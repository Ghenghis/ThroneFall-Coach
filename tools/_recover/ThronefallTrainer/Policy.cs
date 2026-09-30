using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Policy
{
	public static bool Enabled = true;

	public static float Epsilon = 0.1f;

	public static float LearningRate = 0.3f;

	public static float Discount = 0.9f;

	private static readonly Dictionary<string, Dictionary<string, float>> Q = new Dictionary<string, Dictionary<string, float>>();

	private static readonly List<(string s, string a)> traj = new List<(string, string)>();

	private static float pendingReward;

	private static readonly Random rng = new Random();

	private static string file;

	private static float saveAt;

	public static int Decisions;

	public static int Updates;

	public static int States => Q.Count;

	public static int Cells
	{
		get
		{
			int num = 0;
			foreach (Dictionary<string, float> value in Q.Values)
			{
				num += value.Count;
			}
			return num;
		}
	}

	public static void Init()
	{
		file = Path.Combine(Recorder.AgentDir, "policy.json");
		Load();
	}

	private static void Ensure()
	{
		if (file == null)
		{
			Init();
		}
	}

	public static string Eval(string point, string[] options, string stateKey)
	{
		Ensure();
		if (!Enabled || options == null || options.Length == 0)
		{
			if (options == null || options.Length == 0)
			{
				return "";
			}
			return options[0];
		}
		string key = point + "|" + stateKey;
		if (!(rng.NextDouble() < (double)Epsilon))
		{
			return Best(key, options);
		}
		return options[rng.Next(options.Length)];
	}

	public static void Commit(string point, string action, string stateKey, string[] options)
	{
		string text = point + "|" + stateKey;
		traj.Add((text, action));
		Decisions++;
		if (traj.Count > 1)
		{
			(string s, string a) tuple = traj[traj.Count - 2];
			string item = tuple.s;
			string item2 = tuple.a;
			float num = BestQ(text, options);
			Update(item, item2, pendingReward + Discount * num);
			pendingReward = 0f;
		}
	}

	public static string Choose(string point, string[] options, string stateKey)
	{
		string text = Eval(point, options, stateKey);
		Commit(point, text, stateKey, options);
		return text;
	}

	public static void Reward(float r)
	{
		pendingReward += r;
	}

	public static void BeginRun()
	{
		traj.Clear();
		pendingReward = 0f;
	}

	public static void MatchEnd(bool victory, float castleHpFrac, int breaches)
	{
		float num = (victory ? 10f : (-10f)) + castleHpFrac * 5f - (float)breaches * 0.4f + pendingReward;
		for (int num2 = traj.Count - 1; num2 >= 0; num2--)
		{
			var (key, action) = traj[num2];
			Update(key, action, num);
			num *= Discount;
		}
		traj.Clear();
		pendingReward = 0f;
		Save();
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)("[policy] match end " + (victory ? "VICTORY" : "defeat") + ": " + $"reward backed over {Decisions} decisions, table={Q.Count} states"));
		}
	}

	public static void Pulse(float r)
	{
		Reward(r);
	}

	public static string Best(string key, string[] options)
	{
		string result = options[0];
		float num = float.MinValue;
		foreach (string text in options)
		{
			float num2 = Get(key, text);
			if (num2 > num)
			{
				num = num2;
				result = text;
			}
		}
		return result;
	}

	public static float BestQ(string key, string[] options)
	{
		float num = float.MinValue;
		foreach (string action in options)
		{
			float num2 = Get(key, action);
			if (num2 > num)
			{
				num = num2;
			}
		}
		if (num != float.MinValue)
		{
			return num;
		}
		return 0f;
	}

	private static float Get(string key, string action)
	{
		if (!Q.TryGetValue(key, out var value) || !value.TryGetValue(action, out var value2))
		{
			return 0f;
		}
		return value2;
	}

	private static void Update(string key, string action, float target)
	{
		if (float.IsNaN(target) || float.IsInfinity(target))
		{
			return;
		}
		if (!Q.TryGetValue(key, out var value))
		{
			value = (Q[key] = new Dictionary<string, float>());
		}
		float num = (value.TryGetValue(action, out var value2) ? value2 : 0f);
		float num2 = num + LearningRate * (target - num);
		if (!float.IsNaN(num2) && !float.IsInfinity(num2))
		{
			value[action] = num2;
			Updates++;
			if (Time.unscaledTime > saveAt)
			{
				saveAt = Time.unscaledTime + 15f;
				Save();
				DumpStats();
			}
		}
	}

	private static void DumpStats()
	{
		try
		{
			int num = 0;
			float num2 = 0f;
			foreach (Dictionary<string, float> value in Q.Values)
			{
				foreach (float value2 in value.Values)
				{
					num++;
					num2 += Mathf.Abs(value2);
				}
			}
			Recorder.WriteAtomic(Path.Combine(Recorder.AgentDir, "policystats.json"), "{\"states\":" + Q.Count + ",\"cells\":" + num + ",\"decisions\":" + Decisions + ",\"updates\":" + Updates + ",\"mean_abs_q\":" + ((num > 0) ? (num2 / (float)num).ToString("0.###", CultureInfo.InvariantCulture) : "0") + ",\"epsilon\":" + Epsilon.ToString("0.###", CultureInfo.InvariantCulture) + "}");
		}
		catch
		{
		}
	}

	public static string Stats()
	{
		int num = 0;
		foreach (Dictionary<string, float> value in Q.Values)
		{
			num += value.Count;
		}
		return $"{{\"states\":{Q.Count},\"cells\":{num}," + $"\"decisions\":{Decisions},\"updates\":{Updates}}}";
	}

	public static string Dump(string point)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (KeyValuePair<string, Dictionary<string, float>> item in Q)
		{
			if (!item.Key.StartsWith(point))
			{
				continue;
			}
			stringBuilder.Append(item.Key).Append(" -> ");
			foreach (KeyValuePair<string, float> item2 in item.Value)
			{
				stringBuilder.Append(item2.Key).Append('=').Append(item2.Value.ToString("0.##"))
					.Append(' ');
			}
			stringBuilder.Append('\n');
		}
		return stringBuilder.ToString();
	}

	private static string Js(string s)
	{
		if (!string.IsNullOrEmpty(s))
		{
			return s.Replace("\\", "\\\\").Replace("\"", "\\\"");
		}
		return "";
	}

	private static string UnJs(string s)
	{
		if (string.IsNullOrEmpty(s) || s.IndexOf('\\') < 0)
		{
			return s;
		}
		StringBuilder stringBuilder = new StringBuilder(s.Length);
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] == '\\' && i + 1 < s.Length)
			{
				char c = s[++i];
				stringBuilder.Append(c switch
				{
					'r' => '\r', 
					't' => '\t', 
					'n' => '\n', 
					_ => c, 
				});
			}
			else
			{
				stringBuilder.Append(s[i]);
			}
		}
		return stringBuilder.ToString();
	}

	private static void Save()
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder("{");
			bool flag = true;
			foreach (KeyValuePair<string, Dictionary<string, float>> item in Q)
			{
				if (!flag)
				{
					stringBuilder.Append(',');
				}
				flag = false;
				stringBuilder.Append('\n').Append('"').Append(Js(item.Key))
					.Append("\":{");
				bool flag2 = true;
				foreach (KeyValuePair<string, float> item2 in item.Value)
				{
					if (!flag2)
					{
						stringBuilder.Append(',');
					}
					flag2 = false;
					stringBuilder.Append('"').Append(Js(item2.Key)).Append("\":")
						.Append(item2.Value.ToString("0.####", CultureInfo.InvariantCulture));
				}
				stringBuilder.Append('}');
			}
			stringBuilder.Append("\n}");
			Recorder.WriteAtomic(file, stringBuilder.ToString());
		}
		catch (Exception ex)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)("[policy] save: " + ex.Message));
			}
		}
	}

	private static void Load()
	{
		try
		{
			if (!File.Exists(file))
			{
				return;
			}
			foreach (Match item in Regex.Matches(File.ReadAllText(file), "\"([^\"]+)\"\\s*:\\s*\\{([^}]*)\\}"))
			{
				Dictionary<string, float> dictionary = new Dictionary<string, float>();
				foreach (Match item2 in Regex.Matches(item.Groups[2].Value, "\"([^\"]+)\"\\s*:\\s*(-?[\\d.eE+-]+)"))
				{
					if (float.TryParse(item2.Groups[2].Value, NumberStyles.Float, CultureInfo.InvariantCulture, out var result) && !float.IsNaN(result) && !float.IsInfinity(result))
					{
						dictionary[UnJs(item2.Groups[1].Value)] = result;
					}
				}
				Q[UnJs(item.Groups[1].Value)] = dictionary;
			}
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)$"[policy] loaded {Q.Count} learned states");
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[policy] load: " + ex.Message));
			}
		}
	}
}
