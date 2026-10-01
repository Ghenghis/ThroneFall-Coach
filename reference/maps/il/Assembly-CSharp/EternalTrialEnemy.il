// ===== EternalTrialEnemy  (token 0x02000143) =====
  .method EternalTrialEnemy::get_DifficultyValueTemp()  // token 0x060006D8 rva 0x1e5f8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EternalTrialEnemy::difficultyValueTemp  /*0x0400083A*/
    IL_0006: ret

  .method EternalTrialEnemy::set_DifficultyValueTemp(float)  // token 0x060006D9 rva 0x1e600 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float EternalTrialEnemy::difficultyValueTemp  /*0x0400083A*/
    IL_0007: ret

  .method EternalTrialEnemy::get_TempSpawnLineList()  // token 0x060006DA rva 0x1e609 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<EnemySpawnLine> EternalTrialEnemy::tempSpawnLineList  /*0x0400083B*/
    IL_0006: ret

  .method EternalTrialEnemy::get_TempSpawnLineSpawnDuration()  // token 0x060006DB rva 0x1e611 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<float> EternalTrialEnemy::tempSpawnLineSpawnDuration  /*0x0400083C*/
    IL_0006: ret

  .method EternalTrialEnemy::get_TempSpawnLineTargetDifficulty()  // token 0x060006DC rva 0x1e619 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<float> EternalTrialEnemy::tempSpawnLineTargetDifficulty  /*0x0400083D*/
    IL_0006: ret

  .method EternalTrialEnemy::get_TempSpawnLineActualDifficulty()  // token 0x060006DD rva 0x1e621 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<float> EternalTrialEnemy::tempSpawnLineActualDifficulty  /*0x0400083E*/
    IL_0006: ret

  .method EternalTrialEnemy::get_TempTargetDifficulty()  // token 0x060006DE rva 0x1e629 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EternalTrialEnemy::tempTargetDifficulty  /*0x0400083F*/
    IL_0006: ret

  .method EternalTrialEnemy::set_TempTargetDifficulty(float)  // token 0x060006DF rva 0x1e631 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float EternalTrialEnemy::tempTargetDifficulty  /*0x0400083F*/
    IL_0007: ret

  .method EternalTrialEnemy::get_TempActualDifficulty()  // token 0x060006E0 rva 0x1e63a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EternalTrialEnemy::tempActualDifficulty  /*0x04000840*/
    IL_0006: ret

  .method EternalTrialEnemy::set_TempActualDifficulty(float)  // token 0x060006E1 rva 0x1e642 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float EternalTrialEnemy::tempActualDifficulty  /*0x04000840*/
    IL_0007: ret

  .method EternalTrialEnemy::get_TempSpawnAmount()  // token 0x060006E2 rva 0x1e64b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<int> EternalTrialEnemy::tempSpawnAmount  /*0x04000841*/
    IL_0006: ret

  .method EternalTrialEnemy::get_TempDropGold()  // token 0x060006E3 rva 0x1e653 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<int> EternalTrialEnemy::tempDropGold  /*0x04000842*/
    IL_0006: ret

  .method EternalTrialEnemy::get_desiredGroupSize()  // token 0x060006E4 rva 0x1e65b attrs Public, HideBySig, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.5
    IL_0001: ret

  .method EternalTrialEnemy::get_flying()  // token 0x060006E5 rva 0x1e65e attrs Public, HideBySig, SpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0006: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TaggedObject>  /*0x2B000061*/
    IL_000b: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0010: ldc.i4.6
    IL_0011: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0016: ret

  .method EternalTrialEnemy::get_smallGround()  // token 0x060006E6 rva 0x1e676 attrs Public, HideBySig, SpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0006: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Pathfinding.Seeker>  /*0x2B000064*/
    IL_000b: ldflda GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_0010: ldc.i4.0
    IL_0011: call bool Pathfinding.GraphMask::Contains(uint)  /*0x0A0002D2*/
    IL_0016: brtrue.s IL_002f
    IL_0018: ldarg.0
    IL_0019: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_001e: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Pathfinding.Seeker>  /*0x2B000064*/
    IL_0023: ldflda GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_0028: ldc.i4.1
    IL_0029: call bool Pathfinding.GraphMask::Contains(uint)  /*0x0A0002D2*/
    IL_002e: ret
    IL_002f: ldc.i4.1
    IL_0030: ret

  .method EternalTrialEnemy::get_bigGround()  // token 0x060006E7 rva 0x1e6a8 attrs Public, HideBySig, SpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialEnemy::enemyPrefab  /*0x04000837*/
    IL_0006: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Pathfinding.Seeker>  /*0x2B000064*/
    IL_000b: ldflda GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_0010: ldc.i4.2
    IL_0011: call bool Pathfinding.GraphMask::Contains(uint)  /*0x0A0002D2*/
    IL_0016: ret

  .method EternalTrialEnemy::.ctor()  // token 0x060006E8 rva 0x1e6c0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 95 (0x5f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float EternalTrialEnemy::difficultyValue  /*0x04000838*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float EternalTrialEnemy::difficultyValueTemp  /*0x0400083A*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<EnemySpawnLine>::.ctor()  /*0x0A0002CB*/
    IL_001c: stfld List<EnemySpawnLine> EternalTrialEnemy::tempSpawnLineList  /*0x0400083B*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0027: stfld List<float> EternalTrialEnemy::tempSpawnLineSpawnDuration  /*0x0400083C*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0032: stfld List<float> EternalTrialEnemy::tempSpawnLineTargetDifficulty  /*0x0400083D*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_003d: stfld List<float> EternalTrialEnemy::tempSpawnLineActualDifficulty  /*0x0400083E*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0048: stfld List<int> EternalTrialEnemy::tempSpawnAmount  /*0x04000841*/
    IL_004d: ldarg.0
    IL_004e: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0053: stfld List<int> EternalTrialEnemy::tempDropGold  /*0x04000842*/
    IL_0058: ldarg.0
    IL_0059: call void System.Object::.ctor()  /*0x0A000038*/
    IL_005e: ret

// ===== EternalTrialEnemy/EGroup  (token 0x02000144) =====
