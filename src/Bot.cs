using System.Globalization;
using System.IO;
using BepInEx;
using UnityEngine;

namespace ThronefallTrainer
{
    internal enum BotMode { Idle, CollectCoin, ReturnHome, HoldCastle, Engage, EnterLevel, StartNight, SpendGold, ResolveUI, PositionArmy }

    /// <summary>
    /// Tier-1 autopilot. Plugin.Update() calls <see cref="Tick"/> every frame;
    /// decisions run at 4 Hz while <see cref="DesiredDir"/> (world-space unit
    /// vector) is refreshed per frame so moving targets are tracked smoothly.
    /// The Harmony prefix in BotPatches.cs converts DesiredDir into the
    /// camera-relative input vector that MoveScript expects.
    /// </summary>
    internal static class Bot
    {
        public static bool Enabled { get; private set; }

        /// <summary>
        /// Legit play: no survival bundle applied AND the bot refuses
        /// cheat-adjacent mechanics of its own — no teleport nudges (sidestep
        /// unstick instead), no direct-damage fallback, no direct Attack()
        /// calls that bypass weapon cooldown. Driven by Plugin from
        /// cfgBotCheats: bundle OFF = legit.
        /// </summary>
        public static bool Legit;

        /// <summary>World-space run direction for this frame (zero = stand still).</summary>
        public static Vector3 DesiredDir { get; private set; }

        public static BotMode Mode { get; private set; } = BotMode.Idle;
        public static string Status { get; private set; } = "off (F6)";
        public static int StuckStrikes { get; private set; }

        // ---- steering knobs ----
        private const float ArriveCoin   = 0.8f;
        private const float ArriveHold   = 6f;
        // Park basically on top of the target — 4 m left the hero outside
        // melee/swing range, so it stood in a mob never attacking.
        private const float ArriveEngage = 1.5f;
        private const float HomeRadius   = 14f;   // drift back to castle past this
        private const float CoinSeekRange = 80f;

        // ---- cadence / watchdog ----
        private const float DecisionInterval = 0.25f;
        private const float StuckWatchWindow = 2f;
        private const float StuckEpsilon     = 0.35f; // moved less than this = stuck
        private const int    MaxStrikesBeforeTeleport = 3;
        private const float  TeleportNudge   = 2.5f;

        private static float decisionClock;
        private static float watchClock;
        private static Vector3 watchAnchor;
        private static bool hasAnchor;

        private static bool hasTarget;
        private static Vector3 targetPos;
        private static float arriveDist = 1f;
        // Live pursuit: Engage stores the enemy itself so each frame steers at
        // its current position — a stale position snapshot made the hero stand
        // still next to foes that had already walked off.
        private static TaggedObject engageTarget;

        // Attack pump: the hero only swings when ManualAttack.inputBuffer is
        // armed by a press (TryToAttack). Auto-attack is marker-gated and the
        // interact path is blocked while the trainer menu freezes the player,
        // so the bot buffers presses itself while engaged.
        private static ManualAttack heroAttack;
        private static float attackDiagAt;

        /// <summary>World pos the bot steers toward — live enemy transform when engaging.</summary>
        private static Vector3 AimPos =>
            (Legit && Time.unscaledTime < detourUntil)
                ? detourPos
                : (Mode == BotMode.Engage && engageTarget != null && !Legit)
                    ? engageTarget.transform.position
                    : targetPos;

        // level-select entry: interact throttle
        private static float levelInteractAt;
        // title-screen advance: throttle while the level-select scene loads
        private static float menuAdvanceAt;
        // nighthorn: interact throttle (harvest, then start-night)
        private static float hornInteractAt;
        // SwitchToNight fallback: single-shot window so repeated calls can't
        // stack multiple wave spawns before IsNight flips; 15 s covers the
        // transition and still retries if a start silently fails.
        private static float nightRequestAt;
        private static bool lastNightState;

        // Blocking UI frames (level-up reward, perk select, upgrade choice,
        // end-of-match, pause) freeze the player — resolved before the FSM.
        private static float frameActionAt;
        private static string uiFrame = "";
        private static string lastUiNoteFrame = "";
        private static float nextUiNoteAt;
        // Day economy: building slot the bot currently holds interaction on.
        private static BuildingInteractor heldBuild;
        private static float buildInteractAt;
        private static float nextHoldNoteAt;
        // Spend-stall watch: if the held slot produced no payment for 7 s the
        // interactor is dead for now (deny-loop on an unaffordable upgrade,
        // stuck harvest/choice state) — park it for the day and move on.
        private static float spendWatchAt;
        private static int spendWatchGold = -1;
        private static int spendWatchCores = -1;
        // ManualAttack scene scan: FindObjectsOfType at 4 Hz is wasteful — 1 s.
        private static float maScanAt;
        // Watchdog: aim distance last window — still closing = healthy pursuit.
        private static float lastWatchDist = float.MaxValue;
        // Diag taper: log on change or every 15 s instead of every 5 s.
        private static string lastDiagKey;
        // Legit unstick: instead of teleporting, steer to a perpendicular
        // detour point briefly — the wall-slide a player would do.
        private static float detourUntil;
        private static Vector3 detourPos;
        private static int detourSide = 1;
        private static int detourCount;

        // Legit nav steering: follow the game's own A* navmesh to the goal
        // instead of a straight line. Straight-line steering wedges on any
        // obstacle (map props, building colliders, water); a sidestep detour
        // can't route around them — this can. Path requests run at ~1 Hz
        // (same cadence as PathfindMovementPlayerunit.recalculatePathInterval)
        // and only while the target changed or the path ran out.
        private static Pathfinding.Path navPath;
        private static int navIndex;
        private static Vector3 navGoal;
        private static float navRepathAt;
        private static bool navInFlight;
        private static float navSteerArrive = 0.5f;
        private static int navDiagCount;
        private static float nextMoveDiagAt;

        // Legit combat state.
        private static float weaponRange;          // hero weapon's max priority range
        private static bool weaponFiresWhileMoving = true;
        private static int armyPhase;              // 0 none, 1 walking to anchor, 2 placed today
        private static float armyWalkAt;           // failsafe: place wherever we are after this

        // Session memory: which scenes we've played and how often we lost
        // each, so a too-hard node rotates out instead of looping forever.
        private static readonly System.Collections.Generic.Dictionary<string, int> sessionDefeats =
            new System.Collections.Generic.Dictionary<string, int>();
        private static readonly System.Collections.Generic.HashSet<string> playedThisSession =
            new System.Collections.Generic.HashSet<string>();
        private static string lastMatchScene;
        private static string lastGameState = "";
        // Frame tracking: how many times the same blocking frame survived a
        // close — a stubborn one with a back-to-map button gets followed.
        private static string lastFrameName = "";
        private static int frameSeen;

