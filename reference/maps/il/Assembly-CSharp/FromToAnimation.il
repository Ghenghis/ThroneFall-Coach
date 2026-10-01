// ===== FromToAnimation  (token 0x02000024) =====
  .method FromToAnimation::Start()  // token 0x060000C2 rva 0x5460 attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform FromToAnimation::transformToAnimate  /*0x040000F0*/
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_000c: stfld Quaternion FromToAnimation::initialRotation  /*0x040000F1*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldflda Vector3 FromToAnimation::eulerTargetRotation  /*0x040000EF*/
    IL_0018: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_001d: ldarg.0
    IL_001e: ldflda Vector3 FromToAnimation::eulerTargetRotation  /*0x040000EF*/
    IL_0023: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0028: ldarg.0
    IL_0029: ldflda Vector3 FromToAnimation::eulerTargetRotation  /*0x040000EF*/
    IL_002e: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0033: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0038: stfld Quaternion FromToAnimation::targetRotation  /*0x040000F2*/
    IL_003d: ret

  .method FromToAnimation::Animate()  // token 0x060000C3 rva 0x549f attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void FromToAnimation.<Animate>d__6::.ctor(int)  /*0x060000C6*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld FromToAnimation FromToAnimation.<Animate>d__6::<>4__this  /*0x040000F5*/
    IL_000d: ret

  .method FromToAnimation::Trigger()  // token 0x060000C4 rva 0x54ae attrs Public, Virtual, HideBySig
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
    IL_0016: call IEnumerator FromToAnimation::Animate()  /*0x060000C3*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method FromToAnimation::.ctor()  // token 0x060000C5 rva 0x54d1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_0006: ret

// ===== FromToAnimation/<Animate>d__6  (token 0x02000025) =====
  .method FromToAnimation.<Animate>d__6::.ctor(int)  // token 0x060000C6 rva 0x54d9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int FromToAnimation.<Animate>d__6::<>1__state  /*0x040000F3*/
    IL_000d: ret

  .method FromToAnimation.<Animate>d__6::System.IDisposable.Dispose()  // token 0x060000C7 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FromToAnimation.<Animate>d__6::MoveNext()  // token 0x060000C8 rva 0x54e8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 213 (0xd5), max stack 6, init locals
    .locals ([0] int, [1] FromToAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int FromToAnimation.<Animate>d__6::<>1__state  /*0x040000F3*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld FromToAnimation FromToAnimation.<Animate>d__6::<>4__this  /*0x040000F5*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0092
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int FromToAnimation.<Animate>d__6::<>1__state  /*0x040000F3*/
    IL_001e: ldloc.1
    IL_001f: ldfld Transform FromToAnimation::transformToAnimate  /*0x040000F0*/
    IL_0024: ldloc.1
    IL_0025: ldfld Quaternion FromToAnimation::initialRotation  /*0x040000F1*/
    IL_002a: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_002f: ldarg.0
    IL_0030: ldc.r4 0f
    IL_0035: stfld float FromToAnimation.<Animate>d__6::<timer>5__2  /*0x040000F6*/
    IL_003a: br.s IL_0099
    IL_003c: ldloc.1
    IL_003d: ldfld Transform FromToAnimation::transformToAnimate  /*0x040000F0*/
    IL_0042: ldloc.1
    IL_0043: ldfld Quaternion FromToAnimation::initialRotation  /*0x040000F1*/
    IL_0048: ldloc.1
    IL_0049: ldfld Quaternion FromToAnimation::targetRotation  /*0x040000F2*/
    IL_004e: ldloc.1
    IL_004f: ldfld AnimationCurve FromToAnimation::curve  /*0x040000EE*/
    IL_0054: ldarg.0
    IL_0055: ldfld float FromToAnimation.<Animate>d__6::<timer>5__2  /*0x040000F6*/
    IL_005a: ldloc.1
    IL_005b: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0060: div
    IL_0061: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0066: call Quaternion UnityEngine.Quaternion::Lerp(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A000092*/
    IL_006b: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldfld float FromToAnimation.<Animate>d__6::<timer>5__2  /*0x040000F6*/
    IL_0077: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007c: add
    IL_007d: stfld float FromToAnimation.<Animate>d__6::<timer>5__2  /*0x040000F6*/
    IL_0082: ldarg.0
    IL_0083: ldnull
    IL_0084: stfld object FromToAnimation.<Animate>d__6::<>2__current  /*0x040000F4*/
    IL_0089: ldarg.0
    IL_008a: ldc.i4.1
    IL_008b: stfld int FromToAnimation.<Animate>d__6::<>1__state  /*0x040000F3*/
    IL_0090: ldc.i4.1
    IL_0091: ret
    IL_0092: ldarg.0
    IL_0093: ldc.i4.m1
    IL_0094: stfld int FromToAnimation.<Animate>d__6::<>1__state  /*0x040000F3*/
    IL_0099: ldarg.0
    IL_009a: ldfld float FromToAnimation.<Animate>d__6::<timer>5__2  /*0x040000F6*/
    IL_009f: ldloc.1
    IL_00a0: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00a5: blt.s IL_003c
    IL_00a7: ldloc.1
    IL_00a8: ldfld Transform FromToAnimation::transformToAnimate  /*0x040000F0*/
    IL_00ad: ldloc.1
    IL_00ae: ldfld Quaternion FromToAnimation::initialRotation  /*0x040000F1*/
    IL_00b3: ldloc.1
    IL_00b4: ldfld Quaternion FromToAnimation::targetRotation  /*0x040000F2*/
    IL_00b9: ldloc.1
    IL_00ba: ldfld AnimationCurve FromToAnimation::curve  /*0x040000EE*/
    IL_00bf: ldc.r4 1f
    IL_00c4: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00c9: call Quaternion UnityEngine.Quaternion::Lerp(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A000092*/
    IL_00ce: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_00d3: ldc.i4.0
    IL_00d4: ret

  .method FromToAnimation.<Animate>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000C9 rva 0x55c9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FromToAnimation.<Animate>d__6::<>2__current  /*0x040000F4*/
    IL_0006: ret

  .method FromToAnimation.<Animate>d__6::System.Collections.IEnumerator.Reset()  // token 0x060000CA rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method FromToAnimation.<Animate>d__6::System.Collections.IEnumerator.get_Current()  // token 0x060000CB rva 0x55c9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FromToAnimation.<Animate>d__6::<>2__current  /*0x040000F4*/
    IL_0006: ret

