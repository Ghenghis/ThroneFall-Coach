# Quality Framework — Thronefall Trainer

Standards, automated checks, and debugging procedures for the mod. Read
alongside `AUTOPILOT.md` (what the bot does) and `BOT-DEV.md` (how to extend).

## 1. Coding standards

**Bot code (`src/Bot.cs`, `src/BotPerception.cs`)**

- **Legit gating**: any player-impossible capability must be behind
  `if (Legit)`/`else` or `if (!Legit)`. Currently gated: `Attack()` direct
  calls, `Hp.TakeDamage` fallbacks, `TeleportTo` movement nudges. When adding
  power-paths, mirror the split — `tools\bot-lint.ps1` greps for violations.
- **Perception is read-only** — `Capture()` never mutates game state.
- **Timers use `Time.unscaledTime`** — the bot ticks while scenes load and
  pause menus freeze `Time.time`. Never raw `Time.time` in Bot.cs.
- **Log fields ≤4 chars** (`bld`, `horn`, `lvln`) — histogram tooling keys
  off the fixed width.
- **Notes are one-shots** — `LogLine(in s, "x")` fires on the event edge, not
  per tick (use `DiagLog` for BepInEx-level events: on-change or tapered).
- **Throttle expensive scans** — `Resources.FindObjectsOfTypeAll` and LINQ
  over long lists go behind a `*_At` clock (1 Hz pattern exists).
- **Verify API names against `decompiled/`** — dumps go stale on game
  patches. The decompiled source is the contract; training-data Unity APIs
  for this engine are unreliable.

**Events / UI (`src/Plugin.cs`)**

- Overlay is Unity IMGUI (`OnGUI` + `GUILayout.Button` + `Event.current`):
  buttons re-evaluate every repaint — they inherently respond to clicks; no
  explicit event wiring needed. Keep handlers **idempotent and null-guarded**
  (singletons like `TagManager.instance` are null on menus/loads).
- Hotkeys go through `ReInput`/`UnityEngine.Input` in `Update`, not OnGUI.
- Bot-written UI state (frame closes, choice picks) must be **throttled via
  `frameActionAt`-style clocks** — rapid Apply/Close churn corrupts the
  frame stack.

**Style**: compact code, existing conventions, minimal comments — code
should explain itself; comments only where behavior is non-obvious (see the
inline rationale comments added with the navigation work).

## 2. Automated checks

| Tool | What it catches | Run |
|---|---|---|
| `tools\bot-lint.ps1` | ungated cheat calls, >4-char log fields, `Time.time` misuse, missing csproj refs, dead enum values, unresolved `s.X` refs, learning-stack wiring (Policy/Memory/NetPolicy/Overlay/Coach present, net shadow-only, coach off-thread, F1 toggle) | after every `src/` edit; exit code = #FAIL |
| `tools\verify.ps1` | one-shot: lint + build + replay fixture + coach-server `/state` + `/metrics` | before claiming a deploy works; `-ReplayTol N` for memory-drift ticks, `-NoBuild` to skip compile |
| `tools\bot-diagnose.ps1` | live-state defects: hero parked in travel mode, unstick storms, day-never-ends, wave grind, UI churn, cheat leaks vs config, log stall | any time the run looks wrong; `-Lines N` for window size, `-Fix` for config repair |
| `tools\build-and-deploy.ps1` | builds Release, stops the game (DLL locks while running), copies to plugins, relaunches | standard deploy path |
| `dotnet run --project tests\Replay` | replays recorded `ticks.jsonl` through `BotBrain.Decide` — catches decision regressions offline | after changing decide logic; `--tol N` for memory-dependent drift |
| `dotnet build -c Release` | compile errors | before deploy |

Pre-deploy checklist: `bot-lint` → build → `build-and-deploy` →
`bot-diagnose` ~60 s into the run → `verify` for the full gate.

## 3. Debugging workflow

1. **Reproduce** — let `bot-log.jsonl` show the symptom (4 Hz rows + notes).
2. **Diagnose** — `bot-diagnose.ps1` flags the signature class; the BepInEx
   `LogOutput.log` `[bot]` lines carry the detail (stuck strikes with
   `frozen`/`ts`/`frame` fields, `nav-path` results, `move-diag` internals,
   `spend target` scoring).
3. **Instrument** — add a bounded `Plugin.Log` diagnostic (counter-limited,
   like `navDiagCount`) rather than per-tick spam; redeploy.
