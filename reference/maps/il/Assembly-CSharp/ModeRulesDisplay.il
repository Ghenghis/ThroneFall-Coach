// ===== ModeRulesDisplay  (token 0x02000323) =====
  .method ModeRulesDisplay::Refresh()  // token 0x0600114D rva 0x51800 attrs Public, HideBySig
    // code size 184 (0xb8), max stack 5, init locals
    .locals ([0] LevelInfo, [1] int)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0007: ldnull
    IL_0008: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000d: brfalse.s IL_0017
    IL_000f: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0014: stloc.0
    IL_0015: br.s IL_0022
    IL_0017: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_001c: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_0021: stloc.0
    IL_0022: ldloc.0
    IL_0023: ldnull
    IL_0024: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0029: brfalse.s IL_0038
    IL_002b: ldarg.0
    IL_002c: ldfld GameObject ModeRulesDisplay::modeRulePanel  /*0x040014A7*/
    IL_0031: ldc.i4.0
    IL_0032: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0037: ret
    IL_0038: ldloc.0
    IL_0039: callvirt string LevelInfo::get_displayModeDescription()  /*0x060008E1*/
    IL_003e: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0043: ldc.i4.0
    IL_0044: ble.s IL_00ab
    IL_0046: ldarg.0
    IL_0047: ldfld TextMeshProUGUI ModeRulesDisplay::rulesDisplay  /*0x040014A6*/
    IL_004c: ldc.i4.6
    IL_004d: newarr System.String  /*0x0100001D*/
    IL_0052: dup
    IL_0053: ldc.i4.0
    IL_0054: ldstr "<size="
    IL_0059: stelem.ref
    IL_005a: dup
    IL_005b: ldc.i4.1
    IL_005c: ldc.i4.s 20
    IL_005e: stloc.1
    IL_005f: ldloca.s 1
    IL_0061: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0066: stelem.ref
    IL_0067: dup
    IL_0068: ldc.i4.2
    IL_0069: ldstr "><style=Subheader>"
    IL_006e: stelem.ref
    IL_006f: dup
    IL_0070: ldc.i4.3
    IL_0071: ldloc.0
    IL_0072: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0077: stelem.ref
    IL_0078: dup
    IL_0079: ldc.i4.4
    IL_007a: ldstr ":</size></style>\n"
    IL_007f: stelem.ref
    IL_0080: dup
    IL_0081: ldc.i4.5
    IL_0082: ldloc.0
    IL_0083: callvirt string LevelInfo::get_displayModeDescription()  /*0x060008E1*/
    IL_0088: stelem.ref
    IL_0089: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_008e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0093: ldarg.0
    IL_0094: ldfld GameObject ModeRulesDisplay::modeRulePanel  /*0x040014A7*/
    IL_0099: ldc.i4.1
    IL_009a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009f: ldarg.0
    IL_00a0: ldfld UIParentResizer ModeRulesDisplay::sizer  /*0x040014A8*/
    IL_00a5: callvirt void UIParentResizer::Trigger()  /*0x0600131B*/
    IL_00aa: ret
    IL_00ab: ldarg.0
    IL_00ac: ldfld GameObject ModeRulesDisplay::modeRulePanel  /*0x040014A7*/
    IL_00b1: ldc.i4.0
    IL_00b2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b7: ret

  .method ModeRulesDisplay::.ctor()  // token 0x0600114E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

