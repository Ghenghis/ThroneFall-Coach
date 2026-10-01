// ===== SeasonTwoWaveGen  (token 0x0200014E) =====
  .method SeasonTwoWaveGen::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  // token 0x06000713 rva 0x20584 attrs Public, Virtual, HideBySig
    // code size 3701 (0xe75), max stack 13, init locals
    .locals ([0] Random, [1] float, [2] int, [3] int, [4] float, [5] float, [6] List<EternalTrialEnemy>, [7] string, [8] float, [9] int, [10] int, [11] List<WaveDraft>, [12] int, [13] int, [14] Dictionary<EternalTrialEnemy, List<EnemySpawnLine>>, [15] List<Wave>, [16] int, [17] int, [18] int, [19] int, [20] int, [21] List.Enumerator<EternalTrialEnemy>, [22] EternalTrialEnemy, [23] EternalTrialEnemy, [24] int, [25] int, [26] WaveDraft, [27] int, [28] int, [29] int, [30] EternalTrialEnemy, [31] int, [32] EternalTrialEnemy, [33] EternalTrialEnemy, [34] List<EnemySpawnLine>, [35] string, [36] int, [37] EnemySpawnLine, [38] int, [39] int, [40] float, [41] float, [42] float, [43] WaveDraft, [44] float, [45] float, [46] float, [47] float, [48] float, [49] float, [50] string, [51] float, [52] int, [53] List<float>, [54] int, [55] int, [56] EternalTrialEnemy, [57] float, [58] int, [59] WaveDraft, [60] int, [61] int, [62] string, [63] int, [64] float, [65] int, [66] int, [67] int, [68] int, [69] int, [70] int, [71] int, [72] EternalTrialEnemy, [73] int, [74] WaveDraft, [75] int, [76] List<EnemySpawnLine>, [77] EternalTrialEnemy, [78] int, [79] List<EnemySpawnLine>, [80] int, [81] int, [82] int, [83] List.Enumerator<WaveDraft>, [84] WaveDraft, [85] Wave, [86] int, [87] EternalTrialEnemy, [88] bool, [89] float, [90] float, [91] List<EnemySpawnLine>, [92] int, [93] Spawn, [94] int)
    IL_0000: ldarg.s 5
    IL_0002: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_0007: stloc.0
    IL_0008: ldarg.s 5
    IL_000a: call void UnityEngine.Random::InitState(int)  /*0x0A000294*/
    IL_000f: ldarg.s 4
    IL_0011: ldloc.0
    IL_0012: ldc.i4.8
    IL_0013: ldc.i4.s 26
    IL_0015: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_001a: stind.i4
    IL_001b: ldarg.3
    IL_001c: ldc.i4.2
    IL_001d: bgt.s IL_0037
    IL_001f: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0024: ldc.r4 0.5f
    IL_0029: ble.un.s IL_0037
    IL_002b: ldarg.s 4
    IL_002d: ldloc.0
    IL_002e: ldc.i4.8
    IL_002f: ldc.i4.s 56
    IL_0031: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_0036: stind.i4
    IL_0037: ldarg.3
    IL_0038: ldc.i4.7
    IL_0039: blt.s IL_0048
    IL_003b: ldarg.s 4
    IL_003d: ldloc.0
    IL_003e: ldc.i4.s 13
    IL_0040: ldc.i4.s 26
    IL_0042: callvirt int System.Random::Next(int,int)  /*0x0A00017E*/
    IL_0047: stind.i4
    IL_0048: ldarg.3
    IL_0049: switch (IL_0064, IL_0070, IL_007c, IL_0088, IL_0094)
    IL_0062: br.s IL_00a0
    IL_0064: ldc.r4 0.7f
    IL_0069: stloc.1
    IL_006a: ldc.i4.3
    IL_006b: stloc.2
    IL_006c: ldc.i4.4
    IL_006d: stloc.3
    IL_006e: br.s IL_00b4
    IL_0070: ldc.r4 0.85f
    IL_0075: stloc.1
    IL_0076: ldc.i4.4
    IL_0077: stloc.2
    IL_0078: ldc.i4.4
    IL_0079: stloc.3
    IL_007a: br.s IL_00b4
    IL_007c: ldc.r4 1f
    IL_0081: stloc.1
    IL_0082: ldc.i4.5
    IL_0083: stloc.2
    IL_0084: ldc.i4.5
    IL_0085: stloc.3
    IL_0086: br.s IL_00b4
    IL_0088: ldc.r4 1.2f
    IL_008d: stloc.1
    IL_008e: ldc.i4.7
    IL_008f: stloc.2
    IL_0090: ldc.i4.6
    IL_0091: stloc.3
    IL_0092: br.s IL_00b4
    IL_0094: ldc.r4 1.44f
    IL_0099: stloc.1
    IL_009a: ldc.i4.8
    IL_009b: stloc.2
    IL_009c: ldc.i4.7
    IL_009d: stloc.3
    IL_009e: br.s IL_00b4
    IL_00a0: ldc.r4 1.2f
    IL_00a5: ldarg.3
    IL_00a6: ldc.i4.2
    IL_00a7: sub
    IL_00a8: conv.r4
    IL_00a9: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00ae: stloc.1
    IL_00af: ldc.i4.s 10
    IL_00b1: stloc.2
    IL_00b2: ldc.i4.8
    IL_00b3: stloc.3
    IL_00b4: ldc.r4 0.4f
    IL_00b9: stloc.s 4
    IL_00bb: ldc.r4 0.5f
    IL_00c0: stloc.s 5
    IL_00c2: ldarg.3
    IL_00c3: ldc.i4.3
    IL_00c4: bgt.s IL_00d4
    IL_00c6: ldc.r4 0.65f
    IL_00cb: stloc.s 4
    IL_00cd: ldc.r4 0.65f
    IL_00d2: stloc.s 5
    IL_00d4: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_00d9: stloc.s 6
    IL_00db: ldc.i4.0
    IL_00dc: stloc.s 16
    IL_00de: br IL_017e
    IL_00e3: ldarg.0
    IL_00e4: ldfld EternalTrialEnemySet SeasonTwoWaveGen::enemySet  /*0x0400087F*/
    IL_00e9: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_00ee: ldloc.3
    IL_00ef: ldloc.0
    IL_00f0: call List<!!0> WaveGenUtility::GetRandomElements(System.Collections.Generic.List<!!0>,int,System.Random)<EternalTrialEnemy>  /*0x2B000069*/
    IL_00f5: stloc.s 6
    IL_00f7: ldc.i4.0
    IL_00f8: stloc.s 17
    IL_00fa: ldc.i4.0
    IL_00fb: stloc.s 18
    IL_00fd: ldc.i4.0
    IL_00fe: stloc.s 19
    IL_0100: ldc.i4.0
    IL_0101: stloc.s 20
    IL_0103: ldloc.s 6
    IL_0105: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_010a: stloc.s 21
    IL_010c: br.s IL_015a
    IL_010e: ldloca.s 21
    IL_0110: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0115: stloc.s 22
    IL_0117: ldloc.s 22
    IL_0119: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_011e: brtrue.s IL_013a
    IL_0120: ldloc.s 17
    IL_0122: ldc.i4.1
    IL_0123: add
    IL_0124: stloc.s 17
    IL_0126: ldloc.s 22
    IL_0128: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_012d: ldc.r4 0f
    IL_0132: bgt.un.s IL_013a
    IL_0134: ldloc.s 20
    IL_0136: ldc.i4.1
    IL_0137: add
    IL_0138: stloc.s 20
    IL_013a: ldloc.s 22
    IL_013c: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0141: ldc.i4.1
    IL_0142: bne.un.s IL_014a
    IL_0144: ldloc.s 18
    IL_0146: ldc.i4.1
    IL_0147: add
    IL_0148: stloc.s 18
    IL_014a: ldloc.s 22
    IL_014c: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0151: ldc.i4.2
    IL_0152: bne.un.s IL_015a
    IL_0154: ldloc.s 19
    IL_0156: ldc.i4.1
    IL_0157: add
    IL_0158: stloc.s 19
    IL_015a: ldloca.s 21
    IL_015c: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0161: brtrue.s IL_010e
    IL_0163: leave.s IL_0173
    IL_0165: ldloca.s 21
    IL_0167: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_016d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0172: endfinally
    IL_0173: ldloc.s 20
    IL_0175: ldc.i4.0
    IL_0176: bgt.s IL_018a
    IL_0178: ldloc.s 16
    IL_017a: ldc.i4.1
    IL_017b: add
    IL_017c: stloc.s 16
    IL_017e: ldloc.s 16
    IL_0180: ldc.i4 2000
    IL_0185: blt IL_00e3
    IL_018a: ldloc.s 6
    IL_018c: ldloc.0
    IL_018d: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_0192: ldstr "LEVEL ENEMIES: "
    IL_0197: stloc.s 7
    IL_0199: ldloc.s 6
    IL_019b: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_01a0: stloc.s 21
    IL_01a2: br.s IL_01c7
    IL_01a4: ldloca.s 21
    IL_01a6: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_01ab: stloc.s 23
    IL_01ad: ldloc.s 7
    IL_01af: ldloc.s 23
    IL_01b1: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_01b6: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_01bb: ldstr ", "
    IL_01c0: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_01c5: stloc.s 7
    IL_01c7: ldloca.s 21
    IL_01c9: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_01ce: brtrue.s IL_01a4
    IL_01d0: leave.s IL_01e0
    IL_01d2: ldloca.s 21
    IL_01d4: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_01da: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01df: endfinally
    IL_01e0: ldloc.s 7
    IL_01e2: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_01e7: ldc.r4 0.2f
    IL_01ec: stloc.s 8
    IL_01ee: ldc.i4.3
    IL_01ef: stloc.s 9
    IL_01f1: ldc.i4.s 40
    IL_01f3: stloc.s 10
    IL_01f5: ldc.i4.0
    IL_01f6: stloc.s 24
    IL_01f8: br.s IL_0266
    IL_01fa: ldarg.0
    IL_01fb: ldflda List<int> SeasonTwoWaveGen::_OUTgoldSpentOnEconomyBeforeNigh  /*0x04000881*/
    IL_0200: ldarg.0
    IL_0201: ldflda List<int> SeasonTwoWaveGen::_OUTgoldSpentOnDefenseBeforeNight  /*0x04000882*/
    IL_0206: ldarg.0
    IL_0207: ldflda List<int> SeasonTwoWaveGen::_OUTNetworthBeforeNight  /*0x04000883*/
    IL_020c: ldarg.0
    IL_020d: ldflda List<int> SeasonTwoWaveGen::_OUTgoldEarnedInNight  /*0x04000884*/
    IL_0212: ldarg.0
    IL_0213: ldflda List<int> SeasonTwoWaveGen::_OUTgoldDroppedInNight  /*0x04000885*/
    IL_0218: ldarg.0
    IL_0219: ldflda List<string> SeasonTwoWaveGen::_OUTBuildorder  /*0x04000886*/
    IL_021e: ldarg.0
    IL_021f: ldflda List<int> SeasonTwoWaveGen::_OUTDefensePower  /*0x04000887*/
    IL_0224: ldarg.2
    IL_0225: ldfld List<VirtualBuilding> LevelInfo::virtualBuildings  /*0x04000B2C*/
    IL_022a: ldarg.s 4
    IL_022c: ldind.i4
    IL_022d: ldloc.s 8
    IL_022f: ldloc.s 9
    IL_0231: ldloc.s 10
    IL_0233: ldloc.2
    IL_0234: call void EconomySimulator::SimulateEconomy(ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<string>,ref System.Collections.Generic.List<int>,System.Collections.Generic.List<VirtualBuilding>,int,float,int,int,int)  /*0x060006C2*/
    IL_0239: ldloc.2
    IL_023a: ldarg.0
    IL_023b: ldfld List<int> SeasonTwoWaveGen::_OUTgoldEarnedInNight  /*0x04000884*/
    IL_0240: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0245: beq.s IL_026c
    IL_0247: ldarg.s 4
    IL_0249: ldind.i4
    IL_024a: ldc.i4.s 10
    IL_024c: ble.s IL_0256
    IL_024e: ldarg.s 4
    IL_0250: ldarg.s 4
    IL_0252: ldind.i4
    IL_0253: ldc.i4.1
    IL_0254: sub
    IL_0255: stind.i4
    IL_0256: ldloc.s 8
    IL_0258: ldc.r4 0.9f
    IL_025d: mul
    IL_025e: stloc.s 8
    IL_0260: ldloc.s 24
    IL_0262: ldc.i4.1
    IL_0263: add
    IL_0264: stloc.s 24
    IL_0266: ldloc.s 24
    IL_0268: ldc.i4.s 100
    IL_026a: blt.s IL_01fa
    IL_026c: ldarg.0
    IL_026d: ldfld List<int> SeasonTwoWaveGen::_OUTgoldEarnedInNight  /*0x04000884*/
    IL_0272: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0277: stloc.2
    IL_0278: newobj void System.Collections.Generic.List<WaveDraft>::.ctor()  /*0x0A0002FB*/
    IL_027d: stloc.s 11
    IL_027f: ldc.i4.0
    IL_0280: ldloc.s 6
    IL_0282: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0287: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_028c: stloc.s 12
    IL_028e: ldc.i4.0
    IL_028f: ldloc.s 6
    IL_0291: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0296: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_029b: stloc.s 13
    IL_029d: ldc.i4.0
    IL_029e: stloc.s 25
    IL_02a0: br IL_052d
    IL_02a5: newobj void WaveDraft::.ctor()  /*0x06000715*/
    IL_02aa: stloc.s 26
    IL_02ac: ldloc.s 11
    IL_02ae: ldloc.s 26
    IL_02b0: callvirt void System.Collections.Generic.List<WaveDraft>::Add(!0)  /*0x0A0002FD*/
    IL_02b5: ldloc.s 26
    IL_02b7: ldarg.0
    IL_02b8: ldfld List<int> SeasonTwoWaveGen::_OUTDefensePower  /*0x04000887*/
    IL_02bd: ldloc.s 25
    IL_02bf: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_02c4: conv.r4
    IL_02c5: ldc.r4 2f
    IL_02ca: mul
    IL_02cb: ldloc.1
    IL_02cc: mul
    IL_02cd: ldc.r4 11f
    IL_02d2: ldloc.1
    IL_02d3: ldc.r4 1f
    IL_02d8: ldc.r4 1.75f
    IL_02dd: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_02e2: mul
    IL_02e3: add
    IL_02e4: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_02e9: ldarg.3
    IL_02ea: brtrue.s IL_0304
    IL_02ec: ldloc.s 26
    IL_02ee: dup
    IL_02ef: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_02f4: ldc.r4 0.9f
    IL_02f9: mul
    IL_02fa: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_02ff: br IL_03aa
    IL_0304: ldarg.3
    IL_0305: ldc.i4.2
    IL_0306: bne.un.s IL_0328
    IL_0308: ldloc.s 26
    IL_030a: dup
    IL_030b: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0310: ldc.r4 1.01f
    IL_0315: ldloc.s 25
    IL_0317: conv.r4
    IL_0318: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_031d: mul
    IL_031e: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0323: br IL_03aa
    IL_0328: ldarg.3
    IL_0329: ldc.i4.3
    IL_032a: bne.un.s IL_0349
    IL_032c: ldloc.s 26
    IL_032e: dup
    IL_032f: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0334: ldc.r4 1.02f
    IL_0339: ldloc.s 25
    IL_033b: conv.r4
    IL_033c: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0341: mul
    IL_0342: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0347: br.s IL_03aa
    IL_0349: ldarg.3
    IL_034a: ldc.i4.4
    IL_034b: bne.un.s IL_036a
    IL_034d: ldloc.s 26
    IL_034f: dup
    IL_0350: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0355: ldc.r4 1.03f
    IL_035a: ldloc.s 25
    IL_035c: conv.r4
    IL_035d: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0362: mul
    IL_0363: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0368: br.s IL_03aa
    IL_036a: ldarg.3
    IL_036b: ldc.i4.5
    IL_036c: bne.un.s IL_038b
    IL_036e: ldloc.s 26
    IL_0370: dup
    IL_0371: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0376: ldc.r4 1.04f
    IL_037b: ldloc.s 25
    IL_037d: conv.r4
    IL_037e: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0383: mul
    IL_0384: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0389: br.s IL_03aa
    IL_038b: ldarg.3
    IL_038c: ldc.i4.6
    IL_038d: blt.s IL_03aa
    IL_038f: ldloc.s 26
    IL_0391: dup
    IL_0392: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0397: ldc.r4 1.05f
    IL_039c: ldloc.s 25
    IL_039e: conv.r4
    IL_039f: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_03a4: mul
    IL_03a5: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_03aa: ldloc.s 25
    IL_03ac: ldloc.2
    IL_03ad: ldc.i4.1
    IL_03ae: sub
    IL_03af: bne.un.s IL_03c4
    IL_03b1: ldloc.s 26
    IL_03b3: dup
    IL_03b4: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_03b9: ldc.r4 1.15f
    IL_03be: mul
    IL_03bf: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_03c4: ldloc.s 26
    IL_03c6: ldarg.0
    IL_03c7: ldfld List<int> SeasonTwoWaveGen::_OUTgoldSpentOnDefenseBeforeNight  /*0x04000882*/
    IL_03cc: ldloc.s 25
    IL_03ce: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_03d3: stfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_03d8: ldloc.s 26
    IL_03da: ldarg.0
    IL_03db: ldfld List<int> SeasonTwoWaveGen::_OUTgoldDroppedInNight  /*0x04000885*/
    IL_03e0: ldloc.s 25
    IL_03e2: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_03e7: stfld int WaveDraft::goldToDropAtNight  /*0x0400088D*/
    IL_03ec: ldloc.s 25
    IL_03ee: ldc.i4.1
    IL_03ef: add
    IL_03f0: ldc.i4.1
    IL_03f1: ldloc.s 6
    IL_03f3: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_03f8: ldc.i4.1
    IL_03f9: sub
    IL_03fa: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_03ff: stloc.s 28
    IL_0401: ldc.i4.1
    IL_0402: ldloc.s 28
    IL_0404: ldc.i4.1
    IL_0405: add
    IL_0406: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_040b: stloc.s 27
    IL_040d: ldloc.s 27
    IL_040f: ldc.i4.1
    IL_0410: ldc.i4.5
    IL_0411: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0416: stloc.s 27
    IL_0418: ldarg.3
    IL_0419: ldc.i4.3
    IL_041a: blt.s IL_0429
    IL_041c: ldloc.s 25
    IL_041e: brtrue.s IL_0429
    IL_0420: ldc.i4.1
    IL_0421: ldc.i4.3
    IL_0422: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0427: stloc.s 27
    IL_0429: ldarg.3
    IL_042a: ldc.i4.6
    IL_042b: blt.s IL_043b
    IL_042d: ldloc.s 25
    IL_042f: ldc.i4.1
    IL_0430: bgt.s IL_043b
    IL_0432: ldc.i4.1
    IL_0433: ldc.i4.4
    IL_0434: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0439: stloc.s 27
    IL_043b: ldarg.3
    IL_043c: ldc.i4.1
    IL_043d: blt.s IL_045a
    IL_043f: ldloc.0
    IL_0440: callvirt double System.Random::NextDouble()  /*0x0A000331*/
    IL_0445: ldc.r8 0.5
    IL_044e: bge.un.s IL_045a
    IL_0450: ldc.i4.2
    IL_0451: ldloc.s 27
    IL_0453: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0458: stloc.s 27
    IL_045a: ldc.i4.0
    IL_045b: stloc.s 29
    IL_045d: br.s IL_04ae
    IL_045f: ldloc.s 12
    IL_0461: ldc.i4.1
    IL_0462: add
    IL_0463: ldloc.s 6
    IL_0465: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_046a: rem
    IL_046b: stloc.s 12
    IL_046d: ldloc.s 6
    IL_046f: ldloc.s 12
    IL_0471: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0476: stloc.s 30
    IL_0478: ldloc.s 30
    IL_047a: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_047f: brtrue.s IL_04a8
    IL_0481: ldloc.s 26
    IL_0483: ldfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_0488: conv.r4
    IL_0489: ldloc.s 30
    IL_048b: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_0490: blt.un.s IL_04a8
    IL_0492: ldloc.s 26
    IL_0494: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0499: ldloc.s 30
    IL_049b: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_04a0: ldloc.s 27
    IL_04a2: ldc.i4.1
    IL_04a3: sub
    IL_04a4: stloc.s 27
    IL_04a6: br.s IL_04b9
    IL_04a8: ldloc.s 29
    IL_04aa: ldc.i4.1
    IL_04ab: add
    IL_04ac: stloc.s 29
    IL_04ae: ldloc.s 29
    IL_04b0: ldloc.s 6
    IL_04b2: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_04b7: blt.s IL_045f
    IL_04b9: ldloc.s 27
    IL_04bb: ldc.i4.0
    IL_04bc: ble.s IL_0527
    IL_04be: ldc.i4.0
    IL_04bf: stloc.s 31
    IL_04c1: br.s IL_051c
    IL_04c3: ldloc.s 13
    IL_04c5: ldc.i4.1
    IL_04c6: add
    IL_04c7: ldloc.s 6
    IL_04c9: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_04ce: rem
    IL_04cf: stloc.s 13
    IL_04d1: ldloc.s 6
    IL_04d3: ldloc.s 13
    IL_04d5: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_04da: stloc.s 32
    IL_04dc: ldloc.s 26
    IL_04de: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_04e3: ldloc.s 32
    IL_04e5: callvirt bool System.Collections.Generic.List<EternalTrialEnemy>::Contains(!0)  /*0x0A0002FF*/
    IL_04ea: brtrue.s IL_0516
    IL_04ec: ldloc.s 26
    IL_04ee: ldfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_04f3: conv.r4
    IL_04f4: ldloc.s 32
    IL_04f6: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_04fb: blt.un.s IL_0516
    IL_04fd: ldloc.s 26
    IL_04ff: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0504: ldloc.s 32
    IL_0506: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_050b: ldloc.s 27
    IL_050d: ldc.i4.1
    IL_050e: sub
    IL_050f: stloc.s 27
    IL_0511: ldloc.s 27
    IL_0513: ldc.i4.0
    IL_0514: ble.s IL_0527
    IL_0516: ldloc.s 31
    IL_0518: ldc.i4.1
    IL_0519: add
    IL_051a: stloc.s 31
    IL_051c: ldloc.s 31
    IL_051e: ldloc.s 6
    IL_0520: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0525: blt.s IL_04c3
    IL_0527: ldloc.s 25
    IL_0529: ldc.i4.1
    IL_052a: add
    IL_052b: stloc.s 25
    IL_052d: ldloc.s 25
    IL_052f: ldloc.2
    IL_0530: blt IL_02a5
    IL_0535: newobj void System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::.ctor()  /*0x0A000300*/
    IL_053a: stloc.s 14
    IL_053c: newobj void System.Collections.Generic.Dictionary<EnemySpawnLine, float>::.ctor()  /*0x0A000301*/
    IL_0541: pop
    IL_0542: ldloc.s 6
    IL_0544: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0549: stloc.s 21
    IL_054b: br IL_0619
    IL_0550: ldloca.s 21
    IL_0552: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0557: stloc.s 33
    IL_0559: ldarg.1
    IL_055a: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000302*/
    IL_055f: stloc.s 34
    IL_0561: ldloc.s 14
    IL_0563: ldloc.s 33
    IL_0565: ldloc.s 34
    IL_0567: callvirt void System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::Add(!0,!1)  /*0x0A000303*/
    IL_056c: ldloc.s 34
    IL_056e: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0573: ldc.i4.1
    IL_0574: sub
    IL_0575: stloc.s 36
    IL_0577: br.s IL_05c9
    IL_0579: ldloc.s 34
    IL_057b: ldloc.s 36
    IL_057d: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0582: stloc.s 37
    IL_0584: ldloc.s 33
    IL_0586: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_058b: brfalse.s IL_0596
    IL_058d: ldloc.s 37
    IL_058f: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_0594: brfalse.s IL_05ba
    IL_0596: ldloc.s 33
    IL_0598: callvirt bool EternalTrialEnemy::get_bigGround()  /*0x060006E7*/
    IL_059d: brfalse.s IL_05a8
    IL_059f: ldloc.s 37
    IL_05a1: ldfld bool EnemySpawnLine::canSpawnBigGround  /*0x0400082F*/
    IL_05a6: brfalse.s IL_05ba
    IL_05a8: ldloc.s 33
    IL_05aa: callvirt bool EternalTrialEnemy::get_smallGround()  /*0x060006E6*/
    IL_05af: brfalse.s IL_05c3
    IL_05b1: ldloc.s 37
    IL_05b3: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_05b8: brtrue.s IL_05c3
    IL_05ba: ldloc.s 34
    IL_05bc: ldloc.s 36
    IL_05be: callvirt void System.Collections.Generic.List<EnemySpawnLine>::RemoveAt(int)  /*0x0A000306*/
    IL_05c3: ldloc.s 36
    IL_05c5: ldc.i4.1
    IL_05c6: sub
    IL_05c7: stloc.s 36
    IL_05c9: ldloc.s 36
    IL_05cb: ldc.i4.0
    IL_05cc: bge.s IL_0579
    IL_05ce: ldloc.s 34
    IL_05d0: ldloc.0
    IL_05d1: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_05d6: ldstr ""
    IL_05db: stloc.s 35
    IL_05dd: ldc.i4.0
    IL_05de: stloc.s 38
    IL_05e0: br.s IL_060e
    IL_05e2: ldloc.s 35
    IL_05e4: ldloc.s 34
    IL_05e6: ldloc.s 38
    IL_05e8: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_05ed: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_05f2: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_05f7: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_05fc: ldstr ", "
    IL_0601: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0606: stloc.s 35
    IL_0608: ldloc.s 38
    IL_060a: ldc.i4.1
    IL_060b: add
    IL_060c: stloc.s 38
    IL_060e: ldloc.s 38
    IL_0610: ldloc.s 34
    IL_0612: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0617: blt.s IL_05e2
    IL_0619: ldloca.s 21
    IL_061b: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0620: brtrue IL_0550
    IL_0625: leave.s IL_0635
    IL_0627: ldloca.s 21
    IL_0629: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_062f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0634: endfinally
    IL_0635: ldc.i4.0
    IL_0636: stloc.s 39
    IL_0638: br IL_089b
    IL_063d: ldc.r4 0f
    IL_0642: stloc.s 40
    IL_0644: ldc.r4 0f
    IL_0649: stloc.s 41
    IL_064b: ldc.r4 0f
    IL_0650: stloc.s 42
    IL_0652: ldloc.s 11
    IL_0654: ldloc.s 39
    IL_0656: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_065b: stloc.s 43
    IL_065d: ldloc.s 43
    IL_065f: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0664: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0669: stloc.s 21
    IL_066b: br.s IL_06c1
    IL_066d: ldloca.s 21
    IL_066f: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0674: ldc.r4 1f
    IL_0679: ldc.r4 5f
    IL_067e: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0683: stloc.s 51
    IL_0685: dup
    IL_0686: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_068b: brtrue.s IL_0694
    IL_068d: ldloc.s 40
    IL_068f: ldloc.s 51
    IL_0691: add
    IL_0692: stloc.s 40
    IL_0694: dup
    IL_0695: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_069a: ldc.i4.1
    IL_069b: bne.un.s IL_06a4
    IL_069d: ldloc.s 41
    IL_069f: ldloc.s 51
    IL_06a1: add
    IL_06a2: stloc.s 41
    IL_06a4: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_06a9: ldc.i4.2
    IL_06aa: bne.un.s IL_06b3
    IL_06ac: ldloc.s 42
    IL_06ae: ldloc.s 51
    IL_06b0: add
    IL_06b1: stloc.s 42
    IL_06b3: ldloc.s 43
    IL_06b5: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_06ba: ldloc.s 51
    IL_06bc: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_06c1: ldloca.s 21
    IL_06c3: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_06c8: brtrue.s IL_066d
    IL_06ca: leave.s IL_06da
    IL_06cc: ldloca.s 21
    IL_06ce: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_06d4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_06d9: endfinally
    IL_06da: ldloc.s 40
    IL_06dc: ldloc.s 41
    IL_06de: add
    IL_06df: ldloc.s 42
    IL_06e1: add
    IL_06e2: stloc.s 44
    IL_06e4: ldloc.s 41
    IL_06e6: ldloc.s 44
    IL_06e8: div
    IL_06e9: ldc.r4 0f
    IL_06ee: ldloc.s 4
    IL_06f0: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_06f5: ldloc.s 44
    IL_06f7: mul
    IL_06f8: stloc.s 45
    IL_06fa: ldloc.s 42
    IL_06fc: ldloc.s 44
    IL_06fe: div
    IL_06ff: ldc.r4 0f
    IL_0704: ldloc.s 5
    IL_0706: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_070b: ldloc.s 44
    IL_070d: mul
    IL_070e: stloc.s 46
    IL_0710: ldloc.s 44
    IL_0712: ldloc.s 45
    IL_0714: sub
    IL_0715: ldloc.s 46
    IL_0717: sub
    IL_0718: ldloc.s 45
    IL_071a: ldloc.s 41
    IL_071c: div
    IL_071d: stloc.s 47
    IL_071f: ldloc.s 46
    IL_0721: ldloc.s 42
    IL_0723: div
    IL_0724: stloc.s 48
    IL_0726: ldloc.s 40
    IL_0728: div
    IL_0729: stloc.s 49
    IL_072b: ldc.i4.0
    IL_072c: stloc.s 52
    IL_072e: br IL_07e8
    IL_0733: ldloc.s 43
    IL_0735: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_073a: ldloc.s 52
    IL_073c: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0741: dup
    IL_0742: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0747: ldc.i4.1
    IL_0748: bne.un.s IL_076c
    IL_074a: ldloc.s 43
    IL_074c: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0751: stloc.s 53
    IL_0753: ldloc.s 52
    IL_0755: stloc.s 54
    IL_0757: ldloc.s 53
    IL_0759: ldloc.s 54
    IL_075b: ldloc.s 53
    IL_075d: ldloc.s 54
    IL_075f: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0764: ldloc.s 47
    IL_0766: mul
    IL_0767: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_076c: dup
    IL_076d: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0772: ldc.i4.2
    IL_0773: bne.un.s IL_0797
    IL_0775: ldloc.s 43
    IL_0777: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_077c: stloc.s 53
    IL_077e: ldloc.s 52
    IL_0780: stloc.s 54
    IL_0782: ldloc.s 53
    IL_0784: ldloc.s 54
    IL_0786: ldloc.s 53
    IL_0788: ldloc.s 54
    IL_078a: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_078f: ldloc.s 48
    IL_0791: mul
    IL_0792: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_0797: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_079c: brtrue.s IL_07c0
    IL_079e: ldloc.s 43
    IL_07a0: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_07a5: stloc.s 53
    IL_07a7: ldloc.s 52
    IL_07a9: stloc.s 54
    IL_07ab: ldloc.s 53
    IL_07ad: ldloc.s 54
    IL_07af: ldloc.s 53
    IL_07b1: ldloc.s 54
    IL_07b3: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_07b8: ldloc.s 49
    IL_07ba: mul
    IL_07bb: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_07c0: ldloc.s 43
    IL_07c2: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_07c7: stloc.s 53
    IL_07c9: ldloc.s 52
    IL_07cb: stloc.s 54
    IL_07cd: ldloc.s 53
    IL_07cf: ldloc.s 54
    IL_07d1: ldloc.s 53
    IL_07d3: ldloc.s 54
    IL_07d5: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_07da: ldloc.s 44
    IL_07dc: div
    IL_07dd: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_07e2: ldloc.s 52
    IL_07e4: ldc.i4.1
    IL_07e5: add
    IL_07e6: stloc.s 52
    IL_07e8: ldloc.s 52
    IL_07ea: ldloc.s 43
    IL_07ec: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_07f1: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_07f6: blt IL_0733
    IL_07fb: ldstr "Wave "
    IL_0800: ldloc.s 39
    IL_0802: ldc.i4.1
    IL_0803: add
    IL_0804: stloc.s 54
    IL_0806: ldloca.s 54
    IL_0808: call string System.Int32::ToString()  /*0x0A000031*/
    IL_080d: ldstr ": "
    IL_0812: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0817: stloc.s 50
    IL_0819: ldc.i4.0
    IL_081a: stloc.s 55
    IL_081c: br.s IL_0885
    IL_081e: ldloc.s 43
    IL_0820: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0825: ldloc.s 55
    IL_0827: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_082c: stloc.s 56
    IL_082e: ldc.i4.5
    IL_082f: newarr System.String  /*0x0100001D*/
    IL_0834: dup
    IL_0835: ldc.i4.0
    IL_0836: ldloc.s 50
    IL_0838: stelem.ref
    IL_0839: dup
    IL_083a: ldc.i4.1
    IL_083b: ldloc.s 56
    IL_083d: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0842: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0847: stelem.ref
    IL_0848: dup
    IL_0849: ldc.i4.2
    IL_084a: ldstr "("
    IL_084f: stelem.ref
    IL_0850: dup
    IL_0851: ldc.i4.3
    IL_0852: ldloc.s 43
    IL_0854: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0859: ldloc.s 55
    IL_085b: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0860: ldc.r4 100f
    IL_0865: mul
    IL_0866: stloc.s 57
    IL_0868: ldloca.s 57
    IL_086a: call string System.Single::ToString()  /*0x0A00030C*/
    IL_086f: stelem.ref
    IL_0870: dup
    IL_0871: ldc.i4.4
    IL_0872: ldstr "%), "
    IL_0877: stelem.ref
    IL_0878: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_087d: stloc.s 50
    IL_087f: ldloc.s 55
    IL_0881: ldc.i4.1
    IL_0882: add
    IL_0883: stloc.s 55
    IL_0885: ldloc.s 55
    IL_0887: ldloc.s 43
    IL_0889: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_088e: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0893: blt.s IL_081e
    IL_0895: ldloc.s 39
    IL_0897: ldc.i4.1
    IL_0898: add
    IL_0899: stloc.s 39
    IL_089b: ldloc.s 39
    IL_089d: ldloc.2
    IL_089e: blt IL_063d
    IL_08a3: ldc.i4.0
    IL_08a4: stloc.s 58
    IL_08a6: br IL_0b70
    IL_08ab: ldloc.s 11
    IL_08ad: ldloc.s 58
    IL_08af: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_08b4: stloc.s 59
    IL_08b6: ldc.i4.0
    IL_08b7: stloc.s 60
    IL_08b9: ldc.i4.0
    IL_08ba: stloc.s 61
    IL_08bc: ldc.i4.0
    IL_08bd: stloc.s 63
    IL_08bf: br IL_0944
    IL_08c4: ldloc.s 59
    IL_08c6: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_08cb: ldloc.s 59
    IL_08cd: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_08d2: ldloc.s 63
    IL_08d4: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_08d9: mul
    IL_08da: stloc.s 64
    IL_08dc: ldc.i4.1
    IL_08dd: ldloc.s 64
    IL_08df: ldloc.s 59
    IL_08e1: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_08e6: ldloc.s 63
    IL_08e8: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_08ed: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_08f2: div
    IL_08f3: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_08f8: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_08fd: stloc.s 65
    IL_08ff: ldloc.s 59
    IL_0901: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0906: ldloc.s 65
    IL_0908: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_090d: ldloc.s 59
    IL_090f: ldfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_0914: ldc.r4 1f
    IL_0919: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_091e: ldloc.s 59
    IL_0920: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_0925: ldc.i4.0
    IL_0926: callvirt void System.Collections.Generic.List<bool>::Add(!0)  /*0x0A00025B*/
    IL_092b: ldloc.s 60
    IL_092d: ldloc.s 65
    IL_092f: add
    IL_0930: stloc.s 60
    IL_0932: ldloc.s 60
    IL_0934: ldc.i4.s 10
    IL_0936: blt.s IL_093e
    IL_0938: ldloc.s 61
    IL_093a: ldc.i4.1
    IL_093b: add
    IL_093c: stloc.s 61
    IL_093e: ldloc.s 63
    IL_0940: ldc.i4.1
    IL_0941: add
    IL_0942: stloc.s 63
    IL_0944: ldloc.s 63
    IL_0946: ldloc.s 59
    IL_0948: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_094d: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0952: blt IL_08c4
    IL_0957: ldc.i4.0
    IL_0958: stloc.s 66
    IL_095a: br IL_09ef
    IL_095f: ldloc.s 60
    IL_0961: ldarg.0
    IL_0962: ldfld int SeasonTwoWaveGen::maxAmountOfUnitsPerWave  /*0x04000880*/
    IL_0967: ble IL_0a02
    IL_096c: ldloc.s 61
    IL_096e: ldc.i4.0
    IL_096f: ble IL_0a02
    IL_0974: ldloc.s 59
    IL_0976: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_097b: ldloc.s 66
    IL_097d: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0982: ldc.i4.s 10
    IL_0984: blt.s IL_09e9
    IL_0986: ldloc.s 59
    IL_0988: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_098d: ldloc.s 66
    IL_098f: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0994: stloc.s 67
    IL_0996: ldloc.s 59
    IL_0998: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_099d: ldloc.s 66
    IL_099f: ldloc.s 59
    IL_09a1: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_09a6: ldloc.s 66
    IL_09a8: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_09ad: conv.r4
    IL_09ae: ldc.r4 6f
    IL_09b3: div
    IL_09b4: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_09b9: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_09be: ldloc.s 59
    IL_09c0: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_09c5: ldloc.s 66
    IL_09c7: ldc.i4.1
    IL_09c8: callvirt void System.Collections.Generic.List<bool>::set_Item(int,!0)  /*0x0A000310*/
    IL_09cd: ldloc.s 61
    IL_09cf: ldc.i4.1
    IL_09d0: sub
    IL_09d1: stloc.s 61
    IL_09d3: ldloc.s 60
    IL_09d5: ldloc.s 67
    IL_09d7: ldloc.s 59
    IL_09d9: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_09de: ldloc.s 66
    IL_09e0: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_09e5: sub
    IL_09e6: sub
    IL_09e7: stloc.s 60
    IL_09e9: ldloc.s 66
    IL_09eb: ldc.i4.1
    IL_09ec: add
    IL_09ed: stloc.s 66
    IL_09ef: ldloc.s 66
    IL_09f1: ldloc.s 59
    IL_09f3: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_09f8: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_09fd: blt IL_095f
    IL_0a02: ldc.i4.0
    IL_0a03: stloc.s 68
    IL_0a05: br IL_0acd
    IL_0a0a: ldc.i4.0
    IL_0a0b: stloc.s 69
    IL_0a0d: br IL_0aaa
    IL_0a12: ldloc.s 60
    IL_0a14: ldarg.0
    IL_0a15: ldfld int SeasonTwoWaveGen::maxAmountOfUnitsPerWave  /*0x04000880*/
    IL_0a1a: ble IL_0abd
    IL_0a1f: ldloc.s 59
    IL_0a21: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0a26: ldloc.s 69
    IL_0a28: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a2d: ldc.i4.s 20
    IL_0a2f: blt.s IL_0aa4
    IL_0a31: ldloc.s 59
    IL_0a33: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0a38: ldloc.s 69
    IL_0a3a: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a3f: stloc.s 70
    IL_0a41: ldloc.s 59
    IL_0a43: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0a48: ldloc.s 69
    IL_0a4a: ldloc.s 59
    IL_0a4c: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0a51: ldloc.s 69
    IL_0a53: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a58: conv.r4
    IL_0a59: ldc.r4 0.75f
    IL_0a5e: mul
    IL_0a5f: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0a64: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_0a69: ldloc.s 59
    IL_0a6b: ldfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_0a70: stloc.s 53
    IL_0a72: ldloc.s 69
    IL_0a74: stloc.s 54
    IL_0a76: ldloc.s 53
    IL_0a78: ldloc.s 54
    IL_0a7a: ldloc.s 53
    IL_0a7c: ldloc.s 54
    IL_0a7e: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0a83: ldc.r4 2f
    IL_0a88: mul
    IL_0a89: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_0a8e: ldloc.s 60
    IL_0a90: ldloc.s 70
    IL_0a92: ldloc.s 59
    IL_0a94: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0a99: ldloc.s 69
    IL_0a9b: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0aa0: sub
    IL_0aa1: sub
    IL_0aa2: stloc.s 60
    IL_0aa4: ldloc.s 69
    IL_0aa6: ldc.i4.1
    IL_0aa7: add
    IL_0aa8: stloc.s 69
    IL_0aaa: ldloc.s 69
    IL_0aac: ldloc.s 59
    IL_0aae: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0ab3: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0ab8: blt IL_0a12
    IL_0abd: ldloc.s 60
    IL_0abf: ldarg.0
    IL_0ac0: ldfld int SeasonTwoWaveGen::maxAmountOfUnitsPerWave  /*0x04000880*/
    IL_0ac5: ble.s IL_0ad6
    IL_0ac7: ldloc.s 68
    IL_0ac9: ldc.i4.1
    IL_0aca: add
    IL_0acb: stloc.s 68
    IL_0acd: ldloc.s 68
    IL_0acf: ldc.i4.s 10
    IL_0ad1: blt IL_0a0a
    IL_0ad6: ldstr "Wave "
    IL_0adb: ldloc.s 58
    IL_0add: ldc.i4.1
    IL_0ade: add
    IL_0adf: stloc.s 54
    IL_0ae1: ldloca.s 54
    IL_0ae3: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0ae8: ldstr ": "
    IL_0aed: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0af2: stloc.s 62
    IL_0af4: ldc.i4.0
    IL_0af5: stloc.s 71
    IL_0af7: br.s IL_0b5a
    IL_0af9: ldloc.s 59
    IL_0afb: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0b00: ldloc.s 71
    IL_0b02: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0b07: stloc.s 72
    IL_0b09: ldc.i4.5
    IL_0b0a: newarr System.String  /*0x0100001D*/
    IL_0b0f: dup
    IL_0b10: ldc.i4.0
    IL_0b11: ldloc.s 62
    IL_0b13: stelem.ref
    IL_0b14: dup
    IL_0b15: ldc.i4.1
    IL_0b16: ldloc.s 72
    IL_0b18: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0b1d: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0b22: stelem.ref
    IL_0b23: dup
    IL_0b24: ldc.i4.2
    IL_0b25: ldstr "(x"
    IL_0b2a: stelem.ref
    IL_0b2b: dup
    IL_0b2c: ldc.i4.3
    IL_0b2d: ldloc.s 59
    IL_0b2f: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0b34: ldloc.s 71
    IL_0b36: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0b3b: stloc.s 54
    IL_0b3d: ldloca.s 54
    IL_0b3f: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0b44: stelem.ref
    IL_0b45: dup
    IL_0b46: ldc.i4.4
    IL_0b47: ldstr "), "
    IL_0b4c: stelem.ref
    IL_0b4d: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0b52: stloc.s 62
    IL_0b54: ldloc.s 71
    IL_0b56: ldc.i4.1
    IL_0b57: add
    IL_0b58: stloc.s 71
    IL_0b5a: ldloc.s 71
    IL_0b5c: ldloc.s 59
    IL_0b5e: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0b63: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0b68: blt.s IL_0af9
    IL_0b6a: ldloc.s 58
    IL_0b6c: ldc.i4.1
    IL_0b6d: add
    IL_0b6e: stloc.s 58
    IL_0b70: ldloc.s 58
    IL_0b72: ldloc.2
    IL_0b73: blt IL_08ab
    IL_0b78: ldc.i4.0
    IL_0b79: stloc.s 73
    IL_0b7b: br IL_0c89
    IL_0b80: ldloc.s 11
    IL_0b82: ldloc.s 73
    IL_0b84: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_0b89: stloc.s 74
    IL_0b8b: ldc.i4.0
    IL_0b8c: stloc.s 75
    IL_0b8e: br IL_0c70
    IL_0b93: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0b98: stloc.s 76
    IL_0b9a: ldloc.s 74
    IL_0b9c: ldfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_0ba1: ldloc.s 76
    IL_0ba3: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::Add(!0)  /*0x0A000311*/
    IL_0ba8: ldloc.s 74
    IL_0baa: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0baf: ldloc.s 75
    IL_0bb1: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0bb6: stloc.s 77
    IL_0bb8: ldc.i4.1
    IL_0bb9: stloc.s 78
    IL_0bbb: ldc.i4.0
    IL_0bbc: stloc.s 80
    IL_0bbe: br.s IL_0c07
    IL_0bc0: ldloc.s 11
    IL_0bc2: ldloc.s 80
    IL_0bc4: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_0bc9: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0bce: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0bd3: stloc.s 21
    IL_0bd5: br.s IL_0be8
    IL_0bd7: ldloca.s 21
    IL_0bd9: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_0bde: ldloc.s 77
    IL_0be0: bne.un.s IL_0be8
    IL_0be2: ldloc.s 78
    IL_0be4: ldc.i4.1
    IL_0be5: add
    IL_0be6: stloc.s 78
    IL_0be8: ldloca.s 21
    IL_0bea: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0bef: brtrue.s IL_0bd7
    IL_0bf1: leave.s IL_0c01
    IL_0bf3: ldloca.s 21
    IL_0bf5: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0bfb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0c00: endfinally
    IL_0c01: ldloc.s 80
    IL_0c03: ldc.i4.1
    IL_0c04: add
    IL_0c05: stloc.s 80
    IL_0c07: ldloc.s 80
    IL_0c09: ldloc.s 73
    IL_0c0b: blt.s IL_0bc0
    IL_0c0d: ldloc.s 14
    IL_0c0f: ldloc.s 77
    IL_0c11: callvirt !1 System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::get_Item(!0)  /*0x0A000312*/
    IL_0c16: stloc.s 79
    IL_0c18: ldc.i4.0
    IL_0c19: stloc.s 81
    IL_0c1b: br.s IL_0c3e
    IL_0c1d: ldloc.s 81
    IL_0c1f: ldloc.s 79
    IL_0c21: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0c26: bge.s IL_0c44
    IL_0c28: ldloc.s 76
    IL_0c2a: ldloc.s 79
    IL_0c2c: ldloc.s 81
    IL_0c2e: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0c33: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_0c38: ldloc.s 81
    IL_0c3a: ldc.i4.1
    IL_0c3b: add
    IL_0c3c: stloc.s 81
    IL_0c3e: ldloc.s 81
    IL_0c40: ldloc.s 78
    IL_0c42: blt.s IL_0c1d
    IL_0c44: ldloc.s 74
    IL_0c46: ldfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_0c4b: ldloc.s 74
    IL_0c4d: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0c52: ldloc.s 75
    IL_0c54: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0c59: ldloc.s 76
    IL_0c5b: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0c60: call List<int> WaveGenUtility::DistributeEnemies(int,int)  /*0x06000730*/
    IL_0c65: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<int>>::Add(!0)  /*0x0A000314*/
    IL_0c6a: ldloc.s 75
    IL_0c6c: ldc.i4.1
    IL_0c6d: add
    IL_0c6e: stloc.s 75
    IL_0c70: ldloc.s 75
    IL_0c72: ldloc.s 74
    IL_0c74: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0c79: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0c7e: blt IL_0b93
    IL_0c83: ldloc.s 73
    IL_0c85: ldc.i4.1
    IL_0c86: add
    IL_0c87: stloc.s 73
    IL_0c89: ldloc.s 73
    IL_0c8b: ldloc.2
    IL_0c8c: blt IL_0b80
    IL_0c91: ldc.i4.0
    IL_0c92: stloc.s 82
    IL_0c94: br.s IL_0cb5
    IL_0c96: ldloc.s 11
    IL_0c98: ldloc.s 82
    IL_0c9a: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_0c9f: dup
    IL_0ca0: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_0ca5: call float UnityEngine.Mathf::Sqrt(float)  /*0x0A000332*/
    IL_0caa: stfld float WaveDraft::waveDuration  /*0x04000890*/
    IL_0caf: ldloc.s 82
    IL_0cb1: ldc.i4.1
    IL_0cb2: add
    IL_0cb3: stloc.s 82
    IL_0cb5: ldloc.s 82
    IL_0cb7: ldloc.2
    IL_0cb8: blt.s IL_0c96
    IL_0cba: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_0cbf: stloc.s 15
    IL_0cc1: ldloc.s 11
    IL_0cc3: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveDraft>::GetEnumerator()  /*0x0A000315*/
    IL_0cc8: stloc.s 83
    IL_0cca: br IL_0e56
    IL_0ccf: ldloca.s 83
    IL_0cd1: call !0 System.Collections.Generic.List.Enumerator<WaveDraft>::get_Current()  /*0x0A000316*/
    IL_0cd6: stloc.s 84
    IL_0cd8: newobj void Wave::.ctor()  /*0x06000699*/
    IL_0cdd: stloc.s 85
    IL_0cdf: ldloc.s 15
    IL_0ce1: ldloc.s 85
    IL_0ce3: callvirt void System.Collections.Generic.List<Wave>::Add(!0)  /*0x0A000317*/
    IL_0ce8: ldc.i4.0
    IL_0ce9: stloc.s 86
    IL_0ceb: br IL_0e02
    IL_0cf0: ldloc.s 84
    IL_0cf2: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0cf7: ldloc.s 86
    IL_0cf9: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0cfe: stloc.s 87
    IL_0d00: ldloc.s 84
    IL_0d02: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0d07: ldloc.s 86
    IL_0d09: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0d0e: pop
    IL_0d0f: ldloc.s 84
    IL_0d11: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_0d16: ldloc.s 86
    IL_0d18: callvirt !0 System.Collections.Generic.List<bool>::get_Item(int)  /*0x0A00025C*/
    IL_0d1d: stloc.s 88
    IL_0d1f: ldloc.s 84
    IL_0d21: ldfld float WaveDraft::waveDuration  /*0x04000890*/
    IL_0d26: stloc.s 89
    IL_0d28: ldloc.s 84
    IL_0d2a: ldfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_0d2f: ldloc.s 86
    IL_0d31: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0d36: stloc.s 90
    IL_0d38: ldloc.s 84
    IL_0d3a: ldfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_0d3f: ldloc.s 86
    IL_0d41: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::get_Item(int)  /*0x0A000318*/
    IL_0d46: stloc.s 91
    IL_0d48: ldc.i4.0
    IL_0d49: stloc.s 92
    IL_0d4b: br IL_0dee
    IL_0d50: newobj void Spawn::.ctor()  /*0x060006A4*/
    IL_0d55: stloc.s 93
    IL_0d57: ldloc.s 93
    IL_0d59: ldloc.s 87
    IL_0d5b: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0d60: stfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0d65: ldloc.s 93
    IL_0d67: ldloc.s 84
    IL_0d69: ldfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_0d6e: ldloc.s 86
    IL_0d70: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<int>>::get_Item(int)  /*0x0A000319*/
    IL_0d75: ldloc.s 92
    IL_0d77: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0d7c: stfld int Spawn::count  /*0x040007E7*/
    IL_0d81: ldloc.s 93
    IL_0d83: ldloc.s 88
    IL_0d85: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_0d8a: ldloc.s 93
    IL_0d8c: ldc.r4 0f
    IL_0d91: stfld float Spawn::delay  /*0x040007E4*/
    IL_0d96: ldloc.s 93
    IL_0d98: ldloc.s 89
    IL_0d9a: ldc.i4.1
    IL_0d9b: ldloc.s 93
    IL_0d9d: ldfld int Spawn::count  /*0x040007E7*/
    IL_0da2: ldc.i4.1
    IL_0da3: sub
    IL_0da4: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0da9: conv.r4
    IL_0daa: div
    IL_0dab: ldloc.s 90
    IL_0dad: div
    IL_0dae: stfld float Spawn::interval  /*0x040007E8*/
    IL_0db3: ldloc.s 93
    IL_0db5: ldloc.s 91
    IL_0db7: ldloc.s 92
    IL_0db9: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0dbe: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0dc3: stfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0dc8: ldloc.s 93
    IL_0dca: ldc.i4.0
    IL_0dcb: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0dd0: ldloc.s 93
    IL_0dd2: ldfld int Spawn::count  /*0x040007E7*/
    IL_0dd7: ldc.i4.0
    IL_0dd8: ble.s IL_0de8
    IL_0dda: ldloc.s 85
    IL_0ddc: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0de1: ldloc.s 93
    IL_0de3: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_0de8: ldloc.s 92
    IL_0dea: ldc.i4.1
    IL_0deb: add
    IL_0dec: stloc.s 92
    IL_0dee: ldloc.s 92
    IL_0df0: ldloc.s 91
    IL_0df2: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0df7: blt IL_0d50
    IL_0dfc: ldloc.s 86
    IL_0dfe: ldc.i4.1
    IL_0dff: add
    IL_0e00: stloc.s 86
    IL_0e02: ldloc.s 86
    IL_0e04: ldloc.s 84
    IL_0e06: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0e0b: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0e10: blt IL_0cf0
    IL_0e15: ldloc.s 84
    IL_0e17: ldfld int WaveDraft::goldToDropAtNight  /*0x0400088D*/
    IL_0e1c: stloc.s 94
    IL_0e1e: br.s IL_0e51
    IL_0e20: ldloc.s 85
    IL_0e22: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0e27: ldc.i4.0
    IL_0e28: ldloc.s 85
    IL_0e2a: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0e2f: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_0e34: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0e39: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0e3e: dup
    IL_0e3f: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0e44: ldc.i4.1
    IL_0e45: add
    IL_0e46: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0e4b: ldloc.s 94
    IL_0e4d: ldc.i4.1
    IL_0e4e: sub
    IL_0e4f: stloc.s 94
    IL_0e51: ldloc.s 94
    IL_0e53: ldc.i4.0
    IL_0e54: bgt.s IL_0e20
    IL_0e56: ldloca.s 83
    IL_0e58: call bool System.Collections.Generic.List.Enumerator<WaveDraft>::MoveNext()  /*0x0A00031A*/
    IL_0e5d: brtrue IL_0ccf
    IL_0e62: leave.s IL_0e72
    IL_0e64: ldloca.s 83
    IL_0e66: constrained. System.Collections.Generic.List.Enumerator<WaveDraft>  /*0x1B000091*/
    IL_0e6c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0e71: endfinally
    IL_0e72: ldloc.s 15
    IL_0e74: ret
    .try IL_010c-IL_0165 finally handler IL_0165-IL_0173
    .try IL_01a2-IL_01d2 finally handler IL_01d2-IL_01e0
    .try IL_054b-IL_0627 finally handler IL_0627-IL_0635
    .try IL_066b-IL_06cc finally handler IL_06cc-IL_06da
    .try IL_0bd5-IL_0bf3 finally handler IL_0bf3-IL_0c01
    .try IL_0cca-IL_0e64 finally handler IL_0e64-IL_0e72

  .method SeasonTwoWaveGen::.ctor()  // token 0x06000714 rva 0x2149c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 95 (0x5f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4 200
    IL_0006: stfld int SeasonTwoWaveGen::maxAmountOfUnitsPerWave  /*0x04000880*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0011: stfld List<int> SeasonTwoWaveGen::_OUTgoldSpentOnEconomyBeforeNigh  /*0x04000881*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_001c: stfld List<int> SeasonTwoWaveGen::_OUTgoldSpentOnDefenseBeforeNight  /*0x04000882*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0027: stfld List<int> SeasonTwoWaveGen::_OUTNetworthBeforeNight  /*0x04000883*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0032: stfld List<int> SeasonTwoWaveGen::_OUTgoldEarnedInNight  /*0x04000884*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_003d: stfld List<int> SeasonTwoWaveGen::_OUTgoldDroppedInNight  /*0x04000885*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0048: stfld List<string> SeasonTwoWaveGen::_OUTBuildorder  /*0x04000886*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0053: stfld List<int> SeasonTwoWaveGen::_OUTDefensePower  /*0x04000887*/
    IL_0058: ldarg.0
    IL_0059: call void EternalWaveGenerator::.ctor()  /*0x06000705*/
    IL_005e: ret

