using System;
using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

namespace ThronefallTrainer
{
    // ------------------------------------------------------------------------------------------------------------
    // GPS for wall gates.
    //
    // Measured on the live Frostsee run 20261001T101018Z: the hero sat for ~12 minutes (t=207 s .. 980 s) in the walled courtyard in
    // the north-west. Every path request to a target outside logged "Couldn't find a node close to the end point" (the pathfinder's
    // answer when the end point cannot be reached from the start), the steering then fell back to "walk straight at the goal" and
    // pinned against the wall, and pin-park parked one build slot after another. The way out was a wall gate 12.6 m away
    // (Gate Wide Variant (3) at (-64.8,-61.3)); the hero only left when a changed target happened to steer it within 5 m of it.
    // Wall gates (GateOpener: bars/doors that open by themselves when the king comes within openDistance = 5 m) were never approached:
    // the bot had no concept of them (its "gate" code is about pay-to-open path pads and enemy spawn doors).
    //
    // What this module does:
    //   * TRIGGER = a real pathfinder failure for the current goal (Bot reports it via NoteNavFail). The connected-area labels of the
    //     pathfinder (GraphNode.Area) are NOT used as a trigger: they are renumbered whenever the graph is recalculated, so labels read in
    //     different frames cannot be compared (measured: label-based triggering fired ~35 false plans in 3 minutes of a healthy run).
    //   * every active GateOpener is a portal; the walkable ground around it is sampled (16 points on two rings), and the gate chain from
    //     the hero's area to the goal's area is searched with labels read in ONE frame (GatePlanner.Plan); if that finds nothing, the gate
    //     that is cheapest on the way to the goal is tried (GatePlanner.PlanHeuristic, label-free, at most MaxHeuristic times per goal);
    //   * the hero walks to the near side of the gate (normal A*), pushes straight through (the gate opens on its own) and normal pathing
    //     resumes; progress is judged by geometry (distance along the gate axis), never by stored labels;
    //   * a gate that does not work (pinned, timeout) is put on a cool-down and the next one is tried.
    // The pure planning part is in GatePlanner.cs and is unit-tested (tests/GatePlanner.Tests).
    // ------------------------------------------------------------------------------------------------------------
    internal static class Gates
    {
        // ---- tunables (estimates; the numbers that matter are logged by [gps] lines so they can be corrected from evidence) ----
        const float ScanEvery = 2f;           // FindObjectsOfType<GateOpener> throttle
        const float SampleCache = 4f;         // gate samples are reused this long
        const float PlanEvery = 0.5f;         // planning throttle while not on a gate leg
        const float FailWindow = 4f;          // a path failure for this goal is "recent" for this long
        const float FailGoalTol = 3.5f;       // ... if the goal is this close to the failed one
        const float SampleR1 = 2.2f, SampleR2 = 3.6f;
        const int SampleN = 16;
        const float OnMeshTol = 1.0f;         // a sample must be this close (xz) to a walkable node to count as standing room
        const float LayerTol = 3.5f;          // vertical tolerance against the hero's walking layer (wall tops are another layer)
        const float ApproachTimeout = 22f;
        const float PassTimeout = 5f;
        const float FailCooldown = 90f;
        const float OffMeshMax = 3.0f;        // hero further than this from the navmesh: area unknown, do nothing
        const float MaxHeroToGate = 70f;      // heuristic plans only consider gates this close to the hero
        const int MaxHeuristic = 2;           // heuristic (label-free) plans per goal cluster and minute
        const float PinWindow = 8f;           // the heuristic needs a pin this recent
        public const float Arrive = 0.6f;

        public static bool Enabled = true;
        public static bool Active { get; private set; }
        /// <summary>True on the "push through" leg: steer straight at Out, do not ask the pathfinder (it still sees the gate as closed).</summary>
        public static bool Direct { get; private set; }
        public static int Plans, Crossings, Failures, Heuristics;
        /// <summary>Changes whenever the leg changes (new gate, approach -> through, end); 0 when no gate plan is active. The steering drops its stale path when it changes.</summary>
        public static int LegKey => Active && plan.Gate != null ? plan.Gate.Id * 4 + phase : 0;
        public static string Status = "";

