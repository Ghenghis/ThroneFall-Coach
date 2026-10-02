"""Tests for tools/livecap.py - the live video hub - without the game: synthetic frames, a fake ffmpeg, a fake plugin, real WebSockets/HTTP on
ephemeral ports.  Run:  python tests/test_livecap.py"""
import argparse
import asyncio
import json
import os
import socket
import struct
import sys
import tempfile
import threading
import time
import urllib.request

import cv2
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "tools"))
import livecap as lc  # noqa: E402
from websockets.sync.client import connect  # noqa: E402

FRAME_HDR = struct.Struct("<BBHIdHHH")
FAKE_FFMPEG = os.path.join(HERE, "fake_ffmpeg.py")
FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:300]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


class Harness:
    """A livecap instance in this process (own thread + event loop) on free ports with a temp agent dir."""

    def __init__(self, source="synthetic", window=None, ffmpeg="", ingest=-1, width=640, fps=30, fake_mode=None, idle=0.0):
        self.agent = tempfile.mkdtemp(prefix="lc_test_")
        self.window = window
        cfg = argparse.Namespace(port=0, agent=self.agent, source=source, width=width, fps=fps, quality=7, ffmpeg=ffmpeg, ingest_port=ingest, status=False, stop=False, bound_port=0, idle_s=idle,
                                 window_finder=(lambda: (window[0], dict(window[1]))) if window else (lambda: (None, {})))
        self.cfg = cfg
        self.lc = lc.LiveCap(cfg)
        if fake_mode:
            os.environ["FAKE_FFMPEG_MODE"] = fake_mode
        self.thread = threading.Thread(target=lambda: asyncio.run(self.lc.run()), daemon=True)
        self.thread.start()
        if not self.lc.ready.wait(15):
            raise RuntimeError("livecap did not start")
        self.port = cfg.bound_port
        self.hub = self.lc.hub

    def url(self, path=""):
        return "ws://127.0.0.1:%d/ws%s" % (self.port, path)

    def http(self, path, headers=None):
        req = urllib.request.Request("http://127.0.0.1:%d%s" % (self.port, path), headers=headers or {})
        try:
            with urllib.request.urlopen(req, timeout=5) as r:
                return r.status, r.read(), dict(r.headers)
        except urllib.error.HTTPError as e:
            return e.code, e.read(), dict(e.headers)

    def ws(self, **kw):
        return connect(self.url(), max_size=None, compression=None, open_timeout=5, **kw)

    def close(self):
        try:
            self.hub.loop.call_soon_threadsafe(self.hub.stop_ev.set)
            self.thread.join(8)
        except Exception:
            pass
        if self.hub.game:
            self.hub.game.stop_ev.set()
        os.environ.pop("FAKE_FFMPEG_MODE", None)


def parse_frame(m):
    magic, typ, flags, seq, t_ms, w, h, ml = FRAME_HDR.unpack_from(m, 0)
    return {"magic": magic, "flags": flags, "seq": seq, "t_ms": t_ms, "w": w, "h": h, "meta": m[22:22 + ml], "jpeg": bytes(m[22 + ml:])}


def collect(ws, n, timeout=8.0, ack=True, delay=0.0):
    """Receive until n binary frames (and every text message seen on the way)."""
    frames, texts = [], []
    end = time.time() + timeout
    while len(frames) < n and time.time() < end:
        try:
            m = ws.recv(timeout=max(0.05, end - time.time()))
        except TimeoutError:
            break
        if isinstance(m, str):
            texts.append(json.loads(m))
            continue
        f = parse_frame(m)
        f["rx"] = time.time() * 1000
        frames.append(f)
        if delay:
            time.sleep(delay)
        if ack:
            ws.send(json.dumps({"ack": f["seq"]}))
    return frames, texts


def decode(jpeg):
    return cv2.imdecode(np.frombuffer(jpeg, np.uint8), cv2.IMREAD_COLOR)


def wait_for(fn, timeout=12.0, step=0.25):
    """Poll fn() until it returns something truthy (returned) or the timeout passes (returns the last falsy value)."""
    end = time.time() + timeout
    v = fn()
    while not v and time.time() < end:
        time.sleep(step)
        v = fn()
    return v


def state_of(h):
    return json.loads(h.http("/stats")[1])


