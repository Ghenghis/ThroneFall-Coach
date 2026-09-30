import sys, json
sys.path.insert(0, r"K:\Downloads-IDM\Thronefall\Trainer\tools\refpack")
import tf_assets as A
from tf_common import Enums
g = A.Game(r"K:\Downloads-IDM\Thronefall\Thronefall_Data", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
en = Enums(r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
f = g.file("level1")
for pid, m in f.monobehaviours("InputManager"):
    print("InputManager keys:", list(m.v.keys())[:30])
    ud = m.v.get("_userData") or m.v.get("userData")
    if ud:
        print(" userData keys:", list(ud.keys()))
        for k, v in ud.items():
            if isinstance(v, list): print("   ", k, "len", len(v), "first:", json.dumps(v[0], default=str)[:300] if v else None)
        acts = ud.get("actions", [])
        print("ACTIONS:", [(a.get("id"), a.get("name"), a.get("type"), a.get("userAssignable")) for a in acts][:80])
for cls, fld in [("Equippable","unlockRequirement"),("LevelInfo","quests"),("LevelInfo/Quest","questType"),("Equippable","availableToContentPack")]:
    print(cls, fld, en.field_type.get((cls,fld)), en.field_enum(cls,fld))
print([k for k in en.enums if 'Quest' in k or 'Unlock' in k or 'ContentPack' in k or 'Requirement' in k])
for k in [k for k in en.enums if 'Quest' in k or 'Unlock' in k or 'ContentPack' in k or 'Requirement' in k]: print(k, en.enums[k])
