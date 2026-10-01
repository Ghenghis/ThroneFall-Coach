# 01 - Waves, spawning, day/night cycle

Source: `decompiled/*.cs` (Unity 2022.3 Mono), static reading. Citations: `File.cs:line`. `wn` = `EnemySpawner.wavenumber`. "Night index" is 0-based; the UI's "Night N" is `index+1` (`EnemySpawner.cs:642`). All timers use scaled `Time.deltaTime`; a UI frame with `freezeTime` sets `timeScale=0` (`UIFrameManager.cs:237-240`); the player can toggle 1x/2x (`PlayerMovement.cs:99-113`).

## (a) Facts from code

**Data and numbering**
- F1. `Wave` = `spawns` + `difficultyMulti` (default 1); `warningText` is never read (`Wave.cs:9-13`). `Spawn` = `delay, enemyPrefab, eliteEnemies, count, interval, spawnLine, goldCoins` (`Spawn.cs:8-20`).
- F2. Wave source (`EnemySpawner.cs:286-309`): ET mode + `waveGeneratorScript` -> `GenerateWaves(lines, levelInfo, run.stage, out gold, run.currentStageSeed)`; else `endlessMode` + `endlessModeWaveGeneratorScript` -> generated with stage 3 and `endlessSeed`; else the serialized `waves`. Mode = `LocalGamestate.SelectedGameMode` if set (`:260-267`).
- F3. `wn` starts at -1 (`:32,277`); `StartSpawning` does `wn++` then clamps to `[0,Count-1]` (`:553-554`); `wn` is saved/restored (`:232-243,282-285`). Debug start-wave is dead (`DebugController.cs:114` returns -1).
- F4. Preview/marker index = `wn+1` by day, `wn` by night (`EnemySpawner.cs:449,600-611,622-633`; `PauseUILoadoutHelper.cs:63-71`). `MatchOver` = `wn>=Count-1 && !spawning`; `FinalWaveComingUp(w)` = `w==Count-2`; `PreFinalWaveComingUp` = `wn==Count-3`; `LevelBeatenAsSoonAsWaveFinished` = `wn>Count-2` (`:81-124`).
- F5. Generated waves use the `EnemySpawnLine` components under the spawner (`:293,308`): flags `canSpawnFlying/SmallGround/BigGround`; `difficulty` enum -> budget multiplier 1.15 easier / 0.85 harder / 1.0 (`EnemySpawnLine.cs:6-31`), but that multiplier is read only by `SuperWaveGen` (`SuperWaveGen.cs:771`; the `mostlySharedAttackpaths`/`mostlySeperatedAttackPaths` lists likewise, `:754-756`); Endless, SeasonTwo and Pauls use just the `can*` flags. A spawn line's child transforms are its polyline nodes (`Spawn.cs:274-308`).

**Spawn loop**
- F6. `Spawn.Update`: `wait -= dt`; when `<=0`, `wait = interval` and exactly one unit spawns (no carry-over: max one per Spawn per frame). First spawn after `delay`; a Spawn finishes after `count` units; `Wave.HasFinished` = all Spawns finished (`Spawn.cs:105-116,268-271`; `Wave.cs:46-61`). `Wave.Reset` re-arms every Spawn at dusk (`EnemySpawner.cs:555`; `Spawn.cs:74-103`). `count` 0 still spawns one unit (check follows the spawn, `:266-271`).
- F7. While spawning, each frame: if `numberOfEnemiesOnTheMap < pauseSpawningAtEnemyCount` the wave updates and may finish; otherwise all spawn timers freeze (`EnemySpawner.cs:396-416`). Default 275, clamped to 200 in `Start` (`:48-49,256-259`). The count is every `EnemyOwned`-tagged object (`:391,417`; `TagManager.cs:434-437`).
- F8. With 0 enemies on the map, `Wave.ReduceMaxDelayTillNextSpawn` subtracts `(smallest unfinished wait - 5 s)` from every unfinished Spawn, so the next spawn is at most 5 s away (`EnemySpawner.cs:418-421`; `Wave.cs:63-82`). `reduceSpawnWaitTimes` (`:72-73`) is read nowhere in the 3,056 decompiled files (grep): no effect; the reduction is unconditional.
- F9. `InfinitelySpawning` (restart wave on empty field) is set only by the tutorial (`EnemySpawner.cs:401-410`; `TutorialManager.cs:401`).
- F10. Spawn point: uniform-by-length random point on the line polyline, `+5` y if flying; fewer than 2 nodes -> first node (still `+5` if flying), or the line transform itself when it has no children (no `+5`) (`Spawn.cs:274-298`). The constraint chosen at `:125-133` is unused by that function. Units snap to their own Seeker graph in `Start` (`PathfindMovementEnemy.cs:133,151`). The three `NNConstraint`s (graphs "Enemy Units Air/S/L", `EnemySpawner.cs:252-254`) matter only through `GetValidSpawnPointForEnemy` (`:132-144`; sole caller `FinalBossDragon.cs:124,129`).
- F11. A prefab without `TaggedObject` is only `SetActive(true)`d; a prefab that is a loaded scene object is activated, not cloned (`Spawn.cs:117-123,143-148`).
- F12. `totalEnemiesSpawnedThisWave` resets at dusk and increments per spawn (`EnemySpawner.cs:526`; `Spawn.cs:266`); melee units seeing an odd value in `Start` begin on `backupMovementGraph` (`PathfindMovementEnemy.cs:147-150`).

**Unit scaling and wave edits**
- F13. HP factor `H = difficultyMulti x perks` (x4 if elite); damage factor `D = lerp(1,difficultyMulti,0.5) x perks` (x3 if elite) (`Spawn.cs:163-183,225-265`). Perk terms: Turtle(H), Tiger(D), Falcon(speed, chase time), AntiAir(flying: H,D), WarGods(H,D), Growth (`max^(wn/(Count-1))`), RangeGod (ranged non-flying: H,D,cooldown,speed,range), Chaos (non-`Exploding` units: spawn lerped toward castle by `(i%5)/5`; initial attack cooldown set to 3 s via `AutoAttack.SetCooldownTo`, `AutoAttack.cs:75-79`, `cooldownDuration` unchanged), Afterlife (even-indexed Humanoids spawn an extra enemy on death) (`:135-224`; values `PerkManager.cs:63-83,182-214,249-272`). `Hp.enemyToSpawnOnDeath` spawns before destroy (`Hp.cs:398-401`).
- F14. Level-start wave edits: EliteGod (every N-th non-elite Spawn becomes elite), RatGod (gold x modifier with carry), Loan (+start gold, interest deducted from early enemy gold), RoyalMint (+start gold), CheeseGod (first `cheeseGod_affectedNights` nights: count x2, interval and delay /1.25) (`EnemySpawner.cs:310-382`).

