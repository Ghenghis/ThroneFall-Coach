using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(Hp), "Start")]
internal static class HpStartPatch
{
	private static void Postfix(Hp __instance)
	{
		if (Cheats.EnemyHpEnabled && Cheats.EnemyHpMult != 1f)
		{
			TaggedObject taggedObj = __instance.TaggedObj;
			if ((Object)(object)taggedObj != (Object)null && taggedObj.Contains((ETag)1))
			{
				__instance.ScaleHp(Cheats.EnemyHpMult);
			}
		}
	}
}
