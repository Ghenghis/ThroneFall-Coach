// ===== SettingsEnableControlGroups  (token 0x02000278) =====
  .method SettingsEnableControlGroups::OnApply()  // token 0x06000D88 rva 0x3d80e attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld Checkbox SettingsEnableControlGroups::checkbox  /*0x04000FE9*/
    IL_000b: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0010: callvirt void SettingsManager::SetEnableControlGroups(bool)  /*0x06000DC9*/
    IL_0015: ldarg.0
    IL_0016: ldfld Checkbox SettingsEnableControlGroups::checkbox  /*0x04000FE9*/
    IL_001b: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0020: brfalse.s IL_0032
    IL_0022: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0027: ldarg.0
    IL_0028: ldfld UIFrame SettingsEnableControlGroups::controlGroupTutorialUI  /*0x04000FEA*/
    IL_002d: callvirt void UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  /*0x06001307*/
    IL_0032: ret

  .method SettingsEnableControlGroups::OnEnable()  // token 0x06000D89 rva 0x3d842 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0021
    IL_000c: ldarg.0
    IL_000d: ldfld Checkbox SettingsEnableControlGroups::checkbox  /*0x04000FE9*/
    IL_0012: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0017: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_001c: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_0021: ret

  .method SettingsEnableControlGroups::.ctor()  // token 0x06000D8A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

