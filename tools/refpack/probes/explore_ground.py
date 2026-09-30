import sys, json, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
L = {l['index']: l['name'] for l in json.load(open(r"K:\Downloads-IDM\Thronefall\Trainer\reference\data\unity_tags_layers.json"))['layers']}
f = g.file(g.scene_file("Uferwind"))
cnt = collections.Counter()
for pid, o in f.sf.objects.items():
    if o.type.name in ("Terrain","TerrainCollider","MeshCollider","BoxCollider","CapsuleCollider","SphereCollider","TerrainData"):
        try:
            c = o.read(); go = f.go(c.m_GameObject.m_PathID) if hasattr(c, 'm_GameObject') else None
            cnt[(o.type.name, L.get(go['layer'], go['layer']) if go else None, bool(getattr(c,'m_IsTrigger',False)), go['active'] if go else None)] += 1
        except Exception as e: cnt[(o.type.name, 'err')] += 1
for k,v in sorted(cnt.items(), key=lambda kv:-kv[1])[:20]: print(v, k)
print("MB classes with 'Border|Bounds|Wall|Limit|Fall|Kill|Clamp':", {k:len(v) for k,v in f.class_index().items() if any(s in k for s in ("Border","Bounds","Wall","Limit","Fall","Kill","Clamp","Boundary","Hazard","Water"))})
