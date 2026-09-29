# Thronefall Campaign Autopilot — Status, Known Issues & Handoff

Status: **working end-to-end, verified live** (2026-09-28)
Component: `ThronefallTrainer.dll` → `K:\Downloads-IDM\Thronefall\BepInEx\plugins\`
Toggle: **F6** (persisted in `BepInEx\config\...\ThronefallTrainer.cfg` as `Bot.AutopilotEnabled`)
Telemetry: `BepInEx\plugins\bot-log.jsonl` (~4 Hz JSONL + event notes)

---

## 1. What it does

A full campaign autopilot for Thronefall (BepInEx + Harmony, net472):

`title screen → level-select map → pick unbeaten level → play match`
`  day: collect coins → spend gold on builds/upgrades → start night`
`  night: engage/clear waves (cheat-assisted) → repeat`
`→ victory frame → back to map → next unbeaten level`

It also auto-resolves every blocking UI frame that would otherwise freeze input:
upgrade choices, perk/level-up selections, reward frames, escapable menus.

## 2. Architecture

| File | Role |
|---|---|
| `src/Plugin.cs` | BepInEx entry. Overlay menu (F1), hotkeys, config bindings, bot enable + survival-cheat bundle, `Bot.Tick()` pump |
| `src/Bot.cs` | FSM (`BotMode`), steering targets, watchdog, UI resolver, build holds, JSONL log |
| `src/BotPerception.cs` | `Snapshot` — one read of game state per decision tick (hero, coins, enemies, buildings, horn, map nodes, balances) |
| `src/BotPatches.cs` | Harmony prefix on `PlayerMovement.MoveScript` + `PlayerBallMovement.MoveScript` — rewrites `inputVector` from `Bot.DesiredDir` (camera-relative). Bot off = passthrough |
| `src/Patches.cs` | Cheat patches: `Hp.TakeDamage` (god/instant-kill), `PlayerInteraction.SpendCoins`/`SpendEnergyCores` (FreeBuild), `Coinslot.AddFill` (InstantBuild), `Hp.Start` (enemy HP mult), `LocalGamestate.SetState` (NeverLose), `Weapon.Attack` (MultiShot) |
| `src/ThronefallTrainer.csproj` | net472, `GameDir=..\..`, references game's Managed DLLs. **No auto-deploy** — manual copy |
| `decompiled/` | Reference dumps of game classes the bot calls — verify against these before touching API usage |

Hotkeys (from overlay footer): `F1 menu | F2 kill | F3 revive | F4 +100g | F5 tp | F6 bot`

### Bot survival bundle (`Bot.BotSurvivalCheats`, default **true**)
Applied on enable, restored on disable: `GodHero`, `GodAll`, `InstantRevive`,
`NeverLose`, `RegenEnabled`+`RegenMult=20`, `CoinMagnet`+`MagnetRadius=500`,
`InstantKill`, `NoCooldown`. **The autopilot is cheat-dependent by design** —
night clears rely on InstantKill; without it the bot fights greedily and dies.

## 3. FSM modes (`BotMode`)

| Mode | Trigger → Action |
|---|---|
| `ResolveUI` | Blocking UI present → resolves it (see §4). Runs before everything else |
| `EnterLevel` | `_LevelSelect` scene → nearest **unbeaten** `LevelInteractor` (`beatenBest` via `LevelProgressManager`; all beaten → nearest playable for coin farming) → `InteractionBegin` + `TransitionFromLevelSelectToLevel`; seeds `fixedLoadout` into `PerkManager` first |
| `CollectCoin` | Day, coins on ground → nearest `TagManager.freeCoins` entry |
| `SpendGold` | Day, `NearestBuild` interactable (`CanBeInteractedWith`) and gold>0 or harvestable → walk, `Focus` (harvest) + `InteractionBegin`, pump `InteractionHold` at 0.4 s |
| `Engage` | Night / enemies present → pursue nearest enemy, `ManualAttack.TryToAttack()` every tick |
| `StartNight` | Nothing left to spend/collect → `Nighthorn.instance.InteractionBegin` (auto-harvests + starts wave); horn inactive/missing → `DayNightCycle.SwitchToNight()` throttled 15 s |
| `ReturnHome` / `HoldCastle` | Strayed >14 m from castle → drift back / hold |
| `Idle` | No valid snapshot (loads, menus) |

Decisions run at `DecisionInterval = 0.25 s`.

## 4. Blocking-frame resolver (`HandleBlockingFrame`)

Order matters — top to bottom:

1. **`ChoiceManager` (pre-gate)** — `ChoiceCoroutineRunning && ChoiceCoroutineWaiting`
   → `choiceToReturn = first availableChoices where CanBePicked`, 1 s throttle.
   Hoisted above the `freezePlayer` gate because a pending choice freezes
   `BuildingInteractor` holds *even when its frame doesn't freeze the player*.
   Without this, `SpendGold` deadlocks on upgrade-choice slots.
2. **Freeze gate** — `frame == null || !frame.freezePlayer` → done. The
   non-freezing campaign-map UI is never touched.
3. **End-of-match** — frame contains `BackToLevelSelectHelper` AND
   (`canNotBeEscaped` OR `frameSeen ≥ 2`) → `SceneTransitionManager.TransitionToLevelSelect()`.
4. **Perk frame** — `PerkSelectionItem` children → select first unselected
   (via its `PerkSelectionGroup`), close.
5. **Generic** — `CloseActiveFrame()` if escapable, else `frame.Apply()`,
   2 s throttle. `frameSeen` counts how often the same frame survives a close —
   an escapable frame that keeps coming back *and* has a back-to-map helper is
   treated as end-of-match (this is how Frostsee's victory frame works).

## 5. Day economy & the stall fix

`SpendGold` drives `BuildingInteractor`:

- `TagManager.playerBuildingInteractors` filtered by `CanBeInteractedWith`
  (true only while the slot has work: build/upgrade to pay, or harvest payout).
- Pickup: `Focus()` (income buildings pay out on focus) + `InteractionBegin`.
- Hold: `InteractionHold` pumps one coin at a time — any `Balance > 0` works.
- Retarget/mode change → `Unfocus` + `InteractionEnd` (`ReleaseBuild`).

**Stall fix (the reason this doc exists):** `InteractionHold` early-outs when
the slot deny-loops — e.g. a Craaghelm upgrade costing **energy cores** the
hero doesn't have, or `isWaitingForChoice`. `CanBeInteractedWith` stays true,
so the bot used to glue to that slot forever.

- **Spend-stall watch** — on pickup, record `Balance`+`CoreBalance`; reset on
  any change. **7 s of zero progress → park the slot.**
- **Park list** (`BotPerception.buildIgnore`) — parked slots are skipped in the
  scan. Park duration is **rest-of-day** (600 s); the list **clears on
  `IsNight`** (dusk resets every interactor anyway → fresh retry next day).
- Why park-for-day and not 20 s: expired parks re-entered the scan, so
  `NearestBuild` never emptied → the `StartNight`/`SwitchToNight` branch was
  never reached → **the day could never end**. With park-for-day the pool
  drains → night starts. This was verified live.

## 6. Stuck watchdog

Three strikes → teleport nudge toward `AimPos`. A strike requires, per ~2 s
window: `DesiredDir ≠ 0`, hero moved <0.35 m, **and** aim distance *not
decreasing* (closing-guard — a healthy pursuit that's closing range is never
nudged). Resets on Idle/no target.

## 7. Verified live (bot-log.jsonl, all-time)

30,276 lines since first deploy — full campaign loop confirmed:

| Note | Count | Meaning |
|---|---|---|
| `build-hold` | 3721 | day-economy holds pumping |
| `switch-night` | 71 | horn-missing fallback started night |
| `transition-level` | 74 | `TransitionFromLevelSelectToLevel` fired |
| `level-interact` | 74 | map node interaction |
| `frame-close` | 126 | generic/perk frames resolved |
| `choice-pick` | 27 | upgrade choices auto-picked (incl. mid-hold) |
| `build-stall` | 50 | dead slots parked |
| `stuck:1/2/3` + `teleport-nudge` | 435 / 123 | wedge → recovery, self-resolves |
| `invalid` | 10890 | ticks during scene loads (noise — see §8) |

Observed end-to-end: `AfterMatchVictory` → `_LevelSelect` (`lvln:10` nodes) →
`level-interact` → `transition-level` → new Frostsee run → day economy →
`switch-night` → night `Engage` → victory → repeat.

## 8. Known issues / problems

Real defects or sharp edges, ranked by impact:

1. **Wall-wedges (functional but noisy).** Steering is straight-line;
   `NearestBuildPos` is the *building transform center*, i.e. inside its
   collider. The hero rubs walls → `stuck` strikes → `teleport-nudge`. 123
   nudges all-time; every one self-recovered but it's ugly and costs seconds.
   → Fix idea: stand-off target (offset `NearestBuildPos` toward the hero by
   the interact radius ~1.5 m) or real pathing.
2. **Parked slots burn 7 s each.** A fully dead pool takes `n × 7 s` to drain
   (Frostsee: ~35 slots ≈ 4 min). Tolerable, but could be O(1) — pre-filter
   core-cost upgrades when `CoreBalance == 0` (needs a public cost probe —
   `BuildingInteractor` doesn't expose `nextUpgradeCost`; check decompiled
   `Buildable`/cost fields before attempting).
3. **`frameSeen` escalation risk.** An *escapable* frame surviving two closes
   that contains `BackToLevelSelectHelper` → treated as end-of-match →
   `TransitionToLevelSelect` = **mid-run exit**. If a pause/settings frame
   ever embeds that helper, the bot abandons the run. Mitigation today:
   don't pause while the bot runs. Proper fix: restrict escalation to
   AfterMatch* game states or the known victory frame name.
4. **Cheat dependency.** Wave clearing assumes `InstantKill`+`GodAll`. Disable
   `Bot.BotSurvivalCheats` and the autopilot is a demo, not a player.
5. **`inter` field flickers 0↔75.** `InteractorCount` is sampled inside the
   1 Hz level-scan block, so alternating ticks read 0 — cosmetic.
6. **`wave` semantics.** `Wavenumber` reports the *upcoming* night index
   (`11/13` during day = night 11 is next). Correct but reads oddly.
7. **`transition-level` fires twice per cycle.** First interact opens the
   pre-level frame → `ResolveUI` closes it → second interact transitions.
   Works; slightly clunky.
8. **`buildIgnore` isn't scene-scoped.** Keys are per-instance so stale
   entries can't collide with a new scene's interactors, but for hygiene it
   could clear on scene change, not just on night.
9. **`invalid` log spam.** ~36 % of lines are load-ticks. Could suppress or
   group into `loading` notes.
10. **Greedy combat.** `Engage` pursues nearest enemy in a straight line — no
    kiting, spacing, or target priority. Only viable thanks to cheats.
11. **Deploy friction.** DLL is locked while `thronefall.exe` runs — must
    stop the process before copying. No build-time deploy step.

## 9. Future improvements / enhancements

- **Nav-aware steering** — the game ships `AstarPathfindingProject` (already a
  csproj reference). Query a path instead of straight-line + nudges.
- **Stand-off interaction point** — cheapest wedge fix: aim at
  `pos + (hero→pos).normalized * -1.5 m` for build targets.
- **Choice/perk heuristics** — currently first-`CanBePicked`. Add scoring:
  economy picks early, damage/defense for `FinalWaveComingUp`.
- **Core-cost pre-filter** — skip parking cost entirely by probing upgrade
  cost type when `CoreBalance == 0`.
- **Bot status overlay** — extend the F1 window: mode, target name, gold,
  `bld` remaining, stall/nudge counters.
- **Config-ify timings** — `DecisionInterval`, 7 s stall watch, nudge
  distance, hold throttle → `BepInEx` config entries.
- **Run metrics** — append a per-run summary line (waves, gold spent, stalls,
  nudges) on each `AfterMatchVictory`.
- **Pause-frame safety** — gate the `BackToLevelSelectHelper` escalation on
  `AfterMatch*` states only.
- **Noise control** — collapse `invalid` ticks into one `scene-load` note.
- **Auto-deploy** — csproj post-build copy, guarded by a `game running` check.
- **Tests** — none exist. Perception/decide logic could go behind interfaces
  for a mock harness; Harmony surface stays manual-verified against
  `decompiled/`.

## 10. Handoff — reproduce / verify

### Build
```powershell
dotnet build K:\Downloads-IDM\Thronefall\Trainer\src\ThronefallTrainer.csproj -c Release
# output: K:\Downloads-IDM\Thronefall\Trainer\bin\ThronefallTrainer.dll
```
(`GameDir` defaults to `..\..` = the repo's game root. Building from a clone
elsewhere: `-p:GameDir="C:\Path\To\Thronefall"`.)

### Deploy (game locks the DLL — stop it first)
```powershell
Stop-Process -Name thronefall -Force -ErrorAction SilentlyContinue
Copy-Item K:\Downloads-IDM\Thronefall\Trainer\bin\ThronefallTrainer.dll `
          K:\Downloads-IDM\Thronefall\BepInEx\plugins\ -Force
Start-Process K:\Downloads-IDM\Thronefall\thronefall.exe `
          -WorkingDirectory K:\Downloads-IDM\Thronefall
