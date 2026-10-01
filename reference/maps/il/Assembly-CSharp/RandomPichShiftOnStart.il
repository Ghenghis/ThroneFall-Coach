// ===== RandomPichShiftOnStart  (token 0x02000251) =====
  .method RandomPichShiftOnStart::Awake()  // token 0x06000CA9 rva 0x3a2b6 attrs Private, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource RandomPichShiftOnStart::target  /*0x04000F57*/
    IL_0006: dup
    IL_0007: callvirt float UnityEngine.AudioSource::get_pitch()  /*0x0A0000CA*/
    IL_000c: ldarg.0
    IL_000d: ldfld float RandomPichShiftOnStart::radius  /*0x04000F58*/
    IL_0012: neg
    IL_0013: ldarg.0
    IL_0014: ldfld float RandomPichShiftOnStart::radius  /*0x04000F58*/
    IL_0019: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_001e: add
    IL_001f: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0024: ldarg.0
    IL_0025: ldfld AudioSource RandomPichShiftOnStart::target  /*0x04000F57*/
    IL_002a: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_002f: ret

  .method RandomPichShiftOnStart::.ctor()  // token 0x06000CAA rva 0x3a2e7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.075f
    IL_0006: stfld float RandomPichShiftOnStart::radius  /*0x04000F58*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