        private static StreamWriter botLog;
        private static bool logFailed;

        // Campaign-map node scorer: unbeaten-first, then prefer nodes not yet
        // toured this session, then penalise scenes we've repeatedly lost
        // (each defeat −45, so 3 losses drops any node below everything else).
        static Bot()
        {
            BotPerception.LevelScore = (li, beaten) =>
            {
                string scene = li.levelInfo != null ? li.levelInfo.sceneName : null;
                int defeats = scene != null && sessionDefeats.TryGetValue(scene, out int d) ? d : 0;
                float sc = beaten ? 0f : 100f;
                if (scene == null || !playedThisSession.Contains(scene)) sc += 15f;
                return sc - defeats * 45f;
            };
        }

        /// <summary>F6 / overlay entry point. Persists via cfgBotEnabled in Plugin.</summary>
        public static void SetEnabled(bool v)
        {
            if (v == Enabled) return;
            Enabled = v;
            DesiredDir = Vector3.zero;
            ClearTarget();
            Mode = BotMode.Idle;
            Status = v ? "starting" : "off (F6)";
            hasAnchor = false;
            StuckStrikes = 0;
            decisionClock = 0f;
            nightRequestAt = 0f;
            lastNightState = false;
            armyPhase = 0;
            detourUntil = 0f;
            detourCount = 0;
            weaponRange = 0f;
            heroAttack = null;
            navPath = null;
            navIndex = 0;
            navInFlight = false;
            navGoal = Vector3.zero;
            Plugin.Log?.LogInfo($"[bot] autopilot {(v ? "ENABLED" : "disabled")} (F6)");
            LogRaw(v ? "enabled" : "disabled");
            if (!v) CloseLog();
        }

        public static void Shutdown() => SetEnabled(false);

        /// <summary>Per-frame driver, called from Plugin.Update().</summary>
        public static void Tick()
        {
            if (!Enabled) return;

            // Re-steer every frame so moving targets (coins/arrows/enemies) are tracked.
            var pm = PlayerMovement.instance;
            if (hasTarget && pm != null)
            {
                if (Legit)
                    DesiredDir = DirTo(pm.transform.position, NavSteerPoint(pm.transform.position, AimPos), navSteerArrive);
                else
                    DesiredDir = DirTo(pm.transform.position, AimPos, arriveDist);
            }
            else
                DesiredDir = Vector3.zero;

            decisionClock += Time.unscaledDeltaTime;
            if (decisionClock < DecisionInterval) return;
            decisionClock = 0f;
            TickInner();
        }

        private static void TickInner()
        {
            var s = BotPerception.Capture();

            // Session memory edges: a victory clears the level's defeat count
            // and marks it toured; a defeat counts toward rotating the node
            // out of the unbeaten pool (LevelScore penalises it).
            if (s.GameState != lastGameState)
            {
                if (s.GameState == "AfterMatchVictory" && lastMatchScene != null)
                {
                    playedThisSession.Add(lastMatchScene);
                    sessionDefeats.Remove(lastMatchScene);
                }
                else if (s.GameState == "AfterMatchDefeat" && lastMatchScene != null)
                {
                    sessionDefeats[lastMatchScene] =
                        sessionDefeats.TryGetValue(lastMatchScene, out int d) ? d + 1 : 1;
                    Plugin.Log?.LogInfo($"[bot] defeat on '{lastMatchScene}' (x{sessionDefeats[lastMatchScene]} this session)");
                    LogLine(in s, "defeat");
                }
                lastGameState = s.GameState;
            }
            if (s.Valid && !s.SceneName.StartsWith("_")) lastMatchScene = s.SceneName;

            if (!s.Valid)
            {
                Mode = BotMode.Idle;
                ClearTarget();
                Status = "waiting (" + s.GameState + ")";
                LogLine(in s, "invalid");
                // Title screen: the Play button routes through
                // TitleScreenUIHelper.ClickPlay -> SceneTransitionManager.
                // TransitionFromNullToLevelSelect — call it ourselves so the
                // bot never waits for a manual click (throttled while the
                // level-select scene loads).
                if (s.SceneName == "_StartMenu" &&
                    SceneTransitionManager.instance != null &&
                    Time.unscaledTime >= menuAdvanceAt)
                {
                    menuAdvanceAt = Time.unscaledTime + 8f;
                    Plugin.Log?.LogInfo("[bot] start menu -> TransitionFromNullToLevelSelect()");
                    SceneTransitionManager.instance.TransitionFromNullToLevelSelect();
                }
                // A blocking frame can outlive the match state (end-of-match
                // shows before/while the scene flips) — resolve it here too.
                HandleBlockingFrame(in s);
                return;
            }

            // Any frame that freezes the player (level-up reward, perk/upgrade
            // pick, victory or defeat screen, pause) blocks all in-world
            // interaction — resolve it before the FSM picks a mode. Non-freezing
            // frames like the level-select map UI are deliberately untouched.
            if (HandleBlockingFrame(in s))
            {
                Mode = BotMode.ResolveUI;
                ClearTarget();
                Status = "ui: " + uiFrame;
                if (uiFrame != lastUiNoteFrame || Time.unscaledTime >= nextUiNoteAt)
                {
                    lastUiNoteFrame = uiFrame;
                    nextUiNoteAt = Time.unscaledTime + 5f;
                    LogLine(in s, "ui");
                }
                return;
            }

            Decide(in s);
            RunWatchdog(in s);
            Status = FormatStatus(in s);
            LogLine(in s, "tick");

            // Movement diag while the watchdog is grinding: is the input even
            // reaching the character, and is something freezing it?
            if (StuckStrikes > 0 && Time.unscaledTime >= nextMoveDiagAt)
            {
                nextMoveDiagAt = Time.unscaledTime + 2f;
                var pmD = PlayerMovement.instance;
                int wpCount = navPath?.vectorPath != null ? navPath.vectorPath.Count : -1;
                string wpInfo = wpCount > 0 ? string.Join(";", navPath.vectorPath) : "-";
                Plugin.Log?.LogWarning($"[bot] move-diag: hasTgt={hasTarget} desired={DesiredDir} " +
                    $"vel={(pmD != null ? pmD.Velocity.ToString() : "null")} " +
                    $"frozen={LocalGamestate.Instance != null && LocalGamestate.Instance.PlayerFrozen} " +
                    $"mode={Mode} aim={AimPos} hero={(pmD != null ? pmD.transform.position.ToString() : "null")} " +
                    $"navIdx={navIndex} wpCount={wpCount} inFlight={navInFlight} navGoal={navGoal} wp=[{wpInfo}] steer={NavSteerPoint(pmD.transform.position, AimPos)}");
            }
        }

