# Efficiency standard

How the bot is rated, per task and overall. Source of truth for the numbers is
`Bench` in `src/Tasks.cs` (written to `agent/benchmarks.json` at start; mirrored in
`tools/eff_lib.py`; `tools/check-efficiency.py` fails if they drift).

## Provenance of every number

| Constant | Value | Provenance |
|---|---|---|
| Walk speed | 16 m/s | **Measured**: p90 hero speed over 17,477 Durststein ticks (wall-clock; includes game speed-up). |
| Fill time | 4.5 s | **Measured**: median first-pay to build-done over 143 builds (p10 0.5 s, p75 35.6 s, p90 236 s, so heavy-tailed). |
| Baseline useful % | 75.2 | **Measured**: the live tick classifier back-tested (`eff_lib.backtest`) on the 60 runs / 13.3 h before the task tracker. Same rule as live, so directly comparable. (The older 47.7 % = 100 - 52.3 % day waste used a 10 s window rule and is NOT comparable.) |
| Baseline productive % | 65.2 | **Measured**: same runs. |
| Target useful % | 85 | **Estimate** (design goal). |
| Target build efficiency | 60 | **Estimate**. |
| Target score | 80 | **Estimate**. |
| Human reference | 236 gold | **Sourced** (Steam Duststein bonus-mode thread): a gold-optimisation score, not a speed or APM figure. No human speed benchmark exists in public sources; none is claimed. |

## What a "task" is

Every second of live play belongs to exactly one task: a build (per slot), or a
mode span (CollectCoin, Engage, HoldCastle, PositionArmy, Idle, ...).
Spans shorter than 1.5 s are counted as `task_micro` (flapping indicator) and not rated.

Each tick is classified **useful** (progress in the last 3 s, moving on a work mode, or foes engaged at night),
**wasted** (daytime Idle, or standing still with gold and buildable slots) or **neutral** (UI, dead, night with no foes).

| Task type | Efficiency (0-100) |
|---|---|
| build | `min(1, ideal/actual)`; `ideal = start_distance/16 + 4.5 s`. Full value for `ok`, half for `partial` (gold spent, level not raised), 0 for `fail`/`abandoned`. `ok` requires gold spent and the global level sum to rise. |
| other | `100 * useful / (useful + wasted)`; `n/a` if the span was all neutral. |
| day / night report | mean live score, useful %, gold spent, builds, ally delta, level-sum delta. |

## Verification loop

After a `build-done` the tracker waits 2.5 s and requires the level sum to exceed its value 8 s earlier.
If not: `task-miss` event + `tasks.jsonl` record, and parked slots on that scene are forgiven (max once per 60 s)
so the work is retried instead of staying quarantined.

## MiniMax as observer

- Digest (every coach call) carries efficiency, useful %, idle seconds, drain reasons, weak tasks, misses.
- Heartbeat sources: 90 s periodic, idle-watch, stall-watch, score collapse (< 40 and 20 s no progress), and the code-only
  `Tasks.Watch()` filter: 3 failed builds in 90 s, gold >= 50 unspent for 25 s with buildable slots, every 3rd task-miss.
  The LLM is called only on those triggers (the filter itself is LLM-free).
- Each call logs latency (ms), tokens and failures; each applied advice is scored by score-before vs score-60 s-after
  (`coach-fx` records, shown on the dashboard).

## Where it shows

- Dashboard (`tools/coach-server.py`, Audit tab): live score, per-task table, windows (1 h / 16 h / 48 h / all) vs baseline vs goal,
  per-bot-build rows, MiniMax heartbeat panel.
- `python tools/efficiency-compare.py` prints the same table.
- `python tools/check-efficiency.py` verifies the whole pipeline end to end.

## Known limits

- Targets other than the measured ones are estimates; tune only after a back-test.
- `useful` is a proxy; it does not prove each action was the best one, only that time was not obviously wasted.
- Game speed-ups change wall-clock speeds; the 16 m/s figure is wall-clock for this install.

