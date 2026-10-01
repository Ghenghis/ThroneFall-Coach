# Totend — level handbook

*Generated from the shipped asset files (build index 28, scene file `level28`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Freifort** |
| Nights (waves) | 15 |
| Enemies in total | 1446 |
| Total enemy base HP | 153312 |
| Gold coins dropped by waves (sum of `goldCoins`) | 430 |
| Flying enemies / bosses | 135 / 0 |
| Enemy spawn lines | 11 |
| Build slots | 100 |
| Shrines | 6 |
| Starting gold (`goldBalanceAtStart`) | 23 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -48.9, 27.9, 10.8 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/28_Totend_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Right Air | (-116, -72) | 36.9 | air | Normal | 110 | 0.5 | (-84, -41) | – |
| Enemy Spawner | (-175, 15) | 0 | air/small/big | Normal | 180 | 0.5 | (-66, 32) | – |
| Left Air | (-110, 93) | 36.5 | air | Normal | 110 | 0.5 | (-82, 53) | – |
| Spawn | (-149, -17) | 1.6 | air/small/big | Normal | 170 | 0.5 | (-150, -8) | – |
| Spawn | (-135, -23) | 1.6 | air/small/big | Normal | 182 | 0.5 | (-150, -8) | – |
| Spawn | (-147, 52) | 1.6 | air/small/big | Normal | 185 | 0.5 | (-148, 45) | – |
| Right Bridge | (-42, -135) | 32 | air/small/big | Normal | 161 | 0.5 | (-33, -11) | – |
| Stage 2 Spawn Line | (-175, 15) | 0 | air/small/big | Normal | 180 | 0.5 | (-66, 32) | – |
| Middle Bridge | (-168, 11) | 31.9 | air/small/big | Normal | 178 | 0.5 | (-66, -11) | – |
| Left Bridge | (-43, 160) | 29.9 | air/small/big | Normal | 165 | 0.5 | (-33, 32) | – |
| FINAL BOSS FIGHT | (-188, 18) | 26.4 | – | n/a | – | – | – | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Melee and Archer | 20 | 900 | 0 | 0 | 0 | 10 | 20× Fire Snail | Middle Bridge:20 | 59 | 83 |
| 2 | Dark Warriors and Iron Tower | 7 | 1010 | 1 | 0 | 0 | 10 | 6× Dark Warrior, 1× Iron Tower | Left Bridge:7 | 24 | 34 |
| 3 | Flying Wizzards and Monsters | 150 | 3188 | 45 | 20 | 0 | 15 | 50× E Small Spider, 45× Slime, 25× Giraffe Slime, 20× Flying Mage, 10× Racer | Right Bridge:150 | 21 | 128 |
| 4 | Frontal Siege | 55 | 2900 | 15 | 0 | 0 | 18 | 25× E Medium Spider, 15× Mole Warrior, 15× Mole Archer | Middle Bridge:55 | 13 | 50 |
| 5 | Thing, Big Spider, Furies | 18 | 3825 | 15 | 15 | 0 | 18 | 15× Fury, 2× E Big Spider, 1× Thing | Left Bridge:18 | 17 | 71 |
| 6 | Fire Snails | 100 | 4500 | 0 | 0 | 0 | 30 | 100× Fire Snail | Right Bridge:100 | 54 | 103 |
| 7 | Siege and Ghosts | 53 | 6230 | 9 | 0 | 0 | 30 | 35× Ghost, 6× Wheel, 3× Ram, 3× Quicksling, 3× Catapult, 3× Iron Tower | Middle Bridge:53 | 16 | 101 |
| 8 | Flyers and Racers | 189 | 7785 | 60 | 60 | 0 | 27 | 120× Racer, 20× Wasp, 20× Fury, 20× Bloodwing, 9× Exploder | Right Air:30, Left Air:30, Middle Bridge:43, Left Bridge:43, Right Bridge:43 | 9 | 54 |
| 9 | Big Left Attack | 143 | 13800 | 30 | 0 | 0 | 30 | 60× Fire Snail, 20× Dark Warrior, 20× Master Crossbowmen, 20× Flail, 10× Catapult, 10× Flogre, 3× Thing | Left Bridge:143 | 24 | 110 |
| 10 | Archer Wave | 163 | 12620 | 115 | 20 | 0 | 35 | 80× Archer, 25× Fire Snail, 20× Wind-Boat, 15× Iron Tower, 15× Pikes, 8× Exploder | Right Bridge:163 | 18 | 85 |
| 11 | Frontal Monster Wave | 82 | 21950 | 30 | 0 | 0 | 32 | 30× Fire Snail, 30× Giraffe Slime, 15× E Big Spider, 7× Thing | Middle Bridge:82 | 18 | 96 |
| 12 | Big Mole Attack Wave From Left | 175 | 12750 | 75 | 0 | 0 | 60 | 75× Mole Archer, 75× Mole Warrior, 25× Wheel | Left Bridge:175 | 11 | 70 |
| 13 | Big Fugging Wave From Right | 170 | 20950 | 20 | 0 | 0 | 50 | 100× Dark Warrior, 30× Fire Snail, 20× Quicksling, 20× Ram | Right Bridge:170 | 23 | 95 |
| 14 | Final Siege Before Boss | 120 | 40905 | 53 | 20 | 0 | 60 | 40× Dark Warrior, 24× Iron Tower, 20× Wind-Boat, 18× E Big Spider, 9× Thing, 9× Catapult | Middle Bridge:60, Left Bridge:20, Right Bridge:20, Right Air:10, Left Air:10 | 16 | 112 |
| 15 | FINAL BOSS | 1 | 0 | 0 | 0 | 0 | 5 | 1× The Corrupt King | FINAL BOSS FIGHT:1 | – | – |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 14 (40905 HP, 120 enemies); night-to-night HP ratio (last/first) = 0×. Ranged enemies appear on nights 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14; flyers on nights 3, 5, 8, 10, 14.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| The Corrupt King | FINAL BOSS FIGHT | – | – | – | – | – | – |  | While once the beloved ruler of the realm, he was corrupted by greed and power. You rebuilt the realm from the |
| Slime | E Slime | 12 | 5 | 2.5 | 1.2 | 0.4 | 3 | MeeleFighter, Monster, NaturallyVulnerableToSplash | Slimes are small melee monsters without much brain so they will just attack whatever is closest to them. They  |
| E Small Spider | E Small Spider | 12 | 15 | 2.5 | 2.4 | 0.4 | 6 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Pikes | E LongSpear | 25 | 5 | 6 | 3.5 | 1 | 3.5 | MeeleFighter, VulnerableVsRanged, NaturallyVulnerableToSplash, Humanoid | Equipped with long spears. Your horse is slowed and you take additional damage when riding into them, even mor |
| Giraffe Slime | E Giraffeslime | 30 | 5 | 15 | 1.5 | 1 | 1.5 | RangedFighter, Monster, NaturallyVulnerableToSplash | Has a slimy ranged attack but no brain. Attacks whatever is closest. |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Master Crossbowmen | E Crossbow | 40 | 4 | 15 | 15 | 1.6 | 9.38 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | Master Crossbowmen deal massive amounts of damage to you and your units. Best to keep yourself and your troops |
| Fire Snail | E Fire Snail | 45 | 3 | 3.3 | 1.2 | 0.4 | 3 | Monster, MeeleFighter, FireAndExplosionResistant | A slow monster bound by dark forces that explodes on death. Takes reduced damage from fire and explosions. |
| Flying Mage | E Flying Wizzard | 45 | 7 | 17 | 2 | 2 | 1 | RangedFighter, Flying, Humanoid | Shoots magical projectiles that deal splash damage. Prefers attacking your units. |
| Catapult | E Catapult | 45 | 2 | 26.4 | 150 | 5 | 30 | RangedFighter, SiegeWeapon | Catapults are siege units that deal massive damage to your buildings from afar. Your only chance is to get clo |
| Mole Archer | E Moleman Archer | 50 | 5 | 20 | 3.8 | 2 | 1.88 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | A ranged unit that loves playing hard to get. Takes additional damage from defense towers. |
| E Medium Spider | E Medium Spider | 50 | 14 | 2.8 | 6 | 0.4 | 15 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Bloodwing | E Bloodwing | 50 | 12 | 13 | 3 | 0.5 | 6 | RangedFighter, FastMoving, Monster, Flying | Flying unit that loves the smell of blood. Chases your troops across the entire map. |
| Quicksling | E Quicksling | 55 | 3 | 37.5 | 9.8 | 0.45 | 21.72 | RangedFighter, SiegeWeapon | A unique siege weapon that rapidly fires arrows at random enemies in its range. If you don't have any allied b |
| Flail | E Flail | 55 | 5 | 3 | 2.2 | 1 | 2.2 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Deals splash damage with each attack. |
| Mole Warrior | E Moleman | 60 | 5 | 3 | 5 | 1 | 5 | MeeleFighter, TakesIncreasedDamageFromTowers, Humanoid | Can tunnel directly to its target. Takes additional damage from defense towers. |
| Exploder | E Exploder | 65 | 9 | 4 | 3.5 | 1 | 3.5 | MeeleFighter, FastMoving, TakesReducedDamageFromPlayerAttacks, Monster, SiegeWeapon, Exploding | Exploders are monsters that roll straight for the closest building and explode when they die. They are slightl |
| Fury | E Fury | 75 | 3 | 15 | 30 | 4 | 7.5 | RangedFighter, Flying, Monster | A large flying monster that focusses on destroying your defenses. Their projectiles are quite slow and easy to |
| Ghost | E Ghost | 100 | 3.3 | 3.5 | 6.5 | 1 | 6.5 | MeeleFighter, TakesIncreasedDamageFromTowers, TakesReducedDamageFromPlayerAttacks | Can pass through other units and closed gates. Prefers to attack towers and your castle center. Takes increase |
| Dark Warrior | E Dark Warrior | 135 | 7 | 4 | 10 | 1 | 10 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid, FastMoving | Poisoned by greed and magic, these humanoid warriors are a nightmare to fight against. |
| Wheel | E Wheel | 180 | 15 | 5 | 3.5 | 0.25 | 14 | MeeleFighter, FastMoving, SiegeWeapon | A fast siege engine that deals some splash damage. |
| Iron Tower | E Iron Tower | 200 | 5 | 35 | 3.5 | 0.5 | 7 | RangedFighter, SiegeWeapon, FireAndExplosionResistant | A siege tower on wheels that takes reduced damage from fire and explosions. |
| Ram | E Ram | 250 | 2.2 | 3.5 | 15 | 2 | 7.5 | MeeleFighter, SiegeWeapon, ArmoredAgainstRanged, NaturallyHighHealthTarget, LargeUnit | Rams are siege units with a ton of health looking to tear down your walls and buildings. Furthermore, they are |
| Flogre | E Flogre | 275 | 4 | 3 | 9 | 1 | 9 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | A giant ogre equipped with a flail, dealing splash damage around it. |
| Wind-Boat | E Windboat | 300 | 3 | 17 | 15 | 1 | 15 | RangedFighter, Flying, SiegeWeapon | A high-health flying siege engine with a medium ranged attack. |
| E Big Spider | E Big Spider | 800 | 10 | 4.2 | 12 | 0.3 | 40 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving, LargeUnit |  |
| Thing | E Thing | 1100 | 4 | 6.2 | 2.2 | 0.3 | 7.33 | MeeleFighter, Monster, LargeUnit | A terrifying monster that can attack with its tentacles in all directions at once. |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 15 | economy | Mill upgrade #1 ×6, Mill upgrade #2 ×9 | 6 g ×6, 10 g ×9 | 1 | 1 | 1 | – |
| House | 11 | economy | Castle Center upgrade #1 ×5, House upgrade #1 ×6 | 3 g ×5, 5 g ×5, 7 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 3 | economy | Castle Center upgrade #1 ×3 | 3 g ×3 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #1 ×2 | 3 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #1 ×2 | 3 g ×2 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barricades | 2 | other | Castle Center upgrade #3 ×2 | 30 g ×2 | 1 | 4 | 0 | 1 |
| Gold Mine | 3 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×2 | 3 g ×1, 10 g ×2 | 1 | 5 | 6 | 0 |
| Hero's Quarter | 3 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #3 ×2 | 3 g ×1, 30 g ×2 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 3 | other | Castle Center upgrade #1 ×3 | 3 g ×3 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 6 | shrine | Castle Center upgrade #1 ×6 | 3 g ×6 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 26 | tower | Castle Center upgrade #1 ×12, Castle Center upgrade #2 ×8, Castle Center upgrade #3 ×6 | 3 g ×12, 10 g ×8, 30 g ×6 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 20 | wall | Castle Center upgrade #1 ×5, Wall upgrade #1 ×12, Castle Center upgrade #2 ×3 (shares its activator's upgrades) | 3 g ×5, 6 g ×6, 10 g ×3, 14 g ×6 | 3 | 4 → 12 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 2× Archery Range, 2× Barracks, 1× Blacksmith, 12× Defense Tower, 1× Gold Mine, 1× Hero's Quarter, 5× House, 3× Mill, 1× Royal Forge, 6× Shrine, 3× Summoning Circle, 1× Temple, 5× Wall; **5 g** → 5× House; **6 g** → 6× Field, 6× Wall; **7 g** → 1× House; **10 g** → 8× Defense Tower, 9× Field, 2× Gold Mine, 3× Wall; **14 g** → 6× Wall; **30 g** → 2× Barricades, 6× Defense Tower, 2× Hero's Quarter.

**Totals:** building every slot to its final level costs **4039 gold**; if everything is at maximum level the buildings pay **193 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **695 m²** (unbuilt world) of 20296 m² navmesh; 187 blocking colliders ({'static': 52, 'building': 135}), 28 auto-opening gates.

* 100/100 build slots have at least one collision-free stand point within interaction range (`terrain/28_Totend.json → slots[].standPoints`); median walking distance castle→stand point 9 m.

* **Limitation:** 91 slots are not connected to the castle in the terrain model (multi-storey geometry); their stand points are locally valid only.

* 6 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
