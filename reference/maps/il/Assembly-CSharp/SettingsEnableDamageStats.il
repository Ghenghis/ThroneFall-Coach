// ===== SettingsEnableDamageStats  (token 0x02000279) =====
  .method SettingsEnableDamageStats::OnApply()  // token 0x06000D8B rva 0x3d865 attrs Public, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsEnableDamageStats::playerUnit  /*0x04000FEC*/
    IL_0006: brfalse.s IL_001e
    IL_0008: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_000d: ldarg.0
    IL_000e: ldfld Checkbox SettingsEnableDamageStats::checkbox  /*0x04000FEB*/
    IL_0013: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0018: callvirt void SettingsManager::SetEnabledUnitDamageStats(bool)  /*0x06000DCC*/
    IL_001d: ret
    IL_001e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0023: ldarg.0
    IL_0024: ldfld Checkbox SettingsEnableDamageStats::checkbox  /*0x04000FEB*/
    IL_0029: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_002e: callvirt void SettingsManager::SetEnabledEnemyUnitDamageStats(bool)  /*0x06000DCD*/
    IL_0033: ret

  .method SettingsEnableDamageStats::OnEnable()  // token 0x06000D8C rva 0x3d89c attrs Private, HideBySig
    // code size 64 (0x40), max stack 2, init locals
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_003f
    IL_000c: ldarg.0
    IL_000d: ldfld bool SettingsEnableDamageStats::playerUnit  /*0x04000FEC*/
    IL_0012: brfalse.s IL_002a
    IL_0014: ldarg.0
    IL_0015: ldfld Checkbox SettingsEnableDamageStats::checkbox  /*0x04000FEB*/
    IL_001a: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001f: callvirt bool SettingsManager::get_EnableUnitDamageStats()  /*0x06000DAE*/
    IL_0024: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldfld Checkbox SettingsEnableDamageStats::checkbox  /*0x04000FEB*/
    IL_0030: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0035: callvirt bool SettingsManager::get_EnableEnemyUnitDamageStats()  /*0x06000DAF*/
    IL_003a: callvirt void Checkbox::SetState(bool)  /*0x06000FD6*/
    IL_003f: ret

  .method SettingsEnableDamageStats::.ctor()  // token 0x06000D8D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

