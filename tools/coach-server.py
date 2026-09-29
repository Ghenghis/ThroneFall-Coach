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
import base64, json, os, sys, time, urllib.request, urllib.error, pathlib, glob
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
PORT = 8099
if "--port" in sys.argv:
    PORT = int(sys.argv[sys.argv.index("--port") + 1])

# ── MiniMax live-watch loop ──────────────────────────────────────────────
# MiniMax observes telemetry every MM_WATCH_SECS, proposes ONE bounded
# steering patch, we validate+clamp it, write coach-commands.json, and the
# plugin applies within ~4 s. Everything is logged with proof.
MM_URL = "https://api.minimax.io/v1/chat/completions"
MM_MODEL = os.environ.get("MINIMAX_MODEL", "MiniMax-M3")
WATCH_EVERY = float(os.environ.get("MM_WATCH_SECS", "50"))
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

def mm_chat(messages, max_tokens=900):
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
    return out["choices"][0]["message"]["content"], out.get("usage", {})

MM_SYS = """You are MiniMax Watch — a strict live steering advisor for a
Thronefall autopilot. You see real telemetry and may adjust the bot's
STRATEGY KNOBS ONLY (never cheats, never code). Reply with ONLY a JSON
object, no prose outside it:
{"squad_size":0,"reserve_size":0,"escort_size":0,"army_target":0,
 "build_focus":"military|income|defense|balanced",
 "hero_posture":"builder|fighter","night_call":false,
 "note":"<one sentence: what you changed and why>"}
Rules: use 0/false for "no change"; squad 1-8, reserve 0-10, escort 0-6,
army_target 0-60; build_focus must be one of the listed words; only change
what the telemetry justifies. If nothing needs changing return {}.
"""

# Strict validation — only these keys, clamped ranges, enum values only.
MM_FIELDS = {
    "squad_size":   (int,  (0, 8)),
    "reserve_size": (int,  (0, 10)),
    "escort_size":  (int,  (0, 6)),
    "army_target":  (int,  (0, 60)),
    "build_focus":  (str,  {"military", "income", "defense", "balanced"}),
    "hero_posture": (str,  {"builder", "fighter"}),
    "night_call":   (bool, None),
    "note":         (str,  160),
}
def validate_patch(obj):
    if not isinstance(obj, dict):
        return None
    out = {}
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
        with open(MMWATCH, "a", encoding="utf-8") as f:
            f.write(json.dumps(entry) + "\n")
    except Exception:
        pass
    # mirror into the chat stream so the user sees steering live
    tag = "applied" if entry.get("applied") else ("rejected" if not entry.get("patch") else "advised")
    append_log("mm", f"[mm-watch {tag}] {entry.get('patch') or entry.get('raw','')[:140]} :: {entry.get('note','')}")

def mm_watch_loop():
    """Continuously: observe -> MiniMax -> validate -> command -> proof."""
    mm_watch_loop.last_patch = ""
    mm_watch_loop.last_raw = ""
    last_sig = ""
    while True:
        try:
            st = live_state()
            if not st.get("live"):
                time.sleep(8); continue
            # Skip mid-call spam: only re-steer when something moved
            sig = (st.get("mode"), st.get("night"), st.get("ally", 0))
            urgent = st.get("red") or (st.get("night") and st.get("doors_cov", 0) == 0)
            if sig == last_sig and not urgent:
                time.sleep(WATCH_EVERY); continue
            last_sig = sig
            m = metrics()
            audit = {}
            af = AGENT / "audit.json"
            if af.exists():
                try: audit = json.loads(af.read_text(errors="replace"))
                except Exception: pass
            prompt = (
                "TELEMETRY: " + json.dumps(st, separators=(",", ":")) +
                "\nACTION: " + json.dumps({k: audit.get(k) for k in
                    ("mode", "mode_since", "cur_build", "doors_cov",
                     "ally", "free", "night", "wave", "red")}) +
                "\nPLAYBOOK CHECKLIST: " + json.dumps(
                    [c for c in audit.get("checklist", []) if not c.get("done")][:5]) +
                "\nALERTS: " + json.dumps(audit_alerts(audit)[:4]) +
                "\nGRADES: " + json.dumps(m.get("grades", {})) +
                "\nWEAKNESSES: " + json.dumps(m.get("weaknesses", [])[:3]) +
                "\nCorrect the FAILED checklist items. Respond JSON only.")
            reply, usage = mm_chat(
                [{"role": "system", "content": MM_SYS},
                 {"role": "user", "content": prompt}])
            # extract first {...} block
            i0, i1 = reply.find("{"), reply.rfind("}")
            patch = validate_patch(
                json.loads(reply[i0:i1 + 1])) if 0 <= i0 < i1 else None
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
                    mm_watch_loop.last_patch = sig
                    if patch:
                        CMDFILE.write_text(json.dumps(patch))
                        entry["note"] = note
                        _watch_log(entry)
                        time.sleep(6)
                        st2 = live_state()
                        # applied = the patch reached the file + the game
                        # ticked on (mode/ally/anything moved since).
                        moved = any(st2.get(k) != st.get(k)
                                    for k in ("mode", "ally", "doors_cov",
                                              "army_target", "night"))
                        entry["applied"] = moved
                        entry["after"] = {"army_target": st2.get("army_target"),
                                          "mode": st2.get("mode")}
                        _watch_log({"t": round(time.time(), 1),
                                    "kind": "proof", **entry})
            else:
                entry["note"] = "no-change or unparseable"
                if entry.get("raw") and entry["raw"] != mm_watch_loop.last_raw:
                    mm_watch_loop.last_raw = entry["raw"]
                    _watch_log(entry)
        except Exception as ex:
            _watch_log({"t": round(time.time(), 1), "error": str(ex)})
        time.sleep(WATCH_EVERY)


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
    runs = sorted(glob.glob(str(AGENT / "runs" / "*")))
    return pathlib.Path(runs[-1]) if runs else None

