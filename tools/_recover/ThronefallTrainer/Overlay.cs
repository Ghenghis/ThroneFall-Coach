using System;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal sealed class Overlay : MonoBehaviour
{
	public static bool Visible;

	private Rect win = new Rect(14f, 14f, 340f, 460f);

	private int page;

	private Vector2 scroll;

	private string book = "";

	private string bookScene = "";

	private float refAt;

	private string body = "";

	private GUIStyle big;

	private GUIStyle small;

	private GUIStyle dim;

	private GUIStyle green;

	private GUIStyle red;

	private void Update()
	{
		if (Input.GetKeyDown((KeyCode)289))
		{
			Visible = !Visible;
		}
	}

	private void OnGUI()
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Expected Obj, but got Unknown
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		if (!Visible)
		{
			return;
		}
		try
		{
			if (big == null)
			{
				Styles();
			}
			win = GUI.Window(54299, win, (WindowFunction)Draw, "Grandmaster  [F8]");
		}
		catch (Exception arg)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogError((object)$"[overlay] OnGUI failed — disabled: {arg}");
			}
			Visible = false;
		}
	}

	private void Styles()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Expected Obj, but got Unknown
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Expected Obj, but got Unknown
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Expected Obj, but got Unknown
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Expected Obj, but got Unknown
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Expected Obj, but got Unknown
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		big = new GUIStyle(GUI.skin.label)
		{
			fontSize = 15,
			fontStyle = (FontStyle)1,
			richText = true
		};
		small = new GUIStyle(GUI.skin.label)
		{
			fontSize = 11,
			wordWrap = true,
			richText = true
		};
		dim = new GUIStyle(GUI.skin.label)
		{
			fontSize = 11,
			wordWrap = true,
			richText = true
		};
		dim.normal.textColor = new Color(0.7f, 0.75f, 0.85f);
		green = new GUIStyle(GUI.skin.label)
		{
			fontSize = 11,
			wordWrap = true,
			richText = true
		};
		green.normal.textColor = new Color(0.5f, 1f, 0.5f);
		red = new GUIStyle(GUI.skin.label)
		{
			fontSize = 11,
			wordWrap = true,
			richText = true
		};
		red.normal.textColor = new Color(1f, 0.55f, 0.45f);
	}

	private void Draw(int id)
	{
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		GUILayout.BeginHorizontal(Array.Empty<GUILayoutOption>());
		if (GUILayout.Toggle(page == 0, " STATUS ", GUI.skin.button, Array.Empty<GUILayoutOption>()))
		{
			page = 0;
		}
		if (GUILayout.Toggle(page == 1, " LEARN ", GUI.skin.button, Array.Empty<GUILayoutOption>()))
		{
			page = 1;
		}
		if (GUILayout.Toggle(page == 2, " PLAYBOOK ", GUI.skin.button, Array.Empty<GUILayoutOption>()))
		{
			page = 2;
		}
		GUILayout.EndHorizontal();
		if (Time.unscaledTime > refAt)
		{
			refAt = Time.unscaledTime + 0.25f;
			Refresh();
		}
		scroll = GUILayout.BeginScrollView(scroll, Array.Empty<GUILayoutOption>());
		GUILayout.Label(body, (page == 2) ? small : dim, Array.Empty<GUILayoutOption>());
		GUILayout.EndScrollView();
		GUI.DragWindow();
	}

	private void Refresh()
	{
		BotPerception.Snapshot s = BotPerception.Last;
		if (!BotPerception.LastValid)
		{
			body = "waiting for first tick...";
		}
		else if (page == 0)
		{
			body = PageStatus(in s);
		}
		else if (page == 1)
		{
			body = PageLearn();
		}
		else
		{
			body = PageBook(s.SceneName ?? "");
		}
	}

	private string PageStatus(in BotPerception.Snapshot s)
	{
		string text = (s.IsNight ? "NIGHT" : "day");
		return $"<b>{s.SceneName}</b>  wave {s.Wave}/{s.WaveTotal}  {text}\n" + $"mode <b>{Bot.Mode}</b>   hp {s.HeroHpPct * 100f:0}%  " + "castle " + ((s.CastleHpPct >= 0f) ? ((s.CastleHpPct * 100f).ToString("0") + "%") : "?") + "\n" + $"gold {s.Balance}   allies <b>{s.AllyCount}</b>/{s.ArmyTarget}" + $"   free {s.FreeUnits}   foes {s.EnemyCount}\n" + $"doors covered <b>{s.DoorsCovered}</b>/{s.DoorCount}" + (s.RedAlert ? "   <color=#ff5544>RED ALERT</color>\n" : "\n") + (s.HasUncoveredDoor ? $"uncovered: {s.UncoveredDoorLine} (x{s.UncoveredDoorTarget})\n" : "all posts manned\n") + ((Coach.HeroPosture == "fighter") ? "posture: FIGHTER\n" : "posture: builder (army fights)\n") + ((Coach.BuildFocus != "") ? ("coach focus: " + Coach.BuildFocus + "\n") : "") + (Coach.Busy ? "coach thinking...\n" : "");
	}

	private string PageLearn()
	{
		string text = (NetPolicy.Loaded ? ($"neural shadow: {NetPolicy.Agree} agree / {NetPolicy.Disagree} disagree" + $" ({NetPolicy.Ratio * 100f:0}%)\n") : "neural net: no weights yet\n");
		return $"RL Q-table: {Policy.States} states, {Policy.Cells} cells\n" + $"decisions {Policy.Decisions}, updates {Policy.Updates}, " + $"epsilon {Policy.Epsilon:0.##}\n" + text + $"memory: {Memory.Count} mishaps never retried\n" + "playbook: " + BotPerception.StrategySummary() + "\n" + $"coach calls {Coach.CallsMade}, tokens {Coach.TokensUsed}\n" + ((Coach.LastAdvice != "") ? ("\nlast advice:\n" + Coach.LastAdvice + "\n") : "");
	}

	private string PageBook(string scene)
	{
		if (scene != bookScene)
		{
			bookScene = scene;
			book = BotPerception.StrategyText(scene);
			if (book == "")
			{
				book = "no playbook for '" + scene + "' yet — run tools\\mm-coach.py --scene " + scene;
			}
		}
		return "<b>PLAYBOOK — " + scene + "</b>\n" + book;
	}

	public Overlay()
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
	}
}
