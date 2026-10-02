# Live View video - how the picture gets from the game to the Coach page, and why it is fast

The Live View used to be choppy, delayed and sometimes just froze. This document records **what was wrong (measured)**, the pipeline that replaced it,
how to run / debug it, the protocol, the tests that prove it, and where the ceiling is.

```
 Thronefall.exe (plugin: view.json 20 Hz, markers.json 10 Hz, optional in-game frame push)        agent/*.json
        |                       |                                                                      |
        |  (A) in-game frames   |  (B) the window's own composed surface                              |
        |  raw RGBA, TCP :8095  |  Windows Graphics Capture <- ffmpeg `gfxcapture` (GPU scale + MJPEG) |
        v                       v                                                                      v
   +---------------------- tools/livecap.py  (separate process, port 8097) -------------------------------+
   |  GameIngest | WgcCapture | plugin live.jpg fallback   ->  Hub: latest frame, per-client ack flow control |
   |  overlay relay: view.json + markers.json -> push, markers get WORLD coords (unproject)                |
   |  /stats  /frame.jpg  /frame.png  /live.js  /  (standalone viewer)  ws://127.0.0.1:8097/ws              |
   +--------------------------------------------------------------------------------------------------------+
        |  WebSocket: JPEG frames (+ per-frame camera meta) + view/mk/state JSON      ^ acks, settings, stats
        v                                                                             |
   browser: tools/live.js -> Web Worker -> createImageBitmap -> OffscreenCanvas (video + overlay, vsync via rAF)
   coach-server.py (:8099) serves the page + /live.js, supervises livecap (command-center job), keeps /live.png for the vision model
```

## 1. What was wrong (all measured on this machine, 2026-10-01)

| symptom | measured cause |
|---|---|
| picture showed **the Coach page inside the Live View** (picture-in-picture, "OFFLINE", etc.) | the old in-process grabber did `BitBlt` of the game window's DC. For this window that returns whatever is **on screen** in that rectangle: with the browser on top of the game you capture the browser. A plain screen grab of a covered window shows the cover (test `tests/test_wgc_real.py` proves it, red cover vs blue target). |
| frozen / 2-4 fps feed whenever the game window is **minimised** | no external capture can see a minimised window (BitBlt, PrintWindow and WGC all return black / nothing). Only a capture done *inside* the game works. |
| "6.8 fps" in the UI | the fps readout counted `/live.json` polls (300 ms) - it could never show more than ~3.3 fps - and the grabber re-encoded identical frames. Neither was the real video rate. |
| multi-second **delay** | MJPEG over one HTTP connection: if the browser decodes slower than the server sends, frames pile up in the socket buffers (seconds of backlog). The page also re-opened the stream every 30 s (visible hitch). |
| picture hitches whenever the page was busy | `<img>` MJPEG decode and the marker canvas both live on the page's main thread, which also renders chat / incident DOM. |
| **server stalled for minutes at startup** (so a restart = no UI) | the grabber thread's pywin32/PIL imports and `ssl` store loading contended with the main thread's imports; 2 of 8 test starts hung. With the in-process grabber off: 12 of 12 starts alive in 0.8-3.5 s. |
| markers lagging / wobbling | overlay positions came from `markers.json` (4 Hz) polled every 300 ms and redrawn on a separate canvas, `view.json` (4 Hz) polled every 1000 ms. |
| the **game itself** stutters | the plugin takes two synchronous full-resolution screenshots on the game thread (`CaptureScreenshotAsTexture` + `EncodeToJPG` every 0.25 s, `EncodeToPNG` every 2 s). Measured via WGC: the game presents ~60 fps *between* hitches but only 8-36 fps on average with 100-500 ms stalls; plugin file writes line up with the stall ends (68% vs 38% for random times). GPU contention (LM Studio at 90-100% util, 23.7 of 24.5 GB VRAM used) adds more. |

