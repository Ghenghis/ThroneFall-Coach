using System;
using System.IO;
using System.Net;
using System.Text;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// LLM coach ("Grandmaster") — an event-driven advisor, not a per-tick
    /// controller. Fires on day-start and defeat with a compact telemetry
    /// digest, gets back a small JSON strategy patch, and applies it to the
    /// live policy knobs. Default backend is the LOCAL LM Studio endpoint
    /// (free, unlimited); MiniMax cloud is config-selectable for deep passes.
    /// Never blocks the game thread; every failure is logged and skipped.
    /// </summary>
    internal static class Coach
    {
        // ---- config (wired from Plugin.BindConfig) ----
        public static bool Enabled;
        public static string Url = "http://127.0.0.1:1234/v1/chat/completions";
        public static string Model = "kat-coder-v2.5-dev-apex";
        public static string ApiKey = "";          // empty for local LM Studio
        public static float MinIntervalS = 45f;    // hard throttle between calls
        public static int MaxTokens = 900;
        // Vision seam (defeat screenshots -> local VL model). Local = free;
        // MiniMax vision has quota so it stays opt-in via config.
        public static bool VisionEnabled;
        public static string VisionModel = "qwen3-vl-2b-thinking-abliterated";

        // ---- live overrides the policy layer reads ----
        public static int SquadSize;        // 0 = use built-in default
        public static int ReserveSize;
        public static int EscortSize;
        public static int ArmyTargetFloor;
        public static string BuildFocus = "";   // military|income|defense|balanced
        public static string HeroPosture = "";  // builder|fighter
        public static string LastAdvice = "";
        public static float LastAdviceAt;
        public static int CallsMade, TokensUsed, Failures, LastLatencyMs;
        public static string LastTrigger = "";
        public static volatile bool Busy;   // written by the worker thread
        public static bool LiveShot;             // dump agent/live.png for the chat UI
        public static float LiveShotEvery = 2f;
        public static float LiveShotFastEvery = 0.25f;
        public static float LiveMarkersEvery = 0.1f;       // markers.json at 10 Hz: the overlay draws from it, it does not need a screenshot
        // While the in-game stream is up the live.png write is pure stall
        // (200-490 ms PNG encode on the game thread every 30 s — the single
        // biggest stall class, ~21% of stalled time). <=0 = never write it;
        // the link-drop logic below re-arms the 2 s fallback automatically.
        public static float LiveShotLinkedEvery = 0f;
        private static float nextLiveShotFast;
        private static float nextMarkers;
        private static float nextLiveShot;

        private static float lastCallAt = -999f;
        private static UnityEngine.Object hostRef;

        /// <summary>Host is only needed to check the plugin is still alive —
        /// calls run on a worker thread, not a Unity coroutine.</summary>
        public static void Init(MonoBehaviour h) { hostRef = h; }

        private const string SysPrompt =
            "You are Grandmaster, the strategy advisor for a Thronefall autopilot " +
            "bot. The bot fights with UNITS, not the hero: it posts squads on " +
            "enemy corridors outside the walls, keeps a castle reserve, and the " +
            "hero builds/farms and only fights as last resort. No cheats. " +
            "Given the telemetry digest, return ONLY a JSON object: " +
            "The digest carries efficiency (0-100, target 80+), useful_pct (target 85), " +
            "idle_s_since_progress, drain reasons, weak_tasks (lowest-efficiency task kinds) " +
            "and task_misses: if efficiency is low, steer build_focus/army_target to fix the " +
            "worst task, and set night_call true when the day has nothing left to spend on. " +
            "{\"squad_size\":int,\"reserve_size\":int,\"escort_size\":int," +
            "\"army_target\":int,\"build_focus\":\"military|income|defense|balanced\"," +
            "\"hero_posture\":\"builder|fighter\",\"note\":\"<one sentence>\"}.";

        /// <summary>Called from Bot's per-frame Update: periodic live.png for
        /// the chat UI + poll the user command file the chat server writes.</summary>
        public static void PerFrame(in BotPerception.Snapshot s, Vector3 aim, bool hasAim)
        {
            long perfT = FramePerf.Now();
            // Screen-projected intent markers for the Live pane overlay —
            // the canvas draws where the bot WANTS to be, not just pixels.
            if (LiveShot && Time.unscaledTime >= nextMarkers)
            {
                nextMarkers = Time.unscaledTime + LiveMarkersEvery;
                try
                {
                    var cam = Camera.main;
                    if (cam != null)
                    {
                        var mk = Path.Combine(Recorder.AgentDir, "markers.json");
                        var tmp = mk + ".tmp";
                        var sb = new StringBuilder(400);
                        sb.Append("{\"pw\":").Append(Screen.width)
                          .Append(",\"ph\":").Append(Screen.height)
                          .Append(",\"pts\":[");
                        int n = 0;
                        Action<string, Vector3, string> pt = (tag, pos, col) =>
                        {
                            var sp = cam.WorldToScreenPoint(pos);
                            if (sp.z <= 0f) return;   // behind camera
                            sb.Append(n++ > 0 ? "," : "")
                              .Append("{\"t\":\"").Append(tag)
                              .Append("\",\"x\":").Append(Mathf.RoundToInt(sp.x))
                              .Append(",\"y\":").Append(Mathf.RoundToInt(Screen.height - sp.y))
                              .Append(",\"wx\":").Append(ActLogic.F(pos.x))      // world x,z next to the screen x,y: the overlay no longer
                              .Append(",\"wz\":").Append(ActLogic.F(pos.z))      // has to un-project pixels to find where a point is
                              .Append(",\"w\":").Append(Screen.width)
                              .Append(",\"h\":").Append(Screen.height)
                              .Append(",\"c\":\"").Append(col).Append("\"}");
                        };
                        pt("hero", s.HeroPos, "#00e5ff");
                        if (hasAim) pt("aim", aim, "#ffd400");
                        if (s.HasCastle) pt("castle", s.CastlePos, "#fff");
                        if ((UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null)
                            pt("bld:" + (s.NearestBuildName ?? "?"), s.NearestBuildPos, "#00ff7f");
                        if (s.RedAlert && s.HasThreatAnchor) pt("THREAT", s.ThreatAnchor, "#ff2d2d");
                        if (Bot.FocusActive) pt("GO", Bot.FocusPos, "#ffffff");
                        if (s.DoorAnchors != null)
                            for (int di = 0; di < s.DoorAnchors.Length; di++)
                            {
                                // state colour: covered=orange, parked=grey,
                                // open=red ring — label carries unit count
                                int du = BotPerception.DoorUnitAt(di);
                                string dc = BotPerception.DoorParkedAt(di) >= 0f
                                    ? "#777" : (du > 0 ? "#ff9e00" : "#ff2d2d");
                                pt("door" + di + "·" + du, s.DoorAnchors[di], dc);
                            }
                        // live foes (cheap: TagManager already tracks them)
                        try
                        {
                            var tm2 = TagManager.instance;
                            if (tm2 != null && tm2.EnemyUnits != null)
                            {
                                int foeN = 0;
                                foreach (var e in tm2.EnemyUnits)
                                {
                                    if (e == null || ++foeN > 40) continue;
                                    pt("foe", e.transform.position, "#ff4d4d");
                                }
                            }
                        }
                        catch (Exception) { }
                        sb.Append("]");
                        // nav polyline — the actual path the hero is walking
                        var wps = Bot.NavPathPoints;
                        if (wps != null)
                        {
                            sb.Append(",\"ln\":[");
                            bool firstPt = true;
                            foreach (var wp in wps)
                            {
                                var sp = cam.WorldToScreenPoint(wp);
                                if (sp.z <= 0f) continue;
                                sb.Append(firstPt ? "" : ",")
                                  .Append("[")
                                  .Append(Mathf.RoundToInt(sp.x))
                                  .Append(",")
                                  .Append(Mathf.RoundToInt(Screen.height - sp.y))
                                  .Append("]");
                                firstPt = false;
                            }
                            sb.Append("]");
                        }
                        sb.Append("}");
                        File.WriteAllText(tmp, sb.ToString());
                        if (File.Exists(mk)) File.Delete(mk);
                        File.Move(tmp, mk);
                    }
                }
                catch (Exception) { }
            }
            // While the in-game stream (LiveLink, src/LiveLink.cs) is up, the synchronous screenshots below would only stutter the game
            // (full-resolution grab + encode on the game thread = 100-500 ms hitches): live.jpg stops entirely, live.png drops to
            // LiveShotLinkedEvery. With no link they behave exactly as before - that is the fallback.
            bool linked = LiveLink.Connected;
            if (!linked && nextLiveShot > Time.unscaledTime + LiveShotEvery)
                nextLiveShot = Time.unscaledTime + LiveShotEvery;   // the link dropped: back to the 2 s cadence now, not after the leftover 30 s
            if (LiveShot && Time.unscaledTime >= nextLiveShot &&
                !(linked && LiveShotLinkedEvery <= 0f))     // 0 = linked means NO live.png at all
            {
                nextLiveShot = Time.unscaledTime + (linked ? LiveShotLinkedEvery : LiveShotEvery);
                try
                {
                    var tex = ScreenCapture.CaptureScreenshotAsTexture();
                    if (tex != null)
                    {
                        FramePerf.Shot(2);
                        var lp = Path.Combine(Recorder.AgentDir, "live.png");
                        var tmp = lp + ".tmp";
                        File.WriteAllBytes(tmp, tex.EncodeToPNG());
                        if (File.Exists(lp)) File.Delete(lp);
                        File.Move(tmp, lp);   // atomic — server polls live.png
                        UnityEngine.Object.Destroy(tex);
                    }
                }
                catch (Exception) { }
            }
            // Fast feed: JPEG at ~2.5 fps for the Live pane — PNG encode is
            // ~4x slower and the file is ~5x heavier; vision keeps live.png.
            if (LiveShot && !linked && Time.unscaledTime >= nextLiveShotFast)
            {
                nextLiveShotFast = Time.unscaledTime + LiveShotFastEvery;
                try
                {
                    var tex = ScreenCapture.CaptureScreenshotAsTexture();
                    if (tex != null)
                    {
                        FramePerf.Shot(1);
                        var lj = Path.Combine(Recorder.AgentDir, "live.jpg");
                        var tmp = lj + ".tmp";
                        File.WriteAllBytes(tmp, tex.EncodeToJPG(55));
                        if (File.Exists(lj)) File.Delete(lj);
                        File.Move(tmp, lj);
                        UnityEngine.Object.Destroy(tex);
                    }
                }
                catch (Exception) { }
            }
            if (Time.unscaledTime >= nextCmdPoll)
            {
                nextCmdPoll = Time.unscaledTime + 1f;   // was 4 s — click-to-command needs near-live latency
                PollCommands();
            }
            ApplyPendingFocus();
            FramePerf.Mark(FramePerf.SecCoach, perfT);
        }

        private static float nextCmdPoll;
        private static string lastCmdText = "";   // content-level dedupe
        private static string pendingFocus;        // ui click → aim target name

        /// <summary>Resolve a pending "focus" order into a world point the
        /// hero walks to (doors, castle, threat anchor or named build slot).</summary>
        private static void ApplyPendingFocus()
        {
            if (pendingFocus == null) return;
            var s = BotPerception.Last;
            if (!BotPerception.LastValid) { pendingFocus = null; return; }
            var f = pendingFocus; pendingFocus = null;
            Vector3 pos; bool found = true;
            var dm = System.Text.RegularExpressions.Regex.Match(f, "^door(\\d+)");
            if (dm.Success)
            {
                int di = int.Parse(dm.Groups[1].Value);
                if (s.DoorAnchors != null && di >= 0 && di < s.DoorAnchors.Length)
                    pos = s.DoorAnchors[di];
                else { found = false; pos = s.HeroPos; }
            }
            else if (f == "castle") pos = s.CastlePos;
            else if (f == "threat") pos = s.ThreatAnchor;
            else if (f.StartsWith("bld:") && (UnityEngine.Object)(object)s.NearestBuild != (UnityEngine.Object)null
                     && s.NearestBuildName == f.Substring(4)) pos = s.NearestBuildPos;
            else { found = false; pos = s.HeroPos; }
            if (!found) { Plugin.Log?.LogInfo("[coach] focus ignored: " + f); return; }
            Bot.SetFocus(pos, 20f);
            Plugin.Log?.LogInfo($"[coach] focus -> {f} @({pos.x:0},{pos.z:0}) for 20s");
        }

        /// <summary>tools/coach-server.py writes agent/coach-commands.json
        /// whenever the user (via chat) issues a strategy override. Same
        /// schema as the advisor reply — apply it like a coach answer.</summary>
        private static void PollCommands()
        {
            try
            {
                var p = Path.Combine(Recorder.AgentDir, "coach-commands.json");
                if (!File.Exists(p)) return;
                string j = File.ReadAllText(p);
                // Content identity, not GetHashCode — a collision or A->B->A
                // file transition used to silently drop real commands.
                if (j == lastCmdText) return;
                // Commit the dedupe AFTER Apply — a malformed-but-new file
                // used to burn the dedupe key, then a corrected rewrite with
                // identical bytes could never get through (server retry).
                Apply(j, "user-cmd", Time.unscaledTime);
                lastCmdText = j;
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[coach] cmd poll: {ex.Message}"); }
        }

        /// <summary>Fire an advisory call if the throttle allows. Runs on a
        /// worker thread — the game thread never waits on the LLM.</summary>
        public static void Advise(string trigger, string digestJson)
        {
            if (!Enabled || hostRef == null || Busy) return;
            if (Time.unscaledTime - lastCallAt < MinIntervalS) return;
            Busy = true;
            float callNow = Time.unscaledTime;   // captured on the main thread —
            // Unity API is forbidden on the worker below
            int gen = runGen;                    // if a retry resets mid-flight,
            // Apply() discards the stale advisory instead of re-stamping
            try
            {
                var t = new System.Threading.Thread(() => Call(trigger, digestJson, callNow, gen));
                t.IsBackground = true;
                t.Start();
                lastCallAt = Time.unscaledTime;  // throttle commits only after
            }                                    // a successful spawn — a failed
            catch { Busy = false; }   // a failed spawn must not wedge the coach
        }

        private static void Call(string trigger, string digest, float callNow, int gen)
        {
            var sw = System.Diagnostics.Stopwatch.StartNew();
            try
            {
                string body =
                    "{\"model\":\"" + Esc(Model ?? "") + "\",\"stream\":false," +
                    "\"max_tokens\":" + MaxTokens + ",\"temperature\":0.3," +
                    "\"messages\":[" +
                    "{\"role\":\"system\",\"content\":\"" + Esc(SysPrompt) + "\"}," +
                    "{\"role\":\"user\",\"content\":\"" +
                        Esc("trigger=" + trigger + "\n" + digest) + "\"}]}";
                var req = (HttpWebRequest)WebRequest.Create(Url);
                req.Method = "POST";
                req.ContentType = "application/json";
                req.Timeout = 60000;
                if (!string.IsNullOrEmpty(ApiKey))
                    req.Headers["Authorization"] = "Bearer " + ApiKey;
                byte[] bytes = Encoding.UTF8.GetBytes(body);
                req.ContentLength = bytes.Length;
                using (var st = req.GetRequestStream()) st.Write(bytes, 0, bytes.Length);
                string resp;
                using (var r = (HttpWebResponse)req.GetResponse())
                using (var rd = new StreamReader(r.GetResponseStream()))
                    resp = rd.ReadToEnd();
                CallsMade++;
                LastLatencyMs = (int)sw.ElapsedMilliseconds;
                LastTrigger = trigger;
                var um = System.Text.RegularExpressions.Regex.Match(
                    resp, "\"total_tokens\"\\s*:\\s*(\\d+)");
                if (um.Success) TokensUsed += int.Parse(um.Groups[1].Value);
                var cm = System.Text.RegularExpressions.Regex.Match(
                    resp, "\"content\"\\s*:\\s*\"((?:[^\"\\\\]|\\\\.)*)\"");
                if (cm.Success)
                {
                    if (gen != runGen)
                        Plugin.Log?.LogInfo("[coach] stale-run advisory discarded");
                    else Apply(Unesc(cm.Groups[1].Value), trigger, callNow);
                }
                else Plugin.Log?.LogWarning("[coach] no content in response");
            }
            catch (Exception ex)
            {
                Failures++;
                Plugin.Log?.LogWarning($"[coach] {trigger} call failed: {ex.Message}");
            }
            Busy = false;
        }

        /// <summary>A fresh user-cmd (MiniMax watch / UI order) pins the override
        /// set for this long; while pinned, advisory replies (Grandmaster,
        /// day-start/eff-collapse/coach-beat) update LastAdvice only — they were
        /// stomping MiniMax's steering mid-run (army 60 -> 40, squad 12).</summary>
        private static float userCmdPinUntil;

        /// <summary>Parse the JSON patch and apply overrides (clamped sane).</summary>
        private static void Apply(string content, string trigger, float callNow)
        {
            int i0 = content.IndexOf('{'), i1 = content.LastIndexOf('}');
            if (i0 < 0 || i1 <= i0) { Plugin.Log?.LogWarning("[coach] advice not JSON"); return; }
            string j = content.Substring(i0, i1 - i0 + 1);
            // PRESENT-KEYS-ONLY semantics: Num() returns 0 for a missing key,
            // so a partial patch like {"build_focus":"military"} used to wipe
            // every other override to 0 — the silent "commands apply but the
            // army plan vanishes" bug. Only a key that's actually present
            // changes its field.
            bool fromFile = trigger == "user-cmd";
            if (fromFile) userCmdPinUntil = Time.unscaledTime + 240f;
            // Advisory replies send 0 = "no change" per the schema; Apply used
            // to store the 0 and CLEAR the override. Zeros only mean "release"
            // on the user-cmd path (the server's clear:true expands to zeros).
            bool locked = !fromFile && Time.unscaledTime < userCmdPinUntil;
            bool AdNum(string jx, string k, out int v) => TryNum(jx, k, out v) && (fromFile || v != 0);
            if (!locked)
            {
                if (AdNum(j, "squad_size", out int v1)) SquadSize = ClampInt(v1, 0, 12);
                if (AdNum(j, "reserve_size", out int v2)) ReserveSize = ClampInt(v2, 0, 16);
                if (AdNum(j, "escort_size", out int v3)) EscortSize = ClampInt(v3, 0, 8);
                if (AdNum(j, "army_target", out int v4)) ArmyTargetFloor = ClampInt(v4, 0, 120);
                if (TryStr(j, "build_focus", out string f) && (fromFile || !string.IsNullOrEmpty(f))) BuildFocus = f;
                if (TryStr(j, "hero_posture", out string hp) && (fromFile || !string.IsNullOrEmpty(hp))) HeroPosture = hp;
                if (TryBool(j, "night_call", out bool nc) && nc)
                    NightCallRequested = true;            // advisory flag — brain still gates
            }
            // Live-view click-to-command: {"focus":"door2"|"castle"|"threat"|"bld:<name>"}
            // Resolved on the main thread next PerFrame (worker thread can't
            // touch Unity objects).
            if (TryStr(j, "focus", out string fo) && !string.IsNullOrEmpty(fo))
                pendingFocus = fo;
            if (TryStr(j, "note", out string note) && !string.IsNullOrEmpty(note)) LastAdvice = note;
            var rest = new System.Collections.Generic.List<string>();
            foreach (System.Text.RegularExpressions.Match xm in
                new System.Text.RegularExpressions.Regex("\"(\\w+)\"\\s*:").Matches(j))
                if (!KnownKeys.Contains(xm.Groups[1].Value))
                    rest.Add(xm.Groups[1].Value);
            if (rest.Count > 0)
                Plugin.Log?.LogWarning("[coach] unhandled keys: " + string.Join(",", rest));
            LastAdviceAt = callNow;   // worker thread — no Unity API here
            Plugin.Log?.LogInfo(
                $"[coach] {trigger} -> squad={SquadSize} reserve={ReserveSize} " +
                $"escort={EscortSize} army>={ArmyTargetFloor} focus={BuildFocus} " +
                $"posture={HeroPosture} :: {LastAdvice}");
        }

        private static int Num(string j, string key)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
            return m.Success ? int.Parse(m.Groups[1].Value) : 0;
        }

        private static string Str(string j, string key)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
            return m.Success ? m.Groups[1].Value : "";
        }

        public static bool NightCallRequested;
        private static readonly System.Collections.Generic.HashSet<string> KnownKeys =
            new System.Collections.Generic.HashSet<string>
            { "squad_size", "reserve_size", "escort_size", "army_target",
              "build_focus", "hero_posture", "night_call", "note", "focus" };

        private static bool TryBool(string j, string key, out bool v)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*(true|false)");
            v = m.Success && m.Groups[1].Value == "true";
            return m.Success;
        }

        private static bool TryNum(string j, string key, out int v)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
            v = m.Success ? int.Parse(m.Groups[1].Value) : 0;
            return m.Success;
        }

        private static bool TryStr(string j, string key, out string v)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
            v = m.Success ? m.Groups[1].Value : null;
            return m.Success;
        }

        /// <summary>Run-start reset: coach overrides were persisting across
        /// matches/scenes — a squad_size issued hours ago silently steered the
        /// next run. Clear them at each BeginRun; notes stay (advice history).</summary>
        private static volatile int runGen; // bumped per match — the stale-reply
        // check must see the new generation the moment it changes


        public static void ResetRun()
        {
            SquadSize = 0; ReserveSize = 0; EscortSize = 0;
            ArmyTargetFloor = 0; BuildFocus = ""; HeroPosture = "";
            NightCallRequested = false;
            userCmdPinUntil = 0f;       // new run: advisory regains steering until the next user-cmd
            runGen++;                      // in-flight Apply() sees a stale gen
            // Clear the command dedupe — a new run MUST accept the same
            // patch bytes: the server rewrites last_patch on every run and
            // a stale lastCmdText deadlocked steering forever (the plugin
            // deduped the file, the server saw "not applied", retried
            // identical content — permanent mm-watch BROKEN loop).
            lastCmdText = "";
        }

        /// <summary>Defeat screenshot -> local vision model. One call per
        /// defeat only (bounded); writes the analysis as an advisor note.</summary>
        public static void AnalyzeScreenshot(byte[] png, string context)
        {
            if (!VisionEnabled || Busy) return;
            Busy = true;
            string b64 = Convert.ToBase64String(png);
            int gen = runGen;   // 90 s vision call must not stamp stale-run
                                // advice after a ResetRun (same guard as Call)
            try
            {
                var t = new System.Threading.Thread(() => VisionCall(b64, context, gen));
                t.IsBackground = true;
                t.Start();
            }
            catch { Busy = false; }   // failed spawn must not wedge the coach
        }

        private static void VisionCall(string b64png, string context, int gen)
        {
            try
            {
                string body =
                    "{\"model\":\"" + Esc(VisionModel ?? "") + "\",\"stream\":false," +
                    "\"max_tokens\":600,\"temperature\":0.3,\"messages\":[{" +
                    "\"role\":\"user\",\"content\":[{" +
                    "{\"type\":\"text\",\"text\":\"" + Esc(
                        "Thronefall autopilot just failed/survived a wave. " +
                        "Describe: where enemies are, where units are posted, " +
                        "what the hero is doing, what went wrong, one fix. " +
                        context) + "\"}," +
                    "{\"type\":\"image_url\",\"image_url\":{\"url\":" +
                    "\"data:image/png;base64," + b64png + "\"}}]}]}";
                var req = (HttpWebRequest)WebRequest.Create(Url);
                req.Method = "POST";
                req.ContentType = "application/json";
                req.Timeout = 90000;
                if (!string.IsNullOrEmpty(ApiKey))
                    req.Headers["Authorization"] = "Bearer " + ApiKey;
                byte[] bytes = Encoding.UTF8.GetBytes(body);
                req.ContentLength = bytes.Length;
                using (var st = req.GetRequestStream()) st.Write(bytes, 0, bytes.Length);
                string resp;
                using (var r = (HttpWebResponse)req.GetResponse())
                using (var rd = new StreamReader(r.GetResponseStream()))
                    resp = rd.ReadToEnd();
                var cm = System.Text.RegularExpressions.Regex.Match(
                    resp, "\"content\"\\s*:\\s*\"((?:[^\"\\\\]|\\\\.)*)\"");
                if (cm.Success)
                {
                    if (gen == runGen)   // a reset during the call discards it
                    {
                        LastAdvice = Unesc(cm.Groups[1].Value);
                        Plugin.Log?.LogInfo("[coach-vision] " + LastAdvice);
                    }
                }
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[coach-vision] failed: {ex.Message}"); }
            Busy = false;
        }

        private static int ClampInt(int v, int lo, int hi)
        { return v < lo ? lo : (v > hi ? hi : v); }

        private static string Esc(string s)
        {
            // All control chars <0x20 must escape — a stray \t/\f in a digest
            // produced invalid request JSON (every advisory failed that run).
            var sb = new System.Text.StringBuilder(s.Length + 8);
            foreach (char c in s)
            {
                if (c == '\\') sb.Append("\\\\");
                else if (c == '"') sb.Append("\\\"");
                else if (c == '\n') sb.Append("\\n");
                else if (c == '\r') { }                     // drop
                else if (c < 0x20) sb.Append("\\u").Append(((int)c).ToString("x4"));
                else sb.Append(c);
            }
            return sb.ToString();
        }

        private static string Unesc(string s)
        {
            // Single-pass unescape — sequential Replace corrupted \\n into a
            // literal newline (audit: "\\\\n" came out as '\' + newline).
            var sb = new System.Text.StringBuilder(s.Length);
            for (int i = 0; i < s.Length; i++)
            {
                if (s[i] == '\\' && i + 1 < s.Length)
                {
                    char n = s[i + 1];
                    if (n == 'n') { sb.Append('\n'); i++; continue; }
                    if (n == 't') { sb.Append('\t'); i++; continue; }
                    if (n == 'r') { sb.Append('\r'); i++; continue; }
                    if (n == '"') { sb.Append('"'); i++; continue; }
                    if (n == '\\') { sb.Append('\\'); i++; continue; }
                    if (n == '/') { sb.Append('/'); i++; continue; }
                    if (n == 'u' && i + 5 < s.Length &&
                        int.TryParse(s.Substring(i + 2, 4),
                            System.Globalization.NumberStyles.HexNumber, null, out int cv))
                    { sb.Append((char)cv); i += 5; continue; }
                }
                sb.Append(s[i]);
            }
            return sb.ToString();
        }
    }
}

