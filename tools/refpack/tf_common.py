"""tf_common — shared decoding helpers for the Thronefall extractors (enums, localization, prefab/weapon summaries)."""
from __future__ import annotations

import json
import os
from typing import Any

import tf_assets as A

R = lambda x, n=3: round(float(x), n)  # noqa: E731


def vec3(t) -> list[float]:
    return [R(t[0]), R(t[1]), R(t[2])]


def brief(s: dict) -> dict:
    """Compact form of a summary(): the fields a planner needs, recursive over children."""
    b: dict[str, Any] = {"name": s["name"]}
    if s.get("displayName"):
        b["displayName"] = s["displayName"]
    if s.get("description"):
        b["description"] = s["description"]
    for k in ("maxHp", "tags", "coinDrop"):
        if k in s:
            b[k] = s[k]
    if "move" in s:
        b["speed"] = s["move"]["speed"]
    if "attacks" in s:
        b["attacks"] = [{"component": a["component"], "range": a.get("range"), "cooldown": a.get("cooldown"), "baseDamage": a.get("baseDamage"), "dps": a.get("dps"),
                         "weapon": (a.get("weapon") or {}).get("name"), "manual": a.get("manual", False)} for a in s["attacks"]]
    if "produces" in s:
        b["produces"] = s["produces"]
    other = [c for c in s["components"] if c not in ("Transform", "RectTransform")]
    b["components"] = other
    if "children" in s:
        b["children"] = [brief(c) for c in s["children"]]
    return b


class Enums:
    """Enum name tables + field→enum-type lookup, built from TfMap's types.jsonl (the ground truth for names)."""

    def __init__(self, maps_dir: str):
        self.enums: dict[str, dict[int, str]] = {}
        self.field_type: dict[tuple[str, str], str] = {}
        path = os.path.join(maps_dir, "code", "Assembly-CSharp.types.jsonl")
        with open(path, encoding="utf-8") as f:
            for line in f:
                d = json.loads(line)
                if d.get("vendor"):
                    continue
                if d["kind"] == "enum":
                    self.enums[d["full"]] = {int(v["v"]): v["n"] for v in d.get("values", []) if v.get("v") is not None}
                for fld in d.get("fields", []):
                    self.field_type[(d["full"], fld["n"])] = fld["t"]

    def name(self, enum_full: str, value: int) -> str:
        return self.enums.get(enum_full, {}).get(int(value), f"#{value}")

    def field_enum(self, cls: str, field: str) -> str | None:
        t = self.field_type.get((cls, field))
        if t is None:
            return None
        t = t.replace(".", "/") if t not in self.enums else t
        for cand in (t, t.replace("/", ".")):
            if cand in self.enums:
                return cand
        # nested enum shown as Outer.Inner
        for k in self.enums:
            if k.replace("/", ".") == t.replace("/", "."):
                return k
        return None

    def decode_fields(self, cls: str, v: dict[str, Any]) -> dict[str, Any]:
        out = {}
        for k, x in v.items():
            e = self.field_enum(cls, k) if isinstance(x, int) and not isinstance(x, bool) else None
            out[k] = x
            if e:
                out[k + "_name"] = self.name(e, x)
        return out

    def tags(self, values: list[int]) -> list[str]:
        return [self.name("TagManager/ETag", t) for t in values]


class Loc:
    """I2 Localization: term → English text."""

    def __init__(self, g: A.Game):
        self.terms: dict[str, str] = {}
        r = g.file("resources.assets")
        ids = r.class_index().get("LanguageSourceAsset", [])
        if not ids:
            return
        m = r.mb(ids[0])
        src = m.v.get("mSource", {})
        langs = src.get("mLanguages", [])
        en = 0
        for i, l in enumerate(langs):
            if str(l.get("Name", "")).lower().startswith("english"):
                en = i
                break
        self.langs = [l.get("Name") for l in langs]
        for t in src.get("mTerms", []):
            arr = t.get("Languages", [])
            if arr:
                self.terms[t.get("Term", "")] = arr[en] if en < len(arr) else arr[0]

    def t(self, key: str) -> str:
        return self.terms.get(key, "")

    def find(self, prefix: str) -> dict[str, str]:
        return {k: v for k, v in self.terms.items() if k.startswith(prefix)}


