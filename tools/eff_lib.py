"""Shared efficiency analytics over agent/tasks.jsonl (written by src/Tasks.cs).

Every record carries `ts` (wall-clock epoch s) and `build` (DLL mtime epoch),
so results can be bucketed by time window and by bot version.
"""
import json, os, time
from collections import defaultdict
from pathlib import Path

AGENT = Path(os.environ.get("TF_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"))

# Measured by tools/efficiency-report.py over 196 runs / 36 h (see EFFICIENCY.md).
BASELINE = {"useful_pct": 75.2, "productive_pct": 65.2, "active_pct": 7.3}
TARGET = {"active_pct": 50.0, "useful_pct": 85.0, "build_eff": 60.0, "eff_score": 80.0}


def load(agent=AGENT):
    out = []
    for name in ("tasks.jsonl.old", "tasks.jsonl"):
        p = Path(agent) / name
        if not p.exists():
            continue
        for ln in p.read_text(encoding="utf-8", errors="replace").splitlines():
            if ln.startswith("{"):
                try:
                    out.append(json.loads(ln))
                except ValueError:
                    pass
    return out


def summarize(recs):
    """Aggregate a list of records into the KPI dict used by report + dashboard."""
    use = waste = 0.0
    kinds = defaultdict(lambda: {"n": 0, "ok": 0, "fail": 0, "dur": 0.0, "eff": 0.0, "neff": 0,
                                 "gold": 0, "walk": 0, "use": 0.0, "waste": 0.0})
    days = []
    misses = 0
    fx = []
    for r in recs:
        k = r.get("kind", "")
        if k == "day":
            days.append(r)
        elif k == "task-miss":
            misses += 1
        elif k == "coach-fx":
            fx.append(r)
        elif k != "night" and "dur" in r:
            a = kinds[k]
            a["n"] += 1
            a["dur"] += r["dur"]
            a["gold"] += r.get("gold", 0)
            a["walk"] += r.get("walk", 0)
            a["use"] += r.get("use_s", 0)
            a["waste"] += r.get("waste_s", 0)
            use += r.get("use_s", 0)
            waste += r.get("waste_s", 0)
            if r.get("out") == "ok":
                a["ok"] += 1
            elif r.get("out") == "fail":
                a["fail"] += 1
            if r.get("eff", -1) >= 0:
                a["eff"] += r["eff"]
                a["neff"] += 1
    builds = [(k, v) for k, v in kinds.items() if k.startswith("build:")]
    bn = sum(v["n"] for _, v in builds)
    bok = sum(v["ok"] for _, v in builds)
    beff = sum(v["eff"] for _, v in builds)
    bne = sum(v["neff"] for _, v in builds)
    secs = sum(v["dur"] for v in kinds.values())
    out = {
        "tasks": sum(v["n"] for v in kinds.values()),
        "useful_pct": round(100 * use / (use + waste), 1) if use + waste > 1 else None,
        "build_n": bn,
        "build_ok_pct": round(100 * bok / bn, 1) if bn else None,
        "build_eff": round(beff / bne, 1) if bne else None,
        "gold_per_min": round(sum(v["gold"] for v in kinds.values()) / (secs / 60), 1) if secs > 60 else None,
        "task_misses": misses,
        "days": len(days),
        "day_active_pct": round(sum(d.get("active_pct", 0) * d.get("dur", 0) for d in days) / max(1, sum(d.get("dur", 0) for d in days)), 1) if days else None,
        "day_useful_pct": round(sum(d.get("useful_pct", 0) for d in days if d.get("useful_pct", -1) >= 0) /
                                max(1, sum(1 for d in days if d.get("useful_pct", -1) >= 0)), 1) if days else None,
        "day_avg_eff": round(sum(d.get("avg_eff", 0) for d in days) / len(days), 1) if days else None,
        "builds_per_day": round(sum(d.get("builds", 0) for d in days) / len(days), 2) if days else None,
        "ally_gain_per_day": round(sum(d.get("ally_delta", 0) for d in days) / len(days), 2) if days else None,
        "maxed_gain_per_day": round(sum(d.get("maxed_delta", 0) for d in days) / len(days), 2) if days else None,
        "coach_fx_n": len(fx),
        "coach_fx_avg_delta": round(sum(f["eff_after"] - f["eff_before"] for f in fx) / len(fx), 1) if fx else None,
        "coach_latency_ms": round(sum(f.get("latency_ms", 0) for f in fx) / len(fx)) if fx else None,
        "worst": sorted(((k, round(v["waste"])) for k, v in kinds.items()), key=lambda x: -x[1])[:5],
        "by_kind": {k: {"n": v["n"], "ok": v["ok"], "fail": v["fail"],
                        "eff": round(v["eff"] / v["neff"]) if v["neff"] else None,
                        "avg_s": round(v["dur"] / v["n"], 1), "waste_s": round(v["waste"])}
                    for k, v in sorted(kinds.items(), key=lambda kv: -kv[1]["waste"])[:20]},
    }
    return out


