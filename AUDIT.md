# Component audit — corrections ledger

Legend: ✅ fixed+deployed · 🔧 fixed, not yet proven live · 🔴 open · 📋 open (lower priority)

## Fixes shipped this session (verified at build/deploy)

| # | Bug | Fix | Status |
|---|---|---|---|
| 1 | `/chat` returned 501 — `do_POST` nested inside `metrics()` | moved back into handler class | ✅ verified 200 |
| 2 | Choice-frame Escape-closed mid-coroutine → upgrade refunds | `ChoiceCoroutineRunning` guard + `Apply()` confirm | 🔧 deployed |
| 3 | Held-build dropped during `waitChoice` (CanBeInteractedWith false → skip) → hold released, fill refunded | held-match hoisted before interactable filter | 🔧 deployed |
| 4 | Playbook never won the pick (harvest +1000 vs playbook +150) | next open category +1200 when funded — playbook is the default policy | 🔧 deployed |
| 5 | Ungated horn path rang night at t=13 (ally=0) | `readyForNight` gate | 🔧 deployed |
| 6 | Ungated switch-night fallback fired at t=0 | same gate | � deployed |
| 7 | `DayStartAt` stale on same-scene retry → budget instantly "expired" → instant night | wave-rollover `PrevWave` + `DayStartAt<=0` resets | 🔧 deployed |
| 8 | **`Coach.Apply` wiped all fields on partial patches** (`Num()=0` for missing keys — a `{"build_focus":"military"}` deleted the entire army plan — THE "commands don't work" bug) | present-keys-only `TryNum`/`TryStr` | 🔧 deployed |
| 9 | Coach overrides persisted across matches | `Coach.ResetRun()` on `BeginRun` | 🔧 deployed |
| 10 | `MarkDoorClaim` stamped before posting → 0-unit posts hid uncovered doors 25 s | claim only when `posted > 0` | 🔧 deployed |
| 11 | Escorts walking past corridors inflated `DoorsCovered` → fake night-readiness | coverage counts only `HoldPosition`/home-posted units | 🔧 deployed |
| 12 | HeroDead corpse ran the stuck watchdog → teleport attempts + warn spam | watchdog early-return when `s.HeroDead` | 🔧 deployed |
| 13 | MiniMax replies missing `content` → silent `'content'` KeyError loop | reasoning fallback + real error text | ✅ verified |
| 14 | `live.png` served mid-plugin-write → broken img glyphs | last-good-frame cache + `/live.json` mtime | ✅ verified |
| 15 | Run dirs `*-unknown` polluted grades (level-select transitions) | scene names from ticks, transit excluded | ✅ verified |
| 16 | MiniMax failures silent | `[mm-watch ERROR]` + `NOT APPLIED`/`BROKEN` mirror to chat | ✅ verified |
| 17 | No link-failure surfacing | `/health` + LINK DOWN/UP chat entries + red banner | ✅ verified |
| 18 | No command round-trip proof | `/ping` endpoint + PING button (verified `ok:true`) | ✅ verified |
| 19 | Steering stalled forever after one MiniMax error (`last_sig` set pre-call) | commit sig only after successful reply | 🔧 deployed |
| 20 | Failed-apply patch deduped forever | `last_patch` reset when `applied=false` | 🔧 deployed |
| 21 | Torn writes: CMDFILE/chatlog concurrent | `write_cmd` + `append_log` locks | 🔧 deployed |
| 22 | `/mmwatch` + `/history` crash on torn jsonl line | guarded `json.loads` | 🔧 deployed |
| 23 | `/run` path traversal + `Access-Control-Allow-Origin: *` | `Path(name).name` + localhost-only CORS | 🔧 deployed |
| 24 | Page froze on missing audit (silent stale UI) | OFFLINE state paints | 🔧 deployed |
| 25 | `mmchip` written by two pollers (flicker) + `mm_note` never populated | single owner + `/audit` serves last steer | 🔧 deployed |

## Open items from the audits

| # | Item | Where | Priority |
|---|---|---|---|
| 26 | `Coach.ReserveSize`/`Strat.Reserve` written but never consumed | Coach.cs:171 / BotPerception.cs:414 | 📋 wire into post/escort split or drop |
| 27 | `night_call` parsed server-side only — `Apply()` ignores it | Coach.cs:165 | 📋 map to posture or log "unhandled" |
| 28 | `army_target` applied as floor only — can't lower | BotPerception.cs:1088 | 📋 add `ArmyTargetCap` semantics |
| 29 | Coach worker threads call `Time.unscaledTime` + unsynchronized statics | Coach.cs:154/177 | 📋 move to main thread |
| 30 | audit writer silent outside InMatch (stale mode shown) | Bot.cs:367 | 📋 write `mode:"ui"` when !Valid |
| 31 | `Strat.BuildOrder`/`CatBuilt` not cleared on missing playbook | BotPerception.cs:411 | 📋 clear on early return |
| 32 | `Memory.Park` permanent, unbounded → can brick every slot | Memory.cs:45 | 🔴 cap + expiry |
| 33 | `NetPolicy.Shadow` argmax can index OOB → per-tick crash | NetPolicy.cs:103 | 🔴 bounds check |
| 34 | arrived-but-failing watchdog blind spot (coin/horn in range but failing) | Bot.cs:585 | 🔴 soft-strike timer |
| 35 | legit-mode hard-stuck teleports (violates legit promise) | Bot.cs:611 | 🔴 gate behind !Legit |
| 36 | `engageTarget` set when `Pursue==0` | Bot.cs:440 | 📋 strict-null |
| 37 | Policy: pendingReward dropped at MatchEnd; traj leaks on abandoned runs | Policy.cs:115 | 📋 |
| 38 | Log spam: 4 Hz tick JSONL + 1 Hz hold-diag + unbounded strikes | Bot.cs | 📋 rate-limit |
| 39 | Overlay OnGUI no try/catch; StrategyText file IO on GUI thread | Overlay.cs | � |
| 40 | JSON writes non-atomic (audit/state/policy/netstats/mishaps) | multiple | 📋 tmp+move |
| 41 | `doorFoes` indexed before `BuildDoors` on scene change | BotPerception.cs:943 | 📋 reorder |
| 42 | `s.FreeUnits` counts escorts → squad posting starved | BotPerception.cs:1032 | 🔴 exclude `FollowingPlayer` |
| 43 | "army producing?" sanity: military built>60 s but AllyCount==0 → flag | new | 📋 anomaly event |
| 44 | verify.ps1 doesn't exercise e2e chain | tools/ | 📋 merge e2e-audit.ps1 |

## Evidence summary (live-verified today)

- `user-cmd` round-trip: write → `[coach] user-cmd ->` in LogOutput.log ≤ 8 s ✅
- Builds completing: `playbook: built 'Castle Center'`, `'Defense Tower'`, `'Wall'`, `'Gold Mine'` ✅
- Failure pattern that broke runs: `switch-night` at t=0 (ally=0 → wipe) — root cause chain: ungated paths + stale DayStartAt + partial-patch wipe ✅ fixed
- 14/15 e2e checks passing (`tools/e2e-audit.ps1`); 15th fails only because newest run predates the fix
