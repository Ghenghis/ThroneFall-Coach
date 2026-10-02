# MiniMax engineer - let the incident responder's code tasks become reviewed, gated, reversible patches

`tools/mm_engineer.py` turns the `code_task` actions that MiniMax files in `engineer-queue.jsonl` into **patches that MiniMax writes itself**,
inside an isolated copy of the repo, behind a build + test + lint + safety gate, and only then (on approval, or in opt-in auto mode) into the
live tree and, last, into the running game - with backups, a health check and automatic rollback at every step.

```
 command center (MiniMax)                         <agent>/engineer-queue.jsonl   (append-only, never rewritten)
        | code_task                                      |
        v                                                v
   Engineer.run_task(id)  -- copy repo -->  <agent>/engineer/work/<id>/{base,work}     (the live tree is only READ)
        |  agent loop: MiniMax <-> ls/read/grep/edit/create/build/test/finish   (text JSON, one action per turn)
        |  finish -> gates: build | tests+lint vs BASE | size | safety scan   (a failed gate is fed back, the loop continues)
        v
   status "patched"  +  <agent>/engineer/<id>.diff                                   (unified diff, a/ b/ paths)
        |  Engineer.apply_patch(id)    git apply --check (byte-exact) -> backup -> git apply -> BUILD on the real tree
        |                              build fails -> files restored automatically ("apply-failed"); tree moved -> "conflict"
        v
   status "applied"                                                                  (source changed, game still runs the old DLL)
        |  Engineer.deploy(id, confirm=True)   cooldown -> DLL backup -> build-and-deploy.ps1 -> health check
        v                                       unhealthy -> DLL restored + source reverted ("rolled-back")
   status "deployed"
```

State lives next to the other agent files: the queue is never rewritten, per-task state is the sidecar `<agent>/engineer-status.json`
(`{id: {status, started, finished, steps, tokens, diff_path, gates, summary, error, applied_at, deployed_at, ...}}`).

## 1. Safety model - what MiniMax can and cannot do

| MiniMax **can** | MiniMax **cannot** |
|---|---|
| `ls` / `read` / `grep` files in its **workspace copy** (src, tests, tools, docs, root `*.md`, csproj/sln) | touch the live tree, the game, `Trainer\bin`, the agent dir, `.git` - the run only *reads* the live tree to make the copy |
| `edit` (exact unique text replacement) / `create` text files under `src/ tests/ tools/ docs/` - at most **6 files / 400 changed lines** | run a command, a shell, a script or the network; it only gets the 8 actions below |
| ask the system to `build` and `test` (unit-test projects + python tests + `bot-lint.ps1`) | edit the gates or the deploy path: `tools/bot-lint.ps1`, `tools/build-and-deploy.ps1`, supervisor scripts, `tools/mm_engineer.py`, `tools/engineer-sim.py`, `tests/test_mm_engineer.py`, any `.ps1/.bat/.sh/.cmd/.vbs`, any binary (`.dll .exe ...`) |
| `finish` with a summary (or `no_change`) | touch `.git`, `bin`, `obj`, `decompiled*`, `dist`, `reference`, `desktop`, `node_modules`, `__pycache__`; use `..`, absolute paths, drive letters, `:` streams, reserved names, symlinks/junctions |
| edit `tools/coach-server.py` / `tools/command_center.py` / the modules they import (flagged `touches_server`, needs a server restart) | add cheat/teleport/damage APIs, process spawns, registry, non-localhost network, dynamic loading, ... (static scan, below) |
| | apply its own patch, deploy, restart the game, or change the config - those are `Engineer` methods only a human (UI) or the opt-in auto mode calls |