def compare(recs=None, now=None):
    """Windows (last 1h / 16h / 48h / all) and per-build-version buckets."""
    recs = load() if recs is None else recs
    now = now or time.time()
    wins = {}
    for label, secs in (("last_1h", 3600), ("last_16h", 16 * 3600), ("last_48h", 48 * 3600), ("all", None)):
        sel = [r for r in recs if secs is None or r.get("ts", 0) >= now - secs]
        wins[label] = summarize(sel)
    by_build = defaultdict(list)
    for r in recs:
        by_build[r.get("build", 0)].append(r)
    builds = []
    for b in sorted(by_build)[-5:]:
        s = summarize(by_build[b])
        s["build"] = b
        s["since"] = min(r.get("ts", 0) for r in by_build[b])
        builds.append(s)
    days = [r for r in recs if r.get("kind") == "day"]
    best = {"builds": max((d.get("builds", 0) for d in days), default=None),
            "gold_spent": max((d.get("gold_spent", 0) for d in days), default=None),
            "useful_pct": max((d.get("useful_pct", 0) for d in days), default=None),
            "note": "empirical best single day so far; a gold-based ceiling is not computable (botpack has no slot costs)"}
    return {"windows": wins, "builds": builds, "baseline": BASELINE, "target": TARGET, "records": len(recs), "best_day": best}


PROG = ("pay", "build-done", "gate-", "squad-", "army-", "door-park", "horn-interact", "switch-night", "choice-pick")
WORK = ("SpendGold", "CollectCoin", "PositionArmy", "ReturnHome", "Engage")


def backtest_run(run_dir):
    """Apply the live Tasks.cs tick classifier (useful/wasted/neutral) to a recorded run,
    so old and new runs are compared with the SAME rule. Returns (useful_s, wasted_s) or None."""
    import math
    run_dir = Path(run_dir)
    tk = []
    for ln in (run_dir / "ticks.jsonl").read_text(encoding="utf-8", errors="replace").splitlines():
        if ln.startswith("{"):
            try:
                t = json.loads(ln)
            except ValueError:
                continue
            if t.get("state") == "InMatch" and t.get("pos") and "t" in t:
                tk.append(t)
    if len(tk) < 20:
        return None
    ev = []
    for ln in (run_dir / "events.jsonl").read_text(encoding="utf-8", errors="replace").splitlines():
        if ln.startswith("{"):
            try:
                e = json.loads(ln)
            except ValueError:
                continue
            if str(e.get("note", "")).startswith(PROG) and "t" in e:
                ev.append(e["t"])
    off = tk[0]["t"] if tk[0]["t"] > 60 else 0.0
    ev = sorted(x + off for x in ev)
    use = waste = 0.0
    j = 0
    prev = None
    for t in tk:
        if prev is not None:
            dt = min(t["t"] - prev["t"], 1.0)
            if dt > 0:
                while j < len(ev) and ev[j] < t["t"] - 3.0:
                    j += 1
                recent = j < len(ev) and ev[j] <= t["t"]
                speed = math.dist(t["pos"], prev["pos"]) / dt
                mode = t.get("mode", "")
                if mode in ("HeroDead", "ResolveUI", "EnterLevel", "StartNight"):
                    c = 0
                elif t.get("night"):
                    c = 1 if (t.get("nf", 0) or t.get("foes", 0)) else 0
                elif recent:
                    c = 1
                elif mode == "Idle":
                    c = -1
                elif speed > 1 and mode in WORK:
                    c = 1
                elif (t.get("gold", 0) or 0) >= 15 and (t.get("bld", 0) or 0) > 0:
                    c = -1
                else:
                    c = 1 if speed > 0.3 else 0
                if c > 0:
                    use += dt
                elif c < 0:
                    waste += dt
        prev = t
    return use, waste


def backtest(runs_dir=None, cutoff_ts=None, last=40):
    """Mean useful % of the most recent `last` runs before vs after `cutoff_ts` (run dir mtime)."""
    runs_dir = Path(runs_dir or (Path(AGENT) / "runs"))
    items = []
    for d in runs_dir.iterdir():
        if d.is_dir() and "Level" not in d.name and not d.name.endswith("_UI"):
            items.append((d.stat().st_mtime, d))
    items.sort()
    def agg(sel):
        u = w = 0.0
        n = 0
        for _, d in sel:
            try:
                r = backtest_run(d)
            except Exception:
                r = None
            if r and r[0] + r[1] > 60:
                u += r[0]; w += r[1]; n += 1
        return {"runs": n, "useful_pct": round(100 * u / (u + w), 1) if u + w else None, "hours": round((u + w) / 3600, 2)}
    before = [x for x in items if cutoff_ts and x[0] < cutoff_ts][-last:]
    after = [x for x in items if cutoff_ts and x[0] >= cutoff_ts]
    return {"before": agg(before), "after": agg(after)}


def gap(summary):
    """Gap-to-target list, biggest first (percentage points / absolute)."""
    g = []
    if summary.get("useful_pct") is not None:
        g.append(("useful_pct", TARGET["useful_pct"] - summary["useful_pct"]))
    if summary.get("build_eff") is not None:
        g.append(("build_eff", TARGET["build_eff"] - summary["build_eff"]))
    return sorted(g, key=lambda x: -x[1])

