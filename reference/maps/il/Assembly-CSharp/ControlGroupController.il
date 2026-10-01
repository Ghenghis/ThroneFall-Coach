// ===== ControlGroupController  (token 0x020002E5) =====
  .method ControlGroupController::get_Hidden()  // token 0x06000FEE rva 0x48da0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ControlGroupController::hidden  /*0x040012D1*/
    IL_0006: ret

  .method ControlGroupController::Start()  // token 0x06000FEF rva 0x48da8 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ControlGroupController::SetInitialColor()  /*0x06000FF0*/
    IL_0006: ret

  .method ControlGroupController::SetInitialColor()  // token 0x06000FF0 rva 0x48db0 attrs Private, HideBySig
    // code size 106 (0x6a), max stack 2, init locals
    .locals ([0] ColorAndLightManager, [1] Colorscheme, [2] TagManager.ETag)
    IL_0000: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000c: brfalse.s IL_0069
    IL_000e: ldloc.0
    IL_000f: callvirt Colorscheme ColorAndLightManager::get_CurrentColorScheme()  /*0x06000354*/
    IL_0014: stloc.1
    IL_0015: ldloc.1
    IL_0016: ldnull
    IL_0017: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001c: brfalse.s IL_001f
    IL_001e: ret
    IL_001f: ldloc.1
    IL_0020: ldfld Color Colorscheme::Group1Color  /*0x04000485*/
    IL_0025: pop
    IL_0026: ldarg.0
    IL_0027: ldfld TagManager.ETag ControlGroupController::GroupTag  /*0x040012D0*/
    IL_002c: stloc.2
    IL_002d: ldloc.2
    IL_002e: ldc.i4.s 45
    IL_0030: sub
    IL_0031: switch (IL_0043, IL_0050, IL_005d)
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldloc.1
    IL_0045: ldfld Color Colorscheme::Group1Color  /*0x04000485*/
    IL_004a: stfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldloc.1
    IL_0052: ldfld Color Colorscheme::Group2Color  /*0x04000486*/
    IL_0057: stfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_005c: ret
    IL_005d: ldarg.0
    IL_005e: ldloc.1
    IL_005f: ldfld Color Colorscheme::Group3Color  /*0x04000487*/
    IL_0064: stfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_0069: ret

  .method ControlGroupController::FlagDrop()  // token 0x06000FF1 rva 0x48e26 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image ControlGroupController::_icon  /*0x040012C6*/
    IL_0006: ldc.r4 0f
    IL_000b: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0010: ldarg.0
    IL_0011: ldfld Animator ControlGroupController::_animator  /*0x040012C7*/
    IL_0016: ldstr "Drop"
    IL_001b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0020: ldarg.0
    IL_0021: ldc.i4.0
    IL_0022: stfld bool ControlGroupController::hidden  /*0x040012D1*/
    IL_0027: ret

  .method ControlGroupController::FlagHide()  // token 0x06000FF2 rva 0x48e4f attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator ControlGroupController::_animator  /*0x040012C7*/
    IL_0006: ldstr "Hide"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ldarg.0
    IL_0011: ldfld AudioSource ControlGroupController::_sfx_clear  /*0x040012C9*/
    IL_0016: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_001b: ldarg.0
    IL_001c: ldc.i4.1
    IL_001d: stfld bool ControlGroupController::hidden  /*0x040012D1*/
    IL_0022: ret

  .method ControlGroupController::RemovingPulse()  // token 0x06000FF3 rva 0x48e73 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator ControlGroupController::DoRemovingPulse()  /*0x06000FF4*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method ControlGroupController::DoRemovingPulse()  // token 0x06000FF4 rva 0x48e88 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ControlGroupController.<DoRemovingPulse>d__19::.ctor(int)  /*0x06000FFF*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ControlGroupController ControlGroupController.<DoRemovingPulse>d__19::<>4__this  /*0x040012D8*/
    IL_000d: ret

  .method ControlGroupController::Pulse()  // token 0x06000FF5 rva 0x48e97 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator ControlGroupController::DoPulse()  /*0x06000FF6*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method ControlGroupController::DoPulse()  // token 0x06000FF6 rva 0x48eac attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ControlGroupController.<DoPulse>d__21::.ctor(int)  /*0x06000FF9*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ControlGroupController ControlGroupController.<DoPulse>d__21::<>4__this  /*0x040012D4*/
    IL_000d: ret

  .method ControlGroupController::SetFillAmount(float)  // token 0x06000FF7 rva 0x48ebb attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image ControlGroupController::_icon  /*0x040012C6*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_000c: ret

  .method ControlGroupController::.ctor()  // token 0x06000FF8 rva 0x48ecc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 117 (0x75), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0006: stfld Color ControlGroupController::_pulseColor  /*0x040012CA*/
    IL_000b: ldarg.0
    IL_000c: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_0011: stfld Color ControlGroupController::_removingColor  /*0x040012CB*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.5f
    IL_001c: stfld float ControlGroupController::_pulseTime  /*0x040012CD*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: ldc.r4 0f
    IL_002c: ldc.r4 1f
    IL_0031: ldc.r4 1f
    IL_0036: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_003b: stfld AnimationCurve ControlGroupController::_pulseCurve  /*0x040012CE*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0f
    IL_0046: ldc.r4 0f
    IL_004b: ldc.r4 1f
    IL_0050: ldc.r4 1f
    IL_0055: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_005a: stfld AnimationCurve ControlGroupController::_removeFlash  /*0x040012CF*/
    IL_005f: ldarg.0
    IL_0060: ldc.i4.s 45
    IL_0062: stfld TagManager.ETag ControlGroupController::GroupTag  /*0x040012D0*/
    IL_0067: ldarg.0
    IL_0068: ldc.i4.1
    IL_0069: stfld bool ControlGroupController::hidden  /*0x040012D1*/
    IL_006e: ldarg.0
    IL_006f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0074: ret

