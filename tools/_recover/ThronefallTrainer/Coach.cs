using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using BepInEx.Logging;
using UnityEngine;

namespace ThronefallTrainer;

internal static class Coach
{
	public static bool Enabled;

	public static string Url = "http://127.0.0.1:1234/v1/chat/completions";

	public static string Model = "kat-coder-v2.5-dev-apex";

	public static string ApiKey = "";

	public static float MinIntervalS = 45f;

	public static int MaxTokens = 900;

	public static bool VisionEnabled;

	public static string VisionModel = "qwen3-vl-2b-thinking-abliterated";

	public static int SquadSize;

	public static int ReserveSize;

	public static int EscortSize;

	public static int ArmyTargetFloor;

	public static string BuildFocus = "";

	public static string HeroPosture = "";

	public static string LastAdvice = "";

	public static float LastAdviceAt;

	public static int CallsMade;

	public static int TokensUsed;

	public static volatile bool Busy;

	public static bool LiveShot;

	public static float LiveShotEvery = 2f;

	private static float nextLiveShot;

	private static float lastCallAt = -999f;

	private static Object hostRef;

	private const string SysPrompt = "You are Grandmaster, the strategy advisor for a Thronefall autopilot bot. The bot fights with UNITS, not the hero: it posts squads on enemy corridors outside the walls, keeps a castle reserve, and the hero builds/farms and only fights as last resort. No cheats. Given the telemetry digest, return ONLY a JSON object: {\"squad_size\":int,\"reserve_size\":int,\"escort_size\":int,\"army_target\":int,\"build_focus\":\"military|income|defense|balanced\",\"hero_posture\":\"builder|fighter\",\"note\":\"<one sentence>\"}.";

	private static float nextCmdPoll;

	private static string lastCmdText = "";

	public static bool NightCallRequested;

	private static readonly HashSet<string> KnownKeys = new HashSet<string> { "squad_size", "reserve_size", "escort_size", "army_target", "build_focus", "hero_posture", "night_call", "note" };

	private static volatile int runGen;

	public static void Init(MonoBehaviour h)
	{
		hostRef = (Object)(object)h;
	}

	public static void PerFrame()
	{
		if (LiveShot && Time.unscaledTime >= nextLiveShot)
		{
			nextLiveShot = Time.unscaledTime + LiveShotEvery;
			try
			{
				Texture2D val = ScreenCapture.CaptureScreenshotAsTexture();
				if ((Object)(object)val != (Object)null)
				{
					string text = Path.Combine(Recorder.AgentDir, "live.png");
					string text2 = text + ".tmp";
					File.WriteAllBytes(text2, ImageConversion.EncodeToPNG(val));
					if (File.Exists(text))
					{
						File.Delete(text);
					}
					File.Move(text2, text);
					Object.Destroy((Object)(object)val);
				}
			}
			catch (Exception)
			{
			}
		}
		if (Time.unscaledTime >= nextCmdPoll)
		{
			nextCmdPoll = Time.unscaledTime + 4f;
			PollCommands();
		}
	}

