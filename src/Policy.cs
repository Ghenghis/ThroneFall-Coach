using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Real reinforcement learning — a persistent Q-table over the bot's
    /// strategic choices (build focus, squad size, night-call timing).
    ///
    ///   state:  scene | wave-bucket | ally-bucket | door-coverage | red | broke
    ///   action: one of the discrete options per decision point
    ///   reward: +10 victory, -10 defeat, +castle-hp-saved*5, -0.4/breach,
    ///           +0.2/night survived
    ///
    /// Epsilon-greedy: exploits the learned best action 90 %, explores 10 % —
    /// that IS the trial-and-error the operator asked for. The table is
    /// saved to agent/policy.json — the bot's weights — and survives every
    /// run. Coach/strategy overrides still outrank learned choices; the
    /// table learns the DEFAULT, the advisors steer it.
    /// </summary>
    internal static class Policy
    {
        public static bool Enabled = true;
        public static float Epsilon = 0.10f;      // exploration rate
        public static float LearningRate = 0.3f;
        public static float Discount = 0.9f;

        private static readonly Dictionary<string, Dictionary<string, float>> Q =
            new Dictionary<string, Dictionary<string, float>>();
        private static readonly List<(string s, string a)> traj =
            new List<(string, string)>();
        private static float pendingReward;
        private static readonly System.Random rng = new System.Random();
        private static string file;
        private static float saveAt;
        public static int Decisions, Updates;
        public static int States => Q.Count;
        public static int Cells
        {
            get { int n = 0; foreach (var r in Q.Values) n += r.Count; return n; }
        }

        public static void Init()
        {
            file = Path.Combine(Recorder.AgentDir, "policy.json");
            Load();
        }

        private static void Ensure()
        {
            if (file == null) Init();
        }

        /// <summary>Cheap pick — evaluates the table (ε-greedy) but records
        /// NOTHING. Safe to call every perception tick; the trajectory only
        /// grows through Commit, when the chosen action is actually used.</summary>
        public static string Eval(string point, string[] options,
                                  string stateKey)
        {
            Ensure();
            if (!Enabled || options == null || options.Length == 0)
                return options != null && options.Length > 0 ? options[0] : "";
            string key = point + "|" + stateKey;
            return rng.NextDouble() < Epsilon
                ? options[rng.Next(options.Length)]
                : Best(key, options);
        }

        /// <summary>Record a used decision + SARSA-update the previous one.</summary>
        public static void Commit(string point, string action, string stateKey,
                                  string[] options)
        {
            string key = point + "|" + stateKey;
            traj.Add((key, action));
            Decisions++;
            if (traj.Count > 1)
            {
                var (ps, pa) = traj[traj.Count - 2];
                float bestNext = BestQ(key, options);
                Update(ps, pa, pendingReward + Discount * bestNext);
                pendingReward = 0f;
            }
        }

        /// <summary>Eval+Commit for callers that decide once per call.</summary>
        public static string Choose(string point, string[] options,
                                    string stateKey)
        {
            string pick = Eval(point, options, stateKey);
            Commit(point, pick, stateKey, options);
            return pick;
        }

        /// <summary>Reward shaping — accumulate until the next decision
        /// backup, then it folds into the previous (s,a) update.</summary>
        public static void Reward(float r)
        {
            pendingReward += r;
        }

        /// <summary>New run — an abandoned trajectory (scene unloaded without
        /// MatchEnd) used to leak into the next run's learning window.</summary>
        public static void BeginRun()
        {
            traj.Clear();
            pendingReward = 0f;
        }

        /// <summary>Match end: propagate outcome back along the trajectory
        /// (discounted), then flush to disk.</summary>
        public static void MatchEnd(bool victory, float castleHpFrac, int breaches)
        {
            float r = (victory ? 10f : -10f) + castleHpFrac * 5f - breaches * 0.4f
                      + pendingReward;        // folded pulses — a defeat mid-day
                                             // used to drop Reward() entirely
            for (int i = traj.Count - 1; i >= 0; i--)
            {
                var (s, a) = traj[i];
                Update(s, a, r);
                r *= Discount;
            }
            traj.Clear();
            pendingReward = 0f;
            Save();
            Plugin.Log?.LogInfo(
                $"[policy] match end {(victory ? "VICTORY" : "defeat")}: " +
                $"reward backed over {Decisions} decisions, table={Q.Count} states");
        }

        /// <summary>Partial-night reward pulse (wave survived, breach).</summary>
        public static void Pulse(float r) { Reward(r); }

        public static string Best(string key, string[] options)
        {
            string pick = options[0]; float best = float.MinValue;
            foreach (var o in options)
            {
                float q = Get(key, o);
                if (q > best) { best = q; pick = o; }
            }
            return pick;
        }

        public static float BestQ(string key, string[] options)
        {
            float b = float.MinValue;
            foreach (var o in options) { float q = Get(key, o); if (q > b) b = q; }
            return b == float.MinValue ? 0f : b;
        }

        private static float Get(string key, string action)
        {
            return Q.TryGetValue(key, out var row) &&
                   row.TryGetValue(action, out float v) ? v : 0f;
        }

        private static void Update(string key, string action, float target)
        {
            // NaN poison: a single non-finite reward wrote "NaN" into the
            // file (unparseable on reload → cell vanished) AND made every
            // future Best() compare false → policy degenerated to options[0].
            if (float.IsNaN(target) || float.IsInfinity(target)) return;
            if (!Q.TryGetValue(key, out var row))
                Q[key] = row = new Dictionary<string, float>();
            float old = row.TryGetValue(action, out float v) ? v : 0f;
            float next = old + LearningRate * (target - old);
            // Finite input can still overflow in the update (Q-learning with
            // a huge target) — a written Infinity poisons the cell on save.
            if (float.IsNaN(next) || float.IsInfinity(next)) return;
            row[action] = next;
            Updates++;
            if (Time.unscaledTime > saveAt)
            { saveAt = Time.unscaledTime + 15f; Save(); DumpStats(); }
        }

        /// <summary>Dashboard-visible learner stats (chat /metrics reads it).</summary>
        private static void DumpStats()
        {
            try
            {
                int nonzero = 0; float qSum = 0f;
                foreach (var row in Q.Values)
                    foreach (var v in row.Values)
                    { nonzero++; qSum += Mathf.Abs(v); }
                Recorder.WriteAtomic(Path.Combine(Recorder.AgentDir, "policystats.json"),
                    "{\"states\":" + Q.Count + ",\"cells\":" + nonzero +
                    ",\"decisions\":" + Decisions + ",\"updates\":" + Updates +
                    ",\"mean_abs_q\":" + (nonzero > 0
                        ? (qSum / nonzero).ToString("0.###",
                            System.Globalization.CultureInfo.InvariantCulture)
                        : "0") +
                    ",\"epsilon\":" + Epsilon.ToString("0.###",
                        System.Globalization.CultureInfo.InvariantCulture) + "}");
            }
            catch { }
        }

        /// <summary>Compact stats for the coach digest / chat UI.</summary>
        public static string Stats()
        {
            int nonzero = 0;
            foreach (var row in Q.Values) nonzero += row.Count;
            return $"{{\"states\":{Q.Count},\"cells\":{nonzero}," +
                   $"\"decisions\":{Decisions},\"updates\":{Updates}}}";
        }

        public static string Dump(string point)
        {
            var sb = new System.Text.StringBuilder();
            foreach (var kv in Q)
                if (kv.Key.StartsWith(point))
                {
                    sb.Append(kv.Key).Append(" -> ");
                    foreach (var a in kv.Value)
                        sb.Append(a.Key).Append('=')
                          .Append(a.Value.ToString("0.##")).Append(' ');
                    sb.Append('\n');
                }
            return sb.ToString();
        }

        // JSON string escape/unescape for keys — state keys are composed of
        // scene names and tags; a raw " or \\ wrote corrupt JSON that the
        // loader regex then silently skipped (cell loss per write).
        private static string Js(string s) =>
            string.IsNullOrEmpty(s) ? "" :
            s.Replace("\\", "\\\\").Replace("\"", "\\\"");
        private static string UnJs(string s)
        {
            if (string.IsNullOrEmpty(s) || s.IndexOf('\\') < 0) return s;
            var b = new System.Text.StringBuilder(s.Length);
            for (int i = 0; i < s.Length; i++)
            {
                if (s[i] == '\\' && i + 1 < s.Length)
                {
                    char e = s[++i];
                    b.Append(e == 'n' ? '\n' : e == 't' ? '\t' : e == 'r' ? '\r' : e);
                }
                else b.Append(s[i]);
            }
            return b.ToString();
        }

        private static void Save()
        {
            try
            {
                var sb = new System.Text.StringBuilder("{");
                bool first = true;
                foreach (var kv in Q)
                {
                    if (!first) sb.Append(',');
                    first = false;
                    sb.Append('\n').Append('"').Append(Js(kv.Key)).Append("\":{");
                    bool f2 = true;
                    foreach (var a in kv.Value)
                    {
                        if (!f2) sb.Append(',');
                        f2 = false;
                        sb.Append('"').Append(Js(a.Key)).Append("\":")
                          .Append(a.Value.ToString("0.####",
                              System.Globalization.CultureInfo.InvariantCulture));
                    }
                    sb.Append('}');
                }
                sb.Append("\n}");
                Recorder.WriteAtomic(file, sb.ToString());
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[policy] save: {ex.Message}"); }
        }

        private static void Load()
        {
            try
            {
                if (!File.Exists(file)) return;
                string j = File.ReadAllText(file);
                foreach (System.Text.RegularExpressions.Match m in
                    System.Text.RegularExpressions.Regex.Matches(
                        j, "\"([^\"]+)\"\\s*:\\s*\\{([^}]*)\\}"))
                {
                    var row = new Dictionary<string, float>();
                    foreach (System.Text.RegularExpressions.Match a in
                        System.Text.RegularExpressions.Regex.Matches(
                            m.Groups[2].Value, "\"([^\"]+)\"\\s*:\\s*(-?[\\d.eE+-]+)"))
                    {
                        // TryParse per cell — one malformed token used to
                        // abort the WHOLE table load mid-file.
                        if (float.TryParse(a.Groups[2].Value,
                                System.Globalization.NumberStyles.Float,
                                System.Globalization.CultureInfo.InvariantCulture,
                                out float av) && !float.IsNaN(av) && !float.IsInfinity(av))
                            row[UnJs(a.Groups[1].Value)] = av;
                    }
                    Q[UnJs(m.Groups[1].Value)] = row;
                }
                Plugin.Log?.LogInfo($"[policy] loaded {Q.Count} learned states");
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[policy] load: {ex.Message}"); }
        }
    }
}
