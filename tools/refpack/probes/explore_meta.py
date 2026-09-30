import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
def dump(fname, cls, n=1, maxlen=1500, pick=None):
    f = g.file(fname)
    for i,(pid,m) in enumerate(f.monobehaviours(cls)):
        if pick and not pick(m): continue
        print(f"--- {fname}:{cls} pid={pid} name={m.name!r} go={(f.go(m.go)['name'] if m.go else None)!r}")
        s = json.dumps(m.v, default=str, ensure_ascii=False)
        print(s[:maxlen] + (f" ...[{len(s)} chars]" if len(s)>maxlen else ""))
        n -= 1
        if n<=0: break
dump("sharedassets1.assets","LevelInfo",2,1800)
dump("sharedassets1.assets","EquippableWeapon",1,900)
dump("sharedassets1.assets","EquippablePerk",1,900)
dump("sharedassets1.assets","EquippableMutation",1,700)
dump("resources.assets","EquippableBuildingUpgrade",1,700)
dump("resources.assets","BalancingParameters",1,900)
dump("level3","LevelInteractor",1,2500)
dump("level3","EternalTrialsInteractor",1,600)
dump("level3","BonusLevelInteractor",1,700)
