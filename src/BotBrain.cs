using System;
using System.Collections.Generic;

namespace ThronefallTrainer
{
    // =========================================================================
    // PURE LAYER — v3 design §3.1. No UnityEngine, no .instance, no Time.
    // Compiled directly into the netstandard2.0 replay-test project; everything
    // here must stay pure (bot-lint enforces the forbidden-token list).
    //
    //   SnapshotData  : every value the FSM reads, positions as Vec2 (x,z)
    //   BotMemory     : the state that used to be carried statics in Bot.cs
    //   DecideResult  : Mode + AimPos + Intents + Notes — Tick executes it
    //   Intent        : closed set of world-side actions (Tick maps to refs)
    // =========================================================================

    internal struct Vec2
    {
        public float X, Z;
        public Vec2(float x, float z) { X = x; Z = z; }
        public static readonly Vec2 Zero = new Vec2(0f, 0f);

        public float Mag { get { return (float)Math.Sqrt(X * X + Z * Z); } }
        public float SqrMag { get { return X * X + Z * Z; } }
        public Vec2 Norm
        {
            get
            {
                float m = Mag;
                return m > 1e-5f ? new Vec2(X / m, Z / m) : Zero;
            }
        }

        public static Vec2 operator +(Vec2 a, Vec2 b) { return new Vec2(a.X + b.X, a.Z + b.Z); }
        public static Vec2 operator -(Vec2 a, Vec2 b) { return new Vec2(a.X - b.X, a.Z - b.Z); }
        public static Vec2 operator *(Vec2 a, float k) { return new Vec2(a.X * k, a.Z * k); }
        public static Vec2 Perp(Vec2 a) { return new Vec2(-a.Z, a.X); }
        public static float Dist(Vec2 a, Vec2 b) { return (a - b).Mag; }

        /// <summary>Stand-off point `off` metres toward `from` (hero side).</summary>
        public static Vec2 StandOff(Vec2 point, Vec2 from, float off)
        {
            Vec2 d = from - point;
            return d.SqrMag < 0.01f ? point : point + d.Norm * off;
        }
    }

    internal enum IntentKind
    {
        None,
        BeginHold,        // Focus + InteractionBegin + hold on the picked slot
        ReleaseHold,      // InteractionEnd on the held slot
        PumpHold,         // InteractionHold on the held slot
        ParkSlot,         // ignore the picked slot for the rest of the day
        PumpAttack,       // TryToAttack() (legit) — Tick chooses impl
        CommandArmy,      // select-all allied units (phase 0)
        PlaceArmy,        // place + hold at anchor (phase 2)
        HornInteract,     // Nighthorn InteractionBegin
        SwitchNight,      // DayNightCycle.SwitchToNight()
        SeedLoadout,      // fixedLoadout / best-unlocked-weapon seeding
        TransitionLevel,  // SceneTransitionManager to the picked node
        InteractLevel,    // LevelInteractor.InteractionBegin — opens its frame
        PlaceSquad,       // remote-post a squad at a door anchor (holds it)
        EscortHero,       // a few free units FollowPlayer — the bodyguard
        RecallToBreach,   // red alert — all units converge on the threat
        ClearCoinPark,    // drop the parked-coin set (day edge)
    }

    internal struct Intent
    {
        public IntentKind Kind;
        public int Index;
        public bool CheatOnly;
        public static Intent Of(IntentKind k) { return new Intent { Kind = k, Index = -1 }; }
        public static Intent At(IntentKind k, int i) { return new Intent { Kind = k, Index = i }; }
        public static Intent Cheat(IntentKind k) { return new Intent { Kind = k, Index = -1, CheatOnly = true }; }
    }

    /// <summary>
    /// Value-only mirror of the perception snapshot — the part Decide is
    /// allowed to see. Positions are Vec2 (x,z); heights drop away since the
    /// FSM never uses y. Strings are fine (netstandard2.0-safe).
    /// </summary>
    internal struct SnapshotData
    {
        public bool Valid;
        public string GameState;
        public string SceneName;

        public Vec2 HeroPos;
        public float HeroHpPct;
        public bool HeroDead;
        public int Balance;
        public int CoreBalance;

        public bool IsNight;
        public float DayTimeLeft;
        public int Wave;
        public int WaveTotal;
        public int EnemyCount;

        public bool HasCoin;
        public Vec2 CoinPos;
        public float CoinDist;
        public int CoinCount;

        public bool HasNearEnemy;
        public Vec2 NearEnemyPos;
        public float NearEnemyDist;
        public int NearFoeCount;        // foes within 8 m of the hero

        public bool HasCastle;
        public Vec2 CastlePos;
        public float CastleDist;

        public bool HasCastleThreat;
        public Vec2 CastleThreatPos;
        public float CastleThreatDist;

        public bool HasThreatAnchor;
        public Vec2 ThreatAnchor;
        public bool HasArmyAnchor;
        public Vec2 ArmyAnchor;
        public string ArmyAnchorLine;
        public int DoorCount;
        public int DoorsCovered;
        public int FreeUnits;
        public bool HasUncoveredDoor;
        public Vec2 UncoveredDoorPos;
        public string UncoveredDoorLine;
        public int UncoveredDoorTarget;
        public bool UncoveredDoorHot;
        public int ArmyTarget;
        public float SelfDefendRange;   // hero self-defense radius (posture)
        public float DayBudget;         // learned day length before horn
        public bool RedAlert;
        public float RedAlertRadius;

        public bool OnLevelSelect;
        public int InteractorCount;
        public int LevelCount;
        public bool HasLevel;
        public Vec2 LevelPos;
        public float LevelDist;
        public bool SceneBusy;          // sceneTransitionIsRunning

        public bool HasHorn;
        public Vec2 HornPos;
        public float HornDist;

        public int BuildCount;          // interactable slots this scan
        public bool HasBuild;           // best-scoring slot exists
        public int BuildKey;            // instance id — held-slot matching
        public string BuildName;
        public Vec2 BuildPos;
        public float BuildDist;
        public int BuildScore;
        public bool BuildHarvest;

