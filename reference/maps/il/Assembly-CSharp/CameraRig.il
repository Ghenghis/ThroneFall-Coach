// ===== CameraRig  (token 0x02000096) =====
  .method CameraRig::get_DefaultOrthSize()  // token 0x0600032A rva 0xdffe attrs Private, HideBySig, SpecialName
    // code size 9 (0x9), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float[] CameraRig::zoomLevels  /*0x040003E6*/
    IL_0006: ldc.i4.0
    IL_0007: ldelem.r4
    IL_0008: ret

  .method CameraRig::UpdateZoom()  // token 0x0600032B rva 0xe008 attrs Private, HideBySig
    // code size 183 (0xb7), max stack 6, init locals
    .locals ([0] float, [1] List.Enumerator<Camera>, [2] Camera)
    IL_0000: ldarg.0
    IL_0001: ldfld Player CameraRig::input  /*0x040003E8*/
    IL_0006: ldstr "Zoom"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_003c
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: ldfld int CameraRig::zoomLevel  /*0x040003E9*/
    IL_0019: ldc.i4.1
    IL_001a: add
    IL_001b: ldarg.0
    IL_001c: ldfld float[] CameraRig::zoomLevels  /*0x040003E6*/
    IL_0021: ldlen
    IL_0022: conv.i4
    IL_0023: rem
    IL_0024: stfld int CameraRig::zoomLevel  /*0x040003E9*/
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld float[] CameraRig::zoomLevels  /*0x040003E6*/
    IL_0030: ldarg.0
    IL_0031: ldfld int CameraRig::zoomLevel  /*0x040003E9*/
    IL_0036: ldelem.r4
    IL_0037: stfld float CameraRig::targetOrthSize  /*0x040003EA*/
    IL_003c: ldarg.0
    IL_003d: ldfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_0042: ldc.r4 0f
    IL_0047: bgt.s IL_0051
    IL_0049: ldarg.0
    IL_004a: ldfld float CameraRig::targetOrthSize  /*0x040003EA*/
    IL_004f: br.s IL_005e
    IL_0051: ldarg.0
    IL_0052: ldfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_0057: ldarg.0
    IL_0058: call float CameraRig::get_DefaultOrthSize()  /*0x0600032A*/
    IL_005d: mul
    IL_005e: stloc.0
    IL_005f: ldarg.0
    IL_0060: ldfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_0065: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Camera>::GetEnumerator()  /*0x0A000168*/
    IL_006a: stloc.1
    IL_006b: br.s IL_009d
    IL_006d: ldloca.s 1
    IL_006f: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::get_Current()  /*0x0A000169*/
    IL_0074: stloc.2
    IL_0075: ldloc.2
    IL_0076: ldloc.0
    IL_0077: ldloc.2
    IL_0078: callvirt float UnityEngine.Camera::get_orthographicSize()  /*0x0A000166*/
    IL_007d: ldc.r4 0.5f
    IL_0082: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0087: ldarg.0
    IL_0088: ldfld float CameraRig::zoomSpeed  /*0x040003E7*/
    IL_008d: mul
    IL_008e: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0093: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0098: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_009d: ldloca.s 1
    IL_009f: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::MoveNext()  /*0x0A00016A*/
    IL_00a4: brtrue.s IL_006d
    IL_00a6: leave.s IL_00b6
    IL_00a8: ldloca.s 1
    IL_00aa: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Camera>  /*0x1B00002F*/
    IL_00b0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b5: endfinally
    IL_00b6: ret
    .try IL_006b-IL_00a8 finally handler IL_00a8-IL_00b6

  .method CameraRig::Start()  // token 0x0600032C rva 0xe0dc attrs Private, HideBySig
    // code size 90 (0x5a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_000c: stfld Quaternion CameraRig::startRotation  /*0x040003E3*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_001d: stfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_0029: stfld Transform CameraRig::currentTarget  /*0x040003E2*/
    IL_002e: ldarg.0
    IL_002f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: ldnull
    IL_0035: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_003a: ldarg.0
    IL_003b: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0040: ldc.i4.0
    IL_0041: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0046: stfld Player CameraRig::input  /*0x040003E8*/
    IL_004b: ldarg.0
    IL_004c: ldarg.0
    IL_004d: ldfld float[] CameraRig::zoomLevels  /*0x040003E6*/
    IL_0052: ldc.i4.0
    IL_0053: ldelem.r4
    IL_0054: stfld float CameraRig::targetOrthSize  /*0x040003EA*/
    IL_0059: ret

  .method CameraRig::Update()  // token 0x0600032D rva 0xe144 attrs Private, HideBySig
    // code size 260 (0x104), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool CameraRig::transitionRunning  /*0x040003EB*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_000f: ldnull
    IL_0010: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0015: brfalse.s IL_004c
    IL_0017: ldarg.0
    IL_0018: ldfld Transform CameraRig::currentTarget  /*0x040003E2*/
    IL_001d: ldarg.0
    IL_001e: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_0023: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0028: brfalse.s IL_004c
    IL_002a: ldarg.0
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_0032: ldarg.0
    IL_0033: ldfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_0038: ldarg.0
    IL_0039: call float CameraRig::get_DefaultOrthSize()  /*0x0600032A*/
    IL_003e: mul
    IL_003f: call IEnumerator CameraRig::TransitionToTarget(UnityEngine.Transform,float)  /*0x0600032E*/
    IL_0044: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0049: pop
    IL_004a: br.s IL_0092
    IL_004c: ldarg.0
    IL_004d: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_0052: ldnull
    IL_0053: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0058: brfalse.s IL_0092
    IL_005a: ldarg.0
    IL_005b: ldfld Transform CameraRig::currentTarget  /*0x040003E2*/
    IL_0060: ldarg.0
    IL_0061: ldfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_0066: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_006b: brfalse.s IL_0092
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: call float CameraRig::get_DefaultOrthSize()  /*0x0600032A*/
    IL_0074: stfld float CameraRig::targetOrthSize  /*0x040003EA*/
    IL_0079: ldarg.0
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: ldfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_0081: ldarg.0
    IL_0082: ldfld float CameraRig::targetOrthSize  /*0x040003EA*/
    IL_0087: call IEnumerator CameraRig::TransitionToTarget(UnityEngine.Transform,float)  /*0x0600032E*/
    IL_008c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0091: pop
    IL_0092: ldarg.0
    IL_0093: ldfld bool CameraRig::transitionRunning  /*0x040003EB*/
    IL_0098: brfalse.s IL_009b
    IL_009a: ret
    IL_009b: ldarg.0
    IL_009c: call void CameraRig::UpdateZoom()  /*0x0600032B*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_00a7: ldnull
    IL_00a8: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00ad: brfalse.s IL_00dc
    IL_00af: ldarg.0
    IL_00b0: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_00bb: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c0: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00c5: ldarg.0
    IL_00c6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld Transform CameraRig::overrideCameraTarget  /*0x040003DF*/
    IL_00d1: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00d6: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_00db: ret
    IL_00dc: ldarg.0
    IL_00dd: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_00e8: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ed: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00f2: ldarg.0
    IL_00f3: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f8: ldarg.0
    IL_00f9: ldfld Quaternion CameraRig::startRotation  /*0x040003E3*/
    IL_00fe: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0103: ret

  .method CameraRig::TransitionToTarget(UnityEngine.Transform,float)  // token 0x0600032E rva 0xe254 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void CameraRig.<TransitionToTarget>d__18::.ctor(int)  /*0x06000330*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld CameraRig CameraRig.<TransitionToTarget>d__18::<>4__this  /*0x040003EE*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float CameraRig.<TransitionToTarget>d__18::targetCameraSize  /*0x040003F0*/
    IL_001b: ret

  .method CameraRig::.ctor()  // token 0x0600032F rva 0xe274 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 74 (0x4a), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 -1f
    IL_0006: stfld float CameraRig::overrideZoom  /*0x040003E0*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float CameraRig::transitionSpeed  /*0x040003E4*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<UnityEngine.Camera>::.ctor()  /*0x0A00016B*/
    IL_001c: stfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.4
    IL_0023: newarr System.Single  /*0x01000052*/
    IL_0028: dup
    IL_0029: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=16 <PrivateImplementationDetails>::B631696EB16EF3A01596305E592C512E9D1253AFF3A806B5C707BACEA66AE3CA  /*0x040037B1*/
    IL_002e: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A00016C*/
    IL_0033: stfld float[] CameraRig::zoomLevels  /*0x040003E6*/
    IL_0038: ldarg.0
    IL_0039: ldc.r4 50f
    IL_003e: stfld float CameraRig::zoomSpeed  /*0x040003E7*/
    IL_0043: ldarg.0
    IL_0044: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0049: ret

