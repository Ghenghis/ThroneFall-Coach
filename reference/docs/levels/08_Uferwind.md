# Uferwind — level handbook

*Generated from the shipped asset files (build index 8, scene file `level8`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Frostsee** |
| Nights (waves) | 12 |
| Enemies in total | 662 |
| Total enemy base HP | 37134 |
| Gold coins dropped by waves (sum of `goldCoins`) | 146 |
| Flying enemies / bosses | 281 / 0 |
| Enemy spawn lines | 13 |
| Build slots | 117 |
| Shrines | 5 |
| Starting gold (`goldBalanceAtStart`) | 18 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | 10.2, 17.6, -51.7 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/08_Uferwind_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Spawn 3 | (-65, 24) | 29.5 | air/small/big | Normal | 134 | 0.5 | (-62, 12) | Spawn 2, Spawn 4 |
| Spawn 6 | (51, 8) | 18 | air/small/big | Normal | 159 | 0.5 | (-29, -38) | Spawn 5, Spawn 7 |
| Spawn 1 Air | (-50, -182) | 47.7 | air | Normal | 136 | 0.5 | (6, -136) | Spawn 2 Air |
| Spawn 4 Air | (94, -64) | 42.7 | air | Normal | 153 | 0.5 | (18, -26) | Spawn 3 Air |
| Spawn 2 Air | (28, -206) | 41.6 | air | Normal | 129 | 0.5 | (6, -136) | Spawn 1 Air, Spawn 3 Air |
| Spawn 3 Air | (80, -143) | 51.9 | air | Normal | 67 | 0.5 | (28, -78) | Spawn 2 Air, Spawn 4 Air |
| Spawn | (42, -96) | 1.6 | air/small/big | Normal | 58 | 0.5 | (28, -78) | – |
| Spawn | (7, -154) | 1.6 | air/small/big | Normal | 117 | 0.5 | (7, -135) | – |
| Spawn 7 | (66, -16) | 13.8 | air/small/big | Normal | 165 | 0.5 | (-29, -38) | Spawn 6, Spawn 4 Air, Spawn 5 |
| Spawn 2 | (-94, 0) | 12.7 | air/small/big | Normal | 127 | 0.5 | (-33, -52) | Spawn 1, Spawn 3 |
| Spawn 1 | (-99, -66) | 67.3 | air/small/big | Normal | 115 | 0.5 | (-31, -53) | Spawn 2 |
| Spawn 4 | (-34, 36) | 15.4 | air/small/big | Normal | 136 | 0.5 | (-30, -9) | Spawn 3, Spawn 5 |
| Spawn 5 | (20, 32) | 13.8 | air/small/big | Normal | 150 | 0.5 | (-29, -38) | Spawn 4, Spawn 6, Spawn 7 |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Weaklings | 47 | 409 | 0 | 0 | 0 | 10 | 47× Peasant | Spawn 1:12, Spawn 2:5, Spawn 3:6, Spawn 4:6, Spawn 5:6, Spawn 6:6, Spawn 7:6 | 29 | 42 |
| 2 | Spears & Archers | 18 | 400 | 10 | 0 | 0 | 7 | 10× Archer, 8× Pikes | Spawn 6:8, Spawn 7:10 | 32 | 42 |
| 3 | Furies | 7 | 525 | 7 | 7 | 0 | 11 | 7× Fury | Spawn 1:1, Spawn 2:1, Spawn 3:1, Spawn 4:1, Spawn 5:1, Spawn 6:1, Spawn 7:1 | 22 | 39 |
| 4 | Spears & Archers | 41 | 900 | 25 | 0 | 0 | 12 | 25× Archer, 16× Pikes | Spawn 1:41 | 23 | 38 |
| 5 | Huge Flyer Wave From the Sea, Riders on Land | 32 | 1380 | 20 | 20 | 0 | 14 | 12× Wasp, 12× Monster Rider, 8× Fury | Spawn 1 Air:5, Spawn 2 Air:5, Spawn 3 Air:5, Spawn 4 Air:5, Spawn 5:12 | 14 | 52 |
| 6 | Barrel Knights | 38 | 3800 | 0 | 0 | 0 | 14 | 38× Barrel Knight | Spawn 7:5, Spawn 6:5, Spawn 5:6, Spawn 4:5, Spawn 3:6, Spawn 2:5, Spawn 1:6 | 14 | 23 |
| 7 | Flying Wizzards | 25 | 1125 | 25 | 25 | 0 | 7 | 25× Flying Mage | Spawn 1:25 | 16 | 20 |
| 8 | Huge Flyer Wave From the Sea, Archers and Spears on Land | 78 | 2425 | 53 | 28 | 0 | 12 | 25× Pikes, 25× Archer, 16× Wasp, 12× Fury | Spawn 1 Air:7, Spawn 2 Air:7, Spawn 3 Air:7, Spawn 4 Air:7, Spawn 3:50 | 16 | 52 |
| 9 | Barrel Knights and Flying Wizzards | 80 | 6075 | 35 | 35 | 0 | 28 | 45× Barrel Knight, 35× Flying Mage | Spawn 7:11, Spawn 6:12, Spawn 5:11, Spawn 4:12, Spawn 3:11, Spawn 2:12, Spawn 1:11 | 10 | 25 |
| 10 | Racers and furies from the back. Flyers from the sea. | 75 | 3625 | 50 | 50 | 0 | 15 | 30× Fury, 25× Racer, 20× Wasp | Spawn 7:25, Spawn 6:30, Spawn 4 Air:20 | 11 | 30 |
| 11 | Big attack wave from the front | 96 | 6200 | 40 | 40 | 0 | 16 | 40× Flying Mage, 40× Pikes, 12× Ogre, 4× Ram | Spawn 1:96 | 16 | 62 |
| 12 | Final attack from all sides | 125 | 10270 | 76 | 76 | 0 | 0 | 46× Flying Mage, 42× Barrel Knight, 30× Fury, 7× Ram | Spawn 1:17, Spawn 2:17, Spawn 3:19, Spawn 4:17, Spawn 5:19, Spawn 6:17, Spawn 7:19 | 10 | 73 |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 12 (10270 HP, 125 enemies); night-to-night HP ratio (last/first) = 25.1×. Ranged enemies appear on nights 2, 3, 4, 5, 7, 8, 9, 10, 11, 12; flyers on nights 3, 5, 7, 8, 9, 10, 11, 12.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Peasant | E Weakling | 9 | 4 | 3 | 1 | 1 | 1 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Peasants equipped with clubs. Not an enemy to worry about, unless they appear in bigger numbers. |
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Pikes | E LongSpear | 25 | 5 | 6 | 3.5 | 1 | 3.5 | MeeleFighter, VulnerableVsRanged, NaturallyVulnerableToSplash, Humanoid | Equipped with long spears. Your horse is slowed and you take additional damage when riding into them, even mor |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Monster Rider | E Monster Rider | 40 | 11 | 4 | 3 | 1 | 3 | MeeleFighter, FastMoving, Monster, Humanoid | Monster riders are fast and durable melee warriors. A man meets monster synergy that should not be underestima |
| Flying Mage | E Flying Wizzard | 45 | 7 | 17 | 2 | 2 | 1 | RangedFighter, Flying, Humanoid | Shoots magical projectiles that deal splash damage. Prefers attacking your units. |
| Fury | E Fury | 75 | 3 | 15 | 30 | 4 | 7.5 | RangedFighter, Flying, Monster | A large flying monster that focusses on destroying your defenses. Their projectiles are quite slow and easy to |
| Barrel Knight | E BarrelKnight | 100 | 8 | 3.2 | 3.5 | 1.25 | 2.8 | MeeleFighter, SiegeWeapon, NaturallyHighHealthTarget | An enchanted warrior made of wood. Counts as a siege weapon and is armored against ranged attacks. Quite sturd |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |
| Ram | E Ram | 250 | 2.2 | 3.5 | 15 | 2 | 7.5 | MeeleFighter, SiegeWeapon, ArmoredAgainstRanged, NaturallyHighHealthTarget, LargeUnit | Rams are siege units with a ton of health looking to tear down your walls and buildings. Furthermore, they are |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 25 | economy | Mill upgrade #1 ×10, Mill upgrade #2 ×15 | 6 g ×6, 10 g ×9, 13 g ×4, 17 g ×6 | 1 | 1 | 1 | – |
| House | 13 | economy | Castle Center upgrade #1 ×4, House upgrade #1 ×9 | 3 g ×4, 5 g ×4, 7 g ×3, 9 g ×1, 11 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 5 | economy | Castle Center upgrade #1 ×3, Castle Center upgrade #2 ×2 | 3 g ×3, 10 g ×2 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #1 ×2 | 3 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #1 ×2 | 3 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Bridge | 3 | other | Castle Center upgrade #1 ×3 | 3 g ×3 | 1 | 2 | 1 | 0 |
| Harbour | 3 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×2 | 3 g ×1, 10 g ×2 | 2 | 3 → 7 | 0 | 0 |
| Hero's Quarter | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Summoning Circle | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 1 → 2 | 0 | 0 |
| Shrine | 5 | shrine | Castle Center upgrade #1 ×5 | 3 g ×5 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 26 | tower | Castle Center upgrade #1 ×15, Castle Center upgrade #2 ×11 | 3 g ×15, 10 g ×11 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 28 | wall | Castle Center upgrade #1 ×2, Wall upgrade #1 ×26 (shares its activator's upgrades) | 3 g ×2, 6 g ×2, 18 g ×24 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 2× Archery Range, 2× Barracks, 1× Blacksmith, 3× Bridge, 15× Defense Tower, 1× Harbour, 1× Hero's Quarter, 4× House, 3× Mill, 5× Shrine, 2× Summoning Circle, 2× Wall; **5 g** → 4× House; **6 g** → 6× Field, 2× Wall; **7 g** → 3× House; **9 g** → 1× House; **10 g** → 11× Defense Tower, 9× Field, 2× Harbour, 2× Mill; **11 g** → 1× House; **13 g** → 4× Field; **17 g** → 6× Field; **18 g** → 24× Wall.

**Totals:** building every slot to its final level costs **4235 gold**; if everything is at maximum level the buildings pay **208 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **15666 m²** (unbuilt world) of 16029 m² navmesh; 170 blocking colliders ({'static': 22, 'building': 148}), 20 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 49–159 m (2.7 s at day speed).

* 117/117 build slots have at least one collision-free stand point within interaction range (`terrain/08_Uferwind.json → slots[].standPoints`); median walking distance castle→stand point 96 m.

* 5 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
