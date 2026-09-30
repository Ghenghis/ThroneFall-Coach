using System.Globalization;
using System.IO;
using BepInEx;
using UnityEngine;

namespace ThronefallTrainer
{
    // BotMode lives in BotBrain.cs (pure layer — replay tests compile it alone).

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
        /// <summary>Active UI frame name ("" = none) — mailbox outbox reads it.</summary>
        public static string UiFrame => uiFrame;
        public static int StuckStrikes { get; private set; }

        // ---- steering knobs ----
        private const float ArriveCoin   = 0.8f;
        private const float ArriveHold   = 6f;
        // Park basically on top of the target — 4 m left the hero outside
        // melee/swing range, so it stood in a mob never attacking.
        private const float ArriveEngage = 1.5f;
    // Orbit sweep constants/state live in BotBrain.cs (pure layer).
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
        private static float arriveSince;   // arrived-but-failing timer
        private static int stuckStrikeTotal;  // per-run cap (log flood)
        private static Vector3 watchAnchor;
        private static bool hasAnchor;
        private static Vector3 lastFreePos; private static float lastFreeAt = -999f;

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

        // title-screen advance: throttle while the level-select scene loads
        private static float menuAdvanceAt;

        // Blocking UI frames (level-up reward, perk select, upgrade choice,
        // end-of-match, pause) freeze the player — resolved before the FSM.
        private static float frameActionAt;
        private static string uiFrame = "";
        private static string lastUiNoteFrame = "";
        private static float nextUiNoteAt;
        // Day economy: building slot the bot currently holds interaction on.
        private static BuildingInteractor heldBuild;
        // (Clocks/watch state moved into BotMemory — the pure layer.)
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
        private static bool navWrongLayer;   // path resolved on elevated navmesh
        private static float navDirectUntil; // beeline window — navmesh lies, feet don't
        private static float interZeroSince = -1f;  // no-interactables timer
        private static float interVacuumAt;         // vacuum exit cooldown
        private static float nonVacSince = -1f;     // sustained-healthy window
        private static float navRepathAt;
        private static bool navInFlight;
        private static float navSteerArrive = 0.5f;
        private static int navDiagCount;
        private static float nextMoveDiagAt;

        // Legit combat state (army phase/clocks moved into BotMemory).
        private static float weaponRange;          // hero weapon's max priority range
        private static bool weaponFiresWhileMoving = true;

        // Session memory: which scenes we've played and how often we lost
        // each, so a too-hard node rotates out instead of looping forever.
        private static bool lastNightTick = true;   // first tick IS a day-start — coach plans it

