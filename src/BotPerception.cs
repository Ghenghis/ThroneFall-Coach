using System.Collections.Generic;
using UnityEngine;

namespace ThronefallTrainer
{
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
        }

        private static readonly List<TaggedObject> castleBuf = new List<TaggedObject>();
        private static LevelInteractor[] levelCache;
        private static float levelScanAt;

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

        public static Snapshot Capture()
        {
            var s = new Snapshot { GameState = "unknown" };
            s.SceneName = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name;

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

            // Home anchor for hold/return behaviour.
            tm.FindAllTaggedObjectsWithTag(castleBuf, TagManager.ETag.CastleCenter);
            if (castleBuf.Count > 0 && castleBuf[0] != null)
            {
                s.HasCastle = true;
                s.CastlePos = castleBuf[0].transform.position;
                s.CastleDist = FlatDist(s.CastlePos, s.HeroPos);
            }

            var spawner = EnemySpawner.instance;
            if (spawner != null)
            {
                s.Wave = spawner.Wavenumber;
                s.WaveTotal = spawner.WaveCount;
                s.EnemyCount = spawner.NumberOfEnemiesOnTheMap;
            }
            else
            {
                s.EnemyCount = tm.EnemyUnits.Count;
            }

            // Nearest live enemy to the hero AND nearest to the castle — the
            // castle-proximate one is what actually loses the run, so it wins
            // target priority for legit defense play.
            s.NearestEnemyDist = float.MaxValue;
            float castleThreatSq = float.MaxValue;
            Vector3 enemySum = Vector3.zero;
            int enemyN = 0;
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
                if (s.HasCastle)
                {
                    float dc = (ep - s.CastlePos).sqrMagnitude;
                    if (dc < castleThreatSq) { castleThreatSq = dc; s.CastleThreat = e; }
                }
                enemySum += ep; enemyN++;
            }
            if (s.NearestEnemy != null)
            {
                s.NearestEnemyPos = s.NearestEnemy.transform.position;
                s.NearestEnemyDist = Mathf.Sqrt(s.NearestEnemyDist);
            }
            else s.NearestEnemyDist = 0f;
            if (s.CastleThreat != null)
                s.CastleThreatDist = Mathf.Sqrt(castleThreatSq);
            else { s.CastleThreatDist = 0f; s.CastleThreat = s.NearestEnemy; }

            // Allied army (troop buildings / heroes). Used to anchor the hero
            // behind the meatshield line for legit defense.
            if (tm.PlayerUnits != null)
            {
                Vector3 allySum = Vector3.zero;
                foreach (var u in tm.PlayerUnits)
                {
                    if (u == null || u.Hp == null || !u.Hp.Alive) continue;
                    allySum += u.transform.position; s.AllyCount++;
                }
                if (s.AllyCount > 0) s.AllyCentroid = allySum / s.AllyCount;
            }

            // Nearest unclaimed coin. freeCoins is maintained by TagManager via
            // Coin.OnEnable/OnDestroy, so it should always be accurate.
            s.NearestCoinDist = float.MaxValue;
            int n = tm.freeCoins.Count;
            for (int i = 0; i < n; i++)
            {
                Coin c = tm.freeCoins[i];
                if (c == null || !c.IsFree) continue;
                s.CoinCount++;
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
            if (horn != null && horn.isActiveAndEnabled)
            {
                s.HasHorn = true;
                s.Horn = horn;
                s.HornPos = horn.transform.position;
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
            }

            // Night resets the dead-slot park list: dusk forces every
            // interactor's state to None anyway, so parked slots get a fresh
            // retry on the next day rather than expiring mid-day.
            if (s.IsNight && buildIgnore.Count > 0) buildIgnore.Clear();

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
                if (bi == null || !bi.isActiveAndEnabled || !bi.CanBeInteractedWith) continue;
                if (buildIgnore.Count > 0 && buildIgnore.TryGetValue(bi, out float until))
                {
                    if (until > Time.unscaledTime) continue;   // still parked
                    buildIgnore.Remove(bi);                    // expired -> retry
                }
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
                    score += military * 100;
                    if (incomeDelta > 0) score += 30 + Mathf.Min(incomeDelta, 10) * 3;
                }
                s.BuildCount++;
                float d = (bi.transform.position - s.HeroPos).sqrMagnitude;
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
            }
            else s.NearestBuildDist = 0f;

            s.Valid = true;
            return s;
        }

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

        private static float FlatDist(Vector3 a, Vector3 b)
        {
            a.y = 0f; b.y = 0f;
            return Vector3.Distance(a, b);
        }
    }
}
