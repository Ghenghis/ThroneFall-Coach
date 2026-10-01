# Moorweg — level handbook

*Generated from the shipped asset files (build index 26, scene file `level26`). Every number is decoded or computed from them; formulas are stated where used. Provenance and checks: [verification](../12-verification-and-coverage.md).*

## 1. At a glance

| Item | Value |
|---|---|
| Unlock requirement | beat **Wildbach** |
| Nights (waves) | 12 |
| Enemies in total | 584 |
| Total enemy base HP | 91335 |
| Gold coins dropped by waves (sum of `goldCoins`) | 210 |
| Flying enemies / bosses | 30 / 1 |
| Enemy spawn lines | 13 |
| Build slots | 82 |
| Shrines | 6 |
| Starting gold (`goldBalanceAtStart`) | 16 |
| Wave generator asset | Season2 Wave Gen |
| Perk slots (`maxPerkCount`) | 5 |
| Fixed loadout | none |
| Castle position (x, y, z) | -77.9, 19.2, 2.7 |
| Hold-to-call-night time (`nightCallTime`) | 2.0 s (key: Space) |
| Hero speed (walk / day-walk / sprint / day-sprint) | 14.0 / 18.2 / 23.0 / 29.9 m/s |
| Interaction / coin-magnet radius | 3.0 m / 7.0 m |

![overview map](../../img/levels/26_Moorweg_overview.png)

*Figure 1. Hero-walkable area (green), blockers, build slots by type, enemy spawn lines (red), least-cost ground routes to the castle and their narrowest points. Built from colliders + the baked A* navmesh; see §7.*

## 2. Where enemies come from

Enemies spawn at random points along a **spawn line** (a polyline of child transforms, `Spawn.cs:274-297`). The route is the least-cost path on the baked 'Enemy Units S' navmesh from the line's centre to the castle; travel time = route length ÷ enemy speed.

| Spawn line | Centre (x, z) | Line length m | Can spawn | Difficulty | Route to castle m | Narrowest clearance m | Choke (x, z) | Shares path with |
|---|---|---:|---|---|---:|---:|---|---|
| SpawnLine | (-104, -61) | 0 | air/small/big | Normal | 94 | 0.5 | (-112, -62) | – |
| Farms | (16, -56) | 14.3 | air/small/big | Normal | 139 | 0.5 | (7, -47) | – |
| Mountains | (-22, 97) | 19.3 | air/small/big | Normal | 175 | 0.5 | (-22, 45) | – |
| Center | (9, 0) | 16.1 | air/small/big | Normal | 110 | 0.5 | (-35, -10) | – |
| Spawn | (-138, -57) | 1.6 | air/small/big | Normal | 85 | 0.7 | (-116, -36) | – |
| Spawn | (-160, 49) | 1.6 | air/small/big | Normal | 102 | 1.1 | (-117, 28) | – |
| Spawn | (-107, -83) | 1.6 | air/small/big | Normal | 106 | 0.5 | (-116, -62) | – |
| Spawn | (-115, 81) | 1.6 | air/small/big | Normal | 95 | 0.5 | (-108, 77) | – |
| Graveyard | (-50, -100) | 9.5 | air/small/big | Normal | 117 | 0.5 | (-71, -76) | – |
| Spawn Animation | (-104, -58) | 4.4 | – | n/a | 94 | 0.5 | (-112, -62) | – |
| Empty Delay | (0, 0) | 0 | – | n/a | – | – | – | – |
| Screen Shake | (0, 0) | 0 | – | n/a | – | – | – | – |
| E Ghostqueen | (-104, -61) | 0 | – | n/a | 94 | 0.5 | (-112, -62) | – |

## 3. Night by night

`EnemySpawner` mode: **Classic**; wave generator asset: `Season2 Wave Gen`; `pauseSpawningAtEnemyCount` = 275 (spawning pauses while that many enemies are alive; see [waves doc](../mechanics/01-waves-spawning-daynight.md)). Times are seconds after dusk.