# ------------------------------------------------------------------------------------------------------------------------ pure helpers
def test_helpers():
    img = np.zeros((240, 320, 3), np.uint8)
    ok, enc = cv2.imencode(".jpg", img)
    b = enc.tobytes()
    check("jpeg_size reads the SOF marker", lc.jpeg_size(b) == (320, 240), lc.jpeg_size(b))
    check("jpeg_size survives truncation/garbage", lc.jpeg_size(b[:30]) is None and lc.jpeg_size(b"\xff\xd8\x00\x01") is None and lc.jpeg_size(b"") is None)
    check("jpeg_quality maps ffmpeg qscale to libjpeg quality monotonically", lc.jpeg_quality(2) > lc.jpeg_quality(7) > lc.jpeg_quality(20) >= 30 and lc.jpeg_quality(2) <= 95)
    R = lc.ORIGIN_RE
    check("origin policy: localhost/127.0.0.1/::1 with any port are allowed", all(R.match(o) for o in ("http://127.0.0.1:8099", "http://localhost:3000", "https://127.0.0.1", "http://[::1]:8099")))
    check("origin policy: foreign sites and lookalikes are refused", not any(R.match(o) for o in ("http://evil.example", "http://127.0.0.1.evil.example", "https://localhost.evil.com:80", "file://", "http://127.0.0.1@evil.example")))
    vp = [0.01462, 0, -0.01462, 0.22775, 0.01597, 0.01581, 0.01597, 0.24656, 0.00081, -0.00164, 0.00081, -0.77928, 0, 0, 0, 1]
    gy, pw, ph = 13.49, 1920, 1440
    ok_all = True
    for wx, wz in ((-24.2, -8.5), (0, 0), (30, -12.5), (-60, 44)):
        nx = vp[0] * wx + vp[1] * gy + vp[2] * wz + vp[3]
        ny = vp[4] * wx + vp[5] * gy + vp[6] * wz + vp[7]
        px, py = (nx * 0.5 + 0.5) * pw, (1 - (ny * 0.5 + 0.5)) * ph
        back = lc.Hub.unproject(vp, gy, px, py, pw, ph)
        ok_all &= back is not None and abs(back[0] - wx) < 1e-3 and abs(back[1] - wz) < 1e-3
    check("unproject(project(x)) returns the world position for the orthographic camera", ok_all)
    persp = list(vp[:12]) + [0, 0, 1, 0]
    check("unproject refuses a perspective matrix instead of returning nonsense", lc.Hub.unproject(persp, gy, 100, 100, pw, ph) is None)


# ------------------------------------------------------------------------------------------------------------------------ protocol
def test_stream_basics():
    h = Harness("synthetic", fps=30, width=640)
    try:
        with h.ws() as ws:
            frames, texts = collect(ws, 20, timeout=8)
        types = [t.get("type") for t in texts]
        check("first messages: hello then state", types[:2] == ["hello", "state"], types)
        check("hello announces version, picture size, fps", texts and texts[0].get("v") == lc.VERSION and texts[0].get("w") and texts[0].get("fps") == 30, texts[:1])
        check("frames arrive (20 within 8 s)", len(frames) == 20, len(frames))
        check("frame header: magic 'T', plausible size, valid JPEG that decodes", all(f["magic"] == 0x54 and decode(f["jpeg"]) is not None for f in frames) and frames[0]["w"] == 640 and frames[0]["h"] == 480)
        seqs = [f["seq"] for f in frames]
        check("sequence numbers strictly increase", all(b > a for a, b in zip(seqs, seqs[1:])), seqs)
        lat = [f["rx"] - f["t_ms"] for f in frames]
        check("capture->client latency is tiny on loopback (p95 < 250 ms)", sorted(lat)[int(len(lat) * .95) - 1] < 250 and min(lat) > -50, sorted(lat)[-3:])
        check("a decoded frame is the moving test pattern (not black)", decode(frames[5]["jpeg"]).mean() > 20)
    finally:
        h.close()


