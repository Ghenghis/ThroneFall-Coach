using System;
using UnityEngine;
using ThronefallRefPack;
static class T {
  static int fails = 0;
  static void Check(string name, float got, float want, float tol=0.02f) { bool ok = Math.Abs(got-want) <= tol; if(!ok) fails++; Console.WriteLine((ok?"PASS ":"FAIL ")+name+": got "+got.ToString("F3")+" want "+want.ToString("F3")); }
  static int Main() {
    var p = new BotPack { hero = new BpHero { interactionRadius = 3.0f } };
    var s = new BpSlot { id = 55238, building = "Castle Center" };
    // Nordfels Castle Center interactor footprint (reference/data/terrain/05_Nordfels.json -> slots[].interactorPolygons)
    p.interactorPoints = new[] {
      new BpPolyPoint{slotId=55238,poly=0,k=0,x=-8.93f,z=-3.36f}, new BpPolyPoint{slotId=55238,poly=0,k=1,x=-0.15f,z=-3.36f},
      new BpPolyPoint{slotId=55238,poly=0,k=2,x=-0.15f,z=5.54f},  new BpPolyPoint{slotId=55238,poly=0,k=3,x=-8.93f,z=5.54f} };
    Check("wedge point (0.6, 2.7)  dist to castle collider", BotPackLoader.DistanceToInteractor(p, s, new Vector2(0.6f, 2.7f)), 0.75f);
    Check("wedge point (2.4, 1.8)  dist to castle collider", BotPackLoader.DistanceToInteractor(p, s, new Vector2(2.4f, 1.8f)), 2.55f);
    Check("inside the footprint    dist", BotPackLoader.DistanceToInteractor(p, s, new Vector2(-4f, 1f)), 0f);
    Check("corner (1.0, 6.0)       dist", BotPackLoader.DistanceToInteractor(p, s, new Vector2(1.0f, 6.0f)), (float)Math.Sqrt(1.15*1.15+0.46*0.46));
    Console.WriteLine("InInteractionRange at (0.6,2.7): " + BotPackLoader.InInteractionRange(p, s, new Vector3(0.6f, 0, 2.7f)) + "  (expected True)");
    Console.WriteLine("InInteractionRange at (2.4,1.8): " + BotPackLoader.InInteractionRange(p, s, new Vector3(2.4f, 0, 1.8f)) + "  (expected True, 2.55 <= 2.6)");
    Console.WriteLine("InInteractionRange at (5.0,1.8): " + BotPackLoader.InInteractionRange(p, s, new Vector3(5.0f, 0, 1.8f)) + "  (expected False)");
    // RunGrid: 3 runs
    var g = new BpGrid { resolution = 0.5f, originX = 10f, originZ = 20f, width = 10, height = 4, walkableUnbuiltRuns = new[]{0,2,3, 1,0,10, 3,9,1} };
    var rg = new RunGrid(g, g.walkableUnbuiltRuns);
    Console.WriteLine("RunGrid(10.75,20.25)=" + rg.Contains(10.75f,20.25f) + " (row0,col1 -> false)  (11.25,20.25)=" + rg.Contains(11.25f,20.25f) + " (col2 -> true)  (14.9,21.7)=" + rg.Contains(14.9f,21.7f) + " (row3,col9 -> true)");
    float nx, nz; bool f = rg.Nearest(10.25f, 20.25f, 2f, out nx, out nz);
    Console.WriteLine("Nearest to (10.25,20.25): " + f + " -> (" + nx + "," + nz + ")");
    return fails;
  }
}
