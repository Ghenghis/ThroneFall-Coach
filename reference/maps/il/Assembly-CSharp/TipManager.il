// ===== TipManager  (token 0x020002BB) =====
  .method TipManager::Awake()  // token 0x06000F09 rva 0x4354b attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TipManager TipManager::instance  /*0x04001155*/
    IL_0006: ldarg.0
    IL_0007: ldfld TMP_Text TipManager::headerText  /*0x0400115C*/
    IL_000c: ldstr ""
    IL_0011: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0016: ldarg.0
    IL_0017: ldfld TMP_Text TipManager::bodyText  /*0x0400115D*/
    IL_001c: ldstr ""
    IL_0021: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0026: ret

  .method TipManager::Start()  // token 0x06000F0A rva 0x43573 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0006: stfld SettingsManager TipManager::settings  /*0x0400115E*/
    IL_000b: ret

  .method TipManager::UpdateTipRaw(string,string,bool)  // token 0x06000F0B rva 0x43580 attrs Public, HideBySig
    // code size 205 (0xcd), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld SettingsManager TipManager::settings  /*0x0400115E*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0018
    IL_000d: ldarg.0
    IL_000e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0013: stfld SettingsManager TipManager::settings  /*0x0400115E*/
    IL_0018: ldarg.0
    IL_0019: ldfld SettingsManager TipManager::settings  /*0x0400115E*/
    IL_001e: callvirt bool SettingsManager::get_DisableExtraTips()  /*0x06000DA9*/
    IL_0023: brfalse.s IL_0036
    IL_0025: ldarg.3
    IL_0026: brtrue.s IL_0036
    IL_0028: ldstr ""
    IL_002d: starg.s 1
    IL_002f: ldstr ""
    IL_0034: starg.s 2
    IL_0036: ldarg.0
    IL_0037: ldfld TMP_Text TipManager::headerText  /*0x0400115C*/
    IL_003c: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0041: ldarg.1
    IL_0042: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0047: brfalse.s IL_0055
    IL_0049: ldarg.0
    IL_004a: ldfld TMP_Text TipManager::headerText  /*0x0400115C*/
    IL_004f: ldarg.1
    IL_0050: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0055: ldarg.0
    IL_0056: ldfld TMP_Text TipManager::bodyText  /*0x0400115D*/
    IL_005b: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0060: ldarg.2
    IL_0061: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0066: brfalse.s IL_0074
    IL_0068: ldarg.0
    IL_0069: ldfld TMP_Text TipManager::bodyText  /*0x0400115D*/
    IL_006e: ldarg.2
    IL_006f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0074: ldarg.0
    IL_0075: ldfld GameObject TipManager::background  /*0x0400115A*/
    IL_007a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_007f: brfalse.s IL_00c1
    IL_0081: ldarg.0
    IL_0082: ldfld TMP_Text TipManager::headerText  /*0x0400115C*/
    IL_0087: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_008c: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0091: ldc.i4.0
    IL_0092: bgt.s IL_00a7
    IL_0094: ldarg.0
    IL_0095: ldfld TMP_Text TipManager::bodyText  /*0x0400115D*/
    IL_009a: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_009f: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_00a4: ldc.i4.0
    IL_00a5: ble.s IL_00b5
    IL_00a7: ldarg.0
    IL_00a8: ldfld GameObject TipManager::background  /*0x0400115A*/
    IL_00ad: ldc.i4.1
    IL_00ae: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b3: br.s IL_00c1
    IL_00b5: ldarg.0
    IL_00b6: ldfld GameObject TipManager::background  /*0x0400115A*/
    IL_00bb: ldc.i4.0
    IL_00bc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld UIParentResizer TipManager::sizer  /*0x0400115B*/
    IL_00c7: callvirt void UIParentResizer::Trigger()  /*0x0600131B*/
    IL_00cc: ret

  .method TipManager::UpdateTipLocalized(string,string,bool)  // token 0x06000F0C rva 0x4365c attrs Public, HideBySig
    // code size 32 (0x20), max stack 5, init locals
    .locals ([0] string, [1] string)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.1
    IL_0002: ldc.i4.0
    IL_0003: ldc.i4.1
    IL_0004: ldc.i4.1
    IL_0005: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_000a: stloc.0
    IL_000b: ldarg.2
    IL_000c: ldc.i4.1
    IL_000d: ldc.i4.0
    IL_000e: ldc.i4.1
    IL_000f: ldc.i4.1
    IL_0010: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0015: stloc.1
    IL_0016: ldarg.0
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: ldarg.3
    IL_001a: call void TipManager::UpdateTipRaw(string,string,bool)  /*0x06000F0B*/
    IL_001f: ret

  .method TipManager::.ctor()  // token 0x06000F0D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

