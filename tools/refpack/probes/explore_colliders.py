import sys, json, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A, UnityPy
from UnityPy.enums import ClassIDType
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
L = {l['index']: l['name'] for l in json.load(open(r"K:\Downloads-IDM\Thronefall\Trainer\reference\data\unity_tags_layers.json"))['layers']}
env = UnityPy.load(r"K:\Downloads-IDM\Thronefall\Thronefall_Data\globalgamemanagers")
for sf in env.files.values():
    if not hasattr(sf, "objects"): continue
    names = collections.Counter(o.type.name for o in sf.objects.values())
    print("ggm types:", dict(names))
    for o in sf.objects.values():
        if o.type.name in ("PhysicsManager","DynamicsManager"):
            d = o.read()
            print(o.type.name, [k for k in dir(d) if k.startswith('m_')][:30])
            mat = getattr(d, "m_LayerCollisionMatrix", None)
            if mat:
                print("matrix len", len(mat))
                player = 11
                print("Player(11) collides with:", [L.get(i, i) for i in range(32) if (mat[i] >> player) & 1 or (mat[player] >> i) & 1])
f = g.file("level5")
cnt = collections.Counter()
for pid, o in f.sf.objects.items():
    if o.type.name in ("BoxCollider","SphereCollider","CapsuleCollider","MeshCollider","CharacterController","TerrainCollider"):
        c = o.read()
        go = f.go(c.m_GameObject.m_PathID)
        cnt[(o.type.name, L.get(go["layer"], go["layer"]), bool(getattr(c, "m_IsTrigger", False)), go["active"])] += 1
for k, v in sorted(cnt.items(), key=lambda kv: -kv[1])[:30]: print(v, k)
# hero controller
for pid, m in f.monobehaviours("PlayerMovement"):
    for cpid, cname in f.go_components(m.go):
        if cname == "CharacterController":
            c = f.sf.objects[cpid].read()
            print("Hero CharacterController:", {k: getattr(c, k) for k in ("m_Height","m_Radius","m_SlopeLimit","m_StepOffset","m_SkinWidth","m_MinMoveDistance","m_Center")}, "layer", L.get(f.go(m.go)["layer"]))
