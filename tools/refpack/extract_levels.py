"""extract_levels — per-scene gameplay data from Thronefall's asset files.

For every playable scene: waves (with spawn-line polylines in world space), build slots with full upgrade trees,
shrines, castle, hero, day/night settings. Everything is decoded from the shipped files with byte-exact layouts
(see verify_layouts.py); nothing is estimated.

usage: python extract_levels.py [--scenes REGEX] [--out DIR]
"""
from __future__ import annotations

import argparse
import collections
import csv
import json
import os
import re
import sys
import time
import traceback

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tf_assets as A  # noqa: E402
from tf_common import Enums, Loc, Summaries, R, brief, vec3  # noqa: E402

DATA = os.environ.get("TF_DATA", r"K:\Downloads-IDM\Thronefall\Thronefall_Data")   # override to run against another install
MAPS = os.environ.get("TF_MAPS", r"K:\Downloads-IDM\Thronefall\Trainer\reference\maps")
OUT = os.environ.get("TF_OUT", r"K:\Downloads-IDM\Thronefall\Trainer\reference\data")


def owner_go(f: A.SFile, pid: int) -> int:
    t = f.unity_type(pid)
    if t == "GameObject":
        return pid
    if t == "MonoBehaviour":
        m = f.mb(pid)
        return m.go if m else 0
    o = f.sf.objects.get(pid)
    try:
        return o.read().m_GameObject.m_PathID if o is not None else 0
    except Exception:  # noqa: BLE001
        return 0


def pos_of(f: A.SFile, pid: int) -> list[float] | None:
    t = f.unity_type(pid)
    if t in ("Transform", "RectTransform"):
        return vec3(f.world_pos(pid))
    go = owner_go(f, pid)
    if not go:
        return None
    tf = f.transform_of_go(go)
    return vec3(f.world_pos(tf)) if tf else None


def scene_kind(name: str, idx: int) -> str:
    if name.startswith("_"):
        return "system"
    if idx <= 9 or idx in (25, 26, 27, 28):
        return "campaign"
    if 10 <= idx <= 24:
        return "minimode"
    return "minimode-new"


