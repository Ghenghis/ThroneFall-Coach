using System;
using System.Collections.Generic;
using ThronefallTrainer;
using UnityEngine;

// Unit tests for src/ActLogic.cs (act.v1 parsing + retreat choice + zone math). Run: dotnet run --project tests/ActLogic.Tests
internal static class Program
{
    static int pass, fail;
    static void Check(string name, bool ok, string detail = "")
    {
        if (ok) { pass++; Console.WriteLine("[PASS] " + name); }
        else { fail++; Console.WriteLine("[FAIL] " + name + "  " + detail); }
    }
    static bool Near(float a, float b, float eps = 0.01f) { return Math.Abs(a - b) <= eps; }

    static int Main()
    {
        // ---------------------------------------------------------------- parsing
        ActCmd c;
        Check("avoid with all fields", ActLogic.TryParse("{\"act\":\"avoid\",\"x\":-83.7,\"z\":13.5,\"r\":18.0,\"ttl_s\":600.0,\"note\":\"incident-H0007#1790\"}", out c)
              && c.How == "avoid" && Near(c.X, -83.7f) && Near(c.Z, 13.5f) && Near(c.R, 18f) && Near(c.TtlS, 600f) && c.Note == "incident-H0007#1790" && c.HasXZ);
        Check("avoid defaults to r=12 ttl=600", ActLogic.TryParse("{\"act\": \"avoid\", \"x\": 4, \"z\": 12}", out c) && Near(c.R, 12f) && Near(c.TtlS, 600f));
        Check("avoid clamps radius and ttl", ActLogic.TryParse("{\"act\":\"avoid\",\"x\":4,\"z\":12,\"r\":500,\"ttl_s\":99999}", out c) && Near(c.R, 40f) && Near(c.TtlS, 1800f));
        Check("avoid clamps tiny values up", ActLogic.TryParse("{\"act\":\"avoid\",\"x\":4,\"z\":12,\"r\":0.1,\"ttl_s\":1}", out c) && Near(c.R, 2f) && Near(c.TtlS, 10f));
        Check("coordinates are clamped to +-2000", ActLogic.TryParse("{\"act\":\"goto\",\"x\":99999,\"z\":-99999}", out c) && Near(c.X, 2000f) && Near(c.Z, -2000f));
        Check("goto ttl default 20, clamp 3..30", ActLogic.TryParse("{\"act\":\"goto\",\"x\":1,\"z\":2}", out c) && Near(c.TtlS, 20f)
              && ActLogic.TryParse("{\"act\":\"goto\",\"x\":1,\"z\":2,\"ttl_s\":600}", out c) && Near(c.TtlS, 30f));
        Check("avoid without x,z is rejected", !ActLogic.TryParse("{\"act\":\"avoid\",\"r\":10}", out c));
        Check("goto without x,z is rejected", !ActLogic.TryParse("{\"act\":\"goto\"}", out c));
        Check("only x without z is not a position", !ActLogic.TryParse("{\"act\":\"avoid\",\"x\":5}", out c));
        Check("retreat needs no coordinates", ActLogic.TryParse("{\"act\":\"retreat\"}", out c) && c.How == "retreat" && !c.HasXZ);
        Check("retreat accepts an optional hint", ActLogic.TryParse("{\"act\":\"retreat\",\"x\":3.1,\"z\":19.0,\"r\":2,\"ttl_s\":10}", out c) && c.HasXZ && Near(c.X, 3.1f));
        Check("clear_ignores / forgive parse", ActLogic.TryParse("{\"act\":\"clear_ignores\"}", out c) && c.How == "clear_ignores" && ActLogic.TryParse("{\"act\":\"forgive\"}", out c));
        Check("unknown act is rejected", !ActLogic.TryParse("{\"act\":\"teleport\",\"x\":1,\"z\":2}", out c));
        Check("no act key = a plain knob command, not ours", !ActLogic.TryParse("{\"army_target\":60,\"build_focus\":\"military\",\"note\":\"x\"}", out c));
        Check("empty / null body", !ActLogic.TryParse("", out c) && !ActLogic.TryParse(null, out c));
        Check("whitespace and newlines tolerated", ActLogic.TryParse("{\n  \"act\" : \"avoid\" ,\n  \"x\" : 1.5 ,\n  \"z\" : -2.5\n}", out c) && Near(c.X, 1.5f) && Near(c.Z, -2.5f));
        Check("scientific notation tolerated", ActLogic.TryParse("{\"act\":\"goto\",\"x\":1e1,\"z\":2.5E1}", out c) && Near(c.X, 10f) && Near(c.Z, 25f));
        Check("probe by screen point", ActLogic.TryParse("{\"act\":\"probe\",\"sx\":412,\"sy\":300,\"id\":\"p17\"}", out c) && c.HasScreen && Near(c.Sx, 412f) && c.Id == "p17");
        Check("probe by world point defaults r=3, clamps r", ActLogic.TryParse("{\"act\":\"probe\",\"wx\":-21.5,\"wz\":19}", out c) && c.HasWorld && Near(c.Wr, 3f)
              && ActLogic.TryParse("{\"act\":\"probe\",\"wx\":1,\"wz\":2,\"wr\":99}", out c) && Near(c.Wr, 12f));
        Check("probe without any point is rejected", !ActLogic.TryParse("{\"act\":\"probe\",\"id\":\"p1\"}", out c));
        Check("a malicious string value cannot smuggle a second act", ActLogic.TryParse("{\"act\":\"retreat\",\"note\":\"x\\\"act\\\":\\\"avoid\"}", out c) && c.How == "retreat");

        // ---------------------------------------------------------------- retreat choice
        var hero = new Vector3(0, 0, 0);
        var trail = new List<Vector3> { new Vector3(-30, 0, 0), new Vector3(-20, 0, 0), new Vector3(-12, 0, 0), new Vector3(-9, 0, 0), new Vector3(-4, 0, 0), new Vector3(-1, 0, 0) };
        var ages = new List<float> { 38f, 30f, 22f, 15f, 6f, 1f };
        var r = ActLogic.ChooseRetreat(trail, ages, hero, null, null);
        Check("retreat: the most recent trail point that is >= 8 m away and >= 3 s old", r.HasValue && Near(r.Value.x, -9f), r.HasValue ? r.Value.ToString() : "null");
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, minAway: 15f);
        Check("retreat: honours a larger minimum distance", r.HasValue && Near(r.Value.x, -20f), r.HasValue ? r.Value.ToString() : "null");
        var ageNew = new List<float> { 38f, 30f, 22f, 15f, 6f, 1f };
        r = ActLogic.ChooseRetreat(new List<Vector3> { new Vector3(-9, 0, 0) }, new List<float> { 1f }, hero, null, null);
        Check("retreat: a point only 1 s old is not 'back along the trail'", !r.HasValue);
        r = ActLogic.ChooseRetreat(new List<Vector3> { new Vector3(-5, 0, 0) }, new List<float> { 10f }, hero, null, null);
        Check("retreat: falls back to the farthest point if none reaches minAway (>= 3 m)", r.HasValue && Near(r.Value.x, -5f));
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, new Vector3(10, 0, 10), null);
        Check("retreat: uses the server's hint when the trail is empty", r.HasValue && Near(r.Value.x, 10f));
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, new Vector3(1, 0, 1), null);
        Check("retreat: ignores a hint that is too close", !r.HasValue);
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, null, new Vector3(100, 0, 0));
        Check("retreat: walks 12 m towards the castle as a last resort", r.HasValue && Near(r.Value.x, 12f) && Near(r.Value.z, 0f));
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, null, new Vector3(5, 0, 0));
        Check("retreat: never overshoots the castle", r.HasValue && Near(r.Value.x, 5f));
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, null, new Vector3(1, 0, 0));
        Check("retreat: already at the castle -> nothing", !r.HasValue);
        r = ActLogic.ChooseRetreat(new List<Vector3> { new Vector3(-60, 0, 0) }, new List<float> { 10f }, hero, null, null);
        Check("retreat: a trail point farther than maxAway is not a retreat", !r.HasValue);
        r = ActLogic.ChooseRetreat(new List<Vector3> { new Vector3(-12, 0, 0) }, new List<float> { 90f }, hero, null, null);
        Check("retreat: a trail point older than maxAge is stale", !r.HasValue);

        // ---------------------------------------------------------------- zones
        Check("InZone ignores height", ActLogic.InZone(new Vector3(3, 50, 4), new Vector3(0, 0, 0), 5.01f) && !ActLogic.InZone(new Vector3(3, 0, 4), new Vector3(0, 0, 0), 4.9f));
        var zc = new List<Vector3> { new Vector3(0, 0, 0), new Vector3(50, 0, 50) };
        var zr = new List<float> { 10f, 5f };
        Check("FreeOfZones: outside both", ActLogic.FreeOfZones(new Vector3(20, 0, 20), zc, zr));
        Check("FreeOfZones: inside the second", !ActLogic.FreeOfZones(new Vector3(52, 0, 51), zc, zr));
        // helpers
        Check("F() is culture-invariant, 2 decimals", ActLogic.F(1.5f) == "1.5" && ActLogic.F(-0.456f) == "-0.46" && ActLogic.F(12f) == "12");
        Check("Js() escapes quotes, backslashes and control chars", ActLogic.Js("a\"b\\c\nd") == "\"a\\\"b\\\\c d\"");

        Console.WriteLine();
        Console.WriteLine(fail == 0 ? "ALL PASSED - " + pass + " checks" : "FAILED - " + fail + " of " + (pass + fail));
        return fail == 0 ? 0 : 1;
    }
}
