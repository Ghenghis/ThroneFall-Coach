// ===== SettingsAntiAliasing  (token 0x0200026D) =====
  .method SettingsAntiAliasing::Start()  // token 0x06000D61 rva 0x3d41b attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsAntiAliasing::selector  /*0x04000FDD*/
    IL_0006: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsAntiAliasing::OnChange()  /*0x06000D63*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsAntiAliasing::OnEnable()  // token 0x06000D62 rva 0x3d43c attrs Private, HideBySig
    // code size 109 (0x6d), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsAntiAliasing::selector  /*0x04000FDD*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_0010: ldarg.0
    IL_0011: ldfld EnumSelector SettingsAntiAliasing::selector  /*0x04000FDD*/
    IL_0016: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_001b: ldc.i4.4
    IL_001c: newarr System.String  /*0x0100001D*/
    IL_0021: dup
    IL_0022: ldc.i4.0
    IL_0023: ldstr "Disabled"
    IL_0028: stelem.ref
    IL_0029: dup
    IL_002a: ldc.i4.1
    IL_002b: ldstr "2x"
    IL_0030: stelem.ref
    IL_0031: dup
    IL_0032: ldc.i4.2
    IL_0033: ldstr "4x"
    IL_0038: stelem.ref
    IL_0039: dup
    IL_003a: ldc.i4.3
    IL_003b: ldstr "8x"
    IL_0040: stelem.ref
    IL_0041: callvirt void System.Collections.Generic.List<string>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000594*/
    IL_0046: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_004b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0050: brfalse.s IL_006c
    IL_0052: ldarg.0
    IL_0053: ldfld EnumSelector SettingsAntiAliasing::selector  /*0x04000FDD*/
    IL_0058: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_005d: callvirt MsaaQuality SettingsManager::get_AntiAliasing()  /*0x06000D9F*/
    IL_0062: call int SettingsManager::AALevelToInt(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DCF*/
    IL_0067: callvirt void EnumSelector::SetIndex(int)  /*0x060010B5*/
    IL_006c: ret

  .method SettingsAntiAliasing::OnChange()  // token 0x06000D63 rva 0x3d4b5 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld EnumSelector SettingsAntiAliasing::selector  /*0x04000FDD*/
    IL_000b: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0010: call MsaaQuality SettingsManager::IntToAALevel(int)  /*0x06000DD0*/
    IL_0015: callvirt void SettingsManager::SetAntiAliasing(UnityEngine.Rendering.Universal.MsaaQuality)  /*0x06000DBB*/
    IL_001a: ret

  .method SettingsAntiAliasing::.ctor()  // token 0x06000D64 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

