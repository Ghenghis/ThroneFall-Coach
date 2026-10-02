#!/usr/bin/env python3
"""livecap - the Live View's video + overlay hub.  A separate process, so a coach-server restart (or a stalled Python thread in it)
never freezes the picture.

  game window --(Windows Graphics Capture via ffmpeg's `gfxcapture`, GPU scaled, native MJPEG)--> livecap --WebSocket--> browser worker canvas
  agent/view.json + markers.json (camera matrix, hero, zones, doors...) ------------------------^      (overlay drawn in sync with the frame)

Why this and not the old in-process BitBlt grabber:
  * BitBlt/PrintWindow of a window DC returns whatever is ON SCREEN there when the game window is covered (the Coach page itself ->
    the infinite "picture of the picture"); WGC captures the game's own composed surface even when other windows cover it.
  * ffmpeg does the scaling (GPU), colour conversion and JPEG encoding in native code in its own process: no GIL, ~no CPU.
  * delivery is a push WebSocket with ack-based flow control and latest-frame-wins: a slow browser can never build up a seconds-long
    backlog (the MJPEG-over-HTTP failure mode), and every frame carries its capture time so the page can show the real latency.

Endpoints (127.0.0.1 only):
  ws://127.0.0.1:8097/ws      binary frames + JSON events (see PROTOCOL below)
  GET /stats                  JSON: capture fps, gaps, clients (incl. what the browsers report they actually drew), ffmpeg state
  GET /frame.jpg  /frame.png  latest frame (for snapshots / vision); GET /live.js and GET / (standalone full-window viewer)

PROTOCOL  server -> client binary frame:  'T' u8 | type u8 (1=frame) | flags u16 | seq u32 | t_srv_ms f64 | w u16 | h u16 | meta_len u16 | meta json | JPEG
          server -> client text (JSON): hello, view, mk, state, pong        client -> server text (JSON): ack, set, ping, hello, stats
"""
import argparse
import asyncio
import collections
import ctypes
import json
import os
import re
import shutil
import socket
import struct
import subprocess
import sys
import threading
import time
import traceback

VERSION = "livecap-1.0"
HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_AGENT = os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent")
ORIGIN_RE = re.compile(r"^https?://(127\.0\.0\.1|localhost|\[::1\])(:\d+)?$")
HDR = re.compile(rb"--ffmpeg\r\nContent-type: image/jpeg\r\nContent-length: (\d+)\r\n\r\n", re.I)
GAME_TITLE = os.environ.get("LIVECAP_TITLE", "Thronefall")        # what the game window is called (overridable: the tests capture a stand-in window)
GAME_CLASS = os.environ.get("LIVECAP_CLASS", "UnityWndClass")
GAME_EXE = os.environ.get("LIVECAP_EXE", "thronefall.exe")        # "" = do not check the process name
MAX_INFLIGHT = 3            # frames the browser may still owe an ack for before we stop sending (latest-frame-wins beyond that)
FRAME_HDR = struct.Struct("<BBHIdHHH")   # magic, type, flags, seq, t_srv_ms, w, h, meta_len  (22 bytes)
FLAG_PLUGIN = 1             # frame came from the plugin's own screenshot files (fallback), not from WGC
FLAG_RESEND = 2             # re-sent latest frame for a client that just connected
FLAG_GAME = 4               # frame rendered INSIDE the game and pushed by the plugin (works minimised/covered; carries the exact camera matrix)
INGEST_HDR = struct.Struct("<4sIIIIdII")   # magic 'TFRM', meta_len, w, h, fmt, t_game_ms, seq, payload_len  (36 bytes) - plugin -> livecap


def now_ms():
    return time.time() * 1000.0


def log(*a):
    line = "%s [livecap] %s" % (time.strftime("%H:%M:%S"), " ".join(str(x) for x in a))
    try:
        print(line, flush=True)
    except Exception:
        pass
    p = LOGFILE[0]
    if p:
        try:
            if os.path.exists(p) and os.path.getsize(p) > 1_000_000:
                os.replace(p, p + ".old")
            with open(p, "a", encoding="utf-8") as f:
                f.write(line + "\n")
        except OSError:
            pass


LOGFILE = [None]


# ------------------------------------------------------------------------------------------------------------- Windows helpers
if sys.platform == "win32":
    import ctypes.wintypes as wt
    user32 = ctypes.WinDLL("user32", use_last_error=True)
    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    _VP = ctypes.c_void_p
    user32.FindWindowW.argtypes = [wt.LPCWSTR, wt.LPCWSTR]
    user32.FindWindowW.restype = _VP
    user32.IsWindow.argtypes = [_VP]
    user32.IsWindow.restype = wt.BOOL
    user32.IsIconic.argtypes = [_VP]
    user32.IsIconic.restype = wt.BOOL
    user32.IsWindowVisible.argtypes = [_VP]
    user32.IsWindowVisible.restype = wt.BOOL
    user32.GetClientRect.argtypes = [_VP, ctypes.POINTER(wt.RECT)]
    user32.GetClientRect.restype = wt.BOOL
    user32.GetWindowThreadProcessId.argtypes = [_VP, ctypes.POINTER(wt.DWORD)]
    user32.GetWindowThreadProcessId.restype = wt.DWORD
    kernel32.OpenProcess.argtypes = [wt.DWORD, wt.BOOL, wt.DWORD]
    kernel32.OpenProcess.restype = _VP
    kernel32.QueryFullProcessImageNameW.argtypes = [_VP, wt.DWORD, wt.LPWSTR, ctypes.POINTER(wt.DWORD)]
    kernel32.QueryFullProcessImageNameW.restype = wt.BOOL
    kernel32.CloseHandle.argtypes = [_VP]
    kernel32.CreateJobObjectW.argtypes = [_VP, wt.LPCWSTR]
    kernel32.CreateJobObjectW.restype = _VP
    kernel32.SetInformationJobObject.argtypes = [_VP, ctypes.c_int, _VP, wt.DWORD]
    kernel32.SetInformationJobObject.restype = wt.BOOL
    kernel32.AssignProcessToJobObject.argtypes = [_VP, _VP]
    kernel32.AssignProcessToJobObject.restype = wt.BOOL
    try:                                                      # physical pixels, not DPI-virtualised ones (the game is 1920x1440 on a 150% desktop)
        user32.SetProcessDpiAwarenessContext(ctypes.c_void_p(-4))
    except Exception:
        pass

    class _IO(ctypes.Structure):
        _fields_ = [("a", ctypes.c_ulonglong)] * 6

    class _BASIC(ctypes.Structure):
        _fields_ = [("PerProcessUserTimeLimit", ctypes.c_longlong), ("PerJobUserTimeLimit", ctypes.c_longlong), ("LimitFlags", wt.DWORD),
                    ("MinimumWorkingSetSize", ctypes.c_size_t), ("MaximumWorkingSetSize", ctypes.c_size_t), ("ActiveProcessLimit", wt.DWORD),
                    ("Affinity", ctypes.c_size_t), ("PriorityClass", wt.DWORD), ("SchedulingClass", wt.DWORD)]

    class _EXT(ctypes.Structure):
        _fields_ = [("Basic", _BASIC), ("Io", _IO), ("ProcessMemoryLimit", ctypes.c_size_t), ("JobMemoryLimit", ctypes.c_size_t),
                    ("PeakProcessMemoryUsed", ctypes.c_size_t), ("PeakJobMemoryUsed", ctypes.c_size_t)]