def live_state():
    st = {"live": False}
    run = latest_run()
    if not run: return st
    ticks = run / "ticks.jsonl"
    if ticks.exists():
        lines = ticks.read_text(errors="replace").strip().splitlines()
        if lines:
            try:
                last = json.loads(lines[-1])
                st.update({"live": True, "run": run.name, "t": last.get("t"),
                    "mode": last.get("mode"), "gold": last.get("gold"),
                    "foes": last.get("foes"), "night": last.get("night"),
                    "ally": last.get("ally"), "free": last.get("free"),
                    "doors_cov": last.get("drc"), "doors": last.get("drn"),
                    "army_target": last.get("at"), "red": last.get("ra"),
                    "hp": last.get("hp")})
            except Exception: pass
        notes = run / "notes.jsonl"
        if notes.exists():
            nl = notes.read_text(errors="replace").strip().splitlines()[-8:]
            st["notes"] = [json.loads(x).get("note", "?") for x in nl
                           if x.strip().startswith("{")]
    return st

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
    if ms > 90 and a.get("mode") in ("SpendGold", "Idle", "HoldCastle"):
        out.append({"sev": "warn", "msg": f"stuck in {a.get('mode')} for {ms:.0f}s"})
    cats = a.get("cat_built", {})
    if a.get("t", 0) > 400 and cats.get("wall", 0) == 0:
        out.append({"sev": "warn", "msg": "no walls built yet"})
    if a.get("t", 0) > 300 and cats.get("military", 0) == 0:
        out.append({"sev": "crit", "msg": "NO troop buildings built — army can't grow"})
    if a.get("breaches", 0) > 0:
        out.append({"sev": "info", "msg": f"{a['breaches']} door breach(es) this run"})
    return out

def append_log(role, text):
    CHATLOG.parent.mkdir(parents=True, exist_ok=True)
    with open(CHATLOG, "a", encoding="utf-8") as f:
        f.write(json.dumps({"t": time.time(), "role": role,
                            "text": text[:8000]}) + "\n")

def extract_cmd(reply):
    i0 = reply.find("<cmd>")
    i1 = reply.find("</cmd>")
    if i0 < 0 or i1 <= i0: return None, reply
    raw = reply[i0 + 5:i1]
    try:
        cmd = json.loads(raw[raw.find("{"):raw.rfind("}") + 1])
        cmd["note"] = cmd.get("note", "") or "user-directed"
        CMDFILE.write_text(json.dumps(cmd, indent=1))
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
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/" or self.path.startswith("/index"):
            self._send(200, PAGE, "text/html; charset=utf-8")
        elif self.path == "/state":
            self._send(200, json.dumps(live_state()), "application/json")
        elif self.path == "/live.png":
            p = AGENT / "live.png"
            if p.exists():
                try:
                    self._send(200, p.read_bytes(), "image/png")
                except PermissionError:
                    # plugin mid-write — serve the last good frame
                    self._send(204, "")
            else:
                self._send(404, "no frame yet")
        elif self.path == "/audit":
            p = AGENT / "audit.json"
            if p.exists():
                try:
                    a = json.loads(p.read_text(errors="replace"))
                    a["alerts"] = audit_alerts(a)
                    a["age_s"] = round(time.time() - p.stat().st_mtime, 1)
                    self._send(200, json.dumps(a), "application/json")
                except Exception as e:
                    self._send(500, json.dumps({"error": str(e)}), "application/json")
            else:
                self._send(404, "{}")
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
                lines = MMWATCH.read_text(errors="replace").strip().splitlines()[-30:]
                self._send(200, json.dumps([json.loads(x) for x in lines
                                            if x.strip().startswith("{")]),
                           "application/json")
            else:
                self._send(200, "[]", "application/json")
        elif self.path.startswith("/playbook"):
            scene = ""
            if "?" in self.path and "scene=" in self.path:
                scene = self.path.split("scene=")[1].split("&")[0]
            if not scene:
                st = live_state()
                scene = (st.get("run") or "").split("-", 1)[-1]
            pb = AGENT / "botpack" / f"strategy_{scene.lower()}.json"
            self._send(200, json.dumps({
                "scene": scene,
                "playbook": readj(pb, None),
                "raw": pb.read_text(errors="replace") if pb.exists() else ""}),
                "application/json")
        elif self.path == "/history":
            if CHATLOG.exists():
                lines = CHATLOG.read_text(errors="replace").strip().splitlines()[-60:]
                self._send(200, json.dumps([json.loads(x) for x in lines
                                            if x.strip().startswith("{")]),
                           "application/json")
            else:
                self._send(200, "[]", "application/json")
        else:
            self._send(404, "?")

