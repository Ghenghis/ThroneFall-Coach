# Ideas backlog (v3) — ranked, corrected, no implementation

Companion to `AGENTIC-DESIGN.md` (architecture and phases) and `UNDERSTANDING.md`
(how the code sits together). This file is the menu. Ranking is by leverage for
a **legit campaign autopilot that learns**, given the code as shipped in the zip.

Effort: S = score/mode tweak · M = new perception + Decide branch · L = new subsystem.
Phase = where it lands in `AGENTIC-DESIGN.md §10`.

Changes from v1 are marked **[changed]** with the reason — most came from reading
`decompiled/` rather than guessing.

---

## P. Perception — make the body see what the player sees (Phase 1)

| ID | Idea | Why | Source | Effort |
|---|---|---|---|---|
| **P1** | **Next-wave preview in Snapshot** — `NextWaveIndex`, enemy count, elite count, total HP, max range, fastest speed, `difficultyMulti`, `goldReward`; flying derived from the prefab tag (`TaggedObject.Contains(ETag.Flying)`, not on `WaveEnemyInfo`) | The player sees this before every night; the bot buys blind. Drives A2, A3, A4, stance and retreat thresholds. **[biggest single gain; ~40 lines for the call, the scoring wiring is A2]** | `EnemySpawner.GetWaveInfoForNextWave()`, `GetNextWave()`, `WaveEnemyInfo` | M |
| **P2** | **Choice → branch mapping** — each pending build-upgrade `Choice` resolved to its `UpgradeBranch` (income Δ, hp Δ, military objects) | Makes A1 exact for `ChoiceManager` frames (the only caller is `BuildSlot.ExecuteUpgrade`); perk frames are a different path. **[changed: v1 proposed a name rubric]** | origin slot private `upgradeSelected` (reflection) → `upgradeBranches[i].choiceDetails == choice`; fallback `Upgrades[Level]` | S |
| P3 | Foe range on `CastleThreat` / `NearestEnemy` | Kite outside *their* range (A4). | `AutoAttack.targetPriorities[].range/minRange` | S |
| P4 | Shrine list: position, activated, `CollectionRange` | Enables the corrected B3. | `Shrine` (`ShrineHasBeenActivated`, `ParentBuildSlot`) | S |
| P5 | Phase flags: `PreFinalWaveComingUp`, `LevelBeatenAsSoonAsWaveFinished`, `CastleHpPct` (`DayTimeLeft` already exists) | Late-game multipliers with real flags instead of `Wave/WaveTotal` arithmetic. | `EnemySpawner`, castle `Hp.HpPercentage` | S |
| P7 | Wall classification: branch with `hpChange > 0` and no military object | Walls stop scoring as "other". | `UpgradeBranch.hpChange` | S |
| P8 | **Recorder**: compact `SnapshotData` DTO at 2 Hz (394 B/line ≈ 2.8 MB/h) + events + `summary.json` per run | Feeds replay tests, evaluator, brain. Everything downstream needs it. **[moved to Phase 0]** | — | M |

## A. Highest leverage on legit play (Phase 1–2)

| ID | Idea | Notes | Depends | Effort |
|---|---|---|---|---|
| **A1** | Choice scoring | `choice.military / choice.income / choice.hp` knobs × phase; tie → first `CanBePicked` fallback so the resolver cannot stall. | P2 | S |
| **A2** | Wave-aware + chokepoint build scoring | `score.wall` rises with `NextWave.Count` and range; slot nearest the next spawn line gets a proximity bonus; last two nights flip income below defense. | P1, P7 | M |
| A3 | Mid-wave army re-command | Re-place when threat bearing vs placed bearing > 35° or castle HP drops a bucket; throttle ≥ 10 s. | existing `CommandUnits` path | M |
| A4 | Kite on foe range | Hold just outside `foe.range + 1`, step in only when the castle is being hit. | P3 | S |
| A5 | Ability / potion pump | **[changed]** `PotionVialAutoCast` *is* a `ManualAttack`; today `PumpAttack` holds only one handle (`Bot.cs:905`). Pump `TryToAttack()` on `WeaponEquipper.activeWeapon` **and** `passiveWeapon`. No new potion code. | — | S |
| A6 | Fog-limited perception (hard-legit flag) | Filter enemies/coins by `FogOfWarManager` / `VisionSource`. Later, as a stricter ruleset. | Phase 6 | M |
| A7 | **Legit loadout per scene** | Today: best unlocked weapon only. Choosing perks/weapon on the map is a legit player decision and the biggest lever the brain can pull (`PerkManager.SetEquipped`, `LevelInfo.maxPerkCount`, `Equippable.IsUnlocked`). Must never reopen the loadout frame (that was the double-fire). Frozen while a rule is on trial for that scene. **[new]** | Phase 3 brain `pick_loadout`, else a static table | M |

