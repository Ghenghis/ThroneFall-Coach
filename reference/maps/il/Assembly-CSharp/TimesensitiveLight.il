// ===== TimesensitiveLight  (token 0x020002B8) =====
  .method TimesensitiveLight::OnDawn_AfterSunrise()  // token 0x06000EF5 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TimesensitiveLight::OnDawn_BeforeSunrise()  // token 0x06000EF6 rva 0x432dc attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float TimesensitiveLight::blendTime  /*0x04001149*/
    IL_000e: call IEnumerator TimesensitiveLight::BlendToDay(float)  /*0x06000EFA*/
    IL_0013: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0018: pop
    IL_0019: ret

  .method TimesensitiveLight::OnDusk()  // token 0x06000EF7 rva 0x432f7 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float TimesensitiveLight::blendTime  /*0x04001149*/
    IL_000e: call IEnumerator TimesensitiveLight::BlendToNight(float)  /*0x06000EF9*/
    IL_0013: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0018: pop
    IL_0019: ret

  .method TimesensitiveLight::Start()  // token 0x06000EF8 rva 0x43314 attrs Private, HideBySig
    // code size 73 (0x49), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Light>  /*0x2B00002C*/
    IL_0007: stfld Light TimesensitiveLight::target  /*0x0400114A*/
    IL_000c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0011: ldarg.0
    IL_0012: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0017: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001c: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0021: brtrue.s IL_0036
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: ldc.r4 0f
    IL_002a: call IEnumerator TimesensitiveLight::BlendToDay(float)  /*0x06000EFA*/
    IL_002f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0034: pop
    IL_0035: ret
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0f
    IL_003d: call IEnumerator TimesensitiveLight::BlendToNight(float)  /*0x06000EF9*/
    IL_0042: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0047: pop
    IL_0048: ret

  .method TimesensitiveLight::BlendToNight(float)  // token 0x06000EF9 rva 0x43369 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void TimesensitiveLight.<BlendToNight>d__8::.ctor(int)  /*0x06000F03*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld TimesensitiveLight TimesensitiveLight.<BlendToNight>d__8::<>4__this  /*0x04001152*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float TimesensitiveLight.<BlendToNight>d__8::duration  /*0x04001153*/
    IL_0014: ret

  .method TimesensitiveLight::BlendToDay(float)  // token 0x06000EFA rva 0x4337f attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void TimesensitiveLight.<BlendToDay>d__9::.ctor(int)  /*0x06000EFD*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld TimesensitiveLight TimesensitiveLight.<BlendToDay>d__9::<>4__this  /*0x0400114D*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float TimesensitiveLight.<BlendToDay>d__9::duration  /*0x0400114E*/
    IL_0014: ret

  .method TimesensitiveLight::OnDuskEarly()  // token 0x06000EFB rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TimesensitiveLight::.ctor()  // token 0x06000EFC rva 0x43395 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TimesensitiveLight::dayIntensity  /*0x04001147*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float TimesensitiveLight::blendTime  /*0x04001149*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== TimesensitiveLight/<BlendToDay>d__9  (token 0x020002B9) =====
  .method TimesensitiveLight.<BlendToDay>d__9::.ctor(int)  // token 0x06000EFD rva 0x433b3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int TimesensitiveLight.<BlendToDay>d__9::<>1__state  /*0x0400114B*/
    IL_000d: ret

  .method TimesensitiveLight.<BlendToDay>d__9::System.IDisposable.Dispose()  // token 0x06000EFE rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TimesensitiveLight.<BlendToDay>d__9::MoveNext()  // token 0x06000EFF rva 0x433c4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 167 (0xa7), max stack 6, init locals
    .locals ([0] int, [1] TimesensitiveLight)
    IL_0000: ldarg.0
    IL_0001: ldfld int TimesensitiveLight.<BlendToDay>d__9::<>1__state  /*0x0400114B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld TimesensitiveLight TimesensitiveLight.<BlendToDay>d__9::<>4__this  /*0x0400114D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_007f
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int TimesensitiveLight.<BlendToDay>d__9::<>1__state  /*0x0400114B*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float TimesensitiveLight.<BlendToDay>d__9::<timer>5__2  /*0x0400114F*/
    IL_0029: br.s IL_0086
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float TimesensitiveLight.<BlendToDay>d__9::<timer>5__2  /*0x0400114F*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float TimesensitiveLight.<BlendToDay>d__9::<timer>5__2  /*0x0400114F*/
    IL_003d: ldloc.1
    IL_003e: ldfld Light TimesensitiveLight::target  /*0x0400114A*/
    IL_0043: ldloc.1
    IL_0044: ldfld float TimesensitiveLight::nightIntensity  /*0x04001148*/
    IL_0049: ldloc.1
    IL_004a: ldfld float TimesensitiveLight::dayIntensity  /*0x04001147*/
    IL_004f: ldc.r4 0f
    IL_0054: ldarg.0
    IL_0055: ldfld float TimesensitiveLight.<BlendToDay>d__9::duration  /*0x0400114E*/
    IL_005a: ldarg.0
    IL_005b: ldfld float TimesensitiveLight.<BlendToDay>d__9::<timer>5__2  /*0x0400114F*/
    IL_0060: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0065: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_006a: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_006f: ldarg.0
    IL_0070: ldnull
    IL_0071: stfld object TimesensitiveLight.<BlendToDay>d__9::<>2__current  /*0x0400114C*/
    IL_0076: ldarg.0
    IL_0077: ldc.i4.1
    IL_0078: stfld int TimesensitiveLight.<BlendToDay>d__9::<>1__state  /*0x0400114B*/
    IL_007d: ldc.i4.1
    IL_007e: ret
    IL_007f: ldarg.0
    IL_0080: ldc.i4.m1
    IL_0081: stfld int TimesensitiveLight.<BlendToDay>d__9::<>1__state  /*0x0400114B*/
    IL_0086: ldarg.0
    IL_0087: ldfld float TimesensitiveLight.<BlendToDay>d__9::<timer>5__2  /*0x0400114F*/
    IL_008c: ldarg.0
    IL_008d: ldfld float TimesensitiveLight.<BlendToDay>d__9::duration  /*0x0400114E*/
    IL_0092: ble.s IL_002b
    IL_0094: ldloc.1
    IL_0095: ldfld Light TimesensitiveLight::target  /*0x0400114A*/
    IL_009a: ldloc.1
    IL_009b: ldfld float TimesensitiveLight::dayIntensity  /*0x04001147*/
    IL_00a0: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_00a5: ldc.i4.0
    IL_00a6: ret

  .method TimesensitiveLight.<BlendToDay>d__9::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F00 rva 0x43477 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TimesensitiveLight.<BlendToDay>d__9::<>2__current  /*0x0400114C*/
    IL_0006: ret

  .method TimesensitiveLight.<BlendToDay>d__9::System.Collections.IEnumerator.Reset()  // token 0x06000F01 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method TimesensitiveLight.<BlendToDay>d__9::System.Collections.IEnumerator.get_Current()  // token 0x06000F02 rva 0x43477 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TimesensitiveLight.<BlendToDay>d__9::<>2__current  /*0x0400114C*/
    IL_0006: ret

