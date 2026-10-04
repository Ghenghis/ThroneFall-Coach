using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using BepInEx;
using BepInEx.Logging;
using Pathfinding;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Bot
{
	public static bool Legit;

	[CompilerGenerated]
	private static BotMode Mode__BackingField;

	[CompilerGenerated]
	private static string Status__BackingField;

	private const float ArriveCoin = 0.8f;

	private const float ArriveHold = 6f;

	private const float ArriveEngage = 1.5f;

	private const float HomeRadius = 14f;

	private const float CoinSeekRange = 80f;

	private const float DecisionInterval = 0.25f;

	private const float StuckWatchWindow = 2f;

	private const float StuckEpsilon = 0.35f;

	private const int MaxStrikesBeforeTeleport = 3;

	private const float TeleportNudge = 2.5f;

	private static float decisionClock;

	private static float watchClock;

	private static float arriveSince;

	private static int stuckStrikeTotal;

	private static Vector3 watchAnchor;

	private static bool hasAnchor;

	private static Vector3 lastFreePos;

	private static float lastFreeAt;

	private static bool hasTarget;

	private static Vector3 targetPos;

	private static float arriveDist;

	private static TaggedObject engageTarget;

	private static ManualAttack heroAttack;

	private static float weRevalAt;

	private static float attackDiagAt;

	private static float menuAdvanceAt;

	private static float frameActionAt;

	private static string uiFrame;

	private static string lastUiNoteFrame;

	private static float nextUiNoteAt;

	private static BuildingInteractor heldBuild;

	private static float maScanAt;

	private static float lastWatchDist;
	private static float slideDist0 = float.MaxValue, slideT0;

	private static float idleWatchSince = -1f;

	private static int frameCloseStreak;

	private static int choiceConfirmStreak;

	private static float nextEffBeat, noPickSince = -1f, nextRescan;

	private static float aimBlockedSince;

	private static int aimFlapStreak;

	private static float flapHold = 2.5f;

	private static Vector3 lastAimPos;

	private static float lastAimAt;

	private static float nextCoachBeat;

	private static string lastDiagKey;

	private static float detourUntil;

	private static Vector3 detourPos;

	private static int detourSide;

	private static int detourCount;

	private static Pathfinding.Path navPath;

	private static readonly Dictionary<long, float> navNoPathLogAt = new Dictionary<long, float>();

	private static int navIndex;

	private static Vector3 navGoal;

	private static bool navWrongLayer;

	private static float navDirectUntil;

	private static float interZeroSince;

	private static float interVacuumAt;

	private static float nonVacSince;

	private static bool sawInteractables;

	private static float navRepathAt;

	private static bool navInFlight;

	private static int navRequestId;

	private static bool beganRunThisTick;

	private static float navSteerArrive;

	private static int navDiagCount;

	private static float nextMoveDiagAt;

	private static float weaponRange;

	private static bool weaponFiresWhileMoving;

	private static bool lastNightTick;

	private static readonly Dictionary<string, int> sessionDefeats;

	private static readonly HashSet<string> playedThisSession;

	private static string lastMatchScene;

	private static string lastGameState;

	private static string lastFrameName;

	private static int frameSeen;

	private static float lastFrameAt;

	private static float choiceSince;

	private static StreamWriter botLog;

	private static bool logFailed;

	private static int recTickFrame;

	private static BotMode prevModeRec;

	private static float modeSinceAt;

	private static float nextAuditAt;

	private static string recordedScene;

	private static BotMemory mem;

	private static PolicyTable pol;

	private static string polPath;

	private static long polStamp;

	private static float polScanAt;

	private static readonly HashSet<string> prevRuleFires;

	private static float holdDiagAt;

	private static string holdDoneName;

	private static readonly HashSet<Coin> coinIgnore;

	private static float stuckSpamWindow;

	private static int stuckSpamCount;

	private static float nightParkSince;

	private static float lastAnomalyAt;

	// Per-type anomaly debounce: the global gate above throttles rate, but a
	// repeating anomaly (stuck-spam under door-park thrash) still fired at max
	// rate — 28 times in 600 s, becoming the spammiest log source itself.
	// Each kind gets its own cooldown window.
	private static readonly Dictionary<string, float> anomalyAt = new Dictionary<string, float>();

	private static bool AnomalyAllowed(string kind, float cooldown = 45f)
	{
		float now = Time.unscaledTime;
		if (anomalyAt.TryGetValue(kind, out float prev) && now - prev < cooldown)
			return false;
		anomalyAt[kind] = now;
		lastAnomalyAt = now;
		return true;
	}

	private static Vector3 nightParkPos;

	private static string requestedWeapon;

	private static bool frontierLatch;

	private static Vector3 frontierLatchGoal;

	private static readonly FieldInfo StmRunningField;

	private static string lastEvtNote;

	private static float lastEvtAt;

	public static bool Enabled { get; private set; }

	public static bool SprintWanted;
	public static Vector3 DesiredDir
	{
		[CompilerGenerated]
		get
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			return field;
		}
		[CompilerGenerated]
		private set
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			field = value;
		}
	}

	public static BotMode Mode
	{
		[CompilerGenerated]
		get
		{
			return Mode__BackingField;
		}
		[CompilerGenerated]
		private set
		{
			Mode__BackingField = value;
		}
	}

	public static string Status
	{
		[CompilerGenerated]
		get
		{
			return Status__BackingField;
		}
		[CompilerGenerated]
		private set
		{
			Status__BackingField = value;
		}
	}

	public static string UiFrame => uiFrame;

	public static int StuckStrikes { get; private set; }

	private static Vector3 focusPos;
	private static float focusUntil;
	private static Vector3 retreatPos;              // trap-retreat latch target (castle)
	private static float retreatUntil;              // suppress all other aims until this expires
	private static float unfocusStepAt;             // throttle for the night-call unfocus step
	/// <summary>UI click-to-command ("send hero here"). Seconds-capped so a
	/// stale click can never trap the hero; brain resumes after expiry.</summary>
	internal static void SetFocus(Vector3 pos, float seconds)
	{ focusPos = pos; focusUntil = Time.unscaledTime + seconds; }
	internal static Vector3 FocusPos => focusPos;
	internal static bool FocusActive => Time.unscaledTime < focusUntil;

	/// <summary>Live-view overlay: the nav path the hero is walking.</summary>
	internal static List<Vector3> NavPathPoints =>
		(navPath != null && navPath.vectorPath != null && navPath.vectorPath.Count > 1)
			? navPath.vectorPath : null;

	private static Vector3 AimPos
	{
		get
		{
			//IL_0028: Unknown result type (might be due to invalid IL or missing references)
			//IL_003e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0038: Unknown result type (might be due to invalid IL or missing references)
			if (!Legit || !(Time.unscaledTime < detourUntil))
			{
				if (Mode != BotMode.Engage || !((UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null))
				{
					return targetPos;
				}
				return ((Component)engageTarget).transform.position;
			}
			return detourPos;
		}
	}

	private static string Digest(in BotPerception.Snapshot s)
	{
		int value;
		return "{" + Tasks.DigestJson() + ",\"efficiency\":" + Mathf.RoundToInt(Efficiency.Score) + ",\"idle_s_since_progress\":" + Mathf.RoundToInt(Efficiency.SecondsSinceProgress) + ",\"drain\":\"" + Efficiency.DrainWhy.Trim() + "\",\"maxed_pct\":" + (BotPerception.MaxLevelTotal > 0 ? Mathf.RoundToInt(100f * BotPerception.MaxLevelSum / BotPerception.MaxLevelTotal) : 0) + ",\"buildable_slots\":" + s.BuildCount + ",\"scene\":\"" + s.SceneName + "\",\"wave\":" + s.Wave + ",\"wave_max\":" + s.WaveTotal + ",\"gold\":" + s.Balance + ",\"cores\":" + s.CoreBalance + ",\"allies\":" + s.AllyCount + ",\"free_units\":" + s.FreeUnits + ",\"doors_covered\":" + s.DoorsCovered + ",\"doors\":" + s.DoorCount + ",\"foes\":" + s.EnemyCount + ",\"red_alert\":" + (s.RedAlert ? "true" : "false") + ",\"buildings\":" + s.BuildCount + ",\"hero_hp_pct\":" + ((int)(s.HeroHpPct * 100f)).ToString(CultureInfo.InvariantCulture) + ",\"defeats\":" + (sessionDefeats.TryGetValue(s.SceneName ?? "", out value) ? value : 0) + ",\"policy\":" + Policy.Stats() + "}";
	}

	static Bot()
	{
		Mode__BackingField = BotMode.Idle;
		Status__BackingField = "off (F6)";
		lastFreeAt = -999f;
		arriveDist = 1f;
		uiFrame = "";
		lastUiNoteFrame = "";
		lastWatchDist = float.MaxValue;
		detourSide = 1;
		interZeroSince = -1f;
		nonVacSince = -1f;
		navSteerArrive = 0.5f;
		weaponFiresWhileMoving = true;
		lastNightTick = true;
		sessionDefeats = new Dictionary<string, int>();
		playedThisSession = new HashSet<string>();
		lastGameState = "";
		lastFrameName = "";
		prevModeRec = BotMode.Idle;
		mem = BotMemory.Fresh();
		pol = PolicyTable.Default();
		prevRuleFires = new HashSet<string>();
		holdDoneName = "";
		coinIgnore = new HashSet<Coin>();
		stuckSpamWindow = -1f;
		nightParkSince = -1f;
		StmRunningField = typeof(SceneTransitionManager).GetField("sceneTransitionIsRunning", BindingFlags.Instance | BindingFlags.NonPublic);
		try
		{
			MethodInfo[] methods = typeof(UIFrameManager).GetMethods(BindingFlags.Instance | BindingFlags.Public);
			StringBuilder stringBuilder = new StringBuilder();
			MethodInfo[] array = methods;
			foreach (MethodInfo methodInfo in array)
			{
				if (methodInfo.GetParameters().Length <= 1 && (methodInfo.Name.IndexOf("Escape", StringComparison.OrdinalIgnoreCase) >= 0 || methodInfo.Name.IndexOf("Pause", StringComparison.OrdinalIgnoreCase) >= 0 || methodInfo.Name.IndexOf("Open", StringComparison.OrdinalIgnoreCase) >= 0 || methodInfo.Name.IndexOf("Level", StringComparison.OrdinalIgnoreCase) >= 0))
				{
					stringBuilder.Append(methodInfo.Name).Append("; ");
				}
			}
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)("[bot] uiframe api: " + stringBuilder));
			}
		}
		catch
		{
		}
		BotPerception.LevelScore = (LevelInteractor li, bool beaten) =>
		{
			string text = (((UnityEngine.Object)(object)li.levelInfo != (UnityEngine.Object)null) ? li.levelInfo.sceneName : null);
			int num = ((text != null && sessionDefeats.TryGetValue(text, out var value)) ? value : 0);
			float num2 = (beaten ? 0f : 100f);
			if (text == null || !playedThisSession.Contains(text))
			{
				num2 += 15f;
			}
			if (Memory.IsBadScene(text))
			{
				num2 -= 1000f;
			}
			// Quest-aware (v3): a level with uncompleted quests beats an equally
			// unbeaten level with none — quests are the campaign-progress unit.
			if ((UnityEngine.Object)(object)li.levelInfo != (UnityEngine.Object)null)
			{
				try
				{
					num2 += 12f * (li.levelInfo.QuestsTotal() - li.levelInfo.QuestsComplete());
				}
				catch
				{
				}
			}
			return num2 - (float)num * 45f;
		};
		BotPerception.CoinSkip = (Coin c) => coinIgnore.Contains(c);
		Recorder.Start();
	}

	public static void SetEnabled(bool v)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		if (v != Enabled)
		{
			Enabled = v;
			DesiredDir = Vector3.zero;
			ClearTarget();
			Mode = BotMode.Idle;
			Status = (v ? "starting" : "off (F6)");
			hasAnchor = false;
			StuckStrikes = 0;
			stuckStrikeTotal = 0;
			ReleaseBuild("new-run");
			decisionClock = 0f;
			mem = BotMemory.Fresh();
			detourUntil = 0f;
			detourCount = 0;
			weaponRange = 0f;
			heroAttack = null;
			ReleaseGate("reset"); Efficiency.Reset(); aimBlockedSince = 0f; lastAimAt = 0f; flapHold = 2.5f; aimFlapStreak = 0;
			navPath = null;
			navIndex = 0;
			navInFlight = false;
			navGoal = Vector3.zero;
			navWrongLayer = false;
			navDirectUntil = 0f;
			navRepathAt = 0f;
			navRequestId++;
			lastGameState = "";
			recordedScene = null;
			lastNightTick = true;
			uiFrame = "";
			lastFrameName = "";
			frameSeen = 0;
			lastFrameAt = 0f;
			sawInteractables = false;
			interZeroSince = -1f;
			nonVacSince = -1f;
			interVacuumAt = 0f;
			arriveSince = 0f;
			lastWatchDist = float.MaxValue;
			holdDoneName = "";
			detourCount = 0;
			detourUntil = 0f;
			coinIgnore.Clear();
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)("[bot] autopilot " + (v ? "ENABLED" : "disabled") + " (F6)"));
			}
			LogRaw(v ? "enabled" : "disabled");
			if (!v)
			{
				CloseLog();
			}
		}
	}

	public static void Shutdown()
	{
		SetEnabled(v: false);
	}

	public static void Tick()
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_008f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0241: Unknown result type (might be due to invalid IL or missing references)
		if (!Enabled)
		{
			return;
		}
		PlayerMovement instance = PlayerMovement.instance;
		Vector3 val = Vector3.zero;
		if (hasTarget && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
		{
			val = ((!Legit) ? DirTo(((Component)instance).transform.position, AimPos, arriveDist) : DirTo(((Component)instance).transform.position, NavSteerPoint(((Component)instance).transform.position, AimPos), navSteerArrive));
			// Steering repulsion: nav waypoints sit flush on collider faces, so
			// following them corner-hugs into walls/buildings (the "stuck on
			// Main Collider" class). Push the desired dir off anything inside
			// ~0.7 m — prevention, not just pin recovery. Skipped while paying
			// a hold (he must touch the slot) and during gate push-through.
			if (Legit && val.sqrMagnitude > 0.01f &&
			    (UnityEngine.Object)(object)heldBuild == (UnityEngine.Object)null &&
			    Time.unscaledTime >= navDirectUntil)
				val = ObstacleRepulse(((Component)instance).transform.position, val);
		}
		float num = 1f - Mathf.Exp(-10f * Time.unscaledDeltaTime);
		DesiredDir = Vector3.Lerp(DesiredDir, val, num);
		SprintWanted = hasTarget && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null && (UnityEngine.Object)(object)heldBuild == (UnityEngine.Object)null && val.sqrMagnitude > 0.25f && (Mode == BotMode.SpendGold || Mode == BotMode.CollectCoin || Mode == BotMode.PositionArmy || Mode == BotMode.ReturnHome || Mode == BotMode.StartNight) && Vector3.Distance(((Component)instance).transform.position, AimPos) > 8f;
		Vector3 desiredDir = DesiredDir;
		if (desiredDir.sqrMagnitude < 0.0001f)
		{
			DesiredDir = Vector3.zero;
		}
		PlayerInteraction instance2 = PlayerInteraction.instance;
		if ((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
		{
			((InteractorBase)heldBuild).InteractionHold(instance2);
		}
		Type ty;
		if ((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null && Time.unscaledTime >= holdDiagAt)
		{
			holdDiagAt = Time.unscaledTime + 1f;
			ty = ((object)heldBuild).GetType();
			string text = (((UnityEngine.Object)(object)heldBuild.targetBuilding != (UnityEngine.Object)null) ? heldBuild.targetBuilding.buildingName : "");
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)string.Format("[bot] hold-diag '{0}' b='{1}': state={2} started={3} waitChoice={4} complete={5} harvest={6} canInter={7}", ((UnityEngine.Object)heldBuild).name, text, Get("currentState"), Get("interactionStarted"), Get("isWaitingForChoice"), Get("interactionComplete"), heldBuild.canBeHarvested, ((InteractorBase)heldBuild).CanBeInteractedWith));
			}
			object obj = Get("interactionComplete");
			bool flag = default;
			int num2;
			if (obj is bool)
			{
				flag = (bool)obj;
				num2 = 1;
			}
			else
			{
				num2 = 0;
			}
			if (((uint)num2 & (flag ? 1u : 0u)) != 0 && text != "" && text != holdDoneName)
			{
				holdDoneName = text;
				string bdn0 = text;
				if (((UnityEngine.Object)(object)heldBuild.targetBuilding != (UnityEngine.Object)null) &&
				    heldBuild.targetBuilding.name.IndexOf("gate", StringComparison.OrdinalIgnoreCase) >= 0)
					bdn0 = text + "|gate";
				BotPerception.BuildDone(bdn0, ((Component)heldBuild).transform.position);
			}
		}
		Coach.PerFrame(in BotPerception.Last, hasTarget ? targetPos : Vector3.zero, hasTarget);
		Act.PerFrame(in BotPerception.Last, hasTarget ? targetPos : Vector3.zero, hasTarget);   // act.v1 / view.v1 / probe.v1 (src/Act.cs)
		decisionClock += Time.unscaledDeltaTime;
		if (!(decisionClock < 0.25f))
		{
			decisionClock = 0f;
			TickInner();
		}
		object Get(string n)
		{
			Type type = ty;
			while (type != null)
			{
				FieldInfo field = type.GetField(n, BindingFlags.Instance | BindingFlags.NonPublic);
				if (field != null)
				{
					return field.GetValue(heldBuild);
				}
				type = type.BaseType;
			}
			return null;
		}
	}

	private static void TickInner()
	{
		//IL_0998: Unknown result type (might be due to invalid IL or missing references)
		//IL_09a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_09ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_0bf8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0c11: Unknown result type (might be due to invalid IL or missing references)
		//IL_0c5e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0c6f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0cb2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0ccb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0cd0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0cd5: Unknown result type (might be due to invalid IL or missing references)
		BotPerception.Snapshot s = (BotPerception.Last = BotPerception.Capture(((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null) ? ((UnityEngine.Object)heldBuild).GetInstanceID() : (-1)));
		BotPerception.LastValid = true;
		if (s.GameState != lastGameState)
		{
			if (s.GameState == "InMatch")
			{
				Recorder.BeginRun(s.SceneName);
				Policy.BeginRun();
				Coach.ResetRun();
				recordedScene = s.SceneName;
				beganRunThisTick = false;
				stuckStrikeTotal = 0;
				sawInteractables = false;
				interZeroSince = -1f;
				nonVacSince = -1f;
				lastNightTick = true;
				coinIgnore.Clear();
				navWrongLayer = false;
				navPath = null;
				navIndex = 0;
				navInFlight = false;
				navRequestId++;
				heroAttack = null;
				ReleaseGate("match"); Efficiency.Reset(); Tasks.Reset(); aimBlockedSince = 0f; lastAimAt = 0f; flapHold = 2.5f; aimFlapStreak = 0; SpatialMemory.Decay(s.SceneName);
				mem = BotMemory.Fresh();
				arriveSince = 0f;
				detourUntil = 0f;
				detourCount = 0;
				lastWatchDist = float.MaxValue;
				holdDoneName = "";
				prevRuleFires.Clear();
				Memory.ForgiveParks(s.SceneName);
				// User-requested campaign bootstrap: one-time gold grant at
				// match start (config Economy.GoldGrant, 0 = off).
				if (Plugin.GoldGrant > 0 &&
				    (UnityEngine.Object)(object)PlayerInteraction.instance != (UnityEngine.Object)null)
				{
					PlayerInteraction.instance.AddCoin(Plugin.GoldGrant);
					LogLine(in s, "gold-grant:" + Plugin.GoldGrant);
				}
			}
			if (s.GameState == "AfterMatchVictory" && lastMatchScene != null)
			{
				playedThisSession.Add(lastMatchScene);
				sessionDefeats.Remove(lastMatchScene);
				Recorder.MatchEnd("victory", Legit);
				Policy.MatchEnd(victory: true, Mathf.Max(0f, s.CastleHpPct), BotPerception.BreachCount);
			}
			else if (s.GameState == "AfterMatchDefeat" && lastMatchScene != null)
			{
				sessionDefeats[lastMatchScene] = ((!sessionDefeats.TryGetValue(lastMatchScene, out var value)) ? 1 : (value + 1));
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)$"[bot] defeat on '{lastMatchScene}' (x{sessionDefeats[lastMatchScene]} this session)");
				}
				LogLine(in s, "defeat");
				Recorder.MatchEnd("defeat", Legit);
				Policy.MatchEnd(victory: false, Mathf.Max(0f, s.CastleHpPct), BotPerception.BreachCount);
				Coach.Advise("defeat", Digest(in s));
				if (Coach.VisionEnabled)
				{
					Texture2D val = ScreenCapture.CaptureScreenshotAsTexture();
					if ((UnityEngine.Object)(object)val != (UnityEngine.Object)null)
					{
						Coach.AnalyzeScreenshot(ImageConversion.EncodeToPNG(val), "scene=" + s.SceneName);
						UnityEngine.Object.Destroy((UnityEngine.Object)(object)val);
					}
				}
			}
			lastGameState = s.GameState;
		}
		if (lastNightTick && !s.IsNight && s.Valid)
		{
			Policy.Pulse(0.2f);
		}
		if (lastNightTick && !s.IsNight && s.Valid && (s.SceneName == null || !s.SceneName.StartsWith("_")))
		{
			Coach.Advise("day-start", Digest(in s));
		}
		if (s.Valid)
		{
			lastNightTick = s.IsNight;
		}
		if (s.Valid && !s.SceneName.StartsWith("_"))
		{
			lastMatchScene = s.SceneName;
		}
		if (!s.Valid)
		{
			Mode = BotMode.Idle;
			ClearTarget();
			Status = "waiting (" + s.GameState + ")";
			LogLine(in s, "invalid");
			if (s.SceneName == "_StartMenu" && (UnityEngine.Object)(object)SceneTransitionManager.instance != (UnityEngine.Object)null && Time.unscaledTime >= menuAdvanceAt)
			{
				menuAdvanceAt = Time.unscaledTime + 8f;
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogInfo((object)"[bot] start menu -> TransitionFromNullToLevelSelect()");
				}
				SceneTransitionManager.instance.TransitionFromNullToLevelSelect();
			}
			// Level-select map without a usable gamestate (audit F1): the
			// snapshot dies before the level scan runs when LocalGamestate is
			// absent or not InMatch — drive the transition directly; the node
			// map needs no walking.
			else if (!s.SceneName.StartsWith("_") &&
			         (UnityEngine.Object)(object)SceneTransitionManager.instance != (UnityEngine.Object)null &&
			         Time.unscaledTime >= menuAdvanceAt)
			{
				var lnode = BotPerception.BestLevelNode();
				if ((UnityEngine.Object)(object)lnode != (UnityEngine.Object)null &&
				    (UnityEngine.Object)(object)lnode.levelInfo != (UnityEngine.Object)null)
				{
					menuAdvanceAt = Time.unscaledTime + 8f;
					ManualLogSource log9 = Plugin.Log;
					if (log9 != null)
					{
						log9.LogInfo((object)("[bot] map node -> '" + lnode.levelInfo.sceneName + "' (no-gamestate path)"));
					}
					SceneTransitionManager.instance.TransitionFromLevelSelectToLevel(lnode.levelInfo.sceneName);
				}
			}
			HandleBlockingFrame(in s);
			WriteAuditStub(in s, "menu");
			return;
		}
		if (HandleBlockingFrame(in s))
		{
			Mode = BotMode.ResolveUI;
			if (!((UnityEngine.Object)(object)ChoiceManager.instance != (UnityEngine.Object)null) || !ChoiceManager.instance.ChoiceCoroutineRunning)
			{
				ClearTarget();
			}
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
		if (!s.SceneName.StartsWith("_") && !s.OnLevelSelect && recordedScene != s.SceneName && !beganRunThisTick)
		{
			recordedScene = s.SceneName;
			Recorder.BeginRun(s.SceneName);
			Policy.BeginRun();
			Coach.ResetRun();
			stuckStrikeTotal = 0;
		}
		beganRunThisTick = false;
		SnapshotData s2 = BotPerception.ToData(in s);
		if ((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null || s.BuildCount > 0 || BotPerception.CatBuilt.Count > 0)
		{
			sawInteractables = true;
		}
		// The level-select map reports GameState InMatch but has no build
		// interactables by design — the vacuum watchdog quarantined the
		// scene and fired Apply()/TransitionToLevelSelect mid-navigation.
		if (s.GameState == "InMatch" && !s.IsNight &&
		    s.SceneName != null && !s.SceneName.StartsWith("_") &&
		    !sawInteractables && (UnityEngine.Object)(object)s.NearestBuild == (UnityEngine.Object)null && s.InteractorCount == 0)
		{
			nonVacSince = -1f;
			if (interZeroSince < 0f)
			{
				interZeroSince = Time.unscaledTime;
				ManualLogSource log3 = Plugin.Log;
				if (log3 != null)
				{
					log3.LogWarning((object)($"[bot] vacuum-diag ARMED: gs={s.GameState} night={s.IsNight} " + string.Format("ally={0} coins={1} nb={2} ", s.AllyCount, s.CoinCount, ((UnityEngine.Object)(object)s.NearestBuild == (UnityEngine.Object)null) ? "null" : s.NearestBuildName) + $"inter={s.InteractorCount}"));
				}
			}
			else if (Time.unscaledTime - interZeroSince > 40f && Time.unscaledTime >= interVacuumAt)
			{
				interVacuumAt = Time.unscaledTime + 120f;
				interZeroSince = -1f;
				if (s.SceneName != null)
				{
					sessionDefeats[s.SceneName] = ((!sessionDefeats.TryGetValue(s.SceneName, out var value2)) ? 1 : (value2 + 1));
					Memory.MarkBadScene(s.SceneName);
				}
				ManualLogSource log4 = Plugin.Log;
				if (log4 != null)
				{
					log4.LogWarning((object)"[bot] interactor vacuum — no interactables/coins 40 s into day; match is corrupt → level select via frame");
				}
				LogLine(in s, "inter-vacuum");
				UIFrameManager instance = UIFrameManager.instance;
				UIFrame val2 = (((UnityEngine.Object)(object)instance != (UnityEngine.Object)null) ? instance.ActiveFrame : null);
				if ((UnityEngine.Object)(object)val2 != (UnityEngine.Object)null)
				{
					val2.Apply();
				}
				else if ((UnityEngine.Object)(object)instance != (UnityEngine.Object)null && (UnityEngine.Object)(object)PlayerInteraction.instance != (UnityEngine.Object)null && (UnityEngine.Object)(object)SceneTransitionManager.instance != (UnityEngine.Object)null)
				{
					SceneTransitionManager.instance.TransitionToLevelSelect();
				}
			}
		}
		else if (!s.IsNight)
		{
			if (nonVacSince < 0f)
			{
				nonVacSince = Time.unscaledTime;
			}
			if (Time.unscaledTime - nonVacSince > 3f)
			{
				interZeroSince = -1f;
			}
		}
		Mailbox.Poll(in s);
		if (Time.unscaledTime >= polScanAt)
		{
			polScanAt = Time.unscaledTime + 1f;
			if (polPath == null)
			{
				polPath = System.IO.Path.Combine(Recorder.AgentDir, "policy.txt");
			}
			try
			{
				if (File.Exists(polPath) && File.GetLastWriteTimeUtc(polPath).Ticks != polStamp)
				{
					polStamp = File.GetLastWriteTimeUtc(polPath).Ticks;
					List<string> errors = new List<string>();
					if (PolicyTable.Parse(File.ReadAllText(polPath), ref pol, out errors))
					{
						ManualLogSource log5 = Plugin.Log;
						if (log5 != null)
						{
							log5.LogInfo((object)$"[bot] policy v{pol.Version} loaded ({pol.rules.Count} rule(s))");
						}
					}
					else
					{
						LogLine(in s, "policy-reject");
						ManualLogSource log6 = Plugin.Log;
						if (log6 != null)
						{
							log6.LogWarning((object)string.Format("[bot] policy REJECTED (kept v{0}): {1}", pol.Version, string.Join("; ", errors)));
						}
					}
				}
			}
			catch (Exception ex)
			{
				ManualLogSource log7 = Plugin.Log;
				if (log7 != null)
				{
					log7.LogWarning((object)("[bot] policy read: " + ex.Message));
				}
			}
		}
		PolicyTable policyTable = pol.Resolved(in s2);
		DecideResult decideResult = BotBrain.Decide(in s2, ref mem, Time.unscaledTime, Legit, in policyTable);
		if (decideResult.RulesFired != null && decideResult.RulesFired.Count > 0)
		{
			foreach (string item in decideResult.RulesFired)
			{
				if (prevRuleFires.Add(item))
				{
					LogLine(in s, "rule-fire:" + item);
				}
				Recorder.CountRuleFire(item);
			}
		}
		Mode = decideResult.Mode;
		NetPolicy.Shadow(in s, decideResult.Mode.ToString());
		engageTarget = ((decideResult.Pursue == 2) ? s.NearestEnemy : ((decideResult.Pursue != 1) ? null : (((UnityEngine.Object)(object)s.CastleThreat != (UnityEngine.Object)null) ? s.CastleThreat : s.NearestEnemy)));
		// UI click-to-command: a "send hero here" focus beats the brain's aim
		// for a short window (safe: expires fast, outranked by nothing).
		if (Time.unscaledTime < focusUntil)
		{
			decideResult.AimPos = new Vec2(focusPos.x, focusPos.z);
			decideResult.HasAim = true;
		}
		// Trap-retreat latch: a wedge pins him INSIDE geometry where every
		// re-aim flip flops between castle and the pocket target — he never
		// walks far enough to exit. Hold the retreat aim until it expires so
		// he actually travels out of the pocket (was: 97 retreats, 0 escapes).
		if (Time.unscaledTime < retreatUntil)
		{
			decideResult.AimPos = new Vec2(retreatPos.x, retreatPos.z);
			decideResult.HasAim = true;
			decideResult.Mode = BotMode.HoldCastle;
		}
		if (decideResult.HasAim)
		{
			Vector3 val3 = new Vector3(decideResult.AimPos.X, 0f, decideResult.AimPos.Z);
			val3.y = AimY(in s, val3);
			// Anti-flap: an aim REVERSAL inside 2.5 s on a non-urgent mode is
			// the visible back-and-forth loop (modes flap -> aims alternate ->
			// hero ping-pongs and nothing completes). Engage/death/return/
			// red-alert override instantly; economy modes commit.
			bool urgent = decideResult.Mode == BotMode.Engage ||
			              decideResult.Mode == BotMode.HeroDead ||
			              decideResult.Mode == BotMode.ReturnHome || s.RedAlert;
			if (!urgent && Time.unscaledTime - lastAimAt < flapHold && s.HeroPos.sqrMagnitude > 0.01f)
			{
				Vector3 toNew = val3 - s.HeroPos, toOld = lastAimPos - s.HeroPos;
				toNew.y = 0f; toOld.y = 0f;
				if (toNew.sqrMagnitude > 0.01f && toOld.sqrMagnitude > 0.01f &&
				    Vector3.Dot(toNew.normalized, toOld.normalized) < -0.5f &&
				    (lastAimPos - s.HeroPos).magnitude > 4f)
				{
					val3 = lastAimPos;
					LogLine(in s, "aim-flap-blocked");
					aimBlockedSince = aimBlockedSince <= 0f ? Time.unscaledTime : aimBlockedSince;
					// Escalating hysteresis: the same oscillating pair
					// re-fires the blocker every 2.5 s forever — extend the
					// commit window so the hero actually walks somewhere.
					if (++aimFlapStreak > 3) flapHold = Mathf.Min(8f, flapHold * 1.5f);
				}
				else { aimBlockedSince = 0f; aimFlapStreak = 0;
				       // Decay the hysteresis — it ratcheted to 8 s and never
				       // recovered, delaying every legitimate retarget.
				       flapHold = Mathf.Max(2.5f, flapHold * 0.9f); }
			}
			else if (!urgent) { aimFlapStreak = 0; flapHold = Mathf.Max(2.5f, flapHold * 0.9f); }
			// A reused (blocked) aim must NOT refresh the window, otherwise a
			// stable opposite target is "a reversal" forever (A12 finding).
			if (aimBlockedSince <= 0f || Time.unscaledTime - aimBlockedSince > flapHold)
			{
				lastAimPos = val3; lastAimAt = Time.unscaledTime; aimBlockedSince = 0f;
			}
			SetTarget(val3, decideResult.Arrive, decideResult.ProjectToNav);
		}
		else
		{
			ClearTarget();
		}
		foreach (string note in decideResult.Notes)
		{
			LogLine(in s, note);
		}
		foreach (Intent intent in decideResult.Intents)
		{
			Execute(in s, intent);
		}
		{
			bool gateIntent = false;
			foreach (Intent gi in decideResult.Intents) if (gi.Kind == IntentKind.GateHold) { gateIntent = true; break; }
			if (!gateIntent && (UnityEngine.Object)(object)heldGate != (UnityEngine.Object)null) ReleaseGate("not-held");
		}
		Efficiency.Update(s.Balance, s.AllyCount, s.DoorsCovered, s.BuildCount, s.IsNight,
			(UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null, Mode.ToString(),
			new Vector2(s.HeroPos.x, s.HeroPos.z), s.GameState == "InMatch", decideResult.Notes);
		Tasks.Update(in s, Mode.ToString(), decideResult.Notes);
		// Rescue rescan: slots exist and gold is in hand but nothing is pickable (every slot parked/ignored) -> forgive and retry.
		if (!s.IsNight && s.GameState == "InMatch" && (s.BuildCount > 0 || s.BlockedBuilds > 0) && (UnityEngine.Object)(object)s.NearestBuild == (UnityEngine.Object)null && s.Balance >= 20)
		{
			if (noPickSince < 0f) noPickSince = Time.unscaledTime;
			else if (Time.unscaledTime - noPickSince > 8f && Time.unscaledTime >= nextRescan)
			{
				nextRescan = Time.unscaledTime + 30f;
				BotPerception.ClearIgnores();
				Memory.ForgiveParksSoft(s.SceneName);   // keep stall/unreachable parks — they were proven bad, not transient
				LogLine(in s, "rescan-slots");
			}
		}
		else noPickSince = -1f;
		{
			string wt = Tasks.Watch();
			if (wt != null && s.GameState == "InMatch")
			{
				Coach.Advise("task-watch:" + wt, Digest(in s));
				LogLine(in s, "coach-beat:" + wt);
			}
		}
		// Desperate efficiency: bypass the coach throttle once per 60 s.
		if (Efficiency.Tier == 2 && Efficiency.SecondsSinceProgress > 20f && Time.unscaledTime >= nextEffBeat && s.GameState == "InMatch")
		{
			nextEffBeat = Time.unscaledTime + 60f;
			Coach.Advise("eff-collapse", Digest(in s));
			LogLine(in s, "coach-beat:eff");
		}
		// Coach heartbeat: an idle bot is a failure mode — probe the advisor
		// when the hero has sat in Idle during a live day for >60 s, and on
		// stuck-strike clusters. Throttle lives inside Coach.Advise (45 s min).
		if (Mode == BotMode.Idle && s.GameState == "InMatch" && !s.IsNight)
		{
			if (idleWatchSince < 0f) idleWatchSince = Time.unscaledTime;
			else if (Time.unscaledTime - idleWatchSince > 60f &&
			         Time.unscaledTime >= nextCoachBeat)
			{
				nextCoachBeat = Time.unscaledTime + 90f;
				idleWatchSince = Time.unscaledTime;   // once per spell
				Coach.Advise("idle-watch", Digest(in s));
				LogLine(in s, "coach-beat:idle");
			}
		}
		else idleWatchSince = -1f;
		if (StuckStrikes >= 3 && Time.unscaledTime >= nextCoachBeat)
		{
			nextCoachBeat = Time.unscaledTime + 90f;
			Coach.Advise("stall-watch", Digest(in s));
			LogLine(in s, "coach-beat:stall");
		}
		// Continuous steering: a live match shouldn't go silent between
		// day-start and defeat — a 90 s cadence keeps MiniMax advising during
		// active play too (idle/stall beats still fire on their own timers).
		if (s.GameState == "InMatch" && Time.unscaledTime >= nextCoachBeat)
		{
			nextCoachBeat = Time.unscaledTime + 90f;
			Coach.Advise("coach-beat:periodic", Digest(in s));
			LogLine(in s, "coach-beat:tick");
		}
		RunWatchdog(in s);
		Status = FormatStatus(in s);
		LogLine(in s, "tick");
		Recorder.NoteGameFacts(in s);
		if (Mode != prevModeRec)
		{
			if (Mode == BotMode.HeroDead)
			{
				Recorder.CountDeath();
			}
			prevModeRec = Mode;
			modeSinceAt = Time.unscaledTime;
		}
		if (Time.unscaledTime >= nextAuditAt)
		{
			nextAuditAt = Time.unscaledTime + 3f;
			try
			{
				string text = System.IO.Path.Combine(Recorder.AgentDir, "audit.json");
				string text2 = text + ".tmp";
				File.WriteAllText(text2, BotPerception.AuditJson(ref s, Mode.ToString(), modeSinceAt, Time.unscaledTime));
				if (File.Exists(text))
				{
					File.Delete(text);
				}
				File.Move(text2, text);
			}
			catch
			{
			}
		}
		if ((recTickFrame++ & 1) == 0)
		{
			Recorder.Tick(s2.ToJson("tick", Time.unscaledTime, Mode));
		}
		CheckAnomalies(in s);
		if (StuckStrikes <= 0 || !(Time.unscaledTime >= nextMoveDiagAt))
		{
			return;
		}
		nextMoveDiagAt = Time.unscaledTime + 2f;
		PlayerMovement instance2 = PlayerMovement.instance;
		if ((UnityEngine.Object)(object)instance2 == (UnityEngine.Object)null)
		{
			nextMoveDiagAt = Time.unscaledTime + 2f;
			return;
		}
		int num = ((navPath?.vectorPath != null) ? navPath.vectorPath.Count : (-1));
		string text3 = ((num > 0) ? string.Join(";", navPath.vectorPath) : "-");
		ManualLogSource log8 = Plugin.Log;
		if (log8 != null)
		{
			log8.LogWarning((object)($"[bot] move-diag: hasTgt={hasTarget} desired={DesiredDir} " + $"vel={instance2.Velocity} " + $"frozen={(UnityEngine.Object)(object)LocalGamestate.Instance != (UnityEngine.Object)null && LocalGamestate.Instance.PlayerFrozen} " + $"mode={Mode} aim={AimPos} hero={((Component)instance2).transform.position} " + $"navIdx={navIndex} wpCount={num} inFlight={navInFlight} navGoal={navGoal} wp=[{text3}] steer={NavSteerPoint(((Component)instance2).transform.position, AimPos)}"));
		}
	}

	private static void CheckAnomalies(in BotPerception.Snapshot s)
	{
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_013c: Unknown result type (might be due to invalid IL or missing references)
		//IL_024f: Unknown result type (might be due to invalid IL or missing references)
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime < lastAnomalyAt + 10f)
		{
			return;
		}
		if (StuckStrikes > 0)
		{
			if (unscaledTime > stuckSpamWindow)
			{
				stuckSpamWindow = unscaledTime + 30f;
				stuckSpamCount = 0;
			}
			if (++stuckSpamCount >= 3)
			{
				stuckSpamCount = 0;
				if (!AnomalyAllowed("stuck-spam")) return;
				LogLine(in s, "anomaly:stuck-spam");
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogWarning((object)$"[bot] anomaly stuck-spam at {s.HeroPos} mode={Mode}");
				}
				return;
			}
		}
		if (s.IsNight && s.EnemyCount > 0 && Mode == BotMode.Engage)
		{
			if (nightParkSince < 0f)
			{
				nightParkSince = unscaledTime;
				nightParkPos = s.HeroPos;
			}
			else
			{
				Vector3 val = s.HeroPos - nightParkPos;
				if (val.sqrMagnitude > 1.5f)
				{
					nightParkSince = unscaledTime;
					nightParkPos = s.HeroPos;
				}
				else if (unscaledTime - nightParkSince > 15f)
				{
					nightParkSince = -1f;
					if (!AnomalyAllowed("night-park")) return;
					LogLine(in s, "anomaly:night-park");
					ManualLogSource log2 = Plugin.Log;
					if (log2 != null)
					{
						log2.LogWarning((object)$"[bot] anomaly night-park at {s.HeroPos} foes={s.EnemyCount}");
					}
					return;
				}
			}
		}
		else
		{
			nightParkSince = -1f;
		}
		if (!(BotPerception.MilitaryFirstAt > 0f) || s.AllyCount != 0 || !(unscaledTime - BotPerception.MilitaryFirstAt > 90f))
		{
			return;
		}
		if (!AnomalyAllowed("army-starved", 90f)) return;
		LogLine(in s, "anomaly:army-starved");
		ManualLogSource log3 = Plugin.Log;
		if (log3 != null)
		{
			log3.LogWarning((object)"[bot] anomaly army-starved: military building 90s, ally=0");
		}
		try
		{
			StringBuilder stringBuilder = new StringBuilder();
			BuildSlot[] array = UnityEngine.Object.FindObjectsOfType<BuildSlot>(true);
			foreach (BuildSlot val2 in array)
			{
				if (!((UnityEngine.Object)(object)val2 == (UnityEngine.Object)null))
				{
					string text = val2.buildingName ?? "";
					if (text.IndexOf("barrack", StringComparison.OrdinalIgnoreCase) >= 0 || text.IndexOf("archer", StringComparison.OrdinalIgnoreCase) >= 0 || text.IndexOf("militia", StringComparison.OrdinalIgnoreCase) >= 0)
					{
						stringBuilder.Append(text).Append("(lvl=").Append(val2.Level)
							.Append(",state=")
							.Append(val2.State)
							.Append(",active=")
							.Append(((Component)val2).gameObject.activeInHierarchy)
							.Append(",actLvl=")
							.Append(val2.ActivatorLevel)
							.Append(",via=")
							.Append(((UnityEngine.Object)(object)val2.ActivatorBuilding != (UnityEngine.Object)null) ? (val2.ActivatorBuilding.buildingName + ":" + val2.ActivatorBuilding.Level) : "-")
							.Append(");");
					}
				}
			}
			stringBuilder.Append("| respawners:");
			UnitRespawnerForBuildings[] array2 = UnityEngine.Object.FindObjectsOfType<UnitRespawnerForBuildings>(true);
			foreach (UnitRespawnerForBuildings val3 in array2)
			{
				if ((UnityEngine.Object)(object)val3 == (UnityEngine.Object)null)
				{
					continue;
				}
				int value = ((val3.units != null) ? val3.units.Count : (-1));
				int num = 0;
				int num2 = 0;
				if (val3.units != null)
				{
					foreach (Hp unit in val3.units)
					{
						if (!((UnityEngine.Object)(object)unit == (UnityEngine.Object)null))
						{
							if (((Component)unit).gameObject.activeInHierarchy)
							{
								num++;
							}
							if (unit.Alive)
							{
								num2++;
							}
						}
					}
				}
				stringBuilder.Append(((UnityEngine.Object)val3).name).Append("(units=").Append(value)
					.Append(",act=")
					.Append(num)
					.Append(",alive=")
					.Append(num2)
					.Append(",hp=")
					.Append(((UnityEngine.Object)(object)val3.hp != (UnityEngine.Object)null && !val3.hp.KnockedOut) ? "ok" : "down")
					.Append(");");
			}
			ManualLogSource log4 = Plugin.Log;
			if (log4 != null)
			{
				log4.LogWarning((object)("[bot] respawner dump: " + stringBuilder));
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log5 = Plugin.Log;
			if (log5 != null)
			{
				log5.LogWarning((object)("[bot] respawner dump fail " + ex.Message));
			}
		}
	}

	private static void RunWatchdog(in BotPerception.Snapshot s)
	{
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_033c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0342: Unknown result type (might be due to invalid IL or missing references)
		//IL_0347: Unknown result type (might be due to invalid IL or missing references)
		//IL_034c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a0c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a12: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a17: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a1c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a2b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a47: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a3e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a51: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a56: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a5b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a5e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0882: Unknown result type (might be due to invalid IL or missing references)
		//IL_0879: Unknown result type (might be due to invalid IL or missing references)
		//IL_0a75: Unknown result type (might be due to invalid IL or missing references)
		//IL_0887: Unknown result type (might be due to invalid IL or missing references)
		//IL_088a: Unknown result type (might be due to invalid IL or missing references)
		//IL_088f: Unknown result type (might be due to invalid IL or missing references)
		//IL_089f: Unknown result type (might be due to invalid IL or missing references)
		//IL_08a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_08a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_08ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_08b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_08be: Unknown result type (might be due to invalid IL or missing references)
		//IL_08c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_08c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_08df: Unknown result type (might be due to invalid IL or missing references)
		//IL_08e4: Unknown result type (might be due to invalid IL or missing references)
		//IL_08ee: Expected Obj, but got Unknown
		//IL_08e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_08ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_08f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0467: Unknown result type (might be due to invalid IL or missing references)
		//IL_045e: Unknown result type (might be due to invalid IL or missing references)
		//IL_03f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_046c: Unknown result type (might be due to invalid IL or missing references)
		//IL_046f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0474: Unknown result type (might be due to invalid IL or missing references)
		//IL_0484: Unknown result type (might be due to invalid IL or missing references)
		//IL_0489: Unknown result type (might be due to invalid IL or missing references)
		//IL_048e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0493: Unknown result type (might be due to invalid IL or missing references)
		//IL_0495: Unknown result type (might be due to invalid IL or missing references)
		//IL_04a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_04a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_04ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_094e: Unknown result type (might be due to invalid IL or missing references)
		//IL_04c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_04c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_04d3: Expected Obj, but got Unknown
		//IL_04ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_04d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_04d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0514: Unknown result type (might be due to invalid IL or missing references)
		//IL_0579: Unknown result type (might be due to invalid IL or missing references)
		//IL_05f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0639: Unknown result type (might be due to invalid IL or missing references)
		//IL_0741: Unknown result type (might be due to invalid IL or missing references)
		//IL_0746: Unknown result type (might be due to invalid IL or missing references)
		//IL_0760: Unknown result type (might be due to invalid IL or missing references)
		//IL_076b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0770: Unknown result type (might be due to invalid IL or missing references)
		if ((UnityEngine.Object)(object)LocalGamestate.Instance != (UnityEngine.Object)null && LocalGamestate.Instance.PlayerFrozen)
		{
			watchClock = 0f;
			lastWatchDist = float.MaxValue;
			return;
		}
		if (!hasTarget || Mode == BotMode.Idle || s.HeroDead)
		{
			hasAnchor = false;
			StuckStrikes = 0;
			watchClock = 0f;
			lastWatchDist = float.MaxValue;
			return;
		}
		if (!hasAnchor)
		{
			watchAnchor = s.HeroPos;
			hasAnchor = true;
			watchClock = 0f;
			lastWatchDist = FlatDist(s.HeroPos, AimPos);
			return;
		}
		watchClock += 0.25f;
		if (watchClock < 1.5f)
		{
			return;
		}
		watchClock = 0f;
		float num = Vector3.Distance(s.HeroPos, watchAnchor);
		if (num >= 0.35f)
		{
			lastFreePos = watchAnchor;
			lastFreeAt = Time.unscaledTime;
		}
		watchAnchor = s.HeroPos;
		float num2 = FlatDist(s.HeroPos, AimPos);
		bool flag = num2 < lastWatchDist - 0.3f;
		lastWatchDist = num2;
		bool flag2 = num2 > arriveDist + 0.5f;
		if (!flag2 && Mode != BotMode.PositionArmy)
		{
			if (arriveSince <= 0f)
			{
				arriveSince = Time.unscaledTime;
			}
			if (Time.unscaledTime - arriveSince > 20f)
			{
				arriveSince = 0f;
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogWarning((object)$"[bot] aim-stall in {Mode} — parked aim");
				}
				LogLine(in s, "aim-stall");
				if (Mode == BotMode.CollectCoin && (UnityEngine.Object)(object)s.NearestCoin != (UnityEngine.Object)null)
				{
					coinIgnore.Add(s.NearestCoin);
				}
				else if (Mode == BotMode.SpendGold && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
				{
					BotPerception.IgnoreBuild(s.NearestBuild, 300f);
				}
				ClearTarget();
				return;
			}
		}
		else
		{
			arriveSince = 0f;
		}
		// Wall-slide detector: moving but not getting closer (sliding along a wall) for >3 s is a pin too.
		bool slideStuck = false;
		if (!flag2 || num2 < slideDist0 - 1.5f || Time.unscaledTime - slideT0 > 30f) { slideDist0 = num2; slideT0 = Time.unscaledTime; }
		else if (Time.unscaledTime - slideT0 > 3f && Mode != BotMode.Engage && (UnityEngine.Object)(object)heldBuild == (UnityEngine.Object)null)
		{
			slideStuck = true; slideDist0 = num2; slideT0 = Time.unscaledTime;
		}
		if ((((num < 0.35f) & flag2) && !flag) || slideStuck)
		{
			// GPS: a pin on a gate leg counts against that gate (Gates.cs); nothing is parked or learned as a wall for it.
			if (Gates.Active && Gates.OnPinned(s.HeroPos, slideStuck && !(((num < 0.35f) & flag2) && !flag)))
			{
				return;
			}
			Gates.NotePin();
			// Stuck but "reachable": the pathfinder returned a path and the
			// hero still can't move (mesh lies — gate leg, pocket, door seam).
			// Feed it to the GPS as a nav failure so Redirect can try a gate
			// plan instead of burning sidesteps (proposal: stuck detector
			// fired repeatedly while gps-plan never engaged).
			// Threshold 2nd strike (~4.5 s pinned): a first-strike wiggle is
			// usually a unit bump, not a wall — feeding it to the GPS on every
			// strike marked interior goals nav-failed and sent the hero on
			// spurious gate detours ("spin in circles").
			if (StuckStrikes >= 2 && !Gates.Active) Gates.NoteNavFail(AimPos);
			StuckStrikes++;
			// A build/pay HOLD is immobile by design — slow pays (Barracks
			// 40 g) stand still for seconds while coins land. Do NOT let the
			// pin probe park the very slot he's paying: the Firepot churn
			// (94 pins) was his own in-progress interactable re-parked
			// mid-hold, aborting real work.
			if ((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null)
			{
				StuckStrikes = 0;
				return;
			}
			// Physical trap FIRST (was nested inside `if (pinCls != null)`):
			// wedged BETWEEN two colliders the 1.6 m probe finds nothing —
			// pinCls==null and the retreat never fired (audit finding A).
			if (StuckStrikes >= 4 && Legit && Mode != BotMode.Engage &&
			    Mode != BotMode.HeroDead && Time.unscaledTime >= retreatUntil)
			{
				// Castle first — it sits center-map on open ground; the
				// pocket mouth (lastFreePos) was still inside the trap
				// (74 retreats, zero escapes). Only fall back to
				// lastFreePos when no castle exists.
				Vector3 home = s.HasCastle ? s.CastlePos : lastFreePos;
				if (home != Vector3.zero)
				{
					// Latch the retreat: the 4 Hz decide loop re-overrode
					// the aim every ~1.6 s, so each retreat died before he
					// moved a metre. Now the castle aim holds for 15 s
					// regardless of what the brain wants next.
					navPath = null; navIndex = 0; navWrongLayer = false;
					retreatPos = home;
					retreatUntil = Time.unscaledTime + 15f;
					SetTarget(home, 2.5f, projectToNav: true);
					// PHYSICAL escape drive: aims alone don't move him out
					// of a collider pocket — steer backwards off the pin
					// (away from where the aim was pointing) for 4 s so
					// the CharacterController actually walks free.
					Vector3 back = s.HeroPos - AimPos; back.y = 0f;
					detourPos = back.sqrMagnitude > 0.01f
					    ? s.HeroPos + back.normalized * 7f
					    : s.HeroPos + Vector3.Cross(Vector3.up, Vector3.forward) * 7f;
					if ((UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
					    detourPos = AstarPath.active.GetNearest(detourPos, new NNConstraint()).position;
					detourUntil = Time.unscaledTime + 4f;
					LogLine(in s, "trap-retreat");
				}
				return;
			}
			// Awareness probe: WHAT is the hero pinned on? Classifies the
			// collider ahead — pen (buildable/upgradeable), gate, wall,
			// terrain rock/tree, enemy, other object — so pins learn the
			// structure instead of an anonymous "stuck".
			string pinCls = PinProbe(s.HeroPos, AimPos);
			// Cell-heat only for REAL geometry — unit/enemy bumps marked the
			// cell hot and the planner repicked + fired stuck-spam on what
			// was just a follower crowding him (pin:unit = top class).
			if (pinCls != "unit" && pinCls != "enemy")
				SpatialMemory.Bump(s.SceneName, s.HeroPos);
			if (pinCls != null)
			{
				LogLine(in s, "pin:" + pinCls);
				Recorder.Event("pin-type", "\"what\":\"" + pinCls + "\"" + Act.PinExtraJson(s.HeroPos));   // + the blocker's name/layer/bounds/static flag
				// ORDER MATTERS: "obj:Boundaries*" must be checked BEFORE the
				// stand-pocket branch (whose "obj:" prefix would swallow it).
				// A boundary pin means the CURRENT GOAL — coin, slot, anchor —
				// is past the world edge: park that goal kind, not whatever
				// building happens to be nearest.
				if (pinCls.StartsWith("obj:Boundaries"))
				{
					if (Mode == BotMode.CollectCoin && (UnityEngine.Object)(object)s.NearestCoin != (UnityEngine.Object)null)
					{
						coinIgnore.Add(s.NearestCoin);   // the edge coin stays reachable=false forever
						LogLine(in s, "boundary-coin-park");
					}
					else if (Mode == BotMode.SpendGold && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
					{
						// Edge slots cluster: parking ONE slot for 60 s just
						// sent him to the next slot in the same dead pocket
						// (28 re-parks in 200 s). Park the whole pocket HARD —
						// it never becomes reachable for the rest of the run.
						BotPerception.IgnoreStand(s.NearestBuildPos);
						int pk = BotPerception.IgnorePocket(s.NearestBuildPos, 16f, 600f, hard: true);
						BotPerception.NoteBuildFail(BotPerception.BuildCat(s.NearestBuildName));
						LogLine(in s, "boundary-slot-park:" + pk);
					}
					else LogLine(in s, "boundary-pin-drop");
					ClearTarget();
					return;
				}
				// Strike >= 2 only: a first-strike bump is usually a friendly
				// unit, not a wall — parking the slot on that evidence
				// aborted real work (audit finding B). "unit"/"enemy"/"gate"
				// classes are excluded: a body bump is not a building pocket.
				if (StuckStrikes >= 2 && Mode == BotMode.SpendGold &&
				    (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null &&
				    (pinCls.StartsWith("pen:") || pinCls.StartsWith("wall") || pinCls.StartsWith("obj:")))
				{
					// Not just the stand set — the whole slot is wedged in
					// collider geometry right now. Stand-blacklist + park the
					// pocket (soft: interior pockets can open as walls die).
					BotPerception.IgnoreStand(s.NearestBuildPos);
					BotPerception.IgnorePocket(s.NearestBuildPos, 12f, 120f);
					BotPerception.NoteBuildFail(BotPerception.BuildCat(s.NearestBuildName));
					ClearTarget();
					LogLine(in s, "stand-pocket");
					return;
				}
			}
			stuckStrikeTotal++;
			if (stuckStrikeTotal == 60)
			{
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogWarning((object)"[bot] 60 stuck strikes — per-strike logging capped this run");
				}
			}
			else if (stuckStrikeTotal < 60)
			{
				ManualLogSource log3 = Plugin.Log;
				if (log3 != null)
				{
					log3.LogWarning((object)$"[bot] stuck strike {StuckStrikes} (mode={Mode}, moved {num:0.00} m)");
				}
			}
			LogLine(in s, $"stuck:{StuckStrikes}");
			// Pinned en route to a build slot (live data: hero stood 13-20 s at a wall, 27-67 m short of towers beyond it):
			// two still windows (~4 s) -> park that slot now instead of waiting for 3 strikes / the 18 s approach timeout.
			if (StuckStrikes >= 2 && Mode == BotMode.SpendGold && (UnityEngine.Object)(object)heldBuild == (UnityEngine.Object)null && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
			{
				BotPerception.IgnoreBuild(s.NearestBuild, 300f);
				// Park the fenced pocket too — sibling slots in the same
				// unreachable gap re-pin on the next pick (Boundaries loop).
				// Immovable geometry (boundary/terrain/ground) hard-parks:
				// no gate will ever open it, so rescan must not forgive it.
				bool hardPin = pinCls != null && (
					pinCls.IndexOf("boundar", StringComparison.OrdinalIgnoreCase) >= 0 ||
					pinCls.IndexOf("terrain", StringComparison.OrdinalIgnoreCase) >= 0 ||
					pinCls.IndexOf("ground", StringComparison.OrdinalIgnoreCase) >= 0);
				BotPerception.IgnorePocket(
					((Component)s.NearestBuild).transform.position,
					12f, hardPin ? 600f : 300f, hardPin);
				ClearTarget();
				StuckStrikes = 0;
				LogLine(in s, "pin-park");
				return;
			}
			// First strike (~1.5 s pinned): immediate sidestep along the learned-cool side instead of waiting 3 strikes.
			// Unit/enemy bumps are transient — the sidestep+detour machinery
			// on a follower collision is the visible "wiggle" churn (361
			// sidesteps this run were escorts bumping him). Only geometry
			// classes deserve the detour.
			if (StuckStrikes == 1 && Legit && Mode != BotMode.Engage &&
			    pinCls != "unit" && pinCls != "enemy")
			{
				Vector3 qv = AimPos - s.HeroPos;
				qv.y = 0f;
				Vector3 qd = qv.sqrMagnitude > 0.01f ? qv.normalized : Vector3.forward;
				Vector3 qp = s.HeroPos - qd * 1.5f + Vector3.Cross(Vector3.up, qd) * (4f * (float)detourSide);
				if ((UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
				{
					qp = AstarPath.active.GetNearest(qp, new NNConstraint()).position;
				}
				detourPos = ChooseDetour(in s, qd, qp);
				detourUntil = Time.unscaledTime + 1.2f;
				detourSide = -detourSide;
				LogLine(in s, "quick-sidestep");
			}
			if (StuckStrikes < 3)
			{
				return;
			}
			StuckStrikes = 0;
			if (Mode == BotMode.Engage)
			{
				mem.OrbitAngle += mem.OrbitDir * 0.9f;
			}
			if (Mode == BotMode.CollectCoin && (UnityEngine.Object)(object)s.NearestCoin != (UnityEngine.Object)null)
			{
				coinIgnore.Add(s.NearestCoin);
				ClearTarget();
				ManualLogSource log4 = Plugin.Log;
				if (log4 != null)
				{
					log4.LogWarning((object)"[bot] coin unreachable — parked");
				}
				LogLine(in s, "coin-stall");
				return;
			}
			PlayerMovement instance = PlayerMovement.instance;
			if (Legit)
			{
				Vector3 val = AimPos - s.HeroPos;
				val.y = 0f;
				if (num < 0.05f && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
				{
					CharacterController component = ((Component)instance).GetComponent<CharacterController>();
					ManualLogSource log5 = Plugin.Log;
					if (log5 != null)
					{
						log5.LogWarning((object)("[bot] hard-stuck diag: type=" + ((object)instance).GetType().Name + " " + $"ctrlEnabled={(UnityEngine.Object)(object)component != (UnityEngine.Object)null && ((Collider)component).enabled} grounded={(UnityEngine.Object)(object)component != (UnityEngine.Object)null && component.isGrounded} " + $"vel={instance.Velocity} dead={instance.Dead} scene={s.SceneName}"));
					}
					detourCount++;
					if (detourCount > 4)
					{
						detourCount = 1;
						detourSide = -detourSide;
					}
					float num3 = 3f * (float)detourCount;
					Vector3 val2 = ((val.sqrMagnitude > 0.01f) ? val.normalized : Vector3.forward);
					detourPos = s.HeroPos - val2 * (2f + num3 * 0.5f) + Vector3.Cross(Vector3.up, val2) * (num3 * (float)detourSide);
					if ((UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
					{
						detourPos = AstarPath.active.GetNearest(detourPos, new NNConstraint()).position;
					}
					// Spatial learning (A4): remember WHERE we pin, and choose
					// the detour from 8 headings whose walkable end-point is
					// outside every learned-hot cell — the old blind guess was
					// snapped back onto the same chokepoint by GetNearest.
					SpatialMemory.Bump(s.SceneName, s.HeroPos);
					detourPos = ChooseDetour(in s, val2, detourPos);
					detourUntil = Time.unscaledTime + 1.2f + 0.6f * (float)detourCount;
					ManualLogSource log6 = Plugin.Log;
					if (log6 != null)
					{
						log6.LogWarning((object)$"[bot] hard-stuck (legit) → detour x{detourCount} to {detourPos}");
					}
					LogLine(in s, $"unstick:{detourCount}");
					if (Mode == BotMode.PositionArmy && s.HasUncoveredDoor && (navWrongLayer || detourCount >= 3))
					{
						if (s.UncoveredDoorIdx >= 0)
						{
							BotPerception.ParkDoorIdx(s.UncoveredDoorIdx);
						}
						else
						{
							BotPerception.ParkDoorAnchor(s.UncoveredDoorPos);
						}
						navWrongLayer = false;
						ClearTarget();
						LogLine(in s, "door-unreachable");
					}
					else if (Mode == BotMode.SpendGold && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null && (navWrongLayer || detourCount >= 3))
					{
						if (s.HeroPos.y > s.NearestBuildPos.y + 2.5f)
						{
							ClearTarget();
							navWrongLayer = false;
							detourCount = 0;
							SetTarget(s.CastlePos, 1.5f);
							ManualLogSource log7 = Plugin.Log;
							if (log7 != null)
							{
								log7.LogWarning((object)"[bot] hero on wall top → descending via castle");
							}
							LogLine(in s, "hero-descend");
							return;
						}
						if (navWrongLayer && detourCount < 3)
						{
							BotPerception.IgnoreStand(s.NearestBuildPos);
							BotPerception.NoteBuildFail(BotPerception.BuildCat(s.NearestBuildName));
							navDirectUntil = Time.unscaledTime + 9f;
							navPath = null;
							navIndex = 0;
							navWrongLayer = false;
							ManualLogSource log8 = Plugin.Log;
							if (log8 != null)
							{
								log8.LogWarning((object)"[bot] wrong-layer path → direct steer 9s");
							}
							LogLine(in s, "direct-steer");
							return;
						}
						string text = s.NearestBuildName ?? "";
						bool flag3 = text.IndexOf("castle", StringComparison.OrdinalIgnoreCase) >= 0 || text.IndexOf("horn", StringComparison.OrdinalIgnoreCase) >= 0 || ((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null && (object)s.NearestBuild == BotPerception.HornBi);
						BotPerception.IgnoreBuild(s.NearestBuild, flag3 ? 60f : 300f);
						BotPerception.NoteBuildFail(BotPerception.BuildCat(s.NearestBuildName));
						if (flag3)
						{
							ClearTarget();
							ManualLogSource log9 = Plugin.Log;
							if (log9 != null)
							{
								log9.LogWarning((object)"[bot] vital slot unreachable — short ignore only (no park)");
							}
							LogLine(in s, "build-vital-skip");
						}
						else
						{
							Vector3 nearestBuildPos = s.NearestBuildPos;
							for (float num4 = -8f; num4 <= 8f; num4 += 8f)
							{
								for (float num5 = -8f; num5 <= 8f; num5 += 8f)
								{
									Memory.Park(s.SceneName, nearestBuildPos + new Vector3(num4, 0f, num5), "unreachable");
								}
							}
						}
						ClearTarget();
						ManualLogSource log10 = Plugin.Log;
						if (log10 != null)
						{
							log10.LogWarning((object)("[bot] slot unreachable — parked 5 min" + (navWrongLayer ? " [layer]" : "") + " + pocket cells"));
						}
						navWrongLayer = false;
						LogLine(in s, "build-unreachable");
					}
					else if (detourCount >= 4)
					{
						ManualLogSource log11 = Plugin.Log;
						if (log11 != null)
						{
							log11.LogWarning((object)$"[bot] aim unreachable in {Mode} — released (detour x{detourCount})");
						}
						LogLine(in s, "aim-unreachable");
						ClearTarget();
					}
				}
				else
				{
					detourCount++;
					if (detourCount > 4)
					{
						detourCount = 1;
						detourSide = -detourSide;
					}
					float num6 = 3f * (float)detourCount;
					Vector3 val3 = ((val.sqrMagnitude > 0.01f) ? val.normalized : Vector3.forward);
					detourPos = s.HeroPos - val3 * (2f + num6 * 0.5f) + Vector3.Cross(Vector3.up, val3) * (num6 * (float)detourSide);
					if ((UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
					{
						detourPos = AstarPath.active.GetNearest(detourPos, new NNConstraint()).position;
					}
					detourUntil = Time.unscaledTime + 1.2f + 0.6f * (float)detourCount;
					UIFrame val4 = (((UnityEngine.Object)(object)UIFrameManager.instance != (UnityEngine.Object)null) ? UIFrameManager.instance.ActiveFrame : null);
					ManualLogSource log12 = Plugin.Log;
					if (log12 != null)
					{
						log12.LogWarning((object)($"[bot] stuck → sidestep detour x{detourCount} to {detourPos} " + $"(frozen={(UnityEngine.Object)(object)LocalGamestate.Instance != (UnityEngine.Object)null && LocalGamestate.Instance.PlayerFrozen}, " + string.Format("ts={0:0.##}, frame={1}, ", Time.timeScale, ((UnityEngine.Object)(object)val4 != (UnityEngine.Object)null) ? ((UnityEngine.Object)val4).name : "null") + $"choiceWait={(UnityEngine.Object)(object)ChoiceManager.instance != (UnityEngine.Object)null && ChoiceManager.instance.ChoiceCoroutineWaiting})"));
					}
					LogLine(in s, $"unstick:{detourCount}");
				}
			}
			else if ((UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
			{
				Vector3 val5 = AimPos - s.HeroPos;
				val5.y = 0f;
				Vector3 val6 = s.HeroPos + ((val5.sqrMagnitude > 0.01f) ? val5.normalized : Vector3.forward) * 2.5f;
				instance.TeleportTo(val6);
				ManualLogSource log13 = Plugin.Log;
				if (log13 != null)
				{
					log13.LogWarning((object)$"[bot] stuck → teleport nudge to {val6}");
				}
				LogLine(in s, "teleport-nudge");
			}
		}
		else
		{
			StuckStrikes = 0;
		}
	}

	private static void WriteAuditStub(in BotPerception.Snapshot s, string label)
	{
		if (Time.unscaledTime < nextAuditAt)
		{
			return;
		}
		nextAuditAt = Time.unscaledTime + 3f;
		try
		{
			string text = System.IO.Path.Combine(Recorder.AgentDir, "audit.json");
			string text2 = text + ".tmp";
			File.WriteAllText(text2, "{\"scene\":" + BotPerception.JsonStr(s.SceneName ?? "?") + ",\"t\":0,\"mode\":" + BotPerception.JsonStr(label) + ",\"mode_since\":0,\"gold\":0,\"ally\":0,\"free\":0,\"foes\":0,\"night\":false,\"wave\":0,\"wave_total\":0,\"doors_cov\":0,\"doors\":0,\"red\":false,\"breaches\":0,\"bld\":0,\"cur_build\":\"\",\"checklist\":[],\"door_units\":[],\"door_lines\":[],\"cat_built\":{},\"alerts\":[]}");
			if (File.Exists(text))
			{
				File.Delete(text);
			}
			File.Move(text2, text);
		}
		catch
		{
		}
	}

	private static float AimY(in BotPerception.Snapshot s, Vector3 flat)
	{
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		if (Mode == BotMode.SpendGold && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
		{
			if (s.HasBuildStand && FlatDist(flat, s.BuildStandPos) < 3f)
			{
				return s.BuildStandPos.y;
			}
			if (FlatDist(flat, s.NearestBuildPos) < 6f)
			{
				return s.NearestBuildPos.y;
			}
		}
		if ((Mode == BotMode.HoldCastle || Mode == BotMode.PositionArmy) && s.HasCastle)
		{
			if (s.HasCastleStand && FlatDist(flat, s.CastleStandPos) < 4f)
			{
				return s.CastleStandPos.y;
			}
			if (FlatDist(flat, s.CastlePos) < 6f)
			{
				return s.CastlePos.y;
			}
		}
		if (Mode == BotMode.PositionArmy && s.HasUncoveredDoor && FlatDist(flat, s.UncoveredDoorPos) < 8f)
		{
			return s.UncoveredDoorPos.y;
		}
		return flat.y;
	}

	private static void SetTarget(Vector3 pos, float arrive, bool projectToNav = false)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Expected Obj, but got Unknown
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		if (projectToNav && (UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
		{
			pos = AstarPath.active.GetNearest(pos, NearestNodeConstraint.Walkable).position;
		}
		if (FlatDist(pos, targetPos) > 6f)
		{
			detourCount = 0;
			navWrongLayer = false;
			arriveSince = 0f;
			frontierLatch = false;
		}
		targetPos = pos;
		arriveDist = arrive;
		hasTarget = true;
	}

	private static void Execute(in BotPerception.Snapshot s, Intent it)
	{
		//IL_03cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0442: Unknown result type (might be due to invalid IL or missing references)
		if (it.CheatOnly && Legit)
		{
			return;
		}
		PlayerInteraction instance = PlayerInteraction.instance;
		switch (it.Kind)
		{
		case IntentKind.ReleaseHold:
			ReleaseBuild("intent");
			break;
		case IntentKind.BeginHold:
		{
			if (!((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null) || !((UnityEngine.Object)(object)instance != (UnityEngine.Object)null))
			{
				break;
			}
			ReleaseBuild("pre-begin");
			BuildingInteractor nearestBuild = s.NearestBuild;
			((InteractorBase)nearestBuild).Focus(instance);
			((InteractorBase)nearestBuild).InteractionBegin(instance);
			if (IsInterLatchedComplete(nearestBuild))
			{
				((InteractorBase)nearestBuild).InteractionEnd(instance);
				nearestBuild.UpdateInteractionState(false, (BuildingInteractor.InteractionState)0);
				((InteractorBase)nearestBuild).InteractionBegin(instance);
			}
			if (IsInterLatchedComplete(nearestBuild))
			{
				((InteractorBase)nearestBuild).Unfocus(instance);
				((InteractorBase)nearestBuild).InteractionEnd(instance);
				LogLine(in s, "hold-latch-defer");
				BotPerception.IgnoreBuild(nearestBuild, 30f);
				break;
			}
			heldBuild = nearestBuild;
			BotPerception.HeldBuildRef = nearestBuild;
			if (!string.IsNullOrEmpty(s.PolicyFocus))
			{
				Policy.Commit("build_focus", s.PolicyFocus, s.PolicyKey ?? "", new string[4] { "military", "income", "defense", "balanced" });
			}
			ManualLogSource log4 = Plugin.Log;
			if (log4 != null)
			{
				log4.LogInfo((object)("[bot] building '" + ((UnityEngine.Object)nearestBuild).name + "' -> hold-to-pay"));
			}
			break;
		}
		case IntentKind.PumpHold:
			if ((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
			{
				((InteractorBase)heldBuild).InteractionHold(instance);
			}
			break;
		case IntentKind.ParkSlot:
			if ((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
			{
				Type type = ((object)s.NearestBuild).GetType();
				string text = "?";
				object obj = "?";
				object obj2 = "?";
				object obj3 = "?";
				FieldInfo field = type.GetField("currentState", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field != null)
				{
					text = field.GetValue(s.NearestBuild)?.ToString();
				}
				FieldInfo field2 = type.GetField("interactionStarted", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field2 != null)
				{
					obj = field2.GetValue(s.NearestBuild);
				}
				FieldInfo field3 = type.GetField("isWaitingForChoice", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field3 != null)
				{
					obj2 = field3.GetValue(s.NearestBuild);
				}
				FieldInfo field4 = type.GetField("interactionComplete", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field4 != null)
				{
					obj3 = field4.GetValue(s.NearestBuild);
				}
				FieldInfo field5 = type.GetField("costDisplay", BindingFlags.Instance | BindingFlags.NonPublic);
				object obj4 = "?";
				if (field5 != null)
				{
					object value = field5.GetValue(s.NearestBuild);
					FieldInfo fieldInfo = value?.GetType().GetField("currentlyFilledCoins", BindingFlags.Instance | BindingFlags.NonPublic);
					if (fieldInfo != null)
					{
						obj4 = fieldInfo.GetValue(value);
					}
				}
				ManualLogSource log6 = Plugin.Log;
				if (log6 != null)
				{
					log6.LogWarning((object)("[bot] build-stall diag '" + s.NearestBuildName + "': " + $"state={text} started={obj} waitChoice={obj2} complete={obj3} filled={obj4} " + $"dist={s.NearestBuildDist:0.#} balance={s.Balance} harvest={s.NearestBuild.canBeHarvested} " + $"canInteract={((InteractorBase)s.NearestBuild).CanBeInteractedWith}"));
				}
			}
			// Scaled ignore (audit): a real wedge parks 10 min; a far approach
			// stall (behind an unopened gate) only hides the slot 60 s — the
			// gate may open, and 600 s used to outlast whole days.
			BotPerception.IgnoreBuild(s.NearestBuild, s.NearestBuildDist <= 14f ? 600f : 60f);
			if (!((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null))
			{
				break;
			}
			// Only burn a memory cell when the hero ARRIVED and the hold still
			// wouldn't start (a genuine wedge). Far stalls (36–147 m) are
			// approach timeouts — the slot may become reachable after a gate
			// opens, and permanent parking was deleting real upgrade targets
			// forever ("pens never get upgraded").
			if (!IsInterLatchedComplete(s.NearestBuild) && s.NearestBuildDist <= 14f)
			{
				Memory.Park(s.SceneName, ((Component)s.NearestBuild).transform.position, "build-stall");
			}
			else if (!IsInterLatchedComplete(s.NearestBuild))
			{
				Plugin.Log?.LogInfo($"[bot] build-stall at {s.NearestBuildDist:0.#} m — approach stall, cell kept");
			}
			else
			{
				ManualLogSource log7 = Plugin.Log;
				if (log7 != null)
				{
					log7.LogWarning((object)"[bot] build-stall is a complete-latch wedge — cell NOT parked");
				}
			}
			// catStuck only counts real wedges — approach stalls were retiring
			// whole categories (4 'tower' fails -> no towers for the rest of
			// the run).
			if (s.NearestBuildDist <= 14f)
				BotPerception.NoteBuildFail(BotPerception.BuildCat(s.NearestBuildName));
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
			if (PlaceSquad(in s) > 0 && s.HasUncoveredDoor)
			{
				if (s.UncoveredDoorIdx >= 0)
				{
					BotPerception.MarkDoorClaimIdx(s.UncoveredDoorIdx);
				}
				else
				{
					BotPerception.MarkDoorClaim(s.UncoveredDoorPos);
				}
			}
			break;
		case IntentKind.ParkDoor:
			BotPerception.ParkDoorIdx(it.Index);
			break;
		case IntentKind.GateHold:
			GateHold(in s);
			break;
		case IntentKind.RecallToBreach:
			RecallToBreach(in s);
			break;
		case IntentKind.EscortHero:
			EscortHero(in s);
			break;
		case IntentKind.HornInteract:
			if ((UnityEngine.Object)(object)s.Horn != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
			{
				((InteractorBase)s.Horn).InteractionBegin(instance);
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogInfo((object)"[bot] at nighthorn -> InteractionBegin()");
				}
			}
			else if ((UnityEngine.Object)(object)BotPerception.HornBi != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
			{
				BotPerception.HornBi.InteractionBegin(instance);
				ManualLogSource log3 = Plugin.Log;
				if (log3 != null)
				{
					log3.LogInfo((object)"[bot] horn interactor -> InteractionBegin()");
				}
			}
			break;
		case IntentKind.SwitchNight:
		{
			// Call-night precondition (decompiled PlayerInteraction.IsFreeToCallNight):
			// no focussed interactor, not frozen, castle alive, tutorial allows,
			// match running. Calling SwitchToNight while blocked just no-ops —
			// the brain burned the 15 s retry window on silent rejects.
			var pi = PlayerInteraction.instance;
			if ((UnityEngine.Object)(object)pi != (UnityEngine.Object)null && !pi.IsFreeToCallNight)
			{
				// Blocked usually = a focussed interactor. Step off it so the
				// game's own Unfocus clears and the next tick can call night —
				// previously the 15 s window just burned standing on the slot.
				var fi = pi.FocussedInteractor;
				if ((UnityEngine.Object)(object)fi != (UnityEngine.Object)null)
				{
					// Throttled: this fired EVERY tick while the call stayed
					// blocked — 687 micro-steps = the in-out doorway dance.
					if (Time.unscaledTime >= unfocusStepAt)
					{
						unfocusStepAt = Time.unscaledTime + 3f;
						Vector3 away = s.HeroPos - ((Component)fi).transform.position;
						away.y = 0f;
						if (away.sqrMagnitude < 0.01f)
						{
							away = new Vector3(5f, 0f, 0f);
						}
						away = away.normalized * 6f;
						SetTarget(s.HeroPos + away, 1.5f, projectToNav: true);
						LogLine(in s, "night-unfocus-step");
					}
				}
				else
				{
					LogLine(in s, "night-blocked");
				}
				break;
			}
			Policy.Commit("night", ((int)s.DayBudget).ToString(), s.PolicyKey ?? "", new string[3] { "150", "240", "330" });
			DayNightCycle instance3 = DayNightCycle.Instance;
			if (instance3 != null)
			{
				instance3.SwitchToNight();
			}
			break;
		}
		case IntentKind.SeedLoadout:
			SeedLoadout(in s);
			break;
		case IntentKind.TransitionLevel:
		{
			LevelInteractor nearestLevel = s.NearestLevel;
			SceneTransitionManager instance2 = SceneTransitionManager.instance;
			if ((UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && (UnityEngine.Object)(object)nearestLevel != (UnityEngine.Object)null && (UnityEngine.Object)(object)nearestLevel.levelInfo != (UnityEngine.Object)null && !BotPerception.SceneTransitionBusy(instance2))
			{
				LevelInteractor.lastActiveLevelInfo = nearestLevel.levelInfo;
				ManualLogSource log5 = Plugin.Log;
				if (log5 != null)
				{
					log5.LogInfo((object)("[bot] transitioning to level '" + nearestLevel.levelInfo.sceneName + "'"));
				}
				instance2.TransitionFromLevelSelectToLevel(nearestLevel.levelInfo.sceneName);
			}
			break;
		}
		case IntentKind.InteractLevel:
			if ((UnityEngine.Object)(object)s.NearestLevel != (UnityEngine.Object)null && (UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
			{
				((InteractorBase)s.NearestLevel).InteractionBegin(instance);
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)("[bot] level '" + ((UnityEngine.Object)s.NearestLevel).name + "' -> InteractionBegin (frame)"));
				}
			}
			break;
		case IntentKind.ClearCoinPark:
			coinIgnore.Clear();
			break;
		}
	}

	private static bool NearDoor(Vector3 p, Vector3[] doors, float r)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		if (doors == null)
		{
			return false;
		}
		for (int i = 0; i < doors.Length; i++)
		{
			float num = doors[i].x - p.x;
			float num2 = doors[i].z - p.z;
			if (num * num + num2 * num2 < r * r)
			{
				return true;
			}
		}
		return false;
	}

	private static void CommandArmyAll(in BotPerception.Snapshot s)
	{
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		CommandUnits instance = CommandUnits.instance;
		TagManager instance2 = TagManager.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null || (UnityEngine.Object)(object)instance2 == (UnityEngine.Object)null)
		{
			return;
		}
		Vector3[] doorAnchors = s.DoorAnchors;
		int num = 0;
		foreach (TaggedObject playerUnit in TagManager.instance.PlayerUnits)
		{
			if (!((UnityEngine.Object)(object)playerUnit == (UnityEngine.Object)null) && !((UnityEngine.Object)(object)playerUnit.Hp == (UnityEngine.Object)null) && playerUnit.Hp.Alive && !NearDoor(((Component)playerUnit).transform.position, doorAnchors, 25f))
			{
				PathfindMovementPlayerunit component = ((Component)playerUnit).GetComponent<PathfindMovementPlayerunit>();
				if (!((UnityEngine.Object)(object)component != (UnityEngine.Object)null) || !component.FollowingPlayer)
				{
					instance.OnUnitAdd(playerUnit, false);
					num++;
				}
			}
		}
		instance.commanding = num > 0;
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)$"[bot] commanding {num} free unit(s) (squads stay posted)");
		}
	}

	private static int PlaceSquad(in BotPerception.Snapshot s)
	{
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_0100: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		int num = ((s.UncoveredDoorTarget > 0) ? s.UncoveredDoorTarget : 4);
		int num2 = 0;
		int num3 = Mathf.Max(Coach.ReserveSize, BotPerception.Strat.Reserve);
		int num4 = Mathf.Max(0, s.FreeUnits - num3);
		TagManager instance = TagManager.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null)
		{
			return 0;
		}
		IReadOnlyList<TaggedObject> playerUnits = instance.PlayerUnits;
		for (int i = 0; i < playerUnits.Count; i++)
		{
			if (num2 >= num)
			{
				break;
			}
			if (num2 >= num4)
			{
				break;
			}
			TaggedObject val = playerUnits[i];
			if (!((UnityEngine.Object)(object)val == (UnityEngine.Object)null) && !((UnityEngine.Object)(object)val.Hp == (UnityEngine.Object)null) && val.Hp.Alive)
			{
				PathfindMovementPlayerunit component = ((Component)val).GetComponent<PathfindMovementPlayerunit>();
				if (!((UnityEngine.Object)(object)component == (UnityEngine.Object)null) && !NearDoor(((Component)component).transform.position, s.DoorAnchors, 25f) && !component.FollowingPlayer)
				{
					float num5 = (float)num2 * 1.571f;
					Vector3 val2 = new Vector3(Mathf.Cos(num5), 0f, Mathf.Sin(num5)) * (1.2f + 0.4f * (float)num2);
					component.HomePosition = s.UncoveredDoorPos + val2;
					component.HasReachedHomePositionAlready = false;
					component.FollowPlayer(false);
					component.HoldPosition = true;
					num2++;
				}
			}
		}
		if (num2 > 0)
		{
			Policy.Commit("squad", num.ToString(), s.PolicyKey ?? "", new string[5] { "3", "4", "5", "6", "8" });
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)$"[bot] posted squad {num2}/{num} remotely at door '{s.UncoveredDoorLine}'");
			}
		}
		return num2;
	}

	private static void RecallToBreach(in BotPerception.Snapshot s)
	{
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		TagManager instance = TagManager.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null)
		{
			return;
		}
		IReadOnlyList<TaggedObject> playerUnits = instance.PlayerUnits;
		int num = 0;
		for (int i = 0; i < playerUnits.Count; i++)
		{
			TaggedObject val = playerUnits[i];
			if (!((UnityEngine.Object)(object)val == (UnityEngine.Object)null) && !((UnityEngine.Object)(object)val.Hp == (UnityEngine.Object)null) && val.Hp.Alive)
			{
				PathfindMovementPlayerunit component = ((Component)val).GetComponent<PathfindMovementPlayerunit>();
				if (!((UnityEngine.Object)(object)component == (UnityEngine.Object)null))
				{
					// Don't strip squads posted at doors FAR from the breach:
					// re-homing every unit vacated the other lanes and the
					// leak cascaded (Frostsee wave-12/13 defeats).
					if (component.HoldPosition && s.DoorAnchors != null)
					{
						Vector3 hp = component.HomePosition;
						bool farPosted = false;
						for (int d = 0; d < s.DoorAnchors.Length; d++)
						{
							Vector3 a = s.DoorAnchors[d]; a.y = hp.y;
							if ((a - hp).sqrMagnitude <= 64f &&
							    (s.ThreatAnchor - a).sqrMagnitude > 625f)
								farPosted = true;
						}
						if (farPosted) continue;
					}
					float num2 = (float)num * 0.785f;
					Vector3 val2 = new Vector3(Mathf.Cos(num2), 0f, Mathf.Sin(num2)) * (1.5f + 0.3f * (float)num);
					component.FollowPlayer(false);
					component.HomePosition = s.ThreatAnchor + val2;
					component.HasReachedHomePositionAlready = false;
					component.HoldPosition = true;
					num++;
				}
			}
		}
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogWarning((object)$"[bot] BREACH-RESPONSE: {num} unit(s) converging on threat");
		}
	}

	private static void EscortHero(in BotPerception.Snapshot s)
	{
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		int num;
		if (Coach.EscortSize > 0)
		{
			num = Coach.EscortSize;
		}
		else if (BotPerception.Strat.Escort > 0)
		{
			num = BotPerception.Strat.Escort;
		}
		else
		{
			num = ((s.AllyCount >= 12) ? 4 : 3);
		}
		int num2 = 0;
		TagManager instance = TagManager.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null)
		{
			return;
		}
		IReadOnlyList<TaggedObject> playerUnits = instance.PlayerUnits;
		for (int i = 0; i < playerUnits.Count; i++)
		{
			TaggedObject val = playerUnits[i];
			if ((UnityEngine.Object)(object)val == (UnityEngine.Object)null || (UnityEngine.Object)(object)val.Hp == (UnityEngine.Object)null || !val.Hp.Alive)
			{
				continue;
			}
			PathfindMovementPlayerunit component = ((Component)val).GetComponent<PathfindMovementPlayerunit>();
			if (!((UnityEngine.Object)(object)component == (UnityEngine.Object)null) && !NearDoor(((Component)component).transform.position, s.DoorAnchors, 25f))
			{
				bool flag = component.FollowingPlayer;
				if (num2 < num && !flag)
				{
					component.HoldPosition = false;
					component.FollowPlayer(true);
					flag = true;
				}
				if (flag)
				{
					num2++;
				}
			}
		}
	}

	private static void PlaceArmy()
	{
		CommandUnits instance = CommandUnits.instance;
		if (!((UnityEngine.Object)(object)instance == (UnityEngine.Object)null))
		{
			instance.PlaceCommandedUnitsAndCalculateTargetPositions(false);
			instance.MakeUnitsInBufferHoldPosition();
			instance.commanding = false;
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)"[bot] army placed at anchor, holding");
			}
		}
	}

	public static void RequestLoadout(string weapon)
	{
		requestedWeapon = weapon;
	}

	private static void SeedLoadout(in BotPerception.Snapshot s)
	{
		LevelInteractor nearestLevel = s.NearestLevel;
		PerkManager instance = PerkManager.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null || (UnityEngine.Object)(object)nearestLevel == (UnityEngine.Object)null || (UnityEngine.Object)(object)nearestLevel.levelInfo == (UnityEngine.Object)null)
		{
			return;
		}
		if (nearestLevel.levelInfo.fixedLoadout != null && nearestLevel.levelInfo.fixedLoadout.Count > 0)
		{
			instance.CurrentlyEquipped.Clear();
			instance.CurrentlyEquipped.AddRange(nearestLevel.levelInfo.fixedLoadout);
		}
		if (instance.CurrentlyEquipped.Count != 0)
		{
			return;
		}
		if (!string.IsNullOrEmpty(requestedWeapon))
		{
			Equippable val = null;
			foreach (Equippable allEquippable in instance.allEquippables)
			{
				if (allEquippable is EquippableWeapon && allEquippable.IsUnlocked && string.Equals(allEquippable.displayName, requestedWeapon, StringComparison.OrdinalIgnoreCase))
				{
					val = allEquippable;
					break;
				}
			}
			if ((UnityEngine.Object)(object)val != (UnityEngine.Object)null)
			{
				PerkManager.SetEquipped(val, true);
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)("[bot] loadout pinned by sidecar: '" + val.displayName + "'"));
				}
				requestedWeapon = null;
				return;
			}
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[bot] sidecar weapon '" + requestedWeapon + "' not found/locked — auto pick"));
			}
			requestedWeapon = null;
		}
		string[] array = new string[14]
		{
			"bow", "cross", "wand", "staff", "sling", "knife", "shuriken", "chakram", "javelin", "boomerang",
			"pistol", "rifle", "dart", "throw"
		};
		Equippable val2 = null;
		Equippable val3 = null;
		foreach (Equippable allEquippable2 in instance.allEquippables)
		{
			if (!(allEquippable2 is EquippableWeapon) || !allEquippable2.IsUnlocked)
			{
				continue;
			}
			if ((UnityEngine.Object)(object)val2 == (UnityEngine.Object)null || allEquippable2.sortingValue > val2.sortingValue)
			{
				val2 = allEquippable2;
			}
			string text = (allEquippable2.displayName ?? "").ToLowerInvariant();
			bool flag = false;
			string[] array2 = array;
			foreach (string value in array2)
			{
				if (text.Contains(value))
				{
					flag = true;
					break;
				}
			}
			if (flag && ((UnityEngine.Object)(object)val3 == (UnityEngine.Object)null || allEquippable2.sortingValue > val3.sortingValue))
			{
				val3 = allEquippable2;
			}
		}
		Equippable val4 = (((UnityEngine.Object)(object)val3 != (UnityEngine.Object)null) ? val3 : val2);
		if ((UnityEngine.Object)(object)val4 != (UnityEngine.Object)null)
		{
			PerkManager.SetEquipped(val4, true);
			ManualLogSource log3 = Plugin.Log;
			if (log3 != null)
			{
				log3.LogInfo((object)("[bot] loadout seeded: '" + val4.displayName + "'" + (((UnityEngine.Object)(object)val4 == (UnityEngine.Object)(object)val3) ? " (ranged preferred)" : "")));
			}
		}
	}

	/// <summary>act.v1 (src/Act.cs): drop the current target so the brain re-picks (retreat/avoid/forgive).</summary>
	internal static void ActClearTarget() { ClearTarget(); }

	private static void ClearTarget()
	{
		hasTarget = false;
		engageTarget = null;
		detourCount = 0;
		navWrongLayer = false;
		arriveSince = 0f;
		frontierLatch = false;
		ReleaseBuild("clear-target");
	}

	private static bool IsInterLatchedComplete(BuildingInteractor bi)
	{
		try
		{
			Type type = ((object)bi).GetType();
			while (type != null)
			{
				FieldInfo field = type.GetField("interactionComplete", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field != null)
				{
					return (bool)field.GetValue(bi);
				}
				type = type.BaseType;
			}
			return false;
		}
		catch
		{
			return false;
		}
	}

	private static void ReleaseBuild(string why = "")
	{
		if ((UnityEngine.Object)(object)heldBuild == (UnityEngine.Object)null)
		{
			return;
		}
		PlayerInteraction instance = PlayerInteraction.instance;
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)("[bot] hold-release '" + ((UnityEngine.Object)heldBuild).name + "' " + $"why={why} " + $"waitChoice={(UnityEngine.Object)(object)ChoiceManager.instance != (UnityEngine.Object)null && ChoiceManager.instance.ChoiceCoroutineRunning}"));
		}
		if (BotPerception.IsInteractorComplete(heldBuild))
		{
			string text = (((UnityEngine.Object)(object)heldBuild.targetBuilding != (UnityEngine.Object)null) ? heldBuild.targetBuilding.buildingName : ((UnityEngine.Object)heldBuild).name);
			if (!string.IsNullOrEmpty(text) && text != holdDoneName)
			{
				holdDoneName = text;
				string bdn = text;
				if (((UnityEngine.Object)(object)heldBuild.targetBuilding != (UnityEngine.Object)null) &&
				    heldBuild.targetBuilding.name.IndexOf("gate", StringComparison.OrdinalIgnoreCase) >= 0)
					bdn = text + "|gate";
				BotPerception.BuildDone(bdn, ((Component)heldBuild).transform.position);
			}
		}
		if ((UnityEngine.Object)(object)instance != (UnityEngine.Object)null)
		{
			((InteractorBase)heldBuild).Unfocus(instance);
			((InteractorBase)heldBuild).InteractionEnd(instance);
		}
		heldBuild = null;
		BotPerception.HeldBuildRef = null;
		holdDoneName = "";
	}

	// Ranked choice pick (was: first pickable, or any name containing a military
	// keyword — which grabbed "Guard House" over "Commander"). Army-first: unit
	// unlocks and command/control upgrades lead, defense and castle tiers next,
	// economy funds the machine, hero self-buffs last (the hero builds, the
	// army fights).
	private static int ChoiceRank(string n)
	{
		string t = n.ToLowerInvariant();
		if (t.Contains("commander") || t.Contains("command")) return 100;                    // hold-position control
		if (t.Contains("castle") || t.Contains("royal") || t.Contains("fortif")) return 85;  // Castle Up, Royal Mastery/Training
		if (t.Contains("barrack") || t.Contains("archer") || t.Contains("knight") || t.Contains("militia") ||
		    t.Contains("guard") || t.Contains("squad") || t.Contains("troop") || t.Contains("soldier") ||
		    t.Contains("rider") || t.Contains("spear") || t.Contains("crossbow") || t.Contains("longbow")) return 80;
		if (t.Contains("tower") || t.Contains("wall") || t.Contains("ballista") || t.Contains("defen") || t.Contains("barricade")) return 70;
		if (t.Contains("builder") || t.Contains("guild") || t.Contains("engineer") || t.Contains("mastery") || t.Contains("training")) return 60;
		if (t.Contains("income") || t.Contains("field") || t.Contains("house") || t.Contains("gold") || t.Contains("interest") ||
		    t.Contains("harvest") || t.Contains("tax") || t.Contains("farm") || t.Contains("market") || t.Contains("mine") ||
		    t.Contains("harbour") || t.Contains("harbor") || t.Contains("fish")) return 50;
		if (t.Contains("damage") || t.Contains("health") || t.Contains("armor") || t.Contains("regen") ||
		    t.Contains("speed") || t.Contains("weapon") || t.Contains("sword")) return 20;   // hero buffs last
		return 45;
	}

	private static int WeaponRank(string n)
	{
		string t = n.ToLowerInvariant();
		if (t.Contains("bow") || t.Contains("crossbow") || t.Contains("gun") || t.Contains("staff") || t.Contains("wand")) return 10;  // stay out of melee
		if (t.Contains("spear") || t.Contains("javelin") || t.Contains("lance")) return 6;
		if (t.Contains("sword") || t.Contains("axe") || t.Contains("hammer") || t.Contains("scythe") || t.Contains("dagger")) return 3;
		return 5;
	}

	private static int PerkRank(string n)
	{
		string t = n.ToLowerInvariant();
		if (t.Contains("interest") || t.Contains("income") || t.Contains("gold") || t.Contains("tax") || t.Contains("economy") || t.Contains("harvest")) return 10;
		if (t.Contains("tower") || t.Contains("wall") || t.Contains("defen") || t.Contains("ballista") || t.Contains("outpost")) return 9;
		if (t.Contains("unit") || t.Contains("soldier") || t.Contains("squad") || t.Contains("army") || t.Contains("respawn") || t.Contains("command") || t.Contains("last stand")) return 8;
		if (t.Contains("build") || t.Contains("cost") || t.Contains("repair") || t.Contains("engineer") || t.Contains("cheap") || t.Contains("upgrade")) return 7;
		if (t.Contains("hp") || t.Contains("health") || t.Contains("armor") || t.Contains("regen") || t.Contains("indestruct")) return 5;
		if (t.Contains("damage") || t.Contains("weapon") || t.Contains("attack") || t.Contains("speed") || t.Contains("knockback")) return 4;
		return 3;
	}

	private static bool HandleBlockingFrame(in BotPerception.Snapshot s)
	{
		UIFrameManager instance = UIFrameManager.instance;
		UIFrame val = (((UnityEngine.Object)(object)instance != (UnityEngine.Object)null) ? instance.ActiveFrame : null);
		uiFrame = (((UnityEngine.Object)(object)val != (UnityEngine.Object)null) ? ((UnityEngine.Object)val).name : "");
		ChoiceManager instance2 = ChoiceManager.instance;
		if ((UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && instance2.ChoiceCoroutineRunning)
		{
			if (choiceSince <= 0f)
			{
				choiceSince = Time.unscaledTime;
			}
		}
		else
		{
			choiceSince = 0f;
		}
		bool flag = choiceSince > 0f && Time.unscaledTime - choiceSince > 20f;
		// Choice coroutine stuck >20 s without resolving — the UI is frozen and
		// the generic close path will just bounce on an unresponsive frame.
		// Cancel the coroutine once and reset the watchdog.
		if (flag && (UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null)
		{
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 1f;
				Plugin.Log?.LogWarning("[bot] choice coroutine wedged >20 s -> CancelChoice()");
				instance2.CancelChoice();
				LogLine(in s, "choice-coroutine-wedge");
				choiceSince = 0f;
				choiceConfirmStreak = 0;
			}
			return true;
		}
		if ((UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && instance2.ChoiceCoroutineRunning && instance2.ChoiceCoroutineWaiting && !flag)
		{
			// Multi-tier slots re-present after EVERY pick — a 1 s throttle
			// leaves the frame up between picks (the "frozen popup"). Resolve
			// waits near-instantly; unresolvable lists cancel instead of
			// forever-assigning a doomed choice.
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 0.2f;
				Choice val2 = null;
				int bestRank = -1;
				foreach (Choice availableChoice in instance2.availableChoices)
				{
					if (availableChoice != null && availableChoice.CanBePicked)
					{
						int r = ChoiceRank(availableChoice.name ?? "");
						if (val2 == null || r > bestRank)
						{
							val2 = availableChoice;
							bestRank = r;
						}
					}
				}
				if (val2 == null)
				{
					Plugin.Log?.LogWarning("[bot] choice frame: nothing pickable -> CancelChoice()");
					instance2.CancelChoice();
					LogLine(in s, "choice-cancel-unpickable");
					choiceConfirmStreak = 0;
				}
				else
				{
					instance2.choiceToReturn = val2;
					ManualLogSource log = Plugin.Log;
					if (log != null)
					{
						log.LogInfo((object)("[bot] choice frame -> '" + ((instance2.choiceToReturn != null) ? instance2.choiceToReturn.name : "none") + "' rank=" + bestRank));
					}
					LogLine(in s, "choice-pick");
				}
			}
			return true;
		}
		if ((UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && instance2.ChoiceCoroutineRunning && !flag)
		{
			return true;
		}
		if ((UnityEngine.Object)(object)val == (UnityEngine.Object)null || !val.freezePlayer)
		{
			if (Time.unscaledTime - lastFrameAt > 3f)
			{
				lastFrameName = "";
				frameSeen = 0;
				frameCloseStreak = 0;
				choiceConfirmStreak = 0;
			}
			return false;
		}
		lastFrameAt = Time.unscaledTime;
		if (((UnityEngine.Object)val).name != lastFrameName)
		{
			lastFrameName = ((UnityEngine.Object)val).name;
			frameSeen = 0;
			// Escalation counters are per-frame — a choice frame closing into a
			// perk frame used to inherit the confirm streak and force-close the
			// new frame at streak>=2 (audit F8). frameCloseStreak persists on
			// purpose: it is the ping-pong breaker.
			choiceConfirmStreak = 0;
		}
		if ((UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null && instance2.ChoiceCoroutineRunning)
		{
			return true;
		}
		if (((UnityEngine.Object)val).name.IndexOf("Choice", StringComparison.OrdinalIgnoreCase) >= 0)
		{
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 1f;
				choiceConfirmStreak++;
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogInfo((object)"[bot] choice frame -> Apply() (confirm)");
				}
				val.Apply();
				LogLine(in s, "choice-confirm");
				// Escalation: the pick coroutine consumes choiceToReturn but the
				// UI frame outlives it — Apply() loops forever with the frozen
				// overlay on screen. 2+ confirms → CloseActiveFrame; 6+ →
				// CancelChoice unfreezes the player outright.
				if (choiceConfirmStreak >= 6 && (UnityEngine.Object)(object)instance2 != (UnityEngine.Object)null)
				{
					Plugin.Log?.LogWarning("[bot] choice frame stuck -> CancelChoice()");
					instance2.CancelChoice();
					LogLine(in s, "choice-cancel");
					choiceConfirmStreak = 0;
				}
				else if (choiceConfirmStreak >= 2)
				{
					instance.CloseActiveFrame();
					LogLine(in s, "choice-close");
				}
			}
			return true;
		}
		if ((UnityEngine.Object)(object)((Component)val).GetComponentInChildren<BackToLevelSelectHelper>(true) != (UnityEngine.Object)null && (val.canNotBeEscaped || (frameSeen >= 2 && (s.GameState.StartsWith("AfterMatch") || ((UnityEngine.Object)val).name.IndexOf("After Match") >= 0))))
		{
			frameSeen++;
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 2f;
				ManualLogSource log3 = Plugin.Log;
				if (log3 != null)
				{
					log3.LogInfo((object)"[bot] end-of-match -> Apply() (back-to-map)");
				}
				LogLine(in s, "match-end");
				val.Apply();
			}
			// Victory/defeat popups sometimes ignore Apply() and stay open
			// (observed: 40+ s stuck). Force a level-select transition after
			// the frame has been seen 5 times (~10 s of attempts).
			if (s.GameState != "InMatch" && frameSeen >= 5 &&
			    (UnityEngine.Object)(object)SceneTransitionManager.instance != (UnityEngine.Object)null)
			{
				frameSeen = 0; frameCloseStreak = 0;
				Plugin.Log?.LogWarning("[bot] match-end frame stuck -> forcing TransitionToLevelSelect()");
				LogLine(in s, "match-escape");
				SceneTransitionManager.instance.TransitionToLevelSelect();
			}
			return true;
		}
		PerkSelectionItem[] componentsInChildren = ((Component)val).GetComponentsInChildren<PerkSelectionItem>(true);
		if (componentsInChildren != null && componentsInChildren.Length != 0)
		{
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 1.5f;
				int num = 0;
				// Curated selection (was: equip EVERYTHING unlocked — mutations are
				// challenge modifiers that only make the run harder, and a full
				// weapon group pick churns the one weapon slot).
				var perkRanked = new List<KeyValuePair<int, PerkSelectionItem>>();
				var weaponByGroup = new Dictionary<PerkSelectionGroup, KeyValuePair<int, PerkSelectionItem>>();
				var weaponTaken = new HashSet<PerkSelectionGroup>();
				foreach (PerkSelectionItem pre in componentsInChildren)
				{
					PerkSelectionGroup pg = ((Component)pre).GetComponentInParent<PerkSelectionGroup>();
					if ((UnityEngine.Object)(object)pg != (UnityEngine.Object)null && pre.Selected &&
					    !((UnityEngine.Object)(object)pre.Equippable == (UnityEngine.Object)null) && pre.Equippable is EquippableWeapon)
						weaponTaken.Add(pg);              // the group already has its weapon
				}
				foreach (PerkSelectionItem val4 in componentsInChildren)
				{
					PerkSelectionGroup componentInParent = ((Component)val4).GetComponentInParent<PerkSelectionGroup>();
					if ((UnityEngine.Object)(object)componentInParent == (UnityEngine.Object)null || val4.Selected ||
					    (UnityEngine.Object)(object)val4.Equippable == (UnityEngine.Object)null || !val4.Equippable.IsUnlocked)
						continue;
					if (val4.Equippable is EquippableMutation)
						continue;                       // mutators add difficulty, not power
					if (val4.Equippable is EquippableWeapon)
					{
						if (weaponTaken.Contains(componentInParent)) continue;    // one weapon per group
						int wr = WeaponRank(val4.Equippable.name ?? "");
						if (!weaponByGroup.TryGetValue(componentInParent, out var cur) || wr > cur.Key)
							weaponByGroup[componentInParent] = new KeyValuePair<int, PerkSelectionItem>(wr, val4);
						continue;
					}
					perkRanked.Add(new KeyValuePair<int, PerkSelectionItem>(PerkRank(val4.Equippable.name ?? ""), val4));
				}
				foreach (var wg in weaponByGroup) { wg.Value.Value.GetComponentInParent<PerkSelectionGroup>().SelectPerk(wg.Value.Value); num++; weaponTaken.Add(wg.Key); }
				perkRanked.Sort((x, y) => y.Key.CompareTo(x.Key));
				for (int pi = 0; pi < perkRanked.Count && pi < 4; pi++)
				{
					perkRanked[pi].Value.GetComponentInParent<PerkSelectionGroup>().SelectPerk(perkRanked[pi].Value);
					num++;
				}
				ManualLogSource log4 = Plugin.Log;
				if (log4 != null)
				{
					log4.LogInfo((object)$"[bot] perk frame '{((UnityEngine.Object)val).name}' -> picked {num} item(s), closing");
				}
				LogLine(in s, "perk-pick");
				if (!val.canNotBeEscaped)
				{
					instance.CloseActiveFrame();
				}
				else
				{
					val.Apply();
				}
			}
			return true;
		}
		// The Level Select frame is the CORRECT frame during EnterLevel —
		// busyHung opened it precisely so its Start button gets clicked.
		// Apply() IS that button; the generic closer used to shut it before
		// Start ever fired -> open/close loop, level never entered.
		if (Mode == BotMode.EnterLevel && (UnityEngine.Object)(object)val != (UnityEngine.Object)null &&
		    ((UnityEngine.Object)val).name.IndexOf("Level Select", StringComparison.OrdinalIgnoreCase) >= 0)
		{
			if (Time.unscaledTime >= frameActionAt)
			{
				frameActionAt = Time.unscaledTime + 2f;
				val.Apply();
				LogLine(in s, "level-start-click");
			}
			return true;
		}
		if (Time.unscaledTime >= frameActionAt)
		{
			frameActionAt = Time.unscaledTime + 2f;
			frameSeen++;
			ManualLogSource log5 = Plugin.Log;
			if (log5 != null)
			{
				log5.LogInfo((object)("[bot] blocking frame '" + ((UnityEngine.Object)val).name + "' -> close"));
			}
			LogLine(in s, "frame-close");
			if (!val.canNotBeEscaped)
			{
				instance.CloseActiveFrame();
			}
			else
			{
				val.Apply();
			}
			// Ping-pong breaker: after-match + level-up frames re-open each
			// other forever (observed: 40+ s of alternating closes). If we're
			// still closing frames 5+ times in a row while OUT of a match,
			// skip the frame stack entirely and hard-transition to the map.
			if (s.GameState != "InMatch" && ++frameCloseStreak >= 5 &&
			    (UnityEngine.Object)(object)SceneTransitionManager.instance != (UnityEngine.Object)null)
			{
				frameCloseStreak = 0;
				Plugin.Log?.LogWarning("[bot] frame ping-pong -> forcing TransitionToLevelSelect()");
				LogLine(in s, "frame-escape");
				SceneTransitionManager.instance.TransitionToLevelSelect();
			}
		}
		return true;
	}

	private static CutOpenPathInteractor heldGate;
	private static float heldGateAt;

	/// <summary>Classify what the hero is pinned on: nearest collider ~1.6 m
	/// ahead toward the aim. Returns a short tag ("pen:Barracks", "gate",
	/// "wall", "terrain:Rock", "enemy", "obj:<name>") or null if nothing
	/// recognizable — runs only on stuck strikes so the sphere is cheap.</summary>
	private static readonly Collider[] repBuf = new Collider[16];

	/// <summary>Steering-time obstacle repulsion: one overlap probe per tick
	/// pushes the desired direction off any collider inside heroRadius+clearance.
	/// Excludes the hero himself, the held build (must touch to pay) and the
	/// engage target (must close). Ally units count — they wedge him too —
	/// the push lets him slide around them.</summary>
	private static Vector3 ObstacleRepulse(Vector3 hero, Vector3 dir)
	{
		try
		{
			int n = Physics.OverlapSphereNonAlloc(hero + Vector3.up * 0.5f, 1.0f, repBuf,
				~0, QueryTriggerInteraction.Ignore);
			Vector3 push = Vector3.zero;
			for (int i = 0; i < n; i++)
			{
				var c = repBuf[i];
				if ((UnityEngine.Object)(object)c == (UnityEngine.Object)null) continue;
				var go = c.gameObject;
				var tg = go.GetComponentInParent<TaggedObject>();
				if (tg != null && tg.Contains(TagManager.ETag.Player)) continue;      // self
				// Followers trail by design — repulsing off them was the
				// visible "jitter" (hero wobbles while his escort crowds him).
				if (tg != null && tg.Contains(TagManager.ETag.PlayerOwned))
				{
					var pu = go.GetComponentInParent<PathfindMovementPlayerunit>();
					if ((UnityEngine.Object)(object)pu != (UnityEngine.Object)null && pu.FollowingPlayer)
						continue;
				}
				if ((UnityEngine.Object)(object)heldBuild != (UnityEngine.Object)null &&
				    c.transform.IsChildOf(((Component)heldBuild).transform)) continue;
				if (Mode == BotMode.Engage && (UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null &&
				    c.transform.IsChildOf(((Component)engageTarget).transform)) continue;
				Vector3 cp = c.ClosestPoint(hero); cp.y = hero.y;
				Vector3 away = hero - cp; float d = away.magnitude;
				const float margin = 0.7f;
				if (d < margin && d > 0.001f)
					push += away.normalized * ((margin - d) / margin);
			}
			if (push.sqrMagnitude < 0.001f) return dir;
			Vector3 r = dir + push * 1.5f;
			r.y = 0f;
			return r.sqrMagnitude > 0.01f ? r.normalized : dir;
		}
		catch { return dir; }
	}

	private static string PinProbe(Vector3 hero, Vector3 aim)
	{
		try
		{
			Vector3 dir = aim - hero; dir.y = 0f;
			if (dir.sqrMagnitude < 0.01f) dir = Vector3.forward; else dir.Normalize();
			var hits = Physics.OverlapSphere(hero + dir * 1.6f + Vector3.up * 0.5f, 1.4f);
			string best = null; float bd = float.MaxValue;
			foreach (var c in hits)
			{
				if ((UnityEngine.Object)(object)c == (UnityEngine.Object)null) continue;
				var go = c.gameObject;
				if (c.isTrigger) continue;   // cosmetic/trigger volumes can't pin
				var tg = go.GetComponentInParent<TaggedObject>();
				if (tg != null && tg.Contains(TagManager.ETag.Player)) continue;
				var bi = go.GetComponentInParent<BuildingInteractor>();
				string cls;
				if (bi != null)
					cls = "pen:" + (bi.targetBuilding != null ? bi.targetBuilding.buildingName : bi.name) +
					      (bi.CanBeInteractedWith ? "(upgradeable)" : "");
				else if ((UnityEngine.Object)(object)go.GetComponentInParent<GateOpener>() != (UnityEngine.Object)null) cls = "gate";
				else if (tg != null && tg.Contains(TagManager.ETag.EnemyOwned)) cls = "enemy";
				// Friendly unit: ALLY wedges classified as obj:<unit> and the
				// stand-pocket branch parked the build SLOT for it — a unit
				// bump aborting real work (audit finding C).
				else if (tg != null && tg.Contains(TagManager.ETag.PlayerOwned)) cls = "unit";
				else
				{
					string n = (go.name ?? "").ToLowerInvariant();
					if (n.Contains("wall")) cls = "wall";
					else if (n.Contains("rock") || n.Contains("stone") || n.Contains("boulder") ||
					         n.Contains("mountain") || n.Contains("cliff") || n.Contains("ore")) cls = "terrain:" + go.name;
					else if (n.Contains("tree") || n.Contains("stump") || n.Contains("bush")) cls = "terrain:" + go.name;
					else if (n.Contains("water") || n.Contains("river") || n.Contains("lake")) cls = "terrain:" + go.name;
					else if (n.Contains("path") || n.Contains("decal") || n.Contains("road") ||
					         n.Contains("grass") || n.Contains("fx") || n.Contains("particle") ||
					         n.Contains("parent") || n.Contains("container") || n.Contains("holder") ||
					         n.Contains("group") || n.Contains("root") ||
					         n.Contains("damage collider") || n.Contains("projectile collider"))
						continue;   // decorative art AND container transforms can't pin —
					            // "Alive Parent" misclassified a grouping node as a blocker
					else cls = "obj:" + go.name;
				}
				float d = (go.transform.position - hero).sqrMagnitude;
				if (d < bd) { bd = d; best = cls; Act.LastPinCol = c; }
			}
			return best;
		}
		catch { return null; }
	}

	private static Vector3 ChooseDetour(in BotPerception.Snapshot s, Vector3 toAim, Vector3 fallback)
	{
		if ((UnityEngine.Object)(object)AstarPath.active == (UnityEngine.Object)null) return fallback;
		Vector3 best = fallback; float bestScore = float.NegativeInfinity;
		if (!SpatialMemory.Hot(s.SceneName, fallback)) bestScore = 0f;
		for (int i = 0; i < 8; i++)
		{
			float ang = i * (Mathf.PI / 4f);
			Vector3 dir = new Vector3(Mathf.Cos(ang), 0f, Mathf.Sin(ang));
			float rad = 3f + 1.5f * Mathf.Min(detourCount, 4);
			Vector3 cand = s.HeroPos + dir * rad;
			Vector3 snapped = AstarPath.active.GetNearest(cand, new NNConstraint()).position;
			if ((snapped - cand).magnitude > 1.5f) continue;   // not really walkable there
			if (SpatialMemory.Hot(s.SceneName, snapped)) continue;
			float forward = toAim.sqrMagnitude > 0.01f ? Vector3.Dot(dir, toAim.normalized) : 0f;
			float sc = forward * 2f - SpatialMemory.ScoreAt(s.SceneName, snapped);
			if (sc > bestScore) { bestScore = sc; best = snapped; }
		}
		return best;
	}

	internal static void ReleaseGate(string why)
	{
		var pi = PlayerInteraction.instance;
		if ((UnityEngine.Object)(object)heldGate != (UnityEngine.Object)null && (UnityEngine.Object)(object)pi != (UnityEngine.Object)null)
		{
			try { heldGate.InteractionEnd(pi); } catch { }
			Plugin.Log?.LogInfo("[bot] gate released (" + why + ")");
		}
		heldGate = null;
	}
	private static readonly System.Reflection.FieldInfo GateOpenedField =
		typeof(CutOpenPathInteractor).GetField("pathOpened",
			System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);

	private static void GateHold(in BotPerception.Snapshot s)
	{
		var pad = s.NearestGate;
		var pi = PlayerInteraction.instance;
		if ((UnityEngine.Object)(object)pad == (UnityEngine.Object)null ||
		    (UnityEngine.Object)(object)pi == (UnityEngine.Object)null) return;
		if ((UnityEngine.Object)(object)heldGate != (UnityEngine.Object)pad)
		{
			ReleaseGate("switch");
			heldGate = pad;
			heldGateAt = Time.unscaledTime;
			pad.InteractionBegin(pi);
			LogLine(in s, "gate-begin");
		}
		pad.InteractionHold(pi);
		// Done when the path opens or the pad stops being interactable.
		bool open = false;
		try { if (GateOpenedField != null)
			open = (bool)GateOpenedField.GetValue(pad); } catch { }
		if (open || !pad.CanBeInteractedWith || Time.unscaledTime - heldGateAt > 15f)
		{
			pad.InteractionEnd(pi);
			Plugin.Log?.LogInfo("[bot] gate pad " +
				(open ? "OPENED" : "abandoned") + " '" + ((UnityEngine.Object)pad).name + "'");
			LogLine(in s, open ? "gate-open" : "gate-abandon");
			heldGate = null;
		}
	}

	private static void DiagLog(string key, string msg, bool warn)
	{
		if (key == lastDiagKey && Time.unscaledTime < attackDiagAt)
		{
			return;
		}
		lastDiagKey = key;
		attackDiagAt = Time.unscaledTime + 15f;
		if (warn)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)msg);
			}
		}
		else
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogInfo((object)msg);
			}
		}
	}

	private static void PumpAttack()
	{
		//IL_0497: Unknown result type (might be due to invalid IL or missing references)
		//IL_04a6: Unknown result type (might be due to invalid IL or missing references)
		PlayerMovement instance = PlayerMovement.instance;
		if ((UnityEngine.Object)(object)instance == (UnityEngine.Object)null)
		{
			return;
		}
		if ((UnityEngine.Object)(object)heroAttack == (UnityEngine.Object)null)
		{
			TaggedObject componentInParent = ((Component)instance).GetComponentInParent<TaggedObject>();
			WeaponEquipper val = (((UnityEngine.Object)(object)componentInParent != (UnityEngine.Object)null) ? ((Component)componentInParent).GetComponentInChildren<WeaponEquipper>(true) : UnityEngine.Object.FindObjectOfType<WeaponEquipper>());
			if ((UnityEngine.Object)(object)val != (UnityEngine.Object)null)
			{
				heroAttack = (((UnityEngine.Object)(object)val.activeWeapon != (UnityEngine.Object)null) ? val.activeWeapon : val.passiveWeapon);
			}
			if ((UnityEngine.Object)(object)heroAttack == (UnityEngine.Object)null && (UnityEngine.Object)(object)componentInParent != (UnityEngine.Object)null)
			{
				heroAttack = ((Component)componentInParent).GetComponentInChildren<ManualAttack>(true);
			}
			if ((UnityEngine.Object)(object)heroAttack == (UnityEngine.Object)null && Time.unscaledTime >= maScanAt)
			{
				maScanAt = Time.unscaledTime + 1f;
				ManualAttack[] array = UnityEngine.Object.FindObjectsOfType<ManualAttack>(true);
				ManualAttack[] array2 = array;
				foreach (ManualAttack val2 in array2)
				{
					TaggedObject componentInParent2 = ((Component)val2).GetComponentInParent<TaggedObject>();
					if ((UnityEngine.Object)(object)componentInParent2 != (UnityEngine.Object)null && componentInParent2.Contains((TagManager.ETag)2))
					{
						heroAttack = val2;
						break;
					}
				}
				if ((UnityEngine.Object)(object)heroAttack == (UnityEngine.Object)null)
				{
					string text = "";
					for (int j = 0; j < array.Length && j < 6; j++)
					{
						text = text + ((j > 0) ? "," : "") + ((UnityEngine.Object)array[j]).name;
					}
					WeaponEquipper[] array3 = UnityEngine.Object.FindObjectsOfType<WeaponEquipper>(true);
					int num = (((UnityEngine.Object)(object)PerkManager.instance != (UnityEngine.Object)null) ? PerkManager.instance.CurrentlyEquipped.Count : (-1));
					DiagLog("no-manual-attack", $"[bot] no player ManualAttack: scene has {array.Length} [{text}], {array3.Length} WeaponEquipper, {num} equipped perks", warn: true);
				}
			}
			if ((UnityEngine.Object)(object)heroAttack != (UnityEngine.Object)null)
			{
				weaponRange = 0f;
				foreach (TargetPriority targetPriority in heroAttack.targetPriorities)
				{
					weaponRange = Mathf.Max(weaponRange, targetPriority.range);
				}
				weaponFiresWhileMoving = (UnityEngine.Object)(object)((Component)heroAttack).GetComponent<DelayManualAttackWhileMoving>() == (UnityEngine.Object)null;
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)$"[bot] ManualAttack found on '{((UnityEngine.Object)heroAttack).name}' (autoAttack={heroAttack.autoAttack}, range={weaponRange:0.#}, firesWhileMoving={weaponFiresWhileMoving})");
				}
			}
		}
		else if (Time.unscaledTime >= weRevalAt)
		{
			weRevalAt = Time.unscaledTime + 2f;
			TaggedObject componentInParent3 = ((Component)instance).GetComponentInParent<TaggedObject>();
			WeaponEquipper val3 = (((UnityEngine.Object)(object)componentInParent3 != (UnityEngine.Object)null) ? ((Component)componentInParent3).GetComponentInChildren<WeaponEquipper>(true) : UnityEngine.Object.FindObjectOfType<WeaponEquipper>());
			ManualAttack val4;
			if ((UnityEngine.Object)(object)val3 != (UnityEngine.Object)null)
			{
				val4 = (((UnityEngine.Object)(object)val3.activeWeapon != (UnityEngine.Object)null) ? val3.activeWeapon : val3.passiveWeapon);
			}
			else
			{
				val4 = null;
			}
			if ((UnityEngine.Object)(object)val4 != (UnityEngine.Object)null && (UnityEngine.Object)(object)val4 != (UnityEngine.Object)(object)heroAttack)
			{
				heroAttack = val4;
				weaponRange = 0f;
				foreach (TargetPriority targetPriority2 in val4.targetPriorities)
				{
					weaponRange = Mathf.Max(weaponRange, targetPriority2.range);
				}
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogInfo((object)$"[bot] ManualAttack re-resolved -> '{((UnityEngine.Object)val4).name}' (range={weaponRange:0.#})");
				}
			}
		}
		if ((UnityEngine.Object)(object)heroAttack == (UnityEngine.Object)null)
		{
			if (!Legit)
			{
				Hp val5 = (((UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null) ? ((Component)engageTarget).GetComponent<Hp>() : null);
				if ((UnityEngine.Object)(object)val5 != (UnityEngine.Object)null)
				{
					TaggedObject componentInParent4 = ((Component)instance).GetComponentInParent<TaggedObject>();
					val5.TakeDamage(500f, componentInParent4, true, true);
				}
				else
				{
					DiagLog("weaponless:" + (((UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null) ? ((UnityEngine.Object)engageTarget).name : "null"), "[bot] engage: weaponless, enemy hp missing (engageTarget=" + (((UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null) ? ((UnityEngine.Object)engageTarget).name : "null") + ")", warn: true);
				}
			}
			return;
		}
		TaggedObject val6 = null;
		try
		{
			val6 = heroAttack.FindAttackTarget(true);
		}
		catch
		{
		}
		float num2 = (((UnityEngine.Object)(object)engageTarget != (UnityEngine.Object)null) ? FlatDist(((Component)instance).transform.position, ((Component)engageTarget).transform.position) : (-1f));
		DiagLog("wt:" + (((UnityEngine.Object)(object)val6 != (UnityEngine.Object)null) ? ((UnityEngine.Object)val6).name : "null"), string.Format("[bot] engage diag: weaponTarget={0} pursueDist={1:0.0}", ((UnityEngine.Object)(object)val6 != (UnityEngine.Object)null) ? ((UnityEngine.Object)val6).name : "null", num2), warn: false);
		if ((UnityEngine.Object)(object)val6 != (UnityEngine.Object)null)
		{
			if (Legit)
			{
				heroAttack.TryToAttack();
			}
			else
			{
				heroAttack.Attack();
			}
		}
		else
		{
			heroAttack.TryToAttack();
		}
	}

	private static Vector3 DirTo(Vector3 from, Vector3 to, float arrive)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = to - from;
		val.y = 0f;
		if (val.magnitude <= arrive)
		{
			return Vector3.zero;
		}
		return val.normalized;
	}

	private static Vector3 StandOff(Vector3 target, Vector3 hero, float radius)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = hero - target;
		val.y = 0f;
		if (val.magnitude <= radius)
		{
			return target;
		}
		return target + val.normalized * radius;
	}

	private static int gpsLegPrev;

	/// <summary>GPS wrapper: when the goal lies behind a closed wall gate, steer at the near / far side of the gate that leads there (see Gates.cs).</summary>
	private static Vector3 NavSteerPoint(Vector3 hero, Vector3 goal)
	{
		Vector3 gpsGoal = Gates.Redirect(hero, goal);
		int gpsLeg = Gates.LegKey;
		if (gpsLeg != gpsLegPrev)
		{
			// a gate leg started / changed / ended: the stored path leads to the previous steering point, drop it (same reset as a new match)
			gpsLegPrev = gpsLeg;
			navPath = null;
			navIndex = 0;
			navGoal = Vector3.zero;
			navWrongLayer = false;
			navInFlight = false;
			navRepathAt = 0f;
			navRequestId++;
			frontierLatch = false;
		}
		if (Gates.Active && Gates.Direct)
		{
			navDirectUntil = Time.unscaledTime + 0.35f;   // push through the opening in a straight line: the pathfinder still sees the gate as closed
		}
		Vector3 steer = NavSteerPointCore(hero, gpsGoal);
		if (Gates.Active)
		{
			navSteerArrive = Gates.Arrive;
		}
		return steer;
	}

	private static Vector3 NavSteerPointCore(Vector3 hero, Vector3 goal)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_013f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_0184: Unknown result type (might be due to invalid IL or missing references)
		//IL_0189: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0154: Unknown result type (might be due to invalid IL or missing references)
		//IL_0163: Unknown result type (might be due to invalid IL or missing references)
		//IL_01df: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
		navSteerArrive = arriveDist;
		if (frontierLatch && FlatDist(goal, frontierLatchGoal) > 4f)
		{
			frontierLatch = false;
		}
		if (frontierLatch)
		{
			navSteerArrive = 0.5f;
			return goal;
		}
		if (Legit && Time.unscaledTime < detourUntil)
		{
			navSteerArrive = 0.5f;
		}
		if (Time.unscaledTime < navDirectUntil)
		{
			return goal;
		}
		if (hasTarget)
		{
			MaybeRequestPath(hero, goal);
		}
		Pathfinding.Path val = navPath;
		if (val == null || val.vectorPath == null || val.vectorPath.Count == 0)
		{
			return goal;
		}
		List<Vector3> vectorPath = val.vectorPath;
		if (vectorPath.Count > 0 && FlatDist(hero, vectorPath[0]) > 15f)
		{
			navPath = null;
			navIndex = 0;
			navGoal = Vector3.zero;
			navWrongLayer = false;
			return goal;
		}
		while (navIndex < vectorPath.Count - 1 && FlatDist(hero, vectorPath[navIndex]) < 1.4f)
		{
			navIndex++;
		}
		navIndex = Mathf.Min(navIndex, vectorPath.Count - 1);
		Vector3 val2 = vectorPath[vectorPath.Count - 1];
		if (navIndex == vectorPath.Count - 1 && FlatDist(hero, val2) < 0.8f)
		{
			frontierLatch = true;
			frontierLatchGoal = goal;
			navSteerArrive = 0.5f;
			return goal;
		}
		float num;
		if (navIndex != vectorPath.Count - 1)
		{
			num = 0.5f;
		}
		else
		{
			num = ((FlatDist(vectorPath[vectorPath.Count - 1], goal) > 2.5f) ? 0.5f : arriveDist);
		}
		navSteerArrive = num;
		if (Legit && Time.unscaledTime < detourUntil)
		{
			navSteerArrive = 0.5f;
		}
		if (navIndex < vectorPath.Count - 1)
		{
			return vectorPath[navIndex];
		}
		return val2;
	}

	private static void MaybeRequestPath(Vector3 hero, Vector3 goal)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Expected Obj, but got Unknown
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_008f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		if ((UnityEngine.Object)(object)AstarPath.active == (UnityEngine.Object)null || navInFlight || Time.unscaledTime < navRepathAt)
		{
			return;
		}
		bool flag = false;
		if (navPath != null && navPath.vectorPath != null && navPath.vectorPath.Count > 0)
		{
			Vector3 b = navPath.vectorPath[navPath.vectorPath.Count - 1];
			flag = navIndex >= navPath.vectorPath.Count - 1 && FlatDist(hero, b) < 1.4f;
		}
		bool flag2 = FlatDist(goal, navGoal) > 2.5f;
		if (navPath != null && !flag && !flag2)
		{
			return;
		}
		navRepathAt = Time.unscaledTime + 1.1f;
		// Pre-check: if the goal snaps far off the walkable graph (map-edge
		// pins, trigger colliders) the path will error and spam the log —
		// skip it and log once per coarse goal instead.
		var nn = AstarPath.active.GetNearest(goal, NNConstraint.Walkable);
		// nn.node is an A* GraphNode (plain class, NOT UnityEngine.Object) —
		// the (UnityEngine.Object)(object) cast threw InvalidCastException on
		// EVERY call, killing every nav request: the hero steered blind and
		// pinned on geometry all day. Plain null check fixes the whole nav layer.
		if (nn.node == null || FlatDist(goal, nn.position) > 4f)
		{
			Gates.NoteNavFail(goal);
			int gx = (int)(goal.x / 8f), gz = (int)(goal.z / 8f);
			long gkey = ((long)gx << 20) | (uint)(gz & 0xFFFFF);
			if (navNoPathLogAt.TryGetValue(gkey, out float lp) && Time.unscaledTime - lp < 60f)
				return;
			navNoPathLogAt[gkey] = Time.unscaledTime;
			Plugin.Log?.LogWarning($"[bot] nav-goal off-mesh -> {goal} (skipped path request)");
			return;
		}
		navGoal = goal;
		navInFlight = true;
		int reqId = ++navRequestId;
		AstarPath.StartPath((Pathfinding.Path)(object)ABPath.Construct(hero, goal, (OnPathDelegate)((Pathfinding.Path done) =>
		{
			//IL_0102: Unknown result type (might be due to invalid IL or missing references)
			//IL_004e: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
			navInFlight = false;
			if (reqId == navRequestId)
			{
				if (!done.error && done.vectorPath != null && done.vectorPath.Count > 0)
				{
					navWrongLayer = Mathf.Abs(done.vectorPath[done.vectorPath.Count - 1].y - goal.y) > 2.5f;
					navPath = done;
					navIndex = 0;
					navDiagCount++;
					if (navDiagCount <= 20)
					{
						ManualLogSource log = Plugin.Log;
						if (log != null)
						{
							log.LogInfo((object)($"[bot] nav-path ok: {done.vectorPath.Count} wp -> {goal}" + (navWrongLayer ? " [wrong-layer]" : "")));
						}
					}
				}
				else
				{
					navPath = null;
					navWrongLayer = false;
					Gates.NoteNavFail(goal);   // GPS: the pathfinder cannot reach this goal from here (cut off by walls / closed gates)
					ManualLogSource log2 = Plugin.Log;
					if (log2 != null)
					{
						log2.LogWarning((object)$"[bot] nav-path error -> {goal} ({done.errorLog})");
					}
				}
			}
		})), false, false);
	}

	private static bool SceneTransitionBusy(SceneTransitionManager stm)
	{
		if (StmRunningField != null)
		{
			return (bool)StmRunningField.GetValue(stm);
		}
		return false;
	}

	private static float FlatDist(Vector3 a, Vector3 b)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		a.y = 0f;
		b.y = 0f;
		return Vector3.Distance(a, b);
	}

	private static string FormatStatus(in BotPerception.Snapshot s)
	{
		return string.Format(CultureInfo.InvariantCulture, "{0} | wv {1}/{2} foes {3} coins {4} gold {5} hp {6:P0}", Mode, s.Wave, s.WaveTotal, s.EnemyCount, s.CoinCount, s.Balance, s.HeroHpPct);
	}

	private static void EnsureLog()
	{
		if (botLog != null || logFailed)
		{
			return;
		}
		try
		{
			botLog = new StreamWriter(System.IO.Path.Combine(Paths.PluginPath, "bot-log.jsonl"), append: true)
			{
				AutoFlush = true
			};
		}
		catch
		{
			logFailed = true;
		}
	}

	private static void CloseLog()
	{
		try
		{
			botLog?.Close();
		}
		catch
		{
		}
		botLog = null;
	}

	private static void LogRaw(string note)
	{
		EnsureLog();
		try
		{
			botLog?.WriteLine(string.Format(CultureInfo.InvariantCulture, "{{\"t\":{0:0.00},\"note\":\"{1}\"}}", Time.unscaledTime, note));
		}
		catch
		{
		}
	}

	private static string FormatTickJson(in BotPerception.Snapshot s, string note)
	{
		return string.Format(CultureInfo.InvariantCulture, "{{\"t\":{0:0.00},\"mode\":{1},\"state\":{2},\"scene\":{3},\"night\":{4},\"wave\":\"{5}/{6}\",\"foes\":{7},\"coins\":{8},\"gold\":{9},\"hp\":{10:0.###},\"hpPct\":{22:0},\"pos\":[{11:0.#},{12:0.#}],\"ls\":{13},\"lvln\":{14},\"inter\":{15},\"lvld\":{16:0.#},\"horn\":{17},\"hd\":{18:0.#},\"bld\":{19},\"nf\":{20},\"note\":{21},\"nav\":{23}}}", Time.unscaledTime, BotPerception.JsonStr(Mode.ToString()), BotPerception.JsonStr(s.GameState), BotPerception.JsonStr(s.SceneName), s.IsNight ? "true" : "false", s.Wave, s.WaveTotal, s.EnemyCount, s.CoinCount, s.Balance, s.HeroHpPct, s.HeroPos.x, s.HeroPos.z, s.OnLevelSelect ? "true" : "false", s.LevelCount, s.InteractorCount, s.NearestLevelDist, s.HasHorn ? "true" : "false", s.HornDist, s.BuildCount, s.EnemiesNearHero, BotPerception.JsonStr(note), (int)(s.HeroHpPct * 100f), BotPerception.JsonStr(Gates.Status ?? ""));
	}

	internal static void LogLine(in BotPerception.Snapshot s, string note)
	{
		EnsureLog();
		if (note != "tick" && (!(note == lastEvtNote) || !(Time.unscaledTime - lastEvtAt < 4f)))
		{
			Recorder.Event(note);
			lastEvtNote = note;
			lastEvtAt = Time.unscaledTime;
		}
		if (note == "snap")
		{
			Recorder.CountSnap();
			Recorder.NoteAnchor(s.SceneName, s.HeroPos.x, s.HeroPos.z, "wedge");
		}
		else if (note.StartsWith("unstick"))
		{
			Recorder.CountUnstick();
		}
		else
		{
			switch (note)
			{
			case "build-stall":
			case "coin-stall":
			case "aim-stall":
			case "build-unreachable":
				Recorder.CountStall();
				break;
			}
		}
		if (botLog == null)
		{
			return;
		}
		try
		{
			botLog.WriteLine(FormatTickJson(in s, note));
		}
		catch
		{
		}
	}
}
