using System.Collections.Generic;
using UnityEngine;

namespace ThronefallTrainer
{
    // Extracted botpack records — top-level public types; the pack is
    // hand-parsed anyway (JsonUtility dropped nested arrays on this Unity
    // version). Flat shape agreed with claude-refpack.
    [System.Serializable] public class StandPtRec { public float x, y, z, cl, dInt; }
    [System.Serializable] public class SlotPackRec { public int id; public string name; public float[] pos; public StandPtRec[] stands; }
    public class SpawnRouteRec
    {
        public string line;         // "Left Front Road"
        public float[] spawn;       // spawn center [x,z]
        public float[][] wp;        // route waypoints [[x,z],..] ending at castle
        public float lenM;
        public bool fly, ground;    // which spawn types this route accepts
        public float narrowM;       // narrowest clearance on the route
        public float[] narrowAt;    // where (choke point)
    }
    public class WaveRec
    {
        public int wave, count, gold; public string enemy, disp, line; public bool elite; public float hp;
    }

    /// <summary>
    /// Read-only world-state snapshot for the autopilot. Captured once per
    /// decision tick (4 Hz) by <see cref="Bot.Tick"/>; every field derives from
    /// the game's public singleton APIs, so no scanning or screen-reading needed.
    /// </summary>
    internal static class BotPerception
    {
        internal struct Snapshot
        {
            public bool Valid;          // true = inside an active match with a hero
            public string GameState;    // LocalGamestate.CurrentState as text

            public Vector3 HeroPos;
            public float HeroHpPct;     // 0..1
            public bool HeroDead;       // knocked out (ghost)
            public int Balance;         // coin balance in hand
            public int CoreBalance;     // energy-core balance (Craaghelm slots)

            public bool IsNight;
            public float DayTimeLeft;   // seconds of automated day remaining
            public int Wave;
            public int WaveTotal;
            public int EnemyCount;

            public Coin NearestCoin;
            public Vector3 NearestCoinPos;
            public float NearestCoinDist;
            public int CoinCount;       // free coins on the ground

            public TaggedObject NearestEnemy;
            public Vector3 NearestEnemyPos;
            public float NearestEnemyDist;
            public int EnemiesNearHero; // live foes within 8 m of the hero

            public bool HasCastle;
            public Vector3 CastlePos;
            public float CastleDist;

            public bool OnLevelSelect;    // true on the campaign map scene
            public string SceneName;      // active scene for diagnostics
            public int InteractorCount;   // all InteractorBase in scene
            public int LevelCount;        // playable level nodes found
            public LevelInteractor NearestLevel;   // nearest playable level node
            public Vector3 NearestLevelPos;        // its interaction stand point
            public float NearestLevelDist;

            public bool HasHorn;          // Nighthorn exists and is active (day phase)
            public Nighthorn Horn;        // the horn interactable itself
            public Vector3 HornPos;
            public float HornDist;

            public int BuildCount;        // building slots currently interactable
            public BuildingInteractor NearestBuild;    // best-scoring spendable building
            public Vector3 NearestBuildPos;
            public float NearestBuildDist;
            public int NearestBuildScore; // why it won (harvest +1000, military +100, income +30+Δ, base +10)

            // ---- legit-play fields ----
            public int AllyCount;         // live allied units (TagManager.PlayerUnits)
            public Vector3 AllyCentroid;  // mean position of allied units

            public TaggedObject CastleThreat;  // enemy nearest to the castle (defense priority)
            public float CastleThreatDist;     // its distance to the castle

            public bool HasThreatAnchor;
            public Vector3 ThreatAnchor;       // castle shifted ~9 m toward the threat side
            public bool HasArmyAnchor;         // botpack: corridor point for army placement
            public Vector3 ArmyAnchor;
            public string ArmyAnchorLine;

            // Squad/defense coverage (botpack spawn doors)
            public Vector3[] DoorAnchors;
            public string[] DoorLines;
            public int DoorCount;
            public int DoorsCovered;   // doors with >=2 manned units
            public int FreeUnits;      // units not within 10 m of a door
        public int EscortUnits;    // units on hero escort (not squad-available)
            public Vector3 UncoveredDoorPos;
            public string UncoveredDoorLine;
            public int UncoveredDoorTarget;
            public bool UncoveredDoorHot;
            public bool HasUncoveredDoor;
            public int ArmyTarget;
            public float SelfDefendRange;   // hero fights inside this radius
            public float DayBudget;         // learned night-call timing (sec)
            public string PolicyKey;        // RL state key for commits
            public string PolicyFocus;      // RL build_focus pick this tick
            public bool RedAlert;          // enemy inside the protected ring
            public float RedAlertRadius;

            // ---- v3 seam fields (feed SnapshotData / pure Decide) ----
            public bool SceneBusy;             // sceneTransitionIsRunning
            public bool CanCommand;            // CommandUnits.instance != null
            public bool CanSwitch;             // DayNightCycle.Instance != null
            public int NearestBuildKey;        // GetInstanceID — held-slot match
            public string NearestBuildName;    // display/diag name
            public bool NearestBuildHarvest;   // canBeHarvested
            public bool HasWeapon;
            public float ActiveRange;          // active weapon max target-priority range
            public bool ActiveFiresMoving;     // no DelayManualAttackWhileMoving

                // Slot stand-points from the extracted terrain pack (refpack):
            // known-reachable free cells beside each slot — kills the whole
            // "stand-off point inside the collider" wedge class.
            public bool HasBuildStand;       // nearest stand-point for the pick
            public Vector3 BuildStandPos;    // world pos to navigate to
            public float BuildStandDist;
            public Vector3 CastleStandPos;   // castle slot's stand-point
            public bool HasCastleStand;

            // ---- Phase 1 awareness (v3 design §P1/P3/P4/P5/P7) ----
            // P1 next-wave intel via EnemySpawner.GetWaveInfoForNextWave()
            public int NextWaveCount;          // total foes in the upcoming wave
            public int NextWaveElites;         // elite foes in it
            public float NextWaveMaxHp;        // toughest foe hp
            public float NextWaveSpeed;        // fastest foe speed
            public float NextWaveFoeRange;     // longest foe attack range
            public int NextWaveGold;           // goldReward for beating it
            public bool FinalWaveNext;         // the NEXT wave ends the level

            // P3 live-threat metadata (nearest foe to the hero)
            public float NearEnemyRange;       // its attack range (0 melee unknown)
            public float NearEnemyHp;          // its current hp
            public bool NearEnemyElite;        // elite flag on it

            // P5 castle + match framing
            public float CastleHpPct;          // -1 = unknown
            public bool WaveBeforeFinalNext;   // WaveBeforeFinalWaveComingUp

            // P4 shrines (unactivated only — activated ones are inert)
            public int ShrineCount;
            public Vector3 ShrinePos;
            public float ShrineDist;

            // P7 slot classes for the picked interactor
            public int BuildMil;               // military weight of its next upgrade
            public int BuildInc;               // income delta of its next upgrade
        }

        /// <summary>Plain-value projection for the pure layer (BotBrain).</summary>
        internal static SnapshotData ToData(in Snapshot s)
        {
            return new SnapshotData
            {
                Valid = s.Valid, GameState = s.GameState, SceneName = s.SceneName,
                HeroPos = V(s.HeroPos), HeroHpPct = s.HeroHpPct, HeroDead = s.HeroDead,
                Balance = s.Balance, CoreBalance = s.CoreBalance,
                IsNight = s.IsNight, DayTimeLeft = s.DayTimeLeft,
                Wave = s.Wave, WaveTotal = s.WaveTotal, EnemyCount = s.EnemyCount,
                HasCoin = s.NearestCoin != null, CoinPos = V(s.NearestCoinPos),
                CoinDist = s.NearestCoinDist, CoinCount = s.CoinCount,
                HasNearEnemy = s.NearestEnemy != null, NearEnemyPos = V(s.NearestEnemyPos),
                NearEnemyDist = s.NearestEnemyDist, NearFoeCount = s.EnemiesNearHero,
                HasCastle = s.HasCastle, CastlePos = V(s.CastlePos), CastleDist = s.CastleDist,
                HasCastleThreat = s.CastleThreat != null,
                CastleThreatPos = s.CastleThreat != null ? V(s.CastleThreat.transform.position) : Vec2.Zero,
                CastleThreatDist = s.CastleThreatDist,
                HasThreatAnchor = s.HasThreatAnchor, ThreatAnchor = V(s.ThreatAnchor),
                HasArmyAnchor = s.HasArmyAnchor, ArmyAnchor = V(s.ArmyAnchor),
                ArmyAnchorLine = s.ArmyAnchorLine ?? "",
                DoorCount = s.DoorCount, DoorsCovered = s.DoorsCovered,
                FreeUnits = s.FreeUnits,
                HasUncoveredDoor = s.HasUncoveredDoor,
                UncoveredDoorPos = V(s.UncoveredDoorPos),
                UncoveredDoorLine = s.UncoveredDoorLine ?? "",
                UncoveredDoorTarget = s.UncoveredDoorTarget,
                UncoveredDoorHot = s.UncoveredDoorHot,
                ArmyTarget = s.ArmyTarget,
                SelfDefendRange = s.SelfDefendRange,
                DayBudget = s.DayBudget,
                RedAlert = s.RedAlert, RedAlertRadius = s.RedAlertRadius,
                OnLevelSelect = s.OnLevelSelect, InteractorCount = s.InteractorCount,
                LevelCount = s.LevelCount, HasLevel = s.NearestLevel != null,
                LevelPos = V(s.NearestLevelPos), LevelDist = s.NearestLevelDist,
                SceneBusy = s.SceneBusy,
                HasHorn = s.HasHorn, HornPos = V(s.HornPos), HornDist = s.HornDist,
                BuildCount = s.BuildCount, HasBuild = s.NearestBuild != null,
                BuildKey = s.NearestBuild != null ? s.NearestBuild.GetInstanceID() : -1,
                BuildName = s.NearestBuildName, BuildPos = V(s.NearestBuildPos),
                BuildDist = s.NearestBuildDist, BuildScore = s.NearestBuildScore,
                BuildHarvest = s.NearestBuildHarvest,
                AllyCount = s.AllyCount, AllyCentroid = V(s.AllyCentroid),
                CanCommand = s.CanCommand, CanSwitch = s.CanSwitch,
                NightCall = Coach.NightCallRequested,   // pure-layer bridge
                HasWeapon = s.HasWeapon, ActiveRange = s.ActiveRange,
                ActiveFiresMoving = s.ActiveFiresMoving,
                NextWaveCount = s.NextWaveCount, NextWaveElites = s.NextWaveElites,
                NextWaveMaxHp = s.NextWaveMaxHp, NextWaveSpeed = s.NextWaveSpeed,
                NextWaveFoeRange = s.NextWaveFoeRange, NextWaveGold = s.NextWaveGold,
                FinalWaveNext = s.FinalWaveNext,
                NearEnemyRange = s.NearEnemyRange, NearEnemyHp = s.NearEnemyHp,
                NearEnemyElite = s.NearEnemyElite,
                CastleHpPct = s.CastleHpPct, WaveBeforeFinalNext = s.WaveBeforeFinalNext,
                ShrineCount = s.ShrineCount, ShrinePos = V(s.ShrinePos),
                ShrineDist = s.ShrineDist,
                BuildMil = s.BuildMil, BuildInc = s.BuildInc,
                HasBuildStand = s.HasBuildStand, BuildStandPos = V(s.BuildStandPos),
                BuildStandDist = s.BuildStandDist,
                HasCastleStand = s.HasCastleStand, CastleStandPos = V(s.CastleStandPos),
            };
        }

