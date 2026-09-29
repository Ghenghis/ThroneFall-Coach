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
            public BuildingInteractor NearestBuild;    // nearest spendable building
            public Vector3 NearestBuildPos;
            public float NearestBuildDist;
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

            // Nearest live enemy.
            s.NearestEnemyDist = float.MaxValue;
            foreach (var e in tm.EnemyUnits)
            {
                if (e == null) continue;
                float d = (e.transform.position - s.HeroPos).sqrMagnitude;
                if (d < s.NearestEnemyDist)
                {
                    s.NearestEnemyDist = d;
                    s.NearestEnemy = e;
                }
            }
            if (s.NearestEnemy != null)
            {
                s.NearestEnemyPos = s.NearestEnemy.transform.position;
                s.NearestEnemyDist = Mathf.Sqrt(s.NearestEnemyDist);
            }
            else s.NearestEnemyDist = 0f;

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
                // Nearest playable node overall AND nearest unbeaten node. The
                // victory loop returns the bot to this map; unbeaten-first turns
                // "walk to the closest node" into an actual campaign advance
                // instead of re-entering the level just finished.
                float dAny = float.MaxValue, dUnbeaten = float.MaxValue;
                LevelInteractor bestAny = null, bestUnbeaten = null;
                var lpm = LevelProgressManager.instance;
                foreach (var li in levelCache)
                {
                    if (li == null || !li.isActiveAndEnabled || !li.CanBePlayed) continue;
                    s.LevelCount++;
                    float d = (li.PlayerTeleportPosition - s.HeroPos).sqrMagnitude;
                    if (d < dAny) { dAny = d; bestAny = li; }
                    bool beaten = lpm != null && li.levelInfo != null &&
                                  lpm.GetLevelDataForScene(li.levelInfo.sceneName).beatenBest;
                    if (!beaten && d < dUnbeaten) { dUnbeaten = d; bestUnbeaten = li; }
                }
                s.NearestLevel = bestUnbeaten ?? bestAny;
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

            // Night resets the dead-slot park list: dusk forces every
            // interactor's state to None anyway, so parked slots get a fresh
            // retry on the next day rather than expiring mid-day.
            if (s.IsNight && buildIgnore.Count > 0) buildIgnore.Clear();

            // Day economy: TagManager maintains playerBuildingInteractors (each
            // slot registers/unregisters itself). CanBeInteractedWith is true
            // only while the slot has work — a build/upgrade to pay for or a
            // harvest payout waiting — so the list needs no further filtering.
            s.NearestBuildDist = float.MaxValue;
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
                s.BuildCount++;
                float d = (bi.transform.position - s.HeroPos).sqrMagnitude;
                if (d < s.NearestBuildDist)
                {
                    s.NearestBuildDist = d;
                    s.NearestBuild = bi;
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

        private static float FlatDist(Vector3 a, Vector3 b)
        {
            a.y = 0f; b.y = 0f;
            return Vector3.Distance(a, b);
        }
    }
}
