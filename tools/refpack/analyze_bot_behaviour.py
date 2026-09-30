"""analyze_bot_behaviour — what the recorded bot runs actually did, measured against the extracted game data.

Input : BepInEx/plugins/bot-log.jsonl  (one JSON row per bot tick, ~4 Hz, written by the Trainer's Bot.cs; `t` = real seconds since launch)
Output: reference/verification/bot_behaviour.json  (machine-readable)
        reference/docs/generated/bot_behaviour.md   (tables the autonomy guide quotes)

Everything here is *measured from the log*; the game data only supplies the castle position of each scene and the shipped revive time.
A "session" is one game launch (the log's `t` restarts from ~0 and the first scene is `_Boot`).

usage: python analyze_bot_behaviour.py [--log PATH]
"""
from __future__ import annotations

import argparse
import collections
import json
import math
import os
import statistics

REF = r"K:\Downloads-IDM\Thronefall\Trainer\reference"
LOG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl"
FAR_M = (30.0, 50.0)           # "far from the castle" thresholds used in the tables
STUCK_NOTES = ("stuck", "snap", "unstick", "teleport-nudge")


def load_castles() -> dict[str, tuple[float, float]]:
    out = {}
    tdir = os.path.join(REF, "data", "terrain")
    for fn in sorted(os.listdir(tdir)):
        if not fn.endswith(".json"):
            continue
        t = json.load(open(os.path.join(tdir, fn), encoding="utf-8"))
        c = t["features"].get("castle")
        if not c:
            continue
        if isinstance(c, (list, tuple)) and c and isinstance(c[0], (list, tuple)):
            c = c[0]
        if isinstance(c, dict):
            c = c.get("pos") or c.get("position")
        if c and len(c) >= 3:
            out[t["scene"]] = (float(c[0]), float(c[2]))
    return out


def load_econ() -> dict[str, dict]:
    """scene -> {start: starting gold, coins: {night(1-based): goldCoins dropped that night}} from the extracted level data."""
    out = {}
    ddir = os.path.join(REF, "data", "levels")
    for fn in sorted(os.listdir(ddir)):
        if not fn.endswith(".json"):
            continue
        L = json.load(open(os.path.join(ddir, fn), encoding="utf-8"))
        sp = (L.get("spawners") or [None])[0]
        if not sp:
            continue
        coins = collections.Counter()
        for wv in sp.get("waves", []):
            coins[int(wv["night"])] += sum(int(x.get("goldCoins", 0)) for x in wv["spawns"])
        out[L["scene"]] = {"start": int(sp.get("goldBalanceAtStart", 0)), "coins": dict(coins)}
    return out


