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
            Append(sb, ",\"acen\":", AllyCentroid, AllyCount > 0, ci);
            Append(sb, ",\"cmd\":", CanCommand);
            Append(sb, ",\"csw\":", CanSwitch);
            Append(sb, ",\"weap\":", HasWeapon);
            Append(sb, ",\"wrng\":", ActiveRange, ci);
            Append(sb, ",\"wfm\":", ActiveFiresMoving);
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
    }

    internal static class BotBrain
    {
        // Geometry constants mirrored from Bot.cs (kept identical by contract).
        const float ArriveCoin = 0.6f;
        const float ArriveHold = 2.5f;
        const float HomeRadius = 14f;
        const float CoinSeekRange = 80f;
        const float OrbitSpin = 0.7f;
        const float OrbitArc = 1.9f;

        /// <summary>
        /// The full FSM, ported pure: reads SnapshotData + BotMemory only,
        /// returns Mode/AimPos/Intents/Notes. Every world-side call the old
        //  Decide made inline is now an Intent the Tick executes against refs.
        /// </summary>
        public static DecideResult Decide(in SnapshotData s, ref BotMemory m, float now, bool legit)
        {
            var r = new DecideResult
            {
                Mode = m.Mode,
                Intents = new List<Intent>(),
                Notes = new List<string>(),
            };

            // Held-build release guard (used to be ReleaseBuild() inline).
            if (m.HeldBuild >= 0 && (m.Mode != BotMode.SpendGold ||
                !s.HasBuild || s.BuildKey != m.HeldBuild || s.BuildDist > 4f))
            {
                r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
                m.HeldBuild = -1;
            }

            // Day/night edge → re-arm night request + army + coin park.
            if (m.LastNightState != s.IsNight)
            {
                m.NightRequestAt = 0f;
                m.LastNightState = s.IsNight;
                if (!s.IsNight) { m.ArmyPhase = 0; r.Intents.Add(Intent.Of(IntentKind.ClearCoinPark)); }
            }

            // ---- campaign map: enter a level ----
            if (s.HasLevel)
            {
                m.Mode = BotMode.EnterLevel; r.Mode = m.Mode;
                Aim(ref r, Vec2.StandOff(s.LevelPos, s.HeroPos, 2.5f), 1.5f);
                if (s.LevelDist <= 9f && now >= m.LevelInteractAt && !s.SceneBusy)
                {
                    m.LevelInteractAt = now + 2f;
                    r.Notes.Add("level-interact");
                    r.Intents.Add(Intent.Of(IntentKind.SeedLoadout));
                    r.Intents.Add(Intent.Of(IntentKind.TransitionLevel));
                    r.Notes.Add("transition-level");
                }
                return r;
            }

            // ---- dead hero ----
            if (s.HeroDead || s.HeroHpPct <= 0f)
            {
                m.Mode = BotMode.HeroDead; r.Mode = m.Mode;
                if (m.HeldBuild >= 0) { r.Intents.Add(Intent.Of(IntentKind.ReleaseHold)); m.HeldBuild = -1; }
                if (s.HasCastle) Aim(ref r, s.CastlePos, ArriveHold); else r.HasAim = false;
                return r;
            }

            // ---- safe night coin-run ----
            if (s.IsNight && s.NearFoeCount == 0
                && (!s.HasNearEnemy || s.NearEnemyDist > 12f)
                && s.HasCoin && s.CoinDist <= CoinSeekRange)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            if (s.IsNight)
            {
                bool hasThreat = s.HasCastleThreat || s.HasNearEnemy;
                Vec2 threatPos = s.HasCastleThreat ? s.CastleThreatPos : s.NearEnemyPos;
                Vec2 axisDir = s.HasThreatAnchor ? s.ThreatAnchor - s.CastlePos : Vec2.Zero;

                if (hasThreat)
                {
                    // Legit retreat: badly hurt hero pulls behind the castle.
                    if (legit && s.HeroHpPct < 0.5f && s.HasCastle)
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
                        if (heroNear < 4.5f || s.NearFoeCount >= 2)
                        {
                            Vec2 away = s.CastlePos - s.NearEnemyPos;
                            Aim(ref r, s.CastlePos + away.Norm * 4f, 1.2f);
                        }
                        else
                        {
                            // perpetual orbit on the defended-side arc
                            float dt = m.LastOrbitAt > 0f ? now - m.LastOrbitAt : 0.25f;
                            m.LastOrbitAt = now;
                            m.OrbitAngle += OrbitSpin * m.OrbitDir * dt;
                            if (m.OrbitAngle > OrbitArc) { m.OrbitAngle = OrbitArc; m.OrbitDir = -1f; }
                            else if (m.OrbitAngle < -OrbitArc) { m.OrbitAngle = -OrbitArc; m.OrbitDir = 1f; }
                            Vec2 fwd = axisDir.SqrMag > 0.01f ? axisDir.Norm : new Vec2(0f, 1f);
                            Vec2 oc = s.CastlePos - fwd * 3f;
                            float rr = Clamp(s.ActiveRange * 0.3f, 9f, 12f);
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
                            Aim(ref r, s.HeroPos + pull * 5f, 1.2f);
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
                }
                else if (s.HasCastle)
                {
                    m.Mode = BotMode.HoldCastle; r.Mode = m.Mode;
                    Aim(ref r, s.HasThreatAnchor ? s.ThreatAnchor : s.CastlePos, ArriveHold);
                }
                else { m.Mode = BotMode.Idle; r.Mode = m.Mode; r.HasAim = false; }
                return r;
            }

            // ---- day: coins ----
            if (s.HasCoin && s.CoinDist <= CoinSeekRange)
            {
                m.Mode = BotMode.CollectCoin; r.Mode = m.Mode;
                Aim(ref r, s.CoinPos, ArriveCoin);
                return r;
            }

            // ---- day economy ----
            if (s.HasBuild && (s.Balance > 0 || s.BuildHarvest))
            {
                m.Mode = BotMode.SpendGold; r.Mode = m.Mode;
                Aim(ref r, Vec2.StandOff(s.BuildPos, s.HeroPos, 1.6f), 1.0f);
                if (s.BuildDist <= 4f && now >= m.BuildInteractAt)
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

            // ---- army placement ----
            if (legit && m.ArmyPhase < 2 && s.AllyCount > 0 && s.HasCastle && s.CanCommand)
            {
                if (m.ArmyPhase == 0)
                {
                    r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
                    m.ArmyPhase = 1;
                    m.ArmyWalkAt = now + 8f;
                }
                m.Mode = BotMode.PositionArmy; r.Mode = m.Mode;
                Vec2 aAxis = s.HasThreatAnchor ? s.ThreatAnchor - s.CastlePos : Vec2.Zero;
                Vec2 anchor = aAxis.SqrMag > 0.01f ? s.CastlePos + aAxis.Norm * 11f : s.CastlePos;
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
            if (s.HasHorn)
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
            if (s.CanSwitch && now >= m.NightRequestAt &&
                !(s.SceneName != null && s.SceneName.StartsWith("_")))
            {
                m.NightRequestAt = now + 15f;
                r.Notes.Add("switch-night");
                r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
                m.Mode = BotMode.StartNight; r.Mode = m.Mode;
                return r;
            }
            if (s.HasCastle && s.CastleDist > HomeRadius)
            {
                m.Mode = BotMode.ReturnHome; r.Mode = m.Mode;
                Aim(ref r, s.CastlePos, ArriveHold);
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
