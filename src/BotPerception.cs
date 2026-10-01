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
        public int DoorsClaimed;   // covered only because a squad is en route
            public int FreeUnits;      // units not within 10 m of a door
        public int EscortUnits;    // units on hero escort (not squad-available)
            public Vector3 UncoveredDoorPos;
            public string UncoveredDoorLine;
            public int UncoveredDoorIdx;   // the pick's anchor index —
            // parking by POSITION matched a neighbour anchor when two lines
            // deduped within 20 m (Forest stalls kept parking 'Spawn')
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
            public bool HeldBuildComplete;     // held slot's interactionComplete latched
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
        public int GateCount;               // interactable path-toggle pads
        public float GateDist;
        public Vector3 GatePos;
        public CutOpenPathInteractor NearestGate;
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
                UncoveredDoorIdx = s.UncoveredDoorIdx,
                GateCount = s.GateCount,
                GatePos = V(s.GatePos),
                GateDist = s.GateDist,
                ArmyTarget = s.ArmyTarget, SinceProg = Efficiency.SecondsSinceProgress,
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
                HeldBuildComplete = s.HeldBuildComplete,
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
        private static CutOpenPathInteractor[] gateCache;
        private static float gateScanAt;
        private static List<BuildingInteractor> gateBuilds =
            new List<BuildingInteractor>();   // Gate slots NOT on TagManager's
                                              // list (Gate Wide Variant etc.)
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
            // Nearest anchor, not first-in-20 m: two deduped lines closer than
            // 20 m once claimed the wrong door (picked door stayed re-pickable
            // while a different corridor read "en route").
            int bi = -1; float bd = 400f;
            for (int i = 0; i < sceneDoorAnchors.Length; i++)
            {
                float d = (sceneDoorAnchors[i] - pos).sqrMagnitude;
                if (d < bd) { bd = d; bi = i; }
            }
            if (bi >= 0) doorClaim[bi] = UnityEngine.Time.unscaledTime;
        }

        /// <summary>Claim by INDEX — the coverage loop already picked the
        /// door; a positional re-scan can latch a neighbor anchor.</summary>
        public static void MarkDoorClaimIdx(int i)
        {
            if (doorClaim == null || sceneDoorAnchors == null) return;
            if (i >= 0 && i < doorClaim.Length)
                doorClaim[i] = UnityEngine.Time.unscaledTime;
        }

        /// <summary>Live manned-unit count at a door anchor — the brain's
        /// "posted but never arrived" detector (squad spam loop).</summary>
        public static int DoorUnitAt(int i) =>
            (doorUnit != null && i >= 0 && i < doorUnit.Length) ? doorUnit[i] : 0;

        private static float[] doorParked;   // aim-stall proved unwalkable

        /// <summary>Park a door anchor for 5 min — the hero-door aim proved
        /// the point unwalkable (terrain wedge); re-picking it every 25 s
        /// produced the endless aim-stall loop on High Back Road.</summary>
        public static void ParkDoorAnchor(Vector3 pos)
        {
            if (sceneDoorAnchors == null) return;
            if (doorParked == null || doorParked.Length != sceneDoorAnchors.Length)
                doorParked = new float[sceneDoorAnchors.Length];
            // Nearest anchor — first-in-20 m parked the wrong corridor when
            // two lines deduped inside the radius.
            int bi = -1; float bd = 400f;
            for (int i = 0; i < sceneDoorAnchors.Length; i++)
            {
                float d = (sceneDoorAnchors[i] - pos).sqrMagnitude;
                if (d < bd) { bd = d; bi = i; }
            }
            if (bi >= 0)
            {
                doorParked[bi] = UnityEngine.Time.unscaledTime;
                Plugin.Log?.LogWarning(
                    $"[bot] door '{(sceneDoorLines != null && bi < sceneDoorLines.Length ? sceneDoorLines[bi] : "?")}' parked 5m @ {pos}");
                return;
            }
            Plugin.Log?.LogWarning($"[bot] ParkDoorAnchor: no anchor within 20m of {pos}");
        }

        /// <summary>Park by INDEX — the coverage loop knows which door it
        /// picked; the position scan used to latch the first anchor within
        /// 20 m and marked the wrong line (Forest aim parked Spawn).</summary>
        public static void ParkDoorIdx(int i)
        {
            if (sceneDoorAnchors == null || i < 0 || i >= sceneDoorAnchors.Length) return;
            if (doorParked == null || doorParked.Length != sceneDoorAnchors.Length)
                doorParked = new float[sceneDoorAnchors.Length];
            doorParked[i] = UnityEngine.Time.unscaledTime;
            Plugin.Log?.LogWarning(
                $"[bot] door '{(sceneDoorLines != null && i < sceneDoorLines.Length ? sceneDoorLines[i] : "?")}' parked 5m (idx {i})");
        }

        private static bool DoorParked(int i)
        {
            if (doorParked == null || i >= doorParked.Length) return false;
            return UnityEngine.Time.unscaledTime - doorParked[i] < 300f;
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
            public static float DoorDist = 40f;   // perimeter anchor distance (m)
            public static string Focus = "";
            public static string[] BuildOrder = new string[0];           // "cat:name - note"
            public static System.Collections.Generic.Dictionary<string, int>
                LineSquad = new System.Collections.Generic.Dictionary<string, int>();
        }

        /// <summary>Playbook build order — how many of each category must be
        /// standing before the next entry unlocks. Consumed per scene.</summary>
        public static readonly System.Collections.Generic.Dictionary<string, int>
            CatBuilt = new System.Collections.Generic.Dictionary<string, int>();
        /// <summary>Per-NAME build counts — checklist entries like
        /// "upgrade:Barracks_T2" used to complete on ANY upgrade (a castle
        /// upgrade checked a Barracks item). Name matching fixes it.</summary>
        private static readonly System.Collections.Generic.Dictionary<string, int>
            NameBuilt = new System.Collections.Generic.Dictionary<string, int>(
                System.StringComparer.OrdinalIgnoreCase);
        private static string catBuiltScene;
        private static float milFirstAt = -1f;   // first military build (anomaly D3)
        private static float slotDumpAt;          // slot-filter diagnostic cadence

        /// <summary>Classify a buildable by name — the categories the
        /// playbook's build_order speaks in.</summary>
        public static string BuildCat(string name)
        {
            string n = (name ?? "").ToLowerInvariant();
            // Gate-first: "Gate Wide Variant" walls carry buildingName="Wall"
            // — the door-checklist items mean THESE slots. If the object is a
            // gate it must classify as gate, not wall.
            if (n.Contains("gate")) return "gate";
            if (n.Contains("wall") || n.Contains("palisade") || n.Contains("fortify")) return "wall";
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
            // The pocket-park wrote a 3x3 ring around the unreachable cell —
            // redeeming only the center leaves 8 permanently-quarantined
            // neighbor cells even though nav to the pocket is now proven.
            if (pos != default)
            {
                string sc = slotPackScene ?? "";
                for (int dx = -1; dx <= 1; dx++)
                    for (int dz = -1; dz <= 1; dz++)
                        Memory.Unpark(sc, pos + new Vector3(dx * 8f, 0f, dz * 8f));
            }
            if (catBuiltScene != slotPackScene)
            {
                catBuiltScene = slotPackScene;
                CatBuilt.Clear();
                NameBuilt.Clear();
                milFirstAt = -1f;
            }
            string cat = BuildCat(buildingName);
            nonDefenseStreak = (cat == "wall" || cat == "gate" || cat == "tower") ? 0 : nonDefenseStreak + 1;
            // "Gate Wide Variant" objects report buildingName "Wall" — the
            // playbook's gate checklist items mean the gate slots, so a
            // completed wall-slot that carried a GateOpener has to count as
            // gate. Marked by a name suffix from the caller.
            if (cat == "wall" && buildingName != null &&
                buildingName.IndexOf("|gate", System.StringComparison.OrdinalIgnoreCase) >= 0)
                cat = "gate";
            if (cat == "military" && milFirstAt < 0f)
                milFirstAt = Time.unscaledTime;
            CatBuilt[cat] = (CatBuilt.TryGetValue(cat, out int c) ? c : 0) + 1;
            NameBuilt[buildingName] =
                (NameBuilt.TryGetValue(buildingName, out int nc) ? nc : 0) + 1;
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
                // Wedged categories advance instead of deadlocking the plan —
                // a wall slot behind unwalkable geometry used to freeze open[0]
                // while towers/houses absorbed every pick for 6+ min.
                if (catStuck.TryGetValue(cat, out int st) && st >= 4) continue;
                need.TryGetValue(cat, out int seen);
                need[cat] = seen + 1;
                CatBuilt.TryGetValue(cat, out int have);
                if (have < need[cat]) open.Add(cat);
                if (open.Count >= 3) break;
            }
            return open.ToArray();
        }

        private static readonly System.Collections.Generic.Dictionary<string, int> catStuck =
            new System.Collections.Generic.Dictionary<string, int>();

        /// <summary>Count a failure against a build category (unreachable park,
        /// wrong-layer retry, stall). At 4+ the playbook skips it — the plan
        /// degrades to the next category instead of starving.</summary>
        public static void NoteBuildFail(string cat)
        {
            if (string.IsNullOrEmpty(cat)) return;
            catStuck.TryGetValue(cat, out int n);
            catStuck[cat] = n + 1;
        }

        /// <summary>Full playbook checklist for the audit UI: every build_order
        /// entry with its done/pending status against CatBuilt.</summary>
        public static string AuditJson(ref Snapshot s, string mode, float modeSince, float now)
        {
            var ci = System.Globalization.CultureInfo.InvariantCulture;
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
              .Append(",\"bmil_first\":").Append(milFirstAt >= 0f ? Mathf.RoundToInt(milFirstAt).ToString(ci) : "null")
              // foes = LIVE enemies (was next-wave count — dashboards read
              // wave size as live foes during the day; audit round 7).
              .Append(",\"foes\":").Append(s.EnemyCount)
              .Append(",\"next_foes\":").Append(s.NextWaveCount)
              .Append(",\"night\":").Append(s.IsNight ? "true" : "false")
              .Append(",\"wave\":").Append(s.Wave)
              .Append(",\"wave_total\":").Append(s.WaveTotal)
              .Append(",\"doors_cov\":").Append(s.DoorsCovered)
              .Append(",\"doors_claimed\":").Append(s.DoorsClaimed)
              .Append(",\"doors\":").Append(s.DoorCount)
              .Append(",\"red\":").Append(s.RedAlert ? "true" : "false")
              .Append(",\"breaches\":").Append(BreachCount)
              .Append(",\"bld\":").Append(s.BuildCount)
              .Append(",\"gates\":").Append(s.GateCount)
              .Append(',').Append(Efficiency.Json())
              .Append(',').Append(Tasks.Json())
              .Append(",\"hot_cells\":").Append(SpatialMemory.HotCount(s.SceneName))
              .Append(",\"maxed_pct\":").Append(MaxLevelTotal > 0 ? Mathf.RoundToInt(100f * MaxLevelSum / MaxLevelTotal) : 0)
              .Append(",\"slots_built\":").Append(SlotsBuilt)
              .Append(",\"slots_total\":").Append(SlotsTotal)
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
                var cc = entry.Split(':');
                string cat = cc[0].Trim();
                // Named entries check the NAME, not the category bucket —
                // "upgrade:Barracks_T2" used to complete when a Castle Center
                // upgrade incremented cat 'upgrade' (live-evidence audit).
                string wantName = cc.Length > 1 ? cc[1].Split('-')[0].Trim() : null;
                // Playbook names carry day/tier suffixes: "Barracks_T2_day6"
                // → match the building "Barracks". Strip _dayN and _TN.
                if (wantName != null)
                {
                    wantName = System.Text.RegularExpressions.Regex.Replace(
                        wantName, "_day\\d+$", "",
                        System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                    wantName = System.Text.RegularExpressions.Regex.Replace(
                        wantName, "_T\\d+$", "",
                        System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                }
                cnt.TryGetValue(cat, out int k); cnt[cat] = k + 1;
                bool done;
                if (wantName != null)
                {
                    done = false;
                    foreach (var nb in NameBuilt)
                        if (nb.Value > 0 && nb.Key.IndexOf(wantName,
                                System.StringComparison.OrdinalIgnoreCase) >= 0)
                        { done = true; break; }
                }
                else
                {
                    CatBuilt.TryGetValue(cat, out int have);
                    done = have >= cnt[cat];
                }
                if (i > 0) sb.Append(',');
                sb.Append("{\"n\":").Append(JsonStr(entry))
                  .Append(",\"done\":").Append(done ? "true" : "false")
                  .Append('}');
            }
            sb.Append("]}");
            return sb.ToString();
        }

        internal static string JsonStr(string v)
        {
            if (v == null) return "null";
            return "\"" + v.Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"";
        }

        private static void LoadStrategy(string scene)
        {
            Strat.Squad = Strat.Reserve = Strat.Escort = Strat.ArmyTarget = 0;
        Strat.DoorDist = 40f;
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
            NameBuilt.Clear();
            catStuck.Clear();
            milFirstAt = -1f;
            catBuiltScene = null;
            badStands.Clear();       // per-scene stand blacklist (PosKey has no scene)
            doorParked = null;       // unwalkable-door marks die with the scene
            BreachCount = 0;
            HornBi = null;           // stale horn handle across reloads
            lastBuildPick = null;    // dead objects from the old scene
            HeldBuildRef = null;
        CommittedBuildRef = null;
            buildClassCache.Clear();
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
                // door_distance_m: how far out the perimeter anchors sit.
                // Parsed but unconsumed until round-7 — the doc claimed the
                // field did nothing; wire it into BuildDoors.
                {
                    var ddm = System.Text.RegularExpressions.Regex.Match(
                        j, "\"door_distance_m\"\\s*:\\s*([\\d.]+)");
                    if (ddm.Success && float.TryParse(ddm.Groups[1].Value,
                        System.Globalization.NumberStyles.Float,
                        System.Globalization.CultureInfo.InvariantCulture,
                        out float dv) && dv >= 10f && dv <= 200f)
                        Strat.DoorDist = dv;
                    else Strat.DoorDist = 40f;
                }
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
            Mathf.FloorToInt(p.x / 4f) + "," + Mathf.FloorToInt(p.z / 4f);

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
            // NO fallback to stands[0] — every candidate just failed the
            // clearance check; returning one anyway advertises an unwalkable
            // stand as usable (audit: east-perimeter aims never released).
            if (best == null) return Vector3.zero;
            return new Vector3(best.x, best.y, best.z);
        }

        /// <summary>BestStand over a raw stands array (castle section).</summary>
        private static Vector3 BestStandRecs(StandPtRec[] stands, Vector3 hero)
        {
            if (stands == null || stands.Length == 0) return Vector3.zero;
            StandPtRec best = null; float bd = float.MaxValue;
            foreach (var p in stands)
            {
                if (p.cl < 0.5f) continue;
                float dx = p.x - hero.x, dz = p.z - hero.z;
                float d = dx * dx + dz * dz;
                if (d < bd) { bd = d; best = p; }
            }
            if (best == null) return Vector3.zero;
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
            int scopeStart = 0;
            int si = json.IndexOf("\"slots\"", System.StringComparison.Ordinal);
            if (si < 0) return null;   // no slots section — a full-file scan
                                       // turns gates/spawns pos keys into
                                       // phantom buildable slots.
            {
                int so = json.IndexOf('[', si);
                int sc = MatchBracket(json, so);
                if (sc > so) { scopeStart = so; scopeEnd = sc; }
            }
            int i = scopeStart;
            while (true)
            {
                i = json.IndexOf("\"pos\"", i, System.StringComparison.Ordinal);
                if (i < 0 || i >= scopeEnd) break;
                var sl = new SlotPackRec { name = "" };
                // id sits a few chars before pos — bounded to the slots
                // section so a slot can't adopt a preceding object's id.
                int h = json.LastIndexOf("\"id\"", i, i - scopeStart);
                if (h > 0 && i - h < 400) { var m = System.Text.RegularExpressions.Regex.Match(json.Substring(h, System.Math.Min(32, json.Length - h)), "\"id\"\\s*:\\s*(-?\\d+)"); if (m.Success) sl.id = int.Parse(m.Groups[1].Value, ci); }
                var pm = System.Text.RegularExpressions.Regex.Match(json.Substring(i, System.Math.Min(120, json.Length - i)),
                    "\"pos\"\\s*:\\s*\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]");
                if (pm.Success) sl.pos = new float[] {
                    float.Parse(pm.Groups[1].Value, ci),
                    float.Parse(pm.Groups[2].Value, ci),
                    float.Parse(pm.Groups[3].Value, ci) };
                // stands must come from THIS slot — an unbounded search let
                // a stand-less slot attach the NEXT slot's stands (re-audit:
                // scopeEnd/20 k alone still crossed record boundaries). Bound
                // it to the next "pos" — a slot record ends where the next
                // begins.
                int nextPos = json.IndexOf("\"pos\"", i + 5, System.StringComparison.Ordinal);
                int slotEnd = (nextPos > i && nextPos < scopeEnd) ? nextPos : scopeEnd;
                int st = json.IndexOf("\"stands\"", i, System.StringComparison.Ordinal);
                if (st > 0 && st < slotEnd)
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
        private static void EnsureInteractorFields()
        {
            if (fiLooked) return;
            fiLooked = true;
            var ty = typeof(BuildingInteractor);
            fiComplete = ty.GetField("interactionComplete",
                System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
            fiWaiting = ty.GetField("isWaitingForChoice",
                System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
        }

        private static bool IsInteractorFinished(BuildingInteractor bi)
        {
            EnsureInteractorFields();
            try
            {
                // interactionComplete LATCHES after the first successful hold —
                // a multi-tier building (Castle Center: 4 upgrade tiers) then
                // read "finished" forever and never offered tier 2, which is
                // why the barracks activator stayed at level 1. The game's own
                // CanBeInteractedWith is authoritative: a slot that still
                // accepts interaction is NOT finished regardless of the flag.
                if (!bi.CanBeInteractedWith)
                {
                    if (fiComplete != null && (bool)fiComplete.GetValue(bi)) return true;
                    // isWaitingForChoice is STALE-SAFE: a slot whose hold ended
                    // mid-choice keeps the flag latched forever, which read as
                    // "finished" and skipped the Castle Center's second tier —
                    // the barracks activator then never reached level 2. Only a
                    // LIVE choice coroutine counts as finished here.
                    if (fiWaiting != null && (bool)fiWaiting.GetValue(bi))
                    {
                        var cm = ChoiceManager.instance;
                        if (cm != null && cm.ChoiceCoroutineRunning) return true;
                        // no live choice — stale flag, keep the slot pickable
                    }
                }
            }
            catch { }
            return false;
        }

        /// <summary>Strict completion for held-slot stickiness ONLY —
        /// isWaitingForChoice must NOT read as finished (a mid-fill choice
        /// would drop the hold → release → refund; the exact bmil=0 loop).
        /// </summary>
        public static bool IsInteractorComplete(BuildingInteractor bi)
        {
            // Held-slot check runs BEFORE IsInteractorFinished in the scan —
            // a null fiComplete would mean "never finished" and the bot would
            // hold a completed slot forever. Initialize the fields here too.
            EnsureInteractorFields();
            try { return fiComplete != null && (bool)fiComplete.GetValue(bi); }
            catch { return false; }
        }

        private static int MatchBracket(string s, int open)
        {
            if (open < 0) return -1;
            int depth = 0;
            bool inStr = false;
            for (int i = open; i < s.Length; i++)
            {
                // Skip string literals — a '[' or ']' inside a name/note
                // corrupted depth and truncated sections.
                if (s[i] == '"' && (i == 0 || s[i - 1] != '\\')) inStr = !inStr;
                if (inStr) continue;
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
                        // "wp" is a nested array — a greedy \[.*\] swallows
                        // the narrowAt [x,y] that follows it, corrupting the
                        // final waypoint (audit's choke-as-origin bug).
                        int wk = seg.IndexOf("\"wp\"", System.StringComparison.Ordinal);
                        if (wk >= 0)
                        {
                            int wo = seg.IndexOf('[', wk);
                            int wc = wo >= 0 ? MatchBracket(seg, wo) : -1;
                            if (wc > wo)
                            {
                                var wps = new System.Collections.Generic.List<float[]>();
                                foreach (System.Text.RegularExpressions.Match pm in
                                    System.Text.RegularExpressions.Regex.Matches(seg.Substring(wo, wc - wo), "\\[\\s*(-?[\\d.eE+-]+)\\s*,\\s*(-?[\\d.eE+-]+)\\s*\\]"))
                                    wps.Add(new float[] { float.Parse(pm.Groups[1].Value, ci), float.Parse(pm.Groups[2].Value, ci) });
                                r.wp = wps.ToArray();
                            }
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

        public static void ClearIgnores() { buildIgnore.Clear(); }
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

        /// <summary>The executor's currently-held interactor — survives
        /// leaving the builds list mid-fill so stickiness isn't lost.</summary>
        public static BuildingInteractor HeldBuildRef;
        public static BuildingInteractor CommittedBuildRef;
        public static float CommittedBuildAt;
        private static string firstOpenPresent;
        private static int nonDefenseStreak;
        public static int MaxLevelSum, MaxLevelTotal, SlotsBuilt, SlotsTotal;
        private static System.Reflection.FieldInfo fiRequiredRoot;
        private static System.Collections.Generic.HashSet<BuildSlot> enablersNow =
            new System.Collections.Generic.HashSet<BuildSlot>();
        private static System.Collections.Generic.HashSet<BuildSlot> enablersPrev =
            new System.Collections.Generic.HashSet<BuildSlot>();
        private static System.Collections.Generic.HashSet<string> catsPresent;

        // TagManager list-flicker grace — see the carry-forward below.
        private static BuildingInteractor lastBuildPick;
        private static float lastBuildPickAt;

        public static Snapshot Capture(int preferBuildKey = -1)
        {
            var s = new Snapshot { GameState = "unknown", UncoveredDoorIdx = -1 };
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
                // The keep has a dedicated "castle" stands section — it is
                // not a slot record, so FindSlot(castlePos) never matches and
                // HasCastleStand stayed permanently false (dead pack data).
                var csp = castleStands != null ? BestStandRecs(castleStands, s.HeroPos)
                                             : BestStand(FindSlot(castlePos), s.HeroPos);
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

            // Gate/unlock pads: CutOpenPathInteractor = the pay-to-open path
            // toggles (the "doors" the bot never unlocked — they aren't in
            // playerBuildingInteractors so the scan never saw them). 1 Hz.
            if (Time.unscaledTime >= gateScanAt)
            {
                gateScanAt = Time.unscaledTime + 1f;
                gateCache = Object.FindObjectsOfType<CutOpenPathInteractor>(true);
                // Gate building slots live outside playerBuildingInteractors
                // (Gate Wide Variant on Durststein never appeared in the
                // scan) — find them by their building name so the playbook's
                // "gate" items can actually be built.
                // Max-everything progress meter: sum(level)/sum(maxLevel) over
                // every build slot in the scene — the proof number for
                // "everything built and upgraded to the max".
                int lvSum = 0, lvMax = 0, built = 0, total = 0;
                foreach (var sl in Object.FindObjectsOfType<BuildSlot>(true))
                {
                    if (sl == null || sl.Upgrades == null) continue;
                    total++; lvMax += sl.Upgrades.Count; lvSum += Mathf.Min(sl.Level, sl.Upgrades.Count);
                    if (sl.Level > 0) built++;
                }
                MaxLevelSum = lvSum; MaxLevelTotal = lvMax; SlotsBuilt = built; SlotsTotal = total;
                gateBuilds.Clear();
                foreach (var gb in Object.FindObjectsOfType<BuildingInteractor>(true))
                {
                    if (gb == null) continue;
                    string gn = gb.targetBuilding != null ? gb.targetBuilding.name : gb.name;
                    if (gn != null && gn.IndexOf("gate", System.StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        gateBuilds.Add(gb);
                        if (gateBuilds.Count <= 8)
                            Plugin.Log?.LogInfo($"[bot] gate-slot '{gn}' cat={BuildCat(gb.targetBuilding != null ? gb.targetBuilding.buildingName : gn)} bn='{(gb.targetBuilding != null ? gb.targetBuilding.buildingName : "?")}' can={gb.CanBeInteractedWith}");
                    }
                }
            }
            s.GateCount = 0; s.GateDist = float.MaxValue; s.NearestGate = null;
            if (gateCache != null)
            {
                foreach (var gp in gateCache)
                {
                    if (gp == null || !gp.CanBeInteractedWith) continue;
                    s.GateCount++;
                    float gd = (gp.transform.position - s.HeroPos).sqrMagnitude;
                    if (gd < s.GateDist)
                    {
                        s.GateDist = gd;
                        s.NearestGate = gp;
                    }
                }
                if (s.NearestGate != null)
                {
                    s.GatePos = s.NearestGate.transform.position;
                    s.GateDist = Mathf.Sqrt(s.GateDist);
                }
                else s.GateDist = 0f;
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
                {
                    // Nearest anchor wins — converging corridors mis-attributed
                    // foes to whichever door came first in array order.
                    int nd = -1; float ndD = 900f;
                    for (int dd = 0; dd < sceneDoorAnchors.Length && dd < doorFoes.Length; dd++)
                    {
                        float fx = sceneDoorAnchors[dd].x - ep.x, fz = sceneDoorAnchors[dd].z - ep.z;
                        float fd = fx * fx + fz * fz;
                        if (fd < ndD) { ndD = fd; nd = dd; }
                    }
                    if (nd >= 0) doorFoes[nd]++;
                }
                enemySum += ep; enemyN++;
            }
            s.EnemyCount = enemyN;      // live-only — the raw list keeps dead entries
            s.EnemiesNearHero = foesNear;
            if (s.NearestEnemy != null)
            {
                s.NearestEnemyPos = s.NearestEnemy.transform.position;
                s.NearestEnemyDist = Mathf.Sqrt(s.NearestEnemyDist);
            }
            else s.NearestEnemyDist = 0f;
            if (s.CastleThreat != null)
                s.CastleThreatDist = Mathf.Sqrt(castleThreatSq);
            else { s.CastleThreatDist = s.NearestEnemyDist; s.CastleThreat = s.NearestEnemy; }
            // NearestEnemyDist is already sqrt'd above — a 0 here told every
            // consumer "enemy on top of the castle" for a distant live foe.

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
                s.UncoveredDoorIdx = -1;
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
                        // Escorts walking past a corridor must NOT count as
                        // manning it — only a unit ordered to HOLD or stand its
                        // home post counts. Nearest manned anchor wins (the
                        // old first-in-array break mis-tallied at choke
                        // convergences near the castle).
                        int md = -1; float mdD = 625f;
                        for (int d = 0; d < s.DoorAnchors.Length; d++)
                        {
                            float dx = s.DoorAnchors[d].x - u.transform.position.x;
                            float dz = s.DoorAnchors[d].z - u.transform.position.z;
                            bool manned = pu != null && !pu.FollowingPlayer &&
                                (pu.HoldPosition ||
                                (pu.HomePosition - s.DoorAnchors[d]).sqrMagnitude < 64f);
                            float dd2 = dx * dx + dz * dz;
                            if (dd2 < mdD && manned) { mdD = dd2; md = d; }
                        }
                        if (md >= 0)
                        {
                            nearDoor = true;
                            if (doorUnit != null && md < doorUnit.Length) doorUnit[md]++;
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
                // pk feeds DoorTarget inside the loop (needs a key NOW) —
                // but s.PolicyKey is re-assigned AFTER RedAlert so the RL
                // state key actually carries the coverage/alert buckets it
                // claims to (it used to be written with stale c0/r0).
                string pk = PKey(ref s);
                s.DoorCount = s.DoorAnchors.Length;
                s.DoorsCovered = 0;
                s.UncoveredDoorPos = Vector3.zero; s.UncoveredDoorLine = null;
                s.UncoveredDoorIdx = -1;
                s.UncoveredDoorHot = false;
                float leakD = float.MaxValue;
                int doorsClaimed = 0;
                for (int hot = 1; hot >= 0; hot--)
                {
                    for (int d = 0; d < s.DoorAnchors.Length; d++)
                    {
                        if (DoorParked(d))
                        {
                            // Parked = unwalkable proof — count it covered so
                            // doors_cov can still reach doors and defenseFirst
                            // doesn't latch permanently on a dead anchor.
                            if (hot == 1) s.DoorsCovered++;
                            continue;
                        }
                        if (doorUnit != null && d < doorUnit.Length &&
                            doorUnit[d] >= DoorTarget(d, pk))
                        { if (hot == 1) s.DoorsCovered++; continue; }
                        // Claimed + walking — skip re-posting for 25 s. This
                        // is "claimed", not "covered" — a wiped squad used to
                        // inflate doors_cov. Tracked separately now.
                        if (doorClaim != null && d < doorClaim.Length &&
                            UnityEngine.Time.unscaledTime - doorClaim[d] < 25f)
                        {
                            if (hot == 1) { s.DoorsCovered++; doorsClaimed++; }
                            continue;
                        }
                        if ((doorFoes != null && d < doorFoes.Length &&
                             doorFoes[d] > 0) != (hot == 1)) continue;
                        float dc = FlatDist(s.DoorAnchors[d], s.CastlePos);
                        if (hot == 1 || dc < leakD)
                        {
                            if (hot == 0) leakD = dc;
                            s.UncoveredDoorPos = s.DoorAnchors[d];
                            s.UncoveredDoorIdx = d;
                            s.UncoveredDoorLine =
                                d < (s.DoorLines?.Length ?? 0) ? s.DoorLines[d] : "";
                            s.UncoveredDoorTarget = DoorTarget(d, pk);
                            s.UncoveredDoorHot = hot == 1;
                            if (hot == 1) break;   // first hot door wins
                        }
                    }
                }
                s.DoorsClaimed = doorsClaimed;
                // Sentinel bug: an anchor legitimately AT world origin read
                // as "no uncovered door" — the index is the truth.
                s.HasUncoveredDoor = s.UncoveredDoorIdx >= 0;
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
                            Plugin.Log?.LogWarning($"[bot] BREACH on door '{(bi < (s.DoorLines?.Length ?? 0) ? s.DoorLines[bi] : "?")}' — squad target raised");
                        }
                    }
                }
            }
            else s.RedAlert = false;
            // Final RL state key — now that DoorsCovered and RedAlert are real.
            s.PolicyKey = PKey(ref s);

            // Nearest unclaimed coin. freeCoins is maintained by TagManager via
            // Coin.OnEnable/OnDestroy, so it should always be accurate.
            s.NearestCoinDist = float.MaxValue;
            int n = tm.freeCoins.Count;
            for (int i = 0; i < n; i++)
            {
                Coin c = tm.freeCoins[i];
                if (c == null || !c.IsFree) continue;
                if (CoinSkip != null && CoinSkip(c)) continue;
                s.CoinCount++;   // count collectable coins only — the skip list
                                 // used to inflate CoinCount for an ignored coin
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
                            // Walk the base types — GetField with NonPublic
                            // does NOT return fields declared on a base class
                            // (the horn's targetBuilding lives there), so bn
                            // stayed "" and horn detection degraded.
                            object tb = null;
                            for (var tt = t; tt != null && tb == null; tt = tt.BaseType)
                            {
                                tb = tt.GetField("targetBuilding", BF)?.GetValue(bi)
                                  ?? tt.GetProperty("targetBuilding", BF)?.GetValue(bi)
                                  ?? tt.GetField("building", BF)?.GetValue(bi)
                                  ?? tt.GetProperty("building", BF)?.GetValue(bi);
                            }
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
            // Long-day leak: destroyed slots and one-shot ignores accumulate
            // as keys forever (Unity fake-null keys hold the entry). Sweep
            // expired entries when the table grows past a small bound.
            if (buildIgnore.Count > 64)
            {
                var dead = new List<BuildingInteractor>();
                float nowU = Time.unscaledTime;
                foreach (var kv in buildIgnore)
                    if (kv.Key == null || kv.Value <= nowU) dead.Add(kv.Key);
                foreach (var k in dead) buildIgnore.Remove(k);
            }

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
            int commitCandScore = int.MinValue;   // committed slot's score
            float commitCandDist = 0f;            // this pass (if it survived
            float nowT = Time.unscaledTime;       // the filters)
            if (catsPresent == null)
                catsPresent = new System.Collections.Generic.HashSet<string>();
            catsPresent.Clear();
            { var tmpE = enablersPrev; enablersPrev = enablersNow; enablersNow = tmpE; enablersNow.Clear(); }
            int effTier = Efficiency.Tier;
            var builds = tm.playerBuildingInteractors;
            if (gateBuilds.Count > 0)
            {
                // Merge gate slots into the candidate list (deduped).
                builds = new List<BuildingInteractor>(tm.playerBuildingInteractors);
                foreach (var gb in gateBuilds)
                    if (gb != null && !builds.Contains(gb)) builds.Add(gb);
            }
            // Held-hold identity pin: a mid-fill interactor LEAVES the
            // builds list while its fill runs (pads deactivate) — the
            // preferBuildKey match then misses every tick and the brain
            // release/re-begins forever (fill never completes: Castle lvl=0
            // bug). If the held object still exists and isn't complete, keep
            // it selected regardless of list membership.
            if (HeldBuildRef != null)
            {
                bool hbInList = false;
                for (int i = 0; i < builds.Count; i++)
                    if (ReferenceEquals(builds[i], HeldBuildRef)) { hbInList = true; break; }
                if (!hbInList)
                {
                    float hdh = (HeldBuildRef.transform.position - s.HeroPos).sqrMagnitude;
                    bool midCh = ChoiceManager.instance != null &&
                                 ChoiceManager.instance.ChoiceCoroutineRunning;
                    // 12 m held radius — the castle's stand ring sits ~9.5 m
                    // from center; 6 m (36 sqr) dropped the pin every tick.
                    if (hdh <= (midCh ? 400f : 144f) && !IsInteractorComplete(HeldBuildRef))
                    {
                        s.NearestBuild = HeldBuildRef;
                        s.NearestBuildDist = hdh;
                        s.NearestBuildScore = 100000;
                        bestBuildScore = int.MaxValue;
                        s.BuildCount++;
                    }
                }
            }
            for (int i = 0; i < builds.Count; i++)
            {
                var bi = builds[i];
                if (bi == null) continue;
                // Do NOT gate on isActiveAndEnabled — Thronefall's build pads
                // report act=False while still fully interactable (live diag:
                // Barracks(act=False, can=True) sat unbuildable for the whole
                // day). CanBeInteractedWith is the game's own predicate —
                // it already goes false on destroyed/removed slots.
                // Held-hold stickiness must outrank the interactable filter:
                // mid-choice slots report CanBeInteractedWith=false while the
                // unit pick resolves — skipping them here releases the hold
                // and refunds the partial fill (observed: Archery Range →
                // waitChoice → brain re-picked Barracks → refund → never
                // completes). Keep the held slot selected until done.
                bool heldMatch0 = preferBuildKey >= 0 &&
                                  (bi.GetInstanceID() == preferBuildKey ||
                                   ReferenceEquals(bi, HeldBuildRef));
                if (heldMatch0)
                {
                    float hd0 = (bi.transform.position - s.HeroPos).sqrMagnitude;
                    // Completion surfaced to the brain: it releases the hold
                    // instantly instead of riding the 7 s stall watchdog —
                    // the latch-loop (complete → re-hold → early-return →
                    // stall → re-pick) is how Castle Center tier-2 never ran.
                    if (IsInteractorComplete(bi)) s.HeldBuildComplete = true;
                    // Mid-choice slots MUST stay held at any distance —
                    // walking >6 m during a pick + going invisible caused the
                    // refund churn. Keep them selected while a choice coroutine
                    // is live (or they simply report non-interactable).
                    bool midChoice = ChoiceManager.instance != null &&
                                     ChoiceManager.instance.ChoiceCoroutineRunning;
                    // 12 m held radius: big-building stands (castle ~9.5 m
                    // center-dist) used to exceed 6 m and drop the pin →
                    // per-tick release/re-begin thrash (fill never fills).
                    float heldR = midChoice ? 400f : 144f;  // 20 m vs 12 m
                    if (hd0 <= heldR && !IsInteractorComplete(bi))
                    {
                        s.NearestBuildDist = hd0;
                        s.NearestBuild = bi;
                        s.NearestBuildScore = 100000;
                        bestBuildScore = int.MaxValue;
                        s.BuildCount++;          // held pick is still a
                                                 // candidate — bld telemetry
                                                 // underreported it to 0
                        continue;
                    }
                }
                if (!bi.CanBeInteractedWith)
                {
                    // Max-everything (A3): a built slot that cannot upgrade
                    // because its ROOT (usually Castle Center) is too low is
                    // waiting on the root — promote the root as an enabler.
                    try
                    {
                        var wbs = bi.targetBuilding;
                        if (wbs != null && wbs.Level > 0 && wbs.Upgrades != null && wbs.Level < wbs.Upgrades.Count)
                        {
                            if (fiRequiredRoot == null)
                                fiRequiredRoot = typeof(BuildSlot).GetField("requiredRoot",
                                    System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                            var root = fiRequiredRoot?.GetValue(wbs) as BuildSlot;
                            if (root != null && root != wbs && root.CanBeUpgraded) enablersNow.Add(root);
                        }
                    }
                    catch { }
                    continue;
                }
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
                    // Deactivated slots accept payment through the interactor
                    // but NEVER materialize — Activate() only fires when the
                    // slot's activator building passes activatorLevel. The
                    // barracks held to waitChoice, "completed", and produced
                    // zero units: lvl=1 Built on an inactive GameObject.
                    // Skip only while the slot is still activator-GATED — a
                    // slot whose activator already passed its level (or was
                    // never StartDeactivated) is legitimately interactable:
                    // unconditional skipping made them invisible forever
                    // (round-7 audit). ActivatorBuilding can be null — guard.
                    if (!bs.gameObject.activeInHierarchy && bs.StartDeactivated &&
                        (bs.ActivatorBuilding == null ||
                         bs.ActivatorBuilding.Level <= bs.ActivatorLevel))
                    {
                        // Build the ENABLER first (A2/A5): a gated slot is
                        // un-buildable until its activator (Castle Center
                        // etc.) levels up — remember it so the activator's
                        // own interactor gets a large score next scan.
                        if (bs.ActivatorBuilding != null) enablersNow.Add(bs.ActivatorBuilding);
                        continue;
                    }
                    if (bs.NextUpgradeOrBuildEnergyCoreCost > s.CoreBalance)
                        continue;                              // can't afford cores — skip outright
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
                    if (incomeDelta > 0)
                    {
                        score += 30 + Mathf.Min(incomeDelta, 10) * 3;
                        // ROI (A11): income per gold spent — a 1 g Field (+1)
                        // must beat a 20 g House L3 (+2): payback, not raw delta.
                        float cst = Mathf.Max(1f, bs.NextUpgradeOrBuildCost);
                        score += Mathf.Min(600, (int)(300f * incomeDelta / cst));
                    }
                    // WAR PREP: far under the army target (<70 %) the next wave is lethal — troops and the
                    // buildings that unlock troops outrank every playbook pin (max 7500) and all economy.
                    bool underArmed = s.ArmyTarget > 0 && s.AllyCount * 10 < s.ArmyTarget * 7;
                    if (armyShort && military > 0) score += underArmed ? 14000 : 6500;
                    if (enablersPrev.Contains(bs)) score += underArmed ? 14500 : 7000;
                    // PLAYBOOK ORDER: the M3 plan's literal build sequence —
                    // the next unsatisfied category gets a heavy bonus so
                    // walls/gates/barracks go up in the playbook's order,
                    // not whenever scoring happens to favor them.
                    var open = OpenBuildOrder();
                    if (open.Length > 0)
                    {
                        string scat = BuildCat(bs.buildingName);
                        // Gate wall-variants classify by their object name —
                        // buildingName is literally "Wall" for them.
                        if (scat == "wall" && bs.name != null &&
                            bs.name.IndexOf("gate", System.StringComparison.OrdinalIgnoreCase) >= 0)
                            scat = "gate";
                        if (catsPresent != null) catsPresent.Add(scat);
                        // HARD build order: pin the FIRST open category that
                        // actually has live candidates — open[0] can name a
                        // category this map has no slots for ("gate" on
                        // Durststein = the CutOpenPath pads, not building
                        // slots), which starved every real task behind it.
                        // Tiering (A5/A2): enabler 7000 > army-short military
                        // 6500 > playbook pin 5000 — but after 2 straight
                        // non-defense builds the pin jumps to 7500 so walls /
                        // gates / towers can never starve behind troops.
                        if (scat == firstOpenPresent)
                            score += nonDefenseStreak >= 2 ? 7500 : 5000;
                        else
                        {
                            int oi = System.Array.IndexOf(open, scat);
                            if (oi >= 0) score += 600 - oi * 150;
                        }
                    }
                }
                s.BuildCount++;
                float d = (bi.transform.position - s.HeroPos).sqrMagnitude;
                // Efficiency: closer work wins ties AND beats slightly better
                // far work — walking 60 m to a marginally-better slot is how
                // the bot used to spend the whole day traveling.
                // Nearest-first within a tier (A2: 32% of waste was serial
                // cross-map travel): 60 m falloff, 8 pts/m.
                score += Mathf.Max(0, 60 - (int)Mathf.Sqrt(d)) * 8;
                // A1: ~55% of day waste was cross-map walking. Beyond 20 m
                // each metre costs 25 pts (cap 3000): priority tiers still
                // win, but the NEAREST member of a tier wins decisively and a
                // far low-tier slot can never beat a near one.
                score -= Mathf.Min(3000, Mathf.Max(0, (int)Mathf.Sqrt(d) - 20) * 25);
                // Held-hold stickiness: the slot we're mid-pay on wins
                // outright while it's still interactable and near — prevents
                // per-tick pick flips that refund the partial fill.
                // Stickiness must die on completion — a completed interactor
                // re-winning +100000 makes the brain keep pumping a latch the
                // fill can never satisfy (castle tier-2 wedge).
                bool heldMatch = preferBuildKey >= 0 && bi.GetInstanceID() == preferBuildKey
                                 && !IsInteractorComplete(bi);
                if (heldMatch && d <= 12f * 12f)   // castle stand ring is ~9.5 m
                {
                    s.NearestBuildDist = d;
                    s.NearestBuild = bi;
                    s.NearestBuildScore = score + 100000;
                    bestBuildScore = int.MaxValue;   // no later pick can beat it
                    continue;
                }
                if (CommittedBuildRef != null && ReferenceEquals(bi, CommittedBuildRef))
                { commitCandScore = score; commitCandDist = d; }
                if (score > bestBuildScore || (score == bestBuildScore && d < s.NearestBuildDist))
                {
                    bestBuildScore = score;
                    s.NearestBuildDist = d;
                    s.NearestBuild = bi;
                    s.NearestBuildScore = score;
                }
            }
            // Slot-scan diagnostic: WHY did the military never build? Dump the
            // filtered interactables once per 30 s of day — the audit found
            // 406 day ticks with bld=0 and barracks never appearing as `bn`.
            if (!s.IsNight && Time.unscaledTime > slotDumpAt)
            {
                slotDumpAt = Time.unscaledTime + 30f;
                var skip = new System.Text.StringBuilder();
                for (int i = 0; i < builds.Count; i++)
                {
                    var bi = builds[i];
                    if (bi == null) continue;
                    string bn = bi.targetBuilding != null ? bi.targetBuilding.buildingName : bi.name;
                    if (bn == null || bn.IndexOf("barrack", System.StringComparison.OrdinalIgnoreCase) < 0 &&
                        bn.IndexOf("archer", System.StringComparison.OrdinalIgnoreCase) < 0 &&
                        bn.IndexOf("militia", System.StringComparison.OrdinalIgnoreCase) < 0 &&
                        bn.IndexOf("wall", System.StringComparison.OrdinalIgnoreCase) < 0 &&
                        bn.IndexOf("gate", System.StringComparison.OrdinalIgnoreCase) < 0 &&
                        bn.IndexOf("castle", System.StringComparison.OrdinalIgnoreCase) < 0) continue;
                    if (bn.IndexOf("castle", System.StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        var csl = bi.targetBuilding;
                        skip.Append(bn)
                            .Append("(can=").Append(bi.CanBeInteractedWith)
                            .Append(csl != null ?
                                (",lvl=" + csl.Level +
                                 ",upgs=" + (csl.OwnUpgrades != null ? csl.OwnUpgrades.Count : -1) +
                                 ",canUp=" + csl.CanBeUpgraded) : "")
                            .Append(");");
                        continue;
                    }
                    var bslot = bi.targetBuilding;
                    skip.Append(bn)
                        .Append("(inter=").Append(bi.isActiveAndEnabled)
                        .Append(",can=").Append(bi.CanBeInteractedWith)
                        .Append(",slot=").Append(bslot == null ? "?" :
                            (bslot.gameObject.activeInHierarchy ? "on" : "off"))
                        .Append(bslot != null ?
                            (",lvl=" + bslot.Level +
                             ",actLvl=" + bslot.ActivatorLevel +
                             ",via=" + (bslot.ActivatorBuilding != null
                                 ? bslot.ActivatorBuilding.buildingName + ":" + bslot.ActivatorBuilding.Level
                                 : "-")) : "")
                        .Append(");");
                }
                // Prove the gate merge is (or isn't) finding slots.
                skip.Append($"[[gateBuilds={gateBuilds.Count}]]");
                if (skip.Length > 0)
                    Plugin.Log?.LogInfo($"[bot] mil/wall slot state: {skip}");
            }
            // Approach-commit hysteresis: two same-name slots scoring within
            // ~35% flip-flopped the pick every tick — the hero orbited
            // between Defense Towers for 150 s paying each once and never
            // finishing any (Durststein). While walking, keep the committed
            // slot unless the new argmax CLEARLY beats it or the commit went
            // stale/invalid.
            if (HeldBuildRef != null)
            {
                CommittedBuildRef = null;      // a live hold supersedes
            }
            // Effective order pin for the NEXT tick: first open category that
            // had at least one live candidate this scan.
            var oo = OpenBuildOrder();
            firstOpenPresent = null;
            for (int oi = 0; oi < oo.Length; oi++)
                if (catsPresent.Contains(oo[oi])) { firstOpenPresent = oo[oi]; break; }
            if (s.NearestBuild != null && CommittedBuildRef != null &&
                effTier < 2 &&
                !ReferenceEquals(s.NearestBuild, CommittedBuildRef) &&
                commitCandScore > int.MinValue &&
                nowT - CommittedBuildAt < 25f &&
                bestBuildScore <= commitCandScore * 1.35f + 60)
            {
                s.NearestBuild = CommittedBuildRef;
                s.NearestBuildDist = commitCandDist;
                s.NearestBuildScore = commitCandScore;
            }
            else if (s.NearestBuild != null &&
                !ReferenceEquals(s.NearestBuild, CommittedBuildRef))
            {
                CommittedBuildRef = s.NearestBuild;
                CommittedBuildAt = nowT;
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
            // TagManager flicker grace: playerBuildingInteractors goes EMPTY
            // for whole tick runs mid-hold (inter=0 flicker) — the pick then
            // drops, SpendGold is skipped, hero-door walks the hero off, and
            // the distance guard releases the fill (hold/release thrash at
            // Mill, live run). Carry the last pick forward for 1.5 s while
            // the hero is still within hold range of it.
            if (s.NearestBuild == null && lastBuildPick != null &&
                Time.unscaledTime - lastBuildPickAt < 1.5f &&
                (lastBuildPick.transform.position - s.HeroPos).sqrMagnitude <= 196f)
            {
                s.NearestBuild = lastBuildPick;
                s.NearestBuildPos = lastBuildPick.transform.position;
                s.NearestBuildDist = FlatDist(s.NearestBuildPos, s.HeroPos);
                s.NearestBuildKey = lastBuildPick.GetInstanceID();
                s.NearestBuildHarvest = lastBuildPick.canBeHarvested;
                s.NearestBuildName = lastBuildPick.targetBuilding != null
                    ? lastBuildPick.targetBuilding.buildingName : lastBuildPick.name;
                s.BuildCount++;
            }
            else if (s.NearestBuild != null)
            {
                lastBuildPick = s.NearestBuild;
                lastBuildPickAt = Time.unscaledTime;
            }

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
            return doorBreach[d] ? Mathf.Max(baseSz, Mathf.Min(baseSz * 2, 6)) : baseSz;
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
                doorBreach = null; doorUnit = null; doorParked = null;
                // Claims/parks/breaches are per-scene state — a same-count
                // corridor layout must not inherit the previous map's marks
                // (audit: new scene kept 5-min door parks and breach-doubled
                // targets because the realloc only ran on length change).
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
                        // perimeter anchor ~door_distance_m out (outer line —
                        // squads meet the wave early, not at the doorstep;
                        // was hard-coded 40 m, now playbook-tunable)
                        bool added = false;
                        float dd = Strat.DoorDist * Strat.DoorDist;
                        for (int i = r.wp.Length - 1; i >= 0; i--)
                        {
                            float dx = r.wp[i][0] - last[0], dz = r.wp[i][1] - last[1];
                            if (dx * dx + dz * dz >= dd)
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
            // Always rebuild on scene change (nulls above) OR length change —
            // never carry per-door marks into a fresh scene.
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