**Gold**
- F15. A Spawn's `goldCoins` are randomly spread over its units (`Spawn.cs:90-101`); each unit's `Hp.coinCount` (`:159-162`) coins drop on death (`Hp.cs:413-426`); 1 coin = 1 gold (`Coin.cs:114`; `PlayerInteraction.cs:263-268`). Start gold `goldBalanceAtStart` (default 10) is added in `Start` unless the match is loaded from a save (`EnemySpawner.cs:18,232-237,360-367`).
- F16. Building income is harvested automatically after sunrise, 1 coin per `CoinSpawner.interval` (default 0.5 s) per building (`BuildingInteractor.cs:297-300`; `CoinSpawner.cs:9,55-70`); a building knocked out during the night is denied the next dawn's income (`BuildingInteractor.cs:92-98,170,286-290,435-441`). InterestPerk (if equipped) pays `min(20, ceil(balance/3))` at dusk, serialized defaults (`InterestPerk.cs:12-16,47-62`). TreasureHunter pays 15/25/40 at day start when `wn` = Count-4/-3/-2 (`EnemySpawner.cs:431-442,501-520`; shipped values `data/balance_sheet.json` `PerkManager.PerkManager.treasureHunterGoldAmountWave1/2/3`; the code defaults at `PerkManager.cs:140-146` are 10/20/30).

**Night start, end, victory**
- F17. Night starts by: (1) Nighthorn interact - if `AllCoinsHarvested` it blows, else it harvests everything and returns (`Nighthorn.cs:44-67,97-121`); (2) holding Call Night for `nightCallTime` (code default 1 s; 2.0 s in all 37 extracted levels, `data/levels/*.json` `nightCall[0].nightCallTime`) when `IsFreeToCallNight` and day is not automated (`NightCall.cs:11,73-87`); (3) automated day timer reaching 0 with a castle present (`DayNightCycle.cs:116-129`; `AutoDayNight.cs:6-12`). `IsFreeToCallNight` = not frozen, nothing focused, castle exists, tutorial permits, `!MatchOver`, InMatch (`PlayerInteraction.cs:77-87`).
- F18. `SwitchToNight`: state Night, then `DuskCall`: stopwatch reset, player-owned units vulnerable, `OnDuskEarly` then `OnDusk` on all (`DayNightCycle.cs:215-261,301-309`). `EnemySpawner.OnDusk` -> reset counters, destroy markers, `StartSpawning` (`EnemySpawner.cs:522-529,586-589`). Building interaction is disabled at night (`BuildingInteractor.cs:286-290,327-329`); `AutoAttack` runs only at night (`AutoAttack.cs:89-92`).
- F19. Night ends when `Night && !SpawningInProgress && NumberOfEnemiesOnTheMap<=0` (`DayNightCycle.cs:112-115`); or (level-specific) automated night timer (`:130-138`; shipped only in `29_Freifort_MM1`, 240 s, and `40_Wildbach_MM3`, 120 s); or 2 s after an `OnDeathStartNextDay` Hp dies (`OnDeathStartNextDay.cs:11-20`). `AutoKillAllEnemiesBeforeSunrise` (if present) kills all enemies at dawn (`AutoKillAllEnemiesBeforeSunrise.cs:14-17`). `TieBreaker`: after spawning ends, 30 s with unchanged enemy and building counts and no Boss -> 10 dmg/s to one enemy until dawn (`TieBreaker.cs:7-10,71-110`).
- F20. Dawn (`DayNightCycle.cs:141-213,279-299`): state Day; `OnDawn_BeforeSunrise` (score tally `ScoreManager.cs:157-199`, `harvestedToday=false`); wait `sunriseTime` (code default 2.5 s; 3.0 s in all 37 extracted levels, `data/levels/*.json` `dayNight[0].sunriseTime`); `OnDawn_AfterSunrise`: revive all player-owned (invulnerable by day), building harvest, `OnStartOfTheDay` (markers, treasure hunter), horn reactivates, free coins fly to the hero, autosave 4 frames later unless `wn>=Count-1` (`EnemySpawner.cs:424-445`; `Nighthorn.cs:123-126`; `LocalMatchSaveLoad.cs:38,102-113`).
- F21. Victory: after the sunrise wait, `wn>=Count-1` -> `AfterMatchVictory` (`DayNightCycle.cs:293-296`), the only victory path in scope (grep); end screen after 1 s (`LocalGamestate.cs:127-157`). Defeat: an `objectsThatTriggerLoseWhenDestroyed` Hp killed/knocked out, resign, or ET reload while `inNight` (`LocalGamestate.cs:33,83-89,159-165`; `InMatchResignHelper.cs:26`; `LocalMatchSaveLoad.cs:28-31,125-132`). Mid-match state is saved only at dawn (`LocalMatchSaveLoad.cs:35-56,102-113`).

**Enemy targeting and movement**
- F22. `FindMoveToTarget` (`PathfindMovementEnemy.cs:207-234`): (1) hit by a Player-tagged attacker within `agroTimeWhenAttackedByPlayer` (5 s) and hero not knocked out -> chase hero (`:101-112`; `Hp.cs:372-375`; hero hits pass the hero as attacker: `ManualAttack.cs:258`, `Weapon.cs:236-241`); (2) else the first `targetPriority` (list order) whose closest match (Euclidean distance; `AUTO_Commanded` excluded, `:136-139`) lies within its `range` (`TargetPriority.cs:299-322`); (3) else walk to the spawn point plus random offset. `maximumDistanceFromHome` is not used on this path.
- F23. Movement: A* path to the snapped target; speed `movementSpeed` (code default 2; prefab values 2-15, e.g. Swordsman 5, Racer/Hunterling 10, Wheel/Small Spider 15: `data/enemy_prefabs.json` `speed`); stops within `keepDistanceOf` (default 2). First path request within 2x`recalculatePathInterval` (1 s) of spawn, then every 2-3 s (1-2 s while chasing) (`:126-131,236-259,266-282`). Attacks use `AutoAttack` priorities, first priority with a target in range (`AutoAttack.cs:123-135`).

