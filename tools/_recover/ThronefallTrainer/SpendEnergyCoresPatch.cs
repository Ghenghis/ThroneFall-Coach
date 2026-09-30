using HarmonyLib;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(PlayerInteraction), "SpendEnergyCores")]
internal static class SpendEnergyCoresPatch
{
	private static bool Prefix()
	{
		return !Cheats.FreeBuild;
	}
}
