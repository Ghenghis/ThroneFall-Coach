"""build_map_docs — generate the mapping documents from the TfMap output (both builds):

  02-build-fingerprint-and-drift.md   what changed between the bot's build and the Steam build, and what it breaks
  04-state-map.md                     bot-relevant game state -> class.member, type, metadata token, present in each build?
  06-hook-map.md                      every Harmony target of the Trainer: signature, token, inlining risk, call sites, drift
  11-code-map-index.md                inventory of the mapping files and how to query them

Every member named in these tables is looked up in reference/maps*/code/Assembly-CSharp.types.jsonl; unresolved names are
listed at the end of the state map instead of being silently published.
"""
from __future__ import annotations

import collections
import csv
import json
import os
import re

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
SRC = r"K:\Downloads-IDM\Thronefall\Trainer\src"
DOCS = os.path.join(REF, "docs")
A = os.path.join(REF, "maps")
B = os.path.join(REF, "maps_steam")


def load_types(maps):
    out = {}
    with open(os.path.join(maps, "code", "Assembly-CSharp.types.jsonl"), encoding="utf-8") as fh:
        for line in fh:
            d = json.loads(line)
            if not d.get("vendor"):
                out[d["full"]] = d
    return out


def load_methods(maps):
    rows = {}
    with open(os.path.join(maps, "code", "Assembly-CSharp.methods.tsv"), encoding="utf-8") as fh:
        for r in csv.DictReader(fh, delimiter="\t"):
            rows[int(r["id"])] = r
    return rows


def md_table(header, rows):
    out = ["| " + " | ".join(header) + " |", "|" + "|".join("---" for _ in header) + "|"]
    for r in rows:
        out.append("| " + " | ".join(str(c).replace("|", "\\|").replace("\n", " ") for c in r) + " |")
    return "\n".join(out)


def find_member(t: dict, name: str):
    """(kind, record) for the first member called `name` (fields, then properties, then methods)."""
    for f in t.get("fields", []):
        if f["n"] == name:
            return "field", f
    for p in t.get("props", []):
        if p["n"] == name:
            return "property", p
    ms = [m for m in t.get("methods", []) if m["n"] == name]
    if ms:
        return "method", ms
    return None, None


