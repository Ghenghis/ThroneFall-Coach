// ===== EnemySpawnLine  (token 0x02000140) =====
  .method EnemySpawnLine::get_DifficultyBudgetMultiplyer()  // token 0x060006D1 rva 0x1e474 attrs Public, HideBySig, SpecialName
    // code size 35 (0x23), max stack 2, init locals
    .locals ([0] EnemySpawnLine.ESpawnDifficulty)
    IL_0000: ldarg.0
    IL_0001: ldfld EnemySpawnLine.ESpawnDifficulty EnemySpawnLine::difficulty  /*0x0400082C*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: beq.s IL_0011
    IL_000b: ldloc.0
    IL_000c: ldc.i4.2
    IL_000d: beq.s IL_0017
    IL_000f: br.s IL_001d
    IL_0011: ldc.r4 1.15f
    IL_0016: ret
    IL_0017: ldc.r4 0.85f
    IL_001c: ret
    IL_001d: ldc.r4 1f
    IL_0022: ret

  .method EnemySpawnLine::get_SpawnLine()  // token 0x060006D2 rva 0x1e4a3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ret

  .method EnemySpawnLine::.ctor()  // token 0x060006D3 rva 0x1e4ab attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0006: stfld List<EnemySpawnLine> EnemySpawnLine::mostlySharedAttackpaths  /*0x04000830*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_0011: stfld List<EnemySpawnLine> EnemySpawnLine::mostlySeperatedAttackPaths  /*0x04000831*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== EnemySpawnLine/ESpawnDifficulty  (token 0x02000141) =====
