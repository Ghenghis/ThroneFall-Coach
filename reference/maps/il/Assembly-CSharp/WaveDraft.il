// ===== WaveDraft  (token 0x0200014F) =====
  .method WaveDraft::.ctor()  // token 0x06000715 rva 0x21508 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0006: stfld List<EternalTrialEnemy> WaveDraft::enemiesToEncounter  /*0x04000888*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0011: stfld List<float> WaveDraft::percentageOfDifficultyAllocatedToEnemy  /*0x04000889*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_001c: stfld List<float> WaveDraft::spawnInSpeedForEnemy  /*0x0400088A*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0027: stfld List<int> WaveDraft::enemyCountForEnemy  /*0x0400088E*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<bool>::.ctor()  /*0x0A00025F*/
    IL_0032: stfld List<bool> WaveDraft::eliteEnemies  /*0x0400088F*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<System.Collections.Generic.List<EnemySpawnLine>>::.ctor()  /*0x0A000333*/
    IL_003d: stfld List<List<EnemySpawnLine>> WaveDraft::enemySpawnLines  /*0x04000891*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<System.Collections.Generic.List<int>>::.ctor()  /*0x0A000334*/
    IL_0048: stfld List<List<int>> WaveDraft::enemiesPerSpawnLine  /*0x04000892*/
    IL_004d: ldarg.0
    IL_004e: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0053: ret

