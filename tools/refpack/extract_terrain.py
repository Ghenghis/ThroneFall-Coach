"""extract_terrain — where the hero can actually stand / walk, per scene ("why does the bot get stuck on rocks?").

Model (v2, verified against the baked A* navmesh):
  walkable surface  = the baked 'Player Units S' navmesh triangles connected to the castle (true elevation included)
  blockers          = enabled, non-trigger colliders whose physics layer collides with layer 'Player' (PhysicsManager matrix)
                      — box / sphere / capsule / mesh — including colliders of build-slot hierarchies that are inactive now
                      (they become solid when built); a blocker only counts where its vertical extent overlaps the hero
                      capsule at the *local surface height* (step offset .. height above the surface)
  hero controller   = CharacterController radius/height/step/slope/skin read from the assets (PlayerMovement.cs:6,246)
  hero-free cells   = surface cells not within (radius + skin) of any blocker
Outputs per scene: JSON (grid as run-length rows, obstacles, per-slot stand points, castle→spawn hero paths),
a compressed .npz with numpy arrays for python consumers, and a PNG preview.

Requires extract_navmesh.py to have run first.

usage: python extract_terrain.py [--scenes REGEX] [--res 0.25]
"""
from __future__ import annotations

import argparse
import collections
import json
import math
import os
import re
import sys
import time

import numpy as np
import scipy.ndimage as ndi
from skimage.graph import MCP_Geometric

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tf_assets as A  # noqa: E402

DATA = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"
MAPS = r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps"
REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
OUT = os.path.join(REF, "data", "terrain")
NAV = os.path.join(REF, "data", "navmesh")
IMG = os.path.join(REF, "img", "maps")

COLLIDERS = ("BoxCollider", "SphereCollider", "CapsuleCollider", "MeshCollider")
NAV_GRAPH = "Player Units S"


# ------------------------------------------------------------------ math helpers

def qrot(q, v):
    return A.qrot(q, v)


def to_world(world, p):
    pos, rot, scl = world
    r = qrot(rot, (p[0] * scl[0], p[1] * scl[1], p[2] * scl[2]))
    return (pos[0] + r[0], pos[1] + r[1], pos[2] + r[2])


def hull(points):
    pts = sorted(set((round(p[0], 4), round(p[1], 4)) for p in points))
    if len(pts) <= 2:
        return pts

    def cross(o, a, b):
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])

    lo, up = [], []
    for p in pts:
        while len(lo) >= 2 and cross(lo[-2], lo[-1], p) <= 0:
            lo.pop()
        lo.append(p)
    for p in reversed(pts):
        while len(up) >= 2 and cross(up[-2], up[-1], p) <= 0:
            up.pop()
        up.append(p)
    return lo[:-1] + up[:-1]


class Grid:
    """Top-down boolean grid, cell (i, j) = (x, z) index; `h` is the local surface height (NaN = no surface)."""

    def __init__(self, x0, z0, x1, z1, res, hmap=None):
        self.res = res
        self.x0, self.z0 = x0, z0
        self.w = int(math.ceil((x1 - x0) / res))
        self.h = int(math.ceil((z1 - z0) / res))
        self.a = np.zeros((self.h, self.w), dtype=bool)
        self.hmap = hmap

    def cell(self, x, z):
        return int((x - self.x0) / self.res), int((z - self.z0) / self.res)

    def _ok(self, j0, j1, i0, i1, y0, y1, step, height):
        if self.hmap is None or y0 is None:
            return None
        h = self.hmap[j0:j1, i0:i1]
        return np.isnan(h) | ((y1 > h + step) & (y0 < h + height))

    def fill_polygon(self, poly, y0=None, y1=None, step=0.3, height=3.0):
        if len(poly) < 3:
            return
        xs = [p[0] for p in poly]
        zs = [p[1] for p in poly]
        i0, j0 = self.cell(min(xs), min(zs))
        i1, j1 = self.cell(max(xs), max(zs))
        i0, j0 = max(i0, 0), max(j0, 0)
        i1, j1 = min(i1 + 1, self.w), min(j1 + 1, self.h)
        if i1 <= i0 or j1 <= j0:
            return
        gx = self.x0 + (np.arange(i0, i1) + 0.5) * self.res
        gz = self.z0 + (np.arange(j0, j1) + 0.5) * self.res
        X, Z = np.meshgrid(gx, gz)
        inside = np.ones_like(X, dtype=bool)
        n = len(poly)
        for k in range(n):
            ax, az = poly[k]
            bx, bz = poly[(k + 1) % n]
            inside &= ((bx - ax) * (Z - az) - (bz - az) * (X - ax)) >= -1e-9
        ok = self._ok(j0, j1, i0, i1, y0, y1, step, height)
        if ok is not None:
            inside &= ok
        self.a[j0:j1, i0:i1] |= inside

    def draw_segment(self, a, b, y0=None, y1=None, step=0.3, height=3.0, thickness=0.12):
        length = math.hypot(b[0] - a[0], b[1] - a[1])
        n = max(2, int(length / (self.res * 0.5)) + 1)
        r = max(0, int(thickness / self.res))
        for t in np.linspace(0.0, 1.0, n):
            x, z = a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t
            i, j = self.cell(x, z)
            if not (0 <= i < self.w and 0 <= j < self.h):
                continue
            ja, jb, ia, ib = max(j - r, 0), min(j + r + 1, self.h), max(i - r, 0), min(i + r + 1, self.w)
            ok = self._ok(ja, jb, ia, ib, y0, y1, step, height)
            if ok is None:
                self.a[ja:jb, ia:ib] = True
            else:
                self.a[ja:jb, ia:ib] |= ok

    @staticmethod
    def dilate(a, radius_cells):
        r = int(math.ceil(radius_cells))
        ys, xs = np.mgrid[-r:r + 1, -r:r + 1]
        kern = (xs * xs + ys * ys) <= radius_cells ** 2
        out = np.zeros_like(a)
        H, W = a.shape
        for dy, dx in zip(*np.nonzero(kern)):
            dy -= r
            dx -= r
            src = a[max(0, -dy):H - max(0, dy), max(0, -dx):W - max(0, dx)]
            out[max(0, dy):max(0, dy) + src.shape[0], max(0, dx):max(0, dx) + src.shape[1]] |= src
        return out

    @staticmethod
    def rle(a):
        rows = []
        for row in a:
            runs = []
            i, n = 0, len(row)
            while i < n:
                if row[i]:
                    j = i
                    while j < n and row[j]:
                        j += 1
                    runs.append([i, j - i])
                    i = j
                else:
                    i += 1
            rows.append(runs)
        return rows


