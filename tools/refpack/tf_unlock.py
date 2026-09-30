"""tf_unlock — when does a build slot become available, and what caps its upgrades?

Rules read from BuildSlot.cs (decompiled, game 2.13):
  * A slot with startDeactivated activates when  activatorBuilding.Level > activatorLevel   (Activate(), BuildSlot.cs:685),
    i.e. when its activator is upgraded from level N to N+1 — its (N+1)-th upgrade purchase.
  * GetBuildSlotsThatWillUnlockWhenUpgraded() lists slots with  activatorLevel == level  (BuildSlot.cs:604-615) — same meaning.
  * CanBeUpgraded: beyond level 0 a slot may only be upgraded while  requiredRoot.Level > level + requiredRootLevelDifference
    (BuildSlot.cs:283-292); requiredRoot is the top of the activator chain (BuildSlot.Start, BuildSlot.cs:641-651).
  * activatorUpgradesThis: the slot mirrors its activator's Level and Upgrades (a follower, e.g. wall segments; BuildSlot.cs:184-211).
"""
from __future__ import annotations


def unlock_info(slots: list[dict]) -> dict[int, dict]:
    """slots = level JSON `buildSlots`. Returns id -> {rootId, upgradeNumber, costGold, chain}."""
    by_id = {s["id"]: s for s in slots}
    memo: dict[int, int] = {}

    def root_of(s: dict) -> int:
        cur, seen = s, set()
        while cur["activator"] and cur["activator"]["slot"] in by_id and cur["id"] not in seen:
            seen.add(cur["id"])
            cur = by_id[cur["activator"]["slot"]]
        return cur["id"]

    def cost(s: dict, depth: int = 0) -> int:
        """Gold of activator upgrades that must be bought before the slot appears (recursive); -1 = unknown."""
        if s["id"] in memo:
            return memo[s["id"]]
        if depth > 12:
            return -1
        if not s["startDeactivated"] or not s["activator"]:
            v = 0
        else:
            a = by_id.get(s["activator"]["slot"])
            if a is None:
                v = -1
            else:
                n = s["activator"]["level"] + 1
                base = cost(a, depth + 1)
                v = -1 if base < 0 else base + sum(l["cost"] for l in a["levels"][:n])
        memo[s["id"]] = v
        return v

    out = {}
    for s in slots:
        act = s["activator"]
        out[s["id"]] = {"rootId": root_of(s), "upgradeNumber": (act["level"] + 1) if act and s["startDeactivated"] else 0, "costGold": cost(s),
                        "activatorId": act["slot"] if act else 0}
    return out


def describe(s: dict, info: dict) -> str:
    """Human wording used by the handbook: 'Castle Center, after its upgrade #3'."""
    act = s["activator"]
    if not act or not s["startDeactivated"]:
        return "available from the start"
    n = act["level"] + 1
    txt = f"{act['building']}, after its upgrade #{n}"
    if act.get("upgradesThis"):
        txt += " (shares its upgrades)"
    return txt
