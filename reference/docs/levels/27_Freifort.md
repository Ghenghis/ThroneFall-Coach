# Freifort — level handbook

*Generated from the shipped asset files (build index 27, scene file `level27`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Moorweg** |
| Nights (waves) | 13 |
| Enemies in total | 654 |
| Total enemy base HP | 117858 |
| Gold coins dropped by waves (sum of `goldCoins`) | 197 |
| Flying enemies / bosses | 54 / 1 |
| Enemy spawn lines | 11 |
| Build slots | 113 |
| Shrines | 6 |
| Starting gold (`goldBalanceAtStart`) | 13 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -58, 8.7, 24.2 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/27_Freifort_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| Bot Left | (-111, -126) | 16.7 | air/small/big | Normal | 220 | 0.5 | (-100, -67) | – |
| Cave | (-161, -83) | 6.2 | air/small | Normal | 225 | 0.5 | (-154, -88) | – |
| SpawnLine | (-37, -145) | 17.7 | air/small/big | Normal | 221 | 0.5 | (-46, -75) | – |
| Top Right | (33, -37) | 17 | air/small/big | Normal | 159 | 0.5 | (-6, -12) | – |
| Top Left | (-168, 27) | 13 | air/small/big | Normal | 130 | 0.5 | (-140, 27) | – |
| Spawn | (-139, 81) | 1.6 | air/small/big | Normal | 108 | 0.5 | (-104, 75) | – |
| Spawn | (-162, 35) | 1.6 | air/small/big | Normal | 125 | 0.5 | (-149, 31) | – |
| Spawn | (25, -21) | 1.6 | air/small/big | Normal | 153 | 0.5 | (22, -28) | – |
| Spawn | (-83, -126) | 1.6 | air/small/big | Normal | 223 | 0.5 | (-97, -91) | – |
| Middle | (-39, -120) | 35.8 | air/small/big | Normal | 208 | 0.5 | (-41, -94) | – |
| Bot Right | (24, -105) | 13.5 | air/small/big | Normal | 215 | 0.5 | (18, -96) | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Barrel Knight and Archers | 8 | 320 | 6 | 0 | 0 | 7 | 6× Archer, 2× Barrel Knight | Top Left:8 | 16 | 36 |
| 2 | Flails, Rams, Crossbows | 7 | 550 | 2 | 0 | 0 | 8 | 4× Flail, 2× Master Crossbowmen, 1× Ram | Top Right:7 | 32 | 71 |
| 3 | Spiders from Cave | 28 | 462 | 0 | 0 | 0 | 8 | 25× E Small Spider, 3× E Medium Spider | Cave:28 | 15 | 30 |
| 4 | Wheels | 3 | 540 | 0 | 0 | 0 | 8 | 3× Wheel | Middle:3 | 14 | 18 |
| 5 | Monster Riders | 45 | 1800 | 0 | 0 | 0 | 12 | 45× Monster Rider | Middle:15, Bot Right:15, Bot Left:15 | 19 | 41 |
| 6 | Hunterling & Quicklsing | 34 | 1020 | 4 | 0 | 0 | 12 | 20× Swordsman, 10× Hunterling, 4× Quicksling | Top Left:10, Bot Left:24 | 13 | 79 |
| 7 | Big Tower Attack | 50 | 3100 | 35 | 0 | 0 | 12 | 30× Archer, 15× Barrel Knight, 5× Iron Tower | Middle:50 | 26 | 56 |
| 8 | Cave | 75 | 3050 | 20 | 20 | 0 | 12 | 40× Racer, 20× Flying Mage, 15× E Medium Spider | Cave:15, Bot Right:40, Bot Left:20 | 16 | 61 |
| 9 | Wheels | 60 | 4275 | 15 | 0 | 0 | 18 | 15× Wheel, 15× Monster Rider, 15× Master Crossbowmen, 15× Pikes | Middle:20, Bot Left:20, Bot Right:20 | 14 | 69 |
| 10 | Windboats | 65 | 11260 | 21 | 21 | 0 | 35 | 21× Wind-Boat, 20× Barrel Knight, 12× E Medium Spider, 10× Ogre, 2× Wheel | Bot Left:9, Middle:17, Bot Right:27, Cave:12 | 15 | 89 |
| 11 | Runby | 107 | 6515 | 47 | 2 | 0 | 25 | 45× Archer, 30× Pikes, 15× Racer, 8× Wheel, 6× Ram, 2× Wind-Boat, 1× E Big Spider | Top Right:54, Top Left:53 | 11 | 70 |
| 12 | Fat Siege Attack | 171 | 18965 | 65 | 11 | 0 | 40 | 52× Barrel Knight, 32× Master Crossbowmen, 32× Flail, 11× Iron Tower, 11× Wheel, 11× Wind-Boat, 11× Catapult, 11× Ram | Middle:85, Bot Right:43, Bot Left:43 | 14 | 160 |
| 13 | IRON CASTLE | 1 | 66000 | 1 | 0 | 1 | 0 | 1× Iron Castle | SpawnLine:1 | – | – |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 13 (66000 HP, 1 enemies); night-to-night HP ratio (last/first) = 206.2×. Ranged enemies appear on nights 1, 2, 6, 7, 8, 9, 10, 11, 12, 13; flyers on nights 8, 10, 11, 12.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| E Small Spider | E Small Spider | 12 | 15 | 2.5 | 2.4 | 0.4 | 6 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Pikes | E LongSpear | 25 | 5 | 6 | 3.5 | 1 | 3.5 | MeeleFighter, VulnerableVsRanged, NaturallyVulnerableToSplash, Humanoid | Equipped with long spears. Your horse is slowed and you take additional damage when riding into them, even mor |
| Hunterling | E Hunterling | 30 | 10 | 3.5 | 5 | 0.5 | 10 | MeeleFighter, FastMoving, Monster, NaturallyVulnerableToSplash | Hunterlings are incredibly fast and dangerous monsters with the sole aim of chasing you down. They can smell y |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Master Crossbowmen | E Crossbow | 40 | 4 | 15 | 15 | 1.6 | 9.38 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | Master Crossbowmen deal massive amounts of damage to you and your units. Best to keep yourself and your troops |
| Monster Rider | E Monster Rider | 40 | 11 | 4 | 3 | 1 | 3 | MeeleFighter, FastMoving, Monster, Humanoid | Monster riders are fast and durable melee warriors. A man meets monster synergy that should not be underestima |
| Flying Mage | E Flying Wizzard | 45 | 7 | 17 | 2 | 2 | 1 | RangedFighter, Flying, Humanoid | Shoots magical projectiles that deal splash damage. Prefers attacking your units. |
| Catapult | E Catapult | 45 | 2 | 26.4 | 150 | 5 | 30 | RangedFighter, SiegeWeapon | Catapults are siege units that deal massive damage to your buildings from afar. Your only chance is to get clo |
| E Medium Spider | E Medium Spider | 50 | 14 | 2.8 | 6 | 0.4 | 15 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Flail | E Flail | 55 | 5 | 3 | 2.2 | 1 | 2.2 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Deals splash damage with each attack. |
| Quicksling | E Quicksling | 55 | 3 | 37.5 | 9.8 | 0.45 | 21.72 | RangedFighter, SiegeWeapon | A unique siege weapon that rapidly fires arrows at random enemies in its range. If you don't have any allied b |
| Barrel Knight | E BarrelKnight | 100 | 8 | 3.2 | 3.5 | 1.25 | 2.8 | MeeleFighter, SiegeWeapon, NaturallyHighHealthTarget | An enchanted warrior made of wood. Counts as a siege weapon and is armored against ranged attacks. Quite sturd |
| Wheel | E Wheel | 180 | 15 | 5 | 3.5 | 0.25 | 14 | MeeleFighter, FastMoving, SiegeWeapon | A fast siege engine that deals some splash damage. |
| Iron Tower | E Iron Tower | 200 | 5 | 35 | 3.5 | 0.5 | 7 | RangedFighter, SiegeWeapon, FireAndExplosionResistant | A siege tower on wheels that takes reduced damage from fire and explosions. |
| Ogre | E Ogre | 200 | 4 | 3 | 20 | 1 | 20 | MeeleFighter, NaturallyHighHealthTarget, Humanoid | Ogres are huge melee warriors that really pack a punch. Hey! Due to their human heritage, ogres aren't monster |
| Ram | E Ram | 250 | 2.2 | 3.5 | 15 | 2 | 7.5 | MeeleFighter, SiegeWeapon, ArmoredAgainstRanged, NaturallyHighHealthTarget, LargeUnit | Rams are siege units with a ton of health looking to tear down your walls and buildings. Furthermore, they are |
| Wind-Boat | E Windboat | 300 | 3 | 17 | 15 | 1 | 15 | RangedFighter, Flying, SiegeWeapon | A high-health flying siege engine with a medium ranged attack. |
| E Big Spider | E Big Spider | 800 | 10 | 4.2 | 12 | 0.3 | 40 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving, LargeUnit |  |
| Iron Castle | E Iron Castle | 66000 | – | – | – | – | – | RangedFighter, Boss, SiegeWeapon, FireAndExplosionResistant | You can see it approaching on the horizon, an iron castle on wheels. It can only mean one thing. The corrupt k |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 20 | economy | Mill upgrade #1 ×8, Mill upgrade #2 ×12 | 6 g ×4, 10 g ×6, 13 g ×4, 17 g ×6 | 1 | 1 | 1 | – |
| House | 13 | economy | Castle Center upgrade #1 ×2, House upgrade #1 ×11 | 3 g ×2, 5 g ×2, 7 g ×2, 9 g ×2, 11 g ×2, 13 g ×2, 15 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 4 | economy | Castle Center upgrade #1 ×2, Castle Center upgrade #2 ×2 | 3 g ×2, 10 g ×2 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #1 ×1, Castle Center upgrade #3 ×1 | 3 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Gold Mine | 2 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1 | 3 g ×1, 10 g ×1 | 1 | 5 | 6 | 0 |
| Harbour | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 2 | 3 → 7 | 0 | 0 |
| Hero's Quarter | 2 | other | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 4 | other | Castle Center upgrade #1 ×4 | 3 g ×4 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 6 | shrine | Castle Center upgrade #1 ×6 | 3 g ×6 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 31 | tower | Castle Center upgrade #1 ×17, Castle Center upgrade #2 ×7, Castle Center upgrade #3 ×7 | 3 g ×17, 10 g ×7, 30 g ×7 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 21 | wall | Castle Center upgrade #1 ×2, Wall upgrade #1 ×15, Castle Center upgrade #2 ×3, Castle Center upgrade #3 ×1 (shares its activator's upgrades) | 3 g ×2, 6 g ×2, 7 g ×6, 10 g ×3, 13 g ×2, 14 g ×3, 30 g ×1, 33 g ×2 | 3 | 3 → 2 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Barracks, 1× Blacksmith, 17× Defense Tower, 1× Gold Mine, 2× Harbour, 2× House, 2× Mill, 1× Royal Forge, 6× Shrine, 4× Summoning Circle, 1× Temple, 2× Wall; **5 g** → 2× House; **6 g** → 4× Field, 2× Wall; **7 g** → 2× House, 6× Wall; **9 g** → 2× House; **10 g** → 1× Archery Range, 7× Defense Tower, 6× Field, 1× Gold Mine, 1× Hero's Quarter, 2× Mill, 3× Wall; **11 g** → 2× House; **13 g** → 4× Field, 2× House, 2× Wall; **14 g** → 3× Wall; **15 g** → 1× House; **17 g** → 6× Field; **30 g** → 1× Archery Range, 1× Barracks, 7× Defense Tower, 1× Hero's Quarter, 1× Wall; **33 g** → 2× Wall.

**Totals:** building every slot to its final level costs **4334 gold**; if everything is at maximum level the buildings pay **221 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **25609 m²** (unbuilt world) of 25820 m² navmesh; 170 blocking colliders ({'static': 27, 'building': 143}), 16 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 99–220 m (5.4 s at day speed).

* 113/113 build slots have at least one collision-free stand point within interaction range (`terrain/27_Freifort.json → slots[].standPoints`); median walking distance castle→stand point 112 m.

* 6 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
