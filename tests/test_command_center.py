"""Tests for tools/command_center.py with a fake server context (no network, no game). Run:  python tests/test_command_center.py"""
import json
import os
import pathlib
import sys
import tempfile
import threading
import time

os.environ["CC_SKIP_PID_CHECK"] = "1"                   # caps.json in these tests belongs to a fake plugin, not a running game
os.environ["CC_LIVECAP"] = "0"                          # the livecap supervisor job must never spawn a real process from a unit test

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "tools"))
sys.path.insert(0, HERE)
import command_center as ccm  # noqa: E402
from incidents import IncidentEngine, MemSource  # noqa: E402
from test_incidents import Sim, Clock, BOUND  # noqa: E402

FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:300]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


class FakeCtx:
    def __init__(self, tmp):
        self.AGENT = pathlib.Path(tmp)
        (self.AGENT / "runs" / "run1").mkdir(parents=True, exist_ok=True)
        self.cfg = {"mode": "auto", "interval_s": 30}
        self.replies = []
        self.calls = []
        self.writes, self.logs, self.proposals, self.side, self.pend = [], [], [], [], []
        self.fail = None

    def mm_chat(self, messages, max_tokens=3000):
        self.calls.append(messages)
        if self.fail:
            raise RuntimeError(self.fail)
        r = self.replies.pop(0) if self.replies else '{"actions":[]}'
        return r if isinstance(r, str) else json.dumps(r), {"total_tokens": 321}

    def mm_cfg(self):
        return dict(self.cfg)

    def validate_patch(self, obj):
        if not isinstance(obj, dict):
            return None
        ok = {k: v for k, v in obj.items() if k in ("squad_size", "army_target", "build_focus", "hero_posture", "clear", "note")}
        return ok or None

    def guard_patch(self, patch, st):
        return patch

    def write_cmd(self, cmd):
        self.writes.append(cmd)

    def append_log(self, role, text):
        self.logs.append((role, text))

    def record_proposal(self, p, st):
        self.proposals.append(p)
        return True

    def apply_side_effects(self, patch, mode, st):
        self.side.append((patch, mode))
        return "relaunch (fake)"

    def live_state(self):
        return {"live": True, "run": "run1"}

    def latest_run(self):
        return self.AGENT / "runs" / "run1"

    def tail_lines(self, path, n, cap=65536):
        try:
            return [l for l in pathlib.Path(path).read_text(errors="replace").splitlines() if l.strip()][-n:]
        except OSError:
            return []

    def pending_list(self):
        return list(self.pend)

    def pending_write(self, p):
        self.pend = list(p)

    def recent_proposals(self, n=6):
        return [p["bug"] for p in self.proposals][-n:]


class FakePlugin:
    """Emulates the plugin side of act.v1/probe.v1 (Act.cs): polls agent/act-commands.json, 'executes', answers with act-ack.json (and
    probe.json for probes). mode="log": no ack file, only the game-log line (the server's second witness)."""

    def __init__(self, agent, hits=None, ok=True, delay=0.0, mode="ack", gamelog=None):
        self.agent, self.ok, self.delay, self.mode, self.gamelog = str(agent), ok, delay, mode, gamelog
        self.hits = hits if hits is not None else [
            {"name": "Boundaries 3", "cls": "obj:Boundaries 3", "decor": False, "path": "Map/Boundaries 3", "lay": "Boundaries", "tag": "Untagged", "stat": True, "trig": False,
             "c": [4, 0, 12], "size": [30, 4, 2], "dist": 0.8},
            {"name": "Grass patch", "cls": "decor:Grass patch", "decor": True, "path": "Map/Grass patch", "lay": "Default", "stat": True, "c": [4, 0, 12.5], "size": [3, 1, 3], "dist": 1.2}]
        self.seen = []
        self.stop = threading.Event()
        self.th = threading.Thread(target=self._run, daemon=True)
        self.th.start()

    def close(self):
        self.stop.set()
        self.th.join(2)

    def _run(self):
        last = None
        while not self.stop.is_set():
            try:
                d = json.load(open(os.path.join(self.agent, "act-commands.json"), encoding="utf-8"))
            except Exception:
                d = None
            if d and d.get("note") and d["note"] != last:
                last = d["note"]
                self.seen.append(d)
                time.sleep(self.delay)
                detail = "ok" if self.ok else "no retreat point (empty trail, no hint, no castle)"
                if d.get("act") == "probe" and self.ok:
                    with open(os.path.join(self.agent, "probe.json"), "w", encoding="utf-8") as f:
                        json.dump({"id": d.get("id"), "t": time.time(), "mode": "world" if "wx" in d else "screen", "world": [d.get("wx", 0), 0, d.get("wz", 0)], "hits": self.hits}, f)
                    detail = "probe: %d collider(s)" % len(self.hits)
                if self.mode == "ack":
                    with open(os.path.join(self.agent, "act-ack.json"), "w", encoding="utf-8") as f:
                        json.dump({"t": time.time(), "act": d.get("act"), "note": d["note"], "ok": self.ok, "detail": detail, "n": len(self.seen)}, f)
                elif self.gamelog:
                    with open(self.gamelog, "a", encoding="utf-8") as f:
                        f.write("[Info   :ThronefallTrainer] [coach] act %s %s :: %s (note %s)\n" % (d.get("act"), "OK" if self.ok else "FAILED", detail, d["note"]))
            time.sleep(0.02)


