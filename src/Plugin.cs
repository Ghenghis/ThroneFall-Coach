using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using BepInEx;
using BepInEx.Configuration;
using BepInEx.Logging;
using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Shared cheat state, read by both the overlay and the Harmony patches.
    /// Persisted via BepInEx config so toggles survive restarts.
    /// </summary>
    public static class Cheats
    {
        // Protection
        public static bool GodHero;
        public static bool GodAll;
        public static bool InstantRevive;

        // Economy
        public static bool FreeBuild;
        public static bool GoldDrip;
        public static bool InstantBuild;
        public static bool CoinMagnet;
        public static float MagnetRadius = 250f;

        // Combat
        public static bool InstantKill;
        public static bool DamageMultEnabled;
        public static float DamageMultiplier = 10f;
        public static bool NoCooldown;
        public static bool AttackSpeedEnabled;
        public static float AttackSpeedMult = 2f;
        public static bool RegenEnabled;
        public static float RegenMult = 5f;
        public static bool MultiShotEnabled;
        public static int MultiShotCount = 3;

        // Enemies
        public static bool EnemySpeedEnabled;
        public static float EnemySpeedMult = 1f;
        public static bool EnemyDamageEnabled;
        public static float EnemyDamageMult = 1f;
        public static bool EnemyHpEnabled;
        public static float EnemyHpMult = 1f;
        public static bool EndlessWaves;

        // Army
        public static bool CommandRangeEnabled;
        public static float CommandRange = 500f;
        public static bool FastRespawn;
        public static bool AllyDmgEnabled;
        public static float AllyDmgMult = 5f;
        public static bool AllyAspdEnabled;
        public static float AllyAspdMult = 3f;

        // World / time
        public static bool MoveSpeedEnabled;
        public static float MoveSpeedMult = 2f;
        public static bool GameSpeedEnabled;
        public static float GameSpeedMult = 2f;
        public static bool EndlessDay;
        public static bool ZoomEnabled;
        public static float ZoomMult = 1.5f;
        public static bool NeverLose;
        public static bool RevealMap;
    }

    [BepInPlugin(GUID, "Thronefall Trainer", Version)]
    public class Plugin : BaseUnityPlugin
    {
        public const string GUID = "dev.thronefall.trainer";
        public const string Version = "3.0.0";   // must parse as System.Version — "3.0.0-dev" got the plugin skipped by BepInEx

        internal static ManualLogSource Log;

        // ---- persisted settings ----
        private ConfigEntry<bool> cfgGodHero, cfgGodAll, cfgInstantRevive,
            cfgFreeBuild, cfgGoldDrip, cfgInstantBuild, cfgMagnet,
            cfgInstantKill, cfgDmgEnabled, cfgNoCooldown, cfgAtkSpdEnabled, cfgRegenEnabled,
            cfgMultiShot, cfgAllyDmgEnabled, cfgAllyAspdEnabled,
            cfgEnemySpdEnabled, cfgEnemyDmgEnabled, cfgEnemyHpEnabled, cfgEndlessWaves,
            cfgCmdRangeEnabled, cfgFastRespawn,
            cfgMoveEnabled, cfgSpeedEnabled, cfgEndlessDay, cfgZoomEnabled,
            cfgNeverLose, cfgRevealMap, cfgBotEnabled, cfgBotCheats;
        private ConfigEntry<bool> cfgCoach, cfgCoachVision, cfgCoachLive;
        private ConfigEntry<string> cfgCoachUrl, cfgCoachModel, cfgCoachKey, cfgCoachVModel;
        private ConfigEntry<float> cfgMagnetRadius, cfgDmgMult, cfgAtkSpdMult, cfgRegenMult,
            cfgEnemySpdMult, cfgEnemyDmgMult, cfgEnemyHpMult, cfgCmdRange,
            cfgMoveMult, cfgSpeedMult, cfgZoomMult,
            cfgMultiShotCount, cfgAllyDmgMult, cfgAllyAspdMult,
            cfgOpacity;
        private ConfigEntry<int> cfgTheme;
        private ConfigEntry<int> cfgGoldGrant;
        private ConfigEntry<bool> cfgLiveEnabled;
        private ConfigEntry<int> cfgLivePort, cfgLiveWidth, cfgLiveFps;
        private ConfigEntry<string> cfgLiveFlip;
        private ConfigEntry<bool> cfgPerfEnabled;
        internal static int GoldGrant;   // cfg mirrored at apply

        // ---- reflection handles ----
        private static readonly FieldInfo BalanceField =
            typeof(PlayerInteraction).GetField("balance", BindingFlags.NonPublic | BindingFlags.Instance);
        private static readonly FieldInfo CoresField =
            typeof(PlayerInteraction).GetField("energyCoreBalance", BindingFlags.NonPublic | BindingFlags.Instance);
        private static readonly FieldInfo DayTimeField =
            typeof(DayNightCycle).GetField("remainingAutoDayTime", BindingFlags.NonPublic | BindingFlags.Instance);
        private static readonly FieldInfo ZoomLevelsField =
            typeof(CameraRig).GetField("zoomLevels", BindingFlags.NonPublic | BindingFlags.Instance);

        // ---- overlay state ----
        private bool showMenu;
        private bool collapsed;
        private bool resizing;
        private bool playerFrozenByUs;
        private Rect windowRect = new Rect(20f, 20f, 380f, 620f);
        private const float MinW = 300f, MinH = 200f, CollapsedH = 48f;
        private float expandedHeight = 620f;
        private Vector2 scroll;
        private GUIStyle sectionStyle;
        private bool settingsOpen;
        private float uiOpacity = 1f;
        private int themeIndex;
        private string alphaText = "1";
        private GUISkin skin;
        private int builtTheme = -1;
        private readonly List<Texture2D> themeTex = new List<Texture2D>();

        private struct Theme
        {
            public Color bg, panel, button, hover, accent, text;
            public Theme(float bg, float panel, float button, float hover,
                         float ar, float ag, float ab, float tr, float tg, float tb)
            {
                this.bg = C(bg, bg, bg); this.panel = C(panel, panel, panel);
                this.button = C(button, button, button); this.hover = C(hover, hover, hover);
                this.accent = new Color(ar, ag, ab); this.text = new Color(tr, tg, tb);
            }
            private static Color C(float r, float g, float b) => new Color(r, g, b, 0.96f);
        }

        private static readonly Theme[] Themes =
        {
            //            bg    panel  button hover  accent        text
            new Theme(0.13f, 0.18f, 0.24f, 0.32f, 0.85f,0.70f,0.25f, 1f,1f,1f),      // Dark + gold accent
            new Theme(0.16f, 0.22f, 0.28f, 0.38f, 0.95f,0.75f,0.20f, 1f,0.95f,0.8f), // Thronefall Gold
            new Theme(0.13f, 0.18f, 0.25f, 0.34f, 0.62f,0.45f,0.95f, 0.95f,0.92f,1f),// Arcane purple
            new Theme(0.10f, 0.16f, 0.22f, 0.32f, 0.35f,0.80f,0.45f, 0.9f,1f,0.92f), // Forest green
            new Theme(0.16f, 0.22f, 0.28f, 0.38f, 0.95f,0.42f,0.20f, 1f,0.92f,0.88f),// Ember red
            new Theme(0.10f, 0.16f, 0.24f, 0.34f, 0.40f,0.75f,0.95f, 0.92f,0.97f,1f),// Ice blue
        };
        private static readonly string[] ThemeNames = { "Dark", "Gold", "Arcane", "Forest", "Ember", "Ice" };

        // ---- text field buffers ----
        private string goldText = "", coresText = "";
        private string dmgText = "10", moveText = "2", speedText = "2", magnetText = "250",
            atkSpdText = "2", regenText = "5", enemySpdText = "1", enemyDmgText = "1",
            enemyHpText = "1", cmdRangeText = "500", zoomText = "1.5",
            multiShotText = "3", allyDmgText = "5", allyAspdText = "3";

        // ---- cached originals / instances ----
        private PlayerMovement cachedPM;
        private float origSpeed, origSpeedDay, origSprint, origSprintDay;
        private float origMagnet = -1f;
        private bool magnetWasOn, gameSpeedWasOn;
        private PlayerInteraction cachedPI;   // magnet capture is per-instance

        private ManualAttack[] heroAttacks;
        private readonly Dictionary<int, float> origCooldownTimes = new Dictionary<int, float>();

        private readonly Dictionary<int, float> origEnemySpeeds = new Dictionary<int, float>();
        private float enemyTick;

        private PlayerUpgradeManager cachedPUM;
        private float origRegenMult = 1f;
        private bool regenWasOn;

        private AutoRevive cachedAutoRevive;
        private float origReviveTime = 20f;
        private bool reviveWasOn;

        private CommandUnits cachedCmd;
        private float origAttractRange;
        private bool cmdRangeWasOn;

        private bool fastRespawnWasOn;
        private float origRespawnMulti = 1f;

        private BlacksmithUpgrades cachedBlacksmith;
        private float origMeleeDmg = 1f, origRangedDmg = 1f;
        private bool allyDmgWasOn;
        private readonly Dictionary<int, float> origAllyCooldowns = new Dictionary<int, float>();
        private bool allyAspdWasOn;

        private CameraRig cachedCamRig;
        private float[] origZoomLevels;
        private bool zoomWasOn;

        private readonly Dictionary<int, Vector2> origVisionScales = new Dictionary<int, Vector2>();
        private bool revealWasOn;

        private void Awake()
        {
            Log = Logger;
            BindConfig();
            new Harmony(GUID).PatchAll();
            Logger.LogInfo("Thronefall Trainer loaded. Press F1 to open the overlay.");
        }

        private void BindConfig()
        {
            cfgGodHero        = Config.Bind("Protection", "GodHero",          false);
            cfgGodAll         = Config.Bind("Protection", "GodAll",           false);
            cfgInstantRevive  = Config.Bind("Protection", "InstantRevive",    false);

            cfgFreeBuild      = Config.Bind("Economy",    "FreeBuild",        false);
        cfgGoldDrip       = Config.Bind("Economy",    "GoldDrip",         false);
        cfgCoach          = Config.Bind("Coach",      "Enabled",          true);
        cfgCoachVision    = Config.Bind("Coach",      "VisionEnabled",    false);
        cfgCoachLive      = Config.Bind("Coach",      "LiveShot",         true);
        cfgCoachVModel    = Config.Bind("Coach",      "VisionModel",      "qwen3-vl-2b-thinking-abliterated");
        cfgCoachUrl       = Config.Bind("Coach",      "Url",              "http://127.0.0.1:1234/v1/chat/completions");
        cfgCoachModel     = Config.Bind("Coach",      "Model",            "kat-coder-v2.5-dev-apex");
        cfgCoachKey       = Config.Bind("Coach",      "ApiKey",           "");
            cfgInstantBuild   = Config.Bind("Economy",    "InstantBuild",     false);
            cfgMagnet         = Config.Bind("Economy",    "CoinMagnet",       false);
            cfgMagnetRadius   = Config.Bind("Economy",    "MagnetRadius",     250f);
            cfgGoldGrant      = Config.Bind("Economy",    "GoldGrant",        0);

            cfgInstantKill    = Config.Bind("Combat",     "InstantKill",      false);
            cfgDmgEnabled     = Config.Bind("Combat",     "DamageMultEnabled",false);
            cfgDmgMult        = Config.Bind("Combat",     "DamageMultiplier", 10f);
            cfgNoCooldown     = Config.Bind("Combat",     "NoCooldown",       false);
            cfgAtkSpdEnabled  = Config.Bind("Combat",     "AttackSpeedEnabled", false);
            cfgAtkSpdMult     = Config.Bind("Combat",     "AttackSpeedMult",  2f);
            cfgRegenEnabled   = Config.Bind("Combat",     "RegenEnabled",     false);
            cfgRegenMult      = Config.Bind("Combat",     "RegenMult",        5f);
            cfgMultiShot      = Config.Bind("Combat",     "MultiShot",        false);
            cfgMultiShotCount = Config.Bind("Combat",     "MultiShotCount",   3f);

            cfgEnemySpdEnabled  = Config.Bind("Enemies",  "EnemySpeedEnabled",  false);
            cfgEnemySpdMult     = Config.Bind("Enemies",  "EnemySpeedMult",   1f);
            cfgEnemyDmgEnabled  = Config.Bind("Enemies",  "EnemyDamageEnabled", false);
            cfgEnemyDmgMult     = Config.Bind("Enemies",  "EnemyDamageMult",  1f);
            cfgEnemyHpEnabled   = Config.Bind("Enemies",  "EnemyHpEnabled",   false);
            cfgEnemyHpMult      = Config.Bind("Enemies",  "EnemyHpMult",      1f);
            cfgEndlessWaves     = Config.Bind("Enemies",  "EndlessWaves",     false);

            cfgCmdRangeEnabled  = Config.Bind("Army",     "CommandRangeEnabled", false);
            cfgCmdRange         = Config.Bind("Army",     "CommandRange",     500f);
            cfgFastRespawn      = Config.Bind("Army",     "FastRespawn",      false);
            cfgAllyDmgEnabled   = Config.Bind("Army",     "AllyDmgEnabled",   false);
            cfgAllyDmgMult      = Config.Bind("Army",     "AllyDmgMult",      5f);
            cfgAllyAspdEnabled  = Config.Bind("Army",     "AllyAspdEnabled",  false);
            cfgAllyAspdMult     = Config.Bind("Army",     "AllyAspdMult",     3f);
            cfgNeverLose        = Config.Bind("Protection","NeverLose",       false);
            cfgRevealMap        = Config.Bind("Camera",   "RevealMap",        false);
            cfgBotEnabled       = Config.Bind("Bot",      "AutopilotEnabled", false);
            // Default LEGIT — fresh installs must not arm the cheat bundle;
            // the user's standing rule is "no trainer cheats" in autopilot.
            cfgBotCheats        = Config.Bind("Bot",      "BotSurvivalCheats", false);
            cfgOpacity          = Config.Bind("Overlay",  "Opacity",          1f);
            cfgTheme            = Config.Bind("Overlay",  "ThemeIndex",       0);
            cfgLiveEnabled      = Config.Bind("Live",     "Enabled",          true,   "Stream the game's own rendered frames to livecap (tools/livecap.py) over 127.0.0.1 (live.v1). Costs next to nothing while livecap is not running.");
            cfgLivePort         = Config.Bind("Live",     "Port",             8095,   "livecap's ingest port (TCP, loopback only).");
            cfgLiveWidth        = Config.Bind("Live",     "Width",            1280,   "Width in pixels of the streamed frames, 320-1920 (the height follows the window's aspect). livecap can override this at runtime.");
            cfgLiveFps          = Config.Bind("Live",     "Fps",              30,     "Frames per second to capture, 5-60. livecap can override this at runtime.");
            cfgLiveFlip         = Config.Bind("Live",     "FlipY",            "auto", "auto = detect once whether the capture comes out upside down and correct it; on / off = force a vertical flip.");
            cfgPerfEnabled      = Config.Bind("Perf",     "Enabled",          true,   "Frame-time instrumentation (perf.v1): agent/perf.json once a second, agent/perf-stalls.jsonl for frames over 100 ms. Costs a few microseconds per frame.");

            cfgMoveEnabled    = Config.Bind("Movement",   "MoveSpeedEnabled", false);
            cfgMoveMult       = Config.Bind("Movement",   "MoveSpeedMult",    2f);
            cfgSpeedEnabled   = Config.Bind("Time",       "GameSpeedEnabled", false);
            cfgSpeedMult      = Config.Bind("Time",       "GameSpeedMult",    2f);
            cfgEndlessDay     = Config.Bind("Time",       "EndlessDay",       false);
            cfgZoomEnabled    = Config.Bind("Camera",     "ZoomEnabled",      false);
            cfgZoomMult       = Config.Bind("Camera",     "ZoomMult",         1.5f);

            Cheats.GodHero = cfgGodHero.Value;             Cheats.GodAll = cfgGodAll.Value;
            Cheats.InstantRevive = cfgInstantRevive.Value;
            Cheats.FreeBuild = cfgFreeBuild.Value;         Cheats.GoldDrip = cfgGoldDrip.Value;
        Coach.Enabled = cfgCoach.Value; Coach.Url = cfgCoachUrl.Value;
        Coach.Model = cfgCoachModel.Value; Coach.ApiKey = cfgCoachKey.Value;
        Coach.VisionEnabled = cfgCoachVision.Value; Coach.VisionModel = cfgCoachVModel.Value;
        Coach.LiveShot = cfgCoachLive.Value;
        Coach.Init(this);
        LiveLink.Enabled = cfgLiveEnabled.Value; LiveLink.Port = cfgLivePort.Value;
        LiveLink.CfgWidth = cfgLiveWidth.Value; LiveLink.CfgFps = cfgLiveFps.Value; LiveLink.FlipMode = cfgLiveFlip.Value;
        LiveLink.Init(this);                         // in-game frame stream to livecap (live.v1); does nothing when [Live] Enabled=false
        FramePerf.Init(cfgPerfEnabled.Value);        // frame-time instrumentation (perf.v1)
        gameObject.AddComponent<Overlay>();          // F1 in-game panel
        Cheats.InstantBuild = cfgInstantBuild.Value;
            Cheats.CoinMagnet = cfgMagnet.Value;           Cheats.MagnetRadius = cfgMagnetRadius.Value;
            GoldGrant = cfgGoldGrant.Value;
            magnetText = Fmt(Cheats.MagnetRadius);
            Cheats.InstantKill = cfgInstantKill.Value;     Cheats.DamageMultEnabled = cfgDmgEnabled.Value;
            Cheats.DamageMultiplier = cfgDmgMult.Value;    dmgText = Fmt(Cheats.DamageMultiplier);
            Cheats.NoCooldown = cfgNoCooldown.Value;
            Cheats.AttackSpeedEnabled = cfgAtkSpdEnabled.Value;
            Cheats.AttackSpeedMult = cfgAtkSpdMult.Value;  atkSpdText = Fmt(Cheats.AttackSpeedMult);
            Cheats.RegenEnabled = cfgRegenEnabled.Value;
            Cheats.RegenMult = cfgRegenMult.Value;         regenText = Fmt(Cheats.RegenMult);
            Cheats.MultiShotEnabled = cfgMultiShot.Value;
            Cheats.MultiShotCount = (int)cfgMultiShotCount.Value; multiShotText = Fmt(Cheats.MultiShotCount);
            Cheats.EnemySpeedEnabled = cfgEnemySpdEnabled.Value;
            Cheats.EnemySpeedMult = cfgEnemySpdMult.Value; enemySpdText = Fmt(Cheats.EnemySpeedMult);
            Cheats.EnemyDamageEnabled = cfgEnemyDmgEnabled.Value;
            Cheats.EnemyDamageMult = cfgEnemyDmgMult.Value; enemyDmgText = Fmt(Cheats.EnemyDamageMult);
            Cheats.EnemyHpEnabled = cfgEnemyHpEnabled.Value;
            Cheats.EnemyHpMult = cfgEnemyHpMult.Value;     enemyHpText = Fmt(Cheats.EnemyHpMult);
            Cheats.EndlessWaves = cfgEndlessWaves.Value;
            Cheats.CommandRangeEnabled = cfgCmdRangeEnabled.Value;
            Cheats.CommandRange = cfgCmdRange.Value;       cmdRangeText = Fmt(Cheats.CommandRange);
            Cheats.FastRespawn = cfgFastRespawn.Value;
            Cheats.AllyDmgEnabled = cfgAllyDmgEnabled.Value;
            Cheats.AllyDmgMult = cfgAllyDmgMult.Value;     allyDmgText = Fmt(Cheats.AllyDmgMult);
            Cheats.AllyAspdEnabled = cfgAllyAspdEnabled.Value;
            Cheats.AllyAspdMult = cfgAllyAspdMult.Value;   allyAspdText = Fmt(Cheats.AllyAspdMult);
            Cheats.MoveSpeedEnabled = cfgMoveEnabled.Value;
            Cheats.MoveSpeedMult = cfgMoveMult.Value;      moveText = Fmt(Cheats.MoveSpeedMult);
            Cheats.GameSpeedEnabled = cfgSpeedEnabled.Value;
            Cheats.GameSpeedMult = cfgSpeedMult.Value;     speedText = Fmt(Cheats.GameSpeedMult);
            Cheats.EndlessDay = cfgEndlessDay.Value;
            Cheats.ZoomEnabled = cfgZoomEnabled.Value;
            Cheats.ZoomMult = cfgZoomMult.Value;           zoomText = Fmt(Cheats.ZoomMult);
            Cheats.NeverLose = cfgNeverLose.Value;
            Cheats.RevealMap = cfgRevealMap.Value;
            SetBotEnabled(cfgBotEnabled.Value);
            uiOpacity = Mathf.Clamp(cfgOpacity.Value, 0.2f, 1f);
            themeIndex = Mathf.Clamp(cfgTheme.Value, 0, Themes.Length - 1);
            alphaText = Fmt(uiOpacity);
        }

        private static string Fmt(float v) => v.ToString("0.##", CultureInfo.InvariantCulture);

        // =====================================================================
        //  Per-frame cheat logic
        // =====================================================================
        private void Update()
        {
            FramePerf.BeginFrame();
            // Re-read every frame: a runtime edit of BotSurvivalCheats via the
            // config manager used to leave Bot.Legit stale — true→false kept
            // F2–F5 armed in what had become legit mode.
            Bot.Legit = !cfgBotCheats.Value;
            if (Input.GetKeyDown(KeyCode.F1)) ToggleMenu();
            // LEGIT-MODE GATE: F2–F5 are direct cheat injects (kill/gold/
            // teleport) — they must NEVER fire while the autopilot is
            // playing legitimately. The Bot's own cheat intents are gated
            // the same way; the hotkeys weren't (audit #1).
            if (!Bot.Enabled || !Bot.Legit)
            {
                if (Input.GetKeyDown(KeyCode.F2)) KillAllEnemies();
                if (Input.GetKeyDown(KeyCode.F3)) ReviveAll();
                if (Input.GetKeyDown(KeyCode.F4)) AddGold(100);
                if (Input.GetKeyDown(KeyCode.F5)) TeleportToMouse();
            }
            if (Input.GetKeyDown(KeyCode.F6)) SetBotEnabled(!Bot.Enabled);

            var pi = PlayerInteraction.instance;
            var pm = PlayerMovement.instance;

            // A throwing cheat (reflection, torn game state) must NEVER starve
            // the autopilot — the old code skipped Bot.Tick on exception and
            // silently stalled the run while the broken cheat stayed enabled.
            try
            {

            // ---- Free build: spending is patched to a no-op, but the pay loop
            // also requires Balance > 0, so keep a floor of 1 in each currency.
            if (Cheats.FreeBuild && pi != null &&
                BalanceField != null && CoresField != null)
            {
                if (pi.Balance < 1)
                    BalanceField.SetValue(pi, 1);
                if (pi.EnergyCoreBalance < 1)
                    CoresField.SetValue(pi, 1);
            }

            // ---- Gold drip (bot-tuning aid): pin the wallet so the strategy
            // loop can be validated without the economy bottleneck. OFF by
            // default — legit autopilot never enables it. Hard-gated: wallet
            // injection is a cheat, not strategy tuning.
            if (Cheats.GoldDrip && pi != null && !(Bot.Enabled && Bot.Legit))
            {
                if (pi.Balance < 500) SetGold(500);
                if (pi.EnergyCoreBalance < 20) SetCores(20);
            }

            // ---- Move speed (re-derive originals when the instance changes).
            if (pm != cachedPM)
            {
                cachedPM = pm;
                cachedAutoRevive = null; // re-resolve below
                heroAttacks = null;
                if (cachedPM != null)
                {
                    origSpeed = cachedPM.speed;
                    origSpeedDay = cachedPM.speedDuringDay;
                    origSprint = cachedPM.sprintSpeed;
                    origSprintDay = cachedPM.sprintSpeedDuringDay;
                }
            }
            if (cachedPM != null)
            {
                float m = Cheats.MoveSpeedEnabled ? Cheats.MoveSpeedMult : 1f;
                cachedPM.speed = origSpeed * m;
                cachedPM.speedDuringDay = origSpeedDay * m;
                cachedPM.sprintSpeed = origSprint * m;
                cachedPM.sprintSpeedDuringDay = origSprintDay * m;
            }

            // ---- No cooldown + attack speed on every ManualAttack under the hero
            // (equipped weapon plus ability components like LightningWandMA).
            if (cachedPM != null && heroAttacks == null)
                heroAttacks = cachedPM.GetComponentsInChildren<ManualAttack>(true);
            if (heroAttacks != null)
            {
                foreach (var ma in heroAttacks)
                {
                    if (ma == null) continue;
                    int id = ma.GetInstanceID();
                    if (!origCooldownTimes.TryGetValue(id, out float origCd))
                    {
                        origCd = ma.cooldownTime;
                        origCooldownTimes[id] = origCd;
                    }
                    ma.cooldownTime = Cheats.AttackSpeedEnabled ? origCd / Mathf.Max(0.05f, Cheats.AttackSpeedMult) : origCd;
                    if (Cheats.NoCooldown)
                        ma.Cooldown = 0f;
                }
            }

            // ---- HP regen multiplier.
            if (PlayerUpgradeManager.instance != cachedPUM)
            {
                if (regenWasOn && cachedPUM != null)
                    cachedPUM.PlayerHealthRegenerationMultiplyer = origRegenMult;
                cachedPUM = PlayerUpgradeManager.instance;
                if (cachedPUM != null)
                    origRegenMult = cachedPUM.PlayerHealthRegenerationMultiplyer;
            }
            if (cachedPUM != null)
            {
                if (Cheats.RegenEnabled)
                {
                    regenWasOn = true;
                    cachedPUM.PlayerHealthRegenerationMultiplyer = origRegenMult * Cheats.RegenMult;
                }
                else if (regenWasOn)
                {
                    regenWasOn = false;
                    cachedPUM.PlayerHealthRegenerationMultiplyer = origRegenMult;
                }
            }

            // ---- Instant revive (AutoRevive sits on the hero).
            if (cachedPM != null && cachedAutoRevive == null)
            {
                cachedAutoRevive = cachedPM.GetComponentInChildren<AutoRevive>(true);
                if (cachedAutoRevive != null)
                    origReviveTime = cachedAutoRevive.reviveAfterBeingKnockedOutFor;
            }
            if (cachedAutoRevive != null)
            {
                if (Cheats.InstantRevive)
                {
                    reviveWasOn = true;
                    cachedAutoRevive.reviveAfterBeingKnockedOutFor = 0.05f;
                }
                else if (reviveWasOn)
                {
                    reviveWasOn = false;
                    cachedAutoRevive.reviveAfterBeingKnockedOutFor = origReviveTime;
                }
            }

            // ---- Game speed.
            if (Cheats.GameSpeedEnabled)
            {
                gameSpeedWasOn = true;
                if (Time.timeScale > 0f)
                    Time.timeScale = Cheats.GameSpeedMult;
            }
            else if (gameSpeedWasOn)
            {
                gameSpeedWasOn = false;
                Time.timeScale = PlayerMovement.gameplayTimeScale;
            }

            // ---- Coin magnet (per-instance capture — a scene reload swaps
            // in a NEW PlayerInteraction; restoring the old instance's radius
            // over its real default was the audit's stale-restore bug).
            if (pi != cachedPI)
            {
                cachedPI = pi;
                if (pi != null) origMagnet = pi.coinMagnetRadius;
            }
            if (Cheats.CoinMagnet && pi != null)
            {
                magnetWasOn = true;
                pi.coinMagnetRadius = Cheats.MagnetRadius;
            }
            else if (magnetWasOn)
            {
                magnetWasOn = false;
                if (pi != null && origMagnet >= 0f)
                    pi.coinMagnetRadius = origMagnet;
            }

            // ---- Command range (grab units from across the map).
            if (CommandUnits.instance != cachedCmd)
            {
                if (cmdRangeWasOn && cachedCmd != null)
                    cachedCmd.attractRange = origAttractRange;
                cachedCmd = CommandUnits.instance;
                if (cachedCmd != null)
                    origAttractRange = cachedCmd.attractRange;
            }
            if (cachedCmd != null)
            {
                if (Cheats.CommandRangeEnabled)
                {
                    cmdRangeWasOn = true;
                    cachedCmd.attractRange = Cheats.CommandRange;
                }
                else if (cmdRangeWasOn)
                {
                    cmdRangeWasOn = false;
                    cachedCmd.attractRange = origAttractRange;
                }
            }

            // ---- Fast unit respawn.
            if (BlacksmithUpgrades.instance != null)
            {
                if (Cheats.FastRespawn)
                {
                    if (!fastRespawnWasOn)
                    {
                        fastRespawnWasOn = true;
                        origRespawnMulti = BlacksmithUpgrades.instance.unitRespawnSpeedMulti;
                    }
                    BlacksmithUpgrades.instance.unitRespawnSpeedMulti = origRespawnMulti * 50f;
                }
                else if (fastRespawnWasOn)
                {
                    fastRespawnWasOn = false;
                    BlacksmithUpgrades.instance.unitRespawnSpeedMulti = origRespawnMulti;
                }
            }

            // ---- Ally damage: melee/ranged multipliers are sampled per-hit in
            // Weapon.cs, so writing them here buffs every player weapon live.
            if (BlacksmithUpgrades.instance != cachedBlacksmith)
            {
                if (allyDmgWasOn && cachedBlacksmith != null)
                {
                    cachedBlacksmith.meleeDamage = origMeleeDmg;
                    cachedBlacksmith.rangedDamage = origRangedDmg;
                }
                cachedBlacksmith = BlacksmithUpgrades.instance;
                if (cachedBlacksmith != null)
                {
                    origMeleeDmg = cachedBlacksmith.meleeDamage;
                    origRangedDmg = cachedBlacksmith.rangedDamage;
                }
            }
            if (cachedBlacksmith != null)
            {
                if (Cheats.AllyDmgEnabled)
                {
                    allyDmgWasOn = true;
                    cachedBlacksmith.meleeDamage = origMeleeDmg * Cheats.AllyDmgMult;
                    cachedBlacksmith.rangedDamage = origRangedDmg * Cheats.AllyDmgMult;
                }
                else if (allyDmgWasOn)
                {
                    allyDmgWasOn = false;
                    cachedBlacksmith.meleeDamage = origMeleeDmg;
                    cachedBlacksmith.rangedDamage = origRangedDmg;
                }
            }

            // ---- Endless day: hold the automated day timer up.
            if (Cheats.EndlessDay && DayNightCycle.Instance != null &&
                DayTimeField != null &&
                DayNightCycle.Instance.CurrentTimestate == DayNightCycle.Timestate.Day &&
                DayNightCycle.Instance.AutomatedDaytime)
            {
                DayTimeField.SetValue(DayNightCycle.Instance, 999999f);
            }

            // ---- Endless waves toggle mirrors onto the live spawner.
            if (EnemySpawner.instance != null &&
                EnemySpawner.instance.InfinitelySpawning != Cheats.EndlessWaves)
            {
                EnemySpawner.instance.InfinitelySpawning = Cheats.EndlessWaves;
            }

            // ---- Zoom: scale the rig's zoom-level table (each notch × mult).
            if (Cheats.ZoomEnabled || zoomWasOn)
            {
                if (cachedCamRig == null)
                {
                    cachedCamRig = Object.FindObjectOfType<CameraRig>();
                    origZoomLevels = null;
                }
                if (cachedCamRig != null && ZoomLevelsField != null)
                {
                    var levels = (float[])ZoomLevelsField.GetValue(cachedCamRig);
                    if (origZoomLevels == null && levels != null)
                        origZoomLevels = (float[])levels.Clone();
                    if (origZoomLevels != null && levels != null)
                    {
                        float zm = Cheats.ZoomEnabled ? Cheats.ZoomMult : 1f;
                        for (int i = 0; i < levels.Length && i < origZoomLevels.Length; i++)
                            levels[i] = origZoomLevels[i] * zm;
                        zoomWasOn = Cheats.ZoomEnabled;
                    }
                }
            }

            // ---- Reveal map: blow up every fog-of-war vision source radius.
            // (Ticked together with enemy speed at ~4 Hz; FindObjectsOfType is
            // too heavy for every frame.)
            enemyTick += Time.unscaledDeltaTime;
            if (enemyTick >= 0.25f)
            {
                enemyTick = 0f;
                ApplyEnemySpeed();
                ApplyRevealMap();
                ApplyAllyAttackSpeed();
            }

            }
            catch (System.Exception ex)
            {
                Log?.LogWarning($"[plugin] Update cheat section threw: {ex.Message}");
            }

            // ---- Autopilot: decides + steers at 4 Hz; movement is injected
            // via the MoveScript prefix in BotPatches.cs.
            long fpBot = FramePerf.Now();
            try { Bot.Tick(); }
            catch (System.Exception ex)
            { Log?.LogWarning($"[bot] Tick threw: {ex.Message}"); }
            FramePerf.Mark(FramePerf.SecBot, fpBot);
            FramePerf.EndFrame();
        }

        /// <summary>Scale cooldownDuration on every PlayerOwned AutoAttack (troops + towers).</summary>
        private void ApplyAllyAttackSpeed()
        {
            var tm = TagManager.instance;
            if (tm == null) return;
            float mult = Cheats.AllyAspdEnabled ? Mathf.Max(0.05f, Cheats.AllyAspdMult) : 1f;

            void ApplyTo(AutoAttack aa)
            {
                int id = aa.GetInstanceID();
                if (!origAllyCooldowns.TryGetValue(id, out float orig))
                {
                    orig = aa.cooldownDuration;
                    origAllyCooldowns[id] = orig;
                }
                aa.cooldownDuration = orig / mult;
            }

            foreach (var t in tm.PlayerUnits)
            {
                if (t == null) continue;
                foreach (var aa in t.GetComponentsInChildren<AutoAttack>(true))
                    ApplyTo(aa);
            }
            foreach (var bi in tm.playerBuildingInteractors)
            {
                if (bi == null) continue;
                foreach (var aa in bi.GetComponentsInChildren<AutoAttack>(true))
                {
                    var owner = aa.GetComponentInParent<TaggedObject>();
                    if (owner == null || owner.Contains(TagManager.ETag.PlayerOwned))
                        ApplyTo(aa);
                }
            }
            allyAspdWasOn = Cheats.AllyAspdEnabled;
        }

        private void ApplyRevealMap()
        {
            if (!Cheats.RevealMap && !revealWasOn)
                return;
            foreach (var vs in Object.FindObjectsOfType<KB.FogRTS.Runtime.VisionSource>())
            {
                if (vs == null) continue;
                int vid = vs.GetInstanceID();
                if (Cheats.RevealMap)
                {
                    revealWasOn = true;
                    if (!origVisionScales.ContainsKey(vid))
                        origVisionScales[vid] = vs.Scale;
                    vs.Scale = new Vector2(99999f, 99999f);
                }
                else if (origVisionScales.TryGetValue(vid, out Vector2 orig))
                {
                    vs.Scale = orig;
                }
            }
            if (!Cheats.RevealMap)
            {
                revealWasOn = false;
                origVisionScales.Clear();
            }
        }

        private void ApplyEnemySpeed()
        {
            var tm = TagManager.instance;
            if (tm == null) return;

            if (!Cheats.EnemySpeedEnabled)
            {
                // Restore originals on the live list where possible.
                foreach (var t in tm.EnemyUnits)
                {
                    if (t == null) continue;
                    var mv = t.GetComponent<PathfindMovementEnemy>();
                    if (mv != null && origEnemySpeeds.TryGetValue(mv.GetInstanceID(), out float orig))
                        mv.movementSpeed = orig;
                }
                origEnemySpeeds.Clear();
                return;
            }

            var live = new HashSet<int>();
            foreach (var t in tm.EnemyUnits)
            {
                if (t == null) continue;
                var mv = t.GetComponent<PathfindMovementEnemy>();
                if (mv == null) continue;
                int id = mv.GetInstanceID();
                live.Add(id);
                if (!origEnemySpeeds.TryGetValue(id, out float orig))
                {
                    orig = mv.movementSpeed;
                    origEnemySpeeds[id] = orig;
                }
                mv.movementSpeed = orig * Cheats.EnemySpeedMult;
            }
            // Forget entries for enemies that no longer exist.
            foreach (var id in new List<int>(origEnemySpeeds.Keys))
            {
                if (!live.Contains(id))
                    origEnemySpeeds.Remove(id);
            }
        }

        private void ToggleMenu()
        {
            showMenu = !showMenu;
            // Freeze the hero while the menu is open so keystrokes typed into
            // the text fields don't steer the character or trigger attacks.
            // RESTORE only OUR freeze — a game frame (level-up/pause) that
            // froze the player while the menu was open used to get clobbered
            // by the unconditional unfreeze (audit round 7).
            if (LocalGamestate.Instance != null)
            {
                if (showMenu)
                {
                    LocalGamestate.Instance.SetPlayerFreezeState(true);
                    playerFrozenByUs = true;
                }
                else if (playerFrozenByUs)
                {
                    LocalGamestate.Instance.SetPlayerFreezeState(false);
                    playerFrozenByUs = false;
                }
            }
        }

        private void CloseMenu()
        {
            if (showMenu)
                ToggleMenu();
        }

        /// <summary>F6 / overlay toggle: turn the autopilot on or off and persist it.</summary>
        private void SetBotEnabled(bool v)
        {
            // Bundle ON  → bot may use cheat-adjacent mechanics (teleport
            // nudges, direct Attack() calls, damage fallback). Bundle OFF →
            // Bot.Legit: the autopilot stays inside player rules.
            Bot.Legit = !cfgBotCheats.Value;
            Bot.SetEnabled(v);
            cfgBotEnabled.Value = v;
            ApplyBotSurvivalCheats(v);
        }

        // ---- bot survival-cheat snapshot ----
        private bool botCheatsActive;
        private bool svGodHero, svGodAll, svInstantRevive, svNeverLose, svRegen, svMagnet, svInstantKill, svNoCooldown;
        private float svRegenMult, svMagnetRadius;

        /// <summary>
        /// While the autopilot runs, force the survival cheat set so the bot
        /// can't die: god hero + god player-owned (castle/units/buildings),
        /// instant revive as backup, never-lose so the run can't end, strong HP
        /// regen, and a wide coin magnet to boost collection. Prior states are
        /// restored when the bot is switched off. Disable via Bot/BotSurvivalCheats.
        /// </summary>
        private void ApplyBotSurvivalCheats(bool on)
        {
            if (!cfgBotCheats.Value) return;
            if (on)
            {
                svGodHero = Cheats.GodHero;             svGodAll = Cheats.GodAll;
                svInstantRevive = Cheats.InstantRevive; svNeverLose = Cheats.NeverLose;
                svRegen = Cheats.RegenEnabled;          svRegenMult = Cheats.RegenMult;
                svMagnet = Cheats.CoinMagnet;           svMagnetRadius = Cheats.MagnetRadius;
                svInstantKill = Cheats.InstantKill;     svNoCooldown = Cheats.NoCooldown;
                botCheatsActive = true;

                Cheats.GodHero = true; Cheats.GodAll = true;
                Cheats.InstantRevive = true; Cheats.NeverLose = true;
                Cheats.RegenEnabled = true; Cheats.RegenMult = 20f;
                Cheats.CoinMagnet = true;
                Cheats.MagnetRadius = Mathf.Max(Cheats.MagnetRadius, 500f);
                // Instant-kill so the bot clears waves instead of tanking 40+
                // foes one swing at a time — otherwise nights stall with the
                // hero standing in melee range looking idle.
                Cheats.InstantKill = true;
                // No-cooldown so every pumped attack press lands immediately —
                // paired with InstantKill the hero clears a whole mob per swing.
                Cheats.NoCooldown = true;
                Log?.LogInfo("[bot] survival cheats ON: god hero+all, instant revive, never-lose, regen x20, magnet 500, instant-kill, no-cooldown");
            }
            else if (botCheatsActive)
            {
                botCheatsActive = false;
                // Conditional restore: only roll back flags that still equal
                // what WE forced — a user who flipped a toggle mid-run used
                // to lose that choice to the stale snapshot.
                if (Cheats.GodHero) Cheats.GodHero = svGodHero;
                if (Cheats.GodAll) Cheats.GodAll = svGodAll;
                if (Cheats.InstantRevive) Cheats.InstantRevive = svInstantRevive;
                if (Cheats.NeverLose) Cheats.NeverLose = svNeverLose;
                if (Cheats.RegenEnabled) { Cheats.RegenEnabled = svRegen; Cheats.RegenMult = svRegenMult; }
                if (Cheats.CoinMagnet) { Cheats.CoinMagnet = svMagnet; Cheats.MagnetRadius = svMagnetRadius; }
                if (Cheats.InstantKill) Cheats.InstantKill = svInstantKill;
                if (Cheats.NoCooldown) Cheats.NoCooldown = svNoCooldown;
                Log?.LogInfo("[bot] survival cheats restored to previous state");
            }
        }

        private void OnDestroy()
        {
            Bot.Shutdown();
            LiveLink.Shutdown();
            if (playerFrozenByUs && LocalGamestate.Instance != null)
                LocalGamestate.Instance.SetPlayerFreezeState(false);
            if (gameSpeedWasOn)
                Time.timeScale = PlayerMovement.gameplayTimeScale;
        }

        // =====================================================================
        //  Actions
        // =====================================================================
        private void AddGold(int amount)
        {
            var pi = PlayerInteraction.instance;
            if (pi != null)
                pi.AddCoin(amount);
        }

        private void SetGold(int value)
        {
            var pi = PlayerInteraction.instance;
            if (pi == null || BalanceField == null) return;
            int delta = value - pi.Balance;
            BalanceField.SetValue(pi, value);
            if (delta > 0) pi.onBalanceGain.Invoke(delta);
            else if (delta < 0) pi.onBalanceSpend.Invoke(-delta);
        }

        private void SetCores(int value)
        {
            var pi = PlayerInteraction.instance;
            if (pi == null || CoresField == null) return;
            int delta = value - pi.EnergyCoreBalance;
            CoresField.SetValue(pi, value);
            if (delta > 0) pi.onEnergyCoreBalanceGain.Invoke(delta);
            else if (delta < 0) pi.onEnergyCoreBalanceSpend.Invoke(-delta);
        }

        private void KillAllEnemies()
        {
            if (TagManager.instance != null)
                Hp.KillAllEnemyUnits();
        }

        private void ReviveAll()
        {
            if (TagManager.instance != null && PerkManager.instance != null)
                Hp.ReviveAllKnockedOutPlayerUnitsAndBuildings();
        }

        private void HalveEnemyHp()
        {
            var tm = TagManager.instance;
            if (tm == null) return;
            foreach (var t in tm.EnemyUnits)
            {
                if (t != null && t.Hp != null)
                    t.Hp.SetHpTo(t.Hp.HpValue * 0.5f);
            }
        }

        private void SkipWave()
        {
            if (EnemySpawner.instance != null)
                EnemySpawner.instance.DebugSkipWave();
        }

        private void StopSpawning()
        {
            if (EnemySpawner.instance != null)
                EnemySpawner.instance.StopSpawnAfterWaveAndReset();
        }

        private void StartNight()
        {
            if (DayNightCycle.Instance != null)
                DayNightCycle.Instance.SwitchToNight();
        }

        private void BackToDay()
        {
            if (DayNightCycle.Instance != null)
                DayNightCycle.Instance.SwithToDay();
        }

        /// <summary>
        /// Flip every enemy to the player's side: retag it PlayerOwned and
        /// rewrite its move/attack target priorities to hunt EnemyOwned.
        /// (TargetPriority lists are serialized per-component, so mutating them
        /// only affects that unit.) Note: retagged enemies leave the enemy
        /// count, so an all-charm mid-spawn can end the wave early.
        /// </summary>
        private void CharmAllEnemies()
        {
            var tm = TagManager.instance;
            if (tm == null) return;
            var snapshot = new List<TaggedObject>(tm.EnemyUnits);
            foreach (var t in snapshot)
            {
                if (t == null) continue;
                t.RemoveTag(TagManager.ETag.EnemyOwned);
                t.AddTag(TagManager.ETag.PlayerOwned);

                foreach (var aa in t.GetComponentsInChildren<AutoAttack>(true))
                {
                    foreach (var tp in aa.targetPriorities)
                    {
                        tp.mustHaveTags.Clear();
                        tp.mustHaveTags.Add(TagManager.ETag.EnemyOwned);
                        tp.mayNotHaveTags.Remove(TagManager.ETag.EnemyOwned);
                        tp.mayNotHaveTags.Add(TagManager.ETag.PlayerOwned);
                    }
                }
                foreach (var mv in t.GetComponentsInChildren<PathfindMovementEnemy>(true))
                {
                    mv.agroTimeWhenAttackedByPlayer = 0f;
                    foreach (var tp in mv.targetPriorities)
                    {
                        tp.mustHaveTags.Clear();
                        tp.mustHaveTags.Add(TagManager.ETag.EnemyOwned);
                    }
                }
            }
        }

        private void HarvestAll()
        {
            var tm = TagManager.instance;
            var pi = PlayerInteraction.instance;
            if (tm == null || pi == null) return;
            foreach (var bi in tm.playerBuildingInteractors)
            {
                if (bi == null) continue;
                bi.SetHarvested(false);
                bi.Harvest(pi);
            }
        }

        private void CoinFountain(int amount)
        {
            var pi = PlayerInteraction.instance;
            if (pi == null) return;
            foreach (var spawner in CoinSpawner.allCoinSpawners)
            {
                if (spawner != null && spawner.gameObject.activeInHierarchy)
                {
                    spawner.TriggerCoinSpawn(amount, pi);
                    return;
                }
            }
        }

        private void TeleportToMouse()
        {
            var pm = PlayerMovement.instance;
            var cam = Camera.main;
            if (pm == null || cam == null)
                return;
            var ray = cam.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out RaycastHit hit, 2000f))
                pm.TeleportTo(hit.point);
        }

        private void SpawnNextWave()
        {
            if (EnemySpawner.instance != null)
                EnemySpawner.instance.StartSpawning();
        }

        private void WinLevel()
        {
            if (LocalGamestate.Instance != null &&
                LocalGamestate.Instance.CurrentState == LocalGamestate.State.InMatch)
            {
                LocalGamestate.Instance.SetState(LocalGamestate.State.AfterMatchVictory);
            }
        }

        private void MaxAllBuildSlots()
        {
            foreach (var slot in Object.FindObjectsOfType<BuildSlot>())
            {
                try { slot.DEBUGUpgradeToMax(); }
                catch (System.Exception e) { Log.LogWarning($"DEBUGUpgradeToMax failed on {slot?.name}: {e.Message}"); }
            }
        }

        private void CloneTroops(int count)
        {
            var tm = TagManager.instance;
            var pm = PlayerMovement.instance;
            if (tm == null || pm == null) return;

            var pool = new List<TaggedObject>();
            foreach (var t in tm.PlayerUnits)
            {
                if (t != null && t.Hp != null && !t.Hp.KnockedOut)
                    pool.Add(t);
            }
            if (pool.Count == 0)
            {
                Log.LogWarning("Clone troops: no living player units found to clone.");
                return;
            }
            for (int i = 0; i < count; i++)
            {
                var src = pool[UnityEngine.Random.Range(0, pool.Count)];
                Vector3 pos = pm.transform.position +
                              Quaternion.Euler(0f, UnityEngine.Random.Range(0f, 360f), 0f) * Vector3.forward * 3f;
                try
                {
                    var clone = Object.Instantiate(src.gameObject, pos, Quaternion.identity);
                    var mv = clone.GetComponent<PathfindMovementPlayerunit>();
                    if (mv != null)
                    {
                        mv.HomePosition = pos;
                        mv.SnapToNavmesh();
                    }
                }
                catch (System.Exception e)
                {
                    Log.LogWarning($"Clone failed: {e.Message}");
                }
            }
        }

        // ---- Meta / progression (writes the persistent save file) ----
        private void UnlockAllLevels()
        {
            var lpm = LevelProgressManager.instance;
            if (lpm == null || lpm.levelInfos == null) return;
            foreach (var li in lpm.levelInfos)
            {
                if (li == null || string.IsNullOrEmpty(li.sceneName))
                    continue;
                var d = lpm.GetLevelDataForScene(li.sceneName);
                if (d == null)
                    continue;
                d.beatenBest = true;
                if (d.highscoreBest < 9999999)
                    d.highscoreBest = 9999999;
                // Empty loadout entry satisfies every BeatTheLevelWithout quest.
                d.levelHasBeenBeatenWith.Add(new List<Equippable>());
                // Each BeatTheLevelWith quest needs an entry containing its required gear.
                foreach (var q in li.quests)
                {
                    if (q != null && q.questType == Quest.EType.BeatTheLevelWith &&
                        q.beatTheLevelWith != null && q.beatTheLevelWith.Count > 0)
                    {
                        d.levelHasBeenBeatenWith.Add(new List<Equippable>(q.beatTheLevelWith));
                    }
                }
            }
            try { SaveLoadManager.instance?.SaveGame(); }
            catch (System.Exception e) { Log.LogWarning($"SaveGame failed: {e.Message}"); }
        }

        private void UnlockAllPerks()
        {
            var pmgr = PerkManager.instance;
            if (pmgr == null) return;
            pmgr.level = PerkManager.MaxLevel;
            try { SaveLoadManager.instance?.SaveGame(); }
            catch (System.Exception e) { Log.LogWarning($"SaveGame failed: {e.Message}"); }
        }

        private void AddScore(int amount)
        {
            if (ScoreManager.Instance != null)
                ScoreManager.Instance.AddDebugPoints(amount);
        }

        /// <summary>
        /// Force-equip every perk & mutator. Effects sampled dynamically
        /// (per-hit/per-frame getters) apply immediately; perks that cached
        /// state at Start just won't retro-apply until next run.
        /// </summary>
        private void EquipAllPerks()
        {
            var pmgr = PerkManager.instance;
            if (pmgr == null) return;
            foreach (var eq in pmgr.allEquippables)
            {
                if (eq is EquippablePerk || eq is EquippableMutation)
                {
                    try { PerkManager.SetEquipped(eq, true); }
                    catch (System.Exception e) { Log.LogWarning($"SetEquipped({eq?.name}) failed: {e.Message}"); }
                }
            }
        }

        private void UnlockAllAchievements()
        {
            try
            {
                foreach (AchievementManager.Achievements a in
                         System.Enum.GetValues(typeof(AchievementManager.Achievements)))
                {
                    AchievementManager.UnlockAchievement(a);
                }
            }
            catch (System.Exception e) { Log.LogWarning($"UnlockAchievement failed: {e.Message}"); }
        }

        private void ChargeAllShrines()
        {
            foreach (var s in Object.FindObjectsOfType<Shrine>())
            {
                if (s != null)
                {
                    try { s.MakeProgressAndUpdateBar(99999f); }
                    catch (System.Exception e) { Log.LogWarning($"Shrine charge failed: {e.Message}"); }
                }
            }
        }

        // =====================================================================
        //  Overlay (Unity IMGUI)
        // =====================================================================
        private Texture2D Solid(Color c)
        {
            var t = new Texture2D(1, 1, TextureFormat.RGBA32, false);
            t.SetPixel(0, 0, c);
            t.Apply();
            t.hideFlags = HideFlags.HideAndDontSave;
            themeTex.Add(t);
            return t;
        }

        private GUIStyle Flat(GUIStyle src, Color normal, Color hover, Color active, Color text)
        {
            var s = new GUIStyle(src);
            s.normal.background = Solid(normal);
            s.hover.background = Solid(hover);
            s.active.background = Solid(active);
            s.focused.background = Solid(hover);
            s.onNormal.background = Solid(active);
            s.onHover.background = Solid(hover);
            s.onActive.background = Solid(active);
            s.onFocused.background = Solid(active);
            s.normal.textColor = text; s.hover.textColor = text; s.active.textColor = text;
            s.focused.textColor = text; s.onNormal.textColor = text; s.onHover.textColor = text;
            s.onActive.textColor = text; s.onFocused.textColor = text;
            return s;
        }

        /// <summary>Rebuild the overlay skin whenever the theme changes (lazy, OnGUI only).</summary>
        private void EnsureSkin()
        {
            if (skin != null && builtTheme == themeIndex)
                return;
            foreach (var t in themeTex) Object.Destroy(t);
            themeTex.Clear();
            builtTheme = themeIndex;
            sectionStyle = null; // rebuilt from the new skin on next Section()

            var th = Themes[themeIndex];
            var def = GUI.skin;
            skin = ScriptableObject.CreateInstance<GUISkin>();

            skin.window = Flat(def.window, th.bg, th.bg, th.bg, th.accent);
            skin.box = Flat(def.box, th.panel, th.panel, th.panel, th.text);
            skin.label = new GUIStyle(def.label) { };
            skin.label.normal.textColor = th.text;
            skin.button = Flat(def.button, th.button, th.hover, th.accent, th.text);
            skin.textField = Flat(def.textField, th.panel, th.panel, th.accent, th.text);
            skin.horizontalSlider = Flat(def.horizontalSlider, th.panel, th.panel, th.panel, th.text);
            skin.horizontalSliderThumb = Flat(def.horizontalSliderThumb, th.button, th.hover, th.accent, th.text);
            // Keep default toggle/scrollbar art (checkmark textures); just tint text.
            skin.toggle = new GUIStyle(def.toggle);
            skin.toggle.normal.textColor = th.text;
            skin.toggle.hover.textColor = th.text;
            skin.toggle.active.textColor = th.text;
            skin.toggle.onNormal.textColor = th.accent;
            skin.toggle.onHover.textColor = th.accent;
            skin.toggle.onActive.textColor = th.accent;
        }

        private void OnGUI()
        {
            if (!showMenu)
                return;

            EnsureSkin();
            var prevSkin = GUI.skin;
            if (skin != null) GUI.skin = skin;
            GUI.color = new Color(1f, 1f, 1f, uiOpacity);

            // Clamp on-screen (handles resolution changes between sessions).
            windowRect.x = Mathf.Clamp(windowRect.x, -windowRect.width + 60f, Screen.width - 60f);
            windowRect.y = Mathf.Clamp(windowRect.y, 0f, Screen.height - 30f);

            // Corner-drag resize, tracked in screen space so it keeps working
            // even when the cursor leaves the window mid-drag.
            var e = Event.current;
            var gripScreen = new Rect(windowRect.xMax - 26f, windowRect.yMax - 26f, 26f, 26f);
            if (e.type == EventType.MouseDown && e.button == 0 && gripScreen.Contains(e.mousePosition))
            {
                resizing = true;
                e.Use();
            }
            else if (e.type == EventType.MouseDrag && resizing)
            {
                windowRect.width = Mathf.Clamp(e.mousePosition.x - windowRect.x + 9f, MinW, Screen.width - windowRect.x);
                float minH = collapsed ? CollapsedH : MinH;
                windowRect.height = Mathf.Clamp(e.mousePosition.y - windowRect.y + 9f, minH, Screen.height - windowRect.y);
                e.Use();
            }
            else if (e.type == EventType.MouseUp)
            {
                resizing = false;
            }

            // A DrawWindow throw must not leak GUI.skin/color corruption to
            // every other plugin's OnGUI — restore in finally.
            try
            {
                windowRect = GUI.Window(0x7A11, windowRect, DrawWindow, "Thronefall Trainer");
            }
            catch (System.Exception ex)
            {
                Log?.LogWarning($"[plugin] DrawWindow threw: {ex.Message}");
            }
            finally
            {
                GUI.color = Color.white;
                GUI.skin = prevSkin;
            }
        }

        private static bool EnterPressed()
        {
            var e = Event.current;
            return e.type == EventType.KeyDown &&
                   (e.keyCode == KeyCode.Return || e.keyCode == KeyCode.KeypadEnter);
        }

        private static bool EnterOn(string controlName)
        {
            return EnterPressed() && GUI.GetNameOfFocusedControl() == controlName;
        }

        private void Section(string title)
        {
            if (sectionStyle == null)
            {
                sectionStyle = new GUIStyle(GUI.skin.label) { fontStyle = FontStyle.Bold };
            }
            GUILayout.Space(4f);
            GUILayout.Label(title, sectionStyle);
        }

        /// <summary>Toggle that mirrors into a persisted config entry.</summary>
        private void ConfigToggle(ConfigEntry<bool> entry, string label, ref bool field)
        {
            bool v = GUILayout.Toggle(field, " " + label);
            if (v != field)
            {
                field = v;
                entry.Value = v;
            }
        }

        /// <summary>
        /// "label | slider | text field | value" row. Dragging the slider applies
        /// live; typing + Enter while the field is focused also applies.
        /// </summary>
        private void SliderRow(string controlName, string label, ref string text,
                               float min, float max, float current,
                               System.Action<float> apply, ConfigEntry<float> persist)
        {
            GUILayout.BeginHorizontal();
            GUILayout.Label(label, GUILayout.Width(105));

            float sliderVal = GUILayout.HorizontalSlider(current, min, max, GUILayout.MinWidth(60));
            GUI.SetNextControlName(controlName);
            string newText = GUILayout.TextField(text, GUILayout.Width(48));
            if (newText != text)
                text = newText;
            GUILayout.Label("x" + Fmt(current), GUILayout.Width(40));
            GUILayout.EndHorizontal();

            if (Mathf.Abs(sliderVal - current) > 0.001f)
            {
                apply(sliderVal);
                text = Fmt(sliderVal);
                if (persist != null) persist.Value = sliderVal;
            }
            else if (EnterOn(controlName) &&
                     float.TryParse(text, NumberStyles.Float, CultureInfo.InvariantCulture, out float parsed))
            {
                parsed = Mathf.Clamp(parsed, min, max);
                apply(parsed);
                if (persist != null) persist.Value = parsed;
            }
        }

        /// <summary>label | text field | Set — applies on Set or Enter while focused.</summary>
        private void IntRow(string controlName, string label, ref string text, System.Action<int> apply)
        {
            GUILayout.BeginHorizontal();
            GUILayout.Label(label, GUILayout.Width(105));
            GUI.SetNextControlName(controlName);
            text = GUILayout.TextField(text, GUILayout.Width(60));
            if ((GUILayout.Button("Set", GUILayout.Width(38)) || EnterOn(controlName)) &&
                int.TryParse(text, out int v))
            {
                apply(v);
            }
            GUILayout.EndHorizontal();
        }

        private void DrawWindow(int id)
        {
            // Title-bar row: settings + collapse + close buttons.
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            if (!collapsed && GUILayout.Button("S", GUILayout.Width(24)))
                settingsOpen = !settingsOpen;
            if (GUILayout.Button(collapsed ? "+" : "-", GUILayout.Width(24)))
            {
                collapsed = !collapsed;
                if (collapsed)
                {
                    expandedHeight = windowRect.height;
                    windowRect.height = CollapsedH;
                }
                else
                {
                    windowRect.height = expandedHeight;
                }
            }
            if (GUILayout.Button("x", GUILayout.Width(24)))
                CloseMenu();
            GUILayout.EndHorizontal();

            if (!collapsed && settingsOpen)
            {
                Section("-- OVERLAY SETTINGS --");
                SliderRow("alphaField", "Opacity", ref alphaText, 0.2f, 1f, uiOpacity,
                          v => uiOpacity = v, cfgOpacity);
                GUILayout.Label("Theme: " + ThemeNames[themeIndex]);
                int pick = GUILayout.SelectionGrid(themeIndex, ThemeNames, 3);
                if (pick != themeIndex)
                {
                    themeIndex = pick;
                    cfgTheme.Value = pick;
                }
                if (GUILayout.Button("Reset window position"))
                    windowRect = new Rect(20f, 20f, 380f, 620f);
                if (GUILayout.Button("< Back to cheats"))
                    settingsOpen = false;
            }
            else if (!collapsed)
            {
                scroll = GUILayout.BeginScrollView(scroll);

                var pi = PlayerInteraction.instance;

                // LEGIT-MODE GATE (GUI): the same lock the F2–F5 keys honor.
                // Every button below injects a cheat — they used to bypass
                // the gate entirely, so the autopilot's "legit" mode could
                // be silently broken by a stray click. Bot toggle stays
                // enabled below so the user can always disengage.
                bool legitLocked = Bot.Enabled && Bot.Legit;
                if (legitLocked)
                {
                    GUILayout.Label("<i>Cheats locked — autopilot is playing legit. Disable bot (F6) to unlock.</i>");
                    GUI.enabled = false;
                }

                // ---------------- Resources ----------------
                Section("-- RESOURCES --");
                IntRow("goldField", "Gold: " + (pi != null ? pi.Balance.ToString() : "n/a"), ref goldText, SetGold);
                GUILayout.BeginHorizontal();
                GUILayout.Label("", GUILayout.Width(105));
                if (GUILayout.Button("+100", GUILayout.Width(52))) AddGold(100);
                if (GUILayout.Button("+1k", GUILayout.Width(42))) AddGold(1000);
                if (GUILayout.Button("+10k", GUILayout.Width(45))) AddGold(10000);
                GUILayout.EndHorizontal();
                IntRow("coresField", "Cores: " + (pi != null ? pi.EnergyCoreBalance.ToString() : "n/a"), ref coresText, SetCores);

                // ---------------- Protection ----------------
                Section("-- PROTECTION --");
                ConfigToggle(cfgGodHero, "God mode - hero", ref Cheats.GodHero);
                ConfigToggle(cfgGodAll, "God mode - units & buildings", ref Cheats.GodAll);
                ConfigToggle(cfgInstantRevive, "Instant hero revive", ref Cheats.InstantRevive);
                ConfigToggle(cfgRegenEnabled, "HP regen multiplier", ref Cheats.RegenEnabled);
                SliderRow("regenField", "   regen", ref regenText, 0f, 100f, Cheats.RegenMult,
                          v => Cheats.RegenMult = v, cfgRegenMult);

                // ---------------- Economy ----------------
                Section("-- ECONOMY --");
                ConfigToggle(cfgFreeBuild, "Free build (no coin/core cost)", ref Cheats.FreeBuild);
                ConfigToggle(cfgGoldDrip, "Gold drip (pin wallet 500 — bot tuning)", ref Cheats.GoldDrip);
                ConfigToggle(cfgInstantBuild, "Instant build (fast pay fill)", ref Cheats.InstantBuild);
                ConfigToggle(cfgMagnet, "Coin magnet", ref Cheats.CoinMagnet);
                SliderRow("magnetField", "   radius", ref magnetText, 10f, 2000f, Cheats.MagnetRadius,
                          v => Cheats.MagnetRadius = v, cfgMagnetRadius);
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Harvest all income")) HarvestAll();
                if (GUILayout.Button("Coin fountain x100")) CoinFountain(100);
                if (GUILayout.Button("Charge shrines")) ChargeAllShrines();
                GUILayout.EndHorizontal();

                // ---------------- Combat ----------------
                Section("-- COMBAT --");
                ConfigToggle(cfgDmgEnabled, "Damage multiplier", ref Cheats.DamageMultEnabled);
                SliderRow("dmgField", "   multiplier", ref dmgText, 1f, 1000f, Cheats.DamageMultiplier,
                          v => Cheats.DamageMultiplier = v, cfgDmgMult);
                ConfigToggle(cfgInstantKill, "Instant kill (one hit)", ref Cheats.InstantKill);
                ConfigToggle(cfgAtkSpdEnabled, "Attack speed multiplier", ref Cheats.AttackSpeedEnabled);
                SliderRow("atkSpdField", "   multiplier", ref atkSpdText, 0.25f, 20f, Cheats.AttackSpeedMult,
                          v => Cheats.AttackSpeedMult = v, cfgAtkSpdMult);
                ConfigToggle(cfgNoCooldown, "No ability/attack cooldown", ref Cheats.NoCooldown);
                ConfigToggle(cfgMultiShot, "Multi-shot (all player weapons)", ref Cheats.MultiShotEnabled);
                SliderRow("multiShotField", "   projectiles", ref multiShotText, 1f, 15f, Cheats.MultiShotCount,
                          v => Cheats.MultiShotCount = (int)v, cfgMultiShotCount);

                // ---------------- Enemies ----------------
                Section("-- ENEMIES --");
                ConfigToggle(cfgEnemySpdEnabled, "Enemy speed (0 = frozen)", ref Cheats.EnemySpeedEnabled);
                SliderRow("enemySpdField", "   speed", ref enemySpdText, 0f, 3f, Cheats.EnemySpeedMult,
                          v => Cheats.EnemySpeedMult = v, cfgEnemySpdMult);
                ConfigToggle(cfgEnemyDmgEnabled, "Enemy damage (0 = harmless)", ref Cheats.EnemyDamageEnabled);
                SliderRow("enemyDmgField", "   damage", ref enemyDmgText, 0f, 2f, Cheats.EnemyDamageMult,
                          v => Cheats.EnemyDamageMult = v, cfgEnemyDmgMult);
                ConfigToggle(cfgEnemyHpEnabled, "Enemy HP at spawn", ref Cheats.EnemyHpEnabled);
                SliderRow("enemyHpField", "   hp", ref enemyHpText, 0.1f, 3f, Cheats.EnemyHpMult,
                          v => Cheats.EnemyHpMult = v, cfgEnemyHpMult);
                ConfigToggle(cfgEndlessWaves, "Endless waves (wave repeats)", ref Cheats.EndlessWaves);
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Kill all enemies")) KillAllEnemies();
                if (GUILayout.Button("Charm all enemies")) CharmAllEnemies();
                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Halve enemy HP")) HalveEnemyHp();
                if (GUILayout.Button("Stop spawning")) StopSpawning();
                GUILayout.EndHorizontal();
                if (GUILayout.Button("Revive all units & buildings")) ReviveAll();

                // ---------------- Army ----------------
                Section("-- ARMY --");
                ConfigToggle(cfgCmdRangeEnabled, "Command range (grab all)", ref Cheats.CommandRangeEnabled);
                SliderRow("cmdRangeField", "   range", ref cmdRangeText, 10f, 5000f, Cheats.CommandRange,
                          v => Cheats.CommandRange = v, cfgCmdRange);
                ConfigToggle(cfgFastRespawn, "Fast unit respawn", ref Cheats.FastRespawn);
                ConfigToggle(cfgAllyDmgEnabled, "Ally damage multiplier", ref Cheats.AllyDmgEnabled);
                SliderRow("allyDmgField", "   damage", ref allyDmgText, 1f, 50f, Cheats.AllyDmgMult,
                          v => Cheats.AllyDmgMult = v, cfgAllyDmgMult);
                ConfigToggle(cfgAllyAspdEnabled, "Ally attack speed (troops+towers)", ref Cheats.AllyAspdEnabled);
                SliderRow("allyAspdField", "   speed", ref allyAspdText, 0.5f, 20f, Cheats.AllyAspdMult,
                          v => Cheats.AllyAspdMult = v, cfgAllyAspdMult);
                if (GUILayout.Button("Clone a random troop x5")) CloneTroops(5);
                if (GUILayout.Button("Build/upgrade ALL slots (free)")) MaxAllBuildSlots();

                // ---------------- World / time ----------------
                Section("-- WORLD / TIME --");
                ConfigToggle(cfgMoveEnabled, "Move speed multiplier", ref Cheats.MoveSpeedEnabled);
                SliderRow("moveField", "   multiplier", ref moveText, 0.25f, 8f, Cheats.MoveSpeedMult,
                          v => Cheats.MoveSpeedMult = v, cfgMoveMult);
                ConfigToggle(cfgSpeedEnabled, "Game speed (speedhack)", ref Cheats.GameSpeedEnabled);
                SliderRow("speedField", "   multiplier", ref speedText, 0.1f, 10f, Cheats.GameSpeedMult,
                          v => Cheats.GameSpeedMult = v, cfgSpeedMult);
                ConfigToggle(cfgEndlessDay, "Endless day (freeze timer)", ref Cheats.EndlessDay);
                ConfigToggle(cfgZoomEnabled, "Zoom multiplier", ref Cheats.ZoomEnabled);
                SliderRow("zoomField", "   zoom", ref zoomText, 0.5f, 4f, Cheats.ZoomMult,
                          v => Cheats.ZoomMult = v, cfgZoomMult);
                ConfigToggle(cfgRevealMap, "Reveal map (remove fog)", ref Cheats.RevealMap);
                ConfigToggle(cfgNeverLose, "Never lose (defeat blocked)", ref Cheats.NeverLose);
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Teleport to mouse [F5]")) TeleportToMouse();
                if (GUILayout.Button("Spawn next wave")) SpawnNextWave();
                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Skip wave")) SkipWave();
                if (GUILayout.Button("Start night")) StartNight();
                if (GUILayout.Button("Back to day")) BackToDay();
                GUILayout.EndHorizontal();
                if (GUILayout.Button("Win level (instant victory)")) WinLevel();

                // ---------------- Meta / progression ----------------
                Section("-- META (writes save file) --");
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Unlock all levels & crowns")) UnlockAllLevels();
                if (GUILayout.Button("Unlock all perks/gear")) UnlockAllPerks();
                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                if (GUILayout.Button("Equip ALL perks (mid-run)")) EquipAllPerks();
                if (GUILayout.Button("Unlock achievements")) UnlockAllAchievements();
                GUILayout.EndHorizontal();
                if (GUILayout.Button("+1,000,000 score")) AddScore(1000000);

                if (legitLocked) GUI.enabled = true;   // Bot toggle stays live

                Section("Bot");
                bool botOn = GUILayout.Toggle(Bot.Enabled, " Autopilot (F6)");
                if (botOn != Bot.Enabled) SetBotEnabled(botOn);
                GUILayout.Label("  " + Bot.Status);

                GUILayout.FlexibleSpace();
                GUILayout.Label($"F1 menu | F2 kill | F3 revive | F4 +100g | F5 tp | F6 bot | F8 panel  v{Version}");

                GUILayout.EndScrollView();
            }

            // Resize grip drawn at bottom-right corner; drag logic lives in
            // OnGUI (screen space) so drags keep working outside the window.
            var grip = new Rect(windowRect.width - 26f, windowRect.height - 26f, 26f, 26f);
            GUI.Box(grip, "=");
            // Only the title bar moves the window (leaves the corner free for
            // the resize grip and the right end free for the S/-/x buttons).
            GUI.DragWindow(new Rect(0f, 0f, windowRect.width - 84f, 24f));
        }
    }
}
