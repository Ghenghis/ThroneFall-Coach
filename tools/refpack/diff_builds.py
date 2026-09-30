"""diff_builds — API and data drift between two Thronefall installs (e.g. the bot's copy vs the current Steam build).

Compares, using the TfMap outputs and the extracted data of both builds:
  * assemblies (size / sha256 / last write), Unity + game version strings
  * game types, fields, methods (signature + IL size), enum values  → what a Harmony patch or reflection lookup could break
  * the classes/members the Trainer sources actually reference
  * per-level data: nights, enemy counts, HP, slot counts, costs, enemy stats, UI frames, controls

usage: python diff_builds.py --a-maps DIR --b-maps DIR --a-data DIR --b-data DIR --a-name K --b-name Steam --out DIR
"""
from __future__ import annotations

import argparse
import collections
import json
import os
import re

import UnityPy


def load_types(maps: str) -> dict[str, dict]:
    out = {}
    with open(os.path.join(maps, "code", "Assembly-CSharp.types.jsonl"), encoding="utf-8") as fh:
        for line in fh:
            d = json.loads(line)
            if d.get("vendor"):
                continue
            out[d["full"]] = d
    return out


def version_info(data_dir: str) -> dict:
    env = UnityPy.load(os.path.join(data_dir, "globalgamemanagers"))
    for sf in env.files.values():
        if not hasattr(sf, "objects"):
            continue
        for o in sf.objects.values():
            if o.type.name == "PlayerSettings":
                t = o.read()
                return {"productName": t.productName, "bundleVersion": t.bundleVersion, "companyName": t.companyName, "unity": str(sf.unity_version)}
    return {}


