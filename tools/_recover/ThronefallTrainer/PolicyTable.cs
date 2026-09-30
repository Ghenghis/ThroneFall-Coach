using System;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;

namespace ThronefallTrainer;

internal struct PolicyTable
{
	public Dictionary<string, float> knobs;

	public List<PolicyRule> rules;

	public int Version;

	public List<string> firedIds;

	public static PolicyTable Default()
	{
		return new PolicyTable
		{
			Version = 0,
			knobs = new Dictionary<string, float>
			{
				["coin_seek"] = 80f,
				["coin_seek_big"] = 40f,
				["big_wave_nwc"] = 30f,
				["kite_r_min"] = 9f,
				["kite_r_max"] = 14f,
				["kite_foe_pad"] = 2f,
				["pull_near"] = 4.5f,
				["pull_foe_pad"] = 1f,
				["pull_swarm"] = 2f,
				["retreat_hp"] = 0.5f,
				["orbit_spin"] = 0.7f,
				["orbit_arc"] = 1.9f,
				["home_radius"] = 14f,
				["army_anchor"] = 11f,
				["melee_pull"] = 5f
			},
			rules = new List<PolicyRule>()
		};
	}

	public float K(string name)
	{
		if (knobs == null || !knobs.TryGetValue(name, out var value))
		{
			return 0f;
		}
		return value;
	}

	public PolicyTable Resolved(in SnapshotData s)
	{
		PolicyTable result = this;
		result.firedIds = new List<string>();
		if (rules == null || rules.Count == 0)
		{
			return result;
		}
		result.knobs = new Dictionary<string, float>(knobs);
		Type typeFromHandle = typeof(SnapshotData);
		foreach (PolicyRule rule in rules)
		{
			FieldInfo field = typeFromHandle.GetField(rule.Field);
			if (field == null)
			{
				continue;
			}
			object value = field.GetValue(s);
			float a;
			try
			{
				if (!(value is bool))
				{
					a = Convert.ToSingle(value);
				}
				else
				{
					a = (((bool)value) ? 1f : 0f);
				}
			}
			catch
			{
				continue;
			}
			if (Cmp(a, rule.Op, rule.Value))
			{
				result.knobs[rule.Knob] = rule.Set;
				if (!result.firedIds.Contains(rule.Id))
				{
					result.firedIds.Add(rule.Id);
				}
			}
		}
		return result;
	}

	private static bool Cmp(float a, string op, float b)
	{
		return op switch
		{
			">" => a > b, 
			">=" => a >= b, 
			"<" => a < b, 
			"<=" => a <= b, 
			"==" => Math.Abs(a - b) < 1E-06f, 
			"!=" => Math.Abs(a - b) >= 1E-06f, 
			_ => false, 
		};
	}

	public static bool Parse(string text, ref PolicyTable table, out List<string> errors)
	{
		errors = new List<string>();
		PolicyTable policyTable = Default();
		policyTable.Version = table.Version + 1;
		HashSet<string> hashSet = new HashSet<string>(Array.ConvertAll(typeof(SnapshotData).GetFields(), (FieldInfo x) => x.Name));
		int num = 0;
		string[] array = text.Split('\n');
		for (int num2 = 0; num2 < array.Length; num2++)
		{
			string text2 = array[num2].Trim();
			if (text2.Length == 0 || text2.StartsWith("#"))
			{
				continue;
			}
			num++;
			if (text2.StartsWith("knob "))
			{
				string[] array2 = text2.Substring(5).Split('=');
				if (array2.Length != 2 || !IsKnob(array2[0].Trim()) || !float.TryParse(array2[1].Trim(), NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
				{
					errors.Add($"line {num}: bad knob '{text2}'");
				}
				else
				{
					policyTable.knobs[array2[0].Trim()] = result;
				}
				continue;
			}
			int num3 = text2.IndexOf("->", StringComparison.Ordinal);
			int num4 = text2.IndexOf('|');
			if (num4 <= 0 || num3 <= num4)
			{
				errors.Add($"line {num}: expected 'id | FIELD op v -> knob = v'");
				continue;
			}
			string text3 = text2.Substring(0, num4).Trim();
			string text4 = text2.Substring(num4 + 1, num3 - num4 - 1).Trim();
			string text5 = text2.Substring(num3 + 2).Trim();
			string[] array3 = text4.Split(new char[1] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
			string[] array4 = text5.Split('=');
			if (text3.Length == 0 || text3.Length > 32)
			{
				errors.Add($"line {num}: bad rule id");
				continue;
			}
			if (policyTable.rules.Count >= 32)
			{
				errors.Add($"line {num}: rule limit 32");
				continue;
			}
			if (array3.Length != 3 || !hashSet.Contains(array3[0]) || (!(array3[1] == ">") && !(array3[1] == ">=") && !(array3[1] == "<") && !(array3[1] == "<=") && !(array3[1] == "==") && !(array3[1] == "!=")) || !float.TryParse(array3[2], NumberStyles.Float, CultureInfo.InvariantCulture, out var result2) || Math.Abs(result2) > 1000000f)
			{
				errors.Add($"line {num}: bad condition '{text4}'");
				continue;
			}
			if (array4.Length != 2 || !IsKnob(array4[0].Trim()) || !float.TryParse(array4[1].Trim(), NumberStyles.Float, CultureInfo.InvariantCulture, out var result3) || Math.Abs(result3) > 1000000f)
			{
				errors.Add($"line {num}: bad effect '{text5}'");
				continue;
			}
			policyTable.rules.Add(new PolicyRule
			{
				Id = text3,
				Field = array3[0],
				Op = array3[1],
				Value = result2,
				Knob = array4[0].Trim(),
				Set = result3
			});
		}
		if (errors.Count > 0)
		{
			return false;
		}
		table = policyTable;
		return true;
	}

	private static bool IsKnob(string k)
	{
		if (k.Length == 0 || k.Length > 24)
		{
			return false;
		}
		foreach (char c in k)
		{
			if (!char.IsLetterOrDigit(c) && c != '_')
			{
				return false;
			}
		}
		return true;
	}
}
