// ===== CameraController  (token 0x02000094) =====
  .method CameraController::Awake()  // token 0x0600031F rva 0xde8b attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0017
    IL_000d: ldstr "More than one camera controller in the scene."
    IL_0012: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0017: ldarg.0
    IL_0018: stsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_001d: ret

  .method CameraController::Start()  // token 0x06000320 rva 0xdeaa attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0006: stfld Camera CameraController::targetCamera  /*0x040003D6*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld Camera CameraController::targetCamera  /*0x040003D6*/
    IL_0012: callvirt float UnityEngine.Camera::get_orthographicSize()  /*0x0A000166*/
    IL_0017: stfld float CameraController::initialScale  /*0x040003D7*/
    IL_001c: ldarg.0
    IL_001d: ldc.i4.1
    IL_001e: stfld bool CameraController::initialized  /*0x040003D8*/
    IL_0023: ret

  .method CameraController::ShakePunch()  // token 0x06000321 rva 0xdecf attrs Public, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CameraController::initialized  /*0x040003D8*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_000f: ldarg.0
    IL_0010: ldarg.0
    IL_0011: ldarg.0
    IL_0012: ldfld float CameraController::shakeScaleFactor  /*0x040003D5*/
    IL_0017: ldarg.0
    IL_0018: ldfld float CameraController::shakeDuration  /*0x040003D4*/
    IL_001d: call IEnumerator CameraController::ExecuteShake(float,float)  /*0x06000322*/
    IL_0022: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0027: pop
    IL_0028: ret

  .method CameraController::ExecuteShake(float,float)  // token 0x06000322 rva 0xdef9 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void CameraController.<ExecuteShake>d__10::.ctor(int)  /*0x06000324*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld CameraController CameraController.<ExecuteShake>d__10::<>4__this  /*0x040003DB*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float CameraController.<ExecuteShake>d__10::scale  /*0x040003DD*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float CameraController.<ExecuteShake>d__10::duration  /*0x040003DC*/
    IL_001b: ret

  .method CameraController::.ctor()  // token 0x06000323 rva 0xdf16 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float CameraController::shakeDuration  /*0x040003D4*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 -1f
    IL_0011: stfld float CameraController::shakeScaleFactor  /*0x040003D5*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== CameraController/<ExecuteShake>d__10  (token 0x02000095) =====
  .method CameraController.<ExecuteShake>d__10::.ctor(int)  // token 0x06000324 rva 0xdf34 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int CameraController.<ExecuteShake>d__10::<>1__state  /*0x040003D9*/
    IL_000d: ret

  .method CameraController.<ExecuteShake>d__10::System.IDisposable.Dispose()  // token 0x06000325 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CameraController.<ExecuteShake>d__10::MoveNext()  // token 0x06000326 rva 0xdf44 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 166 (0xa6), max stack 5, init locals
    .locals ([0] int, [1] CameraController)
    IL_0000: ldarg.0
    IL_0001: ldfld int CameraController.<ExecuteShake>d__10::<>1__state  /*0x040003D9*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld CameraController CameraController.<ExecuteShake>d__10::<>4__this  /*0x040003DB*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_007e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int CameraController.<ExecuteShake>d__10::<>1__state  /*0x040003D9*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float CameraController.<ExecuteShake>d__10::<timer>5__2  /*0x040003DE*/
    IL_0029: br.s IL_0085
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float CameraController.<ExecuteShake>d__10::<timer>5__2  /*0x040003DE*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float CameraController.<ExecuteShake>d__10::<timer>5__2  /*0x040003DE*/
    IL_003d: ldloc.1
    IL_003e: ldfld Camera CameraController::targetCamera  /*0x040003D6*/
    IL_0043: ldloc.1
    IL_0044: ldfld float CameraController::initialScale  /*0x040003D7*/
    IL_0049: ldloc.1
    IL_004a: ldfld AnimationCurve CameraController::shakeCurve  /*0x040003D3*/
    IL_004f: ldarg.0
    IL_0050: ldfld float CameraController.<ExecuteShake>d__10::<timer>5__2  /*0x040003DE*/
    IL_0055: ldarg.0
    IL_0056: ldfld float CameraController.<ExecuteShake>d__10::duration  /*0x040003DC*/
    IL_005b: div
    IL_005c: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0061: ldarg.0
    IL_0062: ldfld float CameraController.<ExecuteShake>d__10::scale  /*0x040003DD*/
    IL_0067: mul
    IL_0068: add
    IL_0069: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_006e: ldarg.0
    IL_006f: ldnull
    IL_0070: stfld object CameraController.<ExecuteShake>d__10::<>2__current  /*0x040003DA*/
    IL_0075: ldarg.0
    IL_0076: ldc.i4.1
    IL_0077: stfld int CameraController.<ExecuteShake>d__10::<>1__state  /*0x040003D9*/
    IL_007c: ldc.i4.1
    IL_007d: ret
    IL_007e: ldarg.0
    IL_007f: ldc.i4.m1
    IL_0080: stfld int CameraController.<ExecuteShake>d__10::<>1__state  /*0x040003D9*/
    IL_0085: ldarg.0
    IL_0086: ldfld float CameraController.<ExecuteShake>d__10::<timer>5__2  /*0x040003DE*/
    IL_008b: ldarg.0
    IL_008c: ldfld float CameraController.<ExecuteShake>d__10::duration  /*0x040003DC*/
    IL_0091: ble.s IL_002b
    IL_0093: ldloc.1
    IL_0094: ldfld Camera CameraController::targetCamera  /*0x040003D6*/
    IL_0099: ldloc.1
    IL_009a: ldfld float CameraController::initialScale  /*0x040003D7*/
    IL_009f: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_00a4: ldc.i4.0
    IL_00a5: ret

  .method CameraController.<ExecuteShake>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000327 rva 0xdff6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CameraController.<ExecuteShake>d__10::<>2__current  /*0x040003DA*/
    IL_0006: ret

  .method CameraController.<ExecuteShake>d__10::System.Collections.IEnumerator.Reset()  // token 0x06000328 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method CameraController.<ExecuteShake>d__10::System.Collections.IEnumerator.get_Current()  // token 0x06000329 rva 0xdff6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CameraController.<ExecuteShake>d__10::<>2__current  /*0x040003DA*/
    IL_0006: ret