class KillOnExitJob:
    """Windows job object: every process assigned to it is killed when livecap exits (no orphan ffmpeg, whatever way we die)."""

    def __init__(self):
        self.h = None
        if sys.platform != "win32":
            return
        try:
            h = kernel32.CreateJobObjectW(None, None)
            info = _EXT()
            info.Basic.LimitFlags = 0x2000                    # JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE
            if h and kernel32.SetInformationJobObject(h, 9, ctypes.byref(info), ctypes.sizeof(info)):
                self.h = h
        except Exception as ex:
            log("job object unavailable:", ex)

    def add(self, proc):
        if self.h:
            try:
                kernel32.AssignProcessToJobObject(self.h, int(proc._handle))
            except Exception:
                pass


def exe_of(hwnd):
    pid = wt.DWORD(0)
    user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
    h = kernel32.OpenProcess(0x1000, False, pid.value)       # PROCESS_QUERY_LIMITED_INFORMATION
    if not h:
        return ""
    try:
        buf = ctypes.create_unicode_buffer(520)
        n = wt.DWORD(520)
        return os.path.basename(buf.value) if kernel32.QueryFullProcessImageNameW(h, 0, buf, ctypes.byref(n)) else ""
    finally:
        kernel32.CloseHandle(h)


def find_game_window():
    """(hwnd, info) of the Thronefall game window or (None, {}). Exact title + Unity class + exe name, so a browser tab titled
    'Thronefall Coach' can never be mistaken for the game."""
    if sys.platform != "win32":
        return None, {}
    h = user32.FindWindowW(GAME_CLASS or None, GAME_TITLE) or user32.FindWindowW(None, GAME_TITLE)
    if not h:
        return None, {}
    h = int(h)
    exe = exe_of(h)
    if exe and GAME_EXE and exe.lower() != GAME_EXE.lower():
        return None, {}
    rc = wt.RECT()
    user32.GetClientRect(h, ctypes.byref(rc))
    return h, {"hwnd": h, "cw": rc.right, "ch": rc.bottom, "iconic": bool(user32.IsIconic(h)), "visible": bool(user32.IsWindowVisible(h)), "exe": exe}


def jpeg_size(b):
    """(w, h) from the first SOF marker, or None."""
    i, n = 2, len(b)
    while i + 9 < n:
        if b[i] != 0xFF:
            i += 1
            continue
        m = b[i + 1]
        if m in (0xC0, 0xC1, 0xC2):
            return (b[i + 7] << 8) | b[i + 8], (b[i + 5] << 8) | b[i + 6]
        if m == 0xD8 or m == 0x01 or 0xD0 <= m <= 0xD9 or m == 0xFF:
            i += 2 if m != 0xFF else 1
            continue
        i += 2 + ((b[i + 2] << 8) | b[i + 3])
    return None


# ------------------------------------------------------------------------------------------------------------- stats helpers
class Gaps:
    """Rolling inter-event gaps -> fps and percentiles."""

    def __init__(self, n=300):
        self.t = collections.deque(maxlen=n)
        self.total = 0

    def add(self, t=None):
        self.t.append(time.perf_counter() if t is None else t)
        self.total += 1

    def fps(self, window=2.0):
        now = time.perf_counter()
        k = sum(1 for x in self.t if now - x <= window)
        return k / window if k else 0.0

    def gaps_ms(self):
        v = list(self.t)
        return sorted((v[i] - v[i - 1]) * 1000 for i in range(1, len(v)))

    def summary(self):
        g = self.gaps_ms()
        if not g:
            return {"p50": None, "p95": None, "p99": None, "max": None}
        r = lambda q: round(g[min(len(g) - 1, int(len(g) * q))], 1)
        return {"p50": r(0.5), "p95": r(0.95), "p99": r(0.99), "max": round(g[-1], 1)}


class Frame:
    __slots__ = ("seq", "t_ms", "jpeg", "w", "h", "flags", "meta")

    def __init__(self, seq, t_ms, jpeg, w, h, flags, meta=b""):
        self.seq, self.t_ms, self.jpeg, self.w, self.h, self.flags, self.meta = seq, t_ms, jpeg, w, h, flags, meta


