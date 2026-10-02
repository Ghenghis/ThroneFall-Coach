"""Stand-in for ffmpeg in the livecap tests: finds the tcp://127.0.0.1:<port> output in its argv, connects and writes MJPEG parts in ffmpeg's
`-f mpjpeg` framing at a fixed rate.  FAKE_FFMPEG_MODE = ok | die_after:<n> | silent | noconnect | garbage_then_ok"""
import os
import re
import socket
import sys
import time

import cv2
import numpy as np

mode = os.environ.get("FAKE_FFMPEG_MODE", "ok")
fps = float(os.environ.get("FAKE_FFMPEG_FPS", "30"))
m = re.search(r"tcp://127\.0\.0\.1:(\d+)", " ".join(sys.argv))
if mode == "noconnect" or not m:
    sys.stderr.write("fake ffmpeg: cannot open the capture\n")
    sys.exit(1)
s = socket.create_connection(("127.0.0.1", int(m.group(1))), timeout=5)
if mode == "silent":
    time.sleep(60)
    sys.exit(0)
limit = int(mode.split(":")[1]) if mode.startswith("die_after:") else None
if mode == "garbage_then_ok":
    s.sendall(b"\x00\x01garbage-before-the-first-part\r\n")
n = 0
w, h = 320, 240
while True:
    img = np.full((h, w, 3), (n * 7) % 256, np.uint8)
    cv2.putText(img, "F%d" % n, (10, 120), cv2.FONT_HERSHEY_SIMPLEX, 2, (255, 255, 255), 3)
    ok, enc = cv2.imencode(".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, 80])
    b = enc.tobytes()
    try:
        s.sendall(b"--ffmpeg\r\nContent-type: image/jpeg\r\nContent-length: %d\r\n\r\n" % len(b) + b + b"\r\n")
    except OSError:
        sys.exit(0)
    n += 1
    if limit is not None and n >= limit:
        sys.exit(0)
    time.sleep(1.0 / fps)