        /// <summary>Score-free FSM: pick the mode + a world-space move target.</summary>
        private static void Decide(in BotPerception.Snapshot s)
        {
            // Release a building hold that outlived its moment — mode switched,
            // target retargeted, or hero nudged out of range. InteractionEnd
            // cancels the partial fill and refunds the coins (CancelFill).
            if (heldBuild != null && (Mode != BotMode.SpendGold ||
                s.NearestBuild != heldBuild ||
                FlatDist(s.HeroPos, heldBuild.transform.position) > 4f))
                ReleaseBuild();

            // Day/night flip → re-arm the single-shot night request so a fresh
            // day can trigger the next night, and re-arm army positioning.
            if (lastNightState != s.IsNight)
            {
                nightRequestAt = 0f;
                lastNightState = s.IsNight;
                if (!s.IsNight) armyPhase = 0;
            }

            // Campaign map is itself an InMatch scene: walk to the nearest
            // playable level node, fire its interactor (sets lastActiveLevelInfo
            // and opens the select frame), then jump straight into the level via
            // SceneTransitionManager — bypasses PlayButtonPressed, whose manager
            // singleton is null on some map variants (Craaghelm/Fangmore).
            if (s.NearestLevel != null)
            {
                Mode = BotMode.EnterLevel;
                // Aim a couple metres in front of the node collider rather
                // than at its transform — same stand-off trick as buildings.
                SetTarget(StandOff(s.NearestLevelPos, s.HeroPos, 2.5f), 1.5f);
                // InteractionBegin + TransitionFromLevelSelectToLevel are
                // direct calls with no internal range gate — nodes' teleport
                // spots can sit inside collider rings the navmesh can't reach,
                // so fire from whatever distance the hero manages (map travel
                // is cosmetic anyway, players click nodes from anywhere).
                if (s.NearestLevelDist <= 9f && Time.unscaledTime >= levelInteractAt)
                {
                    var li = s.NearestLevel;
                    var stm = SceneTransitionManager.instance;
                    // Skip InteractionBegin: it only opens the pre-level frame
                    // (which ResolveUI then wastes a close on) and sets
                    // lastActiveLevelInfo for the loadout UI we bypass anyway.
                    // The old double-fire came from TransitionToScene silently
                    // dropping calls while sceneTransitionIsRunning — gate on it.
                    if (stm != null && li.levelInfo != null && !SceneTransitionBusy(stm))
                    {
                        levelInteractAt = Time.unscaledTime + 2f;
                        LogLine(in s, "level-interact");
                        // Mirror LevelSelectManager.PlayButtonPressed: apply
                        // fixedLoadout when the level has one, and if the
                        // loadout was never seeded this session (the bot
                        // skips the loadout UI) arm the hero with the best
                        // unlocked weapon — otherwise he spawns weaponless
                        // and literally cannot fight.
                        var pmgr = PerkManager.instance;
                        if (pmgr != null)
                        {
                            if (li.levelInfo.fixedLoadout != null && li.levelInfo.fixedLoadout.Count > 0)
                            {
                                pmgr.CurrentlyEquipped.Clear();
                                pmgr.CurrentlyEquipped.AddRange(li.levelInfo.fixedLoadout);
                            }
                            if (pmgr.CurrentlyEquipped.Count == 0)
                            {
                                Equippable best = null;
                                foreach (var eq in pmgr.allEquippables)
                                {
                                    if (eq is EquippableWeapon && eq.IsUnlocked &&
                                        (best == null || eq.sortingValue > best.sortingValue))
                                        best = eq;
                                }
                                if (best != null)
                                {
                                    PerkManager.SetEquipped(best, true);
                                    Plugin.Log?.LogInfo($"[bot] loadout seeded: '{best.displayName}'");
                                }
                            }
                        }
                        Plugin.Log?.LogInfo($"[bot] transitioning to level '{li.levelInfo.sceneName}'");
                        LogLine(in s, "transition-level");
                        stm.TransitionFromLevelSelectToLevel(li.levelInfo.sceneName);
                    }
                }
                return;
            }

            // Knocked-out hero is a ghost: drift home regardless of phase.
            if (s.HeroDead)
            {
                Mode = s.HasCastle ? BotMode.ReturnHome : BotMode.Idle;
                if (s.HasCastle) SetTarget(s.CastlePos, ArriveHold); else ClearTarget();
                return;
            }

            if (s.IsNight)
            {
                // Defense priority: the enemy nearest the CASTLE is the run's
                // actual threat, not the one nearest the hero.
                var threat = s.CastleThreat != null ? s.CastleThreat : s.NearestEnemy;
                Vector3 axisDir = s.HasThreatAnchor
                    ? s.ThreatAnchor - s.CastlePos : Vector3.zero;
                axisDir.y = 0f;
                if (threat != null)
                {
                    // Legit retreat: badly hurt hero pulls back behind the
                    // castle and lets the army work. 0.5 not 0.33 — wave
                    // bursts kill from ~0.7 in about a second, so the exit
                    // has to start before the danger zone, not inside it.
                    if (Legit && s.HeroHpPct < 0.5f && s.HasCastle)
                    {
                        Mode = BotMode.ReturnHome;
                        engageTarget = threat;
                        // Stand next to the keep, not inside its collider.
                        SetTarget(StandOff(s.CastlePos, s.HeroPos, 3f), ArriveHold);
                        PumpAttack();
                        return;
                    }
                    Mode = BotMode.Engage;
                    engageTarget = threat;
                    Vector3 tp = threat.transform.position;
                    bool ranged = weaponRange >= 6f;
                    // Ranged hero parks DEEP inside the keep — on the far side
                    // of the castle from the threat axis. Every forward hold
                    // (anchor line, army flank) still put him where the swarm
                    // converges; once melee encircles him no kite escapes.
                    // Behind the keep he's a poor melee target yet the bow's
                    // reach still covers the wall line. Melee holds the line.
                    Vector3 anchor = s.CastlePos;
                    if (axisDir.sqrMagnitude > 0.01f)
                        anchor = ranged
                            ? s.CastlePos - axisDir.normalized * 4f
                            : s.CastlePos + axisDir.normalized * 9f;
                    if (ranged && s.HasCastle)
                    {
                        // Kite on the foe nearest the HERO, not the threat
                        // target — bursts swarm him at the anchor while the
                        // castle-threat is being fought elsewhere, and that's
                        // exactly how he died on waves 2 and 4. Bow fires
                        // while moving, so stepping back costs no damage.
                        float heroNear = s.NearestEnemy != null ? s.NearestEnemyDist : float.MaxValue;
                        float kiteR = weaponFiresWhileMoving
                            ? Mathf.Min(weaponRange * 0.5f, 10f) : 4f;
                        if (heroNear < 5f)
                        {
                            // Danger zone: a swarm at melee range always wins
                            // a stand-up fight. Fall back behind the keep —
                            // castle + away-from-foe, a 37 m bow still reaches
                            // the wall-line from inside the yard.
                            Vector3 awayFromFoe = s.CastlePos - s.NearestEnemyPos;
                            awayFromFoe.y = 0f;
                            SetTarget(s.CastlePos + awayFromFoe.normalized * 4f, 1.2f);
                        }
                        else if (heroNear < kiteR)
                        {
                            // Kite: step away from the closest foe, biased
                            // toward the keep so the run doesn't orbit out.
                            Vector3 away = s.HeroPos - s.NearestEnemyPos; away.y = 0f;
                            if (away.sqrMagnitude < 0.01f) away = s.HeroPos - tp;
                            Vector3 toCastle = s.CastlePos - s.HeroPos; toCastle.y = 0f;
                            Vector3 kiteDir = (away.normalized * 0.7f +
                                (toCastle.sqrMagnitude > 0.01f ? toCastle.normalized : Vector3.zero) * 0.3f).normalized;
                            SetTarget(s.HeroPos + kiteDir * 6f, 1.2f);
                        }
                        else
                        {
                            // Stand-off on the castle side of the threat at
                            // ~70% of weapon range — intercept it before the
                            // keep, not after.
                            float stand = Mathf.Clamp(weaponRange * 0.7f, 4f, 14f);
                            Vector3 toAnchor = anchor - tp; toAnchor.y = 0f;
                            SetTarget(tp + toAnchor.normalized * Mathf.Min(stand, toAnchor.magnitude), 1.2f);
                        }
                    }
                    else
                    {
                        // Melee/no weapon: hold at the army line with the
                        // troops — charging mobs loses legit runs.
                        SetTarget(axisDir.sqrMagnitude > 0.01f
                            ? s.CastlePos + axisDir.normalized * 9f : anchor, 2f);
                    }
                    PumpAttack();
                }
                else if (s.HasCastle)
                {
                    Mode = BotMode.HoldCastle;
                    SetTarget(axisDir.sqrMagnitude > 0.01f
                        ? s.CastlePos + axisDir.normalized * 4.5f : s.CastlePos, ArriveHold);
                }
                else { Mode = BotMode.Idle; ClearTarget(); }
                return;
            }

            // ---- day ----
            if (s.NearestCoin != null && s.NearestCoinDist <= CoinSeekRange)
            {
                Mode = BotMode.CollectCoin;
                SetTarget(s.NearestCoinPos, ArriveCoin);
                return;
            }

            // ---- day economy ----
            // Unspent coins buy buildings/upgrades: InteractionHold pumps one
            // coin per call through costDisplay.FillUp, and the instant-build
            // cheat makes every fill complete a whole slot — a short hold
            // erects or upgrades the building. Harvest-state slots pay out
            // income on InteractionBegin, worth the trip even at zero balance.
            if (s.NearestBuild != null && (s.Balance > 0 || s.NearestBuild.canBeHarvested))
            {
                Mode = BotMode.SpendGold;
                // Aim at a stand-off point on the hero's side of the slot, not
                // the transform center — that's inside the collider and is what
                // the hero used to rub walls against until the watchdog nudged.
                SetTarget(StandOff(s.NearestBuildPos, s.HeroPos, 1.6f), 1.0f);
                var nbName = s.NearestBuild.targetBuilding != null
                    ? s.NearestBuild.targetBuilding.buildingName : s.NearestBuild.name;
                DiagLog("nb:" + nbName + s.NearestBuildScore + s.NearestBuildPos,
                    $"[bot] spend target '{nbName}' score={s.NearestBuildScore} " +
                    $"at {s.NearestBuildPos} dist={s.NearestBuildDist:0.#} hero={s.HeroPos} bal={s.Balance}", false);
                if (s.NearestBuildDist <= 4f && Time.unscaledTime >= buildInteractAt)
                {
                    buildInteractAt = Time.unscaledTime + 0.4f;
                    var bi = s.NearestBuild;
                    if (heldBuild != bi)
                    {
                        ReleaseBuild();
                        bi.Focus(PlayerInteraction.instance);   // harvest pays out on focus
                        bi.InteractionBegin(PlayerInteraction.instance);
                        heldBuild = bi;
                        spendWatchGold = s.Balance;
                        spendWatchCores = s.CoreBalance;
                        spendWatchAt = Time.unscaledTime + 7f;
                        Plugin.Log?.LogInfo($"[bot] building '{bi.name}' -> hold-to-pay");
                    }
                    else if (s.Balance != spendWatchGold || s.CoreBalance != spendWatchCores)
                    {
                        // A payment landed — reset the stall clock.
                        spendWatchGold = s.Balance;
                        spendWatchCores = s.CoreBalance;
                        spendWatchAt = Time.unscaledTime + 7f;
                    }
                    else if (Time.unscaledTime >= spendWatchAt)
                    {
                        Plugin.Log?.LogInfo($"[bot] build '{bi.name}' no progress -> parked for the day");
                        LogLine(in s, "build-stall");
                        // Park till dusk (the ignore list clears on night).
                        // Dead slots drop out of the candidate pool for good
                        // today, so NearestBuild drains to null and the
                        // horn/SwitchToNight path below finally runs.
                        BotPerception.IgnoreBuild(bi, 600f);
                        ReleaseBuild();
                        return;
                    }
                    bi.InteractionHold(PlayerInteraction.instance);
                    if (Time.unscaledTime >= nextHoldNoteAt)
                    {
                        nextHoldNoteAt = Time.unscaledTime + 3f;
                        LogLine(in s, "build-hold");
                    }
                }
                return;
            }

            // ---- army placement (legit) ----
            // Economy done: park the troops at the defensive anchor through the
            // game's own command path (select-all → place at hero → hold) —
            // the exact sequence a player does before blowing the horn.
            if (Legit && armyPhase < 2 && s.AllyCount > 0 && s.HasCastle &&
                CommandUnits.instance != null)
            {
                if (armyPhase == 0)
                {
                    var cu = CommandUnits.instance;
                    int added = 0;
                    foreach (var u in TagManager.instance.PlayerUnits)
                    {
                        if (u == null || u.Hp == null || !u.Hp.Alive) continue;
                        cu.OnUnitAdd(u, false); added++;
                    }
                    cu.commanding = added > 0;
                    armyPhase = 1;
                    armyWalkAt = Time.unscaledTime + 8f;
                    Plugin.Log?.LogInfo($"[bot] commanding {added} allied unit(s) to anchor");
                }
                Mode = BotMode.PositionArmy;
                // Army line sits at castle+11 — troops meet the wave BEFORE
                // it reaches the keep; the ranged hero holds behind at +4.5.
                Vector3 aAxis = s.HasThreatAnchor ? s.ThreatAnchor - s.CastlePos : Vector3.zero;
                aAxis.y = 0f;
                Vector3 anchor = aAxis.sqrMagnitude > 0.01f
                    ? s.CastlePos + aAxis.normalized * 11f : s.CastlePos;
                SetTarget(anchor, 3f);
                if (FlatDist(s.HeroPos, anchor) <= 4f || Time.unscaledTime >= armyWalkAt)
                {
                    var cu = CommandUnits.instance;
                    cu.PlaceCommandedUnitsAndCalculateTargetPositions(false);
                    cu.MakeUnitsInBufferHoldPosition();
                    cu.commanding = false; // TryToSelectUnits semantics: placed units leave the commanding set
                    armyPhase = 2;
                    Plugin.Log?.LogInfo("[bot] army placed at anchor, holding");
                    LogLine(in s, "army-placed");
                }
                return;
            }

            // Nothing left to pick up or pay for: walk to the Nighthorn. Its InteractionBegin
            // auto-harvests every building and loose coin on first press, then
            // starts the night wave on the next — which is when enemies drop coins.
            if (s.HasHorn)
            {
                Mode = BotMode.StartNight;
                SetTarget(s.HornPos, 2f);
                if (s.HornDist <= 2.8f && Time.unscaledTime >= hornInteractAt)
                {
                    hornInteractAt = Time.unscaledTime + 2f;
                    s.Horn.InteractionBegin(PlayerInteraction.instance);
                    Plugin.Log?.LogInfo("[bot] at nighthorn -> InteractionBegin()");
                    LogLine(in s, "horn-interact");
                }
                return;
            }
            // Fallback: horn not detectable this phase (inactive GO, intro state) —
            // flip to night directly through the persistent DayNightCycle
            // singleton. Single-shot per window: SwitchToNight re-fires OnDusk /
            // StartSpawning on every call, so spamming it before IsNight flips
            // stacks multiple waves on top of each other. 15 s is enough for the
            // transition; if it never flips we retry on the next window.
            if (DayNightCycle.Instance != null && Time.unscaledTime >= nightRequestAt &&
                !s.SceneName.StartsWith("_"))
            {
                nightRequestAt = Time.unscaledTime + 15f;
                Plugin.Log?.LogInfo("[bot] no horn detected -> DayNightCycle.SwitchToNight()");
                LogLine(in s, "switch-night");
                DayNightCycle.Instance.SwitchToNight();
                Mode = BotMode.StartNight;
                return;
            }
            if (s.HasCastle && s.CastleDist > HomeRadius)
            {
                Mode = BotMode.ReturnHome;
                SetTarget(s.CastlePos, ArriveHold);
                return;
            }
            Mode = BotMode.Idle;
            ClearTarget();
        }

