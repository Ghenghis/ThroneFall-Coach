"""Tests for the pure parts of tools/frame-cadence.py (parsing ffmpeg showinfo, finding presentation gaps, matching them with the plugin's stall lines).
Run:  python tests/test_frame_cadence.py   (the capture itself needs the game and ffmpeg; it is exercised by hand, see docs/LIVE-VIEW.md section 7)"""
import importlib.util
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("frame_cadence", os.path.join(HERE, "..", "tools", "frame-cadence.py"))
fc = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fc)
FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:300]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


def frames_at(pts_list, t_wall0=5000.0):
    return [(t_wall0 + p, p) for p in pts_list]


def main():
    line = "[Parsed_showinfo_3 @ 000001d2c8b0e540] n:  12 pts: 1620000 pts_time:16.2     duration: 10000 duration_time:0.1 fmt:bgra"
    check("parse_pts reads pts_time from a showinfo line", fc.parse_pts(line) == 16.2)
    check("parse_pts ignores every other line", fc.parse_pts("Input #0, lavfi, from 'gfxcapture=hwnd=1':") is None and fc.parse_pts("") is None)

    pts = [i / 60.0 for i in range(0, 300)]                                       # a clean 60 fps for 5 s
    pts += [pts[-1] + 0.250 + i / 60.0 for i in range(0, 120)]                    # then a 250 ms freeze and 2 more seconds
    gaps, every = fc.presentation_gaps(frames_at(pts))
    check("presentation_gaps: exactly the one freeze is found, with its length", len(gaps) == 1 and abs(gaps[0][1] - 250.0) < 1.0, gaps)
    check("presentation_gaps: the gap is placed on the wall clock where it ended", abs(gaps[0][0] - (5000.0 + pts[300])) < 0.01, gaps)
    check("presentation_gaps: the sorted gap list has the usual 16.7 ms cadence in the middle", abs(every[len(every) // 2] - 16.667) < 0.5, every[len(every) // 2])
    check("presentation_gaps: nothing to report for a smooth run", fc.presentation_gaps(frames_at([i / 60.0 for i in range(600)]))[0] == [])
    check("presentation_gaps: too few frames -> empty, no crash", fc.presentation_gaps(frames_at([0.0, 1.0])) == ([], []))

    t_end = 5000.0 + pts[300]
    stalls = [{"t": t_end + 0.05, "frame_ms": 270.0, "wall_ms": 16.0, "plugin_ms": 0.0},            # Unity says 270, the plugin's wall clock saw only 16 ms: still a real gap
              {"t": t_end - 3.0, "frame_ms": 400.0, "wall_ms": 395.0, "plugin_ms": 390.0},         # a stall line with nothing real around it
              {"t": t_end + 0.1, "frame_ms": 120.0, "wall_ms": 120.0, "plugin_ms": 100.0}]         # too short to be asked about (< 250 ms)
    m = fc.match_stalls(gaps, stalls)
    check("match_stalls: lines under 250 ms are not asked about", len(m) == 2, len(m))
    check("match_stalls: a stall line next to a real gap is confirmed even when the plugin's wall clock disagrees", m[1][1] and abs(m[1][1] - 250.0) < 2, m)
    check("match_stalls: a stall line with no gap near it is reported as unconfirmed", m[0][1] is None, m)

    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
