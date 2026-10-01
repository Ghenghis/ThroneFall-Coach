// ===== ScaleAnimation  (token 0x0200003A) =====
  .method ScaleAnimation::Start()  // token 0x06000124 rva 0x6ab6 attrs Private, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform ScaleAnimation::transformToAnimate  /*0x04000168*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_000c: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0011: stfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_0016: ldarg.0
    IL_0017: ldfld bool ScaleAnimation::playOnStart  /*0x04000169*/
    IL_001c: brfalse.s IL_002f
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_0029: ldarg.0
    IL_002a: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_002f: ret

  .method ScaleAnimation::Animate()  // token 0x06000125 rva 0x6ae7 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ScaleAnimation.<Animate>d__6::.ctor(int)  /*0x06000128*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ScaleAnimation ScaleAnimation.<Animate>d__6::<>4__this  /*0x0400016D*/
    IL_000d: ret

  .method ScaleAnimation::Trigger()  // token 0x06000126 rva 0x6af6 attrs Public, Virtual, HideBySig
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
    IL_0016: call IEnumerator ScaleAnimation::Animate()  /*0x06000125*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method ScaleAnimation::.ctor()  // token 0x06000127 rva 0x6b19 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_000b: ldarg.0
    IL_000c: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_0011: ret

// ===== ScaleAnimation/<Animate>d__6  (token 0x0200003B) =====
  .method ScaleAnimation.<Animate>d__6::.ctor(int)  // token 0x06000128 rva 0x6b2c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ScaleAnimation.<Animate>d__6::<>1__state  /*0x0400016B*/
    IL_000d: ret

  .method ScaleAnimation.<Animate>d__6::System.IDisposable.Dispose()  // token 0x06000129 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScaleAnimation.<Animate>d__6::MoveNext()  // token 0x0600012A rva 0x6b3c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 254 (0xfe), max stack 7, init locals
    .locals ([0] int, [1] ScaleAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int ScaleAnimation.<Animate>d__6::<>1__state  /*0x0400016B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ScaleAnimation ScaleAnimation.<Animate>d__6::<>4__this  /*0x0400016D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a9
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int ScaleAnimation.<Animate>d__6::<>1__state  /*0x0400016B*/
    IL_0021: ldloc.1
    IL_0022: ldfld Transform ScaleAnimation::transformToAnimate  /*0x04000168*/
    IL_0027: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_002c: ldloc.1
    IL_002d: ldfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_0032: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0037: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_003c: ldarg.0
    IL_003d: ldc.r4 0f
    IL_0042: stfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_0047: br.s IL_00b0
    IL_0049: ldloc.1
    IL_004a: ldfld Transform ScaleAnimation::transformToAnimate  /*0x04000168*/
    IL_004f: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0054: ldloc.1
    IL_0055: ldfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_005a: ldloc.1
    IL_005b: ldfld float ScaleAnimation::targetScale  /*0x04000167*/
    IL_0060: ldloc.1
    IL_0061: ldfld AnimationCurve ScaleAnimation::curve  /*0x04000166*/
    IL_0066: ldarg.0
    IL_0067: ldfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_006c: ldloc.1
    IL_006d: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0072: div
    IL_0073: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0078: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_007d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0082: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0087: ldarg.0
    IL_0088: ldarg.0
    IL_0089: ldfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_008e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0093: add
    IL_0094: stfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_0099: ldarg.0
    IL_009a: ldnull
    IL_009b: stfld object ScaleAnimation.<Animate>d__6::<>2__current  /*0x0400016C*/
    IL_00a0: ldarg.0
    IL_00a1: ldc.i4.1
    IL_00a2: stfld int ScaleAnimation.<Animate>d__6::<>1__state  /*0x0400016B*/
    IL_00a7: ldc.i4.1
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.m1
    IL_00ab: stfld int ScaleAnimation.<Animate>d__6::<>1__state  /*0x0400016B*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_00b6: ldloc.1
    IL_00b7: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00bc: blt.s IL_0049
    IL_00be: ldloc.1
    IL_00bf: ldfld Transform ScaleAnimation::transformToAnimate  /*0x04000168*/
    IL_00c4: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c9: ldloc.1
    IL_00ca: ldfld float ScaleAnimation::initialScale  /*0x0400016A*/
    IL_00cf: ldloc.1
    IL_00d0: ldfld float ScaleAnimation::targetScale  /*0x04000167*/
    IL_00d5: ldloc.1
    IL_00d6: ldfld AnimationCurve ScaleAnimation::curve  /*0x04000166*/
    IL_00db: ldarg.0
    IL_00dc: ldfld float ScaleAnimation.<Animate>d__6::<timer>5__2  /*0x0400016E*/
    IL_00e1: ldloc.1
    IL_00e2: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00e7: div
    IL_00e8: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00ed: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00f2: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00f7: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00fc: ldc.i4.0
    IL_00fd: ret

  .method ScaleAnimation.<Animate>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600012B rva 0x6c46 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ScaleAnimation.<Animate>d__6::<>2__current  /*0x0400016C*/
    IL_0006: ret

  .method ScaleAnimation.<Animate>d__6::System.Collections.IEnumerator.Reset()  // token 0x0600012C rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ScaleAnimation.<Animate>d__6::System.Collections.IEnumerator.get_Current()  // token 0x0600012D rva 0x6c46 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ScaleAnimation.<Animate>d__6::<>2__current  /*0x0400016C*/
    IL_0006: ret