        static GateOpener[] openers = new GateOpener[0];
        static GateOpener[] sampledFor;
        static float scanAt, planAt, sampledAt, legStart, phaseAt, disabledUntil, sealedLogAt, failAt = -99f, heurAt = -99f, pinAt = -99f;
        static List<GateInfo> infos = new List<GateInfo>();
        static GatePlan plan;
        static Vector3 planGoal, failGoal, heurGoal;
        static int heurCount;
        static int phase;                      // 1 = walking to the near side, 2 = pushing through
        static int pins;
        static int sceneHandle = int.MinValue;
        static readonly Dictionary<int, float> failedUntil = new Dictionary<int, float>();
        static bool errLogged;

        static float Flat(Vector3 a, Vector3 b) { float dx = a.x - b.x, dz = a.z - b.z; return Mathf.Sqrt(dx * dx + dz * dz); }
        static void Log(string m) { Plugin.Log?.LogInfo("[gps] " + m); }
        /// <summary>Structured evidence in the run's events.jsonl (read by tools/nav-report.py).</summary>
        static void Evt(string note, string extra) { try { Recorder.Event(note, extra); } catch { } }
        static float episodeStart = -1f;     // when the pathfinder first failed in the current enclosure episode (Time.unscaledTime)

        public static void Reset(string why)
        {
            if (Active) Log("reset (" + why + ")");
            Active = false; Direct = false; phase = 0; pins = 0; Status = "";
            infos = new List<GateInfo>(); sampledFor = null; sampledAt = -99f; scanAt = 0f; planAt = 0f; failAt = -99f; heurAt = -99f; heurCount = 0;
            failedUntil.Clear(); openers = new GateOpener[0];
        }

        static bool IsFailed(int id) { return failedUntil.TryGetValue(id, out float t) && Time.unscaledTime < t; }

        static void Fail(string why)
        {
            Failures++;
            Evt("gps-fail", $"\"why\":\"{why}\",\"gate\":{(plan.Gate != null ? plan.Gate.Id : 0)}");
            if (plan.Gate != null) { failedUntil[plan.Gate.Id] = Time.unscaledTime + FailCooldown; Log("gate #" + plan.Gate.Id + " failed (" + why + ") -> cool-down " + (int)FailCooldown + " s"); }
            Active = false; Direct = false; phase = 0; pins = 0; planAt = 0f; Status = "gate-failed:" + why;
        }

        /// <summary>Bot reports a pathfinder failure for this goal ("Couldn't find a node close to the end point"): the only trigger for planning.</summary>
        public static void NoteNavFail(Vector3 goal)
        {
            if (Active) return;                    // failures of the intermediate legs are not interesting
            if (Time.unscaledTime - failAt > 20f) episodeStart = Time.unscaledTime;
            failGoal = goal; failAt = Time.unscaledTime;
        }

        /// <summary>The stuck handler counted a pin (hero not moving while travelling): evidence for the label-free fallback.</summary>
        public static void NotePin() { if (!Active) pinAt = Time.unscaledTime; }

        static bool RecentFail(Vector3 goal) { return Time.unscaledTime - failAt < FailWindow && Flat(goal, failGoal) < FailGoalTol; }

        static uint? AreaAt(Vector3 p, out float flatOff)
        {
            flatOff = 0f;
            var ast = AstarPath.active;
            if (ast == null) return null;
            NNInfo nn = ast.GetNearest(p, NearestNodeConstraint.Walkable);
            if (nn.node == null) return null;
            flatOff = Flat(nn.position, p);
            return nn.node.Area;
        }