## B. Map intelligence

| ID | Idea | Notes | Effort |
|---|---|---|---|
| B1 | Per-scene playbooks | **[changed]** Not hand-written markdown: `policy.json` rules scoped by scene, plus a *generated* `scenes/<scene>.md`. Humans read; the body executes the JSON. | S → M |
| B2 | Hand nav anchors for keep interiors / node rings | **Phase 1** — the live log puts 136 of 150 Nordfels wedges in one 4 m cell at (0, 4) during `SpendGold`. 2–3 anchors per scene in `config/anchors.json`; the anomaly loop may add one (`add_nav_anchor`). | S |
| B3 | Shrines | **[changed — v1 was wrong]** Shrines charge from real unit deaths (any side; knock-outs excluded) inside `CollectionRange` via `Hp` → `Shrine.DeathOfUnitAt`, not from walking to them. Correct idea: when an unactivated shrine lies within ~20° of the threat axis, `army.shrineBias` pulls the anchor so kills land in range. | S |
| B4 | Eternal Trials / bonus nodes | `ETMapChoiceDisplay`, `BonusLevelInteractor`. After the campaign loop is boring. | L |

## G. Agentic layer (Phase 3–5) — see `AGENTIC-DESIGN.md`

| ID | Idea | Notes | Effort |
|---|---|---|---|
| G0 | **Policy table + rule DSL** (`policy.json`, bounds, hot reload, reject-on-error) | The interface between brain and body. **[new; replaces "playbook weights" free text]** | M |
| G1 | Match-end reflection → *trial* rules | ≤ 2 proposed rules, ≤ 3 lessons per match; local model by default. | M |
| G2 | Screenshot as a tool | `unknown-frame` and wipe post-mortem only. Vision provider optional. | M |
| G3 | Sidecar + local dashboard (Docker on WSL2 or native `uv`) | File mailbox, polled (no inotify over DrvFs), no sockets in the game. **[changed: VPS optional]** | M |
| G4 | Procedural skills via PR | Cat Coder / local coder writes scorer patch + replay test; lint + human merge. | M |
| **G5** | **Evaluator: trial → promoted / retired** | Interleaved B A B A B A pairs per scene (3–6 pairs), pinned loadout, deterministic metrics over `summary.json`. Detects "not worse + a secondary improved", not 10 % win-rate deltas. **[new — without it, reflection drifts]** | M |
| **G6** | **Anomaly loop** | Live detectors + bounded action menu + verify-within + human flag. **[new]** | M |
| G7 | Synthetic minimap from Snapshot | Spatial reasoning for the brain without pixels. | S |

## C. Overlay / trainer product

| ID | Idea | Notes | Effort |
|---|---|---|---|
| C1 | Profiles: Sandbox / Farm / Legit bot / Review | cfg sections, one click. | M |
| C2 | Persist-session button | overlay → cfg write-back. | S |
| C3 | Bot status strip: mode, target, gold, `bld`, `NextWaveIndex`, counters, **rules fired this tick**, sidecar alive | AUTOPILOT §9 wants it; the rule strip is new. | S |
| C4 | Split DLL (Trainer / Bot / Agent) | when the coupling hurts; not before Phase 3. | L |
| C5 | Multiplayer guard | disable bot, mailbox, cheats when an EOS lobby is live. | S |

