#!/usr/bin/env python3
"""Where does the hero stand still? Pin hotspots of one scene over many runs, with the build slots nearest to each hotspot.

A pin episode = hero moved < 1.0 m for >= MIN_S seconds while travelling by day (SpendGold / CollectCoin / PositionArmy / ReturnHome)
and no gold was paid (same definition as tools/pin-report.py). Episodes are binned into CELL x CELL metre cells; each hotspot lists the
total pinned seconds, the number of episodes and runs, and the nearest slots from agent/slots/<scene>.json - a hotspot next to
"Wall Segment" / "Gate" slots means the hero is stuck on walls it built itself.

Usage: python pin-hotspots.py --scene Frostsee [--since 20260929] [--cell 6] [--top 14] [--min 3]
"""
import argparse, glob, json, math, os
from collections import defaultdict

GAME = os.environ.get("TF_GAME", r"K:\Downloads-IDM\Thronefall")
AG = os.environ.get("TF_AGENT", os.path.join(GAME, "BepInEx", "plugins", "agent"))
TRAVEL = ("SpendGold", "CollectCoin", "PositionArmy", "ReturnHome")

ap = argparse.ArgumentParser()
ap.add_argument("--scene", required=True)
ap.add_argument("--since", default="20260929")
ap.add_argument("--until", default="")
ap.add_argument("--cell", type=float, default=6.0)
ap.add_argument("--top", type=int, default=14)
ap.add_argument("--min", type=float, default=3.0)
a = ap.parse_args()

runs = sorted(glob.glob(os.path.join(AG, "runs", "*" + a.scene + "*")), key=os.path.basename)
runs = [r for r in runs if "_UI" not in r and "Level" not in r and os.path.basename(r) >= a.since and (not a.until or os.path.basename(r) <= a.until)]
cells = defaultdict(lambda: [0.0, 0, set()])
total = 0.0
travel = 0.0
for d in runs:
    anchor = None
    prev = None
    try:
        lines = open(os.path.join(d, "ticks.jsonl"), encoding="utf-8", errors="replace")
    except OSError:
        continue
    for ln in lines:
        try:
            t = json.loads(ln)
        except ValueError:
            continue
        if t.get("state") != "InMatch" or not t.get("pos") or t.get("night") or t.get("mode") not in TRAVEL:
            anchor = None; prev = None
            continue
        if prev is not None and 0 < t["t"] - prev["t"] < 1.5:
            travel += t["t"] - prev["t"]
        prev = t
        p = t["pos"]
        if anchor is None or math.dist(p, anchor[0]) >= 1.0 or t.get("gold") != anchor[2]:
            if anchor is not None and anchor[3] - anchor[1] >= a.min:
                dur = anchor[3] - anchor[1]
                c = (round(anchor[0][0] / a.cell) * a.cell, round(anchor[0][1] / a.cell) * a.cell)
                cells[c][0] += dur; cells[c][1] += 1; cells[c][2].add(os.path.basename(d)[:15]); total += dur
            anchor = (p, t["t"], t.get("gold"), t["t"])
        else:
            anchor = (anchor[0], anchor[1], anchor[2], t["t"])

slots = []
try:
    slots = json.load(open(os.path.join(AG, "slots", a.scene + ".json"), encoding="utf-8"))["slots"]
except (OSError, ValueError, KeyError):
    pass


def near(c):
    best = sorted(slots, key=lambda s: math.dist((s["pos"][0], s["pos"][2]), c))[:2]
    return "; ".join("%s@%.0fm" % (b["name"].replace(" Variant", ""), math.dist((b["pos"][0], b["pos"][2]), c)) for b in best)


print("scene=%s runs=%d travel_s=%.0f pinned_s=%.0f (%.1f%% of travel)" % (a.scene, len(runs), travel, total, 100 * total / max(travel, 1)))
for c, (sec, n, rs) in sorted(cells.items(), key=lambda kv: -kv[1][0])[:a.top]:
    print("cell (%4.0f,%4.0f) %6.0f s %4d episodes %3d runs  nearest slots: %s" % (c[0], c[1], sec, n, len(rs), near(c)))
