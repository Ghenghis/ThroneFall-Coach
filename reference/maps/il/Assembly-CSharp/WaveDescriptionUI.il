// ===== WaveDescriptionUI  (token 0x02000389) =====
  .method WaveDescriptionUI::Start()  // token 0x06001376 rva 0x5c391 attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldfld GameObject WaveDescriptionUI::waveDescriptionPanel  /*0x04001797*/
    IL_0011: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0016: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001b: ldc.i4.0
    IL_001c: ceq
    IL_001e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0023: ret

  .method WaveDescriptionUI::OnDawn_AfterSunrise()  // token 0x06001377 rva 0x5c3b6 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject WaveDescriptionUI::waveDescriptionPanel  /*0x04001797*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method WaveDescriptionUI::OnDusk()  // token 0x06001378 rva 0x5c3c4 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject WaveDescriptionUI::waveDescriptionPanel  /*0x04001797*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method WaveDescriptionUI::OnDawn_BeforeSunrise()  // token 0x06001379 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveDescriptionUI::OnDuskEarly()  // token 0x0600137A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WaveDescriptionUI::.ctor()  // token 0x0600137B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