def make(tmp, **cfg_over):
    clock = Clock()
    ctx = FakeCtx(tmp)
    ccm.GAMELOG = os.path.join(tmp, "LogOutput.log")         # hermetic: never read the real game log
    sim = Sim()
    sim.clock = clock
    sim.eng = IncidentEngine(sim.src, clock=clock)
    cc = ccm.CommandCenter(ctx, engine=sim.eng, clock=clock)
    cc.cfg["wake"].update(coalesce_s=0, **cfg_over)
    sim.poller = cc.engine_tick                       # the command center polls the engine and routes its alerts
    return cc, ctx, sim, clock


def make_stuck(sim, n_extra=0):
    sim.run(2, moving=True)
    sim.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    for sec in range(1, 8 + n_extra):
        sim.step(1.0, pos=sim.pos, events=[(0.5, "stuck:2", BOUND)] if sec % 3 == 0 else [])


def drain(cc, timeout=5):
    end = time.time() + timeout
    while time.time() < end and (cc.inflight or cc.pending):
        time.sleep(0.02)
        if cc.pending and not cc.inflight:
            cc.maybe_wake()
    time.sleep(0.05)


def tick(cc, sim, secs=1.0, **kw):
    """advance the simulated world one step, then let the command center react like its 1 Hz thread would"""
    sim.step(secs, **kw)
    cc.maybe_wake()


def set_caps(ctx, caps, clock=None, pid=4242, build="act-1"):
    """What Act.cs publishes every 30 s: agent/caps.json (+ the plain audit.json the server reads for the scene)."""
    (ctx.AGENT / "audit.json").write_text(json.dumps({"scene": "Frostsee", "mode": "SpendGold", "gold": 100}))
    (ctx.AGENT / "caps.json").write_text(json.dumps({"t": clock.t if clock else time.time(), "pid": pid, "build": build, "caps": caps, "view_ok": True}))


def test_extract_and_validate():
    check("extract_json tolerates prose around the object", ccm.extract_json('sure! {"actions":[{"type":"ack"}]} done')["actions"][0]["type"] == "ack")
    check("extract_json returns None without an object", ccm.extract_json("nothing") is None)
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, _ = make(tmp)
        v = cc.validate_action
        check("validate: unstick/avoid needs x and z", v({"type": "unstick", "how": "avoid"}) is None)
        a = v({"type": "unstick", "how": "avoid", "x": 99999, "z": -5, "r": 500, "ttl_s": 99999})
        check("validate: clamps coordinates, radius and ttl", a and a["x"] == 2000 and a["r"] == 40 and a["ttl_s"] == 1800, a)
        a = v({"type": "unstick", "how": "avoid", "x": 1, "z": 2})
        check("validate: avoid defaults to r=12 ttl=600", a and a["r"] == 12.0 and a["ttl_s"] == 600.0, a)
        check("validate: unknown unstick method rejected", v({"type": "unstick", "how": "teleport", "x": 1, "z": 2}) is None)
        check("validate: unknown action type rejected", v({"type": "rm -rf"}) is None and v("x") is None and v(None) is None)
        check("validate: command goes through the knob whitelist", v({"type": "command", "patch": {"army_target": 40, "evil": 1}})["patch"] == {"army_target": 40})
        check("validate: command with no valid knob rejected", v({"type": "command", "patch": {"evil": 1}}) is None)
        check("validate: code_task needs a title", v({"type": "code_task"}) is None and v({"type": "code_task", "title": "x"}) is not None)
        check("validate: retreat needs no coordinates", v({"type": "unstick", "how": "retreat"}) is not None)


