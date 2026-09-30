# Configuration Reference

File: `BepInEx\config\ThronefallTrainer.cfg` (auto-generated on first run; edit
while the game is **closed**, or via the F1 overlay which writes back live).

## Persistence semantics

- Config = **startup defaults**. At `Awake`, each `cfg*.Value` seeds `Cheats.*`.
- Overlay toggles/sliders change the **live session** (`Cheats.*`) but are not
  written back — they reset to config values on next launch.
- **Exception:** `Bot.AutopilotEnabled` is written back when you press **F6**,
  so the bot resumes across restarts.
- `Bot.BotSurvivalCheats` (default **`false`**) controls whether enabling the bot
  force-applies the survival bundle (god, regen, magnet, instant-kill,
  no-cooldown). Previous cheat states are snapshotted and **restored on F6-off**
  (conditional: only flags still holding the forced value roll back).
  It also drives `Bot.Legit` (`= !BotSurvivalCheats`): bundle ON unlocks the
  bot's own power shortcuts (direct `Attack()` calls, `TakeDamage` fallbacks,
  teleport nudges); bundle OFF means the bot plays by player rules —
  `TryToAttack()` cooldowns, navmesh/sidestep movement, army via
  `CommandUnits`. See `AUTOPILOT.md §1`. While `Bot.Legit`, F2–F5 hotkeys
  and every GUI cheat control are locked; `Economy.GoldDrip` is force-bypassed
  (wallet injection is a cheat, not tuning).

## Bot

| Key | Default | Effect |
|---|---|---|
| `Bot.AutopilotEnabled` | `false` | Bot active at launch (same as pressing F6) |
| `Bot.BotSurvivalCheats` | `false` | Survival bundle on bot enable; `false` = `Bot.Legit` — bot obeys player rules (see AUTOPILOT §1). **Legit is the default.** |

## Coach

| Key | Default | Effect |
|---|---|---|
| `Coach.Enabled` | `true` | Polls `agent/coach-commands.json` each tick (server `tools/coach-server.py` writes it) |
| `Coach.Url` | `http://127.0.0.1:1234/v1/chat/completions` | Local advisor (OpenAI-compatible) endpoint |
| `Coach.ApiKey` | `""` | Bearer token for the local endpoint, if required |
| `Coach.Model` | `kat-coder-v2.5-dev-apex` | Model name sent in the request JSON |
| `Coach.VisionEnabled` | `false` | Send one defeat screenshot to `Coach.Url` (vision-capable model) for post-fail analysis |
| `Coach.VisionModel` | `qwen3-vl-2b-thinking-abliterated` | Vision model name |
| `Coach.LiveShot` | `true` | Periodic `agent/live.png` screen capture for the server UI |

## Protection

| Key | Default | Effect |
|---|---|---|
| `Protection.GodHero` | `false` | Hero takes no damage |
| `Protection.GodAll` | `false` | All `Player`/`PlayerOwned` objects take no damage |
| `Protection.InstantRevive` | `false` | Hero/units revive instantly |
| `Protection.NeverLose` | `false` | `LocalGamestate.SetState` can't enter defeat states (disables resign while on) |

## Economy

| Key | Default | Effect |
|---|---|---|
| `Economy.FreeBuild` | `false` | `SpendCoins`/`SpendEnergyCores` become no-ops; `Update()` keeps a balance floor of 1 (holds require `Balance > 0`) |
| `Economy.InstantBuild` | `false` | `Coinslot.AddFill` forced to 100 % — builds/upgrades complete instantly |
| `Economy.CoinMagnet` | `false` | Coins fly to the hero |
| `Economy.MagnetRadius` | `250` | Magnet radius (m); the bot bundle raises this to ≥ 500 |
| `Economy.GoldDrip` | `false` | Pins wallet ≥500 / cores ≥20 in `Update` — **suppressed while `Bot.Legit`** (autopilot legit mode bypasses it regardless of the toggle) |

## Combat

| Key | Default | Effect |
|---|---|---|
| `Combat.InstantKill` | `false` | Player-caused damage set to target max HP |
| `Combat.DamageMultEnabled` | `false` | Enable `DamageMultiplier` |
| `Combat.DamageMultiplier` | `10` | Scales player damage |
| `Combat.NoCooldown` | `false` | Hero attack cooldown removed |
| `Combat.AttackSpeedEnabled` | `false` | Enable `AttackSpeedMult` |
| `Combat.AttackSpeedMult` | `2` | Hero attack-speed multiplier |
| `Combat.RegenEnabled` | `false` | Enable `RegenMult` HP regen |
| `Combat.RegenMult` | `5` | HP/s regen on hero |
| `Combat.MultiShot` | `false` | `Weapon.Attack` fires `MultiShotCount` extra times (reentrancy-guarded) |
| `Combat.MultiShotCount` | `3` | Extra shots per attack |

## Enemies

| Key | Default | Effect |
|---|---|---|
| `Enemies.EnemySpeedEnabled` / `EnemySpeedMult` | `false` / `1` | Enemy move speed scaling |
| `Enemies.EnemyDamageEnabled` / `EnemyDamageMult` | `false` / `1` | Incoming damage scaling |
| `Enemies.EnemyHpEnabled` / `EnemyHpMult` | `false` / `1` | Postfix on `Hp.Start` → `ScaleHp` for `EnemyOwned` spawns |
| `Enemies.EndlessWaves` | `false` | Waves keep spawning after the last scripted wave |

## Army

| Key | Default | Effect |
|---|---|---|
| `Army.CommandRangeEnabled` / `CommandRange` | `false` / `500` | Unit command radius |
| `Army.FastRespawn` | `false` | Faster unit respawn at dawn |
| `Army.AllyDmgEnabled` / `AllyDmgMult` | `false` / `5` | Ally damage multiplier |
| `Army.AllyAspdEnabled` / `AllyAspdMult` | `false` / `3` | Ally attack-speed multiplier |

## Movement / Time / Camera / Overlay

| Key | Default | Effect |
|---|---|---|
| `Movement.MoveSpeedEnabled` / `MoveSpeedMult` | `false` / `2` | Hero move-speed multiplier |
| `Time.GameSpeedEnabled` / `GameSpeedMult` | `false` / `2` | `Time.timeScale` override |
| `Time.EndlessDay` | `false` | Day phase never auto-ends |
| `Camera.ZoomEnabled` / `ZoomMult` | `false` / `1.5` | Extra zoom range via `CameraRig.zoomLevels` |
| `Camera.RevealMap` | `false` | Fog-of-war reveal |
| `Overlay.Opacity` | `1` | Overlay alpha (clamped 0.2–1) |
| `Overlay.ThemeIndex` | `0` | Overlay theme index (clamped to `Themes.Length-1`) |

## Notes

- Meta/progression overlay buttons (score, unlocks, resources) have **no** config
  entries — they apply once and write the save file immediately.
- Hotkeys: **F1** cheat menu · **F2** kill · **F3** revive · **F4** +100 gold ·
  **F5** teleport-to-mouse · **F6** autopilot · **F8** live bot overlay panel.
  **F2–F5 are suppressed while `Bot.Legit` is active** (autopilot legit mode) —
  the GUI cheat controls are locked the same way.
- `Army.FastRespawn` is a known legit-mode edge: it is a game-mechanics bypass
  (respawn time), not gated by `Bot.Legit` yet — leave it `false` for legit runs.
- After a game update, member names may change — invalid values in the cfg are
  coerced by BepInEx; missing keys are recreated with defaults.
