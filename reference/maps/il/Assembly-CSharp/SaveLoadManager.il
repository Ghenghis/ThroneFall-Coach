// ===== SaveLoadManager  (token 0x020001DD) =====
  .method SaveLoadManager::get_SaveFileName()  // token 0x060009B0 rva 0x2d3fd attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadManager::saveFileName  /*0x04000C67*/
    IL_0006: ret

  .method SaveLoadManager::Awake()  // token 0x060009B1 rva 0x2d405 attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0018
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001e: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0023: ldarg.0
    IL_0024: stsfld SaveLoadManager SaveLoadManager::instance  /*0x04000C65*/
    IL_0029: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_002e: callvirt void Thronefall.SaveServices.ISaveServices::Initialize()  /*0x06003DD4*/
    IL_0033: ret

  .method SaveLoadManager::Start()  // token 0x060009B2 rva 0x2d43a attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void SaveLoadManager::LoadGame(bool)  /*0x060009B8*/
    IL_0007: ret

  .method SaveLoadManager::Update()  // token 0x060009B3 rva 0x2d443 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0005: callvirt void Thronefall.SaveServices.ISaveServices::Update()  /*0x06003DD6*/
    IL_000a: ret

  .method SaveLoadManager::DebugLoadMaxedOutSave()  // token 0x060009B4 rva 0x2d44f attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void SaveLoadManager::LoadGame(bool)  /*0x060009B8*/
    IL_0007: ret

  .method SaveLoadManager::SaveGame()  // token 0x060009B5 rva 0x2d458 attrs Public, HideBySig
    // code size 618 (0x26a), max stack 4, init locals
    .locals ([0] int, [1] Dictionary.Enumerator<string, LevelData>, [2] KeyValuePair<string, LevelData>, [3] string, [4] LevelData, [5] List.Enumerator<List<Equippable>>, [6] List<string>, [7] List.Enumerator<Equippable>, [8] Equippable)
    IL_0000: call bool DebugController::get_SaveTheGame()  /*0x060003D1*/
    IL_0005: brtrue.s IL_0013
    IL_0007: ldarg.0
    IL_0008: ldstr "Saving is not enabled!"
    IL_000d: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_0012: ret
    IL_0013: ldarg.0
    IL_0014: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0019: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_001e: ldarg.0
    IL_001f: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0024: stfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_0029: ldarg.0
    IL_002a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_002f: stfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0034: ldarg.0
    IL_0035: ldstr "Save File Version"
    IL_003a: ldarg.0
    IL_003b: ldflda int SaveLoadManager::saveFileVersionNr  /*0x04000C66*/
    IL_0040: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0045: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_004a: ldarg.0
    IL_004b: ldstr "Perk Level"
    IL_0050: ldarg.0
    IL_0051: ldfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0056: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_005b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0060: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_0065: ldarg.0
    IL_0066: ldstr "Perk XP"
    IL_006b: ldarg.0
    IL_006c: ldfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0071: ldflda int PerkManager::xp  /*0x04000BEB*/
    IL_0076: call string System.Int32::ToString()  /*0x0A000031*/
    IL_007b: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_0080: ldarg.0
    IL_0081: ldstr "Eternal Trials Score V3"
    IL_0086: ldarg.0
    IL_0087: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_008c: callvirt int LevelProgressManager::get_EternalTrialsHighscore()  /*0x06000942*/
    IL_0091: stloc.0
    IL_0092: ldloca.s 0
    IL_0094: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0099: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_009e: ldarg.0
    IL_009f: ldstr "Tips Shown"
    IL_00a4: ldarg.0
    IL_00a5: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_00aa: ldfld List<string> LevelProgressManager::tipsShown  /*0x04000BBA*/
    IL_00af: call void SaveLoadManager::SaveList(string,System.Collections.Generic.List<!!0>)<string>  /*0x2B00009D*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_00ba: callvirt SceneNameToLevelData LevelProgressManager::get_SceneNameToLevelData()  /*0x06000946*/
    IL_00bf: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<string, LevelData>::GetEnumerator()  /*0x0A00045C*/
    IL_00c4: stloc.1
    IL_00c5: br IL_020d
    IL_00ca: ldloca.s 1
    IL_00cc: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<string, LevelData>::get_Current()  /*0x0A00045D*/
    IL_00d1: stloc.2
    IL_00d2: ldloca.s 2
    IL_00d4: call !0 System.Collections.Generic.KeyValuePair<string, LevelData>::get_Key()  /*0x0A00045E*/
    IL_00d9: stloc.3
    IL_00da: ldloca.s 2
    IL_00dc: call !1 System.Collections.Generic.KeyValuePair<string, LevelData>::get_Value()  /*0x0A00045F*/
    IL_00e1: stloc.s 4
    IL_00e3: ldloc.s 4
    IL_00e5: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_00ea: ldc.i4.0
    IL_00eb: bgt.s IL_00f9
    IL_00ed: ldloc.s 4
    IL_00ef: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_00f4: brfalse IL_020d
    IL_00f9: ldarg.0
    IL_00fa: ldstr "Level"
    IL_00ff: ldloc.3
    IL_0100: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_0105: ldarg.0
    IL_0106: ldstr "QuestsCompleteWhenLastOnMap"
    IL_010b: ldloc.s 4
    IL_010d: ldflda int LevelData::questsCompleteWhenLastVisitingMap  /*0x04000BBC*/
    IL_0112: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0117: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_011c: ldarg.0
    IL_011d: ldstr "Beaten"
    IL_0122: ldloc.s 4
    IL_0124: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_0129: brtrue.s IL_0132
    IL_012b: ldstr "0"
    IL_0130: br.s IL_0137
    IL_0132: ldstr "1"
    IL_0137: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_013c: ldloc.s 4
    IL_013e: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_0143: brfalse.s IL_014b
    IL_0145: ldloc.3
    IL_0146: call void AchievementManager::LevelBeaten(string)  /*0x06000913*/
    IL_014b: ldarg.0
    IL_014c: ldstr "HighscoreV2"
    IL_0151: ldloc.s 4
    IL_0153: ldflda int LevelData::highscoreBest  /*0x04000BC2*/
    IL_0158: call string System.Int32::ToString()  /*0x0A000031*/
    IL_015d: call void SaveLoadManager::SaveSingle(string,string)  /*0x060009B6*/
    IL_0162: ldarg.0
    IL_0163: ldstr "NetworthV2 / Day"
    IL_0168: ldloc.s 4
    IL_016a: ldfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_016f: call void SaveLoadManager::SaveList(string,System.Collections.Generic.List<!!0>)<int>  /*0x2B00009E*/
    IL_0174: ldarg.0
    IL_0175: ldstr "ScoreV2 / Day"
    IL_017a: ldloc.s 4
    IL_017c: ldfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_0181: call void SaveLoadManager::SaveList(string,System.Collections.Generic.List<!!0>)<int>  /*0x2B00009E*/
    IL_0186: ldloc.s 4
    IL_0188: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_018d: callvirt List.Enumerator<!0> System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::GetEnumerator()  /*0x0A000460*/
    IL_0192: stloc.s 5
    IL_0194: br.s IL_01f4
    IL_0196: ldloca.s 5
    IL_0198: call !0 System.Collections.Generic.List.Enumerator<System.Collections.Generic.List<Equippable>>::get_Current()  /*0x0A000461*/
    IL_019d: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_01a2: stloc.s 6
    IL_01a4: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_01a9: stloc.s 7
    IL_01ab: br.s IL_01ce
    IL_01ad: ldloca.s 7
    IL_01af: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_01b4: stloc.s 8
    IL_01b6: ldloc.s 8
    IL_01b8: ldnull
    IL_01b9: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_01be: brtrue.s IL_01ce
    IL_01c0: ldloc.s 6
    IL_01c2: ldloc.s 8
    IL_01c4: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_01c9: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_01ce: ldloca.s 7
    IL_01d0: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_01d5: brtrue.s IL_01ad
    IL_01d7: leave.s IL_01e7
    IL_01d9: ldloca.s 7
    IL_01db: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_01e1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01e6: endfinally
    IL_01e7: ldarg.0
    IL_01e8: ldstr "Beaten With"
    IL_01ed: ldloc.s 6
    IL_01ef: call void SaveLoadManager::SaveList(string,System.Collections.Generic.List<!!0>)<string>  /*0x2B00009D*/
    IL_01f4: ldloca.s 5
    IL_01f6: call bool System.Collections.Generic.List.Enumerator<System.Collections.Generic.List<Equippable>>::MoveNext()  /*0x0A000462*/
    IL_01fb: brtrue.s IL_0196
    IL_01fd: leave.s IL_020d
    IL_01ff: ldloca.s 5
    IL_0201: constrained. System.Collections.Generic.List.Enumerator<System.Collections.Generic.List<Equippable>>  /*0x1B0000D1*/
    IL_0207: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_020c: endfinally
    IL_020d: ldloca.s 1
    IL_020f: call bool System.Collections.Generic.Dictionary.Enumerator<string, LevelData>::MoveNext()  /*0x0A000463*/
    IL_0214: brtrue IL_00ca
    IL_0219: leave.s IL_0229
    IL_021b: ldloca.s 1
    IL_021d: constrained. System.Collections.Generic.Dictionary.Enumerator<string, LevelData>  /*0x1B0000CF*/
    IL_0223: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0228: endfinally
    IL_0229: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_022e: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0233: ldarg.0
    IL_0234: call string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_0239: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_023e: ldarg.0
    IL_023f: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0244: callvirt void Thronefall.SaveServices.ISaveServices::WriteAllLinesSafe(string,System.Collections.Generic.IEnumerable<string>)  /*0x06003DDA*/
    IL_0249: ldarg.0
    IL_024a: ldstr "Game Saved to "
    IL_024f: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0254: ldarg.0
    IL_0255: call string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_025a: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_025f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0264: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_0269: ret
    .try IL_01ab-IL_01d9 finally handler IL_01d9-IL_01e7
    .try IL_0194-IL_01ff finally handler IL_01ff-IL_020d
    .try IL_00c5-IL_021b finally handler IL_021b-IL_0229

  .method SaveLoadManager::SaveSingle(string,string)  // token 0x060009B6 rva 0x2d71c attrs Public, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0006: ldarg.1
    IL_0007: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0012: ldarg.2
    IL_0013: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0018: ldarg.0
    IL_0019: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_001e: ldstr ""
    IL_0023: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0028: ret

  .method SaveLoadManager::SaveList(string,System.Collections.Generic.List<!!0>)  // token 0x060009B7 rva 0x2d748 attrs Public, HideBySig
    // code size 103 (0x67), max stack 3, init locals
    .locals ([0] int, [1] int, [2] !!0)
    IL_0000: ldarg.0
    IL_0001: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0006: ldarg.1
    IL_0007: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_0012: ldarg.2
    IL_0013: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_0018: stloc.0
    IL_0019: ldloca.s 0
    IL_001b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0020: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0025: ldc.i4.0
    IL_0026: stloc.1
    IL_0027: br.s IL_004d
    IL_0029: ldarg.0
    IL_002a: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_002f: ldarg.2
    IL_0030: ldloc.1
    IL_0031: callvirt !0 System.Collections.Generic.List<!!0>::get_Item(int)  /*0x0A000357*/
    IL_0036: stloc.2
    IL_0037: ldloca.s 2
    IL_0039: constrained. !!0  /*0x1B00009D*/
    IL_003f: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_0044: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0049: ldloc.1
    IL_004a: ldc.i4.1
    IL_004b: add
    IL_004c: stloc.1
    IL_004d: ldloc.1
    IL_004e: ldarg.2
    IL_004f: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_0054: blt.s IL_0029
    IL_0056: ldarg.0
    IL_0057: ldfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_005c: ldstr ""
    IL_0061: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0066: ret

  .method SaveLoadManager::LoadGame(bool)  // token 0x060009B8 rva 0x2d7bc attrs Private, HideBySig
    // code size 1344 (0x540), max stack 6, init locals
    .locals ([0] LevelData, [1] int, [2] List<Equippable>, [3] string, [4] uint, [5] int, [6] int, [7] int, [8] int, [9] string, [10] Equippable, [11] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0006: stfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_000b: ldarg.0
    IL_000c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0011: stfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0016: call DebugController.SaveLoadMode DebugController::get_SaveLoadModeToUse()  /*0x060003D0*/
    IL_001b: ldc.i4.1
    IL_001c: bne.un.s IL_0067
    IL_001e: ldarg.0
    IL_001f: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0024: ldfld TextAsset DebugController::emptySaveFile  /*0x040004D3*/
    IL_0029: callvirt string UnityEngine.TextAsset::get_text()  /*0x0A000464*/
    IL_002e: ldc.i4.3
    IL_002f: newarr System.String  /*0x0100001D*/
    IL_0034: dup
    IL_0035: ldc.i4.0
    IL_0036: ldstr "\r\n"
    IL_003b: stelem.ref
    IL_003c: dup
    IL_003d: ldc.i4.1
    IL_003e: ldstr "\r"
    IL_0043: stelem.ref
    IL_0044: dup
    IL_0045: ldc.i4.2
    IL_0046: ldstr "\n"
    IL_004b: stelem.ref
    IL_004c: ldc.i4.0
    IL_004d: callvirt string[] System.String::Split(string[],System.StringSplitOptions)  /*0x0A000465*/
    IL_0052: stfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_0057: ldarg.0
    IL_0058: ldstr "Loading is not enabled!"
    IL_005d: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_0062: br IL_0107
    IL_0067: call DebugController.SaveLoadMode DebugController::get_SaveLoadModeToUse()  /*0x060003D0*/
    IL_006c: ldc.i4.2
    IL_006d: ceq
    IL_006f: ldarg.1
    IL_0070: or
    IL_0071: brfalse.s IL_00b9
    IL_0073: ldarg.0
    IL_0074: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0079: ldfld TextAsset DebugController::maxedSaveFile  /*0x040004D4*/
    IL_007e: callvirt string UnityEngine.TextAsset::get_text()  /*0x0A000464*/
    IL_0083: ldc.i4.3
    IL_0084: newarr System.String  /*0x0100001D*/
    IL_0089: dup
    IL_008a: ldc.i4.0
    IL_008b: ldstr "\r\n"
    IL_0090: stelem.ref
    IL_0091: dup
    IL_0092: ldc.i4.1
    IL_0093: ldstr "\r"
    IL_0098: stelem.ref
    IL_0099: dup
    IL_009a: ldc.i4.2
    IL_009b: ldstr "\n"
    IL_00a0: stelem.ref
    IL_00a1: ldc.i4.0
    IL_00a2: callvirt string[] System.String::Split(string[],System.StringSplitOptions)  /*0x0A000465*/
    IL_00a7: stfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_00ac: ldarg.0
    IL_00ad: ldstr "Loading maxed out save file with everything unlocked!"
    IL_00b2: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_00b7: br.s IL_0107
    IL_00b9: nop
    IL_00ba: ldarg.0
    IL_00bb: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_00c0: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_00c5: ldarg.0
    IL_00c6: call string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_00cb: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_00d0: callvirt string[] Thronefall.SaveServices.ISaveServices::ReadAllLinesSafe(string)  /*0x06003DDD*/
    IL_00d5: stfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_00da: leave.s IL_0107
    IL_00dc: pop
    IL_00dd: ldarg.0
    IL_00de: ldstr "No save file was found at "
    IL_00e3: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_00e8: ldarg.0
    IL_00e9: call string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_00ee: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_00f3: ldstr " so the load process was canceled."
    IL_00f8: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_00fd: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_0102: leave IL_053f
    IL_0107: ldnull
    IL_0108: stloc.0
    IL_0109: ldarg.0
    IL_010a: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_010f: callvirt SceneNameToLevelData LevelProgressManager::get_SceneNameToLevelData()  /*0x06000946*/
    IL_0114: callvirt void System.Collections.Generic.Dictionary<string, LevelData>::Clear()  /*0x0A000466*/
    IL_0119: ldarg.0
    IL_011a: ldc.i4.0
    IL_011b: stfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_0120: br IL_050c
    IL_0125: ldarg.0
    IL_0126: ldarg.0
    IL_0127: ldfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_012c: ldarg.0
    IL_012d: ldfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_0132: ldelem.ref
    IL_0133: stfld string SaveLoadManager::line  /*0x04000C6E*/
    IL_0138: ldarg.0
    IL_0139: ldfld string SaveLoadManager::line  /*0x04000C6E*/
    IL_013e: stloc.3
    IL_013f: ldloc.3
    IL_0140: call uint <PrivateImplementationDetails>::ComputeStringHash(string)  /*0x060043F8*/
    IL_0145: stloc.s 4
    IL_0147: ldloc.s 4
    IL_0149: ldc.i4 1343983731
    IL_014e: bgt.un.s IL_019c
    IL_0150: ldloc.s 4
    IL_0152: ldc.i4 1096112509
    IL_0157: bgt.un.s IL_0176
    IL_0159: ldloc.s 4
    IL_015b: ldc.i4 334231268
    IL_0160: beq IL_0248
    IL_0165: ldloc.s 4
    IL_0167: ldc.i4 1096112509
    IL_016c: beq IL_0233
    IL_0171: br IL_04fe
    IL_0176: ldloc.s 4
    IL_0178: ldc.i4 1261565511
    IL_017d: beq IL_021e
    IL_0182: ldloc.s 4
    IL_0184: ldc.i4 1269395570
    IL_0189: beq.s IL_01f4
    IL_018b: ldloc.s 4
    IL_018d: ldc.i4 1343983731
    IL_0192: beq IL_029c
    IL_0197: br IL_04fe
    IL_019c: ldloc.s 4
    IL_019e: ldc.i4 -2097188678
    IL_01a3: bgt.un.s IL_01ce
    IL_01a5: ldloc.s 4
    IL_01a7: ldc.i4 1966058922
    IL_01ac: beq IL_0272
    IL_01b1: ldloc.s 4
    IL_01b3: ldc.i4 2111981737
    IL_01b8: beq IL_0287
    IL_01bd: ldloc.s 4
    IL_01bf: ldc.i4 -2097188678
    IL_01c4: beq IL_02c6
    IL_01c9: br IL_04fe
    IL_01ce: ldloc.s 4
    IL_01d0: ldc.i4 -532214606
    IL_01d5: beq IL_025d
    IL_01da: ldloc.s 4
    IL_01dc: ldc.i4 -110019561
    IL_01e1: beq.s IL_0209
    IL_01e3: ldloc.s 4
    IL_01e5: ldc.i4 -99512314
    IL_01ea: beq IL_02b1
    IL_01ef: br IL_04fe
    IL_01f4: ldloc.3
    IL_01f5: ldstr "Tips Shown"
    IL_01fa: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_01ff: brtrue IL_02db
    IL_0204: br IL_04fe
    IL_0209: ldloc.3
    IL_020a: ldstr "Perk Level"
    IL_020f: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0214: brtrue IL_0322
    IL_0219: br IL_04fe
    IL_021e: ldloc.3
    IL_021f: ldstr "Perk XP"
    IL_0224: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0229: brtrue IL_033d
    IL_022e: br IL_04fe
    IL_0233: ldloc.3
    IL_0234: ldstr "Level"
    IL_0239: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_023e: brtrue IL_0358
    IL_0243: br IL_04fe
    IL_0248: ldloc.3
    IL_0249: ldstr "Eternal Trials Score V3"
    IL_024e: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0253: brtrue IL_036f
    IL_0258: br IL_04fe
    IL_025d: ldloc.3
    IL_025e: ldstr "QuestsCompleteWhenLastOnMap"
    IL_0263: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0268: brtrue IL_038a
    IL_026d: br IL_04fe
    IL_0272: ldloc.3
    IL_0273: ldstr "Beaten"
    IL_0278: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_027d: brtrue IL_03a6
    IL_0282: br IL_04fe
    IL_0287: ldloc.3
    IL_0288: ldstr "HighscoreV2"
    IL_028d: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0292: brtrue IL_03c7
    IL_0297: br IL_04fe
    IL_029c: ldloc.3
    IL_029d: ldstr "NetworthV2 / Day"
    IL_02a2: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_02a7: brtrue IL_03e3
    IL_02ac: br IL_04fe
    IL_02b1: ldloc.3
    IL_02b2: ldstr "ScoreV2 / Day"
    IL_02b7: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_02bc: brtrue IL_042b
    IL_02c1: br IL_04fe
    IL_02c6: ldloc.3
    IL_02c7: ldstr "Beaten With"
    IL_02cc: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_02d1: brtrue IL_0473
    IL_02d6: br IL_04fe
    IL_02db: ldarg.0
    IL_02dc: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_02e1: ldfld List<string> LevelProgressManager::tipsShown  /*0x04000BBA*/
    IL_02e6: callvirt void System.Collections.Generic.List<string>::Clear()  /*0x0A00045B*/
    IL_02eb: ldarg.0
    IL_02ec: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_02f1: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_02f6: stloc.1
    IL_02f7: ldc.i4.0
    IL_02f8: stloc.s 5
    IL_02fa: br.s IL_0318
    IL_02fc: ldarg.0
    IL_02fd: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_0302: ldfld List<string> LevelProgressManager::tipsShown  /*0x04000BBA*/
    IL_0307: ldarg.0
    IL_0308: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_030d: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0312: ldloc.s 5
    IL_0314: ldc.i4.1
    IL_0315: add
    IL_0316: stloc.s 5
    IL_0318: ldloc.s 5
    IL_031a: ldloc.1
    IL_031b: blt.s IL_02fc
    IL_031d: br IL_04fe
    IL_0322: ldarg.0
    IL_0323: ldfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0328: ldarg.0
    IL_0329: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_032e: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_0333: stfld int PerkManager::level  /*0x04000BEC*/
    IL_0338: br IL_04fe
    IL_033d: ldarg.0
    IL_033e: ldfld PerkManager SaveLoadManager::perkManager  /*0x04000C6B*/
    IL_0343: ldarg.0
    IL_0344: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0349: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_034e: stfld int PerkManager::xp  /*0x04000BEB*/
    IL_0353: br IL_04fe
    IL_0358: ldarg.0
    IL_0359: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_035e: ldarg.0
    IL_035f: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0364: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0369: stloc.0
    IL_036a: br IL_04fe
    IL_036f: ldarg.0
    IL_0370: ldfld LevelProgressManager SaveLoadManager::levelProgressManager  /*0x04000C6A*/
    IL_0375: ldarg.0
    IL_0376: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_037b: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_0380: callvirt void LevelProgressManager::set_EternalTrialsHighscore(int)  /*0x06000943*/
    IL_0385: br IL_04fe
    IL_038a: ldloc.0
    IL_038b: brfalse IL_04fe
    IL_0390: ldloc.0
    IL_0391: ldarg.0
    IL_0392: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0397: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_039c: stfld int LevelData::questsCompleteWhenLastVisitingMap  /*0x04000BBC*/
    IL_03a1: br IL_04fe
    IL_03a6: ldloc.0
    IL_03a7: brfalse IL_04fe
    IL_03ac: ldloc.0
    IL_03ad: ldarg.0
    IL_03ae: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_03b3: ldstr "1"
    IL_03b8: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_03bd: stfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_03c2: br IL_04fe
    IL_03c7: ldloc.0
    IL_03c8: brfalse IL_04fe
    IL_03cd: ldloc.0
    IL_03ce: ldarg.0
    IL_03cf: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_03d4: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_03d9: stfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_03de: br IL_04fe
    IL_03e3: ldloc.0
    IL_03e4: brfalse IL_04fe
    IL_03e9: ldarg.0
    IL_03ea: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_03ef: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_03f4: stloc.1
    IL_03f5: ldloc.0
    IL_03f6: ldfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_03fb: callvirt void System.Collections.Generic.List<int>::Clear()  /*0x0A0000F5*/
    IL_0400: ldc.i4.0
    IL_0401: stloc.s 6
    IL_0403: br.s IL_0421
    IL_0405: ldloc.0
    IL_0406: ldfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_040b: ldarg.0
    IL_040c: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0411: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_0416: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_041b: ldloc.s 6
    IL_041d: ldc.i4.1
    IL_041e: add
    IL_041f: stloc.s 6
    IL_0421: ldloc.s 6
    IL_0423: ldloc.1
    IL_0424: blt.s IL_0405
    IL_0426: br IL_04fe
    IL_042b: ldloc.0
    IL_042c: brfalse IL_04fe
    IL_0431: ldarg.0
    IL_0432: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0437: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_043c: stloc.1
    IL_043d: ldloc.0
    IL_043e: ldfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_0443: callvirt void System.Collections.Generic.List<int>::Clear()  /*0x0A0000F5*/
    IL_0448: ldc.i4.0
    IL_0449: stloc.s 7
    IL_044b: br.s IL_0469
    IL_044d: ldloc.0
    IL_044e: ldfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_0453: ldarg.0
    IL_0454: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0459: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_045e: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0463: ldloc.s 7
    IL_0465: ldc.i4.1
    IL_0466: add
    IL_0467: stloc.s 7
    IL_0469: ldloc.s 7
    IL_046b: ldloc.1
    IL_046c: blt.s IL_044d
    IL_046e: br IL_04fe
    IL_0473: ldloc.0
    IL_0474: brfalse IL_04fe
    IL_0479: ldarg.0
    IL_047a: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_047f: call int System.Int32::Parse(string)  /*0x0A000467*/
    IL_0484: stloc.1
    IL_0485: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_048a: stloc.2
    IL_048b: ldc.i4.0
    IL_048c: stloc.s 8
    IL_048e: br.s IL_04ed
    IL_0490: ldarg.0
    IL_0491: call string SaveLoadManager::ReadNextLn()  /*0x060009B9*/
    IL_0496: stloc.s 9
    IL_0498: ldnull
    IL_0499: stloc.s 10
    IL_049b: ldc.i4.0
    IL_049c: stloc.s 11
    IL_049e: br.s IL_04d0
    IL_04a0: ldarg.0
    IL_04a1: ldfld List<Equippable> SaveLoadManager::allEquippablesID  /*0x04000C6C*/
    IL_04a6: ldloc.s 11
    IL_04a8: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_04ad: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_04b2: ldloc.s 9
    IL_04b4: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_04b9: brfalse.s IL_04ca
    IL_04bb: ldarg.0
    IL_04bc: ldfld List<Equippable> SaveLoadManager::allEquippablesID  /*0x04000C6C*/
    IL_04c1: ldloc.s 11
    IL_04c3: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_04c8: stloc.s 10
    IL_04ca: ldloc.s 11
    IL_04cc: ldc.i4.1
    IL_04cd: add
    IL_04ce: stloc.s 11
    IL_04d0: ldloc.s 11
    IL_04d2: ldarg.0
    IL_04d3: ldfld List<Equippable> SaveLoadManager::allEquippablesID  /*0x04000C6C*/
    IL_04d8: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_04dd: blt.s IL_04a0
    IL_04df: ldloc.2
    IL_04e0: ldloc.s 10
    IL_04e2: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_04e7: ldloc.s 8
    IL_04e9: ldc.i4.1
    IL_04ea: add
    IL_04eb: stloc.s 8
    IL_04ed: ldloc.s 8
    IL_04ef: ldloc.1
    IL_04f0: blt.s IL_0490
    IL_04f2: ldloc.0
    IL_04f3: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_04f8: ldloc.2
    IL_04f9: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::Add(!0)  /*0x0A000431*/
    IL_04fe: ldarg.0
    IL_04ff: ldarg.0
    IL_0500: ldfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_0505: ldc.i4.1
    IL_0506: add
    IL_0507: stfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_050c: ldarg.0
    IL_050d: ldfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_0512: ldarg.0
    IL_0513: ldfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_0518: ldlen
    IL_0519: conv.i4
    IL_051a: blt IL_0125
    IL_051f: ldarg.0
    IL_0520: ldstr "Loaded Game from "
    IL_0525: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_052a: ldarg.0
    IL_052b: call string SaveLoadManager::get_SaveFileName()  /*0x060009B0*/
    IL_0530: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0535: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_053a: call void SaveLoadManager::DebugLogInEditorOnly(string)  /*0x060009BA*/
    IL_053f: ret
    .try IL_00ba-IL_00dc catch System.Object handler IL_00dc-IL_0107

  .method SaveLoadManager::ReadNextLn()  // token 0x060009B9 rva 0x2dd18 attrs Private, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_0007: ldc.i4.1
    IL_0008: add
    IL_0009: stfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld string[] SaveLoadManager::loadData  /*0x04000C69*/
    IL_0015: ldarg.0
    IL_0016: ldfld int SaveLoadManager::iln  /*0x04000C6D*/
    IL_001b: ldelem.ref
    IL_001c: stfld string SaveLoadManager::line  /*0x04000C6E*/
    IL_0021: ldarg.0
    IL_0022: ldfld string SaveLoadManager::line  /*0x04000C6E*/
    IL_0027: ret

  .method SaveLoadManager::DebugLogInEditorOnly(string)  // token 0x060009BA rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SaveLoadManager::.ctor()  // token 0x060009BB rva 0x2dd41 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int SaveLoadManager::saveFileVersionNr  /*0x04000C66*/
    IL_0007: ldarg.0
    IL_0008: ldstr "ThroneSave.sav"
    IL_000d: stfld string SaveLoadManager::saveFileName  /*0x04000C67*/
    IL_0012: ldarg.0
    IL_0013: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0018: stfld List<string> SaveLoadManager::saveData  /*0x04000C68*/
    IL_001d: ldarg.0
    IL_001e: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0023: stfld List<Equippable> SaveLoadManager::allEquippablesID  /*0x04000C6C*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002e: ret

