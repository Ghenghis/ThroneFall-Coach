// ===== TFUIIncomeDisplay  (token 0x02000351) =====
  .method TFUIIncomeDisplay::get_CurrentIncome()  // token 0x06001219 rva 0x56de5 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int TFUIIncomeDisplay::currentIncome  /*0x040015D2*/
    IL_0006: ret

  .method TFUIIncomeDisplay::GetTitle()  // token 0x0600121A rva 0x56ded attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldstr "Menu/Gold Income"
    IL_0005: ldc.i4.1
    IL_0006: ldc.i4.0
    IL_0007: ldc.i4.1
    IL_0008: ldc.i4.0
    IL_0009: ldnull
    IL_000a: ldnull
    IL_000b: ldc.i4.1
    IL_000c: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0011: ret

  .method TFUIIncomeDisplay::GetDescription()  // token 0x0600121B rva 0x56e00 attrs Public, HideBySig
    // code size 437 (0x1b5), max stack 11, init locals
    .locals ([0] string)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldstr "\n"
    IL_000c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0011: stloc.0
    IL_0012: ldc.i4.5
    IL_0013: newarr System.String  /*0x0100001D*/
    IL_0018: dup
    IL_0019: ldc.i4.0
    IL_001a: ldloc.0
    IL_001b: stelem.ref
    IL_001c: dup
    IL_001d: ldc.i4.1
    IL_001e: ldstr "Menu/Income From Buildings"
    IL_0023: ldc.i4.1
    IL_0024: ldc.i4.0
    IL_0025: ldc.i4.1
    IL_0026: ldc.i4.0
    IL_0027: ldnull
    IL_0028: ldnull
    IL_0029: ldc.i4.1
    IL_002a: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_002f: stelem.ref
    IL_0030: dup
    IL_0031: ldc.i4.2
    IL_0032: ldstr " <sprite name=arrow_right> <sprite name=coin><style=Body Numerals>"
    IL_0037: stelem.ref
    IL_0038: dup
    IL_0039: ldc.i4.3
    IL_003a: ldarg.0
    IL_003b: ldflda int TFUIIncomeDisplay::iFromBuildings  /*0x040015CD*/
    IL_0040: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0045: stelem.ref
    IL_0046: dup
    IL_0047: ldc.i4.4
    IL_0048: ldstr "</style>"
    IL_004d: stelem.ref
    IL_004e: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0053: stloc.0
    IL_0054: ldloc.0
    IL_0055: ldstr "\n"
    IL_005a: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_005f: stloc.0
    IL_0060: ldarg.0
    IL_0061: ldfld int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_0066: ldc.i4.0
    IL_0067: ble.s IL_00b7
    IL_0069: ldc.i4.5
    IL_006a: newarr System.String  /*0x0100001D*/
    IL_006f: dup
    IL_0070: ldc.i4.0
    IL_0071: ldloc.0
    IL_0072: stelem.ref
    IL_0073: dup
    IL_0074: ldc.i4.1
    IL_0075: ldstr "Building/Castle Center Choice Builder's Guild"
    IL_007a: ldc.i4.1
    IL_007b: ldc.i4.0
    IL_007c: ldc.i4.1
    IL_007d: ldc.i4.0
    IL_007e: ldnull
    IL_007f: ldnull
    IL_0080: ldc.i4.1
    IL_0081: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0086: stelem.ref
    IL_0087: dup
    IL_0088: ldc.i4.2
    IL_0089: ldstr " <sprite name=arrow_right> <sprite name=coin><style=Body Numerals>"
    IL_008e: stelem.ref
    IL_008f: dup
    IL_0090: ldc.i4.3
    IL_0091: ldarg.0
    IL_0092: ldflda int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_0097: call string System.Int32::ToString()  /*0x0A000031*/
    IL_009c: stelem.ref
    IL_009d: dup
    IL_009e: ldc.i4.4
    IL_009f: ldstr "</style>"
    IL_00a4: stelem.ref
    IL_00a5: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_00aa: stloc.0
    IL_00ab: ldloc.0
    IL_00ac: ldstr "\n"
    IL_00b1: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b6: stloc.0
    IL_00b7: ldarg.0
    IL_00b8: ldfld int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_00bd: ldc.i4.0
    IL_00be: ble.s IL_010e
    IL_00c0: ldc.i4.5
    IL_00c1: newarr System.String  /*0x0100001D*/
    IL_00c6: dup
    IL_00c7: ldc.i4.0
    IL_00c8: ldloc.0
    IL_00c9: stelem.ref
    IL_00ca: dup
    IL_00cb: ldc.i4.1
    IL_00cc: ldstr "Equippable/Treasure Hunter"
    IL_00d1: ldc.i4.1
    IL_00d2: ldc.i4.0
    IL_00d3: ldc.i4.1
    IL_00d4: ldc.i4.0
    IL_00d5: ldnull
    IL_00d6: ldnull
    IL_00d7: ldc.i4.1
    IL_00d8: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_00dd: stelem.ref
    IL_00de: dup
    IL_00df: ldc.i4.2
    IL_00e0: ldstr " <sprite name=arrow_right> <sprite name=coin><style=Body Numerals>"
    IL_00e5: stelem.ref
    IL_00e6: dup
    IL_00e7: ldc.i4.3
    IL_00e8: ldarg.0
    IL_00e9: ldflda int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_00ee: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00f3: stelem.ref
    IL_00f4: dup
    IL_00f5: ldc.i4.4
    IL_00f6: ldstr "</style>"
    IL_00fb: stelem.ref
    IL_00fc: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0101: stloc.0
    IL_0102: ldloc.0
    IL_0103: ldstr "\n"
    IL_0108: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_010d: stloc.0
    IL_010e: ldarg.0
    IL_010f: ldfld int TFUIIncomeDisplay::iFromInterest  /*0x040015CE*/
    IL_0114: ldc.i4.0
    IL_0115: ble.s IL_0165
    IL_0117: ldc.i4.5
    IL_0118: newarr System.String  /*0x0100001D*/
    IL_011d: dup
    IL_011e: ldc.i4.0
    IL_011f: ldloc.0
    IL_0120: stelem.ref
    IL_0121: dup
    IL_0122: ldc.i4.1
    IL_0123: ldstr "Equippable/Interest"
    IL_0128: ldc.i4.1
    IL_0129: ldc.i4.0
    IL_012a: ldc.i4.1
    IL_012b: ldc.i4.0
    IL_012c: ldnull
    IL_012d: ldnull
    IL_012e: ldc.i4.1
    IL_012f: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0134: stelem.ref
    IL_0135: dup
    IL_0136: ldc.i4.2
    IL_0137: ldstr " <sprite name=arrow_right> <sprite name=coin><style=Body Numerals>"
    IL_013c: stelem.ref
    IL_013d: dup
    IL_013e: ldc.i4.3
    IL_013f: ldarg.0
    IL_0140: ldflda int TFUIIncomeDisplay::iFromInterest  /*0x040015CE*/
    IL_0145: call string System.Int32::ToString()  /*0x0A000031*/
    IL_014a: stelem.ref
    IL_014b: dup
    IL_014c: ldc.i4.4
    IL_014d: ldstr "</style>"
    IL_0152: stelem.ref
    IL_0153: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0158: stloc.0
    IL_0159: ldloc.0
    IL_015a: ldstr "\n"
    IL_015f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0164: stloc.0
    IL_0165: ldc.i4.5
    IL_0166: newarr System.String  /*0x0100001D*/
    IL_016b: dup
    IL_016c: ldc.i4.0
    IL_016d: ldloc.0
    IL_016e: stelem.ref
    IL_016f: dup
    IL_0170: ldc.i4.1
    IL_0171: ldstr "Menu/Income From Enemies"
    IL_0176: ldc.i4.1
    IL_0177: ldc.i4.0
    IL_0178: ldc.i4.1
    IL_0179: ldc.i4.0
    IL_017a: ldnull
    IL_017b: ldnull
    IL_017c: ldc.i4.1
    IL_017d: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0182: stelem.ref
    IL_0183: dup
    IL_0184: ldc.i4.2
    IL_0185: ldstr " <sprite name=arrow_right> <sprite name=coin><style=Body Numerals>"
    IL_018a: stelem.ref
    IL_018b: dup
    IL_018c: ldc.i4.3
    IL_018d: ldarg.0
    IL_018e: ldflda int TFUIIncomeDisplay::iFromEnemies  /*0x040015D1*/
    IL_0193: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0198: stelem.ref
    IL_0199: dup
    IL_019a: ldc.i4.4
    IL_019b: ldstr "</style>"
    IL_01a0: stelem.ref
    IL_01a1: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_01a6: stloc.0
    IL_01a7: ldloc.0
    IL_01a8: ldstr "\n"
    IL_01ad: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_01b2: stloc.0
    IL_01b3: ldloc.0
    IL_01b4: ret

  .method TFUIIncomeDisplay::UpdateData(int)  // token 0x0600121C rva 0x56fc4 attrs Public, HideBySig
    // code size 524 (0x20c), max stack 3, init locals
    .locals ([0] List<TaggedObject>, [1] List<BuildSlot>, [2] BuildSlot, [3] WaveInfo, [4] List.Enumerator<TaggedObject>, [5] List.Enumerator<BuildSlot>, [6] BuildSlot, [7] int)
    IL_0000: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0005: stloc.0
    IL_0006: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_000b: stloc.1
    IL_000c: ldnull
    IL_000d: stloc.2
    IL_000e: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0013: ldloc.0
    IL_0014: ldc.i4.8
    IL_0015: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_001a: ldloc.0
    IL_001b: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0020: stloc.s 4
    IL_0022: br.s IL_0049
    IL_0024: ldloca.s 4
    IL_0026: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_002b: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0030: stloc.2
    IL_0031: ldloc.2
    IL_0032: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0037: brfalse.s IL_0049
    IL_0039: ldloc.2
    IL_003a: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_003f: ldc.i4.1
    IL_0040: bne.un.s IL_0049
    IL_0042: ldloc.1
    IL_0043: ldloc.2
    IL_0044: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_0049: ldloca.s 4
    IL_004b: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0050: brtrue.s IL_0024
    IL_0052: leave.s IL_0062
    IL_0054: ldloca.s 4
    IL_0056: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_005c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0061: endfinally
    IL_0062: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0067: ldloc.0
    IL_0068: ldc.i4.s 44
    IL_006a: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_006f: ldloc.0
    IL_0070: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0075: stloc.s 4
    IL_0077: br.s IL_009e
    IL_0079: ldloca.s 4
    IL_007b: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0080: callvirt !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0085: stloc.2
    IL_0086: ldloc.2
    IL_0087: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_008c: brfalse.s IL_009e
    IL_008e: ldloc.2
    IL_008f: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0094: ldc.i4.1
    IL_0095: bne.un.s IL_009e
    IL_0097: ldloc.1
    IL_0098: ldloc.2
    IL_0099: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_009e: ldloca.s 4
    IL_00a0: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00a5: brtrue.s IL_0079
    IL_00a7: leave.s IL_00b7
    IL_00a9: ldloca.s 4
    IL_00ab: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00b1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b6: endfinally
    IL_00b7: ldarg.0
    IL_00b8: ldc.i4.0
    IL_00b9: stfld int TFUIIncomeDisplay::currentIncome  /*0x040015D2*/
    IL_00be: ldarg.0
    IL_00bf: ldc.i4.0
    IL_00c0: stfld int TFUIIncomeDisplay::iFromBuildings  /*0x040015CD*/
    IL_00c5: ldarg.0
    IL_00c6: ldc.i4.0
    IL_00c7: stfld int TFUIIncomeDisplay::iFromInterest  /*0x040015CE*/
    IL_00cc: ldarg.0
    IL_00cd: ldc.i4.0
    IL_00ce: stfld int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_00d3: ldarg.0
    IL_00d4: ldc.i4.0
    IL_00d5: stfld int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_00da: ldarg.0
    IL_00db: ldc.i4.0
    IL_00dc: stfld int TFUIIncomeDisplay::iFromEnemies  /*0x040015D1*/
    IL_00e1: ldloc.1
    IL_00e2: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_00e7: stloc.s 5
    IL_00e9: br.s IL_0108
    IL_00eb: ldloca.s 5
    IL_00ed: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_00f2: stloc.s 6
    IL_00f4: ldarg.0
    IL_00f5: ldarg.0
    IL_00f6: ldfld int TFUIIncomeDisplay::iFromBuildings  /*0x040015CD*/
    IL_00fb: ldloc.s 6
    IL_00fd: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0102: add
    IL_0103: stfld int TFUIIncomeDisplay::iFromBuildings  /*0x040015CD*/
    IL_0108: ldloca.s 5
    IL_010a: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_010f: brtrue.s IL_00eb
    IL_0111: leave.s IL_0121
    IL_0113: ldloca.s 5
    IL_0115: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_011b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0120: endfinally
    IL_0121: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0126: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_012b: brfalse.s IL_015c
    IL_012d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0132: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0137: brtrue.s IL_015c
    IL_0139: call UpgradeBuildersGuild UpgradeBuildersGuild::get_Instance()  /*0x06000C35*/
    IL_013e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0143: brfalse.s IL_015c
    IL_0145: ldarg.0
    IL_0146: ldarg.0
    IL_0147: ldfld int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_014c: call UpgradeBuildersGuild UpgradeBuildersGuild::get_Instance()  /*0x06000C35*/
    IL_0151: callvirt int UpgradeBuildersGuild::GetIncomeChangeIfNextUpgradeIsPossible()  /*0x06000C3E*/
    IL_0156: add
    IL_0157: stfld int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_015c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0161: callvirt bool PerkManager::get_TreasureHunterActive()  /*0x06000987*/
    IL_0166: brfalse.s IL_0194
    IL_0168: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_016d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0172: brfalse.s IL_0194
    IL_0174: ldc.i4.0
    IL_0175: stloc.s 7
    IL_0177: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_017c: ldarg.1
    IL_017d: ldloca.s 7
    IL_017f: callvirt bool EnemySpawner::GetTreasureHunterBonus(int,ref int)  /*0x0600068C*/
    IL_0184: pop
    IL_0185: ldarg.0
    IL_0186: ldarg.0
    IL_0187: ldfld int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_018c: ldloc.s 7
    IL_018e: add
    IL_018f: stfld int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_0194: ldarg.1
    IL_0195: call WaveInfo EnemySpawner::GetWaveInfoByNumber(int)  /*0x06000695*/
    IL_019a: stloc.3
    IL_019b: ldloc.3
    IL_019c: brfalse.s IL_01b1
    IL_019e: ldarg.0
    IL_019f: ldarg.0
    IL_01a0: ldfld int TFUIIncomeDisplay::iFromEnemies  /*0x040015D1*/
    IL_01a5: ldloc.3
    IL_01a6: ldfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_01ab: add
    IL_01ac: stfld int TFUIIncomeDisplay::iFromEnemies  /*0x040015D1*/
    IL_01b1: ldsfld InterestPerk InterestPerk::instance  /*0x04000A6A*/
    IL_01b6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01bb: brfalse.s IL_01cd
    IL_01bd: ldarg.0
    IL_01be: ldsfld InterestPerk InterestPerk::instance  /*0x04000A6A*/
    IL_01c3: callvirt int InterestPerk::InterestAmount()  /*0x06000869*/
    IL_01c8: stfld int TFUIIncomeDisplay::iFromInterest  /*0x040015CE*/
    IL_01cd: ldarg.0
    IL_01ce: ldarg.0
    IL_01cf: ldfld int TFUIIncomeDisplay::iFromBuildings  /*0x040015CD*/
    IL_01d4: ldarg.0
    IL_01d5: ldfld int TFUIIncomeDisplay::iFromBuildersGuild  /*0x040015CF*/
    IL_01da: add
    IL_01db: ldarg.0
    IL_01dc: ldfld int TFUIIncomeDisplay::iFromTreasureHunter  /*0x040015D0*/
    IL_01e1: add
    IL_01e2: ldarg.0
    IL_01e3: ldfld int TFUIIncomeDisplay::iFromEnemies  /*0x040015D1*/
    IL_01e8: add
    IL_01e9: ldarg.0
    IL_01ea: ldfld int TFUIIncomeDisplay::iFromInterest  /*0x040015CE*/
    IL_01ef: add
    IL_01f0: stfld int TFUIIncomeDisplay::currentIncome  /*0x040015D2*/
    IL_01f5: ldarg.0
    IL_01f6: ldfld TextMeshProUGUI TFUIIncomeDisplay::displayNumber  /*0x040015CC*/
    IL_01fb: ldarg.0
    IL_01fc: ldflda int TFUIIncomeDisplay::currentIncome  /*0x040015D2*/
    IL_0201: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0206: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_020b: ret
    .try IL_0022-IL_0054 finally handler IL_0054-IL_0062
    .try IL_0077-IL_00a9 finally handler IL_00a9-IL_00b7
    .try IL_00e9-IL_0113 finally handler IL_0113-IL_0121

  .method TFUIIncomeDisplay::.ctor()  // token 0x0600121D rva 0x57204 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUIPerklike::.ctor()  /*0x0600122A*/
    IL_0006: ret

