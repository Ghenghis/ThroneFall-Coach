using System;
using System.Collections.Generic;
using UnityEngine;

namespace ThronefallTrainer
{
    // Pure gate planning (no pathfinder, no game objects): used by Gates.cs and unit-tested in tests/GatePlanner.Tests.
    internal struct GateSample
    {
        public uint Area;
        public Vector3 Pos;
        public GateSample(uint area, Vector3 pos) { Area = area; Pos = pos; }
    }

    internal sealed class GateInfo
    {
        public int Id;
        public Vector3 Center;
        public float OpenDist = 5f;
        public readonly List<GateSample> Samples = new List<GateSample>();
    }

    internal struct GatePlan
    {
        public GateInfo Gate;
        public Vector3 In;        // near side (hero's side), the hero walks here first
        public Vector3 Out;       // far side, the hero pushes straight through to here
        public uint FromArea, ToArea, GoalArea;
        public int Hops;          // gates on the chain from the hero's area to the goal's area (>= 1)
    }

    /// <summary>Pure planning: which gate leads out of the hero's connected area towards the goal's area.</summary>
    internal static class GatePlanner
    {
        static float Flat(Vector3 a, Vector3 b) { float dx = a.x - b.x, dz = a.z - b.z; return (float)Math.Sqrt(dx * dx + dz * dz); }

        static List<uint> AreasOf(GateInfo g)
        {
            var l = new List<uint>();
            for (int i = 0; i < g.Samples.Count; i++) if (!l.Contains(g.Samples[i].Area)) l.Add(g.Samples[i].Area);
            return l;
        }

        /// <summary>Gates on the shortest chain from <paramref name="from"/> to <paramref name="goalArea"/> (excluded gate ignored); -1 if none.</summary>
        static int Hops(IList<GateInfo> gates, uint from, uint goalArea, GateInfo excluded, Func<int, bool> isFailed)
        {
            if (from == goalArea) return 0;
            var dist = new Dictionary<uint, int> { { from, 0 } };
            var q = new Queue<uint>(); q.Enqueue(from);
            while (q.Count > 0)
            {
                uint a = q.Dequeue();
                for (int i = 0; i < gates.Count; i++)
                {
                    var g = gates[i];
                    if (g == excluded || (isFailed != null && isFailed(g.Id))) continue;
                    var areas = AreasOf(g);
                    if (!areas.Contains(a)) continue;
                    for (int k = 0; k < areas.Count; k++)
                    {
                        uint b = areas[k];
                        if (b == a || dist.ContainsKey(b)) continue;
                        dist[b] = dist[a] + 1;
                        if (b == goalArea) return dist[b];
                        q.Enqueue(b);
                    }
                }
            }
            return -1;
        }