# --------------------------------------------------------------------------------------------- state map
STATE = [
    # (concept, class, member, how to use / note)
    ("Hero object", "PlayerMovement", "instance", "static singleton; `.transform.position` = hero position"),
    ("Hero dead?", "PlayerMovement", "Dead", "true while knocked out (respawn timer running)"),
    ("Hero steering input", "PlayerMovement", "MoveScript", "Harmony prefix point used by the bot: replaces `inputVector`"),
    ("Hero life", "Hp", "maxHp", "serialized max HP; current via `Hp.HpPercentage`"),
    ("Hero life %", "Hp", "HpPercentage", "0..1"),
    ("Gold", "PlayerInteraction", "Balance", "player gold (coins)"),
    ("Hero interaction radius", "PlayerInteraction", "interactionRadius", "3.0 m sphere around the hero (PlayerInteraction.cs:191)"),
    ("Coin magnet radius", "PlayerInteraction", "coinMagnetRadius", "7.0 m; coins inside fly to the hero"),
    ("May call night now?", "PlayerInteraction", "IsFreeToCallNight", "false while focusing an interactor, frozen, tutorial gate, match over"),
    ("Focused interactor", "PlayerInteraction", "focussedInteractor", "non-null while the hero is in range of a building interactor"),
    ("Energy cores (2.13 only)", "PlayerInteraction", "EnergyCoreBalance", "DLC currency; API removed in 2.14"),
    ("Day/night state", "DayNightCycle", "CurrentTimestate", "enum Day/Night"),
    ("Day timer (automatic modes)", "DayNightCycle", "RemainingAutoDayTime", "only counts when AutomatedDaytime"),
    ("Auto day mode?", "DayNightCycle", "AutomatedDaytime", "true only in AutoDayNight modes"),
    ("Start the night", "DayNightCycle", "SwitchToNight", "same effect as a completed Call-Night hold"),
    ("Night length so far", "DayNightCycle", "CurrentNightLength", "seconds since dusk"),
    ("Hold-to-call-night fill", "NightCall", "nightCallTime", "seconds of holding the 'Call Night' action"),
    ("Wave counter", "EnemySpawner", "Wavenumber", "starts -1; increments in StartSpawning (upcoming night = wn+1 by day)"),
    ("Wave list", "EnemySpawner", "waves", "the per-level authored waves (see data/levels)"),
    ("Enemies alive", "EnemySpawner", "NumberOfEnemiesOnTheMap", "night ends when spawning done and this is 0"),
    ("Spawning running?", "EnemySpawner", "SpawningInProgress", ""),
    ("Match over?", "EnemySpawner", "MatchOver", ""),
    ("Preview of next night", "EnemySpawner", "GetWaveInfoForNextWave", "what the HUD shows: names, counts, HP, range, speed"),
    ("Final wave coming?", "EnemySpawner", "PreFinalWaveComingUp", ""),
    ("Game state", "LocalGamestate", "CurrentState", "enum: InMatch, AfterMatchVictory, AfterMatchDefeat, ..."),
    ("Player frozen?", "LocalGamestate", "PlayerFrozen", "true while a freezePlayer UI frame is open"),
    ("Change game state", "LocalGamestate", "SetState", "Harmony point for 'never lose' (cheat, not used in legit mode)"),
    ("All tagged objects", "TagManager", "instance", "static singleton registry"),
    ("Player units", "TagManager", "PlayerUnits", "allied army"),
    ("Enemy units", "TagManager", "EnemyUnits", "all living enemies"),
    ("Loose coins", "TagManager", "freeCoins", "coins on the ground"),
    ("Buildable/harvestable slots", "TagManager", "playerBuildingInteractors", "one BuildingInteractor per slot"),
    ("Count by tag", "TagManager", "CountObjectsWithTag", "e.g. ETag.CastleCenter > 0 means castle alive"),
    ("Slot level", "BuildSlot", "Level", "current upgrade level"),
    ("Slot upgrade tree", "BuildSlot", "upgrades", "per-level cost/branches (asset data)"),
    ("Next cost", "BuildSlot", "NextUpgradeOrBuildCost", "gold needed for the next step"),
    ("Slot prerequisites", "BuildSlot", "activatorBuilding", "slot that must reach `activatorLevel` first"),
    ("Slot interactor", "BuildSlot", "interactor", "BuildingInteractor of this slot"),
    ("Can interact now?", "BuildingInteractor", "CanBeInteractedWith", "true only while the slot has work"),
    ("Pay / build", "BuildingInteractor", "InteractionHold", "hold-to-pay pump (Coinslot fill); silent early-outs when denied"),
    ("Harvest ready?", "BuildingInteractor", "canBeHarvested", "income waiting"),
    ("Waiting for a choice?", "BuildingInteractor", "IsWaitingForChoice", "a multi-branch upgrade froze the hero until picked"),
    ("Upgrade choice list", "ChoiceManager", "availableChoices", "branches offered"),
    ("Choice pending?", "ChoiceManager", "ChoiceCoroutineWaiting", ""),
    ("Answer a choice", "ChoiceManager", "choiceToReturn", "set to the chosen Choice"),
    ("UI frame stack", "UIFrameManager", "ActiveFrame", "top frame; input only reaches it"),
    ("Close top frame", "UIFrameManager", "CloseActiveFrame", "no effect on canNotBeEscaped frames"),
    ("Open a frame", "UIFrameManager", "ChangeActiveFrame", "what menu buttons call"),
    ("Frame flags", "UIFrame", "canNotBeEscaped", "see data/ui_frames.json"),
    ("Frame freezes player", "UIFrame", "freezePlayer", ""),
    ("Army: select unit", "CommandUnits", "OnUnitAdd", "player's select path"),
    ("Army: place", "CommandUnits", "PlaceCommandedUnitsAndCalculateTargetPositions", ""),
    ("Army: hold position", "CommandUnits", "MakeUnitsInBufferHoldPosition", ""),
    ("Army gather range", "CommandUnits", "attractRange", "6.0 m"),
    ("Level transition", "SceneTransitionManager", "TransitionFromLevelSelectToLevel", "starts a match from the map"),
    ("Back to map", "SceneTransitionManager", "TransitionToLevelSelect", ""),
    ("Menu -> map", "SceneTransitionManager", "TransitionFromNullToLevelSelect", "what TitleScreenUIHelper.ClickPlay does"),
    ("Level progress", "LevelProgressManager", "GetLevelDataForScene", "beaten / highscore / quests"),
    ("Loadout", "PerkManager", "SetEquipped", "equip perks/weapons before a level"),
    ("Weapon in hand", "WeaponEquipper", "activeWeapon", "hero's active ManualAttack"),
    ("Hero attack", "ManualAttack", "TryToAttack", "respects cooldown (legit)"),
    ("Save", "SaveLoadManager", "SaveGame", "writes ThroneSave.sav"),
    ("Shrine progress", "Shrine", "ShrineHasBeenActivated", ""),
    ("Enemy target logic", "PathfindMovementEnemy", "targetPriorities", "ordered tag rules; asset data per prefab"),
    ("Enemy speed", "PathfindMovementEnemy", "movementSpeed", "asset data per prefab"),
    ("Attack cooldown", "AutoAttack", "cooldownDuration", "asset data per prefab"),
    ("Weapon damage table", "Weapon", "directDamage", "per-victim-tag add/multiplier"),
    ("Night-call gate", "TutorialManager", "AllowStartingTheNight", "tutorial only"),
]


