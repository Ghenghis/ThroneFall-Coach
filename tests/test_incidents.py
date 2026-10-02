"""Unit tests for tools/incidents.py - synthetic telemetry in, incidents out. Run:  python tests/test_incidents.py
No game, no network. Every scenario mirrors a pattern seen in the real run logs (pin streaks on a boundary, gold-idle, wedged frames)."""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "tools"))
from incidents import IncidentEngine, MemSource, classify_obstacle, CFG  # noqa: E402


class Clock:
    def __init__(self):
        self.t = 1_000_000.0

    def __call__(self):
        return self.t


class Sim:
    """Drives the engine like the 1 Hz poll thread: advances simulated time, writes 2 Hz ticks and the events of that second."""

    def __init__(self, **cfg):
        self.clock = Clock()
        self.src = MemSource()
        self.eng = IncidentEngine(self.src, cfg=cfg, clock=self.clock)
        self.poller = lambda: self.eng.poll()          # tests of the command center swap in cc.engine_tick
        self.t = 100.0
        self.ticks = []
        self.pos = [10.0, 20.0]
        self.last = {}

    def step(self, secs=1.0, pos=None, moving=False, events=(), audit=None, mode="SpendGold", ta=(60.0, 40.0), state="InMatch", **bundle):
        end = self.t + secs
        t = self.t
        while t < end - 1e-9:
            t = round(t + 0.5, 3)
            if pos is not None:
                self.pos = list(pos)
            elif moving:
                self.pos = [self.pos[0] + 1.0, self.pos[1] + 0.2]       # ~2.0 m/s
            self.ticks.append({"t": t, "pos": list(self.pos), "mode": mode, "state": state, "ta": list(ta) if ta else None,
                               "scene": "Frostsee", "bn": bundle.pop("bn", "Barracks"), "night": False})
        self.t = end
        evs = []
        for dt, note, what in events:
            et = round(self.t - secs + dt, 3)
            if what:
                evs.append({"t": et, "note": "pin-type", "what": what})
            evs.append({"t": et, "note": note})
        b = {"run": "run1", "live": True, "ticks": self.ticks[-160:], "events": evs, "audit": audit if audit is not None else {"scene": "Frostsee", "gold": 100, "mode": mode, "since_prog": 0},
             "ticks_age": 0.4, "audit_age": 0.4, "game_running": True, "gamelog_new": bundle.pop("gamelog_new", [])}
        b.update(bundle)
        self.src.bundle = b
        self.clock.t += secs
        self.last = self.poller()
        return self.last

    def run(self, secs, **kw):
        out = []
        for _ in range(int(secs)):
            out.append(self.step(1.0, **kw))
        return out

    def kinds(self):
        return sorted(i["kind"] for i in self.eng.open_list())


FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


BOUND = "obj:Boundaries 3 (2)"


def test_classification():
    c = classify_obstacle(BOUND)
    check("classify: Boundaries -> immovable map boundary", c["class"] == "map boundary" and c["immovable"] is True, c)
    c = classify_obstacle("pen:Wall")
    check("classify: pen:Wall -> player wall, movable", c["class"] == "player wall" and c["immovable"] is False, c)
    c = classify_obstacle("pen:Defense Tower")
    check("classify: pen:Defense Tower -> player building", c["class"] == "player building", c)
    check("classify: gate", classify_obstacle("obj:Gate Wide Variant (3)")["class"] == "gate")
    check("classify: ground is immovable terrain", classify_obstacle("obj:Ground")["immovable"] is True)
    check("classify: nothing -> unknown", classify_obstacle(None)["class"] == "unknown")


def test_lone_strike_is_not_an_incident():
    s = Sim()
    s.run(5, moving=True)
    s.step(1.0, events=[(0.5, "stuck:1", BOUND), (0.5, "quick-sidestep", None)])
    s.run(10, moving=True)
    check("one 2 s strike opens nothing", s.kinds() == [], s.kinds())


