#!/usr/bin/env python3
"""Pin report: how long the hero stands still while it is supposed to be travelling.

An episode = hero moved < 1.0 m over >= MIN_S seconds while mode is a travel mode
(SpendGold/CollectCoin/PositionArmy/ReturnHome) and nothing is being paid (gold unchanged),
by day. Reports count, total seconds, share of day travel time, and the duration histogram.

Usage: python pin-report.py [--runs N] [--scene Frostsee] [--min 3]
"""
import argparse, glob, json, math, os
from collections import Counter

AG = os.environ.get("TF_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")
ap = argparse.ArgumentParser()
ap.add_argument("--runs", type=int, default=8)
ap.add_argument("--scene", default="")
ap.add_argument("--min", type=float, default=3.0)
a = ap.parse_args()
TRAVEL = ("SpendGold", "CollectCoin", "PositionArmy", "ReturnHome")
runs = sorted(glob.glob(os.path.join(AG, "runs", "*" + a.scene + "*")), key=os.path.getmtime)
runs = [r for r in runs if "Level" not in r and not r.endswith("_UI")][-a.runs:]
hist = Counter()
eps = []
travel_s = still_s = 0.0
for d in runs:
    anchor = None
    gold0 = None
    prev = None
    for ln in open(d + "/ticks.jsonl", encoding="utf-8", errors="replace"):
        try:
            t = json.loads(ln)
        except ValueError:
            continue
        if t.get("state") != "InMatch" or not t.get("pos") or t.get("night") or t.get("mode") not in TRAVEL:
            anchor = None
            prev = None
            continue
        if prev is not None and 0 < t["t"] - prev["t"] < 1.5:
            travel_s += t["t"] - prev["t"]
        prev = t
        p = t["pos"]
        if anchor is None or math.dist(p, anchor[0]) >= 1.0 or t.get("gold") != anchor[2]:
            if anchor is not None and anchor[3] - anchor[1] >= a.min:
                eps.append((os.path.basename(d), anchor[1], anchor[3] - anchor[1], t.get("mode")))
            anchor = (p, t["t"], t.get("gold"), t["t"])
        else:
            anchor = (anchor[0], anchor[1], anchor[2], t["t"])
for e in eps:
    still_s += e[2]
    hist["3-6" if e[2] < 6 else "6-12" if e[2] < 12 else "12-30" if e[2] < 30 else "30+"] += 1
print(f"runs={len(runs)} travel_s={travel_s:.0f} pinned_episodes(>={a.min:.0f}s)={len(eps)} pinned_s={still_s:.0f} "
      f"share={100 * still_s / max(travel_s, 1):.1f}% hist={dict(hist)}")
for e in sorted(eps, key=lambda x: -x[2])[:6]:
    print("  longest:", e[0], "t=%.0f" % e[1], "%.0fs" % e[2], e[3])
