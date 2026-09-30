"""extract_meta — non-level game data: UI frames, level metadata & unlock chain, equippables, weapons, balance sheet,
controls (Rewired), Unity tags/layers, localization. Everything decoded from the shipped files with verified layouts.

usage: python extract_meta.py [--out DIR]
"""
from __future__ import annotations

import argparse
import collections
import csv
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tf_assets as A  # noqa: E402
from tf_common import Enums, Loc, Summaries, R, vec3  # noqa: E402
from UnityPy.enums import ClassIDType  # noqa: E402

DATA = os.environ.get("TF_DATA", r"K:\Downloads-IDM\Thronefall\Thronefall_Data")   # override to run against another install
MAPS = os.environ.get("TF_MAPS", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
OUT = os.environ.get("TF_OUT", r"K:\Downloads-IDM\Thronefall\Trainer\reference\data")


def scalars(v: dict, skip=()) -> dict:
    return {k: (R(x) if isinstance(x, float) else x) for k, x in v.items() if isinstance(x, (int, float, bool, str)) and k not in skip}


class Meta:
    def __init__(self):
        self.g = A.Game(DATA, MAPS)
        self.en = Enums(MAPS)
        self.loc = Loc(self.g)
        self.sm = Summaries(self.g, self.en, self.loc)
        self.all_enums = json.load(open(os.path.join(MAPS, "code", "enums_all.json"), encoding="utf-8"))

    def enum_by_suffix(self, suffix: str) -> dict[int, str]:
        for k, v in self.all_enums.items():
            if k.endswith("|" + suffix):
                return {int(val): name for name, val in v["values"] if val is not None}
        return {}

    # ------------------------------------------------------------------ UI frames
    def ui_frames(self) -> list[dict]:
        f = self.g.file("level2")
        out = []
        for pid, m in f.monobehaviours("UIFrame"):
            go = f.go(m.go)
            frame: dict = {"id": pid, "name": go["name"], "nameRepr": repr(go["name"]), "path": f.path(m.go), "activeSelf": go["active"],
                           "freezeTime": m.v["freezeTime"], "freezePlayer": m.v["freezePlayer"], "canNotBeEscaped": m.v["canNotBeEscaped"],
                           "storeLastSelected": m.v["storeLastSelectedElementInFrameStack"], "events": {}}
            for ev in ("onActivate", "onNewFocus", "onNewSelection", "onApply", "onDeactivate"):
                calls = self.calls(f, m.v.get(ev))
                if calls:
                    frame["events"][ev] = calls
            classes = collections.Counter()
            buttons, texts = [], []
            seen = 0
            stack = [(f.transform_of_go(m.go), 0)]
            while stack and seen < 900:
                tfp, d = stack.pop()
                t = f.tf(tfp)
                if not t:
                    continue
                gopid = t["go"]
                seen += 1
                for cpid, cname in f.go_components(gopid):
                    if cname in ("Transform", "RectTransform", "CanvasRenderer"):
                        continue
                    classes[cname] += 1
                    mm = f.mb(cpid) if f.unity_type(cpid) == "MonoBehaviour" else None
                    if mm is None:
                        continue
                    if cname in ("Button", "TFUITextButton"):
                        label = self.first_text(f, gopid)
                        ev = mm.v.get("m_OnClick") if cname == "Button" else mm.v.get("onApply")
                        buttons.append({"go": f.go(gopid)["name"], "path": f.path(gopid), "kind": cname, "label": label,
                                        "interactable": mm.v.get("m_Interactable", not mm.v.get("cannotBeSelected", False)), "onClick": self.calls(f, ev)})
                    elif cname in ("TextMeshProUGUI", "TextMeshPro") and mm.v.get("m_text"):
                        texts.append(mm.v["m_text"])
                if d < 9:
                    for c in t["children"]:
                        stack.append((c, d + 1))
            frame["componentCounts"] = dict(classes.most_common())
            frame["gameHelpers"] = sorted(k for k in classes if k in self.game_classes())
            frame["buttons"] = buttons
            frame["texts"] = list(dict.fromkeys(x for x in texts if x.strip()))[:20]
            frame["subtreeObjects"] = seen
            out.append(frame)
        return sorted(out, key=lambda x: x["path"])

    _game_classes: set | None = None

    def game_classes(self) -> set:
        if self._game_classes is None:
            s = set()
            with open(os.path.join(MAPS, "code", "Assembly-CSharp.types.jsonl"), encoding="utf-8") as fh:
                for line in fh:
                    d = json.loads(line)
                    if not d.get("vendor") and d.get("unity") and not d["name"].startswith("<"):
                        s.add(d["name"])
            self._game_classes = s
        return self._game_classes

    def first_text(self, f: A.SFile, go_pid: int) -> str:
        stack = [f.transform_of_go(go_pid)]
        n = 0
        while stack and n < 60:
            tfp = stack.pop(0)
            t = f.tf(tfp)
            n += 1
            for cpid, cname in f.go_components(t["go"]):
                if cname in ("TextMeshProUGUI", "TextMeshPro"):
                    mm = f.mb(cpid)
                    if mm and mm.v.get("m_text"):
                        return mm.v["m_text"]
            stack.extend(t["children"])
        return ""

    def calls(self, f: A.SFile, evt) -> list[dict]:
        if not evt:
            return []
        out = []
        for c in evt.get("m_PersistentCalls", {}).get("m_Calls", []):
            tgt = f.ref(c["m_Target"])
            tgo = ""
            if tgt and tgt[0] == f.name:
                tgo = f.go(f.owner_go(tgt[1]))["name"] if f.owner_go(tgt[1]) else ""
            a = c.get("m_Arguments", {})
            arg = a.get("m_StringArgument") or a.get("m_IntArgument") or a.get("m_FloatArgument") or a.get("m_BoolArgument") or ""
            oa = f.ref(a.get("m_ObjectArgument", {"m_FileID": 0, "m_PathID": 0})) if a else None
            objarg = ""
            if oa and oa[0] == f.name:
                ogo = f.owner_go(oa[1])
                objarg = f.go(ogo)["name"] if ogo else ""
            out.append({"type": c["m_TargetAssemblyTypeName"].split(",")[0], "method": c["m_MethodName"], "targetObject": tgo, "arg": arg, "objectArg": objarg})
        return out

    # ------------------------------------------------------------------ levels
    def level_infos(self) -> tuple[list[dict], dict[int, dict]]:
        f = self.g.file("sharedassets1.assets")
        by_pid = {}
        for pid, m in f.monobehaviours("LevelInfo"):
            by_pid[pid] = m
        equip_names = {}
        equip_files = {}
        for fname in ("sharedassets1.assets", "resources.assets"):
            ef = self.g.file(fname)
            for cls in ("EquippablePerk", "EquippableWeapon", "EquippableMutation", "EquippableBuildingUpgrade"):
                for pid, m in ef.monobehaviours(cls):
                    equip_names[(fname, pid)] = m.v.get("displayName") or m.name
        qtype = self.en.enums.get("Quest/EType", {})
        out = []
        for pid, m in by_pid.items():
            v = m.v

            def eq(ref):
                r = f.ref(ref)
                return equip_names.get(r, f"?{r}") if r else None

            unlock = f.ref(v["unlockRequirement"])
            quests = []
            for q in v["quests"]:
                quests.append({"type": qtype.get(q["questType"], q["questType"]), "beatWith": [eq(x) for x in q["beatTheLevelWith"] if eq(x)],
                               "beatWithout": [eq(x) for x in q["beatTheLevelWithout"] if eq(x)], "achieveScoreOf": q["achieveScoreOf"]})
            vb = [{k: (R(x) if isinstance(x, float) else x) for k, x in b.items() if k != "callAfterIncome"} for b in v["virtualBuildings"]]
            out.append({"id": pid, "assetName": m.name, "sceneName": v["sceneName"], "displayName": v["displayName"], "useSubtitle": v["useSubtitle"],
                        "unlockedInDemo": v["unlockedInDemo"], "ignoreSaves": v["ignoreSaves"], "allBuildingChoicesUnlocked": v["allBuildingChoicesUnlocked"],
                        "contribution": v["contribution"], "maxPerkCount": v["maxPerkCount"],
                        "requiresBeatenLevel": by_pid[unlock[1]].v["sceneName"] if unlock and unlock[0] == f.name and unlock[1] in by_pid else None,
                        "fixedLoadout": [eq(x) for x in v["fixedLoadout"]], "quests": quests, "virtualBuildings": vb})
        return out, {m.pid: m.v for m in by_pid.values()}

    def level_nodes(self, infos: dict[int, dict]) -> list[dict]:
        f = self.g.file("level3")
        ext = self.g.file("sharedassets1.assets")
        name_of = {pid: m.v["sceneName"] for pid, m in ext.monobehaviours("LevelInfo")}
        out = []
        for cls in ("LevelInteractor", "BonusLevelInteractor", "EternalTrialsInteractor"):
            for pid, m in f.monobehaviours(cls):
                go = f.go(m.go)
                tfp = f.transform_of_go(m.go)
                d = {"class": cls, "id": pid, "name": go["name"], "path": f.path(m.go), "pos": vec3(f.world_pos(tfp)), "active": go["active"]}
                for key in ("levelInfo", "baseLevelInfo"):
                    if key in m.v:
                        r = f.ref(m.v[key])
                        d[key] = name_of.get(r[1]) if r else None
                if "levelsToPick" in m.v:
                    d["levelsToPick"] = [name_of.get(f.ref(x)[1]) for x in m.v["levelsToPick"] if f.ref(x)]
                d["fields"] = scalars(m.v)
                out.append(d)
        return out

    # ------------------------------------------------------------------ equippables, weapons, balance
    def equippables(self) -> list[dict]:
        rows = []
        unlock = self.en.enums.get("Equippable/UnlockRequirement", {})
        packs = self.en.enums.get("Equippable/ContentPack", {})
        names = [i["sceneName"] for i in self.level_infos()[0]]
        for fname in ("sharedassets1.assets", "resources.assets"):
            f = self.g.file(fname)
            for cls in ("EquippablePerk", "EquippableWeapon", "EquippableMutation", "EquippableBuildingUpgrade"):
                for pid, m in f.monobehaviours(cls):
                    v = m.v
                    rows.append({"class": cls, "file": fname, "id": pid, "assetName": m.name, "displayName": v.get("displayName"),
                                 "description": v.get("description"), "unlockRequirement": unlock.get(v.get("unlockRequirement"), v.get("unlockRequirement")),
                                 "requiredBeatenLevelIndex": v.get("requiredBeatenLevel"), "contentPacks": [packs.get(x, x) for x in v.get("availableToContentPack", [])],
                                 "extra": scalars(v, skip=("displayName", "description", "unlockRequirement", "requiredBeatenLevel"))})
        return rows

    def weapons(self) -> list[dict]:
        out = []
        for fname in ("resources.assets", "sharedassets1.assets"):
            f = self.g.file(fname)
            for pid, m in f.monobehaviours("Weapon"):
                w = self.sm.weapon((fname, pid))
                out.append({"file": fname, "id": pid, **w})
        return out

    @staticmethod
    def _num(v):
        if isinstance(v, str):
            try:
                x = float(v)
                return int(x) if x.is_integer() and "." not in v else R(x, 4)
            except ValueError:
                return v
        return R(v) if isinstance(v, float) else v

    def balance(self) -> dict:
        f = self.g.file("resources.assets")
        for pid, m in f.monobehaviours("BalancingParameters"):
            d = m.v["parameters"]
            keys = d.get("keyData", [])
            vals = d.get("valueData", [])
            return {"count": len(keys), "note": "developer balance sheet: 'Prefab.Component.field' -> value (from BalancingParameters.parameters)",
                    "values": {k: self._num(v) for k, v in zip(keys, vals)}, "rawValueType": type(vals[0]).__name__ if vals else None}
        return {}

    # ------------------------------------------------------------------ controls
    def controls(self) -> dict:
        f = self.g.file("level1")
        kc = self.enum_by_suffix("UnityEngine.KeyCode")
        pid, m = next(iter(f.monobehaviours("InputManager")))
        ud = m.v["_userData"]
        actions = {a["_id"]: a for a in ud["actions"]}
        cats = {c["_id"]: c["_name"] for c in ud["mapCategories"]}

        def maps(kind: str, with_keys: bool):
            res = collections.defaultdict(list)
            for mp in ud[kind]:
                for e in mp["actionElementMaps"]:
                    a = actions.get(e["_actionId"], {})
                    b = {"map": cats.get(mp["categoryId"], mp["categoryId"]), "elementType": e["_elementType"], "elementId": e["_elementIdentifierId"],
                         "axisContribution": e["_axisContribution"], "axisRange": e["_axisRange"], "invert": e["_invert"]}
                    if with_keys and e.get("_keyboardKeyCode"):
                        b["key"] = kc.get(e["_keyboardKeyCode"], e["_keyboardKeyCode"])
                        mods = [kc.get(e.get(k), e.get(k)) for k in ("_modifierKey1", "_modifierKey2", "_modifierKey3") if e.get(k)]
                        if mods:
                            b["modifiers"] = mods
                    if mp.get("hardwareGuidString"):
                        b["hardware"] = mp["hardwareGuidString"]
                    res[a.get("_name", f"#{e['_actionId']}")].append(b)
            return res

        return {
            "actions": [{"id": a["_id"], "name": a["_name"], "type": {0: "Axis", 1: "Button"}.get(a["_type"], a["_type"]), "positive": a["_positiveDescriptiveName"], "negative": a["_negativeDescriptiveName"],
                         "category": next((c["_name"] for c in ud["actionCategories"] if c["_id"] == a["_categoryId"]), a["_categoryId"])} for a in ud["actions"]],
            "keyboard": maps("keyboardMaps", True), "mouse": maps("mouseMaps", False), "joystick": maps("joystickMaps", False),
            "players": [{"id": p["_id"], "name": p["_name"]} for p in ud["players"]],
        }

    def tags_layers(self) -> dict:
        env = __import__("UnityPy").load(os.path.join(DATA, "globalgamemanagers"))
        for sf in env.files.values():
            if not hasattr(sf, "objects"):
                continue
            for o in sf.objects.values():
                if o.type.name == "TagManager":
                    t = o.read()
                    return {"tags": list(getattr(t, "tags", [])), "layers": [{"index": i, "name": n} for i, n in enumerate(getattr(t, "layers", [])) if n]}
        return {}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=OUT)
    a = ap.parse_args()
    os.makedirs(a.out, exist_ok=True)
    mt = Meta()

    def save(name, obj):
        with open(os.path.join(a.out, name), "w", encoding="utf-8") as fh:
            json.dump(obj, fh, indent=1, ensure_ascii=False)
        print(f"  {name}: {len(obj) if hasattr(obj, '__len__') else ''}")

    frames = mt.ui_frames()
    save("ui_frames.json", frames)
    with open(os.path.join(a.out, "ui_frames.csv"), "w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["name_repr", "path", "freezeTime", "freezePlayer", "canNotBeEscaped", "activeSelf", "gameHelpers", "buttons(label->onClick)", "texts"])
        for fr in frames:
            w.writerow([fr["nameRepr"], fr["path"], fr["freezeTime"], fr["freezePlayer"], fr["canNotBeEscaped"], fr["activeSelf"], ";".join(fr["gameHelpers"]),
                        " | ".join(f"{(b['label'] or b['go']).strip()}->" + ",".join(f"{c['type']}.{c['method']}" + (f"({c['objectArg']})" if c.get('objectArg') else "") for c in b["onClick"]) for b in fr["buttons"]), " | ".join(fr["texts"][:6]).replace("\n", " ")])
    infos, _ = mt.level_infos()
    save("level_infos.json", infos)
    nodes = mt.level_nodes({})
    save("level_select_nodes.json", nodes)
    save("equippables.json", mt.equippables())
    save("weapons.json", mt.weapons())
    save("balance_sheet.json", mt.balance())
    save("controls.json", mt.controls())
    save("unity_tags_layers.json", mt.tags_layers())
    with open(os.path.join(a.out, "localization_en.csv"), "w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["term", "english"])
        for k, v in sorted(mt.loc.terms.items()):
            w.writerow([k, v.replace("\n", "\\n")])
    print(f"  localization_en.csv: {len(mt.loc.terms)}")
    game_enums = {k: v for k, v in mt.en.enums.items()}
    save("enums_game.json", game_enums)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
