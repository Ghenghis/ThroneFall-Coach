// ===== PlayerCameraScreenShake  (token 0x0200022E) =====
  .method PlayerCameraScreenShake::Start()  // token 0x06000B99 rva 0x36f84 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: callvirt bool SettingsManager::get_DisableScreenShake()  /*0x06000DAD*/
    IL_000a: ldc.i4.0
    IL_000b: ceq
    IL_000d: stsfld bool MoreMountains.Feedbacks.MMF_PositionShake::FeedbackTypeAuthorized  /*0x0A0004F5*/
    IL_0012: ret

  .method PlayerCameraScreenShake::.ctor()  // token 0x06000B9A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

