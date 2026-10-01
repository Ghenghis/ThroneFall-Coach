// ===== SettingsLanguage  (token 0x0200027C) =====
  .method SettingsLanguage::Start()  // token 0x06000D94 rva 0x3d95c attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0006: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsLanguage::OnChange()  /*0x06000D96*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsLanguage::OnEnable()  // token 0x06000D95 rva 0x3d97c attrs Private, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    .locals ([0] string, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_0010: ldarg.0
    IL_0011: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0016: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_001b: ldc.i4.1
    IL_001c: call List<string> I2.Loc.LocalizationManager::GetAllLanguages(bool)  /*0x06001834*/
    IL_0021: callvirt void System.Collections.Generic.List<string>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000594*/
    IL_0026: call string I2.Loc.LocalizationManager::get_CurrentLanguage()  /*0x06001822*/
    IL_002b: stloc.0
    IL_002c: ldc.i4.0
    IL_002d: stloc.1
    IL_002e: br.s IL_005a
    IL_0030: ldarg.0
    IL_0031: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0036: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_003b: ldloc.1
    IL_003c: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_0041: ldloc.0
    IL_0042: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0047: brfalse.s IL_0056
    IL_0049: ldarg.0
    IL_004a: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_004f: ldloc.1
    IL_0050: callvirt void EnumSelector::SetIndex(int)  /*0x060010B5*/
    IL_0055: ret
    IL_0056: ldloc.1
    IL_0057: ldc.i4.1
    IL_0058: add
    IL_0059: stloc.1
    IL_005a: ldloc.1
    IL_005b: ldarg.0
    IL_005c: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0061: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0066: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_006b: blt.s IL_0030
    IL_006d: ret

  .method SettingsLanguage::OnChange()  // token 0x06000D96 rva 0x3d9f6 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: ldarg.0
    IL_000c: ldfld EnumSelector SettingsLanguage::selector  /*0x04000FEF*/
    IL_0011: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0016: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_001b: call void I2.Loc.LocalizationManager::set_CurrentLanguage(string)  /*0x06001823*/
    IL_0020: ret

  .method SettingsLanguage::.ctor()  // token 0x06000D97 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

