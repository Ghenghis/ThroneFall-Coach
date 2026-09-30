using HarmonyLib;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(LocalGamestate), "SetState")]
internal static class NeverLosePatch
{
	private static bool Prefix(State nextState)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Invalid comparison between Unknown and I4
		if (Cheats.NeverLose)
		{
			return (int)nextState != 3;
		}
		return true;
	}
}
