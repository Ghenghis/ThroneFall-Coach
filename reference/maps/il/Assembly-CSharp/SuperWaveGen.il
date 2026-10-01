// ===== SuperWaveGen  (token 0x02000150) =====
  .method SuperWaveGen::RandomizeAllMetaParameters(int)  // token 0x06000716 rva 0x21568 attrs Private, HideBySig
    // code size 272 (0x110), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.EStartingGold>  /*0x2B00006A*/
    IL_0006: stfld SuperWaveGen.EStartingGold SuperWaveGen::settingEStartingGold  /*0x04000898*/
    IL_000b: ldarg.1
    IL_000c: ldc.i4.4
    IL_000d: blt.s IL_001e
    IL_000f: ldarg.0
    IL_0010: ldfld SuperWaveGen.EStartingGold SuperWaveGen::settingEStartingGold  /*0x04000898*/
    IL_0015: brtrue.s IL_001e
    IL_0017: ldarg.0
    IL_0018: ldc.i4.1
    IL_0019: stfld SuperWaveGen.EStartingGold SuperWaveGen::settingEStartingGold  /*0x04000898*/
    IL_001e: ldarg.0
    IL_001f: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.EEnemyGoldDropRate>  /*0x2B00006B*/
    IL_0024: stfld SuperWaveGen.EEnemyGoldDropRate SuperWaveGen::settingEEnemyGoldDropRate  /*0x04000899*/
    IL_0029: ldarg.0
    IL_002a: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.EMinimumGoldGainPerNight>  /*0x2B00006C*/
    IL_002f: stfld SuperWaveGen.EMinimumGoldGainPerNight SuperWaveGen::settingEMinimumGoldGainPerNight  /*0x0400089A*/
    IL_0034: ldarg.0
    IL_0035: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.EMaximumGoldGainPerNight>  /*0x2B00006D*/
    IL_003a: stfld SuperWaveGen.EMaximumGoldGainPerNight SuperWaveGen::settingEMaximumGoldGainPerNight  /*0x0400089B*/
    IL_003f: ldarg.0
    IL_0040: call !!0 SuperWaveGen::GetRandomEnumValueWithDistribution()<SuperWaveGen.EEnemyPreselection>  /*0x2B00006E*/
    IL_0045: stfld SuperWaveGen.EEnemyPreselection SuperWaveGen::settingEnemyPreselection  /*0x0400089D*/
    IL_004a: ldarg.0
    IL_004b: call !!0 SuperWaveGen::GetRandomEnumValueWithDistribution()<SuperWaveGen.EEnemyTypesMode>  /*0x2B00006F*/
    IL_0050: stfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_0055: ldarg.0
    IL_0056: call !!0 SuperWaveGen::GetRandomEnumValueWithDistribution()<SuperWaveGen.ESpawnSelectMode>  /*0x2B000070*/
    IL_005b: stfld SuperWaveGen.ESpawnSelectMode SuperWaveGen::settingSpawnToPick  /*0x0400089F*/
    IL_0060: ldarg.0
    IL_0061: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.ESpawnInDuration>  /*0x2B000071*/
    IL_0066: stfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_006b: ldarg.0
    IL_006c: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.ESpawnInType>  /*0x2B000072*/
    IL_0071: stfld SuperWaveGen.ESpawnInType SuperWaveGen::settingESpawnInType  /*0x040008A2*/
    IL_0076: ldarg.0
    IL_0077: call !!0 SuperWaveGen::GetRandomEnumValueWithDistribution()<SuperWaveGen.EElitMode>  /*0x2B000073*/
    IL_007c: stfld SuperWaveGen.EElitMode SuperWaveGen::settingEliteMode  /*0x040008A1*/
    IL_0081: ldarg.0
    IL_0082: call !!0 SuperWaveGen::GetRandomEnumValue()<SuperWaveGen.EFinalWaveBonus>  /*0x2B000074*/
    IL_0087: stfld SuperWaveGen.EFinalWaveBonus SuperWaveGen::settingEFinalWaveBonus  /*0x040008A4*/
    IL_008c: ldarg.0
    IL_008d: call !!0 SuperWaveGen::GetRandomEnumValueWithDistribution()<SuperWaveGen.EDistributeDifficulty>  /*0x2B000075*/
    IL_0092: stfld SuperWaveGen.EDistributeDifficulty SuperWaveGen::settingEDistributeDifficulty  /*0x040008A3*/
    IL_0097: ldarg.1
    IL_0098: ldc.i4.1
    IL_0099: bgt.s IL_00c2
    IL_009b: ldarg.0
    IL_009c: ldc.i4.0
    IL_009d: stfld SuperWaveGen.EFinalWaveBonus SuperWaveGen::settingEFinalWaveBonus  /*0x040008A4*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_00a8: ldc.i4.3
    IL_00a9: bne.un.s IL_00b2
    IL_00ab: ldarg.0
    IL_00ac: ldc.i4.1
    IL_00ad: stfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_00b8: ldc.i4.4
    IL_00b9: bne.un.s IL_00c2
    IL_00bb: ldarg.0
    IL_00bc: ldc.i4.2
    IL_00bd: stfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_00c2: ldarg.1
    IL_00c3: ldc.i4.2
    IL_00c4: bgt.s IL_00cd
    IL_00c6: ldarg.0
    IL_00c7: ldc.i4.0
    IL_00c8: stfld SuperWaveGen.EElitMode SuperWaveGen::settingEliteMode  /*0x040008A1*/
    IL_00cd: ldarg.1
    IL_00ce: ldc.i4.6
    IL_00cf: blt.s IL_010f
    IL_00d1: ldarg.0
    IL_00d2: ldfld SuperWaveGen.EDistributeDifficulty SuperWaveGen::settingEDistributeDifficulty  /*0x040008A3*/
    IL_00d7: ldc.i4.4
    IL_00d8: bne.un.s IL_00e1
    IL_00da: ldarg.0
    IL_00db: ldc.i4.3
    IL_00dc: stfld SuperWaveGen.EDistributeDifficulty SuperWaveGen::settingEDistributeDifficulty  /*0x040008A3*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld SuperWaveGen.ESpawnSelectMode SuperWaveGen::settingSpawnToPick  /*0x0400089F*/
    IL_00e7: brtrue.s IL_00f0
    IL_00e9: ldarg.0
    IL_00ea: ldc.i4.3
    IL_00eb: stfld SuperWaveGen.ESpawnSelectMode SuperWaveGen::settingSpawnToPick  /*0x0400089F*/
    IL_00f0: ldarg.0
    IL_00f1: ldfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_00f6: brtrue.s IL_00ff
    IL_00f8: ldarg.0
    IL_00f9: ldc.i4.2
    IL_00fa: stfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_00ff: ldarg.0
    IL_0100: ldfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_0105: ldc.i4.1
    IL_0106: bne.un.s IL_010f
    IL_0108: ldarg.0
    IL_0109: ldc.i4.4
    IL_010a: stfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_010f: ret

  .method SuperWaveGen::ReturnDebugInfoAboutWave(int)  // token 0x06000717 rva 0x21684 attrs Public, Virtual, HideBySig
    // code size 91 (0x5b), max stack 3, init locals
    .locals ([0] string, [1] List.Enumerator<string>, [2] string)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: blt.s IL_000f
    IL_0004: ldarg.1
    IL_0005: ldarg.0
    IL_0006: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_000b: ldlen
    IL_000c: conv.i4
    IL_000d: blt.s IL_0015
    IL_000f: ldstr ""
    IL_0014: ret
    IL_0015: ldstr ""
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0021: ldarg.1
    IL_0022: ldelem.ref
    IL_0023: callvirt List.Enumerator<!0> System.Collections.Generic.List<string>::GetEnumerator()  /*0x0A0002EB*/
    IL_0028: stloc.1
    IL_0029: br.s IL_0040
    IL_002b: ldloca.s 1
    IL_002d: call !0 System.Collections.Generic.List.Enumerator<string>::get_Current()  /*0x0A0002EC*/
    IL_0032: stloc.2
    IL_0033: ldloc.0
    IL_0034: ldloc.2
    IL_0035: ldstr "\n"
    IL_003a: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_003f: stloc.0
    IL_0040: ldloca.s 1
    IL_0042: call bool System.Collections.Generic.List.Enumerator<string>::MoveNext()  /*0x0A0002ED*/
    IL_0047: brtrue.s IL_002b
    IL_0049: leave.s IL_0059
    IL_004b: ldloca.s 1
    IL_004d: constrained. System.Collections.Generic.List.Enumerator<string>  /*0x1B000087*/
    IL_0053: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0058: endfinally
    IL_0059: ldloc.0
    IL_005a: ret
    .try IL_0029-IL_004b finally handler IL_004b-IL_0059

  .method SuperWaveGen::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  // token 0x06000718 rva 0x216fc attrs Public, Virtual, HideBySig
    // code size 783 (0x30f), max stack 13, init locals
    .locals ([0] Random, [1] int, [2] float, [3] int, [4] int, [5] List<Wave>, [6] List.Enumerator<EternalTrialEnemy>, [7] SuperWaveGen.EStartingGold, [8] SuperWaveGen.EEnemyGoldDropRate, [9] SuperWaveGen.EMinimumGoldGainPerNight, [10] SuperWaveGen.EMaximumGoldGainPerNight, [11] int, [12] int, [13] bool)
    IL_0000: ldarg.s 5
    IL_0002: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_0007: stloc.0
    IL_0008: ldarg.s 5
    IL_000a: call void UnityEngine.Random::InitState(int)  /*0x0A000294*/
    IL_000f: ldarg.0
    IL_0010: ldarg.3
    IL_0011: call void SuperWaveGen::RandomizeAllMetaParameters(int)  /*0x06000716*/
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_001d: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_0022: newarr System.Single  /*0x01000052*/
    IL_0027: stfld float[] SuperWaveGen::tagsCountered  /*0x040008A6*/
    IL_002c: ldarg.0
    IL_002d: ldfld EternalTrialEnemySet SuperWaveGen::enemySet  /*0x04000893*/
    IL_0032: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_0037: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_003c: stloc.s 6
    IL_003e: br.s IL_0052
    IL_0040: ldloca.s 6
    IL_0042: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0047: dup
    IL_0048: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_004d: callvirt void EternalTrialEnemy::set_DifficultyValueTemp(float)  /*0x060006D9*/
    IL_0052: ldloca.s 6
    IL_0054: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0059: brtrue.s IL_0040
    IL_005b: leave.s IL_006b
    IL_005d: ldloca.s 6
    IL_005f: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0065: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006a: endfinally
    IL_006b: ldc.i4.0
    IL_006c: stloc.1
    IL_006d: ldarg.3
    IL_006e: switch (IL_0081, IL_0095, IL_00a9)
    IL_007f: br.s IL_00bd
    IL_0081: ldc.i4.3
    IL_0082: stloc.1
    IL_0083: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0088: ldc.r4 0.5f
    IL_008d: bgt.un.s IL_00c1
    IL_008f: ldloc.1
    IL_0090: ldc.i4.1
    IL_0091: add
    IL_0092: stloc.1
    IL_0093: br.s IL_00c1
    IL_0095: ldc.i4.5
    IL_0096: stloc.1
    IL_0097: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_009c: ldc.r4 0.5f
    IL_00a1: bgt.un.s IL_00c1
    IL_00a3: ldloc.1
    IL_00a4: ldc.i4.1
    IL_00a5: add
    IL_00a6: stloc.1
    IL_00a7: br.s IL_00c1
    IL_00a9: ldc.i4.7
    IL_00aa: stloc.1
    IL_00ab: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00b0: ldc.r4 0.5f
    IL_00b5: bgt.un.s IL_00c1
    IL_00b7: ldloc.1
    IL_00b8: ldc.i4.1
    IL_00b9: add
    IL_00ba: stloc.1
    IL_00bb: br.s IL_00c1
    IL_00bd: ldc.i4.6
    IL_00be: ldarg.3
    IL_00bf: add
    IL_00c0: stloc.1
    IL_00c1: ldarg.s 6
    IL_00c3: ldc.i4.0
    IL_00c4: ble.s IL_00c9
    IL_00c6: ldarg.s 6
    IL_00c8: stloc.1
    IL_00c9: ldarg.s 4
    IL_00cb: ldc.i4.0
    IL_00cc: stind.i4
    IL_00cd: ldarg.0
    IL_00ce: ldfld SuperWaveGen.EStartingGold SuperWaveGen::settingEStartingGold  /*0x04000898*/
    IL_00d3: stloc.s 7
    IL_00d5: ldloc.s 7
    IL_00d7: switch (IL_00f2, IL_00f8, IL_00ff, IL_0106, IL_010d)
    IL_00f0: br.s IL_0112
    IL_00f2: ldarg.s 4
    IL_00f4: ldc.i4.8
    IL_00f5: stind.i4
    IL_00f6: br.s IL_0112
    IL_00f8: ldarg.s 4
    IL_00fa: ldc.i4.s 13
    IL_00fc: stind.i4
    IL_00fd: br.s IL_0112
    IL_00ff: ldarg.s 4
    IL_0101: ldc.i4.s 18
    IL_0103: stind.i4
    IL_0104: br.s IL_0112
    IL_0106: ldarg.s 4
    IL_0108: ldc.i4.s 23
    IL_010a: stind.i4
    IL_010b: br.s IL_0112
    IL_010d: ldarg.s 4
    IL_010f: ldc.i4.s 28
    IL_0111: stind.i4
    IL_0112: ldarg.s 4
    IL_0114: ldarg.s 4
    IL_0116: ldind.i4
    IL_0117: ldc.i4.s -2
    IL_0119: ldc.i4.3
    IL_011a: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_011f: add
    IL_0120: stind.i4
    IL_0121: ldc.r4 0f
    IL_0126: stloc.2
    IL_0127: ldarg.0
    IL_0128: ldfld SuperWaveGen.EEnemyGoldDropRate SuperWaveGen::settingEEnemyGoldDropRate  /*0x04000899*/
    IL_012d: stloc.s 8
    IL_012f: ldloc.s 8
    IL_0131: switch (IL_0148, IL_0150, IL_0158, IL_0160)
    IL_0146: br.s IL_0166
    IL_0148: ldc.r4 0f
    IL_014d: stloc.2
    IL_014e: br.s IL_0166
    IL_0150: ldc.r4 0.05625f
    IL_0155: stloc.2
    IL_0156: br.s IL_0166
    IL_0158: ldc.r4 0.1125f
    IL_015d: stloc.2
    IL_015e: br.s IL_0166
    IL_0160: ldc.r4 0.225f
    IL_0165: stloc.2
    IL_0166: ldc.i4.0
    IL_0167: stloc.3
    IL_0168: ldarg.0
    IL_0169: ldfld SuperWaveGen.EMinimumGoldGainPerNight SuperWaveGen::settingEMinimumGoldGainPerNight  /*0x0400089A*/
    IL_016e: stloc.s 9
    IL_0170: ldloc.s 9
    IL_0172: switch (IL_018d, IL_0191, IL_0195, IL_0199, IL_019d)
    IL_018b: br.s IL_01a0
    IL_018d: ldc.i4.2
    IL_018e: stloc.3
    IL_018f: br.s IL_01a0
    IL_0191: ldc.i4.4
    IL_0192: stloc.3
    IL_0193: br.s IL_01a0
    IL_0195: ldc.i4.6
    IL_0196: stloc.3
    IL_0197: br.s IL_01a0
    IL_0199: ldc.i4.8
    IL_019a: stloc.3
    IL_019b: br.s IL_01a0
    IL_019d: ldc.i4.s 11
    IL_019f: stloc.3
    IL_01a0: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_01a5: ldc.r4 0.5f
    IL_01aa: bgt.un.s IL_01b0
    IL_01ac: ldloc.3
    IL_01ad: ldc.i4.1
    IL_01ae: add
    IL_01af: stloc.3
    IL_01b0: ldc.i4 10000000
    IL_01b5: stloc.s 4
    IL_01b7: ldarg.0
    IL_01b8: ldfld SuperWaveGen.EMaximumGoldGainPerNight SuperWaveGen::settingEMaximumGoldGainPerNight  /*0x0400089B*/
    IL_01bd: stloc.s 10
    IL_01bf: ldloc.s 10
    IL_01c1: switch (IL_01dc, IL_01e1, IL_01e8, IL_01ef, IL_01f6)
    IL_01da: br.s IL_01fd
    IL_01dc: ldloc.3
    IL_01dd: stloc.s 4
    IL_01df: br.s IL_01fd
    IL_01e1: ldloc.3
    IL_01e2: ldc.i4.2
    IL_01e3: mul
    IL_01e4: stloc.s 4
    IL_01e6: br.s IL_01fd
    IL_01e8: ldloc.3
    IL_01e9: ldc.i4.3
    IL_01ea: mul
    IL_01eb: stloc.s 4
    IL_01ed: br.s IL_01fd
    IL_01ef: ldloc.3
    IL_01f0: ldc.i4.4
    IL_01f1: mul
    IL_01f2: stloc.s 4
    IL_01f4: br.s IL_01fd
    IL_01f6: ldc.i4 10000000
    IL_01fb: stloc.s 4
    IL_01fd: ldarg.0
    IL_01fe: ldflda List<int> SuperWaveGen::_OUTgoldSpentOnEconomyBeforeNigh  /*0x040008A9*/
    IL_0203: ldarg.0
    IL_0204: ldflda List<int> SuperWaveGen::_OUTgoldSpentOnDefenseBeforeNight  /*0x040008AA*/
    IL_0209: ldarg.0
    IL_020a: ldflda List<int> SuperWaveGen::_OUTNetworthBeforeNight  /*0x040008AB*/
    IL_020f: ldarg.0
    IL_0210: ldflda List<int> SuperWaveGen::_OUTgoldEarnedInNight  /*0x040008AC*/
    IL_0215: ldarg.0
    IL_0216: ldflda List<int> SuperWaveGen::_OUTgoldDroppedInNight  /*0x040008AD*/
    IL_021b: ldarg.0
    IL_021c: ldflda List<string> SuperWaveGen::_OUTBuildorder  /*0x040008AE*/
    IL_0221: ldarg.0
    IL_0222: ldflda List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_0227: ldarg.2
    IL_0228: ldfld List<VirtualBuilding> LevelInfo::virtualBuildings  /*0x04000B2C*/
    IL_022d: ldarg.s 4
    IL_022f: ldind.i4
    IL_0230: ldloc.2
    IL_0231: ldloc.3
    IL_0232: ldloc.s 4
    IL_0234: ldloc.1
    IL_0235: call void EconomySimulator::SimulateEconomy(ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<string>,ref System.Collections.Generic.List<int>,System.Collections.Generic.List<VirtualBuilding>,int,float,int,int,int)  /*0x060006C2*/
    IL_023a: ldarg.0
    IL_023b: ldfld List<int> SuperWaveGen::_OUTgoldEarnedInNight  /*0x040008AC*/
    IL_0240: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0245: stloc.1
    IL_0246: ldarg.0
    IL_0247: ldloc.1
    IL_0248: newarr System.Single  /*0x01000052*/
    IL_024d: stfld float[] SuperWaveGen::targetDifficultyInNight  /*0x040008A7*/
    IL_0252: ldarg.0
    IL_0253: ldloc.1
    IL_0254: newarr System.Collections.Generic.List<string>  /*0x1B000004*/
    IL_0259: stfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_025e: ldc.i4.0
    IL_025f: stloc.s 11
    IL_0261: br.s IL_0277
    IL_0263: ldarg.0
    IL_0264: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0269: ldloc.s 11
    IL_026b: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0270: stelem.ref
    IL_0271: ldloc.s 11
    IL_0273: ldc.i4.1
    IL_0274: add
    IL_0275: stloc.s 11
    IL_0277: ldloc.s 11
    IL_0279: ldarg.0
    IL_027a: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_027f: ldlen
    IL_0280: conv.i4
    IL_0281: blt.s IL_0263
    IL_0283: ldarg.0
    IL_0284: ldarg.0
    IL_0285: ldfld EternalTrialEnemySet SuperWaveGen::enemySet  /*0x04000893*/
    IL_028a: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_028f: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00031C*/
    IL_0294: stfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0299: ldarg.0
    IL_029a: ldarg.0
    IL_029b: ldflda List<EternalTrialEnemy> SuperWaveGen::removedEnemies  /*0x040008B0*/
    IL_02a0: ldloc.0
    IL_02a1: call void SuperWaveGen::RemoveInvalidEnemiesFromShuffeledEnemeisAndShuffle(ref System.Collections.Generic.List<EternalTrialEnemy>,System.Random)  /*0x06000722*/
    IL_02a6: ldarg.0
    IL_02a7: ldarg.1
    IL_02a8: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000302*/
    IL_02ad: stfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_02b2: ldarg.0
    IL_02b3: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_02b8: ldloc.0
    IL_02b9: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_02be: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_02c3: stloc.s 5
    IL_02c5: ldc.i4.0
    IL_02c6: stloc.s 12
    IL_02c8: br.s IL_0307
    IL_02ca: ldloc.s 5
    IL_02cc: ldarg.0
    IL_02cd: ldloc.s 12
    IL_02cf: ldloc.s 5
    IL_02d1: ldarg.3
    IL_02d2: ldloca.s 13
    IL_02d4: ldloc.s 12
    IL_02d6: ldloc.1
    IL_02d7: ldc.i4.1
    IL_02d8: sub
    IL_02d9: ceq
    IL_02db: ldloc.0
    IL_02dc: call Wave SuperWaveGen::GenerateWave(int,System.Collections.Generic.List<Wave>,int,ref bool,bool,System.Random)  /*0x06000719*/
    IL_02e1: callvirt void System.Collections.Generic.List<Wave>::Add(!0)  /*0x0A000317*/
    IL_02e6: ldloc.s 13
    IL_02e8: brtrue.s IL_0301
    IL_02ea: ldloc.s 12
    IL_02ec: ldc.i4.1
    IL_02ed: ble.s IL_0301
    IL_02ef: ldarg.0
    IL_02f0: ldarg.1
    IL_02f1: ldarg.2
    IL_02f2: ldarg.3
    IL_02f3: ldarg.s 4
    IL_02f5: ldarg.s 5
    IL_02f7: ldloc.s 12
    IL_02f9: ldc.i4.1
    IL_02fa: sub
    IL_02fb: callvirt List<Wave> EternalWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  /*0x06000703*/
    IL_0300: ret
    IL_0301: ldloc.s 12
    IL_0303: ldc.i4.1
    IL_0304: add
    IL_0305: stloc.s 12
    IL_0307: ldloc.s 12
    IL_0309: ldloc.1
    IL_030a: blt.s IL_02ca
    IL_030c: ldloc.s 5
    IL_030e: ret
    .try IL_003e-IL_005d finally handler IL_005d-IL_006b

  .method SuperWaveGen::GenerateWave(int,System.Collections.Generic.List<Wave>,int,ref bool,bool,System.Random)  // token 0x06000719 rva 0x21a28 attrs Private, HideBySig
    // code size 6859 (0x1acb), max stack 9, init locals
    .locals ([0] Wave, [1] int, [2] bool, [3] bool, [4] bool, [5] List<EternalTrialEnemy>, [6] int, [7] int, [8] bool, [9] int, [10] float, [11] float, [12] float, [13] List<EnemySpawnLine>, [14] float, [15] int, [16] float, [17] float, [18] float, [19] int, [20] int, [21] float, [22] float, [23] float, [24] int, [25] int, [26] float, [27] float, [28] List<TagManager.ETag>, [29] float, [30] float, [31] int, [32] float, [33] bool, [34] float, [35] int, [36] float, [37] float, [38] int, [39] SuperWaveGen.EFinalWaveBonus, [40] SuperWaveGen.EEnemyTypesMode, [41] int, [42] int, [43] List.Enumerator<EternalTrialEnemy>, [44] EternalTrialEnemy, [45] EternalTrialEnemy, [46] SuperWaveGen.ESpawnSelectMode, [47] EternalTrialEnemy, [48] EternalTrialEnemy, [49] EternalTrialEnemy, [50] EternalTrialEnemy, [51] EternalTrialEnemy, [52] EternalTrialEnemy, [53] EternalTrialEnemy, [54] List<EnemySpawnLine>, [55] List.Enumerator<EnemySpawnLine>, [56] EnemySpawnLine, [57] EternalTrialEnemy, [58] List<EnemySpawnLine>, [59] EnemySpawnLine, [60] EternalTrialEnemy, [61] List<EnemySpawnLine>, [62] EnemySpawnLine, [63] EternalTrialEnemy, [64] EnemySpawnLine, [65] EternalTrialEnemy, [66] List<EnemySpawnLine>, [67] EnemySpawnLine, [68] SuperWaveGen.ESpawnInDuration, [69] EnemySpawnLine, [70] int, [71] int, [72] EnemySpawnLine, [73] EnemySpawnLine, [74] int, [75] EnemySpawnLine, [76] float, [77] EternalTrialEnemy, [78] int, [79] EternalTrialEnemy, [80] bool, [81] float, [82] SuperWaveGen.EDistributeDifficulty, [83] float, [84] float, [85] int, [86] float, [87] int, [88] EternalTrialEnemy, [89] int, [90] float, [91] float, [92] int, [93] Tuple<float, int>, [94] int, [95] List.Enumerator<TagManager.ETag>, [96] TagManager.ETag, [97] int, [98] EternalTrialEnemy, [99] int, [100] float, [101] TagManager.ETag, [102] int, [103] float, [104] EternalTrialEnemy, [105] int, [106] List<Spawn>, [107] SuperWaveGen.EElitMode, [108] int, [109] Spawn, [110] int, [111] int, [112] Spawn, [113] Spawn, [114] int, [115] int, [116] int, [117] int, [118] Spawn, [119] int, [120] int, [121] float, [122] SuperWaveGen.ESpawnInType, [123] List.Enumerator<Spawn>, [124] EternalTrialEnemy)
    IL_0000: newobj void Wave::.ctor()  /*0x06000699*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<int> SuperWaveGen::_OUTgoldDroppedInNight  /*0x040008AD*/
    IL_000c: ldarg.1
    IL_000d: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0012: stloc.1
    IL_0013: ldc.i4.0
    IL_0014: stloc.2
    IL_0015: ldc.i4.0
    IL_0016: stloc.3
    IL_0017: ldc.i4.0
    IL_0018: stloc.s 4
    IL_001a: ldarg.s 5
    IL_001c: brfalse.s IL_006e
    IL_001e: ldarg.0
    IL_001f: ldfld SuperWaveGen.EFinalWaveBonus SuperWaveGen::settingEFinalWaveBonus  /*0x040008A4*/
    IL_0024: stloc.s 39
    IL_0026: ldloc.s 39
    IL_0028: switch (IL_006e, IL_004b, IL_0056, IL_0061, IL_004f, IL_005a, IL_0067)
    IL_0049: br.s IL_006e
    IL_004b: ldc.i4.1
    IL_004c: stloc.2
    IL_004d: br.s IL_006e
    IL_004f: ldc.i4.1
    IL_0050: stloc.2
    IL_0051: ldc.i4.1
    IL_0052: stloc.s 4
    IL_0054: br.s IL_006e
    IL_0056: ldc.i4.1
    IL_0057: stloc.3
    IL_0058: br.s IL_006e
    IL_005a: ldc.i4.1
    IL_005b: stloc.3
    IL_005c: ldc.i4.1
    IL_005d: stloc.s 4
    IL_005f: br.s IL_006e
    IL_0061: ldc.i4.1
    IL_0062: stloc.3
    IL_0063: ldc.i4.1
    IL_0064: stloc.2
    IL_0065: br.s IL_006e
    IL_0067: ldc.i4.1
    IL_0068: stloc.3
    IL_0069: ldc.i4.1
    IL_006a: stloc.2
    IL_006b: ldc.i4.1
    IL_006c: stloc.s 4
    IL_006e: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0073: stloc.s 5
    IL_0075: ldarg.0
    IL_0076: ldfld SuperWaveGen.EEnemyTypesMode SuperWaveGen::settingEnemiesToSpawn  /*0x0400089E*/
    IL_007b: stloc.s 40
    IL_007d: ldloc.s 40
    IL_007f: switch (IL_00a9, IL_0127, IL_00bf, IL_00e9, IL_014a, IL_0181, IL_020e, IL_01cc)
    IL_00a4: br IL_025b
    IL_00a9: ldloc.s 5
    IL_00ab: ldarg.0
    IL_00ac: ldarg.1
    IL_00ad: ldc.i4.0
    IL_00ae: ldloca.s 6
    IL_00b0: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_00b5: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_00ba: br IL_025b
    IL_00bf: ldloc.s 5
    IL_00c1: ldarg.0
    IL_00c2: ldarg.1
    IL_00c3: ldc.i4.0
    IL_00c4: ldloca.s 6
    IL_00c6: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_00cb: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_00d0: ldloc.s 5
    IL_00d2: ldarg.0
    IL_00d3: ldarg.1
    IL_00d4: ldloc.s 6
    IL_00d6: ldc.i4.1
    IL_00d7: add
    IL_00d8: ldloca.s 6
    IL_00da: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_00df: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_00e4: br IL_025b
    IL_00e9: ldloc.s 5
    IL_00eb: ldarg.0
    IL_00ec: ldarg.1
    IL_00ed: ldc.i4.0
    IL_00ee: ldloca.s 6
    IL_00f0: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_00f5: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_00fa: ldloc.s 5
    IL_00fc: ldarg.0
    IL_00fd: ldarg.1
    IL_00fe: ldloc.s 6
    IL_0100: ldc.i4.1
    IL_0101: add
    IL_0102: ldloca.s 6
    IL_0104: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_0109: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_010e: ldloc.s 5
    IL_0110: ldarg.0
    IL_0111: ldarg.1
    IL_0112: ldloc.s 6
    IL_0114: ldc.i4.1
    IL_0115: add
    IL_0116: ldloca.s 6
    IL_0118: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_011d: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0122: br IL_025b
    IL_0127: ldarg.0
    IL_0128: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_012d: ldarg.s 6
    IL_012f: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_0134: ldloc.s 5
    IL_0136: ldarg.0
    IL_0137: ldarg.1
    IL_0138: ldc.i4.0
    IL_0139: ldloca.s 6
    IL_013b: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_0140: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0145: br IL_025b
    IL_014a: ldarg.0
    IL_014b: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0150: ldarg.s 6
    IL_0152: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_0157: ldloc.s 5
    IL_0159: ldarg.0
    IL_015a: ldarg.1
    IL_015b: ldc.i4.0
    IL_015c: ldloca.s 6
    IL_015e: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_0163: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0168: ldloc.s 5
    IL_016a: ldarg.0
    IL_016b: ldarg.1
    IL_016c: ldloc.s 6
    IL_016e: ldc.i4.1
    IL_016f: add
    IL_0170: ldloca.s 6
    IL_0172: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_0177: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_017c: br IL_025b
    IL_0181: ldarg.0
    IL_0182: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0187: ldarg.s 6
    IL_0189: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_018e: ldloc.s 5
    IL_0190: ldarg.0
    IL_0191: ldarg.1
    IL_0192: ldc.i4.0
    IL_0193: ldloca.s 6
    IL_0195: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_019a: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_019f: ldloc.s 5
    IL_01a1: ldarg.0
    IL_01a2: ldarg.1
    IL_01a3: ldloc.s 6
    IL_01a5: ldc.i4.1
    IL_01a6: add
    IL_01a7: ldloca.s 6
    IL_01a9: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_01ae: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_01b3: ldloc.s 5
    IL_01b5: ldarg.0
    IL_01b6: ldarg.1
    IL_01b7: ldloc.s 6
    IL_01b9: ldc.i4.1
    IL_01ba: add
    IL_01bb: ldloca.s 6
    IL_01bd: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_01c2: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_01c7: br IL_025b
    IL_01cc: ldarg.1
    IL_01cd: ldc.i4.1
    IL_01ce: ldc.i4.7
    IL_01cf: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_01d4: stloc.s 7
    IL_01d6: ldloc.s 5
    IL_01d8: ldarg.0
    IL_01d9: ldarg.1
    IL_01da: ldc.i4.0
    IL_01db: ldloca.s 6
    IL_01dd: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_01e2: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_01e7: ldc.i4.0
    IL_01e8: stloc.s 41
    IL_01ea: br.s IL_0206
    IL_01ec: ldloc.s 5
    IL_01ee: ldarg.0
    IL_01ef: ldarg.1
    IL_01f0: ldloc.s 6
    IL_01f2: ldc.i4.1
    IL_01f3: add
    IL_01f4: ldloca.s 6
    IL_01f6: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_01fb: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0200: ldloc.s 41
    IL_0202: ldc.i4.1
    IL_0203: add
    IL_0204: stloc.s 41
    IL_0206: ldloc.s 41
    IL_0208: ldloc.s 7
    IL_020a: blt.s IL_01ec
    IL_020c: br.s IL_025b
    IL_020e: ldarg.0
    IL_020f: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0214: ldarg.s 6
    IL_0216: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_021b: ldarg.1
    IL_021c: ldc.i4.1
    IL_021d: ldc.i4.7
    IL_021e: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0223: stloc.s 7
    IL_0225: ldloc.s 5
    IL_0227: ldarg.0
    IL_0228: ldarg.1
    IL_0229: ldc.i4.0
    IL_022a: ldloca.s 6
    IL_022c: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_0231: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0236: ldc.i4.0
    IL_0237: stloc.s 42
    IL_0239: br.s IL_0255
    IL_023b: ldloc.s 5
    IL_023d: ldarg.0
    IL_023e: ldarg.1
    IL_023f: ldloc.s 6
    IL_0241: ldc.i4.1
    IL_0242: add
    IL_0243: ldloca.s 6
    IL_0245: call EternalTrialEnemy SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  /*0x0600071A*/
    IL_024a: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_024f: ldloc.s 42
    IL_0251: ldc.i4.1
    IL_0252: add
    IL_0253: stloc.s 42
    IL_0255: ldloc.s 42
    IL_0257: ldloc.s 7
    IL_0259: blt.s IL_023b
    IL_025b: ldloc.s 4
    IL_025d: brfalse.s IL_02c4
    IL_025f: ldarg.0
    IL_0260: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0265: ldarg.0
    IL_0266: ldfld List<EternalTrialEnemy> SuperWaveGen::removedEnemies  /*0x040008B0*/
    IL_026b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0002FA*/
    IL_0270: ldarg.0
    IL_0271: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0276: ldarg.s 6
    IL_0278: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_027d: ldarg.0
    IL_027e: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0283: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0288: stloc.s 43
    IL_028a: br.s IL_02ab
    IL_028c: ldloca.s 43
    IL_028e: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0293: stloc.s 44
    IL_0295: ldloc.s 5
    IL_0297: ldloc.s 44
    IL_0299: callvirt bool System.Collections.Generic.List<EternalTrialEnemy>::Contains(!0)  /*0x0A0002FF*/
    IL_029e: brtrue.s IL_02ab
    IL_02a0: ldloc.s 5
    IL_02a2: ldloc.s 44
    IL_02a4: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_02a9: leave.s IL_02c4
    IL_02ab: ldloca.s 43
    IL_02ad: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_02b2: brtrue.s IL_028c
    IL_02b4: leave.s IL_02c4
    IL_02b6: ldloca.s 43
    IL_02b8: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_02be: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02c3: endfinally
    IL_02c4: ldloc.s 5
    IL_02c6: call IEnumerable<!!0> System.Linq.Enumerable::Distinct(System.Collections.Generic.IEnumerable<!!0>)<EternalTrialEnemy>  /*0x2B000076*/
    IL_02cb: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<EternalTrialEnemy>  /*0x2B000077*/
    IL_02d0: stloc.s 5
    IL_02d2: ldloc.s 5
    IL_02d4: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_02d9: ldc.i4.0
    IL_02da: bgt.s IL_02f4
    IL_02dc: ldloc.s 5
    IL_02de: ldarg.0
    IL_02df: ldfld EternalTrialEnemySet SuperWaveGen::enemySet  /*0x04000893*/
    IL_02e4: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_02e9: ldc.i4.0
    IL_02ea: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_02ef: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_02f4: ldc.i4.1
    IL_02f5: stloc.s 8
    IL_02f7: ldloc.s 5
    IL_02f9: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_02fe: stloc.s 43
    IL_0300: br.s IL_0325
    IL_0302: ldloca.s 43
    IL_0304: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0309: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_030e: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0313: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0318: ldc.i4.6
    IL_0319: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_031e: brtrue.s IL_0325
    IL_0320: ldc.i4.0
    IL_0321: stloc.s 8
    IL_0323: leave.s IL_033e
    IL_0325: ldloca.s 43
    IL_0327: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_032c: brtrue.s IL_0302
    IL_032e: leave.s IL_033e
    IL_0330: ldloca.s 43
    IL_0332: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0338: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_033d: endfinally
    IL_033e: ldloc.s 8
    IL_0340: brfalse.s IL_03ab
    IL_0342: ldstr "Adding a ground enemy YO!"
    IL_0347: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_034c: ldarg.0
    IL_034d: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0352: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0357: stloc.s 43
    IL_0359: br.s IL_0392
    IL_035b: ldloca.s 43
    IL_035d: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0362: stloc.s 45
    IL_0364: ldloc.s 45
    IL_0366: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_036b: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0370: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0375: ldc.i4.6
    IL_0376: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_037b: brtrue.s IL_0392
    IL_037d: ldstr "Adding a ground enemy YO!"
    IL_0382: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0387: ldloc.s 5
    IL_0389: ldloc.s 45
    IL_038b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0390: leave.s IL_03ab
    IL_0392: ldloca.s 43
    IL_0394: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0399: brtrue.s IL_035b
    IL_039b: leave.s IL_03ab
    IL_039d: ldloca.s 43
    IL_039f: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_03a5: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_03aa: endfinally
    IL_03ab: ldloc.s 5
    IL_03ad: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_03b2: stloc.s 43
    IL_03b4: br.s IL_03e8
    IL_03b6: ldloca.s 43
    IL_03b8: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_03bd: dup
    IL_03be: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_03c3: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Clear()  /*0x0A000337*/
    IL_03c8: dup
    IL_03c9: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineTargetDifficulty()  /*0x060006DC*/
    IL_03ce: callvirt void System.Collections.Generic.List<float>::Clear()  /*0x0A000338*/
    IL_03d3: dup
    IL_03d4: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_03d9: callvirt void System.Collections.Generic.List<int>::Clear()  /*0x0A0000F5*/
    IL_03de: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_03e3: callvirt void System.Collections.Generic.List<int>::Clear()  /*0x0A0000F5*/
    IL_03e8: ldloca.s 43
    IL_03ea: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_03ef: brtrue.s IL_03b6
    IL_03f1: leave.s IL_0401
    IL_03f3: ldloca.s 43
    IL_03f5: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_03fb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0400: endfinally
    IL_0401: ldarg.0
    IL_0402: ldfld SuperWaveGen.ESpawnSelectMode SuperWaveGen::settingSpawnToPick  /*0x0400089F*/
    IL_0407: stloc.s 46
    IL_0409: ldloc.s 46
    IL_040b: switch (IL_043d, IL_0484, IL_04e5, IL_0560, IL_05b4, IL_0622, IL_06aa, IL_07fe, IL_0744, IL_08ab)
    IL_0438: br IL_0923
    IL_043d: ldloc.s 5
    IL_043f: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0444: stloc.s 43
    IL_0446: br.s IL_0468
    IL_0448: ldloca.s 43
    IL_044a: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_044f: stloc.s 47
    IL_0451: ldloc.s 47
    IL_0453: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0458: ldarg.0
    IL_0459: ldloc.s 47
    IL_045b: ldc.i4.0
    IL_045c: ldloca.s 6
    IL_045e: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0463: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0468: ldloca.s 43
    IL_046a: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_046f: brtrue.s IL_0448
    IL_0471: leave IL_0923
    IL_0476: ldloca.s 43
    IL_0478: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_047e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0483: endfinally
    IL_0484: ldloc.s 5
    IL_0486: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_048b: stloc.s 43
    IL_048d: br.s IL_04c9
    IL_048f: ldloca.s 43
    IL_0491: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0496: stloc.s 48
    IL_0498: ldloc.s 48
    IL_049a: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_049f: ldarg.0
    IL_04a0: ldloc.s 48
    IL_04a2: ldc.i4.0
    IL_04a3: ldloca.s 6
    IL_04a5: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_04aa: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_04af: ldloc.s 48
    IL_04b1: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_04b6: ldarg.0
    IL_04b7: ldloc.s 48
    IL_04b9: ldloc.s 6
    IL_04bb: ldc.i4.1
    IL_04bc: add
    IL_04bd: ldloca.s 6
    IL_04bf: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_04c4: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_04c9: ldloca.s 43
    IL_04cb: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_04d0: brtrue.s IL_048f
    IL_04d2: leave IL_0923
    IL_04d7: ldloca.s 43
    IL_04d9: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_04df: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_04e4: endfinally
    IL_04e5: ldloc.s 5
    IL_04e7: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_04ec: stloc.s 43
    IL_04ee: br.s IL_0544
    IL_04f0: ldloca.s 43
    IL_04f2: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_04f7: stloc.s 49
    IL_04f9: ldloc.s 49
    IL_04fb: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0500: ldarg.0
    IL_0501: ldloc.s 49
    IL_0503: ldc.i4.0
    IL_0504: ldloca.s 6
    IL_0506: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_050b: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0510: ldloc.s 49
    IL_0512: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0517: ldarg.0
    IL_0518: ldloc.s 49
    IL_051a: ldloc.s 6
    IL_051c: ldc.i4.1
    IL_051d: add
    IL_051e: ldloca.s 6
    IL_0520: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0525: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_052a: ldloc.s 49
    IL_052c: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0531: ldarg.0
    IL_0532: ldloc.s 49
    IL_0534: ldloc.s 6
    IL_0536: ldc.i4.1
    IL_0537: add
    IL_0538: ldloca.s 6
    IL_053a: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_053f: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0544: ldloca.s 43
    IL_0546: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_054b: brtrue.s IL_04f0
    IL_054d: leave IL_0923
    IL_0552: ldloca.s 43
    IL_0554: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_055a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_055f: endfinally
    IL_0560: ldarg.0
    IL_0561: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0566: ldarg.s 6
    IL_0568: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_056d: ldloc.s 5
    IL_056f: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0574: stloc.s 43
    IL_0576: br.s IL_0598
    IL_0578: ldloca.s 43
    IL_057a: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_057f: stloc.s 50
    IL_0581: ldloc.s 50
    IL_0583: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0588: ldarg.0
    IL_0589: ldloc.s 50
    IL_058b: ldc.i4.0
    IL_058c: ldloca.s 6
    IL_058e: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0593: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0598: ldloca.s 43
    IL_059a: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_059f: brtrue.s IL_0578
    IL_05a1: leave IL_0923
    IL_05a6: ldloca.s 43
    IL_05a8: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_05ae: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_05b3: endfinally
    IL_05b4: ldarg.0
    IL_05b5: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_05ba: ldarg.s 6
    IL_05bc: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_05c1: ldloc.s 5
    IL_05c3: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_05c8: stloc.s 43
    IL_05ca: br.s IL_0606
    IL_05cc: ldloca.s 43
    IL_05ce: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_05d3: stloc.s 51
    IL_05d5: ldloc.s 51
    IL_05d7: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_05dc: ldarg.0
    IL_05dd: ldloc.s 51
    IL_05df: ldc.i4.0
    IL_05e0: ldloca.s 6
    IL_05e2: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_05e7: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_05ec: ldloc.s 51
    IL_05ee: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_05f3: ldarg.0
    IL_05f4: ldloc.s 51
    IL_05f6: ldloc.s 6
    IL_05f8: ldc.i4.1
    IL_05f9: add
    IL_05fa: ldloca.s 6
    IL_05fc: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0601: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0606: ldloca.s 43
    IL_0608: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_060d: brtrue.s IL_05cc
    IL_060f: leave IL_0923
    IL_0614: ldloca.s 43
    IL_0616: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_061c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0621: endfinally
    IL_0622: ldarg.0
    IL_0623: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0628: ldarg.s 6
    IL_062a: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_062f: ldloc.s 5
    IL_0631: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0636: stloc.s 43
    IL_0638: br.s IL_068e
    IL_063a: ldloca.s 43
    IL_063c: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0641: stloc.s 52
    IL_0643: ldloc.s 52
    IL_0645: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_064a: ldarg.0
    IL_064b: ldloc.s 52
    IL_064d: ldc.i4.0
    IL_064e: ldloca.s 6
    IL_0650: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0655: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_065a: ldloc.s 52
    IL_065c: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0661: ldarg.0
    IL_0662: ldloc.s 52
    IL_0664: ldloc.s 6
    IL_0666: ldc.i4.1
    IL_0667: add
    IL_0668: ldloca.s 6
    IL_066a: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_066f: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0674: ldloc.s 52
    IL_0676: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_067b: ldarg.0
    IL_067c: ldloc.s 52
    IL_067e: ldloc.s 6
    IL_0680: ldc.i4.1
    IL_0681: add
    IL_0682: ldloca.s 6
    IL_0684: call EnemySpawnLine SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  /*0x0600071B*/
    IL_0689: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_068e: ldloca.s 43
    IL_0690: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0695: brtrue.s IL_063a
    IL_0697: leave IL_0923
    IL_069c: ldloca.s 43
    IL_069e: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_06a4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_06a9: endfinally
    IL_06aa: ldarg.0
    IL_06ab: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_06b0: ldarg.s 6
    IL_06b2: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_06b7: ldloc.s 5
    IL_06b9: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_06be: stloc.s 43
    IL_06c0: br.s IL_0728
    IL_06c2: ldloca.s 43
    IL_06c4: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_06c9: stloc.s 53
    IL_06cb: ldarg.0
    IL_06cc: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_06d1: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_06d6: stloc.s 55
    IL_06d8: br.s IL_06fd
    IL_06da: ldloca.s 55
    IL_06dc: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_06e1: stloc.s 56
    IL_06e3: ldarg.0
    IL_06e4: ldloc.s 53
    IL_06e6: ldloc.s 56
    IL_06e8: call bool SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  /*0x0600071C*/
    IL_06ed: brfalse.s IL_06fd
    IL_06ef: ldloc.s 53
    IL_06f1: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_06f6: ldloc.s 56
    IL_06f8: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_06fd: ldloca.s 55
    IL_06ff: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_0704: brtrue.s IL_06da
    IL_0706: leave.s IL_0716
    IL_0708: ldloca.s 55
    IL_070a: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_0710: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0715: endfinally
    IL_0716: ldloc.s 53
    IL_0718: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_071d: stloc.s 54
    IL_071f: ldloca.s 54
    IL_0721: ldarg.s 6
    IL_0723: call void SuperWaveGen::RemoveRandomInstances(ref System.Collections.Generic.List<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000078*/
    IL_0728: ldloca.s 43
    IL_072a: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_072f: brtrue.s IL_06c2
    IL_0731: leave IL_0923
    IL_0736: ldloca.s 43
    IL_0738: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_073e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0743: endfinally
    IL_0744: ldc.i4.1
    IL_0745: ldarg.1
    IL_0746: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_074b: stloc.s 9
    IL_074d: ldarg.0
    IL_074e: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0753: ldarg.s 6
    IL_0755: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_075a: ldloc.s 5
    IL_075c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0761: stloc.s 43
    IL_0763: br.s IL_07df
    IL_0765: ldloca.s 43
    IL_0767: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_076c: stloc.s 57
    IL_076e: ldarg.0
    IL_076f: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0774: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0779: stloc.s 55
    IL_077b: br.s IL_07a0
    IL_077d: ldloca.s 55
    IL_077f: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_0784: stloc.s 59
    IL_0786: ldarg.0
    IL_0787: ldloc.s 57
    IL_0789: ldloc.s 59
    IL_078b: call bool SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  /*0x0600071C*/
    IL_0790: brfalse.s IL_07a0
    IL_0792: ldloc.s 57
    IL_0794: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0799: ldloc.s 59
    IL_079b: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_07a0: ldloca.s 55
    IL_07a2: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_07a7: brtrue.s IL_077d
    IL_07a9: leave.s IL_07b9
    IL_07ab: ldloca.s 55
    IL_07ad: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_07b3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_07b8: endfinally
    IL_07b9: ldloc.s 57
    IL_07bb: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_07c0: stloc.s 58
    IL_07c2: br.s IL_07d4
    IL_07c4: ldloc.s 58
    IL_07c6: ldloc.s 58
    IL_07c8: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_07cd: ldc.i4.1
    IL_07ce: sub
    IL_07cf: callvirt void System.Collections.Generic.List<EnemySpawnLine>::RemoveAt(int)  /*0x0A000306*/
    IL_07d4: ldloc.s 58
    IL_07d6: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_07db: ldloc.s 9
    IL_07dd: bgt.s IL_07c4
    IL_07df: ldloca.s 43
    IL_07e1: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_07e6: brtrue IL_0765
    IL_07eb: leave IL_0923
    IL_07f0: ldloca.s 43
    IL_07f2: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_07f8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_07fd: endfinally
    IL_07fe: ldc.i4.1
    IL_07ff: ldarg.1
    IL_0800: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0805: stloc.s 9
    IL_0807: ldloc.s 5
    IL_0809: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_080e: stloc.s 43
    IL_0810: br.s IL_088c
    IL_0812: ldloca.s 43
    IL_0814: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0819: stloc.s 60
    IL_081b: ldarg.0
    IL_081c: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0821: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0826: stloc.s 55
    IL_0828: br.s IL_084d
    IL_082a: ldloca.s 55
    IL_082c: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_0831: stloc.s 62
    IL_0833: ldarg.0
    IL_0834: ldloc.s 60
    IL_0836: ldloc.s 62
    IL_0838: call bool SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  /*0x0600071C*/
    IL_083d: brfalse.s IL_084d
    IL_083f: ldloc.s 60
    IL_0841: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0846: ldloc.s 62
    IL_0848: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_084d: ldloca.s 55
    IL_084f: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_0854: brtrue.s IL_082a
    IL_0856: leave.s IL_0866
    IL_0858: ldloca.s 55
    IL_085a: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_0860: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0865: endfinally
    IL_0866: ldloc.s 60
    IL_0868: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_086d: stloc.s 61
    IL_086f: br.s IL_0881
    IL_0871: ldloc.s 61
    IL_0873: ldloc.s 61
    IL_0875: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_087a: ldc.i4.1
    IL_087b: sub
    IL_087c: callvirt void System.Collections.Generic.List<EnemySpawnLine>::RemoveAt(int)  /*0x0A000306*/
    IL_0881: ldloc.s 61
    IL_0883: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0888: ldloc.s 9
    IL_088a: bgt.s IL_0871
    IL_088c: ldloca.s 43
    IL_088e: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0893: brtrue IL_0812
    IL_0898: leave IL_0923
    IL_089d: ldloca.s 43
    IL_089f: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_08a5: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_08aa: endfinally
    IL_08ab: ldloc.s 5
    IL_08ad: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_08b2: stloc.s 43
    IL_08b4: br.s IL_090a
    IL_08b6: ldloca.s 43
    IL_08b8: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_08bd: stloc.s 63
    IL_08bf: ldarg.0
    IL_08c0: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_08c5: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_08ca: stloc.s 55
    IL_08cc: br.s IL_08f1
    IL_08ce: ldloca.s 55
    IL_08d0: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_08d5: stloc.s 64
    IL_08d7: ldarg.0
    IL_08d8: ldloc.s 63
    IL_08da: ldloc.s 64
    IL_08dc: call bool SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  /*0x0600071C*/
    IL_08e1: brfalse.s IL_08f1
    IL_08e3: ldloc.s 63
    IL_08e5: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_08ea: ldloc.s 64
    IL_08ec: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_08f1: ldloca.s 55
    IL_08f3: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_08f8: brtrue.s IL_08ce
    IL_08fa: leave.s IL_090a
    IL_08fc: ldloca.s 55
    IL_08fe: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_0904: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0909: endfinally
    IL_090a: ldloca.s 43
    IL_090c: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0911: brtrue.s IL_08b6
    IL_0913: leave.s IL_0923
    IL_0915: ldloca.s 43
    IL_0917: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_091d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0922: endfinally
    IL_0923: ldloc.2
    IL_0924: brfalse IL_09cc
    IL_0929: ldarg.0
    IL_092a: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_092f: ldarg.s 6
    IL_0931: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_0936: ldloc.s 5
    IL_0938: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_093d: stloc.s 43
    IL_093f: br.s IL_09b3
    IL_0941: ldloca.s 43
    IL_0943: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0948: stloc.s 65
    IL_094a: ldloc.s 65
    IL_094c: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0951: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Clear()  /*0x0A000337*/
    IL_0956: ldarg.0
    IL_0957: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_095c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0961: stloc.s 55
    IL_0963: br.s IL_0988
    IL_0965: ldloca.s 55
    IL_0967: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_096c: stloc.s 67
    IL_096e: ldarg.0
    IL_096f: ldloc.s 65
    IL_0971: ldloc.s 67
    IL_0973: call bool SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  /*0x0600071C*/
    IL_0978: brfalse.s IL_0988
    IL_097a: ldloc.s 65
    IL_097c: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0981: ldloc.s 67
    IL_0983: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0988: ldloca.s 55
    IL_098a: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_098f: brtrue.s IL_0965
    IL_0991: leave.s IL_09a1
    IL_0993: ldloca.s 55
    IL_0995: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_099b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_09a0: endfinally
    IL_09a1: ldloc.s 65
    IL_09a3: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_09a8: stloc.s 66
    IL_09aa: ldloca.s 66
    IL_09ac: ldarg.s 6
    IL_09ae: call void SuperWaveGen::RemoveRandomInstances(ref System.Collections.Generic.List<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000078*/
    IL_09b3: ldloca.s 43
    IL_09b5: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_09ba: brtrue.s IL_0941
    IL_09bc: leave.s IL_09cc
    IL_09be: ldloca.s 43
    IL_09c0: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_09c6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_09cb: endfinally
    IL_09cc: ldarg.0
    IL_09cd: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_09d2: ldarg.1
    IL_09d3: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_09d8: conv.r4
    IL_09d9: ldc.r4 2f
    IL_09de: mul
    IL_09df: ldc.r4 11f
    IL_09e4: add
    IL_09e5: stloc.s 10
    IL_09e7: ldarg.0
    IL_09e8: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_09ed: ldarg.1
    IL_09ee: ldelem.ref
    IL_09ef: ldloca.s 10
    IL_09f1: call string System.Single::ToString()  /*0x0A00030C*/
    IL_09f6: ldstr " Base Difficulty from Expected Defense Gold Spent ({0} Defense Power)"
    IL_09fb: ldarg.0
    IL_09fc: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_0a01: ldarg.1
    IL_0a02: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a07: box System.Int32  /*0x01000026*/
    IL_0a0c: call string System.String::Format(string,object)  /*0x0A00021A*/
    IL_0a11: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0a16: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0a1b: ldc.r4 1f
    IL_0a20: stloc.s 11
    IL_0a22: ldc.r4 1f
    IL_0a27: stloc.s 12
    IL_0a29: ldarg.0
    IL_0a2a: ldfld SuperWaveGen.ESpawnInDuration SuperWaveGen::settingSpawnInDuration  /*0x040008A0*/
    IL_0a2f: stloc.s 68
    IL_0a31: ldloc.s 68
    IL_0a33: switch (IL_0a52, IL_0a5b, IL_0a70, IL_0a85, IL_0a9a, IL_0ac2)
    IL_0a50: br.s IL_0acc
    IL_0a52: ldc.r4 1f
    IL_0a57: stloc.s 11
    IL_0a59: br.s IL_0acc
    IL_0a5b: ldc.r4 5.5f
    IL_0a60: ldc.r4 4f
    IL_0a65: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0a6a: mul
    IL_0a6b: add
    IL_0a6c: stloc.s 11
    IL_0a6e: br.s IL_0acc
    IL_0a70: ldc.r4 11.5f
    IL_0a75: ldc.r4 7f
    IL_0a7a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0a7f: mul
    IL_0a80: add
    IL_0a81: stloc.s 11
    IL_0a83: br.s IL_0acc
    IL_0a85: ldc.r4 25f
    IL_0a8a: ldc.r4 7f
    IL_0a8f: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0a94: mul
    IL_0a95: add
    IL_0a96: stloc.s 11
    IL_0a98: br.s IL_0acc
    IL_0a9a: ldc.r4 1f
    IL_0a9f: ldc.r4 30f
    IL_0aa4: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0aa9: mul
    IL_0aaa: add
    IL_0aab: stloc.s 11
    IL_0aad: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0ab2: ldc.r4 0.2f
    IL_0ab7: bge.un.s IL_0acc
    IL_0ab9: ldc.r4 2f
    IL_0abe: stloc.s 11
    IL_0ac0: br.s IL_0acc
    IL_0ac2: ldarg.1
    IL_0ac3: conv.r4
    IL_0ac4: ldc.r4 3f
    IL_0ac9: mul
    IL_0aca: stloc.s 11
    IL_0acc: ldloc.3
    IL_0acd: brfalse.s IL_0ae2
    IL_0acf: ldc.r4 40f
    IL_0ad4: ldc.r4 140f
    IL_0ad9: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0ade: mul
    IL_0adf: add
    IL_0ae0: stloc.s 11
    IL_0ae2: ldc.r4 1f
    IL_0ae7: ldloc.s 11
    IL_0ae9: ldc.r4 60f
    IL_0aee: div
    IL_0aef: add
    IL_0af0: stloc.s 12
    IL_0af2: ldarg.0
    IL_0af3: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0af8: ldarg.1
    IL_0af9: ldelem.ref
    IL_0afa: ldloca.s 12
    IL_0afc: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0b01: ldstr "x From spawn duration ("
    IL_0b06: ldloca.s 11
    IL_0b08: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0b0d: ldstr " sec)"
    IL_0b12: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0b17: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0b1c: ldloc.s 10
    IL_0b1e: ldloc.s 12
    IL_0b20: mul
    IL_0b21: stloc.s 10
    IL_0b23: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0b28: stloc.s 13
    IL_0b2a: ldloc.s 5
    IL_0b2c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0b31: stloc.s 43
    IL_0b33: br.s IL_0b80
    IL_0b35: ldloca.s 43
    IL_0b37: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0b3c: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0b41: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0b46: stloc.s 55
    IL_0b48: br.s IL_0b67
    IL_0b4a: ldloca.s 55
    IL_0b4c: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_0b51: stloc.s 69
    IL_0b53: ldloc.s 13
    IL_0b55: ldloc.s 69
    IL_0b57: callvirt bool System.Collections.Generic.List<EnemySpawnLine>::Contains(!0)  /*0x0A00033C*/
    IL_0b5c: brtrue.s IL_0b67
    IL_0b5e: ldloc.s 13
    IL_0b60: ldloc.s 69
    IL_0b62: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0b67: ldloca.s 55
    IL_0b69: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_0b6e: brtrue.s IL_0b4a
    IL_0b70: leave.s IL_0b80
    IL_0b72: ldloca.s 55
    IL_0b74: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_0b7a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0b7f: endfinally
    IL_0b80: ldloca.s 43
    IL_0b82: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0b87: brtrue.s IL_0b35
    IL_0b89: leave.s IL_0b99
    IL_0b8b: ldloca.s 43
    IL_0b8d: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0b93: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0b98: endfinally
    IL_0b99: ldc.r4 0f
    IL_0b9e: stloc.s 14
    IL_0ba0: ldc.i4.0
    IL_0ba1: stloc.s 15
    IL_0ba3: ldc.i4.0
    IL_0ba4: stloc.s 70
    IL_0ba6: br IL_0c4e
    IL_0bab: ldloc.s 70
    IL_0bad: ldc.i4.1
    IL_0bae: add
    IL_0baf: stloc.s 71
    IL_0bb1: br IL_0c3a
    IL_0bb6: ldloc.s 15
    IL_0bb8: ldc.i4.1
    IL_0bb9: add
    IL_0bba: stloc.s 15
    IL_0bbc: ldloc.s 13
    IL_0bbe: ldloc.s 70
    IL_0bc0: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0bc5: stloc.s 72
    IL_0bc7: ldloc.s 13
    IL_0bc9: ldloc.s 71
    IL_0bcb: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0bd0: stloc.s 73
    IL_0bd2: ldloc.s 72
    IL_0bd4: ldfld List<EnemySpawnLine> EnemySpawnLine::mostlySharedAttackpaths  /*0x04000830*/
    IL_0bd9: ldloc.s 73
    IL_0bdb: callvirt bool System.Collections.Generic.List<EnemySpawnLine>::Contains(!0)  /*0x0A00033C*/
    IL_0be0: brtrue.s IL_0bf2
    IL_0be2: ldloc.s 73
    IL_0be4: ldfld List<EnemySpawnLine> EnemySpawnLine::mostlySharedAttackpaths  /*0x04000830*/
    IL_0be9: ldloc.s 72
    IL_0beb: callvirt bool System.Collections.Generic.List<EnemySpawnLine>::Contains(!0)  /*0x0A00033C*/
    IL_0bf0: brfalse.s IL_0bfe
    IL_0bf2: ldloc.s 14
    IL_0bf4: ldc.r4 1f
    IL_0bf9: add
    IL_0bfa: stloc.s 14
    IL_0bfc: br.s IL_0c34
    IL_0bfe: ldloc.s 72
    IL_0c00: ldfld List<EnemySpawnLine> EnemySpawnLine::mostlySeperatedAttackPaths  /*0x04000831*/
    IL_0c05: ldloc.s 73
    IL_0c07: callvirt bool System.Collections.Generic.List<EnemySpawnLine>::Contains(!0)  /*0x0A00033C*/
    IL_0c0c: brtrue.s IL_0c1e
    IL_0c0e: ldloc.s 73
    IL_0c10: ldfld List<EnemySpawnLine> EnemySpawnLine::mostlySeperatedAttackPaths  /*0x04000831*/
    IL_0c15: ldloc.s 72
    IL_0c17: callvirt bool System.Collections.Generic.List<EnemySpawnLine>::Contains(!0)  /*0x0A00033C*/
    IL_0c1c: brfalse.s IL_0c2a
    IL_0c1e: ldloc.s 14
    IL_0c20: ldc.r4 0.8f
    IL_0c25: add
    IL_0c26: stloc.s 14
    IL_0c28: br.s IL_0c34
    IL_0c2a: ldloc.s 14
    IL_0c2c: ldc.r4 0.9f
    IL_0c31: add
    IL_0c32: stloc.s 14
    IL_0c34: ldloc.s 71
    IL_0c36: ldc.i4.1
    IL_0c37: add
    IL_0c38: stloc.s 71
    IL_0c3a: ldloc.s 71
    IL_0c3c: ldloc.s 13
    IL_0c3e: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0c43: blt IL_0bb6
    IL_0c48: ldloc.s 70
    IL_0c4a: ldc.i4.1
    IL_0c4b: add
    IL_0c4c: stloc.s 70
    IL_0c4e: ldloc.s 70
    IL_0c50: ldloc.s 13
    IL_0c52: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0c57: blt IL_0bab
    IL_0c5c: ldloc.s 15
    IL_0c5e: ldc.i4.0
    IL_0c5f: bgt.s IL_0c68
    IL_0c61: ldc.r4 1f
    IL_0c66: br.s IL_0c6e
    IL_0c68: ldloc.s 14
    IL_0c6a: ldloc.s 15
    IL_0c6c: conv.r4
    IL_0c6d: div
    IL_0c6e: stloc.s 16
    IL_0c70: ldc.r4 0.98f
    IL_0c75: ldloc.s 13
    IL_0c77: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0c7c: ldc.i4.2
    IL_0c7d: sub
    IL_0c7e: conv.r4
    IL_0c7f: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0c84: ldloc.s 16
    IL_0c86: mul
    IL_0c87: stloc.s 17
    IL_0c89: ldarg.0
    IL_0c8a: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0c8f: ldarg.1
    IL_0c90: ldelem.ref
    IL_0c91: ldc.i4.6
    IL_0c92: newarr System.String  /*0x0100001D*/
    IL_0c97: dup
    IL_0c98: ldc.i4.0
    IL_0c99: ldloca.s 17
    IL_0c9b: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0ca0: stelem.ref
    IL_0ca1: dup
    IL_0ca2: ldc.i4.1
    IL_0ca3: ldstr "x From count ("
    IL_0ca8: stelem.ref
    IL_0ca9: dup
    IL_0caa: ldc.i4.2
    IL_0cab: ldloc.s 13
    IL_0cad: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0cb2: stloc.s 74
    IL_0cb4: ldloca.s 74
    IL_0cb6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0cbb: stelem.ref
    IL_0cbc: dup
    IL_0cbd: ldc.i4.3
    IL_0cbe: ldstr " spawns and average relationship strength of "
    IL_0cc3: stelem.ref
    IL_0cc4: dup
    IL_0cc5: ldc.i4.4
    IL_0cc6: ldloca.s 16
    IL_0cc8: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0ccd: stelem.ref
    IL_0cce: dup
    IL_0ccf: ldc.i4.5
    IL_0cd0: ldstr ")"
    IL_0cd5: stelem.ref
    IL_0cd6: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0cdb: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0ce0: ldloc.s 10
    IL_0ce2: ldloc.s 17
    IL_0ce4: mul
    IL_0ce5: stloc.s 10
    IL_0ce7: ldc.r4 0f
    IL_0cec: stloc.s 18
    IL_0cee: ldloc.s 13
    IL_0cf0: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0cf5: stloc.s 55
    IL_0cf7: br.s IL_0d0e
    IL_0cf9: ldloca.s 55
    IL_0cfb: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_0d00: stloc.s 75
    IL_0d02: ldloc.s 18
    IL_0d04: ldloc.s 75
    IL_0d06: callvirt float EnemySpawnLine::get_DifficultyBudgetMultiplyer()  /*0x060006D1*/
    IL_0d0b: add
    IL_0d0c: stloc.s 18
    IL_0d0e: ldloca.s 55
    IL_0d10: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_0d15: brtrue.s IL_0cf9
    IL_0d17: leave.s IL_0d27
    IL_0d19: ldloca.s 55
    IL_0d1b: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_0d21: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0d26: endfinally
    IL_0d27: ldloc.s 18
    IL_0d29: ldloc.s 13
    IL_0d2b: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0d30: conv.r4
    IL_0d31: div
    IL_0d32: stloc.s 18
    IL_0d34: ldarg.0
    IL_0d35: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0d3a: ldarg.1
    IL_0d3b: ldelem.ref
    IL_0d3c: ldloca.s 18
    IL_0d3e: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0d43: ldstr "x From spawn difficulty (e.g. proximity to base)."
    IL_0d48: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0d4d: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0d52: ldloc.s 10
    IL_0d54: ldloc.s 18
    IL_0d56: mul
    IL_0d57: stloc.s 10
    IL_0d59: ldarg.1
    IL_0d5a: ldarg.2
    IL_0d5b: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0d60: ldc.i4.1
    IL_0d61: sub
    IL_0d62: bne.un.s IL_0d90
    IL_0d64: ldc.r4 1.05f
    IL_0d69: stloc.s 76
    IL_0d6b: ldarg.0
    IL_0d6c: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0d71: ldarg.1
    IL_0d72: ldelem.ref
    IL_0d73: ldloca.s 76
    IL_0d75: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0d7a: ldstr "x From final night difficulty bonus."
    IL_0d7f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0d84: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0d89: ldloc.s 10
    IL_0d8b: ldloc.s 76
    IL_0d8d: mul
    IL_0d8e: stloc.s 10
    IL_0d90: ldarg.3
    IL_0d91: ldc.i4.0
    IL_0d92: ldc.i4.5
    IL_0d93: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0d98: stloc.s 19
    IL_0d9a: ldarg.3
    IL_0d9b: ldloc.s 19
    IL_0d9d: sub
    IL_0d9e: stloc.s 20
    IL_0da0: ldc.r4 1.2f
    IL_0da5: ldloc.s 19
    IL_0da7: ldc.i4.2
    IL_0da8: sub
    IL_0da9: conv.r4
    IL_0daa: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0daf: ldloc.s 20
    IL_0db1: conv.r4
    IL_0db2: ldc.r4 0.3f
    IL_0db7: mul
    IL_0db8: add
    IL_0db9: stloc.s 21
    IL_0dbb: ldarg.0
    IL_0dbc: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_0dc1: ldarg.1
    IL_0dc2: ldelem.ref
    IL_0dc3: ldloca.s 21
    IL_0dc5: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0dca: ldstr "x From current stage (stage "
    IL_0dcf: ldarga.s 3
    IL_0dd1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0dd6: ldstr ")."
    IL_0ddb: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0de0: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0de5: ldloc.s 10
    IL_0de7: ldloc.s 21
    IL_0de9: mul
    IL_0dea: stloc.s 10
    IL_0dec: ldarg.0
    IL_0ded: ldfld float[] SuperWaveGen::targetDifficultyInNight  /*0x040008A7*/
    IL_0df2: ldarg.1
    IL_0df3: ldloc.s 10
    IL_0df5: stelem.r4
    IL_0df6: ldc.r4 0f
    IL_0dfb: stloc.s 22
    IL_0dfd: ldc.r4 0f
    IL_0e02: stloc.s 23
    IL_0e04: ldc.i4.0
    IL_0e05: stloc.s 24
    IL_0e07: ldc.i4.0
    IL_0e08: stloc.s 25
    IL_0e0a: ldloc.s 5
    IL_0e0c: ldarg.s 6
    IL_0e0e: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_0e13: ldc.r4 0f
    IL_0e18: stloc.s 26
    IL_0e1a: ldloc.s 5
    IL_0e1c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0e21: stloc.s 43
    IL_0e23: br.s IL_0e3a
    IL_0e25: ldloca.s 43
    IL_0e27: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0e2c: stloc.s 77
    IL_0e2e: ldloc.s 26
    IL_0e30: ldloc.s 77
    IL_0e32: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_0e37: add
    IL_0e38: stloc.s 26
    IL_0e3a: ldloca.s 43
    IL_0e3c: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0e41: brtrue.s IL_0e25
    IL_0e43: leave.s IL_0e53
    IL_0e45: ldloca.s 43
    IL_0e47: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0e4d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0e52: endfinally
    IL_0e53: ldc.r4 1f
    IL_0e58: stloc.s 27
    IL_0e5a: ldc.i4.0
    IL_0e5b: stloc.s 78
    IL_0e5d: br IL_106f
    IL_0e62: ldloc.s 5
    IL_0e64: ldloc.s 78
    IL_0e66: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0e6b: stloc.s 79
    IL_0e6d: ldloc.s 78
    IL_0e6f: ldloc.s 5
    IL_0e71: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0e76: ldc.i4.1
    IL_0e77: sub
    IL_0e78: ceq
    IL_0e7a: stloc.s 80
    IL_0e7c: ldarg.0
    IL_0e7d: ldfld SuperWaveGen.EDistributeDifficulty SuperWaveGen::settingEDistributeDifficulty  /*0x040008A3*/
    IL_0e82: stloc.s 82
    IL_0e84: ldarg.s 5
    IL_0e86: brfalse.s IL_0e8b
    IL_0e88: ldc.i4.0
    IL_0e89: stloc.s 82
    IL_0e8b: ldloc.s 82
    IL_0e8d: switch (IL_0eab, IL_0ec2, IL_0edf, IL_0f38, IL_0f11)
    IL_0ea6: br IL_0f75
    IL_0eab: ldloc.s 79
    IL_0ead: ldloc.s 10
    IL_0eaf: ldloc.s 5
    IL_0eb1: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0eb6: conv.r4
    IL_0eb7: div
    IL_0eb8: callvirt void EternalTrialEnemy::set_TempTargetDifficulty(float)  /*0x060006DF*/
    IL_0ebd: br IL_0f75
    IL_0ec2: ldloc.s 79
    IL_0ec4: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_0ec9: ldloc.s 26
    IL_0ecb: div
    IL_0ecc: stloc.s 81
    IL_0ece: ldloc.s 79
    IL_0ed0: ldloc.s 10
    IL_0ed2: ldloc.s 81
    IL_0ed4: mul
    IL_0ed5: callvirt void EternalTrialEnemy::set_TempTargetDifficulty(float)  /*0x060006DF*/
    IL_0eda: br IL_0f75
    IL_0edf: ldloc.s 79
    IL_0ee1: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_0ee6: ldloc.s 26
    IL_0ee8: div
    IL_0ee9: stloc.s 81
    IL_0eeb: ldloc.s 79
    IL_0eed: ldloc.s 10
    IL_0eef: ldloc.s 81
    IL_0ef1: mul
    IL_0ef2: ldc.r4 0.5f
    IL_0ef7: mul
    IL_0ef8: ldloc.s 10
    IL_0efa: ldloc.s 5
    IL_0efc: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0f01: conv.r4
    IL_0f02: div
    IL_0f03: ldc.r4 0.5f
    IL_0f08: mul
    IL_0f09: add
    IL_0f0a: callvirt void EternalTrialEnemy::set_TempTargetDifficulty(float)  /*0x060006DF*/
    IL_0f0f: br.s IL_0f75
    IL_0f11: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0f16: ldloc.s 27
    IL_0f18: mul
    IL_0f19: stloc.s 81
    IL_0f1b: ldloc.s 80
    IL_0f1d: brfalse.s IL_0f23
    IL_0f1f: ldloc.s 27
    IL_0f21: stloc.s 81
    IL_0f23: ldloc.s 27
    IL_0f25: ldloc.s 81
    IL_0f27: sub
    IL_0f28: stloc.s 27
    IL_0f2a: ldloc.s 79
    IL_0f2c: ldloc.s 10
    IL_0f2e: ldloc.s 81
    IL_0f30: mul
    IL_0f31: callvirt void EternalTrialEnemy::set_TempTargetDifficulty(float)  /*0x060006DF*/
    IL_0f36: br.s IL_0f75
    IL_0f38: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0f3d: ldloc.s 27
    IL_0f3f: mul
    IL_0f40: stloc.s 81
    IL_0f42: ldloc.s 80
    IL_0f44: brfalse.s IL_0f4a
    IL_0f46: ldloc.s 27
    IL_0f48: stloc.s 81
    IL_0f4a: ldloc.s 27
    IL_0f4c: ldloc.s 81
    IL_0f4e: sub
    IL_0f4f: stloc.s 27
    IL_0f51: ldloc.s 79
    IL_0f53: ldloc.s 10
    IL_0f55: ldloc.s 81
    IL_0f57: mul
    IL_0f58: ldc.r4 0.5f
    IL_0f5d: mul
    IL_0f5e: ldloc.s 10
    IL_0f60: ldloc.s 5
    IL_0f62: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0f67: conv.r4
    IL_0f68: div
    IL_0f69: ldc.r4 0.5f
    IL_0f6e: mul
    IL_0f6f: add
    IL_0f70: callvirt void EternalTrialEnemy::set_TempTargetDifficulty(float)  /*0x060006DF*/
    IL_0f75: ldc.r4 0f
    IL_0f7a: stloc.s 83
    IL_0f7c: ldloc.s 79
    IL_0f7e: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0f83: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnemySpawnLine>::GetEnumerator()  /*0x0A000339*/
    IL_0f88: stloc.s 55
    IL_0f8a: br IL_103d
    IL_0f8f: ldloca.s 55
    IL_0f91: call !0 System.Collections.Generic.List.Enumerator<EnemySpawnLine>::get_Current()  /*0x0A00033A*/
    IL_0f96: pop
    IL_0f97: ldloc.s 79
    IL_0f99: callvirt float EternalTrialEnemy::get_TempTargetDifficulty()  /*0x060006DE*/
    IL_0f9e: ldloc.s 79
    IL_0fa0: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_0fa5: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0faa: conv.r4
    IL_0fab: div
    IL_0fac: stloc.s 84
    IL_0fae: ldloc.s 79
    IL_0fb0: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineTargetDifficulty()  /*0x060006DC*/
    IL_0fb5: ldloc.s 84
    IL_0fb7: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_0fbc: ldc.i4.1
    IL_0fbd: ldloc.s 84
    IL_0fbf: ldloc.s 79
    IL_0fc1: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_0fc6: div
    IL_0fc7: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0fcc: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0fd1: stloc.s 85
    IL_0fd3: ldloc.s 25
    IL_0fd5: ldloc.s 85
    IL_0fd7: add
    IL_0fd8: stloc.s 25
    IL_0fda: ldloc.s 79
    IL_0fdc: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0fe1: ldloc.s 85
    IL_0fe3: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0fe8: ldloc.s 85
    IL_0fea: conv.r4
    IL_0feb: ldloc.s 79
    IL_0fed: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_0ff2: mul
    IL_0ff3: stloc.s 86
    IL_0ff5: ldloc.s 79
    IL_0ff7: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineActualDifficulty()  /*0x060006DD*/
    IL_0ffc: ldloc.s 86
    IL_0ffe: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_1003: ldloc.s 83
    IL_1005: ldloc.s 86
    IL_1007: add
    IL_1008: stloc.s 83
    IL_100a: ldloc.s 23
    IL_100c: ldloc.1
    IL_100d: conv.r4
    IL_100e: ldloc.s 84
    IL_1010: ldloc.s 10
    IL_1012: div
    IL_1013: mul
    IL_1014: add
    IL_1015: stloc.s 23
    IL_1017: ldloc.s 23
    IL_1019: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_101e: stloc.s 87
    IL_1020: ldloc.s 24
    IL_1022: ldloc.s 87
    IL_1024: add
    IL_1025: stloc.s 24
    IL_1027: ldloc.s 23
    IL_1029: ldloc.s 87
    IL_102b: conv.r4
    IL_102c: sub
    IL_102d: stloc.s 23
    IL_102f: ldloc.s 79
    IL_1031: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_1036: ldloc.s 87
    IL_1038: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_103d: ldloca.s 55
    IL_103f: call bool System.Collections.Generic.List.Enumerator<EnemySpawnLine>::MoveNext()  /*0x0A00033B*/
    IL_1044: brtrue IL_0f8f
    IL_1049: leave.s IL_1059
    IL_104b: ldloca.s 55
    IL_104d: constrained. System.Collections.Generic.List.Enumerator<EnemySpawnLine>  /*0x1B000097*/
    IL_1053: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_1058: endfinally
    IL_1059: ldloc.s 79
    IL_105b: ldloc.s 83
    IL_105d: callvirt void EternalTrialEnemy::set_TempActualDifficulty(float)  /*0x060006E1*/
    IL_1062: ldloc.s 22
    IL_1064: ldloc.s 83
    IL_1066: add
    IL_1067: stloc.s 22
    IL_1069: ldloc.s 78
    IL_106b: ldc.i4.1
    IL_106c: add
    IL_106d: stloc.s 78
    IL_106f: ldloc.s 78
    IL_1071: ldloc.s 5
    IL_1073: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_1078: blt IL_0e62
    IL_107d: ldloc.s 5
    IL_107f: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_1084: stloc.s 43
    IL_1086: br IL_1192
    IL_108b: ldloca.s 43
    IL_108d: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_1092: stloc.s 88
    IL_1094: ldc.i4.0
    IL_1095: stloc.s 89
    IL_1097: br IL_1175
    IL_109c: ldloc.s 88
    IL_109e: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineActualDifficulty()  /*0x060006DD*/
    IL_10a3: ldloc.s 89
    IL_10a5: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_10aa: stloc.s 90
    IL_10ac: ldloc.s 88
    IL_10ae: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineTargetDifficulty()  /*0x060006DC*/
    IL_10b3: ldloc.s 89
    IL_10b5: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_10ba: stloc.s 91
    IL_10bc: ldloc.s 91
    IL_10be: ldloc.s 10
    IL_10c0: ldloc.s 22
    IL_10c2: sub
    IL_10c3: add
    IL_10c4: stloc.s 91
    IL_10c6: ldloc.s 22
    IL_10c8: ldloc.s 90
    IL_10ca: bne.un.s IL_10d5
    IL_10cc: ldloc.s 22
    IL_10ce: ldloc.s 90
    IL_10d0: bgt IL_116f
    IL_10d5: ldloc.s 88
    IL_10d7: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_10dc: ldloc.s 89
    IL_10de: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_10e3: stloc.s 92
    IL_10e5: ldarg.0
    IL_10e6: ldloc.s 88
    IL_10e8: ldloc.s 91
    IL_10ea: ldloc.s 90
    IL_10ec: call Tuple<float, int> SuperWaveGen::AdjustSpawnDifficulty(EternalTrialEnemy,float,float)  /*0x0600071D*/
    IL_10f1: stloc.s 93
    IL_10f3: ldloc.s 93
    IL_10f5: callvirt !1 System.Tuple<float, int>::get_Item2()  /*0x0A00033D*/
    IL_10fa: ldloc.s 92
    IL_10fc: sub
    IL_10fd: stloc.s 94
    IL_10ff: ldloc.s 25
    IL_1101: ldloc.s 94
    IL_1103: add
    IL_1104: ldc.i4.0
    IL_1105: ble.s IL_116f
    IL_1107: ldloc.s 25
    IL_1109: ldloc.s 94
    IL_110b: add
    IL_110c: stloc.s 25
    IL_110e: ldloc.s 88
    IL_1110: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_1115: ldloc.s 89
    IL_1117: ldloc.s 93
    IL_1119: callvirt !1 System.Tuple<float, int>::get_Item2()  /*0x0A00033D*/
    IL_111e: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_1123: ldloc.s 88
    IL_1125: callvirt List<float> EternalTrialEnemy::get_TempSpawnLineActualDifficulty()  /*0x060006DD*/
    IL_112a: ldloc.s 89
    IL_112c: ldloc.s 93
    IL_112e: callvirt !0 System.Tuple<float, int>::get_Item1()  /*0x0A00033E*/
    IL_1133: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_1138: ldloc.s 88
    IL_113a: ldarg.0
    IL_113b: ldloc.s 88
    IL_113d: call float SuperWaveGen::CalculateActualDifficulty(EternalTrialEnemy)  /*0x0600071F*/
    IL_1142: callvirt void EternalTrialEnemy::set_TempActualDifficulty(float)  /*0x060006E1*/
    IL_1147: ldloc.s 5
    IL_1149: ldsfld Func<EternalTrialEnemy, float> SuperWaveGen.<>c::<>9__45_0  /*0x04000910*/
    IL_114e: dup
    IL_114f: brtrue.s IL_1168
    IL_1151: pop
    IL_1152: ldsfld SuperWaveGen.<>c SuperWaveGen.<>c::<>9  /*0x0400090F*/
    IL_1157: ldftn float SuperWaveGen.<>c::<GenerateWave>b__45_0(EternalTrialEnemy)  /*0x0600072B*/
    IL_115d: newobj void System.Func<EternalTrialEnemy, float>::.ctor(object,IntPtr)  /*0x0A00033F*/
    IL_1162: dup
    IL_1163: stsfld Func<EternalTrialEnemy, float> SuperWaveGen.<>c::<>9__45_0  /*0x04000910*/
    IL_1168: call float System.Linq.Enumerable::Sum(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, float>)<EternalTrialEnemy>  /*0x2B000079*/
    IL_116d: stloc.s 22
    IL_116f: ldloc.s 89
    IL_1171: ldc.i4.1
    IL_1172: add
    IL_1173: stloc.s 89
    IL_1175: ldloc.s 89
    IL_1177: ldloc.s 88
    IL_1179: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_117e: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_1183: blt IL_109c
    IL_1188: ldarg.0
    IL_1189: ldloc.s 88
    IL_118b: ldloc.s 5
    IL_118d: call void SuperWaveGen::AdjustGoldAllocation(EternalTrialEnemy,System.Collections.Generic.List<EternalTrialEnemy>)  /*0x0600071E*/
    IL_1192: ldloca.s 43
    IL_1194: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_1199: brtrue IL_108b
    IL_119e: leave.s IL_11ae
    IL_11a0: ldloca.s 43
    IL_11a2: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_11a8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_11ad: endfinally
    IL_11ae: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_11b3: stloc.s 28
    IL_11b5: ldloc.s 5
    IL_11b7: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_11bc: stloc.s 43
    IL_11be: br.s IL_1224
    IL_11c0: ldloca.s 43
    IL_11c2: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_11c7: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_11cc: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_11d1: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_11d6: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_11db: stloc.s 95
    IL_11dd: br.s IL_120b
    IL_11df: ldloca.s 95
    IL_11e1: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_11e6: stloc.s 96
    IL_11e8: ldloc.s 28
    IL_11ea: ldloc.s 96
    IL_11ec: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_11f1: brtrue.s IL_120b
    IL_11f3: ldarg.0
    IL_11f4: ldfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_11f9: ldloc.s 96
    IL_11fb: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_1200: brfalse.s IL_120b
    IL_1202: ldloc.s 28
    IL_1204: ldloc.s 96
    IL_1206: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_120b: ldloca.s 95
    IL_120d: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_1212: brtrue.s IL_11df
    IL_1214: leave.s IL_1224
    IL_1216: ldloca.s 95
    IL_1218: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_121e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_1223: endfinally
    IL_1224: ldloca.s 43
    IL_1226: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_122b: brtrue.s IL_11c0
    IL_122d: leave.s IL_123d
    IL_122f: ldloca.s 43
    IL_1231: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_1237: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_123c: endfinally
    IL_123d: ldarg.0
    IL_123e: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_1243: ldarg.1
    IL_1244: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_1249: conv.r4
    IL_124a: stloc.s 29
    IL_124c: ldarg.1
    IL_124d: ldc.i4.0
    IL_124e: ble.s IL_126e
    IL_1250: ldarg.0
    IL_1251: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_1256: ldarg.1
    IL_1257: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_125c: ldarg.0
    IL_125d: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_1262: ldarg.1
    IL_1263: ldc.i4.1
    IL_1264: sub
    IL_1265: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_126a: sub
    IL_126b: conv.r4
    IL_126c: stloc.s 29
    IL_126e: ldloc.s 29
    IL_1270: ldloc.s 28
    IL_1272: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_1277: conv.r4
    IL_1278: div
    IL_1279: stloc.s 30
    IL_127b: ldc.i4.0
    IL_127c: stloc.s 97
    IL_127e: br.s IL_12af
    IL_1280: ldloc.s 28
    IL_1282: ldarg.0
    IL_1283: ldfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_1288: ldloc.s 97
    IL_128a: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_128f: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_1294: brfalse.s IL_12a9
    IL_1296: ldarg.0
    IL_1297: ldfld float[] SuperWaveGen::tagsCountered  /*0x040008A6*/
    IL_129c: ldloc.s 97
    IL_129e: ldelema System.Single  /*0x01000052*/
    IL_12a3: dup
    IL_12a4: ldind.r4
    IL_12a5: ldloc.s 30
    IL_12a7: add
    IL_12a8: stind.r4
    IL_12a9: ldloc.s 97
    IL_12ab: ldc.i4.1
    IL_12ac: add
    IL_12ad: stloc.s 97
    IL_12af: ldloc.s 97
    IL_12b1: ldarg.0
    IL_12b2: ldfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_12b7: callvirt int System.Collections.Generic.List<TagManager.ETag>::get_Count()  /*0x0A00019C*/
    IL_12bc: blt.s IL_1280
    IL_12be: ldarg.0
    IL_12bf: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_12c4: ldarg.1
    IL_12c5: ldelem.ref
    IL_12c6: ldstr "---------------"
    IL_12cb: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_12d0: ldarg.0
    IL_12d1: ldfld EternalTrialEnemySet SuperWaveGen::enemySet  /*0x04000893*/
    IL_12d6: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_12db: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_12e0: stloc.s 43
    IL_12e2: br IL_13da
    IL_12e7: ldloca.s 43
    IL_12e9: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_12ee: stloc.s 98
    IL_12f0: ldc.i4.0
    IL_12f1: stloc.s 99
    IL_12f3: ldloc.s 98
    IL_12f5: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_12fa: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_12ff: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_1304: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_1309: stloc.s 95
    IL_130b: br.s IL_1339
    IL_130d: ldloca.s 95
    IL_130f: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_1314: stloc.s 101
    IL_1316: ldarg.0
    IL_1317: ldfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_131c: ldloc.s 101
    IL_131e: callvirt int System.Collections.Generic.List<TagManager.ETag>::IndexOf(!0)  /*0x0A000341*/
    IL_1323: stloc.s 102
    IL_1325: ldloc.s 102
    IL_1327: ldc.i4.m1
    IL_1328: beq.s IL_1339
    IL_132a: ldloc.s 99
    IL_132c: ldarg.0
    IL_132d: ldfld float[] SuperWaveGen::tagsCountered  /*0x040008A6*/
    IL_1332: ldloc.s 102
    IL_1334: ldelem.r4
    IL_1335: conv.i4
    IL_1336: add
    IL_1337: stloc.s 99
    IL_1339: ldloca.s 95
    IL_133b: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_1340: brtrue.s IL_130d
    IL_1342: leave.s IL_1352
    IL_1344: ldloca.s 95
    IL_1346: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_134c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_1351: endfinally
    IL_1352: ldloc.s 98
    IL_1354: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_1359: stloc.s 100
    IL_135b: ldloc.s 98
    IL_135d: ldloc.s 98
    IL_135f: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_1364: ldc.r4 0.996f
    IL_1369: ldloc.s 99
    IL_136b: conv.r4
    IL_136c: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_1371: ldc.r4 0.4f
    IL_1376: ldc.r4 1f
    IL_137b: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_1380: mul
    IL_1381: callvirt void EternalTrialEnemy::set_DifficultyValueTemp(float)  /*0x060006D9*/
    IL_1386: ldarg.0
    IL_1387: ldfld List<string>[] SuperWaveGen::difficultyContributionsInNight  /*0x040008A8*/
    IL_138c: ldarg.1
    IL_138d: ldelem.ref
    IL_138e: ldc.i4.5
    IL_138f: newarr System.String  /*0x0100001D*/
    IL_1394: dup
    IL_1395: ldc.i4.0
    IL_1396: ldloc.s 98
    IL_1398: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_139d: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_13a2: stelem.ref
    IL_13a3: dup
    IL_13a4: ldc.i4.1
    IL_13a5: ldstr " difficulty reduced from "
    IL_13aa: stelem.ref
    IL_13ab: dup
    IL_13ac: ldc.i4.2
    IL_13ad: ldloca.s 100
    IL_13af: call string System.Single::ToString()  /*0x0A00030C*/
    IL_13b4: stelem.ref
    IL_13b5: dup
    IL_13b6: ldc.i4.3
    IL_13b7: ldstr " to "
    IL_13bc: stelem.ref
    IL_13bd: dup
    IL_13be: ldc.i4.4
    IL_13bf: ldloc.s 98
    IL_13c1: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_13c6: stloc.s 103
    IL_13c8: ldloca.s 103
    IL_13ca: call string System.Single::ToString()  /*0x0A00030C*/
    IL_13cf: stelem.ref
    IL_13d0: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_13d5: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_13da: ldloca.s 43
    IL_13dc: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_13e1: brtrue IL_12e7
    IL_13e6: leave.s IL_13f6
    IL_13e8: ldloca.s 43
    IL_13ea: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_13f0: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_13f5: endfinally
    IL_13f6: ldc.i4.0
    IL_13f7: stloc.s 31
    IL_13f9: ldloc.s 5
    IL_13fb: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_1400: stloc.s 43
    IL_1402: br IL_14a3
    IL_1407: ldloca.s 43
    IL_1409: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_140e: stloc.s 104
    IL_1410: ldc.i4.0
    IL_1411: stloc.s 105
    IL_1413: br.s IL_1490
    IL_1415: ldloc.s 104
    IL_1417: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_141c: ldloc.s 105
    IL_141e: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_1423: ldc.i4.0
    IL_1424: ble.s IL_148a
    IL_1426: ldloc.0
    IL_1427: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_142c: ldloc.s 104
    IL_142e: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_1433: ldloc.s 104
    IL_1435: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_143a: ldloc.s 105
    IL_143c: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_1441: callvirt Transform EnemySpawnLine::get_SpawnLine()  /*0x060006D2*/
    IL_1446: ldloc.s 104
    IL_1448: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_144d: ldloc.s 105
    IL_144f: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_1454: ldc.r4 0.2f
    IL_1459: ldloc.s 104
    IL_145b: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_1460: ldloc.s 105
    IL_1462: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_1467: ldc.r4 0f
    IL_146c: ldc.i4.0
    IL_146d: newobj void Spawn::.ctor(UnityEngine.GameObject,UnityEngine.Transform,int,float,int,float,bool)  /*0x060006A5*/
    IL_1472: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_1477: ldloc.s 31
    IL_1479: ldloc.s 104
    IL_147b: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_1480: ldloc.s 105
    IL_1482: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_1487: add
    IL_1488: stloc.s 31
    IL_148a: ldloc.s 105
    IL_148c: ldc.i4.1
    IL_148d: add
    IL_148e: stloc.s 105
    IL_1490: ldloc.s 105
    IL_1492: ldloc.s 104
    IL_1494: callvirt List<EnemySpawnLine> EternalTrialEnemy::get_TempSpawnLineList()  /*0x060006DA*/
    IL_1499: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_149e: blt IL_1415
    IL_14a3: ldloca.s 43
    IL_14a5: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_14aa: brtrue IL_1407
    IL_14af: leave.s IL_14bf
    IL_14b1: ldloca.s 43
    IL_14b3: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_14b9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_14be: endfinally
    IL_14bf: ldc.r4 0f
    IL_14c4: stloc.s 32
    IL_14c6: ldarg.0
    IL_14c7: ldfld SuperWaveGen.EElitMode SuperWaveGen::settingEliteMode  /*0x040008A1*/
    IL_14cc: stloc.s 107
    IL_14ce: ldloc.s 107
    IL_14d0: switch (IL_15b0, IL_14f2, IL_1575, IL_157e, IL_1587, IL_1590)
    IL_14ed: br IL_15b0
    IL_14f2: ldloc.0
    IL_14f3: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_14f8: ldsfld Func<Spawn, bool> SuperWaveGen.<>c::<>9__45_1  /*0x04000911*/
    IL_14fd: dup
    IL_14fe: brtrue.s IL_1517
    IL_1500: pop
    IL_1501: ldsfld SuperWaveGen.<>c SuperWaveGen.<>c::<>9  /*0x0400090F*/
    IL_1506: ldftn bool SuperWaveGen.<>c::<GenerateWave>b__45_1(Spawn)  /*0x0600072C*/
    IL_150c: newobj void System.Func<Spawn, bool>::.ctor(object,IntPtr)  /*0x0A000342*/
    IL_1511: dup
    IL_1512: stsfld Func<Spawn, bool> SuperWaveGen.<>c::<>9__45_1  /*0x04000911*/
    IL_1517: call IEnumerable<!!0> System.Linq.Enumerable::Where(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, bool>)<Spawn>  /*0x2B00007A*/
    IL_151c: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Spawn>  /*0x2B00007B*/
    IL_1521: stloc.s 106
    IL_1523: ldloc.s 106
    IL_1525: call bool System.Linq.Enumerable::Any(System.Collections.Generic.IEnumerable<!!0>)<Spawn>  /*0x2B00007C*/
    IL_152a: brfalse IL_15b0
    IL_152f: ldloc.s 106
    IL_1531: ldc.i4.0
    IL_1532: ldloc.s 106
    IL_1534: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_1539: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_153e: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_1543: dup
    IL_1544: dup
    IL_1545: ldfld int Spawn::count  /*0x040007E7*/
    IL_154a: conv.r4
    IL_154b: ldc.r4 6f
    IL_1550: div
    IL_1551: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_1556: stfld int Spawn::count  /*0x040007E7*/
    IL_155b: dup
    IL_155c: dup
    IL_155d: ldfld float Spawn::interval  /*0x040007E8*/
    IL_1562: ldc.r4 6f
    IL_1567: mul
    IL_1568: stfld float Spawn::interval  /*0x040007E8*/
    IL_156d: ldc.i4.1
    IL_156e: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_1573: br.s IL_15b0
    IL_1575: ldc.r4 0.2f
    IL_157a: stloc.s 32
    IL_157c: br.s IL_15b0
    IL_157e: ldc.r4 0.4f
    IL_1583: stloc.s 32
    IL_1585: br.s IL_15b0
    IL_1587: ldc.r4 0.6f
    IL_158c: stloc.s 32
    IL_158e: br.s IL_15b0
    IL_1590: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_1595: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_159a: ldc.r4 0.25f
    IL_159f: blt.s IL_15a8
    IL_15a1: ldc.r4 1f
    IL_15a6: br.s IL_15ad
    IL_15a8: ldc.r4 0f
    IL_15ad: mul
    IL_15ae: stloc.s 32
    IL_15b0: ldloc.s 32
    IL_15b2: ldc.r4 0f
    IL_15b7: ble.un IL_1685
    IL_15bc: ldc.i4.0
    IL_15bd: stloc.s 108
    IL_15bf: br IL_1673
    IL_15c4: ldloc.0
    IL_15c5: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_15ca: ldloc.s 108
    IL_15cc: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_15d1: stloc.s 109
    IL_15d3: ldloc.s 109
    IL_15d5: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_15da: brtrue IL_166d
    IL_15df: ldloc.s 109
    IL_15e1: ldfld int Spawn::count  /*0x040007E7*/
    IL_15e6: conv.r4
    IL_15e7: ldloc.s 32
    IL_15e9: mul
    IL_15ea: ldc.r4 6f
    IL_15ef: div
    IL_15f0: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_15f5: ldc.i4.6
    IL_15f6: mul
    IL_15f7: stloc.s 110
    IL_15f9: ldloc.s 109
    IL_15fb: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_1600: conv.r4
    IL_1601: ldloc.s 32
    IL_1603: mul
    IL_1604: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_1609: stloc.s 111
    IL_160b: ldloc.s 110
    IL_160d: ldc.i4.0
    IL_160e: ble.s IL_166d
    IL_1610: ldloc.s 109
    IL_1612: dup
    IL_1613: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_1618: ldloc.s 111
    IL_161a: sub
    IL_161b: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_1620: ldloc.s 109
    IL_1622: dup
    IL_1623: ldfld int Spawn::count  /*0x040007E7*/
    IL_1628: ldloc.s 110
    IL_162a: sub
    IL_162b: stfld int Spawn::count  /*0x040007E7*/
    IL_1630: ldloc.s 109
    IL_1632: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_1637: ldloc.s 109
    IL_1639: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_163e: ldloc.s 110
    IL_1640: ldc.i4.6
    IL_1641: div
    IL_1642: ldloc.s 109
    IL_1644: ldfld float Spawn::interval  /*0x040007E8*/
    IL_1649: ldc.r4 6f
    IL_164e: mul
    IL_164f: ldloc.s 111
    IL_1651: ldloc.s 109
    IL_1653: ldfld float Spawn::delay  /*0x040007E4*/
    IL_1658: ldc.i4.1
    IL_1659: newobj void Spawn::.ctor(UnityEngine.GameObject,UnityEngine.Transform,int,float,int,float,bool)  /*0x060006A5*/
    IL_165e: stloc.s 112
    IL_1660: ldloc.0
    IL_1661: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_1666: ldloc.s 112
    IL_1668: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_166d: ldloc.s 108
    IL_166f: ldc.i4.1
    IL_1670: add
    IL_1671: stloc.s 108
    IL_1673: ldloc.s 108
    IL_1675: ldloc.0
    IL_1676: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_167b: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_1680: blt IL_15c4
    IL_1685: ldc.i4.0
    IL_1686: stloc.s 33
    IL_1688: br IL_175d
    IL_168d: ldnull
    IL_168e: stloc.s 113
    IL_1690: ldc.i4.m1
    IL_1691: stloc.s 114
    IL_1693: ldc.i4.0
    IL_1694: stloc.s 116
    IL_1696: br.s IL_16e4
    IL_1698: ldloc.s 113
    IL_169a: brfalse.s IL_16b7
    IL_169c: ldloc.0
    IL_169d: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_16a2: ldloc.s 116
    IL_16a4: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_16a9: ldfld int Spawn::count  /*0x040007E7*/
    IL_16ae: ldloc.s 113
    IL_16b0: ldfld int Spawn::count  /*0x040007E7*/
    IL_16b5: ble.s IL_16de
    IL_16b7: ldloc.0
    IL_16b8: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_16bd: ldloc.s 116
    IL_16bf: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_16c4: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_16c9: brtrue.s IL_16de
    IL_16cb: ldloc.0
    IL_16cc: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_16d1: ldloc.s 116
    IL_16d3: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_16d8: stloc.s 113
    IL_16da: ldloc.s 116
    IL_16dc: stloc.s 114
    IL_16de: ldloc.s 116
    IL_16e0: ldc.i4.1
    IL_16e1: add
    IL_16e2: stloc.s 116
    IL_16e4: ldloc.s 116
    IL_16e6: ldloc.0
    IL_16e7: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_16ec: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_16f1: blt.s IL_1698
    IL_16f3: ldloc.s 113
    IL_16f5: brfalse.s IL_1701
    IL_16f7: ldloc.s 113
    IL_16f9: ldfld int Spawn::count  /*0x040007E7*/
    IL_16fe: ldc.i4.1
    IL_16ff: bne.un.s IL_1706
    IL_1701: ldc.i4.1
    IL_1702: stloc.s 33
    IL_1704: br.s IL_176a
    IL_1706: ldc.i4.1
    IL_1707: ldloc.s 113
    IL_1709: ldfld int Spawn::count  /*0x040007E7*/
    IL_170e: ldc.i4.6
    IL_170f: div
    IL_1710: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_1715: stloc.s 115
    IL_1717: ldloc.s 31
    IL_1719: ldloc.s 113
    IL_171b: ldfld int Spawn::count  /*0x040007E7*/
    IL_1720: sub
    IL_1721: stloc.s 31
    IL_1723: ldloc.s 31
    IL_1725: ldloc.s 115
    IL_1727: add
    IL_1728: stloc.s 31
    IL_172a: ldloc.s 113
    IL_172c: dup
    IL_172d: ldfld float Spawn::interval  /*0x040007E8*/
    IL_1732: ldc.r4 6f
    IL_1737: mul
    IL_1738: stfld float Spawn::interval  /*0x040007E8*/
    IL_173d: ldloc.s 113
    IL_173f: ldloc.s 115
    IL_1741: stfld int Spawn::count  /*0x040007E7*/
    IL_1746: ldloc.s 113
    IL_1748: ldc.i4.1
    IL_1749: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_174e: ldloc.0
    IL_174f: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_1754: ldloc.s 114
    IL_1756: ldloc.s 113
    IL_1758: callvirt void System.Collections.Generic.List<Spawn>::set_Item(int,!0)  /*0x0A000345*/
    IL_175d: ldloc.s 31
    IL_175f: ldarg.0
    IL_1760: ldfld int SuperWaveGen::maxAmountOfUnitsPerWave  /*0x04000894*/
    IL_1765: bgt IL_168d
    IL_176a: ldc.r4 3.4028235E+38f
    IL_176f: stloc.s 34
    IL_1771: ldloc.0
    IL_1772: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_1777: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_177c: stloc.s 35
    IL_177e: ldc.r4 0.05f
    IL_1783: ldc.r4 0.45f
    IL_1788: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_178d: stloc.s 36
    IL_178f: ldloc.s 11
    IL_1791: ldloc.s 35
    IL_1793: conv.r4
    IL_1794: div
    IL_1795: stloc.s 37
    IL_1797: ldloc.0
    IL_1798: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_179d: ldarg.s 6
    IL_179f: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<Spawn>  /*0x2B00007D*/
    IL_17a4: ldc.i4.0
    IL_17a5: stloc.s 117
    IL_17a7: br IL_19d1
    IL_17ac: ldloc.0
    IL_17ad: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_17b2: ldloc.s 117
    IL_17b4: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_17b9: stloc.s 118
    IL_17bb: ldarg.0
    IL_17bc: ldfld SuperWaveGen.ESpawnInType SuperWaveGen::settingESpawnInType  /*0x040008A2*/
    IL_17c1: stloc.s 122
    IL_17c3: ldloc.s 11
    IL_17c5: ldc.r4 45f
    IL_17ca: blt.un.s IL_17fd
    IL_17cc: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_17d1: ldc.r4 0.5f
    IL_17d6: bge.un.s IL_17dd
    IL_17d8: ldc.i4.0
    IL_17d9: stloc.s 122
    IL_17db: br.s IL_17fd
    IL_17dd: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_17e2: ldc.r4 0.5f
    IL_17e7: bge.un.s IL_17ee
    IL_17e9: ldc.i4.3
    IL_17ea: stloc.s 122
    IL_17ec: br.s IL_17fd
    IL_17ee: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_17f3: ldc.r4 0.5f
    IL_17f8: bge.un.s IL_17fd
    IL_17fa: ldc.i4.6
    IL_17fb: stloc.s 122
    IL_17fd: ldloc.s 122
    IL_17ff: switch (IL_1829, IL_184d, IL_1873, IL_1899, IL_18e8, IL_1938, IL_196a, IL_199f)
    IL_1824: br IL_19cb
    IL_1829: ldarg.0
    IL_182a: ldloc.s 118
    IL_182c: ldfld int Spawn::count  /*0x040007E7*/
    IL_1831: ldloc.s 11
    IL_1833: ldloca.s 34
    IL_1835: ldloc.s 118
    IL_1837: ldflda float Spawn::interval  /*0x040007E8*/
    IL_183c: ldloc.s 118
    IL_183e: ldflda float Spawn::delay  /*0x040007E4*/
    IL_1843: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_1848: br IL_19cb
    IL_184d: ldarg.0
    IL_184e: ldloc.0
    IL_184f: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_1854: ldloc.s 118
    IL_1856: ldc.i4.2
    IL_1857: ldloc.s 11
    IL_1859: ldc.r4 0.1f
    IL_185e: mul
    IL_185f: ldloca.s 34
    IL_1861: ldloc.s 11
    IL_1863: ldc.r4 0f
    IL_1868: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_186d: pop
    IL_186e: br IL_19cb
    IL_1873: ldarg.0
    IL_1874: ldloc.0
    IL_1875: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_187a: ldloc.s 118
    IL_187c: ldc.i4.3
    IL_187d: ldloc.s 11
    IL_187f: ldc.r4 0.1f
    IL_1884: mul
    IL_1885: ldloca.s 34
    IL_1887: ldloc.s 11
    IL_1889: ldc.r4 0f
    IL_188e: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_1893: pop
    IL_1894: br IL_19cb
    IL_1899: ldc.i4.4
    IL_189a: ldc.i4.0
    IL_189b: ldc.i4.3
    IL_189c: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_18a1: add
    IL_18a2: stloc.s 120
    IL_18a4: ldc.i4.1
    IL_18a5: ldloc.s 118
    IL_18a7: ldfld int Spawn::count  /*0x040007E7*/
    IL_18ac: ldloc.s 120
    IL_18ae: div
    IL_18af: conv.r4
    IL_18b0: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_18b5: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_18ba: stloc.s 119
    IL_18bc: ldloc.s 11
    IL_18be: ldloc.s 36
    IL_18c0: mul
    IL_18c1: ldloc.s 119
    IL_18c3: conv.r4
    IL_18c4: div
    IL_18c5: stloc.s 121
    IL_18c7: ldarg.0
    IL_18c8: ldloc.0
    IL_18c9: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_18ce: ldloc.s 118
    IL_18d0: ldloc.s 119
    IL_18d2: ldloc.s 121
    IL_18d4: ldloca.s 34
    IL_18d6: ldloc.s 11
    IL_18d8: ldc.r4 0f
    IL_18dd: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_18e2: pop
    IL_18e3: br IL_19cb
    IL_18e8: ldc.i4.8
    IL_18e9: ldc.i4.0
    IL_18ea: ldc.i4.s 10
    IL_18ec: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_18f1: add
    IL_18f2: stloc.s 120
    IL_18f4: ldc.i4.1
    IL_18f5: ldloc.s 118
    IL_18f7: ldfld int Spawn::count  /*0x040007E7*/
    IL_18fc: ldloc.s 120
    IL_18fe: div
    IL_18ff: conv.r4
    IL_1900: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_1905: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_190a: stloc.s 119
    IL_190c: ldloc.s 11
    IL_190e: ldloc.s 36
    IL_1910: mul
    IL_1911: ldloc.s 119
    IL_1913: conv.r4
    IL_1914: div
    IL_1915: stloc.s 121
    IL_1917: ldarg.0
    IL_1918: ldloc.0
    IL_1919: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_191e: ldloc.s 118
    IL_1920: ldloc.s 119
    IL_1922: ldloc.s 121
    IL_1924: ldloca.s 34
    IL_1926: ldloc.s 11
    IL_1928: ldc.r4 0f
    IL_192d: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_1932: pop
    IL_1933: br IL_19cb
    IL_1938: ldc.i4.1
    IL_1939: ldc.i4.6
    IL_193a: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_193f: stloc.s 119
    IL_1941: ldloc.s 11
    IL_1943: ldloc.s 36
    IL_1945: mul
    IL_1946: ldloc.s 119
    IL_1948: conv.r4
    IL_1949: div
    IL_194a: stloc.s 121
    IL_194c: ldarg.0
    IL_194d: ldloc.0
    IL_194e: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_1953: ldloc.s 118
    IL_1955: ldloc.s 119
    IL_1957: ldloc.s 121
    IL_1959: ldloca.s 34
    IL_195b: ldloc.s 11
    IL_195d: ldc.r4 0f
    IL_1962: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_1967: pop
    IL_1968: br.s IL_19cb
    IL_196a: ldarg.0
    IL_196b: ldloc.s 118
    IL_196d: ldfld int Spawn::count  /*0x040007E7*/
    IL_1972: ldloc.s 37
    IL_1974: ldloca.s 34
    IL_1976: ldloc.s 118
    IL_1978: ldflda float Spawn::interval  /*0x040007E8*/
    IL_197d: ldloc.s 118
    IL_197f: ldflda float Spawn::delay  /*0x040007E4*/
    IL_1984: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_1989: ldloc.s 118
    IL_198b: dup
    IL_198c: ldfld float Spawn::delay  /*0x040007E4*/
    IL_1991: ldloc.s 37
    IL_1993: ldloc.s 117
    IL_1995: conv.r4
    IL_1996: mul
    IL_1997: add
    IL_1998: stfld float Spawn::delay  /*0x040007E4*/
    IL_199d: br.s IL_19cb
    IL_199f: ldc.i4.2
    IL_19a0: ldc.i4.4
    IL_19a1: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_19a6: stloc.s 119
    IL_19a8: ldarg.0
    IL_19a9: ldloc.0
    IL_19aa: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_19af: ldloc.s 118
    IL_19b1: ldloc.s 119
    IL_19b3: ldloc.s 37
    IL_19b5: ldc.r4 0.1f
    IL_19ba: mul
    IL_19bb: ldloca.s 34
    IL_19bd: ldloc.s 37
    IL_19bf: ldloc.s 37
    IL_19c1: ldloc.s 117
    IL_19c3: conv.r4
    IL_19c4: mul
    IL_19c5: call int SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  /*0x06000725*/
    IL_19ca: pop
    IL_19cb: ldloc.s 117
    IL_19cd: ldc.i4.1
    IL_19ce: add
    IL_19cf: stloc.s 117
    IL_19d1: ldloc.s 117
    IL_19d3: ldloc.s 35
    IL_19d5: blt IL_17ac
    IL_19da: ldloc.0
    IL_19db: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_19e0: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_19e5: stloc.s 123
    IL_19e7: br.s IL_19fe
    IL_19e9: ldloca.s 123
    IL_19eb: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_19f0: dup
    IL_19f1: ldfld float Spawn::delay  /*0x040007E4*/
    IL_19f6: ldloc.s 34
    IL_19f8: sub
    IL_19f9: stfld float Spawn::delay  /*0x040007E4*/
    IL_19fe: ldloca.s 123
    IL_1a00: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_1a05: brtrue.s IL_19e9
    IL_1a07: leave.s IL_1a17
    IL_1a09: ldloca.s 123
    IL_1a0b: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_1a11: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_1a16: endfinally
    IL_1a17: ldloc.s 23
    IL_1a19: ldc.r4 0.01f
    IL_1a1e: ble.un.s IL_1a36
    IL_1a20: ldstr "We did not drop all the gold. Thats bad. Leftover: "
    IL_1a25: ldloca.s 23
    IL_1a27: call string System.Single::ToString()  /*0x0A00030C*/
    IL_1a2c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_1a31: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_1a36: ldloc.s 24
    IL_1a38: ldloc.1
    IL_1a39: beq.s IL_1a5d
    IL_1a3b: ldstr "Dropped gold and gold to drop do not match: "
    IL_1a40: ldloca.s 24
    IL_1a42: call string System.Int32::ToString()  /*0x0A000031*/
    IL_1a47: ldstr " - "
    IL_1a4c: ldloca.s 1
    IL_1a4e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_1a53: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_1a58: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_1a5d: ldc.i4.0
    IL_1a5e: stloc.s 38
    IL_1a60: ldloc.s 5
    IL_1a62: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_1a67: stloc.s 43
    IL_1a69: br.s IL_1a81
    IL_1a6b: ldloca.s 43
    IL_1a6d: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_1a72: stloc.s 124
    IL_1a74: ldloc.s 38
    IL_1a76: ldarg.0
    IL_1a77: ldloc.s 124
    IL_1a79: call int SuperWaveGen::CalculateTotalGoldDropped(EternalTrialEnemy)  /*0x06000720*/
    IL_1a7e: add
    IL_1a7f: stloc.s 38
    IL_1a81: ldloca.s 43
    IL_1a83: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_1a88: brtrue.s IL_1a6b
    IL_1a8a: leave.s IL_1a9a
    IL_1a8c: ldloca.s 43
    IL_1a8e: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_1a94: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_1a99: endfinally
    IL_1a9a: ldloc.s 38
    IL_1a9c: ldloc.1
    IL_1a9d: beq.s IL_1ac1
    IL_1a9f: ldstr "Gold check and gold to drop do not match: "
    IL_1aa4: ldloca.s 38
    IL_1aa6: call string System.Int32::ToString()  /*0x0A000031*/
    IL_1aab: ldstr " - "
    IL_1ab0: ldloca.s 1
    IL_1ab2: call string System.Int32::ToString()  /*0x0A000031*/
    IL_1ab7: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_1abc: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_1ac1: ldarg.s 4
    IL_1ac3: ldloc.s 33
    IL_1ac5: ldc.i4.0
    IL_1ac6: ceq
    IL_1ac8: stind.i1
    IL_1ac9: ldloc.0
    IL_1aca: ret
    .try IL_028a-IL_02b6 finally handler IL_02b6-IL_02c4
    .try IL_0300-IL_0330 finally handler IL_0330-IL_033e
    .try IL_0359-IL_039d finally handler IL_039d-IL_03ab
    .try IL_03b4-IL_03f3 finally handler IL_03f3-IL_0401
    .try IL_0446-IL_0476 finally handler IL_0476-IL_0484
    .try IL_048d-IL_04d7 finally handler IL_04d7-IL_04e5
    .try IL_04ee-IL_0552 finally handler IL_0552-IL_0560
    .try IL_0576-IL_05a6 finally handler IL_05a6-IL_05b4
    .try IL_05ca-IL_0614 finally handler IL_0614-IL_0622
    .try IL_0638-IL_069c finally handler IL_069c-IL_06aa
    .try IL_06d8-IL_0708 finally handler IL_0708-IL_0716
    .try IL_06c0-IL_0736 finally handler IL_0736-IL_0744
    .try IL_077b-IL_07ab finally handler IL_07ab-IL_07b9
    .try IL_0763-IL_07f0 finally handler IL_07f0-IL_07fe
    .try IL_0828-IL_0858 finally handler IL_0858-IL_0866
    .try IL_0810-IL_089d finally handler IL_089d-IL_08ab
    .try IL_08cc-IL_08fc finally handler IL_08fc-IL_090a
    .try IL_08b4-IL_0915 finally handler IL_0915-IL_0923
    .try IL_0963-IL_0993 finally handler IL_0993-IL_09a1
    .try IL_093f-IL_09be finally handler IL_09be-IL_09cc
    .try IL_0b48-IL_0b72 finally handler IL_0b72-IL_0b80
    .try IL_0b33-IL_0b8b finally handler IL_0b8b-IL_0b99
    .try IL_0cf7-IL_0d19 finally handler IL_0d19-IL_0d27
    .try IL_0e23-IL_0e45 finally handler IL_0e45-IL_0e53
    .try IL_0f8a-IL_104b finally handler IL_104b-IL_1059
    .try IL_1086-IL_11a0 finally handler IL_11a0-IL_11ae
    .try IL_11dd-IL_1216 finally handler IL_1216-IL_1224
    .try IL_11be-IL_122f finally handler IL_122f-IL_123d
    .try IL_130b-IL_1344 finally handler IL_1344-IL_1352
    .try IL_12e2-IL_13e8 finally handler IL_13e8-IL_13f6
    .try IL_1402-IL_14b1 finally handler IL_14b1-IL_14bf
    .try IL_19e7-IL_1a09 finally handler IL_1a09-IL_1a17
    .try IL_1a69-IL_1a8c finally handler IL_1a8c-IL_1a9a

  .method SuperWaveGen::FirstPossibleEnemyForWave(int,int,ref int)  // token 0x0600071A rva 0x2381c attrs Private, HideBySig
    // code size 101 (0x65), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldarg.3
    IL_0001: ldarg.2
    IL_0002: ldarg.0
    IL_0003: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0008: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_000d: rem
    IL_000e: stind.i4
    IL_000f: ldarg.3
    IL_0010: ldind.i4
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0018: ldarg.3
    IL_0019: ldind.i4
    IL_001a: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_001f: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_0024: ldarg.0
    IL_0025: ldfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_002a: ldarg.1
    IL_002b: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0030: conv.r4
    IL_0031: bgt.un.s IL_0041
    IL_0033: ldarg.0
    IL_0034: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0039: ldarg.3
    IL_003a: ldind.i4
    IL_003b: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0040: ret
    IL_0041: ldarg.3
    IL_0042: ldarg.3
    IL_0043: ldind.i4
    IL_0044: ldc.i4.1
    IL_0045: add
    IL_0046: ldarg.0
    IL_0047: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_004c: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0051: rem
    IL_0052: stind.i4
    IL_0053: ldarg.3
    IL_0054: ldind.i4
    IL_0055: ldloc.0
    IL_0056: bne.un.s IL_0012
    IL_0058: ldarg.0
    IL_0059: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_005e: ldloc.0
    IL_005f: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0064: ret

  .method SuperWaveGen::FirstPossibleSpawnFor(EternalTrialEnemy,int,ref int)  // token 0x0600071B rva 0x23890 attrs Private, HideBySig
    // code size 158 (0x9e), max stack 3, init locals
    .locals ([0] bool, [1] bool, [2] bool, [3] int)
    IL_0000: ldarg.1
    IL_0001: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: callvirt bool EternalTrialEnemy::get_bigGround()  /*0x060006E7*/
    IL_000d: stloc.1
    IL_000e: ldarg.1
    IL_000f: callvirt bool EternalTrialEnemy::get_smallGround()  /*0x060006E6*/
    IL_0014: stloc.2
    IL_0015: ldarg.3
    IL_0016: ldarg.2
    IL_0017: ldarg.0
    IL_0018: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_001d: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0022: rem
    IL_0023: stind.i4
    IL_0024: ldarg.3
    IL_0025: ldind.i4
    IL_0026: stloc.3
    IL_0027: ldarg.0
    IL_0028: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_002d: ldarg.3
    IL_002e: ldind.i4
    IL_002f: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0034: ldfld bool EnemySpawnLine::canSpawnBigGround  /*0x0400082F*/
    IL_0039: brtrue.s IL_003e
    IL_003b: ldloc.1
    IL_003c: brtrue.s IL_007a
    IL_003e: ldarg.0
    IL_003f: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0044: ldarg.3
    IL_0045: ldind.i4
    IL_0046: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_004b: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_0050: brtrue.s IL_0055
    IL_0052: ldloc.0
    IL_0053: brtrue.s IL_007a
    IL_0055: ldarg.0
    IL_0056: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_005b: ldarg.3
    IL_005c: ldind.i4
    IL_005d: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0062: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_0067: brtrue.s IL_006c
    IL_0069: ldloc.2
    IL_006a: brtrue.s IL_007a
    IL_006c: ldarg.0
    IL_006d: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0072: ldarg.3
    IL_0073: ldind.i4
    IL_0074: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0079: ret
    IL_007a: ldarg.3
    IL_007b: ldarg.3
    IL_007c: ldind.i4
    IL_007d: ldc.i4.1
    IL_007e: add
    IL_007f: ldarg.0
    IL_0080: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0085: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_008a: rem
    IL_008b: stind.i4
    IL_008c: ldarg.3
    IL_008d: ldind.i4
    IL_008e: ldloc.3
    IL_008f: bne.un.s IL_0027
    IL_0091: ldarg.0
    IL_0092: ldfld List<EnemySpawnLine> SuperWaveGen::shuffledSpawns  /*0x04000896*/
    IL_0097: ldloc.3
    IL_0098: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_009d: ret

  .method SuperWaveGen::IsPossibleSpawnLineFor(EternalTrialEnemy,EnemySpawnLine)  // token 0x0600071C rva 0x2393a attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.2
    IL_0001: ldfld bool EnemySpawnLine::canSpawnBigGround  /*0x0400082F*/
    IL_0006: brtrue.s IL_0010
    IL_0008: ldarg.1
    IL_0009: callvirt bool EternalTrialEnemy::get_bigGround()  /*0x060006E7*/
    IL_000e: brtrue.s IL_0032
    IL_0010: ldarg.2
    IL_0011: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_0016: brtrue.s IL_0020
    IL_0018: ldarg.1
    IL_0019: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_001e: brtrue.s IL_0032
    IL_0020: ldarg.2
    IL_0021: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_0026: brtrue.s IL_0030
    IL_0028: ldarg.1
    IL_0029: callvirt bool EternalTrialEnemy::get_smallGround()  /*0x060006E6*/
    IL_002e: brtrue.s IL_0032
    IL_0030: ldc.i4.1
    IL_0031: ret
    IL_0032: ldc.i4.0
    IL_0033: ret

  .method SuperWaveGen::AdjustSpawnDifficulty(EternalTrialEnemy,float,float)  // token 0x0600071D rva 0x23970 attrs Private, HideBySig
    // code size 76 (0x4c), max stack 3, init locals
    .locals ([0] int, [1] float)
    IL_0000: ldc.i4.0
    IL_0001: ldarg.2
    IL_0002: ldarg.1
    IL_0003: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_0008: div
    IL_0009: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_000e: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0013: stloc.0
    IL_0014: ldloc.0
    IL_0015: conv.r4
    IL_0016: ldarg.1
    IL_0017: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_001c: mul
    IL_001d: stloc.1
    IL_001e: ldarg.2
    IL_001f: ldloc.1
    IL_0020: sub
    IL_0021: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0026: ldarg.2
    IL_0027: ldarg.3
    IL_0028: sub
    IL_0029: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_002e: bge.un.s IL_0038
    IL_0030: ldloc.1
    IL_0031: ldloc.0
    IL_0032: newobj void System.Tuple<float, int>::.ctor(!0,!1)  /*0x0A000346*/
    IL_0037: ret
    IL_0038: ldarg.3
    IL_0039: ldarg.3
    IL_003a: ldarg.1
    IL_003b: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_0040: div
    IL_0041: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0046: newobj void System.Tuple<float, int>::.ctor(!0,!1)  /*0x0A000346*/
    IL_004b: ret

  .method SuperWaveGen::AdjustGoldAllocation(EternalTrialEnemy,System.Collections.Generic.List<EternalTrialEnemy>)  // token 0x0600071E rva 0x239c8 attrs Private, HideBySig
    // code size 430 (0x1ae), max stack 4, init locals
    .locals ([0] int, [1] List.Enumerator<EternalTrialEnemy>, [2] EternalTrialEnemy, [3] int, [4] List<int>, [5] int, [6] int, [7] int, [8] int, [9] int)
    IL_0000: ldarg.1
    IL_0001: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0006: ldsfld Func<int, bool> SuperWaveGen.<>c::<>9__50_0  /*0x04000912*/
    IL_000b: dup
    IL_000c: brtrue.s IL_0025
    IL_000e: pop
    IL_000f: ldsfld SuperWaveGen.<>c SuperWaveGen.<>c::<>9  /*0x0400090F*/
    IL_0014: ldftn bool SuperWaveGen.<>c::<AdjustGoldAllocation>b__50_0(int)  /*0x0600072D*/
    IL_001a: newobj void System.Func<int, bool>::.ctor(object,IntPtr)  /*0x0A000347*/
    IL_001f: dup
    IL_0020: stsfld Func<int, bool> SuperWaveGen.<>c::<>9__50_0  /*0x04000912*/
    IL_0025: call bool System.Linq.Enumerable::All(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, bool>)<int>  /*0x2B00007E*/
    IL_002a: brfalse IL_010e
    IL_002f: ldarg.1
    IL_0030: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_0035: call int System.Linq.Enumerable::Sum(System.Collections.Generic.IEnumerable<int>)  /*0x0A000349*/
    IL_003a: stloc.0
    IL_003b: ldarg.2
    IL_003c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0041: stloc.1
    IL_0042: br IL_00c9
    IL_0047: ldloca.s 1
    IL_0049: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_004e: stloc.2
    IL_004f: ldloc.2
    IL_0050: ldarg.1
    IL_0051: beq.s IL_00c9
    IL_0053: ldloc.2
    IL_0054: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0059: ldsfld Func<int, bool> SuperWaveGen.<>c::<>9__50_1  /*0x04000913*/
    IL_005e: dup
    IL_005f: brtrue.s IL_0078
    IL_0061: pop
    IL_0062: ldsfld SuperWaveGen.<>c SuperWaveGen.<>c::<>9  /*0x0400090F*/
    IL_0067: ldftn bool SuperWaveGen.<>c::<AdjustGoldAllocation>b__50_1(int)  /*0x0600072E*/
    IL_006d: newobj void System.Func<int, bool>::.ctor(object,IntPtr)  /*0x0A000347*/
    IL_0072: dup
    IL_0073: stsfld Func<int, bool> SuperWaveGen.<>c::<>9__50_1  /*0x04000913*/
    IL_0078: call bool System.Linq.Enumerable::Any(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, bool>)<int>  /*0x2B00007F*/
    IL_007d: brfalse.s IL_00c9
    IL_007f: ldc.i4.0
    IL_0080: stloc.3
    IL_0081: br.s IL_00b7
    IL_0083: ldloc.2
    IL_0084: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0089: ldloc.3
    IL_008a: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_008f: ldc.i4.0
    IL_0090: ble.s IL_00b3
    IL_0092: ldloc.2
    IL_0093: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_0098: stloc.s 4
    IL_009a: ldloc.3
    IL_009b: stloc.s 5
    IL_009d: ldloc.s 4
    IL_009f: ldloc.s 5
    IL_00a1: ldloc.s 4
    IL_00a3: ldloc.s 5
    IL_00a5: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_00aa: ldloc.0
    IL_00ab: add
    IL_00ac: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_00b1: ldc.i4.0
    IL_00b2: stloc.0
    IL_00b3: ldloc.3
    IL_00b4: ldc.i4.1
    IL_00b5: add
    IL_00b6: stloc.3
    IL_00b7: ldloc.3
    IL_00b8: ldloc.2
    IL_00b9: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_00be: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_00c3: bge.s IL_00c9
    IL_00c5: ldloc.0
    IL_00c6: ldc.i4.0
    IL_00c7: bgt.s IL_0083
    IL_00c9: ldloca.s 1
    IL_00cb: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_00d0: brtrue IL_0047
    IL_00d5: leave.s IL_00e5
    IL_00d7: ldloca.s 1
    IL_00d9: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_00df: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e4: endfinally
    IL_00e5: ldc.i4.0
    IL_00e6: stloc.s 6
    IL_00e8: br.s IL_00fe
    IL_00ea: ldarg.1
    IL_00eb: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_00f0: ldloc.s 6
    IL_00f2: ldc.i4.0
    IL_00f3: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_00f8: ldloc.s 6
    IL_00fa: ldc.i4.1
    IL_00fb: add
    IL_00fc: stloc.s 6
    IL_00fe: ldloc.s 6
    IL_0100: ldarg.1
    IL_0101: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_0106: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_010b: blt.s IL_00ea
    IL_010d: ret
    IL_010e: ldc.i4.0
    IL_010f: stloc.s 7
    IL_0111: br IL_019b
    IL_0116: ldarg.1
    IL_0117: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_011c: ldloc.s 7
    IL_011e: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0123: brtrue.s IL_0195
    IL_0125: ldarg.1
    IL_0126: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_012b: ldloc.s 7
    IL_012d: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0132: stloc.s 8
    IL_0134: ldarg.1
    IL_0135: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_013a: ldloc.s 7
    IL_013c: ldc.i4.0
    IL_013d: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_0142: ldc.i4.0
    IL_0143: stloc.s 9
    IL_0145: br.s IL_0181
    IL_0147: ldarg.1
    IL_0148: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_014d: ldloc.s 9
    IL_014f: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0154: ldc.i4.0
    IL_0155: ble.s IL_017b
    IL_0157: ldarg.1
    IL_0158: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_015d: stloc.s 4
    IL_015f: ldloc.s 9
    IL_0161: stloc.s 5
    IL_0163: ldloc.s 4
    IL_0165: ldloc.s 5
    IL_0167: ldloc.s 4
    IL_0169: ldloc.s 5
    IL_016b: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0170: ldloc.s 8
    IL_0172: add
    IL_0173: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_0178: ldc.i4.0
    IL_0179: stloc.s 8
    IL_017b: ldloc.s 9
    IL_017d: ldc.i4.1
    IL_017e: add
    IL_017f: stloc.s 9
    IL_0181: ldloc.s 9
    IL_0183: ldarg.1
    IL_0184: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0189: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_018e: bge.s IL_0195
    IL_0190: ldloc.s 8
    IL_0192: ldc.i4.0
    IL_0193: bgt.s IL_0147
    IL_0195: ldloc.s 7
    IL_0197: ldc.i4.1
    IL_0198: add
    IL_0199: stloc.s 7
    IL_019b: ldloc.s 7
    IL_019d: ldarg.1
    IL_019e: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_01a3: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_01a8: blt IL_0116
    IL_01ad: ret
    .try IL_0042-IL_00d7 finally handler IL_00d7-IL_00e5

  .method SuperWaveGen::CalculateActualDifficulty(EternalTrialEnemy)  // token 0x0600071F rva 0x23b94 attrs Private, HideBySig
    // code size 53 (0x35), max stack 3, init locals
    .locals ([0] float, [1] int)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_0025
    IL_000a: ldloc.0
    IL_000b: ldarg.1
    IL_000c: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0011: ldloc.1
    IL_0012: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0017: conv.r4
    IL_0018: ldarg.1
    IL_0019: callvirt float EternalTrialEnemy::get_DifficultyValueTemp()  /*0x060006D8*/
    IL_001e: mul
    IL_001f: add
    IL_0020: stloc.0
    IL_0021: ldloc.1
    IL_0022: ldc.i4.1
    IL_0023: add
    IL_0024: stloc.1
    IL_0025: ldloc.1
    IL_0026: ldarg.1
    IL_0027: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_002c: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0031: blt.s IL_000a
    IL_0033: ldloc.0
    IL_0034: ret

  .method SuperWaveGen::CalculateTotalGoldDropped(EternalTrialEnemy)  // token 0x06000720 rva 0x23bd8 attrs Private, HideBySig
    // code size 41 (0x29), max stack 3, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: br.s IL_0019
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: callvirt List<int> EternalTrialEnemy::get_TempDropGold()  /*0x060006E3*/
    IL_000d: ldloc.1
    IL_000e: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0013: add
    IL_0014: stloc.0
    IL_0015: ldloc.1
    IL_0016: ldc.i4.1
    IL_0017: add
    IL_0018: stloc.1
    IL_0019: ldloc.1
    IL_001a: ldarg.1
    IL_001b: callvirt List<int> EternalTrialEnemy::get_TempSpawnAmount()  /*0x060006E2*/
    IL_0020: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0025: blt.s IL_0006
    IL_0027: ldloc.0
    IL_0028: ret

  .method SuperWaveGen::RemoveRandomInstances(ref System.Collections.Generic.List<!!0>,System.Random)  // token 0x06000721 rva 0x23c10 attrs Private, Static, HideBySig
    // code size 61 (0x3d), max stack 3, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: ldarg.0
    IL_0003: ldind.ref
    IL_0004: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_0009: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_000e: stloc.0
    IL_000f: ldc.i4.0
    IL_0010: stloc.1
    IL_0011: br.s IL_002e
    IL_0013: ldarg.1
    IL_0014: ldc.i4.0
    IL_0015: ldarg.0
    IL_0016: ldind.ref
    IL_0017: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_001c: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_0021: stloc.2
    IL_0022: ldarg.0
    IL_0023: ldind.ref
    IL_0024: ldloc.2
    IL_0025: callvirt void System.Collections.Generic.List<!!0>::RemoveAt(int)  /*0x0A00034C*/
    IL_002a: ldloc.1
    IL_002b: ldc.i4.1
    IL_002c: add
    IL_002d: stloc.1
    IL_002e: ldloc.1
    IL_002f: ldloc.0
    IL_0030: bge.s IL_003c
    IL_0032: ldarg.0
    IL_0033: ldind.ref
    IL_0034: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_0039: ldc.i4.1
    IL_003a: bgt.s IL_0013
    IL_003c: ret

  .method SuperWaveGen::RemoveInvalidEnemiesFromShuffeledEnemeisAndShuffle(ref System.Collections.Generic.List<EternalTrialEnemy>,System.Random)  // token 0x06000722 rva 0x23c5c attrs Private, HideBySig
    // code size 1387 (0x56b), max stack 3, init locals
    .locals ([0] bool, [1] SuperWaveGen.EEnemyPreselection, [2] int, [3] int, [4] int, [5] int, [6] int, [7] int, [8] int, [9] int, [10] int, [11] int, [12] int, [13] List.Enumerator<EternalTrialEnemy>, [14] EternalTrialEnemy)
    IL_0000: ldarg.0
    IL_0001: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0006: ldarg.2
    IL_0007: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_000c: ldarg.1
    IL_000d: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0012: stind.ref
    IL_0013: ldarg.0
    IL_0014: ldfld SuperWaveGen.EEnemyPreselection SuperWaveGen::settingEnemyPreselection  /*0x0400089D*/
    IL_0019: stloc.1
    IL_001a: ldloc.1
    IL_001b: switch (IL_04ba, IL_04ae, IL_02b3, IL_0319, IL_0059, IL_00b9, IL_01e7, IL_024d, IL_037f, IL_0119, IL_0180, IL_03e6, IL_044a)
    IL_0054: br IL_04ba
    IL_0059: ldarg.0
    IL_005a: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_005f: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0064: ldc.i4.1
    IL_0065: sub
    IL_0066: stloc.2
    IL_0067: br.s IL_00b0
    IL_0069: ldarg.0
    IL_006a: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_006f: ldloc.2
    IL_0070: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0075: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_007a: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_007f: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0084: ldc.i4.s 19
    IL_0086: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_008b: brtrue.s IL_00ac
    IL_008d: ldarg.1
    IL_008e: ldind.ref
    IL_008f: ldarg.0
    IL_0090: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0095: ldloc.2
    IL_0096: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_009b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_00a6: ldloc.2
    IL_00a7: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_00ac: ldloc.2
    IL_00ad: ldc.i4.1
    IL_00ae: sub
    IL_00af: stloc.2
    IL_00b0: ldloc.2
    IL_00b1: ldc.i4.0
    IL_00b2: bge.s IL_0069
    IL_00b4: br IL_04ba
    IL_00b9: ldarg.0
    IL_00ba: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_00bf: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_00c4: ldc.i4.1
    IL_00c5: sub
    IL_00c6: stloc.3
    IL_00c7: br.s IL_0110
    IL_00c9: ldarg.0
    IL_00ca: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_00cf: ldloc.3
    IL_00d0: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_00d5: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_00da: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_00df: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00e4: ldc.i4.s 19
    IL_00e6: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00eb: brfalse.s IL_010c
    IL_00ed: ldarg.1
    IL_00ee: ldind.ref
    IL_00ef: ldarg.0
    IL_00f0: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_00f5: ldloc.3
    IL_00f6: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_00fb: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0100: ldarg.0
    IL_0101: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0106: ldloc.3
    IL_0107: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_010c: ldloc.3
    IL_010d: ldc.i4.1
    IL_010e: sub
    IL_010f: stloc.3
    IL_0110: ldloc.3
    IL_0111: ldc.i4.0
    IL_0112: bge.s IL_00c9
    IL_0114: br IL_04ba
    IL_0119: ldarg.0
    IL_011a: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_011f: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0124: ldc.i4.1
    IL_0125: sub
    IL_0126: stloc.s 4
    IL_0128: br.s IL_0176
    IL_012a: ldarg.0
    IL_012b: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0130: ldloc.s 4
    IL_0132: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0137: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_013c: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0141: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0146: ldc.i4.s 16
    IL_0148: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_014d: brtrue.s IL_0170
    IL_014f: ldarg.1
    IL_0150: ldind.ref
    IL_0151: ldarg.0
    IL_0152: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0157: ldloc.s 4
    IL_0159: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_015e: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0163: ldarg.0
    IL_0164: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0169: ldloc.s 4
    IL_016b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_0170: ldloc.s 4
    IL_0172: ldc.i4.1
    IL_0173: sub
    IL_0174: stloc.s 4
    IL_0176: ldloc.s 4
    IL_0178: ldc.i4.0
    IL_0179: bge.s IL_012a
    IL_017b: br IL_04ba
    IL_0180: ldarg.0
    IL_0181: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0186: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_018b: ldc.i4.1
    IL_018c: sub
    IL_018d: stloc.s 5
    IL_018f: br.s IL_01dd
    IL_0191: ldarg.0
    IL_0192: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0197: ldloc.s 5
    IL_0199: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_019e: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_01a3: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_01a8: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01ad: ldc.i4.s 16
    IL_01af: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01b4: brfalse.s IL_01d7
    IL_01b6: ldarg.1
    IL_01b7: ldind.ref
    IL_01b8: ldarg.0
    IL_01b9: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_01be: ldloc.s 5
    IL_01c0: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_01c5: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_01ca: ldarg.0
    IL_01cb: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_01d0: ldloc.s 5
    IL_01d2: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_01d7: ldloc.s 5
    IL_01d9: ldc.i4.1
    IL_01da: sub
    IL_01db: stloc.s 5
    IL_01dd: ldloc.s 5
    IL_01df: ldc.i4.0
    IL_01e0: bge.s IL_0191
    IL_01e2: br IL_04ba
    IL_01e7: ldarg.0
    IL_01e8: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_01ed: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_01f2: ldc.i4.1
    IL_01f3: sub
    IL_01f4: stloc.s 6
    IL_01f6: br.s IL_0243
    IL_01f8: ldarg.0
    IL_01f9: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_01fe: ldloc.s 6
    IL_0200: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0205: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_020a: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_020f: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0214: ldc.i4.4
    IL_0215: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_021a: brtrue.s IL_023d
    IL_021c: ldarg.1
    IL_021d: ldind.ref
    IL_021e: ldarg.0
    IL_021f: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0224: ldloc.s 6
    IL_0226: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_022b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0230: ldarg.0
    IL_0231: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0236: ldloc.s 6
    IL_0238: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_023d: ldloc.s 6
    IL_023f: ldc.i4.1
    IL_0240: sub
    IL_0241: stloc.s 6
    IL_0243: ldloc.s 6
    IL_0245: ldc.i4.0
    IL_0246: bge.s IL_01f8
    IL_0248: br IL_04ba
    IL_024d: ldarg.0
    IL_024e: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0253: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0258: ldc.i4.1
    IL_0259: sub
    IL_025a: stloc.s 7
    IL_025c: br.s IL_02a9
    IL_025e: ldarg.0
    IL_025f: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0264: ldloc.s 7
    IL_0266: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_026b: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0270: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0275: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_027a: ldc.i4.5
    IL_027b: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0280: brtrue.s IL_02a3
    IL_0282: ldarg.1
    IL_0283: ldind.ref
    IL_0284: ldarg.0
    IL_0285: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_028a: ldloc.s 7
    IL_028c: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0291: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0296: ldarg.0
    IL_0297: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_029c: ldloc.s 7
    IL_029e: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_02a3: ldloc.s 7
    IL_02a5: ldc.i4.1
    IL_02a6: sub
    IL_02a7: stloc.s 7
    IL_02a9: ldloc.s 7
    IL_02ab: ldc.i4.0
    IL_02ac: bge.s IL_025e
    IL_02ae: br IL_04ba
    IL_02b3: ldarg.0
    IL_02b4: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_02b9: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_02be: ldc.i4.1
    IL_02bf: sub
    IL_02c0: stloc.s 8
    IL_02c2: br.s IL_030f
    IL_02c4: ldarg.0
    IL_02c5: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_02ca: ldloc.s 8
    IL_02cc: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_02d1: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_02d6: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_02db: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_02e0: ldc.i4.6
    IL_02e1: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_02e6: brfalse.s IL_0309
    IL_02e8: ldarg.1
    IL_02e9: ldind.ref
    IL_02ea: ldarg.0
    IL_02eb: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_02f0: ldloc.s 8
    IL_02f2: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_02f7: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_02fc: ldarg.0
    IL_02fd: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0302: ldloc.s 8
    IL_0304: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_0309: ldloc.s 8
    IL_030b: ldc.i4.1
    IL_030c: sub
    IL_030d: stloc.s 8
    IL_030f: ldloc.s 8
    IL_0311: ldc.i4.0
    IL_0312: bge.s IL_02c4
    IL_0314: br IL_04ba
    IL_0319: ldarg.0
    IL_031a: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_031f: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0324: ldc.i4.1
    IL_0325: sub
    IL_0326: stloc.s 9
    IL_0328: br.s IL_0375
    IL_032a: ldarg.0
    IL_032b: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0330: ldloc.s 9
    IL_0332: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0337: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_033c: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0341: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0346: ldc.i4.6
    IL_0347: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_034c: brtrue.s IL_036f
    IL_034e: ldarg.1
    IL_034f: ldind.ref
    IL_0350: ldarg.0
    IL_0351: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0356: ldloc.s 9
    IL_0358: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_035d: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0362: ldarg.0
    IL_0363: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0368: ldloc.s 9
    IL_036a: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_036f: ldloc.s 9
    IL_0371: ldc.i4.1
    IL_0372: sub
    IL_0373: stloc.s 9
    IL_0375: ldloc.s 9
    IL_0377: ldc.i4.0
    IL_0378: bge.s IL_032a
    IL_037a: br IL_04ba
    IL_037f: ldarg.0
    IL_0380: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0385: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_038a: ldc.i4.1
    IL_038b: sub
    IL_038c: stloc.s 10
    IL_038e: br.s IL_03dc
    IL_0390: ldarg.0
    IL_0391: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0396: ldloc.s 10
    IL_0398: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_039d: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_03a2: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_03a7: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_03ac: ldc.i4.s 9
    IL_03ae: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_03b3: brfalse.s IL_03d6
    IL_03b5: ldarg.1
    IL_03b6: ldind.ref
    IL_03b7: ldarg.0
    IL_03b8: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_03bd: ldloc.s 10
    IL_03bf: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_03c4: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_03c9: ldarg.0
    IL_03ca: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_03cf: ldloc.s 10
    IL_03d1: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_03d6: ldloc.s 10
    IL_03d8: ldc.i4.1
    IL_03d9: sub
    IL_03da: stloc.s 10
    IL_03dc: ldloc.s 10
    IL_03de: ldc.i4.0
    IL_03df: bge.s IL_0390
    IL_03e1: br IL_04ba
    IL_03e6: ldarg.0
    IL_03e7: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_03ec: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_03f1: ldc.i4.1
    IL_03f2: sub
    IL_03f3: stloc.s 11
    IL_03f5: br.s IL_0443
    IL_03f7: ldarg.0
    IL_03f8: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_03fd: ldloc.s 11
    IL_03ff: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0404: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0409: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_040e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0413: ldc.i4.s 32
    IL_0415: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_041a: brtrue.s IL_043d
    IL_041c: ldarg.1
    IL_041d: ldind.ref
    IL_041e: ldarg.0
    IL_041f: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0424: ldloc.s 11
    IL_0426: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_042b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0430: ldarg.0
    IL_0431: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0436: ldloc.s 11
    IL_0438: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_043d: ldloc.s 11
    IL_043f: ldc.i4.1
    IL_0440: sub
    IL_0441: stloc.s 11
    IL_0443: ldloc.s 11
    IL_0445: ldc.i4.0
    IL_0446: bge.s IL_03f7
    IL_0448: br.s IL_04ba
    IL_044a: ldarg.0
    IL_044b: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0450: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0455: ldc.i4.1
    IL_0456: sub
    IL_0457: stloc.s 12
    IL_0459: br.s IL_04a7
    IL_045b: ldarg.0
    IL_045c: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0461: ldloc.s 12
    IL_0463: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0468: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_046d: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0472: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0477: ldc.i4.s 32
    IL_0479: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_047e: brfalse.s IL_04a1
    IL_0480: ldarg.1
    IL_0481: ldind.ref
    IL_0482: ldarg.0
    IL_0483: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0488: ldloc.s 12
    IL_048a: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_048f: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0494: ldarg.0
    IL_0495: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_049a: ldloc.s 12
    IL_049c: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::RemoveAt(int)  /*0x0A00034D*/
    IL_04a1: ldloc.s 12
    IL_04a3: ldc.i4.1
    IL_04a4: sub
    IL_04a5: stloc.s 12
    IL_04a7: ldloc.s 12
    IL_04a9: ldc.i4.0
    IL_04aa: bge.s IL_045b
    IL_04ac: br.s IL_04ba
    IL_04ae: ldarg.0
    IL_04af: ldflda List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_04b4: ldarg.2
    IL_04b5: call void SuperWaveGen::RemoveRandomInstances(ref System.Collections.Generic.List<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000080*/
    IL_04ba: ldc.i4.1
    IL_04bb: stloc.0
    IL_04bc: ldarg.0
    IL_04bd: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_04c2: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_04c7: stloc.s 13
    IL_04c9: br.s IL_04ed
    IL_04cb: ldloca.s 13
    IL_04cd: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_04d2: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_04d7: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_04dc: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_04e1: ldc.i4.6
    IL_04e2: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_04e7: brtrue.s IL_04ed
    IL_04e9: ldc.i4.0
    IL_04ea: stloc.0
    IL_04eb: leave.s IL_0506
    IL_04ed: ldloca.s 13
    IL_04ef: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_04f4: brtrue.s IL_04cb
    IL_04f6: leave.s IL_0506
    IL_04f8: ldloca.s 13
    IL_04fa: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0500: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0505: endfinally
    IL_0506: ldloc.0
    IL_0507: brfalse.s IL_056a
    IL_0509: ldarg.1
    IL_050a: ldind.ref
    IL_050b: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0510: stloc.s 13
    IL_0512: br.s IL_0551
    IL_0514: ldloca.s 13
    IL_0516: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_051b: stloc.s 14
    IL_051d: ldloc.s 14
    IL_051f: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0524: callvirt !!0 UnityEngine.GameObject::GetComponent()<TaggedObject>  /*0x2B000003*/
    IL_0529: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_052e: ldc.i4.6
    IL_052f: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0534: brtrue.s IL_0551
    IL_0536: ldarg.0
    IL_0537: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_053c: ldloc.s 14
    IL_053e: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0543: ldarg.0
    IL_0544: ldfld List<EternalTrialEnemy> SuperWaveGen::shuffledEnemies  /*0x04000895*/
    IL_0549: ldarg.2
    IL_054a: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_054f: leave.s IL_056a
    IL_0551: ldloca.s 13
    IL_0553: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0558: brtrue.s IL_0514
    IL_055a: leave.s IL_056a
    IL_055c: ldloca.s 13
    IL_055e: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0564: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0569: endfinally
    IL_056a: ret
    .try IL_04c9-IL_04f8 finally handler IL_04f8-IL_0506
    .try IL_0512-IL_055c finally handler IL_055c-IL_056a

  .method SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  // token 0x06000723 rva 0x241f0 attrs Private, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.s 4
    IL_0002: ldc.r4 0.02f
    IL_0007: stind.r4
    IL_0008: ldarg.s 5
    IL_000a: ldc.r4 0f
    IL_000f: stind.r4
    IL_0010: ldarg.1
    IL_0011: ldc.i4.1
    IL_0012: ble.s IL_001f
    IL_0014: ldarg.s 4
    IL_0016: ldarg.2
    IL_0017: ldarg.1
    IL_0018: ldc.i4.1
    IL_0019: sub
    IL_001a: conv.r4
    IL_001b: div
    IL_001c: stind.r4
    IL_001d: br.s IL_0029
    IL_001f: ldarg.s 5
    IL_0021: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0026: ldarg.2
    IL_0027: mul
    IL_0028: stind.r4
    IL_0029: ldarg.3
    IL_002a: ldarg.3
    IL_002b: ldind.r4
    IL_002c: ldarg.s 5
    IL_002e: ldind.r4
    IL_002f: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_0034: stind.r4
    IL_0035: ret

  .method SuperWaveGen::DistributeEvenly(int,int)  // token 0x06000724 rva 0x24228 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 5, init locals
    .locals ([0] int[], [1] int, [2] int, [3] int)
    IL_0000: ldarg.2
    IL_0001: newarr System.Int32  /*0x01000026*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: ldarg.2
    IL_0009: div
    IL_000a: stloc.1
    IL_000b: ldarg.1
    IL_000c: ldarg.2
    IL_000d: rem
    IL_000e: stloc.2
    IL_000f: ldc.i4.0
    IL_0010: stloc.3
    IL_0011: br.s IL_0024
    IL_0013: ldloc.0
    IL_0014: ldloc.3
    IL_0015: ldloc.1
    IL_0016: ldloc.3
    IL_0017: ldloc.2
    IL_0018: blt.s IL_001d
    IL_001a: ldc.i4.0
    IL_001b: br.s IL_001e
    IL_001d: ldc.i4.1
    IL_001e: add
    IL_001f: stelem.i4
    IL_0020: ldloc.3
    IL_0021: ldc.i4.1
    IL_0022: add
    IL_0023: stloc.3
    IL_0024: ldloc.3
    IL_0025: ldarg.2
    IL_0026: blt.s IL_0013
    IL_0028: ldloc.0
    IL_0029: ret

  .method SuperWaveGen::SplitSpawns(System.Collections.Generic.List<Spawn>,Spawn,int,float,ref float,float,float)  // token 0x06000725 rva 0x24260 attrs Private, HideBySig
    // code size 317 (0x13d), max stack 7, init locals
    .locals ([0] int, [1] int[], [2] int[], [3] float, [4] int, [5] float, [6] float, [7] float, [8] Spawn)
    IL_0000: ldarg.2
    IL_0001: ldfld int Spawn::count  /*0x040007E7*/
    IL_0006: ldc.i4.1
    IL_0007: bgt.s IL_0036
    IL_0009: ldarg.0
    IL_000a: ldarg.2
    IL_000b: ldfld int Spawn::count  /*0x040007E7*/
    IL_0010: ldarg.s 6
    IL_0012: ldarg.s 5
    IL_0014: ldarg.2
    IL_0015: ldflda float Spawn::interval  /*0x040007E8*/
    IL_001a: ldarg.2
    IL_001b: ldflda float Spawn::delay  /*0x040007E4*/
    IL_0020: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_0025: ldarg.2
    IL_0026: dup
    IL_0027: ldfld float Spawn::delay  /*0x040007E4*/
    IL_002c: ldarg.s 7
    IL_002e: add
    IL_002f: stfld float Spawn::delay  /*0x040007E4*/
    IL_0034: ldc.i4.0
    IL_0035: ret
    IL_0036: ldarg.3
    IL_0037: ldc.i4.1
    IL_0038: bgt.s IL_0067
    IL_003a: ldarg.0
    IL_003b: ldarg.2
    IL_003c: ldfld int Spawn::count  /*0x040007E7*/
    IL_0041: ldarg.s 6
    IL_0043: ldarg.s 5
    IL_0045: ldarg.2
    IL_0046: ldflda float Spawn::interval  /*0x040007E8*/
    IL_004b: ldarg.2
    IL_004c: ldflda float Spawn::delay  /*0x040007E4*/
    IL_0051: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_0056: ldarg.2
    IL_0057: dup
    IL_0058: ldfld float Spawn::delay  /*0x040007E4*/
    IL_005d: ldarg.s 7
    IL_005f: add
    IL_0060: stfld float Spawn::delay  /*0x040007E4*/
    IL_0065: ldc.i4.0
    IL_0066: ret
    IL_0067: ldarg.3
    IL_0068: ldarg.2
    IL_0069: ldfld int Spawn::count  /*0x040007E7*/
    IL_006e: ble.s IL_0078
    IL_0070: ldarg.2
    IL_0071: ldfld int Spawn::count  /*0x040007E7*/
    IL_0076: starg.s 3
    IL_0078: ldc.i4.0
    IL_0079: stloc.0
    IL_007a: ldarg.0
    IL_007b: ldarg.2
    IL_007c: ldfld int Spawn::count  /*0x040007E7*/
    IL_0081: ldarg.3
    IL_0082: call int[] SuperWaveGen::DistributeEvenly(int,int)  /*0x06000724*/
    IL_0087: stloc.1
    IL_0088: ldarg.0
    IL_0089: ldarg.2
    IL_008a: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_008f: ldarg.3
    IL_0090: call int[] SuperWaveGen::DistributeEvenly(int,int)  /*0x06000724*/
    IL_0095: stloc.2
    IL_0096: ldarg.s 6
    IL_0098: ldarg.s 4
    IL_009a: sub
    IL_009b: ldarg.3
    IL_009c: ldc.i4.1
    IL_009d: sub
    IL_009e: conv.r4
    IL_009f: div
    IL_00a0: stloc.3
    IL_00a1: ldarg.0
    IL_00a2: ldloc.1
    IL_00a3: ldc.i4.0
    IL_00a4: ldelem.i4
    IL_00a5: ldarg.s 4
    IL_00a7: ldarg.s 5
    IL_00a9: ldarg.2
    IL_00aa: ldflda float Spawn::interval  /*0x040007E8*/
    IL_00af: ldarg.2
    IL_00b0: ldflda float Spawn::delay  /*0x040007E4*/
    IL_00b5: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_00ba: ldarg.2
    IL_00bb: dup
    IL_00bc: ldfld float Spawn::delay  /*0x040007E4*/
    IL_00c1: ldarg.s 7
    IL_00c3: add
    IL_00c4: stfld float Spawn::delay  /*0x040007E4*/
    IL_00c9: ldarg.2
    IL_00ca: ldloc.1
    IL_00cb: ldc.i4.0
    IL_00cc: ldelem.i4
    IL_00cd: stfld int Spawn::count  /*0x040007E7*/
    IL_00d2: ldarg.2
    IL_00d3: ldloc.2
    IL_00d4: ldc.i4.0
    IL_00d5: ldelem.i4
    IL_00d6: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_00db: ldc.i4.1
    IL_00dc: stloc.s 4
    IL_00de: br.s IL_0136
    IL_00e0: ldloc.3
    IL_00e1: ldloc.s 4
    IL_00e3: conv.r4
    IL_00e4: mul
    IL_00e5: stloc.s 5
    IL_00e7: ldarg.0
    IL_00e8: ldloc.1
    IL_00e9: ldloc.s 4
    IL_00eb: ldelem.i4
    IL_00ec: ldarg.s 4
    IL_00ee: ldarg.s 5
    IL_00f0: ldloca.s 6
    IL_00f2: ldloca.s 7
    IL_00f4: call void SuperWaveGen::CalculateSpawnParameters(int,float,ref float,ref float,ref float)  /*0x06000723*/
    IL_00f9: ldarg.2
    IL_00fa: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_00ff: ldarg.2
    IL_0100: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0105: ldloc.1
    IL_0106: ldloc.s 4
    IL_0108: ldelem.i4
    IL_0109: ldloc.s 6
    IL_010b: ldloc.2
    IL_010c: ldloc.s 4
    IL_010e: ldelem.i4
    IL_010f: ldloc.s 5
    IL_0111: ldloc.s 7
    IL_0113: add
    IL_0114: ldarg.s 7
    IL_0116: add
    IL_0117: ldarg.2
    IL_0118: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_011d: newobj void Spawn::.ctor(UnityEngine.GameObject,UnityEngine.Transform,int,float,int,float,bool)  /*0x060006A5*/
    IL_0122: stloc.s 8
    IL_0124: ldarg.1
    IL_0125: ldloc.s 8
    IL_0127: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_012c: ldloc.0
    IL_012d: ldc.i4.1
    IL_012e: add
    IL_012f: stloc.0
    IL_0130: ldloc.s 4
    IL_0132: ldc.i4.1
    IL_0133: add
    IL_0134: stloc.s 4
    IL_0136: ldloc.s 4
    IL_0138: ldarg.3
    IL_0139: blt.s IL_00e0
    IL_013b: ldloc.0
    IL_013c: ret

  .method SuperWaveGen::GetRandomEnumValue()  // token 0x06000726 rva 0x243ac attrs Public, Static, HideBySig
    // code size 40 (0x28), max stack 3, init locals
    .locals ([0] Array)
    IL_0000: ldtoken !!0  /*0x1B00009D*/
    IL_0005: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_000a: call Array System.Enum::GetValues(System.Type)  /*0x0A00034E*/
    IL_000f: stloc.0
    IL_0010: ldloc.0
    IL_0011: ldc.i4.0
    IL_0012: ldloc.0
    IL_0013: callvirt int System.Array::get_Length()  /*0x0A00034F*/
    IL_0018: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_001d: callvirt object System.Array::GetValue(int)  /*0x0A000350*/
    IL_0022: unbox.any !!0  /*0x1B00009D*/
    IL_0027: ret

  .method SuperWaveGen::GetRandomEnumValueWithDistribution()  // token 0x06000727 rva 0x243e0 attrs Public, Static, HideBySig
    // code size 174 (0xae), max stack 3, init locals
    .locals ([0] List<!!0>, [1] int, [2] IEnumerator, [3] object, [4] string, [5] int, [6] int, [7] int, [8] IDisposable)
    IL_0000: ldtoken !!0  /*0x1B00009D*/
    IL_0005: call Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)  /*0x0A0002B5*/
    IL_000a: call Array System.Enum::GetValues(System.Type)  /*0x0A00034E*/
    IL_000f: newobj void System.Collections.Generic.List<!!0>::.ctor()  /*0x0A000351*/
    IL_0014: stloc.0
    IL_0015: callvirt IEnumerator System.Array::GetEnumerator()  /*0x0A000352*/
    IL_001a: stloc.2
    IL_001b: br.s IL_007b
    IL_001d: ldloc.2
    IL_001e: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0023: stloc.3
    IL_0024: ldloc.3
    IL_0025: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_002a: stloc.s 4
    IL_002c: ldloc.s 4
    IL_002e: ldc.i4.s 95
    IL_0030: callvirt int System.String::LastIndexOf(char)  /*0x0A000353*/
    IL_0035: stloc.s 5
    IL_0037: ldloc.s 5
    IL_0039: ldc.i4.0
    IL_003a: ble.s IL_006f
    IL_003c: ldloc.s 4
    IL_003e: ldloc.s 5
    IL_0040: ldc.i4.1
    IL_0041: add
    IL_0042: callvirt string System.String::Substring(int)  /*0x0A000354*/
    IL_0047: ldloca.s 6
    IL_0049: call bool System.Int32::TryParse(string,ref int)  /*0x0A000355*/
    IL_004e: brfalse.s IL_006f
    IL_0050: ldc.i4.0
    IL_0051: stloc.s 7
    IL_0053: br.s IL_0067
    IL_0055: ldloc.0
    IL_0056: ldloc.3
    IL_0057: unbox.any !!0  /*0x1B00009D*/
    IL_005c: callvirt void System.Collections.Generic.List<!!0>::Add(!0)  /*0x0A000356*/
    IL_0061: ldloc.s 7
    IL_0063: ldc.i4.1
    IL_0064: add
    IL_0065: stloc.s 7
    IL_0067: ldloc.s 7
    IL_0069: ldloc.s 6
    IL_006b: blt.s IL_0055
    IL_006d: br.s IL_007b
    IL_006f: ldloc.0
    IL_0070: ldloc.3
    IL_0071: unbox.any !!0  /*0x1B00009D*/
    IL_0076: callvirt void System.Collections.Generic.List<!!0>::Add(!0)  /*0x0A000356*/
    IL_007b: ldloc.2
    IL_007c: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0081: brtrue.s IL_001d
    IL_0083: leave.s IL_0099
    IL_0085: ldloc.2
    IL_0086: isinst System.IDisposable  /*0x0100001B*/
    IL_008b: stloc.s 8
    IL_008d: ldloc.s 8
    IL_008f: brfalse.s IL_0098
    IL_0091: ldloc.s 8
    IL_0093: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0098: endfinally
    IL_0099: ldc.i4.0
    IL_009a: ldloc.0
    IL_009b: callvirt int System.Collections.Generic.List<!!0>::get_Count()  /*0x0A00034B*/
    IL_00a0: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_00a5: stloc.1
    IL_00a6: ldloc.0
    IL_00a7: ldloc.1
    IL_00a8: callvirt !0 System.Collections.Generic.List<!!0>::get_Item(int)  /*0x0A000357*/
    IL_00ad: ret
    .try IL_001b-IL_0085 finally handler IL_0085-IL_0099

  .method SuperWaveGen::.ctor()  // token 0x06000728 rva 0x244ac attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4 200
    IL_0006: stfld int SuperWaveGen::maxAmountOfUnitsPerWave  /*0x04000894*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0011: stfld List<TagManager.ETag> SuperWaveGen::counterableTags  /*0x040008A5*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_001c: stfld List<int> SuperWaveGen::_OUTgoldSpentOnEconomyBeforeNigh  /*0x040008A9*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0027: stfld List<int> SuperWaveGen::_OUTgoldSpentOnDefenseBeforeNight  /*0x040008AA*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0032: stfld List<int> SuperWaveGen::_OUTNetworthBeforeNight  /*0x040008AB*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_003d: stfld List<int> SuperWaveGen::_OUTgoldEarnedInNight  /*0x040008AC*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0048: stfld List<int> SuperWaveGen::_OUTgoldDroppedInNight  /*0x040008AD*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0053: stfld List<string> SuperWaveGen::_OUTBuildorder  /*0x040008AE*/
    IL_0058: ldarg.0
    IL_0059: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_005e: stfld List<int> SuperWaveGen::_OUTDefensePower  /*0x040008AF*/
    IL_0063: ldarg.0
    IL_0064: call void EternalWaveGenerator::.ctor()  /*0x06000705*/
    IL_0069: ret

// ===== SuperWaveGen/EStartingGold  (token 0x02000151) =====
// ===== SuperWaveGen/EEnemyGoldDropRate  (token 0x02000152) =====
// ===== SuperWaveGen/EMinimumGoldGainPerNight  (token 0x02000153) =====
// ===== SuperWaveGen/EMaximumGoldGainPerNight  (token 0x02000154) =====
// ===== SuperWaveGen/EEnemyPreselection  (token 0x02000155) =====
// ===== SuperWaveGen/EEnemyTypesMode  (token 0x02000156) =====
// ===== SuperWaveGen/ESpawnSelectMode  (token 0x02000157) =====
// ===== SuperWaveGen/ESpawnInDuration  (token 0x02000158) =====
// ===== SuperWaveGen/EElitMode  (token 0x02000159) =====
// ===== SuperWaveGen/ESpawnInType  (token 0x0200015A) =====
// ===== SuperWaveGen/EDistributeDifficulty  (token 0x0200015B) =====
// ===== SuperWaveGen/EFinalWaveBonus  (token 0x0200015C) =====
// ===== SuperWaveGen/<>c  (token 0x0200015D) =====
  .method SuperWaveGen.<>c::.cctor()  // token 0x06000729 rva 0x24522 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void SuperWaveGen.<>c::.ctor()  /*0x0600072A*/
    IL_0005: stsfld SuperWaveGen.<>c SuperWaveGen.<>c::<>9  /*0x0400090F*/
    IL_000a: ret

  .method SuperWaveGen.<>c::.ctor()  // token 0x0600072A rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method SuperWaveGen.<>c::<GenerateWave>b__45_0(EternalTrialEnemy)  // token 0x0600072B rva 0x2452e attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt float EternalTrialEnemy::get_TempActualDifficulty()  /*0x060006E0*/
    IL_0006: ret

  .method SuperWaveGen.<>c::<GenerateWave>b__45_1(Spawn)  // token 0x0600072C rva 0x24536 attrs Assembly, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld int Spawn::count  /*0x040007E7*/
    IL_0006: ldc.i4.s 10
    IL_0008: blt.s IL_0014
    IL_000a: ldarg.1
    IL_000b: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_0010: ldc.i4.0
    IL_0011: ceq
    IL_0013: ret
    IL_0014: ldc.i4.0
    IL_0015: ret

  .method SuperWaveGen.<>c::<AdjustGoldAllocation>b__50_0(int)  // token 0x0600072D rva 0x2454d attrs Assembly, HideBySig
    // code size 5 (0x5), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: ceq
    IL_0004: ret

  .method SuperWaveGen.<>c::<AdjustGoldAllocation>b__50_1(int)  // token 0x0600072E rva 0x24553 attrs Assembly, HideBySig
    // code size 5 (0x5), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: cgt
    IL_0004: ret

