import UnityPy, os, collections, time
from UnityPy.enums import ClassIDType
GAME = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"
t=time.time()
env = UnityPy.load(GAME)
print("loaded in %.1fs; env.files=%d" % (time.time()-t, len(env.files)))
names = sorted(env.files.keys())
print(names[:8], '...', names[-4:])
tot=0; scr=collections.Counter()
where=collections.defaultdict(int)
for name, sf in env.files.items():
    if not hasattr(sf, 'objects'): continue
    n=len(sf.objects); tot+=n
    ms=[o for o in sf.objects.values() if o.type==ClassIDType.MonoScript]
    if ms: where[os.path.basename(name)]=len(ms)
print("total objects", tot)
print("files holding MonoScript objects:", dict(where))
sf = env.files[[n for n in names if n.endswith('level1')][0]]
print("level1 externals:", [(getattr(e,'path',None), getattr(e,'guid',None)) for e in sf.externals][:20])
print("level1 ref_types:", len(sf.ref_types) if sf.ref_types else 0)
o = next(o for o in sf.objects.values() if o.type==ClassIDType.MonoBehaviour)
raw = o.get_raw_data()
print("first MB raw len", len(raw), raw[:40].hex())