**What the player is shown**
- F24. Screen markers per next-night spawn, from `OnStartOfTheDay` until dusk: icon + count summed per (sprite, position, elite) at the midpoint of the line's first/last node; plus a difficulty marker `round((difficultyMulti-1)/0.1)` if `difficultyMulti != 1` (`EnemySpawner.cs:447-499,531-543`).
- F25. Pause-menu preview (`PauseUILoadoutHelper.cs:74-87,171-217`) from `GetWaveInfo` (`EnemySpawner.cs:635-746`): per (icon, name, elite): count, base maxHP, speed, range, damage, cooldown, projectile speed; `goldReward` = sum of `goldCoins`; +% HP/damage; "Night X/Y"; any index `[0,Count-1]`. Counts are sums of `spawn.count`, maxHP is the unscaled prefab value, and spawns whose prefab lacks `ScreenMarkerIcon` are omitted (`:648-656,701-743`); death-spawned and boss-minion units are not included. Income panel adds building income, treasure hunter, interest (`TFUIIncomeDisplay.cs:53-107`).
- F26. Dusk popup `wn+1 / Count` (`WaveCountPopUp.cs:35-50`); horn tooltip differs for pre-final/final night (`Nighthorn.cs:74-89`); automated-day clock (`DayCountdownUI.cs:26-48`). In ET the map-choice screen shows every night's `WaveInfo` and start gold before choosing (`MapChoice.cs:51-60`; `EternalTrialsMapPreview.cs:17-33`; `ETChoicePickScreen.cs:141`).
- F27. Waves also run outside the night loop: `InstantEnemySpawn.SpawnWave` resets a `Wave` and updates it until finished (`InstantEnemySpawn.cs:10-28`); `IronCastleEnemySpawning` updates its three waves once its Hp is below 75/50/25% (`:20-33`); `FinalBossDragon` runs one wave per health segment (`FinalBossDragon.cs:95-120`). Their units delay night end only if the prefab is `EnemyOwned`-tagged (asset data; F19).

## (b) Inferences (not directly stated in code)