	private static void PollCommands()
	{
		try
		{
			string path = Path.Combine(Recorder.AgentDir, "coach-commands.json");
			if (File.Exists(path))
			{
				string text = File.ReadAllText(path);
				if (!(text == lastCmdText))
				{
					Apply(text, "user-cmd", Time.unscaledTime);
					lastCmdText = text;
				}
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)("[coach] cmd poll: " + ex.Message));
			}
		}
	}

	public static void Advise(string trigger, string digestJson)
	{
		if (!Enabled || hostRef == (Object)null || Busy || Time.unscaledTime - lastCallAt < MinIntervalS)
		{
			return;
		}
		Busy = true;
		float callNow = Time.unscaledTime;
		int gen = runGen;
		try
		{
			Thread thread = new Thread(() =>
			{
				Call(trigger, digestJson, callNow, gen);
			});
			thread.IsBackground = true;
			thread.Start();
			lastCallAt = Time.unscaledTime;
		}
		catch
		{
			Busy = false;
		}
	}

	private static void Call(string trigger, string digest, float callNow, int gen)
	{
		try
		{
			string s = "{\"model\":\"" + Esc(Model ?? "") + "\",\"stream\":false,\"max_tokens\":" + MaxTokens + ",\"temperature\":0.3,\"messages\":[{\"role\":\"system\",\"content\":\"" + Esc("You are Grandmaster, the strategy advisor for a Thronefall autopilot bot. The bot fights with UNITS, not the hero: it posts squads on enemy corridors outside the walls, keeps a castle reserve, and the hero builds/farms and only fights as last resort. No cheats. Given the telemetry digest, return ONLY a JSON object: {\"squad_size\":int,\"reserve_size\":int,\"escort_size\":int,\"army_target\":int,\"build_focus\":\"military|income|defense|balanced\",\"hero_posture\":\"builder|fighter\",\"note\":\"<one sentence>\"}.") + "\"},{\"role\":\"user\",\"content\":\"" + Esc("trigger=" + trigger + "\n" + digest) + "\"}]}";
			HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(Url);
			httpWebRequest.Method = "POST";
			httpWebRequest.ContentType = "application/json";
			httpWebRequest.Timeout = 60000;
			if (!string.IsNullOrEmpty(ApiKey))
			{
				httpWebRequest.Headers["Authorization"] = "Bearer " + ApiKey;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			httpWebRequest.ContentLength = bytes.Length;
			using (Stream stream = httpWebRequest.GetRequestStream())
			{
				stream.Write(bytes, 0, bytes.Length);
			}
			string input;
			using (HttpWebResponse httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse())
			{
				using StreamReader streamReader = new StreamReader(httpWebResponse.GetResponseStream());
				input = streamReader.ReadToEnd();
			}
			CallsMade++;
			Match match = Regex.Match(input, "\"total_tokens\"\\s*:\\s*(\\d+)");
			if (match.Success)
			{
				TokensUsed += int.Parse(match.Groups[1].Value);
			}
			Match match2 = Regex.Match(input, "\"content\"\\s*:\\s*\"((?:[^\"\\\\]|\\\\.)*)\"");
			if (match2.Success)
			{
				if (gen != runGen)
				{
					ManualLogSource log = Plugin.Log;
					if (log != null)
					{
						log.LogInfo((object)"[coach] stale-run advisory discarded");
					}
				}
				else
				{
					Apply(Unesc(match2.Groups[1].Value), trigger, callNow);
				}
			}
			else
			{
				ManualLogSource log2 = Plugin.Log;
				if (log2 != null)
				{
					log2.LogWarning((object)"[coach] no content in response");
				}
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log3 = Plugin.Log;
			if (log3 != null)
			{
				log3.LogWarning((object)("[coach] " + trigger + " call failed: " + ex.Message));
			}
		}
		Busy = false;
	}

	private static void Apply(string content, string trigger, float callNow)
	{
		int num = content.IndexOf('{');
		int num2 = content.LastIndexOf('}');
		if (num < 0 || num2 <= num)
		{
			ManualLogSource log = Plugin.Log;
			if (log != null)
			{
				log.LogWarning((object)"[coach] advice not JSON");
			}
			return;
		}
		string text = content.Substring(num, num2 - num + 1);
		if (TryNum(text, "squad_size", out var v))
		{
			SquadSize = ClampInt(v, 0, 12);
		}
		if (TryNum(text, "reserve_size", out var v2))
		{
			ReserveSize = ClampInt(v2, 0, 16);
		}
		if (TryNum(text, "escort_size", out var v3))
		{
			EscortSize = ClampInt(v3, 0, 8);
		}
		if (TryNum(text, "army_target", out var v4))
		{
			ArmyTargetFloor = ClampInt(v4, 0, 120);
		}
		if (TryStr(text, "build_focus", out var v5))
		{
			BuildFocus = v5;
		}
		if (TryStr(text, "hero_posture", out var v6))
		{
			HeroPosture = v6;
		}
		if (TryStr(text, "note", out var v7))
		{
			LastAdvice = v7;
		}
		if (TryBool(text, "night_call", out var v8) & v8)
		{
			NightCallRequested = true;
		}
		List<string> list = new List<string>();
		foreach (Match item in new Regex("\"(\\w+)\"\\s*:").Matches(text))
		{
			if (!KnownKeys.Contains(item.Groups[1].Value))
			{
				list.Add(item.Groups[1].Value);
			}
		}
		if (list.Count > 0)
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[coach] unhandled keys: " + string.Join(",", list)));
			}
		}
		LastAdviceAt = callNow;
		ManualLogSource log3 = Plugin.Log;
		if (log3 != null)
		{
			log3.LogInfo((object)($"[coach] {trigger} -> squad={SquadSize} reserve={ReserveSize} " + $"escort={EscortSize} army>={ArmyTargetFloor} focus={BuildFocus} " + "posture=" + HeroPosture + " :: " + LastAdvice));
		}
	}

	private static int Num(string j, string key)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
		if (!match.Success)
		{
			return 0;
		}
		return int.Parse(match.Groups[1].Value);
	}

	private static string Str(string j, string key)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
		if (!match.Success)
		{
			return "";
		}
		return match.Groups[1].Value;
	}

	private static bool TryBool(string j, string key, out bool v)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*(true|false)");
		v = match.Success && match.Groups[1].Value == "true";
		return match.Success;
	}

	private static bool TryNum(string j, string key, out int v)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
		v = (match.Success ? int.Parse(match.Groups[1].Value) : 0);
		return match.Success;
	}

	private static bool TryStr(string j, string key, out string v)
	{
		Match match = Regex.Match(j, "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
		v = (match.Success ? match.Groups[1].Value : null);
		return match.Success;
	}

	public static void ResetRun()
	{
		SquadSize = 0;
		ReserveSize = 0;
		EscortSize = 0;
		ArmyTargetFloor = 0;
		BuildFocus = "";
		HeroPosture = "";
		NightCallRequested = false;
		runGen++;
		lastCmdText = "";
	}

	public static void AnalyzeScreenshot(byte[] png, string context)
	{
		if (!VisionEnabled || Busy)
		{
			return;
		}
		Busy = true;
		string b64 = Convert.ToBase64String(png);
		int gen = runGen;
		try
		{
			Thread thread = new Thread(() =>
			{
				VisionCall(b64, context, gen);
			});
			thread.IsBackground = true;
			thread.Start();
		}
		catch
		{
			Busy = false;
		}
	}

	private static void VisionCall(string b64png, string context, int gen)
	{
		try
		{
			string s = "{\"model\":\"" + Esc(VisionModel ?? "") + "\",\"stream\":false,\"max_tokens\":600,\"temperature\":0.3,\"messages\":[{\"role\":\"user\",\"content\":[{{\"type\":\"text\",\"text\":\"" + Esc("Thronefall autopilot just failed/survived a wave. Describe: where enemies are, where units are posted, what the hero is doing, what went wrong, one fix. " + context) + "\"},{\"type\":\"image_url\",\"image_url\":{\"url\":\"data:image/png;base64," + b64png + "\"}}]}]}";
			HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(Url);
			httpWebRequest.Method = "POST";
			httpWebRequest.ContentType = "application/json";
			httpWebRequest.Timeout = 90000;
			if (!string.IsNullOrEmpty(ApiKey))
			{
				httpWebRequest.Headers["Authorization"] = "Bearer " + ApiKey;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			httpWebRequest.ContentLength = bytes.Length;
			using (Stream stream = httpWebRequest.GetRequestStream())
			{
				stream.Write(bytes, 0, bytes.Length);
			}
			string input;
			using (HttpWebResponse httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse())
			{
				using StreamReader streamReader = new StreamReader(httpWebResponse.GetResponseStream());
				input = streamReader.ReadToEnd();
			}
			Match match = Regex.Match(input, "\"content\"\\s*:\\s*\"((?:[^\"\\\\]|\\\\.)*)\"");
			if (match.Success && gen == runGen)
			{
				LastAdvice = Unesc(match.Groups[1].Value);
				ManualLogSource log = Plugin.Log;
				if (log != null)
				{
					log.LogInfo((object)("[coach-vision] " + LastAdvice));
				}
			}
		}
		catch (Exception ex)
		{
			ManualLogSource log2 = Plugin.Log;
			if (log2 != null)
			{
				log2.LogWarning((object)("[coach-vision] failed: " + ex.Message));
			}
		}
		Busy = false;
	}

	private static int ClampInt(int v, int lo, int hi)
	{
		if (v >= lo)
		{
			if (v <= hi)
			{
				return v;
			}
			return hi;
		}
		return lo;
	}

	private static string Esc(string s)
	{
		StringBuilder stringBuilder = new StringBuilder(s.Length + 8);
		foreach (char c in s)
		{
			if (c == '\\')
			{
				stringBuilder.Append("\\\\");
			}
			else if (c == '"')
			{
				stringBuilder.Append("\\\"");
			}
			else if (c == '\n')
			{
				stringBuilder.Append("\\n");
			}
			else if (c != '\r')
			{
				if (c < ' ')
				{
					StringBuilder stringBuilder2 = stringBuilder.Append("\\u");
					int num = c;
					stringBuilder2.Append(num.ToString("x4"));
				}
				else
				{
					stringBuilder.Append(c);
				}
			}
		}
		return stringBuilder.ToString();
	}

	private static string Unesc(string s)
	{
		StringBuilder stringBuilder = new StringBuilder(s.Length);
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] == '\\' && i + 1 < s.Length)
			{
				switch (s[i + 1])
				{
				case 'n':
					stringBuilder.Append('\n');
					i++;
					continue;
				case 't':
					stringBuilder.Append('\t');
					i++;
					continue;
				case 'r':
					stringBuilder.Append('\r');
					i++;
					continue;
				case '"':
					stringBuilder.Append('"');
					i++;
					continue;
				case '\\':
					stringBuilder.Append('\\');
					i++;
					continue;
				case '/':
					stringBuilder.Append('/');
					i++;
					continue;
				case 'u':
				{
					if (i + 5 < s.Length && int.TryParse(s.Substring(i + 2, 4), NumberStyles.HexNumber, null, out var result))
					{
						stringBuilder.Append((char)result);
						i += 5;
						continue;
					}
					break;
				}
				}
			}
			stringBuilder.Append(s[i]);
		}
		return stringBuilder.ToString();
	}
}