def raster_nav(tris, verts, x0, z0, w, h, res):
    """Rasterise navmesh triangles; returns (mask, height) where height is interpolated triangle Y."""
    mask = np.zeros((h, w), dtype=bool)
    hm = np.full((h, w), np.nan, dtype=np.float32)
    for a, b, c in tris:
        p = verts[[a, b, c]]
        i0 = max(int((p[:, 0].min() - x0) / res), 0)
        i1 = min(int((p[:, 0].max() - x0) / res) + 1, w)
        j0 = max(int((p[:, 2].min() - z0) / res), 0)
        j1 = min(int((p[:, 2].max() - z0) / res) + 1, h)
        if i1 <= i0 or j1 <= j0:
            continue
        gx = x0 + (np.arange(i0, i1) + 0.5) * res
        gz = z0 + (np.arange(j0, j1) + 0.5) * res
        X, Z = np.meshgrid(gx, gz)
        (ax, ay, az), (bx, by, bz), (cx, cy, cz) = p
        den = (bz - cz) * (ax - cx) + (cx - bx) * (az - cz)
        if abs(den) < 1e-9:
            continue
        l1 = ((bz - cz) * (X - cx) + (cx - bx) * (Z - cz)) / den
        l2 = ((cz - az) * (X - cx) + (ax - cx) * (Z - cz)) / den
        l3 = 1 - l1 - l2
        inside = (l1 >= -1e-6) & (l2 >= -1e-6) & (l3 >= -1e-6)
        y = l1 * ay + l2 * by + l3 * cy
        sub_m = mask[j0:j1, i0:i1]
        sub_h = hm[j0:j1, i0:i1]
        sub_h[inside] = y[inside]
        sub_m |= inside
    return mask, hm


def main_component(verts, tris, castle_xz):
    """Indices of the triangles connected (shared edge) to the triangle nearest the castle."""
    edges = collections.defaultdict(list)
    for t, (a, b, c) in enumerate(tris):
        for u, v in ((a, b), (b, c), (c, a)):
            edges[(min(u, v), max(u, v))].append(t)
    nbr = collections.defaultdict(list)
    for ts in edges.values():
        for x in ts:
            for y in ts:
                if x != y:
                    nbr[x].append(y)
    cent = verts[tris].mean(axis=1)
    start = int(np.argmin((cent[:, 0] - castle_xz[0]) ** 2 + (cent[:, 2] - castle_xz[1]) ** 2))
    seen = {start}
    stack = [start]
    while stack:
        t = stack.pop()
        for u in nbr[t]:
            if u not in seen:
                seen.add(u)
                stack.append(u)
    return sorted(seen)


# ------------------------------------------------------------------ extraction

