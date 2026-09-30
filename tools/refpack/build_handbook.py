"""build_handbook — turn the extracted game data into per-level handbook pages (Markdown + overview map figures).

Everything printed is either copied from the decoded asset files or computed from them by the formulas stated on the page
(e.g. arrival time = spawn delay + route length / enemy speed). Derived guidance is labelled as such.

usage: python build_handbook.py [--scenes REGEX]
"""
from __future__ import annotations

import argparse
import collections
import csv
import glob
import json
import math
import os
import re
import sys

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tf_unlock import unlock_info  # noqa: E402

REF =r"K:\Downloads-IDM\Thronefall\Trainer\reference"
DATA = os.path.join(REF, "data")
DOCS = os.path.join(REF, "docs", "levels")
IMG = os.path.join(REF, "img", "levels")

CAMPAIGN = {4, 5, 6, 7, 8, 9, 25, 26, 27, 28}

SLOT_GROUPS = {
    "Castle Center": ("castle", "#f2b600"), "Defense Tower": ("tower", "#2b7bba"), "Barracks": ("military", "#1a9850"), "Archery Range": ("military", "#1a9850"),
    "House": ("economy", "#e6a100"), "Field": ("economy", "#e6a100"), "Mill": ("economy", "#e6a100"), "Wall": ("wall", "#7f7f7f"), "Gate Wide": ("wall", "#7f7f7f"),
    "Shrine": ("shrine", "#8e44ad"), "Blacksmith": ("support", "#a0522d"), "Summoning Circle": ("other", "#999999"),
}


def group_of(building: str):
    return SLOT_GROUPS.get(building, ("other", "#999999"))


def jl(path):
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def fmt(x, nd=1):
    if x is None:
        return "–"
    if isinstance(x, float):
        return f"{x:.{nd}f}".rstrip("0").rstrip(".") if nd else str(int(round(x)))
    return str(x)


def md_table(header, rows, align=None):
    out = ["| " + " | ".join(header) + " |", "|" + "|".join((":---:" if (align and align[i] == "c") else ("---:" if (align and align[i] == "r") else "---")) for i in range(len(header))) + "|"]
    for r in rows:
        out.append("| " + " | ".join(str(c).replace("|", "\\|").replace("\n", " ") for c in r) + " |")
    return "\n".join(out)


def can_hit_air(attack: dict) -> bool | None:
    ts = attack.get("targets") or []
    if not ts:
        return None
    return any("Flying" not in t["not"] for t in ts)