def state_map(ta, tb):
    rows, missing = [], []
    for concept, cls, mem, note in STATE:
        ra, rb = ta.get(cls), tb.get(cls)
        ka, va = find_member(ra, mem) if ra else (None, None)
        kb, vb = find_member(rb, mem) if rb else (None, None)
        if not ka and not kb:
            missing.append((concept, cls, mem))
            continue
        ref = va if ka else vb
        if ka == "method":
            desc = "; ".join(m["sig"] for m in (va if ka else vb))[:110]
            tok = (va if ka else vb)[0]["tok"]
        elif ka == "property" or kb == "property":
            p = ref
            desc = p["t"]
            tok = p.get("get") or p.get("set") or ""
        else:
            desc = ref["t"]
            tok = ref["tok"]
        mark = lambda k: "✓" if k else "✗ removed"
        rows.append([concept, f"`{cls}.{mem}`", ka or kb, f"`{desc}`", f"`{tok}`", mark(ka), mark(kb), note])
    return rows, missing


# --------------------------------------------------------------------------------------------- hook map
def harmony_targets():
    out = []
    for fn in sorted(os.listdir(SRC)):
        if not fn.endswith(".cs"):
            continue
        txt = open(os.path.join(SRC, fn), encoding="utf-8", errors="replace").read()
        for m in re.finditer(r"\[HarmonyPatch\(typeof\((\w+)\),\s*(?:nameof\(\w+\.(\w+)\)|\"(\w+)\")\)\]", txt):
            out.append((fn, m.group(1), m.group(2) or m.group(3)))
    return out


