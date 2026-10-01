using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>Single source of truth for efficiency standards. Written to
    /// agent/benchmarks.json at start so reports and the dashboard read the
    /// same numbers the bot is scored against.</summary>
    internal static class Bench
    {
        public const float WalkSpeed = 16f;       // m/s, measured p90 hero speed (17k Durststein ticks)
        public const float FillS = 4.5f;          // s, measured median first-pay -> build-done (143 builds)
        public const float TargetUsefulPct = 85f; // est. target share of non-neutral time spent useful
        public const float TargetBuildEff = 60f; // est. target per-build task efficiency
        public const float TargetEffScore = 80f;  // live Efficiency.Score target
        public const float BaselineUsefulPct = 75.2f; // measured: same tick classifier back-tested on the 60 runs (13.3 h) before this change
        public const float BaselineProductivePct = 65.2f;
        public const float BaselineActivePct = 7.3f;  // measured: seconds within 2 s of a pay/build-done event, 85 runs / 17.9 h
        public const float TargetActivePct = 50f;     // estimate: walk + hold cycle cannot be 100 %; ceiling est. ~65 %

        public static string Json() => "{\"walk_speed_mps\":{\"v\":16,\"src\":\"measured p90, 17477 ticks\"}," +
            "\"fill_s\":{\"v\":4.5,\"src\":\"measured median first pay to build-done, 143 builds\"}," +
            "\"target_useful_pct\":{\"v\":85,\"src\":\"estimate\"}," +
            "\"target_build_eff\":{\"v\":60,\"src\":\"estimate\"}," +
            "\"target_eff_score\":{\"v\":80,\"src\":\"estimate\"}," +
            "\"baseline_useful_pct\":{\"v\":75.2,\"src\":\"measured: tick classifier back-tested on 60 pre-change runs, 13.3h\"}," +
            "\"baseline_active_pct\":{\"v\":7.3,\"src\":\"measured strict: 2s buckets with pay/build-done, 85 runs 17.9h\"}," +
            "\"target_active_pct\":{\"v\":50,\"src\":\"estimate; ceiling est. 65\"}," +
            "\"baseline_productive_pct\":{\"v\":65.2,\"src\":\"measured 196 runs 36h\"}," +
            "\"human_ref\":{\"v\":236,\"src\":\"Steam Duststein bonus-mode gold puzzle best score thread (gold), not a speed figure\"}}";
    }

    /// <summary>
    /// Per-task efficiency ledger. Every second of live play belongs to one
    /// task (a build, a coin run, a defence span, idle...). Each task gets a
    /// start, duration, outcome and 0-100 efficiency; builds are verified
    /// afterwards and a missed result re-queues the work. Also keeps day and
    /// night reports, scores MiniMax advice by what happened after it, and
    /// exposes a code-only supervisor filter that decides when to wake the LLM.
    /// </summary>
    internal static class Tasks
    {
        sealed class Agg { public int N, Ok, Fail, NEff; public float Dur, EffSum, Gold, Walk, Useful, Wasted; }
        sealed class Cur
        {
            public string Kind, Label; public float T0, Gold0, D0, Walk, Useful, Wasted;
            public int Ally0, Door0, Key; public float Maxed0; public bool Progress; public string Outcome = "";
        }

        static readonly Dictionary<string, Agg> agg = new Dictionary<string, Agg>();
        static readonly List<string> recent = new List<string>();
        static readonly List<string> reports = new List<string>();
        static readonly List<string> fx = new List<string>();
        static Cur cur;
        static Vector2 lastPos; static bool havePos; static float lastT = -1f;
        static int lastBal = -1;
        static bool prevNight, havePhase;
        static float phT0, phWaste0, phSpent, phEffSum, phSec, phUseful, phWasted; static int phBuilds, phAlly0, phMaxed0;
        static float verifyAt; static int verifyMaxed; static string verifyName = "";
        static float nextForgive, fxAt, fxBase; static string fxTrig = ""; static float seenAdviceAt;
        static readonly Queue<float> failTimes = new Queue<float>();
        static float goldIdleSince = -1f, benchWritten;
        static StreamWriter log;
        static long buildStamp;
        static readonly Queue<Vector2> maxHist = new Queue<Vector2>();
        public static int Misses, Verified, Micro, TotalTasks;
        public static float Useful, Wasted, ActiveS, TotalS, lastActAt = -99f;
        static float phActive;
        public static float ActivePct => TotalS > 5f ? 100f * ActiveS / TotalS : 0f;
        public static string WorstKind = "";

        public static float UsefulPct => (Useful + Wasted) > 1f ? 100f * Useful / (Useful + Wasted) : 0f;

        public static void Reset()
        {
            ActiveS = 0f; TotalS = 0f; lastActAt = -99f; cur = null; havePos = false; lastT = -1f; lastBal = -1; havePhase = false;
            verifyAt = 0f; goldIdleSince = -1f; failTimes.Clear(); maxHist.Clear(); pending.Clear();
        }

        static void Open(string kind, string label, in BotPerception.Snapshot s, float now)
        {
            cur = new Cur { Kind = kind, Label = label, T0 = now, Gold0 = s.Balance, D0 = (s.NearestBuild != null) ? s.NearestBuildDist : 0f,
                Ally0 = s.AllyCount, Door0 = s.DoorsCovered, Maxed0 = BotPerception.MaxLevelSum, Key = s.NearestBuildKey };
        }

        static void Close(string outcome, in BotPerception.Snapshot s, float now)
        {
            if (cur == null) return;
            var c = cur; cur = null;
            float dur = now - c.T0;
            if (dur < 1.5f) { Micro++; return; }
            float spent = Mathf.Max(0f, c.Gold0 - s.Balance);
            bool prog = spent > 0 || s.AllyCount > c.Ally0 || s.DoorsCovered > c.Door0;
            if (c.Kind == "build" && spent > 0 && outcome != "fail" && BotPerception.MaxLevelSum <= c.Maxed0)
            { pending.Add(new Pend { C = c, Outcome = outcome, Now = now, Dur = dur, Spent = spent, Prog = prog, Due = now + 4f }); return; }
            Finalize(c, outcome, now, dur, spent, prog);
        }

        sealed class Pend { public Cur C; public string Outcome; public float Now, Dur, Spent, Due; public bool Prog; }
        static readonly List<Pend> pending = new List<Pend>();

        static void Finalize(Cur c, string outcome, float now, float dur, float spent, bool prog)
        {            string kindKey = c.Kind == "build" ? "build:" + c.Label : c.Kind;
            float eff;
            if (c.Kind == "build")
            {
                float ideal = c.D0 / Bench.WalkSpeed + Bench.FillS;
                float f = Mathf.Min(1f, ideal / Mathf.Max(0.1f, dur)) * 100f;
                if (outcome != "fail" && spent > 0 && BotPerception.MaxLevelSum > c.Maxed0) outcome = "ok";
                eff = outcome == "ok" ? f : outcome == "partial" ? f * 0.5f : 0f;
            }
            else
            {
                float den = c.Useful + c.Wasted;
                eff = den > 0.5f ? 100f * c.Useful / den : -1f;
                if (outcome == "") outcome = prog || c.Useful > c.Wasted ? "ok" : "none";
            }
            if (!agg.TryGetValue(kindKey, out var a)) agg[kindKey] = a = new Agg();
            a.N++; a.Dur += dur; a.Gold += spent; a.Walk += c.Walk; a.Useful += c.Useful; a.Wasted += c.Wasted;
            if (outcome == "ok") a.Ok++; else if (outcome == "fail") a.Fail++;
            if (eff >= 0f) { a.EffSum += eff; a.NEff++; }
            TotalTasks++;
            if (outcome == "fail") { failTimes.Enqueue(now); }
            var sb = new StringBuilder(160);
            sb.Append("{\"t\":").Append(now.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"kind\":").Append(BotPerception.JsonStr(kindKey))
              .Append(",\"dur\":").Append(dur.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"out\":").Append(BotPerception.JsonStr(outcome))
              .Append(",\"eff\":").Append(Mathf.RoundToInt(eff))
              .Append(",\"gold\":").Append((int)spent)
              .Append(",\"walk\":").Append(Mathf.RoundToInt(c.Walk))
              .Append(",\"use_s\":").Append(c.Useful.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"waste_s\":").Append(c.Wasted.ToString("0.0", CultureInfo.InvariantCulture)).Append('}');
            string line = sb.ToString();
            recent.Add(line); if (recent.Count > 12) recent.RemoveAt(0);
            Write(line);
            if (c.Kind == "build" && outcome == "ok") phBuilds++;
            RecomputeWorst();
        }

        static void RecomputeWorst()
        {
            float worst = 0f; string w = "";
            foreach (var kv in agg) if (kv.Value.Wasted > worst) { worst = kv.Value.Wasted; w = kv.Key; }
            WorstKind = w;
        }

        static void Write(string line)
        {
            try
            {
                if (log == null)
                {
                    Directory.CreateDirectory(Recorder.AgentDir);
                    var p = Path.Combine(Recorder.AgentDir, "tasks.jsonl");
                    if (File.Exists(p) && new FileInfo(p).Length > 8 * 1024 * 1024) File.Move(p, p + ".old");
                    log = new StreamWriter(p, true, new UTF8Encoding(false)) { AutoFlush = true };
                }
                if (buildStamp == 0) try { buildStamp = new DateTimeOffset(File.GetLastWriteTimeUtc(System.Reflection.Assembly.GetExecutingAssembly().Location)).ToUnixTimeSeconds(); } catch { buildStamp = 1; }
                log.WriteLine("{\"ts\":" + DateTimeOffset.UtcNow.ToUnixTimeSeconds() + ",\"build\":" + buildStamp + "," + line.Substring(1));
            }
            catch { }
        }

        static void WriteBench(float now)
        {
            if (benchWritten > 0f) return;
            benchWritten = now;
            try { File.WriteAllText(Path.Combine(Recorder.AgentDir, "benchmarks.json"), Bench.Json()); } catch { }
        }

        static void ClosePhase(bool wasNight, float now)
        {
            float dur = now - phT0;
            if (dur > 5f)
            {
                float pct = (phUseful + phWasted) > 1f ? 100f * phUseful / (phUseful + phWasted) : -1f;
                var sb = new StringBuilder(200);
                sb.Append("{\"kind\":\"").Append(wasNight ? "night" : "day").Append("\",\"t\":").Append(now.ToString("0.0", CultureInfo.InvariantCulture))
                  .Append(",\"dur\":").Append(dur.ToString("0.0", CultureInfo.InvariantCulture))
                  .Append(",\"active_pct\":").Append((100f * phActive / dur).ToString("0.0", CultureInfo.InvariantCulture))
                  .Append(",\"useful_pct\":").Append(pct.ToString("0.0", CultureInfo.InvariantCulture))
                  .Append(",\"avg_eff\":").Append(phSec > 0 ? Mathf.RoundToInt(phEffSum / phSec) : 0)
                  .Append(",\"gold_spent\":").Append((int)phSpent)
                  .Append(",\"builds\":").Append(phBuilds)
                  .Append(",\"ally_delta\":").Append(phAllyNow - phAlly0)
                  .Append(",\"maxed_delta\":").Append(phMaxedNow - phMaxed0)
                  .Append(",\"waste_s\":").Append(Mathf.RoundToInt(Efficiency.WasteSeconds - phWaste0)).Append('}');
                string l = sb.ToString();
                reports.Add(l); if (reports.Count > 6) reports.RemoveAt(0);
                Write(l);
            }
        }
        static int phAllyNow, phMaxedNow;

        static void StartPhase(bool night, float now, in BotPerception.Snapshot s)
        {
            phActive = 0; phT0 = now; phWaste0 = Efficiency.WasteSeconds; phSpent = 0; phEffSum = 0; phSec = 0; phUseful = 0; phWasted = 0; phBuilds = 0;
            phAlly0 = s.AllyCount; phMaxed0 = BotPerception.MaxLevelSum; prevNight = night; havePhase = true;
        }

        /// <summary>Call once per brain tick after Efficiency.Update.</summary>
        public static void Update(in BotPerception.Snapshot s, string mode, IList<string> notes)
        {
            float now = Time.unscaledTime;
            if (s.GameState != "InMatch") { if (cur != null) Close("", s, now); lastT = -1f; return; }
            WriteBench(now);
            var pos = new Vector2(s.HeroPos.x, s.HeroPos.z);
            if (lastT < 0f) { lastT = now; lastPos = pos; havePos = true; lastBal = s.Balance; if (!havePhase) StartPhase(s.IsNight, now, s); return; }
            float dt = Mathf.Min(now - lastT, 1f); lastT = now;
            if (dt <= 0f) return;
            float moved = Vector2.Distance(pos, lastPos); lastPos = pos;
            float speed = moved / dt;
            if (lastBal >= 0 && s.Balance < lastBal) phSpent += lastBal - s.Balance;
            lastBal = s.Balance;
            phAllyNow = s.AllyCount; phMaxedNow = BotPerception.MaxLevelSum;

            if (s.IsNight != prevNight) { ClosePhase(prevNight, now); StartPhase(s.IsNight, now, s); }

            bool done = false, fail = false;
            if (notes != null) for (int i = 0; i < notes.Count; i++)
            {
                string n = notes[i];
                if (n == "build-done") done = true;
                else if (n == "build-stall" || n == "slot-abandon") fail = true;
                if (n == "pay" || n == "build-done") lastActAt = now;
            }

            TotalS += dt; phActive += 0f;
            if (now - lastActAt < 2f) { ActiveS += dt; phActive += dt; }
            bool isBuild = mode == "SpendGold" && (s.NearestBuild != null);
            string kind = isBuild ? "build" : mode;
            string label = isBuild ? (s.NearestBuildName ?? "?") : "";
            if (cur != null && (cur.Kind != kind || (isBuild && cur.Key != s.NearestBuildKey)))
            {
                string o = cur.Kind == "build" ? (cur.Progress ? "partial" : "abandoned") : "";
                Close(o, s, now);
            }
            if (cur == null) Open(kind, label, in s, now);

            // classify this slice of time
            bool recentProg = Efficiency.SecondsSinceProgress < 3f;
            bool nightIdleOk = s.IsNight;
            int cls; // 1 useful, -1 wasted, 0 neutral
            if (mode == "HeroDead" || mode == "ResolveUI" || mode == "EnterLevel" || mode == "StartNight") cls = 0;
            else if (s.IsNight) cls = s.EnemyCount > 0 ? 1 : 0;
            else if (recentProg) cls = 1;
            else if (mode == "Idle") cls = -1;
            else if (speed > 1f && (mode == "SpendGold" || mode == "CollectCoin" || mode == "PositionArmy" || mode == "ReturnHome" || mode == "Engage")) cls = 1;
            else if (s.Balance >= 15 && s.BuildCount > 0) cls = -1;
            else cls = speed > 0.3f ? 1 : 0;
            if (cls > 0) { cur.Useful += dt; Useful += dt; phUseful += dt; }
            else if (cls < 0) { cur.Wasted += dt; Wasted += dt; phWasted += dt; }
            cur.Walk += moved;
            if (recentProg) cur.Progress = true;
            phEffSum += Efficiency.Score * dt; phSec += dt;

            if (!s.IsNight && s.Balance >= 50 && s.BuildCount > 0 && mode != "SpendGold") { if (goldIdleSince < 0f) goldIdleSince = now; }
            else goldIdleSince = -1f;

            for (int pi = pending.Count - 1; pi >= 0; pi--)
            { var p = pending[pi]; bool rose = BotPerception.MaxLevelSum > p.C.Maxed0; if (rose || now >= p.Due) { pending.RemoveAt(pi); Finalize(p.C, p.Outcome, p.Now, p.Dur, p.Spent, p.Prog); } }
            maxHist.Enqueue(new Vector2(now, BotPerception.MaxLevelSum));
            while (maxHist.Count > 1 && now - maxHist.Peek().x > 8f) maxHist.Dequeue();
            if (done) { verifyAt = now + 2.5f; verifyMaxed = (int)maxHist.Peek().y; verifyName = cur != null ? cur.Label : ""; }
            else if (fail) Close("fail", s, now);

            // verification: a finished build must raise the level sum
            if (verifyAt > 0f && now >= verifyAt)
            {
                verifyAt = 0f;
                if (BotPerception.MaxLevelSum > verifyMaxed) Verified++;
                else
                {
                    Misses++;
                    Write("{\"kind\":\"task-miss\",\"t\":" + now.ToString("0.0", CultureInfo.InvariantCulture) + ",\"what\":" + BotPerception.JsonStr(verifyName) + "}");
                    Recorder.Event("task-miss", "\"what\":" + BotPerception.JsonStr(verifyName));
                    if (now >= nextForgive) { nextForgive = now + 60f; try { Memory.ForgiveParks(s.SceneName); } catch { } }
                }
            }
            while (failTimes.Count > 0 && now - failTimes.Peek() > 90f) failTimes.Dequeue();

            // score MiniMax advice by what happened afterwards
            if (Coach.LastAdviceAt != seenAdviceAt)
            {
                seenAdviceAt = Coach.LastAdviceAt; fxAt = now + 60f; fxBase = Efficiency.Score; fxTrig = Coach.LastTrigger;
            }
            if (fxAt > 0f && now >= fxAt)
            {
                fxAt = 0f;
                string l = "{\"kind\":\"coach-fx\",\"t\":" + now.ToString("0.0", CultureInfo.InvariantCulture) + ",\"trigger\":" + BotPerception.JsonStr(fxTrig) +
                    ",\"eff_before\":" + Mathf.RoundToInt(fxBase) + ",\"eff_after\":" + Mathf.RoundToInt(Efficiency.Score) + ",\"latency_ms\":" + Coach.LastLatencyMs + "}";
                fx.Add(l); if (fx.Count > 6) fx.RemoveAt(0);
                Write(l);
            }
        }

        /// <summary>Code-only supervisor filter (no LLM): returns a trigger
        /// name when the bot is drifting, null otherwise.</summary>
        public static string Watch()
        {
            float now = Time.unscaledTime;
            if (failTimes.Count >= 3) { failTimes.Clear(); return "task-fail-streak"; }
            if (goldIdleSince >= 0f && now - goldIdleSince > 25f) { goldIdleSince = now; return "gold-unspent-25s"; }
            if (Misses >= 3 && Misses % 3 == 0 && nextMissWake != Misses) { nextMissWake = Misses; return "task-miss-x" + Misses; }
            return null;
        }
        static int nextMissWake;

        public static string DigestJson()
        {
            var sb = new StringBuilder(300);
            sb.Append("\"useful_pct\":").Append(UsefulPct.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"target_useful_pct\":").Append(Bench.TargetUsefulPct.ToString("0", CultureInfo.InvariantCulture))
              .Append(",\"task_misses\":").Append(Misses).Append(",\"worst_kind\":").Append(BotPerception.JsonStr(WorstKind))
              .Append(",\"weak_tasks\":[");
            var weak = new List<KeyValuePair<string, Agg>>();
            foreach (var kv in agg) if (kv.Value.NEff >= 2 && kv.Value.EffSum / kv.Value.NEff < 50f) weak.Add(kv);
            weak.Sort((x, y) => y.Value.Wasted.CompareTo(x.Value.Wasted));
            for (int i = 0; i < weak.Count && i < 3; i++)
            {
                if (i > 0) sb.Append(',');
                var a = weak[i].Value;
                sb.Append("{\"k\":").Append(BotPerception.JsonStr(weak[i].Key)).Append(",\"eff\":").Append(Mathf.RoundToInt(a.EffSum / a.NEff))
                  .Append(",\"n\":").Append(a.N).Append(",\"fail\":").Append(a.Fail).Append('}');
            }
            sb.Append(']');
            return sb.ToString();
        }

        public static string Json()
        {
            var sb = new StringBuilder(1500);
            sb.Append("\"active_pct\":").Append(ActivePct.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"useful_pct\":").Append(UsefulPct.ToString("0.0", CultureInfo.InvariantCulture))
              .Append(",\"task_total\":").Append(TotalTasks).Append(",\"task_micro\":").Append(Micro)
              .Append(",\"task_verified\":").Append(Verified).Append(",\"task_misses\":").Append(Misses)
              .Append(",\"worst_kind\":").Append(BotPerception.JsonStr(WorstKind))
              .Append(",\"coach\":{\"calls\":").Append(Coach.CallsMade).Append(",\"fail\":").Append(Coach.Failures)
              .Append(",\"tokens\":").Append(Coach.TokensUsed).Append(",\"latency_ms\":").Append(Coach.LastLatencyMs)
              .Append(",\"last_trigger\":").Append(BotPerception.JsonStr(Coach.LastTrigger))
              .Append(",\"age_s\":").Append(Coach.LastAdviceAt > 0f ? Mathf.RoundToInt(Time.unscaledTime - Coach.LastAdviceAt) : -1).Append('}')
              .Append(",\"task_agg\":{");
            bool first = true;
            foreach (var kv in agg)
            {
                if (!first) sb.Append(','); first = false;
                var a = kv.Value;
                sb.Append(BotPerception.JsonStr(kv.Key)).Append(":{\"n\":").Append(a.N).Append(",\"ok\":").Append(a.Ok).Append(",\"fail\":").Append(a.Fail)
                  .Append(",\"avg_s\":").Append((a.Dur / Mathf.Max(1, a.N)).ToString("0.0", CultureInfo.InvariantCulture))
                  .Append(",\"eff\":").Append(a.NEff > 0 ? Mathf.RoundToInt(a.EffSum / a.NEff) : -1)
                  .Append(",\"gold\":").Append((int)a.Gold).Append(",\"walk\":").Append(Mathf.RoundToInt(a.Walk))
                  .Append(",\"use_s\":").Append(Mathf.RoundToInt(a.Useful)).Append(",\"waste_s\":").Append(Mathf.RoundToInt(a.Wasted)).Append('}');
            }
            sb.Append("},\"task_recent\":[").Append(string.Join(",", recent.ToArray()))
              .Append("],\"reports\":[").Append(string.Join(",", reports.ToArray()))
              .Append("],\"coach_fx\":[").Append(string.Join(",", fx.ToArray())).Append(']');
            return sb.ToString();
        }
    }
}




