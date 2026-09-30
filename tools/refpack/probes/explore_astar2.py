import sys, json, base64, zipfile, io, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
pid, m = next(iter(f.monobehaviours("AstarPath")))
d = m.v["data"]
z = zipfile.ZipFile(io.BytesIO(base64.b64decode(d["dataString"])))
print("meta.json:", z.read("meta.json").decode("utf-8","replace")[:400])
for n in ("graph2.json","graph3.json"):
    j = json.loads(z.read(n).decode("utf-8","replace")); print(n, j["name"], "radius", j["characterRadius"], "mask", j["mask"], "bounds", j["forcedBoundsCenter"], j["forcedBoundsSize"], "cell", j["cellSize"])
ref = f.ref(d["file_cachedStartup"])
print("cachedStartup ref:", ref, d["file_cachedStartup"])
if ref:
    ff = g.file(ref[0]); o = ff.sf.objects.get(ref[1])
    print("type:", o.type.name if o else None)
    if o is not None and o.type.name == "TextAsset":
        t = o.read()
        raw = t.m_Script if isinstance(t.m_Script, (bytes, bytearray)) else t.m_Script.encode("utf-8", "surrogateescape")
        print("TextAsset", t.m_Name, "bytes", len(raw), raw[:8])
        try:
            zz = zipfile.ZipFile(io.BytesIO(raw))
            for i in zz.infolist(): print("   ", i.filename, i.file_size)
        except Exception as e:
            print("not zip:", e)
# layer indices
L = json.load(open(r"K:\Downloads-IDM\Thronefall\Trainer\reference\data\unity_tags_layers.json"))
print("layers:", [(l['index'], l['name']) for l in L['layers']])
