# Thronefall mechanics 02: economy, building, upgrades

Source: `Trainer/decompiled/` (Unity 2022.3 Mono). Cites are `File.cs:line`. **Asset** = value serialized in scenes/prefabs/ScriptableObjects. **Code default** = field initializer an asset may override. Numbers in parentheses are code defaults unless marked "asset"; where the extracted assets (`reference/data/levels/*.json`, `balance_sheet.json`) differ, the asset value is given inline or in the Verification log at the end. Section (b) and the "Spending priority" list in (f) are inference/policy; everything else is read from code.

## (a) Facts from code
(F-numbers are stable ids; F9 was merged into F3.)

### a1. Ledger, coins, energy cores
| # | Fact | Cite |
|---|---|---|
| F1 | Hero holds `balance`, `energyCoreBalance`, cumulative `networth`. `AddCoin` raises balance and networth; `SpendCoins` lowers balance only. | PlayerInteraction.cs:7-9,23,263-287 |
| F2 | `TrueBalance = balance + live Coin objects + coins queued in CoinSpawners` (cores likewise). Save stores TrueBalance; HUD shows `Balance` only. | PlayerInteraction.cs:93-95,116-123; TreasuryUI.cs:168-176 |
| F3 | Coin motion: optional fall, hop animation (`spawnAnimationDuration`, default 1 s), then, only if `target` is set, `MoveTowards(hero+(0,2,0), maxSpeed*dt*accelerationCurve(t/accelerationTime))` (defaults 20, 1 s). Collected at distance < 0.1 (hard-coded) via `AddCoin(1)`; HealingGold perk heals the hero per pickup. | Coin.cs:7-13,31,33,77-122 (heal 115-118) |
| F4 | Magnet: every frame `OverlapSphereNonAlloc(hero, coinMagnetRadius, 32-slot buffer, coinLayer)`; each free coin gets the hero as target. Default radius 10; hero asset 7.0 in all 36 extracted levels that have a hero (`levels/*.json` `heroes[0].interaction.coinMagnetRadius`). | PlayerInteraction.cs:11,31,250-261; Coin.cs:49 |
| F5 | Only coins with `registerInTagManager` enter `freeCoins` (every plain `Coin` enters `coins`). Dawn and a horn press target every free coin at any distance. | Coin.cs:67-73; DayNightCycle.cs:170-176; Nighthorn.cs:113-118 |
| F6 | `CoinSpawner.TriggerCoinSpawn(n)`: one coin per `interval` (default 0.5 s), each pre-targeted at the hero; aborts if the spawner object goes inactive. | CoinSpawner.cs:9,47-70 |
| F7 | Enemy gold: `Spawn.goldCoins` is scattered randomly over the spawn's `count` enemies (`Hp.coinCount`). On death coin 0 appears at the unit, coin i>=1 on a 2-unit ring at 45deg*i; needs an `Hp.coin` prefab. | Spawn.cs:90-101,159-162; Hp.cs:413-426 |
| F8 | `EnergyCore : Coin` has its own lists and spawner. Cores are produced, counted and spent only on Craaghelm DLC maps with the DLC available. | EnergyCore.cs:3-85; EnergyCoreSpawner.cs:47-70; BuildingInteractor.cs:222,398-401; BuildSlot.cs:903-906; PlayerInteraction.cs:110,119 |

### a2. Paying
| # | Fact | Cite |
|---|---|---|
| F10 | `TryToBuildOrUpgradeAndPay` never spends currency; it only executes the next `Upgrade`. Free upgrades call it, `ExecuteBuildOrUpgrade` or `ForceManualUpgradeWithoutFeedbackEffects` directly. Payment is `SpendCoins(1)` per completed slot inside `InteractionHold`. | BuildSlot.cs:730-763,845-888; BuildingInteractor.cs:215-220; UpgradeBuildersGuild.cs:76; OutpostPerk.cs:43; Tunnel.cs:99; AncientShrinePerk.cs:24; AutoUpgradeBuildingOnStart.cs:27 |
| F11 | Cost display = one `Coinslot` per cost unit. `TotalFillTime = clamp(n*0.15*0.9, 0.8, 1.75)` s. Each held frame `FillUp` adds `deltaTime*n/TotalFillTime` to the current slot; slot full at >=1 (overflow discarded) then one coin is spent. | CostDisplay.cs:51,69,108-199; Coinslot.cs:26-43 |
| F12 | Charged currency: cores if `NextUpgradeOrBuildEnergyCoreCost>0`, else gold. Gold branch needs `Balance>0` and core cost 0; core branch needs `EnergyCoreBalance>0`, gold cost 0, DLC map and DLC; otherwise `Deny()` (visual only). | BuildingInteractor.cs:215-231,418-428 |
| F13 | `CompletelyFilled = currentlyFilledCoins >= currentAmount`; cost 0 shows no slots and completes on the first hold frame. | CostDisplay.cs:65,125-131; BuildingInteractor.cs:202-213 |
| F14 | `CancelFill` re-spawns a hero-targeted coin per full slot; called on release (Upgrade state), `Unfocus`, cancelled choice. `UpdateDisplay`, called by `UpdateInteractionState` while focussed in Upgrade state (and again one frame later by `CostDisplay.Update`), zeroes fill with no refund. | CostDisplay.cs:79-84,108-120,218-232; BuildingInteractor.cs:235-246,272-284,359-366,407-416 |

### a3. BuildSlot
| # | Fact | Cite |
|---|---|---|
| F15 | `Upgrade{upgradeTooltip, cost=3, energyCoreCost, disableInThisMode, upgradeBranches}`; `UpgradeBranch{choiceDetails, replacementMesh, goldIncomeChange, energyCoreIncomeChange, hpChange, objectsToActivate, objectsToDisable}`. `upgrades[level]` is the next purchase; level 0 = Blueprint. Runtime writers of `cost`: PerkCostModifyer, UpgradeCastleUp, save restore; no level/wave/difficulty formula exists. | BuildSlot.cs:19-53,82,234-244,425; PerkCostModifyer.cs:20; UpgradeCastleUp.cs:61,65 |
| F16 | `CanBeUpgraded`: follower delegates to activator; false if `level>=upgrades.Count` or `upgrades[level].disableInThisMode`; if `root.Level <= level+requiredRootLevelDifference` only level 0 (first build) passes; else true. Root = end of the `activatorBuilding` chain (castle); a slot with no `activatorBuilding` is its own root (`requiredRoot = this`), so with a difference >= 0 only its first build passes unless forced to -100 (asset: 37 Castle Centers, 18 Houses in "Frostsee The Great Wall" and 1 Blacksmith in "Durststein" have none). Derived: new level <= `root.Level - requiredRootLevelDifference`. Default -100 = unrestricted (`PerkUnrestrictedUpgrading`, `AllowUpgrade` force it); asset values: 0 on 1,475 slots, 1 on 504 (Wall/Barricades), -100 on only 440 (Field/Castle Center). `BuildSlotExt` adds `Level < maxLevel+1`. | BuildSlot.cs:57-59,270-296,656-663; PerkUnrestrictedUpgrading.cs:13-16; AllowUpgrade.cs:8-11; BuildSlotExt.cs:15-25 |
| F17 | `NextUpgradeOrBuildCost` and `...EnergyCoreCost` return sentinel 100 when not upgradable. | BuildSlot.cs:318-322,345-349 |
| F18 | Follower (`activatorUpgradesThis`): `Upgrades`, `Level`, `CanBeUpgraded`, costs come from the activator. Buying the activator first runs each follower's own next upgrade with a random branch (no UI) and fires `OnParentUpgrade`, not `OnUpgrade`. | BuildSlot.cs:188-212,274-277,314-317,741-750,790-793,835-839 |
| F19 | `Start` builds `isActivatorOf`/`isRootOf`/`builtSlotsThatRelyOnThisBuilding`. If `startDeactivated` (default true) the GameObject is disabled and `Activate` hooks `activatorBuilding.OnUpgrade`; `Activate` succeeds when `activatorBuilding.Level > activatorLevel`. Otherwise `Activate` runs at once. A saved `level` clears `startDeactivated`. OutpostPerk uses `ActivateIgrnoringActivatorLevel`. | BuildSlot.cs:69-80,405-408,649-701; OutpostPerk.cs:39-44 |
| F20 | `ReduceChildrensBuildRequirementIfPerk`: on first Update with the perk, each direct child gets `activatorLevel=max(0,activatorLevel-1)`, then self-destroys. | ReduceChildrensBuildRequirementIfPerk.cs:8-22 |
| F21 | `ApplyLocalUpgradeChanges`: mesh swap; `goldIncome += goldIncomeChange`; `energyCoreIncome +=` (DLC only); `maxHp += hpChange` then `Heal(hpChange)` (no heal on load); any purchase clears `AUTO_NoReviveNextMorning`, and a knocked-out building (new level>1) is first revived at 1 HP; `objectsToActivate` on, `objectsToDisable` off. `OnEnable` first switches every `objectsToActivate` off. | BuildSlot.cs:528-544,890-940 |
| F22 | After `level++`, `OnUpgradeChoiceComplete` refreshes interactors under every `isRootOf` slot, then fires `OnUpgradeEarly`, `OnUpgrade` (dependants `Activate`). Branch index found by reference equality of `choiceDetails`. | BuildSlot.cs:796-843 |
| F23 | Save keeps `level`, `appliedUpgrades`, and the next upgrade's cost(s) (load restores the gold cost only if non-zero, and the core cost only alongside it, DLC maps only); branches re-apply one frame after load. PerkCostModifyer skips upgrades whose cost came from save. | BuildSlot.cs:403-458; PerkCostModifyer.cs:16-21 |

