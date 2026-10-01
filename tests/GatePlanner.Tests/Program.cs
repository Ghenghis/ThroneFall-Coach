using System;
using System.Collections.Generic;
using ThronefallTrainer;
using UnityEngine;

// Unit tests for the pure gate planner (src/GatePlanner.cs). Run: dotnet run --project tests/GatePlanner.Tests
// The planner decides, from labelled ground samples around each gate, which gate leads out of the hero's pathfinder area
// towards the goal's area. No game, no pathfinder, no Unity runtime is needed.
internal static class Program
{
    static int pass, fail;
    static void Check(string name, bool ok, string detail = "")
    {
        if (ok) { pass++; Console.WriteLine("[PASS] " + name); }
        else { fail++; Console.WriteLine("[FAIL] " + name + "  " + detail); }
    }

    // a gate at (cx, cz) whose axis runs along x: area `west` on the x<cx side, area `east` on the x>cx side, samples on two rings
    static GateInfo Gate(int id, float cx, float cz, uint west, uint east, uint? third = null)
    {
        var g = new GateInfo { Id = id, Center = new Vector3(cx, 0f, cz) };
        foreach (float r in new[] { 2.2f, 3.6f })
            for (int k = 0; k < 16; k++)
            {
                float a = k * (float)(Math.PI * 2.0 / 16.0);
                float dx = (float)Math.Cos(a) * r, dz = (float)Math.Sin(a) * r;
                if (Math.Abs(dx) < 1.0f) continue;                 // the wall itself: no standing room next to the gate axis
                uint area = dx < 0f ? west : east;
                if (third.HasValue && dz > 2f) area = third.Value;  // a third area north of the gate (junction)
                g.Samples.Add(new GateSample(area, new Vector3(cx + dx, 0f, cz + dz)));
            }
        return g;
    }

    static float Flat(Vector3 a, Vector3 b) { float dx = a.x - b.x, dz = a.z - b.z; return (float)Math.Sqrt(dx * dx + dz * dz); }