def test_incident_wakes_minimax_and_unsupported_plugin_is_reported():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"diagnosis": "Hero keeps ramming Boundaries 3.", "cause": "immovable-boundary", "confidence": 0.8,
                        "actions": [{"type": "unstick", "how": "avoid", "x": 4.0, "z": 12.0, "r": 14, "ttl_s": 600, "why": "immovable"},
                                    {"type": "command", "patch": {"build_focus": "military", "bogus": 1}}]}]
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        check("a STUCK incident woke MiniMax once", len(ctx.calls) == 1, len(ctx.calls))
        prompt = ctx.calls[0][1]["content"]
        check("the prompt carries the incident, obstacle class and trail", "map boundary" in prompt and "TRAIL" in prompt and "INCIDENTS (act on these)" in prompt)
        check("the prompt names the world coordinates + distance to the castle", '"near"' in prompt)
        inc = sim.eng.open_list()[0]
        results = {a["action"]["type"]: a["result"] for a in inc["actions"]}
        check("unstick on a plugin without act.v1 is reported as UNSUPPORTED", results.get("unstick", "").startswith("UNSUPPORTED"), results)
        check("... and queued once as an urgent engineer task", any("act.v1" in p["bug"] for p in ctx.proposals) and os.path.exists(os.path.join(tmp, "engineer-queue.jsonl")))
        check("a knob command is DROPPED for a stuck incident (knobs cannot move a pinned hero)", not ctx.writes and any("dropped" in a["result"] for a in inc["actions"] if a["action"].get("type") == "command"), (ctx.writes, inc["actions"]))
        rows = [json.loads(l) for l in open(os.path.join(tmp, "mm-actions.jsonl"))]
        check("mm-actions.jsonl records reason, diagnosis, actions and latency", rows and rows[-1]["diagnosis"].startswith("Hero keeps") and len(rows[-1]["actions"]) == 2 and "latency_s" in rows[-1], rows[-1:])
        check("the chat feed got an mm-incident line", any("mm-incident" in t for _, t in ctx.logs))


def test_knob_command_for_idle_incident_is_written():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"diagnosis": "picker stuck", "actions": [{"type": "command", "patch": {"build_focus": "military", "bogus": 1}}]}]
        sim.run(5, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 20})
        for _ in range(4):
            tick(cc, sim, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 90, "cur_build": "Barracks"})
        drain(cc)
        check("idle incident: the knob command was validated, nonce-stamped and written", ctx.writes and ctx.writes[-1].get("build_focus") == "military" and "bogus" not in ctx.writes[-1] and "#" in ctx.writes[-1]["note"], ctx.writes)


def test_unstick_executes_when_plugin_supports_it():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        set_caps(ctx, ["act.v1", "probe.v1", "view.v1"], clock)
        pl = FakePlugin(ctx.AGENT)
        try:
            ctx.replies = [{"diagnosis": "boundary", "cause": "immovable-boundary", "actions": [{"type": "unstick", "how": "avoid", "x": 4, "z": 12, "r": 14, "ttl_s": 600}]}]
            make_stuck(sim)
            for _ in range(3):
                tick(cc, sim, pos=sim.pos)
            drain(cc)
            w = [x for x in pl.seen if x.get("act") == "avoid"]
            check("the plugin received an act command with clamped parameters and a nonce", w and w[0]["x"] == 4 and w[0]["z"] == 12 and w[0]["r"] == 14 and w[0]["ttl_s"] == 600 and "#" in w[0]["note"], pl.seen)
            check("the act went through act-commands.json, not through the strategy-knob file", not any("act" in x for x in ctx.writes), ctx.writes)
            inc = sim.eng.open_list()[0]
            check("the incident records the plugin's confirmation", any(a["result"].startswith("executed by the bot") for a in inc["actions"]), inc["actions"])
            check("no engineer task is raised when the plugin supports it", not any("act.v1" in p["bug"] for p in ctx.proposals))
        finally:
            pl.close()


def test_unstick_failure_modes_are_reported_honestly():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        set_caps(ctx, ["act.v1"], clock)
        cc.act_timeout = 0.3
        make_stuck(sim)
        for _ in range(3):
            sim.step(1.0, pos=sim.pos)
        ids = [sim.eng.open_list()[0]["id"]]
        pl = FakePlugin(ctx.AGENT, ok=False)
        try:
            r = cc.send_unstick({"how": "retreat"}, ids)
            check("the plugin refuses (nowhere to retreat to): its reason is relayed, never 'executed'", r.startswith("plugin could not execute") and "no retreat point" in r, r)
        finally:
            pl.close()
        r = cc.send_unstick({"how": "retreat"}, ids)
        check("nobody answers (no ack file, nothing in the game log): reported as NOT confirmed", r.startswith("sent, NOT confirmed"), r)


