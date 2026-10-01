// ===== TrapController  (token 0x0200012B) =====
  .method TrapController::Attach(AutoAttackTrap)  // token 0x0600063D rva 0x1a3e1 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0007: ret

  .method TrapController::Detach()  // token 0x0600063E rva 0x1a3ea attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0007: ret

  .method TrapController::OnTriggerEnter(UnityEngine.Collider)  // token 0x0600063F rva 0x1a3f4 attrs Private, HideBySig
    // code size 82 (0x52), max stack 2, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.1
    IL_000f: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0014: stloc.0
    IL_0015: ldloc.0
    IL_0016: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001b: brfalse.s IL_0051
    IL_001d: ldloc.0
    IL_001e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0023: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0028: brfalse.s IL_0051
    IL_002a: ldloc.0
    IL_002b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0030: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0035: brtrue.s IL_0051
    IL_0037: ldarg.0
    IL_0038: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_003d: ldloc.0
    IL_003e: callvirt bool AutoAttackTrap::MatchTags(TaggedObject)  /*0x06000614*/
    IL_0043: brfalse.s IL_0051
    IL_0045: ldarg.0
    IL_0046: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_004b: ldloc.0
    IL_004c: callvirt void AutoAttackTrap::AddTarget(TaggedObject)  /*0x06000615*/
    IL_0051: ret

  .method TrapController::OnTriggerExit(UnityEngine.Collider)  // token 0x06000640 rva 0x1a454 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.1
    IL_000f: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0014: stloc.0
    IL_0015: ldloc.0
    IL_0016: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001b: brfalse.s IL_0029
    IL_001d: ldarg.0
    IL_001e: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0023: ldloc.0
    IL_0024: callvirt void AutoAttackTrap::RemoveTarget(TaggedObject)  /*0x06000616*/
    IL_0029: ret

  .method TrapController::Activate(bool,bool)  // token 0x06000641 rva 0x1a48a attrs Public, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TrapController::_onActivateFx  /*0x04000797*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0012: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0017: ldarg.2
    IL_0018: and
    IL_0019: brfalse.s IL_0026
    IL_001b: ldarg.0
    IL_001c: ldfld AutoAttackTrap TrapController::_autoAttack  /*0x0400079B*/
    IL_0021: callvirt void AutoAttackTrap::Activate()  /*0x06000617*/
    IL_0026: ret

  .method TrapController::PlayAttackVFX()  // token 0x06000642 rva 0x1a4b2 attrs Public, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem TrapController::_trapAttackFX  /*0x04000798*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000c
    IL_0009: pop
    IL_000a: br.s IL_0011
    IL_000c: call void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0011: ldarg.0
    IL_0012: ldfld Animator TrapController::_trapAnimator  /*0x04000799*/
    IL_0017: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001c: brfalse.s IL_002f
    IL_001e: ldarg.0
    IL_001f: ldfld Animator TrapController::_trapAnimator  /*0x04000799*/
    IL_0024: ldarg.0
    IL_0025: ldfld string TrapController::_triggerParameterName  /*0x0400079A*/
    IL_002a: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_002f: ret

  .method TrapController::.ctor()  // token 0x06000643 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

