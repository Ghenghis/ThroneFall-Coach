# Changelog

## GPS wall-gate escape + night-readiness fix (Claude handoff + verification pass)

- **GPS (Claude's work, audited + deployed here):** `src/Gates.cs`/`src/GatePlanner.cs` — when the pathfinder fails for a goal
  (`NoteNavFail` from the path callback, not area labels — labels renumber per frame and produced ~35 false plans in 3 min),
  a BFS over gate-connected nav areas (`GatePlanner.Plan`, unit-tested 19/19 in `tests/GatePlanner.Tests`) or a label-free
  geometric fallback (`PlanHeuristic`, max 2 tries/goal/min, only while pinned) picks the wall gate leading toward the goal.
  The hero walks to the near side (normal A*), pushes straight through (`Direct` leg: the pathfinder still sees the gate
  as closed — `navDirectUntil` is pushed 0.35 s ahead each frame). 3 pins or a 22 s/5 s timeout -> 90 s gate cool-down.
  `Gates.OnPinned` suppresses stuck strikes/parks while a gate leg is active. Docs: `docs/GPS.md`.
- **Live evidence:** `[gps] plan #1 (areas) via gate #203888 at (-90.0,-65.9) hops=1` fired in the deployed build, then
  `goal is reachable from here now -> gate plan dropped` — the trigger and the drop-on-reachable path both verified live.
  A real `gps-cross` (hero actually pushed through a gate) still not observed.
- **Night readiness now counts manned doors, not parked ones:** `Snapshot.DoorsParked`/`DoorsClaimed` are projected to the
  brain (`DoorsCovered` also counted parked unwalkable anchors — a fully-parked perimeter read as "defended" and the
  night was called with nobody manning it, cf. Frostsee losses). `realDoors = covered - parked - claimed`; parked anchors
  still satisfy the "all doors handled" clause (unwalkable = nothing more to post).
- **Rescue rescan fixed:** `rescan-slots` required `BuildCount > 0`, but `BuildCount` only counts UNIGNORED slots — a fully
  parked slot list read 0 and the rescan could never fire. Now counts `BlockedBuilds` (slots skipped only for
  ignore/park) and fires when `BlockedBuilds > 0 && NearestBuild == null && gold >= 20` for 8 s.
- **Idle-night delay** while gold >= 20 and any blocked/buildable slot remains: 12 s -> 40 s (gives rescan room).
- **Approach-timeout cluster hysteresis:** retargeting between neighbours (<20 m, no payment) no longer resets the 18 s
  clock — A/B slot thrashing previously made the timeout unreachable.
- **Army target looks 2 waves ahead** (`EnemySpawner.GetWaveInfoByNumber`, public): `MaxWaveAhead` drives the target
  (Frostsee wave 12 = 143 foes vs the previous next-wave-only sizing). Also drives the big-wave coin-range gate and the
  military build-score bump.
- **Ranked choice selection:** `ChoiceRank` replaces first-pickable-or-military-keyword. Order: commander/command 100,
  castle/royal 85, unit unlocks 80, defense 70, builder/guild/mastery 60, economy 50, unknown 45, hero self-buffs 20.
  The pick logs its rank.
- **Curated perks:** mutations (`EquippableMutation`) are never equipped (challenge modifiers); weapons pick one per
  group preferring ranged (`WeaponRank`), and only when the group has no weapon selected; perks ranked (`PerkRank`),
  top 4.
- **ticks.jsonl** gained `"nav"` (Gates.Status) for enclosure diagnosis.
- `tools/build-and-deploy.ps1`: `taskkill /F` replaces `Stop-Process` (it returned success while the process kept running,
  twice), refuses to deploy while the exe still lives, and the plugin-load check scans from byte 0 when BepInEx rotated
  the log. NOTE: the file must keep a UTF-8 BOM or ASCII-only — PS 5.1 reads BOM-less files as ANSI and em-dashes decode
  to `"` and break the parse.
- **Hero-door timeout + project-to-nav:** day/night idle `PositionArmy`/`HoldCastle` now snap their hold point to the
  nearest walkable node (`r.ProjectToNav`, `NearestNodeConstraint.Walkable`) and give up an unreachable door after 12 s,
  ignore it for 45 s, then try again. Previously the hero stood 17-42 s at off-mesh guard points in `PositionArmy`.
- **Match-end popup hardening:** the back-to-map frame now counts its own close attempts and forces
  `TransitionToLevelSelect()` after 10 s (5 generic frame closes also force it). This prevents the victory popup from
  sitting open indefinitely and the empty-match vacuum it causes.
- **Result:** fresh-run Frostsee **victory** (run 20261001T111053Z, all 12/13 waves, 0 hero deaths, castle 87 % at the
  143-foe wave, 2601 s). Live in that run: 9 gps-cross (1.0-4.1 s each, incl. a 2-hop chain), 5 rescan-slots on the 30 s
  cooldown, pin share 18.6 % vs the 37.5 % baseline. Second Frostsee win; first under GPS + night-readiness.
- **Replay harness fixed + green path:** `BotBrain` no longer touches `BotPerception` (`DoorUnitAt`/`OpenBuildOrder`
  are projected onto `SnapshotData` as `UncoveredDoorUnits`/`OpenOrder`), so `tests/Replay` compiles again and its
  parser understands drp/drcl/udu/bldb/mwa. The shipped durststein-dto fixture now drifts 1/163 ticks (intended:
  idle-night needs 40 s while gold + blocked slots remain); re-capture under this build to re-baseline.

## Pin-park pass (live evidence)

- `pin-park`: pinned ~4 s en route to a build slot (SpendGold, nothing held) -> park the slot (was 18 s approach-timeout). Frostsee data showed the hero standing 13-20 s at a wall 27-67 m short of towers beyond it.
- Live Frostsee match after the change: day 1 ended with every buildable slot built (bld 39 -> 0), ally 8 -> 28 -> 36, maxed 11 -> 57-60 %, strict active 29-37 % (earlier day 1: ally 8-12, maxed 9-11 %). One match only.
- **Result:** that Frostsee match (run 20261001T090657Z) ended in **victory** (match-end, 1626 s run time) with 36 troops, i.e. the pin-park build beat the final boss wave that beat the previous build twice. n=1.
- Slot dump at wave 5: all military slots at max (Barracks lvl 3, Archery lvl 3, Castle lvl 3 canUp=False) -> army cap ~36-48. Final Frostsee waves (night 12 = 143 foes, 5670 hp) beat 31-42 troops twice, with 9.7k gold unspendable. Remaining levers are not spending: choice/perk selection, tower/wall mix, hero role vs the boss, army positioning.
## Overnight pass (sprint, busy-day, approach-timeout, strict metric)

- Strict **ACTIVE %** headline metric (share of time within 2 s of a pay/build-done); measured baseline 7.3 % (85 runs, 17.9 h).
  Early live days: 25.8 % (day 1, 169 s), 12.6 % (514 s day) - small sample, not a proven improvement.
- **Sprint** on long (>8 m) non-combat legs via `PlayerMovement.sprinting` in the MoveScript prefix (full HP only, like the game):
  measured hero speed p90 16.3 -> 23.7 m/s, p99 29.5 (game daySprint 29.9).
- **Busy-day veto**: the early night call is blocked while buildable slots exist, gold >= 20 and progress was made in the last 25 s
  (60 s when under 70 % of the army target); forced-night budget x3.75 (busy) / x2.5 (under-armed).
- **War prep** scoring (+14000 troop buildings, +14500 enablers when under 70 % of army target).
- **Approach-timeout**: same build target 18 s with no payment -> park + rotate (`approach-timeout` event; fired 6 times in the first runs).
- Removed: night building (impossible: `BuildingInteractor.UpdateInteractionState` forces state None at night).
- `tools/monitor.py` samples audit.json every 15 s into `agent/monitor.csv`.

Open (evidence): troop count stays at 8 against targets of 20-28 after 2 military buildings; day 1 of the 514 s run built 27 slots
(maxed 7 -> 18 %) but still entered night with 8 troops. Next lever: military upgrade tiers (Barracks/Archery lvl 2+), Castle lvl 3 choice,
and why ~47 buildable slots remain unbuilt (gated or unreachable). `tests/Replay` does not compile (pre-existing BotPerception references in BotBrain).
## Efficiency system (task ledger + MiniMax observer)

- `src/Tasks.cs`: per-task ledger (every second of play belongs to a build or a mode span), 0-100 efficiency per task,
  day/night reports, build verification (level sum must rise; miss -> `task-miss` + `Memory.ForgiveParks`), deferred
  4 s outcome resolution so completed builds are not mislabelled `partial`, `Tasks.Watch()` LLM-free supervisor filter,
  `coach-fx` scoring of MiniMax advice (score before vs 60 s after). Writes `agent/tasks.jsonl` (ts + build stamped) and
  `agent/benchmarks.json`; exports ledger, coach heartbeat stats and reports in `audit.json`.
- `src/Coach.cs`: latency, failure count, last trigger; system prompt now explains efficiency/useful_pct/weak_tasks.
- `src/Efficiency.cs`: score is held (not decayed) at night, so a quiet night no longer reads 0.
- `tools/eff_lib.py`, `efficiency-compare.py`, `tune-efficiency.py`, `check-efficiency.py`; dashboard `/efficiency` +
  Audit-tab panels (live score, per-task table, 1h/16h/48h/all vs baseline vs goal, MiniMax heartbeat).
- `STANDARD.md`: every constant labelled measured / sourced / estimate. Baseline 75.2 % useful (same classifier on 60
  pre-change runs); the old 47.7 % used a different rule and is not comparable.
- Finding: `useful%` vs max wave r=0.20, and run length vs max wave r=0.67, so wave count is confounded by survival time;
  the tuning script emits hypotheses only and never applies weights.
## v3.0-dev round-7 audit pass (2026-06-30)

Nine-agent audit fleet + live Neuland evidence; defects fixed:

- **Nav root cause**: brain aims were Vec2-flattened to y=0 — elevated/pocket
  slots always produced wrong-layer A* goals, mass-parking the buildable map
  and starving SpendGold into a permanent Idle deadlock. `AimY` now restores
  the real target height; parked cells are forgiven on each new match
  (`Memory.ForgiveParks`).
- **Double BeginRun**: a blocking frame on the InMatch edge could re-run
  `BeginRun`/`Coach.ResetRun` mid-match — fixed via `recordedScene` commit at
  the edge + full per-match reset set (mem/arriveSince/detour/holdDoneName).
- **Coach deadlock**: `Coach.ResetRun` now clears `lastCmdText` — the
  byte-identical server retry could never re-apply (permanent BROKEN loop).
  Server writes carry a per-attempt nonce so retries produce fresh bytes.
- **Legit lock hardening**: all GUI cheat controls are `GUI.enabled`-gated
  while `Bot.Legit`; `GoldDrip` is force-bypassed in legit mode; `Bot.Legit`
  refreshes every frame (config-manager edits no longer leave it stale);
  cheat-bundle restore is conditional (mid-run user flips preserved);
  menu unfreeze restores only our own freeze; watchdog ignores frozen heroes.
- **Checklist integrity**: named playbook entries (`upgrade:Barracks_T2`) now
  match on build NAME — a Castle upgrade no longer satisfies Barracks items.
- **Persistence**: Policy update overflow guard, JSON key escape/unescape,
  Memory scene sanitize, `ForgiveScene` EnsureInit, NetPolicy full-layer dim
  check + torn-file mtime retry, Recorder Tick phantom/drop accounting,
  writer-join on Stop, single-pass JSON unescape (Windows path safe).
- **Perception**: gated inactive-slot skip (activator-bound only, not all
  inactive), slot-pack parse bounded to the slots section, bracket matcher
  skips string literals, horn reflection walks base types, door claim/park by
  index, parked doors counted covered, `doors_claimed`/`next_foes` telemetry
  split, `door_distance_m` strategy field consumed, held-mid-choice slots
  stay selected, `buildIgnore` sweep.
- **Brain**: build-done returns immediately (no release→begin thrash),
  SlotVisitKey cleared on every release, newMatch resets ArmyPhase, scene
  flicker ignored, castle-threat at distance 0 stays urgent, JSONL notes
  escaped, orbit-dt clamped.
- **Tools**: PS5.1-safe bot-lint, gen-fields param order + no-BOM, verify
  FAIL-grep, deploy log freshness gate, decompile exit codes, replay fixture
  path, e2e atomic command write, coach-server tail-reads everywhere +
  `clear:true` release + validated extract_cmd + live `wave`/`bld` sig fields.

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

