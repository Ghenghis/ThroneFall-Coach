using System;
using System.Collections.Concurrent;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using BepInEx;

namespace ThronefallTrainer
{
    /// <summary>
    /// Run recorder (v3 design §3.4/P8): per-run <c>agent/runs/&lt;runId&gt;/</c>
    /// with a 2 Hz compact-DTO tick stream, the event/notes stream, and a
    /// one-shot summary.json at match end. All writes funnel through one
    /// bounded queue drained by a background thread — Tick is never blocked
    /// by disk IO. On overflow the oldest lines drop and are counted in
    /// <c>summary.json.recorder.dropped</c>.
    /// </summary>
    internal static class Recorder
    {
        public const int QueueCap = 2000;
        private static readonly ConcurrentQueue<string> q = new ConcurrentQueue<string>();

        private static Thread writer;
        private static readonly object writerLock = new object();
        private static volatile bool running;   // Drain() reads it outside the lock

        private static string runId;
        private static string runDir;
        private static string ticksPath, eventsPath, summaryPath;
        private static int tickCount, dropped, lastTickSecond = -1;
        private static int ioErrors;

        // summary accumulation
        private static float tStart;
        private static float castleHpMinSeen = 1f;
        private static int heroDeaths, snaps, unsticks, stalls;
        private static string lastScene = "";
        private static int lastWave;
        private static float lastGold = -1f;

        public static string RunId => runId;
        public static int Ticks => tickCount;
        public static int Dropped => dropped;

        /// <summary>Agent data dir: BepInEx/plugins/agent/.</summary>
        public static string AgentDir
        {
            get
            {
                try { return Path.Combine(Paths.PluginPath, "agent"); }
                catch { return "agent"; }
            }
        }

        /// <summary>Start the writer thread. Idempotent.</summary>
        public static void Start()
        {
            lock (writerLock)
            {
                if (running) return;
                running = true;
                writer = new Thread(Drain) { IsBackground = true, Name = "tf-recorder" };
                writer.Start();
            }
        }

        public static void Stop()
        {
            lock (writerLock) { running = false; }
            // Flush the tail — Stop() at plugin unload used to lose the last
            // summary/episodic-index lines when the process exited fast.
            try { writer?.Join(2000); } catch { }
        }

        /// <summary>
        /// Persistent learned navigation anchors (v3 §B2): every snap/wedge
        /// rescue records the scene + spot so steering/policy can avoid or
        /// exploit it later. Written straight through to agent/anchors.json
        /// (small file, low rate — snap events are rare).
        /// </summary>
        public static void NoteAnchor(string scene, float x, float z, string kind)
        {
            try
            {
                var path = Path.Combine(AgentDir, "anchors.json");
                Directory.CreateDirectory(AgentDir);
                var lines = File.Exists(path) ? File.ReadAllLines(path) : new string[0];
                var list = new System.Collections.Generic.List<string>(lines);
                // merge on (scene,kind,~1m bucket): bump hit count if a near
                // identical anchor already exists
                var ci = CultureInfo.InvariantCulture;
                string bx = x.ToString("0.#", ci), bz = z.ToString("0.#", ci);
                for (int i = list.Count - 1; i >= 0; i--)
                {
                    var e = list[i];
                    if (!e.Contains("\"s\":\"" + scene + "\"") || !e.Contains("\"k\":\"" + kind + "\"")) continue;
                    float ex = JFloat(e, "\"x\":"), ez = JFloat(e, "\"z\":");
                    if (Math.Abs(ex - x) > 3f || Math.Abs(ez - z) > 3f) continue;
                    int hits = (int)JFloat(e, "\"hits\":") + 1;
                    list[i] = string.Format(ci,
                        "{{\"s\":\"{0}\",\"k\":\"{1}\",\"x\":{2},\"z\":{3},\"hits\":{4}}}",
                        scene, kind, bx, bz, hits);
                    WriteAtomic(path, string.Join("\n", list));
                    return;
                }
                list.Add(string.Format(ci,
                    "{{\"s\":\"{0}\",\"k\":\"{1}\",\"x\":{2},\"z\":{3},\"hits\":1}}",
                    scene, kind, bx, bz));
                WriteAtomic(path, string.Join("\n", list));
            }
            catch { }
        }

