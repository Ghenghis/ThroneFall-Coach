// ===== SettingsUIScale  (token 0x0200028B) =====
  .method SettingsUIScale::OnEnable()  // token 0x06000DFC rva 0x3ec05 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld TFUISliderRelative SettingsUIScale::target  /*0x0400104A*/
    IL_0013: ldc.r4 1f
    IL_0018: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001d: callvirt float SettingsManager::get_UiReferenceResolutionFactor()  /*0x06000DA7*/
    IL_0022: sub
    IL_0023: ldc.i4.1
    IL_0024: callvirt void TFUISliderRelative::SetValue(float,bool)  /*0x0600125D*/
    IL_0029: ret

  .method SettingsUIScale::Start()  // token 0x06000DFD rva 0x3ec30 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUISliderRelative SettingsUIScale::target  /*0x0400104A*/
    IL_0006: ldfld UnityEvent TFUISliderRelative::onChange  /*0x04001617*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsUIScale::OnChange()  /*0x06000DFE*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsUIScale::OnChange()  // token 0x06000DFE rva 0x3ec4e attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldc.r4 1f
    IL_000a: ldarg.0
    IL_000b: ldfld TFUISliderRelative SettingsUIScale::target  /*0x0400104A*/
    IL_0010: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0015: sub
    IL_0016: callvirt void SettingsManager::SetUIReferenceResolutionScaleFactor(float)  /*0x06000DCE*/
    IL_001b: ret

  .method SettingsUIScale::.ctor()  // token 0x06000DFF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