    private static int Main()
    {
        var hero = new Vector3(-10f, 0f, 0f);
        var goal = new Vector3(30f, 0f, 0f);
        GatePlan p;

        Check("no gates: no plan", !GatePlanner.Plan(new List<GateInfo>(), 1, 2, hero, goal, null, out p));
        Check("same area: no plan", !GatePlanner.Plan(new List<GateInfo> { Gate(1, 0, 0, 1, 2) }, 1, 1, hero, goal, null, out p));

        var g1 = Gate(1, 0f, 0f, 1, 2);
        Check("one gate joining hero area and goal area: plan found", GatePlanner.Plan(new List<GateInfo> { g1 }, 1, 2, hero, goal, null, out p) && p.Gate == g1 && p.Hops == 1 && p.FromArea == 1 && p.ToArea == 2, "");
        Check("near side sample is in the hero's area and west of the gate", p.In.x < 0f, "In=" + p.In);
        Check("far side sample is in the goal's area and east of the gate", p.Out.x > 0f, "Out=" + p.Out);
        Check("the near side sample is the one closest to the hero", Flat(p.In, hero) <= Flat(g1.Samples.Find(s => s.Area == 1).Pos, hero) + 0.01f);

        // two gates between the same areas: the one whose far side is near the goal and that is near the hero wins
        var gNear = Gate(10, 0f, -20f, 1, 2);     // near the hero's x but far south
        var gGoal = Gate(11, 0f, 2f, 1, 2);       // on the line hero -> goal
        Check("two gates: the one on the line hero->goal is preferred", GatePlanner.Plan(new List<GateInfo> { gNear, gGoal }, 1, 2, hero, goal, null, out p) && p.Gate == gGoal, "got " + (p.Gate == null ? "none" : p.Gate.Id.ToString()));

        // chain 1 -ga- 3 -gb- 2
        var ga = Gate(20, 0f, 0f, 1, 3);
        var gb = Gate(21, 20f, 0f, 3, 2);
        Check("two-hop chain: first gate is the one leaving the hero's area, hops = 2", GatePlanner.Plan(new List<GateInfo> { gb, ga }, 1, 2, hero, goal, null, out p) && p.Gate == ga && p.ToArea == 3 && p.Hops == 2, "got gate " + (p.Gate == null ? "none" : p.Gate.Id.ToString()) + " hops " + p.Hops);

        // dead end: hero area 1 only reaches area 3, goal is area 2
        Check("dead end (no chain to the goal's area): no plan", !GatePlanner.Plan(new List<GateInfo> { ga }, 1, 2, hero, goal, null, out p));

        // failed gates are skipped
        var gFail = Gate(30, 0f, 0f, 1, 2); var gOk = Gate(31, 0f, 10f, 1, 2);
        Check("a failed gate is skipped, the other one is used", GatePlanner.Plan(new List<GateInfo> { gFail, gOk }, 1, 2, hero, goal, id => id == 30, out p) && p.Gate == gOk, "got " + (p.Gate == null ? "none" : p.Gate.Id.ToString()));
        Check("all gates failed: no plan", !GatePlanner.Plan(new List<GateInfo> { gFail, gOk }, 1, 2, hero, goal, id => true, out p));

        // a gate that does not touch the hero's area cannot be the first hop
        var gElse = Gate(40, 0f, 0f, 5, 6);
        Check("gate between other areas is ignored", !GatePlanner.Plan(new List<GateInfo> { gElse }, 1, 2, hero, goal, null, out p));

        // junction gate (three areas): going straight to the goal's area is preferred over a detour
        var gJ = Gate(50, 0f, 0f, 1, 2, third: 3);
        Check("junction gate: target area reachable directly", GatePlanner.Plan(new List<GateInfo> { gJ }, 1, 2, hero, goal, null, out p) && p.ToArea == 2 && p.Hops == 1, "ToArea " + p.ToArea + " hops " + p.Hops);

        // robustness: gate with samples only on the hero's side is not a portal
        var gOne = new GateInfo { Id = 60, Center = Vector3.zero };
        gOne.Samples.Add(new GateSample(1, new Vector3(-2, 0, 0))); gOne.Samples.Add(new GateSample(1, new Vector3(-3, 0, 1)));
        Check("gate with samples in one area only is not a portal", !GatePlanner.Plan(new List<GateInfo> { gOne }, 1, 2, hero, goal, null, out p));

        // ---- label-free heuristic planner ----
        var h1 = Gate(70, 0f, 0f, 1, 2);          // on the way
        var h2 = Gate(71, 0f, -30f, 1, 2);        // off the line
        Check("heuristic: picks the gate on the way and sets near/far side", GatePlanner.PlanHeuristic(new List<GateInfo> { h2, h1 }, hero, goal, null, 70f, out p) && p.Gate == h1 && p.In.x < 0f && p.Out.x > 0f, "got " + (p.Gate == null ? "none" : p.Gate.Id.ToString()));
        Check("heuristic: respects the failed-gate filter", GatePlanner.PlanHeuristic(new List<GateInfo> { h2, h1 }, hero, goal, id => id == 70, 70f, out p) && p.Gate == h2);
        Check("heuristic: ignores gates farther than the radius", !GatePlanner.PlanHeuristic(new List<GateInfo> { h1 }, new Vector3(-200f, 0f, 0f), goal, null, 70f, out p));
        var oneSide = new GateInfo { Id = 80, Center = Vector3.zero };
        oneSide.Samples.Add(new GateSample(1, new Vector3(-2, 0, 0))); oneSide.Samples.Add(new GateSample(1, new Vector3(-3, 0, 1)));
        Check("heuristic: a gate with standing room on one side only is not a portal", !GatePlanner.PlanHeuristic(new List<GateInfo> { oneSide }, hero, goal, null, 70f, out p));
        Check("heuristic: no gates, no plan", !GatePlanner.PlanHeuristic(new List<GateInfo>(), hero, goal, null, 70f, out p));

        Console.WriteLine("SUMMARY: {0} passed, {1} FAILED", pass, fail);
        return fail == 0 ? 0 : 1;
    }
}
