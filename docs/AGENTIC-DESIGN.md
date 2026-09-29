# Thronefall Agent — Design v3 (final, 2026-09-29)

Single-player, educational. Supersedes v2. Incorporates every item of
`V2-AUDIT.md` (dispositions in `AUDIT-LOG.md`) plus three further review passes
over the shipped source (`src/*.cs`), `decompiled/` and `decompiled_fog/`.
`AGENTIC-RESEARCH.md` stays in the repo as the bibliography; this file is the design.

Conventions: every identifier in backticks exists in the zip and was grep-checked
(`AUDIT-LOG.md §3`). Numbers marked *est.* are estimates with the formula shown;
everything else is measured or read from code.

---

## 0. Summary

| Question | Answer |
|---|---|
| Architecture | Four layers: **Body** (C#, in-process, 4 Hz FSM) · **Policy** (bounded rule DSL in one JSON file) · **Brain** (Python sidecar, event-driven, provider-agnostic LLM) · **Critic** (replay harness + interleaved A/B evaluator + live anomaly loop). Four memory stores with schemas and retention. |
| First thing to build | Recorder + per-run summary + pure `Decide` extract + fixture replay (Phase 0). No LLM until Phase 3. |
| Largest single gain | `EnemySpawner.GetWaveInfoForNextWave()` — the next-wave preview the player sees, unused by the bot today. |
| What the LLM may do | Propose bounded rules, pick a legit loadout, request one screenshot, choose one action from a fixed menu, write lessons. Never `inputVector`, mode, `SetState`, cheats, or code in the live process. |
| What makes it smart | Every rule is on trial until an interleaved A/B evaluator promotes it; every anomaly action carries an expected effect and a verify-within deadline. |
| Where inference runs | OpenAI-compatible endpoint with JSON-schema output required. Local on the RTX 3090 Ti by default; MiniMax M3 for vision; the coder model for offline C# patches. |

---

## 1. Ground truth from the code (what v3 is built on)

### 1.1 What the body sees today

`BotPerception.Snapshot` (`BotPerception.cs:13-71`): `Valid, GameState, HeroPos,
HeroHpPct, HeroDead, Balance, CoreBalance, IsNight, DayTimeLeft, Wave, WaveTotal,
EnemyCount, NearestCoin*, CoinCount, NearestEnemy*, HasCastle/CastlePos/CastleDist,
OnLevelSelect, SceneName, InteractorCount, LevelCount, NearestLevel*, HasHorn/Horn*,
BuildCount, NearestBuild*, NearestBuildScore, AllyCount, AllyCentroid, CastleThreat*,
HasThreatAnchor, ThreatAnchor`.

Not in the struct: next-wave composition, pending-choice → branch class, foe attack
range, shrine list, wall class (`hpChange`), `PreFinalWaveComingUp`,
`LevelBeatenAsSoonAsWaveFinished`, castle HP %, passive weapon handle, fog visibility.

### 1.2 Facts that shape the design

| Fact | Where | Design consequence |
|---|---|---|
| `wavenumber` starts at −1, increments in `StartSpawning`; during day the raw value is the **last started** night | `EnemySpawner.cs:32,553` | Snapshot gets `NextWaveIndex = IsNight ? Wave : Wave+1`; all rules use it; raw `Wave` stays for logs only |
| `GetWaveInfoForNextWave()` already resolves the day/night offset and fills name, count, elite, `maxHP`, `speed`, `range`, `attackDamage`, `attackCooldown`, `projectileSpeed`, `goldReward`, `difficultyMulti` | `EnemySpawner.cs:600-745`, `WaveEnemyInfo.cs` | P1 calls it once per day-start and once per dusk (it allocates; not per tick) |
| **No flying field** on `WaveEnemyInfo` | `WaveEnemyInfo.cs` | Flying derived from `GetNextWave().spawns[i].enemyPrefab.GetComponent<TaggedObject>().Contains(TagManager.ETag.Flying)` (`TaggedObject.cs:127`) |
| `ChoiceManager.PresentChoices` is called **only** from `BuildSlot.ExecuteUpgrade`; the exact upgrade is stored in private `upgradeSelected` | `BuildSlot.cs:773-792,148` | P2 scores build-branch choices only. Primary lookup: reflection on `upgradeSelected`; fallback `Upgrades[Level]`. Perk frames (`PerkSelectionItem`) are a separate path |
| `Choice.CanBePicked` is an unlock gate, not quality | `Choice.cs:22-35` | Remains the eligibility filter and the tie-break fallback |
| `GetBuildClass` sums income over **all** branches and ignores `hpChange` | `BotPerception.cs:395-434` | P2 scores the pending branch alone; P7 adds the fortification class |
| Shrines charge only from `Hp` real deaths inside `collectionRange`; knock-outs do not count; **any** unit's death counts | `Hp.cs:402-411`, `Shrine.cs:163-180` | B3 = anchor bias, never a day walk |
| `PotionVialAutoCast : ManualAttack`; bot pumps only one of `activeWeapon`/`passiveWeapon` | `PotionVialAutoCast.cs:1`, `Bot.cs:905-906` | P6 pumps both |
| `HandleBlockingFrame` returns before `Decide()` while a choice waits; `RemainingAutoDayTime` keeps running | `Bot.cs:281-293`, `BotPerception.cs:124` | No network on the choice path, ever |
| `PerkManager.SetEquipped` only edits `currentlyEquipped`; `InteractionBegin` on the map was the double-fire | `PerkManager.cs:440-456`, `Bot.cs:356-390` | A7 uses `SetEquipped` before `TransitionFromLevelSelectToLevel`, never opens the loadout frame; respects `LevelInfo.maxPerkCount` and `Equippable.IsUnlocked` |
| Castle is the `CastleCenter` tagged object; `TaggedObject.Hp.HpPercentage` | `TagManager.ETag.CastleCenter`, `Hp.cs:114` | `CastleHpPct` in Snapshot; `castleHpMin` metric |
| BepInEx plugin is net472; the game ships Unity's `JsonUtility`; Newtonsoft is not guaranteed | `ThronefallTrainer.csproj` | Policy and recorder use `JsonUtility` (`[Serializable]` classes, arrays, no dictionaries). Add `UnityEngine.JSONSerializeModule` reference |
| `Snapshot` holds Unity references (`Coin`, `TaggedObject`, `BuildingInteractor`, `Nighthorn`, `LevelInteractor`) | `BotPerception.cs:30-58` | Split into `SnapshotData` (plain values) + `SnapshotRefs`; tests compile against `SnapshotData` only |
| `AUTOPILOT.md`: “Tests — none exist”; 10 890 of 30 276 log lines are `invalid` | `AUTOPILOT.md §7-8` | Phase 0 is recorder + harness; `invalid` collapses to one `scene-load` note |

### 1.3 Live-log evidence (Thronefall.zip “v1”, `bot-log.jsonl`, 37 355 lines, 17 process starts, ≈ 2.7 h)

Measured with a script over the shipped log (`BotSurvivalCheats = false`, `AutopilotEnabled = true` in the cfg):

| Measurement | Value | Design consequence |
|---|---|---|
| `invalid` share | 638 / 37 355 = **1.7 %** (the 36 % figure in `AUTOPILOT.md` was the older log) | D1 still collapses them; the noise problem is now `stuck:*` (519 lines) not loads |
| Nordfels `stuck:3` + `snap` positions | **136 of 150** within one 4 m cell at (0, 4) in `SpendGold` — the keep-interior slot | B2 (hand anchor for the Nordfels keep) moves to **Phase 1**; it is one entry in `anchors.json`, and the anomaly detector’s `add_nav_anchor` has a known first target |
| Nordfels furthest wave | 12 / 13 reached; 5 807 ticks (≈ 24 min) spent at 12/13 | the final night is where `castleHpMin` and `durationNight` matter most; evaluator secondary metrics are right |
| `teleport-nudge` | 8 lines (5 Nordfels, 2 Neuland, 1 map) while cfg says legit | either from an earlier session with the bundle on, or a legit leak; Phase 0 recorder tags every line with `legit` so this is decidable next time — today it is not |
| End-of-match handling | `'After Match Frame '` (note the trailing space) closed by the **generic** branch 12 / 12 times; `match-end` note never fired | `BackToLevelSelectHelper` lookup did not match on this build; Phase 0 verifies and `frames.json` names the frame explicitly |
| `UIFrame.name` values seen | `Level Up Frame`, `After Match Frame ` (trailing space), `Title Frame` | seed list for `config/frames.json`; names are stored trimmed **and** raw |
| `army-placed`, `choice-pick`, `perk-pick`, `horn-interact` | 0 occurrences in this log | army placement never ran in these sessions (`PositionArmy` needs `AllyCount > 0` and `CommandUnits.instance`); the Phase 1 live check must show `army-placed` on Nordfels or the legit night is fought by the hero alone |
| Loadout | `Long Bow` seeded once; `Bow & Dagger` found twice (37.5 m, fires while moving) | A7 has a real baseline to beat |
| Avg line size today | 229 B at 4 Hz ≈ 3.3 MB/h | the 2 Hz 394 B DTO (2.84 MB/h) carries ~3× the fields for less volume |

---

## 2. Architecture

```
┌ Windows 11 · thronefall.exe · BepInEx 5 ─────────────────────────────────────────────────┐
│ L0 BODY (C#)                                                                              │
│   Capture() → SnapshotData + SnapshotRefs                       4 Hz, read-only            │
│   Decide(in SnapshotData, in PolicyTable, ref BotMemory) → DecideResult   PURE, testable   │
│   Tick executes DecideResult.Intents via SnapshotRefs (holds, attacks, army, transitions)  │
│   PolicyTable ← agent/policy.json (JsonUtility, validated, last-good, 1 Hz mtime poll)     │
│   Recorder → agent/runs/<runId>/ticks.jsonl (2 Hz) · events.jsonl · summary.json           │
│   Mailbox  → agent/outbox.jsonl      ← agent/inbox.jsonl (bounded commands)                │
│   No sockets. No threads touching Unity objects. Background writer thread with bounded queue│
└──────────────────────────────┬───────────────────────────────────────▲─────────────────────┘
                               │ files, polled (no inotify dependence)  │
┌ WSL2 · Docker compose ───────▼───────────────────────────────────────┴─────────────────────┐
│ L2 BRAIN  tf-agent: poll outbox (1 s) → evidence pack → LLM (JSON schema) → validate → rules│
│ L3 CRITIC replay harness · interleaved A/B evaluator · live detectors · action verifier     │
│ MEMORY    agent/memory/{episodic,semantic,procedural,working}                              │
│ DASHBOARD FastAPI + single HTML page · localhost:8787                                      │
│ LLM       local (LM Studio :1234 / Ollama :11434 / vLLM :8000) · MiniMax M3 · coder model  │
└────────────────────────────────────────────────────────────────────────────────────────────┘
```

### 2.1 Invariants and how each is enforced

| Invariant | Enforcement |
|---|---|
| Perception is read-only | `Capture()` reviewed; lint forbids `InteractionBegin|SetEquipped|TeleportTo|SetState` tokens inside `BotPerception.cs` |
| `Decide` is pure | `Decide` lives in `BotBrain.cs` with **no** `using UnityEngine` at all (positions are `Vec2`); lint forbids `UnityEngine`, `.instance`, `Time.`, `FindObjectsOfType` in `BotBrain.cs`, `KnobTable.cs`, `PolicyTable.cs`; the netstandard2.0 test project compiles those three files directly |
| Body never waits | no `System.Net` in the plugin (lint); policy load is try/parse/validate/swap with last-good; mailbox appends are enqueued to a bounded queue (cap 2 000 lines, drop-oldest with a `dropped` counter) drained by one background thread |
| Brain writes data, never code, into the live process | the only files the body reads are `policy.json`, `inbox.jsonl`, `anchors.json`, `frames.json`; all schema-validated |
| Every rule bounded, scoped, sourced, expirable, on trial | `policy.schema.json`; knob table with `[min,max]`; evaluator is the sole writer of `status` |
| Legit gate first | knob table contains no cheat entries; lint fails on a knob name outside the allow-list; every `Intent` is tagged `LegitOk` or `CheatOnly` and `Tick` refuses `CheatOnly` when `Legit` |
| Single-player only | if an EOS lobby is active (`Epic.OnlineServices.Lobby` types instantiated), bot, recorder and cheats disable (C5) |

---

## 3. Body (L0) — precise scope

### 3.1 Phase 0 refactor: `SnapshotData` / `SnapshotRefs` / `Decide` / `Intents`

```csharp
// BotPerception.cs
internal struct SnapshotData   { /* all value fields of today's Snapshot + P1..P7 fields; positions as Vec2 (x,z); no UnityEngine types */ }
internal struct SnapshotRefs   { public Coin NearestCoin; public TaggedObject NearestEnemy, CastleThreat, Castle;
                                 public BuildingInteractor NearestBuild; public Nighthorn Horn; public LevelInteractor NearestLevel;
                                 public Choice[] PendingChoices; public ManualAttack Active, Passive; }

// BotBrain.cs (pure; compiled into tests)
internal enum IntentKind { BeginHold, ReleaseHold, PumpAttack, CommandArmy, PlaceArmy, HornInteract, SwitchNight,
                           TransitionLevel, SeedLoadout, PickChoice, CloseFrame, ApplyFrame, BackToMap, MenuAdvance, None }
internal struct Intent        { public IntentKind Kind; public int Index; public bool CheatOnly; }
internal struct Vec2          { public float X, Z; }   // no UnityEngine types in the pure layer
internal struct DecideResult  { public BotMode Mode; public Vec2 AimPos; public float Arrive; public Intent[] Intents;
                                 public int[] RulesFired; }
internal static DecideResult Decide(in SnapshotData s, in PolicyTable p, ref BotMemory m, float now);
```

`BotMemory` holds exactly today's carried statics: mode, held-build id, park list
(by slot name), night-request clock, army phase, session defeats, played scenes,
frame-seen counter, detour state, nav goal. `now` is passed in (`Time.unscaledTime`
at the call site) so tests control time.

`Tick` (in `Bot.cs`) does: `Capture → Decide → execute Intents against SnapshotRefs
→ watchdog → recorder`. Every `TryToAttack`, `InteractionBegin`, `SetEquipped`,
`TransitionFromLevelSelectToLevel`, `CloseActiveFrame`, `SwitchToNight` call moves
into the intent executor. Watchdog and nav steering stay in `Bot.cs` (they need
`AstarPath`) but read `DecideResult.AimPos`.

Effort (est.): ~350 lines moved, ~150 new. No behavior change is intended; the
replay fixtures recorded **before** the refactor must reproduce the same mode
sequence **after** it — that is the Phase 0 regression test.

### 3.2 Snapshot additions

| ID | Fields added to `SnapshotData` | Source | Rate |
|---|---|---|---|
| P1 | `NextWaveIndex`, `NW.Count`, `NW.EliteCount`, `NW.HpSum`, `NW.MaxRange`, `NW.MaxSpeed`, `NW.HasFlying`, `NW.HasRanged` (`range ≥ 6`), `NW.GoldReward`, `NW.Difficulty`, `NW.SpawnLineCentroid` | `GetWaveInfoForNextWave()`, `GetNextWave().spawns[]`, prefab `TaggedObject.Contains(ETag.Flying)` | recompute on day/night edge and on `Wave` change; cached otherwise |
| P2 | `Choice.Count`, per choice: `Pickable`, `IncomeDelta`, `HpDelta`, `Military` (0/1), `Cores` | `ChoiceManager.availableChoices`, origin slot `upgradeSelected` (reflection) → `upgradeBranches[i]` where `choiceDetails == choice` | only while `ChoiceCoroutineWaiting` |
| P3 | `Threat.Range`, `Threat.MinRange`, `Threat.IsRanged`; same for `Near.*` | enemy `AutoAttack.targetPriorities` (max `range`, min `minRange`) | per tick, cached per `TaggedObject` instance |
| P4 | `Shrines[]: X, Z, Activated, Range` (≤ 8) | `Shrine` components via `FindObjectsOfType<Shrine>` at scene load only | scene load |
| P5 | `PreFinalWave`, `LastWaveNext`, `CastleHpPct` | `EnemySpawner.PreFinalWaveComingUp`, `LevelBeatenAsSoonAsWaveFinished`, castle `Hp.HpPercentage` | per tick |
| P6 (= IDEAS A5) | `HasPassiveWeapon`, `ActiveRange`, `ActiveFiresMoving` | `WeaponEquipper.activeWeapon/passiveWeapon`, `DelayManualAttackWhileMoving` | on weapon change |
| P7 | per candidate slot: `Class ∈ {Harvest, Military, Income, Fortify, Keep, Other}`, `HpDelta` | `UpgradeBranch.hpChange`, `objectsToActivate` scan, slot `buildingName` contains "Castle"/"Keep" → `Keep` | per scan (cached per slot) |
| P8 | recorder (below) | — | 2 Hz ticks, all events |
| P9 (= IDEAS G0) | policy table (§4) | — | 1 Hz poll |
| P10 (= IDEAS A3, Phase 5) | `Army.PlacedBearingDeg`, `Threat.BearingDeg` | computed from existing positions | per tick |

`DayTimeLeft` already exists and is not re-added (audit item 2).

### 3.3 Scoring with policy

```
slotScore   = Σ_k knob[k] · phase[k] · class_k(slot) + proximity(slot, NW.SpawnLineCentroid) · knob["score.choke"]
choiceScore = knob["choice.military"]·Military + knob["choice.income"]·IncomeDelta + knob["choice.hp"]·HpDelta   (Pickable only; tie → first Pickable)
standoff    = clamp(max(Threat.Range + knob["stance.foeMargin"], ActiveRange · knob["stance.standoffFrac"]), 4, 14)
retreat     = HeroHpPct < knob["stance.retreatHp"]
armyDepth   = knob["army.depth"] (+ knob["army.shrineBias"] toward an unactivated shrine within 20° of the axis)
```

Defaults reproduce today's numbers exactly (harvest 1000, military 100, income 30+3·min(Δ,10), base 10, stand-off 0.7, retreat 0.5, depth 11), so Phase 2 with an empty rule list is behavior-identical to Phase 1.

### 3.4 Recorder (P8)

- `ticks.jsonl`: compact DTO of `SnapshotData` (short keys ≤ 4 chars per `QUALITY.md`), **2 Hz** (every other decide), only while `Valid`. Measured DTO size 394 B/line → **2.84 MB/h** (4 Hz would be 5.67 MB/h). Retention 14 days or 40 runs, hard cap 300 MB oldest-first.
- `events.jsonl`: every note the log emits today plus `rule-fired` (tapered 5 s), `policy-loaded`, `policy-reject`, `loadout`, `scene-load{durationMs}`.
- `summary.json` on `AfterMatchVictory|Defeat` (schema below). Written once; `runId = yyyyMMddTHHmmssZ-<scene>`.
- Writer: `ConcurrentQueue<string>` cap 2 000, one background thread, `FileShare.ReadWrite`, flush every 250 ms; dropped lines counted and reported in `summary.json.recorder.dropped`.

```json
{ "runId": "20260929T211400Z-Nordfels", "scene": "Nordfels", "legit": true, "result": "victory|defeat|abandoned",
  "waves": 13, "nightsSurvived": 13, "durationS": 1421.5, "castleHpMin": 0.62, "heroDeaths": 1,
  "goldCurve": [10, 24, 31, 40, 52, 61, 70, 84], "goldUnspentAtDuskAvg": 3.1, "stalls": 2, "unsticks": 5, "snaps": 0,
  "choices": [{"wave": 3, "picked": "Archer Tower", "score": 140}], "rulesFired": {"nordfels-walls-late": 7},
  "loadout": ["Bow & Dagger", "Builder's Guild"], "policyVersion": 17, "recorder": {"ticks": 2843, "dropped": 0} }
```

---

## 4. Policy — rule DSL, storage, loading

### 4.1 File (`agent/policy.json`, `JsonUtility`-compatible: arrays, no dictionaries)

```json
{ "schemaVersion": 1, "version": 17, "generatedBy": "tf-agent 0.4.0",
  "knobs": [ { "name": "score.harvest", "def": 1000, "min": 500, "max": 2000 },
             { "name": "score.military", "def": 100, "min": 0, "max": 400 },
             { "name": "score.income", "def": 30, "min": 0, "max": 200 },
             { "name": "score.fortify", "def": 10, "min": 0, "max": 300 },
             { "name": "score.keep", "def": 10, "min": 0, "max": 300 },
             { "name": "score.choke", "def": 0, "min": 0, "max": 150 },
             { "name": "choice.military", "def": 100, "min": 0, "max": 400 },
             { "name": "choice.income", "def": 60, "min": 0, "max": 400 },
             { "name": "choice.hp", "def": 40, "min": 0, "max": 400 },
             { "name": "stance.standoffFrac", "def": 0.7, "min": 0.4, "max": 0.95 },
             { "name": "stance.foeMargin", "def": 1.0, "min": 0, "max": 4 },
             { "name": "stance.retreatHp", "def": 0.5, "min": 0.3, "max": 0.7 },
             { "name": "army.depth", "def": 11, "min": 6, "max": 16 },
             { "name": "army.shrineBias", "def": 0, "min": 0, "max": 1 },
             { "name": "nav.holdSeconds", "def": 7, "min": 4, "max": 15 } ],
  "rules": [ { "id": "nordfels-walls-late", "scene": "Nordfels", "waveMin": 2, "waveMax": 99, "phase": "day",
               "when": [ { "field": "NW.Count", "op": "ge", "value": 20 }, { "field": "Fortify.Count", "op": "lt", "value": 2 } ],
               "then": [ { "knob": "score.fortify", "op": "add", "value": 120 } ],
               "status": "trial", "confidence": 0.6, "createdBy": "reflection", "created": "2026-09-29",
               "expires": "2026-11-01", "evidence": [ "20260929T211400Z-Nordfels" ] } ] }
```

### 4.2 Validation (body side, ~200 lines, all failures → keep last-good + `policy-reject{reason}`)

1. `schemaVersion == 1`; `version` strictly greater than loaded (else ignore silently — a re-write of the same file). A rollback is therefore written by the sidecar as a **new** higher version carrying the previous content.
2. Every `knobs[].name` in the compiled allow-list (`KnobTable.cs`); `min ≤ def ≤ max`.
3. Every `when.field` in `SNAPSHOT-FIELDS.md` (generated from `SnapshotData` by `tools/gen-fields.ps1`; the same generator emits `FieldIndex.cs` so lookup is a switch, not reflection).
4. `op ∈ {lt, le, eq, ge, gt, in}`; `then.op ∈ {add, set, mul}`; `phase ∈ {day, night, any}`.
5. ≤ 40 rules with `status != retired` per scene; ≤ 3 non-retired rules touching the same knob for overlapping scope.
6. `expires` in the future; `status ∈ {trial, promoted, retired}`.
7. Result of `then` is clamped to `[min,max]` at evaluation time, always.

### 4.3 Loading and atomicity

- Sidecar writes `policy.json.tmp` then `os.replace()`; on Windows the body opens with `FileShare.ReadWrite|Delete` and retries once after 100 ms on `IOException`.
- Body polls mtime at 1 Hz on the main thread (cheap `File.GetLastWriteTimeUtc`), parses on a background thread, swaps the reference on the main thread. Ephemeral knobs (from `inbox.jsonl`, `runId`-scoped) overlay the table and expire at `match-end`.

---

## 5. Memory

```
BepInEx/plugins/agent/
  policy.json  anchors.json  frames.json  inbox.jsonl  outbox.jsonl  alive.json
  runs/<runId>/{ticks.jsonl, events.jsonl, summary.json}               episodic (raw)
  memory/
    episodic/index.jsonl          one line per run: summary minus curves      never pruned
    semantic/lessons.jsonl        {runId, scene, claim, proposedRuleId?, outcome: unknown|confirmed|refuted}
    semantic/scenes/<scene>.md    GENERATED from policy + lessons + index (never hand-edited)
    procedural/skills/<name>/     patch.diff · test.cs · provenance.json      merged by PR only
    working/core.md               ≤ 1 200 tokens: goals, bounds, tool contract, style
    working/context.json          rebuilt per call: last 8 events, current summary, active trial
```

Prompt budget (reflection): core 1 200 + context 3 500 + scene playbook 1 800 +
task 900 + JSON schema 600 = **8 000 tokens** input, ≤ 700 output. On a 32B Q4
model at ~22 tok/s output and ~900 tok/s prompt eval (est., RTX 3090 Ti) that is
≈ 9 s + 32 s ≈ **41 s**, inside the 60 s budget. A 14B model halves it.

Compaction (`tf-agent memory compact`, nightly): ticks older than 14 days deleted;
`index.jsonl` keeps summaries forever; lessons with `outcome=refuted` older than 90
days are moved to `lessons.archive.jsonl`.

---

## 6. Brain (L2)

### 6.1 Events → tasks

| Event | Trigger (body) | Brain task | Budget → fallback |
|---|---|---|---|
| `run-start` | `EnterLevel` about to transition | `pick_loadout(scene)` from `index.jsonl` + playbook; ≤ `maxPerkCount`, only `IsUnlocked` | 5 s → today's seeding |
| `day-start` | day edge | optional ≤ 3 ephemeral knobs for this run | 10 s → none |
| `match-end` | `AfterMatch*` | reflection: ≤ 3 lessons, ≤ 2 proposed rules, ≤ 1 retirement request | 60 s, offline |
| `anomaly` | detector (§7.3) | one action from the menu | 20 s → `flag_for_human` |
| `unknown-frame` | `UIFrame.name` ∉ `frames.json` | `request_screenshot` → classify → `close|apply|back` + append to `frames.json` | 10 s → generic close (today's path) |
| `policy-reject` | body | repair or roll back to previous version | — |

Loadout is **frozen for the duration of a trial on that scene** (audit §6): while a
rule is in trial on scene X, `pick_loadout` returns the trial's pinned loadout.

### 6.2 Tool contract (closed set; each has a JSON schema and a test)

`propose_rule(rule)` · `retire_rule(id, reason)` · `set_ephemeral_knob(knob, value, runId)` ·
`pick_loadout(scene, names[])` · `request_level(scene)` · `request_screenshot(crop?)` ·
`query_ticks(runId, tStart, tEnd, fields[])` · `query_runs(scene, limit)` ·
`write_lesson(claim, evidence[])` · `add_nav_anchor(scene, x, z, reason)` ·
`park_slot(scene, slotName, runId)` · `flag_for_human(reason)`

Lint: a tool added without schema + test + bounds entry fails `scripts/lint.ps1`.

### 6.3 Providers

```yaml
# config/agent.yaml — requirement is "OpenAI-compatible + JSON-schema structured output", not a model name
provider: local
local:   { baseUrl: "http://host.docker.internal:1234/v1", model: "${LOCAL_INSTRUCT_MODEL}", vision: false }
minimax: { baseUrl: "https://api.minimax.io/v1", model: "MiniMax-M3", apiKeyEnv: MINIMAX_API_KEY, vision: true }
coder:   { baseUrl: "http://host.docker.internal:1234/v1", model: "${LOCAL_CODER_MODEL}" }   # G4 patches only, offline
routing: { reflection: local, anomaly: local, day-start: local, unknown-frame: minimax, skill-patch: coder }
timeouts: { reflection: 60, anomaly: 20, unknown-frame: 10, day-start: 10, run-start: 5 }
```

`scripts/doctor.ps1` sends a 1-token schema-constrained probe to each configured
provider and fails on any that does not return valid JSON for the schema.

---

## 7. Critic (L3)

### 7.1 Replay harness (Phase 0)

- `tests/Replay.Tests/` (xunit, **netstandard2.0 test target** referencing only `BotBrain.cs`, `SnapshotData`, `PolicyTable`, `KnobTable` — no game DLLs).
- Fixtures: `tests/fixtures/runs/{neuland-tutorial, nordfels-w0-3, craaghelm-core-stall}/ticks.jsonl` recorded live **before** the refactor with the recorder from step 1; `expected.json` holds the mode sequence and `bld` drain per day.
- Assertions: identical mode sequence pre/post refactor; day drains to `bld == 0` before `SwitchNight`; no `CheatOnly` intent when `legit`; with `policy-nordfels.json`, `nordfels-walls-late` fires on day 2 and the top slot class is `Fortify`.
- A proposed rule is replayed against every fixture of its scene before it is written to `policy.json`; a rule that changes the picked slot on a fixture where the recorded run was a **victory** is flagged `risky` and requires interleaved evaluation with the shorter schedule below.

### 7.2 Evaluator — interleaved A/B, not “3 runs then promote”

Campaign variance is high (legit nights take minutes; one elite pack flips `win`).
So a trial never runs alone:

```
schedule per scene:  B A B A B A (B = baseline policy, A = baseline + trial rule), same pinned loadout
min pairs 3, max pairs 6; one trial per scene at a time; other scenes keep playing baseline
primary   = win (0/1), then castleHpMin (0..1)
secondary = heroDeaths↓, goldUnspentAtDuskAvg↓, stalls↓, durationNight↓
promote   if  Σ(win_A − win_B) ≥ 0  AND  mean(castleHpMin_A − castleHpMin_B) ≥ −0.05
          AND  at least one secondary improves in ≥ 2 of the pairs
retire    if  Σ(win_A − win_B) ≤ −2  (early stop)  OR  after 6 pairs without promotion
```

Sample-size honesty: 6 pairs cannot detect a 10 % win-rate change; they can detect
“did not make it worse and moved a secondary.” That is the bar. Thresholds live in
`config/evaluator.yaml` and are knobs, not science. The evaluator is the only writer
of `status`; the brain may only request.

### 7.3 Anomaly loop

| Signature | Detector (sidecar, over `outbox.jsonl`, 1 s poll) | Action menu | verifyWithin |
|---|---|---|---|
| day never ends | `bld > 0` for > 240 s and no `build-stall`/`switch-night` | `park_slot`, `set_ephemeral_knob(nav.holdSeconds, 4)` | 60 s |
| nav wedge | `stuck:3` + `snap` within 8 m for > 30 s | `add_nav_anchor` | next visit to that point (≤ 1 run) |
| UI churn | > 6 `frame-close` in 20 s on one frame | `request_screenshot` → `frames.json` entry | 30 s |
| wave grind | same scene, 3 defeats, no rule change | `request_level`, `retire_rule`, `pick_loadout` | 1 run |
| legit leak | `teleport-nudge` while `legit=true` | `flag_for_human` only | — |
| policy churn | > 3 `policy-loaded` in 60 s | pause brain writes 10 min, `flag_for_human` | — |
| sidecar stale | `alive.json` older than 30 s | body keeps last-good; dashboard red | — |

Each action records `{signature, action, expectedEffect, verifyWithin, outcome}` in
`events.jsonl`. A failed action is never retried for the same signature in the same
run; the next escalation is `flag_for_human`. Detector thresholds mirror `tools/bot-diagnose.ps1`.

---

## 8. Camera

L0 `SnapshotData` is the truth. L1 event screenshot only on `unknown-frame` and the
wipe frame at `match-end`: `ScreenCapture.CaptureScreenshotAsTexture()` (needs the
`UnityEngine.ScreenCaptureModule` reference in the csproj) on the main thread → resize to ≤ 768 px → PNG → `agent/shots/<event>-<t>.png` → deleted after the
tool result is written (sidecar deletes; body sweeps files older than 10 min at start).
L2 synthetic minimap: sidecar renders a 256 px top-down PNG from `ticks.jsonl` (castle,
slots by class, spawn-line centroid, army centroid, hero) — regenerable, no OCR noise.
No streaming, no video, no pixels on the decision path.

---

## 9. File transport between Windows and the container

Docker Desktop bind-mounts of NTFS paths do not deliver inotify reliably and can hold
locks on files the game has open. Therefore:

- The body writes only under `BepInEx/plugins/agent/` with `FileShare.ReadWrite|Delete`.
- The sidecar **polls** (`watchfiles` with `force_polling=True`, 1 s) and reads with
  byte offsets; it never renames or truncates a file the body appends to.
- The sidecar writes `policy.json`, `inbox.jsonl`, `frames.json`, `anchors.json` via
  temp + `os.replace`. The body treats a transient `IOException` as “retry next second.”
- Optional: `scripts/run-dev.ps1 -Native` runs `tf-agent` as a Windows process (uv) for users without Docker; identical code path.

---

## 10. Repository, scripts, gates

```
/
  src/ThronefallTrainer/        Plugin.cs Patches.cs Bot.cs BotPerception.cs BotPatches.cs
                                BotBrain.cs (pure Decide) KnobTable.cs PolicyTable.cs Recorder.cs Mailbox.cs
                                WaveIntel.cs ChoiceIntel.cs FieldIndex.cs (generated)
  src/tf-agent/                 tf_agent/{mailbox,evidence,providers,brain,evaluator,detectors,memory,dashboard}/ · pyproject.toml
  tests/Replay.Tests/           xunit netstandard2.0 · fixtures replay
  tests/fixtures/runs/          neuland-tutorial/ nordfels-w0-3/ craaghelm-core-stall/  (real recordings)
  tests/agent/                  pytest: schema, validator parity (same policy files as C# tests), evaluator, detectors,
                                mailbox offsets; tests/agent/integration/ hits a real local endpoint (compose profile llm)
  docs/                         README ARCHITECTURE(UNDERSTANDING) AGENTIC-DESIGN AGENTIC-RESEARCH IDEAS AUDIT-LOG
                                CONFIG SNAPSHOT-FIELDS(generated) SECURITY TESTING QUALITY CHANGELOG
  scripts/                      doctor run-dev test lint format build release  (.ps1 + .sh)
  docker/                       compose.yaml (tf-agent, dashboard; profile llm: ollama) · Dockerfile
  config/                       agent.yaml evaluator.yaml policy.schema.json knobs.json frames.json anchors.json
  tools/                        bot-lint.ps1 (extended) bot-diagnose.ps1 build-and-deploy.ps1 decompile.ps1 gen-fields.ps1
  env/.env.example              MINIMAX_API_KEY= LOCAL_INSTRUCT_MODEL= LOCAL_CODER_MODEL=
```

| Script | Checks / does | Fails when |
|---|---|---|
| `doctor.ps1` | .NET SDK ≥ 8 · `GameDir` has `thronefall.exe`, `BepInEx/core/0Harmony.dll`, `Thronefall_Data/Managed/UnityEngine.JSONSerializeModule.dll` · Python 3.12 · Docker or `uv` · ports 8787 free · each provider answers a schema probe · `.env` has no key inside `agent.yaml` | any FAIL; prints the fix command |
| `run-dev.ps1` | `dotnet build -c Release` → `build-and-deploy.ps1` (stops game, copies DLL) → `compose up -d` (or `-Native`) → opens dashboard | build or health check fails within 60 s |
| `test.ps1` | `dotnet test` (replay) · `pytest` · `pytest -m integration` when `llm` profile is up · smoke: drop a fixture summary in outbox and expect a validated `policy.json` within 90 s | any test fails or smoke times out |
| `lint.ps1` | `bot-lint.ps1` (legit gate, log widths, unscaled time, refs, enum coverage, snapshot fields, **purity of BotBrain.cs, knob allow-list, no System.Net**) · `ruff` · `mypy --strict` · `PSScriptAnalyzer` · forbidden-pattern scan · `gen-fields.ps1 -Check` drift | any warning |
| `format.ps1` | `dotnet format` · `black` · `ruff --fix` · `Invoke-Formatter` | never (applies) |
| `build.ps1` | Release DLL + `tf-agent` wheel + image | warnings (TreatWarningsAsErrors) |
| `release.ps1` | zip {DLL, config/, scripts/, docs/, image tar} + SHA256SUMS · boots sidecar from the zip on a clean WSL distro and runs smoke | smoke fails |

CI (`.github/workflows/ci.yml`) runs exactly `lint.ps1`, `build.ps1`, `test.ps1` on a
Windows runner (C#) and an Ubuntu runner (Python); game DLLs are not in CI, so the
plugin build in CI compiles against a **reference assembly** produced by
`tools/gen-refstub.ps1`: it compiles `decompiled/*.cs` with `csc -refonly` after a
Roslyn pass that replaces every method body with `throw null`. If a game patch makes
that pass fail, the documented fallback is a **self-hosted Windows runner with the
game installed** (`runs-on: [self-hosted, thronefall]`), and `doctor.ps1` reports
which path CI is using. The reference assembly is build-only and never shipped.

Mocks: LLM calls are mocked in unit tests only; `tests/agent/integration/` uses the
real local endpoint; the body has no mocks — the harness runs the real `Decide`.

---

## 11. Phases with Definition of Done

| Phase | Scope | Done when (all must hold) |
|---|---|---|
| **0 Foundation** | D1 D2 D5 P8: recorder (2 Hz DTO, events, `summary.json`), `invalid` collapse, `SnapshotData/Refs` split, pure `Decide` + intents, `Replay.Tests`, 3 fixtures recorded pre-refactor, `scripts/*`, CI, `SECURITY.md` | pre/post-refactor mode sequences identical on all 3 fixtures · `bot-lint` 0 FAIL · `doctor.ps1` PASS on a clean clone · `test.ps1` green · CHANGELOG entry |
| **1 Awareness** | P1 P2 P3 P4 P5 P6 P7 (IDEAS A1 A2 A4 A5), scorers per §3.3 with compiled defaults, B2 `anchors.json` with the Nordfels keep anchor | replay: Nordfels fixture day 2 top slot is `Fortify` when `NW.Count ≥ 20` · choice picks are branch-scored (fallback only on ties) · kite distance uses `Threat.Range` · both weapons pumped (event count) · live: one Nordfels run recorded with the new fields non-zero, `army-placed` present, and `snap` count at (0, 4) reduced from 64 to ≤ 5 |
| **2 Policy** | P9/G0: `KnobTable`, `PolicyTable`, validator, hot reload, `gen-fields.ps1` (D6), overlay rule strip (C3), timings as knobs (D4) | empty rule list ⇒ scores identical to Phase 1 (replay) · hand-written rule changes live scoring within 1 s · malformed file ⇒ last-good + `policy-reject` · C# and Python validators agree on 20 shared fixture files |
| **3 Brain** | G1 G3 A7: `tf-agent` mailbox, evidence pack, provider client, reflection → trial rules, `pick_loadout`, dashboard | smoke passes on local model · 3 consecutive matches each yield ≤ 2 schema-valid trial rules · dashboard shows runs, rules, live status, alive |
| **4 Critic** | G5 B1: interleaved evaluator, pinned loadout during trial, lessons outcome tagging, playbook generation | injected bad rule (`score.income = max` on last night) retired within ≤ 6 pairs unattended · injected good rule promoted · `scenes/Nordfels.md` regenerates from data |
| **5 Solver** | G6 detectors, action menu, verify-within, G2 `unknown-frame` with vision provider, P10/A3 army re-command | wedge fixture ⇒ `add_nav_anchor` ⇒ signature clears in replay · unknown frame classified once via screenshot and added to `frames.json` · `legit leak` always flags human |
| **6 Stretch** | G7 synthetic minimap, A6 fog-limited ruleset, B3 shrine bias, G4 coder patches via PR, B4 Eternal Trials, C1 profiles, C4 DLL split | only after 4–5 are boring |

Phases 0–2 are pure C# and are the empirical gate (audit §10): if hand-written rules
in Phase 2 do not change a Nordfels day buy, no LLM will either.

---

## 12. Failure modes and recovery

| Component | Failure | Detection | Recovery |
|---|---|---|---|
| Recorder | disk full / IO error | write exception counter | stop recording, keep playing, `recorder-error` event once |
| Recorder | queue overflow | `dropped > 0` | drop-oldest; reported in summary |
| Policy | invalid file | validator | last-good; `policy-reject`; brain repairs |
| Policy | stale file (version ≤ loaded) | version check | ignored |
| Mailbox | file locked | `IOException` | retry next second; never block Tick |
| Sidecar | down | `alive.json` age > 30 s | body unaffected; dashboard red; detectors resume from byte offset |
| Provider | timeout / bad JSON | schema validation | per-event fallback (§6.1); 3 consecutive failures ⇒ provider marked degraded for 10 min |
| Evaluator | confounded trial (loadout changed) | pin check | pair discarded, not counted |
| Game patch | API drift | `decompile.ps1` diff + `bot-lint` refs | Snapshot fields that fail to resolve are logged once and read as 0; rules on them never fire |

---

## 13. Security

Game process opens no sockets, executes no downloaded code, reads four validated
files. Sidecar container mounts only `agent/`; no access to `ThroneSave.sav`. Keys in
`.env` only; `doctor.ps1` refuses keys in YAML. Screenshots deleted after use, never
committed (`.gitignore`). Multiplayer guard (C5). Tool set closed and lint-enforced.
`SECURITY.md` lists these as the threat model and the reporting path.

---

## 14. Explicitly not doing

Per-tick LLM · LLM-written inputs, modes, `SetState` or cheats · fine-tuning on
`bot-log.jsonl` · pixels-first control · live codegen into the DLL · vector DB, VPS or
multi-agent crews before the file-based design is exhausted · synchronous brain on any
UI frame.
