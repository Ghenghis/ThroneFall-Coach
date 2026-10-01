# GPS: wall-gate awareness for the autopilot

Status 2026-10-01 ~04:00. Tags: [MEASURED] read from recorded runs / logs, [DECOMPILED] read in `decompiled/` or the A* library, [TESTED] unit tests, [NOT VERIFIED] not yet seen live.

## 1. The problem (evidence)

* Live run `20261001T101018Z-Frostsee` [MEASURED, `agent/runs/<run>/ticks.jsonl`]: the hero stayed inside a ~25 x 13 m walled courtyard in the north-west from t ~ 237 s to t ~ 980 s (12 minutes), spending nothing (gold 4879 -> 4862) while the bot cycled `stuck:1 -> quick-sidestep -> stuck:2 -> pin-park` every ~5 s (102 pin-parks in that run).
* Every path request from there logged `[bot] nav-path error -> (...) (Couldn't find a node close to the end point)` [MEASURED, BepInEx/LogOutput.log]. `NavSteerPoint` then returns the goal itself, i.e. the hero walks straight at it and pins against the wall (`move-diag ... wpCount=-1 wp=[-] steer=aim`).
* The hero left at t ~ 980 s by walking south at x ~ -61 within 4-5 m of `Gate Wide Variant (3)` at (-64.8,-61.3), 12.6 m from where it had stood [MEASURED: positions in ticks.jsonl; slot position in `agent/slots/Frostsee.json`].
* Over 13 Frostsee runs the hero was pinned for 2,723 s = 37 % of its travel time [MEASURED, `python tools/pin-hotspots.py --scene Frostsee`]; the top hotspots lie next to `Wall Segment` slots, i.e. on the bot's own walls. Durststein: 17 % pinned over 167 runs; its biggest hotspot (about a third of the pinned time) is at the Blacksmith slot and is a different problem (section 6).
* The bot had no concept of wall gates: its "gate" code concerns pay-to-open path pads (`CutOpenPathInteractor`) and enemy spawn doors [MEASURED: `grep -n GateOpener src/*.cs` finds only a comment].

## 2. How the game works (sources)

* `GateOpener` [DECOMPILED, `decompiled/GateOpener.cs`]: opens (doors rotate / bars sink) when a `Player` or a `PlayerUnit` is within `openDistance` (default 5 m); checks every 0.33 s; closes when nobody is near. The king only has to walk up to the gate.
* Pathfinder = A* Pathfinding Project 5.4 [DECOMPILED, `AstarPathfindingProject.dll`]. `GraphNode.Area` is the connected-component label; `HierarchicalGraph` re-assigns the labels from scratch (`areas[i] = 0`, flood fill in node-index order) whenever it recalculates. **Labels of different frames must not be compared.** An end point that cannot be reached from the start gives "Couldn't find a node close to the end point".

## 3. Design (`src/Gates.cs`, `src/GatePlanner.cs`)

1. **Trigger:** only a real path failure for the current goal (`Bot` path callback -> `Gates.NoteNavFail`). Not the area labels.
2. **Portals:** every active `GateOpener`; 16 ground samples on two rings (2.2 m and 3.6 m) around it, each labelled with its area in the same frame.
3. **Plan:** `GatePlanner.Plan` (BFS over areas, gates are edges, labels of ONE frame) picks the first gate on the shortest chain to the goal's area; if that finds nothing, `PlanHeuristic` (label-free: cheapest gate on the way, standing room on two opposite sides) is tried, at most twice per goal cluster and minute and only while the hero is pinned.
4. **Execute:** walk to the near side (normal A*), push straight through (`Direct` leg: the pathfinder still sees the gate as closed), progress judged by geometry (distance along the gate axis). Timeouts 22 s / 5 s; three pins or a timeout put the gate on a 90 s cool-down.
5. **Interplay:** while a gate leg is active the stuck handler does not count strikes or park targets (`Gates.OnPinned`); after a crossing the build ignores and the memory parks made during the enclosure are forgiven (build #3).

## 4. Verification so far

* [TESTED] `dotnet run --project tests/GatePlanner.Tests`: 19 of 19 (single gate, two gates, two-hop chain, dead end, failed gates, junction, heuristic cases). `tools/bot-lint.ps1`: 0 FAIL.
* [MEASURED] first deployed build (label trigger) produced ~35 false plans in 3 minutes of a healthy run with 0 path errors: labels are not stable across frames. Replaced by the path-failure trigger (deployed 03:40:52, DLL SHA-256 prefix CCC36318B438D3E0): no false plans and no path errors in its first minutes.
* [NOT VERIFIED] a real `[gps] plan ... crossed` after an enclosure has not been seen yet. Check: `[gps]` lines in LogOutput.log, `gps-*` events (build #3), `python tools/nav-report.py --scene Frostsee --since 20261001T104109Z` against the baseline of 38.4 % pinned (12 Frostsee runs before the fix).

## 5. Limits

* An enclosure with no built gate cannot be left by walking; the bot would have to build a gate slot from inside (not implemented).
* The wall side from which a slot is built is chosen as "nearest stand cell" (`BotPerception.BestStand`); building a wall from the pocket side can seal the hero in [INFERRED from the hotspots, not tested].

## 6. Next

Analyse the Durststein Blacksmith hotspot (hero idles at (-39.8,43) with a target 34 m away, `stuck`/`unstick` events) before touching it — `pin-hotspots.py --scene Durststein` shows cells (-42,42)/(-36,42)/(-30,42) beside the Blacksmith slot hold 2,643 s / 32 % of all Durststein pinned time across 167 runs; the Blacksmith is reachable (`interactor` in range) so this is likely a stand-point/aim bug, not a gate enclosure.

## 7. Verification update (2026-10-01 ~05:00, second agent)

* [TESTED] `dotnet build` 0 errors; `tools/bot-lint.ps1` 0 FAIL; GatePlanner tests 19/19.
* [MEASURED] build #3 deployed (DLL SHA-256 prefix FB472764A3E057ED → later rebuild). Live log shows `[gps] plan #1 (areas) via gate #203888 at (-90.0,-65.9) hops=1` followed by `goal is reachable from here now -> gate plan dropped` — the trigger works; a real `gps-cross` is still [NOT VERIFIED].
* [TESTED] `nav` field added to ticks.jsonl (Gates.Status per tick).
