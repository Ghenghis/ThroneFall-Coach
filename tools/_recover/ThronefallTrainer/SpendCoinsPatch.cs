using HarmonyLib;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(PlayerInteraction), "SpendCoins")]
internal static class SpendCoinsPatch
{
	private static bool Prefix()
	{
		return !Cheats.FreeBuild;
	}
}
