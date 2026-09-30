# Coach UI Handoff — rebuild spec

Server: `tools/coach-server.py` — single-file Python HTTP server on `127.0.0.1:8099`.
The HTML is one embedded string `PAGE = r"""..."""` inside the file.
Restart command: `python -u tools/coach-server.py --port 8099` (cwd = Trainer root).

## Endpoints (all real, keep)

| Endpoint | Payload |
|---|---|
| `GET /` | the page |
| `GET /audit` | **the live truth** — see schema below |
| `GET /state` | legacy tick digest (mode/gold/ally/doors) |
| `GET /live.png` | current game frame (plugin writes every ~2 s) |
| `GET /live.json` | `{"ts": <mtime>}` — poll this, only reload img when ts changes |
| `GET /metrics` | grades, learning stats, weaknesses, run curve |
| `GET /history` | chatlog tail `[{role,text,t}]` |
| `GET /playbook` | `{"raw": strategy markdown}` |
| `GET /run?name=<dir>` | last 12 ticks of a run `[{t,mode,ally,drc,drn,gold}]` |
| `POST /chat` | `{message, image?}` → `{reply, cmd?}` (LM Studio @ 1234) |
| `POST /regen` | `{}` → MiniMax rewrites scene playbook |

## `/audit` schema — the single source of truth

Written by the plugin every ~3 s to `agent/audit.json`; the server adds
`alerts`, `age_s`, `mm_note`. Poll this once per second and paint
everything from it — **do not** give panels their own data paths.

```json
{
  "scene": "Durststein", "t": 1125, "mode": "SpendGold", "mode_since": 9,
  "gold": 531, "ally": 8, "free": 5, "foes": 47, "night": false,
  "wave": 2, "wave_total": 12, "doors_cov": 0, "doors": 6,
  "red": false, "breaches": 0, "bld": 10, "cur_build": "PalisadeWall",
  "open_order": ["military", "tower"],
  "cat_built": {"income": 2, "wall": 1},
  "door_units": [3, 0, 2, 0, 0, 4],
  "door_lines": ["Front Road", "Left Front", ...],
  "checklist": [{"n": "income:starter_farm - ...", "done": true}, ...],
  "alerts": [{"sev": "crit|warn|info", "msg": "..."}],
  "age_s": 1.2,
  "mm_note": "applied {\"army_target\":45 ...}"
}
```

## What the user demands (verbatim requirements)

1. Real-time: the page must reflect the game *every second* — visible
   timestamps + `age_s` staleness badge so old data can't masquerade.
2. Truth/proof: every number traces to `audit.json` or run ticks —
   no decorative aggregates without their inputs shown.
3. Interactive: hideable/resizable sidebar + right drawer, expandable
   run rows, growing/lockable composer, voice with 3 s auto-send window.
4. MiniMax watch must be visibly *working* — applied/rejected stamps
   with timestamps, not silent logs.
5. BOT ORDERED → automatic VERIFIED follow-up showing post-command state.
6. Live view must not flicker — only repaint on new frame mtime.

## Known history (don't reintroduce these bugs)

- `do_POST` once ended up nested inside `metrics()` → all POSTs 501.
- `live.png` served mid-plugin-write → broken img. Cache last good bytes.
- Run dirs named `*-unknown` are `_LevelSelect` transitions — name them
  from the tick's `scene` field and mark `<20 ticks` as `transit`,
  excluded from grade math.
- `army_target` is a **floor** (max with formula) — verifying "applied"
  by comparing the number is wrong; check the game log's
  `[coach] user-cmd ->` line instead.

## Data files (plugin side)

- `agent/audit.json` — live state (new, every 3 s)
- `agent/coach-commands.json` — command intake (plugin polls ~4 s)
- `agent/mmwatch.jsonl` — MiniMax steering log
- `agent/chatlog.jsonl` — chat history
- `agent/live.png` — game frame (~2 s)
- `agent/runs/<ts>-<scene>/ticks.jsonl|events.jsonl` — run telemetry
- `agent/botpack/strategy_<scene>.json` — playbook per scene
