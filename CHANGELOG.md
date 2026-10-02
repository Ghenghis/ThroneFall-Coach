# Changelog

## MiniMax orchestration pass (diagnosis: alive but blind and knob-only)

- **Finding:** MiniMax was NOT down - `mm_watch_loop` had 3790 cycles, ~60-90 s cadence, 160 applied / 32 NOT applied in the last 400.
  It was ineffective for four measured reasons: (1) it saw a 13-field digest with no pin/stuck/gps/waste data; (2) its only output
  was 7 strategy knobs, so every code-level problem it noticed ("bot stuck 104 s") had no outlet; (3) its steering was harmful:
  `hero_posture:"fighter"` 220x vs builder 150x (contradicts army-fights/hero-builds) and `army_target` changed on 160 of 360 patches
  (15->35->15->20->25), and the plugin treated it as a SET so it overwrote the bot's lookahead target; (4) 8 % of applies were
  false "NOT APPLIED" (40 KB log-tail count slid past the marker) and a false "stuck in SpendGold" alert fed it bad diagnoses.
- **Fixes:** `eng_digest` (events/nav/waste/log warnings) + event glossary in the prompt; `proposal` channel -> `proposals.jsonl`
  (deduped, `[mm-proposal]` in chat); `guard_patch` (fighter only in red alert, army_target step >= 10); plugin `army_target` is now a
  floor (`Mathf.Max`); offset-based apply proof; `mm-heartbeat.json` + `/health` "MiniMax heartbeat"; `mmwatch.jsonl` 8 MB rollover;
  SpendGold/HoldCastle no longer flagged "stuck". See `docs/ORCHESTRATION.md`.
- **Live proof:** heartbeat ok after restart, first proposal recorded (real evidence: 115 stuck events, 46 % waste; its fix text
  misread stuck events as combat - glossary added).
- **Two writers stomping the overrides (the real "MiniMax isn't steering" bug):** the plugin's LOCAL Grandmaster advisor
  (`Coach.Advise`: day-start/defeat/eff-collapse/coach-beat triggers) applied its replies through the same `Apply()` with no
  server-side clamps (squad=12 seen) and **zero-as-release semantics** — every advisory reply rewrote or cleared MiniMax's pins
  mid-run (army 60 -> 40 observed). Now: a fresh `user-cmd` pins the override set for 240 s (`userCmdPinUntil`), advisory replies
  update `LastAdvice` only while pinned, and advisory zeros are ignored (0 = no change per the schema). Verified live: a
  `coach-beat`/`eff-collapse` reply landed between MiniMax writes and `army>=` stayed pinned. `/order` now runs through
  `validate_patch` (was unfiltered). `mm_chat` watch calls use max_tokens 8000 — 3000 made every call die at
  finish_reason=length (empty body).

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
- **Hero-door timer now works at night too:** `HoldCastle` sets/updates `HeroDoorSince`/`HeroDoorIdx` when it holds a
  hot door, so a 12 s timeout falls back to the castle. The re-try clock now starts at the end of the 45 s ignore
  window instead of 45 s in the past (the old `HeroDoorSince = now` made the door ignore-locked forever after one
  timeout).
- **CastleThreat no longer falls back to the nearest enemy to the hero** — `CastleThreat` is now strictly the
  nearest foe to the castle (`HasCastleThreat` false when none). The old fallback made every live foe look like a
  castle threat, disabling the safe night coin-scavenge branch and corrupting red-alert `CastleThreatDist` checks.
- **Per-door squad posting counts** — `DoorPostCounts`/`DoorPostAts` arrays replace the global `DoorPostStreak`.
  Alternating between two uncovered unwalkable doors no longer resets the count, so `PlaceSquad` spam now parks the
  bad anchors after 4 posts as intended.
- **Choice coroutine wedge cancel** — if `ChoiceCoroutine` is running >20 s, the bot now calls `CancelChoice()` once
  and resets the watchdog instead of looping `CloseActiveFrame()` on a frozen player.
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

