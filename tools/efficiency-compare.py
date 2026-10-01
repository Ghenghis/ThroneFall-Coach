#!/usr/bin/env python3
"""Compare bot efficiency across time windows and bot builds, vs baseline and target.

Usage: python efficiency-compare.py [--json OUT]
Source: agent/tasks.jsonl (written live by src/Tasks.cs). Baseline = historical
196-run measurement; target = estimates in src/Tasks.cs Bench (agent/benchmarks.json).
"""
import argparse, json, sys, time
sys.path.insert(0, __import__("os").path.dirname(__file__))
import eff_lib

ap = argparse.ArgumentParser()
ap.add_argument("--json")
a = ap.parse_args()
c = eff_lib.compare()
cols = ["useful_pct", "build_n", "build_ok_pct", "build_eff", "gold_per_min", "task_misses", "days",
        "day_useful_pct", "day_avg_eff", "builds_per_day", "ally_gain_per_day", "maxed_gain_per_day",
        "coach_fx_avg_delta", "coach_latency_ms"]
print(f"records={c['records']}  baseline useful%={c['baseline']['useful_pct']}  target useful%={c['target']['useful_pct']}")
print(f"{'metric':22}" + "".join(f"{w:>10}" for w in c["windows"]))
for k in cols:
    print(f"{k:22}" + "".join(f"{str(c['windows'][w].get(k)):>10}" for w in c["windows"]))
print("\nper bot build (DLL mtime):")
for b in c["builds"]:
    print(time.strftime("  %m-%d %H:%M", time.localtime(b["build"])), "since", time.strftime("%m-%d %H:%M", time.localtime(b["since"])),
          f"tasks={b['tasks']} useful%={b['useful_pct']} build_eff={b['build_eff']} ok%={b['build_ok_pct']} misses={b['task_misses']}")
allw = c["windows"]["all"]
print("\nbiggest gaps to target:", eff_lib.gap(allw))
print("worst wasters (kind, waste_s):", allw["worst"])
if a.json:
    open(a.json, "w").write(json.dumps(c, indent=1))