        /// <summary>
        /// Stuck watchdog: while steering toward a target, if the hero hasn't
        /// moved ~0.35 m within 2 s (three strikes) we recover — teleport-nudge
        /// in cheat mode; a sidestep detour under legit rules (players can't
        /// teleport, they strafe around the obstacle).
        /// </summary>
        private static void RunWatchdog(in BotPerception.Snapshot s)
        {
            if (!hasTarget || Mode == BotMode.Idle)
            {
                hasAnchor = false; StuckStrikes = 0; watchClock = 0f;
                lastWatchDist = float.MaxValue;
                return;
            }
            if (!hasAnchor)
            {
                watchAnchor = s.HeroPos; hasAnchor = true; watchClock = 0f;
                lastWatchDist = FlatDist(s.HeroPos, AimPos);
                return;
            }

            watchClock += DecisionInterval;
            if (watchClock < StuckWatchWindow) return;
            watchClock = 0f;

            float moved = Vector3.Distance(s.HeroPos, watchAnchor);
            watchAnchor = s.HeroPos;
            float aimDist = FlatDist(s.HeroPos, AimPos);
            // Still closing on the aim point = healthy pursuit even when the
            // hero itself stayed put (a melee target walking toward us).
            bool closing = aimDist < lastWatchDist - 0.3f;
            lastWatchDist = aimDist;
            bool stillFar = aimDist > arriveDist + 0.5f;

            if (moved < StuckEpsilon && stillFar && !closing)
            {
                StuckStrikes++;
                Plugin.Log?.LogWarning($"[bot] stuck strike {StuckStrikes} (mode={Mode}, moved {moved:0.00} m)");
                LogLine(in s, $"stuck:{StuckStrikes}");
                if (StuckStrikes >= MaxStrikesBeforeTeleport)
                {
                    StuckStrikes = 0;
                    var pm = PlayerMovement.instance;
                    if (Legit)
                    {
                        Vector3 toAim = AimPos - s.HeroPos; toAim.y = 0f;
                        if (moved < 0.05f && pm != null && AstarPath.active != null)
                        {
                            var ctrl = pm.GetComponent<CharacterController>();
                            Plugin.Log?.LogWarning($"[bot] hard-stuck diag: type={pm.GetType().Name} " +
                                $"ctrlEnabled={ctrl != null && ctrl.enabled} grounded={ctrl != null && ctrl.isGrounded} " +
                                $"vel={pm.Velocity} dead={pm.Dead} scene={s.SceneName}");
                            // Zero displacement = embedded inside a collider or
                            // otherwise physically trapped — a real player
                            // could not even move here, so the wall-slide is
                            // pointless. Snap to the nearest walkable navmesh
                            // node, the game's own SnapToNavmesh recovery that
                            // spawned units get. Still a teleport, but limited
                            // to a can't-move-at-all trap, never a shortcut.
                            Vector3 snap = AstarPath.active.GetNearest(
                                s.HeroPos + (toAim.sqrMagnitude > 0.01f ? toAim.normalized : Vector3.forward) * 1.5f,
                                new Pathfinding.NNConstraint()).position;
                            pm.TeleportTo(snap);
                            Plugin.Log?.LogWarning($"[bot] stuck (no movement possible) → navmesh snap to {snap}");
                            LogLine(in s, "snap");
                        }
                        else
                        {
                            // Players can't teleport — wall-slide instead. Detour
                            // reach escalates on the same side (3→12 m) so a big
                            // obstacle gets skirted instead of re-wedged after a
                            // token 3 m nudge; flips side only after a full cycle.
                            detourCount++;
                            if (detourCount > 4) { detourCount = 1; detourSide = -detourSide; }
                            float reach = 3f * detourCount;
                            Vector3 fwd = toAim.sqrMagnitude > 0.01f ? toAim.normalized : Vector3.forward;
                            detourPos = s.HeroPos + fwd * 2f +
                                Vector3.Cross(Vector3.up, fwd) * (reach * detourSide);
                            detourUntil = Time.unscaledTime + 1.2f + 0.6f * detourCount;
                            var af = UIFrameManager.instance != null ? UIFrameManager.instance.ActiveFrame : null;
                            Plugin.Log?.LogWarning($"[bot] stuck → sidestep detour x{detourCount} to {detourPos} " +
                                $"(frozen={LocalGamestate.Instance != null && LocalGamestate.Instance.PlayerFrozen}, " +
                                $"ts={Time.timeScale:0.##}, frame={(af != null ? af.name : "null")}, " +
                                $"choiceWait={ChoiceManager.instance != null && ChoiceManager.instance.ChoiceCoroutineWaiting})");
                            LogLine(in s, $"unstick:{detourCount}");
                        }
                    }
                    else if (pm != null)
                    {
                        Vector3 dir = AimPos - s.HeroPos;
                        dir.y = 0f;
                        Vector3 nudge = s.HeroPos +
                            (dir.sqrMagnitude > 0.01f ? dir.normalized : Vector3.forward) * TeleportNudge;
                        pm.TeleportTo(nudge);
                        Plugin.Log?.LogWarning($"[bot] stuck → teleport nudge to {nudge}");
                        LogLine(in s, "teleport-nudge");
                    }
                }
            }
            else { StuckStrikes = 0; detourCount = 0; }
        }

