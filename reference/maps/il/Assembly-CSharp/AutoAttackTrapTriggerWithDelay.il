// ===== AutoAttackTrapTriggerWithDelay  (token 0x02000128) =====
  .method AutoAttackTrapTriggerWithDelay::Update()  // token 0x0600062F rva 0x1a1b4 attrs Public, Virtual, HideBySig
    // code size 91 (0x5b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call AutoAttackTrap.EState AutoAttackTrap::get_State()  /*0x0600060C*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call AutoAttackTrap.EState AutoAttackTrap::get_State()  /*0x0600060C*/
    IL_000f: ldc.i4.1
    IL_0010: bne.un.s IL_0021
    IL_0012: ldarg.0
    IL_0013: ldfld bool AutoAttackTrapTriggerWithDelay::isRunning  /*0x04000790*/
    IL_0018: brfalse.s IL_0021
    IL_001a: ldarg.0
    IL_001b: ldc.i4.0
    IL_001c: stfld bool AutoAttackTrapTriggerWithDelay::isRunning  /*0x04000790*/
    IL_0021: ldarg.0
    IL_0022: call HashSet<TaggedObject> AutoAttackTrap::get_Targets()  /*0x0600060D*/
    IL_0027: callvirt int System.Collections.Generic.HashSet<TaggedObject>::get_Count()  /*0x0A000284*/
    IL_002c: ldc.i4.0
    IL_002d: ble.s IL_0054
    IL_002f: ldarg.0
    IL_0030: call AutoAttackTrap.EState AutoAttackTrap::get_State()  /*0x0600060C*/
    IL_0035: ldc.i4.1
    IL_0036: bne.un.s IL_0054
    IL_0038: ldarg.0
    IL_0039: ldfld bool AutoAttackTrapTriggerWithDelay::isRunning  /*0x04000790*/
    IL_003e: brtrue.s IL_0054
    IL_0040: ldarg.0
    IL_0041: ldc.i4.1
    IL_0042: stfld bool AutoAttackTrapTriggerWithDelay::isRunning  /*0x04000790*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: call IEnumerator AutoAttackTrapTriggerWithDelay::ActivateWithDelay()  /*0x06000630*/
    IL_004e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0053: pop
    IL_0054: ldarg.0
    IL_0055: call void AutoAttackTrap::Update()  /*0x06000622*/
    IL_005a: ret

  .method AutoAttackTrapTriggerWithDelay::ActivateWithDelay()  // token 0x06000630 rva 0x1a21b attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::.ctor(int)  /*0x06000634*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AutoAttackTrapTriggerWithDelay AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>4__this  /*0x04000793*/
    IL_000d: ret

  .method AutoAttackTrapTriggerWithDelay::UpdateActive()  // token 0x06000631 rva 0x1a22c attrs Family, Virtual, HideBySig
    // code size 80 (0x50), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: call HashSet<TaggedObject> AutoAttackTrap::get_Targets()  /*0x0600060D*/
    IL_0026: callvirt int System.Collections.Generic.HashSet<TaggedObject>::get_Count()  /*0x0A000284*/
    IL_002b: ldc.i4.0
    IL_002c: ble.s IL_0048
    IL_002e: ldarg.0
    IL_002f: call void AutoAttackTrap::AttackAllTargets()  /*0x06000625*/
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_003b: ldarg.0
    IL_003c: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0041: add
    IL_0042: stfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldc.i4.3
    IL_004a: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_004f: ret

  .method AutoAttackTrapTriggerWithDelay::TransferToCooldown()  // token 0x06000632 rva 0x1a288 attrs Family, Virtual, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0007: ldarg.0
    IL_0008: call void AutoAttackTrap::Deactivate()  /*0x06000618*/
    IL_000d: ret

  .method AutoAttackTrapTriggerWithDelay::.ctor()  // token 0x06000633 rva 0x1a297 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AutoAttackTrapTriggerWithDelay::activationDelay  /*0x0400078F*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttackTrap::.ctor()  /*0x06000627*/
    IL_0011: ret

// ===== AutoAttackTrapTriggerWithDelay/<ActivateWithDelay>d__3  (token 0x02000129) =====
  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::.ctor(int)  // token 0x06000634 rva 0x1a2aa attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>1__state  /*0x04000791*/
    IL_000d: ret

  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::System.IDisposable.Dispose()  // token 0x06000635 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::MoveNext()  // token 0x06000636 rva 0x1a2bc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 71 (0x47), max stack 2, init locals
    .locals ([0] int, [1] AutoAttackTrapTriggerWithDelay)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>1__state  /*0x04000791*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AutoAttackTrapTriggerWithDelay AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>4__this  /*0x04000793*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>1__state  /*0x04000791*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float AutoAttackTrapTriggerWithDelay::activationDelay  /*0x0400078F*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>2__current  /*0x04000792*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>1__state  /*0x04000791*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>1__state  /*0x04000791*/
    IL_003f: ldloc.1
    IL_0040: call void AutoAttackTrap::Activate()  /*0x06000617*/
    IL_0045: ldc.i4.0
    IL_0046: ret

  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000637 rva 0x1a30f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>2__current  /*0x04000792*/
    IL_0006: ret

  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::System.Collections.IEnumerator.Reset()  // token 0x06000638 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::System.Collections.IEnumerator.get_Current()  // token 0x06000639 rva 0x1a30f attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoAttackTrapTriggerWithDelay.<ActivateWithDelay>d__3::<>2__current  /*0x04000792*/
    IL_0006: ret