class Extractor:
    def __init__(self):
        t = time.time()
        self.g = A.Game(DATA, MAPS)
        self.en = Enums(MAPS)
        self.loc = Loc(self.g)
        self.sm = Summaries(self.g, self.en, self.loc)
        print(f"ready in {time.time() - t:.1f}s; {len(self.loc.terms)} localization terms")

    # ------------------------------------------------------------------ pieces
    def spawn_lines(self, f: A.SFile) -> dict[int, dict]:
        lines: dict[int, dict] = {}
        for pid, m in f.monobehaviours("EnemySpawnLine"):
            tf = f.transform_of_go(m.go)
            pts = [vec3(f.world_pos(k)) for k in f.tf(tf)["children"]]
            length = sum(((a[0] - b[0]) ** 2 + (a[2] - b[2]) ** 2) ** 0.5 for a, b in zip(pts, pts[1:]))
            mid = [R(sum(p[i] for p in pts) / len(pts)) for i in range(3)] if pts else vec3(f.world_pos(tf))
            lines[tf] = {
                "tf": tf, "name": f.go(m.go)["name"], "path": f.path(m.go), "points": pts, "length": R(length), "center": mid,
                "difficulty": self.en.name("EnemySpawnLine/ESpawnDifficulty", m.v["difficulty"]),
                "canSpawnFlying": m.v["canSpawnFlying"], "canSpawnSmallGround": m.v["canSpawnSmallGround"], "canSpawnBigGround": m.v["canSpawnBigGround"],
                "sharedPaths": [f.go(owner_go(f, r[1]))["name"] for r in (f.ref(x) for x in m.v["mostlySharedAttackpaths"]) if r],
                "separatedPaths": [f.go(owner_go(f, r[1]))["name"] for r in (f.ref(x) for x in m.v["mostlySeperatedAttackPaths"]) if r],
            }
        return lines

    def waves(self, f: A.SFile, spawner: A.MB, lines: dict[int, dict], enemies: dict[str, dict]) -> list[dict]:
        out = []
        for i, w in enumerate(spawner.v["waves"]):
            sp_out = []
            tot = collections.Counter()
            per_line = collections.Counter()
            dur = 0.0
            for s in w["spawns"]:
                pref = f.ref(s["enemyPrefab"])
                key = None
                e = None
                if pref:
                    key = f"{pref[0]}:{pref[1]}"
                    if key not in enemies:
                        enemies[key] = brief(self.sm.summary(pref[0], pref[1]))
                        enemies[key]["prefab"] = key
                    e = enemies[key]
                lref = f.ref(s["spawnLine"])
                line = None
                if lref and lref[0] == f.name:
                    line = lines.get(lref[1])
                    if line is None:  # spawn transform without an EnemySpawnLine component (e.g. tutorial): use its child polyline
                        pts = [vec3(f.world_pos(k)) for k in f.tf(lref[1])["children"]]
                        pos = vec3(f.world_pos(lref[1]))
                        length = sum(((a[0] - b[0]) ** 2 + (a[2] - b[2]) ** 2) ** 0.5 for a, b in zip(pts, pts[1:]))
                        line = lines[lref[1]] = {"tf": lref[1], "name": f.go(f.tf(lref[1])["go"])["name"], "path": f.path(f.tf(lref[1])["go"]), "points": pts, "length": R(length),
                                                 "center": [R(sum(p[i] for p in pts) / len(pts)) for i in range(3)] if pts else pos, "difficulty": "n/a", "implicit": True,
                                                 "canSpawnFlying": None, "canSpawnSmallGround": None, "canSpawnBigGround": None, "sharedPaths": [], "separatedPaths": []}
                lname = line["name"] if line else (f"?{lref}" if lref else None)
                n = s["count"]
                hp = (e or {}).get("maxHp", 0) * n
                tags = (e or {}).get("tags", [])
                tot["count"] += n
                tot["hp"] += hp
                tot["coins"] += s["goldCoins"]
                tot["elite"] += n if s["eliteEnemies"] else 0
                tot["flying"] += n if "Flying" in tags else 0
                tot["boss"] += n if "Boss" in tags else 0
                tot["ranged"] += n if "RangedFighter" in tags else 0
                per_line[lname] += n
                span = s["delay"] + max(0, n - 1) * s["interval"]
                dur = max(dur, span)
                sp_out.append({"enemy": key, "enemyName": (e or {}).get("name"), "displayName": (e or {}).get("displayName"), "count": n, "elite": s["eliteEnemies"],
                               "delay": R(s["delay"]), "interval": R(s["interval"]), "waitBeforeNextSpawn": R(s["waitBeforeNextSpawn"]),
                               "goldCoins": s["goldCoins"], "spawnLine": lname,
                               "spawnCenter": line["center"] if line else None, "maxHp": (e or {}).get("maxHp"), "spawnSpanSeconds": R(span)})
            out.append({"index": i, "night": i + 1, "warningText": w["warningText"], "difficultyMulti": R(w["difficultyMulti"]), "spawns": sp_out,
                        "totals": {"enemies": tot["count"], "baseHp": R(tot["hp"], 1), "goldCoins": tot["coins"], "eliteEnemies": tot["elite"], "flying": tot["flying"],
                                   "boss": tot["boss"], "ranged": tot["ranged"], "spawnSpanSeconds": R(dur), "byLine": dict(per_line)}})
        return out

    def slots(self, f: A.SFile) -> list[dict]:
        out = []
        pid2name = {}
        for pid, m in f.monobehaviours("BuildSlot"):
            pid2name[pid] = m.v["buildingName"]
        respawners = {}
        for pid, m in f.monobehaviours("UnitRespawnerForBuildings"):
            r = f.ref(m.v["myBuildSlot"])
            if r:
                respawners[r[1]] = pid
        for pid, m in f.monobehaviours("BuildSlot"):
            v = m.v
            go = f.go(m.go)
            tf = f.transform_of_go(m.go)
            world = f.world(tf)
            act = f.ref(v["activatorBuilding"])
            inter = f.ref(v["interactor"])
            ipos = pos_of(f, inter[1]) if inter and inter[0] == f.name else None
            icol = f.ref(v["interactorCollider"])
            col = None
            if icol and icol[0] == f.name:
                o = f.sf.objects.get(icol[1])
                if o is not None:
                    try:
                        c = o.read()
                        col = {"type": o.type.name, "trigger": bool(getattr(c, "m_IsTrigger", False)), "pos": pos_of(f, icol[1])}
                        if hasattr(c, "m_Size"):
                            col["size"] = vec3((c.m_Size.x, c.m_Size.y, c.m_Size.z))
                            col["center"] = vec3((c.m_Center.x, c.m_Center.y, c.m_Center.z))
                        if hasattr(c, "m_Radius"):
                            col["radius"] = R(c.m_Radius)
                    except Exception:  # noqa: BLE001
                        pass
            levels = []
            for li, up in enumerate(v["upgrades"]):
                branches = []
                for br in up["upgradeBranches"]:
                    acts = []
                    for o in br["objectsToActivate"]:
                        r = f.ref(o)
                        if r:
                            try:
                                acts.append(brief(self.sm.summary(r[0], r[1])))
                            except Exception as e:  # noqa: BLE001
                                acts.append({"error": repr(e)[:120]})
                    # collapse identical repeated objects (e.g. 4 knights) into one entry with a count
                    grouped: dict[str, dict] = {}
                    for a_ in acts:
                        k_ = json.dumps(a_, sort_keys=True)
                        if k_ in grouped:
                            grouped[k_]["count"] += 1
                        else:
                            grouped[k_] = {"count": 1, **a_}
                    acts = list(grouped.values())
                    dis = []
                    for o in br["objectsToDisable"]:
                        r = f.ref(o)
                        if r:
                            dis.append(self.g.file(r[0]).go(r[1])["name"])
                    cd = br["choiceDetails"]
                    branches.append({"choice": {"name": cd["name"], "tooltip": cd["tooltip"], "disabledInMode": cd["disabledInThisMode"]} if cd["name"] or cd["tooltip"] else None,
                                     "goldIncome": br["goldIncomeChange"], "coreIncome": br.get("energyCoreIncomeChange", 0), "hpChange": br["hpChange"],
                                     "activates": acts, "disables": dis, "replacesMesh": bool(f.ref(br["replacementMesh"]))})
                levels.append({"level": li + 1, "cost": up["cost"], "coreCost": up.get("energyCoreCost", 0), "tooltip": up["upgradeTooltip"],
                               "disabledInThisMode": up["disableInThisMode"], "branches": branches})
            rec = {"id": pid, "name": go["name"], "path": f.path(m.go), "building": v["buildingName"], "pos": vec3(world[0]), "yawDeg": R(A.yaw_deg(world[1]), 1),
                   "active": go["active"], "startDeactivated": v["startDeactivated"], "requiredRootLevelDifference": v["requiredRootLevelDifference"],
                   "activator": {"slot": act[1], "building": pid2name.get(act[1]), "level": v["activatorLevel"], "upgradesThis": v["activatorUpgradesThis"]} if act and act[0] == f.name else None,
                   "interactorPos": ipos, "interactorCollider": col, "navmeshCutPadding": R(v["navmeshCutPadding"]),
                   "levels": levels, "totalCost": sum(l["cost"] for l in levels), "totalCoreCost": sum(l["coreCost"] for l in levels),
                   "maxIncome": sum(max((b["goldIncome"] for b in l["branches"]), default=0) for l in levels)}
            if pid in respawners:
                rm = f.mb(respawners[pid])
                rgo = rm.go
                rs = self.sm.summary(f.name, rgo, depth=3)
                rec["unitProducer"] = brief(rs).get("produces")
            out.append(rec)
        return out

    def objects_of(self, f: A.SFile, cls: str, keep=None) -> list[dict]:
        out = []
        for pid, m in f.monobehaviours(cls):
            go = f.go(m.go)
            tf = f.transform_of_go(m.go)
            d = {"id": pid, "name": go["name"], "path": f.path(m.go), "active": go["active"], "pos": vec3(f.world_pos(tf)) if tf else None}
            if keep:
                d.update({k: m.v[k] for k in keep if k in m.v})
            out.append(d)
        return out

    def tagged(self, f: A.SFile, tag: str) -> list[dict]:
        out = []
        want = [k for k, n in self.en.enums["TagManager/ETag"].items() if n == tag][0]
        for pid, m in f.monobehaviours("TaggedObject"):
            if want in m.v["tags"]:
                s = self.sm.summary(f.name, m.go, depth=3)
                tf = f.transform_of_go(m.go)
                out.append({"id": pid, "name": s["name"], "path": f.path(m.go), "pos": vec3(f.world_pos(tf)) if tf else None, "maxHp": s.get("maxHp"), "tags": s.get("tags")})
        return out

    # ------------------------------------------------------------------ level
    def level(self, scene: str, idx: int) -> dict:
        fname = self.g.scene_file(scene)
        f = self.g.file(fname)
        errs: list[str] = []
        rec: dict = {"scene": scene, "buildIndex": idx, "file": fname, "kind": scene_kind(scene, idx), "objects": len(f.sf.objects), "monobehaviourClasses": len(f.class_index())}

        def guard(name, fn, default=None):
            try:
                return fn()
            except Exception as e:  # noqa: BLE001
                errs.append(f"{name}: {e!r}\n{traceback.format_exc(limit=3)}")
                return default

        lines = guard("spawn_lines", lambda: self.spawn_lines(f), {})
        enemies: dict[str, dict] = {}
        spawners = []
        for pid, m in f.monobehaviours("EnemySpawner"):
            def one(pid=pid, m=m):
                ws = self.waves(f, m, lines, enemies)
                gen = f.ref(m.v["waveGeneratorScript"])
                egen = f.ref(m.v["endlessModeWaveGeneratorScript"])
                return {"id": pid, "name": f.go(m.go)["name"], "mode": self.en.name(self.en.field_enum("EnemySpawner", "currentMode") or "", m.v["currentMode"]),
                        "modeRaw": m.v["currentMode"], "goldBalanceAtStart": m.v["goldBalanceAtStart"], "endlessMode": m.v["endlessMode"],
                        "pauseSpawningAtEnemyCount": m.v["pauseSpawningAtEnemyCount"], "reduceSpawnWaitTimes": m.v["reduceSpawnWaitTimes"],
                        "waveGenerator": (self.g.deref_mb(gen).name if gen and self.g.deref_mb(gen) else None),
                        "endlessWaveGenerator": (self.g.deref_mb(egen).name if egen and self.g.deref_mb(egen) else None),
                        "waveCount": len(ws), "waves": ws}
            s = guard("spawner", one)
            if s:
                spawners.append(s)
        rec["spawners"] = spawners
        rec["spawnLines"] = list(lines.values())
        rec["enemies"] = enemies
        rec["buildSlots"] = guard("slots", lambda: self.slots(f), [])
        rec["shrines"] = guard("shrines", lambda: self.objects_of(f, "Shrine", ["maxXp", "collectionRange", "incomeOnceUnlocked", "strengthBonusOnAdditionalShrine"]), [])
        rec["nighthorns"] = guard("horn", lambda: self.objects_of(f, "Nighthorn"), [])
        rec["dayNight"] = guard("daynight", lambda: self.objects_of(f, "DayNightCycle", ["sunriseTime"]), [])
        rec["autoDayNight"] = guard("autodaynight", lambda: self.objects_of(f, "AutoDayNight", ["autoDayLength", "dayLength", "autoNightLength", "nightLength"]), [])
        rec["nightCall"] = guard("nightcall", lambda: self.objects_of(f, "NightCall", ["nightCallTime"]), [])
        rec["castle"] = guard("castle", lambda: self.tagged(f, "CastleCenter"), [])
        rec["heroes"] = guard("hero", lambda: self.hero(f), [])
        rec["units"] = {}
        # derived facts
        ws = spawners[0]["waves"] if spawners else []
        rec["summary"] = {
            "nights": len(ws), "enemiesTotal": sum(w["totals"]["enemies"] for w in ws), "baseHpTotal": R(sum(w["totals"]["baseHp"] for w in ws), 1),
            "goldCoinsTotal": sum(w["totals"]["goldCoins"] for w in ws), "flyingEnemies": sum(w["totals"]["flying"] for w in ws), "bossEnemies": sum(w["totals"]["boss"] for w in ws),
            "spawnLines": len(lines), "buildSlots": len(rec["buildSlots"]),
            "slotsByBuilding": dict(collections.Counter(s["building"] for s in rec["buildSlots"])),
            "hasHorn": bool(rec["nighthorns"]), "shrines": len(rec["shrines"]), "castleFound": bool(rec["castle"]),
            "enemyTypes": sorted({e["name"] for e in enemies.values()}),
        }
        if errs:
            rec["errors"] = errs
        return rec

    def hero(self, f: A.SFile) -> list[dict]:
        out = []
        for pid, m in f.monobehaviours("PlayerMovement"):
            s = self.sm.summary(f.name, m.go, depth=3)
            tf = f.transform_of_go(m.go)
            pi = next((mm for _, mm in f.monobehaviours("PlayerInteraction") if mm.go == m.go), None)
            cu = next((mm for _, mm in f.monobehaviours("CommandUnits") if mm.go == m.go), None)
            out.append({"name": s["name"], "pos": vec3(f.world_pos(tf)), "summary": brief(s), "movement": self.en.decode_fields("PlayerMovement", {k: (R(x) if isinstance(x, float) else x) for k, x in m.v.items()
                                                                                                              if isinstance(x, (int, float, bool, str))}),
                        "interaction": {k: (R(x) if isinstance(x, float) else x) for k, x in (pi.v.items() if pi else []) if isinstance(x, (int, float, bool))},
                        "command": {k: (R(x) if isinstance(x, float) else x) for k, x in (cu.v.items() if cu else []) if isinstance(x, (int, float, bool, str))}})
        return out


