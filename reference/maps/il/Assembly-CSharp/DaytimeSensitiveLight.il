// ===== DaytimeSensitiveLight  (token 0x020000A1) =====
  .method DaytimeSensitiveLight::Start()  // token 0x0600037B rva 0xfd43 attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Light>  /*0x2B00002C*/
    IL_0007: stfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_000c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0011: ldarg.0
    IL_0012: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0017: ret

  .method DaytimeSensitiveLight::OnDawn_AfterSunrise()  // token 0x0600037C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveLight::OnDusk()  // token 0x0600037D rva 0xfd5c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator DaytimeSensitiveLight::ToNight()  /*0x06000380*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method DaytimeSensitiveLight::OnDawn_BeforeSunrise()  // token 0x0600037E rva 0xfd71 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator DaytimeSensitiveLight::ToDay()  /*0x0600037F*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method DaytimeSensitiveLight::ToDay()  // token 0x0600037F rva 0xfd86 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DaytimeSensitiveLight.<ToDay>d__10::.ctor(int)  /*0x06000383*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DaytimeSensitiveLight DaytimeSensitiveLight.<ToDay>d__10::<>4__this  /*0x04000490*/
    IL_000d: ret

  .method DaytimeSensitiveLight::ToNight()  // token 0x06000380 rva 0xfd95 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DaytimeSensitiveLight.<ToNight>d__11::.ctor(int)  /*0x06000389*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DaytimeSensitiveLight DaytimeSensitiveLight.<ToNight>d__11::<>4__this  /*0x04000494*/
    IL_000d: ret

  .method DaytimeSensitiveLight::OnDuskEarly()  // token 0x06000381 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveLight::.ctor()  // token 0x06000382 rva 0xfda4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0006: stfld Color DaytimeSensitiveLight::dayColor  /*0x04000488*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float DaytimeSensitiveLight::dayToSunsetDuration  /*0x0400048B*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 2f
    IL_001c: stfld float DaytimeSensitiveLight::sunsetToNightDuration  /*0x0400048C*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== DaytimeSensitiveLight/<ToDay>d__10  (token 0x020000A2) =====
  .method DaytimeSensitiveLight.<ToDay>d__10::.ctor(int)  // token 0x06000383 rva 0xfdcd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_000d: ret

  .method DaytimeSensitiveLight.<ToDay>d__10::System.IDisposable.Dispose()  // token 0x06000384 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveLight.<ToDay>d__10::MoveNext()  // token 0x06000385 rva 0xfddc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 278 (0x116), max stack 5, init locals
    .locals ([0] int, [1] DaytimeSensitiveLight)
    IL_0000: ldarg.0
    IL_0001: ldfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DaytimeSensitiveLight DaytimeSensitiveLight.<ToDay>d__10::<>4__this  /*0x04000490*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0081, IL_00ee)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_0029: ldarg.0
    IL_002a: ldc.r4 0f
    IL_002f: stfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_0034: br.s IL_0088
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_003d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0042: add
    IL_0043: stfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_0048: ldloc.1
    IL_0049: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_004e: ldloc.1
    IL_004f: ldfld Color DaytimeSensitiveLight::nightColor  /*0x0400048A*/
    IL_0054: ldloc.1
    IL_0055: ldfld Color DaytimeSensitiveLight::sunsetColor  /*0x04000489*/
    IL_005a: ldarg.0
    IL_005b: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_0060: ldloc.1
    IL_0061: ldfld float DaytimeSensitiveLight::sunsetToNightDuration  /*0x0400048C*/
    IL_0066: div
    IL_0067: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_006c: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0071: ldarg.0
    IL_0072: ldnull
    IL_0073: stfld object DaytimeSensitiveLight.<ToDay>d__10::<>2__current  /*0x0400048F*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.1
    IL_007a: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_007f: ldc.i4.1
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldc.i4.m1
    IL_0083: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_0088: ldarg.0
    IL_0089: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_008e: ldloc.1
    IL_008f: ldfld float DaytimeSensitiveLight::sunsetToNightDuration  /*0x0400048C*/
    IL_0094: ble.s IL_0036
    IL_0096: ldarg.0
    IL_0097: ldc.r4 0f
    IL_009c: stfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_00a1: br.s IL_00f5
    IL_00a3: ldarg.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_00aa: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00af: add
    IL_00b0: stfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_00b5: ldloc.1
    IL_00b6: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_00bb: ldloc.1
    IL_00bc: ldfld Color DaytimeSensitiveLight::sunsetColor  /*0x04000489*/
    IL_00c1: ldloc.1
    IL_00c2: ldfld Color DaytimeSensitiveLight::dayColor  /*0x04000488*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_00cd: ldloc.1
    IL_00ce: ldfld float DaytimeSensitiveLight::dayToSunsetDuration  /*0x0400048B*/
    IL_00d3: div
    IL_00d4: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00d9: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_00de: ldarg.0
    IL_00df: ldnull
    IL_00e0: stfld object DaytimeSensitiveLight.<ToDay>d__10::<>2__current  /*0x0400048F*/
    IL_00e5: ldarg.0
    IL_00e6: ldc.i4.2
    IL_00e7: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_00ec: ldc.i4.1
    IL_00ed: ret
    IL_00ee: ldarg.0
    IL_00ef: ldc.i4.m1
    IL_00f0: stfld int DaytimeSensitiveLight.<ToDay>d__10::<>1__state  /*0x0400048E*/
    IL_00f5: ldarg.0
    IL_00f6: ldfld float DaytimeSensitiveLight.<ToDay>d__10::<timer>5__2  /*0x04000491*/
    IL_00fb: ldloc.1
    IL_00fc: ldfld float DaytimeSensitiveLight::dayToSunsetDuration  /*0x0400048B*/
    IL_0101: ble.s IL_00a3
    IL_0103: ldloc.1
    IL_0104: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_0109: ldloc.1
    IL_010a: ldfld Color DaytimeSensitiveLight::dayColor  /*0x04000488*/
    IL_010f: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0114: ldc.i4.0
    IL_0115: ret

  .method DaytimeSensitiveLight.<ToDay>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000386 rva 0xfefe attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DaytimeSensitiveLight.<ToDay>d__10::<>2__current  /*0x0400048F*/
    IL_0006: ret

  .method DaytimeSensitiveLight.<ToDay>d__10::System.Collections.IEnumerator.Reset()  // token 0x06000387 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DaytimeSensitiveLight.<ToDay>d__10::System.Collections.IEnumerator.get_Current()  // token 0x06000388 rva 0xfefe attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DaytimeSensitiveLight.<ToDay>d__10::<>2__current  /*0x0400048F*/
    IL_0006: ret

