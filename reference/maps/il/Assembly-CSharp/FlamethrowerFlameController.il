// ===== FlamethrowerFlameController  (token 0x020000F8) =====
  .method FlamethrowerFlameController::Attach(AutoAttackFlamethrower)  // token 0x06000532 rva 0x16cd6 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld AutoAttackFlamethrower FlamethrowerFlameController::_autoAttack  /*0x040006C1*/
    IL_0007: ret

  .method FlamethrowerFlameController::OnTriggerEnter(UnityEngine.Collider)  // token 0x06000533 rva 0x16ce0 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    .locals ([0] TrapController, [1] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt int UnityEngine.GameObject::get_layer()  /*0x0A00022A*/
    IL_000b: ldc.i4.s 30
    IL_000d: bne.un.s IL_0021
    IL_000f: ldarg.1
    IL_0010: ldloca.s 0
    IL_0012: callvirt bool UnityEngine.Component::TryGetComponent(ref !!0)<TrapController>  /*0x2B00003C*/
    IL_0017: brfalse.s IL_0021
    IL_0019: ldloc.0
    IL_001a: ldc.i4.1
    IL_001b: ldc.i4.1
    IL_001c: callvirt void TrapController::Activate(bool,bool)  /*0x06000641*/
    IL_0021: ldarg.1
    IL_0022: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0027: callvirt int UnityEngine.GameObject::get_layer()  /*0x0A00022A*/
    IL_002c: ldc.i4.8
    IL_002d: bne.un.s IL_004a
    IL_002f: ldarg.1
    IL_0030: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0035: stloc.1
    IL_0036: ldloc.1
    IL_0037: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_003c: brfalse.s IL_004a
    IL_003e: ldarg.0
    IL_003f: ldfld AutoAttackFlamethrower FlamethrowerFlameController::_autoAttack  /*0x040006C1*/
    IL_0044: ldloc.1
    IL_0045: callvirt void AutoAttackFlamethrower::AddTarget(TaggedObject)  /*0x06000432*/
    IL_004a: ret

  .method FlamethrowerFlameController::.ctor()  // token 0x06000534 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