        private static void SetTarget(Vector3 pos, float arrive)
        {
            // A materially different goal invalidates the detour escalation —
            // fresh obstacles deserve a fresh wall-slide attempt.
            if (FlatDist(pos, targetPos) > 2f) detourCount = 0;
            targetPos = pos;
            arriveDist = arrive;
            hasTarget = true;
        }

        private static void ClearTarget() { hasTarget = false; engageTarget = null; ReleaseBuild(); }

        private static void ReleaseBuild()
        {
            if (heldBuild == null) return;
            var pi = PlayerInteraction.instance;
            if (pi != null) { heldBuild.Unfocus(pi); heldBuild.InteractionEnd(pi); }
            heldBuild = null;
        }

        /// <summary>
        /// Resolve whichever UI frame is freezing the player. Order matters:
        /// a running choice coroutine wins (the frame is just its view), then
        /// end-of-match (BackToLevelSelectHelper inside), then perk selection,
        /// then any generic escapable frame (reward, pause). Non-freezing
        /// frames — the campaign map's level-select UI among them — return
        /// false so we never hide the UI the bot actually uses.
        /// </summary>
        private static bool HandleBlockingFrame(in BotPerception.Snapshot s)
        {
            var fm = UIFrameManager.instance;
            var frame = fm != null ? fm.ActiveFrame : null;
            uiFrame = frame != null ? frame.name : "";
            // A pending choice blocks BuildingInteractor holds whether or not
            // its frame currently freezes the player — resolve it before the
            // frame gate so SpendGold can't deadlock on an unframed choice.
            var cm = ChoiceManager.instance;
            if (cm != null && cm.ChoiceCoroutineRunning && cm.ChoiceCoroutineWaiting)
            {
                if (Time.unscaledTime >= frameActionAt)
                {
                    frameActionAt = Time.unscaledTime + 1f;
                    Choice pick = null;
                    foreach (var c in cm.availableChoices)
                        if (c != null && c.CanBePicked) { pick = c; break; }
                    cm.choiceToReturn = pick;
                    Plugin.Log?.LogInfo($"[bot] choice frame -> '{(cm.choiceToReturn != null ? cm.choiceToReturn.name : "none")}'");
                    LogLine(in s, "choice-pick");
                }
                return true;
            }

            if (frame == null || !frame.freezePlayer) { lastFrameName = ""; frameSeen = 0; return false; }
            if (frame.name != lastFrameName) { lastFrameName = frame.name; frameSeen = 0; }

            // End-of-match screens carry a BackToLevelSelectHelper button and
            // are unescapable — follow it to return to the campaign map where
            // EnterLevel picks the next unbeaten node. Pause menus carry the
            // same button but ARE escapable, so they take the plain-close path
            // below instead. The frameSeen>=2 escalation is gated on AfterMatch*
            // states so a stubborn mid-run frame can never nuke the run.
            var backHelper = frame.GetComponentInChildren<BackToLevelSelectHelper>(true);
            if (backHelper != null && (frame.canNotBeEscaped ||
                (frameSeen >= 2 && s.GameState.StartsWith("AfterMatch"))))
            {
                if (Time.unscaledTime >= frameActionAt && SceneTransitionManager.instance != null)
                {
                    frameActionAt = Time.unscaledTime + 2f;
                    Plugin.Log?.LogInfo("[bot] end-of-match -> TransitionToLevelSelect()");
                    LogLine(in s, "match-end");
                    SceneTransitionManager.instance.TransitionToLevelSelect();
                }
                return true;
            }

            var items = frame.GetComponentsInChildren<PerkSelectionItem>(true);
            if (items != null && items.Length > 0)
            {
                if (Time.unscaledTime >= frameActionAt)
                {
                    frameActionAt = Time.unscaledTime + 1.5f;
                    int picked = 0;
                    foreach (var item in items)
                    {
                        var g = item.GetComponentInParent<PerkSelectionGroup>();
                        if (g == null || item.Selected || item.Equippable == null || !item.Equippable.IsUnlocked)
                            continue;
                        g.SelectPerk(item);
                        picked++;
                    }
                    Plugin.Log?.LogInfo($"[bot] perk frame '{frame.name}' -> picked {picked} item(s), closing");
                    LogLine(in s, "perk-pick");
                    if (!frame.canNotBeEscaped) fm.CloseActiveFrame();
                    else frame.Apply();
                }
                return true;
            }

            if (Time.unscaledTime >= frameActionAt)
            {
                frameActionAt = Time.unscaledTime + 2f;
                frameSeen++;
                Plugin.Log?.LogInfo($"[bot] blocking frame '{frame.name}' -> close");
                LogLine(in s, "frame-close");
                if (!frame.canNotBeEscaped) fm.CloseActiveFrame();
                else frame.Apply();
            }
            return true;
        }

