# Audit log — v1 → v2 → v3

How the design packet was reviewed, what changed, and what was verified. Kept in
the repo so the next reviewer does not redo the work.

## 1. V2-AUDIT.md items — disposition

| # | Audit item | Verified against | Disposition in v3 |
|---|---|---|---|
| 1 | P1 lists a “flying flag” that is not on `WaveEnemyInfo` | `WaveEnemyInfo.cs` (no such field); `TaggedObject.Contains` at `TaggedObject.cs:127`; `TagManager.ETag.Flying` | **Fixed.** `NW.HasFlying` derived from `GetNextWave().spawns[i].enemyPrefab` tag; listed as extra work in §3.2 |
| 2 | P5 re-adds `RemainingAutoDayTime`, already `Snapshot.DayTimeLeft` | `BotPerception.cs:124` | **Fixed.** Removed from P5; P5 = `PreFinalWaveComingUp`, `LevelBeatenAsSoonAsWaveFinished`, `CastleHpPct` |
| 3 | P2 scores “choices” but only build-branch choices go through `ChoiceManager` | `PresentChoices` callers: `BuildSlot.cs` only; perk frames use `PerkSelectionItem` (`Bot.cs:840-857`) | **Fixed.** Scope stated; primary lookup via private `upgradeSelected` (`BuildSlot.cs:148,784`) with `Upgrades[Level]` fallback |
| 4 | Raw `Wavenumber` ≠ HUD next wave | `EnemySpawner.cs:32` (init −1), `:553` (increment) | **Fixed.** `NextWaveIndex` added; rules may not reference raw `Wave` |
| 5 | `qwen3-32b-instruct` hard-coded as the local default | user runs LM Studio / Ollama with many models and a separate coder model | **Fixed.** Requirement is “OpenAI-compatible + JSON-schema output”; model names are `${LOCAL_INSTRUCT_MODEL}` / `${LOCAL_CODER_MODEL}` env vars; `doctor.ps1` probes each provider |
| 6 | Docker bind-mount of the plugin folder: DrvFs drops inotify and can lock jsonl | Docker Desktop WSL2 guidance | **Fixed.** §9: polling with byte offsets (`watchfiles` `force_polling`), `FileShare.ReadWrite|Delete` in the body, temp + `os.replace` from the sidecar, `-Native` run mode |
| 7 | Full `IDecideHost` seam in Phase 0 is over-scoped | `Decide()` call sites in `Bot.cs` (11 Unity singletons) | **Fixed.** Pure `Decide(in SnapshotData, in PolicyTable, ref BotMemory, now) → DecideResult{Intents}`; side effects executed in `Tick`; `SnapshotData`/`SnapshotRefs` split so tests need no game DLLs |
| 8 | 3-run promotion is underpowered | `AUTOPILOT.md §8.6` (nights take minutes), NeverLose off ⇒ single elite pack flips `win` | **Fixed.** Interleaved B A B A B A pairs (3–6), pinned loadout, early stop, explicit statement of what 6 pairs can and cannot detect; thresholds in `config/evaluator.yaml` |
| 9 | PDF page 5 almost empty | v2 render | **Fixed.** v3 packet re-flowed; every page inspected |
| 10 | “~40 lines” for P1 is the call, not the scoring | — | **Fixed.** Stated in §3.2 and IDEAS P1: call ≈ 40 lines, wiring is A2 |
| — | Shrine XP counts any unit death, not enemy-only | `Shrine.cs:163-180`, `Hp.cs:402-411` | **Adopted.** IDEAS B3 and design §1.2 say “any side; knock-outs excluded” |
| — | `PumpAttack` holds one handle; passive never pumped | `Bot.cs:905-906` | **Adopted.** P6/A5 text cites the line |
| — | A7 loadout must never reopen the loadout frame | `Bot.cs:356-390`, `AUTOPILOT.md` double-fire | **Adopted.** §1.2 and §6.1 |
| — | Loadout confounds trials | — | **Adopted.** Loadout pinned per scene while a rule is on trial |
| — | Recorder must not dump object graphs at 4 Hz | `AUTOPILOT.md` 36 % `invalid` | **Adopted.** Compact DTO, 2 Hz, measured 394 B/line |
| — | Keep `AGENTIC-RESEARCH.md` as bibliography | — | **Adopted.** Restored with a header pointing to the design of record |
| — | Provider split: MiniMax for vision, coder for patches | user stack | **Adopted.** `routing:` in `agent.yaml` |

## 2. Findings from the v3 self-review passes (not in the audit)