        public int AllyCount;
        public Vec2 AllyCentroid;
        public bool CanCommand;         // CommandUnits.instance present
        public bool CanSwitch;          // DayNightCycle.Instance present

        // Weapon state (P6): perception reads WeaponEquipper so the pure
        // layer knows the armed range without holding a ManualAttack ref.
        public bool HasWeapon;
        public float ActiveRange;
        public bool ActiveFiresMoving;

        // ---- Phase 1 awareness (design §P1/P3/P4/P5/P7) ----
        public int NextWaveCount;
        public int NextWaveElites;
        public float NextWaveMaxHp;
        public float NextWaveSpeed;
        public float NextWaveFoeRange;
        public int NextWaveGold;
        public bool FinalWaveNext;

        public float NearEnemyRange;
        public float NearEnemyHp;
        public bool NearEnemyElite;

        public float CastleHpPct;      // -1 unknown
        public bool WaveBeforeFinalNext;

        public int ShrineCount;
        public Vec2 ShrinePos;
        public float ShrineDist;

        public int BuildMil;
        public int BuildInc;

        // extracted terrain stand-points (agent/slots/<scene>.json)
        public bool HasBuildStand;
        public Vec2 BuildStandPos;
        public float BuildStandDist;
        public bool HasCastleStand;
        public Vec2 CastleStandPos;

        /// <summary>
        /// Compact-DTO serialization for ticks.jsonl — every Decide input,
        /// so a recorded tick replays the full snapshot faithfully. Keys are
        /// ≤4 chars; positions are [x,z] pairs. Writer + replay share this.
        /// </summary>
        public string ToJson(string note, float t, BotMode mode)
        {
            var ci = System.Globalization.CultureInfo.InvariantCulture;
            var sb = new System.Text.StringBuilder(420);
            sb.Append("{\"t\":").Append(t.ToString("0.00", ci))
              .Append(",\"mode\":\"").Append(mode).Append("\"")
              .Append(",\"state\":\"").Append(GameState).Append("\"")
              .Append(",\"scene\":\"").Append(SceneName).Append("\"")
              .Append(",\"night\":").Append(IsNight ? "true" : "false")
              .Append(",\"wave\":\"").Append(Wave).Append('/').Append(WaveTotal).Append("\"")
              .Append(",\"foes\":").Append(EnemyCount)
              .Append(",\"coins\":").Append(CoinCount)
              .Append(",\"gold\":").Append(Balance)
              .Append(",\"hp\":").Append(HeroHpPct.ToString("0.###", ci))
              .Append(",\"pos\":[").Append(HeroPos.X.ToString("0.#", ci))
              .Append(',').Append(HeroPos.Z.ToString("0.#", ci)).Append(']')
              .Append(",\"note\":\"").Append(note).Append('\"');

            Append(sb, ",\"dead\":", HeroDead);
            Append(sb, ",\"cbal\":", CoreBalance);
            Append(sb, ",\"dtl\":", DayTimeLeft, ci);
            Append(sb, ",\"cpos\":", CoinPos, HasCoin, ci);
            Append(sb, ",\"cd\":", CoinDist, ci);
            Append(sb, ",\"epos\":", NearEnemyPos, HasNearEnemy, ci);
            Append(sb, ",\"ed\":", NearEnemyDist, ci);
            Append(sb, ",\"nf\":", NearFoeCount);
            Append(sb, ",\"cast\":", CastlePos, HasCastle, ci);
            Append(sb, ",\"cad\":", CastleDist, ci);
            Append(sb, ",\"cthp\":", CastleThreatPos, HasCastleThreat, ci);
            Append(sb, ",\"cthd\":", CastleThreatDist, ci);
            Append(sb, ",\"ta\":", ThreatAnchor, HasThreatAnchor, ci);
            Append(sb, ",\"ls\":", OnLevelSelect);
            Append(sb, ",\"inter\":", InteractorCount);
            Append(sb, ",\"lvln\":", LevelCount);
            Append(sb, ",\"lvlp\":", LevelPos, HasLevel, ci);
            Append(sb, ",\"lvld\":", LevelDist, ci);
            Append(sb, ",\"busy\":", SceneBusy);
            Append(sb, ",\"hpos\":", HornPos, HasHorn, ci);
            Append(sb, ",\"hd\":", HornDist, ci);
            Append(sb, ",\"bld\":", BuildCount);
            Append(sb, ",\"bldk\":", BuildKey);
            sb.Append(",\"bn\":\"").Append(BuildName ?? "").Append('\"');
            Append(sb, ",\"bpos\":", BuildPos, HasBuild, ci);
            Append(sb, ",\"bd\":", BuildDist, ci);
            Append(sb, ",\"bsc\":", BuildScore);
            Append(sb, ",\"bharv\":", BuildHarvest);
            Append(sb, ",\"ally\":", AllyCount);
            Append(sb, ",\"free\":", FreeUnits);
            Append(sb, ",\"drc\":", DoorsCovered);
            Append(sb, ",\"drn\":", DoorCount);
            Append(sb, ",\"ra\":", RedAlert);
            Append(sb, ",\"at\":", ArmyTarget);
            Append(sb, ",\"hot\":", UncoveredDoorHot);
            Append(sb, ",\"dbg\":", DayBudget, ci);
            Append(sb, ",\"acen\":", AllyCentroid, AllyCount > 0, ci);
            Append(sb, ",\"cmd\":", CanCommand);
            Append(sb, ",\"csw\":", CanSwitch);
            Append(sb, ",\"weap\":", HasWeapon);
            Append(sb, ",\"wrng\":", ActiveRange, ci);
            Append(sb, ",\"wfm\":", ActiveFiresMoving);
            Append(sb, ",\"nwc\":", NextWaveCount);
            Append(sb, ",\"nwe\":", NextWaveElites);
            Append(sb, ",\"nwh\":", NextWaveMaxHp, ci);
            Append(sb, ",\"nws\":", NextWaveSpeed, ci);
            Append(sb, ",\"nwr\":", NextWaveFoeRange, ci);
            Append(sb, ",\"nwg\":", NextWaveGold);
            Append(sb, ",\"fw\":", FinalWaveNext);
            Append(sb, ",\"erng\":", NearEnemyRange, ci);
            Append(sb, ",\"ehp\":", NearEnemyHp, ci);
            Append(sb, ",\"eel\":", NearEnemyElite);
            Append(sb, ",\"chp\":", CastleHpPct, ci);
            Append(sb, ",\"wbf\":", WaveBeforeFinalNext);
            Append(sb, ",\"shr\":", ShrineCount);
            Append(sb, ",\"shp\":", ShrinePos, ShrineCount > 0, ci);
            Append(sb, ",\"shd\":", ShrineDist, ci);
            Append(sb, ",\"bmil\":", BuildMil);
            Append(sb, ",\"binc\":", BuildInc);
            Append(sb, ",\"bst\":", HasBuildStand);
            Append(sb, ",\"bsp\":", BuildStandPos, HasBuildStand, ci);
            Append(sb, ",\"bsd\":", BuildStandDist, ci);
            Append(sb, ",\"cst\":", HasCastleStand);
            Append(sb, ",\"csp\":", CastleStandPos, HasCastleStand, ci);
            return sb.Append('}').ToString();
        }

