# Component audit — truth status, not claims

Verified = observed in a live log/telemetry. Broken = known defect.
Unproven = code exists, no live evidence it works.

## Game-side executor (`src/`)

| Component | Status | Evidence |
|---|---|---|
| Hold-to-pay (`InteractionHold` per-frame) | ✅ works | `hold-diag: state=Upgrade started=True` |
| Choice-frame picks | ⚠️ fixed unverified | was closing frame mid-coroutine → upgrade refunds. Fix deployed `08e2dea+` |
| Build executor completes | 🔴 unproven | `CatBuilt` rarely grew; gold sat ~500 for 60+ min |
| Stuck watchdog | ⚠️ partial | `stuck:1..3` + `snap` fire, but hero idles "arrived" at dead targets with zero strikes |
| Squad posting / doors | 🔴 unproven | `doors_cov` pinned 0/6 in every recent run |
| Horn / night call | ⚠️ partial | horn fallback exists; budget-forced night worked once; horn identity still unresolved |
| Defeat→retry loop | ✅ works | `defeat (x8)` → `_LevelSelect` → `Durststein` re-entry observed |
| Coach command intake | ✅ works | `[coach] user-cmd ->` appears in LogOutput.log on write |
| Playbook loader | ✅ parses | `strategy 'Durststein': squad=5 reserve=4 ... order=16` in log |
| Playbook **enforcement** | 🔴 unproven | build order not visibly followed (no cat progression) |
| audit.json writer | ✅ works | verified live: t/wave/ally/pos updating |
| live.png frames | ✅ works | file refreshes ~2 s when game focused |

## Coach server (`tools/coach-server.py`)

| Endpoint | Status | Evidence |
|---|---|---|
| `GET /` page | ✅ 200 | served |
| `POST /chat` | ✅ fixed | was 501 (do_POST nested in metrics) — verified reply |
| `GET /audit` | ✅ real | plugin data + alerts + mm_note |
| `GET /live.png` | ✅ fixed | was serving mid-write frames → cached |
| `GET /live.json` | ✅ new | mtime tag for flicker-free repaint |
| `GET /health` | ✅ new | plugin feed / live frames / local LLM / MiniMax — already caught `'content'` crash |
| `GET /metrics` | ⚠️ fixed | scene names now from ticks; transit runs excluded |
| `GET /run` | ✅ new | last 12 ticks per run |
| `GET /playbook`, `POST /regen` | ✅ works | MiniMax rewrite runs |

## MiniMax watch loop

| Behavior | Status |
|---|---|
| Reads live telemetry | ✅ real state in prompts |
| Strict JSON validation | ✅ rejects out-of-schema |
| Writes coach-commands.json | ✅ file lands |
| Game applies | ✅ `[coach] user-cmd` in log |
| **Bot obeys** | 🔴 commands apply but behavior didn't change (executor bugs) |
| Error surfacing | ✅ fixed — errors + NOT APPLIED now mirror to chat |
| M3 `content` KeyError | ✅ fixed — reasoning fallback + real error text |

## Honest summary

The chain works end to end: MiniMax → file → plugin apply. What failed
was the *last mile*: the executor couldn't complete builds (choice-frame
cancel + dead-aim parking). With the choice-frame fix deployed, the next
live run is the real test — watch `playbook: built` lines and `gold`
actually decreasing.
