"""Tests for tools/stallstat.py: collapsing the plugin's stall log into REAL stalls (the log pairs Unity's delta time with the wrong frame, so every stall is logged twice),
the cause / section shares, and the periodic finder on top of them.   Run:  python tests/test_stallstat.py"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "tools"))
import stallstat as ss  # noqa: E402

FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:300]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


def line(t, frame, wall, plugin, cause, top="bot", top_ms=None, shot=""):
    return {"t": t, "frame_ms": frame, "wall_ms": wall, "plugin_ms": plugin, "cause": cause, "top": top, "top_ms": plugin if top_ms is None else top_ms, "gc": 0, "shot": shot}


def main():
    # the sequence seen in the real log around a live.png capture (02:03:59): the real line (the plugin's wall clock 215 ms, 207 ms in the coach section, shot=png, Unity's
    # delta still the old 17 ms) and one frame later its echo (Unity's delta 317 ms, the plugin's wall clock a normal 17.7 ms, nothing in our sections -> "engine")
    real = line(100.0, 17, 215.3, 208.1, "plugin", "coach", 207.3, "png")
    echo = line(100.5, 317, 17.7, 0.0, "engine", "bot", 0.0)
    ev = ss.real_events([real, echo])
    check("real_events: a stall and its echo one frame later are ONE stall", len(ev) == 1, ev)
    check("real_events: ... with the plugin's own clock as its length and the cause of the real line", ev and ev[0]["ms"] == 215.3 and ev[0]["cause"] == "plugin" and ev[0]["top"] == "coach", ev)
    check("real_events: order of the input does not matter", ss.real_events([echo, real]) == ev)

    ev = ss.real_events([echo])
    check("real_events: an echo with NO real line before it (the real frame was under the 100 ms threshold) is kept, as 'engine' with Unity's delta as its length",
          len(ev) == 1 and ev[0]["ms"] == 317 and ev[0]["cause"] == "engine" and ev[0]["lone_delta"], ev)
    ev = ss.real_events([line(100.0, 17, 120.0, 110.0, "plugin", "bot"), line(101.5, 317, 17.7, 0.0, "engine")])
    check("real_events: an echo 1.5 s after the real line is not an echo (too far apart): two stalls", len(ev) == 2, ev)
    ev = ss.real_events([line(100.0, 17, 120.0, 110.0, "plugin", "bot"), line(100.2, 17, 130.0, 120.0, "plugin", "bot")])
    check("real_events: two real stalls in consecutive frames are two stalls (the second has a long wall clock, it is no echo)", len(ev) == 2, ev)
    ev = ss.real_events([line(100.0, 17, 70.0, 60.0, "plugin", "bot"), line(100.1, 90, 15.0, 0.0, "engine")])
    check("real_events: a predecessor shorter than 80 ms does not make the next line an echo", len(ev) == 2, ev)
    # two stalls in consecutive frames: each line's delta is the stall of the frame before it, the third line is the echo of the second
    ev = ss.real_events([line(100.00, 17, 120.0, 110.0, "plugin", "bot"), line(100.15, 120, 130.0, 118.0, "plugin", "bot"), line(100.30, 130, 16.0, 0.0, "engine")])
    check("real_events: two stalls in consecutive frames + the echo of the second = two stalls", len(ev) == 2 and [e["ms"] for e in ev] == [120.0, 130.0], ev)
    old = [{"t": 1.0, "frame_ms": 300.0, "cause": "engine"}, {"t": 2.0, "frame_ms": 150.0, "cause": "plugin"}]
    ev = ss.real_events(old)
    check("real_events: rows without wall_ms (older logs, hand-made rows) are taken as they are", [e["ms"] for e in ev] == [300.0, 150.0] and [e["cause"] for e in ev] == ["engine", "plugin"], ev)

    # a 30 s png timer, each stall logged as real line + echo, plus a bot stall every ~1.5 s and an unexplained 789 ms one
    rows = []
    for k in range(10):
        t = 1000.0 + 30 * k
        rows += [line(t, 17, 280.0, 270.0, "plugin", "coach", 270.0, "png"), line(t + 0.3, 330, 17.0, 0.0, "engine")]
    for k in range(40):
        t = 1003.55 + 7.0 * k                                                          # never closer than 0.45 s to a png line, so no two stalls interleave
        rows += [line(t, 17, 105.0, 100.0, "plugin", "bot", 100.0), line(t + 0.1, 117, 16.5, 0.0, "engine")]
    rows.append(line(1141.0, 767, 14.5, 4.7, "engine", "coach", 4.7))                 # nothing real just before it: an unexplained one (clear of the png and bot lines)
    ev = ss.real_events(rows)
    check("real_events: 10 png stalls + 40 bot stalls + 1 lone = 51 stalls (not 101 log lines)", len(rows) == 101 and len(ev) == 51, (len(rows), len(ev)))
    sh = ss.shares(ev)
    plugin_ms = 10 * 280 + 40 * 105
    total = plugin_ms + 767
    check("shares: the plugin's share of the stalled time is what its sections really cost (not the 87% 'engine' the raw log gives)", abs(sh["plugin"] - plugin_ms / total) < 0.002 and abs(sh["engine"] - 767 / total) < 0.002, sh)
    raw_engine = sum(r["frame_ms"] for r in rows if r["cause"] == "engine") / sum(r["frame_ms"] for r in rows)
    check("shares: ... whereas counting the raw log lines would have called %.0f%% of the stalled time 'engine'" % (100 * raw_engine), raw_engine > 0.6, raw_engine)
    check("shares: the measured sections are ranked by their share of ALL stalled time", list(sh["sections"]) == ["bot", "coach"] and abs(sh["sections"]["bot"] - 40 * 105 / total) < 0.002, sh["sections"])
    check("shares: n and stalled_ms", sh["n"] == 51 and sh["stalled_ms"] == round(total), sh)
    check("shares: no events -> only the counts (the HUD shows nothing)", ss.shares([]) == {"n": 0, "stalled_ms": 0})
    per = ss.find_period([e["t"] for e in ev if e["ms"] >= 200])
    check("find_period on the collapsed events: the 30 s png timer; the echoes add no events, the unexplained 767 ms stall is just one more event (9 of 10 repeat)", per == (30.0, 9, 10), per)

    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
