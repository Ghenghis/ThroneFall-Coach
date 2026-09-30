# Component audit — corrections ledger

Legend: ✅ fixed+verified · 🔧 fixed, deployed, pending runtime proof · 🔴 open · 📋 lower priority

## Round 1+2 shipped (`7d598e2` + audit-round commit)

| # | Bug | Fix | Status |
|---|---|---|---|
| 1 | `/chat` 501 (nested handler) | moved back into handler | ✅ 200 |
| 2 | Choice-frame Escape-cancel → refunds | `Apply()` confirm + coroutine guard | 🔧 |
| 3 | Held-build dropped during waitChoice | held-match before interactable filter | 🔧 |
| 4 | Playbook never won (harvest +1000) | next open category +1200 when funded | 🔧 |
| 5 | Ungated horn path → t=13 night | `readyForNight` gate | ✅ run 030158Z day phase |
| 6 | Ungated switch-night → t=0 night | same gate | ✅ |
| 7 | Stale `DayStartAt` on retry | wave-rollover + `<=0` resets | ✅ |
| 8 | **`Coach.Apply` partial-patch wipe** — THE compliance bug | present-keys-only | 🔧 |
| 9 | Overrides leaked across matches | `ResetRun()` on `BeginRun` | 🔧 |
| 10 | `MarkDoorClaim` before posting | claim only `posted>0` | 🔧 |
| 11 | Escorts counted as manned | coverage needs `HoldPosition`/home | 🔧 |
| 12 | Dead hero ran watchdog | `HeroDead` early-return | 🔧 |
| 13 | MiniMax `'content'` silent loop | fallback + error text | ✅ |
| 14 | Torn `live.png` | last-good cache | ✅ |
| 15 | `*-unknown` run dirs pollute grades | scene names from ticks | ✅ |
| 16 | MiniMax failures silent | `[mm-watch ERROR]` chat mirror | ✅ |
| 17 | No link-failure surfacing | `/health` + LINK DOWN/UP | ✅ live-proven |
| 18 | No round-trip proof | `/ping` + PING button | ✅ |
| 19 | `last_sig` stalls steering | commit only after success | 🔧 |
| 20 | Failed-apply deduped forever | `last_patch` reset | 🔧 |
| 21 | Torn cmd/chat writes | locks + `os.replace` | 🔧 |
| 22 | mmwatch/history crash | guarded json | 🔧 |
| 23 | `/run` traversal + open CORS | basename + localhost | 🔧 |
| 24 | Stale UI on dead audit | OFFLINE paint | 🔧 |
| 25 | mmchip dual-owner | healthCheck only | 🔧 |

## Round 3 shipped (this session, commit after `7d598e2`)

| # | Bug | Fix | Status |
|---|---|---|---|
| 26 | `ReserveSize` parsed but unconsumed | caps squad posting (`AllyCount-reserve`) | 🔧 |
| 27 | `night_call` ignored game-side | parsed → `NightCallRequested` (advisory, CanSwitch-gated) | 🔧 |
| 28 | `army_target` floor-only | now a SET (lowering works) | � |
| 29 | Coach worker touched `Time.unscaledTime` | `callNow` captured main-thread; `volatile Busy` | 🔧 |
| 30 | audit stale outside InMatch | `WriteAuditStub` ui/menu modes | 🔧 |
| 31 | Playbook state lingered when pack missing | `BuildOrder`/`LineSquad` cleared | 🔧 |
| 32 | `Memory.Park` unbounded | per-scene cap 24 + `Unpark` on build success | � |
| 33 | NetPolicy argmax OOB crash | bounds check | 🔧 |
| 34 | Arrived-but-failing = permanent idle | 20 s soft-stall parks coin/slot aim | 🔧 |
| 35 | **Legit hard-stuck teleported** | detour escalation only — legit contract restored | 🔧 |
| 36 | `engageTarget` non-null when `Pursue==0` | strict-null | 🔧 |
| 37 | `pendingReward` dropped + traj leaked | folded into MatchEnd + `Policy.BeginRun()` | � |
| 38 | Log spam (strikes/hold-diag) | 60-strike per-run cap | � |
| 39 | Overlay OnGUI unguarded | try/catch → self-disable | 🔧 |
| 40 | Non-atomic JSON writes | `Recorder.WriteAtomic` everywhere + server `os.replace` | � |
| 41 | `doorFoes` indexed before `BuildDoors` | reordered — door map first | � |
| 42 | **Escorts counted as free units** | `EscortUnits` field split — squads stop starving | � |
| 43 | No army-production anomaly | D3: military built>90 s & ally=0 → `anomaly:army-starved` | 🔧 |
| 44 | verify.ps1 missing e2e chain | now runs `e2e-audit.ps1` when live | 🔧 |
| 45 | **Instant-night wave-0 loop** (found in live run 031734Z: `switch-night` t=0 → t=16 `night:true`) | `GameState→InMatch` edge resets clock + **45 s absolute floor** on every night path | 🔧 DEPLOYED — verifying now |

