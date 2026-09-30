using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer;

internal static class BotPatches
{
	[HarmonyPatch(typeof(PlayerMovement), "MoveScript")]
	private static class PlayerMovePatch
	{
		[HarmonyPrefix]
		private static void Prefix(ref Vector2 inputVector)
		{
			Rewrite(ref inputVector);
		}
	}

	[HarmonyPatch(typeof(PlayerBallMovement), "MoveScript")]
	private static class BallMovePatch
	{
		[HarmonyPrefix]
		private static void Prefix(ref Vector2 inputVector)
		{
			Rewrite(ref inputVector);
		}
	}

	private static void Rewrite(ref Vector2 inputVector)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		if (!Bot.Enabled)
		{
			return;
		}
		Vector3 desiredDir = Bot.DesiredDir;
		if (desiredDir.sqrMagnitude < 0.0001f)
		{
			inputVector = Vector2.zero;
			return;
		}
		Camera main = Camera.main;
		if ((Object)(object)main == (Object)null)
		{
			inputVector = Vector2.zero;
			return;
		}
		Transform transform = ((Component)main).transform;
		Vector3 val = Vector3.ProjectOnPlane(transform.forward, Vector3.up);
		Vector3 normalized = val.normalized;
		val = Vector3.ProjectOnPlane(transform.right, Vector3.up);
		Vector3 normalized2 = val.normalized;
		inputVector = new Vector2(Vector3.Dot(desiredDir, normalized), Vector3.Dot(desiredDir, normalized2));
	}
}