## D. Telemetry & tooling (Phase 0)

| ID | Idea | Notes | Effort |
|---|---|---|---|
| D1 | Collapse `invalid` ticks into one `scene-load` note with duration | ~36 % of the log today. | S |
| D2 | Per-run `summary.json` | schema in `AGENTIC-DESIGN.md §5`. | S |
| D3 | Dashboard | now part of the sidecar (G3). | — |
| D4 | Config-ify timings | become knobs with bounds (`nav.holdSeconds` etc.). | S |
| **D5** | **Replay harness** | Pure `Decide(in SnapshotData, in PolicyTable, ref BotMemory)` returning intents; side effects stay in `Tick`. xunit on netstandard2.0, no game DLLs. Fixtures recorded before the refactor. **[moved to Phase 0; seam shrunk per audit]** | M |
| D6 | `gen-fields.ps1`: `SNAPSHOT-FIELDS.md` + `FieldIndex.cs` from `SnapshotData`, lint drift check | the rule DSL lies without it. **[new]** | S |

## E. Combat / army refinements

| ID | Idea | Notes | Effort |
|---|---|---|---|
| E1 | Night coin dip when `foes == 0` between spawns | gate: castle not under fire, hp > 0.6. | S |
| E2 | Depth by weapon range | melee holds with the line; longbow further back. | S |
| E3 | Clone-troop hygiene (cheat side) | label "until dawn" or register with respawner. | S |
| E4 | Charm-all after spawn ends (cheat side) | gate on `EnemySpawner.SpawningInProgress`. | S |

## F. Meta / progression — overlay only, never in legit bot

Selective perk equip (score like A1), crown hunter for incomplete quests
(`LevelInfo.quests`), save-slot backup on first F6. All write `ThroneSave.sav`;
keep them behind explicit buttons.

---

## Build order (matches the phases)

```
Phase 0  D1 D2 D5 P8               recorder · summary · pure Decide + replay · scripts · CI
Phase 1  P1 P2 P3 P4 P5 P7 A1 A2 A4 A5 B2   awareness + scoring + keep anchor (no LLM yet)
Phase 2  G0 D6 C3 D4               policy table · field generator · rule strip · knobs
Phase 3  G1 G3 A7                  brain · dashboard · loadout
Phase 4  G5 B1                     evaluator · generated playbooks
Phase 5  G6 G2 A3                  anomaly loop · screenshot tool · re-command
Phase 6  G7 G4 A6 B3 B4 C1 C4      polish and stricter rulesets

Design-doc aliases: P6 = A5, P9 = G0, P10 = A3.
```

## Traps (kept, plus new ones)

| Idea | Why not |
|---|---|
| GOAP / utility-AI rewrite | Ten modes are documented; scoring + policy is the missing piece. |
| Learn a policy from jsonl | 4 Hz logs are not labelled expert actions. |
| Replace A* with a grid | `AstarPath` exists; anchors + sidesteps fix known holes. |
| Bot fills the loadout UI | `InteractionBegin` on the map is how double-fire came back; seed `PerkManager` directly (A7). |
| InstantKill as "legit night" | that is the bundle; the lint contract dies. |
| Auto-resign / retry | hides the defeats used for node rotation. |
| **Brain picks choices synchronously** | day timer runs; holds freeze. Score in-process, reweight between matches. |
| **Free-text lessons as the policy** | unvalidated, unbounded, unreplayable. DSL or nothing. |
| **Reflection without an evaluator** | confident lessons that were never tested accumulate; the bot gets worse with a story. |
| **Walking to shrines** | they charge on kills in range, not proximity. |
| **Bind-mounting the plugin folder and tailing with inotify** | DrvFs drops events and can lock files the game holds; poll with byte offsets. |
| **Newtonsoft / System.Text.Json in the plugin** | not guaranteed in the game's Managed folder; `JsonUtility` with arrays. |
