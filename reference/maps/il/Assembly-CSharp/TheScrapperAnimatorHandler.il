// ===== TheScrapperAnimatorHandler  (token 0x020000E7) =====
  .method TheScrapperAnimatorHandler::OnEnable()  // token 0x060004ED rva 0x1573d attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TheScrapperController TheScrapperAnimatorHandler::_controller  /*0x0400065E*/
    IL_0006: ldfld UnityEvent TheScrapperController::OnActivateCurrentPhase  /*0x04000682*/
    IL_000b: ldarg.0
    IL_000c: ldftn void TheScrapperAnimatorHandler::OnGrowthSpurt()  /*0x060004F0*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld TheScrapperAutoAttack TheScrapperAnimatorHandler::_autoAttack  /*0x0400065F*/
    IL_0022: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0027: ldarg.0
    IL_0028: ldftn void TheScrapperAnimatorHandler::OnAttack()  /*0x060004F1*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ret

  .method TheScrapperAnimatorHandler::OnDisable()  // token 0x060004EE rva 0x15777 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TheScrapperController TheScrapperAnimatorHandler::_controller  /*0x0400065E*/
    IL_0006: ldfld UnityEvent TheScrapperController::OnActivateCurrentPhase  /*0x04000682*/
    IL_000b: ldarg.0
    IL_000c: ldftn void TheScrapperAnimatorHandler::OnGrowthSpurt()  /*0x060004F0*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_001c: ldarg.0
    IL_001d: ldfld TheScrapperAutoAttack TheScrapperAnimatorHandler::_autoAttack  /*0x0400065F*/
    IL_0022: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0027: ldarg.0
    IL_0028: ldftn void TheScrapperAnimatorHandler::OnAttack()  /*0x060004F1*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_0038: ret

  .method TheScrapperAnimatorHandler::SwitchPhase()  // token 0x060004EF rva 0x157b1 attrs Public, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldsfld UnityEvent TheScrapperAnimatorHandler::OnSwitchPhase  /*0x0400065C*/
    IL_0005: dup
    IL_0006: brtrue.s IL_000a
    IL_0008: pop
    IL_0009: ret
    IL_000a: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000f: ret

  .method TheScrapperAnimatorHandler::OnGrowthSpurt()  // token 0x060004F0 rva 0x157c2 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator TheScrapperAnimatorHandler::_animator  /*0x0400065D*/
    IL_0006: ldstr "GrowthSpurt"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ret

  .method TheScrapperAnimatorHandler::OnAttack()  // token 0x060004F1 rva 0x157d4 attrs Private, HideBySig
    // code size 141 (0x8d), max stack 4, init locals
    .locals ([0] List.Enumerator<TheScrapperAnimatorHandler.AttackVFX>, [1] TheScrapperAnimatorHandler.AttackVFX)
    IL_0000: ldarg.0
    IL_0001: ldfld Animator TheScrapperAnimatorHandler::_animator  /*0x0400065D*/
    IL_0006: ldstr "AttackDirection"
    IL_000b: ldarg.0
    IL_000c: ldfld TheScrapperAutoAttack TheScrapperAnimatorHandler::_autoAttack  /*0x0400065F*/
    IL_0011: callvirt TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::get_CurrentAttackSource()  /*0x060004F4*/
    IL_0016: ldc.i4.1
    IL_0017: beq.s IL_001c
    IL_0019: ldc.i4.1
    IL_001a: br.s IL_001d
    IL_001c: ldc.i4.0
    IL_001d: callvirt void UnityEngine.Animator::SetInteger(string,int)  /*0x0A00020E*/
    IL_0022: ldarg.0
    IL_0023: ldfld Animator TheScrapperAnimatorHandler::_animator  /*0x0400065D*/
    IL_0028: ldstr "Attack"
    IL_002d: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0032: ldarg.0
    IL_0033: ldfld List<TheScrapperAnimatorHandler.AttackVFX> TheScrapperAnimatorHandler::_attackVFXs  /*0x04000660*/
    IL_0038: callvirt List.Enumerator<!0> System.Collections.Generic.List<TheScrapperAnimatorHandler.AttackVFX>::GetEnumerator()  /*0x0A000212*/
    IL_003d: stloc.0
    IL_003e: br.s IL_0073
    IL_0040: ldloca.s 0
    IL_0042: call !0 System.Collections.Generic.List.Enumerator<TheScrapperAnimatorHandler.AttackVFX>::get_Current()  /*0x0A000213*/
    IL_0047: stloc.1
    IL_0048: ldloc.1
    IL_0049: ldfld TheScrapperAttackOrigin.AttackSource TheScrapperAnimatorHandler.AttackVFX::Source  /*0x04000664*/
    IL_004e: ldarg.0
    IL_004f: ldfld TheScrapperAutoAttack TheScrapperAnimatorHandler::_autoAttack  /*0x0400065F*/
    IL_0054: callvirt TheScrapperAttackOrigin.AttackSource TheScrapperAutoAttack::get_CurrentAttackSource()  /*0x060004F4*/
    IL_0059: bne.un.s IL_0073
    IL_005b: ldloc.1
    IL_005c: ldfld ParticleSystem TheScrapperAnimatorHandler.AttackVFX::VFX  /*0x04000665*/
    IL_0061: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0066: brfalse.s IL_0073
    IL_0068: ldloc.1
    IL_0069: ldfld ParticleSystem TheScrapperAnimatorHandler.AttackVFX::VFX  /*0x04000665*/
    IL_006e: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0073: ldloca.s 0
    IL_0075: call bool System.Collections.Generic.List.Enumerator<TheScrapperAnimatorHandler.AttackVFX>::MoveNext()  /*0x0A000214*/
    IL_007a: brtrue.s IL_0040
    IL_007c: leave.s IL_008c
    IL_007e: ldloca.s 0
    IL_0080: constrained. System.Collections.Generic.List.Enumerator<TheScrapperAnimatorHandler.AttackVFX>  /*0x1B000052*/
    IL_0086: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008b: endfinally
    IL_008c: ret
    .try IL_003e-IL_007e finally handler IL_007e-IL_008c

  .method TheScrapperAnimatorHandler::.ctor()  // token 0x060004F2 rva 0x15880 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TheScrapperAnimatorHandler.AttackVFX>::.ctor()  /*0x0A000215*/
    IL_0006: stfld List<TheScrapperAnimatorHandler.AttackVFX> TheScrapperAnimatorHandler::_attackVFXs  /*0x04000660*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

  .method TheScrapperAnimatorHandler::.cctor()  // token 0x060004F3 rva 0x15893 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0005: stsfld UnityEvent TheScrapperAnimatorHandler::OnSwitchPhase  /*0x0400065C*/
    IL_000a: ret

// ===== TheScrapperAnimatorHandler/AttackVFX  (token 0x020000E8) =====