        /// <summary>Distinct connected areas of the walkable ground at / around the goal, nearest first (a goal next to a wall may touch two areas). Labels are valid for THIS frame only.</summary>
        static List<uint> GoalAreas(Vector3 goal)
        {
            var res = new List<uint>();
            var ast = AstarPath.active;
            if (ast == null) return res;
            var cand = new List<KeyValuePair<float, uint>>();
            for (int k = -1; k < 8; k++)
            {
                Vector3 p = goal;
                if (k >= 0) { float a = k * (Mathf.PI * 2f / 8f); p += new Vector3(Mathf.Cos(a) * 1.5f, 0f, Mathf.Sin(a) * 1.5f); }
                NNInfo nn = ast.GetNearest(p, NearestNodeConstraint.Walkable);
                if (nn.node == null) continue;
                if (Flat(nn.position, p) > (k < 0 ? 3.0f : 1.2f)) continue;
                if (Mathf.Abs(nn.position.y - goal.y) > 4f) continue;
                cand.Add(new KeyValuePair<float, uint>(Flat(nn.position, goal), nn.node.Area));
            }
            cand.Sort((x, y) => x.Key.CompareTo(y.Key));
            for (int i = 0; i < cand.Count; i++) if (!res.Contains(cand[i].Value)) res.Add(cand[i].Value);
            return res;
        }

        static void ScanGates()
        {
            if (Time.unscaledTime < scanAt) return;
            scanAt = Time.unscaledTime + ScanEvery;
            openers = UnityEngine.Object.FindObjectsOfType<GateOpener>(false);
        }

        static void SampleGates(Vector3 hero)
        {
            if (Time.unscaledTime - sampledAt < SampleCache && ReferenceEquals(sampledFor, openers)) return;
            sampledAt = Time.unscaledTime; sampledFor = openers;
            var ast = AstarPath.active;
            var list = new List<GateInfo>();
            for (int i = 0; i < openers.Length; i++)
            {
                var o = openers[i];
                if (o == null) continue;
                var gi = new GateInfo { Id = o.GetInstanceID(), Center = o.transform.position, OpenDist = o.openDistance > 0.5f ? o.openDistance : 5f };
                for (int ring = 0; ring < 2; ring++)
                {
                    float r = ring == 0 ? SampleR1 : SampleR2;
                    for (int k = 0; k < SampleN; k++)
                    {
                        float a = k * (Mathf.PI * 2f / SampleN);
                        Vector3 p = gi.Center + new Vector3(Mathf.Cos(a) * r, 0f, Mathf.Sin(a) * r);
                        p.y = hero.y;
                        NNInfo nn = ast.GetNearest(p, NearestNodeConstraint.Walkable);
                        if (nn.node == null) continue;
                        if (Flat(nn.position, p) > OnMeshTol) continue;                 // inside the wall / off the mesh: not standing room
                        if (Mathf.Abs(nn.position.y - hero.y) > LayerTol) continue;     // another layer (wall top)
                        gi.Samples.Add(new GateSample(nn.node.Area, nn.position));      // the label is only used within the frame of this sampling
                    }
                }
                if (gi.Samples.Count > 0) list.Add(gi);
            }
            infos = list;
        }

