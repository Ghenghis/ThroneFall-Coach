# Handoff to Devin: Live View, the game-stall investigation, and what is waiting on the user (2026-10-02)

Written by Claude (Claude Code session `d8f96dda-17d8-4f51-ab5e-bcccf1a19ee2`) at the user's request ("finish current task and hand off to Devin").
**Start here, then read `docs/LIVE-VIEW.md` section 7** (the evidence, with numbers) and `CHANGELOG.md` (top entry).

## 0. The ten-line version
* The Live View **video path is done and fast** (livecap + `live.js`, ~53 fps drawn, ~20 ms latency, tests green). When the picture "stops", the **game itself** froze: confirmed from outside the game.
* About **two thirds of the game's stalled time is our own plugin**: the bot's scene scans (~115 ms every 1.0 s, 43%) and the `live.png` write (200-490 ms every 30 s, 21%). Neither is fixed. **Fixing them needs a plugin rebuild and a game restart, so it needs the user's explicit yes** (section 3).
* The plugin's stall log (`FramePerf`) **logs every stall twice** (Unity's delta time arrives one frame late); the "engine" half is an echo. Tooling now corrects for it; the plugin does not yet (section 3, item 3).
* The HUD now says where the stall is, from measurements, and never claims a cause it has not measured. Production livecap runs this code (section 1).
* Ruled out: the local LLM's GPU activity, GPU-bound game, copy-engine / RAM paging, CPU scheduling starvation. Not explained: the unattributed third, rare multi-second freezes (section 4).
* **Nothing is committed or pushed by me.** The working tree holds verified, uncommitted work (section 5). The game, the coach-server and the plugin were not touched.

## 1. State of the running system (as I leave it)
| thing | state |
|---|---|
| game | `thronefall.exe` running (Frostsee), plugin build `act-2` (dll 2026-10-02T07:42Z), caps `act.v1 view.v1 probe.v1 live.v1 perf.v1`, in-game link to livecap connected |
| coach-server | `python tools/coach-server.py --port 8099`, started by hand earlier (not by me), serves `/live.js` from disk on every request: **reload the Coach page (Ctrl+F5) to get the new HUD** |
| livecap | `tools/livecap.py` on :8097 (ingest :8095), respawned by the command-center job `livecap` (every 10 s). Restart = `python tools/livecap.py --stop`, the supervisor brings it back in ~4 s. Runs the code in this tree (GpuWatch, corrected stall causes, period finder). Idle (no viewers) it costs the game nothing: the plugin pauses its capture |
| MiniMax / command center | untouched by me (Auto mode, incidents, engineer queue). The bot's own health on the page was grade D/F with loops on walls/doors; that is the GPS/bot workstream, not this one |
| machine | 90-100% CPU from other tools (Defender, java/jcmd, Kilo, Devin ...), VRAM 96% committed (llama-server 18 GB, dwm 13.5-14.3 GB, game 1 GB) |

## 2. Rules from the user that still apply (do not relax them)
* **No game restart / redeploy without the user's explicit yes.** `tools/build-and-deploy.ps1` kills and relaunches `thronefall.exe`. Build to scratch (`dotnet build -c Release -p:GameDir="K:\Downloads-IDM\Thronefall" -p:OutputPath=<scratch>\`) to check that something compiles; deploy only on a yes.
* **A GitHub PAT sits in `K:\private\.env`: never print, log or use it unless the user asks.**
* Do not change security / system settings yourself (Defender exclusions, NVIDIA overlay, registry). Tell the user; their call.
* Never delete `C:\CrashDumps`; no registry writes; junction-safe deletes. R6BO (the other game) is out of scope here.
* Do not commit / push unless asked. Note `git add -A` sweeps everything in the tree, including the files in section 5 (they are verified, so that is fine, but know it).
* **Honest HUD rule**: the HUD may state where a stall is and what was measured; it must not claim a cause that no measurement supports (the VRAM figure is shown as a fact; no A/B has shown it matters).

## 3. The work queue (priority order)
Items 1-3 change the plugin: **ask the user first** (game restart). The analysis tools to prove them are ready (item 4).

