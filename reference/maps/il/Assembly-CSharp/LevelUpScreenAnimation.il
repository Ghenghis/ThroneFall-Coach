// ===== LevelUpScreenAnimation  (token 0x0200031E) =====
  .method LevelUpScreenAnimation::Trigger()  // token 0x0600112D rva 0x50546 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator LevelUpScreenAnimation::Animation()  /*0x0600112E*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method LevelUpScreenAnimation::Animation()  // token 0x0600112E rva 0x5055b attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LevelUpScreenAnimation.<Animation>d__4::.ctor(int)  /*0x06001130*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LevelUpScreenAnimation LevelUpScreenAnimation.<Animation>d__4::<>4__this  /*0x0400147E*/
    IL_000d: ret

  .method LevelUpScreenAnimation::.ctor()  // token 0x0600112F rva 0x5056a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float LevelUpScreenAnimation::animationTime  /*0x04001479*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== LevelUpScreenAnimation/<Animation>d__4  (token 0x0200031F) =====
  .method LevelUpScreenAnimation.<Animation>d__4::.ctor(int)  // token 0x06001130 rva 0x5057d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LevelUpScreenAnimation.<Animation>d__4::<>1__state  /*0x0400147C*/
    IL_000d: ret

  .method LevelUpScreenAnimation.<Animation>d__4::System.IDisposable.Dispose()  // token 0x06001131 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LevelUpScreenAnimation.<Animation>d__4::MoveNext()  // token 0x06001132 rva 0x5058c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 170 (0xaa), max stack 6, init locals
    .locals ([0] int, [1] LevelUpScreenAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int LevelUpScreenAnimation.<Animation>d__4::<>1__state  /*0x0400147C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LevelUpScreenAnimation LevelUpScreenAnimation.<Animation>d__4::<>4__this  /*0x0400147E*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0083
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int LevelUpScreenAnimation.<Animation>d__4::<>1__state  /*0x0400147C*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float LevelUpScreenAnimation.<Animation>d__4::<timer>5__2  /*0x0400147F*/
    IL_0029: br.s IL_008a
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float LevelUpScreenAnimation.<Animation>d__4::<timer>5__2  /*0x0400147F*/
    IL_0032: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0037: add
    IL_0038: stfld float LevelUpScreenAnimation.<Animation>d__4::<timer>5__2  /*0x0400147F*/
    IL_003d: ldloc.1
    IL_003e: ldfld Transform LevelUpScreenAnimation::target  /*0x0400147B*/
    IL_0043: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0048: ldloc.1
    IL_0049: ldfld AnimationCurve LevelUpScreenAnimation::scaleCurve  /*0x0400147A*/
    IL_004e: ldc.r4 0f
    IL_0053: ldloc.1
    IL_0054: ldfld float LevelUpScreenAnimation::animationTime  /*0x04001479*/
    IL_0059: ldarg.0
    IL_005a: ldfld float LevelUpScreenAnimation.<Animation>d__4::<timer>5__2  /*0x0400147F*/
    IL_005f: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0064: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0069: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0073: ldarg.0
    IL_0074: ldnull
    IL_0075: stfld object LevelUpScreenAnimation.<Animation>d__4::<>2__current  /*0x0400147D*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.1
    IL_007c: stfld int LevelUpScreenAnimation.<Animation>d__4::<>1__state  /*0x0400147C*/
    IL_0081: ldc.i4.1
    IL_0082: ret
    IL_0083: ldarg.0
    IL_0084: ldc.i4.m1
    IL_0085: stfld int LevelUpScreenAnimation.<Animation>d__4::<>1__state  /*0x0400147C*/
    IL_008a: ldarg.0
    IL_008b: ldfld float LevelUpScreenAnimation.<Animation>d__4::<timer>5__2  /*0x0400147F*/
    IL_0090: ldloc.1
    IL_0091: ldfld float LevelUpScreenAnimation::animationTime  /*0x04001479*/
    IL_0096: blt.s IL_002b
    IL_0098: ldloc.1
    IL_0099: ldfld Transform LevelUpScreenAnimation::target  /*0x0400147B*/
    IL_009e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00a3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a8: ldc.i4.0
    IL_00a9: ret

  .method LevelUpScreenAnimation.<Animation>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001133 rva 0x50642 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelUpScreenAnimation.<Animation>d__4::<>2__current  /*0x0400147D*/
    IL_0006: ret

  .method LevelUpScreenAnimation.<Animation>d__4::System.Collections.IEnumerator.Reset()  // token 0x06001134 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LevelUpScreenAnimation.<Animation>d__4::System.Collections.IEnumerator.get_Current()  // token 0x06001135 rva 0x50642 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelUpScreenAnimation.<Animation>d__4::<>2__current  /*0x0400147D*/
    IL_0006: ret