### a4. Choices
| # | Fact | Cite |
|---|---|---|
| F24 | `PresentChoices`: 0 branches = cancel; 1 = applied at once; >=2 (locked ones count) = choice frame with `PlayerFrozen=true` until pick or cancel. Ignored while another choice runs, and `ExecuteUpgrade` then returns silently. | ChoiceManager.cs:47-82; BuildSlot.cs:775-777 |
| F25 | Locked = `disabledInThisMode` or `!CanBePicked`. `CanBePicked` is true if level flag `allBuildingChoicesUnlocked` (asset) or Eternal Trial or `requiresUnlocked` is null; else needs `requiresUnlocked.IsUnlocked` (meta level / campaign). UI refuses locked picks. | Choice.cs:7,22-36; LevelProgressManager.cs:64-76; Equippable.cs:72-90; TFUIUpgradeChoice.cs:182-212; ChoiceUIFrameHelper.cs:141-149 |
| F26 | GodOfChoice: one frame after enable, floor(n/2) branches of every upgrade get `disabledInThisMode`, chosen deterministically from the SaveLoadEntity GUID. | BuildSlot.cs:546-603 |
| F27 | Cancel sources: Cancel button, closing the choice frame, auto-day timer expiry. Result `OnUpgradeCancel`, interactor unblocks and refunds. | CancelOrOpenPauseMenu.cs:18-23; UIFrameManager.cs:262-265; DayNightCycle.cs:116-128; BuildSlot.cs:798-802; BuildingInteractor.cs:272-284 |

### a5. Harvest and modifiers
| # | Fact | Cite |
|---|---|---|
| F28 | `canBeHarvested` = Built and not `harvestedToday` and (`GoldIncome>0` or `EnergyCoreIncome>0`) and not `knockedOutTonight`. `Harvest` spawns `GoldIncome` coins (plus cores). Triggers: dawn, `Focus` in Harvest state, horn. `BuildComplete` and `OnLoad` set `harvestedToday=true`, so a new or upgraded building first pays at the next dawn. | BuildingInteractor.cs:92-102,248-254,297-306,380-405,527-532; Nighthorn.cs:109-112 |
| F29 | `knockedOutTonight` is set on Hp knock-out (skipped when `neverDenyHarvest` is set, by `PerkRemoveDestroyedAtNightTag`) and cleared at dusk; it denies the dawn harvest in between. Also set by `MarkDestroyedBuildingsAsDontRevive` under DestructionGod and by `TemplePrayers` on all Shrines. | BuildingInteractor.cs:155-158,286-290,435-441; PerkRemoveDestroyedAtNightTag.cs:11-16; Hp.cs:483; TemplePrayers.cs:34-43 |
| F30 | Builders Guild: free upgrade (random branch) of a Level-1 House at effect enable and every `OnDuskEarly`. Outpost and Tunnel also build free. | UpgradeBuildersGuild.cs:22-36,43-46,67-80; OutpostPerk.cs:22-47; Tunnel.cs:97-124 |
| F31 | Each `IncomeModifyer` registers with its interactor; `OnDawn` runs after the harvest inside `OnDawn_AfterSunrise` (table below). | IncomeModifyer.cs:9-16; BuildingInteractor.cs:297-306 |

