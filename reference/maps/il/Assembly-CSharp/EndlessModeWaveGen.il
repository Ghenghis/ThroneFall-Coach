// ===== EndlessModeWaveGen  (token 0x0200014A) =====
  .method EndlessModeWaveGen::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  // token 0x06000706 rva 0x1f268 attrs Public, Virtual, HideBySig
    // code size 2920 (0xb68), max stack 6, init locals
    .locals ([0] Random, [1] int, [2] List<EternalTrialEnemy>, [3] List<WaveDraft>, [4] int, [5] int, [6] Dictionary<EternalTrialEnemy, List<EnemySpawnLine>>, [7] List<EnemySpawnLine>, [8] List<Wave>, [9] int, [10] WaveDraft, [11] int, [12] int, [13] int, [14] EternalTrialEnemy, [15] int, [16] EternalTrialEnemy, [17] List.Enumerator<EternalTrialEnemy>, [18] EternalTrialEnemy, [19] List<EnemySpawnLine>, [20] int, [21] EnemySpawnLine, [22] int, [23] int, [24] float, [25] float, [26] float, [27] WaveDraft, [28] float, [29] float, [30] float, [31] float, [32] float, [33] float, [34] string, [35] float, [36] int, [37] List<float>, [38] int, [39] int, [40] EternalTrialEnemy, [41] float, [42] int, [43] EndlessModeWaveGen.<>c__DisplayClass7_0, [44] int, [45] int, [46] List<int>, [47] string, [48] int, [49] float, [50] int, [51] int, [52] List.Enumerator<int>, [53] int, [54] int, [55] int, [56] EternalTrialEnemy, [57] int, [58] WaveDraft, [59] int, [60] List<EnemySpawnLine>, [61] EternalTrialEnemy, [62] int, [63] List<EnemySpawnLine>, [64] int, [65] EnemySpawnLine, [66] WaveDraft, [67] int, [68] List<EnemySpawnLine>, [69] int, [70] List.Enumerator<WaveDraft>, [71] WaveDraft, [72] Wave, [73] int, [74] int, [75] EternalTrialEnemy, [76] bool, [77] float, [78] float, [79] List<EnemySpawnLine>, [80] int, [81] Spawn, [82] int)
    IL_0000: ldarg.s 5
    IL_0002: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_0007: stloc.0
    IL_0008: ldarg.s 5
    IL_000a: call void UnityEngine.Random::InitState(int)  /*0x0A000294*/
    IL_000f: ldarg.s 4
    IL_0011: ldarg.0
    IL_0012: ldfld int EndlessModeWaveGen::startingGold  /*0x04000863*/
    IL_0017: stind.i4
    IL_0018: ldarg.0
    IL_0019: ldfld float[] EndlessModeWaveGen::waveDifficulties  /*0x04000864*/
    IL_001e: ldlen
    IL_001f: conv.i4
    IL_0020: ldarg.0
    IL_0021: ldfld float[] EndlessModeWaveGen::difficultyMultiplayersAfterwards  /*0x04000865*/
    IL_0026: ldlen
    IL_0027: conv.i4
    IL_0028: add
    IL_0029: stloc.1
    IL_002a: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_002f: stloc.2
    IL_0030: ldloc.2
    IL_0031: ldarg.0
    IL_0032: ldfld EternalTrialEnemySet EndlessModeWaveGen::enemySet  /*0x04000861*/
    IL_0037: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_003c: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0002FA*/
    IL_0041: ldloc.2
    IL_0042: ldloc.0
    IL_0043: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_0048: newobj void System.Collections.Generic.List<WaveDraft>::.ctor()  /*0x0A0002FB*/
    IL_004d: stloc.3
    IL_004e: ldc.i4.0
    IL_004f: ldloc.2
    IL_0050: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0055: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_005a: stloc.s 4
    IL_005c: ldc.i4.0
    IL_005d: ldloc.2
    IL_005e: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0063: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0068: stloc.s 5
    IL_006a: ldc.i4.0
    IL_006b: stloc.s 9
    IL_006d: br IL_01ab
    IL_0072: newobj void WaveDraft::.ctor()  /*0x06000715*/
    IL_0077: stloc.s 10
    IL_0079: ldloc.3
    IL_007a: ldloc.s 10
    IL_007c: callvirt void System.Collections.Generic.List<WaveDraft>::Add(!0)  /*0x0A0002FD*/
    IL_0081: ldloc.s 10
    IL_0083: ldarg.0
    IL_0084: ldfld float[] EndlessModeWaveGen::waveDifficulties  /*0x04000864*/
    IL_0089: ldloc.s 9
    IL_008b: ldarg.0
    IL_008c: ldfld float[] EndlessModeWaveGen::waveDifficulties  /*0x04000864*/
    IL_0091: ldlen
    IL_0092: conv.i4
    IL_0093: ldc.i4.1
    IL_0094: sub
    IL_0095: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_009a: ldelem.r4
    IL_009b: stfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_00a0: ldloc.s 10
    IL_00a2: ldc.i4.4
    IL_00a3: ldloc.s 9
    IL_00a5: ldc.i4.4
    IL_00a6: mul
    IL_00a7: add
    IL_00a8: stfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_00ad: ldloc.s 10
    IL_00af: ldc.i4.4
    IL_00b0: ldloc.s 9
    IL_00b2: add
    IL_00b3: ldc.i4.s 50
    IL_00b5: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00ba: stfld int WaveDraft::goldToDropAtNight  /*0x0400088D*/
    IL_00bf: ldloc.s 9
    IL_00c1: ldc.i4.1
    IL_00c2: ldc.i4.3
    IL_00c3: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_00c8: add
    IL_00c9: ldc.i4.1
    IL_00ca: ldc.i4.8
    IL_00cb: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_00d0: stloc.s 11
    IL_00d2: ldc.i4.1
    IL_00d3: ldloc.s 11
    IL_00d5: ldc.i4.1
    IL_00d6: add
    IL_00d7: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_00dc: stloc.s 12
    IL_00de: ldc.i4.0
    IL_00df: stloc.s 13
    IL_00e1: br.s IL_0130
    IL_00e3: ldloc.s 4
    IL_00e5: ldc.i4.1
    IL_00e6: add
    IL_00e7: ldloc.2
    IL_00e8: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_00ed: rem
    IL_00ee: stloc.s 4
    IL_00f0: ldloc.2
    IL_00f1: ldloc.s 4
    IL_00f3: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_00f8: stloc.s 14
    IL_00fa: ldloc.s 14
    IL_00fc: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0101: brtrue.s IL_012a
    IL_0103: ldloc.s 10
    IL_0105: ldfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_010a: conv.r4
    IL_010b: ldloc.s 14
    IL_010d: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_0112: blt.un.s IL_012a
    IL_0114: ldloc.s 10
    IL_0116: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_011b: ldloc.s 14
    IL_011d: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_0122: ldloc.s 12
    IL_0124: ldc.i4.1
    IL_0125: sub
    IL_0126: stloc.s 12
    IL_0128: br.s IL_013a
    IL_012a: ldloc.s 13
    IL_012c: ldc.i4.1
    IL_012d: add
    IL_012e: stloc.s 13
    IL_0130: ldloc.s 13
    IL_0132: ldloc.2
    IL_0133: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0138: blt.s IL_00e3
    IL_013a: ldloc.s 12
    IL_013c: ldc.i4.0
    IL_013d: ble.s IL_01a5
    IL_013f: ldc.i4.0
    IL_0140: stloc.s 15
    IL_0142: br.s IL_019b
    IL_0144: ldloc.s 5
    IL_0146: ldc.i4.1
    IL_0147: add
    IL_0148: ldloc.2
    IL_0149: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_014e: rem
    IL_014f: stloc.s 5
    IL_0151: ldloc.2
    IL_0152: ldloc.s 5
    IL_0154: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0159: stloc.s 16
    IL_015b: ldloc.s 10
    IL_015d: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0162: ldloc.s 16
    IL_0164: callvirt bool System.Collections.Generic.List<EternalTrialEnemy>::Contains(!0)  /*0x0A0002FF*/
    IL_0169: brtrue.s IL_0195
    IL_016b: ldloc.s 10
    IL_016d: ldfld int WaveDraft::defenseGoldSpent  /*0x0400088C*/
    IL_0172: conv.r4
    IL_0173: ldloc.s 16
    IL_0175: ldfld float EternalTrialEnemy::minDefenseInvestment  /*0x04000839*/
    IL_017a: blt.un.s IL_0195
    IL_017c: ldloc.s 10
    IL_017e: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0183: ldloc.s 16
    IL_0185: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_018a: ldloc.s 12
    IL_018c: ldc.i4.1
    IL_018d: sub
    IL_018e: stloc.s 12
    IL_0190: ldloc.s 12
    IL_0192: ldc.i4.0
    IL_0193: ble.s IL_01a5
    IL_0195: ldloc.s 15
    IL_0197: ldc.i4.1
    IL_0198: add
    IL_0199: stloc.s 15
    IL_019b: ldloc.s 15
    IL_019d: ldloc.2
    IL_019e: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_01a3: blt.s IL_0144
    IL_01a5: ldloc.s 9
    IL_01a7: ldc.i4.1
    IL_01a8: add
    IL_01a9: stloc.s 9
    IL_01ab: ldloc.s 9
    IL_01ad: ldloc.1
    IL_01ae: blt IL_0072
    IL_01b3: newobj void System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::.ctor()  /*0x0A000300*/
    IL_01b8: stloc.s 6
    IL_01ba: newobj void System.Collections.Generic.Dictionary<EnemySpawnLine, float>::.ctor()  /*0x0A000301*/
    IL_01bf: pop
    IL_01c0: ldloc.2
    IL_01c1: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_01c6: stloc.s 17
    IL_01c8: br IL_0253
    IL_01cd: ldloca.s 17
    IL_01cf: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_01d4: stloc.s 18
    IL_01d6: ldarg.1
    IL_01d7: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000302*/
    IL_01dc: stloc.s 19
    IL_01de: ldloc.s 6
    IL_01e0: ldloc.s 18
    IL_01e2: ldloc.s 19
    IL_01e4: callvirt void System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::Add(!0,!1)  /*0x0A000303*/
    IL_01e9: ldloc.s 19
    IL_01eb: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_01f0: ldc.i4.1
    IL_01f1: sub
    IL_01f2: stloc.s 20
    IL_01f4: br.s IL_0246
    IL_01f6: ldloc.s 19
    IL_01f8: ldloc.s 20
    IL_01fa: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_01ff: stloc.s 21
    IL_0201: ldloc.s 18
    IL_0203: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_0208: brfalse.s IL_0213
    IL_020a: ldloc.s 21
    IL_020c: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_0211: brfalse.s IL_0237
    IL_0213: ldloc.s 18
    IL_0215: callvirt bool EternalTrialEnemy::get_bigGround()  /*0x060006E7*/
    IL_021a: brfalse.s IL_0225
    IL_021c: ldloc.s 21
    IL_021e: ldfld bool EnemySpawnLine::canSpawnBigGround  /*0x0400082F*/
    IL_0223: brfalse.s IL_0237
    IL_0225: ldloc.s 18
    IL_0227: callvirt bool EternalTrialEnemy::get_smallGround()  /*0x060006E6*/
    IL_022c: brfalse.s IL_0240
    IL_022e: ldloc.s 21
    IL_0230: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_0235: brtrue.s IL_0240
    IL_0237: ldloc.s 19
    IL_0239: ldloc.s 20
    IL_023b: callvirt void System.Collections.Generic.List<EnemySpawnLine>::RemoveAt(int)  /*0x0A000306*/
    IL_0240: ldloc.s 20
    IL_0242: ldc.i4.1
    IL_0243: sub
    IL_0244: stloc.s 20
    IL_0246: ldloc.s 20
    IL_0248: ldc.i4.0
    IL_0249: bge.s IL_01f6
    IL_024b: ldloc.s 19
    IL_024d: ldloc.0
    IL_024e: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EnemySpawnLine>  /*0x2B000068*/
    IL_0253: ldloca.s 17
    IL_0255: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_025a: brtrue IL_01cd
    IL_025f: leave.s IL_026f
    IL_0261: ldloca.s 17
    IL_0263: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0269: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_026e: endfinally
    IL_026f: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0274: stloc.s 7
    IL_0276: ldloc.s 7
    IL_0278: ldarg.1
    IL_0279: callvirt void System.Collections.Generic.List<EnemySpawnLine>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000307*/
    IL_027e: ldloc.s 7
    IL_0280: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0285: ldc.i4.1
    IL_0286: sub
    IL_0287: stloc.s 22
    IL_0289: br.s IL_02ca
    IL_028b: ldloc.s 7
    IL_028d: ldloc.s 22
    IL_028f: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0294: ldfld bool EnemySpawnLine::canSpawnBigGround  /*0x0400082F*/
    IL_0299: brfalse.s IL_02bb
    IL_029b: ldloc.s 7
    IL_029d: ldloc.s 22
    IL_029f: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_02a4: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_02a9: brfalse.s IL_02bb
    IL_02ab: ldloc.s 7
    IL_02ad: ldloc.s 22
    IL_02af: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_02b4: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_02b9: brtrue.s IL_02c4
    IL_02bb: ldloc.s 7
    IL_02bd: ldloc.s 22
    IL_02bf: callvirt void System.Collections.Generic.List<EnemySpawnLine>::RemoveAt(int)  /*0x0A000306*/
    IL_02c4: ldloc.s 22
    IL_02c6: ldc.i4.1
    IL_02c7: sub
    IL_02c8: stloc.s 22
    IL_02ca: ldloc.s 22
    IL_02cc: ldc.i4.0
    IL_02cd: bge.s IL_028b
    IL_02cf: ldc.i4.0
    IL_02d0: stloc.s 23
    IL_02d2: br IL_053c
    IL_02d7: ldc.r4 0f
    IL_02dc: stloc.s 24
    IL_02de: ldc.r4 0f
    IL_02e3: stloc.s 25
    IL_02e5: ldc.r4 0f
    IL_02ea: stloc.s 26
    IL_02ec: ldloc.3
    IL_02ed: ldloc.s 23
    IL_02ef: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_02f4: stloc.s 27
    IL_02f6: ldloc.s 27
    IL_02f8: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_02fd: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0302: stloc.s 17
    IL_0304: br.s IL_035a
    IL_0306: ldloca.s 17
    IL_0308: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_030d: ldc.r4 1f
    IL_0312: ldc.r4 5f
    IL_0317: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_031c: stloc.s 35
    IL_031e: dup
    IL_031f: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0324: brtrue.s IL_032d
    IL_0326: ldloc.s 24
    IL_0328: ldloc.s 35
    IL_032a: add
    IL_032b: stloc.s 24
    IL_032d: dup
    IL_032e: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0333: ldc.i4.1
    IL_0334: bne.un.s IL_033d
    IL_0336: ldloc.s 25
    IL_0338: ldloc.s 35
    IL_033a: add
    IL_033b: stloc.s 25
    IL_033d: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0342: ldc.i4.2
    IL_0343: bne.un.s IL_034c
    IL_0345: ldloc.s 26
    IL_0347: ldloc.s 35
    IL_0349: add
    IL_034a: stloc.s 26
    IL_034c: ldloc.s 27
    IL_034e: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0353: ldloc.s 35
    IL_0355: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_035a: ldloca.s 17
    IL_035c: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0361: brtrue.s IL_0306
    IL_0363: leave.s IL_0373
    IL_0365: ldloca.s 17
    IL_0367: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_036d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0372: endfinally
    IL_0373: ldloc.s 24
    IL_0375: ldloc.s 25
    IL_0377: add
    IL_0378: ldloc.s 26
    IL_037a: add
    IL_037b: stloc.s 28
    IL_037d: ldloc.s 25
    IL_037f: ldloc.s 28
    IL_0381: div
    IL_0382: ldc.r4 0f
    IL_0387: ldarg.0
    IL_0388: ldfld float EndlessModeWaveGen::maxFlavourUnits  /*0x04000866*/
    IL_038d: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0392: ldloc.s 28
    IL_0394: mul
    IL_0395: stloc.s 29
    IL_0397: ldloc.s 26
    IL_0399: ldloc.s 28
    IL_039b: div
    IL_039c: ldc.r4 0f
    IL_03a1: ldarg.0
    IL_03a2: ldfld float EndlessModeWaveGen::maxFlyingUnits  /*0x04000867*/
    IL_03a7: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_03ac: ldloc.s 28
    IL_03ae: mul
    IL_03af: stloc.s 30
    IL_03b1: ldloc.s 28
    IL_03b3: ldloc.s 29
    IL_03b5: sub
    IL_03b6: ldloc.s 30
    IL_03b8: sub
    IL_03b9: ldloc.s 29
    IL_03bb: ldloc.s 25
    IL_03bd: div
    IL_03be: stloc.s 31
    IL_03c0: ldloc.s 30
    IL_03c2: ldloc.s 26
    IL_03c4: div
    IL_03c5: stloc.s 32
    IL_03c7: ldloc.s 24
    IL_03c9: div
    IL_03ca: stloc.s 33
    IL_03cc: ldc.i4.0
    IL_03cd: stloc.s 36
    IL_03cf: br IL_0489
    IL_03d4: ldloc.s 27
    IL_03d6: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_03db: ldloc.s 36
    IL_03dd: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_03e2: dup
    IL_03e3: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_03e8: ldc.i4.1
    IL_03e9: bne.un.s IL_040d
    IL_03eb: ldloc.s 27
    IL_03ed: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_03f2: stloc.s 37
    IL_03f4: ldloc.s 36
    IL_03f6: stloc.s 38
    IL_03f8: ldloc.s 37
    IL_03fa: ldloc.s 38
    IL_03fc: ldloc.s 37
    IL_03fe: ldloc.s 38
    IL_0400: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0405: ldloc.s 31
    IL_0407: mul
    IL_0408: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_040d: dup
    IL_040e: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_0413: ldc.i4.2
    IL_0414: bne.un.s IL_0438
    IL_0416: ldloc.s 27
    IL_0418: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_041d: stloc.s 37
    IL_041f: ldloc.s 36
    IL_0421: stloc.s 38
    IL_0423: ldloc.s 37
    IL_0425: ldloc.s 38
    IL_0427: ldloc.s 37
    IL_0429: ldloc.s 38
    IL_042b: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0430: ldloc.s 32
    IL_0432: mul
    IL_0433: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_0438: ldfld EternalTrialEnemy.EGroup EternalTrialEnemy::group  /*0x04000843*/
    IL_043d: brtrue.s IL_0461
    IL_043f: ldloc.s 27
    IL_0441: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0446: stloc.s 37
    IL_0448: ldloc.s 36
    IL_044a: stloc.s 38
    IL_044c: ldloc.s 37
    IL_044e: ldloc.s 38
    IL_0450: ldloc.s 37
    IL_0452: ldloc.s 38
    IL_0454: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0459: ldloc.s 33
    IL_045b: mul
    IL_045c: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_0461: ldloc.s 27
    IL_0463: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0468: stloc.s 37
    IL_046a: ldloc.s 36
    IL_046c: stloc.s 38
    IL_046e: ldloc.s 37
    IL_0470: ldloc.s 38
    IL_0472: ldloc.s 37
    IL_0474: ldloc.s 38
    IL_0476: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_047b: ldloc.s 28
    IL_047d: div
    IL_047e: callvirt void System.Collections.Generic.List<float>::set_Item(int,!0)  /*0x0A00030B*/
    IL_0483: ldloc.s 36
    IL_0485: ldc.i4.1
    IL_0486: add
    IL_0487: stloc.s 36
    IL_0489: ldloc.s 36
    IL_048b: ldloc.s 27
    IL_048d: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0492: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0497: blt IL_03d4
    IL_049c: ldstr "Wave "
    IL_04a1: ldloc.s 23
    IL_04a3: ldc.i4.1
    IL_04a4: add
    IL_04a5: stloc.s 38
    IL_04a7: ldloca.s 38
    IL_04a9: call string System.Int32::ToString()  /*0x0A000031*/
    IL_04ae: ldstr ": "
    IL_04b3: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_04b8: stloc.s 34
    IL_04ba: ldc.i4.0
    IL_04bb: stloc.s 39
    IL_04bd: br.s IL_0526
    IL_04bf: ldloc.s 27
    IL_04c1: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_04c6: ldloc.s 39
    IL_04c8: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_04cd: stloc.s 40
    IL_04cf: ldc.i4.5
    IL_04d0: newarr System.String  /*0x0100001D*/
    IL_04d5: dup
    IL_04d6: ldc.i4.0
    IL_04d7: ldloc.s 34
    IL_04d9: stelem.ref
    IL_04da: dup
    IL_04db: ldc.i4.1
    IL_04dc: ldloc.s 40
    IL_04de: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_04e3: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_04e8: stelem.ref
    IL_04e9: dup
    IL_04ea: ldc.i4.2
    IL_04eb: ldstr "("
    IL_04f0: stelem.ref
    IL_04f1: dup
    IL_04f2: ldc.i4.3
    IL_04f3: ldloc.s 27
    IL_04f5: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_04fa: ldloc.s 39
    IL_04fc: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0501: ldc.r4 100f
    IL_0506: mul
    IL_0507: stloc.s 41
    IL_0509: ldloca.s 41
    IL_050b: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0510: stelem.ref
    IL_0511: dup
    IL_0512: ldc.i4.4
    IL_0513: ldstr "%), "
    IL_0518: stelem.ref
    IL_0519: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_051e: stloc.s 34
    IL_0520: ldloc.s 39
    IL_0522: ldc.i4.1
    IL_0523: add
    IL_0524: stloc.s 39
    IL_0526: ldloc.s 39
    IL_0528: ldloc.s 27
    IL_052a: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_052f: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0534: blt.s IL_04bf
    IL_0536: ldloc.s 23
    IL_0538: ldc.i4.1
    IL_0539: add
    IL_053a: stloc.s 23
    IL_053c: ldloc.s 23
    IL_053e: ldloc.1
    IL_053f: blt IL_02d7
    IL_0544: ldc.i4.0
    IL_0545: stloc.s 42
    IL_0547: br IL_07f2
    IL_054c: newobj void EndlessModeWaveGen.<>c__DisplayClass7_0::.ctor()  /*0x06000708*/
    IL_0551: stloc.s 43
    IL_0553: ldloc.s 43
    IL_0555: ldloc.3
    IL_0556: ldloc.s 42
    IL_0558: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_055d: stfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0562: ldc.i4.0
    IL_0563: stloc.s 44
    IL_0565: ldc.i4.0
    IL_0566: stloc.s 45
    IL_0568: ldc.i4.0
    IL_0569: stloc.s 48
    IL_056b: br IL_060e
    IL_0570: ldloc.s 43
    IL_0572: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0577: ldfld float WaveDraft::targetDifficulty  /*0x0400088B*/
    IL_057c: ldloc.s 43
    IL_057e: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0583: ldfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0588: ldloc.s 48
    IL_058a: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_058f: mul
    IL_0590: stloc.s 49
    IL_0592: ldc.i4.1
    IL_0593: ldloc.s 49
    IL_0595: ldloc.s 43
    IL_0597: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_059c: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_05a1: ldloc.s 48
    IL_05a3: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_05a8: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_05ad: div
    IL_05ae: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_05b3: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_05b8: stloc.s 50
    IL_05ba: ldloc.s 43
    IL_05bc: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_05c1: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_05c6: ldloc.s 50
    IL_05c8: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_05cd: ldloc.s 43
    IL_05cf: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_05d4: ldfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_05d9: ldc.r4 1f
    IL_05de: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_05e3: ldloc.s 43
    IL_05e5: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_05ea: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_05ef: ldc.i4.0
    IL_05f0: callvirt void System.Collections.Generic.List<bool>::Add(!0)  /*0x0A00025B*/
    IL_05f5: ldloc.s 44
    IL_05f7: ldloc.s 50
    IL_05f9: add
    IL_05fa: stloc.s 44
    IL_05fc: ldloc.s 44
    IL_05fe: ldc.i4.s 10
    IL_0600: blt.s IL_0608
    IL_0602: ldloc.s 45
    IL_0604: ldc.i4.1
    IL_0605: add
    IL_0606: stloc.s 45
    IL_0608: ldloc.s 48
    IL_060a: ldc.i4.1
    IL_060b: add
    IL_060c: stloc.s 48
    IL_060e: ldloc.s 48
    IL_0610: ldloc.s 43
    IL_0612: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0617: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_061c: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0621: blt IL_0570
    IL_0626: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_062b: stloc.s 46
    IL_062d: ldc.i4.0
    IL_062e: stloc.s 51
    IL_0630: br.s IL_0641
    IL_0632: ldloc.s 46
    IL_0634: ldloc.s 51
    IL_0636: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_063b: ldloc.s 51
    IL_063d: ldc.i4.1
    IL_063e: add
    IL_063f: stloc.s 51
    IL_0641: ldloc.s 51
    IL_0643: ldloc.s 43
    IL_0645: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_064a: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_064f: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0654: blt.s IL_0632
    IL_0656: ldloc.s 46
    IL_0658: ldloc.s 43
    IL_065a: ldftn int EndlessModeWaveGen.<>c__DisplayClass7_0::<GenerateWaves>b__0(int,int)  /*0x06000709*/
    IL_0660: newobj void System.Comparison<int>::.ctor(object,IntPtr)  /*0x0A00030D*/
    IL_0665: callvirt void System.Collections.Generic.List<int>::Sort(System.Comparison<!0>)  /*0x0A00030E*/
    IL_066a: ldloc.s 46
    IL_066c: callvirt List.Enumerator<!0> System.Collections.Generic.List<int>::GetEnumerator()  /*0x0A0002C5*/
    IL_0671: stloc.s 52
    IL_0673: br IL_072d
    IL_0678: ldloca.s 52
    IL_067a: call !0 System.Collections.Generic.List.Enumerator<int>::get_Current()  /*0x0A0002C6*/
    IL_067f: stloc.s 53
    IL_0681: ldloc.s 44
    IL_0683: ldarg.0
    IL_0684: ldfld int EndlessModeWaveGen::maxAmountOfUnitsPerWave  /*0x04000862*/
    IL_0689: bgt.s IL_0690
    IL_068b: leave IL_0749
    IL_0690: ldloc.s 45
    IL_0692: ldc.i4.0
    IL_0693: bgt.s IL_069a
    IL_0695: leave IL_0749
    IL_069a: ldloc.s 43
    IL_069c: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_06a1: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_06a6: ldloc.s 53
    IL_06a8: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_06ad: ldc.i4.s 10
    IL_06af: blt.s IL_072d
    IL_06b1: ldloc.s 43
    IL_06b3: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_06b8: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_06bd: ldloc.s 53
    IL_06bf: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_06c4: stloc.s 54
    IL_06c6: ldloc.s 43
    IL_06c8: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_06cd: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_06d2: ldloc.s 53
    IL_06d4: ldloc.s 43
    IL_06d6: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_06db: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_06e0: ldloc.s 53
    IL_06e2: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_06e7: conv.r4
    IL_06e8: ldc.r4 6f
    IL_06ed: div
    IL_06ee: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_06f3: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_06f8: ldloc.s 43
    IL_06fa: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_06ff: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_0704: ldloc.s 53
    IL_0706: ldc.i4.1
    IL_0707: callvirt void System.Collections.Generic.List<bool>::set_Item(int,!0)  /*0x0A000310*/
    IL_070c: ldloc.s 45
    IL_070e: ldc.i4.1
    IL_070f: sub
    IL_0710: stloc.s 45
    IL_0712: ldloc.s 44
    IL_0714: ldloc.s 54
    IL_0716: ldloc.s 43
    IL_0718: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_071d: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0722: ldloc.s 53
    IL_0724: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0729: sub
    IL_072a: sub
    IL_072b: stloc.s 44
    IL_072d: ldloca.s 52
    IL_072f: call bool System.Collections.Generic.List.Enumerator<int>::MoveNext()  /*0x0A0002C9*/
    IL_0734: brtrue IL_0678
    IL_0739: leave.s IL_0749
    IL_073b: ldloca.s 52
    IL_073d: constrained. System.Collections.Generic.List.Enumerator<int>  /*0x1B00007C*/
    IL_0743: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0748: endfinally
    IL_0749: ldstr "Wave "
    IL_074e: ldloc.s 42
    IL_0750: ldc.i4.1
    IL_0751: add
    IL_0752: stloc.s 38
    IL_0754: ldloca.s 38
    IL_0756: call string System.Int32::ToString()  /*0x0A000031*/
    IL_075b: ldstr ": "
    IL_0760: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0765: stloc.s 47
    IL_0767: ldc.i4.0
    IL_0768: stloc.s 55
    IL_076a: br.s IL_07d7
    IL_076c: ldloc.s 43
    IL_076e: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0773: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0778: ldloc.s 55
    IL_077a: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_077f: stloc.s 56
    IL_0781: ldc.i4.5
    IL_0782: newarr System.String  /*0x0100001D*/
    IL_0787: dup
    IL_0788: ldc.i4.0
    IL_0789: ldloc.s 47
    IL_078b: stelem.ref
    IL_078c: dup
    IL_078d: ldc.i4.1
    IL_078e: ldloc.s 56
    IL_0790: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0795: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_079a: stelem.ref
    IL_079b: dup
    IL_079c: ldc.i4.2
    IL_079d: ldstr "(x"
    IL_07a2: stelem.ref
    IL_07a3: dup
    IL_07a4: ldc.i4.3
    IL_07a5: ldloc.s 43
    IL_07a7: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_07ac: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_07b1: ldloc.s 55
    IL_07b3: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_07b8: stloc.s 38
    IL_07ba: ldloca.s 38
    IL_07bc: call string System.Int32::ToString()  /*0x0A000031*/
    IL_07c1: stelem.ref
    IL_07c2: dup
    IL_07c3: ldc.i4.4
    IL_07c4: ldstr "), "
    IL_07c9: stelem.ref
    IL_07ca: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_07cf: stloc.s 47
    IL_07d1: ldloc.s 55
    IL_07d3: ldc.i4.1
    IL_07d4: add
    IL_07d5: stloc.s 55
    IL_07d7: ldloc.s 55
    IL_07d9: ldloc.s 43
    IL_07db: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_07e0: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_07e5: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_07ea: blt.s IL_076c
    IL_07ec: ldloc.s 42
    IL_07ee: ldc.i4.1
    IL_07ef: add
    IL_07f0: stloc.s 42
    IL_07f2: ldloc.s 42
    IL_07f4: ldloc.1
    IL_07f5: blt IL_054c
    IL_07fa: ldc.i4.0
    IL_07fb: stloc.s 57
    IL_07fd: br IL_0950
    IL_0802: ldloc.s 57
    IL_0804: ldc.i4.2
    IL_0805: rem
    IL_0806: brtrue IL_08cb
    IL_080b: ldloc.3
    IL_080c: ldloc.s 57
    IL_080e: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_0813: stloc.s 58
    IL_0815: ldc.i4.0
    IL_0816: stloc.s 59
    IL_0818: br IL_08b6
    IL_081d: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0822: stloc.s 60
    IL_0824: ldloc.s 58
    IL_0826: ldfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_082b: ldloc.s 60
    IL_082d: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::Add(!0)  /*0x0A000311*/
    IL_0832: ldloc.s 58
    IL_0834: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0839: ldloc.s 59
    IL_083b: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_0840: stloc.s 61
    IL_0842: ldc.i4.1
    IL_0843: ldc.i4.3
    IL_0844: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0849: stloc.s 62
    IL_084b: ldloc.s 57
    IL_084d: ldc.i4.1
    IL_084e: bgt.s IL_0853
    IL_0850: ldc.i4.1
    IL_0851: stloc.s 62
    IL_0853: ldloc.s 6
    IL_0855: ldloc.s 61
    IL_0857: callvirt !1 System.Collections.Generic.Dictionary<EternalTrialEnemy, System.Collections.Generic.List<EnemySpawnLine>>::get_Item(!0)  /*0x0A000312*/
    IL_085c: stloc.s 63
    IL_085e: ldc.i4.0
    IL_085f: stloc.s 64
    IL_0861: br.s IL_0884
    IL_0863: ldloc.s 64
    IL_0865: ldloc.s 63
    IL_0867: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_086c: bge.s IL_088a
    IL_086e: ldloc.s 60
    IL_0870: ldloc.s 63
    IL_0872: ldloc.s 64
    IL_0874: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0879: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_087e: ldloc.s 64
    IL_0880: ldc.i4.1
    IL_0881: add
    IL_0882: stloc.s 64
    IL_0884: ldloc.s 64
    IL_0886: ldloc.s 62
    IL_0888: blt.s IL_0863
    IL_088a: ldloc.s 58
    IL_088c: ldfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_0891: ldloc.s 58
    IL_0893: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_0898: ldloc.s 59
    IL_089a: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_089f: ldloc.s 60
    IL_08a1: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_08a6: call List<int> WaveGenUtility::DistributeEnemies(int,int)  /*0x06000730*/
    IL_08ab: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<int>>::Add(!0)  /*0x0A000314*/
    IL_08b0: ldloc.s 59
    IL_08b2: ldc.i4.1
    IL_08b3: add
    IL_08b4: stloc.s 59
    IL_08b6: ldloc.s 59
    IL_08b8: ldloc.s 58
    IL_08ba: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_08bf: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_08c4: blt IL_081d
    IL_08c9: br.s IL_094a
    IL_08cb: ldloc.s 7
    IL_08cd: ldc.i4.0
    IL_08ce: ldloc.s 7
    IL_08d0: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_08d5: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_08da: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_08df: stloc.s 65
    IL_08e1: ldloc.3
    IL_08e2: ldloc.s 57
    IL_08e4: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_08e9: stloc.s 66
    IL_08eb: ldc.i4.0
    IL_08ec: stloc.s 67
    IL_08ee: br.s IL_093a
    IL_08f0: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_08f5: stloc.s 68
    IL_08f7: ldloc.s 66
    IL_08f9: ldfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_08fe: ldloc.s 68
    IL_0900: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::Add(!0)  /*0x0A000311*/
    IL_0905: ldloc.s 68
    IL_0907: ldloc.s 65
    IL_0909: callvirt void System.Collections.Generic.List<EnemySpawnLine>::Add(!0)  /*0x0A000313*/
    IL_090e: ldloc.s 66
    IL_0910: ldfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_0915: ldloc.s 66
    IL_0917: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_091c: ldloc.s 67
    IL_091e: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0923: ldloc.s 68
    IL_0925: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_092a: call List<int> WaveGenUtility::DistributeEnemies(int,int)  /*0x06000730*/
    IL_092f: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<int>>::Add(!0)  /*0x0A000314*/
    IL_0934: ldloc.s 67
    IL_0936: ldc.i4.1
    IL_0937: add
    IL_0938: stloc.s 67
    IL_093a: ldloc.s 67
    IL_093c: ldloc.s 66
    IL_093e: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0943: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0948: blt.s IL_08f0
    IL_094a: ldloc.s 57
    IL_094c: ldc.i4.1
    IL_094d: add
    IL_094e: stloc.s 57
    IL_0950: ldloc.s 57
    IL_0952: ldloc.1
    IL_0953: blt IL_0802
    IL_0958: ldc.i4.0
    IL_0959: stloc.s 69
    IL_095b: br.s IL_0975
    IL_095d: ldloc.3
    IL_095e: ldloc.s 69
    IL_0960: callvirt !0 System.Collections.Generic.List<WaveDraft>::get_Item(int)  /*0x0A000308*/
    IL_0965: ldc.r4 7f
    IL_096a: stfld float WaveDraft::waveDuration  /*0x04000890*/
    IL_096f: ldloc.s 69
    IL_0971: ldc.i4.1
    IL_0972: add
    IL_0973: stloc.s 69
    IL_0975: ldloc.s 69
    IL_0977: ldloc.1
    IL_0978: blt.s IL_095d
    IL_097a: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_097f: stloc.s 8
    IL_0981: ldloc.3
    IL_0982: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveDraft>::GetEnumerator()  /*0x0A000315*/
    IL_0987: stloc.s 70
    IL_0989: br IL_0b49
    IL_098e: ldloca.s 70
    IL_0990: call !0 System.Collections.Generic.List.Enumerator<WaveDraft>::get_Current()  /*0x0A000316*/
    IL_0995: stloc.s 71
    IL_0997: newobj void Wave::.ctor()  /*0x06000699*/
    IL_099c: stloc.s 72
    IL_099e: ldloc.s 8
    IL_09a0: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_09a5: stloc.s 73
    IL_09a7: ldloc.s 8
    IL_09a9: ldloc.s 72
    IL_09ab: callvirt void System.Collections.Generic.List<Wave>::Add(!0)  /*0x0A000317*/
    IL_09b0: ldloc.s 72
    IL_09b2: ldarg.0
    IL_09b3: ldfld float[] EndlessModeWaveGen::difficultyMultiplayersAfterwards  /*0x04000865*/
    IL_09b8: ldloc.s 73
    IL_09ba: ldarg.0
    IL_09bb: ldfld float[] EndlessModeWaveGen::waveDifficulties  /*0x04000864*/
    IL_09c0: ldlen
    IL_09c1: conv.i4
    IL_09c2: sub
    IL_09c3: ldc.i4.1
    IL_09c4: add
    IL_09c5: ldc.i4.0
    IL_09c6: ldarg.0
    IL_09c7: ldfld float[] EndlessModeWaveGen::difficultyMultiplayersAfterwards  /*0x04000865*/
    IL_09cc: ldlen
    IL_09cd: conv.i4
    IL_09ce: ldc.i4.1
    IL_09cf: sub
    IL_09d0: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_09d5: ldelem.r4
    IL_09d6: stfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_09db: ldc.i4.0
    IL_09dc: stloc.s 74
    IL_09de: br IL_0af5
    IL_09e3: ldloc.s 71
    IL_09e5: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_09ea: ldloc.s 74
    IL_09ec: callvirt !0 System.Collections.Generic.List<EternalTrialEnemy>::get_Item(int)  /*0x0A0002FE*/
    IL_09f1: stloc.s 75
    IL_09f3: ldloc.s 71
    IL_09f5: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_09fa: ldloc.s 74
    IL_09fc: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a01: pop
    IL_0a02: ldloc.s 71
    IL_0a04: ldfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_0a09: ldloc.s 74
    IL_0a0b: callvirt !0 System.Collections.Generic.List<bool>::get_Item(int)  /*0x0A00025C*/
    IL_0a10: stloc.s 76
    IL_0a12: ldloc.s 71
    IL_0a14: ldfld float WaveDraft::waveDuration  /*0x04000890*/
    IL_0a19: stloc.s 77
    IL_0a1b: ldloc.s 71
    IL_0a1d: ldfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_0a22: ldloc.s 74
    IL_0a24: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0a29: stloc.s 78
    IL_0a2b: ldloc.s 71
    IL_0a2d: ldfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_0a32: ldloc.s 74
    IL_0a34: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::get_Item(int)  /*0x0A000318*/
    IL_0a39: stloc.s 79
    IL_0a3b: ldc.i4.0
    IL_0a3c: stloc.s 80
    IL_0a3e: br IL_0ae1
    IL_0a43: newobj void Spawn::.ctor()  /*0x060006A4*/
    IL_0a48: stloc.s 81
    IL_0a4a: ldloc.s 81
    IL_0a4c: ldloc.s 75
    IL_0a4e: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0a53: stfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0a58: ldloc.s 81
    IL_0a5a: ldloc.s 71
    IL_0a5c: ldfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_0a61: ldloc.s 74
    IL_0a63: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<int>>::get_Item(int)  /*0x0A000319*/
    IL_0a68: ldloc.s 80
    IL_0a6a: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0a6f: stfld int Spawn::count  /*0x040007E7*/
    IL_0a74: ldloc.s 81
    IL_0a76: ldloc.s 76
    IL_0a78: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_0a7d: ldloc.s 81
    IL_0a7f: ldc.r4 0f
    IL_0a84: stfld float Spawn::delay  /*0x040007E4*/
    IL_0a89: ldloc.s 81
    IL_0a8b: ldloc.s 77
    IL_0a8d: ldc.i4.1
    IL_0a8e: ldloc.s 81
    IL_0a90: ldfld int Spawn::count  /*0x040007E7*/
    IL_0a95: ldc.i4.1
    IL_0a96: sub
    IL_0a97: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0a9c: conv.r4
    IL_0a9d: div
    IL_0a9e: ldloc.s 78
    IL_0aa0: div
    IL_0aa1: stfld float Spawn::interval  /*0x040007E8*/
    IL_0aa6: ldloc.s 81
    IL_0aa8: ldloc.s 79
    IL_0aaa: ldloc.s 80
    IL_0aac: callvirt !0 System.Collections.Generic.List<EnemySpawnLine>::get_Item(int)  /*0x0A000305*/
    IL_0ab1: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0ab6: stfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0abb: ldloc.s 81
    IL_0abd: ldc.i4.0
    IL_0abe: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0ac3: ldloc.s 81
    IL_0ac5: ldfld int Spawn::count  /*0x040007E7*/
    IL_0aca: ldc.i4.0
    IL_0acb: ble.s IL_0adb
    IL_0acd: ldloc.s 72
    IL_0acf: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0ad4: ldloc.s 81
    IL_0ad6: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_0adb: ldloc.s 80
    IL_0add: ldc.i4.1
    IL_0ade: add
    IL_0adf: stloc.s 80
    IL_0ae1: ldloc.s 80
    IL_0ae3: ldloc.s 79
    IL_0ae5: callvirt int System.Collections.Generic.List<EnemySpawnLine>::get_Count()  /*0x0A000304*/
    IL_0aea: blt IL_0a43
    IL_0aef: ldloc.s 74
    IL_0af1: ldc.i4.1
    IL_0af2: add
    IL_0af3: stloc.s 74
    IL_0af5: ldloc.s 74
    IL_0af7: ldloc.s 71
    IL_0af9: ldfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_0afe: callvirt int System.Collections.Generic.List<EternalTrialEnemy>::get_Count()  /*0x0A0002FC*/
    IL_0b03: blt IL_09e3
    IL_0b08: ldloc.s 71
    IL_0b0a: ldfld int WaveDraft::goldToDropAtNight  /*0x0400088D*/
    IL_0b0f: stloc.s 82
    IL_0b11: br.s IL_0b44
    IL_0b13: ldloc.s 72
    IL_0b15: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0b1a: ldc.i4.0
    IL_0b1b: ldloc.s 72
    IL_0b1d: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0b22: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_0b27: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0b2c: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0b31: dup
    IL_0b32: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0b37: ldc.i4.1
    IL_0b38: add
    IL_0b39: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0b3e: ldloc.s 82
    IL_0b40: ldc.i4.1
    IL_0b41: sub
    IL_0b42: stloc.s 82
    IL_0b44: ldloc.s 82
    IL_0b46: ldc.i4.0
    IL_0b47: bgt.s IL_0b13
    IL_0b49: ldloca.s 70
    IL_0b4b: call bool System.Collections.Generic.List.Enumerator<WaveDraft>::MoveNext()  /*0x0A00031A*/
    IL_0b50: brtrue IL_098e
    IL_0b55: leave.s IL_0b65
    IL_0b57: ldloca.s 70
    IL_0b59: constrained. System.Collections.Generic.List.Enumerator<WaveDraft>  /*0x1B000091*/
    IL_0b5f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0b64: endfinally
    IL_0b65: ldloc.s 8
    IL_0b67: ret
    .try IL_01c8-IL_0261 finally handler IL_0261-IL_026f
    .try IL_0304-IL_0365 finally handler IL_0365-IL_0373
    .try IL_0673-IL_073b finally handler IL_073b-IL_0749
    .try IL_0989-IL_0b57 finally handler IL_0b57-IL_0b65

  .method EndlessModeWaveGen::.ctor()  // token 0x06000707 rva 0x1fe40 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4 200
    IL_0006: stfld int EndlessModeWaveGen::maxAmountOfUnitsPerWave  /*0x04000862*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.s 20
    IL_000e: stfld int EndlessModeWaveGen::startingGold  /*0x04000863*/
    IL_0013: ldarg.0
    IL_0014: ldc.r4 0.4f
    IL_0019: stfld float EndlessModeWaveGen::maxFlavourUnits  /*0x04000866*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0.5f
    IL_0024: stfld float EndlessModeWaveGen::maxFlyingUnits  /*0x04000867*/
    IL_0029: ldarg.0
    IL_002a: call void EternalWaveGenerator::.ctor()  /*0x06000705*/
    IL_002f: ret

// ===== EndlessModeWaveGen/<>c__DisplayClass7_0  (token 0x0200014B) =====
  .method EndlessModeWaveGen.<>c__DisplayClass7_0::.ctor()  // token 0x06000708 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method EndlessModeWaveGen.<>c__DisplayClass7_0::<GenerateWaves>b__0(int,int)  // token 0x06000709 rva 0x1fe74 attrs Assembly, HideBySig
    // code size 43 (0x2b), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_0006: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_000b: ldarg.2
    IL_000c: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0011: stloc.0
    IL_0012: ldloca.s 0
    IL_0014: ldarg.0
    IL_0015: ldfld WaveDraft EndlessModeWaveGen.<>c__DisplayClass7_0::wd  /*0x04000868*/
    IL_001a: ldfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_001f: ldarg.1
    IL_0020: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0025: call int System.Int32::CompareTo(int)  /*0x0A00031B*/
    IL_002a: ret

