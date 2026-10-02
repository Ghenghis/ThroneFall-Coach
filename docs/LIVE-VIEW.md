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
| the **game itself** stutters | the plugin takes two synchronous full-resolution screenshots on the game thread (`CaptureScreenshotAsTexture` + `EncodeToJPG` every 0.25 s, `EncodeToPNG` every 2 s). Measured via WGC: the game presents ~60 fps *between* hitches but only 8-36 fps on average with 100-500 ms stalls; plugin file writes line up with the stall ends (68% vs 38% for random times). (An early guess blamed GPU contention from LM Studio as well; the later measurements in section 7 found **no** correlation between the LLM's GPU activity and the stalls, and found two plugin-side periodic hitches that are still present after the screenshots were reduced.) |

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
* **Game telemetry relay**: the plugin's `perf.json` (frame-time percentiles, stalls, per-section ms) is pushed as a `perf` message together with `causes` computed by livecap from `perf-stalls.jsonl` (`Hub.stall_causes`, cached 5 s): over the last minute **each real stall counted once** (the plugin's log lists every stall twice, see section 7.2 - `stallstat.real_events` drops the echoes) as `n`, `stalled_ms`, shares `plugin` / `mixed` / `engine` and `sections` (which measured plugin section, as a share of all stalled time), plus `period_s` when the stalls >= 200 ms of the last 10 minutes recur at one fixed interval. Plus a `gpu` message: VRAM pressure and who holds it (`GpuWatch`). They exist so the HUD can say *where* the stall is instead of just "slow".
* Settings: a viewer can ask for `{fps, width, quality}`; limits 5-60 fps, 480-1920 px, qscale 2-20; at most one change per 2 s. The plugin is told the same over its control channel.
* Security (it can show the game screen): bound to 127.0.0.1; WebSocket **Origin must be localhost/127.0.0.1/::1** (a web page on another site cannot connect); plain HTTP requests with `Sec-Fetch-Site: cross-site` are refused (an `<img>` on another site cannot embed `/frame.jpg`); CORS only for those origins.
* Heartbeat file `agent/livecap.json` (pid, port, state, fps) once a second; log `agent/livecap.log`.

### The player (`tools/live.js`)
* Decodes in a **Web Worker** (`createImageBitmap`), draws video + overlay into an **OffscreenCanvas** that the compositor presents on its own thread: measured 55 fps drawn (p50 latency 15 ms) *and still >30 fps while the page's main thread was kept ~90% busy*.
* Latest-frame-wins in the browser too: an undecoded frame is dropped when a newer one arrives.
* Overlay (same visual language as before: hero cyan, aim yellow, castle white, builds green, doors by state, foes as dots, nav path dashed) plus **avoid zones with countdown** and **incident rings** from the command center, all world-locked.
* HUD bottom-left: `● 27.9 fps · 12 ms · wgc 1280x960` (green >= 24 fps and < 150 ms, amber, red) or the reason there is no picture (`FALLBACK plugin screenshots`, `STATIC SCENE`, `GAME NOT RUNNING`, `NO SIGNAL · reconnecting`). The readout under the picture uses the same real numbers. Up to three dim lines stack above it when the game's telemetry is flowing: `game 51 fps · stalls>100ms 3/5s · engine 94% plugin 6% · plugin 4.0 ms/frame`, an amber `a stall >200 ms every 30 s (a timer)` when the long stalls recur at one fixed interval, and `VRAM 23.1/24.0 GB (96%) · llama-server 17.6 · dwm 13.2 · thronefall 1.0` (amber from 90%, red when over-committed). Every line is fitted to the canvas (the Coach page's Live pane is ~320 px wide): the least important parts are dropped first, and in a very short pane whole lines are dropped from the top (VRAM first). A reading that stops updating disappears (perf after 6 s, VRAM after 20 s) - the HUD never shows stale numbers as live.
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
* What holds the game below 60 today (measured, section 7): the game presents ~52 fps on average with a hitch of 100+ ms about every 2.5 s. About two thirds of the stalled time is the plugin's own code, still present in build `act-2 / live-1`: (1) the bot's scene scans (`FindObjectsOfType(..., true)` several at once on one 1 Hz tick) cost ~115 ms every second (43% of the stalled time); (2) `live.png` is still written every 30 s while the in-game capture is connected (`live.jpg` stopped entirely) and each write freezes the game for 200-490 ms (21%, the biggest single stalls). The remaining third is not attributed (7.5), including rare multi-second freezes that are not explained yet. The local LLM's GPU activity does **not** line up with the stalls. The HUD fps is therefore also a *game health meter*, and the HUD sentence says where the stall is.
* Beyond 60: pointless (60 Hz game, 60 Hz display).
* Real-time bot <-> MiniMax <-> UI interaction is bounded by file polling today (plugin polls `act-commands.json` every 0.4 s, `coach-commands.json` every 1 s, view.json 20 Hz after live-1). The next step is a push channel on the same plugin<->livecap socket ("Link v2": commands/acks/events in both directions, < 20 ms) - not built yet.

