using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace ThronefallTrainer
{
    /// <summary>One frame message header of the plugin -> livecap link (36 bytes on the wire, all little-endian).</summary>
    internal struct FrameHeader
    {
        public uint MetaLen;       // bytes of UTF-8 JSON that follow the header
        public uint W, H;          // pixel size of the payload image
        public uint Fmt;           // 1 = RGBA32 rows bottom-to-top (Unity readback), 2 = BGRA32 top-to-bottom, 3 = RGB24 bottom-to-top
        public double TMs;         // unix epoch milliseconds when the frame was captured
        public uint Seq;           // capture counter (a gap = frames dropped before they left the process)
        public uint PayloadLen;    // w*h*4 (fmt 1/2) or w*h*3 (fmt 3)
    }

    /// <summary>Pure logic of live.v1 (no Unity runtime needed): the wire framing, control-line parsing, capture size / pacing maths,
    /// the camera meta JSON, the orientation probe and the lock-free-ish frame exchange. LiveLink.cs owns the Unity side
    /// (render textures, async readback), LiveLinkNet.cs the socket thread. Unit-tested in tests/ActLogic.Tests.</summary>
    internal static class LiveLinkLogic
    {
        static readonly CultureInfo Inv = CultureInfo.InvariantCulture;

        // ------------------------------------------------------------------------------------------------ protocol
        public const string HelloPrefix = "TFGAME1 ";
        public const int HeaderLen = 36;                       // "TFRM" (4) + six u32 (24) + one f64 (8); exact layout in EncodeHeader
        public const int MaxMetaLen = 8192;                    // livecap drops the connection when a frame announces more
        public const uint FmtRgba32 = 1, FmtBgra32 = 2, FmtRgb24 = 3;
        public const int MinFps = 5, MaxFps = 60, MinWidth = 320, MaxWidth = 1920, MaxDim = 4096;

        /// <summary>Bytes per pixel of a frame format, 0 for an unknown one.</summary>
        public static int BytesPerPixel(uint fmt) { return fmt == FmtRgb24 ? 3 : (fmt == FmtRgba32 || fmt == FmtBgra32 ? 4 : 0); }

        /// <summary>The payload size a w x h image of `fmt` must have (-1 = unknown format / overflow).</summary>
        public static long PayloadLen(uint fmt, long w, long h)
        {
            int bpp = BytesPerPixel(fmt);
            if (bpp == 0 || w <= 0 || h <= 0) return -1;
            long n = w * h * bpp;
            return n > int.MaxValue ? -1 : n;
        }

        static void PutU32(byte[] b, int o, uint v) { b[o] = (byte)v; b[o + 1] = (byte)(v >> 8); b[o + 2] = (byte)(v >> 16); b[o + 3] = (byte)(v >> 24); }
        static uint GetU32(byte[] b, int o) { return (uint)(b[o] | (b[o + 1] << 8) | (b[o + 2] << 16) | (b[o + 3] << 24)); }

        /// <summary>Layout (offset: field): 0 "TFRM" | 4 meta_len u32 | 8 w u32 | 12 h u32 | 16 fmt u32 | 20 t_ms f64 | 28 seq u32 | 32 payload_len u32.
        /// Writes HeaderLen bytes at dst[off..] and returns HeaderLen. Explicit byte shifts, so the result never depends on the host endianness.</summary>
        public static int EncodeHeader(byte[] dst, int off, FrameHeader h)
        {
            dst[off] = (byte)'T'; dst[off + 1] = (byte)'F'; dst[off + 2] = (byte)'R'; dst[off + 3] = (byte)'M';
            PutU32(dst, off + 4, h.MetaLen); PutU32(dst, off + 8, h.W); PutU32(dst, off + 12, h.H); PutU32(dst, off + 16, h.Fmt);
            long t = BitConverter.DoubleToInt64Bits(h.TMs);
            for (int i = 0; i < 8; i++) dst[off + 20 + i] = (byte)(t >> (8 * i));
            PutU32(dst, off + 28, h.Seq); PutU32(dst, off + 32, h.PayloadLen);
            return HeaderLen;
        }

        /// <summary>Decode + validate (the same checks livecap applies): magic, known format, sane size, payload_len == w*h*bpp, meta_len bound.</summary>
        public static bool TryDecodeHeader(byte[] src, int off, int count, out FrameHeader h, out string error)
        {
            h = default(FrameHeader); error = null;
            if (src == null || count < HeaderLen || off < 0 || off + HeaderLen > src.Length) { error = "short header"; return false; }
            if (src[off] != (byte)'T' || src[off + 1] != (byte)'F' || src[off + 2] != (byte)'R' || src[off + 3] != (byte)'M') { error = "bad magic"; return false; }
            h.MetaLen = GetU32(src, off + 4); h.W = GetU32(src, off + 8); h.H = GetU32(src, off + 12); h.Fmt = GetU32(src, off + 16);
            long t = 0;
            for (int i = 0; i < 8; i++) t |= (long)src[off + 20 + i] << (8 * i);
            h.TMs = BitConverter.Int64BitsToDouble(t);
            h.Seq = GetU32(src, off + 28); h.PayloadLen = GetU32(src, off + 32);
            if (BytesPerPixel(h.Fmt) == 0) { error = "unknown fmt " + h.Fmt; return false; }
            if (h.W < 1 || h.H < 1 || h.W > MaxDim || h.H > MaxDim) { error = "bad size " + h.W + "x" + h.H; return false; }
            if (h.MetaLen > MaxMetaLen) { error = "meta too long " + h.MetaLen; return false; }
            if (PayloadLen(h.Fmt, h.W, h.H) != h.PayloadLen) { error = "payload_len " + h.PayloadLen + " != w*h*bpp"; return false; }
            return true;
        }

        /// <summary>The first thing sent on a connection: "TFGAME1 " + json + "\n".</summary>
        public static string HelloLine(string build, int pid, int w, int h, string unity)
        {
            return HelloPrefix + "{\"build\":" + ActLogic.Js(build) + ",\"pid\":" + pid.ToString(Inv) + ",\"w\":" + w.ToString(Inv) + ",\"h\":" + h.ToString(Inv) +
                   ",\"unity\":" + ActLogic.Js(unity) + "}\n";
        }

        // ------------------------------------------------------------------------------------------------ control lines (livecap -> plugin)
        const string NumRe = "(-?\\d+(?:\\.\\d+)?(?:[eE][-+]?\\d+)?)";
        static readonly Regex CapKey = new Regex("\"cap\"\\s*:\\s*\\{");           // not RegexOptions.Compiled: Reflection.Emit costs more than a rare control line
        static readonly Regex FpsRe = new Regex("\"fps\"\\s*:\\s*" + NumRe);
        static readonly Regex WRe = new Regex("\"w\"\\s*:\\s*" + NumRe);

        public static int ClampFps(double v) { return (int)Math.Round(v < MinFps ? MinFps : (v > MaxFps ? MaxFps : v), MidpointRounding.AwayFromZero); }
        public static int ClampWidth(double v) { return (int)Math.Round(v < MinWidth ? MinWidth : (v > MaxWidth ? MaxWidth : v), MidpointRounding.AwayFromZero); }

        /// <summary>The text of the first {...} object that follows `"cap":` (nesting-aware, string-aware); null when there is none.</summary>
        static string CapObject(string line)
        {
            var m = CapKey.Match(line);
            if (!m.Success) return null;
            int start = m.Index + m.Length, depth = 1;
            bool inStr = false;
            for (int i = start; i < line.Length; i++)
            {
                char c = line[i];
                if (inStr) { if (c == '\\') i++; else if (c == '"') inStr = false; continue; }
                if (c == '"') inStr = true;
                else if (c == '{') depth++;
                else if (c == '}' && --depth == 0) return line.Substring(start, i - start);
            }
            return null;                                       // unterminated: garbage
        }

        /// <summary>Parse one control line, e.g. {"cap":{"fps":30,"w":1280}}. True when it carried a usable `cap` field. `fps` / `w` come back
        /// clamped (5..60 / 320..1920) or 0 = "not present, keep what you have". Anything else (ping, unknown keys, garbage) is ignored.</summary>
        public static bool TryParseControl(string line, out int fps, out int w)
        {
            int paused;
            TryParseControl(line, out fps, out w, out paused);
            return fps > 0 || w > 0;
        }

        static readonly Regex PausedRe = new Regex("\"paused\"\\s*:\\s*(true|false)");

        /// <summary>The same plus livecap's `"paused"` (it sends {"cap":{"fps":30,"w":1280,"paused":true}} when nobody is watching, "stop / resume the
        /// in-game capture too"): `paused` = 1 / 0, or -1 when the line does not say. True when the line carried any usable cap field.</summary>
        public static bool TryParseControl(string line, out int fps, out int w, out int paused)
        {
            fps = 0; w = 0; paused = -1;
            if (string.IsNullOrEmpty(line) || line.Length > 4096) return false;
            string cap = CapObject(line);
            if (cap == null) return false;
            double v;
            var m = FpsRe.Match(cap);
            if (m.Success && double.TryParse(m.Groups[1].Value, NumberStyles.Float, Inv, out v) && !double.IsNaN(v) && !double.IsInfinity(v)) fps = ClampFps(v);
            m = WRe.Match(cap);
            if (m.Success && double.TryParse(m.Groups[1].Value, NumberStyles.Float, Inv, out v) && !double.IsNaN(v) && !double.IsInfinity(v)) w = ClampWidth(v);
            m = PausedRe.Match(cap);
            if (m.Success) paused = m.Groups[1].Value == "true" ? 1 : 0;
            return fps > 0 || w > 0 || paused >= 0;
        }

        // ------------------------------------------------------------------------------------------------ capture size and pacing
        /// <summary>Nearest even number, ties go up (1001 -> 1002, 1000.4 -> 1000).</summary>
        public static int RoundEven(double v) { return (int)Math.Floor(v / 2.0 + 0.5) * 2; }

        /// <summary>Size of the downscaled capture: width = the request clamped to 320..1920 and never above the screen, height keeps the SCREEN's
        /// aspect, both rounded to even numbers (video-friendly), height capped at 4096 (livecap's limit). False for a screen too small to capture
        /// (minimised windows report 0x0).</summary>
        public static bool CaptureSize(int screenW, int screenH, int reqW, out int w, out int h)
        {
            w = 0; h = 0;
            if (screenW < 16 || screenH < 16) return false;
            int rw = ClampWidth(reqW);
            if (rw > screenW) rw = screenW;
            double aspect = (double)screenH / screenW;
            w = Math.Max(2, RoundEven(rw));
            if (w > screenW) w -= 2;
            h = Math.Max(2, RoundEven(w * aspect));
            if (h > MaxDim) { h = MaxDim; w = Math.Max(2, RoundEven(h / aspect)); }
            return true;
        }

        /// <summary>Seconds between captures for a target fps (clamped 5..60).</summary>
        public static float IntervalFor(double fps) { return 1f / ClampFps(fps); }

        /// <summary>Is a capture due? `next` is the scheduled time; half a frame of slack so a 60 Hz game hits a 30 fps schedule on every
        /// second frame instead of every third (a frame that lands 0.1 ms early must not wait a whole extra frame).</summary>
        public static bool Due(float now, float next, float frameDt)
        {
            float slack = 0.5f * (frameDt < 0f ? 0f : (frameDt > 0.1f ? 0.1f : frameDt));
            return now + slack >= next;
        }

        /// <summary>Schedule after a capture at `now`: keep the phase (next + interval), but after a hitch longer than an interval start over
        /// from `now` instead of firing a burst of catch-up frames.</summary>
        public static float Advance(float next, float now, float interval)
        {
            float n = next + interval;
            return n <= now ? now + interval : n;
        }

        public const double BackoffStart = 0.5, BackoffMax = 5.0;

        /// <summary>Reconnect delay after a failure: 0.5 -> 1 -> 2 -> 4 -> 5 -> 5 ... seconds.</summary>
        public static double NextBackoff(double cur) { return NextBackoff(cur, BackoffStart, BackoffMax); }
        public static double NextBackoff(double cur, double start, double max) { double n = cur * 2.0; return n > max ? max : (n < start ? start : n); }

        /// <summary>Adapts the capture rate to what leaves the process: a capture whose frame is overwritten in the latest-frame slot before the
        /// sender took it cost a GPU copy, a readback and a memcpy for nothing. Evaluated once per window (about every 2 s) from the sent /
        /// dropped counters: more than 25 % dropped = the consumer cannot keep up, back off by 20 % (never below MinFps); a clean window creeps
        /// back up towards the target.</summary>
        public sealed class RateAdapter
        {
            public int Target { get; private set; }
            public float Effective { get; private set; }
            public RateAdapter(int targetFps) { Target = ClampFps(targetFps); Effective = Target; }

            public void SetTarget(int targetFps)
            {
                int t = ClampFps(targetFps);
                if (t == Target) return;
                Target = t;
                if (Effective > t || Effective < 1f) Effective = t;
            }

            public float Update(int sent, int dropped)
            {
                int total = sent + dropped;
                if (total < 4) return Effective;                                         // not enough evidence in this window
                if (dropped * 4 > total) Effective = Math.Max(MinFps, Effective * 0.8f);
                else if (dropped == 0 && Effective < Target) Effective = Math.Min(Target, Effective + Math.Max(1f, Target * 0.1f));
                return Effective;
            }
        }

        // ------------------------------------------------------------------------------------------------ per-frame meta JSON
        static float Fin(float v) { return float.IsNaN(v) || float.IsInfinity(v) ? 0f : v; }

        /// <summary>"[a,b,...]" for a 16-float row-major matrix, the exact number format view.json always used ("0.#####", invariant).</summary>
        public static void AppendVp(StringBuilder sb, float[] vp16)
        {
            sb.Append('[');
            for (int i = 0; i < 16; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(Fin(vp16[i]).ToString("0.#####", Inv));
            }
            sb.Append(']');
        }

        /// <summary>The per-frame meta: {"pw","ph","vp":[16],"gy","hero":[x,z],"ts","scene","ok"}. vp / gy / hero are the same numbers
        /// view.json carries (Act.SampleView). `sceneJson` is an already escaped JSON string literal (quotes included). Without a camera
        /// (menus, loading) "vp" is [] and ok false.</summary>
        public static string BuildMeta(StringBuilder sb, int pw, int ph, float[] vp16, bool haveVp, bool ok, float gy, float hx, float hz, float timeScale, string sceneJson)
        {
            sb.Length = 0;
            sb.Append("{\"pw\":").Append(pw.ToString(Inv)).Append(",\"ph\":").Append(ph.ToString(Inv)).Append(",\"vp\":");
            if (haveVp) AppendVp(sb, vp16); else sb.Append("[]");
            sb.Append(",\"gy\":").Append(ActLogic.F(Fin(gy))).Append(",\"hero\":[").Append(ActLogic.F(Fin(hx))).Append(',').Append(ActLogic.F(Fin(hz)))
              .Append("],\"ts\":").Append(ActLogic.F(Fin(timeScale))).Append(",\"scene\":").Append(string.IsNullOrEmpty(sceneJson) ? "\"\"" : sceneJson)
              .Append(",\"ok\":").Append(ok && haveVp ? "true" : "false").Append('}');
            return sb.ToString();
        }

        // ------------------------------------------------------------------------------------------------ pixel self-checks
        /// <summary>Mean luma 0..255 of every `step`-th pixel of an RGBA32 buffer (the "is the capture black?" self-check).</summary>
        public static float MeanLuma(byte[] rgba, int len, int step)
        {
            if (rgba == null || len < 4) return 0f;
            if (step < 1) step = 1;
            long sum = 0; int n = 0;
            for (int p = 0; p + 3 < len; p += 4 * step) { sum += (77 * rgba[p] + 150 * rgba[p + 1] + 29 * rgba[p + 2]) >> 8; n++; }
            return n == 0 ? 0f : (float)((double)sum / n);
        }

        public const int GridW = 24, GridH = 16;
        public const double MinGridStd = 3.0;

        /// <summary>Pixel coordinate (0..size-1) of sub-sample `sub` (0..2) of grid cell `cell` out of `cells`; shared by the buffer sampler and
        /// the Texture2D sampler in LiveLink.cs so both look at the same spots.</summary>
        public static int CellPixel(int cell, int cells, int size, int sub)
        {
            int p = (int)((cell + (sub + 0.5) / 3.0) / cells * size);
            return p < 0 ? 0 : (p >= size ? size - 1 : p);
        }

        /// <summary>GridW x GridH grid (3x3 samples per cell) of a swap-invariant luma, 0.207 R + 0.587 G + 0.207 B, of an RGBA32 buffer; grid row 0 =
        /// the FIRST row of the buffer. When `meanRgb`
        /// (3 floats) is given it receives the mean R, G, B (0..255) over the same samples (the colour check of the probe).</summary>
        public static void LumaGrid(byte[] rgba, int w, int h, float[] grid, float[] meanRgb = null)
        {
            long sr = 0, sg = 0, sb = 0;
            for (int gy = 0; gy < GridH; gy++)
                for (int gx = 0; gx < GridW; gx++)
                {
                    int sum = 0;
                    for (int sy = 0; sy < 3; sy++)
                    {
                        int y = CellPixel(gy, GridH, h, sy);
                        for (int sx = 0; sx < 3; sx++)
                        {
                            int i = (y * w + CellPixel(gx, GridW, w, sx)) * 4;
                            sum += (53 * (rgba[i] + rgba[i + 2]) + 150 * rgba[i + 1]) >> 8;     // R and B weigh the same: a BGRA / RGBA mix-up cannot fool the orientation test
                            sr += rgba[i]; sg += rgba[i + 1]; sb += rgba[i + 2];
                        }
                    }
                    grid[gy * GridW + gx] = sum / 9f;
                }
            if (meanRgb != null)
            {
                double n = GridW * GridH * 9.0;
                meanRgb[0] = (float)(sr / n); meanRgb[1] = (float)(sg / n); meanRgb[2] = (float)(sb / n);
            }
        }

        /// <summary>Mean and standard deviation of a luma grid.</summary>
        public static void GridStats(float[] grid, out float mean, out float std)
        {
            int n = GridW * GridH;
            double m = 0, v = 0;
            for (int i = 0; i < n; i++) m += grid[i];
            m /= n;
            for (int i = 0; i < n; i++) { double d = grid[i] - m; v += d * d; }
            mean = (float)m; std = (float)Math.Sqrt(v / n);
        }

        /// <summary>Do the delivered colours match the reference (mean R,G,B 0..255 of the same frame)? "" = yes, else a short diagnosis: red and blue
        /// swapped (BGRA bytes read as RGBA), or the overall brightness off by more than 15 % (an sRGB / linear mix-up in the capture path).</summary>
        public static string ColorDiagnosis(float[] refRgb, float[] testRgb)
        {
            float dr = Math.Abs(refRgb[0] - testRgb[0]), db = Math.Abs(refRgb[2] - testRgb[2]);
            float sr = Math.Abs(refRgb[0] - testRgb[2]), sb = Math.Abs(refRgb[2] - testRgb[0]);
            if (Math.Abs(refRgb[0] - refRgb[2]) > 12f && sr + sb < 0.5f * (dr + db)) return "red and blue look SWAPPED (BGRA bytes read as RGBA?)";
            float lr = (77f * refRgb[0] + 150f * refRgb[1] + 29f * refRgb[2]) / 256f, lt = (77f * testRgb[0] + 150f * testRgb[1] + 29f * testRgb[2]) / 256f;
            if (lr > 10f && (lt < 0.85f * lr || lt > 1.15f * lr))
                return "brightness is " + (lt > lr ? "+" : "") + ActLogic.F((lt / lr - 1f) * 100f) + " % off the on-screen picture (sRGB / linear mix-up in the capture path?)";
            return "";
        }

        /// <summary>Is the delivered buffer upright? `reference` is a grid of the same frame taken with an API of KNOWN orientation (a Texture2D:
        /// row 0 = bottom, like Unity's readback), `test` the grid of what the capture delivered. +1 = same orientation, -1 = vertically
        /// flipped, 0 = cannot tell (flat picture, vertically symmetric one, or the two do not look like the same frame). Deliberately
        /// conservative: the winner must beat the loser by 3x, fit well in absolute terms, AND the loser must be clearly wrong (a quarter of
        /// the picture's own variance), because a wrong "flip" would turn a good stream upside down.</summary>
        public static int DecideFlip(float[] reference, float[] test, out double ssdDirect, out double ssdFlipped)
        {
            int n = GridW * GridH;
            double mean = 0;
            for (int i = 0; i < n; i++) mean += reference[i];
            mean /= n;
            double varTot = 0; ssdDirect = 0; ssdFlipped = 0;
            for (int gy = 0; gy < GridH; gy++)
                for (int gx = 0; gx < GridW; gx++)
                {
                    int i = gy * GridW + gx;
                    double dr = reference[i] - mean; varTot += dr * dr;
                    double d1 = test[i] - reference[i]; ssdDirect += d1 * d1;
                    double d2 = test[i] - reference[(GridH - 1 - gy) * GridW + gx]; ssdFlipped += d2 * d2;
                }
            if (Math.Sqrt(varTot / n) < MinGridStd) return 0;
            if (ssdDirect <= 0.35 * ssdFlipped && ssdDirect <= 0.5 * varTot && ssdFlipped >= 0.25 * varTot) return 1;
            if (ssdFlipped <= 0.35 * ssdDirect && ssdFlipped <= 0.5 * varTot && ssdDirect >= 0.25 * varTot) return -1;
            return 0;
        }

        /// <summary>Reverse the row order of a w x h image of `bpp` bytes per pixel in place (`scratch` holds one row, at least w*bpp bytes).</summary>
        public static void FlipRows(byte[] data, int w, int h, int bpp, byte[] scratch)
        {
            int stride = w * bpp;
            for (int top = 0, bot = h - 1; top < bot; top++, bot--)
            {
                Buffer.BlockCopy(data, top * stride, scratch, 0, stride);
                Buffer.BlockCopy(data, bot * stride, data, top * stride, stride);
                Buffer.BlockCopy(scratch, 0, data, bot * stride, stride);
            }
        }

        // ------------------------------------------------------------------------------------------------ log throttle
        /// <summary>Monotonic seconds (Stopwatch), usable from any thread.</summary>
        public static double NowSec() { return Stopwatch.GetTimestamp() / (double)Stopwatch.Frequency; }

        /// <summary>At most one message per kind per window (default 30 s). Thread-safe.</summary>
        public sealed class LogThrottle
        {
            readonly Dictionary<string, double> last = new Dictionary<string, double>();
            readonly double window;
            public LogThrottle(double windowSec) { window = windowSec; }
            public bool Allow(string kind, double nowSec)
            {
                lock (last)
                {
                    double t;
                    if (last.TryGetValue(kind, out t) && nowSec - t < window) return false;
                    last[kind] = nowSec;
                    return true;
                }
            }
        }
    }

    /// <summary>One captured frame on its way to the socket: a pooled pixel buffer plus what the header and meta need.</summary>
    internal sealed class LiveFrame
    {
        public byte[] Data;               // exactly w*h*bpp bytes (pooled, reused)
        public int W, H;
        public uint Fmt, Seq;
        public double TMs;
        public string Meta;
        public LiveFrame(int len) { Data = new byte[len]; }
    }

    /// <summary>The hand-over between the game thread (readback callback) and the sender thread: ONE "latest frame" slot, latest wins, nothing
    /// queues. A frame that is overwritten before the sender took it is recycled (and counted as dropped). Buffers cycle through a small pool,
    /// so after warm-up (three frames) nothing is allocated per frame; a changed capture size simply retires the old buffers.</summary>
    internal sealed class FrameExchange
    {
        const int MaxPool = 4;
        readonly object gate = new object();
        readonly Stack<LiveFrame> free = new Stack<LiveFrame>();
        LiveFrame latest;
        public int Allocated, Dropped, Published;     // read for status lines; written under the lock

        /// <summary>A frame with Data.Length == len, from the pool when possible (game thread).</summary>
        public LiveFrame Rent(int len)
        {
            lock (gate)
            {
                while (free.Count > 0)
                {
                    var f = free.Pop();
                    if (f.Data.Length == len) return f;           // else: wrong size, retired to the GC
                }
                Allocated++;
            }
            return new LiveFrame(len);
        }

        /// <summary>Make `f` the latest frame; a previous one nobody took is recycled and counted as dropped (game thread).</summary>
        public void Publish(LiveFrame f)
        {
            lock (gate)
            {
                if (latest != null) { Recycle(latest); Dropped++; }
                latest = f;
                Published++;
            }
        }

        /// <summary>The newest frame, or null when there is nothing new (sender thread). Give it back with Return.</summary>
        public LiveFrame TakeLatest()
        {
            lock (gate) { var f = latest; latest = null; return f; }
        }

        public void Return(LiveFrame f) { lock (gate) Recycle(f); }

        /// <summary>Drop a pending frame (a new connection must not start with a stale picture).</summary>
        public void Clear() { lock (gate) { if (latest != null) { Recycle(latest); latest = null; } } }

        void Recycle(LiveFrame f) { if (free.Count < MaxPool) free.Push(f); }
    }
}
