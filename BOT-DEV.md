# Extending the Autopilot

Developer guide for `Bot.cs` / `BotPerception.cs` / `BotPatches.cs`. Read
`AUTOPILOT.md` first for architecture and known issues; this file is the
"how do I add X" companion to the README's "Adding a new cheat".

## Pipeline recap

```
Plugin.Update (every frame)
 └─ Bot.Tick()
     ├─ if (Legit && hasTarget) DesiredDir ← DirTo(hero, NavSteerPoint)  (per frame)
     ├─ BotPerception.Capture() → Snapshot        (read game state)
     ├─ Bot.Decide(in s)        → mode + target   (every DecisionInterval=0.25s)
     ├─ steering: DesiredDir ← DirTo(hero, NavSteerPoint(hero, AimPos))
     └─ watchdog / build holds / UI resolve / logging
BotPatches.MoveScript prefix: inputVector := DesiredDir (camera-relative)
```

Two contracts keep it simple: **perception is read-only** (Capture must never
mutate the game) and **decide is stateless between ticks** except through the
explicit static fields listed below.

## Legit gating (`Bot.Legit`)

`Bot.Legit = !BotSurvivalCheats`, set by `Plugin.SetBotEnabled`. Every
player-impossible capability MUST check `Legit` first:

- attacks: legit → `ManualAttack.TryToAttack()` only (`Attack()` bypasses
  `cooldownTime` — cheat); no `Hp.TakeDamage` fallback in legit;
- movement: legit → nav waypoints + sidesteps (+ navmesh snap only when
  displacement <0.05 m); cheat → `TeleportTo` nudge;
- retreat/army scoring live in legit-only branches.

When adding any new power-path, mirror the `if (Legit) … else …` split —
run `tools\bot-lint.ps1` afterwards (it greps for ungated cheat calls).

## Add a Snapshot field (`BotPerception.cs`)

1. Add `public T Field;` to `Snapshot`.
2. Set it inside `Capture()` — null-guard every singleton
   (`instance?.Prop ?? default`), fields are read on the menu scene too where
   most singletons are null.
3. Add it to `Bot.FormatStatus` if it belongs in the overlay/log tick —
   **keep the log field ≤4 chars** (`bld`, `horn`, `lvln`…) or the histogram
   tooling and log width suffer.
4. Expensive scans (`Resources.FindObjectsOfTypeAll`, LINQ over big lists):
   put them behind a throttle clock — see the 1 Hz `levelScanAt` map scan for
   the existing pattern. `Capture` runs at ~4 Hz.

## Add a mode

1. Extend `enum BotMode` (order in the enum is cosmetic only).
2. Add the branch in `Decide()` **in priority order** — top wins. Current order:
   `ResolveUI` > `EnterLevel` (map scene) > day phases (`CollectCoin` →
   `SpendGold` → `PositionArmy` (legit) → `StartNight`/`ReturnHome`) >
   night `Engage`/`HoldCastle`/`ReturnHome` (legit retreat `HeroHpPct<0.5`).
   New modes go above or below existing branches *deliberately* — e.g.
   `ResolveUI` is first because a stuck frame blocks every other mode.
3. `SetTarget(pos, arriveDist)` + set `Status`; every non-Idle mode must give
   the watchdog a target or it will reset.
4. If the mode can hold a build interactor, ensure `ReleaseBuild()` is called
   when leaving it — the existing release check in `Tick` covers
   `Mode != SpendGold` automatically if you use `heldBuild`.
5. Log a one-shot `note` on transitions (`LogLine(in s, "my-note")`), not per
   tick — follow the on-change/tapered convention so the JSONL stays greppable.

### EnterLevel details
- Node pick = best `LevelScore` (unbeaten +100, session-unplayed +50,
  distance tie-break /3, −45 per `sessionDefeats` entry — rotates a
  repeatedly-lost node out).
- Scene transitions gate on `SceneTransitionManager.sceneTransitionIsRunning`
  (private bool — read via reflection once into `TranBusyFi`).
- `InteractionBegin` was removed entirely — the level-select frame it opened
  was being closed by `ResolveUI`, and `TransitionFromLevelSelectToLevel`
  alone drives the load. `level-interact` note stays as the marker.

### PositionArmy details
- Selects every `TagManager.PlayerUnits` entry via `OnUnitAdd(tgo,false)`
  (all-units loop lives *inside* `PlaceCommandedUnitsAndCalculateTargetPositions`
  — calling `OnUnitAdd` on each unit mirrors the player UI path).
