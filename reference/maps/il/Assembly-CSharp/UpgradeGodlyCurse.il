// ===== UpgradeGodlyCurse  (token 0x0200023F) =====
  .method UpgradeGodlyCurse::Awake()  // token 0x06000C58 rva 0x39708 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld UpgradeGodlyCurse UpgradeGodlyCurse::instance  /*0x04000F18*/
    IL_0006: ret

  .method UpgradeGodlyCurse::OnEnable()  // token 0x06000C59 rva 0x39710 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0010: ldc.i4.1
    IL_0011: stfld bool PlayerUpgradeManager::godlyCurse  /*0x04000F27*/
    IL_0016: ret

  .method UpgradeGodlyCurse::Damage(Hp)  // token 0x06000C5A rva 0x39728 attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<Hp> UpgradeGodlyCurse::damagedHpObjects  /*0x04000F1A*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.HashSet<Hp>::Contains(!0)  /*0x0A000516*/
    IL_000c: brtrue.s IL_0032
    IL_000e: ldarg.1
    IL_000f: ldarg.1
    IL_0010: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0015: ldarg.0
    IL_0016: ldfld float UpgradeGodlyCurse::damagePercentage  /*0x04000F19*/
    IL_001b: mul
    IL_001c: ldnull
    IL_001d: ldc.i4.0
    IL_001e: ldc.i4.1
    IL_001f: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0024: pop
    IL_0025: ldarg.0
    IL_0026: ldfld HashSet<Hp> UpgradeGodlyCurse::damagedHpObjects  /*0x04000F1A*/
    IL_002b: ldarg.1
    IL_002c: callvirt bool System.Collections.Generic.HashSet<Hp>::Add(!0)  /*0x0A000517*/
    IL_0031: pop
    IL_0032: ret

  .method UpgradeGodlyCurse::OnDuskEarly()  // token 0x06000C5B rva 0x3975c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<Hp> UpgradeGodlyCurse::damagedHpObjects  /*0x04000F1A*/
    IL_0006: callvirt void System.Collections.Generic.HashSet<Hp>::Clear()  /*0x0A000518*/
    IL_000b: ret

  .method UpgradeGodlyCurse::OnDusk()  // token 0x06000C5C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeGodlyCurse::OnDawn_AfterSunrise()  // token 0x06000C5D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeGodlyCurse::OnDawn_BeforeSunrise()  // token 0x06000C5E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UpgradeGodlyCurse::.ctor()  // token 0x06000C5F rva 0x39769 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.HashSet<Hp>::.ctor()  /*0x0A000519*/
    IL_0006: stfld HashSet<Hp> UpgradeGodlyCurse::damagedHpObjects  /*0x04000F1A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