def hook_map(ta, tb, ma, callers):
    rows, notes = [], []
    for fn, cls, meth in harmony_targets():
        ra, rb = ta.get(cls), tb.get(cls)
        msa = [m for m in (ra or {}).get("methods", []) if m["n"] == meth]
        msb = [m for m in (rb or {}).get("methods", []) if m["n"] == meth]
        if not msa:
            rows.append([f"`{cls}.{meth}`", fn, "NOT FOUND in 2.13", "", "", "", "", ""])
            continue
        for m in msa:
            ids = callers.get(m["key"], [])
            names = collections.Counter(ma[i]["logical"].split("::")[0] for i in ids if i in ma)
            same = next((x for x in msb if x["key"] == m["key"]), None)
            if not msb:
                steam = "✗ **removed in 2.14**"
            elif same is None:
                steam = "⚠ signature changed: " + "; ".join(x["sig"] for x in msb)
            elif same.get("il") != m.get("il"):
                steam = f"⚠ body changed (IL {m.get('il')} → {same.get('il')} B); signature same"
            else:
                steam = "✓ identical"
            risk = []
            if m.get("inlineRisk"):
                risk.append("**inlineRisk** (short non-virtual: Mono may inline it, patch could miss call sites)")
            if "virtual" in m["fl"] or "override" in m["fl"]:
                risk.append("virtual (patch applies to the declaring class only)")
            if not risk:
                risk.append("low")
            rows.append([f"`{cls}.{m['n']}`", fn, f"`{m['sig']}`", f"`{m['tok']}`", f"{m.get('il', '?')} B", "; ".join(risk),
                         f"{len(ids)} call sites" + (f" ({', '.join(f'{n}×{c}' for n, c in names.most_common(4))})" if ids else ""), steam])
    return rows


