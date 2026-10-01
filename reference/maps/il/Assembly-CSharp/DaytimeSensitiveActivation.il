// ===== DaytimeSensitiveActivation  (token 0x020000AE) =====
  .method DaytimeSensitiveActivation::OnDawn_AfterSunrise()  // token 0x060003C2 rva 0x10b8b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DaytimeSensitiveActivation::activeTime  /*0x040004C9*/
    IL_0006: brtrue.s IL_0015
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_001b: ldc.i4.0
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ret

  .method DaytimeSensitiveActivation::OnDawn_BeforeSunrise()  // token 0x060003C3 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveActivation::OnDusk()  // token 0x060003C4 rva 0x10bae attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DaytimeSensitiveActivation::activeTime  /*0x040004C9*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_0016
    IL_0009: ldarg.0
    IL_000a: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_000f: ldc.i4.1
    IL_0010: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_001c: ldc.i4.0
    IL_001d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0022: ret

  .method DaytimeSensitiveActivation::Start()  // token 0x060003C5 rva 0x10bd4 attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0010: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0015: brtrue.s IL_002c
    IL_0017: ldarg.0
    IL_0018: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_001d: ldarg.0
    IL_001e: ldfld DayNightCycle.Timestate DaytimeSensitiveActivation::activeTime  /*0x040004C9*/
    IL_0023: ldc.i4.0
    IL_0024: ceq
    IL_0026: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject DaytimeSensitiveActivation::target  /*0x040004CA*/
    IL_0032: ldarg.0
    IL_0033: ldfld DayNightCycle.Timestate DaytimeSensitiveActivation::activeTime  /*0x040004C9*/
    IL_0038: ldc.i4.1
    IL_0039: ceq
    IL_003b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0040: ret

  .method DaytimeSensitiveActivation::OnDuskEarly()  // token 0x060003C6 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveActivation::.ctor()  // token 0x060003C7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

