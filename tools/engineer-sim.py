#!/usr/bin/env python3
"""engineer-sim: run the whole MiniMax-engineer pipeline against a SANDBOX repo (a tiny python project with an injected bug).
No game, no C#, never the real tree. The sandbox lives in a temp dir; the model works in an isolated workspace copy, the diff is
applied to a COPY of the sandbox, and the result is verified by running the sandbox tests.

  python tools/engineer-sim.py --mock          scripted model: deterministic and offline (this is what the unit tests drive)
  python tools/engineer-sim.py                 the REAL MiniMax-M3 (key from K:\\private\\.env, 8000 max tokens, 90 s timeout, retry once)
  python tools/engineer-sim.py --crlf-tabs     same, but the sandbox files use TAB indentation + CRLF like the real src/Bot.cs
                                               (combine with --mock for the scripted variant)

Also exports make_sandbox / PyRunner / ScriptedChat / TASK, which tests/test_mm_engineer.py reuses.
"""
import argparse
import json
import os
import re
import shutil
import sys
import tempfile
import time
from pathlib import Path

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import mm_engineer as me  # noqa: E402

PICKER = '''"""Build-site picker (sandbox twin of the bot's build picker)."""
import math


def dist(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])


def pick_next(hero, sites, blocked):
    """Return the nearest build site the hero can actually reach, or None.

    sites   - list of {"id": str, "pos": (x, z)}
    blocked - set of site ids the hero cannot reach (pinned on colliders)
    """
    best = None
    best_d = None
    for site in sites:
        d = dist(hero, site["pos"])
        if best is None or d < best_d:
            best = site
            best_d = d
    return best


def pick_many(hero, sites, blocked, n):
    """Return up to n reachable sites, nearest first."""
    out = []
    remaining = list(sites)
    while remaining and len(out) < n:
        best = None
        best_d = None
        for site in remaining:
            d = dist(hero, site["pos"])
            if best is None or d < best_d:
                best = site
                best_d = d
        remaining.remove(best)
        if best["id"] in blocked:
            continue
        out.append(best)
    return out
'''

TEST_PICKER = '''import os
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "src"))
import picker  # noqa: E402

SITES = [{"id": "a", "pos": (1, 0)}, {"id": "b", "pos": (5, 0)}, {"id": "c", "pos": (9, 0)}]
HERO = (0, 0)


class PickerTests(unittest.TestCase):
    def test_nearest_site_wins(self):
        self.assertEqual(picker.pick_next(HERO, SITES, set())["id"], "a")

    def test_no_sites(self):
        self.assertIsNone(picker.pick_next(HERO, [], set()))

    def test_skips_blocked_site(self):
        self.assertEqual(picker.pick_next(HERO, SITES, {"a"})["id"], "b")

    def test_all_blocked_returns_none(self):
        self.assertIsNone(picker.pick_next(HERO, SITES, {"a", "b", "c"}))

    def test_pick_many_skips_blocked(self):
        self.assertEqual([s["id"] for s in picker.pick_many(HERO, SITES, {"b"}, 5)], ["a", "c"])

    def test_pick_many_limit(self):
        self.assertEqual(len(picker.pick_many(HERO, SITES, set(), 2)), 2)


if __name__ == "__main__":
    unittest.main()
'''

LINT_PS1 = """# sandbox stand-in for tools/bot-lint.ps1 - the engineer reads the cheat patterns from here
$cheatCalls = @(
    @{ rx = 'pm\\.TeleportTo\\(';            name = 'PlayerMovement.TeleportTo (movement cheat)' },
    @{ rx = 'Hp\\.TakeDamage\\(';            name = 'Hp.TakeDamage (damage injection)' }
)
"""

NOTES = """# Sandbox notes

`picker.pick_next` chooses the next build site for the hero. `blocked` holds the ids of sites the hero is known
to be unable to reach (it gets pinned on a collider on the way). The picker must never hand out a blocked site.
"""

HELPER = '''"""sandbox helper script"""


def slug(text):
    return "-".join(text.lower().split())
'''

SANDBOX_FILES = {
    "src/picker.py": PICKER,
    "tests/test_picker.py": TEST_PICKER,
    "tools/bot-lint.ps1": LINT_PS1,
    "tools/helper.py": HELPER,
    "docs/NOTES.md": NOTES,
}

