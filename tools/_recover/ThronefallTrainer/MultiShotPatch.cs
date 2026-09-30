using System;
using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer;

[HarmonyPatch(typeof(Weapon), "Attack")]
internal static class MultiShotPatch
{
	private static bool reentrant;

	private static bool Prefix(Weapon __instance, Vector3 _attackOrigin, Hp _target, Vector3 _attackDirection, TaggedObject _attacker, float _finalDamageMultiplyer, float _projectileSpeedMultiplyer)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		if (reentrant || !Cheats.MultiShotEnabled || (Object)(object)_attacker == (Object)null || !_attacker.Contains((ETag)0))
		{
			return true;
		}
		reentrant = true;
		try
		{
			for (int i = 1; i < Cheats.MultiShotCount; i++)
			{
				try
				{
					__instance.Attack(_attackOrigin, _target, _attackDirection, _attacker, _finalDamageMultiplyer, _projectileSpeedMultiplyer);
				}
				catch (Exception)
				{
					break;
				}
			}
		}
		finally
		{
			reentrant = false;
		}
		return true;
	}
}
