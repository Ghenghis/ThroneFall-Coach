// ===== PaulsWaveGenerator  (token 0x0200014C) =====
  .method PaulsWaveGenerator::OnValidate()  // token 0x0600070A rva 0x1feab attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PaulsWaveGenerator::RecalculateWaveParameters()  /*0x0600070B*/
    IL_0006: ret

  .method PaulsWaveGenerator::RecalculateWaveParameters()  // token 0x0600070B rva 0x1feb3 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PaulsWaveGenerator::RecalculateStrengthPerWave()  /*0x0600070C*/
    IL_0006: ldarg.0
    IL_0007: call void PaulsWaveGenerator::RecalculateGoldPerWave()  /*0x0600070D*/
    IL_000c: ldarg.0
    IL_000d: call void PaulsWaveGenerator::RecalculateEnemyTypeLimitPerWave()  /*0x0600070E*/
    IL_0012: ret

  .method PaulsWaveGenerator::RecalculateStrengthPerWave()  // token 0x0600070C rva 0x1fec8 attrs Private, HideBySig
    // code size 92 (0x5c), max stack 8, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0007: newarr System.Single  /*0x01000052*/
    IL_000c: stfld float[] PaulsWaveGenerator::strengthPerWave  /*0x0400087A*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_0052
    IL_0015: ldarg.0
    IL_0016: ldfld float[] PaulsWaveGenerator::strengthPerWave  /*0x0400087A*/
    IL_001b: ldloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld float PaulsWaveGenerator::initialWaveStrength  /*0x0400086D*/
    IL_0022: ldarg.0
    IL_0023: ldfld float PaulsWaveGenerator::targetWaveStrength  /*0x0400086E*/
    IL_0028: ldarg.0
    IL_0029: ldfld AnimationCurve PaulsWaveGenerator::strengthProgression  /*0x04000870*/
    IL_002e: ldc.r4 0f
    IL_0033: ldarg.0
    IL_0034: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0039: ldc.i4.1
    IL_003a: sub
    IL_003b: conv.r4
    IL_003c: ldloc.0
    IL_003d: conv.r4
    IL_003e: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0043: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0048: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_004d: stelem.r4
    IL_004e: ldloc.0
    IL_004f: ldc.i4.1
    IL_0050: add
    IL_0051: stloc.0
    IL_0052: ldloc.0
    IL_0053: ldarg.0
    IL_0054: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0059: blt.s IL_0015
    IL_005b: ret

  .method PaulsWaveGenerator::RecalculateGoldPerWave()  // token 0x0600070D rva 0x1ff30 attrs Private, HideBySig
    // code size 99 (0x63), max stack 8, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0007: newarr System.Int32  /*0x01000026*/
    IL_000c: stfld int[] PaulsWaveGenerator::goldPerWave  /*0x0400087B*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_0059
    IL_0015: ldarg.0
    IL_0016: ldfld int[] PaulsWaveGenerator::goldPerWave  /*0x0400087B*/
    IL_001b: ldloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld int PaulsWaveGenerator::minGoldPerWave  /*0x04000871*/
    IL_0022: conv.r4
    IL_0023: ldarg.0
    IL_0024: ldfld int PaulsWaveGenerator::maxGoldPerWave  /*0x04000872*/
    IL_0029: conv.r4
    IL_002a: ldarg.0
    IL_002b: ldfld AnimationCurve PaulsWaveGenerator::goldProgression  /*0x04000873*/
    IL_0030: ldc.r4 0f
    IL_0035: ldarg.0
    IL_0036: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_003b: ldc.i4.1
    IL_003c: sub
    IL_003d: conv.r4
    IL_003e: ldloc.0
    IL_003f: conv.r4
    IL_0040: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0045: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_004a: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_004f: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0054: stelem.i4
    IL_0055: ldloc.0
    IL_0056: ldc.i4.1
    IL_0057: add
    IL_0058: stloc.0
    IL_0059: ldloc.0
    IL_005a: ldarg.0
    IL_005b: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0060: blt.s IL_0015
    IL_0062: ret

  .method PaulsWaveGenerator::RecalculateEnemyTypeLimitPerWave()  // token 0x0600070E rva 0x1ffa0 attrs Private, HideBySig
    // code size 99 (0x63), max stack 8, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0007: newarr System.Int32  /*0x01000026*/
    IL_000c: stfld int[] PaulsWaveGenerator::enemyTypeLimitPerWave  /*0x0400087C*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_0059
    IL_0015: ldarg.0
    IL_0016: ldfld int[] PaulsWaveGenerator::enemyTypeLimitPerWave  /*0x0400087C*/
    IL_001b: ldloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld int PaulsWaveGenerator::minEnemyTypeLimitPerWave  /*0x04000874*/
    IL_0022: conv.r4
    IL_0023: ldarg.0
    IL_0024: ldfld int PaulsWaveGenerator::maxEnemyTypeLimitPerWave  /*0x04000875*/
    IL_0029: conv.r4
    IL_002a: ldarg.0
    IL_002b: ldfld AnimationCurve PaulsWaveGenerator::enemyTypeLimitProgression  /*0x04000876*/
    IL_0030: ldc.r4 0f
    IL_0035: ldarg.0
    IL_0036: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_003b: ldc.i4.1
    IL_003c: sub
    IL_003d: conv.r4
    IL_003e: ldloc.0
    IL_003f: conv.r4
    IL_0040: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0045: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_004a: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_004f: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0054: stelem.i4
    IL_0055: ldloc.0
    IL_0056: ldc.i4.1
    IL_0057: add
    IL_0058: stloc.0
    IL_0059: ldloc.0
    IL_005a: ldarg.0
    IL_005b: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0060: blt.s IL_0015
    IL_0062: ret

  .method PaulsWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  // token 0x0600070F rva 0x20010 attrs Public, Virtual, HideBySig
    // code size 940 (0x3ac), max stack 4, init locals
    .locals ([0] Random, [1] List<Wave>, [2] List<EternalTrialEnemy>, [3] Dictionary<EternalTrialEnemy, int>, [4] List<PaulsWaveGenerator.EnemySpawnGroup>, [5] List<EternalTrialEnemy>, [6] float, [7] float, [8] int, [9] int, [10] EnemySpawnLine[], [11] int, [12] EnemySpawnLine, [13] int, [14] int, [15] Wave, [16] int, [17] int, [18] float, [19] bool, [20] List.Enumerator<EternalTrialEnemy>, [21] EternalTrialEnemy, [22] EternalTrialEnemy, [23] Dictionary.Enumerator<EternalTrialEnemy, int>, [24] KeyValuePair<EternalTrialEnemy, int>, [25] List.Enumerator<PaulsWaveGenerator.EnemySpawnGroup>, [26] PaulsWaveGenerator.EnemySpawnGroup, [27] Spawn)
    IL_0000: ldarg.s 5
    IL_0002: newobj void System.Random::.ctor(int)  /*0x0A00017C*/
    IL_0007: stloc.0
    IL_0008: ldarg.s 4
    IL_000a: ldarg.0
    IL_000b: ldfld int PaulsWaveGenerator::startGold  /*0x04000869*/
    IL_0010: stind.i4
    IL_0011: ldarg.0
    IL_0012: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_0017: stfld List<Transform> PaulsWaveGenerator::flyingSpawns  /*0x04000878*/
    IL_001c: ldarg.0
    IL_001d: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_0022: stfld List<Transform> PaulsWaveGenerator::groundedSpawns  /*0x04000879*/
    IL_0027: ldarg.1
    IL_0028: stloc.s 10
    IL_002a: ldc.i4.0
    IL_002b: stloc.s 11
    IL_002d: br.s IL_0072
    IL_002f: ldloc.s 10
    IL_0031: ldloc.s 11
    IL_0033: ldelem.ref
    IL_0034: stloc.s 12
    IL_0036: ldloc.s 12
    IL_0038: ldfld bool EnemySpawnLine::canSpawnFlying  /*0x0400082D*/
    IL_003d: brfalse.s IL_0051
    IL_003f: ldarg.0
    IL_0040: ldfld List<Transform> PaulsWaveGenerator::flyingSpawns  /*0x04000878*/
    IL_0045: ldloc.s 12
    IL_0047: callvirt Transform EnemySpawnLine::get_SpawnLine()  /*0x060006D2*/
    IL_004c: callvirt void System.Collections.Generic.List<UnityEngine.Transform>::Add(!0)  /*0x0A000235*/
    IL_0051: ldloc.s 12
    IL_0053: ldfld bool EnemySpawnLine::canSpawnSmallGround  /*0x0400082E*/
    IL_0058: brfalse.s IL_006c
    IL_005a: ldarg.0
    IL_005b: ldfld List<Transform> PaulsWaveGenerator::groundedSpawns  /*0x04000879*/
    IL_0060: ldloc.s 12
    IL_0062: callvirt Transform EnemySpawnLine::get_SpawnLine()  /*0x060006D2*/
    IL_0067: callvirt void System.Collections.Generic.List<UnityEngine.Transform>::Add(!0)  /*0x0A000235*/
    IL_006c: ldloc.s 11
    IL_006e: ldc.i4.1
    IL_006f: add
    IL_0070: stloc.s 11
    IL_0072: ldloc.s 11
    IL_0074: ldloc.s 10
    IL_0076: ldlen
    IL_0077: conv.i4
    IL_0078: blt.s IL_002f
    IL_007a: ldarg.0
    IL_007b: call void PaulsWaveGenerator::RecalculateWaveParameters()  /*0x0600070B*/
    IL_0080: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_0085: stloc.1
    IL_0086: ldarg.0
    IL_0087: ldfld EternalTrialEnemySet PaulsWaveGenerator::enemySet  /*0x04000877*/
    IL_008c: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_0091: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00031C*/
    IL_0096: stloc.2
    IL_0097: newobj void System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::.ctor()  /*0x0A00031D*/
    IL_009c: stloc.3
    IL_009d: newobj void System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>::.ctor()  /*0x0A00031E*/
    IL_00a2: stloc.s 4
    IL_00a4: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_00a9: stloc.s 5
    IL_00ab: ldc.r4 1f
    IL_00b0: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_00b5: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_00ba: conv.r4
    IL_00bb: ldarg.0
    IL_00bc: ldfld float PaulsWaveGenerator::waveStrengthPerStageMultiplier  /*0x0400086F*/
    IL_00c1: mul
    IL_00c2: add
    IL_00c3: stloc.s 6
    IL_00c5: ldc.r4 0f
    IL_00ca: stloc.s 7
    IL_00cc: ldc.i4.0
    IL_00cd: stloc.s 8
    IL_00cf: ldc.i4.0
    IL_00d0: stloc.s 9
    IL_00d2: ldc.i4.0
    IL_00d3: stloc.s 13
    IL_00d5: br IL_039d
    IL_00da: ldloc.s 5
    IL_00dc: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Clear()  /*0x0A00031F*/
    IL_00e1: ldloc.3
    IL_00e2: callvirt void System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::Clear()  /*0x0A000320*/
    IL_00e7: ldloc.s 4
    IL_00e9: callvirt void System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>::Clear()  /*0x0A000321*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld float[] PaulsWaveGenerator::strengthPerWave  /*0x0400087A*/
    IL_00f4: ldloc.s 13
    IL_00f6: ldelem.r4
    IL_00f7: ldloc.s 6
    IL_00f9: mul
    IL_00fa: stloc.s 7
    IL_00fc: ldarg.0
    IL_00fd: ldfld int[] PaulsWaveGenerator::goldPerWave  /*0x0400087B*/
    IL_0102: ldloc.s 13
    IL_0104: ldelem.i4
    IL_0105: stloc.s 8
    IL_0107: ldarg.0
    IL_0108: ldfld int[] PaulsWaveGenerator::enemyTypeLimitPerWave  /*0x0400087C*/
    IL_010d: ldloc.s 13
    IL_010f: ldelem.i4
    IL_0110: stloc.s 9
    IL_0112: ldc.i4.0
    IL_0113: stloc.s 14
    IL_0115: br IL_01f9
    IL_011a: ldc.i4.0
    IL_011b: stloc.s 19
    IL_011d: ldloc.s 14
    IL_011f: ldloc.s 9
    IL_0121: bge.s IL_0198
    IL_0123: ldloc.2
    IL_0124: ldloc.0
    IL_0125: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_012a: ldloc.2
    IL_012b: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0130: stloc.s 20
    IL_0132: br.s IL_017f
    IL_0134: ldloca.s 20
    IL_0136: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_013b: stloc.s 21
    IL_013d: ldloc.s 7
    IL_013f: ldloc.s 21
    IL_0141: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_0146: blt.un.s IL_017f
    IL_0148: ldloc.s 7
    IL_014a: ldloc.s 21
    IL_014c: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_0151: sub
    IL_0152: stloc.s 7
    IL_0154: ldarg.0
    IL_0155: ldloc.s 21
    IL_0157: ldloca.s 3
    IL_0159: ldloca.s 4
    IL_015b: call void PaulsWaveGenerator::TryAddEnemyToGroup(EternalTrialEnemy,ref System.Collections.Generic.Dictionary<EternalTrialEnemy, int>,ref System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>)  /*0x06000710*/
    IL_0160: ldc.i4.1
    IL_0161: stloc.s 19
    IL_0163: ldloc.s 5
    IL_0165: ldloc.s 21
    IL_0167: callvirt bool System.Collections.Generic.List<EternalTrialEnemy>::Contains(!0)  /*0x0A0002FF*/
    IL_016c: brtrue.s IL_0188
    IL_016e: ldloc.s 14
    IL_0170: ldc.i4.1
    IL_0171: add
    IL_0172: stloc.s 14
    IL_0174: ldloc.s 5
    IL_0176: ldloc.s 21
    IL_0178: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_017d: leave.s IL_01f5
    IL_017f: ldloca.s 20
    IL_0181: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0186: brtrue.s IL_0134
    IL_0188: leave.s IL_01f5
    IL_018a: ldloca.s 20
    IL_018c: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_0192: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0197: endfinally
    IL_0198: ldloc.s 5
    IL_019a: ldloc.0
    IL_019b: call void RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)<EternalTrialEnemy>  /*0x2B000067*/
    IL_01a0: ldloc.s 5
    IL_01a2: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_01a7: stloc.s 20
    IL_01a9: br.s IL_01dc
    IL_01ab: ldloca.s 20
    IL_01ad: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_01b2: stloc.s 22
    IL_01b4: ldloc.s 7
    IL_01b6: ldloc.s 22
    IL_01b8: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_01bd: blt.un.s IL_01dc
    IL_01bf: ldloc.s 7
    IL_01c1: ldloc.s 22
    IL_01c3: ldfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_01c8: sub
    IL_01c9: stloc.s 7
    IL_01cb: ldarg.0
    IL_01cc: ldloc.s 22
    IL_01ce: ldloca.s 3
    IL_01d0: ldloca.s 4
    IL_01d2: call void PaulsWaveGenerator::TryAddEnemyToGroup(EternalTrialEnemy,ref System.Collections.Generic.Dictionary<EternalTrialEnemy, int>,ref System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>)  /*0x06000710*/
    IL_01d7: ldc.i4.1
    IL_01d8: stloc.s 19
    IL_01da: leave.s IL_01f5
    IL_01dc: ldloca.s 20
    IL_01de: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_01e3: brtrue.s IL_01ab
    IL_01e5: leave.s IL_01f5
    IL_01e7: ldloca.s 20
    IL_01e9: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_01ef: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01f4: endfinally
    IL_01f5: ldloc.s 19
    IL_01f7: brfalse.s IL_0205
    IL_01f9: ldloc.s 7
    IL_01fb: ldc.r4 0f
    IL_0200: bgt IL_011a
    IL_0205: ldloc.3
    IL_0206: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::GetEnumerator()  /*0x0A000322*/
    IL_020b: stloc.s 23
    IL_020d: br.s IL_0232
    IL_020f: ldloca.s 23
    IL_0211: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<EternalTrialEnemy, int>::get_Current()  /*0x0A000323*/
    IL_0216: stloc.s 24
    IL_0218: ldloc.s 4
    IL_021a: ldloca.s 24
    IL_021c: call !0 System.Collections.Generic.KeyValuePair<EternalTrialEnemy, int>::get_Key()  /*0x0A000324*/
    IL_0221: ldloca.s 24
    IL_0223: call !1 System.Collections.Generic.KeyValuePair<EternalTrialEnemy, int>::get_Value()  /*0x0A000325*/
    IL_0228: newobj void PaulsWaveGenerator.EnemySpawnGroup::.ctor(EternalTrialEnemy,int)  /*0x06000712*/
    IL_022d: callvirt void System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>::Add(!0)  /*0x0A000326*/
    IL_0232: ldloca.s 23
    IL_0234: call bool System.Collections.Generic.Dictionary.Enumerator<EternalTrialEnemy, int>::MoveNext()  /*0x0A000327*/
    IL_0239: brtrue.s IL_020f
    IL_023b: leave.s IL_024b
    IL_023d: ldloca.s 23
    IL_023f: constrained. System.Collections.Generic.Dictionary.Enumerator<EternalTrialEnemy, int>  /*0x1B000094*/
    IL_0245: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_024a: endfinally
    IL_024b: newobj void Wave::.ctor()  /*0x06000699*/
    IL_0250: stloc.s 15
    IL_0252: ldc.i4.0
    IL_0253: stloc.s 17
    IL_0255: ldc.r4 0f
    IL_025a: stloc.s 18
    IL_025c: ldloc.s 4
    IL_025e: callvirt List.Enumerator<!0> System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>::GetEnumerator()  /*0x0A000328*/
    IL_0263: stloc.s 25
    IL_0265: br IL_0353
    IL_026a: ldloca.s 25
    IL_026c: call !0 System.Collections.Generic.List.Enumerator<PaulsWaveGenerator.EnemySpawnGroup>::get_Current()  /*0x0A000329*/
    IL_0271: stloc.s 26
    IL_0273: ldloc.s 17
    IL_0275: ldc.i4.1
    IL_0276: add
    IL_0277: stloc.s 17
    IL_0279: ldloc.s 17
    IL_027b: ldarg.0
    IL_027c: ldfld int PaulsWaveGenerator::maxNumberOfGroupsToSpawnSimultaneously  /*0x0400086B*/
    IL_0281: ble.s IL_0291
    IL_0283: ldc.i4.0
    IL_0284: stloc.s 17
    IL_0286: ldloc.s 18
    IL_0288: ldarg.0
    IL_0289: ldfld float PaulsWaveGenerator::delayBetweenGroups  /*0x0400086C*/
    IL_028e: add
    IL_028f: stloc.s 18
    IL_0291: newobj void Spawn::.ctor()  /*0x060006A4*/
    IL_0296: stloc.s 27
    IL_0298: ldloc.s 8
    IL_029a: ldc.i4.0
    IL_029b: ble.s IL_02b9
    IL_029d: ldc.i4.1
    IL_029e: ldloc.s 8
    IL_02a0: ldc.i4.1
    IL_02a1: add
    IL_02a2: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_02a7: stloc.s 16
    IL_02a9: ldloc.s 27
    IL_02ab: ldloc.s 16
    IL_02ad: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_02b2: ldloc.s 8
    IL_02b4: ldloc.s 16
    IL_02b6: sub
    IL_02b7: stloc.s 8
    IL_02b9: ldloc.s 27
    IL_02bb: ldloc.s 26
    IL_02bd: ldfld int PaulsWaveGenerator.EnemySpawnGroup::count  /*0x0400087E*/
    IL_02c2: stfld int Spawn::count  /*0x040007E7*/
    IL_02c7: ldloc.s 27
    IL_02c9: ldc.r4 0.15f
    IL_02ce: stfld float Spawn::interval  /*0x040007E8*/
    IL_02d3: ldloc.s 27
    IL_02d5: ldloc.s 18
    IL_02d7: stfld float Spawn::delay  /*0x040007E4*/
    IL_02dc: ldloc.s 27
    IL_02de: ldloc.s 26
    IL_02e0: ldfld EternalTrialEnemy PaulsWaveGenerator.EnemySpawnGroup::enemy  /*0x0400087D*/
    IL_02e5: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_02ea: stfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_02ef: ldloc.s 26
    IL_02f1: ldfld EternalTrialEnemy PaulsWaveGenerator.EnemySpawnGroup::enemy  /*0x0400087D*/
    IL_02f6: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_02fb: brfalse.s IL_0322
    IL_02fd: ldloc.s 27
    IL_02ff: ldarg.0
    IL_0300: ldfld List<Transform> PaulsWaveGenerator::flyingSpawns  /*0x04000878*/
    IL_0305: ldc.i4.0
    IL_0306: ldarg.0
    IL_0307: ldfld List<Transform> PaulsWaveGenerator::flyingSpawns  /*0x04000878*/
    IL_030c: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0311: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0316: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_031b: stfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0320: br.s IL_0345
    IL_0322: ldloc.s 27
    IL_0324: ldarg.0
    IL_0325: ldfld List<Transform> PaulsWaveGenerator::groundedSpawns  /*0x04000879*/
    IL_032a: ldc.i4.0
    IL_032b: ldarg.0
    IL_032c: ldfld List<Transform> PaulsWaveGenerator::groundedSpawns  /*0x04000879*/
    IL_0331: callvirt int System.Collections.Generic.List<UnityEngine.Transform>::get_Count()  /*0x0A000236*/
    IL_0336: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_033b: callvirt !0 System.Collections.Generic.List<UnityEngine.Transform>::get_Item(int)  /*0x0A000237*/
    IL_0340: stfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0345: ldloc.s 15
    IL_0347: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_034c: ldloc.s 27
    IL_034e: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_0353: ldloca.s 25
    IL_0355: call bool System.Collections.Generic.List.Enumerator<PaulsWaveGenerator.EnemySpawnGroup>::MoveNext()  /*0x0A00032A*/
    IL_035a: brtrue IL_026a
    IL_035f: leave.s IL_036f
    IL_0361: ldloca.s 25
    IL_0363: constrained. System.Collections.Generic.List.Enumerator<PaulsWaveGenerator.EnemySpawnGroup>  /*0x1B000096*/
    IL_0369: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_036e: endfinally
    IL_036f: ldloc.s 8
    IL_0371: ldc.i4.0
    IL_0372: ble.s IL_038f
    IL_0374: ldloc.s 15
    IL_0376: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_037b: ldc.i4.0
    IL_037c: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0381: dup
    IL_0382: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0387: ldloc.s 8
    IL_0389: add
    IL_038a: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_038f: ldloc.1
    IL_0390: ldloc.s 15
    IL_0392: callvirt void System.Collections.Generic.List<Wave>::Add(!0)  /*0x0A000317*/
    IL_0397: ldloc.s 13
    IL_0399: ldc.i4.1
    IL_039a: add
    IL_039b: stloc.s 13
    IL_039d: ldloc.s 13
    IL_039f: ldarg.0
    IL_03a0: ldfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_03a5: blt IL_00da
    IL_03aa: ldloc.1
    IL_03ab: ret
    .try IL_0132-IL_018a finally handler IL_018a-IL_0198
    .try IL_01a9-IL_01e7 finally handler IL_01e7-IL_01f5
    .try IL_020d-IL_023d finally handler IL_023d-IL_024b
    .try IL_0265-IL_0361 finally handler IL_0361-IL_036f

  .method PaulsWaveGenerator::TryAddEnemyToGroup(EternalTrialEnemy,ref System.Collections.Generic.Dictionary<EternalTrialEnemy, int>,ref System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>)  // token 0x06000710 rva 0x203fc attrs Private, HideBySig
    // code size 90 (0x5a), max stack 4, init locals
    .locals ([0] EternalTrialEnemy, [1] int)
    IL_0000: ldarg.2
    IL_0001: ldind.ref
    IL_0002: ldarg.1
    IL_0003: callvirt bool System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::ContainsKey(!0)  /*0x0A00032B*/
    IL_0008: brfalse.s IL_0050
    IL_000a: ldarg.2
    IL_000b: ldind.ref
    IL_000c: ldarg.1
    IL_000d: stloc.0
    IL_000e: dup
    IL_000f: ldloc.0
    IL_0010: callvirt !1 System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::get_Item(!0)  /*0x0A00032C*/
    IL_0015: stloc.1
    IL_0016: ldloc.0
    IL_0017: ldloc.1
    IL_0018: ldc.i4.1
    IL_0019: add
    IL_001a: callvirt void System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::set_Item(!0,!1)  /*0x0A00032D*/
    IL_001f: ldarg.2
    IL_0020: ldind.ref
    IL_0021: ldarg.1
    IL_0022: callvirt !1 System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::get_Item(!0)  /*0x0A00032C*/
    IL_0027: ldc.i4.1
    IL_0028: add
    IL_0029: ldarg.1
    IL_002a: callvirt int EternalTrialEnemy::get_desiredGroupSize()  /*0x060006E4*/
    IL_002f: ble.s IL_0059
    IL_0031: ldarg.3
    IL_0032: ldind.ref
    IL_0033: ldarg.1
    IL_0034: ldarg.2
    IL_0035: ldind.ref
    IL_0036: ldarg.1
    IL_0037: callvirt !1 System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::get_Item(!0)  /*0x0A00032C*/
    IL_003c: newobj void PaulsWaveGenerator.EnemySpawnGroup::.ctor(EternalTrialEnemy,int)  /*0x06000712*/
    IL_0041: callvirt void System.Collections.Generic.List<PaulsWaveGenerator.EnemySpawnGroup>::Add(!0)  /*0x0A000326*/
    IL_0046: ldarg.2
    IL_0047: ldind.ref
    IL_0048: ldarg.1
    IL_0049: callvirt bool System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::Remove(!0)  /*0x0A00032E*/
    IL_004e: pop
    IL_004f: ret
    IL_0050: ldarg.2
    IL_0051: ldind.ref
    IL_0052: ldarg.1
    IL_0053: ldc.i4.1
    IL_0054: callvirt void System.Collections.Generic.Dictionary<EternalTrialEnemy, int>::Add(!0,!1)  /*0x0A00032F*/
    IL_0059: ret

  .method PaulsWaveGenerator::.ctor()  // token 0x06000711 rva 0x20464 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 254 (0xfe), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld int PaulsWaveGenerator::startGold  /*0x04000869*/
    IL_0008: ldarg.0
    IL_0009: ldc.i4.s 13
    IL_000b: stfld int PaulsWaveGenerator::wavecount  /*0x0400086A*/
    IL_0010: ldarg.0
    IL_0011: ldc.i4.2
    IL_0012: stfld int PaulsWaveGenerator::maxNumberOfGroupsToSpawnSimultaneously  /*0x0400086B*/
    IL_0017: ldarg.0
    IL_0018: ldc.r4 5f
    IL_001d: stfld float PaulsWaveGenerator::delayBetweenGroups  /*0x0400086C*/
    IL_0022: ldarg.0
    IL_0023: ldc.r4 6f
    IL_0028: stfld float PaulsWaveGenerator::initialWaveStrength  /*0x0400086D*/
    IL_002d: ldarg.0
    IL_002e: ldc.r4 300f
    IL_0033: stfld float PaulsWaveGenerator::targetWaveStrength  /*0x0400086E*/
    IL_0038: ldarg.0
    IL_0039: ldc.r4 0.15f
    IL_003e: stfld float PaulsWaveGenerator::waveStrengthPerStageMultiplier  /*0x0400086F*/
    IL_0043: ldarg.0
    IL_0044: ldc.r4 0f
    IL_0049: ldc.r4 0f
    IL_004e: ldc.r4 1f
    IL_0053: ldc.r4 1f
    IL_0058: call AnimationCurve UnityEngine.AnimationCurve::Linear(float,float,float,float)  /*0x0A000330*/
    IL_005d: stfld AnimationCurve PaulsWaveGenerator::strengthProgression  /*0x04000870*/
    IL_0062: ldarg.0
    IL_0063: ldc.i4.3
    IL_0064: stfld int PaulsWaveGenerator::minGoldPerWave  /*0x04000871*/
    IL_0069: ldarg.0
    IL_006a: ldc.i4.s 20
    IL_006c: stfld int PaulsWaveGenerator::maxGoldPerWave  /*0x04000872*/
    IL_0071: ldarg.0
    IL_0072: ldc.r4 0f
    IL_0077: ldc.r4 0f
    IL_007c: ldc.r4 1f
    IL_0081: ldc.r4 1f
    IL_0086: call AnimationCurve UnityEngine.AnimationCurve::Linear(float,float,float,float)  /*0x0A000330*/
    IL_008b: stfld AnimationCurve PaulsWaveGenerator::goldProgression  /*0x04000873*/
    IL_0090: ldarg.0
    IL_0091: ldc.i4.2
    IL_0092: stfld int PaulsWaveGenerator::minEnemyTypeLimitPerWave  /*0x04000874*/
    IL_0097: ldarg.0
    IL_0098: ldc.i4.5
    IL_0099: stfld int PaulsWaveGenerator::maxEnemyTypeLimitPerWave  /*0x04000875*/
    IL_009e: ldarg.0
    IL_009f: ldc.r4 0f
    IL_00a4: ldc.r4 0f
    IL_00a9: ldc.r4 1f
    IL_00ae: ldc.r4 1f
    IL_00b3: call AnimationCurve UnityEngine.AnimationCurve::Linear(float,float,float,float)  /*0x0A000330*/
    IL_00b8: stfld AnimationCurve PaulsWaveGenerator::enemyTypeLimitProgression  /*0x04000876*/
    IL_00bd: ldarg.0
    IL_00be: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_00c3: stfld List<Transform> PaulsWaveGenerator::flyingSpawns  /*0x04000878*/
    IL_00c8: ldarg.0
    IL_00c9: newobj void System.Collections.Generic.List<UnityEngine.Transform>::.ctor()  /*0x0A000238*/
    IL_00ce: stfld List<Transform> PaulsWaveGenerator::groundedSpawns  /*0x04000879*/
    IL_00d3: ldarg.0
    IL_00d4: ldc.i4.0
    IL_00d5: newarr System.Single  /*0x01000052*/
    IL_00da: stfld float[] PaulsWaveGenerator::strengthPerWave  /*0x0400087A*/
    IL_00df: ldarg.0
    IL_00e0: ldc.i4.0
    IL_00e1: newarr System.Int32  /*0x01000026*/
    IL_00e6: stfld int[] PaulsWaveGenerator::goldPerWave  /*0x0400087B*/
    IL_00eb: ldarg.0
    IL_00ec: ldc.i4.0
    IL_00ed: newarr System.Int32  /*0x01000026*/
    IL_00f2: stfld int[] PaulsWaveGenerator::enemyTypeLimitPerWave  /*0x0400087C*/
    IL_00f7: ldarg.0
    IL_00f8: call void EternalWaveGenerator::.ctor()  /*0x06000705*/
    IL_00fd: ret

// ===== PaulsWaveGenerator/EnemySpawnGroup  (token 0x0200014D) =====
  .method PaulsWaveGenerator.EnemySpawnGroup::.ctor(EternalTrialEnemy,int)  // token 0x06000712 rva 0x2056e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld EternalTrialEnemy PaulsWaveGenerator.EnemySpawnGroup::enemy  /*0x0400087D*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld int PaulsWaveGenerator.EnemySpawnGroup::count  /*0x0400087E*/
    IL_0014: ret