        /// <summary>
        /// Called every frame by the steering (Bot.NavSteerPoint). Returns the point to steer at: the goal itself unless the pathfinder just
        /// failed for this goal and a gate can lead there, in which case the near side / far side of that gate.
        /// </summary>
        public static Vector3 Redirect(Vector3 hero, Vector3 goal)
        {
            if (!Enabled || Time.unscaledTime < disabledUntil) return goal;
            try
            {
                var ast = AstarPath.active;
                if (ast == null) { if (Active) Reset("no pathfinder"); return goal; }
                var sceneNow = UnityEngine.SceneManagement.SceneManager.GetActiveScene();
                if (sceneNow.handle != sceneHandle) { sceneHandle = sceneNow.handle; Reset("scene " + sceneNow.name); }
                if (Active) return Advance(hero, goal);
                if (!RecentFail(goal)) { Status = ""; return goal; }                        // the pathfinder is happy: nothing to do
                if (Time.unscaledTime < planAt) return goal;
                planAt = Time.unscaledTime + PlanEvery;

                uint? aH = AreaAt(hero, out float hOff);
                if (aH == null || hOff > OffMeshMax) return goal;                            // hero off the mesh: area unknown
                ScanGates();
                if (openers.Length == 0) { LogSealed(aH.Value, 0, 0); return goal; }
                SampleGates(hero);

                List<uint> gAreas = GoalAreas(goal);
                GatePlan p = default(GatePlan);
                bool found = false; string how = "areas";
                for (int gi = 0; gi < gAreas.Count && !found; gi++)
                    found = !gAreas.Contains(aH.Value) && GatePlanner.Plan(infos, aH.Value, gAreas[gi], hero, goal, IsFailed, out p);
                if (!found)
                {
                    // label-free fallback, a few tries per goal cluster
                    if (Flat(goal, heurGoal) > FailGoalTol * 2f || Time.unscaledTime - heurAt > 60f) { heurGoal = goal; heurAt = Time.unscaledTime; heurCount = 0; }
                    // only when the hero is really pinned right now: a path failure alone can also mean "target on another island"
                    if (Time.unscaledTime - pinAt < PinWindow && heurCount < MaxHeuristic && GatePlanner.PlanHeuristic(infos, hero, goal, IsFailed, MaxHeroToGate, out p)) { found = true; how = "heuristic"; heurCount++; Heuristics++; }
                }
                if (!found) { LogSealed(aH.Value, gAreas.Count > 0 ? gAreas[0] : 0u, infos.Count); return goal; }

                plan = p; planGoal = goal; Active = true; Direct = false; phase = 1; pins = 0; legStart = Time.unscaledTime; phaseAt = legStart; Plans++;
                Status = "gate:" + p.Gate.Id + ":approach";
                Evt("gps-plan", $"\"how\":\"{how}\",\"gate\":{p.Gate.Id},\"gx\":{p.Gate.Center.x:0.0},\"gz\":{p.Gate.Center.z:0.0},\"hx\":{hero.x:0.0},\"hz\":{hero.z:0.0},\"tx\":{goal.x:0.0},\"tz\":{goal.z:0.0},\"hops\":{p.Hops}");
                Log($"plan #{Plans} ({how}) via gate #{p.Gate.Id} at ({p.Gate.Center.x:0.0},{p.Gate.Center.z:0.0}) hops={p.Hops} in=({p.In.x:0.0},{p.In.z:0.0}) out=({p.Out.x:0.0},{p.Out.z:0.0}) hero=({hero.x:0.0},{hero.z:0.0}) goal=({goal.x:0.0},{goal.z:0.0}) labels hero={aH.Value} goal={(gAreas.Count > 0 ? gAreas[0].ToString() : "-")} gates={infos.Count} (pathfinder failed for this goal)");
                return Advance(hero, goal);
            }
            catch (Exception e)
            {
                if (!errLogged) { errLogged = true; Plugin.Log?.LogWarning("[gps] disabled for 30 s after exception: " + e); }
                disabledUntil = Time.unscaledTime + 30f; Active = false; Direct = false;
                return goal;
            }
        }

        static void LogSealed(uint aH, uint aG, int gates)
        {
            Status = "sealed";
            if (Time.unscaledTime < sealedLogAt) return;
            sealedLogAt = Time.unscaledTime + 20f;
            Evt("gps-sealed", $"\"gates\":{openers.Length},\"usable\":{gates}");
            var sb = new System.Text.StringBuilder();
            for (int i = 0; i < infos.Count && i < 8; i++)
            {
                var g = infos[i]; sb.Append(" #").Append(g.Id).Append("(").Append(g.Center.x.ToString("0")).Append(",").Append(g.Center.z.ToString("0")).Append(")areas=");
                var seen = new List<uint>(); for (int s = 0; s < g.Samples.Count; s++) if (!seen.Contains(g.Samples[s].Area)) seen.Add(g.Samples[s].Area);
                sb.Append(string.Join("/", seen.ConvertAll(x => x.ToString()).ToArray()));
            }
            Log($"pathfinder failed for the goal and no usable gate (hero label {aH}, goal label {aG}, gate objects={openers.Length}, usable={gates}){sb}");
        }

