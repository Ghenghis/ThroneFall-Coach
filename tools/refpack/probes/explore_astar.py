import sys, json, base64, zipfile, io, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
pid, m = next(iter(f.monobehaviours("AstarPath")))
d = m.v["data"]
print("AstarData keys:", {k: (type(v).__name__, (len(v) if hasattr(v,'__len__') else v)) for k, v in d.items()})
z = zipfile.ZipFile(io.BytesIO(base64.b64decode(d["dataString"])))
for i in z.infolist(): print("  zip entry:", i.filename, i.file_size)
for name in z.namelist():
    if name.endswith(".json"):
        j = json.loads(z.read(name).decode("utf-8", "replace"))
        keys = list(j.keys())
        print(name, "keys:", keys[:40])
        if "graph0" in name or "graph1" in name or name.startswith("graph_meta"):
            print("   ", json.dumps(j)[:1200])
# globalgamemanagers types
import UnityPy
env = UnityPy.load(r"K:\Downloads-IDM\Thronefall\Thronefall_Data\globalgamemanagers")
cnt = collections.Counter()
for sf in env.files.values():
    if hasattr(sf, "objects"):
        for o in sf.objects.values(): cnt[o.type.name] += 1
print(dict(cnt))