        private static float JFloat(string json, string key)
        {
            int i = json.IndexOf(key, StringComparison.Ordinal);
            if (i < 0) return 0f;
            i += key.Length;
            int j = i;
            while (j < json.Length && (char.IsDigit(json[j]) || json[j] == '.' ||
                   json[j] == '-' || json[j] == '+' || json[j] == 'e' || json[j] == 'E')) j++;
            // NumberStyles.Float: digit-scan refused 1e-05 notation → parsed 1.
            float.TryParse(json.Substring(i, j - i), NumberStyles.Float,
                CultureInfo.InvariantCulture, out float v);
            return v;
        }

        /// <summary>
        /// Begin a new run file set. Called at level EnterLevel/gamestate
        /// transitions; safe to call repeatedly — identical runId is a no-op.
        /// </summary>
        public static void BeginRun(string scene)
        {
            try
            {
                string id = DateTime.UtcNow.ToString("yyyyMMddTHHmmssZ",
                        CultureInfo.InvariantCulture) + "-" +
                    (string.IsNullOrEmpty(scene) ? "unknown" : Sanitize(scene));
                // Commit locals AFTER all fallible work — a failed
                // CreateDirectory used to leave runDir set with null paths,
                // silently dropping every tick until the next run (audit #3).
                string dir = Path.Combine(AgentDir, "runs", id);
                Directory.CreateDirectory(dir);
                runId = id;
                runDir = dir;
                ticksPath = Path.Combine(runDir, "ticks.jsonl");
                eventsPath = Path.Combine(runDir, "events.jsonl");
                summaryPath = Path.Combine(runDir, "summary.json");
                tickCount = dropped = heroDeaths = snaps = unsticks = stalls = 0;
                ruleFires.Clear();
                castleHpMinSeen = 1f;
                lastScene = scene;
                lastWave = 0;
                lastGold = -1f;
                lastTickSecond = -1;
                tStart = UnityEngine.Time.unscaledTime;
                Event("run-start", "\"scene\":\"" + J(scene) + "\"");
            }
            catch { ioErrors++; }
        }

        /// <summary>
        /// Append an event line (notes, transitions, per-run occurrences).
        /// Cheap — enqueue only; the writer thread owns the file.
        /// </summary>
        public static void Event(string note, string extra = null)
        {
            // No phantom "unknown" run dirs — events before the first real
            // BeginRun used to create orphaned runs/<ts>-unknown/ folders.
            if (runDir == null) return;
            Enq(eventsPath, "{" + "\"t\":" + F(UnityEngine.Time.unscaledTime - tStart) +
                ",\"note\":\"" + J(note) + "\"" +
                (extra != null ? "," + extra : "") + "}");
        }

        /// <summary>
        /// 2 Hz compact-DTO tick. Caller passes a pre-formatted line so the
        /// recorder stays decoupled from the snapshot shape during the
        /// SnapshotData refactor (Phase 0).
        /// </summary>
        public static void Tick(string compactLine)
        {
            // Half-second bucket: whole-second dedupe threw away ~half the
            // real 2 Hz ticks (tickCount/summary underreported).
            if (ticksPath == null) return;   // Tick before BeginRun — don't
            // count a phantom tick into summary.recorder.ticks.
            int bucket = (int)((UnityEngine.Time.unscaledTime - tStart) * 2f);
            if (bucket == lastTickSecond) return;
            lastTickSecond = bucket;
            if (Enq(ticksPath, compactLine)) tickCount++;   // dropped ticks
            // no longer inflate the tick counter (dropped is tracked by Enq)
        }

        public static void NoteGameFacts(in BotPerception.Snapshot s)
        {
            if (s.Wave > lastWave) lastWave = s.Wave;
            lastGold = s.Balance;
            lastScene = s.SceneName;
        }

        public static void CountSnap() { snaps++; }
        public static void CountUnstick() { unsticks++; }
        public static void CountStall() { stalls++; }
        public static void CountDeath() { heroDeaths++; }
        public static void SeeCastleHp(float pct) { if (pct < castleHpMinSeen) castleHpMinSeen = pct; }

        // Policy rule telemetry: per-rule fire counts ride the summary.
        private static readonly System.Collections.Generic.Dictionary<string, int> ruleFires =
            new System.Collections.Generic.Dictionary<string, int>();
        public static void CountRuleFire(string id)
        {
            ruleFires[id] = ruleFires.TryGetValue(id, out int n) ? n + 1 : 1;
        }