- `alliedAnchor` = `castle + normalize(anchor - castle) * 6 m` → hero walks
  there, then `PlaceCommanded…` + `MakeUnitsInBufferHoldPosition`.
- `commanding` is cleared on non-SpendGold/PositionArmy modes; 8 s failsafe
  places from wherever the hero is.

### Nav steering (`NavSteerPoint` / `MaybeRequestPath`)
- `ABPath.Construct(hero, goal, cb)` → `AstarPath.StartPath` (~1 Hz repath,
  invalidates on goal move >1.5 m). `AstarPath` is **global-namespace**;
  `Path.nnConstraint` is get-only — do not try to set it.
- `NavSteerPoint` fallbacks that mattered in real runs:
  - path's last waypoint >2.5 m from goal → navmesh can't reach → steer at
    goal directly (castle interiors, map node rings);
  - last waypoint <0.8 m from hero → degenerate path → steer at goal
    (a 1-wp path whose point sits under the hero otherwise yields
    `DesiredDir=0` → moved 0.00 forever → strikes → wedges).
- Waypoint arrive radii: intermediate 0.5 m, last `arriveDist`.

## Add a ResolveUI frame handler

In `HandleBlockingFrame`, order is the feature:

1. `ChoiceManager` pre-gate — anything that blocks `InteractionHold` **must**
   stay above the `freezePlayer` check.
2. Non-freezing frames are never touched (the map UI must survive).
3. `BackToLevelSelectHelper` + `canNotBeEscaped`/escalation = end-of-match.
4. Specific interactive frames (perk pick) before the generic close.

To handle a new frame type: insert a branch between 3 and 4 that finds its
component (`frame.GetComponentInChildren<T>()`), picks/solves it, and
**throttle via `frameActionAt`** (existing: 1 s for choice, 2 s for closes).
If the frame can carry a back-to-map helper, decide whether it counts toward
`frameSeen` escalation — see AUTOPILOT §8.3 for the risk.

## Throttles & timers (all `Time.unscaledTime` — pause-safe)

| Field | Interval | Guards |
|---|---|---|
| `DecisionInterval` | 0.25 s | Decide cadence |
| `buildInteractAt` | 0.4 s | `InteractionHold` pump |
| `frameActionAt` | 1–2 s | UI resolve actions |
| `spendWatchAt` | 7 s | Dead-slot stall window |
| `switchNightAt` | 15 s | `SwitchToNight` fallback (also night-rearm edge) |
| `levelScanAt` | 1 s | Map node rescan |
| `levelInteractAt` | 2 s | `TransitionFromLevelSelectToLevel` call |
| `navRepathAt` | ~1 Hz | A* repath (same as game's own units) |
| `attackPumpAt` | 0.25 s | `TryToAttack` pump |
| `commandUnitsAt` | 8 s | PositionArmy failsafe place |
| `detourUntil` | 1.2 s + 0.6×count | Sidestep detour lifespan |
| watchdog window | ~2 s | `stuck` strike accumulation |

Hardcoded today — AUTOPILOT §9 tracks the plan to move these into config.

## Telemetry conventions

- One JSON object per line: `{"t":…,"mode":"…",…,"note":"…"}`.
- Tick lines carry the full field set; `note` is omitted when empty.
- `note` values are kebab-case one-shots: `build-stall`, `choice-pick`,
  `frame-close`, `level-interact`, `transition-level`, `switch-night`,
  `teleport-nudge` (cheat mode only), `unstick:n`, `snap` (legit navmesh
  rescue), `army-placed`, `defeat` (+ per-scene counter), `match-end`,
  `invalid`. New notes get logged only on the event, never per tick.
- `invalid` = snapshot not valid this tick (loads) — 36 % of lines; see
  AUTOPILOT §8.9 before adding similar noise.

## Pitfalls for bot edits

- `InteractionHold` early-outs silently — if your new flow isn't making
  progress, add a stall-style watch rather than assuming the call landed.
- `CanBeInteractedWith` can be true for slots that will never accept payment
  (core-cost upgrades) — filter at the scan or park at the hold.
- Don't `Unfocus` a slot you're still holding; `ReleaseBuild()` does
  `Unfocus`+`InteractionEnd` in the right order.
- The bot shares the hero with the overlay — freeze state (`F1` menu) and
  cheats both affect it. Test with the menu closed.
- Verify every game-API name against `decompiled\` after updates; the dumps
  are regenerated by `tools\decompile.ps1`.