## 2. The pipeline

### Sources (best first; the state is shown honestly in the HUD)
| state | source | needs | fps | notes |
|---|---|---|---|---|
| `game` | **in-game capture** pushed by the plugin (`src/LiveLink.cs`, see `docs/PLUGIN-LIVE.md`) | plugin build `live-1` | up to 60 | works minimised / covered / fullscreen; every frame carries the exact camera matrix |
| `wgc` | **Windows Graphics Capture** through `ffmpeg -f lavfi gfxcapture` | ffmpeg >= 8 with `gfxcapture`, game window not minimised | game-limited (<= 60) | occlusion-proof, GPU scaling + native JPEG, ~0 CPU |
| `plugin` | the plugin's own `live.jpg` (<= 4 fps) | LiveShot on | 2-4 | **fallback**, flagged in the HUD |
| `static` | WGC running, the game presents no new frame (paused / static scene) | - | 0 | last frame kept, labelled |
| `minimized` / `no-window` / `error` | nothing capturable | - | - | HUD says what to do; plugin fallback used if fresh |

`SourceManager` switches by itself (hysteresis: the in-game feed must be silent for 1.5 s before WGC takes over; WGC restarts with exponential backoff
0.5 -> 10 s if ffmpeg dies; a capture that cannot start fails in < 1 s, not after a 12 s timeout).

### livecap (`tools/livecap.py`, `python tools/livecap.py --help`)
* Own process, detached: a coach-server restart (or a stalled Python thread in it) never touches the picture; the page keeps its socket.
* ffmpeg child is in a Windows **job object** (killed with livecap - no orphans). Output travels over a loopback TCP socket (a Windows anonymous pipe has a 4 KB buffer and throttles 100 KB frames).
* **Flow control**: the server never has more than 3 un-acked frames in flight per client and always sends the *latest* frame. A slow viewer skips frames, it never builds a backlog (test: a 120 ms/frame viewer at 60 fps capture keeps p95 latency < 400 ms; the old MJPEG backlog was seconds). A client that never acks (curl, tests) is detected after 2 s and sent frames freely.
* **Overlay relay**: `view.json` (camera matrix, zones) and `markers.json` are pushed whenever they change (polled at 40 Hz). Markers are given **world coordinates** by un-projecting their screen position with the matching camera (orthographic camera: exact), so the page can re-project them with the newest camera on *every drawn frame*. Frames from the in-game capture carry their own camera matrix, which makes the overlay frame-exact.
* Settings: a viewer can ask for `{fps, width, quality}`; limits 5-60 fps, 480-1920 px, qscale 2-20; at most one change per 2 s. The plugin is told the same over its control channel.
* Security (it can show the game screen): bound to 127.0.0.1; WebSocket **Origin must be localhost/127.0.0.1/::1** (a web page on another site cannot connect); plain HTTP requests with `Sec-Fetch-Site: cross-site` are refused (an `<img>` on another site cannot embed `/frame.jpg`); CORS only for those origins.
* Heartbeat file `agent/livecap.json` (pid, port, state, fps) once a second; log `agent/livecap.log`.

