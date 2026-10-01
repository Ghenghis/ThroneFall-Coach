// ===== SpinAnimation  (token 0x02000042) =====
  .method SpinAnimation::Start()  // token 0x0600013F rva 0x716a attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform SpinAnimation::transformToAnimate  /*0x0400019E*/
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_000c: stfld Quaternion SpinAnimation::initialRotation  /*0x0400019F*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldflda Vector3 SpinAnimation::spinRotation  /*0x0400019D*/
    IL_0018: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_001d: ldarg.0
    IL_001e: ldflda Vector3 SpinAnimation::spinRotation  /*0x0400019D*/
    IL_0023: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0028: ldarg.0
    IL_0029: ldflda Vector3 SpinAnimation::spinRotation  /*0x0400019D*/
    IL_002e: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0033: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0038: stfld Quaternion SpinAnimation::targetRotation  /*0x040001A0*/
    IL_003d: ret

  .method SpinAnimation::Animate()  // token 0x06000140 rva 0x71a9 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void SpinAnimation.<Animate>d__6::.ctor(int)  /*0x06000143*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld SpinAnimation SpinAnimation.<Animate>d__6::<>4__this  /*0x040001A3*/
    IL_000d: ret

  .method SpinAnimation::Trigger()  // token 0x06000141 rva 0x71b8 attrs Public, Virtual, HideBySig
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
    IL_0016: call IEnumerator SpinAnimation::Animate()  /*0x06000140*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method SpinAnimation::.ctor()  // token 0x06000142 rva 0x54d1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_0006: ret

// ===== SpinAnimation/<Animate>d__6  (token 0x02000043) =====
  .method SpinAnimation.<Animate>d__6::.ctor(int)  // token 0x06000143 rva 0x71db attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int SpinAnimation.<Animate>d__6::<>1__state  /*0x040001A1*/
    IL_000d: ret

  .method SpinAnimation.<Animate>d__6::System.IDisposable.Dispose()  // token 0x06000144 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpinAnimation.<Animate>d__6::MoveNext()  // token 0x06000145 rva 0x71ec attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 193 (0xc1), max stack 5, init locals
    .locals ([0] int, [1] SpinAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int SpinAnimation.<Animate>d__6::<>1__state  /*0x040001A1*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld SpinAnimation SpinAnimation.<Animate>d__6::<>4__this  /*0x040001A3*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_0099
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int SpinAnimation.<Animate>d__6::<>1__state  /*0x040001A1*/
    IL_0021: ldloc.1
    IL_0022: ldfld Transform SpinAnimation::transformToAnimate  /*0x0400019E*/
    IL_0027: ldloc.1
    IL_0028: ldfld Quaternion SpinAnimation::initialRotation  /*0x0400019F*/
    IL_002d: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0032: ldarg.0
    IL_0033: ldc.r4 0f
    IL_0038: stfld float SpinAnimation.<Animate>d__6::<timer>5__2  /*0x040001A4*/
    IL_003d: br.s IL_00a0
    IL_003f: ldloc.1
    IL_0040: ldfld Transform SpinAnimation::transformToAnimate  /*0x0400019E*/
    IL_0045: ldloc.1
    IL_0046: ldflda Quaternion SpinAnimation::initialRotation  /*0x0400019F*/
    IL_004b: call Vector3 UnityEngine.Quaternion::get_eulerAngles()  /*0x0A0000B9*/
    IL_0050: ldloc.1
    IL_0051: ldfld Vector3 SpinAnimation::spinRotation  /*0x0400019D*/
    IL_0056: ldarg.0
    IL_0057: ldfld float SpinAnimation.<Animate>d__6::<timer>5__2  /*0x040001A4*/
    IL_005c: ldloc.1
    IL_005d: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0062: div
    IL_0063: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0068: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006d: call Quaternion UnityEngine.Quaternion::Euler(UnityEngine.Vector3)  /*0x0A0000B6*/
    IL_0072: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0077: ldarg.0
    IL_0078: ldarg.0
    IL_0079: ldfld float SpinAnimation.<Animate>d__6::<timer>5__2  /*0x040001A4*/
    IL_007e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0083: add
    IL_0084: stfld float SpinAnimation.<Animate>d__6::<timer>5__2  /*0x040001A4*/
    IL_0089: ldarg.0
    IL_008a: ldnull
    IL_008b: stfld object SpinAnimation.<Animate>d__6::<>2__current  /*0x040001A2*/
    IL_0090: ldarg.0
    IL_0091: ldc.i4.1
    IL_0092: stfld int SpinAnimation.<Animate>d__6::<>1__state  /*0x040001A1*/
    IL_0097: ldc.i4.1
    IL_0098: ret
    IL_0099: ldarg.0
    IL_009a: ldc.i4.m1
    IL_009b: stfld int SpinAnimation.<Animate>d__6::<>1__state  /*0x040001A1*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld float SpinAnimation.<Animate>d__6::<timer>5__2  /*0x040001A4*/
    IL_00a6: ldloc.1
    IL_00a7: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00ac: blt.s IL_003f
    IL_00ae: ldloc.1
    IL_00af: ldfld Transform SpinAnimation::transformToAnimate  /*0x0400019E*/
    IL_00b4: ldloc.1
    IL_00b5: ldfld Quaternion SpinAnimation::initialRotation  /*0x0400019F*/
    IL_00ba: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_00bf: ldc.i4.0
    IL_00c0: ret

  .method SpinAnimation.<Animate>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000146 rva 0x72b9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SpinAnimation.<Animate>d__6::<>2__current  /*0x040001A2*/
    IL_0006: ret

  .method SpinAnimation.<Animate>d__6::System.Collections.IEnumerator.Reset()  // token 0x06000147 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method SpinAnimation.<Animate>d__6::System.Collections.IEnumerator.get_Current()  // token 0x06000148 rva 0x72b9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SpinAnimation.<Animate>d__6::<>2__current  /*0x040001A2*/
    IL_0006: ret

