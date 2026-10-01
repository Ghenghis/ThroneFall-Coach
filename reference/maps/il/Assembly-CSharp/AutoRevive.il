// ===== AutoRevive  (token 0x02000076) =====
  .method AutoRevive::OnDusk()  // token 0x06000263 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoRevive::OnDawn_AfterSunrise()  // token 0x06000264 rva 0xad1f attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_0007: ret

  .method AutoRevive::OnDawn_BeforeSunrise()  // token 0x06000265 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoRevive::Start()  // token 0x06000266 rva 0xad28 attrs Private, HideBySig
    // code size 117 (0x75), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0006: stfld DayNightCycle AutoRevive::dayNightCycle  /*0x0400033D*/
    IL_000b: ldarg.0
    IL_000c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0011: callvirt bool PerkManager::get_GodOfDeathActive()  /*0x06000989*/
    IL_0016: stfld bool AutoRevive::godOfDeathActive  /*0x04000339*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld Equippable AutoRevive::explosiveRevivalPerk  /*0x0400033C*/
    IL_0022: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0027: stfld bool AutoRevive::explosiveRevivalActive  /*0x0400033A*/
    IL_002c: ldarg.0
    IL_002d: ldfld bool AutoRevive::godOfDeathActive  /*0x04000339*/
    IL_0032: brfalse.s IL_004b
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld float AutoRevive::reviveAfterBeingKnockedOutFor  /*0x04000334*/
    IL_003b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0040: ldfld float PerkManager::godOfDeath_playerRespawnMultiplyer  /*0x04000C20*/
    IL_0045: mul
    IL_0046: stfld float AutoRevive::reviveAfterBeingKnockedOutFor  /*0x04000334*/
    IL_004b: ldarg.0
    IL_004c: ldarg.0
    IL_004d: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0052: stfld Hp AutoRevive::hp  /*0x04000333*/
    IL_0057: ldarg.0
    IL_0058: ldarg.0
    IL_0059: ldfld Equippable AutoRevive::ringOfResurectionPerk  /*0x0400033E*/
    IL_005e: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0063: stfld bool AutoRevive::ringOfResurection  /*0x04000337*/
    IL_0068: ldarg.0
    IL_0069: ldfld DayNightCycle AutoRevive::dayNightCycle  /*0x0400033D*/
    IL_006e: ldarg.0
    IL_006f: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0074: ret

  .method AutoRevive::get_ReviveAfterBeingKnockedOutFor()  // token 0x06000267 rva 0xada9 attrs Private, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoRevive::ringOfResurection  /*0x04000337*/
    IL_0006: brfalse.s IL_0016
    IL_0008: ldarg.0
    IL_0009: ldfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_000e: brfalse.s IL_0016
    IL_0010: ldc.r4 2f
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldfld float AutoRevive::reviveAfterBeingKnockedOutFor  /*0x04000334*/
    IL_001c: ret

  .method AutoRevive::Update()  // token 0x06000268 rva 0xadc8 attrs Private, HideBySig
    // code size 301 (0x12d), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp AutoRevive::hp  /*0x04000333*/
    IL_0006: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_000b: brfalse IL_0121
    IL_0010: ldarg.0
    IL_0011: ldfld DayNightCycle AutoRevive::dayNightCycle  /*0x0400033D*/
    IL_0016: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001b: brtrue.s IL_0039
    IL_001d: ldarg.0
    IL_001e: ldfld Hp AutoRevive::hp  /*0x04000333*/
    IL_0023: ldc.i4.1
    IL_0024: ldc.r4 1f
    IL_0029: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_002e: ldarg.0
    IL_002f: ldfld UnityEvent AutoRevive::onReviveTrigger  /*0x04000332*/
    IL_0034: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_0040: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0045: add
    IL_0046: stfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_004b: ldarg.0
    IL_004c: ldfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_0051: ldarg.0
    IL_0052: call float AutoRevive::get_ReviveAfterBeingKnockedOutFor()  /*0x06000267*/
    IL_0057: blt.un IL_012c
    IL_005c: ldarg.0
    IL_005d: ldfld bool AutoRevive::ringOfResurection  /*0x04000337*/
    IL_0062: brfalse.s IL_007f
    IL_0064: ldarg.0
    IL_0065: ldfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_006a: brfalse.s IL_007f
    IL_006c: ldarg.0
    IL_006d: ldfld Hp AutoRevive::hp  /*0x04000333*/
    IL_0072: ldc.i4.1
    IL_0073: ldc.r4 1f
    IL_0078: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_007d: br.s IL_00b4
    IL_007f: ldarg.0
    IL_0080: ldfld Hp AutoRevive::hp  /*0x04000333*/
    IL_0085: ldc.i4.1
    IL_0086: ldarg.0
    IL_0087: ldfld PlayerHpRegen AutoRevive::playerHpRegen  /*0x04000331*/
    IL_008c: callvirt float PlayerHpRegen::get_HealingPerSecond()  /*0x06000B9D*/
    IL_0091: ldarg.0
    IL_0092: ldfld float AutoRevive::refillHealthForSecs  /*0x04000335*/
    IL_0097: mul
    IL_0098: ldarg.0
    IL_0099: ldfld Hp AutoRevive::hp  /*0x04000333*/
    IL_009e: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00a3: div
    IL_00a4: ldarg.0
    IL_00a5: ldfld float AutoRevive::minHealthOnRevive  /*0x0400033F*/
    IL_00aa: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_00af: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld bool AutoRevive::ringOfResurection  /*0x04000337*/
    IL_00ba: brfalse.s IL_00df
    IL_00bc: ldarg.0
    IL_00bd: ldfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_00c2: brfalse.s IL_00df
    IL_00c4: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_00c9: dup
    IL_00ca: ldc.i4.7
    IL_00cb: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_00d0: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_00d5: ldc.r4 1f
    IL_00da: call void Hp::ReviveAllUnitsWithTag(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,float)  /*0x06000830*/
    IL_00df: ldarg.0
    IL_00e0: ldfld bool AutoRevive::explosiveRevivalActive  /*0x0400033A*/
    IL_00e5: brfalse.s IL_010e
    IL_00e7: ldarg.0
    IL_00e8: ldfld Weapon AutoRevive::explosiveRevivalWeapon  /*0x0400033B*/
    IL_00ed: ldarg.0
    IL_00ee: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f8: ldnull
    IL_00f9: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00fe: ldnull
    IL_00ff: ldc.r4 1f
    IL_0104: ldc.r4 1f
    IL_0109: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_010e: ldarg.0
    IL_010f: ldfld UnityEvent AutoRevive::onReviveTrigger  /*0x04000332*/
    IL_0114: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0119: ldarg.0
    IL_011a: ldc.i4.0
    IL_011b: stfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_0120: ret
    IL_0121: ldarg.0
    IL_0122: ldc.r4 0f
    IL_0127: stfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_012c: ret

  .method AutoRevive::get_TimeTillRevive()  // token 0x06000269 rva 0xaf01 attrs Public, HideBySig, SpecialName
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_0006: ldc.r4 0f
    IL_000b: bgt.un.s IL_0013
    IL_000d: ldc.r4 -1f
    IL_0012: ret
    IL_0013: ldarg.0
    IL_0014: call float AutoRevive::get_ReviveAfterBeingKnockedOutFor()  /*0x06000267*/
    IL_0019: ldarg.0
    IL_001a: ldfld float AutoRevive::hasBeenKnockedOutFor  /*0x04000336*/
    IL_001f: sub
    IL_0020: ret

  .method AutoRevive::OnDuskEarly()  // token 0x0600026A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoRevive::.ctor()  // token 0x0600026B rva 0xaf23 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent AutoRevive::onReviveTrigger  /*0x04000332*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 20f
    IL_0011: stfld float AutoRevive::reviveAfterBeingKnockedOutFor  /*0x04000334*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 10f
    IL_001c: stfld float AutoRevive::refillHealthForSecs  /*0x04000335*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld bool AutoRevive::quickReviveAvailable  /*0x04000338*/
    IL_0028: ldarg.0
    IL_0029: ldc.r4 0.05f
    IL_002e: stfld float AutoRevive::minHealthOnRevive  /*0x0400033F*/
    IL_0033: ldarg.0
    IL_0034: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0039: ret

