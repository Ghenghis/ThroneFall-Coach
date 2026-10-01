// ===== ShieldOnFirstDamaged  (token 0x0200028E) =====
  .method ShieldOnFirstDamaged::Reset()  // token 0x06000E06 rva 0x3eeaa attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool ShieldOnFirstDamaged::shieldAvailable  /*0x0400105A*/
    IL_000e: ldarg.0
    IL_000f: ldc.r4 0f
    IL_0014: stfld float ShieldOnFirstDamaged::shiledHasBeenActiveFor  /*0x04001058*/
    IL_0019: ldarg.0
    IL_001a: ldc.i4.0
    IL_001b: call void ShieldOnFirstDamaged::SetShieldVisuals(bool)  /*0x06000E0A*/
    IL_0020: ret

  .method ShieldOnFirstDamaged::Update()  // token 0x06000E07 rva 0x3eecc attrs Private, HideBySig
    // code size 74 (0x4a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_0006: brfalse.s IL_0049
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld float ShieldOnFirstDamaged::shiledHasBeenActiveFor  /*0x04001058*/
    IL_000f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0014: add
    IL_0015: stfld float ShieldOnFirstDamaged::shiledHasBeenActiveFor  /*0x04001058*/
    IL_001a: ldarg.0
    IL_001b: ldfld float ShieldOnFirstDamaged::shiledHasBeenActiveFor  /*0x04001058*/
    IL_0020: ldarg.0
    IL_0021: ldfld float ShieldOnFirstDamaged::shieldDuration  /*0x04001056*/
    IL_0026: blt.un.s IL_0049
    IL_0028: ldarg.0
    IL_0029: ldc.i4.0
    IL_002a: stfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.0
    IL_0031: stfld bool ShieldOnFirstDamaged::shieldAvailable  /*0x0400105A*/
    IL_0036: ldarg.0
    IL_0037: ldfld Hp ShieldOnFirstDamaged::hpToShield  /*0x04001055*/
    IL_003c: ldc.i4.0
    IL_003d: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0042: ldarg.0
    IL_0043: ldc.i4.0
    IL_0044: call void ShieldOnFirstDamaged::SetShieldVisuals(bool)  /*0x06000E0A*/
    IL_0049: ret

  .method ShieldOnFirstDamaged::Start()  // token 0x06000E08 rva 0x3ef22 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ShieldOnFirstDamaged::Reset()  /*0x06000E06*/
    IL_0006: ldarg.0
    IL_0007: ldfld Hp ShieldOnFirstDamaged::hpToShield  /*0x04001055*/
    IL_000c: ldfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_0011: ldarg.0
    IL_0012: ldftn void ShieldOnFirstDamaged::OnDamaged(bool)  /*0x06000E09*/
    IL_0018: newobj void UnityEngine.Events.UnityAction<bool>::.ctor(object,IntPtr)  /*0x0A0000CC*/
    IL_001d: callvirt void UnityEngine.Events.UnityEvent<bool>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0000CD*/
    IL_0022: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0027: ldarg.0
    IL_0028: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_002d: ret

  .method ShieldOnFirstDamaged::OnDamaged(bool)  // token 0x06000E09 rva 0x3ef51 attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_0006: brtrue.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool ShieldOnFirstDamaged::shieldAvailable  /*0x0400105A*/
    IL_000e: brfalse.s IL_003d
    IL_0010: ldarg.0
    IL_0011: ldfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_0016: brtrue.s IL_001f
    IL_0018: ldarg.0
    IL_0019: ldc.i4.1
    IL_001a: call void ShieldOnFirstDamaged::SetShieldVisuals(bool)  /*0x06000E0A*/
    IL_001f: ldarg.0
    IL_0020: ldfld Hp ShieldOnFirstDamaged::hpToShield  /*0x04001055*/
    IL_0025: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_002a: ldarg.0
    IL_002b: ldfld Hp ShieldOnFirstDamaged::hpToShield  /*0x04001055*/
    IL_0030: ldc.i4.1
    IL_0031: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0036: ldarg.0
    IL_0037: ldc.i4.1
    IL_0038: stfld bool ShieldOnFirstDamaged::shieldActive  /*0x04001059*/
    IL_003d: ret

  .method ShieldOnFirstDamaged::SetShieldVisuals(bool)  // token 0x06000E0A rva 0x3ef90 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ShieldOnFirstDamaged::shieldVisuals  /*0x04001057*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method ShieldOnFirstDamaged::OnDawn_AfterSunrise()  // token 0x06000E0B rva 0x3ef9e attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ShieldOnFirstDamaged::Reset()  /*0x06000E06*/
    IL_0006: ret

  .method ShieldOnFirstDamaged::OnDawn_BeforeSunrise()  // token 0x06000E0C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ShieldOnFirstDamaged::OnDusk()  // token 0x06000E0D rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ShieldOnFirstDamaged::OnDuskEarly()  // token 0x06000E0E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ShieldOnFirstDamaged::.ctor()  // token 0x06000E0F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

