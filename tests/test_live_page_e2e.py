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
    shown = ("  " + str(detail)[:400]) if detail and not cond else ""
    print(("[%s] %s%s" % ("PASS" if cond else "FAIL", name, shown)).encode("ascii", "replace").decode("ascii"))       # the HUD text has a bullet: a cp1252 console must not crash the report of a failure
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


IRREGULAR = (1.0, 2.4, 5.1, 6.0, 9.3, 12.2, 13.7, 17.9, 21.1, 24.4, 28.8, 31.0)      # seconds ago: twelve unrelated stalls (a perfectly regular train would itself be a periodic source)


def hud_vram_check(Browser):
    """The GPU-memory readout and the 'who is slow' sentence in the standalone viewer, fed by an in-process livecap (synthetic 8 fps = a picture with something to explain)."""
    import threading
    from test_livecap import Harness
    import livecap as lcm
    h = Harness("synthetic", fps=8, width=640)
    try:
        def feed_perf():                                                    # the plugin writes perf.json once a second; the page treats a reading older than 6 s as gone
            json.dump({"t": time.time(), "seq": 1, "fps": 21, "frame_ms": {"p50": 30, "p99": 400}, "stalls_100": 7, "plugin_ms": {"avg": 6.0}}, open(os.path.join(h.agent, "perf.json"), "w"))
        with open(os.path.join(h.agent, "perf-stalls.jsonl"), "w") as f:
            f.write("\n".join(json.dumps({"t": time.time() - i, "frame_ms": 300.0, "cause": "engine"}) for i in IRREGULAR) + "\n")
        feed_perf()
        full = {"t": time.time(), "used_mb": 21285, "committed_mb": 23681, "shared_mb": 317, "total_mb": 24564, "pressure": 0.964,
                "top": [{"name": "llama-server.exe", "pid": 1, "mb": 18038, "shared_mb": 180}, {"name": "dwm.exe", "pid": 2, "mb": 13474, "shared_mb": 7},
                        {"name": "thronefall.exe", "pid": 3, "mb": 1044, "shared_mb": 21}]}
        gpu = lcm.types_ns(latest=full, version=1, state="ok", stop_ev=threading.Event())
        h.hub.gpu = gpu
        with Browser(1280, 800) as b:
            page = b.open("http://127.0.0.1:%d/" % h.port)
            time.sleep(3.5)
            feed_perf()
            time.sleep(1.2)
            st = json.loads(page.js("JSON.stringify({v: LV.stats.vram, r: LV.stats.reason, level: LV.stats.level})"))
            v = st["v"] or {}
            check("HUD/VRAM: the page receives the GPU reading and reduces it to GB, a pressure and the holders",
                  bool(v) and abs(v["totalGB"] - 24564 / 1024) < 0.01 and abs(v["pressure"] - 0.964) < 1e-6 and [t["name"] for t in v["top"]] == ["llama-server", "dwm", "thronefall"], st)
            check("HUD/VRAM: the game itself is not listed as one of the 'others' that hog the card", [t["name"] for t in v.get("others", [])] == ["llama-server", "dwm"], v.get("others"))
            r = st["r"]
            check("HUD/VRAM: when the game stalls outside the plugin's code AND the card is full the sentence states VRAM and its holders as facts",
                  "the game itself stalls" in r and "not the video" in r and "VRAM 96% full" in r and "llama-server 17.6 GB" in r and "dwm 13.2 GB" in r, r)
            check("HUD/VRAM: ...and it does not claim a cause it has not measured (no 'because', no 'not the plugin')", "because" not in r and "not the plugin" not in r and "INSIDE" not in r, r)
            page.screenshot(os.path.join(tempfile.gettempdir(), "live_hud_vram.png"))
            gpu.latest, gpu.version = dict(full, pressure=0.4, used_mb=9000, committed_mb=9500, top=[{"name": "thronefall.exe", "pid": 3, "mb": 1044, "shared_mb": 21}]), 2
            feed_perf()
            time.sleep(1.5)
            r2 = page.js("LV.stats.reason")
            check("HUD/VRAM: with plenty of VRAM left the sentence does not mention it", "the game itself stalls" in r2 and "VRAM" not in r2, r2)
            check("HUD/VRAM: no script errors while drawing the extra HUD line", not [c for c in page.console if c[0] == "exception"], page.console[:3])
            r3 = page.js("LV.stats.reason")
            check("HUD/period: nothing is said about a timer while the stalls are not periodic", "(a timer)" not in r3, r3)
            now = time.time()
            rows = [{"t": now - i, "frame_ms": 300.0, "cause": "engine"} for i in IRREGULAR] + [{"t": now - 20 - 30 * k, "frame_ms": 240.0, "cause": "engine"} for k in range(12)]
            with open(os.path.join(h.agent, "perf-stalls.jsonl"), "w") as f:
                f.write("\n".join(json.dumps(r) for r in sorted(rows, key=lambda r: r["t"])) + "\n")
            h.hub._causes_t = 0.0
            feed_perf()
            time.sleep(1.5)
            r4 = page.js("LV.stats.reason")
            check("HUD/period: a stall that recurs every 30 s is named in the sentence (a timer, not load)", "a stall >200 ms every 30 s (a timer)" in r4, r4)
            page.screenshot(os.path.join(tempfile.gettempdir(), "live_hud_period.png"))
            now = time.time()                                               # our own sections cause the stalls (each logged twice: real line + echo): the sentence names them
            rows = []
            for i in range(8):
                t = now - 3 - 5 * i
                rows += [{"t": t, "frame_ms": 17.0, "wall_ms": 110.0, "plugin_ms": 104.0, "cause": "plugin", "top": "bot", "top_ms": 104.0},
                         {"t": t + 0.1, "frame_ms": 117.0, "wall_ms": 16.0, "plugin_ms": 0.0, "cause": "engine", "top": "bot", "top_ms": 0.0}]
            for j in range(4):
                t = now - 2.5 - 9 * j
                rows += [{"t": t, "frame_ms": 17.0, "wall_ms": 250.0, "plugin_ms": 240.0, "cause": "plugin", "top": "coach", "top_ms": 240.0, "shot": "png"},
                         {"t": t + 0.3, "frame_ms": 267.0, "wall_ms": 16.0, "plugin_ms": 0.0, "cause": "engine", "top": "bot", "top_ms": 0.0}]
            with open(os.path.join(h.agent, "perf-stalls.jsonl"), "w") as f:
                f.write("\n".join(json.dumps(r) for r in sorted(rows, key=lambda r: r["t"])) + "\n")
            h.hub._causes_t = 0.0
            feed_perf()
            time.sleep(1.5)
            r5 = page.js("LV.stats.reason")
            check("HUD/plugin: when our own sections cause the stalls the sentence says so and names them (each stall counted once, not as 'engine')",
                  "plugin code is stalling the game (100% of stalled time: coach 53%, bot 47%)" in r5 and "the game itself" not in r5, r5)
            time.sleep(21)                                                 # the watcher is silent now: a reading older than 20 s must disappear, not stay on screen as if live
            gone = page.js("LV.stats.vram === null")
            check("HUD/VRAM: a reading that stops updating (watcher dead / nobody sampling) vanishes after 20 s instead of staying on screen", gone, page.js("JSON.stringify(LV.stats.vram)"))
    finally:
        h.close()


