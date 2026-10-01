// ===== EnemySpawnManager  (token 0x020001CA) =====
  .method EnemySpawnManager::Awake()  // token 0x06000934 rva 0x2be66 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld EnemySpawnManager EnemySpawnManager::instance  /*0x04000B9E*/
    IL_0006: ret

  .method EnemySpawnManager::.ctor()  // token 0x06000935 rva 0x2be6e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float EnemySpawnManager::weaponAttackHeight  /*0x04000BA2*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

