// ===== OnDeathKillAllPlayerUnits  (token 0x02000203) =====
  .method OnDeathKillAllPlayerUnits::Start()  // token 0x06000AC6 rva 0x333f1 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0006: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_000b: ldarg.0
    IL_000c: ldftn void OnDeathKillAllPlayerUnits::OnDeath()  /*0x06000AC7*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method OnDeathKillAllPlayerUnits::OnDeath()  // token 0x06000AC7 rva 0x3340f attrs Private, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: call void Hp::KillAllPlayerUnits()  /*0x06000836*/
    IL_0005: ret

  .method OnDeathKillAllPlayerUnits::.ctor()  // token 0x06000AC8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

