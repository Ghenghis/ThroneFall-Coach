using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Vision-free spatial learning. Every stuck strike / unstick bumps the
    /// 2 m cell the hero is pinned in; hot cells (score >= 2) are avoided when
    /// choosing detours and are excluded as detour end-points. Scores persist
    /// to agent\spnav.txt so the same wall is never re-learned next run, and
    /// decay by 1 per new match so stale knowledge (a wall that got built
    /// over, a door that opened) fades instead of fencing the map forever.
    /// </summary>
    internal static class SpatialMemory
    {
        const float Cell = 2f;
        static readonly Dictionary<string, Dictionary<long, int>> grid = new Dictionary<string, Dictionary<long, int>>();
        static bool loaded, dirty;
        static float lastSave;
        public static int Bumps;

        static string FilePath => Path.Combine(Recorder.AgentDir, "spnav.txt");
        static long Key(Vector3 p) => ((long)Mathf.FloorToInt(p.x / Cell) << 32) ^ (uint)Mathf.FloorToInt(p.z / Cell);

        static Dictionary<long, int> Scene(string scene)
        {
            Load();
            scene = scene ?? "";
            if (!grid.TryGetValue(scene, out var g)) grid[scene] = g = new Dictionary<long, int>();
            return g;
        }

        static void Load()
        {
            if (loaded) return;
            loaded = true;
            try
            {
                if (!File.Exists(FilePath)) return;
                foreach (var line in File.ReadAllLines(FilePath))
                {
                    var p = line.Split('|');
                    if (p.Length != 3 || !long.TryParse(p[1], out long k) || !int.TryParse(p[2], out int v)) continue;
                    if (!grid.TryGetValue(p[0], out var g)) grid[p[0]] = g = new Dictionary<long, int>();
                    g[k] = v;
                }
            }
            catch { }
        }

        public static void Bump(string scene, Vector3 p, int amt = 1)
        {
            var g = Scene(scene);
            long k = Key(p);
            g.TryGetValue(k, out int v);
            g[k] = Math.Min(v + amt, 12);
            Bumps++; dirty = true;
            MaybeSave();
        }

        public static int ScoreAt(string scene, Vector3 p)
        {
            Scene(scene).TryGetValue(Key(p), out int v);
            return v;
        }

        /// <summary>Hot = pinned here twice or more (this cell or a neighbour).</summary>
        public static bool Hot(string scene, Vector3 p)
        {
            var g = Scene(scene);
            int best = 0;
            for (int dx = -1; dx <= 1; dx++)
                for (int dz = -1; dz <= 1; dz++)
                    if (g.TryGetValue(Key(p + new Vector3(dx * Cell, 0f, dz * Cell)), out int v) && v > best) best = v;
            return best >= 2;
        }

        public static int HotCount(string scene)
        {
            int n = 0;
            foreach (var v in Scene(scene).Values) if (v >= 2) n++;
            return n;
        }

        /// <summary>New match: every cell cools by 1 (stale walls fade).</summary>
        public static void Decay(string scene)
        {
            var g = Scene(scene);
            var dead = new List<long>();
            var keys = new List<long>(g.Keys);
            foreach (var k in keys) { if (--g[k] <= 0) dead.Add(k); }
            foreach (var k in dead) g.Remove(k);
            dirty = true; MaybeSave(true);
        }

        static void MaybeSave(bool force = false)
        {
            if (!dirty || (!force && Time.unscaledTime - lastSave < 20f)) return;
            lastSave = Time.unscaledTime; dirty = false;
            try
            {
                var sb = new StringBuilder();
                foreach (var sc in grid)
                    foreach (var c in sc.Value) sb.Append(sc.Key).Append('|').Append(c.Key).Append('|').Append(c.Value).Append('\n');
                File.WriteAllText(FilePath, sb.ToString());
            }
            catch { }
        }
    }
}