| Night | In-game warning | Enemies | Base HP | Ranged | Flying | Boss | Coins | Composition | By spawn line | First contact s | Last arrival s |
|:---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---:|
| 1 | Monsters | 8 | 240 | 8 | 0 | 0 | 8 | 8× Giraffe Slime | Center:8 | 22 | 36 |
| 2 | Ghosts | 8 | 800 | 0 | 0 | 0 | 7 | 8× Ghost | Graveyard:8 | 35 | 42 |
| 3 | Thing | 1 | 1100 | 0 | 0 | 0 | 10 | 1× Thing | Mountains:1 | 44 | 44 |
| 4 | Spiders | 72 | 1575 | 0 | 0 | 0 | 10 | 54× E Small Spider, 18× E Medium Spider | Farms:72 | 9 | 62 |
| 5 | Human Invaders | 36 | 1560 | 4 | 0 | 0 | 12 | 20× Swordsman, 10× Monster Rider, 4× Master Crossbowmen, 2× Ram | Center:36 | 22 | 59 |
| 6 | Racer & Barrel Knights | 44 | 2320 | 0 | 0 | 0 | 12 | 32× Racer, 12× Barrel Knight | Graveyard:11, Center:11, Farms:11, Mountains:11 | 11 | 47 |
| 7 | Thing Invasion | 5 | 5500 | 0 | 0 | 0 | 15 | 5× Thing | Mountains:3, Center:2 | 28 | 52 |
| 8 | Ghosts | 100 | 10000 | 0 | 0 | 0 | 15 | 100× Ghost | Center:100 | 33 | 63 |
| 9 | Farm Monster Invasion | 60 | 6840 | 50 | 30 | 0 | 30 | 20× Spiky Giraffe, 20× Wasp, 10× Fury, 6× Exploder, 4× E Big Spider | Farms:30, Graveyard:30 | 12 | 75 |
| 10 | Humanoid Boss Wave | 140 | 9800 | 70 | 0 | 0 | 35 | 50× Flail, 50× Archer, 20× Master Crossbowmen, 10× Flogre, 10× Ram | Mountains:140 | 35 | 123 |
| 11 | Things and Ghosts | 106 | 36600 | 0 | 0 | 0 | 56 | 80× Ghost, 26× Thing | Graveyard:27, Farms:26, Center:26, Mountains:27 | 28 | 141 |
| 12 | Boss | 4 | 15000 | 1 | 0 | 1 | 0 | 1× Spawn Animation, 1× Empty Delay, 1× Screen Shake, 1× Elara the Vile | Spawn Animation:1, Empty Delay:1, Screen Shake:1, E Ghostqueen:1 | – | – |

*First contact = min over spawn groups of (`delay` + route ÷ speed); last arrival = max of (`delay` + (count−1)·`interval` + route ÷ speed). Flyers use the straight-line distance to the castle. These are lower bounds: enemies stop to fight units/buildings that they target on the way (see [combat doc](../mechanics/03-combat-units-targeting.md)).*

**Derived:** the heaviest night by total base HP is night 11 (36600 HP, 106 enemies); night-to-night HP ratio (last/first) = 62.5×. Ranged enemies appear on nights 1, 5, 9, 10, 12; flyers on nights 9.

## 4. Enemy roster