class Level:
    def __init__(self, path: str, terrain_dir: str, navmesh_dir: str):
        self.L = jl(path)
        base = os.path.basename(path)
        self.T = jl(os.path.join(terrain_dir, base)) if os.path.exists(os.path.join(terrain_dir, base)) else None
        self.N = jl(os.path.join(navmesh_dir, base)) if os.path.exists(os.path.join(navmesh_dir, base)) else None
        self.npz = np.load(os.path.join(terrain_dir, base.replace(".json", ".npz"))) if os.path.exists(os.path.join(terrain_dir, base.replace(".json", ".npz"))) else None
        self.idx = self.L["buildIndex"]
        self.name = self.L["scene"]
        self.safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", self.name)
        self.enemies = self.L["enemies"]
        self.sp = self.L["spawners"][0] if self.L["spawners"] else None
        self.routes = (self.N or {}).get("enemyRoutes", [])
        self.castle = (self.L["castle"] or [{}])[0].get("pos")

    # ------------------------------------------------------------------ helpers
    def route_for(self, center):
        best, bd = None, 1e9
        if center is None:
            return None
        for r in self.routes:
            c = r.get("spawnCenterXZ")
            if not c:
                continue
            d = math.hypot(c[0] - center[0], c[1] - center[2])
            if d < bd:
                best, bd = r, d
        return best if bd < 3.0 else None

    def travel(self, spawn: dict) -> tuple[float | None, str]:
        """(seconds from spawn to castle contact for the enemy of this spawn group, method)."""
        e = self.enemies.get(spawn["enemy"]) or {}
        speed = e.get("speed") or 0
        tags = e.get("tags", [])
        if not speed or not self.castle or not spawn.get("spawnCenter"):
            return None, "n/a"
        sc = spawn["spawnCenter"]
        if "Flying" in tags:
            d = math.hypot(sc[0] - self.castle[0], sc[2] - self.castle[2])
            return d / speed, f"straight line {d:.0f} m"
        r = self.route_for(sc)
        if r and r.get("lengthM"):
            return r["lengthM"] / speed, f"navmesh route {r['lengthM']:.0f} m"
        d = math.hypot(sc[0] - self.castle[0], sc[2] - self.castle[2])
        return d / speed, f"straight line {d:.0f} m (no ground route)"

    # ------------------------------------------------------------------ figure
    def figure(self):
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        from matplotlib.lines import Line2D
        os.makedirs(IMG, exist_ok=True)
        fig, ax = plt.subplots(figsize=(11.5, 9))
        ext = None
        if self.npz is not None and self.T:
            g = self.T["grid"]
            res = g["resolution"]
            x0, z0 = g["originXZ"]
            surf, ws, wa = self.npz["navSurface"], self.npz["walkableStatic"], self.npz["walkableWithBuildings"]
            H, W = surf.shape
            img = np.full((H, W, 3), 0.965)
            img[surf] = (0.80, 0.88, 0.96)
            img[wa] = (0.86, 0.94, 0.86)
            img[ws & ~wa] = (0.93, 0.86, 0.72)
            img[surf & ~ws] = (0.30, 0.30, 0.34)
            ext = (x0, x0 + W * res, z0, z0 + H * res)
            ax.imshow(img, origin="lower", extent=ext, interpolation="nearest")
        # spawn lines + routes
        for sl in self.L["spawnLines"]:
            pts = sl["points"]
            fly = sl.get("canSpawnFlying") and not sl.get("canSpawnSmallGround")
            if len(pts) > 1:
                ax.plot([p[0] for p in pts], [p[2] for p in pts], c="#d1362f", lw=2.4, zorder=4)
            c = sl["center"]
            ax.annotate(sl["name"], (c[0], c[2]), fontsize=7, color="#8b1a14", xytext=(3, 3), textcoords="offset points", zorder=6)
        for r in self.routes:
            if r.get("waypoints"):
                ax.plot([p[0] for p in r["waypoints"]], [p[1] for p in r["waypoints"]], c="#d1362f", lw=1.0, ls="--", alpha=0.85, zorder=3)
                ax.scatter([r["narrowestAtXZ"][0]], [r["narrowestAtXZ"][1]], c="k", s=12, zorder=5)
        # slots
        seen = {}
        for s in self.L["buildSlots"]:
            grp, col = group_of(s["building"])
            ax.scatter([s["pos"][0]], [s["pos"][2]], s=16 if grp != "wall" else 8, c=col, edgecolors="none", zorder=5, alpha=0.95)
            seen[grp] = col
        for sh in self.L["shrines"]:
            if sh["pos"]:
                ax.add_patch(plt.Circle((sh["pos"][0], sh["pos"][2]), sh.get("collectionRange", 20), fill=False, ec="#8e44ad", lw=0.6, ls=":", alpha=0.6, zorder=2))
        if self.castle:
            ax.scatter([self.castle[0]], [self.castle[2]], s=220, marker="*", c="#f2b600", edgecolors="k", zorder=7)
        handles = [Line2D([0], [0], marker="o", ls="", color=c, label=g, markersize=6) for g, c in seen.items()]
        handles += [Line2D([0], [0], color="#d1362f", lw=2.4, label="enemy spawn line"), Line2D([0], [0], color="#d1362f", lw=1, ls="--", label="ground route to castle"),
                    Line2D([0], [0], marker="o", ls="", color="k", label="narrowest point of route", markersize=4), Line2D([0], [0], marker="*", ls="", color="#f2b600", mec="k", label="castle", markersize=12)]
        ax.legend(handles=handles, loc="upper left", fontsize=7, framealpha=0.9, ncol=2)
        ax.set_aspect("equal")
        ax.set_title(f"{self.name}: green = hero-walkable, tan = walkable only while unbuilt, dark = static blockers, blue = other navmesh, dotted = shrine range", fontsize=9)
        ax.set_xlabel("X (m)")
        ax.set_ylabel("Z (m)")
        p = os.path.join(IMG, f"{self.idx:02d}_{self.safe}_overview.png")
        fig.savefig(p, dpi=105, bbox_inches="tight")
        plt.close(fig)
        return p

    # ------------------------------------------------------------------ page
    def page(self, infos: dict, eq_by_name: dict) -> str:
        L, T, sp = self.L, self.T, self.sp
        info = infos.get(self.name, {})
        s = L["summary"]
        out: list[str] = []
        w = out.append
        w(f"# {self.name} — level handbook\n")
        w(f"*Generated from the shipped asset files (build index {self.idx}, scene file `{L['file']}`). Every number is decoded or computed from them; formulas are stated where used. "
          f"Provenance and checks: [verification](../12-verification-and-coverage.md).*\n")
        w("## 1. At a glance\n")
        rows = [["Unlock requirement", f"beat **{info.get('requiresBeatenLevel')}**" if info.get("requiresBeatenLevel") else "none (first level)"],
                ["Nights (waves)", s["nights"]], ["Enemies in total", s["enemiesTotal"]], ["Total enemy base HP", fmt(s["baseHpTotal"], 0)],
                ["Gold coins dropped by waves (sum of `goldCoins`)", s["goldCoinsTotal"]], ["Flying enemies / bosses", f"{s['flyingEnemies']} / {s['bossEnemies']}"],
                ["Enemy spawn lines", s["spawnLines"]], ["Build slots", s["buildSlots"]], ["Shrines", s["shrines"]],
                ["Starting gold (`goldBalanceAtStart`)", sp["goldBalanceAtStart"] if sp else "–"], ["Wave generator asset", sp["waveGenerator"] if sp else "–"],
                ["Perk slots (`maxPerkCount`)", info.get("maxPerkCount", "–")], ["Fixed loadout", ", ".join(info.get("fixedLoadout") or []) or "none"],
                ["Castle position (x, y, z)", ", ".join(fmt(v, 1) for v in self.castle) if self.castle else "–"]]
        if L.get("nightCall"):
            rows.append(["Hold-to-call-night time (`nightCallTime`)", f"{L['nightCall'][0].get('nightCallTime')} s (key: Space)"])
        if L.get("autoDayNight"):
            a = L["autoDayNight"][0]
            rows.append(["Automatic day/night (`AutoDayNight`)", f"day {a.get('dayLength')} s (auto={a.get('autoDayLength')}), night {a.get('nightLength')} s (auto={a.get('autoNightLength')})"])
        if L["heroes"]:
            hm = L["heroes"][0]["movement"]
            rows.append(["Hero speed (walk / day-walk / sprint / day-sprint)", f"{hm.get('speed')} / {hm.get('speedDuringDay')} / {hm.get('sprintSpeed')} / {hm.get('sprintSpeedDuringDay')} m/s"])
            hi = L["heroes"][0]["interaction"]
            rows.append(["Interaction / coin-magnet radius", f"{hi.get('interactionRadius')} m / {hi.get('coinMagnetRadius')} m"])
        w(md_table(["Item", "Value"], rows) + "\n")
        w(f"![overview map](../../img/levels/{self.idx:02d}_{self.safe}_overview.png)\n")
        w("*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. "
          "Built from colliders + the baked A* navmesh; see §7.*\n")

        # -------- entry points
        w("## 2. Where enemies come from\n")
        w("Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked "
          "'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.\n")
        rows = []
        for sl in L["spawnLines"]:
            r = self.route_for([sl["center"][0], 0, sl["center"][2]] if False else [sl["center"][0], sl["center"][1], sl["center"][2]])
            r2 = None
            for rr in self.routes:
                c = rr.get("spawnCenterXZ")
                if c and math.hypot(c[0] - sl["center"][0], c[1] - sl["center"][2]) < 3.0:
                    r2 = rr
                    break
            kinds = []
            if sl.get("canSpawnFlying"):
                kinds.append("air")
            if sl.get("canSpawnSmallGround"):
                kinds.append("small")
            if sl.get("canSpawnBigGround"):
                kinds.append("big")
            rows.append([sl["name"], f"({fmt(sl['center'][0], 0)}, {fmt(sl['center'][2], 0)})", fmt(sl["length"], 1), "/".join(kinds) or "–", sl.get("difficulty", "–"),
                         fmt(r2.get("lengthM"), 0) if r2 and r2.get("lengthM") else "–", fmt(r2.get("narrowestClearanceM"), 1) if r2 and r2.get("narrowestClearanceM") is not None else "–",
                         (f"({fmt(r2['narrowestAtXZ'][0], 0)}, {fmt(r2['narrowestAtXZ'][1], 0)})" if r2 and r2.get("narrowestAtXZ") else "–"),
                         ", ".join(sl.get("sharedPaths") or []) or "–"])
        w(md_table(["Spawn line", "Centre (x, z)", "Line length m", "Can spawn", "Difficulty", "Route to castle m", "Narrowest clearance m", "Choke (x, z)", "Shares path with"], rows, align=["l", "l", "r", "l", "l", "r", "r", "l", "l"]) + "\n")

        # -------- nights
        w("## 3. Night by night\n")
        if sp:
            w(f"`EnemySpawner` mode: **{sp['mode']}**; wave generator asset: `{sp['waveGenerator']}`; `pauseSpawningAtEnemyCount` = {sp['pauseSpawningAtEnemyCount']} (spawning pauses while that many enemies are alive; "
              f"see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.\n")
            rows = []
            for wv in sp["waves"]:
                comp = collections.Counter()
                for sx in wv["spawns"]:
                    comp[(sx["displayName"] or sx["enemyName"] or "?") + (" (elite)" if sx["elite"] else "")] += sx["count"]
                etas, last = [], []
                methods = set()
                for sx in wv["spawns"]:
                    tr, method = self.travel(sx)
                    if tr is None:
                        continue
                    methods.add(method.split(" ")[0])
                    etas.append(sx["delay"] + tr)
                    last.append(sx["delay"] + max(0, sx["count"] - 1) * sx["interval"] + tr)
                t = wv["totals"]
                rows.append([wv["night"], wv["warningText"].replace("\n", " ")[:90], t["enemies"], fmt(t["baseHp"], 0), t["ranged"], t["flying"], t["boss"], t["goldCoins"],
                             ", ".join(f"{n}× {c}" for c, n in comp.most_common()), ", ".join(f"{k}:{v}" for k, v in t["byLine"].items()), fmt(min(etas), 0) if etas else "–", fmt(max(last), 0) if last else "–"])
            w(md_table(["Night", "In-game warning", "Enemies", "Base HP", "Ranged", "Flying", "Boss", "Coins", "Composition", "By spawn line", "First contact s", "Last arrival s"], rows,
                       align=["c", "l", "r", "r", "r", "r", "r", "r", "l", "l", "r", "r"]) + "\n")
            w("*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). "
              "Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way "
              "(see [combat doc](../mechanics/03-combat-units-targeting.md)).*\n")
            hp = [wv["totals"]["baseHp"] for wv in sp["waves"]]
            if hp:
                hardest = int(np.argmax(hp)) + 1
                w(f"**Derived:** the heaviest night by total base HP is night {hardest} ({fmt(max(hp), 0)} HP, {sp['waves'][hardest - 1]['totals']['enemies']} enemies); "
                  f"night-to-night HP ratio (last/first) = {fmt(hp[-1] / max(hp[0], 1), 1)}×. Ranged enemies appear on nights "
                  f"{', '.join(str(wv['night']) for wv in sp['waves'] if wv['totals']['ranged'])}; flyers on nights "
                  f"{', '.join(str(wv['night']) for wv in sp['waves'] if wv['totals']['flying']) or 'none'}.\n")

        # -------- enemies
        w("## 4. Enemy roster\n")
        rows = []
        for key, e in sorted(self.enemies.items(), key=lambda kv: kv[1].get("maxHp", 0)):
            at = (e.get("attacks") or [{}])[0]
            prios = ""
            rows.append([e.get("displayName") or e["name"], e["name"], fmt(e.get("maxHp"), 0), fmt(e.get("speed"), 1), fmt(at.get("range"), 1), fmt(at.get("baseDamage"), 1), fmt(at.get("cooldown"), 2), fmt(at.get("dps"), 2),
                         ", ".join(t for t in e.get("tags", []) if t not in ("EnemyOwned", "AUTO_Alive")), (e.get("description") or "")[:110]])
        w(md_table(["Name", "Prefab", "HP", "Speed", "Range", "Damage", "Cooldown", "DPS", "Tags", "In-game description"], rows, align=["l", "l", "r", "r", "r", "r", "r", "r", "l", "l"]) + "\n")
        w("*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*\n")

        # -------- buildings
        w("## 5. Buildings, costs and unlocks\n")
        by_type = collections.defaultdict(list)
        for sl in L["buildSlots"]:
            by_type[sl["building"]].append(sl)
        ui_all = unlock_info(L["buildSlots"])
        rows = []
        for b, lst in sorted(by_type.items(), key=lambda kv: (group_of(kv[0])[0], kv[0])):
            sl = lst[0]
            cnt = collections.Counter(((s_["activator"]["building"], ui_all[s_["id"]]["upgradeNumber"]) if s_["activator"] and s_["startDeactivated"] else ("start", 0)) for s_ in lst)
            unlock_txt = ", ".join((f"{a_} upgrade #{n_} ×{c_}" if a_ != "start" else f"from the start ×{c_}") for (a_, n_), c_ in sorted(cnt.items(), key=lambda kv: (kv[0][1], kv[0][0])))
            gold = collections.Counter(ui_all[s_["id"]]["costGold"] for s_ in lst)
            gold_txt = ", ".join(f"{g_} g ×{c_}" if g_ >= 0 else f"? ×{c_}" for g_, c_ in sorted(gold.items()))
            follower = " (shares its activator's upgrades)" if sl["activator"] and sl["activator"].get("upgradesThis") else ""
            rows.append([b, len(lst), group_of(b)[0], unlock_txt + follower, gold_txt, len(sl["levels"]), " → ".join(str(l["cost"]) for l in sl["levels"]) + (f" (+{sl['totalCoreCost']} cores)" if sl["totalCoreCost"] else ""),
                         sl["maxIncome"], sl["requiredRootLevelDifference"] if sl["requiredRootLevelDifference"] > -100 else "–"])
        w(md_table(["Building", "Slots", "Role", "Slot appears when (activator upgrade #, count)", "Prerequisite gold spent first (count)", "Levels", "Gold cost per level", "Max income/day", "Level-cap diff"], rows,
                   align=["l", "r", "l", "l", "l", "r", "l", "r", "r"]) + "\n")
        w("*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). "
          "'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is "
          "greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*\n")
        tl = collections.defaultdict(collections.Counter)
        for s_ in L["buildSlots"]:
            tl[ui_all[s_["id"]]["costGold"]][s_["building"]] += 1
        w("**Unlock timeline (derived):** " + "; ".join(f"**{c} g** → " + ", ".join(f"{n}× {b_}" for b_, n in sorted(v.items())) for c, v in sorted(tl.items()) if c >= 0) + ".\n")
        tot = sum(sl["totalCost"] for sl in L["buildSlots"])
        inc = sum(sl["maxIncome"] for sl in L["buildSlots"])
        w(f"**Totals:** building every slot to its final level costs **{tot} gold**; if everything is at maximum level the buildings pay **{inc} gold per dawn** (`goldIncomeChange`, paid at dawn only — "
          f"see the [economy doc](../mechanics/02-economy-building-upgrades.md)).\n")
        # detailed upgrade choices for military/tower types
        for b in ("Castle Center", "Defense Tower", "Barracks", "Archery Range", "Blacksmith", "Mill", "House", "Shrine"):
            if b not in by_type:
                continue
            sl = by_type[b][0]
            w(f"### 5.{list(by_type).index(b) + 1 if False else ''} {b}\n".replace("5. ", "").replace("### ", "### ", 1))
            rows = []
            for lv in sl["levels"]:
                for bi, br in enumerate(lv["branches"]):
                    ch = (br["choice"] or {}).get("name") or ""
                    parts = []
                    for a in br["activates"]:
                        nm = a.get("displayName") or a["name"]
                        bits = []
                        if a.get("maxHp"):
                            bits.append(f"HP {fmt(a['maxHp'], 0)}")
                        for at in a.get("attacks", []) or []:
                            if at.get("range"):
                                bits.append(f"range {fmt(at['range'], 1)}, dps {fmt(at.get('dps'), 2)}")
                        if not a.get("produces"):
                            seen_c = collections.Counter()
                            for c in a.get("children", []) or []:
                                for at in c.get("attacks", []) or []:
                                    if at.get("range"):
                                        seen_c[f"{c['name']}: range {fmt(at['range'], 1)}, dps {fmt(at.get('dps'), 2)}"] += 1
                            bits += [k + (f" ×{n}" if n > 1 else "") for k, n in seen_c.items()]
                        if a.get("produces"):
                            for u in a["produces"]["unitTypes"]:
                                ub = u["sample"]
                                at = (ub.get("attacks") or [{}])[0]
                                bits.append(f"{a['produces']['unitCount']}× {ub.get('displayName') or u['name']} (HP {fmt(ub.get('maxHp'), 0)}, speed {fmt(ub.get('speed'), 1)}, range {fmt(at.get('range'), 1)}, dps {fmt(at.get('dps'), 2)}); respawn s by level {a['produces']['respawnSecondsByLevel']}")
                        cnt = f"{a['count']}× " if a.get("count", 1) > 1 else ""
                        if bits or nm not in ("Level 2 Bonuses",):
                            parts.append(f"{cnt}{nm}" + (f" [{'; '.join(bits)}]" if bits else ""))
                    rows.append([lv["level"], lv["cost"], lv["coreCost"] or "", ch, br["goldIncome"] or "", br["hpChange"] or "", (lv["tooltip"] or "")[:60], "; ".join(parts[:4])[:260]])
            w(md_table(["Lvl", "Gold", "Cores", "Choice", "Income", "HP +", "Tooltip", "Activates"], rows, align=["c", "r", "r", "l", "r", "r", "l", "l"]) + "\n")

        # -------- economy of coins
        w("## 6. Practical numbers for planning\n")
        if T:
            r = T["reachability"]
            w(f"* Hero-reachable ground: **{fmt(r['reachableAreaM2'], 0)} m²** (unbuilt world) of {fmt(T['stats']['navSurfaceM2'], 0)} m² navmesh; {T['stats']['obstacles']} blocking colliders "
              f"({T['stats']['byCategory']}), {len(T.get('gates', []))} auto-opening gates.\n")
            sps = [sv for sv in r.get("spawnLineVertices", []) if sv.get("heroPathFromCastleM")]
            if sps:
                w(f"* The hero can walk from the castle to the nearest spawn-line vertex in {fmt(min(v['heroPathFromCastleM'] for v in sps), 0)}–{fmt(max(v['heroPathFromCastleM'] for v in sps), 0)} m "
                  f"({fmt(min(v['heroPathFromCastleM'] for v in sps) / (L['heroes'][0]['movement'].get('speedDuringDay', 18.2) if L['heroes'] else 18.2), 1)} s at day speed).\n")
            standing = [sl for sl in T["slots"] if sl["standPoints"]]
            far = [q for sl in standing for q in sl["standPoints"][:1] if q.get("pathFromCastleM")]
            w(f"* {len(standing)}/{len(T['slots'])} build slots have at least one collision-free stand point within interaction range (`terrain/{self.idx:02d}_{self.safe}.json → slots[].standPoints`); "
              f"median walking distance castle→stand point {fmt(float(np.median([q['pathFromCastleM'] for q in far])), 0) if far else '–'} m.\n")
            disconnected = [sl for sl in T["slots"] if sl.get("connectedToCastleInModel") is False]
            if disconnected:
                w(f"* **Limitation:** {len(disconnected)} slots are not connected to the castle in the terrain model (multi-storey geometry); their stand points are locally valid only.\n")
        shr = L["shrines"]
        if shr:
            w(f"* {len(shr)} shrines, each needs **{fmt(shr[0].get('maxXp'), 0)} XP**, collection range {fmt(shr[0].get('collectionRange'), 0)} m, pays {shr[0].get('incomeOnceUnlocked')} gold/dawn once unlocked "
              f"(XP comes from unit deaths inside the range).\n")
        # anti-air capability of defenders
        aa = []
        for b in ("Defense Tower", "Barracks", "Archery Range"):
            if b in by_type:
                for lv in by_type[b][0]["levels"]:
                    for br in lv["branches"]:
                        for a in br["activates"]:
                            ats = list(a.get("attacks", []) or [])
                            for c in a.get("children", []) or []:
                                ats += list(c.get("attacks", []) or [])
                            if a.get("produces"):
                                for u in a["produces"]["unitTypes"]:
                                    ats += list(u["sample"].get("attacks", []) or [])
        w("\n## 7. Method notes and limits\n")
        w("* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); "
          "navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.\n"
          "* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). "
          "It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).\n"
          "* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.\n")
        return "\n".join(out)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenes", default=".*")
    a = ap.parse_args()
    os.makedirs(DOCS, exist_ok=True)
    infos = {x["sceneName"]: x for x in jl(os.path.join(DATA, "level_infos.json"))}
    eq = {}
    index_rows = []
    rx = re.compile(a.scenes)
    for p in sorted(glob.glob(os.path.join(DATA, "levels", "*.json"))):
        lv = Level(p, os.path.join(DATA, "terrain"), os.path.join(DATA, "navmesh"))
        if not rx.search(lv.name):
            continue
        s = lv.L["summary"]
        index_rows.append([lv.idx, lv.name, lv.L["kind"], s["nights"], s["enemiesTotal"], f"{s['baseHpTotal']:.0f}", s["flyingEnemies"], s["spawnLines"], s["buildSlots"],
                           (infos.get(lv.name) or {}).get("requiresBeatenLevel") or "–", f"[{'page' if lv.idx in CAMPAIGN else 'data'}]({'%02d_%s.md' % (lv.idx, lv.safe) if lv.idx in CAMPAIGN else '#'})" if lv.idx in CAMPAIGN else ""])
        lv.figure()
        if lv.idx in CAMPAIGN:
            with open(os.path.join(DOCS, f"{lv.idx:02d}_{lv.safe}.md"), "w", encoding="utf-8") as fh:
                fh.write(lv.page(infos, eq))
            print("wrote", lv.name)
    with open(os.path.join(DOCS, "README.md"), "w", encoding="utf-8") as fh:
        fh.write("# Level handbook — index\n\nAll 37 gameplay scenes of the installed build. Campaign maps have full pages; mini-mode scenes share their map with a campaign level and differ in waves, "
                 "slots and loadout rules (see `reference/data/levels/*.json`).\n\n")
        fh.write(md_table(["Build idx", "Scene", "Kind", "Nights", "Enemies", "Base HP", "Flying", "Spawn lines", "Slots", "Requires", "Page"], index_rows, align=["r", "l", "l", "r", "r", "r", "r", "r", "r", "l", "l"]))
        fh.write("\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
