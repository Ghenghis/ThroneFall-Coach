using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// Feeds the bot's steering into the game's movement input. The game calls
    /// MoveScript(inputVector) every frame with camera-relative axes
    /// (x = camera-forward, y = camera-right); while the bot is enabled we
    /// rewrite that argument from its world-space <see cref="Bot.DesiredDir"/>.
    /// PlayerBallMovement overrides MoveScript, so both entry points get the
    /// same prefix. When the bot is off, inputVector passes through untouched.
    /// </summary>
    internal static class BotPatches
    {
        private static void Rewrite(ref Vector2 inputVector)
        {
            if (!Bot.Enabled) return;
            Vector3 dir = Bot.DesiredDir;
            if (dir.sqrMagnitude < 0.0001f) { inputVector = Vector2.zero; return; }
            var cam = Camera.main;
            if (cam == null) { inputVector = Vector2.zero; return; }
            Transform t = cam.transform;
            Vector3 fwd   = Vector3.ProjectOnPlane(t.forward, Vector3.up).normalized;
            Vector3 right = Vector3.ProjectOnPlane(t.right,   Vector3.up).normalized;
            inputVector = new Vector2(Vector3.Dot(dir, fwd), Vector3.Dot(dir, right));
        }

        [HarmonyPatch(typeof(PlayerMovement), nameof(PlayerMovement.MoveScript))]
        private static class PlayerMovePatch
        {
            [HarmonyPrefix]
            private static void Prefix(ref Vector2 inputVector) => Rewrite(ref inputVector);
        }

        [HarmonyPatch(typeof(PlayerBallMovement), nameof(PlayerBallMovement.MoveScript))]
        private static class BallMovePatch
        {
            [HarmonyPrefix]
            private static void Prefix(ref Vector2 inputVector) => Rewrite(ref inputVector);
        }
    }
}