def test_flow_control():
    h = Harness("synthetic", fps=60, width=320)
    try:
        # a client that never acks: gets at most MAX_INFLIGHT frames, then nothing - until the server decides it simply does not speak the ack protocol
        with h.ws() as ws:
            frames, _ = collect(ws, 50, timeout=1.2, ack=False)
            check("no-ack client: the server stops after MAX_INFLIGHT=%d frames (no unbounded send)" % lc.MAX_INFLIGHT, len(frames) == lc.MAX_INFLIGHT, len(frames))
            more, _ = collect(ws, 30, timeout=4.5, ack=False)
            check("... and after ~2 s it is treated as an ack-less client and frames flow again", len(more) >= 10, len(more))
            st = json.loads(h.http("/stats")[1])
            check("stats mark that client as no_ack", any(c["no_ack"] for c in st["clients"]), st["clients"])
        # a slow viewer (120 ms per frame) at 60 fps capture: the server must skip, never queue -> the latency of what it receives stays bounded
        with h.ws() as ws:
            frames, _ = collect(ws, 25, timeout=10, ack=True, delay=0.12)
            lat = sorted(f["rx"] - f["t_ms"] for f in frames)
            check("slow client: received frames are FRESH (p95 latency < 400 ms; an MJPEG backlog would be seconds)", lat[int(len(lat) * .95) - 1] < 400, lat[-4:])
            seqs = [f["seq"] for f in frames]
            check("slow client: the server skipped frames instead of queueing them (seq gaps)", seqs[-1] - seqs[0] > len(seqs) * 2, (seqs[0], seqs[-1], len(seqs)))
        # two clients are independent
        with h.ws() as a, h.ws() as b:
            fa, _ = collect(a, 15, timeout=6)
            fb, _ = collect(b, 15, timeout=6)
        check("two clients each get their own full stream", len(fa) == 15 and len(fb) == 15, (len(fa), len(fb)))
    finally:
        h.close()


def test_http_and_security():
    h = Harness("synthetic", fps=30, width=320)
    try:
        time.sleep(0.5)
        s, body, hd = h.http("/health")
        check("/health", s == 200 and body == b"ok")
        s, body, hd = h.http("/stats")
        d = json.loads(body)
        check("/stats has state, capture fps, cfg and clients", s == 200 and d["version"] == lc.VERSION and d["capture"]["fps"] > 5 and d["cfg"]["fps"] == 30 and isinstance(d["clients"], list), list(d))
        s, body, hd = h.http("/frame.jpg")
        check("/frame.jpg is the latest frame as a JPEG", s == 200 and body[:2] == b"\xff\xd8" and decode(body) is not None and hd.get("Content-Type") == "image/jpeg")
        s, body, hd = h.http("/frame.png")
        img = cv2.imdecode(np.frombuffer(body, np.uint8), cv2.IMREAD_COLOR)
        check("/frame.png is a PNG that decodes to the frame size", s == 200 and body[:8] == b"\x89PNG\r\n\x1a\n" and img is not None and img.shape[1] == 320, (s, body[:8]))
        s, body, hd = h.http("/live.js")
        check("/live.js is served (the standalone viewer needs it)", s == 200 and b"window.LV" in body and "javascript" in hd.get("Content-Type", ""))
        s, body, hd = h.http("/")
        check("/ serves the standalone viewer page", s == 200 and b"live.js" in body and b"LV_STANDALONE" in body)
        check("unknown path -> 404", h.http("/nope")[0] == 404)
        check("a cross-site request (another web page embedding the game screen) is refused", h.http("/frame.jpg", {"Sec-Fetch-Site": "cross-site"})[0] == 403)
        check("same-site / direct requests are allowed", h.http("/frame.jpg", {"Sec-Fetch-Site": "same-site"})[0] == 200)
        s, body, hd = h.http("/stats", {"Origin": "http://127.0.0.1:8099"})
        check("CORS header only for an allowed origin", hd.get("Access-Control-Allow-Origin") == "http://127.0.0.1:8099")
        s, body, hd = h.http("/stats", {"Origin": "http://evil.example"})
        check("... and none for a foreign origin", "Access-Control-Allow-Origin" not in hd)
        ok = False
        try:
            with connect(h.url(), origin="http://evil.example", open_timeout=4):
                ok = True
        except Exception:
            ok = False
        check("WebSocket from a foreign Origin is rejected (a random web page cannot watch the game)", not ok)
        with connect(h.url(), origin="http://127.0.0.1:8099", max_size=None, open_timeout=4) as ws:
            check("WebSocket from the Coach page's origin is accepted", ws.recv(timeout=4) is not None)
        s, body, hd = h.http("/ws")
        check("a plain HTTP GET of /ws is refused politely (426)", s == 426)
        hb = os.path.join(h.agent, "livecap.json")
        time.sleep(1.2)
        d = json.load(open(hb))
        check("heartbeat file livecap.json (pid, port, state, fps) for the supervisor", d["pid"] == os.getpid() and d["port"] == h.port and d["state"] == "synthetic" and d["fps"] > 0, d)
    finally:
        h.close()


