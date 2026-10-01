// ===== TimeUtils  (token 0x0200039A) =====
  .method TimeUtils::get_CurrentSmoothedFps()  // token 0x060013BE rva 0x5de1e attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld float TimeUtils::<CurrentSmoothedFps>k__BackingField  /*0x0400180B*/
    IL_0005: ret

  .method TimeUtils::set_CurrentSmoothedFps(float)  // token 0x060013BF rva 0x5de25 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld float TimeUtils::<CurrentSmoothedFps>k__BackingField  /*0x0400180B*/
    IL_0006: ret

  .method TimeUtils::get_CurrentFps()  // token 0x060013C0 rva 0x5de2d attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld float TimeUtils::<CurrentFps>k__BackingField  /*0x0400180C*/
    IL_0005: ret

  .method TimeUtils::set_CurrentFps(float)  // token 0x060013C1 rva 0x5de34 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld float TimeUtils::<CurrentFps>k__BackingField  /*0x0400180C*/
    IL_0006: ret

  .method TimeUtils::get_InverseDeltaTime()  // token 0x060013C2 rva 0x5de3c attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld float TimeUtils::<InverseDeltaTime>k__BackingField  /*0x0400180D*/
    IL_0005: ret

  .method TimeUtils::set_InverseDeltaTime(float)  // token 0x060013C3 rva 0x5de43 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld float TimeUtils::<InverseDeltaTime>k__BackingField  /*0x0400180D*/
    IL_0006: ret

  .method TimeUtils::get_InverseDeltaTimeSqr()  // token 0x060013C4 rva 0x5de4b attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld float TimeUtils::<InverseDeltaTimeSqr>k__BackingField  /*0x0400180E*/
    IL_0005: ret

  .method TimeUtils::set_InverseDeltaTimeSqr(float)  // token 0x060013C5 rva 0x5de52 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld float TimeUtils::<InverseDeltaTimeSqr>k__BackingField  /*0x0400180E*/
    IL_0006: ret

  .method TimeUtils::Update()  // token 0x060013C6 rva 0x5de5c attrs Private, HideBySig
    // code size 99 (0x63), max stack 3, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldc.r4 1f
    IL_0005: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000a: div
    IL_000b: stloc.0
    IL_000c: ldc.r4 1f
    IL_0011: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0016: div
    IL_0017: call void TimeUtils::set_CurrentFps(float)  /*0x060013C1*/
    IL_001c: call float TimeUtils::get_CurrentFps()  /*0x060013C0*/
    IL_0021: ldloc.0
    IL_0022: ldarg.0
    IL_0023: ldfld float TimeUtils::smoothing  /*0x0400180F*/
    IL_0028: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_002d: call void TimeUtils::set_CurrentSmoothedFps(float)  /*0x060013BF*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: stloc.1
    IL_0038: ldloc.1
    IL_0039: ldc.r4 0f
    IL_003e: bgt.un.s IL_0046
    IL_0040: ldsfld float UnityEngine.Mathf::Epsilon  /*0x0A00077F*/
    IL_0045: stloc.1
    IL_0046: ldc.r4 1f
    IL_004b: ldloc.1
    IL_004c: div
    IL_004d: call void TimeUtils::set_InverseDeltaTime(float)  /*0x060013C3*/
    IL_0052: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0057: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_005c: mul
    IL_005d: call void TimeUtils::set_InverseDeltaTimeSqr(float)  /*0x060013C5*/
    IL_0062: ret

  .method TimeUtils::.ctor()  // token 0x060013C7 rva 0x5decb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float TimeUtils::smoothing  /*0x0400180F*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

