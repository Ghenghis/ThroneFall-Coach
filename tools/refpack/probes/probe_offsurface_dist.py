import collections, json, sys
import numpy as np
import scipy.ndimage as ndi
REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
LOG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl"
sf = sys.argv[1]
t = json.load(open(f"{REF}/data/terrain/{sf}.json", encoding="utf-8")); z = np.load(f"{REF}/data/terrain/{sf}.npz")
g = t["grid"]; res = g["resolution"]; x0, z0 = g["originXZ"]; w, h = g["width"], g["height"]
surf, ws = z["navSurface"], z["walkableStatic"]
dist_surf = ndi.distance_transform_edt(~surf) * res
pts = []
for line in open(LOG, encoding="utf-8", errors="replace"):
    try: d = json.loads(line)
    except ValueError: continue
    if d.get("scene") == t["scene"] and d.get("state") == "InMatch" and d.get("pos") and d["pos"] != [0, 0]: pts.append(d)
far = []
buckets = collections.Counter()
for d in pts:
    x, zz = d["pos"]; i, j = int((x - x0) / res), int((zz - z0) / res)
    if not (0 <= i < w and 0 <= j < h): buckets["outside-grid"] += 1; continue
    ds = dist_surf[j, i]
    b = "on" if ds == 0 else "<=0.5" if ds <= 0.5 else "<=1" if ds <= 1 else "<=2" if ds <= 2 else "<=5" if ds <= 5 else "<=20" if ds <= 20 else ">20"
    buckets[b] += 1
    if ds > 2: far.append((d["pos"][0], d["pos"][1], ds, d["mode"], d["note"], d["night"], d["wave"]))
print(t["scene"], len(pts), buckets)
# cluster far points on a 10 m grid
cl = collections.defaultdict(list)
for x, zz, ds, m, note, n, wv in far: cl[(round(x / 10) * 10, round(zz / 10) * 10)].append((ds, m, note, n))
for k, v in sorted(cl.items(), key=lambda kv: -len(kv[1]))[:14]:
    print(k, len(v), "meanDist", round(sum(a[0] for a in v) / len(v), 1), collections.Counter(a[1] for a in v).most_common(3), collections.Counter(a[3] for a in v))
