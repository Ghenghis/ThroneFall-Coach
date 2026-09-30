using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using BepInEx;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Recorder
{
	public const int QueueCap = 2000;

	private static readonly ConcurrentQueue<string> q = new ConcurrentQueue<string>();

	private static Thread writer;

	private static readonly object writerLock = new object();

	private static volatile bool running;

	private static string runId;

	private static string runDir;

	private static string ticksPath;

	private static string eventsPath;

	private static string summaryPath;

	private static int tickCount;

	private static int dropped;

	private static int lastTickSecond = -1;

	private static int ioErrors;

	private static float tStart;

	private static float castleHpMinSeen = 1f;

	private static int heroDeaths;

	private static int snaps;

	private static int unsticks;

	private static int stalls;

	private static string lastScene = "";

	private static int lastWave;

	private static float lastGold = -1f;

	private static readonly Dictionary<string, int> ruleFires = new Dictionary<string, int>();

	public static string RunId => runId;

	public static int Ticks => tickCount;

	public static int Dropped => dropped;

	public static string AgentDir
	{
		get
		{
			try
			{
				return Path.Combine(Paths.PluginPath, "agent");
			}
			catch
			{
				return "agent";
			}
		}
	}

	public static void Start()
	{
		lock (writerLock)
		{
			if (!running)
			{
				running = true;
				writer = new Thread(Drain)
				{
					IsBackground = true,
					Name = "tf-recorder"
				};
				writer.Start();
			}
		}
	}

	public static void Stop()
	{
		lock (writerLock)
		{
			running = false;
		}
		try
		{
			writer?.Join(2000);
		}
		catch
		{
		}
	}

	public static void NoteAnchor(string scene, float x, float z, string kind)
	{
		try
		{
			string path = Path.Combine(AgentDir, "anchors.json");
			Directory.CreateDirectory(AgentDir);
			List<string> list = new List<string>(File.Exists(path) ? File.ReadAllLines(path) : new string[0]);
			CultureInfo invariantCulture = CultureInfo.InvariantCulture;
			string text = x.ToString("0.#", invariantCulture);
			string text2 = z.ToString("0.#", invariantCulture);
			for (int num = list.Count - 1; num >= 0; num--)
			{
				string text3 = list[num];
				if (text3.Contains("\"s\":\"" + scene + "\"") && text3.Contains("\"k\":\"" + kind + "\""))
				{
					float num2 = JFloat(text3, "\"x\":");
					float num3 = JFloat(text3, "\"z\":");
					if (!(Math.Abs(num2 - x) > 3f) && !(Math.Abs(num3 - z) > 3f))
					{
						int num4 = (int)JFloat(text3, "\"hits\":") + 1;
						list[num] = string.Format(invariantCulture, "{{\"s\":\"{0}\",\"k\":\"{1}\",\"x\":{2},\"z\":{3},\"hits\":{4}}}", scene, kind, text, text2, num4);
						WriteAtomic(path, string.Join("\n", list));
						return;
					}
				}
			}
			list.Add(string.Format(invariantCulture, "{{\"s\":\"{0}\",\"k\":\"{1}\",\"x\":{2},\"z\":{3},\"hits\":1}}", scene, kind, text, text2));
			WriteAtomic(path, string.Join("\n", list));
		}
		catch
		{
		}
	}

	private static float JFloat(string json, string key)
	{
		int num = json.IndexOf(key, StringComparison.Ordinal);
		if (num < 0)
		{
			return 0f;
		}
		num += key.Length;
		int i;
		for (i = num; i < json.Length && (char.IsDigit(json[i]) || json[i] == '.' || json[i] == '-' || json[i] == '+' || json[i] == 'e' || json[i] == 'E'); i++)
		{
		}
		float.TryParse(json.Substring(num, i - num), NumberStyles.Float, CultureInfo.InvariantCulture, out var result);
		return result;
	}

	public static void BeginRun(string scene)
	{
		try
		{
			string path = DateTime.UtcNow.ToString("yyyyMMddTHHmmssZ", CultureInfo.InvariantCulture) + "-" + (string.IsNullOrEmpty(scene) ? "unknown" : Sanitize(scene));
			string path2 = Path.Combine(AgentDir, "runs", path);
			Directory.CreateDirectory(path2);
			runId = path;
			runDir = path2;
			ticksPath = Path.Combine(runDir, "ticks.jsonl");
			eventsPath = Path.Combine(runDir, "events.jsonl");
			summaryPath = Path.Combine(runDir, "summary.json");
			tickCount = (dropped = (heroDeaths = (snaps = (unsticks = (stalls = 0)))));
			ruleFires.Clear();
			castleHpMinSeen = 1f;
			lastScene = scene;
			lastWave = 0;
			lastGold = -1f;
			lastTickSecond = -1;
			tStart = Time.unscaledTime;
			Event("run-start", "\"scene\":\"" + J(scene) + "\"");
		}
		catch
		{
			ioErrors++;
		}
	}

	public static void Event(string note, string extra = null)
	{
		if (runDir != null)
		{
			Enq(eventsPath, "{\"t\":" + F(Time.unscaledTime - tStart) + ",\"note\":\"" + J(note) + "\"" + ((extra != null) ? ("," + extra) : "") + "}");
		}
	}

	public static void Tick(string compactLine)
	{
		if (ticksPath == null)
		{
			return;
		}
		int num = (int)((Time.unscaledTime - tStart) * 2f);
		if (num != lastTickSecond)
		{
			lastTickSecond = num;
			if (Enq(ticksPath, compactLine))
			{
				tickCount++;
			}
		}
	}

	public static void NoteGameFacts(in BotPerception.Snapshot s)
	{
		if (s.Wave > lastWave)
		{
			lastWave = s.Wave;
		}
		lastGold = s.Balance;
		lastScene = s.SceneName;
	}

	public static void CountSnap()
	{
		snaps++;
	}

	public static void CountUnstick()
	{
		unsticks++;
	}

	public static void CountStall()
	{
		stalls++;
	}

	public static void CountDeath()
	{
		heroDeaths++;
	}

	public static void SeeCastleHp(float pct)
	{
		if (pct < castleHpMinSeen)
		{
			castleHpMinSeen = pct;
		}
	}

	public static void CountRuleFire(string id)
	{
		ruleFires[id] = ((!ruleFires.TryGetValue(id, out var value)) ? 1 : (value + 1));
	}

	public static void MatchEnd(string result, bool legit)
	{
		if (runDir == null)
		{
			return;
		}
		try
		{
			Directory.CreateDirectory(runDir);
			string text = "{\"runId\":\"" + J(runId) + "\",\"scene\":\"" + J(lastScene) + "\",\"legit\":" + (legit ? "true" : "false") + ",\"result\":\"" + J(result) + "\",\"waves\":" + lastWave + ",\"durationS\":" + F(Time.unscaledTime - tStart) + ",\"castleHpMin\":" + F(castleHpMinSeen) + ",\"heroDeaths\":" + heroDeaths + ",\"goldLast\":" + F(lastGold) + ",\"stalls\":" + stalls + ",\"unsticks\":" + unsticks + ",\"snaps\":" + snaps + ",\"rulesFired\":{" + string.Join(",", from kv in ruleFires.ToArray()
				select "\"" + J(kv.Key) + "\":" + kv.Value) + "},\"recorder\":{\"ticks\":" + tickCount + ",\"dropped\":" + dropped + ",\"ioErrors\":" + ioErrors + "}}";
			WriteAtomic(summaryPath, text);
			Event("match-end", "\"result\":\"" + J(result) + "\"");
			Enq(Path.Combine(AgentDir, "memory", "episodic", "index.jsonl"), text);
		}
		catch
		{
			ioErrors++;
		}
	}

	private static bool Enq(string path, string line)
	{
		if (!running || path == null)
		{
			return false;
		}
		if (q.Count >= 2000)
		{
			dropped++;
			return false;
		}
		q.Enqueue(path + "\u0001" + line);
		return true;
	}

	private static void Drain()
	{
		while (running || !q.IsEmpty)
		{
			try
			{
				if (q.TryDequeue(out var result))
				{
					int num = result.IndexOf('\u0001');
					if (num <= 0)
					{
						continue;
					}
					string path = result.Substring(0, num);
					string value = result.Substring(num + 1);
					string directoryName = Path.GetDirectoryName(path);
					if (!string.IsNullOrEmpty(directoryName))
					{
						Directory.CreateDirectory(directoryName);
					}
					using (FileStream stream = new FileStream(path, FileMode.Append, FileAccess.Write, FileShare.ReadWrite | FileShare.Delete))
					{
						using StreamWriter streamWriter = new StreamWriter(stream);
						streamWriter.WriteLine(value);
					}
					continue;
				}
				Thread.Sleep(250);
			}
			catch
			{
				ioErrors++;
				dropped++;
				Thread.Sleep(250);
			}
		}
	}

	private static string J(string s)
	{
		if (s != null)
		{
			return s.Replace("\\", "\\\\").Replace("\"", "\\\"");
		}
		return "";
	}

	private static string F(float v)
	{
		return v.ToString("0.###", CultureInfo.InvariantCulture);
	}

	private static string Sanitize(string s)
	{
		char[] array = s.ToCharArray();
		for (int i = 0; i < array.Length; i++)
		{
			if (!char.IsLetterOrDigit(array[i]) && array[i] != '-' && array[i] != '_')
			{
				array[i] = '_';
			}
		}
		return new string(array);
	}

	public static void WriteAtomic(string path, string text)
	{
		if (path == null)
		{
			return;
		}
		string text2 = path + ".tmp";
		File.WriteAllText(text2, text);
		try
		{
			if (File.Exists(path))
			{
				File.Replace(text2, path, null);
			}
			else
			{
				File.Move(text2, path);
			}
		}
		catch (FileNotFoundException)
		{
			File.Move(text2, path);
		}
	}
}
