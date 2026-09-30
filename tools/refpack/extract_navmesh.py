"""extract_navmesh — the baked A* recast navmeshes that ground enemies / allied units walk on.

Each scene's `AstarPath` component stores (a) graph settings as a zip inside `data.dataString` (base64) and (b) with
`cacheStartup=true` the *baked* graph data in a TextAsset (`file_cachedStartup`, a zip with `graphN_extra.binary`).
Format (verified against the shipped Pathfinding.NavmeshBase.DeserializeExtraInfo, A* 4.2.18 data):
    int32 tileXCount, int32 tileZCount
    per tile:  int32 x, int32 z, [alias when (x,z) != position]  int32 w, int32 d,
               int32 nTris   + nTris   * int32       (triangle vertex indices)
               int32 nVerts  + nVerts  * 3 * int32   (Int3, world space, 1000 units = 1 m)
               int32 nVertsG + nVertsG * 3 * int32   (graph space; A* >= 4)
               int32 nNodes  ...                     (per-node data; not needed here)

For every spawn line the script traces the cheapest ground route to the castle on the 'Enemy Units S' graph and reports
length, narrowest point ("choke") and travel time per enemy speed.

usage: python extract_navmesh.py [--scenes REGEX] [--res 0.5]
"""
from __future__ import annotations

import argparse
import base64
import collections
import io
import json
import math
import os
import re
import struct
import sys
import time
import zipfile

import numpy as np
import scipy.ndimage as ndi
from skimage.graph import MCP_Geometric

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tf_assets as A  # noqa: E402

DATA = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"
MAPS = r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps"
REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
OUT = os.path.join(REF, "data", "navmesh")
IMG = os.path.join(REF, "img", "maps")


class R:
    def __init__(self, b: bytes):
        self.b, self.p = b, 0

    def i32(self) -> int:
        v = struct.unpack_from("<i", self.b, self.p)[0]
        self.p += 4
        return v

    def ints(self, n: int) -> np.ndarray:
        a = np.frombuffer(self.b, dtype="<i4", count=n, offset=self.p)
        self.p += 4 * n
        return a


def parse_graph(raw: bytes) -> dict:
    r = R(raw)
    tx, tz = r.i32(), r.i32()
    tiles = []
    for zi in range(tz):
        for xi in range(tx):
            x, z = r.i32(), r.i32()
            if x != xi or z != zi:
                continue  # alias of another tile
            w, d = r.i32(), r.i32()
            nt = r.i32()
            tris = r.ints(nt).reshape(-1, 3)
            nv = r.i32()
            verts = r.ints(nv * 3).reshape(-1, 3) / 1000.0
            ng = r.i32()
            r.ints(ng * 3)  # graph-space vertices (unused)
            nn = r.i32()
            tiles.append({"x": x, "z": z, "w": w, "d": d, "tris": tris, "verts": verts, "nodeCount": nn})
            if tx * tz > 1:
                raise NotImplementedError("multi-tile graph: node payload parser not implemented")
            return {"tileX": tx, "tileZ": tz, "tiles": tiles}
    return {"tileX": tx, "tileZ": tz, "tiles": tiles}


