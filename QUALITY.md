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
| `tools\bot-lint.ps1` | ungated cheat calls, >4-char log fields, `Time.time` misuse, missing csproj refs, dead enum values, unresolved `s.X` refs | after every `src/` edit; exit code = #FAIL |
| `tools\bot-diagnose.ps1` | live-state defects: hero parked in travel mode, unstick storms, day-never-ends, wave grind, UI churn, cheat leaks vs config, log stall | any time the run looks wrong; `-Lines N` for window size, `-Fix` for config repair |
| `tools\build-and-deploy.ps1` | builds Release, stops the game (DLL locks while running), copies to plugins, relaunches | standard deploy path |
| `dotnet build -c Release` | compile errors | before deploy |

Pre-deploy checklist: `bot-lint` → build → `build-and-deploy` →
`bot-diagnose` ~60 s into the run.

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

## 5. Maintenance

- Regenerate `decompiled/` with `tools\decompile.ps1` after game updates;
  re-verify API names (`nnConstraint` get-only, `AstarPath` global namespace
  — both surprised us this round).
- `bot-log.jsonl` is append-only, ~10 MB/hr — rotate freely.
- Keep `AUTOPILOT.md` "Verified live" honest: update counts/dates with real
  evidence after each significant change; never claim from compile alone.
- Two-mode contract: docs/tests must name which mode (`Legit` vs bundle) a
  behavior applies to — they differ meaningfully.