| Name | Prefab | HP | Speed | Range | Damage | Cooldown | DPS | Tags | In-game description |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| Spawn Animation | Spawn Animation | – | – | – | – | – | – |  |  |
| Empty Delay | Empty Delay | – | – | – | – | – | – |  |  |
| Screen Shake | Screen Shake | – | – | – | – | – | – |  |  |
| E Small Spider | E Small Spider | 12 | 15 | 2.5 | 2.4 | 0.4 | 6 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Archer | E Archer | 20 | 5 | 20 | 2.5 | 2 | 1.25 | RangedFighter, TakesIncreasedDamageFromTowers, NaturallyVulnerableToSplash, Humanoid | Archers shoot arrows from afar. Quite strong when left uncontested. Weak against buildings and towers. |
| Swordsman | E Melee | 25 | 5 | 3 | 2.5 | 1 | 2.5 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Swordsmen are simple melee warriors, but do not underestimate them when they come in numbers. |
| Wasp | E Flyer | 25 | 8 | 13 | 2.5 | 1 | 2.5 | RangedFighter, Flying, Monster | Wasps are flying monsters eager to destroy every single one of your economic buildings. |
| Giraffe Slime | E Giraffeslime | 30 | 5 | 15 | 1.5 | 1 | 1.5 | RangedFighter, Monster, NaturallyVulnerableToSplash | Has a slimy ranged attack but no brain. Attacks whatever is closest. |
| Racer | E Racer | 35 | 10 | 3.5 | 2.5 | 1 | 2.5 | MeeleFighter, TakesReducedDamageFromPlayerAttacks, FastMoving, Monster | Racers are fast rolling monsters that are not messing around. They aim right for your castle center and are so |
| Master Crossbowmen | E Crossbow | 40 | 4 | 15 | 15 | 1.6 | 9.38 | RangedFighter, TakesIncreasedDamageFromTowers, Humanoid | Master Crossbowmen deal massive amounts of damage to you and your units. Best to keep yourself and your troops |
| Monster Rider | E Monster Rider | 40 | 11 | 4 | 3 | 1 | 3 | MeeleFighter, FastMoving, Monster, Humanoid | Monster riders are fast and durable melee warriors. A man meets monster synergy that should not be underestima |
| E Medium Spider | E Medium Spider | 50 | 14 | 2.8 | 6 | 0.4 | 15 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving |  |
| Flail | E Flail | 55 | 5 | 3 | 2.2 | 1 | 2.2 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | Deals splash damage with each attack. |
| Exploder | E Exploder | 65 | 9 | 4 | 3.5 | 1 | 3.5 | MeeleFighter, FastMoving, TakesReducedDamageFromPlayerAttacks, Monster, SiegeWeapon, Exploding | Exploders are monsters that roll straight for the closest building and explode when they die. They are slightl |
| Fury | E Fury | 75 | 3 | 15 | 30 | 4 | 7.5 | RangedFighter, Flying, Monster | A large flying monster that focusses on destroying your defenses. Their projectiles are quite slow and easy to |
| Ghost | E Ghost | 100 | 3.3 | 3.5 | 6.5 | 1 | 6.5 | MeeleFighter, TakesIncreasedDamageFromTowers, TakesReducedDamageFromPlayerAttacks | Can pass through other units and closed gates. Prefers to attack towers and your castle center. Takes increase |
| Barrel Knight | E BarrelKnight | 100 | 8 | 3.2 | 3.5 | 1.25 | 2.8 | MeeleFighter, SiegeWeapon, NaturallyHighHealthTarget | An enchanted warrior made of wood. Counts as a siege weapon and is armored against ranged attacks. Quite sturd |
| Spiky Giraffe | E StrongGiraffeslime | 100 | 7 | 20 | 3.5 | 1 | 3.5 | RangedFighter, Monster, NaturallyVulnerableToSplash | Has a slimy ranged attack and a lot of health but no brain. Attacks whatever is closest. |
| Ram | E Ram | 250 | 2.2 | 3.5 | 15 | 2 | 7.5 | MeeleFighter, SiegeWeapon, ArmoredAgainstRanged, NaturallyHighHealthTarget, LargeUnit | Rams are siege units with a ton of health looking to tear down your walls and buildings. Furthermore, they are |
| Flogre | E Flogre | 275 | 4 | 3 | 9 | 1 | 9 | MeeleFighter, NaturallyVulnerableToSplash, Humanoid | A giant ogre equipped with a flail, dealing splash damage around it. |
| E Big Spider | E Big Spider | 800 | 10 | 4.2 | 12 | 0.3 | 40 | MeeleFighter, Monster, NaturallyVulnerableToSplash, FastMoving, LargeUnit |  |
| Thing | E Thing | 1100 | 4 | 6.2 | 2.2 | 0.3 | 7.33 | MeeleFighter, Monster, LargeUnit | A terrifying monster that can attack with its tentacles in all directions at once. |
| Elara the Vile | E Ghostqueen | 15000 | – | 50 | 15.6 | 0.15 | 104 | RangedFighter, MeeleFighter, Boss, ArmoredAgainstRanged, Humanoid | Could this really be the grave of the infamous Elara the Vile? You've heard the stories of how she burned down |

*Damage is the first row of the weapon's damage table (per-victim-tag multipliers apply in `Hp.TakeDamage`; see the combat doc).*

## 5. Buildings, costs and unlocks

