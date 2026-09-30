using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using BepInEx.Logging;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace ThronefallTrainer;

internal static class BotPerception
{
	internal struct Snapshot
	{
		public bool Valid;

		public string GameState;

		public Vector3 HeroPos;

		public float HeroHpPct;

		public bool HeroDead;

		public int Balance;

		public int CoreBalance;

		public bool IsNight;

		public float DayTimeLeft;

		public int Wave;

		public int WaveTotal;

		public int EnemyCount;

		public Coin NearestCoin;

		public Vector3 NearestCoinPos;

		public float NearestCoinDist;

		public int CoinCount;

		public TaggedObject NearestEnemy;

		public Vector3 NearestEnemyPos;

		public float NearestEnemyDist;

		public int EnemiesNearHero;

		public bool HasCastle;

		public Vector3 CastlePos;

		public float CastleDist;

		public bool OnLevelSelect;

		public string SceneName;

		public int InteractorCount;

		public int LevelCount;

		public LevelInteractor NearestLevel;

		public Vector3 NearestLevelPos;

		public float NearestLevelDist;

		public bool HasHorn;

		public Nighthorn Horn;

		public Vector3 HornPos;

		public float HornDist;

		public int BuildCount;

		public BuildingInteractor NearestBuild;

		public Vector3 NearestBuildPos;

		public float NearestBuildDist;

		public int NearestBuildScore;

		public int AllyCount;

		public Vector3 AllyCentroid;

		public TaggedObject CastleThreat;

		public float CastleThreatDist;

		public bool HasThreatAnchor;

		public Vector3 ThreatAnchor;

		public bool HasArmyAnchor;

		public Vector3 ArmyAnchor;

		public string ArmyAnchorLine;

		public Vector3[] DoorAnchors;

		public string[] DoorLines;

		public int DoorCount;

		public int DoorsCovered;

		public int DoorsClaimed;

		public int FreeUnits;

		public int EscortUnits;

		public Vector3 UncoveredDoorPos;

		public string UncoveredDoorLine;

		public int UncoveredDoorIdx;

		public int UncoveredDoorTarget;

		public bool UncoveredDoorHot;

		public bool HasUncoveredDoor;

		public int ArmyTarget;

		public float SelfDefendRange;

		public float DayBudget;

		public string PolicyKey;

		public string PolicyFocus;

		public bool RedAlert;

		public float RedAlertRadius;

		public bool SceneBusy;

		public bool CanCommand;

		public bool CanSwitch;

		public int NearestBuildKey;

		public string NearestBuildName;

		public bool NearestBuildHarvest;

		public bool HeldBuildComplete;

		public bool HasWeapon;

		public float ActiveRange;

		public bool ActiveFiresMoving;

		public bool HasBuildStand;

		public Vector3 BuildStandPos;

		public float BuildStandDist;

		public Vector3 CastleStandPos;

		public bool HasCastleStand;

		public int NextWaveCount;

		public int NextWaveElites;

		public float NextWaveMaxHp;

		public float NextWaveSpeed;

		public float NextWaveFoeRange;

		public int NextWaveGold;

		public bool FinalWaveNext;

		public float NearEnemyRange;

		public float NearEnemyHp;

		public bool NearEnemyElite;

		public float CastleHpPct;

		public bool WaveBeforeFinalNext;

		public int ShrineCount;

		public Vector3 ShrinePos;

		public float ShrineDist;

		public int BuildMil;

		public int BuildInc;
	}

	internal static class Strat
	{
		public static int Squad;

		public static int Reserve;

		public static int Escort;

		public static int ArmyTarget;

		public static float DoorDist = 40f;

		public static string Focus = "";

		public static string[] BuildOrder = new string[0];

		public static Dictionary<string, int> LineSquad = new Dictionary<string, int>();
	}

	private class BuildClass
	{
		public int mil;

		public int inc;
	}

	private static readonly List<TaggedObject> castleBuf = new List<TaggedObject>();

	private static LevelInteractor[] levelCache;

	private static float levelScanAt;

	private static ManualAttack maCache;

	private static float weScanAt;

	private static Shrine[] shrineCache;

	private static float shrineScanAt;

	private static bool castleHpLogged;

	private static SlotPackRec[] slotPack;

	private static SpawnRouteRec[] spawnRoutes;

	private static WaveRec[] wavePack;

	private static StandPtRec[] castleStands;

	private static string slotPackScene = "";

	private static string armyAnchorLine;

	private static int[] doorUnit;

	private static bool[] doorBreach;

	private static float[] doorClaim;

	private static float[] doorParked;

	private static Vector3[] sceneDoorAnchors;

	private static string[] sceneDoorLines;

	private static string doorScene = "";

	private static int[] doorFoes;

	private static float hornScanAt;

	private static string hornDumpScene;

	public static InteractorBase HornBi;

	public static int BreachCount;

	public static readonly Dictionary<string, int> CatBuilt = new Dictionary<string, int>();

	private static readonly Dictionary<string, int> NameBuilt = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

	private static string catBuiltScene;

	private static float milFirstAt = -1f;

	private static float slotDumpAt;

	private static readonly Dictionary<string, int> catStuck = new Dictionary<string, int>();

	private static readonly HashSet<string> badStands = new HashSet<string>();

	private static FieldInfo fiComplete;

	private static FieldInfo fiWaiting;

	private static bool fiLooked;

	private static readonly Dictionary<BuildingInteractor, float> buildIgnore = new Dictionary<BuildingInteractor, float>();

	public static Func<LevelInteractor, bool, float> LevelScore;

	public static Func<Coin, bool> CoinSkip;

	public static Snapshot Last;

	public static bool LastValid;

	public static BuildingInteractor HeldBuildRef;

	private static readonly FieldInfo StmRunningField = typeof(SceneTransitionManager).GetField("sceneTransitionIsRunning", BindingFlags.Instance | BindingFlags.NonPublic);

	private static readonly Dictionary<BuildSlot, BuildClass> buildClassCache = new Dictionary<BuildSlot, BuildClass>();

	private static string lastClassScene = "";

	public static float MilitaryFirstAt => milFirstAt;

	internal static SnapshotData ToData(in Snapshot s)
	{
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0144: Unknown result type (might be due to invalid IL or missing references)
		//IL_0195: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_023c: Unknown result type (might be due to invalid IL or missing references)
		//IL_02f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0332: Unknown result type (might be due to invalid IL or missing references)
		//IL_03a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_03f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_04fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0542: Unknown result type (might be due to invalid IL or missing references)
		//IL_056e: Unknown result type (might be due to invalid IL or missing references)
		return new SnapshotData
		{
			Valid = s.Valid,
			GameState = s.GameState,
			SceneName = s.SceneName,
			HeroPos = V(s.HeroPos),
			HeroHpPct = s.HeroHpPct,
			HeroDead = s.HeroDead,
			Balance = s.Balance,
			CoreBalance = s.CoreBalance,
			IsNight = s.IsNight,
			DayTimeLeft = s.DayTimeLeft,
			Wave = s.Wave,
			WaveTotal = s.WaveTotal,
			EnemyCount = s.EnemyCount,
			HasCoin = ((Object)(object)s.NearestCoin != (Object)null),
			CoinPos = V(s.NearestCoinPos),
			CoinDist = s.NearestCoinDist,
			CoinCount = s.CoinCount,
			HasNearEnemy = ((Object)(object)s.NearestEnemy != (Object)null),
			NearEnemyPos = V(s.NearestEnemyPos),
			NearEnemyDist = s.NearestEnemyDist,
			NearFoeCount = s.EnemiesNearHero,
			HasCastle = s.HasCastle,
			CastlePos = V(s.CastlePos),
			CastleDist = s.CastleDist,
			HasCastleThreat = ((Object)(object)s.CastleThreat != (Object)null),
			CastleThreatPos = (((Object)(object)s.CastleThreat != (Object)null) ? V(((Component)s.CastleThreat).transform.position) : Vec2.Zero),
			CastleThreatDist = s.CastleThreatDist,
			HasThreatAnchor = s.HasThreatAnchor,
			ThreatAnchor = V(s.ThreatAnchor),
			HasArmyAnchor = s.HasArmyAnchor,
			ArmyAnchor = V(s.ArmyAnchor),
			ArmyAnchorLine = (s.ArmyAnchorLine ?? ""),
			DoorCount = s.DoorCount,
			DoorsCovered = s.DoorsCovered,
			FreeUnits = s.FreeUnits,
			HasUncoveredDoor = s.HasUncoveredDoor,
			UncoveredDoorPos = V(s.UncoveredDoorPos),
			UncoveredDoorLine = (s.UncoveredDoorLine ?? ""),
			UncoveredDoorTarget = s.UncoveredDoorTarget,
			UncoveredDoorHot = s.UncoveredDoorHot,
			ArmyTarget = s.ArmyTarget,
			SelfDefendRange = s.SelfDefendRange,
			DayBudget = s.DayBudget,
			RedAlert = s.RedAlert,
			RedAlertRadius = s.RedAlertRadius,
			OnLevelSelect = s.OnLevelSelect,
			InteractorCount = s.InteractorCount,
			LevelCount = s.LevelCount,
			HasLevel = ((Object)(object)s.NearestLevel != (Object)null),
			LevelPos = V(s.NearestLevelPos),
			LevelDist = s.NearestLevelDist,
			SceneBusy = s.SceneBusy,
			HasHorn = s.HasHorn,
			HornPos = V(s.HornPos),
			HornDist = s.HornDist,
			BuildCount = s.BuildCount,
			HasBuild = ((Object)(object)s.NearestBuild != (Object)null),
			BuildKey = (((Object)(object)s.NearestBuild != (Object)null) ? ((Object)s.NearestBuild).GetInstanceID() : (-1)),
			BuildName = s.NearestBuildName,
			BuildPos = V(s.NearestBuildPos),
			BuildDist = s.NearestBuildDist,
			BuildScore = s.NearestBuildScore,
			BuildHarvest = s.NearestBuildHarvest,
			HeldBuildComplete = s.HeldBuildComplete,
			AllyCount = s.AllyCount,
			AllyCentroid = V(s.AllyCentroid),
			CanCommand = s.CanCommand,
			CanSwitch = s.CanSwitch,
			NightCall = Coach.NightCallRequested,
			HasWeapon = s.HasWeapon,
			ActiveRange = s.ActiveRange,
			ActiveFiresMoving = s.ActiveFiresMoving,
			NextWaveCount = s.NextWaveCount,
			NextWaveElites = s.NextWaveElites,
			NextWaveMaxHp = s.NextWaveMaxHp,
			NextWaveSpeed = s.NextWaveSpeed,
			NextWaveFoeRange = s.NextWaveFoeRange,
			NextWaveGold = s.NextWaveGold,
			FinalWaveNext = s.FinalWaveNext,
			NearEnemyRange = s.NearEnemyRange,
			NearEnemyHp = s.NearEnemyHp,
			NearEnemyElite = s.NearEnemyElite,
			CastleHpPct = s.CastleHpPct,
			WaveBeforeFinalNext = s.WaveBeforeFinalNext,
			ShrineCount = s.ShrineCount,
			ShrinePos = V(s.ShrinePos),
			ShrineDist = s.ShrineDist,
			BuildMil = s.BuildMil,
			BuildInc = s.BuildInc,
			HasBuildStand = s.HasBuildStand,
			BuildStandPos = V(s.BuildStandPos),
			BuildStandDist = s.BuildStandDist,
			HasCastleStand = s.HasCastleStand,
			CastleStandPos = V(s.CastleStandPos)
		};
	}

