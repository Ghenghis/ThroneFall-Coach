// ===== IncreaseAttackSpeedOverTime  (token 0x02000196) =====
  .method IncreaseAttackSpeedOverTime::Start()  // token 0x0600083C rva 0xad0b attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ret

  .method IncreaseAttackSpeedOverTime::Update()  // token 0x0600083D rva 0x28708 attrs Private, HideBySig
    // code size 109 (0x6d), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack IncreaseAttackSpeedOverTime::autoAttack  /*0x04000A58*/
    IL_0006: ldfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_000b: brfalse.s IL_0049
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_0014: ldarg.0
    IL_0015: ldfld float IncreaseAttackSpeedOverTime::increaseSpeed  /*0x04000A5A*/
    IL_001a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001f: mul
    IL_0020: add
    IL_0021: ldarg.0
    IL_0022: ldfld float IncreaseAttackSpeedOverTime::maximumAdditionalCooldownSpeed  /*0x04000A59*/
    IL_0027: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_002c: stfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_0031: ldarg.0
    IL_0032: ldfld AutoAttack IncreaseAttackSpeedOverTime::autoAttack  /*0x04000A58*/
    IL_0037: ldarg.0
    IL_0038: ldfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_003d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0042: mul
    IL_0043: callvirt void AutoAttack::ReduceCooldownBy(float)  /*0x06000231*/
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: ldarg.0
    IL_004b: ldfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_0050: ldarg.0
    IL_0051: ldfld float IncreaseAttackSpeedOverTime::decreaseSpeed  /*0x04000A5B*/
    IL_0056: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005b: mul
    IL_005c: sub
    IL_005d: ldc.r4 0f
    IL_0062: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0067: stfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_006c: ret

  .method IncreaseAttackSpeedOverTime::OnDawn_AfterSunrise()  // token 0x0600083E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncreaseAttackSpeedOverTime::OnDawn_BeforeSunrise()  // token 0x0600083F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncreaseAttackSpeedOverTime::OnDusk()  // token 0x06000840 rva 0x28781 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: stfld float IncreaseAttackSpeedOverTime::additionalCooldownSpeed  /*0x04000A5C*/
    IL_000b: ret

  .method IncreaseAttackSpeedOverTime::OnDuskEarly()  // token 0x06000841 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncreaseAttackSpeedOverTime::.ctor()  // token 0x06000842 rva 0x2878e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float IncreaseAttackSpeedOverTime::maximumAdditionalCooldownSpeed  /*0x04000A59*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.1f
    IL_0011: stfld float IncreaseAttackSpeedOverTime::increaseSpeed  /*0x04000A5A*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float IncreaseAttackSpeedOverTime::decreaseSpeed  /*0x04000A5B*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

