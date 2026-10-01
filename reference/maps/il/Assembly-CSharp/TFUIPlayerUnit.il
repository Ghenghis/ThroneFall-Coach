// ===== TFUIPlayerUnit  (token 0x02000355) =====
  .method TFUIPlayerUnit::get_Data()  // token 0x0600122E rva 0x57531 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnitInfo TFUIPlayerUnit::enemyInfoData  /*0x040015E6*/
    IL_0006: ret

  .method TFUIPlayerUnit::SetDataSimple(UnitInfo)  // token 0x0600122F rva 0x5753c attrs Public, HideBySig
    // code size 256 (0x100), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0026
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0015: stfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_0021: stfld Color TFUIUnit::originalIconColor  /*0x04001647*/
    IL_0026: ldarg.0
    IL_0027: ldarg.1
    IL_0028: stfld UnitInfo TFUIPlayerUnit::enemyInfoData  /*0x040015E6*/
    IL_002d: ldarg.0
    IL_002e: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0033: ldarg.1
    IL_0034: ldfld Sprite UnitInfo::unitIcon  /*0x040017EC*/
    IL_0039: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0045: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_004a: stfld Color TFUIUnit::defaultBGColor  /*0x04001643*/
    IL_004f: ldarg.0
    IL_0050: ldarg.0
    IL_0051: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0056: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_005b: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_0060: ldarg.0
    IL_0061: ldfld TextMeshProUGUI TFUIUnit::numberText  /*0x0400164E*/
    IL_0066: ldarg.1
    IL_0067: ldflda int UnitInfo::unitCount  /*0x040017EF*/
    IL_006c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0071: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0076: ldarg.0
    IL_0077: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_007c: ldarg.1
    IL_007d: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_0082: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0087: ldarg.0
    IL_0088: ldfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_008d: ldarg.1
    IL_008e: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_0093: ldc.i4.0
    IL_0094: ceq
    IL_0096: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_009b: ldarg.1
    IL_009c: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_00a1: brfalse.s IL_00d1
    IL_00a3: ldarg.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_00aa: stfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00af: ldarg.0
    IL_00b0: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00b5: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_00ba: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00bf: ldarg.0
    IL_00c0: ldarg.0
    IL_00c1: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00c6: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_00cb: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_00d0: ret
    IL_00d1: ldarg.0
    IL_00d2: ldarg.0
    IL_00d3: ldfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_00d8: stfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00dd: ldarg.0
    IL_00de: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld Color TFUIUnit::originalIconColor  /*0x04001647*/
    IL_00e9: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00ee: ldarg.0
    IL_00ef: ldarg.0
    IL_00f0: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00f5: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_00fa: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_00ff: ret

  .method TFUIPlayerUnit::.ctor()  // token 0x06001230 rva 0x5653c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUIUnit::.ctor()  /*0x06001290*/
    IL_0006: ret