        private static Vec2 V(Vector3 v) { return new Vec2(v.x, v.z); }

        private static readonly List<TaggedObject> castleBuf = new List<TaggedObject>();
        private static LevelInteractor[] levelCache;
        private static float levelScanAt;
        private static ManualAttack maCache;
        private static float weScanAt;
        private static Shrine[] shrineCache;
        private static float shrineScanAt;
        private static bool castleHpLogged;

        // ---- extracted terrain pack (claude-refpack): per-scene slot
        // stand-points. Loaded lazily by scene name from agent/slots/.
        // Records are top-level public classes — JsonUtility silently drops
        // fields of private nested types. ----

        private static SlotPackRec[] slotPack;
        private static SpawnRouteRec[] spawnRoutes;
        private static WaveRec[] wavePack;
        private static StandPtRec[] castleStands;
        private static string slotPackScene = "";
        private static string armyAnchorLine;
        private static int[] doorUnit;
        private static bool[] doorBreach;
        private static float[] doorClaim;   // squad placed, units en route

        /// <summary>Stamp a door as just-posted (executor calls this after
        /// PlaceSquad) so the uncovered-door scan doesn't re-pick the same
        /// corridor while the squad is still walking there.</summary>
        public static void MarkDoorClaim(Vector3 pos)
        {
            if (doorClaim == null || sceneDoorAnchors == null) return;
            for (int i = 0; i < sceneDoorAnchors.Length; i++)
                if ((sceneDoorAnchors[i] - pos).sqrMagnitude < 400f)
                { doorClaim[i] = UnityEngine.Time.unscaledTime; return; }
        }
        private static Vector3[] sceneDoorAnchors;
        private static string[] sceneDoorLines;
        private static string doorScene = "";
        private static int[] doorFoes;
        private static float hornScanAt;   // last horn-interactor rescan
        private static string hornDumpScene;  // interactor dump per scene
        public static InteractorBase HornBi;   // fallback horn handle
        public static int BreachCount;

        /// <summary>M3 grandmaster playbook for the scene (tools/mm-coach.py
        /// writes botpack/strategy_&lt;scene&gt;.json). Hand-parsed like the
        /// botpack itself — JsonUtility is not trusted on this runtime.</summary>
        internal static class Strat   // Bot.PlaceSquad reads Strat.Reserve
        {
            public static int Squad, Reserve, Escort, ArmyTarget;
            public static string Focus = "";
            public static string[] BuildOrder = new string[0];           // "cat:name - note"
            public static System.Collections.Generic.Dictionary<string, int>
                LineSquad = new System.Collections.Generic.Dictionary<string, int>();
        }

        /// <summary>Playbook build order — how many of each category must be
        /// standing before the next entry unlocks. Consumed per scene.</summary>
        public static readonly System.Collections.Generic.Dictionary<string, int>
            CatBuilt = new System.Collections.Generic.Dictionary<string, int>();
        private static string catBuiltScene;
        private static float milFirstAt = -1f;   // first military build (anomaly D3)

        /// <summary>Classify a buildable by name — the categories the
        /// playbook's build_order speaks in.</summary>
        public static string BuildCat(string name)
        {
            string n = (name ?? "").ToLowerInvariant();
            if (n.Contains("wall") || n.Contains("palisade") || n.Contains("fortify")) return "wall";
            if (n.Contains("gate")) return "gate";
            if (n.Contains("tower") || n.Contains("ballista") || n.Contains("cannon") ||
                n.Contains("watchtower")) return "tower";
            if (n.Contains("barrack") || n.Contains("archery") || n.Contains("militia") ||
                n.Contains("guard") || n.Contains("outpost")) return "military";
            if (n.Contains("house") || n.Contains("mill") || n.Contains("farm") ||
                n.Contains("mine") || n.Contains("market")) return "income";
            if (n.Contains("castle")) return "upgrade";
            return "other";
        }

        /// <summary>Called when a hold-to-pay completes — advances the
        /// playbook build order by counting built categories per scene.</summary>
        public static void BuildDone(string buildingName, Vector3 pos = default)
        {
            // Redemption: a slot that completes unparks its cell — transient
            // stalls (occupants, temporary walls) shouldn't be remembered.
            if (pos != default)
                Memory.Unpark(slotPackScene ?? "", pos);
            if (catBuiltScene != slotPackScene)
            {
                catBuiltScene = slotPackScene;
                CatBuilt.Clear();
                milFirstAt = -1f;
            }
            string cat = BuildCat(buildingName);
            if (cat == "military" && milFirstAt < 0f)
                milFirstAt = Time.unscaledTime;
            CatBuilt[cat] = (CatBuilt.TryGetValue(cat, out int c) ? c : 0) + 1;
            Plugin.Log?.LogInfo($"[bot] playbook: built '{buildingName}' (cat {cat} #{CatBuilt[cat]})");
        }

        public static int MilitaryCount() =>
            CatBuilt.TryGetValue("military", out int v) ? v : 0;
        public static float MilitaryFirstAt => milFirstAt;

        /// <summary>Next playbook build categories not yet satisfied —
        /// [0] = the current build target, [1..2] = soon.</summary>
        public static string[] OpenBuildOrder()
        {
            var order = Strat.BuildOrder;
            var need = new System.Collections.Generic.Dictionary<string, int>();
            var open = new System.Collections.Generic.List<string>();
            for (int i = 0; i < order.Length; i++)
            {
                string cat = order[i].Split(':')[0].Trim();
                need.TryGetValue(cat, out int seen);
                need[cat] = seen + 1;
                CatBuilt.TryGetValue(cat, out int have);
                if (have < need[cat]) open.Add(cat);
                if (open.Count >= 3) break;
            }
            return open.ToArray();
        }

        /// <summary>Full playbook checklist for the audit UI: every build_order
        /// entry with its done/pending status against CatBuilt.</summary>
        public static string AuditJson(ref Snapshot s, string mode, float modeSince, float now)
        {
            var sb = new System.Text.StringBuilder(900);
            sb.Append("{\"scene\":").Append(JsonStr(s.SceneName))
              .Append(",\"t\":").Append(Mathf.RoundToInt(now))
              .Append(",\"mode\":").Append(JsonStr(mode))
              .Append(",\"mode_since\":").Append(Mathf.RoundToInt(now - modeSince))
              .Append(",\"gold\":").Append(Mathf.RoundToInt(s.Balance))
              .Append(",\"ally\":").Append(s.AllyCount)
              .Append(",\"free\":").Append(s.FreeUnits)
              .Append(",\"escort\":").Append(s.EscortUnits)
              .Append(",\"army_target\":").Append(s.ArmyTarget)
              .Append(",\"bmil\":").Append(MilitaryCount())
              .Append(",\"bmil_first\":").Append(Mathf.RoundToInt(milFirstAt))
              .Append(",\"foes\":").Append(s.NextWaveCount)
              .Append(",\"night\":").Append(s.IsNight ? "true" : "false")
              .Append(",\"wave\":").Append(s.Wave)
              .Append(",\"wave_total\":").Append(s.WaveTotal)
              .Append(",\"doors_cov\":").Append(s.DoorsCovered)
              .Append(",\"doors\":").Append(s.DoorCount)
              .Append(",\"red\":").Append(s.RedAlert ? "true" : "false")
              .Append(",\"breaches\":").Append(BreachCount)
              .Append(",\"bld\":").Append(s.BuildCount)
              .Append(",\"cur_build\":").Append(JsonStr(s.NearestBuildName))
              .Append(",\"open_order\":[");
            var open = OpenBuildOrder();
            for (int i = 0; i < open.Length; i++)
            { if (i > 0) sb.Append(','); sb.Append(JsonStr(open[i])); }
            sb.Append("],\"cat_built\":{");
            bool first = true;
            foreach (var kv in CatBuilt)
            { if (!first) sb.Append(','); first = false;
              sb.Append(JsonStr(kv.Key)).Append(':').Append(kv.Value); }
            sb.Append("},\"door_units\":[");
            if (doorUnit != null)
                for (int i = 0; i < doorUnit.Length; i++)
                { if (i > 0) sb.Append(','); sb.Append(doorUnit[i]); }
            sb.Append("],\"door_lines\":[");
            if (sceneDoorLines != null)
                for (int i = 0; i < sceneDoorLines.Length; i++)
                { if (i > 0) sb.Append(','); sb.Append(JsonStr(sceneDoorLines[i])); }
            sb.Append("],\"checklist\":[");
            // Every playbook entry, in order, marked done or pending — this
            // is what "following the playbook" means on screen.
            var cnt = new System.Collections.Generic.Dictionary<string, int>();
            for (int i = 0; i < Strat.BuildOrder.Length; i++)
            {
                string entry = Strat.BuildOrder[i];
                string cat = entry.Split(':')[0].Trim();
                cnt.TryGetValue(cat, out int k); cnt[cat] = k + 1;
                CatBuilt.TryGetValue(cat, out int have);
                if (i > 0) sb.Append(',');
                sb.Append("{\"n\":").Append(JsonStr(entry))
                  .Append(",\"done\":").Append(have >= cnt[cat] ? "true" : "false")
                  .Append('}');
            }
            sb.Append("]}");
            return sb.ToString();
        }

        private static string JsonStr(string v)
        {
            if (v == null) return "null";
            return "\"" + v.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }

        private static void LoadStrategy(string scene)
        {
            Strat.Squad = Strat.Reserve = Strat.Escort = Strat.ArmyTarget = 0;
            Strat.Focus = "";
            // Clear order data too — a missing playbook used to leave the
            // PREVIOUS scene's build order + checklist in the audit feed.
            Strat.BuildOrder = new string[0];
            Strat.LineSquad.Clear();
            // CatBuilt/milFirstAt were lazily reset inside BuildDone only —
            // a new scene before the first completion inherited the old
            // scene's counts (playbook categories pre-satisfied, wrong
            // army-starved timers). Reset here where scene context changes.
            CatBuilt.Clear();
            milFirstAt = -1f;
            catBuiltScene = null;
            try
            {
                var p = System.IO.Path.Combine(Recorder.AgentDir, "botpack",
                    "strategy_" + scene.ToLowerInvariant() + ".json");
                if (!System.IO.File.Exists(p)) return;
                string j = System.IO.File.ReadAllText(p);
                Strat.Squad = JInt(j, "squad_size");
                Strat.Reserve = JInt(j, "reserve_size");
                Strat.Escort = JInt(j, "escort_size");
                Strat.ArmyTarget = JInt(j, "army_target");
                // build_order: ["cat:name - note", ...] — the playbook's
                // literal sequence the scoring bonus below follows.
                var bom = System.Text.RegularExpressions.Regex.Match(
                    j, "\"build_order\"\\s*:\\s*\\[(.*?)\\]",
                    System.Text.RegularExpressions.RegexOptions.Singleline);
                var bo = new System.Collections.Generic.List<string>();
                if (bom.Success)
                    foreach (System.Text.RegularExpressions.Match mm in
                        System.Text.RegularExpressions.Regex.Matches(
                            bom.Groups[1].Value, "\"([^\"]+)\""))
                        bo.Add(mm.Groups[1].Value);
                Strat.BuildOrder = bo.ToArray();
                // wave_priority: [{line, squad, note}] → per-door squad sizes.
                Strat.LineSquad.Clear();
                var wpm = System.Text.RegularExpressions.Regex.Match(
                    j, "\"wave_priority\"\\s*:\\s*\\[(.*?)\\]",
                    System.Text.RegularExpressions.RegexOptions.Singleline);
                if (wpm.Success)
                    foreach (System.Text.RegularExpressions.Match wm in
                        System.Text.RegularExpressions.Regex.Matches(
                            wpm.Groups[1].Value,
                            "\"line\"\\s*:\\s*\"([^\"]+)\"[^{}]*?\"squad\"\\s*:\\s*(\\d+)",
                            System.Text.RegularExpressions.RegexOptions.Singleline))
                        Strat.LineSquad[wm.Groups[1].Value.Trim()] =
                            int.Parse(wm.Groups[2].Value);
                var fm = System.Text.RegularExpressions.Regex.Match(
                    j, "\"build_focus\"\\s*:\\s*\"([^\"]*)\"");
                if (fm.Success) Strat.Focus = fm.Groups[1].Value;
                Plugin.Log?.LogInfo($"[bot] strategy '{scene}': squad={Strat.Squad} " +
                    $"reserve={Strat.Reserve} escort={Strat.Escort} army>={Strat.ArmyTarget} " +
                    $"order={Strat.BuildOrder.Length} linesquad={Strat.LineSquad.Count}");
            }
            catch (System.Exception ex) { Plugin.Log?.LogWarning($"[bot] strategy load: {ex.Message}"); }
        }