4. **Root-cause before fixing** — see §4 examples: each symptom had a
   different mechanism; only instrumentation separated them.
5. **Verify** — fresh-run the scenario; old `bot-log.jsonl` lines persist
   across restarts so filter by `t` relative to process start.

## 4. Resolved-issue examples (what the process caught)

- **Hero `moved 0.00` on Nordfels** — not a freeze (`frozen=False, ts=1`),
  not a collider wedge: the A* path degenerated to `1 wp` at the hero's own
  node, `navSteerArrive=1.0` made `DesiredDir` identically zero. Fix:
  `NavSteerPoint` treats paths that can't reach the goal as no-path →
  straight-line steering. `move-diag` instrumentation exposed it.
- **Hidden attack-speed cheat** — `heroAttack.Attack()` every 0.25 s bypassed
  `cooldownTime` for ~4× fire rate. Fix: legit path uses `TryToAttack()` and
  relies on `autoAttack` — real cadence, verified by slower kill times.
- **Map transition double-fire** — `level-interact` fired repeatedly because
  the busy flag wasn't checked. Fix: `sceneTransitionIsRunning` via
  reflection + `levelInteractAt` throttle + `InteractionBegin` removed.
- **Level Up Frame "lost perk"** — investigated as a possible skipped
  selection; decompiled `ChoiceManager`/`PerkSelectionItem` showed the real
  perk UI never opens post-match — the frame is a notification, closing it
  is correct. Docs updated rather than code.
- **Day-never-ends** — parked-slot list expired too fast (20 s parks
  re-entered the scan). Fix: park-for-day, clears at dusk. Verified: pool
  drains → `switch-night` fires.
- **Phantom doors (12 for 6 corridors)** — `A.Count == L.Count` in
  `BuildDoors` was always true, adding a midpoint door *as well as* the
  40 m anchor for every corridor. Squads split across fake posts, coverage
  stayed 0. Fix: explicit `added` flag; verified `squad doors: 6` matches
  the unique ground lines in `botpack/*.json`.
- **Silent night-call** — `DayNightCycle.SwitchToNight()` no-ops unless the
  game considers the day ready; `Nighthorn.instance` is null on several
  scenes. Fix: horn fallback via `FindObjectsOfType<Nighthorn>()` then a
  name-scan over `BuildingInteractor`s (15 s rescan), budget-expiry forces
  the call regardless of `CanSwitch`.
- **Replay drift on memory fields** — `m.DayStartAt`/`m.LastSquadAt` aren't
  in `ticks.jsonl`, so exact replay can't reproduce memory-timing decisions.
  Fix: `--tol N` allows bounded drift ticks; new fields are added to
  `SnapshotData.ToJson`/`Parse` in lockstep so future fields stay replayable.

## 6. Learning-stack quality gates

| Check | Catches |
|---|---|
| `shadow-gate` | `NetPolicy.*` called anywhere but `Shadow()`/status — the neural policy is advisory until promoted |
| `coach-io` | blocking web calls in `Coach.cs` (must stay on background threads — `WebRequest.Create` + `Thread`) |
| `wired` | `Memory.*`/`Policy.*` absent from `Bot.cs` — dead learning layer |
| `stack` | missing `Policy.cs`/`Memory.cs`/`NetPolicy.cs`/`Overlay.cs`/`Coach.cs` |
| `overlay` | F1 toggle removed from `Overlay.Update` |

Promotion rule: the neural policy graduates from shadow to active only
after the in-log agreement ratio (`[net] shadow: N agree / M disagree`)
holds >70 % over a full session AND the replay + live outcome metrics
(`metrics()` → grades) don't regress. Keep `Policy` (tabular) as the
fallback whenever the net is disagreeing.

## 5. Maintenance

- Regenerate `decompiled/` with `tools\decompile.ps1` after game updates;
  re-verify API names (`nnConstraint` get-only, `AstarPath` global namespace
  — both surprised us this round).
- `bot-log.jsonl` is append-only, ~10 MB/hr — rotate freely.
- Keep `AUTOPILOT.md` "Verified live" honest: update counts/dates with real
  evidence after each significant change; never claim from compile alone.
- Two-mode contract: docs/tests must name which mode (`Legit` vs bundle) a
  behavior applies to — they differ meaningfully.