def test_act_protocol_roundtrip():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        set_caps(ctx, ["act.v1", "probe.v1"], clock)
        pl = FakePlugin(ctx.AGENT)
        try:
            ack = cc.send_act({"act": "retreat"}, tag="t1")
            check("send_act: the plugin ack is matched by note", ack and ack["ok"] and ack["note"].startswith("t1#") and ack["detail"] == "ok", ack)
            check("send_act: the command reached the plugin with the nonce", pl.seen and pl.seen[0]["act"] == "retreat" and pl.seen[0]["note"] == ack["note"], pl.seen)
            out = []
            ths = [threading.Thread(target=lambda i=i: out.append(cc.send_act({"act": "avoid", "x": i, "z": i, "r": 5}, tag="p")), daemon=True) for i in range(3)]
            for t in ths:
                t.start()
            for t in ths:
                t.join(15)
            check("three concurrent senders (frozen clock!) each get their own ack - notes are unique", len(out) == 3 and all(o and o["ok"] for o in out) and len({o["note"] for o in out}) == 3, out)
            check("... and the plugin saw all of them (none overwritten before it read it)", len(pl.seen) == 4, [x["act"] for x in pl.seen])
        finally:
            pl.close()
        # the game log is the second witness when the ack file never appears
        pl2 = FakePlugin(ctx.AGENT, mode="log", gamelog=ccm.GAMELOG)
        try:
            ack = cc.send_act({"act": "forgive"}, tag="t2", timeout=0.4)
            check("no ack file but the game log carries our note: executed, confirmed via the log", ack and ack["ok"] and ack.get("via") == "gamelog", ack)
        finally:
            pl2.close()
        pl3 = FakePlugin(ctx.AGENT, mode="log", gamelog=ccm.GAMELOG, ok=False)
        try:
            ack = cc.send_act({"act": "retreat"}, tag="t3", timeout=0.4)
            check("a FAILED line in the game log is reported as a failure", ack and ack["ok"] is False and ack.get("via") == "gamelog", ack)
        finally:
            pl3.close()
        t0 = time.time()
        ack = cc.send_act({"act": "forgive"}, tag="t4", timeout=0.3)
        check("nobody answering returns None after the timeout plus the log grace period", ack is None and time.time() - t0 < 4, ack)


def test_plugin_info_and_caps():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        check("no caps.json: no capabilities", cc._caps() == set() and cc.plugin_info()["build"] is None)
        set_caps(ctx, ["act.v1", "probe.v1", "view.v1"], clock, build="act-1")
        pi = cc.plugin_info()
        check("a fresh caps.json is read (caps, build, view_ok)", set(pi["caps"]) == {"act.v1", "probe.v1", "view.v1"} and pi["build"] == "act-1" and pi["view_ok"] is True, pi)
        clock.t += 200
        check("a caps.json older than 120 s is ignored (the plugin has stopped or been replaced)", cc._caps() == set(), cc.plugin_info())
        set_caps(ctx, ["act.v1"], clock, pid=999999)
        os.environ.pop("CC_SKIP_PID_CHECK", None)
        try:
            cc._pid_cache = (0.0, None)
            check("caps written by a game process that is no longer running are ignored", cc._caps() == set(), cc.plugin_info())
        finally:
            os.environ["CC_SKIP_PID_CHECK"] = "1"


def test_incident_probe_in_prompt():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        set_caps(ctx, ["act.v1", "probe.v1"], clock)
        pl = FakePlugin(ctx.AGENT)
        try:
            ctx.replies = [{"diagnosis": "d", "actions": [{"type": "unstick", "how": "avoid", "x": 4, "z": 12, "r": 14, "ttl_s": 600}]}]
            make_stuck(sim)
            for _ in range(3):
                tick(cc, sim, pos=sim.pos)
            drain(cc)
            prompt = ctx.calls[0][1]["content"]
            check("the incident package carries the probe: what the game says is at the pin", '"probe_at_spot"' in prompt and "Boundaries 3" in prompt and '"static":true' in prompt, prompt[-1200:])
            check("decorative colliders (grass, decals) are filtered out", "Grass patch" not in prompt)
            probes = [x for x in pl.seen if x["act"] == "probe"]
            check("exactly one probe was sent for the incident", len(probes) == 1 and "wx" in probes[0] and "wz" in probes[0], pl.seen)
            iid = sim.eng.open_list()[0]["id"]
            cc.build_incident_prompt([iid], "again")
            check("a second prompt for the same incident reuses the cached probe", len([x for x in pl.seen if x["act"] == "probe"]) == 1)
            check("order on the wire: probe first, then the unstick", [x["act"] for x in pl.seen] == ["probe", "avoid"], [x["act"] for x in pl.seen])
        finally:
            pl.close()
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        set_caps(ctx, ["act.v1"], clock)                      # act.v1 but no probe.v1
        pl = FakePlugin(ctx.AGENT)
        try:
            ctx.replies = [{"actions": []}]
            make_stuck(sim)
            for _ in range(3):
                tick(cc, sim, pos=sim.pos)
            drain(cc)
            prompt = ctx.calls[0][1]["content"]
            check("a plugin without probe.v1: probe_at_spot is null and nothing was sent", '"probe_at_spot":null' in prompt and not pl.seen, (prompt[-300:], pl.seen))
        finally:
            pl.close()


