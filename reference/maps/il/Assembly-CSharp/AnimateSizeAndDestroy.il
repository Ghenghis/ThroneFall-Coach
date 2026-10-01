// ===== AnimateSizeAndDestroy  (token 0x02000017) =====
  .method AnimateSizeAndDestroy::Start()  // token 0x0600008D rva 0x47ab attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_000c: stfld Vector3 AnimateSizeAndDestroy::initialScale  /*0x04000095*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call IEnumerator AnimateSizeAndDestroy::AnimateScale()  /*0x0600008E*/
    IL_0018: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_001d: pop
    IL_001e: ret

  .method AnimateSizeAndDestroy::AnimateScale()  // token 0x0600008E rva 0x47cb attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AnimateSizeAndDestroy.<AnimateScale>d__4::.ctor(int)  /*0x06000090*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AnimateSizeAndDestroy AnimateSizeAndDestroy.<AnimateScale>d__4::<>4__this  /*0x04000098*/
    IL_000d: ret

  .method AnimateSizeAndDestroy::.ctor()  // token 0x0600008F rva 0x47da attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AnimateSizeAndDestroy::duration  /*0x04000094*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== AnimateSizeAndDestroy/<AnimateScale>d__4  (token 0x02000018) =====
  .method AnimateSizeAndDestroy.<AnimateScale>d__4::.ctor(int)  // token 0x06000090 rva 0x47ed attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AnimateSizeAndDestroy.<AnimateScale>d__4::<>1__state  /*0x04000096*/
    IL_000d: ret

  .method AnimateSizeAndDestroy.<AnimateScale>d__4::System.IDisposable.Dispose()  // token 0x06000091 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AnimateSizeAndDestroy.<AnimateScale>d__4::MoveNext()  // token 0x06000092 rva 0x47fc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 159 (0x9f), max stack 3, init locals
    .locals ([0] int, [1] AnimateSizeAndDestroy, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int AnimateSizeAndDestroy.<AnimateScale>d__4::<>1__state  /*0x04000096*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AnimateSizeAndDestroy AnimateSizeAndDestroy.<AnimateScale>d__4::<>4__this  /*0x04000098*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_007d
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AnimateSizeAndDestroy.<AnimateScale>d__4::<>1__state  /*0x04000096*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float AnimateSizeAndDestroy.<AnimateScale>d__4::<time>5__2  /*0x04000099*/
    IL_0029: br.s IL_0084
    IL_002b: ldloc.1
    IL_002c: ldfld AnimationCurve AnimateSizeAndDestroy::animationCurve  /*0x04000093*/
    IL_0031: ldarg.0
    IL_0032: ldfld float AnimateSizeAndDestroy.<AnimateScale>d__4::<time>5__2  /*0x04000099*/
    IL_0037: ldloc.1
    IL_0038: ldfld float AnimateSizeAndDestroy::duration  /*0x04000094*/
    IL_003d: div
    IL_003e: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0043: stloc.2
    IL_0044: ldloc.1
    IL_0045: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004a: ldloc.1
    IL_004b: ldfld Vector3 AnimateSizeAndDestroy::initialScale  /*0x04000095*/
    IL_0050: ldloc.2
    IL_0051: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0056: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_005b: ldarg.0
    IL_005c: ldarg.0
    IL_005d: ldfld float AnimateSizeAndDestroy.<AnimateScale>d__4::<time>5__2  /*0x04000099*/
    IL_0062: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0067: add
    IL_0068: stfld float AnimateSizeAndDestroy.<AnimateScale>d__4::<time>5__2  /*0x04000099*/
    IL_006d: ldarg.0
    IL_006e: ldnull
    IL_006f: stfld object AnimateSizeAndDestroy.<AnimateScale>d__4::<>2__current  /*0x04000097*/
    IL_0074: ldarg.0
    IL_0075: ldc.i4.1
    IL_0076: stfld int AnimateSizeAndDestroy.<AnimateScale>d__4::<>1__state  /*0x04000096*/
    IL_007b: ldc.i4.1
    IL_007c: ret
    IL_007d: ldarg.0
    IL_007e: ldc.i4.m1
    IL_007f: stfld int AnimateSizeAndDestroy.<AnimateScale>d__4::<>1__state  /*0x04000096*/
    IL_0084: ldarg.0
    IL_0085: ldfld float AnimateSizeAndDestroy.<AnimateScale>d__4::<time>5__2  /*0x04000099*/
    IL_008a: ldloc.1
    IL_008b: ldfld float AnimateSizeAndDestroy::duration  /*0x04000094*/
    IL_0090: ble.s IL_002b
    IL_0092: ldloc.1
    IL_0093: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0098: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_009d: ldc.i4.0
    IL_009e: ret

  .method AnimateSizeAndDestroy.<AnimateScale>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000093 rva 0x48a7 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AnimateSizeAndDestroy.<AnimateScale>d__4::<>2__current  /*0x04000097*/
    IL_0006: ret

  .method AnimateSizeAndDestroy.<AnimateScale>d__4::System.Collections.IEnumerator.Reset()  // token 0x06000094 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AnimateSizeAndDestroy.<AnimateScale>d__4::System.Collections.IEnumerator.get_Current()  // token 0x06000095 rva 0x48a7 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AnimateSizeAndDestroy.<AnimateScale>d__4::<>2__current  /*0x04000097*/
    IL_0006: ret

