#!/usr/bin/env python3
"""Overnight monitor: samples audit.json every 15 s into agent/monitor.csv (append)."""
import json, time, os, sys
AG = r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"
out = os.path.join(AG, "monitor.csv")
cols = ["night","wave","wave_total","ally","army_target","gold","maxed_pct","active_pct","mode","since_prog","hot_cells","doors_cov","breaches","bld","eff","scene"]
if not os.path.exists(out):
    open(out, "w").write("ts," + ",".join(cols) + "\n")
while True:
    try:
        a = json.load(open(os.path.join(AG, "audit.json"), encoding="utf-8"))
        open(out, "a").write(str(int(time.time())) + "," + ",".join(str(a.get(c, "")) for c in cols) + "\n")
    except Exception:
        pass
    time.sleep(15)