        static void Append(System.Text.StringBuilder sb, string key, bool v)
        { sb.Append(key).Append(v ? "true" : "false"); }
        static void Append(System.Text.StringBuilder sb, string key, int v)
        { sb.Append(key).Append(v); }
        static void Append(System.Text.StringBuilder sb, string key, float v, System.Globalization.CultureInfo ci)
        { sb.Append(key).Append(v.ToString("0.###", ci)); }
        static void Append(System.Text.StringBuilder sb, string key, Vec2 p,
            bool present, System.Globalization.CultureInfo ci)
        {
            sb.Append(key);
            if (!present) { sb.Append("null"); return; }
            sb.Append('[').Append(p.X.ToString("0.#", ci))
              .Append(',').Append(p.Z.ToString("0.#", ci)).Append(']');
        }
    }

    /// <summary>
    /// Everything the FSM used to carry in file-level statics. Tick owns one
    /// instance and passes it by ref — the memory is serializable in principle
    /// (all plain values).
    /// </summary>
    internal struct BotMemory
    {
        public BotMode Mode;

        // held-build interaction
        public int HeldBuild;           // BuildKey of the held slot, -1 none
        public float BuildInteractAt;
        public int SpendWatchGold;
        public int SpendWatchCores;
        public float SpendWatchAt;
        public float NextHoldNoteAt;

        // day/night edge + single-shot request clocks
        public bool LastNightState;
        public float NightRequestAt;
        public float HornInteractAt;
        public float LevelInteractAt;

        // army two-step
        public int ArmyPhase;
        public float ArmyWalkAt;
        public float LastSquadAt;
        public float LastBreachAt;
        public float DayStartAt;
        public string DayScene;
        public int PrevWave;         // wave-rollover detects same-scene retries
        public float SquadWalkAt;
        public float LastEscortAt;

        // visit-abandon: stood at a picked slot 10 s with no pay -> park it
        public int SlotVisitKey;
        public float SlotVisitSince;

        // level-select transition hang detector
        public float BusySince;
        public float LastArmyCmdAt;   // solver: night re-command cadence

        // orbit-kite sweep
        public float OrbitAngle;
        public float OrbitDir;
        public float LastOrbitAt;

        // which foe the pursue flag resolved to last decide (0 threat/1 near)
        public int Pursue;

        /// <summary>Defaults that aren't the struct zero — call once at init.</summary>
        public static BotMemory Fresh()
        {
            return new BotMemory
            {
                Mode = BotMode.Idle,
                HeldBuild = -1,
            BusySince = -1f,
            SlotVisitKey = -1,
                OrbitDir = 1f,
                LastNightState = true,   // assume night so the first day-edge fires cleanly
                ArmyPhase = 0,
            };
        }
    }

    internal struct DecideResult
    {
        public BotMode Mode;
        public Vec2 AimPos;
        public bool HasAim;
        public float Arrive;
        public bool ProjectToNav;   // Tick projects AimPos onto the navmesh
        public int Pursue;          // 0 none · 1 castle-threat · 2 nearest-hero
        public List<Intent> Intents;
        public List<string> Notes;
        public List<string> RulesFired;
    }

    // =========================================================================
    // Phase 2: bounded policy table (design §P9). A hot-loadable line-DSL of
    //   knob NAME = VALUE
    //   id | FIELD OP V -> NAME = VALUE
    // rules — evaluated each Decide against SnapshotData fields via reflection.
    // Bounds: ≤32 rules, known fields only, |value| ≤ 1e6, knob names ≤ 24
    // chars, no code execution — a policy can only retune numbers the FSM
    // already reads. Last-good table wins on any validation error.
    // =========================================================================

    internal struct PolicyRule
    {
        public string Id;
        public string Field;   // SnapshotData field name
        public string Op;      // > >= < <= == !=
        public float Value;
        public string Knob;
        public float Set;
    }

    internal struct PolicyTable
    {
        public Dictionary<string, float> knobs;
        public List<PolicyRule> rules;
        public int Version;         // bumped on every successful load
        public List<string> firedIds;   // rule ids that fired this Resolve