| Building | Slots | Role | Slot appears when (activator upgrade #, count) | Prerequisite gold spent first (count) | Levels | Gold cost per level | Max income/day | Level-cap diff |
|---|---:|---|---|---|---:|---|---:|---:|
| Castle Center | 1 | castle | from the start ×1 | 0 g ×1 | 4 | 3 → 7 → 20 → 100 | 20 | – |
| Field | 10 | economy | Mill upgrade #1 ×4, Mill upgrade #2 ×6 | 6 g ×4, 10 g ×6 | 1 | 1 | 1 | – |
| House | 12 | economy | Castle Center upgrade #1 ×3, House upgrade #1 ×8, Castle Center upgrade #2 ×1 | 3 g ×3, 5 g ×3, 7 g ×2, 9 g ×1, 10 g ×1, 11 g ×1, 13 g ×1 | 3 | 2 → 2 → 20 | 4 | 0 |
| Mill | 2 | economy | Castle Center upgrade #1 ×2 | 3 g ×2 | 3 | 3 → 4 → 6 | 6 | 0 |
| Archery Range | 2 | military | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Barracks | 2 | military | Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 10 g ×1, 30 g ×1 | 4 | 4 → 8 → 16 → 50 | 0 | 0 |
| Gold Mine | 3 | other | Castle Center upgrade #1 ×1, Castle Center upgrade #2 ×1, Castle Center upgrade #3 ×1 | 3 g ×1, 10 g ×1, 30 g ×1 | 1 | 5 | 6 | 0 |
| Harbour | 1 | other | Castle Center upgrade #2 ×1 | 10 g ×1 | 2 | 3 → 7 | 0 | 0 |
| Hero's Quarter | 2 | other | Castle Center upgrade #1 ×2 | 3 g ×2 | 4 | 6 → 10 → 20 → 50 | 0 | 0 |
| Royal Forge | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 7 → 14 | 0 | 0 |
| Summoning Circle | 4 | other | Castle Center upgrade #1 ×4 | 3 g ×4 | 2 | 1 → 2 | 0 | 0 |
| Temple | 1 | other | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 2 → 6 → 25 | 0 | 0 |
| Shrine | 6 | shrine | Castle Center upgrade #1 ×6 | 3 g ×6 | 1 | 3 | 0 | 0 |
| Blacksmith | 1 | support | Castle Center upgrade #1 ×1 | 3 g ×1 | 3 | 4 → 9 → 16 | 0 | 0 |
| Defense Tower | 27 | tower | Castle Center upgrade #1 ×9, Castle Center upgrade #2 ×14, Castle Center upgrade #3 ×4 | 3 g ×9, 10 g ×14, 30 g ×4 | 4 | 3 → 5 → 15 → 40 | 3 | 0 |
| Wall | 7 | wall | Castle Center upgrade #1 ×3, Wall upgrade #1 ×1, Castle Center upgrade #2 ×3 (shares its activator's upgrades) | 3 g ×3, 10 g ×3, 14 g ×1 | 3 | 3 → 3 → 50 | 0 | 1 |

*'upgrade #N' means the slot appears when its activator is bought for the N-th time (activator level N−1 → N; `BuildSlot.Activate`: `activatorBuilding.Level > activatorLevel`). 'Prerequisite gold' sums those activator upgrades plus, recursively, what the activator itself needed. **Level cap:** past level 0 a building can only be upgraded while its root building's level is greater than its own level + the diff (`BuildSlot.CanBeUpgraded`); with diff 0 a Barracks can never exceed the castle's level.*

**Unlock timeline (derived):** **0 g** → 1× Castle Center; **3 g** → 1× Blacksmith, 9× Defense Tower, 1× Gold Mine, 2× Hero's Quarter, 3× House, 2× Mill, 1× Royal Forge, 6× Shrine, 4× Summoning Circle, 1× Temple, 3× Wall; **5 g** → 3× House; **6 g** → 4× Field; **7 g** → 2× House; **9 g** → 1× House; **10 g** → 1× Archery Range, 1× Barracks, 14× Defense Tower, 6× Field, 1× Gold Mine, 1× Harbour, 1× House, 3× Wall; **11 g** → 1× House; **13 g** → 1× House; **14 g** → 1× Wall; **30 g** → 1× Archery Range, 1× Barracks, 4× Defense Tower, 1× Gold Mine.

**Totals:** building every slot to its final level costs **3189 gold**; if everything is at maximum level the buildings pay **189 gold per dawn** (`goldIncomeChange`, paid at dawn only — see the [economy doc](../mechanics/02-economy-building-upgrades.md)).

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

* Hero-reachable ground: **18712 m²** (unbuilt world) of 18903 m² navmesh; 136 blocking colliders ({'static': 25, 'building': 111}), 14 auto-opening gates.

* The hero can walk from the castle to the nearest spawn-line vertex in 76–172 m (4.2 s at day speed).

* 82/82 build slots have at least one collision-free stand point within interaction range (`terrain/26_Moorweg.json → slots[].standPoints`); median walking distance castle→stand point 77 m.

* 6 shrines, each needs **350 XP**, collection range 20 m, pays 2 gold/dawn once unlocked (XP comes from unit deaths inside the range).


## 7. Method notes and limits

* **Sources:** waves, spawn lines, slots, unit and enemy stats are `MonoBehaviour` payloads decoded with layouts generated from the game DLLs (byte-exact on 655,330/655,330 objects); navmesh from the baked A* cache; colliders from the scene's physics objects. See `tools/refpack/`.
* **Hero-walkable model:** navmesh surface connected to the castle, minus colliders (blockers evaluated at the local surface height, walkable ramps excluded by triangle normal, gates ignored). It contains the hero in 99.7 % of logged Nordfels ticks (telemetry validation).
* **Estimates:** arrival times ignore fighting and avoidance; income is an upper bound; unit dps ignores per-victim multipliers and upgrades from perks/blacksmith.
