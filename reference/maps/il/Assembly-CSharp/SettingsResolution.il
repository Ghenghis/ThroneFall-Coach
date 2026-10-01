// ===== SettingsResolution  (token 0x02000289) =====
  .method SettingsResolution::Start()  // token 0x06000DF4 rva 0x3e9d7 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsResolution::selector  /*0x04001047*/
    IL_0006: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsResolution::ApplyResolution()  /*0x06000DF6*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsResolution::OnEnable()  // token 0x06000DF5 rva 0x3e9f8 attrs Private, HideBySig
    // code size 235 (0xeb), max stack 5, init locals
    .locals ([0] int, [1] int, [2] Resolution, [3] string, [4] int, [5] RefreshRate, [6] double)
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsResolution::selector  /*0x04001047*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_0010: ldarg.0
    IL_0011: ldfld Dictionary<int, Resolution> SettingsResolution::availableResolutions  /*0x04001048*/
    IL_0016: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Resolution>::Clear()  /*0x0A0005A9*/
    IL_001b: ldc.i4.0
    IL_001c: stloc.0
    IL_001d: ldc.i4.0
    IL_001e: stloc.1
    IL_001f: br IL_00d1
    IL_0024: call Resolution[] UnityEngine.Screen::get_resolutions()  /*0x0A000595*/
    IL_0029: ldloc.1
    IL_002a: ldelem UnityEngine.Resolution  /*0x0100010D*/
    IL_002f: stloc.2
    IL_0030: ldarg.0
    IL_0031: ldfld Dictionary<int, Resolution> SettingsResolution::availableResolutions  /*0x04001048*/
    IL_0036: ldloc.1
    IL_0037: ldloc.2
    IL_0038: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Resolution>::Add(!0,!1)  /*0x0A0005AA*/
    IL_003d: ldc.i4.6
    IL_003e: newarr System.String  /*0x0100001D*/
    IL_0043: dup
    IL_0044: ldc.i4.0
    IL_0045: ldloca.s 2
    IL_0047: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_004c: stloc.s 4
    IL_004e: ldloca.s 4
    IL_0050: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0055: stelem.ref
    IL_0056: dup
    IL_0057: ldc.i4.1
    IL_0058: ldstr " x "
    IL_005d: stelem.ref
    IL_005e: dup
    IL_005f: ldc.i4.2
    IL_0060: ldloca.s 2
    IL_0062: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_0067: stloc.s 4
    IL_0069: ldloca.s 4
    IL_006b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0070: stelem.ref
    IL_0071: dup
    IL_0072: ldc.i4.3
    IL_0073: ldstr " @ "
    IL_0078: stelem.ref
    IL_0079: dup
    IL_007a: ldc.i4.4
    IL_007b: ldloca.s 2
    IL_007d: call RefreshRate UnityEngine.Resolution::get_refreshRateRatio()  /*0x0A00059D*/
    IL_0082: stloc.s 5
    IL_0084: ldloca.s 5
    IL_0086: call double UnityEngine.RefreshRate::get_value()  /*0x0A0005AB*/
    IL_008b: stloc.s 6
    IL_008d: ldloca.s 6
    IL_008f: ldstr "F0"
    IL_0094: call string System.Double::ToString(string)  /*0x0A0005AC*/
    IL_0099: stelem.ref
    IL_009a: dup
    IL_009b: ldc.i4.5
    IL_009c: ldstr "Hz"
    IL_00a1: stelem.ref
    IL_00a2: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_00a7: stloc.3
    IL_00a8: ldarg.0
    IL_00a9: ldfld EnumSelector SettingsResolution::selector  /*0x04001047*/
    IL_00ae: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_00b3: ldloc.3
    IL_00b4: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_00b9: ldloc.2
    IL_00ba: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_00bf: callvirt Resolution SettingsManager::get_CurrentResolution()  /*0x06000D9D*/
    IL_00c4: call bool ResolutionExtensions::CompareResolutions(UnityEngine.Resolution,UnityEngine.Resolution)  /*0x06000DE2*/
    IL_00c9: brfalse.s IL_00cd
    IL_00cb: ldloc.1
    IL_00cc: stloc.0
    IL_00cd: ldloc.1
    IL_00ce: ldc.i4.1
    IL_00cf: add
    IL_00d0: stloc.1
    IL_00d1: ldloc.1
    IL_00d2: call Resolution[] UnityEngine.Screen::get_resolutions()  /*0x0A000595*/
    IL_00d7: ldlen
    IL_00d8: conv.i4
    IL_00d9: blt IL_0024
    IL_00de: ldarg.0
    IL_00df: ldfld EnumSelector SettingsResolution::selector  /*0x04001047*/
    IL_00e4: ldloc.0
    IL_00e5: callvirt void EnumSelector::SetIndex(int)  /*0x060010B5*/
    IL_00ea: ret

  .method SettingsResolution::ApplyResolution()  // token 0x06000DF6 rva 0x3eaf0 attrs Private, HideBySig
    // code size 56 (0x38), max stack 3, init locals
    .locals ([0] Resolution)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<int, Resolution> SettingsResolution::availableResolutions  /*0x04001048*/
    IL_0006: ldarg.0
    IL_0007: ldfld EnumSelector SettingsResolution::selector  /*0x04001047*/
    IL_000c: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0011: ldloca.s 0
    IL_0013: callvirt bool System.Collections.Generic.Dictionary<int, UnityEngine.Resolution>::TryGetValue(!0,ref !1)  /*0x0A0005AD*/
    IL_0018: brfalse.s IL_0037
    IL_001a: ldloc.0
    IL_001b: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0020: callvirt Resolution SettingsManager::get_CurrentResolution()  /*0x06000D9D*/
    IL_0025: call bool ResolutionExtensions::CompareResolutions(UnityEngine.Resolution,UnityEngine.Resolution)  /*0x06000DE2*/
    IL_002a: brtrue.s IL_0037
    IL_002c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0031: ldloc.0
    IL_0032: callvirt void SettingsManager::SetResolution(UnityEngine.Resolution)  /*0x06000DB8*/
    IL_0037: ret

  .method SettingsResolution::.ctor()  // token 0x06000DF7 rva 0x3eb34 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<int, UnityEngine.Resolution>::.ctor()  /*0x0A0005AE*/
    IL_0006: stfld Dictionary<int, Resolution> SettingsResolution::availableResolutions  /*0x04001048*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

