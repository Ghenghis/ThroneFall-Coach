// ===== ColorAndLightManager  (token 0x0200009D) =====
  .method ColorAndLightManager::get_Instance()  // token 0x06000351 rva 0xec4c attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld ColorAndLightManager ColorAndLightManager::instance  /*0x0400041B*/
    IL_0005: ret

  .method ColorAndLightManager::get_Sunlight()  // token 0x06000352 rva 0xec53 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0006: ret

  .method ColorAndLightManager::get_BonfireLight()  // token 0x06000353 rva 0xec5b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Light ColorAndLightManager::bonfireLight  /*0x0400041D*/
    IL_0006: ret

  .method ColorAndLightManager::get_CurrentColorScheme()  // token 0x06000354 rva 0xec63 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0006: ret

  .method ColorAndLightManager::get_EliteEnemyMaterial()  // token 0x06000355 rva 0xec6b attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Material ColorAndLightManager::eliteEnemyMaterial  /*0x0400044A*/
    IL_0005: ret

  .method ColorAndLightManager::OnDawn_AfterSunrise()  // token 0x06000356 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ColorAndLightManager::OnDusk()  // token 0x06000357 rva 0xec72 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator ColorAndLightManager::ToNight()  /*0x0600035D*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method ColorAndLightManager::OnDawn_BeforeSunrise()  // token 0x06000358 rva 0xec87 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator ColorAndLightManager::ToDay()  /*0x0600035C*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method ColorAndLightManager::Daylight()  // token 0x06000359 rva 0xec9c attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0006: ldarg.0
    IL_0007: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_000c: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_0011: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_001d: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0022: ldarg.0
    IL_0023: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0028: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_002d: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_0032: ret

  .method ColorAndLightManager::SunsetLight()  // token 0x0600035A rva 0xecd0 attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0006: ldarg.0
    IL_0007: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_000c: ldfld Color Colorscheme::sunsetLightColor  /*0x04000459*/
    IL_0011: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_001d: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0022: ldarg.0
    IL_0023: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0028: ldfld Color Colorscheme::sunsetLightColor  /*0x04000459*/
    IL_002d: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_0032: ret

  .method ColorAndLightManager::NightLight()  // token 0x0600035B rva 0xed04 attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0006: ldarg.0
    IL_0007: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_000c: ldfld Color Colorscheme::nightLightColor  /*0x0400045A*/
    IL_0011: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_001d: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0022: ldarg.0
    IL_0023: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0028: ldfld Color Colorscheme::nightLightColor  /*0x0400045A*/
    IL_002d: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_0032: ret

  .method ColorAndLightManager::ToDay()  // token 0x0600035C rva 0xed38 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ColorAndLightManager.<ToDay>d__66::.ctor(int)  /*0x0600036D*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ColorAndLightManager ColorAndLightManager.<ToDay>d__66::<>4__this  /*0x04000451*/
    IL_000d: ret

  .method ColorAndLightManager::ToNight()  // token 0x0600035D rva 0xed47 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void ColorAndLightManager.<ToNight>d__67::.ctor(int)  /*0x06000373*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld ColorAndLightManager ColorAndLightManager.<ToNight>d__67::<>4__this  /*0x04000456*/
    IL_000d: ret

  .method ColorAndLightManager::Awake()  // token 0x0600035E rva 0xed56 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld ColorAndLightManager ColorAndLightManager::instance  /*0x0400041B*/
    IL_0006: ret

  .method ColorAndLightManager::Start()  // token 0x0600035F rva 0xed60 attrs Private, HideBySig
    // code size 264 (0x108), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0007: stfld Colorscheme ColorAndLightManager::initialColorscheme  /*0x04000420*/
    IL_000c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0011: ldarg.0
    IL_0012: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0017: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_001c: ldc.i4.1
    IL_001d: bne.un.s IL_0058
    IL_001f: ldarg.0
    IL_0020: ldfld bool ColorAndLightManager::ignoreEternalTrials  /*0x04000445*/
    IL_0025: brtrue.s IL_0058
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_002e: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0033: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_0038: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_003d: ldc.i4.0
    IL_003e: ldarg.0
    IL_003f: ldfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_0044: callvirt int System.Collections.Generic.List<Colorscheme>::get_Count()  /*0x0A00017D*/
    IL_0049: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_004e: callvirt !0 System.Collections.Generic.List<Colorscheme>::get_Item(int)  /*0x0A00017F*/
    IL_0053: stfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0058: ldarg.0
    IL_0059: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_005e: ldarg.0
    IL_005f: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0064: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_0069: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_006e: ldarg.0
    IL_006f: ldarg.0
    IL_0070: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0075: call void ColorAndLightManager::ApplyColorScheme(Colorscheme)  /*0x06000363*/
    IL_007a: ldarg.0
    IL_007b: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_0080: ldnull
    IL_0081: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0086: brfalse.s IL_0093
    IL_0088: ldarg.0
    IL_0089: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_008e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0093: ldarg.0
    IL_0094: ldfld Transform ColorAndLightManager::playerTransform  /*0x04000423*/
    IL_0099: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009e: brfalse.s IL_00e3
    IL_00a0: ldarg.0
    IL_00a1: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_00a6: ldfld GameObject Colorscheme::particlesToAttachToPlayer  /*0x0400047F*/
    IL_00ab: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b0: brfalse.s IL_00e3
    IL_00b2: ldarg.0
    IL_00b3: ldarg.0
    IL_00b4: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_00b9: ldfld GameObject Colorscheme::particlesToAttachToPlayer  /*0x0400047F*/
    IL_00be: ldarg.0
    IL_00bf: ldfld Transform ColorAndLightManager::playerTransform  /*0x04000423*/
    IL_00c4: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_00c9: stfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_00d4: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00d9: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00de: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld Material ColorAndLightManager::enemyMaterial  /*0x04000424*/
    IL_00e9: newobj void UnityEngine.Material::.ctor(UnityEngine.Material)  /*0x0A000180*/
    IL_00ee: stsfld Material ColorAndLightManager::eliteEnemyMaterial  /*0x0400044A*/
    IL_00f3: ldsfld Material ColorAndLightManager::eliteEnemyMaterial  /*0x0400044A*/
    IL_00f8: ldstr "_OutlineColor"
    IL_00fd: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0102: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0107: ret

  .method ColorAndLightManager::Update()  // token 0x06000360 rva 0xee74 attrs Private, HideBySig
    // code size 137 (0x89), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldflda Vector2 ColorAndLightManager::riverOffset  /*0x0400044E*/
    IL_0006: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_000b: ldarg.0
    IL_000c: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_0011: ldfld float WaterSettings::riverScrollSpeed  /*0x04001810*/
    IL_0016: mul
    IL_0017: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_001c: ldarg.0
    IL_001d: ldfld Material ColorAndLightManager::waterMaterial  /*0x04000437*/
    IL_0022: ldstr "_BaseMap"
    IL_0027: ldarg.0
    IL_0028: ldfld Vector2 ColorAndLightManager::riverOffset  /*0x0400044E*/
    IL_002d: callvirt void UnityEngine.Material::SetTextureOffset(string,UnityEngine.Vector2)  /*0x0A000183*/
    IL_0032: ldarg.0
    IL_0033: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0038: ldnull
    IL_0039: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003e: brfalse.s IL_0056
    IL_0040: ldarg.0
    IL_0041: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0046: ldstr "_BaseMap"
    IL_004b: ldarg.0
    IL_004c: ldfld Vector2 ColorAndLightManager::riverOffset  /*0x0400044E*/
    IL_0051: callvirt void UnityEngine.Material::SetTextureOffset(string,UnityEngine.Vector2)  /*0x0A000183*/
    IL_0056: ldarg.0
    IL_0057: ldflda Vector2 ColorAndLightManager::oceanOffset  /*0x0400044D*/
    IL_005c: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0061: ldarg.0
    IL_0062: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_0067: ldfld float WaterSettings::oceanScrollSpeed  /*0x04001812*/
    IL_006c: mul
    IL_006d: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0072: ldarg.0
    IL_0073: ldfld Material ColorAndLightManager::oceanMaterial  /*0x04000439*/
    IL_0078: ldstr "_BaseMap"
    IL_007d: ldarg.0
    IL_007e: ldfld Vector2 ColorAndLightManager::oceanOffset  /*0x0400044D*/
    IL_0083: callvirt void UnityEngine.Material::SetTextureOffset(string,UnityEngine.Vector2)  /*0x0A000183*/
    IL_0088: ret

  .method ColorAndLightManager::ApplayColorScheme()  // token 0x06000361 rva 0xef09 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0007: call void ColorAndLightManager::ApplyColorScheme(Colorscheme)  /*0x06000363*/
    IL_000c: ret

  .method ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  // token 0x06000362 rva 0xef18 attrs Public, Static, HideBySig
    // code size 83 (0x53), max stack 4, init locals
    .locals ([0] float, [1] float, [2] float, [3] float, [4] Color)
    IL_0000: ldarg.0
    IL_0001: ldloca.s 0
    IL_0003: ldloca.s 1
    IL_0005: ldloca.s 2
    IL_0007: call void UnityEngine.Color::RGBToHSV(UnityEngine.Color,ref float,ref float,ref float)  /*0x0A000184*/
    IL_000c: ldarg.1
    IL_000d: ldc.r4 360f
    IL_0012: div
    IL_0013: stloc.3
    IL_0014: ldloc.0
    IL_0015: ldloc.3
    IL_0016: add
    IL_0017: ldc.r4 1f
    IL_001c: rem
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: ldc.r4 0f
    IL_0024: bge.un.s IL_002e
    IL_0026: ldloc.0
    IL_0027: ldc.r4 1f
    IL_002c: add
    IL_002d: stloc.0
    IL_002e: ldloc.1
    IL_002f: ldarg.2
    IL_0030: mul
    IL_0031: stloc.1
    IL_0032: ldloc.1
    IL_0033: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0038: stloc.1
    IL_0039: ldloc.0
    IL_003a: ldloc.1
    IL_003b: ldloc.2
    IL_003c: call Color UnityEngine.Color::HSVToRGB(float,float,float)  /*0x0A000186*/
    IL_0041: stloc.s 4
    IL_0043: ldloca.s 4
    IL_0045: ldarg.0
    IL_0046: ldfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_004b: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0050: ldloc.s 4
    IL_0052: ret

  .method ColorAndLightManager::ApplyColorScheme(Colorscheme)  // token 0x06000363 rva 0xef78 attrs Public, HideBySig
    // code size 1730 (0x6c2), max stack 5, init locals
    .locals ([0] Color, [1] Color, [2] Color, [3] Color, [4] Color, [5] SettingsManager.ColorBlindMode)
    IL_0000: ldarg.1
    IL_0001: ldfld Color Colorscheme::enemyLightColor  /*0x0400045D*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: ldfld Color Colorscheme::enemyMidColor  /*0x0400045E*/
    IL_000d: stloc.1
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld Color ColorAndLightManager::originalEnemyHealthBarColor  /*0x0400044B*/
    IL_0015: stfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_001a: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0024: brfalse IL_0139
    IL_0029: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_002e: callvirt SettingsManager.ColorBlindMode SettingsManager::get_ColorblindMode()  /*0x06000DB1*/
    IL_0033: stloc.s 5
    IL_0035: ldloc.s 5
    IL_0037: ldc.i4.1
    IL_0038: sub
    IL_0039: switch (IL_0053, IL_0095, IL_00d4, IL_0113)
    IL_004e: br IL_0139
    IL_0053: ldloc.0
    IL_0054: ldc.r4 64f
    IL_0059: ldc.r4 1.5f
    IL_005e: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_0063: stloc.0
    IL_0064: ldloc.1
    IL_0065: ldc.r4 64f
    IL_006a: ldc.r4 1.5f
    IL_006f: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_0074: stloc.1
    IL_0075: ldarg.0
    IL_0076: ldarg.0
    IL_0077: ldfld Color ColorAndLightManager::originalEnemyHealthBarColor  /*0x0400044B*/
    IL_007c: ldc.r4 64f
    IL_0081: ldc.r4 1.5f
    IL_0086: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_008b: stfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_0090: br IL_0139
    IL_0095: ldloc.0
    IL_0096: ldc.r4 40f
    IL_009b: ldc.r4 1.5f
    IL_00a0: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_00a5: stloc.0
    IL_00a6: ldloc.1
    IL_00a7: ldc.r4 40f
    IL_00ac: ldc.r4 1.5f
    IL_00b1: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_00b6: stloc.1
    IL_00b7: ldarg.0
    IL_00b8: ldarg.0
    IL_00b9: ldfld Color ColorAndLightManager::originalEnemyHealthBarColor  /*0x0400044B*/
    IL_00be: ldc.r4 40f
    IL_00c3: ldc.r4 1.5f
    IL_00c8: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_00cd: stfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_00d2: br.s IL_0139
    IL_00d4: ldloc.0
    IL_00d5: ldc.r4 -42f
    IL_00da: ldc.r4 1.5f
    IL_00df: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_00e4: stloc.0
    IL_00e5: ldloc.1
    IL_00e6: ldc.r4 -42f
    IL_00eb: ldc.r4 1.5f
    IL_00f0: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_00f5: stloc.1
    IL_00f6: ldarg.0
    IL_00f7: ldarg.0
    IL_00f8: ldfld Color ColorAndLightManager::originalEnemyHealthBarColor  /*0x0400044B*/
    IL_00fd: ldc.r4 -42f
    IL_0102: ldc.r4 1.5f
    IL_0107: call Color ColorAndLightManager::HueShift(UnityEngine.Color,float,float)  /*0x06000362*/
    IL_010c: stfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_0111: br.s IL_0139
    IL_0113: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0118: stloc.0
    IL_0119: call Color UnityEngine.Color::get_gray()  /*0x0A000189*/
    IL_011e: stloc.1
    IL_011f: ldarg.0
    IL_0120: ldc.r4 220f
    IL_0125: ldc.r4 220f
    IL_012a: ldc.r4 220f
    IL_012f: newobj void UnityEngine.Color::.ctor(float,float,float)  /*0x0A00018A*/
    IL_0134: stfld Color ColorAndLightManager::enemyHealthBarColor  /*0x0400044C*/
    IL_0139: ldarg.0
    IL_013a: ldarg.0
    IL_013b: ldfld Material ColorAndLightManager::enemyMaterial  /*0x04000424*/
    IL_0140: ldloc.0
    IL_0141: ldloc.1
    IL_0142: ldarg.1
    IL_0143: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0148: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_014d: ldarg.0
    IL_014e: ldarg.0
    IL_014f: ldfld Material ColorAndLightManager::allyMaterial  /*0x04000425*/
    IL_0154: ldarg.1
    IL_0155: ldfld Color Colorscheme::allyLightColor  /*0x0400045F*/
    IL_015a: ldarg.1
    IL_015b: ldfld Color Colorscheme::allyMidColor  /*0x04000460*/
    IL_0160: ldarg.1
    IL_0161: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0166: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_016b: ldarg.0
    IL_016c: ldarg.0
    IL_016d: ldfld Material ColorAndLightManager::allyRangedMaterial  /*0x04000426*/
    IL_0172: ldarg.1
    IL_0173: ldfld Color Colorscheme::allyRangedLightColor  /*0x04000461*/
    IL_0178: ldarg.1
    IL_0179: ldfld Color Colorscheme::allyRangedMidColor  /*0x04000462*/
    IL_017e: ldarg.1
    IL_017f: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0184: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0189: ldarg.0
    IL_018a: ldarg.0
    IL_018b: ldfld Material ColorAndLightManager::playerMaterial  /*0x04000427*/
    IL_0190: ldarg.1
    IL_0191: ldfld Color Colorscheme::playerLightColor  /*0x04000465*/
    IL_0196: ldarg.1
    IL_0197: ldfld Color Colorscheme::playerMidColor  /*0x04000466*/
    IL_019c: ldarg.1
    IL_019d: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_01a2: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_01a7: ldarg.0
    IL_01a8: ldarg.0
    IL_01a9: ldfld Material ColorAndLightManager::playerCapeMaterial  /*0x04000428*/
    IL_01ae: ldarg.1
    IL_01af: ldfld Color Colorscheme::playerCapeLightColor  /*0x04000467*/
    IL_01b4: ldarg.1
    IL_01b5: ldfld Color Colorscheme::playerCapeMidColor  /*0x04000468*/
    IL_01ba: ldarg.1
    IL_01bb: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_01c0: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_01c5: ldarg.0
    IL_01c6: ldarg.0
    IL_01c7: ldfld Material ColorAndLightManager::playerCrownMaterial  /*0x04000429*/
    IL_01cc: ldarg.1
    IL_01cd: ldfld Color Colorscheme::playerCrownLightColor  /*0x04000469*/
    IL_01d2: ldarg.1
    IL_01d3: ldfld Color Colorscheme::playerCrownMidColor  /*0x0400046A*/
    IL_01d8: ldarg.1
    IL_01d9: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_01de: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_01e3: ldarg.0
    IL_01e4: ldarg.0
    IL_01e5: ldfld Material ColorAndLightManager::horseMaterial  /*0x0400042A*/
    IL_01ea: ldarg.1
    IL_01eb: ldfld Color Colorscheme::horseLightColor  /*0x0400046B*/
    IL_01f0: ldarg.1
    IL_01f1: ldfld Color Colorscheme::horseMidColor  /*0x0400046C*/
    IL_01f6: ldarg.1
    IL_01f7: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_01fc: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0201: ldarg.0
    IL_0202: ldarg.0
    IL_0203: ldfld Material ColorAndLightManager::buildingMaterial  /*0x0400042B*/
    IL_0208: ldarg.1
    IL_0209: ldfld Color Colorscheme::buildingLightColor  /*0x0400046D*/
    IL_020e: ldarg.1
    IL_020f: ldfld Color Colorscheme::buildingMidColor  /*0x0400046E*/
    IL_0214: ldarg.1
    IL_0215: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_021a: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_021f: ldarg.0
    IL_0220: ldarg.0
    IL_0221: ldfld Material ColorAndLightManager::buildingMaterialShadow  /*0x0400042C*/
    IL_0226: ldarg.1
    IL_0227: ldfld Color Colorscheme::buildingLightColor  /*0x0400046D*/
    IL_022c: ldarg.1
    IL_022d: ldfld Color Colorscheme::buildingMidColor  /*0x0400046E*/
    IL_0232: ldarg.1
    IL_0233: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0238: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_023d: ldloca.s 2
    IL_023f: ldarg.1
    IL_0240: ldflda Color Colorscheme::buildingLightColor  /*0x0400046D*/
    IL_0245: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_024a: ldarg.1
    IL_024b: ldflda Color Colorscheme::buildingLightColor  /*0x0400046D*/
    IL_0250: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_0255: ldarg.1
    IL_0256: ldflda Color Colorscheme::buildingLightColor  /*0x0400046D*/
    IL_025b: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_0260: ldc.r4 0.15f
    IL_0265: call void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A00018E*/
    IL_026a: ldloca.s 3
    IL_026c: ldarg.1
    IL_026d: ldflda Color Colorscheme::buildingMidColor  /*0x0400046E*/
    IL_0272: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_0277: ldarg.1
    IL_0278: ldflda Color Colorscheme::buildingMidColor  /*0x0400046E*/
    IL_027d: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_0282: ldarg.1
    IL_0283: ldflda Color Colorscheme::buildingMidColor  /*0x0400046E*/
    IL_0288: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_028d: ldc.r4 0.15f
    IL_0292: call void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A00018E*/
    IL_0297: ldloca.s 4
    IL_0299: ldarg.1
    IL_029a: ldflda Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_029f: ldfld float UnityEngine.Color::r  /*0x0A00018B*/
    IL_02a4: ldarg.1
    IL_02a5: ldflda Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_02aa: ldfld float UnityEngine.Color::g  /*0x0A00018C*/
    IL_02af: ldarg.1
    IL_02b0: ldflda Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_02b5: ldfld float UnityEngine.Color::b  /*0x0A00018D*/
    IL_02ba: ldc.r4 0.15f
    IL_02bf: call void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A00018E*/
    IL_02c4: ldarg.0
    IL_02c5: ldarg.0
    IL_02c6: ldfld Material ColorAndLightManager::buildingPreviewMaterial  /*0x0400042D*/
    IL_02cb: ldloc.2
    IL_02cc: ldloc.3
    IL_02cd: ldloc.s 4
    IL_02cf: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_02d4: ldarg.0
    IL_02d5: ldarg.0
    IL_02d6: ldfld Material ColorAndLightManager::coinMaterial  /*0x0400042E*/
    IL_02db: ldarg.1
    IL_02dc: ldfld Color Colorscheme::coinLightColor  /*0x0400046F*/
    IL_02e1: ldarg.1
    IL_02e2: ldfld Color Colorscheme::coinMidColor  /*0x04000470*/
    IL_02e7: ldarg.1
    IL_02e8: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_02ed: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_02f2: ldarg.0
    IL_02f3: ldarg.0
    IL_02f4: ldfld Material ColorAndLightManager::groundMaterial  /*0x0400042F*/
    IL_02f9: ldarg.1
    IL_02fa: ldfld Color Colorscheme::groundColor  /*0x04000471*/
    IL_02ff: ldarg.1
    IL_0300: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0305: ldarg.1
    IL_0306: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_030b: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0310: ldarg.0
    IL_0311: ldarg.0
    IL_0312: ldfld Material ColorAndLightManager::groundPatches  /*0x04000434*/
    IL_0317: ldarg.1
    IL_0318: ldfld Color Colorscheme::groundColorLow  /*0x04000473*/
    IL_031d: ldarg.1
    IL_031e: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0323: ldarg.1
    IL_0324: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0329: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_032e: ldarg.0
    IL_032f: ldarg.0
    IL_0330: ldfld Material ColorAndLightManager::groundHigh  /*0x04000430*/
    IL_0335: ldarg.1
    IL_0336: ldfld Color Colorscheme::groundColorHigh  /*0x04000472*/
    IL_033b: ldarg.1
    IL_033c: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0341: ldarg.1
    IL_0342: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0347: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_034c: ldarg.0
    IL_034d: ldarg.0
    IL_034e: ldfld Material ColorAndLightManager::groundLow  /*0x04000431*/
    IL_0353: ldarg.1
    IL_0354: ldfld Color Colorscheme::groundColorLow  /*0x04000473*/
    IL_0359: ldarg.1
    IL_035a: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_035f: ldarg.1
    IL_0360: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0365: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_036a: ldarg.0
    IL_036b: ldarg.0
    IL_036c: ldfld Material ColorAndLightManager::earthMaterial  /*0x04000432*/
    IL_0371: ldarg.1
    IL_0372: ldfld Color Colorscheme::earthLightColor  /*0x04000474*/
    IL_0377: ldarg.1
    IL_0378: ldfld Color Colorscheme::earthMidColor  /*0x04000475*/
    IL_037d: ldarg.1
    IL_037e: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0383: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0388: ldarg.0
    IL_0389: ldarg.0
    IL_038a: ldfld Material ColorAndLightManager::sandMaterial  /*0x04000433*/
    IL_038f: ldarg.1
    IL_0390: ldfld Color Colorscheme::sandColor  /*0x04000476*/
    IL_0395: ldarg.1
    IL_0396: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_039b: ldarg.1
    IL_039c: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_03a1: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_03a6: ldarg.0
    IL_03a7: ldarg.0
    IL_03a8: ldfld Material ColorAndLightManager::treeMaterial  /*0x04000435*/
    IL_03ad: ldarg.1
    IL_03ae: ldfld Color Colorscheme::treeLightColor  /*0x04000477*/
    IL_03b3: ldarg.1
    IL_03b4: ldfld Color Colorscheme::treeMidColor  /*0x04000478*/
    IL_03b9: ldarg.1
    IL_03ba: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_03bf: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_03c4: ldarg.0
    IL_03c5: ldarg.0
    IL_03c6: ldfld Material ColorAndLightManager::rockMaterial  /*0x04000436*/
    IL_03cb: ldarg.1
    IL_03cc: ldfld Color Colorscheme::rockLightColor  /*0x04000479*/
    IL_03d1: ldarg.1
    IL_03d2: ldfld Color Colorscheme::rockMidColor  /*0x0400047A*/
    IL_03d7: ldarg.1
    IL_03d8: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_03dd: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_03e2: ldarg.0
    IL_03e3: ldarg.0
    IL_03e4: ldfld Material ColorAndLightManager::waterMaterial  /*0x04000437*/
    IL_03e9: ldarg.1
    IL_03ea: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_03ef: ldarg.1
    IL_03f0: ldfld Color Colorscheme::waterSecondaryColor  /*0x0400047C*/
    IL_03f5: ldarg.1
    IL_03f6: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_03fb: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0400: ldarg.0
    IL_0401: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0406: ldnull
    IL_0407: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_040c: brfalse.s IL_0442
    IL_040e: ldarg.0
    IL_040f: ldarg.0
    IL_0410: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0415: ldarg.1
    IL_0416: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_041b: ldarg.1
    IL_041c: ldfld Color Colorscheme::waterSecondaryColor  /*0x0400047C*/
    IL_0421: ldarg.1
    IL_0422: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0427: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_042c: ldarg.0
    IL_042d: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0432: ldstr "_FlatSpecularColor"
    IL_0437: ldarg.1
    IL_0438: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_043d: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0442: ldarg.0
    IL_0443: ldarg.0
    IL_0444: ldfld Material ColorAndLightManager::oceanMaterial  /*0x04000439*/
    IL_0449: ldarg.1
    IL_044a: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_044f: ldarg.1
    IL_0450: ldfld Color Colorscheme::waterSecondaryColor  /*0x0400047C*/
    IL_0455: ldarg.1
    IL_0456: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_045b: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_0460: ldarg.0
    IL_0461: ldarg.0
    IL_0462: ldfld Material ColorAndLightManager::roadMaterial  /*0x0400043A*/
    IL_0467: ldarg.1
    IL_0468: ldfld Color Colorscheme::roadColor  /*0x0400047D*/
    IL_046d: ldarg.1
    IL_046e: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0473: ldarg.1
    IL_0474: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0479: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_047e: ldarg.0
    IL_047f: ldarg.0
    IL_0480: ldfld Material ColorAndLightManager::shadowShapeMaterial  /*0x0400043B*/
    IL_0485: ldarg.1
    IL_0486: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_048b: ldarg.1
    IL_048c: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0491: ldarg.1
    IL_0492: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0497: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_049c: ldarg.0
    IL_049d: ldarg.0
    IL_049e: ldfld Material ColorAndLightManager::dmgFlashMaterial  /*0x0400043C*/
    IL_04a3: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_04a8: ldarg.1
    IL_04a9: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_04ae: ldarg.1
    IL_04af: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_04b4: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_04b9: ldarg.0
    IL_04ba: ldarg.0
    IL_04bb: ldfld Material ColorAndLightManager::treasureChestMaterial  /*0x0400043D*/
    IL_04c0: ldarg.0
    IL_04c1: ldfld Material ColorAndLightManager::treasureChestMaterial  /*0x0400043D*/
    IL_04c6: ldstr "_BaseColor"
    IL_04cb: callvirt Color UnityEngine.Material::GetColor(string)  /*0x0A00018F*/
    IL_04d0: ldarg.0
    IL_04d1: ldfld Material ColorAndLightManager::treasureChestMaterial  /*0x0400043D*/
    IL_04d6: ldstr "_ColorDim"
    IL_04db: callvirt Color UnityEngine.Material::GetColor(string)  /*0x0A00018F*/
    IL_04e0: ldarg.1
    IL_04e1: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_04e6: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_04eb: ldarg.0
    IL_04ec: ldarg.0
    IL_04ed: ldfld Material ColorAndLightManager::treasureChestAccentMaterial  /*0x0400043E*/
    IL_04f2: ldarg.0
    IL_04f3: ldfld Material ColorAndLightManager::treasureChestAccentMaterial  /*0x0400043E*/
    IL_04f8: ldstr "_BaseColor"
    IL_04fd: callvirt Color UnityEngine.Material::GetColor(string)  /*0x0A00018F*/
    IL_0502: ldarg.0
    IL_0503: ldfld Material ColorAndLightManager::treasureChestAccentMaterial  /*0x0400043E*/
    IL_0508: ldstr "_ColorDim"
    IL_050d: callvirt Color UnityEngine.Material::GetColor(string)  /*0x0A00018F*/
    IL_0512: ldarg.1
    IL_0513: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0518: call void ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  /*0x06000364*/
    IL_051d: ldarg.0
    IL_051e: ldfld Material ColorAndLightManager::buildIndicatorBuiltAllMaterial  /*0x0400043F*/
    IL_0523: ldnull
    IL_0524: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0529: brfalse.s IL_0557
    IL_052b: ldarg.0
    IL_052c: ldfld Material ColorAndLightManager::buildIndicatorBuiltAllMaterial  /*0x0400043F*/
    IL_0531: ldstr "_Main_Color"
    IL_0536: ldarg.1
    IL_0537: ldfld Color Colorscheme::RangeIndicatorBuiltLightColor  /*0x04000483*/
    IL_053c: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0541: ldarg.0
    IL_0542: ldfld Material ColorAndLightManager::buildIndicatorBuiltAllMaterial  /*0x0400043F*/
    IL_0547: ldstr "_Shadow_Color"
    IL_054c: ldarg.1
    IL_054d: ldfld Color Colorscheme::RangeIndicatorBuiltMidColor  /*0x04000484*/
    IL_0552: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0557: ldarg.0
    IL_0558: ldfld Material ColorAndLightManager::buildIndicatorPreviewAllMaterial  /*0x04000440*/
    IL_055d: ldnull
    IL_055e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0563: brfalse.s IL_0591
    IL_0565: ldarg.0
    IL_0566: ldfld Material ColorAndLightManager::buildIndicatorPreviewAllMaterial  /*0x04000440*/
    IL_056b: ldstr "_Main_Color"
    IL_0570: ldarg.1
    IL_0571: ldfld Color Colorscheme::RangeIndicatorPreviewLightColor  /*0x04000480*/
    IL_0576: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_057b: ldarg.0
    IL_057c: ldfld Material ColorAndLightManager::buildIndicatorPreviewAllMaterial  /*0x04000440*/
    IL_0581: ldstr "_Shadow_Color"
    IL_0586: ldarg.1
    IL_0587: ldfld Color Colorscheme::RangeIndicatorPreviewMidColor  /*0x04000481*/
    IL_058c: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0591: ldarg.0
    IL_0592: ldfld Material ColorAndLightManager::buildIndicatorPreviewBaseMaterial  /*0x04000441*/
    IL_0597: ldnull
    IL_0598: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_059d: brfalse.s IL_05b5
    IL_059f: ldarg.0
    IL_05a0: ldfld Material ColorAndLightManager::buildIndicatorPreviewBaseMaterial  /*0x04000441*/
    IL_05a5: ldstr "_BaseColor"
    IL_05aa: ldarg.1
    IL_05ab: ldfld Color Colorscheme::RangeIndicatorPreviewBaseColor  /*0x04000482*/
    IL_05b0: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_05b5: ldarg.0
    IL_05b6: ldfld Material ColorAndLightManager::Group1Material  /*0x04000442*/
    IL_05bb: ldnull
    IL_05bc: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_05c1: brfalse.s IL_05d9
    IL_05c3: ldarg.0
    IL_05c4: ldfld Material ColorAndLightManager::Group1Material  /*0x04000442*/
    IL_05c9: ldstr "_Color"
    IL_05ce: ldarg.1
    IL_05cf: ldfld Color Colorscheme::Group1Color  /*0x04000485*/
    IL_05d4: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_05d9: ldarg.0
    IL_05da: ldfld Material ColorAndLightManager::Group2Material  /*0x04000443*/
    IL_05df: ldnull
    IL_05e0: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_05e5: brfalse.s IL_05fd
    IL_05e7: ldarg.0
    IL_05e8: ldfld Material ColorAndLightManager::Group2Material  /*0x04000443*/
    IL_05ed: ldstr "_Color"
    IL_05f2: ldarg.1
    IL_05f3: ldfld Color Colorscheme::Group2Color  /*0x04000486*/
    IL_05f8: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_05fd: ldarg.0
    IL_05fe: ldfld Material ColorAndLightManager::Group3Material  /*0x04000444*/
    IL_0603: ldnull
    IL_0604: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0609: brfalse.s IL_0621
    IL_060b: ldarg.0
    IL_060c: ldfld Material ColorAndLightManager::Group3Material  /*0x04000444*/
    IL_0611: ldstr "_Color"
    IL_0616: ldarg.1
    IL_0617: ldfld Color Colorscheme::Group3Color  /*0x04000487*/
    IL_061c: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0621: ldarg.0
    IL_0622: ldfld Material ColorAndLightManager::waterMaterial  /*0x04000437*/
    IL_0627: ldstr "_BaseMap"
    IL_062c: ldarg.0
    IL_062d: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_0632: ldfld Vector2 WaterSettings::riverTextureTiling  /*0x04001811*/
    IL_0637: callvirt void UnityEngine.Material::SetTextureScale(string,UnityEngine.Vector2)  /*0x0A000190*/
    IL_063c: ldarg.0
    IL_063d: ldfld Material ColorAndLightManager::waterMaterial  /*0x04000437*/
    IL_0642: ldstr "_SelfShadingSize"
    IL_0647: ldarg.0
    IL_0648: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_064d: ldfld float WaterSettings::selfShadingSize  /*0x04001814*/
    IL_0652: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_0657: ldarg.0
    IL_0658: ldfld Material ColorAndLightManager::oceanMaterial  /*0x04000439*/
    IL_065d: ldstr "_BaseMap"
    IL_0662: ldarg.0
    IL_0663: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_0668: ldfld Vector2 WaterSettings::oceanTextureTiling  /*0x04001813*/
    IL_066d: callvirt void UnityEngine.Material::SetTextureScale(string,UnityEngine.Vector2)  /*0x0A000190*/
    IL_0672: ldarg.0
    IL_0673: ldfld Material ColorAndLightManager::oceanMaterial  /*0x04000439*/
    IL_0678: ldstr "_SelfShadingSize"
    IL_067d: ldarg.0
    IL_067e: ldfld WaterSettings ColorAndLightManager::waterSettings  /*0x04000421*/
    IL_0683: ldfld float WaterSettings::oceanSelfShadingSize  /*0x04001815*/
    IL_0688: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_068d: ldarg.0
    IL_068e: ldfld Light ColorAndLightManager::bonfireLight  /*0x0400041D*/
    IL_0693: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0698: brfalse.s IL_06ab
    IL_069a: ldarg.0
    IL_069b: ldfld Light ColorAndLightManager::bonfireLight  /*0x0400041D*/
    IL_06a0: ldarg.1
    IL_06a1: ldfld Color Colorscheme::bonfireLightColor  /*0x0400045C*/
    IL_06a6: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_06ab: ldarg.1
    IL_06ac: stsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_06b1: ldarg.0
    IL_06b2: ldfld UnityEvent ColorAndLightManager::OnColorChange  /*0x04000449*/
    IL_06b7: dup
    IL_06b8: brtrue.s IL_06bc
    IL_06ba: pop
    IL_06bb: ret
    IL_06bc: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_06c1: ret

  .method ColorAndLightManager::SetMaterialColors(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color,UnityEngine.Color)  // token 0x06000364 rva 0xf648 attrs Private, HideBySig
    // code size 64 (0x40), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldstr "_BaseColor"
    IL_0006: ldarg.2
    IL_0007: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_000c: ldarg.1
    IL_000d: ldstr "_ColorDim"
    IL_0012: ldarg.3
    IL_0013: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0018: ldarg.1
    IL_0019: ldstr "_ColorDimExtra"
    IL_001e: ldarg.s 4
    IL_0020: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0025: ldarg.1
    IL_0026: ldstr "_UnityShadowColor"
    IL_002b: ldarg.s 4
    IL_002d: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0032: ldarg.1
    IL_0033: ldstr "_OutlineColor"
    IL_0038: ldarg.s 4
    IL_003a: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_003f: ret

  .method ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  // token 0x06000365 rva 0xf694 attrs Public, HideBySig
    // code size 367 (0x16f), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Material ColorAndLightManager::enemyMaterial  /*0x04000424*/
    IL_0007: ldarg.1
    IL_0008: ldarg.2
    IL_0009: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld Material ColorAndLightManager::allyMaterial  /*0x04000425*/
    IL_0015: ldarg.1
    IL_0016: ldarg.2
    IL_0017: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld Material ColorAndLightManager::allyRangedMaterial  /*0x04000426*/
    IL_0023: ldarg.1
    IL_0024: ldarg.2
    IL_0025: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_002a: ldarg.0
    IL_002b: ldarg.0
    IL_002c: ldfld Material ColorAndLightManager::playerMaterial  /*0x04000427*/
    IL_0031: ldarg.1
    IL_0032: ldarg.2
    IL_0033: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0038: ldarg.0
    IL_0039: ldarg.0
    IL_003a: ldfld Material ColorAndLightManager::playerCapeMaterial  /*0x04000428*/
    IL_003f: ldarg.1
    IL_0040: ldarg.2
    IL_0041: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0046: ldarg.0
    IL_0047: ldarg.0
    IL_0048: ldfld Material ColorAndLightManager::playerCrownMaterial  /*0x04000429*/
    IL_004d: ldarg.1
    IL_004e: ldarg.2
    IL_004f: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0054: ldarg.0
    IL_0055: ldarg.0
    IL_0056: ldfld Material ColorAndLightManager::horseMaterial  /*0x0400042A*/
    IL_005b: ldarg.1
    IL_005c: ldarg.2
    IL_005d: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0062: ldarg.0
    IL_0063: ldarg.0
    IL_0064: ldfld Material ColorAndLightManager::buildingMaterial  /*0x0400042B*/
    IL_0069: ldarg.1
    IL_006a: ldarg.2
    IL_006b: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldfld Material ColorAndLightManager::buildingMaterialShadow  /*0x0400042C*/
    IL_0077: ldarg.1
    IL_0078: ldarg.2
    IL_0079: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_007e: ldarg.0
    IL_007f: ldarg.0
    IL_0080: ldfld Material ColorAndLightManager::coinMaterial  /*0x0400042E*/
    IL_0085: ldarg.1
    IL_0086: ldarg.2
    IL_0087: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_008c: ldarg.0
    IL_008d: ldarg.0
    IL_008e: ldfld Material ColorAndLightManager::groundMaterial  /*0x0400042F*/
    IL_0093: ldarg.1
    IL_0094: ldarg.2
    IL_0095: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_009a: ldarg.0
    IL_009b: ldarg.0
    IL_009c: ldfld Material ColorAndLightManager::earthMaterial  /*0x04000432*/
    IL_00a1: ldarg.1
    IL_00a2: ldarg.2
    IL_00a3: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00a8: ldarg.0
    IL_00a9: ldarg.0
    IL_00aa: ldfld Material ColorAndLightManager::groundLow  /*0x04000431*/
    IL_00af: ldarg.1
    IL_00b0: ldarg.2
    IL_00b1: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00b6: ldarg.0
    IL_00b7: ldarg.0
    IL_00b8: ldfld Material ColorAndLightManager::groundHigh  /*0x04000430*/
    IL_00bd: ldarg.1
    IL_00be: ldarg.2
    IL_00bf: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00c4: ldarg.0
    IL_00c5: ldarg.0
    IL_00c6: ldfld Material ColorAndLightManager::sandMaterial  /*0x04000433*/
    IL_00cb: ldarg.1
    IL_00cc: ldarg.2
    IL_00cd: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00d2: ldarg.0
    IL_00d3: ldarg.0
    IL_00d4: ldfld Material ColorAndLightManager::groundPatches  /*0x04000434*/
    IL_00d9: ldarg.1
    IL_00da: ldarg.2
    IL_00db: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00e0: ldarg.0
    IL_00e1: ldarg.0
    IL_00e2: ldfld Material ColorAndLightManager::treeMaterial  /*0x04000435*/
    IL_00e7: ldarg.1
    IL_00e8: ldarg.2
    IL_00e9: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00ee: ldarg.0
    IL_00ef: ldarg.0
    IL_00f0: ldfld Material ColorAndLightManager::rockMaterial  /*0x04000436*/
    IL_00f5: ldarg.1
    IL_00f6: ldarg.2
    IL_00f7: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_00fc: ldarg.0
    IL_00fd: ldarg.0
    IL_00fe: ldfld Material ColorAndLightManager::waterMaterial  /*0x04000437*/
    IL_0103: ldarg.1
    IL_0104: ldarg.2
    IL_0105: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_010a: ldarg.0
    IL_010b: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_0110: ldnull
    IL_0111: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0116: brfalse.s IL_0126
    IL_0118: ldarg.0
    IL_0119: ldarg.0
    IL_011a: ldfld Material ColorAndLightManager::waterfallMaterial  /*0x04000438*/
    IL_011f: ldarg.1
    IL_0120: ldarg.2
    IL_0121: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0126: ldarg.0
    IL_0127: ldarg.0
    IL_0128: ldfld Material ColorAndLightManager::oceanMaterial  /*0x04000439*/
    IL_012d: ldarg.1
    IL_012e: ldarg.2
    IL_012f: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0134: ldarg.0
    IL_0135: ldarg.0
    IL_0136: ldfld Material ColorAndLightManager::dmgFlashMaterial  /*0x0400043C*/
    IL_013b: ldarg.1
    IL_013c: ldarg.2
    IL_013d: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0142: ldarg.0
    IL_0143: ldarg.0
    IL_0144: ldfld Material ColorAndLightManager::treasureChestMaterial  /*0x0400043D*/
    IL_0149: ldarg.1
    IL_014a: ldarg.2
    IL_014b: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_0150: ldarg.0
    IL_0151: ldarg.0
    IL_0152: ldfld Material ColorAndLightManager::treasureChestAccentMaterial  /*0x0400043E*/
    IL_0157: ldarg.1
    IL_0158: ldarg.2
    IL_0159: call void ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  /*0x06000366*/
    IL_015e: ldarg.0
    IL_015f: ldfld UnityEvent ColorAndLightManager::OnColorChange  /*0x04000449*/
    IL_0164: dup
    IL_0165: brtrue.s IL_0169
    IL_0167: pop
    IL_0168: ret
    IL_0169: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_016e: ret

  .method ColorAndLightManager::SetOutlineColorBasedOnLight(UnityEngine.Material,UnityEngine.Color,UnityEngine.Color)  // token 0x06000366 rva 0xf810 attrs Private, HideBySig
    // code size 38 (0x26), max stack 4, init locals
    .locals ([0] Color)
    IL_0000: ldarg.2
    IL_0001: ldarg.2
    IL_0002: ldarg.3
    IL_0003: call Color UnityEngine.Color::op_Multiply(UnityEngine.Color,UnityEngine.Color)  /*0x0A000192*/
    IL_0008: ldarg.1
    IL_0009: ldstr "_LightContribution"
    IL_000e: callvirt float UnityEngine.Material::GetFloat(string)  /*0x0A000193*/
    IL_0013: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0018: stloc.0
    IL_0019: ldarg.1
    IL_001a: ldstr "_OutlineColor"
    IL_001f: ldloc.0
    IL_0020: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0025: ret

  .method ColorAndLightManager::OnDuskEarly()  // token 0x06000367 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ColorAndLightManager::EasyReloadColorScheme()  // token 0x06000368 rva 0xf842 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0007: call void ColorAndLightManager::EasySwitchEntireColorSchemeTo(Colorscheme)  /*0x06000369*/
    IL_000c: ret

  .method ColorAndLightManager::EasySwitchEntireColorSchemeTo(Colorscheme)  // token 0x06000369 rva 0xf850 attrs Public, HideBySig
    // code size 230 (0xe6), max stack 3, init locals
    .locals ([0] Healthbar[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: call void ColorAndLightManager::ApplyColorScheme(Colorscheme)  /*0x06000363*/
    IL_000e: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0013: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0018: brtrue.s IL_0022
    IL_001a: ldarg.0
    IL_001b: call void ColorAndLightManager::Daylight()  /*0x06000359*/
    IL_0020: br.s IL_0028
    IL_0022: ldarg.0
    IL_0023: call void ColorAndLightManager::NightLight()  /*0x0600035B*/
    IL_0028: ldarg.0
    IL_0029: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_002e: ldnull
    IL_002f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0034: brfalse.s IL_0041
    IL_0036: ldarg.0
    IL_0037: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_003c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0041: ldarg.0
    IL_0042: ldfld Transform ColorAndLightManager::playerTransform  /*0x04000423*/
    IL_0047: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_004c: brfalse.s IL_0091
    IL_004e: ldarg.0
    IL_004f: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0054: ldfld GameObject Colorscheme::particlesToAttachToPlayer  /*0x0400047F*/
    IL_0059: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_005e: brfalse.s IL_0091
    IL_0060: ldarg.0
    IL_0061: ldarg.0
    IL_0062: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0067: ldfld GameObject Colorscheme::particlesToAttachToPlayer  /*0x0400047F*/
    IL_006c: ldarg.0
    IL_006d: ldfld Transform ColorAndLightManager::playerTransform  /*0x04000423*/
    IL_0072: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0077: stfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_007c: ldarg.0
    IL_007d: ldfld GameObject ColorAndLightManager::playerCameraParticles  /*0x04000447*/
    IL_0082: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0087: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_008c: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0091: ldarg.0
    IL_0092: ldfld Material ColorAndLightManager::enemyMaterial  /*0x04000424*/
    IL_0097: newobj void UnityEngine.Material::.ctor(UnityEngine.Material)  /*0x0A000180*/
    IL_009c: stsfld Material ColorAndLightManager::eliteEnemyMaterial  /*0x0400044A*/
    IL_00a1: ldsfld Material ColorAndLightManager::eliteEnemyMaterial  /*0x0400044A*/
    IL_00a6: ldstr "_OutlineColor"
    IL_00ab: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_00b0: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_00b5: ldsfld MinimapRenderer MinimapRenderer::instance  /*0x04000D34*/
    IL_00ba: callvirt void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_00bf: ldsfld MinimapRenderer MinimapRenderer::instance  /*0x04000D34*/
    IL_00c4: callvirt void MinimapRenderer::Start()  /*0x06000A73*/
    IL_00c9: call !!0[] UnityEngine.Object::FindObjectsOfType()<Healthbar>  /*0x2B00002A*/
    IL_00ce: stloc.0
    IL_00cf: ldc.i4.0
    IL_00d0: stloc.1
    IL_00d1: br.s IL_00df
    IL_00d3: ldloc.0
    IL_00d4: ldloc.1
    IL_00d5: ldelem.ref
    IL_00d6: callvirt void Healthbar::UpdateColor()  /*0x06000802*/
    IL_00db: ldloc.1
    IL_00dc: ldc.i4.1
    IL_00dd: add
    IL_00de: stloc.1
    IL_00df: ldloc.1
    IL_00e0: ldloc.0
    IL_00e1: ldlen
    IL_00e2: conv.i4
    IL_00e3: blt.s IL_00d3
    IL_00e5: ret

  .method ColorAndLightManager::CycleToNextColorscheme()  // token 0x0600036A rva 0xf944 attrs Public, HideBySig
    // code size 108 (0x6c), max stack 3, init locals
    .locals ([0] int, [1] int, [2] List.Enumerator<Colorscheme>)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: ldarg.0
    IL_0005: ldfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_000a: callvirt List.Enumerator<!0> System.Collections.Generic.List<Colorscheme>::GetEnumerator()  /*0x0A000195*/
    IL_000f: stloc.2
    IL_0010: br.s IL_002c
    IL_0012: ldloca.s 2
    IL_0014: call !0 System.Collections.Generic.List.Enumerator<Colorscheme>::get_Current()  /*0x0A000196*/
    IL_0019: ldarg.0
    IL_001a: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_001f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0024: brfalse.s IL_0028
    IL_0026: ldloc.1
    IL_0027: stloc.0
    IL_0028: ldloc.1
    IL_0029: ldc.i4.1
    IL_002a: add
    IL_002b: stloc.1
    IL_002c: ldloca.s 2
    IL_002e: call bool System.Collections.Generic.List.Enumerator<Colorscheme>::MoveNext()  /*0x0A000197*/
    IL_0033: brtrue.s IL_0012
    IL_0035: leave.s IL_0045
    IL_0037: ldloca.s 2
    IL_0039: constrained. System.Collections.Generic.List.Enumerator<Colorscheme>  /*0x1B000033*/
    IL_003f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0044: endfinally
    IL_0045: ldloc.0
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.0
    IL_0049: ldloc.0
    IL_004a: ldarg.0
    IL_004b: ldfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_0050: callvirt int System.Collections.Generic.List<Colorscheme>::get_Count()  /*0x0A00017D*/
    IL_0055: blt.s IL_0059
    IL_0057: ldc.i4.0
    IL_0058: stloc.0
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: ldfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_0060: ldloc.0
    IL_0061: callvirt !0 System.Collections.Generic.List<Colorscheme>::get_Item(int)  /*0x0A00017F*/
    IL_0066: call void ColorAndLightManager::EasySwitchEntireColorSchemeTo(Colorscheme)  /*0x06000369*/
    IL_006b: ret
    .try IL_0010-IL_0037 finally handler IL_0037-IL_0045

  .method ColorAndLightManager::RegisterBonfireLight(UnityEngine.Light)  // token 0x0600036B rva 0xf9cc attrs Public, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Light ColorAndLightManager::bonfireLight  /*0x0400041D*/
    IL_0007: ldarg.0
    IL_0008: ldfld Light ColorAndLightManager::bonfireLight  /*0x0400041D*/
    IL_000d: ldsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_0012: ldfld Color Colorscheme::bonfireLightColor  /*0x0400045C*/
    IL_0017: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_001c: ret

  .method ColorAndLightManager::.ctor()  // token 0x0600036C rva 0xf9ea attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Colorscheme>::.ctor()  /*0x0A000198*/
    IL_0011: stfld List<Colorscheme> ColorAndLightManager::eternalTrialColorschemes  /*0x04000446*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent ColorAndLightManager::OnColorChange  /*0x04000449*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== ColorAndLightManager/<ToDay>d__66  (token 0x0200009E) =====
  .method ColorAndLightManager.<ToDay>d__66::.ctor(int)  // token 0x0600036D rva 0xfa13 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_000d: ret

  .method ColorAndLightManager.<ToDay>d__66::System.IDisposable.Dispose()  // token 0x0600036E rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ColorAndLightManager.<ToDay>d__66::MoveNext()  // token 0x0600036F rva 0xfa24 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 405 (0x195), max stack 5, init locals
    .locals ([0] int, [1] ColorAndLightManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ColorAndLightManager ColorAndLightManager.<ToDay>d__66::<>4__this  /*0x04000451*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_00b3, IL_0149)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_0029: ldarg.0
    IL_002a: ldc.r4 0f
    IL_002f: stfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_0034: ldarg.0
    IL_0035: ldloc.1
    IL_0036: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_003b: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_0040: stfld Color ColorAndLightManager.<ToDay>d__66::<currentColor>5__3  /*0x04000453*/
    IL_0045: br.s IL_00ba
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_004e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0053: add
    IL_0054: stfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_0059: ldloc.1
    IL_005a: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_005f: ldarg.0
    IL_0060: ldfld Color ColorAndLightManager.<ToDay>d__66::<currentColor>5__3  /*0x04000453*/
    IL_0065: ldloc.1
    IL_0066: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_006b: ldfld Color Colorscheme::sunsetLightColor  /*0x04000459*/
    IL_0070: ldarg.0
    IL_0071: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_0076: ldloc.1
    IL_0077: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_007c: div
    IL_007d: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0082: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0087: ldloc.1
    IL_0088: ldloc.1
    IL_0089: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_008e: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0093: ldloc.1
    IL_0094: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0099: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_009e: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_00a3: ldarg.0
    IL_00a4: ldnull
    IL_00a5: stfld object ColorAndLightManager.<ToDay>d__66::<>2__current  /*0x04000450*/
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.1
    IL_00ac: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_00b1: ldc.i4.1
    IL_00b2: ret
    IL_00b3: ldarg.0
    IL_00b4: ldc.i4.m1
    IL_00b5: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_00c0: ldloc.1
    IL_00c1: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_00c6: ble IL_0047
    IL_00cb: ldarg.0
    IL_00cc: ldc.r4 0f
    IL_00d1: stfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_00d6: br.s IL_0150
    IL_00d8: ldarg.0
    IL_00d9: ldarg.0
    IL_00da: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_00df: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00e4: add
    IL_00e5: stfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_00ea: ldloc.1
    IL_00eb: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_00f0: ldloc.1
    IL_00f1: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_00f6: ldfld Color Colorscheme::sunsetLightColor  /*0x04000459*/
    IL_00fb: ldloc.1
    IL_00fc: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0101: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_0106: ldarg.0
    IL_0107: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_010c: ldloc.1
    IL_010d: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_0112: div
    IL_0113: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0118: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_011d: ldloc.1
    IL_011e: ldloc.1
    IL_011f: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0124: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0129: ldloc.1
    IL_012a: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_012f: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_0134: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_0139: ldarg.0
    IL_013a: ldnull
    IL_013b: stfld object ColorAndLightManager.<ToDay>d__66::<>2__current  /*0x04000450*/
    IL_0140: ldarg.0
    IL_0141: ldc.i4.2
    IL_0142: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_0147: ldc.i4.1
    IL_0148: ret
    IL_0149: ldarg.0
    IL_014a: ldc.i4.m1
    IL_014b: stfld int ColorAndLightManager.<ToDay>d__66::<>1__state  /*0x0400044F*/
    IL_0150: ldarg.0
    IL_0151: ldfld float ColorAndLightManager.<ToDay>d__66::<timer>5__2  /*0x04000452*/
    IL_0156: ldloc.1
    IL_0157: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_015c: ble IL_00d8
    IL_0161: ldloc.1
    IL_0162: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0167: ldloc.1
    IL_0168: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_016d: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_0172: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0177: ldloc.1
    IL_0178: ldloc.1
    IL_0179: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_017e: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0183: ldloc.1
    IL_0184: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0189: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_018e: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_0193: ldc.i4.0
    IL_0194: ret

  .method ColorAndLightManager.<ToDay>d__66::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000370 rva 0xfbc5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ColorAndLightManager.<ToDay>d__66::<>2__current  /*0x04000450*/
    IL_0006: ret

  .method ColorAndLightManager.<ToDay>d__66::System.Collections.IEnumerator.Reset()  // token 0x06000371 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ColorAndLightManager.<ToDay>d__66::System.Collections.IEnumerator.get_Current()  // token 0x06000372 rva 0xfbc5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ColorAndLightManager.<ToDay>d__66::<>2__current  /*0x04000450*/
    IL_0006: ret

// ===== ColorAndLightManager/<ToNight>d__67  (token 0x0200009F) =====
  .method ColorAndLightManager.<ToNight>d__67::.ctor(int)  // token 0x06000373 rva 0xfbcd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int ColorAndLightManager.<ToNight>d__67::<>1__state  /*0x04000454*/
    IL_000d: ret

  .method ColorAndLightManager.<ToNight>d__67::System.IDisposable.Dispose()  // token 0x06000374 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ColorAndLightManager.<ToNight>d__67::MoveNext()  // token 0x06000375 rva 0xfbdc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 257 (0x101), max stack 5, init locals
    .locals ([0] int, [1] ColorAndLightManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int ColorAndLightManager.<ToNight>d__67::<>1__state  /*0x04000454*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld ColorAndLightManager ColorAndLightManager.<ToNight>d__67::<>4__this  /*0x04000456*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00b5
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int ColorAndLightManager.<ToNight>d__67::<>1__state  /*0x04000454*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: stfld float ColorAndLightManager.<ToNight>d__67::<timer>5__2  /*0x04000457*/
    IL_002c: ldloc.1
    IL_002d: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_0032: ldloc.1
    IL_0033: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0038: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_003d: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0042: br.s IL_00bc
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld float ColorAndLightManager.<ToNight>d__67::<timer>5__2  /*0x04000457*/
    IL_004b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0050: add
    IL_0051: stfld float ColorAndLightManager.<ToNight>d__67::<timer>5__2  /*0x04000457*/
    IL_0056: ldloc.1
    IL_0057: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_005c: ldloc.1
    IL_005d: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0062: ldfld Color Colorscheme::dayLightColor  /*0x04000458*/
    IL_0067: ldloc.1
    IL_0068: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_006d: ldfld Color Colorscheme::nightLightColor  /*0x0400045A*/
    IL_0072: ldarg.0
    IL_0073: ldfld float ColorAndLightManager.<ToNight>d__67::<timer>5__2  /*0x04000457*/
    IL_0078: ldloc.1
    IL_0079: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_007e: div
    IL_007f: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0084: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_0089: ldloc.1
    IL_008a: ldloc.1
    IL_008b: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_0090: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_0095: ldloc.1
    IL_0096: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_009b: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_00a0: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_00a5: ldarg.0
    IL_00a6: ldnull
    IL_00a7: stfld object ColorAndLightManager.<ToNight>d__67::<>2__current  /*0x04000455*/
    IL_00ac: ldarg.0
    IL_00ad: ldc.i4.1
    IL_00ae: stfld int ColorAndLightManager.<ToNight>d__67::<>1__state  /*0x04000454*/
    IL_00b3: ldc.i4.1
    IL_00b4: ret
    IL_00b5: ldarg.0
    IL_00b6: ldc.i4.m1
    IL_00b7: stfld int ColorAndLightManager.<ToNight>d__67::<>1__state  /*0x04000454*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld float ColorAndLightManager.<ToNight>d__67::<timer>5__2  /*0x04000457*/
    IL_00c2: ldloc.1
    IL_00c3: ldfld float ColorAndLightManager::transitionDuration  /*0x04000422*/
    IL_00c8: ble IL_0044
    IL_00cd: ldloc.1
    IL_00ce: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_00d3: ldloc.1
    IL_00d4: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_00d9: ldfld Color Colorscheme::nightLightColor  /*0x0400045A*/
    IL_00de: callvirt void UnityEngine.Light::set_color(UnityEngine.Color)  /*0x0A00017B*/
    IL_00e3: ldloc.1
    IL_00e4: ldloc.1
    IL_00e5: ldfld Colorscheme ColorAndLightManager::colorscheme  /*0x0400041E*/
    IL_00ea: ldfld Color Colorscheme::globalShadowColor  /*0x0400045B*/
    IL_00ef: ldloc.1
    IL_00f0: ldfld Light ColorAndLightManager::sunlight  /*0x0400041C*/
    IL_00f5: callvirt Color UnityEngine.Light::get_color()  /*0x0A000199*/
    IL_00fa: call void ColorAndLightManager::AdjustAllOutlineColorsBasedOnLight(UnityEngine.Color,UnityEngine.Color)  /*0x06000365*/
    IL_00ff: ldc.i4.0
    IL_0100: ret

  .method ColorAndLightManager.<ToNight>d__67::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000376 rva 0xfce9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ColorAndLightManager.<ToNight>d__67::<>2__current  /*0x04000455*/
    IL_0006: ret

  .method ColorAndLightManager.<ToNight>d__67::System.Collections.IEnumerator.Reset()  // token 0x06000377 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method ColorAndLightManager.<ToNight>d__67::System.Collections.IEnumerator.get_Current()  // token 0x06000378 rva 0xfce9 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object ColorAndLightManager.<ToNight>d__67::<>2__current  /*0x04000455*/
    IL_0006: ret