        public static PolicyTable Default()
        {
            return new PolicyTable
            {
                Version = 0,
                knobs = new Dictionary<string, float>
                {
                    ["coin_seek"] = 80f,
                    ["coin_seek_big"] = 40f,     // big/final-wave day coin range
                    ["big_wave_nwc"] = 30f,      // "big wave" NextWaveCount gate
                    ["kite_r_min"] = 9f,
                    ["kite_r_max"] = 14f,
                    ["kite_foe_pad"] = 2f,       // orbit radius = foe range + this
                    ["pull_near"] = 4.5f,        // deep-pull when foe closer than this
                    ["pull_foe_pad"] = 1f,       // or inside its attack range + this
                    ["pull_swarm"] = 2f,         // or this many foes within 8 m
                    ["retreat_hp"] = 0.5f,       // hurt-hero retreat threshold
                    ["orbit_spin"] = 0.7f,
                    ["orbit_arc"] = 1.9f,
                    ["home_radius"] = 14f,
                    ["army_anchor"] = 11f,
                    ["melee_pull"] = 5f,
                },
                rules = new List<PolicyRule>(),
            };
        }

        /// <summary>Knob value — rules may have overlaid the base.</summary>
        public float K(string name)
        {
            float v;
            return knobs != null && knobs.TryGetValue(name, out v) ? v : 0f;
        }

        /// <summary>
        /// Evaluate rules against the snapshot and return a copy with hits
        /// folded into knobs — the base table stays untouched (Dictionary is
        /// a reference type; a plain Apply would permanently clobber bases).
        /// </summary>
        public PolicyTable Resolved(in SnapshotData s)
        {
            var t = this;
            t.firedIds = new List<string>();
            if (rules == null || rules.Count == 0) return t;
            t.knobs = new Dictionary<string, float>(knobs);
            var ty = typeof(SnapshotData);
            foreach (var r in rules)
            {
                var f = ty.GetField(r.Field);
                if (f == null) continue;
                object o = f.GetValue(s);
                float cur = o is bool ? ((bool)o ? 1f : 0f) : Convert.ToSingle(o);
                if (Cmp(cur, r.Op, r.Value))
                {
                    t.knobs[r.Knob] = r.Set;
                    if (!t.firedIds.Contains(r.Id)) t.firedIds.Add(r.Id);
                }
            }
            return t;
        }

        static bool Cmp(float a, string op, float b)
        {
            switch (op)
            {
                case ">": return a > b;
                case ">=": return a >= b;
                case "<": return a < b;
                case "<=": return a <= b;
                case "==": return Math.Abs(a - b) < 1e-6f;
                case "!=": return Math.Abs(a - b) >= 1e-6f;
                default: return false;
            }
        }

        /// <summary>
        /// Parse + validate a policy file. Returns false (and fills errors)
        /// when ANY line is invalid — callers keep the last-good table.
        /// </summary>
        public static bool Parse(string text, ref PolicyTable table, out List<string> errors)
        {
            errors = new List<string>();
            var t = Default();
            t.Version = table.Version + 1;
            var fields = new HashSet<string>(
                Array.ConvertAll(typeof(SnapshotData).GetFields(), x => x.Name));
            int n = 0;
            foreach (var raw in text.Split('\n'))
            {
                var line = raw.Trim();
                if (line.Length == 0 || line.StartsWith("#")) continue;
                n++;
                if (line.StartsWith("knob "))
                {
                    var p = line.Substring(5).Split('=');
                    if (p.Length != 2 || !IsKnob(p[0].Trim()) || !float.TryParse(p[1].Trim(),
                        System.Globalization.NumberStyles.Float,
                        System.Globalization.CultureInfo.InvariantCulture, out float v))
                        errors.Add($"line {n}: bad knob '{line}'");
                    else t.knobs[p[0].Trim()] = v;
                    continue;
                }
                // id | FIELD OP V -> KNOB = V
                var arrow = line.IndexOf("->", StringComparison.Ordinal);
                var bar = line.IndexOf('|');
                if (bar <= 0 || arrow <= bar) { errors.Add($"line {n}: expected 'id | FIELD op v -> knob = v'"); continue; }
                string id = line.Substring(0, bar).Trim();
                string cond = line.Substring(bar + 1, arrow - bar - 1).Trim();
                string eff = line.Substring(arrow + 2).Trim();
                var cp = cond.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                var ep = eff.Split('=');
                if (id.Length == 0 || id.Length > 32)
                    errors.Add($"line {n}: bad rule id");
                else if (t.rules.Count >= 32)
                    errors.Add($"line {n}: rule limit 32");
                else if (cp.Length != 3 || !fields.Contains(cp[0]) ||
                         !(cp[1] == ">" || cp[1] == ">=" || cp[1] == "<" || cp[1] == "<=" || cp[1] == "==" || cp[1] == "!=") ||
                         !float.TryParse(cp[2], System.Globalization.NumberStyles.Float,
                             System.Globalization.CultureInfo.InvariantCulture, out float cv) ||
                         Math.Abs(cv) > 1e6f)
                    errors.Add($"line {n}: bad condition '{cond}'");
                else if (ep.Length != 2 || !IsKnob(ep[0].Trim()) ||
                         !float.TryParse(ep[1].Trim(), System.Globalization.NumberStyles.Float,
                             System.Globalization.CultureInfo.InvariantCulture, out float sv) ||
                         Math.Abs(sv) > 1e6f)
                    errors.Add($"line {n}: bad effect '{eff}'");
                else
                    t.rules.Add(new PolicyRule { Id = id, Field = cp[0], Op = cp[1], Value = cv, Knob = ep[0].Trim(), Set = sv });
            }
            if (errors.Count > 0) return false;
            table = t;
            return true;
        }

        static bool IsKnob(string k)
        {
            if (k.Length == 0 || k.Length > 24) return false;
            foreach (char c in k)
                if (!(char.IsLetterOrDigit(c) || c == '_')) return false;
            return true;
        }
    }

    internal static class BotBrain
    {
        // Geometry constants mirrored from Bot.cs (kept identical by contract).
        const float ArriveCoin = 0.6f;
        const float ArriveHold = 2.5f;

