#!/usr/bin/env python3
"""Replay recorded runs through the incident engine (simulated 1 Hz clock) - the proof that the detectors work on REAL telemetry.

    python tools/incident-replay.py --latest
    python tools/incident-replay.py 20261001T101018Z-Frostsee
    python tools/incident-replay.py --scene Frostsee --last 6

Prints, per run: incidents by kind, time lost, the longest ones, hotspots with their obstacle class, and the time-to-alert of every
pin streak (how long after the hero first stopped the engine raised the alarm). Nothing is written to the agent dir.
"""
import argparse
import glob
import json
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import incidents as inc  # noqa: E402

AGENT = os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")


class ReplaySource:
    def __init__(self, run_dir):
        self.run = os.path.basename(run_dir)
        self.ticks = self._load(os.path.join(run_dir, "ticks.jsonl"))
        self.events = self._load(os.path.join(run_dir, "events.jsonl"))
        self.t = 0.0
        self._ei = 0
        self.logs = []
        self.seq = 0
        self.opens = None

    @staticmethod
    def _load(p):
        out = []
        try:
            for ln in open(p, encoding="utf-8", errors="replace"):
                if ln.startswith("{"):
                    try:
                        out.append(json.loads(ln))
                    except Exception:
                        pass
        except OSError:
            pass
        return out

    def advance(self, t):
        self.t = t

    def read(self):
        n = 0
        while n < len(self.ticks) and self.ticks[n].get("t", 0) <= self.t:
            n += 1
        evs = []
        while self._ei < len(self.events) and self.events[self._ei].get("t", 0) <= self.t:
            evs.append(self.events[self._ei])
            self._ei += 1
        last = self.ticks[n - 1] if n else {}
        return {"run": self.run, "live": n > 0, "ticks": self.ticks[max(0, n - 160):n], "events": evs, "ticks_age": 0.4, "audit_age": 0.4, "game_running": True,
                "audit": {"scene": last.get("scene"), "gold": last.get("gold"), "mode": last.get("mode"), "night": last.get("night"), "since_prog": None},
                "gamelog_new": []}

    def load_seq(self):
        return self.seq

    def save_seq(self, n):
        self.seq = n

    def write_open(self, snap):
        self.opens = snap

    def log(self, rec):
        self.logs.append(rec)

    def read_log(self, n):
        return self.logs[-n:]

    def snapshot_frame(self, *a):
        pass


def replay(run_dir, verbose=True):
    src = ReplaySource(run_dir)
    if not src.ticks:
        return None
    clock = [0.0]
    eng = inc.IncidentEngine(src, clock=lambda: clock[0])
    t_end = src.ticks[-1]["t"]
    t = src.ticks[0]["t"]
    t0 = t
    timeline = []
    while t <= t_end + 25:
        clock[0] = 1_000_000.0 + (t - t0)
        src.advance(t)
        ch = eng.poll()
        for i in ch["opened"]:
            timeline.append((t, "open", i))
        for i in ch["escalated"]:
            timeline.append((t, "escalate", i))
        for i in ch["resolved"]:
            timeline.append((t, "resolve", i))
        t += 1.0
    allinc = eng.closed + list(eng.open.values())
    by_kind = {}
    for i in allinc:
        by_kind.setdefault(i["kind"], []).append(i)
    # time-to-alert for every pin streak: first pin of the streak vs the engine's open time
    streaks = []
    cur = None
    for e in src.events:
        n = str(e.get("note", ""))
        if inc.STRIKE_RE.match(n):
            if cur and e["t"] - cur[1] <= inc.CFG["streak_gap_s"]:
                cur[1] = e["t"]
                cur[2] += 1
            else:
                if cur:
                    streaks.append(cur)
                cur = [e["t"], e["t"], 1]
    if cur:
        streaks.append(cur)
    stuck_inc = sorted(by_kind.get("stuck", []), key=lambda i: i["t_open"])
    return {"run": src.run, "ticks": len(src.ticks), "duration_s": round(t_end - t0), "streaks": streaks, "by_kind": by_kind, "incidents": allinc,
            "timeline": timeline, "logs": src.logs, "stuck": stuck_inc, "t0": t0}


def report(r):
    print("=" * 100)
    print("%s   %d ticks, %d s" % (r["run"], r["ticks"], r["duration_s"]))
    kinds = {k: len(v) for k, v in r["by_kind"].items()}
    print("incidents:", kinds or "none")
    streaks = r["streaks"]
    long5 = [s for s in streaks if (s[1] - s[0]) + inc.CFG["first_strike_s"] >= inc.CFG["stuck_warn_s"]]
    lost = sum((s[1] - s[0]) + inc.CFG["first_strike_s"] for s in streaks)
    print("pin streaks: %d total, %d lasting >= %.0fs, ~%.0fs (%.1f%% of the run) spent pinned" % (len(streaks), len(long5), inc.CFG["stuck_warn_s"], lost, 100.0 * lost / max(1, r["duration_s"])))
    stuck_t = sorted(i["t_open"] for i in r["by_kind"].get("stuck", []))
    # raise-time: engine open time (sim clock) vs streak start
    tta = []
    for s in long5:
        opened = [i for i in r["by_kind"].get("stuck", []) if abs((i["t_open"] - 1_000_000.0 + r["t0"]) - s[0]) < 40 and (i["t_open"] - 1_000_000.0 + r["t0"]) >= s[0] - 0.5]
        if opened:
            tta.append(min((i["t_open"] - 1_000_000.0 + r["t0"]) for i in opened) - s[0])
    if tta:
        tta.sort()
        print("time from the first pin of a streak to the STUCK alert: median %.1fs, max %.1fs (n=%d)" % (tta[len(tta) // 2], tta[-1], len(tta)))
    for k in ("hotspot", "stuck", "idle", "loop", "wedge", "code", "feed"):
        for i in sorted(r["by_kind"].get(k, []), key=lambda x: -(x.get("dur_s") or 0))[:5]:
            pos = i.get("pos")
            print("  %-8s %-4s %-5s %6.0fs  %s%s" % (k, i["id"], i["sev"], i.get("dur_s") or 0, ("at (%.0f,%.0f) " % tuple(pos)) if pos else "", (i.get("detail") or "")[:110]))
    alerts = sum(i["alerts"] for i in r["incidents"])
    print("alerts that would have woken MiniMax: %d over %d s (%.1f per hour)" % (alerts, r["duration_s"], alerts * 3600.0 / max(1, r["duration_s"])))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("run", nargs="?")
    ap.add_argument("--latest", action="store_true")
    ap.add_argument("--scene")
    ap.add_argument("--last", type=int, default=3)
    a = ap.parse_args()
    runs = sorted(glob.glob(os.path.join(AGENT, "runs", "*")), key=os.path.getmtime)
    if a.run:
        sel = [os.path.join(AGENT, "runs", a.run)] if not os.path.isdir(a.run) else [a.run]
    elif a.latest:
        sel = runs[-1:]
    elif a.scene:
        sel = [r for r in runs if a.scene.lower() in os.path.basename(r).lower()][-a.last:]
    else:
        sel = runs[-a.last:]
    for r in sel:
        res = replay(r)
        if res:
            report(res)
    return 0


if __name__ == "__main__":
    sys.exit(main())
