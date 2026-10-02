using System;
using System.Globalization;
using System.Text;

namespace ThronefallTrainer
{
    /// <summary>What the frames of a time window looked like (filled by FrameRing.Summarize; one instance is reused, nothing is allocated).</summary>
    internal sealed class PerfSummary
    {
        public int Frames, Stalls50, Stalls100;
        public float Fps;                                   // frames that ended in the last second
        public float P50, P95, P99, Max, WallMax;           // frame_ms (Time.unscaledDeltaTime) percentiles / max; wall-clock max as a cross-check
        public float PluginAvg, PluginMax;                  // the plugin's own main-thread ms per frame
        public readonly float[] SecAvg = new float[FrameRing.Sections], SecMax = new float[FrameRing.Sections];

        public void Reset()
        {
            Frames = Stalls50 = Stalls100 = 0;
            Fps = P50 = P95 = P99 = Max = WallMax = PluginAvg = PluginMax = 0f;
            Array.Clear(SecAvg, 0, SecAvg.Length); Array.Clear(SecMax, 0, SecMax.Length);
        }
    }

    /// <summary>Fixed-size ring of per-frame records (frame time, plugin time, per-section plugin time, GC collections, screenshot flags). Push is O(1)
    /// and allocation-free; Summarize walks the newest frames back to a time cutoff and sorts a preallocated scratch copy once per call (once a second).</summary>
    internal sealed class FrameRing
    {
        public const int Sections = 5;
        /// <summary>Exclusive, non-overlapping plugin sections: cheats = Plugin.Update minus Bot.Tick, bot = Bot.Tick minus Coach.PerFrame minus Act.PerFrame,
        /// coach, act, livelink (the end-of-frame capture tick + readback callbacks, which run outside Plugin.Update).</summary>
        public static readonly string[] SectionNames = { "cheats", "bot", "coach", "act", "livelink" };

        public readonly int Capacity;
        readonly double[] t;                                // frame end time, monotonic seconds
        readonly float[] frameMs, wallMs, pluginMs;
        readonly float[][] sec = new float[Sections][];
        readonly int[] gc;
        readonly byte[] shot;                               // bit 1 = a legacy live.jpg grab ran in this frame, bit 2 = live.png
        readonly float[] scratch;
        readonly double[] secSum = new double[Sections];
        int head, count;

        public FrameRing(int capacity)
        {
            Capacity = Math.Max(4, capacity);
            t = new double[Capacity]; frameMs = new float[Capacity]; wallMs = new float[Capacity]; pluginMs = new float[Capacity];
            for (int i = 0; i < Sections; i++) sec[i] = new float[Capacity];
            gc = new int[Capacity]; shot = new byte[Capacity]; scratch = new float[Capacity];
        }

        public int Count { get { return count; } }

        /// <summary>Record one finished frame. O(1), no allocation. `secMs` has Sections entries.</summary>
        public void Push(double tSec, float frameMsV, float wallMsV, float pluginMsV, float[] secMs, int gcDelta, byte shotFlags)
        {
            int i = head;
            t[i] = tSec; frameMs[i] = frameMsV; wallMs[i] = wallMsV; pluginMs[i] = pluginMsV; gc[i] = gcDelta; shot[i] = shotFlags;
            for (int k = 0; k < Sections; k++) sec[k][i] = secMs[k];
            head = (head + 1) % Capacity;
            if (count < Capacity) count++;
        }

        /// <summary>Index of the k-th newest record (0 = newest).</summary>
        int At(int k) { return ((head - 1 - k) % Capacity + Capacity) % Capacity; }

        public double TimeOf(int k) { return t[At(k)]; }
        public float FrameMsOf(int k) { return frameMs[At(k)]; }
        public float PluginMsOf(int k) { return pluginMs[At(k)]; }
        public float SectionOf(int sectionIndex, int k) { return sec[sectionIndex][At(k)]; }
        public int GcOf(int k) { return gc[At(k)]; }
        public byte ShotOf(int k) { return shot[At(k)]; }

