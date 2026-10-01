// ===== PositionAnimation  (token 0x0200002E) =====
  .method PositionAnimation::Start()  // token 0x060000F3 rva 0x5cf6 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform PositionAnimation::transformToAnimate  /*0x0400011D*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_000c: stfld Vector3 PositionAnimation::initialPosition  /*0x0400011E*/
    IL_0011: ret

  .method PositionAnimation::Animate()  // token 0x060000F4 rva 0x5d09 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PositionAnimation.<Animate>d__5::.ctor(int)  /*0x060000F7*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PositionAnimation PositionAnimation.<Animate>d__5::<>4__this  /*0x04000121*/
    IL_000d: ret

  .method PositionAnimation::Trigger()  // token 0x060000F5 rva 0x5d18 attrs Public, Virtual, HideBySig
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
    IL_0016: call IEnumerator PositionAnimation::Animate()  /*0x060000F4*/
    IL_001b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0020: pop
    IL_0021: ret

  .method PositionAnimation::.ctor()  // token 0x060000F6 rva 0x54d1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void OneShotAnimationBase::.ctor()  /*0x060000CF*/
    IL_0006: ret

// ===== PositionAnimation/<Animate>d__5  (token 0x0200002F) =====
  .method PositionAnimation.<Animate>d__5::.ctor(int)  // token 0x060000F7 rva 0x5d3b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PositionAnimation.<Animate>d__5::<>1__state  /*0x0400011F*/
    IL_000d: ret

  .method PositionAnimation.<Animate>d__5::System.IDisposable.Dispose()  // token 0x060000F8 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PositionAnimation.<Animate>d__5::MoveNext()  // token 0x060000F9 rva 0x5d4c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 213 (0xd5), max stack 6, init locals
    .locals ([0] int, [1] PositionAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int PositionAnimation.<Animate>d__5::<>1__state  /*0x0400011F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PositionAnimation PositionAnimation.<Animate>d__5::<>4__this  /*0x04000121*/
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
    IL_0019: stfld int PositionAnimation.<Animate>d__5::<>1__state  /*0x0400011F*/
    IL_001e: ldloc.1
    IL_001f: ldfld Transform PositionAnimation::transformToAnimate  /*0x0400011D*/
    IL_0024: ldloc.1
    IL_0025: ldfld Vector3 PositionAnimation::initialPosition  /*0x0400011E*/
    IL_002a: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_002f: ldarg.0
    IL_0030: ldc.r4 0f
    IL_0035: stfld float PositionAnimation.<Animate>d__5::<timer>5__2  /*0x04000122*/
    IL_003a: br.s IL_0099
    IL_003c: ldloc.1
    IL_003d: ldfld Transform PositionAnimation::transformToAnimate  /*0x0400011D*/
    IL_0042: ldloc.1
    IL_0043: ldfld Vector3 PositionAnimation::initialPosition  /*0x0400011E*/
    IL_0048: ldloc.1
    IL_0049: ldfld Vector3 PositionAnimation::targetPosition  /*0x0400011C*/
    IL_004e: ldloc.1
    IL_004f: ldfld AnimationCurve PositionAnimation::curve  /*0x0400011B*/
    IL_0054: ldarg.0
    IL_0055: ldfld float PositionAnimation.<Animate>d__5::<timer>5__2  /*0x04000122*/
    IL_005a: ldloc.1
    IL_005b: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0060: div
    IL_0061: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0066: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_006b: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldfld float PositionAnimation.<Animate>d__5::<timer>5__2  /*0x04000122*/
    IL_0077: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007c: add
    IL_007d: stfld float PositionAnimation.<Animate>d__5::<timer>5__2  /*0x04000122*/
    IL_0082: ldarg.0
    IL_0083: ldnull
    IL_0084: stfld object PositionAnimation.<Animate>d__5::<>2__current  /*0x04000120*/
    IL_0089: ldarg.0
    IL_008a: ldc.i4.1
    IL_008b: stfld int PositionAnimation.<Animate>d__5::<>1__state  /*0x0400011F*/
    IL_0090: ldc.i4.1
    IL_0091: ret
    IL_0092: ldarg.0
    IL_0093: ldc.i4.m1
    IL_0094: stfld int PositionAnimation.<Animate>d__5::<>1__state  /*0x0400011F*/
    IL_0099: ldarg.0
    IL_009a: ldfld float PositionAnimation.<Animate>d__5::<timer>5__2  /*0x04000122*/
    IL_009f: ldloc.1
    IL_00a0: ldfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_00a5: blt.s IL_003c
    IL_00a7: ldloc.1
    IL_00a8: ldfld Transform PositionAnimation::transformToAnimate  /*0x0400011D*/
    IL_00ad: ldloc.1
    IL_00ae: ldfld Vector3 PositionAnimation::initialPosition  /*0x0400011E*/
    IL_00b3: ldloc.1
    IL_00b4: ldfld Vector3 PositionAnimation::targetPosition  /*0x0400011C*/
    IL_00b9: ldloc.1
    IL_00ba: ldfld AnimationCurve PositionAnimation::curve  /*0x0400011B*/
    IL_00bf: ldc.r4 1f
    IL_00c4: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00c9: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00ce: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00d3: ldc.i4.0
    IL_00d4: ret

  .method PositionAnimation.<Animate>d__5::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000FA rva 0x5e2d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PositionAnimation.<Animate>d__5::<>2__current  /*0x04000120*/
    IL_0006: ret

  .method PositionAnimation.<Animate>d__5::System.Collections.IEnumerator.Reset()  // token 0x060000FB rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PositionAnimation.<Animate>d__5::System.Collections.IEnumerator.get_Current()  // token 0x060000FC rva 0x5e2d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PositionAnimation.<Animate>d__5::<>2__current  /*0x04000120*/
    IL_0006: ret

