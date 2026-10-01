// ===== PlayerUpgradeManager  (token 0x02000243) =====
  .method PlayerUpgradeManager::get_PlayerDamageMultiplyer()  // token 0x06000C67 rva 0x3982c attrs Public, HideBySig, SpecialName
    // code size 84 (0x54), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PerkManager PlayerUpgradeManager::perkManager  /*0x04000F23*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0018
    IL_000d: ldarg.0
    IL_000e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0013: stfld PerkManager PlayerUpgradeManager::perkManager  /*0x04000F23*/
    IL_0018: ldarg.0
    IL_0019: ldfld PerkManager PlayerUpgradeManager::perkManager  /*0x04000F23*/
    IL_001e: callvirt bool PerkManager::get_RiskTakerEquipped()  /*0x06000995*/
    IL_0023: brfalse.s IL_004d
    IL_0025: ldarg.0
    IL_0026: ldfld PerkManager PlayerUpgradeManager::perkManager  /*0x04000F23*/
    IL_002b: ldfld float PerkManager::riskTakerMaxBonusDamageMultiplyer  /*0x04000C3D*/
    IL_0030: ldc.r4 1f
    IL_0035: ldarg.0
    IL_0036: ldfld Hp PlayerUpgradeManager::hp  /*0x04000F21*/
    IL_003b: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0040: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0045: ldarg.0
    IL_0046: ldfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_004b: mul
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: ldfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0053: ret

  .method PlayerUpgradeManager::set_PlayerDamageMultiplyer(float)  // token 0x06000C68 rva 0x3988c attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0007: ret

  .method PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  // token 0x06000C69 rva 0x39895 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayerUpgradeManager::playerHealthRegenerationMultiplyer  /*0x04000F25*/
    IL_0006: ret

  .method PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  // token 0x06000C6A rva 0x3989d attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float PlayerUpgradeManager::playerHealthRegenerationMultiplyer  /*0x04000F25*/
    IL_0007: ret

  .method PlayerUpgradeManager::Awake()  // token 0x06000C6B rva 0x398a6 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0006: ret

  .method PlayerUpgradeManager::Start()  // token 0x06000C6C rva 0x398b0 attrs Private, HideBySig
    // code size 105 (0x69), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0006: stfld PerkManager PlayerUpgradeManager::perkManager  /*0x04000F23*/
    IL_000b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0010: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0015: brfalse.s IL_0022
    IL_0017: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001c: ldarg.0
    IL_001d: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0022: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0027: callvirt bool PerkManager::get_CommanderModeActive()  /*0x06000980*/
    IL_002c: brfalse.s IL_0045
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0035: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003a: ldfld float PerkManager::commanderModeSelfDmgMulti  /*0x04000C08*/
    IL_003f: mul
    IL_0040: stfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0045: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004a: callvirt bool PerkManager::get_GlassCanonActive()  /*0x06000981*/
    IL_004f: brfalse.s IL_0068
    IL_0051: ldarg.0
    IL_0052: ldarg.0
    IL_0053: ldfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0058: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005d: ldfld float PerkManager::glassCanon_dmgMulti  /*0x04000C0A*/
    IL_0062: mul
    IL_0063: stfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0068: ret

  .method PlayerUpgradeManager::OnDusk()  // token 0x06000C6D rva 0x39925 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PlayerUpgradeManager::GetStrongerIfInWarriorMode()  /*0x06000C70*/
    IL_0006: ret

  .method PlayerUpgradeManager::OnDawn_AfterSunrise()  // token 0x06000C6E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager::OnDawn_BeforeSunrise()  // token 0x06000C6F rva 0x39925 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PlayerUpgradeManager::GetStrongerIfInWarriorMode()  /*0x06000C70*/
    IL_0006: ret

  .method PlayerUpgradeManager::GetStrongerIfInWarriorMode()  // token 0x06000C70 rva 0x39930 attrs Public, HideBySig
    // code size 92 (0x5c), max stack 5, init locals
    IL_0000: br.s IL_003d
    IL_0002: ldarg.0
    IL_0003: ldarg.0
    IL_0004: ldfld int PlayerUpgradeManager::damageIncreases  /*0x04000F2B*/
    IL_0009: ldc.i4.1
    IL_000a: add
    IL_000b: stfld int PlayerUpgradeManager::damageIncreases  /*0x04000F2B*/
    IL_0010: ldarg.0
    IL_0011: ldarg.0
    IL_0012: ldfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_0017: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001c: ldfld float PerkManager::warriorModeSelfDmgMultiMax  /*0x04000C05*/
    IL_0021: ldc.r4 1f
    IL_0026: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002b: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_0030: conv.r4
    IL_0031: div
    IL_0032: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0037: mul
    IL_0038: stfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_003d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0042: callvirt bool PerkManager::get_WarriorModeActive()  /*0x0600097F*/
    IL_0047: brfalse.s IL_005b
    IL_0049: ldarg.0
    IL_004a: ldfld int PlayerUpgradeManager::damageIncreases  /*0x04000F2B*/
    IL_004f: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0054: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0059: blt.s IL_0002
    IL_005b: ret

  .method PlayerUpgradeManager::OnDuskEarly()  // token 0x06000C71 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager::OnBeforeMainLoadPass(string)  // token 0x06000C72 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager::OnLoad(string)  // token 0x06000C73 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager::OnAfterMainLoadPass(string)  // token 0x06000C74 rva 0x39998 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator PlayerUpgradeManager::DelayLoadedGetStronger()  /*0x06000C76*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method PlayerUpgradeManager::OnSave(string)  // token 0x06000C75 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager::DelayLoadedGetStronger()  // token 0x06000C76 rva 0x399a7 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::.ctor(int)  /*0x06000C78*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlayerUpgradeManager PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>4__this  /*0x04000F2E*/
    IL_000d: ret

  .method PlayerUpgradeManager::.ctor()  // token 0x06000C77 rva 0x399b6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float PlayerUpgradeManager::playerDamageMultiplyer  /*0x04000F24*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float PlayerUpgradeManager::playerHealthRegenerationMultiplyer  /*0x04000F25*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.5f
    IL_001c: stfld float PlayerUpgradeManager::godlyCurseDamageMultiplyer  /*0x04000F2A*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== PlayerUpgradeManager/<DelayLoadedGetStronger>d__28  (token 0x02000244) =====
  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::.ctor(int)  // token 0x06000C78 rva 0x399df attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_000d: ret

  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::System.IDisposable.Dispose()  // token 0x06000C79 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::MoveNext()  // token 0x06000C7A rva 0x399f0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 95 (0x5f), max stack 2, init locals
    .locals ([0] int, [1] PlayerUpgradeManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerUpgradeManager PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>4__this  /*0x04000F2E*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>2__current  /*0x04000F2D*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>2__current  /*0x04000F2D*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>1__state  /*0x04000F2C*/
    IL_0057: ldloc.1
    IL_0058: call void PlayerUpgradeManager::GetStrongerIfInWarriorMode()  /*0x06000C70*/
    IL_005d: ldc.i4.0
    IL_005e: ret

  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000C7B rva 0x39a5b attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>2__current  /*0x04000F2D*/
    IL_0006: ret

  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::System.Collections.IEnumerator.Reset()  // token 0x06000C7C rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::System.Collections.IEnumerator.get_Current()  // token 0x06000C7D rva 0x39a5b attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerUpgradeManager.<DelayLoadedGetStronger>d__28::<>2__current  /*0x04000F2D*/
    IL_0006: ret