        /// <summary>Statistics over the frames that ended within `windowSec` seconds before `nowSec`.</summary>
        public void Summarize(double nowSec, double windowSec, PerfSummary r)
        {
            r.Reset();
            double cutoff = nowSec - windowSec, cutoff1 = nowSec - 1.0, sumPlugin = 0;
            Array.Clear(secSum, 0, Sections);
            int n = 0, fps = 0;
            for (int k = 0; k < count; k++)
            {
                int i = At(k);
                if (t[i] < cutoff) break;
                float f = frameMs[i];
                scratch[n++] = f;
                if (f > r.Max) r.Max = f;
                if (wallMs[i] > r.WallMax) r.WallMax = wallMs[i];
                if (f > 50f) r.Stalls50++;
                if (f > 100f) r.Stalls100++;
                if (t[i] >= cutoff1) fps++;
                sumPlugin += pluginMs[i];
                if (pluginMs[i] > r.PluginMax) r.PluginMax = pluginMs[i];
                for (int s = 0; s < Sections; s++)
                {
                    float v = sec[s][i];
                    secSum[s] += v;
                    if (v > r.SecMax[s]) r.SecMax[s] = v;
                }
            }
            r.Frames = n;
            r.Fps = fps;
            if (n == 0) return;
            r.PluginAvg = (float)(sumPlugin / n);
            for (int s = 0; s < Sections; s++) r.SecAvg[s] = (float)(secSum[s] / n);
            Array.Sort(scratch, 0, n);
            r.P50 = FramePerfLogic.Percentile(scratch, n, 50.0);
            r.P95 = FramePerfLogic.Percentile(scratch, n, 95.0);
            r.P99 = FramePerfLogic.Percentile(scratch, n, 99.0);
        }
    }

    /// <summary>Pure helpers of the frame-time instrumentation (src/FramePerf.cs): percentile maths, exclusive sections, stall attribution,
    /// the perf.json / perf-stalls.jsonl text and the file cap. Unit-tested in tests/ActLogic.Tests.</summary>
    internal static class FramePerfLogic
    {
        static readonly CultureInfo Inv = CultureInfo.InvariantCulture;
        public const float StallMs = 100f;                  // a frame this long gets a perf-stalls.jsonl line
        public const int StallsFileCap = 200000;            // bytes; above it the oldest half is dropped

        /// <summary>Nearest-rank percentile of the first `n` values of an ASCENDING array: the value at rank ceil(p/100 * n). 0 when empty.</summary>
        public static float Percentile(float[] sorted, int n, double pct)
        {
            if (n <= 0) return 0f;
            int rank = (int)Math.Ceiling(pct / 100.0 * n);
            if (rank < 1) rank = 1;
            if (rank > n) rank = n;
            return sorted[rank - 1];
        }

        /// <summary>Split the raw per-frame timings into exclusive sections (all in ms): cheats = update - botTick, bot = botTick - coach - act, coach, act,
        /// livelink. update = Plugin.Update's span (contains Bot.Tick, which contains Coach / Act); livelink runs outside it. Negative remainders (clock
        /// granularity) clamp to 0. Returns the plugin total for the frame: update + livelink.</summary>
        public static float Exclusive(float update, float botTick, float coach, float act, float live, float[] secOut)
        {
            secOut[0] = Math.Max(0f, update - botTick);
            secOut[1] = Math.Max(0f, botTick - coach - act);
            secOut[2] = coach; secOut[3] = act; secOut[4] = live;
            return update + live;
        }

        /// <summary>Index of the longest section (first one on a tie), -1 when every section is 0.</summary>
        public static int TopSection(float[] secMs, out float ms)
        {
            int best = -1; ms = 0f;
            for (int i = 0; i < secMs.Length; i++) if (secMs[i] > ms) { ms = secMs[i]; best = i; }
            return best;
        }

        /// <summary>Who owns a long frame: "plugin" when our own code accounts for at least half of it, "engine" (engine / GPU / OS) when it accounts for
        /// at most a fifth, else "mixed".</summary>
        public static string Cause(float frameMs, float pluginMs)
        {
            if (frameMs <= 0f) return "engine";
            float share = pluginMs / frameMs;
            return share >= 0.5f ? "plugin" : (share <= 0.2f ? "engine" : "mixed");
        }

        static string N(float v) { return float.IsNaN(v) || float.IsInfinity(v) ? "0" : v.ToString("0.##", Inv); }

