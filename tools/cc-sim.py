#!/usr/bin/env python3
"""End-to-end simulation of the command center - no game needed, nothing in the real agent dir is touched.

    python tools/cc-sim.py                       # replay the first long pin streak of the newest Frostsee run, mock MiniMax, plugin WITHOUT act.v1
    python tools/cc-sim.py --caps act.v1         # same, but the emulated plugin supports movement commands (act)
    python tools/cc-sim.py --real-minimax --mode semi   # one pass through the REAL MiniMax API (semi = actions queued, never executed)

What happens: a scratch agent dir is created; a recorded run is replayed into it in (accelerated) real time; the REAL coach-server.py
runs against it on port 8199 with the command center on; a mock MiniMax (or the real one) answers incident wakes; an emulated plugin
confirms `act` commands in a scratch game log. Then the whole chain is asserted: incident opened -> alert -> MiniMax woken -> plan
validated -> action executed/queued/rejected -> logged on the incident, in mm-actions.jsonl and the chat feed -> visible on the API.
"""
import argparse
import glob
import http.server
import json
import os
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REAL_AGENT = os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")
PORT, MOCK_PORT = 8199, 8198
RESULTS = []


def check(name, cond, detail=""):
    RESULTS.append((bool(cond), name))
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:260]) if (detail and not cond) else ""))


def jl(path):
    out = []
    try:
        for ln in open(path, encoding="utf-8", errors="replace"):
            if ln.startswith("{"):
                try:
                    out.append(json.loads(ln))
                except Exception:
                    pass
    except OSError:
        pass
    return out


def http_json(path, port=PORT, data=None, timeout=10):
    req = urllib.request.Request("http://127.0.0.1:%d%s" % (port, path), data=json.dumps(data).encode() if data is not None else None,
                                 headers={"Content-Type": "application/json"} if data is not None else {})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read())


# ---------------------------------------------------------------------------------------------------------------- mock MiniMax
MOCK_LOG = []


def mock_plan(prompt):
    """Deterministic 'MiniMax': reads the incident package and answers like a sensible responder would."""
    if "SCHEDULED REVIEW" in prompt:
        return {"diagnosis": "Reviewed: pins concentrated on a few spots, no new pattern.", "cause": "unknown", "confidence": 0.5, "actions": []}
    i0 = prompt.find("{")
    try:
        pkg, _ = json.JSONDecoder().raw_decode(prompt[i0:])
    except Exception:
        return {"diagnosis": "unparseable package", "actions": []}
    incs = pkg.get("INCIDENTS (act on these)") or []
    actions, diag, cause = [], [], "unknown"
    for i in incs[:3]:
        ob = (i.get("obstacle") or {})
        pos = i.get("pos") or [0, 0]
        hist = i.get("history_at_spot") or []
        tried_avoid = any("avoid" in json.dumps(h.get("actions")) for h in hist)
        if i["kind"] in ("stuck", "hotspot"):
            if ob.get("immovable"):
                cause = "immovable-boundary"
                big = tried_avoid or i["kind"] == "hotspot"
                actions.append({"type": "unstick", "how": "avoid", "x": pos[0], "z": pos[1], "r": 24 if big else 14, "ttl_s": 1200 if big else 600, "why": "pinned on an immovable %s" % ob.get("class")})
                actions.append({"type": "unstick", "how": "retreat", "why": "get off the boundary"})
                if big:
                    actions.append({"type": "code_task", "title": "Target selector keeps picking targets behind the map boundary", "file": "src/Bot.cs", "function": "PickBuild/ChooseTarget",
                                    "evidence": "%s: %s strikes at one spot" % (i["id"], i.get("pins")), "fix": "skip any target whose straight path crosses a hard-parked boundary pocket"})
            else:
                cause = "player-structure"
                actions.append({"type": "unstick", "how": "retreat", "why": "walk back and re-pick"})
        elif i["kind"] == "idle":
            cause = "idle-gold"
            actions += [{"type": "unstick", "how": "clear_ignores", "why": "reset parked slots"}, {"type": "command", "patch": {"build_focus": "balanced", "note": "unstick the picker"}}]
        elif i["kind"] in ("wedge", "feed"):
            cause = "ui-wedge" if i["kind"] == "wedge" else "feed-dead"
            actions.append({"type": "ack", "note": "watching"})
        diag.append("%s %s: %s" % (i["id"], i["kind"], i.get("detail", "")[:80]))
    return {"diagnosis": "; ".join(diag) or "nothing to do", "cause": cause, "confidence": 0.8, "actions": actions[:4]}