## Verified live this session

- `audit.json` now exposes `escort`, `army_target`, `bmil`, `bmil_first`, `mm_note` — `t=364 mode=SpendGold gold=504 ally=4 escort=4`
- `/health` all 4 checks green; MiniMax `applied at 20:17` with full-context prompt
- `order->applied` PASS — `user-cmd` count rose on command write
- mmwatch 12 s stale — watch loop cycling with applied proofs
- Newest run `031734Z` has day phase (SpendGold/CollectCoin ticks) — but **also shows the residual instant-night** that item 45 targets

## Round 4 shipped — 5-agent audit (commits `0fa64f6`…`7e96d52`)

| # | Bug | Fix | Status |
|---|---|---|---|
| 46 | **`bmil=0` chain** — held slot dropped mid-choice; `isWaitingForChoice` counted as finished | `IsInteractorComplete` for stickiness | ✅ choice-pick→confirm chains clean, `hold-release waitChoice=False` only |
| 47 | ResolveUI released hold mid-fill → refund loop | guard keeps `ResolveUI`; `ClearTarget` skipped while `ChoiceCoroutineRunning` | ✅ zero mid-choice releases since |
| 48 | `SlotVisitSince` never reset on pay → 10s abandon → permanent `Memory.Park` | resets on balance change | 🔧 |
| 49 | `holdDoneName` suppressed repeat same-name builds | reset in `ReleaseBuild` + release logging | ✅ `'Defense Tower' cat tower #1..#6` counted |
| 50 | 13 stale `mishaps.json` cells permanently suppressing Durststein builds | wiped; FIFO eviction in `Memory.Park` | 🔧 |
| 51 | Same-scene retry skipped BeginRun (coach/policy/strikes leak) | `GameState→InMatch` edge reset | 🔧 |
| 52 | `CatBuilt`/`milFirstAt` lingered across scenes | reset in `LoadStrategy` | 🔧 |
| 53 | Stale coach worker reply re-stamps post-retry | `runGen` discard | 🔧 |
| 54 | `PolicyTable.Resolved` crash on non-numeric field → dead decide-ticks | try/catch skip | 🔧 |
| 55 | `NetPolicy` OOB bias/empty-logits per-tick crash | bounds + empty guard | 🔧 |
| 56 | `BotBrain` read `Coach` statics (pure-layer break) | `NightCall` via `SnapshotData` | 🔧 |
| 57 | `stuckStrikeTotal` lifetime not per-run | reset per match | 🔧 |
| 58 | Escorts swept into `CommandArmyAll` → follow/hold churn | `FollowingPlayer` skip | ✅ free units real: `esc=8 free=2` split correct |
| 59 | `Strat.Escort` parsed, unconsumed | consumed in `EscortHero` | 🔧 |
| 60 | `manned` count could include escorts | `!FollowingPlayer` gate | 🔧 |
| 61 | `SetEnabled` left `heldBuild` open | `ReleaseBuild()` | 🔧 |
| 62 | `anchors.json`/`live.png` torn writes | `WriteAtomic` | 🔧 |
| 63 | `pmD` null deref in move-diag | guard | 🔧 |
| 64 | `JVal` raw-mode `LastIndexOf` swallowed trailing fields | unescaped-quote scan | 🔧 |
| 65 | Server: `live_state()` torn-line/lock crash killed `/chat`, `/state` | guards | 🔧 |
| 66 | Server: mm-proof false-positive (tail presence ≠ new apply) | before/after `user-cmd` count | 🔧 |
| 67 | Server: `last_sig` committed before parse → dedupe poison | commit after parse | 🔧 |
| 68 | Server: `tick()` froze strip on fetch fail | paints OFFLINE | 🔧 |
| 69 | Server: `pickRun` filtered-index picked wrong run | pick by run id | 🔧 |
| 70 | Server: `..`/`scene` traversal, role `error` vs mapper `err`, undefined renders, dead `.gA` CSS, unescaped weakness/mishap fields | all patched | 🔧 |
| 71 | `open_order` non-first cats (+70) lost to towers (+600) | open[0]=1200, open[1]=600, open[2]=300 | 🔧 military picks now reached (`bn='Archery Range'/'Barracks'`) |
| 72 | Wall-top hero trapped on elevated navmesh (y=13.49) | wrong-layer detect → descend via castle anchor | 🔧 |
| 73 | East-perimeter stand cells snap to wall-top navmesh | `IgnoreStand` → standoff fallback | 🔧 |
| 74 | Navmesh is helper only — players walk freely; unreachable-by-A* ≠ unreachable | 9s direct-steer window before park | 🔧 deployed; pending proof |
| 75 | `After Match Frame` survived 7+ closes → 400s `invalid` loop after every defeat | name-gated `TransitionToLevelSelect` | 🔧 |
| 76 | `invalid`/`hero-door` events spam ~4Hz | identical-note dedupe 1/4s | 🔧 |

