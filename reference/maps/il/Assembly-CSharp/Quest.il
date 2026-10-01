// ===== Quest  (token 0x0200024F) =====
  .method Quest::get_IsBeatLevelWith()  // token 0x06000CA2 rva 0x39f44 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method Quest::get_IsAchieveScoreOf()  // token 0x06000CA3 rva 0x39f4f attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_0006: ldc.i4.2
    IL_0007: ceq
    IL_0009: ret

  .method Quest::get_IsBeatLevelWithout()  // token 0x06000CA4 rva 0x39f5a attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_0006: ldc.i4.3
    IL_0007: ceq
    IL_0009: ret

  .method Quest::CheckBeaten(LevelData)  // token 0x06000CA5 rva 0x39f68 attrs Public, HideBySig
    // code size 333 (0x14d), max stack 3, init locals
    .locals ([0] List<Equippable>, [1] Quest.EType, [2] bool, [3] int, [4] List<Equippable>, [5] int, [6] int, [7] int, [8] List<Equippable>, [9] bool, [10] int)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: ldfld List<Equippable> PerkManager::countQuestsAsIncompleteWith  /*0x04000BE9*/
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_0011: stloc.1
    IL_0012: ldloc.1
    IL_0013: switch (IL_002d, IL_0050, IL_0039, IL_00ce)
    IL_0028: br IL_0142
    IL_002d: ldarg.1
    IL_002e: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_0033: stloc.2
    IL_0034: leave IL_014b
    IL_0039: ldarg.1
    IL_003a: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_003f: ldarg.0
    IL_0040: ldfld int Quest::achieveScoreOf  /*0x04000F50*/
    IL_0045: clt
    IL_0047: ldc.i4.0
    IL_0048: ceq
    IL_004a: stloc.2
    IL_004b: leave IL_014b
    IL_0050: ldc.i4.0
    IL_0051: stloc.3
    IL_0052: br.s IL_00bc
    IL_0054: ldarg.1
    IL_0055: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_005a: ldloc.3
    IL_005b: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::get_Item(int)  /*0x0A00051A*/
    IL_0060: stloc.s 4
    IL_0062: ldarg.0
    IL_0063: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0068: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_006d: stloc.s 5
    IL_006f: ldc.i4.0
    IL_0070: stloc.s 6
    IL_0072: br.s IL_00ad
    IL_0074: ldarg.0
    IL_0075: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_007a: ldloc.s 4
    IL_007c: ldloc.s 6
    IL_007e: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_0083: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0088: brfalse.s IL_0090
    IL_008a: ldloc.s 5
    IL_008c: ldc.i4.1
    IL_008d: sub
    IL_008e: stloc.s 5
    IL_0090: ldloc.s 5
    IL_0092: ldc.i4.0
    IL_0093: bgt.s IL_00a7
    IL_0095: ldarg.0
    IL_0096: ldloc.s 4
    IL_0098: ldloc.0
    IL_0099: call bool Quest::ContainsAnyItemsFromList(System.Collections.Generic.List<Equippable>,System.Collections.Generic.List<Equippable>)  /*0x06000CA6*/
    IL_009e: brtrue.s IL_00a7
    IL_00a0: ldc.i4.1
    IL_00a1: stloc.2
    IL_00a2: leave IL_014b
    IL_00a7: ldloc.s 6
    IL_00a9: ldc.i4.1
    IL_00aa: add
    IL_00ab: stloc.s 6
    IL_00ad: ldloc.s 6
    IL_00af: ldloc.s 4
    IL_00b1: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_00b6: blt.s IL_0074
    IL_00b8: ldloc.3
    IL_00b9: ldc.i4.1
    IL_00ba: add
    IL_00bb: stloc.3
    IL_00bc: ldloc.3
    IL_00bd: ldarg.1
    IL_00be: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_00c3: callvirt int System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::get_Count()  /*0x0A00051B*/
    IL_00c8: blt.s IL_0054
    IL_00ca: ldc.i4.0
    IL_00cb: stloc.2
    IL_00cc: leave.s IL_014b
    IL_00ce: ldc.i4.0
    IL_00cf: stloc.s 7
    IL_00d1: br.s IL_012f
    IL_00d3: ldarg.1
    IL_00d4: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_00d9: ldloc.s 7
    IL_00db: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::get_Item(int)  /*0x0A00051A*/
    IL_00e0: stloc.s 8
    IL_00e2: ldc.i4.1
    IL_00e3: stloc.s 9
    IL_00e5: ldc.i4.0
    IL_00e6: stloc.s 10
    IL_00e8: br.s IL_010b
    IL_00ea: ldarg.0
    IL_00eb: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_00f0: ldloc.s 8
    IL_00f2: ldloc.s 10
    IL_00f4: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_00f9: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_00fe: brfalse.s IL_0105
    IL_0100: ldc.i4.0
    IL_0101: stloc.s 9
    IL_0103: br.s IL_0116
    IL_0105: ldloc.s 10
    IL_0107: ldc.i4.1
    IL_0108: add
    IL_0109: stloc.s 10
    IL_010b: ldloc.s 10
    IL_010d: ldloc.s 8
    IL_010f: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0114: blt.s IL_00ea
    IL_0116: ldloc.s 9
    IL_0118: brfalse.s IL_0129
    IL_011a: ldarg.0
    IL_011b: ldloc.s 8
    IL_011d: ldloc.0
    IL_011e: call bool Quest::ContainsAnyItemsFromList(System.Collections.Generic.List<Equippable>,System.Collections.Generic.List<Equippable>)  /*0x06000CA6*/
    IL_0123: brtrue.s IL_0129
    IL_0125: ldc.i4.1
    IL_0126: stloc.2
    IL_0127: leave.s IL_014b
    IL_0129: ldloc.s 7
    IL_012b: ldc.i4.1
    IL_012c: add
    IL_012d: stloc.s 7
    IL_012f: ldloc.s 7
    IL_0131: ldarg.1
    IL_0132: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_0137: callvirt int System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::get_Count()  /*0x0A00051B*/
    IL_013c: blt.s IL_00d3
    IL_013e: ldc.i4.0
    IL_013f: stloc.2
    IL_0140: leave.s IL_014b
    IL_0142: ldc.i4.0
    IL_0143: stloc.2
    IL_0144: leave.s IL_014b
    IL_0146: pop
    IL_0147: ldc.i4.0
    IL_0148: stloc.2
    IL_0149: leave.s IL_014b
    IL_014b: ldloc.2
    IL_014c: ret
    .try IL_0000-IL_0146 catch System.Object handler IL_0146-IL_014b

  .method Quest::ContainsAnyItemsFromList(System.Collections.Generic.List<Equippable>,System.Collections.Generic.List<Equippable>)  // token 0x06000CA6 rva 0x3a0e0 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 2, init locals
    .locals ([0] List.Enumerator<Equippable>, [1] Equippable, [2] bool)
    IL_0000: ldarg.2
    IL_0001: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0006: stloc.0
    IL_0007: br.s IL_001e
    IL_0009: ldloca.s 0
    IL_000b: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0010: stloc.1
    IL_0011: ldarg.1
    IL_0012: ldloc.1
    IL_0013: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0018: brfalse.s IL_001e
    IL_001a: ldc.i4.1
    IL_001b: stloc.2
    IL_001c: leave.s IL_0039
    IL_001e: ldloca.s 0
    IL_0020: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0025: brtrue.s IL_0009
    IL_0027: leave.s IL_0037
    IL_0029: ldloca.s 0
    IL_002b: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0031: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0036: endfinally
    IL_0037: ldc.i4.0
    IL_0038: ret
    IL_0039: ldloc.2
    IL_003a: ret
    .try IL_0007-IL_0029 finally handler IL_0029-IL_0037

  .method Quest::GetMissionStatement()  // token 0x06000CA7 rva 0x3a138 attrs Public, HideBySig
    // code size 309 (0x135), max stack 5, init locals
    .locals ([0] string, [1] Quest.EType, [2] List.Enumerator<Equippable>, [3] Equippable, [4] Equippable)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_000c: stloc.1
    IL_000d: ldloc.1
    IL_000e: switch (IL_0051, IL_0065, IL_0028, IL_00cc)
    IL_0023: br IL_0133
    IL_0028: ldstr "Achieve Score"
    IL_002d: ldc.i4.1
    IL_002e: ldc.i4.0
    IL_002f: ldc.i4.1
    IL_0030: ldc.i4.1
    IL_0031: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0036: ldstr " "
    IL_003b: ldarg.0
    IL_003c: ldflda int Quest::achieveScoreOf  /*0x04000F50*/
    IL_0041: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0046: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_004b: stloc.0
    IL_004c: br IL_0133
    IL_0051: ldstr "Achieve Victory"
    IL_0056: ldc.i4.1
    IL_0057: ldc.i4.0
    IL_0058: ldc.i4.1
    IL_0059: ldc.i4.1
    IL_005a: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_005f: stloc.0
    IL_0060: br IL_0133
    IL_0065: ldstr "Achieve Victory With"
    IL_006a: ldc.i4.1
    IL_006b: ldc.i4.0
    IL_006c: ldc.i4.1
    IL_006d: ldc.i4.1
    IL_006e: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0073: stloc.0
    IL_0074: ldarg.0
    IL_0075: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_007a: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_007f: stloc.2
    IL_0080: br.s IL_00a1
    IL_0082: ldloca.s 2
    IL_0084: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0089: stloc.3
    IL_008a: ldloc.0
    IL_008b: ldstr " "
    IL_0090: ldloc.3
    IL_0091: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0096: ldstr " +"
    IL_009b: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_00a0: stloc.0
    IL_00a1: ldloca.s 2
    IL_00a3: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_00a8: brtrue.s IL_0082
    IL_00aa: leave.s IL_00ba
    IL_00ac: ldloca.s 2
    IL_00ae: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_00b4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b9: endfinally
    IL_00ba: ldloc.0
    IL_00bb: ldloc.0
    IL_00bc: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_00c1: ldc.i4.1
    IL_00c2: sub
    IL_00c3: ldc.i4.1
    IL_00c4: callvirt string System.String::Remove(int,int)  /*0x0A00051C*/
    IL_00c9: stloc.0
    IL_00ca: br.s IL_0133
    IL_00cc: ldstr "Achieve Victory Without"
    IL_00d1: ldc.i4.1
    IL_00d2: ldc.i4.0
    IL_00d3: ldc.i4.1
    IL_00d4: ldc.i4.1
    IL_00d5: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00da: stloc.0
    IL_00db: ldarg.0
    IL_00dc: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_00e1: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_00e6: stloc.2
    IL_00e7: br.s IL_010a
    IL_00e9: ldloca.s 2
    IL_00eb: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_00f0: stloc.s 4
    IL_00f2: ldloc.0
    IL_00f3: ldstr " "
    IL_00f8: ldloc.s 4
    IL_00fa: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_00ff: ldstr " +"
    IL_0104: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0109: stloc.0
    IL_010a: ldloca.s 2
    IL_010c: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0111: brtrue.s IL_00e9
    IL_0113: leave.s IL_0123
    IL_0115: ldloca.s 2
    IL_0117: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_011d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0122: endfinally
    IL_0123: ldloc.0
    IL_0124: ldloc.0
    IL_0125: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_012a: ldc.i4.1
    IL_012b: sub
    IL_012c: ldc.i4.1
    IL_012d: callvirt string System.String::Remove(int,int)  /*0x0A00051C*/
    IL_0132: stloc.0
    IL_0133: ldloc.0
    IL_0134: ret
    .try IL_0080-IL_00ac finally handler IL_00ac-IL_00ba
    .try IL_00e7-IL_0115 finally handler IL_0115-IL_0123

  .method Quest::.ctor()  // token 0x06000CA8 rva 0x3a298 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0006: stfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0011: stfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ret

// ===== Quest/EType  (token 0x02000250) =====
