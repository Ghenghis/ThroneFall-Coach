"""Tiny Chrome DevTools Protocol driver (headless Edge/Chrome) for end-to-end UI checks - no chromedriver, no downloads.

    with Browser() as b:                      # headless=new, own temp profile, remote debugging on a free port
        page = b.open("http://127.0.0.1:8099/")
        print(page.js("document.title"))        # JavaScript run INSIDE the headless test browser via CDP Runtime.evaluate
        page.screenshot("shot.png")

A headless page is *visible* (rAF runs, timers are not throttled), unlike the app's built-in browser pane when it is hidden - so frame-rate
measurements taken here are real.
"""
import asyncio
import base64
import json
import os
import shutil
import socket
import subprocess
import tempfile
import threading
import time
import urllib.request

CANDIDATES = (r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe", r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
              r"C:\Program Files\Google\Chrome\Application\chrome.exe", r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")


def find_browser():
    for p in CANDIDATES:
        if os.path.exists(p):
            return p
    return shutil.which("msedge") or shutil.which("chrome")


class Page:
    def __init__(self, loop, ws):
        self.loop, self.ws = loop, ws
        self._id = 0
        self._pending = {}
        self.console = []
        self.events = []
        self.reader = asyncio.run_coroutine_threadsafe(self._read(), loop)

    async def _read(self):
        try:
            async for raw in self.ws:
                m = json.loads(raw)
                if "id" in m and m["id"] in self._pending:
                    self._pending.pop(m["id"]).set_result(m)
                elif m.get("method") == "Runtime.consoleAPICalled":
                    self.console.append((m["params"]["type"], " ".join(str(a.get("value", a.get("description", ""))) for a in m["params"]["args"])))
                elif m.get("method") == "Runtime.exceptionThrown":
                    d = m["params"]["exceptionDetails"]
                    self.console.append(("exception", "%s @ %s:%s:%s %s" % (d.get("text", ""), d.get("url", ""), d.get("lineNumber"), d.get("columnNumber"),
                                                                       (d.get("exception", {}).get("description", "") or "")[:200])))
                else:
                    self.events.append(m)
                    del self.events[:-200]
        except Exception:
            pass

    async def _send(self, method, params=None, timeout=30):
        self._id += 1
        i = self._id
        fut = self.loop.create_future()
        self._pending[i] = fut
        await self.ws.send(json.dumps({"id": i, "method": method, "params": params or {}}))
        r = await asyncio.wait_for(fut, timeout)
        if "error" in r:
            raise RuntimeError("%s: %s" % (method, r["error"]))
        return r.get("result", {})

    def send(self, method, params=None, timeout=30):
        return asyncio.run_coroutine_threadsafe(self._send(method, params, timeout), self.loop).result(timeout + 5)

    def navigate(self, url, wait=1.0):
        self.send("Page.navigate", {"url": url})
        time.sleep(wait)

    def js(self, expr, await_promise=True, timeout=30):
        """Run JavaScript inside the headless test browser (CDP Runtime.evaluate) and return its value. Not Python eval."""
        r = self.send("Runtime.evaluate", {"expression": expr, "returnByValue": True, "awaitPromise": await_promise}, timeout)
        if "exceptionDetails" in r:
            raise RuntimeError("js error: %s" % json.dumps(r["exceptionDetails"])[:400])
        return r["result"].get("value")

    def screenshot(self, path, clip=None):
        p = {"format": "png"}
        if clip:
            p["clip"] = dict(clip, scale=1)
        data = self.send("Page.captureScreenshot", p)["data"]
        with open(path, "wb") as f:
            f.write(base64.b64decode(data))
        return path


class Browser:
    def __init__(self, width=1500, height=950, extra=()):
        self.exe = find_browser()
        if not self.exe:
            raise RuntimeError("no Edge/Chrome found")
        self.size = (width, height)
        self.extra = list(extra)
        self.proc = None
        self.profile = None
        self.loop = None
        self.thread = None
        self.pages = []

    def __enter__(self):
        s = socket.socket()
        s.bind(("127.0.0.1", 0))
        port = s.getsockname()[1]
        s.close()
        self.port = port
        self.profile = tempfile.mkdtemp(prefix="cdp_prof_")
        cmd = [self.exe, "--headless=new", "--remote-debugging-port=%d" % port, "--user-data-dir=%s" % self.profile, "--window-size=%d,%d" % self.size, "--no-first-run",
               "--no-default-browser-check", "--disable-extensions", "--disable-background-networking", "--mute-audio", "--remote-allow-origins=*", "about:blank"] + self.extra
        self.proc = subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        for _ in range(100):
            try:
                urllib.request.urlopen("http://127.0.0.1:%d/json/version" % port, timeout=1).read()
                break
            except Exception:
                time.sleep(0.2)
        else:
            raise RuntimeError("browser did not start")
        self.loop = asyncio.new_event_loop()
        self.thread = threading.Thread(target=self.loop.run_forever, daemon=True)
        self.thread.start()
        return self

    def open(self, url):
        import websockets.asyncio.client as wsc
        req = urllib.request.Request("http://127.0.0.1:%d/json/new?about:blank" % self.port, method="PUT")
        info = json.loads(urllib.request.urlopen(req, timeout=5).read())
        async def _connect():
            return await wsc.connect(info["webSocketDebuggerUrl"], max_size=None, open_timeout=10, ping_interval=None)
        ws = asyncio.run_coroutine_threadsafe(_connect(), self.loop).result(15)
        page = Page(self.loop, ws)
        for d in ("Page", "Runtime"):
            page.send(d + ".enable")
        page.send("Emulation.setDeviceMetricsOverride", {"width": self.size[0], "height": self.size[1], "deviceScaleFactor": 1, "mobile": False})
        page.navigate(url)
        self.pages.append(page)
        return page

    def __exit__(self, *a):
        try:
            for p in self.pages:
                asyncio.run_coroutine_threadsafe(p.ws.close(), self.loop).result(3)
        except Exception:
            pass
        if self.proc:
            self.proc.kill()
            try:
                self.proc.wait(5)
            except Exception:
                pass
        if self.loop:
            self.loop.call_soon_threadsafe(self.loop.stop)
        if self.profile:
            shutil.rmtree(self.profile, ignore_errors=True)
