import sys, json, base64, zipfile, io
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
for sc in ["Nordfels", "Durststein"]:
    f = g.file(g.scene_file(sc))
    pid, m = next(iter(f.monobehaviours("AstarPath")))
    d = m.v["data"]
    z = zipfile.ZipFile(io.BytesIO(base64.b64decode(d["dataString"])))
    print(sc, "meta:", z.read("meta.json").decode()[:200])
    j = json.loads(z.read("graph0.json").decode("utf-8", "replace"))
    print("  keys:", sorted(j.keys()))
    ref = f.ref(d["file_cachedStartup"])
    print("  cacheStartup", d["cacheStartup"], "ref", ref)
    if ref:
        o = g.file(ref[0]).sf.objects.get(ref[1]); t = o.read()
        raw = t.m_Script if isinstance(t.m_Script, (bytes, bytearray)) else t.m_Script.encode("utf-8", "surrogateescape")
        zz = zipfile.ZipFile(io.BytesIO(raw)); print("  cache entries:", [(i.filename, i.file_size) for i in zz.infolist()][:14])
        print("  cache meta:", zz.read("meta.json").decode()[:200])
    g.drop(f.name)
