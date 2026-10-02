using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>One parsed `act` command (tools/command_center.py -> agent/act-commands.json).</summary>
    internal struct ActCmd
    {
        public string How;                 // retreat | avoid | goto | clear_ignores | forgive | probe
        public string Note;                // nonce stamped by the server (dedupe key)
        public string Id;                  // probe id echoed in probe.json
        public float X, Z, R, TtlS;        // world x/z (the game's x/z plane), radius m, seconds
        public bool HasXZ;
        public float Sx, Sy;               // probe: screen point in the game's pixel space (origin top-left)
        public bool HasScreen;
        public float Wx, Wz, Wr;           // probe: world point + radius
        public bool HasWorld;
    }

    /// <summary>Pure logic of act.v1 (no Unity runtime needed): parsing + clamping, choosing a retreat point from the hero's trail,
    /// zone membership. Unit-tested in tests/ActLogic.Tests.</summary>
    internal static class ActLogic
    {
        public const float MaxCoord = 2000f, MinR = 2f, MaxR = 40f, MinTtl = 10f, MaxTtl = 1800f;
        static readonly CultureInfo Inv = CultureInfo.InvariantCulture;

        static bool Num(string j, string key, out float v)
        {
            var m = Regex.Match(j, "\"" + key + "\"\\s*:\\s*(-?\\d+(?:\\.\\d+)?(?:[eE][-+]?\\d+)?)");
            v = 0f;
            return m.Success && float.TryParse(m.Groups[1].Value, NumberStyles.Float, Inv, out v);
        }

        static bool Str(string j, string key, out string v)
        {
            var m = Regex.Match(j, "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
            v = m.Success ? m.Groups[1].Value : null;
            return m.Success;
        }

        static readonly HashSet<string> Known = new HashSet<string> { "retreat", "avoid", "goto", "clear_ignores", "forgive", "probe" };

        /// <summary>Parse a command file body. False when it carries no (known) `act`. Values are clamped here, never trusted.</summary>
        public static bool TryParse(string json, out ActCmd c)
        {
            c = default(ActCmd);
            if (string.IsNullOrEmpty(json) || !Str(json, "act", out string how) || !Known.Contains(how)) return false;
            c.How = how;
            Str(json, "note", out c.Note);
            Str(json, "id", out c.Id);
            bool hx = Num(json, "x", out c.X), hz = Num(json, "z", out c.Z);
            c.HasXZ = hx && hz;
            if (c.HasXZ) { c.X = Clamp(c.X, -MaxCoord, MaxCoord); c.Z = Clamp(c.Z, -MaxCoord, MaxCoord); }
            if (!Num(json, "r", out c.R)) c.R = how == "avoid" ? 12f : 0f;
            if (!Num(json, "ttl_s", out c.TtlS)) c.TtlS = how == "avoid" ? 600f : how == "goto" ? 20f : 0f;
            if (how == "avoid") { c.R = Clamp(c.R, MinR, MaxR); c.TtlS = Clamp(c.TtlS, MinTtl, MaxTtl); }
            if (how == "goto") c.TtlS = Clamp(c.TtlS, 3f, 30f);
            c.HasScreen = Num(json, "sx", out c.Sx) && Num(json, "sy", out c.Sy);
            bool wx = Num(json, "wx", out c.Wx), wz = Num(json, "wz", out c.Wz);
            c.HasWorld = wx && wz;
            if (c.HasWorld) { c.Wx = Clamp(c.Wx, -MaxCoord, MaxCoord); c.Wz = Clamp(c.Wz, -MaxCoord, MaxCoord); if (!Num(json, "wr", out c.Wr)) c.Wr = 3f; c.Wr = Clamp(c.Wr, 0.5f, 12f); }
            if (how == "avoid" && !c.HasXZ) return false;
            if (how == "goto" && !c.HasXZ) return false;
            if (how == "probe" && !c.HasScreen && !c.HasWorld) return false;
            return true;
        }

        public static float Clamp(float v, float lo, float hi) { return v < lo ? lo : (v > hi ? hi : v); }

        public static float Flat(Vector3 a, Vector3 b) { float dx = a.x - b.x, dz = a.z - b.z; return (float)Math.Sqrt(dx * dx + dz * dz); }

        public static bool InZone(Vector3 p, Vector3 center, float r) { return Flat(p, center) <= r; }

        /// <summary>Where to walk to get off a pin: the most recent trail point that is at least `minAway` m from the hero
        /// (and not just a second old), else the farthest one; then the server's hint, then towards the castle. `ageS[i]` is how
        /// old trail[i] is (seconds); the trail is ordered oldest first. Null = nothing sensible.</summary>
        public static Vector3? ChooseRetreat(IList<Vector3> trail, IList<float> ageS, Vector3 hero, Vector3? hint, Vector3? castle,
                                             float minAway = 8f, float maxAway = 30f, float minAge = 3f, float maxAge = 40f)
        {
            Vector3? far = null; float farD = 0f;
            for (int i = trail.Count - 1; i >= 0; i--)
            {
                float age = ageS[i];
                if (age < minAge || age > maxAge) continue;
                float d = Flat(trail[i], hero);
                if (d > maxAway) continue;
                if (d >= minAway) return trail[i];
                if (d > farD) { farD = d; far = trail[i]; }
            }
            if (far.HasValue && farD >= 3f) return far;
            if (hint.HasValue)
            {
                float d = Flat(hint.Value, hero);
                if (d >= 3f && d <= 40f) return hint;
            }
            if (castle.HasValue)
            {
                float d = Flat(castle.Value, hero);
                if (d < 3f) return null;
                float step = Math.Min(12f, d);
                var dir = castle.Value - hero; dir.y = 0f; dir.Normalize();
                return hero + dir * step;
            }
            return null;
        }

        /// <summary>Is a (x,z) point free of every active zone? Used to veto a retreat target inside an avoid zone.</summary>
        public static bool FreeOfZones(Vector3 p, IList<Vector3> centers, IList<float> radii)
        {
            for (int i = 0; i < centers.Count; i++) if (InZone(p, centers[i], radii[i])) return false;
            return true;
        }

        public static string F(float v) { return v.ToString("0.##", Inv); }

        public static string Js(string s)
        {
            if (s == null) return "\"\"";
            var sb = new System.Text.StringBuilder(s.Length + 2);
            sb.Append('"');
            foreach (char ch in s)
            {
                if (ch == '\\') sb.Append("\\\\");
                else if (ch == '"') sb.Append("\\\"");
                else if (ch < 0x20) sb.Append(' ');
                else sb.Append(ch);
            }
            return sb.Append('"').ToString();
        }
    }
}