        /// <summary>
        /// Final summary at AfterMatchVictory / AfterMatchDefeat / abandon.
        /// Writes summary.json once; subsequent calls merge over it (the file
        /// is re-written with the latest numbers — idempotent end marker).
        /// </summary>
        public static void MatchEnd(string result, bool legit)
        {
            if (runDir == null) return;
            try
            {
                Directory.CreateDirectory(runDir);
                string json =
                    "{\"runId\":\"" + J(runId) + "\",\"scene\":\"" + J(lastScene) + "\"," +
                    "\"legit\":" + (legit ? "true" : "false") + "," +
                    "\"result\":\"" + J(result) + "\"," +
                    "\"waves\":" + lastWave + "," +
                    "\"durationS\":" + F(UnityEngine.Time.unscaledTime - tStart) + "," +
                    "\"castleHpMin\":" + F(castleHpMinSeen) + "," +
                    "\"heroDeaths\":" + heroDeaths + "," +
                    "\"goldLast\":" + F(lastGold) + "," +
                    "\"stalls\":" + stalls + ",\"unsticks\":" + unsticks + ",\"snaps\":" + snaps + "," +
                    "\"rulesFired\":{" + string.Join(",", System.Linq.Enumerable.Select(
                        ruleFires.ToArray(), kv => "\"" + J(kv.Key) + "\":" + kv.Value)) + "}," +
                    "\"recorder\":{\"ticks\":" + tickCount + ",\"dropped\":" + dropped +
                    ",\"ioErrors\":" + ioErrors + "}}";
                WriteAtomic(summaryPath, json);
                Event("match-end", "\"result\":\"" + J(result) + "\"");
                // Index line into episodic memory (spec §5: one line per run).
                Enq(Path.Combine(AgentDir, "memory", "episodic", "index.jsonl"), json);
            }
            catch { ioErrors++; }
        }

        private static bool Enq(string path, string line)
        {
            // Post-Stop() enqueues sit in a queue nobody drains — silent
            // unbounded grow. Also reject null paths (pre-BeginRun callers).
            if (!running || path == null) return false;
            if (q.Count >= QueueCap)
            {
                dropped++;
                return false;
            }
            // One queue item carries its target file — one writer thread can
            // service ticks + events + index with a single handle set.
            q.Enqueue(path + "\u0001" + line);
            return true;
        }

        private static void Drain()
        {
            while (running || !q.IsEmpty)
            {
                try
                {
                    string item;
                    if (q.TryDequeue(out item))
                    {
                        int sep = item.IndexOf('\u0001');
                        if (sep > 0)
                        {
                            string path = item.Substring(0, sep);
                            string line = item.Substring(sep + 1);
                            var dir = Path.GetDirectoryName(path);
                            if (!string.IsNullOrEmpty(dir)) Directory.CreateDirectory(dir);
                            using (var fs = new FileStream(path, FileMode.Append,
                                FileAccess.Write, FileShare.ReadWrite | FileShare.Delete))
                            using (var sw = new StreamWriter(fs))
                                sw.WriteLine(line);
                        }
                    }
                    else Thread.Sleep(250);   // spec: flush every 250 ms
                }
                catch
                {
                    ioErrors++;
                    dropped++;     // the dequeued item is LOST — count it;
                    Thread.Sleep(250);   // re-enqueue risks an error loop
                }
            }
        }

        private static string J(string s)
        {
            return s == null ? "" : s.Replace("\\", "\\\\").Replace("\"", "\\\"");
        }
        private static string F(float v)
        {
            return v.ToString("0.###", CultureInfo.InvariantCulture);
        }
        private static string Sanitize(string s)
        {
            var chars = s.ToCharArray();
            for (int i = 0; i < chars.Length; i++)
                if (!char.IsLetterOrDigit(chars[i]) && chars[i] != '-' && chars[i] != '_')
                    chars[i] = '_';
            return new string(chars);
        }

