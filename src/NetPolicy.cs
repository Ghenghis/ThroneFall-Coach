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
                // Verify EVERY tensor is real — a partial load (w1 set, w2
                // null) used to flip Loaded and crash inside the forward pass.
                Loaded = w1 != null && w1.Length > 0 && w1[0] != null &&
                         w2 != null && wp != null && wp.Length > 0;
                // Dimension mismatch = a net trained on a different feature
                // count — its silent-truncated dot products produced
                // confident garbage disagree data. Refuse to load.
                if (Loaded && w1[0].Length != Features(default(BotPerception.Snapshot)).Length)
                {
                    Plugin.Log?.LogWarning(
                        $"[net] feature dim mismatch: w1={w1[0].Length} vs features=" +
                        $"{Features(default(BotPerception.Snapshot)).Length} — net NOT loaded");
                    Loaded = false;
                }
                // FULL chain check: hidden/output layer boundaries must line
                // up end-to-end or Mul silently truncates to wrong dims.
                if (Loaded)
                {
                    bool ok =
                        w2.Length > 0 && w2[0] != null && w2[0].Length == w1.Length &&
                        b1 != null && b1.Length == w1.Length &&
                        b2 != null && b2.Length == w2.Length &&
                        wp[0] != null && wp[0].Length == w2.Length &&
                        bp != null && bp.Length == wp.Length &&
                        wp.Length == Modes.Length;
                    if (!ok)
                    {
                        Plugin.Log?.LogWarning(
                            $"[net] layer dims broken: w1 {w1.Length}x{w1[0].Length} " +
                            $"w2 {w2.Length}x{(w2[0] != null ? w2[0].Length : -1)} " +
                            $"wp {wp.Length}x{(wp[0] != null ? wp[0].Length : -1)} " +
                            $"(need {Modes.Length} outputs) — net NOT loaded");
                        Loaded = false;
                    }
                }
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
                // Mirror episodes.py feats() — day progress + incoming wave
                // pressure (fixes constant StartNight votes during day).
                s.DayTimeLeft / 600f,
                s.NextWaveCount / 60f,
                s.ArmyTarget > 0 ? Mathf.Clamp01((float)s.AllyCount / s.ArmyTarget) : 0f,
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
            if (logits.Length == 0) return -1;   // malformed net → no silent argmax
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
        private static float netPollAt;
        private static DateTime netMtime;
        /// <summary>Shadow check — call once per Decide tick.</summary>
        public static void Shadow(in BotPerception.Snapshot s, string pickedMode)
        {
            if (!tried) { tried = true; Init(); }
            // Sidecar can drop a fresh netpolicy.json mid-session — the old
            // tried-once gate left the stale model shadowing forever.
            if (Time.unscaledTime > netPollAt)
            {
                netPollAt = Time.unscaledTime + 30f;
                try
                {
                    var p = Path.Combine(Recorder.AgentDir, "netpolicy.json");
                    var mt = File.Exists(p) ? File.GetLastWriteTimeUtc(p) : default;
                    // Latch the mtime only on a SUCCESSFUL load — a torn
                    // sidecar write used to consume the mtime and the retry
                    // window then skipped the fix for 30 s.
                    if (mt != netMtime) { Init(); if (Loaded) netMtime = mt; }
                }
                catch { }
            }
            if (!Loaded) return;
            int m = Predict(Features(in s), out float conf);
            if (m < 0 || m >= Modes.Length) return;   // OOB argmax → per-tick crash
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
                    Recorder.WriteAtomic(Path.Combine(Recorder.AgentDir, "netstats.json"),
                        "{\"agree\":" + agree + ",\"disagree\":" + disagree +
                        ",\"ratio\":" + ((agree + disagree) > 0
                            ? ((float)agree / (agree + disagree)).ToString("0.###",
                                System.Globalization.CultureInfo.InvariantCulture)
                            : "0") +
                        ",\"last_net\":" + BotPerception.JsonStr(Modes[m]) +
                        ",\"last_bot\":" + BotPerception.JsonStr(pickedMode) +
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
                float acc = b != null && i < b.Length ? b[i] : 0f;   // OOB bias → per-tick crash
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
            if (a < 0) return null;
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
            if (a < 0 || b <= a) return null;   // malformed bracket → was Substring(-)
            return ParseVec(j.Substring(a + 1, b - a - 1));
        }

        private static float[] ParseVec(string csv)
        {
            var list = new List<float>();
            foreach (var tok in csv.Split(','))
                if (float.TryParse(tok.Trim(),
                    System.Globalization.NumberStyles.Float,
                    System.Globalization.CultureInfo.InvariantCulture,
                    out float v) && !float.IsNaN(v) && !float.IsInfinity(v))   // NaN/Inf tokens parsed
                    // as legit numbers and poisoned every logit
                    list.Add(v);
            return list.ToArray();
        }
    }
}