def test_settings():
    h = Harness("synthetic", fps=30, width=640)
    try:
        h.hub.settings_t = 0
        h.hub.apply_settings({"fps": 99999, "width": 5, "quality": -3})
        check("settings are clamped (fps<=60, width>=480, quality>=2)", (h.cfg.fps, h.cfg.width, h.cfg.quality) == (60, 480, 2), (h.cfg.fps, h.cfg.width, h.cfg.quality))
        h.hub.apply_settings({"fps": 10})
        check("a second change within 2 s is ignored (no restart storm)", h.cfg.fps == 60)
        h.hub.settings_t = 0
        h.hub.apply_settings({"fps": "banana"})
        check("garbage values are ignored", h.cfg.fps == 60)
        with h.ws() as ws:
            h.hub.settings_t = 0
            ws.send(json.dumps({"set": {"quality": 12}}))
            time.sleep(0.5)
            check("a client can change the quality over the socket", h.cfg.quality == 12, h.cfg.quality)
            ws.send(json.dumps({"stats": {"fps": 47.5, "lat": 18, "nested": {"x": 1}, "bad": [1]}}))
            ws.send(json.dumps({"ping": 123}))
            pong = None
            for _ in range(30):
                m = ws.recv(timeout=2)
                if isinstance(m, str) and json.loads(m).get("type") == "pong":
                    pong = json.loads(m)
                    break
            check("ping -> pong echoes the token and carries the server time", pong and pong["t"] == 123 and pong["now"] > 1e12, pong)
            st = json.loads(h.http("/stats")[1])
            rep = st["clients"][0]["report"]
            check("what the browser reports it actually drew shows up in /stats (scalars only)", rep.get("fps") == 47.5 and rep.get("lat") == 18 and "nested" not in rep and "bad" not in rep, rep)
    finally:
        h.close()


# ------------------------------------------------------------------------------------------------------------------------ overlay
def test_overlay():
    h = Harness("synthetic", fps=20, width=320)
    try:
        view = {"t": time.time(), "ok": True, "pw": 1920, "ph": 1440, "gy": 13.49, "hero": [-24.2, -8.5], "zones": [{"x": -10, "z": -30, "r": 14, "ttl_left": 90}],
                "vp": [0.01462, 0, -0.01462, 0.22775, 0.01597, 0.01581, 0.01597, 0.24656, 0.00081, -0.00164, 0.00081, -0.77928, 0, 0, 0, 1]}
        mk = {"pw": 1920, "ph": 1440, "pts": [{"t": "hero", "x": 957, "y": 765, "w": 1920, "h": 1440, "c": "#0ff"}, {"t": "castle", "x": 1201, "y": 196, "w": 1920, "h": 1440, "c": "#fff"}],
              "ln": [[957, 765], [1100, 600]]}
        with h.ws() as ws:
            collect(ws, 2, timeout=3)
            json.dump(view, open(os.path.join(h.agent, "view.json"), "w"))
            time.sleep(0.15)
            json.dump(mk, open(os.path.join(h.agent, "markers.json"), "w"))
            got = {}
            end = time.time() + 5
            while time.time() < end and ("view" not in got or "mk" not in got):
                m = ws.recv(timeout=2)
                if isinstance(m, str):
                    d = json.loads(m)
                    if d.get("type") in ("view", "mk"):
                        got[d["type"]] = d
                else:
                    ws.send(json.dumps({"ack": parse_frame(m)["seq"]}))
        check("view.json is pushed to the client when it changes", "view" in got and got["view"]["vp"][0] == 0.01462 and got["view"]["zones"][0]["r"] == 14, got.get("view"))
        pts = got.get("mk", {}).get("pts", [])
        check("markers.json is pushed with a WORLD position added to every point", len(pts) == 2 and all("wx" in p and "wz" in p for p in pts), pts)
        v = view["vp"]
        p = pts[0]
        nx = v[0] * p["wx"] + v[1] * 13.49 + v[2] * p["wz"] + v[3]
        ny = v[4] * p["wx"] + v[5] * 13.49 + v[6] * p["wz"] + v[7]
        px, py = (nx * .5 + .5) * 1920, (1 - (ny * .5 + .5)) * 1440
        check("re-projecting that world position with the same camera reproduces the screen pixel (within 1.5 px)", abs(px - 957) < 1.5 and abs(py - 765) < 1.5, (px, py))
        check("the nav-path polyline gets world points too", len(got["mk"].get("lw", [])) == 2 and all(q for q in got["mk"]["lw"]), got["mk"].get("lw"))
        # a client that connects LATER gets the current overlay immediately
        with h.ws() as ws2:
            _, texts = collect(ws2, 1, timeout=3)
        check("a late joiner receives the latest view + markers right away", {"view", "mk"} <= {t.get("type") for t in texts}, [t.get("type") for t in texts])
        # garbage in the files must not hurt
        open(os.path.join(h.agent, "view.json"), "w").write("{not json")
        time.sleep(0.3)
        os.remove(os.path.join(h.agent, "markers.json"))
        time.sleep(0.3)
        with h.ws() as ws3:
            f, _ = collect(ws3, 3, timeout=4)
        check("malformed / missing overlay files are ignored; video keeps flowing", len(f) == 3, len(f))
    finally:
        h.close()


