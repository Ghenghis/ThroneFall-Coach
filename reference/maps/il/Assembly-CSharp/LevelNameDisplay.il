// ===== LevelNameDisplay  (token 0x0200031C) =====
  .method LevelNameDisplay::UpdateLevelTitle()  // token 0x06001127 rva 0x5038c attrs Public, HideBySig
    // code size 164 (0xa4), max stack 5, init locals
    .locals ([0] LevelInfo, [1] TextMeshProUGUI)
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
    IL_0029: brfalse.s IL_002c
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: ldfld TextMeshProUGUI LevelNameDisplay::levelTitle  /*0x0400146E*/
    IL_0032: ldloc.0
    IL_0033: callvirt string LevelInfo::get_LocalizedDisplayName()  /*0x060008DF*/
    IL_0038: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_003d: ldloc.0
    IL_003e: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0043: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0048: ldc.i4.0
    IL_0049: ble.s IL_00a3
    IL_004b: ldarg.0
    IL_004c: ldfld bool LevelNameDisplay::displaySubtitle  /*0x0400146F*/
    IL_0051: brfalse.s IL_00a3
    IL_0053: ldarg.0
    IL_0054: ldfld TextMeshProUGUI LevelNameDisplay::levelTitle  /*0x0400146E*/
    IL_0059: stloc.1
    IL_005a: ldloc.1
    IL_005b: ldc.i4.6
    IL_005c: newarr System.String  /*0x0100001D*/
    IL_0061: dup
    IL_0062: ldc.i4.0
    IL_0063: ldloc.1
    IL_0064: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0069: stelem.ref
    IL_006a: dup
    IL_006b: ldc.i4.1
    IL_006c: ldstr "\n<size="
    IL_0071: stelem.ref
    IL_0072: dup
    IL_0073: ldc.i4.2
    IL_0074: ldarg.0
    IL_0075: ldflda float LevelNameDisplay::untertitleSize  /*0x04001470*/
    IL_007a: call string System.Single::ToString()  /*0x0A00030C*/
    IL_007f: stelem.ref
    IL_0080: dup
    IL_0081: ldc.i4.3
    IL_0082: ldstr "><style=Subheader>"
    IL_0087: stelem.ref
    IL_0088: dup
    IL_0089: ldc.i4.4
    IL_008a: ldloc.0
    IL_008b: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0090: stelem.ref
    IL_0091: dup
    IL_0092: ldc.i4.5
    IL_0093: ldstr "</size></style>"
    IL_0098: stelem.ref
    IL_0099: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_009e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00a3: ret

  .method LevelNameDisplay::.ctor()  // token 0x06001128 rva 0x5043c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float LevelNameDisplay::untertitleSize  /*0x04001470*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