### The player (`tools/live.js`)
* Decodes in a **Web Worker** (`createImageBitmap`), draws video + overlay into an **OffscreenCanvas** that the compositor presents on its own thread: measured 55 fps drawn (p50 latency 15 ms) *and still >30 fps while the page's main thread was kept ~90% busy*.
* Latest-frame-wins in the browser too: an undecoded frame is dropped when a newer one arrives.
* Overlay (same visual language as before: hero cyan, aim yellow, castle white, builds green, doors by state, foes as dots, nav path dashed) plus **avoid zones with countdown** and **incident rings** from the command center, all world-locked.
* HUD bottom-left: `● 27.9 fps · 12 ms · wgc 1280x960` (green >= 24 fps and < 150 ms, amber, red) or the reason there is no picture (`FALLBACK plugin screenshots`, `STATIC SCENE`, `GAME NOT RUNNING`, `NO SIGNAL · reconnecting`). The readout under the picture uses the same real numbers.
* No signal for 8 s -> the page's legacy feed takes the picture back (no frozen last frame) while the worker keeps reconnecting; the first frame re-activates the player. A hidden tab drops its socket.
* Page integration is minimal and guarded (`window.LV && LV.active`): the legacy `<img>` is parked as a size spacer, the page's marker canvas and `/live.json` image polling stay quiet, `sendShot` / `saveShot` / `reconnectStream` use the player. Click-to-command keeps working (the worker feeds the world-locked marker positions to the page's hit-test).
* Standalone viewer (full window, letterboxed): `http://127.0.0.1:8097/` - keys `f` fullscreen, `h` HUD, `1` 960px/30fps, `2` 1280px/60fps, `3` 1920px/60fps.

### Other server changes (tools/coach-server.py, tools/command_center.py)
* The in-process grabber thread is **off** (`COACH_INPROC_GRAB=1` re-enables it for debugging).
* Command-center job **`livecap`** (scheduler table): every 10 s checks `/stats`; if livecap is not answering it starts it detached (`agent/livecap.out`) within seconds. Port: `LIVECAP_PORT` (default 8097); extra args: `LIVECAP_ARGS`; disable: `CC_LIVECAP=0` or `cc-config.json {"livecap": {"enabled": false}}`.
* `/live.png` and the vision model (`/mmlook`) take frames from livecap (`fetch_live_png`) and fall back to the plugin's `live.png`, so they keep working when the plugin stops writing screenshots; the health check "live frames" reads the livecap heartbeat.
* Fixed while here: a stray `}` in the click-to-command handler of the page's main script was a **SyntaxError that killed the whole page** (no chat, no run list, no controls) - `tests/test_page_js.py` now loads the real page in a headless browser and fails on any script error.

## 3. Numbers (measured, this machine: Ryzen 7 5800X3D, RTX 3090 Ti, game 1920x1440 windowed, stream 1280x960 q7)