class Mock(http.server.BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def do_POST(self):
        n = int(self.headers.get("Content-Length", 0) or 0)
        body = json.loads(self.rfile.read(n) or b"{}")
        msgs = body.get("messages", [])
        prompt = msgs[-1]["content"] if msgs else ""
        MOCK_LOG.append({"t": time.time(), "system": (msgs[0]["content"][:60] if msgs else ""), "prompt": prompt, "auth": self.headers.get("Authorization", "")[:12]})
        plan = mock_plan(prompt)
        out = {"choices": [{"message": {"content": json.dumps(plan)}}], "usage": {"total_tokens": 1234}}
        data = json.dumps(out).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


# ---------------------------------------------------------------------------------------------------------------- scratch agent + replay feeder
def pick_run():
    runs = sorted((r for r in glob.glob(os.path.join(REAL_AGENT, "runs", "*Frostsee*")) if os.path.getsize(os.path.join(r, "ticks.jsonl")) > 200000), key=os.path.getmtime)
    return runs[-1] if runs else None


def find_window(events, pad_before=45, length=130):
    """First pin streak lasting >= 8 s; returns (t_from, t_to)."""
    cur = None
    for e in events:
        n = str(e.get("note", ""))
        if n.startswith("stuck:") or n == "pin-park":
            if cur and e["t"] - cur[1] <= 8:
                cur[1] = e["t"]
            else:
                cur = [e["t"], e["t"]]
            if cur[1] - cur[0] >= 8:
                return cur[0] - pad_before, cur[0] - pad_before + length
    return None


class Feeder(threading.Thread):
    def __init__(self, scratch, src_run, t_from, t_to, speed, caps):
        super().__init__(daemon=True)
        self.agent = os.path.join(scratch, "agent")
        self.log = os.path.join(scratch, "LogOutput.log")
        self.src_ticks, self.src_events = jl(os.path.join(src_run, "ticks.jsonl")), jl(os.path.join(src_run, "events.jsonl"))
        self.t_from, self.t_to, self.speed, self.caps = t_from, t_to, speed, caps
        self.run_dir = os.path.join(self.agent, "runs", os.path.basename(src_run))
        os.makedirs(self.run_dir, exist_ok=True)
        self.done = False
        self.sim_t = t_from
        self.first_pin_wall = None
        self.cmd_seen = ""
        self.base_audit = {}
        try:
            self.base_audit = json.load(open(os.path.join(REAL_AGENT, "audit.json"), encoding="utf-8"))
        except Exception:
            pass
        for f in ("live.jpg", "live.png", "markers.json"):
            if os.path.exists(os.path.join(REAL_AGENT, f)):
                shutil.copy(os.path.join(REAL_AGENT, f), os.path.join(self.agent, f))
        open(self.log, "w").write("[Info   :ThronefallTrainer] simulated game log\n")

    def audit(self):
        a = dict(self.base_audit)
        a.update(t=self.sim_t, scene="Frostsee", since_prog=15, frame="", caps=self.caps, stuck=0, gold=1200, mode="SpendGold")
        tmp = os.path.join(self.agent, "audit.json.tmp")
        json.dump(a, open(tmp, "w"))
        os.replace(tmp, os.path.join(self.agent, "audit.json"))

    def emulated_plugin(self):
        p = os.path.join(self.agent, "coach-commands.json")
        try:
            txt = open(p, encoding="utf-8").read()
        except OSError:
            return
        if txt and txt != self.cmd_seen:
            self.cmd_seen = txt
            try:
                d = json.loads(txt)
            except Exception:
                return
            with open(self.log, "a") as f:
                if "act" in d:
                    f.write("[Info   :ThronefallTrainer] [coach] act %s %s\n" % (d["act"], json.dumps(d)))
                else:
                    f.write("[Info   :ThronefallTrainer] [coach] user-cmd -> %s\n" % json.dumps(d))

    def run(self):
        tp, ep = os.path.join(self.run_dir, "ticks.jsonl"), os.path.join(self.run_dir, "events.jsonl")
        hist = [t for t in self.src_ticks if self.t_from - 90 <= t["t"] < self.t_from]
        with open(tp, "w") as f:
            f.writelines(json.dumps(t) + "\n" for t in hist)
        open(ep, "w").close()
        nt = next((i for i, t in enumerate(self.src_ticks) if t["t"] >= self.t_from), len(self.src_ticks))
        ne = next((i for i, e in enumerate(self.src_events) if e["t"] >= self.t_from), len(self.src_events))
        start = time.time()
        while True:
            self.sim_t = self.t_from + (time.time() - start) * self.speed
            batch_t, batch_e = [], []
            while nt < len(self.src_ticks) and self.src_ticks[nt]["t"] <= self.sim_t:
                batch_t.append(self.src_ticks[nt])
                nt += 1
            while ne < len(self.src_events) and self.src_events[ne]["t"] <= self.sim_t:
                batch_e.append(self.src_events[ne])
                ne += 1
            if batch_t:
                with open(tp, "a") as f:
                    f.writelines(json.dumps(t) + "\n" for t in batch_t)
            if batch_e:
                with open(ep, "a") as f:
                    f.writelines(json.dumps(e) + "\n" for e in batch_e)
                if self.first_pin_wall is None and any(str(e.get("note", "")).startswith("stuck:") for e in batch_e):
                    self.first_pin_wall = time.time()
            self.audit()
            self.emulated_plugin()
            if self.sim_t >= self.t_to:
                self.done = True
            time.sleep(0.4)
            if self.done and time.time() - start > (self.t_to - self.t_from) / self.speed + 60:
                return


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--run")
    ap.add_argument("--speed", type=float, default=3.0)
    ap.add_argument("--caps", default="")
    ap.add_argument("--mode", default="auto")
    ap.add_argument("--real-minimax", action="store_true")
    ap.add_argument("--keep", action="store_true")
    a = ap.parse_args()

    src = a.run and os.path.join(REAL_AGENT, "runs", a.run) or pick_run()
    if not src:
        print("no Frostsee run with enough ticks found")
        return 2
    events = jl(os.path.join(src, "events.jsonl"))
    win = find_window(events)
    if not win:
        print("no pin streak >= 8 s in", src)
        return 2
    scratch = tempfile.mkdtemp(prefix="cc_sim_")
    agent = os.path.join(scratch, "agent")
    os.makedirs(agent, exist_ok=True)
    json.dump({"mode": a.mode, "interval_s": 3600, "speedrun": False, "vision_model": ""}, open(os.path.join(agent, "mm-config.json"), "w"))
    caps = [c for c in a.caps.split(",") if c]
    print("scratch:", scratch, "| source run:", os.path.basename(src), "| window t=%.0f..%.0f at x%.0f | caps=%s | mode=%s | minimax=%s" %
          (win[0], win[1], a.speed, caps, a.mode, "REAL" if a.real_minimax else "mock"))

    mock = None
    env = dict(os.environ, THRONEFALL_AGENT=agent, THRONEFALL_GAMELOG=os.path.join(scratch, "LogOutput.log"), MM_WATCH="0", CC_ENABLED="1", PYTHONUNBUFFERED="1")
    if not a.real_minimax:
        mock = http.server.ThreadingHTTPServer(("127.0.0.1", MOCK_PORT), Mock)
        threading.Thread(target=mock.serve_forever, daemon=True).start()
        env.update(MM_URL="http://127.0.0.1:%d/v1/chat/completions" % MOCK_PORT, MM_KEY_OVERRIDE="mock-key")
    feeder = Feeder(scratch, src, win[0], win[1], a.speed, caps)
    feeder.start()
    time.sleep(1.0)
    outp = open(os.path.join(scratch, "server.out"), "w")
    srv = subprocess.Popen([sys.executable, "-u", os.path.join(ROOT, "tools", "coach-server.py"), "--port", str(PORT)], cwd=ROOT, env=env, stdout=outp, stderr=subprocess.STDOUT)
    try:
        up = False
        for _ in range(40):
            time.sleep(0.5)
            try:
                if http_json("/alive", timeout=2).get("ok"):
                    up = True
                    break
            except Exception:
                pass
        check("coach-server with the command center started on :%d" % PORT, up)
        if not up:
            print(open(os.path.join(scratch, "server.out")).read()[-1500:])
            return 1
        check("server log says the command center is ON", "command center ON" in open(os.path.join(scratch, "server.out")).read())
        t0 = time.time()
        deadline = t0 + (win[1] - win[0]) / a.speed + 45
        seen_open = None
        while time.time() < deadline:
            time.sleep(2.0)
            try:
                d = http_json("/incidents")
            except Exception:
                continue
            if d["open"] and seen_open is None:
                seen_open = time.time()
                print("  first incident visible after %.1fs wall (%.0fs sim): %s" % (seen_open - t0, (seen_open - t0) * a.speed, [(i["id"], i["kind"], i["sev"]) for i in d["open"]]))
            acts = http_json("/mmactions?n=20")
            if feeder.done and acts and time.time() - t0 > (win[1] - win[0]) / a.speed + 6:
                break
        d = http_json("/incidents?n=100")
        acts = http_json("/mmactions?n=30")
        pulse = http_json("/botpulse")
        sched = http_json("/scheduler")
        queue = http_json("/engineer-queue")
        inc_all = d["open"] + [x for x in d["recent"]]
        check("incidents were opened from the replayed telemetry", bool(inc_all), d["counters"])
        kinds = sorted({i["kind"] for i in inc_all})
        print("  incident kinds seen:", kinds, "| counters", d["counters"], "| ratings", {k: d["ratings"].get(k) for k in ("health", "grade", "stuck_s_now", "moving_pct_60s")})
        check("a STUCK or HOTSPOT incident carries an obstacle classification and a position",
              any(i["kind"] in ("stuck", "hotspot") and i.get("obstacle", {}).get("class") not in (None, "unknown") and i.get("pos") for i in inc_all))
        check("MiniMax was woken by an incident (mock received an incident package)" if mock else "MiniMax (real API) was woken by an incident",
              (any("INCIDENT PACKAGE" in m["prompt"] for m in MOCK_LOG) if mock else bool(acts)), len(MOCK_LOG))
        if mock and feeder.first_pin_wall and MOCK_LOG:
            first = min(m["t"] for m in MOCK_LOG if "INCIDENT PACKAGE" in m["prompt"])
            lat = (first - feeder.first_pin_wall) * a.speed
            print("  first pin -> MiniMax woken: %.1f sim-seconds (%.1f wall s)" % (lat, first - feeder.first_pin_wall))
            check("wake latency after the first pin is under 30 simulated seconds", 0 < lat < 30, lat)
        if mock:
            check("the mock never saw the real API key", all(m["auth"].startswith("Bearer mock") for m in MOCK_LOG), [m["auth"] for m in MOCK_LOG][:2])
        check("mm-actions.jsonl has the plan, actions and latency", bool(acts) and all("latency_s" in r for r in acts), acts[-1:] if acts else "none")
        flat = [x for r in acts for x in (r.get("actions") or [])]
        print("  actions:", [(x["type"], x.get("how"), x["result"][:60]) for x in flat][:10])
        if mock:
            if "act.v1" in caps:
                cmds = open(os.path.join(agent, "coach-commands.json")).read() if os.path.exists(os.path.join(agent, "coach-commands.json")) else ""
                check("unstick executed: the act command reached the plugin and the game log confirmed it",
                      any(x["type"] == "unstick" and "executed by the bot" in x["result"] for x in flat) and '"act"' in cmds, cmds[:200])
            elif a.mode == "semi":
                check("semi mode: unstick queued for approval, nothing executed",
                      any(x["type"] == "unstick" and "queued for approval" in x["result"] for x in flat) and not os.path.exists(os.path.join(agent, "coach-commands.json")))
            else:
                check("plugin without act.v1: unstick reported UNSUPPORTED and an urgent engineer task was queued",
                      any(x["type"] == "unstick" and x["result"].startswith("UNSUPPORTED") for x in flat) and any("act.v1" in q.get("title", "") for q in queue), queue[:2])
            check("code_task from an escalated response reached the engineer queue", any("boundary" in q.get("title", "").lower() or "act.v1" in q.get("title", "") for q in queue), queue[:3])
        if inc_all:
            iid = [i for i in inc_all if i["kind"] in ("stuck", "hotspot")][0]["id"] if any(i["kind"] in ("stuck", "hotspot") for i in inc_all) else inc_all[0]["id"]
            check("the actions are recorded on the incident itself", any(i.get("actions") for i in inc_all), [(i["id"], len(i.get("actions", []))) for i in inc_all][:6])
            try:
                with urllib.request.urlopen("http://127.0.0.1:%d/incident/frame?id=%s" % (PORT, iid), timeout=5) as r:
                    check("the incident frame snapshot is served as a JPEG", r.status == 200 and r.read(2) == b"\xff\xd8")
            except Exception as ex:
                check("the incident frame snapshot is served as a JPEG", False, ex)
        check("/botpulse reports the watchdog alive, MiniMax state and scheduler",
              pulse["watchdog"]["alive"] and pulse["minimax"]["last_wake"]["t"] > 0 and len(pulse["scheduler"]) >= 4, {k: pulse.get(k) for k in ("watchdog",)})
        check("scheduler jobs have run (pulse + selfcheck) and have a next-run time", all(j["next"] > time.time() - 5 for j in sched["jobs"]) and any(j["id"] == "pulse" and j["runs"] >= 1 for j in sched["jobs"]), sched)
        chat = jl(os.path.join(agent, "chatlog.jsonl"))
        check("the chat feed shows INCIDENT lines and the MiniMax diagnosis", any("INCIDENT" in c.get("text", "") for c in chat) and any("mm-incident" in c.get("text", "") for c in chat), [c["text"][:60] for c in chat][-4:])
        check("incidents.jsonl lifecycle log exists with open + action events", any(r["ev"] == "open" for r in jl(os.path.join(agent, "incidents.jsonl"))) and any(r["ev"] == "action" for r in jl(os.path.join(agent, "incidents.jsonl"))))
        check("cc-heartbeat.json is fresh (supervisor reads it)", os.path.exists(os.path.join(agent, "cc-heartbeat.json")) and time.time() - os.path.getmtime(os.path.join(agent, "cc-heartbeat.json")) < 60)
        errs = os.path.join(agent, "cc-errors.log")
        check("no command-center errors logged", not os.path.exists(errs) or os.path.getsize(errs) == 0, open(errs).read()[:300] if os.path.exists(errs) else "")
    finally:
        srv.terminate()
        try:
            srv.wait(5)
        except Exception:
            srv.kill()
        if mock:
            mock.shutdown()
    bad = [n for ok, n in RESULTS if not ok]
    print("\n%s - %d checks, %d failed%s" % ("ALL PASSED" if not bad else "FAILED", len(RESULTS), len(bad), ("  (scratch kept: %s)" % scratch) if (a.keep or bad) else ""))
    if not (a.keep or bad):
        shutil.rmtree(scratch, ignore_errors=True)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
