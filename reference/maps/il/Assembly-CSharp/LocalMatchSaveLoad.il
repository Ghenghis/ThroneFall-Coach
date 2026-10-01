// ===== LocalMatchSaveLoad  (token 0x0200025A) =====
  .method LocalMatchSaveLoad::get_CurrentlyLoadingMatch()  // token 0x06000CD7 rva 0x3ae8d attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld bool LocalMatchSaveLoad::currentlyLoadingMatch  /*0x04000F82*/
    IL_0005: ret

  .method LocalMatchSaveLoad::Awake()  // token 0x06000CD8 rva 0x3ae94 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LocalMatchSaveLoad::disableAutomaticSaveLoading  /*0x04000F83*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: call !!0[] UnityEngine.Object::FindObjectsOfType(bool)<SaveLoadEntity>  /*0x2B0000BB*/
    IL_0010: stfld SaveLoadEntity[] LocalMatchSaveLoad::allSaveLoadEntities  /*0x04000F84*/
    IL_0015: ldarg.0
    IL_0016: call void LocalMatchSaveLoad::TryLoad()  /*0x06000CDB*/
    IL_001b: ret

  .method LocalMatchSaveLoad::Start()  // token 0x06000CD9 rva 0x3aeb1 attrs Private, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LocalMatchSaveLoad::disableAutomaticSaveLoading  /*0x04000F83*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_000e: ldarg.0
    IL_000f: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0014: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0019: ldc.i4.1
    IL_001a: bne.un.s IL_0035
    IL_001c: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0021: ldfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_0026: brfalse.s IL_0035
    IL_0028: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_002d: ldc.i4.3
    IL_002e: ldc.i4.0
    IL_002f: ldc.i4.0
    IL_0030: callvirt void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_0035: ret

  .method LocalMatchSaveLoad::Save()  // token 0x06000CDA rva 0x3aee8 attrs Private, HideBySig
    // code size 122 (0x7a), max stack 3, init locals
    .locals ([0] SaveLoadEntity[], [1] int, [2] SaveLoadEntity)
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_000a: ldc.i4.1
    IL_000b: bne.un.s IL_002a
    IL_000d: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0012: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0017: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_001c: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0021: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0026: ldc.i4.1
    IL_0027: sub
    IL_0028: blt.s IL_002b
    IL_002a: ret
    IL_002b: call void MatchSaveLoadHandler::InitializeCurrentSave()  /*0x06000CFB*/
    IL_0030: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0035: ldc.i4.1
    IL_0036: bne.un.s IL_004c
    IL_0038: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_003d: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0042: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_0047: stfld int MatchSave::etSeed  /*0x04000F8D*/
    IL_004c: ldarg.0
    IL_004d: ldfld SaveLoadEntity[] LocalMatchSaveLoad::allSaveLoadEntities  /*0x04000F84*/
    IL_0052: stloc.0
    IL_0053: ldc.i4.0
    IL_0054: stloc.1
    IL_0055: br.s IL_006e
    IL_0057: ldloc.0
    IL_0058: ldloc.1
    IL_0059: ldelem.ref
    IL_005a: stloc.2
    IL_005b: ldloc.2
    IL_005c: ldnull
    IL_005d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0062: brtrue.s IL_006a
    IL_0064: ldloc.2
    IL_0065: callvirt void SaveLoadEntity::ExecuteSave()  /*0x06000D0E*/
    IL_006a: ldloc.1
    IL_006b: ldc.i4.1
    IL_006c: add
    IL_006d: stloc.1
    IL_006e: ldloc.1
    IL_006f: ldloc.0
    IL_0070: ldlen
    IL_0071: conv.i4
    IL_0072: blt.s IL_0057
    IL_0074: call void MatchSaveLoadHandler::SaveRun()  /*0x06000CFC*/
    IL_0079: ret

  .method LocalMatchSaveLoad::TryLoad()  // token 0x06000CDB rva 0x3af70 attrs Private, HideBySig
    // code size 151 (0x97), max stack 2, init locals
    .locals ([0] SaveLoadEntity[], [1] int, [2] SaveLoadEntity, [3] SaveLoadEntity, [4] SaveLoadEntity)
    IL_0000: call bool MatchSaveLoadHandler::get_IsLoadingPermitted()  /*0x06000CF2*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldc.i4.1
    IL_0009: stsfld bool LocalMatchSaveLoad::currentlyLoadingMatch  /*0x04000F82*/
    IL_000e: ldarg.0
    IL_000f: ldfld SaveLoadEntity[] LocalMatchSaveLoad::allSaveLoadEntities  /*0x04000F84*/
    IL_0014: stloc.0
    IL_0015: ldc.i4.0
    IL_0016: stloc.1
    IL_0017: br.s IL_0030
    IL_0019: ldloc.0
    IL_001a: ldloc.1
    IL_001b: ldelem.ref
    IL_001c: stloc.2
    IL_001d: ldloc.2
    IL_001e: ldnull
    IL_001f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0024: brtrue.s IL_002c
    IL_0026: ldloc.2
    IL_0027: callvirt void SaveLoadEntity::ExecuteBeforeMainLoadPass()  /*0x06000D0B*/
    IL_002c: ldloc.1
    IL_002d: ldc.i4.1
    IL_002e: add
    IL_002f: stloc.1
    IL_0030: ldloc.1
    IL_0031: ldloc.0
    IL_0032: ldlen
    IL_0033: conv.i4
    IL_0034: blt.s IL_0019
    IL_0036: ldarg.0
    IL_0037: ldfld SaveLoadEntity[] LocalMatchSaveLoad::allSaveLoadEntities  /*0x04000F84*/
    IL_003c: stloc.0
    IL_003d: ldc.i4.0
    IL_003e: stloc.1
    IL_003f: br.s IL_0058
    IL_0041: ldloc.0
    IL_0042: ldloc.1
    IL_0043: ldelem.ref
    IL_0044: stloc.3
    IL_0045: ldloc.3
    IL_0046: ldnull
    IL_0047: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004c: brtrue.s IL_0054
    IL_004e: ldloc.3
    IL_004f: callvirt void SaveLoadEntity::ExecuteLoad()  /*0x06000D0C*/
    IL_0054: ldloc.1
    IL_0055: ldc.i4.1
    IL_0056: add
    IL_0057: stloc.1
    IL_0058: ldloc.1
    IL_0059: ldloc.0
    IL_005a: ldlen
    IL_005b: conv.i4
    IL_005c: blt.s IL_0041
    IL_005e: ldarg.0
    IL_005f: ldfld SaveLoadEntity[] LocalMatchSaveLoad::allSaveLoadEntities  /*0x04000F84*/
    IL_0064: stloc.0
    IL_0065: ldc.i4.0
    IL_0066: stloc.1
    IL_0067: br.s IL_0083
    IL_0069: ldloc.0
    IL_006a: ldloc.1
    IL_006b: ldelem.ref
    IL_006c: stloc.s 4
    IL_006e: ldloc.s 4
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0076: brtrue.s IL_007f
    IL_0078: ldloc.s 4
    IL_007a: callvirt void SaveLoadEntity::ExecuteAfterMainLoadPass()  /*0x06000D0D*/
    IL_007f: ldloc.1
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.1
    IL_0083: ldloc.1
    IL_0084: ldloc.0
    IL_0085: ldlen
    IL_0086: conv.i4
    IL_0087: blt.s IL_0069
    IL_0089: ldarg.0
    IL_008a: ldarg.0
    IL_008b: call IEnumerator LocalMatchSaveLoad::SetLoadStatWithDelay()  /*0x06000CDC*/
    IL_0090: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0095: pop
    IL_0096: ret

  .method LocalMatchSaveLoad::SetLoadStatWithDelay()  // token 0x06000CDC rva 0x3b013 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::.ctor(int)  /*0x06000CE3*/
    IL_0006: ret

  .method LocalMatchSaveLoad::TriggerDelayedSave()  // token 0x06000CDD rva 0x3b01b attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LocalMatchSaveLoad.<TriggerDelayedSave>d__10::.ctor(int)  /*0x06000CE9*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LocalMatchSaveLoad LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>4__this  /*0x04000F89*/
    IL_000d: ret

  .method LocalMatchSaveLoad::OnDawn_AfterSunrise()  // token 0x06000CDE rva 0x3b02a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator LocalMatchSaveLoad::TriggerDelayedSave()  /*0x06000CDD*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method LocalMatchSaveLoad::OnDawn_BeforeSunrise()  // token 0x06000CDF rva 0x3b039 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 30 (0x1e), max stack 8
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: bne.un.s IL_001d
    IL_0008: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000d: ldc.i4.0
    IL_000e: stfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_0013: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0018: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_001d: ret

  .method LocalMatchSaveLoad::OnDusk()  // token 0x06000CE0 rva 0x3b058 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 30 (0x1e), max stack 8
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: bne.un.s IL_001d
    IL_0008: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000d: ldc.i4.1
    IL_000e: stfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_0013: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0018: call void EternalTrialsRunManager::SaveRun(EternalTrialsRun)  /*0x060006ED*/
    IL_001d: ret

  .method LocalMatchSaveLoad::OnDuskEarly()  // token 0x06000CE1 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LocalMatchSaveLoad::.ctor()  // token 0x06000CE2 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== LocalMatchSaveLoad/<SetLoadStatWithDelay>d__9  (token 0x0200025B) =====
  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::.ctor(int)  // token 0x06000CE3 rva 0x3b077 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_000d: ret

  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::System.IDisposable.Dispose()  // token 0x06000CE4 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::MoveNext()  // token 0x06000CE5 rva 0x3b088 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 169 (0xa9), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: switch (IL_0027, IL_003e, IL_0055, IL_006c, IL_0083, IL_009a)
    IL_0025: ldc.i4.0
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: ldc.i4.m1
    IL_0029: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_002e: ldarg.0
    IL_002f: ldnull
    IL_0030: stfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_0035: ldarg.0
    IL_0036: ldc.i4.1
    IL_0037: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_003c: ldc.i4.1
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldc.i4.m1
    IL_0040: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0045: ldarg.0
    IL_0046: ldnull
    IL_0047: stfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_004c: ldarg.0
    IL_004d: ldc.i4.2
    IL_004e: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0053: ldc.i4.1
    IL_0054: ret
    IL_0055: ldarg.0
    IL_0056: ldc.i4.m1
    IL_0057: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_005c: ldarg.0
    IL_005d: ldnull
    IL_005e: stfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.3
    IL_0065: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_006a: ldc.i4.1
    IL_006b: ret
    IL_006c: ldarg.0
    IL_006d: ldc.i4.m1
    IL_006e: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0073: ldarg.0
    IL_0074: ldnull
    IL_0075: stfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.4
    IL_007c: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0081: ldc.i4.1
    IL_0082: ret
    IL_0083: ldarg.0
    IL_0084: ldc.i4.m1
    IL_0085: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_008a: ldarg.0
    IL_008b: ldnull
    IL_008c: stfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_0091: ldarg.0
    IL_0092: ldc.i4.5
    IL_0093: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_0098: ldc.i4.1
    IL_0099: ret
    IL_009a: ldarg.0
    IL_009b: ldc.i4.m1
    IL_009c: stfld int LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>1__state  /*0x04000F85*/
    IL_00a1: ldc.i4.0
    IL_00a2: stsfld bool LocalMatchSaveLoad::currentlyLoadingMatch  /*0x04000F82*/
    IL_00a7: ldc.i4.0
    IL_00a8: ret

  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000CE6 rva 0x3b13d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_0006: ret

  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::System.Collections.IEnumerator.Reset()  // token 0x06000CE7 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::System.Collections.IEnumerator.get_Current()  // token 0x06000CE8 rva 0x3b13d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalMatchSaveLoad.<SetLoadStatWithDelay>d__9::<>2__current  /*0x04000F86*/
    IL_0006: ret