def test_stuck_opens_at_five_seconds_and_alerts_once():
    s = Sim()
    s.run(3, moving=True)
    alerts = []
    s.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    for sec in range(1, 7):
        ev = [(0.5, "stuck:2", BOUND)] if sec == 3 else []
        r = s.step(1.0, pos=s.pos, events=ev)
        alerts += r["alerts"]
    open_ = s.eng.open_list()
    check("a ~6 s pin streak opens a STUCK incident (warn)", len(open_) == 1 and open_[0]["kind"] == "stuck" and open_[0]["sev"] == "warn", [(i["kind"], i["sev"], i.get("dur_s")) for i in open_])
    check("exactly one alert queued for it", len(alerts) == 1 and alerts[0]["reason"] == "opened", alerts)
    inc = open_[0]
    check("incident carries obstacle class + position", inc["obstacle"]["class"] == "map boundary" and inc["pos"] and abs(inc["pos"][0] - 13.0) < 5, (inc["obstacle"], inc["pos"]))
    check("a frame snapshot was requested", inc["id"] in s.src.frames)


def test_escalation_and_resolve():
    s = Sim()
    s.run(2, moving=True)
    s.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    for sec in range(1, 16):
        ev = [(0.5, "stuck:%d" % (1 + sec % 2), BOUND)] if sec % 3 == 0 else []
        s.step(1.0, pos=s.pos, events=ev)
    inc = s.eng.open_list()[0]
    check("a 14 s streak escalates to crit", inc["sev"] == "crit" and inc["dur_s"] >= 12, (inc["sev"], inc["dur_s"]))
    # the hero gets free and walks away
    resolved = []
    for _ in range(30):
        r = s.step(1.0, moving=True)
        resolved += r["resolved"]
    stuck_open = [i for i in s.eng.open_list() if i["kind"] == "stuck"]
    check("moving on for 30 s resolves the STUCK incident", not stuck_open and any(i["kind"] == "stuck" for i in resolved), (s.kinds(), len(resolved)))
    check("resolve is logged with a reason", any(r["ev"] == "resolve" and r["kind"] == "stuck" for r in s.src.logs))


def test_realert_is_rate_limited():
    s = Sim()
    s.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    n_alerts = 0
    for sec in range(1, 100):
        ev = [(0.5, "stuck:2", BOUND)] if sec % 3 == 0 else []
        n_alerts += len(s.step(1.0, pos=s.pos, events=ev)["alerts"])
    # open(warn) + escalate(crit) + a re-alert at most every 60 s over ~100 s
    check("alert storm is bounded (<= 4 alerts in 100 s for one incident)", n_alerts <= 4, n_alerts)
    inc = s.eng.open_list()[0]
    check("an acked incident stops re-alerting", s.eng.ack(inc["id"], "mm", "looking") is True)
    more = 0
    for sec in range(100, 220):
        ev = [(0.5, "stuck:2", BOUND)] if sec % 3 == 0 else []
        more += len(s.step(1.0, pos=s.pos, events=ev)["alerts"])
    check("no alerts after ack", more == 0, more)


def test_hotspot_needs_a_small_radius():
    # three streaks at the same boundary spot -> hotspot
    s = Sim()
    for visit in range(3):
        s.run(6, moving=True)
        s.step(1.0, pos=[100.0, 50.0], events=[(0.5, "stuck:1", BOUND)])
        s.step(1.0, pos=[100.5, 50.2], events=[(0.5, "stuck:2", BOUND)])
        s.step(1.0, pos=[100.2, 50.1], events=[(0.5, "pin-park", None)])
        s.run(14, moving=True)
    check("3 pin streaks within 8 m -> HOTSPOT incident", "hotspot" in s.kinds(), s.kinds())
    hs = [i for i in s.eng.open_list() if i["kind"] == "hotspot"][0]
    check("hotspot is crit and counts the visits", hs["sev"] == "crit" and hs["count"] >= 3, (hs["sev"], hs.get("count")))
    # same number of streaks but far apart -> no hotspot
    s2 = Sim()
    for visit in range(3):
        s2.run(6, moving=True)
        p = [100.0 + 60 * visit, 50.0]
        s2.step(1.0, pos=p, events=[(0.5, "stuck:1", BOUND)])
        s2.step(1.0, pos=p, events=[(0.5, "stuck:2", BOUND)])
        s2.run(14, moving=True)
    check("streaks 60 m apart are not a hotspot", "hotspot" not in s2.kinds(), s2.kinds())


