// ===== ResetAudioSettings  (token 0x0200026C) =====
  .method ResetAudioSettings::Trigger()  // token 0x06000D5F rva 0x3d3f7 attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: callvirt void SettingsManager::ResetAudioSettings()  /*0x06000DD8*/
    IL_000a: ldarg.0
    IL_000b: ldfld GameObject ResetAudioSettings::objToRefresh  /*0x04000FDC*/
    IL_0010: ldc.i4.0
    IL_0011: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0016: ldarg.0
    IL_0017: ldfld GameObject ResetAudioSettings::objToRefresh  /*0x04000FDC*/
    IL_001c: ldc.i4.1
    IL_001d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0022: ret

  .method ResetAudioSettings::.ctor()  // token 0x06000D60 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

