#!/usr/bin/env python3
"""Headless benchmark client for livecap: connects like the browser does (acks every frame it 'displays') and reports what it got.

    python tools/live-bench.py                       # 10 s against ws://127.0.0.1:8097/ws
    python tools/live-bench.py --secs 20 --decode    # also decode every JPEG (cv2) to include decode cost
    python tools/live-bench.py --slow 100            # a slow viewer (100 ms per frame): proves the backlog never builds (latency stays bounded)
    python tools/live-bench.py --require-fps 20 --require-p95-ms 200   # exit code 1 when the numbers miss the bar (CI / proof)

Latency = (time the frame arrived at this client) - (time livecap received it from the capture); both clocks are this machine's, so it is the
transport+queue part of the glass-to-glass latency (add ~15-25 ms for the browser's decode + paint).
"""
import argparse
import asyncio
import json
import struct
import sys
import time

FRAME_HDR = struct.Struct("<BBHIdHHH")


def pct(v, q):
    v = sorted(v)
    return v[min(len(v) - 1, int(len(v) * q))] if v else float("nan")


async def run(a):
    import websockets.asyncio.client as wsc
    url = a.url
    t_end = time.time() + a.secs
    lat, gaps, sizes, dec = [], [], [], []
    seqs = []
    first = last_t = None
    state = {}
    info = None
    async with wsc.connect(url, max_size=None, compression=None, open_timeout=5, **({"origin": a.origin} if a.origin else {})) as ws:
        await ws.send(json.dumps({"hello": {"client": "live-bench", "decode": a.decode}}))
        while time.time() < t_end:
            try:
                m = await asyncio.wait_for(ws.recv(), timeout=max(0.2, t_end - time.time()))
            except asyncio.TimeoutError:
                break
            if isinstance(m, str):
                d = json.loads(m)
                if d.get("type") == "hello":
                    info = d
                elif d.get("type") == "state":
                    state = d
                continue
            magic, typ, flags, seq, t_srv, w, h, mlen = FRAME_HDR.unpack_from(m, 0)
            if magic != 0x54:
                print("bad frame magic", magic)
                return 2
            now = time.time() * 1000
            jpeg = memoryview(m)[FRAME_HDR.size + mlen:]
            if a.decode:
                import cv2
                import numpy as np
                t0 = time.perf_counter()
                cv2.imdecode(np.frombuffer(jpeg, np.uint8), cv2.IMREAD_COLOR)
                dec.append((time.perf_counter() - t0) * 1000)
            if a.slow:
                await asyncio.sleep(a.slow / 1000)
            lat.append(now - t_srv)
            sizes.append(len(jpeg))
            seqs.append(seq)
            t = time.perf_counter()
            if last_t is not None:
                gaps.append((t - last_t) * 1000)
            last_t = t
            if first is None:
                first = t
            if not a.no_ack:
                await ws.send(json.dumps({"ack": seq}))
    el = (last_t - first) if first and last_t and last_t > first else 0
    n = len(seqs)
    fps = (n - 1) / el if el else 0.0
    lost = (seqs[-1] - seqs[0] + 1 - n) if n > 1 else 0
    print("url %s | state %s %s | stream %sx%s @cfg %s fps q%s" % (url, state.get("state"), state.get("detail", ""), info and info.get("w"), info and info.get("h"), info and info.get("fps"), info and info.get("q")))
    print("frames %d in %.1fs = %.1f fps | %.0f KB/frame avg | %.1f Mbit/s | skipped by the server (latest-wins): %d" % (n, el, fps, sum(sizes) / max(1, n) / 1024, sum(sizes) * 8 / max(el, 1e-9) / 1e6, lost))
    if gaps:
        print("inter-frame gap ms: p50 %.1f  p95 %.1f  p99 %.1f  max %.1f" % (pct(gaps, .5), pct(gaps, .95), pct(gaps, .99), max(gaps)))
    if lat:
        print("latency capture->client ms: p50 %.1f  p95 %.1f  max %.1f" % (pct(lat, .5), pct(lat, .95), max(lat)))
    if dec:
        print("decode ms: p50 %.1f  p95 %.1f" % (pct(dec, .5), pct(dec, .95)))
    bad = []
    if a.require_fps and fps < a.require_fps:
        bad.append("fps %.1f < %.1f" % (fps, a.require_fps))
    if a.require_p95_ms and lat and pct(lat, .95) > a.require_p95_ms:
        bad.append("p95 latency %.0f ms > %.0f" % (pct(lat, .95), a.require_p95_ms))
    if n == 0:
        bad.append("no frames received")
    if bad:
        print("FAIL:", "; ".join(bad))
        return 1
    print("OK")
    return 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--url", default="ws://127.0.0.1:8097/ws")
    ap.add_argument("--secs", type=float, default=10)
    ap.add_argument("--decode", action="store_true")
    ap.add_argument("--slow", type=float, default=0, help="extra ms of 'rendering' per frame before acking")
    ap.add_argument("--no-ack", action="store_true")
    ap.add_argument("--origin", default="")
    ap.add_argument("--require-fps", type=float, default=0)
    ap.add_argument("--require-p95-ms", type=float, default=0)
    a = ap.parse_args()
    return asyncio.run(run(a))


if __name__ == "__main__":
    sys.exit(main())
