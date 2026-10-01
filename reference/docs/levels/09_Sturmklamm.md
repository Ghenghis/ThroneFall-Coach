# Sturmklamm — level handbook

*Generated from the shipped asset files (build index 9, scene file `level9`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Uferwind** |
| Nights (waves) | 13 |
| Enemies in total | 842 |
| Total enemy base HP | 76695 |
| Gold coins dropped by waves (sum of `goldCoins`) | 244 |
| Flying enemies / bosses | 108 / 4 |
| Enemy spawn lines | 14 |
| Build slots | 80 |
| Shrines | 6 |
| Starting gold (`goldBalanceAtStart`) | 11 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -48.1, 31, 11.5 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/09_Sturmklamm_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Bridge Broken | (-140, 78) | 14.1 | air | Normal | 273 | 0.5 | (-101, 79) | – |
| Bridge 3 | (-44, -79) | 14.1 | air/small/big | Normal | 180 | 0.5 | (-48, -61) | Bridge 2 |
| Base Left Air | (-10, 54) | 40.9 | air | Normal | 23 | 7 | (-38, 22) | Base Right Air |
| Base Right Air | (17, 18) | 43.6 | air | Normal | 50 | 0.5 | (-33, -2) | Base Left Air |
| Spawn | (-109, 81) | 1.6 | air/small/big | Normal | 241 | 0.5 | (-97, 83) | – |
| Spawn | (-112, 71) | 1.6 | air/small/big | Normal | 249 | 0.5 | (-101, 79) | – |
| Spawn | (-104, 74) | 1.6 | air/small/big | Normal | 240 | 0.5 | (-99, 80) | – |
| Bridge 2 | (-87, -59) | 14.1 | air/small/big | Normal | 154 | 0.5 | (-75, -37) | Bridge 3 |
| Bridge 1 | (-124, -8) | 14.1 | air/small/big | Normal | 194 | 0.5 | (-102, 9) | – |
| West Air | (-87, 114) | 14.1 | air | Normal | 206 | 0.5 | (-67, 91) | – |
| Marker Pos | (-84, -16) | 0 | – | n/a | – | – | – | – |
| Marker Pos | (-26, -61) | 0 | – | n/a | – | – | – | – |
| Marker Pos | (-113, 42) | 0 | – | n/a | – | – | – | – |
| Marker Pos | (-91, 73) | 0 | – | n/a | – | – | – | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Spears and Bow | 6 | 135 | 3 | 0 | 0 | 6 | 3× Archer, 3× Pikes | Bridge 1:2, Bridge 2:2, Bridge 3:2 | 31 | 39 |
| 2 | Molemen | 5 | 300 | 0 | 0 | 0 | 6 | 5× Mole Warrior | Bridge Broken:5 | 55 | 57 |
| 3 | Spears and Bow | 21 | 465 | 12 | 0 | 0 | 12 | 12× Archer, 9× Pikes | Bridge 1:7, Bridge 2:7, Bridge 3:7 | 31 | 42 |
| 4 | Flyer Wave | 14 | 650 | 14 | 14 | 0 | 13 | 8× Wasp, 6× Fury | West Air:8, Base Right Air:3, Base Left Air:3 | 14 | 29 |
| 5 | Molemen and Mole Archers | 16 | 880 | 8 | 0 | 0 | 12 | 8× Mole Archer, 8× Mole Warrior | Bridge 1:4, Bridge 2:4, Bridge 3:4, Bridge Broken:4 | 31 | 58 |
| 6 | Fat Frontal Attack | 39 | 1935 | 33 | 0 | 0 | 15 | 30× Archer, 6× Ogre, 3× Catapult | Bridge 3:13, Bridge 2:13, Bridge 1:13 | 31 | 107 |
| 7 | Long Nicht With Diverse Attacks | 100 | 4350 | 20 | 20 | 0 | 12 | 30× Racer, 30× Monster Rider, 20× Mole Warrior, 20× Flying Mage | Bridge Broken:20, Bridge 2:60, Base Right Air:20 | 9 | 112 |
| 8 | Quickslings | 45 | 1395 | 9 | 0 | 0 | 18 | 36× Pikes, 9× Quicksling | Bridge 1:15, Bridge 2:15, Bridge 3:15 | 31 | 66 |
| 9 | Massive Mole Massacre | 106 | 5790 | 60 | 0 | 0 | 30 | 60× Mole Archer, 40× Mole Warrior, 6× Exploder | Bridge 1:32, Bridge 2:32, Bridge 3:32, Bridge Broken:10 | 17 | 64 |
| 10 | Racer Stream | 126 | 4740 | 30 | 0 | 0 | 18 | 90× Racer, 30× Master Crossbowmen, 6× Exploder | Bridge 2:126 | 15 | 44 |
| 11 | Flyer Nightmares | 74 | 3150 | 74 | 74 | 0 | 48 | 30× Flying Mage, 30× Wasp, 14× Fury | Base Left Air:37, Base Right Air:37 | 7 | 37 |
| 12 | Fat Wave From All Sides | 286 | 12905 | 101 | 0 | 0 | 54 | 85× Mole Archer, 70× Mole Warrior, 45× Swordsman, 30× Pikes, 30× Racer, 16× Quicksling, 10× Exploder | Bridge 1:86, Bridge 2:101, Bridge 3:79, Bridge Broken:20 | 17 | 136 |
| 13 | Boss Wave | 4 | 40000 | 0 | 0 | 4 | 0 | 4× Strange Statue | Marker Pos:4 | 10 | 15 |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 13 (40000 HP, 4 enemies); night-to-night HP ratio (last/first) = 296.3×. Ranged enemies appear on nights 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12; flyers on nights 4, 7, 11.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Pikes | E LongSpear | 25 | 5 | 6 | 3.5 | 1 | 3.5 | MeeleFighter, VulnerableVsRanged, NaturallyVulnerableToSplash, Humanoid | Equipped with long spears. Your horse is slowed and you take additional damage when riding into them, even mor |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Monster Rider | E Monster Rider | 40 | 11 | 4 | 3 | 1 | 3 | MeeleFighter, FastMoving, Monster, Humanoid | Monster riders are fast and durable melee warriors. A man meets monster synergy that should not be underestima |
| Master Crossbowmen | E Crossbow | 40 | 4 | 15 | 15 | 1.6 | 9.38 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | Master Crossbowmen deal massive amounts of damage to you and your units. Best to keep yourself and your troops |
| Catapult | E Catapult | 45 | 2 | 26.4 | 150 | 5 | 30 | RangedFighter, SiegeWeapon | Catapults are siege units that deal massive damage to your buildings from afar. Your only chance is to get clo |
| Flying Mage | E Flying Wizzard | 45 | 7 | 17 | 2 | 2 | 1 | RangedFighter, Flying, Humanoid | Shoots magical projectiles that deal splash damage. Prefers attacking your units. |
| Mole Archer | E Moleman Archer | 50 | 5 | 20 | 3.8 | 2 | 1.88 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | A ranged unit that loves playing hard to get. Takes additional damage from defense towers. |
| Quicksling | E Quicksling | 55 | 3 | 37.5 | 9.8 | 0.45 | 21.72 | RangedFighter, SiegeWeapon | A unique siege weapon that rapidly fires arrows at random enemies in its range. If you don't have any allied b |
| Mole Warrior | E Moleman | 60 | 5 | 3 | 5 | 1 | 5 | MeeleFighter, TakesIncreasedDamageFromTowers, Humanoid | Can tunnel directly to its target. Takes additional damage from defense towers. |
| Exploder | E Exploder | 65 | 9 | 4 | 3.5 | 1 | 3.5 | MeeleFighter, FastMoving, TakesReducedDamageFromPlayerAttacks, Monster, SiegeWeapon, Exploding | Exploders are monsters that roll straight for the closest building and explode when they die. They are slightl |
| Fury | E Fury | 75 | 3 | 15 | 30 | 4 | 7.5 | RangedFighter, Flying, Monster | A large flying monster that focusses on destroying your defenses. Their projectiles are quite slow and easy to |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |
| Strange Statue | E Eldermole | 10000 | 6 | 5.5 | 22.5 | 0.5 | 45 | MeeleFighter, TakesIncreasedDamageFromTowers, Boss | Some speculate they could be part of an ancient defense mechanism? Maybe there is a reason this castle remaine |
| Strange Statue | E Eldermole | 10000 | 6 | 5.5 | 22.5 | 0.5 | 45 | MeeleFighter, TakesIncreasedDamageFromTowers, Boss | Some speculate they could be part of an ancient defense mechanism? Maybe there is a reason this castle remaine |
| Strange Statue | E Eldermole | 10000 | 6 | 5.5 | 22.5 | 0.5 | 45 | MeeleFighter, TakesIncreasedDamageFromTowers, Boss | Some speculate they could be part of an ancient defense mechanism? Maybe there is a reason this castle remaine |
| Strange Statue | E Eldermole | 10000 | 6 | 5.5 | 22.5 | 0.5 | 45 | MeeleFighter, TakesIncreasedDamageFromTowers, Boss | Some speculate they could be part of an ancient defense mechanism? Maybe there is a reason this castle remaine |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 15 | economy | Mill upgrade #1 ×6, Mill upgrade #2 ×9 | 6 g ×4, 10 g ×6, 13 g ×2, 17 g ×3 | 1 | 1 | 1 | – |
| House | 11 | economy | Castle Center upgrade #1 ×3, House upgrade #1 ×6, Castle Center upgrade #2 ×1, House upgrade #3 ×1 | 3 g ×3, 5 g ×1, 7 g ×1, 9 g ×1, 10 g ×1, 11 g ×1, 12 g ×1, 14 g ×1, 27 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 3 | economy | Castle Center upgrade #1 ×2, Castle Center upgrade #2 ×1 | 3 g ×2, 10 g ×1 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #3 ×2 | 30 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barricades | 3 | other | Barricades upgrade #1 ×1, Castle Center upgrade #2 ×2 | 10 g ×2, 15 g ×1 | 1 | 5 | 0 | 1 |
| Gold Mine | 2 | other | Castle Center upgrade #3 ×2 | 30 g ×2 | 1 | 5 | 6 | 0 |
| Hero's Quarter | 2 | other | Castle Center upgrade #3 ×2 | 30 g ×2 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 3 | other | Castle Center upgrade #1 ×3 | 3 g ×3 | 2 | 1 → 2 | 0 | 0 |
| Shrine | 6 | shrine | Castle Center upgrade #1 ×6 | 3 g ×6 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #2 ×1 | 10 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 24 | tower | Castle Center upgrade #1 ×7, Castle Center upgrade #2 ×16, Castle Center upgrade #3 ×1 | 3 g ×7, 10 g ×16, 30 g ×1 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 4 | wall | Castle Center upgrade #1 ×4 | 3 g ×4 | 3 | 3 → 6 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Archery Range, 7× Defense Tower, 3× House, 2× Mill, 1× Royal Forge, 6× Shrine, 3× Summoning Circle, 4× Wall; **5 g** → 1× House; **6 g** → 4× Field; **7 g** → 1× House; **9 g** → 1× House; **10 g** → 1× Archery Range, 2× Barricades, 1× Blacksmith, 16× Defense Tower, 6× Field, 1× House, 1× Mill; **11 g** → 1× House; **12 g** → 1× House; **13 g** → 2× Field; **14 g** → 1× House; **15 g** → 1× Barricades; **17 g** → 3× Field; **27 g** → 1× House; **30 g** → 2× Barracks, 1× Defense Tower, 2× Gold Mine, 2× Hero's Quarter.

**Totals:** building every slot to its final level costs **2786 gold**; if everything is at maximum level the buildings pay **181 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

### Castle Center

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 3 |  |  |  |  | Start a new Kingdom! | Lvl 1 Perks |
| 2 | 7 |  | Royal Training |  | 200 | Unlock more build options and choose an upgrade.  | Royal Training; Auto Attack Level 2 [range 35, dps 2.25]; Royal Training Mesh |
| 2 | 7 |  | Builder's Guild |  | 200 | Unlock more build options and choose an upgrade.  | Builder's Guild; Auto Attack Level 2 [range 35, dps 2.25]; Builders Guild Mesh |
| 2 | 7 |  | Magic Armor |  | 200 | Unlock more build options and choose an upgrade.  | Magic Armor; Auto Attack Level 2 [range 35, dps 2.25]; Magic Armor Mesh |
| 2 | 7 |  | Assassin's Training |  | 200 | Unlock more build options and choose an upgrade.  | Assassin's Training; Auto Attack Level 2 [range 35, dps 2.25]; Assassins Training Mesh |
| 3 | 20 |  | Royal Mastery |  | 400 | Unlock more build options and choose an upgrade.  | Auto Attack Level 3 [range 35, dps 4.5]; Royal Mastery; Royal Mastery Mesh |
| 3 | 20 |  | Commander |  | 400 | Unlock more build options and choose an upgrade.  | Commander; Auto Attack Level 3 [range 35, dps 4.5]; Commander Mesh |
| 3 | 20 |  | Castle Up |  | 400 | Unlock more build options and choose an upgrade.  | Castle Up; Auto Attack Level 3 [range 35, dps 4.5]; Castle Up Mesh |
| 3 | 20 |  | Godly Curse |  | 400 | Unlock more build options and choose an upgrade.  | Godly Curse; Auto Attack Level 3 [range 35, dps 4.5]; Godly Curse Mesh |
| 4 | 100 |  | Empire Towers |  | 1000 |  | Empire Towers |
| 4 | 100 |  | Empire Troups |  | 1000 |  | Empire Troups |
| 4 | 100 |  | Empire Armor |  | 1000 |  | Empire Armor |
| 4 | 100 |  | Empire Growth | 20 | 1000 |  | Empire Growth |

### Defense Tower

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 3 |  |  |  |  | Shoots at enemies. | Tower Attack [range 36, dps 4] |
| 2 | 5 |  | Castle Tower |  | 150 | Improves health and attack damage. | Tower Attack [range 36, dps 4]; Castle Tower |
| 2 | 5 |  | Sniper Tower |  |  | Improves health and attack damage. | Tower Attack [range 36, dps 4]; Sniper Tower |
| 2 | 5 |  | Armored Tower |  | 350 | Improves health and attack damage. | Tower Attack [range 36, dps 4]; Armored Tower |
| 2 | 5 |  | Bunker Tower |  | 75 | Improves health and attack damage. | Tower Attack [range 36, dps 4]; Bunker Tower |
| 3 | 15 |  | Archers Spire |  | 350 | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Archers Spire; Archers Spire Visuals |
| 3 | 15 |  | Ballistic Spire |  |  | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Ballistic Spire; Ballistic Spire Visuals |
| 3 | 15 |  | Fire Spire |  | 250 | Choose between several upgrades. | Tower Attack [range 36, dps 4]; PourHotOil; Fire Spire; Fire Spire Visuals |
| 3 | 15 |  | Healing Spire |  | 750 | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Healing Spire Visuals; Healing Spire |
| 4 | 40 |  | Insane Damage |  |  | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Insane Damage |
| 4 | 40 |  | Insane Range |  |  | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Insane Range |
| 4 | 40 |  | Insane Health |  | 2500 | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Insane Health |
| 4 | 40 |  | Hunting Equipment | 3 |  | Choose between several upgrades. | Tower Attack [range 36, dps 4]; Hunting Equipment |

### Barracks

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 4 |  | Knights |  |  | Choose a melee unit type. | Knights [12× Knights (HP 105, speed 4, range 3.5, dps 2.5); respawn s by level [15.0, 10.0, 6.0, 6.0]]; 4× Knights [HP 105; range 3.5, dps 2.5] |
| 1 | 4 |  | Speermen |  |  | Choose a melee unit type. | Speers [12× Spearmen (HP 66, speed 9.5, range 5.5, dps 4.04); respawn s by level [15.0, 10.0, 6.0, 6.0]]; 4× Spearmen [HP 66; range 5.5, dps 4.04] |
| 1 | 4 |  | Flails |  |  | Choose a melee unit type. | Morningstars [12× Flails (HP 70, speed 5, range 4, dps 1.65); respawn s by level [15.0, 10.0, 6.0, 6.0]]; 4× Flails [HP 70; range 4, dps 1.65] |
| 1 | 4 |  | Berserks |  |  | Choose a melee unit type. | Berserks [12× Berserks (HP 58, speed 6.5, range 3, dps 5); respawn s by level [15.0, 10.0, 6.0, 6.0]]; 4× Berserks [HP 58; range 3, dps 5] |
| 2 | 8 |  |  |  | 10 | More units, faster unit respawn. | 4× Knights [HP 105; range 3.5, dps 2.5]; 4× Spearmen [HP 66; range 5.5, dps 4.04]; 4× Flails [HP 70; range 4, dps 1.65]; 4× Berserks [HP 58; range 3, dps 5] |
| 3 | 16 |  |  |  | 10 | More units, faster unit respawn. | 4× Knights [HP 105; range 3.5, dps 2.5]; 4× Spearmen [HP 66; range 5.5, dps 4.04]; 4× Flails [HP 70; range 4, dps 1.65]; 4× Berserks [HP 58; range 3, dps 5] |
| 4 | 50 |  |  |  | 150 | Stronger Units | Upgrade To Lvl 4 |

### Archery Range

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 4 |  | Longbow Archers |  |  | Choose a ranged unit type. | Longbows [12× Longbow Archers (HP 25, speed 9, range 50, dps 2); respawn s by level [15.0, 10.0, 6.0, 6.0]] |
| 1 | 4 |  | Crossbowpeople |  |  | Choose a ranged unit type. | Crossbows [12× Crossbowmen (HP 45, speed 4, range 21, dps 3.5); respawn s by level [15.0, 10.0, 6.0, 6.0]] |
| 1 | 4 |  | Hunters |  |  | Choose a ranged unit type. | Hunters [12× Hunters (HP 45, speed 6, range 35, dps 1.96); respawn s by level [15.0, 10.0, 6.0, 6.0]] |
| 1 | 4 |  | Fire Archers |  |  | Choose a ranged unit type. | Fire Archers [12× Fire Archers (HP 20, speed 3.5, range 25, dps 1.5); respawn s by level [15.0, 10.0, 6.0, 6.0]] |
| 2 | 8 |  |  |  | 10 | More units, faster respawn. | 4× Longbow Archers [HP 25; range 50, dps 2]; 4× Crossbowmen [HP 45; range 21, dps 3.5]; 4× Hunters [HP 45; range 35, dps 1.96; range 3.5, dps 5.48]; 4× Fire Archers [HP 20; range 25, dps 1.5] |
| 3 | 16 |  |  |  | 10 | More units, faster respawn. | 4× Longbow Archers [HP 25; range 50, dps 2]; 4× Crossbowmen [HP 45; range 21, dps 3.5]; 4× Hunters [HP 45; range 35, dps 1.96; range 3.5, dps 5.48]; 4× Fire Archers [HP 20; range 25, dps 1.5] |
| 4 | 50 |  |  |  | 150 | More units, faster respawn. | Upgrade To Lvl 4 |

### Blacksmith

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 4 |  | Melee Attack |  |  | Can research upgrades. Upgrades apply to you, your troups an | MeleeAttack; MA1 |
| 1 | 4 |  | Ranged Attack |  |  | Can research upgrades. Upgrades apply to you, your troups an | RangedAttack; RA1 |
| 1 | 4 |  | Melee Armor |  |  | Can research upgrades. Upgrades apply to you, your troups an | MeleeResistance; 2× MR1 |
| 1 | 4 |  | Ranged Armor |  |  | Can research upgrades. Upgrades apply to you, your troups an | RangedResistance; 2× RR1 |
| 2 | 9 |  | Melee Attack |  |  | Researches upgrades. Upgrades apply to you, your troups and  | MeleeAttack; MA2 |
| 2 | 9 |  | Ranged Attack |  |  | Researches upgrades. Upgrades apply to you, your troups and  | RangedAttack; RA2 |
| 2 | 9 |  | Melee Armor |  |  | Researches upgrades. Upgrades apply to you, your troups and  | MeleeResistance; 2× MR2 |
| 2 | 9 |  | Ranged Armor |  |  | Researches upgrades. Upgrades apply to you, your troups and  | RangedResistance; 2× RR2 |
| 3 | 16 |  | Melee Attack |  |  | Researches upgrades. Upgrades apply to you, your troups and  | MeleeAttack; MA3 |
| 3 | 16 |  | Ranged Attack |  |  | Researches upgrades. Upgrades apply to you, your troups and  | RangedAttack; RA3 |
| 3 | 16 |  | Melee Armor |  |  | Researches upgrades. Upgrades apply to you, your troups and  | MeleeResistance; 2× MR3 |
| 3 | 16 |  | Ranged Armor |  |  | Researches upgrades. Upgrades apply to you, your troups and  | RangedResistance; 2× RR3 |

### Mill

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 3 |  | Improved Plow | 1 |  | Unlocks the option to build fields to increase income. | Auto Attack Lvl 1 [range 38, dps 1.21]; Lvl 1 Rotor; Improved Plow |
| 1 | 3 |  | Explosive Trap | 1 |  | Unlocks the option to build fields to increase income. | Auto Attack Lvl 1 [range 38, dps 1.21]; Lvl 1 Rotor; Explosive Trap |
| 1 | 3 |  | Scarecrows | 1 |  | Unlocks the option to build fields to increase income. | Auto Attack Lvl 1 [range 38, dps 1.21]; Lvl 1 Rotor; Scarecrows |
| 1 | 3 |  | Wind Spirits | 1 |  | Unlocks the option to build fields to increase income. | Auto Attack Lvl 1 [range 38, dps 1.21]; Lvl 1 Rotor; Wind Spirits [Auto Attack Lvl 1: range 38, dps 1.21; Auto Attack Lvl 2: range 38, dps 2; Auto Attack Lvl 3: range 38, dps 4] |
| 2 | 4 |  |  | 1 | 20 | Increases income significantly. | Lvl 2 Rotor; Auto Attack Lvl 2 [range 38, dps 2] |
| 3 | 6 |  |  | 4 | 30 | Increases income significantly. | Lvl 3 Rotor; Auto Attack Lvl 3 [range 38, dps 4] |

### House

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 2 |  |  | 1 |  | A stable income source. | AutoAttackPerk Lvl1 [range 34, dps 1.6] |
| 2 | 2 |  |  | 1 | 10 | Icreases daily income. | AutoAttackPerk Lvl2 [range 34, dps 4.82] |
| 3 | 20 |  |  | 2 | 70 | Icreases daily income. |  |

### Shrine

| Lvl | Gold | Cores | Choice | Income | HP + | Tooltip | Activates |
|:---:|---:|---:|---|---:|---:|---|---|
| 1 | 3 |  |  |  |  | Shoots at enemies. |  |

## 6. Practical numbers for planning

* Hero-reachable ground: **7959 m²** (unbuilt world) of 8448 m² navmesh; 119 blocking colliders ({'static': 16, 'building': 103}), 8 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 144–240 m (7.9 s at day speed).

* 80/80 build slots have at least one collision-free stand point within interaction range (`terrain/09_Sturmklamm.json → slots[].standPoints`); median walking distance castle→stand point 118 m.

* 6 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