# ------------------------------------------------------------------------------------------------------------------------ sources
def jpeg_file(path, color=(10, 120, 200), size=(1920, 1440)):
    img = np.full((size[1], size[0], 3), color, np.uint8)
    ok, enc = cv2.imencode(".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, 70])
    tmp = path + ".tmp"
    open(tmp, "wb").write(enc.tobytes())
    for _ in range(20):                                           # livecap may have the file open for a moment (Windows refuses the rename)
        try:
            os.replace(tmp, path)
            break
        except PermissionError:
            time.sleep(0.02)
    return enc.tobytes()


def test_plugin_file_fallback():
    h = Harness("auto")                                           # no game window, no ffmpeg
    try:
        time.sleep(0.8)
        st = json.loads(h.http("/stats")[1])
        check("no window and no plugin frame: state says the game is not running", st["state"] in ("no-window", "minimized") and st["frame_age_s"] is None, (st["state"], st["detail"]))
        p = os.path.join(h.agent, "live.jpg")
        stop = threading.Event()

        def toucher():                                                # the plugin rewrites live.jpg every ~0.25 s
            n = 0
            while not stop.is_set():
                jpeg_file(p, color=(10 + n % 200, 120, 200))
                n += 1
                time.sleep(0.3)
        tt = threading.Thread(target=toucher, daemon=True)
        tt.start()
        with h.ws() as ws:
            frames, texts = collect(ws, 3, timeout=6)
            st = state_of(h)
        check("a fresh live.jpg from the plugin is served as the fallback feed, flagged as such", len(frames) >= 2 and frames[0]["flags"] & lc.FLAG_PLUGIN and (frames[0]["w"], frames[0]["h"]) == (1920, 1440), [(f["flags"], f["w"]) for f in frames])
        check("state is 'plugin' while that feed is fresh", st["state"] == "plugin" and st["source"] == "plugin", (st["state"], st["source"]))
        stop.set()
        tt.join(2)
        os.utime(p, (time.time() - 30, time.time() - 30))
        time.sleep(0.8)
        st = json.loads(h.http("/stats")[1])
        check("a stale plugin frame (>3 s) is NOT passed off as live: state falls back to no-window", st["state"] == "no-window", st["state"])
        n0 = h.hub.cap_gaps.total
        open(p, "wb").write(b"\xff\xd8\xff\xe0 truncated")        # a half-written file
        os.utime(p, (time.time(), time.time()))
        time.sleep(0.8)
        check("a half-written live.jpg is ignored", h.hub.cap_gaps.total == n0, (n0, h.hub.cap_gaps.total))
    finally:
        h.close()


GAME = (4242, {"hwnd": 4242, "cw": 1920, "ch": 1440, "iconic": False, "visible": True, "exe": "thronefall.exe"})


def patch_fake_ffmpeg():
    class Fake(lc.WgcCapture):
        def command(self, port):
            return [sys.executable, FAKE_FFMPEG, "tcp://127.0.0.1:%d" % port]
    orig = lc.WgcCapture
    lc.WgcCapture = Fake
    return orig


def test_wgc_manager():
    orig = patch_fake_ffmpeg()
    try:
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="ok")
        try:
            with h.ws() as ws:
                frames, texts = collect(ws, 15, timeout=12)
            st = json.loads(h.http("/stats")[1])
            check("game window present: the capture process is started and frames flow", len(frames) >= 10 and st["state"] == "wgc" and st["source"] == "wgc", (len(frames), st["state"]))
            check("frames carry no plugin flag", all(not f["flags"] & lc.FLAG_PLUGIN for f in frames))
            check("output size follows the window aspect (640 wide, 4:3)", st["cfg"]["out"] == [640, 480], st["cfg"]["out"])
            check("stats expose the capture process pid", st["capture"]["ffmpeg_pid"], st["capture"])
            # window disappears -> capture stops, state says so
            h.cfg.window_finder = lambda: (None, {})
            time.sleep(1.2)
            st = json.loads(h.http("/stats")[1])
            check("window gone: capture process stopped, state no-window", st["state"] == "no-window" and st["capture"]["ffmpeg_pid"] is None, (st["state"], st["capture"]["ffmpeg_pid"]))
            # minimised
            h.cfg.window_finder = lambda: (4242, dict(GAME[1], iconic=True, cw=0, ch=0))
            time.sleep(1.0)
            st = json.loads(h.http("/stats")[1])
            check("minimised window: state 'minimized' with an explanation (WGC cannot capture it)", st["state"] == "minimized" and "minimised" in st["detail"], (st["state"], st["detail"]))
            # back again -> restarts
            h.cfg.window_finder = lambda: (4242, dict(GAME[1]))
            st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" and d["capture"]["fps"] > 3 else None)(state_of(h)), 15)
            check("window back: capture restarts by itself", bool(st), state_of(h)["state"])
        finally:
            h.close()
        # the capture process dies by itself -> restarted with backoff, counted
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="die_after:8")
        try:
            end = time.time() + 14
            st = {}
            while time.time() < end:
                time.sleep(0.5)
                st = json.loads(h.http("/stats")[1])
                if st["capture"]["restarts"] >= 2:
                    break
            check("a dying capture process is restarted (restarts counter >= 2) instead of leaving the picture dead", st["capture"]["restarts"] >= 2, st["capture"])
            check("... and frames came from every incarnation", st["capture"]["frames"] >= 16, st["capture"]["frames"])
        finally:
            h.close()
        # leading garbage before the first MJPEG part is skipped (resync)
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="garbage_then_ok")
        try:
            with h.ws() as ws:
                frames, _ = collect(ws, 5, timeout=10)
            check("garbage before the first MJPEG part is skipped (the parser resyncs)", len(frames) >= 5, len(frames))
        finally:
            h.close()
        # capture cannot start at all
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="noconnect")
        try:
            st = wait_for(lambda: (lambda d: d if d["state"] not in ("starting",) else None)(state_of(h)), 10)
            check("capture that cannot start: honest error state (with the reason) and no crash", bool(st) and st["state"] == "error" and "exited" in st["detail"], st and (st["state"], st["detail"]))
            t0 = time.time()
            check("... and it failed FAST (the capture process died, nobody waits out a 12 s timeout)", time.time() - t0 < 5)
        finally:
            h.close()
    finally:
        lc.WgcCapture = orig