        /// <summary>Atomic write: tmp + move. The coach server polls these
        /// files every second — a torn write once poisoned a whole metric.
        /// </summary>
        public static void WriteAtomic(string path, string text)
        {
            if (path == null) return;
            string tmp = path + ".tmp";
            File.WriteAllText(tmp, text);
            // File.Replace is a REAL atomic rename — the delete+move pair
            // left the destination missing to 1 Hz sidecar polls, and a
            // crash in the window destroyed the old file too (audit).
            try
            {
                if (File.Exists(path)) File.Replace(tmp, path, null);
                else File.Move(tmp, path);
            }
            catch (System.IO.FileNotFoundException)
            {
                File.Move(tmp, path);   // destination vanished mid-write
            }
        }
    }

    /// <summary>
    /// tf-agent mailbox (v3 Phase 3): file-based bridge between the in-game
    /// plugin and the external sidecar.
    ///   agent/tf-agent/inbox/*.order  — line-JSON orders, processed then
    ///     moved to inbox/done/ (ops: policy | note | report | loadout)
    ///   agent/tf-agent/outbox/state.json — live run state every ~5 s
    ///   agent/tf-agent/outbox/result-<ts>.json — end-of-run bundle
    /// Bounded and fire-and-forget: bad orders are quarantined to done/
    /// with a `mailbox-reject` event — the game loop never blocks.
    /// </summary>
    internal static class Mailbox
    {
        private static float nextPollAt;
        private static float nextStateAt;

        private static string InboxDir => Path.Combine(Recorder.AgentDir, "tf-agent", "inbox");
        private static string OutboxDir => Path.Combine(Recorder.AgentDir, "tf-agent", "outbox");
        private static string DoneDir => Path.Combine(InboxDir, "done");

        /// <summary>Called every Tick — polls at 1 Hz; state write at 0.2 Hz.</summary>
        public static void Poll(in BotPerception.Snapshot s)
        {
            float now = UnityEngine.Time.unscaledTime;
            if (now >= nextPollAt)
            {
                nextPollAt = now + 1f;
                ProcessInbox(s);
            }
            if (now >= nextStateAt && runDirKnown)
            {
                nextStateAt = now + 5f;
                WriteState(s);
            }
        }

        private static bool runDirKnown => Recorder.RunId != null;

        private static void ProcessInbox(in BotPerception.Snapshot s)
        {
            try
            {
                if (!Directory.Exists(InboxDir)) return;
                foreach (var f in Directory.GetFiles(InboxDir, "*.order"))
                {
                    try
                    {
                        var text = File.ReadAllText(f);
                        Apply(text, in s);
                    }
                    catch (Exception ex)
                    {
                        Plugin.Log?.LogWarning($"[bot] mailbox order failed '{Path.GetFileName(f)}': {ex.Message}");
                        Bot.LogLine(in s, "mailbox-reject");
                    }
                    finally
                    {
                        try
                        {
                            Directory.CreateDirectory(DoneDir);
                            var dst = Path.Combine(DoneDir, Path.GetFileName(f));
                            if (File.Exists(dst)) File.Delete(dst);
                            File.Move(f, dst);
                        }
                        catch { }
                    }
                }
            }
            catch { }
        }

        private static void Apply(string order, in BotPerception.Snapshot s)
        {
            // Line-JSON, minimal key pulls — no serializer needed.
            string op = JVal(order, "\"op\":");
            if (op == null) throw new InvalidDataException("missing op");
            switch (op)
            {
                case "policy":
                {
                    string text = JVal(order, "\"text\":", true);
                    if (text == null) throw new InvalidDataException("policy op needs text");
                    var p = Path.Combine(Recorder.AgentDir, "policy.txt");
                    WriteAtomic(p, text);
                    Bot.LogLine(in s, "mailbox-policy");
                    Plugin.Log?.LogInfo("[bot] mailbox: policy.txt replaced by sidecar");
                    break;
                }
                case "note":
                {
                    string text = JVal(order, "\"text\":", true) ?? "sidecar-note";
                    Recorder.Event("mailbox-note", "\"text\":\"" + text.Replace("\"", "'") + "\"");
                    break;
                }
                case "report":
                {
                    // Drop the current summary-ish state bundle for the sidecar.
                    WriteState(s, "report-" + DateTime.UtcNow.ToString("HHmmss"));
                    Recorder.Event("mailbox-report");
                    break;
                }
                case "loadout":
                {
                    string w = JVal(order, "\"weapon\":", true);
                    if (!string.IsNullOrEmpty(w))
                    {
                        Bot.RequestLoadout(w);
                        Recorder.Event("mailbox-loadout", "\"w\":\"" + w.Replace("\"", "'") + "\"");
                    }
                    break;
                }
                default:
                    throw new InvalidDataException("unknown op '" + op + "'");
            }
        }

