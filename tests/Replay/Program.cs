// Replay harness (v3 design §7.1): feeds recorded tick lines into the pure
// BotBrain.Decide and asserts the emitted Mode sequence matches what the run
// actually did. A divergence = a behavior change introduced by a refactor or
// a policy-table change — exactly the regression Phase 0 exists to catch.
//
// Zero external deps: net8 console, System.Text.Json, and BotBrain.cs linked
// directly (proving it compiles without UnityEngine).
//
//   dotnet run -c Release --project tests/Replay -- <fixtureDir> [...]
//
// Fixture layout: tests/fixtures/runs/<name>/ticks.jsonl (recorder output),
// expected.json optional {"legit":true} (default true).

using System;
using System.IO;
using System.Text.Json;

namespace ThronefallTrainer
{
    internal static class Program
    {
        private static int Main(string[] args)
        {
            // --tol N: allowed mismatches per fixture (memory-dependent
            // decisions like DayStartAt can't be reconstructed from ticks).
            int tol = 0;
            var dirs = new List<string>();
            for (int i = 0; i < args.Length; i++)
            {
                if (args[i] == "--tol" && i + 1 < args.Length) { tol = int.Parse(args[++i]); continue; }
                dirs.Add(args[i]);
            }
            int fail = 0, total = 0;
            var fixtures = dirs.Count > 0 ? dirs.ToArray() : FindFixtures();
            if (fixtures.Length == 0)
            {
                Console.WriteLine("replay: no fixtures (pass tests/fixtures/runs/<name> or run from repo root)");
                return 2;
            }

            foreach (var dir in fixtures)
            {
                var ticks = Path.Combine(dir, "ticks.jsonl");
                if (!File.Exists(ticks))
                {
                    Console.WriteLine($"replay: {dir} — no ticks.jsonl");
                    fail++;
                    continue;
                }

                var mem = BotMemory.Fresh();
                int n = 0, mismatch = 0;
                string firstDiff = "";
                float now = 0f;
                bool legit = ReadLegit(dir);
                var pol = ReadPolicy(dir);

                foreach (var line in File.ReadLines(ticks))
                {
                    if (string.IsNullOrWhiteSpace(line)) continue;
                    var sd = Parse(line);
                    // Recorded tick time drives `now` so clocks/watches behave identically.
                    now = sd.T;
                    var p = pol.Resolved(in sd.Data);
                    var res = BotBrain.Decide(in sd.Data, ref mem, now, legit, in p);
                    n++;
                    string want = sd.Mode, got = res.Mode.ToString();
                    if (!string.Equals(want, got, StringComparison.OrdinalIgnoreCase))
                    {
                        mismatch++;
                        if (firstDiff.Length == 0)
                            firstDiff = $"t={sd.T:0.00}: recorded={want} decided={got}";
                    }
                }

                total++;
                string name = Path.GetFileName(dir.TrimEnd('/', '\\'));
                if (mismatch <= tol)
                    Console.WriteLine($"replay: {name} — {n} ticks PASS ({mismatch} within tol {tol})");
                else
                {
                    Console.WriteLine($"replay: {name} — {mismatch}/{n} mode mismatches FAIL, first: {firstDiff}");
                    fail++;
                }
            }

            Console.WriteLine(fail == 0
                ? $"replay: all {total} fixture(s) PASS"
                : $"replay: {fail}/{total} fixture(s) FAIL");
            return fail;
        }

        private static string[] FindFixtures()
        {
            // bin/<cfg>/net8.0 -> 4x .. lands on tests/ (not the repo root) —
            // the old suffix produced tests/tests/fixtures/runs (audit: path
            // never existed; autodiscovery only worked via the CWD fallback).
            var root = Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..",
                "fixtures", "runs");
            root = Path.GetFullPath(root);
            if (!Directory.Exists(root))
                root = Path.Combine(Directory.GetCurrentDirectory(), "tests", "fixtures", "runs");
            return Directory.Exists(root) ? Directory.GetDirectories(root) : new string[0];
        }

        // Fixture-local policy.txt overrides the default table; a parse
        // failure is a hard error (the fixture is deliberately broken).
        private static PolicyTable ReadPolicy(string dir)
        {
            var pol = PolicyTable.Default();
            var p = Path.Combine(dir, "policy.txt");
            if (!File.Exists(p)) return pol;
            var errs = new System.Collections.Generic.List<string>();
            if (!PolicyTable.Parse(File.ReadAllText(p), ref pol, out errs))
                throw new InvalidOperationException($"policy.txt invalid: {string.Join("; ", errs)}");
            return pol;
        }

        private static bool ReadLegit(string dir)
        {
            var p = Path.Combine(dir, "expected.json");
            if (!File.Exists(p)) return true;
            try
            {
                using var doc = JsonDocument.Parse(File.ReadAllText(p));
                return doc.RootElement.TryGetProperty("legit", out var v) ? v.GetBoolean() : true;
            }
            catch { return true; }
        }

        private struct Parsed { public float T; public string Mode; public SnapshotData Data; }

