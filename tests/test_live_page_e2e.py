"""End-to-end test of the Live View in the REAL Coach page: coach-server (+ its command center, which supervises livecap) + livecap on a synthetic
source + a headless Edge/Chrome. Measures what the user actually sees (frames drawn per second, latency) and checks the failure behaviour.

    python tests/test_live_page_e2e.py       (needs Edge or Chrome; skips otherwise)
"""
import json
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


def get(url, timeout=3):
    return json.loads(urllib.request.urlopen(url, timeout=timeout).read())


def kill_livecap(port):
    try:
        hb = get("http://127.0.0.1:%d/stats" % port)
        subprocess.run(["taskkill", "/F", "/T", "/PID", str(hb["pid"])], capture_output=True)
        return hb["pid"]
    except Exception:
        return None


def main():
    from cdp_browser import Browser, find_browser
    if not find_browser():
        print("SKIP: no Edge/Chrome found")
        return 0
    agent = tempfile.mkdtemp(prefix="liveE2E_")
    port, lport = free_port(), free_port()
    env = dict(os.environ, THRONEFALL_AGENT=agent, MM_WATCH="0", CC_ENABLED="1", CC_SKIP_PID_CHECK="1", PYTHONUNBUFFERED="1", LIVECAP_PORT=str(lport),
               LIVECAP_ARGS="--source synthetic --ingest-port -1 --fps 60 --width 1280")
    env.pop("CC_LIVECAP", None)
    srv = subprocess.Popen([sys.executable, "-u", os.path.join(ROOT, "tools", "coach-server.py"), "--port", str(port)], cwd=ROOT, env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        for _ in range(60):
            time.sleep(0.5)
            try:
                get("http://127.0.0.1:%d/alive" % port, 1)
                break
            except Exception:
                pass
        for _ in range(40):
            time.sleep(0.5)
            try:
                if get("http://127.0.0.1:%d/stats" % lport, 1)["state"] == "synthetic":
                    break
            except Exception:
                pass
        else:
            check("the command center started livecap by itself", False)
            return 1
        check("the command center's scheduler job started livecap by itself (detached process)", True)
        with Browser(1700, 950) as b:
            page = b.open("http://127.0.0.1:%d/" % port)
            time.sleep(4)
            page.js("typeof tool==='function' ? (tool('live'), 1) : 0")
            time.sleep(2)
            check("no script errors", not [c for c in page.console if c[0] == "exception"], page.console[:3])
            active = page.js("!!(window.LV && LV.active)")
            check("the player connected to livecap and took over the picture (LV.active)", active, page.js("window.LV ? LV.state + ' ' + LV.detail : 'no LV'"))
            s1 = json.loads(page.js("JSON.stringify(LV.stats)"))
            t1 = time.time()
            time.sleep(6)
            s2 = json.loads(page.js("JSON.stringify(LV.stats)"))
            dt = time.time() - t1
            fps = (s2["drawn"] - s1["drawn"]) / dt
            print("   measured in the page: drawn %.1f fps, received %.1f/s, latency p50 %.0f ms p95 %.0f ms, decode p50 %.1f ms, dropped %d" % (fps, (s2["recv"] - s1["recv"]) / dt, s2["lat"], s2["latP95"], s2["dec"], s2["dropped"] - s1["dropped"]))
            check("the browser really draws about 40+ new frames per second", fps > 35, round(fps, 1))
            check("capture->display latency stays low (p95 < 120 ms)", s2["latP95"] < 120, s2["latP95"])
            # camera + world API: a click on the video can be turned into world metres ("send the hero here") and command feedback can be drawn world-locked
            vp = [0.01462, 0, -0.01462, 0.22775, 0.01597, 0.01581, 0.01597, 0.24656, 0.00081, -0.00164, 0.00081, -0.77928, 0, 0, 0, 1]
            json.dump({"t": time.time(), "ok": True, "pw": 1920, "ph": 1440, "gy": 13.49, "vp": vp, "zones": []}, open(os.path.join(agent, "view.json"), "w"))
            time.sleep(1.2)
            wres = json.loads(page.js("(async()=>{const c=document.getElementById('lvc');return JSON.stringify(await LV.world(c.clientWidth/2,c.clientHeight/2))})()"))
            import livecap as lcm
            exp = lcm.Hub.unproject(vp, 13.49, 960, 720, 1920, 1440)
            check("LV.world(): the centre of the picture maps to the right world position on the ground plane", wres and abs(wres["x"] - exp[0]) < 0.05 and abs(wres["z"] - exp[1]) < 0.05, (wres, exp))
            page.js("LV.mark({id:'t1', x:%f, z:%f, r:14, label:'GO test', color:'#7bc96f', ttl:30}); 1" % (exp[0], exp[1]))
            time.sleep(0.5)
            hit = page.js("(async()=>JSON.stringify(await LV.hit(10,10)))()")
            check("LV.hit() answers (null when no marker is near)", hit == "null", hit)
            canvas = page.js("(function(c){return c && c.clientWidth > 100 && getComputedStyle(c).display !== 'none'})(document.getElementById('lvc'))")
            check("the video canvas is visible inside the Live pane", bool(canvas))
            shot_hidden = page.js("getComputedStyle(document.getElementById('shot')).visibility") == "hidden"
            check("the legacy <img> MJPEG is parked (hidden, replaced by a spacer: no second download)", shot_hidden and "svg" in page.js("document.getElementById('shot').src"))
            page.js("window.__busy = true; (function spin(){ const t=performance.now(); while(performance.now()-t < 90){} if(window.__busy) setTimeout(spin, 10); })(); 0")
            d1 = json.loads(page.js("JSON.stringify(LV.stats)", timeout=20))
            time.sleep(4)
            d2 = json.loads(page.js("JSON.stringify(LV.stats)", timeout=20))
            page.js("window.__busy = false; 0")
            bfps = (d2["drawn"] - d1["drawn"]) / 4.0
            check("with the page's MAIN thread ~90% busy the video still draws > 30 fps (worker + offscreen canvas)", bfps > 30, round(bfps, 1))
            hud = page.js("document.getElementById('lvFps').textContent")
            check("the readout under the picture shows the REAL fps and latency", "fps" in hud and "ms" in hud, hud)
            # kill the video process: the player must say so, hand over to the legacy feed, and come back by itself when livecap returns
            def job(enabled):                                  # hold the supervisor still so the outage lasts as long as the test needs
                req = urllib.request.Request("http://127.0.0.1:%d/scheduler" % port, data=json.dumps({"job": "livecap", "enabled": enabled}).encode(), headers={"Content-Type": "application/json"})
                return json.loads(urllib.request.urlopen(req, timeout=5).read())
            job(False)
            pid = kill_livecap(lport)
            check("(test) livecap killed, supervisor job paused", pid is not None)
            time.sleep(11)
            down = page.js("JSON.stringify({active: LV.active, state: LV.state, legacy: /[/]live[.](mjpeg|png|jpg)/.test(document.getElementById('shot').src), spacer: document.getElementById('shot').src.indexOf('data:') === 0})")
            print("   after killing livecap for 11 s:", down)
            d = json.loads(down)
            check("no signal for 8 s: the player steps aside and the page's legacy feed takes the picture back (no frozen last frame)", (not d["active"]) and d["legacy"] and not d["spacer"], d)
            job(True)                                          # supervisor back on: it must notice the missing process and start it again
            ok = False
            for _ in range(40):
                time.sleep(1)
                try:
                    if get("http://127.0.0.1:%d/stats" % lport, 1)["state"] == "synthetic" and page.js("!!LV.active"):
                        ok = True
                        break
                except Exception:
                    pass
            check("the command center restarts livecap and the player re-activates by itself (no page reload)", ok, page.js("window.LV ? LV.state + ' active=' + LV.active : 'no LV'"))
            if ok:
                time.sleep(3)
                s3 = json.loads(page.js("JSON.stringify(LV.stats)"))
                t3 = time.time()
                time.sleep(3)
                s4 = json.loads(page.js("JSON.stringify(LV.stats)"))
                check("and the picture is moving again", (s4["drawn"] - s3["drawn"]) / (time.time() - t3) > 25, s4["drawn"] - s3["drawn"])
            page.screenshot(os.path.join(tempfile.gettempdir(), "live_e2e.png"))
    finally:
        kill_livecap(lport)
        srv.kill()
        try:
            srv.wait(5)
        except Exception:
            pass
    print("\n%s - %d failed" % ("ALL PASSED" if not FAILS else "FAILED", len(FAILS)))
    return 1 if FAILS else 0


if __name__ == "__main__":
    sys.exit(main())
