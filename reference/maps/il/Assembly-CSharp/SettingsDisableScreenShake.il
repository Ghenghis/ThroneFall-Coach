// ===== SettingsDisableScreenShake  (token 0x02000274) =====
  .method SettingsDisableScreenShake::OnApply()  // token 0x06000D7B rva 0x3d73a attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld Checkbox SettingsDisableScreenShake::checkbox  /*0x04000FE5*/
    IL_000b: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0010: callvirt void SettingsManager::SetDisableScreenShake(bool)  /*0x06000DCA*/
    IL_0015: ldarg.0
    IL_0016: call void SettingsDisableScreenShake::Refresh()  /*0x06000D7D*/
    IL_001b: ret

  .method SettingsDisableScreenShake::OnEnable()  // token 0x06000D7C rva 0x3d757 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0021
    IL_000c: ldarg.0
    IL_000d: ldfld Checkbox SettingsDisableScreenShake::checkbox  /*0x04000FE5*/
    IL_0012: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0017: callvirt bool SettingsManager::get_DisableScreenShake()  /*0x06000DAD*/
    IL_001c: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_0021: ret

  .method SettingsDisableScreenShake::Refresh()  // token 0x06000D7D rva 0x3d77a attrs Public, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_001e
    IL_000c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0011: callvirt bool SettingsManager::get_DisableScreenShake()  /*0x06000DAD*/
    IL_0016: ldc.i4.0
    IL_0017: ceq
    IL_0019: stsfld bool MoreMountains.Feedbacks.MMF_PositionShake::FeedbackTypeAuthorized  /*0x0A0004F5*/
    IL_001e: ret

  .method SettingsDisableScreenShake::.ctor()  // token 0x06000D7E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

