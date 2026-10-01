// ===== WeaponUsageFX  (token 0x020000FE) =====
  .method WeaponUsageFX::Start()  // token 0x06000547 rva 0x1712f attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack WeaponUsageFX::_autoAttack  /*0x040006DD*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_002a
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack WeaponUsageFX::_autoAttack  /*0x040006DD*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: dup
    IL_001a: ldvirtftn void WeaponUsageFX::OnAttack()  /*0x06000548*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002a: ret

  .method WeaponUsageFX::OnAttack()  // token 0x06000548 rva 0x1715b attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem WeaponUsageFX::_fx  /*0x040006DE*/
    IL_0006: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_000b: ret

  .method WeaponUsageFX::.ctor()  // token 0x06000549 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