| what | result |
|---|---|
| WGC capture -> client (real game, 15 s) | 33.3 fps received, p50 inter-frame 17.6 ms (= 60 fps cadence between hitches), p95 99 ms, p99 258 ms (those are the **game's own stalls**), transport latency p50 0.6 ms / p95 7 ms, 69 KB/frame, 19 Mbit/s |
| same, in the real Coach page (headless Edge, 10 s) | 27 fps received / 22 drawn (frames that arrive in a burst after a game stall coalesce), latency p50 11 ms / p95 27 ms, decode 7.5 ms, 0 dropped |
| synthetic 60 fps source in the real page | **55.6 fps drawn**, p50 15 ms / p95 16-28 ms, 0-1 dropped; with the page's main thread jammed ~90%: still 46 fps |
| WGC on a stand-in window (animated GDI, 1258x904) | 36.6 fps, **livecap ~4% of one core**, ffmpeg ~0% |
| game frame cadence via WGC (before this work) | 24-28 fps average, 60% of the time inside stalls > 70 ms, 27 stalls > 100 ms per 10 s |
| old pipeline | 4.5-6.8 fps at the HTTP level (UI showed <= 3.3), seconds of delay, unusable when covered / minimised |

## 4. Ceiling - what is physically possible

* The picture can never be smoother than the **game's own presented frame rate**. Capture, JPEG, loopback and the worker add ~1 frame (<= 30 ms). 60 fps needs the game to present 60 fps.
* Capture cost is negligible (GPU does the scaling; ~4% of a core for the whole pipeline), so **60 fps at 1280x960 is available whenever the game delivers it**; 1920x1440 costs ~2x JPEG size (1920px preset `3`).
* What holds the game below 60 today: the plugin's synchronous screenshots (removed by plugin build `act-2 / live-1`: with the in-game capture connected the plugin stops `live.jpg` entirely and writes `live.png` only every 30 s), GPU contention from the local LLM (LM Studio, 23.7/24.5 GB VRAM, 90-100% util spikes) and bot per-frame work. The HUD fps is therefore also a *game health meter*.
* Beyond 60: pointless (60 Hz game, 60 Hz display).
* Real-time bot <-> MiniMax <-> UI interaction is bounded by file polling today (plugin polls `act-commands.json` every 0.4 s, `coach-commands.json` every 1 s, view.json 20 Hz after live-1). The next step is a push channel on the same plugin<->livecap socket ("Link v2": commands/acks/events in both directions, < 20 ms) - not built yet.

## 5. Operating it

```
python tools/livecap.py --status              # JSON of the running instance (also: curl http://127.0.0.1:8097/stats)
python tools/livecap.py --stop                # stop it (pid from agent/livecap.json); the command-center job restarts it within ~10 s
python tools/livecap.py --port 8097 --width 1280 --fps 60 --quality 7 [--source auto|wgc|plugin|synthetic] [--ffmpeg PATH] [--ingest-port 8095|0|-1]
python tools/live-bench.py --secs 15 --decode # headless client: fps, gaps, latency, decode (add --slow 100 to emulate a slow viewer)
python tools/live-fake-plugin.py --fps 30     # stands in for the plugin's in-game capture (exercises GameIngest)
```
Ports: 8097 livecap (WS+HTTP), 8095 plugin ingest (TCP), 8099 coach-server. Everything binds 127.0.0.1.

### Reading the HUD / `state`
| HUD | meaning | what to do |
|---|---|---|
| `27.9 fps · 12 ms · wgc` green | live window capture | - |
| `... · game` | live in-game capture (best) | - |
| `FALLBACK plugin screenshots 2.3 fps` | game window minimised or ffmpeg unavailable; only the plugin's screenshots | restore the game window, or deploy plugin `live-1` (works minimised) |
| `STATIC SCENE · 3.2s` | WGC is running but the game presents nothing new | normal in a paused / static scene |
| `GAME NOT RUNNING` | no game window, no fresh plugin frame | start the game |
| `NO SIGNAL · reconnecting` | the page lost livecap | check `agent/livecap.json`; the command-center job restarts it; after 8 s the legacy feed takes over |
| low fps with green latency | the game itself is slow | look at GPU load (LM Studio), plugin stalls (`[live]` log lines) |

## 6. Tests (all run without the game)
| file | what it proves |
|---|---|
| `tests/test_livecap.py` | 88 checks: frame protocol, ack flow control and slow-viewer bound, no-ack clients, HTTP endpoints + security (Origin / Sec-Fetch-Site / CORS), settings clamping, overlay push + world-coordinate round trip (<1.5 px), plugin-file fallback + staleness, WGC manager with a fake ffmpeg (restart with backoff, window gone / minimised / back, parser resync, fast failure), in-game ingest (orientation, per-frame meta, control lines, replace-on-reconnect, corrupt header), game-beats-WGC and fall-back |
| `tests/test_wgc_real.py` | **real ffmpeg gfxcapture** on a stand-in window: moving pixels, client area only, still the target's own content when another window covers it (a screen grab sees the cover), minimise / restore / close |
| `tests/test_live_page_e2e.py` | the real Coach page in headless Edge/Chrome: livecap started by the command center, >35 drawn fps, latency, jammed-main-thread test, kill livecap -> legacy feed -> automatic recovery |
| `tests/test_page_js.py` | the served page has no script error and defines its functions (the guard for the SyntaxError above) |
| `tests/test_command_center.py` | unchanged suite still passes with the `livecap` job |
`tools/cdp_browser.py` is a 100-line DevTools-Protocol driver (headless Edge/Chrome, no chromedriver, no downloads) used by the browser tests.
