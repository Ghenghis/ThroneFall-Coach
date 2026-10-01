#!/usr/bin/env python3
"""Phase 6 tuning report: does the efficiency metric actually predict doing well?

For every recorded Durststein-style run (>=120 s in match) compute
  useful%  (same classifier as live, eff_lib.backtest_run)
  max_wave (from ticks 'wave' = "w/total"), survival_s, mode shares
and report the Pearson correlation of useful% and each mode share with max_wave.
Then PROPOSE (never apply) weight changes into agent/tune-proposal.json:
modes whose time share correlates negatively with progress are candidates for a
higher drain; positively correlated ones for a higher gain.

Usage: python tune-efficiency.py [--last 80] [--scene Durststein] [--out FILE]
A proposal needs |r| >= 0.3 over >= 20 runs to be emitted; otherwise it says
"insufficient evidence" so weights are not tuned on noise.
"""
import argparse, json, math, sys, os
from collections import Counter
from pathlib import Path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import eff_lib


def pearson(x, y):
    n = len(x)
    if n < 3:
        return None
    mx, my = sum(x) / n, sum(y) / n
    sx = math.sqrt(sum((a - mx) ** 2 for a in x))
    sy = math.sqrt(sum((b - my) ** 2 for b in y))
    return None if sx == 0 or sy == 0 else sum((a - mx) * (b - my) for a, b in zip(x, y)) / (sx * sy)


def run_stats(d):
    r = eff_lib.backtest_run(d)
    if not r or r[0] + r[1] < 120:
        return None
    modes, wave, t0, t1 = Counter(), 0, None, None
    prev = None
    for ln in (d / "ticks.jsonl").read_text(encoding="utf-8", errors="replace").splitlines():
        if not ln.startswith("{"):
            continue
        try:
            t = json.loads(ln)
        except ValueError:
            continue
        if t.get("state") != "InMatch":
            continue
        if t0 is None:
            t0 = t["t"]
        t1 = t["t"]
        try:
            wave = max(wave, int(str(t.get("wave", "0/0")).split("/")[0]))
        except ValueError:
            pass
        if prev is not None:
            modes[t.get("mode", "?")] += min(t["t"] - prev["t"], 1.0)
        prev = t
    tot = sum(modes.values()) or 1
    return {"run": d.name, "useful_pct": 100 * r[0] / (r[0] + r[1]), "max_wave": wave, "dur": (t1 or 0) - (t0 or 0),
            "shares": {k: v / tot for k, v in modes.items()}}


ap = argparse.ArgumentParser()
ap.add_argument("--last", type=int, default=80)
ap.add_argument("--scene", default="Durststein")
ap.add_argument("--out", default=str(eff_lib.AGENT / "tune-proposal.json"))
a = ap.parse_args()
runs = sorted((d for d in (eff_lib.AGENT / "runs").iterdir() if d.is_dir() and a.scene in d.name), key=lambda p: p.stat().st_mtime)[-a.last:]
st = [s for s in (run_stats(d) for d in runs) if s]
print(f"runs analysed: {len(st)} (scene={a.scene})")
out = {"runs": len(st), "scene": a.scene, "corr": {}, "proposals": [], "applied": False}
if st:
    w = [s["max_wave"] for s in st]
    r = pearson([s["useful_pct"] for s in st], w)
    out["corr"]["useful_pct~max_wave"] = None if r is None else round(r, 3)
    print("corr(useful%, max_wave) =", out["corr"]["useful_pct~max_wave"])
    for m in sorted({k for s in st for k in s["shares"]}):
        rm = pearson([s["shares"].get(m, 0) for s in st], w)
        out["corr"]["share_" + m + "~max_wave"] = None if rm is None else round(rm, 3)
        if rm is not None:
            print(f"  share[{m:12}] r={rm:+.2f}")
            if len(st) >= 20 and abs(rm) >= 0.3:
                out["proposals"].append({"mode": m, "r": round(rm, 3),
                                         "suggest": "raise drain/penalty for this mode's wasted time" if rm < 0 else "this mode correlates with progress; do not penalise"})
out["caveat"] = ("max_wave is confounded with run length (longer runs spend more time in night modes such as HoldCastle/HeroDead); "
                 "proposals are hypotheses to A/B test, never auto-applied")
if st:
    rd_ = pearson([s["dur"] for s in st], [s["max_wave"] for s in st])
    out["corr"]["dur~max_wave"] = None if rd_ is None else round(rd_, 3)
    print("confound check corr(duration, max_wave) =", out["corr"]["dur~max_wave"])
if not out["proposals"]:
    out["note"] = "insufficient evidence (need >=20 runs and |r|>=0.3): weights unchanged"
print(json.dumps(out["proposals"], indent=1) if out["proposals"] else out["note"])
Path(a.out).write_text(json.dumps(out, indent=1))
print("wrote", a.out)