// ===== DaytimeSensitiveLight/<ToNight>d__11  (token 0x020000A3) =====
  .method DaytimeSensitiveLight.<ToNight>d__11::.ctor(int)  // token 0x06000389 rva 0xff06 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_000d: ret

  .method DaytimeSensitiveLight.<ToNight>d__11::System.IDisposable.Dispose()  // token 0x0600038A rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DaytimeSensitiveLight.<ToNight>d__11::MoveNext()  // token 0x0600038B rva 0xff18 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 278 (0x116), max stack 5, init locals
    .locals ([0] int, [1] DaytimeSensitiveLight)
    IL_0000: ldarg.0
    IL_0001: ldfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DaytimeSensitiveLight DaytimeSensitiveLight.<ToNight>d__11::<>4__this  /*0x04000494*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0081, IL_00ee)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_0029: ldarg.0
    IL_002a: ldc.r4 0f
    IL_002f: stfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_0034: br.s IL_0088
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_003d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0042: add
    IL_0043: stfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_0048: ldloc.1
    IL_0049: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_004e: ldloc.1
    IL_004f: ldfld Color DaytimeSensitiveLight::dayColor  /*0x04000488*/
    IL_0054: ldloc.1
    IL_0055: ldfld Color DaytimeSensitiveLight::sunsetColor  /*0x04000489*/
    IL_005a: ldarg.0
    IL_005b: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_0060: ldloc.1
    IL_0061: ldfld float DaytimeSensitiveLight::dayToSunsetDuration  /*0x0400048B*/
    IL_0066: div
    IL_0067: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_006c: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0071: ldarg.0
    IL_0072: ldnull
    IL_0073: stfld object DaytimeSensitiveLight.<ToNight>d__11::<>2__current  /*0x04000493*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.1
    IL_007a: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_007f: ldc.i4.1
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldc.i4.m1
    IL_0083: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_0088: ldarg.0
    IL_0089: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_008e: ldloc.1
    IL_008f: ldfld float DaytimeSensitiveLight::dayToSunsetDuration  /*0x0400048B*/
    IL_0094: ble.s IL_0036
    IL_0096: ldarg.0
    IL_0097: ldc.r4 0f
    IL_009c: stfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_00a1: br.s IL_00f5
    IL_00a3: ldarg.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_00aa: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00af: add
    IL_00b0: stfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_00b5: ldloc.1
    IL_00b6: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_00bb: ldloc.1
    IL_00bc: ldfld Color DaytimeSensitiveLight::dayColor  /*0x04000488*/
    IL_00c1: ldloc.1
    IL_00c2: ldfld Color DaytimeSensitiveLight::nightColor  /*0x0400048A*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_00cd: ldloc.1
    IL_00ce: ldfld float DaytimeSensitiveLight::sunsetToNightDuration  /*0x0400048C*/
    IL_00d3: div
    IL_00d4: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00d9: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_00de: ldarg.0
    IL_00df: ldnull
    IL_00e0: stfld object DaytimeSensitiveLight.<ToNight>d__11::<>2__current  /*0x04000493*/
    IL_00e5: ldarg.0
    IL_00e6: ldc.i4.2
    IL_00e7: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_00ec: ldc.i4.1
    IL_00ed: ret
    IL_00ee: ldarg.0
    IL_00ef: ldc.i4.m1
    IL_00f0: stfld int DaytimeSensitiveLight.<ToNight>d__11::<>1__state  /*0x04000492*/
    IL_00f5: ldarg.0
    IL_00f6: ldfld float DaytimeSensitiveLight.<ToNight>d__11::<timer>5__2  /*0x04000495*/
    IL_00fb: ldloc.1
    IL_00fc: ldfld float DaytimeSensitiveLight::sunsetToNightDuration  /*0x0400048C*/
    IL_0101: ble.s IL_00a3
    IL_0103: ldloc.1
    IL_0104: ldfld Light DaytimeSensitiveLight::targetLight  /*0x0400048D*/
    IL_0109: ldloc.1
    IL_010a: ldfld Color DaytimeSensitiveLight::nightColor  /*0x0400048A*/
    IL_010f: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0114: ldc.i4.0
    IL_0115: ret

  .method DaytimeSensitiveLight.<ToNight>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600038C rva 0x1003a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DaytimeSensitiveLight.<ToNight>d__11::<>2__current  /*0x04000493*/
    IL_0006: ret

  .method DaytimeSensitiveLight.<ToNight>d__11::System.Collections.IEnumerator.Reset()  // token 0x0600038D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DaytimeSensitiveLight.<ToNight>d__11::System.Collections.IEnumerator.get_Current()  // token 0x0600038E rva 0x1003a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DaytimeSensitiveLight.<ToNight>d__11::<>2__current  /*0x04000493*/
    IL_0006: ret

