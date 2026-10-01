// ===== UnitCommandRadiusAnimation  (token 0x02000047) =====
  .method UnitCommandRadiusAnimation::get_Active()  // token 0x06000152 rva 0x7422 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitCommandRadiusAnimation::active  /*0x040001B2*/
    IL_0006: ret

  .method UnitCommandRadiusAnimation::Start()  // token 0x06000153 rva 0x742a attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitCommandRadiusAnimation::active  /*0x040001B2*/
    IL_0006: brtrue.s IL_0014
    IL_0008: ldarg.0
    IL_0009: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: ldc.i4.0
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ret

  .method UnitCommandRadiusAnimation::Activate()  // token 0x06000154 rva 0x7440 attrs Public, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool UnitCommandRadiusAnimation::active  /*0x040001B2*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: ldc.i4.1
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: call IEnumerator UnitCommandRadiusAnimation::AnimateShow()  /*0x06000156*/
    IL_0020: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0025: pop
    IL_0026: ret

  .method UnitCommandRadiusAnimation::Deactivate()  // token 0x06000155 rva 0x7468 attrs Public, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool UnitCommandRadiusAnimation::active  /*0x040001B2*/
    IL_0007: ldarg.0
    IL_0008: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000d: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0012: brtrue.s IL_0015
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: call IEnumerator UnitCommandRadiusAnimation::AnimateHide()  /*0x06000157*/
    IL_0022: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0027: pop
    IL_0028: ret

  .method UnitCommandRadiusAnimation::AnimateShow()  // token 0x06000156 rva 0x7492 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UnitCommandRadiusAnimation.<AnimateShow>d__10::.ctor(int)  /*0x0600015F*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UnitCommandRadiusAnimation UnitCommandRadiusAnimation.<AnimateShow>d__10::<>4__this  /*0x040001B9*/
    IL_000d: ret

  .method UnitCommandRadiusAnimation::AnimateHide()  // token 0x06000157 rva 0x74a1 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UnitCommandRadiusAnimation.<AnimateHide>d__11::.ctor(int)  /*0x06000159*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UnitCommandRadiusAnimation UnitCommandRadiusAnimation.<AnimateHide>d__11::<>4__this  /*0x040001B5*/
    IL_000d: ret

  .method UnitCommandRadiusAnimation::.ctor()  // token 0x06000158 rva 0x74b0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.25f
    IL_0006: stfld float UnitCommandRadiusAnimation::hideTime  /*0x040001B1*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== UnitCommandRadiusAnimation/<AnimateHide>d__11  (token 0x02000048) =====
  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::.ctor(int)  // token 0x06000159 rva 0x74c3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UnitCommandRadiusAnimation.<AnimateHide>d__11::<>1__state  /*0x040001B3*/
    IL_000d: ret

  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::System.IDisposable.Dispose()  // token 0x0600015A rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::MoveNext()  // token 0x0600015B rva 0x74d4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 182 (0xb6), max stack 6, init locals
    .locals ([0] int, [1] UnitCommandRadiusAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int UnitCommandRadiusAnimation.<AnimateHide>d__11::<>1__state  /*0x040001B3*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UnitCommandRadiusAnimation UnitCommandRadiusAnimation.<AnimateHide>d__11::<>4__this  /*0x040001B5*/
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
    IL_0019: stfld int UnitCommandRadiusAnimation.<AnimateHide>d__11::<>1__state  /*0x040001B3*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float UnitCommandRadiusAnimation.<AnimateHide>d__11::<timer>5__2  /*0x040001B6*/
    IL_0029: br.s IL_008a
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float UnitCommandRadiusAnimation.<AnimateHide>d__11::<timer>5__2  /*0x040001B6*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float UnitCommandRadiusAnimation.<AnimateHide>d__11::<timer>5__2  /*0x040001B6*/
    IL_003d: ldloc.1
    IL_003e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0043: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0048: ldloc.1
    IL_0049: ldfld AnimationCurve UnitCommandRadiusAnimation::hideCurve  /*0x040001AF*/
    IL_004e: ldc.r4 0f
    IL_0053: ldloc.1
    IL_0054: ldfld float UnitCommandRadiusAnimation::hideTime  /*0x040001B1*/
    IL_0059: ldarg.0
    IL_005a: ldfld float UnitCommandRadiusAnimation.<AnimateHide>d__11::<timer>5__2  /*0x040001B6*/
    IL_005f: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0064: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0069: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0073: ldarg.0
    IL_0074: ldnull
    IL_0075: stfld object UnitCommandRadiusAnimation.<AnimateHide>d__11::<>2__current  /*0x040001B4*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.1
    IL_007c: stfld int UnitCommandRadiusAnimation.<AnimateHide>d__11::<>1__state  /*0x040001B3*/
    IL_0081: ldc.i4.1
    IL_0082: ret
    IL_0083: ldarg.0
    IL_0084: ldc.i4.m1
    IL_0085: stfld int UnitCommandRadiusAnimation.<AnimateHide>d__11::<>1__state  /*0x040001B3*/
    IL_008a: ldarg.0
    IL_008b: ldfld float UnitCommandRadiusAnimation.<AnimateHide>d__11::<timer>5__2  /*0x040001B6*/
    IL_0090: ldloc.1
    IL_0091: ldfld float UnitCommandRadiusAnimation::hideTime  /*0x040001B1*/
    IL_0096: ble.s IL_002b
    IL_0098: ldloc.1
    IL_0099: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00a3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a8: ldloc.1
    IL_00a9: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ae: ldc.i4.0
    IL_00af: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b4: ldc.i4.0
    IL_00b5: ret

  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600015C rva 0x7596 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitCommandRadiusAnimation.<AnimateHide>d__11::<>2__current  /*0x040001B4*/
    IL_0006: ret

  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::System.Collections.IEnumerator.Reset()  // token 0x0600015D rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UnitCommandRadiusAnimation.<AnimateHide>d__11::System.Collections.IEnumerator.get_Current()  // token 0x0600015E rva 0x7596 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitCommandRadiusAnimation.<AnimateHide>d__11::<>2__current  /*0x040001B4*/
    IL_0006: ret

// ===== UnitCommandRadiusAnimation/<AnimateShow>d__10  (token 0x02000049) =====
  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::.ctor(int)  // token 0x0600015F rva 0x759e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UnitCommandRadiusAnimation.<AnimateShow>d__10::<>1__state  /*0x040001B7*/
    IL_000d: ret

  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::System.IDisposable.Dispose()  // token 0x06000160 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::MoveNext()  // token 0x06000161 rva 0x75b0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 170 (0xaa), max stack 6, init locals
    .locals ([0] int, [1] UnitCommandRadiusAnimation)
    IL_0000: ldarg.0
    IL_0001: ldfld int UnitCommandRadiusAnimation.<AnimateShow>d__10::<>1__state  /*0x040001B7*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UnitCommandRadiusAnimation UnitCommandRadiusAnimation.<AnimateShow>d__10::<>4__this  /*0x040001B9*/
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
    IL_0019: stfld int UnitCommandRadiusAnimation.<AnimateShow>d__10::<>1__state  /*0x040001B7*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float UnitCommandRadiusAnimation.<AnimateShow>d__10::<timer>5__2  /*0x040001BA*/
    IL_0029: br.s IL_008a
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float UnitCommandRadiusAnimation.<AnimateShow>d__10::<timer>5__2  /*0x040001BA*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float UnitCommandRadiusAnimation.<AnimateShow>d__10::<timer>5__2  /*0x040001BA*/
    IL_003d: ldloc.1
    IL_003e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0043: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0048: ldloc.1
    IL_0049: ldfld AnimationCurve UnitCommandRadiusAnimation::animationCurve  /*0x040001AE*/
    IL_004e: ldc.r4 0f
    IL_0053: ldloc.1
    IL_0054: ldfld float UnitCommandRadiusAnimation::animationTime  /*0x040001B0*/
    IL_0059: ldarg.0
    IL_005a: ldfld float UnitCommandRadiusAnimation.<AnimateShow>d__10::<timer>5__2  /*0x040001BA*/
    IL_005f: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0064: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0069: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0073: ldarg.0
    IL_0074: ldnull
    IL_0075: stfld object UnitCommandRadiusAnimation.<AnimateShow>d__10::<>2__current  /*0x040001B8*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.1
    IL_007c: stfld int UnitCommandRadiusAnimation.<AnimateShow>d__10::<>1__state  /*0x040001B7*/
    IL_0081: ldc.i4.1
    IL_0082: ret
    IL_0083: ldarg.0
    IL_0084: ldc.i4.m1
    IL_0085: stfld int UnitCommandRadiusAnimation.<AnimateShow>d__10::<>1__state  /*0x040001B7*/
    IL_008a: ldarg.0
    IL_008b: ldfld float UnitCommandRadiusAnimation.<AnimateShow>d__10::<timer>5__2  /*0x040001BA*/
    IL_0090: ldloc.1
    IL_0091: ldfld float UnitCommandRadiusAnimation::animationTime  /*0x040001B0*/
    IL_0096: ble.s IL_002b
    IL_0098: ldloc.1
    IL_0099: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00a3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a8: ldc.i4.0
    IL_00a9: ret

  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000162 rva 0x7666 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitCommandRadiusAnimation.<AnimateShow>d__10::<>2__current  /*0x040001B8*/
    IL_0006: ret

  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::System.Collections.IEnumerator.Reset()  // token 0x06000163 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UnitCommandRadiusAnimation.<AnimateShow>d__10::System.Collections.IEnumerator.get_Current()  // token 0x06000164 rva 0x7666 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitCommandRadiusAnimation.<AnimateShow>d__10::<>2__current  /*0x040001B8*/
    IL_0006: ret

