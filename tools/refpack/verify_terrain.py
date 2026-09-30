"""verify_terrain — cross-check two independent extractions per scene:
   (A) hero-reachable area rebuilt from collider geometry (extract_terrain.py), and
   (B) the baked A* 'Player Units S' navmesh (extract_navmesh.py).
The hero and allied units walk in the same valley, so (A) should mostly lie inside (B). Reported per scene:
   coverage  = |A ∩ B| / |A|   (share of hero-reachable cells that the navmesh also covers)
   navUsed   = |A ∩ B| / |B|   (share of the navmesh the hero can actually reach)
Also lists scenes with suspicious values so they can be inspected instead of trusted.

usage: python verify_terrain.py
"""
from __future__ import annotations

import glob
import json
import os
import sys

import numpy as np
import scipy.ndimage as ndi

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from extract_navmesh import rasterize  # noqa: E402

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"


def unrle(rows, w):
    a = np.zeros((len(rows), w), dtype=bool)
    for j, runs in enumerate(rows):
        for s, n in runs:
            a[j, s:s + n] = True
    return a


def main() -> int:
    out = []
    for tpath in sorted(glob.glob(os.path.join(REF, "data", "terrain", "*.json"))):
        base = os.path.basename(tpath)
        npath = os.path.join(REF, "data", "navmesh", base)
        if not os.path.exists(npath):
            continue
        t = json.load(open(tpath, encoding="utf-8"))
        n = json.load(open(npath, encoding="utf-8"))
        gd = t["grid"]
        res = gd["resolution"]
        w, h = gd["width"], gd["height"]
        x0, z0 = gd["originXZ"]
        blocked = unrle(gd["blockedWithBuildingsRLE"], w)
        free = ~blocked
        home = t["reachability"]["homeXZ"]
        lab, _ = ndi.label(free, structure=np.ones((3, 3)))
        i, j = int((home[0] - x0) / res), int((home[1] - z0) / res)
        reach = lab == lab[j, i]
        ng = next((g for g in n["graphs"] if g["name"].startswith("Player Units S") and g.get("triangles")), None)
        rec = {"scene": t["scene"], "buildIndex": t["buildIndex"], "heroReachableM2": round(float(reach.sum()) * res * res, 1), "slots": t["reachability"]["slotsTotal"],
               "slotsWithoutStandPoint": t["reachability"]["slotsWithoutStandPoint"], "staticBlockedPct": round(100 * t["stats"]["blockedStaticCells"] / t["stats"]["totalCells"], 2),
               "obstacles": t["stats"]["obstacles"]}
        if ng:
            verts = np.array(ng["vertices"])
            tris = np.array(ng["triangles"])
            nav = rasterize(tris, verts, x0, z0, w, h, res)
            inter = reach & nav
            rec.update({"navmeshM2": round(float(nav.sum()) * res * res, 1), "coveragePct": round(100 * inter.sum() / max(reach.sum(), 1), 1), "navUsedPct": round(100 * inter.sum() / max(nav.sum(), 1), 1)})
        flags = []
        if rec["staticBlockedPct"] < 0.05:
            flags.append("almost no static blockers rasterised")
        if rec.get("coveragePct") is not None and rec["coveragePct"] < 60:
            flags.append("hero area only partly inside navmesh")
        if rec["slotsWithoutStandPoint"]:
            flags.append(f"{rec['slotsWithoutStandPoint']} slots without stand point")
        rec["flags"] = flags
        out.append(rec)
        print(f"{rec['buildIndex']:2d} {rec['scene']:38s} hero={rec['heroReachableM2']:8.0f} m2  nav={rec.get('navmeshM2', 0):8.0f} m2  coverage={rec.get('coveragePct')}%  navUsed={rec.get('navUsedPct')}%  static={rec['staticBlockedPct']}%  {flags}")
    os.makedirs(os.path.join(REF, "verification"), exist_ok=True)
    json.dump(out, open(os.path.join(REF, "verification", "terrain_vs_navmesh.json"), "w", encoding="utf-8"), indent=1)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
