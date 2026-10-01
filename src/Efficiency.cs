using System.Collections.Generic;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Strict productivity meter. A decaying accumulator is fed by real
    /// accomplishments (gold actually spent, buildings finished, troops gained,
    /// doors covered, gates opened) and drained by waste (gold sitting unspent
    /// while slots exist, daytime Idle, pacing without progress, mode flapping,
    /// stuck strikes). Score = 100 * raw / (raw + K): ~85-90 under sustained
    /// productive play, collapses under 15 within seconds of true idling.
    /// Feeds back into candidate selection (wider search when low) and is
    /// exported in audit.json / ticks for the dashboard and reports.
    /// </summary>
    internal static class Efficiency
    {
        public static float Raw, Score = 50f, SpendRatio, Drain, WasteSeconds, TotalSeconds, LowSeconds;
        public static string DrainWhy = "";

        const float HalfLife = 8f;
        const float Lam = 0.6931f / HalfLife;
        const float K = 4f;

        static float spent, earned, lastBal = -1f, lastAlly, lastDoor, lastT = -1f, lastModeChangeAt;
        static string lastMode = "";
        static readonly Queue<float> modeFlips = new Queue<float>();
        static readonly Queue<Vector2> posRing = new Queue<Vector2>();
        static readonly Queue<float> posRingT = new Queue<float>();
        static float lastProgressAt;

        public static void Reset()
        {
            Raw = 0f; Score = 50f; SpendRatio = 0f; Drain = 0f; DrainWhy = "";
            spent = earned = 0f; lastBal = -1f; lastAlly = lastDoor = 0f; lastT = -1f;
            lastMode = ""; modeFlips.Clear(); posRing.Clear(); posRingT.Clear();
            lastProgressAt = Time.unscaledTime;
        }

        /// <summary>Seconds since the last real accomplishment (pay, build, troop, door).</summary>
        public static float SecondsSinceProgress => Time.unscaledTime - lastProgressAt;

        public static void Update(float balance, int ally, int doorsCovered, int buildable,
            bool isNight, bool heldBuild, string mode, Vector2 heroPos, bool inMatch,
            IList<string> notes)
        {
            float now = Time.unscaledTime;
            if (!inMatch) { lastT = -1f; return; }
            if (lastT < 0f) { lastT = now; lastBal = balance; lastAlly = ally; lastDoor = doorsCovered; lastProgressAt = now; return; }
            float dt = Mathf.Min(now - lastT, 1f);
            lastT = now;
            if (dt <= 0f) return;

            // night, or broke by day: nothing affordable to spend, so hold the score instead of punishing the bot
            float dec = (isNight || balance < 10f) ? 1f : Mathf.Exp(-Lam * dt);
            Raw *= dec;
            float decSlow = Mathf.Exp(-Lam * dt / 3.75f);
            spent *= decSlow; earned *= decSlow;

            bool progressed = false;
            if (balance < lastBal)
            {
                float g = lastBal - balance;
                Raw += Mathf.Min(g, 20f) * 0.5f;
                spent += g; progressed = true;
            }
            else if (balance > lastBal) earned += balance - lastBal;
            if (ally > lastAlly) { Raw += 0.6f * (ally - lastAlly); progressed = true; }
            if (doorsCovered > lastDoor) { Raw += 4f * (doorsCovered - lastDoor); progressed = true; }
            lastBal = balance; lastAlly = ally; lastDoor = doorsCovered;

            if (notes != null)
                for (int i = 0; i < notes.Count; i++)
                {
                    string n = notes[i];
                    if (n == "build-done") { Raw += 8f; progressed = true; }
                    else if (n == "gate-open") { Raw += 6f; progressed = true; }
                    else if (n.StartsWith("stuck")) Raw -= 3f;
                    else if (n.StartsWith("anomaly:stuck")) Raw -= 6f;
                }

            // mode flapping: >3 changes in 10 s
            if (mode != lastMode) { modeFlips.Enqueue(now); lastMode = mode; }
            while (modeFlips.Count > 0 && now - modeFlips.Peek() > 10f) modeFlips.Dequeue();

            // pacing: moved >8 m over the last 5 s without any progress
            posRing.Enqueue(heroPos); posRingT.Enqueue(now);
            while (posRingT.Count > 0 && now - posRingT.Peek() > 5f) { posRingT.Dequeue(); posRing.Dequeue(); }
            float pathM = 0f; Vector2 prev = Vector2.zero; bool first = true;
            foreach (var p in posRing) { if (!first) pathM += Vector2.Distance(prev, p); prev = p; first = false; }

            float drain = 0f; string why = "";
            if (!isNight)
            {
                if (balance >= 15f && buildable > 0 && !heldBuild)
                { float d = 0.35f * Mathf.Min(1f, balance / 50f); drain += d; why += "gold-idle "; }
                if (mode == "Idle") { drain += 0.8f; why += "idle "; }
                if (pathM > 8f && !progressed && SecondsSinceProgress > 5f) { drain += 0.25f; why += "pacing "; }
            }
            if (modeFlips.Count > 3) { drain += 0.5f; why += "flap "; }
            Drain = drain; DrainWhy = why;
            Raw = Mathf.Max(0f, Raw - drain * dt);
            if (progressed) lastProgressAt = now;

            Score = 100f * Raw / (Raw + K);
            SpendRatio = Mathf.Clamp01(spent / (earned + 1f));
            TotalSeconds += dt;
            if (!isNight && drain > 0.3f) WasteSeconds += dt;
            if (Score < 40f) LowSeconds += dt;
        }

        /// <summary>0 = normal, 1 = hungry (score &lt; 60), 2 = desperate (&lt; 40).</summary>
        public static int Tier => Score < 40f ? 2 : Score < 60f ? 1 : 0;

        public static string Json() =>
            "\"eff\":" + Mathf.RoundToInt(Score) +
            ",\"eff_raw\":" + Raw.ToString("0.0", System.Globalization.CultureInfo.InvariantCulture) +
            ",\"spend_r\":" + SpendRatio.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture) +
            ",\"eff_drain\":\"" + DrainWhy.Trim() + "\"" +
            ",\"waste_s\":" + Mathf.RoundToInt(WasteSeconds) +
            ",\"since_prog\":" + Mathf.RoundToInt(SecondsSinceProgress);
    }
}
