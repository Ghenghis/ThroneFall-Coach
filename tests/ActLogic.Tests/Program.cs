using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;
using System.Threading;
using ThronefallTrainer;
using UnityEngine;

// Unit tests for src/ActLogic.cs (act.v1 parsing + retreat choice + zone math) and src/LiveLinkLogic.cs + src/LiveLinkNet.cs (live.v1: wire framing,
// control lines, capture-size / pacing maths, frame hand-over, orientation probe, and the real sender thread against a loopback server).
// Run: dotnet run --project tests/ActLogic.Tests
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

        RetreatZoneTests();
        LiveFramingTests();
        LiveMathTests();
        LiveExchangeTests();
        LivePixelTests();
        LiveNetTests();
        FramePerfTests();
        AsyncWriterTests();

        Console.WriteLine();
        Console.WriteLine(fail == 0 ? "ALL PASSED - " + pass + " checks" : "FAILED - " + fail + " of " + (pass + fail));
        return fail == 0 ? 0 : 1;
    }

    static bool WaitFor(Func<bool> cond, int ms)
    {
        var sw = System.Diagnostics.Stopwatch.StartNew();
        while (sw.ElapsedMilliseconds < ms) { if (cond()) return true; Thread.Sleep(10); }
        return cond();
    }

    static string F(Vector3? v) { return v.HasValue ? "(" + v.Value.x + "," + v.Value.y + "," + v.Value.z + ")" : "null"; }
    static List<Vector3> L(params Vector3[] v) { return new List<Vector3>(v); }
    static List<float> L(params float[] v) { return new List<float>(v); }

    // ---------------------------------------------------------------- retreat vs avoid zones (the live bug: the zone is made around the pin spot)
    static void RetreatZoneTests()
    {
        var hero = new Vector3(0, 0, 0);
        var trail = new List<Vector3> { new Vector3(-30, 0, 0), new Vector3(-20, 0, 0), new Vector3(-12, 0, 0), new Vector3(-9, 0, 0), new Vector3(-4, 0, 0), new Vector3(-1, 0, 0) };
        var ages = new List<float> { 38f, 30f, 22f, 15f, 6f, 1f };
        Vector3? r;

        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null);
        Check("retreat+zones: the old answer (-9 m) IS inside a 12 m zone around the hero - that was the live bug", r.HasValue && Near(r.Value.x, -9f) && ActLogic.InZone(r.Value, hero, 12f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(hero), zoneR: L(12f));
        Check("retreat+zones: hero inside a 12 m zone -> the most recent trail point OUTSIDE it (-20; -12 sits on the edge = inside)", r.HasValue && Near(r.Value.x, -20f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(hero), zoneR: L(22f));
        Check("retreat+zones: a 22 m zone pushes the choice out to the 30 m point", r.HasValue && Near(r.Value.x, -30f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(hero, new Vector3(-20, 0, 0)), zoneR: L(12f, 5f));
        Check("retreat+zones: two zones - the point must be outside ALL of them", r.HasValue && Near(r.Value.x, -30f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(new Vector3(100, 0, 100)), zoneR: L(5f));
        Check("retreat+zones: a zone somewhere else changes nothing (-9)", r.HasValue && Near(r.Value.x, -9f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: new List<Vector3>(), zoneR: new List<float>());
        Check("retreat+zones: empty zone lists = the old behaviour (-9)", r.HasValue && Near(r.Value.x, -9f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: null, zoneR: null, minAway: 15f);
        Check("retreat+zones: null zone lists + minAway 15 = the old behaviour (-20)", r.HasValue && Near(r.Value.x, -20f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, minAway: 15f, zoneC: L(hero), zoneR: L(12f));
        Check("retreat+zones: minAway still applies to the outside search (-20)", r.HasValue && Near(r.Value.x, -20f), F(r));

        r = ActLogic.ChooseRetreat(L(new Vector3(-40, 0, 0)), L(20f), hero, null, null, zoneC: L(hero), zoneR: L(35f));
        Check("retreat+zones: no point in the 8-30 m window is outside -> the window stretches to 45 m (-40)", r.HasValue && Near(r.Value.x, -40f), F(r));
        r = ActLogic.ChooseRetreat(L(new Vector3(-40, 0, 0)), L(20f), hero, null, null);
        Check("retreat (no zones): the same 40 m point is still NOT a retreat - the stretch only exists to get out of zones", !r.HasValue, F(r));
        r = ActLogic.ChooseRetreat(L(new Vector3(-50, 0, 0)), L(20f), hero, null, null, zoneC: L(hero), zoneR: L(35f));
        Check("retreat+zones: 45 m is the limit (a 50 m point is never chosen)", !r.HasValue, F(r));

        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(hero), zoneR: L(40f));
        Check("retreat+zones: trail entirely inside the zone -> still walks, to the point that leaves it fastest (-30, 10 m deep), never a veto", r.HasValue && Near(r.Value.x, -30f), F(r));
        r = ActLogic.ChooseRetreat(trail, ages, hero, null, null, zoneC: L(new Vector3(-30, 0, 0)), zoneR: L(40f));
        Check("retreat+zones: 'fastest out' is measured from the ZONE centre, not the hero (-4 here)", r.HasValue && Near(r.Value.x, -4f), F(r));
        var tie = L(new Vector3(-20, 0, 0), new Vector3(0, 0, 20));
        r = ActLogic.ChooseRetreat(tie, L(30f, 10f), hero, null, null, zoneC: L(hero), zoneR: L(100f));
        Check("retreat+zones: equal clearance -> the more recent trail point wins", r.HasValue && Near(r.Value.z, 20f) && Near(r.Value.x, 0f), F(r));
        r = ActLogic.ChooseRetreat(L(new Vector3(-25, 0, 0)), L(1f), hero, null, null, zoneC: L(hero), zoneR: L(12f));
        Check("retreat+zones: the age window still applies (a 1 s old point is not 'back along the trail')", !r.HasValue, F(r));
        r = ActLogic.ChooseRetreat(L(new Vector3(-5, 0, 0)), L(10f), hero, null, null, zoneC: L(new Vector3(50, 0, 50)), zoneR: L(5f));
        Check("retreat+zones: nothing reaches minAway and the zone is irrelevant -> the farthest point, like before (-5)", r.HasValue && Near(r.Value.x, -5f), F(r));

        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, new Vector3(10, 0, 10), null, zoneC: L(hero), zoneR: L(20f));
        Check("retreat+zones: the server's hint is still used when the trail is empty - even inside a zone (zones never forbid walking)", r.HasValue && Near(r.Value.x, 10f) && ActLogic.InZone(r.Value, hero, 20f), F(r));
        r = ActLogic.ChooseRetreat(new List<Vector3>(), new List<float>(), hero, null, new Vector3(100, 0, 0), zoneC: L(hero), zoneR: L(20f));
        Check("retreat+zones: the castle fallback is still used (12 m towards it), zone or not", r.HasValue && Near(r.Value.x, 12f), F(r));

        Check("Clearance: worst zone wins", Near(ActLogic.Clearance(new Vector3(30, 0, 0), L(hero, new Vector3(40, 0, 0)), L(12f, 15f)), -5f)
              && Near(ActLogic.Clearance(new Vector3(30, 9, 0), L(hero), L(12f)), 18f));
        Check("Clearance: no zones = +Infinity, null-safe", float.IsPositiveInfinity(ActLogic.Clearance(hero, null, null)) && float.IsPositiveInfinity(ActLogic.Clearance(hero, new List<Vector3>(), new List<float>())));
    }

    // ---------------------------------------------------------------- live.v1 wire framing, hello, control lines, meta
    static void LiveFramingTests()
    {
        var h = new FrameHeader { MetaLen = 123, W = 1280, H = 960, Fmt = 1, TMs = 1759300123456.0, Seq = 4000000000u, PayloadLen = 1280u * 960u * 4u };
        var buf = new byte[5 + LiveLinkLogic.HeaderLen + 3];
        int n = LiveLinkLogic.EncodeHeader(buf, 5, h);
        FrameHeader d; string err;
        bool ok = LiveLinkLogic.TryDecodeHeader(buf, 5, LiveLinkLogic.HeaderLen, out d, out err);
        Check("framing: header is 36 bytes", n == 36 && LiveLinkLogic.HeaderLen == 36);
        Check("framing: encode -> decode round trip keeps every field (u32 above 2^31, f64 epoch ms, non-zero offset)",
              ok && d.MetaLen == 123 && d.W == 1280 && d.H == 960 && d.Fmt == 1 && d.Seq == 4000000000u && d.PayloadLen == 1280u * 960u * 4u && d.TMs == 1759300123456.0, err);
        Check("framing: byte layout = 'TFRM' + u32 meta_len, w, h, fmt + f64 t_ms + u32 seq, payload_len, all little-endian",
              buf[5] == 'T' && buf[6] == 'F' && buf[7] == 'R' && buf[8] == 'M'
              && buf[9] == 123 && buf[10] == 0 && buf[11] == 0 && buf[12] == 0                       // meta_len 123
              && buf[13] == 0x00 && buf[14] == 0x05 && buf[15] == 0 && buf[16] == 0                  // w 1280 = 0x0500
              && buf[17] == 0xC0 && buf[18] == 0x03 && buf[19] == 0 && buf[20] == 0                  // h 960 = 0x03C0
              && buf[21] == 1 && buf[22] == 0 && buf[23] == 0 && buf[24] == 0                        // fmt 1
              && buf[33] == 0x00 && buf[34] == 0x28 && buf[35] == 0x6B && buf[36] == 0xEE            // seq 4000000000 = 0xEE6B2800 (offset 28 -> 5+28 = 33)
              && buf[37] == 0x00 && buf[38] == 0x00 && buf[39] == 0x4B && buf[40] == 0x00            // payload 4915200 = 0x004B0000 (offset 32 -> 37)
              && buf[41] == 0 && buf[42] == 0 && buf[43] == 0,                                       // nothing written past the header
              BitConverter.ToString(buf));
        var one = new byte[LiveLinkLogic.HeaderLen];
        LiveLinkLogic.EncodeHeader(one, 0, new FrameHeader { MetaLen = 0, W = 2, H = 2, Fmt = 3, TMs = 1.0, Seq = 0, PayloadLen = 12 });
        Check("framing: f64 1.0 is 00 00 00 00 00 00 F0 3F at offset 20", one[20] == 0 && one[21] == 0 && one[22] == 0 && one[23] == 0 && one[24] == 0 && one[25] == 0 && one[26] == 0xF0 && one[27] == 0x3F, BitConverter.ToString(one));
        Check("framing: fmt 2 (BGRA) and fmt 3 (RGB24) payload sizes validate", LiveLinkLogic.PayloadLen(2, 10, 10) == 400 && LiveLinkLogic.PayloadLen(3, 10, 10) == 300 && LiveLinkLogic.PayloadLen(1, 10, 10) == 400
              && LiveLinkLogic.PayloadLen(9, 10, 10) == -1 && LiveLinkLogic.PayloadLen(1, 0, 10) == -1);
        Check("framing: a decoded fmt 3 header with the right payload is accepted", LiveLinkLogic.TryDecodeHeader(one, 0, one.Length, out d, out err) && d.Fmt == 3 && d.PayloadLen == 12, err);

        var bad = (byte[])buf.Clone();
        bad[5] = (byte)'X';
        Check("framing: bad magic is rejected", !LiveLinkLogic.TryDecodeHeader(bad, 5, 36, out d, out err) && err == "bad magic", err);
        Check("framing: a short buffer is rejected", !LiveLinkLogic.TryDecodeHeader(buf, 5, 20, out d, out err) && err == "short header" && !LiveLinkLogic.TryDecodeHeader(buf, 20, 36, out d, out err) && !LiveLinkLogic.TryDecodeHeader(null, 0, 36, out d, out err));
        bad = (byte[])buf.Clone(); bad[21] = 9;
        Check("framing: an unknown fmt is rejected", !LiveLinkLogic.TryDecodeHeader(bad, 5, 36, out d, out err), err);
        bad = (byte[])buf.Clone(); bad[37]++;
        Check("framing: payload_len != w*h*bpp is rejected (livecap would drop the connection)", !LiveLinkLogic.TryDecodeHeader(bad, 5, 36, out d, out err), err);
        bad = (byte[])buf.Clone(); bad[9] = 0x01; bad[10] = 0x20;                                    // meta_len 0x2001 = 8193
        Check("framing: meta_len above 8192 is rejected", !LiveLinkLogic.TryDecodeHeader(bad, 5, 36, out d, out err), err);
        bad = (byte[])buf.Clone(); bad[13] = 0; bad[14] = 0;
        Check("framing: a zero width is rejected", !LiveLinkLogic.TryDecodeHeader(bad, 5, 36, out d, out err), err);

        string hello = LiveLinkLogic.HelloLine("live-1", 1234, 1920, 1440, "2022.3.62f1");
        Check("hello: exactly 'TFGAME1 ' + json + LF", hello == "TFGAME1 {\"build\":\"live-1\",\"pid\":1234,\"w\":1920,\"h\":1440,\"unity\":\"2022.3.62f1\"}\n", hello);
        using (var doc = JsonDocument.Parse(hello.Substring(8)))
            Check("hello: the json parses and carries build/pid/w/h/unity", doc.RootElement.GetProperty("pid").GetInt32() == 1234 && doc.RootElement.GetProperty("unity").GetString() == "2022.3.62f1");
        Check("hello: strings are escaped", LiveLinkLogic.HelloLine("a\"b", 1, 2, 3, "c\\d").Contains("\"build\":\"a\\\"b\"") && LiveLinkLogic.HelloLine("a\"b", 1, 2, 3, "c\\d").Contains("\"unity\":\"c\\\\d\""));

        // control lines (livecap -> plugin)
        int fps, w;
        Check("control: {\"cap\":{\"fps\":30,\"w\":1280}}", LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":30,\"w\":1280}}", out fps, out w) && fps == 30 && w == 1280);
        Check("control: python's json.dumps spacing", LiveLinkLogic.TryParseControl("{\"cap\": {\"fps\": 45, \"w\": 960}}", out fps, out w) && fps == 45 && w == 960);
        Check("control: trailing CR / LF tolerated", LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":30}}\r", out fps, out w) && fps == 30 && w == 0);
        Check("control: fps clamps to 5..60", LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":1}}", out fps, out w) && fps == 5 && LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":500}}", out fps, out w) && fps == 60
              && LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":-7}}", out fps, out w) && fps == 5 && LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":1e30}}", out fps, out w) && fps == 60);
        Check("control: w clamps to 320..1920", LiveLinkLogic.TryParseControl("{\"cap\":{\"w\":100}}", out fps, out w) && w == 320 && fps == 0 && LiveLinkLogic.TryParseControl("{\"cap\":{\"w\":5000}}", out fps, out w) && w == 1920);
        Check("control: fractional values round (29.6 -> 30, 29.4 -> 29)", LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":29.6}}", out fps, out w) && fps == 30 && LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":29.4}}", out fps, out w) && fps == 29);
        Check("control: a partial cap keeps the other field at 0 = 'no change'", LiveLinkLogic.TryParseControl("{\"cap\":{\"w\":640}}", out fps, out w) && fps == 0 && w == 640);
        Check("control: unknown keys (also nested ones) are ignored", LiveLinkLogic.TryParseControl("{\"zzz\":[1,2],\"cap\":{\"fps\":45,\"foo\":1,\"bar\":{\"x\":2},\"w\":800},\"q\":0}", out fps, out w) && fps == 45 && w == 800);
        Check("control: a brace inside a string does not end the cap object", LiveLinkLogic.TryParseControl("{\"cap\":{\"note\":\"}{\",\"fps\":20}}", out fps, out w) && fps == 20);
        Check("control: fps outside the cap object is not ours", LiveLinkLogic.TryParseControl("{\"fps\":99,\"cap\":{\"w\":640}}", out fps, out w) && fps == 0 && w == 640);
        Check("control: ping is ignored", !LiveLinkLogic.TryParseControl("{\"ping\":1}", out fps, out w) && fps == 0 && w == 0);
        int pz;
        Check("control: livecap's \"paused\" key (python spacing): true = 1, false = 0, together with fps / w", LiveLinkLogic.TryParseControl("{\"cap\": {\"fps\": 30, \"w\": 1280, \"paused\": true}}", out fps, out w, out pz) && fps == 30 && w == 1280 && pz == 1
              && LiveLinkLogic.TryParseControl("{\"cap\": {\"fps\": 30, \"w\": 1280, \"paused\": false}}", out fps, out w, out pz) && pz == 0);
        Check("control: \"paused\" alone is a usable line (new overload) but the 2-value overload still says no, as before", LiveLinkLogic.TryParseControl("{\"cap\":{\"paused\":true}}", out fps, out w, out pz) && fps == 0 && w == 0 && pz == 1
              && !LiveLinkLogic.TryParseControl("{\"cap\":{\"paused\":true}}", out fps, out w));
        Check("control: no \"paused\" = -1 (no change); a non-boolean or a \"paused\" outside the cap object is not ours", LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":30}}", out fps, out w, out pz) && pz == -1
              && !LiveLinkLogic.TryParseControl("{\"cap\":{\"paused\":\"yes\"}}", out fps, out w, out pz) && pz == -1 && LiveLinkLogic.TryParseControl("{\"paused\":true,\"cap\":{\"fps\":30}}", out fps, out w, out pz) && pz == -1);
        Check("control: garbage is ignored (empty, null, text, truncated, wrong types, huge)",
              !LiveLinkLogic.TryParseControl("", out fps, out w) && !LiveLinkLogic.TryParseControl(null, out fps, out w) && !LiveLinkLogic.TryParseControl("hello", out fps, out w)
              && !LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":", out fps, out w) && !LiveLinkLogic.TryParseControl("{\"cap\":5}", out fps, out w) && !LiveLinkLogic.TryParseControl("{\"cap\":{}}", out fps, out w)
              && !LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":\"fast\",\"w\":null}}", out fps, out w) && !LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":1e999}}", out fps, out w)
              && !LiveLinkLogic.TryParseControl("{\"cap\":{\"fps\":30}" + new string(' ', 5000) + "}", out fps, out w) && fps == 0 && w == 0);

        // per-frame meta
        var vp = new float[] { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 };
        var sb = new StringBuilder();
        string meta = LiveLinkLogic.BuildMeta(sb, 1920, 1440, vp, true, true, 13.49f, -24.2f, -8.5f, 1f, "\"Level1\"");
        Check("meta: exact text {pw,ph,vp,gy,hero,ts,scene,ok}", meta == "{\"pw\":1920,\"ph\":1440,\"vp\":[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],\"gy\":13.49,\"hero\":[-24.2,-8.5],\"ts\":1,\"scene\":\"Level1\",\"ok\":true}", meta);
        using (var doc = JsonDocument.Parse(meta))
        {
            var root = doc.RootElement;
            Check("meta: valid JSON, vp has 16 numbers, hero 2, ts/scene present", root.GetProperty("vp").GetArrayLength() == 16 && root.GetProperty("hero").GetArrayLength() == 2 && root.GetProperty("scene").GetString() == "Level1" && root.GetProperty("ts").GetDouble() == 1.0);
        }
        vp[0] = 0.014625f; vp[1] = -0.5f; vp[2] = 1e-7f; vp[3] = float.NaN; vp[4] = float.PositiveInfinity;
        var sb2 = new StringBuilder(); LiveLinkLogic.AppendVp(sb2, vp);
        Check("meta: vp numbers use view.json's \"0.#####\" format; NaN / Inf become 0 (valid JSON)", sb2.ToString().StartsWith("[0.01463,-0.5,0,0,0,1,") && sb2.ToString().EndsWith(",1]"), sb2.ToString());
        string noCam = LiveLinkLogic.BuildMeta(sb, 1920, 1440, vp, false, true, 0f, 0f, 0f, 0f, null);
        using (var doc = JsonDocument.Parse(noCam))
            Check("meta: without a camera vp is [] and ok is false (still valid JSON)", doc.RootElement.GetProperty("vp").GetArrayLength() == 0 && !doc.RootElement.GetProperty("ok").GetBoolean() && doc.RootElement.GetProperty("scene").GetString() == "", noCam);
        var old = CultureInfo.CurrentCulture;
        try
        {
            CultureInfo.CurrentCulture = new CultureInfo("de-DE");
            string de = LiveLinkLogic.BuildMeta(sb, 10, 10, new float[16], true, true, 1.5f, 2.25f, 3.5f, 0.5f, "\"x\"");
            Check("meta: culture-invariant (de-DE decimal comma must not leak into the JSON)", de.Contains("\"gy\":1.5") && de.Contains("\"hero\":[2.25,3.5]") && !de.Contains("1,5"), de);
        }
        catch (CultureNotFoundException) { Check("meta: culture-invariant (de-DE not installed - skipped)", true); }
        finally { CultureInfo.CurrentCulture = old; }
    }

    // ---------------------------------------------------------------- capture size, pacing, rate adaption, backoff, log throttle
    static void LiveMathTests()
    {
        int w, h;
        Check("size: 1920x1440 @ 1280 -> 1280x960", LiveLinkLogic.CaptureSize(1920, 1440, 1280, out w, out h) && w == 1280 && h == 960);
        Check("size: 1920x1080 @ 1280 -> 1280x720", LiveLinkLogic.CaptureSize(1920, 1080, 1280, out w, out h) && w == 1280 && h == 720);
        Check("size: 2560x1440 @ 1920 -> 1920x1080", LiveLinkLogic.CaptureSize(2560, 1440, 1920, out w, out h) && w == 1920 && h == 1080);
        Check("size: 1366x768 @ 1280 -> 1280x720 (719.67 rounds to the even 720)", LiveLinkLogic.CaptureSize(1366, 768, 1280, out w, out h) && w == 1280 && h == 720);
        Check("size: odd request 1001 rounds to the even 1002 (ties up), height stays even", LiveLinkLogic.CaptureSize(1920, 1440, 1001, out w, out h) && w == 1002 && h == 752 && w % 2 == 0 && h % 2 == 0, w + "x" + h);
        Check("size: request below 320 clamps up (320x240)", LiveLinkLogic.CaptureSize(1920, 1440, 100, out w, out h) && w == 320 && h == 240);
        Check("size: request above 1920 clamps down", LiveLinkLogic.CaptureSize(3840, 2160, 9999, out w, out h) && w == 1920 && h == 1080);
        Check("size: never upscales past the screen (800x600 stays 800x600)", LiveLinkLogic.CaptureSize(800, 600, 1920, out w, out h) && w == 800 && h == 600);
        Check("size: portrait window keeps its aspect (1080x1920 @ 1920 -> 1080x1920)", LiveLinkLogic.CaptureSize(1080, 1920, 1920, out w, out h) && w == 1080 && h == 1920);
        Check("size: height is capped at 4096 (livecap's limit), width follows", LiveLinkLogic.CaptureSize(1000, 8000, 1000, out w, out h) && h == 4096 && w == 512, w + "x" + h);
        Check("size: a minimised window (0x0) / tiny screen cannot be captured", !LiveLinkLogic.CaptureSize(0, 0, 1280, out w, out h) && w == 0 && h == 0 && !LiveLinkLogic.CaptureSize(8, 8, 1280, out w, out h));
        bool allEven = true, aspectOk = true;
        foreach (int sw in new[] { 640, 800, 1024, 1280, 1366, 1600, 1920, 2560, 3440, 3840 })
            foreach (int sh in new[] { 480, 600, 720, 768, 900, 1080, 1200, 1440, 2160 })
                foreach (int rw in new[] { 320, 641, 960, 1280, 1500, 1919, 1920 })
                {
                    if (!LiveLinkLogic.CaptureSize(sw, sh, rw, out w, out h)) { allEven = false; continue; }
                    if (w % 2 != 0 || h % 2 != 0 || w > 1920 || w > sw + 1 || h > 4096) allEven = false;
                    if (Math.Abs(h - (double)w * sh / sw) > 1.0001) aspectOk = false;                        // nearest-even rounding: never more than 1 px off
                }
        Check("size: sweep over screens x requests - always even, <= 1920 wide, <= the screen", allEven);
        Check("size: sweep - the height is within 1 px of the exact aspect-preserving height", aspectOk);

        Check("interval: 30 fps = 1/30 s; clamps to 5..60", Math.Abs(LiveLinkLogic.IntervalFor(30) - 1f / 30f) < 1e-6 && Math.Abs(LiveLinkLogic.IntervalFor(1) - 0.2f) < 1e-6 && Math.Abs(LiveLinkLogic.IntervalFor(500) - 1f / 60f) < 1e-6);
        Check("interval: Due honours half a frame of slack", LiveLinkLogic.Due(1.0f, 1.0f, 0.0167f) && LiveLinkLogic.Due(1.0f, 1.008f, 0.0167f) && !LiveLinkLogic.Due(1.0f, 1.02f, 0.0167f)
              && !LiveLinkLogic.Due(1.0f, 1.2f, 5f), "slack is capped at 50 ms");
        Check("interval: Advance keeps the phase, and after a hitch restarts from now (no catch-up burst)", Math.Abs(LiveLinkLogic.Advance(1.0f, 1.0f, 0.0333f) - 1.0333f) < 1e-5 && Math.Abs(LiveLinkLogic.Advance(1.0f, 2.0f, 0.0333f) - 2.0333f) < 1e-5);
        foreach (var c in new[] { new[] { 60, 30 }, new[] { 60, 20 }, new[] { 60, 45 }, new[] { 120, 60 }, new[] { 144, 30 }, new[] { 30, 30 }, new[] { 90, 25 } })
        {
            int gameFps = c[0], target = c[1];
            float dt = 1f / gameFps, interval = LiveLinkLogic.IntervalFor(target), next = 0f, last = -1f, maxGap = 0f;
            int count = 0, secs = 20;
            for (int i = 0; i < gameFps * secs; i++)
            {
                float t = i * dt;
                if (!LiveLinkLogic.Due(t, next, dt)) continue;
                count++;
                if (last >= 0f) maxGap = Math.Max(maxGap, t - last);
                last = t;
                next = LiveLinkLogic.Advance(next, t, interval);
            }
            double rate = count / (double)secs;
            Check("pacing: a " + gameFps + " Hz game on a " + target + " fps schedule captures " + ActLogic.F((float)rate) + " fps (within 3 %), max gap " + ActLogic.F(maxGap * 1000f) + " ms",
                  Math.Abs(rate - Math.Min(target, gameFps)) <= 0.03 * target && maxGap <= 2.01f * Math.Max(interval, dt), "count=" + count);
        }
        {   // a 500 ms hitch must not be followed by a burst of catch-up captures
            float interval = LiveLinkLogic.IntervalFor(30), next = 0f, t = 0f; int burst = 0; float lastCap = -1f;
            var times = new List<float>();
            for (int i = 0; i < 40; i++) { t += i == 20 ? 0.5f : 1f / 60f; times.Add(t); }
            foreach (var tt in times)
                if (LiveLinkLogic.Due(tt, next, 1f / 60f)) { if (lastCap >= 0f && tt - lastCap < interval * 0.5f) burst++; lastCap = tt; next = LiveLinkLogic.Advance(next, tt, interval); }
            Check("pacing: after a 500 ms hitch the schedule resumes without a burst", burst == 0);
        }

        var ra = new LiveLinkLogic.RateAdapter(30);
        Check("rate: starts at the target", ra.Effective == 30f && ra.Target == 30);
        Check("rate: a clean window changes nothing", ra.Update(30, 0) == 30f);
        Check("rate: too little evidence changes nothing", ra.Update(1, 2) == 30f && ra.Update(0, 0) == 30f);
        Check("rate: exactly 25 % dropped is tolerated", ra.Update(3, 1) == 30f);
        Check("rate: >25 % dropped backs off by 20 %", Math.Abs(ra.Update(10, 10) - 24f) < 1e-4 && Math.Abs(ra.Update(10, 10) - 19.2f) < 1e-4);
        for (int i = 0; i < 40; i++) ra.Update(10, 10);
        Check("rate: never below 5 fps", ra.Effective == 5f);
        int windows = 0;
        while (ra.Effective < 30f && windows < 100) { ra.Update(10, 0); windows++; }
        Check("rate: clean windows creep back up (+3 fps per window) to the target and stop there", ra.Effective == 30f && windows == 9 && ra.Update(10, 0) == 30f, "windows=" + windows);
        ra.SetTarget(10);
        Check("rate: lowering the target pulls the effective rate down with it", ra.Target == 10 && ra.Effective == 10f);
        ra.SetTarget(60);
        Check("rate: raising the target lets it creep up again", ra.Target == 60 && ra.Effective == 10f && ra.Update(10, 0) > 10f);
        Check("rate: the target is clamped to 5..60", new LiveLinkLogic.RateAdapter(1).Target == 5 && new LiveLinkLogic.RateAdapter(500).Target == 60);

        double b = LiveLinkLogic.BackoffStart; var seq = new List<double> { b };
        for (int i = 0; i < 5; i++) { b = LiveLinkLogic.NextBackoff(b); seq.Add(b); }
        Check("backoff: 0.5 -> 1 -> 2 -> 4 -> 5 -> 5 s", string.Join(",", seq) == "0.5,1,2,4,5,5", string.Join(",", seq));

        var th = new LiveLinkLogic.LogThrottle(30);
        Check("throttle: one message per kind per 30 s", th.Allow("a", 100) && !th.Allow("a", 110) && !th.Allow("a", 129.9) && th.Allow("a", 130) && th.Allow("b", 111) && !th.Allow("b", 112));
    }

    // ---------------------------------------------------------------- the latest-frame slot / buffer pool
    static void LiveExchangeTests()
    {
        var ex = new FrameExchange();
        var a = ex.Rent(100);
        Check("exchange: first Rent allocates", ex.Allocated == 1 && a.Data.Length == 100);
        ex.Publish(a);
        var got = ex.TakeLatest();
        Check("exchange: publish -> take hands the same frame over, then the slot is empty", ReferenceEquals(got, a) && ex.TakeLatest() == null);
        ex.Return(got);
        var a2 = ex.Rent(100);
        Check("exchange: a returned frame is reused (no allocation)", ReferenceEquals(a2, a) && ex.Allocated == 1);
        var b = ex.Rent(100);
        ex.Publish(a2); ex.Publish(b);
        Check("exchange: latest wins - the older unsent frame is dropped and counted", ReferenceEquals(ex.TakeLatest(), b) && ex.Dropped == 1 && ex.Published == 3);
        ex.Return(b);
        var c1 = ex.Rent(100); var c2 = ex.Rent(100);
        Check("exchange: the dropped frame went back to the pool (still only 2 allocations)", ex.Allocated == 2 && (ReferenceEquals(c1, a2) || ReferenceEquals(c2, a2)));
        ex.Publish(c1); ex.Clear();
        Check("exchange: Clear drops a pending frame (a new connection must not start with a stale picture)", ex.TakeLatest() == null && ReferenceEquals(ex.Rent(100), c1));
        var ex2 = new FrameExchange();
        var p1 = ex2.Rent(100); var p2 = ex2.Rent(100);
        ex2.Return(p1); ex2.Return(p2);                                   // pool: two 100-byte frames
        var q1 = ex2.Rent(200);
        Check("exchange: a different size gets a new buffer (the wrong-size pooled ones are retired)", q1.Data.Length == 200 && ex2.Allocated == 3);
        ex2.Return(q1);
        var q2 = ex2.Rent(200);
        Check("exchange: ... and the pool serves the new size afterwards", ReferenceEquals(q2, q1) && ex2.Allocated == 3);
        var q3 = ex2.Rent(100);
        Check("exchange: ... while a 100-byte request no longer finds the retired ones", !ReferenceEquals(q3, p1) && !ReferenceEquals(q3, p2) && ex2.Allocated == 4);

        var st = new FrameExchange();
        int taken = 0;
        for (int i = 0; i < 5000; i++)
        {
            var f = st.Rent(4096); st.Publish(f);
            if (i % 2 == 0) { var t = st.TakeLatest(); if (t != null) { taken++; st.Return(t); } }
        }
        Check("exchange: 5000 frames with a consumer at half speed: 2500 taken, 2499 dropped, never more than 3 buffers allocated", st.Allocated <= 3 && taken == 2500 && st.Dropped == 2499 && st.Published == 5000, "allocated " + st.Allocated + ", dropped " + st.Dropped + ", taken " + taken);

        var race = new FrameExchange();
        int pub = 0, rec = 0; bool stop = false; string failure = null;
        var consumer = new Thread(() =>
        {
            try { while (!Volatile.Read(ref stop)) { var f = race.TakeLatest(); if (f == null) { Thread.Yield(); continue; } rec++; race.Return(f); } }
            catch (Exception e) { failure = e.ToString(); }
        });
        consumer.Start();
        var sw = System.Diagnostics.Stopwatch.StartNew();
        while (sw.ElapsedMilliseconds < 300) { var f = race.Rent(1024); race.Publish(f); pub++; }
        Volatile.Write(ref stop, true); consumer.Join(2000);
        var rest = race.TakeLatest();
        Check("exchange: producer / consumer threads - every published frame is either received, dropped or still pending", failure == null && pub == rec + race.Dropped + (rest != null ? 1 : 0), "pub=" + pub + " rec=" + rec + " dropped=" + race.Dropped + " " + failure);
        Check("exchange: ... and the pool stayed tiny (<= 4 allocations)", race.Allocated <= 4, "allocated " + race.Allocated);
    }

    // ---------------------------------------------------------------- pixel helpers: luma, grid sampling, orientation probe
    static byte[] Image(int w, int h, Func<int, int, int> lumaAt)     // RGBA, row 0 = first row of the buffer
    {
        var px = new byte[w * h * 4];
        for (int y = 0; y < h; y++)
            for (int x = 0; x < w; x++)
            {
                int i = (y * w + x) * 4, v = Math.Max(0, Math.Min(255, lumaAt(x, y)));
                px[i] = (byte)v; px[i + 1] = (byte)v; px[i + 2] = (byte)v; px[i + 3] = 255;
            }
        return px;
    }

    static void LivePixelTests()
    {
        var black = new byte[64 * 4]; var white = new byte[64 * 4];
        for (int i = 0; i < white.Length; i++) white[i] = 255;
        Check("luma: black = 0, white = 255", LiveLinkLogic.MeanLuma(black, black.Length, 1) == 0f && Math.Abs(LiveLinkLogic.MeanLuma(white, white.Length, 1) - 255f) < 1f);
        var half = Image(8, 8, (x, y) => y < 4 ? 200 : 0);
        Check("luma: sampling every 4th pixel still sees the mean (~100)", Math.Abs(LiveLinkLogic.MeanLuma(half, half.Length, 4) - 100f) < 30f && LiveLinkLogic.MeanLuma(null, 0, 1) == 0f);
        bool cellsOk = true;
        foreach (int size in new[] { 1, 2, 5, 16, 24, 100, 1280, 1440, 1920 })
            for (int cells = 16; cells <= 24; cells += 8)
            {
                int prev = -1;
                for (int cell = 0; cell < cells; cell++)
                    for (int sub = 0; sub < 3; sub++)
                    {
                        int p = LiveLinkLogic.CellPixel(cell, cells, size, sub);
                        if (p < 0 || p >= size || p < prev) cellsOk = false;
                        prev = p;
                    }
            }
        Check("grid: CellPixel stays inside the image and is monotone for any size", cellsOk);

        int W = 96, H = 64;
        Func<int, int, int> scene = (x, y) => 20 + y * 3 + (x / 12) * 4 + ((x / 24) % 2 == 0 && y < 20 ? 90 : 0);           // not vertically symmetric
        var upright = Image(W, H, scene);                                                                                      // row 0 first
        var refGrid = new float[LiveLinkLogic.GridW * LiveLinkLogic.GridH]; var testGrid = new float[refGrid.Length];
        LiveLinkLogic.LumaGrid(upright, W, H, refGrid);
        double dd, df;
        LiveLinkLogic.LumaGrid(upright, W, H, testGrid);
        Check("probe: the same picture in the same row order -> +1 (upright)", LiveLinkLogic.DecideFlip(refGrid, testGrid, out dd, out df) == 1 && dd < 1e-9, "direct " + dd + " flipped " + df);
        var flipped = (byte[])upright.Clone();
        LiveLinkLogic.FlipRows(flipped, W, H, 4, new byte[W * 4]);
        LiveLinkLogic.LumaGrid(flipped, W, H, testGrid);
        Check("probe: the same picture upside down -> -1 (flipped)", LiveLinkLogic.DecideFlip(refGrid, testGrid, out dd, out df) == -1 && df < 0.02 * dd, "direct " + dd + " flipped " + df);
        var flat = Image(W, H, (x, y) => 90);
        var flatGrid = new float[refGrid.Length]; LiveLinkLogic.LumaGrid(flat, W, H, flatGrid);
        Check("probe: a flat picture says nothing -> 0", LiveLinkLogic.DecideFlip(flatGrid, flatGrid, out dd, out df) == 0);
        var sym = Image(W, H, (x, y) => 40 + Math.Abs((y / 4) * 2 - 15) * 8 + (x / 4) * 3);                         // cell row k and cell row 15-k are identical
        var symGrid = new float[refGrid.Length]; LiveLinkLogic.LumaGrid(sym, W, H, symGrid);
        Check("probe: a vertically symmetric picture cannot be oriented -> 0", LiveLinkLogic.DecideFlip(symGrid, symGrid, out dd, out df) == 0);
        var other = Image(W, H, (x, y) => 20 + ((x * 7 + y * 13) % 97));
        var otherGrid = new float[refGrid.Length]; LiveLinkLogic.LumaGrid(other, W, H, otherGrid);
        Check("probe: two unrelated pictures -> 0 (no false 'flip')", LiveLinkLogic.DecideFlip(refGrid, otherGrid, out dd, out df) == 0);
        var noisy = (byte[])upright.Clone();
        var rng = new System.Random(7);
        for (int i = 0; i < noisy.Length; i += 4) { int v = noisy[i] + rng.Next(-12, 13); v = Math.Max(0, Math.Min(255, v)); noisy[i] = noisy[i + 1] = noisy[i + 2] = (byte)v; }
        LiveLinkLogic.LumaGrid(noisy, W, H, testGrid);
        Check("probe: ±12 levels of noise (a bilinear downscale is not pixel-exact) still decides correctly", LiveLinkLogic.DecideFlip(refGrid, testGrid, out dd, out df) == 1);
        LiveLinkLogic.FlipRows(noisy, W, H, 4, new byte[W * 4]); LiveLinkLogic.LumaGrid(noisy, W, H, testGrid);
        Check("probe: ... and so does the flipped noisy one", LiveLinkLogic.DecideFlip(refGrid, testGrid, out dd, out df) == -1);

        // colour check of the probe (R/B order, brightness)
        var colorBuf = new byte[W * H * 4];
        for (int i = 0; i < colorBuf.Length; i += 4) { colorBuf[i] = 200; colorBuf[i + 1] = 100; colorBuf[i + 2] = 50; colorBuf[i + 3] = 255; }
        var cg = new float[refGrid.Length]; var mean = new float[3];
        LiveLinkLogic.LumaGrid(colorBuf, W, H, cg, mean);
        Check("color: LumaGrid reports the mean R,G,B of the sampled pixels", Math.Abs(mean[0] - 200f) < 0.01f && Math.Abs(mean[1] - 100f) < 0.01f && Math.Abs(mean[2] - 50f) < 0.01f, mean[0] + "," + mean[1] + "," + mean[2]);
        float gm, gs;
        LiveLinkLogic.GridStats(cg, out gm, out gs);
        Check("color: GridStats of a constant picture = its (R/B-symmetric) luma, std 0", Math.Abs(gm - (53 * (200 + 50) + 150 * 100) / 256f) < 1f && gs < 1e-3f);
        var swappedBuf = (byte[])colorBuf.Clone();
        for (int i = 0; i < swappedBuf.Length; i += 4) { byte t = swappedBuf[i]; swappedBuf[i] = swappedBuf[i + 2]; swappedBuf[i + 2] = t; }
        var cgs = new float[refGrid.Length]; LiveLinkLogic.LumaGrid(swappedBuf, W, H, cgs);
        Check("color: the orientation grid does not change when red and blue are swapped (BGRA read as RGBA cannot fool the flip test)", SameFloats(cg, cgs));
        var scene2 = new byte[W * H * 4];
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) { int i = (y * W + x) * 4; scene2[i] = (byte)(y < H / 2 ? 255 : 0); scene2[i + 1] = (byte)(40 + y); scene2[i + 2] = (byte)(y < H / 2 ? 0 : 255); scene2[i + 3] = 255; }
        var scene2Sw = (byte[])scene2.Clone();
        for (int i = 0; i < scene2Sw.Length; i += 4) { byte t = scene2Sw[i]; scene2Sw[i] = scene2Sw[i + 2]; scene2Sw[i + 2] = t; }
        var g2a = new float[refGrid.Length]; var g2b = new float[refGrid.Length];
        LiveLinkLogic.LumaGrid(scene2, W, H, g2a); LiveLinkLogic.LumaGrid(scene2Sw, W, H, g2b);
        Check("probe: a red-top / blue-bottom scene delivered with R and B swapped is still judged upright, not flipped", LiveLinkLogic.DecideFlip(g2a, g2b, out dd, out df) == 1, "direct " + dd + " flipped " + df);
        LiveLinkLogic.GridStats(refGrid, out gm, out gs);
        Check("color: GridStats of the test scene has real contrast", gs > 20f);
        var cRef = new[] { 200f, 100f, 50f };
        Check("color: identical colours -> no complaint", LiveLinkLogic.ColorDiagnosis(cRef, new[] { 200f, 100f, 50f }) == "" && LiveLinkLogic.ColorDiagnosis(cRef, new[] { 196f, 102f, 53f }) == "");
        Check("color: red and blue swapped -> diagnosed", LiveLinkLogic.ColorDiagnosis(cRef, new[] { 50f, 100f, 200f }).Contains("SWAPPED"));
        Check("color: a grey picture cannot reveal a swap -> no false alarm", LiveLinkLogic.ColorDiagnosis(new[] { 100f, 100f, 100f }, new[] { 100f, 100f, 100f }) == "");
        string dark = LiveLinkLogic.ColorDiagnosis(cRef, new[] { 140f, 70f, 35f });
        Check("color: 30 % darker -> brightness diagnosis with the percentage", dark.StartsWith("brightness is -3") && dark.Contains("%"), dark);
        Check("color: +10 % brighter is tolerated, +30 % is not", LiveLinkLogic.ColorDiagnosis(cRef, new[] { 220f, 110f, 55f }) == "" && LiveLinkLogic.ColorDiagnosis(cRef, new[] { 260f, 130f, 65f }).StartsWith("brightness is +3"));
        Check("color: a near-black reference is not judged on brightness", LiveLinkLogic.ColorDiagnosis(new[] { 3f, 3f, 3f }, new[] { 6f, 6f, 6f }) == "");

        foreach (int hh in new[] { 1, 2, 3, 4, 7 })
        {
            var img = new byte[5 * hh * 4];
            for (int y = 0; y < hh; y++) for (int x = 0; x < 5 * 4; x++) img[y * 20 + x] = (byte)(y + 1);
            var copy = (byte[])img.Clone();
            LiveLinkLogic.FlipRows(img, 5, hh, 4, new byte[20]);
            bool rev = true;
            for (int y = 0; y < hh; y++) for (int x = 0; x < 20; x++) if (img[y * 20 + x] != hh - y) rev = false;
            LiveLinkLogic.FlipRows(img, 5, hh, 4, new byte[20]);
            Check("flip: " + hh + " rows are reversed, and flipping twice restores the image", rev && SameArr(img, copy));
        }
    }

    static bool SameFloats(float[] a, float[] b) { if (a.Length != b.Length) return false; for (int i = 0; i < a.Length; i++) if (Math.Abs(a[i] - b[i]) > 1e-4f) return false; return true; }

    static bool SameArr(byte[] a, byte[] b) { if (a.Length != b.Length) return false; for (int i = 0; i < a.Length; i++) if (a[i] != b[i]) return false; return true; }

    // ---------------------------------------------------------------- perf.v1: ring buffer, percentiles, sections, stall attribution, JSON, file cap
    static float[] Sec(float a, float b, float c, float d, float e) { return new[] { a, b, c, d, e }; }

    static void FramePerfTests()
    {
        // percentiles: nearest rank = ceil(p/100 * n)
        var hundred = new float[100]; for (int i = 0; i < 100; i++) hundred[i] = i + 1;
        Check("perf: percentiles of 1..100 are 50 / 95 / 99 / 100", FramePerfLogic.Percentile(hundred, 100, 50) == 50f && FramePerfLogic.Percentile(hundred, 100, 95) == 95f
              && FramePerfLogic.Percentile(hundred, 100, 99) == 99f && FramePerfLogic.Percentile(hundred, 100, 100) == 100f && FramePerfLogic.Percentile(hundred, 100, 0.5) == 1f);
        var five = new float[] { 10, 20, 30, 40, 50 };
        Check("perf: percentiles of 5 values (rank rounds up): p50 = 30, p95 = p99 = 50, p10 = 10", FramePerfLogic.Percentile(five, 5, 50) == 30f && FramePerfLogic.Percentile(five, 5, 95) == 50f
              && FramePerfLogic.Percentile(five, 5, 99) == 50f && FramePerfLogic.Percentile(five, 5, 10) == 10f);
        Check("perf: percentile of one value is that value, of none is 0, n is honoured (not the array length)", FramePerfLogic.Percentile(new float[] { 7f, 99f }, 1, 99) == 7f && FramePerfLogic.Percentile(five, 0, 50) == 0f && FramePerfLogic.Percentile(five, 3, 100) == 30f);
        var thousand = new float[1000]; for (int i = 0; i < 999; i++) thousand[i] = 16.7f; thousand[999] = 400f;
        Check("perf: one outlier in 1000 frames is the max but not the p99", FramePerfLogic.Percentile(thousand, 1000, 99) == 16.7f && FramePerfLogic.Percentile(thousand, 1000, 100) == 400f);

        // ring buffer: wrap-around keeps the newest `capacity` records, newest first
        var ring = new FrameRing(8);
        var sec = Sec(0, 0, 0, 0, 0);
        for (int i = 0; i < 5; i++) ring.Push(i, 10 + i, 10 + i, 1, sec, 0, 0);
        Check("perf ring: 5 pushes into a ring of 8 -> 5 records, newest first", ring.Count == 5 && ring.FrameMsOf(0) == 14f && ring.FrameMsOf(4) == 10f);
        for (int i = 5; i < 20; i++) ring.Push(i, 10 + i, 10 + i, 1, sec, 0, 0);
        Check("perf ring: 20 pushes into a ring of 8 -> exactly the last 8 (frames 12..19), oldest overwritten", ring.Count == 8 && ring.FrameMsOf(0) == 29f && ring.FrameMsOf(7) == 22f && ring.TimeOf(7) == 12.0);
        Check("perf ring: capacity has a floor of 4", new FrameRing(1).Capacity == 4);

        // summary over a time window: 100 frames, 0.1 s apart, frame_ms 16..25 repeating
        var r2 = new FrameRing(2048); var sum = new PerfSummary();
        for (int i = 0; i < 100; i++) r2.Push(i * 0.1, 16 + (i % 10), 16 + (i % 10), 2f, Sec(1f, 0.5f, 0.25f, 0.125f, 0.125f), 0, 0);
        r2.Summarize(10.0, 5.0, sum);                                        // frames with t >= 5.0: 50..99 = 50 frames
        Check("perf summary: the 5 s window holds exactly the frames inside it (50 of 100)", sum.Frames == 50, "frames " + sum.Frames);
        Check("perf summary: fps = frames that ended in the last second (t >= 9.0: 10 frames)", sum.Fps == 10f, "fps " + sum.Fps);
        Check("perf summary: p50 / p95 / p99 / max of 16..25 repeating", sum.P50 == 20f && sum.P95 == 25f && sum.P99 == 25f && sum.Max == 25f, sum.P50 + " " + sum.P95 + " " + sum.P99 + " " + sum.Max);
        Check("perf summary: plugin avg / max and the per-section averages", Math.Abs(sum.PluginAvg - 2f) < 1e-5 && sum.PluginMax == 2f && Math.Abs(sum.SecAvg[0] - 1f) < 1e-5 && Math.Abs(sum.SecAvg[1] - 0.5f) < 1e-5 && Math.Abs(sum.SecAvg[4] - 0.125f) < 1e-5 && sum.SecMax[2] == 0.25f);
        r2.Summarize(10.0, 0.05, sum);
        Check("perf summary: a window that contains nothing is all zeros (no division by zero)", sum.Frames == 0 && sum.P99 == 0f && sum.PluginAvg == 0f && sum.Max == 0f);
        var small = new FrameRing(16);
        for (int i = 0; i < 100; i++) small.Push(i * 0.01, 16.7f, 16.7f, 1f, sec, 0, 0);
        small.Summarize(1.0, 5.0, sum);
        Check("perf summary: a window longer than the ring only sees what the ring still holds", sum.Frames == 16);

        // stalls: strictly greater than 50 / 100 ms
        var r3 = new FrameRing(512);
        float[] ms = { 16.7f, 50f, 50.1f, 99.9f, 100f, 100.1f, 400f, 16.7f };
        for (int i = 0; i < ms.Length; i++) r3.Push(i * 0.1, ms[i], ms[i], 1f, sec, 0, 0);
        r3.Summarize(1.0, 5.0, sum);
        Check("perf summary: stalls_50 counts frames > 50 ms (50.1, 99.9, 100, 100.1, 400 = 5), stalls_100 frames > 100 ms (100.1, 400 = 2); the limits themselves do not count", sum.Stalls50 == 5 && sum.Stalls100 == 2, sum.Stalls50 + " " + sum.Stalls100);
        Check("perf summary: max is the real maximum", sum.Max == 400f);
        var wall = new FrameRing(16); wall.Push(1.0, 20f, 350f, 1f, sec, 0, 0); wall.Push(1.1, 20f, 20f, 1f, sec, 0, 0);
        wall.Summarize(2.0, 5.0, sum);
        Check("perf summary: the wall-clock max is tracked separately (a clamped unscaledDeltaTime cannot hide a stall)", sum.Max == 20f && sum.WallMax == 350f);

        // realistic: 5 s at 60 fps with 4 stalls of 150 ms among 296 normal frames
        var r4 = new FrameRing(2048);
        for (int i = 0; i < 300; i++) r4.Push(i / 60.0, i % 75 == 7 ? 150f : 16.7f, 16.7f, 1f, sec, 0, 0);
        r4.Summarize(5.0, 5.0, sum);
        Check("perf summary: 4 stalls in 300 frames = 1.3 % of them -> p95 is still a normal frame, p99 and max are the stall", sum.Frames == 300 && sum.Stalls100 == 4 && sum.P95 == 16.7f && sum.P99 == 150f && sum.Max == 150f, sum.Frames + " " + sum.Stalls100 + " " + sum.P95 + " " + sum.P99);

        // O(1), allocation-free per frame
        var r5 = new FrameRing(2048); var secs = Sec(1, 2, 3, 4, 5);
        for (int i = 0; i < 4096; i++) r5.Push(i, 16.7f, 16.7f, 1f, secs, 0, 0);          // warm up
        long a0 = GC.GetAllocatedBytesForCurrentThread();
        for (int i = 0; i < 200000; i++) r5.Push(i, 16.7f, 16.7f, 1f, secs, 0, 0);
        long a1 = GC.GetAllocatedBytesForCurrentThread();
        r5.Summarize(200000.0, 5.0, sum); r5.Summarize(200000.0, 5.0, sum);
        long a2 = GC.GetAllocatedBytesForCurrentThread();
        r5.Summarize(200000.0, 5.0, sum);
        long a3 = GC.GetAllocatedBytesForCurrentThread();
        Check("perf: 200000 Push calls allocate 0 bytes", a1 - a0 == 0, (a1 - a0) + " bytes");
        Check("perf: Summarize (once a second) allocates 0 bytes too", a3 - a2 == 0, (a3 - a2) + " bytes");

        // exclusive sections: update contains Bot.Tick, which contains Coach.PerFrame and Act.PerFrame; livelink runs outside Plugin.Update
        var ex5 = new float[5];
        float total = FramePerfLogic.Exclusive(5f, 3f, 1f, 0.5f, 0.7f, ex5);
        Check("perf sections: cheats = update - bot, bot = botTick - coach - act, coach, act, livelink; total = update + livelink",
              Math.Abs(ex5[0] - 2f) < 1e-5 && Math.Abs(ex5[1] - 1.5f) < 1e-5 && ex5[2] == 1f && ex5[3] == 0.5f && ex5[4] == 0.7f && Math.Abs(total - 5.7f) < 1e-5);
        total = FramePerfLogic.Exclusive(2f, 3f, 4f, 1f, 0f, ex5);
        Check("perf sections: clock granularity can never make a section negative", ex5[0] == 0f && ex5[1] == 0f && total == 2f);
        float topMs; int top = FramePerfLogic.TopSection(Sec(0.2f, 0.5f, 120f, 0.5f, 3f), out topMs);
        Check("perf sections: the longest section is named (coach, 120 ms); ties go to the first; all-zero = none", top == 2 && topMs == 120f && FramePerfLogic.TopSection(Sec(1, 1, 0, 0, 0), out topMs) == 0 && FramePerfLogic.TopSection(Sec(0, 0, 0, 0, 0), out topMs) == -1 && topMs == 0f);
        Check("perf cause: plugin >= 50 % of the frame, engine <= 20 %, mixed between", FramePerfLogic.Cause(200f, 150f) == "plugin" && FramePerfLogic.Cause(200f, 100f) == "plugin" && FramePerfLogic.Cause(200f, 40f) == "engine"
              && FramePerfLogic.Cause(200f, 10f) == "engine" && FramePerfLogic.Cause(200f, 60f) == "mixed" && FramePerfLogic.Cause(0f, 5f) == "engine");

        // stall line (perf-stalls.jsonl)
        string sl = FramePerfLogic.StallLine(1759300123.456, 212.4f, 213.1f, 150.3f, Sec(0.2f, 0.5f, 148.6f, 0.5f, 0.5f), 2, 1);
        using (var doc = JsonDocument.Parse(sl))
        {
            var rt = doc.RootElement;
            Check("perf stall line: valid JSON with t, frame_ms, wall_ms, plugin_ms, cause, top (coach 148.6), gc, shot, sec",
                  Math.Abs(rt.GetProperty("t").GetDouble() - 1759300123.5) < 0.06 && rt.GetProperty("frame_ms").GetDouble() == 212.4 && rt.GetProperty("wall_ms").GetDouble() == 213.1 && rt.GetProperty("plugin_ms").GetDouble() == 150.3
                  && rt.GetProperty("cause").GetString() == "plugin" && rt.GetProperty("top").GetString() == "coach" && rt.GetProperty("top_ms").GetDouble() == 148.6 && rt.GetProperty("gc").GetInt32() == 2
                  && rt.GetProperty("shot").GetString() == "jpg" && rt.GetProperty("sec").GetProperty("coach").GetDouble() == 148.6 && rt.GetProperty("sec").EnumerateObject().Count() == 5, sl);
        }
        using (var doc = JsonDocument.Parse(FramePerfLogic.StallLine(1.0, 300f, 300f, 0.4f, Sec(0, 0.1f, 0, 0, 0.3f), 0, 0)))
            Check("perf stall line: a stall our code did not cause says cause=engine (plugin 0.4 ms of 300) and names the longest section anyway; no shot = \"\"", doc.RootElement.GetProperty("cause").GetString() == "engine" && doc.RootElement.GetProperty("top").GetString() == "livelink" && doc.RootElement.GetProperty("shot").GetString() == "");
        Check("perf stall line: shot flags 2 = png, 3 = jpg+png", FramePerfLogic.StallLine(1, 100, 100, 1, sec, 0, 2).Contains("\"shot\":\"png\"") && FramePerfLogic.StallLine(1, 100, 100, 1, sec, 0, 3).Contains("\"shot\":\"jpg+png\""));
        Check("perf stall line: all-zero sections -> top none; NaN / Infinity never leak into the JSON", FramePerfLogic.StallLine(1, 100, 100, 1, sec, 0, 0).Contains("\"top\":\"none\"") && JsonOk(FramePerfLogic.StallLine(1, float.NaN, float.PositiveInfinity, 1, Sec(float.NaN, 0, 0, 0, 0), 0, 0)));

        // perf.json
        var sm = new PerfSummary { Frames = 300, Fps = 59f, P50 = 16.7f, P95 = 18.2f, P99 = 34f, Max = 212.4f, WallMax = 213.1f, Stalls50 = 5, Stalls100 = 2, PluginAvg = 0.82f, PluginMax = 150.3f };
        for (int i = 0; i < 5; i++) { sm.SecAvg[i] = 0.1f * (i + 1); sm.SecMax[i] = 1f * (i + 1); }
        string pj = FramePerfLogic.PerfJson(1759300123.4, 12, 5.0, sm, 4321, 3, true, true, false, true, 0, 1, 0.31f);
        using (var doc = JsonDocument.Parse(pj))
        {
            var rt = doc.RootElement;
            Check("perf.json: schema - t, seq, window_s, frames, fps, frame_ms{p50,p95,p99,max}, wall_ms_max, stalls_50, stalls_100, plugin_ms{avg,max}",
                  Math.Abs(rt.GetProperty("t").GetDouble() - 1759300123.4) < 1e-6 && rt.GetProperty("seq").GetInt32() == 12 && rt.GetProperty("window_s").GetDouble() == 5 && rt.GetProperty("frames").GetInt32() == 300 && rt.GetProperty("fps").GetDouble() == 59
                  && rt.GetProperty("frame_ms").GetProperty("p50").GetDouble() == 16.7 && rt.GetProperty("frame_ms").GetProperty("p95").GetDouble() == 18.2 && rt.GetProperty("frame_ms").GetProperty("p99").GetDouble() == 34 && rt.GetProperty("frame_ms").GetProperty("max").GetDouble() == 212.4
                  && rt.GetProperty("wall_ms_max").GetDouble() == 213.1 && rt.GetProperty("stalls_50").GetInt32() == 5 && rt.GetProperty("stalls_100").GetInt32() == 2
                  && Math.Abs(rt.GetProperty("plugin_ms").GetProperty("avg").GetDouble() - 0.82) < 1e-9 && rt.GetProperty("plugin_ms").GetProperty("max").GetDouble() == 150.3, pj);
            Check("perf.json: per-section averages and maxima for cheats / bot / coach / act / livelink", rt.GetProperty("sections").GetProperty("cheats").GetDouble() == 0.1 && rt.GetProperty("sections").GetProperty("coach").GetDouble() == 0.3 && rt.GetProperty("sections").GetProperty("livelink").GetDouble() == 0.5
                  && rt.GetProperty("sections_max").GetProperty("bot").GetDouble() == 2 && rt.GetProperty("sections_max").GetProperty("livelink").GetDouble() == 5 && rt.GetProperty("sections").EnumerateObject().Count() == 5, pj);
            Check("perf.json: gc_count / gc_delta, live {enabled, connected}, legacy {jpg, png}, shots {jpg, png}, self_ms", rt.GetProperty("gc_count").GetInt32() == 4321 && rt.GetProperty("gc_delta").GetInt32() == 3 && rt.GetProperty("live").GetProperty("enabled").GetBoolean() && rt.GetProperty("live").GetProperty("connected").GetBoolean()
                  && !rt.GetProperty("legacy").GetProperty("jpg").GetBoolean() && rt.GetProperty("legacy").GetProperty("png").GetBoolean() && rt.GetProperty("shots").GetProperty("jpg").GetInt32() == 0 && rt.GetProperty("shots").GetProperty("png").GetInt32() == 1 && rt.GetProperty("self_ms").GetDouble() == 0.31, pj);
        }
        var oldCulture = CultureInfo.CurrentCulture;
        try
        {
            CultureInfo.CurrentCulture = new CultureInfo("de-DE");
            Check("perf.json: culture-invariant (de-DE decimal comma must not leak)", JsonOk(FramePerfLogic.PerfJson(1759300123.4, 1, 5.0, sm, 1, 0, false, false, true, true, 2, 3, 0.5f)) && !FramePerfLogic.PerfJson(1759300123.4, 1, 5.0, sm, 1, 0, false, false, true, true, 2, 3, 0.5f).Contains("16,7"));
        }
        catch (CultureNotFoundException) { Check("perf.json: culture-invariant (de-DE not installed - skipped)", true); }
        finally { CultureInfo.CurrentCulture = oldCulture; }

        // file cap of perf-stalls.jsonl
        var lines = new StringBuilder();
        for (int i = 0; i < 10; i++) lines.Append("{\"n\":" + i + "}\n");
        string half = FramePerfLogic.NewestHalf(lines.ToString());
        Check("perf cap: the newest half of 10 lines is lines 5..9, in order, newline-terminated", half == "{\"n\":5}\n{\"n\":6}\n{\"n\":7}\n{\"n\":8}\n{\"n\":9}\n", half);
        Check("perf cap: odd counts round the kept half up (5 -> 3), one line stays one, empty stays empty, CRLF and a missing final newline are fine",
              FramePerfLogic.NewestHalf("a\nb\nc\nd\ne\n") == "c\nd\ne\n" && FramePerfLogic.NewestHalf("only\n") == "only\n" && FramePerfLogic.NewestHalf("") == "" && FramePerfLogic.NewestHalf(null) == ""
              && FramePerfLogic.NewestHalf("a\r\nb\r\nc") == "b\nc\n");
        var big = new StringBuilder();
        string row = FramePerfLogic.StallLine(1759300123.4, 212.4f, 213.1f, 150.3f, Sec(0.2f, 0.5f, 148.6f, 0.5f, 0.5f), 2, 1) + "\n";
        while (big.Length <= FramePerfLogic.StallsFileCap) big.Append(row);
        string trimmed = FramePerfLogic.NewestHalf(big.ToString());
        Check("perf cap: a file just over the 200 KB cap shrinks to about half, every kept line is intact JSON", trimmed.Length > FramePerfLogic.StallsFileCap / 2 - row.Length && trimmed.Length < FramePerfLogic.StallsFileCap / 2 + 2 * row.Length && trimmed.TrimEnd('\n').Split('\n').All(JsonOk), trimmed.Length + " chars");
    }

    static bool JsonOk(string s) { try { using (JsonDocument.Parse(s)) return true; } catch (Exception) { return false; } }

    // ---------------------------------------------------------------- AsyncWriter: file writes off the game thread (Act.AtomicWrite, perf.json, perf-stalls.jsonl)
    static void AsyncWriterTests()
    {
        string dir = Path.Combine(Path.GetTempPath(), "asyncwriter_test_" + Environment.ProcessId);
        if (Directory.Exists(dir)) Directory.Delete(dir, true);
        Directory.CreateDirectory(dir);
        try
        {
            string f1 = Path.Combine(dir, "one.json");
            AsyncWriter.Write(f1, "{\"a\":1}");
            Check("asyncwriter: a write lands on disk", AsyncWriter.WaitIdle(3000) && File.ReadAllText(f1) == "{\"a\":1}" && !File.Exists(f1 + ".tmp"));
            for (int i = 0; i < 2000; i++) AsyncWriter.Write(f1, "{\"n\":" + i + "}");
            Check("asyncwriter: latest wins - 2000 rapid writes to one path end with the last text", AsyncWriter.WaitIdle(5000) && File.ReadAllText(f1) == "{\"n\":1999}");

            var sw = System.Diagnostics.Stopwatch.StartNew();
            for (int i = 0; i < 20000; i++) AsyncWriter.Write(f1, "{\"n\":" + i + ",\"pad\":\"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\"}");
            double usPerCall = sw.Elapsed.TotalMilliseconds * 1000.0 / 20000;
            AsyncWriter.WaitIdle(5000);
            Check("asyncwriter: what the game thread pays per Write call is a few microseconds (" + usPerCall.ToString("0.00") + " us), not a file operation", usPerCall < 25.0, usPerCall.ToString("0.00"));

            // no reader ever sees a half-written file (a missing one in the delete/move gap is allowed: livecap's readers skip it)
            string big = Path.Combine(dir, "big.json");
            int good = 0, corrupt = 0; bool stop = false;
            var reader = new Thread(() =>
            {
                while (!Volatile.Read(ref stop))
                {
                    try { using (JsonDocument.Parse(File.ReadAllText(big))) good++; }
                    catch (IOException) { }                                    // missing / being replaced
                    catch (UnauthorizedAccessException) { }                    // Windows reports a delete-pending file as access denied
                    catch (JsonException) { corrupt++; }
                }
            });
            reader.Start();
            var sw2 = System.Diagnostics.Stopwatch.StartNew();
            int k = 0;
            while (sw2.ElapsedMilliseconds < 1500) { AsyncWriter.Write(big, "{\"k\":" + (k++) + ",\"pad\":\"" + new string('y', 20000) + "\"}"); Thread.Sleep(2); }
            AsyncWriter.WaitIdle(3000);
            Volatile.Write(ref stop, true); reader.Join();
            Check("asyncwriter: " + k + " 20 KB replacements read concurrently by a polling reader: " + good + " clean reads, " + corrupt + " torn", corrupt == 0 && good > 20, "good " + good + " corrupt " + corrupt);

            // appends keep their order; above the cap the file is cut to its newest half
            string log = Path.Combine(dir, "log.jsonl");
            for (int i = 0; i < 200; i++) AsyncWriter.Append(log,"{\"i\":" + i + ",\"pad\":\"" + new string('z', 900) + "\"}\n", 100000, FramePerfLogic.NewestHalf);
            AsyncWriter.WaitIdle(5000);
            var lines = File.ReadAllLines(log).Where(l => l.Length > 0).ToList();
            bool inOrder = true; int prev = -1;
            foreach (var l in lines) { int i = JsonDocument.Parse(l).RootElement.GetProperty("i").GetInt32(); if (i <= prev) inOrder = false; prev = i; }
            Check("asyncwriter: appends keep their order, the file ends with the newest line and stays within the cap (" + new FileInfo(log).Length + " bytes, " + lines.Count + " lines; 200 appends < the queue bound of 256, so none can be dropped)",
                  inOrder && prev == 199 && new FileInfo(log).Length <= 100000 + 1000 && lines.All(JsonOk), new FileInfo(log).Length + " bytes, last " + prev);

            // failures never reach the caller, and the writer keeps working afterwards
            int failBefore = AsyncWriter.Failures;
            bool threw = false;
            try { AsyncWriter.Write(Path.Combine(dir, "no", "such", "dir", "x.json"), "x"); AsyncWriter.Append(Path.Combine(dir, "no", "such", "dir", "y.jsonl"), "x\n", 0, null); AsyncWriter.Write(null, "x"); AsyncWriter.Write("x", null); }
            catch (Exception) { threw = true; }
            AsyncWriter.WaitIdle(5000);
            string f2 = Path.Combine(dir, "after.json");
            AsyncWriter.Write(f2, "{\"ok\":true}");
            Check("asyncwriter: a write into a missing directory fails quietly (counted), nulls are ignored, and the next write still works", !threw && AsyncWriter.Failures > failBefore && AsyncWriter.WaitIdle(3000) && File.ReadAllText(f2) == "{\"ok\":true}", "failures " + AsyncWriter.Failures);

            // many threads, many paths
            var threads = new List<Thread>();
            for (int t = 0; t < 8; t++)
            {
                int id = t;
                var th = new Thread(() => { for (int i = 0; i < 300; i++) AsyncWriter.Write(Path.Combine(dir, "m" + id + ".json"), "{\"t\":" + id + ",\"i\":" + i + "}"); });
                threads.Add(th); th.Start();
            }
            foreach (var th in threads) th.Join();
            Check("asyncwriter: 8 threads writing 8 paths concurrently - every file ends with its own last text", AsyncWriter.WaitIdle(5000) && Enumerable.Range(0, 8).All(id => File.ReadAllText(Path.Combine(dir, "m" + id + ".json")) == "{\"t\":" + id + ",\"i\":299}"));
        }
        finally { try { Directory.Delete(dir, true); } catch (Exception) { } }
    }

    // ---------------------------------------------------------------- the real sender thread against a loopback server
    static string ReadLine(NetworkStream ns)
    {
        var sb = new StringBuilder();
        for (;;) { int b = ns.ReadByte(); if (b < 0) throw new IOException("eof"); if (b == '\n') return sb.ToString(); sb.Append((char)b); }
    }

    static byte[] ReadExact(NetworkStream ns, int n)
    {
        var buf = new byte[n]; int got = 0;
        while (got < n) { int k = ns.Read(buf, got, n - got); if (k <= 0) throw new IOException("eof after " + got + " of " + n); got += k; }
        return buf;
    }

    static void PublishPattern(LiveSender s, int w, int h, uint seq, string meta)
    {
        var f = s.Frames.Rent(w * h * 4);
        for (int i = 0; i < f.Data.Length; i++) f.Data[i] = (byte)((i * 31 + (int)seq) & 0xFF);
        f.W = w; f.H = h; f.Fmt = LiveLinkLogic.FmtRgba32; f.Seq = seq; f.TMs = 1759300123456.0 + seq; f.Meta = meta;
        s.Frames.Publish(f);
        s.Wake();
    }

    static void LiveNetTests()
    {
        var listener = new TcpListener(IPAddress.Loopback, 0);
        listener.Start();
        int port = ((IPEndPoint)listener.LocalEndpoint).Port;
        var logs = new List<string>();
        var sender = new LiveSender { Port = port, Build = "live-1", UnityVersion = "2022.3.62f1", Pid = 4242, ConnectTimeoutMs = 1000, BackoffStartS = 0.05, BackoffMaxS = 0.25 };
        sender.Log = (k, t, warn) => { lock (logs) logs.Add(k + (warn ? "!" : "") + ": " + t); };
        sender.ScreenW = 1920; sender.ScreenH = 1440;
        TcpClient cli = null; TcpListener listener2 = null;
        try
        {
            Check("net: Connected semantics before anything happened (link down, never sent)", !sender.LinkUp && double.IsPositiveInfinity(sender.SecondsSinceLastSend()));
            sender.Start();
            var acc = listener.AcceptTcpClientAsync();
            if (!acc.Wait(5000)) { Check("net: the sender connects to the listener", false, "no connection within 5 s"); return; }
            cli = acc.Result;
            var ns = cli.GetStream(); ns.ReadTimeout = 5000;
            string hello = ReadLine(ns);
            Check("net: first bytes on the wire = the hello line", hello + "\n" == LiveLinkLogic.HelloLine("live-1", 4242, 1920, 1440, "2022.3.62f1"), hello);
            Check("net: link reports up", WaitFor(() => sender.LinkUp, 2000) && sender.Connects == 1);

            string meta = "{\"pw\":1920,\"ph\":1440,\"vp\":[],\"gy\":13.49,\"hero\":[-24.2,-8.5],\"ts\":1,\"scene\":\"Level1\",\"ok\":true}";
            PublishPattern(sender, 64, 48, 7, meta);
            var hb = ReadExact(ns, LiveLinkLogic.HeaderLen);
            FrameHeader hd; string err;
            bool hok = LiveLinkLogic.TryDecodeHeader(hb, 0, hb.Length, out hd, out err);
            Check("net: the frame header decodes and carries w/h/fmt/seq/t_ms/payload_len", hok && hd.W == 64 && hd.H == 48 && hd.Fmt == 1 && hd.Seq == 7 && hd.TMs == 1759300123456.0 + 7 && hd.PayloadLen == 64u * 48u * 4u && hd.MetaLen == (uint)meta.Length, err);
            var mb = ReadExact(ns, (int)hd.MetaLen);
            Check("net: meta bytes arrive intact", Encoding.UTF8.GetString(mb) == meta);
            var pb = ReadExact(ns, (int)hd.PayloadLen);
            bool pixOk = true;
            for (int i = 0; i < pb.Length; i++) if (pb[i] != (byte)((i * 31 + 7) & 0xFF)) { pixOk = false; break; }
            Check("net: payload arrives byte-for-byte", pixOk);
            Check("net: Connected bookkeeping after a frame (seconds since send is small, counters moved)", WaitFor(() => sender.FramesSent == 1, 2000) && sender.SecondsSinceLastSend() < 2.0 && sender.BytesSent == 36 + meta.Length + 64 * 48 * 4);

            PublishPattern(sender, 32, 32, 8, null);
            hb = ReadExact(ns, LiveLinkLogic.HeaderLen);
            Check("net: a frame without meta is sent with meta_len 0", LiveLinkLogic.TryDecodeHeader(hb, 0, hb.Length, out hd, out err) && hd.MetaLen == 0 && hd.Seq == 8, err);
            ReadExact(ns, 32 * 32 * 4);

            // control lines livecap -> plugin
            var wr = cli.GetStream();
            byte[] ctl = Encoding.UTF8.GetBytes("{\"cap\": {\"fps\": 45, \"w\": 960}}\nnot json at all\n{\"ping\":1}\n{\"cap\":{\"fps\":500}}\n");
            wr.Write(ctl, 0, ctl.Length);
            Check("net: control lines are applied (garbage + ping ignored, fps clamped to 60, w stays 960)", WaitFor(() => sender.CtlFps == 60, 2000) && sender.CtlW == 960, "fps " + sender.CtlFps + " w " + sender.CtlW);
            byte[] split1 = Encoding.UTF8.GetBytes("{\"cap\":{\"w\":"), split2 = Encoding.UTF8.GetBytes("640}}\n");
            wr.Write(split1, 0, split1.Length); Thread.Sleep(50); wr.Write(split2, 0, split2.Length);
            Check("net: a control line split across two TCP segments is reassembled", WaitFor(() => sender.CtlW == 640, 2000), "w " + sender.CtlW);
            byte[] longLine = new byte[6000]; for (int i = 0; i < longLine.Length; i++) longLine[i] = (byte)'x';
            wr.Write(longLine, 0, longLine.Length);
            byte[] nl = Encoding.UTF8.GetBytes("\n{\"cap\":{\"fps\":10}}\n"); wr.Write(nl, 0, nl.Length);
            Check("net: an over-long garbage line is skipped, the next line still works", WaitFor(() => sender.CtlFps == 10, 2000), "fps " + sender.CtlFps);
            lock (logs) Check("net: control changes were logged as info", logs.Exists(l => l.StartsWith("ctl: ")));
            byte[] pauseLine = Encoding.UTF8.GetBytes("{\"cap\": {\"fps\": 30, \"w\": 1280, \"paused\": true}}\n");
            wr.Write(pauseLine, 0, pauseLine.Length);
            Check("net: livecap's \"paused\": true is picked up with fps / w, the link stays up", WaitFor(() => sender.CtlPaused, 2000) && sender.LinkUp && sender.CtlFps == 30 && sender.CtlW == 1280);
            byte[] resumeLine = Encoding.UTF8.GetBytes("{\"cap\":{\"paused\":false}}\n");
            wr.Write(resumeLine, 0, resumeLine.Length);
            Check("net: \"paused\": false resumes (and leaves fps / w alone)", WaitFor(() => !sender.CtlPaused, 2000) && sender.CtlFps == 30 && sender.CtlW == 1280);
            wr.Write(pauseLine, 0, pauseLine.Length);                  // left paused on purpose: the reconnect below must reset it
            WaitFor(() => sender.CtlPaused, 2000);

            // the consumer goes away: link drops, the sender reconnects by itself and says hello again
            cli.Close(); cli = null;
            Check("net: server closed -> link goes down", WaitFor(() => !sender.LinkUp, 3000));
            var acc2 = listener.AcceptTcpClientAsync();
            bool re = acc2.Wait(5000);
            Check("net: ... and the sender reconnects on its own", re);
            if (re)
            {
                cli = acc2.Result; ns = cli.GetStream(); ns.ReadTimeout = 5000;
                Check("net: second connection starts with a fresh hello", ReadLine(ns) + "\n" == LiveLinkLogic.HelloLine("live-1", 4242, 1920, 1440, "2022.3.62f1"));
                Check("net: link up again, 2 connects / 1 disconnect counted", WaitFor(() => sender.LinkUp && sender.Connects == 2 && sender.Disconnects == 1, 3000), sender.Connects + "/" + sender.Disconnects);
                Check("net: a new connection starts unpaused (the pause belonged to the old one)", !sender.CtlPaused);
                PublishPattern(sender, 16, 16, 9, "{}");
                hb = ReadExact(ns, LiveLinkLogic.HeaderLen);
                Check("net: frames flow again after the reconnect", LiveLinkLogic.TryDecodeHeader(hb, 0, hb.Length, out hd, out err) && hd.Seq == 9, err);
                ReadExact(ns, (int)hd.MetaLen); ReadExact(ns, 16 * 16 * 4);
            }

            // nobody listening: quiet retries (one log line per outage), no exception, then it finds the listener again
            if (cli != null) { cli.Close(); cli = null; }
            listener.Stop();
            Check("net: with the listener gone the link is down", WaitFor(() => !sender.LinkUp, 3000));
            Check("net: ... and one 'down' line is logged", WaitFor(() => { lock (logs) return logs.Exists(l => l.StartsWith("down: ")); }, 6000));
            Thread.Sleep(1200);
            int downs; lock (logs) downs = logs.FindAll(l => l.StartsWith("down: ")).Count;
            Check("net: ... and only ONE for the whole outage (retries are silent)", downs == 1, "down lines: " + downs);
            try { listener2 = new TcpListener(IPAddress.Loopback, port); listener2.Start(); }
            catch (SocketException) { listener2 = null; }
            if (listener2 == null) Check("net: sender finds a listener that comes back (skipped: port could not be re-bound)", true);
            else
            {
                var acc3 = listener2.AcceptTcpClientAsync();
                bool back = acc3.Wait(8000);
                Check("net: when the listener comes back the sender connects again", back && WaitFor(() => sender.LinkUp, 3000));
                if (back) { cli = acc3.Result; Check("net: ... with a hello", ReadLine(cli.GetStream()).StartsWith("TFGAME1 {")); }
            }

            sender.Stop();
            Check("net: Stop() takes the link down", WaitFor(() => !sender.LinkUp, 2000));
            if (cli != null)
            {
                cli.GetStream().ReadTimeout = 3000;
                bool eof = false;
                try { eof = cli.GetStream().ReadByte() < 0; } catch (IOException) { eof = true; }
                Check("net: ... and the server sees the connection close", eof);
            }
        }
        catch (Exception ex) { Check("net: no unexpected exception in the loopback test", false, ex.ToString()); }
        finally
        {
            try { sender.Stop(); } catch (Exception) { }
            try { if (cli != null) cli.Close(); } catch (Exception) { }
            try { listener.Stop(); } catch (Exception) { }
            try { if (listener2 != null) listener2.Stop(); } catch (Exception) { }
        }
    }
}