1. **Skip the `live.png` write while the in-game link is up.** `src/Coach.cs` ~170-194 (`LiveShotLinkedEvery = 30f`, `ScreenCapture.CaptureScreenshotAsTexture()` + `EncodeToPNG()` + file write, all on the game thread). Make "linked" mean *no* png (e.g. `LiveShotLinkedEvery <= 0` = never, bound as a config value); the existing `nextLiveShot` logic already resumes the 2 s fallback the moment the link drops. **Do not use `[Coach] LiveShot=false`**: it also stops `markers.json` (the overlay feed). Consumers are safe: `fetch_live_png` and the health check already prefer livecap (`tools/coach-server.py` ~963, ~993); `tools/e2e-audit.ps1` line 30 expects a fresh `live.png`, teach it to accept a running livecap. Expected: the 30 s freeze (the longest single stalls in the log) disappears.
2. **Fix `FramePerf` itself** (`src/FramePerf.cs`, `src/FramePerfLogic.cs`): classify a stall by `wall_ms` (the plugin's own clock, same frame as `plugin_ms`), log **one line per stall**, keep Unity's `unscaledDeltaTime` only as a cross-check, and rotate `perf-stalls.jsonl` (keep the previous generation) instead of dropping the oldest half (a rare freeze is gone within ~20 min today). Update `tests/ActLogic.Tests` (it covers FramePerfLogic). After this, `stallstat.real_events` is a pass-through.
3. **Share and stagger the bot's scene scans** (`src/BotPerception.cs` ~1363-1428 and ~1819-1823: Shrine, CutOpenPathInteractor, BuildSlot, BuildingInteractor, LevelInteractor, InteractorBase, all `Object.FindObjectsOfType<..>(true)` on 1 Hz timers that re-arm from the same tick and so stay phase-locked). Plan: wrap each scan in its own `FramePerf.Mark` section **first** and measure (the 43% share is measured, the split between the six scans is not); then serve BuildingInteractor / LevelInteractor / CutOpenPathInteractor from one `InteractorBase` scan filtered by type, move BuildSlot / Shrine to other ticks or a slower cadence. Behaviour must stay identical: `MaxLevelSum`, `gateBuilds`, `InteractorCount` feed `Tasks.cs` verification, the door logic and `Bot.cs` vacuum-diag. `Bot.cs` / `BotPerception.cs` are your hot files: coordinate with whatever GPS work is in flight.
4. **Prove each change** (read-only tools, ready): `python tools/perf-watch.py --history 10` (no `PERIODIC ... 30.0 s` line at 200 ms; the `bot` section's share and p50 far below 43% / 115 ms) and `python tools/frame-cadence.py --secs 240` (real presentation gaps >= 150 ms per minute, no 30 s pattern, the plugin's lines matched to real gaps). Run both before and after, same session conditions (the machine is noisy; compare shares and patterns, not single numbers).
5. **Open investigation (no owner yet):** the rare multi-second freezes and the unattributed third (`LIVE-VIEW.md` 7.5). After a long freeze, copy `agent/perf-stalls.jsonl` immediately. An ETW trace with wait stacks (`wpr`) around one would settle whether it is the engine, Defender's on-access scan (game / agent folder not excluded) or something blocking inside our coach section (a 1.4-1.6 s `coach` stall was seen twice).
6. **Older open items** (from the notes of this session, not mine to finish): command-center architecture doc, GPS docs (`BOT-WEAKNESSES.md`), GPS build #3 deploy, Link v2 push channel (design only), UI polish (right-click act menu / probe popup, theater mode), R6BO keymap repair (needs the user's yes) and R6BO docs workflow.

## 4. What the evidence says (details and numbers: `docs/LIVE-VIEW.md` section 7)
* Real stalls, each counted once (23 min): 543 (24 per minute), 85 s stalled, p50 119 ms, max 1.4 s. Plugin 64% + mixed 1%, unattributed 35%. By section: `bot` 43% (295 stalls, p50 116 ms, recurring every 1.0 s), `coach` 21% (71 stalls, p50 241 ms; the 30.0 s `live.png` cycle, 200-490 ms).
* Independent confirmation: `tools/frame-cadence.py` (WGC timestamps) found the same gaps; every plugin stall line >= 250 ms matched a real gap. Presented 52.9-54.7 fps, p99 gap 83 ms.
* The 30 s timer: `perf-watch --history` reports it by itself; `agent/live.png` is rewritten at every one of those stalls; the phase of the 30 s runs jumps when the link drops and returns (a re-armed timer).
* Ruled out (numbers in 7.4): LLM GPU activity (r = -0.01), game GPU-bound (3D 16-21%), copy-engine paging (~1%), RAM paging, CPU scheduling starvation (spinner max 82 ms).

## 5. What is in the working tree (all uncommitted, all verified)
| file | what |
|---|---|
| `tools/livecap.py` (modified) | `GpuWatch` (VRAM per process / adapter via `win32pdh`, 5 s, only while watched, `--gpu auto\|on\|off`, `/stats` `gpu`), `gpu` relay + late-joiner replay (< 30 s old), `Hub.stall_causes` (each stall once, `sections`, `period_s`), `perf` relay |
| `tools/live.js` (modified) | HUD: game telemetry line, amber timer note, VRAM line, all fitted to the pane width (the Coach Live pane is ~320 px) and dropped from the top in short panes; sentences that name where the stall is (`plugin code is stalling the game (64% of stalled time: bot 43%, coach 21%)`) and never a cause; stale readings vanish (perf 6 s, VRAM 20 s) |
| `tools/stallstat.py` (new) | pure helpers: `real_events` (drops the log's echoes), `shares`, `find_period` (support-based, chance-tested, robust to noise / phase resets / missed cycles) |
| `tools/perf-watch.py` (new) | live view and `--history MIN` of the plugin's stall log, corrected, with the periodic-timer finder |
| `tools/frame-cadence.py` (new) | the window's real presentation gaps (ffmpeg `gfxcapture` timestamps) joined with the plugin's stall lines; read-only |
| `tests/test_livecap.py`, `tests/test_live_page_e2e.py` (modified) | GpuWatch (fake `win32pdh`, idle gating, relay, staleness, real counters), echo / period / sections in `stall_causes`, HUD sentences, narrow-pane fit |
| `tests/test_stallstat.py`, `tests/test_perfwatch.py`, `tests/test_frame_cadence.py` (new) | the pure helpers and the two CLIs (mutation-checked) |
| `docs/LIVE-VIEW.md` (modified), `CHANGELOG.md` (modified), `docs/HANDOFF-LIVE-VIEW.md` (this file), `AUTOPILOT.md` (pointer added) | documentation |
| note | `tools/__pycache__/livecap.cpython-314.pyc` is **tracked** in git (it shows as modified every run); consider `git rm --cached` + `.gitignore` for `__pycache__` |

## 6. How to verify everything (run ONE suite at a time; no test needs the game)
```
cd K:\Downloads-IDM\Thronefall\Trainer
python tests/test_stallstat.py        # 16 checks
python tests/test_perfwatch.py        # 17
python tests/test_frame_cadence.py    # 10
python tests/test_livecap.py          # 113  (frame protocol, flow control, security, overlay, perf + stall causes, GpuWatch, sources, ingest)
python tests/test_page_js.py          # 16   (the served Coach page has no script error)
python tests/test_wgc_real.py         # 12   (real ffmpeg gfxcapture on a stand-in window)
python tests/test_command_center.py   # 106
python tests/test_incidents.py        # 44
python tests/test_mm_engineer.py      # 419
python tests/test_live_page_e2e.py    # 39, run ALONE, last (headless Edge; two concurrent runs measured 33 fps and failed its 40 fps check)
```
Exact counts and what each proves: `docs/LIVE-VIEW.md` section 6. Reading `perf.json` / `perf-stalls.jsonl` live: `python tools/perf-watch.py --secs 60`.

**Status at handoff (2026-10-02 ~02:55):** every suite above was run green on the final code **except `test_mm_engineer.py`**, whose last re-run I stopped at the user's request (it was green, 419 checks, earlier the same night; it does not import anything changed since). The page measured 58.5 fps drawn at 12 ms latency in the e2e. I stopped all my test / probe processes so you can test on a quiet machine; the only thing of mine still running is the production livecap (pid changes on restart), intentionally, on the final code.

## 7. Gotchas that cost time this session
* `python` run with cwd in `%TEMP%` hangs on `import websockets`: run from the repo root.
* **Bash heredocs mangle backslashes** in this environment: write files with the Write / Edit tools, not `cat <<EOF` / `python - <<EOF` containing `\n`.
* A `( ... ) &` inside a background Bash call survives and starts a **second** battery in parallel; run the loop itself as the background command. Concurrent suites distort each other (CPU contention).
* The stall log is capped at ~200 KB and halves itself: analyse it soon after an event.
* `GpuWatch` only samples while somebody watches (idle = zero cost), so `/stats` `gpu` is `starting` with no viewer.
* Printing a bullet (`●`) in a failing check under a cp1252 console used to crash `test_live_page_e2e.py` and hide the real failure; fixed in `check()`.

## 8. Questions only the user can answer (ask them; do not assume)
1. Go-ahead to rebuild the plugin with items 1-3 above and restart the game (and when: it ends the current run).
2. Defender real-time scanning of `K:\Downloads-IDM\Thronefall` (MsMpEng is at ~170% CPU; the folder is not excluded) and the NVIDIA capture module (`nvspcap64.dll`) loaded in the game: leave as is, or change? Both are untested suspects for the unexplained freezes.
3. Unload / shrink LM Studio's model for an A/B (VRAM is 96% committed; the link to the stalls is unproven, and it would interrupt MiniMax / coach).

## 9. Paste-ready message for Devin
> Read `K:\Downloads-IDM\Thronefall\Trainer\docs\HANDOFF-LIVE-VIEW.md` first, then `docs/LIVE-VIEW.md` section 7. The Live View is finished and verified (production livecap runs it). The remaining work is in the plugin (skip the 30 s `live.png` write while linked; fix FramePerf's double logging; share/stagger BotPerception's six FindObjectsOfType scans) and **needs the user's explicit yes before any rebuild/restart of the game**. Use `tools/perf-watch.py --history 10` and `tools/frame-cadence.py --secs 240` before and after. The working tree has verified uncommitted files (section 5); the GitHub PAT in `K:\private\.env` must never be printed.