def test_hotspot_resolves_when_quiet():
    s = Sim()
    for visit in range(3):
        s.run(6, moving=True)
        s.step(1.0, pos=[100.0, 50.0], events=[(0.5, "stuck:1", BOUND)])
        s.step(1.0, pos=[100.3, 50.1], events=[(0.5, "stuck:2", BOUND)])
        s.run(10, moving=True)
    assert "hotspot" in s.kinds()
    s.run(140, moving=True)
    check("a hotspot resolves after 2 quiet minutes", "hotspot" not in s.kinds(), s.kinds())


def test_idle_with_gold():
    s = Sim()
    s.run(5, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 20, "eff_drain": "gold-idle pacing", "bld_blocked": 9, "cur_build": "Barracks"})
    s.run(3, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 70, "eff_drain": "gold-idle pacing", "bld_blocked": 9, "cur_build": "Barracks"})
    inc = [i for i in s.eng.open_list() if i["kind"] == "idle"]
    check("70 s without progress and 4.7k gold -> IDLE warn", len(inc) == 1 and inc[0]["sev"] == "warn", s.kinds())
    s.run(3, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 200, "eff_drain": "gold-idle pacing", "bld_blocked": 9})
    inc = [i for i in s.eng.open_list() if i["kind"] == "idle"]
    check("200 s -> escalates to crit", inc and inc[0]["sev"] == "crit", inc and inc[0]["sev"])
    s.run(3, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 5})
    check("progress resolves IDLE", "idle" not in s.kinds(), s.kinds())
    s2 = Sim()
    s2.run(5, audit={"scene": "Frostsee", "gold": 4748, "mode": "SpendGold", "since_prog": 300, "night": True})
    check("no IDLE incident at night", "idle" not in s2.kinds(), s2.kinds())
    s3 = Sim()
    s3.run(5, audit={"scene": "Frostsee", "gold": 50, "mode": "SpendGold", "since_prog": 300})
    check("no IDLE incident when there is no gold to spend", "idle" not in s3.kinds(), s3.kinds())


def test_wedge():
    s = Sim()
    s.run(25, audit={"scene": "Frostsee", "gold": 10, "mode": "Idle", "since_prog": 0, "frame": "ChoiceFrame"})
    check("a UI frame stuck open for 25 s -> WEDGE", "wedge" in s.kinds(), s.kinds())
    s.run(3, audit={"scene": "Frostsee", "gold": 10, "mode": "Idle", "since_prog": 0, "frame": ""})
    check("closing the frame resolves it", "wedge" not in s.kinds(), s.kinds())


def test_feed_dead_and_back():
    s = Sim()
    s.run(3)
    r = s.step(1.0, ticks_age=25.0, audit_age=25.0, live=False)
    check("telemetry silent for 25 s -> FEED crit", "feed" in s.kinds() and s.eng.open_list()[0]["sev"] == "crit", s.kinds())
    check("the feed incident alerts MiniMax", any(a for a in r["alerts"]), r["alerts"])
    s.step(1.0, ticks_age=0.3, audit_age=0.3)
    check("feed back -> resolved", "feed" not in s.kinds(), s.kinds())
    s2 = Sim()
    s2.run(2)
    s2.step(1.0, ticks_age=40.0, audit_age=40.0, live=False, game_running=False)
    check("detail says the game is not running", "not running" in s2.eng.open_list()[0]["detail"], s2.eng.open_list()[0].get("detail"))


