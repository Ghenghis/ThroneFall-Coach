import UnityPy, os, sys, json, collections
from UnityPy.enums import ClassIDType
GAME = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"
# --- build settings: level index -> scene path
env = UnityPy.load(os.path.join(GAME, "globalgamemanagers"))
for sf in env.files.values():
    if not hasattr(sf, "objects"): continue
    for pid, o in sf.objects.items():
        if o.type.name == "BuildSettings":
            bs = o.read()
            scenes = list(bs.scenes)
            print("BuildSettings scenes:", len(scenes))
            for i, s in enumerate(scenes): print(i, s)
# --- native readers on level1
env = UnityPy.load(os.path.join(GAME, "level1"))
sf = next(f for f in env.files.values() if hasattr(f, "objects"))
gos = [o for o in sf.objects.values() if o.type == ClassIDType.GameObject][:2]
for o in gos:
    g = o.read()
    print("GO", o.path_id, g.m_Name, "active", g.m_IsActive, "layer", g.m_Layer, "tag", g.m_Tag, "components", [ (type(c).__name__, getattr(c,'component',None)) for c in g.m_Components[:3]] if hasattr(g,'m_Components') else dir(g)[:30])
tr = [o for o in sf.objects.values() if o.type in (ClassIDType.Transform, ClassIDType.RectTransform)][:2]
for o in tr:
    t = o.read()
    print("TR", o.path_id, type(t).__name__, t.m_LocalPosition, t.m_LocalRotation, t.m_LocalScale, "father", t.m_Father, "children", len(t.m_Children))