# --------------------------------------------------------------------------------------------- main
def main() -> int:
    ta, tb = load_types(A), load_types(B)
    ma = load_methods(A)
    callers = json.load(open(os.path.join(A, "code", "callers.json"), encoding="utf-8"))
    drift = json.load(open(os.path.join(REF, "verification", "build_drift.json"), encoding="utf-8"))
    lc_a = json.load(open(os.path.join(REF, "verification", "layout_check.json"), encoding="utf-8"))
    lc_b = json.load(open(os.path.join(REF, "verification", "layout_check_steam.json"), encoding="utf-8"))

    # ---------------- drift doc
    v = drift["versions"]
    an, bn = drift["a"], drift["b"]
    w = []
    w.append("# 02 · Build fingerprint and API/data drift\n")
    w.append(f"*Generated by `tools/refpack/diff_builds.py` + `build_map_docs.py` on 2026-09-29. Compared: **{an}** = `K:\\Downloads-IDM\\Thronefall` (the copy the bot runs on) vs **{bn}** = "
             f"`C:\\Program Files (x86)\\Steam\\steamapps\\common\\Thronefall` (Steam appid 2239150, buildid 25306299, updated 2026-09-25 10:39 UTC).*\n")
    w.append("## 1. Fingerprints\n")
    w.append(md_table(["", an, bn], [["Game version (`PlayerSettings.bundleVersion`)", v[an]["bundleVersion"], v[bn]["bundleVersion"]], ["Unity", v[an]["unity"], v[bn]["unity"]],
                                       ["Assembly-CSharp SHA-256", "`F350269E…6B30`", "`217DC7E6…DFE6`"], ["Assembly-CSharp size", "2,587,648 B", "2,531,840 B"],
                                       ["Managed DLLs (identical / changed)", f"{drift['assemblies']['identical']} identical", f"{len(drift['assemblies']['changed'])} differ (rebuilt, mostly timestamps)"],
                                       ["Game types (excl. vendor, compiler-generated)", drift["types"]["countA"], drift["types"]["countB"]],
                                       ["Script objects decoded byte-exact", f"{lc_a['byteExact']:,} / {lc_a['checked']:,} ({lc_a['byteExactPct']}%)", f"{lc_b['byteExact']:,} / {lc_b['checked']:,} ({lc_b['byteExactPct']}%)"]]))
    w.append("\nThe same extraction pipeline (layout generator → byte-exact verifier → data extractors) runs unchanged on **both** builds, which is the evidence that it will survive future updates: re-run "
             "`tools/refpack/run_all.ps1` after a game patch and read this report.\n")
    w.append("## 2. What changed in the code (2.13 → 2.14)\n")
    w.append(f"* **{len(drift['types']['added'])} types added, {len(drift['types']['removed'])} removed, {drift['types']['changedCount']} changed.** The removed set is dominated by DLC content that is not part of the base game "
             "(bosses such as Crystal Dragon / Lava Golem / Construct Colossus, `AutoAttackFlamethrower`, `AutoAttackRailgun`, trap towers, `EnergyCore*`, `Equippable.ContentPack`). Added: DLC-gate UI (`DlcGateUIFrameHelper`, "
             "`UIFrameManager.TryOpenDLCGate`), wardrobe/platform helpers, `TFUIHoldableButton`, `Thronefall.DLCServices.*`.\n"
             "* **Base-game data is unchanged.** See §4.\n")
    w.append("## 3. Impact on the Trainer / bot sources\n")
    imp = drift["trainerImpact"]
    w.append(f"`src/*.cs` references {imp['typesReferencedBySrc']} game types; **{imp['typesWithDrift']}** of them changed in 2.14:\n")
    rows = []
    for x in imp["details"]:
        parts = []
        for k, label in (("fieldsRemoved", "fields removed"), ("fieldsAdded", "fields added"), ("fieldsRetyped", "fields retyped"), ("methodsRemoved", "methods removed"), ("methodsAdded", "methods added"), ("methodsBodyChanged", "body changed")):
            if x.get(k):
                parts.append(f"**{label}:** " + ", ".join(f"`{i}`" for i in x[k][:6]) + (" …" if len(x[k]) > 6 else ""))
        rows.append([f"`{x['type']}`", "<br>".join(parts) or x["status"]])
    w.append(md_table(["Type", "Changes"], rows))
    w.append("\n**Breaking for the current Trainer:** `PlayerInteraction.SpendEnergyCores` (Harmony target), `EnergyCoreBalance`, `BuildSlot.NextUpgradeOrBuildEnergyCoreCost` and `TagManager.energyCores` no longer exist in 2.14 — "
             "code referencing them fails to compile or patch there. Everything else is additive or a body change. Guidance: keep developing against 2.13 (the K: copy) and gate energy-core code behind a build check.\n")
    w.append("## 4. Data drift (waves, stats, UI, controls)\n")
    d = drift["data"]
    w.append(md_table(["Check", "Result"], [["Scenes compared", d.get("scenesCompared")], ["Scenes with different wave/slot totals", json.dumps(d.get("sceneDiffs"), ensure_ascii=False)],
                                            ["Enemy stat differences (HP, speed, attacks)", len(d.get("enemyStatDiffs", []))], ["Balance-sheet entries changed", f"{d.get('balanceChanged')} of {d.get('balanceEntries')[0] if d.get('balanceEntries') else '?'}"],
                                            ["UI frames only in 2.14", ", ".join(d.get("uiFramesOnlyB", [])) or "none"], ["UI frames only in 2.13", ", ".join(d.get("uiFramesOnlyA", [])) or "none"],
                                            ["Input actions only in 2.14", ", ".join(d.get("inputActionsOnlyB", [])) or "none"], ["Input actions only in 2.13", ", ".join(d.get("inputActionsOnlyA", [])) or "none"]]))
    w.append("\n**Conclusion:** the per-level handbook (waves, spawn lines, slots, unit and enemy stats) is valid for both builds; only Wildbach MM3 differs (1 enemy fewer, −50 base HP).\n")
    w.append("## 5. Re-running after a game update\n")
    w.append("```powershell\n# 1) map the new DLLs (2.7 s):  dotnet tools\\refpack\\TfMap\\bin\\Release\\net8.0\\TfMap.dll <Managed dir> <out maps dir>\n"
             "# 2) prove the layouts: python tools\\refpack\\verify_layouts.py --game <Thronefall_Data> --maps <out maps dir>\n"
             "# 3) extract:            python tools\\refpack\\extract_levels.py / extract_meta.py / extract_navmesh.py / extract_terrain.py  (set TF_DATA/TF_MAPS/TF_OUT to target another install)\n"
             "# 4) compare:            python tools\\refpack\\diff_builds.py --a-maps ... --b-maps ...\n```\n")
    open(os.path.join(DOCS, "02-build-fingerprint-and-drift.md"), "w", encoding="utf-8").write("\n".join(w))

    # ---------------- state map
    rows, missing = state_map(ta, tb)
    w = ["# 04 · State map — what the bot can read from the running game\n",
         "*Generated by `build_map_docs.py`. Each row was looked up in the TfMap output of both builds (`reference/maps*/code/Assembly-CSharp.types.jsonl`); the metadata token is the ECMA-335 token in "
         "`Assembly-CSharp.dll` (2.13), unique per member and stable inside that build. For per-prefab values (HP, speed, ranges, costs) see `reference/data/`.*\n",
         md_table(["Concept", "Member", "Kind", "Type / signature", "Token (2.13)", "2.13", "2.14", "Notes"], rows)]
    if missing:
        w.append("\n## Unresolved names (fix the list, do not trust these concepts)\n" + md_table(["Concept", "Class", "Member"], missing))
    w.append("\n## How to read the map\n"
             "* **Singletons** are static fields/properties named `instance`/`Instance`: `PlayerMovement.instance`, `PlayerInteraction.instance`, `EnemySpawner.instance`, `TagManager.instance`, `DayNightCycle.Instance`, "
             "`LocalGamestate.Instance`, `UIFrameManager.instance`, `ChoiceManager.instance`, `CommandUnits.instance`, `SceneTransitionManager.instance`, `LevelProgressManager.instance`, `PerkManager.instance`. "
             "The list of every detected singleton is in `reference/maps/code/singletons.md`.\n"
             "* Most singletons exist only inside a match (`_UI`/level scenes); on the title screen they are `null` — null-guard every access.\n"
             "* A `property` is compiled to `get_X`/`set_X` methods (tokens in `types.jsonl → props[].get/set`).\n")
    open(os.path.join(DOCS, "04-state-map.md"), "w", encoding="utf-8").write("\n".join(w))
    print(f"state map: {len(rows)} rows, {len(missing)} unresolved: {missing}")

    # ---------------- hook map
    rows = hook_map(ta, tb, ma, callers)
    w = ["# 06 · Hook map — Harmony patch points\n",
         "*Generated by `build_map_docs.py` from the `[HarmonyPatch]` attributes in `Trainer/src/*.cs`. 'Inline risk' is a **heuristic** (non-virtual, ≤ 32 IL bytes, no exception handlers): Mono's JIT may inline such "
         "methods into callers, so a Harmony patch would not see those call sites. Call-site counts come from the IL cross-reference index (`code/callers.json`), so they are exact for the game's own code.*\n",
         md_table(["Target", "Patched in", "Signature", "Token", "IL size", "Risk notes", "Callers (IL scan)", "Status in 2.14"], rows)]
    w.append("\n## Reading the table\n"
             "* A patch on a method **with many call sites** is a good choke point (e.g. `Hp.TakeDamage`, every damage path goes through it). A method with **0 game call sites** is invoked by Unity or through "
             "delegates/reflection (e.g. `Hp.Start`, `PlayerMovement.MoveScript` is called from `Update`).\n"
             "* `PlayerInteraction.SpendEnergyCores` does not exist in 2.14 — `[HarmonyPatch]` on a missing method throws at `PatchAll()` there.\n")
    open(os.path.join(DOCS, "06-hook-map.md"), "w", encoding="utf-8").write("\n".join(w))
    print(f"hook map: {len(rows)} rows")

    # ---------------- singletons list + code map index
    sing = [(n, t["singleton"]) for n, t in sorted(ta.items()) if t.get("singleton")]
    with open(os.path.join(A, "code", "singletons.md"), "w", encoding="utf-8") as fh:
        fh.write("# Singleton accessors detected in Assembly-CSharp (2.13)\n\n" + md_table(["Class", "Accessor"], [[f"`{n}`", s] for n, s in sing]) + "\n")
    summ = json.load(open(os.path.join(A, "summary.json"), encoding="utf-8"))
    unity = collections.Counter(t.get("unity") for t in ta.values())
    roles = collections.Counter(t["kind"] for t in ta.values())
    msgs = collections.Counter()
    for t in ta.values():
        for m in t.get("methods", []):
            if m.get("unityMsg"):
                msgs[m["n"]] += 1
    w = ["# 11 · Code-map index — the mapping files\n",
         "*'Mapping file' here means machine-readable indexes of the game's code and data: which classes exist, what fields they serialize, who calls whom, where every value lives. Nothing was deobfuscated: "
         "Thronefall ships a Mono build with original names, so the map is pure metadata + IL analysis (`tools/refpack/TfMap`).*\n",
         "## Inventory\n",
         md_table(["File", "What it is", "Size / count"], [
             ["`maps/assemblies.json`", "every managed DLL: version, MVID, sha256, type/method/field counts, references", f"{summ['assemblies']} assemblies"],
             ["`maps/code/<asm>.types.jsonl`", "one JSON object per type: base chain, flags, attributes, fields (serialized?, const), properties, methods (token, RVA, IL size, Unity message, inline risk)", f"{summ['types']:,} types"],
             ["`maps/il/<asm>/<Type>.il`", "readable IL disassembly of every game method with resolved operands", f"{summ['methodBodies']:,} method bodies, {summ['ilBytes']:,} IL bytes"],
             ["`maps/code/<asm>.methods.tsv`", "method id → token, key, logical owner (coroutines/lambdas mapped to their source method)", f"{summ['methodsWithIds']:,} methods"],
             ["`maps/code/<asm>.xrefs.jsonl`", "per method: calls, field reads/writes, string literals, type references, with IL offsets", ""],
             ["`maps/code/callers.json`", "callee key → ids of calling methods (reverse call graph)", f"{summ['callees']:,} callees"],
             ["`maps/code/field_readers.json`, `field_writers.json`", "field key → ids of methods that read/write it", f"{summ['fieldsRead']:,} read, {summ['fieldsWritten']:,} written"],
             ["`maps/code/enums_all.json`", "all enums of all assemblies (Unity, Rewired, game) with values", f"{summ['enumsAllAssemblies']:,} enums"],
             ["`maps/code/singletons.md`", "static instance accessors of game classes", f"{len(sing)} classes"],
             ["`maps/serialization/layouts.json` (+ `layouts.txt`)", "Unity serialization layout of every script class (what the asset files contain, in order)", f"{summ['scriptLayouts']} scripts, all verified byte-exact"],
             ["`maps/serialization/class_layouts.json`", "layouts of classes stored behind `[SerializeReference]`", f"{summ['classLayouts']} classes"],
             ["`verification/layout_check*.json`", "byte-exact proof of the layouts against the real assets (both builds)", f"{lc_a['byteExact']:,} + {lc_b['byteExact']:,} objects"]]),
         "\n## Composition of the game code\n",
         md_table(["Measure", "Value"], [["Game types (excl. vendor & compiler-generated)", len(ta)], ["Kinds", ", ".join(f"{k}: {v}" for k, v in roles.most_common())],
                                        ["Unity roles", ", ".join(f"{k}: {v}" for k, v in unity.most_common())], ["Most common Unity messages", ", ".join(f"{k} ({v})" for k, v in msgs.most_common(8))]]),
         "\n## Example queries\n",
         "```python\nimport json\n# who calls Hp.TakeDamage?\nc = json.load(open('maps/code/callers.json'))\nids = c['Hp::TakeDamage(float,TaggedObject,bool,bool)']\n"
         "# which methods write EnemySpawner.wavenumber?\nw = json.load(open('maps/code/field_writers.json'))['EnemySpawner::wavenumber']\n```\n"
         "```powershell\n# find every IL mention of a string literal / method\nSelect-String -Path reference\\maps\\il\\Assembly-CSharp\\*.il -Pattern 'Call Night'\n```\n"]
    open(os.path.join(DOCS, "11-code-map-index.md"), "w", encoding="utf-8").write("\n".join(w))
    print("code map index written")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
