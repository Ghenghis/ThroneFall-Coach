// ===== SettingsBrightnessHelper  (token 0x02000270) =====
  .method SettingsBrightnessHelper::Start()  // token 0x06000D6C rva 0x3d570 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SettingsBrightnessHelper::Refresh()  /*0x06000D6D*/
    IL_0006: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_000b: ldfld UnityEvent SettingsManager::onBrightnessScaleChange  /*0x04000FF6*/
    IL_0010: ldarg.0
    IL_0011: ldftn void SettingsBrightnessHelper::Refresh()  /*0x06000D6D*/
    IL_0017: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0021: ret

  .method SettingsBrightnessHelper::Refresh()  // token 0x06000D6D rva 0x3d593 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Material SettingsBrightnessHelper::mat  /*0x04000FE1*/
    IL_0006: ldstr "_Brightness"
    IL_000b: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0010: callvirt float SettingsManager::get_BrightnessScale()  /*0x06000DA1*/
    IL_0015: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_001a: ret

  .method SettingsBrightnessHelper::OnDestroy()  // token 0x06000D6E rva 0x3d5af attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Material SettingsBrightnessHelper::mat  /*0x04000FE1*/
    IL_0006: ldstr "_Brightness"
    IL_000b: ldc.r4 1f
    IL_0010: callvirt void UnityEngine.Material::SetFloat(string,float)  /*0x0A000191*/
    IL_0015: ret

  .method SettingsBrightnessHelper::.ctor()  // token 0x06000D6F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