Paths are normalised (`\` -> `/`), matched case-insensitively and canonicalised to the on-disk casing, so `SRC/Picker.PY` and `src/picker.py` are one file and one diff entry. Non-ASCII characters
(NTFS case folding could alias a protected file, e.g. a dotless i), 8.3 short names (`MM_ENG~1.PY`), and Windows-invalid characters are rejected outright.
Edits keep each file's BOM and per-line CRLF/LF exactly; the model only ever sees `\n`.

**Where a human decides**

* `mode: semi` (default) - the engineer only *prepares* patches. Applying and deploying are explicit approvals in the Live View.
* `mode: auto` - additionally applies a gate-passing patch to the live tree, but never one that touches the coach server, carries scan warnings
  (e.g. a new Harmony patch), or exceeds `auto_apply_max_lines`.
* `auto_deploy: true` (default **false**) - additionally deploys unattended, only for small clean patches (<= 150 changed lines, <= 3 files, touching `src/`, no server files,
  no scan warnings), through the same guarded `deploy()` (confirm flag, cooldown, backup, health check, rollback).

## 2. Statuses

| status | meaning | next |
|---|---|---|
| `queued` | in the queue, not yet worked on (also: a patch that hit a **conflict** goes back here with a `note`) | `run`, `reject` |
| `working` | an agent run is in progress (`status()["current"]` shows step/tokens/elapsed) | - |
| `patched` | gates passed, diff exported to `<id>.diff`, **waiting for approval** | `apply`, `reject`, view diff |
| `applying` | `git apply` + build gate on the real tree in progress | - |
| `applied` | patch is in the live tree and builds; the game still runs the old DLL | `deploy`, `revert` |
| `apply-failed` | the real tree did not build with the patch (or git failed): files were **restored automatically** | `requeue`, `reject` |
| `deploying` | deploy script / health check in progress | - |
| `deployed` | new DLL running and healthy | - |
| `rolled-back` | the health check failed (or the deploy half-ran): DLL restored from backup **and** source reverted | `requeue` |
| `failed` | run ended without a passing finish (`step-limit`, `token-limit`, `wall-timeout`, `model-error`, `protocol`, or a failed re-validation) - partial work is kept as `<id>.failed.diff` | `requeue`, `reject` |
| `no-change` | the model found the defect already fixed / not a code defect (`finish` with `no_change`) | `requeue`, `reject` |
| `rejected` | a human said no (`reject_reason` stored) | `requeue` |

`working`/`applying`/`deploying` left behind by a crashed process are resolved on the next start (`failed` / `apply-failed` / back to `applied`), never retried silently.

## 3. The agent loop

Text JSON, no native tool calling. Each model reply must be **one JSON object**; the parser takes the first balanced `{...}` (tolerates prose, code fences,
`<think>` blocks, raw newlines in strings, trailing commas, `tool`/`args` aliases). An invalid reply gets a corrective message; **3 in a row abort** the run.

| action | what happens |
|---|---|
| `{"action":"ls","path":"src"}` | directory listing with sizes and line counts (build output dirs hidden) |
| `{"action":"read","path":"src/Bot.cs","start":2700,"end":2820}` | numbered lines, **max 220 per call**, lines > 400 chars cut, output capped at ~6 KB with a "continue with start=N" hint, flags tab/space indent and CRLF |
| `{"action":"grep","pattern":"PickNext","glob":"src/*.cs","max":40,"i":true}` | pure-python regex, **max 40 hits, 160 chars per line**; invalid regex falls back to literal; nested quantifiers refused |
| `{"action":"edit","path":..,"old":..,"new":..}` | `old` must occur **exactly once**, otherwise the answer says how many times (and at which lines); a whitespace-only mismatch is diagnosed and the exact text shown; per-edit limits (files / changed lines) enforced |
| `{"action":"create","path":..,"content":..}` | new file only under `src/ tests/ tools/ docs/`; line ending style follows sibling files |
| `{"action":"build"}` / `{"action":"test"}` | runner result; `test` separates **NEW failures** from failures that already exist in the BASE copy |
| `{"action":"finish","summary":..}` | runs the gates; refused with the failure text if one fails; `no_change:true` ends with `no-change` |

**Memory is bounded**: system prompt + task message (which carries one-line summaries of older steps, the running edit log and a `STATE:` line: build/test status of the
current edits) + the **last 6 full exchanges** (14 messages at most). Every observation starts with `[step n/28, k left | tokens | time]`; at 3 steps left it warns.

**Grounding**: the task's `file`/`function` are guesses of an assistant that cannot see the code. Before the first call the engineer searches the real code for them and tells
the model what exists (`file 'src/Bot.cs' does NOT exist; similar: ...`, `symbol 'PickNext': NOT FOUND`, definitions with line numbers, and a keyword heat map of where related
code lives in `src/`). `tools/_recover`, `tools/refpack` and the engineer's own tooling are excluded from that search.

**Limits** (config): `max_steps` 28 (every model call is a step), `max_tokens_total` 400 000, `wall_timeout_s` 840, `max_changed_lines` 400 (added + removed), `max_files` 6.

**System prompt** (see `SYSTEM_PROMPT`): senior C# engineer on a live autopilot; the bot must stay a legit player; smallest change that fixes the **cause** (e.g. target selection
must verify reachability before committing the hero, not a retry); the task's names are guesses - use grep/read; extend a unit test when the logic is pure; never edit
generated/decompiled code; always build then test before finish.

## 4. Gates (all must pass before `patched`)

1. **hygiene** - files changed by test runs (stray new/modified/deleted files) are reverted, so the diff contains exactly the model's edits.
2. **policy** - every changed path re-checked (allowed roots, protected files, forbidden dirs).
3. **limits** - <= `max_files`, <= `max_changed_lines`.
4. **safety scan** of the diff (below).
5. **build** - `dotnet build src/ThronefallTrainer.csproj -c Release --artifacts-path <scratch> -p:OutputPath=<scratch>/out/ -p:GameDir=<game>` in the workspace (never `Trainer\bin`, never `src/obj`).
6. **tests** - the allowlisted C# test projects (`test_projects`: GatePlanner.Tests, ActLogic.Tests, Replay) are built and run, the allowlisted python tests (`python_tests`: test_incidents.py,
   test_command_center.py) are run, then `tools/bot-lint.ps1`. It is an allowlist on purpose: other scripts under `tests/` can have real-world side effects (`tests/test_wgc_real.py` opens windows and
   captures the screen, the `*_e2e`/`test_page_js` tests drive a headless browser) and must never run unasked inside a gate; add them by name (or `"*"`) if you want them.
   Results are compared **by name against the BASE copy**: pre-existing failures are not blamed on the patch, any **new** failing test or new lint FAIL is. The base run happens at most once per
   task and only when something fails. A runner that could not verify (crash, time budget) is never a pass.

**Safety scan rules** (added lines only; an added matching line is neutral only if the same file removes an *identical* line (modulo whitespace) - a move or re-indent - while a changed or merely offset line
counts as new; comments are ignored; `.md`/`.json` are not scanned). The scan also runs **before** every `build`/`test` action, because those execute workspace code (test programs, python tests): a
violating edit is never executed, the model is told to fix it first.

| rule | `.cs` | `.py` | verdict |
|---|---|---|---|
| `process-spawn` | `Process.Start`, `ProcessStartInfo`, `System.Diagnostics.Process`, `Process.GetProcess*/Kill` | `subprocess`, `os.system/popen/exec*/spawn*`, `taskkill` | reject |
| `file-delete` | `File.Delete` / `Directory.Delete` unless **each call visibly targets the agent dir or a tmp file** | `shutil.rmtree`, `os.remove/unlink/rmdir`, `.unlink()` | reject |
| `registry` | `Registry`, `Microsoft.Win32` | | reject |
| `net-nonlocal` | `WebClient/HttpClient/HttpWebRequest/UnityWebRequest/...`, URL literals - only `127.0.0.1`/`localhost` with a visible target is allowed | `urllib.request`, `http.client`, `requests`, URLs | reject |
| `exit` | `Environment.Exit/FailFast`, `Application.Quit` | `os._exit` | reject |
| `dynamic-load` | `Assembly.Load*`, `AppDomain`, `DllImport`, `Reflection.Emit`, `CodeDom`, ... | `ctypes`, `importlib`, `eval`, `exec`, `compile`, `pickle` | reject |
| `cheat-api` | the regexes `tools/bot-lint.ps1` flags (`pm.TeleportTo(`, `heroAttack.Attack()`, `Hp.TakeDamage(`) **read from the lint script**, plus `TeleportTo`, `.Teleport(`, `TakeDamage(`, `Cheats.<flag>` | | reject |
| `msbuild-exec` | csproj/props/targets: `<Exec>`, `<Target>`, `<Import>`, `<PackageReference>`, pre/post-build events, `DownloadFile` | | reject |
| `harmony-patch`, `timescale`, `threads`, `native-memory` | new Harmony patch, `Time.timeScale =`, `new Thread`/`Task.Run`, `unsafe`/`Marshal.Write*` | | **warning** (blocks auto-apply, human review) |
| `tests-weakened` | lines removed/changed in an *existing* file under `tests/` (the baseline comparison cannot see a test that was made to pass by weakening it) | same | **warning** |

## 5. Applying to the live tree

`apply_patch(id)` (status must be `patched`):

1. the diff file's sha256 must still match the one recorded when the gates passed; the diff is **re-parsed, re-checked against the path policy and re-scanned**;
2. `git -c core.autocrlf=false apply --check` in `repo_root` against the **current** tree. The override matters: this machine's system git has `core.autocrlf=true`, which would
   rewrite every patched LF file to CRLF. The diff is generated from raw bytes (CRLF/BOM/no-final-newline preserved), so a byte-exact apply is both correct and minimal.
   If the check fails (somebody else changed those files) -> **`conflict`**: nothing is touched, the task goes back to `queued` with a note; re-running it works against the new tree;
3. backups of every touched file go to `<agent>/engineer/<id>.prev/` (+ manifest with the pre- and post-apply hashes), `git apply`, then the sha256 of every touched file is stored (`post_hashes`).
   If git reports a failure after it already wrote some files (a locked file), everything it wrote is undone from the backups;
4. **build gate on the real tree** into a scratch artifacts dir. If it fails: backups are restored **only for files that still hash to the post-apply hash** (a file somebody changed
   meanwhile is left alone and reported in `restore.skipped`), status `apply-failed`.

`revert(id)` undoes an `applied` patch the same way (same hash guard). Applying never builds into `Trainer\bin` and never runs the game.

## 6. Deploy

`deploy(id, confirm=True)` - **the only path that restarts the game**:

1. status must be `applied`; `confirm` must be the boolean `True` (a string or truthy value is refused); the patch must touch `src/` (tools-only patches have nothing to deploy - restart the coach server);
2. cooldown `deploy_cooldown_s` (900) since the last deploy (persisted in `engineer/state.json`, survives restarts);
3. the currently deployed `BepInEx/plugins/ThronefallTrainer.dll` is copied to `<agent>/engineer/backups/ThronefallTrainer.<yyyymmdd-hhmmss>.dll` (hash-verified; no DLL to back up = no deploy);
4. `deploy_fn()` - production default `pwsh -NoProfile -ExecutionPolicy Bypass -File tools/build-and-deploy.ps1` (builds into `Trainer\bin`, kills the game, copies with a hash check, relaunches);
   if it fails *before* the DLL changed, the task simply stays `applied` (no rollback, no restart);
5. `health_fn(ctx)` - production default: within `health_timeout_s` (150) `audit.json` is **fresh (< 20 s) and written after the deploy started**, and `caps.json` exists, is newer than the
   deploy and carries a **different pid** than before (proof that the *new* process came up; `health_require_caps: false` skips the caps part);
6. unhealthy -> `restore_fn(backup)` (production: kill the game, put the backup DLL back with a hash check, relaunch) **and** the source patch is reverted from the backups (hash-guarded)
   -> `rolled-back`. If the restore itself failed, `rollback.dll.ok` is `false` in the task record and the game may be down - copy the newest file from `<agent>/engineer/backups/` over
   `BepInEx/plugins/ThronefallTrainer.dll` by hand. A deploy script that fails *after* it killed the game but before it replaced the DLL (`game_down`) takes the same rollback path, so the game is relaunched.

## 7. Configuration - `<agent>/cc-config.json`, key `"engineer"`

```json
{ "engineer": { "mode": "semi", "auto_deploy": false, "min_gap_s": 600, "deploy_cooldown_s": 900 } }
```

| key | default | meaning |
|---|---|---|
| `mode` | `semi` | `off` (idle), `semi` (prepare patches only), `auto` (also apply). Anything else is treated as `off` |
| `auto_deploy` | `false` | only the JSON boolean `true` counts (`"false"` is false). Needs `mode: auto` |
| `min_gap_s` | 600 | autorun starts at most one task per this many seconds |
| `max_pending_patches` | 3 | autorun pauses while this many patches wait for approval |
| `max_attempts` | 3 | autorun never runs a task more than this often (conflicts and failures count) |
| `max_steps` / `max_tokens_total` / `wall_timeout_s` / `max_changed_lines` / `max_files` | 28 / 400000 / 840 / 400 / 6 | run limits |
| `deploy_cooldown_s` | 900 | minimum time between deploys |
| `health_timeout_s` / `health_fresh_s` / `health_require_caps` | 150 / 20 / true | health check |
| `auto_apply_max_lines` / `auto_deploy_max_lines` / `auto_deploy_max_files` | 400 / 150 / 3 | unattended size limits |
| `keep_workspaces` | 4 | newest workspaces kept under `engineer/work/` |
| `python_tests` / `test_projects` | `["test_incidents.py","test_command_center.py"]` / `["GatePlanner.Tests","ActLogic.Tests","Replay"]` | **allowlists** (names or globs, `"*"` = everything found) of the suites the production runner runs; scripts with real-world side effects are deliberately not on it |
| `skip_python_tests` / `skip_test_projects` | `[]` / `[]` | subtract from the allowlists, e.g. `["Replay"]` (all four are read when the Engineer is constructed; `test_mm_engineer.py` is always skipped) |
| `game_dir`, `deployed_dll`, `project_notes`, timeouts, read/grep sizes | see `DEFAULT_CFG` | |

`Engineer.get_cfg()` re-reads the file on every call, so UI changes apply live. `Engineer.set_cfg(patch)` writes **only the `engineer` key** (it never rewrites the command center's own settings) and
returns the effective config; the command center should call it instead of editing its in-memory copy (its `save_cfg()` would otherwise overwrite the change).

## 8. CLI

```
python tools/mm_engineer.py --list                    # merged queue (id, status, priority, title)
python tools/mm_engineer.py --status                  # the UI status JSON
python tools/mm_engineer.py --diff   E0003            # print the exported diff
python tools/mm_engineer.py --run    E0003            # agent run (calls MiniMax with the key from K:\private\.env; minutes, up to ~400k tokens)
python tools/mm_engineer.py --apply  E0003            # git apply + build gate on the live tree, automatic restore on failure
python tools/mm_engineer.py --reject E0003 "duplicate of E0001"
python tools/mm_engineer.py --requeue E0003 | --revert E0003
   [--agent <agent dir>] [--repo <repo root>]         # defaults: $THRONEFALL_AGENT or the usual agent dir, the repo this file lives in
```

There is **no `--deploy`**: a deploy restarts the game and goes through the Live View's confirmation (or the opt-in auto mode).

## 9. How the command center calls it

Nothing in `command_center.py` needs to know how the engineer works - five touch points:

```python
# __init__  (ctx.mm_chat is the same MiniMax function the incident responder uses: chat(messages, max_tokens=...) -> (content, usage))
import mm_engineer
self.engineer = mm_engineer.Engineer(repo_root=HERE.parent, agent_dir=self.agent, mm_chat=self.ctx.mm_chat,
                                     log=lambda m: self.ctx.append_log("mm", m))

# scheduler job, every 60 s - returns immediately, the work runs in a worker thread
"engineer": {"every_s": 60, "desc": "MiniMax engineer: prepare/apply code patches (cc-config engineer.mode)", "fn": self._job_engineer}
def _job_engineer(self):
    r = self.engineer.maybe_autorun()                     # {"action": "idle|wait|busy|run|apply|deploy", "task": "E0003", "reason": ...}
    return "%s %s" % (r.get("action"), r.get("task") or r.get("reason") or "")

# http_get(self, h, path):   (replaces the raw /engineer-queue handler: queue() is the merged view)
res = self.engineer.api_get(path, headers=h.headers)
if res is not None: h._send(res[0], _jdump(res[1]), "application/json"); return True

# http_post(self, h, path, n):
if path.startswith("/engineer"):
    try: body = json.loads(h.rfile.read(n) or b"{}")
    except ValueError: body = {}
    res = self.engineer.api_post(path, body, headers=h.headers)
    if res is not None: h._send(res[0], _jdump(res[1]), "application/json"); return True
```

**Pass `headers=h.headers`.** The coach server listens on 127.0.0.1 but has no CSRF protection of its own (its CORS header only hides responses): any web page open in the user's browser can
POST to `http://127.0.0.1:8099/...`, and `/engineer/apply`, `/engineer/deploy` and `/engineer/config` (mode/auto_deploy) are far more dangerous than a knob order. With the headers the engineer
refuses (`403`) a non-loopback `Host` (DNS rebinding) or `Origin`, and (`415`) any state-changing request that is not `Content-Type: application/json` - a content type a cross-site form or
`fetch` cannot send without a CORS preflight, which the server never grants. The Live View's own `fetch(..., {method:"POST", headers:{"Content-Type":"application/json"}, body: JSON.stringify(...)})`
must therefore set that header. (The command center's existing POST endpoints have the same exposure; `Engineer.request_guard(headers, write=True)` can be reused for them.)

**GET** (all JSON)

| path | returns |
|---|---|
| `/engineer` | `status()` - below |
| `/engineer/queue?n=60` | `queue()`: newest first; every queue field + sidecar fields + `status`, `queue_status`, `allowed` (buttons to offer), `same_target_as` (same file+function guess as an earlier row) |
| `/engineer/diff?id=E0003` | `{"id", "diff": "<unified diff text>", "task": {...}}` (404 when none) |
| `/engineer/log?id=E0003&n=60` | `{"id", "log": [{"n","t","action","args","result","tokens","model_s"} ...]}` - the live transcript of the run |

**POST** (JSON body; `run`/`apply`/`deploy` start a worker thread and answer `202 {"ok":true,"started":"E0003","op":"apply"}` - poll `/engineer`; wrong status, missing confirm, cooldown and busy are answered
immediately with `409 {"ok":false,"error":...}`; unknown ids `404`)

| path | body | |
|---|---|---|
| `/engineer/run` | `{"id"}` | status must be `queued` |
| `/engineer/apply` | `{"id"}` | status must be `patched` |
| `/engineer/deploy` | `{"id","confirm":true}` | status `applied`; **`confirm` must be the JSON boolean true** - have the button ask "this restarts the game" |
| `/engineer/reject` | `{"id","reason"}` | |
| `/engineer/requeue`, `/engineer/revert` | `{"id"}` | |
| `/engineer/config` | `{"mode","auto_deploy","min_gap_s","deploy_cooldown_s","max_steps"}` (any subset) | persisted into `cc-config.json` (`400` for an invalid mode) |
| `/engineer/autorun` | `{}` | one `maybe_autorun()` decision (manual "run next now") |

`status()` (what the pane polls):

```json
{ "t": 1790916000.0, "mode": "semi", "auto_deploy": false, "busy": false,
  "counts": {"queued": 31, "patched": 1, "applied": 1, "total": 33},
  "current": {"id":"E0003","op":"run","step":5,"max_steps":28,"phase":"model|action|gates:build|gates:tests","action":"edit","tokens":13022,"elapsed_s":14.2,"edits":1},
  "next": {"id":"E0001","title":"...","priority":"urgent"},
  "awaiting_approval": ["E0003"], "awaiting_deploy": [],
  "last_results": [{"id","title","status","finished","steps","tokens","summary","error","note","touches_server","needs_plugin_deploy","diff_stats":{"files":[..],"added":2,"removed":0},"applied_at","deployed_at","attempts"}],
  "cooldown": {"deploy_remaining_s": 0, "next_run_in_s": 120},
  "git": true, "config": { ...effective config... } }
```

A task row in `queue()` additionally carries `gates` (`limits`, `safety{ok,violations,warnings}`, `build`, `tests{passed,new_failures,preexisting}`, `lint`, optional `hygiene`),
`diff_path`, `diff_sha256`, `diff_stats`, `touches_server`, `needs_plugin_deploy`, `safety_warnings`, `post_hashes`, `restore`, `rollback`, `backup_dll`, `health`, `conflicts`, `attempts`, `transcript` and a
`history` list of `{t, event}`.

Every free-text field in these payloads (`title`, `evidence`, `fix`, `summary`, `error`, `note`, the diff, transcript results) is model-generated: **render it as text, never as HTML**.

Suggested pane: header with `mode` / `auto_deploy` toggles and the `current` progress bar; one row per task with a status badge, `summary`, gate chips (build / tests / lint / safety, scan warnings in amber),
`touches_server` ("restart the coach server after applying"), buttons from `allowed`; "diff" opens `/engineer/diff`; "Deploy" asks for confirmation; `rolled-back`/`apply-failed` rows show `error`.

## 10. Files

| path | what |
|---|---|
| `<agent>/engineer-queue.jsonl` | input, append-only (written by the command center) |
| `<agent>/engineer-status.json` | sidecar state per task id |
| `<agent>/engineer/<id>.diff` | the exported patch; `<id>.failed.diff` partial work of a failed run |
| `<agent>/engineer/<id>.log.jsonl` | step transcript (`.prev` = the run before) |
| `<agent>/engineer/<id>.prev/` | apply backups + `_manifest.json` |
| `<agent>/engineer/work/<id>/{base,work}/` | the isolated copies (newest `keep_workspaces` kept) |
| `<agent>/engineer/backups/ThronefallTrainer.<ts>.dll` | DLL backups taken before every deploy |
| `<agent>/engineer/state.json`, `engineer.lock` | cooldown/gap timestamps; the one-operation lock (pid + heartbeat, a dead process's lock does not block) |

Sidecar, state and lock files are replaced atomically (`os.replace`). On Windows a reader that opens one of them in the same few milliseconds gets `PermissionError`: other tools that read
`engineer-status.json` directly should retry briefly; the engineer itself retries, and a read-modify-write that cannot read the sidecar **fails instead of overwriting it with an empty view**
(a sidecar that stays corrupt is moved aside as `engineer-status.json.corrupt-<ts>`).

The workspace copy contains `src tests tools docs` and root `*.md/*.sln/*.csproj` - **not** `.git`, `bin`, `obj`, `decompiled*`, `dist`, `desktop`, `reference`, `node_modules`, `__pycache__`, links or files > 3 MB.

## 11. First supervised run (before enabling `auto`)

```
python tools/mm_engineer.py --list                          # 30+ urgent rows are normal; many are the same defect filed again (same_target_as in /engineer/queue)
python tools/mm_engineer.py --reject E0005 "duplicate of E0001"
python tools/mm_engineer.py --run E0003                      # tail <agent>\engineer\E0003.log.jsonl in a second window; ends patched / failed / no-change
python tools/mm_engineer.py --diff E0003                     # read it: does it fix the CAUSE? is every changed line needed?
python tools/mm_engineer.py --apply E0003                    # live tree + build gate; automatic restore if it does not build
# deploy: Live View button (POST /engineer/deploy, confirm:true) once the command center wires the endpoints in (section 9)
```

Watch for: patches that only add retries/timeouts, edits far from the reported symptom, a summary that does not match the diff, `safety_warnings`, and `tests.preexisting` hiding the very test that should have turned green.

## 12. Verification and honest limits

* `python tests/test_mm_engineer.py` - 400+ checks against a sandbox repo, a scripted mock model and fake runner/deploy/health hooks (path policy, exact-edit semantics incl. BOM/CRLF/mixed endings, diff
  round trips through real `git apply`, a real git repo with `autocrlf=true` (byte-exact apply, no line-ending churn), scan rules, gate feedback loops, limits, retries/aborts, apply/conflict/partial-apply restore, deploy guards/cooldown/rollback,
  autorun modes, API, CLI, sidecar races, fuzzed model replies, process-tree timeouts, the production hooks with a faked process layer, a local fake MiniMax endpoint).
  Typically 20-40 s (up to ~60 s while the machine is busy with the game and builds); it needs `git` on PATH and writes only to temp dirs.
* `python tools/engineer-sim.py --mock` (offline) and `python tools/engineer-sim.py` (real MiniMax) drive the whole loop on the sandbox; `--crlf-tabs` makes the sandbox files TAB-indented with CRLF endings like
  the real `Bot.cs`. Real MiniMax-M3 runs (three): plain sandbox patched in **7 steps / 20 151 tokens / 20 s**; CRLF+tabs sandbox patched in **6 steps / 16 376 tokens / 19 s** (it wrote the tabs as `\t` correctly);
  plain again (after later hardening) patched in **8 steps / 26 062 tokens / 52 s** - there the model answered once **in prose instead of JSON** (step 3, after two reads); the corrective message
  got it back on track the very next call, which is exactly the path the parser/abort logic exists for (observations now end with a one-line "reply with exactly one JSON action object" reminder; that
  last tweak was only checked by the mock tests, not by another real run). All three: the same correct 2-line fix, applied to a copy of the sandbox, 6/6 tests green. Calls took 1-6 s each, far below the 90 s timeout.
* The production `Runner.build` was smoke-run on a scratch copy of the real repo (6.7 s, DLL produced, `Trainer\bin` and `src\obj` untouched, no leftover dotnet processes). `Runner.test`, the default
  deploy/health/restore hooks are exercised in tests only with fakes (command lines, parsers, decision logic) - **do a first supervised run** (`--run`, review `--diff`, `--apply`) before enabling `auto`.

Limits you should know:

* **Baseline comparison is not a fix check**: a patch that breaks nothing but also fixes nothing passes the gates (the observation lists the still-failing pre-existing tests, and the summary should say
  what changed - read it). Example from the tree at the time of writing: the `Replay` fixture already failed in the BASE (1/163 mode mismatches), so it shows up as *pre-existing* - it cannot veto a patch, but it also
  cannot catch a patch that makes that particular fixture worse (`skip_test_projects` can drop a suite you consider noise). Unit tests only cover pure logic; the bot's in-game behaviour is validated afterwards by the incident watchdog, not by the gates. The health check proves the plugin comes up
  (audit.json, caps.json), not that behaviour improved.
* **The safety scan is a pattern filter, not a sandbox.** It stops the obvious (process spawns, cheats, network, loaders), but reviewing the diff in `semi` mode is the real control; `auto` trades that for speed.
* **Task text is untrusted input**: evidence/fix strings come from MiniMax reading game data and land in the prompt. The path policy, protected files and scan bound what a bad prompt can do.
* **Concurrent editors**: the live tree may be edited by someone else while a patch is prepared. `git apply --check` catches overlapping edits (`conflict`), the restore guard protects newer edits, but there is a
  short window between apply and the build gate in which the tree is in flux.
* **A deploy ships the whole live tree**, not just the engineer's patch: `build-and-deploy.ps1` builds whatever is in `src/` at that moment, including other people's uncommitted work (the apply-time
  build gate only proves it compiles). Deploy when the tree is in a state you would deploy anyway.
* A deploy restarts the game (a running match is lost) - that is why it needs `confirm`, a cooldown, and is off in auto mode by default. Patches to the coach server (`touches_server`) are applied but need a
  manual coach-server restart (the supervisor does not do it for engineer patches).
* Old `queued` tasks can be obsolete (e.g. the `act.v1` tasks once `Act.cs` exists): the model is told it may `finish` with `no_change`; rejecting duplicates up front (`same_target_as`) saves tokens.
* A run costs tokens: ~20k for the trivial sandbox task, expect 100-400k on the real 3 000-line files (observations are capped at 6 KB, the conversation at 14 messages).
