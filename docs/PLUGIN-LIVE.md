# live.v1: the game's own frames, streamed to livecap (plugin build act-2 / live-1)

Status 2026-10-02 ~00:50. Tags: [MEASURED] measured on this machine, [DECOMPILED] read in the game's Unity assemblies, [TESTED] unit / loopback / end-to-end / simulated-player-loop tests, [NOT VERIFIED] needs the running game (section 9 says what will reveal each one).

This document also covers two things that ship in the same build: **perf.v1**, the frame-time instrumentation that tells us why the game stutters (section 11), and **background file writes** for the status files (section 5).

## 1. Why

* The legacy Live View feed lives in `Coach.PerFrame`: `ScreenCapture.CaptureScreenshotAsTexture()` + `EncodeToJPG(55)` every 0.25 s (`live.jpg`) and `EncodeToPNG()` every 2 s (`live.png`), all synchronous on the game thread at full resolution. [MEASURED, by the owner of this build] the game then presents 8-35 fps instead of 60 (hitches of 100-500 ms several times a second); a Windows Graphics Capture of the window shows 24 fps with 60 % of the time stalled.
* An external window capture shows nothing while the game window is minimised; a capture made inside the game's own frame is independent of the window.

## 2. What it does

```
game thread, end of every frame (WaitForEndOfFrame coroutine)           GPU                          sender thread (own socket)
ScreenCapture.CaptureScreenshotIntoRenderTexture(full)   --copy-->     full RT (screen size, ARGB32)
Graphics.Blit(full, small [, vertical flip])             --scale-->    small RT (Width x aspect, ARGB32)
AsyncGPUReadback.Request(small, 0, RGBA32)               --DMA---->    staging buffer
   ... 2-3 frames later, in the readback callback:
   copy the bytes into a POOLED byte[] -> the ONE "latest frame" slot -> AutoResetEvent ----------------------------> TCP: header + meta + pixels
```

* **Latest wins, nothing queues.** A frame that is overwritten in the slot before the sender took it is counted as `dropped` and its buffer is recycled. Three pooled buffers cycle (one being sent, one in the slot, one being filled): no per-frame allocation after warm-up [TESTED: 5000 frames, 3 buffers].
* **At most 3 readbacks pending** (a readback lands 2-3 frames after the request, so a strict one-at-a-time would cap a 60 fps game at 20-30 captured fps), published **strictly in order** (`seq`); a readback that does not come back within 2 s is abandoned.
* **Capture rate adapts to the consumer**: every ~2 s the sent / dropped counters are looked at; more than 25 % dropped = livecap cannot keep up, so the capture rate steps down 20 % (never below 5 fps) and creeps back up (+10 % of the target per clean window). [TESTED, `LiveLinkLogic.RateAdapter`]
* **Pacing** keeps the schedule on a grid with half a frame of slack, so a 60 Hz game gets exactly 30 captures/s on a 30 fps schedule (not 20) and a 500 ms hitch is not followed by a burst. [TESTED: 60/20, 60/30, 60/45, 120/60, 144/30, 30/30, 90/25 Hz/fps, within 3 %]
* **Frame size**: the requested width clamped to 320..1920 and never above the window, the height from the window's own aspect, both rounded to even numbers, height at most 4096. 1920x1440 @ 1280 gives 1280x960. [TESTED, sweep over 630 screen / width combinations]
* **Everything that can throw is caught**: the game thread never throws because of this feature; warnings are throttled to one per 30 s per kind; 120 capture failures in a row, 60 readback errors in a row, or a black capture of a non-black screen switch the feature off and the legacy files take over.
* **Nothing is paid while livecap is not running**: one coroutine resume per frame, a few comparisons, and a refused loopback connect every 0.5 s backing off to 5 s on a below-normal background thread; no allocations, no log lines.
* The plugin is the TCP **client** (`127.0.0.1:<Port>`); livecap listens (`--ingest-port`, default 8095). Loopback only.

## 3. Wire protocol

All integers little-endian. Plugin to livecap unless stated.

### 3.1 Hello (once per connection)

