# MiniMax <-> Bot <-> Engineer orchestration

Three loops, each with a heartbeat, cooperating through files in `BepInEx/plugins/agent/`.

| Loop | Where | Cadence | Heartbeat / proof |
|---|---|---|---|
| Bot (plugin) | `src/Bot.cs` Tick, `Coach.cs` polls `coach-commands.json` every ~4 s | 4 Hz decide | `audit.json` (<10 s old), `[coach] user-cmd ->` in `LogOutput.log` |
| MiniMax watch | `tools/coach-server.py` `mm_watch_loop` | ~30-90 s | `mm-heartbeat.json`, `/health` check "MiniMax heartbeat", `mmwatch.jsonl` |
| Engineer (code agent) | reads `proposals.jsonl`, ships code, redeploys | every pass | git log, `AUDIT.md` |

## What MiniMax can and cannot do

MiniMax is a **steering advisor + bug reporter**, not a code editor:

* **Knobs (applied live):** `squad_size`, `reserve_size`, `escort_size`, `army_target`, `build_focus`, `hero_posture`, `night_call`, `clear`.
  Validated + clamped in `validate_patch`, then `guard_patch`.
* **Guards the model cannot bypass** (`guard_patch`):
  * `hero_posture:"fighter"` is forced back to `builder` unless a red alert is live (the army fights, the hero builds).
  * `army_target` moves only in steps >= 10 (it flip-flopped 15->35->15->20->25 every cycle).
  * The plugin treats `army_target` as a **floor** (`Mathf.Max`) so it can never lower the bot's lookahead/playbook target.
* **Proposals (not applied, handed to the engineer):** the optional `proposal` object
  `{"bug","evidence","fix"}` is appended to `proposals.jsonl` (deduped by title, mirrored into the chat log as `[mm-proposal]`).
  Use it for anything a knob cannot fix: pins, abandoned builds, popups, gps failures, idle with gold.
* **Why no direct code edits:** an unreviewed LLM patch deployed into a live game process can crash or cheat-drift the bot.
  The engineer reviews each proposal, builds, lints, tests and deploys. Statuses in `proposals.jsonl`: `open` -> `fixed:<commit>` / `rejected:<reason>`.

## What MiniMax sees every cycle

`audit.json` snapshot, door posts, playbook checklist, activity timeline, alerts, grades, weaknesses, breach doors, net-vs-bot,
plus the **ENGINEERING DIGEST** (`eng_digest`, cached 45 s): event counts of the last 600 events (stuck, quick-sidestep, pin-park,
approach-timeout, door-park, gps-*, rescan-slots, slot-abandon, frame/match-escape, choice-*), last tick nav/build/door fields,
task useful/waste ratio, and game-log warning counts. An event glossary in `MM_SYS` keeps it from misreading detector events
as combat. `RECENT PROPOSALS` prevents repeats.

## Health

`GET /health` checks: plugin feed, live frames, local LLM, MiniMax last call, **MiniMax heartbeat** (loop alive <240 s,
ok/err/applied/not-applied/proposal counters). Link transitions are posted to the chat log (`LINK DOWN`/`LINK UP`).
The apply proof reads only bytes appended to `LogOutput.log` after the write (offset proof), not a sliding tail.

## Engineer procedure (every pass)

1. `Get-Content agent\mm-heartbeat.json` and `/health` — loop alive? errors? not-applied rising?
2. `Get-Content agent\proposals.jsonl` — triage `open` items: verify the evidence against `ticks.jsonl`/`events.jsonl`, fix real bugs,
   reject misreadings (set the status), commit with the proposal title.
3. Build, `bot-lint.ps1`, deploy (`tools/build-and-deploy.ps1`), confirm fresh telemetry before claiming a fix.
4. Restart `coach-server.py` after editing it (the running process keeps the old code):
   `Start-Process python tools\coach-server.py --port 8099 -WindowStyle Hidden`.

## Known limits

* MiniMax has no tool access (no file read, no shell); it only sees what the digest contains. Add a field to `eng_digest` to give it sight.
* A proposal depends on the model's reading of the digest; the first live proposal misread `stuck` events as combat strikes
  (the evidence — 115 stuck events, 46 % waste — was real, the suggested fix was not). The glossary was added in response.