        /// <summary>Compact telemetry digest for the coach — ~200 tokens.</summary>
        private static string Digest(in BotPerception.Snapshot s)
        {
            return "{\"scene\":\"" + (s.SceneName ?? "") + "\"," +
                "\"wave\":" + s.Wave + ",\"wave_max\":" + s.WaveTotal +
                ",\"gold\":" + s.Balance + ",\"cores\":" + s.CoreBalance +
                ",\"allies\":" + s.AllyCount + ",\"free_units\":" + s.FreeUnits +
                ",\"doors_covered\":" + s.DoorsCovered + ",\"doors\":" + s.DoorCount +
                ",\"foes\":" + s.EnemyCount + ",\"red_alert\":" + (s.RedAlert ? "true" : "false") +
                ",\"buildings\":" + s.BuildCount +
                ",\"hero_hp\":" + s.HeroHpPct.ToString("0.##",
                    System.Globalization.CultureInfo.InvariantCulture) +
                ",\"defeats\":" + (sessionDefeats.TryGetValue(s.SceneName ?? "", out int dd) ? dd : 0) +
                ",\"policy\":" + Policy.Stats() + "}";
        }

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
            BotPerception.CoinSkip = c => coinIgnore.Contains(c);
            Recorder.Start();
        }

        private static int recTickFrame;
        private static BotMode prevModeRec = BotMode.Idle;
        private static float modeSinceAt, nextAuditAt;
        private static string recordedScene;

        // Pure-layer memory: everything the old file-level statics carried for
        // the FSM (clocks, phases, held-slot key, orbit sweep) — Tick passes it
        // by ref so Decide stays testable.
        private static BotMemory mem = BotMemory.Fresh();

        // Phase 2 policy: hot-loaded line-DSL retuning the FSM's numeric
        // knobs. Last-good table wins on any parse error.
        private static PolicyTable pol = PolicyTable.Default();
        private static string polPath;
        private static long polStamp;
        private static float polScanAt;
        private static readonly System.Collections.Generic.HashSet<string> prevRuleFires =
            new System.Collections.Generic.HashSet<string>();
        private static float holdDiagAt;
        private static string holdDoneName = "";

        private static readonly System.Collections.Generic.HashSet<Coin> coinIgnore =
            new System.Collections.Generic.HashSet<Coin>();

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
            stuckStrikeTotal = 0;
            ReleaseBuild();              // mid-hold disable left InteractionBegin open
            decisionClock = 0f;
            mem = BotMemory.Fresh();
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
            // Exponential smoothing — frame-rate lerp of the desired direction
            // turns the hero like a human instead of snapping at 4 Hz decision
            // boundaries. Retarget pops become smooth arcs.
            var pm = PlayerMovement.instance;
            Vector3 want = Vector3.zero;
            if (hasTarget && pm != null)
            {
                if (Legit)
                    want = DirTo(pm.transform.position, NavSteerPoint(pm.transform.position, AimPos), navSteerArrive);
                else
                    want = DirTo(pm.transform.position, AimPos, arriveDist);
            }
            float k = 1f - Mathf.Exp(-10f * Time.unscaledDeltaTime);
            DesiredDir = Vector3.Lerp(DesiredDir, want, k);
            if (DesiredDir.sqrMagnitude < 0.0001f) DesiredDir = Vector3.zero;

            // Hold-to-pay at FRAME rate: CostDisplay.FillUp advances by
            // Time.deltaTime PER CALL — a 4 Hz decide-tick pump starves the
            // fill ~15x and any release refunds every filled coin back to
            // pickup form. This is the "gold never spends" bug (refpack
            // finding). The hold runs here, once per Update.
            var piHold = PlayerInteraction.instance;
            if (heldBuild != null && piHold != null && pm != null)
                heldBuild.InteractionHold(piHold);

            // 1 Hz hold diagnostic while paying — the private fill flags tell
            // us which early-return starves the fill.
            if (heldBuild != null && Time.unscaledTime >= holdDiagAt)
            {
                holdDiagAt = Time.unscaledTime + 1f;
                var ty = heldBuild.GetType();
                object Get(string n) => ty.GetField(n, System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance)?.GetValue(heldBuild);
                string bName = heldBuild.targetBuilding != null ? heldBuild.targetBuilding.buildingName : "";
                Plugin.Log?.LogInfo($"[bot] hold-diag '{heldBuild.name}' b='{bName}': state={Get("currentState")} started={Get("interactionStarted")} waitChoice={Get("isWaitingForChoice")} complete={Get("interactionComplete")} harvest={heldBuild.canBeHarvested} canInter={heldBuild.CanBeInteractedWith}");
                // Playbook bookkeeping: a completed fill advances the
                // build-order tracker so the next pick follows the plan.
                var cpl = Get("interactionComplete");
                if (cpl is bool done && done && bName != "" &&
                    bName != holdDoneName)
                {
                    holdDoneName = bName;
                    BotPerception.BuildDone(bName,
                        heldBuild.transform.position);
                }
            }

            Coach.PerFrame();   // live.png + user command-file poll

            decisionClock += Time.unscaledDeltaTime;
            if (decisionClock < DecisionInterval) return;
            decisionClock = 0f;
            TickInner();
        }

        private static void TickInner()
        {
            // Held-hold stickiness: while paying, perception re-selects the
            // same slot so BuildKey can't flip mid-fill (a flip releases the
            // hold and refunds every partially-paid coin — see refpack
            // CostDisplay.CancelFill respawn mechanic).
            int heldKey = heldBuild != null ? heldBuild.GetInstanceID() : -1;
            var s = BotPerception.Capture(heldKey);
            BotPerception.Last = s; BotPerception.LastValid = true;

            // Session memory edges: a victory clears the level's defeat count
            // and marks it toured; a defeat counts toward rotating the node
            // out of the unbeaten pool (LevelScore penalises it).
            if (s.GameState != lastGameState)
            {
                // InMatch edge = a fresh match for bookkeeping AND runtime
                // state — same-scene retries (defeat → retry loads the same
                // scene name) skipped the scene-name check and leaked coach
                // overrides, parked strikes, and policy traj into the retry.
                if (s.GameState == "InMatch")
                {
                    Recorder.BeginRun(s.SceneName);
                    Policy.BeginRun();
                    Coach.ResetRun();
                    stuckStrikeTotal = 0;
                }
                if (s.GameState == "AfterMatchVictory" && lastMatchScene != null)
                {
                    playedThisSession.Add(lastMatchScene);
                    sessionDefeats.Remove(lastMatchScene);
                    Recorder.MatchEnd("victory", Legit);
                    Policy.MatchEnd(true, Mathf.Max(0f, s.CastleHpPct), BotPerception.BreachCount);
                }
                else if (s.GameState == "AfterMatchDefeat" && lastMatchScene != null)
                {
                    sessionDefeats[lastMatchScene] =
                        sessionDefeats.TryGetValue(lastMatchScene, out int d) ? d + 1 : 1;
                    Plugin.Log?.LogInfo($"[bot] defeat on '{lastMatchScene}' (x{sessionDefeats[lastMatchScene]} this session)");
                    LogLine(in s, "defeat");
                    Recorder.MatchEnd("defeat", Legit);
                    Policy.MatchEnd(false, Mathf.Max(0f, s.CastleHpPct), BotPerception.BreachCount);
                    Coach.Advise("defeat", Digest(in s));
                    if (Coach.VisionEnabled)
                    {
                        var shot = ScreenCapture.CaptureScreenshotAsTexture();
                        if (shot != null)
                        {
                            Coach.AnalyzeScreenshot(shot.EncodeToPNG(),
                                "scene=" + (s.SceneName ?? ""));
                            UnityEngine.Object.Destroy(shot);
                        }
                    }
                }
                lastGameState = s.GameState;
            }
            // Day-start edge: night survived (+0.2 reward pulse) and the
            // coach plans the build order for the day.
            if (lastNightTick && !s.IsNight && s.Valid)
                Policy.Pulse(0.2f);
            if (lastNightTick && !s.IsNight && s.Valid &&
                !(s.SceneName != null && s.SceneName.StartsWith("_")))
                Coach.Advise("day-start", Digest(in s));
            if (s.Valid) lastNightTick = s.IsNight;
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
                WriteAuditStub(in s, "menu");
                return;
            }

            // Any frame that freezes the player (level-up reward, perk/upgrade
            // pick, victory or defeat screen, pause) blocks all in-world
            // interaction — resolve it before the FSM picks a mode. Non-freezing
            // frames like the level-select map UI are deliberately untouched.
            if (HandleBlockingFrame(in s))
            {
                Mode = BotMode.ResolveUI;
                // Don't ClearTarget→ReleaseBuild while a CHOICE coroutine is
                // live — releasing mid-fill refunds the payment (the exact
                // refund loop the trace found). Movement target still clears.
                if (!(ChoiceManager.instance != null &&
                      ChoiceManager.instance.ChoiceCoroutineRunning))
                    ClearTarget();
                WriteAuditStub(in s, "ui:" + uiFrame);
                Status = "ui: " + uiFrame;
                if (uiFrame != lastUiNoteFrame || Time.unscaledTime >= nextUiNoteAt)
                {
                    lastUiNoteFrame = uiFrame;
                    nextUiNoteAt = Time.unscaledTime + 5f;
                    LogLine(in s, "ui");
                }
                return;
            }

            // Run bookkeeping: scene transitions begin a recorder run.
            // Same-scene retries are covered by the InMatch edge above.
            if (!s.SceneName.StartsWith("_") && !s.OnLevelSelect &&
                recordedScene != s.SceneName)
            {
                recordedScene = s.SceneName;
                Recorder.BeginRun(s.SceneName);
                Policy.BeginRun();   // abandoned trajectories must not leak
                // Coach overrides must not leak across matches — a squad_size
                // issued hours ago silently steered later runs. Fresh slate.
                Coach.ResetRun();
                stuckStrikeTotal = 0;   // per-run strike-log cap
            }

            var sd = BotPerception.ToData(in s);

            // Interactor vacuum: a same-scene retry can load a Durststein
            // with ZERO spawned interactables (inter=0, bld=0, coins=0 for
            // minutes — observed run 044014Z, hero frozen at the castle
            // doing hero-door all day). No bot action can fix it; the match
            // is corrupt. Reload via level select — EnterLevel re-picks.
            // inter=0 alone is NOT proof — the metric itself is unreliable
            // (healthy runs show inter:0 while building). Require the real
            // signals: nothing buildable AND nothing collectible AND no army
            // for a sustained day stretch.
            if (s.GameState == "InMatch" && !s.IsNight && s.AllyCount == 0 &&
                s.CoinCount == 0 && s.NearestBuild == null && s.InteractorCount == 0)
            {
                nonVacSince = -1f;
                if (interZeroSince < 0)
                {
                    interZeroSince = Time.unscaledTime;
                    Plugin.Log?.LogWarning(
                        $"[bot] vacuum-diag ARMED: gs={s.GameState} night={s.IsNight} " +
                        $"ally={s.AllyCount} coins={s.CoinCount} nb={(s.NearestBuild == null ? "null" : s.NearestBuildName)} " +
                        $"inter={s.InteractorCount}");
                }
                else if (Time.unscaledTime - interZeroSince > 40f &&
                         Time.unscaledTime >= interVacuumAt)
                {
                    interVacuumAt = Time.unscaledTime + 120f;   // one try/2min
                    interZeroSince = -1f;
                    // A vacuum costs the node like a defeat would — the map
                    // scorer then picks a DIFFERENT unbeaten node with fresh
                    // interactables instead of resuming this dead match
                    // forever (observed: vacuum→reload→vacuum loop).
                    if (s.SceneName != null)
                    {
                        sessionDefeats[s.SceneName] =
                            sessionDefeats.TryGetValue(s.SceneName, out int vd) ? vd + 1 : 1;
                    }
                    Plugin.Log?.LogWarning(
                        "[bot] interactor vacuum — no interactables/coins 40 s " +
                        "into day; match is corrupt → level select via frame");
                    LogLine(in s, "inter-vacuum");
                    // Same lesson as the match-end path: go through the pause
                    // frame's own back-button, not a raw scene transition.
                    var fm2 = UIFrameManager.instance;
                    var frame2 = fm2 != null ? fm2.ActiveFrame : null;
                    if (frame2 != null) frame2.Apply();
                    else if (fm2 != null && PlayerInteraction.instance != null &&
                             SceneTransitionManager.instance != null)
                        SceneTransitionManager.instance.TransitionToLevelSelect();
                }
            }
            else
            {
                // Fields flicker (ally/coin/gs bounce between captures) —
                // only a SUSTAINED healthy window disarms the vacuum timer.
                if (nonVacSince < 0) nonVacSince = Time.unscaledTime;
                if (Time.unscaledTime - nonVacSince > 3f) interZeroSince = -1f;
            }

            // Sidecar bridge (Phase 3): poll inbox orders (1 Hz), publish
            // state.json for the external agent (0.2 Hz).
            Mailbox.Poll(in s);

            // Hot reload: policy file mtime changed → re-validate; on any
            // error keep the last-good table and log a policy-reject event.
            if (Time.unscaledTime >= polScanAt)
            {
                polScanAt = Time.unscaledTime + 1f;
                if (polPath == null) polPath = System.IO.Path.Combine(Recorder.AgentDir, "policy.txt");
                try
                {
                    if (System.IO.File.Exists(polPath) &&
                        System.IO.File.GetLastWriteTimeUtc(polPath).Ticks != polStamp)
                    {
                        polStamp = System.IO.File.GetLastWriteTimeUtc(polPath).Ticks;
                        var errors = new System.Collections.Generic.List<string>();
                        if (PolicyTable.Parse(System.IO.File.ReadAllText(polPath), ref pol, out errors))
                            Plugin.Log?.LogInfo($"[bot] policy v{pol.Version} loaded ({pol.rules.Count} rule(s))");
                        else
                        {
                            LogLine(in s, "policy-reject");
                            Plugin.Log?.LogWarning($"[bot] policy REJECTED (kept v{pol.Version}): {string.Join("; ", errors)}");
                        }
                    }
                }
                catch (System.Exception ex) { Plugin.Log?.LogWarning($"[bot] policy read: {ex.Message}"); }
            }

            var pres = pol.Resolved(in sd);
            var res = BotBrain.Decide(in sd, ref mem, Time.unscaledTime, Legit, in pres);
            // Rule telemetry: fire-once events per rule id + a summary count.
            if (res.RulesFired != null && res.RulesFired.Count > 0)
                foreach (var rid in res.RulesFired)
                {
                    if (prevRuleFires.Add(rid)) LogLine(in s, "rule-fire:" + rid);
                    Recorder.CountRuleFire(rid);
                }
            Mode = res.Mode;
            NetPolicy.Shadow(in s, res.Mode.ToString());   // learned-net agreement
            // Pursuit ref for the cheat-steer path and attack diag — the pure
            // layer can't hold Unity refs, so it returns a flag and we resolve.
            engageTarget = res.Pursue == 2
                ? s.NearestEnemy
                : res.Pursue == 1
                    ? (s.CastleThreat != null ? s.CastleThreat : s.NearestEnemy)
                    : null;   // Pursue==0 → no target: stale refs fed the
                              // weaponless TakeDamage fallback + move-diag
            if (res.HasAim) SetTarget(new Vector3(res.AimPos.X, 0f, res.AimPos.Z), res.Arrive, res.ProjectToNav);
            else ClearTarget();
            foreach (var note in res.Notes) LogLine(in s, note);
            foreach (var it in res.Intents) Execute(in s, it);
            RunWatchdog(in s);
            Status = FormatStatus(in s);
            LogLine(in s, "tick");

            // v3 recorder: 2 Hz compact DTO + run facts + mode edges.
            Recorder.NoteGameFacts(in s);
            if (Mode != prevModeRec)
            {
                if (Mode == BotMode.HeroDead) Recorder.CountDeath();
                prevModeRec = Mode;
                modeSinceAt = Time.unscaledTime;
            }
            // Audit feed for the coach UI: current action, playbook checklist,
            // per-door posts — refreshed ~every 3 s so the panel can prove
            // what the bot is (not) doing. Atomic tmp+move: the server reads
            // this every second — a torn write would poison the feed.
            if (Time.unscaledTime >= nextAuditAt)
            {
                nextAuditAt = Time.unscaledTime + 3f;
                try
                {
                    var ap = System.IO.Path.Combine(Recorder.AgentDir, "audit.json");
                    var tmp = ap + ".tmp";
                    System.IO.File.WriteAllText(tmp,
                        BotPerception.AuditJson(ref s, Mode.ToString(),
                            modeSinceAt, Time.unscaledTime));
                    if (System.IO.File.Exists(ap)) System.IO.File.Delete(ap);
                    System.IO.File.Move(tmp, ap);
                }
                catch { }
            }
            if ((recTickFrame++ & 1) == 0)
                Recorder.Tick(sd.ToJson("tick", Time.unscaledTime, Mode));

            // Phase-5 anomaly detectors — cheap pass/fail checks that emit
            // `anomaly:*` events; the critic/evaluator consumes the rates.
            CheckAnomalies(in s);

            // Movement diag while the watchdog is grinding: is the input even
            // reaching the character, and is something freezing it?
            if (StuckStrikes > 0 && Time.unscaledTime >= nextMoveDiagAt)
            {
                nextMoveDiagAt = Time.unscaledTime + 2f;
                var pmD = PlayerMovement.instance;
                if (pmD == null) { nextMoveDiagAt = Time.unscaledTime + 2f; return; }
                int wpCount = navPath?.vectorPath != null ? navPath.vectorPath.Count : -1;
                string wpInfo = wpCount > 0 ? string.Join(";", navPath.vectorPath) : "-";
                Plugin.Log?.LogWarning($"[bot] move-diag: hasTgt={hasTarget} desired={DesiredDir} " +
                    $"vel={pmD.Velocity} " +
                    $"frozen={LocalGamestate.Instance != null && LocalGamestate.Instance.PlayerFrozen} " +
                    $"mode={Mode} aim={AimPos} hero={pmD.transform.position} " +
                    $"navIdx={navIndex} wpCount={wpCount} inFlight={navInFlight} navGoal={navGoal} wp=[{wpInfo}] steer={NavSteerPoint(pmD.transform.position, AimPos)}");
            }
        }


        // Phase-5 anomaly state: detectors emit once-per-cooldown so the
        // event stream gets a signal rate, not a flood.
        private static float stuckSpamWindow = -1f;
        private static int stuckSpamCount;
        private static float nightParkSince = -1f;
        private static float lastAnomalyAt;
        private static Vector3 nightParkPos;

        /// <summary>
        /// Bounded anomaly checks (v3 Phase 5 detectors). Events only —
        /// correction stays with the watchdog/brain; these prove the run
        /// health signal for the critic and future action-menu solver.
        /// </summary>
        private static void CheckAnomalies(in BotPerception.Snapshot s)
        {
            float now = Time.unscaledTime;
            if (now < lastAnomalyAt + 10f) return;   // ≥10 s between anomaly events

            // D1 stuck-spam: ≥3 strikes inside a 30 s window.
            if (StuckStrikes > 0)
            {
                if (now > stuckSpamWindow) { stuckSpamWindow = now + 30f; stuckSpamCount = 0; }
                if (++stuckSpamCount >= 3)
                {
                    stuckSpamCount = 0; lastAnomalyAt = now;
                    LogLine(in s, "anomaly:stuck-spam");
                    Plugin.Log?.LogWarning($"[bot] anomaly stuck-spam at {s.HeroPos} mode={Mode}");
                    return;
                }
            }

            // D2 night-park: Engage mode, foes live, hero effectively parked
            // >15 s (watchdog's arrival-freeze window) — the encirclement
            // case that used to end runs.
            if (s.IsNight && s.EnemyCount > 0 && Mode == BotMode.Engage)
            {
                if (nightParkSince < 0f) { nightParkSince = now; nightParkPos = s.HeroPos; }
                else if ((s.HeroPos - nightParkPos).sqrMagnitude > 1.5f)
                {
                    nightParkSince = now; nightParkPos = s.HeroPos;
                }
                else if (now - nightParkSince > 15f)
                {
                    nightParkSince = -1f; lastAnomalyAt = now;
                    LogLine(in s, "anomaly:night-park");
                    Plugin.Log?.LogWarning($"[bot] anomaly night-park at {s.HeroPos} foes={s.EnemyCount}");
                    return;
                }
            }
            else nightParkSince = -1f;

            // D3 army-starved: a military building stood >90 s yet zero
            // units ever came out — production stall that used to die
            // silently (mm-watch could only see ally=0, not the cause).
            if (BotPerception.MilitaryFirstAt > 0f && s.AllyCount == 0 &&
                now - BotPerception.MilitaryFirstAt > 90f)
            {
                lastAnomalyAt = now;
                LogLine(in s, "anomaly:army-starved");
                Plugin.Log?.LogWarning(
                    "[bot] anomaly army-starved: military building 90s, ally=0");
                return;
            }
        }

        /// <summary>
        /// Stuck watchdog: while steering toward a target, if the hero hasn't
        /// moved ~0.35 m within 2 s (three strikes) we recover — teleport-nudge
        /// in cheat mode; a sidestep detour under legit rules (players can't
        /// teleport, they strafe around the obstacle).
        /// </summary>
        private static void RunWatchdog(in BotPerception.Snapshot s)
        {
            if (!hasTarget || Mode == BotMode.Idle || s.HeroDead)
            {
                // Dead hero: no movement is expected — strikes would stack
                // forever and fire teleport attempts on a corpse.
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
            // Track the last position the hero provably MOVED through — the
            // escape point when the hard-stuck path proves he's caged.
            if (moved >= StuckEpsilon) { lastFreePos = watchAnchor; lastFreeAt = Time.unscaledTime; }
            watchAnchor = s.HeroPos;
            float aimDist = FlatDist(s.HeroPos, AimPos);
            // Still closing on the aim point = healthy pursuit even when the
            // hero itself stayed put (a melee target walking toward us).
            bool closing = aimDist < lastWatchDist - 0.3f;
            lastWatchDist = aimDist;
            bool stillFar = aimDist > arriveDist + 0.5f;

            // Arrived-but-failing watchdog: reached the aim radius yet the
            // interaction never completes (coin on a collider, slot behind a
            // wall edge, unreachable horn). stillFar is false so strikes
            // never accrue — the hero used to stand there forever. Give an
            // arrived aim 20 s to resolve, then park it like a stall.
            if (!stillFar)
            {
                if (arriveSince <= 0f) arriveSince = Time.unscaledTime;
                if (Time.unscaledTime - arriveSince > 20f)
                {
                    arriveSince = 0f;
                    Plugin.Log?.LogWarning($"[bot] aim-stall in {Mode} — parked aim");
                    LogLine(in s, "aim-stall");
                    if (Mode == BotMode.CollectCoin && s.NearestCoin != null)
                        coinIgnore.Add(s.NearestCoin);
                    else if (Mode == BotMode.SpendGold && s.NearestBuild != null)
                        BotPerception.IgnoreBuild(s.NearestBuild, 300f);
                    ClearTarget();
                    return;
                }
            }
            else arriveSince = 0f;

            if (moved < StuckEpsilon && stillFar && !closing)
            {
                StuckStrikes++;
                stuckStrikeTotal++;
                if (stuckStrikeTotal == 60)
                    Plugin.Log?.LogWarning("[bot] 60 stuck strikes — per-strike logging capped this run");
                else if (stuckStrikeTotal < 60)
                    Plugin.Log?.LogWarning($"[bot] stuck strike {StuckStrikes} (mode={Mode}, moved {moved:0.00} m)");
                LogLine(in s, $"stuck:{StuckStrikes}");
                if (StuckStrikes >= MaxStrikesBeforeTeleport)
                {
                    StuckStrikes = 0;
                    // Wedged mid-orbit (ring segment inside geometry): jump
                    // the sweep past this arc so the next ring point is a
                    // different spot, not the same wall.
                    if (Mode == BotMode.Engage) mem.OrbitAngle += mem.OrbitDir * 0.9f;
                    // A coin the hero can't reach after 3 recoveries is behind
                    // geometry or off-navmesh — park it for the rest of the
                    // scene instead of grinding snaps forever (observed: 4
                    // snap cycles ~30 s chasing a walled coin on Durststein).
                    if (Mode == BotMode.CollectCoin && s.NearestCoin != null)
                    {
                        coinIgnore.Add(s.NearestCoin);
                        ClearTarget();
                        Plugin.Log?.LogWarning("[bot] coin unreachable — parked");
                        LogLine(in s, "coin-stall");
                        return;
                    }
                    var pm = PlayerMovement.instance;
                    if (Legit)
                    {
                        Vector3 toAim = AimPos - s.HeroPos; toAim.y = 0f;
                        if (moved < 0.05f && pm != null)
                        {
                            // LEGIT MODE: no teleport — players can't warp out
                            // of a collider cage. Escalate the detour reach
                            // instead (3→12 m) and park the aim if it stays
                            // unreachable; teleport nudges violated the
                            // legit-mode contract (audit finding).
                            var ctrl = pm.GetComponent<CharacterController>();
                            Plugin.Log?.LogWarning($"[bot] hard-stuck diag: type={pm.GetType().Name} " +
                                $"ctrlEnabled={ctrl != null && ctrl.enabled} grounded={ctrl != null && ctrl.isGrounded} " +
                                $"vel={pm.Velocity} dead={pm.Dead} scene={s.SceneName}");
                            detourCount++;
                            if (detourCount > 4) { detourCount = 1; detourSide = -detourSide; }
                            float reach = 3f * detourCount;
                            Vector3 fwd = toAim.sqrMagnitude > 0.01f ? toAim.normalized : Vector3.forward;
                            detourPos = s.HeroPos + fwd * 2f +
                                Vector3.Cross(Vector3.up, fwd) * (reach * detourSide);
                            detourUntil = Time.unscaledTime + 1.2f + 0.6f * detourCount;
                            Plugin.Log?.LogWarning($"[bot] hard-stuck (legit) → detour x{detourCount} to {detourPos}");
                            LogLine(in s, $"unstick:{detourCount}");

                            // If the aim itself is unreachable (nav island /
                            // one-way drop — A* returns a 1-wp degenerate
                            // path), park the pick like the coin stall does;
                            // the next-best slot/coin takes over instead of
                            // grinding the same wall forever. A wrong-layer
                            // path (elevated navmesh, wall-top hero to ground
                            // slot) can NEVER descend — park instantly.
                            if (Mode == BotMode.SpendGold && s.NearestBuild != null &&
                                (navWrongLayer || StuckStrikes >= 3))
                            {
                                // HERO is the wrong layer (standing on a wall
                                // top, all waypoints at y≈13): parking the slot
                                // is wrong — the slot is fine, WE can't descend.
                                // Aim at the castle (always ground level) — the
                                // route the hero climbed up routes back down.
                                if (s.HeroPos.y > s.NearestBuildPos.y + 2.5f)
                                {
                                    ClearTarget();
                                    navWrongLayer = false;
                                    SetTarget(s.CastlePos, 1.5f);
                                    Plugin.Log?.LogWarning("[bot] hero on wall top → descending via castle");
                                    LogLine(in s, "hero-descend");
                                }
                                else if (navWrongLayer)
                                {
                                    // Wrong-layer path — try WALKING IT
                                    // (players don't use navmesh; a 30m
                                    // straight steer + wall-slide reaches
                                    // what A* can't route). Stand cells die
                                    // too so the aim comes off the bad cell.
                                    BotPerception.IgnoreStand(s.NearestBuildPos);
                                    BotPerception.NoteBuildFail(
                                        BotPerception.BuildCat(s.NearestBuildName));
                                    navDirectUntil = Time.unscaledTime + 9f;
                                    navPath = null; navIndex = 0;
                                    navWrongLayer = false;
                                    Plugin.Log?.LogWarning("[bot] wrong-layer path → direct steer 9s");
                                    LogLine(in s, "direct-steer");
                                }
                                else
                                {
                                    BotPerception.IgnoreBuild(s.NearestBuild, 300f);
                                    BotPerception.NoteBuildFail(
                                        BotPerception.BuildCat(s.NearestBuildName));
                                    ClearTarget();
                                    Plugin.Log?.LogWarning("[bot] slot unreachable — parked 5 min" +
                                        (navWrongLayer ? " [layer]" : ""));
                                    navWrongLayer = false;
                                    LogLine(in s, "build-unreachable");
                                }
                            }
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

        /// <summary>Outside InMatch (menus, frames) the normal audit writer
        /// never runs — the server then shows the LAST mode for minutes
        /// ("Engage" while sitting at level select = the 'rogue bot' look).
        /// Write a minimal honest audit here: mode=ui/menu, real scene.</summary>
        private static void WriteAuditStub(in BotPerception.Snapshot s, string label)
        {
            if (Time.unscaledTime < nextAuditAt) return;
            nextAuditAt = Time.unscaledTime + 3f;
            try
            {
                var ap = System.IO.Path.Combine(Recorder.AgentDir, "audit.json");
                var tmp = ap + ".tmp";
                System.IO.File.WriteAllText(tmp,
                    "{\"scene\":\"" + (s.SceneName ?? "?") + "\",\"t\":0," +
                    "\"mode\":\"" + label + "\",\"mode_since\":0,\"gold\":0," +
                    "\"ally\":0,\"free\":0,\"foes\":0,\"night\":false," +
                    "\"wave\":0,\"wave_total\":0,\"doors_cov\":0,\"doors\":0," +
                    "\"red\":false,\"breaches\":0,\"bld\":0,\"cur_build\":\"\"," +
                    "\"checklist\":[],\"door_units\":[],\"door_lines\":[]," +
                    "\"cat_built\":{},\"alerts\":[]}");
                if (System.IO.File.Exists(ap)) System.IO.File.Delete(ap);
                System.IO.File.Move(tmp, ap);
            }
            catch { }
        }

        private static void SetTarget(Vector3 pos, float arrive, bool projectToNav = false)
        {
            // Navmesh projection: sweep targets (orbit ring) can land inside
            // geometry — aim at the nearest walkable point instead.
            if (projectToNav && AstarPath.active != null)
                pos = AstarPath.active.GetNearest(pos, new Pathfinding.NNConstraint()).position;
            // A materially different goal invalidates the detour escalation —
            // fresh obstacles deserve a fresh wall-slide attempt.
            if (FlatDist(pos, targetPos) > 2f) detourCount = 0;
            targetPos = pos;
            arriveDist = arrive;
            hasTarget = true;
        }

        /// <summary>
        /// Executes a pure-layer Intent against the live refs in the snapshot.
        /// Every world-side call the old inline Decide made lives here — the
        /// Brain only emits intent kind + index.
        /// </summary>
        private static void Execute(in BotPerception.Snapshot s, Intent it)
        {
            if (it.CheatOnly && Legit) return;   // legit gate: never fire cheat intents
            var pi = PlayerInteraction.instance;
            switch (it.Kind)
            {
                case IntentKind.ReleaseHold:
                    ReleaseBuild();
                    break;
                case IntentKind.BeginHold:
                    if (s.NearestBuild != null && pi != null)
                    {
                        ReleaseBuild();
                        var bi = s.NearestBuild;
                        bi.Focus(pi);            // harvest pays out on focus
                        bi.InteractionBegin(pi);
                        heldBuild = bi;
                        // RL: the build-focus choice is now a USED decision.
                        if (!string.IsNullOrEmpty(s.PolicyFocus))
                            Policy.Commit("build_focus", s.PolicyFocus,
                                s.PolicyKey ?? "",
                                new[] { "military", "income", "defense", "balanced" });
                        Plugin.Log?.LogInfo($"[bot] building '{bi.name}' -> hold-to-pay");
                    }
                    break;
                case IntentKind.PumpHold:
                    if (heldBuild != null && pi != null)
                        heldBuild.InteractionHold(pi);
                    break;
                case IntentKind.ParkSlot:
                    // Diagnostic: WHY is this slot not filling? Reflection
                    // into the interactor's private fill state — the refpack
                    // finding says FillUp only advances while InteractionHold
                    // runs and early-returns on state/choice/started gates.
                    if (s.NearestBuild != null)
                    {
                        var ty = s.NearestBuild.GetType();
                        string st = "?"; object started = "?", waiting = "?", complete = "?";
                        var f1 = ty.GetField("currentState", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                        if (f1 != null) st = f1.GetValue(s.NearestBuild)?.ToString();
                        var f2 = ty.GetField("interactionStarted", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                        if (f2 != null) started = f2.GetValue(s.NearestBuild);
                        var f3 = ty.GetField("isWaitingForChoice", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                        if (f3 != null) waiting = f3.GetValue(s.NearestBuild);
                        var f4 = ty.GetField("interactionComplete", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                        if (f4 != null) complete = f4.GetValue(s.NearestBuild);
                        var bf = ty.GetField("costDisplay", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                        object filled = "?";
                        if (bf != null)
                        {
                            var cd = bf.GetValue(s.NearestBuild);
                            var cf = cd?.GetType().GetField("currentlyFilledCoins",
                                System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                            if (cf != null) filled = cf.GetValue(cd);
                        }
                        Plugin.Log?.LogWarning($"[bot] build-stall diag '{s.NearestBuildName}': " +
                            $"state={st} started={started} waitChoice={waiting} complete={complete} filled={filled} " +
                            $"dist={s.NearestBuildDist:0.#} balance={s.Balance} harvest={s.NearestBuild.canBeHarvested} " +
                            $"canInteract={s.NearestBuild.CanBeInteractedWith}");
                    }
                    BotPerception.IgnoreBuild(s.NearestBuild, 600f);
                    if (s.NearestBuild != null)
                    {
                        Memory.Park(s.SceneName,
                            s.NearestBuild.transform.position, "build-stall");
                        BotPerception.NoteBuildFail(
                            BotPerception.BuildCat(s.NearestBuildName));
                    }
                    break;
                case IntentKind.PumpAttack:
                    PumpAttack();
                    break;
                case IntentKind.CommandArmy:
                    CommandArmyAll(in s);
                    break;
                case IntentKind.PlaceArmy:
                    PlaceArmy();
                    break;
                case IntentKind.PlaceSquad:
                    // Claim only AFTER units actually post — a 0-unit post
                    // used to stamp the door "en route" for 25 s while the
                    // perimeter stayed open.
                    if (PlaceSquad(in s) > 0 && s.HasUncoveredDoor)
                        BotPerception.MarkDoorClaim(s.UncoveredDoorPos);
                    break;
                case IntentKind.RecallToBreach:
                    RecallToBreach(in s);
                    break;
                case IntentKind.EscortHero:
                    EscortHero(in s);
                    break;
                case IntentKind.HornInteract:
                    if (s.Horn != null && pi != null)
                    {
                        s.Horn.InteractionBegin(pi);
                        Plugin.Log?.LogInfo("[bot] at nighthorn -> InteractionBegin()");
                    }
                    else if (BotPerception.HornBi != null && pi != null)
                    {
                        BotPerception.HornBi.InteractionBegin(pi);
                        Plugin.Log?.LogInfo("[bot] horn interactor -> InteractionBegin()");
                    }
                    break;
                case IntentKind.SwitchNight:
                    Policy.Commit("night", ((int)s.DayBudget).ToString(),
                        s.PolicyKey ?? "", new[] { "150", "240", "330" });
                    DayNightCycle.Instance?.SwitchToNight();
                    break;
                case IntentKind.SeedLoadout:
                    SeedLoadout(in s);
                    break;
                case IntentKind.TransitionLevel:
                    {
                        var li = s.NearestLevel;
                        var stm = SceneTransitionManager.instance;
                        if (stm != null && li != null && li.levelInfo != null &&
                            !BotPerception.SceneTransitionBusy(stm))
                        {
                            // Mark the pick like the game's own interact path
                            // does (LevelInteractor.InteractionBegin sets it)
                            // so after-match return + quest tracking stay sane.
                            LevelInteractor.lastActiveLevelInfo = li.levelInfo;
                            Plugin.Log?.LogInfo($"[bot] transitioning to level '{li.levelInfo.sceneName}'");
                            stm.TransitionFromLevelSelectToLevel(li.levelInfo.sceneName);
                        }
                    }
                    break;
                case IntentKind.InteractLevel:
                    // The node's own interact path — opens its level-select
                    // frame (same as a player click); the frame resolver then
                    // clicks Start. Fallback for a hung sceneTransitionIsRunning.
                    if (s.NearestLevel != null && pi != null)
                    {
                        s.NearestLevel.InteractionBegin(pi);
                        Plugin.Log?.LogInfo($"[bot] level '{s.NearestLevel.name}' -> InteractionBegin (frame)");
                    }
                    break;
                case IntentKind.ClearCoinPark:
                    coinIgnore.Clear();
                    break;
            }
        }

        private static bool NearDoor(Vector3 p, Vector3[] doors, float r)
        {
            if (doors == null) return false;
            for (int i = 0; i < doors.Length; i++)
            {
                float dx = doors[i].x - p.x, dz = doors[i].z - p.z;
                if (dx * dx + dz * dz < r * r) return true;
            }
            return false;
        }

        /// <summary>Army step 1: select every FREE allied unit (door squads
        /// stay posted — their HomePosition is their door anchor).</summary>
        private static void CommandArmyAll(in BotPerception.Snapshot s)
        {
            var cu = CommandUnits.instance;
            if (cu == null) return;
            var doors = s.DoorAnchors;
            int added = 0;
            foreach (var u in TagManager.instance.PlayerUnits)
            {
                if (u == null || u.Hp == null || !u.Hp.Alive) continue;
                if (NearDoor(u.transform.position, doors, 25f)) continue;   // posted/en-route squad — leave it
                var pu0 = u.GetComponent<PathfindMovementPlayerunit>();
                if (pu0 != null && pu0.FollowingPlayer) continue;   // escorts stay on the hero —
                // the sweep kept re-holding them into churn with EscortHero
                cu.OnUnitAdd(u, false); added++;
            }
            cu.commanding = added > 0;
            Plugin.Log?.LogInfo($"[bot] commanding {added} free unit(s) (squads stay posted)");
        }

        /// <summary>Post a squad at the current door anchor REMOTELY — set
        /// each free unit's HomePosition + hold and let its own AI walk the
        /// corridor. The hero never leaves the build loop for posting trips.
        /// HoldPosition makes them engage anything within ~7 m of the door.</summary>
        private static int PlaceSquad(in BotPerception.Snapshot s)
        {
            int target = s.UncoveredDoorTarget > 0 ? s.UncoveredDoorTarget : 4;
            int posted = 0;
            // Coach/playbook RESERVE: never post the last N units — they stay
            // at the castle as the emergency garrison (field was previously
            // parsed but never consumed).
            int reserve = Mathf.Max(Coach.ReserveSize, BotPerception.Strat.Reserve);
            int postable = Mathf.Max(0, s.AllyCount - reserve);
            var units = TagManager.instance.PlayerUnits;
            for (int i = 0; i < units.Count && posted < target && posted < postable; i++)
            {
                var t = units[i];
                if (t == null || t.Hp == null || !t.Hp.Alive) continue;
                var u = t.GetComponent<PathfindMovementPlayerunit>();
                if (u == null) continue;
                if (NearDoor(u.transform.position, s.DoorAnchors, 25f)) continue;
                if (u.FollowingPlayer) continue;                       // escort stays
                float a = posted * 1.571f;
                Vector3 off = new Vector3(Mathf.Cos(a), 0f, Mathf.Sin(a)) * (1.2f + 0.4f * posted);
                u.HomePosition = s.UncoveredDoorPos + off;
                u.HasReachedHomePositionAlready = false;
                u.FollowPlayer(false);
                u.HoldPosition = true;
                posted++;
            }
            if (posted > 0)
            {
                // RL: the squad-size choice is now a USED decision.
                Policy.Commit("squad", target.ToString(),
                    s.PolicyKey ?? "", new[] { "3", "4", "5", "6", "8" });
                Plugin.Log?.LogInfo($"[bot] posted squad {posted}/{target} remotely at door '{s.UncoveredDoorLine}'");
            }
            return posted;
        }

        /// <summary>RED ALERT: an enemy is inside the ring — EVERY unit
        /// converges on the threat anchor (door squads abandon their posts,
        /// escorts drop follow). The city-line takes priority over any door.</summary>
        private static void RecallToBreach(in BotPerception.Snapshot s)
        {
            var units = TagManager.instance.PlayerUnits;
            int sent = 0;
            for (int i = 0; i < units.Count; i++)
            {
                var t = units[i];
                if (t == null || t.Hp == null || !t.Hp.Alive) continue;
                var u = t.GetComponent<PathfindMovementPlayerunit>();
                if (u == null) continue;
                float a = sent * 0.785f;
                Vector3 off = new Vector3(Mathf.Cos(a), 0f, Mathf.Sin(a)) * (1.5f + 0.3f * sent);
                u.FollowPlayer(false);
                u.HomePosition = s.ThreatAnchor + off;
                u.HasReachedHomePositionAlready = false;
                u.HoldPosition = true;
                sent++;
            }
            Plugin.Log?.LogWarning($"[bot] BREACH-RESPONSE: {sent} unit(s) converging on threat");
        }

        /// <summary>Escort: a slice of free units follows the hero through
        /// his build route — FollowPlayer, not hold — so he never fights
        /// alone inside the ring.</summary>
        private static void EscortHero(in BotPerception.Snapshot s)
        {
            int want = Coach.EscortSize > 0 ? Coach.EscortSize
                     : BotPerception.Strat.Escort > 0 ? BotPerception.Strat.Escort
                     : (s.AllyCount >= 12 ? 4 : 3);   // playbook escort honored too
            int escorts = 0;
            var units = TagManager.instance.PlayerUnits;
            for (int i = 0; i < units.Count; i++)
            {
                var t = units[i];
                if (t == null || t.Hp == null || !t.Hp.Alive) continue;
                var u = t.GetComponent<PathfindMovementPlayerunit>();
                if (u == null) continue;
                if (NearDoor(u.transform.position, s.DoorAnchors, 25f)) continue;
                bool following = u.FollowingPlayer;
                if (escorts < want && !following)
                {
                    u.HoldPosition = false;
                    u.FollowPlayer(true);
                    following = true;
                }
                if (following) escorts++;
            }
        }

        /// <summary>Army step 2: place the command set at the hero + hold.</summary>
        private static void PlaceArmy()
        {
            var cu = CommandUnits.instance;
            if (cu == null) return;
            cu.PlaceCommandedUnitsAndCalculateTargetPositions(false);
            cu.MakeUnitsInBufferHoldPosition();
            cu.commanding = false;
            Plugin.Log?.LogInfo("[bot] army placed at anchor, holding");
        }

        /// <summary>
        /// Mirror LevelSelectManager.PlayButtonPressed: apply fixedLoadout when
        /// the level has one; if the loadout was never seeded this session (the
        /// bot skips the loadout UI) arm the hero with the best unlocked
        /// weapon — otherwise he spawns weaponless and literally cannot fight.
        /// A ranged weapon is preferred so the orbit-kite play style exists.
        /// </summary>
        private static string requestedWeapon;   // sidecar mailbox loadout pin

        /// <summary>Sidecar orders a specific weapon for the next seed
        /// (name matched case-insensitively against allEquippables).</summary>
        public static void RequestLoadout(string weapon)
        {
            requestedWeapon = weapon;
        }

        private static void SeedLoadout(in BotPerception.Snapshot s)
        {
            var li = s.NearestLevel;
            var pmgr = PerkManager.instance;
            if (pmgr == null || li == null || li.levelInfo == null) return;
            if (li.levelInfo.fixedLoadout != null && li.levelInfo.fixedLoadout.Count > 0)
            {
                pmgr.CurrentlyEquipped.Clear();
                pmgr.CurrentlyEquipped.AddRange(li.levelInfo.fixedLoadout);
            }
            if (pmgr.CurrentlyEquipped.Count == 0)
            {
                // Sidecar-requested loadout takes precedence when it resolves.
                if (!string.IsNullOrEmpty(requestedWeapon))
                {
                    Equippable req = null;
                    foreach (var eq in pmgr.allEquippables)
                        if (eq is EquippableWeapon && eq.IsUnlocked &&
                            string.Equals(eq.displayName, requestedWeapon,
                                System.StringComparison.OrdinalIgnoreCase))
                        { req = eq; break; }
                    if (req != null)
                    {
                        PerkManager.SetEquipped(req, true);
                        Plugin.Log?.LogInfo($"[bot] loadout pinned by sidecar: '{req.displayName}'");
                        requestedWeapon = null;
                        return;
                    }
                    Plugin.Log?.LogWarning($"[bot] sidecar weapon '{requestedWeapon}' not found/locked — auto pick");
                    requestedWeapon = null;
                }
                string[] rangedKw = { "bow", "cross", "wand", "staff",
                    "sling", "knife", "shuriken", "chakram", "javelin",
                    "boomerang", "pistol", "rifle", "dart", "throw" };
                Equippable best = null, bestRanged = null;
                foreach (var eq in pmgr.allEquippables)
                {
                    if (!(eq is EquippableWeapon) || !eq.IsUnlocked) continue;
                    if (best == null || eq.sortingValue > best.sortingValue)
                        best = eq;
                    string nm = (eq.displayName ?? "").ToLowerInvariant();
                    bool isRanged = false;
                    foreach (var kw in rangedKw)
                        if (nm.Contains(kw)) { isRanged = true; break; }
                    if (isRanged && (bestRanged == null ||
                        eq.sortingValue > bestRanged.sortingValue))
                        bestRanged = eq;
                }
                var pick = bestRanged != null ? bestRanged : best;
                if (pick != null)
                {
                    PerkManager.SetEquipped(pick, true);
                    Plugin.Log?.LogInfo($"[bot] loadout seeded: '{pick.displayName}'" +
                        (pick == bestRanged ? " (ranged preferred)" : ""));
                }
            }
        }

        private static void ClearTarget() { hasTarget = false; engageTarget = null; ReleaseBuild(); }

        private static void ReleaseBuild()
        {
            if (heldBuild == null) return;
            // Silent releases hid the refund loop for a whole session —
            // log every release with the fill state so it's auditable.
            var pi = PlayerInteraction.instance;
            Plugin.Log?.LogInfo(
                $"[bot] hold-release '{heldBuild.name}' " +
                $"waitChoice={ChoiceManager.instance != null && ChoiceManager.instance.ChoiceCoroutineRunning}");
            if (pi != null) { heldBuild.Unfocus(pi); heldBuild.InteractionEnd(pi); }
            heldBuild = null;
            holdDoneName = "";   // reset dedup — the next same-named
                                 // building (more_barracks, wall #2) must
                                 // count too; stale name made it invisible
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
                    // Military-first choice: troops/defense branches win over
                    // economy/cosmetic ones when both are pickable.
                    Choice pick = null, milPick = null;
                    foreach (var c in cm.availableChoices)
                    {
                        if (c == null || !c.CanBePicked) continue;
                        if (pick == null) pick = c;
                        string cn = c.name ?? "";
                        if (milPick == null && (
                            cn.IndexOf("barrack", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("archer", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("militia", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("guard", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("tower", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("wall", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("knight", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("squad", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("troop", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            cn.IndexOf("soldier", System.StringComparison.OrdinalIgnoreCase) >= 0))
                            milPick = c;
                    }
                    cm.choiceToReturn = milPick ?? pick;
                    Plugin.Log?.LogInfo($"[bot] choice frame -> '{(cm.choiceToReturn != null ? cm.choiceToReturn.name : "none")}'");
                    LogLine(in s, "choice-pick");
                }
                return true;
            }

            if (frame == null || !frame.freezePlayer) { lastFrameName = ""; frameSeen = 0; return false; }
            if (frame.name != lastFrameName) { lastFrameName = frame.name; frameSeen = 0; }

            // A Choice frame mid-resolution must NOT be closed — the pick is
            // already set but the coroutine needs a beat to resume; slamming
            // the frame shut cancels the hold and refunds the fill (the
            // "never finishes upgrades" bug). Wait for the coroutine to end.
            if (cm != null && cm.ChoiceCoroutineRunning) return true;
            // And when the coroutine IS done, the frame must be CONFIRMED,
            // not closed — CloseActiveFrame() is the Escape/cancel path and
            // refunds the fill (evidence: Archery Range + Barracks never
            // completed while Gold Mine/Wall/Tower did). Apply() commits
            // the picked choice so the interactor finishes the upgrade.
            if (frame.name.IndexOf("Choice", System.StringComparison.OrdinalIgnoreCase) >= 0)
            {
                if (Time.unscaledTime >= frameActionAt)
                {
                    frameActionAt = Time.unscaledTime + 1f;
                    Plugin.Log?.LogInfo("[bot] choice frame -> Apply() (confirm)");
                    frame.Apply();
                    LogLine(in s, "choice-confirm");
                }
                return true;
            }

            // End-of-match screens carry a BackToLevelSelectHelper button and
            // are unescapable — follow it to return to the campaign map where
            // EnterLevel picks the next unbeaten node. Pause menus carry the
            // same button but ARE escapable, so they take the plain-close path
            // below instead. The frameSeen>=2 escalation is gated on AfterMatch*
            // states so a stubborn mid-run frame can never nuke the run.
            var backHelper = frame.GetComponentInChildren<BackToLevelSelectHelper>(true);
            // 'After Match Frame' survived 7+ plain closes while GameState had
            // already rolled past AfterMatch* into transition — gate on the
            // frame NAME too, not only the state string.
            if (backHelper != null && (frame.canNotBeEscaped ||
                (frameSeen >= 2 && (s.GameState.StartsWith("AfterMatch") ||
                                    frame.name.IndexOf("After Match") >= 0))))
            {
                if (Time.unscaledTime >= frameActionAt)
                {
                    frameActionAt = Time.unscaledTime + 2f;
                    // Click the game's OWN back-to-map path — Apply() fires
                    // the frame's primary action (the BackToLevelSelectHelper
                    // button), which runs the game's match-cleanup before
                    // transitioning. A raw SceneTransitionManager call
                    // skipped that cleanup: the next Durststein inherited
                    // the dead match — interactables never respawned
                    // (the inter-vacuum loop).
                    Plugin.Log?.LogInfo("[bot] end-of-match -> Apply() (back-to-map)");
                    LogLine(in s, "match-end");
                    frame.Apply();
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
            // Direct-steer window: a wrong-layer path flagged the navmesh —
            // but the hero walks FREELY (navmesh is only our helper). Steer
            // straight for the goal; hard-stuck detours handle obstacles.
            if (Time.unscaledTime < navDirectUntil)
                return goal;
            if (hasTarget) MaybeRequestPath(hero, goal);

            var p = navPath;
            if (p == null || p.vectorPath == null || p.vectorPath.Count == 0)
                return goal;
            var wp = p.vectorPath;
            // Stale path: a cached result whose first waypoint sits >15 m from
            // the hero was built for a different origin (post-snap, scene
            // edge). Following it steers the hero backward into geometry —
            // discard and let the next tick re-path from the real position.
            if (wp.Count > 0 && FlatDist(hero, wp[0]) > 15f)
            {
                navPath = null; navIndex = 0; navGoal = Vector3.zero;
                return goal;
            }
            while (navIndex < wp.Count - 1 && FlatDist(hero, wp[navIndex]) < 1.4f) navIndex++;
            navIndex = Mathf.Min(navIndex, wp.Count - 1);
            var last = wp[wp.Count - 1];
            // Degenerate path: the navmesh snapped the whole route onto where
            // the hero already stands — steering at it gives DesiredDir≈0 →
            // standing still forever. Fall back to the raw goal.
            if (navIndex == wp.Count - 1 && FlatDist(hero, last) < 0.8f)
                return goal;
            // FOLLOW the routed path even when its tail stops short of the
            // goal — the old "last wp >2.5 m from goal → beeline" skipped the
            // entire route and steered the hero straight into the cliff/wall
            // the path had routed around (the pin-the-building bug). Only the
            // final waypoint's gap gets a straight finish.
            navSteerArrive = navIndex == wp.Count - 1 ? arriveDist : 0.5f;
            if (navIndex < wp.Count - 1) return wp[navIndex];
            // At the last waypoint: if it lands on the goal, hold arrive-dist;
            // else it's the navmesh's "closest reachable" — beeline the small
            // remaining gap.
            return FlatDist(last, goal) <= 2.5f ? last : goal;
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
                    var last = done.vectorPath[done.vectorPath.Count - 1];
                    // Wrong-layer path: the navmesh resolved to an elevated
                    // route (hero on a wall top, slot below — move-diag showed
                    // y=13.49 paths to y≈0 goals). Grinding produced only
                    // stuck-strikes; flag it so the watchdog parks instantly.
                    navWrongLayer = Mathf.Abs(last.y - goal.y) > 2.5f;
                    navPath = done;
                    navIndex = 0;
                    navDiagCount++;
                    if (navDiagCount <= 20)
                        Plugin.Log?.LogInfo($"[bot] nav-path ok: {done.vectorPath.Count} wp -> {goal}" +
                            (navWrongLayer ? " [wrong-layer]" : ""));
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

        private static string FormatTickJson(in BotPerception.Snapshot s, string note)
        {
            return string.Format(CultureInfo.InvariantCulture,
                "{{\"t\":{0:0.00},\"mode\":\"{1}\",\"state\":\"{2}\",\"scene\":\"{3}\",\"night\":{4},\"wave\":\"{5}/{6}\",\"foes\":{7},\"coins\":{8},\"gold\":{9},\"hp\":{10:0.###},\"pos\":[{11:0.#},{12:0.#}],\"ls\":{13},\"lvln\":{14},\"inter\":{15},\"lvld\":{16:0.#},\"horn\":{17},\"hd\":{18:0.#},\"bld\":{19},\"nf\":{20},\"note\":\"{21}\"}}",
                Time.unscaledTime, Mode, s.GameState, s.SceneName,
                s.IsNight ? "true" : "false",
                s.Wave, s.WaveTotal, s.EnemyCount, s.CoinCount, s.Balance,
                s.HeroHpPct, s.HeroPos.x, s.HeroPos.z,
                s.OnLevelSelect ? "true" : "false", s.LevelCount, s.InteractorCount, s.NearestLevelDist,
                s.HasHorn ? "true" : "false", s.HornDist, s.BuildCount, s.EnemiesNearHero, note);
        }

        private static string lastEvtNote; private static float lastEvtAt;

        internal static void LogLine(in BotPerception.Snapshot s, string note)
        {
            EnsureLog();
            // Event stream + derived counters feed the recorder regardless of
            // the main log being available. "tick" is the 4 Hz heartbeat —
            // it belongs in ticks.jsonl, not the event stream. Identical
            // notes flood at ~4 Hz (invalid ×80, hero-door ×18) — collapse
            // repeats to one entry per 4 s; counters still count every one.
            if (note != "tick")
            {
                if (note == lastEvtNote && Time.unscaledTime - lastEvtAt < 4f) { }
                else { Recorder.Event(note); lastEvtNote = note; lastEvtAt = Time.unscaledTime; }
            }
            if (note == "snap")
            {
                Recorder.CountSnap();
                Recorder.NoteAnchor(s.SceneName, s.HeroPos.x, s.HeroPos.z, "wedge");
            }
            else if (note.StartsWith("unstick")) Recorder.CountUnstick();
            else if (note == "build-stall" || note == "coin-stall") Recorder.CountStall();
            if (botLog == null) return;
            try
            {
                botLog.WriteLine(FormatTickJson(in s, note));
            }
            catch { }
        }
    }
}
