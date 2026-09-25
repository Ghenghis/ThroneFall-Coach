using HarmonyLib;
using UnityEngine;

namespace ThronefallTrainer
{
    /// <summary>
    /// God mode + player damage multiplier + enemy damage scaling, all at the
    /// single choke point every unit/building damage call goes through.
    /// </summary>
    [HarmonyPatch(typeof(Hp), "TakeDamage")]
    internal static class HpTakeDamagePatch
    {
        private static bool Prefix(Hp __instance, ref float _amount, TaggedObject _damageComingFrom, bool causedByPlayer)
        {
            TaggedObject tagged = __instance.TaggedObj;
            if (tagged == null)
                return true;

            bool targetIsPlayerOwned = tagged.Contains(TagManager.ETag.PlayerOwned);
            bool attackerIsEnemy = _damageComingFrom != null &&
                                   _damageComingFrom.Contains(TagManager.ETag.EnemyOwned);

            // Enemy -> player damage scaling ("harmless enemies" when set to 0).
            if (targetIsPlayerOwned && attackerIsEnemy && Cheats.EnemyDamageEnabled)
            {
                _amount *= Cheats.EnemyDamageMult;
                if (_amount <= 0f)
                    return false;
            }

            // Incoming damage blocked entirely for protected targets.
            if (Cheats.GodAll && targetIsPlayerOwned)
                return false;
            if (Cheats.GodHero && tagged.Contains(TagManager.ETag.Player))
                return false;

            // Outgoing (player-caused) damage boost / instant kill.
            if (tagged.Contains(TagManager.ETag.EnemyOwned) &&
                (causedByPlayer || (_damageComingFrom != null && _damageComingFrom.Contains(TagManager.ETag.PlayerOwned))))
            {
                if (Cheats.InstantKill)
                    _amount = float.MaxValue;
                else if (Cheats.DamageMultEnabled)
                    _amount *= Cheats.DamageMultiplier;
            }
            return true;
        }
    }

    /// <summary>Free build: coin spends become no-ops (floor of 1 is maintained in Plugin.Update).</summary>
    [HarmonyPatch(typeof(PlayerInteraction), "SpendCoins")]
    internal static class SpendCoinsPatch
    {
        private static bool Prefix() => !Cheats.FreeBuild;
    }

    /// <summary>Free build also covers the DLC energy-core currency.</summary>
    [HarmonyPatch(typeof(PlayerInteraction), "SpendEnergyCores")]
    internal static class SpendEnergyCoresPatch
    {
        private static bool Prefix() => !Cheats.FreeBuild;
    }

    /// <summary>
    /// Instant build: each hold-to-pay frame fills a whole coin slot
    /// (Coinslot.AddFill is the per-coin progress call in CostDisplay.FillUp).
    /// </summary>
    [HarmonyPatch(typeof(Coinslot), "AddFill")]
    internal static class CoinslotAddFillPatch
    {
        private static void Prefix(ref float percentage)
        {
            if (Cheats.InstantBuild)
                percentage = 1f;
        }
    }

    /// <summary>
    /// Enemy HP scaling at spawn: Hp.Start runs for every spawned unit and
    /// covers both Spawn.Update-spawned waves and AdjustEnemyParametersAfterSpawn
    /// spawns, so we don't need to touch the spawn internals.
    /// </summary>
    [HarmonyPatch(typeof(Hp), "Start")]
    internal static class HpStartPatch
    {
        private static void Postfix(Hp __instance)
        {
            if (!Cheats.EnemyHpEnabled || Cheats.EnemyHpMult == 1f)
                return;
            TaggedObject tagged = __instance.TaggedObj;
            if (tagged != null && tagged.Contains(TagManager.ETag.EnemyOwned))
                __instance.ScaleHp(Cheats.EnemyHpMult);
        }
    }

    /// <summary>
    /// Never lose: the only defeat path is LocalGamestate.SetState(AfterMatchDefeat)
    /// (vital-object destruction and cutscene deaths all funnel through it).
    /// </summary>
    [HarmonyPatch(typeof(LocalGamestate), "SetState")]
    internal static class NeverLosePatch
    {
        private static bool Prefix(LocalGamestate.State nextState)
        {
            return !(Cheats.NeverLose && nextState == LocalGamestate.State.AfterMatchDefeat);
        }
    }

    /// <summary>
    /// Multi-shot: every Weapon.Attack call is exactly one projectile/hit, so we
    /// re-enter it N-1 extra times from a reentrancy-guarded prefix. Restricted
    /// to PlayerOwned attackers (hero weapon, towers, troops, abilities).
    /// </summary>
    [HarmonyPatch(typeof(Weapon), "Attack")]
    internal static class MultiShotPatch
    {
        private static bool reentrant;

        private static bool Prefix(Weapon __instance, Vector3 _attackOrigin, Hp _target,
            Vector3 _attackDirection, TaggedObject _attacker,
            float _finalDamageMultiplyer, float _projectileSpeedMultiplyer)
        {
            if (reentrant || !Cheats.MultiShotEnabled || _attacker == null ||
                !_attacker.Contains(TagManager.ETag.PlayerOwned))
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
                        __instance.Attack(_attackOrigin, _target, _attackDirection,
                                          _attacker, _finalDamageMultiplyer, _projectileSpeedMultiplyer);
                    }
                    catch (System.Exception)
                    {
                        break; // projectile pool exhausted - stop, keep the shot
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
}
