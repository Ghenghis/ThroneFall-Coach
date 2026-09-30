using System;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using BepInEx;
using BepInEx.Configuration;
using BepInEx.Logging;
using HarmonyLib;
using KB.FogRTS.Runtime;
using UnityEngine;

namespace ThronefallTrainer;

[BepInPlugin("dev.thronefall.trainer", "Thronefall Trainer", "3.0.0")]
public class Plugin : BaseUnityPlugin
{
	private struct Theme(float bg, float panel, float button, float hover, float ar, float ag, float ab, float tr, float tg, float tb)
	{
		public Color bg = C(bg, bg, bg);

		public Color panel = C(panel, panel, panel);

		public Color button = C(button, button, button);

		public Color hover = C(hover, hover, hover);

		public Color accent = new Color(ar, ag, ab);

		public Color text = new Color(tr, tg, tb);

		private static Color C(float r, float g, float b)
		{
			//IL_0008: Unknown result type (might be due to invalid IL or missing references)
			return new Color(r, g, b, 0.96f);
		}
	}

	public const string GUID = "dev.thronefall.trainer";

	public const string Version = "3.0.0";

	internal static ManualLogSource Log;

	private ConfigEntry<bool> cfgGodHero;

	private ConfigEntry<bool> cfgGodAll;

	private ConfigEntry<bool> cfgInstantRevive;

	private ConfigEntry<bool> cfgFreeBuild;

	private ConfigEntry<bool> cfgGoldDrip;

	private ConfigEntry<bool> cfgInstantBuild;

	private ConfigEntry<bool> cfgMagnet;

	private ConfigEntry<bool> cfgInstantKill;

	private ConfigEntry<bool> cfgDmgEnabled;

	private ConfigEntry<bool> cfgNoCooldown;

	private ConfigEntry<bool> cfgAtkSpdEnabled;

	private ConfigEntry<bool> cfgRegenEnabled;

	private ConfigEntry<bool> cfgMultiShot;

	private ConfigEntry<bool> cfgAllyDmgEnabled;

	private ConfigEntry<bool> cfgAllyAspdEnabled;

	private ConfigEntry<bool> cfgEnemySpdEnabled;

	private ConfigEntry<bool> cfgEnemyDmgEnabled;

	private ConfigEntry<bool> cfgEnemyHpEnabled;

	private ConfigEntry<bool> cfgEndlessWaves;

	private ConfigEntry<bool> cfgCmdRangeEnabled;

	private ConfigEntry<bool> cfgFastRespawn;

	private ConfigEntry<bool> cfgMoveEnabled;

	private ConfigEntry<bool> cfgSpeedEnabled;

	private ConfigEntry<bool> cfgEndlessDay;

	private ConfigEntry<bool> cfgZoomEnabled;

	private ConfigEntry<bool> cfgNeverLose;

	private ConfigEntry<bool> cfgRevealMap;

	private ConfigEntry<bool> cfgBotEnabled;

	private ConfigEntry<bool> cfgBotCheats;

	private ConfigEntry<bool> cfgCoach;

	private ConfigEntry<bool> cfgCoachVision;

	private ConfigEntry<bool> cfgCoachLive;

	private ConfigEntry<string> cfgCoachUrl;

	private ConfigEntry<string> cfgCoachModel;

	private ConfigEntry<string> cfgCoachKey;

	private ConfigEntry<string> cfgCoachVModel;

	private ConfigEntry<float> cfgMagnetRadius;

	private ConfigEntry<float> cfgDmgMult;

	private ConfigEntry<float> cfgAtkSpdMult;

	private ConfigEntry<float> cfgRegenMult;

	private ConfigEntry<float> cfgEnemySpdMult;

	private ConfigEntry<float> cfgEnemyDmgMult;

	private ConfigEntry<float> cfgEnemyHpMult;

	private ConfigEntry<float> cfgCmdRange;

	private ConfigEntry<float> cfgMoveMult;

	private ConfigEntry<float> cfgSpeedMult;

	private ConfigEntry<float> cfgZoomMult;

	private ConfigEntry<float> cfgMultiShotCount;

	private ConfigEntry<float> cfgAllyDmgMult;

	private ConfigEntry<float> cfgAllyAspdMult;

	private ConfigEntry<float> cfgOpacity;

	private ConfigEntry<int> cfgTheme;

	private static readonly FieldInfo BalanceField = typeof(PlayerInteraction).GetField("balance", BindingFlags.Instance | BindingFlags.NonPublic);

	private static readonly FieldInfo CoresField = typeof(PlayerInteraction).GetField("energyCoreBalance", BindingFlags.Instance | BindingFlags.NonPublic);

	private static readonly FieldInfo DayTimeField = typeof(DayNightCycle).GetField("remainingAutoDayTime", BindingFlags.Instance | BindingFlags.NonPublic);

	private static readonly FieldInfo ZoomLevelsField = typeof(CameraRig).GetField("zoomLevels", BindingFlags.Instance | BindingFlags.NonPublic);

	private bool showMenu;

	private bool collapsed;

	private bool resizing;

	private bool playerFrozenByUs;

	private Rect windowRect = new Rect(20f, 20f, 380f, 620f);

	private const float MinW = 300f;

	private const float MinH = 200f;

	private const float CollapsedH = 48f;

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

	private static readonly Theme[] Themes = new Theme[6]
	{
		new Theme(0.13f, 0.18f, 0.24f, 0.32f, 0.85f, 0.7f, 0.25f, 1f, 1f, 1f),
		new Theme(0.16f, 0.22f, 0.28f, 0.38f, 0.95f, 0.75f, 0.2f, 1f, 0.95f, 0.8f),
		new Theme(0.13f, 0.18f, 0.25f, 0.34f, 0.62f, 0.45f, 0.95f, 0.95f, 0.92f, 1f),
		new Theme(0.1f, 0.16f, 0.22f, 0.32f, 0.35f, 0.8f, 0.45f, 0.9f, 1f, 0.92f),
		new Theme(0.16f, 0.22f, 0.28f, 0.38f, 0.95f, 0.42f, 0.2f, 1f, 0.92f, 0.88f),
		new Theme(0.1f, 0.16f, 0.24f, 0.34f, 0.4f, 0.75f, 0.95f, 0.92f, 0.97f, 1f)
	};

	private static readonly string[] ThemeNames = new string[6] { "Dark", "Gold", "Arcane", "Forest", "Ember", "Ice" };

	private string goldText = "";

	private string coresText = "";

	private string dmgText = "10";

	private string moveText = "2";

	private string speedText = "2";

	private string magnetText = "250";

	private string atkSpdText = "2";

	private string regenText = "5";

	private string enemySpdText = "1";

	private string enemyDmgText = "1";

	private string enemyHpText = "1";

	private string cmdRangeText = "500";

	private string zoomText = "1.5";

	private string multiShotText = "3";

	private string allyDmgText = "5";

	private string allyAspdText = "3";

	private PlayerMovement cachedPM;

	private float origSpeed;

	private float origSpeedDay;

	private float origSprint;

	private float origSprintDay;

	private float origMagnet = -1f;

	private bool magnetWasOn;

	private bool gameSpeedWasOn;

	private PlayerInteraction cachedPI;

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

	private float origMeleeDmg = 1f;

	private float origRangedDmg = 1f;

	private bool allyDmgWasOn;

	private readonly Dictionary<int, float> origAllyCooldowns = new Dictionary<int, float>();

	private bool allyAspdWasOn;

	private CameraRig cachedCamRig;

	private float[] origZoomLevels;

	private bool zoomWasOn;

	private readonly Dictionary<int, Vector2> origVisionScales = new Dictionary<int, Vector2>();

	private bool revealWasOn;

	private bool botCheatsActive;

	private bool svGodHero;

	private bool svGodAll;

	private bool svInstantRevive;

	private bool svNeverLose;

	private bool svRegen;

	private bool svMagnet;

	private bool svInstantKill;

	private bool svNoCooldown;

	private float svRegenMult;

	private float svMagnetRadius;