TASK = {
    "id": "E0003", "t": 1790914690.9, "status": "queued", "priority": "urgent", "incidents": ["H0003"],
    "title": "BuildPicker repicks sites the hero cannot reach (castle Main Collider / Boundaries pin)",
    "file": "src/Bot.cs", "function": "BuildPicker.PickNext",
    "evidence": "H0003 hotspot 6 pins on obj:Main Collider at (8.6,15.0); build target 31.7,18.9 dist 23.4m; still_with_goal_pct_60s=0; "
                "bld_blocked=10/39; 5007g banked with 0 being built; same family as proposal 'picker selects targets the hero cannot reach'",
    "fix": "After PickNext, check that the site is not in the blocked list (sites the hero cannot reach); if it is, skip it and pick the next nearest "
           "reachable site; never hand out a blocked site.",
}

SANDBOX_NOTES = ("this repository is a tiny PYTHON sandbox (src/*.py, tests/test_*.py, tools/, docs/), not the real C# project: build = a syntax check, "
                 "test = python -m unittest plus a small lint. The task text was written for the C# bot - map it onto this code (the real names differ).")


def to_tabs(text):
    """4-space indentation -> tabs (the real C# sources indent with tabs)."""
    out = []
    for line in text.split("\n"):
        n = len(line) - len(line.lstrip(" "))
        out.append("\t" * (n // 4) + line[n:])
    return "\n".join(out)


def make_sandbox(root, crlf_tabs=False):
    """Write the sandbox repo under root and return it. crlf_tabs=True writes the python files with TAB indentation and CRLF line endings,
    like the real src/Bot.cs - the case where exact-text matching is hardest for a model."""
    root = Path(root)
    for rel, text in SANDBOX_FILES.items():
        p = root / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        if crlf_tabs and rel.endswith(".py"):
            text = to_tabs(text).replace("\n", "\r\n")
        p.write_bytes(text.encode("utf-8"))
    return root


def write_queue(agent_dir, tasks):
    agent = Path(agent_dir)
    agent.mkdir(parents=True, exist_ok=True)
    with open(agent / "engineer-queue.jsonl", "w", encoding="utf-8") as f:
        for t in tasks:
            f.write(json.dumps(t) + "\n")


class PyRunner:
    """Runner for the sandbox: build = syntax check of src/ and tools/ python files, test = python -m unittest + a one-rule lint.
    Same result dicts as mm_engineer.Runner. `fail_build_roots` lets a test make the build fail for one specific tree."""

    def __init__(self, python=None):
        self.python = python or sys.executable
        self.build_calls, self.test_calls = [], []
        self.fail_build_roots = set()

    def build(self, root, out_dir=None, timeout=None):
        root = Path(root)
        self.build_calls.append(str(root))
        if str(root) in self.fail_build_roots:
            return {"ok": False, "errors": ["injected build failure for %s" % root], "seconds": 0.0, "error": ""}
        errors = []
        for sub in ("src", "tools"):
            for p in sorted((root / sub).rglob("*.py")) if (root / sub).exists() else []:
                try:
                    compile(p.read_bytes(), str(p), "exec", dont_inherit=True)
                except SyntaxError as ex:
                    errors.append("%s(%s,%s): error SyntaxError: %s" % (p.relative_to(root).as_posix(), ex.lineno, ex.offset, ex.msg))
        return {"ok": not errors, "errors": errors, "seconds": 0.05, "error": ""}

    def test(self, root, timeout=None):
        root = Path(root)
        self.test_calls.append(str(root))
        env = dict(os.environ, PYTHONDONTWRITEBYTECODE="1", PYTHONIOENCODING="utf-8")
        rc, out, to = me.run_cmd([self.python, "-m", "unittest", "discover", "-s", "tests", "-p", "test_*.py"], cwd=root, timeout=timeout or 120, env=env)
        out = out.replace("\r\n", "\n")
        failures, details = [], {}
        for block in re.split(r"^={70}$", out, flags=re.M)[1:]:
            block = re.split(r"^-{70}\nRan \d+ tests?", block, flags=re.M)[0]            # the last block also carries the run summary
            m = re.match(r"\s*(FAIL|ERROR): (\S+) \(([^)]*)\)", block)
            if m:
                fid = "unittest: " + m.group(3)
                failures.append(fid)
                last = [l for l in block.strip().splitlines() if l.strip() and not l.startswith(("-", "+", "?"))]
                details[fid] = (last[-1] if last else "")[:200]
        ran = re.search(r"Ran (\d+) tests?", out)
        n = int(ran.group(1)) if ran else 0
        lint = []
        for p in sorted((root / "src").rglob("*.py")) if (root / "src").exists() else []:
            if "time.time()" in p.read_text(encoding="utf-8", errors="replace"):
                lint.append("lint: no-wallclock")
                break
        for f in lint:
            failures.append(f)
            details[f] = "src uses time.time() (use a monotonic/unscaled clock)"
        err = "unittest timed out" if to else ""
        return {"ok": not failures and not err, "passed": max(0, n - len([f for f in failures if f.startswith("unittest")])), "failed": len(failures), "failures": failures,
                "details": details, "lint_fails": lint, "lint_warns": [], "error": err, "seconds": 0.3}


class ScriptedChat:
    """Deterministic stand-in for mm_chat. Each script entry: a dict (-> JSON), a str (sent raw), an Exception (raised) or a callable(messages)->entry."""

    def __init__(self, replies, tokens=600, clock=None, advance=0.0):
        self.replies = list(replies)
        self.calls = []
        self.tokens = tokens
        self.clock = clock
        self.advance = advance

    def __call__(self, messages, max_tokens=3000):
        self.calls.append({"messages": [dict(m) for m in messages], "max_tokens": max_tokens})
        if self.clock is not None:
            self.clock.t += self.advance
        if not self.replies:
            raise RuntimeError("scripted model: script exhausted")
        r = self.replies.pop(0)
        if callable(r):
            r = r(messages)
        if isinstance(r, Exception):
            raise r
        return (r if isinstance(r, str) else json.dumps(r)), {"total_tokens": self.tokens}


FIX_OLD = '    for site in sites:\n        d = dist(hero, site["pos"])\n        if best is None or d < best_d:'
FIX_NEW = '    for site in sites:\n        if site["id"] in blocked:\n            continue\n        d = dist(hero, site["pos"])\n        if best is None or d < best_d:'


def mock_script(crlf_tabs=False):
    """ls -> grep -> read -> WRONG edit (non-unique old text, rejected with a count) -> correct edit -> build -> test -> finish."""
    old, new = (to_tabs(FIX_OLD), to_tabs(FIX_NEW)) if crlf_tabs else (FIX_OLD, FIX_NEW)
    return [
        {"action": "ls", "path": "src"},
        {"action": "grep", "pattern": "def pick_next", "glob": "src/*.py"},
        {"action": "read", "path": "src/picker.py", "start": 1, "end": 40},
        {"action": "edit", "path": "src/picker.py", "old": "best = site", "new": "best = site  # nearest so far"},
        {"action": "edit", "path": "src/picker.py", "old": old, "new": new},
        {"action": "build"},
        {"action": "test"},
        {"action": "finish", "summary": "pick_next now skips sites in the blocked set, so the hero is never sent to an unreachable site."},
    ]


def sandbox_cfg(**over):
    cfg = {"project_notes": SANDBOX_NOTES, "mode": "semi", "min_gap_s": 0, "keep_workspaces": 4}
    cfg.update(over)
    return cfg


def run_sim(mock, keep=False, max_steps=None, wall=None, out=print, crlf_tabs=False):
    tmp = Path(tempfile.mkdtemp(prefix="engineer-sim-"))
    repo, real, agent = make_sandbox(tmp / "repo", crlf_tabs=crlf_tabs), tmp / "real", tmp / "agent"
    shutil.copytree(repo, real)
    write_queue(agent, [TASK])
    chat = ScriptedChat(mock_script(crlf_tabs)) if mock else me.make_minimax_chat(timeout=90, retries=1)
    over = {}
    if max_steps:
        over["max_steps"] = max_steps
    if wall:
        over["wall_timeout_s"] = wall
    runner = PyRunner()
    eng = me.Engineer(str(repo), str(agent), chat, cfg=sandbox_cfg(**over), runner=runner, log=lambda m: out("  " + m), sleep=lambda s: None if mock else time.sleep(s))
    out("sandbox: %s" % tmp)
    out("running task %s with the %s model ..." % (TASK["id"], "SCRIPTED" if mock else "REAL MiniMax"))
    t0 = time.time()
    res = eng.run_task(TASK["id"], progress_cb=lambda i: out("  [%s] step %d/%d %s %s tokens=%d t=%.0fs" % (i["op"], i["step"], i["max_steps"], i["phase"], i.get("action") or "", i["tokens"], i["elapsed_s"])))
    wall_s = time.time() - t0
    full = eng.queue()[0]
    out("")
    out("=== RESULT: status=%s steps=%s tokens=%s wall=%.0fs" % (full["status"], full.get("steps"), full.get("tokens"), wall_s))
    if full.get("error"):
        out("error: %s" % full["error"])
    if full.get("summary"):
        out("model summary: %s" % full["summary"])
    out("gates: %s" % json.dumps({k: (v.get("ok") if isinstance(v, dict) else v) for k, v in (full.get("gates") or {}).items()}))
    # what the model did, from the transcript
    log = eng.log_tail(TASK["id"], 200)
    refused = [r for r in log if "ERROR:" in str(r.get("result", ""))]
    invalid = [r for r in log if r.get("action") == "invalid"]
    gate_refusals = [r for r in log if "FINISH REFUSED" in str(r.get("result", ""))]
    out("transcript: %d steps; %d refused actions, %d invalid replies, %d refused finishes" % (len([r for r in log if "n" in r and r.get("action") not in ("model-error",)]), len(refused), len(invalid), len(gate_refusals)))
    for r in log:
        if r.get("action") in ("model-error",):
            out("  step %s: MODEL ERROR %s" % (r.get("n"), r.get("error")))
        elif r.get("action") == "invalid":
            out("  step %s: INVALID reply (%s): %s" % (r.get("n"), r.get("error"), str(r.get("reply", ""))[:160].replace("\n", " ")))
        else:
            out("  step %s: %s %s -> %s" % (r.get("n"), r.get("action"), json.dumps(r.get("args"))[:150], str(r.get("result", "")).split("\n", 2)[1 if "\n" in str(r.get("result", "")) else 0][:130]))
    verified = None
    if full["status"] == "patched":
        out("")
        out("--- diff ---")
        out(eng.diff_text(TASK["id"]).rstrip())
        out("--- applying to a COPY of the sandbox (the 'real tree') ---")
        eng2 = me.Engineer(str(real), str(agent), chat, cfg=sandbox_cfg(), runner=runner, log=lambda m: out("  " + m))
        ap = eng2.apply_patch(TASK["id"])
        out("apply: %s" % json.dumps({k: v for k, v in ap.items() if k != "restore"}))
        tr = runner.test(real)
        out("tests in the applied tree: passed=%s failures=%s" % (tr["passed"], tr["failures"]))
        verified = ap.get("ok") and tr["ok"]
        out("BUG FIXED AND VERIFIED: %s" % bool(verified))
    out("")
    out("(sandbox kept at %s)" % tmp if keep else "(sandbox removed)")
    if not keep:
        me.rmtree_force(tmp)
    return {"status": full["status"], "steps": full.get("steps"), "tokens": full.get("tokens"), "verified": bool(verified), "wall_s": wall_s}


def main(argv=None):
    ap = argparse.ArgumentParser(description="Run the MiniMax engineer against the sandbox repo.")
    ap.add_argument("--mock", action="store_true", help="use the scripted model instead of the real MiniMax")
    ap.add_argument("--keep", action="store_true", help="keep the temp sandbox/agent dirs")
    ap.add_argument("--crlf-tabs", action="store_true", help="sandbox python files with TAB indentation and CRLF endings (like the real Bot.cs)")
    ap.add_argument("--max-steps", type=int, default=0)
    ap.add_argument("--wall", type=int, default=0, help="wall-clock limit in seconds (default: the engineer's 14 min)")
    a = ap.parse_args(argv)
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    r = run_sim(a.mock, keep=a.keep, max_steps=a.max_steps or None, wall=a.wall or None, crlf_tabs=a.crlf_tabs)
    return 0 if r["status"] == "patched" and r["verified"] else 1


if __name__ == "__main__":
    sys.exit(main())