def test_http_probe():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        body = json.dumps({"wx": 4, "wz": 12, "wr": 3}).encode()
        h = FakeHandler(body)
        cc.http_post(h, "/probe", len(body))
        d = json.loads(h.sent[1])
        check("POST /probe without a probe.v1 plugin says so", d["ok"] is False and "probe.v1" in d["why"], d)
        set_caps(ctx, ["act.v1", "probe.v1"], clock)
        pl = FakePlugin(ctx.AGENT)
        try:
            h = FakeHandler(body)
            cc.http_post(h, "/probe", len(body))
            d = json.loads(h.sent[1])
            check("POST /probe (world point) returns the colliders with decor filtered", d["ok"] and [x["name"] for x in d["probe"]["hits"]] == ["Boundaries 3"] and d["probe"]["hits"][0]["static"] is True, d)
            b2 = json.dumps({"sx": 400, "sy": 300}).encode()
            h = FakeHandler(b2)
            cc.http_post(h, "/probe", len(b2))
            check("POST /probe (screen point) is forwarded as sx/sy", json.loads(h.sent[1])["ok"] and pl.seen[-1].get("sx") == 400 and pl.seen[-1].get("sy") == 300, pl.seen[-1])
            b3 = json.dumps({"foo": 1}).encode()
            h = FakeHandler(b3)
            cc.http_post(h, "/probe", len(b3))
            check("POST /probe with no point is rejected", json.loads(h.sent[1])["ok"] is False)
        finally:
            pl.close()


def test_http_act_from_the_ui():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)

        def post(obj):
            body = json.dumps(obj).encode()
            h = FakeHandler(body)
            cc.http_post(h, "/act", len(body))
            return json.loads(h.sent[1])
        r = post({"act": "goto", "x": 10, "z": 20})
        check("UI act without an act.v1 plugin says so (and sends nothing)", r["ok"] is False and "act.v1" in r["why"], r)
        set_caps(ctx, ["act.v1", "probe.v1"], clock)
        pl = FakePlugin(ctx.AGENT)
        try:
            r = post({"act": "goto", "x": 10.5, "z": -20, "ttl_s": 9999})
            check("goto from the UI is executed by the plugin and confirmed", r["ok"] and r["result"].startswith("executed by the bot"), r)
            w = [x for x in pl.seen if x.get("act") == "goto"]
            check("the command reached the plugin clamped by the same whitelist (ttl <= 1800, coordinates kept)", w and w[0]["x"] == 10.5 and w[0]["z"] == -20 and w[0]["ttl_s"] <= 1800, pl.seen)
            r = post({"act": "avoid", "x": 1, "z": 2, "r": 999})
            check("avoid radius is clamped to 40 m", r["ok"] and r["act"]["r"] == 40, r)
            check("retreat needs no coordinates", post({"act": "retreat"})["ok"])
            check("unknown act is rejected, nothing sent", post({"act": "teleport", "x": 1, "z": 1})["ok"] is False and not [x for x in pl.seen if x.get("act") == "teleport"])
            check("goto without x,z is rejected", post({"act": "goto"})["ok"] is False)
            r = post({"act": "probe", "wx": 4, "wz": 12})
            check("probe goes through the same endpoint", r["ok"] and r["probe"]["hits"], r)
            check("every UI action is written to the chat feed", sum(1 for _, t in ctx.logs if "ui-act" in t) >= 3, [t for _, t in ctx.logs][-3:])
        finally:
            pl.close()


def test_code_task_ack_relaunch_and_dedupe():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"diagnosis": "target selector bug", "actions": [
            {"type": "code_task", "title": "Target selector re-picks slots behind the boundary", "file": "src/Bot.cs", "function": "PickBuild", "evidence": "33 strikes", "fix": "skip slots whose path crosses a hard-parked pocket"},
            {"type": "relaunch", "why": "wedged"}, {"type": "ack", "note": "filed"}]}]
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        q = [json.loads(l) for l in open(os.path.join(tmp, "engineer-queue.jsonl"))]
        check("code_task lands in the engineer queue as urgent", q and q[0]["priority"] == "urgent" and q[0]["file"] == "src/Bot.cs" and q[0]["status"] == "queued", q)
        check("the same task is not queued twice", cc.enqueue_code_task({"type": "code_task", "title": q[0]["title"]}, []) == "already queued")
        check("relaunch is REFUSED for a pin incident (never kill the game over a pin)", not ctx.side, ctx.side)
        inc0 = sim.eng.open_list()[0]
        check("... and the refusal is recorded", any("refused" in a["result"] for a in inc0["actions"] if a["action"].get("type") == "relaunch"), inc0["actions"])
        # a wedged UI frame that lasted > 60 s does justify it
        sim2 = Sim()
        sim2.clock = cc.clock
        wedge = cc.engine.open  # reuse the engine: open a wedge incident by hand
        w = cc.engine._open("wedge", "crit", cc.clock(), detail="frame stuck", dur_s=90)
        res = cc._run_action({"type": "relaunch", "why": "wedged"}, [w["id"]], "auto", False)
        check("relaunch is executed for a >= 60 s wedge in auto mode", ctx.side and ctx.side[0][0].get("relaunch"), (res, ctx.side))
        inc = sim.eng.open_list()[0]
        check("ack silences re-alerts", inc.get("acked") and inc["acked"]["by"] == "minimax", inc.get("acked"))


