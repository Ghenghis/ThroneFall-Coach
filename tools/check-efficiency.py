#!/usr/bin/env python3
"""Self-check for the efficiency pipeline. Exit 0 = healthy, 1 = problems found.

Checks (each prints PASS/FAIL with a suggested fix):
  1. audit.json fresh (<10 s) and carries eff/useful_pct/task_agg/coach keys
  2. tasks.jsonl growing, records have ts+build, no malformed lines
  3. benchmarks.json equals the constants mirrored in tools/eff_lib.py
  4. MiniMax heartbeat: coach age < 240 s while a match is live; failures ratio
  5. coach-server /efficiency endpoint responds (if server up)

Usage: python check-efficiency.py [--agent DIR] [--port 8099]
"""
import argparse, json, os, sys, time, urllib.request
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import eff_lib

ap = argparse.ArgumentParser()
ap.add_argument("--agent", default=str(eff_lib.AGENT))
ap.add_argument("--port", type=int, default=8099)
a = ap.parse_args()
AG = a.agent
bad = 0


def res(ok, name, fix=""):
    global bad
    print(("PASS " if ok else "FAIL ") + name + ("" if ok else "  -> " + fix))
    bad += 0 if ok else 1


try:
    p = os.path.join(AG, "audit.json")
    age = time.time() - os.path.getmtime(p)
    au = json.load(open(p, encoding="utf-8"))
except Exception as e:
    au, age = {}, 999
    print("audit.json unreadable:", e)
res(age < 10, f"audit.json fresh ({age:.0f}s)", "game not running or plugin not writing; relaunch via tools/build-and-deploy.ps1")
need = ["eff", "useful_pct", "task_agg", "coach", "maxed_pct", "task_total"]
miss = [k for k in need if k not in au]
res(not miss, "audit.json has efficiency keys", f"missing {miss}; deploy the latest DLL")

tp = os.path.join(AG, "tasks.jsonl")
recs, badl = [], 0
if os.path.exists(tp):
    for ln in open(tp, encoding="utf-8", errors="replace"):
        ln = ln.strip()
        if not ln:
            continue
        try:
            recs.append(json.loads(ln))
        except ValueError:
            badl += 1
res(len(recs) > 0, f"tasks.jsonl has records ({len(recs)})", "Tasks.Update not running; check Bot.cs hook")
res(badl == 0, f"tasks.jsonl no malformed lines ({badl})", "fix JSON writer in Tasks.Write")
stamped = [r for r in recs if "ts" in r and "build" in r]
res(len(stamped) > 0, f"tasks.jsonl stamped records ({len(stamped)})", "old DLL; redeploy")
if stamped:
    res(time.time() - max(r["ts"] for r in stamped) < 900, "tasks.jsonl written in last 15 min",
        "no match played recently, or tracker stalled")

bp = os.path.join(AG, "benchmarks.json")
try:
    b = json.load(open(bp))
    ok = (b["target_useful_pct"]["v"] == eff_lib.TARGET["useful_pct"] and
          b["target_build_eff"]["v"] == eff_lib.TARGET["build_eff"] and
          b["target_eff_score"]["v"] == eff_lib.TARGET["eff_score"] and
          b["baseline_useful_pct"]["v"] == eff_lib.BASELINE["useful_pct"])
except Exception:
    ok = False
res(ok, "benchmarks.json matches eff_lib constants", "update Bench in src/Tasks.cs and TARGET/BASELINE in tools/eff_lib.py together")

c = au.get("coach", {})
live = au.get("mode") not in (None, "")
if live and c:
    cage = c.get("age_s", -1)
    res(0 <= cage < 240, f"MiniMax heartbeat age {cage}s", "coach not answering: check Coach.Url/LM Studio, see BepInEx log '[coach]'")
    calls = max(1, c.get("calls", 0) + c.get("fail", 0))
    res(c.get("fail", 0) / calls < 0.5, f"coach failure ratio {c.get('fail', 0)}/{calls}", "endpoint down or timing out (60 s timeout)")

try:
    j = json.load(urllib.request.urlopen(f"http://127.0.0.1:{a.port}/efficiency", timeout=5))
    res("windows" in j, "dashboard /efficiency endpoint", "restart tools/coach-server.py")
except Exception as e:
    res(False, "dashboard /efficiency endpoint", f"server down? {e}")

print("\nOVERALL:", "HEALTHY" if bad == 0 else f"{bad} problem(s)")
sys.exit(1 if bad else 0)