def test_code_errors():
    s = Sim()
    lines = ["[Error  : Unity Log] NullReferenceException: at Bot.Tick", "[Warning: ThronefallTrainer] fine", "System.Exception: boom"]
    s.step(1.0, gamelog_new=lines)
    check("2 exception lines are below the threshold", "code" not in s.kinds(), s.kinds())
    s.step(1.0, gamelog_new=["[Error  : Unity Log] NullReferenceException: at Bot.Tick"])
    check("3 exception lines in 60 s -> CODE incident", "code" in s.kinds(), s.kinds())
    inc = [i for i in s.eng.open_list() if i["kind"] == "code"][0]
    check("it quotes the most frequent message", "NullReferenceException" in inc["excerpt"], inc.get("excerpt"))
    s.run(70)
    check("quiet for 70 s -> resolved", "code" not in s.kinds(), s.kinds())


def test_target_loop():
    s = Sim()
    for i in range(4):
        s.step(1.0, bn="Harbor", events=[(0.5, "approach-timeout", None)])
        s.run(8, moving=True, bn="Harbor")
    check("the same build target abandoned 4x -> LOOP", "loop" in s.kinds(), s.kinds())
    inc = [i for i in s.eng.open_list() if i["kind"] == "loop"][0]
    check("it names the target", inc["target"] == "Harbor", inc.get("target"))


def test_new_run_resolves_everything():
    s = Sim()
    s.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    for sec in range(1, 8):
        s.step(1.0, pos=s.pos, events=[(0.5, "stuck:2", BOUND)] if sec % 3 == 0 else [])
    assert s.kinds() == ["stuck"]
    s.step(1.0, run="run2", ticks=[])
    check("a new run resolves open incidents as run-ended", s.kinds() == [] and s.eng.closed[-1]["resolved_by"] == "run-ended", (s.kinds(), s.eng.closed[-1:] and s.eng.closed[-1].get("resolved_by")))


def test_ratings_and_log():
    s = Sim()
    s.run(30, moving=True)
    h_ok = s.eng.ratings["health"]
    check("a walking bot rates >= 85", h_ok >= 85, s.eng.ratings)
    s.step(1.0, events=[(0.5, "stuck:1", BOUND)])
    for sec in range(1, 16):
        s.step(1.0, pos=s.pos, events=[(0.5, "stuck:2", BOUND)] if sec % 3 == 0 else [])
    r = s.eng.ratings
    check("a bot pinned for 15 s rates lower and reports stuck_s_now", r["health"] < h_ok - 15 and r["stuck_s_now"] >= 12, r)
    check("still_with_goal_pct is high while pinned with a goal", s.eng.ratings.get("still_with_goal_pct_60s", 0) >= 15, s.eng.ratings)
    inc = s.eng.open_list()[0]
    s.eng.record_action(inc["id"], "mm", {"type": "unstick", "how": "forgive"}, "queued")
    check("actions are recorded on the incident and in the log", inc["actions"][-1]["by"] == "mm" and any(x["ev"] == "action" for x in s.src.logs))
    snap = s.src.opens
    check("incidents-open snapshot has the open incident, counters and ratings", snap and snap["open"] and snap["counters"]["opened"] >= 1 and "health" in snap["ratings"], snap and list(snap))


def main():
    for fn in (test_classification, test_lone_strike_is_not_an_incident, test_stuck_opens_at_five_seconds_and_alerts_once, test_escalation_and_resolve,
               test_realert_is_rate_limited, test_hotspot_needs_a_small_radius, test_hotspot_resolves_when_quiet, test_idle_with_gold, test_wedge,
               test_feed_dead_and_back, test_code_errors, test_target_loop, test_new_run_resolves_everything, test_ratings_and_log):
        try:
            fn()
        except AssertionError as e:
            print("[FAIL] %s raised AssertionError %s" % (fn.__name__, e))
            FAILS.append(fn.__name__)
        except Exception as e:  # noqa
            import traceback
            traceback.print_exc()
            FAILS.append(fn.__name__)
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
