// ===== SettingsLanguageReset  (token 0x0200027D) =====
  .method SettingsLanguageReset::ResetLanguage()  // token 0x06000D98 rva 0x3da18 attrs Public, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: call string I2.Loc.LocalizationManager::GetCurrentDeviceLanguage(bool)  /*0x06001850*/
    IL_0006: call void I2.Loc.LocalizationManager::set_CurrentLanguage(string)  /*0x06001823*/
    IL_000b: ldarg.0
    IL_000c: ldfld GameObject SettingsLanguageReset::objToRefresh  /*0x04000FF0*/
    IL_0011: ldc.i4.0
    IL_0012: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0017: ldarg.0
    IL_0018: ldfld GameObject SettingsLanguageReset::objToRefresh  /*0x04000FF0*/
    IL_001d: ldc.i4.1
    IL_001e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0023: ret

  .method SettingsLanguageReset::.ctor()  // token 0x06000D99 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

