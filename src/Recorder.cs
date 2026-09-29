using System;
using System.Collections.Concurrent;
using System.Globalization;
using System.IO;
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
        private static bool running;

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
                runId = id;
                runDir = Path.Combine(AgentDir, "runs", id);
                Directory.CreateDirectory(runDir);
                ticksPath = Path.Combine(runDir, "ticks.jsonl");
                eventsPath = Path.Combine(runDir, "events.jsonl");
                summaryPath = Path.Combine(runDir, "summary.json");
                tickCount = dropped = heroDeaths = snaps = unsticks = stalls = 0;
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
            if (runDir == null) BeginRun("unknown");
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
            int sec = (int)(UnityEngine.Time.unscaledTime - tStart);
            if (sec == lastTickSecond) return;   // caller emits ~2 Hz already;
            // this guard just dedupes accidental double-calls in the same second
            lastTickSecond = sec;
            Enq(ticksPath, compactLine);
            tickCount++;
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
                    "\"recorder\":{\"ticks\":" + tickCount + ",\"dropped\":" + dropped +
                    ",\"ioErrors\":" + ioErrors + "}}";
                File.WriteAllText(summaryPath, json);
                Event("match-end", "\"result\":\"" + J(result) + "\"");
                // Index line into episodic memory (spec §5: one line per run).
                Enq(Path.Combine(AgentDir, Path.Combine("memory", "episodic"), "index.jsonl"), json);
            }
            catch { ioErrors++; }
        }

        private static void Enq(string path, string line)
        {
            if (q.Count >= QueueCap)
            {
                dropped++;
                return;
            }
            // One queue item carries its target file — one writer thread can
            // service ticks + events + index with a single handle set.
            q.Enqueue(path + "\u0001" + line);
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
                catch { ioErrors++; Thread.Sleep(250); }
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
    }
}