class Terrain:
    def __init__(self, res: float):
        self.res = res
        self.g = A.Game(DATA, MAPS)
        self.layers = {l["index"]: l["name"] for l in json.load(open(os.path.join(REF, "data", "unity_tags_layers.json")))["layers"]}
        import UnityPy
        env = UnityPy.load(os.path.join(DATA, "globalgamemanagers"))
        self.matrix = None
        for sf in env.files.values():
            if not hasattr(sf, "objects"):
                continue
            for o in sf.objects.values():
                if o.type.name == "PhysicsManager":
                    self.matrix = list(o.read().m_LayerCollisionMatrix)
        assert self.matrix is not None
        self.player_layer = next(i for i, n in self.layers.items() if n == "Player")
        self.hero_layers = {i for i in range(32) if (self.matrix[i] >> self.player_layer) & 1}
        self.mesh_cache: dict[tuple, tuple | None] = {}
        self.hero = None

    def mesh(self, f: A.SFile, ref):
        key = (f.name, ref["m_FileID"], ref["m_PathID"])
        if key in self.mesh_cache:
            return self.mesh_cache[key]
        r = f.ref(ref)
        res = None
        if r and r[0] not in ("unity default resources", "Library/unity default resources"):
            try:
                mo = self.g.file(r[0]).sf.objects.get(r[1])
                obj = mo.read().export()
                vs, fs = [], []
                for line in obj.splitlines():
                    if line.startswith("v "):
                        _, x, y, z = line.split()[:4]
                        vs.append((-float(x), float(y), float(z)))  # UnityPy mirrors X on OBJ export
                    elif line.startswith("f "):
                        idx = [int(t.split("/")[0]) - 1 for t in line.split()[1:]]
                        for k in range(1, len(idx) - 1):
                            fs.append((idx[0], idx[k], idx[k + 1]))
                res = (vs, fs)
            except Exception:  # noqa: BLE001
                res = None
        elif r:
            res = ("builtin", r[1])
        self.mesh_cache[key] = res
        return res

    def active_in_hierarchy(self, f: A.SFile, go_pid: int) -> bool:
        cur = f.transform_of_go(go_pid)
        guard = 0
        while cur and guard < 200:
            t = f.tf(cur)
            if not t or not f.go(t["go"])["active"]:
                return False
            cur = t["father"]
            guard += 1
        return True

    def geometry(self, f: A.SFile, o, c, world):
        """World-space footprint of a collider: convex XZ polygons (+ triangles for meshes) and vertical extent."""
        pos, rot, scl = world
        kind = o.type.name
        polys, tris = [], []
        if kind == "BoxCollider":
            cx, cy, cz = c.m_Center.x, c.m_Center.y, c.m_Center.z
            hx, hy, hz = c.m_Size.x / 2, c.m_Size.y / 2, c.m_Size.z / 2
            cs = [to_world(world, (cx + sx * hx, cy + sy * hy, cz + sz * hz)) for sx in (-1, 1) for sy in (-1, 1) for sz in (-1, 1)]
            polys.append(hull([(p[0], p[2]) for p in cs]))
            shape = {"center": [round(x, 3) for x in to_world(world, (cx, cy, cz))], "size": [round(c.m_Size.x * abs(scl[0]), 3), round(c.m_Size.y * abs(scl[1]), 3), round(c.m_Size.z * abs(scl[2]), 3)],
                     "yawDeg": round(A.yaw_deg(rot), 2)}
            return {"polys": polys, "tris": tris, "ymin": min(p[1] for p in cs), "ymax": max(p[1] for p in cs), "shape": shape}
        if kind == "SphereCollider":
            ctr = to_world(world, (c.m_Center.x, c.m_Center.y, c.m_Center.z))
            r = c.m_Radius * max(abs(scl[0]), abs(scl[1]), abs(scl[2]))
            polys.append([(ctr[0] + r * math.cos(a), ctr[2] + r * math.sin(a)) for a in np.linspace(0, 2 * math.pi, 17)[:-1]])
            return {"polys": polys, "tris": tris, "ymin": ctr[1] - r, "ymax": ctr[1] + r, "shape": {"center": [round(x, 3) for x in ctr], "radius": round(r, 3)}}
        if kind == "CapsuleCollider":
            ctr = to_world(world, (c.m_Center.x, c.m_Center.y, c.m_Center.z))
            sc = max(abs(scl[0]), abs(scl[2])) if c.m_Direction == 1 else max(abs(scl[1]), abs(scl[2]))
            r = c.m_Radius * sc
            hgt = max(c.m_Height * abs(scl[c.m_Direction]), 2 * r)
            ax = qrot(rot, [(1, 0, 0), (0, 1, 0), (0, 0, 1)][c.m_Direction])
            half = hgt / 2 - r
            p1 = (ctr[0] + ax[0] * half, ctr[1] + ax[1] * half, ctr[2] + ax[2] * half)
            p2 = (ctr[0] - ax[0] * half, ctr[1] - ax[1] * half, ctr[2] - ax[2] * half)
            pts = []
            for p in (p1, p2):
                pts += [(p[0] + r * math.cos(a), p[2] + r * math.sin(a)) for a in np.linspace(0, 2 * math.pi, 17)[:-1]]
            polys.append(hull(pts))
            return {"polys": polys, "tris": tris, "ymin": min(p1[1], p2[1]) - r, "ymax": max(p1[1], p2[1]) + r,
                    "shape": {"center": [round(x, 3) for x in ctr], "radius": round(r, 3), "height": round(hgt, 3), "axis": ["x", "y", "z"][c.m_Direction]}}
        mres = self.mesh(f, {"m_FileID": c.m_Mesh.m_FileID, "m_PathID": c.m_Mesh.m_PathID})
        if mres is None:
            return None
        if mres[0] == "builtin":
            return {"builtin": True, "shape": {"builtinMeshId": mres[1], "scale": [round(x, 2) for x in scl]}}
        vs, fs = mres
        wv = [to_world(world, v) for v in vs]
        tris = [(wv[a], wv[b], wv[c_]) for a, b, c_ in fs]
        ys = [p[1] for p in wv]
        xs = [p[0] for p in wv]
        zs = [p[2] for p in wv]
        return {"polys": polys, "tris": tris, "ymin": min(ys), "ymax": max(ys),
                "shape": {"vertices": len(vs), "triangles": len(fs), "bounds": [round(min(xs), 2), round(min(zs), 2), round(max(xs), 2), round(max(zs), 2)]}}

    def load_nav(self, idx: int, scene: str):
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene)
        path = os.path.join(NAV, f"{idx:02d}_{safe}.json")
        d = json.load(open(path, encoding="utf-8"))
        gr = next((g for g in d["graphs"] if g["name"].startswith(NAV_GRAPH) and g.get("triangles")), None)
        if gr is None:
            gr = next((g for g in d["graphs"] if g.get("triangles")), None)
        return np.array(gr["vertices"], dtype=float), np.array(gr["triangles"], dtype=int), d

    def scene(self, scene: str, idx: int) -> dict:
        f = self.g.file(self.g.scene_file(scene))
        slots = {}
        for pid, m in f.monobehaviours("BuildSlot"):
            slots[m.go] = pid
        hero = {}
        for pid, m in f.monobehaviours("PlayerMovement"):
            for cpid, cname in f.go_components(m.go):
                if cname == "CharacterController":
                    c = f.sf.objects[cpid].read()
                    hero = {"radius": c.m_Radius, "height": c.m_Height, "step": c.m_StepOffset, "slope": c.m_SlopeLimit, "skin": c.m_SkinWidth, "center": [c.m_Center.x, c.m_Center.y, c.m_Center.z]}
            break
        self.hero = hero or self.hero or {"radius": 0.71, "height": 3.0, "step": 0.3, "slope": 45.0, "skin": 0.1, "center": [0, 1.6, 0]}
        step, height = self.hero["step"], self.hero["height"]
        feats = self.features(f)
        castle = feats["castle"][0] if feats["castle"] else (feats["slots"][0] if feats["slots"] else (0.0, 0.0, 0.0))

        # ---- walkable surface = navmesh component connected to the castle
        verts, tris, navd = self.load_nav(idx, scene)
        comp = main_component(verts, tris, (castle[0], castle[2]))
        ctris = tris[comp]
        pad = 8.0
        x0, x1 = float(verts[ctris][:, :, 0].min()) - pad, float(verts[ctris][:, :, 0].max()) + pad
        z0, z1 = float(verts[ctris][:, :, 2].min()) - pad, float(verts[ctris][:, :, 2].max()) + pad
        W, H = int(math.ceil((x1 - x0) / self.res)), int(math.ceil((z1 - z0) / self.res))
        nav_mask, hmap = raster_nav(ctris, verts, x0, z0, W, H, self.res)

        # ---- gates: door / bar transforms of GateOpener open automatically near the hero (GateOpener.cs), so their colliders never block
        gate_tfs, gates = set(), []
        for gpid, gm in f.monobehaviours("GateOpener"):
            for key in ("doorL", "doorR", "bars"):
                r = f.ref(gm.v[key])
                if r and r[0] == f.name:
                    gate_tfs.add(r[1])
            gates.append({"id": gpid, "name": f.go(gm.go)["name"], "pos": [round(x, 2) for x in f.world_pos(f.transform_of_go(gm.go))], "mode": self.g.file(f.name) and ["Door", "Bars"][gm.v["mode"]],
                          "openDistance": round(gm.v["openDistance"], 2), "clearDistance": round(gm.v["clearDistance"], 2)})

        # ---- collect blockers
        obstacles, ground = [], []
        skipped = collections.Counter()
        for pid, o in f.sf.objects.items():
            if o.type.name not in COLLIDERS:
                continue
            c = o.read()
            go_pid = c.m_GameObject.m_PathID
            go = f.go(go_pid)
            layer = go["layer"]
            if getattr(c, "m_IsTrigger", False):
                skipped["trigger"] += 1
                continue
            if layer not in self.hero_layers:
                skipped["layer-not-colliding-with-player"] += 1
                continue
            tfp = f.transform_of_go(go_pid)
            owner = None
            cur = tfp
            guard = 0
            while cur and guard < 60:
                t = f.tf(cur)
                if t["go"] in slots:
                    owner = slots[t["go"]]
                    break
                cur = t["father"]
                guard += 1
            in_gate = False
            cur = tfp
            guard = 0
            while cur and guard < 60:
                if cur in gate_tfs:
                    in_gate = True
                    break
                cur = f.tf(cur)["father"]
                guard += 1
            if in_gate:
                skipped["gate-door-or-bars (opens automatically)"] += 1
                continue
            enabled = getattr(c, "m_Enabled", True)
            active = self.active_in_hierarchy(f, go_pid)
            potential = False
            if not (enabled and active):
                if owner is None:
                    skipped["disabled-or-inactive"] += 1
                    continue
                potential = True  # solid once the building is built / upgraded
            world = f.world(tfp)
            entry = {"id": pid, "type": o.type.name, "name": go["name"], "path": f.path(go_pid), "layer": self.layers.get(layer, layer), "slot": owner, "potential": potential}
            geo = self.geometry(f, o, c, world)
            if geo is None:
                skipped["mesh-unreadable"] += 1
                continue
            if geo.get("builtin") or self.layers.get(layer) == "Ground":
                entry["shape"] = geo["shape"]
                entry["category"] = "ground"
                ground.append(entry)
                continue
            entry.update({"shape": geo["shape"], "ymin": round(geo["ymin"], 3), "ymax": round(geo["ymax"], 3), "category": "building" if owner else "static",
                          "_polys": geo["polys"], "_tris": geo["tris"]})
            obstacles.append(entry)

        # exclude blockers whose footprint is nowhere near the walkable surface (e.g. the 'Coin UI' mini-scene)
        def near_nav(e):
            pts = [p for poly in e["_polys"] for p in poly] + [(v[0], v[2]) for t in e["_tris"] for v in t]
            if not pts:
                return False
            xs = [p[0] for p in pts]
            zs = [p[1] for p in pts]
            return not (max(xs) < x0 or min(xs) > x1 or max(zs) < z0 or min(zs) > z1)

        near = [e for e in obstacles if near_nav(e)]
        far = [e for e in obstacles if e not in near]
        obstacles = near

        # ---- rasterise blockers at local surface height
        grids = {}
        for cat in ("static", "building"):
            gd = Grid(x0, z0, x1, z1, self.res, hmap=hmap)
            for e in obstacles:
                if e["category"] != cat:
                    continue
                self.raster_obstacle(gd, e, step, height)
            grids[cat] = gd
        # connectivity uses radius - skin (the CharacterController may penetrate up to its skin width); stand points keep radius + skin
        rc = (self.hero["radius"] - self.hero["skin"]) / self.res
        rs = (self.hero["radius"] + self.hero["skin"]) / self.res
        blocked_static = Grid.dilate(grids["static"].a, rc)
        blocked_static_s = Grid.dilate(grids["static"].a, rs)
        blocked_all = blocked_static_s | Grid.dilate(grids["building"].a, rs)
        free_static = nav_mask & ~blocked_static      # permissive: unbuilt world, connectivity clearance
        free_all = nav_mask & ~blocked_all            # conservative: everything built, stand-point clearance
        r_cells = rs

        info = {"scene": scene, "buildIndex": idx, "model": "navmesh-surface minus collider blockers at local height (v2)", "hero": self.hero,
                "heroLayers": sorted(str(self.layers.get(i, i)) for i in self.hero_layers), "skipped": dict(skipped), "ground": ground and [{k: v for k, v in e.items() if not k.startswith("_")} for e in ground],
                "navmesh": {"graph": NAV_GRAPH, "trianglesTotal": int(len(tris)), "trianglesConnectedToCastle": int(len(comp)), "castleXZ": [round(castle[0], 2), round(castle[2], 2)]}}
        info["grid"] = {"resolution": self.res, "originXZ": [round(x0, 3), round(z0, 3)], "width": W, "height": H, "inflatedByRadius": {"connectivity": round(rc * self.res, 3), "standPoints": round(rs * self.res, 3)},
                        "cellIndex": "i=floor((X-originX)/res), j=floor((Z-originZ)/res)",
                        "walkableStaticRLE": Grid.rle(free_static), "walkableWithBuildingsRLE": Grid.rle(free_all), "navSurfaceRLE": Grid.rle(nav_mask)}
        cs = float(nav_mask.sum())
        info["stats"] = {"obstacles": len(obstacles), "byCategory": dict(collections.Counter(e["category"] for e in obstacles)), "potentialBuildingColliders": sum(1 for e in obstacles if e["potential"]),
                         "navSurfaceM2": round(cs * self.res ** 2, 1), "walkableStaticM2": round(float(free_static.sum()) * self.res ** 2, 1), "walkableWithBuildingsM2": round(float(free_all.sum()) * self.res ** 2, 1)}
        info["gates"] = gates
        info["obstacles"] = [{k: v for k, v in e.items() if not k.startswith("_")} for e in obstacles]
        info["excludedFarFromSurface"] = [{k: v for k, v in e.items() if not k.startswith("_")} for e in far]
        info["features"] = {k: [[round(c_, 2) for c_ in p] for p in v] for k, v in feats.items()}
        info["slots"], info["reachability"], cum, main = self.slot_analysis(f, Grid(x0, z0, x1, z1, self.res), hmap, free_static, free_all, feats)
        if os.environ.get("TF_DEBUG"):
            self.debug_frontier(obstacles, main, nav_mask, free_static, x0, z0, x1, z1, hmap, step, height, rc)
        os.makedirs(OUT, exist_ok=True)
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene)
        np.savez_compressed(os.path.join(OUT, f"{idx:02d}_{safe}.npz"), navSurface=nav_mask, walkableStatic=free_static, walkableWithBuildings=free_all, reachableFromCastle=main,
                            surfaceY=np.nan_to_num(hmap, nan=-9999).astype(np.float16), pathFromCastleM=np.where(np.isfinite(cum), cum, -1).astype(np.float16),
                            origin=np.array([x0, z0]), resolution=np.array([self.res]))
        self.preview(scene, idx, nav_mask, blocked_static, blocked_all, main, Grid(x0, z0, x1, z1, self.res), f, feats, info["slots"])
        return info

    def raster_obstacle(self, gd: Grid, e: dict, step: float, height: float):
        for poly in e["_polys"]:
            gd.fill_polygon(poly, e["ymin"], e["ymax"], step, height)
        cos_slope = math.cos(math.radians(self.hero["slope"]))
        for t in e["_tris"]:
            # a triangle whose normal points up within the hero's slope limit is a walkable FLOOR (ramp, stairs, path), not a wall
            ux, uy, uz = (t[1][0] - t[0][0], t[1][1] - t[0][1], t[1][2] - t[0][2])
            vx, vy, vz = (t[2][0] - t[0][0], t[2][1] - t[0][1], t[2][2] - t[0][2])
            nx, ny, nz = uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx
            nl = math.sqrt(nx * nx + ny * ny + nz * nz)
            if nl < 1e-9 or ny / nl >= cos_slope:
                continue
            ty0, ty1 = min(v[1] for v in t), max(v[1] for v in t)
            p2 = [(v[0], v[2]) for v in t]
            area = (p2[1][0] - p2[0][0]) * (p2[2][1] - p2[0][1]) - (p2[1][1] - p2[0][1]) * (p2[2][0] - p2[0][0])
            if area < 0:
                p2 = [p2[0], p2[2], p2[1]]
            gd.fill_polygon(p2, ty0, ty1, step, height)
            for i in range(3):
                gd.draw_segment(p2[i], p2[(i + 1) % 3], ty0, ty1, step, height)

    def debug_frontier(self, obstacles, main, nav_mask, free_static, x0, z0, x1, z1, hmap, step, height, rc):
        frontier = ndi.binary_dilation(main, iterations=int(3 / self.res)) & nav_mask & ~free_static & ~main
        rows = []
        for e in obstacles:
            if e["category"] != "static":
                continue
            gd = Grid(x0, z0, x1, z1, self.res, hmap=hmap)
            self.raster_obstacle(gd, e, step, height)
            n = int((Grid.dilate(gd.a, rc) & frontier).sum())
            if n:
                rows.append((n, e["type"], e["layer"], e["name"], e["path"][:60], e["shape"], e["ymin"], e["ymax"]))
        for r in sorted(rows, reverse=True)[:14]:
            print("   FRONTIER", r)

    INTERACT_R = 3.0  # PlayerInteraction.interactionRadius (PlayerInteraction.cs:15, OverlapSphere at :191)

    def slot_interactor_polys(self, f: A.SFile, m):
        cands = []
        r = f.ref(m.v["interactorCollider"])
        if r and r[0] == f.name and f.unity_type(r[1]) in COLLIDERS:
            cands.append(r[1])
        inter = f.ref(m.v["interactor"])
        if inter and inter[0] == f.name:
            ig = f.owner_go(inter[1])
            for cpid, cname in f.go_components(ig) if ig else []:
                if cname in COLLIDERS:
                    cands.append(cpid)
        polys, seen = [], set()
        for pid in cands:
            if pid in seen:
                continue
            seen.add(pid)
            o = f.sf.objects[pid]
            c = o.read()
            go = c.m_GameObject.m_PathID
            geo = self.geometry(f, o, c, f.world(f.transform_of_go(go)))
            if geo and not geo.get("builtin"):
                polys += geo["polys"]
        return polys

    def slot_analysis(self, f: A.SFile, grid: Grid, hmap, free_static, free_all, feats):
        """Connectivity uses the permissive 'unbuilt' world (free_static); a stand point itself must stay free after building (free_all)."""
        res = grid.res
        clearance = ndi.distance_transform_edt(free_all) * res
        cx, cz = (feats["castle"][0][0], feats["castle"][0][2]) if feats["castle"] else (0.0, 0.0)
        ci, cj = grid.cell(cx, cz)
        home = None
        for rad in range(0, 160):
            best = None
            for dj in range(-rad, rad + 1):
                for di in range(-rad, rad + 1):
                    if max(abs(di), abs(dj)) != rad:
                        continue
                    i, j = ci + di, cj + dj
                    if 0 <= i < grid.w and 0 <= j < grid.h and free_static[j, i]:
                        d = di * di + dj * dj
                        if best is None or d < best[0]:
                            best = (d, i, j)
            if best:
                home = (best[1], best[2])
                break
        lab, _ = ndi.label(free_static, structure=np.ones((3, 3)))
        main = (lab == lab[home[1], home[0]]) if home else np.zeros_like(free_static)
        if home:
            cum, _ = MCP_Geometric(np.where(main, 1.0, np.inf), fully_connected=True).find_costs([(home[1], home[0])])
            cum = cum * res
        else:
            cum = np.full(free_static.shape, np.inf)
        out = []
        unreachable = 0
        for pid, m in f.monobehaviours("BuildSlot"):
            go = f.go(m.go)
            wp = f.world_pos(f.transform_of_go(m.go))
            polys = self.slot_interactor_polys(f, m)
            rec = {"id": pid, "name": go["name"], "building": m.v["buildingName"], "pos": [round(x, 2) for x in wp], "startDeactivated": m.v["startDeactivated"],
                   "interactorPolygons": [[[round(a, 2), round(b, 2)] for a, b in poly] for poly in polys]}
            if not polys:
                rec["standPoints"] = []
                rec["note"] = "no interactor collider found"
                out.append(rec)
                continue
            xs = [p[0] for poly in polys for p in poly]
            zs = [p[1] for poly in polys for p in poly]
            pad = self.INTERACT_R + 1.0
            i0, j0 = grid.cell(min(xs) - pad, min(zs) - pad)
            i1, j1 = grid.cell(max(xs) + pad, max(zs) + pad)
            i0, j0 = max(i0, 0), max(j0, 0)
            i1, j1 = min(i1 + 1, grid.w), min(j1 + 1, grid.h)
            if i1 <= i0 or j1 <= j0:
                rec["standPoints"] = []
                rec["note"] = "interactor outside the walkable surface"
                unreachable += 1
                out.append(rec)
                continue
            win = Grid(grid.x0 + i0 * res, grid.z0 + j0 * res, grid.x0 + i1 * res, grid.z0 + j1 * res, res)
            for poly in polys:
                win.fill_polygon(poly)
            wh, ww = min(win.h, j1 - j0), min(win.w, i1 - i0)
            dist = ndi.distance_transform_edt(~win.a) * res
            zone = dist <= (self.INTERACT_R - 0.1)
            sub = (slice(j0, j0 + wh), slice(i0, i0 + ww))
            cand = zone[:wh, :ww] & main[sub] & free_all[sub]
            connected = bool(cand.any())
            if not connected:
                # multi-storey or otherwise disconnected geometry: fall back to any free cell in the interaction zone and say so
                cand = zone[:wh, :ww] & free_all[sub]
            pc, cl, hh = cum[sub], clearance[sub], hmap[sub]
            pts = []
            if cand.any():
                jj, ii = np.nonzero(cand)
                order = sorted(range(len(ii)), key=lambda k: (min(round(float(pc[jj[k], ii[k]]), 1), 1e9), -min(float(cl[jj[k], ii[k]]), 1.0)))
                for k in order:
                    x = win.x0 + (ii[k] + 0.5) * res
                    z = win.z0 + (jj[k] + 0.5) * res
                    if all(math.hypot(x - q["x"], z - q["z"]) >= 2.0 for q in pts):
                        pv = float(pc[jj[k], ii[k]])
                        pts.append({"x": round(x, 2), "y": round(float(hh[jj[k], ii[k]]), 2), "z": round(z, 2), "pathFromCastleM": round(pv, 1) if math.isfinite(pv) else None,
                                    "clearanceM": round(float(cl[jj[k], ii[k]]), 2), "distToInteractorM": round(float(dist[jj[k], ii[k]]), 2)})
                    if len(pts) >= 4:
                        break
            rec["standPoints"] = pts
            rec["connectedToCastleInModel"] = connected
            if pts and not connected:
                rec["note"] = "stand points are locally free but not connected to the castle in this model (multi-storey geometry, e.g. ramps off the navmesh)"
            rec["interactionZoneCells"] = int(zone[:wh, :ww].sum())
            rec["reachableCells"] = int(cand.sum())
            if not pts:
                unreachable += 1
                rec["note"] = "no reachable free cell within the interaction radius (enclosed, off-surface or blocked)"
            out.append(rec)
        reach = {"homeXZ": [round(grid.x0 + (home[0] + 0.5) * res, 2), round(grid.z0 + (home[1] + 0.5) * res, 2)] if home else None,
                 "freeCellsUnbuilt": int(free_static.sum()), "freeCellsAllBuilt": int(free_all.sum()), "reachableFromCastleCells": int(main.sum()), "reachableAreaM2": round(float(main.sum()) * res * res, 1),
                 "slotsTotal": len(out), "slotsWithoutStandPoint": unreachable}
        sp = []
        for _, m in f.monobehaviours("EnemySpawnLine"):
            for k in f.tf(f.transform_of_go(m.go))["children"]:
                x, _, z = f.world_pos(k)
                i, j = grid.cell(x, z)
                v = float("inf")
                if 0 <= i < grid.w and 0 <= j < grid.h:
                    # nearest reachable cell within 6 m of the spawn vertex (spawn points can lie just outside the surface)
                    r_c = int(6 / res)
                    win = cum[max(j - r_c, 0):j + r_c + 1, max(i - r_c, 0):i + r_c + 1]
                    v = float(np.nanmin(np.where(np.isfinite(win), win, np.nan))) if np.isfinite(win).any() else float("inf")
                sp.append({"line": f.go(m.go)["name"], "x": round(x, 1), "z": round(z, 1), "heroPathFromCastleM": round(v, 1) if math.isfinite(v) else None, "insideHeroArea": math.isfinite(v)})
        reach["spawnLineVertices"] = sp
        return out, reach, cum, main

    def features(self, f: A.SFile) -> dict:
        castle = [f.world_pos(f.transform_of_go(m.go)) for _, m in f.monobehaviours("TaggedObject") if 3 in m.v["tags"]]
        slots = [f.world_pos(f.transform_of_go(m.go)) for _, m in f.monobehaviours("BuildSlot")]
        spawn = []
        for _, m in f.monobehaviours("EnemySpawnLine"):
            for k in f.tf(f.transform_of_go(m.go))["children"]:
                spawn.append(f.world_pos(k))
        return {"castle": castle, "slots": slots, "spawn": spawn}

    def preview(self, scene, idx, nav, static, allb, main, grid, f, feats, slots=()):
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        os.makedirs(IMG, exist_ok=True)
        ext = (grid.x0, grid.x0 + grid.w * grid.res, grid.z0, grid.z0 + grid.h * grid.res)
        fig, ax = plt.subplots(figsize=(11, 11 * (ext[3] - ext[2]) / max(ext[1] - ext[0], 1)))
        img = np.zeros(nav.shape + (3,), dtype=float) + 0.96
        img[nav] = (0.72, 0.84, 0.95)            # navmesh surface connected to the castle
        img[nav & allb] = (0.78, 0.65, 0.5)      # blocked by buildings (built)
        img[nav & static] = (0.25, 0.25, 0.28)   # blocked by static obstacles
        img[main & ~allb & ~static] = (0.86, 0.94, 0.86)  # reachable free area for the hero
        ax.imshow(img, origin="lower", extent=ext, interpolation="nearest")
        if feats["slots"]:
            ax.scatter([p[0] for p in feats["slots"]], [p[2] for p in feats["slots"]], s=9, c="#2b7bba", label="build slot")
        for _, m in f.monobehaviours("EnemySpawnLine"):
            pts = [f.world_pos(k) for k in f.tf(f.transform_of_go(m.go))["children"]]
            if len(pts) > 1:
                ax.plot([p[0] for p in pts], [p[2] for p in pts], c="#d1362f", lw=2)
        sx = [q["x"] for sl in slots for q in sl["standPoints"][:1]]
        sz = [q["z"] for sl in slots for q in sl["standPoints"][:1]]
        if sx:
            ax.scatter(sx, sz, s=14, marker="x", c="#1a9850", label="best stand point")
        bad = [sl["pos"] for sl in slots if not sl["standPoints"]]
        if bad:
            ax.scatter([p[0] for p in bad], [p[2] for p in bad], s=60, marker="X", c="#d73027", label="slot without reachable stand point")
        if feats["castle"]:
            ax.scatter([p[0] for p in feats["castle"]], [p[2] for p in feats["castle"]], s=140, marker="*", c="#f2b600", edgecolors="k", label="castle")
        ax.set_title(f"{scene}: green = hero-free reachable area, dark = static blockers, tan = buildings, blue = other navmesh, red = spawn lines")
        ax.set_xlabel("X (m)")
        ax.set_ylabel("Z (m)")
        ax.legend(loc="upper right", fontsize=8)
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene)
        fig.savefig(os.path.join(IMG, f"{idx:02d}_{safe}_hero_blocked.png"), dpi=100, bbox_inches="tight")
        plt.close(fig)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenes", default=r"^[^_]")
    ap.add_argument("--res", type=float, default=0.25)
    a = ap.parse_args()
    t = Terrain(a.res)
    os.makedirs(OUT, exist_ok=True)
    rx = re.compile(a.scenes)
    for idx, scene in enumerate(t.g.scene_names):
        if scene.startswith("_") or idx < 4 or not rx.search(scene):
            continue
        t0 = time.time()
        try:
            info = t.scene(scene, idx)
        except Exception as e:  # noqa: BLE001
            import traceback
            print(f"{idx:2d} {scene:40s} ERROR {e!r}\n{traceback.format_exc(limit=4)}", flush=True)
            continue
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene)
        with open(os.path.join(OUT, f"{idx:02d}_{safe}.json"), "w", encoding="utf-8") as fh:
            json.dump(info, fh, separators=(",", ":"), ensure_ascii=False)
        s, r = info["stats"], info["reachability"]
        print(f"{idx:2d} {scene:38s} surface={s['navSurfaceM2']:8.0f} m2 walkable={s['walkableWithBuildingsM2']:8.0f} m2 reachable={r['reachableAreaM2']:8.0f} m2 obstacles={s['obstacles']:4d} "
              f"potentialBldg={s['potentialBuildingColliders']:3d} slots={r['slotsTotal']} noStand={r['slotsWithoutStandPoint']}  {time.time() - t0:.1f}s", flush=True)
        t.g.drop(f"level{idx}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
