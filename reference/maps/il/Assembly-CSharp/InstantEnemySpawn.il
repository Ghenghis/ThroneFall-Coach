// ===== InstantEnemySpawn  (token 0x0200019C) =====
  .method InstantEnemySpawn::SpawnWave()  // token 0x06000859 rva 0x289ca attrs Public, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool InstantEnemySpawn::spawnRunning  /*0x04000A66*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call IEnumerator InstantEnemySpawn::SpawningWave()  /*0x0600085A*/
    IL_0010: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0015: pop
    IL_0016: ret

  .method InstantEnemySpawn::SpawningWave()  // token 0x0600085A rva 0x289e2 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void InstantEnemySpawn.<SpawningWave>d__3::.ctor(int)  /*0x0600085C*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld InstantEnemySpawn InstantEnemySpawn.<SpawningWave>d__3::<>4__this  /*0x04000A69*/
    IL_000d: ret

  .method InstantEnemySpawn::.ctor()  // token 0x0600085B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== InstantEnemySpawn/<SpawningWave>d__3  (token 0x0200019D) =====
  .method InstantEnemySpawn.<SpawningWave>d__3::.ctor(int)  // token 0x0600085C rva 0x289f1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int InstantEnemySpawn.<SpawningWave>d__3::<>1__state  /*0x04000A67*/
    IL_000d: ret

  .method InstantEnemySpawn.<SpawningWave>d__3::System.IDisposable.Dispose()  // token 0x0600085D rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InstantEnemySpawn.<SpawningWave>d__3::MoveNext()  // token 0x0600085E rva 0x28a00 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 107 (0x6b), max stack 2, init locals
    .locals ([0] int, [1] InstantEnemySpawn)
    IL_0000: ldarg.0
    IL_0001: ldfld int InstantEnemySpawn.<SpawningWave>d__3::<>1__state  /*0x04000A67*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld InstantEnemySpawn InstantEnemySpawn.<SpawningWave>d__3::<>4__this  /*0x04000A69*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_004e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int InstantEnemySpawn.<SpawningWave>d__3::<>1__state  /*0x04000A67*/
    IL_001e: ldloc.1
    IL_001f: ldc.i4.1
    IL_0020: stfld bool InstantEnemySpawn::spawnRunning  /*0x04000A66*/
    IL_0025: ldloc.1
    IL_0026: ldfld Wave InstantEnemySpawn::wave  /*0x04000A65*/
    IL_002b: ldc.i4.1
    IL_002c: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_0031: br.s IL_0055
    IL_0033: ldloc.1
    IL_0034: ldfld Wave InstantEnemySpawn::wave  /*0x04000A65*/
    IL_0039: callvirt void Wave::Update()  /*0x0600069D*/
    IL_003e: ldarg.0
    IL_003f: ldnull
    IL_0040: stfld object InstantEnemySpawn.<SpawningWave>d__3::<>2__current  /*0x04000A68*/
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: stfld int InstantEnemySpawn.<SpawningWave>d__3::<>1__state  /*0x04000A67*/
    IL_004c: ldc.i4.1
    IL_004d: ret
    IL_004e: ldarg.0
    IL_004f: ldc.i4.m1
    IL_0050: stfld int InstantEnemySpawn.<SpawningWave>d__3::<>1__state  /*0x04000A67*/
    IL_0055: ldloc.1
    IL_0056: ldfld Wave InstantEnemySpawn::wave  /*0x04000A65*/
    IL_005b: callvirt bool Wave::HasFinished()  /*0x0600069E*/
    IL_0060: brfalse.s IL_0033
    IL_0062: ldloc.1
    IL_0063: ldc.i4.0
    IL_0064: stfld bool InstantEnemySpawn::spawnRunning  /*0x04000A66*/
    IL_0069: ldc.i4.0
    IL_006a: ret

  .method InstantEnemySpawn.<SpawningWave>d__3::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600085F rva 0x28a77 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object InstantEnemySpawn.<SpawningWave>d__3::<>2__current  /*0x04000A68*/
    IL_0006: ret

  .method InstantEnemySpawn.<SpawningWave>d__3::System.Collections.IEnumerator.Reset()  // token 0x06000860 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method InstantEnemySpawn.<SpawningWave>d__3::System.Collections.IEnumerator.get_Current()  // token 0x06000861 rva 0x28a77 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object InstantEnemySpawn.<SpawningWave>d__3::<>2__current  /*0x04000A68*/
    IL_0006: ret

