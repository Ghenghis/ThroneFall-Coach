// ===== MapChoice  (token 0x02000147) =====
  .method MapChoice::GenerateNewMapChoice(int,string,System.Random,int)  // token 0x06000700 rva 0x1f010 attrs Public, Static, HideBySig
    // code size 421 (0x1a5), max stack 8, init locals
    .locals ([0] MapChoice, [1] List<EquippableWeapon>, [2] List<EquippablePerk>, [3] LevelInfo, [4] int, [5] int, [6] List.Enumerator<Equippable>, [7] Equippable, [8] int, [9] int, [10] List.Enumerator<Wave>, [11] WaveInfo)
    IL_0000: newobj void MapChoice::.ctor()  /*0x06000701*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.3
    IL_0008: stfld int MapChoice::id  /*0x04000860*/
    IL_000d: ldloc.0
    IL_000e: ldarg.1
    IL_000f: stfld string MapChoice::mapName  /*0x0400085A*/
    IL_0014: newobj void System.Collections.Generic.List<EquippableWeapon>::.ctor()  /*0x0A0002E2*/
    IL_0019: stloc.1
    IL_001a: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_001f: stloc.2
    IL_0020: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0025: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_002a: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_002f: stloc.s 6
    IL_0031: br.s IL_0080
    IL_0033: ldloca.s 6
    IL_0035: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_003a: stloc.s 7
    IL_003c: ldloc.s 7
    IL_003e: isinst EquippableWeapon  /*0x0200021B*/
    IL_0043: brfalse.s IL_0052
    IL_0045: ldloc.1
    IL_0046: ldloc.s 7
    IL_0048: isinst EquippableWeapon  /*0x0200021B*/
    IL_004d: callvirt void System.Collections.Generic.List<EquippableWeapon>::Add(!0)  /*0x0A0002E5*/
    IL_0052: ldloc.s 7
    IL_0054: isinst EquippablePerk  /*0x0200021A*/
    IL_0059: brfalse.s IL_0080
    IL_005b: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0060: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0065: ldloc.s 7
    IL_0067: isinst EquippablePerk  /*0x0200021A*/
    IL_006c: callvirt bool System.Collections.Generic.List<EquippablePerk>::Contains(!0)  /*0x0A0002DD*/
    IL_0071: brtrue.s IL_0080
    IL_0073: ldloc.2
    IL_0074: ldloc.s 7
    IL_0076: isinst EquippablePerk  /*0x0200021A*/
    IL_007b: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_0080: ldloca.s 6
    IL_0082: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0087: brtrue.s IL_0033
    IL_0089: leave.s IL_0099
    IL_008b: ldloca.s 6
    IL_008d: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0093: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0098: endfinally
    IL_0099: ldc.i4.0
    IL_009a: stloc.s 8
    IL_009c: br.s IL_00d7
    IL_009e: ldloc.2
    IL_009f: callvirt int System.Collections.Generic.List<EquippablePerk>::get_Count()  /*0x0A0002EE*/
    IL_00a4: ldc.i4.1
    IL_00a5: blt.s IL_00dc
    IL_00a7: ldarg.2
    IL_00a8: ldc.i4.0
    IL_00a9: ldloc.2
    IL_00aa: callvirt int System.Collections.Generic.List<EquippablePerk>::get_Count()  /*0x0A0002EE*/
    IL_00af: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_00b4: stloc.s 9
    IL_00b6: ldloc.0
    IL_00b7: ldfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_00bc: ldloc.2
    IL_00bd: ldloc.s 9
    IL_00bf: callvirt !0 System.Collections.Generic.List<EquippablePerk>::get_Item(int)  /*0x0A0002EF*/
    IL_00c4: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_00c9: ldloc.2
    IL_00ca: ldloc.s 9
    IL_00cc: callvirt void System.Collections.Generic.List<EquippablePerk>::RemoveAt(int)  /*0x0A0002F0*/
    IL_00d1: ldloc.s 8
    IL_00d3: ldc.i4.1
    IL_00d4: add
    IL_00d5: stloc.s 8
    IL_00d7: ldloc.s 8
    IL_00d9: ldarg.0
    IL_00da: blt.s IL_009e
    IL_00dc: ldloc.0
    IL_00dd: ldloc.1
    IL_00de: ldarg.2
    IL_00df: ldc.i4.0
    IL_00e0: ldloc.1
    IL_00e1: callvirt int System.Collections.Generic.List<EquippableWeapon>::get_Count()  /*0x0A0002F1*/
    IL_00e6: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_00eb: callvirt !0 System.Collections.Generic.List<EquippableWeapon>::get_Item(int)  /*0x0A0002F2*/
    IL_00f0: stfld EquippableWeapon MapChoice::containedWeapon  /*0x0400085B*/
    IL_00f5: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_00fa: ldarg.1
    IL_00fb: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromSceneName(string)  /*0x06000944*/
    IL_0100: stloc.3
    IL_0101: ldloc.0
    IL_0102: ldloc.3
    IL_0103: ldfld EnemySpawner LevelInfo::enemySpawner  /*0x04000B28*/
    IL_0108: ldfld EternalWaveGenerator EnemySpawner::waveGeneratorScript  /*0x040007C8*/
    IL_010d: ldloc.3
    IL_010e: ldfld EnemySpawner LevelInfo::enemySpawner  /*0x04000B28*/
    IL_0113: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0118: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<EnemySpawnLine>  /*0x2B000057*/
    IL_011d: ldloc.3
    IL_011e: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0123: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_0128: ldloca.s 4
    IL_012a: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_012f: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_0134: ldloc.0
    IL_0135: ldfld int MapChoice::id  /*0x04000860*/
    IL_013a: add
    IL_013b: ldc.i4.m1
    IL_013c: callvirt List<Wave> EternalWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  /*0x06000703*/
    IL_0141: stfld List<Wave> MapChoice::waves  /*0x0400085D*/
    IL_0146: ldc.i4.1
    IL_0147: stloc.s 5
    IL_0149: ldloc.0
    IL_014a: ldfld List<Wave> MapChoice::waves  /*0x0400085D*/
    IL_014f: callvirt List.Enumerator<!0> System.Collections.Generic.List<Wave>::GetEnumerator()  /*0x0A000295*/
    IL_0154: stloc.s 10
    IL_0156: br.s IL_0182
    IL_0158: ldloca.s 10
    IL_015a: call !0 System.Collections.Generic.List.Enumerator<Wave>::get_Current()  /*0x0A000296*/
    IL_015f: callvirt WaveInfo Wave::GetWaveInfo()  /*0x060006A1*/
    IL_0164: stloc.s 11
    IL_0166: ldloc.s 11
    IL_0168: ldloc.s 5
    IL_016a: stfld int WaveInfo::waveNumber  /*0x040007FB*/
    IL_016f: ldloc.0
    IL_0170: ldfld List<WaveInfo> MapChoice::waveInfos  /*0x0400085E*/
    IL_0175: ldloc.s 11
    IL_0177: callvirt void System.Collections.Generic.List<WaveInfo>::Add(!0)  /*0x0A0002F3*/
    IL_017c: ldloc.s 5
    IL_017e: ldc.i4.1
    IL_017f: add
    IL_0180: stloc.s 5
    IL_0182: ldloca.s 10
    IL_0184: call bool System.Collections.Generic.List.Enumerator<Wave>::MoveNext()  /*0x0A000297*/
    IL_0189: brtrue.s IL_0158
    IL_018b: leave.s IL_019b
    IL_018d: ldloca.s 10
    IL_018f: constrained. System.Collections.Generic.List.Enumerator<Wave>  /*0x1B000074*/
    IL_0195: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_019a: endfinally
    IL_019b: ldloc.0
    IL_019c: ldloc.s 4
    IL_019e: stfld int MapChoice::goldAtStart  /*0x0400085F*/
    IL_01a3: ldloc.0
    IL_01a4: ret
    .try IL_0031-IL_008b finally handler IL_008b-IL_0099
    .try IL_0156-IL_018d finally handler IL_018d-IL_019b

  .method MapChoice::.ctor()  // token 0x06000701 rva 0x1f1e0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<EquippablePerk>::.ctor()  /*0x0A0002E1*/
    IL_0006: stfld List<EquippablePerk> MapChoice::containedPerks  /*0x0400085C*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_0011: stfld List<Wave> MapChoice::waves  /*0x0400085D*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<WaveInfo>::.ctor()  /*0x0A0002F4*/
    IL_001c: stfld List<WaveInfo> MapChoice::waveInfos  /*0x0400085E*/
    IL_0021: ldarg.0
    IL_0022: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0027: ret