class Summaries:
    """Cached, human-usable summaries of prefabs / scene objects / weapons."""

    def __init__(self, g: A.Game, enums: Enums, loc: Loc):
        self.g, self.en, self.loc = g, enums, loc
        self._prefab: dict[tuple[str, int], dict] = {}
        self._weapon: dict[tuple[str, int], dict] = {}

    # ---- helpers
    def tp(self, prios: list[dict]) -> list[dict]:
        return [{"must": self.en.tags(p["mustHaveTags"]), "not": self.en.tags(p["mayNotHaveTags"]),
                 "range": R(p["range"]), "minRange": R(p["minRange"])} for p in prios]

    def weapon(self, ref) -> dict | None:
        if not ref:
            return None
        if ref in self._weapon:
            return self._weapon[ref]
        m = self.g.deref_mb(ref)
        if m is None:
            return None
        v = m.v
        d = {
            "name": m.name,
            "blacksmith": self.en.name("EDamageAffectedByBlacksmithUpgrade", v["blacksmithEffect"]) if "blacksmithEffect" in v else None,
            "direct": [{"requiredTags": self.en.tags(x["requiredTags"]), "add": R(x["damageAdded"]), "mult": R(x["damageMultiplyer"])} for x in v.get("directDamage", [])],
            "splash": [{"requiredTags": self.en.tags(x["requiredTags"]), "add": R(x["damageAdded"]), "mult": R(x["damageMultiplyer"])} for x in v.get("splashDamage", [])],
            "projectileSpeed": R(v.get("projectileSpeed", 0)),
            "parabola": R(v.get("projectileParabulaFactor", 0)),
            "maxChaseRange": R(v.get("maximumChaseRange", 0)),
            "shootWithoutTargetRange": R(v.get("shootWithoutTargetRange", 0)),
            "slowsFastEnemiesFor": R(v.get("slowsFastEnemiesFor", 0)),
            "isPlayerWeapon": bool(v.get("isPlayerWeapon", False)),
            "extraEffects": len(v.get("additionalWeaponEffects", [])),
        }
        # Damage tables are per victim tag (first row = PlayerOwned victims for enemy weapons). Splash is reported separately.
        base = d["direct"][0]["add"] if d["direct"] else 0.0
        splash = d["splash"][0]["add"] if d["splash"] else 0.0
        d["baseDamage"] = base if base else splash
        d["baseDamageIsSplash"] = bool(not base and splash)
        self._weapon[ref] = d
        return d

    def attack_component(self, cname: str, v: dict) -> dict | None:
        """AutoAttack-like components (units, towers, enemies)."""
        if "weapon" not in v or "cooldownDuration" not in v:
            return None
        return {"component": cname, "cooldown": R(v["cooldownDuration"]), "cooldownRandomization": R(v.get("cooldownRandomization", 0)),
                "recheckInterval": R(v.get("recheckTargetInterval", 0)), "targets": self.tp(v.get("targetPriorities", [])),
                "damageMult": R(v.get("damageMultiplyer", 1)), "projectileSpeedMult": R(v.get("projectileSpeedMultiplyer", 1)),
                "_weapon": v["weapon"]}

    def summary(self, file: str, pid: int, depth: int = 0) -> dict:
        """Summary of one GameObject (prefab in an asset file or an object in a scene)."""
        key = (file, pid)
        if key in self._prefab:
            return self._prefab[key]
        f = self.g.file(file)
        go = f.go(pid)
        comps = f.go_components(pid)
        d: dict[str, Any] = {"file": file, "pid": pid, "name": go["name"], "activeSelf": go["active"], "components": [c[1] for c in comps]}
        attacks = []
        for cpid, cname in comps:
            m = f.mb(cpid)
            if m is None:
                continue
            v = m.v
            if cname == "Hp":
                d["maxHp"] = R(v["maxHp"])
                d["knockedOut"] = bool(v["getsKnockedOutInsteadOfDying"])
                d["invulnerable"] = bool(v["invulnerable"])
                d["coinDrop"] = v["coinCount"]
            elif cname == "TaggedObject":
                d["tags"] = self.en.tags(v["tags"])
            elif cname in ("PathfindMovementEnemy", "PathfindMovementPlayerunit") or ("movementSpeed" in v and "targetPriorities" in v):
                d["move"] = {"component": cname, "speed": R(v["movementSpeed"]), "keepDistance": R(v.get("keepDistanceOf", 0)),
                             "maxDistanceFromHome": R(v.get("maximumDistanceFromHome", 0)), "speedWhenSlowed": R(v.get("speedWhenSlowed", 0)),
                             "graph": v.get("backupMovementGraph", ""), "targetPriorities": self.tp(v["targetPriorities"])}
            elif cname == "ScreenMarkerIcon":
                lk = v.get("locaKey", "")
                d["locaKey"] = lk
                # mirrors ScreenMarkerIcon.UnitName / UnitDescription (ScreenMarkerIcon.cs:11-31)
                has_name = bool(self.loc.t(lk + " Name"))
                d["displayName"] = self.loc.t(lk + " Name") if has_name else self.loc.t(lk)
                d["description"] = self.loc.t(lk) if has_name else self.loc.t(lk + " Description")
                d["isPlayerUnit"] = bool(v.get("isPlayerUnit", False))
            elif cname == "UnitTypeDisplay":
                pass
            elif cname == "UnitRespawnerForBuildings":
                units = [f.ref(u) for u in v.get("units", [])]
                seen: dict[str, dict] = {}
                for u in units:
                    if not u:
                        continue
                    ugo = self.g.file(u[0]).owner_go(u[1]) or u[1]  # units are List<Hp>: resolve the owning GameObject
                    us = self.summary(u[0], ugo, depth=3)
                    e = seen.setdefault(us["name"], {"count": 0, "sample": us})
                    e["count"] += 1
                d["produces"] = {"unitCount": len([u for u in units if u]), "respawnSecondsByLevel": [R(x) for x in v.get("timeToRespawnAUnitDependingOnLevel", [])],
                                 "unitTypes": [{"name": k, "count": e["count"], "sample": brief(e["sample"])} for k, e in seen.items()]}
            else:
                a = self.attack_component(cname, v)
                if a:
                    w = self.weapon(f.ref(a.pop("_weapon")))
                    a["weapon"] = w
                    if w:
                        a["baseDamage"] = w["baseDamage"]
                        a["dps"] = R(w["baseDamage"] * a["damageMult"] / a["cooldown"]) if a["cooldown"] > 0 else None
                        a["range"] = max((t["range"] for t in a["targets"] if t["range"] < 10000), default=0)
                    attacks.append(a)
                elif cname == "ManualAttack" or ("cooldownTime" in v and "weapon" in v):
                    w = self.weapon(f.ref(v["weapon"])) if "weapon" in v else None
                    attacks.append({"component": cname, "manual": True, "cooldown": R(v.get("cooldownTime", 0)), "autoAttack": bool(v.get("autoAttack", False)), "weapon": w})
        if attacks:
            d["attacks"] = attacks
        # descend into children for towers / composite objects (attacks, unit producers often live on children)
        if depth < 3:
            tfp = f.transform_of_go(pid)
            kids = []
            for c in f.tf(tfp).get("children", []) if tfp else []:
                cgo = f.tf(c).get("go")
                if cgo:
                    kids.append(cgo)
            sub = []
            for cgo in kids:
                s = self.summary(file, cgo, depth + 1)
                if any(k in s for k in ("attacks", "maxHp", "produces", "move")) or s.get("children"):
                    sub.append(s)
            if sub:
                d["children"] = sub
        self._prefab[key] = d
        return d
