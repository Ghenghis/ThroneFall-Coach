// ===== LevelInfo  (token 0x020001B4) =====
  .method LevelInfo::get_LocalizedDisplayName()  // token 0x060008DF rva 0x2ac16 attrs Public, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldstr "Map Name/"
    IL_0005: ldarg.0
    IL_0006: ldfld string LevelInfo::displayName  /*0x04000B20*/
    IL_000b: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0010: ldc.i4.1
    IL_0011: ldc.i4.0
    IL_0012: ldc.i4.1
    IL_0013: ldc.i4.0
    IL_0014: ldnull
    IL_0015: ldnull
    IL_0016: ldc.i4.1
    IL_0017: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_001c: ret

  .method LevelInfo::get_displaySubtitle()  // token 0x060008E0 rva 0x2ac34 attrs Public, HideBySig, SpecialName
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LevelInfo::useSubtitle  /*0x04000B21*/
    IL_0006: brfalse.s IL_0025
    IL_0008: ldstr "Map/"
    IL_000d: ldarg.0
    IL_000e: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0013: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0018: ldc.i4.1
    IL_0019: ldc.i4.0
    IL_001a: ldc.i4.1
    IL_001b: ldc.i4.0
    IL_001c: ldnull
    IL_001d: ldnull
    IL_001e: ldc.i4.1
    IL_001f: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0024: ret
    IL_0025: ldstr ""
    IL_002a: ret

  .method LevelInfo::get_displayModeDescription()  // token 0x060008E1 rva 0x2ac60 attrs Public, HideBySig, SpecialName
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LevelInfo::useModeDescription  /*0x04000B22*/
    IL_0006: brfalse.s IL_0025
    IL_0008: ldstr "Map Description/"
    IL_000d: ldarg.0
    IL_000e: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0013: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0018: ldc.i4.1
    IL_0019: ldc.i4.0
    IL_001a: ldc.i4.1
    IL_001b: ldc.i4.0
    IL_001c: ldnull
    IL_001d: ldnull
    IL_001e: ldc.i4.1
    IL_001f: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0024: ret
    IL_0025: ldstr ""
    IL_002a: ret

  .method LevelInfo::get_HasFixedLoadout()  // token 0x060008E2 rva 0x2ac8c attrs Public, HideBySig, SpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0006: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_000b: ldc.i4.0
    IL_000c: cgt
    IL_000e: ret

  .method LevelInfo::get_LevelData()  // token 0x060008E3 rva 0x2ac9c attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: ldarg.0
    IL_0006: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_000b: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0010: ret

  .method LevelInfo::QuestsComplete()  // token 0x060008E4 rva 0x2acb0 attrs Public, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    .locals ([0] int, [1] int, [2] Quest)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_0006: brtrue.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: ldc.i4.0
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br.s IL_0036
    IL_0010: ldarg.0
    IL_0011: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_0016: ldloc.1
    IL_0017: callvirt !0 System.Collections.Generic.List<Quest>::get_Item(int)  /*0x0A0003D6*/
    IL_001c: stloc.2
    IL_001d: ldloc.2
    IL_001e: brfalse.s IL_0032
    IL_0020: ldloc.2
    IL_0021: ldarg.0
    IL_0022: call LevelData LevelInfo::get_LevelData()  /*0x060008E3*/
    IL_0027: callvirt bool Quest::CheckBeaten(LevelData)  /*0x06000CA5*/
    IL_002c: brfalse.s IL_0032
    IL_002e: ldloc.0
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: stloc.0
    IL_0032: ldloc.1
    IL_0033: ldc.i4.1
    IL_0034: add
    IL_0035: stloc.1
    IL_0036: ldloc.1
    IL_0037: ldarg.0
    IL_0038: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_003d: callvirt int System.Collections.Generic.List<Quest>::get_Count()  /*0x0A0003D7*/
    IL_0042: blt.s IL_0010
    IL_0044: ldloc.0
    IL_0045: ret

  .method LevelInfo::QuestsTotal()  // token 0x060008E5 rva 0x2ad02 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_0006: brtrue.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_0010: callvirt int System.Collections.Generic.List<Quest>::get_Count()  /*0x0A0003D7*/
    IL_0015: ret

  .method LevelInfo::get_Beaten()  // token 0x060008E6 rva 0x2ad19 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call LevelData LevelInfo::get_LevelData()  /*0x060008E3*/
    IL_0006: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_000b: ret

  .method LevelInfo::.ctor()  // token 0x060008E7 rva 0x2ad26 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Quest>::.ctor()  /*0x0A0003D8*/
    IL_0006: stfld List<Quest> LevelInfo::quests  /*0x04000B29*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0011: stfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.5
    IL_0018: stfld int LevelInfo::maxPerkCount  /*0x04000B2B*/
    IL_001d: ldarg.0
    IL_001e: newobj void System.Collections.Generic.List<VirtualBuilding>::.ctor()  /*0x0A0002C4*/
    IL_0023: stfld List<VirtualBuilding> LevelInfo::virtualBuildings  /*0x04000B2C*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_002e: ret

// ===== LevelInfo/ProgressionContribution  (token 0x020001B5) =====
