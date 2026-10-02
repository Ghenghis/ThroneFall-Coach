#!/usr/bin/env python3
"""Rolling view of the GAME's own frame-time telemetry (agent/perf.json + perf-stalls.jsonl, written by the plugin's FramePerf).

    python tools/perf-watch.py                 # one line every 5 s until Ctrl+C
    python tools/perf-watch.py --secs 60       # 60 s, then a summary (what share of stalled time is the engine, what is our plugin)
    python tools/perf-watch.py --history 10    # no waiting: analyse the last 10 minutes of agent/perf-stalls.jsonl (causes, sections, PERIODIC stalls)
    python tools/perf-watch.py --agent DIR

Use it for A/B experiments (unload a local LLM, close a GPU-heavy app, change a plugin setting): run it for a minute before and a minute after.
`plugin` stalls = a measured plugin section (bot / coach / act / livelink) was the slow part; `engine` = not inside one of the measured sections (the game's own work, GPU
wait, driver, OS, plugin work outside Update - and stalls just under the 100 ms logging threshold, which are only seen through their echo).
The plugin's log pairs Unity's delta time with the wrong frame (one frame late), so every stall is logged twice: the real line and an "engine"-looking echo. This tool counts
each stall once (stallstat.real_events); the raw perf-stalls.jsonl and perf.json causes are not corrected.
A stall that recurs every N seconds is a timer, not load: --history prints the period when there is one (this is how the 30 s live.png hitch was found).
"""
import argparse
import collections
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from stallstat import find_period, real_events, shares  # noqa: E402

DEFAULT_AGENT = os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")


def read_json(p):
    try:
        with open(p, encoding="utf-8") as f:
            return json.load(f)
    except (OSError, ValueError):
        return None


def stall_rows(p, since):
    out = []
    try:
        with open(p, encoding="utf-8", errors="replace") as f:
            for ln in f:
                try:
                    r = json.loads(ln)
                except ValueError:
                    continue
                if r.get("t", 0) >= since:
                    out.append(r)
    except OSError:
        pass
    return out


def history(agent, minutes):
    rows = stall_rows(os.path.join(agent, "perf-stalls.jsonl"), time.time() - minutes * 60)
    if not rows:
        print("no stall lines in the last %.0f minutes (perf-stalls.jsonl missing or the game was quiet)" % minutes)
        return 1
    ev = real_events(rows)
    span = max(1.0, ev[-1]["t"] - ev[0]["t"]) if ev else 1.0
    sh = shares(ev)
    ms = sorted(e["ms"] for e in ev)
    print("last %.0f min: %d real stalls > 100 ms (%.1f per minute; %d log lines, %d were echoes of the same stall), %.1f s stalled in total; length p50 %.0f ms, p90 %.0f ms, max %.0f ms" % (
        span / 60, len(ev), len(ev) / (span / 60), len(rows), len(rows) - len(ev), sh["stalled_ms"] / 1000, ms[len(ms) // 2], ms[int(len(ms) * 0.9)], ms[-1]))
    print("share of stalled time: plugin %.0f%% + mixed %.0f%% (a measured plugin section was the slow part) | engine %.0f%% (not in the plugin's measured sections; includes stalls just under the 100 ms log threshold)" % (
        100 * sh.get("plugin", 0), 100 * sh.get("mixed", 0), 100 * sh.get("engine", 0)))
    by = collections.defaultdict(list)
    for e in ev:
        if e["cause"] in ("plugin", "mixed") and e.get("top"):
            by[e["top"]].append(e["ms"])
    tot = sum(e["ms"] for e in ev) or 1.0
    for k, v in sorted(by.items(), key=lambda kv: -sum(kv[1])):
        v.sort()
        print("  plugin section %-8s %4d stalls = %2.0f%% of the stalled time, length p50 %.0f ms, max %.0f ms" % (k, len(v), 100 * sum(v) / tot, v[len(v) // 2], v[-1]))
    for min_ms in (200, 100):
        per = find_period([e["t"] for e in ev if e["ms"] >= min_ms])
        if per:
            what = {}
            for e in ev:
                if e["ms"] >= min_ms and e.get("top"):
                    what[e["top"]] = what.get(e["top"], 0) + 1
            print("PERIODIC: stalls >= %d ms recur every %.1f s (%d of %d are followed by another one %.1f s later) - something runs on a %.0f s timer%s; look at what writes / captures / syncs that often" % (
                min_ms, per[0], per[1], per[2], per[0], per[0], (" (mostly in the %s section)" % max(what, key=what.get)) if what else ""))
            break
    else:
        print("no periodic component among the stalls (>= 200 ms or >= 100 ms)")
    return 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--agent", default=DEFAULT_AGENT)
    ap.add_argument("--secs", type=float, default=0, help="stop after this many seconds and print a summary (0 = run until Ctrl+C)")
    ap.add_argument("--every", type=float, default=5.0)
    ap.add_argument("--history", type=float, default=0, metavar="MIN", help="do not wait: analyse the last MIN minutes of perf-stalls.jsonl and exit")
    a = ap.parse_args()
    if a.history:
        return history(a.agent, a.history)
    t0 = time.time()
    print("time      fps  frame_ms p50/p99/max     stalls>50/>100 (5 s)  plugin ms/frame (bot coach live)   cause of stalls so far")
    samples = []
    try:
        while True:
            time.sleep(a.every)
            p = read_json(os.path.join(a.agent, "perf.json"))
            if not p:
                print("no perf.json yet (plugin build with perf.v1 not running?)")
                continue
            samples.append(p)
            fm, sec = p.get("frame_ms", {}), p.get("sections", {})
            sh = shares(real_events(stall_rows(os.path.join(a.agent, "perf-stalls.jsonl"), t0)))
            print("%s  %3d  %6.1f/%6.1f/%6.1f   %3d / %3d          %5.1f  (%4.1f %4.1f %4.1f)        plugin %.0f%%  mixed %.0f%%  engine %.0f%%" % (
                time.strftime("%H:%M:%S"), p.get("fps", 0), fm.get("p50", 0), fm.get("p99", 0), fm.get("max", 0), p.get("stalls_50", 0), p.get("stalls_100", 0),
                p.get("plugin_ms", {}).get("avg", 0), sec.get("bot", 0), sec.get("coach", 0), sec.get("livelink", 0),
                100 * sh.get("plugin", 0), 100 * sh.get("mixed", 0), 100 * sh.get("engine", 0)))
            if a.secs and time.time() - t0 >= a.secs:
                break
    except KeyboardInterrupt:
        pass
    if samples:
        fps = sorted(s.get("fps", 0) for s in samples)
        s100 = sum(s.get("stalls_100", 0) for s in samples)
        print("\nsummary over %.0f s: fps median %d (min %d, max %d) | stalls >100 ms per 5 s window: mean %.1f | plugin %.1f ms/frame avg" % (
            time.time() - t0, fps[len(fps) // 2], fps[0], fps[-1], s100 / len(samples), sum(s.get("plugin_ms", {}).get("avg", 0) for s in samples) / len(samples)))
        per = find_period([e["t"] for e in real_events(stall_rows(os.path.join(a.agent, "perf-stalls.jsonl"), t0)) if e["ms"] >= 200], min_gaps=3)
        if per:
            print("periodic: stalls >= 200 ms recur every %.1f s (%d of %d are followed by another one that period later) - a timer, not load (see --history)" % per)
    return 0


if __name__ == "__main__":
    sys.exit(main())