## Verified live — round 4 chain evidence

- Run `035106Z-Durststein`: `squad-door:High Back Road` + `squad-door:Left Front Road` — door posting with real free units (escort split works).
- Runs `034640Z`/`035106Z`: `playbook: built` ×N with `hold-release waitChoice=False` only — **the mid-choice refund loop is dead.**
- Run `040328Z`: `nav-path [wrong-layer]` detector live — all east-perimeter goals flagged.
- Run `040937Z`: `income`+`tower` completed ×11 while `open=["wall","gate","military"]` — walls still stall (items 72-74 target this).

## Still open

- FastRespawn not gated under Legit (config-side)
- `/chat` metrics unconditional (chatlog already appended on reply — cosmetic)
- hot-reload chattiness: `switch-night`+`horn` still emit when `CanSwitch=false`? (tick `csw:true` — watch)
- GoldDrip removal — pending army loop proof
- **Wall/gate construction unproven** — open[0]=wall never completes; direct-steer fallback (74) is the active attempt
- `door_units` never >0 in audit even when `squad-door` events fire — coverage metric still unreliable
- `aim` vs `navGoal` desync (line-136 move-diag) — separate from wrong-layer; watch
- `InMatch Pause Frame` opening mid-match — why does pause trigger?
- Policy-net 98% disagree — shadow only, no action yet
- MM `army_target` oscillation 12→80 between calls — advisor stability
## Verified live - round 5 chain evidence (runs 044014Z..060644Z)

