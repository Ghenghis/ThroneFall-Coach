// ===== SettingsArachnophobiaMode  (token 0x0200026E) =====
  .method SettingsArachnophobiaMode::OnApply()  // token 0x06000D65 rva 0x3d4d1 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld Checkbox SettingsArachnophobiaMode::checkbox  /*0x04000FDE*/
    IL_000b: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0010: callvirt void SettingsManager::SetArachnophobiaMode(bool)  /*0x06000DC7*/
    IL_0015: ret

  .method SettingsArachnophobiaMode::OnEnable()  // token 0x06000D66 rva 0x3d4e8 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0021
    IL_000c: ldarg.0
    IL_000d: ldfld Checkbox SettingsArachnophobiaMode::checkbox  /*0x04000FDE*/
    IL_0012: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0017: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_001c: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_0021: ret

  .method SettingsArachnophobiaMode::.ctor()  // token 0x06000D67 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

