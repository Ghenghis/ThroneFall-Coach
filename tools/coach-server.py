#!/usr/bin/env python3
"""Thronefall coach chat bridge — talk to the bot's Grandmaster.

Local web UI: chat + mic (browser STT) + TTS replies + live game feed +
annotated screenshots (draw arrows -> sent to a local vision model).

Command path: user text (or the model's own JSON block) -> translates to
the coach override schema -> agent/coach-commands.json -> the plugin
applies it within ~4 s.

Endpoints:
  GET  /            chat UI
  GET  /state       live bot digest (latest tick + coach fields)
  GET  /live.png    current game frame (plugin writes it every ~2 s)
  GET  /history     chatlog tail
  POST /chat        {message, image?} -> LLM reply (+ maybe a command)

Usage: python tools/coach-server.py [--port 8099]
Env:  COACH_LLM_URL, COACH_LLM_MODEL, COACH_VISION_MODEL, COACH_LLM_KEY
"""
import base64, json, os, sys, time, urllib.request, urllib.error, urllib.parse, pathlib, glob
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

ROOT = pathlib.Path(__file__).resolve().parent.parent
AGENT = pathlib.Path(os.environ.get(
    "THRONEFALL_AGENT",
    r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"))
LLM_URL = os.environ.get("COACH_LLM_URL",
    "http://127.0.0.1:1234/v1/chat/completions")
LLM_MODEL = os.environ.get("COACH_LLM_MODEL", "kat-coder-v2.5-dev-apex")
VISION_MODEL = os.environ.get("COACH_VISION_MODEL", "qwen3-vl-2b-thinking-abliterated")
LLM_KEY = os.environ.get("COACH_LLM_KEY", "")
CHATLOG = AGENT / "chatlog.jsonl"
CMDFILE = AGENT / "coach-commands.json"
MMWATCH = AGENT / "mmwatch.jsonl"
_live_cache = {"b": None, "ts": 0}
PORT = 8099
if "--port" in sys.argv:
    _pi = sys.argv.index("--port") + 1
    if _pi >= len(sys.argv):
        raise SystemExit("usage: --port <number>")
    PORT = int(sys.argv[_pi])

# ── MiniMax live-watch loop ──────────────────────────────────────────────
# MiniMax observes telemetry every MM_WATCH_SECS, proposes ONE bounded
# steering patch, we validate+clamp it, write coach-commands.json, and the
# plugin applies within ~4 s. Everything is logged with proof.
MM_URL = "https://api.minimax.io/v1/chat/completions"
MM_MODEL = os.environ.get("MINIMAX_MODEL", "MiniMax-M3")
WATCH_EVERY = float(os.environ.get("MM_WATCH_SECS", "30"))
MM_ENABLED = os.environ.get("MM_WATCH", "1") != "0"

def mm_key():
    for p in (r"K:\private\.env", r"K:\private\minimax-m3-ultra.env"):
        try:
            for ln in pathlib.Path(p).read_text().splitlines():
                ln = ln.strip()
                if ln.startswith(("MINIMAX_API_KEY=", "minimax=")) and "=" in ln:
                    return ln.split("=", 1)[1].strip()
        except OSError:
            continue
    return os.environ.get("MINIMAX_API_KEY", "")

def mm_chat(messages, max_tokens=3000):
    key = mm_key()
    if not key:
        raise RuntimeError("MINIMAX_API_KEY missing")
    body = {"model": MM_MODEL, "stream": False, "max_tokens": max_tokens,
            "temperature": 0.3, "reasoning_split": True, "messages": messages}
    req = urllib.request.Request(MM_URL, data=json.dumps(body).encode(),
        headers={"Authorization": "Bearer " + key,
                 "Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=90) as r:
        out = json.loads(r.read())
    # M3 with reasoning_split may return reasoning-only turns or an error
    # body without choices — surface what actually came back, don't KeyError.
    try:
        msg = out["choices"][0]["message"]
        content = msg.get("content") or ""
        if not content.strip():
            # NEVER fall back to reasoning_content — it carries the model's
            # rejected/considered options; feeding it into the patch parser
            # applied half-formed thoughts as live commands (audit).
            raise RuntimeError(f"empty MiniMax reply: {str(out)[:200]}")
        return content, out.get("usage", {})
    except (KeyError, IndexError, TypeError):
        raise RuntimeError(f"MiniMax bad response: {str(out)[:200]}")

MM_SYS = """You are MiniMax Watch — the live steering advisor AND bug reporter
for a Thronefall autopilot. You see real telemetry and may adjust the bot's
STRATEGY KNOBS ONLY (never cheats, never code). Reply with ONLY a JSON
object, no prose outside it:
{"squad_size":0,"reserve_size":0,"escort_size":0,"army_target":0,
 "build_focus":"military|income|defense|balanced",
 "hero_posture":"builder|fighter","night_call":false,
 "note":"<one sentence: what you changed and why>",
 "proposal":{"bug":"<short title>","evidence":"<numbers from the digest>",
             "fix":"<concrete code-level fix: file/function/threshold>"}}
Rules: use 0/false for "no change"; squad 1-8, reserve 0-10, escort 0-6,
army_target is a FLOOR 0-60 (the bot's own target never goes below it, and
changes under 10 are ignored); build_focus must be one of the listed words;
only change what the telemetry justifies. If nothing needs changing return {}.
hero_posture: keep "builder" — the army fights, the hero builds. "fighter"
is only honoured during a RED ALERT and is otherwise forced back to builder.
To RELEASE a previously-set override back to the bot's built-in defaults,
send {"clear":true} — do NOT send zeros to mean "back to default".
EVENT GLOSSARY (read these correctly): stuck / quick-sidestep = the HERO'S
MOVEMENT pin detector (he stopped making progress walking - NOT combat strikes);
pin-park = a build slot abandoned because the hero was pinned walking to it;
approach-timeout = same build target 18 s without payment; door-park = a squad
door anchor proven unreachable; gps-plan/gps-cross/gps-fail = the wall-gate
escape navigator (cross = success); rescan-slots = forgiving parked slots;
slot-abandon = stood at a slot 10 s without paying; anomaly = log-spam guard.
KNOBS CANNOT FIX CODE BUGS. When the ENGINEERING DIGEST shows a pattern that
no knob can fix (hero pinned at walls, repeated stuck strikes, a build that
is retried and abandoned, a popup that never closes, gps-fail, idle with gold),
add a "proposal" with the evidence and the code-level fix you recommend. The
engineer reads proposals.jsonl every pass and ships the fixes; do not repeat
a proposal that is already in RECENT PROPOSALS.
"""

MMHB = AGENT / "mm-heartbeat.json"
PROPOSALS = AGENT / "proposals.jsonl"
_hb = {"cycles": 0, "ok": 0, "errors": 0, "applied": 0, "not_applied": 0,
       "proposals": 0, "last_ok": 0, "last_error": "", "live": False}

def hb(**kw):
    """Heartbeat the engineer + /health can read: loop alive, last good call,
    last error, apply proof counts. Written every cycle, even when idle."""
    _hb.update(kw)
    _hb["t"] = round(time.time(), 1)
    try:
        tmp = MMHB.with_suffix(".tmp")
        tmp.write_text(json.dumps(_hb))
        os.replace(tmp, MMHB)
    except OSError:
        pass

_eng_cache = {"t": 0, "v": {}}
def eng_digest():
    """What the knob-only prompt was blind to: pin/stuck/gps/rescan/door-park
    event counts of the live run, the nav status, task waste ratio and the
    game log's warning counts. Cached 45 s (it reads several tails)."""
    if time.time() - _eng_cache["t"] < 45 and _eng_cache["v"]:
        return _eng_cache["v"]
    d = {}
    try:
        run = latest_run()
        if run:
            ev = tail_lines(run / "events.jsonl", 600, cap=200000)
            cnt = {}
            for ln in ev:
                try: n = json.loads(ln).get("note", "")
                except Exception: continue
                n = n.split(":")[0]
                cnt[n] = cnt.get(n, 0) + 1
            keep = ("stuck", "quick-sidestep", "pin-park", "approach-timeout", "door-park",
                    "gps-plan", "gps-cross", "gps-fail", "rescan-slots", "slot-abandon",
                    "task-miss", "frame-escape", "match-escape", "choice-cancel",
                    "choice-coroutine-wedge", "breach-response", "inter-vacuum",
                    "aim-flap-blocked", "anomaly", "switch-night", "idle-night-call")
            d["events_last600"] = {k: v for k, v in cnt.items() if k in keep}
            tl = tail_lines(run / "ticks.jsonl", 1)
            if tl:
                t = json.loads(tl[-1])
                d["tick"] = {k: t.get(k) for k in ("nav", "bld", "bldb", "bn", "bd", "at", "mwa",
                             "drc", "drn", "drp", "drcl", "udu", "free", "ally", "gold", "dtl")}
    except Exception as ex:
        d["events_err"] = str(ex)[:80]
    try:
        use = waste = n = 0
        for ln in tail_lines(AGENT / "tasks.jsonl", 150, cap=120000):
            try: t = json.loads(ln)
            except Exception: continue
            use += t.get("use_s", 0) or 0; waste += t.get("waste_s", 0) or 0; n += 1
        d["tasks_last150"] = {"n": n, "useful_s": round(use), "waste_s": round(waste),
                              "useful_pct": round(100 * use / max(1, use + waste))}
    except Exception:
        pass
    try:
        lg = tail_bytes(pathlib.Path(r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log"), 80000)
        d["gamelog_last80KB"] = {k: lg.count(k) for k in
            ("stuck strike", "anomaly", "[gps] failed", "[gps] crossed", "Exception", "match-escape")}
    except Exception:
        pass
    _eng_cache.update(t=time.time(), v=d)
    return d

def recent_proposals(n=6):
    out = []
    for ln in tail_lines(PROPOSALS, n, cap=40000):
        try: out.append(json.loads(ln).get("bug", ""))
        except Exception: pass
    return out

def record_proposal(p, st):
    """Append a MiniMax bug proposal for the engineer; dedupe by title."""
    if not isinstance(p, dict) or not str(p.get("bug", "")).strip():
        return False
    bug = str(p["bug"])[:120]
    if bug.lower() in [x.lower() for x in recent_proposals(30)]:
        return False
    rec = {"t": round(time.time(), 1), "run": st.get("run"), "bug": bug,
           "evidence": str(p.get("evidence", ""))[:600], "fix": str(p.get("fix", ""))[:600],
           "status": "open"}
    try:
        with open(PROPOSALS, "a", encoding="utf-8") as f:
            f.write(json.dumps(rec) + "\n")
    except OSError:
        return False
    hhmm = time.strftime("%H:%M")
    append_log("mm", f"[{hhmm} mm-proposal] {bug} :: {rec['fix'][:200]}")
    _hb["proposals"] += 1
    return True

_last_at = {"v": 0}
def guard_patch(patch, st):
    """Server-side guards the model can't talk its way around: the hero stays
    a builder outside red alert, and army_target only moves in steps >= 10
    (it flip-flopped 15->35->15->20->25 every cycle, dragging the bot's own
    lookahead target around)."""
    if not patch:
        return patch
    if patch.get("hero_posture") == "fighter" and not st.get("red"):
        patch["hero_posture"] = "builder"
    if "army_target" in patch:
        if _last_at["v"] and abs(patch["army_target"] - _last_at["v"]) < 10:
            patch.pop("army_target")
        else:
            _last_at["v"] = patch["army_target"]
    return patch if any(k != "note" for k in patch) else None

# Strict validation — only these keys, clamped ranges, enum values only.
MM_FIELDS = {
    "squad_size":   (int,  (0, 8)),
    "reserve_size": (int,  (0, 10)),
    "escort_size":  (int,  (0, 6)),
    "army_target":  (int,  (0, 60)),
    "build_focus":  (str,  {"military", "income", "defense", "balanced"}),
    "hero_posture": (str,  {"builder", "fighter"}),
    "night_call":   (bool, None),
    "clear":        (bool, None),   # true = release all overrides to defaults
    "note":         (str,  160),
}
def validate_patch(obj):
    if not isinstance(obj, dict):
        return None
    out = {}
    # clear=true expands to an all-zeros patch — the plugin treats 0 as
    # "use built-in default", so this is how the model RELEASES an
    # override (0 alone is stripped as "no change" below).
    if obj.get("clear") is True:
        return {"squad_size": 0, "reserve_size": 0, "escort_size": 0,
                "army_target": 0, "note": "cleared overrides"}
    for k, spec in MM_FIELDS.items():
        if k not in obj: continue
        t, lim = spec
        v = obj[k]
        if t is int:
            if isinstance(v, bool) or not isinstance(v, (int, float)):
                continue
            v = max(lim[0], min(lim[1], int(v)))
            if v == 0: continue          # 0 = no change
        elif t is str:
            if not isinstance(v, str): continue
            if isinstance(lim, set):
                if v not in lim: continue
            else:
                v = v[:lim]
        elif t is bool:
            v = v is True
            if not v: continue
        out[k] = v
    return out or None

def _watch_log(entry):
    try:
        if MMWATCH.exists() and MMWATCH.stat().st_size > 8_000_000:
            os.replace(MMWATCH, MMWATCH.with_suffix(".old"))   # rolling cap
        with open(MMWATCH, "a", encoding="utf-8") as f:
            f.write(json.dumps(entry) + "\n")
    except Exception:
        pass
    # mirror into the chat stream so the user sees steering live —
    # timestamped so stale advisories are visibly old, never confused
    # with the live header numbers. FAILURES mirror too — silence = fake.
    hhmm = time.strftime("%H:%M", time.localtime(entry.get("t", time.time())))
    if entry.get("error"):
        append_log("mm", f"[{hhmm} mm-watch ERROR] {entry['error'][:200]}")
        return
    if entry.get("kind") == "proof":
        tag = "applied" if entry.get("applied") else "NOT APPLIED"
        append_log("mm", f"[{hhmm} mm-watch {tag}] {entry.get('patch')} :: {entry.get('note','')}")
        if not entry.get("applied"):
            append_log("mm", f"[{hhmm} mm-watch BROKEN] wrote command but no '[coach] user-cmd' in game log — is the plugin polling?")
        return
    tag = "rejected" if not entry.get("patch") else "advised"
    body = entry.get('patch') or entry.get('raw', '')[:140]
    append_log("mm", f"[{hhmm} mm-watch {tag}] {body} :: {entry.get('note','')}")

def mm_watch_loop():
    """Continuously: observe -> MiniMax -> validate -> command -> proof."""
    mm_watch_loop.last_patch = ""
    mm_watch_loop.last_raw = ""
    last_sig = ""
    last_run = None
    while True:
        try:
            st = live_state()
            if not st.get("live"):
                hb(live=False)
                time.sleep(8); continue
            _hb["live"] = True
            # New run => the plugin-side ResetRun() cleared all overrides —
            # re-issue steering instead of deduping it away forever.
            if st.get("run") != last_run:
                last_run = st.get("run")
                mm_watch_loop.last_patch = ""
                last_sig = ""
            # Skip mid-call spam: re-steer on stable signals only — `ally`
            # fluctuated every tick so sig==last_sig almost never deduped.
            sig = (st.get("mode"), st.get("night"), st.get("wave"),
                   st.get("red"), st.get("bld", 0))
            urgent = st.get("red") or (st.get("night") and st.get("doors_cov", 0) == 0)
            # Audit alerts make it urgent too — MiniMax stays busy while
            # the bot fails checklist items.
            if not urgent:
                try:
                    af = AGENT / "audit.json"
                    # Stale audit.json used to keep urgent=True forever —
                    # a dead plugin's last crit made MiniMax burn tokens every
                    # WATCH_EVER cycle indefinitely. Freshness-gate it.
                    if af.exists() and time.time() - af.stat().st_mtime < 15:
                        au = json.loads(af.read_text(errors="replace"))
                        urgent = any(x.get("sev") == "crit"
                                     for x in audit_alerts(au))
                except Exception:
                    pass
            if sig == last_sig and not urgent:
                time.sleep(WATCH_EVERY); continue
            # DON'T commit last_sig until the call succeeds — a transient
            # MiniMax error used to poison the dedupe and silence steering
            # until telemetry changed (sometimes never on a stuck run).
            m = metrics()
            audit = {}
            af = AGENT / "audit.json"
            if af.exists():
                try: audit = json.loads(af.read_text(errors="replace"))
                except Exception: pass
            # Full-context prompt — the model has ~262k tokens; the old
            # digest clipped doors/checklist/alerts to 5 items and blinded
            # it to per-door detail. Feed everything real instead.
            track_activity(audit.get("mode"), audit.get("t"))
            door_detail = [{"line": l, "units": u}
                           for l, u in zip(audit.get("door_lines", []),
                                           audit.get("door_units", []))]
            prompt = (
                "FULL AUDIT SNAPSHOT: " + json.dumps(
                    {k: audit.get(k) for k in
                     ("t", "mode", "mode_since", "gold", "ally", "free",
                      "foes", "night", "wave", "wave_total", "red",
                      "breaches", "bld", "cur_build", "army_target",
                      "cat_built", "open_order", "build_stale_s")}) +
                "\nDOOR POSTS (per-corridor units): " + json.dumps(door_detail) +
                "\nFULL PLAYBOOK CHECKLIST: " + json.dumps(
                    audit.get("checklist", [])) +
                "\nACTIVITY TIMELINE: " + json.dumps(_activity[:6]) +
                "\nALERTS (all): " + json.dumps(audit_alerts(audit)) +
                "\nGRADES + INPUTS: " + json.dumps(m.get("grades", {})) +
                "\nGRADE FORMULAS: " + json.dumps(m.get("grade_src", {})) +
                "\nWEAKNESSES: " + json.dumps(m.get("weaknesses", [])[:5]) +
                "\nBREACH-PRONE DOORS: " + json.dumps(m.get("breach_doors", [])) +
                "\nNET vs BOT: " + json.dumps(m.get("learning", {}).get("net", {})) +
                "\nENGINEERING DIGEST (pins/stuck/gps/rescan/waste - knobs cannot fix these, propose code fixes): " +
                json.dumps(eng_digest()) +
                "\nRECENT PROPOSALS (do not repeat): " + json.dumps(recent_proposals()) +
                "\nCorrect the FAILED checklist items. Respond JSON only.")
            reply, usage = mm_chat(
                [{"role": "system", "content": MM_SYS},
                 {"role": "user", "content": prompt}],
                # The digest prompt makes M3 reason long — 3000 ended every
                # call as finish_reason=length with EMPTY content (a wasted
                # cycle). 8000 leaves room for reasoning + the JSON patch.
                max_tokens=8000)
            # extract first {...} block — parse failure must NOT commit
            # last_sig (a malformed reply would dedupe future calls forever)
            i0, i1 = reply.find("{"), reply.rfind("}")
            robj = json.loads(reply[i0:i1 + 1]) if 0 <= i0 < i1 else None
            if isinstance(robj, dict):
                record_proposal(robj.get("proposal"), st)
            patch = guard_patch(validate_patch(robj), st)
            last_sig = sig   # commit ONLY after call+parse both succeed
            hb(ok=_hb["ok"] + 1, cycles=_hb["cycles"] + 1, last_ok=round(time.time(), 1))
            entry = {"t": round(time.time(), 1), "state": st, "usage": usage,
                     "raw": reply[:300], "patch": patch, "note": ""}
            if patch:
                note = patch.pop("note", "")
                # night_call maps onto posture/trigger only — the bot still
                # gates it through CanSwitch; a flag here is advisory.
                if patch.pop("night_call", False):
                    patch["hero_posture"] = patch.get("hero_posture", "builder")
                # Dedupe: don't re-write an identical command — the plugin
                # polls by content-hash so a same-body file is a no-op anyway,
                # but skipping it keeps the feed readable.
                sig = json.dumps(patch, sort_keys=True)
                if sig != mm_watch_loop.last_patch:
                    if patch:
                        # Proof must count NEW applies — an old "[coach]
                        # user-cmd ->" marker in the tail made every later
                        # patch a false-positive (audit finding).
                        glog = pathlib.Path(
                            r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log")
                        try:
                            before = glog.stat().st_size
                        except Exception:
                            before = -1
                        try:
                            # Nonce: if this patch FAILS to apply, the retry
                            # would write byte-identical content which the
                            # plugin content-dedupes — 'applied' could never
                            # become true (infinite BROKEN loop). A fresh
                            # timestamped note makes every write distinct.
                            patch["note"] = f"{note}#{int(time.time())}" \
                                if note else f"#{int(time.time())}"
                            write_cmd(patch)
                        except Exception as ex:
                            # A failed write must NOT commit the dedupe —
                            # identical telemetry should retry next cycle.
                            # But SLEEP first: continue skipped the bottom
                            # sleep and burned MiniMax tokens in a hot loop.
                            last_sig = ""
                            append_log("mm", f"write_cmd failed: {ex}")
                            time.sleep(WATCH_EVERY)
                            continue
                        mm_watch_loop.last_patch = sig   # commit post-write
                        entry["note"] = note
                        _watch_log(entry)
                        time.sleep(6)
                        applied = False
                        try:
                            # Offset proof: read only bytes appended since the
                            # write (the old 40 KB tail-count slid past the
                            # marker on a chatty log -> ~8 % false NOT APPLIED).
                            # A log that rotated/truncated reads from 0.
                            size = glog.stat().st_size
                            start = before if 0 <= before <= size else 0
                            with open(glog, "rb") as fh:
                                fh.seek(start)
                                chunk = fh.read().decode("utf-8", errors="replace")
                            applied = "[coach] user-cmd ->" in chunk
                        except Exception:
                            pass
                        hb(**({"applied": _hb["applied"] + 1} if applied
                              else {"not_applied": _hb["not_applied"] + 1}))
                        entry["applied"] = applied
                        _watch_log({"t": round(time.time(), 1),
                                    "kind": "proof", **entry})
                        if not applied:
                            # Failed apply must not be deduped away — clear
                            # the sig so the next cycle re-issues the same
                            # fix instead of skipping it forever.
                            mm_watch_loop.last_patch = ""
            else:
                # Distinguish the three failure shapes — an EMPTY patch is
                # a different problem (model passed the gate with no fields)
                # than unparseable text or a deduped identical patch.
                entry["note"] = ("empty patch (no fields)" if patch == {}
                                 else "no-change or unparseable")
                if entry.get("raw") and entry["raw"] != mm_watch_loop.last_raw:
                    mm_watch_loop.last_raw = entry["raw"]
                    _watch_log(entry)
                elif not entry.get("raw"):
                    # Model returned nothing parseable at all — say so once
                    # instead of blank '[rejected]' spam.
                    _watch_log({**entry, "raw": "(empty reply)"})
        except urllib.error.HTTPError as ex:
            hb(errors=_hb["errors"] + 1, last_error=f"HTTP {ex.code}")
            _watch_log({"t": round(time.time(), 1),
                        "error": f"MiniMax HTTP {ex.code}: {ex.read()[:160]!r}"})
        except Exception as ex:
            hb(errors=_hb["errors"] + 1, last_error=str(ex)[:120])
            _watch_log({"t": round(time.time(), 1), "error": str(ex)})
        hb()
        time.sleep(WATCH_EVERY)


def health_watch_loop():
    """Ping /health's checks every ~20 s; transitions land in chatlog."""
    while True:
        try:
            health()
        except Exception:
            pass
        time.sleep(20)


SYS = """You are Grandmaster, the live coach wired INTO a Thronefall autopilot.
You see its real telemetry every message. You can ORDER the bot by ending
your reply with a JSON block tagged <cmd>...</cmd> — only when the user
asks for a behavior change or you decide one is needed. Schema:
<cmd>{"squad_size":0,"reserve_size":0,"escort_size":0,"army_target":0,
"build_focus":"military|income|defense|balanced",
"hero_posture":"builder|fighter","note":"<what you told it>"}</cmd>
Use 0 for "no change". The bot posts squads on spawn corridors outside
the walls, keeps a castle reserve, and the hero builds/farms while troops
fight. It does NOT cheat. Keep answers short and concrete."""

def llm(messages, model, max_tokens=700):
    body = {"model": model, "stream": False, "max_tokens": max_tokens,
            "temperature": 0.35, "messages": messages}
    req = urllib.request.Request(LLM_URL, data=json.dumps(body).encode(),
        headers={"Content-Type": "application/json",
                 **({"Authorization": "Bearer " + LLM_KEY} if LLM_KEY else {})})
    with urllib.request.urlopen(req, timeout=120) as r:
        out = json.loads(r.read())
    return out["choices"][0]["message"]["content"], out.get("usage", {})

def latest_run():
    # mtimes, not lexical sort — a lexically-last stale dir ("unknown-…")
    # beat a live "Nordfels-…" run and live_state went dark mid-session.
    runs = glob.glob(str(AGENT / "runs" / "*"))
    if not runs: return None
    try:
        return pathlib.Path(max(runs, key=lambda p: os.path.getmtime(p)))
    except OSError:
        return pathlib.Path(runs[-1])

def tail_bytes(path, cap=65536):
    """Last N BYTES read from END of file — whole-file read_text() of
    LogOutput.log / mmwatch.jsonl in polling loops was MB-scale churn."""
    try:
        size = path.stat().st_size
        with open(path, "rb") as fh:
            fh.seek(max(0, size - cap))
            return fh.read().decode("utf-8", errors="replace")
    except OSError:
        return ""

def tail_lines(path, n, cap=65536):
    """Last N lines read from END of file — unbounded read_text() on the
    whole JSONL was the per-request CPU/RSS climb (audit)."""
    data = tail_bytes(path, cap)
    return [l for l in data.strip().splitlines() if l.strip()][-n:]

def track_activity(mode, t=None):
    """Shared mode-edge timeline — used by /audit AND the watch prompt.
    Previously the watch loop saw activity=[] forever because it was only
    maintained inside the HTTP handler."""
    global _activity
    with _auditlock:
        if not _activity or _activity[-1][1] != mode:
            _activity.append((t, mode))
            _activity = _activity[-12:]
        return list(reversed(_activity))

def live_state():
    st = {"live": False}
    run = latest_run()
    if not run: return st
    ticks = run / "ticks.jsonl"
    if ticks.exists():
        try:
            # Freshness gate: an orphaned old run dir must not steer a dead
            # game — "live" requires the file written within 30 s.
            if time.time() - ticks.stat().st_mtime > 30:
                return st
        except OSError:
            return st
        lines = tail_lines(ticks, 1)
        if lines:
            try:
                last = json.loads(lines[-1])
                st.update({"live": True, "run": run.name, "t": last.get("t"),
                    "mode": last.get("mode"), "gold": last.get("gold"),
                    "foes": last.get("foes"), "night": last.get("night"),
                    "ally": last.get("ally"), "free": last.get("free"),
                    "doors_cov": last.get("drc"), "doors": last.get("drn"),
                    "army_target": last.get("at"), "red": last.get("ra"),
                    "hp": last.get("hp"),
                    # sig fields — they were referenced by mm_watch_loop but
                    # never populated, so wave/bld dedupe was permanently
                    # inert (stale steering across wave transitions).
                    "wave": last.get("wave"), "bld": last.get("bld")})
            except Exception: pass
        notes = run / "notes.jsonl"
        if notes.exists():
            nl = tail_lines(notes, 8)
            out = []
            for x in nl:
                if not x.strip().startswith("{"): continue
                try: out.append(json.loads(x).get("note", "?"))
                except Exception: continue     # torn line can't kill /state or /chat
            st["notes"] = out
    return st

def health():
    """Connectivity truth — every probe returns its real status, no mocks."""
    h = {"checks": []}
    # 1. Plugin audit feed alive?
    af = AGENT / "audit.json"
    if af.exists():
        age = time.time() - af.stat().st_mtime
        h["checks"].append({"name": "plugin feed", "ok": age < 10,
                            "detail": f"audit.json {age:.0f}s old"})
    else:
        h["checks"].append({"name": "plugin feed", "ok": False,
                            "detail": "audit.json missing — plugin DLL not deployed?"})
    # 2. Live frame feed
    lf = AGENT / "live.png"
    if lf.exists():
        age = time.time() - lf.stat().st_mtime
        h["checks"].append({"name": "live frames", "ok": age < 15,
                            "detail": f"live.png {age:.0f}s old"})
    else:
        h["checks"].append({"name": "live frames", "ok": False,
                            "detail": "no live.png — LiveShot off or plugin absent"})
    # 3. Local LLM (LM Studio)
    try:
        # Strip the /chat/completions path properly — rsplit("/chat") on a
        # base URL without it produced a nonsense probe URL.
        base = urllib.parse.urlsplit(LLM_URL)
        models_url = urllib.parse.urlunsplit(
            (base.scheme, base.netloc, "/v1/models", "", ""))
        with urllib.request.urlopen(models_url, timeout=3) as r:
            ok = r.status == 200
        h["checks"].append({"name": "local LLM", "ok": ok,
                            "detail": LLM_MODEL})
    except Exception as ex:
        h["checks"].append({"name": "local LLM", "ok": False,
                            "detail": str(ex)[:80]})
    # 4. MiniMax — last watch entry: was it an error?
    mm_ok, mm_det = True, "no calls yet"
    try:
        for ln in tail_lines(MMWATCH, 30)[::-1]:   # tail-read, not whole file
            e = json.loads(ln)
            if e.get("error"):
                mm_ok, mm_det = False, e["error"][:100]
                break
            if e.get("patch") is not None or e.get("kind") == "proof":
                mm_det = ("applied" if e.get("applied") else "advised") + \
                         f" at {time.strftime('%H:%M', time.localtime(e.get('t',0)))}"
                break
    except FileNotFoundError:
        mm_det = "no watch log yet"
    except Exception:
        pass
    h["checks"].append({"name": "MiniMax", "ok": mm_ok, "detail": mm_det})
    # 5. MiniMax loop heartbeat — the loop itself alive (not just "last call ok")
    try:
        hbj = json.loads(MMHB.read_text())
        age = time.time() - hbj.get("t", 0)
        h["checks"].append({"name": "MiniMax heartbeat", "ok": age < 240,
            "detail": f"{age:.0f}s ago, ok={hbj.get('ok')} err={hbj.get('errors')} "
                      f"applied={hbj.get('applied')}/{hbj.get('not_applied')} props={hbj.get('proposals')}"})
    except Exception:
        h["checks"].append({"name": "MiniMax heartbeat", "ok": False,
                            "detail": "no mm-heartbeat.json (loop not running?)"})
    h["ok"] = all(c["ok"] for c in h["checks"])
    # Edge detector: post link transitions INTO the chat log so a dead
    # link is a red error line, not a silent banner. Locked — /health calls
    # and the watch thread could otherwise interleave and double-post.
    sig = tuple(c["ok"] for c in h["checks"])
    with _healthlock:
        if health.prev_sig is not None and sig != health.prev_sig:
            # Enumerate — index(c) matched by dict equality, which collapses
            # when two checks ever produce identical dicts.
            for i, (c, now) in enumerate(zip(h["checks"], sig)):
                was = health.prev_sig[i] if i < len(health.prev_sig) else True
                hhmm = time.strftime("%H:%M")
                if was and not now:
                    append_log("err", f"[{hhmm} LINK DOWN] {c['name']} — {c['detail']}")
                elif now and not was:
                    append_log("ok", f"[{hhmm} LINK UP] {c['name']} — {c['detail']}")
        health.prev_sig = sig
    return h
health.prev_sig = None

def audit_alerts(a):
    """Derive alerts from the audit dict — the 'not doing its job' flags the
    panel must show. All computed from real plugin telemetry."""
    out = []
    ms = a.get("mode_since", 0)
    if a.get("night") and a.get("doors_cov", 0) == 0 and a.get("doors", 0) > 0:
        out.append({"sev": "crit", "msg": "NIGHT with 0 doors covered — perimeter is open"})
    if a.get("red"):
        out.append({"sev": "crit", "msg": "RED ALERT — enemies inside the building ring"})
    if a.get("ally", 0) < (a.get("army_target") or 20) * 0.3 and a.get("t", 0) > 300:
        out.append({"sev": "warn", "msg": f"army {a.get('ally')} far below target — production stalled"})
    # SpendGold is the normal day build mode and HoldCastle the normal night
    # mode — flagging them as "stuck" fed MiniMax a false diagnosis every
    # cycle ("Bot stuck 104s in SpendGold"). Only a daytime Idle is idle.
    if ms > 90 and a.get("mode") == "Idle" and not a.get("night"):
        out.append({"sev": "warn", "msg": f"idle by day for {ms:.0f}s"})
    cats = a.get("cat_built", {})
    if a.get("t", 0) > 400 and cats.get("wall", 0) == 0:
        out.append({"sev": "warn", "msg": "no walls built yet"})
    if a.get("t", 0) > 300 and cats.get("military", 0) == 0:
        out.append({"sev": "crit", "msg": "NO troop buildings built — army can't grow"})
    if a.get("breaches", 0) > 0:
        out.append({"sev": "info", "msg": f"{a['breaches']} door breach(es) this run"})
    return out

_activity = []           # [(tick_t, mode)] mode-edge timeline, capped 12
_lastcats = {"sum": 0, "since": time.time()}
import threading as _threading
_loglock = _threading.Lock()
_cmdlock = _threading.Lock()
_healthlock = _threading.Lock()   # guards health() edge detection
_auditlock = _threading.Lock()    # guards _activity/_lastcats mutation

def append_log(role, text):
    CHATLOG.parent.mkdir(parents=True, exist_ok=True)
    with _loglock:
        with open(CHATLOG, "a", encoding="utf-8") as f:
            f.write(json.dumps({"t": time.time(), "role": role,
                                "text": text[:8000]}) + "\n")

def write_cmd(cmd):
    """All command-file writes through one lock + atomic tmp+rename — the
    plugin polls this file; a torn JSON used to be skipped silently."""
    with _cmdlock:
        tmp = CMDFILE.with_suffix(".tmp")
        tmp.write_text(json.dumps(cmd))
        os.replace(tmp, CMDFILE)

def extract_cmd(reply):
    i0 = reply.find("<cmd>")
    i1 = reply.find("</cmd>")
    if i0 < 0 or i1 <= i0: return None, reply
    raw = reply[i0 + 5:i1]
    try:
        cmd = json.loads(raw[raw.find("{"):raw.rfind("}") + 1])
        # Validate through the SAME whitelist as MiniMax patches — the chat
        # model's hallucinated keys (or a bogus build_focus string) used to
        # land verbatim in coach-commands.json and apply unchecked.
        cmd = validate_patch(cmd) or {}
        cmd["note"] = cmd.get("note", "") or "user-directed"
        write_cmd(cmd)
        clean = (reply[:i0] + reply[i1 + 6:]).strip()
        return cmd, clean
    except Exception:
        return None, reply

class H(BaseHTTPRequestHandler):
    def log_message(self, *a): pass

    def _send(self, code, body, ct="text/plain"):
        if isinstance(body, str): body = body.encode()
        self.send_response(code)
        self.send_header("Content-Type", ct)
        self.send_header("Content-Length", str(len(body)))
        # localhost-only — a wildcard let ANY website drive /order and
        # /chat on this port from the user's browser.
        self.send_header("Access-Control-Allow-Origin",
                         f"http://127.0.0.1:{PORT}")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        # Global guard — any unexpected exception (TOCTOU file race etc.)
        # used to drop the connection with NO response at all.
        try:
            self._do_GET()
        except Exception as ex:
            try: self._send(500, f"handler error: {ex}")
            except Exception: pass

    def do_POST(self):
        try:
            self._do_POST()
        except Exception as ex:
            try: self._send(500, f"handler error: {ex}")
            except Exception: pass

    def _do_GET(self):
        if self.path == "/" or self.path.startswith("/index"):
            self._send(200, PAGE, "text/html; charset=utf-8")
        elif self.path == "/state":
            self._send(200, json.dumps(live_state()), "application/json")
        elif self.path == "/live.png":
            p = AGENT / "live.png"
            try:
                if p.exists():
                    b = p.read_bytes()
                    _live_cache["b"] = b
                    _live_cache["ts"] = p.stat().st_mtime
                    self._send(200, b, "image/png")
                elif _live_cache.get("b"):
                    self._send(200, _live_cache["b"], "image/png")
                else:
                    self._send(404, "no frame yet")
            except (PermissionError, OSError):
                # plugin mid-write — serve the last good frame, not a broken img
                if _live_cache.get("b"):
                    self._send(200, _live_cache["b"], "image/png")
                else:
                    self._send(404, "no frame yet")
        elif self.path == "/live.json":
            p = AGENT / "live.png"
            ts = p.stat().st_mtime if p.exists() else 0
            self._send(200, json.dumps({"ts": ts}), "application/json")
        elif self.path.startswith("/run?"):
            # run detail: last 12 ticks of one run — powers the sidebar
            # expandable rows (truth, not summaries).
            from urllib.parse import parse_qs
            q = parse_qs(self.path.split("?", 1)[1])
            name = (q.get("name") or [""])[0]
            name = pathlib.Path(name).name          # traversal-safe
            if name in ("", ".", ".."):
                self._send(400, json.dumps({"err": "bad run name"}),
                           "application/json"); return
            tk = AGENT / "runs" / name / "ticks.jsonl"
            out = {"ticks": []}
            if tk.exists():
                lines = tail_lines(tk, 12)
                for ln in lines:
                    try:
                        t = json.loads(ln)
                        out["ticks"].append({"t": t.get("t"), "mode": t.get("mode"),
                            "ally": t.get("ally"), "drc": t.get("drc"),
                            "drn": t.get("drn"), "gold": t.get("gold")})
                    except Exception:
                        pass
            self._send(200, json.dumps(out), "application/json")
        elif self.path == "/health":
            self._send(200, json.dumps(health()), "application/json")
        elif self.path == "/ping":
            # Round-trip proof: write a no-op command, then watch the game
            # log for the plugin's own apply line. Returns the truth.
            out = {"ok": False, "stage": "write"}
            try:
                tag = f"ui-ping-{int(time.time())}"
                log = pathlib.Path(
                    r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log")
                before = tail_bytes(log, 80000).count(
                    "[coach] user-cmd") if log.exists() else 0
                write_cmd({"note": tag})
                out["stage"] = "wait-apply"
                ok = False
                for _ in range(20):          # ~10 s window
                    time.sleep(0.5)
                    if log.exists() and tail_bytes(log, 80000).count(
                            "[coach] user-cmd") > before:
                        ok = True
                        break
                out["ok"] = ok
                out["stage"] = "applied" if ok else "no-apply"
                append_log("err" if not ok else "c",
                           f"[PING {'OK' if ok else 'FAILED'}] command round-trip "
                           f"{'confirmed' if ok else 'not confirmed by game log'}")
            except Exception as ex:
                out["error"] = str(ex)
            self._send(200, json.dumps(out), "application/json")
        elif self.path == "/audit":
            p = AGENT / "audit.json"
            if p.exists():
                try:
                    a = json.loads(p.read_text(errors="replace"))
                    # Merge army_target from the tick stream — the audit
                    # writer doesn't carry it, and the strip needs it. Only
                    # merge when the tick belongs to THIS run; else it mixes
                    # stale values from a different match (audit finding).
                    st0 = live_state()
                    if st0.get("run") == a.get("run") or not a.get("run"):
                        a["army_target"] = st0.get("army_target")
                    # Last MiniMax steer for the panel/chip — the audit had
                    # no mm_note, so the UI showed '—' forever.
                    try:
                        for ln in tail_lines(MMWATCH, 8)[::-1]:
                            e = json.loads(ln)
                            if e.get("patch") or e.get("kind") == "proof":
                                a["mm_note"] = (
                                    ("applied " if e.get("applied") else "") +
                                    json.dumps(e.get("patch") or e.get("raw", ""))[:80])
                                break
                    except Exception:
                        pass
                    # Activity timeline: mode edges, newest first, capped.
                    # Thread-locked — two concurrent /audit calls used to
                    # interleave the append and lose/duplicate edges.
                    a["activity"] = track_activity(a.get("mode"), a.get("t"))
                    # Build-stall tracker: how long since a build completed
                    # (cat_built sum) while the bot claims to be spending.
                    cat_sum = sum((a.get("cat_built") or {}).values())
                    global _lastcats
                    if cat_sum != _lastcats["sum"]:
                        _lastcats = {"sum": cat_sum, "since": time.time()}
                    a["build_stale_s"] = round(time.time() - _lastcats["since"])
                    a["alerts"] = audit_alerts(a)
                    if a["build_stale_s"] > 120 and a.get("mode") in \
                            ("SpendGold", "Idle", "HoldCastle"):
                        a["alerts"].insert(0,
                            {"sev": "warn", "msg":
                             f"no build completed in {a['build_stale_s']}s while spending"})
                    a["age_s"] = round(time.time() - p.stat().st_mtime, 1)
                    self._send(200, json.dumps(a), "application/json")
                except Exception as e:
                    self._send(500, json.dumps({"error": str(e)}), "application/json")
            else:
                self._send(404, "{}")
        elif self.path == "/efficiency":
            try:
                import sys as _s
                import os as _os
                _s.path.insert(0, _os.path.dirname(_os.path.abspath(__file__)))
                import eff_lib
                eff_lib.AGENT = AGENT
                body = eff_lib.compare(eff_lib.load(AGENT))
                bf = AGENT / "benchmarks.json"
                body["bench"] = json.loads(bf.read_text()) if bf.exists() else {}
                self._send(200, json.dumps(body), "application/json")
            except Exception as e:
                self._send(500, json.dumps({"error": str(e)}), "application/json")
        elif self.path == "/policy":
            pf = AGENT / "policy.json"
            mf = AGENT / "mishaps.json"
            out = {"policy": None, "mishaps": []}
            if pf.exists():
                try:
                    table = json.loads(pf.read_text())
                    out["policy"] = {"states": len(table),
                        "cells": sum(len(v) for v in table.values()),
                        "top": sorted(
                            ((k, max(v.items(), key=lambda x: x[1])) for k, v in table.items()),
                            key=lambda x: -x[1][1])[:25]}
                except Exception as ex:
                    out["policy"] = {"error": str(ex)}
            if mf.exists():
                try: out["mishaps"] = json.loads(mf.read_text())
                except Exception: pass
            self._send(200, json.dumps(out), "application/json")
        elif self.path == "/metrics":
            self._send(200, json.dumps(metrics()), "application/json")
        elif self.path == "/mmwatch":
            if MMWATCH.exists():
                lines = tail_lines(MMWATCH, 30)
                rows = []
                for x in lines:
                    try: rows.append(json.loads(x))
                    except Exception: pass
                self._send(200, json.dumps(rows), "application/json")
            else:
                self._send(200, "[]", "application/json")
        elif self.path.startswith("/playbook"):
            scene = ""
            if "?" in self.path and "scene=" in self.path:
                scene = self.path.split("scene=")[1].split("&")[0]
            if not scene:
                st = live_state()
                scene = (st.get("run") or "").split("-", 1)[-1]
            scene = pathlib.Path(scene).name        # same traversal guard
            pb = AGENT / "botpack" / f"strategy_{scene.lower()}.json"
            self._send(200, json.dumps({
                "scene": scene,
                "playbook": readj(pb, None),
                "raw": pb.read_text(errors="replace") if pb.exists() else ""}),
                "application/json")
        elif self.path == "/history":
            if CHATLOG.exists():
                lines = tail_lines(CHATLOG, 60)
                rows = []
                for x in lines:
                    try: rows.append(json.loads(x))
                    except Exception: pass
                self._send(200, json.dumps(rows), "application/json")
            else:
                self._send(200, "[]", "application/json")
        else:
            self._send(404, "?")

    def _do_POST(self):
        # Cap the read — a peer claiming a huge Content-Length used to hang
        # the handler thread (and unbounded base64 hit the LLM request).
        try:
            _n = int(self.headers.get("Content-Length", 0) or 0)
        except (TypeError, ValueError):
            _n = 0
        if _n > 8 * 1024 * 1024:
            self._send(413, "too large"); return
        if self.path == "/order":
            # Direct command — writes the coach file, waits for the plugin's
            # own apply line in the game log. Proof, not assumption.
            n = _n
            try:
                data = json.loads(self.rfile.read(n) or b"{}")
            except Exception:
                self._send(400, "bad json"); return
            cmd = validate_patch(data) or {}   # same clamps as MiniMax patches
            if not cmd:
                self._send(400, "no allowed fields"); return
            # Timestamp nonce: two identical orders used to produce identical
            # file bytes → the plugin's content-dedupe skipped the second and
            # the proof loop reported FAILED though state applied. Same fix
            # the watch loop uses for MiniMax patches.
            cmd.setdefault("note", f"ui-order#{int(time.time())}")
            out = {"ok": False, "cmd": cmd}
            try:
                log = pathlib.Path(
                    r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log")
                before = tail_bytes(log, 80000).count(
                    "[coach] user-cmd") if log.exists() else 0
                write_cmd(cmd)
                ok = False
                for _ in range(20):
                    time.sleep(0.5)
                    if log.exists() and tail_bytes(log, 80000).count(
                            "[coach] user-cmd") > before:
                        ok = True
                        break
                out["ok"] = ok
                append_log("c" if ok else "err",
                    f"[ORDER {'APPLIED' if ok else 'FAILED'}] {json.dumps(cmd)}")
            except Exception as ex:
                out["error"] = str(ex)
            self._send(200, json.dumps(out), "application/json")
            return
        if self.path == "/regen":
            n = int(self.headers.get("Content-Length", 0))
            try:
                data = json.loads(self.rfile.read(n) or b"{}")
                scene = data.get("scene") or "Durststein"
                import subprocess
                subprocess.Popen(
                    [sys.executable, str(ROOT / "tools" / "mm-coach.py"),
                     "--scene", scene],
                    cwd=str(ROOT))
                self._send(200, json.dumps({"ok": True}), "application/json")
            except Exception as ex:
                self._send(200, json.dumps({"ok": False, "err": str(ex)}),
                           "application/json")
            return
        if self.path != "/chat":
            self._send(404, "?"); return
        n = int(self.headers.get("Content-Length", 0))
        try:
            data = json.loads(self.rfile.read(n) or b"{}")
        except Exception:
            self._send(400, "bad json"); return
        msg = (data.get("message") or "").strip()
        img = data.get("image")   # base64 png, optional
        st = live_state()
        st["learner"] = {
            "policy": readj(AGENT / "policystats.json", {}),
            "net": readj(AGENT / "netstats.json", {}),
            "grades": metrics()["grades"]}   # /chat is the only caller left —
        # metrics() is now TTL-cached so the full JSONL scan doesn't run per
        # message (seconds-long scan per chat = audit finding #16)
        digest = json.dumps(st, separators=(",", ":"))
        append_log("user", msg + (" [image]" if img else ""))
        try:
            if img:
                msgs = [{"role": "system", "content": SYS},
                        {"role": "user", "content": [
                            {"type": "text", "text":
                                "BOT STATE: " + digest + "\nUSER: " + msg},
                            {"type": "image_url", "image_url":
                                {"url": "data:image/png;base64," + img}}]}]
                reply, usage = llm(msgs, VISION_MODEL, 700)
            else:
                msgs = [{"role": "system", "content": SYS},
                        {"role": "user", "content":
                            "BOT STATE: " + digest + "\nUSER: " + msg}]
                reply, usage = llm(msgs, LLM_MODEL, 700)
            cmd, clean = extract_cmd(reply)
            append_log("assistant", clean + (f" [CMD {json.dumps(cmd)}]"
                                           if cmd else ""))
            self._send(200, json.dumps({"reply": clean, "cmd": cmd,
                                        "usage": usage,
                                        "state": st}), "application/json")
        except Exception as ex:
            append_log("err", str(ex))   # 'err' is the role the history mapper styles red
            self._send(200, json.dumps({"reply": f"(LLM unreachable: {ex})",
                                        "cmd": None, "state": st}),
                       "application/json")


def readj(p, dflt):
    try:
        return json.loads(pathlib.Path(p).read_text(errors="replace"))
    except Exception:
        return dflt

_metrics_cache = {"m": None, "at": 0.0}

def metrics():
    """Full dashboard payload — grades, learning, weaknesses, curve.
    TTL-cached: this scans every ticks/events/dataset file — at per-request
    cadence it was the server's dominant CPU cost."""
    if _metrics_cache["m"] is not None and \
            time.time() - _metrics_cache["at"] < 15:
        return _metrics_cache["m"]
    m = _metrics()
    _metrics_cache["m"] = m
    _metrics_cache["at"] = time.time()
    return m

def _metrics():
    m = {"learning": {}, "grades": {}, "weaknesses": [], "runs": [],
         "mishaps": readj(AGENT / "mishaps.json", []) or []}
    m["learning"]["policy"] = readj(AGENT / "policystats.json", {})
    m["learning"]["net"] = readj(AGENT / "netstats.json", {})
    # dataset volume + outcome split
    rows = wins = defs = 0
    for f in glob.glob(str(AGENT / "dataset" / "*.jsonl")):
        for line in tail_lines(pathlib.Path(f), 5000):   # bounded tail-read
            try:
                r = json.loads(line)
                rows += 1
                oc = r.get("meta", {}).get("outcome")
                if oc == "victory": wins += 1
                if oc == "defeat": defs += 1
            except Exception: pass
    m["learning"]["dataset"] = {"rows": rows, "wins": wins, "defeats": defs}
    # per-run learning curve + perf aggregates
    curve, cat = [], {"econ": [], "def": [], "army": [], "hero": [],
                      "surv": []}
    defeats_scene, breaches_line, squads = {}, {}, 0
    for rd in sorted(glob.glob(str(AGENT / "runs" / "*"))):
        rd = pathlib.Path(rd)
        ticks = rd / "ticks.jsonl"
        if not ticks.exists(): continue
        n = cov = ra = spend = night_t = build = 0
        ally_rat = hp_sum = wave_max = 0.0
        outcome = "running"
        last_scene = ""
        ev = rd / "events.jsonl"
        if ev.exists():
            for nl in tail_lines(ev, 200):
                try: e = json.loads(nl)
                except Exception: continue
                if e.get("note") in ("victory", "defeat"):
                    outcome = e["note"]
        for line in tail_lines(ticks, 5000, cap=2_000_000):
            try: t = json.loads(line)
            except Exception: continue
            n += 1
            last_scene = t.get("scene") or last_scene
            if t.get("night"): night_t += 1
            if t.get("mode") == "SpendGold": spend += 1
            if t.get("ra"): ra += 1
            if (t.get("drn") or 0) > 0:
                cov += (t.get("drc") or 0) / t["drn"]
            if (t.get("at") or 0) > 0:
                ally_rat += min(1.0, (t.get("ally") or 0) / t["at"])
            hp_sum += t.get("hp") or 0
            # tick "wave" is "3/8" — str, not float; the bare float() always
            # threw ValueError and wave_max silently stayed 0 (surv grade).
            try: wave_max = max(wave_max,
                    float(str(t.get("wave") or "0").split("/")[0] or 0))
            except Exception: pass
        if n == 0: continue
        # Scene truth from the ticks themselves — folder names can stay
        # "unknown" (run started before the scene resolved, e.g. _LevelSelect).
        scene = last_scene or rd.name.split("-", 1)[-1]
        transit = n < 20   # <10 s captures = menu/transition hops, not runs
        days = max(1, night_t)
        e_g = min(100, spend / n * 250 + 40)
        d_g = min(100, (cov / n) * 100 + (1 - ra / n) * 40)
        a_g = min(100, (ally_rat / n) * 140)
        h_g = min(100, (hp_sum / n) * 80 + (outcome != "defeat") * 20)
        s_g = min(100, wave_max * 8 + (outcome == "victory") * 30)
        if not transit:
            for k, v in (("econ", e_g), ("def", d_g), ("army", a_g),
                         ("hero", h_g), ("surv", s_g)):
                cat[k].append(v)
        if outcome == "defeat":
            defeats_scene[scene] = defeats_scene.get(scene, 0) + 1
        curve.append({"run": rd.name, "scene": scene, "outcome": outcome,
                      "wave": wave_max, "ticks": n, "transit": transit,
                      "score": round((e_g + d_g + a_g + h_g + s_g) / 5)})
    # MiniMax command apply-rate — % of last 20 steers the plugin confirmed.
    mm_applied = mm_total = 0
    try:
        for ln in tail_lines(MMWATCH, 40):
            e = json.loads(ln)
            if e.get("kind") == "proof":
                mm_total += 1
                if e.get("applied"): mm_applied += 1
    except Exception:
        pass
    m["mm_rate"] = round(mm_applied / mm_total * 100) if mm_total else 0
    m["mm_total"] = mm_total
    m["curve"] = curve
    m["grades"] = {k: round(sum(v) / len(v)) if v else 0
                   for k, v in cat.items()}
    # truth inputs behind each grade — the panel can show *why*.
    m["grade_src"] = {
        "econ":  "spend-time % of ticks",
        "def":   "door coverage % + red-alert rate",
        "army":  "ally/army_target ratio over run",
        "hero":  "mean hero hp over ticks",
        "surv":  "max wave reached + victory bonus"}
    # trend: last 3 runs vs previous 3
    if len(curve) >= 6:
        old = sum(c["score"] for c in curve[-6:-3]) / 3
        new = sum(c["score"] for c in curve[-3:]) / 3
        m["trend"] = round(new - old, 1)
    # weaknesses
    if defeats_scene:
        top = sorted(defeats_scene.items(), key=lambda x: -x[1])[:4]
        for sc, c in top:
            m["weaknesses"].append(
                {"type": "defeats", "where": sc, "count": c,
                 "fix": "re-run MiniMax playbook; raise army_target"})
    if m["grades"].get("def", 0) < 50:
        m["weaknesses"].append({"type": "coverage", "where": "doors",
            "count": m["grades"]["def"],
            "fix": "squad_size up; build barracks earlier"})
    if m["grades"].get("army", 0) < 50:
        m["weaknesses"].append({"type": "army", "where": "production",
            "count": m["grades"]["army"],
            "fix": "more troop buildings; army_target floor"})
    if m["grades"].get("econ", 0) < 40:
        m["weaknesses"].append({"type": "economy", "where": "income",
            "count": m["grades"]["econ"],
            "fix": "income buildings before military sprawl"})
    # session-log derived: breaches per line, squads posted
    log = pathlib.Path(r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log")
    if log.exists():
        tail = tail_bytes(log, 400000)
        import re
        for mm in re.finditer(r"BREACH on door '([^']+)'", tail):
            ln = mm.group(1)
            breaches_line[ln] = breaches_line.get(ln, 0) + 1
        squads = len(re.findall(r"posted squad \d+/\d+", tail))
    m["breach_doors"] = sorted(breaches_line.items(), key=lambda x: -x[1])[:6]
    m["squads_posted"] = squads
    return m

PAGE = r"""<!DOCTYPE html><html><head><meta charset="utf-8"><title>Thronefall Coach</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
:root{--bg:#1a1210;--rail:#150e0b;--side:#201612;--main:#231912;--card:#2c2118;
 --bord:rgba(240,179,94,.14);--acc:#f0b35e;--acc2:#e8a33d;--ok:#7bc96f;
 --warn:#e8a33d;--bad:#e0604f;--txt:#f3e7cf;--dim:#a08a6e;--teal:#3fa9a0}
*{box-sizing:border-box}
html,body{height:100%}
body{margin:0;font-family:'Segoe UI',system-ui,sans-serif;background:var(--bg);
 color:var(--txt);display:flex;overflow:hidden;font-size:13.5px}
button{background:none;border:0;color:var(--txt);cursor:pointer;font-family:inherit}
::selection{background:rgba(240,179,94,.3)}
#rail{width:52px;background:var(--rail);border-right:1px solid var(--bord);
 display:flex;flex-direction:column;align-items:center;padding:12px 0;gap:7px;flex:none}
#rail .lg{font-size:20px;margin-bottom:8px}
#rail .ri{width:38px;height:38px;border-radius:10px;display:flex;align-items:center;
 justify-content:center;font-size:16px;color:var(--dim);border:1px solid transparent}
#rail .ri:hover{background:#2c2118;color:var(--txt)}
#rail .ri.on{background:#3a2b1c;color:var(--acc);border-color:rgba(240,179,94,.35)}
#side{width:220px;min-width:170px;max-width:400px;background:var(--side);
 border-right:1px solid var(--bord);display:flex;flex-direction:column;
 flex:none;resize:horizontal;overflow:hidden}
#side.hide{display:none}
#side .sh{padding:10px;display:flex;gap:6px;align-items:center}
#side .sh input{flex:1;background:#150e0a;border:1px solid var(--bord);border-radius:8px;
 padding:6px 9px;color:var(--txt);font-size:12px;outline:0;min-width:0}
#runlist{flex:1;overflow-y:auto;padding:4px 6px}
.rf{font-size:10px;color:var(--dim);padding:2px 8px;border-radius:10px;
 border:1px solid var(--bord)}
.rf.on{color:var(--acc);border-color:rgba(240,179,94,.5)}
#jump{position:fixed;bottom:130px;left:50%;transform:translateX(-50%);
 display:none;background:#3a2b1c;border:1px solid var(--acc);border-radius:16px;
 padding:4px 14px;font-size:11px;color:var(--acc);z-index:5;box-shadow:0 3px 10px rgba(0,0,0,.5)}
.rl{display:flex;flex-direction:column;gap:2px;padding:8px 9px;border-radius:8px;
 cursor:pointer;margin-bottom:2px;border:1px solid transparent}
.rl:hover{background:#2a1f16}
.rl.on{background:#332616;border-color:rgba(240,179,94,.4)}
.rl.tr{opacity:.45}
.rl .rn{font-size:12px;font-weight:600;display:flex;align-items:center;gap:6px}
.rl .rm{font-size:10px;color:var(--dim)}
.rl .det{font-size:10px;color:#c9b088;background:#150e0a;border-radius:6px;
 padding:5px 7px;margin-top:3px;line-height:1.5;white-space:pre-wrap}
.dot{width:7px;height:7px;border-radius:50%;flex:none;box-shadow:0 0 5px currentColor}
.dot.run{background:var(--acc2);color:var(--acc2)}
.dot.win{background:var(--ok);color:var(--ok)}
.dot.lose{background:var(--bad);color:var(--bad)}
#side .ft{padding:8px 10px;border-top:1px solid var(--bord);font-size:10px;color:var(--dim)}
#main{flex:1;display:flex;flex-direction:column;min-width:0;overflow:hidden}
#hd{height:46px;border-bottom:1px solid var(--bord);display:flex;align-items:center;
 gap:8px;padding:0 14px;flex:none;background:#1c1410}
#hd .t{font-weight:700;font-size:14px;color:var(--acc);white-space:nowrap}
.chip{background:#2c2118;border:1px solid var(--bord);border-radius:20px;
 padding:3px 10px;font-size:11px;color:var(--dim);white-space:nowrap}
.chip.on{color:var(--ok);border-color:rgba(123,201,111,.45)}
.chip.mm{color:#f0d5a0;border-color:rgba(240,179,94,.45)}
#hd .sp{flex:1;min-width:4px}
/* LIVE STRIP — the one source of truth, updates every second */
#strip{display:flex;gap:0;flex:none;border-bottom:1px solid var(--bord);
 background:#191108;overflow-x:auto}
.st{padding:8px 14px;border-right:1px solid var(--bord);min-width:86px;flex:none}
.st .k{font-size:9px;color:var(--dim);text-transform:uppercase;letter-spacing:.7px}
.st .v{font-size:16px;font-weight:700;color:var(--txt);line-height:1.1}
.st .v.gold{color:var(--acc)}.st .v.red{color:var(--bad)}.st .v.ok{color:var(--ok)}
.gA{color:#7bc96f}.gB{color:#a4d277}.gC{color:#f0b35e}.gD{color:#e8824b}.gF{color:#e5534b}
.st .v.small{font-size:12px;line-height:1.5}
.bar-mini{height:4px;border-radius:2px;background:#150e0a;overflow:hidden;width:70px;margin-top:2px}
.bar-mini div{height:100%;background:var(--acc2)}
.bar-mini div.ok{background:var(--ok)}.bar-mini div.bad{background:var(--bad)}
#alertbar{display:none;flex:none;padding:5px 14px;font-size:11.5px;font-weight:700}
#alertbar.crit{display:block;background:rgba(224,96,79,.18);color:#ff9d8f;
 border-bottom:1px solid rgba(224,96,79,.4)}
#alertbar.warn{display:block;background:rgba(232,163,61,.13);color:#f0c983;
 border-bottom:1px solid rgba(232,163,61,.35)}
#healthbar{display:none;flex:none;padding:5px 14px;font-size:11px;
 background:rgba(224,80,64,.22);color:#ffb3a8;border-bottom:2px solid var(--bad);
 line-height:1.5}
#healthbar.bad{display:block}
#healthbar b{color:#ff7d6e}
#feed{flex:1;min-height:0;overflow-y:auto;padding:14px 18px 30px;display:flex;
 flex-direction:column;gap:9px;
 background:radial-gradient(ellipse at 20% -10%,rgba(240,179,94,.05),transparent 50%),var(--main)}
.m{max-width:84%;padding:9px 13px;border-radius:12px;line-height:1.45;
 white-space:pre-wrap;font-size:13px;animation:pop .15s;overflow-wrap:break-word}
@keyframes pop{from{opacity:0;transform:translateY(4px)}to{opacity:1}}
.m.u{align-self:flex-end;background:#46311f;border:1px solid rgba(240,179,94,.3)}
.m.a{align-self:flex-start;background:var(--card);border:1px solid var(--bord)}
.m.c{align-self:flex-start;background:#201a12;border-left:3px solid var(--acc);
 font-size:11px;color:#c9b088}
.m.mm{align-self:flex-start;background:#1a1f2e;border-left:3px solid var(--teal);
 font-size:11px;color:#9ec8c4}
.m.err{align-self:stretch;background:rgba(224,80,64,.13);border:1px solid rgba(224,80,64,.45);
 border-left:4px solid var(--bad);font-size:11.5px;color:#ff9d8f;font-weight:600}
.m .who{display:block;font-size:9px;color:var(--dim);margin-bottom:2px;
 text-transform:uppercase;letter-spacing:.6px}
.m .tm{float:right;font-size:9px;color:var(--dim);margin-left:10px}
#cmp{margin:0 16px 13px;background:var(--card);border:1px solid rgba(240,179,94,.25);
 border-radius:13px;padding:9px;flex:none;position:relative;z-index:3;
 box-shadow:0 -4px 18px rgba(0,0,0,.3)}
#txt{width:100%;background:#1a120c;border:1px solid rgba(240,179,94,.18);outline:0;
 color:var(--txt);font-size:13.5px;resize:vertical;min-height:36px;max-height:45vh;
 font-family:inherit;padding:9px 11px;border-radius:9px;line-height:1.4}
#txt:focus{border-color:var(--acc)}
#cmp .bar{display:flex;gap:5px;align-items:center;margin-top:7px}
#cmp .cb{height:29px;min-width:32px;border-radius:8px;display:flex;align-items:center;
 justify-content:center;font-size:14px;color:var(--dim);padding:0 7px}
#cmp .cb:hover{background:#3a2b1c;color:var(--acc)}
#cmp .cb.on{color:var(--acc)}
#cmp .cb.rec-on{color:#e5534b;animation:pulse 1s infinite}
@keyframes pulse{50%{opacity:.5}}
#vst{font-size:10.5px;color:var(--dim);flex:1}
#send{background:linear-gradient(180deg,#f5c06a,#d9912e);border-radius:9px;
 padding:6px 18px;font-weight:700;font-size:12.5px;color:#241505;
 box-shadow:0 2px 0 #8a5c1e}
#send:hover{filter:brightness(1.1)}
#panel{width:0;overflow:hidden;background:var(--main);display:flex;flex:none}
#panel.open{width:360px;min-width:230px}
#pgrab{width:6px;cursor:ew-resize;flex:none}
#pgrab:hover{background:rgba(240,179,94,.3)}
#pin{flex:1;display:flex;flex-direction:column;min-width:0;border-left:1px solid var(--bord)}
#phd{height:46px;border-bottom:1px solid var(--bord);display:flex;align-items:center;
 padding:0 13px;font-weight:700;font-size:13px;gap:8px;flex:none;color:var(--acc);
 background:#1c1410}
#pbody{flex:1;overflow-y:auto;padding:11px}
.pane{display:none}.pane.on{display:block}
.card{background:var(--card);border:1px solid var(--bord);border-radius:10px;
 padding:10px 12px;margin-bottom:8px}
.card h4{margin:0 0 5px;font-size:10px;color:var(--acc2);text-transform:uppercase;
 letter-spacing:.7px;font-weight:700}
.kv{display:flex;justify-content:space-between;gap:8px;font-size:12px;padding:3px 0;
 border-bottom:1px solid rgba(240,179,94,.08)}
.kv:last-child{border-bottom:0}
.kv b{color:var(--acc);text-align:right}
.wk{background:var(--card);border-left:3px solid var(--bad);border-radius:7px;
 padding:8px 10px;margin-bottom:7px;font-size:12px}
.wk b{color:var(--bad)}
.hint{color:var(--dim);font-size:10.5px;margin-top:3px}
pre.book{background:#150e0a;border:1px solid var(--bord);border-radius:9px;
 padding:10px;font-size:10.5px;white-space:pre-wrap;color:#d8c49a;max-height:60vh;
 overflow-y:auto;line-height:1.5}
#view{position:relative;margin-bottom:8px}
#shot{width:100%;border-radius:9px;border:1px solid rgba(240,179,94,.25);display:block;
 background:#0d0906;min-height:140px}
#draw{position:absolute;left:0;top:0;cursor:crosshair}
#livemeta{font-size:10px;color:var(--dim);display:flex;justify-content:space-between;margin-top:3px}
.pb{display:flex;gap:6px}
.pb button{flex:1;background:#332617;border:1px solid var(--bord);border-radius:8px;
 padding:7px;font-size:11px;color:var(--txt)}
.pb button:hover{border-color:var(--acc);color:var(--acc)}
.door{display:inline-block;background:#150e0a;border:1px solid var(--bord);
 border-radius:7px;padding:4px 8px;margin:2px 3px 0 0;font-size:10.5px}
.door.cov{border-color:rgba(123,201,111,.5);color:#a5d977}
.door.open{border-color:rgba(224,96,79,.5);color:#ff9d8f}
::-webkit-scrollbar{width:8px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:#3d2c1b;border-radius:5px}
</style></head><body>
<div id="rail">
 <div class="lg">&#128081;</div>
 <button class="ri on" id="r0" onclick="tool('chat')" title="Chat">&#128172;</button>
 <button class="ri" id="r1" onclick="tool('live')" title="Live view">&#128064;</button>
 <button class="ri" id="r2" onclick="tool('stats')" title="Stats">&#128200;</button>
 <button class="ri" id="r3" onclick="tool('book')" title="Playbook">&#128218;</button>
 <button class="ri" id="r4" onclick="tool('weak')" title="Weaknesses">&#9888;</button>
 <button class="ri" id="r5" onclick="tool('audit')" title="Audit">&#9878;</button>
</div>
<div id="side">
 <div class="sh"><input id="rq" placeholder="Search runs" oninput="runs()">
 <button class="cb" onclick="hideSide()" title="hide" style="color:var(--dim)">&#10094;</button></div>
 <div class="sh" style="padding-top:0">
  <button class="cb rf on" onclick="rf(this,'all')">all</button>
  <button class="cb rf" onclick="rf(this,'defeat')">defeats</button>
  <button class="cb rf" onclick="rf(this,'victory')">wins</button>
  <button class="cb rf" onclick="rf(this,'running')">running</button>
  <button class="cb rf" onclick="rf(this,'tr')">transit</button></div>
 <div id="runlist"></div>
 <div class="ft" id="sideft">…</div>
</div>
<div id="main">
 <div id="hd">
  <button class="cb" id="showSide" onclick="hideSide()" title="runs" style="display:none;color:var(--dim);font-size:15px">&#10095;</button>
  <div class="t">&#128081; Thronefall Coach</div>
  <span class="chip" id="stchip">offline</span>
  <span class="chip mm" id="mmchip">MiniMax · idle</span>
  <div class="sp"></div>
  <span class="chip" id="agechip">—</span>
 </div>
 <!-- LIVE STRIP: one truth, every second. If it doesn't move, it's stale -->
 <div id="strip"></div>
 <div id="alertbar"></div>
 <div id="healthbar"></div>
 <div id="feed"></div>
 <button id="jump" onclick="jumpBottom()">▼ new</button>
 <div id="cmp">
  <textarea id="txt" rows="2" placeholder="Command the realm… (Enter sends · Shift+Enter newline · drag corner to grow)"></textarea>
  <div class="bar">
   <button class="cb" onclick="document.getElementById('file').click()" title="attach image">&#128206;</button>
   <input type="file" id="file" accept="image/*" style="display:none" onchange="attach(this)">
   <button class="cb" id="mic" title="voice — auto-sends after a pause">&#127908;</button>
   <button class="cb" id="tts" title="speak replies" onclick="ttsOn=!ttsOn;this.classList.toggle('on',ttsOn)">&#128266;</button>
   <button class="cb" id="lock" title="lock textbox size" onclick="lockBox=this.classList.toggle('on')">&#128274;</button>
   <button class="cb" title="round-trip test: web→bot→game" onclick="ping()">&#128268;</button>
   <button class="cb" title="ORDER: military now" onclick="order({build_focus:'military',note:'ui-military'})">&#9876;</button>
   <button class="cb" title="ORDER: defense now" onclick="order({build_focus:'defense',note:'ui-defense'})">&#128737;</button>
   <button class="cb" title="ORDER: income now" onclick="order({build_focus:'income',note:'ui-income'})">&#128176;</button>
   <button class="cb" title="ORDER: hero builds" onclick="order({hero_posture:'builder',note:'ui-builder'})">&#128296;</button>
   <button class="cb" title="ORDER: hero fights" onclick="order({hero_posture:'fighter',note:'ui-fighter'})">&#9876;</button>
   <span id="vst"></span>
   <button id="send" onclick="send()">Send</button>
  </div>
 </div>
</div>
<div id="panel"><div id="pgrab"></div><div id="pin">
 <div id="phd"><span id="pttl">Live</span><div class="sp" style="flex:1"></div>
 <button onclick="tool('chat')" style="color:var(--dim)">&#10005;</button></div>
 <div id="pbody">
  <div class="pane" id="p-live">
   <div id="view"><img id="shot" src="/live.png"><canvas id="draw"></canvas></div>
   <div id="livemeta"><span id="lvAge">—</span><span id="lvFps"></span></div>
   <div class="pb" style="margin-top:7px"><button onclick="clearInk()">Clear ink</button>
    <button onclick="sendShot()">Send annotated</button></div>
  </div>
  <div class="pane" id="p-stats">
   <div class="card"><h4>Grades (how computed below)</h4><div id="gradeCards"></div></div>
   <div class="card"><h4>Learning</h4><div id="learnKV"></div></div>
   <div class="card"><h4>Reward curve</h4><canvas id="curve" style="width:100%;height:130px"></canvas>
    <div class="hint" id="trendline"></div></div>
  </div>
  <div class="pane" id="p-book">
   <div class="pb" style="margin-bottom:8px"><button onclick="book()">Refresh</button>
    <button onclick="regen()">&#10227; MiniMax rewrite</button></div>
   <pre class="book" id="book">loading…</pre>
  </div>
  <div class="pane" id="p-weak">
   <div class="card"><h4>Weaknesses</h4><div id="weak"></div></div>
   <div class="card"><h4>Breach-prone doors</h4><div id="breachTbl"></div></div>
   <div class="card"><h4>Never-retry memory</h4><div id="mish" class="hint"></div></div>
  </div>
  <div class="pane" id="p-audit">
   <div class="card"><h4>Efficiency (live)</h4><div id="effLive"></div></div>
   <div class="card"><h4>Task efficiency (per task kind)</h4><div id="effTasks"></div></div>
   <div class="card"><h4>Now vs last 1h / 16h / 48h vs baseline vs target</h4><div id="effCmp" class="hint">loading…</div></div>
   <div class="card"><h4>MiniMax heartbeat</h4><div id="effCoach"></div></div>
   <div class="card"><h4>Playbook checklist</h4><div id="auCheck"></div></div>
   <div class="card"><h4>Door posts</h4><div id="auDoor"></div></div>
   <div class="card"><h4>Built so far</h4><div id="auCat"></div></div>
   <div class="card"><h4>Action timeline</h4><div id="auAct"></div></div>
   <div class="card"><h4>Last MiniMax command</h4><div id="auMm" class="hint"></div></div>
  </div>
 </div>
</div></div>
<script>
let ttsOn=false,strokes=[],pending=null,cur=null,runRows=[],lockBox=false;
let sideHidden=false,voiceTimer=null,voiceBuf="",A={};   // A = live audit state
const feed=document.getElementById('feed'),txt=document.getElementById('txt');
const shot=document.getElementById('shot'),cv=document.getElementById('draw');
function esc(s){const d=document.createElement('div');d.textContent=s;return d.innerHTML}
function add(role,text,who,tm){
 const d=document.createElement('div');d.className='m '+(role=='mm'?'mm':role=='err'?'err':role);
 d.innerHTML=(who?`<span class="who">${who}<span class="tm">${tm||''}</span></span>`:'')+esc(text);
 feed.appendChild(d);
 if(scrolledUp){newCount++;
  document.getElementById('jump').textContent='▼ '+newCount+' new'}
 else feed.scrollTop=feed.scrollHeight;
 if(role=='a'&&ttsOn){const u=new SpeechSynthesisUtterance(text);u.rate=1.05;speechSynthesis.speak(u)}}
async function j(u,o){const r=await fetch(u,o);return r.json()}
/* ── THE ONE LIVE LOOP: audit.json every 1 s drives EVERYTHING ── */
async function tick(){try{const a=await j('/audit');A=a;paint()}catch(e){A={};paint()}}
function paint(){
 const a=A;if(!a.mode){
  const chip=document.getElementById('stchip');
  chip.textContent='OFFLINE — no audit feed';chip.classList.remove('on');
  document.getElementById('agechip').textContent='plugin not writing audit.json';
  document.getElementById('strip').innerHTML=
   '<div class="st"><div class="k">status</div><div class="v red">OFFLINE</div></div>';
  return}
 const chip=document.getElementById('stchip');
 const stale=(a.age_s??99)>8;
 chip.textContent=stale?'STALE '+a.age_s+'s':'LIVE · '+a.scene;
 chip.classList.toggle('on',!stale);
 document.getElementById('agechip').textContent=`t=${a.t}s · mode ${a.mode} (${a.mode_since}s) · seen ${a.age_s}s ago`;
 // mmchip is owned by healthCheck() — paint() must not fight it.
 const cell=(k,v,cls)=>`<div class="st"><div class="k">${k}</div><div class="v ${cls||''}">${v}</div></div>`;
 document.getElementById('strip').innerHTML=
  cell('action',esc(a.mode||'')+(a.mode_since>60?` <span style="font-size:10px;color:var(--bad)">${a.mode_since}s</span>`:`<span style="font-size:10px;color:var(--dim)">${a.mode_since}s</span>`),'small')
  +cell('building',esc(a.cur_build||'—'),'small')
  +cell('gold',a.gold,'gold')
  +`<div class="st"><div class="k">army</div><div class="v">${a.ally}
   <span style="font-size:10px;color:var(--dim)">+${a.free||0}free</span></div>
   <div class="bar-mini"><div class="${(a.ally/(a.army_target||1))>0.7?'ok':(a.ally/(a.army_target||1))>0.3?'':'bad'}"
   style="width:${Math.min(100,(a.ally/(a.army_target||1))*100)}%"></div></div></div>`
  +cell('wave',a.wave+'/'+a.wave_total)
  +cell('doors',`${a.doors_cov}/${a.doors}`,a.doors_cov>0?'ok':'red')
  +cell('foes',a.foes)
  +cell('breach',a.breaches,a.breaches>0?'red':'')
  +cell('night',a.night?'YES':'no',a.night?'red':'')
  +cell('status',a.red?'RED':(a.alerts&&a.alerts.length?a.alerts.length+' alerts':'—'),a.red?'red':'ok');
 // door chips in audit pane
 const du=a.door_units||[],dl=a.door_lines||[];
 document.getElementById('auDoor').innerHTML=dl.length?dl.map((l,i)=>
  `<span class="door ${du[i]>0?'cov':'open'}">${esc(l)} · ${du[i]||0}</span>`).join(''):'<span class="hint">—</span>';
 document.getElementById('auCheck').innerHTML=(a.checklist||[]).map(c=>
  `<div class="kv"><span>${esc(c.n)}</span><b style="color:${c.done?'#7bc96f':'#e5534b'}">${c.done?'✓':'✗'}</b></div>`).join('')
  ||'<div class="hint">no playbook</div>';
 document.getElementById('auCat').innerHTML=Object.entries(a.cat_built||{}).map(([k,v])=>
  `<div class="kv"><span>${esc(k)}</span><b>${esc(v)}</b></div>`).join('')||'<div class="hint">nothing built yet</div>';
 document.getElementById('auAct').innerHTML=(a.activity||[]).map(([t,m])=>
  `<div class="kv"><span>t=${t}s</span><b>${esc(m)}</b></div>`).join('')||'<div class="hint">—</div>';
 document.getElementById('auMm').textContent=a.mm_note||'—';
 const done=(a.checklist||[]).filter(c=>c.done).length,tot=(a.checklist||[]).length;
 document.getElementById('auCheck').insertAdjacentHTML('afterbegin',
  tot?`<div class="hint" style="margin-bottom:4px">${done}/${tot} complete
   ${a.build_stale_s>120?`· <b style="color:#e5534b">stall ${a.build_stale_s}s</b>`:''}</div>`:'');
 // alert bar — highest severity wins
 const al=(a.alerts||[]);
 const bar=document.getElementById('alertbar');
 if(al.length){const top=al.some(x=>x.sev=='crit')?'crit':'warn';
  bar.className=top;bar.textContent=al.map(x=>x.msg).join(' · ')}
 else bar.className='';
}
setInterval(tick,1000);
function effPaint(){const a=A;if(a.eff===undefined)return;
 const col=v=>v>=80?'#7bc96f':v>=60?'#e5c07b':'#e5534b';
 const kv=(k,v,c)=>`<div class="kv"><span>${k}</span><b${c?` style="color:${c}"`:''}>${v}</b></div>`;
 document.getElementById('effLive').innerHTML=
  kv('<b>ACTIVE % strict (was 7.3, goal 50)</b>',(a.active_pct??0)+'%',(a.active_pct>=40?'#7bc96f':a.active_pct>=20?'#e5c07b':'#e5534b'))+kv('efficiency score (target 80)',a.eff,col(a.eff))+kv('lenient useful % (not the goal metric)',(a.useful_pct??0)+'%',col(a.useful_pct||0))
  +kv('maxed %',(a.maxed_pct??0)+'%')+kv('idle since progress',(a.since_prog??0)+'s',(a.since_prog>20?'#e5534b':''))
  +kv('drain',esc(a.eff_drain||'none'))+kv('spend ratio',a.spend_r)+kv('hot cells',a.hot_cells)
  +kv('tasks (verified / missed / micro)',`${a.task_total||0} (${a.task_verified||0} / ${a.task_misses||0} / ${a.task_micro||0})`,a.task_misses>0?'#e5c07b':'')
  +kv('worst task kind',esc(a.worst_kind||'—'));
 const ag=a.task_agg||{};
 document.getElementById('effTasks').innerHTML=Object.entries(ag).sort((x,y)=>y[1].waste_s-x[1].waste_s).slice(0,14).map(([k,v])=>
  `<div class="kv"><span>${esc(k)} <small>n=${v.n} ok=${v.ok} fail=${v.fail} ${v.avg_s}s</small></span><b style="color:${v.eff<0?'#888':col(v.eff)}">${v.eff<0?'n/a':v.eff}</b></div>`).join('')||'<div class="hint">no tasks yet</div>';
 const c=a.coach||{};
 document.getElementById('effCoach').innerHTML=kv('calls / failures',`${c.calls||0} / ${c.fail||0}`,c.fail>0?'#e5c07b':'')
  +kv('last latency',(c.latency_ms||0)+' ms')+kv('last trigger',esc(c.last_trigger||'—'))+kv('last advice age',c.age_s<0?'never':c.age_s+'s',c.age_s>180||c.age_s<0?'#e5534b':'#7bc96f')
  +kv('tokens',c.tokens||0)
  +(a.coach_fx||[]).map(f=>kv('fx '+esc(f.trigger),`${f.eff_before} → ${f.eff_after}`,f.eff_after>=f.eff_before?'#7bc96f':'#e5534b')).join('');}
async function effCmp(){try{const e=await j('/efficiency');const W=e.windows,names=['last_1h','last_16h','last_48h','all'];
 const rows=[['ACTIVE % strict (day reports)','day_active_pct'],['lenient useful %','useful_pct'],['build eff','build_eff'],['build ok %','build_ok_pct'],['gold/min','gold_per_min'],['builds/day','builds_per_day'],['ally gain/day','ally_gain_per_day'],['maxed gain/day','maxed_gain_per_day'],['task misses','task_misses'],['coach fx Δeff','coach_fx_avg_delta'],['coach latency ms','coach_latency_ms']];
 let h='<table style="width:100%;font-size:11px"><tr><th></th>'+names.map(n=>`<th>${n.replace('last_','')}</th>`).join('')+'<th>base</th><th>goal</th></tr>';
 for(const[l,k]of rows){h+=`<tr><td>${l}</td>`+names.map(n=>`<td>${W[n][k]??'—'}</td>`).join('')
  +`<td>${k=='day_active_pct'?e.baseline.active_pct:k=='useful_pct'?e.baseline.useful_pct:''}</td><td>${k=='day_active_pct'?e.target.active_pct:k=='useful_pct'?e.target.useful_pct:k=='build_eff'?e.target.build_eff:''}</td></tr>`}
 h+='</table><div class="hint" style="margin-top:4px">by bot build: '+(e.builds||[]).map(b=>`${new Date(b.build*1000).toLocaleString()} → useful ${b.useful_pct??'—'}% / build eff ${b.build_eff??'—'} (${b.tasks} tasks)`).join(' | ')+'</div>'
 +'<div class="hint">worst wasters: '+((W.all.worst||[]).map(x=>x[0]+' '+x[1]+'s').join(', ')||'—')+'</div>';
 document.getElementById('effCmp').innerHTML=h}catch(x){document.getElementById('effCmp').textContent='no efficiency data yet'}}
setInterval(effPaint,1000);setInterval(effCmp,10000);effCmp();
/* connectivity truth — red banner names exactly what is down */
async function healthCheck(){try{const h=await j('/health');
 const bad=(h.checks||[]).filter(c=>!c.ok);
 const bar=document.getElementById('healthbar');
 if(bad.length){bar.className='bad';
  bar.innerHTML='<b>DISCONNECTED:</b> '+bad.map(c=>`<b>${esc(c.name)}</b> — ${esc(c.detail)}`).join(' &nbsp;·&nbsp; ')}
 else bar.className='';
 document.getElementById('mmchip').textContent='MiniMax · '+
  ((h.checks||[]).find(c=>c.name=='MiniMax')||{}).detail;}catch(e){
 document.getElementById('healthbar').className='bad';
 document.getElementById('healthbar').textContent='SERVER UNREACHABLE — coach-server.py down'}}
setInterval(healthCheck,8000);healthCheck();
/* ── chat ── */
async function send(){
 const m=txt.value.trim();if(!m&&!pending)return;txt.value='';txt.style.height='auto';
 add('u',m+(pending?' [image]':''),'you',new Date().toLocaleTimeString());
 const body={message:m||'look at this'};if(pending){body.image=pending;pending=null}
 let r;
 try{r=await j('/chat',{method:'POST',body:JSON.stringify(body)})}
 catch(e){add('err','/chat failed: '+e,'LINK');return}
 add('a',r.reply,'Grandmaster');
 if(r.cmd){add('c','BOT ORDERED: '+JSON.stringify(r.cmd),'order');verifyCmd(r.cmd)}}
async function verifyCmd(cmd){
 await new Promise(r=>setTimeout(r,6000));paint();
 if(A.mode)add('c',`VERIFIED: mode=${A.mode} ally=${A.ally} doors=${A.doors_cov}/${A.doors} built=${JSON.stringify(A.cat_built||{})}`,'proof')}
txt.addEventListener('input',()=>{if(!lockBox){txt.style.height='auto';txt.style.height=Math.min(txt.scrollHeight,window.innerHeight*0.45)+'px'}});
txt.addEventListener('keydown',e=>{if(e.key=='Enter'&&!e.shiftKey){e.preventDefault();send()}});
function rf(el,f){runFilter=f;
 document.querySelectorAll('.rf').forEach(b=>b.classList.toggle('on',b==el));runs()}
/* scroll-lock: reading up = no autoscroll; jump button on new msgs */
let scrolledUp=false,newCount=0;
feed.addEventListener('scroll',()=>{scrolledUp=feed.scrollHeight-feed.scrollTop-feed.clientHeight>80;
 if(!scrolledUp)newCount=0;
 document.getElementById('jump').style.display=scrolledUp?'block':'none';
 document.getElementById('jump').textContent='▼ '+newCount+' new'});
function jumpBottom(){feed.scrollTop=feed.scrollHeight;scrolledUp=false}
function hideSide(){sideHidden=!sideHidden;
 document.getElementById('side').classList.toggle('hide',sideHidden);
 document.getElementById('showSide').style.display=sideHidden?'flex':'none'}
/* tool drawer */
const panel=document.getElementById('panel'),grab=document.getElementById('pgrab');
grab.onmousedown=e=>{e.preventDefault();
 const mv=ev=>{panel.style.width=Math.max(230,Math.min(window.innerWidth-300,window.innerWidth-ev.clientX))+'px'};
 const up=()=>{document.removeEventListener('mousemove',mv);document.removeEventListener('mouseup',up)};
 document.addEventListener('mousemove',mv);document.addEventListener('mouseup',up)};
function tool(t){
 const names={chat:'',live:'Live View',stats:'Stats',book:'Playbook',weak:'Weaknesses',audit:'Audit'};
 if(t=='chat'){panel.classList.remove('open');return}
 panel.classList.add('open');document.getElementById('pttl').textContent=names[t];
 document.querySelectorAll('.pane').forEach(x=>x.classList.remove('on'));
 document.getElementById('p-'+t).classList.add('on');
 document.querySelectorAll('#rail .ri').forEach((b,i)=>b.classList.toggle('on',
   ['chat','live','stats','book','weak','audit'][i]==t));
 if(t=='book')book();else if(t=='stats'||t=='weak')refresh();}
/* live frame — swap only on real new frame */
let lastTs=0,frameCt=0,lastFpsT=Date.now();
setInterval(async()=>{try{const l=await j('/live.json');
 if(l.ts&&l.ts!=lastTs){lastTs=l.ts;shot.src='/live.png?x='+l.ts;frameCt++;
  document.getElementById('lvAge').textContent='frame '+new Date(l.ts*1000).toLocaleTimeString()}
 const now=Date.now();if(now-lastFpsT>4000){document.getElementById('lvFps').textContent=
  (frameCt/((now-lastFpsT)/1000)).toFixed(1)+' fps';frameCt=0;lastFpsT=now}}catch(e){}},800);
/* history — last 30 only, mm entries get their time */
(async()=>{const h=await j('/history');h.slice(-30).forEach(x=>{
 const r=x.role=='user'?'u':x.role=='assistant'?'a':x.role=='mm'?'mm':x.role=='err'?'err':'c';
 const w=x.role=='user'?'you':x.role=='assistant'?'Grandmaster':x.role=='mm'?'MiniMax Watch':x.role=='err'?'LINK':'system';
 add(r,x.text,w,x.t?new Date(x.t*1000).toLocaleTimeString():'')})})();
/* runs — preserve selection+expansion across refreshes */
let selRun=-1,runFilter='all';
async function runs(){
 try{const m=await j('/metrics');runRows=(m.curve||[]).slice(-40).reverse();
 const q=document.getElementById('rq').value.toLowerCase();
 document.getElementById('runlist').innerHTML=runRows
  .filter(r=>runFilter=='all'||(runFilter=='tr' ? r.transit : !r.transit && r.outcome==runFilter))
  .filter(r=>!q||(r.scene||'').toLowerCase().includes(q))
  .map((r,i)=>`<div class="rl ${r.transit?'tr':''} ${r.run==selRun?'on':''}" onclick='pickRun(${JSON.stringify?JSON.stringify(r.run):'"'+r.run+'"'},${i})'>
   <span class="rn"><span class="dot ${r.outcome=='victory'?'win':r.outcome=='defeat'?'lose':'run'}"></span>
   ${esc(r.scene||'unknown')}</span>
   <span class="rm">${r.transit?'transition':esc(r.outcome||'')} · wave ${r.wave} · score ${r.score}</span>
   <div class="det" id="det${i}" style="display:none"></div></div>`).join('');
 document.getElementById('sideft').textContent=`${runRows.length} runs · squads ${m.squads_posted} · memory ${(m.mishaps||[]).length}`;
 if(selRun)pickRun(selRun)}catch(e){}}
async function pickRun(runId,idx){const r=runRows.find(x=>x.run===runId);if(!r)return;selRun=runId;
 document.querySelectorAll('.rl').forEach(x=>x.classList.toggle('on',x.onclick&&x.onclick.toString().includes(`'${runId}'`)));
 const d=document.getElementById('det'+idx);if(!d)return;
 if(d.dataset.open){d.style.display='none';d.dataset.open='';return}
 d.style.display='block';d.dataset.open='1';d.textContent='loading…';
 try{const t=await j('/run?name='+encodeURIComponent(r.run));
  d.innerHTML=(t.ticks||[]).map(x=>`t=${x.t} · ${esc(x.mode)} · ally ${x.ally} · doors ${x.drc}/${x.drn} · ${x.gold}g`).join('<br>')
   ||'no ticks'}catch(e){d.textContent='err'}}
setInterval(runs,15000);
/* metrics */
function gc(v){return v>=80?'gA':v>=60?'gB':v>=40?'gC':v>=20?'gD':'gF'}
async function refresh(){try{const m=await j('/metrics');
 const names={econ:'Economy',def:'Defense',army:'Army',hero:'Hero safety',surv:'Progression'};
 const src=m.grade_src||{};
 document.getElementById('gradeCards').innerHTML=Object.entries(names).map(([k,n])=>{
  const v=m.grades[k]||0;return `<div class="kv"><span>${n}<div class="hint" style="margin:0;font-size:9px">${src[k]||''}</div></span><b class="${gc(v)}">${v}</b></div>`}).join('');
 const L=m.learning||{},P=L.policy||{},N=L.net||{},D=L.dataset||{};
 document.getElementById('learnKV').innerHTML=[
  ['dataset rows',D.rows??0],['wins / defeats',`${D.wins??0} / ${D.defeats??0}`],
  ['policy states',P.states??0],['Q cells',P.cells??0],['decisions',P.decisions??0],
  ['mean |Q|',P.mean_abs_q??0],['ε',P.epsilon??'—'],
  ['net agree',N.ratio!==undefined?(N.ratio*100).toFixed(0)+'%':'—'],
  ['mm apply-rate',m.mm_rate+'% of '+m.mm_total]]
  .map(([k,v])=>`<div class="kv"><span>${k}</span><b>${v}</b></div>`).join('');
 document.getElementById('trendline').textContent=
  `trend ${(m.trend??0)>=0?'+':''}${m.trend??'—'} · net: ${N.last_net||'—'} vs bot ${N.last_bot||'—'} conf ${N.conf||0}`;
 document.getElementById('weak').innerHTML=(m.weaknesses||[]).length?
  m.weaknesses.map(w=>`<div class="wk"><b>${esc(w.type)}</b> — ${esc(w.where)} (${w.count})<div class="hint">→ ${esc(w.fix)}</div></div>`).join('')
  :'<div class="hint">none detected</div>';
 document.getElementById('breachTbl').innerHTML=(m.breach_doors||[]).map(([d,c])=>
  `<div class="kv"><span>${esc(d)}</span><b>${esc(c)}</b></div>`).join('')||'<div class="hint">none</div>';
 document.getElementById('mish').innerHTML=(m.mishaps||[]).map(x=>`<div>• ${esc(x)}</div>`).join('')||'none yet';
 const c=document.getElementById('curve'),x=c.getContext('2d');
 const W=c.width=c.clientWidth*2,H=c.height=260;x.clearRect(0,0,W,H);
 const pts=(m.curve||[]).filter(c2=>!c2.transit).map(c2=>c2.score);
 if(pts.length>1){const st=(W-30)/(pts.length-1);
  x.strokeStyle='#3d2c1b';for(let g=0;g<=4;g++){x.beginPath();x.moveTo(15,10+g*(H-30)/4);x.lineTo(W-15,10+g*(H-30)/4);x.stroke()}
  x.strokeStyle='#f0b35e';x.lineWidth=3;x.beginPath();
  pts.forEach((v,i)=>{const px=15+i*st,py=10+(100-v)*(H-30)/100;i?x.lineTo(px,py):x.moveTo(px,py)});x.stroke()}
}catch(e){}}
setInterval(()=>{if(document.getElementById('p-stats').classList.contains('on')||document.getElementById('p-weak').classList.contains('on'))refresh()},8000);
/* playbook */
async function book(){try{const b=await j('/playbook');
 document.getElementById('book').textContent=b.raw||'no playbook for this scene'}catch(e){}}
async function regen(){document.getElementById('book').textContent='MiniMax is writing a new playbook… (10-30 s)';
 await j('/regen',{method:'POST',body:'{}'});setTimeout(book,15000);setTimeout(book,35000)}
/* annotate */
function fit(){cv.width=shot.clientWidth;cv.height=shot.clientHeight;redraw()}
shot.onload=fit;window.onresize=fit;
cv.onmousedown=e=>{cur={x1:e.offsetX,y1:e.offsetY,x2:e.offsetX,y2:e.offsetY}};
cv.onmousemove=e=>{if(cur){cur.x2=e.offsetX;cur.y2=e.offsetY;redraw()}};
cv.onmouseup=()=>{if(cur){strokes.push(cur);cur=null;redraw()}};
function redraw(){const c=cv.getContext('2d');c.clearRect(0,0,cv.width,cv.height);
 c.strokeStyle='#f0b35e';c.lineWidth=3;c.lineCap='round';
 strokes.concat(cur?[cur]:[]).forEach(s=>{c.beginPath();c.moveTo(s.x1,s.y1);c.lineTo(s.x2,s.y2);c.stroke();
 const a=Math.atan2(s.y2-s.y1,s.x2-s.x1);c.beginPath();c.moveTo(s.x2,s.y2);
 c.lineTo(s.x2-14*Math.cos(a-.5),s.y2-14*Math.sin(a-.5));c.moveTo(s.x2,s.y2);
 c.lineTo(s.x2-14*Math.cos(a+.5),s.y2-14*Math.sin(a+.5));c.stroke()})}
function clearInk(){strokes=[];redraw()}
function sendShot(){const c=document.createElement('canvas');
 c.width=shot.naturalWidth;c.height=shot.naturalHeight;const x=c.getContext('2d');
 x.drawImage(shot,0,0,c.width,c.height);x.strokeStyle='#f0b35e';x.lineWidth=5;x.lineCap='round';
 const sx=c.width/cv.width,sy=c.height/cv.height;
 strokes.forEach(s=>{x.beginPath();x.moveTo(s.x1*sx,s.y1*sy);x.lineTo(s.x2*sx,s.y2*sy);x.stroke();
 const a=Math.atan2((s.y2-s.y1)*sy,(s.x2-s.x1)*sx);x.beginPath();x.moveTo(s.x2*sx,s.y2*sy);
 x.lineTo(s.x2*sx-20*Math.cos(a-.5),s.y2*sy-20*Math.sin(a-.5));x.moveTo(s.x2*sx,s.y2*sy);
 x.lineTo(s.x2*sx-20*Math.cos(a+.5),s.y2*sy-20*Math.sin(a+.5));x.stroke()});
 pending=c.toDataURL('image/png').split(',')[1];
 add('c','shot attached — write your order & Send','attach')}
function attach(f){const r=new FileReader();
 r.onload=()=>{pending=r.result.split(',')[1];add('c','file attached — write your order & hit Send','attach')};
 if(f.files[0])r.readAsDataURL(f.files[0]);f.value=''}
async function order(cmd){
 add('c','ORDER sent: '+JSON.stringify(cmd),'you');
 try{const r=await j('/order',{method:'POST',body:JSON.stringify(cmd)});
  add(r.ok?'c':'err',r.ok?'ORDER APPLIED — game confirmed':'ORDER FAILED — game never confirmed','proof')}catch(e){add('err','ORDER failed: '+e,'proof')}}
async function ping(){
 add('c','PING: writing test command, waiting for the game to confirm…','proof');
 try{const r=await j('/ping');
  add(r.ok?'c':'err',r.ok?'PING OK — the bot received and applied a live command':
   'PING FAILED at '+r.stage+' — '+(r.error||'game log never showed the apply'),
   'proof')}catch(e){add('err','PING failed: '+e,'proof')}}
/* voice */
let rec,recOn=false;const SR=window.SpeechRecognition||window.webkitSpeechRecognition;
if(SR){rec=new SR();rec.continuous=true;rec.interimResults=true;rec.lang='en-US';
 rec.onresult=e=>{let fin='',int='';
  for(let i=e.resultIndex;i<e.results.length;i++){
   if(e.results[i].isFinal)fin+=e.results[i][0].transcript;else int+=e.results[i][0].transcript}
  if(fin)voiceBuf=(voiceBuf+' '+fin).trim();
  txt.value=(voiceBuf+' '+int).trim();
  document.getElementById('vst').textContent=recOn?'listening… auto-send on pause':'';
  clearTimeout(voiceTimer);
  voiceTimer=setTimeout(()=>{if(recOn){recOn=false;document.getElementById('mic').classList.remove('rec-on');
   document.getElementById('vst').textContent='';try{rec.stop()}catch(e){}
   voiceBuf='';if(txt.value.trim())send()}},3000)};
 rec.onend=()=>{if(recOn){try{rec.start()}catch(e){}}};
 rec.onerror=()=>{recOn=false;document.getElementById('mic').classList.remove('rec-on')};
 document.getElementById('mic').onclick=()=>{
  if(recOn){recOn=false;clearTimeout(voiceTimer);document.getElementById('mic').classList.remove('rec-on');
   document.getElementById('vst').textContent='';try{rec.stop()}catch(e){};voiceBuf=''}
  else{recOn=true;voiceBuf=txt.value;document.getElementById('mic').classList.add('rec-on');
   document.getElementById('vst').textContent='listening…';try{rec.start()}catch(e){}}}}
else document.getElementById('mic').style.display='none';
runs();refresh();tick();
</script></body></html>"""







if __name__ == "__main__":
    import threading
    print(f"[coach-server] agent dir: {AGENT}")
    print(f"[coach-server] llm: {LLM_MODEL} @ {LLM_URL}")
    print(f"[coach-server] vision: {VISION_MODEL}")
    print(f"[coach-server] UI: http://127.0.0.1:{PORT}/")
    if MM_ENABLED:
        threading.Thread(target=mm_watch_loop, daemon=True).start()
        print(f"[coach-server] MiniMax watch loop ON every {WATCH_EVERY}s")
    threading.Thread(target=health_watch_loop, daemon=True).start()
    ThreadingHTTPServer(("127.0.0.1", PORT), H).serve_forever()