# ------------------------------------------------------------------------------------------------------------- capture sources
class WgcCapture:
    """One ffmpeg process = one capture session (window handle + output size + fps + quality). Frames come back as MJPEG parts over a
    loopback TCP socket (a Windows anonymous pipe has a 4 KB buffer and measurably throttles 100 KB frames)."""

    def __init__(self, ffmpeg, hwnd, w, h, fps, quality, on_frame, job):
        self.ffmpeg, self.hwnd, self.w, self.h, self.fps, self.quality = ffmpeg, hwnd, w, h, fps, quality
        self.on_frame, self.job = on_frame, job
        self.proc = None
        self.thread = None
        self.dead = threading.Event()
        self.err = collections.deque(maxlen=12)
        self.started = time.time()
        self.last_frame = 0.0
        self.frames = 0

    def filter(self):
        return ("gfxcapture=hwnd=%d:capture_cursor=0:max_framerate=%d:width=%d:height=%d:resize_mode=scale:scale_mode=bicubic,"
                "hwdownload,format=bgra,format=yuvj420p" % (self.hwnd, self.fps, self.w, self.h))

    def command(self, port):
        """The capture process command line (a method so the tests can substitute a fake)."""
        return [self.ffmpeg, "-hide_banner", "-loglevel", "error", "-nostats", "-nostdin", "-f", "lavfi", "-i", self.filter(), "-c:v", "mjpeg",
                "-q:v", str(self.quality), "-fps_mode", "passthrough", "-flush_packets", "1", "-f", "mpjpeg", "tcp://127.0.0.1:%d" % port]

    def start(self):
        srv = socket.socket()
        srv.bind(("127.0.0.1", 0))
        srv.listen(1)
        cmd = self.command(srv.getsockname()[1])
        flags = 0x08000000 if sys.platform == "win32" else 0            # CREATE_NO_WINDOW
        self.proc = subprocess.Popen(cmd, stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, creationflags=flags)
        self.job.add(self.proc)
        threading.Thread(target=self._drain_stderr, daemon=True, name="ffmpeg-err").start()
        srv.settimeout(0.25)
        deadline = time.time() + 12
        conn = None
        try:
            while conn is None:
                try:
                    conn, _ = srv.accept()
                except socket.timeout:
                    if self.proc.poll() is not None:                      # died before connecting (bad filter, no such window...): fail NOW, not after 12 s
                        time.sleep(0.2)                                   # let the stderr reader catch the last lines
                        raise RuntimeError("ffmpeg exited (code %s) before connecting: %s" % (self.proc.returncode, "; ".join(self.err) or "no output"))
                    if time.time() > deadline:
                        raise RuntimeError("ffmpeg did not connect within 12 s (%s)" % ("; ".join(self.err) or "no output"))
        except Exception:
            self.stop()
            raise
        finally:
            srv.close()
        conn.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 4 << 20)
        conn.settimeout(5)
        self.thread = threading.Thread(target=self._read, args=(conn,), daemon=True, name="wgc-reader")
        self.thread.start()

    def _drain_stderr(self):
        try:
            for line in iter(self.proc.stderr.readline, b""):
                s = line.decode("utf8", "replace").strip()
                if s and "deprecated pixel format" not in s:
                    self.err.append(s[:200])
        except Exception:
            pass

    def _read(self, conn):
        buf = bytearray()
        try:
            while not self.dead.is_set():
                try:
                    chunk = conn.recv(1 << 20)
                except socket.timeout:
                    if self.proc.poll() is not None:
                        break
                    continue                                          # a static scene produces no frames - not an error
                if not chunk:
                    break
                buf += chunk
                while True:
                    i = 0
                    while i < len(buf) and buf[i] in (13, 10):
                        i += 1
                    if i:
                        del buf[:i]
                    m = HDR.match(buf)
                    if not m:
                        if len(buf) > 8192:                           # lost sync: skip to the next part boundary
                            j = buf.find(b"--ffmpeg", 1)
                            del buf[:j if j > 0 else len(buf)]
                        break
                    end = m.end() + int(m.group(1))
                    if len(buf) < end:
                        break
                    jpeg = bytes(buf[m.end():end])
                    del buf[:end]
                    self.frames += 1
                    self.last_frame = time.time()
                    self.on_frame(jpeg, self.w, self.h)
        except Exception as ex:
            self.err.append("reader: %s" % ex)
        finally:
            self.dead.set()
            try:
                conn.close()
            except OSError:
                pass

    def alive(self):
        return self.proc is not None and self.proc.poll() is None and not self.dead.is_set()

    def stop(self):
        self.dead.set()
        p = self.proc
        if p and p.poll() is None:
            try:
                p.kill()
                p.wait(3)
            except Exception:
                pass


