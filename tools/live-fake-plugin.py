#!/usr/bin/env python3
"""A stand-in for the plugin's in-game capture (src/LiveLink.cs): connects to livecap's ingest port and pushes raw RGBA frames with a camera
matrix in the per-frame meta - the exact byte protocol the real plugin speaks. Used by the tests and for trying the pipeline without the game.

    python tools/live-fake-plugin.py --port 8095 --fps 30 --w 1280 --h 960 --secs 20
"""
import argparse
import json
import socket
import struct
import sys
import threading
import time

import numpy as np

INGEST_HDR = struct.Struct("<4sIIIIdII")


def make_frame(n, w, h, fmt=1):
    """Test pattern with an UPRIGHT scene: red band at the TOP, blue at the BOTTOM, a green square sliding left->right, frame counter in the blue channel of a corner."""
    img = np.zeros((h, w, 4), np.uint8)
    img[..., 3] = 255
    img[: h // 8, :, 0] = 255                                       # top band: red   (RGBA)
    img[-h // 8:, :, 2] = 255                                       # bottom band: blue
    x = int((n * 7) % (w - 80))
    img[h // 2 - 40: h // 2 + 40, x: x + 80, 1] = 255               # moving green square
    img[8:24, 8:8 + 16, :3] = (n % 256, 255 - n % 256, 128)          # corner swatch that changes every frame
    if fmt == 2:                                                    # BGRA top-down
        return img[..., [2, 1, 0, 3]].copy()
    return img[::-1].copy()                                         # fmt 1: RGBA rows bottom-to-top, like Unity's readback


def run(a):
    s = socket.create_connection(("127.0.0.1", a.port), timeout=5)
    s.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    s.sendall(("TFGAME1 " + json.dumps({"build": "fake-1", "pid": 0, "w": a.w, "h": a.h, "unity": "fake"}) + "\n").encode())
    ctl = {"fps": a.fps}

    def reader():
        buf = b""
        try:
            while True:
                d = s.recv(4096)
                if not d:
                    return
                buf += d
                while b"\n" in buf:
                    line, buf = buf.split(b"\n", 1)
                    try:
                        c = json.loads(line).get("cap")
                        if c:
                            ctl["fps"] = max(5, min(60, int(c.get("fps", ctl["fps"]))))
                            print("control from livecap:", c, flush=True)
                    except Exception:
                        pass
        except OSError:
            return
    threading.Thread(target=reader, daemon=True).start()
    vp = [0.01462, 0, -0.01462, 0.22775, 0.01597, 0.01581, 0.01597, 0.24656, 0.00081, -0.00164, 0.00081, -0.77928, 0, 0, 0, 1]
    t0 = time.perf_counter()
    n = 0
    sent = 0
    end = t0 + a.secs
    next_t = t0
    while time.perf_counter() < end:
        frame = make_frame(n, a.w, a.h, a.fmt)
        meta = json.dumps({"pw": 1920, "ph": 1440, "vp": vp, "gy": 13.49, "hero": [-24.2, -8.5], "ts": 1.0, "scene": "fake", "n": n}).encode()
        payload = frame.tobytes()
        hdr = INGEST_HDR.pack(b"TFRM", len(meta), a.w, a.h, a.fmt, time.time() * 1000.0, n, len(payload))
        try:
            s.sendall(hdr + meta + payload)
        except OSError as ex:
            print("send failed:", ex)
            break
        sent += 1
        n += 1
        next_t += 1.0 / ctl["fps"]
        d = next_t - time.perf_counter()
        if d > 0:
            time.sleep(d)
        elif d < -0.5:
            next_t = time.perf_counter()
    el = time.perf_counter() - t0
    print("sent %d frames in %.1fs = %.1f fps (%.1f MB/s)" % (sent, el, sent / el, sent * a.w * a.h * (3 if a.fmt == 3 else 4) / el / 1e6))
    s.close()


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8095)
    ap.add_argument("--fps", type=int, default=30)
    ap.add_argument("--w", type=int, default=1280)
    ap.add_argument("--h", type=int, default=960)
    ap.add_argument("--fmt", type=int, default=1)
    ap.add_argument("--secs", type=float, default=10)
    sys.exit(run(ap.parse_args()) or 0)
