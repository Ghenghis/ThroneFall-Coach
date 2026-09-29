using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Episodic memory — things the bot tried that failed, remembered
    /// FOREVER per scene (not just the in-run ignore timers):
    ///
    ///   - build slots that stalled/wedged (ParkSlot events)
    ///   - spots the pathing gave up on
    ///
    /// Stored as "scene|gx,gz|reason" rows in agent/mishaps.json. The build
    /// scanner skips parked cells outright — the same mistake is never
    /// retried. Delete the file (or a row) to unlearn.
    /// </summary>
    internal static class Memory
    {
        private static readonly HashSet<string> parked = new HashSet<string>();
        private static readonly HashSet<string> parkedWhy = new HashSet<string>();
        private static string file;
        private static bool loaded;

        private static void EnsureInit()
        {
            if (loaded) return;
            loaded = true;
            try { file = Path.Combine(Recorder.AgentDir, "mishaps.json"); Load(); }
            catch { }
        }

        private static string Cell(Vector3 p) =>
            $"{Mathf.RoundToInt(p.x / 4f)},{Mathf.RoundToInt(p.z / 4f)}";

        /// <summary>Is this slot position remembered as bad?</summary>
        public static bool IsParked(string scene, Vector3 pos)
        {
            EnsureInit();
            return parked.Contains(scene + "|" + Cell(pos));
        }

        /// <summary>Record a mishap; persists immediately.</summary>
        public static void Park(string scene, Vector3 pos, string why)
        {
            EnsureInit();
            string key = scene + "|" + Cell(pos);
            if (parked.Add(key))
            {
                parkedWhy.Add(key + "|" + (why ?? "?"));
                Save();
                Plugin.Log?.LogInfo($"[memory] parked '{key}' ({why}) — never retrying");
            }
        }

        public static int Count => parked.Count;

        private static void Save()
        {
            try
            {
                var sb = new System.Text.StringBuilder("[\n");
                bool first = true;
                foreach (var w in parkedWhy)
                {
                    if (!first) sb.Append(",\n");
                    first = false;
                    sb.Append("  \"").Append(w).Append('"');
                }
                sb.Append("\n]\n");
                File.WriteAllText(file, sb.ToString());
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[memory] save: {ex.Message}"); }
        }

        private static void Load()
        {
            try
            {
                if (!File.Exists(file)) return;
                foreach (System.Text.RegularExpressions.Match m in
                    System.Text.RegularExpressions.Regex.Matches(
                        File.ReadAllText(file), "\"([^\"]+)\""))
                {
                    string row = m.Groups[1].Value;
                    var parts = row.Split('|');
                    if (parts.Length >= 2)
                    {
                        parked.Add(parts[0] + "|" + parts[1]);
                        parkedWhy.Add(row);
                    }
                }
                if (parked.Count > 0)
                    Plugin.Log?.LogInfo($"[memory] {parked.Count} mishaps remembered");
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[memory] load: {ex.Message}"); }
        }
    }
}