// ===== ControlGroupController/<DoPulse>d__21  (token 0x020002E6) =====
  .method ControlGroupController.<DoPulse>d__21::.ctor(int)  // token 0x06000FF9 rva 0x48f4d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ControlGroupController.<DoPulse>d__21::<>1__state  /*0x040012D2*/
    IL_000d: ret

  .method ControlGroupController.<DoPulse>d__21::System.IDisposable.Dispose()  // token 0x06000FFA rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ControlGroupController.<DoPulse>d__21::MoveNext()  // token 0x06000FFB rva 0x48f5c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 184 (0xb8), max stack 5, init locals
    .locals ([0] int, [1] ControlGroupController, [2] Color)
    IL_0000: ldarg.0
    IL_0001: ldfld int ControlGroupController.<DoPulse>d__21::<>1__state  /*0x040012D2*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ControlGroupController ControlGroupController.<DoPulse>d__21::<>4__this  /*0x040012D4*/
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
    IL_001c: stfld int ControlGroupController.<DoPulse>d__21::<>1__state  /*0x040012D2*/
    IL_0021: ldloc.1
    IL_0022: call void ControlGroupController::SetInitialColor()  /*0x06000FF0*/
    IL_0027: ldarg.0
    IL_0028: ldc.r4 0f
    IL_002d: stfld float ControlGroupController.<DoPulse>d__21::<elapsedTime>5__2  /*0x040012D5*/
    IL_0032: ldloc.1
    IL_0033: ldfld AudioSource ControlGroupController::_sfx_create  /*0x040012C8*/
    IL_0038: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_003d: br.s IL_00a8
    IL_003f: ldloc.1
    IL_0040: ldfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_0045: ldloc.1
    IL_0046: ldfld Color ControlGroupController::_pulseColor  /*0x040012CA*/
    IL_004b: ldloc.1
    IL_004c: ldfld AnimationCurve ControlGroupController::_pulseCurve  /*0x040012CE*/
    IL_0051: ldarg.0
    IL_0052: ldfld float ControlGroupController.<DoPulse>d__21::<elapsedTime>5__2  /*0x040012D5*/
    IL_0057: ldloc.1
    IL_0058: ldfld float ControlGroupController::_pulseTime  /*0x040012CD*/
    IL_005d: div
    IL_005e: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0063: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0068: stloc.2
    IL_0069: ldloc.1
    IL_006a: ldfld Image ControlGroupController::_icon  /*0x040012C6*/
    IL_006f: callvirt Material UnityEngine.UI.Graphic::get_material()  /*0x0A00064D*/
    IL_0074: ldstr "_Color"
    IL_0079: ldloc.2
    IL_007a: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_007f: ldarg.0
    IL_0080: ldarg.0
    IL_0081: ldfld float ControlGroupController.<DoPulse>d__21::<elapsedTime>5__2  /*0x040012D5*/
    IL_0086: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008b: add
    IL_008c: stfld float ControlGroupController.<DoPulse>d__21::<elapsedTime>5__2  /*0x040012D5*/
    IL_0091: ldarg.0
    IL_0092: ldnull
    IL_0093: stfld object ControlGroupController.<DoPulse>d__21::<>2__current  /*0x040012D3*/
    IL_0098: ldarg.0
    IL_0099: ldc.i4.1
    IL_009a: stfld int ControlGroupController.<DoPulse>d__21::<>1__state  /*0x040012D2*/
    IL_009f: ldc.i4.1
    IL_00a0: ret
    IL_00a1: ldarg.0
    IL_00a2: ldc.i4.m1
    IL_00a3: stfld int ControlGroupController.<DoPulse>d__21::<>1__state  /*0x040012D2*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld float ControlGroupController.<DoPulse>d__21::<elapsedTime>5__2  /*0x040012D5*/
    IL_00ae: ldloc.1
    IL_00af: ldfld float ControlGroupController::_pulseTime  /*0x040012CD*/
    IL_00b4: blt.s IL_003f
    IL_00b6: ldc.i4.0
    IL_00b7: ret

  .method ControlGroupController.<DoPulse>d__21::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000FFC rva 0x49020 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ControlGroupController.<DoPulse>d__21::<>2__current  /*0x040012D3*/
    IL_0006: ret

  .method ControlGroupController.<DoPulse>d__21::System.Collections.IEnumerator.Reset()  // token 0x06000FFD rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ControlGroupController.<DoPulse>d__21::System.Collections.IEnumerator.get_Current()  // token 0x06000FFE rva 0x49020 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ControlGroupController.<DoPulse>d__21::<>2__current  /*0x040012D3*/
    IL_0006: ret