```

### Verify
```powershell
# live tail
Get-Content K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl -Tail 20
# behavior histogram
$l = Get-Content K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl -Tail 500
$l | % { ($_ -replace '.*"note":"','' -replace '".*','') } | Group | Sort Count -Desc
```

Healthy signs: `build-hold`/`build-stall` cycling by day, `switch-night` before
waves, `choice-pick` near slots, `level-interact`+`transition-level` on the
map, `frame-close`/`match-end` after victory. Stuck signs: `bld` frozen with
`build-hold` spam and no `build-stall`, or `wave`/`night` never advancing.

### Log fields
`t`(unscaled s) `mode` `state`(`LocalGamestate`) `scene` `night` `wave`(next/total)
`foes` `coins` `gold` `hp` `pos` `ls`(level-select open) `lvln`(playable nodes)
`inter`(interactor count, flickery) `lvld` `horn` `hd`(horn dist) `bld`(interactable slots) `note`

### Key game APIs (all verified against `Trainer\decompiled\`)
`TagManager.instance.playerBuildingInteractors` / `.freeCoins` /
`.enemies` · `BuildingInteractor.{CanBeInteractedWith,Focus,Unfocus,InteractionBegin,InteractionHold,InteractionEnd,canBeHarvested}` · `UIFrameManager.instance.ActiveFrame`, `UIFrame.{freezePlayer,canNotBeEscaped,Apply}` · `ChoiceManager.instance.{ChoiceCoroutineRunning,ChoiceCoroutineWaiting,availableChoices,choiceToReturn}` · `Nighthorn.instance` · `DayNightCycle.Instance.{CurrentTimestate,RemainingAutoDayTime,SwitchToNight}` · `LevelInteractor.{CanBePlayed,PlayerTeleportPosition,levelInfo}` · `LevelProgressManager.instance.GetLevelDataForScene(scene).beatenBest` · `SceneTransitionManager.instance.{TransitionToLevelSelect,TransitionFromLevelSelectToLevel,TransitionFromNullToLevelSelect}` · `PlayerInteraction.instance.{Balance,EnergyCoreBalance}`

### Pitfalls
- **Don't pause** while the bot runs (see §8.3 — escalation can exit the run).
- `decompiled/` dumps go stale after game updates — re-verify API names if the
  game patched.
- `spendWatch`/`frameAction`/`buildInteractAt` all use `Time.unscaledTime` —
  safe across pauses, which is deliberate.
- `bot-log.jsonl` grows ~10 MB/hr of play; rotate/delete freely, it's append-only.

### Next actions (priority order)
1. Stand-off build target (kill the nudge noise) — smallest diff, biggest win.
2. Core-cost pre-filter (skip 7 s-per-dead-slot drain cost).
3. Pause-safety gate on `BackToLevelSelectHelper` escalation.
4. `invalid` log suppression + per-run metrics.
5. Choice scoring.