	private static Vec2 V(Vector3 v)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return new Vec2(v.x, v.z);
	}

	public static void MarkDoorClaim(Vector3 pos)
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		if (doorClaim == null || sceneDoorAnchors == null)
		{
			return;
		}
		int num = -1;
		float num2 = 400f;
		for (int i = 0; i < sceneDoorAnchors.Length; i++)
		{
			Vector3 val = sceneDoorAnchors[i] - pos;
			float sqrMagnitude = val.sqrMagnitude;
			if (sqrMagnitude < num2)
			{
				num2 = sqrMagnitude;
				num = i;
			}
		}
		if (num >= 0)
		{
			doorClaim[num] = Time.unscaledTime;
		}
	}

	public static void MarkDoorClaimIdx(int i)
	{
		if (doorClaim != null && sceneDoorAnchors != null && i >= 0 && i < doorClaim.Length)
		{
			doorClaim[i] = Time.unscaledTime;
		}
	}

	public static void ParkDoorAnchor(Vector3 pos)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		if (sceneDoorAnchors == null)
		{
			return;
		}
		if (doorParked == null || doorParked.Length != sceneDoorAnchors.Length)
		{
			doorParked = new float[sceneDoorAnchors.Length];
		}
		int num = -1;
		float num2 = 400f;
		for (int i = 0; i < sceneDoorAnchors.Length; i++)
		{
			Vector3 val = sceneDoorAnchors[i] - pos;
			float sqrMagnitude = val.sqrMagnitude;
			if (sqrMagnitude < num2)
			{
				num2 = sqrMagnitude;
				num = i;
			}
		}
		if (num >= 0)
		{
			doorParked[num] = Time.unscaledTime;
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)string.Format("[bot] door '{0}' parked 5m @ {1}", (sceneDoorLines != null && num < sceneDoorLines.Length) ? sceneDoorLines[num] : "?", pos));
			}
		}
		else
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)$"[bot] ParkDoorAnchor: no anchor within 20m of {pos}");
			}
		}
	}

	public static void ParkDoorIdx(int i)
	{
		if (sceneDoorAnchors != null && i >= 0 && i < sceneDoorAnchors.Length)
		{
			if (doorParked == null || doorParked.Length != sceneDoorAnchors.Length)
			{
				doorParked = new float[sceneDoorAnchors.Length];
			}
			doorParked[i] = Time.unscaledTime;
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)string.Format("[bot] door '{0}' parked 5m (idx {1})", (sceneDoorLines != null && i < sceneDoorLines.Length) ? sceneDoorLines[i] : "?", i));
			}
		}
	}

	private static bool DoorParked(int i)
	{
		if (doorParked == null || i >= doorParked.Length)
		{
			return false;
		}
		return Time.unscaledTime - doorParked[i] < 300f;
	}

	public static string BuildCat(string name)
	{
		string text = (name ?? "").ToLowerInvariant();
		if (text.Contains("wall") || text.Contains("palisade") || text.Contains("fortify"))
		{
			return "wall";
		}
		if (text.Contains("gate"))
		{
			return "gate";
		}
		if (text.Contains("tower") || text.Contains("ballista") || text.Contains("cannon") || text.Contains("watchtower"))
		{
			return "tower";
		}
		if (text.Contains("barrack") || text.Contains("archery") || text.Contains("militia") || text.Contains("guard") || text.Contains("outpost"))
		{
			return "military";
		}
		if (text.Contains("house") || text.Contains("mill") || text.Contains("farm") || text.Contains("mine") || text.Contains("market"))
		{
			return "income";
		}
		if (text.Contains("castle"))
		{
			return "upgrade";
		}
		return "other";
	}

	public static void BuildDone(string buildingName, Vector3 pos = default(Vector3))
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		if (pos != default(Vector3))
		{
			string scene = slotPackScene ?? "";
			for (int i = -1; i <= 1; i++)
			{
				for (int j = -1; j <= 1; j++)
				{
					Memory.Unpark(scene, pos + new Vector3((float)i * 8f, 0f, (float)j * 8f));
				}
			}
		}
		if (catBuiltScene != slotPackScene)
		{
			catBuiltScene = slotPackScene;
			CatBuilt.Clear();
			NameBuilt.Clear();
			milFirstAt = -1f;
		}
		string text = BuildCat(buildingName);
		if (text == "military" && milFirstAt < 0f)
		{
			milFirstAt = Time.unscaledTime;
		}
		CatBuilt[text] = (CatBuilt.TryGetValue(text, out var value) ? value : 0) + 1;
		NameBuilt[buildingName] = (NameBuilt.TryGetValue(buildingName, out var value2) ? value2 : 0) + 1;
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)$"[bot] playbook: built '{buildingName}' (cat {text} #{CatBuilt[text]})");
		}
	}

	public static int MilitaryCount()
	{
		if (!CatBuilt.TryGetValue("military", out var value))
		{
			return 0;
		}
		return value;
	}

	public static string[] OpenBuildOrder()
	{
		string[] buildOrder = Strat.BuildOrder;
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		List<string> list = new List<string>();
		for (int i = 0; i < buildOrder.Length; i++)
		{
			string text = buildOrder[i].Split(':')[0].Trim();
			if (!catStuck.TryGetValue(text, out var value) || value < 4)
			{
				dictionary.TryGetValue(text, out var value2);
				dictionary[text] = value2 + 1;
				CatBuilt.TryGetValue(text, out var value3);
				if (value3 < dictionary[text])
				{
					list.Add(text);
				}
				if (list.Count >= 3)
				{
					break;
				}
			}
		}
		return list.ToArray();
	}

	public static void NoteBuildFail(string cat)
	{
		if (!string.IsNullOrEmpty(cat))
		{
			catStuck.TryGetValue(cat, out var value);
			catStuck[cat] = value + 1;
		}
	}

	public static string AuditJson(ref Snapshot s, string mode, float modeSince, float now)
	{
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		StringBuilder stringBuilder = new StringBuilder(900);
		stringBuilder.Append("{\"scene\":").Append(JsonStr(s.SceneName)).Append(",\"t\":")
			.Append(Mathf.RoundToInt(now))
			.Append(",\"mode\":")
			.Append(JsonStr(mode))
			.Append(",\"mode_since\":")
			.Append(Mathf.RoundToInt(now - modeSince))
			.Append(",\"gold\":")
			.Append(Mathf.RoundToInt((float)s.Balance))
			.Append(",\"ally\":")
			.Append(s.AllyCount)
			.Append(",\"free\":")
			.Append(s.FreeUnits)
			.Append(",\"escort\":")
			.Append(s.EscortUnits)
			.Append(",\"army_target\":")
			.Append(s.ArmyTarget)
			.Append(",\"bmil\":")
			.Append(MilitaryCount())
			.Append(",\"bmil_first\":")
			.Append((milFirstAt >= 0f) ? Mathf.RoundToInt(milFirstAt).ToString(invariantCulture) : "null")
			.Append(",\"foes\":")
			.Append(s.EnemyCount)
			.Append(",\"next_foes\":")
			.Append(s.NextWaveCount)
			.Append(",\"night\":")
			.Append(s.IsNight ? "true" : "false")
			.Append(",\"wave\":")
			.Append(s.Wave)
			.Append(",\"wave_total\":")
			.Append(s.WaveTotal)
			.Append(",\"doors_cov\":")
			.Append(s.DoorsCovered)
			.Append(",\"doors_claimed\":")
			.Append(s.DoorsClaimed)
			.Append(",\"doors\":")
			.Append(s.DoorCount)
			.Append(",\"red\":")
			.Append(s.RedAlert ? "true" : "false")
			.Append(",\"breaches\":")
			.Append(BreachCount)
			.Append(",\"bld\":")
			.Append(s.BuildCount)
			.Append(",\"cur_build\":")
			.Append(JsonStr(s.NearestBuildName))
			.Append(",\"open_order\":[");
		string[] array = OpenBuildOrder();
		for (int i = 0; i < array.Length; i++)
		{
			if (i > 0)
			{
				stringBuilder.Append(',');
			}
			stringBuilder.Append(JsonStr(array[i]));
		}
		stringBuilder.Append("],\"cat_built\":{");
		bool flag = true;
		foreach (KeyValuePair<string, int> item in CatBuilt)
		{
			if (!flag)
			{
				stringBuilder.Append(',');
			}
			flag = false;
			stringBuilder.Append(JsonStr(item.Key)).Append(':').Append(item.Value);
		}
		stringBuilder.Append("},\"door_units\":[");
		if (doorUnit != null)
		{
			for (int j = 0; j < doorUnit.Length; j++)
			{
				if (j > 0)
				{
					stringBuilder.Append(',');
				}
				stringBuilder.Append(doorUnit[j]);
			}
		}
		stringBuilder.Append("],\"door_lines\":[");
		if (sceneDoorLines != null)
		{
			for (int k = 0; k < sceneDoorLines.Length; k++)
			{
				if (k > 0)
				{
					stringBuilder.Append(',');
				}
				stringBuilder.Append(JsonStr(sceneDoorLines[k]));
			}
		}
		stringBuilder.Append("],\"checklist\":[");
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		for (int l = 0; l < Strat.BuildOrder.Length; l++)
		{
			string text = Strat.BuildOrder[l];
			string[] array2 = text.Split(':');
			string key = array2[0].Trim();
			string text2 = ((array2.Length > 1) ? array2[1].Split('-')[0].Trim() : null);
			if (text2 != null)
			{
				text2 = Regex.Replace(text2, "_day\\d+$", "", RegexOptions.IgnoreCase);
				text2 = Regex.Replace(text2, "_T\\d+$", "", RegexOptions.IgnoreCase);
			}
			dictionary.TryGetValue(key, out var value);
			dictionary[key] = value + 1;
			bool flag2;
			if (text2 != null)
			{
				flag2 = false;
				foreach (KeyValuePair<string, int> item2 in NameBuilt)
				{
					if (item2.Value > 0 && item2.Key.IndexOf(text2, StringComparison.OrdinalIgnoreCase) >= 0)
					{
						flag2 = true;
						break;
					}
				}
			}
			else
			{
				CatBuilt.TryGetValue(key, out var value2);
				flag2 = value2 >= dictionary[key];
			}
			if (l > 0)
			{
				stringBuilder.Append(',');
			}
			stringBuilder.Append("{\"n\":").Append(JsonStr(text)).Append(",\"done\":")
				.Append(flag2 ? "true" : "false")
				.Append('}');
		}
		stringBuilder.Append("]}");
		return stringBuilder.ToString();
	}

	internal static string JsonStr(string v)
	{
		if (v == null)
		{
			return "null";
		}
		return "\"" + v.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
	}

	private static void LoadStrategy(string scene)
	{
		Strat.Squad = (Strat.Reserve = (Strat.Escort = (Strat.ArmyTarget = 0)));
		Strat.DoorDist = 40f;
		Strat.Focus = "";
		Strat.BuildOrder = new string[0];
		Strat.LineSquad.Clear();
		CatBuilt.Clear();
		NameBuilt.Clear();
		catStuck.Clear();
		milFirstAt = -1f;
		catBuiltScene = null;
		badStands.Clear();
		doorParked = null;
		BreachCount = 0;
		HornBi = null;
		buildClassCache.Clear();
		try
		{
			string path = Path.Combine(Recorder.AgentDir, "botpack", "strategy_" + scene.ToLowerInvariant() + ".json");
			if (!File.Exists(path))
			{
				return;
			}
			string text = File.ReadAllText(path);
			Strat.Squad = JInt(text, "squad_size");
			Strat.Reserve = JInt(text, "reserve_size");
			Strat.Escort = JInt(text, "escort_size");
			Strat.ArmyTarget = JInt(text, "army_target");
			Match match = Regex.Match(text, "\"door_distance_m\"\\s*:\\s*([\\d.]+)");
			if (match.Success && float.TryParse(match.Groups[1].Value, NumberStyles.Float, CultureInfo.InvariantCulture, out var result) && result >= 10f && result <= 200f)
			{
				Strat.DoorDist = result;
			}
			else
			{
				Strat.DoorDist = 40f;
			}
			Match match2 = Regex.Match(text, "\"build_order\"\\s*:\\s*\\[(.*?)\\]", RegexOptions.Singleline);
			List<string> list = new List<string>();
			if (match2.Success)
			{
				foreach (Match item in Regex.Matches(match2.Groups[1].Value, "\"([^\"]+)\""))
				{
					list.Add(item.Groups[1].Value);
				}
			}
			Strat.BuildOrder = list.ToArray();
			Strat.LineSquad.Clear();
			Match match4 = Regex.Match(text, "\"wave_priority\"\\s*:\\s*\\[(.*?)\\]", RegexOptions.Singleline);
			if (match4.Success)
			{
				foreach (Match item2 in Regex.Matches(match4.Groups[1].Value, "\"line\"\\s*:\\s*\"([^\"]+)\"[^{}]*?\"squad\"\\s*:\\s*(\\d+)", RegexOptions.Singleline))
				{
					Strat.LineSquad[item2.Groups[1].Value.Trim()] = int.Parse(item2.Groups[2].Value);
				}
			}
			Match match6 = Regex.Match(text, "\"build_focus\"\\s*:\\s*\"([^\"]*)\"");
			if (match6.Success)
			{
				Strat.Focus = match6.Groups[1].Value;
			}
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)($"[bot] strategy '{scene}': squad={Strat.Squad} " + $"reserve={Strat.Reserve} escort={Strat.Escort} army>={Strat.ArmyTarget} " + $"order={Strat.BuildOrder.Length} linesquad={Strat.LineSquad.Count}"));
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[bot] strategy load: " + ex.Message));
			}
		}
	}

	public static string StrategySummary()
	{
		return $"squad={Strat.Squad} reserve={Strat.Reserve} " + $"escort={Strat.Escort} army>={Strat.ArmyTarget} " + "focus=" + Strat.Focus;
	}

	public static string StrategyText(string scene)
	{
		try
		{
			string path = Path.Combine(Recorder.AgentDir, "botpack", "strategy_" + (scene ?? "").ToLowerInvariant() + ".json");
			return File.Exists(path) ? File.ReadAllText(path) : "";
		}
		catch
		{
			return "";
		}
	}

	private static int JInt(string j, string key)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
		if (!match.Success)
		{
			return 0;
		}
		return int.Parse(match.Groups[1].Value);
	}

	private static SlotPackRec[] LoadSlotPack(string scene)
	{
		if (slotPackScene == scene)
		{
			return slotPack;
		}
		slotPackScene = scene;
		slotPack = null;
		spawnRoutes = null;
		wavePack = null;
		castleStands = null;
		LoadStrategy(scene);
		try
		{
			string text = Path.Combine(Recorder.AgentDir, "botpack", scene + ".json");
			if (!File.Exists(text))
			{
				text = Path.Combine(Recorder.AgentDir, "slots", scene + ".json");
			}
			bool flag = File.Exists(text);
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)$"[bot] botpack probe '{scene}': exists={flag} path='{text}'");
			}
			if (!flag)
			{
				return null;
			}
			string json = File.ReadAllText(text);
			slotPack = ParseSlotPack(json);
			spawnRoutes = ParseSpawnRoutes(json);
			wavePack = ParseWaves(json);
			castleStands = ParseCastleStands(json);
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogInfo((object)($"[bot] botpack '{scene}': {((slotPack != null) ? slotPack.Length : (-1))} slots, " + $"{((spawnRoutes != null) ? spawnRoutes.Length : (-1))} routes, " + $"{((wavePack != null) ? wavePack.Length : (-1))} waves"));
			}
		}
		catch (Exception arg)
		{
			ManualLogSource log3 = Plugin.Log;
			if (log3 != null)
			{
				log3.LogWarning((object)$"[bot] botpack load: {arg}");
			}
		}
		return slotPack;
	}

	private static SlotPackRec FindSlot(Vector3 pos)
	{
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		if (slotPack == null)
		{
			return null;
		}
		SlotPackRec result = null;
		float num = 4f;
		SlotPackRec[] array = slotPack;
		foreach (SlotPackRec slotPackRec in array)
		{
			if (slotPackRec.pos != null && slotPackRec.pos.Length >= 3)
			{
				float num2 = slotPackRec.pos[0] - pos.x;
				float num3 = slotPackRec.pos[2] - pos.z;
				float num4 = num2 * num2 + num3 * num3;
				if (num4 < num)
				{
					num = num4;
					result = slotPackRec;
				}
			}
		}
		return result;
	}

	public static void IgnoreStand(Vector3 slotPos)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		badStands.Add(PosKey(slotPos));
	}

	private static string PosKey(Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		return Mathf.FloorToInt(p.x / 4f) + "," + Mathf.FloorToInt(p.z / 4f);
	}

	private static Vector3 BestStand(SlotPackRec sl, Vector3 hero)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		if (sl == null || sl.stands == null || sl.stands.Length == 0)
		{
			return Vector3.zero;
		}
		StandPtRec standPtRec = null;
		float num = float.MaxValue;
		StandPtRec[] stands = sl.stands;
		foreach (StandPtRec standPtRec2 in stands)
		{
			if (!(standPtRec2.cl < 0.5f))
			{
				float num2 = standPtRec2.x - hero.x;
				float num3 = standPtRec2.z - hero.z;
				float num4 = num2 * num2 + num3 * num3;
				if (num4 < num)
				{
					num = num4;
					standPtRec = standPtRec2;
				}
			}
		}
		if (standPtRec == null)
		{
			return Vector3.zero;
		}
		return new Vector3(standPtRec.x, standPtRec.y, standPtRec.z);
	}

	private static Vector3 BestStandRecs(StandPtRec[] stands, Vector3 hero)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		if (stands == null || stands.Length == 0)
		{
			return Vector3.zero;
		}
		StandPtRec standPtRec = null;
		float num = float.MaxValue;
		foreach (StandPtRec standPtRec2 in stands)
		{
			if (!(standPtRec2.cl < 0.5f))
			{
				float num2 = standPtRec2.x - hero.x;
				float num3 = standPtRec2.z - hero.z;
				float num4 = num2 * num2 + num3 * num3;
				if (num4 < num)
				{
					num = num4;
					standPtRec = standPtRec2;
				}
			}
		}
		if (standPtRec == null)
		{
			return Vector3.zero;
		}
		return new Vector3(standPtRec.x, standPtRec.y, standPtRec.z);
	}

	private static SlotPackRec[] ParseSlotPack(string json)
	{
		List<SlotPackRec> list = new List<SlotPackRec>();
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		int num = json.Length;
		int num2 = 0;
		int num3 = json.IndexOf("\"slots\"", StringComparison.Ordinal);
		if (num3 < 0)
		{
			return null;
		}
		int num4 = json.IndexOf('[', num3);
		int num5 = MatchBracket(json, num4);
		if (num5 > num4)
		{
			num2 = num4;
			num = num5;
		}
		int startIndex = num2;
		while (true)
		{
			startIndex = json.IndexOf("\"pos\"", startIndex, StringComparison.Ordinal);
			if (startIndex < 0 || startIndex >= num)
			{
				break;
			}
			SlotPackRec slotPackRec = new SlotPackRec
			{
				name = ""
			};
			int num6 = json.LastIndexOf("\"id\"", startIndex, startIndex - num2);
			if (num6 > 0 && startIndex - num6 < 400)
			{
				Match match = Regex.Match(json.Substring(num6, Math.Min(32, json.Length - num6)), "\"id\"\\s*:\\s*(-?\\d+)");
				if (match.Success)
				{
					slotPackRec.id = int.Parse(match.Groups[1].Value, invariantCulture);
				}
			}
			Match match2 = Regex.Match(json.Substring(startIndex, Math.Min(120, json.Length - startIndex)), "\"pos\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
			if (match2.Success)
			{
				slotPackRec.pos = new float[3]
				{
					float.Parse(match2.Groups[1].Value, invariantCulture),
					float.Parse(match2.Groups[2].Value, invariantCulture),
					float.Parse(match2.Groups[3].Value, invariantCulture)
				};
			}
			int num7 = json.IndexOf("\"pos\"", startIndex + 5, StringComparison.Ordinal);
			int num8 = ((num7 > startIndex && num7 < num) ? num7 : num);
			int num9 = json.IndexOf("\"stands\"", startIndex, StringComparison.Ordinal);
			if (num9 > 0 && num9 < num8)
			{
				int num10 = json.IndexOf('[', num9);
				int num11 = MatchBracket(json, num10);
				if (num11 > num10)
				{
					List<StandPtRec> list2 = new List<StandPtRec>();
					foreach (Match item in Regex.Matches(json.Substring(num10, num11 - num10), "\"x\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"y\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"z\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"cl\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"dInt\"\\s*:\\s*(-?[\\d.eE+-]+)"))
					{
						list2.Add(new StandPtRec
						{
							x = float.Parse(item.Groups[1].Value, invariantCulture),
							y = float.Parse(item.Groups[2].Value, invariantCulture),
							z = float.Parse(item.Groups[3].Value, invariantCulture),
							cl = float.Parse(item.Groups[4].Value, invariantCulture),
							dInt = float.Parse(item.Groups[5].Value, invariantCulture)
						});
					}
					slotPackRec.stands = list2.ToArray();
				}
			}
			list.Add(slotPackRec);
			startIndex += 5;
		}
		if (list.Count != 0)
		{
			return list.ToArray();
		}
		return null;
	}

	private static void EnsureInteractorFields()
	{
		if (!fiLooked)
		{
			fiLooked = true;
			Type typeFromHandle = typeof(BuildingInteractor);
			fiComplete = typeFromHandle.GetField("interactionComplete", BindingFlags.Instance | BindingFlags.NonPublic);
			fiWaiting = typeFromHandle.GetField("isWaitingForChoice", BindingFlags.Instance | BindingFlags.NonPublic);
		}
	}

	private static bool IsInteractorFinished(BuildingInteractor bi)
	{
		EnsureInteractorFields();
		try
		{
			if (!((InteractorBase)bi).CanBeInteractedWith)
			{
				if (fiComplete != null && (bool)fiComplete.GetValue(bi))
				{
					return true;
				}
				if (fiWaiting != null && (bool)fiWaiting.GetValue(bi))
				{
					ChoiceManager instance = ChoiceManager.instance;
					if ((Object)(object)instance != (Object)null && instance.ChoiceCoroutineRunning)
					{
						return true;
					}
				}
			}
		}
		catch
		{
		}
		return false;
	}

	public static bool IsInteractorComplete(BuildingInteractor bi)
	{
		EnsureInteractorFields();
		try
		{
			return fiComplete != null && (bool)fiComplete.GetValue(bi);
		}
		catch
		{
			return false;
		}
	}

	private static int MatchBracket(string s, int open)
	{
		if (open < 0)
		{
			return -1;
		}
		int num = 0;
		bool flag = false;
		for (int i = open; i < s.Length; i++)
		{
			if (s[i] == '"' && (i == 0 || s[i - 1] != '\\'))
			{
				flag = !flag;
			}
			if (!flag)
			{
				if (s[i] == '[')
				{
					num++;
				}
				else if (s[i] == ']' && --num == 0)
				{
					return i;
				}
			}
		}
		return -1;
	}

	private static StandPtRec[] ParseCastleStands(string json)
	{
		int num = json.IndexOf("\"castle\"", StringComparison.Ordinal);
		if (num < 0)
		{
			return null;
		}
		int num2 = json.IndexOf("\"stands\"", num, StringComparison.Ordinal);
		if (num2 < 0 || num2 - num > 4000)
		{
			return null;
		}
		int num3 = json.IndexOf('[', num2);
		int num4 = MatchBracket(json, num3);
		if (num4 <= num3)
		{
			return null;
		}
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		List<StandPtRec> list = new List<StandPtRec>();
		foreach (Match item in Regex.Matches(json.Substring(num3, num4 - num3), "\"x\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"y\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"z\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"cl\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"dInt\"\\s*:\\s*(-?[\\d.eE+-]+)"))
		{
			list.Add(new StandPtRec
			{
				x = float.Parse(item.Groups[1].Value, invariantCulture),
				y = float.Parse(item.Groups[2].Value, invariantCulture),
				z = float.Parse(item.Groups[3].Value, invariantCulture),
				cl = float.Parse(item.Groups[4].Value, invariantCulture),
				dInt = float.Parse(item.Groups[5].Value, invariantCulture)
			});
		}
		if (list.Count != 0)
		{
			return list.ToArray();
		}
		return null;
	}

	private static SpawnRouteRec[] ParseSpawnRoutes(string json)
	{
		int num = json.IndexOf("\"spawns\"", StringComparison.Ordinal);
		if (num < 0)
		{
			return null;
		}
		int num2 = json.IndexOf('[', num);
		int num3 = MatchBracket(json, num2);
		if (num3 <= num2)
		{
			return null;
		}
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		List<SpawnRouteRec> list = new List<SpawnRouteRec>();
		string text = json.Substring(num2 + 1, num3 - num2 - 1);
		int num4 = 0;
		int num5 = -1;
		for (int i = 0; i < text.Length; i++)
		{
			switch (text[i])
			{
			case '{':
				if (num4 == 0)
				{
					num5 = i;
				}
				num4++;
				break;
			case '}':
			{
				num4--;
				if (num4 != 0 || num5 < 0)
				{
					break;
				}
				string text2 = text.Substring(num5, i - num5 + 1);
				SpawnRouteRec spawnRouteRec = new SpawnRouteRec();
				Match match = Regex.Match(text2, "\"line\"\\s*:\\s*\"([^\"]*)\"");
				spawnRouteRec.line = (match.Success ? match.Groups[1].Value : "");
				Match match2 = Regex.Match(text2, "\"spawn\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
				if (match2.Success)
				{
					spawnRouteRec.spawn = new float[2]
					{
						float.Parse(match2.Groups[1].Value, invariantCulture),
						float.Parse(match2.Groups[2].Value, invariantCulture)
					};
				}
				int num6 = text2.IndexOf("\"wp\"", StringComparison.Ordinal);
				if (num6 >= 0)
				{
					int num7 = text2.IndexOf('[', num6);
					int num8 = ((num7 >= 0) ? MatchBracket(text2, num7) : (-1));
					if (num8 > num7)
					{
						List<float[]> list2 = new List<float[]>();
						foreach (Match item in Regex.Matches(text2.Substring(num7, num8 - num7), "\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]"))
						{
							list2.Add(new float[2]
							{
								float.Parse(item.Groups[1].Value, invariantCulture),
								float.Parse(item.Groups[2].Value, invariantCulture)
							});
						}
						spawnRouteRec.wp = list2.ToArray();
					}
				}
				Match match4 = Regex.Match(text2, "\"lenM\"\\s*:\\s*(-?[\\d.eE+-]+)");
				if (match4.Success)
				{
					spawnRouteRec.lenM = float.Parse(match4.Groups[1].Value, invariantCulture);
				}
				Match match5 = Regex.Match(text2, "\"narrowM\"\\s*:\\s*(-?[\\d.eE+-]+)");
				if (match5.Success)
				{
					spawnRouteRec.narrowM = float.Parse(match5.Groups[1].Value, invariantCulture);
				}
				Match match6 = Regex.Match(text2, "\"narrowAt\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
				if (match6.Success)
				{
					spawnRouteRec.narrowAt = new float[2]
					{
						float.Parse(match6.Groups[1].Value, invariantCulture),
						float.Parse(match6.Groups[2].Value, invariantCulture)
					};
				}
				spawnRouteRec.fly = text2.IndexOf("\"fly\": true", StringComparison.Ordinal) >= 0 || text2.IndexOf("\"fly\":true", StringComparison.Ordinal) >= 0;
				spawnRouteRec.ground = text2.IndexOf("\"ground\": true", StringComparison.Ordinal) >= 0 || text2.IndexOf("\"ground\":true", StringComparison.Ordinal) >= 0;
				list.Add(spawnRouteRec);
				num5 = -1;
				break;
			}
			}
		}
		if (list.Count != 0)
		{
			return list.ToArray();
		}
		return null;
	}

	private static WaveRec[] ParseWaves(string json)
	{
		int num = json.IndexOf("\"waves\"", StringComparison.Ordinal);
		if (num < 0)
		{
			return null;
		}
		int num2 = json.IndexOf('[', num);
		int num3 = MatchBracket(json, num2);
		if (num3 <= num2)
		{
			return null;
		}
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		List<WaveRec> list = new List<WaveRec>();
		string text = json.Substring(num2 + 1, num3 - num2 - 1);
		int num4 = 0;
		int num5 = -1;
		for (int i = 0; i < text.Length; i++)
		{
			switch (text[i])
			{
			case '{':
				if (num4 == 0)
				{
					num5 = i;
				}
				num4++;
				break;
			case '}':
				num4--;
				if (num4 == 0 && num5 >= 0)
				{
					string text2 = text.Substring(num5, i - num5 + 1);
					WaveRec waveRec = new WaveRec();
					Match match = Regex.Match(text2, "\"wave\"\\s*:\\s*(-?\\d+)");
					if (match.Success)
					{
						waveRec.wave = int.Parse(match.Groups[1].Value, invariantCulture);
					}
					Match match2 = Regex.Match(text2, "\"count\"\\s*:\\s*(-?\\d+)");
					if (match2.Success)
					{
						waveRec.count = int.Parse(match2.Groups[1].Value, invariantCulture);
					}
					Match match3 = Regex.Match(text2, "\"enemy\"\\s*:\\s*\"([^\"]*)\"");
					if (match3.Success)
					{
						waveRec.enemy = match3.Groups[1].Value;
					}
					Match match4 = Regex.Match(text2, "\"line\"\\s*:\\s*\"([^\"]*)\"");
					if (match4.Success)
					{
						waveRec.line = match4.Groups[1].Value;
					}
					Match match5 = Regex.Match(text2, "\"gold\"\\s*:\\s*(-?\\d+)");
					if (match5.Success)
					{
						waveRec.gold = int.Parse(match5.Groups[1].Value, invariantCulture);
					}
					Match match6 = Regex.Match(text2, "\"hp\"\\s*:\\s*(-?[\\d.eE+-]+)");
					if (match6.Success)
					{
						waveRec.hp = float.Parse(match6.Groups[1].Value, invariantCulture);
					}
					Match match7 = Regex.Match(text2, "\"disp\"\\s*:\\s*\"([^\"]*)\"");
					if (match7.Success)
					{
						waveRec.disp = match7.Groups[1].Value;
					}
					waveRec.elite = text2.IndexOf("\"elite\": true", StringComparison.Ordinal) >= 0 || text2.IndexOf("\"elite\":true", StringComparison.Ordinal) >= 0;
					list.Add(waveRec);
					num5 = -1;
				}
				break;
			}
		}
		if (list.Count != 0)
		{
			return list.ToArray();
		}
		return null;
	}

	public static void IgnoreBuild(BuildingInteractor bi, float seconds)
	{
		if ((Object)(object)bi != (Object)null)
		{
			buildIgnore[bi] = Time.unscaledTime + seconds;
		}
	}

	public static Snapshot Capture(int preferBuildKey = -1)
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Invalid comparison between Unknown and I4
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_13da: Unknown result type (might be due to invalid IL or missing references)
		//IL_13df: Unknown result type (might be due to invalid IL or missing references)
		//IL_13e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_13ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_175e: Unknown result type (might be due to invalid IL or missing references)
		//IL_1763: Unknown result type (might be due to invalid IL or missing references)
		//IL_160d: Unknown result type (might be due to invalid IL or missing references)
		//IL_16a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_16a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_16b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_16b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_011e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Invalid comparison between Unknown and I4
		//IL_1775: Unknown result type (might be due to invalid IL or missing references)
		//IL_1777: Unknown result type (might be due to invalid IL or missing references)
		//IL_173c: Unknown result type (might be due to invalid IL or missing references)
		//IL_1741: Unknown result type (might be due to invalid IL or missing references)
		//IL_1749: Unknown result type (might be due to invalid IL or missing references)
		//IL_174f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0177: Unknown result type (might be due to invalid IL or missing references)
		//IL_0169: Unknown result type (might be due to invalid IL or missing references)
		//IL_18d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_18de: Unknown result type (might be due to invalid IL or missing references)
		//IL_18e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_18e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_18ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_18ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_017c: Unknown result type (might be due to invalid IL or missing references)
		//IL_1a3b: Unknown result type (might be due to invalid IL or missing references)
		//IL_1a40: Unknown result type (might be due to invalid IL or missing references)
		//IL_1a45: Unknown result type (might be due to invalid IL or missing references)
		//IL_1a4d: Unknown result type (might be due to invalid IL or missing references)
		//IL_1a52: Unknown result type (might be due to invalid IL or missing references)
		//IL_1937: Unknown result type (might be due to invalid IL or missing references)
		//IL_193c: Unknown result type (might be due to invalid IL or missing references)
		//IL_1941: Unknown result type (might be due to invalid IL or missing references)
		//IL_1943: Unknown result type (might be due to invalid IL or missing references)
		//IL_1945: Unknown result type (might be due to invalid IL or missing references)
		//IL_190e: Unknown result type (might be due to invalid IL or missing references)
		//IL_1915: Unknown result type (might be due to invalid IL or missing references)
		//IL_191f: Unknown result type (might be due to invalid IL or missing references)
		//IL_1924: Unknown result type (might be due to invalid IL or missing references)
		//IL_1929: Unknown result type (might be due to invalid IL or missing references)
		//IL_01da: Unknown result type (might be due to invalid IL or missing references)
		//IL_01dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0188: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_1953: Unknown result type (might be due to invalid IL or missing references)
		//IL_1955: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0205: Unknown result type (might be due to invalid IL or missing references)
		//IL_0235: Unknown result type (might be due to invalid IL or missing references)
		//IL_023a: Unknown result type (might be due to invalid IL or missing references)
		//IL_021b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0223: Unknown result type (might be due to invalid IL or missing references)
		//IL_0228: Unknown result type (might be due to invalid IL or missing references)
		//IL_023f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0243: Unknown result type (might be due to invalid IL or missing references)
		//IL_0245: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_1ad8: Unknown result type (might be due to invalid IL or missing references)
		//IL_1ade: Unknown result type (might be due to invalid IL or missing references)
		//IL_1ae3: Unknown result type (might be due to invalid IL or missing references)
		//IL_1ae8: Unknown result type (might be due to invalid IL or missing references)
		//IL_025e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0260: Unknown result type (might be due to invalid IL or missing references)
		//IL_236e: Unknown result type (might be due to invalid IL or missing references)
		//IL_2373: Unknown result type (might be due to invalid IL or missing references)
		//IL_1bac: Unknown result type (might be due to invalid IL or missing references)
		//IL_1bb2: Unknown result type (might be due to invalid IL or missing references)
		//IL_1bb7: Unknown result type (might be due to invalid IL or missing references)
		//IL_1bbc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0662: Unknown result type (might be due to invalid IL or missing references)
		//IL_0667: Unknown result type (might be due to invalid IL or missing references)
		//IL_0420: Unknown result type (might be due to invalid IL or missing references)
		//IL_0426: Unknown result type (might be due to invalid IL or missing references)
		//IL_042b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0430: Unknown result type (might be due to invalid IL or missing references)
		//IL_2417: Unknown result type (might be due to invalid IL or missing references)
		//IL_187a: Unknown result type (might be due to invalid IL or missing references)
		//IL_187f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0457: Unknown result type (might be due to invalid IL or missing references)
		//IL_045c: Unknown result type (might be due to invalid IL or missing references)
		//IL_2441: Unknown result type (might be due to invalid IL or missing references)
		//IL_2446: Unknown result type (might be due to invalid IL or missing references)
		//IL_242d: Unknown result type (might be due to invalid IL or missing references)
		//IL_188a: Unknown result type (might be due to invalid IL or missing references)
		//IL_1898: Unknown result type (might be due to invalid IL or missing references)
		//IL_189d: Unknown result type (might be due to invalid IL or missing references)
		//IL_18a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_2452: Unknown result type (might be due to invalid IL or missing references)
		//IL_2456: Unknown result type (might be due to invalid IL or missing references)
		//IL_2458: Unknown result type (might be due to invalid IL or missing references)
		//IL_244d: Unknown result type (might be due to invalid IL or missing references)
		//IL_182a: Unknown result type (might be due to invalid IL or missing references)
		//IL_183a: Unknown result type (might be due to invalid IL or missing references)
		//IL_183f: Unknown result type (might be due to invalid IL or missing references)
		//IL_1844: Unknown result type (might be due to invalid IL or missing references)
		//IL_1cab: Unknown result type (might be due to invalid IL or missing references)
		//IL_2471: Unknown result type (might be due to invalid IL or missing references)
		//IL_2473: Unknown result type (might be due to invalid IL or missing references)
		//IL_247b: Unknown result type (might be due to invalid IL or missing references)
		//IL_2481: Unknown result type (might be due to invalid IL or missing references)
		//IL_069f: Unknown result type (might be due to invalid IL or missing references)
		//IL_06a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_06a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_06a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_06ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_06b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0815: Unknown result type (might be due to invalid IL or missing references)
		//IL_081a: Unknown result type (might be due to invalid IL or missing references)
		//IL_06f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_06f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_06f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_06fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_1f72: Unknown result type (might be due to invalid IL or missing references)
		//IL_1f78: Unknown result type (might be due to invalid IL or missing references)
		//IL_1f7d: Unknown result type (might be due to invalid IL or missing references)
		//IL_1f82: Unknown result type (might be due to invalid IL or missing references)
		//IL_07bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_07bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_07c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_07c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0750: Unknown result type (might be due to invalid IL or missing references)
		//IL_0769: Unknown result type (might be due to invalid IL or missing references)
		//IL_09c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_09c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bed: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bf2: Unknown result type (might be due to invalid IL or missing references)
		//IL_099d: Unknown result type (might be due to invalid IL or missing references)
		//IL_09a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bad: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bb6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bbb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a16: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a1f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a24: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a29: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f0f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f14: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a79: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a9d: Unknown result type (might be due to invalid IL or missing references)
		//IL_11b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_11b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f38: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f52: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f73: Unknown result type (might be due to invalid IL or missing references)
		//IL_0f79: Unknown result type (might be due to invalid IL or missing references)
		//IL_0d01: Unknown result type (might be due to invalid IL or missing references)
		//IL_0d07: Unknown result type (might be due to invalid IL or missing references)
		//IL_1152: Unknown result type (might be due to invalid IL or missing references)
		//IL_1158: Unknown result type (might be due to invalid IL or missing references)
		//IL_115d: Unknown result type (might be due to invalid IL or missing references)
		//IL_1162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0ac8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0ad5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0ada: Unknown result type (might be due to invalid IL or missing references)
		//IL_0adf: Unknown result type (might be due to invalid IL or missing references)
		//IL_0d30: Unknown result type (might be due to invalid IL or missing references)
		//IL_0d35: Unknown result type (might be due to invalid IL or missing references)
		//IL_100f: Unknown result type (might be due to invalid IL or missing references)
		//IL_1029: Unknown result type (might be due to invalid IL or missing references)
		//IL_1351: Unknown result type (might be due to invalid IL or missing references)
		//IL_1356: Unknown result type (might be due to invalid IL or missing references)
		//IL_135e: Unknown result type (might be due to invalid IL or missing references)
		//IL_1364: Unknown result type (might be due to invalid IL or missing references)
		//IL_12ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_12f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_12f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_12fc: Unknown result type (might be due to invalid IL or missing references)
		Snapshot s = new Snapshot
		{
			GameState = "unknown",
			UncoveredDoorIdx = -1
		};
		Scene val = SceneManager.GetActiveScene();
		s.SceneName = val.name;
		LoadSlotPack(s.SceneName);
		LocalGamestate instance = LocalGamestate.Instance;
		if ((Object)(object)instance == (Object)null)
		{
			s.GameState = "no-gamestate";
			return s;
		}
		s.GameState = ((object)instance.CurrentState/*cast due to constrained. prefix*/).ToString();
		if ((int)instance.CurrentState != 1)
		{
			return s;
		}
		PlayerMovement instance2 = PlayerMovement.instance;
		if ((Object)(object)instance2 == (Object)null)
		{
			s.GameState = "no-hero";
			return s;
		}
		s.HeroPos = ((Component)instance2).transform.position;
		if ((Object)(object)instance2.Hp != (Object)null)
		{
			s.HeroHpPct = instance2.Hp.HpPercentage;
		}
		s.HeroDead = instance2.Dead;
		PlayerInteraction instance3 = PlayerInteraction.instance;
		if ((Object)(object)instance3 != (Object)null)
		{
			s.Balance = instance3.Balance;
			s.CoreBalance = instance3.EnergyCoreBalance;
		}
		DayNightCycle instance4 = DayNightCycle.Instance;
		if ((Object)(object)instance4 != (Object)null)
		{
			s.IsNight = (int)instance4.CurrentTimestate == 1;
			s.DayTimeLeft = instance4.RemainingAutoDayTime;
		}
		TagManager instance5 = TagManager.instance;
		if ((Object)(object)instance5 == (Object)null)
		{
			s.GameState = "no-tagmanager";
			return s;
		}
		CastleCenter instance6 = CastleCenter.instance;
		Vector3 val2 = (((Object)(object)instance6 != (Object)null) ? ((Component)instance6).transform.position : CastleCenter.CastleCenterPosition);
		if ((Object)(object)instance6 == (Object)null && val2 == Vector3.zero)
		{
			instance5.FindAllTaggedObjectsWithTag(castleBuf, (ETag)3);
			if (castleBuf.Count > 0 && (Object)(object)castleBuf[0] != (Object)null)
			{
				val2 = ((Component)castleBuf[0]).transform.position;
			}
		}
		if (val2 != Vector3.zero)
		{
			s.HasCastle = true;
			s.CastlePos = val2;
			s.CastleDist = FlatDist(s.CastlePos, s.HeroPos);
			Vector3 val3 = ((castleStands != null) ? BestStandRecs(castleStands, s.HeroPos) : BestStand(FindSlot(val2), s.HeroPos));
			s.HasCastleStand = val3 != Vector3.zero;
			if (s.HasCastleStand)
			{
				s.CastleStandPos = val3;
			}
			s.CastleHpPct = -1f;
			if ((Object)(object)instance6 != (Object)null)
			{
				TaggedObject componentInParent = ((Component)instance6).GetComponentInParent<TaggedObject>();
				Hp val4 = (((Object)(object)componentInParent != (Object)null) ? componentInParent.Hp : ((Component)instance6).GetComponentInParent<Hp>(true));
				if ((Object)(object)val4 == (Object)null)
				{
					val4 = ((Component)instance6).GetComponentInChildren<Hp>(true);
				}
				if ((Object)(object)val4 != (Object)null)
				{
					s.CastleHpPct = val4.HpPercentage;
				}
				if (!castleHpLogged)
				{
					castleHpLogged = true;
					ManualLogSource log = Plugin.Log;
					if (log != null)
					{
						log.LogWarning((object)(((Object)(object)val4 != (Object)null) ? ("[bot] castle-hp: found on '" + ((Object)((Component)val4).gameObject).name + "' " + $"hp={val4.HpValue}/{val4.maxHp} pct={val4.HpPercentage:0.###} alive={val4.Alive}") : ("[bot] castle-hp: no Hp on CastleCenter chain " + $"(up={((Component)instance6).GetComponentsInParent<Hp>(true).Length} " + $"down={((Component)instance6).GetComponentsInChildren<Hp>(true).Length})")));
					}
				}
			}
		}
		if (Time.unscaledTime >= shrineScanAt)
		{
			shrineScanAt = Time.unscaledTime + 1f;
			shrineCache = Object.FindObjectsOfType<Shrine>(true);
		}
		Vector3 val6;
		if (shrineCache != null)
		{
			s.ShrineCount = 0;
			s.ShrineDist = float.MaxValue;
			Shrine[] array = shrineCache;
			foreach (Shrine val5 in array)
			{
				if (!((Object)(object)val5 == (Object)null) && !val5.ShrineHasBeenActivated)
				{
					s.ShrineCount++;
					val6 = ((Component)val5).transform.position - s.HeroPos;
					float sqrMagnitude = val6.sqrMagnitude;
					if (sqrMagnitude < s.ShrineDist)
					{
						s.ShrineDist = sqrMagnitude;
						s.ShrinePos = ((Component)val5).transform.position;
					}
				}
			}
			if (s.ShrineCount == 0)
			{
				s.ShrineDist = 0f;
			}
			else
			{
				s.ShrineDist = Mathf.Sqrt(s.ShrineDist);
			}
		}
		EnemySpawner instance7 = EnemySpawner.instance;
		if ((Object)(object)instance7 != (Object)null)
		{
			s.Wave = instance7.Wavenumber;
			s.WaveTotal = instance7.WaveCount;
			s.EnemyCount = instance7.NumberOfEnemiesOnTheMap;
			WaveInfo waveInfoForNextWave = EnemySpawner.GetWaveInfoForNextWave();
			if (waveInfoForNextWave != null && waveInfoForNextWave.enemies != null)
			{
				s.NextWaveGold = waveInfoForNextWave.goldReward;
				foreach (WaveEnemyInfo enemy in waveInfoForNextWave.enemies)
				{
					if (enemy != null)
					{
						s.NextWaveCount += enemy.enemyCount;
						if (enemy.eliteEnemy)
						{
							s.NextWaveElites += enemy.enemyCount;
						}
						if (enemy.maxHP > s.NextWaveMaxHp)
						{
							s.NextWaveMaxHp = enemy.maxHP;
						}
						if (enemy.speed > s.NextWaveSpeed)
						{
							s.NextWaveSpeed = enemy.speed;
						}
						if (enemy.range > s.NextWaveFoeRange)
						{
							s.NextWaveFoeRange = enemy.range;
						}
					}
				}
			}
			int wavenumber = instance7.Wavenumber;
			s.FinalWaveNext = instance7.FinalWaveComingUp(wavenumber) || wavenumber >= instance7.WaveCount - 1;
			s.WaveBeforeFinalNext = instance7.WaveBeforeFinalWaveComingUp(wavenumber);
		}
		else
		{
			s.EnemyCount = instance5.EnemyUnits.Count;
		}
		if (s.DoorAnchors == null)
		{
			BuildDoors(ref s);
		}
		if (sceneDoorAnchors != null && doorFoes != null)
		{
			for (int j = 0; j < doorFoes.Length; j++)
			{
				doorFoes[j] = 0;
			}
		}
		s.NearestEnemyDist = float.MaxValue;
		float num = float.MaxValue;
		Vector3 val7 = Vector3.zero;
		int num2 = 0;
		int num3 = 0;
		foreach (TaggedObject enemyUnit in instance5.EnemyUnits)
		{
			if ((Object)(object)enemyUnit == (Object)null)
			{
				continue;
			}
			Vector3 position = ((Component)enemyUnit).transform.position;
			val6 = position - s.HeroPos;
			float sqrMagnitude2 = val6.sqrMagnitude;
			if (sqrMagnitude2 < s.NearestEnemyDist)
			{
				s.NearestEnemyDist = sqrMagnitude2;
				s.NearestEnemy = enemyUnit;
			}
			if (sqrMagnitude2 < 64f)
			{
				num3++;
			}
			if (s.HasCastle)
			{
				val6 = position - s.CastlePos;
				float sqrMagnitude3 = val6.sqrMagnitude;
				if (sqrMagnitude3 < num)
				{
					num = sqrMagnitude3;
					s.CastleThreat = enemyUnit;
				}
			}
			if (sceneDoorAnchors != null && doorFoes != null)
			{
				int num4 = -1;
				float num5 = 900f;
				for (int k = 0; k < sceneDoorAnchors.Length && k < doorFoes.Length; k++)
				{
					float num6 = sceneDoorAnchors[k].x - position.x;
					float num7 = sceneDoorAnchors[k].z - position.z;
					float num8 = num6 * num6 + num7 * num7;
					if (num8 < num5)
					{
						num5 = num8;
						num4 = k;
					}
				}
				if (num4 >= 0)
				{
					doorFoes[num4]++;
				}
			}
			val7 += position;
			num2++;
		}
		s.EnemyCount = num2;
		s.EnemiesNearHero = num3;
		if ((Object)(object)s.NearestEnemy != (Object)null)
		{
			s.NearestEnemyPos = ((Component)s.NearestEnemy).transform.position;
			s.NearestEnemyDist = Mathf.Sqrt(s.NearestEnemyDist);
		}
		else
		{
			s.NearestEnemyDist = 0f;
		}
		if ((Object)(object)s.CastleThreat != (Object)null)
		{
			s.CastleThreatDist = Mathf.Sqrt(num);
		}
		else
		{
			s.CastleThreatDist = s.NearestEnemyDist;
			s.CastleThreat = s.NearestEnemy;
		}
		if ((Object)(object)s.NearestEnemy != (Object)null)
		{
			Hp val8 = ((Component)s.NearestEnemy).GetComponentInChildren<Hp>(true);
			if ((Object)(object)val8 == (Object)null)
			{
				val8 = ((Component)s.NearestEnemy).GetComponentInParent<Hp>();
			}
			if ((Object)(object)val8 != (Object)null)
			{
				s.NearEnemyHp = val8.HpValue;
				s.NearEnemyElite = val8.Elite;
			}
			AutoAttack val9 = ((Component)s.NearestEnemy).GetComponentInChildren<AutoAttack>(true);
			if ((Object)(object)val9 == (Object)null)
			{
				val9 = ((Component)s.NearestEnemy).GetComponentInParent<AutoAttack>();
			}
			if ((Object)(object)val9 != (Object)null)
			{
				foreach (TargetPriority targetPriority in val9.targetPriorities)
				{
					if (targetPriority != null && targetPriority.range > s.NearEnemyRange)
					{
						s.NearEnemyRange = targetPriority.range;
					}
				}
			}
		}
		if (s.DoorAnchors == null)
		{
			BuildDoors(ref s);
		}
		if (s.DoorAnchors != null)
		{
			for (int l = 0; l < doorUnit.Length; l++)
			{
				doorUnit[l] = 0;
			}
			s.DoorsCovered = 0;
			s.FreeUnits = 0;
			s.UncoveredDoorPos = Vector3.zero;
			s.UncoveredDoorLine = null;
			s.UncoveredDoorIdx = -1;
		}
		if (instance5.PlayerUnits != null)
		{
			Vector3 val10 = Vector3.zero;
			foreach (TaggedObject playerUnit in instance5.PlayerUnits)
			{
				if ((Object)(object)playerUnit == (Object)null || (Object)(object)playerUnit.Hp == (Object)null || !playerUnit.Hp.Alive)
				{
					continue;
				}
				val10 += ((Component)playerUnit).transform.position;
				s.AllyCount++;
				bool flag = false;
				PathfindMovementPlayerunit component = ((Component)playerUnit).GetComponent<PathfindMovementPlayerunit>();
				if (s.DoorAnchors != null)
				{
					int num9 = -1;
					float num10 = 625f;
					for (int m = 0; m < s.DoorAnchors.Length; m++)
					{
						float num11 = s.DoorAnchors[m].x - ((Component)playerUnit).transform.position.x;
						float num12 = s.DoorAnchors[m].z - ((Component)playerUnit).transform.position.z;
						int num13;
						if ((Object)(object)component != (Object)null && !component.FollowingPlayer)
						{
							if (!component.HoldPosition)
							{
								val6 = component.HomePosition - s.DoorAnchors[m];
								num13 = ((val6.sqrMagnitude < 64f) ? 1 : 0);
							}
							else
							{
								num13 = 1;
							}
						}
						else
						{
							num13 = 0;
						}
						bool flag2 = (byte)num13 != 0;
						float num14 = num11 * num11 + num12 * num12;
						if ((num14 < num10) & flag2)
						{
							num10 = num14;
							num9 = m;
						}
					}
					if (num9 >= 0)
					{
						flag = true;
						if (doorUnit != null && num9 < doorUnit.Length)
						{
							doorUnit[num9]++;
						}
					}
				}
				if ((Object)(object)component != (Object)null && component.FollowingPlayer)
				{
					s.EscortUnits++;
				}
				else if (!flag)
				{
					s.FreeUnits++;
				}
			}
			if (s.AllyCount > 0)
			{
				s.AllyCentroid = val10 / (float)s.AllyCount;
			}
		}
		if (s.DoorAnchors != null)
		{
			string pkey = PKey(ref s);
			s.DoorCount = s.DoorAnchors.Length;
			s.DoorsCovered = 0;
			s.UncoveredDoorPos = Vector3.zero;
			s.UncoveredDoorLine = null;
			s.UncoveredDoorIdx = -1;
			s.UncoveredDoorHot = false;
			float num15 = float.MaxValue;
			int num16 = 0;
			for (int num17 = 1; num17 >= 0; num17--)
			{
				for (int n = 0; n < s.DoorAnchors.Length; n++)
				{
					if (DoorParked(n))
					{
						if (num17 == 1)
						{
							s.DoorsCovered++;
						}
					}
					else if (doorUnit != null && n < doorUnit.Length && doorUnit[n] >= DoorTarget(n, pkey))
					{
						if (num17 == 1)
						{
							s.DoorsCovered++;
						}
					}
					else if (doorClaim != null && n < doorClaim.Length && Time.unscaledTime - doorClaim[n] < 25f)
					{
						if (num17 == 1)
						{
							s.DoorsCovered++;
							num16++;
						}
					}
					else
					{
						if ((doorFoes != null && n < doorFoes.Length && doorFoes[n] > 0) != (num17 == 1))
						{
							continue;
						}
						float num18 = FlatDist(s.DoorAnchors[n], s.CastlePos);
						if (num17 == 1 || num18 < num15)
						{
							if (num17 == 0)
							{
								num15 = num18;
							}
							s.UncoveredDoorPos = s.DoorAnchors[n];
							s.UncoveredDoorIdx = n;
							s.UncoveredDoorLine = ((n < (s.DoorLines?.Length ?? 0)) ? s.DoorLines[n] : "");
							s.UncoveredDoorTarget = DoorTarget(n, pkey);
							s.UncoveredDoorHot = num17 == 1;
							if (num17 == 1)
							{
								break;
							}
						}
					}
				}
			}
			s.DoorsClaimed = num16;
			s.HasUncoveredDoor = s.UncoveredDoorIdx >= 0;
			int num19 = 16;
			if (s.DoorAnchors != null)
			{
				int num20 = 0;
				for (int num21 = 0; num21 < s.DoorAnchors.Length; num21++)
				{
					num20 += DoorTarget(num21, pkey);
				}
				num19 = Mathf.Min(Mathf.Max(num20, 16), 60);
			}
			if (s.NextWaveCount > 0)
			{
				num19 = Mathf.Max(num19, (int)((float)s.NextWaveCount * 1.2f));
			}
			if (Strat.ArmyTarget > num19)
			{
				num19 = Strat.ArmyTarget;
			}
			if (Coach.ArmyTargetFloor > 0)
			{
				num19 = Coach.ArmyTargetFloor;
			}
			s.ArmyTarget = num19;
		}
		s.SelfDefendRange = ((Coach.HeroPosture == "fighter") ? 12f : 7f);
		string stateKey = PKey(ref s);
		string s2 = Policy.Eval("night", new string[3] { "150", "240", "330" }, stateKey);
		s.DayBudget = (float.TryParse(s2, out var result) ? result : 240f);
		if ((Object)(object)s.CastleThreat != (Object)null && s.HasCastle)
		{
			float num22 = (s.RedAlertRadius = ProtectedRadius(ref s));
			float num23 = float.MaxValue;
			Vector3 position2 = ((Component)s.CastleThreat).transform.position;
			if (s.DoorAnchors != null)
			{
				for (int num24 = 0; num24 < s.DoorAnchors.Length; num24++)
				{
					float num25 = s.DoorAnchors[num24].x - position2.x;
					float num26 = s.DoorAnchors[num24].z - position2.z;
					if (num25 * num25 + num26 * num26 < 1600f)
					{
						float num27 = FlatDist(s.DoorAnchors[num24], s.CastlePos);
						if (num27 < num23)
						{
							num23 = num27;
						}
					}
				}
			}
			bool num28 = num23 < float.MaxValue && s.CastleThreatDist < num23 - 6f;
			bool flag3 = s.CastleThreatDist < Mathf.Min(num22, 30f);
			if (num28 | flag3)
			{
				s.RedAlert = true;
				if (s.DoorAnchors != null)
				{
					float num29 = float.MaxValue;
					int num30 = -1;
					for (int num31 = 0; num31 < s.DoorAnchors.Length; num31++)
					{
						float num32 = s.DoorAnchors[num31].x - position2.x;
						float num33 = s.DoorAnchors[num31].z - position2.z;
						float num34 = num32 * num32 + num33 * num33;
						if (num34 < num29)
						{
							num29 = num34;
							num30 = num31;
						}
					}
					if (num30 >= 0 && !doorBreach[num30])
					{
						doorBreach[num30] = true;
						BreachCount++;
						Policy.Pulse(-0.4f);
						ManualLogSource log2 = Plugin.Log;
						if (log2 != null)
						{
							log2.LogWarning((object)("[bot] BREACH on door '" + ((num30 < (s.DoorLines?.Length ?? 0)) ? s.DoorLines[num30] : "?") + "' — squad target raised"));
						}
					}
				}
			}
		}
		else
		{
			s.RedAlert = false;
		}
		s.PolicyKey = PKey(ref s);
		s.NearestCoinDist = float.MaxValue;
		int count = instance5.freeCoins.Count;
		for (int num35 = 0; num35 < count; num35++)
		{
			Coin val11 = instance5.freeCoins[num35];
			if (!((Object)(object)val11 == (Object)null) && val11.IsFree && (CoinSkip == null || !CoinSkip(val11)))
			{
				s.CoinCount++;
				val6 = ((Component)val11).transform.position - s.HeroPos;
				float sqrMagnitude4 = val6.sqrMagnitude;
				if (sqrMagnitude4 < s.NearestCoinDist)
				{
					s.NearestCoinDist = sqrMagnitude4;
					s.NearestCoin = val11;
				}
			}
		}
		if ((Object)(object)s.NearestCoin != (Object)null)
		{
			s.NearestCoinPos = ((Component)s.NearestCoin).transform.position;
			s.NearestCoinDist = Mathf.Sqrt(s.NearestCoinDist);
		}
		else
		{
			s.NearestCoinDist = 0f;
		}
		s.OnLevelSelect = (Object)(object)LevelSelectManager.instance != (Object)null;
		if (Time.unscaledTime >= levelScanAt)
		{
			levelScanAt = Time.unscaledTime + 1f;
			levelCache = Object.FindObjectsOfType<LevelInteractor>(false);
			s.InteractorCount = Object.FindObjectsOfType<InteractorBase>(true).Length;
		}
		if (levelCache != null)
		{
			float num36 = float.NegativeInfinity;
			float num37 = float.MaxValue;
			LevelProgressManager instance8 = LevelProgressManager.instance;
			LevelInteractor[] array2 = levelCache;
			foreach (LevelInteractor val12 in array2)
			{
				if (!((Object)(object)val12 == (Object)null) && ((Behaviour)val12).isActiveAndEnabled && val12.CanBePlayed)
				{
					s.LevelCount++;
					bool flag4 = (Object)(object)instance8 != (Object)null && (Object)(object)val12.levelInfo != (Object)null && instance8.GetLevelDataForScene(val12.levelInfo.sceneName).beatenBest;
					float num38;
					if (LevelScore != null)
					{
						num38 = LevelScore(val12, flag4);
					}
					else
					{
						num38 = (flag4 ? 0f : 1f);
					}
					val6 = val12.PlayerTeleportPosition - s.HeroPos;
					float sqrMagnitude5 = val6.sqrMagnitude;
					if (num38 > num36 || (num38 == num36 && sqrMagnitude5 < num37))
					{
						num36 = num38;
						num37 = sqrMagnitude5;
						s.NearestLevel = val12;
					}
				}
			}
			if ((Object)(object)s.NearestLevel != (Object)null)
			{
				s.NearestLevelPos = s.NearestLevel.PlayerTeleportPosition;
				s.NearestLevelDist = FlatDist(s.NearestLevelPos, s.HeroPos);
			}
			else
			{
				s.NearestLevelDist = 0f;
			}
		}
		Nighthorn val13 = Nighthorn.instance;
		if ((Object)(object)val13 == (Object)null)
		{
			try
			{
				Nighthorn[] array3 = Object.FindObjectsOfType<Nighthorn>();
				if (array3 != null && array3.Length != 0)
				{
					val13 = array3[0];
				}
			}
			catch
			{
			}
		}
		if ((Object)(object)val13 != (Object)null && ((Behaviour)val13).isActiveAndEnabled)
		{
			s.HasHorn = true;
			s.Horn = val13;
			s.HornPos = ((Component)val13).transform.position;
			s.HornDist = FlatDist(s.HornPos, s.HeroPos);
		}
		if (!s.HasHorn && Time.unscaledTime - hornScanAt > 15f)
		{
			hornScanAt = Time.unscaledTime;
			try
			{
				InteractorBase[] array4 = Object.FindObjectsOfType<InteractorBase>(true);
				bool flag5 = hornDumpScene != (s.SceneName ?? "");
				hornDumpScene = s.SceneName ?? "";
				if (flag5)
				{
					ManualLogSource log3 = Plugin.Log;
					if (log3 != null)
					{
						log3.LogInfo((object)$"[bot] horn scan '{s.SceneName}': {array4?.Length ?? (-1)} interactors");
					}
				}
				InteractorBase[] array5 = array4;
				foreach (InteractorBase val14 in array5)
				{
					if ((Object)(object)val14 == (Object)null || !((Behaviour)val14).isActiveAndEnabled)
					{
						continue;
					}
					string text = ((Object)val14).name ?? "";
					string text2 = "";
					try
					{
						Type type = ((object)val14).GetType();
						object obj2 = null;
						Type type2 = type;
						while (type2 != null && obj2 == null)
						{
							obj2 = type2.GetField("targetBuilding", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(val14) ?? type2.GetProperty("targetBuilding", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(val14) ?? type2.GetField("building", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(val14) ?? type2.GetProperty("building", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(val14);
							type2 = type2.BaseType;
						}
						Component val15 = (Component)((obj2 is Component) ? obj2 : null);
						if (val15 != null)
						{
							text2 = ((Object)val15).name ?? ((object)val15).GetType().Name;
						}
						else
						{
							text2 = ((obj2 != null) ? obj2.GetType().Name : "");
						}
					}
					catch
					{
					}
					if (flag5 && text2 != "")
					{
						ManualLogSource log4 = Plugin.Log;
						if (log4 != null)
						{
							log4.LogInfo((object)$"[bot] interactor: '{((object)val14).GetType().Name}/{text}' b='{text2}' at {((Component)val14).transform.position}");
						}
					}
					if (text.IndexOf("horn", StringComparison.OrdinalIgnoreCase) >= 0 || text.IndexOf("night", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("horn", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("night", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("bell", StringComparison.OrdinalIgnoreCase) >= 0)
					{
						ManualLogSource log5 = Plugin.Log;
						if (log5 != null)
						{
							log5.LogInfo((object)("[bot] horn found via interactor '" + text + "'"));
						}
						s.HasHorn = true;
						s.HornPos = ((Component)val14).transform.position;
						s.HornDist = FlatDist(s.HornPos, s.HeroPos);
						HornBi = val14;
						break;
					}
				}
			}
			catch (Exception ex)
			{
				ManualLogSource log6 = Plugin.Log;
				if (log6 != null)
				{
					log6.LogWarning((object)("[bot] horn scan failed: " + ex.Message));
				}
			}
		}
		if ((Object)(object)HornBi != (Object)null && !s.HasHorn && ((Behaviour)HornBi).isActiveAndEnabled)
		{
			s.HasHorn = true;
			s.HornPos = ((Component)HornBi).transform.position;
			s.HornDist = FlatDist(s.HornPos, s.HeroPos);
		}
		Vector3 val16 = Vector3.zero;
		int num39 = 0;
		if (s.IsNight && num2 > 0)
		{
			val16 = val7;
			num39 = num2;
		}
		else if (!s.IsNight && (Object)(object)instance7 != (Object)null && s.Wave >= 0 && s.Wave < instance7.waves.Count)
		{
			Wave val17 = instance7.waves[s.Wave];
			if (val17 != null && val17.spawns != null)
			{
				foreach (Spawn spawn in val17.spawns)
				{
					if (spawn == null)
					{
						continue;
					}
					if ((Object)(object)spawn.spawnLine != (Object)null && spawn.spawnLine.childCount > 0)
					{
						for (int num40 = 0; num40 < spawn.spawnLine.childCount; num40++)
						{
							val16 += spawn.spawnLine.GetChild(num40).position;
							num39++;
						}
					}
					else if ((Object)(object)spawn.enemyPrefab != (Object)null)
					{
						val = spawn.enemyPrefab.scene;
						if (val.isLoaded)
						{
							val16 += spawn.enemyPrefab.transform.position;
							num39++;
						}
					}
				}
			}
		}
		if (num39 > 0 && s.HasCastle)
		{
			Vector3 val18 = val16 / (float)num39;
			Vector3 val19 = val18 - s.CastlePos;
			val19.y = 0f;
			if (val19.sqrMagnitude > 0.01f)
			{
				s.ThreatAnchor = s.CastlePos + val19.normalized * 9f;
				s.HasThreatAnchor = true;
			}
			Vector3 val20 = InterceptAnchor(val18, s.CastlePos);
			if (val20 != Vector3.zero)
			{
				s.ThreatAnchor = val20;
				s.HasThreatAnchor = true;
			}
		}
		if (s.IsNight && buildIgnore.Count > 0)
		{
			buildIgnore.Clear();
		}
		if (buildIgnore.Count > 64)
		{
			List<BuildingInteractor> list = new List<BuildingInteractor>();
			float unscaledTime = Time.unscaledTime;
			foreach (KeyValuePair<BuildingInteractor, float> item in buildIgnore)
			{
				if ((Object)(object)item.Key == (Object)null || item.Value <= unscaledTime)
				{
					list.Add(item.Key);
				}
			}
			foreach (BuildingInteractor item2 in list)
			{
				buildIgnore.Remove(item2);
			}
		}
		s.ArmyAnchor = NextWaveAnchor(s.Wave, s.CastlePos);
		s.HasArmyAnchor = s.ArmyAnchor != Vector3.zero;
		s.ArmyAnchorLine = armyAnchorLine;
		s.NearestBuildDist = float.MaxValue;
		int num41 = int.MinValue;
		List<BuildingInteractor> playerBuildingInteractors = instance5.playerBuildingInteractors;
		if ((Object)(object)HeldBuildRef != (Object)null)
		{
			bool flag6 = false;
			for (int num42 = 0; num42 < playerBuildingInteractors.Count; num42++)
			{
				if (playerBuildingInteractors[num42] == HeldBuildRef)
				{
					flag6 = true;
					break;
				}
			}
			if (!flag6)
			{
				val6 = ((Component)HeldBuildRef).transform.position - s.HeroPos;
				float sqrMagnitude6 = val6.sqrMagnitude;
				bool flag7 = (Object)(object)ChoiceManager.instance != (Object)null && ChoiceManager.instance.ChoiceCoroutineRunning;
				if (sqrMagnitude6 <= (flag7 ? 400f : 144f) && !IsInteractorComplete(HeldBuildRef))
				{
					s.NearestBuild = HeldBuildRef;
					s.NearestBuildDist = sqrMagnitude6;
					s.NearestBuildScore = 100000;
					num41 = int.MaxValue;
					s.BuildCount++;
				}
			}
		}
		for (int num43 = 0; num43 < playerBuildingInteractors.Count; num43++)
		{
			BuildingInteractor val21 = playerBuildingInteractors[num43];
			if ((Object)(object)val21 == (Object)null)
			{
				continue;
			}
			if (preferBuildKey >= 0 && (((Object)val21).GetInstanceID() == preferBuildKey || val21 == HeldBuildRef))
			{
				val6 = ((Component)val21).transform.position - s.HeroPos;
				float sqrMagnitude7 = val6.sqrMagnitude;
				if (IsInteractorComplete(val21))
				{
					s.HeldBuildComplete = true;
				}
				float num44 = (((Object)(object)ChoiceManager.instance != (Object)null && ChoiceManager.instance.ChoiceCoroutineRunning) ? 400f : 144f);
				if (sqrMagnitude7 <= num44 && !IsInteractorComplete(val21))
				{
					s.NearestBuildDist = sqrMagnitude7;
					s.NearestBuild = val21;
					s.NearestBuildScore = 100000;
					num41 = int.MaxValue;
					s.BuildCount++;
					continue;
				}
			}
			if (!((InteractorBase)val21).CanBeInteractedWith || IsInteractorFinished(val21))
			{
				continue;
			}
			if (buildIgnore.Count > 0 && buildIgnore.TryGetValue(val21, out var value))
			{
				if (value > Time.unscaledTime)
				{
					continue;
				}
				buildIgnore.Remove(val21);
			}
			if (Memory.IsParked(s.SceneName ?? "", ((Component)val21).transform.position))
			{
				continue;
			}
			BuildSlot targetBuilding = val21.targetBuilding;
			if ((Object)(object)targetBuilding != (Object)null && ((!((Component)targetBuilding).gameObject.activeInHierarchy && targetBuilding.StartDeactivated && ((Object)(object)targetBuilding.ActivatorBuilding == (Object)null || targetBuilding.ActivatorBuilding.Level <= targetBuilding.ActivatorLevel)) || targetBuilding.NextUpgradeOrBuildEnergyCoreCost > s.CoreBalance || (!val21.canBeHarvested && s.Balance <= 0 && (targetBuilding.NextUpgradeOrBuildCost > 0 || targetBuilding.NextUpgradeOrBuildEnergyCoreCost > 0))))
			{
				continue;
			}
			int num45 = 10;
			if (val21.canBeHarvested)
			{
				num45 += 1000;
			}
			if ((Object)(object)targetBuilding != (Object)null)
			{
				GetBuildClass(targetBuilding, out var military, out var income);
				bool flag8 = s.Balance < 10;
				bool flag9 = s.ArmyTarget > 0 && s.AllyCount < s.ArmyTarget;
				bool flag10 = !flag8 && (s.RedAlert || s.DoorsCovered < s.DoorCount);
				num45 += military * (flag9 ? 600 : (flag10 ? 400 : (100 + Mathf.Min(s.NextWaveCount * 15, 300))));
				string policyFocus;
				if (string.IsNullOrEmpty(Coach.BuildFocus))
				{
					policyFocus = ((!string.IsNullOrEmpty(Strat.Focus)) ? Strat.Focus : Policy.Eval("build_focus", new string[4] { "military", "income", "defense", "balanced" }, s.PolicyKey ?? ""));
				}
				else
				{
					policyFocus = Coach.BuildFocus;
				}
				string text3 = (s.PolicyFocus = policyFocus);
				if (text3 == "military")
				{
					num45 += military * 200;
				}
				else if (text3 == "income" && income > 0)
				{
					num45 += income * 60;
				}
				else if (text3 == "defense")
				{
					num45 += military * 120;
				}
				if (flag8 && income > 0)
				{
					num45 += Mathf.Min(income, 15) * 40;
				}
				if (military > 0 && (s.FinalWaveNext || s.NextWaveCount >= 30))
				{
					num45 += military * 100;
				}
				if (income > 0)
				{
					num45 += 30 + Mathf.Min(income, 10) * 3;
				}
				string[] array6 = OpenBuildOrder();
				if (array6.Length != 0)
				{
					string value2 = BuildCat(targetBuilding.buildingName);
					int num46 = Array.IndexOf(array6, value2);
					if (num46 >= 0)
					{
						num45 += ((!flag8) ? ((num46 == 0) ? 1200 : (600 - num46 * 150)) : 0);
					}
				}
			}
			s.BuildCount++;
			val6 = ((Component)val21).transform.position - s.HeroPos;
			float sqrMagnitude8 = val6.sqrMagnitude;
			num45 += Mathf.Max(0, 40 - (int)Mathf.Sqrt(sqrMagnitude8)) * 3;
			if (preferBuildKey >= 0 && ((Object)val21).GetInstanceID() == preferBuildKey && !IsInteractorComplete(val21) && sqrMagnitude8 <= 144f)
			{
				s.NearestBuildDist = sqrMagnitude8;
				s.NearestBuild = val21;
				s.NearestBuildScore = num45 + 100000;
				num41 = int.MaxValue;
			}
			else if (num45 > num41 || (num45 == num41 && sqrMagnitude8 < s.NearestBuildDist))
			{
				num41 = num45;
				s.NearestBuildDist = sqrMagnitude8;
				s.NearestBuild = val21;
				s.NearestBuildScore = num45;
			}
		}
		if (!s.IsNight && Time.unscaledTime > slotDumpAt)
		{
			slotDumpAt = Time.unscaledTime + 30f;
			StringBuilder stringBuilder = new StringBuilder();
			for (int num47 = 0; num47 < playerBuildingInteractors.Count; num47++)
			{
				BuildingInteractor val22 = playerBuildingInteractors[num47];
				if ((Object)(object)val22 == (Object)null)
				{
					continue;
				}
				string text4 = (((Object)(object)val22.targetBuilding != (Object)null) ? val22.targetBuilding.buildingName : ((Object)val22).name);
				if (text4 != null && (text4.IndexOf("barrack", StringComparison.OrdinalIgnoreCase) >= 0 || text4.IndexOf("archer", StringComparison.OrdinalIgnoreCase) >= 0 || text4.IndexOf("militia", StringComparison.OrdinalIgnoreCase) >= 0 || text4.IndexOf("wall", StringComparison.OrdinalIgnoreCase) >= 0 || text4.IndexOf("gate", StringComparison.OrdinalIgnoreCase) >= 0 || text4.IndexOf("castle", StringComparison.OrdinalIgnoreCase) >= 0))
				{
					if (text4.IndexOf("castle", StringComparison.OrdinalIgnoreCase) >= 0)
					{
						BuildSlot targetBuilding2 = val22.targetBuilding;
						stringBuilder.Append(text4).Append("(can=").Append(((InteractorBase)val22).CanBeInteractedWith)
							.Append(((Object)(object)targetBuilding2 != (Object)null) ? (",lvl=" + targetBuilding2.Level + ",upgs=" + ((targetBuilding2.OwnUpgrades != null) ? targetBuilding2.OwnUpgrades.Count : (-1)) + ",canUp=" + targetBuilding2.CanBeUpgraded) : "")
							.Append(");");
					}
					else
					{
						BuildSlot targetBuilding3 = val22.targetBuilding;
						StringBuilder stringBuilder2 = stringBuilder.Append(text4).Append("(inter=").Append(((Behaviour)val22).isActiveAndEnabled)
							.Append(",can=")
							.Append(((InteractorBase)val22).CanBeInteractedWith)
							.Append(",slot=");
						string value3;
						if ((Object)(object)targetBuilding3 == (Object)null)
						{
							value3 = "?";
						}
						else
						{
							value3 = (((Component)targetBuilding3).gameObject.activeInHierarchy ? "on" : "off");
						}
						stringBuilder2.Append(value3).Append(((Object)(object)targetBuilding3 != (Object)null) ? (",lvl=" + targetBuilding3.Level + ",actLvl=" + targetBuilding3.ActivatorLevel + ",via=" + (((Object)(object)targetBuilding3.ActivatorBuilding != (Object)null) ? (targetBuilding3.ActivatorBuilding.buildingName + ":" + targetBuilding3.ActivatorBuilding.Level) : "-")) : "").Append(");");
					}
				}
			}
			if (stringBuilder.Length > 0)
			{
				ManualLogSource log7 = Plugin.Log;
				if (log7 != null)
				{
					log7.LogInfo((object)$"[bot] mil/wall slot state: {stringBuilder}");
				}
			}
		}
		if ((Object)(object)s.NearestBuild != (Object)null)
		{
			s.NearestBuildPos = ((Component)s.NearestBuild).transform.position;
			s.NearestBuildDist = Mathf.Sqrt(s.NearestBuildDist);
			s.NearestBuildKey = ((Object)s.NearestBuild).GetInstanceID();
			s.NearestBuildHarvest = s.NearestBuild.canBeHarvested;
			s.NearestBuildName = (((Object)(object)s.NearestBuild.targetBuilding != (Object)null) ? s.NearestBuild.targetBuilding.buildingName : ((Object)s.NearestBuild).name);
			if ((Object)(object)s.NearestBuild.targetBuilding != (Object)null)
			{
				GetBuildClass(s.NearestBuild.targetBuilding, out s.BuildMil, out s.BuildInc);
			}
			SlotPackRec slotPackRec = FindSlot(s.NearestBuildPos);
			Vector3 val23 = ((slotPackRec != null && badStands.Contains(PosKey(s.NearestBuildPos))) ? Vector3.zero : BestStand(slotPackRec, s.HeroPos));
			s.HasBuildStand = val23 != Vector3.zero;
			if (s.HasBuildStand)
			{
				s.BuildStandPos = val23;
				s.BuildStandDist = FlatDist(s.BuildStandPos, s.HeroPos);
			}
		}
		else
		{
			s.NearestBuildDist = 0f;
		}
		s.CanCommand = (Object)(object)CommandUnits.instance != (Object)null;
		s.CanSwitch = (Object)(object)DayNightCycle.Instance != (Object)null;
		SceneTransitionManager instance9 = SceneTransitionManager.instance;
		s.SceneBusy = (Object)(object)instance9 != (Object)null && SceneTransitionBusy(instance9);
		if (Time.unscaledTime >= weScanAt)
		{
			weScanAt = Time.unscaledTime + 1f;
			TaggedObject componentInParent2 = ((Component)instance2).GetComponentInParent<TaggedObject>();
			ManualAttack val24 = null;
			WeaponEquipper val25 = (((Object)(object)componentInParent2 != (Object)null) ? ((Component)componentInParent2).GetComponentInChildren<WeaponEquipper>(true) : null);
			if ((Object)(object)val25 != (Object)null)
			{
				val24 = (((Object)(object)val25.activeWeapon != (Object)null) ? val25.activeWeapon : val25.passiveWeapon);
			}
			if ((Object)(object)val24 == (Object)null && (Object)(object)componentInParent2 != (Object)null)
			{
				val24 = ((Component)componentInParent2).GetComponentInChildren<ManualAttack>(true);
			}
			if ((Object)(object)val24 == (Object)null)
			{
				ManualAttack[] array7 = Object.FindObjectsOfType<ManualAttack>(true);
				foreach (ManualAttack val26 in array7)
				{
					TaggedObject componentInParent3 = ((Component)val26).GetComponentInParent<TaggedObject>();
					if ((Object)(object)componentInParent3 != (Object)null && componentInParent3.Contains((ETag)2))
					{
						val24 = val26;
						break;
					}
				}
			}
			maCache = val24;
		}
		if ((Object)(object)maCache != (Object)null)
		{
			ManualAttack val27 = maCache;
			s.HasWeapon = true;
			s.ActiveRange = 0f;
			foreach (TargetPriority targetPriority2 in val27.targetPriorities)
			{
				if (targetPriority2 != null && targetPriority2.range > s.ActiveRange)
				{
					s.ActiveRange = targetPriority2.range;
				}
			}
			s.ActiveFiresMoving = (Object)(object)((Component)val27).GetComponent<DelayManualAttackWhileMoving>() == (Object)null;
		}
		s.Valid = true;
		return s;
	}

	public static bool SceneTransitionBusy(SceneTransitionManager stm)
	{
		if (StmRunningField != null)
		{
			return (bool)StmRunningField.GetValue(stm);
		}
		return false;
	}

	private static void GetBuildClass(BuildSlot bs, out int military, out int income)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		military = 0;
		income = 0;
		if ((Object)(object)bs == (Object)null)
		{
			return;
		}
		string text = lastClassScene;
		Scene activeScene = SceneManager.GetActiveScene();
		if (text != activeScene.name)
		{
			activeScene = SceneManager.GetActiveScene();
			lastClassScene = activeScene.name;
			buildClassCache.Clear();
		}
		if (buildClassCache.TryGetValue(bs, out var value))
		{
			military = value.mil;
			income = value.inc;
			return;
		}
		BuildClass buildClass = new BuildClass();
		List<Upgrade> upgrades = bs.Upgrades;
		if (upgrades != null && bs.Level >= 0 && bs.Level < upgrades.Count)
		{
			Upgrade val = upgrades[bs.Level];
			if (val != null && val.upgradeBranches != null)
			{
				foreach (UpgradeBranch upgradeBranch in val.upgradeBranches)
				{
					if (upgradeBranch == null)
					{
						continue;
					}
					buildClass.inc += upgradeBranch.goldIncomeChange + upgradeBranch.energyCoreIncomeChange;
					string text2 = ((upgradeBranch.choiceDetails != null) ? (upgradeBranch.choiceDetails.name ?? "") : "") + " " + bs.buildingName;
					if (text2.IndexOf("wall", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("gate", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("tower", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("barrack", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("archer", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("ballista", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("militia", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("guard", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("cannon", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("trap", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("spike", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("watchtower", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("outpost", StringComparison.OrdinalIgnoreCase) >= 0 || text2.IndexOf("defense", StringComparison.OrdinalIgnoreCase) >= 0)
					{
						buildClass.mil++;
					}
					if (upgradeBranch.objectsToActivate == null)
					{
						continue;
					}
					foreach (GameObject item in upgradeBranch.objectsToActivate)
					{
						if (!((Object)(object)item == (Object)null) && ((Object)(object)item.GetComponentInChildren<AutoAttack>(true) != (Object)null || (Object)(object)item.GetComponentInChildren<UnitRespawnerForBuildings>(true) != (Object)null))
						{
							buildClass.mil++;
							break;
						}
					}
				}
			}
		}
		buildClassCache[bs] = buildClass;
		military = buildClass.mil;
		income = buildClass.inc;
	}

	private static Vector3 InterceptAnchor(Vector3 threat, Vector3 castle)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_0149: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		if (spawnRoutes == null || castle == Vector3.zero)
		{
			return Vector3.zero;
		}
		SpawnRouteRec spawnRouteRec = null;
		float num = float.MaxValue;
		SpawnRouteRec[] array = spawnRoutes;
		foreach (SpawnRouteRec spawnRouteRec2 in array)
		{
			if (spawnRouteRec2.wp == null || spawnRouteRec2.wp.Length < 2)
			{
				continue;
			}
			for (int j = 0; j < spawnRouteRec2.wp.Length; j++)
			{
				float num2 = spawnRouteRec2.wp[j][0] - threat.x;
				float num3 = spawnRouteRec2.wp[j][1] - threat.z;
				float num4 = num2 * num2 + num3 * num3;
				if (num4 < num)
				{
					num = num4;
					spawnRouteRec = spawnRouteRec2;
				}
			}
		}
		if (spawnRouteRec == null || num > 1600f)
		{
			return Vector3.zero;
		}
		for (int num5 = spawnRouteRec.wp.Length - 1; num5 >= 0; num5--)
		{
			float num6 = spawnRouteRec.wp[num5][0] - castle.x;
			float num7 = spawnRouteRec.wp[num5][1] - castle.z;
			if (num6 * num6 + num7 * num7 >= 100f)
			{
				return new Vector3(spawnRouteRec.wp[num5][0], castle.y, spawnRouteRec.wp[num5][1]);
			}
		}
		float[] array2 = spawnRouteRec.wp[spawnRouteRec.wp.Length - 1];
		return new Vector3(array2[0], castle.y, array2[1]);
	}

	private static Vector3 NextWaveAnchor(int currentWave, Vector3 castle)
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_016b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0174: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		//IL_0145: Unknown result type (might be due to invalid IL or missing references)
		armyAnchorLine = null;
		if (wavePack == null || spawnRoutes == null || castle == Vector3.zero)
		{
			return Vector3.zero;
		}
		int num = currentWave + 1;
		WaveRec waveRec = null;
		WaveRec[] array = wavePack;
		foreach (WaveRec waveRec2 in array)
		{
			if (waveRec2.wave >= num && (waveRec == null || waveRec2.wave < waveRec.wave))
			{
				waveRec = waveRec2;
			}
		}
		if (waveRec == null || string.IsNullOrEmpty(waveRec.line))
		{
			return Vector3.zero;
		}
		SpawnRouteRec spawnRouteRec = null;
		SpawnRouteRec[] array2 = spawnRoutes;
		foreach (SpawnRouteRec spawnRouteRec2 in array2)
		{
			if (spawnRouteRec2.line == waveRec.line && spawnRouteRec2.wp != null && spawnRouteRec2.wp.Length != 0)
			{
				spawnRouteRec = spawnRouteRec2;
				break;
			}
		}
		if (spawnRouteRec == null)
		{
			return Vector3.zero;
		}
		armyAnchorLine = waveRec.line;
		for (int num2 = spawnRouteRec.wp.Length - 1; num2 >= 0; num2--)
		{
			float num3 = spawnRouteRec.wp[num2][0] - castle.x;
			float num4 = spawnRouteRec.wp[num2][1] - castle.z;
			if (num3 * num3 + num4 * num4 >= 144f)
			{
				return new Vector3(spawnRouteRec.wp[num2][0], castle.y, spawnRouteRec.wp[num2][1]);
			}
		}
		float[] array3 = spawnRouteRec.wp[spawnRouteRec.wp.Length - 1];
		return new Vector3(array3[0], castle.y, array3[1]);
	}

	private static string PKey(ref Snapshot s)
	{
		int num = ((s.AllyCount >= 10) ? ((s.AllyCount < 20) ? 1 : ((s.AllyCount < 40) ? 2 : 3)) : 0);
		int num2 = ((s.DoorCount > 0) ? Mathf.Min(3, (int)(4f * (float)s.DoorsCovered / (float)s.DoorCount)) : 0);
		return (s.SceneName ?? "?") + "|w" + s.Wave + "|a" + num + "|c" + num2 + "|r" + (int)(s.RedAlert ? 1 : 0) + "|b" + ((s.Balance < 10) ? 1 : 0);
	}

	private static int DoorTarget(int d, string pkey)
	{
		string text = ((sceneDoorLines != null && d < sceneDoorLines.Length) ? sceneDoorLines[d] : null);
		int num;
		int value;
		if (Coach.SquadSize > 0)
		{
			num = Coach.SquadSize;
		}
		else if (text != null && Strat.LineSquad.TryGetValue(text, out value))
		{
			num = value;
		}
		else if (Strat.Squad <= 0)
		{
			num = (int.TryParse(Policy.Eval("squad", new string[5] { "3", "4", "5", "6", "8" }, pkey), out var result) ? result : 4);
		}
		else
		{
			num = Strat.Squad;
		}
		if (doorBreach == null || d >= doorBreach.Length)
		{
			return num;
		}
		if (!doorBreach[d])
		{
			return num;
		}
		return num * 2;
	}

	private static float ProtectedRadius(ref Snapshot s)
	{
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		List<BuildingInteractor> list = (((Object)(object)TagManager.instance != (Object)null) ? TagManager.instance.playerBuildingInteractors : null);
		float num = 14f;
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				BuildingInteractor val = list[i];
				if (!((Object)(object)val == (Object)null) && !((Object)(object)((Component)val).transform == (Object)null))
				{
					float num2 = FlatDist(((Component)val).transform.position, s.CastlePos);
					if (num2 > num)
					{
						num = num2;
					}
				}
			}
		}
		return num + 4f;
	}

	private static void BuildDoors(ref Snapshot s)
	{
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0194: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ec: Unknown result type (might be due to invalid IL or missing references)
		if (doorScene != s.SceneName || sceneDoorAnchors == null)
		{
			doorScene = s.SceneName;
			sceneDoorAnchors = null;
			sceneDoorLines = null;
			doorBreach = null;
			doorUnit = null;
			doorParked = null;
			if (spawnRoutes != null && s.CastlePos != Vector3.zero)
			{
				List<Vector3> list = new List<Vector3>();
				List<string> list2 = new List<string>();
				HashSet<string> hashSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
				SpawnRouteRec[] array = spawnRoutes;
				foreach (SpawnRouteRec spawnRouteRec in array)
				{
					if (spawnRouteRec == null || spawnRouteRec.wp == null || spawnRouteRec.wp.Length < 3 || !spawnRouteRec.ground)
					{
						continue;
					}
					string text = ((spawnRouteRec.line == null) ? null : spawnRouteRec.line.Trim());
					if ((text != null && !hashSet.Add(text)) || (text == null && hashSet.Contains("")))
					{
						continue;
					}
					if (text == null)
					{
						hashSet.Add("");
					}
					float[] array2 = spawnRouteRec.wp[spawnRouteRec.wp.Length - 1];
					bool flag = false;
					float num = Strat.DoorDist * Strat.DoorDist;
					for (int num2 = spawnRouteRec.wp.Length - 1; num2 >= 0; num2--)
					{
						float num3 = spawnRouteRec.wp[num2][0] - array2[0];
						float num4 = spawnRouteRec.wp[num2][1] - array2[1];
						if (num3 * num3 + num4 * num4 >= num)
						{
							list.Add(new Vector3(spawnRouteRec.wp[num2][0], s.CastlePos.y, spawnRouteRec.wp[num2][1]));
							list2.Add(text ?? "");
							flag = true;
							break;
						}
					}
					if (!flag)
					{
						float[] array3 = spawnRouteRec.wp[spawnRouteRec.wp.Length / 2];
						list.Add(new Vector3(array3[0], s.CastlePos.y, array3[1]));
						list2.Add(text ?? "");
					}
				}
				sceneDoorAnchors = list.ToArray();
				sceneDoorLines = list2.ToArray();
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)string.Format("[bot] squad doors: {0} ({1})", sceneDoorAnchors.Length, string.Join(", ", list2)));
				}
			}
		}
		s.DoorAnchors = sceneDoorAnchors;
		s.DoorLines = sceneDoorLines;
		if (doorUnit == null || doorUnit.Length != (sceneDoorAnchors?.Length ?? 0))
		{
			doorUnit = new int[sceneDoorAnchors?.Length ?? 0];
			doorBreach = new bool[sceneDoorAnchors?.Length ?? 0];
			doorFoes = new int[sceneDoorAnchors?.Length ?? 0];
			doorClaim = new float[sceneDoorAnchors?.Length ?? 0];
		}
	}

	private static float FlatDist(Vector3 a, Vector3 b)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		a.y = 0f;
		b.y = 0f;
		return Vector3.Distance(a, b);
	}
}