        /// <summary>
        /// Label-free fallback (area labels can be renumbered by the pathfinder between frames): the gate that is cheapest on the way from the
        /// hero to the goal. Near side = sample nearest to the hero, far side = the sample most opposite to it as seen from the gate centre.
        /// Only gates that have standing room on two opposite sides qualify. Cost = hero->near + near->centre + far->goal.
        /// </summary>
        public static bool PlanHeuristic(IList<GateInfo> gates, Vector3 hero, Vector3 goal, Func<int, bool> isFailed, float maxHeroToGate, out GatePlan plan)
        {
            plan = default(GatePlan);
            if (gates == null) return false;
            float best = float.MaxValue; bool found = false;
            for (int i = 0; i < gates.Count; i++)
            {
                var g = gates[i];
                if (isFailed != null && isFailed(g.Id)) continue;
                if (Flat(hero, g.Center) > maxHeroToGate) continue;
                int inIdx = -1; float inD = float.MaxValue;
                for (int s = 0; s < g.Samples.Count; s++)
                {
                    float d = Flat(g.Samples[s].Pos, hero);
                    if (d < inD) { inD = d; inIdx = s; }
                }
                if (inIdx < 0) continue;
                Vector3 inPos = g.Samples[inIdx].Pos;
                Vector3 axis = g.Center - inPos; axis.y = 0f;
                if (axis.sqrMagnitude < 0.01f) continue;
                axis.Normalize();
                int outIdx = -1; float outScore = float.MinValue;
                for (int s = 0; s < g.Samples.Count; s++)
                {
                    Vector3 v = g.Samples[s].Pos - g.Center; v.y = 0f;
                    if (v.sqrMagnitude < 0.01f) continue;
                    float dot = Vector3.Dot(v.normalized, axis);
                    if (dot < 0.5f) continue;                       // must be on the far side
                    float score = dot * 10f + v.magnitude * 0.1f;
                    if (score > outScore) { outScore = score; outIdx = s; }
                }
                if (outIdx < 0) continue;
                Vector3 outPos = g.Samples[outIdx].Pos;
                float cost = inD + Flat(inPos, g.Center) + Flat(outPos, goal);
                if (cost < best)
                {
                    best = cost; found = true;
                    plan = new GatePlan { Gate = g, In = inPos, Out = outPos, FromArea = g.Samples[inIdx].Area, ToArea = g.Samples[outIdx].Area, GoalArea = 0, Hops = 1 };
                }
            }
            return found;
        }

        public static bool Plan(IList<GateInfo> gates, uint heroArea, uint goalArea, Vector3 hero, Vector3 goal, Func<int, bool> isFailed, out GatePlan plan)
        {
            plan = default(GatePlan);
            if (gates == null || heroArea == goalArea) return false;
            float best = float.MaxValue; bool found = false;
            for (int i = 0; i < gates.Count; i++)
            {
                var g = gates[i];
                if (isFailed != null && isFailed(g.Id)) continue;
                var areas = AreasOf(g);
                if (!areas.Contains(heroArea)) continue;
                // the near-side sample: in the hero's area, closest to the hero
                int inIdx = -1; float inD = float.MaxValue;
                for (int s = 0; s < g.Samples.Count; s++)
                {
                    if (g.Samples[s].Area != heroArea) continue;
                    float d = Flat(g.Samples[s].Pos, hero);
                    if (d < inD) { inD = d; inIdx = s; }
                }
                if (inIdx < 0) continue;
                Vector3 inPos = g.Samples[inIdx].Pos;
                for (int k = 0; k < areas.Count; k++)
                {
                    uint b = areas[k];
                    if (b == heroArea) continue;
                    int rest = Hops(gates, b, goalArea, g, isFailed);       // gates still needed after crossing this one
                    if (rest < 0) continue;
                    // the far-side sample: in area b, most opposite to the near side (as seen from the gate centre)
                    Vector3 axis = g.Center - inPos; axis.y = 0f;
                    if (axis.sqrMagnitude < 0.01f) axis = Vector3.forward;
                    axis.Normalize();
                    int outIdx = -1; float outScore = float.MinValue;
                    for (int s = 0; s < g.Samples.Count; s++)
                    {
                        if (g.Samples[s].Area != b) continue;
                        Vector3 v = g.Samples[s].Pos - g.Center; v.y = 0f;
                        float score = v.sqrMagnitude < 0.01f ? 0f : Vector3.Dot(v.normalized, axis) * 10f + v.magnitude * 0.1f;
                        if (score > outScore) { outScore = score; outIdx = s; }
                    }
                    if (outIdx < 0) continue;
                    Vector3 outPos = g.Samples[outIdx].Pos;
                    float cost = (1 + rest) * 1000f + inD + Flat(inPos, g.Center) + Flat(outPos, goal) * (rest == 0 ? 1f : 0.2f);
                    if (cost < best)
                    {
                        best = cost; found = true;
                        plan = new GatePlan { Gate = g, In = inPos, Out = outPos, FromArea = heroArea, ToArea = b, GoalArea = goalArea, Hops = 1 + rest };
                    }
                }
            }
            return found;
        }
    }
}