        static Vector3 Advance(Vector3 hero, Vector3 goal)
        {
            float now = Time.unscaledTime;
            // the plan is about getting out of an enclosure, not about one target: it survives a change of target. It is cancelled when the
            // current goal turns out to be reachable (labels read in THIS frame; equality is trustworthy, inequality is not - see header).
            if (now >= planAt)
            {
                planAt = now + 0.5f;
                uint? aNow = AreaAt(hero, out float hOffNow);
                if (aNow != null && hOffNow <= OffMeshMax)
                {
                    List<uint> gNow = GoalAreas(goal);
                    if (gNow.Contains(aNow.Value) && Flat(hero, plan.Gate.Center) > 2f) { Log("goal is reachable from here now -> gate plan dropped"); Evt("gps-drop", "\"why\":\"reachable\""); Active = false; Direct = false; phase = 0; pins = 0; failAt = -99f; Status = "gate-dropped"; return goal; }
                }
            }

            Vector3 axis = plan.Out - plan.In; axis.y = 0f;
            axis = axis.sqrMagnitude < 0.01f ? Vector3.forward : axis.normalized;
            Vector3 rel = hero - plan.Gate.Center; rel.y = 0f;
            float along = Vector3.Dot(rel, axis);                                           // > 0: on the far side of the gate
            float dg = Flat(hero, plan.Gate.Center), dIn = Flat(hero, plan.In);

            if (phase == 1)
            {
                if (along > 1.5f && dg < 7f) { Cross("passed the gate during the approach"); return goal; }
                if (now - legStart > ApproachTimeout) { Fail("approach timeout"); return goal; }
                if (dIn < 1.3f || (dg < Mathf.Max(plan.Gate.OpenDist - 2.0f, 2.5f) && dIn < 3.0f))
                { phase = 2; Direct = true; phaseAt = now; pins = 0; Status = "gate:" + plan.Gate.Id + ":through"; Log("at gate #" + plan.Gate.Id + " (" + dg.ToString("0.0") + " m): pushing through"); return plan.Out; }
                return plan.In;
            }
            if (along > 1.5f && dg < 7f) { Cross("past the gate"); return goal; }
            if (now - phaseAt > PassTimeout) { Fail("did not get through"); return goal; }
            if (Flat(hero, plan.Out) < 1.3f) { Cross("reached the far side"); return goal; }
            return plan.Out;
        }

        static void Cross(string how)
        {
            Crossings++;
            Evt("gps-cross", $"\"how\":\"{how}\",\"gate\":{plan.Gate.Id},\"s\":{(Time.unscaledTime - legStart):0.0}");
            try
            {
                BotPerception.ClearIgnores();                                    // slots ignored while the hero could not leave are valid again
                if (episodeStart >= 0f) Memory.ForgiveParksSince(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name, episodeStart - 1f);
            }
            catch { }
            Log("crossed gate #" + plan.Gate.Id + " (" + how + ") after " + (Time.unscaledTime - legStart).ToString("0.0") + " s");
            Active = false; Direct = false; phase = 0; pins = 0; planAt = Time.unscaledTime + 0.3f; failAt = -99f; Status = "gate-crossed";
        }

        /// <summary>
        /// Called by the stuck handler before it counts a strike. True = the gate leg handles it (the strike is NOT counted and nothing is parked).
        /// A pin while walking to / through the gate counts against the gate: three pins and it is put on cool-down.
        /// </summary>
        public static bool OnPinned(Vector3 hero, bool slideOnly)
        {
            if (!Active) return false;
            if (slideOnly) return true;           // moving, just not getting closer to the final goal: that is expected on a gate leg
            if (++pins >= 3) Fail("pinned x" + pins); else Log("pinned on the gate leg (" + pins + ")");
            return true;
        }
    }
}