// ===== ControlGroupController/<DoRemovingPulse>d__19  (token 0x020002E7) =====
  .method ControlGroupController.<DoRemovingPulse>d__19::.ctor(int)  // token 0x06000FFF rva 0x49028 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ControlGroupController.<DoRemovingPulse>d__19::<>1__state  /*0x040012D6*/
    IL_000d: ret

  .method ControlGroupController.<DoRemovingPulse>d__19::System.IDisposable.Dispose()  // token 0x06001000 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ControlGroupController.<DoRemovingPulse>d__19::MoveNext()  // token 0x06001001 rva 0x49038 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 197 (0xc5), max stack 5, init locals
    .locals ([0] int, [1] ControlGroupController, [2] Color)
    IL_0000: ldarg.0
    IL_0001: ldfld int ControlGroupController.<DoRemovingPulse>d__19::<>1__state  /*0x040012D6*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ControlGroupController ControlGroupController.<DoRemovingPulse>d__19::<>4__this  /*0x040012D8*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0093
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int ControlGroupController.<DoRemovingPulse>d__19::<>1__state  /*0x040012D6*/
    IL_001e: ldloc.1
    IL_001f: call void ControlGroupController::SetInitialColor()  /*0x06000FF0*/
    IL_0024: ldarg.0
    IL_0025: ldc.r4 0f
    IL_002a: stfld float ControlGroupController.<DoRemovingPulse>d__19::<elapsedTime>5__2  /*0x040012D9*/
    IL_002f: br.s IL_009a
    IL_0031: ldloc.1
    IL_0032: ldfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_0037: ldloc.1
    IL_0038: ldfld Color ControlGroupController::_pulseColor  /*0x040012CA*/
    IL_003d: ldloc.1
    IL_003e: ldfld AnimationCurve ControlGroupController::_removeFlash  /*0x040012CF*/
    IL_0043: ldarg.0
    IL_0044: ldfld float ControlGroupController.<DoRemovingPulse>d__19::<elapsedTime>5__2  /*0x040012D9*/
    IL_0049: ldloc.1
    IL_004a: ldfld float ControlGroupController::_pulseTime  /*0x040012CD*/
    IL_004f: div
    IL_0050: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0055: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_005a: stloc.2
    IL_005b: ldloc.1
    IL_005c: ldfld Image ControlGroupController::_icon  /*0x040012C6*/
    IL_0061: callvirt Material UnityEngine.UI.Graphic::get_material()  /*0x0A00064D*/
    IL_0066: ldstr "_Color"
    IL_006b: ldloc.2
    IL_006c: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0071: ldarg.0
    IL_0072: ldarg.0
    IL_0073: ldfld float ControlGroupController.<DoRemovingPulse>d__19::<elapsedTime>5__2  /*0x040012D9*/
    IL_0078: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_007d: add
    IL_007e: stfld float ControlGroupController.<DoRemovingPulse>d__19::<elapsedTime>5__2  /*0x040012D9*/
    IL_0083: ldarg.0
    IL_0084: ldnull
    IL_0085: stfld object ControlGroupController.<DoRemovingPulse>d__19::<>2__current  /*0x040012D7*/
    IL_008a: ldarg.0
    IL_008b: ldc.i4.1
    IL_008c: stfld int ControlGroupController.<DoRemovingPulse>d__19::<>1__state  /*0x040012D6*/
    IL_0091: ldc.i4.1
    IL_0092: ret
    IL_0093: ldarg.0
    IL_0094: ldc.i4.m1
    IL_0095: stfld int ControlGroupController.<DoRemovingPulse>d__19::<>1__state  /*0x040012D6*/
    IL_009a: ldarg.0
    IL_009b: ldfld float ControlGroupController.<DoRemovingPulse>d__19::<elapsedTime>5__2  /*0x040012D9*/
    IL_00a0: ldloc.1
    IL_00a1: ldfld float ControlGroupController::_pulseTime  /*0x040012CD*/
    IL_00a6: blt.s IL_0031
    IL_00a8: ldloc.1
    IL_00a9: ldfld Image ControlGroupController::_icon  /*0x040012C6*/
    IL_00ae: callvirt Material UnityEngine.UI.Graphic::get_material()  /*0x0A00064D*/
    IL_00b3: ldstr "_Color"
    IL_00b8: ldloc.1
    IL_00b9: ldfld Color ControlGroupController::_initialColor  /*0x040012CC*/
    IL_00be: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_00c3: ldc.i4.0
    IL_00c4: ret

  .method ControlGroupController.<DoRemovingPulse>d__19::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001002 rva 0x49109 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ControlGroupController.<DoRemovingPulse>d__19::<>2__current  /*0x040012D7*/
    IL_0006: ret

  .method ControlGroupController.<DoRemovingPulse>d__19::System.Collections.IEnumerator.Reset()  // token 0x06001003 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ControlGroupController.<DoRemovingPulse>d__19::System.Collections.IEnumerator.get_Current()  // token 0x06001004 rva 0x49109 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ControlGroupController.<DoRemovingPulse>d__19::<>2__current  /*0x040012D7*/
    IL_0006: ret

