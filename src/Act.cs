using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Pathfinding;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// act.v1 / view.v1 / probe.v1 - what the command center (tools/command_center.py + the Live View) can ask of the bot and see of it.
    ///   act.v1   movement corrections the incident responder (MiniMax) or the user sends through agent/act-commands.json:
    ///            retreat (walk back along the trail, drop the pinning target), avoid (ban a circle from targeting for ttl seconds),
    ///            goto (walk to x,z), clear_ignores / forgive (reset the parked/ignored targets)
    ///   probe.v1 "what is that?": a screen ray or a world sphere is cast and every collider hit is described (class, name, layer,
    ///            bounds, static?) into agent/probe.json; pin strikes also carry the blocker's geometry in the pin-type event
    ///   view.v1  agent/view.json: the camera's view-projection matrix + active avoid zones, so the Live View can draw any world
    ///            position (incident spots, zones) on the game frame
    /// caps.json advertises exactly what this build can do (the server never sends what the plugin cannot execute).
    /// Everything runs on the main thread from Bot's per-frame Update; commands are clamped in ActLogic (pure, unit-tested).
    /// </summary>
    internal static class Act
    {
        public const string BuildId = "act-1";

        private sealed class Zone { public Vector3 C; public float R; public float Until; public string Note; }
        private static readonly List<Zone> zones = new List<Zone>();
        private static readonly List<Vector3> trail = new List<Vector3>();
        private static readonly List<float> trailT = new List<float>();
        private static float nextTrail, nextPoll, nextView, nextCaps, nextEnforce, lastEnforceDrop;
        private static string lastNote = "", lastCoachNote = "";
        private static string runKey = "";
        private static bool primed, matrixChecked, matrixOk = true;
        private static int execCount;

        /// <summary>The collider that won Bot.PinProbe's classification on the last pin strike (read by PinExtraJson).</summary>
        public static Collider LastPinCol;

        private static string Dir { get { return Recorder.AgentDir; } }
        private static string P(string name) { return System.IO.Path.Combine(Dir, name); }
        private static double Epoch() { return Math.Round(DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0, 1); }

        // ------------------------------------------------------------------------------------------------ per-frame entry
        public static void PerFrame(in BotPerception.Snapshot s, Vector3 aim, bool hasAim)
        {
            try
            {
                if (!primed) Prime();
                if (!BotPerception.LastValid) return;
                string rk = Recorder.RunId ?? "";
                if (rk != runKey) { runKey = rk; zones.Clear(); trail.Clear(); trailT.Clear(); }
                float now = Time.unscaledTime;
                if (now >= nextTrail)
                {
                    nextTrail = now + 0.5f;
                    trail.Add(s.HeroPos); trailT.Add(now);
                    if (trail.Count > 160) { trail.RemoveAt(0); trailT.RemoveAt(0); }
                }
                if (now >= nextPoll) { nextPoll = now + 0.4f; Poll(in s); }
                if (now >= nextEnforce) { nextEnforce = now + 0.5f; Enforce(in s, aim, hasAim, now); }
                if (now >= nextView) { nextView = now + 0.25f; WriteView(in s, now); }
                if (now >= nextCaps) { nextCaps = now + 30f; WriteCaps(); }
            }
            catch (Exception ex) { Plugin.Log?.LogWarning("[act] per-frame: " + ex.Message); }
        }

        private static void Prime()
        {
            primed = true;
            try { lastNote = NoteOf(P("act-commands.json")); lastCoachNote = NoteOf(P("coach-commands.json")); } catch (Exception) { }
            WriteCaps();
            Plugin.Log?.LogInfo("[act] " + BuildId + " ready: retreat/avoid/goto/clear_ignores/forgive/probe, view.json, caps.json");
        }

        private static string NoteOf(string path)
        {
            if (!File.Exists(path)) return "";
            string j = File.ReadAllText(path);
            return ActLogic.TryParse(j, out ActCmd c) ? (c.Note ?? j.GetHashCode().ToString()) : "";
        }

        // ------------------------------------------------------------------------------------------------ intake
        private static void Poll(in BotPerception.Snapshot s)
        {
            // primary channel: act-commands.json (written by the command center); secondary: an `act` inside coach-commands.json
            // (that is where /mmapprove writes an approved semi-mode action)
            TryFile("act-commands.json", ref lastNote, in s);
            TryFile("coach-commands.json", ref lastCoachNote, in s);
        }

        private static void TryFile(string name, ref string last, in BotPerception.Snapshot s)
        {
            string path = P(name);
            if (!File.Exists(path)) return;
            string j;
            try { j = File.ReadAllText(path); } catch (Exception) { return; }     // being rewritten: next poll
            if (!ActLogic.TryParse(j, out ActCmd c)) return;
            string key = c.Note ?? j.GetHashCode().ToString();
            if (key == last) return;
            last = key;
            Execute(c, in s);
        }

        private static void Execute(ActCmd c, in BotPerception.Snapshot s)
        {
            execCount++;
            string detail;
            bool ok = true;
            try
            {
                switch (c.How)
                {
                    case "retreat": ok = DoRetreat(c, in s, out detail); break;
                    case "avoid": ok = DoAvoid(c, in s, out detail); break;
                    case "goto": ok = DoGoto(c, in s, out detail); break;
                    case "clear_ignores":
                    case "forgive": ok = DoForgive(in s, out detail); break;
                    case "probe": ok = DoProbe(c, in s, out detail); break;
                    default: ok = false; detail = "unknown"; break;
                }
            }
            catch (Exception ex) { ok = false; detail = "exception " + ex.Message; }
            Plugin.Log?.LogInfo("[coach] act " + c.How + " " + (ok ? "OK" : "FAILED") + " :: " + detail + " (note " + c.Note + ")");
            Recorder.Event("act", "\"how\":" + ActLogic.Js(c.How) + ",\"ok\":" + (ok ? "true" : "false") + ",\"d\":" + ActLogic.Js(detail));
            File.WriteAllText(P("act-ack.json"), "{\"t\":" + Epoch().ToString(System.Globalization.CultureInfo.InvariantCulture) + ",\"act\":" + ActLogic.Js(c.How) + ",\"note\":" + ActLogic.Js(c.Note) +
                              ",\"ok\":" + (ok ? "true" : "false") + ",\"detail\":" + ActLogic.Js(detail) + ",\"n\":" + execCount + "}");
        }

        // ------------------------------------------------------------------------------------------------ actions
        private static Vector3 Snap(Vector3 p)
        {
            try
            {
                if ((UnityEngine.Object)(object)AstarPath.active != (UnityEngine.Object)null)
                {
                    var q = AstarPath.active.GetNearest(p, new NNConstraint()).position;
                    if (ActLogic.Flat(q, p) <= 6f) return q;
                }
            }
            catch (Exception) { }
            return p;
        }

        private static bool DoRetreat(ActCmd c, in BotPerception.Snapshot s, out string detail)
        {
            var ages = new List<float>(trail.Count);
            float now = Time.unscaledTime;
            for (int i = 0; i < trailT.Count; i++) ages.Add(now - trailT[i]);
            Vector3? hint = c.HasXZ ? new Vector3(c.X, s.HeroPos.y, c.Z) : (Vector3?)null;
            Vector3? castle = s.HasCastle ? s.CastlePos : (Vector3?)null;
            var tgt = ActLogic.ChooseRetreat(trail, ages, s.HeroPos, hint, castle);
            if (!tgt.HasValue) { detail = "no retreat point (empty trail, no hint, no castle)"; return false; }
            var p = Snap(tgt.Value);
            for (int i = 0; i < zones.Count; i++)
                if (ActLogic.InZone(p, zones[i].C, zones[i].R)) { detail = "retreat point lies inside an avoid zone"; return false; }
            Bot.ActClearTarget();
            Bot.SetFocus(p, 6f);
            detail = "walking to (" + ActLogic.F(p.x) + "," + ActLogic.F(p.z) + ") for 6 s, target dropped";
            return true;
        }

        private static bool DoAvoid(ActCmd c, in BotPerception.Snapshot s, out string detail)
        {
            var center = new Vector3(c.X, s.HeroPos.y, c.Z);
            for (int i = zones.Count - 1; i >= 0; i--)                       // a new zone at the same spot replaces the old one (escalation)
                if (ActLogic.Flat(zones[i].C, center) < 6f) zones.RemoveAt(i);
            zones.Add(new Zone { C = center, R = c.R, Until = Time.unscaledTime + c.TtlS, Note = c.Note });
            if (zones.Count > 12) zones.RemoveAt(0);
            int parked = 0;
            try { parked = BotPerception.IgnorePocket(center, c.R, c.TtlS, true); } catch (Exception) { }
            Bot.ActClearTarget();
            detail = "avoid (" + ActLogic.F(c.X) + "," + ActLogic.F(c.Z) + ") r=" + ActLogic.F(c.R) + " for " + ActLogic.F(c.TtlS) + "s, " + parked + " build slot(s) parked, " + zones.Count + " zone(s) active";
            return true;
        }

        private static bool DoGoto(ActCmd c, in BotPerception.Snapshot s, out string detail)
        {
            var p = Snap(new Vector3(c.X, s.HeroPos.y, c.Z));
            Bot.SetFocus(p, c.TtlS);
            detail = "goto (" + ActLogic.F(p.x) + "," + ActLogic.F(p.z) + ") for " + ActLogic.F(c.TtlS) + "s";
            return true;
        }

        private static bool DoForgive(in BotPerception.Snapshot s, out string detail)
        {
            BotPerception.ClearIgnores();
            try { Memory.ForgiveParksSince(s.SceneName, 0f); } catch (Exception) { }
            Bot.ActClearTarget();
            detail = "ignores cleared, parked slots forgiven, target dropped";
            return true;
        }

        /// <summary>Zones keep the bot out: expired ones go; a current aim target inside a zone is dropped (at most every 3 s).</summary>
        private static void Enforce(in BotPerception.Snapshot s, Vector3 aim, bool hasAim, float now)
        {
            for (int i = zones.Count - 1; i >= 0; i--) if (now >= zones[i].Until) zones.RemoveAt(i);
            if (!hasAim || Bot.FocusActive || now - lastEnforceDrop < 3f) return;
            for (int i = 0; i < zones.Count; i++)
                if (ActLogic.InZone(aim, zones[i].C, zones[i].R))
                {
                    lastEnforceDrop = now;
                    Bot.ActClearTarget();
                    Plugin.Log?.LogInfo("[act] aim target (" + ActLogic.F(aim.x) + "," + ActLogic.F(aim.z) + ") is inside an avoid zone -> dropped");
                    Recorder.Event("act-zone-drop", "\"x\":" + ActLogic.F(aim.x) + ",\"z\":" + ActLogic.F(aim.z));
                    return;
                }
        }

        // ------------------------------------------------------------------------------------------------ probe.v1
        private static bool DoProbe(ActCmd c, in BotPerception.Snapshot s, out string detail)
        {
            var sb = new StringBuilder(1200);
            string id = c.Id ?? c.Note ?? "probe";
            float heroY = s.HeroPos.y;
            Collider[] cols; Vector3 world; string mode;
            if (c.HasScreen)
            {
                mode = "screen";
                var cam = Camera.main;
                if (cam == null) { detail = "no main camera"; return false; }
                var ray = cam.ScreenPointToRay(new Vector3(c.Sx, Screen.height - c.Sy, 0f));
                var hits = Physics.RaycastAll(ray, 500f, ~0, QueryTriggerInteraction.Ignore);
                Array.Sort(hits, (a, b) => a.distance.CompareTo(b.distance));
                var plane = new Plane(Vector3.up, new Vector3(0f, heroY, 0f));
                world = plane.Raycast(ray, out float dist) ? ray.GetPoint(dist) : s.HeroPos;
                if (hits.Length > 0) world = hits[0].point;
                cols = new Collider[Math.Min(hits.Length, 8)];
                for (int i = 0; i < cols.Length; i++) cols[i] = hits[i].collider;
            }
            else
            {
                mode = "world";
                world = new Vector3(c.Wx, heroY, c.Wz);
                cols = Physics.OverlapSphere(world + Vector3.up * 0.5f, c.Wr, ~0, QueryTriggerInteraction.Ignore);
                Array.Sort(cols, (a, b) => ((a.transform.position - world).sqrMagnitude).CompareTo((b.transform.position - world).sqrMagnitude));
            }
            sb.Append("{\"id\":").Append(ActLogic.Js(id)).Append(",\"t\":").Append(Epoch().ToString(System.Globalization.CultureInfo.InvariantCulture))
              .Append(",\"mode\":\"").Append(mode).Append("\",\"world\":[").Append(ActLogic.F(world.x)).Append(',').Append(ActLogic.F(world.y)).Append(',').Append(ActLogic.F(world.z)).Append("],\"hits\":[");
            int n = 0;
            foreach (var col in cols)
            {
                if ((UnityEngine.Object)(object)col == (UnityEngine.Object)null || n >= 12) continue;
                if (n++ > 0) sb.Append(',');
                sb.Append(Describe(col, world));
            }
            sb.Append("]}");
            File.WriteAllText(P("probe.json"), sb.ToString());
            detail = "probe " + mode + " at (" + ActLogic.F(world.x) + "," + ActLogic.F(world.z) + "): " + n + " collider(s)";
            return true;
        }

        /// <summary>Same classes as Bot.PinProbe (pen: building / gate / enemy / wall / terrain / obj), plus the geometry.</summary>
        internal static string Classify(Collider c, out bool decorative)
        {
            decorative = false;
            var go = c.gameObject;
            var tg = go.GetComponentInParent<TaggedObject>();
            if (tg != null && tg.Contains(TagManager.ETag.Player)) return "hero";
            var bi = go.GetComponentInParent<BuildingInteractor>();
            if (bi != null)
                return "pen:" + (bi.targetBuilding != null ? bi.targetBuilding.buildingName : bi.name) + (bi.CanBeInteractedWith ? "(upgradeable)" : "");
            if ((UnityEngine.Object)(object)go.GetComponentInParent<GateOpener>() != (UnityEngine.Object)null) return "gate";
            if (tg != null && tg.Contains(TagManager.ETag.EnemyOwned)) return "enemy";
            string n = (go.name ?? "").ToLowerInvariant();
            if (n.Contains("wall")) return "wall";
            if (n.Contains("rock") || n.Contains("stone") || n.Contains("boulder") || n.Contains("mountain") || n.Contains("cliff") || n.Contains("ore") ||
                n.Contains("tree") || n.Contains("stump") || n.Contains("bush") || n.Contains("water") || n.Contains("river") || n.Contains("lake")) return "terrain:" + go.name;
            if (n.Contains("path") || n.Contains("decal") || n.Contains("road") || n.Contains("grass") || n.Contains("fx") || n.Contains("particle") || n.Contains("parent") ||
                n.Contains("container") || n.Contains("holder") || n.Contains("group") || n.Contains("root") || n.Contains("damage collider") || n.Contains("projectile collider"))
            { decorative = true; return "decor:" + go.name; }
            return "obj:" + go.name;
        }

        private static string PathOf(Transform t)
        {
            var parts = new List<string>();
            for (int i = 0; i < 3 && t != null; i++, t = t.parent) parts.Insert(0, t.name);
            return string.Join("/", parts.ToArray());
        }

        private static string Describe(Collider col, Vector3 from)
        {
            var go = col.gameObject;
            string cls = Classify(col, out bool decor);
            var b = col.bounds;
            var sb = new StringBuilder(260);
            sb.Append("{\"name\":").Append(ActLogic.Js(go.name)).Append(",\"cls\":").Append(ActLogic.Js(cls)).Append(",\"decor\":").Append(decor ? "true" : "false")
              .Append(",\"path\":").Append(ActLogic.Js(PathOf(go.transform))).Append(",\"lay\":").Append(ActLogic.Js(LayerMask.LayerToName(go.layer))).Append(",\"tag\":").Append(ActLogic.Js(go.tag))
              .Append(",\"stat\":").Append(go.isStatic ? "true" : "false").Append(",\"trig\":").Append(col.isTrigger ? "true" : "false")
              .Append(",\"c\":[").Append(ActLogic.F(b.center.x)).Append(',').Append(ActLogic.F(b.center.y)).Append(',').Append(ActLogic.F(b.center.z))
              .Append("],\"size\":[").Append(ActLogic.F(b.size.x)).Append(',').Append(ActLogic.F(b.size.y)).Append(',').Append(ActLogic.F(b.size.z))
              .Append("],\"dist\":").Append(ActLogic.F(ActLogic.Flat(b.center, from))).Append('}');
            return sb.ToString();
        }

        /// <summary>Extra fields for the pin-type event: what the pinning collider IS and where it sits (null-safe).</summary>
        public static string PinExtraJson(Vector3 hero)
        {
            try
            {
                var col = LastPinCol; LastPinCol = null;
                if ((UnityEngine.Object)(object)col == (UnityEngine.Object)null) return "";
                var go = col.gameObject; var b = col.bounds;
                return ",\"nm\":" + ActLogic.Js(go.name) + ",\"lay\":" + ActLogic.Js(LayerMask.LayerToName(go.layer)) + ",\"stat\":" + (go.isStatic ? "true" : "false") +
                       ",\"bx\":" + ActLogic.F(b.center.x) + ",\"bz\":" + ActLogic.F(b.center.z) + ",\"sx\":" + ActLogic.F(b.size.x) + ",\"sz\":" + ActLogic.F(b.size.z) +
                       ",\"dst\":" + ActLogic.F(ActLogic.Flat(b.center, hero));
            }
            catch (Exception) { return ""; }
        }

        // ------------------------------------------------------------------------------------------------ view.v1 + caps
        private static void WriteView(in BotPerception.Snapshot s, float now)
        {
            var cam = Camera.main;
            if (cam == null) return;
            Matrix4x4 m = cam.projectionMatrix * cam.worldToCameraMatrix;
            if (!matrixChecked)
            {
                matrixChecked = true;                                        // self-test once: our projection must equal Unity's WorldToScreenPoint
                var sp = cam.WorldToScreenPoint(s.HeroPos);
                var clip = m * new Vector4(s.HeroPos.x, s.HeroPos.y, s.HeroPos.z, 1f);
                if (clip.w > 0.0001f)
                {
                    float px = (clip.x / clip.w * 0.5f + 0.5f) * Screen.width, py = (1f - (clip.y / clip.w * 0.5f + 0.5f)) * Screen.height;
                    matrixOk = Math.Abs(px - sp.x) < 3f && Math.Abs((Screen.height - py) - sp.y) < 3f;
                    Plugin.Log?.LogInfo("[act] view matrix self-test " + (matrixOk ? "OK" : "MISMATCH") + " (mine " + px.ToString("0") + "," + py.ToString("0") + " vs unity " + sp.x.ToString("0") + "," + (Screen.height - sp.y).ToString("0") + ")");
                }
            }
            var inv = System.Globalization.CultureInfo.InvariantCulture;
            var sb = new StringBuilder(700);
            sb.Append("{\"t\":").Append(Epoch().ToString(inv)).Append(",\"ok\":").Append(matrixOk ? "true" : "false").Append(",\"pw\":").Append(Screen.width).Append(",\"ph\":").Append(Screen.height)
              .Append(",\"gy\":").Append(ActLogic.F(s.HeroPos.y)).Append(",\"hero\":[").Append(ActLogic.F(s.HeroPos.x)).Append(',').Append(ActLogic.F(s.HeroPos.z)).Append("],\"vp\":[");
            for (int r = 0; r < 4; r++)
                for (int c = 0; c < 4; c++)
                {
                    if (r + c > 0) sb.Append(',');
                    sb.Append(m[r, c].ToString("0.#####", inv));
                }
            sb.Append("],\"zones\":[");
            for (int i = 0; i < zones.Count; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append("{\"x\":").Append(ActLogic.F(zones[i].C.x)).Append(",\"z\":").Append(ActLogic.F(zones[i].C.z)).Append(",\"r\":").Append(ActLogic.F(zones[i].R))
                  .Append(",\"ttl_left\":").Append(Math.Max(0, Mathf.RoundToInt(zones[i].Until - now))).Append('}');
            }
            sb.Append("]}");
            AtomicWrite(P("view.json"), sb.ToString());
        }

        private static void WriteCaps()
        {
            try
            {
                int pid = System.Diagnostics.Process.GetCurrentProcess().Id;
                string asm = System.Reflection.Assembly.GetExecutingAssembly().Location;
                string built = File.Exists(asm) ? File.GetLastWriteTimeUtc(asm).ToString("yyyy-MM-ddTHH:mm:ssZ") : "?";
                AtomicWrite(P("caps.json"), "{\"t\":" + Epoch().ToString(System.Globalization.CultureInfo.InvariantCulture) + ",\"pid\":" + pid + ",\"build\":" + ActLogic.Js(BuildId) + ",\"dll_time\":" + ActLogic.Js(built) +
                                            ",\"caps\":[\"act.v1\",\"view.v1\",\"probe.v1\"],\"acts\":[\"retreat\",\"avoid\",\"goto\",\"clear_ignores\",\"forgive\",\"probe\"],\"view_ok\":" + (matrixOk ? "true" : "false") + "}");
            }
            catch (Exception ex) { Plugin.Log?.LogWarning("[act] caps: " + ex.Message); }
        }

        private static void AtomicWrite(string path, string text)
        {
            try
            {
                string tmp = path + ".tmp";
                File.WriteAllText(tmp, text);
                if (File.Exists(path)) File.Delete(path);
                File.Move(tmp, path);
            }
            catch (Exception) { }
        }
    }
}