def test_semi_mode_queues_instead_of_acting():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.cfg["mode"] = "semi"
        set_caps(ctx, ["act.v1"], clock)
        ctx.replies = [{"diagnosis": "d", "actions": [{"type": "unstick", "how": "retreat"}, {"type": "command", "patch": {"army_target": 40}}, {"type": "relaunch"}]}]
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        check("semi: nothing written to the plugin", ctx.writes == [], ctx.writes)
        check("semi: the unstick waits for approval as a ready-to-write act patch", len(ctx.pend) >= 1 and ctx.pend[0]["patch"].get("act") == "retreat", ctx.pend)
        check("semi: the knob command was dropped (pin incident) and the relaunch refused - neither is even proposed", len(ctx.pend) == 1, ctx.pend)
        # an idle incident's knob command and a >=60 s wedge's relaunch DO get queued
        w = cc.engine._open("wedge", "crit", cc.clock(), detail="frame stuck", dur_s=90)
        i2 = cc.engine._open("idle", "warn", cc.clock(), detail="gold idle", dur_s=70)
        r1 = cc._run_action({"type": "relaunch"}, [w["id"]], "semi", False)
        r2 = cc._run_action({"type": "command", "patch": {"army_target": 40}}, [i2["id"]], "semi", False)
        check("semi: a wedge relaunch and an idle knob command are queued with ready patches",
              "queued" in r1 and "queued" in r2 and ctx.pend[-2]["patch"].get("relaunch") and ctx.pend[-1]["patch"].get("army_target") == 40, (r1, r2, ctx.pend))


def test_off_mode_suppresses_calls_and_logs_it():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.cfg["mode"] = "off"
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        check("off: MiniMax is not called", ctx.calls == [], len(ctx.calls))
        inc = sim.eng.open_list()[0]
        check("off: the incident records that the alert was suppressed", any("suppressed" in a["result"] for a in inc["actions"]), inc["actions"])
        check("off: counted", cc.stats["alerts_suppressed"] >= 1)


def test_rate_limits():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp, max_per_10min=2, min_gap_crit_s=20, min_gap_warn_s=45)
        ctx.replies = [{"actions": []}] * 10
        # inject alerts directly (unknown id -> warn-level gap) so the timing is fully controlled
        cc.last_wake["t"] = clock.t                         # MiniMax was just woken
        cc.pending["X"] = "forced"
        cc.pending_since = clock.t - 10
        clock.t += 5
        cc.maybe_wake()
        drain(cc, 1)
        check("min gap: a second wake 5 s after the last is held back", len(ctx.calls) == 0, len(ctx.calls))
        check("... and the alert stays pending", "X" in cc.pending)
        clock.t += 45
        cc.maybe_wake()
        drain(cc)
        check("after the gap it wakes", len(ctx.calls) == 1, len(ctx.calls))
        clock.t += 50
        cc.pending["X"] = "forced"
        cc.pending_since = clock.t - 10
        cc.maybe_wake()
        drain(cc)
        check("second wake allowed within the budget", len(ctx.calls) == 2, len(ctx.calls))
        clock.t += 50
        cc.pending["X"] = "forced"
        cc.pending_since = clock.t - 10
        cc.maybe_wake()
        drain(cc, 1)
        check("budget: no more than max_per_10min=2 calls in 10 minutes", len(ctx.calls) == 2, len(ctx.calls))
        clock.t += 600
        cc.maybe_wake()
        drain(cc)
        check("budget window slides: wakes again after 10 minutes", len(ctx.calls) == 3, len(ctx.calls))
        # crit incidents use the shorter gap
        cc2, ctx2, sim2, clock2 = make(tmp, min_gap_crit_s=20, min_gap_warn_s=45)
        ctx2.replies = [{"actions": []}] * 5
        cc2.cfg["wake"]["enabled"] = False
        make_stuck(sim2, 8)                                 # crit incident, wakes disabled so alerts accumulate
        cc2.cfg["wake"]["enabled"] = True
        cc2.last_wake["t"] = clock2.t - 25                  # 25 s ago: past the crit gap (20) but inside the warn gap (45)
        cc2.pending_since = clock2.t - 10
        check("crit incident pending", any((sim2.eng.get(i) or {}).get("sev") == "crit" for i in cc2.pending), cc2.pending)
        cc2.maybe_wake()
        drain(cc2)
        check("crit alerts use the shorter 20 s gap", len(ctx2.calls) == 1, len(ctx2.calls))


