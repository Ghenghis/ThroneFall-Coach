// ===== PeriodicallyEnableAndDisableDuringEnemySpawn  (token 0x02000212) =====
  .method PeriodicallyEnableAndDisableDuringEnemySpawn::Start()  // token 0x06000B4C rva 0x361ee attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0006: stfld EnemySpawner PeriodicallyEnableAndDisableDuringEnemySpawn::enemySpawner  /*0x04000E28*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld float PeriodicallyEnableAndDisableDuringEnemySpawn::enabledDuration  /*0x04000E26*/
    IL_0012: ldarg.0
    IL_0013: ldfld float PeriodicallyEnableAndDisableDuringEnemySpawn::disabledDuration  /*0x04000E27*/
    IL_0018: add
    IL_0019: stfld float PeriodicallyEnableAndDisableDuringEnemySpawn::totalTime  /*0x04000E29*/
    IL_001e: ret

  .method PeriodicallyEnableAndDisableDuringEnemySpawn::Update()  // token 0x06000B4D rva 0x36210 attrs Private, HideBySig
    // code size 40 (0x28), max stack 3, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld EnemySpawner PeriodicallyEnableAndDisableDuringEnemySpawn::enemySpawner  /*0x04000E28*/
    IL_0006: callvirt float EnemySpawner::get_LastSpawnPeriodClock()  /*0x06000676*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: ldfld MonoBehaviour PeriodicallyEnableAndDisableDuringEnemySpawn::toEnableAndDisable  /*0x04000E25*/
    IL_0012: ldloc.0
    IL_0013: ldarg.0
    IL_0014: ldfld float PeriodicallyEnableAndDisableDuringEnemySpawn::totalTime  /*0x04000E29*/
    IL_0019: rem
    IL_001a: ldarg.0
    IL_001b: ldfld float PeriodicallyEnableAndDisableDuringEnemySpawn::enabledDuration  /*0x04000E26*/
    IL_0020: clt
    IL_0022: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0027: ret

  .method PeriodicallyEnableAndDisableDuringEnemySpawn::.ctor()  // token 0x06000B4E rva 0x36244 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float PeriodicallyEnableAndDisableDuringEnemySpawn::enabledDuration  /*0x04000E26*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float PeriodicallyEnableAndDisableDuringEnemySpawn::disabledDuration  /*0x04000E27*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

