# HANDOFF — Thronefall Reference Pack (static extraction · mapping files · game handbook · PDFs)

Written 2026-09-29 ~12:05 UTC by Claude (claude-opus-5-5, owner id `claude-refpack`) because the user is
switching models. **Facts** are marked with their evidence; **Plan** items are proposals not yet executed.

---

## 0. Read this first (60-second version)

- **Goal (user's words, paraphrased):** extract *everything* a fully autonomous ("anonymous" = no human
  interaction) Thronefall bot could need. Deliver it as **mapping files + Markdown + PDFs**: extremely detailed,
  "truth-proof" (every claim backed by evidence), with schematics. It also serves as a **game handbook** so the bot
  and its LLM brain understand levels, waves, troops and terrain.
- **Why the user wants it:** they have watched the bot live. It gets **stuck on rocks**, **stands still at
  nightfall** while monsters walk in, and **goes out alone without troops**. The user's diagnosis: the bot lacks
  game knowledge. Claude agreed. The bot sees the present moment (Snapshot) but has no model of levels, waves,
  spawn routes, troop-producing buildings or obstacles.
- **You are NOT alone in this repo.** Devin (`devin-cli`) is live-coding the bot and running the game.
  Coordinate only through the **Hermes lock orchestrator MCP** (section 2). Check the inbox often.
- **State:** the C# mapper is ~40 % written (`TfMap/Model.cs`, `TfMap/Layouts.cs`, `TfMap.csproj`). It has **not been
  compiled or run yet**. `reference/` is empty. No data has been delivered to Devin yet.