	private void Awake()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		Log = ((BaseUnityPlugin)this).Logger;
		BindConfig();
		new Harmony("dev.thronefall.trainer").PatchAll();
		((BaseUnityPlugin)this).Logger.LogInfo((object)"Thronefall Trainer loaded. Press F1 to open the overlay.");
	}

	private void BindConfig()
	{
		cfgGodHero = ((BaseUnityPlugin)this).Config.Bind<bool>("Protection", "GodHero", false, (ConfigDescription)null);
		cfgGodAll = ((BaseUnityPlugin)this).Config.Bind<bool>("Protection", "GodAll", false, (ConfigDescription)null);
		cfgInstantRevive = ((BaseUnityPlugin)this).Config.Bind<bool>("Protection", "InstantRevive", false, (ConfigDescription)null);
		cfgFreeBuild = ((BaseUnityPlugin)this).Config.Bind<bool>("Economy", "FreeBuild", false, (ConfigDescription)null);
		cfgGoldDrip = ((BaseUnityPlugin)this).Config.Bind<bool>("Economy", "GoldDrip", false, (ConfigDescription)null);
		cfgCoach = ((BaseUnityPlugin)this).Config.Bind<bool>("Coach", "Enabled", true, (ConfigDescription)null);
		cfgCoachVision = ((BaseUnityPlugin)this).Config.Bind<bool>("Coach", "VisionEnabled", false, (ConfigDescription)null);
		cfgCoachLive = ((BaseUnityPlugin)this).Config.Bind<bool>("Coach", "LiveShot", true, (ConfigDescription)null);
		cfgCoachVModel = ((BaseUnityPlugin)this).Config.Bind<string>("Coach", "VisionModel", "qwen3-vl-2b-thinking-abliterated", (ConfigDescription)null);
		cfgCoachUrl = ((BaseUnityPlugin)this).Config.Bind<string>("Coach", "Url", "http://127.0.0.1:1234/v1/chat/completions", (ConfigDescription)null);
		cfgCoachModel = ((BaseUnityPlugin)this).Config.Bind<string>("Coach", "Model", "kat-coder-v2.5-dev-apex", (ConfigDescription)null);
		cfgCoachKey = ((BaseUnityPlugin)this).Config.Bind<string>("Coach", "ApiKey", "", (ConfigDescription)null);
		cfgInstantBuild = ((BaseUnityPlugin)this).Config.Bind<bool>("Economy", "InstantBuild", false, (ConfigDescription)null);
		cfgMagnet = ((BaseUnityPlugin)this).Config.Bind<bool>("Economy", "CoinMagnet", false, (ConfigDescription)null);
		cfgMagnetRadius = ((BaseUnityPlugin)this).Config.Bind<float>("Economy", "MagnetRadius", 250f, (ConfigDescription)null);
		cfgInstantKill = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "InstantKill", false, (ConfigDescription)null);
		cfgDmgEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "DamageMultEnabled", false, (ConfigDescription)null);
		cfgDmgMult = ((BaseUnityPlugin)this).Config.Bind<float>("Combat", "DamageMultiplier", 10f, (ConfigDescription)null);
		cfgNoCooldown = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "NoCooldown", false, (ConfigDescription)null);
		cfgAtkSpdEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "AttackSpeedEnabled", false, (ConfigDescription)null);
		cfgAtkSpdMult = ((BaseUnityPlugin)this).Config.Bind<float>("Combat", "AttackSpeedMult", 2f, (ConfigDescription)null);
		cfgRegenEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "RegenEnabled", false, (ConfigDescription)null);
		cfgRegenMult = ((BaseUnityPlugin)this).Config.Bind<float>("Combat", "RegenMult", 5f, (ConfigDescription)null);
		cfgMultiShot = ((BaseUnityPlugin)this).Config.Bind<bool>("Combat", "MultiShot", false, (ConfigDescription)null);
		cfgMultiShotCount = ((BaseUnityPlugin)this).Config.Bind<float>("Combat", "MultiShotCount", 3f, (ConfigDescription)null);
		cfgEnemySpdEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Enemies", "EnemySpeedEnabled", false, (ConfigDescription)null);
		cfgEnemySpdMult = ((BaseUnityPlugin)this).Config.Bind<float>("Enemies", "EnemySpeedMult", 1f, (ConfigDescription)null);
		cfgEnemyDmgEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Enemies", "EnemyDamageEnabled", false, (ConfigDescription)null);
		cfgEnemyDmgMult = ((BaseUnityPlugin)this).Config.Bind<float>("Enemies", "EnemyDamageMult", 1f, (ConfigDescription)null);
		cfgEnemyHpEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Enemies", "EnemyHpEnabled", false, (ConfigDescription)null);
		cfgEnemyHpMult = ((BaseUnityPlugin)this).Config.Bind<float>("Enemies", "EnemyHpMult", 1f, (ConfigDescription)null);
		cfgEndlessWaves = ((BaseUnityPlugin)this).Config.Bind<bool>("Enemies", "EndlessWaves", false, (ConfigDescription)null);
		cfgCmdRangeEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Army", "CommandRangeEnabled", false, (ConfigDescription)null);
		cfgCmdRange = ((BaseUnityPlugin)this).Config.Bind<float>("Army", "CommandRange", 500f, (ConfigDescription)null);
		cfgFastRespawn = ((BaseUnityPlugin)this).Config.Bind<bool>("Army", "FastRespawn", false, (ConfigDescription)null);
		cfgAllyDmgEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Army", "AllyDmgEnabled", false, (ConfigDescription)null);
		cfgAllyDmgMult = ((BaseUnityPlugin)this).Config.Bind<float>("Army", "AllyDmgMult", 5f, (ConfigDescription)null);
		cfgAllyAspdEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Army", "AllyAspdEnabled", false, (ConfigDescription)null);
		cfgAllyAspdMult = ((BaseUnityPlugin)this).Config.Bind<float>("Army", "AllyAspdMult", 3f, (ConfigDescription)null);
		cfgNeverLose = ((BaseUnityPlugin)this).Config.Bind<bool>("Protection", "NeverLose", false, (ConfigDescription)null);
		cfgRevealMap = ((BaseUnityPlugin)this).Config.Bind<bool>("Camera", "RevealMap", false, (ConfigDescription)null);
		cfgBotEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Bot", "AutopilotEnabled", false, (ConfigDescription)null);
		cfgBotCheats = ((BaseUnityPlugin)this).Config.Bind<bool>("Bot", "BotSurvivalCheats", false, (ConfigDescription)null);
		cfgOpacity = ((BaseUnityPlugin)this).Config.Bind<float>("Overlay", "Opacity", 1f, (ConfigDescription)null);
		cfgTheme = ((BaseUnityPlugin)this).Config.Bind<int>("Overlay", "ThemeIndex", 0, (ConfigDescription)null);
		cfgMoveEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Movement", "MoveSpeedEnabled", false, (ConfigDescription)null);
		cfgMoveMult = ((BaseUnityPlugin)this).Config.Bind<float>("Movement", "MoveSpeedMult", 2f, (ConfigDescription)null);
		cfgSpeedEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Time", "GameSpeedEnabled", false, (ConfigDescription)null);
		cfgSpeedMult = ((BaseUnityPlugin)this).Config.Bind<float>("Time", "GameSpeedMult", 2f, (ConfigDescription)null);
		cfgEndlessDay = ((BaseUnityPlugin)this).Config.Bind<bool>("Time", "EndlessDay", false, (ConfigDescription)null);
		cfgZoomEnabled = ((BaseUnityPlugin)this).Config.Bind<bool>("Camera", "ZoomEnabled", false, (ConfigDescription)null);
		cfgZoomMult = ((BaseUnityPlugin)this).Config.Bind<float>("Camera", "ZoomMult", 1.5f, (ConfigDescription)null);
		Cheats.GodHero = cfgGodHero.Value;
		Cheats.GodAll = cfgGodAll.Value;
		Cheats.InstantRevive = cfgInstantRevive.Value;
		Cheats.FreeBuild = cfgFreeBuild.Value;
		Cheats.GoldDrip = cfgGoldDrip.Value;
		Coach.Enabled = cfgCoach.Value;
		Coach.Url = cfgCoachUrl.Value;
		Coach.Model = cfgCoachModel.Value;
		Coach.ApiKey = cfgCoachKey.Value;
		Coach.VisionEnabled = cfgCoachVision.Value;
		Coach.VisionModel = cfgCoachVModel.Value;
		Coach.LiveShot = cfgCoachLive.Value;
		Coach.Init((MonoBehaviour)(object)this);
		((Component)this).gameObject.AddComponent<Overlay>();
		Cheats.InstantBuild = cfgInstantBuild.Value;
		Cheats.CoinMagnet = cfgMagnet.Value;
		Cheats.MagnetRadius = cfgMagnetRadius.Value;
		magnetText = Fmt(Cheats.MagnetRadius);
		Cheats.InstantKill = cfgInstantKill.Value;
		Cheats.DamageMultEnabled = cfgDmgEnabled.Value;
		Cheats.DamageMultiplier = cfgDmgMult.Value;
		dmgText = Fmt(Cheats.DamageMultiplier);
		Cheats.NoCooldown = cfgNoCooldown.Value;
		Cheats.AttackSpeedEnabled = cfgAtkSpdEnabled.Value;
		Cheats.AttackSpeedMult = cfgAtkSpdMult.Value;
		atkSpdText = Fmt(Cheats.AttackSpeedMult);
		Cheats.RegenEnabled = cfgRegenEnabled.Value;
		Cheats.RegenMult = cfgRegenMult.Value;
		regenText = Fmt(Cheats.RegenMult);
		Cheats.MultiShotEnabled = cfgMultiShot.Value;
		Cheats.MultiShotCount = (int)cfgMultiShotCount.Value;
		multiShotText = Fmt(Cheats.MultiShotCount);
		Cheats.EnemySpeedEnabled = cfgEnemySpdEnabled.Value;
		Cheats.EnemySpeedMult = cfgEnemySpdMult.Value;
		enemySpdText = Fmt(Cheats.EnemySpeedMult);
		Cheats.EnemyDamageEnabled = cfgEnemyDmgEnabled.Value;
		Cheats.EnemyDamageMult = cfgEnemyDmgMult.Value;
		enemyDmgText = Fmt(Cheats.EnemyDamageMult);
		Cheats.EnemyHpEnabled = cfgEnemyHpEnabled.Value;
		Cheats.EnemyHpMult = cfgEnemyHpMult.Value;
		enemyHpText = Fmt(Cheats.EnemyHpMult);
		Cheats.EndlessWaves = cfgEndlessWaves.Value;
		Cheats.CommandRangeEnabled = cfgCmdRangeEnabled.Value;
		Cheats.CommandRange = cfgCmdRange.Value;
		cmdRangeText = Fmt(Cheats.CommandRange);
		Cheats.FastRespawn = cfgFastRespawn.Value;
		Cheats.AllyDmgEnabled = cfgAllyDmgEnabled.Value;
		Cheats.AllyDmgMult = cfgAllyDmgMult.Value;
		allyDmgText = Fmt(Cheats.AllyDmgMult);
		Cheats.AllyAspdEnabled = cfgAllyAspdEnabled.Value;
		Cheats.AllyAspdMult = cfgAllyAspdMult.Value;
		allyAspdText = Fmt(Cheats.AllyAspdMult);
		Cheats.MoveSpeedEnabled = cfgMoveEnabled.Value;
		Cheats.MoveSpeedMult = cfgMoveMult.Value;
		moveText = Fmt(Cheats.MoveSpeedMult);
		Cheats.GameSpeedEnabled = cfgSpeedEnabled.Value;
		Cheats.GameSpeedMult = cfgSpeedMult.Value;
		speedText = Fmt(Cheats.GameSpeedMult);
		Cheats.EndlessDay = cfgEndlessDay.Value;
		Cheats.ZoomEnabled = cfgZoomEnabled.Value;
		Cheats.ZoomMult = cfgZoomMult.Value;
		zoomText = Fmt(Cheats.ZoomMult);
		Cheats.NeverLose = cfgNeverLose.Value;
		Cheats.RevealMap = cfgRevealMap.Value;
		SetBotEnabled(cfgBotEnabled.Value);
		uiOpacity = Mathf.Clamp(cfgOpacity.Value, 0.2f, 1f);
		themeIndex = Mathf.Clamp(cfgTheme.Value, 0, Themes.Length - 1);
		alphaText = Fmt(uiOpacity);
	}

	private static string Fmt(float v)
	{
		return v.ToString("0.##", CultureInfo.InvariantCulture);
	}

	private void Update()
	{
		//IL_0748: Unknown result type (might be due to invalid IL or missing references)
		Bot.Legit = !cfgBotCheats.Value;
		if (Input.GetKeyDown((KeyCode)282))
		{
			ToggleMenu();
		}
		if (!Bot.Enabled || !Bot.Legit)
		{
			if (Input.GetKeyDown((KeyCode)283))
			{
				KillAllEnemies();
			}
			if (Input.GetKeyDown((KeyCode)284))
			{
				ReviveAll();
			}
			if (Input.GetKeyDown((KeyCode)285))
			{
				AddGold(100);
			}
			if (Input.GetKeyDown((KeyCode)286))
			{
				TeleportToMouse();
			}
		}
		if (Input.GetKeyDown((KeyCode)287))
		{
			SetBotEnabled(!Bot.Enabled);
		}
		PlayerInteraction instance = PlayerInteraction.instance;
		PlayerMovement instance2 = PlayerMovement.instance;
		try
		{
			if (Cheats.FreeBuild && (Object)(object)instance != (Object)null && BalanceField != null && CoresField != null)
			{
				if (instance.Balance < 1)
				{
					BalanceField.SetValue(instance, 1);
				}
				if (instance.EnergyCoreBalance < 1)
				{
					CoresField.SetValue(instance, 1);
				}
			}
			if (Cheats.GoldDrip && (Object)(object)instance != (Object)null && (!Bot.Enabled || !Bot.Legit))
			{
				if (instance.Balance < 500)
				{
					SetGold(500);
				}
				if (instance.EnergyCoreBalance < 20)
				{
					SetCores(20);
				}
			}
			if ((Object)(object)instance2 != (Object)(object)cachedPM)
			{
				cachedPM = instance2;
				cachedAutoRevive = null;
				heroAttacks = null;
				if ((Object)(object)cachedPM != (Object)null)
				{
					origSpeed = cachedPM.speed;
					origSpeedDay = cachedPM.speedDuringDay;
					origSprint = cachedPM.sprintSpeed;
					origSprintDay = cachedPM.sprintSpeedDuringDay;
				}
			}
			if ((Object)(object)cachedPM != (Object)null)
			{
				float num = (Cheats.MoveSpeedEnabled ? Cheats.MoveSpeedMult : 1f);
				cachedPM.speed = origSpeed * num;
				cachedPM.speedDuringDay = origSpeedDay * num;
				cachedPM.sprintSpeed = origSprint * num;
				cachedPM.sprintSpeedDuringDay = origSprintDay * num;
			}
			if ((Object)(object)cachedPM != (Object)null && heroAttacks == null)
			{
				heroAttacks = ((Component)cachedPM).GetComponentsInChildren<ManualAttack>(true);
			}
			if (heroAttacks != null)
			{
				ManualAttack[] array = heroAttacks;
				foreach (ManualAttack val in array)
				{
					if (!((Object)(object)val == (Object)null))
					{
						int instanceID = ((Object)val).GetInstanceID();
						if (!origCooldownTimes.TryGetValue(instanceID, out var value))
						{
							value = val.cooldownTime;
							origCooldownTimes[instanceID] = value;
						}
						val.cooldownTime = (Cheats.AttackSpeedEnabled ? (value / Mathf.Max(0.05f, Cheats.AttackSpeedMult)) : value);
						if (Cheats.NoCooldown)
						{
							val.Cooldown = 0f;
						}
					}
				}
			}
			if ((Object)(object)PlayerUpgradeManager.instance != (Object)(object)cachedPUM)
			{
				if (regenWasOn && (Object)(object)cachedPUM != (Object)null)
				{
					cachedPUM.PlayerHealthRegenerationMultiplyer = origRegenMult;
				}
				cachedPUM = PlayerUpgradeManager.instance;
				if ((Object)(object)cachedPUM != (Object)null)
				{
					origRegenMult = cachedPUM.PlayerHealthRegenerationMultiplyer;
				}
			}
			if ((Object)(object)cachedPUM != (Object)null)
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
			if ((Object)(object)cachedPM != (Object)null && (Object)(object)cachedAutoRevive == (Object)null)
			{
				cachedAutoRevive = ((Component)cachedPM).GetComponentInChildren<AutoRevive>(true);
				if ((Object)(object)cachedAutoRevive != (Object)null)
				{
					origReviveTime = cachedAutoRevive.reviveAfterBeingKnockedOutFor;
				}
			}
			if ((Object)(object)cachedAutoRevive != (Object)null)
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
			if (Cheats.GameSpeedEnabled)
			{
				gameSpeedWasOn = true;
				if (Time.timeScale > 0f)
				{
					Time.timeScale = Cheats.GameSpeedMult;
				}
			}
			else if (gameSpeedWasOn)
			{
				gameSpeedWasOn = false;
				Time.timeScale = PlayerMovement.gameplayTimeScale;
			}
			if ((Object)(object)instance != (Object)(object)cachedPI)
			{
				cachedPI = instance;
				if ((Object)(object)instance != (Object)null)
				{
					origMagnet = instance.coinMagnetRadius;
				}
			}
			if (Cheats.CoinMagnet && (Object)(object)instance != (Object)null)
			{
				magnetWasOn = true;
				instance.coinMagnetRadius = Cheats.MagnetRadius;
			}
			else if (magnetWasOn)
			{
				magnetWasOn = false;
				if ((Object)(object)instance != (Object)null && origMagnet >= 0f)
				{
					instance.coinMagnetRadius = origMagnet;
				}
			}
			if ((Object)(object)CommandUnits.instance != (Object)(object)cachedCmd)
			{
				if (cmdRangeWasOn && (Object)(object)cachedCmd != (Object)null)
				{
					cachedCmd.attractRange = origAttractRange;
				}
				cachedCmd = CommandUnits.instance;
				if ((Object)(object)cachedCmd != (Object)null)
				{
					origAttractRange = cachedCmd.attractRange;
				}
			}
			if ((Object)(object)cachedCmd != (Object)null)
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
			if ((Object)(object)BlacksmithUpgrades.instance != (Object)null)
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
			if ((Object)(object)BlacksmithUpgrades.instance != (Object)(object)cachedBlacksmith)
			{
				if (allyDmgWasOn && (Object)(object)cachedBlacksmith != (Object)null)
				{
					cachedBlacksmith.meleeDamage = origMeleeDmg;
					cachedBlacksmith.rangedDamage = origRangedDmg;
				}
				cachedBlacksmith = BlacksmithUpgrades.instance;
				if ((Object)(object)cachedBlacksmith != (Object)null)
				{
					origMeleeDmg = cachedBlacksmith.meleeDamage;
					origRangedDmg = cachedBlacksmith.rangedDamage;
				}
			}
			if ((Object)(object)cachedBlacksmith != (Object)null)
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
			if (Cheats.EndlessDay && (Object)(object)DayNightCycle.Instance != (Object)null && DayTimeField != null && (int)DayNightCycle.Instance.CurrentTimestate == 0 && DayNightCycle.Instance.AutomatedDaytime)
			{
				DayTimeField.SetValue(DayNightCycle.Instance, 999999f);
			}
			if ((Object)(object)EnemySpawner.instance != (Object)null && EnemySpawner.instance.InfinitelySpawning != Cheats.EndlessWaves)
			{
				EnemySpawner.instance.InfinitelySpawning = Cheats.EndlessWaves;
			}
			if (Cheats.ZoomEnabled || zoomWasOn)
			{
				if ((Object)(object)cachedCamRig == (Object)null)
				{
					cachedCamRig = Object.FindObjectOfType<CameraRig>();
					origZoomLevels = null;
				}
				if ((Object)(object)cachedCamRig != (Object)null && ZoomLevelsField != null)
				{
					float[] array2 = (float[])ZoomLevelsField.GetValue(cachedCamRig);
					if (origZoomLevels == null && array2 != null)
					{
						origZoomLevels = (float[])array2.Clone();
					}
					if (origZoomLevels != null && array2 != null)
					{
						float num2 = (Cheats.ZoomEnabled ? Cheats.ZoomMult : 1f);
						for (int j = 0; j < array2.Length && j < origZoomLevels.Length; j++)
						{
							array2[j] = origZoomLevels[j] * num2;
						}
						zoomWasOn = Cheats.ZoomEnabled;
					}
				}
			}
			enemyTick += Time.unscaledDeltaTime;
			if (enemyTick >= 0.25f)
			{
				enemyTick = 0f;
				ApplyEnemySpeed();
				ApplyRevealMap();
				ApplyAllyAttackSpeed();
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log = Log;
			if (log != null)
			{
				log.LogWarning((object)("[plugin] Update cheat section threw: " + ex.Message));
			}
		}
		try
		{
			Bot.Tick();
		}
		catch (Exception ex2)
		{
			ManualLogSource log2 = Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[bot] Tick threw: " + ex2.Message));
			}
		}
	}

	private void ApplyAllyAttackSpeed()
	{
		TagManager instance = TagManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		float mult = (Cheats.AllyAspdEnabled ? Mathf.Max(0.05f, Cheats.AllyAspdMult) : 1f);
		foreach (TaggedObject playerUnit in instance.PlayerUnits)
		{
			if (!((Object)(object)playerUnit == (Object)null))
			{
				AutoAttack[] componentsInChildren = ((Component)playerUnit).GetComponentsInChildren<AutoAttack>(true);
				foreach (AutoAttack aa in componentsInChildren)
				{
					ApplyTo(aa);
				}
			}
		}
		foreach (BuildingInteractor playerBuildingInteractor in instance.playerBuildingInteractors)
		{
			if ((Object)(object)playerBuildingInteractor == (Object)null)
			{
				continue;
			}
			AutoAttack[] componentsInChildren = ((Component)playerBuildingInteractor).GetComponentsInChildren<AutoAttack>(true);
			foreach (AutoAttack val in componentsInChildren)
			{
				TaggedObject componentInParent = ((Component)val).GetComponentInParent<TaggedObject>();
				if ((Object)(object)componentInParent == (Object)null || componentInParent.Contains((ETag)0))
				{
					ApplyTo(val);
				}
			}
		}
		allyAspdWasOn = Cheats.AllyAspdEnabled;
		void ApplyTo(AutoAttack val2)
		{
			int instanceID = ((Object)val2).GetInstanceID();
			if (!origAllyCooldowns.TryGetValue(instanceID, out var value))
			{
				value = val2.cooldownDuration;
				origAllyCooldowns[instanceID] = value;
			}
			val2.cooldownDuration = value / mult;
		}
	}

	private void ApplyRevealMap()
	{
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		if (!Cheats.RevealMap && !revealWasOn)
		{
			return;
		}
		VisionSource[] array = Object.FindObjectsOfType<VisionSource>();
		foreach (VisionSource val in array)
		{
			if ((Object)(object)val == (Object)null)
			{
				continue;
			}
			int instanceID = ((Object)val).GetInstanceID();
			Vector2 value;
			if (Cheats.RevealMap)
			{
				revealWasOn = true;
				if (!origVisionScales.ContainsKey(instanceID))
				{
					origVisionScales[instanceID] = val.Scale;
				}
				val.Scale = new Vector2(99999f, 99999f);
			}
			else if (origVisionScales.TryGetValue(instanceID, out value))
			{
				val.Scale = value;
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
		TagManager instance = TagManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		if (!Cheats.EnemySpeedEnabled)
		{
			foreach (TaggedObject enemyUnit in instance.EnemyUnits)
			{
				if (!((Object)(object)enemyUnit == (Object)null))
				{
					PathfindMovementEnemy component = ((Component)enemyUnit).GetComponent<PathfindMovementEnemy>();
					if ((Object)(object)component != (Object)null && origEnemySpeeds.TryGetValue(((Object)component).GetInstanceID(), out var value))
					{
						component.movementSpeed = value;
					}
				}
			}
			origEnemySpeeds.Clear();
			return;
		}
		HashSet<int> hashSet = new HashSet<int>();
		foreach (TaggedObject enemyUnit2 in instance.EnemyUnits)
		{
			if ((Object)(object)enemyUnit2 == (Object)null)
			{
				continue;
			}
			PathfindMovementEnemy component2 = ((Component)enemyUnit2).GetComponent<PathfindMovementEnemy>();
			if (!((Object)(object)component2 == (Object)null))
			{
				int instanceID = ((Object)component2).GetInstanceID();
				hashSet.Add(instanceID);
				if (!origEnemySpeeds.TryGetValue(instanceID, out var value2))
				{
					value2 = component2.movementSpeed;
					origEnemySpeeds[instanceID] = value2;
				}
				component2.movementSpeed = value2 * Cheats.EnemySpeedMult;
			}
		}
		foreach (int item in new List<int>(origEnemySpeeds.Keys))
		{
			if (!hashSet.Contains(item))
			{
				origEnemySpeeds.Remove(item);
			}
		}
	}

	private void ToggleMenu()
	{
		showMenu = !showMenu;
		if ((Object)(object)LocalGamestate.Instance != (Object)null)
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
		{
			ToggleMenu();
		}
	}

	private void SetBotEnabled(bool v)
	{
		Bot.Legit = !cfgBotCheats.Value;
		Bot.SetEnabled(v);
		cfgBotEnabled.Value = v;
		ApplyBotSurvivalCheats(v);
	}

	private void ApplyBotSurvivalCheats(bool on)
	{
		if (!cfgBotCheats.Value)
		{
			return;
		}
		if (on)
		{
			svGodHero = Cheats.GodHero;
			svGodAll = Cheats.GodAll;
			svInstantRevive = Cheats.InstantRevive;
			svNeverLose = Cheats.NeverLose;
			svRegen = Cheats.RegenEnabled;
			svRegenMult = Cheats.RegenMult;
			svMagnet = Cheats.CoinMagnet;
			svMagnetRadius = Cheats.MagnetRadius;
			svInstantKill = Cheats.InstantKill;
			svNoCooldown = Cheats.NoCooldown;
			botCheatsActive = true;
			Cheats.GodHero = true;
			Cheats.GodAll = true;
			Cheats.InstantRevive = true;
			Cheats.NeverLose = true;
			Cheats.RegenEnabled = true;
			Cheats.RegenMult = 20f;
			Cheats.CoinMagnet = true;
			Cheats.MagnetRadius = Mathf.Max(Cheats.MagnetRadius, 500f);
			Cheats.InstantKill = true;
			Cheats.NoCooldown = true;
			ManualLogSource log = Log;
			if (log != null)
			{
				log.LogInfo((object)"[bot] survival cheats ON: god hero+all, instant revive, never-lose, regen x20, magnet 500, instant-kill, no-cooldown");
			}
		}
		else if (botCheatsActive)
		{
			botCheatsActive = false;
			if (Cheats.GodHero)
			{
				Cheats.GodHero = svGodHero;
			}
			if (Cheats.GodAll)
			{
				Cheats.GodAll = svGodAll;
			}
			if (Cheats.InstantRevive)
			{
				Cheats.InstantRevive = svInstantRevive;
			}
			if (Cheats.NeverLose)
			{
				Cheats.NeverLose = svNeverLose;
			}
			if (Cheats.RegenEnabled)
			{
				Cheats.RegenEnabled = svRegen;
				Cheats.RegenMult = svRegenMult;
			}
			if (Cheats.CoinMagnet)
			{
				Cheats.CoinMagnet = svMagnet;
				Cheats.MagnetRadius = svMagnetRadius;
			}
			if (Cheats.InstantKill)
			{
				Cheats.InstantKill = svInstantKill;
			}
			if (Cheats.NoCooldown)
			{
				Cheats.NoCooldown = svNoCooldown;
			}
			ManualLogSource log2 = Log;
			if (log2 != null)
			{
				log2.LogInfo((object)"[bot] survival cheats restored to previous state");
			}
		}
	}

	private void OnDestroy()
	{
		Bot.Shutdown();
		if (playerFrozenByUs && (Object)(object)LocalGamestate.Instance != (Object)null)
		{
			LocalGamestate.Instance.SetPlayerFreezeState(false);
		}
		if (gameSpeedWasOn)
		{
			Time.timeScale = PlayerMovement.gameplayTimeScale;
		}
	}

	private void AddGold(int amount)
	{
		PlayerInteraction instance = PlayerInteraction.instance;
		if ((Object)(object)instance != (Object)null)
		{
			instance.AddCoin(amount);
		}
	}

	private void SetGold(int value)
	{
		PlayerInteraction instance = PlayerInteraction.instance;
		if (!((Object)(object)instance == (Object)null) && !(BalanceField == null))
		{
			int num = value - instance.Balance;
			BalanceField.SetValue(instance, value);
			if (num > 0)
			{
				instance.onBalanceGain.Invoke(num);
			}
			else if (num < 0)
			{
				instance.onBalanceSpend.Invoke(-num);
			}
		}
	}

	private void SetCores(int value)
	{
		PlayerInteraction instance = PlayerInteraction.instance;
		if (!((Object)(object)instance == (Object)null) && !(CoresField == null))
		{
			int num = value - instance.EnergyCoreBalance;
			CoresField.SetValue(instance, value);
			if (num > 0)
			{
				instance.onEnergyCoreBalanceGain.Invoke(num);
			}
			else if (num < 0)
			{
				instance.onEnergyCoreBalanceSpend.Invoke(-num);
			}
		}
	}

	private void KillAllEnemies()
	{
		if ((Object)(object)TagManager.instance != (Object)null)
		{
			Hp.KillAllEnemyUnits();
		}
	}

	private void ReviveAll()
	{
		if ((Object)(object)TagManager.instance != (Object)null && (Object)(object)PerkManager.instance != (Object)null)
		{
			Hp.ReviveAllKnockedOutPlayerUnitsAndBuildings();
		}
	}

	private void HalveEnemyHp()
	{
		TagManager instance = TagManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		foreach (TaggedObject enemyUnit in instance.EnemyUnits)
		{
			if ((Object)(object)enemyUnit != (Object)null && (Object)(object)enemyUnit.Hp != (Object)null)
			{
				enemyUnit.Hp.SetHpTo(enemyUnit.Hp.HpValue * 0.5f);
			}
		}
	}

	private void SkipWave()
	{
		if ((Object)(object)EnemySpawner.instance != (Object)null)
		{
			EnemySpawner.instance.DebugSkipWave();
		}
	}

	private void StopSpawning()
	{
		if ((Object)(object)EnemySpawner.instance != (Object)null)
		{
			EnemySpawner.instance.StopSpawnAfterWaveAndReset();
		}
	}

	private void StartNight()
	{
		if ((Object)(object)DayNightCycle.Instance != (Object)null)
		{
			DayNightCycle.Instance.SwitchToNight();
		}
	}

	private void BackToDay()
	{
		if ((Object)(object)DayNightCycle.Instance != (Object)null)
		{
			DayNightCycle.Instance.SwithToDay();
		}
	}

	private void CharmAllEnemies()
	{
		TagManager instance = TagManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		foreach (TaggedObject item in new List<TaggedObject>(instance.EnemyUnits))
		{
			if ((Object)(object)item == (Object)null)
			{
				continue;
			}
			item.RemoveTag((ETag)1);
			item.AddTag((ETag)0);
			AutoAttack[] componentsInChildren = ((Component)item).GetComponentsInChildren<AutoAttack>(true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				foreach (TargetPriority targetPriority in componentsInChildren[i].targetPriorities)
				{
					targetPriority.mustHaveTags.Clear();
					targetPriority.mustHaveTags.Add((ETag)1);
					targetPriority.mayNotHaveTags.Remove((ETag)1);
					targetPriority.mayNotHaveTags.Add((ETag)0);
				}
			}
			PathfindMovementEnemy[] componentsInChildren2 = ((Component)item).GetComponentsInChildren<PathfindMovementEnemy>(true);
			foreach (PathfindMovementEnemy obj in componentsInChildren2)
			{
				obj.agroTimeWhenAttackedByPlayer = 0f;
				foreach (TargetPriority targetPriority2 in obj.targetPriorities)
				{
					targetPriority2.mustHaveTags.Clear();
					targetPriority2.mustHaveTags.Add((ETag)1);
				}
			}
		}
	}

	private void HarvestAll()
	{
		TagManager instance = TagManager.instance;
		PlayerInteraction instance2 = PlayerInteraction.instance;
		if ((Object)(object)instance == (Object)null || (Object)(object)instance2 == (Object)null)
		{
			return;
		}
		foreach (BuildingInteractor playerBuildingInteractor in instance.playerBuildingInteractors)
		{
			if (!((Object)(object)playerBuildingInteractor == (Object)null))
			{
				playerBuildingInteractor.SetHarvested(false);
				playerBuildingInteractor.Harvest(instance2);
			}
		}
	}

	private void CoinFountain(int amount)
	{
		PlayerInteraction instance = PlayerInteraction.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		foreach (CoinSpawner allCoinSpawner in CoinSpawner.allCoinSpawners)
		{
			if ((Object)(object)allCoinSpawner != (Object)null && ((Component)allCoinSpawner).gameObject.activeInHierarchy)
			{
				allCoinSpawner.TriggerCoinSpawn(amount, instance);
				break;
			}
		}
	}

	private void TeleportToMouse()
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		PlayerMovement instance = PlayerMovement.instance;
		Camera main = Camera.main;
		RaycastHit val = default;
		if (!((Object)(object)instance == (Object)null) && !((Object)(object)main == (Object)null) && Physics.Raycast(main.ScreenPointToRay(Input.mousePosition), ref val, 2000f))
		{
			instance.TeleportTo(val.point);
		}
	}

	private void SpawnNextWave()
	{
		if ((Object)(object)EnemySpawner.instance != (Object)null)
		{
			EnemySpawner.instance.StartSpawning();
		}
	}

	private void WinLevel()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Invalid comparison between Unknown and I4
		if ((Object)(object)LocalGamestate.Instance != (Object)null && (int)LocalGamestate.Instance.CurrentState == 1)
		{
			LocalGamestate.Instance.SetState((State)2, false, false);
		}
	}

	private void MaxAllBuildSlots()
	{
		BuildSlot[] array = Object.FindObjectsOfType<BuildSlot>();
		foreach (BuildSlot val in array)
		{
			try
			{
				val.DEBUGUpgradeToMax();
			}
			catch (Exception ex)
			{
				Log.LogWarning((object)("DEBUGUpgradeToMax failed on " + ((val != null) ? ((Object)val).name : null) + ": " + ex.Message));
			}
		}
	}

	private void CloneTroops(int count)
	{
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		TagManager instance = TagManager.instance;
		PlayerMovement instance2 = PlayerMovement.instance;
		if ((Object)(object)instance == (Object)null || (Object)(object)instance2 == (Object)null)
		{
			return;
		}
		List<TaggedObject> list = new List<TaggedObject>();
		foreach (TaggedObject playerUnit in instance.PlayerUnits)
		{
			if ((Object)(object)playerUnit != (Object)null && (Object)(object)playerUnit.Hp != (Object)null && !playerUnit.Hp.KnockedOut)
			{
				list.Add(playerUnit);
			}
		}
		if (list.Count == 0)
		{
			Log.LogWarning((object)"Clone troops: no living player units found to clone.");
			return;
		}
		for (int i = 0; i < count; i++)
		{
			TaggedObject val = list[Random.Range(0, list.Count)];
			Vector3 val2 = ((Component)instance2).transform.position + Quaternion.Euler(0f, Random.Range(0f, 360f), 0f) * Vector3.forward * 3f;
			try
			{
				PathfindMovementPlayerunit component = Object.Instantiate<GameObject>(((Component)val).gameObject, val2, Quaternion.identity).GetComponent<PathfindMovementPlayerunit>();
				if ((Object)(object)component != (Object)null)
				{
					component.HomePosition = val2;
					component.SnapToNavmesh();
				}
			}
			catch (Exception ex)
			{
				Log.LogWarning((object)("Clone failed: " + ex.Message));
			}
		}
	}

	private void UnlockAllLevels()
	{
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Invalid comparison between Unknown and I4
		LevelProgressManager instance = LevelProgressManager.instance;
		if ((Object)(object)instance == (Object)null || instance.levelInfos == null)
		{
			return;
		}
		LevelInfo[] levelInfos = instance.levelInfos;
		foreach (LevelInfo val in levelInfos)
		{
			if ((Object)(object)val == (Object)null || string.IsNullOrEmpty(val.sceneName))
			{
				continue;
			}
			LevelData levelDataForScene = instance.GetLevelDataForScene(val.sceneName);
			if (levelDataForScene == null)
			{
				continue;
			}
			levelDataForScene.beatenBest = true;
			if (levelDataForScene.highscoreBest < 9999999)
			{
				levelDataForScene.highscoreBest = 9999999;
			}
			levelDataForScene.levelHasBeenBeatenWith.Add(new List<Equippable>());
			foreach (Quest quest in val.quests)
			{
				if (quest != null && (int)quest.questType == 1 && quest.beatTheLevelWith != null && quest.beatTheLevelWith.Count > 0)
				{
					levelDataForScene.levelHasBeenBeatenWith.Add(new List<Equippable>(quest.beatTheLevelWith));
				}
			}
		}
		try
		{
			SaveLoadManager instance2 = SaveLoadManager.instance;
			if (instance2 != null)
			{
				instance2.SaveGame();
			}
		}
		catch (Exception ex)
		{
			Log.LogWarning((object)("SaveGame failed: " + ex.Message));
		}
	}

	private void UnlockAllPerks()
	{
		PerkManager instance = PerkManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		instance.level = 1000000;
		try
		{
			SaveLoadManager instance2 = SaveLoadManager.instance;
			if (instance2 != null)
			{
				instance2.SaveGame();
			}
		}
		catch (Exception ex)
		{
			Log.LogWarning((object)("SaveGame failed: " + ex.Message));
		}
	}

	private void AddScore(int amount)
	{
		if ((Object)(object)ScoreManager.Instance != (Object)null)
		{
			ScoreManager.Instance.AddDebugPoints(amount);
		}
	}

	private void EquipAllPerks()
	{
		PerkManager instance = PerkManager.instance;
		if ((Object)(object)instance == (Object)null)
		{
			return;
		}
		foreach (Equippable allEquippable in instance.allEquippables)
		{
			if (allEquippable is EquippablePerk || allEquippable is EquippableMutation)
			{
				try
				{
					PerkManager.SetEquipped(allEquippable, true);
				}
				catch (Exception ex)
				{
					Log.LogWarning((object)("SetEquipped(" + ((allEquippable != null) ? ((Object)allEquippable).name : null) + ") failed: " + ex.Message));
				}
			}
		}
	}

	private void UnlockAllAchievements()
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			foreach (Achievements value in Enum.GetValues(typeof(Achievements)))
			{
				AchievementManager.UnlockAchievement(value);
			}
		}
		catch (Exception ex)
		{
			Log.LogWarning((object)("UnlockAchievement failed: " + ex.Message));
		}
	}

	private void ChargeAllShrines()
	{
		Shrine[] array = Object.FindObjectsOfType<Shrine>();
		foreach (Shrine val in array)
		{
			if ((Object)(object)val != (Object)null)
			{
				try
				{
					val.MakeProgressAndUpdateBar(99999f);
				}
				catch (Exception ex)
				{
					Log.LogWarning((object)("Shrine charge failed: " + ex.Message));
				}
			}
		}
	}

	private Texture2D Solid(Color c)
	{
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Expected Obj, but got Unknown
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		Texture2D val = new Texture2D(1, 1, (TextureFormat)4, false);
		val.SetPixel(0, 0, c);
		val.Apply();
		((Object)val).hideFlags = (HideFlags)61;
		themeTex.Add(val);
		return val;
	}

	private GUIStyle Flat(GUIStyle src, Color normal, Color hover, Color active, Color text)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Expected Obj, but got Unknown
		GUIStyle val = new GUIStyle(src);
		val.normal.background = Solid(normal);
		val.hover.background = Solid(hover);
		val.active.background = Solid(active);
		val.focused.background = Solid(hover);
		val.onNormal.background = Solid(active);
		val.onHover.background = Solid(hover);
		val.onActive.background = Solid(active);
		val.onFocused.background = Solid(active);
		val.normal.textColor = text;
		val.hover.textColor = text;
		val.active.textColor = text;
		val.focused.textColor = text;
		val.onNormal.textColor = text;
		val.onHover.textColor = text;
		val.onActive.textColor = text;
		val.onFocused.textColor = text;
		return val;
	}

	private void EnsureSkin()
	{
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00df: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Expected Obj, but got Unknown
		//IL_0115: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_013f: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0168: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_018b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0191: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_019d: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f1: Expected Obj, but got Unknown
		//IL_0202: Unknown result type (might be due to invalid IL or missing references)
		//IL_021d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0238: Unknown result type (might be due to invalid IL or missing references)
		//IL_0253: Unknown result type (might be due to invalid IL or missing references)
		//IL_026e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0289: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)skin != (Object)null && builtTheme == themeIndex)
		{
			return;
		}
		foreach (Texture2D item in themeTex)
		{
			Object.Destroy((Object)(object)item);
		}
		themeTex.Clear();
		builtTheme = themeIndex;
		sectionStyle = null;
		Theme theme = Themes[themeIndex];
		GUISkin val = GUI.skin;
		skin = ScriptableObject.CreateInstance<GUISkin>();
		skin.window = Flat(val.window, theme.bg, theme.bg, theme.bg, theme.accent);
		skin.box = Flat(val.box, theme.panel, theme.panel, theme.panel, theme.text);
		skin.label = new GUIStyle(val.label);
		skin.label.normal.textColor = theme.text;
		skin.button = Flat(val.button, theme.button, theme.hover, theme.accent, theme.text);
		skin.textField = Flat(val.textField, theme.panel, theme.panel, theme.accent, theme.text);
		skin.horizontalSlider = Flat(val.horizontalSlider, theme.panel, theme.panel, theme.panel, theme.text);
		skin.horizontalSliderThumb = Flat(val.horizontalSliderThumb, theme.button, theme.hover, theme.accent, theme.text);
		skin.toggle = new GUIStyle(val.toggle);
		skin.toggle.normal.textColor = theme.text;
		skin.toggle.hover.textColor = theme.text;
		skin.toggle.active.textColor = theme.text;
		skin.toggle.onNormal.textColor = theme.accent;
		skin.toggle.onHover.textColor = theme.accent;
		skin.toggle.onActive.textColor = theme.accent;
	}

	private void OnGUI()
	{
		//IL_0233: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_011d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0123: Invalid comparison between Unknown and I4
		//IL_01d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01db: Invalid comparison between Unknown and I4
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0207: Expected Obj, but got Unknown
		//IL_0202: Unknown result type (might be due to invalid IL or missing references)
		//IL_0207: Unknown result type (might be due to invalid IL or missing references)
		//IL_0193: Unknown result type (might be due to invalid IL or missing references)
		if (!showMenu)
		{
			return;
		}
		EnsureSkin();
		GUISkin val = GUI.skin;
		if ((Object)(object)skin != (Object)null)
		{
			GUI.skin = skin;
		}
		GUI.color = new Color(1f, 1f, 1f, uiOpacity);
		windowRect.x = Mathf.Clamp(windowRect.x, 0f - windowRect.width + 60f, (float)Screen.width - 60f);
		windowRect.y = Mathf.Clamp(windowRect.y, 0f, (float)Screen.height - 30f);
		Event current = Event.current;
		Rect val2 = new Rect(windowRect.xMax - 26f, windowRect.yMax - 26f, 26f, 26f);
		if ((int)current.type == 0 && current.button == 0 && val2.Contains(current.mousePosition))
		{
			resizing = true;
			current.Use();
		}
		else if ((int)current.type == 3 && resizing)
		{
			windowRect.width = Mathf.Clamp(current.mousePosition.x - windowRect.x + 9f, 300f, (float)Screen.width - windowRect.x);
			float num = (collapsed ? 48f : 200f);
			windowRect.height = Mathf.Clamp(current.mousePosition.y - windowRect.y + 9f, num, (float)Screen.height - windowRect.y);
			current.Use();
		}
		else if ((int)current.type == 1)
		{
			resizing = false;
		}
		try
		{
			windowRect = GUI.Window(31249, windowRect, (WindowFunction)DrawWindow, "Thronefall Trainer");
		}
		catch (Exception ex)
		{
			ManualLogSource log = Log;
			if (log != null)
			{
				log.LogWarning((object)("[plugin] DrawWindow threw: " + ex.Message));
			}
		}
		finally
		{
			GUI.color = Color.white;
			GUI.skin = val;
		}
	}

	private static bool EnterPressed()
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Invalid comparison between Unknown and I4
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Invalid comparison between Unknown and I4
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Invalid comparison between Unknown and I4
		Event current = Event.current;
		if ((int)current.type == 4)
		{
			if ((int)current.keyCode != 13)
			{
				return (int)current.keyCode == 271;
			}
			return true;
		}
		return false;
	}

	private static bool EnterOn(string controlName)
	{
		if (EnterPressed())
		{
			return GUI.GetNameOfFocusedControl() == controlName;
		}
		return false;
	}

	private void Section(string title)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Expected Obj, but got Unknown
		if (sectionStyle == null)
		{
			sectionStyle = new GUIStyle(GUI.skin.label)
			{
				fontStyle = (FontStyle)1
			};
		}
		GUILayout.Space(4f);
		GUILayout.Label(title, sectionStyle, Array.Empty<GUILayoutOption>());
	}

	private void ConfigToggle(ConfigEntry<bool> entry, string label, ref bool field)
	{
		bool flag = GUILayout.Toggle(field, " " + label, Array.Empty<GUILayoutOption>());
		if (flag != field)
		{
			field = flag;
			entry.Value = flag;
		}
	}

	private void SliderRow(string controlName, string label, ref string text, float min, float max, float current, Action<float> apply, ConfigEntry<float> persist)
	{
		GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
		GUILayout.Label(label, new GUILayoutOption[1] { GUILayout.Width(105f) });
		float num = GUILayout.HorizontalSlider(current, min, max, new GUILayoutOption[1] { GUILayout.MinWidth(60f) });
		GUI.SetNextControlName(controlName);
		string text2 = GUILayout.TextField(text, new GUILayoutOption[1] { GUILayout.Width(48f) });
		if (text2 != text)
		{
			text = text2;
		}
		GUILayout.Label("x" + Fmt(current), new GUILayoutOption[1] { GUILayout.Width(40f) });
		GUILayout.EndHorizontal();
		float result;
		if (Mathf.Abs(num - current) > 0.001f)
		{
			apply(num);
			text = Fmt(num);
			if (persist != null)
			{
				persist.Value = num;
			}
		}
		else if (EnterOn(controlName) && float.TryParse(text, NumberStyles.Float, CultureInfo.InvariantCulture, out result))
		{
			result = Mathf.Clamp(result, min, max);
			apply(result);
			if (persist != null)
			{
				persist.Value = result;
			}
		}
	}

	private void IntRow(string controlName, string label, ref string text, Action<int> apply)
	{
		GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
		GUILayout.Label(label, new GUILayoutOption[1] { GUILayout.Width(105f) });
		GUI.SetNextControlName(controlName);
		text = GUILayout.TextField(text, new GUILayoutOption[1] { GUILayout.Width(60f) });
		if ((GUILayout.Button("Set", new GUILayoutOption[1] { GUILayout.Width(38f) }) || EnterOn(controlName)) && int.TryParse(text, out var result))
		{
			apply(result);
		}
		GUILayout.EndHorizontal();
	}

	private void DrawWindow(int id)
	{
		//IL_0d07: Unknown result type (might be due to invalid IL or missing references)
		//IL_0d36: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0200: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bf: Unknown result type (might be due to invalid IL or missing references)
		GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
		GUILayout.FlexibleSpace();
		if (!collapsed && GUILayout.Button("S", new GUILayoutOption[1] { GUILayout.Width(24f) }))
		{
			settingsOpen = !settingsOpen;
		}
		if (GUILayout.Button(collapsed ? "+" : "-", new GUILayoutOption[1] { GUILayout.Width(24f) }))
		{
			collapsed = !collapsed;
			if (collapsed)
			{
				expandedHeight = windowRect.height;
				windowRect.height = 48f;
			}
			else
			{
				windowRect.height = expandedHeight;
			}
		}
		if (GUILayout.Button("x", new GUILayoutOption[1] { GUILayout.Width(24f) }))
		{
			CloseMenu();
		}
		GUILayout.EndHorizontal();
		if (!collapsed && settingsOpen)
		{
			Section("-- OVERLAY SETTINGS --");
			SliderRow("alphaField", "Opacity", ref alphaText, 0.2f, 1f, uiOpacity, (float v) =>
			{
				uiOpacity = v;
			}, cfgOpacity);
			GUILayout.Label("Theme: " + ThemeNames[themeIndex], Array.Empty<GUILayoutOption>());
			int num = GUILayout.SelectionGrid(themeIndex, ThemeNames, 3, Array.Empty<GUILayoutOption>());
			if (num != themeIndex)
			{
				themeIndex = num;
				cfgTheme.Value = num;
			}
			if (GUILayout.Button("Reset window position", Array.Empty<GUILayoutOption>()))
			{
				windowRect = new Rect(20f, 20f, 380f, 620f);
			}
			if (GUILayout.Button("< Back to cheats", Array.Empty<GUILayoutOption>()))
			{
				settingsOpen = false;
			}
		}
		else if (!collapsed)
		{
			scroll = GUILayout.BeginScrollView(scroll, Array.Empty<GUILayoutOption>());
			PlayerInteraction instance = PlayerInteraction.instance;
			bool flag = Bot.Enabled && Bot.Legit;
			if (flag)
			{
				GUILayout.Label("<i>Cheats locked — autopilot is playing legit. Disable bot (F6) to unlock.</i>", Array.Empty<GUILayoutOption>());
				GUI.enabled = false;
			}
			Section("-- RESOURCES --");
			IntRow("goldField", "Gold: " + (((Object)(object)instance != (Object)null) ? instance.Balance.ToString() : "n/a"), ref goldText, SetGold);
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			GUILayout.Label("", new GUILayoutOption[1] { GUILayout.Width(105f) });
			if (GUILayout.Button("+100", new GUILayoutOption[1] { GUILayout.Width(52f) }))
			{
				AddGold(100);
			}
			if (GUILayout.Button("+1k", new GUILayoutOption[1] { GUILayout.Width(42f) }))
			{
				AddGold(1000);
			}
			if (GUILayout.Button("+10k", new GUILayoutOption[1] { GUILayout.Width(45f) }))
			{
				AddGold(10000);
			}
			GUILayout.EndHorizontal();
			IntRow("coresField", "Cores: " + (((Object)(object)instance != (Object)null) ? instance.EnergyCoreBalance.ToString() : "n/a"), ref coresText, SetCores);
			Section("-- PROTECTION --");
			ConfigToggle(cfgGodHero, "God mode - hero", ref Cheats.GodHero);
			ConfigToggle(cfgGodAll, "God mode - units & buildings", ref Cheats.GodAll);
			ConfigToggle(cfgInstantRevive, "Instant hero revive", ref Cheats.InstantRevive);
			ConfigToggle(cfgRegenEnabled, "HP regen multiplier", ref Cheats.RegenEnabled);
			SliderRow("regenField", "   regen", ref regenText, 0f, 100f, Cheats.RegenMult, (float v) =>
			{
				Cheats.RegenMult = v;
			}, cfgRegenMult);
			Section("-- ECONOMY --");
			ConfigToggle(cfgFreeBuild, "Free build (no coin/core cost)", ref Cheats.FreeBuild);
			ConfigToggle(cfgGoldDrip, "Gold drip (pin wallet 500 — bot tuning)", ref Cheats.GoldDrip);
			ConfigToggle(cfgInstantBuild, "Instant build (fast pay fill)", ref Cheats.InstantBuild);
			ConfigToggle(cfgMagnet, "Coin magnet", ref Cheats.CoinMagnet);
			SliderRow("magnetField", "   radius", ref magnetText, 10f, 2000f, Cheats.MagnetRadius, (float v) =>
			{
				Cheats.MagnetRadius = v;
			}, cfgMagnetRadius);
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Harvest all income", Array.Empty<GUILayoutOption>()))
			{
				HarvestAll();
			}
			if (GUILayout.Button("Coin fountain x100", Array.Empty<GUILayoutOption>()))
			{
				CoinFountain(100);
			}
			if (GUILayout.Button("Charge shrines", Array.Empty<GUILayoutOption>()))
			{
				ChargeAllShrines();
			}
			GUILayout.EndHorizontal();
			Section("-- COMBAT --");
			ConfigToggle(cfgDmgEnabled, "Damage multiplier", ref Cheats.DamageMultEnabled);
			SliderRow("dmgField", "   multiplier", ref dmgText, 1f, 1000f, Cheats.DamageMultiplier, (float v) =>
			{
				Cheats.DamageMultiplier = v;
			}, cfgDmgMult);
			ConfigToggle(cfgInstantKill, "Instant kill (one hit)", ref Cheats.InstantKill);
			ConfigToggle(cfgAtkSpdEnabled, "Attack speed multiplier", ref Cheats.AttackSpeedEnabled);
			SliderRow("atkSpdField", "   multiplier", ref atkSpdText, 0.25f, 20f, Cheats.AttackSpeedMult, (float v) =>
			{
				Cheats.AttackSpeedMult = v;
			}, cfgAtkSpdMult);
			ConfigToggle(cfgNoCooldown, "No ability/attack cooldown", ref Cheats.NoCooldown);
			ConfigToggle(cfgMultiShot, "Multi-shot (all player weapons)", ref Cheats.MultiShotEnabled);
			SliderRow("multiShotField", "   projectiles", ref multiShotText, 1f, 15f, Cheats.MultiShotCount, (float v) =>
			{
				Cheats.MultiShotCount = (int)v;
			}, cfgMultiShotCount);
			Section("-- ENEMIES --");
			ConfigToggle(cfgEnemySpdEnabled, "Enemy speed (0 = frozen)", ref Cheats.EnemySpeedEnabled);
			SliderRow("enemySpdField", "   speed", ref enemySpdText, 0f, 3f, Cheats.EnemySpeedMult, (float v) =>
			{
				Cheats.EnemySpeedMult = v;
			}, cfgEnemySpdMult);
			ConfigToggle(cfgEnemyDmgEnabled, "Enemy damage (0 = harmless)", ref Cheats.EnemyDamageEnabled);
			SliderRow("enemyDmgField", "   damage", ref enemyDmgText, 0f, 2f, Cheats.EnemyDamageMult, (float v) =>
			{
				Cheats.EnemyDamageMult = v;
			}, cfgEnemyDmgMult);
			ConfigToggle(cfgEnemyHpEnabled, "Enemy HP at spawn", ref Cheats.EnemyHpEnabled);
			SliderRow("enemyHpField", "   hp", ref enemyHpText, 0.1f, 3f, Cheats.EnemyHpMult, (float v) =>
			{
				Cheats.EnemyHpMult = v;
			}, cfgEnemyHpMult);
			ConfigToggle(cfgEndlessWaves, "Endless waves (wave repeats)", ref Cheats.EndlessWaves);
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Kill all enemies", Array.Empty<GUILayoutOption>()))
			{
				KillAllEnemies();
			}
			if (GUILayout.Button("Charm all enemies", Array.Empty<GUILayoutOption>()))
			{
				CharmAllEnemies();
			}
			GUILayout.EndHorizontal();
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Halve enemy HP", Array.Empty<GUILayoutOption>()))
			{
				HalveEnemyHp();
			}
			if (GUILayout.Button("Stop spawning", Array.Empty<GUILayoutOption>()))
			{
				StopSpawning();
			}
			GUILayout.EndHorizontal();
			if (GUILayout.Button("Revive all units & buildings", Array.Empty<GUILayoutOption>()))
			{
				ReviveAll();
			}
			Section("-- ARMY --");
			ConfigToggle(cfgCmdRangeEnabled, "Command range (grab all)", ref Cheats.CommandRangeEnabled);
			SliderRow("cmdRangeField", "   range", ref cmdRangeText, 10f, 5000f, Cheats.CommandRange, (float v) =>
			{
				Cheats.CommandRange = v;
			}, cfgCmdRange);
			ConfigToggle(cfgFastRespawn, "Fast unit respawn", ref Cheats.FastRespawn);
			ConfigToggle(cfgAllyDmgEnabled, "Ally damage multiplier", ref Cheats.AllyDmgEnabled);
			SliderRow("allyDmgField", "   damage", ref allyDmgText, 1f, 50f, Cheats.AllyDmgMult, (float v) =>
			{
				Cheats.AllyDmgMult = v;
			}, cfgAllyDmgMult);
			ConfigToggle(cfgAllyAspdEnabled, "Ally attack speed (troops+towers)", ref Cheats.AllyAspdEnabled);
			SliderRow("allyAspdField", "   speed", ref allyAspdText, 0.5f, 20f, Cheats.AllyAspdMult, (float v) =>
			{
				Cheats.AllyAspdMult = v;
			}, cfgAllyAspdMult);
			if (GUILayout.Button("Clone a random troop x5", Array.Empty<GUILayoutOption>()))
			{
				CloneTroops(5);
			}
			if (GUILayout.Button("Build/upgrade ALL slots (free)", Array.Empty<GUILayoutOption>()))
			{
				MaxAllBuildSlots();
			}
			Section("-- WORLD / TIME --");
			ConfigToggle(cfgMoveEnabled, "Move speed multiplier", ref Cheats.MoveSpeedEnabled);
			SliderRow("moveField", "   multiplier", ref moveText, 0.25f, 8f, Cheats.MoveSpeedMult, (float v) =>
			{
				Cheats.MoveSpeedMult = v;
			}, cfgMoveMult);
			ConfigToggle(cfgSpeedEnabled, "Game speed (speedhack)", ref Cheats.GameSpeedEnabled);
			SliderRow("speedField", "   multiplier", ref speedText, 0.1f, 10f, Cheats.GameSpeedMult, (float v) =>
			{
				Cheats.GameSpeedMult = v;
			}, cfgSpeedMult);
			ConfigToggle(cfgEndlessDay, "Endless day (freeze timer)", ref Cheats.EndlessDay);
			ConfigToggle(cfgZoomEnabled, "Zoom multiplier", ref Cheats.ZoomEnabled);
			SliderRow("zoomField", "   zoom", ref zoomText, 0.5f, 4f, Cheats.ZoomMult, (float v) =>
			{
				Cheats.ZoomMult = v;
			}, cfgZoomMult);
			ConfigToggle(cfgRevealMap, "Reveal map (remove fog)", ref Cheats.RevealMap);
			ConfigToggle(cfgNeverLose, "Never lose (defeat blocked)", ref Cheats.NeverLose);
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Teleport to mouse [F5]", Array.Empty<GUILayoutOption>()))
			{
				TeleportToMouse();
			}
			if (GUILayout.Button("Spawn next wave", Array.Empty<GUILayoutOption>()))
			{
				SpawnNextWave();
			}
			GUILayout.EndHorizontal();
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Skip wave", Array.Empty<GUILayoutOption>()))
			{
				SkipWave();
			}
			if (GUILayout.Button("Start night", Array.Empty<GUILayoutOption>()))
			{
				StartNight();
			}
			if (GUILayout.Button("Back to day", Array.Empty<GUILayoutOption>()))
			{
				BackToDay();
			}
			GUILayout.EndHorizontal();
			if (GUILayout.Button("Win level (instant victory)", Array.Empty<GUILayoutOption>()))
			{
				WinLevel();
			}
			Section("-- META (writes save file) --");
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Unlock all levels & crowns", Array.Empty<GUILayoutOption>()))
			{
				UnlockAllLevels();
			}
			if (GUILayout.Button("Unlock all perks/gear", Array.Empty<GUILayoutOption>()))
			{
				UnlockAllPerks();
			}
			GUILayout.EndHorizontal();
			GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
			if (GUILayout.Button("Equip ALL perks (mid-run)", Array.Empty<GUILayoutOption>()))
			{
				EquipAllPerks();
			}
			if (GUILayout.Button("Unlock achievements", Array.Empty<GUILayoutOption>()))
			{
				UnlockAllAchievements();
			}
			GUILayout.EndHorizontal();
			if (GUILayout.Button("+1,000,000 score", Array.Empty<GUILayoutOption>()))
			{
				AddScore(1000000);
			}
			if (flag)
			{
				GUI.enabled = true;
			}
			Section("Bot");
			bool flag2 = GUILayout.Toggle(Bot.Enabled, " Autopilot (F6)", Array.Empty<GUILayoutOption>());
			if (flag2 != Bot.Enabled)
			{
				SetBotEnabled(flag2);
			}
			GUILayout.Label("  " + Bot.Status, Array.Empty<GUILayoutOption>());
			GUILayout.FlexibleSpace();
			GUILayout.Label("F1 menu | F2 kill | F3 revive | F4 +100g | F5 tp | F6 bot | F8 panel  v3.0.0", Array.Empty<GUILayoutOption>());
			GUILayout.EndScrollView();
		}
		GUI.Box(new Rect(windowRect.width - 26f, windowRect.height - 26f, 26f, 26f), "=");
		GUI.DragWindow(new Rect(0f, 0f, windowRect.width - 84f, 24f));
	}

	public Plugin()
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
	}
}
