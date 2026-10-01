// ===== SettingsPostProcessingHelper  (token 0x02000284) =====
  .method SettingsPostProcessingHelper::Start()  // token 0x06000DE6 rva 0x3e8da attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SettingsPostProcessingHelper::Refresh()  /*0x06000DE7*/
    IL_0006: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_000b: ldfld UnityEvent SettingsManager::onPPSettingsChange  /*0x04000FF4*/
    IL_0010: ldarg.0
    IL_0011: ldftn void SettingsPostProcessingHelper::Refresh()  /*0x06000DE7*/
    IL_0017: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0021: ret

  .method SettingsPostProcessingHelper::Refresh()  // token 0x06000DE7 rva 0x3e8fd attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Volume SettingsPostProcessingHelper::target  /*0x04001043*/
    IL_0006: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_000b: callvirt bool SettingsManager::get_PostProcessing()  /*0x06000D9E*/
    IL_0010: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0015: ret

  .method SettingsPostProcessingHelper::.ctor()  // token 0x06000DE8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