        /// <summary>One line of perf-stalls.jsonl.</summary>
        public static string StallLine(double tUnix, float frameMs, float wallMs, float pluginMs, float[] secMs, int gcDelta, byte shotFlags)
        {
            float topMs; int top = TopSection(secMs, out topMs);
            var sb = new StringBuilder(220);
            sb.Append("{\"t\":").Append(tUnix.ToString("0.0", Inv)).Append(",\"frame_ms\":").Append(N(frameMs)).Append(",\"wall_ms\":").Append(N(wallMs))
              .Append(",\"plugin_ms\":").Append(N(pluginMs)).Append(",\"cause\":\"").Append(Cause(Math.Max(frameMs, wallMs), pluginMs))
              .Append("\",\"top\":\"").Append(top < 0 ? "none" : FrameRing.SectionNames[top]).Append("\",\"top_ms\":").Append(N(topMs))
              .Append(",\"gc\":").Append(gcDelta.ToString(Inv)).Append(",\"shot\":\"").Append((shotFlags & 1) != 0 ? ((shotFlags & 2) != 0 ? "jpg+png" : "jpg") : ((shotFlags & 2) != 0 ? "png" : ""))
              .Append("\",\"sec\":{");
            for (int i = 0; i < secMs.Length; i++) { if (i > 0) sb.Append(','); sb.Append('"').Append(FrameRing.SectionNames[i]).Append("\":").Append(N(secMs[i])); }
            return sb.Append("}}").ToString();
        }

        /// <summary>The text of agent/perf.json (once per second).</summary>
        public static string PerfJson(double tUnix, int seq, double windowS, PerfSummary s, int gcCount, int gcDelta, bool liveEnabled, bool liveConnected,
                                      bool legacyJpg, bool legacyPng, int shotsJpg, int shotsPng, float selfMs)
        {
            var sb = new StringBuilder(640);
            sb.Append("{\"t\":").Append(tUnix.ToString("0.0", Inv)).Append(",\"seq\":").Append(seq.ToString(Inv)).Append(",\"window_s\":").Append(N((float)windowS))
              .Append(",\"frames\":").Append(s.Frames.ToString(Inv)).Append(",\"fps\":").Append(N(s.Fps))
              .Append(",\"frame_ms\":{\"p50\":").Append(N(s.P50)).Append(",\"p95\":").Append(N(s.P95)).Append(",\"p99\":").Append(N(s.P99)).Append(",\"max\":").Append(N(s.Max)).Append('}')
              .Append(",\"wall_ms_max\":").Append(N(s.WallMax))
              .Append(",\"stalls_50\":").Append(s.Stalls50.ToString(Inv)).Append(",\"stalls_100\":").Append(s.Stalls100.ToString(Inv))
              .Append(",\"plugin_ms\":{\"avg\":").Append(N(s.PluginAvg)).Append(",\"max\":").Append(N(s.PluginMax)).Append('}')
              .Append(",\"sections\":{");
            for (int i = 0; i < FrameRing.Sections; i++) { if (i > 0) sb.Append(','); sb.Append('"').Append(FrameRing.SectionNames[i]).Append("\":").Append(N(s.SecAvg[i])); }
            sb.Append("},\"sections_max\":{");
            for (int i = 0; i < FrameRing.Sections; i++) { if (i > 0) sb.Append(','); sb.Append('"').Append(FrameRing.SectionNames[i]).Append("\":").Append(N(s.SecMax[i])); }
            sb.Append("},\"gc_count\":").Append(gcCount.ToString(Inv)).Append(",\"gc_delta\":").Append(gcDelta.ToString(Inv))
              .Append(",\"live\":{\"enabled\":").Append(liveEnabled ? "true" : "false").Append(",\"connected\":").Append(liveConnected ? "true" : "false").Append('}')
              .Append(",\"legacy\":{\"jpg\":").Append(legacyJpg ? "true" : "false").Append(",\"png\":").Append(legacyPng ? "true" : "false").Append('}')
              .Append(",\"shots\":{\"jpg\":").Append(shotsJpg.ToString(Inv)).Append(",\"png\":").Append(shotsPng.ToString(Inv)).Append('}')
              .Append(",\"self_ms\":").Append(N(selfMs)).Append('}');
            return sb.ToString();
        }

        /// <summary>The newest half (by line count, rounded up) of a jsonl text, always starting at a line boundary: the file cap of perf-stalls.jsonl.</summary>
        public static string NewestHalf(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            var lines = text.Split(new[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
            int keep = (lines.Length + 1) / 2;
            var sb = new StringBuilder(text.Length / 2 + 16);
            for (int i = lines.Length - keep; i < lines.Length; i++) sb.Append(lines[i].TrimEnd('\r')).Append('\n');
            return sb.ToString();
        }
    }
}