## 5. Operating it

```
python tools/livecap.py --status              # JSON of the running instance (also: curl http://127.0.0.1:8097/stats)
python tools/livecap.py --stop                # stop it (pid from agent/livecap.json); the command-center job restarts it within ~10 s
python tools/livecap.py --port 8097 --width 1280 --fps 60 --quality 7 [--source auto|wgc|plugin|synthetic] [--ffmpeg PATH] [--ingest-port 8095|0|-1] [--gpu auto|on|off]
python tools/live-bench.py --secs 15 --decode # headless client: fps, gaps, latency, decode (add --slow 100 to emulate a slow viewer)
python tools/live-fake-plugin.py --fps 30     # stands in for the plugin's in-game capture (exercises GameIngest)
python tools/perf-watch.py --secs 60          # the GAME's own frame times + who causes the stalls (plugin sections vs the rest, each stall once), one line per 5 s, summary at the end
python tools/perf-watch.py --history 10       # no waiting: the last 10 minutes of the plugin's stall log - causes, plugin sections, periodic timers
python tools/frame-cadence.py --secs 240      # the window's REAL presentation gaps (WGC timestamps), joined with the plugin's stall lines
```
`--gpu auto` (default) watches VRAM except with the synthetic test source; `off` disables it. The state of the watcher is in `/stats` -> `gpu.state` (`ok`, or `off: <reason>` when this machine has no GPU performance counters).
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
| low fps with green latency | the game itself is slow (the picture is a faithful copy of a game that stalls) | read the sentence next to the readout (below), then `python tools/perf-watch.py --history 10` (section 7) |
| `plugin code is stalling the game (64% of stalled time: bot 43%, coach 21%)` | what the HUD says today: measured plugin sections caused most of the stalled time (each stall counted once), and which sections | section 7.3 / 7.6: the bot's scene scans and the 30 s `live.png` write; `perf.json` `sections` has the per-section milliseconds |
| `the game itself stalls (N stalls >100 ms in the last minute) - not the video; 87% of that time is not in the plugin's measured code · VRAM 96% full (llama-server 17.6 GB, dwm 13.2 GB)` | shown when most of the stalled time is NOT in a measured plugin section: WHERE the stall is (the game, not the video), never why. "Not in the measured code" = the game's own work, GPU / driver / OS, plugin work outside `Update`, and stalls just under the logging threshold. The VRAM part appears only at >= 90% and is a measured fact, not a diagnosis | `perf-watch.py --history 10`; the VRAM holders are context (no A/B has proven they matter) |
| `... · a stall >200 ms every 30 s (a timer)` (amber, also on the game line) | the stalls >= 200 ms of the last 10 minutes recur at one fixed interval: a timer somewhere (here: the plugin's `live.png` write), not load | find what runs on that period; section 7 |
| `this browser is dropping frames` | frames arrive fast, the page draws slowly | close heavy tabs; the worker player already keeps the video off the main thread |

## 6. Tests (all run without the game)
| file | what it proves |
|---|---|
| `tests/test_livecap.py` | 113 checks: frame protocol, ack flow control and slow-viewer bound, no-ack clients, HTTP endpoints + security (Origin / Sec-Fetch-Site / CORS), settings clamping, overlay push + world-coordinate round trip (<1.5 px), game telemetry relay + stall-cause shares + the 30 s timer detection (and forgetting it after 10 quiet minutes), **GPU watch** (counter parsing against a canned fake `win32pdh`: adapter choice, 100 MB floor, over-commit, exited process; no sampling while nobody watches, first reading right after a viewer connects, self-switch-off without counters; relay + late joiner + 30 s staleness + `/stats`; the real counters of the machine), plugin-file fallback + staleness, WGC manager with a fake ffmpeg (restart with backoff, window gone / minimised / back, parser resync, fast failure), in-game ingest (orientation, per-frame meta, control lines, replace-on-reconnect, corrupt header), game-beats-WGC and fall-back |
| `tests/test_wgc_real.py` | **real ffmpeg gfxcapture** on a stand-in window: moving pixels, client area only, still the target's own content when another window covers it (a screen grab sees the cover), minimise / restore / close |
| `tests/test_live_page_e2e.py` | 39 checks in headless Edge/Chrome: the standalone viewer's VRAM readout and "where is the stall" sentence (states VRAM and its holders as facts when the card is full, claims no cause, does not mention VRAM when there is plenty, names a 30 s timer, says nothing about a timer when the stalls are not periodic, a silent watcher's reading vanishes after 20 s; screenshots in `%TEMP%\live_hud_vram.png` / `live_hud_period.png`); **the HUD fits its pane** at 1280 px, at 320 px (the Coach page's Live pane: holders dropped from the VRAM line, the game line shortened from the end, nothing wider than the canvas) and at 300x70 px (VRAM line dropped first, the amber timer line kept; screenshots `live_hud_320.png` ...); then the real Coach page: livecap started by the command center, >35 drawn fps (53 measured alone), latency, jammed-main-thread test, kill livecap -> legacy feed -> automatic recovery. **Run it alone**: two concurrent runs measured 33 fps and failed the fps check (CPU contention, not a bug) |
| `tests/test_stallstat.py` | 16 checks on `tools/stallstat.py`: `real_events` (a stall and its delta-time echo are one stall, an echo with no real line before it is kept as unattributed, consecutive stalls, rows without `wall_ms`), `shares` (plugin share = what the sections really cost, not the raw log's "87% engine"; sections ranked), `find_period` on the collapsed events |
| `tests/test_perfwatch.py` | 17 checks: the support-based periodic finder (30 s timer with jitter, stray events, a re-armed timer = phase reset, double-logged stalls, a missed cycle, a regular 1 s train, a 20-event timer in dense noise is NOT claimed, a timer among 60 unrelated events is found, 60 sets of purely random times never called periodic, too few events, short periods) and the `--history` report (counts only the window and each stall once, shares, named plugin sections, the timer, no file -> no traceback). Mutation-checked |
| `tests/test_frame_cadence.py` | 10 checks on the pure parts of `tools/frame-cadence.py`: ffmpeg showinfo parsing, gap detection + placement on the wall clock, matching the plugin's stall lines with real gaps (confirmed / unconfirmed / too short to ask about) |
| `tests/test_page_js.py` | the served page has no script error and defines its functions (the guard for the SyntaxError above) |
| `tests/test_command_center.py` | unchanged suite still passes with the `livecap` job |
`tools/cdp_browser.py` is a 100-line DevTools-Protocol driver (headless Edge/Chrome, no chromedriver, no downloads) used by the browser tests.

## 7. Why the picture still stops: the game itself stalls (measured 2026-10-02)

The video path is fast (section 3): the page draws what the game presents with ~15-20 ms of latency. When the picture still "stops", the game window really stopped presenting
frames. This section records how that was established, what was found, what was ruled out, **one measurement artefact that misled the first analysis**, and what is still
unexplained. Nothing here touched the game: every measurement is read-only (a capture of the window, performance counters, log files). The game was running a normal bot
session (Frostsee) on the machine described below.

**The machine at the time**: 16 logical CPUs at 90-100% from other tools (Defender's MsMpEng ~170% of a core, jcmd, Kilo, Devin, java, esbuild, du, node ...), 128 GB RAM
with 22 GB free, RTX 3090 Ti with VRAM 96% committed (23.7 of 24.5 GB: LM Studio's llama-server 18.0 GB, dwm.exe 13.5-14.3 GB, the game 1.0 GB; the per-process figures add up
to 33 GB, i.e. Windows has over-committed the card), Defender real-time protection on (the game folder is not excluded), `nvspcap64.dll` (NVIDIA capture) loaded in the game.

### 7.1 Three independent measurements
| source | what it gives | headline numbers |
|---|---|---|
| the plugin's own telemetry (`FramePerf`: `agent/perf.json` 1 Hz, `agent/perf-stalls.jsonl` one line per frame > 100 ms) | the plugin's wall clock between two `Update` calls (`wall_ms`), time in each measured plugin section (`sec`, `top`), Unity's frame time (`frame_ms`), a `cause` | 60 s: median 51 fps (44-55), 2.8 stalls > 100 ms per 5 s, plugin 4.0 ms/frame. 23 minutes, **each stall counted once (see 7.2)**: 543 stalls (24 per minute), 85 s stalled, p50 119 ms, max 1.4 s |
| **the window's real frame cadence from outside** (`tools/frame-cadence.py`: ffmpeg `gfxcapture` stamps every frame the compositor receives) | the truth about "did it freeze?", independent of any in-game clock | 240 s: 12 644 frames, 52.9 fps presented, gap p50 16.7 ms / p99 83 ms / max 767 ms, 20 gaps >= 150 ms, none >= 1 s. **Every plugin stall line >= 250 ms (8 of 8) matched a real gap.** Second run: 54.7 fps, p99 83 ms, max 283 ms |
| Windows counters (per-process GPU engine use, the game's main-thread state, system CPU) and a scheduling probe (a spinning thread that notes every time it is descheduled) | what else was busy when the game froze | see 7.4 |

### 7.2 The artefact: the stall log counts every stall twice (and files half of it under "engine")
`FramePerf` reads Unity's `Time.unscaledDeltaTime` **one frame late**. A stall in frame N is therefore logged twice: (1) the real line - `wall_ms` long (the plugin's own
clock), `plugin_ms` = what our sections spent, `cause` computed from that, but `frame_ms` still the old ~17 ms; and (2) one frame later an **echo** - `frame_ms` long
(Unity's delta arriving), `wall_ms` a normal ~17 ms, `plugin_ms` ~0, so its `cause` reads `engine`. Example from the log (a `live.png` capture): `frame 17 / wall 295 / plugin 283
in coach / shot=png / cause plugin` followed by `frame 351 / wall 18 / plugin 0.1 / cause engine`.

Counting both lines double-counts the time and files our own stalls under "engine": in a 31-minute log 317 of 902 lines were echoes and carried 52 of the 83 s of "stalled
time". **The first analysis of this section (and the notes it produced: "87% engine, 12% plugin", "the engine's fault", "a freeze outside the measured sections") was wrong
for that reason.** With each stall counted once (`tools/stallstat.py` `real_events`, used by `perf-watch.py` and by livecap's HUD) the split is **about two thirds plugin
(bot 43%, coach 21%) and one third unattributed**, e.g. over 23 minutes: plugin 64% + mixed 1%, engine 35%. The raw `perf-stalls.jsonl` and the `causes` inside `perf.json`
are still the plugin's uncorrected output (the aggregate `stalls_50/100` and `frame_ms` percentiles count Unity's deltas once per stall and stay usable).

"engine" (what is left) = not inside a measured section: the game's own work, GPU / driver / OS waits, plugin work outside `Update`, **and stalls just under the 100 ms logging
threshold, which are only ever seen through their echo** (a lone echo line has no real line before it; p50 of those is ~118 ms, so many are plausibly 85-99 ms bot stalls).

### 7.3 What was found in OUR plugin (not fixed: needs a plugin rebuild and a game restart)
| finding | evidence | cause |
|---|---|---|
| **`bot` section: the biggest source - 43% of the stalled time** | 295 stalls in 23 min, p50 116 ms, max 381 ms. Stalls >= 100 ms recur **every 1.0 s** (`perf-watch --history`: 292 of 537 stalls are followed by another one 1.0 s later, "mostly in the bot section") | probable (code reading, per-call cost **not yet measured**): `BotPerception` runs six scene-wide `Object.FindObjectsOfType<...>(true)` scans (Shrine, CutOpenPathInteractor, BuildSlot, BuildingInteractor, LevelInteractor, InteractorBase; lines ~1363-1428 and ~1819-1823) on 1 Hz timers that re-arm from the same tick, so they stay phase-locked and all fire on one tick |
| **`coach` section: 21% - a 200-490 ms freeze every 30 s** | the stalls >= 200 ms recur every **30.0 s** (27 of 91 are followed by another one 30.0 s later; in clean stretches every gap is 30.0 +- 0.2 s). The real lines show `coach` 207-460 ms, `shot=png`, the longest single stalls in the log. A 125 s directory watch saw `agent/live.png` (and `.tmp`) rewritten every 30.02 s and every stall >= 200 ms ended within 1.2 s after such a write. The phase of the 30 s runs jumps when the link drops and returns (e.g. after the livecap restart), as a re-armed timer does | `Coach.cs`: `ScreenCapture.CaptureScreenshotAsTexture()` + `EncodeToPNG()` + file write for `live.png` every `LiveShotLinkedEvery = 30` s while the in-game link is up, all synchronous on the game thread |
| rare 1+ s stalls in the `coach` section | one stall line `wall 1588 ms, plugin 1579 ms, top coach` was seen in the first log; the 31-minute log has a 1.4 s `coach` stall | a blocking call inside the coach section (file / network wait) - not identified |
| a 200-700 ms hitch each time a viewer connects | `livelink` / `coach` top sections at connect time (334 / 685 ms) | one-off per connection (render target + readback set-up); not investigated further |

### 7.4 What was ruled out (with the numbers)
* **The local LLM's GPU activity.** 180 s of per-process GPU engine use against the stall log (per second, so the one-frame echo shift does not matter): llama-server was busy (> 5%) in 9% of the seconds; stall rate 0.31/s while it was busy vs 0.35/s while idle; correlation -0.01 (stalls >= 100 ms) and +0.04 (>= 250 ms).
* **The game being GPU-bound.** Its own 3D-engine use was 16-21% on average.
* **VRAM paging through the copy engine.** All copy-engine use together was ~1%, uncorrelated (r = 0.04). (VRAM is nevertheless 96% committed - a *possible* factor that no measurement here supports or excludes; no A/B was done.)
* **RAM paging.** 22 GB free; the game's page faults ~0 per second during a freeze.
* **CPU scheduling starvation.** A normal-priority spinning thread was descheduled for >= 50 ms only twice in 225 s (max 82 ms) although the machine is at 90-100%; only 2 of 12 game gaps >= 150 ms had any hiccup of it next to them (chance level ~5%).
* **A false alarm in the stall lines.** All 8 plugin stall lines >= 250 ms were confirmed as real gaps by the external recording - the stalls are real, only their *attribution* in the log was off (7.2).

### 7.5 Still unexplained
The unattributed third (p50 ~118 ms; a few real lines with a long wall clock but ~0 plugin time, e.g. `wall 789 ms, plugin 79 ms`), and the **multi-second freezes** seen in the first (since rolled-off) log: one caught live (1.77 s) had the game process at 0-23% of a core, the GPU idle, nothing paging and the main thread *waiting* in a kernel `Executive` wait. Because of the echo effect it cannot be said whether that was a stall in our own code that waits (file / network / lock) or the engine: its real line (small `frame_ms`!) was filtered out of that analysis. Candidates **not** tested: on-access scanning by Defender (MsMpEng at ~170% CPU; the game / agent folder is not excluded - a security setting that is the user's to change), the NVIDIA capture module in the game, storage latency on `K:`. The stall log is capped at ~200 KB and drops its oldest half, so a rare event is gone within ~20 minutes: **copy `perf-stalls.jsonl` right after a long freeze**. Finding it for good needs an ETW trace with wait stacks (`wpr`) around one.

### 7.6 What to change (nothing below is done: each needs a plugin rebuild and a game restart, so it waits for the user's go-ahead)
1. **Do not write `live.png` while the in-game link is connected** (`Coach.cs` ~170-194). livecap already serves frames on demand (`/frame.png`, used by the vision model and the chat through `fetch_live_png`; the health check also prefers livecap), so the plugin's `live.png` is only the fallback for when the link is down - and then the old 2 s cadence resumes by itself (`nextLiveShot` logic). Not via `[Coach] LiveShot=false`: that also stops `markers.json`, the overlay feed. Note `tools/e2e-audit.ps1` line 30 expects a fresh `live.png`; teach it to accept a running livecap. Expected: the 200-490 ms freeze every 30 s (21% of the stalled time, the biggest single stalls) disappears.
2. **Share and stagger the bot's scene scans** (`BotPerception.cs`). One `FindObjectsOfType<InteractorBase>(true)` per second filtered by type can serve the BuildingInteractor / LevelInteractor / CutOpenPathInteractor consumers; the BuildSlot / Shrine scans move to other ticks or to a slower cadence. Behaviour must stay identical (`MaxLevelSum`, `gateBuilds`, `InteractorCount` feed the task verification and the door logic). **Measure the cost of each scan first** (wrap each in `FramePerf.Mark` with its own section) - the 43% share is real, the split between the six scans is not known. Expected: the 100 ms hitch every 1 s becomes a few ms.
3. **Fix `FramePerf` itself.** Classify a stall by `wall_ms` (the plugin's clock, same frame as `plugin_ms`), log ONE line per stall, keep Unity's delta only as a cross-check, and rotate the stall file (keep the previous generation) instead of dropping the oldest half. Then `perf.json` `causes` and the raw log stop lying and `real_events` becomes a pass-through.
4. **Prove it**: before and after, run `python tools/perf-watch.py --history 10` (no `PERIODIC` line at 200 ms, the `bot` section's share and p50 far lower) and `python tools/frame-cadence.py --secs 240` (gaps >= 150 ms per minute, no 30 s pattern, the plugin's lines matched to real gaps).

### 7.7 Re-running the analysis
```
python tools/perf-watch.py --history 10        # each stall once, plugin sections, the periodic timer - from the plugin's own log, no waiting
python tools/frame-cadence.py --secs 240       # the window's real presentation gaps + which plugin stall lines are real
python tools/perf-watch.py --secs 60           # live view of fps / stalls / plugin ms per frame, one line per 5 s
```
The other probes used here were one-off scripts (per-process GPU engine use via `win32pdh` `\GPU Engine(*)`, per-thread state of the game's main thread via `\Thread(thronefall/*)`, a spinning scheduler probe, a 40 ms poll of the agent directory's file changes); their results are the numbers above. What the HUD shows (the `VRAM` line, the shares, the timer note) comes from `GpuWatch` and `Hub.stall_causes` in `tools/livecap.py` and the shared `tools/stallstat.py` (`real_events`, `shares`, `find_period`: support-based, so strays, phase resets and missed cycles do not hide a timer, and a significance test against chance keeps dense noise from being called periodic).
