# Efficiency, waste and "max everything"

The bot is judged on one question: **what fraction of its time produced something?**
This document records the measured baseline, the scoring system that now runs
inside the bot, the 12-agent audit findings that drove the v2 changes, and how
to verify each claim.

## 1. Measured baseline (before v2)

Produced by `tools/efficiency-report.py` over `agent/runs/*` (196 analyzable
runs of 501, 36.0 h of in-match time; raw JSON in `dist/efficiency-baseline.json`).

| Metric | Value |
|---|---|
| Match time analyzed | 36.0 h (day 22.8 h / night 12.8 h) |
| Productive time | 23.5 h (65%) |
| **Daytime wasted** | **11.9 h (52% of daytime)** |
| Daytime with >500 gold sitting unspent | 16.3 h |
| Completed builds / payments / gates opened | 750 / 3144 / 0 |
| Mode share | SpendGold 45%, HoldCastle 23%, Engage 10%, Idle 10%, PositionArmy 7% |

A window is *productive* if it contains a pay / build / gate / squad / army
event, or is a night with foes engaged. It is *waste* if it is daytime with none
of those. Caveats: gold-grant runs inflate "gold idle"; escort-only walking is
not in the productive list (slight over-count of waste).

## 2. Root causes found by the 12 audit agents

| Agent | Finding (verified against code/data) |
|---|---|
| A1 waste forensics | ~55% of waste = cross-map slot walks (96-161 m targets); priority bonuses (5000+) dwarfed the proximity term (<=480). Stuck/unstick loops ~20-30%. |
| A2 gold idle | Gated slots (activator level too low) are skipped, but nothing promoted the *activator* (Castle Center) itself, so whole days starved. |
| A3 upgrades | Built, upgradable slots are skipped when their ROOT (castle) is too low; `OpenBuildOrder` counts categories once and caps at 3, so satisfied categories never get revisited. |
| A4 spatial | 14,068 stuck-family events; hero pinned 40+ s at one cell; detours were snapped by `GetNearest` back onto the same chokepoint; the obstacle itself was never remembered. |
| A5 troops | Troops come only from fixed squads attached to built/upgraded military slots; second Barracks locked behind Castle Center lvl 2, which was never upgraded. The +8000 pin starved military. |
| A6 doors | "Doors" = `Gate Wide Variant` build slots (buildingName "Wall"), 5 gated on Castle lvl 2, 3 on a Wall slot; `GateOpener` opens meshes automatically. Zero `CutOpenPathInteractor` pads exist on Durststein. |
| A7 pro play | Pros: economy-first days 1-2, castle lvl 2 rush, call night right after spending, 20+ troops by mid-map. Bot burned 150-300 s/day walking. |
| A8 reward | Formula below. |
| A9 day/night | Day never ends on its own; night ends when enemies are dead; dawn pays income automatically; no early-call bonus. Optimal: spend, then call night immediately. |
| A10 coach | All coach fields are consumed; latency/tokens are not logged; digest lacked efficiency, idle time, slot counts. |
| A11 economy | Income rank: Castle -> Mines -> Houses -> Mill -> Fields. Scorer used raw income delta, not income per gold. |
| A12 review | choice timeout never matured, aim-flap lock could be permanent, gate hold never released, gate approach could starve builds, `parkedAt` leak. |

## 3. What v2 changed (all in `src/`)

| Change | File |
|---|---|
| `Efficiency` score (below) + audit/digest export + coach beat when collapsed | `Efficiency.cs`, `Bot.cs`, `BotPerception.cs` |
| Enabler-first: activators of gated slots and roots of root-gated upgrades get +7000 | `BotPerception.cs` |
| Tiering: enabler 7000 > army-short military 6500 > playbook pin 5000 (7500 after 2 non-defense builds) | `BotPerception.cs` |
| Nearest-first: +8 pts/m up to 60 m, -25 pts/m beyond 20 m | `BotPerception.cs` |
| ROI income term (income per gold) | `BotPerception.cs` |
| `SpatialMemory`: persistent hot-cell grid (`agent/spnav.txt`), 8-heading detour chooser avoiding hot cells, decay per match | `SpatialMemory.cs`, `Bot.cs` |
| `maxed_pct`, `slots_built`, `slots_total`: sum(level)/sum(max) over every build slot | `BotPerception.cs` |
| Idle-night-call 30 s -> 12 s; breach door target capped | `BotBrain.cs`, `BotPerception.cs` |
| Gate release, 30 s gate-approach backoff, choice timeout fix, aim-flap window fix, parkedAt cleanup | `Bot.cs`, `BotBrain.cs`, `Memory.cs` |

## 4. The efficiency score

`raw` decays with an 8 s half-life; `score = 100 * raw / (raw + 4)`.

Adds to `raw`: gold spent (0.5 per gold, max 10 per tick), `build-done` +8,
`gate-open` +6, each new ally +0.6, each newly covered door +4.

Drains `raw` (per second, daytime only unless noted): unspent gold with buildable
slots and no hold 0.35 x min(1, gold/50); `Idle` mode 0.8; pacing >8 m in 5 s
with no progress 0.25; mode flapping (>3 changes/10 s, any time) 0.5; stuck
strike -3, stuck-spam anomaly -6 (instant).

Tiers: >=60 normal, 40-60 hungry, <40 desperate. Desperate disables the build
commit latch and (after 20 s with no progress) calls the coach immediately
(`coach-beat:eff`, 60 s cooldown).

Exported in `audit.json`: `eff`, `eff_raw`, `spend_r`, `eff_drain`, `waste_s`,
`since_prog`, `hot_cells`, `maxed_pct`, `slots_built`, `slots_total`.

## 5. Verification

1. `python tools/efficiency-report.py --last 10` - compare waste %, gold-idle hours and builds against section 1.
2. Live: read `agent/audit.json` - `eff` should sit high during building, `maxed_pct` should climb every day, `hot_cells` should grow only where the hero actually pinned.
3. Events to grep in `runs/*/events.jsonl`: `build-done`, `gate-open`, `gate-backoff`, `door-park`, `coach-beat:eff`, `aim-flap-blocked`.

## 6. Known limits

- The bot has no vision; anything that exists only on screen must be reported by a human.
- `Efficiency` weights are design constants, not fitted; back-test them with the report script before tuning.
- Gold-grant runs distort economy statistics; set `Economy.GoldGrant = 0` to measure real income.

## 7. Task-level system (see STANDARD.md)
Per-task ledger, verification loop, MiniMax observer and dashboard are documented in STANDARD.md; verify with `python tools/check-efficiency.py`.

