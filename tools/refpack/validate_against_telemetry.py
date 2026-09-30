"""validate_against_telemetry — empirical check of the terrain model against real bot runs.

bot-log.jsonl (BepInEx\\plugins) records the hero position (`pos`=[x,z]) ~4x/s together with mode and notes such as
`stuck:N`, `snap`, `unstick:N`. For every scene present in the log this script reports
  * how many logged hero positions lie on the navmesh surface / in the hero-walkable set (the hero physically cannot stand
    where the model says 'blocked', so a high in-set rate is evidence the model is right), and
  * where the stuck/snap/unstick events cluster, and what the model says about that spot (inside a building collider,
    distance to the nearest blocker, nearest build slot and its recommended stand points).

usage: python validate_against_telemetry.py [--log PATH] [--out DIR]
"""
from __future__ import annotations

import argparse
import collections
import glob
import json
import math
import os
import re

import numpy as np
import scipy.ndimage as ndi

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
LOG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl"


def unrle(rows, w):
    a = np.zeros((len(rows), w), dtype=bool)
    for j, runs in enumerate(rows):
        for s, n in runs:
            a[j, s:s + n] = True
    return a


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--log", default=LOG)
    ap.add_argument("--out", default=os.path.join(REF, "verification"))
    a = ap.parse_args()
    by_scene = collections.defaultdict(list)
    with open(a.log, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            try:
                d = json.loads(line)
            except ValueError:
                continue
            if d.get("state") != "InMatch" or not d.get("pos") or d["pos"] == [0, 0]:
                continue
            by_scene[d.get("scene")].append(d)
    report = {"log": a.log, "scenes": {}}
    for tpath in sorted(glob.glob(os.path.join(REF, "data", "terrain", "*.json"))):
        t = json.load(open(tpath, encoding="utf-8"))
        rows = by_scene.get(t["scene"])
        if not rows:
            continue
        g = t["grid"]
        res, w, h = g["resolution"], g["width"], g["height"]
        x0, z0 = g["originXZ"]
        surf = unrle(g["navSurfaceRLE"], w)
        wstat = unrle(g["walkableStaticRLE"], w)
        wall = unrle(g["walkableWithBuildingsRLE"], w)
        near_surface = ndi.binary_dilation(surf, iterations=int(0.6 / res))     # navmesh keeps ~0.5 m from walls: allow that margin
        dist_free = ndi.distance_transform_edt(~wall) * res                      # distance to the nearest hero-free (all built) cell
        dist_blocked = ndi.distance_transform_edt(wall) * res                    # distance to the nearest blocked/off-surface cell
        inside = collections.Counter()
        for d in rows:
            x, z = d["pos"]
            i, j = int((x - x0) / res), int((z - z0) / res)
            inside["total"] += 1
            if not (0 <= i < w and 0 <= j < h):
                inside["outside-grid"] += 1
                continue
            inside["on-surface"] += bool(near_surface[j, i])
            inside["in-walkable-unbuilt"] += bool(wstat[j, i])
            inside["in-walkable-all-built"] += bool(wall[j, i])
        n = max(inside["total"], 1)
        sc = {"ticks": inside["total"], "pctOnNavSurface(±0.6m)": round(100 * inside["on-surface"] / n, 2), "pctInWalkableUnbuilt": round(100 * inside["in-walkable-unbuilt"] / n, 2),
              "pctInWalkableAllBuilt": round(100 * inside["in-walkable-all-built"] / n, 2), "pctOutsideGrid": round(100 * inside["outside-grid"] / n, 2)}
        # stuck clusters
        ev = [d for d in rows if str(d.get("note", "")).startswith(("stuck", "snap", "unstick"))]
        clusters = collections.defaultdict(list)
        for d in ev:
            clusters[(round(d["pos"][0] / 4), round(d["pos"][1] / 4))].append(d)
        slots = t["slots"]
        out = []
        for key, lst in sorted(clusters.items(), key=lambda kv: -len(kv[1]))[:8]:
            cx = float(np.mean([d["pos"][0] for d in lst]))
            cz = float(np.mean([d["pos"][1] for d in lst]))
            i, j = int((cx - x0) / res), int((cz - z0) / res)
            ok = 0 <= i < w and 0 <= j < h
            near = sorted(slots, key=lambda s_: math.hypot(s_["pos"][0] - cx, s_["pos"][2] - cz))[:1]
            ns = near[0] if near else None
            modes = collections.Counter(d.get("mode") for d in lst).most_common(3)
            out.append({"centerXZ": [round(cx, 1), round(cz, 1)], "events": len(lst), "modes": modes,
                        "insideWalkableAllBuilt": bool(wall[j, i]) if ok else None, "insideWalkableUnbuilt": bool(wstat[j, i]) if ok else None,
                        "distToNearestHeroFreeCellM": round(float(dist_free[j, i]), 2) if ok else None, "distToNearestBlockedM": round(float(dist_blocked[j, i]), 2) if ok else None,
                        "nearestSlot": {"name": ns["name"], "building": ns["building"], "pos": ns["pos"], "distM": round(math.hypot(ns["pos"][0] - cx, ns["pos"][2] - cz), 1),
                                        "recommendedStandPoints": ns["standPoints"][:2]} if ns else None})
        sc["stuckEvents"] = len(ev)
        sc["topStuckClusters"] = out
        report["scenes"][t["scene"]] = sc
        print(f"{t['scene']:24s} ticks={sc['ticks']:6d}  onNavSurface={sc['pctOnNavSurface(±0.6m)']}%  inWalkableUnbuilt={sc['pctInWalkableUnbuilt']}%  inWalkableAllBuilt={sc['pctInWalkableAllBuilt']}%  stuckEvents={len(ev)}")
        for c in out[:4]:
            print(f"    cluster {c['centerXZ']} n={c['events']} modes={c['modes']} inWalkableAllBuilt={c['insideWalkableAllBuilt']} distToFree={c['distToNearestHeroFreeCellM']} nearest={c['nearestSlot'] and (c['nearestSlot']['building'], c['nearestSlot']['distM'])}")
    os.makedirs(a.out, exist_ok=True)
    with open(os.path.join(a.out, "telemetry_validation.json"), "w", encoding="utf-8") as fh:
        json.dump(report, fh, indent=1)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