def load_sessions(path: str) -> list[list[dict]]:
    rows = []
    with open(path, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            try:
                d = json.loads(line)
            except ValueError:
                continue
            if "mode" in d:
                rows.append(d)
    sess, cur, prev = [], [], -1.0
    for r in rows:
        if r["t"] < prev - 1.0 and cur:
            sess.append(cur)
            cur = []
        cur.append(r)
        prev = r["t"]
    if cur:
        sess.append(cur)
    return sess


def pct(vals: list[float], p: float) -> float:
    if not vals:
        return float("nan")
    v = sorted(vals)
    k = min(len(v) - 1, max(0, int(round(p / 100 * (len(v) - 1)))))
    return v[k]


def analyse_session(idx: int, rows: list[dict], castles: dict[str, tuple[float, float]], econ: dict[str, dict]) -> dict | None:
    match = [r for r in rows if r["state"] == "InMatch" and r["scene"] in castles and r.get("pos")]
    if len(match) < 40:
        return None
    dts = [b["t"] - a["t"] for a, b in zip(match, match[1:]) if 0 < b["t"] - a["t"] < 2.0]
    dt = statistics.median(dts) if dts else 0.25
    scenes = collections.Counter(r["scene"] for r in match)
    scene = scenes.most_common(1)[0][0]
    cx, cz = castles[scene]

    def dist(r):
        return math.hypot(r["pos"][0] - castles[r["scene"]][0], r["pos"][1] - castles[r["scene"]][1])

    night = [r for r in match if r["night"]]
    day = [r for r in match if not r["night"]]
    modes_night = collections.Counter(r["mode"] for r in night)
    modes_day = collections.Counter(r["mode"] for r in day)
    dn = [dist(r) for r in night if r["hp"] > 0]
    # knock-out episodes: alive -> hp<=0 -> alive
    ko, cur = [], None
    prev = None
    for r in match:
        alive = r["hp"] > 0
        if prev is not None and prev["hp"] > 0 and not alive and cur is None:
            cur = {"t0": r["t"], "night": r["night"], "wave": r["wave"], "scene": r["scene"], "dist": dist(prev), "foes": prev["foes"], "nf": prev.get("nf", -1), "pos": prev["pos"]}
        if cur is not None and alive:
            cur["dur"] = r["t"] - cur["t0"]
            ko.append(cur)
            cur = None
        prev = r
    ko_night = [k for k in ko if k["night"]]
    ko_day = [k for k in ko if not k["night"]]
    notes = collections.Counter()
    for r in rows:
        n = r.get("note", "")
        for s in STUCK_NOTES:
            if n.startswith(s):
                notes[s] += 1
    waves = collections.defaultdict(int)
    for r in match:
        try:
            w = int(str(r["wave"]).split("/")[0])
            waves[r["scene"]] = max(waves[r["scene"]], w)
        except ValueError:
            pass
    total = collections.Counter(r["state"] for r in rows)
    # economy behaviour: gold held when the night starts, gold actually spent by day (drops that are not refunded within 3 s), delay before the first night
    dusk, spent, first_night = [], 0, None
    for a, b in zip(match, match[1:]):
        if not a["night"] and b["night"]:
            try:
                wv = int(str(b["wave"]).split("/")[0])
            except ValueError:
                wv = -1
            e = econ.get(b["scene"])
            pred = (e["start"] + sum(v for k, v in e["coins"].items() if k <= wv)) if e and wv >= 0 else None
            held = b["gold"] + b["coins"]
            dusk.append({"wave": b["wave"], "gold": b["gold"], "coinsOnMap": b["coins"], "predictedNoSpend": pred, "impliedSpent": (pred - held) if pred is not None else None})
            if first_night is None:
                first_night = round(b["t"] - match[0]["t"], 1)
    j = 0
    for i, a in enumerate(match[:-1]):
        b = match[i + 1]
        if a["night"] or b["night"] or b["gold"] >= a["gold"]:
            continue
        drop = a["gold"] - b["gold"]
        while j < len(match) - 1 and match[j]["t"] < a["t"]:
            j += 1
        later = [m["gold"] for m in match[i + 1:i + 16] if m["t"] - b["t"] <= 3.0 and not m["night"]]
        if not later or max(later) < a["gold"] - drop + 1:      # not refunded
            spent += drop
    ally_n = [r.get("ally", 0) for r in night if "ally" in r]
    return {
        "session": idx, "scene": scene, "scenes": dict(scenes), "matchSeconds": round(len(match) * dt), "tickSeconds": round(dt, 3),
        "nightShare": round(len(night) / len(match), 3),
        "nightModes": {k: round(v / max(1, len(night)), 3) for k, v in modes_night.most_common()},
        "dayModes": {k: round(v / max(1, len(day)), 3) for k, v in modes_day.most_common()},
        "nightDistCastle": {"p50": round(pct(dn, 50), 1), "p90": round(pct(dn, 90), 1), "max": round(max(dn), 1) if dn else None,
                            f"shareOver{int(FAR_M[0])}": round(sum(d > FAR_M[0] for d in dn) / max(1, len(dn)), 3),
                            f"shareOver{int(FAR_M[1])}": round(sum(d > FAR_M[1] for d in dn) / max(1, len(dn)), 3)},
        "knockouts": {"night": len(ko_night), "day": len(ko_day), "durationsNightS": [round(k["dur"], 1) for k in ko_night][:60],
                      "distCastleAtKO": [round(k["dist"]) for k in ko_night][:60], "nearFoesBeforeKO": [k["nf"] for k in ko_night if k["nf"] >= 0][:60]},
        "stuckNotes": dict(notes), "maxWaveReached": dict(waves), "states": dict(total),
        "victoryTicks": total.get("AfterMatchVictory", 0), "defeatTicks": total.get("AfterMatchDefeat", 0),
        "economy": {"goldAtDusk": dusk[:40], "medianGoldAtDusk": (statistics.median([d["gold"] for d in dusk]) if dusk else None), "inferredGoldSpentByDay": spent, "secondsToFirstNight": first_night,
                    "impliedSpentAtLastDusk": (dusk[-1]["impliedSpent"] if dusk else None), "impliedSpentMax": max((d["impliedSpent"] for d in dusk if d["impliedSpent"] is not None), default=None)},
        "allies": ({"nightTicksWithAllies": sum(1 for v in ally_n if v > 0), "nightTicks": len(ally_n), "maxAllies": max(ally_n, default=0)} if ally_n else None),
    }


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--log", default=LOG)
    a = ap.parse_args()
    castles = load_castles()
    sessions = load_sessions(a.log)
    econ = load_econ()
    rep = [r for i, s in enumerate(sessions) if (r := analyse_session(i, s, castles, econ))]
    # aggregate KO durations (night) — expected to cluster at the shipped AutoRevive.reviveAfterBeingKnockedOutFor
    dur = [d for r in rep for d in r["knockouts"]["durationsNightS"]]
    agg = {
        "sessionsTotal": len(sessions), "sessionsAnalysed": len(rep), "logRows": sum(len(s) for s in sessions),
        "matchHours": round(sum(r["matchSeconds"] for r in rep) / 3600, 2),
        "knockoutsNight": sum(r["knockouts"]["night"] for r in rep), "knockoutsDay": sum(r["knockouts"]["day"] for r in rep),
        "koNightDurationS": {"n": len(dur), "p10": pct(dur, 10), "p50": pct(dur, 50), "p90": pct(dur, 90)} if dur else None,
        "shippedReviveAfterKnockedOutS": 11.0,
    }
    out = {"log": a.log, "aggregate": agg, "sessions": rep}
    os.makedirs(os.path.join(REF, "verification"), exist_ok=True)
    json.dump(out, open(os.path.join(REF, "verification", "bot_behaviour.json"), "w", encoding="utf-8"), indent=1)
    # ---- markdown fragment
    gen = os.path.join(REF, "docs", "generated")
    os.makedirs(gen, exist_ok=True)
    L = ["<!-- generated by tools/refpack/analyze_bot_behaviour.py — do not edit by hand -->", "",
         f"Log snapshot: {agg['logRows']:,} rows, {agg['sessionsTotal']} game launches, {agg['sessionsAnalysed']} with ≥ 40 in-match ticks, {agg['matchHours']} h in match.", ""]
    if agg["koNightDurationS"]:
        k = agg["koNightDurationS"]
        L.append(f"Night knock-outs: **{agg['knockoutsNight']}** (day: {agg['knockoutsDay']}). Duration of a night knock-out, seconds: p10 {k['p10']:.1f} · median {k['p50']:.1f} · p90 {k['p90']:.1f} "
                 f"(shipped `AutoRevive.reviveAfterBeingKnockedOutFor` = {agg['shippedReviveAfterKnockedOutS']:.0f} s).")
        L.append("")
    L += ["| session | scene | match min | night % | night modes (share of night ticks) | median / p90 dist. to castle at night | night share > 30 m / > 50 m | KOs night / day | stuck · snap · unstick | gold at dusk (median) · implied total spent by last dusk | first night after (s) | max night reached |",
          "|---:|---|---:|---:|---|---|---|---|---|---|---:|---|"]
    for r in rep:
        nm = ", ".join(f"{k} {int(100 * v)}%" for k, v in list(r["nightModes"].items())[:4])
        d = r["nightDistCastle"]
        sn = r["stuckNotes"]
        L.append(f"| {r['session']} | {r['scene']} | {r['matchSeconds'] / 60:.1f} | {100 * r['nightShare']:.0f} | {nm} | {d['p50']} / {d['p90']} m | "
                 f"{100 * d['shareOver30']:.0f}% / {100 * d['shareOver50']:.0f}% | {r['knockouts']['night']} / {r['knockouts']['day']} | {sn.get('stuck', 0)} · {sn.get('snap', 0)} · {sn.get('unstick', 0)} | "
                 f"{r['economy']['medianGoldAtDusk']} · {r['economy']['impliedSpentAtLastDusk']} | {r['economy']['secondsToFirstNight']} | "
                 f"{', '.join(f'{k} {v}' for k, v in r['maxWaveReached'].items())} |")
    open(os.path.join(gen, "bot_behaviour.md"), "w", encoding="utf-8").write("\n".join(L) + "\n")
    print(json.dumps(agg, indent=1))
    print(f"wrote verification/bot_behaviour.json and docs/generated/bot_behaviour.md ({len(rep)} sessions)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
