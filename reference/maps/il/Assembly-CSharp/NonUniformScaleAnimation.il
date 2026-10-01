// ===== NonUniformScaleAnimation  (token 0x020000C0) =====
  .method NonUniformScaleAnimation::Start()  // token 0x06000400 rva 0x1156c attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform NonUniformScaleAnimation::transformToAnimate  /*0x04000529*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_000c: stfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool NonUniformScaleAnimation::playOnStart  /*0x0400052A*/
    IL_0017: brfalse.s IL_002a
    IL_0019: ldarg.0
    IL_001a: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_001f: stfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_0024: ldarg.0
    IL_0025: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_002a: ret

  .method NonUniformScaleAnimation::Animate()  // token 0x06000401 rva 0x11598 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void NonUniformScaleAnimation.<Animate>d__7::.ctor(int)  /*0x06000404*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld NonUniformScaleAnimation NonUniformScaleAnimation.<Animate>d__7::<>4__this  /*0x0400052F*/
    IL_000d: ret

  .method NonUniformScaleAnimation::Trigger()  // token 0x06000402 rva 0x115a7 attrs Public, Virtual, HideBySig
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
    IL_0016: call IEnumerator NonUniformScaleAnimation::Animate()  /*0x06000401*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method NonUniformScaleAnimation::.ctor()  // token 0x06000403 rva 0x115ca attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0006: stfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_000b: ldarg.0
    IL_000c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0011: stfld Vector3 NonUniformScaleAnimation::currentScale  /*0x0400052C*/
    IL_0016: ldarg.0
    IL_0017: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_001c: ret

// ===== NonUniformScaleAnimation/<Animate>d__7  (token 0x020000C1) =====
  .method NonUniformScaleAnimation.<Animate>d__7::.ctor(int)  // token 0x06000404 rva 0x115e8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int NonUniformScaleAnimation.<Animate>d__7::<>1__state  /*0x0400052D*/
    IL_000d: ret

  .method NonUniformScaleAnimation.<Animate>d__7::System.IDisposable.Dispose()  // token 0x06000405 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method NonUniformScaleAnimation.<Animate>d__7::MoveNext()  // token 0x06000406 rva 0x115f8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 236 (0xec), max stack 6, init locals
    .locals ([0] int, [1] NonUniformScaleAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int NonUniformScaleAnimation.<Animate>d__7::<>1__state  /*0x0400052D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld NonUniformScaleAnimation NonUniformScaleAnimation.<Animate>d__7::<>4__this  /*0x0400052F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a1
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int NonUniformScaleAnimation.<Animate>d__7::<>1__state  /*0x0400052D*/
    IL_0021: ldloc.1
    IL_0022: ldfld Transform NonUniformScaleAnimation::transformToAnimate  /*0x04000529*/
    IL_0027: ldloc.1
    IL_0028: ldfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_002d: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0032: ldloc.1
    IL_0033: ldloc.1
    IL_0034: ldfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_0039: stfld Vector3 NonUniformScaleAnimation::currentScale  /*0x0400052C*/
    IL_003e: ldarg.0
    IL_003f: ldc.r4 0f
    IL_0044: stfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_0049: br.s IL_00a8
    IL_004b: ldloc.1
    IL_004c: ldfld Transform NonUniformScaleAnimation::transformToAnimate  /*0x04000529*/
    IL_0051: ldloc.1
    IL_0052: ldfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_0057: ldloc.1
    IL_0058: ldfld Vector3 NonUniformScaleAnimation::targetScale  /*0x04000528*/
    IL_005d: ldloc.1
    IL_005e: ldfld AnimationCurve NonUniformScaleAnimation::curve  /*0x04000527*/
    IL_0063: ldarg.0
    IL_0064: ldfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_0069: ldloc.1
    IL_006a: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_006f: div
    IL_0070: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0075: call Vector3 UnityEngine.Vector3::LerpUnclamped(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A0001BB*/
    IL_007a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_007f: ldarg.0
    IL_0080: ldarg.0
    IL_0081: ldfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_0086: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008b: add
    IL_008c: stfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_0091: ldarg.0
    IL_0092: ldnull
    IL_0093: stfld object NonUniformScaleAnimation.<Animate>d__7::<>2__current  /*0x0400052E*/
    IL_0098: ldarg.0
    IL_0099: ldc.i4.1
    IL_009a: stfld int NonUniformScaleAnimation.<Animate>d__7::<>1__state  /*0x0400052D*/
    IL_009f: ldc.i4.1
    IL_00a0: ret
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.m1
    IL_00a3: stfld int NonUniformScaleAnimation.<Animate>d__7::<>1__state  /*0x0400052D*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_00ae: ldloc.1
    IL_00af: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00b4: blt.s IL_004b
    IL_00b6: ldloc.1
    IL_00b7: ldfld Transform NonUniformScaleAnimation::transformToAnimate  /*0x04000529*/
    IL_00bc: ldloc.1
    IL_00bd: ldfld Vector3 NonUniformScaleAnimation::initialScale  /*0x0400052B*/
    IL_00c2: ldloc.1
    IL_00c3: ldfld Vector3 NonUniformScaleAnimation::targetScale  /*0x04000528*/
    IL_00c8: ldloc.1
    IL_00c9: ldfld AnimationCurve NonUniformScaleAnimation::curve  /*0x04000527*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld float NonUniformScaleAnimation.<Animate>d__7::<timer>5__2  /*0x04000530*/
    IL_00d4: ldloc.1
    IL_00d5: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00da: div
    IL_00db: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00e0: call Vector3 UnityEngine.Vector3::LerpUnclamped(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A0001BB*/
    IL_00e5: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00ea: ldc.i4.0
    IL_00eb: ret

  .method NonUniformScaleAnimation.<Animate>d__7::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000407 rva 0x116f0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NonUniformScaleAnimation.<Animate>d__7::<>2__current  /*0x0400052E*/
    IL_0006: ret

  .method NonUniformScaleAnimation.<Animate>d__7::System.Collections.IEnumerator.Reset()  // token 0x06000408 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method NonUniformScaleAnimation.<Animate>d__7::System.Collections.IEnumerator.get_Current()  // token 0x06000409 rva 0x116f0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object NonUniformScaleAnimation.<Animate>d__7::<>2__current  /*0x0400052E*/
    IL_0006: ret