        /// <summary>Change-detecting diag logger: same key → next emit in 15 s.</summary>
        private static void DiagLog(string key, string msg, bool warn)
        {
            if (key == lastDiagKey && Time.unscaledTime < attackDiagAt) return;
            lastDiagKey = key;
            attackDiagAt = Time.unscaledTime + 15f;
            if (warn) Plugin.Log?.LogWarning(msg); else Plugin.Log?.LogInfo(msg);
        }

        /// <summary>
        /// Force the hero to swing. TryToAttack only arms an input buffer that
        /// still has to pass cooldown + marker gates, so when it proves deaf we
        /// call Attack() directly — that runs FindAttackTarget and fires the
        /// weapon immediately. Logs a 5 s diagnostic so we can see whether the
        /// weapon ever finds a target and how far the pursuit enemy is.
        /// </summary>
        private static void PumpAttack()
        {
            var pm = PlayerMovement.instance;
            if (pm == null) return;
            if (heroAttack == null)
            {
                // WeaponEquipper (a child of the hero root) exposes the hero's
                // ManualAttack refs as public fields — the direct handle.
                // Searching children for ManualAttack misses it when the
                // weapon object isn't parented under the pawn node.
                var tagged = pm.GetComponentInParent<TaggedObject>();
                var we = tagged != null
                    ? tagged.GetComponentInChildren<WeaponEquipper>(true)
                    : UnityEngine.Object.FindObjectOfType<WeaponEquipper>();
                if (we != null)
                    heroAttack = we.activeWeapon != null ? we.activeWeapon : we.passiveWeapon;

                if (heroAttack == null && tagged != null)
                    heroAttack = tagged.GetComponentInChildren<ManualAttack>(true);

                if (heroAttack == null && Time.unscaledTime >= maScanAt)
                {
                    maScanAt = Time.unscaledTime + 1f; // FindObjectsOfType: 1 Hz, not 4
                    var all = UnityEngine.Object.FindObjectsOfType<ManualAttack>(true);
                    foreach (var ma in all)
                    {
                        var maTag = ma.GetComponentInParent<TaggedObject>();
                        if (maTag != null && maTag.Contains(TagManager.ETag.Player))
                        {
                            heroAttack = ma;
                            break;
                        }
                    }
                    if (heroAttack == null)
                    {
                        string names = "";
                        for (int i = 0; i < all.Length && i < 6; i++)
                            names += (i > 0 ? "," : "") + all[i].name;
                        var wes = UnityEngine.Object.FindObjectsOfType<WeaponEquipper>(true);
                        int equipped = PerkManager.instance != null ? PerkManager.instance.CurrentlyEquipped.Count : -1;
                        DiagLog("no-manual-attack", $"[bot] no player ManualAttack: scene has {all.Length} [{names}], {wes.Length} WeaponEquipper, {equipped} equipped perks", true);
                    }
                }
                if (heroAttack != null)
                {
                    // Capture the weapon's real reach for the ranged/melee and
                    // kite decisions, and whether it can fire on the move.
                    weaponRange = 0f;
                    foreach (var p in heroAttack.targetPriorities)
                        weaponRange = Mathf.Max(weaponRange, p.range);
                    weaponFiresWhileMoving =
                        heroAttack.GetComponent<DelayManualAttackWhileMoving>() == null;
                    Plugin.Log?.LogInfo($"[bot] ManualAttack found on '{heroAttack.name}' (autoAttack={heroAttack.autoAttack}, range={weaponRange:0.#}, firesWhileMoving={weaponFiresWhileMoving})");
                }
            }
            if (heroAttack == null)
            {
                if (Legit)
                    return;   // no direct-damage fallback under legit rules
                // Weaponless hero: no ManualAttack exists to pump. Strike the
                // engaged enemy through Hp — the InstantKill patch turns every
                // player-caused hit into a kill; even without it, 4 strikes/s
                // at 500 dmg clears a wave fast.
                var hpE = engageTarget != null ? engageTarget.GetComponent<Hp>() : null;
                if (hpE != null)
                {
                    var src = pm.GetComponentInParent<TaggedObject>();
                    hpE.TakeDamage(500f, src, true);
                }
                else
                {
                    DiagLog("weaponless:" + (engageTarget != null ? engageTarget.name : "null"),
                        $"[bot] engage: weaponless, enemy hp missing (engageTarget={(engageTarget != null ? engageTarget.name : "null")})", true);
                }
                return;
            }

            TaggedObject t = null;
            try { t = heroAttack.FindAttackTarget(true); } catch { /* priorities may be empty */ }
            float dist = engageTarget != null
                ? FlatDist(pm.transform.position, engageTarget.transform.position) : -1f;
            DiagLog("wt:" + (t != null ? t.name : "null"),
                $"[bot] engage diag: weaponTarget={(t != null ? t.name : "null")} pursueDist={dist:0.0}", false);
            if (t != null)
            {
                // Legit: TryToAttack goes through cooldown + input-buffer like
                // a real button press. Direct Attack() fires every decide tick
                // regardless of cooldownTime — a hidden attack-speed cheat.
                if (Legit) heroAttack.TryToAttack();
                else heroAttack.Attack();
            }
            else
                heroAttack.TryToAttack(); // still arm a press in case a target appears
        }

