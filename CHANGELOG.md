# Changelog

## v3.0-dev — agentic architecture Phase 0–2 (2026-09-29)

Per `docs/AGENTIC-DESIGN.md` — the agentic layers land incrementally;
no LLM until Phase 3.

- **Phase 0 recorder** (`src/Recorder.cs`): bounded async writer →
  `BepInEx/plugins/agent/runs/<runId>/{ticks.jsonl,events.jsonl,
  summary.json}` — 2 Hz faithful-DTO ticks (every Decide input),
  the note stream, run summaries with counters (deaths/snaps/stalls/
  dropped lines), plus `agent/anchors.json` learned wedge anchors.
- **Phase 0 pure layer** (`src/BotBrain.cs`): `SnapshotData` (value-only
  mirror of everything the FSM reads), `BotMemory` (all carried
  statics), `DecideResult` + `Intent` (BeginHold/PumpAttack/
  CommandArmy/HornInteract/TransitionLevel/…). `Bot.cs` is now the
  executor: decide → apply mode/aim → run intents against live refs.
  Lint enforces zero Unity/game tokens in the brain.
- **Replay harness** (`tests/Replay`): net8 zero-dep console that
  compiles `BotBrain.cs` directly and replays recorded ticks —
  mode sequence must be identical. Fixture `durststein-dto` PASS
  179/179.
- **Phase 1 awareness**: next-wave intel (`GetWaveInfoForNextWave` →
  count/elites/maxHp/speed/foe-range/gold), final-wave flags, live foe
  attack-range/hp/elite (orbit radius + deep-pull now honor the
  threat's own reach), `CastleCenter` castle anchor + keep-slot HP,
  shrine scan, build-slot mil/inc classes, P6 weapon chain
  (WeaponEquipper→ManualAttack→player-tag scan @1 Hz; Bow & Dagger
  37.5 range detected live).
- **Phase 2 policy core** (`PolicyTable` in BotBrain): hot-loaded
  line-DSL (`agent/policy.txt`, 1 Hz reload) — `knob NAME = v` and
  `id | FIELD op v -> NAME = v` rules (≤32, validated fields, bounded
  values, last-good on error → `policy-reject` event). Empirical gate
  proven: `coin_seek=5` flipped 45/179 replay decisions; a
  `NextWaveCount`-rule correctly no-ops on pre-field fixtures.
- **Live**: orbit-kite held a 25-foe wave at hp 1.0; night coin-runs;
  castle anchor via `CastleCenterPosition`; weapon range 37.5 drives
  ranged-vs-melee branching.

## v2.1-dev — hero dead-state + swarm pre-emption (2026-09-29)

- **`BotMode.HeroDead`**: knocked-out hero gets a named mode instead of
  `Idle` (or `ReturnHome`) — telemetry now explains the dead window; the
  ghost releases any build hold and drifts home while `pm.Dead` OR
  `hp<=0` (covers the window before the Dead flag flips). Respawn
  auto-resumes normal modes.
- **Pre-emptive swarm retreat**: new `Snapshot.EnemiesNearHero` counts
  live foes within 8 m of the hero; a 3+ pile (or any foe <5 m) pulls
  the hero deep behind the keep BEFORE the encirclement closes —
  `CharacterController` can't displace out of a closed ring, so the
  only surviving move is an early one.
- **Telemetry**: tick JSONL gains `"nf"` (foes near hero).
- **`bot-lint.ps1`**: snapshot-fields regex gets a word-boundary
  lookbehind — `sessionDefeats.TryGetValue`, `BindingFlags.*`,
  `Paths.PluginPath`, `Collections.Generic`, `items.Length` no longer
  false-positive. **0 FAIL, 0 WARN.**

## v2.0.0 — design/research docs packet

`docs/` tracked in the repo and shipped in the Source zip
(AGENTIC-DESIGN, AGENTIC-RESEARCH, AUDIT-LOG, IDEAS, UNDERSTANDING,
v3 design PDF). Binaries identical to v1.0.0.

## v1.0.0 — legit autopilot mode + navigation (2026-09-29)

`Bot.BotSurvivalCheats = false` now means **fully legit play**, not just
"bundle off":

- **Legit mode (`Bot.Legit`)**: attacks via `TryToAttack()` only (the old
  `Attack()` pump was a hidden ~4× fire-rate cheat); no `Hp.TakeDamage`
  fallback; no movement teleports — A* `ABPath` waypoint steering +
  escalating sidestep detours + navmesh `GetNearest` snap only when
  physically embedded (`moved<0.05`); army through the player's
  `CommandUnits` path (select-all → place → hold); session defeat counter
  rotates node selection (−45 score per loss, cleared on win).
- **Defensive play**: castle-threat target priority, threat-axis anchors from
  `EnemySpawner` spawn lines (day) / live centroid (night), ranged stand-off
  at ~70 % weapon range, kite on nearest-foe proximity, <5 m danger zone
  retreats inside the keep, hp<0.5 retreat to castle, melee holds the army
  line. Army anchored castle+11, ranged hero behind at castle−4 — hero no
  longer stands ahead of his own troops.
- **Day economy scoring**: harvest +1000, military production +100/branch,
  income +30+Δ; core-cost and broke slots pre-filtered (no 7 s park);
  stand-off build target (no collider-center wedge).
- **Transition guards**: `sceneTransitionIsRunning` via reflection kills the
  double-fire; `InteractionBegin` removed from `EnterLevel` (map interact is
  distance-free anyway); `_`-scene night-switch guard; `AfterMatch*`-gated
  frame escalation (pause can no longer exit a run); night-switch re-arms on
  day edges only.
- **Navigation**: `NavSteerPoint`/`MaybeRequestPath` — `ABPath` via
  `AstarPath.StartPath` ~1 Hz; paths that can't reach the goal (>2.5 m from
  last waypoint) or degenerate at the hero position fall back to
  straight-line steering — the `moved 0.00` Nordfels trap root cause.