- **Wall-loss tracking (`blost`):** `bi.buildingHP.KnockedOut` now detects knocked-out buildings during the slot scan.
  `CatBuilt` decrements on knockout (checklist/open_order see the breach — `breach_rules` rebuild can now trigger),
  restores on the dawn revive, and drops the marker if a repair completes via `BuildDone`. Emits `build-lost`/
  `build-restored` log lines + `build-lost` event, surfaces in `audit.json`, ticks (`blost`) and the MiniMax
  engineering digest. Fixes the v3 blocker: destroyed walls previously counted as built forever.
- **Elite stall posture:** `elite_stall_hp` (0.62) — an elite on the hero with troops alive routes to the retreat
  lane instead of Engage ("stall, don't duel the Ram").
- **Revive edge:** `revived-reset` re-arms door posts, restarts army phase and drops stale build clocks on respawn.
- **Map-intel generator (v3.5):** `tools/gen-mapintel.py` synthesizes `strategy_<scene>.auto.json` for all 37 scenes
  from extracted botpack data — per-line squad sizes weighted by foes/elites/flyers + chokepoint width,
  `army_target` from the biggest night, `door_distance_m` from corridor narrow-points, `build_order` from slot
  inventory, plus hero/breach/economy rules and objective kind. `LoadStrategy` falls back to the `.auto.json`
  when no hand-tuned pack exists — never-seen maps get a competent playbook instead of blind defaults.
  bot-lint guards the fallback; 37 drafts on disk.
- **Closed loop for MiniMax:** every applied patch now records a metric snapshot; the next watch cycle (>45 s)
  computes deltas (ally/gold/door-coverage/wave) and feeds "EFFECT OF YOUR LAST PATCH" back into the prompt +
  `outcome` entries in mmwatch.jsonl. MiniMax was steering blind; now it sees cause -> effect.