// ===== LocalMatchSaveLoad/<TriggerDelayedSave>d__10  (token 0x0200025C) =====
  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::.ctor(int)  // token 0x06000CE9 rva 0x3b145 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_000d: ret

  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::System.IDisposable.Dispose()  // token 0x06000CEA rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::MoveNext()  // token 0x06000CEB rva 0x3b154 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 149 (0x95), max stack 2, init locals
    .locals ([0] int, [1] LocalMatchSaveLoad)
    IL_0000: ldarg.0
    IL_0001: ldfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LocalMatchSaveLoad LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>4__this  /*0x04000F89*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002a, IL_0041, IL_0058, IL_006f, IL_0086)
    IL_0028: ldc.i4.0
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldc.i4.m1
    IL_002c: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0031: ldarg.0
    IL_0032: ldnull
    IL_0033: stfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_0038: ldarg.0
    IL_0039: ldc.i4.1
    IL_003a: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_003f: ldc.i4.1
    IL_0040: ret
    IL_0041: ldarg.0
    IL_0042: ldc.i4.m1
    IL_0043: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0048: ldarg.0
    IL_0049: ldnull
    IL_004a: stfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_004f: ldarg.0
    IL_0050: ldc.i4.2
    IL_0051: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0056: ldc.i4.1
    IL_0057: ret
    IL_0058: ldarg.0
    IL_0059: ldc.i4.m1
    IL_005a: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_005f: ldarg.0
    IL_0060: ldnull
    IL_0061: stfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_0066: ldarg.0
    IL_0067: ldc.i4.3
    IL_0068: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_006d: ldc.i4.1
    IL_006e: ret
    IL_006f: ldarg.0
    IL_0070: ldc.i4.m1
    IL_0071: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0076: ldarg.0
    IL_0077: ldnull
    IL_0078: stfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_007d: ldarg.0
    IL_007e: ldc.i4.4
    IL_007f: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_0084: ldc.i4.1
    IL_0085: ret
    IL_0086: ldarg.0
    IL_0087: ldc.i4.m1
    IL_0088: stfld int LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>1__state  /*0x04000F87*/
    IL_008d: ldloc.1
    IL_008e: call void LocalMatchSaveLoad::Save()  /*0x06000CDA*/
    IL_0093: ldc.i4.0
    IL_0094: ret

  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000CEC rva 0x3b1f5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_0006: ret

  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::System.Collections.IEnumerator.Reset()  // token 0x06000CED rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LocalMatchSaveLoad.<TriggerDelayedSave>d__10::System.Collections.IEnumerator.get_Current()  // token 0x06000CEE rva 0x3b1f5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalMatchSaveLoad.<TriggerDelayedSave>d__10::<>2__current  /*0x04000F88*/
    IL_0006: ret