- **Next step:** reconnect Hermes → write `TfMap/Program.cs` + `TfMap/IL.cs` → build → run → Python extractor
  (Devin's priority order in section 3).

---

## 1. Project, paths, revisions

| Item | Value (fact) |
|---|---|
| Repo (Devin + Claude) | `K:\Downloads-IDM\Thronefall\Trainer` · branch `main` · HEAD `4b935247c66fcaece7389e1ce9490ffc9fb296ae` (2026-09-29 03:58:45 -0700, "docs: design/research packet …") · remote `origin https://github.com/Ghenghis/ThroneFall-Trainer.git` |
| Uncommitted work in tree | **Devin's**: `AUTOPILOT.md`, `CHANGELOG.md`, `src/Bot.cs`, `src/BotPerception.cs`, `tools/bot-lint.ps1` modified; `src/BotBrain.cs`, `src/Recorder.cs` untracked. **Never** `git add -A`, commit, stash or reset. Also untracked: `.hermes3d_orchestrator/` (Hermes state; don't commit or delete it) and `tools/refpack/` (ours). |
| `.gitignore` | ignores `bin/ obj/ decompiled/ decompiled_fog/ *.png .vs/ .vscode/ dist/` → images you want in git must be **SVG** |
| Game copy the bot runs on | `K:\Downloads-IDM\Thronefall` (BepInEx 5.4.23.x + `BepInEx\plugins\ThronefallTrainer.dll`, `bot-log.jsonl`) |
| Its game logic DLL | `K:\Downloads-IDM\Thronefall\Thronefall_Data\Managed\Assembly-CSharp.dll`: 2,587,648 B, dated 2026-06-30, SHA256 `F350269E5D14213C7486CE65478A8B91651D01B954BDA3D1C18D18C4E30B6505` |
| Steam install (newer build) | `C:\Program Files (x86)\Steam\steamapps\common\Thronefall`: appid 2239150, **buildid 25306299**, LastUpdated 2026-09-25 10:39:57Z; Assembly-CSharp 2,531,840 B, SHA256 `217DC7E6BE0B6DFAD99D3311231320249B844D26CD53763B25AF4EB4729DDFE6` |
| Build drift (fact) | both builds have 168 Managed DLLs with the same names; **20 differ** (Assembly-CSharp, -firstpass, KB.FogRTS.Runtime, MoreMountains.*, Lofelt.*, MPUIKit, Rewired_Windows_Functions, ShapesRuntime, Tayx.Graphy, com.nintendo.sdkplugin, com.rlabrecque.steamworks.net). K: files dated 2026-06-30, Steam 2026-09-25. |
| Other copies (ignore) | `K:\Games\Thronefall`, `G:\steamapps\common\Thronefall` (older: only `level0–39`), `G:\Downloads\Thronefall (NSP)(eShop)` |
| Existing decompile | `Trainer\decompiled\` = 3,056 .cs (ilspycmd `-p` of the **K: build**, 2026-09-25); `Trainer\decompiled_fog\` = 21 .cs (KB.FogRTS.Runtime) |
| Engine | Unity **2022.3.62f2**, **Mono** (no `GameAssembly.dll`; `UnityPlayer.dll` FileVersion 2022.3.62.7762112) |
| Data files | `Thronefall_Data\level0 … level40` (41 scenes), `sharedassets0 … 40.assets`, `resources.assets`, `globalgamemanagers(.assets)`; serialized-file format **22** |
| Type trees | **absent** (`_enable_type_tree = False`, 0 node lists for level1's 66 types). UnityPy 1.25.3 probe (`probes/probe_assets.py`) on the **K: build** `level1`: 384 objects (148 MonoBehaviour); `read_typetree()` ok 9 / **fail 139** ("Expected to read 22688 bytes, but only read 32 bytes"). On the Steam copy the same file has 381 objects / 147 MonoBehaviour, so **level data differs between builds too**. **So we must generate layouts ourselves**: that is `TfMap/Layouts.cs`. |
| JSON libs in K: Managed | `Newtonsoft.Json.dll` **and** `UnityEngine.JSONSerializeModule.dll` present (told Devin; he keeps JsonUtility by choice) |

### Tools on this machine (verified, no downloads needed; do NOT install anything without asking)
- .NET SDK 8.0.424 / 9.x / 10.0.400 (`dotnet`); .NET Framework ref assemblies v4.x installed; NuGet cache has `lib.harmony 2.2.2/2.4.2`, `markdig`, `microsoft.netframework.referenceassemblies.net472`.
- Python **3.14.5** `C:\Python314\python.exe` with **UnityPy 1.25.3**, Markdown 3.10.2, markdown-it-py 3.0, fpdf2 2.8.7, pypdf 6.14, PyPDF2, matplotlib 3.10.9, graphviz 0.21 (+ `dot` at `C:\ProgramData\chocolatey\bin\dot`), Pygments, pillow, lz4, brotli, texture2ddecoder, dnfile, playwright 1.60 (Chromium builds in `%LOCALAPPDATA%\ms-playwright`).
- `ilspycmd` at `%USERPROFILE%\.dotnet\tools\ilspycmd.exe` (**not on PATH**). Edge + Chrome installed (headless print-to-PDF possible). Node, Java 21.
- UnityPy's bundled TPK gives exact built-in layouts for 2022.3.62f2. Script: `tools/refpack/probes/tpk_probe.py` (copied from the session scratchpad; `probes/probe_assets.py` is the type-tree probe from section 1) (`UnityPy.helpers.Tpk.get_typetree_node(classID, UnityVersion.from_str("2022.3.62f2"))`).

---

## 2. Coordination: Hermes lock orchestrator (MANDATORY)

- Use MCP server **`hermes3d-lock-orchestrator`** (tools `mcp__hermes3d-lock-orchestrator__*`). Do **not** use
  `hermes3d-locks`: that instance serves `G:\Github\HermesProof`. Repo of the orchestrator: `G:\Github\hermes3d-mcp-lock-orchestrator`.
- A fresh session's server may start on another workspace (it started on `K:\PAC-MAN 256`). **First call:**
  `hermes_connect_project(workspaceRoot="K:\\Downloads-IDM\\Thronefall\\Trainer", owner="claude-refpack",
  joinPresence=true, ensureGitLabProject=false, probeGitLab=false, addRemote=false, mode="coordinated-dev")`.
  **Never let it add git remotes or create GitLab projects.**
- Reuse the **same owner id `claude-refpack`**. It owns these locks:
  - `tools/refpack` (lock `f849fed5f56103f5d2f3da3b`) and `reference` (lock `52367a6622b19f08825e915f`), acquired 2026-09-29T11:56Z with 240 min TTL; heartbeated 12:08Z.
    Refresh with `hermes_heartbeat(owner="claude-refpack")` **without** `taskId`: the locks carry `task_id: null`, and a heartbeat that passes a taskId touches nothing (verified: `touched: []` vs `touched: ["reference","tools/refpack"]`). If they expire, re-take them with `hermes_lock_files`.
  - A2A task `a2a_1790682962254_dabde820` (status `submitted`).
- State dir: `Trainer\.hermes3d_orchestrator\` (file based; shared with Devin).
- **Devin = `devin-cli`** (Devin CLI, swe-2-max, role builder, task `thronefall-v2-agentic`). His lane (locked):
  `src/Bot.cs, src/BotPerception.cs, src/Recorder.cs, src/Plugin.cs`, the csproj, top-level `tools/*.ps1`, doc
  updates in `docs/`/root md. **He owns the live `thronefall.exe` process and `BepInEx/plugins` deployments.**
  → Claude must never start or stop the game, write into `BepInEx/`, or edit `src/`, `docs/` or root `*.md`.
  If something outside `tools/refpack` or `reference` must change, send a Hermes message or `hermes_request_handoff` first.
- User's protocol (explicit): lock before editing, unlock when done, message each other for unlocks or
  problems, and **check the inbox frequently** (`hermes_get_inbox(owner="claude-refpack")`) at least at every
  milestone and before any write batch. Ack messages that have `requires_ack`.
- Message log so far: sent intro `msg_8d20d4a5f4e1aadd`; Devin acked; Devin's priority message
  `msg_f845468fdfa2f62f` (acked; reply `msg_a9b513c2268bf6e4` told him the next session continues as `claude-refpack`).

---

## 3. Devin's priority order (accepted; this is the extraction order)

1. **Per-level wave tables + spawn-line world coordinates** → his `WaveIntel.cs` (P1) and `anchors.json` seeds
   (B2). Known first anchor: Nordfels keep wedge at **(0, 4)**.
2. **BuildSlot positions + upgrade trees and costs** → slot classes (P7) and `ChoiceIntel` (P2).
3. **UIFrame name list** → `config/frames.json` seed (note the real frame name `"After Match Frame "` has a
   trailing space; `BackToLevelSelectHelper` lookup did not match live, so check where that component sits and whether it's active).
4. **Enemy AutoAttack ranges and speed** → P3 threat fields.

After each lands in `reference/`, send `devin-cli` a Hermes message with the file paths and schema.
He also wants the **API-drift report** (K: build 2026-06-30 vs Steam 2026-09-25).

---

## 4. Verified facts about the game code (evidence = metadata reads done this session)

> ⚠ Items 4.2–4.4 were read from the **Steam** DLL during an early probe. They must be **re-confirmed against the
> K: build** (TfMap does this automatically). The class names below also appear in `Trainer\decompiled\`.

4.1 K: build `Assembly-CSharp` top-level types = 3,060: `Epic.OnlineServices*` 2,148 · global namespace 657 ·
`NGS.MeshFusionPro` 88 · `I2.Loc` 86 · `Rewired*` ~60 · `FlatKit` 7 · `Ara` 6 · `Thronefall.GameServices` 4 ·
`Thronefall.SaveServices` 3 · `MoreMountains.Feedbacks` 1. Game code = global + `Thronefall.*`; the rest is vendor code.

4.2 Serialized (editor-set) fields: the values live in the **asset files**, not the DLL:
- `EnemySpawner`: currentMode, goldBalanceAtStart, waveGeneratorScript, **waves**, pauseSpawningAtEnemyCount, endlessMode, endlessModeWaveGeneratorScript, difficultySprite, flyingConstraint, groundConstraint, groundConstraintLarge, reduceSpawnWaitTimes
- `Wave` [Serializable]: warningText, **spawns**, difficultyMulti
- `Spawn` [Serializable]: delay, **enemyPrefab**, eliteEnemies, **count**, **interval**, **spawnLine**, goldCoins, waitBeforeNextSpawn
- `Hp`: **maxHp**, getsKnockedOutInsteadOfDying, …, coin, coinSpawnOffset, **coinCount**, spwanAttackOnDeath, invulnerable (23 total)
- `Weapon` (ScriptableObject): projectileSpeed, maximumChaseRange, isPlayerWeapon, **directDamage**, **splashDamage**, slowsFastEnemiesFor, additionalWeaponEffects, … (23)
- `AutoAttack`: **cooldownDuration**, cooldownAfterSpawn, cooldownRandomization, recheckTargetInterval, **targetPriorities**, **weapon**, damageMultiplyer, projectileSpeedMultiplyer, … (12)
- `BuildSlot`: **buildingName**, requiredRootLevelDifference, startDeactivated, **activatorBuilding**, **activatorLevel**, activatorUpgradesThis, **upgrades**, … (24)
- `LevelInfo` (SO): sceneName, displayName, …, unlockRequirement, **enemySpawner**, **quests**, **fixedLoadout**, **maxPerkCount**, virtualBuildings
- `BalancingParameters` (SO): parameters · `DayNightCycle`: sunriseTime, OnTimeChange

4.3 ScriptableObject subclasses (20): DlcConfiguration, AdditionalWeaponEffectScript, AudioSet, BalancingParameters,
CameraBounds, Colorscheme, EternalTrialEnemySet, EternalWaveGenerator, LevelInfo, Equippable, WardrobeScriptableObject,
Revision, WaterSettings, Weapon, LanguageSourceAsset, ILocalizeTarget, FogSettings, OutlineSettings, TrailSection,
CustomPlatformHardwareJoystickMapPlatformDataSet.

4.4 Bot-relevant classes that exist (names): DayNightCycle, EnemySpawner, EnemySpawnGroup, EnemySpawnLine,
EnemySpawnManager, Wave, Spawn, WaveInfo, WaveEnemyInfo, EternalWaveGenerator, EndlessModeWaveGen, PaulsWaveGenerator,
SeasonTwoWaveGen, SuperWaveGen, WaveGenUtility, BuildSlot, BuildingInteractor, Upgrade, UpgradeBranch, TowerUpgrade,
PlayerInteraction, PlayerUpgradeManager, PerkManager, LevelProgressManager, LevelData, SceneNameToLevelData,
PathfindMovementEnemy, PathfindMovementPlayerunit, PathPoint, NavmeshBakeHelper, TargetPriority, ETargetingMode, Hp,
Coin, CoinSpawner, Coinslot, IncomeModifyer, IncreaseIncomeDaily, **EconomySimulator** (unread; may be a ready-made
economy model), SaveLoadManager, MatchSave, CommandUnits, UnitRespawnerForBuildings, UIFrame*, ChoiceManager, Shrine, Nighthorn.

4.5 `[SerializeReference]` is referenced by `MoreMountains.Feedbacks.dll` and `AstarPathfindingProject.dll` (plus
UnityEngine modules). Objects of classes with SerializeReference fields end with a `ManagedReferencesRegistry` that
UnityPy can't decode without file ref-types → **custom Python parse needed** (see 6.3).

4.6 Exact Unity 2022.3 built-ins (from TPK, already encoded in `Layouts.cs`):
MonoBehaviour header = `PPtr m_GameObject (int m_FileID, SInt64 m_PathID)`, `UInt8 m_Enabled` (align),
`PPtr m_Script`, `string m_Name`; Gradient = key0–7 (4 floats each), ctime0–7 & atime0–7 (UInt16), `UInt8 m_Mode`,
`SInt8 m_ColorSpace`, `UInt8 m_NumColorKeys`, `UInt8 m_NumAlphaKeys` (align); AnimationCurve = vector of Keyframe
(time, value, inSlope, outSlope, int weightedMode, inWeight, outWeight) + 3 ints.

---

## 5. What exists now (files) and status

| File | Status |
|---|---|
| `tools/refpack/TfMap/TfMap.csproj` | written: net8.0 console, no PackageReferences |
| `tools/refpack/TfMap/Model.cs` | written: `Module` (PEReader + MetadataReader + top-type index + forwarders + sha256), `TDef`, `TypeSig` family (Prim/Named/GenInst/SZArray/MDArray/Ptr/GenParam/Other), `SigProvider` (ISignatureTypeProvider + ICustomAttributeTypeProvider), `TInfo` cache (base chain, enum/valuetype/delegate/UnityObject/MonoBehaviour/ScriptableObject flags, enum underlying), `World` (load all Managed DLLs, resolve TypeRef across assemblies with forwarders, `Info()`), `Naming` (full names with `/` for nested, `Show()` C#-like display), `Attrs` (attribute type lookup, `Describe()` e.g. `Tooltip("…")`, constants) |
| `tools/refpack/TfMap/Layouts.cs` | written: `LayoutBuilder.BuildScript(TDef)` → Unity type-tree `Node(Level, Type, Name, Meta)` list incl. MonoBehaviour header; `BuildClass(TDef)` for SerializeReference data; rules: public/[SerializeField]/[SerializeReference], exclude static/const/readonly/[NonSerialized]; prims (C# `char`→UInt16), string, enums by underlying type, PPtr for UnityEngine.Object, [Serializable] non-abstract non-System classes/structs incl. closed generics (substitution), T[] / List<T> (no nesting), built-ins table (Vector2/3/4, Quaternion, Color, Color32, Rect(Int), Bounds(Int), Vector2/3Int, LayerMask, Matrix4x4, Hash128, SH L2, Keyframe, AnimationCurve, Gradient, RectOffset, GUIStyle, PropertyName→string); align 0x4000 after sub-4-byte non-element prims, after structs, and on every `Array` node; self-typed field skipped; depth limit 10; SerializeReference → `managedReference{SInt64 rid}` + trailing `ManagedReferencesRegistry` node. `Notes` records every skipped field with its reason. |
| `TfMap/Program.cs`, `TfMap/IL.cs` | **NOT WRITTEN** |
| Anything under `reference/` | **empty** |
| Compiled/run | **never**: expect compile fixes on the first build |

Uncertain rules inside `Layouts.cs` that the byte-exact check must settle: (a) enums with non-int underlying types
(currently sized by the underlying type; if they fail, try int32); (b) C# `char` as UInt16; (c) depth-limit counting;
(d) the exact SerializeReference registry node shape for 2022.3 (version 2, `RefIds` vector); (e) GUIStyle layout
(written from memory; only matters if some script serializes a GUIStyle).

---

## 6. Plan for the remaining work (proposals, in order)

### 6.1 `TfMap/Program.cs` + `TfMap/IL.cs` (C#)
CLI: `TfMap <ManagedDir> <OutDir> [--full Assembly-CSharp,Assembly-CSharp-firstpass,KB.FogRTS.Runtime] [--members AstarPathfindingProject] [--vendor Epic.OnlineServices,I2,Rewired,NGS,FlatKit,Ara,MoreMountains] [--no-il] [--no-layouts]`
Outputs (under OutDir):
- `assemblies.json`: every DLL: name, version, MVID, size, sha256, type count, references; skipped natives.
- `code/<Asm>.types.jsonl`: one line per type: token, full name, kind, flags, base + base chain, Unity role
  (MonoBehaviour/ScriptableObject/Serializable/…), interfaces, generic params, attributes; fields (token, type,
  flags, `unitySerialized`, const value, Tooltip/Header/Range text); properties (get/set tokens); events; methods
  (token, RVA, IL size, full signature with param names, flags, Unity message flag, **inlineRisk** = non-virtual & IL ≤ 20 B
  → Mono may inline it, so a Harmony patch won't hit those call sites); enum values; singletons (static field or property of its own type, e.g.
  `EnemySpawner.instance`). Vendor namespaces: summary only.
- `il/<Asm>/<Type>.il`: IL disassembly (game namespaces only). Opcode table = `typeof(OpCodes)` fields keyed by
  `(ushort)op.Value`; 0xFE prefix = two-byte; branch target = next-instruction offset + delta; switch base = end
  of the switch; tokens resolved (MethodDef/MemberRef/MethodSpec/FieldDef/TypeDef/TypeRef/TypeSpec/UserString).
- `code/<Asm>.xrefs.jsonl`: per method: calls [calleeKey, localToken?, ilOffset, opcode], field reads/writes,
  string literals, newobj; plus reverse indexes `callers.json` and `fieldaccess.json`. Special lists:
  Random call sites (UnityEngine.Random / System.Random), Time usage, `Resources.Load`, PlayerPrefs keys, scene-name strings.
- `serialization/layouts.json` (`"<asm>.dll|<ns>|<class>" → {nodes:[[lvl,type,name,meta]…], notes, managedRefs}`) and
  `layouts.txt` (indented, human readable); `serialization/class_layouts.json` for [Serializable] types in assemblies
  that use SerializeReference.
Run: K: build full → `reference/maps/`; Steam build `--no-il --no-layouts` → `reference/maps/_steam/` → Python diff → drift report.

### 6.2 Build & run commands
```powershell
dotnet build K:\Downloads-IDM\Thronefall\Trainer\tools\refpack\TfMap\TfMap.csproj -c Release
dotnet K:\Downloads-IDM\Thronefall\Trainer\tools\refpack\TfMap\bin\Release\net8.0\TfMap.dll `
  "K:\Downloads-IDM\Thronefall\Thronefall_Data\Managed" "K:\Downloads-IDM\Thronefall\Trainer\reference\maps"
dotnet ...\TfMap.dll "C:\Program Files (x86)\Steam\steamapps\common\Thronefall\Thronefall_Data\Managed" `
  "K:\Downloads-IDM\Thronefall\Trainer\reference\maps\_steam" --no-il --no-layouts
```
(`bin/`/`obj/` are gitignored.)

### 6.3 `tools/refpack/extract_assets.py` (Python, UnityPy)
1. `UnityPy.load(<K: Thronefall_Data>)` → all files. MonoScript objects read natively (`m_ClassName`, `m_Namespace`, `m_AssemblyName`).
2. For each MonoBehaviour: parse the header yourself from `obj.get_raw_data()` (int32 fileID, int64 pathID, uint8 enabled + 3 pad,
   int32 fileID, int64 pathID, aligned string) → resolve `m_Script` (fileID 0 = same file, else `externals[fileID-1]`) → layout key
   → `obj.read_typetree(nodes=layout, check_read=True)` (UnityPy accepts `list[dict]` with `m_Level, m_Type, m_Name, m_MetaFlag`).
   A ValueError means the layout is wrong for that class. Record per-class pass/fail; target ≥ 99 % byte-exact, and investigate failures.
3. Managed-ref registry: read with `check_read=False` up to the registry, then parse manually (int version, int count, per entry:
   int64 rid, 3 aligned strings class/ns/asm, data via `class_layouts.json` + `UnityPy.helpers.TypeTreeHelper.read_value`).
4. Scene graphs per level: GameObject (name, active, layer, tag, components), Transform/RectTransform (local TRS, parent) →
   world positions; resolve every PPtr to `{file, pathID, class, name}`; map `levelN` ↔ scene name via `globalgamemanagers` BuildSettings.
5. Domain exports in Devin's order → `reference/data/`: `waves/<scene>.json` + `waves_all.csv` (every Spawn with enemy prefab name,
   count, interval, delay, spawn line + its world position, goldCoins, elites, difficultyMulti, per-wave totals using enemy HP);
   `spawn_lines.csv`; `build_slots/<scene>.json` + `build_slots.csv` + `upgrades.csv` (position, buildingName, activator
   dependencies, every level/branch with cost, core cost, income Δ, hp Δ, objects activated → towers/units produced);
   `ui_frames.csv` + `frames.seed.json` (raw names incl. trailing spaces, freezePlayer, canNotBeEscaped, child helpers + active
   state); `enemies.csv` / `units.csv` / `towers.csv` (Hp.maxHp, coin drop, move speed, AutoAttack cooldown/range/targets,
   Weapon damage/splash/projectile speed, flying tag); `levels.json` (LevelInfo), `weapons.csv`, `perks.csv`, `balancing.json`,
   `localization.csv` (I2 LanguageSourceAsset English terms → display names), `anchors.seed.json` (candidates only: slot stand-off
   points, keep entrances, spawn-line chokepoints; label clearly as derived). Terrain for the "stuck on rocks" problem: collider
   objects (Box/Mesh/Capsule/Sphere colliders + NavmeshCut) per level and the A* graph blob on the `AstarPath` component, if it
   can be decoded (A* stores graphs as zipped bytes; settings JSON + node data).
6. Also export `maps/assets/index.jsonl` (every object: file, pathID, classID/class, name, script) and `maps/scenes/<scene>.json`.

### 6.4 Docs, schematics, PDFs → `reference/docs`, `reference/img`, `reference/pdf`
Docs (Markdown, generated from data + analysis of `decompiled/` with `File.cs:line` citations and metadata tokens):
`00-overview-and-coverage`, `01-re-primer-glossary` (mapping files, decompile vs disassemble, Mono vs IL2CPP, serialized
fields, asset typing, hooking/Harmony, runtime dump, forward model; each tied to Thronefall evidence), `02-build-fingerprint-and-drift`,
`03-architecture-and-game-loop` (day/night, LocalGamestate, scene flow; Graphviz SVG), `04-state-map` (bot concept → class/field/
access path/token), `05-action-map` (player action → legit API path + preconditions), `06-hook-map` (Harmony choke points, inline
risk), `07-level-handbook/<scene>.md` (map schematic SVG with slots, spawn lines, castle, horn, shrines, obstacles; night-by-night
wave table; recommended build order derived from data), `08-mechanics` (damage, targeting, income, spawning, difficulty, wave
generators, randomness), `09-autonomy-guide` (menus → level select → loadout → day/night loop → end screens → recovery;
fixes for stuck / idle at night / no troops), `10-forward-model-spec`, `11-code-map-index`.
PDF pipeline: Markdown → HTML (python-markdown + Pygments CSS, SVG inline) → Playwright Chromium `page.pdf()` (or Edge
`--headless --print-to-pdf`). Render every page and inspect it (no empty pages, no overflow). One PDF per doc + a combined handbook PDF.

### 6.5 Verification ("truth proof"), required before claiming done
- Byte-exact parse rate per class (report table); every doc number traceable to a data file row.
- Identifier check: every backticked identifier in the docs exists in `code/*.types.jsonl` or `decompiled/` (same method Devin's AUDIT-LOG used).
- Cross-check against live telemetry: `K:\Downloads-IDM\Thronefall\BepInEx\plugins\bot-log.jsonl` (`wave` field "n/total").
  E.g. Nordfels total nights **13** (AGENTIC-DESIGN §1.3) must equal `len(EnemySpawner.waves)` extracted for Nordfels.
- Coverage report with measured percentages, not estimates. The user asked "how high a percentage": answer with these numbers.

---

## 7. Next actions (with stop conditions)

1. Reconnect Hermes (section 2), `hermes_get_inbox`, ack anything pending, `hermes_heartbeat`. **Stop** if the MCP is unreachable: no writes while disconnected.
2. Write `TfMap/Program.cs` + `TfMap/IL.cs` (6.1), build, fix compile errors, run on the K: build. Sanity: `EnemySpawner` layout must include `waves → Wave{warningText, spawns → Spawn{…}, difficultyMulti}`.
3. Write `extract_assets.py` steps 1–2 and measure the byte-exact rate. Fix `Layouts.cs` rules until nearly everything passes. **Stop and report** if < 90 % after reasonable fixes.
4. Deliver priority 1 (waves + spawn lines) → message Devin. Then 2 → message, 3 → message, 4 → message.
5. Remaining data, drift report, docs, SVG schematics, PDFs, verification, coverage report.
6. Final: `hermes_append_evidence` (summary + file list), completion message to Devin, release locks (`hermes_release_files`), tell the user.

Never: start or stop `thronefall.exe`; write under `K:\Downloads-IDM\Thronefall\BepInEx` or `Thronefall_Data`; edit `src/`,
`docs/`, root `*.md`, csproj or top-level `tools/*.ps1`; commit or push (the user hasn't asked); install packages without asking.

## 8. Gotchas learned this session
- Bash cwd resets between calls: use absolute paths. PowerShell 7 is the primary shell; Git Bash is also available.
- UnityPy vector reading: node with first child `Array` → children `[int size, <elem> data]`; an align flag on the elem makes
  UnityPy bulk-read then align once. `string` nodes self-align. Meta flag 0x4000 = align.
- Mono builds strip nothing: names are original, so no "deobfuscation mapping" is needed (the user asked about "mapping files";
  our mapping files are the code map, serialization layouts, asset index and state/action/hook maps).
- The bot-relevant numbers (waves, costs, HP) are in the asset files, not the DLL. The DLL only has field names and rules.
- `*.png` is gitignored in this repo.
- The user dictates by voice (expect typos: "anonymous" = autonomous, "Herm's proof" = Hermes/HermesProof MCP).

---
## Addendum - end of session 2 (Sonnet 5.5; stopped by a usage limit, 2026-09-29)

**State.** Locks `reference` and `tools/refpack` are still held by `claude-refpack` (heartbeat or release them; they expire about 15:00Z). Nothing is committed (Devin has uncommitted work in the same repo: never `git add -A`).

**Done this session**
- PDF pipeline fixed in `build_pdfs.py`: `protect_angle()` escapes non-HTML `<Tag>` text (a raw `MonoBehaviour<Script>` had swallowed the rest of the primer), the stray `@page { size: A4; }` is gone so landscape works, images are capped by page height. Verified: `01-re-primer-glossary.pdf` = 2 pages, `levels_05_Nordfels.pdf` = 8 landscape pages with the map on one page. The other PDFs and `Thronefall-Reference-Handbook.pdf` are NOT built yet.
- Independent fact-checks (claim by claim, corrections applied, `Verification log` appended): `mechanics/01` = 296 claims (270 supported / 25 partial / 0 wrong / 1 cannot-verify); `mechanics/02` = 351 claims (327 / 12 / 10 / 2). **`mechanics/03` (combat) and `mechanics/04` (flow/UI) were NOT fact-checked**: their verifier agents were stopped before applying any edit. Re-run a verifier on each.
- New `tools/refpack/analyze_bot_behaviour.py` -> `reference/verification/bot_behaviour.json` and `reference/docs/generated/bot_behaviour.md` (re-run any time; reads `BepInEx/plugins/bot-log.jsonl`). Probes in `tools/refpack/probes/`.

**Measured findings about the bot** (snapshot: 73k log rows, 38 launches, 33 analysable, plus 15 `agent/runs` recorder runs). Use them in `09-autonomy-guide.md`.
1. Start gold + cumulative wave `goldCoins` from `data/levels` predicts the observed gold+coins at each dusk exactly (Nordfels 13 of 13 dusks: 8, 13, 18, 23 ... 96; Durststein 16, 19, 23, 26). This validates those data against the live game, and it shows the bot spent nothing: implied spend <= 1 gold in 22 of the 26 sessions that reached a dusk (others: 2, 2, 3, and 16-19 in the Durststein tail of the 91-min session, so purchases can happen).
2. The first night starts 8.3-9.2 s after the level loads in 24 of 26 sessions (15.8 s and 48.3 s in the others): `build-stall`, then `switch-night`.
3. `ally` = 0 on every night tick of all 15 recorder runs: the bot never had troops (it did not "forget to bring them"). The game's army flow: CommandUnits, hold to gather units within `attractRange` 6, release, walk, press again to place; `holdToHoldPositionTime` 0.5 s (`mechanics/03` section e).
4. Night knock-outs: 172 (day: 0, the day is invulnerable). Duration p10/p50/p90 = 10.9 / 11.0 / 11.1 s (n = 120) = shipped `AutoRevive.reviveAfterBeingKnockedOutFor` 11.0 s. The "stands still at night" stretches are knock-out waits. Hero `maxHp` 50, regen 5 HP/s after 1 s.
5. Old sessions fought 50-90 m from the castle (session 0: median 75 m, 86 % of night ticks > 50 m); recent ones stay 3-13 m from it. Terrain model check: every logged Durststein hero position is <= 2 m from the modelled nav surface (86.0 % on it, 10.5 % within 0.5 m, 1.6 % within 1 m, 1.9 % within 2 m, 0 % beyond); Nordfels: 74 of 29,963 ticks are 2-20 m outside it, around (-55, 5) (west shore), so the map is conservative there.
6. HYPOTHESIS, NOT VERIFIED, for 1-2: `Bot.Execute(PumpHold)` calls `BuildingInteractor.InteractionHold` once per 0.25 s decision tick, but each call fills only `Time.deltaTime * n / TotalFillTime` (`CostDisplay.FillUp`, mechanics/02 F11): about 16 calls (about 4 s) per coin at cost 3. The bot releases after about 3 s (`build-hold` every 3.1 s) and release refunds the paid slot (`CancelFill`, mechanics/02 F14), so progress is lost; a refunded 1-gold dip was seen (Castle Center, gold 19 -> 18 -> 19). Cheap test: pump `InteractionHold` every frame from `Update` and log the filled slots.

**Still to do, in priority order**
1. Write `09-autonomy-guide.md` (findings above + `generated/bot_behaviour.md` + mechanics 01-04 sections e/f/h + level handbooks) and `12-verification-and-coverage.md` (layouts 655,330/655,330 and 655,157/655,157 byte-exact; 37/37 scenes; telemetry; drift; the gold-prediction check; limits: DLC maps absent, runtime RNG, screen coordinates, Totend multi-storey).
2. Write `00-README-INDEX.md`, `03-architecture-and-game-loop.md` (diagrams), `05-action-map.md` (controls.json + interaction gates), `10-forward-model-spec.md` (economy is a per-night recurrence: gold(k+1) = gold(k) - purchases + sum of built income paid at dawn + coins(k); finding 1 validates the coin and start terms).
3. Fact-check `mechanics/03` and `mechanics/04`; fold the corrections in.
4. Update `verify_terrain.py` (stale v1 keys; use `walkableStaticRLE` / `navSurfaceRLE` or the .npz), re-run `validate_against_telemetry.py` (add distance-to-surface percentiles) and `build_map_docs.py`.
5. `python build_pdfs.py` (all docs + combined handbook), inspect pages with pypdfium2.
6. Add `run_all.ps1`; send the Hermes completion message; release the locks; final report to the user.

**Coordination.** A message with findings 1-4 and 6 was sent (or attempted) to `devin-cli` at the end of session 2; check the Hermes inbox (`owner: claude-refpack`) first and re-send if nothing was acknowledged.
