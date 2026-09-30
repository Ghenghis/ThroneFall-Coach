import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
r = g.file("resources.assets")
def show_prefab(pid, want=None):
    go = r.go(pid)
    print(f"=== prefab {pid} '{go['name']}' tag={go['tag']} active={go['active']}")
    comps = r.go_components(pid)
    print("components:", [c[1] for c in comps])
    for cpid, cname in comps:
        if want and cname not in want: continue
        m = r.mb(cpid)
        if m:
            s = json.dumps(m.v, default=str)
            print(f"  [{cname}] {s[:700]}{'...' if len(s)>700 else ''}")
show_prefab(6457, {"Hp","AutoAttack","TaggedObject","PathfindMovementEnemy","ScreenMarkerIcon","UnitTypeDisplay"})
# follow the weapon ref
for cpid, cname in r.go_components(6457):
    if cname == "AutoAttack":
        m = r.mb(cpid)
        wref = r.ref(m.v["weapon"])
        print("weapon ref", wref)
        w = g.deref_mb(wref)
        if w: print("  Weapon:", json.dumps(w.v, default=str)[:900])
# ETag enum
import gzip
for line in open(r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps\code\Assembly-CSharp.types.jsonl", encoding="utf-8"):
    d = json.loads(line)
    if d["full"].endswith("/ETag") or d["full"] == "ETag":
        print(d["full"], [(v["n"], v["v"]) for v in d.get("values", [])])