        /// <summary>One-line playbook summary for the overlay.</summary>
        public static string StrategySummary()
        {
            return $"squad={Strat.Squad} reserve={Strat.Reserve} " +
                   $"escort={Strat.Escort} army>={Strat.ArmyTarget} " +
                   $"focus={Strat.Focus}";
        }

        /// <summary>Raw playbook JSON text for the overlay's playbook page.</summary>
        public static string StrategyText(string scene)
        {
            try
            {
                var p = System.IO.Path.Combine(Recorder.AgentDir, "botpack",
                    "strategy_" + (scene ?? "").ToLowerInvariant() + ".json");
                return System.IO.File.Exists(p) ? System.IO.File.ReadAllText(p) : "";
            }
            catch { return ""; }
        }

        private static int JInt(string j, string key)
        {
            var m = System.Text.RegularExpressions.Regex.Match(
                j, "\"" + key + "\"\\s*:\\s*(-?\\d+)");
            return m.Success ? int.Parse(m.Groups[1].Value) : 0;
        }

        private static SlotPackRec[] LoadSlotPack(string scene)
        {
            if (slotPackScene == scene) return slotPack;
            slotPackScene = scene; slotPack = null; spawnRoutes = null; wavePack = null; castleStands = null;
            LoadStrategy(scene);
            try
            {
                var p = System.IO.Path.Combine(Recorder.AgentDir, "botpack", scene + ".json");
                if (!System.IO.File.Exists(p))
                    p = System.IO.Path.Combine(Recorder.AgentDir, "slots", scene + ".json");   // legacy fallback
                bool exists = System.IO.File.Exists(p);
                Plugin.Log?.LogInfo($"[bot] botpack probe '{scene}': exists={exists} path='{p}'");
                if (!exists) return null;
                string json = System.IO.File.ReadAllText(p);
                slotPack = ParseSlotPack(json);
                spawnRoutes = ParseSpawnRoutes(json);
                wavePack = ParseWaves(json);
                castleStands = ParseCastleStands(json);
                Plugin.Log?.LogInfo($"[bot] botpack '{scene}': {(slotPack != null ? slotPack.Length : -1)} slots, " +
                    $"{(spawnRoutes != null ? spawnRoutes.Length : -1)} routes, " +
                    $"{(wavePack != null ? wavePack.Length : -1)} waves");
            }
            catch (System.Exception ex) { Plugin.Log?.LogWarning($"[bot] botpack load: {ex}"); }
            return slotPack;
        }

        /// <summary>Nearest extracted slot record to a live interactor —
        /// matched by world position (extracted ids don't map to runtime).</summary>
        private static SlotPackRec FindSlot(Vector3 pos)
        {
            if (slotPack == null) return null;
            SlotPackRec best = null; float bd = 4f;
            foreach (var sl in slotPack)
            {
                if (sl.pos == null || sl.pos.Length < 3) continue;
                float dx = sl.pos[0] - pos.x, dz = sl.pos[2] - pos.z;
                float d = dx * dx + dz * dz;
                if (d < bd) { bd = d; best = sl; }
            }
            return best;   // within ~2 m of the extracted record
        }

        private static readonly System.Collections.Generic.HashSet<string> badStands =
            new System.Collections.Generic.HashSet<string>();

        /// <summary>Forget a slot's pack stands after nav proved them
        /// unreachable — the next capture offers the standoff fallback.</summary>
        public static void IgnoreStand(Vector3 slotPos)
        {
            badStands.Add(PosKey(slotPos));
        }

        private static string PosKey(Vector3 p) =>
            ((int)(p.x / 4f)).ToString() + "," + ((int)(p.z / 4f)).ToString();

        /// <summary>Best stand-point for a slot: nearest to the hero among
        /// stands that exist; clearanceM &gt;= 0.5 preferred.</summary>
        private static Vector3 BestStand(SlotPackRec sl, Vector3 hero)
        {
            if (sl == null || sl.stands == null || sl.stands.Length == 0)
                return Vector3.zero;
            StandPtRec best = null; float bd = float.MaxValue;
            foreach (var p in sl.stands)
            {
                if (p.cl < 0.5f) continue;                    // unpathable cell
                float dx = p.x - hero.x, dz = p.z - hero.z;
                float d = dx * dx + dz * dz;
                if (d < bd) { bd = d; best = p; }
            }
            if (best == null) best = sl.stands[0];
            return new Vector3(best.x, best.y, best.z);
        }

