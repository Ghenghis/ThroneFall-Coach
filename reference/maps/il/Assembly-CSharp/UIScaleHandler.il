// ===== UIScaleHandler  (token 0x0200038B) =====
  .method UIScaleHandler::Start()  // token 0x0600137E rva 0x5c3de attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.CanvasScaler>  /*0x2B00010F*/
    IL_0007: stfld CanvasScaler UIScaleHandler::scaler  /*0x04001798*/
    IL_000c: ldarg.0
    IL_000d: call void UIScaleHandler::Refresh()  /*0x0600137F*/
    IL_0012: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0017: ldfld UnityEvent SettingsManager::onUIScaleChange  /*0x04000FF5*/
    IL_001c: ldarg.0
    IL_001d: ldftn void UIScaleHandler::Refresh()  /*0x0600137F*/
    IL_0023: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0028: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002d: ret

  .method UIScaleHandler::Refresh()  // token 0x0600137F rva 0x5c410 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 4, init locals
    .locals ([0] float)
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: callvirt float SettingsManager::get_UiReferenceResolutionFactor()  /*0x06000DA7*/
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld CanvasScaler UIScaleHandler::scaler  /*0x04001798*/
    IL_0011: ldc.r4 1920f
    IL_0016: ldloc.0
    IL_0017: mul
    IL_0018: ldc.r4 1080f
    IL_001d: ldloc.0
    IL_001e: mul
    IL_001f: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0024: callvirt void UnityEngine.UI.CanvasScaler::set_referenceResolution(UnityEngine.Vector2)  /*0x0A00076F*/
    IL_0029: ret

  .method UIScaleHandler::.ctor()  // token 0x06001380 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