// ===== TimesensitiveLight/<BlendToNight>d__8  (token 0x020002BA) =====
  .method TimesensitiveLight.<BlendToNight>d__8::.ctor(int)  // token 0x06000F03 rva 0x4347f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int TimesensitiveLight.<BlendToNight>d__8::<>1__state  /*0x04001150*/
    IL_000d: ret

  .method TimesensitiveLight.<BlendToNight>d__8::System.IDisposable.Dispose()  // token 0x06000F04 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TimesensitiveLight.<BlendToNight>d__8::MoveNext()  // token 0x06000F05 rva 0x43490 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 167 (0xa7), max stack 6, init locals
    .locals ([0] int, [1] TimesensitiveLight)
    IL_0000: ldarg.0
    IL_0001: ldfld int TimesensitiveLight.<BlendToNight>d__8::<>1__state  /*0x04001150*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld TimesensitiveLight TimesensitiveLight.<BlendToNight>d__8::<>4__this  /*0x04001152*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_007f
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int TimesensitiveLight.<BlendToNight>d__8::<>1__state  /*0x04001150*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float TimesensitiveLight.<BlendToNight>d__8::<timer>5__2  /*0x04001154*/
    IL_0029: br.s IL_0086
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float TimesensitiveLight.<BlendToNight>d__8::<timer>5__2  /*0x04001154*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float TimesensitiveLight.<BlendToNight>d__8::<timer>5__2  /*0x04001154*/
    IL_003d: ldloc.1
    IL_003e: ldfld Light TimesensitiveLight::target  /*0x0400114A*/
    IL_0043: ldloc.1
    IL_0044: ldfld float TimesensitiveLight::dayIntensity  /*0x04001147*/
    IL_0049: ldloc.1
    IL_004a: ldfld float TimesensitiveLight::nightIntensity  /*0x04001148*/
    IL_004f: ldc.r4 0f
    IL_0054: ldarg.0
    IL_0055: ldfld float TimesensitiveLight.<BlendToNight>d__8::duration  /*0x04001153*/
    IL_005a: ldarg.0
    IL_005b: ldfld float TimesensitiveLight.<BlendToNight>d__8::<timer>5__2  /*0x04001154*/
    IL_0060: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0065: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_006a: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_006f: ldarg.0
    IL_0070: ldnull
    IL_0071: stfld object TimesensitiveLight.<BlendToNight>d__8::<>2__current  /*0x04001151*/
    IL_0076: ldarg.0
    IL_0077: ldc.i4.1
    IL_0078: stfld int TimesensitiveLight.<BlendToNight>d__8::<>1__state  /*0x04001150*/
    IL_007d: ldc.i4.1
    IL_007e: ret
    IL_007f: ldarg.0
    IL_0080: ldc.i4.m1
    IL_0081: stfld int TimesensitiveLight.<BlendToNight>d__8::<>1__state  /*0x04001150*/
    IL_0086: ldarg.0
    IL_0087: ldfld float TimesensitiveLight.<BlendToNight>d__8::<timer>5__2  /*0x04001154*/
    IL_008c: ldarg.0
    IL_008d: ldfld float TimesensitiveLight.<BlendToNight>d__8::duration  /*0x04001153*/
    IL_0092: ble.s IL_002b
    IL_0094: ldloc.1
    IL_0095: ldfld Light TimesensitiveLight::target  /*0x0400114A*/
    IL_009a: ldloc.1
    IL_009b: ldfld float TimesensitiveLight::nightIntensity  /*0x04001148*/
    IL_00a0: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_00a5: ldc.i4.0
    IL_00a6: ret

  .method TimesensitiveLight.<BlendToNight>d__8::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000F06 rva 0x43543 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TimesensitiveLight.<BlendToNight>d__8::<>2__current  /*0x04001151*/
    IL_0006: ret

  .method TimesensitiveLight.<BlendToNight>d__8::System.Collections.IEnumerator.Reset()  // token 0x06000F07 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method TimesensitiveLight.<BlendToNight>d__8::System.Collections.IEnumerator.get_Current()  // token 0x06000F08 rva 0x43543 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TimesensitiveLight.<BlendToNight>d__8::<>2__current  /*0x04001151*/
    IL_0006: ret

