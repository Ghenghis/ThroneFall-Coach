import sys, json, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
L = {l['index']: l['name'] for l in json.load(open(r"K:\Downloads-IDM\Thronefall\Trainer\reference\data\unity_tags_layers.json"))['layers']}
f = g.file("level5")
for pid, o in f.sf.objects.items():
    if o.type.name != "MeshCollider": continue
    c = o.read()
    go = f.go(c.m_GameObject.m_PathID)
    r = f.ref({"m_FileID": c.m_Mesh.m_FileID, "m_PathID": c.m_Mesh.m_PathID})
    wp = f.world(f.transform_of_go(go["pid"]))
    info = {"go": go["name"], "layer": L.get(go["layer"]), "convex": c.m_Convex, "trigger": c.m_IsTrigger, "mesh": r, "pos": [round(x,1) for x in wp[0]], "scale": [round(x,2) for x in wp[2]]}
    print(info)
    if r:
        mf = g.file(r[0]); mo = mf.sf.objects.get(r[1])
        if mo is not None:
            m = mo.read()
            try:
                obj = m.export()
                nv = sum(1 for l in obj.splitlines() if l.startswith("v "))
                nf = sum(1 for l in obj.splitlines() if l.startswith("f "))
                print("   mesh", m.m_Name, "verts", nv, "faces", nf, "readable?", getattr(m, 'm_IsReadable', None), "vertexcount", getattr(getattr(m,'m_VertexData',None),'m_VertexCount',None))
            except Exception as e:
                print("   export failed:", repr(e)[:200], "vertexcount", getattr(getattr(m,'m_VertexData',None),'m_VertexCount',None), "collisionData", len(getattr(m,'m_CollisionData',b'') or b''))
