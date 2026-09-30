"""probe_hero_components — dump every MonoBehaviour on the hero GameObject (and its direct weapon children) for a scene."""
import json, os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
import tf_assets as A
from tf_common import Enums, R

DATA = r"K:\Downloads-IDM\Thronefall\Thronefall_Data"
MAPS = r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps"
scene = sys.argv[1] if len(sys.argv) > 1 else "Nordfels"
g = A.Game(DATA, MAPS)
f = g.file(g.scene_file(scene))
hero_go = next(m.go for _, m in f.monobehaviours("PlayerMovement"))
print("hero GO", hero_go, f.path(hero_go))

def clean(v, depth=0):
    if isinstance(v, dict):
        if set(v.keys()) == {"m_FileID", "m_PathID"}:
            return f"PPtr({v['m_FileID']},{v['m_PathID']})" if v["m_PathID"] else None
        return {k: clean(x, depth + 1) for k, x in v.items()}
    if isinstance(v, list):
        return [clean(x, depth + 1) for x in v[:12]] + (["..."] if len(v) > 12 else [])
    if isinstance(v, float):
        return round(v, 4)
    return v

def dump_go(go, indent=0):
    for pid, cls in f.go_components(go):
        if f.unity_type(pid) != "MonoBehaviour":
            continue
        m = f.mb(pid)
        if m is None: continue
        print(" " * indent + f"[{cls}] pid={pid}")
        print(" " * indent + "  " + json.dumps(clean(m.v), default=str)[:1800])

dump_go(hero_go)
tf = f.transform_of_go(hero_go)
for ch in f.tf(tf)["children"]:
    cgo = f.owner_go(ch)
    print("--- child", f.path(cgo))
    dump_go(cgo, 2)
    for gch in f.tf(ch)["children"]:
        ggo = f.owner_go(gch)
        print("   --- grandchild", f.path(ggo))
        dump_go(ggo, 4)
