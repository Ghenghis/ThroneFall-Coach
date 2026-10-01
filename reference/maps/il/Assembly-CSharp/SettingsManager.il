// ===== SettingsManager  (token 0x0200027E) =====
  .method SettingsManager::get_Instance()  // token 0x06000D9A rva 0x3da3d attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld SettingsManager SettingsManager::instance  /*0x04000FF1*/
    IL_0005: ret

  .method SettingsManager::get_Fullscreen()  // token 0x06000D9B rva 0x3da44 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::fullscreen  /*0x04000FFD*/
    IL_0006: ret

  .method SettingsManager::get_VSync()  // token 0x06000D9C rva 0x3da4c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::vSync  /*0x04000FFE*/
    IL_0006: ret

  .method SettingsManager::get_CurrentResolution()  // token 0x06000D9D rva 0x3da54 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_0006: ret

  .method SettingsManager::get_PostProcessing()  // token 0x06000D9E rva 0x3da5c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::postProcessing  /*0x04001000*/
    IL_0006: ret

  .method SettingsManager::get_AntiAliasing()  // token 0x06000D9F rva 0x3da64 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MsaaQuality SettingsManager::antiAliasing  /*0x04001001*/
    IL_0006: ret

  .method SettingsManager::get_Renderscale()  // token 0x06000DA0 rva 0x3da6c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::renderscale  /*0x04001002*/
    IL_0006: ret

  .method SettingsManager::get_BrightnessScale()  // token 0x06000DA1 rva 0x3da74 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::brightnessScale  /*0x04001003*/
    IL_0006: ret

  .method SettingsManager::get_VolumeMaster()  // token 0x06000DA2 rva 0x3da7c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_0006: ret

  .method SettingsManager::get_VolumeSFX()  // token 0x06000DA3 rva 0x3da84 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::volumeSFX  /*0x04001005*/
    IL_0006: ret

  .method SettingsManager::get_VolumeEnvironment()  // token 0x06000DA4 rva 0x3da8c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::volumeEnvironment  /*0x04001006*/
    IL_0006: ret

  .method SettingsManager::get_VolumeMusic()  // token 0x06000DA5 rva 0x3da94 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::volumeMusic  /*0x04001007*/
    IL_0006: ret

  .method SettingsManager::get_ResetUnitFormationEveryMorning()  // token 0x06000DA6 rva 0x3da9c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::resetUnitFormationEveryMorning  /*0x04001008*/
    IL_0006: ret

  .method SettingsManager::get_UiReferenceResolutionFactor()  // token 0x06000DA7 rva 0x3daa4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0006: ret

  .method SettingsManager::get_DisableTooltips()  // token 0x06000DA8 rva 0x3daac attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::disableTooltips  /*0x0400100A*/
    IL_0006: ret

  .method SettingsManager::get_DisableExtraTips()  // token 0x06000DA9 rva 0x3dab4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::disableExtraTips  /*0x0400100B*/
    IL_0006: ret

  .method SettingsManager::get_ArachnophobiaMode()  // token 0x06000DAA rva 0x3dabc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::arachnophobiaMode  /*0x0400100C*/
    IL_0006: ret

  .method SettingsManager::get_DisplayTowerRangesOnInteract()  // token 0x06000DAB rva 0x3dac4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::displayTowerRangesOnInteract  /*0x0400100D*/
    IL_0006: ret

  .method SettingsManager::get_EnableControlGroups()  // token 0x06000DAC rva 0x3dacc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::enableControlGroups  /*0x0400100E*/
    IL_0006: ret

  .method SettingsManager::get_DisableScreenShake()  // token 0x06000DAD rva 0x3dad4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::disableScreenShake  /*0x0400100F*/
    IL_0006: ret

  .method SettingsManager::get_EnableUnitDamageStats()  // token 0x06000DAE rva 0x3dadc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::enableUnitDamageStats  /*0x04001010*/
    IL_0006: ret

  .method SettingsManager::get_EnableEnemyUnitDamageStats()  // token 0x06000DAF rva 0x3dae4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::enableEnemyUnitDamageStats  /*0x04001011*/
    IL_0006: ret

  .method SettingsManager::get_EnableUnitStats()  // token 0x06000DB0 rva 0x3daec attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsManager::enableUnitStats  /*0x04001012*/
    IL_0006: ret

  .method SettingsManager::get_ColorblindMode()  // token 0x06000DB1 rva 0x3daf4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SettingsManager.ColorBlindMode SettingsManager::colorblindMode  /*0x04001013*/
    IL_0006: ret

  .method SettingsManager::Awake()  // token 0x06000DB2 rva 0x3dafc attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldsfld SettingsManager SettingsManager::instance  /*0x04000FF1*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld SettingsManager SettingsManager::instance  /*0x04000FF1*/
    IL_001f: ret

  .method SettingsManager::Start()  // token 0x06000DB3 rva 0x3db1d attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SettingsManager::LoadVideoSettingsFromPlayerPrefs()  /*0x06000DD2*/
    IL_0006: ldarg.0
    IL_0007: call void SettingsManager::LoadAudioSettingsFromPlayerPrefs()  /*0x06000DD4*/
    IL_000c: ldarg.0
    IL_000d: call void SettingsManager::LoadGameplaySettingsFromPlayerPrefs()  /*0x06000DD6*/
    IL_0012: ret

  .method SettingsManager::OnEnable()  // token 0x06000DB4 rva 0x3db31 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator SettingsManager::LoadControlsConfigDeffered()  /*0x06000DB7*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ldarg.0
    IL_000e: ldftn void SettingsManager::OnControllerConnect(Rewired.ControllerStatusChangedEventArgs)  /*0x06000DB6*/
    IL_0014: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_0019: call void Rewired.ReInput::add_ControllerConnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000A*/
    IL_001e: ret

  .method SettingsManager::OnDisable()  // token 0x06000DB5 rva 0x3db51 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void SettingsManager::OnControllerConnect(Rewired.ControllerStatusChangedEventArgs)  /*0x06000DB6*/
    IL_0007: newobj void System.Action<Rewired.ControllerStatusChangedEventArgs>::.ctor(object,IntPtr)  /*0x0A000009*/
    IL_000c: call void Rewired.ReInput::remove_ControllerDisconnectedEvent(System.Action<Rewired.ControllerStatusChangedEventArgs>)  /*0x0A00000D*/
    IL_0011: ret

  .method SettingsManager::OnControllerConnect(Rewired.ControllerStatusChangedEventArgs)  // token 0x06000DB6 rva 0x3db64 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator SettingsManager::LoadControlsConfigDeffered()  /*0x06000DB7*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method SettingsManager::LoadControlsConfigDeffered()  // token 0x06000DB7 rva 0x3db73 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void SettingsManager.<LoadControlsConfigDeffered>d__122::.ctor(int)  /*0x06000DDC*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld SettingsManager SettingsManager.<LoadControlsConfigDeffered>d__122::<>4__this  /*0x04001041*/
    IL_000d: ret

  .method SettingsManager::SetResolution(UnityEngine.Resolution)  // token 0x06000DB8 rva 0x3db84 attrs Public, HideBySig
    // code size 179 (0xb3), max stack 4, init locals
    .locals ([0] bool, [1] FullScreenMode, [2] List.Enumerator<Resolution>, [3] Resolution)
    IL_0000: call Resolution[] UnityEngine.Screen::get_resolutions()  /*0x0A000595*/
    IL_0005: newobj void System.Collections.Generic.List<UnityEngine.Resolution>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000596*/
    IL_000a: ldc.i4.0
    IL_000b: stloc.0
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Resolution>::GetEnumerator()  /*0x0A000597*/
    IL_0011: stloc.2
    IL_0012: br.s IL_0029
    IL_0014: ldloca.s 2
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Resolution>::get_Current()  /*0x0A000598*/
    IL_001b: stloc.3
    IL_001c: ldarg.1
    IL_001d: ldloc.3
    IL_001e: call bool ResolutionExtensions::CompareResolutions(UnityEngine.Resolution,UnityEngine.Resolution)  /*0x06000DE2*/
    IL_0023: brfalse.s IL_0029
    IL_0025: ldc.i4.1
    IL_0026: stloc.0
    IL_0027: leave.s IL_0042
    IL_0029: ldloca.s 2
    IL_002b: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Resolution>::MoveNext()  /*0x0A000599*/
    IL_0030: brtrue.s IL_0014
    IL_0032: leave.s IL_0042
    IL_0034: ldloca.s 2
    IL_0036: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Resolution>  /*0x1B000102*/
    IL_003c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0041: endfinally
    IL_0042: ldloc.0
    IL_0043: brtrue.s IL_004c
    IL_0045: call Resolution UnityEngine.Screen::get_currentResolution()  /*0x0A00059A*/
    IL_004a: starg.s 1
    IL_004c: ldarg.0
    IL_004d: ldarg.1
    IL_004e: stfld Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_0053: ldc.i4.1
    IL_0054: stloc.1
    IL_0055: ldarg.0
    IL_0056: ldfld bool SettingsManager::fullscreen  /*0x04000FFD*/
    IL_005b: brtrue.s IL_005f
    IL_005d: ldc.i4.3
    IL_005e: stloc.1
    IL_005f: ldarg.0
    IL_0060: ldflda Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_0065: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_006a: ldarg.0
    IL_006b: ldflda Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_0070: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_0075: ldloc.1
    IL_0076: ldarg.0
    IL_0077: ldflda Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_007c: call RefreshRate UnityEngine.Resolution::get_refreshRateRatio()  /*0x0A00059D*/
    IL_0081: call void UnityEngine.Screen::SetResolution(int,int,UnityEngine.FullScreenMode,UnityEngine.RefreshRate)  /*0x0A00059E*/
    IL_0086: ldarg.0
    IL_0087: ldfld string SettingsManager::VIDEO_RESOLUTION_WIDTH  /*0x04001014*/
    IL_008c: ldarg.0
    IL_008d: ldflda Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_0092: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_0097: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_009c: ldarg.0
    IL_009d: ldfld string SettingsManager::VIDEO_RESOLUTION_HEIGHT  /*0x04001015*/
    IL_00a2: ldarg.0
    IL_00a3: ldflda Resolution SettingsManager::currentResolution  /*0x04000FFF*/
    IL_00a8: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_00ad: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00b2: ret
    .try IL_0012-IL_0034 finally handler IL_0034-IL_0042

  .method SettingsManager::SetVSync(bool)  // token 0x06000DB9 rva 0x3dc54 attrs Public, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::vSync  /*0x04000FFE*/
    IL_0007: ldarg.1
    IL_0008: brfalse.s IL_0012
    IL_000a: ldc.i4.1
    IL_000b: call void UnityEngine.QualitySettings::set_vSyncCount(int)  /*0x0A00059F*/
    IL_0010: br.s IL_0018
    IL_0012: ldc.i4.0
    IL_0013: call void UnityEngine.QualitySettings::set_vSyncCount(int)  /*0x0A00059F*/
    IL_0018: ldarg.0
    IL_0019: ldfld string SettingsManager::VIDEO_VSYNC  /*0x04001018*/
    IL_001e: ldarg.1
    IL_001f: brtrue.s IL_0024
    IL_0021: ldc.i4.0
    IL_0022: br.s IL_0025
    IL_0024: ldc.i4.1
    IL_0025: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_002a: ret

  .method SettingsManager::SetPostProcessing(bool)  // token 0x06000DBA rva 0x3dc80 attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::postProcessing  /*0x04001000*/
    IL_0007: ldarg.0
    IL_0008: ldfld UnityEvent SettingsManager::onPPSettingsChange  /*0x04000FF4*/
    IL_000d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0012: ldarg.0
    IL_0013: ldfld string SettingsManager::VIDEO_POSTPROCESSING  /*0x04001016*/
    IL_0018: ldarg.1
    IL_0019: brtrue.s IL_001e
    IL_001b: ldc.i4.0
    IL_001c: br.s IL_001f
    IL_001e: ldc.i4.1
    IL_001f: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0024: ret

  .method SettingsManager::SetAntiAliasing(UnityEngine.Rendering.Universal.MsaaQuality)  // token 0x06000DBB rva 0x3dca6 attrs Public, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld MsaaQuality SettingsManager::antiAliasing  /*0x04001001*/
    IL_0007: ldarg.0
    IL_0008: ldfld UniversalRenderPipelineAsset SettingsManager::renderAsset  /*0x04000FF2*/
    IL_000d: ldarg.0
    IL_000e: ldfld MsaaQuality SettingsManager::antiAliasing  /*0x04001001*/
    IL_0013: callvirt void UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset::set_msaaSampleCount(int)  /*0x0A0005A0*/
    IL_0018: ldarg.0
    IL_0019: ldfld string SettingsManager::VIDEO_ANTIALIASING  /*0x04001019*/
    IL_001e: ldarg.0
    IL_001f: ldfld MsaaQuality SettingsManager::antiAliasing  /*0x04001001*/
    IL_0024: call int SettingsManager::AALevelToInt(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DCF*/
    IL_0029: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_002e: ret

  .method SettingsManager::SetColorblind(SettingsManager.ColorBlindMode)  // token 0x06000DBC rva 0x3dcd6 attrs Public, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld SettingsManager.ColorBlindMode SettingsManager::colorblindMode  /*0x04001013*/
    IL_0007: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_000c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0011: brfalse.s IL_001d
    IL_0013: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0018: callvirt void ColorAndLightManager::EasyReloadColorScheme()  /*0x06000368*/
    IL_001d: ldarg.0
    IL_001e: ldfld string SettingsManager::GAMEPLAY_COLORBLIND  /*0x04001032*/
    IL_0023: ldarg.0
    IL_0024: ldfld SettingsManager.ColorBlindMode SettingsManager::colorblindMode  /*0x04001013*/
    IL_0029: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_002e: ret

  .method SettingsManager::SetFullscreen(bool)  // token 0x06000DBD rva 0x3dd06 attrs Public, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::fullscreen  /*0x04000FFD*/
    IL_0007: ldarg.1
    IL_0008: call void UnityEngine.Screen::set_fullScreen(bool)  /*0x0A0005A1*/
    IL_000d: ldarg.0
    IL_000e: ldfld string SettingsManager::VIDEO_FULLSCREEN  /*0x04001017*/
    IL_0013: ldarg.1
    IL_0014: brtrue.s IL_0019
    IL_0016: ldc.i4.0
    IL_0017: br.s IL_001a
    IL_0019: ldc.i4.1
    IL_001a: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_001f: ret

  .method SettingsManager::SetShadowResolution(int)  // token 0x06000DBE rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SettingsManager::SetRenderscale(float)  // token 0x06000DBF rva 0x3dd27 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float SettingsManager::renderscale  /*0x04001002*/
    IL_0007: ldarg.0
    IL_0008: ldfld UniversalRenderPipelineAsset SettingsManager::renderAsset  /*0x04000FF2*/
    IL_000d: ldarg.0
    IL_000e: ldfld float SettingsManager::renderscale  /*0x04001002*/
    IL_0013: callvirt void UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset::set_renderScale(float)  /*0x0A0005A2*/
    IL_0018: ldarg.0
    IL_0019: ldfld string SettingsManager::VIDEO_RENDERSCALE  /*0x0400101A*/
    IL_001e: ldarg.0
    IL_001f: ldfld float SettingsManager::renderscale  /*0x04001002*/
    IL_0024: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0029: ret

  .method SettingsManager::SetBrightnessScale(float)  // token 0x06000DC0 rva 0x3dd52 attrs Public, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float SettingsManager::brightnessScale  /*0x04001003*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::VIDEO_BRIGHTNESSSCALE  /*0x0400101B*/
    IL_000d: ldarg.1
    IL_000e: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0013: ldarg.0
    IL_0014: ldfld UnityEvent SettingsManager::onBrightnessScaleChange  /*0x04000FF6*/
    IL_0019: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_001e: ret

  .method SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  // token 0x06000DC1 rva 0x3dd74 attrs Public, HideBySig
    // code size 163 (0xa3), max stack 3, init locals
    .locals ([0] string)
    IL_0000: ldarg.2
    IL_0001: switch (IL_006c, IL_0034, IL_0050, IL_0018)
    IL_0016: br.s IL_0088
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: stfld float SettingsManager::volumeEnvironment  /*0x04001006*/
    IL_001f: ldarg.0
    IL_0020: ldfld string SettingsManager::AUDIO_ENVIRONMENT  /*0x04001020*/
    IL_0025: ldarg.1
    IL_0026: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_002b: ldarg.0
    IL_002c: ldfld string SettingsManager::MIXER_ENVIRONMENT  /*0x04001024*/
    IL_0031: stloc.0
    IL_0032: br.s IL_008f
    IL_0034: ldarg.0
    IL_0035: ldarg.1
    IL_0036: stfld float SettingsManager::volumeMusic  /*0x04001007*/
    IL_003b: ldarg.0
    IL_003c: ldfld string SettingsManager::AUDIO_MUSIC  /*0x0400101E*/
    IL_0041: ldarg.1
    IL_0042: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0047: ldarg.0
    IL_0048: ldfld string SettingsManager::MIXER_MUSIC  /*0x04001022*/
    IL_004d: stloc.0
    IL_004e: br.s IL_008f
    IL_0050: ldarg.0
    IL_0051: ldarg.1
    IL_0052: stfld float SettingsManager::volumeSFX  /*0x04001005*/
    IL_0057: ldarg.0
    IL_0058: ldfld string SettingsManager::AUDIO_SFX  /*0x0400101F*/
    IL_005d: ldarg.1
    IL_005e: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0063: ldarg.0
    IL_0064: ldfld string SettingsManager::MIXER_SFX  /*0x04001023*/
    IL_0069: stloc.0
    IL_006a: br.s IL_008f
    IL_006c: ldarg.0
    IL_006d: ldarg.1
    IL_006e: stfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_0073: ldarg.0
    IL_0074: ldfld string SettingsManager::AUDIO_MASTER  /*0x0400101D*/
    IL_0079: ldarg.1
    IL_007a: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_007f: ldarg.0
    IL_0080: ldfld string SettingsManager::MIXER_MASTER  /*0x04001021*/
    IL_0085: stloc.0
    IL_0086: br.s IL_008f
    IL_0088: ldarg.0
    IL_0089: ldfld string SettingsManager::MIXER_MASTER  /*0x04001021*/
    IL_008e: stloc.0
    IL_008f: ldarg.0
    IL_0090: ldfld AudioMixer SettingsManager::mixer  /*0x04000FF3*/
    IL_0095: ldloc.0
    IL_0096: ldarg.1
    IL_0097: call float SettingsManager::PercentageToAudioLogarithmic(float)  /*0x06000DC3*/
    IL_009c: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_00a1: pop
    IL_00a2: ret

  .method SettingsManager::GetAudioVolume(SettingsManager.MixerChannel)  // token 0x06000DC2 rva 0x3de23 attrs Public, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.1
    IL_0001: switch (IL_002d, IL_001f, IL_0026, IL_0018)
    IL_0016: br.s IL_0034
    IL_0018: ldarg.0
    IL_0019: ldfld float SettingsManager::volumeEnvironment  /*0x04001006*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld float SettingsManager::volumeMusic  /*0x04001007*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldfld float SettingsManager::volumeSFX  /*0x04001005*/
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: ldfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_0033: ret
    IL_0034: ldarg.0
    IL_0035: ldfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_003a: ret

  .method SettingsManager::PercentageToAudioLogarithmic(float)  // token 0x06000DC3 rva 0x3de5f attrs Public, Static, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: conv.r8
    IL_0002: ldc.r8 0.0001
    IL_000b: bge.un.s IL_0014
    IL_000d: ldc.r4 0.0001f
    IL_0012: starg.s 0
    IL_0014: ldarg.0
    IL_0015: ldc.r4 1f
    IL_001a: ble.un.s IL_0023
    IL_001c: ldc.r4 1f
    IL_0021: starg.s 0
    IL_0023: ldarg.0
    IL_0024: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_0029: ldc.r4 20f
    IL_002e: mul
    IL_002f: starg.s 0
    IL_0031: ldarg.0
    IL_0032: ret

  .method SettingsManager::SetResetUnitsInTheMorning(bool)  // token 0x06000DC4 rva 0x3de93 attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::resetUnitFormationEveryMorning  /*0x04001008*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_RESET_UNIS_EVERY_MORNING  /*0x04001026*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ret

  .method SettingsManager::SetDisableTooltips(bool)  // token 0x06000DC5 rva 0x3deae attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::disableTooltips  /*0x0400100A*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_DISABLE_TOOLTIPS  /*0x04001027*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ret

  .method SettingsManager::SetDisableExtraTips(bool)  // token 0x06000DC6 rva 0x3dec9 attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::disableExtraTips  /*0x0400100B*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_DISABLE_EXTRATIPS  /*0x04001028*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ldarg.0
    IL_001a: ldfld UnityEvent SettingsManager::shouldDisplayExtraTipsChange  /*0x04000FF7*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0024: ret

  .method SettingsManager::SetArachnophobiaMode(bool)  // token 0x06000DC7 rva 0x3deef attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::arachnophobiaMode  /*0x0400100C*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_ARACHNOPHOBIA_MODE  /*0x04001029*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ldarg.0
    IL_001a: ldfld UnityEvent SettingsManager::onArachnophobiaModeChange  /*0x04000FF8*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0024: ret

  .method SettingsManager::SetDisplayTowerRangesOnInteract(bool)  // token 0x06000DC8 rva 0x3df15 attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::displayTowerRangesOnInteract  /*0x0400100D*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_DISPLAY_TOWER_RANGE_ON_INTERACT  /*0x0400102B*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ret

  .method SettingsManager::SetEnableControlGroups(bool)  // token 0x06000DC9 rva 0x3df30 attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::enableControlGroups  /*0x0400100E*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_ENABLE_CONTROL_GROUPS  /*0x0400102C*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ldarg.0
    IL_001a: ldfld UnityEvent SettingsManager::onEnableControlGroupsChange  /*0x04000FFA*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0024: ret

  .method SettingsManager::SetDisableScreenShake(bool)  // token 0x06000DCA rva 0x3df56 attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::disableScreenShake  /*0x0400100F*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_DISABLE_SCREEN_SHAKE  /*0x0400102D*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ret

  .method SettingsManager::SetEnabledUnitStats(bool)  // token 0x06000DCB rva 0x3df71 attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::enableUnitStats  /*0x04001012*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_STATS  /*0x04001031*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ret

  .method SettingsManager::SetEnabledUnitDamageStats(bool)  // token 0x06000DCC rva 0x3df8c attrs Public, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::enableUnitDamageStats  /*0x04001010*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_DAMAGE_STATS  /*0x0400102F*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ldarg.0
    IL_001a: ldfld bool SettingsManager::enableUnitDamageStats  /*0x04001010*/
    IL_001f: brtrue.s IL_002c
    IL_0021: ldarg.0
    IL_0022: ldfld UnityEvent SettingsManager::onEnableUnitDamageStatsChange  /*0x04000FFB*/
    IL_0027: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_002c: ret

  .method SettingsManager::SetEnabledEnemyUnitDamageStats(bool)  // token 0x06000DCD rva 0x3dfba attrs Public, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool SettingsManager::enableEnemyUnitDamageStats  /*0x04001011*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_ENABLE_ENEMY_UNIT_DAMAGE_STATS  /*0x04001030*/
    IL_000d: ldarg.1
    IL_000e: brtrue.s IL_0013
    IL_0010: ldc.i4.0
    IL_0011: br.s IL_0014
    IL_0013: ldc.i4.1
    IL_0014: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0019: ldarg.0
    IL_001a: ldfld bool SettingsManager::enableEnemyUnitDamageStats  /*0x04001011*/
    IL_001f: brtrue.s IL_002c
    IL_0021: ldarg.0
    IL_0022: ldfld UnityEvent SettingsManager::onEnableEnemyDamageUnitStatsChange  /*0x04000FFC*/
    IL_0027: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_002c: ret

  .method SettingsManager::SetUIReferenceResolutionScaleFactor(float)  // token 0x06000DCE rva 0x3dfe8 attrs Public, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0007: ldarg.0
    IL_0008: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_000d: ldarg.0
    IL_000e: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0013: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0018: ldarg.0
    IL_0019: ldfld UnityEvent SettingsManager::onUIScaleChange  /*0x04000FF5*/
    IL_001e: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0023: ret

  .method SettingsManager::AALevelToInt(UnityEngine.Rendering.Universal.MsaaQuality)  // token 0x06000DCF rva 0x3e00d attrs Public, Static, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: sub
    IL_0003: switch (IL_001e, IL_0020, IL_0026, IL_0022)
    IL_0018: ldarg.0
    IL_0019: ldc.i4.8
    IL_001a: beq.s IL_0024
    IL_001c: br.s IL_0026
    IL_001e: ldc.i4.0
    IL_001f: ret
    IL_0020: ldc.i4.1
    IL_0021: ret
    IL_0022: ldc.i4.2
    IL_0023: ret
    IL_0024: ldc.i4.3
    IL_0025: ret
    IL_0026: ldc.i4.0
    IL_0027: ret

  .method SettingsManager::IntToAALevel(int)  // token 0x06000DD0 rva 0x3e036 attrs Public, Static, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: switch (IL_0018, IL_001a, IL_001c, IL_001e)
    IL_0016: br.s IL_0020
    IL_0018: ldc.i4.1
    IL_0019: ret
    IL_001a: ldc.i4.2
    IL_001b: ret
    IL_001c: ldc.i4.4
    IL_001d: ret
    IL_001e: ldc.i4.8
    IL_001f: ret
    IL_0020: ldc.i4.1
    IL_0021: ret

  .method SettingsManager::InitializeVideoSettingsToPlayerPrefs(bool)  // token 0x06000DD1 rva 0x3e05c attrs Private, HideBySig
    // code size 286 (0x11e), max stack 3, init locals
    .locals ([0] Resolution)
    IL_0000: call Resolution[] UnityEngine.Screen::get_resolutions()  /*0x0A000595*/
    IL_0005: call Resolution[] UnityEngine.Screen::get_resolutions()  /*0x0A000595*/
    IL_000a: ldlen
    IL_000b: conv.i4
    IL_000c: ldc.i4.1
    IL_000d: sub
    IL_000e: ldelem UnityEngine.Resolution  /*0x0100010D*/
    IL_0013: stloc.0
    IL_0014: ldarg.0
    IL_0015: ldfld string SettingsManager::VIDEO_RESOLUTION_WIDTH  /*0x04001014*/
    IL_001a: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_001f: ldc.i4.0
    IL_0020: ceq
    IL_0022: ldarg.1
    IL_0023: or
    IL_0024: brfalse.s IL_0038
    IL_0026: ldarg.0
    IL_0027: ldfld string SettingsManager::VIDEO_RESOLUTION_WIDTH  /*0x04001014*/
    IL_002c: ldloca.s 0
    IL_002e: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_0033: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0038: ldarg.0
    IL_0039: ldfld string SettingsManager::VIDEO_RESOLUTION_HEIGHT  /*0x04001015*/
    IL_003e: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_0043: ldc.i4.0
    IL_0044: ceq
    IL_0046: ldarg.1
    IL_0047: or
    IL_0048: brfalse.s IL_005c
    IL_004a: ldarg.0
    IL_004b: ldfld string SettingsManager::VIDEO_RESOLUTION_HEIGHT  /*0x04001015*/
    IL_0050: ldloca.s 0
    IL_0052: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_0057: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_005c: ldarg.0
    IL_005d: ldfld string SettingsManager::VIDEO_FULLSCREEN  /*0x04001017*/
    IL_0062: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_0067: ldc.i4.0
    IL_0068: ceq
    IL_006a: ldarg.1
    IL_006b: or
    IL_006c: brfalse.s IL_007a
    IL_006e: ldarg.0
    IL_006f: ldfld string SettingsManager::VIDEO_FULLSCREEN  /*0x04001017*/
    IL_0074: ldc.i4.1
    IL_0075: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_007a: ldarg.0
    IL_007b: ldfld string SettingsManager::VIDEO_VSYNC  /*0x04001018*/
    IL_0080: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_0085: ldc.i4.0
    IL_0086: ceq
    IL_0088: ldarg.1
    IL_0089: or
    IL_008a: brfalse.s IL_0098
    IL_008c: ldarg.0
    IL_008d: ldfld string SettingsManager::VIDEO_VSYNC  /*0x04001018*/
    IL_0092: ldc.i4.1
    IL_0093: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0098: ldarg.0
    IL_0099: ldfld string SettingsManager::VIDEO_POSTPROCESSING  /*0x04001016*/
    IL_009e: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_00a3: ldc.i4.0
    IL_00a4: ceq
    IL_00a6: ldarg.1
    IL_00a7: or
    IL_00a8: brfalse.s IL_00b6
    IL_00aa: ldarg.0
    IL_00ab: ldfld string SettingsManager::VIDEO_POSTPROCESSING  /*0x04001016*/
    IL_00b0: ldc.i4.1
    IL_00b1: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld string SettingsManager::VIDEO_ANTIALIASING  /*0x04001019*/
    IL_00bc: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_00c1: ldc.i4.0
    IL_00c2: ceq
    IL_00c4: ldarg.1
    IL_00c5: or
    IL_00c6: brfalse.s IL_00d9
    IL_00c8: ldarg.0
    IL_00c9: ldfld string SettingsManager::VIDEO_ANTIALIASING  /*0x04001019*/
    IL_00ce: ldc.i4.4
    IL_00cf: call int SettingsManager::AALevelToInt(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DCF*/
    IL_00d4: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00d9: ldarg.0
    IL_00da: ldfld string SettingsManager::VIDEO_RENDERSCALE  /*0x0400101A*/
    IL_00df: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_00e4: ldc.i4.0
    IL_00e5: ceq
    IL_00e7: ldarg.1
    IL_00e8: or
    IL_00e9: brfalse.s IL_00fb
    IL_00eb: ldarg.0
    IL_00ec: ldfld string SettingsManager::VIDEO_RENDERSCALE  /*0x0400101A*/
    IL_00f1: ldc.r4 1f
    IL_00f6: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_00fb: ldarg.0
    IL_00fc: ldfld string SettingsManager::VIDEO_BRIGHTNESSSCALE  /*0x0400101B*/
    IL_0101: call bool UnityEngine.PlayerPrefs::HasKey(string)  /*0x0A0005A4*/
    IL_0106: ldc.i4.0
    IL_0107: ceq
    IL_0109: ldarg.1
    IL_010a: or
    IL_010b: brfalse.s IL_011d
    IL_010d: ldarg.0
    IL_010e: ldfld string SettingsManager::VIDEO_BRIGHTNESSSCALE  /*0x0400101B*/
    IL_0113: ldc.r4 1f
    IL_0118: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_011d: ret

  .method SettingsManager::LoadVideoSettingsFromPlayerPrefs()  // token 0x06000DD2 rva 0x3e188 attrs Private, HideBySig
    // code size 199 (0xc7), max stack 3, init locals
    .locals ([0] Resolution)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void SettingsManager::InitializeVideoSettingsToPlayerPrefs(bool)  /*0x06000DD1*/
    IL_0007: ldloca.s 0
    IL_0009: initobj UnityEngine.Resolution  /*0x0100010D*/
    IL_000f: ldloca.s 0
    IL_0011: ldarg.0
    IL_0012: ldfld string SettingsManager::VIDEO_RESOLUTION_WIDTH  /*0x04001014*/
    IL_0017: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_001c: call void UnityEngine.Resolution::set_width(int)  /*0x0A0005A5*/
    IL_0021: ldloca.s 0
    IL_0023: ldarg.0
    IL_0024: ldfld string SettingsManager::VIDEO_RESOLUTION_HEIGHT  /*0x04001015*/
    IL_0029: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_002e: call void UnityEngine.Resolution::set_height(int)  /*0x0A0005A6*/
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldfld string SettingsManager::VIDEO_FULLSCREEN  /*0x04001017*/
    IL_003a: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_003f: ldc.i4.0
    IL_0040: cgt.un
    IL_0042: stfld bool SettingsManager::fullscreen  /*0x04000FFD*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldfld string SettingsManager::VIDEO_VSYNC  /*0x04001018*/
    IL_004e: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_0053: ldc.i4.0
    IL_0054: cgt.un
    IL_0056: stfld bool SettingsManager::vSync  /*0x04000FFE*/
    IL_005b: ldarg.0
    IL_005c: ldarg.0
    IL_005d: ldfld string SettingsManager::VIDEO_RENDERSCALE  /*0x0400101A*/
    IL_0062: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0067: stfld float SettingsManager::renderscale  /*0x04001002*/
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld string SettingsManager::VIDEO_BRIGHTNESSSCALE  /*0x0400101B*/
    IL_0073: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0078: call void SettingsManager::SetBrightnessScale(float)  /*0x06000DC0*/
    IL_007d: ldarg.0
    IL_007e: ldarg.0
    IL_007f: ldfld bool SettingsManager::vSync  /*0x04000FFE*/
    IL_0084: call void SettingsManager::SetVSync(bool)  /*0x06000DB9*/
    IL_0089: ldarg.0
    IL_008a: ldloc.0
    IL_008b: call void SettingsManager::SetResolution(UnityEngine.Resolution)  /*0x06000DB8*/
    IL_0090: ldarg.0
    IL_0091: ldarg.0
    IL_0092: ldfld string SettingsManager::VIDEO_POSTPROCESSING  /*0x04001016*/
    IL_0097: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_009c: ldc.i4.0
    IL_009d: cgt.un
    IL_009f: call void SettingsManager::SetPostProcessing(bool)  /*0x06000DBA*/
    IL_00a4: ldarg.0
    IL_00a5: ldarg.0
    IL_00a6: ldfld string SettingsManager::VIDEO_ANTIALIASING  /*0x04001019*/
    IL_00ab: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00b0: call MsaaQuality SettingsManager::IntToAALevel(int)  /*0x06000DD0*/
    IL_00b5: call void SettingsManager::SetAntiAliasing(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DBB*/
    IL_00ba: ldarg.0
    IL_00bb: ldarg.0
    IL_00bc: ldfld float SettingsManager::renderscale  /*0x04001002*/
    IL_00c1: call void SettingsManager::SetRenderscale(float)  /*0x06000DBF*/
    IL_00c6: ret

  .method SettingsManager::InitializeAudioSettingsToPlayerPrefs()  // token 0x06000DD3 rva 0x3e25c attrs Private, HideBySig
    // code size 77 (0x4d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld string SettingsManager::AUDIO_MASTER  /*0x0400101D*/
    IL_0006: ldc.r4 0.6f
    IL_000b: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0010: ldarg.0
    IL_0011: ldfld string SettingsManager::AUDIO_MUSIC  /*0x0400101E*/
    IL_0016: ldc.r4 1f
    IL_001b: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0020: ldarg.0
    IL_0021: ldfld string SettingsManager::AUDIO_SFX  /*0x0400101F*/
    IL_0026: ldc.r4 1f
    IL_002b: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0030: ldarg.0
    IL_0031: ldfld string SettingsManager::AUDIO_ENVIRONMENT  /*0x04001020*/
    IL_0036: ldc.r4 1f
    IL_003b: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0040: ldarg.0
    IL_0041: ldfld string SettingsManager::AUDIO_INITIALIZED  /*0x0400101C*/
    IL_0046: ldc.i4.1
    IL_0047: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_004c: ret

  .method SettingsManager::LoadAudioSettingsFromPlayerPrefs()  // token 0x06000DD4 rva 0x3e2b8 attrs Private, HideBySig
    // code size 140 (0x8c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld string SettingsManager::AUDIO_INITIALIZED  /*0x0400101C*/
    IL_0006: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_000b: brtrue.s IL_0013
    IL_000d: ldarg.0
    IL_000e: call void SettingsManager::InitializeAudioSettingsToPlayerPrefs()  /*0x06000DD3*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld string SettingsManager::AUDIO_MASTER  /*0x0400101D*/
    IL_001a: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_001f: stfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_0024: ldarg.0
    IL_0025: ldarg.0
    IL_0026: ldfld string SettingsManager::AUDIO_MUSIC  /*0x0400101E*/
    IL_002b: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0030: stfld float SettingsManager::volumeMusic  /*0x04001007*/
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld string SettingsManager::AUDIO_SFX  /*0x0400101F*/
    IL_003c: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0041: stfld float SettingsManager::volumeSFX  /*0x04001005*/
    IL_0046: ldarg.0
    IL_0047: ldarg.0
    IL_0048: ldfld string SettingsManager::AUDIO_ENVIRONMENT  /*0x04001020*/
    IL_004d: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0052: stfld float SettingsManager::volumeEnvironment  /*0x04001006*/
    IL_0057: ldarg.0
    IL_0058: ldarg.0
    IL_0059: ldfld float SettingsManager::volumeMaster  /*0x04001004*/
    IL_005e: ldc.i4.0
    IL_005f: call void SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  /*0x06000DC1*/
    IL_0064: ldarg.0
    IL_0065: ldarg.0
    IL_0066: ldfld float SettingsManager::volumeMusic  /*0x04001007*/
    IL_006b: ldc.i4.1
    IL_006c: call void SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  /*0x06000DC1*/
    IL_0071: ldarg.0
    IL_0072: ldarg.0
    IL_0073: ldfld float SettingsManager::volumeEnvironment  /*0x04001006*/
    IL_0078: ldc.i4.3
    IL_0079: call void SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  /*0x06000DC1*/
    IL_007e: ldarg.0
    IL_007f: ldarg.0
    IL_0080: ldfld float SettingsManager::volumeSFX  /*0x04001005*/
    IL_0085: ldc.i4.2
    IL_0086: call void SettingsManager::SetAudioValue(float,SettingsManager.MixerChannel)  /*0x06000DC1*/
    IL_008b: ret

  .method SettingsManager::InitializeGameplaySettingsToPlayerPrefs()  // token 0x06000DD5 rva 0x3e350 attrs Private, HideBySig
    // code size 201 (0xc9), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld string SettingsManager::GAMEPLAY_RESET_UNIS_EVERY_MORNING  /*0x04001026*/
    IL_0006: ldc.i4.1
    IL_0007: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_000c: ldarg.0
    IL_000d: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_0012: ldc.r4 1f
    IL_0017: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_001c: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0021: callvirt bool Thronefall.GameServices.IGameServices::get_Initialized()  /*0x06003DF7*/
    IL_0026: brfalse.s IL_0044
    IL_0028: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_002d: callvirt bool Thronefall.GameServices.IGameServices::IsRunningOnSteamDeck()  /*0x06003E01*/
    IL_0032: brfalse.s IL_0044
    IL_0034: ldarg.0
    IL_0035: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_003a: ldc.r4 0.8f
    IL_003f: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0044: ldarg.0
    IL_0045: ldfld string SettingsManager::GAMEPLAY_DISABLE_TOOLTIPS  /*0x04001027*/
    IL_004a: ldc.i4.0
    IL_004b: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0050: ldarg.0
    IL_0051: ldfld string SettingsManager::GAMEPLAY_DISABLE_EXTRATIPS  /*0x04001028*/
    IL_0056: ldc.i4.0
    IL_0057: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_005c: ldarg.0
    IL_005d: ldfld string SettingsManager::GAMEPLAY_ARACHNOPHOBIA_MODE  /*0x04001029*/
    IL_0062: ldc.i4.0
    IL_0063: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0068: ldarg.0
    IL_0069: ldfld string SettingsManager::GAMEPLAY_DISPLAY_TOWER_RANGE_ON_INTERACT  /*0x0400102B*/
    IL_006e: ldc.i4.0
    IL_006f: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0074: ldarg.0
    IL_0075: ldfld string SettingsManager::GAMEPLAY_ENABLE_CONTROL_GROUPS  /*0x0400102C*/
    IL_007a: ldc.i4.0
    IL_007b: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0080: ldarg.0
    IL_0081: ldfld string SettingsManager::GAMEPLAY_DISABLE_SCREEN_SHAKE  /*0x0400102D*/
    IL_0086: ldc.i4.0
    IL_0087: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_008c: ldarg.0
    IL_008d: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_DAMAGE_STATS  /*0x0400102F*/
    IL_0092: ldc.i4.0
    IL_0093: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0098: ldarg.0
    IL_0099: ldfld string SettingsManager::GAMEPLAY_ENABLE_ENEMY_UNIT_DAMAGE_STATS  /*0x04001030*/
    IL_009e: ldc.i4.0
    IL_009f: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_STATS  /*0x04001031*/
    IL_00aa: ldc.i4.0
    IL_00ab: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld string SettingsManager::GAMEPLAY_INITIALIZED  /*0x04001025*/
    IL_00b6: ldc.i4.1
    IL_00b7: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld string SettingsManager::GAMEPLAY_COLORBLIND  /*0x04001032*/
    IL_00c2: ldc.i4.0
    IL_00c3: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_00c8: ret

  .method SettingsManager::LoadGameplaySettingsFromPlayerPrefs()  // token 0x06000DD6 rva 0x3e428 attrs Private, HideBySig
    // code size 411 (0x19b), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld string SettingsManager::GAMEPLAY_INITIALIZED  /*0x04001025*/
    IL_0006: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_000b: brtrue.s IL_0013
    IL_000d: ldarg.0
    IL_000e: call void SettingsManager::InitializeGameplaySettingsToPlayerPrefs()  /*0x06000DD5*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld string SettingsManager::GAMEPLAY_RESET_UNIS_EVERY_MORNING  /*0x04001026*/
    IL_001a: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_001f: ldc.i4.0
    IL_0020: cgt.un
    IL_0022: stfld bool SettingsManager::resetUnitFormationEveryMorning  /*0x04001008*/
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_002e: call float UnityEngine.PlayerPrefs::GetFloat(string)  /*0x0A0005A7*/
    IL_0033: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0038: ldarg.0
    IL_0039: ldarg.0
    IL_003a: ldfld string SettingsManager::GAMEPLAY_DISABLE_TOOLTIPS  /*0x04001027*/
    IL_003f: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_0044: ldc.i4.0
    IL_0045: cgt.un
    IL_0047: stfld bool SettingsManager::disableTooltips  /*0x0400100A*/
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld string SettingsManager::GAMEPLAY_DISABLE_EXTRATIPS  /*0x04001028*/
    IL_0053: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_0058: ldc.i4.0
    IL_0059: cgt.un
    IL_005b: stfld bool SettingsManager::disableExtraTips  /*0x0400100B*/
    IL_0060: ldarg.0
    IL_0061: ldarg.0
    IL_0062: ldfld string SettingsManager::GAMEPLAY_ARACHNOPHOBIA_MODE  /*0x04001029*/
    IL_0067: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_006c: ldc.i4.0
    IL_006d: cgt.un
    IL_006f: stfld bool SettingsManager::arachnophobiaMode  /*0x0400100C*/
    IL_0074: ldarg.0
    IL_0075: ldarg.0
    IL_0076: ldfld string SettingsManager::GAMEPLAY_DISPLAY_TOWER_RANGE_ON_INTERACT  /*0x0400102B*/
    IL_007b: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_0080: ldc.i4.0
    IL_0081: cgt.un
    IL_0083: stfld bool SettingsManager::displayTowerRangesOnInteract  /*0x0400100D*/
    IL_0088: ldarg.0
    IL_0089: ldarg.0
    IL_008a: ldfld string SettingsManager::GAMEPLAY_ENABLE_CONTROL_GROUPS  /*0x0400102C*/
    IL_008f: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_0094: ldc.i4.0
    IL_0095: cgt.un
    IL_0097: stfld bool SettingsManager::enableControlGroups  /*0x0400100E*/
    IL_009c: ldarg.0
    IL_009d: ldarg.0
    IL_009e: ldfld string SettingsManager::GAMEPLAY_DISABLE_SCREEN_SHAKE  /*0x0400102D*/
    IL_00a3: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00a8: ldc.i4.0
    IL_00a9: cgt.un
    IL_00ab: stfld bool SettingsManager::disableScreenShake  /*0x0400100F*/
    IL_00b0: ldarg.0
    IL_00b1: ldarg.0
    IL_00b2: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_DAMAGE_STATS  /*0x0400102F*/
    IL_00b7: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00bc: ldc.i4.0
    IL_00bd: cgt.un
    IL_00bf: stfld bool SettingsManager::enableUnitDamageStats  /*0x04001010*/
    IL_00c4: ldarg.0
    IL_00c5: ldarg.0
    IL_00c6: ldfld string SettingsManager::GAMEPLAY_ENABLE_ENEMY_UNIT_DAMAGE_STATS  /*0x04001030*/
    IL_00cb: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00d0: ldc.i4.0
    IL_00d1: cgt.un
    IL_00d3: stfld bool SettingsManager::enableEnemyUnitDamageStats  /*0x04001011*/
    IL_00d8: ldarg.0
    IL_00d9: ldarg.0
    IL_00da: ldfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_STATS  /*0x04001031*/
    IL_00df: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_00e4: ldc.i4.0
    IL_00e5: cgt.un
    IL_00e7: stfld bool SettingsManager::enableUnitStats  /*0x04001012*/
    IL_00ec: ldarg.0
    IL_00ed: ldarg.0
    IL_00ee: ldfld string SettingsManager::GAMEPLAY_COLORBLIND  /*0x04001032*/
    IL_00f3: ldc.i4.0
    IL_00f4: call int UnityEngine.PlayerPrefs::GetInt(string,int)  /*0x0A0005A8*/
    IL_00f9: stfld SettingsManager.ColorBlindMode SettingsManager::colorblindMode  /*0x04001013*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0104: ldc.r4 0.001f
    IL_0109: bge.un.s IL_0159
    IL_010b: ldarg.0
    IL_010c: ldc.r4 1f
    IL_0111: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0116: ldarg.0
    IL_0117: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_011c: ldc.r4 1f
    IL_0121: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0126: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_012b: callvirt bool Thronefall.GameServices.IGameServices::get_Initialized()  /*0x06003DF7*/
    IL_0130: brfalse.s IL_0159
    IL_0132: call IGameServices Thronefall.GameServices.GameServicesLocator::get_Instance()  /*0x06003DF4*/
    IL_0137: callvirt bool Thronefall.GameServices.IGameServices::IsRunningOnSteamDeck()  /*0x06003E01*/
    IL_013c: brfalse.s IL_0159
    IL_013e: ldarg.0
    IL_013f: ldc.r4 1f
    IL_0144: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0149: ldarg.0
    IL_014a: ldfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_014f: ldc.r4 0.8f
    IL_0154: call void UnityEngine.PlayerPrefs::SetFloat(string,float)  /*0x0A0005A3*/
    IL_0159: ldarg.0
    IL_015a: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_015f: ldc.r4 0.8f
    IL_0164: blt.s IL_0173
    IL_0166: ldarg.0
    IL_0167: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_016c: ldc.r4 1.2f
    IL_0171: ble.un.s IL_019a
    IL_0173: ldarg.0
    IL_0174: ldarg.0
    IL_0175: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_017a: ldc.r4 0.8f
    IL_017f: ldc.r4 1.2f
    IL_0184: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0189: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_018e: ldarg.0
    IL_018f: ldarg.0
    IL_0190: ldfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0195: call void SettingsManager::SetUIReferenceResolutionScaleFactor(float)  /*0x06000DCE*/
    IL_019a: ret

  .method SettingsManager::ResetVideoSettings()  // token 0x06000DD7 rva 0x3e5cf attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void SettingsManager::InitializeVideoSettingsToPlayerPrefs(bool)  /*0x06000DD1*/
    IL_0007: ldarg.0
    IL_0008: call void SettingsManager::LoadVideoSettingsFromPlayerPrefs()  /*0x06000DD2*/
    IL_000d: ret

  .method SettingsManager::ResetAudioSettings()  // token 0x06000DD8 rva 0x3e5de attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SettingsManager::InitializeAudioSettingsToPlayerPrefs()  /*0x06000DD3*/
    IL_0006: ldarg.0
    IL_0007: call void SettingsManager::LoadAudioSettingsFromPlayerPrefs()  /*0x06000DD4*/
    IL_000c: ret

  .method SettingsManager::ResetGameplaySettings()  // token 0x06000DD9 rva 0x3e5ec attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SettingsManager::InitializeGameplaySettingsToPlayerPrefs()  /*0x06000DD5*/
    IL_0006: ldarg.0
    IL_0007: call void SettingsManager::LoadGameplaySettingsFromPlayerPrefs()  /*0x06000DD6*/
    IL_000c: ret

  .method SettingsManager::ResetGameProgress()  // token 0x06000DDA rva 0x3e5fa attrs Public, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: call void GameProgressResetter::ResetAndBackupAllGameProgress()  /*0x06000D5B*/
    IL_0005: ret

  .method SettingsManager::.ctor()  // token 0x06000DDB rva 0x3e604 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 501 (0x1f5), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent SettingsManager::onPPSettingsChange  /*0x04000FF4*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent SettingsManager::onUIScaleChange  /*0x04000FF5*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent SettingsManager::onBrightnessScaleChange  /*0x04000FF6*/
    IL_0021: ldarg.0
    IL_0022: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0027: stfld UnityEvent SettingsManager::shouldDisplayExtraTipsChange  /*0x04000FF7*/
    IL_002c: ldarg.0
    IL_002d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0032: stfld UnityEvent SettingsManager::onArachnophobiaModeChange  /*0x04000FF8*/
    IL_0037: ldarg.0
    IL_0038: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_003d: stfld UnityEvent SettingsManager::onDisplayTowerRangeChange  /*0x04000FF9*/
    IL_0042: ldarg.0
    IL_0043: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0048: stfld UnityEvent SettingsManager::onEnableControlGroupsChange  /*0x04000FFA*/
    IL_004d: ldarg.0
    IL_004e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0053: stfld UnityEvent SettingsManager::onEnableUnitDamageStatsChange  /*0x04000FFB*/
    IL_0058: ldarg.0
    IL_0059: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_005e: stfld UnityEvent SettingsManager::onEnableEnemyDamageUnitStatsChange  /*0x04000FFC*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.1
    IL_0065: stfld bool SettingsManager::fullscreen  /*0x04000FFD*/
    IL_006a: ldarg.0
    IL_006b: ldc.i4.1
    IL_006c: stfld bool SettingsManager::postProcessing  /*0x04001000*/
    IL_0071: ldarg.0
    IL_0072: ldc.i4.4
    IL_0073: stfld MsaaQuality SettingsManager::antiAliasing  /*0x04001001*/
    IL_0078: ldarg.0
    IL_0079: ldc.r4 1f
    IL_007e: stfld float SettingsManager::renderscale  /*0x04001002*/
    IL_0083: ldarg.0
    IL_0084: ldc.r4 1f
    IL_0089: stfld float SettingsManager::brightnessScale  /*0x04001003*/
    IL_008e: ldarg.0
    IL_008f: ldc.r4 1f
    IL_0094: stfld float SettingsManager::uiReferenceResolutionFactor  /*0x04001009*/
    IL_0099: ldarg.0
    IL_009a: ldstr "Video_ResWidth"
    IL_009f: stfld string SettingsManager::VIDEO_RESOLUTION_WIDTH  /*0x04001014*/
    IL_00a4: ldarg.0
    IL_00a5: ldstr "Video_ResHeight"
    IL_00aa: stfld string SettingsManager::VIDEO_RESOLUTION_HEIGHT  /*0x04001015*/
    IL_00af: ldarg.0
    IL_00b0: ldstr "Video_PostProcessing"
    IL_00b5: stfld string SettingsManager::VIDEO_POSTPROCESSING  /*0x04001016*/
    IL_00ba: ldarg.0
    IL_00bb: ldstr "Video_Fullscreen"
    IL_00c0: stfld string SettingsManager::VIDEO_FULLSCREEN  /*0x04001017*/
    IL_00c5: ldarg.0
    IL_00c6: ldstr "Video_Vsync"
    IL_00cb: stfld string SettingsManager::VIDEO_VSYNC  /*0x04001018*/
    IL_00d0: ldarg.0
    IL_00d1: ldstr "Video_AntiAliasing"
    IL_00d6: stfld string SettingsManager::VIDEO_ANTIALIASING  /*0x04001019*/
    IL_00db: ldarg.0
    IL_00dc: ldstr "Video_Renderscale"
    IL_00e1: stfld string SettingsManager::VIDEO_RENDERSCALE  /*0x0400101A*/
    IL_00e6: ldarg.0
    IL_00e7: ldstr "Video_BrightnessScale"
    IL_00ec: stfld string SettingsManager::VIDEO_BRIGHTNESSSCALE  /*0x0400101B*/
    IL_00f1: ldarg.0
    IL_00f2: ldstr "Audio_Initialized_1.1"
    IL_00f7: stfld string SettingsManager::AUDIO_INITIALIZED  /*0x0400101C*/
    IL_00fc: ldarg.0
    IL_00fd: ldstr "Audio_Master"
    IL_0102: stfld string SettingsManager::AUDIO_MASTER  /*0x0400101D*/
    IL_0107: ldarg.0
    IL_0108: ldstr "Audio_Music"
    IL_010d: stfld string SettingsManager::AUDIO_MUSIC  /*0x0400101E*/
    IL_0112: ldarg.0
    IL_0113: ldstr "Audio_SFX"
    IL_0118: stfld string SettingsManager::AUDIO_SFX  /*0x0400101F*/
    IL_011d: ldarg.0
    IL_011e: ldstr "Audio_Environment"
    IL_0123: stfld string SettingsManager::AUDIO_ENVIRONMENT  /*0x04001020*/
    IL_0128: ldarg.0
    IL_0129: ldstr "MasterVolume"
    IL_012e: stfld string SettingsManager::MIXER_MASTER  /*0x04001021*/
    IL_0133: ldarg.0
    IL_0134: ldstr "SettingsMusicVolume"
    IL_0139: stfld string SettingsManager::MIXER_MUSIC  /*0x04001022*/
    IL_013e: ldarg.0
    IL_013f: ldstr "SettingsSFXVolume"
    IL_0144: stfld string SettingsManager::MIXER_SFX  /*0x04001023*/
    IL_0149: ldarg.0
    IL_014a: ldstr "SettingsEnvironmentVolume"
    IL_014f: stfld string SettingsManager::MIXER_ENVIRONMENT  /*0x04001024*/
    IL_0154: ldarg.0
    IL_0155: ldstr "Gameplay_Initialized_1.1"
    IL_015a: stfld string SettingsManager::GAMEPLAY_INITIALIZED  /*0x04001025*/
    IL_015f: ldarg.0
    IL_0160: ldstr "Gameplay_ResetUnitFormationEveryMorning"
    IL_0165: stfld string SettingsManager::GAMEPLAY_RESET_UNIS_EVERY_MORNING  /*0x04001026*/
    IL_016a: ldarg.0
    IL_016b: ldstr "Gameplay_DisableTooltips"
    IL_0170: stfld string SettingsManager::GAMEPLAY_DISABLE_TOOLTIPS  /*0x04001027*/
    IL_0175: ldarg.0
    IL_0176: ldstr "Gameplay_DisableExtraTips"
    IL_017b: stfld string SettingsManager::GAMEPLAY_DISABLE_EXTRATIPS  /*0x04001028*/
    IL_0180: ldarg.0
    IL_0181: ldstr "Gameplay_ArachnophobiaMode"
    IL_0186: stfld string SettingsManager::GAMEPLAY_ARACHNOPHOBIA_MODE  /*0x04001029*/
    IL_018b: ldarg.0
    IL_018c: ldstr "Gameplay_DisplayTowerRange"
    IL_0191: stfld string SettingsManager::GAMEPLAY_DISPLAY_TOWER_RANGE  /*0x0400102A*/
    IL_0196: ldarg.0
    IL_0197: ldstr "Gameplay_DisplayTowerRangeOnInteract"
    IL_019c: stfld string SettingsManager::GAMEPLAY_DISPLAY_TOWER_RANGE_ON_INTERACT  /*0x0400102B*/
    IL_01a1: ldarg.0
    IL_01a2: ldstr "Gameplay_EnableControlGroups"
    IL_01a7: stfld string SettingsManager::GAMEPLAY_ENABLE_CONTROL_GROUPS  /*0x0400102C*/
    IL_01ac: ldarg.0
    IL_01ad: ldstr "Gameplay_DisableScreenShake"
    IL_01b2: stfld string SettingsManager::GAMEPLAY_DISABLE_SCREEN_SHAKE  /*0x0400102D*/
    IL_01b7: ldarg.0
    IL_01b8: ldstr "Gameplay_UIScaleFactor"
    IL_01bd: stfld string SettingsManager::GAMEPLAY_UI_SCALE_FACTOR  /*0x0400102E*/
    IL_01c2: ldarg.0
    IL_01c3: ldstr "Gameplay_EnableUnitDamageStats"
    IL_01c8: stfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_DAMAGE_STATS  /*0x0400102F*/
    IL_01cd: ldarg.0
    IL_01ce: ldstr "Gameplay_EnableEnemyUnitDamageStats"
    IL_01d3: stfld string SettingsManager::GAMEPLAY_ENABLE_ENEMY_UNIT_DAMAGE_STATS  /*0x04001030*/
    IL_01d8: ldarg.0
    IL_01d9: ldstr "Gameplay_EnableUnitStats"
    IL_01de: stfld string SettingsManager::GAMEPLAY_ENABLE_UNIT_STATS  /*0x04001031*/
    IL_01e3: ldarg.0
    IL_01e4: ldstr "Gameplay_Colorblind"
    IL_01e9: stfld string SettingsManager::GAMEPLAY_COLORBLIND  /*0x04001032*/
    IL_01ee: ldarg.0
    IL_01ef: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_01f4: ret

// ===== SettingsManager/MixerChannel  (token 0x0200027F) =====
// ===== SettingsManager/ColorBlindMode  (token 0x02000280) =====
// ===== SettingsManager/<LoadControlsConfigDeffered>d__122  (token 0x02000281) =====
  .method SettingsManager.<LoadControlsConfigDeffered>d__122::.ctor(int)  // token 0x06000DDC rva 0x3e805 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int SettingsManager.<LoadControlsConfigDeffered>d__122::<>1__state  /*0x0400103F*/
    IL_000d: ret

  .method SettingsManager.<LoadControlsConfigDeffered>d__122::System.IDisposable.Dispose()  // token 0x06000DDD rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SettingsManager.<LoadControlsConfigDeffered>d__122::MoveNext()  // token 0x06000DDE rva 0x3e814 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 84 (0x54), max stack 2, init locals
    .locals ([0] int, [1] SettingsManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int SettingsManager.<LoadControlsConfigDeffered>d__122::<>1__state  /*0x0400103F*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld SettingsManager SettingsManager.<LoadControlsConfigDeffered>d__122::<>4__this  /*0x04001041*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_003f
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int SettingsManager.<LoadControlsConfigDeffered>d__122::<>1__state  /*0x0400103F*/
    IL_001e: ldloc.1
    IL_001f: ldfld bool SettingsManager::isInDefferedControlsLoadingCoroutine  /*0x04001033*/
    IL_0024: brfalse.s IL_0028
    IL_0026: ldc.i4.0
    IL_0027: ret
    IL_0028: ldloc.1
    IL_0029: ldc.i4.1
    IL_002a: stfld bool SettingsManager::isInDefferedControlsLoadingCoroutine  /*0x04001033*/
    IL_002f: ldarg.0
    IL_0030: ldnull
    IL_0031: stfld object SettingsManager.<LoadControlsConfigDeffered>d__122::<>2__current  /*0x04001040*/
    IL_0036: ldarg.0
    IL_0037: ldc.i4.1
    IL_0038: stfld int SettingsManager.<LoadControlsConfigDeffered>d__122::<>1__state  /*0x0400103F*/
    IL_003d: ldc.i4.1
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldc.i4.m1
    IL_0041: stfld int SettingsManager.<LoadControlsConfigDeffered>d__122::<>1__state  /*0x0400103F*/
    IL_0046: call void ControlConfigSaveLoad::LoadControlConfigFromJson()  /*0x0600092E*/
    IL_004b: ldloc.1
    IL_004c: ldc.i4.0
    IL_004d: stfld bool SettingsManager::isInDefferedControlsLoadingCoroutine  /*0x04001033*/
    IL_0052: ldc.i4.0
    IL_0053: ret

  .method SettingsManager.<LoadControlsConfigDeffered>d__122::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000DDF rva 0x3e874 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SettingsManager.<LoadControlsConfigDeffered>d__122::<>2__current  /*0x04001040*/
    IL_0006: ret

  .method SettingsManager.<LoadControlsConfigDeffered>d__122::System.Collections.IEnumerator.Reset()  // token 0x06000DE0 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method SettingsManager.<LoadControlsConfigDeffered>d__122::System.Collections.IEnumerator.get_Current()  // token 0x06000DE1 rva 0x3e874 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SettingsManager.<LoadControlsConfigDeffered>d__122::<>2__current  /*0x04001040*/
    IL_0006: ret

