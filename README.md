# Thronefall Trainer

An in-game trainer/overlay for **Thronefall** (Unity 2022.3 Mono build), implemented as a
[BepInEx 5](https://github.com/BepInEx/BepInEx) plugin. All cheats are driven by the game's
own managed APIs (found by decompiling `Assembly-CSharp.dll`), not fragile memory scanning.

## Controls

| Key | Action |
|-----|--------|
| `F1` | Show/hide the overlay (hero is frozen while it is open so typing doesn't steer him) |
| `F2` | Kill all enemies |
| `F3` | Revive all units & buildings |
| `F4` | +100 gold |
| `F5` | Teleport hero to the mouse cursor |

**Overlay window:** drag the **title bar** to move it, drag the `=` grip in the
bottom-right corner to resize, `[-]` collapses it to a title bar, `[x]` or `F1`
hides it, and `S` opens **overlay settings** — opacity slider, 6 color themes
(Dark / Gold / Arcane / Forest / Ember / Ice), and window-position reset.
Text fields apply on **Enter** (while that field is focused) — sliders apply
live while dragged. All toggles, theme, and opacity persist in
`BepInEx\config\dev.thronefall.trainer.cfg` between launches.

## Features

### Resources
- Live gold / energy-core display; set an exact value or add 100 / 1k / 10k.

### Protection
- **God mode - hero** — hero takes zero damage.
- **God mode - units & buildings** — every `PlayerOwned` object is immune (covers new spawns).
- **Instant hero revive** — knockout timer reduced to ~0 (`AutoRevive.reviveAfterBeingKnockedOutFor`).
- **HP regen multiplier** — scales `PlayerUpgradeManager.PlayerHealthRegenerationMultiplyer`.

### Economy
- **Free build** — coin *and* energy-core spends are no-ops; a floor of 1 is kept
  so payments still work at 0 gold.
- **Instant build** — each hold-to-pay frame fills a whole coin slot (`Coinslot.AddFill` patch).
- **Coin magnet** — adjustable pickup radius (`coinMagnetRadius`).
- **Harvest all income** — `SetHarvested(false)` + `Harvest(...)` on every
  `playerBuildingInteractor` (repeatable = infinite re-harvest).
- **Coin fountain** — `CoinSpawner.TriggerCoinSpawn(100, player)` spawns real coins
  that magnet to the hero.
- **Charge shrines** — `Shrine.MakeProgressAndUpdateBar(99999)` on every shrine →
  instant activation (income + power).

### Combat
- **Damage multiplier** — all player-caused damage ×N.
- **Instant kill** — one-hit kills.
- **Attack speed multiplier** — divides `cooldownTime` on every hero `ManualAttack`
  (weapon + ability components).
- **No cooldown** — forces `Cooldown = 0` every frame.
- **Multi-shot** — every `Weapon.Attack` call is exactly one projectile, so a
  reentrancy-guarded prefix on `Weapon.Attack` re-enters it N-1 extra times for any
  `PlayerOwned` attacker → the hero, towers, and troops all fire N shots per attack
  (slider 1–15). Inner calls are try/caught so projectile-pool exhaustion just stops
  the extras instead of erroring.

### Enemies
- **Enemy speed slider** (0–3×) — writes `PathfindMovementEnemy.movementSpeed` on all
  `EnemyUnits` at ~4 Hz; **0 = completely frozen** (also works on bosses).
- **Enemy damage slider** (0–2×) — scales enemy→player-side damage in `Hp.TakeDamage`;
  **0 = enemies are harmless**.
- **Enemy HP at spawn** (0.1–3×) — postfix on `Hp.Start` → `ScaleHp` for `EnemyOwned` spawns.
- **Endless waves** — sets `EnemySpawner.instance.InfinitelySpawning` (current wave repeats).
- Buttons: kill all enemies, halve all enemy HP now, stop spawning
  (`StopSpawnAfterWaveAndReset`), revive all units & buildings.
- **Charm all enemies** — retags every enemy `PlayerOwned` and rewrites its
  `AutoAttack`/`PathfindMovementEnemy` `TargetPriority.mustHaveTags` to hunt
  `EnemyOwned` → they fight their own wave. (Per-component serialized lists, so
  only that unit is affected. Retagged enemies leave the enemy count — charming
  everything mid-spawn can end the wave early.)

### Army
- **Command range slider** — `CommandUnits.instance.attractRange`; command the whole map's army.
- **Fast unit respawn** — `BlacksmithUpgrades.instance.unitRespawnSpeedMulti` × 50.
- **Clone a random troop ×5** — `Object.Instantiate`s a living `PlayerUnit` next to the hero
  (auto-registers with `TagManager`; gets `HomePosition` + `SnapToNavmesh`). Experimental.
- **Build/upgrade ALL slots (free)** — calls `BuildSlot.DEBUGUpgradeToMax()` on every
  `BuildSlot` (the game's own debug function; bypasses cost entirely).
- **Ally damage multiplier** — `BlacksmithUpgrades.meleeDamage`/`rangedDamage` are
  sampled per-hit in `Weapon.cs`, so this buffs every player weapon live (1–50×).
- **Ally attack speed** — divides `cooldownDuration` on every `PlayerOwned` `AutoAttack`
  (troops and towers), scanned at ~4 Hz; originals restored when toggled off.

### World / time
- **Move speed multiplier** — walk/day-walk/sprint/day-sprint.
- **Game speed** — `Time.timeScale` override (clamped 0.1–10; pause menu still works).
- **Endless day** — holds `DayNightCycle`'s private `remainingAutoDayTime` high.
- **Zoom multiplier** — scales the `CameraRig` `zoomLevels` table (each zoom notch × mult).
- **Reveal map** — sets `VisionSource.Scale` to ~99 999 on every fog-of-war source
  (`KB.FogRTS.Runtime`); originals restored on toggle-off.
- **Never lose** — Harmony prefix on `LocalGamestate.SetState` skips
  `AfterMatchDefeat`. Every defeat path (castle destroyed, resign, Eternal Trials
  night-load) funnels through it, so the run literally cannot end in defeat
  (side effect: the resign button becomes a no-op while enabled).
- Buttons: skip wave (`DebugSkipWave`), spawn next wave (`StartSpawning`),
  start night (`SwitchToNight`), back to day (`SwithToDay`), teleport to mouse (F5),
  **Win level** (`SetState(AfterMatchVictory)` — legit transition: marks the level
  beaten, banks the run, and shows the victory screen).

### Meta / progression — writes the save file
- **Unlock all levels & crowns** — sets `beatenBest`, maxes `highscoreBest`, and fabricates
  `levelHasBeenBeatenWith` entries satisfying `BeatTheLevelWith`/`BeatTheLevelWithout` quests
  on every `LevelInfo`, then `SaveLoadManager.SaveGame()`.
- **Unlock all perks/gear** — `PerkManager.instance.level = PerkManager.MaxLevel` (1 000 000),
  covering every meta-level unlock requirement; campaign-gated gear is covered by the level unlock.
- **+1,000,000 score** — `ScoreManager.Instance.AddDebugPoints` (a shipped debug method).
- **Equip ALL perks (mid-run)** — `PerkManager.SetEquipped` on every `EquippablePerk`
  and `EquippableMutation`. Effects sampled dynamically (per-hit getters like
  `riskTaker`, `iceMagic`, score mutators) apply immediately; perks that cached
  state at scene `Start` (health potions, elite towers) take effect next run.
- **Unlock achievements** — loops all 34 `AchievementManager.Achievements` values
  through `UnlockAchievement`.

## How it works

| Cheat | Mechanism |
|-------|-----------|
| God mode / damage mult / instant kill / enemy dmg | Prefix on `Hp.TakeDamage` — `TaggedObject` tag checks (`Player`, `PlayerOwned`, `EnemyOwned`) then block or scale `_amount` |
| Free build | Prefix on `PlayerInteraction.SpendCoins`/`SpendEnergyCores` → skip; `Update()` keeps balance floor of 1 (`BuildingInteractor` requires `Balance > 0`) |
| Instant build | Prefix on `Coinslot.AddFill` → force `percentage = 1` |
| Enemy HP scaling | Postfix on `Hp.Start` → `ScaleHp(mult)` for `EnemyOwned` spawns (covers all spawn paths) |
| Everything else | Direct calls into game singletons: `PlayerInteraction.instance`, `PlayerMovement.instance`, `TagManager.instance`, `EnemySpawner.instance`, `DayNightCycle.Instance`, `PerkManager.instance`, `LevelProgressManager.instance`, `ScoreManager.Instance`, `SaveLoadManager.instance`, `CommandUnits.instance`, `BlacksmithUpgrades.instance` |

The shipped binary also contains a **stripped dev cheat-menu skeleton**
(`CheatSystem`, `CheatMenuIMGUI`, `CheatMenuBootstrap` — registration compiled out in
release) whose documented dev hotkeys confirm this cheat list: addCoin, killAllEnemyUnits,
reviveAllYourUnits, upgradeAllBuildingsToMax, spawnNextWave, instaWinLevel.

## Install

1. Download **BepInEx 5 x64** (`BepInEx_win_x64_5.4.23.x.zip` from the
   [BepInEx releases](https://github.com/BepInEx/BepInEx/releases)) and extract it into
   the game root (next to `thronefall.exe`). Run the game once so BepInEx generates its folders.
2. Place `ThronefallTrainer.dll` into `BepInEx\plugins\`.
3. Launch the game and press **F1**. Plugin logs land in `BepInEx\LogOutput.log`.

To uninstall: delete `winhttp.dll`, `doorstop_config.ini` and the `BepInEx` folder
in the game root.

## Build

Requires the .NET SDK. The project references the game's own DLLs via the `GameDir`
MSBuild property — it defaults to `..\..`, i.e. this repo is expected at
`<game root>\Trainer`:

```powershell
cd Trainer\src
dotnet build -c Release                                  # default layout
dotnet build -c Release -p:GameDir="K:\Games\Thronefall" # cloned elsewhere
.\tools\build-and-deploy.ps1                             # build + copy into BepInEx\plugins
```

`src/ThronefallTrainer.csproj` targets `net472` and references `Thronefall_Data/Managed`
(`Assembly-CSharp.dll`, `UnityEngine.*`, `KB.FogRTS.Runtime`, `AstarPathfindingProject`)
plus `BepInEx/core` — no gameplay NuGet dependencies.

To regenerate the decompiled reference source (needed after game updates):
`.\tools\decompile.ps1` (requires `dotnet tool install -g ilspycmd`).

## Notes / maintenance

- **Game updates**: if a patch renames members (`PlayerInteraction.balance`,
  `Hp.TakeDamage`, `TagManager.ETag`, `DayNightCycle.remainingAutoDayTime`,
  `CameraRig.zoomLevels`), rebuild after re-checking `Trainer\decompiled\`
  (regenerate with `ilspycmd -p -o Trainer\decompiled <Assembly-CSharp.dll>`).
- **Harmony vs. direct calls**: prefer Harmony prefixes on choke-point methods
  (`TakeDamage`, `AddFill`, `Hp.Start`) for continuous effects — they automatically
  cover objects spawned later. `Update()` writes are used for values the game reads
  every frame (speed fields, timescale, timers).
- The overlay is Unity IMGUI (`OnGUI`). `GUI.SetNextControlName` +
  `GUI.GetNameOfFocusedControl` gate Enter-key application so only the focused field
  is applied. The resize drag is handled in `OnGUI` screen space (not inside the
  window callback) because IMGUI windows stop receiving mouse events once the cursor
  leaves the window mid-drag.
- `LocalGamestate.Instance.SetPlayerFreezeState` freezes the hero while the menu is
  open; without it, WASD/E keypresses in text fields move and attack.
