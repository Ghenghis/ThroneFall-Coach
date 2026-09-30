using System;
using System.Globalization;
using System.IO;
using System.Text;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Mailbox
{
	private static float nextPollAt;

	private static float nextStateAt;

	private static string InboxDir => Path.Combine(Recorder.AgentDir, "tf-agent", "inbox");

	private static string OutboxDir => Path.Combine(Recorder.AgentDir, "tf-agent", "outbox");

	private static string DoneDir => Path.Combine(InboxDir, "done");

	private static bool runDirKnown => Recorder.RunId != null;

	public static void Poll(in BotPerception.Snapshot s)
	{
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime >= nextPollAt)
		{
			nextPollAt = unscaledTime + 1f;
			ProcessInbox(in s);
		}
		if (unscaledTime >= nextStateAt && runDirKnown)
		{
			nextStateAt = unscaledTime + 5f;
			WriteState(in s);
		}
	}

	private static void ProcessInbox(in BotPerception.Snapshot s)
	{
		try
		{
			if (!Directory.Exists(InboxDir))
			{
				return;
			}
			string[] files = Directory.GetFiles(InboxDir, "*.order");
			foreach (string text in files)
			{
				try
				{
					Apply(File.ReadAllText(text), in s);
				}
				catch (Exception ex)
				{
					ManualLogSource log = Plugin.Log;
					if (log != null)
					{
						log.LogWarning((object)("[bot] mailbox order failed '" + Path.GetFileName(text) + "': " + ex.Message));
					}
					Bot.LogLine(in s, "mailbox-reject");
				}
				finally
				{
					try
					{
						Directory.CreateDirectory(DoneDir);
						string text2 = Path.Combine(DoneDir, Path.GetFileName(text));
						if (File.Exists(text2))
						{
							File.Delete(text2);
						}
						File.Move(text, text2);
					}
					catch
					{
					}
				}
			}
		}
		catch
		{
		}
	}

	private static void Apply(string order, in BotPerception.Snapshot s)
	{
		string text = JVal(order, "\"op\":");
		if (text == null)
		{
			throw new InvalidDataException("missing op");
		}
		switch (text)
		{
		case "policy":
		{
			string text3 = JVal(order, "\"text\":", raw: true);
			if (text3 == null)
			{
				throw new InvalidDataException("policy op needs text");
			}
			WriteAtomic(Path.Combine(Recorder.AgentDir, "policy.txt"), text3);
			Bot.LogLine(in s, "mailbox-policy");
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogInfo((object)"[bot] mailbox: policy.txt replaced by sidecar");
			}
			break;
		}
		case "note":
		{
			string text4 = JVal(order, "\"text\":", raw: true) ?? "sidecar-note";
			Recorder.Event("mailbox-note", "\"text\":\"" + text4.Replace("\"", "'") + "\"");
			break;
		}
		case "report":
			WriteState(in s, "report-" + DateTime.UtcNow.ToString("HHmmss"));
			Recorder.Event("mailbox-report");
			break;
		case "loadout":
		{
			string text2 = JVal(order, "\"weapon\":", raw: true);
			if (!string.IsNullOrEmpty(text2))
			{
				Bot.RequestLoadout(text2);
				Recorder.Event("mailbox-loadout", "\"w\":\"" + text2.Replace("\"", "'") + "\"");
			}
			break;
		}
		default:
			throw new InvalidDataException("unknown op '" + text + "'");
		}
	}

	private static void WriteState(in BotPerception.Snapshot s, string name = null)
	{
		try
		{
			Directory.CreateDirectory(OutboxDir);
			string path = Path.Combine(OutboxDir, (name == null) ? "state.json" : (name + ".json"));
			string text = "{\"run\":\"" + J(Recorder.RunId ?? "") + "\",\"scene\":\"" + J(s.SceneName) + "\",\"state\":\"" + J(s.GameState) + "\",\"mode\":\"" + J(Bot.Mode.ToString()) + "\",\"wave\":" + s.Wave + ",\"waveTotal\":" + s.WaveTotal + ",\"night\":" + (s.IsNight ? "true" : "false") + ",\"foes\":" + s.EnemyCount + ",\"hp\":" + F(s.HeroHpPct) + ",\"gold\":" + s.Balance + ",\"core\":" + s.CoreBalance + ",\"army\":" + s.AllyCount + ",\"frame\":\"" + J(Bot.UiFrame) + "\"}";
			WriteAtomic(path, text);
		}
		catch
		{
		}
	}

	private static string JVal(string json, string key, bool raw = false)
	{
		int num = json.IndexOf(key, StringComparison.Ordinal);
		if (num < 0)
		{
			return null;
		}
		for (num += key.Length; num < json.Length && (json[num] == ' ' || json[num] == ':'); num++)
		{
		}
		if (num >= json.Length || json[num] != '"')
		{
			return null;
		}
		num++;
		int i;
		for (i = num; i < json.Length; i++)
		{
			if (json[i] == '"')
			{
				int num2 = 0;
				int num3 = i - 1;
				while (num3 >= num && json[num3] == '\\')
				{
					num2++;
					num3--;
				}
				if (num2 % 2 == 0)
				{
					break;
				}
			}
		}
		if (i <= num)
		{
			return null;
		}
		string text = json.Substring(num, i - num);
		StringBuilder stringBuilder = new StringBuilder(text.Length);
		for (int j = 0; j < text.Length; j++)
		{
			if (text[j] == '\\' && j + 1 < text.Length)
			{
				char c = text[++j];
				switch (c)
				{
				case 'n':
					stringBuilder.Append('\n');
					break;
				case 't':
					stringBuilder.Append('\t');
					break;
				case 'r':
					stringBuilder.Append('\r');
					break;
				default:
					stringBuilder.Append(c);
					break;
				}
			}
			else
			{
				stringBuilder.Append(text[j]);
			}
		}
		return stringBuilder.ToString();
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
