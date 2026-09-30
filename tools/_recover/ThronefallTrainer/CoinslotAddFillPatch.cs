using HarmonyLib;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(Coinslot), "AddFill")]
internal static class CoinslotAddFillPatch
{
	private static void Prefix(ref float percentage)
	{
		if (Cheats.InstantBuild)
		{
			percentage = 1f;
		}
	}
}