- **Interactor-vacuum detector** — dead matches (waves run, interactables never spawn) are now identified and abandoned: `inter-vacuum` events fired; `sawInteractables` requires a real buildable slot or `CatBuilt` entries (coins/allies don't count — dead matches still drop coins).
- **Persisted scene quarantine** — `badscenes.json` holds `["Durststein"]`; LevelScore drops quarantined nodes -1000 so `EnterLevel` rotates to live scenes across restarts. Run `055944Z` proved the full arc: vacuum exit at t=40 -> `_LevelSelect` -> `Nordfels` fresh match with `SpendGold bld=1`.
- **Nordfels healthy run** (`060034Z`): House x3, Tower x2, Field x4 = 9 real builds; `BREACH on door Right Bridge` raised squad target; defeat registered, policy backed reward over 18 decisions.
- **Vacuum false-positive caught** — `052438Z-Nordfels` was killed mid-plan at t=142 by the loose gate (idle stretch after economy). Gate now only arms when the match NEVER had interactables.
- **After Match frame spam killed** — close/re-open flicker reset `frameSeen` every close so the name-gate never escalated. Sticky name tracking (3s window) lets `frame.Apply()` fire. Pending: one more clean defeat->map->retry cycle.
- **Door-anchor stalls parked** — `ParkDoorAnchor` (5 min) added after the endless aim-stall loop on High Back Road / Right Bridge.

## Still open (round 5)

- Wall/gate construction still unproven — east-perimeter geometry stalls `direct-steer` too; catStuck degrade now advances the plan past 4-failure categories.
- `stuck:1-3 -> unstick` loop on Nordfels Right Bridge (movement watchdog, separate from aim-stall).
- No pause-open API found on `UIFrameManager` (Escape path not exposed — vacuum exit still falls back to raw `TransitionToLevelSelect` when no frame is up).
- `door_units` metric, aim/navGoal desync, net-disagree 98%, MM army_target oscillation — unchanged.
- Durststein stays quarantined until its save heals (or `badscenes.json` is cleared manually).

## Round 6 — 7-agent parallel audit, commit 13f2ee1

7 explore agents swept every src file + tools + live telemetry. ~60 defects
confirmed and fixed this round (build green, deployed, hash-verified,
plugin-load line confirmed in log).

| Area | Headline fix | Status |
|---|---|---|
| Bot.cs | Legit Engage steered at 4 Hz stale pos — now live transform | 🔧 |
| Bot.cs | `StuckStrikes>=3` unreachable (reset precedes check) → detourCount | 🔧 |
| Bot.cs | Double BeginRun per match (edge+scene-change) → dedupe | 🔧 |
| Bot.cs | SetEnabled kept stale vacuum/frame/nav/coin state → full reset | 🔧 |
| Bot.cs | `lastNightTick` stale → next match's day-start hooks skipped | 🔧 |
| Bot.cs | heroAttack never re-validated on weapon swap → 2 s re-resolve | 🔧 |
| Bot.cs | Async nav path overwrote cleared state → navRequestId guard | 🔧 |
| Bot.cs | navWrongLayer survived discarded paths → cleared | 🔧 |
| Bot.cs | postable used AllyCount (posted units counted free) → FreeUnits | 🔧 |
| Bot.cs | aim-stall/build-unreachable not counted → CountStall | 🔧 |
| BotPerception | door parks/breaches/claims leaked across same-count scenes | 🔧 |
| BotPerception | LoadStrategy now clears badStands/BreachCount/HornBi/classCache | 🔧 |
| BotPerception | `"wp"` greedy regex swallowed narrowAt → MatchBracket | 🔧 |
| BotPerception | castleStands parsed but never used → CastleStandPos wired | 🔧 |
| BotPerception | IsInteractorComplete called before field init → EnsureFields | 🔧 |
| BotPerception | PolicyKey written before RedAlert → after | 🔧 |
| BotPerception | CastleThreatDist fallback 0 (looked like foe-on-castle) | 🔧 |
| BotPerception | core-cost `<=0` (cost-3 slot passed with 1 core) | 🔧 |
| BotPerception | door foe/unit attribution: first-in-array → nearest | 🔧 |
| BotBrain | ArmyTarget==0 → night trivially ready with zero army | 🔧 |
| BotBrain | night coin-run preempted RedAlert/breach response | 🔧 |
| BotBrain | visit-abandon parked slot w/o releasing hold | 🔧 |
| Coach.cs | GetHashCode dedupe (collisions/A→B→A drop commands) | 🔧 |
| Coach.cs | Unesc corrupted \\n; Esc missed control chars | 🔧 |
| Coach.cs | Busy wedged forever on thread-start throw; runGen volatile | 🔧 |
| Recorder | WriteAtomic delete+move window → File.Replace | 🔧 |
| Recorder | `running` non-volatile; partial-init dropped all ticks | 🔧 |
| Recorder | phantom "unknown" run dirs; tick dedupe ate half the 2 Hz | 🔧 |
| Memory | parkedWhy grew duplicates forever; badScenes unescaped | 🔧 |
| Policy | NaN reward poisoned row + file; TryParse per-cell | 🔧 |
| NetPolicy | dim-mismatch net loaded garbage; NaN tokens; no reload | 🔧 |
| Plugin | **F2–F5 cheat hotkeys fired in legit mode** | 🔧 |
| Plugin | BotSurvivalCheats default true → false | 🔧 |
| Plugin | FieldInfo NREs; coin-magnet stale-instance restore | 🔧 |
| Overlay | F1 opened BOTH windows + froze player mid-run → F8 | 🔧 |
| tools | verify.ps1 FAIL-regex (always-PASS); e2e config backup; bot-diagnose PS5.1+BOM; coach-chat port reuse; deploy hash+log-verify; gen-fields GameRoot; decompile guards | 🔧 |
| server | reasoning_content steered the bot (rejected options as cmds) | 🔧 |
| server | live_state never checked mtime → steered dead runs | 🔧 |
| server | dedupe sig included ally (never deduped); write_cmd rollback | 🔧 |
| server | unescaped HTML injection across dashboard; metrics() per-req | 🔧 |
| server | no handler exception guard; unbounded Content-Length | 🔧 |

## Live status (post-deploy)

- Nordfels relaunch t≈156: hero mobile (ReturnHome→Idle), no pin-loop,
  `hero-door:Forest` gapfill worked — he walked the corridor and returned.
- Pending: military production timing (ally=0 through t=156 — the Nordfels
  playbook defers military until 2 mines; checklist item still open),
  door_units telemetry, after-match→map→retry proof on THIS build.

## Round 7 — root causes found by live slot-state diagnostics

Four NEW root causes surfaced after round 6 (each proven by a log dump,
not inference):

| # | Finding | Fix |
|---|---------|-----|
| R7-1 | `ParkDoorAnchor(Vector3)` matched the FIRST anchor within 20 m — Forest's stall parked `Spawn` (anchors cluster near Nordfels gate ring), so Forest re-picked forever | `Snapshot.UncoveredDoorIdx` carried through `SnapshotData`; `ParkDoorIdx(int)` parks exactly that index; `ParkDoorAnchor` kept as fallback |
| R7-2 | Hero gap-fill aimed at the door ANCHOR (~55 m out on the corridor waypoint tip, off the walkable mesh) → every anchor parked as unreachable | `BotBrain` aims 14 m INSIDE the corridor mouth (anchor pulled toward castle) — the hero's guard post, not the spawn tip |
| R7-3 | The aim-stall parked `PositionArmy` doors even when the hero had ARRIVED and was holding correctly — a reached guard post read as a stall | PositionArmy excluded from arrive-stall; unreachable door aims still park via the hard-stuck path (`detourCount>=3` → `ParkDoorIdx`) |
| R7-4 | **`isActiveAndEnabled` filtered out every deactivated build pad** — Nordfels slots report `act=False, can=True` (buildable but marker GameObject off). `bld=0` on 406 day ticks; Barracks/Archery/walls never appeared in `bn` — the `ally=0` root cause | Filter dropped; `CanBeInteractedWith` is the game's own predicate |
| R7-5 | `BuildDone` only ran inside the 1 Hz hold-diag while held — a choice-resolved slot completes at the release instant, so `cat_built.military` stayed 0 and the playbook sat on "military" forever | `ReleaseBuild` now calls `IsInteractorComplete` before dropping the reference and counts the completion there |

Round-7 live proof (run 20260930T073624Z+): Barracks appeared in `bn`
(×7), `cat_built` gained `military:1` at t≈55, walls built ×3 (first ever
on Nordfels — they were the same `act=False` victim). Residual: `ally=0`
post-build → `army-starved` anomaly → respawner-dump instrumentation
deployed to identify the unit-production gap (build vs produce split).

## Still open (round 6+7)

- Barracks builds but produces no units — `UnitRespawnerForBuildings`
  dump inbound to see whether `units[]` is empty/disabled or the building
  needs a separate recruit hold
- `door_units` audit metric vs `squad-door` events disagreement
- aim/navGoal desync; mid-match Pause frame origin
- Policy-net 98% disagree — shadow only
- MM army_target oscillation
- GoldDrip removal — pending army-loop proof
- write_cmd queue/merge (overwrite-clobber window) — deferred: needs a
  command-queue contract with the plugin, not a hotfix

## Round 8 — 9-agent fleet + live-evidence root cause (2026-06-30)

Live evidence (runs 040714Z–073624Z window): hero at y=5.9 pinned on the
rock wall with `aim=(0.87,0.00,-46.64)` — every brain aim was **flattened to
y=0**, so A* projected every target onto the ground navmesh, every path was
`wrong-layer`, the pocket-park poisoned 19 cells (Neuland), SpendGold
starved to zero candidates, and the bot sat Idle 135+ s with 522 gold and
`open_order=["military","wall","military"]`. Allies never spawned because
military structures never reached.

9-agent fleet audited every subsystem; ~65 fixes shipped, then a 3-agent
verification pass found and fixed 6 residual regressions:

| # | Fix | Evidence |
|---|-----|----------|
| B1 | `AimY` restores target height by mode/context (nearest build/stand/castle/door within 6 m flat) instead of `y=0` | src/Bot.cs:641,1135 |
| B2 | `recordedScene = s.SceneName` at the InMatch edge + full per-match reset set (mem/arriveSince/detour/lastWatchDist/holdDoneName/prevRuleFires) — no double BeginRun | Bot.cs:384–405 |
| B3 | `Memory.ForgiveParks(scene)` on new match — wrong-layer/transient parks retry next match; mishaps.json purged of 18 wrong-layer Neuland cells (backup `.bak`) | Memory.cs:143 |
| B4 | Watchdog ignores `PlayerFrozen` heroes (menu/choice); `detourCount>=4` catch-all releases any stuck aim; SpendGold park excludes castle/horn slots (vital) | Bot.cs:829,1075,1042 |
| B5 | Choice-coroutine wedge escape: 20 s `choiceSince` watchdog drops the gate | Bot.cs:1670–1712 |
| B6 | Detour `navSteerArrive=0.5` re-clamped after last-wp branch | Bot.cs:2003 |
| P1 | Inactive-slot skip gated: only `StartDeactivated` AND activator-under-level | Perception:~1830 |
| P2 | `ParseSlotPack` bounded to `"slots"` section + per-record; stands search capped at next `"pos"` (re-audit caught the leftover bleed) | ~780 |
| P3 | `MatchBracket` skips string literals; horn reflection walks base types | ~895,~1618 |
| P4 | `BuildDone` unparks the full 3×3 pocket (9 cells), parked doors count covered, `doors_claimed` separate, `bmil_first` null-not-0, `foes`=live enemies | ~395,~1372,~474 |
| P5 | Checklist named entries (`upgrade:Barracks_T2_day6`) match NAME (suffix-stripped) not category — castle upgrade no longer satisfies a Barracks item | ~509 |
| P6 | `door_distance_m` strategy field now parsed and consumed in `BuildDoors` | ~596,~2260 |
| P7 | held-match mid-choice: `CanBeInteractedWith` checked inside hold (20 m) + `s.BuildCount++` | ~1774 |
| G1 | Brain: build-done `return r` (no same-tick re-hold); releases when mode leaves SpendGold; `ArmyPhase=0` on newMatch; `urgent` takes dist 0; scene-flicker ignored; Perp fallback; orbit-dt clamp; JSON `Esc` on note/scene/bn | BotBrain.cs |
| C1 | `Coach.ResetRun` clears `lastCmdText` — identical-byte retry deadlock fixed; commit-after-Apply; `lastCallAt` post-start; VisionCall gen-dedupe; Esc on models | Coach.cs |
| S1 | Server: `tail_bytes`/`tail_lines` everywhere; latest_run by mtime; `extract_cmd`→`validate_patch`; `clear:true` + zero-as-reset; `wave`/`bld` in sig; audit freshness gate; MiniMax write-fail now sleeps (no token-burn loop); `/order` nonce; metrics wave `"N/M"` parse; `track_activity` shared | coach-server.py |
| E1 | **Legit lock**: `GUI.enabled` gate on all cheat controls while `Bot.Legit`; `Bot.Legit` refreshed per frame (config-manager edits honored); conditional bundle restore; menu unfreeze restores only own freeze; Update try/catch so a throwing cheat can't starve `Bot.Tick`; GoldDrip bypassed in legit | Plugin.cs |
| T1 | Tools: bot-lint PS5.1-safe; gen-fields param order + no-BOM; verify FAIL-grep; deploy checks only new log bytes; decompile exit codes + stale cleanup; Replay fixture path fixed; e2e atomic cmd write + -Directory + per-line try; episodes skips unknown modes; gen-botpack utf-8+mkdir+basename fallback; mm-coach refuse-wrong-scene; train empty guard; _splice marker uniqueness | tools/* |

Deploy: `build-and-deploy.ps1` — hash `990F0EE202A28122` matches src binary.
`python -m py_compile coach-server.py` OK. `dotnet build` 0 errors (only
pre-existing NNConstraint-obsolete warnings).

## Verification pass (round 8 residual defects — all fixed above)

- detour arrive-radius overwrite (Bot.cs:2003)
- wedged choice-coroutine gated Tick forever (choiceSince watchdog)
- castle slot parkable via SpendGold branch (vital exclusion)
- stands bleed across slot records (next-`"pos"` bound)
- server write-fail hot loop (sleep added)
- `"wave"` string broke `_metrics` (split-parse)
- `/order` duplicate-content dedupe (nonce)

## Pending live proof (deployed, awaiting next session run)

- `aim.y` ≈ hero y on elevated scenes (no more `0.00` aims)
- `ally > 0` on Nordfels after barracks completes (bmil≥1 already proven)
- `door_units` nonzero, `doors_claimed` > 0, checklist `done` accuracy
- after-match → map → retry on THIS build; netpolicy mtime reload
- Endless-day/pass-frame regressions under the frozen-watchdog guard
