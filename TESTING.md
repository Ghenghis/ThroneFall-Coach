# Testing & Verification

Manual e2e acceptance checklist + the automated v3 gates.
Run after any `dotnet build` + deploy, and after any game update.

## 0. Automated gates (run every change)

| Gate | Command | Pass |
|---|---|---|
| Lint | `.\tools\bot-lint.ps1` | `0 FAIL` — incl. `pure-layer` (BotBrain has no Unity/game tokens) + `mode-coverage` |
| Replay | `dotnet run -c Release --project tests\Replay` | `all N fixture(s) PASS` — mode sequence identical |
| Build | `dotnet build src\ThronefallTrainer.csproj -c Release` | 0 errors |

Replay fixtures live in `tests\fixtures\runs\<name>\{ticks.jsonl,events.jsonl,
expected.json,policy.txt?}`; copy a dir from `BepInEx\plugins\agent\runs\*`
and write `expected.json` (`{"legit":true}`) to add one. `policy.txt` beside
the fixture overrides the default table for that replay.

## 0.5 v3 live checkpoints

| Check | Path | Expected |
|---|---|---|
| Recorder | `agent\runs\<runId>\` | ticks.jsonl (~2 Hz), events.jsonl, summary.json at match end |
| Faithful DTO | latest `ticks.jsonl` | all field keys non-empty (`nwc`,`weap`,`cast`,…) |
| Policy | `agent\policy.txt` | `policy vN loaded` in BepInEx log on edit; `policy-reject` events on bad rules |
| Mailbox | `agent\tf-agent\inbox\*.order` | moved to `inbox\done\` within ~1 s; `outbox\state.json` refreshes ~5 s |
| Wedge | `stuck:*` event rate | rare bursts only (was 316 at one castle wall) |
| Castle | tick `cast`+`ta` | non-zero positions in-match |

Log: `BepInEx\plugins\bot-log.jsonl` (~4 Hz JSONL). Tail it with
`Get-Content …\bot-log.jsonl -Tail 20 -Wait`. Field legend: AUTOPILOT §10.

Log: `BepInEx\plugins\bot-log.jsonl` (~4 Hz JSONL). Tail it with
`Get-Content …\bot-log.jsonl -Tail 20 -Wait`. Field legend: AUTOPILOT §10.

## A. Plugin loads (30 s)

- [ ] Game boots to title; `BepInEx\LogOutput.log` contains
      `Thronefall Trainer loaded` (absence → DLL not deployed or BepInEx broken).
- [ ] **F1** opens the overlay; hero freezes while it's open; `=` grip resizes.

## B. Cheat smoke tests (2 min, inside a match)

| Check | Action | Expected |
|---|---|---|
| Economy | F4 | Balance +100 |
| Combat | F2 | All enemies die |
| Revive | F3 | Dead units revive |
| Teleport | F5 | Hero jumps to cursor |
| God | toggle GodHero | Hero HP flat under fire |
| FreeBuild | toggle, hold a build slot | Builds without spending |
| Menu doesn't steer | F1 open, type WASD | Hero stays frozen |

## C. Bot day phase (F6, in-match day)

- [ ] Overlay bot line shows a mode, not `waiting`.
- [ ] `CollectCoin`: `pos` moves toward coins; `gold` rises.
- [ ] `SpendGold`: `build-hold` notes appear; `gold` **drops** over time
      (spending) or `bld` drains (`build-stall` = parked dead slot — OK).
- [ ] Pool empty → `switch-night` note or `horn:true` walk, then
      `night:true`.
- [ ] No `stuck:3`/`unstick`/`snap` spam at a single `pos` for >30 s.
      (Cheat mode uses `teleport-nudge` instead — it must never appear in
      legit mode.)
- [ ] **Legit**: `army-placed` note appears once allies exist before night.

## D. Night phase

- [ ] `mode` = `Engage`; `foes` drains to 0 per wave; `wave` advances.
- [ ] Perk/level-up frame mid-night → auto-picked (`frame-close`/`perk-pick`),
      bot never idles on it.
- [ ] **Legit**: `hp` may drop and recover; `hp < 0` death is OK if the army
      finishes the wave (knockout ≠ defeat); `defeat` only on real loss.
- [ ] **Legit**: nights take minutes — the army + real cooldowns grind slower
      than InstantKill. That's correctness, not a stall.

## E. Match end → campaign loop

- [ ] Victory frame → `frame-close`/`match-end` → scene `_LevelSelect`.
- [ ] Map: `lvln` > 0, `level-interact`, `transition-level` **once each**
      (no double-fire — `sceneTransitionIsRunning` gate), then a match scene.
- [ ] New match starts in day state; cycle repeats without input.
- [ ] Gold/unbeaten-level selection: bot enters a map it hasn't beaten when
      one is available; after `defeat` notes ≥3 on a node it should pick a
      different unbeaten node (session rotation).

## G. Legit-mode gate (fresh save path, 2026-09-29)

The `Bot.BotSurvivalCheats = false` config switch. Verified on a fresh save:

- [ ] `god`/`instantkill`/`neverlose`/`nocooldown` off in config AND live:
      `hp` reaches <1 under fire; `foes` drain at real cadence (slow).
- [ ] **No** `teleport-nudge` notes after process start (old lines persist —
      filter by `t` vs launch time). `unstick:n`/`snap` are the legit
      replacements.
- [ ] `TryToAttack` only — no ~4× fire rate; kills come from the equipped
      weapon + allied units (`ManualAttack found on 'X'` line in BepInEx log
      confirms seeding).
- [ ] `EnterLevel` transitions with no `InteractionBegin` frame open/close.
- [ ] `army-placed` before first night once allied units exist.
- [ ] Hero knockout (`hp` negative, `Idle` mode) recovers at dawn — not a
      `defeat` note.
- [ ] Real defeat → `defeat` note + return to map → different node pick.

## F. Regressions to watch (from AUTOPILOT §8)

| Symptom in log | Likely cause |
|---|---|
| `build-hold` spam, `bld`/`gold` frozen ≥7 s, no `build-stall` | Stall watch broken — check `spendWatchAt` fields |
| Day never ends, `bld` never reaches 0 | `buildIgnore` cleared early or scan re-adds parked slots |
| `horn:false` forever, no `switch-night` | `SwitchToNight` fallback skipped — check Decide order |
| Pending choice stalls holds, no `choice-pick` | ChoiceManager gate moved below `freezePlayer` check |
| Escapable frame loop exits mid-run | `BackToLevelSelectHelper` escalation fired on the wrong frame |
| `inter` reads 0 half the ticks | Cosmetic — `InteractorCount` sampled inside 1 Hz scan |
| Teleport-nudges every strike window | Steering wedged on a building collider (known issue #1) |

## Safety rules while testing

- **Never pause** the game during a bot run — the frame-escalation heuristic
  can misread a stubborn pause menu as end-of-match and exit the run.
- Don't run two trainer DLL versions; `BepInEx\plugins` loads both.
- `bot-log.jsonl` is append-only — delete freely between sessions; a stale log
  makes the tail misleading.
