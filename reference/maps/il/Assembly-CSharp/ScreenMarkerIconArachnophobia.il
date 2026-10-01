// ===== ScreenMarkerIconArachnophobia  (token 0x02000007) =====
  .method ScreenMarkerIconArachnophobia::Refresh()  // token 0x06000025 rva 0x274b attrs Public, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0031
    IL_000c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0011: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0016: brfalse.s IL_0025
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: ldfld Sprite ScreenMarkerIconArachnophobia::arachnophobiaModeSprite  /*0x04000020*/
    IL_001f: stfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0024: ret
    IL_0025: ldarg.0
    IL_0026: ldarg.0
    IL_0027: ldfld Sprite ScreenMarkerIconArachnophobia::defaultSprite  /*0x04000021*/
    IL_002c: stfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0031: ret

  .method ScreenMarkerIconArachnophobia::.ctor()  // token 0x06000026 rva 0x277e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ScreenMarkerIcon::.ctor()  /*0x06000D42*/
    IL_0006: ret

