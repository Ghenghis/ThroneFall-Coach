// ===== SettingsBrightnessScale  (token 0x02000271) =====
  .method SettingsBrightnessScale::OnEnable()  // token 0x06000D70 rva 0x3d5c6 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0022
    IL_000d: ldarg.0
    IL_000e: ldfld TFUISlider SettingsBrightnessScale::slider  /*0x04000FE2*/
    IL_0013: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0018: callvirt float SettingsManager::get_BrightnessScale()  /*0x06000DA1*/
    IL_001d: callvirt void TFUISlider::SetValue(float)  /*0x06001243*/
    IL_0022: ret

  .method SettingsBrightnessScale::Start()  // token 0x06000D71 rva 0x3d5ea attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUISlider SettingsBrightnessScale::slider  /*0x04000FE2*/
    IL_0006: ldfld UnityEvent TFUISlider::onChange  /*0x040015F8*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsBrightnessScale::OnChange()  /*0x06000D72*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsBrightnessScale::OnChange()  // token 0x06000D72 rva 0x3d608 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld TFUISlider SettingsBrightnessScale::slider  /*0x04000FE2*/
    IL_000b: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0010: callvirt void SettingsManager::SetBrightnessScale(float)  /*0x06000DC0*/
    IL_0015: ret

  .method SettingsBrightnessScale::.ctor()  // token 0x06000D73 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

