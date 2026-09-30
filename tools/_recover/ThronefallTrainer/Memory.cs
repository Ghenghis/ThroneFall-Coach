using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Memory
{
	private static readonly HashSet<string> parked = new HashSet<string>();

	private static readonly HashSet<string> parkedWhy = new HashSet<string>();

	private static readonly HashSet<string> badScenes = new HashSet<string>();

	private static readonly List<string> parkOrder = new List<string>();

	private static string file;

	private static bool loaded;

	private const int MaxPerScene = 24;

	public static int Count => parked.Count;

	private static void EnsureInit()
	{
		if (loaded)
		{
			return;
		}
		loaded = true;
		try
		{
			file = Path.Combine(Recorder.AgentDir, "mishaps.json");
			Load();
			LoadBadScenes();
		}
		catch
		{
		}
	}

	private static string Cell(Vector3 p)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		return $"{Mathf.RoundToInt(p.x / 4f)},{Mathf.RoundToInt(p.z / 4f)}";
	}

	public static bool IsParked(string scene, Vector3 pos)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		EnsureInit();
		return parked.Contains(Sanitize(scene) + "|" + Cell(pos));
	}

	public static void Park(string scene, Vector3 pos, string why)
	{
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		EnsureInit();
		scene = Sanitize(scene);
		if (why != null && (why.Contains("|") || why.Contains("\"") || why.Contains("\\")))
		{
			why = why.Replace("|", "/").Replace("\"", "'").Replace("\\", "/");
		}
		string text = scene + "|" + Cell(pos);
		if (!parked.Add(text))
		{
			return;
		}
		parkedWhy.Add(text + "|" + (why ?? "?"));
		parkOrder.Add(text);
		int num = 0;
		foreach (string item in parkOrder)
		{
			if (item.StartsWith(scene + "|") && parked.Contains(item))
			{
				num++;
			}
		}
		while (num > 24)
		{
			string text2 = null;
			foreach (string item2 in parkOrder)
			{
				if (item2.StartsWith(scene + "|") && parked.Contains(item2))
				{
					text2 = item2;
					break;
				}
			}
			if (text2 == null)
			{
				break;
			}
			parked.Remove(text2);
			parkOrder.Remove(text2);
			string text3 = null;
			foreach (string item3 in parkedWhy)
			{
				if (item3.StartsWith(text2 + "|"))
				{
					text3 = item3;
					break;
				}
			}
			if (text3 != null)
			{
				parkedWhy.Remove(text3);
			}
			num--;
		}
		Save();
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)("[memory] parked '" + text + "' (" + why + ") — never retrying"));
		}
	}

	public static void Unpark(string scene, Vector3 pos)
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		EnsureInit();
		string text = Sanitize(scene) + "|" + Cell(pos);
		if (!parked.Remove(text))
		{
			return;
		}
		parkOrder.Remove(text);
		string text2 = null;
		foreach (string item in parkedWhy)
		{
			if (item.StartsWith(text + "|"))
			{
				text2 = item;
				break;
			}
		}
		if (text2 != null)
		{
			parkedWhy.Remove(text2);
		}
		Save();
		ManualLogSource log = Plugin.Log;
		if (log != null)
		{
			log.LogInfo((object)("[memory] unparked '" + text + "' — slot redeemed"));
		}
	}

	public static void MarkBadScene(string scene)
	{
		EnsureInit();
		scene = Sanitize(scene);
		if (!string.IsNullOrEmpty(scene) && badScenes.Add(scene))
		{
			SaveBadScenes();
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)("[memory] scene quarantined '" + scene + "' — bad match state persisted"));
			}
		}
	}

	public static bool IsBadScene(string scene)
	{
		EnsureInit();
		if (scene != null)
		{
			return badScenes.Contains(Sanitize(scene));
		}
		return false;
	}

	public static void ForgiveParks(string scene)
	{
		EnsureInit();
		scene = Sanitize(scene);
		int num = 0;
		string[] array = parkOrder.ToArray();
		foreach (string text in array)
		{
			if (text.StartsWith(scene + "|") && parked.Remove(text))
			{
				parkOrder.Remove(text);
				num++;
			}
		}
		if (num > 0)
		{
			parkedWhy.RemoveWhere((string w) => w.StartsWith(scene + "|"));
			Save();
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)$"[memory] forgave {num} parked cells for '{scene}' (new match)");
			}
		}
	}

	public static void ForgiveScene(string scene)
	{
		EnsureInit();
		if (badScenes.Remove(Sanitize(scene)))
		{
			SaveBadScenes();
		}
	}

	private static string Sanitize(string scene)
	{
		if (!string.IsNullOrEmpty(scene))
		{
			return scene.Replace("|", "/").Replace("\"", "'").Replace("\\", "/");
		}
		return "";
	}

	private static void SaveBadScenes()
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder("[");
			bool flag = true;
			foreach (string badScene in badScenes)
			{
				if (!flag)
				{
					stringBuilder.Append(",");
				}
				flag = false;
				stringBuilder.Append(BotPerception.JsonStr(badScene));
			}
			stringBuilder.Append("]");
			Recorder.WriteAtomic(Path.Combine(Recorder.AgentDir, "badscenes.json"), stringBuilder.ToString());
		}
		catch
		{
		}
	}

	private static void LoadBadScenes()
	{
		try
		{
			string path = Path.Combine(Recorder.AgentDir, "badscenes.json");
			if (!File.Exists(path))
			{
				return;
			}
			foreach (Match item in Regex.Matches(File.ReadAllText(path), "\"([^\"]+)\""))
			{
				badScenes.Add(item.Groups[1].Value);
			}
		}
		catch
		{
		}
	}

	private static void Save()
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder("[\n");
			bool flag = true;
			foreach (string item in parkedWhy)
			{
				if (!flag)
				{
					stringBuilder.Append(",\n");
				}
				flag = false;
				stringBuilder.Append("  \"").Append(item).Append('"');
			}
			stringBuilder.Append("\n]\n");
			Recorder.WriteAtomic(file, stringBuilder.ToString());
		}
		catch (Exception ex)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)("[memory] save: " + ex.Message));
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
			bool flag = false;
			foreach (Match item in Regex.Matches(File.ReadAllText(file), "\"([^\"]+)\""))
			{
				string value = item.Groups[1].Value;
				string[] array = value.Split('|');
				if (array.Length >= 2)
				{
					if (parked.Add(array[0] + "|" + array[1]))
					{
						parkOrder.Add(array[0] + "|" + array[1]);
						parkedWhy.Add(value);
					}
					else
					{
						flag = true;
					}
				}
			}
			if (flag)
			{
				Save();
			}
			if (parked.Count > 0)
			{
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)$"[memory] {parked.Count} mishaps remembered");
				}
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[memory] load: " + ex.Message));
			}
		}
	}
}
