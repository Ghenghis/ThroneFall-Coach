using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Episodic memory — things the bot tried that failed, remembered
    /// FOREVER per scene (not just the in-run ignore timers):
    ///
    ///   - build slots that stalled/wedged (ParkSlot events)
    ///   - spots the pathing gave up on
    ///
    /// Stored as "scene|gx,gz|reason" rows in agent/mishaps.json. The build
    /// scanner skips parked cells outright — the same mistake is never
    /// retried. Delete the file (or a row) to unlearn.
    /// </summary>
    internal static class Memory
    {
        private static readonly HashSet<string> parked = new HashSet<string>();
        private static readonly HashSet<string> parkedWhy = new HashSet<string>();
        // Parks EXPIRE — a permanent cell quarantine was the "bot forgets
        // walls/gates" bug: one transient stall (nav block mid-wave) removed
        // the slot from every later attempt and the open_order could never
        // complete. 5 min of wall time is enough to dodge a live jam while
        // still retrying later.
        private static readonly System.Collections.Generic.Dictionary<string, float> parkedAt =
            new System.Collections.Generic.Dictionary<string, float>();
        private const float ParkTtlS = 300f;
        // Scene-level quarantine: a persisted dead match (interactables
        // never spawn — the game resumes the same corrupt save on every
        // reload) must not be re-entered across sessions.
        private static readonly HashSet<string> badScenes = new HashSet<string>();
        // Insertion order for fair eviction — HashSet enumeration can pick
        // the JUST-ADDED key as victim (was silently discarding newest).
        private static readonly System.Collections.Generic.List<string> parkOrder =
            new System.Collections.Generic.List<string>();
        private static string file;
        private static bool loaded;

        private static void EnsureInit()
        {
            if (loaded) return;
            loaded = true;
            try { file = Path.Combine(Recorder.AgentDir, "mishaps.json"); Load(); LoadBadScenes(); }
            catch { }
        }

        private static string Cell(Vector3 p) =>
            $"{Mathf.RoundToInt(p.x / 4f)},{Mathf.RoundToInt(p.z / 4f)}";

        /// <summary>Is this slot position remembered as bad?</summary>
        public static bool IsParked(string scene, Vector3 pos)
        {
            EnsureInit();
            string key = Sanitize(scene) + "|" + Cell(pos);
            if (!parked.Contains(key)) return false;
            if (parkedAt.TryGetValue(key, out float at) &&
                UnityEngine.Time.unscaledTime - at > ParkTtlS)
            {
                parked.Remove(key); parkedAt.Remove(key);
                parkOrder.Remove(key);
                string v2 = null;
                foreach (var w in parkedWhy)
                    if (w.StartsWith(key + "|")) { v2 = w; break; }
                if (v2 != null) parkedWhy.Remove(v2);
                return false;
            }
            return true;
        }

        /// <summary>Record a mishap; persists immediately. Per-scene cap —
        /// an unbounded park list could brick every build slot on a level
        /// forever. At the cap, the newest reason replaces the oldest so the
        /// memory keeps covering the most recent failures.</summary>
        private const int MaxPerScene = 24;
        public static void Park(string scene, Vector3 pos, string why)
        {
            EnsureInit();
            scene = Sanitize(scene);
            // Sanitize the delimiter/quote — a | or " inside `why` corrupted
            // the row on save and then silently vanished on reload. `scene`
            // had the same exposure (unused in practice, but consistent).
            if (why != null && (why.Contains("|") || why.Contains("\"") || why.Contains("\\")))
                why = why.Replace("|", "/").Replace("\"", "'").Replace("\\", "/");
            string key = scene + "|" + Cell(pos);
            if (parked.Add(key))
            {
                parkedWhy.Add(key + "|" + (why ?? "?"));
                parkOrder.Add(key);
                parkedAt[key] = UnityEngine.Time.unscaledTime;
                // Cap per scene: evict the OLDEST entries first (FIFO order,
                // not HashSet enumeration — the newest mishap was getting
                // thrown away while ancient ones survived).
                int count = 0;
                foreach (var p in parkOrder)
                    if (p.StartsWith(scene + "|") && parked.Contains(p)) count++;
                while (count > MaxPerScene)
                {
                    string victim = null;
                    foreach (var p in parkOrder)
                        if (p.StartsWith(scene + "|") && parked.Contains(p))
                        { victim = p; break; }
                    if (victim == null) break;
                    parked.Remove(victim);
                    parkOrder.Remove(victim);
                    string v2 = null;
                    foreach (var w in parkedWhy)
                        if (w.StartsWith(victim + "|")) { v2 = w; break; }
                    if (v2 != null) parkedWhy.Remove(v2);
                    count--;
                }
                Save();
                Plugin.Log?.LogInfo($"[memory] parked '{key}' ({why}) — never retrying");
            }
        }

        /// <summary>Un-learn a cell — used when a build succeeds near a
        /// previously parked spot (the stall was transient, not broken).</summary>
        public static void Unpark(string scene, Vector3 pos)
        {
            EnsureInit();
            string key = Sanitize(scene) + "|" + Cell(pos);
            if (parked.Remove(key))
            {
                parkOrder.Remove(key); parkedAt.Remove(key);
                string v2 = null;
                foreach (var w in parkedWhy)
                    if (w.StartsWith(key + "|")) { v2 = w; break; }
                if (v2 != null) parkedWhy.Remove(v2);
                Save();
                Plugin.Log?.LogInfo($"[memory] unparked '{key}' — slot redeemed");
            }
        }

        public static int Count => parked.Count;

        /// <summary>Scene-level quarantine (interactor-vacuum matches resume
        /// the same corrupt save every reload — never re-enter).</summary>
        public static void MarkBadScene(string scene)
        {
            EnsureInit();
            scene = Sanitize(scene);
            if (string.IsNullOrEmpty(scene)) return;
            if (badScenes.Add(scene))
            {
                SaveBadScenes();
                Plugin.Log?.LogWarning($"[memory] scene quarantined '{scene}' — bad match state persisted");
            }
        }

        public static bool IsBadScene(string scene)
        {
            EnsureInit();
            return scene != null && badScenes.Contains(Sanitize(scene));
        }

        /// <summary>Drop all parked cells for a scene — called on a NEW MATCH:
        /// nav fixes and scene-state changes mean a cell parked under the old
        /// verdict may now be reachable. Permanent parks starved SpendGold
        /// into the Idle deadlock (19 poisoned cells on Neuland). Truly-broken
        /// slots re-park on their own within one stall cycle — bounded cost,
        /// full recovery.</summary>
        public static void ForgiveParks(string scene)
        {
            EnsureInit();
            scene = Sanitize(scene);
            int n = 0;
            foreach (var p in parkOrder.ToArray())
                if (p.StartsWith(scene + "|") && parked.Remove(p))
                { parkOrder.Remove(p); parkedAt.Remove(p); n++; }
            if (n > 0)
            {
                parkedWhy.RemoveWhere(w => w.StartsWith(scene + "|"));
                Save();
                Plugin.Log?.LogInfo($"[memory] forgave {n} parked cells for '{scene}' (new match)");
            }
        }

        /// <summary>Rescan-forgive: drop only TRANSIENT parks. Reasons proven
        /// unreachable ("build-stall", "unreachable", "pocket") survive — the
        /// 30 s rescue rescan otherwise resurrected the same wedged slots and
        /// re-picked them forever (pick→walk→stall→park→forgive→re-pick).
        /// </summary>
        public static void ForgiveParksSoft(string scene)
        {
            EnsureInit();
            scene = Sanitize(scene);
            int n = 0;
            foreach (var p in parkOrder.ToArray())
            {
                if (!p.StartsWith(scene + "|") || !parked.Contains(p)) continue;
                string why = null;
                foreach (var w in parkedWhy)
                    if (w.StartsWith(p + "|")) { why = w; break; }
                string r = why != null ? why.Substring(p.Length + 1) : "";
                if (r.IndexOf("stall", StringComparison.OrdinalIgnoreCase) >= 0 ||
                    r.IndexOf("unreachable", StringComparison.OrdinalIgnoreCase) >= 0 ||
                    r.IndexOf("pocket", StringComparison.OrdinalIgnoreCase) >= 0) continue;
                parked.Remove(p); parkOrder.Remove(p); parkedAt.Remove(p);
                if (why != null) parkedWhy.Remove(why);
                n++;
            }
            if (n > 0)
            {
                Save();
                Plugin.Log?.LogInfo($"[memory] soft-forgave {n} parked cells for '{scene}' (rescan; stall/unreachable kept)");
            }
        }

        /// <summary>Forgive the parks made since <paramref name="sinceT"/> (Time.unscaledTime) - used after the hero got out of an enclosure:
        /// everything parked while it could not leave was parked for the wrong reason (unreachable FROM THERE, not unreachable).</summary>
        public static void ForgiveParksSince(string scene, float sinceT)
        {
            EnsureInit();
            scene = Sanitize(scene);
            int n = 0;
            foreach (var p in parkOrder.ToArray())
                if (p.StartsWith(scene + "|") && parkedAt.TryGetValue(p, out float at) && at >= sinceT && parked.Remove(p))
                {
                    parkOrder.Remove(p); parkedAt.Remove(p); n++;
                    string v2 = null;
                    foreach (var w in parkedWhy) if (w.StartsWith(p + "|")) { v2 = w; break; }
                    if (v2 != null) parkedWhy.Remove(v2);
                }
            if (n > 0) { Save(); Plugin.Log?.LogInfo($"[memory] forgave {n} parked cells for '{scene}' (made while the hero was enclosed)"); }
        }

        /// <summary>Debug/manual: clear a quarantine.</summary>
        public static void ForgiveScene(string scene)
        {
            EnsureInit();   // early calls read an empty badScenes — the remove
                            // silently no-op'd and the quarantine persisted
            if (badScenes.Remove(Sanitize(scene))) SaveBadScenes();
        }

        /// <summary>'|' is the key delimiter — keep scene names key-safe
        /// everywhere they form keys (Park/Unpark/IsParked/MarkBadScene).</summary>
        private static string Sanitize(string scene) =>
            string.IsNullOrEmpty(scene) ? "" : scene.Replace("|", "/")
                .Replace("\"", "'").Replace("\\", "/");

        private static void SaveBadScenes()
        {
            try
            {
                var sb = new System.Text.StringBuilder("[");
                bool first = true;
                foreach (var w in badScenes)
                {
                    if (!first) sb.Append(",");
                    first = false;
                    // Escape through the JSON helper — an unescaped quote in
                    // a scene name would corrupt the quarantine file itself
                    // and un-quarantine a corrupt save on reload.
                    sb.Append(BotPerception.JsonStr(w));
                }
                sb.Append("]");
                Recorder.WriteAtomic(
                    Path.Combine(Recorder.AgentDir, "badscenes.json"), sb.ToString());
            }
            catch { }
        }

        private static void LoadBadScenes()
        {
            try
            {
                var bf = Path.Combine(Recorder.AgentDir, "badscenes.json");
                if (File.Exists(bf))
                    foreach (System.Text.RegularExpressions.Match m in
                        System.Text.RegularExpressions.Regex.Matches(
                            File.ReadAllText(bf), "\"([^\"]+)\""))
                        badScenes.Add(m.Groups[1].Value);
            }
            catch { }
        }

        private static void Save()
        {
            try
            {
                var sb = new System.Text.StringBuilder("[\n");
                bool first = true;
                foreach (var w in parkedWhy)
                {
                    if (!first) sb.Append(",\n");
                    first = false;
                    sb.Append("  \"").Append(w).Append('"');
                }
                sb.Append("\n]\n");
                Recorder.WriteAtomic(file, sb.ToString());
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[memory] save: {ex.Message}"); }
        }

        private static void Load()
        {
            try
            {
                if (!File.Exists(file)) return;
                bool dupes = false;
                foreach (System.Text.RegularExpressions.Match m in
                    System.Text.RegularExpressions.Regex.Matches(
                        File.ReadAllText(file), "\"([^\"]+)\""))
                {
                    string row = m.Groups[1].Value;
                    var parts = row.Split('|');
                    if (parts.Length >= 2)
                    {
                        // parkedWhy only for NEW keys — a duplicate used to
                        // still append a row, growing the file forever and
                        // leaving orphans that survived eviction.
                        if (parked.Add(parts[0] + "|" + parts[1]))
                        {
                            parkOrder.Add(parts[0] + "|" + parts[1]);
                            parkedWhy.Add(row);
                            // Reloaded rows park for 5 min from load — stale
                            // forever-parks were the "forgets walls" bug.
                            parkedAt[parts[0] + "|" + parts[1]] = UnityEngine.Time.unscaledTime;
                        }
                        else dupes = true;
                    }
                }
                if (dupes) Save();   // compact once
                if (parked.Count > 0)
                    Plugin.Log?.LogInfo($"[memory] {parked.Count} mishaps remembered");
            }
            catch (Exception ex)
            { Plugin.Log?.LogWarning($"[memory] load: {ex.Message}"); }
        }
    }
}


