// ===== LightningStriker  (token 0x020001B6) =====
  .method LightningStriker::Start()  // token 0x060008E8 rva 0x2ad58 attrs Private, HideBySig
    // code size 148 (0x94), max stack 2, init locals
    IL_0000: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brtrue.s IL_001f
    IL_000d: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0012: callvirt Light ColorAndLightManager::get_Sunlight()  /*0x06000352*/
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001d: brfalse.s IL_0027
    IL_001f: ldarg.0
    IL_0020: ldc.i4.0
    IL_0021: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_002d: callvirt Light ColorAndLightManager::get_Sunlight()  /*0x06000352*/
    IL_0032: stfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Light>  /*0x2B00002C*/
    IL_003e: stfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_0043: ldarg.0
    IL_0044: ldarg.0
    IL_0045: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.AudioSource>  /*0x2B000017*/
    IL_004a: stfld AudioSource LightningStriker::aSource  /*0x04000B39*/
    IL_004f: ldarg.0
    IL_0050: call void LightningStriker::ResetTimer()  /*0x060008EB*/
    IL_0055: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_005a: ldnull
    IL_005b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0060: brfalse.s IL_0093
    IL_0062: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0067: callvirt Light ColorAndLightManager::get_Sunlight()  /*0x06000352*/
    IL_006c: ldnull
    IL_006d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0072: brfalse.s IL_0093
    IL_0074: ldarg.0
    IL_0075: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007a: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_007f: callvirt Light ColorAndLightManager::get_Sunlight()  /*0x06000352*/
    IL_0084: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0089: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_008e: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0093: ret

  .method LightningStriker::Update()  // token 0x060008E9 rva 0x2adf8 attrs Private, HideBySig
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LightningStriker::inAnimation  /*0x04000B3A*/
    IL_0006: brtrue.s IL_0034
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld float LightningStriker::timer  /*0x04000B3B*/
    IL_000f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0014: sub
    IL_0015: stfld float LightningStriker::timer  /*0x04000B3B*/
    IL_001a: ldarg.0
    IL_001b: ldfld float LightningStriker::timer  /*0x04000B3B*/
    IL_0020: ldc.r4 0f
    IL_0025: bgt.un.s IL_0034
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: call IEnumerator LightningStriker::AnimateLightningStrike()  /*0x060008EA*/
    IL_002e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0033: pop
    IL_0034: ret

  .method LightningStriker::AnimateLightningStrike()  // token 0x060008EA rva 0x2ae2e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LightningStriker.<AnimateLightningStrike>d__14::.ctor(int)  /*0x060008ED*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LightningStriker LightningStriker.<AnimateLightningStrike>d__14::<>4__this  /*0x04000B3E*/
    IL_000d: ret

  .method LightningStriker::ResetTimer()  // token 0x060008EB rva 0x2ae3d attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float LightningStriker::minSecondsBetweenStrikes  /*0x04000B30*/
    IL_0007: ldarg.0
    IL_0008: ldfld float LightningStriker::maxSecondsBetweenStrikes  /*0x04000B31*/
    IL_000d: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0012: stfld float LightningStriker::timer  /*0x04000B3B*/
    IL_0017: ret

  .method LightningStriker::.ctor()  // token 0x060008EC rva 0x2ae56 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float LightningStriker::minSecondsBetweenStrikes  /*0x04000B30*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 120f
    IL_0011: stfld float LightningStriker::maxSecondsBetweenStrikes  /*0x04000B31*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 3f
    IL_001c: stfld float LightningStriker::maxIntensity  /*0x04000B33*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float LightningStriker::strikeDuration  /*0x04000B34*/
    IL_002c: ldarg.0
    IL_002d: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0032: stfld Color LightningStriker::lightningLightColor  /*0x04000B35*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

// ===== LightningStriker/<AnimateLightningStrike>d__14  (token 0x020001B7) =====
  .method LightningStriker.<AnimateLightningStrike>d__14::.ctor(int)  // token 0x060008ED rva 0x2ae95 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LightningStriker.<AnimateLightningStrike>d__14::<>1__state  /*0x04000B3C*/
    IL_000d: ret

  .method LightningStriker.<AnimateLightningStrike>d__14::System.IDisposable.Dispose()  // token 0x060008EE rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LightningStriker.<AnimateLightningStrike>d__14::MoveNext()  // token 0x060008EF rva 0x2aea4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 371 (0x173), max stack 4, init locals
    .locals ([0] int, [1] LightningStriker, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int LightningStriker.<AnimateLightningStrike>d__14::<>1__state  /*0x04000B3C*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LightningStriker LightningStriker.<AnimateLightningStrike>d__14::<>4__this  /*0x04000B3E*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_0134
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int LightningStriker.<AnimateLightningStrike>d__14::<>1__state  /*0x04000B3C*/
    IL_0021: ldloc.1
    IL_0022: ldc.i4.1
    IL_0023: stfld bool LightningStriker::inAnimation  /*0x04000B3A*/
    IL_0028: ldloc.1
    IL_0029: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_002e: ldloc.1
    IL_002f: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_0034: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_0039: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_003e: ldloc.1
    IL_003f: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_0044: ldloc.1
    IL_0045: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_004a: callvirt float UnityEngine.Light::get_intensity()  /*0x0A0003AF*/
    IL_004f: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_0054: ldloc.1
    IL_0055: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_005a: ldc.i4.1
    IL_005b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0060: ldloc.1
    IL_0061: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_0066: ldc.i4.0
    IL_0067: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_006c: ldloc.1
    IL_006d: ldfld AudioSource LightningStriker::aSource  /*0x04000B39*/
    IL_0072: ldc.r4 0.8f
    IL_0077: ldc.r4 1.2f
    IL_007c: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0081: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0086: ldloc.1
    IL_0087: ldfld AudioSource LightningStriker::aSource  /*0x04000B39*/
    IL_008c: ldloc.1
    IL_008d: ldfld AudioClip LightningStriker::thunder  /*0x04000B36*/
    IL_0092: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_0097: ldarg.0
    IL_0098: ldc.r4 0f
    IL_009d: stfld float LightningStriker.<AnimateLightningStrike>d__14::<clock>5__2  /*0x04000B3F*/
    IL_00a2: br IL_013b
    IL_00a7: ldarg.0
    IL_00a8: ldarg.0
    IL_00a9: ldfld float LightningStriker.<AnimateLightningStrike>d__14::<clock>5__2  /*0x04000B3F*/
    IL_00ae: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00b3: add
    IL_00b4: stfld float LightningStriker.<AnimateLightningStrike>d__14::<clock>5__2  /*0x04000B3F*/
    IL_00b9: ldloc.1
    IL_00ba: ldfld AnimationCurve LightningStriker::intensityCurve  /*0x04000B32*/
    IL_00bf: ldc.r4 0f
    IL_00c4: ldloc.1
    IL_00c5: ldfld float LightningStriker::strikeDuration  /*0x04000B34*/
    IL_00ca: ldarg.0
    IL_00cb: ldfld float LightningStriker.<AnimateLightningStrike>d__14::<clock>5__2  /*0x04000B3F*/
    IL_00d0: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_00d5: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00da: stloc.2
    IL_00db: ldloc.1
    IL_00dc: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_00e1: ldloc.1
    IL_00e2: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_00e7: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_00ec: ldloc.1
    IL_00ed: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_00f2: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_00f7: ldloc.2
    IL_00f8: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00fd: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0102: ldloc.1
    IL_0103: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_0108: ldloc.1
    IL_0109: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_010e: callvirt float UnityEngine.Light::get_intensity()  /*0x0A0003AF*/
    IL_0113: ldloc.1
    IL_0114: ldfld float LightningStriker::maxIntensity  /*0x04000B33*/
    IL_0119: ldloc.2
    IL_011a: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_011f: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_0124: ldarg.0
    IL_0125: ldnull
    IL_0126: stfld object LightningStriker.<AnimateLightningStrike>d__14::<>2__current  /*0x04000B3D*/
    IL_012b: ldarg.0
    IL_012c: ldc.i4.1
    IL_012d: stfld int LightningStriker.<AnimateLightningStrike>d__14::<>1__state  /*0x04000B3C*/
    IL_0132: ldc.i4.1
    IL_0133: ret
    IL_0134: ldarg.0
    IL_0135: ldc.i4.m1
    IL_0136: stfld int LightningStriker.<AnimateLightningStrike>d__14::<>1__state  /*0x04000B3C*/
    IL_013b: ldarg.0
    IL_013c: ldfld float LightningStriker.<AnimateLightningStrike>d__14::<clock>5__2  /*0x04000B3F*/
    IL_0141: ldloc.1
    IL_0142: ldfld float LightningStriker::strikeDuration  /*0x04000B34*/
    IL_0147: ble IL_00a7
    IL_014c: ldloc.1
    IL_014d: ldfld Light LightningStriker::lightningLight  /*0x04000B38*/
    IL_0152: ldc.i4.0
    IL_0153: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0158: ldloc.1
    IL_0159: ldfld Light LightningStriker::mainLight  /*0x04000B37*/
    IL_015e: ldc.i4.1
    IL_015f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0164: ldloc.1
    IL_0165: call void LightningStriker::ResetTimer()  /*0x060008EB*/
    IL_016a: ldloc.1
    IL_016b: ldc.i4.0
    IL_016c: stfld bool LightningStriker::inAnimation  /*0x04000B3A*/
    IL_0171: ldc.i4.0
    IL_0172: ret

  .method LightningStriker.<AnimateLightningStrike>d__14::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060008F0 rva 0x2b023 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LightningStriker.<AnimateLightningStrike>d__14::<>2__current  /*0x04000B3D*/
    IL_0006: ret

  .method LightningStriker.<AnimateLightningStrike>d__14::System.Collections.IEnumerator.Reset()  // token 0x060008F1 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LightningStriker.<AnimateLightningStrike>d__14::System.Collections.IEnumerator.get_Current()  // token 0x060008F2 rva 0x2b023 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LightningStriker.<AnimateLightningStrike>d__14::<>2__current  /*0x04000B3D*/
    IL_0006: ret

