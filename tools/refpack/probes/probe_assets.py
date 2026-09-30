import sys, collections, time
import UnityPy
from UnityPy.enums import ClassIDType
GAME = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"  # bot build (the first probe ran on the Steam copy)
t=time.time()
env = UnityPy.load(GAME + r"\level1")
for name, f in env.files.items():
    sf = f
    print("file:", name, "| unity:", getattr(sf, "unity_version", "?"), "| fmt:", getattr(sf.header, "version", "?"), "| typetree:", getattr(sf, "_enable_type_tree", getattr(sf, "enable_type_tree", "?")))
    types = getattr(sf, "types", [])
    print("  types in metadata:", len(types), "| with nodes:", sum(1 for ty in types if getattr(ty, "node", None)))
cnt = collections.Counter(o.type.name for o in env.objects)
print("objects:", len(env.objects), dict(cnt.most_common(12)))
mbs = [o for o in env.objects if o.type == ClassIDType.MonoBehaviour]
ok=fail=0; err=None
for o in mbs[:400]:
    try:
        tt = o.read_typetree()
        ok+=1
    except Exception as e:
        fail+=1; err = err or repr(e)[:300]
print("MonoBehaviour read_typetree ok:", ok, "fail:", fail, "first error:", err)
print("elapsed %.1fs" % (time.time()-t))