        private static Vector3 DirTo(Vector3 from, Vector3 to, float arrive)
        {
            Vector3 d = to - from;
            d.y = 0f;
            if (d.magnitude <= arrive) return Vector3.zero;
            return d.normalized;
        }

        /// <summary>Point on the hero's side of a target, `radius` m out —
        /// stops the steering from aiming inside a building's collider.</summary>
        private static Vector3 StandOff(Vector3 target, Vector3 hero, float radius)
        {
            Vector3 d = hero - target; d.y = 0f;
            if (d.magnitude <= radius) return target;
            return target + d.normalized * radius;
        }

        /// <summary>
        /// Legit steering point: next waypoint of the navmesh path to the goal,
        /// or the goal itself when no path is available (menus, off-graph).
        /// Also sets navSteerArrive — small for mid-path waypoints so the hero
        /// doesn't park at a bend, the real arriveDist at the path's end.
        /// </summary>
        private static Vector3 NavSteerPoint(Vector3 hero, Vector3 goal)
        {
            navSteerArrive = arriveDist;
            if (hasTarget) MaybeRequestPath(hero, goal);

            var p = navPath;
            if (p == null || p.vectorPath == null || p.vectorPath.Count == 0)
                return goal;
            var wp = p.vectorPath;
            while (navIndex < wp.Count - 1 && FlatDist(hero, wp[navIndex]) < 1.4f) navIndex++;
            navIndex = Mathf.Min(navIndex, wp.Count - 1);
            var last = wp[wp.Count - 1];
            // Path doesn't actually reach the goal: the navmesh isn't world-
            // complete (keep interiors, node spawn rings, coarse map meshes)
            // and the last waypoint just marks "closest I got". The hero's
            // CharacterController doesn't care about navmesh — steer straight
            // at the goal and let sidesteps handle any real wall.
            if (FlatDist(last, goal) > 2.5f) return goal;
            // Degenerate path: the navmesh snapped the whole route onto where
            // the hero already stands — steering at it gives DesiredDir≈0 →
            // standing still forever. Fall back to the raw goal.
            if (navIndex == wp.Count - 1 && FlatDist(hero, last) < 0.8f)
                return goal;
            navSteerArrive = navIndex == wp.Count - 1 ? arriveDist : 0.5f;
            return wp[navIndex];
        }