def load_graphs(g: A.Game, f: A.SFile) -> list[dict]:
    pid, m = next(iter(f.monobehaviours("AstarPath")))
    d = m.v["data"]
    settings = zipfile.ZipFile(io.BytesIO(base64.b64decode(d["dataString"])))
    meta = settings.read("meta.json").decode("utf-8", "replace")
    names = [n for n in settings.namelist() if re.fullmatch(r"graph\d+\.json", n)]
    graphs = []
    src = settings
    cache = None
    ref = f.ref(d["file_cachedStartup"])
    if ref:
        o = g.file(ref[0]).sf.objects.get(ref[1])
        t = o.read()
        raw = t.m_Script if isinstance(t.m_Script, (bytes, bytearray)) else t.m_Script.encode("utf-8", "surrogateescape")
        cache = zipfile.ZipFile(io.BytesIO(raw))
        cnames = [n for n in cache.namelist() if re.fullmatch(r"graph\d+\.json", n)]
        if cnames:
            src, names = cache, cnames  # the baked binary belongs to these settings
    for n in sorted(names, key=lambda s_: int(re.findall(r"\d+", s_)[0])):
        graphs.append(json.loads(src.read(n).decode("utf-8", "replace")))
    out = []
    for i, js in enumerate(graphs):
        mask = js.get("mask", js.get("layerMask"))
        rec = {"index": i, "name": js.get("name"), "characterRadius": js.get("characterRadius"), "cellSize": js.get("cellSize"), "maxSlope": js.get("maxSlope"),
               "walkableClimb": js.get("walkableClimb"), "walkableHeight": js.get("walkableHeight"),
               "layerMask": (mask.get("value") if isinstance(mask, dict) else mask),
               "boundsCenter": [js["forcedBoundsCenter"][k] for k in "xyz"], "boundsSize": [js["forcedBoundsSize"][k] for k in "xyz"], "cachedStartup": bool(cache),
               "settingsSource": "cache" if src is cache else "dataString"}
        if cache and f"graph{i}_extra.binary" in cache.namelist():
            try:
                pg = parse_graph(cache.read(f"graph{i}_extra.binary"))
                rec["parsed"] = pg
            except Exception as e:  # noqa: BLE001
                rec["error"] = repr(e)
        out.append(rec)
    return out, meta


def rasterize(tris, verts, x0, z0, w, h, res):
    grid = np.zeros((h, w), dtype=bool)
    for a, b, c in tris:
        p = verts[[a, b, c]][:, [0, 2]]
        i0 = max(int((p[:, 0].min() - x0) / res), 0)
        i1 = min(int((p[:, 0].max() - x0) / res) + 1, w)
        j0 = max(int((p[:, 1].min() - z0) / res), 0)
        j1 = min(int((p[:, 1].max() - z0) / res) + 1, h)
        if i1 <= i0 or j1 <= j0:
            continue
        gx = x0 + (np.arange(i0, i1) + 0.5) * res
        gz = z0 + (np.arange(j0, j1) + 0.5) * res
        X, Z = np.meshgrid(gx, gz)
        (ax, az), (bx, bz), (cx, cz) = p
        den = (bz - cz) * (ax - cx) + (cx - bx) * (az - cz)
        if abs(den) < 1e-9:
            continue
        l1 = ((bz - cz) * (X - cx) + (cx - bx) * (Z - cz)) / den
        l2 = ((cz - az) * (X - cx) + (ax - cx) * (Z - cz)) / den
        l3 = 1 - l1 - l2
        grid[j0:j1, i0:i1] |= (l1 >= -1e-6) & (l2 >= -1e-6) & (l3 >= -1e-6)
    return grid


def simplify(path, tol=1.0):
    """Ramer–Douglas–Peucker on a polyline of (x, z)."""
    if len(path) < 3:
        return path
    a, b = np.array(path[0]), np.array(path[-1])
    ab = b - a
    n = np.hypot(*ab)
    pts = np.array(path[1:-1])
    d = np.abs(ab[0] * (pts[:, 1] - a[1]) - ab[1] * (pts[:, 0] - a[0])) / n if n > 1e-9 else np.hypot(*(pts - a).T)
    k = int(np.argmax(d))
    if d[k] > tol:
        left = simplify(path[:k + 2], tol)
        right = simplify(path[k + 1:], tol)
        return left[:-1] + right
    return [path[0], path[-1]]


