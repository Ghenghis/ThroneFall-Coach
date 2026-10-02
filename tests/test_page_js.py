"""Regression guard for the Coach web page: load the REAL served page in a headless browser and fail on any script error.

A single misplaced brace in the page's big inline <script> kills the whole page (no chat, no run list, no controls) and neither py_compile nor
the Python tests notice it - this happened once (click-to-command), so every edit of tools/coach-server.py is now checked here.

    python tests/test_page_js.py          (needs Edge or Chrome; skips with exit code 0 and a note when neither is installed)
"""
import os
import socket
import subprocess
import sys
import tempfile
import time
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, "tools"))
FAILS = []


def check(name, cond, detail=""):
    print("[%s] %s%s" % ("PASS" if cond else "FAIL", name, ("  " + str(detail)[:400]) if detail and not cond else ""))
    if not cond:
        FAILS.append(name)


def free_port():
    s = socket.socket()
    s.bind(("127.0.0.1", 0))
    p = s.getsockname()[1]
    s.close()
    return p


def main():
    from cdp_browser import Browser, find_browser
    if not find_browser():
        print("SKIP: no Edge/Chrome found")
        return 0
    agent = tempfile.mkdtemp(prefix="pagejs_")
    port = free_port()
    env = dict(os.environ, THRONEFALL_AGENT=agent, MM_WATCH="0", CC_ENABLED="0", CC_LIVECAP="0", PYTHONUNBUFFERED="1")
    srv = subprocess.Popen([sys.executable, "-u", os.path.join(ROOT, "tools", "coach-server.py"), "--port", str(port)], cwd=ROOT, env=env,
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        for _ in range(60):
            time.sleep(0.5)
            try:
                urllib.request.urlopen("http://127.0.0.1:%d/state" % port, timeout=1).read()
                break
            except Exception:
                pass
        else:
            check("coach-server started", False)
            return 1
        html = urllib.request.urlopen("http://127.0.0.1:%d/" % port, timeout=5).read().decode("utf-8")
        check("page is served and has the live player + command center hooks", "/live.js" in html and "/cc.js" in html and len(html) > 40000, len(html))
        with Browser(1700, 950) as b:
            page = b.open("http://127.0.0.1:%d/" % port)
            time.sleep(4)
            page.js("typeof tool==='function' ? (tool('live'), 1) : 0")
            time.sleep(2)
            exc = [c for c in page.console if c[0] == "exception"]
            check("no uncaught script errors while loading the page", not exc, exc[:3])
            for fn in ("tool", "order", "send", "sendShot", "drawMarkers", "reconnectStream", "saveShot", "clearInk", "mkTog", "runs", "refresh"):
                check("main script defines %s() (it only does if the whole script parsed)" % fn, page.js("typeof %s" % fn) == "function")
            check("live pane exists with the video container", bool(page.js("!!document.getElementById('view') && !!document.getElementById('shot')")))
            check("the click-to-command mouse handler is attached", bool(page.js("typeof cv.onmousedown === 'function'")))
            check("no error-level console output", not [c for c in page.console if c[0] in ("error",) and "favicon" not in c[1] and "Failed to load resource" not in c[1] and "ERR_" not in c[1]], page.console[:4])
    finally:
        srv.kill()
        try:
            srv.wait(5)
        except Exception:
            pass
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