class SyntheticSource(threading.Thread):
    """Moving test pattern with a frame counter (no game needed): used by the tests, --selftest and the browser E2E."""

    def __init__(self, hub, fps=30, w=1280, h=960):
        super().__init__(daemon=True, name="synthetic")
        self.hub, self.fps, self.w, self.h = hub, fps, w, h
        self.stop_ev = threading.Event()

    def run(self):
        import cv2
        import numpy as np
        n = 0
        t0 = time.perf_counter()
        yy, xx = np.mgrid[0:self.h, 0:self.w]
        base = np.zeros((self.h, self.w, 3), np.uint8)
        base[..., 0] = (xx * 255 // self.w).astype(np.uint8)
        base[..., 1] = (yy * 255 // self.h).astype(np.uint8)
        base[..., 2] = 60
        while not self.stop_ev.is_set():
            img = base.copy()
            cx = int((0.5 + 0.4 * np.sin(n / 20.0)) * self.w)
            cy = int((0.5 + 0.4 * np.cos(n / 27.0)) * self.h)
            cv2.circle(img, (cx, cy), 60, (255, 255, 255), -1)
            cv2.putText(img, "SYN %06d" % n, (40, 120), cv2.FONT_HERSHEY_SIMPLEX, 3.0, (0, 255, 255), 6)
            ok, enc = cv2.imencode(".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, 80])
            if ok:
                self.hub.publish(enc.tobytes(), self.w, self.h, 0)
            n += 1
            nxt = t0 + n / self.fps
            d = nxt - time.perf_counter()
            if d > 0:
                time.sleep(d)
            elif d < -1.0:
                t0 = time.perf_counter() - n / self.fps


def jpeg_quality(qscale):
    """ffmpeg mjpeg qscale (2..31, lower = better) -> cv2/libjpeg quality (0..100) with about the same look and size."""
    return max(30, min(95, 100 - 3 * int(qscale)))


class _Reader:
    """Exact-length reads from a socket that has a timeout; a timeout BETWEEN messages is just 'nothing yet', inside one it is a dead peer."""

    def __init__(self, conn, stop_ev, partial_timeout=10.0):
        self.conn, self.stop_ev, self.partial_timeout = conn, stop_ev, partial_timeout

    def read_into(self, view):
        got, n = 0, len(view)
        last = time.time()
        while got < n:
            if self.stop_ev.is_set():
                raise OSError("stopping")
            try:
                k = self.conn.recv_into(view[got:], n - got)
            except socket.timeout:
                if got and time.time() - last > self.partial_timeout:
                    raise OSError("peer stalled mid-message")
                continue
            if not k:
                raise OSError("peer closed")
            got += k
            last = time.time()

    def read_exact(self, n):
        b = bytearray(n)
        self.read_into(memoryview(b))
        return bytes(b)

    def readline(self, limit=4096):
        out = bytearray()
        while len(out) < limit:
            c = self.read_exact(1)
            out += c
            if c == b"\n":
                return bytes(out)
        raise ValueError("line too long")


class GameIngest(threading.Thread):
    """TCP server the PLUGIN connects to and pushes raw frames into (the in-game capture: needs no window, works minimised or covered, and
    every frame carries the exact camera matrix it was rendered with). Raw RGBA -> cv2 (flip, BGR, optional resize) -> JPEG -> hub."""

    def __init__(self, hub, cfg):
        super().__init__(daemon=True, name="game-ingest")
        self.hub, self.cfg = hub, cfg
        self.stop_ev = threading.Event()
        self.sock = None
        self.conn = None
        self.info = {}
        self.connected = False
        self.last_frame = 0.0
        self.frames = 0
        self.bad = 0
        self.gaps = Gaps(240)
        self.proc_ms = collections.deque(maxlen=120)
        self.port = 0
        self.ctl_lock = threading.Lock()

    def bind(self):
        s = socket.socket()
        if hasattr(socket, "SO_EXCLUSIVEADDRUSE"):
            s.setsockopt(socket.SOL_SOCKET, socket.SO_EXCLUSIVEADDRUSE, 1)    # nobody else may share this port (Windows)
        s.bind(("127.0.0.1", self.cfg.ingest_port))
        s.listen(2)
        self.port = s.getsockname()[1]
        self.sock = s

    def fresh(self, within=1.5):
        return self.connected and (time.time() - self.last_frame) < within

    def send_control(self):
        """Tell the plugin how fast / how big to capture (it clamps), e.g. when a browser asks for 60 fps or a smaller picture."""
        with self.ctl_lock:
            c = self.conn
            if c is None:
                return
            try:
                c.sendall((json.dumps({"cap": {"fps": int(self.cfg.fps), "w": int(self.cfg.width), "paused": not self.hub.watched()}}) + "\n").encode())
            except OSError:
                pass

    def run(self):
        self.sock.settimeout(0.5)
        while not self.stop_ev.is_set():
            try:
                conn, _ = self.sock.accept()
            except socket.timeout:
                continue
            except OSError:
                break
            with self.ctl_lock:                                            # the newest connection wins (the game was restarted): drop the old one
                old, self.conn = self.conn, conn
            if old is not None:
                try:
                    old.shutdown(socket.SHUT_RDWR)
                    old.close()
                except OSError:
                    pass
            threading.Thread(target=self._run_conn, args=(conn,), daemon=True, name="game-ingest-conn").start()

    def _run_conn(self, conn):
        try:
            self.serve(conn)
        except Exception as ex:
            if self.conn is conn:
                log("ingest connection ended:", ex)
            else:
                log("ingest connection replaced by a newer one")
        finally:
            with self.ctl_lock:
                mine = self.conn is conn
                if mine:
                    self.conn = None
            if mine:
                self.connected = False
            try:
                conn.close()
            except OSError:
                pass

    def encode(self, payload, w, h, fmt):
        import cv2
        import numpy as np
        arr = np.frombuffer(payload, np.uint8).reshape(h, w, 3 if fmt == 3 else 4)
        if fmt == 1:
            img = cv2.cvtColor(cv2.flip(arr, 0), cv2.COLOR_RGBA2BGR)           # Unity readback is bottom-to-top
        elif fmt == 2:
            img = cv2.cvtColor(arr, cv2.COLOR_BGRA2BGR)
        else:
            img = cv2.cvtColor(cv2.flip(arr, 0), cv2.COLOR_RGB2BGR)
        tw = int(min(self.cfg.width, w)) // 2 * 2
        if tw < w:
            img = cv2.resize(img, (tw, max(2, int(round(tw * h / w / 2)) * 2)), interpolation=cv2.INTER_AREA)
        ok, enc = cv2.imencode(".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, jpeg_quality(self.cfg.quality)])
        if not ok:
            raise ValueError("jpeg encode failed")
        return enc.tobytes(), img.shape[1], img.shape[0]

    def serve(self, conn):
        conn.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 8 << 20)
        conn.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        conn.settimeout(1.0)
        rd = _Reader(conn, self.stop_ev)
        line = rd.readline()
        if not line.startswith(b"TFGAME1 "):
            raise ValueError("bad hello %r" % line[:40])
        self.info = json.loads(line[8:].decode("utf-8", "replace"))
        self.connected = True
        self.last_frame = time.time()
        log("plugin connected:", {k: self.info.get(k) for k in ("build", "pid", "w", "h", "unity")})
        self.send_control()
        buf = bytearray(1 << 20)
        while not self.stop_ev.is_set():
            hdr = rd.read_exact(INGEST_HDR.size)
            magic, mlen, w, h, fmt, t_ms, seq, plen = INGEST_HDR.unpack(hdr)
            if magic != b"TFRM" or mlen > 8192 or not (16 <= w <= 4096 and 16 <= h <= 4096) or fmt not in (1, 2, 3) or plen != w * h * (3 if fmt == 3 else 4):
                self.bad += 1
                raise ValueError("bad frame header magic=%r meta=%d %dx%d fmt=%d payload=%d" % (magic, mlen, w, h, fmt, plen))
            meta = rd.read_exact(mlen) if mlen else b""
            if len(buf) < plen:
                buf = bytearray(plen)
            rd.read_into(memoryview(buf)[:plen])
            t0 = time.perf_counter()
            jpeg, ow, oh = self.encode(memoryview(buf)[:plen], w, h, fmt)
            self.proc_ms.append((time.perf_counter() - t0) * 1000)
            self.frames += 1
            self.last_frame = time.time()
            self.gaps.add()
            self.hub.publish(jpeg, ow, oh, FLAG_GAME, meta if len(meta) <= 60000 else b"")

    def stats(self):
        pm = sorted(self.proc_ms)
        return {"listening": self.port, "connected": self.connected, "build": self.info.get("build"), "unity": self.info.get("unity"), "frames": self.frames, "bad": self.bad,
                "fps": round(self.gaps.fps(), 1), "gaps_ms": self.gaps.summary(), "convert_ms_p50": round(pm[len(pm) // 2], 1) if pm else None,
                "age_s": round(time.time() - self.last_frame, 2) if self.last_frame else None}


class SourceManager(threading.Thread):
    """Keeps the best available frame source running, best first: the plugin's in-game capture (GameIngest), WGC via ffmpeg while the game window
    can be captured, the plugin's own live.jpg (<= 4 fps) while neither works (game closed / ffmpeg missing)."""

    def __init__(self, hub, cfg):
        super().__init__(daemon=True, name="sources")
        self.hub, self.cfg = hub, cfg
        self.stop_ev = threading.Event()
        self.cap = None
        self.job = KillOnExitJob()
        self.state, self.detail = "starting", ""
        self.window = {}
        self.restarts = 0
        self.fail_streak = 0
        self.next_try = 0.0
        self.last_settings = None
        self.plugin_mtime = 0
        self.last_paused = False
        self.ffmpeg = cfg.ffmpeg or os.environ.get("LIVECAP_FFMPEG") or shutil.which("ffmpeg")

    def set_state(self, state, detail=""):
        if state != self.state or detail != self.detail:
            self.state, self.detail = state, detail
            log("state ->", state, detail)
            self.hub.state_changed()

    def settings(self, info):
        cw, ch = max(1, info.get("cw") or 1920), max(1, info.get("ch") or 1440)
        w = max(320, min(int(self.cfg.width), cw)) // 2 * 2
        h = max(2, int(round(w * ch / cw / 2)) * 2)
        return (info.get("hwnd"), w, h, int(self.cfg.fps), int(self.cfg.quality))

    def plugin_tick(self):
        """Publish the plugin's own screenshot (live.jpg, <= 4 fps) when it is new; True while that feed is fresh (< 3 s old)."""
        p = os.path.join(self.cfg.agent, "live.jpg")
        try:
            st = os.stat(p)
        except OSError:
            return False
        fresh = time.time() - st.st_mtime <= 3
        if fresh and st.st_mtime_ns != self.plugin_mtime:
            try:
                with open(p, "rb") as f:
                    b = f.read()
            except OSError:
                return fresh
            if len(b) < 1000 or b[:2] != b"\xff\xd8" or b[-2:] != b"\xff\xd9":
                return fresh                                              # being rewritten: next tick
            self.plugin_mtime = st.st_mtime_ns
            wh = jpeg_size(b) or (1920, 1440)
            self.hub.publish(b, wh[0], wh[1], FLAG_PLUGIN)
        return fresh

    def stop_wgc(self):
        if self.cap:
            self.cap.stop()
            self.cap = None

    def run(self):
        while not self.stop_ev.is_set():
            try:
                self.tick()
            except Exception as ex:
                log("source manager error:", ex, traceback.format_exc()[-400:])
                self.set_state("error", str(ex)[:120])
                time.sleep(1.0)
            time.sleep(0.2)
        self.stop_wgc()

    def tick(self):
        mode = self.cfg.source
        g = self.hub.game
        paused = not self.hub.watched()
        if g is not None and paused != self.last_paused:                  # tell the plugin to stop / resume its in-game capture too
            self.last_paused = paused
            g.send_control()
        if paused and mode != "plugin":
            self.stop_wgc()
            if not (g is not None and g.fresh(1.5)):
                self.set_state("idle", "no viewers - capture paused (resumes the moment one connects)")
                time.sleep(0.2)
                return
        elif self.state == "idle":
            self.set_state("starting", "a viewer connected - starting capture")
        if g is not None and g.fresh(1.5) and mode != "plugin":
            self.stop_wgc()                                               # the in-game feed is the best one there is: no ffmpeg needed while it flows
            self.set_state("game", "in-game capture from the plugin (%s)" % (g.info.get("build") or "?"))
            time.sleep(0.15)
            return
        if self.state == "game":
            self.set_state("starting", "the in-game feed stopped - switching to window capture")
        hwnd, info = (getattr(self.cfg, "window_finder", None) or find_game_window)()
        self.window = info
        if mode == "plugin" or not hwnd or info.get("iconic") or not info.get("visible", True):
            self.stop_wgc()
            why = "plugin feed requested" if mode == "plugin" else "game window not found" if not hwnd else "game window minimised" if info.get("iconic") else "game window hidden"
            fresh = self.plugin_tick()
            self.set_state("plugin" if fresh else ("no-window" if not hwnd else "minimized"), why + ("" if fresh else " - and no fresh plugin frame"))
            time.sleep(0.15)
            return
        if not self.ffmpeg:
            self.set_state("error", "ffmpeg not found (set LIVECAP_FFMPEG or --ffmpeg)")
            self.plugin_tick()
            time.sleep(1.0)
            return
        want = self.settings(info)
        if self.cap is not None and (not self.cap.alive() or want != self.last_settings):
            reason = "ffmpeg exited (%s)" % ("; ".join(self.cap.err) or "no message") if not self.cap.alive() else "settings changed"
            if not self.cap.alive():
                self.fail_streak += 1
                self.next_try = time.time() + min(10.0, 0.5 * 2 ** min(self.fail_streak, 5))
            log("capture restart:", reason)
            self.stop_wgc()
            self.restarts += 1
        if self.cap is None and time.time() >= self.next_try:
            if self.state != "starting":
                self.set_state("starting", "starting window capture")
            try:
                cap = WgcCapture(self.ffmpeg, want[0], want[1], want[2], want[3], want[4], self.on_wgc_frame, self.job)
                cap.start()
                self.cap, self.last_settings = cap, want
                log("capture started: hwnd=%d %dx%d @%d fps q%d (ffmpeg pid %d)" % (want[0], want[1], want[2], want[3], want[4], cap.proc.pid))
                self.hub.settings_changed(want[1], want[2])
            except Exception as ex:
                self.fail_streak += 1
                self.next_try = time.time() + min(10.0, 0.5 * 2 ** min(self.fail_streak, 5))
                self.set_state("error", "capture start failed: %s" % str(ex)[:160])
                self.plugin_tick()
                return
        if self.cap is not None:
            age = time.time() - max(self.cap.last_frame, self.cap.started)
            if self.cap.frames and age < 1.5:
                self.fail_streak = 0
                self.set_state("wgc", "")
            elif self.cap.frames:
                self.set_state("static", "no new frame for %.1fs (the game is not presenting - paused/static scene)" % age)
            else:
                self.set_state("starting", "waiting for the first frame (%.1fs)" % age)
                if age > 8:
                    self.cap.err.append("no frame within 8 s")
                    self.cap.stop()

    def on_wgc_frame(self, jpeg, w, h):
        self.hub.publish(jpeg, w, h, 0)


# ------------------------------------------------------------------------------------------------------------- the hub
class Client:
    _ids = 0

    def __init__(self, ws, loop):
        Client._ids += 1
        self.id = Client._ids
        self.ws, self.loop = ws, loop
        self.event = asyncio.Event()
        self.pending = collections.deque()              # seqs sent but not yet acked
        self.sent = self.skipped = self.acks = 0
        self.last_seq = -1
        self.last_ack_t = time.perf_counter()
        self.no_ack = False                             # a client that never acks (curl, simple test clients) is sent frames without the window
        self.sent_gaps = Gaps(120)
        self.report = {}
        self.since = time.time()
        self.info = {}


class Hub:
    def __init__(self, cfg, loop):
        self.cfg, self.loop = cfg, loop
        self.latest = None
        self.seq = 0
        self.clients = set()
        self.cap_gaps = Gaps(400)
        self.bytes_total = 0
        self.sizes = collections.deque(maxlen=120)
        self.started = time.time()
        self.sources = None
        self.view = None
        self.last_msg = {}                              # kind -> last JSON text (new clients get it immediately)
        self.mtimes = {}
        self.view_t = self.mk_t = 0.0
        self.png_cache = (0, b"")
        self.stop_ev = asyncio.Event()
        self.settings_t = 0.0
        self.out_wh = (0, 0)
        self.lock = threading.Lock()
        self.game = None                                # GameIngest (plugin's in-game capture), when enabled
        self.activity_t = time.time()                   # last time someone watched (a viewer connected / a frame was requested)

    def watched(self, grace=None):
        """Is anybody (or anything: vision snapshot, /frame.png) interested in frames right now? Capture only costs something while this is True."""
        g = getattr(self.cfg, "idle_s", 0) if grace is None else grace
        return g <= 0 or bool(self.clients) or (time.time() - self.activity_t) < g

    async def fresh_frame(self, max_wait=5.0):
        """Wake the capture (it may be paused for lack of viewers) and wait until a frame newer than this call exists. Returns the frame or the old one."""
        t0 = now_ms()
        self.activity_t = time.time()
        end = time.time() + max_wait
        while time.time() < end:
            f = self.latest
            if f is not None and f.t_ms >= t0:
                return f
            self.activity_t = time.time()
            await asyncio.sleep(0.05)
        return self.latest

    # --- called from source threads
    def publish(self, jpeg, w, h, flags, meta=b""):
        with self.lock:
            self.seq += 1
            f = Frame(self.seq, now_ms(), jpeg, w, h, flags, meta)
            self.latest = f
            new_size = (w, h) != self.out_wh
            if new_size:
                self.out_wh = (w, h)
            self.cap_gaps.add()
            self.bytes_total += len(jpeg)
            self.sizes.append(len(jpeg))
        try:
            self.loop.call_soon_threadsafe(self._wake_all)
            if new_size:                                                  # tell the browsers the picture size changed (they size their canvas from it)
                self.loop.call_soon_threadsafe(lambda: asyncio.ensure_future(self.broadcast(self.hello_msg())))
        except RuntimeError:
            pass

    def state_changed(self):
        try:
            self.loop.call_soon_threadsafe(lambda: asyncio.ensure_future(self.broadcast(self.state_msg())))
        except RuntimeError:
            pass

    def settings_changed(self, w, h):
        self.out_wh = (w, h)
        try:
            self.loop.call_soon_threadsafe(lambda: asyncio.ensure_future(self.broadcast(self.hello_msg())))
        except RuntimeError:
            pass

    # --- event-loop side
    def _wake_all(self):
        for c in self.clients:
            c.event.set()

    def state_msg(self):
        s = self.sources
        return json.dumps({"type": "state", "state": s.state if s else "?", "detail": s.detail if s else "", "t_srv": now_ms()})

    def hello_msg(self):
        return json.dumps({"type": "hello", "v": VERSION, "w": self.out_wh[0], "h": self.out_wh[1], "fps": self.cfg.fps, "q": self.cfg.quality, "width": self.cfg.width,
                           "state": self.sources.state if self.sources else "?", "t_srv": now_ms()})

    async def broadcast(self, text):
        for c in list(self.clients):
            try:
                await c.ws.send(text)
            except Exception:
                pass

    def origin_ok(self, headers):
        o = headers.get("Origin")
        return (not o) or bool(ORIGIN_RE.match(o))

    def stats(self):
        s = self.sources
        f = self.latest
        sizes = list(self.sizes)
        now = time.time()
        return {
            "version": VERSION, "pid": os.getpid(), "uptime_s": round(now - self.started, 1),
            "state": s.state if s else "?", "detail": s.detail if s else "",
            "source": (("game" if f.flags & FLAG_GAME else "plugin" if f.flags & FLAG_PLUGIN else "wgc") if f else None),
            "game": self.game.stats() if self.game else None,
            "window": s.window if s else {}, "ffmpeg": s.ffmpeg if s else None,
            "cfg": {"width": self.cfg.width, "fps": self.cfg.fps, "quality": self.cfg.quality, "out": list(self.out_wh), "source": self.cfg.source},
            "capture": {"fps": round(self.cap_gaps.fps(), 1), "frames": self.cap_gaps.total, "gaps_ms": self.cap_gaps.summary(),
                        "kb_avg": round(sum(sizes) / len(sizes) / 1024, 1) if sizes else 0, "mbit_s": round(self.cap_gaps.fps() * (sum(sizes) / len(sizes) if sizes else 0) * 8 / 1e6, 1),
                        "restarts": s.restarts if s else 0, "ffmpeg_pid": s.cap.proc.pid if s and s.cap and s.cap.proc else None,
                        "ffmpeg_err": list(s.cap.err) if s and s.cap else []},
            "frame_age_s": round((now_ms() - f.t_ms) / 1000, 2) if f else None,
            "clients": [{"id": c.id, "since_s": round(now - c.since), "sent": c.sent, "skipped": c.skipped, "sent_fps": round(c.sent_gaps.fps(), 1), "inflight": len(c.pending),
                         "no_ack": c.no_ack, "report": c.report, "info": c.info} for c in self.clients],
            "overlay": {"view_age_s": round(now - self.view_t, 2) if self.view_t else None, "mk_age_s": round(now - self.mk_t, 2) if self.mk_t else None},
        }

    def heartbeat_data(self):
        st = self.stats()
        return {"t": round(time.time(), 1), "pid": os.getpid(), "port": self.cfg.bound_port, "version": VERSION, "state": st["state"], "fps": st["capture"]["fps"],
                "clients": len(st["clients"]), "out": st["cfg"]["out"], "started": round(self.started, 1)}

    def write_heartbeat(self, hb):
        p = os.path.join(self.cfg.agent, "livecap.json")
        for _ in range(5):
            try:
                with open(p + ".tmp", "w", encoding="utf-8") as fh:
                    json.dump(hb, fh)
                os.replace(p + ".tmp", p)
                return
            except OSError:
                time.sleep(0.03)

    async def heartbeat_loop(self):
        while not self.stop_ev.is_set():
            try:
                await asyncio.to_thread(self.write_heartbeat, self.heartbeat_data())
            except Exception:
                pass
            await asyncio.sleep(1.0)

    # --- overlay data (view.json / markers.json -> clients, with world positions for the markers)
    @staticmethod
    def unproject(vp, gy, px, py, pw, ph):
        """Screen pixel -> world (x, z) on the ground plane y=gy for an ORTHOGRAPHIC camera (last matrix row 0,0,0,1)."""
        if len(vp) != 16 or any(abs(v) > 1e-6 for v in vp[12:15]) or abs(vp[15] - 1) > 1e-6:
            return None
        nx, ny = (px / pw) * 2 - 1, (1 - py / ph) * 2 - 1
        a, b = vp[0], vp[2]
        c, d = vp[4], vp[6]
        det = a * d - b * c
        if abs(det) < 1e-12:
            return None
        rx, ry = nx - vp[1] * gy - vp[3], ny - vp[5] * gy - vp[7]
        return ((rx * d - b * ry) / det, (a * ry - c * rx) / det)

    def decorate_markers(self, mk):
        v = self.view
        if not (v and v.get("ok") and v.get("vp") and v.get("pw") and mk.get("pts") is not None):
            return mk
        gy, pw, ph = v.get("gy", 0.0), v["pw"], v["ph"]
        for p in mk["pts"]:
            try:
                w = self.unproject(v["vp"], gy, p["x"] / p.get("w", pw) * pw, p["y"] / p.get("h", ph) * ph, pw, ph)
                if w:
                    p["wx"], p["wz"] = round(w[0], 2), round(w[1], 2)
            except Exception:
                pass
        ln = mk.get("ln")
        if ln:
            lw = []
            for q in ln:
                w = self.unproject(v["vp"], gy, q[0], q[1], pw, ph)
                lw.append([round(w[0], 2), round(w[1], 2)] if w else None)
            mk["lw"] = lw
        return mk

    async def overlay_loop(self):
        agent = self.cfg.agent
        while not self.stop_ev.is_set():
            await asyncio.sleep(0.025)
            for kind, name in (("view", "view.json"), ("mk", "markers.json")):
                p = os.path.join(agent, name)
                try:
                    st = os.stat(p)
                except OSError:
                    continue
                if st.st_mtime_ns == self.mtimes.get(kind):
                    continue
                try:
                    with open(p, "rb") as fh:
                        data = json.loads(fh.read().decode("utf-8", "replace"))
                except (OSError, ValueError):
                    continue                                     # mid-write: next poll
                self.mtimes[kind] = st.st_mtime_ns
                if kind == "view":
                    self.view, self.view_t = data, time.time()
                else:
                    data = self.decorate_markers(data)
                    self.mk_t = time.time()
                data["type"], data["t_srv"] = kind, now_ms()
                text = json.dumps(data, separators=(",", ":"))
                self.last_msg[kind] = text
                await self.broadcast(text)

    # --- HTTP + WebSocket
    def http(self, status, ctype, body, headers=None, origin=None):
        from websockets.datastructures import Headers
        from websockets.http11 import Response
        h = Headers([("Content-Type", ctype), ("Content-Length", str(len(body))), ("Cache-Control", "no-store")])
        if origin and ORIGIN_RE.match(origin):
            h["Access-Control-Allow-Origin"] = origin
        for k, v in (headers or {}).items():
            h[k] = v
        return Response(status, {200: "OK", 204: "No Content", 403: "Forbidden", 404: "Not Found", 503: "Service Unavailable"}.get(status, "OK"), h, body)

    @staticmethod
    def to_png(jpeg):
        import cv2
        import numpy as np
        img = cv2.imdecode(np.frombuffer(jpeg, np.uint8), cv2.IMREAD_COLOR)
        ok, enc = cv2.imencode(".png", img, [cv2.IMWRITE_PNG_COMPRESSION, 1])
        return enc.tobytes() if ok else b""

    async def process_request(self, conn, request):
        path = request.path.split("?", 1)[0]
        hd = request.headers
        origin = hd.get("Origin")
        if path == "/ws":
            if not self.origin_ok(hd):
                return self.http(403, "text/plain", b"origin not allowed")
            if (hd.get("Upgrade") or "").lower() != "websocket":
                return self.http(426, "text/plain", b"websocket only")
            return None
        if hd.get("Sec-Fetch-Site") == "cross-site":                 # a web page on another site must not be able to show the game screen
            return self.http(403, "text/plain", b"cross-site request refused")
        if path == "/stats":
            return self.http(200, "application/json", json.dumps(self.stats()).encode(), origin=origin)
        if path == "/health":
            return self.http(200, "text/plain", b"ok", origin=origin)
        if path == "/frame.jpg":
            f = await self.fresh_frame() if (self.sources and self.sources.state == "idle") else self.latest
            self.activity_t = time.time()
            return self.http(200, "image/jpeg", f.jpeg, origin=origin) if f else self.http(404, "text/plain", b"no frame yet")
        if path == "/frame.png":
            f = await self.fresh_frame() if (self.sources and self.sources.state == "idle") else self.latest
            self.activity_t = time.time()
            if not f:
                return self.http(404, "text/plain", b"no frame yet")
            if self.png_cache[0] != f.seq:
                self.png_cache = (f.seq, await asyncio.to_thread(self.to_png, f.jpeg))
            return self.http(200, "image/png", self.png_cache[1], origin=origin)
        if path == "/live.js":
            try:
                with open(os.path.join(HERE, "live.js"), "rb") as fh:
                    return self.http(200, "application/javascript; charset=utf-8", fh.read(), origin=origin)
            except OSError:
                return self.http(404, "text/plain", b"live.js missing")
        if path in ("/", "/index.html"):
            return self.http(200, "text/html; charset=utf-8", VIEWER_HTML.encode("utf-8"))
        return self.http(404, "text/plain", b"not found")

    async def handle_ws(self, ws):
        c = Client(ws, self.loop)
        self.clients.add(c)
        self.activity_t = time.time()
        log("client %d connected (%s) - %d total" % (c.id, getattr(ws, "remote_address", "?"), len(self.clients)))
        sender = None
        try:
            await ws.send(self.hello_msg())
            await ws.send(self.state_msg())
            for k in ("view", "mk"):
                if self.last_msg.get(k):
                    await ws.send(self.last_msg[k])
            sender = asyncio.ensure_future(self.sender(c))
            c.event.set()
            async for msg in ws:
                if isinstance(msg, str):
                    await self.on_client_msg(c, msg)
        except Exception as ex:
            if type(ex).__name__ not in ("ConnectionClosedOK", "ConnectionClosedError", "ConnectionClosed"):
                log("client %d error: %s" % (c.id, ex))
        finally:
            if sender:
                sender.cancel()
            self.clients.discard(c)
            log("client %d gone - %d left" % (c.id, len(self.clients)))

    async def on_client_msg(self, c, msg):
        try:
            d = json.loads(msg)
        except ValueError:
            return
        if "ack" in d:
            n = int(d["ack"])
            while c.pending and c.pending[0] <= n:
                c.pending.popleft()
            c.acks += 1
            c.no_ack = False
            c.last_ack_t = time.perf_counter()
            c.event.set()
        elif "ping" in d:
            await c.ws.send(json.dumps({"type": "pong", "t": d["ping"], "now": now_ms()}))
        elif "stats" in d and isinstance(d["stats"], dict):
            c.report = {k: v for k, v in d["stats"].items() if isinstance(v, (int, float, str, bool))}
        elif "hello" in d and isinstance(d["hello"], dict):
            c.info = {k: str(v)[:80] for k, v in list(d["hello"].items())[:8]}
        elif "set" in d and isinstance(d["set"], dict):
            self.apply_settings(d["set"])

    def apply_settings(self, s):
        if time.time() - self.settings_t < 2.0:
            return
        self.settings_t = time.time()
        try:
            if "width" in s:
                self.cfg.width = max(480, min(1920, int(s["width"])))
            if "fps" in s:
                self.cfg.fps = max(5, min(60, int(s["fps"])))
            if "quality" in s:
                self.cfg.quality = max(2, min(20, int(s["quality"])))
        except (TypeError, ValueError):
            return
        log("settings ->", self.cfg.width, self.cfg.fps, self.cfg.quality)
        if self.game:
            self.game.send_control()

    async def sender(self, c):
        """Latest-frame-wins: whatever is newest when the client is ready. Never queues, never sends a frame the client could not use yet."""
        try:
            while True:
                await c.event.wait()
                c.event.clear()
                f = self.latest
                if f is None or f.seq == c.last_seq:
                    continue
                if len(c.pending) >= MAX_INFLIGHT:
                    if time.perf_counter() - c.last_ack_t > 2.0:         # nobody is acking: not our browser client - stop gating it
                        c.no_ack = True
                        c.pending.clear()
                    else:
                        continue                                          # woken again by the next ack
                if c.last_seq > 0 and f.seq > c.last_seq + 1:
                    c.skipped += f.seq - c.last_seq - 1
                data = FRAME_HDR.pack(0x54, 1, f.flags, f.seq & 0xFFFFFFFF, f.t_ms, f.w, f.h, len(f.meta)) + f.meta + f.jpeg
                c.last_seq = f.seq
                if not c.no_ack:
                    c.pending.append(f.seq)
                c.sent += 1
                c.sent_gaps.add()
                await c.ws.send(data)
        except asyncio.CancelledError:
            raise
        except Exception:
            return                                                       # connection closed: handle_ws cleans up


VIEWER_HTML = """<!doctype html><html><head><meta charset="utf-8"><title>Thronefall live</title>
<style>html,body{margin:0;height:100%;background:#0d0906;overflow:hidden}#view{position:absolute;inset:0}</style></head>
<body><div id="view"></div><script>window.LV_STANDALONE=true;</script><script src="/live.js"></script></body></html>"""


class LiveCap:
    def __init__(self, cfg):
        self.cfg = cfg
        self.hub = None
        self.ready = threading.Event()

    async def run(self):
        import websockets.asyncio.server as wss
        loop = asyncio.get_running_loop()
        hub = self.hub = Hub(self.cfg, loop)
        src = None
        if self.cfg.source == "synthetic":
            src = SyntheticSource(hub, fps=min(self.cfg.fps, 60), w=self.cfg.width, h=self.cfg.width * 3 // 4 // 2 * 2)
            hub.out_wh = (src.w, src.h)
            hub.sources = types_ns(state="synthetic", detail="test pattern", window={}, ffmpeg=None, restarts=0, cap=None, stop_ev=src.stop_ev)
        else:
            src = hub.sources = SourceManager(hub, self.cfg)
        if self.cfg.ingest_port >= 0 and self.cfg.source != "synthetic":
            try:
                hub.game = GameIngest(hub, self.cfg)
                hub.game.bind()
                hub.game.start()
                log("plugin ingest listening on 127.0.0.1:%d" % hub.game.port)
            except OSError as ex:
                hub.game = None
                log("plugin ingest unavailable (port %s busy?): %s" % (self.cfg.ingest_port, ex))
        async with wss.serve(hub.handle_ws, "127.0.0.1", self.cfg.port, process_request=hub.process_request, compression=None, max_size=1 << 16,
                             ping_interval=10, ping_timeout=25, max_queue=8) as server:
            self.cfg.bound_port = server.sockets[0].getsockname()[1]
            log("listening on 127.0.0.1:%d  agent=%s  source=%s  ffmpeg=%s" % (self.cfg.bound_port, self.cfg.agent, self.cfg.source, getattr(hub.sources, "ffmpeg", None)))
            src.start()
            tasks = [asyncio.ensure_future(hub.overlay_loop()), asyncio.ensure_future(hub.heartbeat_loop())]
            self.ready.set()
            await hub.stop_ev.wait()
            for t in tasks:
                t.cancel()
            hub.sources.stop_ev.set()
            if hub.game:
                hub.game.stop_ev.set()


def types_ns(**kw):
    import types
    return types.SimpleNamespace(**kw)


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--port", type=int, default=8097)
    ap.add_argument("--agent", default=DEFAULT_AGENT)
    ap.add_argument("--source", choices=("auto", "wgc", "plugin", "synthetic"), default="auto")
    ap.add_argument("--width", type=int, default=1280)
    ap.add_argument("--fps", type=int, default=60)
    ap.add_argument("--quality", type=int, default=7, help="ffmpeg mjpeg qscale 2..31 (lower = better/larger)")
    ap.add_argument("--ffmpeg", default="")
    ap.add_argument("--idle-s", type=float, default=20.0, help="stop capturing when nobody has watched for this many seconds (0 = always capture)")
    ap.add_argument("--ingest-port", type=int, default=8095, help="TCP port the plugin pushes in-game frames to (0 = any free port, -1 = disabled)")
    ap.add_argument("--status", action="store_true", help="print /stats of the running instance and exit")
    ap.add_argument("--stop", action="store_true", help="stop the running instance (pid from agent/livecap.json) and exit")
    a = ap.parse_args(argv)
    a.bound_port = a.port
    a.window_finder = None
    return a


def main(argv=None):
    cfg = parse_args(argv)
    if cfg.status:
        import urllib.request
        try:
            print(urllib.request.urlopen("http://127.0.0.1:%d/stats" % cfg.port, timeout=3).read().decode())
            return 0
        except Exception as ex:
            print("not running:", ex)
            return 1
    if cfg.stop:
        try:
            hb = json.load(open(os.path.join(cfg.agent, "livecap.json"), encoding="utf-8"))
            subprocess.run(["taskkill", "/F", "/T", "/PID", str(hb["pid"])], capture_output=True)
            print("stopped pid", hb["pid"])
            return 0
        except Exception as ex:
            print("cannot stop:", ex)
            return 1
    os.makedirs(cfg.agent, exist_ok=True)
    LOGFILE[0] = os.path.join(cfg.agent, "livecap.log")
    try:
        probe = socket.socket()
        probe.bind(("127.0.0.1", cfg.port))
        probe.close()
    except OSError:
        log("port %d is already in use - another livecap is running" % cfg.port)
        return 3
    log("starting", VERSION, "pid", os.getpid())
    try:
        asyncio.run(LiveCap(cfg).run())
    except KeyboardInterrupt:
        pass
    return 0


if __name__ == "__main__":
    sys.exit(main())