        // Faithful DTO parse — every key mirrors a SnapshotData field. Presence
        // of a [x,z] position doubles as the Has* flag; "null" means absent.
        private static Parsed Parse(string line)
        {
            using var doc = JsonDocument.Parse(line);
            var e = doc.RootElement;
            var d = new SnapshotData
            {
                Valid = true,
                GameState = S(e, "state"),
                SceneName = S(e, "scene"),
                IsNight = B(e, "night"),
                Balance = I(e, "gold"),
                CoinCount = I(e, "coins"),
                HeroHpPct = F(e, "hp"),
                EnemyCount = I(e, "foes"),
                BuildCount = I(e, "bld"),
                NearFoeCount = I(e, "nf"),
                OnLevelSelect = B(e, "ls"),
                LevelCount = I(e, "lvln"),
                InteractorCount = I(e, "inter"),
                LevelDist = F(e, "lvld"),
                HasHorn = e.TryGetProperty("hpos", out _),
                HornDist = F(e, "hd"),
                HeroDead = B(e, "dead"),
                CoreBalance = I(e, "cbal"),
                DayTimeLeft = F(e, "dtl"),
                NearEnemyDist = F(e, "ed"),
                CastleDist = F(e, "cad"),
                CastleThreatDist = F(e, "cthd"),
                SceneBusy = B(e, "busy"),
                BuildKey = I(e, "bldk"),
                BuildName = S(e, "bn"),
                BuildDist = F(e, "bd"),
                BuildScore = I(e, "bsc"),
                BuildHarvest = B(e, "bharv"),
                AllyCount = I(e, "ally"),
                CanCommand = B(e, "cmd"),
                CanSwitch = B(e, "csw"),
                HasWeapon = B(e, "weap"),
                ActiveRange = F(e, "wrng"),
                ActiveFiresMoving = B(e, "wfm"),
                // Phase 1 awareness fields
                NextWaveCount = I(e, "nwc"),
                NextWaveElites = I(e, "nwe"),
                NextWaveMaxHp = F(e, "nwh"),
                NextWaveSpeed = F(e, "nws"),
                NextWaveFoeRange = F(e, "nwr"),
                NextWaveGold = I(e, "nwg"),
                FinalWaveNext = B(e, "fw"),
                NearEnemyRange = F(e, "erng"),
                NearEnemyHp = F(e, "ehp"),
                NearEnemyElite = B(e, "eel"),
                CastleHpPct = e.TryGetProperty("chp", out var chp) &&
                    chp.ValueKind == JsonValueKind.Number ? chp.GetSingle() : -1f,
                WaveBeforeFinalNext = B(e, "wbf"),
                ShrineCount = I(e, "shr"),
                ShrineDist = F(e, "shd"),
                BuildMil = I(e, "bmil"),
                BuildInc = I(e, "binc"),
                FreeUnits = I(e, "free"),
                DoorCount = I(e, "drn"),
                DoorsCovered = I(e, "drc"),
                ArmyTarget = I(e, "at"),
                RedAlert = B(e, "ra"),
                UncoveredDoorHot = B(e, "hot"),
                DayBudget = F(e, "dbg"),
            };
            var w = S(e, "wave");
            int slash = w.IndexOf('/');
            if (slash > 0 && int.TryParse(w.Substring(0, slash), out int wv)) d.Wave = wv;
            if (slash > 0 && int.TryParse(w.Substring(slash + 1), out int wt)) d.WaveTotal = wt;
            d.HeroPos = P(e, "pos", out _);
            d.CoinPos = P(e, "cpos", out d.HasCoin);
            d.CoinDist = F(e, "cd");
            d.NearEnemyPos = P(e, "epos", out d.HasNearEnemy);
            d.CastlePos = P(e, "cast", out d.HasCastle);
            d.CastleThreatPos = P(e, "cthp", out d.HasCastleThreat);
            d.ThreatAnchor = P(e, "ta", out d.HasThreatAnchor);
            d.LevelPos = P(e, "lvlp", out d.HasLevel);
            d.HornPos = P(e, "hpos", out d.HasHorn);
            d.BuildPos = P(e, "bpos", out d.HasBuild);
            d.AllyCentroid = P(e, "acen", out _);
            d.ShrinePos = P(e, "shp", out _);
            return new Parsed { T = F(e, "t"), Mode = S(e, "mode"), Data = d };
        }

        // [x,z] position or null → presence flag.
        private static Vec2 P(JsonElement e, string n, out bool present)
        {
            present = false;
            if (!e.TryGetProperty(n, out var v) || v.ValueKind != JsonValueKind.Array ||
                v.GetArrayLength() < 2) return new Vec2(0f, 0f);
            present = true;
            return new Vec2(v[0].GetSingle(), v[1].GetSingle());
        }

        private static string S(JsonElement e, string n) =>
            e.TryGetProperty(n, out var v) && v.ValueKind == JsonValueKind.String ? v.GetString() : "";
        private static int I(JsonElement e, string n) =>
            e.TryGetProperty(n, out var v) && v.ValueKind == JsonValueKind.Number ? v.GetInt32() : 0;
        private static float F(JsonElement e, string n) =>
            e.TryGetProperty(n, out var v) && v.ValueKind == JsonValueKind.Number ? v.GetSingle() : 0f;
        private static bool B(JsonElement e, string n) =>
            e.TryGetProperty(n, out var v) && v.ValueKind == JsonValueKind.True;
    }
}
