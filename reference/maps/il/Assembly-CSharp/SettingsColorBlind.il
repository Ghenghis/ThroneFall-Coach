// ===== SettingsColorBlind  (token 0x02000272) =====
  .method SettingsColorBlind::Start()  // token 0x06000D74 rva 0x3d61f attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsColorBlind::selector  /*0x04000FE3*/
    IL_0006: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_000b: ldarg.0
    IL_000c: ldftn void SettingsColorBlind::OnChange()  /*0x06000D76*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method SettingsColorBlind::OnEnable()  // token 0x06000D75 rva 0x3d640 attrs Private, HideBySig
    // code size 157 (0x9d), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld EnumSelector SettingsColorBlind::selector  /*0x04000FE3*/
    IL_0006: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_0010: ldarg.0
    IL_0011: ldfld EnumSelector SettingsColorBlind::selector  /*0x04000FE3*/
    IL_0016: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_001b: ldc.i4.5
    IL_001c: newarr System.String  /*0x0100001D*/
    IL_0021: dup
    IL_0022: ldc.i4.0
    IL_0023: ldstr "Menu/ColorblindModeOff"
    IL_0028: ldc.i4.1
    IL_0029: ldc.i4.0
    IL_002a: ldc.i4.1
    IL_002b: ldc.i4.1
    IL_002c: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0031: stelem.ref
    IL_0032: dup
    IL_0033: ldc.i4.1
    IL_0034: ldstr "Menu/ColorblindModeYellow"
    IL_0039: ldc.i4.1
    IL_003a: ldc.i4.0
    IL_003b: ldc.i4.1
    IL_003c: ldc.i4.1
    IL_003d: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0042: stelem.ref
    IL_0043: dup
    IL_0044: ldc.i4.2
    IL_0045: ldstr "Menu/ColorblindModeOrange"
    IL_004a: ldc.i4.1
    IL_004b: ldc.i4.0
    IL_004c: ldc.i4.1
    IL_004d: ldc.i4.1
    IL_004e: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0053: stelem.ref
    IL_0054: dup
    IL_0055: ldc.i4.3
    IL_0056: ldstr "Menu/ColorblindModePurple"
    IL_005b: ldc.i4.1
    IL_005c: ldc.i4.0
    IL_005d: ldc.i4.1
    IL_005e: ldc.i4.1
    IL_005f: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0064: stelem.ref
    IL_0065: dup
    IL_0066: ldc.i4.4
    IL_0067: ldstr "Menu/ColorblindModeWhite"
    IL_006c: ldc.i4.1
    IL_006d: ldc.i4.0
    IL_006e: ldc.i4.1
    IL_006f: ldc.i4.1
    IL_0070: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0075: stelem.ref
    IL_0076: callvirt void System.Collections.Generic.List<string>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000594*/
    IL_007b: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0080: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0085: brfalse.s IL_009c
    IL_0087: ldarg.0
    IL_0088: ldfld EnumSelector SettingsColorBlind::selector  /*0x04000FE3*/
    IL_008d: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0092: callvirt SettingsManager.ColorBlindMode SettingsManager::get_ColorblindMode()  /*0x06000DB1*/
    IL_0097: callvirt void EnumSelector::SetIndex(int)  /*0x060010B5*/
    IL_009c: ret

  .method SettingsColorBlind::OnChange()  // token 0x06000D76 rva 0x3d6e9 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldarg.0
    IL_0006: ldfld EnumSelector SettingsColorBlind::selector  /*0x04000FE3*/
    IL_000b: callvirt int EnumSelector::get_Index()  /*0x060010AE*/
    IL_0010: callvirt void SettingsManager::SetColorblind(SettingsManager.ColorBlindMode)  /*0x06000DBC*/
    IL_0015: ret

  .method SettingsColorBlind::.ctor()  // token 0x06000D77 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