# ------------------------------------------------------------------------------------------------------------------------ in-game ingest
def rgba_frame(w, h, n=0):
    img = np.zeros((h, w, 4), np.uint8)
    img[..., 3] = 255
    img[: h // 8, :, 0] = 255              # red band at the TOP
    img[-h // 8:, :, 2] = 255              # blue band at the BOTTOM
    img[h // 2 - 20: h // 2 + 20, 10 + n * 4 % (w - 60): 50 + n * 4 % (w - 60), 1] = 255
    return img[::-1].copy()                # rows bottom-to-top like Unity's readback


def plugin_connect(port, build="test-1"):
    s = socket.create_connection(("127.0.0.1", port), timeout=5)
    s.sendall(("TFGAME1 " + json.dumps({"build": build, "pid": 1, "w": 1920, "h": 1440, "unity": "2022.3"}) + "\n").encode())
    return s


def send_frame(s, w, h, n, meta=None, fmt=1):
    payload = rgba_frame(w, h, n).tobytes() if fmt == 1 else rgba_frame(w, h, n)[::-1, :, [2, 1, 0, 3]].tobytes()
    m = json.dumps(meta or {}).encode()
    s.sendall(lc.INGEST_HDR.pack(b"TFRM", len(m), w, h, fmt, time.time() * 1000, n, len(payload)) + m + payload)


def test_game_ingest():
    h = Harness("auto", ingest=0, width=480)
    try:
        port = h.hub.game.port
        s = plugin_connect(port)
        meta = {"pw": 1920, "ph": 1440, "vp": [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1], "gy": 13.5, "scene": "Frostsee"}
        stop_send = threading.Event()

        def pump():                                                   # the plugin keeps sending while we look at it
            n = 0
            while not stop_send.is_set():
                try:
                    send_frame(s, 640, 480, n, meta)
                except OSError:
                    return
                n += 1
                time.sleep(0.03)
        threading.Thread(target=pump, daemon=True).start()
        with h.ws() as ws:
            time.sleep(0.5)
            frames, texts = collect(ws, 5, timeout=6)
            check("frames pushed by the plugin come out of the WebSocket flagged FLAG_GAME", len(frames) >= 3 and all(f["flags"] & lc.FLAG_GAME for f in frames), [f["flags"] for f in frames])
            f = frames[-1]
            img = decode(f["jpeg"])
            check("picture was downscaled to the configured width (480) keeping 4:3", img.shape[1] == 480 and img.shape[0] == 360, img.shape)
            top, bot = img[20, img.shape[1] // 2], img[-20, img.shape[1] // 2]
            check("orientation: bottom-to-top RGBA rows come out UPRIGHT (red band on top, blue at the bottom)", top[2] > 200 and top[0] < 60 and bot[0] > 200 and bot[2] < 60, (top, bot))
            m = json.loads(f["meta"]) if f["meta"] else {}
            check("the per-frame camera/meta from the plugin rides along with the frame", m.get("gy") == 13.5 and len(m.get("vp", [])) == 16 and m.get("scene") == "Frostsee", m)
            st = json.loads(h.http("/stats")[1])
            check("state becomes 'game' and stats describe the plugin", st["state"] == "game" and st["source"] == "game" and st["game"]["connected"] and st["game"]["build"] == "test-1", (st["state"], st["game"]))
            # control messages: the plugin is told what fps / width the viewers want
            s.settimeout(3)
            h.hub.settings_t = 0
            h.hub.apply_settings({"fps": 25, "width": 960})
            got = []
            end = time.time() + 3
            s.setblocking(False)
            while time.time() < end and not any(b'"fps": 25' in g for g in got):
                try:
                    d = s.recv(4096)
                    if d:
                        got.append(d)
                except (BlockingIOError, OSError):
                    time.sleep(0.05)
            lines = b"".join(got).split(b"\n")
            check("livecap sends the requested capture fps/width to the plugin as a JSON control line", any(b'"cap"' in l and b'"fps": 25' in l and b'"w": 960' in l for l in lines), lines[-3:])
        stop_send.set()
        time.sleep(0.2)
        # BGRA top-down is accepted too
        before = h.hub.game.frames
        s2 = plugin_connect(port, "test-2")
        for n in range(5):
            send_frame(s2, 320, 240, n, fmt=2)
            time.sleep(0.05)
        time.sleep(0.5)
        check("a new plugin connection replaces the old one; BGRA top-down frames are accepted", h.hub.game.info.get("build") == "test-2" and h.hub.game.frames >= before + 5, (h.hub.game.info, before, h.hub.game.frames))
        # corrupt header -> that connection is dropped, the listener keeps working
        bad = plugin_connect(port, "test-3")
        bad.sendall(b"NOPE" + b"\x00" * 60)
        time.sleep(0.6)
        check("a corrupt frame header drops the connection and is counted; the listener stays up", h.hub.game.bad >= 1, h.hub.game.bad)
        ok = plugin_connect(port, "test-4")
        send_frame(ok, 320, 240, 0)
        time.sleep(0.4)
        check("... and a later well-formed plugin is accepted again", h.hub.game.info.get("build") == "test-4" and h.hub.game.connected)
        # plugin goes away -> state no longer 'game'
        ok.close()
        s.close()
        s2.close()
        bad.close()
        time.sleep(2.2)
        st = json.loads(h.http("/stats")[1])
        check("when the plugin disconnects the state leaves 'game' (falls back to WGC / plugin files / no-window)", st["state"] != "game" and not st["game"]["connected"], (st["state"], st["game"]))
    finally:
        h.close()


def test_game_beats_wgc():
    orig = patch_fake_ffmpeg()
    try:
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="ok", ingest=0)
        try:
            st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" else None)(state_of(h)), 15)
            check("precondition: WGC feed running", bool(st), state_of(h)["state"])
            s = plugin_connect(h.hub.game.port)
            for n in range(60):
                send_frame(s, 320, 240, n)
                time.sleep(0.03)
            st = json.loads(h.http("/stats")[1])
            check("the in-game feed takes over from WGC while it flows, and WGC's ffmpeg is stopped (no duplicate capture)", st["state"] == "game" and st["capture"]["ffmpeg_pid"] is None, (st["state"], st["capture"]["ffmpeg_pid"]))
            s.close()
            time.sleep(2.0)
            st = state_of(h)
            check("as soon as the plugin feed stops the state says so (starting window capture), not a stale 'game'", st["state"] in ("starting", "wgc"), st["state"])
            st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" else None)(state_of(h)), 15)
            check("... and WGC resumes by itself", bool(st), state_of(h)["state"])
        finally:
            h.close()
    finally:
        lc.WgcCapture = orig


def test_idle_pause():
    orig = patch_fake_ffmpeg()
    try:
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="ok", ingest=0, idle=1.5)
        try:
            st = wait_for(lambda: (lambda d: d if d["state"] == "idle" and d["capture"]["ffmpeg_pid"] is None else None)(state_of(h)), 15)
            check("nobody watching: after the grace period the capture process is stopped and the state says why (idle)", bool(st), state_of(h)["state"])
            check("idle costs nothing: no ffmpeg process while nobody watches", st and st["capture"]["ffmpeg_pid"] is None)
            # a viewer connects -> capture starts by itself and frames flow
            with h.ws() as ws:
                frames, texts = collect(ws, 10, timeout=15)
                check("a viewer connecting wakes the capture; frames flow", len(frames) >= 8, len(frames))
                st = state_of(h)
                check("state is wgc while watched", st["state"] == "wgc", st["state"])
            st = wait_for(lambda: (lambda d: d if d["state"] == "idle" else None)(state_of(h)), 15)
            check("the last viewer leaves: capture pauses again", bool(st), state_of(h)["state"])
            # a snapshot request (vision model / Save frame) wakes it for a moment
            t0 = time.time()
            s, body, hd = h.http("/frame.jpg")
            check("GET /frame.jpg while idle wakes the capture and returns a FRESH frame", s == 200 and body[:2] == b"\xff\xd8" and decode(body) is not None, (s, len(body)))
            print("   (idle -> fresh frame in %.1f s)" % (time.time() - t0))
            st = wait_for(lambda: (lambda d: d if d["state"] == "idle" else None)(state_of(h)), 15)
            check("... and it goes back to idle afterwards", bool(st), state_of(h)["state"])
            # the plugin is told to pause / resume its in-game capture
            s = plugin_connect(h.hub.game.port, "idle-test")
            s.setblocking(False)
            got = b""
            end = time.time() + 6
            while time.time() < end and b"paused" not in got:
                try:
                    got += s.recv(4096)
                except (BlockingIOError, OSError):
                    time.sleep(0.05)
            check("the plugin's control line carries paused=true while nobody watches", b'"paused": true' in got, got[-120:])
            with h.ws():
                end = time.time() + 6
                while time.time() < end and b'"paused": false' not in got:
                    try:
                        got += s.recv(4096)
                    except (BlockingIOError, OSError):
                        time.sleep(0.05)
                check("... and paused=false the moment a viewer connects", b'"paused": false' in got, got[-160:])
            s.close()
        finally:
            h.close()
        # idle_s = 0 turns the feature off
        h = Harness("auto", window=GAME, ffmpeg="fake-ffmpeg", fake_mode="ok", idle=0.0)
        try:
            st = wait_for(lambda: (lambda d: d if d["state"] == "wgc" else None)(state_of(h)), 15)
            time.sleep(3.0)
            check("idle_s=0: capture keeps running without viewers", bool(st) and state_of(h)["state"] == "wgc", state_of(h)["state"])
        finally:
            h.close()
    finally:
        lc.WgcCapture = orig


def main():
    for fn in (test_helpers, test_stream_basics, test_flow_control, test_http_and_security, test_settings, test_overlay, test_plugin_file_fallback, test_wgc_manager,
               test_game_ingest, test_game_beats_wgc, test_idle_pause):
        t0 = time.time()
        try:
            fn()
        except Exception:
            import traceback
            traceback.print_exc()
            FAILS.append(fn.__name__)
        print("   (%s: %.1fs)" % (fn.__name__, time.time() - t0))
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