- B1. From F22 step 3: an attacker prefab needs a `TargetPriority.range` covering its whole route, or it idles at spawn. Asset check: all 39 enemy prefabs with a `PathfindMovementEnemy` entry in `data/balance_sheet.json` end their `targetPriorities` with a catch-all of range 100000 or 1000000, so none idles while a matching player-owned target exists.
- B2. Vestigial code: the spawn-time `NNConstraint` (F10) and `reduceSpawnWaitTimes` (F8) have no effect; the Seeker snaps units in `Start`.
- B3. `SuperWaveGen`'s "final night x1.05" never applies: it tests `_waveNr == lookup.Count-1` (`SuperWaveGen.cs:776`), but the caller passes `list` before adding the new wave (`:420`), so `Count == _waveNr`.
- B4. `smallGround` = Seeker graph 0 or 1, `bigGround` = graph 2 (`EternalTrialEnemy.cs:94-106`). Confirmed by `data/navmesh/*.json` `graphs[]` (identical in all 37 levels): 0 "Enemy Units S", 1 "Player Units S", 2 "Enemy Units L", 3 "Enemy Units Air"; so small = "Enemy Units S" or "Player Units S", big = "Enemy Units L", and `flying` comes from the `Flying` tag (graph 3 is not consulted).
- B5. F12: the counter is incremented in the same `Spawn.Update` call that instantiates, but `Start` runs later (before the unit's first `Update`), so it sees the running total at that moment: the 1-based spawn ordinal only if nothing else spawned in between (Spawns firing in the same frame, e.g. several `delay=0` Spawns of a generated wave, would all see the same total); odd totals send melee units to the alternate route.
- B6. Enemy coin prefabs presumably set `registerInTagManager` (horn and dawn sweep only `freeCoins`: `Nighthorn.cs:57-63`, `DayNightCycle.cs:170-176`), so leftover drops fly to the hero at dawn.
- B7. Exact spawn coordinates and per-unit coin split are not reproducible from a seed: global `UnityEngine.Random` is consumed by other systems after `InitState`. Composition, lines and per-Spawn gold are seed-determined (Pauls: lines and gold are not).
- B8. Commanded units are skipped for enemy movement targeting only; `AutoAttack` priorities lack the exclusion (`PathfindMovementEnemy.cs:136-139`).
- B9. Hero speed 14 at night / 18.2 by day, sprint 23 / 29.9 (`PlayerMovement.cs:14-20,224`; shipped values `data/levels/*.json` `heroes[0].movement`) versus enemy `movementSpeed` 2-15 (F23): at night the hero outruns every enemy only while sprinting (23 > 15); walking (14) it is no faster than Medium Spider (14) and slower than Wheel and Small Spider (15).
- Resolved from asset data (details in the Verification log): the generator asset per level (`Season2 Wave Gen` in all 37 levels, `Endless Mode Wave Gen` only in `35_Totend_MM1`); the Iron Castle and Ghostqueen prefabs carry `EnemyOwned` + `Boss` (so they block night end and, wherever a TieBreaker exists, keep its timer at 0); `AutoDayNight` exists only in `14_Durststein_Speedrun`, `29_Freifort_MM1` and `40_Wildbach_MM3`; `OnDeathStartNextDay` sits on the hero of `29_Freifort_MM1` only.
- Still unresolved (not in the extracted data): the enemy set per level; where `TieBreaker` and `AutoKillAllEnemiesBeforeSunrise` are placed; what `objectsThatTriggerLoseWhenDestroyed` contains; coin prefab flags; whether units added by summoning circles are `EnemyOwned`.

## (c) State machine, timeline, formulas

### C1. One day + night cycle

| State | Entered by | Exact behavior |
|---|---|---|
| START | scene load | Day, `afterSunrise=true`, `wn=-1`, start gold added, markers for `waves[0]` (`DayNightCycle.cs:30-36`; `EnemySpawner.cs:277,360-367,383`) |
| DAWN_WAIT | night end | Day but `afterSunrise=false` for `sunriseTime` (3.0 s shipped, code default 2.5 s); horn hidden, markers absent, player units still down; auto-day countdown already running (`DayNightCycle.cs:28,116-119,190-213,279-292`; `Nighthorn.cs:123-132`) |
| DAY | `DawnCallAfterSunrise` | building/upgrading allowed; income harvested; markers show index `wn+1`; exits via horn, Call Night, or auto timer (`dayLength` code default 15 s, `AutoDayNight.cs:8`; shipped auto-day only in `14_Durststein_Speedrun`, 20 s) (F16-F20) |
| DUSK | `SwitchToNight` | same frame: units vulnerable, `OnDusk` handlers, `StartSpawning` (`wn++`), interest if equipped, popup (F16, F18, F26) |
| NIGHT_SPAWN | `spawningInProgress` | Spawns run; field empty -> first spawn <=5 s after dusk; ends when all Spawns finished (F6-F8) |
| NIGHT_CLEAN | `!spawning` | until enemies == 0; TieBreaker if present (F19) |
| exits | | enemies==0 -> DAWN_WAIT, then VICTORY if `wn>=Count-1`; DEFEAT anytime (F21) |

### C2. Numbering (level with N nights)

| Phase | `wn` | Index shown by markers/preview | UI |
|---|---|---|---|
| First day | -1 | 0 | Night 1/N |
| Night k (1..N) | k-1 | k-1 (current) | popup k/N |
| Day after night k<N | k-1 | k | Night k+1/N |
| Day before final (`FinalWaveComingUp`) | N-2 | N-1 | Night N/N |
| Final night | N-1 | - | popup N/N |
| Dawn after final | N-1 | none (`EnemySpawner.cs:427-430`); out-of-range `GetWaveInfo` returns an empty `WaveInfo` (`:637-640`) | victory after `sunriseTime` (3.0 s) |

### C3. Timers and constants

Sunrise wait 3.0 s in all shipped levels (code default 2.5 s, `DayNightCycle.cs:28`); Call Night hold 2.0 s in all shipped levels (code default 1 s, `NightCall.cs:11`), releasing drains 2x (`NightCall.cs:73-80`); max lead to first spawn 5 s (F8); first path <=2 s, repath 2-3 s (F23); hero aggro 5 s (F22); coin harvest 0.5 s/coin (F16); autosave +4 frames (F20); end screen +1 s (F21); TieBreaker 30 s / 10 dps (`TieBreaker.cs:7-10`); spawn-pause cap <=200 (F7). Score per night (defaults): base 100, protection <=200 (`(1-destroyedFraction)^2`), time <=200 = `clamp((120+S-t)/110,0,1)^2` with S = last spawn duration, t = night length (`ScoreManager.cs:12-33,157-186`).

### C4. Generators (ET and endless)

Shipped usage (`data/levels/*.json` `spawners[0].waveGenerator` / `.endlessWaveGenerator`): all 37 levels name the ET generator asset `Season2 Wave Gen` (matches the `SeasonTwoWaveGen` menu name, `SeasonTwoWaveGen.cs:5`; used only when the run is Eternal Trial, F2); only `35_Totend_MM1` also has `endlessMode: true` with `Endless Mode Wave Gen`; no level references an asset named for `SuperWaveGen` or `PaulsWaveGenerator`, so those two are dormant unless assigned elsewhere. All other Classic levels play their serialized `waves`.

RNG is `System.Random(seed)` for shuffles plus `UnityEngine.Random.InitState(seed)` unless stated. `ETShuffle` = Fisher-Yates (`RandomizeExtensionsForLists.cs:6-17`). Per-line split `DistributeEnemies`: weights U[0.2,1] (float `Random.Range` is inclusive), floor shares, remainder to the largest (`WaveGenUtility.cs:13-38`). Line compatibility: a line is dropped for a unit if `(flying && !canSpawnFlying) || (big && !canSpawnBigGround) || (small && !canSpawnSmallGround)`; flags derive from `EternalTrialEnemy.cs:92-106` (Endless `:82-97`, SeasonTwo `:225-243`, Super `SuperWaveGen.cs:1149-1156`; Super's `FirstPossibleSpawnFor` falls back to an incompatible line if none fits, `:1130-1147`).

**EndlessModeWaveGen** (`EndlessModeWaveGen.cs`)
- Nights = `len(waveDifficulties)` W + `len(difficultyMultiplayersAfterwards)` L (:36); start gold `startingGold` (:35); stage arg unused.
- Night i: budget `waveDifficulties[min(i,W-1)]` (:47); gate `4+4i`; gold to drop `min(4+i,50)` (:48-49); `difficultyMulti = afterwards[clamp(i-W+1,0,L-1)]` (:253).
- Types: 1..`clamp(i+{1,2},1,8)` random count; first a BreadAndButter whose `minDefenseInvestment <= gate`, rest rotate through the shuffled pool (:50-81).
- Shares: weights U[1,5]; Flavour capped 0.4, Flying 0.5, rest BreadAndButter (:107-153). Count `max(1, round(budget x share / difficultyValue))` (:168-169). Over 200 units: largest types with count>=10 become elite, count/6 (:174-199).
- Lines: even i -> 1-2 lines/type (1 for i<=1); odd i -> one line supporting all three kinds, used by every type (:207-242).
- Timing: 7 s window, `interval = 7/max(1,count-1)`, `delay=0` (:245,269). Each gold coin goes to a random Spawn (:278-281).

**SeasonTwoWaveGen** (`SeasonTwoWaveGen.cs`)
- Start gold `Next(8,26)`; stage<=2 and coin flip -> `Next(8,56)`; stage>=7 -> `Next(13,26)` (:32-40).
- Stage -> (scale S, requested nights, pool n): 0:(0.7,3,4) 1:(0.85,4,4) 2:(1,5,5) 3:(1.2,7,6) 4:(1.44,8,7) >=5:(1.2^(stage-2),10,8) (:44-76). Flavour/Flying caps 0.65/0.65 (stage<=3) else 0.4/0.5 (:77-83). Pool = n random enemies incl. one BreadAndButter with gate 0 (:84-116).
- `EconomySimulator` over `LevelInfo.virtualBuildings` yields defense power DP_k, gold drops and the actual night count (rate 0.2, min 3, max 40; retries lower start gold and rate) (:123-139).
- Night k budget = `2*DP_k*S + 11*clamp(S,1,1.75)`; x0.9 (stage 0); x`1.01/1.02/1.03/1.04/1.05^k` (stage 2/3/4/5/>=6); final night x1.15 (:147-175).
- Types per night 1..min(k+1,n-1) (cap 5; stage>=3 first night 1-2; stage>=6 first two 1-3; stage>=1 half the time at least 2), gated by gold spent on defense (:178-221). Counts as Endless (:305-306), but the over-cap elite conversion (count>=10 -> elite, count/6) walks the types in encounter order, not largest first (:316-334); then up to 10 passes making any count>=20 x0.75 with spawn speed x2 (:335-355).
- A type uses `1 + (#earlier nights it appeared)` lines (:366-388). Window `sqrt(budget)` s, `interval = window/max(1,count-1)/speed`, `delay=0` (:393,415). Night gold = simulated drop, random Spawns (:424-427).

**SuperWaveGen** (`SuperWaveGen.cs`)
- Nights: stage 0/1/2 -> 3/5/7 (+1 at 50%), stage>=3 -> 6+stage; shrunk by the economy sim, or regenerated with fewer nights if a night cannot fit the unit cap (:295-326,406,421-424).
- 12 meta-parameters are re-rolled from the seed each generation (:216-269,289); serialized `setting*` and `randomize*` values do nothing. Enum suffix number = draw weight (:1492-1514).
- Economy: start gold {8,13,18,23,28}+{-2..2} (stage>=4 turns the 8 tier into 13, `:219-222`); drop rate {0,0.05625,0.1125,0.225} of networth; min/night {2,4,6,8,11}(+1 at 50%); max = min x{1,2,3,4} or unlimited (:328-404).
- Budget = `(2*DP+11) x (1+T/60) x 0.98^(L-2) x pathRel x mean(line multiplier) x stageFactor` (:698-786); T = spawn window, L = distinct lines, pathRel = mean over line pairs (1.0 mostly-shared, 0.8 mostly-separated, else 0.9), stageFactor = `1.2^(min(stage,5)-2) + 0.3*max(0,stage-5)`.
- Types gated by `minDefenseInvestment <= DP` (:1114-1128); every night has a ground type (:536-557). Unit cost shrinks up to x0.4 as the defense counters its tags (:919-933).
- T: Immediate 1 s; Short 5.5-9.5; Medium 11.5-18.5; Long 25-32; Random 1-31 (20%: 2); Growing 3 x index; final-night VeryLong 40-180 s (:702-731). `interval = T/(count-1)` (a 1-unit Spawn gets interval 0.02 and a random delay in [0,T]), split into groups per `ESpawnInType` (:1019-1092,1422-1435).
- Cap 200: largest non-elite Spawn -> elite, count/6, interval x6 (:993-1018); elite modes (:946-992). Lines per type: 1-3, `index`-growing, or all compatible (:565-697).

**PaulsWaveGenerator** (legacy)
- 13 nights; strength `lerp(6,300,curve(i/(W-1))) x (1+0.15 x stage)`; gold `round(lerp(3,20,curve))`; type limit `round(lerp(2,5,curve))` (:22-100,125-136).
- Random affordable enemies until strength is spent; groups of 5; Spawn `interval` 0.15 s, `delay` +5 s per batch of ~3 groups; ground groups pick a random small-ground line (big-ground ignored) (:138-237). Enemy choice seeded; lines and gold use unseeded `UnityEngine.Random` (:104,197,205,209).

**EconomySimulator** (`EconomySimulator.cs:26-90`): per night, 1/3 (ceil) of gold to defense and the rest to economy (last two nights all defense); greedy buy of the highest-`priority` affordable building; if all are built the run restarts with `i-1` nights; income = sum of built `income`; drop = `clamp(ceil(networth x rate), min, max)`, 0 on the last night.

### C5. RNG source

| Mode | Seed | Reproducible? |
|---|---|---|
| Classic | none; position on line and coin split use the global `UnityEngine.Random`, never seeded by the game here (`Spawn.cs:94,100,276`) | no |
| Endless | `endlessSeed` from save key, else `InitState(round(Time.unscaledTime x 1e6))` then `Range(-1000000,1000000)` (`EnemySpawner.cs:302-307`); saved (`:242`) | fixed per seed; seed is time-derived |
| ET | `currentStageSeed`: fresh = PlayerPrefs seed or `new System.Random().Next(int.MinValue, int.MaxValue)`, after a win the same call (`EternalTrialsRunManager.cs:65-68,88-92,133,177-180`), `+= choice.id` on confirm (`:208`) | preview (`MapChoice.cs:51`, seed+id) equals the generated in-game waves (before the F14 perk edits, which run afterwards in `EnemySpawner.Start`) |

## (d) Serialized fields whose values live in asset files

| Owner | Fields (type; code default) | Meaning |
|---|---|---|
| `EnemySpawner` (`EnemySpawner.cs:16-73`) | `waves` (`List<Wave>`); `waveGeneratorScript`, `endlessModeWaveGeneratorScript` EternalWaveGenerator; `endlessMode` bool; `currentMode` GameMode; `goldBalanceAtStart` int (10); `pauseSpawningAtEnemyCount` int (275); `difficultySprite` | nights, generators, mode, start gold, spawn-pause cap |
| `Wave`/`Spawn` (`Wave.cs:11-13`; `Spawn.cs:8-20`) | `difficultyMulti` float (1); `delay`, `interval` float; `enemyPrefab`; `eliteEnemies` bool; `count`, `goldCoins` int; `spawnLine` Transform | per-night composition and timing |
| `EnemySpawnLine` (`EnemySpawnLine.cs:13-24`) | `difficulty` enum; `canSpawnFlying/SmallGround/BigGround` bool; `mostlySharedAttackpaths`, `mostlySeperatedAttackPaths` List; child node positions | spawn polyline and budget/route metadata |
| `EnemySpawnManager` (`EnemySpawnManager.cs:7-13`) | marker prefabs, `weaponOnSpawn`, `weaponAttackHeight` (1) | markers and spawn FX |
| `EndlessModeWaveGen` (`EndlessModeWaveGen.cs:9-29`) | `enemySet`; `maxAmountOfUnitsPerWave` (200); `startingGold` (20); `waveDifficulties[]`, `difficultyMultiplayersAfterwards[]` float; `maxFlavourUnits` (0.4); `maxFlyingUnits` (0.5) | endless budgets and multipliers |
| `SeasonTwoWaveGen` (`:9-12`), `SuperWaveGen` (`:140-192`) | `enemySet`; `maxAmountOfUnitsPerWave` (200); Super: `counterableTags` (`List<ETag>`) | pool, cap, counter tags |
| `PaulsWaveGenerator` (`:22-61`) | `startGold` 10, `wavecount` 13, `maxNumberOfGroupsToSpawnSimultaneously` 2, `delayBetweenGroups` 5, `initialWaveStrength` 6, `targetWaveStrength` 300, `waveStrengthPerStageMultiplier` 0.15, min/max GoldPerWave 3/20, min/max EnemyTypeLimitPerWave 2/5, three AnimationCurves, `enemySet` | legacy curves |
| `EternalTrialEnemy` in `EternalTrialEnemySet.enemies` (`EternalTrialEnemy.cs:16-40`; `EternalTrialEnemySet.cs:7`) | `enemyPrefab`; `difficultyValue` float (1); `minDefenseInvestment` float (0); `group` EGroup | unit cost, unlock gate, share group |
| `LevelInfo` (`LevelInfo.cs:35,46`; `VirtualBuilding.cs:9-35`) | `virtualBuildings` (`List<VirtualBuilding>`: `name, builtReset, costReset, requirementIndexes, incomeReset, priorityReset, economicBuilding, defensePower, representingLevel`); `enemySpawner` | economy simulation input |
| Day/night components (`DayNightCycle.cs:28`; `AutoDayNight.cs:6-12`; `NightCall.cs:11`; `TieBreaker.cs:7-10`; `LocalGamestate.cs:33`; `PeriodicallyEnableAndDisableDuringEnemySpawn.cs:9-12,24-28`) | `DayNightCycle.sunriseTime` 2.5 (all 37 levels: 3.0); `AutoDayNight.autoDayLength` true, `dayLength` 15, `autoNightLength` false, `nightLength` 15 (component present in only 3 levels: `14_Durststein_Speedrun` true/20/false/15, `29_Freifort_MM1` false/15/true/240, `40_Wildbach_MM3` false/15/true/120); `NightCall.nightCallTime` 1 (all 37 levels: 2.0); `TieBreaker` 30 s / 10 dps (code defaults; placement not in the extracted data); `LocalGamestate.objectsThatTriggerLoseWhenDestroyed`; presence of `AutoKillAllEnemiesBeforeSunrise`, `OnDeathStartNextDay`; `PeriodicallyEnableAndDisableDuringEnemySpawn` 10/10 s (keyed to `LastSpawnPeriodClock`, reset each dusk) | forced day length, stall breakers, lose conditions |
| Extra spawners (`InstantEnemySpawn.cs:6`; `IronCastleEnemySpawning.cs:7-10,20-33`; `SummoningCircle.cs:7,19-28`; `FinalBossDragon.cs:21,30`) | `InstantEnemySpawn.wave`; `IronCastleEnemySpawning.waves` (entries 0-2 used) and `hp` (fire below 75/50/25% Hp); `SummoningCircle.spawnsToAdd`; `FinalBossDragon.waves`, `immediateWaveOnDeath` | boss/minion waves outside the night loop; the summoning circle appends its Spawns once to the next wave |
| Enemy prefab (`Hp.cs:11-13,36,79-83`; `TaggedObject.cs:9`; `PathfindMovementEnemy.cs:9-22,70`; `TargetPriority.cs:9-18`; `AutoAttack.cs:8-20`; `ScreenMarkerIcon.cs:5-7`) | `Hp.maxHp`, `coin`, `coinSpawnOffset`, `enemyToSpawnOnDeath`; `TaggedObject.tags`; `PathfindMovementEnemy` (`targetPriorities`, `keepDistanceOf` 2, `movementSpeed` 2, `recalculatePathInterval` 1, `backupMovementGraph`, `agroTimeWhenAttackedByPlayer` 5, `speedWhenSlowed` 0.33); `TargetPriority` (`mustHaveTags`, `mayNotHaveTags`, `range`, `minRange`); `AutoAttack` (`cooldownDuration` 1, `targetPriorities`, `weapon`); `Seeker.graphMask`; `ScreenMarkerIcon` | stats, targeting, graph class |
| `PerkManager` (`PerkManager.cs:36,63-83,140-157,182-214,229-272`) | perk multipliers used in F13-F14, F16 | code defaults exist only for some; shipped values are in `data/balance_sheet.json` (`PerkManager.PerkManager.*`, e.g. TreasureHunter 15/25/40 vs code 10/20/30) |
| `ScoreManager` (`ScoreManager.cs:12-33`) | `baseScorePerNight` 100, `protectionScorePerNight` 200, `timeScorePerNight` 200, `timeBonusMinTime` 10, `timeBonusMaxTime` 120, `scoreExponent` 2 | night score |

## (e) Bot implications (legit play)

1. **Read state** with `DayNightCycle.Instance` (`CurrentTimestate`, `AfterSunrise`, `CurrentNightLength`, `AutomatedDaytime`, `RemainingAutoDayTime`; `DayNightCycle.cs:54-68`) and `EnemySpawner.instance` (`Wavenumber`, `WaveCount`, `SpawningInProgress`, `NumberOfEnemiesOnTheMap`, `MatchOver`, `FinalWaveComingUp`; `EnemySpawner.cs:75-124`). `EnemySpawner.GetWaveInfoForNextWave()` / `GetWaveInfoByNumber(i)` equal the pause-menu preview (F25); scale its unscaled maxHP/damage by the F13 factors (elite 4x HP, 3x damage; `difficultyMulti`). Prefer player-visible data (markers, preview, popup, day clock); per-Spawn `delay`/`interval`, seeds and generator internals are hidden information, so observe rather than derive them. No spawner mutation is needed: do not use `DebugSkipWave` (`EnemySpawner.cs:150`), `Refresh`, or edit `waves`.
2. **Act only in DAY** (`Day && AfterSunrise`). DAWN_WAIT lasts `sunriseTime` (3.0 s in the shipped levels; code default 2.5 s) after the last kill: no horn, units revive only at its end (F20). Build and upgrade only by day (F18). Income arrives on its own at sunrise; protect economy buildings, since a knock-out costs the next dawn's income (F16). `TrueBalance` counts coins in flight (`PlayerInteraction.cs:93`). The Interest perk pays on gold held at dusk (F16).
3. **Call the night** within `interactionRadius` 3 (`PlayerInteraction.cs:15`) of the horn: first press may only harvest (F17); or hold Call Night for `nightCallTime` (2.0 s in the shipped levels; code default 1 s), which is disabled in automated-day levels and after `MatchOver` (`NightCall.cs:68,73`; `PlayerInteraction.cs:81`). Automated-day levels force night when the clock hits 0 (F17).
4. **Be in position before calling**: with an empty field the first unit appears within 5 s (F8; generated waves: immediately, `delay=0` in C4); units wait up to 2 s for a first path, then walk at `speed` from `WaveInfo` (F23). Attack directions = marker positions; the true spawn point is anywhere on the line polyline; flying units use only flying-capable lines and spawn 5 up. Expect arrivals over the whole spawn window (C4: Endless 7 s; SeasonTwo `sqrt(budget)` s; Super typically <=32 s, Growing = 3 s x night index, final night up to 180 s).
5. **Placement**: enemies head for the nearest target per priority, re-evaluated every 2-3 s; hitting one with the hero drags it to the hero for ~5 s (F22). Commanded units are not chased but can still be shot (B8).
6. **Finish the night**: it ends only when spawning is done and every `EnemyOwned` unit (including death-spawned and boss minions, F13, F27) is dead (F19). Stalls: >=cap enemies alive (F7), unreachable stragglers (TieBreaker only after 30 s of no change, if present).
7. **Final night** = index `Count-1` (`FinalWaveComingUp` on the preceding day, horn tooltip changes). Call Night is blocked after `MatchOver`; victory fires `sunriseTime` (3.0 s) after that night's last kill (F21). In ET never quit during a night (reload = defeat); state is saved only at dawn (F21).
8. **Economy forecast**: `goldReward` of the next night and its enemy list are known before dusk; ET runs also expose all nights and start gold on the map-choice screen; the pool in one SeasonTwo run is only 4-8 enemy types.

## Verification log (independent fact-check)

**Date:** 2026-09-29. **Scope:** every citation was opened in `decompiled/` and compared with the claim (numbers, `<` versus `<=`, field and method names, direction of cause and effect). Constants the assets can override were cross-checked in `reference/data/` (`levels/*.json`, `balance_sheet.json`, `enemy_prefabs.json`, `navmesh/*.json`, `equippables.json`; `data_steam/` is identical for every field used). Scripted checks: all cited files exist and no cited line range exceeds its file; every backticked identifier exists in `decompiled/` or `reference/maps/code/*.types.jsonl`. The only non-matches are notation: `File.cs:line`, `decompiled/*.cs`, wildcards such as `can*`/`setting*`/`randomize*`, the shorthand `canSpawnFlying/SmallGround/BigGround`, formula symbols such as `DP_k` and `pathRel`, and JSON keys or paths of the data files. `Seeker` and `GraphMask` are A* Pathfinding types (`maps/code/AstarPathfindingProject.types.jsonl`), not in `decompiled/`; the doc only uses them via `seeker.graphMask` (`PathfindMovementEnemy.cs:133,145`; `EternalTrialEnemy.cs:98-106`).

**Claims checked: 296** (251 prose/bullet claims: header, F1-F27, B1-B9, C4 generator bullets, section (e); 45 table/list cells: C1, C2, C3, C5, (d)).

| Verdict | Count |
|---|---|
| SUPPORTED | 270 |
| PARTIAL | 25 |
| WRONG | 0 |
| CANNOT-VERIFY | 1 |

Rule applied: a number that is correct as the code default but is overridden by the shipped assets counts as PARTIAL (right field, wrong effective value). No claim was flatly contradicted by the decompiled code. Of the 25 PARTIAL claims, 12 are code defaults overridden by shipped assets (edits #4, #5, #7, #8, #12, #14, #16, #17 (two claims), #27-#29) and 13 are code-reading imprecisions or omissions (edits #1-#3, #10, #11, #18-#23 (#23 has two claims), #25). The single CANNOT-VERIFY is B6.

### Corrections applied (29 edits: 23 fix the 25 PARTIAL claims, 6 add asset-data answers)

| # | Where | Before | After | Evidence |
|---|---|---|---|---|
| 1 | F5 | `difficulty` budget multiplier stated for generated waves in general | read only by `SuperWaveGen` (as are the shared/separated path lists); Endless, SeasonTwo and Pauls use only the `can*` flags | `SuperWaveGen.cs:754-756,771`; grep finds no other reader |
| 2 | F10 | fewer than 2 nodes -> first node or the line transform | the first node keeps the flying `+5`; the line-transform fallback (no children) has no `+5` | `Spawn.cs:293-297` |
| 3 | F13 | Chaos "cooldown 3 s" | non-`Exploding` units only; it is the initial attack cooldown (`SetCooldownTo` sets `cooldown` and `cooldownAfterSpawn`), `cooldownDuration` unchanged | `Spawn.cs:135-140,236-239`; `AutoAttack.cs:75-79,83` |
| 4 | F16 | TreasureHunter pays 10/20/30 | 15/25/40 (10/20/30 are the code initialisers) | `balance_sheet.json` `PerkManager.PerkManager.treasureHunterGoldAmountWave1/2/3`; `equippables.json` Treasure Hunter text ("40 gold"); `PerkManager.cs:140-146` |
| 5 | F17 | `nightCallTime` (default 1 s) | code default 1 s; 2.0 s in all 37 levels | `levels/*.json` `nightCall[0].nightCallTime`; no code writes it (grep) |
| 6 | F19 | automated night timer is "level-specific" | shipped only in `29_Freifort_MM1` (240 s) and `40_Wildbach_MM3` (120 s) | `levels/*.json` `autoDayNight[0]` |
| 7 | F20 | wait `sunriseTime` 2.5 s | code default 2.5 s; 3.0 s in all 37 levels | `levels/*.json` `dayNight[0].sunriseTime`; no code writes it (grep) |
| 8 | F23 | `movementSpeed` (default 2) | code default 2; prefab values 2-15 | `enemy_prefabs.json` `speed`; `balance_sheet.json` `*.PathfindMovementEnemy.movementSpeed` |
| 9 | B1 | "(asset data)" | checked: all 39 enemy prefabs in the sheet end with a catch-all range of 100000 or 1000000 | `balance_sheet.json` `<prefab>.PathfindMovementEnemy.targetPriorities[last].range` |
| 10 | B4 | "probably" Enemy Units S/L, "unverified" | confirmed; graph 1 is "Player Units S", so small = Enemy Units S or Player Units S, big = Enemy Units L, flying comes from the tag | `navmesh/*.json` `graphs[]` (same in all 37) |
| 11 | B5 | `Start` sees the 1-based spawn ordinal | `Start` runs after the instantiating call and sees the running total; it equals the ordinal only if no other unit spawned in between | `Spawn.cs:151,266-267`; `PathfindMovementEnemy.cs:147` |
| 12 | B9 | hero 14/23 "far exceeds default enemy speed 2" | hero 14/23 at night, 18.2/29.9 by day; enemies 2-15, so at night only a sprinting hero outruns all of them | `levels/*.json` `heroes[0].movement`; `PlayerMovement.cs:224` |
| 13 | Unresolved list | five open items | answered in part: generator per level, `EnemyOwned` structures, `AutoDayNight` and `OnDeathStartNextDay` placement; the remainder is listed as still unresolved | answers below |
| 14 | C1 DAWN_WAIT | `sunriseTime`=2.5 s | 3.0 s shipped (2.5 code default) | as #7 |
| 15 | C1 DAY | `dayLength` default 15 s | added: the only auto-day level is `14_Durststein_Speedrun`, 20 s | `levels/*.json` `autoDayNight` |
| 16 | C2 last row | victory after 2.5 s | after `sunriseTime` (3.0 s) | as #7; `DayNightCycle.cs:290-296` |
| 17 | C3 | Sunrise wait 2.5 s; Call Night hold 1 s | 3.0 s; 2.0 s (code defaults 2.5 and 1 kept in brackets) | as #5, #7 |
| 18 | C4 intro | weights U[0.2,1); no statement of which generators ship | U[0.2,1] (float `Random.Range` is inclusive); added: 37/37 levels use `Season2 Wave Gen`, one also `Endless Mode Wave Gen`, none references Super or Pauls | `WaveGenUtility.cs:20`; `levels/*.json` `spawners[0]` |
| 19 | C4 Endless | weights U[1,5) | U[1,5] | `EndlessModeWaveGen.cs:115` |
| 20 | C4 SeasonTwo | "Counts as Endless, then any count>=20 x0.75" | count formula as Endless, but the over-cap elite conversion walks types in encounter order (Endless: largest first); the x0.75 pass runs up to 10 rounds | `SeasonTwoWaveGen.cs:305-306,316-334,335-355` versus `EndlessModeWaveGen.cs:184-199` |
| 21 | C4 Super | start gold {8,13,18,23,28} | stage>=4 turns the 8 tier into 13 | `SuperWaveGen.cs:219-222` |
| 22 | C4 Super | `interval = T/(count-1)` | a 1-unit Spawn gets interval 0.02 and a random delay in [0,T] | `SuperWaveGen.cs:1422-1435` |
| 23 | C5 ET | `new System.Random().Next()`; preview "equals in-game" | `Next(int.MinValue, int.MaxValue)`; equal to the generated waves, before the F14 perk edits | `EternalTrialsRunManager.cs:90,133`; `EnemySpawner.cs:293,310-382`; `MapChoice.cs:51` |
| 24 | (d) day/night row | code defaults only | added shipped values (sunrise 3.0, nightCall 2.0, `AutoDayNight` in 3 levels) | as #5-#7 |
| 25 | (d) extra spawners | `IronCastleEnemySpawning.waves[3]` | `waves` (entries 0-2 used) | `IronCastleEnemySpawning.cs:22-32` |
| 26 | (d) PerkManager row | "code defaults exist only for some" | added: shipped values are in `balance_sheet.json` | as #4 |
| 27 | (e) item 2 | `sunriseTime` (default 2.5 s) | added 3.0 s shipped | as #7 |
| 28 | (e) item 3 | `nightCallTime` (default 1 s) | added 2.0 s shipped | as #5 |
| 29 | (e) item 7 | victory 2.5 s after the last kill | `sunriseTime` (3.0 s) | as #7 |

### Still unverifiable

- B6: the `Coin.registerInTagManager` mechanism is in the code (`Coin.cs:25,67-70`); the flag on the enemy coin prefabs is not exported.
- The enemy set (`EternalTrialEnemySet`) per level and every generator asset field (`waveDifficulties`, `difficultyMultiplayersAfterwards`, `startingGold`, `maxFlavourUnits`, `maxFlyingUnits`, `counterableTags`, ...): section (d) lists code defaults only.
- Placement and values of `TieBreaker` and `AutoKillAllEnemiesBeforeSunrise`; contents of `LocalGamestate.objectsThatTriggerLoseWhenDestroyed`; whether units added by summoning circles are `EnemyOwned`.
- Shipped values of `CoinSpawner.interval` and of `PathfindMovementEnemy.keepDistanceOf`, `recalculatePathInterval`, `agroTimeWhenAttackedByPlayer` (the balance sheet holds only `movementSpeed`, `speedWhenSlowed` and `targetPriorities`).
- The level JSONs report `nighthorns: []` and `summary.hasHorn: false` in all 37 levels although the code and F17 depend on the horn; that is an extractor gap, not evidence.
- B5 rests on Unity calling `Start` after `Instantiate` returns (engine behaviour, not visible in the decompiled code).

### Answers to the open questions (from asset data)

1. **Which generator/enemy set each level uses.** `levels/*.json` `spawners[0].waveGenerator` is `Season2 Wave Gen` in all 37 files (identical in `data_steam`); `spawners[0].endlessWaveGenerator` is `Endless Mode Wave Gen` only in `35_Totend_MM1.json` (`endlessMode: true`); `spawners[0].mode` is `Classic` everywhere except `11_Nordfels_Siege.json` (`EternalTrial`, `modeRaw` 1; F2 lets `LocalGamestate.SelectedGameMode` override it). No level names a Super or Pauls asset, so those generators are dormant in shipped data; every classic level other than `35_Totend_MM1` plays its serialized `spawners[0].waves`. The enemy set is not exported.
2. **Do enemy structures carry `EnemyOwned`?** `enemy_prefabs.json`: `E Iron Castle` (`level27:7200`, maxHp 66000; `level30:7202`, maxHp 68750) has tags `EnemyOwned, RangedFighter, Boss, SiegeWeapon, FireAndExplosionResistant` and a `LoseHealthOverTime` component; `E Ghostqueen` (`level26:3688`, maxHp 15000) has `EnemyOwned` and `Boss`. They therefore count in `NumberOfEnemiesOnTheMap` (`DayNightCycle.cs:112`) and, being `Boss`, hold a TieBreaker timer at 0 (`TieBreaker.cs:80-83`). The scene objects `BOSS FIGHT`, `FINAL BOSS FIGHT`, `Enemy Base 1-6`, `Spawn Animation`, `Empty Delay` and `Screen Shake` have no root tags (activation-only Spawns, F11). No summoner prefab is exported.
3. **Where the day/night helpers sit.** `AutoDayNight`: `14_Durststein_Speedrun` (auto day 20 s), `29_Freifort_MM1` (auto night 240 s), `40_Wildbach_MM3` (auto night 120 s), no other level. `OnDeathStartNextDay` (together with `OnDeathKillAllPlayerUnits`): the hero of `29_Freifort_MM1` only (`heroes[0].summary.components`); `17_Frostsee_Bowling_Challenge` exports no hero. `TieBreaker` and `AutoKillAllEnemiesBeforeSunrise`: not exported.
4. **`objectsThatTriggerLoseWhenDestroyed`.** Not exported; the only related datum is `castle[0]` (Castle Center, maxHp 100 on Nordfels).
5. **Coin prefab flags.** Not exported (see B6).

### Other asset cross-checks

- `pauseSpawningAtEnemyCount` is 275 in 36 levels and 225 in `39_Wildbach_MM2`; `Start` clamps both to 200 (F7).
- `goldBalanceAtStart` is set per level, 0 to 400 (Nordfels 8, Durststein 16, `11_Nordfels_Siege` 400; the ET and endless generators overwrite it), not the code default 10 (F15).
- `warningText` is filled in the assets (Nordfels night 1: "3 Swordsmen approaching from southern bridge") but never read by code (F1).
- `Wave.difficultyMulti` differs from 1 only in `34_Moorweg_MM3` (nights 2-14: 1.25, 1.75, 2.5, 3.5, 5, 7, 10, 15, 21, 30, 40, 58, 75). `13_Durststein_Gold_Puzzle` and `32_Moorweg_MM1` have no Spawns in nights 1-9, so those waves finish at once (F6). Spawns with count 0 occur only as activation placeholders (`29_Freifort_MM1` Enemy Base 1-6, night 1 of `35_Totend_MM1`), consistent with F6 and F11.
- Perk values in `balance_sheet.json` (`PerkManager.PerkManager.*`): Tiger +75% damage, Turtle +60% HP, Falcon +75% speed and -60% chase time, AntiAir -25% HP and damage, WarGods -20% HP and damage, Growth +75% HP and damage reached at the last night, RangeGod +100% HP, +40% damage, -30% cooldown, +50% speed, +70% range, EliteGod every 4th non-elite Spawn, RatGod -50% gold, Loan +7 start gold and 10 interest, CheeseGod x2 count and +25% speed for 3 nights, Interest 1 per 3 gold up to 20, RoyalMint `royalMint_startGoldBonus` 0 (code default 1).
- Hero `interactionRadius` is 3.0 in all 36 exported heroes (matches section (e) item 3).
- `spawnLines[].center` in the level JSONs is the mean of the nodes, whereas the in-game screen marker is the midpoint of the first and last node (F24, `EnemySpawner.cs:456`); they coincide only for 2-node lines (Nordfels "Fly - River" has 3 nodes: center (-53.0, -53.9) versus marker (-48.1, -52.2)).
