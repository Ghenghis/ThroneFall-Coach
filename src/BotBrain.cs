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
        ParkDoor,         // mark a door anchor unwalkable (Index = anchor idx)
        GateHold,         // hold-interact the nearest path-toggle pad
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
        public int BuildsLost;

        public bool HasThreatAnchor;
        public Vec2 ThreatAnchor;
        public bool HasArmyAnchor;
        public Vec2 ArmyAnchor;
        public string ArmyAnchorLine;
        public int DoorCount;
        public int DoorsCovered;
        public int DoorsParked;     // of DoorsCovered: anchors parked as unwalkable, not manned
        public int DoorsClaimed;    // of DoorsCovered: a squad is en route, nobody there yet
        public int FreeUnits;
        public bool HasUncoveredDoor;
        public Vec2 UncoveredDoorPos;
        public string UncoveredDoorLine;
        public int UncoveredDoorTarget;
        public bool UncoveredDoorHot;
        public int UncoveredDoorIdx;
        public int UncoveredDoorUnits;  // units actually manning the picked door (-1 none picked)
        public string[] OpenOrder;      // playbook build categories still open
        public int GateCount;             // interactable path-unlock pads
        public Vec2 GatePos;
        public float GateDist;
        public int ArmyTarget;
        public float SinceProg;   // seconds since the last real accomplishment (Efficiency)
        public float SelfDefendRange;   // hero self-defense radius (posture)
        public float DayBudget;         // learned day length before horn
        public bool RedAlert;
        public float RedAlertRadius;

        public bool OnLevelSelect;
        public int InteractorCount;
        public int LevelCount;
        public int CastleCount;     // multi-keep maps: >1 keeps tagged
        public bool HasLevel;
        public Vec2 LevelPos;
        public float LevelDist;
        public bool SceneBusy;          // sceneTransitionIsRunning

        public bool HasHorn;
        public Vec2 HornPos;
        public float HornDist;

        public int BuildCount;          // interactable slots this scan
        public int BlockedBuilds;       // slots skipped only because ignored/parked
        public bool HasBuild;           // best-scoring slot exists
        public int BuildKey;            // instance id — held-slot matching
        public string BuildName;
        public Vec2 BuildPos;
        public float BuildDist;
        public int BuildScore;
        public bool BuildHarvest;
        public bool HeldBuildComplete;   // held slot latched interactionComplete

        public int AllyCount;
        public Vec2 AllyCentroid;
        public bool CanCommand;         // CommandUnits.instance present
        public bool CanSwitch;          // DayNightCycle.Instance present
        public bool NightCall;          // coach advisory night-call (pure view)

        // Weapon state (P6): perception reads WeaponEquipper so the pure
        // layer knows the armed range without holding a ManualAttack ref.
        public bool HasWeapon;
        public float ActiveRange;
        public bool ActiveFiresMoving;

        // ---- Phase 1 awareness (design §P1/P3/P4/P5/P7) ----
        public int NextWaveCount;
        public int MaxWaveAhead;        // biggest wave within the next two nights
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
              .Append(",\"scene\":\"").Append(Esc(SceneName)).Append("\"")
              .Append(",\"night\":").Append(IsNight ? "true" : "false")
              .Append(",\"wave\":\"").Append(Wave).Append('/').Append(WaveTotal).Append("\"")
              .Append(",\"foes\":").Append(EnemyCount)
              .Append(",\"coins\":").Append(CoinCount)
              .Append(",\"gold\":").Append(Balance)
              .Append(",\"hp\":").Append(HeroHpPct.ToString("0.###", ci))
              .Append(",\"pos\":[").Append(HeroPos.X.ToString("0.#", ci))
              .Append(',').Append(HeroPos.Z.ToString("0.#", ci)).Append(']')
              .Append(",\"note\":\"").Append(Esc(note)).Append('\"');

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
            Append(sb, ",\"castles\":", CastleCount);
            Append(sb, ",\"lvlp\":", LevelPos, HasLevel, ci);
            Append(sb, ",\"lvld\":", LevelDist, ci);
            Append(sb, ",\"busy\":", SceneBusy);
            Append(sb, ",\"hpos\":", HornPos, HasHorn, ci);
            Append(sb, ",\"hd\":", HornDist, ci);
            Append(sb, ",\"bld\":", BuildCount);
            Append(sb, ",\"bldb\":", BlockedBuilds);
            Append(sb, ",\"blost\":", BuildsLost);
            Append(sb, ",\"bldk\":", BuildKey);
            sb.Append(",\"bn\":\"").Append(Esc(BuildName)).Append('\"');
            Append(sb, ",\"bpos\":", BuildPos, HasBuild, ci);
            Append(sb, ",\"bd\":", BuildDist, ci);
            Append(sb, ",\"bsc\":", BuildScore);
            Append(sb, ",\"bharv\":", BuildHarvest);
            Append(sb, ",\"ally\":", AllyCount);
            Append(sb, ",\"free\":", FreeUnits);
            Append(sb, ",\"drc\":", DoorsCovered);
            Append(sb, ",\"drn\":", DoorCount);
            Append(sb, ",\"drp\":", DoorsParked);
            Append(sb, ",\"drcl\":", DoorsClaimed);
            Append(sb, ",\"udu\":", UncoveredDoorUnits);
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
            Append(sb, ",\"mwa\":", MaxWaveAhead);
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

        // JSON string escape — scene/building/note text carries user-visible
        // names (quotes, backslashes in paths); raw append corrupts the JSONL
        // and breaks replay/tooling (audit D8).
        static string Esc(string v) => string.IsNullOrEmpty(v) ? "" :
            v.Replace("\\", "\\\\").Replace("\"", "\\\"")
             .Replace("\n", "\\n").Replace("\r", "\\r").Replace("\t", "\\t");

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
        public int HeldMisses;          // consecutive ticks the slot was missing
        public float BuildInteractAt;
        public float IdleSince;         // continuous-idle timer (-1 = working)
        public float GateWalkSince;     // start of the current gate-pad approach
        public float GateIgnoreUntil;   // backoff after an approach that never opened
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
        public float LastBreachAt;
        public float DayStartAt;
        public string DayScene;
        public string PrevGameState;   // InMatch edge = new match signal
        public string LastArmyLine;    // last noted army anchor line (spam cap)
        public float ArmyLineNoteAt;
        public int PrevWave;         // wave-rollover detects same-scene retries
        public float SquadWalkAt;
        public float LastEscortAt;

        // visit-abandon: stood at a picked slot 10 s with no pay -> park it
        public int SlotVisitKey;
        public float SlotVisitSince;
        public int ApprKeyP1; public float ApprSince; public int ApprGold;
        public Vec2 ApprPos;            // target pos at the last retarget (cluster hysteresis)
        public int HeroDoorIdx; public float HeroDoorSince; public float HeroDoorIgnUntil;
        public int[] DoorPostCounts;    // per-door consecutive PlaceSquad posts
        public float[] DoorPostAts;     // per-door last PlaceSquad time
        public bool WasDead;            // revive edge: re-arm coverage on respawn
        public float ShrineIgnoreUntil; // shrine visit cooldown — charging takes time
        public float HornWalkSince;     // horn approach watchdog
        public float HornIgnoreUntil;   // horn proven unreachable -> SwitchNight fallback

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
                DoorPostCounts = new int[64],
                DoorPostAts = new float[64],
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
                    ["elite_stall_hp"] = 0.62f,  // never solo-duel an elite below this hp
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
                float cur;
                // Non-numeric fields (Vec2, string, enum) crash ToSingle —
                // a bad rule used to kill EVERY decide tick. Skip it.
                try { cur = o is bool ? ((bool)o ? 1f : 0f) : Convert.ToSingle(o); }
                catch { continue; }
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

            // Idle-spell timer: any non-Idle previous mode clears it so the
            // idle fallthrough measures a CONTINUOUS idle stretch.
            if (m.Mode != BotMode.Idle) m.IdleSince = -1f;

            // Held-build release guard (used to be ReleaseBuild() inline).
            // Release only on a REAL invalidation — not a 4 m drift that can
            // happen mid-fill, and not "far from slot origin" while parked at
            // its stand-point. Every release refunds paid coins.
            // (ResolveUI was never a real brain mode — mem.Mode is never
            // assigned it; Tick's early-return + ChoiceCoroutineRunning are
            // what actually keep choice frames from releasing the hold.)
            // NOTE: the mode clause tests the *incoming* decision — m.Mode is
            // LAST tick's value, so a mode transition leaked the hold one
            // extra tick (hero walked off still holding). The BuildKey/dist
            // invalidation below is the real guard; the mode release happens
            // naturally next tick once m.Mode updates.
            if (m.HeldBuild >= 0)
            {
                // Perception flicker hysteresis: `inter` toggles 0/19 on
                // alternating ticks, so a single miss released the hold and
                // the next tick re-began it — InteractionBegin every 250 ms
                // reset the fill and Castle Center stayed lvl=0 forever (live
                // Durststein evidence). Require 3 consecutive misses (~0.75 s)
                // before believing the slot is really gone; distance is an
                // immediate release (hero genuinely walked off).
                bool missing = !s.HasBuild || s.BuildKey != m.HeldBuild;
                m.HeldMisses = missing ? m.HeldMisses + 1 : 0;
                // Distance release: the hold ring for ANY mid-size building
                // sits ~9 m from center (live Mill evidence: pay flowed at
                // dist=8.8 while a 5.5 m cut released it every ~10 s).
                // 12 m covers castle (9.5) and mills; the flicker guard above
                // handles real abandonment.
                float releaseDist = 12f;
                if ((missing && m.HeldMisses >= 3) ||
                    (s.BuildDist > releaseDist && !(s.HasBuildStand && s.BuildStandDist <= 3f)))
                {
                    r.Notes.Add($"rel:misses={m.HeldMisses} bk={s.BuildKey} " +
                        $"hasB={s.HasBuild} dist={s.BuildDist:0.#} bn={s.BuildName}");
                    r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                    m.HeldBuild = -1;
                    m.HeldMisses = 0;
                    m.SlotVisitKey = -1;   // arm-less: a stale visit timestamp made
                                           // the same slot insta-park on revisit
                }
            }

            // Scene/retry change resets the day clock — after a defeat-retry
            // DayStartAt was still ancient, so the budget read as instantly
            // expired and night was called with zero army (ally=0, wave 1).
            // Wave rollover catches the same-scene retry the scene check
            // misses: any new match starts at wave -1/0 — if the previous
            // wave was deeper, this is a fresh match, reset the clock.
            // Primary signal: GameState just became InMatch — this fires on
            // EVERY new match regardless of scene name, wave counters, or
            // day/night carryover (the wave-0-defeat case slipped every
            // other check and re-called night instantly).
            bool stateEdge = s.GameState == "InMatch" &&
                             m.PrevGameState != "InMatch";
            m.PrevGameState = s.GameState;
            // Null/empty scene flicker is not a new match — an additive-load
            // name wobble once reset DayStartAt mid-match and deferred night.
            bool sceneChanged = !string.IsNullOrEmpty(s.SceneName) &&
                                s.SceneName != m.DayScene;
            bool newMatch = sceneChanged ||
                            (s.Wave <= 0 && m.PrevWave > 0) ||
                            (m.DayStartAt <= 0f) ||
                            stateEdge;
            if (newMatch)
            {
                m.DayScene = s.SceneName;
                m.DayStartAt = now;
                m.NightRequestAt = 0f;
                m.ArmyPhase = 0;   // same-scene retry at night carried phase 2
                                   // forward and skipped day placement forever
                // Per-door hero guard timer: a new match means new geometry.
                m.HeroDoorIdx = -1; m.HeroDoorSince = 0f; m.HeroDoorIgnUntil = 0f;
            }
            m.PrevWave = s.Wave;
            // Absolute floor: nothing may call the night inside the first
            // 45 s of a match — no learned budget or stale clock overrides.
            bool dayTooYoung = now - m.DayStartAt < 45f;

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
                m.WasDead = true;
                if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; m.SlotVisitKey = -1; }
                // Drift to the keep's extracted stand-point (a proven free
                // cell); CastlePos itself is inside the keep collider.
                if (s.HasCastleStand) Aim(ref r, s.CastleStandPos, ArriveHold);
                else if (s.HasCastle) Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 4f), ArriveHold);
                else r.HasAim = false;
                return r;
            }
            // Revive edge: squads died/post-states went stale while he was
            // down. Re-arm the door posts (parked anchors keep their
            // Memory.Park — only the retry counters reset), restart the army
            // phase, and drop any stale approach/held-build clocks.
            if (m.WasDead)
            {
                m.WasDead = false;
                m.ArmyPhase = 0;
                m.HeroDoorIdx = -1; m.HeroDoorSince = 0f; m.HeroDoorIgnUntil = 0f;
                if (m.DoorPostCounts != null) System.Array.Clear(m.DoorPostCounts, 0, m.DoorPostCounts.Length);
                if (m.DoorPostAts != null) System.Array.Clear(m.DoorPostAts, 0, m.DoorPostAts.Length);
                m.ApprKeyP1 = 0; m.ApprSince = 0f; m.SlotVisitKey = -1;
                r.Notes.Add("revived-reset");
            }

            // ---- safe night coin-run (wider range at night — foes are held
            // at the doors by squads, so the field is safer to scavenge) ----
            // Red-alert / castle-threat must WIN over night scavenging — a
            // foe chewing buildings 12+ m from the hero (NearFoeCount==0)
            // used to keep this gate true while RecallToBreach never fired.
            // Night scavenge: foes-in-room blocks it only past ~10 m — coins
            // literally at his feet should never sit uncollected while he
            // "holds" (the always-idle complaint is that he freezes even
            // while free gold lies beside him).
            bool coinAdj = s.HasCoin && s.CoinDist <= 10f;
            if (s.IsNight && !s.RedAlert && !s.HasCastleThreat &&
                ((s.NearFoeCount == 0 && (!s.HasNearEnemy || s.NearEnemyDist > 12f)) || coinAdj)
                && s.HasCoin && s.CoinDist <= pol.K("coin_seek") * 1.5f)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            // RED ALERT — day too (audit F4): dawn revives units but leftover
            // enemies and daytime roamers still hit buildings inside the ring;
            // this response used to exist only inside the night block and the
            // bot went coin-running while the walls burned.
            if (s.RedAlert && s.HasThreatAnchor)
            {
                if (s.AllyCount > 0 && now - m.LastBreachAt > 8f)
                {
                    m.LastBreachAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.RecallToBreach));
                    r.Notes.Add("breach-response");
                }
                bool heroMust0 = (s.HasNearEnemy && s.NearEnemyDist <=
                        (s.SelfDefendRange > 0f ? s.SelfDefendRange : 7f))
                    || s.NearFoeCount >= 2;
                if (heroMust0)
                {
                    m.Mode = BotMode.Engage; r.Mode = m.Mode;
                    m.Pursue = r.Pursue = 1;
                    Aim(ref r, s.ThreatAnchor, 1.5f);
                    r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
                    r.Notes.Add("red-alert");
                }
                else
                {
                    m.Mode = BotMode.HoldCastle; r.Mode = m.Mode;
                    Vec2 away0 = s.CastlePos - s.ThreatAnchor;
                    Vec2 safe0 = away0.SqrMag > 0.01f ? s.CastlePos + away0.Norm * 5f : s.CastlePos;
                    Aim(ref r, s.HasCastleStand ? s.CastleStandPos : safe0, ArriveHold);
                    r.Notes.Add("red-hold");
                }
                return r;
            }

            if (s.IsNight)
            {
                // Hot-door posting at NIGHT: a corridor under attack that's
                // uncovered gets whatever free units exist (≥2), not the
                // day-time 4-unit minimum — better a thin squad than a leak.
                // Escalating throttle: the SAME door re-firing every ~6 s is
                // a squad that never sticks (dies on arrival / can't reach).
                // After 3 posts to the same lane the hero walks there and
                // holds it himself — he IS the reinforcement unit.
                // Per-index counts: alternating uncovered doors used to reset
                // the streak, so unwalkable pairs were spammed forever.
                if (legit && s.HasUncoveredDoor && s.UncoveredDoorHot &&
                    s.UncoveredDoorIdx >= 0 && s.UncoveredDoorIdx < m.DoorPostAts.Length && s.FreeUnits >= 2 &&
                    now - m.DoorPostAts[s.UncoveredDoorIdx] > 6f + 4f * m.DoorPostCounts[s.UncoveredDoorIdx])
                {
                    m.DoorPostCounts[s.UncoveredDoorIdx]++;
                    m.DoorPostAts[s.UncoveredDoorIdx] = now;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
                }
                // Posted 4+ times and NOTHING is standing there — the anchor
                // is unwalkable (behind a wall / off-navmesh). Park it: the
                // coverage loop counts parked doors covered, so the spam
                // ends and the units go to a lane they can actually reach.
                if (s.HasUncoveredDoor && s.UncoveredDoorIdx >= 0 && s.UncoveredDoorIdx < m.DoorPostAts.Length &&
                    m.DoorPostCounts[s.UncoveredDoorIdx] >= 4 &&
                    s.UncoveredDoorUnits == 0)
                {
                    r.Intents.Add(Intent.At(IntentKind.ParkDoor, s.UncoveredDoorIdx));
                    r.Notes.Add("door-park:" + s.UncoveredDoorLine);
                    m.DoorPostCounts[s.UncoveredDoorIdx] = 0;
                }
                // Proactive night posting: quiet corridors still get manned —
                // squads stand at their posts BEFORE the next wave leaks.
                else if (legit && s.HasUncoveredDoor && !s.RedAlert &&
                         s.UncoveredDoorIdx >= 0 && s.UncoveredDoorIdx < m.DoorPostAts.Length &&
                         s.FreeUnits >= Math.Max(2, Math.Min(s.UncoveredDoorTarget, 8)) &&
                         now - m.DoorPostAts[s.UncoveredDoorIdx] > 4f)
                {
                    m.DoorPostAts[s.UncoveredDoorIdx] = now;
                    m.DoorPostCounts[s.UncoveredDoorIdx]++;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-post:" + s.UncoveredDoorLine);
                }

                // Red alert is handled above the night gate now (day+dawn
                // breaches were escaping — audit F4).

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
                    // Elite/boss rule (strategy packs: "stall, don't duel the
                    // Ram") — an elite on top of him with troops alive is the
                    // squad's fight, not his. Same retreat lane, higher hp
                    // threshold so he disengages before the burst lands.
                    bool eliteStall = s.NearEnemyElite && s.AllyCount > 0 &&
                        s.HeroHpPct < pol.K("elite_stall_hp");
                    if (legit && s.HasCastle &&
                        (s.HeroHpPct < pol.K("retreat_hp") || eliteStall))
                    {
                        m.Mode = BotMode.ReturnHome; r.Mode = m.Mode;
                        m.Pursue = r.Pursue = s.HasCastleThreat ? 1 : 2;
                        Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 3f), ArriveHold);
                        r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
                        return r;
                    }
                    m.Mode = BotMode.Engage; r.Mode = m.Mode;
                    // Threat AT dist 0 (sitting on the castle) must stay
                    // urgent — the old >0 lower bound flipped Pursue to
                    // nearest-hero and ignored the castle threat.
                    bool urgent = s.HasCastleThreat && s.CastleThreatDist < 20f;
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
                            // Foe ON the castle: the pull vector is ~zero —
                            // Aiming at CastlePos parks the hero inside the
                            // keep collider. Perpendicular orbit instead.
                            Vec2 pull = away.SqrMag > 0.01f ? away.Norm
                                : Vec2.Perp(axisDir.SqrMag > 0.01f ? axisDir.Norm : new Vec2(1f, 0f));
                            Aim(ref r, s.CastlePos + pull * 4f, 1.2f);
                        }
                        else
                        {
                            // perpetual orbit on the defended-side arc —
                            // dt clamps: first Engage after a long break used
                            // dt=minutes and snapped the orbit to the arc edge.
                            float dt = m.LastOrbitAt > 0f
                                ? Math.Min(now - m.LastOrbitAt, 0.5f) : 0.25f;
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
                    // NIGHT BUILD (proposal [16]): foe-free night + funded +
                    // buildable slot + no door duty -> work instead of holding.
                    // "He should be building while they're fighting." Squad
                    // posting already ran above; door duty still wins when a
                    // corridor is uncovered.
                    bool nightBuild = s.NearFoeCount == 0 && !s.HasUncoveredDoor &&
                        (!s.HasNearEnemy || s.NearEnemyDist > 12f) &&
                        s.HasBuild && (s.Balance > 0 || s.BuildHarvest);
                    if (nightBuild)
                    {
                        m.Mode = BotMode.SpendGold; r.Mode = m.Mode;
                        string nb = s.BuildName ?? "";
                        bool bigB = nb.IndexOf("castle",
                            System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                            nb.IndexOf("hall",
                            System.StringComparison.OrdinalIgnoreCase) >= 0;
                        bool inG = s.BuildDist <= (bigB ? 10f : 4f) ||
                            (s.HasBuildStand && s.BuildStandDist <= 1.2f);
                        if (inG)
                        {
                            Aim(ref r, s.HeroPos, 1.0f);
                            if (m.HeldBuild < 0)
                                r.Intents.Add(Intent.Of(IntentKind.BeginHold));
                        }
                        else if (s.HasBuildStand) Aim(ref r, s.BuildStandPos, 0.8f);
                        else Aim(ref r, Vec2.StandOff(s.BuildPos, s.HeroPos,
                            bigB ? 6.0f : 3.0f), 1.0f);
                        r.Notes.Add("night-build");
                        return r;
                    }
                    m.Mode = BotMode.HoldCastle; r.Mode = m.Mode;
                    // Safe night: patrol the hold post instead of freezing —
                    // a small orbit keeps him visibly working (and sweeps up
                    // adjacent coins) while squads hold the corridors.
                    // If the hot door has been held >12 s without relief, the
                    // hold point is unreachable — fall back to the castle before
                    // the hero turns into a 40 s pin.
                    bool nightDoorOk = !s.HasUncoveredDoor || s.UncoveredDoorIdx != m.HeroDoorIdx
                        || (now >= m.HeroDoorIgnUntil && now - m.HeroDoorSince <= 12f);
                    bool holdAtDoor = s.HasUncoveredDoor && s.UncoveredDoorHot && nightDoorOk;
                    if (holdAtDoor)
                    {
                        // Start/refresh the timer so a stuck hot hold falls
                        // back to the castle after 12 s.
                        if (s.UncoveredDoorIdx != m.HeroDoorIdx) { m.HeroDoorIdx = s.UncoveredDoorIdx; m.HeroDoorSince = now; }
                    }
                    // The hot door just exceeded 12 s and we are not already
                    // ignoring it: lock it for 45 s so the hero can re-try later
                    // in the night instead of going permanently dark.
                    else if (s.HasUncoveredDoor && s.UncoveredDoorHot &&
                             s.UncoveredDoorIdx == m.HeroDoorIdx && now >= m.HeroDoorIgnUntil)
                    {
                        m.HeroDoorIgnUntil = now + 45f;
                        m.HeroDoorSince = now + 45f;
                    }
                    Vec2 holdPos = holdAtDoor
                        ? s.UncoveredDoorPos
                        : (s.HasThreatAnchor ? s.ThreatAnchor : s.CastlePos);
                    // Late-wave escalation: last third of the night with a
                    // thin army — a solo hero at the corridor mouth is a
                    // death sentence. Pull back to the defended castle arc
                    // where towers + the reserve actually cover him.
                    if (s.WaveTotal > 0 && s.Wave >= s.WaveTotal - 2 &&
                        s.AllyCount <= 8 && s.HasCastle)
                    {
                        holdPos = s.HasCastleStand ? s.CastleStandPos
                            : s.CastlePos;
                        r.Notes.Add("late-wave-hold");
                    }
                    // Patrol only while foes are actually on the field —
                    // orbiting an empty corridor just reads as pacing.
                    if (s.EnemyCount > 0 || s.NearFoeCount > 0)
                    {
                        float hdt = m.LastOrbitAt > 0f
                            ? Math.Min(now - m.LastOrbitAt, 0.5f) : 0.25f;
                        m.LastOrbitAt = now;
                        m.OrbitAngle += pol.K("orbit_spin") * m.OrbitDir * hdt;
                        if (m.OrbitAngle > 1.2f) m.OrbitDir = -1f;
                        else if (m.OrbitAngle < -1.2f) m.OrbitDir = 1f;
                        Vec2 fwd0 = axisDir.SqrMag > 0.01f ? axisDir.Norm : new Vec2(0f, 1f);
                        Vec2 hring = holdPos + Vec2.Perp(fwd0) *
                            (float)Math.Sin(m.OrbitAngle) * 3f;
                        Aim(ref r, hring, 0.8f);
                        r.ProjectToNav = true;
                    }
                    else { Aim(ref r, holdPos, ArriveHold); r.ProjectToNav = true; }
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
            // BUSY DAY: buildable slots exist, gold is in hand and the bot is still making progress -> the day
            // is not over. Calling night with a full wallet and open slots wastes the only time the hero can build.
            // Under-armed (<70 % of target) with buildable work and recent progress also blocks the early call.
            bool busyDay = (s.HasBuild || s.BuildCount > 0 || s.BlockedBuilds > 0) && s.Balance >= 20 &&
                (s.SinceProg < 25f || (s.Balance >= 500 && s.SinceProg < 90f) || (s.ArmyTarget > 0 && s.AllyCount * 10 < s.ArmyTarget * 7 && s.SinceProg < 60f));
            // Doors actually manned RIGHT NOW: DoorsCovered also counts parked
            // (unwalkable) anchors and en-route claims — neither is a defender,
            // and counting them called the night early with the walls unmanned.
            int realDoors = s.DoorsCovered - s.DoorsParked - s.DoorsClaimed;
            if (!s.IsNight && m.DayStartAt > 0f && !dayTooYoung &&
                ((s.CanSwitch && (s.NightCall || !busyDay &&
                  // Ready = army target met AND someone actually manning the
                  // perimeter (calling night with zero posts invites the
                  // breach we saw at t≈90: 25 foes vs a lone hero).
                  // ArmyTarget==0 means the door scan produced nothing —
                  // x >= 0 trivially true called night with ZERO troops.
                  // Zero is "unknown", not "ready": require a real target
                  // AND a nonzero army before readiness counts.
                  // Parked anchors still satisfy "all handled" — they are
                  // proven unwalkable, so there is nothing more to post.
                  (s.ArmyTarget > 0 && s.AllyCount >= s.ArmyTarget &&
                   (s.DoorCount == 0 || realDoors > 0) ||
                   (s.DoorCount > 0 && realDoors + s.DoorsParked >= s.DoorCount && s.AllyCount > 0)))) ||
                 // Budget expiry forces the night even when the horn isn't
                 // visible — SwitchToNight is the game's own call and rejects
                 // harmlessly if the day is still locked.
                 now - m.DayStartAt > (s.DayBudget > 0f ? s.DayBudget : 240f) *
                    // far under the army target with work + gold left: do not force a lethal night early
                    (busyDay ? 3.75f : (s.ArmyTarget > 0 && s.AllyCount * 10 < s.ArmyTarget * 7 && s.HasBuild && s.Balance > 0 ? 2.5f : 1f))))
            {
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; m.SlotVisitKey = -1; }
                // Horn watchdog (audit F2): walking at a walled-off horn used
                // to wedge the run in StartNight forever — after 25 s of
                // approach without getting near, back off 60 s and let the
                // SwitchNight fallback fire instead.
                bool hornOk = s.HasHorn && now >= m.HornIgnoreUntil;
                if (hornOk)
                {
                    if (m.HornWalkSince <= 0f) m.HornWalkSince = now;
                    else if (now - m.HornWalkSince > 25f && s.HornDist > 4f)
                    {
                        m.HornIgnoreUntil = now + 60f; m.HornWalkSince = 0f;
                        hornOk = false;
                        r.Notes.Add("horn-unreachable");
                    }
                }
                if (hornOk)
                {
                    Aim(ref r, s.HornPos, 2f);
                    if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
                    {
                        m.HornInteractAt = now + 2f;
                        r.Intents.Add(Intent.Of(IntentKind.HornInteract));
                        r.Notes.Add("horn-interact");
                    }
                    return r;
                }
                if (!(s.SceneName != null && s.SceneName.StartsWith("_"))
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
            if (legit && !s.IsNight)
            {
                if (s.HasUncoveredDoor && s.UncoveredDoorIdx >= 0 && s.UncoveredDoorIdx < m.DoorPostAts.Length &&
                    // Partial posts allowed: a door asking 14 units sat
                    // UNCOVERED while 13 free units waited for a full squad.
                    // Post what's there (2+) — thin cover beats an open lane.
                    s.FreeUnits >= (s.UncoveredDoorHot ? 2 : Math.Max(2, Math.Min(s.UncoveredDoorTarget, 8)))
                    && now - m.DoorPostAts[s.UncoveredDoorIdx] > 6f + 4f * m.DoorPostCounts[s.UncoveredDoorIdx])
                {
                    m.DoorPostCounts[s.UncoveredDoorIdx]++;
                    m.DoorPostAts[s.UncoveredDoorIdx] = now;
                    r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
                    r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
                }
                // Same-day version: posts to a door whose units never arrive
                // (doorUnit==0 after 4 tries) = unwalkable anchor — park it.
                if (s.HasUncoveredDoor && s.UncoveredDoorIdx >= 0 && s.UncoveredDoorIdx < m.DoorPostAts.Length &&
                    m.DoorPostCounts[s.UncoveredDoorIdx] >= 4 &&
                    s.UncoveredDoorUnits == 0)
                {
                    r.Intents.Add(Intent.At(IntentKind.ParkDoor, s.UncoveredDoorIdx));
                    r.Notes.Add("door-park:" + s.UncoveredDoorLine);
                    m.DoorPostCounts[s.UncoveredDoorIdx] = 0;
                }
                // Escort waits while ANY door stands uncovered — the bodyguard
                // used to strip the reserve before the open lanes got theirs.
                if (s.FreeUnits > 0 && !s.HasUncoveredDoor && now - m.LastEscortAt > 40f)
                {
                    m.LastEscortAt = now;
                    r.Intents.Add(Intent.Of(IntentKind.EscortHero));
                    r.Notes.Add("escort-refresh");
                }
            }

            // ---- day: coins ----
            // P1 use: a huge or final wave coming up tightens the seek range —
            // no long-range coin runs when the run is on the line.
            float coinRange = (s.FinalWaveNext || s.MaxWaveAhead >= pol.K("big_wave_nwc"))
                ? pol.K("coin_seek_big") : pol.K("coin_seek");
            // Broke: scavenge wider — the economy has to fund the war machine.
            if (s.Balance < 10f) coinRange *= 1.5f;
            if (!s.IsNight && s.HasCoin && s.CoinDist <= coinRange)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            // ---- day: shrine charge — shrines fill from unit deaths inside
            // their collectionRange (decompiled Shrine.cs: DeathOfUnitAt).
            // Walk the commanded blob to the shrine and PlaceArmy so the
            // fighting happens in the circle. Low priority: only when the
            // war machine is basically ready and nothing is on fire.
            if (!s.IsNight && s.ShrineCount > 0 && s.ShrineDist < 80f &&
                now >= m.ShrineIgnoreUntil &&
                s.AllyCount * 10 >= s.ArmyTarget * 7 &&
                !s.RedAlert && !s.HasCastleThreat && !s.UncoveredDoorHot &&
                s.FreeUnits >= 2)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.ShrinePos, 6f);
                r.ProjectToNav = true;
                r.Notes.Add("shrine-visit");
                if (s.ShrineDist < 12f)
                {
                    r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
                    r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
                    if (s.ShrineDist < 8f) m.ShrineIgnoreUntil = now + 180f;
                }
                return r;
            }

            // ---- day: gate/path unlocks ----
            // CutOpenPathInteractor pads are the literal "unlock the doors"
            // mechanic — hold-to-fill, costs toggleCost. Hard rule: when the
            // playbook wants a gate (or no build work is left), walk to the
            // nearest pad and hold it until the path opens.
            var openOrder = s.OpenOrder ?? System.Array.Empty<string>();
            bool wantGate = s.GateCount > 0 && now >= m.GateIgnoreUntil &&
                (System.Array.IndexOf(openOrder, "gate") >= 0 || !s.HasBuild);
            if (!wantGate) m.GateWalkSince = 0f;
            else
            {
                if (m.GateWalkSince <= 0f) m.GateWalkSince = now;
                else if (now - m.GateWalkSince > 30f)
                {
                    // 30 s of approach with no open — back off 90 s so builds
                    // and coins aren't starved by an unreachable pad (A12).
                    m.GateIgnoreUntil = now + 90f; m.GateWalkSince = 0f; wantGate = false;
                    r.Notes.Add("gate-backoff");
                }
            }
            if (!s.IsNight && wantGate && m.HeldBuild < 0)
            {
                m.Mode = BotMode.SpendGold; r.Mode = m.Mode;
                Vec2 gStand = s.GatePos;
                if (s.HasCastle)
                {
                    var gp = s.CastlePos - s.GatePos;
                    if (gp.Mag > 2f) gStand = s.GatePos + gp.Norm * 2.5f;
                }
                Aim(ref r, gStand, 1.0f);
                if (s.GateDist <= 4f)
                    r.Intents.Add(Intent.Of(IntentKind.GateHold));
                else
                    r.Notes.Add("gate-walk d=" + s.GateDist.ToString("0"));
                return r;
            }

            // ---- day economy ----
            // Held slot completed its interaction: release IMMEDIATELY — the
            // old path rode the 7 s stall watchdog for every build, and worse,
            // a latched 'complete' re-won held-stickiness so BeginHold never
            // re-fired to clear it (castle tier-2 → wedge → park).
            if (m.HeldBuild >= 0 && s.HeldBuildComplete)
            {
                r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                m.HeldBuild = -1;
                m.SlotVisitKey = -1;
                r.Notes.Add("build-done");
                // Return now: falling through re-picks the just-finished slot
                // (still best-scoring) and emits Release+BeginHold thrash
                // while HeldBuildComplete is latched — release/begin/release
                // every tick.
                return r;
            }
            if (s.HasBuild && (s.Balance > 0 || s.BuildHarvest))
            {
                m.Mode = BotMode.SpendGold; r.Mode = m.Mode;
                // Approach the extracted stand-point when known (a proven
                // free cell beside the slot) — never a geometric stand-off
                // that may land inside the slot's collider. Hold once inside
                // the interact gate or at the stand-point.
                // BuildDist is hero→slot CENTER — for a large collider the
                // walkable ring sits past 4 m, so a 4 m gate is unreachable
                // (castle = ~5 m collider → hero stuck at ~9 m forever).
                string bn0 = s.BuildName ?? "";
                bool big = bn0.IndexOf("castle",
                    System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                    bn0.IndexOf("hall",
                    System.StringComparison.OrdinalIgnoreCase) >= 0;
                bool inGate = s.BuildDist <= (big ? 10f : 4f) ||
                    (s.HasBuildStand && s.BuildStandDist <= 1.2f);
                if (inGate) Aim(ref r, s.HeroPos, 1.0f);
                else if (s.HasBuildStand) Aim(ref r, s.BuildStandPos, 0.8f);
                else
                {
                    // Center-based stand-off must clear the building's own
                    // collider — Castle Center's ~5 m footprint put a 3 m
                    // offset INSIDE the collider hole (unreachable frontier,
                    // pin-the-wall loop, live run 105400Z). Big buildings get
                    // a bigger ring.
                    Aim(ref r, Vec2.StandOff(s.BuildPos, s.HeroPos,
                        big ? 6.0f : 3.0f), 1.0f);
                }

                // Approach-timeout: the same target for >18 s with no payment (walking, flapping, unreachable pocket)
                // is a time sink (live data: Mills burned 20-36 s each at ~5 s of real work) - park it and rotate.
                if (s.BuildKey >= 0)
                {
                    if (s.BuildKey + 1 != m.ApprKeyP1 || s.Balance != m.ApprGold)
                    {
                        // Cluster hysteresis: retargeting between neighbours with no
                        // payment kept resetting this clock — thrashing inside one
                        // slot cluster made the 18 s timeout unreachable. A retarget
                        // within 20 m and no gold spent does NOT restart the window.
                        if (m.ApprKeyP1 <= 0 || s.Balance != m.ApprGold ||
                            (s.BuildPos - m.ApprPos).SqrMag > 400f)
                            m.ApprSince = now;
                        m.ApprKeyP1 = s.BuildKey + 1; m.ApprGold = s.Balance; m.ApprPos = s.BuildPos;
                    }
                    else if (now - m.ApprSince > 18f)
                    {
                        r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
                        if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; }
                        m.SlotVisitKey = -1; m.ApprKeyP1 = 0;
                        r.Notes.Add("approach-timeout");
                        return r;
                    }
                }
                // Visit-abandon: stood at the picked slot 10 s with no
                // payment -> the fill can't progress — park and rotate.
                // NOTE: the stall watchdog below fires first in practice (7s
                // vs 10s) — keep this as a backstop, but if it ever fires it
                // MUST release the hold like the stall path does (it used to
                // leave m.HeldBuild set → coins kept paying a parked slot).
                if (inGate && s.BuildKey >= 0)   // key 0 is still a valid slot
                {
                    if (s.BuildKey != m.SlotVisitKey) { m.SlotVisitKey = s.BuildKey; m.SlotVisitSince = now; }
                    else if (now - m.SlotVisitSince >= 10f)
                    {
                        r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
                        r.Notes.Add("slot-abandon");
                        if (m.HeldBuild >= 0)
                        {
                            r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                            m.HeldBuild = -1;
                        }
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
                    // While a hold is active we PUMP it — never re-begin on
                    // a BuildKey change (two same-named Interactor pads used
                    // to alternate the pick → ReleaseHold+BeginHold every
                    // tick → the fill reset forever, Castle lvl=0). Release
                    // is decided ONLY by the miss/dist guard above.
                    if (m.HeldBuild < 0)
                    {
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
                        // ALSO resets the slot-abandon timer: a slow fill
                        // (Barracks 40g) pays for >10s — without this, the
                        // visit timer fired mid-payment → ParkSlot → the
                        // cell went into permanent mishap memory. THE
                        // bmil=0 root cause.
                        r.Notes.Add("pay");
                        m.SpendWatchGold = s.Balance;
                        m.SpendWatchCores = s.CoreBalance;
                        m.SpendWatchAt = now + 7f;
                        m.SlotVisitSince = now;
                    }
                    else if (now >= m.SpendWatchAt)
                    {
                        r.Notes.Add("build-stall");
                        r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
                        r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                        m.HeldBuild = -1;
                        m.SlotVisitKey = -1;   // parked slot: stale visit
                                             // stamp must not arm the next
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
                if (s.HasArmyAnchor)
                {
                    anchor = s.ArmyAnchor;
                    // Rate-limit: the line name repeats every decision while
                    // the squad walks — once per line per 10 s is enough.
                    if (s.ArmyAnchorLine != m.LastArmyLine || now >= m.ArmyLineNoteAt)
                    {
                        m.LastArmyLine = s.ArmyAnchorLine;
                        m.ArmyLineNoteAt = now + 10f;
                        r.Notes.Add("army-line:" + s.ArmyAnchorLine);
                    }
                }
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
            // The coach's explicit night_call is also readiness — it still
            // passes through s.CanSwitch, so a locked day can't fire early.
            bool readyForNight = m.DayStartAt > 0f && !dayTooYoung &&
                (s.NightCall ||
                 // ArmyTarget==0 = door scan empty = "unknown", not "ready".
                 // realDoors = manned NOW (parked/claimed anchors don't defend).
                 (s.ArmyTarget > 0 && s.AllyCount >= s.ArmyTarget &&
                  (s.DoorCount == 0 || realDoors > 0)) ||
                 (s.DoorCount > 0 && realDoors + s.DoorsParked >= s.DoorCount && s.AllyCount > 0) ||
                 now - m.DayStartAt > (s.DayBudget > 0f ? s.DayBudget : 240f));
            if (readyForNight && s.HasHorn && now >= m.HornIgnoreUntil)
            {
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                // Same watchdog as the first horn block: 25 s of approach
                // without closing below 4 m = unreachable — back off so the
                // SwitchNight branch below can fire.
                if (m.HornWalkSince <= 0f) m.HornWalkSince = now;
                else if (now - m.HornWalkSince > 25f && s.HornDist > 4f)
                {
                    m.HornIgnoreUntil = now + 60f; m.HornWalkSince = 0f;
                    r.Notes.Add("horn-unreachable");
                }
                else
                {
                    Aim(ref r, s.HornPos, 2f);
                    if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
                    {
                        m.HornInteractAt = now + 2f;
                        r.Intents.Add(Intent.Of(IntentKind.HornInteract));
                        r.Notes.Add("horn-interact");
                    }
                    return r;
                }
            }
            else if (s.HasHorn) m.HornWalkSince = 0f;
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
            // instead of circling the castle. The door ANCHOR sits ~55 m out
            // on the corridor waypoint tip — usually off the walkable mesh
            // (Nordfels: every anchor parked as unreachable). The hero's job
            // is a guard post INSIDE the corridor mouth — aim at the point
            // 14 m toward the castle from the anchor.
            // Mid-fill holds are sacred — hero-door used to yank the hero
            // 17 m off a paying slot (rel:dist=17.9 in the live log),
            // refunding the fill every cycle. Door-posting is for IDLE
            // heroes, not working ones.
            // Hero-door timeout: if the same door has been the uncovered pick for
            // >12 s the guard point is unreachable. Stop re-aiming and let the
            // idle-night/return-home fallback take over instead of standing.
            bool canGuardDoor = s.UncoveredDoorIdx != m.HeroDoorIdx
                || (now >= m.HeroDoorIgnUntil && now - m.HeroDoorSince <= 12f);
            if (s.HasUncoveredDoor && m.HeldBuild < 0 && canGuardDoor)
            {
                if (s.UncoveredDoorIdx != m.HeroDoorIdx) { m.HeroDoorIdx = s.UncoveredDoorIdx; m.HeroDoorSince = now; }
                m.Mode = BotMode.PositionArmy; r.Mode = m.Mode;
                // Vec2 layer — pull the hero post 14 m toward the castle.
                Vec2 guard = s.UncoveredDoorPos;
                if (s.HasCastle)
                {
                    var pull2 = s.CastlePos - s.UncoveredDoorPos;
                    if (pull2.Mag > 2f) guard = s.UncoveredDoorPos + pull2.Norm * 14f;
                }
                Aim(ref r, guard, ArriveHold);
                r.ProjectToNav = true;              // unreachable target -> snap to nearest walkable node
                r.Notes.Add("hero-door:" + (s.UncoveredDoorLine ?? ""));
                return r;
            }
            // Same door stuck for >12 s and not ignored: lock it for 45 s so we
            // don't re-pick the same unreachable post next tick. HeroDoorSince is
            // set to the end of the ignore window so the re-try clock starts at
            // zero when the lock expires (not 45 s in the past).
            if (s.HasUncoveredDoor && m.HeldBuild < 0 &&
                s.UncoveredDoorIdx == m.HeroDoorIdx && now >= m.HeroDoorIgnUntil)
            {
                m.HeroDoorIgnUntil = now + 45f;
                m.HeroDoorSince = now + 45f;
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
            // Nothing left to do mid-day — "sitting still" is the bug, not
            // the goal. Once every work front is exhausted (no build, no
            // coin, no uncovered door, past the young-day gate) for 30 s
            // straight, call night early instead of idling out the 240 s
            // budget. Neuland day phases used to burn 3+ minutes of dead
            // time per wave.
            if (m.IdleSince < 0f) m.IdleSince = now;
            // Gold in hand + slots parked/ignored is NOT "done for the day" —
            // the rescan loop forgives stale parks every ~30 s. Give it room
            // before ringing the horn on a funded day (idle-night fired while
            // 5k+ gold sat unspent behind parked slots, Frostsee audit).
            float idleNightAfter = s.Balance >= 20 && (s.BuildCount > 0 || s.BlockedBuilds > 0) ? 40f : 12f;
            if (!s.IsNight && m.DayStartAt > 0f && !dayTooYoung &&
                s.CanSwitch && now - m.IdleSince > idleNightAfter &&
                now >= m.NightRequestAt)
            {
                m.NightRequestAt = now + 15f;
                m.IdleSince = -1f;
                r.Notes.Add("idle-night-call");
                r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
            }
            return r;
        }

        static void Aim(ref DecideResult r, Vec2 pos, float arrive)
        {
            r.AimPos = pos; r.Arrive = arrive; r.HasAim = true;
            // Every aim lands on walkable ground: door anchors, build slots and
            // patrol points can sit INSIDE rocks / boundary / building geometry
            // (the "90% pinned on map-rocks" complaint). GetNearest is a cheap
            // snap — the hero walks to the nearest reachable node instead of
            // pushing forever into a collider he can never enter.
            r.ProjectToNav = true;
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