        /// <summary>
        /// Throttled A* request. Re-paths when the goal moved materially, when
        /// the current path is consumed, or when none exists. Path requests
        /// run ~1 Hz — the same cadence the game's own units recalculate.
        /// </summary>
        private static void MaybeRequestPath(Vector3 hero, Vector3 goal)
        {
            var astar = AstarPath.active;
            if (astar == null) return;
            if (navInFlight || Time.unscaledTime < navRepathAt) return;

            bool consumed = false;
            if (navPath != null && navPath.vectorPath != null && navPath.vectorPath.Count > 0)
            {
                var last = navPath.vectorPath[navPath.vectorPath.Count - 1];
                consumed = navIndex >= navPath.vectorPath.Count - 1 &&
                           FlatDist(hero, last) < 1.4f;
            }
            bool goalMoved = FlatDist(goal, navGoal) > 2.5f;
            if (navPath != null && !consumed && !goalMoved) return;

            navRepathAt = Time.unscaledTime + 1.1f;
            navGoal = goal;
            navInFlight = true;
            var p = Pathfinding.ABPath.Construct(hero, goal, done =>
            {
                navInFlight = false;
                if (!done.error && done.vectorPath != null && done.vectorPath.Count > 0)
                {
                    navPath = done;
                    navIndex = 0;
                    navDiagCount++;
                    if (navDiagCount <= 20)
                        Plugin.Log?.LogInfo($"[bot] nav-path ok: {done.vectorPath.Count} wp -> {goal}");
                }
                else
                {
                    navPath = null;
                    Plugin.Log?.LogWarning($"[bot] nav-path error -> {goal} ({done.errorLog})");
                }
            });
            AstarPath.StartPath(p);
        }

        // SceneTransitionManager keeps its busy flag private — same FieldInfo
        // trick Plugin uses for PlayerInteraction.balance. Gating the
        // transition call on it kills the old swallow-and-retry double-fire.
        private static readonly System.Reflection.FieldInfo StmRunningField =
            typeof(SceneTransitionManager).GetField("sceneTransitionIsRunning",
                System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);

        private static bool SceneTransitionBusy(SceneTransitionManager stm) =>
            StmRunningField != null && (bool)StmRunningField.GetValue(stm);

        private static float FlatDist(Vector3 a, Vector3 b)
        {
            a.y = 0f; b.y = 0f;
            return Vector3.Distance(a, b);
        }

        private static string FormatStatus(in BotPerception.Snapshot s)
        {
            return string.Format(CultureInfo.InvariantCulture,
                "{0} | wv {1}/{2} foes {3} coins {4} gold {5} hp {6:P0}",
                Mode, s.Wave, s.WaveTotal, s.EnemyCount, s.CoinCount, s.Balance, s.HeroHpPct);
        }

        // ---- telemetry: JSONL beside the plugin dll ----

        private static void EnsureLog()
        {
            if (botLog != null || logFailed) return;
            try
            {
                string path = Path.Combine(Paths.PluginPath, "bot-log.jsonl");
                botLog = new StreamWriter(path, append: true) { AutoFlush = true };
            }
            catch { logFailed = true; }
        }

        private static void CloseLog()
        {
            try { botLog?.Close(); } catch { }
            botLog = null;
        }

        private static void LogRaw(string note)
        {
            EnsureLog();
            try
            {
                botLog?.WriteLine(string.Format(CultureInfo.InvariantCulture,
                    "{{\"t\":{0:0.00},\"note\":\"{1}\"}}", Time.unscaledTime, note));
            }
            catch { }
        }

        private static void LogLine(in BotPerception.Snapshot s, string note)
        {
            EnsureLog();
            if (botLog == null) return;
            try
            {
                botLog.WriteLine(string.Format(CultureInfo.InvariantCulture,
                    "{{\"t\":{0:0.00},\"mode\":\"{1}\",\"state\":\"{2}\",\"scene\":\"{3}\",\"night\":{4},\"wave\":\"{5}/{6}\",\"foes\":{7},\"coins\":{8},\"gold\":{9},\"hp\":{10:0.###},\"pos\":[{11:0.#},{12:0.#}],\"ls\":{13},\"lvln\":{14},\"inter\":{15},\"lvld\":{16:0.#},\"horn\":{17},\"hd\":{18:0.#},\"bld\":{19},\"note\":\"{20}\"}}",
                    Time.unscaledTime, Mode, s.GameState, s.SceneName,
                    s.IsNight ? "true" : "false",
                    s.Wave, s.WaveTotal, s.EnemyCount, s.CoinCount, s.Balance,
                    s.HeroHpPct, s.HeroPos.x, s.HeroPos.z,
                    s.OnLevelSelect ? "true" : "false", s.LevelCount, s.InteractorCount, s.NearestLevelDist,
                    s.HasHorn ? "true" : "false", s.HornDist, s.BuildCount, note));
            }
            catch { }
        }
    }
}