        /// <summary>
        /// The full FSM, ported pure: reads SnapshotData + BotMemory only,
        /// returns Mode/AimPos/Intents/Notes. Every world-side call the old
        //  Decide made inline is now an Intent the Tick executes against refs.
        /// </summary>
        public static DecideResult Decide(in SnapshotData s, ref BotMemory m, float now, bool legit, in PolicyTable pol)
        {
            var r = new DecideResult
            {
                Mode = m.Mode,
                Intents = new List<Intent>(),
                Notes = new List<string>(),
                RulesFired = pol.firedIds ?? new List<string>(),
            };

            // Held-build release guard (used to be ReleaseBuild() inline).
            // Release only on a REAL invalidation — not a 4 m drift that can
            // happen mid-fill, and not "far from slot origin" while parked at
            // its stand-point. Every release refunds paid coins.
            if (m.HeldBuild >= 0 && (m.Mode != BotMode.SpendGold ||
                !s.HasBuild || s.BuildKey != m.HeldBuild ||
                (s.BuildDist > 5.5f && !(s.HasBuildStand && s.BuildStandDist <= 3f))))
            {
                r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                m.HeldBuild = -1;
            }

            // Scene/retry change resets the day clock — after a defeat-retry
            // DayStartAt was still ancient, so the budget read as instantly
            // expired and night was called with zero army (ally=0, wave 1).
            // Wave rollover catches the same-scene retry the scene check
            // misses: any new match starts at wave -1/0 — if the previous
            // wave was deeper, this is a fresh match, reset the clock.
            bool newMatch = m.DayScene != s.SceneName ||
                            (s.Wave <= 0 && m.PrevWave > 0) ||
                            (m.DayStartAt <= 0f);
            if (newMatch)
            {
                m.DayScene = s.SceneName;
                m.DayStartAt = now;
                m.NightRequestAt = 0f;
            }
            m.PrevWave = s.Wave;

            // Day/night edge → re-arm night request + army + coin park.
            if (m.LastNightState != s.IsNight)
            {
                m.NightRequestAt = 0f;
                m.LastNightState = s.IsNight;
                if (!s.IsNight) { m.ArmyPhase = 0; m.DayStartAt = now; r.Intents.Add(Intent.Of(IntentKind.ClearCoinPark)); }
            }

            // ---- campaign map: enter a level ----
            // The map hero never needs to walk to the node — the game's own
            // flow is click-node → level-select frame → Start button, and
            // TransitionFromLevelSelectToLevel IS that button. Walking the
            // map was an artificial requirement that wedged the hero on map
            // colliders for entire sessions.
            if (s.HasLevel)
            {
                m.Mode = BotMode.EnterLevel; r.Mode = m.Mode;
                r.HasAim = false;   // stand still on the map
                if (!s.SceneBusy) m.BusySince = -1f;
                else if (m.BusySince < 0f) m.BusySince = now;
                // sceneTransitionIsRunning hung (cloud coroutine never
                // finished, or currentSceneState drifted) — after 30 s open
                // the node's level-select frame for real; the frame resolver
                // clicks its Start button.
                bool busyHung = m.BusySince >= 0f && now - m.BusySince > 30f;
                if (now >= m.LevelInteractAt && (!s.SceneBusy || busyHung))
                {
                    m.LevelInteractAt = now + 2f;
                    r.Notes.Add("level-interact");
                    r.Intents.Add(Intent.Of(IntentKind.SeedLoadout));
                    if (busyHung) { r.Intents.Add(Intent.Of(IntentKind.InteractLevel)); r.Notes.Add("busy-hung"); }
                    else r.Intents.Add(Intent.Of(IntentKind.TransitionLevel));
                    r.Notes.Add("transition-level");
                }
                return r;
            }

            // ---- dead hero ----
            if (s.HeroDead || s.HeroHpPct <= 0f)
            {
                m.Mode = BotMode.HeroDead; r.Mode = m.Mode;
                if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; }
                // Drift to the keep's extracted stand-point (a proven free
                // cell); CastlePos itself is inside the keep collider.
                if (s.HasCastleStand) Aim(ref r, s.CastleStandPos, ArriveHold);
                else if (s.HasCastle) Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 4f), ArriveHold);
                else r.HasAim = false;
                return r;
            }

            // ---- safe night coin-run (wider range at night — foes are held
            // at the doors by squads, so the field is safer to scavenge) ----
            if (s.IsNight && s.NearFoeCount == 0
                && (!s.HasNearEnemy || s.NearEnemyDist > 12f)
                && s.HasCoin && s.CoinDist <= pol.K("coin_seek") * 1.5f)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            if (s.IsNight)
            {
                // Hot-door posting at NIGHT: a corridor under attack that's
                // uncovered gets whatever free units exist (≥2), not the
                // day-time 4-unit minimum — better a thin squad than a leak.
                if (legit && s.HasUncoveredDoor && s.UncoveredDoorHot &&
                    s.FreeUnits >= 2 && now - m.LastSquadAt > 6f)
                {
                    m.LastSquadAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
                }
                // Proactive night posting: quiet corridors still get manned —
                // squads stand at their posts BEFORE the next wave leaks.
                else if (legit && s.HasUncoveredDoor && !s.RedAlert &&
                         s.FreeUnits >= s.UncoveredDoorTarget &&
                         now - m.LastSquadAt > 4f)
                {
                    m.LastSquadAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-post:" + s.UncoveredDoorLine);
                }

                // RED ALERT: an enemy is inside the building ring — the ARMY
                // converges on the breach; the hero only fights when there's
                // nobody to send or he's personally under attack.
                if (s.RedAlert && s.HasThreatAnchor)
                {
                    if (s.AllyCount > 0 && now - m.LastBreachAt > 8f)
                    {
                        m.LastBreachAt = now;
                        r.Intents.Add(Intent.Of(IntentKind.RecallToBreach));
                        r.Notes.Add("breach-response");
                    }
                    // Sissy rule: the hero NEVER substitutes for an army —
                    // with zero troops he holds at the castle and lets the
                    // walls/towers work. Fighting solo is how he keeps dying.
                    // He only fights what's already ON him.
                    bool heroMust = (s.HasNearEnemy && s.NearEnemyDist <=
                            (s.SelfDefendRange > 0f ? s.SelfDefendRange : 7f))
                        || s.NearFoeCount >= 2;
                    if (heroMust)
                    {
                        m.Mode = BotMode.Engage; r.Mode = m.Mode;
                        m.Pursue = r.Pursue = 1;
                        Aim(ref r, s.ThreatAnchor, 1.5f);
                        r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
                        r.Notes.Add("red-alert");
                    }
                    else
                    {
                        // Sissy hold: far side of the castle while the
                        // converging squads do the fighting.
                        m.Mode = BotMode.HoldCastle; r.Mode = m.Mode;
                        Vec2 away = s.CastlePos - s.ThreatAnchor;
                        Vec2 safe = away.SqrMag > 0.01f ? s.CastlePos + away.Norm * 5f : s.CastlePos;
                        Aim(ref r, s.HasCastleStand ? s.CastleStandPos : safe, ArriveHold);
                        r.Notes.Add("red-hold");
                    }
                    return r;
                }

                bool hasThreat = s.HasCastleThreat || s.HasNearEnemy;
                Vec2 threatPos = s.HasCastleThreat ? s.CastleThreatPos : s.NearEnemyPos;
                Vec2 axisDir = s.HasThreatAnchor ? s.ThreatAnchor - s.CastlePos : Vec2.Zero;

                // Sissy posture: only fight when the enemy is practically ON
                // him — everything else is the squads'/towers' job.
                bool mustFight = s.HasNearEnemy &&
                    s.NearEnemyDist <= (s.SelfDefendRange > 0f ? s.SelfDefendRange : 7f)
                    || s.NearFoeCount >= 2;

                if (mustFight)
                {
                    // Legit retreat: badly hurt hero pulls behind the castle.
                    if (legit && s.HeroHpPct < pol.K("retreat_hp") && s.HasCastle)
                    {
                        m.Mode = BotMode.ReturnHome; r.Mode = m.Mode;
                        m.Pursue = r.Pursue = s.HasCastleThreat ? 1 : 2;
                        Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 3f), ArriveHold);
                        r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
                        return r;
                    }
                    m.Mode = BotMode.Engage; r.Mode = m.Mode;
                    bool urgent = s.CastleThreatDist > 0f && s.CastleThreatDist < 20f;
                    m.Pursue = r.Pursue = (urgent || !s.HasNearEnemy) ? 1 : 2;
                    bool ranged = s.ActiveRange >= 6f;
                    float heroNear = s.HasNearEnemy ? s.NearEnemyDist : float.MaxValue;

                    if (ranged && s.HasCastle)
                    {
                        // A foe inside its own attack range (or a pile
                        // forming) pulls him deep — ranged foes trigger this
                        // earlier than melee reach.
                        float tooNear = Math.Max(pol.K("pull_near"), s.NearEnemyRange + pol.K("pull_foe_pad"));
                        if (heroNear < tooNear || s.NearFoeCount >= (int)pol.K("pull_swarm"))
                        {
                            Vec2 away = s.CastlePos - s.NearEnemyPos;
                            Aim(ref r, s.CastlePos + away.Norm * 4f, 1.2f);
                        }
                        else
                        {
                            // perpetual orbit on the defended-side arc
                            float dt = m.LastOrbitAt > 0f ? now - m.LastOrbitAt : 0.25f;
                            m.LastOrbitAt = now;
                            m.OrbitAngle += pol.K("orbit_spin") * m.OrbitDir * dt;
                            float arc = pol.K("orbit_arc");
                            if (m.OrbitAngle > arc) { m.OrbitAngle = arc; m.OrbitDir = -1f; }
                            else if (m.OrbitAngle < -arc) { m.OrbitAngle = -arc; m.OrbitDir = 1f; }
                            Vec2 fwd = axisDir.SqrMag > 0.01f ? axisDir.Norm : new Vec2(0f, 1f);
                            Vec2 oc = s.CastlePos - fwd * 3f;
                            // P3: the orbit radius outranges the THREAT's own
                            // attack range +2 m — a ranged foe forces a wider
                            // arc, melee-only threats keep the tight one.
                            float rr = Clamp(Math.Max(s.ActiveRange * 0.3f,
                                s.NearEnemyRange + pol.K("kite_foe_pad")), pol.K("kite_r_min"), pol.K("kite_r_max"));
                            Vec2 ring = oc + (fwd * -(float)Math.Cos(m.OrbitAngle) +
                                              Vec2.Perp(fwd) * (float)Math.Sin(m.OrbitAngle)) * rr;
                            Aim(ref r, ring, 1.5f);
                            r.ProjectToNav = true;
                        }
                    }
                    else
                    {
                        // melee hit-and-run
                        if (s.NearFoeCount >= 3 || heroNear < 1.8f)
                        {
                            Vec2 away = s.HeroPos - s.NearEnemyPos;
                            if (away.SqrMag < 0.01f) away = s.HeroPos - threatPos;
                            Vec2 toC = s.HasCastle ? s.CastlePos - s.HeroPos : Vec2.Zero;
                            Vec2 pull = (away.Norm * 0.7f + toC.Norm * 0.3f).Norm;
                            Aim(ref r, s.HeroPos + pull * pol.K("melee_pull"), 1.2f);
                        }
                        else
                        {
                            // Charge the PURSUE target (urgent castle-threat or
                            // nearest-foe), not always the castle-threat.
                            Vec2 pursuePos = m.Pursue == 2 && s.HasNearEnemy
                                ? s.NearEnemyPos : threatPos;
                            Aim(ref r, Vec2.StandOff(pursuePos, s.HeroPos, 1.2f), 1.0f);
                        }
                    }
                    r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
                    // Escort follows the hero through the fight — free units
                    // re-place at his position every 25 s (door squads stay
                    // posted; CommandArmyAll already filters them out).
                    if (s.AllyCount > 0 && s.CanCommand && now - m.LastArmyCmdAt > 25f)
                    {
                        m.LastArmyCmdAt = now;
                        r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
                        r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
                        r.Notes.Add("escort");
                    }
                }
                else if (s.HasCastle)
                {
                    m.Mode = BotMode.HoldCastle; r.Mode = m.Mode;
                    // Safe night: park ON the threatened corridor (or the
                    // hottest uncovered door) — he's the gap-filler unit.
                    if (s.HasUncoveredDoor && s.UncoveredDoorHot)
                        Aim(ref r, s.UncoveredDoorPos, ArriveHold);
                    else
                        Aim(ref r, s.HasThreatAnchor ? s.ThreatAnchor : s.CastlePos, ArriveHold);
                    // Escort follows him between fights — free units only,
                    // posted squads stay at their doors.
                    if (s.FreeUnits > 0 && s.CanCommand && now - m.LastEscortAt > 20f)
                    {
                        m.LastEscortAt = now;
                        r.Intents.Add(Intent.Of(IntentKind.EscortHero));
                        r.Notes.Add("escort-refresh");
                    }
                    // Solver: allied units wander between commands — re-issue
                    // the army command every ~60 s at night (no-op inside
                    // the game's own command cooldown).
                    // Re-command the army to the hero's CURRENT position —
                    // CommandArmy alone re-selects but leaves the banner at
                    // the old spot; units must re-place to stay with him.
                    if (s.AllyCount > 0 && s.CanCommand && now - m.LastArmyCmdAt > 60f)
                    {
                        m.LastArmyCmdAt = now;
                        r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
                        r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
                        r.Notes.Add("army-reposition");
                    }
                }
                else { m.Mode = BotMode.Idle; r.Mode = m.Mode; r.HasAim = false; }
                return r;
            }

            // ---- call the night when ready ----
            // Funded or not, an endless day is a soft-lock: there is ALWAYS a
            // buildable slot while money exists, so SpendGold would dominate
            // forever and the night would never come. Ring the horn once the
            // army is up to target OR the day budget is spent — whichever
            // readiness signal arrives first.
            if (m.DayStartAt > 0f &&
                ((s.CanSwitch &&
                  // Ready = army target met AND someone actually manning the
                  // perimeter (calling night with zero posts invites the
                  // breach we saw at t≈90: 25 foes vs a lone hero).
                  (s.AllyCount >= s.ArmyTarget && (s.DoorCount == 0 || s.DoorsCovered > 0) ||
                   (s.DoorCount > 0 && s.DoorsCovered >= s.DoorCount))) ||
                 // Budget expiry forces the night even when the horn isn't
                 // visible — SwitchToNight is the game's own call and rejects
                 // harmlessly if the day is still locked.
                 now - m.DayStartAt > (s.DayBudget > 0f ? s.DayBudget : 240f)))
            {
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; }
                if (s.HasHorn)
                {
                    Aim(ref r, s.HornPos, 2f);
                    if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
                    {
                        m.HornInteractAt = now + 2f;
                        r.Intents.Add(Intent.Of(IntentKind.HornInteract));
                        r.Notes.Add("horn-interact");
                    }
                }
                else if (!(s.SceneName != null && s.SceneName.StartsWith("_"))
                         && now >= m.NightRequestAt)
                {
                    m.NightRequestAt = now + 15f;
                    r.Notes.Add("switch-night");
                    r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
                }
                return r;
            }

            // ---- day: squads pre-stage on the perimeter ----
            // Remote posts don't need the hero — emit them alongside economy
            // work (this used to sit after SpendGold, which always returned
            // first, so squads only ever posted at night).
            if (legit)
            {
                if (s.HasUncoveredDoor &&
                    s.FreeUnits >= (s.UncoveredDoorHot ? 2 : Math.Max(4, s.UncoveredDoorTarget))
                    && now - m.LastSquadAt > 6f)
                {
                    m.LastSquadAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
                }
                if (s.FreeUnits > 0 && now - m.LastEscortAt > 20f)
                {
                    m.LastEscortAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.EscortHero));
                    r.Notes.Add("escort-refresh");
                }
            }

            // ---- day: coins ----
            // P1 use: a huge or final wave coming up tightens the seek range —
            // no long-range coin runs when the run is on the line.
            float coinRange = (s.FinalWaveNext || s.NextWaveCount >= pol.K("big_wave_nwc"))
                ? pol.K("coin_seek_big") : pol.K("coin_seek");
            // Broke: scavenge wider — the economy has to fund the war machine.
            if (s.Balance < 10f) coinRange *= 1.5f;
            if (s.HasCoin && s.CoinDist <= coinRange)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            // ---- day economy ----
            if (s.HasBuild && (s.Balance > 0 || s.BuildHarvest))
            {
                m.Mode = BotMode.SpendGold; r.Mode = m.Mode;
                // Approach the extracted stand-point when known (a proven
                // free cell beside the slot) — never a geometric stand-off
                // that may land inside the slot's collider. Hold once inside
                // the interact gate or at the stand-point.
                bool inGate = s.BuildDist <= 4f ||
                    (s.HasBuildStand && s.BuildStandDist <= 1.2f);
                if (inGate) Aim(ref r, s.HeroPos, 1.0f);
                else if (s.HasBuildStand) Aim(ref r, s.BuildStandPos, 0.8f);
                else Aim(ref r, Vec2.StandOff(s.BuildPos, s.HeroPos, 3.0f), 1.0f);

                // Visit-abandon: stood at the picked slot 10 s with no
                // payment -> the fill can't progress — park and rotate.
                if (inGate && s.BuildKey > 0)
                {
                    if (s.BuildKey != m.SlotVisitKey) { m.SlotVisitKey = s.BuildKey; m.SlotVisitSince = now; }
                    else if (now - m.SlotVisitSince >= 10f)
                    {
                        r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
                        r.Notes.Add("slot-abandon");
                        m.SlotVisitKey = -1; m.SlotVisitSince = now;
                        return r;
                    }
                }

                // Interact from the same gate as the aim — the slot origin
                // can sit 5+ m inside its own collider while the interactor
                // polygon/stand-point is within range.
                if (inGate && now >= m.BuildInteractAt)
                {
                    m.BuildInteractAt = now + 0.4f;
                    if (m.HeldBuild != s.BuildKey)
                    {
                        r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                        r.Intents.Add(Intent.Of(IntentKind.BeginHold));
                        m.HeldBuild = s.BuildKey;
                        m.SpendWatchGold = s.Balance;
                        m.SpendWatchCores = s.CoreBalance;
                        m.SpendWatchAt = now + 7f;
                    }
                    else if (s.Balance != m.SpendWatchGold || s.CoreBalance != m.SpendWatchCores)
                    {
                        // Real spend progress — mark it so events prove
                        // coins actually land (the analyzer counts these).
                        r.Notes.Add("pay");
                        m.SpendWatchGold = s.Balance;
                        m.SpendWatchCores = s.CoreBalance;
                        m.SpendWatchAt = now + 7f;
                    }
                    else if (now >= m.SpendWatchAt)
                    {
                        r.Notes.Add("build-stall");
                        r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
                        r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                        m.HeldBuild = -1;
                        return r;
                    }
                    r.Intents.Add(Intent.Of(IntentKind.PumpHold));
                    if (now >= m.NextHoldNoteAt)
                    {
                        m.NextHoldNoteAt = now + 3f;
                        r.Notes.Add("build-hold");
                    }
                }
                return r;
            }

            // ---- army placement (first anchor: the next wave's corridor) ----
            if (legit && m.ArmyPhase < 2 && s.AllyCount > 0 && s.HasCastle && s.CanCommand)
            {
                if (m.ArmyPhase == 0)
                {
                    r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
                    m.ArmyPhase = 1;
                    m.ArmyWalkAt = now + 8f;
                }
                m.Mode = BotMode.PositionArmy; r.Mode = m.Mode;
                Vec2 anchor;
                if (s.HasArmyAnchor) { anchor = s.ArmyAnchor; r.Notes.Add("army-line:" + s.ArmyAnchorLine); }
                else
                {
                    Vec2 aAxis = s.HasThreatAnchor ? s.ThreatAnchor - s.CastlePos : Vec2.Zero;
                    anchor = aAxis.SqrMag > 0.01f ? s.CastlePos + aAxis.Norm * pol.K("army_anchor") : s.CastlePos;
                }
                Aim(ref r, anchor, 3f);
                if (Vec2.Dist(s.HeroPos, anchor) <= 4f || now >= m.ArmyWalkAt)
                {
                    r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
                    m.ArmyPhase = 2;
                    r.Notes.Add("army-placed");
                }
                return r;
            }

            // ---- horn / night start ----
            // Same readiness gate as the primary night call — this block was
            // UNGATED: the horn scan fix made HasHorn true and the bot rang
            // night at t=13 with ally=0 before a single day build. Ring only
            // when the army is up or the day budget expired.
            bool readyForNight = m.DayStartAt > 0f &&
                ((s.AllyCount >= s.ArmyTarget && (s.DoorCount == 0 || s.DoorsCovered > 0)) ||
                 (s.DoorCount > 0 && s.DoorsCovered >= s.DoorCount) ||
                 now - m.DayStartAt > (s.DayBudget > 0f ? s.DayBudget : 240f));
            if (readyForNight && s.HasHorn)
            {
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                Aim(ref r, s.HornPos, 2f);
                if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
                {
                    m.HornInteractAt = now + 2f;
                    r.Intents.Add(Intent.Of(IntentKind.HornInteract));
                    r.Notes.Add("horn-interact");
                }
                return r;
            }
            // Same gate — the horn-less fallback was firing switch-night on
            // the FIRST tick of a fresh run (NightRequestAt starts at 0 →
            // now >= 0 → instant night, ally=0, wave 1 wipe). Readiness
            // required here too.
            if (readyForNight && s.CanSwitch && now >= m.NightRequestAt &&
                !(s.SceneName != null && s.SceneName.StartsWith("_")))
            {
                m.NightRequestAt = now + 15f;
                r.Notes.Add("switch-night");
                r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                return r;
            }
            // Day idle gap: nothing buildable, nothing to collect — the hero
            // IS a unit, so he gap-fills the most dangerous uncovered door
            // instead of circling the castle.
            if (s.HasUncoveredDoor)
            {
                m.Mode = BotMode.PositionArmy; r.Mode = m.Mode;
                Aim(ref r, s.UncoveredDoorPos, ArriveHold);
                r.Notes.Add("hero-door:" + (s.UncoveredDoorLine ?? ""));
                return r;
            }
            if (s.HasCastle && s.CastleDist > pol.K("home_radius"))
            {
                m.Mode = BotMode.ReturnHome; r.Mode = m.Mode;
                if (s.HasCastleStand) Aim(ref r, s.CastleStandPos, ArriveHold);
                else Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 4f), ArriveHold);
                return r;
            }
            m.Mode = BotMode.Idle; r.Mode = m.Mode;
            r.HasAim = false;
            return r;
        }

        static void Aim(ref DecideResult r, Vec2 pos, float arrive)
        {
            r.AimPos = pos; r.Arrive = arrive; r.HasAim = true;
        }

        static float Clamp(float v, float lo, float hi)
        {
            return v < lo ? lo : (v > hi ? hi : v);
        }
    }

    /// <summary>
    /// Bot mode enum — defined in the pure layer so replay tests compile
    /// without the Unity-touched Bot.cs.
    /// </summary>
    internal enum BotMode { Idle, CollectCoin, ReturnHome, HoldCastle, Engage, EnterLevel, StartNight, SpendGold, ResolveUI, PositionArmy, HeroDead }
}



