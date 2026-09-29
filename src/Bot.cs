using System.Globalization;
using System.IO;
using BepInEx;
using UnityEngine;

namespace ThronefallTrainer
{
    internal enum BotMode { Idle, CollectCoin, ReturnHome, HoldCastle, Engage, EnterLevel, StartNight, SpendGold, ResolveUI }

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
            (Mode == BotMode.Engage && engageTarget != null)
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
        // Day economy: building slot the bot currently holds interaction on.
        private static BuildingInteractor heldBuild;
        private static float buildInteractAt;
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
        // Frame tracking: how many times the same blocking frame survived a
        // close — a stubborn one with a back-to-map button gets followed.
        private static string lastFrameName = "";
        private static int frameSeen;

        private static StreamWriter botLog;
        private static bool logFailed;

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
                DesiredDir = DirTo(pm.transform.position, AimPos, arriveDist);
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
                LogLine(in s, "ui");
                return;
            }

            Decide(in s);
            RunWatchdog(in s);
            Status = FormatStatus(in s);
            LogLine(in s, "tick");
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
            // day can trigger the next night.
            if (lastNightState != s.IsNight)
            {
                nightRequestAt = 0f;
                lastNightState = s.IsNight;
            }

            // Campaign map is itself an InMatch scene: walk to the nearest
            // playable level node, fire its interactor (sets lastActiveLevelInfo
            // and opens the select frame), then jump straight into the level via
            // SceneTransitionManager — bypasses PlayButtonPressed, whose manager
            // singleton is null on some map variants (Craaghelm/Fangmore).
            if (s.NearestLevel != null)
            {
                Mode = BotMode.EnterLevel;
                SetTarget(s.NearestLevelPos, 2f);
                if (s.NearestLevelDist <= 2.8f && Time.unscaledTime >= levelInteractAt)
                {
                    levelInteractAt = Time.unscaledTime + 2f;
                    var li = s.NearestLevel;
                    li.InteractionBegin(PlayerInteraction.instance);
                    Plugin.Log?.LogInfo("[bot] at level node -> InteractionBegin()");
                    LogLine(in s, "level-interact");

                    var stm = SceneTransitionManager.instance;
                    if (stm != null && li.levelInfo != null)
                    {
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
                if (s.NearestEnemy != null)
                {
                    Mode = BotMode.Engage;
                    engageTarget = s.NearestEnemy;
                    SetTarget(s.NearestEnemyPos, ArriveEngage);
                    PumpAttack();
                }
                else if (s.HasCastle)
                {
                    Mode = BotMode.HoldCastle;
                    SetTarget(s.CastlePos, ArriveHold);
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
                SetTarget(s.NearestBuildPos, 1.2f);
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
                    LogLine(in s, "build-hold");
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
            if (DayNightCycle.Instance != null && Time.unscaledTime >= nightRequestAt)
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
        /// moved ~0.35 m within 2 s (three strikes) we teleport-nudge toward the
        /// target — the same recovery the game itself uses for spawned units.
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
                    if (pm != null)
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
            else StuckStrikes = 0;
        }

        private static void SetTarget(Vector3 pos, float arrive)
        {
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

            // End-of-match screens carry a BackToLevelSelectHelper button and
            // are unescapable — follow it to return to the campaign map where
            // EnterLevel picks the next unbeaten node. Pause menus carry the
            // same button but ARE escapable, so they take the plain-close path
            // below instead; frameSeen>=2 escalates a stubborn escapable frame.
            var backHelper = frame.GetComponentInChildren<BackToLevelSelectHelper>(true);
            if (backHelper != null && (frame.canNotBeEscaped || frameSeen >= 2))
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
                    Plugin.Log?.LogInfo($"[bot] ManualAttack found on '{heroAttack.name}' (autoAttack={heroAttack.autoAttack})");
            }
            if (heroAttack == null)
            {
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
                heroAttack.Attack(); // direct fire — bypasses buffer/cooldown gates
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
