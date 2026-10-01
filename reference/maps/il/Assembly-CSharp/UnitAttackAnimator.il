// ===== UnitAttackAnimator  (token 0x02000046) =====
  .method UnitAttackAnimator::Start()  // token 0x0600014E rva 0x73ab attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack UnitAttackAnimator::unit  /*0x040001AB*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack UnitAttackAnimator::unit  /*0x040001AB*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void UnitAttackAnimator::OnAttack()  /*0x0600014F*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ret

  .method UnitAttackAnimator::OnAttack()  // token 0x0600014F rva 0x73d8 attrs Private, HideBySig
    // code size 54 (0x36), max stack 2, init locals
    .locals ([0] OneShotAnimationBase[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld OneShotAnimationBase UnitAttackAnimator::attackAnimation  /*0x040001AC*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0018
    IL_000d: ldarg.0
    IL_000e: ldfld OneShotAnimationBase UnitAttackAnimator::attackAnimation  /*0x040001AC*/
    IL_0013: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_0018: ldarg.0
    IL_0019: ldfld OneShotAnimationBase[] UnitAttackAnimator::additionalAttackAnimations  /*0x040001AD*/
    IL_001e: stloc.0
    IL_001f: ldc.i4.0
    IL_0020: stloc.1
    IL_0021: br.s IL_002f
    IL_0023: ldloc.0
    IL_0024: ldloc.1
    IL_0025: ldelem.ref
    IL_0026: callvirt void OneShotAnimationBase::Trigger()  /*0x060000CE*/
    IL_002b: ldloc.1
    IL_002c: ldc.i4.1
    IL_002d: add
    IL_002e: stloc.1
    IL_002f: ldloc.1
    IL_0030: ldloc.0
    IL_0031: ldlen
    IL_0032: conv.i4
    IL_0033: blt.s IL_0023
    IL_0035: ret

  .method UnitAttackAnimator::OnAttackExt()  // token 0x06000150 rva 0x741a attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnitAttackAnimator::OnAttack()  /*0x0600014F*/
    IL_0006: ret

  .method UnitAttackAnimator::.ctor()  // token 0x06000151 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