        /// <summary>
        /// Minimal deterministic parser for agent/slots/&lt;scene&gt;.json —
        /// JsonUtility dropped the array fields on this Unity version, and the
        /// file is machine-generated in one fixed shape:
        /// {"scene":"X","slots":[{"id":N,"name":"..","pos":[x,y,z],
        ///   "stands":[{"x":..,"y":..,"z":..,"cl":..,"dInt":..},..]},..]}
        /// </summary>
        private static SlotPackRec[] ParseSlotPack(string json)
        {
            var list = new System.Collections.Generic.List<SlotPackRec>();
            var ci = System.Globalization.CultureInfo.InvariantCulture;
            // Bound the scan to the "slots" section — botpack files carry
            // gates/spawns/level objects with their own "pos" keys that would
            // both shadow real slots and push the substrings out of range.
            int scopeEnd = json.Length;
            int si = json.IndexOf("\"slots\"", System.StringComparison.Ordinal);
            if (si >= 0)
            {
                int so = json.IndexOf('[', si);
                int sc = MatchBracket(json, so);
                if (sc > so) scopeEnd = sc;
            }
            int i = 0;
            while (true)
            {
                i = json.IndexOf("\"pos\"", i, System.StringComparison.Ordinal);
                if (i < 0 || i >= scopeEnd) break;
                var sl = new SlotPackRec { name = "" };
                // id sits a few chars before pos
                int h = json.LastIndexOf("\"id\"", i);
                if (h > 0 && i - h < 400) { var m = System.Text.RegularExpressions.Regex.Match(json.Substring(h, System.Math.Min(32, json.Length - h)), "\"id\"\\s*:\\s*(-?\\d+)"); if (m.Success) sl.id = int.Parse(m.Groups[1].Value, ci); }
                var pm = System.Text.RegularExpressions.Regex.Match(json.Substring(i, System.Math.Min(120, json.Length - i)),
                    "\"pos\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
                if (pm.Success) sl.pos = new float[] {
                    float.Parse(pm.Groups[1].Value, ci),
                    float.Parse(pm.Groups[2].Value, ci),
                    float.Parse(pm.Groups[3].Value, ci) };
                int st = json.IndexOf("\"stands\"", i, System.StringComparison.Ordinal);
                if (st > 0)
                {
                    int open = json.IndexOf('[', st);
                    int close = MatchBracket(json, open);
                    if (close > open)
                    {
                        var stands = new System.Collections.Generic.List<StandPtRec>();
                        foreach (System.Text.RegularExpressions.Match sm in
                            System.Text.RegularExpressions.Regex.Matches(
                                json.Substring(open, close - open),
                                "\"x\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"y\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"z\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"cl\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"dInt\"\\s*:\\s*(-?[\\d.eE+-]+)"))
                        {
                            stands.Add(new StandPtRec
                            {
                                x = float.Parse(sm.Groups[1].Value, ci),
                                y = float.Parse(sm.Groups[2].Value, ci),
                                z = float.Parse(sm.Groups[3].Value, ci),
                                cl = float.Parse(sm.Groups[4].Value, ci),
                                dInt = float.Parse(sm.Groups[5].Value, ci),
                            });
                        }
                        sl.stands = stands.ToArray();
                    }
                }
                list.Add(sl);
                i += 5;
            }
            return list.Count == 0 ? null : list.ToArray();
        }

        // interactionComplete / isWaitingForChoice are private — reflect once
        // and cache the FieldInfo (the scan hits ~20 slots at 4 Hz).
        private static System.Reflection.FieldInfo fiComplete, fiWaiting;
        private static bool fiLooked;
        private static bool IsInteractorFinished(BuildingInteractor bi)
        {
            if (!fiLooked)
            {
                fiLooked = true;
                var ty = typeof(BuildingInteractor);
                fiComplete = ty.GetField("interactionComplete",
                    System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                fiWaiting = ty.GetField("isWaitingForChoice",
                    System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
            }
            try
            {
                if (fiComplete != null && (bool)fiComplete.GetValue(bi)) return true;
                if (fiWaiting != null && (bool)fiWaiting.GetValue(bi)) return true;
            }
            catch { }
            return false;
        }

        /// <summary>Strict completion for held-slot stickiness ONLY —
        /// isWaitingForChoice must NOT read as finished (a mid-fill choice
        /// would drop the hold → release → refund; the exact bmil=0 loop).
        /// </summary>
        private static bool IsInteractorComplete(BuildingInteractor bi)
        {
            try { return fiComplete != null && (bool)fiComplete.GetValue(bi); }
            catch { return false; }
        }

        private static int MatchBracket(string s, int open)
        {
            if (open < 0) return -1;
            int depth = 0;
            for (int i = open; i < s.Length; i++)
            {
                if (s[i] == '[') depth++;
                else if (s[i] == ']') { if (--depth == 0) return i; }
            }
            return -1;
        }

        /// <summary>"castle":{...,"stands":[{x,y,z,cl,dInt},..]} — the keep's
        /// proven-free stand cells; same shape as a slot record.</summary>
        private static StandPtRec[] ParseCastleStands(string json)
        {
            int i = json.IndexOf("\"castle\"", System.StringComparison.Ordinal);
            if (i < 0) return null;
            int st = json.IndexOf("\"stands\"", i, System.StringComparison.Ordinal);
            if (st < 0 || st - i > 4000) return null;
            int open = json.IndexOf('[', st);
            int close = MatchBracket(json, open);
            if (close <= open) return null;
            var ci = System.Globalization.CultureInfo.InvariantCulture;
            var list = new System.Collections.Generic.List<StandPtRec>();
            foreach (System.Text.RegularExpressions.Match m in
                System.Text.RegularExpressions.Regex.Matches(
                    json.Substring(open, close - open),
                    "\"x\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"y\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"z\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"cl\"\\s*:\\s*(-?[\\d.eE+-]+)\\s*,\\s*\"dInt\"\\s*:\\s*(-?[\\d.eE+-]+)"))
                list.Add(new StandPtRec
                {
                    x = float.Parse(m.Groups[1].Value, ci),
                    y = float.Parse(m.Groups[2].Value, ci),
                    z = float.Parse(m.Groups[3].Value, ci),
                    cl = float.Parse(m.Groups[4].Value, ci),
                    dInt = float.Parse(m.Groups[5].Value, ci),
                });
            return list.Count == 0 ? null : list.ToArray();
        }

        /// <summary>"spawns":[{line,spawn,wp,lenM,fly,ground,narrowM,narrowAt}]
        /// — enemy corridors; wp polylines end at the castle.</summary>
        private static SpawnRouteRec[] ParseSpawnRoutes(string json)
        {
            int i = json.IndexOf("\"spawns\"", System.StringComparison.Ordinal);
            if (i < 0) return null;
            int open = json.IndexOf('[', i);
            int close = MatchBracket(json, open);
            if (close <= open) return null;
            var ci = System.Globalization.CultureInfo.InvariantCulture;
            var list = new System.Collections.Generic.List<SpawnRouteRec>();
            string body = json.Substring(open + 1, close - open - 1);
            // split top-level route objects
            int depth = 0, start = -1;
            for (int k = 0; k < body.Length; k++)
            {
                char c = body[k];
                if (c == '{') { if (depth == 0) start = k; depth++; }
                else if (c == '}')
                {
                    depth--;
                    if (depth == 0 && start >= 0)
                    {
                        var seg = body.Substring(start, k - start + 1);
                        var r = new SpawnRouteRec();
                        var lm = System.Text.RegularExpressions.Regex.Match(seg, "\"line\"\\s*:\\s*\"([^\"]*)\"");
                        r.line = lm.Success ? lm.Groups[1].Value : "";
                        var sm = System.Text.RegularExpressions.Regex.Match(seg, "\"spawn\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
                        if (sm.Success) r.spawn = new float[] { float.Parse(sm.Groups[1].Value, ci), float.Parse(sm.Groups[2].Value, ci) };
                        var wm = System.Text.RegularExpressions.Regex.Match(seg, "\"wp\"\\s*:\\s*(\\[.*\\])", System.Text.RegularExpressions.RegexOptions.Singleline);
                        if (wm.Success)
                        {
                            var wps = new System.Collections.Generic.List<float[]>();
                            foreach (System.Text.RegularExpressions.Match pm in
                                System.Text.RegularExpressions.Regex.Matches(wm.Groups[1].Value, "\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]"))
                                wps.Add(new float[] { float.Parse(pm.Groups[1].Value, ci), float.Parse(pm.Groups[2].Value, ci) });
                            r.wp = wps.ToArray();
                        }
                        var nm = System.Text.RegularExpressions.Regex.Match(seg, "\"lenM\"\\s*:\\s*(-?[\\d.eE+-]+)");
                        if (nm.Success) r.lenM = float.Parse(nm.Groups[1].Value, ci);
                        var nrm = System.Text.RegularExpressions.Regex.Match(seg, "\"narrowM\"\\s*:\\s*(-?[\\d.eE+-]+)");
                        if (nrm.Success) r.narrowM = float.Parse(nrm.Groups[1].Value, ci);
                        var nam = System.Text.RegularExpressions.Regex.Match(seg, "\"narrowAt\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
                        if (nam.Success) r.narrowAt = new float[] { float.Parse(nam.Groups[1].Value, ci), float.Parse(nam.Groups[2].Value, ci) };
                        r.fly = seg.IndexOf("\"fly\": true", System.StringComparison.Ordinal) >= 0 ||
                                seg.IndexOf("\"fly\":true", System.StringComparison.Ordinal) >= 0;
                        r.ground = seg.IndexOf("\"ground\": true", System.StringComparison.Ordinal) >= 0 ||
                                   seg.IndexOf("\"ground\":true", System.StringComparison.Ordinal) >= 0;
                        list.Add(r);
                        start = -1;
                    }
                }
            }
            return list.Count == 0 ? null : list.ToArray();
        }

        /// <summary>"waves":[{wave,count,enemy,disp,elite,gold,line,hp}] —
        /// which line the Nth night comes through (pre-positioning).</summary>
        private static WaveRec[] ParseWaves(string json)
        {
            int i = json.IndexOf("\"waves\"", System.StringComparison.Ordinal);
            if (i < 0) return null;
            int open = json.IndexOf('[', i);
            int close = MatchBracket(json, open);
            if (close <= open) return null;
            var ci = System.Globalization.CultureInfo.InvariantCulture;
            var list = new System.Collections.Generic.List<WaveRec>();
            string body = json.Substring(open + 1, close - open - 1);
            int depth = 0, start = -1;
            for (int k = 0; k < body.Length; k++)
            {
                char c = body[k];
                if (c == '{') { if (depth == 0) start = k; depth++; }
                else if (c == '}')
                {
                    depth--;
                    if (depth == 0 && start >= 0)
                    {
                        var seg = body.Substring(start, k - start + 1);
                        var w = new WaveRec();
                        var m1 = System.Text.RegularExpressions.Regex.Match(seg, "\"wave\"\\s*:\\s*(-?\\d+)");
                        if (m1.Success) w.wave = int.Parse(m1.Groups[1].Value, ci);
                        var m2 = System.Text.RegularExpressions.Regex.Match(seg, "\"count\"\\s*:\\s*(-?\\d+)");
                        if (m2.Success) w.count = int.Parse(m2.Groups[1].Value, ci);
                        var m3 = System.Text.RegularExpressions.Regex.Match(seg, "\"enemy\"\\s*:\\s*\"([^\"]*)\"");
                        if (m3.Success) w.enemy = m3.Groups[1].Value;
                        var m4 = System.Text.RegularExpressions.Regex.Match(seg, "\"line\"\\s*:\\s*\"([^\"]*)\"");
                        if (m4.Success) w.line = m4.Groups[1].Value;
                        var m5 = System.Text.RegularExpressions.Regex.Match(seg, "\"gold\"\\s*:\\s*(-?\\d+)");
                        if (m5.Success) w.gold = int.Parse(m5.Groups[1].Value, ci);
                        var m6 = System.Text.RegularExpressions.Regex.Match(seg, "\"hp\"\\s*:\\s*(-?[\\d.eE+-]+)");
                        if (m6.Success) w.hp = float.Parse(m6.Groups[1].Value, ci);
                        var m7 = System.Text.RegularExpressions.Regex.Match(seg, "\"disp\"\\s*:\\s*\"([^\"]*)\"");
                        if (m7.Success) w.disp = m7.Groups[1].Value;
                        w.elite = seg.IndexOf("\"elite\": true", System.StringComparison.Ordinal) >= 0 ||
                                  seg.IndexOf("\"elite\":true", System.StringComparison.Ordinal) >= 0;
                        list.Add(w);
                        start = -1;
                    }
                }
            }
            return list.Count == 0 ? null : list.ToArray();
        }

        // Slots that refused progress (deny-loop, stuck harvest/choice state)
        // are parked here until their timestamp expires — keeps SpendGold from
        // glueing to one dead interactor while others are affordable.
        private static readonly Dictionary<BuildingInteractor, float> buildIgnore =
            new Dictionary<BuildingInteractor, float>();

        public static void IgnoreBuild(BuildingInteractor bi, float seconds)
        {
            if (bi != null) buildIgnore[bi] = Time.unscaledTime + seconds;
        }

        /// <summary>
        /// Optional node scorer for the campaign map. Higher wins; distance
        /// breaks ties. When null the default is unbeaten-first then nearest
        /// playable (the campaign advance). The bot installs a scorer that
        /// penalises repeatedly-defeated scenes and already-played ones so it
        /// tours the map instead of grinding one node.
        /// </summary>
        public static System.Func<LevelInteractor, bool, float> LevelScore;

        /// <summary>Coins the bot gave up on (unreachable / behind walls).</summary>
        public static System.Func<Coin, bool> CoinSkip;

        /// <param name="preferBuildKey">Held-hold stickiness: an interactor
        /// whose InstanceID matches keeps its pick even if another slot scores
        /// higher — flip-flopping the pick mid-hold refunds every paid coin
        /// (CostDisplay.CancelFill respawns them).</param>
        public static Snapshot Last;               // newest capture (overlay)
        public static bool LastValid;

        public static Snapshot Capture(int preferBuildKey = -1)
        {
            var s = new Snapshot { GameState = "unknown" };
            s.SceneName = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;
            LoadSlotPack(s.SceneName);

            var gs = LocalGamestate.Instance;
            if (gs == null) { s.GameState = "no-gamestate"; return s; }
            s.GameState = gs.CurrentState.ToString();
            if (gs.CurrentState != LocalGamestate.State.InMatch) return s;

            var pm = PlayerMovement.instance;
            if (pm == null) { s.GameState = "no-hero"; return s; }
            s.HeroPos = pm.transform.position;
            if (pm.Hp != null) s.HeroHpPct = pm.Hp.HpPercentage;
            s.HeroDead = pm.Dead;

            var pi = PlayerInteraction.instance;
            if (pi != null)
            {
                s.Balance = pi.Balance;
                s.CoreBalance = pi.EnergyCoreBalance;
            }

            var day = DayNightCycle.Instance;
            if (day != null)
            {
                s.IsNight = day.CurrentTimestate == DayNightCycle.Timestate.Night;
                s.DayTimeLeft = day.RemainingAutoDayTime;
            }

            var tm = TagManager.instance;
            if (tm == null) { s.GameState = "no-tagmanager"; return s; }

            // Home anchor for hold/return behaviour. CastleCenter.instance is
            // authoritative; CastleCenterPosition is a plain static set in
            // Start so it survives component-disabled weirdness; the ETag
            // scan is the last resort (the tag isn't on every level's keep).
            var cc = CastleCenter.instance;
            Vector3 castlePos = cc != null ? cc.transform.position : CastleCenter.CastleCenterPosition;
            if (cc == null && castlePos == Vector3.zero)
            {
                tm.FindAllTaggedObjectsWithTag(castleBuf, TagManager.ETag.CastleCenter);
                if (castleBuf.Count > 0 && castleBuf[0] != null)
                    castlePos = castleBuf[0].transform.position;
            }
            if (castlePos != Vector3.zero)
            {
                s.HasCastle = true;
                s.CastlePos = castlePos;
                s.CastleDist = FlatDist(s.CastlePos, s.HeroPos);
                var csp = BestStand(FindSlot(castlePos), s.HeroPos);
                s.HasCastleStand = csp != Vector3.zero;
                if (s.HasCastleStand) s.CastleStandPos = csp;

                // P5: castle HP — the run's actual loss meter. Hp can sit on
                // the keep's TaggedObject or the BuildSlot's building parent.
                s.CastleHpPct = -1f;
                if (cc != null)
                {
                    var cto = cc.GetComponentInParent<TaggedObject>();
                    var chp = cto != null ? cto.Hp : cc.GetComponentInParent<Hp>(true);
                    if (chp == null) chp = cc.GetComponentInChildren<Hp>(true);
                    if (chp != null) s.CastleHpPct = chp.HpPercentage;
                    if (!castleHpLogged)
                    {
                        castleHpLogged = true;
                        Plugin.Log?.LogWarning(chp != null
                            ? $"[bot] castle-hp: found on '{chp.gameObject.name}' " +
                              $"hp={chp.HpValue}/{chp.maxHp} pct={chp.HpPercentage:0.###} alive={chp.Alive}"
                            : $"[bot] castle-hp: no Hp on CastleCenter chain " +
                              $"(up={cc.GetComponentsInParent<Hp>(true).Length} " +
                              $"down={cc.GetComponentsInChildren<Hp>(true).Length})");
                    }
                }
            }

            // P4: unactivated shrines — interactables worth a daytime visit
            // (income buffs). 1 Hz scan; they're static map objects.
            if (Time.unscaledTime >= shrineScanAt)
            {
                shrineScanAt = Time.unscaledTime + 1f;
                shrineCache = Object.FindObjectsOfType<Shrine>(true);
            }
            if (shrineCache != null)
            {
                s.ShrineCount = 0;
                s.ShrineDist = float.MaxValue;
                foreach (var sh in shrineCache)
                {
                    if (sh == null || sh.ShrineHasBeenActivated) continue;
                    s.ShrineCount++;
                    float d = (sh.transform.position - s.HeroPos).sqrMagnitude;
                    if (d < s.ShrineDist)
                    {
                        s.ShrineDist = d;
                        s.ShrinePos = sh.transform.position;
                    }
                }
                if (s.ShrineCount == 0) s.ShrineDist = 0f;
                else s.ShrineDist = Mathf.Sqrt(s.ShrineDist);
            }

            var spawner = EnemySpawner.instance;
            if (spawner != null)
            {
                s.Wave = spawner.Wavenumber;
                s.WaveTotal = spawner.WaveCount;
                s.EnemyCount = spawner.NumberOfEnemiesOnTheMap;

                // P1: next-wave intel — same WaveInfo the game shows players.
                var wi = EnemySpawner.GetWaveInfoForNextWave();
                if (wi != null && wi.enemies != null)
                {
                    s.NextWaveGold = wi.goldReward;
                    foreach (var en in wi.enemies)
                    {
                        if (en == null) continue;
                        s.NextWaveCount += en.enemyCount;
                        if (en.eliteEnemy) s.NextWaveElites += en.enemyCount;
                        if (en.maxHP > s.NextWaveMaxHp) s.NextWaveMaxHp = en.maxHP;
                        if (en.speed > s.NextWaveSpeed) s.NextWaveSpeed = en.speed;
                        if (en.range > s.NextWaveFoeRange) s.NextWaveFoeRange = en.range;
                    }
                }
                // P5: wave framing — final wave vs the one before it.
                int w = spawner.Wavenumber;
                s.FinalWaveNext = spawner.FinalWaveComingUp(w) || w >= spawner.WaveCount - 1;
                s.WaveBeforeFinalNext = spawner.WaveBeforeFinalWaveComingUp(w);
            }
            else
            {
                s.EnemyCount = tm.EnemyUnits.Count;
            }

            // Doors first — on a scene-change capture the enemy loop below
            // once ran before BuildDoors and produced one tick of zero foe
            // counts, which read as "safe corridor" for a full decision.
            if (s.DoorAnchors == null) BuildDoors(ref s);
            // Nearest live enemy to the hero AND nearest to the castle — the
            // castle-proximate one is what actually loses the run, so it wins
            // target priority for legit defense play.
            if (sceneDoorAnchors != null && doorFoes != null)
                for (int d = 0; d < doorFoes.Length; d++) doorFoes[d] = 0;
            s.NearestEnemyDist = float.MaxValue;
            float castleThreatSq = float.MaxValue;
            Vector3 enemySum = Vector3.zero;
            int enemyN = 0;
            int foesNear = 0;
            foreach (var e in tm.EnemyUnits)
            {
                if (e == null) continue;
                Vector3 ep = e.transform.position;
                float d = (ep - s.HeroPos).sqrMagnitude;
                if (d < s.NearestEnemyDist)
                {
                    s.NearestEnemyDist = d;
                    s.NearestEnemy = e;
                }
                if (d < 64f) foesNear++;          // <8 m of the hero
                if (s.HasCastle)
                {
                    float dc = (ep - s.CastlePos).sqrMagnitude;
                    if (dc < castleThreatSq) { castleThreatSq = dc; s.CastleThreat = e; }
                }
                if (sceneDoorAnchors != null && doorFoes != null)
                    for (int dd = 0; dd < sceneDoorAnchors.Length && dd < doorFoes.Length; dd++)
                    {
                        float fx = sceneDoorAnchors[dd].x - ep.x, fz = sceneDoorAnchors[dd].z - ep.z;
                        if (fx * fx + fz * fz < 900f) { doorFoes[dd]++; break; }   // <30 m of the anchor
                    }
                enemySum += ep; enemyN++;
            }
            s.EnemiesNearHero = foesNear;
            if (s.NearestEnemy != null)
            {
                s.NearestEnemyPos = s.NearestEnemy.transform.position;
                s.NearestEnemyDist = Mathf.Sqrt(s.NearestEnemyDist);
            }
            else s.NearestEnemyDist = 0f;
            if (s.CastleThreat != null)
                s.CastleThreatDist = Mathf.Sqrt(castleThreatSq);
            else { s.CastleThreatDist = 0f; s.CastleThreat = s.NearestEnemy; }

            // P3: live-threat metadata — the foe we're about to fight decides
            // the kite distance, so read its own attack range + hp + elite.
            if (s.NearestEnemy != null)
            {
                var fhp = s.NearestEnemy.GetComponentInChildren<Hp>(true);
                if (fhp == null) fhp = s.NearestEnemy.GetComponentInParent<Hp>();
                if (fhp != null) { s.NearEnemyHp = fhp.HpValue; s.NearEnemyElite = fhp.Elite; }
                var aa = s.NearestEnemy.GetComponentInChildren<AutoAttack>(true);
                if (aa == null) aa = s.NearestEnemy.GetComponentInParent<AutoAttack>();
                if (aa != null)
                    foreach (var p in aa.targetPriorities)
                        if (p != null && p.range > s.NearEnemyRange) s.NearEnemyRange = p.range;
            }

            // Squad doors: cached corridor anchors — built BEFORE the unit
            // scan so manned/free accounting works this capture.
            if (s.DoorAnchors == null) BuildDoors(ref s);
            if (s.DoorAnchors != null)
            {
                for (int d = 0; d < doorUnit.Length; d++) doorUnit[d] = 0;
                s.DoorsCovered = 0; s.FreeUnits = 0;
                s.UncoveredDoorPos = Vector3.zero; s.UncoveredDoorLine = null;
            }

            // Allied army (troop buildings / heroes). Used to anchor the hero
            // behind the meatshield line for legit defense.
            if (tm.PlayerUnits != null)
            {
                Vector3 allySum = Vector3.zero;
                foreach (var u in tm.PlayerUnits)
                {
                    if (u == null || u.Hp == null || !u.Hp.Alive) continue;
                    allySum += u.transform.position; s.AllyCount++;
                    // Squad accounting: a unit is "manned" when it stands
                    // within 25 m of a door anchor — units still WALKING the
                    // corridor count so a door isn't re-posted while its
                    // squad is en route. Everything else is free.
                    bool nearDoor = false;
                    var pu = u.GetComponent<PathfindMovementPlayerunit>();
                    if (s.DoorAnchors != null)
                    {
                        for (int d = 0; d < s.DoorAnchors.Length; d++)
                        {
                            float dx = s.DoorAnchors[d].x - u.transform.position.x;
                            float dz = s.DoorAnchors[d].z - u.transform.position.z;
                            // Escorts walking past a corridor must NOT count
                            // as manning it — only a unit ordered to HOLD or
                            // stand its home post counts toward coverage.
                            bool manned = pu != null && !pu.FollowingPlayer &&
                                (pu.HoldPosition ||
                                (pu.HomePosition - s.DoorAnchors[d]).sqrMagnitude < 64f);
                            if (dx * dx + dz * dz < 625f && manned) { nearDoor = true; if (doorUnit != null && d < doorUnit.Length) doorUnit[d]++; break; }
                        }
                    }
                    // Escorts are NOT free — PlaceSquad skips FollowingPlayer
                    // units, so counting them as "free" made the brain think
                    // it had a squad to post while every unit was on escort.
                    bool escortU = pu != null && pu.FollowingPlayer;
                    if (escortU) { s.EscortUnits++; }
                    else if (!nearDoor) s.FreeUnits++;
                }
                if (s.AllyCount > 0) s.AllyCentroid = allySum / s.AllyCount;
            }
            // Door coverage summary for the strategy layer. Each door's
            // target squad size rises after a breach on that corridor —
            // the perimeter "learns" which doors leak. Uncovered-door pick
            // runs two passes: corridors with live foes on them first (hot),
            // then the rest by distance-to-castle (the most dangerous leak).
            if (s.DoorAnchors != null)
            {
                string pk = PKey(ref s);
                s.PolicyKey = pk;
                s.DoorCount = s.DoorAnchors.Length;
                s.DoorsCovered = 0;
                s.UncoveredDoorPos = Vector3.zero; s.UncoveredDoorLine = null;
                s.UncoveredDoorHot = false;
                float leakD = float.MaxValue;
                for (int hot = 1; hot >= 0; hot--)
                {
                    for (int d = 0; d < s.DoorAnchors.Length; d++)
                    {
                        if (doorUnit[d] >= DoorTarget(d, pk)) { if (hot == 1) s.DoorsCovered++; continue; }
                        // Claimed + walking — skip re-posting for 25 s.
                        if (doorClaim != null && d < doorClaim.Length &&
                            UnityEngine.Time.unscaledTime - doorClaim[d] < 25f)
                        {
                            if (hot == 1) s.DoorsCovered++;   // en route counts
                            continue;
                        }
                        if ((doorFoes != null && doorFoes[d] > 0) != (hot == 1)) continue;
                        float dc = FlatDist(s.DoorAnchors[d], s.CastlePos);
                        if (hot == 1 || dc < leakD)
                        {
                            if (hot == 0) leakD = dc;
                            s.UncoveredDoorPos = s.DoorAnchors[d];
                            s.UncoveredDoorLine = d < s.DoorLines.Length ? s.DoorLines[d] : "";
                            s.UncoveredDoorTarget = DoorTarget(d, pk);
                            s.UncoveredDoorHot = hot == 1;
                            if (hot == 1) break;   // first hot door wins
                        }
                    }
                }
                s.HasUncoveredDoor = s.UncoveredDoorPos != Vector3.zero;
                // Army target: squad-size per door (breach doubles), at least
                // 16, plus headroom for the incoming wave — production runs
                // until met.
                int at = 16;
                if (s.DoorAnchors != null)
                {
                    int doorNeed = 0;
                    for (int d = 0; d < s.DoorAnchors.Length; d++) doorNeed += DoorTarget(d, pk);
                    at = Mathf.Min(Mathf.Max(doorNeed, 16), 60);
                }
                if (s.NextWaveCount > 0) at = Mathf.Max(at, (int)(s.NextWaveCount * 1.2f));
                if (Strat.ArmyTarget > at) at = Strat.ArmyTarget;          // M3 playbook floor
                if (Coach.ArmyTargetFloor > 0) at = Coach.ArmyTargetFloor; // live advisor SET (floor semantics broke "reduce army" orders)
                s.ArmyTarget = at;
            }
            // Coach posture: "fighter" widens the hero's self-defense bubble.
            s.SelfDefendRange = Coach.HeroPosture == "fighter" ? 12f : 7f;
            // Learned night-call timing — the Q-table tunes how long the day
            // build phase runs before the horn (150/240/330 s budgets).
            {
                string pk0 = PKey(ref s);
                var nb = Policy.Eval("night",
                    new[] { "150", "240", "330" }, pk0);
                s.DayBudget = float.TryParse(nb, out float v) ? v : 240f;
            }

            // RED ALERT: an enemy is PAST its own corridor's door post —
            // closer to the castle than the squad anchor on its line — or
            // deep inside the building ring. (The funded building sprawl makes
            // a raw radius useless: spawners pop "inside" it instantly.)
            if (s.CastleThreat != null && s.HasCastle)
            {
                float pr = ProtectedRadius(ref s);
                s.RedAlertRadius = pr;
                float lineDoor = float.MaxValue;
                var tp = s.CastleThreat.transform.position;
                if (s.DoorAnchors != null)
                {
                    for (int d = 0; d < s.DoorAnchors.Length; d++)
                    {
                        float dx = s.DoorAnchors[d].x - tp.x, dz = s.DoorAnchors[d].z - tp.z;
                        if (dx * dx + dz * dz < 1600f)   // threat on this door's corridor
                        {
                            float dd = FlatDist(s.DoorAnchors[d], s.CastlePos);
                            if (dd < lineDoor) lineDoor = dd;
                        }
                    }
                }
                bool pastDoor = lineDoor < float.MaxValue &&
                    s.CastleThreatDist < lineDoor - 6f;
                bool deepInside = s.CastleThreatDist < Mathf.Min(pr, 30f);
                if (pastDoor || deepInside)
                {
                    s.RedAlert = true;
                    if (s.DoorAnchors != null)
                    {
                        // mark the breach source: door nearest the threat
                        float bd = float.MaxValue; int bi = -1;
                        for (int d = 0; d < s.DoorAnchors.Length; d++)
                        {
                            float dx = s.DoorAnchors[d].x - tp.x, dz = s.DoorAnchors[d].z - tp.z;
                            float dd = dx * dx + dz * dz;
                            if (dd < bd) { bd = dd; bi = d; }
                        }
                        if (bi >= 0 && !doorBreach[bi])
                        {
                            doorBreach[bi] = true;
                            BreachCount++;
                            Policy.Pulse(-0.4f);   // RL: breaches cost
                            Plugin.Log?.LogWarning($"[bot] BREACH on door '{s.DoorLines[bi]}' — squad target raised");
                        }
                    }
                }
            }
            else s.RedAlert = false;

            // Nearest unclaimed coin. freeCoins is maintained by TagManager via
            // Coin.OnEnable/OnDestroy, so it should always be accurate.
            s.NearestCoinDist = float.MaxValue;
            int n = tm.freeCoins.Count;
            for (int i = 0; i < n; i++)
            {
                Coin c = tm.freeCoins[i];
                if (c == null || !c.IsFree) continue;
                s.CoinCount++;
                if (CoinSkip != null && CoinSkip(c)) continue;
                float d = (c.transform.position - s.HeroPos).sqrMagnitude;
                if (d < s.NearestCoinDist)
                {
                    s.NearestCoinDist = d;
                    s.NearestCoin = c;
                }
            }
            if (s.NearestCoin != null)
            {
                s.NearestCoinPos = s.NearestCoin.transform.position;
                s.NearestCoinDist = Mathf.Sqrt(s.NearestCoinDist);
            }
            else s.NearestCoinDist = 0f;

            // Level-select map: nearest playable level node so the bot can walk
            // up and enter a match on its own. Scan is 1 Hz — FindObjectsOfType
            // is too heavy for the 4 Hz tick and the map is static anyway.
            // Scan runs unconditionally: if any playable node exists we can enter
            // a level even when the manager singleton isn't present (diagnostic
            // safety net for unknown map scene names).
            s.OnLevelSelect = LevelSelectManager.instance != null;
            if (Time.unscaledTime >= levelScanAt)
            {
                levelScanAt = Time.unscaledTime + 1f;
                levelCache = Object.FindObjectsOfType<LevelInteractor>(false);
                s.InteractorCount = Object.FindObjectsOfType<InteractorBase>(true).Length;
            }
            if (levelCache != null)
            {
                // Score every playable node: unbeaten-first by default, the
                // bot's LevelScore hook applies defeat/rotation penalties.
                // Highest score wins, nearest position breaks ties.
                float bestScore = float.NegativeInfinity, bestD = float.MaxValue;
                var lpm = LevelProgressManager.instance;
                foreach (var li in levelCache)
                {
                    if (li == null || !li.isActiveAndEnabled || !li.CanBePlayed) continue;
                    s.LevelCount++;
                    bool beaten = lpm != null && li.levelInfo != null &&
                                  lpm.GetLevelDataForScene(li.levelInfo.sceneName).beatenBest;
                    float sc = LevelScore != null
                        ? LevelScore(li, beaten)
                        : (beaten ? 0f : 1f);
                    float d = (li.PlayerTeleportPosition - s.HeroPos).sqrMagnitude;
                    if (sc > bestScore || (sc == bestScore && d < bestD))
                    {
                        bestScore = sc; bestD = d; s.NearestLevel = li;
                    }
                }
                if (s.NearestLevel != null)
                {
                    s.NearestLevelPos = s.NearestLevel.PlayerTeleportPosition;
                    s.NearestLevelDist = FlatDist(s.NearestLevelPos, s.HeroPos);
                }
                else s.NearestLevelDist = 0f;
            }

            // Nighthorn singleton: day-phase interactable that auto-harvests all
            // buildings/free coins on first interact, then starts the night wave.
            // instance is set in Awake and goes stale when deactivated at dusk —
            // the isActiveAndEnabled check covers both cases.
            var horn = Nighthorn.instance;
            // Fallback: singleton goes stale on some scenes — find the horn
            // interactable directly (there's at most one per level).
            if (horn == null)
            {
                try
                {
                    var horns = UnityEngine.Object.FindObjectsOfType<Nighthorn>();
                    if (horns != null && horns.Length > 0) horn = horns[0];
                }
                catch { }
            }
            if (horn != null && horn.isActiveAndEnabled)
            {
                s.HasHorn = true;
                s.Horn = horn;
                s.HornPos = horn.transform.position;
                s.HornDist = FlatDist(s.HornPos, s.HeroPos);
            }
            // Second fallback: horns expose themselves as a BuildingInteractor
            // too — look for a non-building interactor near the castle whose
            // name smells like the horn.
            // Scan even when a disabled Nighthorn exists — an inactive
            // singleton found by FindObjectsOfType blocks the scan forever
            // otherwise (was the day-never-ends root cause).
            if (!s.HasHorn &&
                UnityEngine.Time.unscaledTime - hornScanAt > 15f)
            {
                hornScanAt = UnityEngine.Time.unscaledTime;
                try
                {
                    // InteractorBase is the real interactable supertype —
                    // BuildingInteractor never matched (0 hits) because the
                    // horn/buildings ride on InteractorBase subclasses.
                    var scan = UnityEngine.Object.FindObjectsOfType<InteractorBase>(true);
                    // Dump once per scene — the campaign map has none of the
                    // level's interactables, so a single global dump misses
                    // the horn entirely.
                    bool firstDump = hornDumpScene != (s.SceneName ?? "");
                    hornDumpScene = s.SceneName ?? "";
                    if (firstDump)
                        Plugin.Log?.LogInfo(
                            $"[bot] horn scan '{s.SceneName}': {scan?.Length ?? -1} interactors");
                    foreach (var bi in scan)
                    {
                        if (bi == null || !bi.isActiveAndEnabled) continue;
                        var nm = bi.name ?? "";
                        // The horn is a BuildingInteractor like every slot —
                        // only its targetBuilding distinguishes it.
                        string bn = "";
                        try
                        {
                            const System.Reflection.BindingFlags BF =
                                System.Reflection.BindingFlags.Instance |
                                System.Reflection.BindingFlags.Public |
                                System.Reflection.BindingFlags.NonPublic;
                            var t = bi.GetType();
                            object tb = t.GetField("targetBuilding", BF)?.GetValue(bi)
                                     ?? t.GetProperty("targetBuilding", BF)?.GetValue(bi)
                                     ?? t.GetField("building", BF)?.GetValue(bi)
                                     ?? t.GetProperty("building", BF)?.GetValue(bi);
                            bn = tb is UnityEngine.Component c ? (c.name ?? c.GetType().Name)
                               : tb != null ? tb.GetType().Name : "";
                        }
                        catch { }
                        if (firstDump && bn != "")
                            Plugin.Log?.LogInfo(
                                $"[bot] interactor: '{bi.GetType().Name}/{nm}' b='{bn}' at {bi.transform.position}");
                        if (nm.IndexOf("horn", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("night", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            bn.IndexOf("horn", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            bn.IndexOf("night", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            bn.IndexOf("bell", System.StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            Plugin.Log?.LogInfo($"[bot] horn found via interactor '{nm}'");
                            s.HasHorn = true;
                            s.HornPos = bi.transform.position;
                            s.HornDist = FlatDist(s.HornPos, s.HeroPos);
                            HornBi = bi;
                            break;
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    Plugin.Log?.LogWarning($"[bot] horn scan failed: {ex.Message}");
                }
            }
            if (HornBi != null && !s.HasHorn && HornBi.isActiveAndEnabled)
            {
                s.HasHorn = true;
                s.HornPos = HornBi.transform.position;
                s.HornDist = FlatDist(s.HornPos, s.HeroPos);
            }

            // Defensive anchor: where the hero+army should stand to meet the
            // threat. Night → centroid of live enemies. Day → centroid of the
            // NEXT wave's spawn lines (the game shows players the same markers).
            // Anchor = castle pulled ~9 m toward that centroid so the hero
            // holds on the threat axis instead of beside the keep's door.
            Vector3 threatSum = Vector3.zero;
            int threatN = 0;
            if (s.IsNight && enemyN > 0)
            {
                threatSum = enemySum; threatN = enemyN;
            }
            else if (!s.IsNight && spawner != null && s.Wave >= 0 && s.Wave < spawner.waves.Count)
            {
                var wv = spawner.waves[s.Wave];
                if (wv != null && wv.spawns != null)
                {
                    foreach (var sp in wv.spawns)
                    {
                        if (sp == null) continue;
                        if (sp.spawnLine != null && sp.spawnLine.childCount > 0)
                        {
                            for (int i = 0; i < sp.spawnLine.childCount; i++)
                            { threatSum += sp.spawnLine.GetChild(i).position; threatN++; }
                        }
                        else if (sp.enemyPrefab != null && sp.enemyPrefab.scene.isLoaded)
                        {
                            threatSum += sp.enemyPrefab.transform.position; threatN++;
                        }
                    }
                }
            }
            if (threatN > 0 && s.HasCastle)
            {
                Vector3 tc = threatSum / threatN;
                Vector3 axis = tc - s.CastlePos; axis.y = 0f;
                if (axis.sqrMagnitude > 0.01f)
                {
                    s.ThreatAnchor = s.CastlePos + axis.normalized * 9f;
                    s.HasThreatAnchor = true;
                }
                // Botpack upgrade: intercept ON the corridor — the route
                // waypoint ~10 m out from the castle that sits on the line
                // the threat is actually walking (not just radial push-out).
                var ip = InterceptAnchor(tc, s.CastlePos);
                if (ip != Vector3.zero)
                {
                    s.ThreatAnchor = ip;
                    s.HasThreatAnchor = true;
                }
            }

            // Night resets the dead-slot park list: dusk forces every
            // interactor's state to None anyway, so parked slots get a fresh
            // retry on the next day rather than expiring mid-day.
            if (s.IsNight && buildIgnore.Count > 0) buildIgnore.Clear();

            // ArmyAnchor: day-time pre-positioning on the incoming wave's
            // corridor (botpack waves -> spawnRoutes -> a waypoint ~12 m out
            // from the castle on that line). PositionArmy parks the banner
            // on the door the next wave actually walks.
            s.ArmyAnchor = NextWaveAnchor(s.Wave, s.CastlePos);
            s.HasArmyAnchor = s.ArmyAnchor != Vector3.zero;
            s.ArmyAnchorLine = armyAnchorLine;

            // Day economy: TagManager maintains playerBuildingInteractors (each
            // slot registers/unregisters itself). CanBeInteractedWith is true
            // only while the slot has work — a build/upgrade to pay for or a
            // harvest payout waiting — so the list needs no further filtering.
            // Day economy: TagManager maintains playerBuildingInteractors (each
            // slot registers/unregisters itself). CanBeInteractedWith is true
            // only while the slot has work — a build/upgrade to pay for or a
            // harvest payout waiting. Each candidate is scored so legit play
            // buys what actually wins nights: harvest first (free income),
            // military production, economy, then everything else. Core-cost
            // upgrades the hero can never pay are filtered here instead of
            // eating a 7 s stall-watch park.
            s.NearestBuildDist = float.MaxValue;
            int bestBuildScore = int.MinValue;
            var builds = tm.playerBuildingInteractors;
            for (int i = 0; i < builds.Count; i++)
            {
                var bi = builds[i];
                if (bi == null || !bi.isActiveAndEnabled) continue;
                // Held-hold stickiness must outrank the interactable filter:
                // mid-choice slots report CanBeInteractedWith=false while the
                // unit pick resolves — skipping them here releases the hold
                // and refunds the partial fill (observed: Archery Range →
                // waitChoice → brain re-picked Barracks → refund → never
                // completes). Keep the held slot selected until done.
                bool heldMatch0 = preferBuildKey >= 0 &&
                                  bi.GetInstanceID() == preferBuildKey;
                if (heldMatch0)
                {
                    float hd0 = (bi.transform.position - s.HeroPos).sqrMagnitude;
                    if (hd0 <= 6f * 6f && !IsInteractorComplete(bi))
                    {
                        s.NearestBuildDist = hd0;
                        s.NearestBuild = bi;
                        s.NearestBuildScore = 100000;
                        bestBuildScore = int.MaxValue;
                        continue;
                    }
                }
                if (!bi.CanBeInteractedWith) continue;
                // "Complete" or choice-wedged interactors still report
                // CanBeInteractedWith — their InteractionHold early-returns
                // forever (diag: state=Upgrade complete=True on the Castle
                // Center). Skip them in the scan instead of stalling on them.
                if (IsInteractorFinished(bi)) continue;
                if (buildIgnore.Count > 0 && buildIgnore.TryGetValue(bi, out float until))
                {
                    if (until > Time.unscaledTime) continue;   // still parked
                    buildIgnore.Remove(bi);                    // expired -> retry
                }
                // Episodic memory: this slot failed before — never retry.
                if (Memory.IsParked(s.SceneName ?? "", bi.transform.position))
                    continue;
                var bs = bi.targetBuilding;
                if (bs != null)
                {
                    if (bs.NextUpgradeOrBuildEnergyCoreCost > 0 && s.CoreBalance <= 0)
                        continue;                              // can never pay — skip outright
                    if (!bi.canBeHarvested && s.Balance <= 0 &&
                        (bs.NextUpgradeOrBuildCost > 0 || bs.NextUpgradeOrBuildEnergyCoreCost > 0))
                        continue;                              // broke and nothing to harvest
                }
                int score = 10;
                if (bi.canBeHarvested) score += 1000;
                if (bs != null)
                {
                    GetBuildClass(bs, out int military, out int incomeDelta);
                    // Defense-first: while the perimeter is uncovered or red
                    // alert is active, military slots dominate the pick —
                    // walls/towers/barracks before income houses. But when
                    // the wallet is empty, income IS the defense — the next
                    // military purchase needs funding first.
                    bool broke = s.Balance < 10;
                    // Army shortage is the TOP build driver: more troop
                    // production before anything else — the war machine is
                    // what covers the doors. Broke still funds first.
                    bool armyShort = s.ArmyTarget > 0 && s.AllyCount < s.ArmyTarget;
                    bool defenseFirst = !broke && (s.RedAlert || s.DoorsCovered < s.DoorCount);
                    score += military * (armyShort ? 600 : defenseFirst ? 400 : 100 + Mathf.Min(s.NextWaveCount * 15, 300));
                    // Coach/playbook/RL focus bias on top of the situation bias.
                    string focus = !string.IsNullOrEmpty(Coach.BuildFocus) ? Coach.BuildFocus
                        : (!string.IsNullOrEmpty(Strat.Focus) ? Strat.Focus
                        : Policy.Eval("build_focus",
                            new[] { "military", "income", "defense", "balanced" },
                            s.PolicyKey ?? ""));
                    s.PolicyFocus = focus;
                    if (focus == "military") score += military * 200;
                    else if (focus == "income" && incomeDelta > 0) score += incomeDelta * 60;
                    else if (focus == "defense") score += military * 120;
                    if (broke && incomeDelta > 0) score += Mathf.Min(incomeDelta, 15) * 40;
                    if (military > 0 && (s.FinalWaveNext || s.NextWaveCount >= 30))
                        score += military * 100;
                    if (incomeDelta > 0) score += 30 + Mathf.Min(incomeDelta, 10) * 3;
                    // PLAYBOOK ORDER: the M3 plan's literal build sequence —
                    // the next unsatisfied category gets a heavy bonus so
                    // walls/gates/barracks go up in the playbook's order,
                    // not whenever scoring happens to favor them.
                    var open = OpenBuildOrder();
                    if (open.Length > 0)
                    {
                        string scat = BuildCat(bs.buildingName);
                        int oi = System.Array.IndexOf(open, scat);
                        if (oi >= 0)
                            // The playbook IS the default policy: open[0]
                            // outbids even a harvest; open[1..2] still beat
                            // any non-plan pick (tower spam at +600 used to
                            // swallow the plan's wall→gate→military order).
                            score += broke ? 0 : (oi == 0 ? 1200 : 600 - oi * 150);
                    }
                }
                s.BuildCount++;
                float d = (bi.transform.position - s.HeroPos).sqrMagnitude;
                // Efficiency: closer work wins ties AND beats slightly better
                // far work — walking 60 m to a marginally-better slot is how
                // the bot used to spend the whole day traveling.
                score += Mathf.Max(0, 40 - (int)Mathf.Sqrt(d)) * 3;
                // Held-hold stickiness: the slot we're mid-pay on wins
                // outright while it's still interactable and near — prevents
                // per-tick pick flips that refund the partial fill.
                bool heldMatch = preferBuildKey >= 0 && bi.GetInstanceID() == preferBuildKey;
                if (heldMatch && d <= 6f * 6f)
                {
                    s.NearestBuildDist = d;
                    s.NearestBuild = bi;
                    s.NearestBuildScore = score + 100000;
                    bestBuildScore = int.MaxValue;   // no later pick can beat it
                    continue;
                }
                if (score > bestBuildScore || (score == bestBuildScore && d < s.NearestBuildDist))
                {
                    bestBuildScore = score;
                    s.NearestBuildDist = d;
                    s.NearestBuild = bi;
                    s.NearestBuildScore = score;
                }
            }
            if (s.NearestBuild != null)
            {
                s.NearestBuildPos = s.NearestBuild.transform.position;
                s.NearestBuildDist = Mathf.Sqrt(s.NearestBuildDist);
                s.NearestBuildKey = s.NearestBuild.GetInstanceID();
                s.NearestBuildHarvest = s.NearestBuild.canBeHarvested;
                s.NearestBuildName = s.NearestBuild.targetBuilding != null
                    ? s.NearestBuild.targetBuilding.buildingName : s.NearestBuild.name;
                if (s.NearestBuild.targetBuilding != null)
                    GetBuildClass(s.NearestBuild.targetBuilding, out s.BuildMil, out s.BuildInc);
                // Terrain pack: known-reachable stand cell for this slot —
                // navigating to a stand-point can't wedge inside the slot's
                // collider (the spend-stall bug's travel side). Cells whose
                // nav path resolves to the WRONG LAYER (wall-top navmesh
                // snap — the whole east-perimeter ring showed this) get
                // discarded: the brain then falls back to the hero-side
                // standoff approach instead of aiming at an unreachable
                // precomputed cell.
                var sl = FindSlot(s.NearestBuildPos);
                var bsp = sl != null && badStands.Contains(PosKey(s.NearestBuildPos))
                    ? Vector3.zero
                    : BestStand(sl, s.HeroPos);
                s.HasBuildStand = bsp != Vector3.zero;
                if (s.HasBuildStand)
                {
                    s.BuildStandPos = bsp;
                    s.BuildStandDist = FlatDist(s.BuildStandPos, s.HeroPos);
                }
            }
            else s.NearestBuildDist = 0f;

            // v3 seam fields: singleton presence + busy + weapon state (P6).
            s.CanCommand = CommandUnits.instance != null;
            s.CanSwitch = DayNightCycle.Instance != null;
            var stm = SceneTransitionManager.instance;
            s.SceneBusy = stm != null && SceneTransitionBusy(stm);
            // Active weapon (P6): same discovery chain as PumpAttack —
            // WeaponEquipper on the hero root, else a ManualAttack tagged
            // Player. 1 Hz re-scan so a weapon switch gets noticed.
            if (Time.unscaledTime >= weScanAt)
            {
                weScanAt = Time.unscaledTime + 1f;
                var weTag = pm.GetComponentInParent<TaggedObject>();
                ManualAttack w = null;
                var weq = weTag != null
                    ? weTag.GetComponentInChildren<WeaponEquipper>(true) : null;
                if (weq != null)
                    w = weq.activeWeapon != null ? weq.activeWeapon : weq.passiveWeapon;
                if (w == null && weTag != null)
                    w = weTag.GetComponentInChildren<ManualAttack>(true);
                if (w == null)
                {
                    foreach (var ma in Object.FindObjectsOfType<ManualAttack>(true))
                    {
                        var mt = ma.GetComponentInParent<TaggedObject>();
                        if (mt != null && mt.Contains(TagManager.ETag.Player)) { w = ma; break; }
                    }
                }
                maCache = w;
            }
            if (maCache != null)
            {
                var w = maCache;
                s.HasWeapon = true;
                s.ActiveRange = 0f;
                foreach (var p in w.targetPriorities)
                    if (p != null && p.range > s.ActiveRange) s.ActiveRange = p.range;
                s.ActiveFiresMoving = w.GetComponent<DelayManualAttackWhileMoving>() == null;
            }

            s.Valid = true;
            return s;
        }

        // SceneTransitionManager keeps its busy flag private — FieldInfo trick.
        private static readonly System.Reflection.FieldInfo StmRunningField =
            typeof(SceneTransitionManager).GetField("sceneTransitionIsRunning",
                System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);

        public static bool SceneTransitionBusy(SceneTransitionManager stm) =>
            StmRunningField != null && (bool)StmRunningField.GetValue(stm);

        // Classification cache: what a slot's NEXT upgrade yields — military
        // weight (towers/unit spawners in objectsToActivate) and income delta.
        // Static per slot so it's computed once; scene change makes stale
        // entries unreachable anyway (interactors are per-scene objects).
        private class BuildClass { public int mil, inc; }
        private static readonly Dictionary<BuildSlot, BuildClass> buildClassCache =
            new Dictionary<BuildSlot, BuildClass>();
        private static string lastClassScene = "";

        private static void GetBuildClass(BuildSlot bs, out int military, out int income)
        {
            military = 0; income = 0;
            if (bs == null) return;
            if (lastClassScene != UnityEngine.SceneManagement.SceneManager.GetActiveScene().name)
            {
                lastClassScene = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;
                buildClassCache.Clear();
            }
            if (buildClassCache.TryGetValue(bs, out BuildClass cached))
            {
                military = cached.mil; income = cached.inc; return;
            }
            var cls = new BuildClass();
            var ups = bs.Upgrades;
            if (ups != null && bs.Level >= 0 && bs.Level < ups.Count)
            {
                var next = ups[bs.Level];
                if (next != null && next.upgradeBranches != null)
                {
                    foreach (var br in next.upgradeBranches)
                    {
                        if (br == null) continue;
                        cls.inc += br.goldIncomeChange + br.energyCoreIncomeChange;
                        // Keyword fallback: walls/gates/towers carry no
                        // AutoAttack object, so the component check alone
                        // never flagged defensive upgrades — the bot skipped
                        // every wall it was told to build.
                        string nm = (br.choiceDetails != null ? (br.choiceDetails.name ?? "") : "") + " " + (bs.buildingName ?? "");
                        if (nm.IndexOf("wall", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("gate", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("tower", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("barrack", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("archer", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("ballista", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("militia", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("guard", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("cannon", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("trap", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("spike", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("watchtower", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("outpost", System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nm.IndexOf("defense", System.StringComparison.OrdinalIgnoreCase) >= 0)
                            cls.mil++;
                        if (br.objectsToActivate == null) continue;
                        foreach (var go in br.objectsToActivate)
                        {
                            if (go == null) continue;
                            if (go.GetComponentInChildren<AutoAttack>(true) != null ||
                                go.GetComponentInChildren<UnitRespawnerForBuildings>(true) != null)
                            {
                                cls.mil++;
                                break; // one military object is enough to flag the upgrade
                            }
                        }
                    }
                }
            }
            buildClassCache[bs] = cls;
            military = cls.mil; income = cls.inc;
        }

        /// <summary>Intercept point on the corridor a threat is walking —
        /// the route waypoint ~10 m out from the castle on the line nearest
        /// the threat's current position.</summary>
        private static Vector3 InterceptAnchor(Vector3 threat, Vector3 castle)
        {
            if (spawnRoutes == null || castle == Vector3.zero) return Vector3.zero;
            SpawnRouteRec best = null; float bd = float.MaxValue;
            foreach (var r in spawnRoutes)
            {
                if (r.wp == null || r.wp.Length < 2) continue;
                for (int i = 0; i < r.wp.Length; i++)
                {
                    float dx = r.wp[i][0] - threat.x, dz = r.wp[i][1] - threat.z;
                    float d = dx * dx + dz * dz;
                    if (d < bd) { bd = d; best = r; }
                }
            }
            if (best == null || bd > 40f * 40f) return Vector3.zero;
            for (int i = best.wp.Length - 1; i >= 0; i--)
            {
                float dx = best.wp[i][0] - castle.x, dz = best.wp[i][1] - castle.z;
                if (dx * dx + dz * dz >= 100f)
                    return new Vector3(best.wp[i][0], castle.y, best.wp[i][1]);
            }
            var last = best.wp[best.wp.Length - 1];
            return new Vector3(last[0], castle.y, last[1]);
        }

        /// <summary>Day-time army anchor: the corridor the NEXT wave spawns
        /// down (wave table -> line -> route), ~12 m out from the castle.</summary>
        private static Vector3 NextWaveAnchor(int currentWave, Vector3 castle)
        {
            armyAnchorLine = null;
            if (wavePack == null || spawnRoutes == null || castle == Vector3.zero)
                return Vector3.zero;
            int next = currentWave + 1;
            WaveRec w = null;
            foreach (var e in wavePack)
                if (e.wave >= next && (w == null || e.wave < w.wave)) w = e;
            if (w == null || string.IsNullOrEmpty(w.line)) return Vector3.zero;
            SpawnRouteRec r = null;
            foreach (var c in spawnRoutes)
                if (c.line == w.line && c.wp != null && c.wp.Length > 0) { r = c; break; }
            if (r == null) return Vector3.zero;
            armyAnchorLine = w.line;
            for (int i = r.wp.Length - 1; i >= 0; i--)
            {
                float dx = r.wp[i][0] - castle.x, dz = r.wp[i][1] - castle.z;
                if (dx * dx + dz * dz >= 144f)
                    return new Vector3(r.wp[i][0], castle.y, r.wp[i][1]);
            }
            var last = r.wp[r.wp.Length - 1];
            return new Vector3(last[0], castle.y, last[1]);
        }

        /// <summary>Perimeter doors: for every ground-capable corridor, the
        /// waypoint ~15 m out from the castle end — where a 4-unit squad can
        /// hold the door while the hero works elsewhere.</summary>
        /// <summary>Squad target per door: 4 base, 8 after that corridor
        /// leaked once (breach memory survives the match).</summary>
        /// <summary>RL state key — discrete buckets the Q-table can learn
        /// against (scene/wave/army/coverage/alert/wallet).</summary>
        private static string PKey(ref Snapshot s)
        {
            int ab = s.AllyCount < 10 ? 0 : s.AllyCount < 20 ? 1 : s.AllyCount < 40 ? 2 : 3;
            int cb = s.DoorCount <= 0 ? 0 : Mathf.Min(3, (int)(4f * s.DoorsCovered / s.DoorCount));
            return (s.SceneName ?? "?") + "|w" + s.Wave + "|a" + ab + "|c" + cb +
                   "|r" + (s.RedAlert ? 1 : 0) + "|b" + (s.Balance < 10 ? 1 : 0);
        }

        private static int DoorTarget(int d, string pkey)
        {
            // Coach override > M3 playbook per-line > playbook global > learned.
            int baseSz;
            string line = (sceneDoorLines != null && d < sceneDoorLines.Length)
                ? sceneDoorLines[d] : null;
            if (Coach.SquadSize > 0) baseSz = Coach.SquadSize;
            else if (line != null && Strat.LineSquad.TryGetValue(line, out int ls)) baseSz = ls;
            else if (Strat.Squad > 0) baseSz = Strat.Squad;
            else
            {
                var pick = Policy.Eval("squad",
                    new[] { "3", "4", "5", "6", "8" }, pkey);
                baseSz = int.TryParse(pick, out int v) ? v : 4;
            }
            if (doorBreach == null || d >= doorBreach.Length) return baseSz;
            return doorBreach[d] ? baseSz * 2 : baseSz;
        }

        /// <summary>The building ring: farthest owned structure's distance
        /// from the castle + margin. Enemies inside it are red alert.</summary>
        private static float ProtectedRadius(ref Snapshot s)
        {
            var builds = TagManager.instance != null ? TagManager.instance.playerBuildingInteractors : null;
            float best = 14f;   // bare castle keep radius
            if (builds != null)
            {
                for (int i = 0; i < builds.Count; i++)
                {
                    var bi = builds[i];
                    if (bi == null || bi.transform == null) continue;
                    float d = FlatDist(bi.transform.position, s.CastlePos);
                    if (d > best) best = d;
                }
            }
            return best + 4f;
        }

        private static void BuildDoors(ref Snapshot s)
        {
            // Cached per scene — the corridor list is static map data; the
            // Snapshot is recreated every capture so this must not rebuild.
            if (doorScene != s.SceneName || sceneDoorAnchors == null)
            {
                doorScene = s.SceneName;
                sceneDoorAnchors = null; sceneDoorLines = null;
                doorBreach = null; doorUnit = null;
                if (spawnRoutes != null && s.CastlePos != Vector3.zero)
                {
                    var A = new System.Collections.Generic.List<Vector3>();
                    var L = new System.Collections.Generic.List<string>();
                    var seen = new System.Collections.Generic.HashSet<string>(
                        System.StringComparer.OrdinalIgnoreCase);
                    foreach (var r in spawnRoutes)
                    {
                        if (r == null || r.wp == null || r.wp.Length < 3 || !r.ground) continue;
                        // ONE door per spawn line — parallel routes into the
                        // same choke are covered by the same posted squad.
                        // Trim+ignore-case: extracted names carry whitespace.
                        string key = r.line == null ? null : r.line.Trim();
                        if (key != null && !seen.Add(key)) continue;
                        if (key == null && seen.Contains("")) continue;
                        if (key == null) seen.Add("");
                        var last = r.wp[r.wp.Length - 1];
                        // perimeter anchor ~40 m out (outer line — squads meet
                        // the wave early, not at the doorstep)
                        bool added = false;
                        for (int i = r.wp.Length - 1; i >= 0; i--)
                        {
                            float dx = r.wp[i][0] - last[0], dz = r.wp[i][1] - last[1];
                            if (dx * dx + dz * dz >= 1600f)
                            {
                                A.Add(new Vector3(r.wp[i][0], s.CastlePos.y, r.wp[i][1]));
                                L.Add(key ?? "");
                                added = true;
                                break;
                            }
                        }
                        if (!added)   // corridor <40 m: midpoint post instead
                        {
                            var mid = r.wp[r.wp.Length / 2];
                            A.Add(new Vector3(mid[0], s.CastlePos.y, mid[1]));
                            L.Add(key ?? "");
                        }
                    }
                    sceneDoorAnchors = A.ToArray(); sceneDoorLines = L.ToArray();
                    Plugin.Log?.LogInfo($"[bot] squad doors: {sceneDoorAnchors.Length} ({string.Join(", ", L)})");
                }
            }
            s.DoorAnchors = sceneDoorAnchors; s.DoorLines = sceneDoorLines;
            if (doorUnit == null || doorUnit.Length != (sceneDoorAnchors?.Length ?? 0))
            {
                doorUnit = new int[sceneDoorAnchors?.Length ?? 0];
                doorBreach = new bool[sceneDoorAnchors?.Length ?? 0];
                doorFoes = new int[sceneDoorAnchors?.Length ?? 0];
                doorClaim = new float[sceneDoorAnchors?.Length ?? 0];
            }
        }

        private static float FlatDist(Vector3 a, Vector3 b)
        {
            a.y = 0f; b.y = 0f;
            return Vector3.Distance(a, b);
        }
    }
}