def write_csvs(out_dir: str, levels: list[dict]) -> None:
    def w(name, header, rows):
        with open(os.path.join(out_dir, name), "w", newline="", encoding="utf-8") as fh:
            cw = csv.writer(fh)
            cw.writerow(header)
            cw.writerows(rows)

    rows = []
    for L in levels:
        for sp in L["spawners"]:
            for wv in sp["waves"]:
                for s in wv["spawns"]:
                    rows.append([L["scene"], wv["index"], wv["night"], wv["warningText"].replace("\n", " "), wv["difficultyMulti"], s["enemyName"], s["displayName"] or "", s["count"], s["elite"],
                                 s["delay"], s["interval"], s["waitBeforeNextSpawn"], s["goldCoins"], s["spawnLine"] or "", *(s["spawnCenter"] or ["", "", ""]), s["maxHp"] if s["maxHp"] is not None else ""])
    w("waves_all.csv", ["scene", "waveIndex", "night", "warning", "difficultyMulti", "enemy", "displayName", "count", "elite", "delay", "interval", "waitBeforeNextSpawn", "goldCoins", "spawnLine", "cx", "cy", "cz", "maxHp"], rows)

    rows = []
    for L in levels:
        for sl in L["spawnLines"]:
            rows.append([L["scene"], sl["name"], sl["path"], len(sl["points"]), sl["length"], *sl["center"], sl["canSpawnFlying"], sl["canSpawnSmallGround"], sl["canSpawnBigGround"], sl["difficulty"],
                         ";".join(sl["sharedPaths"]), ";".join(sl["separatedPaths"]), json.dumps(sl["points"])])
    w("spawn_lines.csv", ["scene", "name", "path", "points", "length", "cx", "cy", "cz", "flying", "smallGround", "bigGround", "difficulty", "sharedPaths", "separatedPaths", "polylineXYZ"], rows)

    rows = []
    urows = []
    for L in levels:
        for s in L["buildSlots"]:
            rows.append([L["scene"], s["id"], s["name"], s["building"], *s["pos"], s["yawDeg"], *(s["interactorPos"] or ["", "", ""]), s["startDeactivated"], s["activator"]["building"] if s["activator"] else "",
                         s["activator"]["level"] if s["activator"] else "", len(s["levels"]), s["totalCost"], s["totalCoreCost"], s["maxIncome"], "yes" if s.get("unitProducer") else ""])
            for lv in s["levels"]:
                for bi, b in enumerate(lv["branches"]):
                    acts = "; ".join(a.get("name", "?") for a in b["activates"])
                    urows.append([L["scene"], s["id"], s["building"], lv["level"], lv["cost"], lv["coreCost"], bi, b["goldIncome"], b["coreIncome"], b["hpChange"], lv["tooltip"].replace("\n", " "),
                                  (b["choice"] or {}).get("name", ""), acts])
    w("build_slots.csv", ["scene", "slotId", "name", "building", "x", "y", "z", "yaw", "ix", "iy", "iz", "startDeactivated", "activatorBuilding", "activatorLevel", "levels", "totalCost", "totalCoreCost", "maxIncome", "producesUnits"], rows)
    w("upgrades.csv", ["scene", "slotId", "building", "level", "cost", "coreCost", "branch", "goldIncome", "coreIncome", "hpChange", "tooltip", "choiceName", "activates"], urows)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenes", default=".*")
    ap.add_argument("--out", default=OUT)
    a = ap.parse_args()
    ex = Extractor()
    os.makedirs(os.path.join(a.out, "levels"), exist_ok=True)
    rx = re.compile(a.scenes)
    levels = []
    for idx, scene in enumerate(ex.g.scene_names):
        if scene.startswith("_") or not rx.search(scene):
            continue
        t = time.time()
        L = ex.level(scene, idx)
        levels.append(L)
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", scene)
        with open(os.path.join(a.out, "levels", f"{idx:02d}_{safe}.json"), "w", encoding="utf-8") as fh:
            json.dump(L, fh, indent=1, ensure_ascii=False)
        s = L["summary"]
        print(f"{idx:2d} {scene:42s} nights={s['nights']:2d} enemies={s['enemiesTotal']:5d} lines={s['spawnLines']} slots={s['buildSlots']:3d} horn={s['hasHorn']} castle={s['castleFound']} "
              f"err={len(L.get('errors', []))}  {time.time() - t:.1f}s", flush=True)
        ex.g.drop(L["file"])
    # global enemy catalog
    cat: dict[str, dict] = {}
    for L in levels:
        for k, e in L["enemies"].items():
            cat.setdefault(k, e)
    with open(os.path.join(a.out, "enemy_prefabs.json"), "w", encoding="utf-8") as fh:
        json.dump(cat, fh, indent=1, ensure_ascii=False)
    write_csvs(a.out, levels)
    index = [{"scene": L["scene"], "buildIndex": L["buildIndex"], "file": L["file"], "kind": L["kind"], **L["summary"]} for L in levels]
    with open(os.path.join(a.out, "levels_index.json"), "w", encoding="utf-8") as fh:
        json.dump(index, fh, indent=1, ensure_ascii=False)
    print(f"wrote {len(levels)} levels, {len(cat)} enemy prefabs -> {a.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
