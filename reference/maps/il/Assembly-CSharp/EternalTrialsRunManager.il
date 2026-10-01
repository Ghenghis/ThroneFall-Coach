// ===== EternalTrialsRunManager  (token 0x02000145) =====
  .method EternalTrialsRunManager::get_SavePath()  // token 0x060006E9 rva 0x1e72b attrs Private, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr "EternalTrials_V4.json"
    IL_0005: ret

  .method EternalTrialsRunManager::get_CurrentRun()  // token 0x060006EA rva 0x1e732 attrs Public, Static, HideBySig, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_0005: brtrue.s IL_0011
    IL_0007: call EternalTrialsRun EternalTrialsRunManager::TryLoadRun()  /*0x060006EE*/
    IL_000c: stsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_0011: ldsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_0016: brtrue.s IL_001d
    IL_0018: call void EternalTrialsRunManager::CreateFreshRun()  /*0x060006F5*/
    IL_001d: ldsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_0022: ret

  .method EternalTrialsRunManager::get_LastDiscardedRun()  // token 0x060006EB rva 0x1e756 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld EternalTrialsRun EternalTrialsRunManager::lastDiscardedRun  /*0x0400084B*/
    IL_0005: ret

  .method EternalTrialsRunManager::get_HasOngoingRun()  // token 0x060006EC rva 0x1e75d attrs Public, Static, HideBySig, SpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_000a: ldc.i4.0
    IL_000b: bgt.s IL_0019
    IL_000d: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0012: ldfld bool EternalTrialsRun::inGame  /*0x04000852*/
    IL_0017: brfalse.s IL_0027
    IL_0019: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001e: ldfld bool EternalTrialsRun::runComplete  /*0x04000851*/
    IL_0023: ldc.i4.0
    IL_0024: ceq
    IL_0026: ret
    IL_0027: ldc.i4.0
    IL_0028: ret

  .method EternalTrialsRunManager::SaveRun(EternalTrialsRun)  // token 0x060006ED rva 0x1e788 attrs Public, Static, HideBySig
    // code size 59 (0x3b), max stack 3, init locals
    .locals ([0] string)
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: callvirt void EternalTrialsRun::LoadoutToStringsForSaving()  /*0x060006FE*/
    IL_000a: ldarg.0
    IL_000b: call string UnityEngine.JsonUtility::ToJson(object)  /*0x0A0002D4*/
    IL_0010: stloc.0
    IL_0011: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0016: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_001b: call string EternalTrialsRunManager::get_SavePath()  /*0x060006E9*/
    IL_0020: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0025: ldloc.0
    IL_0026: callvirt void Thronefall.SaveServices.ISaveServices::WriteAllText(string,string)  /*0x06003DDB*/
    IL_002b: leave.s IL_003a
    IL_002d: pop
    IL_002e: ldstr "There has been an error while trying to save the Eternal Trials run config."
    IL_0033: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0038: leave.s IL_003a
    IL_003a: ret
    .try IL_0000-IL_002d catch System.Object handler IL_002d-IL_003a

  .method EternalTrialsRunManager::TryLoadRun()  // token 0x060006EE rva 0x1e7e0 attrs Public, Static, HideBySig
    // code size 125 (0x7d), max stack 3, init locals
    .locals ([0] EternalTrialsRun)
    IL_0000: ldstr "EternalTrials_FreshRunSeed"
    IL_0005: call int UnityEngine.PlayerPrefs::GetInt(string)  /*0x0A0002D5*/
    IL_000a: stsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_000f: ldsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_0014: brtrue.s IL_001b
    IL_0016: call void EternalTrialsRunManager::GenerateNewFreshRunSeed()  /*0x060006EF*/
    IL_001b: nop
    IL_001c: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0021: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0026: call string EternalTrialsRunManager::get_SavePath()  /*0x060006E9*/
    IL_002b: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_0030: callvirt bool Thronefall.SaveServices.ISaveServices::Exists(string)  /*0x06003DD8*/
    IL_0035: brfalse.s IL_0068
    IL_0037: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_003c: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0041: call string EternalTrialsRunManager::get_SavePath()  /*0x060006E9*/
    IL_0046: callvirt string Thronefall.SaveServices.ISaveServices::GetFullSavePath(string)  /*0x06003DE1*/
    IL_004b: callvirt string Thronefall.SaveServices.ISaveServices::ReadAllText(string)  /*0x06003DDE*/
    IL_0050: call !!0 UnityEngine.JsonUtility::FromJson(string)<EternalTrialsRun>  /*0x2B000065*/
    IL_0055: dup
    IL_0056: callvirt void EternalTrialsRun::SavedStringsToLoadout()  /*0x060006FF*/
    IL_005b: ldstr "Eternal Trials run loaded."
    IL_0060: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0065: stloc.0
    IL_0066: leave.s IL_007b
    IL_0068: ldnull
    IL_0069: stloc.0
    IL_006a: leave.s IL_007b
    IL_006c: pop
    IL_006d: ldstr "There has been an error while trying to load the Eternal Trials Run."
    IL_0072: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0077: ldnull
    IL_0078: stloc.0
    IL_0079: leave.s IL_007b
    IL_007b: ldloc.0
    IL_007c: ret
    .try IL_001c-IL_006c catch System.Object handler IL_006c-IL_007b

  .method EternalTrialsRunManager::GenerateNewFreshRunSeed()  // token 0x060006EF rva 0x1e87c attrs Public, Static, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: newobj void System.Random::.ctor()  /*0x0A0002D7*/
    IL_0005: ldc.i4 -2147483648
    IL_000a: ldc.i4 2147483647
    IL_000f: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_0014: stsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_0019: ldstr "EternalTrials_FreshRunSeed"
    IL_001e: ldsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_0023: call void UnityEngine.PlayerPrefs::SetInt(string,int)  /*0x0A0002D8*/
    IL_0028: ret

  .method EternalTrialsRunManager::DiscardActiveRun()  // token 0x060006F0 rva 0x1e8a6 attrs Public, Static, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: call bool EternalTrialsRunManager::get_HasOngoingRun()  /*0x060006EC*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000d: stsfld EternalTrialsRun EternalTrialsRunManager::lastDiscardedRun  /*0x0400084B*/
    IL_0012: ret

  .method EternalTrialsRunManager::TurnLastDiscardedRunIntoCurrentRun()  // token 0x060006F1 rva 0x1e8ba attrs Public, Static, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_001a
    IL_000d: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0012: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_0017: brfalse.s IL_001a
    IL_0019: ret
    IL_001a: ldsfld EternalTrialsRun EternalTrialsRunManager::lastDiscardedRun  /*0x0400084B*/
    IL_001f: brtrue.s IL_0022
    IL_0021: ret
    IL_0022: ldsfld EternalTrialsRun EternalTrialsRunManager::lastDiscardedRun  /*0x0400084B*/
    IL_0027: stsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_002c: ret

  .method EternalTrialsRunManager::OnVictory()  // token 0x060006F2 rva 0x1e8e8 attrs Public, Static, HideBySig
    // code size 211 (0xd3), max stack 4, init locals
    .locals ([0] string, [1] int, [2] int)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000b: dup
    IL_000c: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0011: ldc.i4.1
    IL_0012: add
    IL_0013: stfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0018: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001d: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0022: call void AchievementManager::UnlockEternalTrialsAchievementForBeating(int)  /*0x06000910*/
    IL_0027: ldc.i4.0
    IL_0028: stloc.1
    IL_0029: br.s IL_005f
    IL_002b: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0030: ldloc.1
    IL_0031: ldelem.ref
    IL_0032: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0037: ldfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_003c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0041: brfalse.s IL_005b
    IL_0043: ldloc.1
    IL_0044: ldc.i4.1
    IL_0045: add
    IL_0046: stloc.2
    IL_0047: ldloc.2
    IL_0048: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_004d: ldlen
    IL_004e: conv.i4
    IL_004f: blt.s IL_0053
    IL_0051: ldc.i4.0
    IL_0052: stloc.2
    IL_0053: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0058: ldloc.2
    IL_0059: ldelem.ref
    IL_005a: stloc.0
    IL_005b: ldloc.1
    IL_005c: ldc.i4.1
    IL_005d: add
    IL_005e: stloc.1
    IL_005f: ldloc.1
    IL_0060: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0065: ldlen
    IL_0066: conv.i4
    IL_0067: blt.s IL_002b
    IL_0069: ldloc.0
    IL_006a: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_006f: ldc.i4.0
    IL_0070: bgt.s IL_0084
    IL_0072: ldstr "Current map not found in map rotation. Loading first map in rotation"
    IL_0077: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_007c: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0081: ldc.i4.0
    IL_0082: ldelem.ref
    IL_0083: stloc.0
    IL_0084: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0089: ldloc.0
    IL_008a: stfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_008f: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0094: newobj void System.Random::.ctor()  /*0x0A0002D7*/
    IL_0099: ldc.i4 -2147483648
    IL_009e: ldc.i4 2147483647
    IL_00a3: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_00a8: stfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_00ad: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_00b2: ldc.i4.0
    IL_00b3: stfld bool EternalTrialsRun::inGame  /*0x04000852*/
    IL_00b8: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_00bd: ldc.i4.0
    IL_00be: stfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_00c3: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_00c8: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_00cd: call void EternalTrialsRunManager::GenerateNewFreshRunSeed()  /*0x060006EF*/
    IL_00d2: ret

  .method EternalTrialsRunManager::OnDefeat()  // token 0x060006F3 rva 0x1e9c7 attrs Public, Static, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: ldc.i4.1
    IL_0006: stfld bool EternalTrialsRun::runComplete  /*0x04000851*/
    IL_000b: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0010: ldc.i4.0
    IL_0011: stfld bool EternalTrialsRun::inGame  /*0x04000852*/
    IL_0016: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001b: ldc.i4.0
    IL_001c: stfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_0021: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0026: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_002b: call void EternalTrialsRunManager::GenerateNewFreshRunSeed()  /*0x060006EF*/
    IL_0030: ret

  .method EternalTrialsRunManager::LoadNextMap(EternalTrialsRun)  // token 0x060006F4 rva 0x1e9fc attrs Public, Static, HideBySig
    // code size 185 (0xb9), max stack 2, init locals
    .locals ([0] int, [1] List.Enumerator<EquippablePerk>, [2] Equippable)
    IL_0000: ldarg.0
    IL_0001: brtrue.s IL_000a
    IL_0003: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0008: starg.s 0
    IL_000a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_000f: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0014: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0019: ldc.i4.1
    IL_001a: sub
    IL_001b: stloc.0
    IL_001c: br.s IL_0038
    IL_001e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0023: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0028: ldloc.0
    IL_0029: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_002e: ldc.i4.0
    IL_002f: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0034: ldloc.0
    IL_0035: ldc.i4.1
    IL_0036: sub
    IL_0037: stloc.0
    IL_0038: ldloc.0
    IL_0039: ldc.i4.0
    IL_003a: bge.s IL_001e
    IL_003c: ldarg.0
    IL_003d: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0042: callvirt List.Enumerator<!0> System.Collections.Generic.List<EquippablePerk>::GetEnumerator()  /*0x0A0002DB*/
    IL_0047: stloc.1
    IL_0048: br.s IL_0083
    IL_004a: ldloca.s 1
    IL_004c: call !0 System.Collections.Generic.List.Enumerator<EquippablePerk>::get_Current()  /*0x0A0002DC*/
    IL_0051: stloc.2
    IL_0052: ldloc.2
    IL_0053: isinst EquippablePerk  /*0x0200021A*/
    IL_0058: ldnull
    IL_0059: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_005e: brfalse.s IL_007c
    IL_0060: ldarg.0
    IL_0061: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_0066: ldloc.2
    IL_0067: isinst EquippablePerk  /*0x0200021A*/
    IL_006c: callvirt bool System.Collections.Generic.List<EquippablePerk>::Contains(!0)  /*0x0A0002DD*/
    IL_0071: brtrue.s IL_0083
    IL_0073: ldloc.2
    IL_0074: ldc.i4.1
    IL_0075: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_007a: br.s IL_0083
    IL_007c: ldloc.2
    IL_007d: ldc.i4.1
    IL_007e: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_0083: ldloca.s 1
    IL_0085: call bool System.Collections.Generic.List.Enumerator<EquippablePerk>::MoveNext()  /*0x0A0002DE*/
    IL_008a: brtrue.s IL_004a
    IL_008c: leave.s IL_009c
    IL_008e: ldloca.s 1
    IL_0090: constrained. System.Collections.Generic.List.Enumerator<EquippablePerk>  /*0x1B000082*/
    IL_0096: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009b: endfinally
    IL_009c: ldarg.0
    IL_009d: ldfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_00a2: ldc.i4.1
    IL_00a3: call void PerkManager::SetEquipped(Equippable,bool)  /*0x060009A5*/
    IL_00a8: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_00b3: callvirt void SceneTransitionManager::TransitionFromNullToLevel(string)  /*0x060009CA*/
    IL_00b8: ret
    .try IL_0048-IL_008e finally handler IL_008e-IL_009c

  .method EternalTrialsRunManager::CreateFreshRun()  // token 0x060006F5 rva 0x1ead4 attrs Public, Static, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0005: ldc.i4.0
    IL_0006: ldelem.ref
    IL_0007: ldsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_000c: ldc.i4.0
    IL_000d: ldc.i4.0
    IL_000e: newobj void EternalTrialsRun::.ctor(string,int,int,bool)  /*0x060006FD*/
    IL_0013: stsfld EternalTrialsRun EternalTrialsRunManager::currentRun  /*0x0400084A*/
    IL_0018: ret

  .method EternalTrialsRunManager::GetMapChoices()  // token 0x060006F6 rva 0x1eaf0 attrs Public, Static, HideBySig
    // code size 115 (0x73), max stack 7, init locals
    .locals ([0] Random, [1] MapChoice[], [2] string[], [3] int)
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_000a: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_000f: stloc.0
    IL_0010: ldc.i4.3
    IL_0011: newarr MapChoice  /*0x02000147*/
    IL_0016: stloc.1
    IL_0017: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_001c: callvirt object System.Array::Clone()  /*0x0A0002DF*/
    IL_0021: castclass string[]  /*0x1B000083*/
    IL_0026: stloc.2
    IL_0027: ldloc.2
    IL_0028: ldloc.0
    IL_0029: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<string>  /*0x2B000066*/
    IL_002e: ldc.i4.0
    IL_002f: stloc.3
    IL_0030: br.s IL_006b
    IL_0032: ldloc.3
    IL_0033: ldloc.2
    IL_0034: ldlen
    IL_0035: conv.i4
    IL_0036: bge.s IL_0048
    IL_0038: ldloc.1
    IL_0039: ldloc.3
    IL_003a: ldc.i4.2
    IL_003b: ldloc.2
    IL_003c: ldloc.3
    IL_003d: ldelem.ref
    IL_003e: ldloc.0
    IL_003f: ldloc.3
    IL_0040: call MapChoice MapChoice::GenerateNewMapChoice(int,string,System.Random,int)  /*0x06000700*/
    IL_0045: stelem.ref
    IL_0046: br.s IL_0067
    IL_0048: ldloc.1
    IL_0049: ldloc.3
    IL_004a: ldc.i4.2
    IL_004b: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0050: ldloc.0
    IL_0051: ldc.i4.0
    IL_0052: ldsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0057: ldlen
    IL_0058: conv.i4
    IL_0059: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_005e: ldelem.ref
    IL_005f: ldloc.0
    IL_0060: ldloc.3
    IL_0061: call MapChoice MapChoice::GenerateNewMapChoice(int,string,System.Random,int)  /*0x06000700*/
    IL_0066: stelem.ref
    IL_0067: ldloc.3
    IL_0068: ldc.i4.1
    IL_0069: add
    IL_006a: stloc.3
    IL_006b: ldloc.3
    IL_006c: ldloc.1
    IL_006d: ldlen
    IL_006e: conv.i4
    IL_006f: blt.s IL_0032
    IL_0071: ldloc.1
    IL_0072: ret

  .method EternalTrialsRunManager::ConfirmChoice(MapChoice)  // token 0x060006F7 rva 0x1eb70 attrs Public, Static, HideBySig
    // code size 103 (0x67), max stack 3, init locals
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: ldarg.0
    IL_0006: ldfld string MapChoice::mapName  /*0x0400085A*/
    IL_000b: stfld string EternalTrialsRun::currentMap  /*0x0400084E*/
    IL_0010: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0015: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_001a: ldarg.0
    IL_001b: ldfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_0020: callvirt void System.Collections.Generic.List<EquippablePerk>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0002E0*/
    IL_0025: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_002a: ldarg.0
    IL_002b: ldfld EquippableWeapon MapChoice::containedWeapon  /*0x0400085B*/
    IL_0030: stfld EquippableWeapon EternalTrialsRun::currentWeapon  /*0x04000856*/
    IL_0035: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_003a: ldc.i4.1
    IL_003b: stfld bool EternalTrialsRun::inGame  /*0x04000852*/
    IL_0040: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0045: dup
    IL_0046: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_004b: ldarg.0
    IL_004c: ldfld int MapChoice::id  /*0x04000860*/
    IL_0051: add
    IL_0052: stfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_0057: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_005c: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_0061: call void EternalTrialsRunManager::GenerateNewFreshRunSeed()  /*0x060006EF*/
    IL_0066: ret

  .method EternalTrialsRunManager::AddScore(int)  // token 0x060006F8 rva 0x1ebe3 attrs Public, Static, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0005: dup
    IL_0006: ldfld int EternalTrialsRun::score  /*0x04000850*/
    IL_000b: ldarg.0
    IL_000c: add
    IL_000d: stfld int EternalTrialsRun::score  /*0x04000850*/
    IL_0012: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0017: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_001c: ret

  .method EternalTrialsRunManager::.ctor()  // token 0x060006F9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

  .method EternalTrialsRunManager::.cctor()  // token 0x060006FA rva 0x1ec04 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 91 (0x5b), max stack 4, init locals
    IL_0000: ldc.i4.s 9
    IL_0002: newarr System.String  /*0x0100001D*/
    IL_0007: dup
    IL_0008: ldc.i4.0
    IL_0009: ldstr "Nordfels"
    IL_000e: stelem.ref
    IL_000f: dup
    IL_0010: ldc.i4.1
    IL_0011: ldstr "Durststein"
    IL_0016: stelem.ref
    IL_0017: dup
    IL_0018: ldc.i4.2
    IL_0019: ldstr "Frostsee"
    IL_001e: stelem.ref
    IL_001f: dup
    IL_0020: ldc.i4.3
    IL_0021: ldstr "Uferwind"
    IL_0026: stelem.ref
    IL_0027: dup
    IL_0028: ldc.i4.4
    IL_0029: ldstr "Sturmklamm"
    IL_002e: stelem.ref
    IL_002f: dup
    IL_0030: ldc.i4.5
    IL_0031: ldstr "Wildbach"
    IL_0036: stelem.ref
    IL_0037: dup
    IL_0038: ldc.i4.6
    IL_0039: ldstr "Moorweg"
    IL_003e: stelem.ref
    IL_003f: dup
    IL_0040: ldc.i4.7
    IL_0041: ldstr "Freifort"
    IL_0046: stelem.ref
    IL_0047: dup
    IL_0048: ldc.i4.8
    IL_0049: ldstr "Totend"
    IL_004e: stelem.ref
    IL_004f: stsfld string[] EternalTrialsRunManager::mapRotation  /*0x04000848*/
    IL_0054: ldc.i4.0
    IL_0055: stsfld int EternalTrialsRunManager::freshRunSeed  /*0x0400084C*/
    IL_005a: ret

