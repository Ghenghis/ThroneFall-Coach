// ===== SettingsShadowResolution  (token 0x0200028A) =====
  .method SettingsShadowResolution::Start()  // token 0x06000DF8 rva 0x3eb47 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsShadowResolution::selector  /*0x04001049*/
    IL_0006: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsShadowResolution::OnChange()  /*0x06000DFA*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsShadowResolution::OnEnable()  // token 0x06000DF9 rva 0x3eb68 attrs Private, HideBySig
    // code size 117 (0x75), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsShadowResolution::selector  /*0x04001049*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_0010: ldarg.0
    IL_0011: ldfld EnumSelector SettingsShadowResolution::selector  /*0x04001049*/
    IL_0016: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_001b: ldc.i4.5
    IL_001c: newarr System.String  /*0x0100001D*/
    IL_0021: dup
    IL_0022: ldc.i4.0
    IL_0023: ldstr "256"
    IL_0028: stelem.ref
    IL_0029: dup
    IL_002a: ldc.i4.1
    IL_002b: ldstr "512"
    IL_0030: stelem.ref
    IL_0031: dup
    IL_0032: ldc.i4.2
    IL_0033: ldstr "1024"
    IL_0038: stelem.ref
    IL_0039: dup
    IL_003a: ldc.i4.3
    IL_003b: ldstr "2048"
    IL_0040: stelem.ref
    IL_0041: dup
    IL_0042: ldc.i4.4
    IL_0043: ldstr "4096"
    IL_0048: stelem.ref
    IL_0049: callvirt void System.Collections.Generic.List<string>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000594*/
    IL_004e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0053: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0058: brfalse.s IL_0074
    IL_005a: ldarg.0
    IL_005b: ldfld EnumSelector SettingsShadowResolution::selector  /*0x04001049*/
    IL_0060: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0065: callvirt MsaaQuality SettingsManager::get_AntiAliasing()  /*0x06000D9F*/
    IL_006a: call int SettingsManager::AALevelToInt(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DCF*/
    IL_006f: callvirt void EnumSelector::SetIndex(int)  /*0x060010B5*/
    IL_0074: ret

  .method SettingsShadowResolution::OnChange()  // token 0x06000DFA rva 0x3ebe9 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld EnumSelector SettingsShadowResolution::selector  /*0x04001049*/
    IL_000b: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0010: call MsaaQuality SettingsManager::IntToAALevel(int)  /*0x06000DD0*/
    IL_0015: callvirt void SettingsManager::SetAntiAliasing(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DBB*/
    IL_001a: ret

  .method SettingsShadowResolution::.ctor()  // token 0x06000DFB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

