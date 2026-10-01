// ===== LevelData  (token 0x020001D0) =====
  .method LevelData::SaveScoreAndStatsToBestIfBest(bool)  // token 0x06000951 rva 0x2c684 attrs Public, HideBySig
    // code size 169 (0xa9), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld bool LevelData::beaten  /*0x04000BBD*/
    IL_0007: brtrue.s IL_0011
    IL_0009: ldarg.0
    IL_000a: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_000f: br.s IL_0012
    IL_0011: ldc.i4.1
    IL_0012: stfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_0017: ldarg.0
    IL_0018: ldfld int LevelData::highscore  /*0x04000BBE*/
    IL_001d: ldarg.0
    IL_001e: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_0023: ble.s IL_0053
    IL_0025: ldarg.0
    IL_0026: ldarg.0
    IL_0027: ldfld int LevelData::highscore  /*0x04000BBE*/
    IL_002c: stfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: ldfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_0038: newobj void System.Collections.Generic.List<int>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000119*/
    IL_003d: stfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: ldfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_0049: newobj void System.Collections.Generic.List<int>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000119*/
    IL_004e: stfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_0053: ldarg.1
    IL_0054: brfalse.s IL_0078
    IL_0056: ldarg.0
    IL_0057: ldfld bool LevelData::beaten  /*0x04000BBD*/
    IL_005c: brfalse.s IL_0078
    IL_005e: ldarg.0
    IL_005f: ldfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_0064: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0069: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_006e: newobj void System.Collections.Generic.List<Equippable>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000430*/
    IL_0073: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::Add(!0)  /*0x0A000431*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.0
    IL_007a: stfld bool LevelData::beaten  /*0x04000BBD*/
    IL_007f: ldarg.0
    IL_0080: ldc.i4.0
    IL_0081: stfld int LevelData::highscore  /*0x04000BBE*/
    IL_0086: ldarg.0
    IL_0087: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_008c: stfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_0091: ldarg.0
    IL_0092: ldfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_0097: ldc.i4.0
    IL_0098: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_009d: ldarg.0
    IL_009e: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_00a3: stfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_00a8: ret

  .method LevelData::.ctor()  // token 0x06000952 rva 0x2c739 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0006: stfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0011: stfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_001c: stfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0027: stfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<System.Collections.Generic.List<Equippable>>::.ctor()  /*0x0A000432*/
    IL_0032: stfld List<List<Equippable>> LevelData::levelHasBeenBeatenWith  /*0x04000BC5*/
    IL_0037: ldarg.0
    IL_0038: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003d: ret

