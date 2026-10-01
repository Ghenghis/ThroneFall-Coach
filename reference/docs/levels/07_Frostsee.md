# Frostsee — level handbook

*Generated from the shipped asset files (build index 7, scene file `level7`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Durststein** |
| Nights (waves) | 13 |
| Enemies in total | 453 |
| Total enemy base HP | 17120 |
| Gold coins dropped by waves (sum of `goldCoins`) | 84 |
| Flying enemies / bosses | 62 / 0 |
| Enemy spawn lines | 8 |
| Build slots | 73 |
| Shrines | 5 |
| Starting gold (`goldBalanceAtStart`) | 7 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | 9.2, 13.5, 7.6 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/07_Frostsee_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Right River AIR | (40, -77) | 29.8 | air | Normal | 55 | 1.5 | (9, -38) | Far Right, Close Right |
| Far Right | (-76, -113) | 22.2 | air/small/big | Normal | 156 | 1.1 | (-57, -82) | Close Right, Right River AIR |
| Close Left | (-38, 60) | 9.4 | air/small/big | HarderForPlayerToDealWith | 76 | 0.5 | (-14, 25) | Far Left |
| Spawn | (-109, 12) | 1.6 | air/small/big | Normal | 146 | 0.5 | (-95, 29) | – |
| Spawn | (-28, -55) | 1.6 | air/small/big | Normal | 78 | 7.4 | (9, -1) | – |
| Close Right | (-28, -76) | 7.6 | air/small/big | Normal | 98 | 6.5 | (-27, -68) | Far Right, Right River AIR |
| Far Left | (-145, -14) | 16.1 | air/small/big | EasierForPlayerToDealWith | 198 | 0.5 | (-99, -55) | Close Left |
| BOSS FIGHT | (-53, -11) | 17.1 | – | n/a | – | – | – | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Melee Left | 7 | 175 | 0 | 0 | 0 | 4 | 7× Swordsman | Close Left:7 | 15 | 27 |
| 2 | SLIMES Introduction | 17 | 212 | 0 | 0 | 0 | 4 | 17× Slime | Close Right:17 | 20 | 21 |
| 3 | CROSSBOW Introduction | 4 | 160 | 4 | 0 | 0 | 2 | 4× Master Crossbowmen | Close Left:4 | 21 | 27 |
| 4 | Lots of Slimes Right | 45 | 562 | 0 | 0 | 0 | 3 | 45× Slime | Close Right:45 | 20 | 33 |
| 5 | RAM Introduction | 11 | 500 | 0 | 0 | 0 | 6 | 10× Swordsman, 1× Ram | Close Left:11 | 15 | 34 |
| 6 | Flying Units | 9 | 225 | 9 | 9 | 0 | 6 | 9× Wasp | Right River AIR:9 | 11 | 27 |
| 7 | Ram & Crossbow Push | 16 | 1060 | 14 | 0 | 0 | 8 | 14× Master Crossbowmen, 2× Ram | Far Left:8, Close Left:8 | 19 | 88 |
| 8 | STRONG SLIME Introduction | 38 | 1780 | 0 | 0 | 0 | 5 | 30× Spiky Slime, 8× Racer | Close Right:30, Far Right:8 | 16 | 31 |
| 9 | Big Flyer Wave | 33 | 825 | 33 | 33 | 0 | 8 | 33× Wasp | Right River AIR:12, Close Left:7, Far Left:7, Far Right:7 | 9 | 31 |
| 10 | Huge human army from far left | 59 | 3400 | 10 | 0 | 0 | 8 | 40× Swordsman, 10× Master Crossbowmen, 5× Ogre, 4× Ram | Far Left:59 | 40 | 118 |
| 11 | Huge monster army from far right | 70 | 2550 | 20 | 20 | 0 | 8 | 30× Racer, 20× Spiky Slime, 20× Wasp | Far Right:70 | 16 | 50 |
| 12 | Big boss like wave with stuff coming from all directions | 143 | 5670 | 8 | 0 | 0 | 22 | 45× Swordsman, 34× Slime, 20× Racer, 17× Spiky Slime, 10× Hunterling, 8× Master Crossbowmen, 6× Ogre, 3× Ram | Close Right:51, Far Right:30, Close Left:30, Far Left:32 | 15 | 98 |
| 13 | BOSS FIGHT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! | 1 | 0 | 0 | 0 | 0 | 0 | 1× Shadow In The Water | BOSS FIGHT:1 | – | – |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 12 (5670 HP, 143 enemies); night-to-night HP ratio (last/first) = 0×. Ranged enemies appear on nights 3, 6, 7, 9, 10, 11, 12; flyers on nights 6, 9, 11.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Shadow In The Water | BOSS FIGHT | – | – | – | – | – | – |  | Some people saw shadows moving in the water a few days ago. Nobody believed them. |
| Slime | E Slime | 12 | 5 | 2.5 | 1.2 | 0.4 | 3 | MeeleFighter, Monster, NaturallyVulnerableToSplash | Slimes are small melee monsters without much brain so they will just attack whatever is closest to them. They  |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Hunterling | E Hunterling | 30 | 10 | 3.5 | 5 | 0.5 | 10 | MeeleFighter, FastMoving, Monster, NaturallyVulnerableToSplash | Hunterlings are incredibly fast and dangerous monsters with the sole aim of chasing you down. They can smell y |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Master Crossbowmen | E Crossbow | 40 | 4 | 15 | 15 | 1.6 | 9.38 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | Master Crossbowmen deal massive amounts of damage to you and your units. Best to keep yourself and your troops |
| Spiky Slime | E StrongSlime | 50 | 5 | 2.5 | 3.6 | 0.4 | 9 | MeeleFighter, Monster, NaturallyVulnerableToSplash | Spiky Slimes are small melee monsters without much brain so they will just attack whatever is closest to them. |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |
| Ram | E Ram | 250 | 2.2 | 3.5 | 15 | 2 | 7.5 | MeeleFighter, SiegeWeapon, ArmoredAgainstRanged, NaturallyHighHealthTarget, LargeUnit | Rams are siege units with a ton of health looking to tear down your walls and buildings. Furthermore, they are |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| House | 18 | economy | Castle Center upgrade #1 ×2, House upgrade #1 ×13, Castle Center upgrade #2 ×3 | 3 g ×2, 5 g ×2, 7 g ×3, 9 g ×2, 10 g ×3, 12 g ×4, 14 g ×1, 16 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #2 ×2 | 10 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Gold Mine | 1 | other | Castle Center upgrade #2 ×1 | 10 g ×1 | 1 | 5 | 6 | 0 |
| Harbour | 3 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×2 | 3 g ×1, 10 g ×2 | 2 | 3 → 7 | 0 | 0 |
| Hero's Quarter | 2 | other | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Summoning Circle | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #2 ×1 | 10 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 5 | shrine | Castle Center upgrade #1 ×5 | 3 g ×5 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 17 | tower | Castle Center upgrade #1 ×2, Castle Center upgrade #2 ×12, Castle Center upgrade #3 ×3 | 3 g ×2, 10 g ×12, 30 g ×3 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 18 | wall | Wall upgrade #1 ×14, Castle Center upgrade #3 ×4 (shares its activator's upgrades) | 30 g ×4, 33 g ×1, 34 g ×2, 35 g ×11 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Archery Range, 1× Blacksmith, 2× Defense Tower, 1× Harbour, 2× House, 5× Shrine, 2× Summoning Circle; **5 g** → 2× House; **7 g** → 3× House; **9 g** → 2× House; **10 g** → 1× Archery Range, 2× Barracks, 12× Defense Tower, 1× Gold Mine, 2× Harbour, 1× Hero's Quarter, 3× House, 1× Temple; **12 g** → 4× House; **14 g** → 1× House; **16 g** → 1× House; **30 g** → 3× Defense Tower, 1× Hero's Quarter, 4× Wall; **33 g** → 1× Wall; **34 g** → 2× Wall; **35 g** → 11× Wall.

**Totals:** building every slot to its final level costs **3266 gold**; if everything is at maximum level the buildings pay **149 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **14125 m²** (unbuilt world) of 14265 m² navmesh; 116 blocking colliders ({'static': 15, 'building': 101}), 12 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 67–192 m (3.7 s at day speed).

* 73/73 build slots have at least one collision-free stand point within interaction range (`terrain/07_Frostsee.json → slots[].standPoints`); median walking distance castle→stand point 48 m.

* 5 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
