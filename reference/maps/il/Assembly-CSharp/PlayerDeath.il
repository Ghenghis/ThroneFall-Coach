// ===== PlayerDeath  (token 0x02000178) =====
  .method PlayerDeath::OnEnable()  // token 0x06000791 rva 0x258d3 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator PlayerDeath::Play()  /*0x06000792*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method PlayerDeath::Play()  // token 0x06000792 rva 0x258e8 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerDeath.<Play>d__6::.ctor(int)  /*0x06000794*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlayerDeath PlayerDeath.<Play>d__6::<>4__this  /*0x04000980*/
    IL_000d: ret

  .method PlayerDeath::.ctor()  // token 0x06000793 rva 0x258f7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.25f
    IL_0006: stfld float PlayerDeath::initialDelay  /*0x0400097A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== PlayerDeath/<Play>d__6  (token 0x02000179) =====
  .method PlayerDeath.<Play>d__6::.ctor(int)  // token 0x06000794 rva 0x2590a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_000d: ret

  .method PlayerDeath.<Play>d__6::System.IDisposable.Dispose()  // token 0x06000795 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerDeath.<Play>d__6::MoveNext()  // token 0x06000796 rva 0x2591c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 290 (0x122), max stack 6, init locals
    .locals ([0] int, [1] PlayerDeath)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerDeath PlayerDeath.<Play>d__6::<>4__this  /*0x04000980*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_006e, IL_00cf, IL_010d)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_002d: ldloc.1
    IL_002e: ldfld Transform PlayerDeath::animationTarget  /*0x0400097B*/
    IL_0033: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0038: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_003d: ldloc.1
    IL_003e: ldfld Cloth PlayerDeath::clothRenderer  /*0x0400097D*/
    IL_0043: ldc.i4.0
    IL_0044: callvirt void UnityEngine.Cloth::set_enabled(bool)  /*0x0A000093*/
    IL_0049: ldarg.0
    IL_004a: ldc.r4 0f
    IL_004f: stfld float PlayerDeath.<Play>d__6::<clock>5__2  /*0x04000981*/
    IL_0054: ldarg.0
    IL_0055: ldloc.1
    IL_0056: ldfld float PlayerDeath::initialDelay  /*0x0400097A*/
    IL_005b: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0060: stfld object PlayerDeath.<Play>d__6::<>2__current  /*0x0400097F*/
    IL_0065: ldarg.0
    IL_0066: ldc.i4.1
    IL_0067: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_006c: ldc.i4.1
    IL_006d: ret
    IL_006e: ldarg.0
    IL_006f: ldc.i4.m1
    IL_0070: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_0075: br.s IL_00d6
    IL_0077: ldarg.0
    IL_0078: ldarg.0
    IL_0079: ldfld float PlayerDeath.<Play>d__6::<clock>5__2  /*0x04000981*/
    IL_007e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0083: add
    IL_0084: stfld float PlayerDeath.<Play>d__6::<clock>5__2  /*0x04000981*/
    IL_0089: ldloc.1
    IL_008a: ldfld Transform PlayerDeath::animationTarget  /*0x0400097B*/
    IL_008f: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0094: ldloc.1
    IL_0095: ldfld AnimationCurve PlayerDeath::animationCurve  /*0x0400097C*/
    IL_009a: ldc.r4 0f
    IL_009f: ldloc.1
    IL_00a0: ldfld float PlayerDeath::animationTime  /*0x04000979*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld float PlayerDeath.<Play>d__6::<clock>5__2  /*0x04000981*/
    IL_00ab: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00b0: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00b5: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00ba: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00bf: ldarg.0
    IL_00c0: ldnull
    IL_00c1: stfld object PlayerDeath.<Play>d__6::<>2__current  /*0x0400097F*/
    IL_00c6: ldarg.0
    IL_00c7: ldc.i4.2
    IL_00c8: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_00cd: ldc.i4.1
    IL_00ce: ret
    IL_00cf: ldarg.0
    IL_00d0: ldc.i4.m1
    IL_00d1: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld float PlayerDeath.<Play>d__6::<clock>5__2  /*0x04000981*/
    IL_00dc: ldloc.1
    IL_00dd: ldfld float PlayerDeath::animationTime  /*0x04000979*/
    IL_00e2: ble.s IL_0077
    IL_00e4: ldloc.1
    IL_00e5: ldfld Transform PlayerDeath::animationTarget  /*0x0400097B*/
    IL_00ea: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00ef: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00f4: ldarg.0
    IL_00f5: ldc.r4 0.1f
    IL_00fa: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_00ff: stfld object PlayerDeath.<Play>d__6::<>2__current  /*0x0400097F*/
    IL_0104: ldarg.0
    IL_0105: ldc.i4.3
    IL_0106: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_010b: ldc.i4.1
    IL_010c: ret
    IL_010d: ldarg.0
    IL_010e: ldc.i4.m1
    IL_010f: stfld int PlayerDeath.<Play>d__6::<>1__state  /*0x0400097E*/
    IL_0114: ldloc.1
    IL_0115: ldfld Cloth PlayerDeath::clothRenderer  /*0x0400097D*/
    IL_011a: ldc.i4.1
    IL_011b: callvirt void UnityEngine.Cloth::set_enabled(bool)  /*0x0A000093*/
    IL_0120: ldc.i4.0
    IL_0121: ret

  .method PlayerDeath.<Play>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000797 rva 0x25a4a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerDeath.<Play>d__6::<>2__current  /*0x0400097F*/
    IL_0006: ret

  .method PlayerDeath.<Play>d__6::System.Collections.IEnumerator.Reset()  // token 0x06000798 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerDeath.<Play>d__6::System.Collections.IEnumerator.get_Current()  // token 0x06000799 rva 0x25a4a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerDeath.<Play>d__6::<>2__current  /*0x0400097F*/
    IL_0006: ret

