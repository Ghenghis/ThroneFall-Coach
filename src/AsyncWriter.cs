using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;

namespace ThronefallTrainer
{
    /// <summary>
    /// File writes off the game thread. A synchronous write-tmp / delete / move costs the game thread 0.2-0.5 ms when the disk is quiet and 5-20 ms
    /// when an antivirus scanner or a slow drive gets involved; view.json (20 Hz), caps.json and perf.json used to pay that on the frame that wrote them.
    /// Now the caller only stores the text (a lock and a dictionary assignment) and a below-normal background thread does the I/O.
    ///   Write(path, text)         atomic replace (tmp file + delete + move, retried when a reader holds the file), LATEST WINS per path: if the
    ///                             thread has not got to an older text yet, only the newest is written
    ///   Append(path, text, cap)   appended in order (the queue is bounded, extra lines are dropped); above `cap` bytes the file is rewritten with
    ///                             trim(content) (perf-stalls.jsonl keeps its newest half)
    /// Nothing here ever throws into the caller; a failed write is counted (Failures) and the next one is tried.
    /// </summary>
    internal static class AsyncWriter
    {
        private sealed class AppendJob { public string Path, Text; public int Cap; public Func<string, string> Trim; }

        private static readonly object gate = new object();
        private static readonly Dictionary<string, string> latest = new Dictionary<string, string>();
        private static readonly List<AppendJob> appends = new List<AppendJob>();
        private static readonly AutoResetEvent wake = new AutoResetEvent(false);
        private static Thread thread;
        private static bool busy;
        private const int MaxQueuedAppends = 256;

        public static int Failures, Written;                 // diagnostics (read by tests)

        /// <summary>Start the writer thread now (plugin load) instead of at the first write (a frame of play).</summary>
        public static void Warm() { lock (gate) Ensure(); }

        public static void Write(string path, string text)
        {
            if (path == null || text == null) return;
            lock (gate) { latest[path] = text; Ensure(); }
            wake.Set();
        }

        public static void Append(string path, string text, int capBytes, Func<string, string> trim)
        {
            if (path == null || text == null) return;
            lock (gate)
            {
                if (appends.Count < MaxQueuedAppends) appends.Add(new AppendJob { Path = path, Text = text, Cap = capBytes, Trim = trim });
                Ensure();
            }
            wake.Set();
        }

        /// <summary>For tests / shutdown: true when everything queued so far has been written (or failed).</summary>
        public static bool WaitIdle(int timeoutMs)
        {
            var sw = System.Diagnostics.Stopwatch.StartNew();
            for (;;)
            {
                lock (gate) { if (latest.Count == 0 && appends.Count == 0 && !busy) return true; }
                if (sw.ElapsedMilliseconds >= timeoutMs) return false;
                Thread.Sleep(2);
            }
        }

        private static void Ensure()                          // under `gate`
        {
            if (thread != null) return;
            thread = new Thread(Run) { IsBackground = true, Name = "Trainer-writer", Priority = ThreadPriority.BelowNormal };
            thread.Start();
        }

        private static void Run()
        {
            for (;;)
            {
                try
                {
                    wake.WaitOne(500);
                    KeyValuePair<string, string>[] w = null; AppendJob[] a = null;
                    lock (gate)
                    {
                        if (latest.Count > 0) { w = new KeyValuePair<string, string>[latest.Count]; int i = 0; foreach (var kv in latest) w[i++] = kv; latest.Clear(); }
                        if (appends.Count > 0) { a = appends.ToArray(); appends.Clear(); }
                        busy = w != null || a != null;
                    }
                    if (w != null) foreach (var kv in w) Atomic(kv.Key, kv.Value);
                    if (a != null) foreach (var j in a) DoAppend(j);
                }
                catch (Exception) { Interlocked.Increment(ref Failures); }
                finally { lock (gate) busy = false; }
            }
        }

        /// <summary>tmp + delete + move, the same sequence the game thread used to run, retried a few times because a reader that has the file open
        /// (livecap, the coach server) makes the delete fail for a few milliseconds.</summary>
        private static void Atomic(string path, string text)
        {
            for (int attempt = 0; attempt < 4; attempt++)
            {
                try
                {
                    string tmp = path + ".tmp";
                    File.WriteAllText(tmp, text);
                    if (File.Exists(path)) File.Delete(path);
                    File.Move(tmp, path);
                    Interlocked.Increment(ref Written);
                    return;
                }
                catch (Exception) { Thread.Sleep(2 + attempt * 3); }
            }
            Interlocked.Increment(ref Failures);
        }

        private static void DoAppend(AppendJob j)
        {
            try
            {
                File.AppendAllText(j.Path, j.Text);
                Interlocked.Increment(ref Written);
                if (j.Cap > 0 && j.Trim != null && new FileInfo(j.Path).Length > j.Cap)
                    Atomic(j.Path, j.Trim(File.ReadAllText(j.Path)));
            }
            catch (Exception) { Interlocked.Increment(ref Failures); }
        }
    }
}
