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
PORT = 8099
if "--port" in sys.argv:
    PORT = int(sys.argv[sys.argv.index("--port") + 1])

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
                self._send(200, p.read_bytes(), "image/png")
            else:
                self._send(404, "no frame yet")
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
<style>
body{margin:0;font-family:'Segoe UI',sans-serif;background:#12141c;color:#dde;height:100vh;display:flex;flex-direction:column;max-width:100vw;overflow:hidden}
#tabs{display:flex;gap:3px;padding:6px 6px 0;flex-wrap:wrap}
#tabs button{background:#1c2233;border-radius:6px 6px 0 0;padding:6px 10px;font-size:12px}
#tabs button.on{background:#3a5ad0}
.tab{display:none;flex:1;overflow:hidden;flex-direction:column}
.tab.on{display:flex}
#log{flex:1;overflow-y:auto;display:flex;flex-direction:column;gap:6px;padding:8px}
.m{padding:7px 10px;border-radius:9px;max-width:92%;white-space:pre-wrap;font-size:13px}
.u{background:#25355a;align-self:flex-end}.a{background:#1f2b1f;align-self:flex-start}.c{background:#4a3a10;font-size:11px;align-self:flex-start}
#inp{display:flex;gap:5px;padding:8px}
#txt{flex:1;padding:8px;border-radius:8px;border:1px solid #334;background:#1a1e2c;color:#dde;font-size:13px}
button{padding:8px 10px;border-radius:8px;border:0;background:#3a5ad0;color:#fff;cursor:pointer;font-size:12px}
button.sec{background:#2a3040}
#view{position:relative;margin:8px}
#shot{width:100%;border-radius:8px;border:1px solid #334;display:block}
#draw{position:absolute;left:0;top:0;cursor:crosshair}
#state{font-size:11px;color:#9ab;padding:4px 8px;white-space:pre-wrap}
.rec{background:#a03}.rec.on{background:#d33}
.page{flex:1;overflow-y:auto;padding:10px}
.cards{display:grid;grid-template-columns:1fr 1fr;gap:8px}
.card{background:#1a1e2c;border-radius:9px;padding:9px 11px}
.card h4{margin:0 0 3px;font-size:11px;color:#8ab}
.card .g{font-size:22px;font-weight:700}
.gA{color:#5f5}.gB{color:#8d5}.gC{color:#dd5}.gD{color:#e83}.gF{color:#e55}
.bar{height:5px;background:#263;border-radius:3px;margin-top:5px;overflow:hidden}
.bar div{height:100%;background:#5f5}
.small{font-size:11px;color:#9ab}
canvas.chart{width:100%;height:150px;background:#1a1e2c;border-radius:8px;margin-top:8px}
table{width:100%;border-collapse:collapse;font-size:11.5px;margin-top:6px}
td,th{padding:3px 6px;border-bottom:1px solid #2a3040;text-align:left}
.wk{background:#1a1e2c;border-left:4px solid #e55;border-radius:6px;padding:7px 10px;margin:5px 0;font-size:12px}
.wk b{color:#e85}
.hint{color:#8ab;font-size:11px}
pre.book{background:#1a1e2c;border-radius:8px;padding:10px;font-size:11px;white-space:pre-wrap;color:#bcd}
</style></head><body>
<div id="tabs">
<button class="on" onclick="tab(0,this)">Chat</button>
<button onclick="tab(1,this)">Live</button>
<button onclick="tab(2,this)">Dash</button>
<button onclick="tab(3,this)">Learn</button>
<button onclick="tab(4,this)">Weak</button>
<button onclick="tab(5,this)">Playbook</button>
</div>
<div class="tab on" id="t0">
<div id="state">loading…</div>
<div id="log"></div>
<div id="inp">
<input id="txt" placeholder="order the bot..." autocomplete="off">
<button id="mic" class="sec rec" title="talk">&#127908;</button>
<button onclick="send()">Send</button>
<input type="file" id="file" accept="image/*" style="display:none" onchange="attach(this)">
<button class="sec" onclick="document.getElementById('file').click()">&#128206;</button>
<button id="tts" class="sec" onclick="ttsOn=!ttsOn;this.style.opacity=ttsOn?1:.4">&#128266;</button>
</div></div>
<div class="tab" id="t1"><div class="page">
<div id="state2" class="small"></div>
<div id="view"><img id="shot" src="/live.png?x=0"><canvas id="draw"></canvas></div>
<div style="display:flex;gap:6px;padding:0 8px 8px">
<button class="sec" onclick="clearInk()">Clear</button>
<button onclick="sendShot()">Send annotated</button></div>
</div></div>
<div class="tab" id="t2"><div class="page"><h4 style="margin:2px">Performance grades</h4><div class="cards" id="gradeCards"></div>
<div id="dashMeta" class="small" style="margin-top:8px"></div>
<h4 style="margin:10px 0 2px">Run history</h4><table id="runs"></table></div></div>
<div class="tab" id="t3"><div class="page">
<h4 style="margin:2px">Learning curve</h4><canvas id="curve" class="chart"></canvas>
<h4 style="margin:10px 0 2px">Learner stats</h4><div class="cards" id="learnCards"></div>
<div id="netline" class="small" style="margin-top:8px"></div></div></div>
<div class="tab" id="t4"><div class="page">
<h4 style="margin:2px">Weaknesses & fixes</h4><div id="weak"></div>
<h4 style="margin:10px 0 2px">Breach-prone doors</h4><table id="breachTbl"></table>
<h4 style="margin:10px 0 2px">Never-retry memory</h4><div id="mish" class="small"></div></div></div>
<div class="tab" id="t5"><div class="page">
<div style="display:flex;gap:6px;align-items:center"><h4 id="bookName" style="margin:2px">Playbook</h4>
<button class="sec" style="margin-left:auto" onclick="regen()">⟳ MiniMax regen</button></div>
<pre class="book" id="book">loading…</pre></div></div>
<script>
let ttsOn=false, strokes=[], pending=null, cur=null;
const log=document.getElementById('log'), txt=document.getElementById('txt');
const shot=document.getElementById('shot'), cv=document.getElementById('draw');
function add(role,text){const d=document.createElement('div');d.className='m '+role;d.textContent=text;log.appendChild(d);log.scrollTop=log.scrollHeight;if(role=='a'&&ttsOn)speak(text);}
function speak(t){const u=new SpeechSynthesisUtterance(t);u.rate=1.05;speechSynthesis.speak(u);}
async function j(u,o){const r=await fetch(u,o);return r.json();}
async function send(){const m=txt.value.trim();if(!m&&!pending)return;txt.value='';add('u',m+(pending?' [image]':''));const body={message:m||'look at this'};if(pending){body.image=pending;pending=null;}const r=await j('/chat',{method:'POST',body:JSON.stringify(body)});add('a',r.reply);if(r.cmd)add('c','BOT ORDERED: '+JSON.stringify(r.cmd));}
txt.addEventListener('keydown',e=>{if(e.key=='Enter')send();});
async function state(){try{const s=await j('/state');const l=s.live?(`${s.run} | t=${s.t} mode=${s.mode} gold=${s.gold} foes=${s.foes} night=${s.night} ally=${s.ally} free=${s.free} doors=${s.doors_cov}/${s.doors} at=${s.army_target} red=${s.red}`):'bot offline / no run';document.getElementById('state').textContent=l;document.getElementById('state2').textContent=l;}catch(e){}}
setInterval(state,4000);setInterval(()=>{shot.src='/live.png?x='+Date.now();},2000);
(async()=>{const h=await j('/history');h.forEach(x=>add(x.role=='user'?'u':(x.role=='assistant'?'a':'c'),x.text));})();
function fit(){cv.width=shot.clientWidth;cv.height=shot.clientHeight;redraw();}
shot.onload=fit;window.onresize=fit;
cv.onmousedown=e=>{cur={x1:e.offsetX,y1:e.offsetY,x2:e.offsetX,y2:e.offsetY};};
cv.onmousemove=e=>{if(cur){cur.x2=e.offsetX;cur.y2=e.offsetY;redraw();}};
cv.onmouseup=()=>{if(cur){strokes.push(cur);cur=null;redraw();}};
function redraw(){const c=cv.getContext('2d');c.clearRect(0,0,cv.width,cv.height);c.strokeStyle='#ff4';c.lineWidth=3;c.lineCap='round';strokes.concat(cur?[cur]:[]).forEach(s=>{c.beginPath();c.moveTo(s.x1,s.y1);c.lineTo(s.x2,s.y2);c.stroke();const a=Math.atan2(s.y2-s.y1,s.x2-s.x1);c.beginPath();c.moveTo(s.x2,s.y2);c.lineTo(s.x2-14*Math.cos(a-0.5),s.y2-14*Math.sin(a-0.5));c.moveTo(s.x2,s.y2);c.lineTo(s.x2-14*Math.cos(a+0.5),s.y2-14*Math.sin(a+0.5));c.stroke();});}
function clearInk(){strokes=[];redraw();}
function sendShot(){const c=document.createElement('canvas');c.width=shot.naturalWidth;c.height=shot.naturalHeight;const x=c.getContext('2d');x.drawImage(shot,0,0,c.width,c.height);x.strokeStyle='#ff4';x.lineWidth=5;x.lineCap='round';const sx=c.width/cv.width,sy=c.height/cv.height;strokes.forEach(s=>{x.beginPath();x.moveTo(s.x1*sx,s.y1*sy);x.lineTo(s.x2*sx,s.y2*sy);x.stroke();const a=Math.atan2((s.y2-s.y1)*sy,(s.x2-s.x1)*sx);x.beginPath();x.moveTo(s.x2*sx,s.y2*sy);x.lineTo(s.x2*sx-20*Math.cos(a-0.5),s.y2*sy-20*Math.sin(a-0.5));x.moveTo(s.x2*sx,s.y2*sy);x.lineTo(s.x2*sx-20*Math.cos(a+0.5),s.y2*sy-20*Math.sin(a+0.5));x.stroke();});pending=c.toDataURL('image/png').split(',')[1];add('c','shot attached — write your order & Send');tab(0,document.querySelector('#tabs button'));}
function attach(f){const r=new FileReader();r.onload=()=>{pending=r.result.split(',')[1];add('c','file attached — write your order & hit Send');};if(f.files[0])r.readAsDataURL(f.files[0]);f.value='';}
let rec;const SR=window.SpeechRecognition||window.webkitSpeechRecognition;
if(SR){rec=new SR();rec.continuous=false;rec.interimResults=false;rec.lang='en-US';
rec.onresult=e=>{txt.value=(txt.value+' '+e.results[0][0].transcript).trim();};
rec.onend=()=>{document.getElementById('mic').classList.remove('on');if(txt.value.trim())send();};
document.getElementById('mic').onclick=()=>{document.getElementById('mic').classList.add('on');rec.start();};}else{document.getElementById('mic').style.display='none';}
// ---- tabs + dashboard ----
function tab(i,el){document.querySelectorAll('.tab').forEach(t=>t.classList.remove('on'));document.querySelectorAll('#tabs button').forEach(b=>b.classList.remove('on'));document.getElementById('t'+i).classList.add('on');el.classList.add('on');if(i==5)book();else refresh();}
function gc(v){return v>=80?'gA':v>=60?'gB':v>=40?'gC':v>=20?'gD':'gF';}
async function refresh(){try{const m=await j('/metrics');dash(m);}catch(e){}}
setInterval(()=>{if(document.querySelector('.tab.on').id!='t0')refresh();},5000);
async function book(){try{const b=await j('/playbook');document.getElementById('bookName').textContent='PLAYBOOK — '+b.scene;document.getElementById('book').textContent=b.raw||'no playbook for this scene';}catch(e){}}
async function regen(){document.getElementById('book').textContent='MiniMax is writing a new playbook… (10-30 s)';await j('/regen',{method:'POST',body:'{}'});setTimeout(book,15000);setTimeout(book,35000);}
function dash(m){
const names={econ:'Economy',def:'Defense',army:'Army',hero:'Hero safety',surv:'Progression'};
document.getElementById('gradeCards').innerHTML=Object.entries(names).map(([k,n])=>{
const v=m.grades[k]||0;return `<div class="card"><h4>${n}</h4><div class="g ${gc(v)}">${v}</div><div class="bar"><div style="width:${v}%"></div></div></div>`;}).join('');
const tr=m.trend!==undefined?(m.trend>=0?`▲ +${m.trend} improving`:`▼ ${m.trend} regressing`):'—';
document.getElementById('dashMeta').innerHTML=`trend: <b>${tr}</b> | squads posted: <b>${m.squads_posted}</b> | memory: <b>${(m.mishaps||[]).length}</b>`;
document.getElementById('runs').innerHTML='<tr><th>run</th><th>outcome</th><th>wave</th><th>score</th></tr>'+(m.curve||[]).slice(-20).map(c=>`<tr><td class="small">${c.scene}</td><td style="color:${c.outcome=='victory'?'#5f5':c.outcome=='defeat'?'#e55':'#9ab'}">${c.outcome}</td><td>${c.wave}</td><td class="${gc(c.score)}">${c.score}</td></tr>`).join('');
const L=m.learning||{},P=L.policy||{},N=L.net||{},D=L.dataset||{};
document.getElementById('learnCards').innerHTML=[
['Dataset rows',D.rows??0],['Wins / defeats',`${D.wins??0} / ${D.defeats??0}`],
['Policy states',P.states??0],['Q cells',P.cells??0],
['RL decisions',P.decisions??0],['Mean |Q|',P.mean_abs_q??0],
['Explore ε',P.epsilon??'—'],['Net agree',N.ratio!==undefined?(N.ratio*100).toFixed(0)+'%':'—']
].map(([k,v])=>`<div class="card"><h4>${k}</h4><div class="g" style="font-size:18px">${v}</div></div>`).join('');
document.getElementById('netline').textContent=N.last_net?`last: net='${N.last_net}' bot='${N.last_bot}' conf=${N.conf}`:'';
document.getElementById('weak').innerHTML=(m.weaknesses||[]).length?m.weaknesses.map(w=>`<div class="wk"><b>${w.type}</b> — ${w.where} (${w.count})<div class="hint">→ ${w.fix}</div></div>`).join(''):'<div class="hint">none detected</div>';
document.getElementById('breachTbl').innerHTML='<tr><th>door</th><th>breaches</th></tr>'+(m.breach_doors||[]).map(([d,c])=>`<tr><td>${d}</td><td>${c}</td></tr>`).join('');
document.getElementById('mish').innerHTML=(m.mishaps||[]).length?m.mishaps.map(x=>`<div>${x}</div>`).join(''):'<i>none yet</i>';
const c2=document.getElementById('curve');const ctx=c2.getContext('2d');const W=c2.width=c2.clientWidth*2;const H=c2.height=300;ctx.clearRect(0,0,W,H);
const pts=(m.curve||[]).map(c=>c.score);if(pts.length>1){const step=(W-40)/(pts.length-1);ctx.strokeStyle='#334';for(let g=0;g<=4;g++){ctx.beginPath();ctx.moveTo(20,20+g*(H-50)/4);ctx.lineTo(W-20,20+g*(H-50)/4);ctx.stroke();}
ctx.strokeStyle='#5af';ctx.lineWidth=3;ctx.beginPath();pts.forEach((v,i)=>{const x=20+i*step,y=20+(100-v)*(H-50)/100;i?ctx.lineTo(x,y):ctx.moveTo(x,y);});ctx.stroke();
(m.curve||[]).forEach((c,i)=>{const x=20+i*step,y=20+(100-c.score)*(H-50)/100;ctx.fillStyle=c.outcome=='victory'?'#5f5':c.outcome=='defeat'?'#e55':'#9ab';ctx.beginPath();ctx.arc(x,y,4,0,7);ctx.fill();});}
}
state();refresh();
</script></body></html>"""

if __name__ == "__main__":
    print(f"[coach-server] agent dir: {AGENT}")
    print(f"[coach-server] llm: {LLM_MODEL} @ {LLM_URL}")
    print(f"[coach-server] vision: {VISION_MODEL}")
    print(f"[coach-server] UI: http://127.0.0.1:{PORT}/")
    ThreadingHTTPServer(("127.0.0.1", PORT), H).serve_forever()
