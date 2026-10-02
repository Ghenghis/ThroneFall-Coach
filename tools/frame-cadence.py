#!/usr/bin/env python3
"""The game window's REAL frame cadence, measured from outside the game - the independent ground truth for "does it freeze?".

    python tools/frame-cadence.py --secs 60               # gaps between the frames the window presents, joined with the plugin's own stall log
    python tools/frame-cadence.py --secs 240 --json out.json

Windows Graphics Capture (ffmpeg's `gfxcapture`, the same capture livecap uses) stamps every frame with the time the compositor received it, so a gap between two
stamps is a moment when the window really showed nothing new - whatever the plugin's own clock says. The report lists the gaps >= 150 ms and, for each stall line the
plugin logged (agent/perf-stalls.jsonl) that is >= 250 ms, whether a real gap sits next to it. Read-only: it only captures the window, like the Live View does.
Run it before and after a change and compare "gaps >= 150 ms per minute" and the periodic gaps.
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import threading
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from stallstat import find_period  # noqa: E402

DEFAULT_AGENT = os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")
PTS = re.compile(r"pts_time:([0-9.]+)")


def parse_pts(line):
    """pts_time (seconds) of an ffmpeg showinfo line, None for any other line."""
    m = PTS.search(line)
    return float(m.group(1)) if m else None


def presentation_gaps(frames, min_ms=150.0):
    """frames = [(arrival wall time, pts s)] -> ([(wall time the gap ended, gap ms)], all gaps in ms sorted). The pts are put on the wall clock with the middle frame as the
    anchor (arrival jitter is a few ms; the pts differences are what is measured)."""
    if len(frames) < 3:
        return [], []
    a_t, a_p = frames[len(frames) // 2]
    gaps, every = [], []
    for (_, p0), (_, p1) in zip(frames, frames[1:]):
        g = (p1 - p0) * 1000.0
        every.append(g)
        if g >= min_ms:
            gaps.append((a_t + (p1 - a_p), g))
    return gaps, sorted(every)


def match_stalls(gaps, stalls, min_ms=250.0):
    """For every plugin stall line >= min_ms: the real presentation gap around it (ms) or None. The stall line is stamped when the long frame ended, so the gap must end
    within about a second of it and be at least 60% as long as the shorter of the two clocks says (the plugin's wall clock can miss a stall that happens outside Update)."""
    out = []
    for s in sorted(stalls, key=lambda r: r["t"]):
        if s.get("frame_ms", 0) < min_ms:
            continue
        best = None
        for gt, g in gaps:
            if abs(gt - s["t"]) < 1.0 + s["frame_ms"] / 2000.0 and g >= 0.6 * min(s["frame_ms"], max(s.get("wall_ms", 0), 100.0)):
                best = max(best or 0.0, g)
        out.append((s, best))
    return out


def read_stalls(agent, t0, t1):
    rows = []
    try:
        with open(os.path.join(agent, "perf-stalls.jsonl"), encoding="utf-8", errors="replace") as f:
            for ln in f:
                try:
                    r = json.loads(ln)
                except ValueError:
                    continue
                if t0 <= r.get("t", 0) <= t1:
                    rows.append(r)
    except OSError:
        pass
    return rows


def capture(hwnd, secs, ffmpeg, width=320):
    """Run gfxcapture on the window for `secs` seconds; returns ([(arrival, pts)], t0, t1)."""
    flt = "gfxcapture=hwnd=%d:capture_cursor=0:max_framerate=120:width=%d:height=%d:resize_mode=scale:scale_mode=bilinear,hwdownload,format=bgra,showinfo" % (hwnd, width, width * 3 // 4)
    p = subprocess.Popen([ffmpeg, "-hide_banner", "-loglevel", "info", "-nostats", "-nostdin", "-f", "lavfi", "-i", flt, "-f", "null", "-"], stdin=subprocess.DEVNULL,
                         stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, creationflags=0x08000000 if sys.platform == "win32" else 0)
    frames = []

    def reader():
        for raw in iter(p.stderr.readline, b""):
            pts = parse_pts(raw.decode("utf8", "replace"))
            if pts is not None:
                frames.append((time.time(), pts))

    threading.Thread(target=reader, daemon=True).start()
    t0 = time.time()
    try:
        time.sleep(secs)
    finally:
        p.kill()
    return frames, t0, time.time()


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--secs", type=float, default=60.0)
    ap.add_argument("--agent", default=DEFAULT_AGENT)
    ap.add_argument("--ffmpeg", default="")
    ap.add_argument("--json", default="", help="also write the gaps and the matched stall lines to this file")
    a = ap.parse_args()
    ff = a.ffmpeg or os.environ.get("LIVECAP_FFMPEG") or shutil.which("ffmpeg")
    if not ff:
        print("ffmpeg (>= 8, with the gfxcapture filter) not found: set LIVECAP_FFMPEG or --ffmpeg")
        return 2
    import livecap
    hwnd, info = livecap.find_game_window()
    if not hwnd:
        print("game window not found (is it running and not minimised?)")
        return 2
    frames, t0, t1 = capture(hwnd, a.secs, ff)
    gaps, every = presentation_gaps(frames)
    if not every:
        print("too few frames captured (%d): the window presented nothing new, or it is minimised" % len(frames))
        return 3
    span = frames[-1][1] - frames[0][1]
    mins = max(span / 60.0, 1e-6)
    print("captured %d frames in %.0f s: %.1f fps presented; gap p50 %.1f ms, p99 %.1f ms, max %.0f ms" % (len(frames), span, len(frames) / span, every[len(every) // 2], every[int(len(every) * 0.99)], every[-1]))
    print("gaps >= 150 ms: %d (%.1f per minute); >= 400 ms: %d; >= 1 s: %d" % (len(gaps), len(gaps) / mins, sum(1 for _, g in gaps if g >= 400), sum(1 for _, g in gaps if g >= 1000)))
    per = find_period([t for t, g in gaps if g >= 200], min_gaps=3)
    if per:
        print("PERIODIC: gaps >= 200 ms recur every %.1f s (%d of %d gaps between them) - a timer, not load" % per)
    stalls = read_stalls(a.agent, t0, t1)
    pairs = match_stalls(gaps, stalls)
    real = sum(1 for _, g in pairs if g)
    print("plugin stall lines in the same window: %d (%d >= 250 ms); of those, %d match a real gap in the presented frames and %d do not" % (len(stalls), len(pairs), real, len(pairs) - real))
    for s, g in pairs[:25]:
        print("  t+%6.1f s  plugin says %4.0f ms (wall clock %5.1f ms, plugin code %5.1f ms)  -> real gap: %s" % (s["t"] - t0, s["frame_ms"], s.get("wall_ms", 0), s.get("plugin_ms", 0), ("%.0f ms" % g) if g else "none"))
    if a.json:
        with open(a.json, "w") as f:
            json.dump({"t0": t0, "t1": t1, "frames": len(frames), "gaps": [(round(t, 3), round(g, 1)) for t, g in gaps], "stalls": stalls}, f)
    return 0


if __name__ == "__main__":
    sys.exit(main())
