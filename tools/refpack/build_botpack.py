"""build_botpack — one compact, JsonUtility-friendly JSON per scene for the in-game bot.

JsonUtility (Unity) cannot read dictionaries or arrays of arrays, so every collection is a flat array of small
[Serializable] records, and the walkable grid is a flat int[] of (row, start, length) triples.
Schema version 1; field names are stable. Loader sketch: reference/botpack/BotPackLoader.cs.txt

usage: python build_botpack.py
"""
from __future__ import annotations

import glob
import hashlib
import json
import math
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_handbook import Level, jl  # noqa: E402
from tf_unlock import unlock_info  # noqa: E402

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
DATA = os.path.join(REF, "data")
OUT = os.path.join(REF, "botpack")
GAME_VERSION = "2.13"
ASSEMBLY_SHA256 = "F350269E5D14213C7486CE65478A8B91651D01B954BDA3D1C18D18C4E30B6505"


def r(x, n=2):
    """Round; JsonUtility cannot read JSON null for numbers, so 'unknown' is -1."""
    return -1.0 if x is None else round(float(x), n)


def flat_runs(rows):
    out = []
    for j, runs in enumerate(rows):
        for s, n in runs:
            out += [j, s, n]
    return out


def build(lv: Level, infos: dict, hero_defaults: dict) -> dict:
    L, T, N = lv.L, lv.T, lv.N
    info = infos.get(lv.name, {})
    hero = (L["heroes"] or [{}])[0]
    hm, hi = hero.get("movement", {}), hero.get("interaction", {})
    sp = lv.sp
    pack: dict = {"schemaVersion": 1, "scene": lv.name, "buildIndex": lv.idx, "gameVersion": GAME_VERSION, "assemblySha256": ASSEMBLY_SHA256,
                  "castleX": r(lv.castle[0]) if lv.castle else 0, "castleY": r(lv.castle[1]) if lv.castle else 0, "castleZ": r(lv.castle[2]) if lv.castle else 0,
                  "hero": {"radius": r((T or {}).get("hero", {}).get("radius", 0.71)), "height": r((T or {}).get("hero", {}).get("height", 3.0)), "step": r((T or {}).get("hero", {}).get("step", 0.3)),
                           "slope": r((T or {}).get("hero", {}).get("slope", 45.0)), "skin": r((T or {}).get("hero", {}).get("skin", 0.1)),
                           "walkSpeed": r(hm.get("speed")), "dayWalkSpeed": r(hm.get("speedDuringDay")), "sprintSpeed": r(hm.get("sprintSpeed")), "daySprintSpeed": r(hm.get("sprintSpeedDuringDay")),
                           "interactionRadius": r(hi.get("interactionRadius", 3.0)), "coinMagnetRadius": r(hi.get("coinMagnetRadius", 7.0))},
                  "rules": {"startGold": sp["goldBalanceAtStart"] if sp else 0, "nightCallSeconds": r((L.get("nightCall") or [{}])[0].get("nightCallTime", 0)),
                            "autoDay": bool(L.get("autoDayNight")), "autoDaySeconds": r((L.get("autoDayNight") or [{}])[0].get("dayLength", 0)) if L.get("autoDayNight") else 0,
                            "pauseSpawningAtEnemyCount": sp["pauseSpawningAtEnemyCount"] if sp else 0, "maxPerkCount": info.get("maxPerkCount", 5),
                            "requiresBeatenLevel": info.get("requiresBeatenLevel") or "", "fixedLoadout": ", ".join(info.get("fixedLoadout") or [])}}
    # enemies
    enemies = []
    for key, e in lv.enemies.items():
        at = (e.get("attacks") or [{}])[0]
        tags = e.get("tags", [])
        enemies.append({"prefab": key, "name": e["name"], "displayName": e.get("displayName") or e["name"], "hp": r(e.get("maxHp")), "speed": r(e.get("speed")), "range": r(at.get("range")),
                        "damage": r(at.get("baseDamage")), "cooldown": r(at.get("cooldown")), "dps": r(at.get("dps")), "flying": "Flying" in tags, "ranged": "RangedFighter" in tags,
                        "boss": "Boss" in tags, "siege": "SiegeWeapon" in tags, "fast": "FastMoving" in tags, "tags": ",".join(t for t in tags if t not in ("EnemyOwned", "AUTO_Alive"))})
    pack["enemies"] = enemies
    # nights + spawn groups
    nights, groups = [], []
    if sp:
        for wv in sp["waves"]:
            etas, last = [], []
            for sx in wv["spawns"]:
                tr, method = lv.travel(sx)
                eta = (sx["delay"] + tr) if tr is not None else None
                lastarr = (sx["delay"] + max(0, sx["count"] - 1) * sx["interval"] + tr) if tr is not None else None
                if eta is not None:
                    etas.append(eta)
                    last.append(lastarr)
                groups.append({"night": wv["night"], "enemy": sx["enemy"] or "", "count": sx["count"], "elite": bool(sx["elite"]), "delay": r(sx["delay"]), "interval": r(sx["interval"]),
                                "goldCoins": sx["goldCoins"], "line": sx["spawnLine"] or "", "travelSeconds": r(tr), "firstContactSeconds": r(eta), "lastArrivalSeconds": r(lastarr)})
            t = wv["totals"]
            nights.append({"night": wv["night"], "warning": wv["warningText"].replace("\n", " "), "enemies": t["enemies"], "baseHp": r(t["baseHp"], 1), "ranged": t["ranged"], "flying": t["flying"],
                           "boss": t["boss"], "elite": t["eliteEnemies"], "goldCoins": t["goldCoins"], "spawnSpanSeconds": r(t["spawnSpanSeconds"]),
                           "firstContactSeconds": r(min(etas)) if etas else -1.0, "lastArrivalSeconds": r(max(last)) if last else -1.0, "difficultyMulti": r(wv["difficultyMulti"])})
    pack["nights"], pack["spawnGroups"] = nights, groups
    # spawn lines + points + route points
    lines, pts, rps = [], [], []
    for sl in L["spawnLines"]:
        rt = None
        for rr in lv.routes:
            c = rr.get("spawnCenterXZ")
            if c and math.hypot(c[0] - sl["center"][0], c[1] - sl["center"][2]) < 3.0:
                rt = rr
                break
        lines.append({"name": sl["name"], "cx": r(sl["center"][0]), "cy": r(sl["center"][1]), "cz": r(sl["center"][2]), "length": r(sl["length"]), "canSpawnFlying": bool(sl.get("canSpawnFlying")),
                      "canSpawnSmallGround": bool(sl.get("canSpawnSmallGround")), "canSpawnBigGround": bool(sl.get("canSpawnBigGround")),
                      "routeLengthM": r(rt.get("lengthM")) if rt else -1.0, "chokeX": r(rt["narrowestAtXZ"][0]) if rt and rt.get("narrowestAtXZ") else 0, "chokeZ": r(rt["narrowestAtXZ"][1]) if rt and rt.get("narrowestAtXZ") else 0,
                      "chokeClearanceM": r(rt.get("narrowestClearanceM")) if rt and rt.get("narrowestClearanceM") is not None else -1.0})
        for p in sl["points"]:
            pts.append({"line": sl["name"], "x": r(p[0]), "y": r(p[1]), "z": r(p[2])})
        if rt and rt.get("waypoints"):
            for i, wp in enumerate(rt["waypoints"]):
                rps.append({"line": sl["name"], "i": i, "x": r(wp[0]), "z": r(wp[1])})
    pack["spawnLines"], pack["spawnPoints"], pack["routePoints"] = lines, pts, rps
    # slots
    tslots = {s["id"]: s for s in (T or {}).get("slots", [])}
    unlock = unlock_info(L["buildSlots"])
    slots, stands, levels, ipts = [], [], [], []
    for sl in L["buildSlots"]:
        ts = tslots.get(sl["id"], {})
        act = sl["activator"]
        first = len(stands)
        for q in ts.get("standPoints", []):
            stands.append({"slotId": sl["id"], "x": q["x"], "y": q.get("y", 0), "z": q["z"], "pathFromCastleM": q.get("pathFromCastleM") if q.get("pathFromCastleM") is not None else -1.0, "clearanceM": q["clearanceM"]})
        for pi, poly in enumerate(ts.get("interactorPolygons", [])):
            for k, (px, pz) in enumerate(poly):
                ipts.append({"slotId": sl["id"], "poly": pi, "k": k, "x": px, "z": pz})
        slots.append({"id": sl["id"], "name": sl["name"], "building": sl["building"], "x": sl["pos"][0], "y": sl["pos"][1], "z": sl["pos"][2], "startDeactivated": sl["startDeactivated"],
                      "activatorId": act["slot"] if act else 0, "activatorBuilding": act["building"] if act else "", "activatorLevel": act["level"] if act else 0, "levelCount": len(sl["levels"]),
                      "totalCost": sl["totalCost"], "maxIncome": sl["maxIncome"], "standFirst": first, "standCount": len(stands) - first, "connectedToCastle": ts.get("connectedToCastleInModel", True),
                      "producesUnits": bool(sl.get("unitProducer")), "rootId": unlock[sl["id"]]["rootId"], "requiredRootLevelDifference": sl["requiredRootLevelDifference"],
                      "unlockAfterUpgradeNumber": unlock[sl["id"]]["upgradeNumber"], "unlockCostGold": unlock[sl["id"]]["costGold"],
                      "followsActivatorUpgrades": bool(act and act.get("upgradesThis"))})
        for lv_ in sl["levels"]:
            for bi, br in enumerate(lv_["branches"]):
                mil = 0
                towerdps = 0.0
                for a in br["activates"]:
                    if a.get("produces"):
                        mil += a["produces"]["unitCount"]
                    for at in a.get("attacks", []) or []:
                        towerdps = max(towerdps, at.get("dps") or 0)
                levels.append({"slotId": sl["id"], "level": lv_["level"], "branch": bi, "cost": lv_["cost"], "choice": (br["choice"] or {}).get("name", ""), "goldIncome": br["goldIncome"], "hpChange": br["hpChange"],
                               "unitsProduced": mil, "attackDps": r(towerdps)})
    pack["slots"], pack["standPoints"], pack["upgradeBranches"], pack["interactorPoints"] = slots, stands, levels, ipts
    pack["shrines"] = [{"x": s["pos"][0], "y": s["pos"][1], "z": s["pos"][2], "maxXp": r(s.get("maxXp")), "range": r(s.get("collectionRange")), "income": s.get("incomeOnceUnlocked", 0)} for s in L["shrines"] if s["pos"]]
    pack["gates"] = [{"x": g["pos"][0], "y": g["pos"][1], "z": g["pos"][2], "openDistance": g["openDistance"], "mode": g["mode"]} for g in (T or {}).get("gates", [])]
    # obstacles as AABBs (approximate; the grid is authoritative)
    obs = []
    for o in (T or {}).get("obstacles", []):
        s = o["shape"]
        if "center" in s and "size" in s:
            hx, hz = s["size"][0] / 2, s["size"][2] / 2
            yaw = math.radians(s.get("yawDeg", 0))
            ex = abs(hx * math.cos(yaw)) + abs(hz * math.sin(yaw))
            ez = abs(hx * math.sin(yaw)) + abs(hz * math.cos(yaw))
            box = (s["center"][0] - ex, s["center"][2] - ez, s["center"][0] + ex, s["center"][2] + ez)
        elif "center" in s and "radius" in s:
            box = (s["center"][0] - s["radius"], s["center"][2] - s["radius"], s["center"][0] + s["radius"], s["center"][2] + s["radius"])
        elif "bounds" in s:
            box = tuple(s["bounds"])
        else:
            continue
        obs.append({"category": o["category"], "layer": o["layer"], "name": o["name"], "slotId": o.get("slot") or 0, "potential": bool(o.get("potential")), "minX": r(box[0]), "minZ": r(box[1]), "maxX": r(box[2]), "maxZ": r(box[3]),
                    "yMin": o["ymin"], "yMax": o["ymax"]})
    pack["obstacles"] = obs
    if T:
        g = T["grid"]
        pack["grid"] = {"resolution": g["resolution"], "originX": g["originXZ"][0], "originZ": g["originXZ"][1], "width": g["width"], "height": g["height"], "encoding": "runs are (row, startColumn, length) triples; cell(x,z)=(floor((x-originX)/res), floor((z-originZ)/res))",
                        "walkableUnbuiltRuns": flat_runs(g["walkableStaticRLE"]), "walkableAllBuiltRuns": flat_runs(g["walkableWithBuildingsRLE"]), "surfaceRuns": flat_runs(g["navSurfaceRLE"])}
        pack["reachability"] = {"reachableAreaM2": T["reachability"]["reachableAreaM2"], "slotsWithoutStandPoint": T["reachability"]["slotsWithoutStandPoint"], "multiStoreyWarning": any(s.get("connectedToCastleInModel") is False for s in T["slots"])}
    return pack


