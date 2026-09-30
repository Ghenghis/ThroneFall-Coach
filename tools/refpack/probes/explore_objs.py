import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level5")
def dump(cls, n=1, maxlen=2500):
    for i,(pid,m) in enumerate(f.monobehaviours(cls)):
        if i>=n: break
        go = f.go(m.go)
        tfp = f.transform_of_go(m.go)
        print(f"--- {cls} pid={pid} go='{go['name']}' path={f.path(m.go)} tag={go['tag']} active={go['active']} wpos={tuple(round(x,2) for x in f.world_pos(tfp))}")
        s = json.dumps(m.v, default=str)
        print(s[:maxlen] + (" ...[%d chars]" % len(s) if len(s)>maxlen else ""))
        print("   components:", [c[1] for c in f.go_components(m.go)])
for c in ["BuildSlot","EnemySpawnLine","Nighthorn","Shrine","DayNightCycle"]:
    print("count", c, len(f.class_index().get(c, [])))
dump("BuildSlot", 1, 3500)
dump("EnemySpawnLine", 2, 800)
dump("Nighthorn", 1, 600)
dump("DayNightCycle", 1, 600)
