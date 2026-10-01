# Nordfels — level handbook

*Generated from the shipped asset files (build index 5, scene file `level5`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Neuland(Tutorial)** |
| Nights (waves) | 13 |
| Enemies in total | 576 |
| Total enemy base HP | 17735 |
| Gold coins dropped by waves (sum of `goldCoins`) | 88 |
| Flying enemies / bosses | 70 / 0 |
| Enemy spawn lines | 7 |
| Build slots | 69 |
| Shrines | 6 |
| Starting gold (`goldBalanceAtStart`) | 8 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -4.5, 0, 1.1 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/05_Nordfels_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Right Bridge | (54, -64) | 16.4 | air/small/big | Normal | 89 | 5.2 | (49, -57) | Forest |
| Main Bridge | (-6, -89) | 20.3 | air/small/big | Normal | 91 | 5 | (-6, -72) | – |
| Fly - River | (-53, -54) | 89.2 | air | Normal | 72 | 2.5 | (-45, -46) | Fly - River |
| Spawn | (56, -12) | 1.6 | air/small/big | Normal | 67 | 0.5 | (34, -12) | – |
| Spawn | (-45, -35) | 1.6 | air/small/big | Normal | 56 | 14.3 | (-38, -32) | – |
| Forest | (72, -1) | 11.8 | air/small/big | Normal | 87 | 0.5 | (57, -2) | Right Bridge |
| Fly - Pond | (-65, 19) | 22.8 | air | Normal | 44 | 0.5 | (-38, 4) | Fly - Pond |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | 3 Swordsmen approaching from southern bridge | 3 | 75 | 0 | 0 | 0 | 5 | 3× Swordsman | Main Bridge:3 | 18 | 24 |
| 2 | 8 Swordsmen approaching from the forest | 8 | 200 | 0 | 0 | 0 | 5 | 8× Swordsman | Forest:8 | 17 | 24 |
| 3 | 2 Hunterlings coming from the forest will hunt you, 8 Melee coming from the southern bridg | 10 | 260 | 0 | 0 | 0 | 5 | 8× Swordsman, 2× Hunterling | Forest:2, Main Bridge:8 | 9 | 22 |
| 4 | 24 Archers from all directions | 24 | 480 | 24 | 0 | 0 | 8 | 24× Archer | Forest:8, Right Bridge:8, Main Bridge:8 | 18 | 41 |
| 5 | 15 Racers from the southern bridge will try to run straight to your castle center to destr | 15 | 525 | 0 | 0 | 0 | 2 | 15× Racer | Main Bridge:15 | 9 | 23 |
| 6 | 20 Swordsmen and 20 archers arriving from the southern bridge | 40 | 900 | 20 | 0 | 0 | 5 | 20× Swordsman, 20× Archer | Main Bridge:40 | 18 | 47 |
| 7 | 15 Flyers coming over the pond in the west | 15 | 375 | 15 | 15 | 0 | 5 | 15× Wasp | Fly - Pond:15 | 8 | 22 |
| 8 | 30 Melee from the southern bridge, 10 Hunterlings and 10 Racers coming from the forest | 50 | 1400 | 0 | 0 | 0 | 9 | 30× Swordsman, 10× Racer, 10× Hunterling | Main Bridge:30, Forest:20 | 9 | 47 |
| 9 | 5 Ogres coming from the southern bridge, 25 Flyers trickling in from all directions | 30 | 1625 | 25 | 25 | 0 | 13 | 25× Wasp, 5× Ogre | Main Bridge:5, Fly - River:10, Right Bridge:5, Forest:5, Fly - Pond:5 | 8 | 47 |
| 10 | 90 Melee Units and 3 Ogers from all directions | 93 | 2850 | 0 | 0 | 0 | 12 | 90× Swordsman, 3× Ogre | Forest:31, Right Bridge:31, Main Bridge:31 | 17 | 62 |
| 11 | 30 Racers & 50 Archers from southern bridge | 80 | 2050 | 50 | 0 | 0 | 14 | 50× Archer, 30× Racer | Main Bridge:80 | 9 | 43 |
| 12 | There is no serious attack tonight. Only a few scouts. The enemy is preparing for their fi | 5 | 150 | 0 | 0 | 0 | 5 | 5× Hunterling | Right Bridge:5 | 9 | 13 |
| 13 | Final attack. Catapults, ogres, archers, flyers. Make Your Last Stand! It's gonna be a lon | 203 | 6845 | 76 | 30 | 0 | 0 | 80× Swordsman, 35× Racer, 30× Wasp, 30× Archer, 16× Catapult, 7× Ogre, 5× Hunterling | Main Bridge:86, Fly - River:15, Fly - Pond:5, Right Bridge:55, Forest:42 | 9 | 166 |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 13 (6845 HP, 203 enemies); night-to-night HP ratio (last/first) = 91.3×. Ranged enemies appear on nights 4, 6, 7, 9, 11, 13; flyers on nights 7, 9, 13.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Hunterling | E Hunterling | 30 | 10 | 3.5 | 5 | 0.5 | 10 | MeeleFighter, FastMoving, Monster, NaturallyVulnerableToSplash | Hunterlings are incredibly fast and dangerous monsters with the sole aim of chasing you down. They can smell y |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Catapult | E Catapult | 45 | 2 | 26.4 | 150 | 5 | 30 | RangedFighter, SiegeWeapon | Catapults are siege units that deal massive damage to your buildings from afar. Your only chance is to get clo |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 15 | economy | Mill upgrade #1 ×6, Mill upgrade #2 ×9 | 6 g ×6, 10 g ×9 | 1 | 1 | 1 | – |
| House | 11 | economy | Castle Center upgrade #1 ×1, House upgrade #1 ×6, Wall upgrade #1 ×1, Castle Center upgrade #2 ×2, Castle Center upgrade #3 ×1 | 3 g ×1, 5 g ×1, 7 g ×1, 9 g ×1, 10 g ×2, 11 g ×1, 12 g ×1, 14 g ×1, 16 g ×1, 30 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 3 | economy | Castle Center upgrade #1 ×3 | 3 g ×3 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Summoning Circle | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 1 → 2 | 0 | 0 |
| Shrine | 6 | shrine | Castle Center upgrade #1 ×6 | 3 g ×6 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 10 | tower | Castle Center upgrade #1 ×2, Castle Center upgrade #2 ×4, Castle Center upgrade #3 ×4 | 3 g ×2, 10 g ×4, 30 g ×4 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 16 | wall | Wall upgrade #1 ×12, Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×3 (shares its activator's upgrades) | 10 g ×1, 14 g ×6, 30 g ×3, 33 g ×6 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Blacksmith, 2× Defense Tower, 1× House, 3× Mill, 6× Shrine, 2× Summoning Circle; **5 g** → 1× House; **6 g** → 6× Field; **7 g** → 1× House; **9 g** → 1× House; **10 g** → 1× Archery Range, 1× Barracks, 4× Defense Tower, 9× Field, 2× House, 1× Wall; **11 g** → 1× House; **12 g** → 1× House; **14 g** → 1× House, 6× Wall; **16 g** → 1× House; **30 g** → 1× Archery Range, 1× Barracks, 4× Defense Tower, 1× House, 3× Wall; **33 g** → 6× Wall.

**Totals:** building every slot to its final level costs **2348 gold**; if everything is at maximum level the buildings pay **127 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **7822 m²** (unbuilt world) of 8087 m² navmesh; 106 blocking colliders ({'static': 11, 'building': 95}), 12 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 47–86 m (2.6 s at day speed).

* 69/69 build slots have at least one collision-free stand point within interaction range (`terrain/05_Nordfels.json → slots[].standPoints`); median walking distance castle→stand point 30 m.

* 6 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
