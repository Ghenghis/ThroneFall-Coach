"""Tests for tools/perf-watch.py: the periodic-stall finder and the --history report.   Run:  python tests/test_perfwatch.py"""
import contextlib
import importlib.util
import io
import json
import os
import random
import sys
import tempfile
import time

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("perf_watch", os.path.join(HERE, "..", "tools", "perf-watch.py"))
pw = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pw)
FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:300]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


def timer(start, n, period=30.0, jitter=0.15, rng=None):
    rng = rng or random.Random(1)
    return [start + i * period + rng.uniform(-jitter, jitter) for i in range(n)]


def main():
    rng = random.Random(7)
    ev = timer(1000.0, 20, rng=rng)
    p = pw.find_period(ev)
    check("find_period: a 30 s timer with +-0.15 s jitter is found as 30.0 s with every gap matching", p and p[0] == 30.0 and p[1] == 19 and p[2] == 19, p)
    stray = ev + [1013.0, 1209.5, 1310.2]                                           # three events that belong to nothing
    p = pw.find_period(stray)
    check("find_period: stray events in between do not hide it", p and abs(p[0] - 30.0) < 0.3 and p[1] >= 15, p)
    reset = timer(1000.0, 10, rng=rng) + timer(1000.0 + 10 * 30.0 + 7.0, 10, rng=rng)       # the timer was re-armed 7 s out of phase (a reconnect)
    p = pw.find_period(reset)
    check("find_period: a phase reset (timer re-armed) does not matter - gaps, not absolute phase", p and abs(p[0] - 30.0) < 0.3 and p[1] >= 17, p)
    twice = [t for e in timer(1000.0, 12, rng=rng) for t in (e, e + 0.2)]               # the same stall logged as two lines 0.2 s apart
    p = pw.find_period(twice)
    check("find_period: lines of one stall logged 0.2 s apart are one event (differences under 0.9 s are bursts and ignored)", p and abs(p[0] - 30.0) < 0.3, p)
    missing = timer(1000.0, 5, rng=rng) + timer(1000.0 + 7 * 30.0, 8, rng=rng)            # one cycle did not stall (a 60 s gap)
    p = pw.find_period(missing)
    check("find_period: a missed cycle (60 s gap) is no reason to lose the 30 s period", p and abs(p[0] - 30.0) < 0.3 and p[1] >= 10, p)
    for trial in range(10):
        r = random.Random(100 + trial)
        noise = [r.uniform(0, 900) for _ in range(14)]
        if pw.find_period(noise):
            check("find_period: random times are NOT called periodic (trial %d)" % trial, False, pw.find_period(noise))
            break
    else:
        check("find_period: 10 sets of random times (14 events over 15 min) are never called periodic", True)
    check("find_period: too few events -> None", pw.find_period([1.0, 31.0, 61.0]) is None and pw.find_period([]) is None)
    p = pw.find_period(timer(0, 15, period=7.0, jitter=0.1, rng=rng))
    check("find_period: also finds short periods (7 s)", p and abs(p[0] - 7.0) < 0.3, p)
    check("find_period: a perfectly regular 1 s train is a 1.0 s timer", pw.find_period([float(i) for i in range(60)]) == (1.0, 59, 59), pw.find_period([float(i) for i in range(60)]))
    rr = random.Random(5)
    dense = sorted([rr.uniform(0, 600) for _ in range(500)] + [10 + 30 * k for k in range(20)])
    check("find_period: with an unrelated event every second a 20-event timer is NOT claimed (chance alone repeats half of all events)", pw.find_period(dense) is None, pw.find_period(dense))
    sparse = sorted([rr.uniform(0, 600) for _ in range(60)] + [10 + 30 * k for k in range(20)])
    pp = pw.find_period(sparse)
    check("find_period: 60 unrelated events + a 20-event 30 s timer over 10 minutes: the timer is found", pp and pp[0] == 30.0 and pp[1] >= 18, pp)
    fp = 0
    for trial in range(60):
        r2 = random.Random(2000 + trial)
        if pw.find_period(sorted(r2.uniform(0, 900) for _ in range(r2.choice((8, 15, 30, 60, 120, 300))))):
            fp += 1
    check("find_period: 60 sets of purely random times (8-300 events over 15 minutes) are never called periodic", fp == 0, fp)

    agent = tempfile.mkdtemp(prefix="pw_")
    now = time.time()
    rows = []
    for i, t in enumerate(timer(now - 563, 18, rng=rng)):                           # 18 unexplained stalls on a 30 s timer (Unity's delta long, the plugin's clock normal)
        rows.append({"t": t, "frame_ms": 250.0 + (i % 3) * 10, "wall_ms": 17.0, "plugin_ms": 0.1, "cause": "engine", "top": "bot", "top_ms": 0.0})
    for i in range(30):                                                             # 30 bot stalls, each logged twice: the real line and its echo one frame later
        t = now - 590 + i * 20.0
        rows.append({"t": t, "frame_ms": 17.0, "wall_ms": 108.0, "plugin_ms": 101.0, "cause": "plugin", "top": "bot", "top_ms": 101.0})
        rows.append({"t": t + 0.15, "frame_ms": 117.0, "wall_ms": 17.0, "plugin_ms": 0.0, "cause": "engine", "top": "bot", "top_ms": 0.0})
    rows.append({"t": now - 5000, "frame_ms": 9999.0, "wall_ms": 1.0, "plugin_ms": 0.0, "cause": "engine", "top": "bot", "top_ms": 0.0})       # outside the window
    with open(os.path.join(agent, "perf-stalls.jsonl"), "w") as f:
        f.write("\n".join(json.dumps(r) for r in sorted(rows, key=lambda r: r["t"])) + "\nnot json\n")
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rc = pw.history(agent, 10)
    out = buf.getvalue()
    check("history: counts only the lines inside the window, and each stall once (78 lines = 30 echoes + 48 real stalls)", rc == 0 and "48 real stalls" in out and "78 log lines, 30 were echoes" in out, out[:300])
    check("history: plugin / engine shares of the stalled TIME (30 x 108 ms plugin vs 18 x ~260 ms engine); the echoes are not counted as 'engine'", "plugin 41%" in out and "engine 59%" in out, out)
    check("history: the plugin's section is named with its share and typical time (the plugin's own clock: 108 ms)", "plugin section bot" in out and "30 stalls = 41%" in out and "p50 108 ms" in out, out)
    check("history: the 30 s timer is reported", "PERIODIC" in out and "every 30.0 s" in out, out)
    empty = tempfile.mkdtemp(prefix="pw_")
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rc = pw.history(empty, 10)
    check("history: no log file -> says so, returns 1 (no traceback)", rc == 1 and "no stall lines" in buf.getvalue(), buf.getvalue())
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