- **Stuck -> GPS escalation:** a pin while travelling to a "reachable" goal (pathfinder returned a path but the
  hero can't move — mesh lies at gate seams/pockets) now calls `Gates.NoteNavFail(AimPos)` after the first
  strike, so gate planning engages instead of burning sidestep strikes. MiniMax proposal #8.
- **Upgrade urgency ("pens"):** an already-Built slot that CanBeUpgraded scores +(900/2200 by idle gold) +
  +1500 when the playbook is fully satisfied — upgrades starved for minutes against the open[0] +5000 pin.
- **Command-center live view fixed:** `/live.png?x=<ts>` polls 404'd because the route matched the path exactly —
  Playwright QA caught it (real browser: 10x 404s); now `startswith` matched, verified 200 + live frame in-page,
  console clean, "LIVE - Frostsee" banner fresh.
- **Pin awareness (`pin-type`):** every stuck strike now classifies the collider in front of the hero —
  `pen:<building>(upgradeable)`, `gate`, `wall`, `terrain:<name>` (rock/tree/water), `enemy`, `obj:<name>` —
  logged + `pin-type` events for MiniMax/digest. The bot now knows WHAT it bumped, not just THAT it bumped.
- **MiniMax command center (UI + scheduler):** new pane — OFF/SEMI/AUTO/AGGRO mode buttons, interval slider
  (15 s - 3 h, `mm-config.json` persisted, loop reads it each cycle), semi-auto approval queue
  (`mm-pending.json` + `/mmapprove` `/mmreject`), last-patch outcome card (measured deltas), live heartbeat card.
  Playwright-verified: mode buttons POST and the loop honors them; config changes land in the chat feed.
- **Closed loop on display:** first measured outcome already live — MiniMax's `squad 5/army 60/military` patch
  produced ally 20 -> 40, gold -153 in 150 s.
- **Desktop app (Thronefall Command):** native WPF + WebView2 host for the command center —
  `desktop/ThronefallCommand`, `tools/build-desktop.ps1` -> `dist\desktop\ThronefallCommand.exe`.
  Free-port picker (+ "auto"), auto-launches coach-server.py, zoom slider rescales ALL UI (fonts/panels/buttons),
  fullscreen/windowed/compact-40%-screen modes, window lock, always-on-top, settings gear with
  saveable profiles (port+zoom+geometry+lock). User-data folder persists web panel state.
- **`/mmapi` discovery endpoint:** MiniMax-as-pilot — enumerates every UI-reachable control
  (all GET/POST verbs, modes, patch fields) so the model can drive the whole app over HTTP.
- **Build-stall fairness fix (the "pens" bug's real teeth):** Memory.Park now only fires when the hero
  actually ARRIVED (dist <= 14 m) and the hold still wedged. Approach stalls (36-147 m — unreachable-behind-
  walls slots) keep their cell and retry after the 600 s ignore window instead of deleting upgrade targets
  permanently. NoteBuildFail (catStuck) is distance-gated the same way — 4 far stalls used to retire an entire
  category (towers starved -> leaks -> more KOs -> churn loop; Defense Tower was 178 attempts/25 ok).
- **Pin probe hygiene:** trigger colliders + decorative ground art (Path/decal/road/grass/fx) skipped —
  pins were mislabeled "obj:Path" while the real blocker was a wall.
- **Stuck->GPS escalation threshold:** strike 1 -> strike 2 — single-strike unit bumps were marking interior
  goals nav-failed and sending the hero on spurious gate detours.
- **Audit round (two agents, real findings, all fixed):**
  - Bot: horn-approach watchdog (25 s no-progress -> HornIgnoreUntil -> SwitchNight fallback; unreachable horns
    no longer wedge StartNight forever); red-alert response hoisted ABOVE the night gate (dawn roamers used to
    chew buildings while the bot coin-ran); build-stall ignore scaled by distance (far approach stall = 60 s,
    arrived wedge = 600 s); choice/perk frame streaks reset on frame-name change.
  - Coach server: `_last_at` army-floor ratchet resets on new run; pending queue writes atomically; /mmreject
    frees the dedupe (rejected patches can be re-proposed); /mmapprove now waits for the [coach] user-cmd
    marker like /order; /proposals + /engdigest endpoints; UI knobs card (squad/reserve/escort/army/night_call/
    release-all) — every MiniMax field reachable by the user; run detail stays expanded across refreshes;
    mmchip 'unknown' fix; mm-pane polling gated on the pane being open.
  - Desktop: python child stdio pipes no longer redirected (the ~4 KB pipe-fill deadlock); ServerUp fully async;
    'auto' port ATTACHES to a running server instead of spawning a second watch loop; profile names sanitized.
  - Bot frame state now visible: audit.json exposes `frame` (open UI frame name) for the digest.
- **MiniMax self-scheduling (cron) + relaunch power:** reply key "schedule":[{every_s,patch,note}] programs
  recurring actions (clamped 30 s - 6 h, semi mode queues them); patch field "relaunch":true restarts the game
  session in auto/aggressive. UI: schedule card with delete buttons; MM_SYS documents the powers.
- **Audit residuals closed:** F1 — the level-select map can have no usable LocalGamestate, which died the whole
  transition path silently. `BotPerception.BestLevelNode()` (same unbeaten-first + LevelScore scoring) now runs
  in the !s.Valid path and calls `TransitionFromLevelSelectToLevel` directly — the node map needs no walking.
  DoorPostAts/DoorPostCounts indexing is bounds-guarded at all 5 sites (a >63-door map would have thrown inside
  Decide). F5/F3 covered by the horn-first preference + the earlier IsFreeToCallNight executor gate.
- **MiniMax vision loop:** local LM Studio VL models (:1234, OpenAI-compatible) now read live.png — qwen3-vl-4b
  verified ("isometric village, no overlays, hero near center"). Model picker has a preference order + 3-model
  fallback; snapshots land in agent/snaps/ with a 2 h auto-purge; reads append to vision.jsonl which feeds
  eng_digest() into the next steering prompt. POST /mmlook {q} = on-demand look; GET /mmvision lists reads+models.
- **Efficiency regression = urgent:** when live 1 h useful_pct drops 12+ pts under the 16 h baseline the watch
  loop flags urgent and forces a steering call — MiniMax is compelled to fix wasted-time regressions, not
  allowed to idle through them.
- **Speedrun records:** GET /speedrun aggregates runs/*/summary.json per scene — attempts, win%, best/avg
  duration, waves, composite grade (speed 60% + clean 40%). Stats pane shows the table; current records:
  Neuland 37/37 best 12:59 · Nordfels 5/9 best 2:03 · Durststein 8/44 best 3:57 · Frostsee 5/10 best 27:06.
- **Desktop F-key map (every modifier):** F1 shortcut reference overlay, F2 connect, F3 zoom cycle, F4 lock,
  F5 reload, F6 pin, F11 fullscreen, F12 compact; Ctrl+F1..7 = panes chat/live/stats/book/weak/audit/mm;
  Ctrl+F8..11 = MiniMax off/semi/auto/aggressive; Shift+F1..3 profile presets; Alt+F5 hard reload.
- **AI-active border glow:** blue halo while MiniMax heartbeat is fresh in an active mode, amber when the
  semi queue has items awaiting you, none when offline — the computer-use cue.
- **Multi-keep maps:** castleBuf now counts every CastleCenter-tagged keep (audit.json "castles" field); with
  >1 keeps the nearest living keep anchors home instead of .instance's arbitrary pick.
- **Night-call unblock:** SwitchNight blocked by a focussed interactor now sidesteps the hero 6 m off the slot
  (night-unfocus-step) so the game's own Unfocus clears — previously the 15 s window burned standing still.
- **Speedrun mode:** mm-config "speedrun":true flips MiniMax to pace-first steering (lean army floors, night
  as soon as defensible, no idle seconds). UI toggle in the knobs card.
- **Vision model picker:** preference order (qwen3-vl-4b first) + try-up-to-3 fallback — qwen2-vl-2b 400s on
  image parts; a bad pick no longer kills the eyes channel.
- **tools/package-desktop.ps1:** dist/ThronefallCommand.zip release artifact (0.6 MB) + INSTALL.txt.
  Inno Setup absent on this machine; swap Compress-Archive for iscc when it lands.
- **Quest-aware level scoring:** LevelScore now adds +12 per uncompleted quest (LevelInfo.QuestsTotal() -
  QuestsComplete()) — campaign progress beats bare unbeaten-first ordering.
- **Ability intents verified:** PumpAttack already calls heroAttack.TryToAttack() — ManualAttack IS the hero
  ability (self-targets, cooldown-gated, assassins-training timing respected). No new code needed; verified
  against decompiled ManualAttack.cs.
- **MiniMax proposals -> shipped fixes (acceptance loop live):**
  - rule-test purge: agent/policy.txt carried 'rule-test | Wave >= 0 -> coin_seek = 90' firing every tick —
    coin collection priority was hard-pinned for every run. Removed; orbit_spin knob kept.
  - Enabler slots (castle center / activator root gating the tech tree) now BYPASS park/ignore filters —
    parking the gating building starved the whole upgrade chain (Durststein army capped 32/78).
  - relaunch:true cooldown 300 s + post-relaunch proof (fresh log bytes + fresh audit.json) before claiming ok.
  - POST /proposals {idx,status} marks open/shipped/rejected; shipped proposals get a live efficiency verdict
    (+/- pts vs at-ship baseline) — the UI proposals card shows the verdict and has ship/reject buttons.
  - Native menu bar: File/View/Panes/MiniMax mirroring every F-key and Ctrl+F* action.
- **Durststein root cause (from run history + MiniMax proposals):** 13/44 defeats are wave-1 night wipes —
  the bot arrives at night under-built (castle tier gates barracks output) holding 4900 gold with 12 allies.
  Daytime build-lost events (roamers) compounded it; the day red-alert fix + enabler bypass target both.
- **Frostsee 27 min is map pacing, not waste:** ~10 min day budgets x multi-day waves; SpendGold dominates day,
  HoldCastle night. speedrun:true is the pace lever.
- **Phase-1 verification run (all live-proven):** /order marker proof, /mmapprove now genuinely waits for the
  [coach] user-cmd line (injected pending -> applied:true with real log proof), relaunch exercised end-to-end:
  game killed + relaunched + new run registered. Proof window widened 90->150 s and accepts log-growth OR
  audit-fresh (full game load + first capture can exceed 90 s; the first live relaunch reported
  verified:false because the window was tight, not because it failed).
- **Desktop app launched + verified:** window responding, WebView2 spawned, menu bar live.
- **Phase-2 live findings -> fixes:** Frostsee wave-1 night survived (doors 5/5, HoldCastle correct).
  - Anomaly debounce: per-type cooldowns (stuck-spam 45s, night-park 45s, army-starved 90s) via AnomalyAllowed() -
    the guard was the spammiest log source (28 events/600s at max global rate).
  - Pin-probe skip list widened: "parent|container|holder|group|root" container transforms misclassified as
    blockers ("obj:Alive Parent") - they can never pin, don't mask the real blocker.
- **Nav-goal off-mesh pre-check:** GetNearest(Walkable) snap >4 m skips the path request entirely and logs
  'nav-goal off-mesh' once per coarse cell per 60 s (was: nav-path error spam on every repath to an
  unreachable edge target). Gates.NoteNavFail still records the unreachable pin.
- **Policy net retrained:** train_policy.py over 23,878 logged rows, acc 0.01 -> 0.52 -> netpolicy.json.
  The shadow's EnterLevel spam during in-level play should drop with real accuracy.
- **Proposal triage first pass:** 40 recent MiniMax proposals graded - 5 shipped (ChoiceFrame wedge, door-park
  fallbacks x3, unstick-pressure focus), 4 rejected (verified false premises: checklist done-flags ARE written
  live; peacetime door posting is by user design), 31 open. proposal_set fixed: tail-40 indexing (was writing
  status onto absolute file rows - marks landed on wrong proposals).
- **Proposal sweep -> shipped:** night-build (foe-free night + funded + buildable + no door duty -> SpendGold
  inside the HoldCastle branch, 'night-build' note - hero builds while squads fight, per the standing
  directive). 11 shipped / 12 rejected / 17 open after a code-verified pass (rejects = verified false
  premises: checklist done-flags, build_focus application, playbook ordering, walk-distance penalty, generic
  frame escape for popups).
- **Net v2 (15 feats):** added day-progress (dtl/600), next-wave size (nwc/60), army-floor ratio
  (ally/army_target). Dataset regen 284,192 rows; acc ~0.53. The shadow's StartNight spam during early day
  should drop - it could not see day progress before.
- **Aim-flap hysteresis (proposals 18/37/38):** escalating commit window - each repeated reversal inside the
  hold extends it x1.5 to max 8 s (was a fixed 2.5 s: the same oscillating pair re-fired the blocker
  forever). Resets on mode change / run reset.
- **Army-target cap (proposal 19):** MaxWaveAhead*1.1 had no ceiling - a 143-foe wave asked for a 157-unit
  army vs ~48 achievable -> armyShort fired forever, every build score skewed to military. Capped at
  postable door-need + 24 headroom.
- **Fast live feed:** plugin now writes live.jpg (JPEG q55) every 0.4 s alongside the 2 s live.png (vision +
  snapshots keep PNG). /live.jpg endpoint + /live.json returns {ts, fast} - UI polls 300 ms and swaps to the
  jpeg feed automatically. ~2.5 fps up from ~0.5 fps.
- **MJPEG live stream:** /live.mjpeg pushes multipart frames as live.jpg changes - measured 4.4 fps live
  (was ~0.5). Live pane uses the stream when fast feed exists, falls back to polled png/jpg otherwise.
  Plugin fast feed now 0.25 s. 0 errors / 0 lint.
- **Live-view intent overlay:** plugin emits markers.json each fast frame - hero/aim/castle/build/door/threat
  positions projected through Camera.main.WorldToScreenPoint. /live.json relays them; a non-interactive
  canvas draws labeled dots over the MJPEG stream. You can now SEE what the bot is aiming at, which door
  lines it is posting, and where the current build target sits.
- **Live pane e2e pass:** state banner (RED ALERT / ui-frame / NIGHT with wave+doors+foes), event ticker
  (last 6 run events under the frame), overlay toggles (doors/castle/builds/aim/path), Save frame +
  Reconnect buttons, nav-path polyline from the live pathfinder, door state colours (covered pink /
  open red / parked grey), fps counter counts real marker frames. markers.json now carries pw/ph +
  door state + nav waypoints; /live.json relays mk+st; /events tails the newest run.
- **Boundary-pin hard park (the gold-idle loop):** pins on map boundary/terrain/ground geometry now mark the
  pocket as HARD-ignored - rescan forgiveness can no longer resurrect them (it was the Frostsee Boundaries-3
  loop: park -> rescan -> re-pick -> pin, forever). Gates still clear ignores on real opens; boundary never
  opens. Live cause of useful_pct=42/waste=540s.
- **UI usability pass:** proposal ship/reject become real buttons (SHIPPED ✓ / REJECT ✗), marker halo +
  stroked labels for snow-scene contrast, palette: hero cyan, aim yellow, castle white, build green,
  threat red, door covered orange / open red / parked grey. Header strip gains useful% + waste cells so
  idle-time is visible without opening Audit.
- **Token Usage pane (new window):** /tokens aggregates mmwatch.jsonl - totals (in/out/total), avg/call,
  last-hour rate, per-kind breakdown (watch/proof/pending), tokens-per-minute sparkline, last 25 calls.
  Rail button added. First data: 1,400 calls / 5.43M tokens / 273k last hour.
- **Stuck stats in the strip:** audit.json now carries stuck-strike count; header strip shows
  useful% + waste_s/drain + pins so stuckness is visible without opening Audit.
- **Quick-order chips** in the composer: +20 troops, call night, bigger squads, escort hero, release all -
  labeled buttons instead of cryptic icons.
- **Boundary hard-park** shipped (rescan-immune ignores for boundary/terrain pockets).
- **All four pane upgrades live:** foe markers (TagManager.EnemyUnits projected - small red dots, ~4 fps),
  door labels carry posted-unit counts, Stats pane 'where time goes' bars per task kind (/taskstats: last 300
  tasks, use/waste/eff/abandoned - first data: 1511s useful vs 3078s wasted), Audit pane 'Recovery events'
  counters (pin-park/sidestep/timeout/rescan/gps/door-park/breach per run via /events?cnt).
- **Marker color pass 2:** door labels now 'doorN · units'; foe dots; halo + stroked labels everywhere.
- **Window-grab live feed:** server-side BitBlt of the Thronefall window (~5-11 fps real pixels, ZERO game
  cost - the plugin's ScreenCapture was the game-thread bottleneck and the 'laggy then freezes' failure
  mode). /live.mjpeg prefers it; plugin JPEG remains the fallback. live.json exposes 'win':true.
- **Click-to-command:** 'cmd' chip in the live overlay toggles marker hit-testing - click a door/build/
  castle/threat marker and the hero walks there ({focus:"door2"} order -> SetFocus 20 s, shown as a GO
  ring). Command poll 4 s -> 1 s so clicks feel live.
- Buttons/doorN·unit labels, banner, ticker, toggles, token pane - all one consolidated Live pane.
