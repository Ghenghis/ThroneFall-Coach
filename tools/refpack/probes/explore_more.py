import sys, json, collections
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
names = collections.Counter(m.v["buildingName"] for _,m in f.monobehaviours("BuildSlot"))
print("Nordfels BuildSlot names:", dict(names))
# a slot that activates objects: find first upgrade with objectsToActivate
shown = 0
for pid, m in f.monobehaviours("BuildSlot"):
    if m.v["buildingName"] in ("Wall",): continue
    for ui, up in enumerate(m.v["upgrades"]):
        for br in up["upgradeBranches"]:
            if br["objectsToActivate"] and shown < 2:
                print(f"\nslot '{m.v['buildingName']}' pid={pid} upg#{ui} cost={up['cost']} core={up['energyCoreCost']} inc={br['goldIncomeChange']} hp={br['hpChange']} tooltip={up['upgradeTooltip']!r}")
                for o in br["objectsToActivate"]:
                    r = f.ref(o)
                    if r and r[0]==f.name:
                        print("   activates:", f.go(r[1])["name"], [c[1] for c in f.go_components(r[1])])
                shown += 1
    if shown >= 2: break
def dump(cls, n=1, maxlen=900, fl=f):
    for i,(pid,m) in enumerate(fl.monobehaviours(cls)):
        if i>=n: break
        print(f"--- {cls} pid={pid} go='{fl.go(m.go)['name']}' :: {json.dumps(m.v, default=str)[:maxlen]}")
dump("Shrine", 1)
dump("UnitRespawnerForBuildings", 1)
dump("BuildingInteractor", 1)
dump("PlayerInteraction", 1)
dump("CastleCenter", 1)
dump("CommandUnits", 1)
# colliders native
from UnityPy.enums import ClassIDType
cnt = collections.Counter(o.type.name for o in f.sf.objects.values())
print({k:v for k,v in cnt.items() if 'Collider' in k or k in ('NavMeshSettings','MeshFilter','Terrain','LineRenderer','Light')})
# lvl select
ls = g.file("level3")
dump("LevelInteractor", 1, 800, ls)
dump("LevelSelectManager", 1, 500, ls)
ui = g.file("level2")
print("UIFrame count in _UI:", len(ui.class_index().get("UIFrame", [])))
dump("UIFrame", 2, 500, ui)
li = g.file("resources.assets")
print("LevelInfo in resources:", len(li.class_index().get("LevelInfo", [])), "Equippable*:", {k:len(v) for k,v in li.class_index().items() if k.startswith("Equippable") or k in ("Weapon","LevelInfo","BalancingParameters","LanguageSourceAsset")})
dump("LevelInfo", 1, 1200, li)
