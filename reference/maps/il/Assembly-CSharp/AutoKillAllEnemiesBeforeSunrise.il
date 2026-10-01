// ===== AutoKillAllEnemiesBeforeSunrise  (token 0x02000075) =====
  .method AutoKillAllEnemiesBeforeSunrise::Start()  // token 0x0600025D rva 0xad0b attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ret

  .method AutoKillAllEnemiesBeforeSunrise::OnDawn_AfterSunrise()  // token 0x0600025E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoKillAllEnemiesBeforeSunrise::OnDawn_BeforeSunrise()  // token 0x0600025F rva 0xad18 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: call void Hp::KillAllEnemyUnits()  /*0x06000835*/
    IL_0005: ret

  .method AutoKillAllEnemiesBeforeSunrise::OnDusk()  // token 0x06000260 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoKillAllEnemiesBeforeSunrise::OnDuskEarly()  // token 0x06000261 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoKillAllEnemiesBeforeSunrise::.ctor()  // token 0x06000262 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