| Pass | Finding | Evidence | Change |
|---|---|---|---|
| 1 | The plugin cannot assume Newtonsoft or `System.Text.Json`; BepInEx 5 on net472 against a Unity 2022 game | `ThronefallTrainer.csproj` references; Unity ships `UnityEngine.JSONSerializeModule` | Policy and recorder use `JsonUtility`; file shapes use arrays, not dictionaries; csproj gains the module reference |
| 1 | `Snapshot` holds Unity object references, so no test project can construct it without game DLLs | `BotPerception.cs:30-58` | `SnapshotData` (values, `Vec2` positions) / `SnapshotRefs` split |
| 1 | `Vector3` in the pure layer would still drag `UnityEngine.CoreModule` into tests | — | `Vec2` struct in the pure layer; conversion at the seam |
| 1 | The exact upgrade being chosen is available directly | `BuildSlot.cs:148` private `upgradeSelected`, set at `:784` before `PresentChoices` at `:788` | Reflection primary, `Upgrades[Level]` fallback |
| 2 | Castle HP was named as a metric but had no source | `TagManager.ETag.CastleCenter`; `TaggedObject.Hp`; `Hp.HpPercentage` (`Hp.cs:114`) | `CastleHpPct` added to P5 |
| 2 | Policy “version must increase” blocks rollbacks | §4.2 | Rollback = new higher version with previous content |
| 2 | `ScreenCapture` needs its own Unity module reference | Unity module layout | Noted in §8 and `doctor.ps1` |
| 2 | Heartbeat described two ways (outbox event vs file) | v2 UNDERSTANDING §11 vs design | `alive.json` everywhere |
| 2 | Recorder at 4 Hz would be 5.7 MB/h — recreates the noise the audit measured | 394 B × 4 × 3600 | 2 Hz (2.84 MB/h), 14-day / 40-run / 300 MB caps |
| 3 | CI cannot build the plugin without game DLLs | — | `csc -refonly` reference assembly from `decompiled/` with a Roslyn body-strip pass; documented fallback = self-hosted Windows runner; the stub is never shipped |
| 3 | IDs P6/P9/P10 existed in the design but not in IDEAS; phase membership differed between the two docs | cross-reference script | Aliases declared (P6=A5, P9=G0, P10=A3); phase tables aligned (checked by script, see §3) |
| 3 | Mailbox/lint gaps: nothing stopped a future `System.Net` call or a cheat-named knob | — | Lint rules: no `System.Net` in plugin, knob allow-list, purity of `BotBrain.cs`/`KnobTable.cs`/`PolicyTable.cs`, intents tagged `CheatOnly` refused under `Legit` |

## 3. Verification performed on the v3 packet

1. **Identifier check.** Every CamelCase token inside backticks in `AGENTIC-DESIGN.md`,
   `IDEAS.md`, `UNDERSTANDING.md` was extracted and searched in `src/`, `decompiled/`,
   `decompiled_fog/`, `tools/`, `*.md` of the zip. Remaining non-matches are .NET/Unity
   framework APIs (`FileShare`, `ConcurrentQueue`, `IOException`, `GetLastWriteTimeUtc`,
   `ScreenCapture.CaptureScreenshotAsTexture`, `PSScriptAnalyzer`), document names, or
   names this design introduces (`SnapshotData`, `BotBrain`, `PolicyTable`, …). No game
   API is cited that does not exist in the dump.
2. **Cross-reference check.** Every idea ID used in the design's phase table is defined in
   `IDEAS.md`; the build-order block in `IDEAS.md` and the phase table in the design list
   the same IDs per phase (script output recorded during the review).
3. **Arithmetic.** 394 B × 2 Hz × 3600 s = 2.84 MB/h; × 4 Hz = 5.67 MB/h. Prompt budget
   1 200 + 3 500 + 1 800 + 900 + 600 = 8 000 tokens. Latency est. 8 000 / 900 + 700 / 22
   ≈ 41 s (< 60 s budget). Throughput figures are estimates for a 32B Q4 model on an
   RTX 3090 Ti and are labelled as such.
4. **Render check.** The PDF was rendered and every page inspected for orphaned headers,
   overflow and empty pages.

## 4. Evidence added from Thronefall.zip (“v1”, live install snapshot)

Source files in `Trainer/src` are byte-identical to the first zip. New material: `BepInEx/config/dev.thronefall.trainer.cfg` (legit, autopilot on), `BepInEx/LogOutput.log` (last process), `bot-log.jsonl` (37 355 lines). Findings are in design §1.3: the Nordfels keep wedge cluster, the trailing-space `After Match Frame ` handled generically, zero `army-placed`, 1.7 % `invalid`, and 8 unexplained `teleport-nudge` lines. B2 moved to Phase 1; `frames.json` seeded. `Thronefall_Data/Managed` is not in the zip, so the `JSONSerializeModule` / no-Newtonsoft assumption remains a `doctor.ps1` check, not a verified fact.

## 5. Open items that only running code can settle

- Whether `csc -refonly` over `decompiled/*.cs` compiles cleanly for this game build
  (fallback documented).
- Real prompt-eval and generation speed of the chosen local model (budget has ~19 s slack).
- Whether `FindObjectsOfType<Shrine>` at scene load sees shrines that are spawned later
  (if not, re-scan on day edge — cheap).
- The exact `frames.json` list; it is built empirically from `UIFrame.name` values seen in
  `bot-log.jsonl` (`ui` notes) during Phase 0 recording.