| Modifier | Effect | Cite |
|---|---|---|
| IncreaseIncomeDaily | `GoldIncome += 1` each dawn | IncreaseIncomeDaily.cs:24-28 |
| FishingHarbour | Level>0 and not knocked out: `GoldIncome = min(GoldIncome+incomeIncreasePerTurn(1), maximumIncome(5))`; copies it into `Upgrades[1].upgradeBranches[0].goldIncomeChange`; then `MarkAsHarvested()` (the new income is not harvestable the same day); the `FishingHarbourUpgrade` branch object doubles both constants when enabled | FishingHarbour.cs:6-8,44-65; FishingHarbourUpgrade.cs:10-11 |
| MineShaft | `GoldIncome = max(GoldIncome-1, 1)`; with SustainableMining the floor is `minimumIncomeWithSustainableMining` (code 3, asset 1); knocked out + perk resets to `resetIncomeSustainableMining` (code 6, asset 7) | MineShaft.cs:6-16,152-195; balance_sheet.json `MineShaft.MineShaft.*` |
| Shrine | XP >= `maxXp` (code 1000, asset 350): `GoldIncome += incomeOnceUnlocked`(2); `collectionRange` code 10, asset 20 | Shrine.cs:24,32,87-102,129; levels/*.json `shrines[]` (121 of 121 shrines) |
| PerkIncomeModifyer / PerkCostModifyer | Start: branch `goldIncomeChange += upgradeIncomeChange[i]`; `upgrades[i].cost += upgradeCostChange[i]` | PerkIncomeModifyer.cs:34-56; PerkCostModifyer.cs:10-25 |
| PerkHpModifyer | Building branches: `hpChange = round(hpChange*hpMultiplyer)`, `maxHp *= hpMultiplyer` | PerkHpModifyer.cs:39-71 |
| UpgradeCastleUp | Wall/tower at Level 1: next cost `max(1,cost-2)`; at Level 2: `max(1,cost-4)` (code defaults; asset discounts 1 at Level 1 and 4 at Level 2, balance_sheet.json `CastleCenterVariant.CastleUp.UpgradeCastleUp.*`); reapplied after each wall/tower upgrade | UpgradeCastleUp.cs:10-31,55-68; CaslteUpReciever.cs:8-19 |
| Mill_ImprovedPlow | `goldIncomeChange +1` on upgrades[1] and [2] | Mill_ImprovedPlow.cs:12-25 |
| TempleWisdom | Night: destroyed buildings drop `goldForDestroyedBuilding` coins; buildings bleed HP | TempleWisdom.cs:23-34,46-65 |
| TemplePrayers | On purchase every Shrine gets `GoldIncome = 0` and `CollectionRange` x`rangeMulti` (code 1.5; asset 2/2.5/4 for Prayers0/1/2); at dusk `GoldIncome` returns to `incomeOnceUnlocked` (0 if not activated) but every Shrine is marked knocked out, so no shrine gold at the next dawn; range reverts at dawn | TemplePrayers.cs:12-53; `localization_en.csv` `Building/Temple Choice Prayers 0 Description` |
| PerkIndestructible; PerkDestroyGameObjectModifyer / EternalTrialsOnlyBuilding | Start: strip `PlayerOwned` tag from the building; destroy the object by perk state / outside Eternal Trial | PerkIndestructible.cs:8-19; PerkDestroyGameObjectModifyer.cs:33-46; EternalTrialsOnlyBuilding.cs:5-13 |

Other `Perk*Modifyer` classes (Cooldown, Range, Speed, Weapon, Damage*, KnockbackOnDestroy, PlayerHealthRegen) reference no cost, income or BuildSlot (grep).

### a6. Destruction, repair, respawn
| # | Fact | Cite |
|---|---|---|
| F32 | Hp<=0 fires `OnKillOrKnockout`. If `getsKnockedOutInsteadOfDying` (asset): tag `AUTO_KnockedOutAndHealOnDawn`, visuals swap, attacks disabled; else object destroyed. `BuildingDestructionHandler` is cosmetic (particles, sound, shake). | Hp.cs:13,252-308,383-412; BuildingDestructionHandler.cs:31-61 |
| F33 | `DawnCallAfterSunrise` (after `sunriseTime`, d3) begins with `ReviveAllKnockedOutPlayerUnitsAndBuildings`: all PlayerOwned without `AUTO_NoReviveNextMorning` revive at 100% and turn invulnerable; dusk removes it. DestructionGod: a knocked-out building's NoRevive tag toggles each dawn (stays down through the first dawn, revives at the second with `destructionGodHealthRegen` of max HP; code 0.33, asset 0.25). | DayNightCycle.cs:141-146,215-225; Hp.cs:475-535 |
| F34 | Knocked-out hero: `PlayerInteraction` disabled (no magnet, no focus); `AutoRevive` revives instantly by day. | Hp.cs:300-303; AutoRevive.cs:97-103 |
| F35 | `UnitRespawnerForBuildings`: night only, only if its own building Hp is up; timer drops by `dt*unitRespawnSpeedMulti` while a unit is down; at 0 revives ONE unit beside the building, timer = `timeToRespawnAUnitDependingOnLevel[clamp(Level)]/totalTrainingSpeed` (asset seconds by level index: Barracks and Archery Range 15/10/6/6, Hero's Quarter 60 for all). GodOfDeath disables it; Temple Sacrifice multiplies `unitRespawnSpeedMulti` (code x3, asset x3.5/x3.75/x4.0 for Sacrifice0/1/2) and kills all player units at dusk. | UnitRespawnerForBuildings.cs:53,67,77-106,121-154,156-194; TempleSacrifice.cs:5-20; levels/*.json `unitProducer.respawnSecondsByLevel`; balance_sheet.json `TempleSacrifice.*` |
| F36 | Busy buildings: Blacksmith/RoyalForge research (`researchTime` dawns, ticks only if not knocked out) and Temple blessings set `buildingIsCurrentlyBusyAndCantBeUpgraded`, forcing interactor state None. | BlacksmithUpgrade.cs:41-63,93-107; RoyalForgeUpgrade.cs:49-71,136-150; TempleUpgrade.cs:29-70; BuildingInteractor.cs:343-346 |

**F37.** `EconomySimulator`/`VirtualBuilding` are offline balancing code called only by the Eternal Trial wave generators (SeasonTwoWaveGen.cs:128; SuperWaveGen.cs:405; used at EnemySpawner.cs:286-294). Per simulated night: defense budget `ceil(V/3)`, rest to economy, all to defense in the last two nights; buy the highest-`priority` affordable building whose requirements are built; income = sum of built `income`, then hooks (Mill -1 min 1, Shrine +1 max 2, Harbor +1 max 5); enemy gold `clamp(ceil(networth*rate), min, max)`, 0 on the last night (EconomySimulator.cs:28-62,93-124; VirtualBuilding.cs:55-120).

**F38.** `PlayerUpgradeManager` (hero damage/regen multipliers; WarriorMode scales damage each wave) and `BlacksmithUpgrades` (global damage, resistance, `unitRespawnSpeedMulti`; changed by research, Empire, Temple Sacrifice, perks) never touch gold (PlayerUpgradeManager.cs:13-16,83-104; BlacksmithUpgrades.cs:7-40; BlacksmithUpgrade.cs:69-86).

## (b) Inferences (not proven by code)
1. **Buildings are knocked out, not destroyed**: `getsKnockedOutInsteadOfDying` is an asset, but `MarkDestroyedBuildingsAsDontRevive` and the revive branch in `ApplyLocalUpgradeChanges` presuppose it (Hp.cs:475-494; BuildSlot.cs:909-919). High confidence.
2. **Enemy-drop coin prefabs set `registerInTagManager`**: untargeted coins are reachable by the dawn/horn sweep only through `freeCoins`, and the tutorial guides the hero to them (DayNightCycle.cs:170-176; Nighthorn.cs:44-67; TutorialManager.cs:215-228). Harvest and refund coins are pre-targeted and need no registration (CoinSpawner.cs:67; CostDisplay.cs:224). Medium.
3. **Mid-hold reset risk**: any `UpdateInteractionState` while focussed and in Upgrade state calls `UpdateDisplay` and drops paid slots without refund (F14). Callers found: completion, dawn/dusk, busy flags, so rare (BuildSlot.cs:751-762; BuildingInteractor.cs:248-254,286-306; BlacksmithUpgrade.cs:59). Medium.
4. **FishingHarbour upgrade 2 roughly doubles income**: harbour income is written into the branch delta (FishingHarbour.cs:63) and deltas are added (BuildSlot.cs:902). Medium.
5. **`EconomySimulator` pacing describes generated (Eternal Trial) modes only**; hand-authored waves live in scene assets (EnemySpawner.cs:26), so using it as a bot prior is a judgement call.
6. **An upgrade with gold and core cost both >0 can never be paid** (F12); none exist in the extracted levels (0 of 13,610 `upgrades.csv` rows have `coreCost` > 0); the Craaghelm DLC scenes are not extracted, so unknown there (Verification log).
7. **Dawn callback order is reverse registration** (DayNightCycle.cs:145-162), so cross-object order is unspecified except harvest-before-modifiers (F31).

## (c) Gold, coins, income end to end
| Flow | Formula / constants | When | Cite |
|---|---|---|---|
| Start gold | `goldBalanceAtStart` (code default 10; asset 0-35 per Classic level, e.g. Nordfels 8; Eternal/Endless generators overwrite) `+ loanBonusMoney` (Loan; asset 7) `+ royalMint_startGoldBonus` (code default 1; asset 0); skipped (0) when loading a save with `wavenumber` | scene start | EnemySpawner.cs:18,232-237,286-309,342-367; PerkManager.cs:36,229; levels/*.json `spawners[0].goldBalanceAtStart`; balance_sheet.json `PerkManager.PerkManager.*` |
| Building income | `sum GoldIncome_b` over Built, not knocked out, not yet harvested; `GoldIncome_b = sum applied goldIncomeChange + runtime modifiers` (a5). Coin k spawns `k*interval` after harvest, flies after the hop (>=1 s default) | each dawn, `sunriseTime` after day starts (asset 3.0 s in all 37 extracted levels; code default 2.5) | BuildingInteractor.cs:92-102,297-306; CoinSpawner.cs:55-70; DayNightCycle.cs:28,279-291; levels/*.json `dayNight[0].sunriseTime` |
| Enemy gold | Wave gold `W = sum spawn.goldCoins`. RatGod: `v = goldCoins*ratGod_GoldModifyer(0.5)+carry; goldCoins = ceil(max(0,v)); carry = v - goldCoins`. Loan: `loanInterestMoney` (asset 10) removed from the earliest spawns | drops at kills (night) | EnemySpawner.cs:329-355,742; PerkManager.cs:83,232 |
| Interest (perk) | `min(maximumInterest(20), ceil(Balance/interestForEach(3)))` added straight to `Balance`; `Balance`, not TrueBalance | dusk | InterestPerk.cs:12,16,47-63 |
| Treasure Hunter (perk) | +10/+20/+30 (code defaults; asset 15/25/40) at the three dawns before the last three waves, direct `AddCoin` | dawn | EnemySpawner.cs:424-445,501-520; PerkManager.cs:140-146 |
| Purchase | `cost` coins, one per slot; time to pay `TotalFillTime(n)`: n<=5 0.80 s, 8 1.08 s, 10 1.35 s, >=13 1.75 s, plus one frame to execute. Coins already in a full slot leave `Balance` immediately | day only | CostDisplay.cs:69; BuildingInteractor.cs:196-233 |
| Refund | 1 coin per full slot, returns as flying coins | release / unfocus / cancel | CostDisplay.cs:218-232 |
| Thief | removes `min(_theftAmount(3), Balance)` after 5 s at target; drops `theft+_bonus` coins when killed | night | ThiefController.cs:8,12,16,54-65,108-118 |
| Other sinks | path toggle `toggleCost` (1); power-up `powerUpCost` (2 cores, scheduled days) | day (path toggle: per `toogleOnlyAtDay`/`toggleOnlyAtNight`, default any time; power-up: day only) | CutOpenPathInteractor.cs:21,84-106,184-191; ScheduledActivationInteractor.cs:13,45-60,118-152 |
| Score link | victory bonus `ceil(TrueBalance*victoryGoldBonusMultiplyer(10))`; nightly protection score penalizes knocked-out buildings | victory / dawn | ScoreManager.cs:60,66,157-199 |

Energy cores: same pipeline with `EnergyCoreIncome`, `energyCoreCost`, 1 core per slot, DLC maps only (F8, F12). `Empire` scales blacksmith multipliers by `1 + Balance/goldToDoublePower` at dusk (code 1000, asset 1500 in all four Empire variants; EmpireUpgrade.cs:7,42-56; balance_sheet.json `CastleCenterVariant.Empire*.EmpireUpgrade.goldToDoublePower`).

## (d) BuildSlot lifecycle
**d1. Graph.** Each slot has at most one `activatorBuilding`; the chain end is the root (castle). A child unlocks when `activator.Level > activatorLevel` (F19); `GetBuildSlotsThatWillUnlockWhenUpgraded` lists children with `activatorLevel == level` (BuildSlot.cs:605-616). Buying is then gated by `CanBeUpgraded` (F16); first build (level 0) ignores the root cap.

**d2. Purchase pipeline.**
1. Focus, state Upgrade (d4). Hold pays coin by coin (F11).
2. Next hold frame with `CompletelyFilled`: `isWaitingForChoice = NextUpgradeIsChoice` (branches>1), then `TryToBuildOrUpgradeAndPay` (BuildingInteractor.cs:202-213).
3. Followers execute first, then `ExecuteUpgrade` (choice UI or immediate) (BuildSlot.cs:741-794).
4. `OnUpgradeChoiceComplete`: level 0 shows the building; `level++`; `appliedUpgrades.Add`; `ApplyLocalUpgradeChanges`; refresh root dependants; `OnUpgradeEarly` triggers the wall/tower discounts, then `OnUpgrade` activates children and paired tunnels (BuildSlot.cs:796-843; CaslteUpReciever.cs:10; Tunnel.cs:53,121-124).
5. Interactor `BuildComplete`: `harvestedToday=true`, `interactionComplete=true`, state refresh (next cost shows if still upgradable) (BuildingInteractor.cs:248-270).

**d3. Dusk and dawn.**
| Step | Effect | Cite |
|---|---|---|
| Dusk: `SwitchToNight` sets Night, then `DuskCall` | player-owned become vulnerable; `OnDuskEarly` (Builders Guild upgrade, respawner arms); `OnDusk`: BuildSlot hides blueprint, interactor clears `knockedOutTonight` and forces state None, Interest pays, horn hides | DayNightCycle.cs:215-261,301-309; BuildSlot.cs:961-967; BuildingInteractor.cs:286-290; InterestPerk.cs:47-50; Nighthorn.cs:128-132 |
| Night | all interactors None; enemy drops; knock-outs set `knockedOutTonight` | BuildingInteractor.cs:327-330,435-441 |
| Dawn 1: state Day, `OnDawn_BeforeSunrise` | `harvestedToday=false`; temple effects end; respawner off; night score computed | DayNightCycle.cs:190-213,279-290; BuildingInteractor.cs:292-295; TempleUpgrade.cs:33-44; UnitRespawnerForBuildings.cs:191-194; ScoreManager.cs:196-199 |
| Dawn 2: after `sunriseTime` (asset 3.0, code default 2.5) | revive all (F33); `OnDawn_AfterSunrise`: blueprints reappear, each interactor harvests then runs modifiers then refreshes state, research ticks; then every free coin is targeted; victory if last wave done | DayNightCycle.cs:141-188,293-296; BuildSlot.cs:969-975; BuildingInteractor.cs:297-306; BlacksmithUpgrade.cs:41-63 |

**d4. `CanBeInteractedWith` and early-outs.** `CanBeInteractedWith = currentState != None` (BuildingInteractor.cs:124). `currentState` is cached and recomputed only by `UpdateInteractionState`: Harvest if `canBeHarvested`, else Upgrade if `CanBeUpgraded`, else None; forced None at Night, when dusk forces it, or when busy; the method returns without changes while `isWaitingForChoice` (BuildingInteractor.cs:308-346). Harvest outranks Upgrade, but `Focus` harvests instantly and the state falls to Upgrade (BuildingInteractor.cs:380-388).

Focus requires: slot activated (F19); Interact not held (the scan is skipped while Interact or Call Night is held or the focussed building awaits a choice); collider on `interactorLayer` within `interactionRadius` (default 3); `CanBeInteractedWith`; nearest by `ClosestPoint` (PlayerInteraction.cs:185-232).

| Gate, in evaluation order | Cite |
|---|---|
| Hero knocked out: `PlayerInteraction` disabled, no `Update` | Hp.cs:300-303 |
| `PlayerFrozen` (choice UI, menus) blocks all input | PlayerInteraction.cs:152-155 |
| Interact pressed with no focus fires the weapon instead | PlayerInteraction.cs:156-165 |
| `currentState != Upgrade` (Harvest, night, busy, not upgradable, root-capped) | BuildingInteractor.cs:198 |
| `interactionComplete`: previous purchase done, release and press again | BuildingInteractor.cs:184-194,198,248-254 |
| `!interactionStarted`: press happened unfocussed, or after release | BuildingInteractor.cs:198,235-246 |
| `isWaitingForChoice` | BuildingInteractor.cs:198 |
| Not full and `Balance==0`, or currency mismatch: `Deny` only | BuildingInteractor.cs:215-231 |

Subclasses: `ScheduledActivationInteractor` is also interactable on its scheduled day when not powered and by day, and charges cores (ScheduledActivationInteractor.cs:45-60,118-152); `CutOpenPathInteractor` obeys day/night, once-per-day and castle-built rules (CutOpenPathInteractor.cs:184-191).

**d5. Destruction, repair, respawn.** Night knock-out sets `knockedOutTonight` (no income next dawn); dawn revives at full HP and dusk clears the flag (BuildingInteractor.cs:286-290,435-441; Hp.cs:506-535). Paid repair exists only as an upgrade of a downed building (revive at 1 HP + delta; matters under DestructionGod, BuildSlot.cs:909-919). Units revive at dawn or one at a time at night via the barracks timer (UnitRespawnerForBuildings.cs:77-154).

## (e) Serialized values stored in assets (for the extractor)
Numbers in parentheses below are code defaults. Extracted asset values that differ (BuildSlot requiredRootLevelDifference 0 or 1 on 1,979 of 2,419 slots, sunriseTime 3.0, nightCallTime 2.0, hero coinMagnetRadius 7, Shrine maxXp 350 / collectionRange 20, MineShaft 1 / 7, castle-up discount 1, Empire 1500, Treasure Hunter 15/25/40, Royal Mint start bonus 0, researchTime and multiplyer per upgrade) are tabulated in the Verification log.

| Owner | Fields (type) | Meaning / code default |
|---|---|---|
| BuildSlot | `upgrades[i].cost` (int), `.energyCoreCost` (int), `.disableInThisMode` (bool), `.upgradeTooltip` | Price of build/upgrade i (i=0 build; default 3); list length = max level |
| BuildSlot | `upgrades[i].upgradeBranches[j].goldIncomeChange`, `.energyCoreIncomeChange`, `.hpChange` (int) | Deltas on purchase; branch count>1 = player choice |
| BuildSlot | `.choiceDetails` (Choice: `name`, `tooltip`, `requiresUnlocked`, `hasArachnophobiaMode`), `.objectsToActivate/Disable` | Choice identity and effect objects |
| BuildSlot | `requiredRootLevelDifference` (int, -100), `startDeactivated` (bool, true), `activatorBuilding`, `activatorLevel` (int), `activatorUpgradesThis` (bool), `buildingName` | Graph edges and level caps |
| BuildSlotExt | `maxLevel`, coin/coinslot prefabs | Level cap, currency visuals |
| BuildingInteractor | `coinSpawner`, `energyCoreSpawner`, `costDisplay`, `buildingHP`, `showsHarvestDeniedCueEvenWithNoIncome`, `buildingIsCurrentlyBusyAndCantBeUpgraded` | Wiring and initial busy flag |
| Hp (buildings) | `maxHp`, `getsKnockedOutInsteadOfDying`, `coin`, `coinCount`, `coinSpawnOffset` | HP base, death mode |
| PlayerInteraction | `coinMagnetRadius` (10), `interactionRadius` (3), `coinLayer`, `interactorLayer` | Reach |
| Coin/EnergyCore prefab | `maxSpeed` (20), `accelerationTime` (1), `accelerationCurve`, `spawnAnimationDuration` (1), `spawnAnimationScale`, `groundOnSpawn`, `registerInTagManager` | Flight timing, free-coin flag |
| CoinSpawner | `interval` (0.5) | Spacing |
| EnemySpawner | `goldBalanceAtStart` (10), `waves[].spawns[].goldCoins/count` | Start gold, drops per wave |
| PerkManager | `royalMint_startGoldBonus` (1), `ratGod_GoldModifyer` (0.5), `treasureHunterGoldAmountWave1..3` (10/20/30), `loanBonusMoney`, `loanInterestMoney`, `healingGoldHealAmount`, `destructionGodHealthRegen` (0.33) | Perk numbers |
| InterestPerk | `interestForEach` (3), `maximumInterest` (20) | Interest curve |
| Perk*Modifyer | `PerkCostModifyer.upgradeCostChange[]`, `PerkIncomeModifyer.upgradeIncomeChange[]` (int per upgrade index), `PerkHpModifyer.hpMultiplyer` | Per-level perk deltas |
| Income scripts | FishingHarbour (`incomeIncreasePerTurn` 1, `maximumIncome` 5, `additionalBoatCapacity`), MineShaft (`incomeReductionPerTurn` 1, `minimumIncome` 1, `minimumIncomeWithSustainableMining` 3, `resetIncomeSustainableMining` 6), Shrine (`incomeOnceUnlocked` 2, `maxXp` 1000, `collectionRange` 10) | Dynamic income rules |
| Misc costs | UpgradeCastleUp `immediateWallAndTowerDiscount2/3` (2/4), EmpireUpgrade `goldToDoublePower` (1000), TempleWisdom `goldForDestroyedBuilding`, ThiefController `_theftAmount` (3) `_bonus` `_holdDuration` (5), CutOpenPath `toggleCost` (1), ScheduledActivation `powerUpCost` (2) `daysToPowerUp[]` | Sinks/discounts |
| Respawn/research | `timeToRespawnAUnitDependingOnLevel[]` (s per level), BlacksmithUpgrade/RoyalForgeUpgrade `researchTime` (2) `multiplyer` (1.2) | Timings and effect size |
| Branch effect scripts (run in `OnEnable` when the branch object is activated, BuildSlot.cs:926-932) | `TowerUpgrade` (`attackCooldownMulti`, `rangeMulti`, `projectileSpeedMulti`, `damageMulti`, `additionalArrowsToShoot`), `UpgradePlayerHp` (`healthMultiplyer`, `heatlhRegenMultiplyer`), `UpgradePlayerDmg.damageMultiplyer`, `UpgradeUnitsOnEnable` (`healthMulti`, `attackMulti`), `UpgradeGodlyCurse.damagePercentage`, `FishingHarbourUpgrade` | Per-level combat/income effects (TowerUpgrade.cs:65-120; UpgradePlayerHp.cs:11-21; UpgradePlayerDmg.cs:8-11; UpgradeUnitsOnEnable.cs:16-29; UpgradeGodlyCurse.cs:8-10,25-32; FishingHarbourUpgrade.cs:8-13) |
| Level/global | LevelInfo `allBuildingChoicesUnlocked`, `virtualBuildings[]`; Equippable `unlockRequirement`/`requiredBeatenLevel`; DayNightCycle `sunriseTime` (2.5); ScoreManager `victoryGoldBonusMultiplyer` (10) | Unlocks, pacing |

## (f) Bot implications
**Readable state (same facts the UI shows).** `PlayerInteraction.instance.Balance/EnergyCoreBalance/TrueBalance`; per slot `Level`, `CanBeUpgraded`, `NextUpgradeOrBuildCost` (valid only if `CanBeUpgraded`, F17), `NextUpgradeIsChoice`, `GoldIncome`, branch deltas and `ReturnTooltip()` (BuildSlot.cs:460-526); interactor `CanBeInteractedWith`, `canBeHarvested`, `KnockedOutTonight`, `IsWaitingForChoice`; `ChoiceManager.instance.ChoiceCoroutineRunning/availableChoices` with `disabledInThisMode`/`CanBePicked`; income preview `TFUIIncomeDisplay.UpdateData` (TFUIIncomeDisplay.cs:53-107); `EnemySpawner.GetWaveInfoForNextWave().goldReward` (EnemySpawner.cs:600-611); `DayNightCycle.CoinCountToBeHarvested` (DayNightCycle.cs:70-88).

**Acting legitimately.** Use only player inputs: move, hold Interact, pick in the choice UI, horn/Call Night. Do not call `TryToBuildOrUpgradeAndPay`, `DEBUGUpgradeToMax`, the cost/income setters or `AddCoin`; they skip payment (F10; BuildSlot.cs:327-333,949-959).

**Spending priority (policy derived from the facts above).**
1. Wait until dawn coins land: `TrueBalance == Balance` (F2); coins keep arriving for `(G-1)*0.5 s` plus flight.
2. Income first while `deltaIncome * usableDawns > cost`, where `usableDawns = WaveCount - 2 - Wavenumber` (the dawn after the last wave ends the match; income bought today first pays next dawn, F28). Rank by `deltaIncome/cost`; among choices prefer larger `goldIncomeChange`, only if unlocked.
3. Value a castle/root upgrade as what it unlocks: children with `activatorLevel==Level` and caps lifted by `requiredRootLevelDifference` (F16, d1).
4. Never leave a wave under-defended (`GetWaveInfoForNextWave()`). Generators' reference split: 1/3 defense first, 2/3 economy, all defense in the last two nights (EconomySimulator.cs:28-34); a prior only.
5. Protect income: a knocked-out building pays nothing next dawn and lowers protection score (F29; ScoreManager.cs:166-180).
6. Idle gold earns nothing unless Interest (defaults: `ceil(Balance/3)`, cap 20 reached at Balance 58, InterestPerk.cs:56-63) or Empire (EmpireUpgrade.cs:42-56) is active; at victory each coin scores about 10 (ScoreManager.cs:66).
7. Start a purchase only when `Balance >= cost` in the right currency; hold continuously for `TotalFillTime(n)` (F11); release and press again per level.

**Deadlocks.**
| Symptom | Cause | Escape |
|---|---|---|
| Choice UI open, hero frozen | `ChoiceCoroutineRunning` (F24) | Pick an unlocked branch through the UI, or Cancel (coins refund) |
| Every branch locked | `requiresUnlocked` / GodOfChoice (F25, F26) | Cancel; buy elsewhere |
| Hold fills nothing, Deny loops | `Balance==0`; core cost with 0 cores (code spawns cores only in harvests, F8, F28; asset-assigned drop prefabs unchecked); DLC missing; gold and core cost both >0 (F12) | Earn coins/cores; skip that upgrade |
| Nothing after a purchase | `interactionComplete` | Release, press again |
| Never focuses | Interact held on arrival; nearer interactor; state None | Release, step within radius, wait a frame, then press |
| State None by day | busy research/temple; root cap; max level; awaiting choice | Wait dawns; upgrade castle first |
| Cannot start night | Horn needs `AllCoinsHarvested` (first press only harvests, Nighthorn.cs:44-67,97-121); hold Call Night for `nightCallTime` (asset 2.0 s in all 37 extracted levels, `levels/*.json` `nightCall[0].nightCallTime`; code default 1 s) needs no focussed interactor and no auto day (PlayerInteraction.cs:81; NightCall.cs:11,73-76) | Press horn twice; step away from interactors |

## Verification log (independent fact-check)

**Date:** 2026-09-29. Independent pass against `Trainer/decompiled/` and `reference/data/`; the game was not run. Paths below are relative to `reference/data/` unless stated.

**Coverage and method.**
- Every cited range was opened in `decompiled/` and compared for numbers, comparison operators, member names, enum values and causality. All 194 original `File.cs:line` cites (195 after the edits) resolve to existing files with in-range lines (scripted check); the first and last line of each range were also printed to catch off-target cites.
- Identifier audit: 393 backticked spans in the original (308 distinct); every identifier-like word was searched in `decompiled/**/*.cs` and `reference/maps/code/Assembly-CSharp.types.jsonl`. Not found in the original: `trainingSpeed` (real name `totalTrainingSpeed`, fixed), `filled` and `branch` (shorthand for `currentlyFilledCoins`/`currentAmount` and `upgradeBranches`, fixed). The other unresolved words were pseudo-variables in formulas (`GoldIncome_b`, `carry`, `ceil`, `deltaIncome`, `usableDawns`, `hero`, `modifiers`, `queued`) or path words (`Trainer`, `decompiled`).
- Asset cross-check: `levels/*.json` (37 scenes, 2,419 BuildSlots), `upgrades.csv` (13,610 rows), `build_slots.csv`, `waves_all.csv`, `balance_sheet.json` (3,174 values), `localization_en.csv`, `level_infos.json`, `enemy_prefabs.json`.
- Unity 2022.3 Mono confirmed: `UnityPlayer.dll` FileVersion 2022.3.62.7762112 (2022.3.62f2), `MonoBleedingEdge/` present, no `il2cpp_data/`.
- Scoring rule for constants: a code-initializer value quoted as the effective value and not marked default is WRONG when the extracted assets override it; if the doc marked it default/code it stays SUPPORTED as a code default and the asset value was added. A backticked name that looks like a real member but does not exist (`trainingSpeed`) or an off-target cited line is WRONG; abbreviated names (`filled`, `branch`) and a right idea with a wrong or missing detail are PARTIAL.

**Result: 351 claims checked** (78 prose claims outside tables, 273 in tables): SUPPORTED 327, PARTIAL 12, WRONG 10, CANNOT-VERIFY 2. Edits: 30 rows in the corrections table below plus 3 more listed after it.

| Section | Claims | Supported | Partial | Wrong | Cannot-verify |
|---|---|---|---|---|---|
| header | 1 | 1 | 0 | 0 | 0 |
| a1 (F1-F8) | 32 | 32 | 0 | 0 | 0 |
| a2 (F10-F14) | 23 | 21 | 2 | 0 | 0 |
| a3 (F15-F23) | 46 | 44 | 2 | 0 | 0 |
| a4 (F24-F27) | 18 | 18 | 0 | 0 | 0 |
| a5 (F28-F31, modifiers) | 39 | 32 | 4 | 3 | 0 |
| a6 (F32-F38) | 40 | 37 | 1 | 2 | 0 |
| (b) | 7 | 6 | 0 | 0 | 1 |
| (c) | 39 | 34 | 2 | 3 | 0 |
| (d) | 52 | 50 | 1 | 1 | 0 |
| (e) | 19 | 19 | 0 | 0 | 0 |
| (f) | 35 | 33 | 0 | 1 | 1 |
| Total | 351 | 327 | 12 | 10 | 2 |

**Corrections (before -> after).**

| # | Where | Before -> After | Verdict | Evidence |
|---|---|---|---|---|
| 1 | header | no default-vs-asset convention -> "Numbers in parentheses are code defaults unless marked asset ..." | note | `balance_sheet.json`, `levels/*.json` |
| 2 | F4 | "Default radius 10." -> plus hero asset 7.0 | supported + annotation | `levels/*.json` `heroes[0].interaction.coinMagnetRadius` = 7.0 in 36 of 36 levels with a hero |
| 3 | F13 | `CompletelyFilled = filled >= amount` -> `currentlyFilledCoins >= currentAmount` | PARTIAL (names) | CostDisplay.cs:65 |
| 4 | F16 | "Root = end of the chain (castle)" -> a slot without `activatorBuilding` is its own root and, with difference >= 0, only its first build passes | PARTIAL | BuildSlot.cs:286-293,651-663; `levels/*.json` `buildSlots[].activator` null on 56 slots |
| 5 | F23 | "only the next upgrade's non-zero cost(s)" -> save writes the cost(s); load restores gold cost only if non-zero, core cost only alongside it (DLC) | PARTIAL | BuildSlot.cs:415-431,450-457 |
| 6 | F29 | "skipped by perk `neverDenyHarvest`" -> skipped when `neverDenyHarvest` is set by `PerkRemoveDestroyedAtNightTag` | PARTIAL (name) | PerkRemoveDestroyedAtNightTag.cs:11-16; BuildingInteractor.cs:62,155-158 |
| 7 | FishingHarbour row | `Upgrades[1].branch[0].goldIncomeChange` -> `Upgrades[1].upgradeBranches[0].goldIncomeChange` | PARTIAL (name) | FishingHarbour.cs:63 |
| 8 | FishingHarbour row | formula with (1) and (5) only -> plus `MarkAsHarvested()` after the increase and `FishingHarbourUpgrade` doubling `maximumIncome` and `incomeIncreasePerTurn` | PARTIAL (missing) | FishingHarbour.cs:64; FishingHarbourUpgrade.cs:10-11 |
| 9 | MineShaft row | "(3 with SustainableMining)" -> floor code 3, asset 1 | WRONG | `balance_sheet.json` `MineShaft.MineShaft.minimumIncomeWithSustainableMining` = 1 |
| 10 | MineShaft row | "resets to 6" -> code 6, asset 7 | WRONG | `balance_sheet.json` `MineShaft.MineShaft.resetIncomeSustainableMining` = 7; `localization_en.csv` `Equippable/Indestructible Mines Description` |
| 11 | Shrine row | "`maxXp`(1000)" -> code 1000, asset 350; `collectionRange` code 10, asset 20 | WRONG | `levels/*.json` `shrines[].maxXp` = 350.0 and `.collectionRange` = 20.0 on 121 of 121 shrines |
| 12 | UpgradeCastleUp row | "(defaults)" -> code defaults, asset discounts 1 (Level 1) and 4 (Level 2) | supported + annotation | `balance_sheet.json` `CastleCenterVariant.CastleUp.UpgradeCastleUp.immediateWallAndTowerDiscount2/3` |
| 13 | F33 | "Dawn begins with `ReviveAll...`" -> `DawnCallAfterSunrise` (after `sunriseTime`) begins with it | PARTIAL (timing) | DayNightCycle.cs:141-146,279-291 |
| 14 | F33 | `destructionGodHealthRegen` -> code 0.33, asset 0.25 | supported + annotation | `balance_sheet.json` `PerkManager.PerkManager.destructionGodHealthRegen` = 25% |
| 15 | F35 | `.../trainingSpeed` -> `.../totalTrainingSpeed`; asset respawn seconds added | WRONG (identifier) | UnitRespawnerForBuildings.cs:33,67,96,103; `levels/*.json` `buildSlots[].unitProducer.respawnSecondsByLevel` |
| 16 | F35 | "Temple Sacrifice triples speed" -> multiplies `unitRespawnSpeedMulti` (code x3, asset x3.5/x3.75/x4.0) and kills all player units at dusk | WRONG | TempleSacrifice.cs:7,9-16; `balance_sheet.json` `Temple.Sacrifice0..2.TempleSacrifice.unitRespawnSpeedMulti` = +250%/+275%/+300% |
| 17 | (c) Start gold | "(default 10)", "(default 1)" -> code default 10, asset 0-35 per level; Loan asset 7; Royal Mint bonus code 1, asset 0 | supported + annotation | `levels/*.json` `spawners[0].goldBalanceAtStart`; `balance_sheet.json` `PerkManager.PerkManager.*` |
| 18 | (c) Building income | "2.5 s (`sunriseTime`)" -> asset 3.0 s (code default 2.5) | WRONG | `levels/*.json` `dayNight[0].sunriseTime` = 3.0 in 37 of 37 levels |
| 19 | (c) Enemy gold | Loan `loanInterestMoney` -> plus asset 10 | annotation | `balance_sheet.json` |
| 20 | (c) Treasure Hunter | "+10/+20/+30 (defaults)" -> code defaults, asset 15/25/40 | supported + annotation | `balance_sheet.json` `treasureHunterGoldAmountWave1..3` |
| 21 | (c) Other sinks | When = "day" -> path toggle per `toogleOnlyAtDay`/`toggleOnlyAtNight` (default any time), power-up day only | PARTIAL | CutOpenPathInteractor.cs:27-33,184-191; ScheduledActivationInteractor.cs:45-60 |
| 22 | (c) Empire | `goldToDoublePower(1000)` -> code 1000, asset 1500 | WRONG | `balance_sheet.json` `CastleCenterVariant.Empire*.EmpireUpgrade.goldToDoublePower` = 1500 (4 of 4) |
| 23 | (c) Empire | cite EmpireUpgrade.cs:10 -> EmpireUpgrade.cs:7 | WRONG (cite) | line 10 is the attribute of `towerDamageMultiplyer`; `goldToDoublePower` is line 7 |
| 24 | d2 step 4 | "`OnUpgrade` ... triggers wall/tower discounts" -> `OnUpgradeEarly` triggers discounts, then `OnUpgrade` activates children and paired tunnels | PARTIAL | BuildSlot.cs:840-841; CaslteUpReciever.cs:10; Tunnel.cs:53 |
| 25 | d3 Dawn 2 | "after `sunriseTime` (2.5)" -> asset 3.0, code default 2.5 | WRONG | same as #18 |
| 26 | Deadlocks | "`nightCallTime`=1 s" -> asset 2.0 s in 37 of 37 levels, code default 1 s | WRONG | `levels/*.json` `nightCall[0].nightCallTime` = 2.0; NightCall.cs:11,73-76 |
| 27 | F16 | "Default -100 = unrestricted" -> plus asset values 0 / 1 / -100 counts | supported + annotation | `levels/*.json` `buildSlots[].requiredRootLevelDifference` (2,419 slots) |
| 28 | (a5) modifier table, (c) Building income | "runtime modifiers (a5)" was incomplete -> new `TemplePrayers` row (zeroes Shrine `GoldIncome`, marks Shrines knocked out) | PARTIAL (omission) | TemplePrayers.cs:12-53; `localization_en.csv` `Building/Temple Choice Prayers 0 Description` ("Activated shrines don't grant any gold"); grep of every `GoldIncome` writer |
| 29 | F29 | "set on Hp knock-out" -> also set by `MarkDestroyedBuildingsAsDontRevive` (DestructionGod) and by `TemplePrayers` | PARTIAL (omission) | Hp.cs:483; TemplePrayers.cs:34-43 |
| 30 | F10 | "Free upgrades call it or `ExecuteBuildOrUpgrade`" -> third path `ForceManualUpgradeWithoutFeedbackEffects` | PARTIAL (omission) | AutoUpgradeBuildingOnStart.cs:19-27; BuildSlot.cs:845-888 |

Also edited without a verdict change: the (e) intro note (lists the asset overrides), (b)6 (answered inline), and the Deadlocks phrase "cores only come from harvests" -> "code spawns cores only in harvests ...; asset-assigned drop prefabs unchecked" (that claim is one of the 2 CANNOT-VERIFY).

**Asset values that differ from the code defaults quoted in the doc.**

| Parameter | Code default | Asset value | Evidence |
|---|---|---|---|
| `DayNightCycle.sunriseTime` | 2.5 s | 3.0 s | `levels/*.json` `dayNight[0].sunriseTime`, 37 of 37 |
| `NightCall.nightCallTime` | 1 s | 2.0 s | `levels/*.json` `nightCall[0].nightCallTime`, 37 of 37 |
| `PlayerInteraction.coinMagnetRadius` | 10 | 7.0 | `levels/*.json` `heroes[0].interaction.coinMagnetRadius`, 36 of 36 with a hero (`interactionRadius` 3.0 = default) |
| `EnemySpawner.goldBalanceAtStart` | 10 | Classic levels 0-35 (Neuland 0, Nordfels 8, Durststein 16, Frostsee 7, Uferwind 18, Sturmklamm 11); the EternalTrial level shows 400 but the generator overwrites it | `levels/*.json` `spawners[0].goldBalanceAtStart` |
| `Shrine.maxXp` / `collectionRange` | 1000 / 10 | 350 / 20 (`incomeOnceUnlocked` 2 and `strengthBonusOnAdditionalShrine` 1.2 unchanged) | `levels/*.json` `shrines[]`, 121 of 121; `balance_sheet.json` `Shrine.BuildingParent.Shrine.*` |
| `MineShaft.minimumIncomeWithSustainableMining` / `resetIncomeSustainableMining` | 3 / 6 | 1 / 7 | `balance_sheet.json` `MineShaft.MineShaft.*` |
| `UpgradeCastleUp.immediateWallAndTowerDiscount2` / `3` | 2 / 4 | 1 / 4 | `balance_sheet.json` `CastleCenterVariant.CastleUp.UpgradeCastleUp.*` |
| `EmpireUpgrade.goldToDoublePower` | 1000 | 1500 | `balance_sheet.json` `CastleCenterVariant.Empire{Towers,Troops,Armor,Growth}.EmpireUpgrade.goldToDoublePower` |
| `PerkManager.royalMint_startGoldBonus` | 1 | 0 (the perk text says the castle makes 1, 2 or 3 extra gold per day; `CastleCenterVariant.PerkIncomeModifyer.upgradeIncomeChange` = 1, 1, 1) | `balance_sheet.json`; `localization_en.csv` `Equippable/Royal Mint Description` |
| `PerkManager.treasureHunterGoldAmountWave1..3` | 10 / 20 / 30 | 15 / 25 / 40 | `balance_sheet.json` |
| `PerkManager.loanBonusMoney` / `loanInterestMoney` / `healingGoldHealAmount` | no default | 7 / 10 / 100 | `balance_sheet.json` |
| `PerkManager.destructionGodHealthRegen` | 0.33 | 0.25 | `balance_sheet.json` |
| `TempleSacrifice.unitRespawnSpeedMulti` | x3 | x3.5 / x3.75 / x4.0 (Sacrifice0/1/2, shown as +250/+275/+300%) | `balance_sheet.json` (percent conversion checked on known pairs: 1.3 -> +30%, 0.5 -> -50%) |
| `TempleWisdom.goldForDestroyedBuilding` / `healthPercentageLossPerSec` | no default | 1 / 2 / 3 per tier / 0.5% per s | `balance_sheet.json` |
| `BlacksmithUpgrade.researchTime` / `multiplyer` | 2 / 1.2 | MeleeAttack 3 / 1.25, RangedAttack 3 / 1.2, MeleeResistance 2 / 1.3, RangedResistance 2 / 1.3 | `balance_sheet.json` `Blacksmith.*` |
| `RoyalForgeUpgrade.researchTime` / `multiplyer` | 2 / 1.2 | AutoAttackSpeed 2 / 0.6, AdditionalHealth 2 / 1.6, CooldownReduction 2 / 0.6, OverallDamage 3 / 1.5 | `balance_sheet.json` `RoyalForge.*` |
| `UnitRespawnerForBuildings.timeToRespawnAUnitDependingOnLevel` | per asset | Barracks and Archery Range 15/10/6/6 s, Hero's Quarter 60 s at every level | `levels/*.json` `buildSlots[].unitProducer.respawnSecondsByLevel` |
| `BuildSlot.requiredRootLevelDifference` / `startDeactivated` | -100 / true | 0 on 1,475 slots, 1 on 504, -100 on 440 / false on 83 (37 Castle Centers, 18 Great Wall Houses, 28 Walls) | `levels/*.json` `buildSlots[].requiredRootLevelDifference`, `.startDeactivated` |
| Unchanged (asset = default) | | `InterestPerk` 3 / 20, `ratGod_GoldModifyer` 0.5, `interactionRadius` 3 | `balance_sheet.json`, `levels/*.json` |

**Answers to open questions from asset data.**
1. **(b)6, gold and core cost both > 0.** `upgrades.csv`, columns `cost` and `coreCost`: 13,610 rows over 37 scenes; rows with `cost`>0 and `coreCost`>0: 0; rows with `coreCost`>0: 0; rows with `cost`==0: 0. `coreIncome` is 0 in every row, `build_slots.csv` `totalCoreCost` is 0 in all 2,419 slots, and `levels/*.json` `buildSlots[].levels[].coreCost` / `.branches[].coreIncome` are 0 in all 6,653 level entries. No extracted upgrade can hit the F12 deadlock. Caveat: `level_infos.json` lists 8 Craaghelm DLC levels (`Craaghelm_map01`..`08`) whose scenes are absent from `levels/` (04..40 only), so DLC core costs are unknown.
2. **Which slots are followers.** `levels/*.json` `buildSlots[].activator.upgradesThis == true`: 325 of 2,419 slots in 29 scenes, all `Wall` (304) or `Barricades` (21); the activator of each follower is itself a Wall/Barricades gate slot, whose own activator is the Castle Center for 319 followers and a Defense Tower (slot 21084) for the 6 followers in `Nordfels Bow Micro`. Nordfels (`levels/05_Nordfels.json`): 12 followers on 4 gates (52046: 6, 52039: 2, 52038: 2, 63056: 2); e.g. slot 49994 "Wall Segment Variant (08)" has `activator` {slot 52039 "Gate Variant (2)", level 0, `upgradesThis` true}, and that gate has `activator` {slot 55238 Castle Center, level 2, `upgradesThis` false}. Related graph data: `requiredRootLevelDifference` is 0 on 1,475 slots, 1 on 504 (all Wall/Barricades) and -100 on 440 (all Field and Castle Center), so the code default -100 is the exception; `startDeactivated` is false on only 83 slots (37 Castle Centers, 18 Great Wall Houses, 28 Walls); 56 slots have no activator (37 Castle Centers, 18 Houses, 1 Blacksmith).
3. **Costs and income per level** (`levels/*.json` `buildSlots[].levels[]` `cost` and `branches[].goldIncome`, identical in `upgrades.csv`; asset values before runtime modifiers). Costs are constants per building type and level, not formulas of level or wave: every Defense Tower level (548 slots) is 3/5/15/40, every Mill (78) 3/4/6; only Walls and Barricades vary per slot. 1,501 of 6,653 level entries are `disabledInThisMode` and never purchasable (F16).

| Building (slots) | L1 cost / gold | L2 | L3 | L4 |
|---|---|---|---|---|
| Field (403) | 1 / +1 | | | |
| House (370) | 2 / +1 | 2 / +1 | 20 / +2 (disabled on 359) | |
| Mill (78) | 3 / +1 | 4 / +1 | 6 / +4 | |
| Gold Mine (44) | 5 / +6 | | | |
| Bridge (12) | 2 / +1 | | | |
| Harbour (20) | 3 / 0 | 7 / 0 (+60 HP) | | (income is runtime, see 4) |
| Shrine (121) | 3 / 0 | | | (+2 at 350 XP, runtime) |
| Castle Center (37) | 3 | 7 | 20 | 100 (disabled on 35 of 36; "Empire Growth" branch +20 gold) |
| Defense Tower (548) | 3 | 5 | 15 | 40 (disabled on 515 of 543; one branch +3 gold) |
| Wall (462) | 2-15 | 2-20 | 50 (disabled on 442) | |
| Barracks (51), Archery Range (54) | 4 | 8 | 16 | 50 (disabled on 49 and 52) |
| Hero's Quarter (52) | 6 | 10 | 20 | 50 (disabled on 49) |
| Blacksmith (19), Royal Forge (18), Temple (18) | 4 / 4 / 2 | 9 / 7 / 6 | 16 / 14 / 25 | |
| Summoning Circle (70), Barricades (42) | 1 / 4-7 | 2 / - | | |

4. **(b)4, Harbour.** `upgrades.csv` rows for `Harbour` (20 slots in 12 scenes, e.g. Frostsee slots 48952 and 48958): L1 cost 3, `goldIncome` 0; L2 cost 7, `goldIncome` 0, `hpChange` 60, `activates` "Level 2". The asset delta of upgrade 2 is 0, so an income step at that purchase can only come from the runtime write in FishingHarbour.cs:63, consistent with (b)4. Extra data: `balance_sheet.json` `FishingHarbour.PerkIncomeModifyer.upgradeIncomeChange` = 1, 1; `PerkCostModifyer.upgradeCostChange` = 0, 3; `PerkHpModifyer.hpMultiplyer` = +100%. Confidence stays Medium (the doubling itself is not visible in static data).
5. **(b)5, EconomySimulator.** `levels/*.json` `spawners[0].mode`: 36 Classic, 1 EternalTrial (`11_Nordfels_Siege`). `waveGenerator` is "Season2 Wave Gen" (SeasonTwoWaveGen, which calls EconomySimulator) on all 37 spawners, but Classic spawners carry hand-authored `waves` (Nordfels `waveCount` 13). The single endless-mode spawner (`35_Totend_MM1`, `endlessMode` true) uses "Endless Mode Wave Gen" (EndlessModeWaveGen, no EconomySimulator call). Supports (b)5.
6. **(b)1, knocked out not destroyed.** `Hp.getsKnockedOutInsteadOfDying` is not extracted. Indirect support only: `localization_en.csv` `Equippable/Challenge the God of Destruction Description` ("Destroyed buildings take an additional day to get repaired"), `Equippable/Resilient Residences Description` ("fully repaired before the first daylight"), `Map Description/Frostsee The Great Wall` ("Buildings don't fully repair in the morning").
7. **Auto day/night (the "no auto day" condition in Deadlocks).** `levels/*.json` `autoDayNight[]` is non-empty only in `14_Durststein_Speedrun` (`autoDayLength` true, `dayLength` 20 s), `29_Freifort_MM1` (`autoNightLength` true, 240 s) and `40_Wildbach_MM3` (`autoNightLength` true, 120 s).

**Still unverifiable.**
- (b)2: whether enemy-drop coin prefabs set `registerInTagManager` (only `Hp.coinCount` defaults are extracted: `enemy_prefabs.json` `coinDrop` = 0 for all 54 unit prefabs). (b)3 (mid-hold reset) is a runtime property.
- Values with no `[BalancingParameter]` and no scene entry, so the doc's code defaults cannot be checked against assets: Coin `maxSpeed`/`accelerationTime`/`spawnAnimationDuration`, `CoinSpawner.interval`, FishingHarbour `incomeIncreasePerTurn`/`maximumIncome`/`additionalBoatCapacity`, MineShaft `incomeReductionPerTurn`/`minimumIncome`, ThiefController `_theftAmount`/`_bonus`/`_holdDuration`, CutOpenPathInteractor `toggleCost` and its day/night flags, ScheduledActivationInteractor `powerUpCost`/`daysToPowerUp`, ScoreManager `victoryGoldBonusMultiplyer`. The `(G-1)*0.5 s` coin-arrival estimate depends on `interval`.
- Core costs and incomes on Craaghelm DLC maps; whether asset-assigned drop prefabs (`Hp.coin`, `ThiefController._coinPrefab`) can be energy cores.
- Runtime overrides of `requiredRootLevelDifference` (`AllowUpgrade`, `PerkUnrestrictedUpgrading` components are not in the extracted JSON, which stores authored values), e.g. on the 18 self-rooted Great Wall Houses.

**Checked, no edit needed.**
- `GetWaveInfo(...).goldReward` (EnemySpawner.cs:653-656,742) skips spawns whose prefab has no `ScreenMarkerIcon` (subclass `ScreenMarkerIconArachnophobia` counts); the 9 prefabs without either all carry 0 gold in `waves_all.csv`, so `goldReward` equals `W` for every wave listed there (35 scenes; `Moorweg MM1` and `Durststein Gold Puzzle` have no rows).
- F8: three core paths are not map-gated (TreasuryUI.cs:174 and DayNightCycle.cs:177-187 test DLC availability only; ScheduledActivationInteractor.cs:141-146 tests nothing); irrelevant outside DLC maps, so F8 stands.
- (b)3: further `UpdateInteractionState` callers exist (Focus, Unfocus, Harvest, BuildSlot.cs:831,870 root refresh, Temple/RoyalForge busy paths); none reaches a focussed hero mid-hold in normal play, so the conclusion stands.
- `UpgradeBuildersGuild.UpgradeAHouse` sorts houses by distance but indexes the unsorted list (UpgradeBuildersGuild.cs:70-73), so "nearest first" is not in effect; F30 does not claim an order.
- `Spawn.Reset(_resetGold: false)` (used by `InfinitelySpawning`, EnemySpawner.cs:407) leaves every enemy with 0 gold (Spawn.cs:90-102).
- `NextUpgradeOrBuildCost` == 100 is ambiguous (F17): the enabled castle level 4 in `Totend MM1` really costs 100; always test `CanBeUpgraded`.
- F20's component destroys itself even when the perk is absent (ReduceChildrensBuildRequirementIfPerk.cs:21).
- Completeness greps over `decompiled/`: `AddCoin`/`SpendCoins` outside PlayerInteraction occur only at Coin.cs:114, EnemySpawner.cs:365,439, InterestPerk.cs:49, BuildingInteractor.cs:219, CutOpenPathInteractor.cs:99, ThiefController.cs:114 (all covered by (c)); `SpendEnergyCores` only at BuildingInteractor.cs:226 and ScheduledActivationInteractor.cs:145; `CancelChoice` callers are exactly the three in F27; `IncomeModifyer` subclasses are exactly the three in a5; every `GoldIncome`/`goldIncomeChange` writer is now covered by a5 (after adding `TemplePrayers`).
- `RubblesInteractionHelper` also sets `buildingIsCurrentlyBusyAndCantBeUpgraded` (busy until the next dawn after one purchase, RubblesInteractionHelper.cs:46-71); no rubble slots exist in the extracted levels, so F36 and the "State None by day" row stay as written (they are not exhaustive).
