// ===== PlayerAttackAnimator  (token 0x02000028) =====
  .method PlayerAttackAnimator::AssignAttack(ManualAttack)  // token 0x060000D0 rva 0x5691 attrs Public, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ManualAttack PlayerAttackAnimator::playerAttack  /*0x040000FD*/
    IL_0007: ldarg.0
    IL_0008: ldfld ManualAttack PlayerAttackAnimator::playerAttack  /*0x040000FD*/
    IL_000d: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_0012: ldarg.0
    IL_0013: ldftn void PlayerAttackAnimator::TriggerAnimations()  /*0x060000D1*/
    IL_0019: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0023: ret

  .method PlayerAttackAnimator::TriggerAnimations()  // token 0x060000D1 rva 0x56b8 attrs Private, HideBySig
    // code size 99 (0x63), max stack 2, init locals
    .locals ([0] List.Enumerator<OneShotAnimationBase>)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld List<OneShotAnimationBase> PlayerAttackAnimator::animations  /*0x040000FA*/
    IL_0014: callvirt List.Enumerator<!0> System.Collections.Generic.List<OneShotAnimationBase>::GetEnumerator()  /*0x0A00009A*/
    IL_0019: stloc.0
    IL_001a: br.s IL_0028
    IL_001c: ldloca.s 0
    IL_001e: call !0 System.Collections.Generic.List.Enumerator<OneShotAnimationBase>::get_Current()  /*0x0A00009B*/
    IL_0023: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_0028: ldloca.s 0
    IL_002a: call bool System.Collections.Generic.List.Enumerator<OneShotAnimationBase>::MoveNext()  /*0x0A00009C*/
    IL_002f: brtrue.s IL_001c
    IL_0031: leave.s IL_0041
    IL_0033: ldloca.s 0
    IL_0035: constrained. System.Collections.Generic.List.Enumerator<OneShotAnimationBase>  /*0x1B000013*/
    IL_003b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0040: endfinally
    IL_0041: ldarg.0
    IL_0042: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0047: ldarg.0
    IL_0048: ldfld List<OneShotAnimationBase> PlayerAttackAnimator::cooldownAnimations  /*0x040000FB*/
    IL_004d: callvirt int System.Collections.Generic.List<OneShotAnimationBase>::get_Count()  /*0x0A00009D*/
    IL_0052: ldc.i4.0
    IL_0053: ble.s IL_0062
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: call IEnumerator PlayerAttackAnimator::DelayedCooldownAnimation()  /*0x060000D2*/
    IL_005c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0061: pop
    IL_0062: ret
    .try IL_001a-IL_0033 finally handler IL_0033-IL_0041

  .method PlayerAttackAnimator::DelayedCooldownAnimation()  // token 0x060000D2 rva 0x5738 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::.ctor(int)  /*0x060000D4*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlayerAttackAnimator PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>4__this  /*0x04000100*/
    IL_000d: ret

  .method PlayerAttackAnimator::.ctor()  // token 0x060000D3 rva 0x5747 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<OneShotAnimationBase>::.ctor()  /*0x0A00009E*/
    IL_0006: stfld List<OneShotAnimationBase> PlayerAttackAnimator::animations  /*0x040000FA*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<OneShotAnimationBase>::.ctor()  /*0x0A00009E*/
    IL_0011: stfld List<OneShotAnimationBase> PlayerAttackAnimator::cooldownAnimations  /*0x040000FB*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.15f
    IL_001c: stfld float PlayerAttackAnimator::delayOfCooldownAnimation  /*0x040000FC*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== PlayerAttackAnimator/<DelayedCooldownAnimation>d__6  (token 0x02000029) =====
  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::.ctor(int)  // token 0x060000D4 rva 0x5770 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>1__state  /*0x040000FE*/
    IL_000d: ret

  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::System.IDisposable.Dispose()  // token 0x060000D5 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::MoveNext()  // token 0x060000D6 rva 0x5780 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 150 (0x96), max stack 3, init locals
    .locals ([0] int, [1] PlayerAttackAnimator, [2] float, [3] List.Enumerator<OneShotAnimationBase>)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>1__state  /*0x040000FE*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerAttackAnimator PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>4__this  /*0x04000100*/
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
    IL_0019: stfld int PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>1__state  /*0x040000FE*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float PlayerAttackAnimator::delayOfCooldownAnimation  /*0x040000FC*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>2__current  /*0x040000FF*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>1__state  /*0x040000FE*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>1__state  /*0x040000FE*/
    IL_003f: ldloc.1
    IL_0040: ldfld ManualAttack PlayerAttackAnimator::playerAttack  /*0x040000FD*/
    IL_0045: callvirt float ManualAttack::get_Cooldown()  /*0x060009FD*/
    IL_004a: ldloc.1
    IL_004b: ldfld float PlayerAttackAnimator::delayOfCooldownAnimation  /*0x040000FC*/
    IL_0050: sub
    IL_0051: stloc.2
    IL_0052: ldloc.2
    IL_0053: ldc.r4 0.1f
    IL_0058: ble.un.s IL_0094
    IL_005a: ldloc.1
    IL_005b: ldfld List<OneShotAnimationBase> PlayerAttackAnimator::cooldownAnimations  /*0x040000FB*/
    IL_0060: callvirt List.Enumerator<!0> System.Collections.Generic.List<OneShotAnimationBase>::GetEnumerator()  /*0x0A00009A*/
    IL_0065: stloc.3
    IL_0066: br.s IL_007b
    IL_0068: ldloca.s 3
    IL_006a: call !0 System.Collections.Generic.List.Enumerator<OneShotAnimationBase>::get_Current()  /*0x0A00009B*/
    IL_006f: dup
    IL_0070: ldloc.2
    IL_0071: stfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_0076: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_007b: ldloca.s 3
    IL_007d: call bool System.Collections.Generic.List.Enumerator<OneShotAnimationBase>::MoveNext()  /*0x0A00009C*/
    IL_0082: brtrue.s IL_0068
    IL_0084: leave.s IL_0094
    IL_0086: ldloca.s 3
    IL_0088: constrained. System.Collections.Generic.List.Enumerator<OneShotAnimationBase>  /*0x1B000013*/
    IL_008e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0093: endfinally
    IL_0094: ldc.i4.0
    IL_0095: ret
    .try IL_0066-IL_0086 finally handler IL_0086-IL_0094

  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000D7 rva 0x5834 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>2__current  /*0x040000FF*/
    IL_0006: ret

  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::System.Collections.IEnumerator.Reset()  // token 0x060000D8 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::System.Collections.IEnumerator.get_Current()  // token 0x060000D9 rva 0x5834 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerAttackAnimator.<DelayedCooldownAnimation>d__6::<>2__current  /*0x040000FF*/
    IL_0006: ret

