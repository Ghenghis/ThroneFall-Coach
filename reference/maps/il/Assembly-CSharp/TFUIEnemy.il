// ===== TFUIEnemy  (token 0x0200034A) =====
  .method TFUIEnemy::get_Data()  // token 0x060011E1 rva 0x56395 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld WaveEnemyInfo TFUIEnemy::enemyInfoData  /*0x0400159D*/
    IL_0006: ret

  .method TFUIEnemy::Start()  // token 0x060011E2 rva 0x5639d attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0013: ldfld UnityEvent SettingsManager::onArachnophobiaModeChange  /*0x04000FF8*/
    IL_0018: ldarg.0
    IL_0019: ldftn void TFUIEnemy::SetSpriteIcon()  /*0x060011E4*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ret

  .method TFUIEnemy::SetDataSimple(WaveEnemyInfo)  // token 0x060011E3 rva 0x563c8 attrs Public, HideBySig
    // code size 269 (0x10d), max stack 3, init locals
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
    IL_0028: stfld WaveEnemyInfo TFUIEnemy::enemyInfoData  /*0x0400159D*/
    IL_002d: ldarg.0
    IL_002e: ldarg.1
    IL_002f: ldfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_0034: stfld Sprite TFUIEnemy::arachnophobiaSprite  /*0x0400159F*/
    IL_0039: ldarg.0
    IL_003a: ldarg.1
    IL_003b: ldfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_0040: stfld Sprite TFUIEnemy::defaultEnemySprite  /*0x0400159E*/
    IL_0045: ldarg.0
    IL_0046: call void TFUIEnemy::SetSpriteIcon()  /*0x060011E4*/
    IL_004b: ldarg.0
    IL_004c: ldarg.0
    IL_004d: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0052: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0057: stfld Color TFUIUnit::defaultBGColor  /*0x04001643*/
    IL_005c: ldarg.0
    IL_005d: ldarg.0
    IL_005e: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0063: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0068: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_006d: ldarg.0
    IL_006e: ldfld TextMeshProUGUI TFUIUnit::numberText  /*0x0400164E*/
    IL_0073: ldarg.1
    IL_0074: ldflda int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0079: call string System.Int32::ToString()  /*0x0A000031*/
    IL_007e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0083: ldarg.0
    IL_0084: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_0089: ldarg.1
    IL_008a: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_008f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0094: ldarg.0
    IL_0095: ldfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_009a: ldarg.1
    IL_009b: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_00a0: ldc.i4.0
    IL_00a1: ceq
    IL_00a3: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_00a8: ldarg.1
    IL_00a9: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_00ae: brfalse.s IL_00de
    IL_00b0: ldarg.0
    IL_00b1: ldarg.0
    IL_00b2: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_00b7: stfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00c2: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_00c7: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00cc: ldarg.0
    IL_00cd: ldarg.0
    IL_00ce: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00d3: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_00d8: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_00dd: ret
    IL_00de: ldarg.0
    IL_00df: ldarg.0
    IL_00e0: ldfld MPImageBasic TFUIUnit::originalBackground  /*0x0400164B*/
    IL_00e5: stfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00ea: ldarg.0
    IL_00eb: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_00f0: ldarg.0
    IL_00f1: ldfld Color TFUIUnit::originalIconColor  /*0x04001647*/
    IL_00f6: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00fb: ldarg.0
    IL_00fc: ldarg.0
    IL_00fd: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0102: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0107: stfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_010c: ret

  .method TFUIEnemy::SetSpriteIcon()  // token 0x060011E4 rva 0x564e4 attrs Private, HideBySig
    // code size 76 (0x4c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0006: ldarg.0
    IL_0007: ldfld Sprite TFUIEnemy::defaultEnemySprite  /*0x0400159E*/
    IL_000c: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0011: ldarg.0
    IL_0012: ldfld Sprite TFUIEnemy::arachnophobiaSprite  /*0x0400159F*/
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001d: brfalse.s IL_0020
    IL_001f: ret
    IL_0020: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0025: ldnull
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brfalse.s IL_002e
    IL_002d: ret
    IL_002e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0033: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0038: brfalse.s IL_004b
    IL_003a: ldarg.0
    IL_003b: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0040: ldarg.0
    IL_0041: ldfld Sprite TFUIEnemy::arachnophobiaSprite  /*0x0400159F*/
    IL_0046: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_004b: ret

  .method TFUIEnemy::.ctor()  // token 0x060011E5 rva 0x5653c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUIUnit::.ctor()  /*0x06001290*/
    IL_0006: ret

