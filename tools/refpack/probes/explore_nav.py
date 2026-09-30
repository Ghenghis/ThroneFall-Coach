import sys, json, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
idx = f.class_index()
print("A* / nav related MB classes in Nordfels:", {k: len(v) for k, v in idx.items() if any(s in k for s in ("Astar","Nav","Recast","Graph","Seeker","Obstacle","Cut","Border","Bounds","Barrier","Blocker"))})
for pid, m in f.monobehaviours("AstarPath"):
    def sz(x):
        if isinstance(x, (bytes, bytearray)): return f"bytes[{len(x)}]"
        if isinstance(x, list): return f"list[{len(x)}]"
        if isinstance(x, dict): return {k: sz(v) for k, v in x.items()}
        return x
    print("AstarPath", pid, json.dumps(sz(m.v), default=str)[:2500])
# collision matrix
import UnityPy
env = UnityPy.load(r"K:\Downloads-IDM\Thronefall\Thronefall_Data\globalgamemanagers")
for sf in env.files.values():
    if not hasattr(sf, "objects"): continue
    for o in sf.objects.values():
        if o.type.name in ("DynamicsManager","Physics2DSettings","TimeManager","QualitySettings","PlayerSettings"):
            try:
                d = o.read()
                keys = [k for k in dir(d) if k.startswith('m_')]
                print(o.type.name, keys[:40])
                if o.type.name == "DynamicsManager":
                    print("  gravity", d.m_Gravity, "layerMatrix len", len(d.m_LayerCollisionMatrix), d.m_LayerCollisionMatrix[:12])
            except Exception as e:
                print(o.type.name, "read err", e)
