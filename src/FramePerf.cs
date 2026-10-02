using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// perf.v1 - ground truth about WHY the game stutters, and proof of the fix after deploy.
    ///   BeginFrame / EndFrame are the first and last lines of Plugin.Update (one call per frame); Mark(section, Now()) wraps the pieces of plugin
    ///   code that run per frame (Bot.Tick, Coach.PerFrame, Act.PerFrame, the LiveLink capture tick + readback callback). Per frame it records the game's
    ///   frame time (Time.unscaledDeltaTime, cross-checked with a wall clock) and the plugin's own main-thread time per section into a fixed ring: O(1),
    ///   allocation-free, never throws. Once a second it writes agent/perf.json (atomic) over the last 5 s: fps, frame_ms p50/p95/p99/max, stalls over
    ///   50 / 100 ms, plugin_ms avg/max, per-section averages, GC collections, and whether LiveLink / the legacy screenshots were active. A frame longer
    ///   than 100 ms appends one line to agent/perf-stalls.jsonl (file capped at ~200 KB, oldest half dropped) saying how much of it was our code
    ///   ("cause": plugin | mixed | engine), which section was the longest, the GC collections during the frame and whether a legacy screenshot ran in it.
    /// The files are written by AsyncWriter's background thread, so the once-a-second write costs the game thread only the JSON text (tens of us).
    /// Not covered (and so counted as "engine" in a stall line): IMGUI (OnGUI), the Harmony patch prefixes, worker threads, and everything the game does.
    /// The pure maths (ring, percentiles, JSON, file cap) is in FramePerfLogic.cs and unit-tested.
    /// </summary>
    internal static class FramePerf
    {
        public static bool Enabled;                      // [Perf] Enabled (Plugin.BindConfig -> Init)

        /// <summary>Set from the config and, when on, run every piece of the once-a-second path once on dummy data, so the JIT cost of its first use is paid at
        /// plugin load and not as a 1-6 ms hitch in the first seconds of play (in the simulated loop the first three flushes cost 1-6 ms against 0.15 ms after).</summary>
        public static void Init(bool enabled)
        {
            Enabled = enabled;
            if (!enabled) return;
            try
            {
                var r = new FrameRing(64); var sm = new PerfSummary(); var sec = new float[FrameRing.Sections];
                for (int i = 0; i < 8; i++) r.Push(i, 16.7f + i, 16.7f, 1f, sec, 0, 0);
                r.Summarize(8.0, 5.0, sm);
                FramePerfLogic.PerfJson(0, 0, WindowS, sm, GC.CollectionCount(0), 0, false, false, false, false, 0, 0, 0f);
                FramePerfLogic.StallLine(0, 120f, 120f, 5f, sec, 0, 1);
                FramePerfLogic.NewestHalf("{}\n{}\n");
                AsyncWriter.Warm();
            }
            catch (Exception) { }
        }

        /// <summary>Raw section ids for Mark. Bot.Tick contains Coach.PerFrame and Act.PerFrame; the reported sections are made exclusive (FramePerfLogic.Exclusive).</summary>
        public const int SecBot = 0, SecCoach = 1, SecAct = 2, SecLive = 3;

        private const double WindowS = 5.0;
        private static readonly double msPerTick = 1000.0 / Stopwatch.Frequency;
        private static readonly FrameRing ring = new FrameRing(2048);      // 5 s of frames up to ~400 fps
        private static readonly PerfSummary sum = new PerfSummary();
        private static readonly float[] secMs = new float[FrameRing.Sections];
        private static readonly long[] raw = new long[4];
        private static readonly StringBuilder stallBuf = new StringBuilder(512);
        private static long beginTicks, updateTicks;
        private static bool open;
        private static byte shotFlags;
        private static int framesSeen, gcAtBegin, gcLastWrite, seq, shotsJpg, shotsPng;
        private static double nextWrite, lastSelfMs, lastWarn = -999;
        private static string perfPath, stallsPath;

        /// <summary>First line of Plugin.Update. Closes the previous frame (its length is Time.unscaledDeltaTime now) and opens this one.</summary>
        public static void BeginFrame()
        {
            if (!Enabled) return;
            try
            {
                long now = Stopwatch.GetTimestamp();
                if (open) Close(now);
                beginTicks = now; open = true; updateTicks = 0;
                gcAtBegin = GC.CollectionCount(0);
            }
            catch (Exception) { }
        }

        /// <summary>Last line of Plugin.Update: the span since BeginFrame is the plugin's Update time; once a second the files are written.</summary>
        public static void EndFrame()
        {
            if (!Enabled || !open) return;
            try
            {
                long now = Stopwatch.GetTimestamp();
                updateTicks = now - beginTicks;
                double sNow = now * msPerTick / 1000.0;
                if (sNow >= nextWrite) { nextWrite = sNow + 1.0; Flush(sNow); }
            }
            catch (Exception) { }
        }

        /// <summary>Start a timing: <c>long t = FramePerf.Now(); ...; FramePerf.Mark(FramePerf.SecCoach, t);</c></summary>
        public static long Now() { return Stopwatch.GetTimestamp(); }

        public static void Mark(int section, long startTicks)
        {
            if (!Enabled) return;
            raw[section] += Stopwatch.GetTimestamp() - startTicks;
        }

        /// <summary>A legacy synchronous screenshot just ran in this frame (1 = live.jpg, 2 = live.png): the stall line says so.</summary>
        public static void Shot(int kind)
        {
            if (!Enabled) return;
            shotFlags |= (byte)kind;
            if (kind == 1) shotsJpg++; else if (kind == 2) shotsPng++;
        }

        private static double UnixNow() { return DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0; }

        /// <summary>Record the frame that just ended.</summary>
        private static void Close(long now)
        {
            framesSeen++;
            if (framesSeen > 2)                                                  // the first frames (scene load) say nothing about steady state
            {
                float frameMs = Time.unscaledDeltaTime * 1000f;
                float wallMs = (float)((now - beginTicks) * msPerTick);
                float plugin = FramePerfLogic.Exclusive((float)(updateTicks * msPerTick), (float)(raw[SecBot] * msPerTick), (float)(raw[SecCoach] * msPerTick),
                                                        (float)(raw[SecAct] * msPerTick), (float)(raw[SecLive] * msPerTick), secMs);
                int gcDelta = GC.CollectionCount(0) - gcAtBegin;
                ring.Push(now * msPerTick / 1000.0, frameMs, wallMs, plugin, secMs, gcDelta, shotFlags);
                if (Math.Max(frameMs, wallMs) > FramePerfLogic.StallMs && stallBuf.Length < 20000)         // (bounded: a storm of stalls cannot grow it)
                    stallBuf.Append(FramePerfLogic.StallLine(UnixNow(), frameMs, wallMs, plugin, secMs, gcDelta, shotFlags)).Append('\n');
            }
            raw[0] = raw[1] = raw[2] = raw[3] = 0; shotFlags = 0;
        }

        /// <summary>Once a second: perf.json (atomic, the same helper as caps.json) and the buffered stall lines.</summary>
        private static void Flush(double nowSec)
        {
            long t0 = Stopwatch.GetTimestamp();
            try
            {
                if (perfPath == null)
                {
                    string dir = Recorder.AgentDir;
                    Directory.CreateDirectory(dir);
                    perfPath = Path.Combine(dir, "perf.json"); stallsPath = Path.Combine(dir, "perf-stalls.jsonl");
                }
                ring.Summarize(nowSec, WindowS, sum);
                int gc = GC.CollectionCount(0);
                bool conn = LiveLink.Connected;
                string json = FramePerfLogic.PerfJson(UnixNow(), ++seq, WindowS, sum, gc, gc - gcLastWrite, LiveLink.Enabled, conn, Coach.LiveShot && !conn, Coach.LiveShot,
                                                      shotsJpg, shotsPng, (float)lastSelfMs);
                gcLastWrite = gc; shotsJpg = 0; shotsPng = 0;
                Act.AtomicWrite(perfPath, json);
                if (stallBuf.Length > 0)                                         // the append and the 200 KB cap happen on the writer thread
                {
                    AsyncWriter.Append(stallsPath, stallBuf.ToString(), FramePerfLogic.StallsFileCap, FramePerfLogic.NewestHalf);
                    stallBuf.Length = 0;
                }
            }
            catch (Exception ex)
            {
                if (nowSec - lastWarn > 60.0) { lastWarn = nowSec; Plugin.Log?.LogWarning("[perf] write failed: " + ex.GetType().Name + ": " + ex.Message); }
            }
            lastSelfMs = (Stopwatch.GetTimestamp() - t0) * msPerTick;
        }
    }
}
