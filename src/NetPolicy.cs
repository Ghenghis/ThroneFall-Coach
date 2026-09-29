using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Neural policy inference — the offline-trained MLP from
    /// tools/train_policy.py (weights in agent/netpolicy.json), forward-pass
    /// only, no tensor dependency:
    ///
    ///   h = tanh(W1 x + b1); h = tanh(W2 h + b2)
    ///   logits = Wp h + bp     (11 mode scores)
    ///   value  = Wv h + bv
    ///
    /// Runs in SHADOW mode: every tick it predicts a mode and we log
    /// agreement/divergence with what the deterministic brain picked.
    /// Promotion to a real tier happens only after agreement proves out
    /// live — that's the honest path to letting learned weights steer.
    /// </summary>
    internal static class NetPolicy
    {
        public static bool Loaded;
        private static float[][] w1, w2, wp;
        private static float[] b1, b2, bp, wv, bv;
        private static readonly string[] Modes =
            { "Idle","CollectCoin","ReturnHome","HoldCastle","Engage",
              "EnterLevel","StartNight","SpendGold","ResolveUI",
              "PositionArmy","HeroDead" };
        private static int agree, disagree;
        public static int Agree => agree;
        public static int Disagree => disagree;
        public static float Ratio => (agree + disagree) > 0
            ? (float)agree / (agree + disagree) : 0f;
        private static float logAt;

        public static void Init()
        {
            try
            {
                var p = Path.Combine(Recorder.AgentDir, "netpolicy.json");
                if (!File.Exists(p)) return;
                string j = File.ReadAllText(p);
                w1 = Mat(j, "w1"); b1 = Vec(j, "b1");
                w2 = Mat(j, "w2"); b2 = Vec(j, "b2");
                wp = Mat(j, "wp"); bp = Vec(j, "bp");
                wv = Vec(j, "wv"); bv = Vec(j, "bv");
                Loaded = w1 != null && w2 != null && wp != null;
                if (Loaded)
                    Plugin.Log?.LogInfo(
                        $"[net] policy net loaded ({w1.Length}x{w1[0].Length}" +
                        $" -> {wp.Length} modes)");
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[net] load: {ex.Message}"); }
        }

        /// <summary>Feature vector — MUST mirror tools/episodes.py feats().</summary>
        public static float[] Features(in BotPerception.Snapshot s)
        {
            return new float[]
            {
                s.Balance / 500f,
                s.EnemyCount / 60f,
                s.AllyCount / 60f,
                s.FreeUnits / 60f,
                s.DoorCount > 0 ? (float)s.DoorsCovered / s.DoorCount : 0f,
                s.DoorCount / 16f,
                s.ArmyTarget / 80f,
                s.IsNight ? 1f : 0f,
                s.RedAlert ? 1f : 0f,
                Mathf.Clamp01(s.HeroHpPct),
                Mathf.Clamp01(s.CastleHpPct >= 0 ? s.CastleHpPct : 0.5f),
                s.Wave / 60f,
            };
        }

        /// <summary>Forward pass -> mode index.</summary>
        public static int Predict(float[] x, out float confidence)
        {
            confidence = 0f;
            if (!Loaded) return -1;
            var h1 = Act(Mul(w1, x, b1));
            var h2 = Act(Mul(w2, h1, b2));
            var logits = Mul(wp, h2, bp);
            // softmax argmax + confidence
            float max = float.MinValue;
            foreach (var l in logits) if (l > max) max = l;
            float sum = 0f;
            var ex = new float[logits.Length];
            for (int i = 0; i < logits.Length; i++)
            { ex[i] = Mathf.Exp(logits[i] - max); sum += ex[i]; }
            int arg = 0; float best = -1f;
            for (int i = 0; i < ex.Length; i++)
            { float pr = ex[i] / sum; if (pr > best) { best = pr; arg = i; } }
            confidence = best;
            return arg;
        }

        private static bool tried;
        /// <summary>Shadow check — call once per Decide tick.</summary>
        public static void Shadow(in BotPerception.Snapshot s, string pickedMode)
        {
            if (!tried) { tried = true; Init(); }
            if (!Loaded) return;
            int m = Predict(Features(in s), out float conf);
            if (m < 0) return;
            bool same = pickedMode == Modes[m];
            if (same) agree++; else disagree++;
            if (Time.unscaledTime > logAt)
            {
                logAt = Time.unscaledTime + 30f;
                Plugin.Log?.LogInfo(
                    $"[net] shadow: {agree} agree / {disagree} disagree" +
                    $" (last: net={Modes[m]}@{conf:0.##} bot={pickedMode})");
                try
                {
                    File.WriteAllText(
                        Path.Combine(Recorder.AgentDir, "netstats.json"),
                        "{\"agree\":" + agree + ",\"disagree\":" + disagree +
                        ",\"ratio\":" + ((agree + disagree) > 0
                            ? ((float)agree / (agree + disagree)).ToString("0.###",
                                System.Globalization.CultureInfo.InvariantCulture)
                            : "0") +
                        ",\"last_net\":\"" + Modes[m] +
                        "\",\"last_bot\":\"" + pickedMode +
                        "\",\"conf\":" + conf.ToString("0.###",
                            System.Globalization.CultureInfo.InvariantCulture) + "}");
                }
                catch { }
            }
        }

        public static string ModeName(int i) =>
            i >= 0 && i < Modes.Length ? Modes[i] : "?";

        private static float[] Mul(float[][] w, float[] x, float[] b)
        {
            var o = new float[w.Length];
            for (int i = 0; i < w.Length; i++)
            {
                float acc = b != null ? b[i] : 0f;
                var r = w[i];
                for (int j = 0; j < r.Length && j < x.Length; j++) acc += r[j] * x[j];
                o[i] = acc;
            }
            return o;
        }

        private static float[] Act(float[] x)
        {
            for (int i = 0; i < x.Length; i++) x[i] = (float)Math.Tanh(x[i]);
            return x;
        }

        private static float[][] Mat(string j, string key)
        {
            int i = j.IndexOf("\"" + key + "\"");
            if (i < 0) return null;
            int a = j.IndexOf('[', i);
            int depth = 0, end = a;
            for (int k = a; k < j.Length; k++)
            {
                if (j[k] == '[') depth++;
                if (j[k] == ']' && --depth == 0) { end = k; break; }
            }
            var rows = new List<float[]>();
            int rs = j.IndexOf('[', a + 1);
            while (rs >= 0 && rs < end)
            {
                int re = j.IndexOf(']', rs);
                rows.Add(ParseVec(j.Substring(rs + 1, re - rs - 1)));
                rs = j.IndexOf('[', re);
                if (rs > end) break;
            }
            return rows.ToArray();
        }

        private static float[] Vec(string j, string key)
        {
            int i = j.IndexOf("\"" + key + "\"");
            if (i < 0) return null;
            int a = j.IndexOf('[', i), b = j.IndexOf(']', a);
            return ParseVec(j.Substring(a + 1, b - a - 1));
        }

        private static float[] ParseVec(string csv)
        {
            var list = new List<float>();
            foreach (var tok in csv.Split(','))
                if (float.TryParse(tok.Trim(),
                    System.Globalization.NumberStyles.Float,
                    System.Globalization.CultureInfo.InvariantCulture,
                    out float v)) list.Add(v);
            return list.ToArray();
        }
    }
}
