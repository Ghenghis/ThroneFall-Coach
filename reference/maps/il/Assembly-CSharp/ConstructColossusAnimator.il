// ===== ConstructColossusAnimator  (token 0x020000BE) =====
  .method ConstructColossusAnimator::Start()  // token 0x060003F9 rva 0x11414 attrs Private, HideBySig
    // code size 83 (0x53), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack ConstructColossusAnimator::_spearThrustAttack  /*0x0400051C*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack ConstructColossusAnimator::_spearThrustAttack  /*0x0400051C*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void ConstructColossusAnimator::OnSpearThrust()  /*0x060003FA*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ldarg.0
    IL_002a: ldfld AutoAttack ConstructColossusAnimator::_spikeAttack  /*0x0400051D*/
    IL_002f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0034: brfalse.s IL_0052
    IL_0036: ldarg.0
    IL_0037: ldfld AutoAttack ConstructColossusAnimator::_spikeAttack  /*0x0400051D*/
    IL_003c: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0041: ldarg.0
    IL_0042: ldftn void ConstructColossusAnimator::OnSpikeAttack()  /*0x060003FB*/
    IL_0048: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004d: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0052: ret

  .method ConstructColossusAnimator::OnSpearThrust()  // token 0x060003FA rva 0x11473 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator ConstructColossusAnimator::_animator  /*0x0400051B*/
    IL_0006: ldstr "SpearAttack"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ret

  .method ConstructColossusAnimator::OnSpikeAttack()  // token 0x060003FB rva 0x11485 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator ConstructColossusAnimator::_animator  /*0x0400051B*/
    IL_0006: ldstr "SpikeAttack"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ret

  .method ConstructColossusAnimator::.ctor()  // token 0x060003FC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

