using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// In-game overlay — F1 toggles a compact IMGUI panel, independent of
    /// any cheat UI. Three pages:
    ///   STATUS   live snapshot + grades + squad/door state
    ///   LEARN    RL table, neural shadow agreement, memory, dataset note
    ///   PLAYBOOK MiniMax strategy file for the current scene (scrollable)
    /// Drawn via OnGUI — zero-alloc-ish string building at ~4 Hz refresh.
    /// </summary>
    internal sealed class Overlay : MonoBehaviour
    {
        public static bool Visible;
        private Rect win = new Rect(14, 14, 340, 460);
        private int page;
        private Vector2 scroll;
        private string book = "";
        private string bookScene = "";
        private float refAt;
        private string body = "";
        private GUIStyle big, small, dim, green, red;

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.F1))
                Visible = !Visible;
        }

        private void OnGUI()
        {
            if (!Visible) return;
            if (big == null) Styles();
            win = GUI.Window(0xD41B, win, Draw, "Grandmaster  [F1]");
        }

        private void Styles()
        {
            big   = new GUIStyle(GUI.skin.label) { fontSize = 15, fontStyle = FontStyle.Bold };
            small = new GUIStyle(GUI.skin.label) { fontSize = 11, wordWrap = true };
            dim   = new GUIStyle(GUI.skin.label) { fontSize = 11, wordWrap = true };
            dim.normal.textColor  = new Color(0.7f, 0.75f, 0.85f);
            green = new GUIStyle(GUI.skin.label) { fontSize = 11, wordWrap = true };
            green.normal.textColor = new Color(0.5f, 1f, 0.5f);
            red   = new GUIStyle(GUI.skin.label) { fontSize = 11, wordWrap = true };
            red.normal.textColor  = new Color(1f, 0.55f, 0.45f);
        }

        private void Draw(int id)
        {
            GUILayout.BeginHorizontal();
            if (GUILayout.Toggle(page == 0, " STATUS ", GUI.skin.button)) page = 0;
            if (GUILayout.Toggle(page == 1, " LEARN ", GUI.skin.button)) page = 1;
            if (GUILayout.Toggle(page == 2, " PLAYBOOK ", GUI.skin.button)) page = 2;
            GUILayout.EndHorizontal();

            if (Time.unscaledTime > refAt) { refAt = Time.unscaledTime + 0.25f; Refresh(); }
            scroll = GUILayout.BeginScrollView(scroll);
            GUILayout.Label(body, page == 2 ? small : dim);
            GUILayout.EndScrollView();
            GUI.DragWindow();
        }

        private void Refresh()
        {
            var s = BotPerception.Last;
            if (!BotPerception.LastValid) { body = "waiting for first tick..."; return; }
            if (page == 0) body = PageStatus(in s);
            else if (page == 1) body = PageLearn();
            else body = PageBook(s.SceneName ?? "");
        }

        private string PageStatus(in BotPerception.Snapshot s)
        {
            string night = s.IsNight ? "NIGHT" : "day";
            return
                $"<b>{s.SceneName}</b>  wave {s.Wave}/{s.WaveTotal}  {night}\n" +
                $"mode <b>{Bot.Mode}</b>   hp {s.HeroHpPct * 100f:0}%  " +
                $"castle {(s.CastleHpPct >= 0 ? (s.CastleHpPct * 100f).ToString("0") + "%" : "?")}\n" +
                $"gold {s.Balance}   allies <b>{s.AllyCount}</b>/{s.ArmyTarget}" +
                $"   free {s.FreeUnits}   foes {s.EnemyCount}\n" +
                $"doors covered <b>{s.DoorsCovered}</b>/{s.DoorCount}" +
                (s.RedAlert ? "   <color=#ff5544>RED ALERT</color>\n" : "\n") +
                (s.HasUncoveredDoor
                    ? $"uncovered: {s.UncoveredDoorLine} (x{s.UncoveredDoorTarget})\n"
                    : "all posts manned\n") +
                (Coach.HeroPosture == "fighter" ? "posture: FIGHTER\n"
                    : "posture: builder (army fights)\n") +
                (Coach.BuildFocus != "" ? $"coach focus: {Coach.BuildFocus}\n" : "") +
                (Coach.Busy ? "coach thinking...\n" : "");
        }

        private string PageLearn()
        {
            string net = NetPolicy.Loaded
                ? $"neural shadow: {NetPolicy.Agree} agree / {NetPolicy.Disagree} disagree" +
                  $" ({NetPolicy.Ratio * 100f:0}%)\n"
                : "neural net: no weights yet\n";
            return
                $"RL Q-table: {Policy.States} states, {Policy.Cells} cells\n" +
                $"decisions {Policy.Decisions}, updates {Policy.Updates}, " +
                $"epsilon {Policy.Epsilon:0.##}\n" +
                net +
                $"memory: {Memory.Count} mishaps never retried\n" +
                $"playbook: {BotPerception.StrategySummary()}\n" +
                $"coach calls {Coach.CallsMade}, tokens {Coach.TokensUsed}\n" +
                (Coach.LastAdvice != ""
                    ? $"\nlast advice:\n{Coach.LastAdvice}\n" : "");
        }

        private string PageBook(string scene)
        {
            if (scene != bookScene)
            {
                bookScene = scene;
                book = BotPerception.StrategyText(scene);
                if (book == "") book = $"no playbook for '{scene}' yet — " +
                    "run tools\\mm-coach.py --scene " + scene;
            }
            return $"<b>PLAYBOOK — {scene}</b>\n{book}";
        }
    }
}
