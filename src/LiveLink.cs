using System;
using System.Collections;
using System.Diagnostics;
using System.Text;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace ThronefallTrainer
{
    /// <summary>
    /// live.v1 - the game's own rendered frames, streamed to livecap (tools/livecap.py) with almost no game-thread cost.
    ///
    /// Why: ScreenCapture.CaptureScreenshotAsTexture + EncodeToJPG/PNG on the game thread (the legacy live.jpg / live.png in Coach.PerFrame) stalls
    /// the game for 100-500 ms several times a second, and an external window capture shows nothing when the window is minimised.
    /// What (all on the game thread, once per capture, at end of frame; target ~1 ms):
    ///   ScreenCapture.CaptureScreenshotIntoRenderTexture(full) -> Graphics.Blit(full, small) (GPU downscale) -> AsyncGPUReadback.Request(small)
    ///   -> the callback (a few frames later) copies the bytes into a pooled buffer and publishes it into ONE "latest frame" slot
    ///   -> the sender thread (LiveLinkNet.cs) writes header + meta + pixels to livecap's ingest port (TCP 127.0.0.1:8095, protocol in docs/PLUGIN-LIVE.md).
    /// Latest wins, nothing queues, at most MaxInFlight (3) readbacks pending (a readback lands 2-3 frames after it was requested, so a strict one-at-a-time
    /// would cap a 60 fps game at 20-30 captured fps) and frames are published strictly in order; everything that can throw is caught here (the game
    /// thread never throws because of this feature) and warnings are throttled to one per 30 s per kind. Without a listener the cost per frame is one
    /// coroutine resume.
    /// The per-frame meta carries the camera matrix + hero the frame was rendered with (same numbers as agent/view.json: Act.SampleView).
    /// Coach.PerFrame skips its synchronous screenshots while Connected is true; with no link they keep working exactly as before.
    /// </summary>
    internal static class LiveLink
    {
        public const string BuildId = "live-1";

        // ---- config (wired from Plugin.BindConfig before Init)
        public static bool Enabled;
        public static int Port = 8095, CfgWidth = 1280, CfgFps = 30;
        public static string FlipMode = "auto";       // auto = probe the capture's orientation once; on / off = force a vertical flip of the GPU downscale

        private const float LogEvery = 30f, StallS = 2f, ProbeEvery = 3f;
        private const int MaxFailStreak = 120, ProbesMax = 6, MaxInFlight = 3, MaxReadbackErrors = 60;
        private static readonly Vector2 FlipScale = new Vector2(1f, -1f), FlipOffset = new Vector2(0f, 1f);

        private static LiveSender sender;
        private static LiveLinkLogic.RateAdapter adapter;
        private static readonly LiveLinkLogic.LogThrottle warnThrottle = new LiveLinkLogic.LogThrottle(30), infoThrottle = new LiveLinkLogic.LogThrottle(1);

        // ---- capture state (game thread only, except where noted)
        private sealed class Req
        {
            public Action<AsyncGPUReadbackRequest> Done;
            public bool Busy, Orphaned, Probe;
            public uint Seq; public double TMs; public string Meta; public int W, H; public float StartedAt; public long TickTicks;
            public Req() { Done = r => OnReadback(this, r); }
        }
        private static readonly Req[] reqs = { new Req(), new Req(), new Req(), new Req(), new Req(), new Req() };   // MaxInFlight live ones + room for abandoned ones
        private static int inFlight;                                                    // live (not abandoned) readbacks pending
        private static bool probePending;                                               // an orientation probe frame is in flight: capture nothing else until it lands
        private static RenderTexture rtFull, rtSmall;
        private static int capW, capH, failStreak, errStreak;
        private static uint captureSeq, lastPubSeq;
        private static float nextCapture, holdOffUntil, nextAdapt, nextLog, nextProbeAt;
        private static bool lastUp, lastStreaming;

        // ---- self-check / orientation probe
        private static bool flipGpu, flipDecided, colorChecked, selfCheckDone;
        private static int selfChecks, probes, probeFails;
        private static byte[] flipScratch;
        private static readonly float[] gridRef = new float[LiveLinkLogic.GridW * LiveLinkLogic.GridH], gridTest = new float[LiveLinkLogic.GridW * LiveLinkLogic.GridH];
        private static readonly float[] refRgb = new float[3], testRgb = new float[3];

        // ---- meta
        private static readonly StringBuilder metaSb = new StringBuilder(640);
        private static readonly float[] vp = new float[16];
        private static string sceneJson = "\"\"";
        private static int sceneHandle = int.MinValue;

        // ---- stats (game thread writes; StatusLine reads)
        private static int readbackErrors, stalls, adaptSent, adaptDropped, loggedSent;
        private static double avgMs, maxMs, winFps;
        private static float loggedAt;

        /// <summary>True while frames were handed to the socket in the last 3 s (link up AND streaming), or while livecap has paused the capture because nobody
        /// is watching (the link is up; the legacy screenshots must not resume for a pause). Coach.PerFrame reads it every frame.</summary>
        public static bool Connected
        {
            get { var s = sender; return Enabled && s != null && s.LinkUp && (s.SecondsSinceLastSend() < 3.0 || s.CtlPaused); }
        }

        /// <summary>One line for the periodic log (every 30 s while there is traffic): link, frames sent, drops, main-thread cost, capture size.</summary>
        public static string StatusLine
        {
            get
            {
                var s = sender;
                if (s == null) return Enabled ? "starting" : "disabled";
                return "link=" + (s.LinkUp ? "up" : "down") + (s.CtlPaused ? " (paused by livecap)" : "") + " streaming=" + (Connected ? "yes" : "no") + " sent=" + s.FramesSent + " (" + ActLogic.F((float)winFps) + " fps) dropped=" + s.Frames.Dropped +
                       " readback-errors=" + readbackErrors + " stalls=" + stalls + " main-thread=" + ActLogic.F((float)avgMs) + " ms/frame avg, " + ActLogic.F((float)maxMs) + " max" +
                       " cap=" + capW + "x" + capH + " @" + (adapter != null ? ActLogic.F(adapter.Effective) + "/" + adapter.Target : "?") + " fps orientation=" +
                       (flipDecided ? (flipGpu ? "flipped on the GPU" : "as captured") : "probing");
            }
        }

        // ------------------------------------------------------------------------------------------------ start / stop
        public static void Init(MonoBehaviour host)
        {
            if (!Enabled || sender != null) return;
            try
            {
                if (!SystemInfo.supportsAsyncGPUReadback)
                {
                    Enabled = false;
                    Plugin.Log?.LogWarning("[live] disabled: this GPU / graphics API has no async readback (legacy live.jpg / live.png keep working)");
                    return;
                }
                int port = Port < 1 || Port > 65535 ? 8095 : Port;
                adapter = new LiveLinkLogic.RateAdapter(CfgFps);
                string fm = (FlipMode ?? "auto").Trim().ToLowerInvariant();
                flipGpu = fm == "on" || fm == "true" || fm == "yes" || fm == "1";
                flipDecided = fm != "auto";                                      // anything but "auto" is a manual choice: no probe
                var s = new LiveSender { Port = port, Build = BuildId, UnityVersion = Application.unityVersion, Pid = Process.GetCurrentProcess().Id, Log = OnSenderLog };
                s.ScreenW = Screen.width; s.ScreenH = Screen.height;
                sender = s;
                s.Start();
                host.StartCoroutine(Loop());
                Plugin.Log?.LogInfo("[live] " + BuildId + " ready: in-game capture -> livecap on 127.0.0.1:" + port + ", " + LiveLinkLogic.ClampWidth(CfgWidth) + " px wide @ " + LiveLinkLogic.ClampFps(CfgFps) +
                                    " fps (livecap may override), orientation " + (flipDecided ? (flipGpu ? "forced flip" : "as captured") : "auto-probed") + "; silent until livecap listens");
            }
            catch (Exception ex)
            {
                Enabled = false;
                Plugin.Log?.LogWarning("[live] init failed, feature off: " + ex.GetType().Name + ": " + ex.Message);
            }
        }

        public static void Shutdown()
        {
            try
            {
                Enabled = false;                                                  // ends the coroutine
                var s = sender;
                if (s != null) s.Stop();
                ReleaseRt(ref rtSmall); ReleaseRt(ref rtFull);
            }
            catch (Exception) { }
        }

        private static void Disable(string why)
        {
            Enabled = false;
            var s = sender;
            if (s != null) s.Stop();
            Plugin.Log?.LogWarning("[live] switched off: " + why + " (legacy live.jpg / live.png take over)");
            try { Act.OnLiveLinkChanged(); } catch (Exception) { }                // caps.json: no live.v1, not connected
        }

        private static void Warn(string kind, string text)
        {
            try { if (Plugin.Log != null && warnThrottle.Allow(kind, LiveLinkLogic.NowSec())) Plugin.Log.LogWarning("[live] " + text); } catch (Exception) { }
        }

        /// <summary>Called on the sender / control threads: throttled (1 s per info kind, 30 s per warning kind) so a flapping link cannot flood the log.</summary>
        private static void OnSenderLog(string kind, string text, bool warn)
        {
            try
            {
                var log = Plugin.Log;
                if (log == null || !(warn ? warnThrottle : infoThrottle).Allow("net:" + kind, LiveLinkLogic.NowSec())) return;
                if (warn) log.LogWarning("[live] " + text); else log.LogInfo("[live] " + text);
            }
            catch (Exception) { }
        }

        // ------------------------------------------------------------------------------------------------ the end-of-frame loop
        private static IEnumerator Loop()
        {
            var eof = new WaitForEndOfFrame();                                    // one instance: no per-frame allocation
            while (Enabled)
            {
                yield return eof;
                long perfT = FramePerf.Now();
                try { Tick(); }
                catch (Exception ex)
                {
                    failStreak++;
                    holdOffUntil = Time.unscaledTime + Math.Min(5f, 0.25f * failStreak);
                    Warn("tick", "capture failed (" + failStreak + " in a row): " + ex.GetType().Name + ": " + ex.Message);
                    if (failStreak >= MaxFailStreak) Disable(failStreak + " consecutive capture failures");
                }
                FramePerf.Mark(FramePerf.SecLive, perfT);
            }
        }

        private static int TargetFps(LiveSender s) { int c = s.CtlFps; return c > 0 ? c : LiveLinkLogic.ClampFps(CfgFps); }
        private static int ReqWidth(LiveSender s) { int c = s.CtlW; return c > 0 ? c : LiveLinkLogic.ClampWidth(CfgWidth); }

        private static void Tick()
        {
            var snd = sender;
            if (snd == null) return;
            float now = Time.unscaledTime;
            Housekeeping(snd, now);
            if (!snd.LinkUp) return;                                              // nobody listening: that is all this frame cost
            if (snd.CtlPaused) return;                                            // livecap says nobody is watching: no capture, the link stays up
            for (int i = 0; i < reqs.Length; i++)                                 // a readback that never comes back is abandoned, not waited for forever
            {
                var o = reqs[i];
                if (o.Busy && !o.Orphaned && now - o.StartedAt > StallS)
                {
                    o.Orphaned = true; inFlight--; stalls++;
                    if (o.Probe) probePending = false;
                    Warn("stall", "a GPU readback took longer than " + StallS + " s: abandoned it");
                }
            }
            if (inFlight >= MaxInFlight || probePending) return;                  // back-pressure (and only the probe frame while probing)
            if (now < holdOffUntil || !LiveLinkLogic.Due(now, nextCapture, Time.unscaledDeltaTime)) return;
            Req q = null;
            for (int i = 0; i < reqs.Length; i++) if (!reqs[i].Busy) { q = reqs[i]; break; }
            if (q == null) return;                                                // every slot is an abandoned readback: wait for one to land
            int sw = Screen.width, sh = Screen.height, cw, ch;
            snd.ScreenW = sw; snd.ScreenH = sh;
            if (!LiveLinkLogic.CaptureSize(sw, sh, ReqWidth(snd), out cw, out ch)) return;    // minimised: Screen reports 0x0

            long t0 = Stopwatch.GetTimestamp();
            try
            {
                if (!EnsureTargets(sw, sh, cw, ch)) return;                       // a size change waits until nothing of the old size is pending
                ScreenCapture.CaptureScreenshotIntoRenderTexture(rtFull);
                bool probe = (!flipDecided || !colorChecked) && now >= nextProbeAt;
                if (probe)                                                        // see FinishProbe: a few synchronous grabs per session, not per frame
                {
                    nextProbeAt = now + ProbeEvery;
                    probe = BeginProbe();
                    if (!probe && ++probeFails >= ProbesMax) { flipDecided = true; colorChecked = true; Warn("probe-giveup", "orientation / colour probe gave up (no reference frame); sending frames as captured. If the Live View is upside down set [Live] FlipY=on"); }
                }
                if (flipGpu) Graphics.Blit(rtFull, rtSmall, FlipScale, FlipOffset); else Graphics.Blit(rtFull, rtSmall);
                q.Seq = ++captureSeq;
                q.TMs = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
                q.Meta = BuildMeta(sw, sh);                                       // the camera as it is NOW = what these pixels show
                q.W = cw; q.H = ch; q.Probe = probe; q.StartedAt = now; q.Orphaned = false; q.Busy = true;
                inFlight++;
                if (probe) probePending = true;
                AsyncGPUReadback.Request(rtSmall, 0, TextureFormat.RGBA32, q.Done);
                q.TickTicks = Stopwatch.GetTimestamp() - t0;
            }
            catch (Exception)
            {
                if (q.Busy && !q.Orphaned) { q.Busy = false; inFlight--; if (q.Probe) probePending = false; }
                throw;                                                            // Loop counts it, throttles the warning and backs off
            }
            nextCapture = LiveLinkLogic.Advance(nextCapture, now, LiveLinkLogic.IntervalFor(adapter.Effective));
            failStreak = 0;
        }

        /// <summary>The two render textures at the current sizes. False = the small one has to change size but readbacks of the old size are still
        /// pending (they read from it): try again next frame.</summary>
        private static bool EnsureTargets(int sw, int sh, int cw, int ch)
        {
            bool fullOk = rtFull != null && rtFull.width == sw && rtFull.height == sh;
            bool smallOk = rtSmall != null && rtSmall.width == cw && rtSmall.height == ch;
            if (fullOk && smallOk) return true;
            if (!smallOk && rtSmall != null && inFlight > 0) return false;
            if (!fullOk)
            {
                ReleaseRt(ref rtFull);
                rtFull = new RenderTexture(sw, sh, 0, RenderTextureFormat.ARGB32) { name = "LiveLink.full", filterMode = FilterMode.Bilinear };
                rtFull.Create();
            }
            if (!smallOk)
            {
                ReleaseRt(ref rtSmall);
                rtSmall = new RenderTexture(cw, ch, 0, RenderTextureFormat.ARGB32) { name = "LiveLink.small", filterMode = FilterMode.Bilinear };
                rtSmall.Create();
                capW = cw; capH = ch;
            }
            return true;
        }

        private static void ReleaseRt(ref RenderTexture rt)
        {
            if (rt == null) return;
            try { rt.Release(); UnityEngine.Object.Destroy(rt); } catch (Exception) { }
            rt = null;
        }

        /// <summary>Camera matrix + hero + time scale + scene for the frame being captured: vp / gy / hero come from Act.SampleView (view.json's code).</summary>
        private static string BuildMeta(int pw, int ph)
        {
            Vector3 hero;
            bool haveCam = Act.SampleView(BotPerception.LastValid ? BotPerception.Last.HeroPos : Vector3.zero, vp, out hero);
            var sc = SceneManager.GetActiveScene();
            if (sc.handle != sceneHandle) { sceneHandle = sc.handle; sceneJson = ActLogic.Js(sc.name); }      // cached: no native string marshalling per frame
            return LiveLinkLogic.BuildMeta(metaSb, pw, ph, vp, haveCam, Act.ViewOk, hero.y, hero.x, hero.z, Time.timeScale, sceneJson);
        }

        // ------------------------------------------------------------------------------------------------ readback callback (game thread, a few frames later)
        private static void OnReadback(Req q, AsyncGPUReadbackRequest r)
        {
            long t0 = Stopwatch.GetTimestamp();
            q.Busy = false;
            if (q.Orphaned) { q.Orphaned = false; return; }                       // abandoned after a stall: just free the slot
            inFlight--;
            bool probe = q.Probe;
            try
            {
                var snd = sender;
                if (snd == null || !Enabled) return;
                if (r.hasError) { BadReadback("readback", "GPU readback reported an error"); return; }
                var data = r.GetData<byte>();
                int len = data.Length;
                if (len != q.W * q.H * 4 || r.width != q.W || r.height != q.H)
                { BadReadback("readback-size", "readback is " + r.width + "x" + r.height + " (" + len + " bytes), expected " + q.W + "x" + q.H); return; }
                errStreak = 0;
                if (q.Seq <= lastPubSeq) return;                                  // arrived out of order: never go back in time
                LiveFrame f = snd.Frames.Rent(len);
                data.CopyTo(f.Data);                                              // the NativeArray is only valid inside this callback
                f.W = q.W; f.H = q.H; f.Fmt = LiveLinkLogic.FmtRgba32; f.Seq = q.Seq; f.TMs = q.TMs; f.Meta = q.Meta;
                if (!selfCheckDone) SelfCheck(f);
                if (probe) FinishProbe(f);
                lastPubSeq = q.Seq;
                snd.Frames.Publish(f);
                snd.Wake();
            }
            catch (Exception ex) { Warn("callback", "readback callback failed: " + ex.GetType().Name + ": " + ex.Message); }
            finally
            {
                if (probe) probePending = false;
                AddCost(q.TickTicks + (Stopwatch.GetTimestamp() - t0));
                FramePerf.Mark(FramePerf.SecLive, t0);
            }
        }

        private static void BadReadback(string kind, string text)
        {
            readbackErrors++; errStreak++;
            Warn(kind, text + " (" + readbackErrors + " so far); frame skipped");
            if (errStreak >= MaxReadbackErrors) Disable(errStreak + " consecutive readback failures");
        }

        private static void AddCost(long ticks)
        {
            double ms = ticks * 1000.0 / Stopwatch.Frequency;
            avgMs = avgMs == 0 ? ms : avgMs * 0.95 + ms * 0.05;
            if (ms > maxMs) maxMs = ms;
        }

        /// <summary>One-time self-check: mean brightness of the first delivered frame, so a black capture shows up in LogOutput.log. A black first
        /// frame (loading screen?) is re-checked about once a second, ten times at most.</summary>
        private static void SelfCheck(LiveFrame f)
        {
            selfChecks++;
            if (selfChecks > 1 && selfChecks % 30 != 0) return;
            float luma = LiveLinkLogic.MeanLuma(f.Data, f.Data.Length, 16);
            bool black = luma < 2f;
            if (!black)
            {
                selfCheckDone = true;
                Plugin.Log?.LogInfo("[live] self-check: first frame " + f.W + "x" + f.H + ", mean brightness " + ActLogic.F(luma) + "/255 -> capture is NOT black");
            }
            else
            {
                if (selfChecks >= 300) selfCheckDone = true;
                Plugin.Log?.LogWarning("[live] self-check: frame " + selfChecks + " is BLACK (mean brightness " + ActLogic.F(luma) + "/255)" + (selfCheckDone ? "; giving up checking - CaptureScreenshotIntoRenderTexture delivers nothing here, set [Live] Enabled=false" : "; checking again in about a second"));
            }
        }

        // ------------------------------------------------------------------------------------------------ orientation probe
        // Whether CaptureScreenshotIntoRenderTexture hands back the picture upright or upside down depends on the graphics API and cannot be
        // known from here, so the first frame is compared with a synchronous CaptureScreenshotAsTexture of the SAME frame (Texture2D rows run
        // bottom-to-top, which the legacy live.png relies on). A clear vertical flip is corrected on the GPU for every later frame and in place for
        // this one; an unclear result (flat or symmetric picture) is retried a few times and then left as captured ([Live] FlipY=on|off overrides).
        // The same reference frame also checks the colours (R/B order, overall brightness) once and logs the verdict, which is the deploy-time proof that
        // the capture path keeps the picture's look; in a manual FlipY mode only that colour check runs.
        private static bool BeginProbe()
        {
            Texture2D tex = null;
            try
            {
                tex = ScreenCapture.CaptureScreenshotAsTexture();
                if (tex == null) return false;
                int w = tex.width, h = tex.height;
                float sr = 0f, sg = 0f, sb = 0f;
                for (int gy = 0; gy < LiveLinkLogic.GridH; gy++)
                    for (int gx = 0; gx < LiveLinkLogic.GridW; gx++)
                    {
                        float sum = 0f;
                        for (int sy = 0; sy < 3; sy++)
                        {
                            int y = LiveLinkLogic.CellPixel(gy, LiveLinkLogic.GridH, h, sy);
                            for (int sx = 0; sx < 3; sx++)
                            {
                                Color c = tex.GetPixel(LiveLinkLogic.CellPixel(gx, LiveLinkLogic.GridW, w, sx), y);
                                sum += (0.2065f * (c.r + c.b) + 0.587f * c.g) * 255f;          // same R/B-symmetric luma as LiveLinkLogic.LumaGrid
                                sr += c.r; sg += c.g; sb += c.b;
                            }
                        }
                        gridRef[gy * LiveLinkLogic.GridW + gx] = sum / 9f;
                    }
                float n = LiveLinkLogic.GridW * LiveLinkLogic.GridH * 9f;
                refRgb[0] = sr / n * 255f; refRgb[1] = sg / n * 255f; refRgb[2] = sb / n * 255f;
                return true;
            }
            catch (Exception ex) { Warn("probe", "orientation probe could not grab a reference frame: " + ex.GetType().Name + ": " + ex.Message); return false; }
            finally { if (tex != null) UnityEngine.Object.Destroy(tex); }
        }

        private static void FinishProbe(LiveFrame f)
        {
            probes++;
            LiveLinkLogic.LumaGrid(f.Data, f.W, f.H, gridTest, testRgb);
            float refMean, refStd;
            LiveLinkLogic.GridStats(gridRef, out refMean, out refStd);
            float testLuma = (77f * testRgb[0] + 150f * testRgb[1] + 29f * testRgb[2]) / 256f;
            if (refMean >= 20f && testLuma < 2f)                                  // black capture of a screen that is NOT black: unusable here, hand back to the legacy files
            {
                Disable("the capture is black while the screen is not (mean brightness " + ActLogic.F(testLuma) + " vs " + ActLogic.F(refMean) + " on screen)");
                return;
            }
            if (!flipDecided)
            {
                double dd, df;
                int v = LiveLinkLogic.DecideFlip(gridRef, gridTest, out dd, out df);
                string err = " (error vs the reference frame: as delivered " + ActLogic.F((float)dd) + ", vertically flipped " + ActLogic.F((float)df) + ")";
                if (v > 0)
                {
                    flipDecided = true;
                    Plugin.Log?.LogInfo("[live] orientation probe: the capture is upright (bottom row first, as fmt 1 promises)" + err);
                }
                else if (v < 0)
                {
                    flipDecided = true;
                    flipGpu = !flipGpu;                                           // every later frame is flipped by the downscale blit
                    if (flipScratch == null || flipScratch.Length < f.W * 4) flipScratch = new byte[f.W * 4];
                    LiveLinkLogic.FlipRows(f.Data, f.W, f.H, 4, flipScratch);      // and this one, in place, so livecap never sees an upside-down frame
                    Plugin.Log?.LogInfo("[live] orientation probe: the capture is VERTICALLY FLIPPED -> flipping every frame on the GPU from now on" + err);
                }
            }
            if (!colorChecked && refMean >= 10f)                                  // a black reference says nothing about colours
            {
                colorChecked = true;
                string diag = LiveLinkLogic.ColorDiagnosis(refRgb, testRgb);
                string rgb = "mean RGB on screen (" + ActLogic.F(refRgb[0]) + "," + ActLogic.F(refRgb[1]) + "," + ActLogic.F(refRgb[2]) + ") vs delivered (" + ActLogic.F(testRgb[0]) + "," + ActLogic.F(testRgb[1]) + "," + ActLogic.F(testRgb[2]) + ")";
                if (diag.Length == 0) Plugin.Log?.LogInfo("[live] colour check: OK, " + rgb);
                else Plugin.Log?.LogWarning("[live] colour check: " + diag + " - " + rgb);
            }
            if (probes >= ProbesMax && (!flipDecided || !colorChecked))
            {
                string left = (flipDecided ? "" : "orientation") + (!flipDecided && !colorChecked ? " and " : "") + (colorChecked ? "" : "colour");
                flipDecided = true; colorChecked = true;
                Plugin.Log?.LogWarning("[live] probe: could not settle the " + left + " after " + probes + " tries (flat / dark / symmetric pictures); sending frames as captured. If the Live View is upside down set [Live] FlipY=on");
            }
        }

        // ------------------------------------------------------------------------------------------------ housekeeping (every frame, cheap)
        private static void Housekeeping(LiveSender s, float now)
        {
            bool up = s.LinkUp;
            if (up != lastUp) { lastUp = up; nextCapture = 0f; }                  // a new connection starts capturing at once
            bool streaming = Connected;
            if (streaming != lastStreaming)
            {
                lastStreaming = streaming;
                try { Act.OnLiveLinkChanged(); } catch (Exception) { }            // caps.json: live_connected
            }
            if (now >= nextAdapt) { nextAdapt = now + 2f; Adapt(s); }
            if (now >= nextLog) { nextLog = now + LogEvery; StatusLog(s, now); }
        }

        private static void Adapt(LiveSender s)
        {
            int sent = s.FramesSent, drop = s.Frames.Dropped;
            int ds = sent - adaptSent, dd = drop - adaptDropped;
            adaptSent = sent; adaptDropped = drop;
            float before = adapter.Effective;
            adapter.SetTarget(TargetFps(s));
            float after = adapter.Update(ds, dd);
            if (Math.Abs(after - before) >= 1f && infoThrottle.Allow("rate", LiveLinkLogic.NowSec()))
                Plugin.Log?.LogInfo("[live] capture rate " + ActLogic.F(before) + " -> " + ActLogic.F(after) + " fps (" + dd + " of " + (ds + dd) + " frames overwritten before they could be sent; target " + adapter.Target + ")");
        }

        private static void StatusLog(LiveSender s, float now)
        {
            int sent = s.FramesSent;
            winFps = loggedAt > 0f && now > loggedAt ? (sent - loggedSent) / (double)(now - loggedAt) : 0.0;
            bool traffic = s.LinkUp || sent != loggedSent;                        // nobody ever listening: no periodic noise
            bool first = loggedAt <= 0f;                                          // the very first call is just the clock starting
            loggedSent = sent; loggedAt = now;
            if (traffic && !first) Plugin.Log?.LogInfo("[live] " + StatusLine);
            maxMs = 0;
        }
    }
}
