using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(Hp), "TakeDamage")]
internal static class HpTakeDamagePatch
{
	private static bool Prefix(Hp __instance, ref float _amount, TaggedObject _damageComingFrom, bool causedByPlayer)
	{
		TaggedObject taggedObj = __instance.TaggedObj;
		if ((Object)(object)taggedObj == (Object)null)
		{
			return true;
		}
		bool flag = taggedObj.Contains((ETag)0);
		bool flag2 = (Object)(object)_damageComingFrom != (Object)null && _damageComingFrom.Contains((ETag)1);
		if ((flag & flag2) && Cheats.EnemyDamageEnabled)
		{
			_amount *= Cheats.EnemyDamageMult;
			if (_amount <= 0f)
			{
				return false;
			}
		}
		if (Cheats.GodAll & flag)
		{
			return false;
		}
		if (Cheats.GodHero && taggedObj.Contains((ETag)2))
		{
			return false;
		}
		if (taggedObj.Contains((ETag)1) && (causedByPlayer || ((Object)(object)_damageComingFrom != (Object)null && _damageComingFrom.Contains((ETag)0))))
		{
			if (Cheats.InstantKill)
			{
				_amount = float.MaxValue;
			}
			else if (Cheats.DamageMultEnabled)
			{
				_amount *= Cheats.DamageMultiplier;
			}
		}
		return true;
	}
}