        private static void WriteState(in BotPerception.Snapshot s, string name = null)
        {
            try
            {
                Directory.CreateDirectory(OutboxDir);
                var file = Path.Combine(OutboxDir,
                    name == null ? "state.json" : name + ".json");
                string json =
                    "{\"run\":\"" + J(Recorder.RunId ?? "") + "\"," +
                    "\"scene\":\"" + J(s.SceneName) + "\"," +
                    "\"state\":\"" + J(s.GameState) + "\"," +
                    "\"mode\":\"" + J(Bot.Mode.ToString()) + "\"," +
                    "\"wave\":" + s.Wave + ",\"waveTotal\":" + s.WaveTotal + "," +
                    "\"night\":" + (s.IsNight ? "true" : "false") + "," +
                    "\"foes\":" + s.EnemyCount + ",\"hp\":" + F(s.HeroHpPct) + "," +
                    "\"gold\":" + s.Balance + ",\"core\":" + s.CoreBalance + "," +
                    "\"army\":" + s.AllyCount + "," +
                    "\"frame\":\"" + J(Bot.UiFrame) + "\"}";
                WriteAtomic(file, json);
            }
            catch { }
        }

        /// <summary>
        /// Pull a JSON string value. When raw=false the value ends at the
        /// next quote; raw=true consumes to the final quote so embedded
        /// escaped text survives (multiline policy bodies).
        /// </summary>
        private static string JVal(string json, string key, bool raw = false)
        {
            int i = json.IndexOf(key, StringComparison.Ordinal);
            if (i < 0) return null;
            i += key.Length;
            while (i < json.Length && (json[i] == ' ' || json[i] == ':')) i++;
            if (i >= json.Length || json[i] != '"') return null;
            i++;
            // Scan for the closing UNESCAPED quote — quote is escaped only
            // when preceded by an ODD number of backslashes (the single-char
            // check misread \\" as escaped and swallowed following fields).
            int j = i;
            while (j < json.Length)
            {
                if (json[j] == '"')
                {
                    int bs = 0;
                    for (int k = j - 1; k >= i && json[k] == '\\'; k--) bs++;
                    if (bs % 2 == 0) break;
                }
                j++;
            }
            if (j <= i) return null;
            // Single-pass unescape — chained Replace corrupts \\\\n (literal
            // backslash + n, e.g. "C:\\new") by rewriting \\n inside \\\\n.
            var sub = json.Substring(i, j - i);
            var sb = new System.Text.StringBuilder(sub.Length);
            for (int k = 0; k < sub.Length; k++)
            {
                if (sub[k] == '\\' && k + 1 < sub.Length)
                {
                    char e = sub[++k];
                    if (e == 'n') sb.Append('\n');
                    else if (e == 't') sb.Append('\t');
                    else if (e == 'r') sb.Append('\r');
                    else sb.Append(e);      // \" \\ \/ etc pass the char
                }
                else sb.Append(sub[k]);
            }
            return sb.ToString();
        }
        private static string J(string s) => s == null ? "" : s.Replace("\\", "\\\\").Replace("\"", "\\\"");
        private static string F(float v) => v.ToString("0.###", CultureInfo.InvariantCulture);

        /// <summary>Atomic write: tmp + move. The coach server polls these
        /// files every second — a torn write once poisoned a whole metric.
        /// </summary>
        public static void WriteAtomic(string path, string text)
        {
            if (path == null) return;
            string tmp = path + ".tmp";
            File.WriteAllText(tmp, text);
            // File.Replace is a REAL atomic rename — the delete+move pair
            // left the destination missing to 1 Hz sidecar polls, and a
            // crash in the window destroyed the old file too (audit).
            try
            {
                if (File.Exists(path)) File.Replace(tmp, path, null);
                else File.Move(tmp, path);
            }
            catch (System.IO.FileNotFoundException)
            {
                File.Move(tmp, path);   // destination vanished mid-write
            }
        }
    }
}