def readj(p, dflt):
    try:
        return json.loads(pathlib.Path(p).read_text(errors="replace"))
    except Exception:
        return dflt

def metrics():
    """Full dashboard payload — grades, learning, weaknesses, curve."""
    m = {"learning": {}, "grades": {}, "weaknesses": [], "runs": [],
         "mishaps": readj(AGENT / "mishaps.json", []) or []}
    m["learning"]["policy"] = readj(AGENT / "policystats.json", {})
    m["learning"]["net"] = readj(AGENT / "netstats.json", {})
    # dataset volume + outcome split
    rows = wins = defs = 0
    for f in glob.glob(str(AGENT / "dataset" / "*.jsonl")):
        for line in open(f, errors="replace"):
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
        ev = rd / "events.jsonl"
        if ev.exists():
            for nl in open(ev, errors="replace"):
                try: e = json.loads(nl)
                except Exception: continue
                if e.get("note") in ("victory", "defeat"):
                    outcome = e["note"]
        scene = rd.name.split("-", 1)[-1]
        if outcome == "defeat":
            defeats_scene[scene] = defeats_scene.get(scene, 0) + 1
        for line in open(ticks, errors="replace"):
            try: t = json.loads(line)
            except Exception: continue
            n += 1
            if t.get("night"): night_t += 1
            if t.get("mode") == "SpendGold": spend += 1
            if t.get("ra"): ra += 1
            if (t.get("drn") or 0) > 0:
                cov += (t.get("drc") or 0) / t["drn"]
            if (t.get("at") or 0) > 0:
                ally_rat += min(1.0, (t.get("ally") or 0) / t["at"])
            hp_sum += t.get("hp") or 0
            try: wave_max = max(wave_max, float(t.get("wave") or 0))
            except Exception: pass
        if n == 0: continue
        days = max(1, night_t)
        e_g = min(100, spend / n * 250 + 40)
        d_g = min(100, (cov / n) * 100 + (1 - ra / n) * 40)
        a_g = min(100, (ally_rat / n) * 140)
        h_g = min(100, (hp_sum / n) * 80 + (outcome != "defeat") * 20)
        s_g = min(100, wave_max * 8 + (outcome == "victory") * 30)
        for k, v in (("econ", e_g), ("def", d_g), ("army", a_g),
                     ("hero", h_g), ("surv", s_g)):
            cat[k].append(v)
        curve.append({"run": rd.name, "scene": scene, "outcome": outcome,
                      "wave": wave_max, "ticks": n,
                      "score": round((e_g + d_g + a_g + h_g + s_g) / 5)})
    m["curve"] = curve
    m["grades"] = {k: round(sum(v) / len(v)) if v else 0
                   for k, v in cat.items()}
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
        tail = log.read_text(errors="replace")[-400000:]
        import re
        for mm in re.finditer(r"BREACH on door '([^']+)'", tail):
            ln = mm.group(1)
            breaches_line[ln] = breaches_line.get(ln, 0) + 1
        squads = len(re.findall(r"posted squad \d+/\d+", tail))
    m["breach_doors"] = sorted(breaches_line.items(), key=lambda x: -x[1])[:6]
    m["squads_posted"] = squads
    return m

    def do_POST(self):
        if self.path == "/regen":
            n = int(self.headers.get("Content-Length", 0))
            try:
                data = json.loads(self.rfile.read(n) or b"{}")
                scene = data.get("scene") or "Durststein"
                import subprocess
                subprocess.Popen(
                    ["python", str(ROOT / "tools" / "mm-coach.py"),
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
            "grades": metrics()["grades"] if self.path == "/chat" else {}}
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
            append_log("error", str(ex))
            self._send(200, json.dumps({"reply": f"(LLM unreachable: {ex})",
                                        "cmd": None, "state": st}),
                       "application/json")

PAGE = r"""<!DOCTYPE html><html><head><meta charset="utf-8"><title>Thronefall Coach</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
/* Thronefall palette — night-brown bg, parchment cards, crown-gold accent */
:root{--bg:#1a1210;--rail:#150e0b;--side:#201612;--main:#231912;--card:#2c2118;
 --bord:rgba(240,179,94,.14);--acc:#f0b35e;--acc2:#e8a33d;--ok:#7bc96f;
 --warn:#e8a33d;--bad:#e0604f;--txt:#f3e7cf;--dim:#a08a6e;--teal:#3fa9a0}
*{box-sizing:border-box}
html,body{height:100%}
body{margin:0;font-family:'Segoe UI',system-ui,sans-serif;background:var(--bg);
 color:var(--txt);display:flex;overflow:hidden;font-size:13.5px}
button{background:none;border:0;color:var(--txt);cursor:pointer;font-family:inherit}
::selection{background:rgba(240,179,94,.3)}
/* ── icon rail ─────────────────────────────────────────── */
#rail{width:54px;background:var(--rail);border-right:1px solid var(--bord);
 display:flex;flex-direction:column;align-items:center;padding:12px 0;gap:7px;flex:none}
#rail .lg{font-size:22px;margin-bottom:10px;filter:drop-shadow(0 2px 3px rgba(0,0,0,.6))}
#rail .ri{width:40px;height:40px;border-radius:10px;display:flex;align-items:center;
 justify-content:center;font-size:17px;color:var(--dim);border:1px solid transparent}
#rail .ri:hover{background:#2c2118;color:var(--txt)}
#rail .ri.on{background:#3a2b1c;color:var(--acc);border-color:rgba(240,179,94,.35);
 box-shadow:0 0 12px rgba(240,179,94,.15)}
/* ── sidebar ───────────────────────────────────────────── */
#side{width:232px;background:var(--side);border-right:1px solid var(--bord);
 display:flex;flex-direction:column;flex:none}
#side .sh{padding:11px 10px 7px;display:flex;gap:7px;align-items:center}
#side .sh input{flex:1;background:#150e0a;border:1px solid var(--bord);border-radius:8px;
 padding:7px 10px;color:var(--txt);font-size:12.5px;outline:0}
#side .sh input:focus{border-color:var(--acc)}
#runlist{flex:1;overflow-y:auto;padding:5px 6px}
.rl{display:flex;flex-direction:column;gap:3px;padding:9px 10px;border-radius:9px;
 cursor:pointer;margin-bottom:3px;border:1px solid transparent}
.rl:hover{background:#2a1f16}
.rl.on{background:#332616;border-color:rgba(240,179,94,.4)}
.rl .rn{font-size:12.5px;font-weight:600;display:flex;align-items:center;gap:7px}
.rl .rm{font-size:10.5px;color:var(--dim)}
.dot{width:8px;height:8px;border-radius:50%;flex:none;box-shadow:0 0 5px currentColor}
.dot.run{background:var(--acc2);color:var(--acc2)}
.dot.win{background:var(--ok);color:var(--ok)}
.dot.lose{background:var(--bad);color:var(--bad)}
#side .ft{padding:9px 11px;border-top:1px solid var(--bord);font-size:10.5px;color:var(--dim)}
/* ── main ──────────────────────────────────────────────── */
#main{flex:1;display:flex;flex-direction:column;min-width:0}
#hd{height:50px;border-bottom:1px solid var(--bord);display:flex;align-items:center;
 gap:10px;padding:0 16px;flex:none;background:#1c1410}
#hd .t{font-weight:700;font-size:15px;color:var(--acc);letter-spacing:.3px}
.chip{background:#2c2118;border:1px solid var(--bord);border-radius:20px;
 padding:4px 11px;font-size:11px;color:var(--dim)}
.chip.on{color:var(--ok);border-color:rgba(123,201,111,.45)}
.chip.mm{color:#f0d5a0;border-color:rgba(240,179,94,.45)}
#hd .sp{flex:1}
/* feed — parchment-y bubbles */
#feed{flex:1;overflow-y:auto;padding:18px;display:flex;flex-direction:column;gap:11px;
 background:
 radial-gradient(ellipse at 20% -10%,rgba(240,179,94,.05),transparent 50%),var(--main)}
.m{max-width:78%;padding:10px 14px;border-radius:13px;line-height:1.45;
 white-space:pre-wrap;font-size:13.5px;animation:pop .15s}
@keyframes pop{from{opacity:0;transform:translateY(4px)}to{opacity:1}}
.m.u{align-self:flex-end;background:#46311f;
 border:1px solid rgba(240,179,94,.3)}
.m.a{align-self:flex-start;background:var(--card);border:1px solid var(--bord)}
.m.c{align-self:flex-start;background:#201a12;border-left:3px solid var(--acc);
 font-size:11.5px;color:#c9b088}
.m.mm{align-self:flex-start;background:#1a1f2e;border-left:3px solid var(--teal);
 font-size:11.5px;color:#9ec8c4}
.m .who{display:block;font-size:9.5px;color:var(--dim);margin-bottom:3px;
 text-transform:uppercase;letter-spacing:.6px}
/* composer — chunky bar like the game's UI */
#cmp{margin:0 18px 15px;background:var(--card);border:1px solid rgba(240,179,94,.25);
 border-radius:14px;padding:11px 12px;display:flex;gap:8px;align-items:flex-end;
 flex:none;box-shadow:0 -4px 18px rgba(0,0,0,.3)}
#cmp .cb{width:35px;height:35px;border-radius:9px;display:flex;align-items:center;
 justify-content:center;font-size:16px;color:var(--dim)}
#cmp .cb:hover{background:#3a2b1c;color:var(--acc)}
#cmp .cb.on{color:var(--acc)}
#txt{flex:1;background:none;border:0;outline:0;color:var(--txt);font-size:13.5px;
 resize:none;max-height:120px;font-family:inherit;padding:8px 0}
#txt::placeholder{color:#6e5c44}
#send{background:linear-gradient(180deg,#f5c06a,#d9912e);border-radius:10px;
 padding:9px 18px;font-weight:700;font-size:12.5px;color:#241505;
 text-shadow:0 1px 0 rgba(255,255,255,.3);box-shadow:0 2px 0 #8a5c1e}
#send:hover{filter:brightness(1.1)}
#send:active{transform:translateY(1px);box-shadow:0 1px 0 #8a5c1e}
/* ── right tool drawer ─────────────────────────────────── */
#panel{width:0;overflow:hidden;border-left:1px solid var(--bord);background:var(--main);
 display:flex;flex-direction:column;transition:width .15s;flex:none}
#panel.open{width:350px}
#phd{height:50px;border-bottom:1px solid var(--bord);display:flex;align-items:center;
 padding:0 14px;font-weight:700;font-size:13px;gap:8px;flex:none;color:var(--acc);
 background:#1c1410}
#pbody{flex:1;overflow-y:auto;padding:12px}
.pane{display:none}.pane.on{display:block}
.card{background:var(--card);border:1px solid var(--bord);border-radius:11px;
 padding:11px 13px;margin-bottom:9px}
.card h4{margin:0 0 6px;font-size:10.5px;color:var(--acc2);text-transform:uppercase;
 letter-spacing:.8px;font-weight:700}
.kv{display:flex;justify-content:space-between;font-size:12.5px;padding:4px 0;
 border-bottom:1px solid rgba(240,179,94,.08)}
.kv:last-child{border-bottom:0}
.kv b{color:var(--acc)}
.gA{color:#7bc96f}.gB{color:#a5d977}.gC{color:#e8a33d}.gD{color:#e0804f}.gF{color:#e5534b}
.wk{background:var(--card);border-left:3px solid var(--bad);border-radius:8px;
 padding:9px 11px;margin-bottom:8px;font-size:12.5px}
.wk b{color:var(--bad)}
.hint{color:var(--dim);font-size:11px;margin-top:4px}
pre.book{background:#150e0a;border:1px solid var(--bord);border-radius:10px;
 padding:11px;font-size:11px;white-space:pre-wrap;color:#d8c49a;max-height:60vh;
 overflow-y:auto;line-height:1.55}
#view{position:relative;margin-bottom:9px}
#shot{width:100%;border-radius:10px;border:1px solid rgba(240,179,94,.25);display:block}
#draw{position:absolute;left:0;top:0;cursor:crosshair}
.pb{display:flex;gap:7px}
.pb button{flex:1;background:#332617;border:1px solid var(--bord);border-radius:9px;
 padding:8px;font-size:11.5px;color:var(--txt)}
.pb button:hover{border-color:var(--acc);color:var(--acc)}
/* scrollbar — thronefall thin gold */
::-webkit-scrollbar{width:9px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:#3d2c1b;border-radius:5px}
::-webkit-scrollbar-thumb:hover{background:#52402a}
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
 <div class="sh"><input id="rq" placeholder="Search runs" oninput="runs()"></div>
 <div id="runlist"></div>
 <div class="ft" id="sideft">runs loading…</div>
</div>
<div id="main">
 <div id="hd">
  <div class="t">&#128081; Thronefall Coach</div>
  <span class="chip" id="stchip">offline</span>
  <span class="chip mm" id="mmchip">MiniMax · idle</span>
  <div class="sp"></div>
  <span class="chip" id="modechip">—</span>
 </div>
 <div id="feed"></div>
 <div id="cmp">
  <button class="cb" onclick="document.getElementById('file').click()" title="attach image">&#128206;</button>
  <input type="file" id="file" accept="image/*" style="display:none" onchange="attach(this)">
  <button class="cb" id="mic" title="voice">&#127908;</button>
  <button class="cb" id="tts" title="speak replies" onclick="ttsOn=!ttsOn;this.classList.toggle('on',ttsOn)">&#128266;</button>
  <textarea id="txt" rows="1" placeholder="Command the realm…"></textarea>
  <button id="send" onclick="send()">Send</button>
 </div>
</div>
<div id="panel"><div id="phd"><span id="pttl">Live</span><div class="sp" style="flex:1"></div>
 <button onclick="tool('chat')" style="color:var(--dim)">&#10005;</button></div>
 <div id="pbody">
  <div class="pane" id="p-live">
   <div id="state2" class="hint" style="margin-bottom:7px"></div>
   <div id="view"><img id="shot" src="/live.png"><canvas id="draw"></canvas></div>
   <div class="pb"><button onclick="clearInk()">Clear ink</button>
    <button onclick="sendShot()">Send annotated</button></div>
  </div>
  <div class="pane" id="p-stats">
   <div class="card"><h4>Grades</h4><div id="gradeCards"></div></div>
   <div class="card"><h4>Learning</h4><div id="learnKV"></div></div>
   <div class="card"><h4>Reward curve</h4><canvas id="curve" style="width:100%;height:130px"></canvas>
    <div class="hint" id="trendline"></div></div>
  </div>
  <div class="pane" id="p-book">
   <div class="pb" style="margin-bottom:9px"><button onclick="book()">Refresh</button>
    <button onclick="regen()">&#10227; MiniMax rewrite</button></div>
   <pre class="book" id="book">loading…</pre>
  </div>
  <div class="pane" id="p-weak">
   <div class="card"><h4>Weaknesses</h4><div id="weak"></div></div>
   <div class="card"><h4>Breach-prone doors</h4><div id="breachTbl"></div></div>
   <div class="card"><h4>Never-retry memory</h4><div id="mish" class="hint"></div></div>
  </div>
  <div class="pane" id="p-audit">
   <div class="card"><h4>Right now</h4><div id="auNow"></div></div>
   <div class="card"><h4>Alerts</h4><div id="auAlert"></div></div>
   <div class="card"><h4>Playbook checklist</h4><div id="auCheck"></div></div>
   <div class="card"><h4>Door posts</h4><div id="auDoor"></div></div>
   <div class="card"><h4>Built so far</h4><div id="auCat"></div></div>
  </div>
 </div>
</div>
<script>
let ttsOn=false, strokes=[], pending=null, cur=null, runRows=[];
const feed=document.getElementById('feed'), txt=document.getElementById('txt');
const shot=document.getElementById('shot'), cv=document.getElementById('draw');
function esc(s){const d=document.createElement('div');d.textContent=s;return d.innerHTML}
function add(role,text,who){
 const d=document.createElement('div');d.className='m '+(role=='mm'?'mm':role);
 d.innerHTML=(who?`<span class="who">${who}</span>`:'')+esc(text);
 feed.appendChild(d);feed.scrollTop=feed.scrollHeight;
 if(role=='a'&&ttsOn){const u=new SpeechSynthesisUtterance(text);u.rate=1.05;speechSynthesis.speak(u)}}
async function j(u,o){const r=await fetch(u,o);return r.json()}
async function send(){
 const m=txt.value.trim();if(!m&&!pending)return;txt.value='';txt.style.height='auto';
 add('u',m+(pending?' [image]':''),'you');
 const body={message:m||'look at this'};if(pending){body.image=pending;pending=null}
 const r=await j('/chat',{method:'POST',body:JSON.stringify(body)});
 add('a',r.reply,'Grandmaster');if(r.cmd)add('c','BOT ORDERED: '+JSON.stringify(r.cmd),'order')}
txt.addEventListener('input',()=>{txt.style.height='auto';txt.style.height=Math.min(120,txt.scrollHeight)+'px'});
txt.addEventListener('keydown',e=>{if(e.key=='Enter'&&!e.shiftKey){e.preventDefault();send()}});
/* tool drawer */
function tool(t){
 const p=document.getElementById('panel');
 const names={chat:'',live:'Live View',stats:'Stats',book:'Playbook',weak:'Weaknesses',audit:'Audit'};
 if(t=='chat'){p.classList.remove('open');return}
 p.classList.add('open');document.getElementById('pttl').textContent=names[t];
 document.querySelectorAll('.pane').forEach(x=>x.classList.remove('on'));
 document.getElementById('p-'+t).classList.add('on');
 document.querySelectorAll('#rail .ri').forEach((b,i)=>b.classList.toggle('on',
   ['chat','live','stats','book','weak','audit'][i]==t));
 if(t=='book')book();else if(t=='audit')audit();else refresh();}
/* audit — what the bot is doing, proof-level */
async function audit(){try{const a=await j('/audit');
 if(a.error){document.getElementById('auNow').innerHTML='<i>'+a.error+'</i>';return}
 document.getElementById('auNow').innerHTML=[
  ['action',`<b>${a.mode}</b> for ${a.mode_since}s`],
  ['target build',a.cur_build||'—'],
  ['army',`${a.ally} (${a.free} free) vs target`],
  ['wave',`${a.wave}/${a.wave_total}`],
  ['doors',`${a.doors_cov}/${a.doors} covered`],
  ['data age',`${a.age_s}s ago`]
 ].map(([k,v])=>`<div class="kv"><span>${k}</span><b>${v}</b></div>`).join('');
 const al=a.alerts||[];
 document.getElementById('auAlert').innerHTML=al.length?
  al.map(x=>`<div class="wk" style="border-color:${x.sev=='crit'?'#e5534b':x.sev=='warn'?'#e8a33d':'#3fa9a0'}">
   <b>${x.sev}</b> ${x.msg}</div>`).join(''):'<div class="hint">all clear</div>';
 document.getElementById('auCheck').innerHTML=(a.checklist||[]).map(c=>
  `<div class="kv"><span>${esc(c.n)}</span><b style="color:${c.done?'#7bc96f':'#e5534b'}">${c.done?'✓':'✗'}</b></div>`).join('')
  ||'<div class="hint">no playbook</div>';
 const du=a.door_units||[],dl=a.door_lines||[];
 document.getElementById('auDoor').innerHTML=dl.length?dl.map((l,i)=>
  `<div class="kv"><span>${l}</span><b style="color:${du[i]>0?'#7bc96f':'#e5534b'}">${du[i]||0} units</b></div>`).join('')
  :'<div class="hint">—</div>';
 document.getElementById('auCat').innerHTML=Object.entries(a.cat_built||{}).map(([k,v])=>
  `<div class="kv"><span>${k}</span><b>${v}</b></div>`).join('')||'<div class="hint">nothing built yet</div>';
}catch(e){}}
setInterval(()=>{if(document.getElementById('p-audit').classList.contains('on'))audit()},4000);
/* state → header chips + side footer */
async function state(){try{const s=await j('/state');
 const c=document.getElementById('stchip');
 if(s.live){c.textContent='LIVE · '+s.run.split('-').pop();c.classList.add('on');
  document.getElementById('modechip').textContent=
   `${s.mode} | gold ${s.gold} | ally ${s.ally} | doors ${s.doors_cov}/${s.doors} | at ${s.army_target}`;
  document.getElementById('state2').textContent=
   `t=${s.t} mode=${s.mode} gold=${s.gold} foes=${s.foes} night=${s.night} ally=${s.ally} free=${s.free} doors=${s.doors_cov}/${s.doors} at=${s.army_target} red=${s.red}`;
 }else{c.textContent='offline';c.classList.remove('on');
  document.getElementById('modechip').textContent='—'}}catch(e){}}
setInterval(state,4000);setInterval(()=>{shot.src='/live.png?x='+Date.now()},2000);
/* history feed — mm-watch entries get their own styling */
(async()=>{const h=await j('/history');h.forEach(x=>{
 const r=x.role=='user'?'u':x.role=='assistant'?'a':x.role=='mm'?'mm':'c';
 const w=x.role=='user'?'you':x.role=='assistant'?'Grandmaster':x.role=='mm'?'MiniMax Watch':'system';
 add(r,x.text,w)})})();
/* runs sidebar */
async function runs(){
 try{const m=await j('/metrics');runRows=(m.curve||[]).slice(-40).reverse();
 const q=document.getElementById('rq').value.toLowerCase();
 document.getElementById('runlist').innerHTML=runRows
  .filter(r=>!q||(r.scene||'').toLowerCase().includes(q))
  .map((r,i)=>`<div class="rl ${i==0?'on':''}" onclick="pickRun(${i})">
   <span class="rn"><span class="dot ${r.outcome=='victory'?'win':r.outcome=='defeat'?'lose':'run'}"></span>
   ${r.scene||'unknown'}</span>
   <span class="rm">${r.outcome} · wave ${r.wave} · score ${r.score}</span></div>`).join('');
 document.getElementById('sideft').textContent=`${runRows.length} runs · squads ${m.squads_posted} · memory ${(m.mishaps||[]).length}`;}catch(e){}}
function pickRun(i){const r=runRows[i];if(!r)return;
 document.querySelectorAll('.rl').forEach((x,j)=>x.classList.toggle('on',j==i));
 add('c',`run ${r.scene} · ${r.outcome} · wave ${r.wave} · score ${r.score}`,'run')}
setInterval(runs,15000);
/* metrics → stats/weak panes */
function gc(v){return v>=80?'gA':v>=60?'gB':v>=40?'gC':v>=20?'gD':'gF'}
async function refresh(){try{const m=await j('/metrics');
 const names={econ:'Economy',def:'Defense',army:'Army',hero:'Hero safety',surv:'Progression'};
 document.getElementById('gradeCards').innerHTML=Object.entries(names).map(([k,n])=>{
  const v=m.grades[k]||0;return `<div class="kv"><span>${n}</span><b class="${gc(v)}">${v}</b></div>`}).join('');
 const L=m.learning||{},P=L.policy||{},N=L.net||{},D=L.dataset||{};
 document.getElementById('learnKV').innerHTML=[
  ['dataset rows',D.rows??0],['wins / defeats',`${D.wins??0} / ${D.defeats??0}`],
  ['policy states',P.states??0],['Q cells',P.cells??0],['decisions',P.decisions??0],
  ['mean |Q|',P.mean_abs_q??0],['ε',P.epsilon??'—'],
  ['net agree',N.ratio!==undefined?(N.ratio*100).toFixed(0)+'%':'—']]
  .map(([k,v])=>`<div class="kv"><span>${k}</span><b>${v}</b></div>`).join('');
 document.getElementById('trendline').textContent=
  `trend ${m.trend>=0?'+':''}${m.trend} · net: ${N.last_net||'—'} vs bot ${N.last_bot||'—'} conf ${N.conf||0}`;
 document.getElementById('weak').innerHTML=(m.weaknesses||[]).length?
  m.weaknesses.map(w=>`<div class="wk"><b>${w.type}</b> — ${w.where} (${w.count})<div class="hint">→ ${w.fix}</div></div>`).join('')
  :'<div class="hint">none detected</div>';
 document.getElementById('breachTbl').innerHTML=(m.breach_doors||[]).map(([d,c])=>
  `<div class="kv"><span>${d}</span><b>${c}</b></div>`).join('')||'<div class="hint">none</div>';
 document.getElementById('mish').innerHTML=(m.mishaps||[]).map(x=>`<div>• ${x}</div>`).join('')||'none yet';
 const c=document.getElementById('curve'),x=c.getContext('2d');
 const W=c.width=c.clientWidth*2,H=c.height=260;x.clearRect(0,0,W,H);
 const pts=(m.curve||[]).map(c2=>c2.score);
 if(pts.length>1){const st=(W-30)/(pts.length-1);
  x.strokeStyle='#3d2c1b';for(let g=0;g<=4;g++){x.beginPath();x.moveTo(15,10+g*(H-30)/4);x.lineTo(W-15,10+g*(H-30)/4);x.stroke()}
  x.strokeStyle='#f0b35e';x.lineWidth=3;x.beginPath();
  pts.forEach((v,i)=>{const px=15+i*st,py=10+(100-v)*(H-30)/100;i?x.lineTo(px,py):x.moveTo(px,py)});x.stroke();
  (m.curve||[]).forEach((c2,i)=>{const px=15+i*st,py=10+(100-c2.score)*(H-30)/100;
   x.fillStyle=c2.outcome=='victory'?'#7bc96f':c2.outcome=='defeat'?'#e5534b':'#a08a6e';
   x.beginPath();x.arc(px,py,4,0,7);x.fill()})}
}catch(e){}}
setInterval(()=>{if(document.getElementById('panel').classList.contains('open'))refresh()},6000);
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
/* mic */
let rec;const SR=window.SpeechRecognition||window.webkitSpeechRecognition;
if(SR){rec=new SR();rec.continuous=false;rec.interimResults=false;rec.lang='en-US';
 rec.onresult=e=>{txt.value=(txt.value+' '+e.results[0][0].transcript).trim()};
 rec.onend=()=>{document.getElementById('mic').classList.remove('on');if(txt.value.trim())send()};
 document.getElementById('mic').onclick=()=>{document.getElementById('mic').classList.add('on');rec.start()}}
else document.getElementById('mic').style.display='none';
state();runs();refresh();
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
    ThreadingHTTPServer(("127.0.0.1", PORT), H).serve_forever()