def scene(g: A.Game, scene_name: str, idx: int, res: float) -> dict:
    f = g.file(g.scene_file(scene_name))
    graphs, meta = load_graphs(g, f)
    info = {"scene": scene_name, "buildIndex": idx, "astarMeta": meta, "graphs": []}
    # common raster extent = union of all graph bounds
    xs, zs = [], []
    for gr in graphs:
        cx, _, cz = gr["boundsCenter"]
        sx, _, sz = gr["boundsSize"]
        xs += [cx - sx / 2, cx + sx / 2]
        zs += [cz - sz / 2, cz + sz / 2]
    x0, x1, z0, z1 = min(xs), max(xs), min(zs), max(zs)
    W, H = int(math.ceil((x1 - x0) / res)), int(math.ceil((z1 - z0) / res))
    rasters = {}
    for gr in graphs:
        rec = {k: v for k, v in gr.items() if k != "parsed"}
        pg = gr.get("parsed")
        if pg and pg["tiles"]:
            t = pg["tiles"][0]
            tris, verts = t["tris"], t["verts"]
            area = 0.0
            for a, b, c in tris:
                p = verts[[a, b, c]][:, [0, 2]]
                area += abs((p[1, 0] - p[0, 0]) * (p[2, 1] - p[0, 1]) - (p[1, 1] - p[0, 1]) * (p[2, 0] - p[0, 0])) / 2
            rec.update({"triangleCount": int(len(tris)), "vertexCount": int(len(verts)), "areaM2": round(area, 1),
                        "vertices": [[round(float(x), 2), round(float(y), 2), round(float(z), 2)] for x, y, z in verts], "triangles": tris.tolist(),
                        "nodeCountFromFile": t["nodeCount"]})
            rasters[gr["index"]] = rasterize(tris, verts, x0, z0, W, H, res)
        info["graphs"].append(rec)
    info["raster"] = {"resolution": res, "originXZ": [round(x0, 2), round(z0, 2)], "width": W, "height": H}

    # ---- enemy routes: spawn line -> castle on the ground graph
    castle = [f.world_pos(f.transform_of_go(m.go)) for _, m in f.monobehaviours("TaggedObject") if 3 in m.v["tags"]]
    routes = []
    gi = next((gr["index"] for gr in graphs if gr["name"].startswith("Enemy Units S")), None)
    if gi is not None and gi in rasters and castle:
        walk = rasters[gi]
        clear = ndi.distance_transform_edt(walk) * res
        lab, _ = ndi.label(walk, structure=np.ones((3, 3)))
        cx, cz = castle[0][0], castle[0][2]

        def nearest_walk(x, z, lab_ok=None):
            i, j = int((x - x0) / res), int((z - z0) / res)
            best = None
            for rad in range(0, 200):
                for dj in range(-rad, rad + 1):
                    for di in range(-rad, rad + 1):
                        if max(abs(di), abs(dj)) != rad:
                            continue
                        ii, jj = i + di, j + dj
                        if 0 <= ii < W and 0 <= jj < H and walk[jj, ii] and (lab_ok is None or lab[jj, ii] == lab_ok):
                            d = di * di + dj * dj
                            if best is None or d < best[0]:
                                best = (d, ii, jj)
                if best:
                    return best[1], best[2]
            return None

        target = nearest_walk(cx, cz)
        if target:
            comp = lab[target[1], target[0]]
            mcp = MCP_Geometric(np.where(lab == comp, 1.0, np.inf), fully_connected=True)
            for _, m in f.monobehaviours("EnemySpawnLine"):
                kids = [f.world_pos(k) for k in f.tf(f.transform_of_go(m.go))["children"]]
                if not kids:
                    continue
                mx, mz = sum(k[0] for k in kids) / len(kids), sum(k[2] for k in kids) / len(kids)
                s = nearest_walk(mx, mz, comp)
                rec = {"line": f.go(m.go)["name"], "spawnCenterXZ": [round(mx, 1), round(mz, 1)], "canSpawnFlying": m.v["canSpawnFlying"], "canSpawnSmallGround": m.v["canSpawnSmallGround"]}
                if s is None:
                    rec["route"] = None
                    rec["note"] = "spawn line is not on the castle's connected ground navmesh (flyer-only or disconnected)"
                    routes.append(rec)
                    continue
                cum, tb = mcp.find_costs([(s[1], s[0])], [(target[1], target[0])])
                idxs = mcp.traceback((target[1], target[0]))
                pts = [(x0 + (i + 0.5) * res, z0 + (j + 0.5) * res) for j, i in idxs]
                length = float(cum[target[1], target[0]]) * res
                cl = [float(clear[j, i]) for j, i in idxs]
                # the narrowest point of the ROUTE: ignore the first/last 8 m (spawn-line edge and castle surroundings)
                seg = np.hypot(np.diff([p[0] for p in pts]), np.diff([p[1] for p in pts])) if len(pts) > 1 else np.array([0.0])
                cumd = np.concatenate([[0.0], np.cumsum(seg)])
                inner = [n for n in range(len(pts)) if cumd[n] >= 8.0 and (cumd[-1] - cumd[n]) >= 8.0]
                k = min(inner, key=lambda n: cl[n]) if inner else int(np.argmin(cl))
                rec.update({"lengthM": round(length, 1), "waypoints": [[round(x, 1), round(z, 1)] for x, z in simplify(pts, 1.5)],
                            "narrowestClearanceM": round(cl[k], 2), "narrowestAtXZ": [round(pts[k][0], 1), round(pts[k][1], 1)],
                            "secondsAtSpeed": {str(v): round(length / v, 1) for v in (2, 4, 5, 6.5, 8, 10)}})
                routes.append(rec)
    info["castle"] = [[round(c, 2) for c in p] for p in castle]
    info["enemyRoutes"] = routes

    # ---- preview
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    os.makedirs(IMG, exist_ok=True)
    fig, ax = plt.subplots(figsize=(11, 11 * (z1 - z0) / max(x1 - x0, 1)))
    img = np.full((H, W, 3), 0.96)
    colors = {0: (0.55, 0.75, 0.95), 1: (0.6, 0.85, 0.6), 2: (0.95, 0.75, 0.5), 3: (0.85, 0.7, 0.95)}
    for gi_, ras in rasters.items():
        if gi_ in (0, 1):
            img[ras] = colors[gi_] if gi_ == 0 else np.minimum(img[ras], colors[1]) if False else colors[gi_]
    if 0 in rasters:
        img[rasters[0]] = colors[0]
    ax.imshow(img, origin="lower", extent=(x0, x0 + W * res, z0, z0 + H * res), interpolation="nearest")
    for rt in routes:
        if rt.get("waypoints"):
            ax.plot([p[0] for p in rt["waypoints"]], [p[1] for p in rt["waypoints"]], c="#d1362f", lw=1.8)
            ax.scatter([rt["narrowestAtXZ"][0]], [rt["narrowestAtXZ"][1]], c="k", s=18, zorder=5)
    if castle:
        ax.scatter([p[0] for p in castle], [p[2] for p in castle], s=150, marker="*", c="#f2b600", edgecolors="k", zorder=6)
    ax.set_title(f"{scene_name}: baked 'Enemy Units S' navmesh (blue), spawn→castle ground routes (red), narrowest point (black dot)")
    safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene_name)
    fig.savefig(os.path.join(IMG, f"{idx:02d}_{safe}_navmesh_routes.png"), dpi=100, bbox_inches="tight")
    plt.close(fig)
    return info


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenes", default=r"^[^_]")
    ap.add_argument("--res", type=float, default=0.5)
    a = ap.parse_args()
    g = A.Game(DATA, MAPS)
    os.makedirs(OUT, exist_ok=True)
    rx = re.compile(a.scenes)
    for idx, sc in enumerate(g.scene_names):
        if sc.startswith("_") or idx < 4 or not rx.search(sc):
            continue
        t0 = time.time()
        try:
            info = scene(g, sc, idx, a.res)
        except Exception as e:  # noqa: BLE001
            print(f"{idx:2d} {sc:40s} ERROR {e!r}")
            continue
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", sc)
        with open(os.path.join(OUT, f"{idx:02d}_{safe}.json"), "w", encoding="utf-8") as fh:
            json.dump(info, fh, separators=(",", ":"), ensure_ascii=False)
        ok = [(gr["name"], gr.get("triangleCount"), gr.get("areaM2")) for gr in info["graphs"]]
        rr = [(r["line"], r.get("lengthM")) for r in info["enemyRoutes"]]
        print(f"{idx:2d} {sc:40s} graphs={ok} routes={rr}  {time.time() - t0:.1f}s", flush=True)
        g.drop(f"level{idx}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
