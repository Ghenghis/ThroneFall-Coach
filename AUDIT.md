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
