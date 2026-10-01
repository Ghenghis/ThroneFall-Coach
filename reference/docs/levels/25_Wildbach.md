# Wildbach — level handbook

*Generated from the shipped asset files (build index 25, scene file `level25`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Sturmklamm** |
| Nights (waves) | 13 |
| Enemies in total | 825 |
| Total enemy base HP | 55610 |
| Gold coins dropped by waves (sum of `goldCoins`) | 103 |
| Flying enemies / bosses | 130 / 0 |
| Enemy spawn lines | 7 |
| Build slots | 78 |
| Shrines | 5 |
| Starting gold (`goldBalanceAtStart`) | 14 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | 5.6, 17.6, -32.3 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/25_Wildbach_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Expansion Side | (75, -162) | 9.9 | air/small/big | Normal | 187 | 0.5 | (18, -134) | Expansion Main |
| Expansion Main | (33, -202) | 19.8 | air/small/big | Normal | 189 | 0.5 | (26, -197) | Expansion Side |
| Upper Level Side | (75, -81) | 6.5 | air/small/big | Normal | 210 | 0.5 | (39, -94) | – |
| Spawn | (-31, -128) | 1.6 | air/small/big | Normal | 111 | 0.5 | (-25, -111) | – |
| Spawn | (-67, -33) | 1.6 | air/small/big | Normal | 123 | 0.5 | (-49, -63) | – |
| Main Bridge | (-28, -188) | 18.8 | air/small/big | Normal | 170 | 0.5 | (-1, -61) | – |
| Pond Air | (-110, -73) | 21.4 | air | Normal | 125 | 0.5 | (-49, -63) | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Flails | 6 | 330 | 0 | 0 | 0 | 4 | 6× Flail | Main Bridge:6 | 34 | 41 |
| 2 | Spiders | 24 | 300 | 0 | 0 | 0 | 4 | 24× E Small Spider | Main Bridge:6, Expansion Main:6, Expansion Side:6, Upper Level Side:6 | 11 | 24 |
| 3 | Bloodwings | 10 | 500 | 10 | 10 | 0 | 6 | 10× Bloodwing | Main Bridge:10 | 13 | 24 |
| 4 | Giraffe Slimes | 42 | 892 | 21 | 0 | 0 | 6 | 21× Slime, 21× Giraffe Slime | Expansion Main:14, Expansion Side:14, Upper Level Side:14 | 37 | 45 |
| 5 | Flails & Flais | 18 | 1650 | 0 | 0 | 0 | 7 | 15× Flail, 3× Flogre | Main Bridge:18 | 34 | 52 |
| 6 | Spiders & Spiders | 76 | 1550 | 0 | 0 | 0 | 8 | 60× E Small Spider, 16× E Medium Spider | Main Bridge:19, Expansion Main:19, Expansion Side:19, Upper Level Side:19 | 11 | 35 |
| 7 | Bloodwings | 30 | 1125 | 30 | 30 | 0 | 6 | 15× Bloodwing, 15× Wasp | Pond Air:30 | 10 | 36 |
| 8 | Giraffe Slimes and Flogres | 67 | 3725 | 60 | 0 | 0 | 10 | 60× Giraffe Slime, 7× Flogre | Expansion Main:15, Expansion Side:15, Upper Level Side:15, Main Bridge:22 | 34 | 60 |
| 9 | Big Spiders | 92 | 3850 | 0 | 0 | 0 | 12 | 60× E Small Spider, 30× E Medium Spider, 2× E Big Spider | Main Bridge:46, Expansion Main:46 | 11 | 27 |
| 10 | Bloodwing Assault | 70 | 3500 | 70 | 70 | 0 | 10 | 70× Bloodwing | Expansion Main:14, Expansion Side:14, Upper Level Side:14, Main Bridge:14, Pond Air:14 | 7 | 27 |
| 11 | Flail Assault | 120 | 11000 | 0 | 0 | 0 | 12 | 100× Flail, 20× Flogre | Expansion Main:60, Main Bridge:60 | 34 | 92 |
| 12 | Slime Assault | 160 | 8000 | 80 | 0 | 0 | 18 | 80× Racer, 40× Giraffe Slime, 40× Spiky Giraffe | Expansion Side:80, Upper Level Side:80 | 19 | 47 |
| 13 | Sipder Finale | 110 | 19188 | 20 | 20 | 0 | 0 | 35× E Medium Spider, 35× E Small Spider, 20× E Big Spider, 20× Bloodwing | Main Bridge:5, Expansion Main:5, Expansion Side:5, Upper Level Side:75, Pond Air:20 | 17 | 55 |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 13 (19188 HP, 110 enemies); night-to-night HP ratio (last/first) = 58.1×. Ranged enemies appear on nights 3, 4, 7, 8, 10, 12, 13; flyers on nights 3, 7, 10, 13.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| E Small Spider | E Small Spider | 12 | 15 | 2.5 | 2.4 | 0.4 | 6 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Slime | E Slime | 12 | 5 | 2.5 | 1.2 | 0.4 | 3 | MeeleFighter, Monster, NaturallyVulnerableToSplash | Slimes are small melee monsters without much brain so they will just attack whatever is closest to them. They  |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Giraffe Slime | E Giraffeslime | 30 | 5 | 15 | 1.5 | 1 | 1.5 | RangedFighter, Monster, NaturallyVulnerableToSplash | Has a slimy ranged attack but no brain. Attacks whatever is closest. |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Bloodwing | E Bloodwing | 50 | 12 | 13 | 3 | 0.5 | 6 | RangedFighter, FastMoving, Monster, Flying | Flying unit that loves the smell of blood. Chases your troops across the entire map. |
| E Medium Spider | E Medium Spider | 50 | 14 | 2.8 | 6 | 0.4 | 15 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Flail | E Flail | 55 | 5 | 3 | 2.2 | 1 | 2.2 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Deals splash damage with each attack. |
| Spiky Giraffe | E StrongGiraffeslime | 100 | 7 | 20 | 3.5 | 1 | 3.5 | RangedFighter, Monster, NaturallyVulnerableToSplash | Has a slimy ranged attack and a lot of health but no brain. Attacks whatever is closest. |
| Flogre | E Flogre | 275 | 4 | 3 | 9 | 1 | 9 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | A giant ogre equipped with a flail, dealing splash damage around it. |
| E Big Spider | E Big Spider | 800 | 10 | 4.2 | 12 | 0.3 | 40 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving, LargeUnit |  |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 15 | economy | Mill upgrade #1 ×6, Mill upgrade #2 ×9 | 6 g ×6, 10 g ×9 | 1 | 1 | 1 | – |
| House | 10 | economy | Castle Center upgrade #1 ×3, House upgrade #1 ×7 | 3 g ×3, 5 g ×3, 7 g ×2, 9 g ×1, 11 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 3 | economy | Castle Center upgrade #1 ×3 | 3 g ×3 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #3 ×2 | 30 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Gold Mine | 2 | other | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 1 | 5 | 6 | 0 |
| Harbour | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 2 | 3 → 7 | 0 | 0 |
| Hero's Quarter | 1 | other | Castle Center upgrade #2 ×1 | 10 g ×1 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 5 | shrine | Castle Center upgrade #1 ×2, Castle Center upgrade #2 ×3 | 3 g ×2, 10 g ×3 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 17 | tower | Castle Center upgrade #1 ×7, Castle Center upgrade #2 ×7, Castle Center upgrade #3 ×3 | 3 g ×7, 10 g ×7, 30 g ×3 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 14 | wall | Castle Center upgrade #1 ×1, Wall upgrade #1 ×8, Castle Center upgrade #2 ×3, Castle Center upgrade #3 ×2 (shares its activator's upgrades) | 3 g ×1, 6 g ×2, 10 g ×3, 13 g ×4, 30 g ×2, 33 g ×2 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Barracks, 1× Blacksmith, 7× Defense Tower, 1× Harbour, 3× House, 3× Mill, 1× Royal Forge, 2× Shrine, 2× Summoning Circle, 1× Temple, 1× Wall; **5 g** → 3× House; **6 g** → 6× Field, 2× Wall; **7 g** → 2× House; **9 g** → 1× House; **10 g** → 1× Barracks, 7× Defense Tower, 9× Field, 1× Gold Mine, 1× Hero's Quarter, 3× Shrine, 3× Wall; **11 g** → 1× House; **13 g** → 4× Wall; **30 g** → 2× Archery Range, 3× Defense Tower, 1× Gold Mine, 2× Wall; **33 g** → 2× Wall.

**Totals:** building every slot to its final level costs **2815 gold**; if everything is at maximum level the buildings pay **156 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **8025 m²** (unbuilt world) of 9166 m² navmesh; 116 blocking colliders ({'static': 11, 'building': 105}), 12 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 102–181 m (5.6 s at day speed).

* 78/78 build slots have at least one collision-free stand point within interaction range (`terrain/25_Wildbach.json → slots[].standPoints`); median walking distance castle→stand point 104 m.

* **Limitation:** 6 slots are not connected to the castle in the terrain model (multi-storey geometry); their stand points are locally valid only.

* 5 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
