// ===== SettingsResetGameProgress  (token 0x02000286) =====
  .method SettingsResetGameProgress::ResetGameProgress()  // token 0x06000DED rva 0x3e96d attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: callvirt void SettingsManager::ResetGameProgress()  /*0x06000DDA*/
    IL_000a: ret

  .method SettingsResetGameProgress::.ctor()  // token 0x06000DEE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