def test_coalescing_two_incidents_one_call():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"actions": []}]
        cc.cfg["wake"]["coalesce_s"] = 15                                  # alerts raised within 15 s of each other share a call
        make_stuck(sim)                                                     # STUCK warn: first alert, then the 15 s window runs
        for _ in range(2):
            sim.step(1.0, pos=sim.pos, audit={"scene": "Frostsee", "gold": 4000, "mode": "SpendGold", "since_prog": 90})   # + IDLE
        check("coalescing: nothing was sent yet", len(ctx.calls) == 0 and "idle" in sim.kinds(), (len(ctx.calls), sim.kinds()))
        for _ in range(15):
            sim.step(1.0, pos=sim.pos, audit={"scene": "Frostsee", "gold": 4000, "mode": "SpendGold", "since_prog": 92})
        drain(cc)
        check("two incidents raised in the same few seconds share ONE MiniMax call", len(ctx.calls) == 1, len(ctx.calls))
        p = ctx.calls[0][1]["content"]
        check("... and the call lists both", '"kind":"stuck"' in p and '"kind":"idle"' in p, p[:300])


def test_minimax_error_is_visible_and_not_fatal():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.fail = "The read operation timed out"
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        check("API error: wake recorded as failed", cc.last_wake["ok"] is False and "timed out" in cc.last_wake["error"], cc.last_wake)
        check("API error: stats and chat show it", cc.stats["wake_errors"] == 1 and any("ERROR" in t for _, t in ctx.logs))
        inc = sim.eng.open_list()[0]
        check("API error: noted on the incident", any("ERROR" in a["result"] for a in inc["actions"]), inc["actions"])
        check("API error: the lock is released (next wake possible)", cc.wake_lock.acquire(blocking=False) and not cc.wake_lock.release())


def test_history_at_spot_is_fed_back():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"actions": [{"type": "unstick", "how": "retreat"}]}, {"actions": []}]
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        first = sim.eng.open_list()[0]
        sim.run(30, moving=True)                                           # it gets free, the incident resolves
        check("first incident resolved", not sim.eng.open_list(), sim.kinds())
        # second pin at the same spot much later
        sim.eng.closed[-1]["pos"] = list(first["pos"])
        sim.pos = list(first["pos"])
        clock.t += 90
        make_stuck(sim)
        for _ in range(3):
            tick(cc, sim, pos=sim.pos)
        drain(cc)
        if len(ctx.calls) >= 2:
            p = ctx.calls[1][1]["content"]
            check("the second prompt shows what was tried here last time", "history_at_spot" in p and "retreat" in p, p[:600])
        else:
            check("second wake happened", False, len(ctx.calls))


def test_scheduler_jobs():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        sim.run(5, moving=True)
        for jb in cc.jobs.values():
            jb["next"] = clock.t - 1
        cc.scheduler_tick()
        check("pulse job ran and wrote botpulse.json", os.path.exists(os.path.join(tmp, "botpulse.json")) and cc.jobs["pulse"]["runs"] == 1 and cc.jobs["pulse"]["last_ok"])
        check("selfcheck wrote cc-heartbeat.json", os.path.exists(os.path.join(tmp, "cc-heartbeat.json")))
        check("report posted to the chat feed", any("hourly" in t for _, t in ctx.logs))
        check("every job has a next-run time in the future", all(jb["next"] > clock.t for jb in cc.jobs.values()))
        check("scheduler state persisted for the UI/supervisor", os.path.exists(os.path.join(tmp, "cc-scheduler.json")))
        cc.set_job("pulse", enabled=False)
        cc.jobs["pulse"]["next"] = clock.t - 1
        runs = cc.jobs["pulse"]["runs"]
        cc.scheduler_tick()
        check("a disabled job does not run", cc.jobs["pulse"]["runs"] == runs)
        cc.set_job("review", every_s=5)
        check("interval is clamped to >= 10 s", cc.jobs["review"]["every_s"] == 10.0)
        # selfcheck restarts a dead watchdog thread
        dead = threading.Thread(target=lambda: None)
        dead.start()
        dead.join()
        cc.threads["watchdog"] = dead
        cc._watch_loop = lambda: time.sleep(0.2)
        note = cc._job_selfcheck()
        check("selfcheck restarts a dead watchdog", "restarted watchdog" in note and cc.threads["watchdog"].is_alive(), note)


