#!/usr/bin/env python3
"""Efficiency report: how much of the bot's playtime was productive vs wasted.

Reads every agent/runs/*/{ticks,events}.jsonl and scores 10 s windows.

  PRODUCTIVE window = any of: pay / build-done / build-hold / gate-* / squad-* /
                      army-* event in the window, OR night with foes engaged.
  WASTE window      = DAY window with none of those (hero walking/idle while
                      gold sat unspent or nothing was done).
  Also reported: time-to-first-build, gold-idle (gold>500 unspent seconds),
  pacing ratio (path length / net displacement), per-mode time share.

Usage: python efficiency-report.py [--runs DIR] [--last N] [--json OUT]
"""
import argparse, json, math, os, sys
from collections import Counter, defaultdict

WIN = 10.0
PRODUCTIVE = ("pay", "build-done", "build-hold", "gate-", "squad-", "army-", "door-park",
              "horn-interact", "switch-night", "choice-pick", "match-end")


def rd(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            for line in f:
                line = line.strip()
                if line.startswith("{"):
                    try:
                        yield json.loads(line)
                    except ValueError:
                        pass
    except OSError:
        return


def analyze(run_dir):
    ticks = [t for t in rd(os.path.join(run_dir, "ticks.jsonl")) if t.get("state") == "InMatch" and "t" in t]
    if len(ticks) < 20:
        return None
    events = list(rd(os.path.join(run_dir, "events.jsonl")))
    # ticks use absolute game time, events are relative to run start
    off = ticks[0]["t"] if ticks[0]["t"] > 60 else 0.0
    prod_t = [e["t"] + off for e in events if "t" in e and str(e.get("note", "")).startswith(PRODUCTIVE)]
    prod_t.sort()
    dur = ticks[-1]["t"] - ticks[0]["t"]
    if dur < 120:
        return None

    modes, day_s, night_s = Counter(), 0.0, 0.0
    waste_s = prod_s = 0.0
    gold_idle_s = 0.0
    path = 0.0
    prev = None
    first_build = None
    wins = defaultdict(lambda: {"day": 0, "foes": 0, "n": 0, "sec": 0.0, "dsec": 0.0})
    pv = None
    for tk in ticks:
        w = int(tk["t"] // WIN)
        wins[w]["n"] += 1
        wins[w]["day"] += 0 if tk.get("night") else 1
        if pv is not None:
            dt = min(tk["t"] - pv["t"], 2.0)
            wins[w]["sec"] += dt
            if not tk.get("night"):
                wins[w]["dsec"] += dt
        pv = tk
        wins[w]["foes"] = max(wins[w]["foes"], tk.get("nf", 0) or 0, 1 if (tk.get("foes", 0) or 0) > 0 and tk.get("night") else 0)
    for tk in ticks:
        if prev is not None:
            dt = min(tk["t"] - prev["t"], 2.0)
            modes[tk.get("mode", "?")] += dt
            if tk.get("night"):
                night_s += dt
            else:
                day_s += dt
                if (tk.get("gold", 0) or 0) > 500 and tk.get("mode") not in ("ResolveUI",):
                    gold_idle_s += dt
            p0, p1 = prev.get("pos"), tk.get("pos")
            if p0 and p1:
                path += math.hypot(p1[0] - p0[0], p1[1] - p0[1])
        prev = tk
    for e in events:
        if str(e.get("note", "")).startswith(("pay", "build-hold")) and first_build is None:
            first_build = max(0.0, e["t"] - ticks[0]["t"])
    # window classification
    import bisect
    for w, d in wins.items():
        lo, hi = w * WIN, (w + 1) * WIN
        i = bisect.bisect_left(prod_t, lo)
        has_prod = i < len(prod_t) and prod_t[i] < hi
        daytime = d["day"] > d["n"] / 2
        if has_prod or (not daytime and d["foes"] > 0):
            prod_s += d["sec"]
        elif daytime:
            waste_s += d["dsec"]
    first, last = ticks[0].get("pos"), ticks[-1].get("pos")
    net = math.hypot(last[0] - first[0], last[1] - first[1]) if first and last else 0.0
    last_audit = ticks[-1]
    return {
        "run": os.path.basename(run_dir), "scene": ticks[0].get("scene"), "dur_s": dur, "day_s": day_s,
        "night_s": night_s, "productive_s": prod_s, "waste_s": waste_s, "gold_idle_s": gold_idle_s,
        "path_m": path, "first_build_s": first_build, "modes": dict(modes),
        "n_pay": sum(1 for e in events if str(e.get("note", "")).startswith("pay")),
        "n_done": sum(1 for e in events if e.get("note") == "build-done"),
        "n_gate": sum(1 for e in events if str(e.get("note", "")).startswith("gate-open")),
        "ally_end": last_audit.get("ally", 0), "wave": last_audit.get("wave"),
        "gold_end": last_audit.get("gold", 0),
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", default=r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent\runs")
    ap.add_argument("--last", type=int, default=0)
    ap.add_argument("--json", default="")
    a = ap.parse_args()
    dirs = sorted(d for d in (os.path.join(a.runs, x) for x in os.listdir(a.runs)) if os.path.isdir(d))
    if a.last:
        dirs = dirs[-a.last:]
    res = [r for r in (analyze(d) for d in dirs) if r]
    if not res:
        print("no analyzable runs")
        return 1
    tot = lambda k: sum(r[k] for r in res)
    dur, prod, waste = tot("dur_s"), tot("productive_s"), tot("waste_s")
    print(f"runs analyzed      : {len(res)} of {len(dirs)}")
    print(f"total match time   : {dur/3600:.2f} h  (day {tot('day_s')/3600:.2f} h / night {tot('night_s')/3600:.2f} h)")
    print(f"productive         : {prod/3600:.2f} h  ({100*prod/dur:.1f}% of match time)")
    print(f"DAY WASTE          : {waste/3600:.2f} h  ({100*waste/max(tot('day_s'),1):.1f}% of daytime)")
    print(f"gold idle (>500)   : {tot('gold_idle_s')/3600:.2f} h of daytime with unspent gold")
    print(f"pay / done / gate  : {tot('n_pay')} / {tot('n_done')} / {tot('n_gate')}")
    fb = [r["first_build_s"] for r in res if r["first_build_s"] is not None]
    if fb:
        fb.sort()
        print(f"time-to-first-build: median {fb[len(fb)//2]:.1f}s  max {fb[-1]:.1f}s")
    modes = Counter()
    for r in res:
        modes.update(r["modes"])
    mt = sum(modes.values()) or 1
    print("mode share         : " + ", ".join(f"{m} {100*s/mt:.0f}%" for m, s in modes.most_common()))
    print("\nworst 8 runs by waste share:")
    for r in sorted(res, key=lambda r: -r["waste_s"] / max(r["day_s"], 1))[:8]:
        print(f"  {r['run']:<34} dur {r['dur_s']/60:5.1f}m waste {100*r['waste_s']/max(r['day_s'],1):5.1f}% of day  pays {r['n_pay']:3d} ally {r['ally_end']}")
    print("\nbest 5 runs:")
    for r in sorted(res, key=lambda r: r["waste_s"] / max(r["day_s"], 1))[:5]:
        print(f"  {r['run']:<34} dur {r['dur_s']/60:5.1f}m waste {100*r['waste_s']/max(r['day_s'],1):5.1f}% of day  pays {r['n_pay']:3d} ally {r['ally_end']}")
    if a.json:
        with open(a.json, "w", encoding="utf-8") as f:
            json.dump(res, f)
    return 0


if __name__ == "__main__":
    sys.exit(main())
