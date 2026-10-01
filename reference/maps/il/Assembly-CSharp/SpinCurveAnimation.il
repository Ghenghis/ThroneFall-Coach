// ===== SpinCurveAnimation  (token 0x020000C3) =====
  .method SpinCurveAnimation::Start()  // token 0x0600040D rva 0x1180e attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform SpinCurveAnimation::transformToAnimate  /*0x0400053F*/
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_000c: stfld Quaternion SpinCurveAnimation::initialRotation  /*0x04000540*/
    IL_0011: ret

  .method SpinCurveAnimation::Animate()  // token 0x0600040E rva 0x11821 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void SpinCurveAnimation.<Animate>d__5::.ctor(int)  /*0x06000411*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld SpinCurveAnimation SpinCurveAnimation.<Animate>d__5::<>4__this  /*0x04000543*/
    IL_000d: ret

  .method SpinCurveAnimation::Trigger()  // token 0x0600040F rva 0x11830 attrs Public, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: call IEnumerator SpinCurveAnimation::Animate()  /*0x0600040E*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method SpinCurveAnimation::.ctor()  // token 0x06000410 rva 0x54d1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_0006: ret

// ===== SpinCurveAnimation/<Animate>d__5  (token 0x020000C4) =====
  .method SpinCurveAnimation.<Animate>d__5::.ctor(int)  // token 0x06000411 rva 0x11853 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int SpinCurveAnimation.<Animate>d__5::<>1__state  /*0x04000541*/
    IL_000d: ret

  .method SpinCurveAnimation.<Animate>d__5::System.IDisposable.Dispose()  // token 0x06000412 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpinCurveAnimation.<Animate>d__5::MoveNext()  // token 0x06000413 rva 0x11864 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 246 (0xf6), max stack 6, init locals
    .locals ([0] int, [1] SpinCurveAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int SpinCurveAnimation.<Animate>d__5::<>1__state  /*0x04000541*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld SpinCurveAnimation SpinCurveAnimation.<Animate>d__5::<>4__this  /*0x04000543*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a4
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int SpinCurveAnimation.<Animate>d__5::<>1__state  /*0x04000541*/
    IL_0021: ldloc.1
    IL_0022: ldfld Transform SpinCurveAnimation::transformToAnimate  /*0x0400053F*/
    IL_0027: ldloc.1
    IL_0028: ldfld Quaternion SpinCurveAnimation::initialRotation  /*0x04000540*/
    IL_002d: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0032: ldarg.0
    IL_0033: ldc.r4 0f
    IL_0038: stfld float SpinCurveAnimation.<Animate>d__5::<timer>5__2  /*0x04000544*/
    IL_003d: br.s IL_00ab
    IL_003f: ldloc.1
    IL_0040: ldfld Transform SpinCurveAnimation::transformToAnimate  /*0x0400053F*/
    IL_0045: ldloc.1
    IL_0046: ldflda Quaternion SpinCurveAnimation::initialRotation  /*0x04000540*/
    IL_004b: call Vector3 UnityEngine.Quaternion::get_eulerAngles()  /*0x0A0000B9*/
    IL_0050: ldloc.1
    IL_0051: ldfld Vector3 SpinCurveAnimation::targetSpinRotation  /*0x0400053E*/
    IL_0056: ldloc.1
    IL_0057: ldfld AnimationCurve SpinCurveAnimation::curve  /*0x0400053D*/
    IL_005c: ldarg.0
    IL_005d: ldfld float SpinCurveAnimation.<Animate>d__5::<timer>5__2  /*0x04000544*/
    IL_0062: ldloc.1
    IL_0063: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0068: div
    IL_0069: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_006e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0073: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0078: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_007d: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0082: ldarg.0
    IL_0083: ldarg.0
    IL_0084: ldfld float SpinCurveAnimation.<Animate>d__5::<timer>5__2  /*0x04000544*/
    IL_0089: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008e: add
    IL_008f: stfld float SpinCurveAnimation.<Animate>d__5::<timer>5__2  /*0x04000544*/
    IL_0094: ldarg.0
    IL_0095: ldnull
    IL_0096: stfld object SpinCurveAnimation.<Animate>d__5::<>2__current  /*0x04000542*/
    IL_009b: ldarg.0
    IL_009c: ldc.i4.1
    IL_009d: stfld int SpinCurveAnimation.<Animate>d__5::<>1__state  /*0x04000541*/
    IL_00a2: ldc.i4.1
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: ldc.i4.m1
    IL_00a6: stfld int SpinCurveAnimation.<Animate>d__5::<>1__state  /*0x04000541*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float SpinCurveAnimation.<Animate>d__5::<timer>5__2  /*0x04000544*/
    IL_00b1: ldloc.1
    IL_00b2: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00b7: blt.s IL_003f
    IL_00b9: ldloc.1
    IL_00ba: ldfld Transform SpinCurveAnimation::transformToAnimate  /*0x0400053F*/
    IL_00bf: ldloc.1
    IL_00c0: ldflda Quaternion SpinCurveAnimation::initialRotation  /*0x04000540*/
    IL_00c5: call Vector3 UnityEngine.Quaternion::get_eulerAngles()  /*0x0A0000B9*/
    IL_00ca: ldloc.1
    IL_00cb: ldfld Vector3 SpinCurveAnimation::targetSpinRotation  /*0x0400053E*/
    IL_00d0: ldloc.1
    IL_00d1: ldfld AnimationCurve SpinCurveAnimation::curve  /*0x0400053D*/
    IL_00d6: ldc.r4 1f
    IL_00db: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00e0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00e5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00ea: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_00ef: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_00f4: ldc.i4.0
    IL_00f5: ret

  .method SpinCurveAnimation.<Animate>d__5::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000414 rva 0x11966 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SpinCurveAnimation.<Animate>d__5::<>2__current  /*0x04000542*/
    IL_0006: ret

  .method SpinCurveAnimation.<Animate>d__5::System.Collections.IEnumerator.Reset()  // token 0x06000415 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method SpinCurveAnimation.<Animate>d__5::System.Collections.IEnumerator.get_Current()  // token 0x06000416 rva 0x11966 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SpinCurveAnimation.<Animate>d__5::<>2__current  /*0x04000542*/
    IL_0006: ret

