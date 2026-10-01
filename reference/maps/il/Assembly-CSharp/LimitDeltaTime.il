// ===== LimitDeltaTime  (token 0x020001B8) =====
  .method LimitDeltaTime::Start()  // token 0x060008F3 rva 0x2b02b attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float LimitDeltaTime::maxDeltaTimeInMs  /*0x04000B40*/
    IL_0006: ldc.r4 1000f
    IL_000b: div
    IL_000c: call void UnityEngine.Time::set_maximumDeltaTime(float)  /*0x0A0003DA*/
    IL_0011: ret

  .method LimitDeltaTime::.ctor()  // token 0x060008F4 rva 0x2b03e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 16f
    IL_0006: stfld float LimitDeltaTime::maxDeltaTimeInMs  /*0x04000B40*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