// ===== CameraRig/<TransitionToTarget>d__18  (token 0x02000097) =====
  .method CameraRig.<TransitionToTarget>d__18::.ctor(int)  // token 0x06000330 rva 0xe2ca attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_000d: ret

  .method CameraRig.<TransitionToTarget>d__18::System.IDisposable.Dispose()  // token 0x06000331 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CameraRig.<TransitionToTarget>d__18::MoveNext()  // token 0x06000332 rva 0xe2dc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 677 (0x2a5), max stack 4, init locals
    .locals ([0] int, [1] CameraRig, [2] float, [3] float, [4] List.Enumerator<Camera>)
    IL_0000: ldarg.0
    IL_0001: ldfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld CameraRig CameraRig.<TransitionToTarget>d__18::<>4__this  /*0x040003EE*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0196, IL_0236)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool CameraRig::transitionRunning  /*0x040003EB*/
    IL_0030: ldarg.0
    IL_0031: ldloc.1
    IL_0032: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0037: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003c: stfld Vector3 CameraRig.<TransitionToTarget>d__18::<startPosition>5__2  /*0x040003F1*/
    IL_0041: ldarg.0
    IL_0042: ldloc.1
    IL_0043: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0048: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_004d: stfld Quaternion CameraRig.<TransitionToTarget>d__18::<startRotation>5__3  /*0x040003F2*/
    IL_0052: ldarg.0
    IL_0053: ldc.r4 0f
    IL_0058: stfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_005d: ldarg.0
    IL_005e: ldloc.1
    IL_005f: ldfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_0064: ldc.i4.0
    IL_0065: callvirt !0 System.Collections.Generic.List<UnityEngine.Camera>::get_Item(int)  /*0x0A00016D*/
    IL_006a: callvirt float UnityEngine.Camera::get_orthographicSize()  /*0x0A000166*/
    IL_006f: stfld float CameraRig.<TransitionToTarget>d__18::<startCameraSize>5__5  /*0x040003F4*/
    IL_0074: br IL_019d
    IL_0079: ldarg.0
    IL_007a: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_007f: ldnull
    IL_0080: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0085: brfalse.s IL_0098
    IL_0087: ldarg.0
    IL_0088: ldloc.1
    IL_0089: ldfld Transform CameraRig::cameraTarget  /*0x040003E1*/
    IL_008e: stfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_0093: br IL_01ad
    IL_0098: ldarg.0
    IL_0099: ldarg.0
    IL_009a: ldfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_009f: ldc.r4 0f
    IL_00a4: ldc.r4 1f
    IL_00a9: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_00ae: stfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_00b3: ldc.r4 3f
    IL_00b8: ldarg.0
    IL_00b9: ldfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_00be: ldc.r4 2f
    IL_00c3: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00c8: mul
    IL_00c9: ldc.r4 2f
    IL_00ce: ldarg.0
    IL_00cf: ldfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_00d4: ldc.r4 3f
    IL_00d9: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00de: mul
    IL_00df: sub
    IL_00e0: stloc.2
    IL_00e1: ldloc.1
    IL_00e2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00e7: ldarg.0
    IL_00e8: ldfld Vector3 CameraRig.<TransitionToTarget>d__18::<startPosition>5__2  /*0x040003F1*/
    IL_00ed: ldarg.0
    IL_00ee: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_00f3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f8: ldloc.2
    IL_00f9: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00fe: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0103: ldloc.1
    IL_0104: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0109: ldarg.0
    IL_010a: ldfld Quaternion CameraRig.<TransitionToTarget>d__18::<startRotation>5__3  /*0x040003F2*/
    IL_010f: ldarg.0
    IL_0110: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_0115: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_011a: ldloc.2
    IL_011b: call Quaternion UnityEngine.Quaternion::Lerp(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A000092*/
    IL_0120: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0125: ldarg.0
    IL_0126: ldfld float CameraRig.<TransitionToTarget>d__18::<startCameraSize>5__5  /*0x040003F4*/
    IL_012b: ldarg.0
    IL_012c: ldfld float CameraRig.<TransitionToTarget>d__18::targetCameraSize  /*0x040003F0*/
    IL_0131: ldloc.2
    IL_0132: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0137: stloc.3
    IL_0138: ldloc.1
    IL_0139: ldfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_013e: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Camera>::GetEnumerator()  /*0x0A000168*/
    IL_0143: stloc.s 4
    IL_0145: br.s IL_0154
    IL_0147: ldloca.s 4
    IL_0149: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::get_Current()  /*0x0A000169*/
    IL_014e: ldloc.3
    IL_014f: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_0154: ldloca.s 4
    IL_0156: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::MoveNext()  /*0x0A00016A*/
    IL_015b: brtrue.s IL_0147
    IL_015d: leave.s IL_016d
    IL_015f: ldloca.s 4
    IL_0161: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Camera>  /*0x1B00002F*/
    IL_0167: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_016c: endfinally
    IL_016d: ldarg.0
    IL_016e: ldarg.0
    IL_016f: ldfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_0174: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0179: ldloc.1
    IL_017a: ldfld float CameraRig::transitionSpeed  /*0x040003E4*/
    IL_017f: mul
    IL_0180: add
    IL_0181: stfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_0186: ldarg.0
    IL_0187: ldnull
    IL_0188: stfld object CameraRig.<TransitionToTarget>d__18::<>2__current  /*0x040003ED*/
    IL_018d: ldarg.0
    IL_018e: ldc.i4.1
    IL_018f: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_0194: ldc.i4.1
    IL_0195: ret
    IL_0196: ldarg.0
    IL_0197: ldc.i4.m1
    IL_0198: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_019d: ldarg.0
    IL_019e: ldfld float CameraRig.<TransitionToTarget>d__18::<transitionTime>5__4  /*0x040003F3*/
    IL_01a3: ldc.r4 1f
    IL_01a8: blt IL_0079
    IL_01ad: ldloc.1
    IL_01ae: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01b3: ldarg.0
    IL_01b4: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_01b9: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01be: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_01c3: ldloc.1
    IL_01c4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01c9: ldarg.0
    IL_01ca: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_01cf: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_01d4: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_01d9: ldloc.1
    IL_01da: ldfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_01df: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Camera>::GetEnumerator()  /*0x0A000168*/
    IL_01e4: stloc.s 4
    IL_01e6: br.s IL_01fa
    IL_01e8: ldloca.s 4
    IL_01ea: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::get_Current()  /*0x0A000169*/
    IL_01ef: ldarg.0
    IL_01f0: ldfld float CameraRig.<TransitionToTarget>d__18::targetCameraSize  /*0x040003F0*/
    IL_01f5: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_01fa: ldloca.s 4
    IL_01fc: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::MoveNext()  /*0x0A00016A*/
    IL_0201: brtrue.s IL_01e8
    IL_0203: leave.s IL_0213
    IL_0205: ldloca.s 4
    IL_0207: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Camera>  /*0x1B00002F*/
    IL_020d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0212: endfinally
    IL_0213: ldloc.1
    IL_0214: ldarg.0
    IL_0215: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_021a: stfld Transform CameraRig::currentTarget  /*0x040003E2*/
    IL_021f: ldloc.1
    IL_0220: ldc.i4.0
    IL_0221: stfld bool CameraRig::transitionRunning  /*0x040003EB*/
    IL_0226: ldarg.0
    IL_0227: ldnull
    IL_0228: stfld object CameraRig.<TransitionToTarget>d__18::<>2__current  /*0x040003ED*/
    IL_022d: ldarg.0
    IL_022e: ldc.i4.2
    IL_022f: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_0234: ldc.i4.1
    IL_0235: ret
    IL_0236: ldarg.0
    IL_0237: ldc.i4.m1
    IL_0238: stfld int CameraRig.<TransitionToTarget>d__18::<>1__state  /*0x040003EC*/
    IL_023d: ldloc.1
    IL_023e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0243: ldarg.0
    IL_0244: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_0249: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_024e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0253: ldloc.1
    IL_0254: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0259: ldarg.0
    IL_025a: ldfld Transform CameraRig.<TransitionToTarget>d__18::newTarget  /*0x040003EF*/
    IL_025f: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0264: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0269: ldloc.1
    IL_026a: ldfld List<Camera> CameraRig::cameras  /*0x040003E5*/
    IL_026f: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Camera>::GetEnumerator()  /*0x0A000168*/
    IL_0274: stloc.s 4
    IL_0276: br.s IL_028a
    IL_0278: ldloca.s 4
    IL_027a: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::get_Current()  /*0x0A000169*/
    IL_027f: ldarg.0
    IL_0280: ldfld float CameraRig.<TransitionToTarget>d__18::targetCameraSize  /*0x040003F0*/
    IL_0285: callvirt void UnityEngine.Camera::set_orthographicSize(float)  /*0x0A000167*/
    IL_028a: ldloca.s 4
    IL_028c: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Camera>::MoveNext()  /*0x0A00016A*/
    IL_0291: brtrue.s IL_0278
    IL_0293: leave.s IL_02a3
    IL_0295: ldloca.s 4
    IL_0297: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Camera>  /*0x1B00002F*/
    IL_029d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02a2: endfinally
    IL_02a3: ldc.i4.0
    IL_02a4: ret
    .try IL_0145-IL_015f finally handler IL_015f-IL_016d
    .try IL_01e6-IL_0205 finally handler IL_0205-IL_0213
    .try IL_0276-IL_0295 finally handler IL_0295-IL_02a3

  .method CameraRig.<TransitionToTarget>d__18::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000333 rva 0xe5b8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CameraRig.<TransitionToTarget>d__18::<>2__current  /*0x040003ED*/
    IL_0006: ret

  .method CameraRig.<TransitionToTarget>d__18::System.Collections.IEnumerator.Reset()  // token 0x06000334 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method CameraRig.<TransitionToTarget>d__18::System.Collections.IEnumerator.get_Current()  // token 0x06000335 rva 0xe5b8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object CameraRig.<TransitionToTarget>d__18::<>2__current  /*0x040003ED*/
    IL_0006: ret

