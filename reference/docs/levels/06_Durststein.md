# Durststein — level handbook

*Generated from the shipped asset files (build index 6, scene file `level6`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Nordfels** |
| Nights (waves) | 12 |
| Enemies in total | 826 |
| Total enemy base HP | 35692 |
| Gold coins dropped by waves (sum of `goldCoins`) | 35 |
| Flying enemies / bosses | 0 / 0 |
| Enemy spawn lines | 10 |
| Build slots | 94 |
| Shrines | 5 |
| Starting gold (`goldBalanceAtStart`) | 16 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -10.2, 13.5, 18.2 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/06_Durststein_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| FarmFlyers | (142, 69) | 16 | air | Normal | 136 | 0.5 | (69, 26) | – |
| High Back Road | (-33, 136) | 34.9 | air/small | Normal | 210 | 0.5 | (-42, 110) | – |
| FrontFlyersRight | (57, -45) | 29.2 | air | Normal | 85 | 0.5 | (39, -8) | FrontFlyersLeft |
| Left Front Road | (-138, 18) | 10.6 | air/small/big | EasierForPlayerToDealWith | 202 | 0.5 | (-134, 11) | Left Back Road |
| Spawn | (-54, 87) | 1.6 | air/small/big | Normal | 155 | 0.5 | (-44, 56) | – |
| Spawn | (88, 3) | 1.6 | air/small/big | Normal | 104 | 3.5 | (61, 3) | – |
| Front Road | (-36, -44) | 23.1 | air/small/big | Normal | 180 | 0.5 | (-37, -18) | FrontFlyersLeft |
| FrontFlyersLeft | (8, -41) | 44.1 | air | Normal | 91 | 0.5 | (38, -10) | FrontFlyersRight, Front Road |
| Left Back Road | (-108, 56) | 52 | air/small/big | Normal | 114 | 0.5 | (-89, 44) | Left Front Road |
| Right Farm Road | (147, -13) | 14 | air/small/big | Normal | 184 | 0.5 | (141, 12) | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | 10 Monster Riders From Front | 8 | 320 | 0 | 0 | 0 | 3 | 8× Monster Rider | Front Road:8 | 16 | 25 |
| 2 | Town Center Racers From Left | 26 | 437 | 0 | 0 | 0 | 4 | 18× Peasant, 8× Racer | Left Front Road:8, Left Back Road:18 | 20 | 45 |
| 3 | Attack wave from right | 24 | 650 | 14 | 0 | 0 | 3 | 14× Archer, 8× Monster Rider, 2× Swordsman | Right Farm Road:16, Front Road:8 | 16 | 43 |
| 4 | Attack wave from top path | 47 | 1160 | 10 | 0 | 0 | 3 | 30× Swordsman, 10× Archer, 7× Hunterling | High Back Road:32, Right Farm Road:15 | 21 | 78 |
| 5 | Round 2 \| Exploders from the Front | 25 | 825 | 0 | 0 | 0 | 4 | 20× Swordsman, 5× Exploder | Front Road:25 | 20 | 55 |
| 6 | Raid from top and right | 52 | 1360 | 30 | 0 | 0 | 4 | 30× Archer, 12× Hunterling, 10× Monster Rider | High Back Road:12, Right Farm Road:40 | 17 | 43 |
| 7 | Raid from front and left | 30 | 1515 | 12 | 0 | 0 | 4 | 12× Archer, 12× Monster Rider, 3× Ogre, 3× Exploder | Left Back Road:15, Left Front Road:3, Front Road:12 | 16 | 42 |
| 8 | Attack from right, high and front | 46 | 2495 | 0 | 0 | 0 | 4 | 36× Swordsman, 7× Ogre, 3× Exploder | Front Road:15, Right Farm Road:16, High Back Road:15 | 35 | 66 |
| 9 | A billion monster riders from all main directions | 105 | 4200 | 0 | 0 | 0 | 4 | 105× Monster Rider | Right Farm Road:35, Front Road:35, Left Front Road:35 | 16 | 69 |
| 10 | Giga wave from left. Hunters from top. | 76 | 2570 | 17 | 0 | 0 | 1 | 25× Hunterling, 15× Swordsman, 15× Archer, 15× Racer, 2× Ogre, 2× Catapult, 2× Exploder | High Back Road:25, Left Back Road:34, Left Front Road:17 | 20 | 59 |
| 11 | Ogres from right, Racers from front | 49 | 4025 | 0 | 0 | 0 | 1 | 35× Racer, 14× Ogre | Right Farm Road:14, Front Road:35 | 18 | 59 |
| 12 | Final Mega Wave | 338 | 16135 | 38 | 0 | 0 | 0 | 150× Monster Rider, 50× Swordsman, 35× Archer, 35× Hunterling, 25× Ogre, 20× Racer, 20× Exploder, 3× Catapult | Front Road:93, Right Farm Road:73, Left Front Road:28, Left Back Road:81, High Back Road:63 | 10 | 189 |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 12 (16135 HP, 338 enemies); night-to-night HP ratio (last/first) = 50.4×. Ranged enemies appear on nights 3, 4, 6, 7, 10, 12; flyers on nights none.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Peasant | E Weakling | 9 | 4 | 3 | 1 | 1 | 1 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Peasants equipped with clubs. Not an enemy to worry about, unless they appear in bigger numbers. |
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Hunterling | E Hunterling | 30 | 10 | 3.5 | 5 | 0.5 | 10 | MeeleFighter, FastMoving, Monster, NaturallyVulnerableToSplash | Hunterlings are incredibly fast and dangerous monsters with the sole aim of chasing you down. They can smell y |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Monster Rider | E Monster Rider | 40 | 11 | 4 | 3 | 1 | 3 | MeeleFighter, FastMoving, Monster, Humanoid | Monster riders are fast and durable melee warriors. A man meets monster synergy that should not be underestima |
| Catapult | E Catapult | 45 | 2 | 26.4 | 150 | 5 | 30 | RangedFighter, SiegeWeapon | Catapults are siege units that deal massive damage to your buildings from afar. Your only chance is to get clo |
| Exploder | E Exploder | 65 | 9 | 4 | 3.5 | 1 | 3.5 | MeeleFighter, FastMoving, TakesReducedDamageFromPlayerAttacks, Monster, SiegeWeapon, Exploding | Exploders are monsters that roll straight for the closest building and explode when they die. They are slightl |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 20 | economy | Mill upgrade #1 ×8, Mill upgrade #2 ×12 | 6 g ×6, 10 g ×9, 13 g ×2, 17 g ×3 | 1 | 1 | 1 | – |
| House | 13 | economy | Castle Center upgrade #1 ×3, House upgrade #1 ×9, Castle Center upgrade #2 ×1 | 3 g ×3, 5 g ×4, 7 g ×2, 9 g ×1, 10 g ×1, 11 g ×1, 12 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 4 | economy | Castle Center upgrade #1 ×3, Castle Center upgrade #2 ×1 | 3 g ×3, 10 g ×1 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barricades | 8 | other | Barricades upgrade #1 ×3, Castle Center upgrade #2 ×3, Castle Center upgrade #3 ×2 | 10 g ×3, 14 g ×3, 30 g ×2 | 1 | 4 | 0 | 1 |
| Gold Mine | 3 | other | Castle Center upgrade #1 ×3 | 3 g ×3 | 1 | 5 | 6 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 5 | shrine | Castle Center upgrade #1 ×5 | 3 g ×5 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | from the start ×1 | 0 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 16 | tower | Castle Center upgrade #1 ×9, Castle Center upgrade #2 ×7 | 3 g ×9, 10 g ×7 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 15 | wall | Castle Center upgrade #1 ×1, Wall upgrade #1 ×9, Castle Center upgrade #2 ×5 (shares its activator's upgrades) | 3 g ×1, 6 g ×4, 10 g ×5, 13 g ×5 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Blacksmith, 1× Castle Center; **3 g** → 1× Archery Range, 1× Barracks, 9× Defense Tower, 3× Gold Mine, 3× House, 3× Mill, 1× Royal Forge, 5× Shrine, 2× Summoning Circle, 1× Temple, 1× Wall; **5 g** → 4× House; **6 g** → 6× Field, 4× Wall; **7 g** → 2× House; **9 g** → 1× House; **10 g** → 1× Archery Range, 1× Barracks, 3× Barricades, 7× Defense Tower, 9× Field, 1× House, 1× Mill, 5× Wall; **11 g** → 1× House; **12 g** → 1× House; **13 g** → 2× Field, 5× Wall; **14 g** → 3× Barricades; **17 g** → 3× Field; **30 g** → 2× Barricades.

**Totals:** building every slot to its final level costs **2843 gold**; if everything is at maximum level the buildings pay **182 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **15121 m²** (unbuilt world) of 15415 m² navmesh; 136 blocking colliders ({'static': 22, 'building': 114}), 16 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 96–205 m (5.2 s at day speed).

* 94/94 build slots have at least one collision-free stand point within interaction range (`terrain/06_Durststein.json → slots[].standPoints`); median walking distance castle→stand point 74 m.

* 5 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
