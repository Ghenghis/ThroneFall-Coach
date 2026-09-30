"""probe_telemetry_offmodel — which model obstacles cover the places where the real hero stood although the model says 'blocked'?"""
import collections, json, math, sys
import numpy as np

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
LOG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl"
scene_file = sys.argv[1] if len(sys.argv) > 1 else "06_Durststein"
t = json.load(open(f"{REF}/data/terrain/{scene_file}.json", encoding="utf-8"))
z = np.load(f"{REF}/data/terrain/{scene_file}.npz")
g = t["grid"]; res = g["resolution"]; x0, z0 = g["originXZ"]; w, h = g["width"], g["height"]
surf, ws, wb = z["navSurface"], z["walkableStatic"], z["walkableWithBuildings"]

def box_contains(o, x, zz, margin):
    s = o["shape"]
    if "center" in s and "size" in s:
        cx, cy, cz = s["center"]; sx, sy, sz = s["size"]; yaw = math.radians(s.get("yawDeg", 0))
        dx, dz = x - cx, zz - cz
        c, sn = math.cos(yaw), math.sin(yaw)
        lx, lz = dx * c - dz * sn, dx * sn + dz * c   # rotate by -yaw (Unity yaw is clockwise seen from above; sign tested below)
        lx2, lz2 = dx * c + dz * sn, -dx * sn + dz * c
        return (abs(lx) <= sx / 2 + margin and abs(lz) <= sz / 2 + margin) or (abs(lx2) <= sx / 2 + margin and abs(lz2) <= sz / 2 + margin)
    if "bounds" in s:
        b = s["bounds"]     # [minX, minZ, maxX, maxZ]
        return b[0] - margin <= x <= b[2] + margin and b[1] - margin <= zz <= b[3] + margin
    return False

pts = []
with open(LOG, encoding="utf-8", errors="replace") as fh:
    for line in fh:
        try: d = json.loads(line)
        except ValueError: continue
        if d.get("scene") == t["scene"] and d.get("state") == "InMatch" and d.get("pos") and d["pos"] != [0, 0]:
            pts.append(d)
print(t["scene"], "ticks", len(pts))
cnt = collections.Counter(); cover = collections.Counter(); modes = collections.Counter()
for d in pts:
    x, zz = d["pos"]
    i, j = int((x - x0) / res), int((zz - z0) / res)
    if not (0 <= i < w and 0 <= j < h): cnt["outside"] += 1; continue
    if ws[j, i]: cnt["walkableStatic"] += 1; continue
    kind = "off-surface" if not surf[j, i] else "on-surface-but-blocked"
    cnt[kind] += 1
    modes[(kind, d["mode"])] += 1
    names = [o["name"] + "|" + o["category"] + ("|potential" if o["potential"] else "") for o in t["obstacles"] if box_contains(o, x, zz, 0.75)]
    for n in (names or ["<none in AABB>"]): cover[(kind, n)] += 1
print(cnt)
print(modes.most_common(12))
for (k, n), v in cover.most_common(30): print(v, k, n)
