using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal static class NetPolicy
{
	public static bool Loaded;

	private static float[][] w1;

	private static float[][] w2;

	private static float[][] wp;

	private static float[] b1;

	private static float[] b2;

	private static float[] bp;

	private static float[] wv;

	private static float[] bv;

	private static readonly string[] Modes = new string[11]
	{
		"Idle", "CollectCoin", "ReturnHome", "HoldCastle", "Engage", "EnterLevel", "StartNight", "SpendGold", "ResolveUI", "PositionArmy",
		"HeroDead"
	};

	private static int agree;

	private static int disagree;

	private static float logAt;

	private static bool tried;

	private static float netPollAt;

	private static DateTime netMtime;

	public static int Agree => agree;

	public static int Disagree => disagree;

	public static float Ratio
	{
		get
		{
			if (agree + disagree <= 0)
			{
				return 0f;
			}
			return (float)agree / (float)(agree + disagree);
		}
	}

	public static void Init()
	{
		try
		{
			string path = Path.Combine(Recorder.AgentDir, "netpolicy.json");
			if (!File.Exists(path))
			{
				return;
			}
			string j = File.ReadAllText(path);
			w1 = Mat(j, "w1");
			b1 = Vec(j, "b1");
			w2 = Mat(j, "w2");
			b2 = Vec(j, "b2");
			wp = Mat(j, "wp");
			bp = Vec(j, "bp");
			wv = Vec(j, "wv");
			bv = Vec(j, "bv");
			Loaded = w1 != null && w1.Length != 0 && w1[0] != null && w2 != null && wp != null && wp.Length != 0;
			if (Loaded && w1[0].Length != Features(default(BotPerception.Snapshot)).Length)
			{
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogWarning((object)($"[net] feature dim mismatch: w1={w1[0].Length} vs features=" + $"{Features(default(BotPerception.Snapshot)).Length} — net NOT loaded"));
				}
				Loaded = false;
			}
			if (Loaded && (w2.Length == 0 || w2[0] == null || w2[0].Length != w1.Length || b1 == null || b1.Length != w1.Length || b2 == null || b2.Length != w2.Length || wp[0] == null || wp[0].Length != w2.Length || bp == null || bp.Length != wp.Length || wp.Length != Modes.Length))
			{
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogWarning((object)($"[net] layer dims broken: w1 {w1.Length}x{w1[0].Length} " + $"w2 {w2.Length}x{((w2[0] != null) ? w2[0].Length : (-1))} " + $"wp {wp.Length}x{((wp[0] != null) ? wp[0].Length : (-1))} " + $"(need {Modes.Length} outputs) — net NOT loaded"));
				}
				Loaded = false;
			}
			if (Loaded)
			{
				ManualLogSource log3 = Plugin.Log;
				if (log3 != null)
				{
					log3.LogInfo((object)($"[net] policy net loaded ({w1.Length}x{w1[0].Length}" + $" -> {wp.Length} modes)"));
				}
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log4 = Plugin.Log;
			if (log4 != null)
			{
				log4.LogWarning((object)("[net] load: " + ex.Message));
			}
		}
	}

	public static float[] Features(in BotPerception.Snapshot s)
	{
		return new float[12]
		{
			(float)s.Balance / 500f,
			(float)s.EnemyCount / 60f,
			(float)s.AllyCount / 60f,
			(float)s.FreeUnits / 60f,
			(s.DoorCount > 0) ? ((float)s.DoorsCovered / (float)s.DoorCount) : 0f,
			(float)s.DoorCount / 16f,
			(float)s.ArmyTarget / 80f,
			s.IsNight ? 1f : 0f,
			s.RedAlert ? 1f : 0f,
			Mathf.Clamp01(s.HeroHpPct),
			Mathf.Clamp01((s.CastleHpPct >= 0f) ? s.CastleHpPct : 0.5f),
			(float)s.Wave / 60f
		};
	}

	public static int Predict(float[] x, out float confidence)
	{
		confidence = 0f;
		if (!Loaded)
		{
			return -1;
		}
		float[] x2 = Act(Mul(w1, x, b1));
		float[] x3 = Act(Mul(w2, x2, b2));
		float[] array = Mul(wp, x3, bp);
		if (array.Length == 0)
		{
			return -1;
		}
		float num = float.MinValue;
		float[] array2 = array;
		foreach (float num2 in array2)
		{
			if (num2 > num)
			{
				num = num2;
			}
		}
		float num3 = 0f;
		float[] array3 = new float[array.Length];
		for (int j = 0; j < array.Length; j++)
		{
			array3[j] = Mathf.Exp(array[j] - num);
			num3 += array3[j];
		}
		int result = 0;
		float num4 = -1f;
		for (int k = 0; k < array3.Length; k++)
		{
			float num5 = array3[k] / num3;
			if (num5 > num4)
			{
				num4 = num5;
				result = k;
			}
		}
		confidence = num4;
		return result;
	}

	public static void Shadow(in BotPerception.Snapshot s, string pickedMode)
	{
		if (!tried)
		{
			tried = true;
			Init();
		}
		if (Time.unscaledTime > netPollAt)
		{
			netPollAt = Time.unscaledTime + 30f;
			try
			{
				string path = Path.Combine(Recorder.AgentDir, "netpolicy.json");
				DateTime dateTime = (File.Exists(path) ? File.GetLastWriteTimeUtc(path) : default(DateTime));
				if (dateTime != netMtime)
				{
					Init();
					if (Loaded)
					{
						netMtime = dateTime;
					}
				}
			}
			catch
			{
			}
		}
		if (!Loaded)
		{
			return;
		}
		int num = Predict(Features(in s), out var confidence);
		if (num < 0 || num >= Modes.Length)
		{
			return;
		}
		if (pickedMode == Modes[num])
		{
			agree++;
		}
		else
		{
			disagree++;
		}
		if (!(Time.unscaledTime > logAt))
		{
			return;
		}
		logAt = Time.unscaledTime + 30f;
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)($"[net] shadow: {agree} agree / {disagree} disagree" + $" (last: net={Modes[num]}@{confidence:0.##} bot={pickedMode})"));
		}
		try
		{
			Recorder.WriteAtomic(Path.Combine(Recorder.AgentDir, "netstats.json"), "{\"agree\":" + agree + ",\"disagree\":" + disagree + ",\"ratio\":" + ((agree + disagree > 0) ? ((float)agree / (float)(agree + disagree)).ToString("0.###", CultureInfo.InvariantCulture) : "0") + ",\"last_net\":" + BotPerception.JsonStr(Modes[num]) + ",\"last_bot\":" + BotPerception.JsonStr(pickedMode) + "\",\"conf\":" + confidence.ToString("0.###", CultureInfo.InvariantCulture) + "}");
		}
		catch
		{
		}
	}

	public static string ModeName(int i)
	{
		if (i < 0 || i >= Modes.Length)
		{
			return "?";
		}
		return Modes[i];
	}

	private static float[] Mul(float[][] w, float[] x, float[] b)
	{
		float[] array = new float[w.Length];
		for (int i = 0; i < w.Length; i++)
		{
			float num = ((b != null && i < b.Length) ? b[i] : 0f);
			float[] array2 = w[i];
			for (int j = 0; j < array2.Length && j < x.Length; j++)
			{
				num += array2[j] * x[j];
			}
			array[i] = num;
		}
		return array;
	}

	private static float[] Act(float[] x)
	{
		for (int i = 0; i < x.Length; i++)
		{
			x[i] = (float)Math.Tanh(x[i]);
		}
		return x;
	}

	private static float[][] Mat(string j, string key)
	{
		int num = j.IndexOf("\"" + key + "\"");
		if (num < 0)
		{
			return null;
		}
		int num2 = j.IndexOf('[', num);
		if (num2 < 0)
		{
			return null;
		}
		int num3 = 0;
		int num4 = num2;
		for (int i = num2; i < j.Length; i++)
		{
			if (j[i] == '[')
			{
				num3++;
			}
			if (j[i] == ']' && --num3 == 0)
			{
				num4 = i;
				break;
			}
		}
		List<float[]> list = new List<float[]>();
		int num5 = j.IndexOf('[', num2 + 1);
		while (num5 >= 0 && num5 < num4)
		{
			int num6 = j.IndexOf(']', num5);
			list.Add(ParseVec(j.Substring(num5 + 1, num6 - num5 - 1)));
			num5 = j.IndexOf('[', num6);
			if (num5 > num4)
			{
				break;
			}
		}
		return list.ToArray();
	}

	private static float[] Vec(string j, string key)
	{
		int num = j.IndexOf("\"" + key + "\"");
		if (num < 0)
		{
			return null;
		}
		int num2 = j.IndexOf('[', num);
		int num3 = j.IndexOf(']', num2);
		if (num2 < 0 || num3 <= num2)
		{
			return null;
		}
		return ParseVec(j.Substring(num2 + 1, num3 - num2 - 1));
	}

	private static float[] ParseVec(string csv)
	{
		List<float> list = new List<float>();
		string[] array = csv.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			if (float.TryParse(array[i].Trim(), NumberStyles.Float, CultureInfo.InvariantCulture, out var result) && !float.IsNaN(result) && !float.IsInfinity(result))
			{
				list.Add(result);
			}
		}
		return list.ToArray();
	}
}
