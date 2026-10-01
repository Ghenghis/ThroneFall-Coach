// ===== BattleAxeShieldFX  (token 0x0200016E) =====
  .method BattleAxeShieldFX::Play(float)  // token 0x0600076F rva 0x25271 attrs Public, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld float BattleAxeShieldFX::animationTime  /*0x04000954*/
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: call IEnumerator BattleAxeShieldFX::AnimationRoutine()  /*0x06000770*/
    IL_0014: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0019: pop
    IL_001a: ldc.i4.s 27
    IL_001c: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0021: ret

  .method BattleAxeShieldFX::AnimationRoutine()  // token 0x06000770 rva 0x25294 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BattleAxeShieldFX.<AnimationRoutine>d__4::.ctor(int)  /*0x06000772*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BattleAxeShieldFX BattleAxeShieldFX.<AnimationRoutine>d__4::<>4__this  /*0x04000958*/
    IL_000d: ret

  .method BattleAxeShieldFX::.ctor()  // token 0x06000771 rva 0x252a3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3.5f
    IL_0006: stfld float BattleAxeShieldFX::animationTime  /*0x04000954*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== BattleAxeShieldFX/<AnimationRoutine>d__4  (token 0x0200016F) =====
  .method BattleAxeShieldFX.<AnimationRoutine>d__4::.ctor(int)  // token 0x06000772 rva 0x252b6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BattleAxeShieldFX.<AnimationRoutine>d__4::<>1__state  /*0x04000956*/
    IL_000d: ret

  .method BattleAxeShieldFX.<AnimationRoutine>d__4::System.IDisposable.Dispose()  // token 0x06000773 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BattleAxeShieldFX.<AnimationRoutine>d__4::MoveNext()  // token 0x06000774 rva 0x252c8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 158 (0x9e), max stack 3, init locals
    .locals ([0] int, [1] BattleAxeShieldFX, [2] ParticleSystem[], [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int BattleAxeShieldFX.<AnimationRoutine>d__4::<>1__state  /*0x04000956*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BattleAxeShieldFX BattleAxeShieldFX.<AnimationRoutine>d__4::<>4__this  /*0x04000958*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_006a
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BattleAxeShieldFX.<AnimationRoutine>d__4::<>1__state  /*0x04000956*/
    IL_001e: ldloc.1
    IL_001f: ldc.r4 0f
    IL_0024: stfld float BattleAxeShieldFX::clock  /*0x04000955*/
    IL_0029: ldloc.1
    IL_002a: ldfld ParticleSystem[] BattleAxeShieldFX::particles  /*0x04000953*/
    IL_002f: stloc.2
    IL_0030: ldc.i4.0
    IL_0031: stloc.3
    IL_0032: br.s IL_0040
    IL_0034: ldloc.2
    IL_0035: ldloc.3
    IL_0036: ldelem.ref
    IL_0037: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_003c: ldloc.3
    IL_003d: ldc.i4.1
    IL_003e: add
    IL_003f: stloc.3
    IL_0040: ldloc.3
    IL_0041: ldloc.2
    IL_0042: ldlen
    IL_0043: conv.i4
    IL_0044: blt.s IL_0034
    IL_0046: br.s IL_0071
    IL_0048: ldloc.1
    IL_0049: ldloc.1
    IL_004a: ldfld float BattleAxeShieldFX::clock  /*0x04000955*/
    IL_004f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0054: add
    IL_0055: stfld float BattleAxeShieldFX::clock  /*0x04000955*/
    IL_005a: ldarg.0
    IL_005b: ldnull
    IL_005c: stfld object BattleAxeShieldFX.<AnimationRoutine>d__4::<>2__current  /*0x04000957*/
    IL_0061: ldarg.0
    IL_0062: ldc.i4.1
    IL_0063: stfld int BattleAxeShieldFX.<AnimationRoutine>d__4::<>1__state  /*0x04000956*/
    IL_0068: ldc.i4.1
    IL_0069: ret
    IL_006a: ldarg.0
    IL_006b: ldc.i4.m1
    IL_006c: stfld int BattleAxeShieldFX.<AnimationRoutine>d__4::<>1__state  /*0x04000956*/
    IL_0071: ldloc.1
    IL_0072: ldfld float BattleAxeShieldFX::clock  /*0x04000955*/
    IL_0077: ldloc.1
    IL_0078: ldfld float BattleAxeShieldFX::animationTime  /*0x04000954*/
    IL_007d: blt.s IL_0048
    IL_007f: ldloc.1
    IL_0080: ldfld ParticleSystem[] BattleAxeShieldFX::particles  /*0x04000953*/
    IL_0085: stloc.2
    IL_0086: ldc.i4.0
    IL_0087: stloc.3
    IL_0088: br.s IL_0096
    IL_008a: ldloc.2
    IL_008b: ldloc.3
    IL_008c: ldelem.ref
    IL_008d: callvirt void UnityEngine.ParticleSystem::Stop()  /*0x0A00022C*/
    IL_0092: ldloc.3
    IL_0093: ldc.i4.1
    IL_0094: add
    IL_0095: stloc.3
    IL_0096: ldloc.3
    IL_0097: ldloc.2
    IL_0098: ldlen
    IL_0099: conv.i4
    IL_009a: blt.s IL_008a
    IL_009c: ldc.i4.0
    IL_009d: ret

  .method BattleAxeShieldFX.<AnimationRoutine>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000775 rva 0x25372 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BattleAxeShieldFX.<AnimationRoutine>d__4::<>2__current  /*0x04000957*/
    IL_0006: ret

  .method BattleAxeShieldFX.<AnimationRoutine>d__4::System.Collections.IEnumerator.Reset()  // token 0x06000776 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BattleAxeShieldFX.<AnimationRoutine>d__4::System.Collections.IEnumerator.get_Current()  // token 0x06000777 rva 0x25372 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BattleAxeShieldFX.<AnimationRoutine>d__4::<>2__current  /*0x04000957*/
    IL_0006: ret

