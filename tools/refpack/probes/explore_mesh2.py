import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
o = f.sf.objects[250]; m = o.read()
print([a for a in dir(m) if not a.startswith('_')][:60])
print("m_Name", m.m_Name, "AABB", getattr(m, 'm_LocalAABB', None))
for name in ("m_Vertices", "m_Indices", "m_IndexBuffer", "m_Triangles"):
    v = getattr(m, name, None)
    print(name, type(v).__name__, (len(v) if hasattr(v, '__len__') else v))
    if hasattr(v, '__len__') and len(v) > 0: print("   head", list(v[:12]))
try:
    print("get_triangles:", type(m.get_triangles()).__name__)
except Exception as e: print("get_triangles err", repr(e)[:100])
obj = m.export().splitlines()
print("\n".join(obj[:14]))
# print the collider's transform to compare with OBJ
for pid, oo in f.sf.objects.items():
    if oo.type.name == "MeshCollider":
        c = oo.read()
        if c.m_Mesh.m_PathID == 250:
            go = f.go(c.m_GameObject.m_PathID); print("collider GO", go["name"], "world", f.world(f.transform_of_go(go['pid'])))