def hud_narrow_check(Browser):
    """The HUD must fit its pane. The Coach page's Live pane is only ~320 px wide: every HUD line is fitted to the canvas (least important parts dropped first), the amber
    timer line is kept whole, and in a very short pane the lines are dropped from the top (VRAM first)."""
    import threading
    from test_livecap import Harness
    import livecap as lcm
    h = Harness("synthetic", fps=8, width=640)
    try:
        now = time.time()
        rows = [{"t": now - i, "frame_ms": 300.0, "cause": "engine"} for i in IRREGULAR] + [{"t": now - 20 - 30 * k, "frame_ms": 240.0, "cause": "engine"} for k in range(12)]
        with open(os.path.join(h.agent, "perf-stalls.jsonl"), "w") as f:
            f.write("\n".join(json.dumps(r) for r in sorted(rows, key=lambda r: r["t"])) + "\n")

        def feed_perf():
            json.dump({"t": time.time(), "seq": 1, "fps": 21, "frame_ms": {"p50": 30, "p99": 400}, "stalls_100": 7, "plugin_ms": {"avg": 6.0}}, open(os.path.join(h.agent, "perf.json"), "w"))
        feed_perf()
        h.hub.gpu = lcm.types_ns(latest={"t": time.time(), "used_mb": 21285, "committed_mb": 23681, "shared_mb": 317, "total_mb": 24564, "pressure": 0.964,
                                         "top": [{"name": "llama-server.exe", "pid": 1, "mb": 18038, "shared_mb": 180}, {"name": "dwm.exe", "pid": 2, "mb": 13474, "shared_mb": 7},
                                                 {"name": "thronefall.exe", "pid": 3, "mb": 1044, "shared_mb": 21}]}, version=1, state="ok", stop_ev=threading.Event())
        for width, height, name in ((1280, 800, "wide"), (320, 400, "narrow (the Coach page's Live pane)"), (300, 70, "narrow and very short")):
            with Browser(width, height) as b:
                page = b.open("http://127.0.0.1:%d/" % h.port)
                time.sleep(3.5)
                feed_perf()
                time.sleep(1.2)
                hud = json.loads(page.js("JSON.stringify(LV.stats.hud)"))
                if not hud:
                    check("HUD/fit [%s]: the HUD was drawn" % name, False, hud)
                    continue
                texts = [t for t, w in hud["lines"]]
                widest = max(w for t, w in hud["lines"])
                check("HUD/fit [%s]: every line fits the canvas (widest %d px of %d available)" % (name, widest, hud["cw"] - hud["x"]), widest <= hud["cw"] - hud["x"], hud)
                check("HUD/fit [%s]: the main label is always there" % name, texts[0].startswith("●"), texts)
                has_timer = "a stall >200 ms every 30 s (a timer)" in texts
                has_vram = any(t.startswith("VRAM ") for t in texts)
                if height >= 200:
                    check("HUD/fit [%s]: the game line, the amber timer line and the VRAM line are all shown" % name, has_timer and has_vram and any(t.startswith("game ") for t in texts), texts)
                    if width < 400:
                        vram = [t for t in texts if t.startswith("VRAM ")][0]
                        check("HUD/fit [%s]: the VRAM holders are dropped from the end until the line fits" % name, 1 <= len(vram.split(" · ")) < 4 and vram.startswith("VRAM 23.1/24.0 GB (96%)"), vram)
                        game = [t for t in texts if t.startswith("game ")][0]
                        check("HUD/fit [%s]: the game line keeps its first parts when it has to be shortened" % name, game.startswith("game 21 fps · stalls>100ms 7/5s") and "ms/frame" not in game, game)
                else:
                    check("HUD/fit [%s]: with room for two lines only, VRAM goes first and the timer line stays" % name, has_timer and not has_vram and len(texts) == 3, texts)
                page.screenshot(os.path.join(tempfile.gettempdir(), "live_hud_%d.png" % width))
                check("HUD/fit [%s]: no script errors" % name, not [c for c in page.console if c[0] == "exception"], page.console[:3])
    finally:
        h.close()


def main():
    from cdp_browser import Browser, find_browser
    if not find_browser():
        print("SKIP: no Edge/Chrome found")
        return 0
    for fn in (hud_vram_check, hud_narrow_check):
        try:
            fn(Browser)
        except Exception:
            import traceback
            traceback.print_exc()
            FAILS.append("%s raised" % fn.__name__)
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