def test_review_job():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"diagnosis": "all fine", "actions": []}]
        r = cc._job_review()
        check("review wakes MiniMax with the REVIEW prompt", len(ctx.calls) == 1 and "SCHEDULED REVIEW" in ctx.calls[0][1]["content"] and "REVIEW" in ctx.calls[0][0]["content"], r)
        ctx.cfg["mode"] = "off"
        check("review is skipped when MiniMax is off", cc._job_review().startswith("skipped"))


def test_pulse_wakes_on_bad_health():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        ctx.replies = [{"actions": []}]
        cc.cfg["wake"]["enabled"] = False                    # the pulse is the only thing that may wake MiniMax here
        make_stuck(sim, 14)
        cc.pending.clear()
        cc.last_wake["t"] = 0
        sim.eng.ratings["health"] = 30
        note = cc._job_pulse()
        drain(cc)
        check("a bad health rating makes the pulse wake MiniMax", "woke MiniMax" in note and len(ctx.calls) == 1, (note, len(ctx.calls)))


class FakeHandler:
    def __init__(self, body=b""):
        import io
        self.sent = None
        self.rfile = io.BytesIO(body)

    def _send(self, code, body, ct="text/plain"):
        self.sent = (code, body if isinstance(body, (bytes, str)) else str(body), ct)


def test_http():
    with tempfile.TemporaryDirectory() as tmp:
        cc, ctx, sim, clock = make(tmp)
        cc.cfg["wake"]["enabled"] = False
        make_stuck(sim)
        h = FakeHandler()
        check("GET /incidents handled", cc.http_get(h, "/incidents?n=10") and h.sent[0] == 200)
        d = json.loads(h.sent[1])
        check("/incidents returns open incidents with obstacle + ratings", d["open"] and d["open"][0]["obstacle"]["class"] == "map boundary" and "health" in d["ratings"], d.get("open"))
        h = FakeHandler()
        cc.http_get(h, "/botpulse")
        d = json.loads(h.sent[1])
        check("/botpulse has bot, minimax, watchdog, scheduler", all(k in d for k in ("bot", "minimax", "watchdog", "scheduler", "ratings")), list(d))
        h = FakeHandler()
        cc.http_get(h, "/alive")
        check("/alive answers", json.loads(h.sent[1])["ok"] is True)
        inc = sim.eng.open_list()[0]
        h = FakeHandler(json.dumps({"id": inc["id"], "note": "seen"}).encode())
        cc.http_post(h, "/incident/ack", 40)
        check("POST /incident/ack acknowledges", json.loads(h.sent[1])["ok"] and sim.eng.open_list()[0]["acked"]["by"] == "user")
        body = json.dumps({"job": "review", "enabled": False, "every_s": 120}).encode()
        h = FakeHandler(body)
        cc.http_post(h, "/scheduler", len(body))
        check("POST /scheduler updates a job", not cc.jobs["review"]["enabled"] and cc.jobs["review"]["every_s"] == 120)
        ctx.replies = [{"actions": []}]
        body = json.dumps({"id": inc["id"]}).encode()
        h = FakeHandler(body)
        cc.http_post(h, "/incident/wake", len(body))
        drain(cc)
        check("POST /incident/wake wakes MiniMax now (manual)", len(ctx.calls) == 1)
        h = FakeHandler()
        check("unknown path is not handled", cc.http_get(h, "/nope") is False and cc.http_post(h, "/nope", 0) is False)
        h = FakeHandler()
        cc.http_get(h, "/incident/frame?id=../../etc/passwd")
        check("frame endpoint sanitises the id", h.sent[0] == 404)


def main():
    for fn in (test_extract_and_validate, test_incident_wakes_minimax_and_unsupported_plugin_is_reported, test_knob_command_for_idle_incident_is_written, test_unstick_executes_when_plugin_supports_it,
               test_unstick_failure_modes_are_reported_honestly, test_act_protocol_roundtrip, test_plugin_info_and_caps, test_incident_probe_in_prompt, test_http_probe,
               test_http_act_from_the_ui,
               test_code_task_ack_relaunch_and_dedupe, test_semi_mode_queues_instead_of_acting, test_off_mode_suppresses_calls_and_logs_it, test_rate_limits,
               test_coalescing_two_incidents_one_call, test_minimax_error_is_visible_and_not_fatal, test_history_at_spot_is_fed_back, test_scheduler_jobs,
               test_review_job, test_pulse_wakes_on_bad_health, test_http):
        try:
            fn()
        except AssertionError as e:
            print("[FAIL] %s raised AssertionError %s" % (fn.__name__, e))
            FAILS.append(fn.__name__)
        except Exception:
            import traceback
            traceback.print_exc()
            FAILS.append(fn.__name__)
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
