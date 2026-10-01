// ===== EternalWaveGenerator  (token 0x02000149) =====
  .method EternalWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  // token 0x06000703 rva 0x1f252 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_0005: ldarg.s 4
    IL_0007: ldc.i4.s 10
    IL_0009: stind.i4
    IL_000a: ret

  .method EternalWaveGenerator::ReturnDebugInfoAboutWave(int)  // token 0x06000704 rva 0x1f25e attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr ""
    IL_0005: ret

  .method EternalWaveGenerator::.ctor()  // token 0x06000705 rva 0x26e3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0006: ret

