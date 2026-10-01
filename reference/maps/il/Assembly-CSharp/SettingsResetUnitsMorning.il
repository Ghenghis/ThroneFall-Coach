// ===== SettingsResetUnitsMorning  (token 0x02000287) =====
  .method SettingsResetUnitsMorning::OnApply()  // token 0x06000DEF rva 0x3e979 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld Checkbox SettingsResetUnitsMorning::checkbox  /*0x04001045*/
    IL_000b: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0010: callvirt void SettingsManager::SetResetUnitsInTheMorning(bool)  /*0x06000DC4*/
    IL_0015: ret

  .method SettingsResetUnitsMorning::OnEnable()  // token 0x06000DF0 rva 0x3e990 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0021
    IL_000c: ldarg.0
    IL_000d: ldfld Checkbox SettingsResetUnitsMorning::checkbox  /*0x04001045*/
    IL_0012: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0017: callvirt bool SettingsManager::get_ResetUnitFormationEveryMorning()  /*0x06000DA6*/
    IL_001c: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_0021: ret

  .method SettingsResetUnitsMorning::.ctor()  // token 0x06000DF1 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