One text line: `TFGAME1 ` + JSON + `\n`, JSON = `{"build":"live-1","pid":<process id>,"w":<window width>,"h":<window height>,"unity":"<Application.unityVersion>"}`. `w`, `h` and `unity` are cached by the game thread (Unity's Screen API is main-thread only): the sender thread never calls into Unity.

### 3.2 Frame message (repeated)

| offset | size | field | meaning |
|---:|---:|---|---|
| 0 | 4 | magic | ASCII `TFRM` |
| 4 | 4 | meta_len | bytes of UTF-8 JSON after the header (always < 8192, livecap drops the connection above that) |
| 8 | 4 | w | pixel width of the payload image |
| 12 | 4 | h | pixel height |
| 16 | 4 | fmt | 1 = RGBA32 rows **bottom-to-top** (what Unity's readback delivers; livecap flips it), 2 = BGRA32 top-to-bottom, 3 = RGB24 bottom-to-top. This build sends 1 only. |
| 20 | 8 | t_ms | f64, unix epoch milliseconds at capture (`DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()`) |
| 28 | 4 | seq | capture counter, monotonic; a gap means frames were dropped before they left the process |
| 32 | 4 | payload_len | `w*h*4` (fmt 1/2) or `w*h*3` (fmt 3) |
| 36 | meta_len | meta | JSON, 3.3 |
| 36+meta_len | payload_len | pixels | |

That is Python's `struct.Struct("<4sIIIIdII")` (36 bytes). [TESTED] the real C# bytes (`LiveLinkLogic.EncodeHeader`, written by a scratch harness) decode with exactly that struct and equal `struct.pack` byte for byte; the sender thread driven against livecap's real `GameIngest` delivers 117 of 117 frames, upright, with meta, at 29 fps.

The header and the meta go out in one `send`, the pixels in a second one straight from the pooled buffer (no copy). Socket: NoDelay, 4 MB send buffer (a whole frame fits), 10 s send timeout (a consumer that stopped reading that long is treated as gone and the plugin reconnects).

### 3.3 Meta (per frame, built at capture time from the camera as it is then)

```json
{"pw":1920,"ph":1440,"vp":[16 floats, row-major],"gy":13.49,"hero":[-24.2,-8.5],"ts":1,"scene":"Level1","ok":true}
```

* `pw`,`ph`: the game window in pixels (the coordinate space of the overlay; the frame itself is downscaled to `w` x `h`, scale by `w/pw`).
* `vp`: `Camera.main.projectionMatrix * worldToCameraMatrix`, row-major, the **same numbers and format as `agent/view.json`** (`Act.SampleView` computes both; one matrix self-test). World point (x,y,z) to window pixel: `c = vp * (x,y,z,1)`, `px = (c.x/c.w*0.5+0.5)*pw`, `py = (1-(c.y/c.w*0.5+0.5))*ph` (origin top-left).
* `gy`: hero ground y; `hero`: `[x,z]`; read live from `PlayerMovement` (the 4 Hz perception snapshot lags up to 0.25 s).
* `ts`: `Time.timeScale`; `scene`: active scene name; `ok`: the matrix self-test result. Without a camera (menus, loading) `vp` is `[]` and `ok` false.

### 3.4 Control (livecap to plugin)

Newline-terminated JSON lines, read by a background thread. `{"cap":{"fps":30,"w":1280}}` retunes the capture: fps clamped to 5..60, w to 320..1920 (rounded to the nearest integer), either key may be absent. `{"ping":1}`, unknown keys, other lines and garbage (also lines over 4096 bytes) are ignored. [TESTED, incl. python's `json.dumps` spacing, a line split across two TCP segments, nested unknown keys, braces inside strings]

`"paused":true|false` (an addition: the current `tools/livecap.py` sends `{"cap":{"fps":30,"w":1280,"paused":<no viewer>}}` "to tell the plugin to stop / resume its in-game capture too"): while `true` the plugin stops capturing (no capture, blit, readback or copy at all; the link stays up) and `LiveLink.Connected` stays true, so the legacy screenshots do not resume for a pause; `false` resumes at the next frame; a line without the key changes nothing; a new connection always starts unpaused. [TESTED: parser, loopback, the simulated player loop, and livecap's real `GameIngest` pausing and resuming the sender thread]

### 3.5 Reconnect

Connect timeout 2 s; on any failure the socket is closed and retried after 0.5, 1, 2, 4, then 5 s (a session that lasted 5 s or more starts over at 0.5 s; a flapping one keeps backing off). One "not listening" line per outage, one "connected" and one "lost" line per session (info lines are throttled to one per kind per second, warnings to one per kind per 30 s). [TESTED against a loopback server: close, restart, listener gone and back.]

## 4. Config (`BepInEx/config/dev.thronefall.trainer.cfg`, section `[Live]`)

| key | default | meaning |
|---|---|---|
| `Enabled` | `true` | `false` = nothing runs (no coroutine, no thread, no caps entry) |
| `Port` | `8095` | livecap's ingest port |
| `Width` | `1280` | frame width, 320..1920; livecap can override at runtime (`cap.w`) |
| `Fps` | `30` | capture rate, 5..60; livecap can override (`cap.fps`) |
| `FlipY` | `auto` | `auto` = detect once whether the capture comes out upside down and correct it (section 7); `on` / `off` force a vertical flip of the downscale |

Code-level knobs in `Coach`: `LiveMarkersEvery = 0.1` s, `LiveShotLinkedEvery = 30` s. A second section, `[Perf] Enabled=true`, switches the frame-time instrumentation of section 11.

## 5. What else changed in this build (act-2)

* **`Coach.PerFrame`**: while `LiveLink.Connected` (frames were handed to the socket in the last 3 s and the link is up) `live.jpg` is not written at all and `live.png` drops to every 30 s; with no link both behave exactly as before (when the link drops, the 2 s live.png cadence resumes at once, not after the leftover 30 s). `markers.json` is written every 0.1 s (was 0.25 s) and every point now also carries `"wx"`,`"wz"` (world x,z, 2 decimals) next to the screen `x`,`y`; all old fields are unchanged.
* **`Act`**: `view.json` every 0.05 s (was 0.25 s), still atomic, schema unchanged plus `"tms"` (unix ms) and `"seq"` (counter); `caps.json` advertises `"live.v1"` in `caps` while LiveLink is enabled, `"perf.v1"` while the instrumentation is on, plus `"live_connected":true|false` (rewritten when the link comes up or goes down, once Act is running; otherwise every 30 s as before); `Act.BuildId` is `act-2`.
* **`Act.AtomicWrite` runs on a background thread** (`src/AsyncWriter.cs`, latest text wins per path): same signature and the same tmp + delete + move sequence, but the game thread now only stores the text (about 1 us per call [MEASURED]) instead of paying 0.2-0.5 ms per write on a quiet disk and 5-20 ms when an antivirus scanner or the drive hiccups. Raising `view.json` from 4 to 20 writes a second would otherwise have made that cost five times larger, and a stutter investigation must not contain its own stutter. The writer retries a few times when a reader (livecap, the coach server) has the file open; readers see either the old or the new file, or for a moment none (Windows reports a delete-pending file as access denied, python's `OSError`), exactly as before. [TESTED: 20 KB replacements read by a polling reader, 7808 clean reads, 0 torn.] Not changed: `markers.json` in `Coach.PerFrame` still writes synchronously (now at 10 Hz; its cost shows up in perf.json's `coach` section) and the other direct `File.WriteAllText` calls in `Act`.
* **Retreat fix** (`ActLogic.ChooseRetreat`, `Act.DoRetreat`): an `avoid` zone is created around the very spot the hero is pinned at, so the old 8-30 m back point was nearly always inside it and `DoRetreat` failed with "retreat point lies inside an avoid zone". Zones now only forbid TARGETING, never walking: the retreat prefers the most recent trail point that is >= minAway from the hero and outside every zone; else the same with the window stretched to 45 m; else the trail point with the most clearance (distance to a zone centre minus its radius, worst zone), i.e. out of the zone the fastest. Only "no candidate at all" fails; the hint / castle fallbacks and the no-zone behaviour are unchanged. The ack detail says whether the target is outside the zones or still how many metres inside. [TESTED, 20 checks incl. the live case: hero inside a 12 m zone, trail entirely inside a zone, no zones, hint / castle fallbacks]

## 6. Cost

| what | cost |
|---|---|
| game thread, per captured frame | three parts: the GPU API calls (capture copy, blit, request) [NOT VERIFIED, expected 0.1-0.3 ms]; the per-frame meta, 8 us [MEASURED, .NET 8, Unity's Mono is 2-4x slower]; the readback copy of 4.9 MB (1280x960), 0.74 ms [MEASURED with `Buffer.BlockCopy`, the same memcpy `NativeArray.CopyTo` does]. About 1 ms per captured frame, i.e. about 30 ms per second of game-thread time at 30 fps (3 %); the periodic status line prints the real number (`main-thread=`). |
| game thread, nobody listening | one coroutine resume and a few comparisons per frame |
| first frame only | mean-brightness self-check 0.44 ms; the orientation / colour probe is one synchronous `CaptureScreenshotAsTexture` (a one-off hitch of a few tens of ms) plus 61 us of grid sampling, once per session (up to 6 times if the picture is flat), in every `FlipY` mode |
| memory | 3 pooled byte[] of `w*h*4` (4.9 MB each at 1280x960, 11 MB at 1920x1440), a screen-size ARGB32 render texture (11 MB at 1920x1440) and the small one (4.9 MB) on the GPU, driver staging buffers for up to 3 readbacks |
| sender thread | below-normal priority; the kernel copy of each frame into the socket, about 150 MB/s of loopback traffic at 1280x960 @ 30 fps |
| legacy files while connected | `live.jpg` (a full-resolution synchronous grab + JPEG four times a second) is gone; `live.png` still costs one synchronous grab every 30 s (a hitch every 30 s) |
| status files | `view.json` / `caps.json` / `perf.json` writes cost the game thread about 1 us each (the I/O is on a below-normal writer thread); `markers.json` is still written synchronously at 10 Hz |
| perf.v1 | 0.25 us per frame (BeginFrame + 4 Marks + EndFrame) and no allocation [MEASURED, .NET 8]; the once-a-second summary + JSON text 0.14 ms median, 0.4-0.6 ms for the first one, an odd 1-3 ms sample in 3-5 % of the flushes (GC / scheduler noise) [MEASURED: 60 direct calls, twice]; `FramePerf.Init` runs the whole path once at plugin load (13 ms then) so no first-use cost lands in gameplay |

## 7. Failure modes

| situation | what happens | log |
|---|---|---|
| livecap not running | silent retries, legacy files keep working | one `[live] livecap is not listening on 127.0.0.1:8095 (...)` per outage |
| livecap restarts / closes | link down, reconnect with backoff, frames resume | `[live] link to livecap lost after N s (...)`, `[live] connected to livecap ...` |
| livecap too slow | latest frame wins, drops counted, capture rate steps down | `[live] capture rate 30 -> 24 fps (... frames overwritten ...)` |
| livecap stops reading | send times out after 10 s, link drops, reconnect | `lost ... (...)` |
| no async readback on this GPU / API | feature off at start | `[live] disabled: this GPU / graphics API has no async readback` |
| `CaptureScreenshotIntoRenderTexture` throws | the frame is skipped, back-off up to 5 s; after 120 in a row the feature switches off | `[live] capture failed (n in a row): ...` / `[live] switched off: ...` |
| capture is black while the screen is not | the probe notices (reference frame vs delivered), the feature switches itself off so the legacy files take over | `[live] switched off: the capture is black while the screen is not (...)` |
| first frames black (loading screen) | re-checked about once a second, ten times | `[live] self-check: frame N is BLACK ...` |
| picture upside down | `auto` flips it on the GPU from the next frame (and the probe frame in place) so livecap never sees an upside-down frame; undecidable pictures are retried, then left as captured | `[live] orientation probe: ...` |
| red / blue swapped, or brightness off by more than 15 % | warned once with both mean RGB triples | `[live] colour check: ...` |
| window resized | render textures are recreated once nothing of the old size is pending | none |
| window minimised and Unity reports a 0x0 screen [NOT VERIFIED that it does] | no capture; `Connected` goes false after 3 s and the legacy files resume | none |
| a readback never returns | abandoned after 2 s, its slot stays blocked until it lands | `[live] a GPU readback took longer than 2 s: abandoned it` |
| livecap pauses (`cap.paused`: nobody is watching) | capture stops completely, the link stays up, `Connected` stays true; resumes on `paused:false` | `[live] control from livecap: ... paused=yes`; the status line says `(paused by livecap)` |
| `[Live] Enabled=false` | nothing at all | none |

## 8. Verifying at deploy (LogOutput.log)

`Select-String -Path K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log -Pattern '\[live\]|\[act\] act-2|view matrix'`

1. At start: `[live] live-1 ready: in-game capture -> livecap on 127.0.0.1:8095, 1280 px wide @ 30 fps (livecap may override), orientation auto-probed; silent until livecap listens`, and (once the autopilot runs) `[act] act-2 ready: ... view.json (20 Hz), caps.json, live.v1 (in-game frame stream)`.
2. After `python tools\livecap.py` starts: `[live] connected to livecap on 127.0.0.1:8095`, `[live] control from livecap: fps=30 w=1280`.
3. Within the first second: `[live] self-check: first frame 1280x960, mean brightness NN/255 -> capture is NOT black` (a `BLACK` line = the capture is empty).
4. Within a few seconds: `[live] orientation probe: the capture is upright ...` or `... VERTICALLY FLIPPED -> flipping every frame on the GPU from now on` (both give an upright stream), then `[live] colour check: OK, mean RGB on screen (r,g,b) vs delivered (r,g,b)`; a `WARN` here names the problem.
5. Every 30 s while linked: `[live] link=up streaming=yes sent=872 (29.1 fps) dropped=2 readback-errors=0 stalls=0 main-thread=0.84 ms/frame avg, 2.10 max cap=1280x960 @30/30 fps orientation=as captured`. Expect `sent` about 30 fps, `dropped` small, `readback-errors=0`, `stalls=0`, `main-thread` about 1 ms (lower `[Live] Width` if it is much higher).
6. Files: `agent/caps.json` has `"live.v1"` and `"live_connected":true`; `agent/view.json` `seq` advances ~20 per second and `tms` is current; `agent/live.jpg` stops changing while connected; `agent/markers.json` points carry `wx`,`wz`.
7. The stutter itself: compare the game's frame pacing with livecap connected (live.jpg frozen) against the legacy path.

## 9. Not verified without the running game

| item | what reveals it |
|---|---|
| `ScreenCapture.CaptureScreenshotIntoRenderTexture` working under this URP setup. [DECOMPILED: a bare engine call, nothing checkable from managed code] | the `self-check` line (NOT black / BLACK), Unity errors in the log, `capture failed` warnings; a black capture switches the feature off by itself |
| orientation of the captured picture | `orientation probe` line; override with `FlipY=on|off` |
| colour fidelity (channel order, sRGB/linear) [DECOMPILED: `AsyncGPUReadback.Request(tex, mip, TextureFormat.RGBA32)` maps to a graphics format from the project's colour space, so the bytes are RGBA; whether the capture copy applies a gamma step is engine-internal] | `colour check` line |
| capture while the window is minimised | minimise the game: `sent` keeps growing in the next status line (if Unity stops rendering, `streaming=no` after 3 s and the legacy files resume) |
| the real main-thread cost and the 30-60 fps target | `main-thread=` and `(N fps)` in the status line; `capture rate` lines if livecap cannot keep up |
| the stutter fix | frame pacing with livecap connected |
| `AsyncGPUReadback` latency on this GPU | `sent` fps versus `[Live] Fps`; with 3 readbacks in flight a 60 fps game should reach 60 |
| `GC.CollectionCount(0)` on Unity's Mono counting the collections that matter | `gc_count` / `gc_delta` in perf.json should move whenever the game's allocation rate is high; a stall line with `gc` >= 1 is a collection |
| `Time.unscaledDeltaTime` not being clamped | `wall_ms_max` (a wall clock between two `BeginFrame` calls) next to `frame_ms.max` in perf.json: if the wall clock is larger, the engine clamps and the stall lines use the larger of the two |
| the real per-frame cost of perf.v1 on Mono | `plugin_ms` / `self_ms` in perf.json itself |

## 10. Tests and tools

* `dotnet run --project tests\ActLogic.Tests` runs everything below in one process. [TESTED] 234 checks: act.v1 parsing, retreat with and without zones, wire framing / hello / control lines / meta, size and pacing maths, rate adaption, backoff, log throttle, the frame exchange (incl. a two-thread run), the pixel helpers (luma, grid, orientation probe incl. noise and an R/B swap, colour check), the real `LiveSender` thread against a loopback server (hello, frame bytes, control lines split across segments, reconnect, silent outage, stop), the perf.v1 maths (percentiles, ring buffer, window summary, sections, stall attribution, JSON, file cap, zero allocation) and `AsyncWriter` (latest wins, no torn reads, ordered capped appends, failures swallowed, threads).
* Beyond the unit tests, outside the repo (scratch): the REAL `LiveLink.cs`, `FramePerf.cs` and `AsyncWriter.cs` were compiled against a fake `UnityEngine` and driven frame by frame next to a real loopback TCP server and real files. [TESTED] 21 live.v1 scenarios, 102 checks together with the perf ones (idle with nobody listening, 30 fps steady, 60 fps at a 3-frame readback latency = 57.7 fps and at 5 frames = 35 fps, flipped capture corrected incl. the first frame, R/B swap diagnosed without a false flip, black capture switches itself off, stalled / failed / erroring readbacks, resize, a stalled consumer, link flap, manual `FlipY`, flat picture, `Enabled=false`, no async readback, livecap pausing and resuming the capture) and 6 perf.v1 scenarios (our stall = plugin / coach / jpg, engine stall = engine with a GC, the 200 KB cap, `Enabled=false`, per-frame cost, cost of the once-a-second flush). The fake follows the semantics the plugin relies on; it cannot say anything about the real GPU, driver or URP.
* Real consumer: the sender thread driven against livecap's own `GameIngest` (tools/livecap.py, imported read-only): 117 of 117 frames, upright, meta intact, 29 fps, control message applied. [TESTED]
* `tools/live-fake-plugin.py` is the stand-in sender for livecap tests (same protocol).
* Source: `src/LiveLink.cs` (Unity side), `src/LiveLinkLogic.cs` (pure logic), `src/LiveLinkNet.cs` (the socket thread, Unity-free), `src/FramePerf.cs` + `src/FramePerfLogic.cs` (perf.v1), `src/AsyncWriter.cs` (background file writes), `src/Act.cs` (`SampleView`, `view.json`, `caps.json`, `AtomicWrite`), `src/Coach.cs` (screenshot gating, `markers.json`, perf marks), `src/Plugin.cs` (config, `BeginFrame` / `EndFrame`).

## 11. perf.v1: why does the game stutter? (frame-time instrumentation)

The measured problem is 8-36 fps with hitches of 100-500 ms. Before and after every change we need ground truth: how long are the frames, and is the time ours or the engine's / GPU's.

**Where it hooks in** (one-line pairs, nothing else): `FramePerf.BeginFrame()` is the first and `FramePerf.EndFrame()` the last line of `Plugin.Update` (there is no early return in between); `FramePerf.Mark(section, t0)` wraps `Bot.Tick` (in Plugin.Update), `Coach.PerFrame`, `Act.PerFrame` (in a `finally`) and the LiveLink capture tick and readback callback; `Coach` also calls `FramePerf.Shot(1|2)` when a legacy `live.jpg` / `live.png` grab ran.

**What is measured, per frame**
* `frame_ms` = `Time.unscaledDeltaTime`, the game's own frame time; a wall clock between two `BeginFrame` calls is kept next to it (`wall_ms_max`) in case the engine clamps the delta. A frame is closed at the NEXT `BeginFrame`, when the delta of the frame that just ended is known.
* `plugin_ms` = our main-thread time: the span of `Plugin.Update` plus the LiveLink tick and callback (which run outside it). Split into five **exclusive** sections: `cheats` (Plugin.Update minus Bot.Tick), `bot` (Bot.Tick minus Coach.PerFrame minus Act.PerFrame), `coach`, `act`, `livelink`. Sections that sum to the total, so "the longest section" is meaningful.
* GC collections (`GC.CollectionCount(0)`) during the frame, and whether a legacy screenshot ran in it.
* **Not covered**, so it counts as "engine" in a stall line: IMGUI (`OnGUI`), the Harmony patch prefixes (`Patches.cs`, `BotPatches.cs`), the worker threads, everything the game itself does (rendering, physics, GPU waits, vsync).

**`agent/perf.json`**, once a second, written through `Act.AtomicWrite` like `caps.json`:

```json
{"t":1790924856.0,"seq":10,"window_s":5,"frames":272,"fps":59,
 "frame_ms":{"p50":13.51,"p95":15.36,"p99":27.1,"max":1216.8},"wall_ms_max":1216.81,
 "stalls_50":1,"stalls_100":1,
 "plugin_ms":{"avg":1.72,"max":15.09},
 "sections":{"cheats":0.34,"bot":0.55,"coach":0.48,"act":0.24,"livelink":0.12},
 "sections_max":{"cheats":3.44,"bot":2.83,"coach":13.99,"act":3.26,"livelink":1.13},
 "gc_count":1,"gc_delta":0,
 "live":{"enabled":true,"connected":true},"legacy":{"jpg":false,"png":true},"shots":{"jpg":0,"png":0},"self_ms":0.14}
```

`t` unix seconds; `seq` counts the writes; `fps` = frames that ended in the last second; `frame_ms` percentiles (nearest rank, `ceil(p/100*n)`) and the max are over the last 5 s (`window_s`), `stalls_50` / `stalls_100` count frames strictly longer than 50 / 100 ms in that window; `plugin_ms` and the section maps are per-frame averages (and maxima) over the window; `gc_delta` = collections since the previous write; `live` / `legacy` say whether the in-game stream and which legacy screenshots are in play, `shots` how many legacy grabs ran since the previous write; `self_ms` = what the previous write cost the game thread (summary + JSON text). [TESTED: exact schema, culture-invariant, valid JSON under NaN / Infinity]

**`agent/perf-stalls.jsonl`**: one line per frame longer than 100 ms (`max(frame_ms, wall_ms)`), buffered and appended by the writer thread once a second. The file is capped at about 200 KB: when an append pushes it over, the oldest half is dropped (whole lines). A line:

```json
{"t":1790924851.2,"frame_ms":162.3,"wall_ms":162.4,"plugin_ms":152.1,"cause":"plugin","top":"coach","top_ms":150.4,"gc":0,"shot":"jpg",
 "sec":{"cheats":0.3,"bot":0.5,"coach":150.4,"act":0.2,"livelink":0.1}}
```

`cause` = `plugin` when our code accounts for at least half of the frame, `engine` (engine / GPU / OS) when it accounts for at most a fifth, else `mixed`; `top` is the longest exclusive section; `gc` the collections during the frame; `shot` which legacy screenshot ran in it. Reading it: `cause=plugin top=coach shot=jpg` is the legacy synchronous screenshot (the thing `live.v1` removes); `cause=engine gc>=1` is a garbage collection; `cause=engine gc=0` is the GPU, vsync, the OS or another process.

**Cost** [MEASURED, .NET 8; Unity's Mono is slower, `plugin_ms` / `self_ms` in perf.json will say]: BeginFrame + 4 Marks + EndFrame 0.25 us per frame, no allocation (the ring is a fixed array: 2048 frames = 5 s up to ~400 fps); the once-a-second summary (sort of ~300 floats) + JSON text 0.14 ms median, 0.4-0.6 ms for the first flush, an odd 1-3 ms sample (GC / scheduler noise; 60 direct calls timed twice), after `FramePerf.Init` pre-ran the path at plugin load; the files are written by the writer thread. Disabled (`[Perf] Enabled=false`) every hook returns immediately.

**Checking it after deploy**: `Get-Content K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent\perf.json` (path as `Recorder.AgentDir`), then `Get-Content ...\perf-stalls.jsonl -Tail 20`. Compare `frame_ms.p99` / `stalls_100` with livecap connected (`live.connected` true, `legacy.jpg` false) against the legacy path (`legacy.jpg` true); the stall lines show which of them cause the hitches.
