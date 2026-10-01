#!/usr/bin/env python3
"""Navigation scorecard per run: how much of the time the hero was stuck, how it got out, and how the match ended.

Reads BepInEx\\plugins\\agent\\runs\\<runId>\\{ticks,events}.jsonl (+ summary.json when the match finished) and prints one line per run
plus an aggregate. Everything is computed from recorded data; nothing is estimated.

Definitions (same as tools/pin-report.py so the numbers are comparable):
  travel_s   seconds in a travel mode (SpendGold / CollectCoin / PositionArmy / ReturnHome) by day
  pinned     an episode where the hero moved < 1.0 m for >= MIN_S seconds while travelling and no gold was paid
  long       pinned episodes >= 30 s;   trapped = longest still period of the run (any mode, by day)
  gps        [gps] plan / crossed / failed lines in BepInEx\\LogOutput.log (only the CURRENT log, i.e. the current game session)

Usage:  python nav-report.py [--since 20261001T103323Z] [--until ID] [--scene Frostsee] [--last N] [--min 3]
"""
import argparse, glob, json, math, os, re
from collections import Counter

GAME = os.environ.get("TF_GAME", r"K:\Downloads-IDM\Thronefall")
AG = os.environ.get("TF_AGENT", os.path.join(GAME, "BepInEx", "plugins", "agent"))
TRAVEL = ("SpendGold", "CollectCoin", "PositionArmy", "ReturnHome")

ap = argparse.ArgumentParser()
ap.add_argument("--since", default="")
ap.add_argument("--until", default="")
ap.add_argument("--scene", default="")
ap.add_argument("--last", type=int, default=0)
ap.add_argument("--min", type=float, default=3.0)
a = ap.parse_args()


def load(path):
    out = []
    try:
        for ln in open(path, encoding="utf-8", errors="replace"):
            try:
                out.append(json.loads(ln))
            except ValueError:
                pass
    except OSError:
        pass
    return out


def analyse(d):
    name = os.path.basename(d)
    ticks = load(os.path.join(d, "ticks.jsonl"))
    events = load(os.path.join(d, "events.jsonl"))
    summ = {}
    try:
        summ = json.load(open(os.path.join(d, "summary.json"), encoding="utf-8"))
    except (OSError, ValueError):
        pass
    travel_s = pinned_s = 0.0
    eps = []
    anchor = None
    prev = None
    still_best = 0.0
    sanchor = None
    for t in ticks:
        pos = t.get("pos")
        if t.get("state") != "InMatch" or not pos or t.get("night"):
            anchor = None; prev = None; sanchor = None
            continue
        # longest still period (any day mode)
        if sanchor is None or math.dist(pos, sanchor[0]) >= 1.0:
            sanchor = (pos, t["t"])
        else:
            still_best = max(still_best, t["t"] - sanchor[1])
        if t.get("mode") not in TRAVEL:
            anchor = None; prev = None
            continue
        if prev is not None and 0 < t["t"] - prev["t"] < 1.5:
            travel_s += t["t"] - prev["t"]
        prev = t
        if anchor is None or math.dist(pos, anchor[0]) >= 1.0 or t.get("gold") != anchor[2]:
            if anchor is not None and anchor[3] - anchor[1] >= a.min:
                eps.append(anchor[3] - anchor[1])
            anchor = (pos, t["t"], t.get("gold"), t["t"])
        else:
            anchor = (anchor[0], anchor[1], anchor[2], t["t"])
    pinned_s = sum(eps)
    ev = Counter(e.get("note", "") for e in events)
    dur = ticks[-1]["t"] - ticks[0]["t"] if len(ticks) > 1 else 0.0
    return {
        "run": name, "dur": dur, "travel": travel_s, "pinned": pinned_s, "eps": len(eps), "long": sum(1 for e in eps if e >= 30),
        "still": still_best, "stuck": ev.get("stuck:1", 0), "parks": ev.get("pin-park", 0), "timeouts": ev.get("approach-timeout", 0),
        "unreach": ev.get("build-unreachable", 0) + ev.get("aim-unreachable", 0), "stall": ev.get("build-stall", 0),
        "result": summ.get("result", "-" if summ else "running/killed"), "waves": summ.get("waves", ""), "gold": summ.get("goldLast", ""),
    }


runs = sorted(glob.glob(os.path.join(AG, "runs", "*" + a.scene + "*")), key=lambda p: os.path.basename(p))
runs = [r for r in runs if "_LevelSelect" not in r and not r.endswith("_UI")]
if a.since:
    runs = [r for r in runs if os.path.basename(r) >= a.since]
if a.until:
    runs = [r for r in runs if os.path.basename(r) <= a.until]
if a.last:
    runs = runs[-a.last:]
rows = [analyse(r) for r in runs]
rows = [r for r in rows if r["dur"] > 30]
print("%-26s %6s %7s %6s %4s %4s %6s %5s %5s %4s %5s %-8s %5s %6s" % (
    "run", "dur_s", "travel", "pin_s", "eps", "long", "still", "stuck", "parks", "tmo", "unrch", "result", "waves", "gold"))
for r in rows:
    print("%-26s %6.0f %7.0f %6.0f %4d %4d %6.0f %5d %5d %4d %5d %-8s %5s %6s" % (
        r["run"], r["dur"], r["travel"], r["pinned"], r["eps"], r["long"], r["still"], r["stuck"], r["parks"], r["timeouts"],
        r["unreach"], r["result"], r["waves"], r["gold"]))
tr = sum(r["travel"] for r in rows); pn = sum(r["pinned"] for r in rows)
print("TOTAL runs=%d travel_s=%.0f pinned_s=%.0f share=%.1f%% episodes=%d long(>=30s)=%d  victories=%d defeats=%d" % (
    len(rows), tr, pn, 100 * pn / max(tr, 1), sum(r["eps"] for r in rows), sum(r["long"] for r in rows),
    sum(1 for r in rows if r["result"] == "victory"), sum(1 for r in rows if r["result"] == "defeat")))

log = os.path.join(GAME, "BepInEx", "LogOutput.log")
if os.path.exists(log):
    gps = Counter()
    for ln in open(log, encoding="utf-8", errors="replace"):
        m = re.search(r"\[gps\] (plan|crossed|gate #\d+ failed|no gate chain|at gate|reset|goal changed)", ln)
        if m:
            gps[m.group(1).split(" #")[0] if m.group(1).startswith("gate") else m.group(1)] += 1
    print("gps (current game session log):", dict(gps))