def main() -> int:
    os.makedirs(OUT, exist_ok=True)
    infos = {x["sceneName"]: x for x in jl(os.path.join(DATA, "level_infos.json"))}
    total = 0
    index = []
    for p in sorted(glob.glob(os.path.join(DATA, "levels", "*.json"))):
        lv = Level(p, os.path.join(DATA, "terrain"), os.path.join(DATA, "navmesh"))
        pack = build(lv, infos, {})
        path = os.path.join(OUT, f"{lv.idx:02d}_{lv.safe}.botpack.json")
        txt = json.dumps(pack, separators=(",", ":"), ensure_ascii=False)
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(txt)
        os.makedirs(os.path.join(OUT, "by-scene"), exist_ok=True)   # same content under the exact scene name, e.g. by-scene/Nordfels.json (matches agent/botpack/<Scene>.json)
        with open(os.path.join(OUT, "by-scene", re.sub(r'[<>:"/\|?*]', "_", lv.name) + ".json"), "w", encoding="utf-8") as fh:
            fh.write(txt)
        total += len(txt)
        index.append({"file": os.path.basename(path), "scene": lv.name, "bytes": len(txt), "nights": len(pack["nights"]), "slots": len(pack["slots"]), "standPoints": len(pack["standPoints"]),
                      "sha256": hashlib.sha256(txt.encode("utf-8")).hexdigest()[:16]})
        print(f"{lv.idx:2d} {lv.name:38s} {len(txt) / 1024:8.0f} KB  nights={len(pack['nights'])} slots={len(pack['slots'])} stand={len(pack['standPoints'])} obstacles={len(pack['obstacles'])}")
    json.dump(index, open(os.path.join(OUT, "index.json"), "w", encoding="utf-8"), indent=1)
    print(f"total {total / 1e6:.1f} MB in {len(index)} files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