def member_sets(t: dict):
    fields = {f["n"]: f["t"] for f in t.get("fields", [])}
    methods = {m["key"]: m.get("il") for m in t.get("methods", []) if "key" in m}
    return fields, methods


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--a-maps", required=True)
    ap.add_argument("--b-maps", required=True)
    ap.add_argument("--a-data", required=True)
    ap.add_argument("--b-data", required=True)
    ap.add_argument("--a-game", required=True, help="Thronefall_Data folder of build A")
    ap.add_argument("--b-game", required=True)
    ap.add_argument("--a-name", default="A")
    ap.add_argument("--b-name", default="B")
    ap.add_argument("--src", default=r"K:\Downloads-IDM\Thronefall\Trainer\src")
    ap.add_argument("--out", required=True)
    a = ap.parse_args()
    os.makedirs(a.out, exist_ok=True)
    rep: dict = {"a": a.a_name, "b": a.b_name}

    # ---- versions + assemblies
    rep["versions"] = {a.a_name: version_info(a.a_game), a.b_name: version_info(a.b_game)}
    asm_a = {x["name"]: x for x in json.load(open(os.path.join(a.a_maps, "assemblies.json"), encoding="utf-8"))["assemblies"]}
    asm_b = {x["name"]: x for x in json.load(open(os.path.join(a.b_maps, "assemblies.json"), encoding="utf-8"))["assemblies"]}
    rep["assemblies"] = {"onlyA": sorted(set(asm_a) - set(asm_b)), "onlyB": sorted(set(asm_b) - set(asm_a)),
                         "changed": [{"name": n, "sizeA": asm_a[n]["size"], "sizeB": asm_b[n]["size"], "types": [asm_a[n]["types"], asm_b[n]["types"]], "methods": [asm_a[n]["methods"], asm_b[n]["methods"]],
                                      "writeA": asm_a[n]["lastWriteUtc"], "writeB": asm_b[n]["lastWriteUtc"]} for n in sorted(set(asm_a) & set(asm_b)) if asm_a[n]["sha256"] != asm_b[n]["sha256"]],
                         "identical": sum(1 for n in set(asm_a) & set(asm_b) if asm_a[n]["sha256"] == asm_b[n]["sha256"])}

    # ---- type / member drift (Assembly-CSharp game code)
    ta, tb = load_types(a.a_maps), load_types(a.b_maps)
    def gamey(n):  # skip compiler-generated helper types
        return "<" not in n and "__" not in n
    added = sorted(n for n in tb if n not in ta and gamey(n))
    removed = sorted(n for n in ta if n not in tb and gamey(n))
    changed = []
    for n in sorted(set(ta) & set(tb)):
        if not gamey(n):
            continue
        fa, ma = member_sets(ta[n])
        fb, mb = member_sets(tb[n])
        d = {"type": n, "fieldsAdded": sorted(set(fb) - set(fa)), "fieldsRemoved": sorted(set(fa) - set(fb)),
             "fieldsRetyped": sorted(f"{k}: {fa[k]} -> {fb[k]}" for k in set(fa) & set(fb) if fa[k] != fb[k]),
             "methodsAdded": sorted(set(mb) - set(ma)), "methodsRemoved": sorted(set(ma) - set(mb)),
             "methodsBodyChanged": sorted(k for k in set(ma) & set(mb) if ma[k] is not None and mb[k] is not None and ma[k] != mb[k])}
        if ta[n].get("kind") == "enum":
            va = {v["n"]: v.get("v") for v in ta[n].get("values", [])}
            vb = {v["n"]: v.get("v") for v in tb[n].get("values", [])}
            d["enumChanges"] = sorted([f"+{k}={vb[k]}" for k in set(vb) - set(va)] + [f"-{k}" for k in set(va) - set(vb)] + [f"{k}: {va[k]}->{vb[k]}" for k in set(va) & set(vb) if va[k] != vb[k]])
        if any(v for k, v in d.items() if k != "type"):
            changed.append(d)
    rep["types"] = {"countA": len(ta), "countB": len(tb), "added": added, "removed": removed, "changedCount": len(changed), "changed": changed}

    # ---- what the Trainer actually touches
    ident = set()
    for fn in os.listdir(a.src):
        if fn.endswith(".cs"):
            ident |= set(re.findall(r"[A-Za-z_][A-Za-z0-9_]*", open(os.path.join(a.src, fn), encoding="utf-8", errors="replace").read()))
    used = sorted(n for n in ta if "/" not in n and n in ident)
    impact = []
    for n in used:
        if n in removed:
            impact.append({"type": n, "status": "REMOVED"})
            continue
        c = next((x for x in changed if x["type"] == n), None)
        if c:
            impact.append({"type": n, "status": "changed", **{k: v for k, v in c.items() if k != "type" and v}})
    rep["trainerImpact"] = {"typesReferencedBySrc": len(used), "typesWithDrift": len(impact), "details": impact}

    # ---- data drift
    def jload(dirp, name):
        p = os.path.join(dirp, name)
        return json.load(open(p, encoding="utf-8")) if os.path.exists(p) else None

    data = {}
    ia, ib = jload(a.a_data, "levels_index.json"), jload(a.b_data, "levels_index.json")
    if ia and ib:
        ma, mb = {x["scene"]: x for x in ia}, {x["scene"]: x for x in ib}
        keys = ["nights", "enemiesTotal", "baseHpTotal", "goldCoinsTotal", "flyingEnemies", "bossEnemies", "spawnLines", "buildSlots"]
        data["scenesOnlyA"] = sorted(set(ma) - set(mb))
        data["scenesOnlyB"] = sorted(set(mb) - set(ma))
        data["sceneDiffs"] = [{"scene": s, **{k: [ma[s][k], mb[s][k]] for k in keys if ma[s].get(k) != mb[s].get(k)}} for s in sorted(set(ma) & set(mb)) if any(ma[s].get(k) != mb[s].get(k) for k in keys)]
        data["scenesCompared"] = len(set(ma) & set(mb))
    ea, eb = jload(a.a_data, "enemy_prefabs.json"), jload(a.b_data, "enemy_prefabs.json")
    if ea and eb:
        na = {v["name"]: v for v in ea.values()}
        nb = {v["name"]: v for v in eb.values()}
        diffs = []
        for n in sorted(set(na) & set(nb)):
            d = {}
            for k in ("maxHp", "speed"):
                if na[n].get(k) != nb[n].get(k):
                    d[k] = [na[n].get(k), nb[n].get(k)]
            aa = [(x.get("range"), x.get("baseDamage"), x.get("cooldown")) for x in na[n].get("attacks", [])]
            ab = [(x.get("range"), x.get("baseDamage"), x.get("cooldown")) for x in nb[n].get("attacks", [])]
            if aa != ab:
                d["attacks(range,dmg,cd)"] = [aa, ab]
            if d:
                diffs.append({"enemy": n, **d})
        data["enemyStatDiffs"] = diffs
        data["enemiesOnlyA"] = sorted(set(na) - set(nb))
        data["enemiesOnlyB"] = sorted(set(nb) - set(na))
    fa, fb = jload(a.a_data, "ui_frames.json"), jload(a.b_data, "ui_frames.json")
    if fa and fb:
        sa, sb = {f["name"]: f for f in fa}, {f["name"]: f for f in fb}
        data["uiFramesOnlyA"] = sorted(sa.keys() - sb.keys())
        data["uiFramesOnlyB"] = sorted(sb.keys() - sa.keys())
        data["uiFrameFlagDiffs"] = [n for n in sa.keys() & sb.keys() if (sa[n]["freezePlayer"], sa[n]["canNotBeEscaped"], sa[n]["freezeTime"]) != (sb[n]["freezePlayer"], sb[n]["canNotBeEscaped"], sb[n]["freezeTime"])]
    ca, cb = jload(a.a_data, "controls.json"), jload(a.b_data, "controls.json")
    if ca and cb:
        an, bn = {x["name"] for x in ca["actions"]}, {x["name"] for x in cb["actions"]}
        data["inputActionsOnlyA"], data["inputActionsOnlyB"] = sorted(an - bn), sorted(bn - an)
    ba, bb = jload(a.a_data, "balance_sheet.json"), jload(a.b_data, "balance_sheet.json")
    if ba and bb:
        va, vb = ba["values"], bb["values"]
        data["balanceEntries"] = [len(va), len(vb)]
        data["balanceChanged"] = sum(1 for k in va if k in vb and va[k] != vb[k])
        data["balanceOnlyA"], data["balanceOnlyB"] = len(set(va) - set(vb)), len(set(vb) - set(va))
    rep["data"] = data
    with open(os.path.join(a.out, "build_drift.json"), "w", encoding="utf-8") as fh:
        json.dump(rep, fh, indent=1, ensure_ascii=False)
    print(json.dumps({"versions": rep["versions"], "assembliesChanged": len(rep["assemblies"]["changed"]), "types": {k: v for k, v in rep["types"].items() if k not in ("added", "removed", "changed")},
                      "trainerImpact": {k: v for k, v in rep["trainerImpact"].items() if k != "details"}, "data": {k: (len(v) if isinstance(v, list) else v) for k, v in data.items()}}, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