- **Quality tooling**: `tools\bot-lint.ps1` (legit-gating, log fields,
  unscaled time, references, enum coverage), `tools\bot-diagnose.ps1`
  (parked hero, unstick storms, day-never-ends, wave grind, config drift
  `-Fix`), `build-and-deploy.ps1` auto-stops the game first.
- **Verified live**: fresh save, all cheats off — `Neuland(Tutorial)` beaten,
  campaign map toured, Nordfels entered, real nights with real hp loss,
  hero knockout + army-cleared wave, `army-placed`, `snap`/`unstick`
  recoveries, single `transition-level` per visit.

## Unreleased — campaign autopilot (2026-09)

Full campaign autopilot, verified end-to-end live (30k+ telemetry lines):

- **FSM bot (F6)**: `Idle / CollectCoin / ReturnHome / HoldCastle / Engage /
  EnterLevel / StartNight / SpendGold / ResolveUI`; steering injected via
  Harmony prefix on `MoveScript`.
- **Campaign loop**: title → level-select map → nearest unbeaten
  `LevelInteractor` (else nearest playable) → match → victory frame → repeat.
- **Blocking-frame resolver**: `ChoiceManager` picks auto-resolved *before* the
  `freezePlayer` gate (unframed pending choices deadlocked holds), perk frames
  auto-pick first unselected `PerkSelectionItem`, end-of-match detection via
  `BackToLevelSelectHelper` with `frameSeen` escalation, generic close/apply.
- **Day economy**: `Focus` harvests + `InteractionBegin`/`InteractionHold`
  hold-to-pay on `BuildingInteractor`s; gold actually drains now.
- **Spend-stall fix**: 7 s no-payment watch → dead slot parked on `buildIgnore`
  for the rest of the day (cleared at dusk) → candidate pool drains →
  `Nighthorn`/`DayNightCycle.SwitchToNight()` fallback fires.
- **Stuck watchdog**: 3-strike teleport nudge only when aim distance isn't
  closing (no more jerk mid-pursuit).
- **Survival bundle**: F6 applies god/regen/magnet/instant-kill/no-cooldown and
  restores prior cheat states on toggle-off (`Bot.BotSurvivalCheats`, default on).
- **Telemetry**: `BepInEx\plugins\bot-log.jsonl` — ~4 Hz snapshot lines +
  one-shot notes (`build-stall`, `choice-pick`, `switch-night`, …).
- **Docs**: `AUTOPILOT.md` (status/issues/handoff), `CONFIG.md` (all 48 keys),
  `BOT-DEV.md` (extension guide), `TESTING.md` (e2e checklist),
  README autopilot sections.

Known issues carried forward: straight-line steering wedges on building
colliders (nudges recover), `frameSeen` escalation can exit a run if a pause
frame embeds `BackToLevelSelectHelper`, cheat-dependent combat. See
AUTOPILOT §8–9 for the full list and next actions.

## fd4841e — initial trainer (first commit)

- BepInEx plugin, IMGUI overlay (F1), themes/opacity.
- Cheat set: protection (god/instant-revive/never-lose), economy
  (free/instant build, magnet), combat (instant-kill, mults, multi-shot,
  regen, no-cooldown), enemies (speed/damage/HP scaling, endless waves),
  army (command range, respawn, ally mults), world/time (speed, endless day),
  camera (zoom, reveal), meta/progression save writers.
- Harmony patches on `Hp.TakeDamage`, `PlayerInteraction.SpendCoins`/
  `SpendEnergyCores`, `Coinslot.AddFill`, `Hp.Start`,
  `LocalGamestate.SetState`, `Weapon.Attack`.
- `tools\build-and-deploy.ps1`, `tools\decompile.ps1`, ilspycmd reference dumps.
