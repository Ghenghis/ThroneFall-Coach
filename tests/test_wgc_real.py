"""REAL Windows Graphics Capture test (no game needed): livecap + the real ffmpeg `gfxcapture` capture a stand-in window, then another window is
put right on top of it. Proves the property the old BitBlt grabber lacked: the picture is the TARGET window's own content even when covered.

    python tests/test_wgc_real.py        (needs ffmpeg with gfxcapture, pywin32, an interactive desktop; skips with exit 0 otherwise)
"""
import json
import os
import shutil
import sys
import time

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "tools"))
import livecap as lc  # noqa: E402
from test_livecap import Harness, check, collect, decode, state_of, wait_for, FAILS  # noqa: E402


def blue_ratio(img):
    b, g, r = img[..., 0].astype(int), img[..., 1].astype(int), img[..., 2].astype(int)
    return float(((b > 150) & (r < 90)).mean())


def red_ratio(img):
    b, g, r = img[..., 0].astype(int), img[..., 1].astype(int), img[..., 2].astype(int)
    return float(((r > 180) & (b < 80) & (g < 80)).mean())


def white_center_x(img):
    ys, xs = np.nonzero((img.min(axis=2) > 235))
    return float(xs.mean()) if len(xs) > 50 else None


def main():
    ff = shutil.which("ffmpeg")
    if not ff:
        print("SKIP: ffmpeg not found")
        return 0
    try:
        import win32gui  # noqa: F401
        from wgc_target_window import TargetWindow
    except ImportError:
        print("SKIP: pywin32 not available")
        return 0
    lc.GAME_TITLE, lc.GAME_CLASS, lc.GAME_EXE = "LivecapTarget", "", ""
    target = TargetWindow(title="LivecapTarget", x=60, y=60, w=800, h=600, bg=(20, 40, 200), animated=True)
    cover = None
    h = None
    try:
        time.sleep(0.5)
        h = Harness("auto", ffmpeg=ff, width=640, fps=30)
        h.cfg.window_finder = None
        # (Harness gives no window_finder when window=None; use the real finder so the real ffmpeg + real window are exercised)
        h.cfg.window_finder = lc.find_game_window
        st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" and d["capture"]["fps"] > 5 else None)(state_of(h)), 25)
        check("real ffmpeg gfxcapture started on the stand-in window and delivers frames", bool(st), state_of(h))
        if not st:
            print(json.dumps(state_of(h), indent=1)[:900])
            return 1
        with h.ws() as ws:
            frames, _ = collect(ws, 40, timeout=15)
        imgs = [decode(f["jpeg"]) for f in frames]
        check("40 frames received", len(frames) >= 30, len(frames))
        check("the picture is the target window (blue background, client area only - no title bar)", np.mean([blue_ratio(i) for i in imgs[-10:]]) > 0.85, [round(blue_ratio(i), 2) for i in imgs[-4:]])
        xs = [white_center_x(i) for i in imgs if white_center_x(i) is not None]
        check("the moving square really moves from frame to frame (live pixels, not a stale surface)", len(xs) > 10 and (max(xs) - min(xs)) > 30, (len(xs), min(xs) if xs else None, max(xs) if xs else None))
        st = state_of(h)
        check("sustained capture rate is real (> 20 fps)", st["capture"]["fps"] > 20, st["capture"]["fps"])
        # the property the old grabber lacked: cover the window and keep capturing ITS pixels
        r = win32gui.GetWindowRect(target.hwnd)
        cover = TargetWindow(title="LivecapCover", x=r[0] - 20, y=r[1] - 20, w=(r[2] - r[0]) + 40, h=(r[3] - r[1]) + 40, bg=(220, 20, 20), animated=False, topmost=True)
        time.sleep(1.0)
        with h.ws() as ws:
            frames2, _ = collect(ws, 20, timeout=10)
        imgs2 = [decode(f["jpeg"]) for f in frames2]
        check("frames keep coming while another window covers the target", len(frames2) >= 10, len(frames2))
        check("WGC still shows the TARGET's own content when it is covered (blue, not the red cover)", np.mean([blue_ratio(i) for i in imgs2[-8:]]) > 0.85 and np.mean([red_ratio(i) for i in imgs2[-8:]]) < 0.03,
              ([round(blue_ratio(i), 2) for i in imgs2[-3:]], [round(red_ratio(i), 2) for i in imgs2[-3:]]))
        xs2 = [white_center_x(i) for i in imgs2 if white_center_x(i) is not None]
        check("... and it is still live (the square keeps moving under the cover)", len(xs2) > 5 and (max(xs2) - min(xs2)) > 30, (len(xs2), xs2[:3]))
        # what a screen/BitBlt capture of that very rectangle gets (documents WHY the old method showed the Coach page inside itself)
        try:
            from PIL import ImageGrab
            g = np.array(ImageGrab.grab(bbox=(r[0] + 100, r[1] + 100, r[0] + 300, r[1] + 250)))[..., ::-1]
            check("(contrast) a plain screen grab of the same area sees the COVER, not the target", red_ratio(g) > 0.9, round(red_ratio(g), 2))
        except Exception as ex:
            print("   (screen-grab contrast skipped: %s)" % ex)
        cover.close()
        cover = None
        # minimised: WGC cannot capture it -> honest state
        target.minimize()
        st = wait_for(lambda: (lambda d: d if d["state"] in ("minimized", "plugin", "no-window") else None)(state_of(h)), 10)
        check("minimised target: state says so (no fake picture)", bool(st) and st["state"] in ("minimized", "plugin", "no-window") and st["capture"]["ffmpeg_pid"] is None, st and st["state"])
        target.restore()
        st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" and d["capture"]["fps"] > 5 else None)(state_of(h)), 25)
        check("restored: capture comes back by itself", bool(st), state_of(h)["state"])
        target.close()
        st = wait_for(lambda: (lambda d: d if d["state"] in ("no-window", "plugin") else None)(state_of(h)), 10)
        check("window closed: state no-window and the capture process is gone", bool(st) and st["capture"]["ffmpeg_pid"] is None, st and (st["state"], st["capture"]["ffmpeg_pid"]))
    finally:
        if cover:
            cover.close()
        try:
            target.close()
        except Exception:
            pass
        if h:
            h.close()
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
