// ===== MatchSaveLoadHandler  (token 0x0200025D) =====
  .method MatchSaveLoadHandler::get_SavePath()  // token 0x06000CEF rva 0x3b1fd attrs Private, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: ldsfld string MatchSaveLoadHandler::currentMap  /*0x04000F8A*/
    IL_0005: ldstr ".json"
    IL_000a: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_000f: ret

  .method MatchSaveLoadHandler::get_SaveLoadForbidden()  // token 0x06000CF0 rva 0x3b20e attrs Public, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: ldsfld string MatchSaveLoadHandler::currentMap  /*0x04000F8A*/
    IL_0005: ldstr "Neuland(Tutorial)"
    IL_000a: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_000f: ret

  .method MatchSaveLoadHandler::get_CurrentSave()  // token 0x06000CF1 rva 0x3b21f attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0005: ret

  .method MatchSaveLoadHandler::get_IsLoadingPermitted()  // token 0x06000CF2 rva 0x3b228 attrs Public, Static, HideBySig, SpecialName
    // code size 68 (0x44), max stack 2, init locals
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: brfalse.s IL_000e
    IL_0007: ldsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_000c: brfalse.s IL_0010
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0015: ldc.i4.1
    IL_0016: bne.un.s IL_0042
    IL_0018: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001d: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_0022: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0027: ldfld int MatchSave::etSeed  /*0x04000F8D*/
    IL_002c: bne.un.s IL_003a
    IL_002e: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0033: ldfld bool EternalTrialsRun::runComplete  /*0x04000851*/
    IL_0038: brfalse.s IL_0042
    IL_003a: ldc.i4.1
    IL_003b: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0040: ldc.i4.0
    IL_0041: ret
    IL_0042: ldc.i4.1
    IL_0043: ret

  .method MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  // token 0x06000CF3 rva 0x3b278 attrs Public, Static, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "_"
    IL_0006: ldarg.1
    IL_0007: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_000c: ret

  .method MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)  // token 0x06000CF4 rva 0x3b286 attrs Public, Static, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: brtrue.s IL_0009
    IL_0007: ldc.i4.0
    IL_0008: ret
    IL_0009: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_000e: ldarg.0
    IL_000f: ldarg.1
    IL_0010: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_0015: ldarg.2
    IL_0016: callvirt bool MatchSave::TryLoadValue(string,ref !!0)<!!0>  /*0x2B0000BC*/
    IL_001b: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,string)  // token 0x06000CF5 rva 0x3b2a3 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<string>  /*0x2B0000BD*/
    IL_0012: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,int)  // token 0x06000CF6 rva 0x3b2b7 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<int>  /*0x2B0000BE*/
    IL_0012: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,float)  // token 0x06000CF7 rva 0x3b2cb attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<float>  /*0x2B0000BF*/
    IL_0012: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,bool)  // token 0x06000CF8 rva 0x3b2df attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<bool>  /*0x2B0000C0*/
    IL_0012: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,int[])  // token 0x06000CF9 rva 0x3b2f3 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<int[]>  /*0x2B0000C1*/
    IL_0012: ret

  .method MatchSaveLoadHandler::SaveValue(string,string,TagManager.ETag[])  // token 0x06000CFA rva 0x3b307 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0005: ldarg.0
    IL_0006: ldarg.1
    IL_0007: call string MatchSaveLoadHandler::GetPathFromIdentifierAndGUID(string,string)  /*0x06000CF3*/
    IL_000c: ldarg.2
    IL_000d: callvirt void MatchSave::AddValue(string,!!0)<TagManager.ETag[]>  /*0x2B0000C2*/
    IL_0012: ret

  .method MatchSaveLoadHandler::InitializeCurrentSave()  // token 0x06000CFB rva 0x3b31b attrs Public, Static, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0005: brfalse.s IL_000e
    IL_0007: ldsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_000c: brfalse.s IL_0018
    IL_000e: newobj void MatchSave::.ctor()  /*0x06000D07*/
    IL_0013: stsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0018: ldc.i4.0
    IL_0019: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_001e: ret

  .method MatchSaveLoadHandler::SaveRun()  // token 0x06000CFC rva 0x3b33c attrs Public, Static, HideBySig
    // code size 92 (0x5c), max stack 3, init locals
    .locals ([0] string)
    IL_0000: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0005: brtrue.s IL_0012
    IL_0007: ldstr "No data found to save."
    IL_000c: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0011: ret
    IL_0012: nop
    IL_0013: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0018: callvirt void MatchSave::ConvertObjectDataToStrings()  /*0x06000D03*/
    IL_001d: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0022: call string UnityEngine.JsonUtility::ToJson(object)  /*0x0A0002D4*/
    IL_0027: stloc.0
    IL_0028: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_002d: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0032: call string MatchSaveLoadHandler::get_SavePath()  /*0x06000CEF*/
    IL_0037: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_003c: ldloc.0
    IL_003d: callvirt void Thronefall.SaveServices.ISaveServices::WriteAllText(string,string)  /*0x06003DDB*/
    IL_0042: ldstr "Match Data successfully saved."
    IL_0047: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_004c: leave.s IL_005b
    IL_004e: pop
    IL_004f: ldstr "There has been an error while trying to save the current match data."
    IL_0054: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0059: leave.s IL_005b
    IL_005b: ret
    .try IL_0013-IL_004e catch System.Object handler IL_004e-IL_005b

  .method MatchSaveLoadHandler::MarkRunCompleteAndSave()  // token 0x06000CFD rva 0x3b3b4 attrs Public, Static, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_000d: ldc.i4.1
    IL_000e: stfld bool MatchSave::runComplete  /*0x04000F8F*/
    IL_0013: call void MatchSaveLoadHandler::SaveRun()  /*0x06000CFC*/
    IL_0018: ret

  .method MatchSaveLoadHandler::TryLoadRun(string)  // token 0x06000CFE rva 0x3b3d0 attrs Public, Static, HideBySig
    // code size 140 (0x8c), max stack 3, init locals
    .locals ([0] Exception)
    IL_0000: ldarg.0
    IL_0001: stsfld string MatchSaveLoadHandler::currentMap  /*0x04000F8A*/
    IL_0006: ldnull
    IL_0007: stsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_000c: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0011: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0016: call string MatchSaveLoadHandler::get_SavePath()  /*0x06000CEF*/
    IL_001b: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0020: callvirt bool Thronefall.SaveServices.ISaveServices::Exists(string)  /*0x06003DD8*/
    IL_0025: brfalse.s IL_0060
    IL_0027: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_002c: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0031: call string MatchSaveLoadHandler::get_SavePath()  /*0x06000CEF*/
    IL_0036: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_003b: callvirt string Thronefall.SaveServices.ISaveServices::ReadAllText(string)  /*0x06003DDE*/
    IL_0040: call !!0 UnityEngine.JsonUtility::FromJson(string)<MatchSave>  /*0x2B0000C3*/
    IL_0045: stsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_004a: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_004f: callvirt void MatchSave::ConvertStringsToObjectData()  /*0x06000D04*/
    IL_0054: ldstr "Match Save loaded."
    IL_0059: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_005e: br.s IL_006a
    IL_0060: ldstr "No Save Data for Match found."
    IL_0065: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_006a: leave.s IL_008b
    IL_006c: stloc.0
    IL_006d: ldstr "There has been an error while trying to load the current match save."
    IL_0072: ldloc.0
    IL_0073: dup
    IL_0074: brtrue.s IL_007a
    IL_0076: pop
    IL_0077: ldnull
    IL_0078: br.s IL_007f
    IL_007a: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_007f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0084: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0089: leave.s IL_008b
    IL_008b: ret
    .try IL_000c-IL_006c catch System.Exception handler IL_006c-IL_008b

  .method MatchSaveLoadHandler::SubmitScoreAndSave(int)  // token 0x06000CFF rva 0x3b478 attrs Public, Static, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldarg.0
    IL_0009: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_000e: ldfld int MatchSave::highestScoreThisRun  /*0x04000F8E*/
    IL_0013: ble.s IL_0020
    IL_0015: ldsfld MatchSave MatchSaveLoadHandler::currentSave  /*0x04000F8B*/
    IL_001a: ldarg.0
    IL_001b: stfld int MatchSave::highestScoreThisRun  /*0x04000F8E*/
    IL_0020: call void MatchSaveLoadHandler::SaveRun()  /*0x06000CFC*/
    IL_0025: ret

  .method MatchSaveLoadHandler::.cctor()  // token 0x06000D00 rva 0x3b49f attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldstr "Neuland(Tutorial)"
    IL_0005: stsfld string MatchSaveLoadHandler::currentMap  /*0x04000F8A*/
    IL_000a: ldc.i4.0
    IL_000b: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0010: ret

