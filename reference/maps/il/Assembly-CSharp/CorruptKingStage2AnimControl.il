// ===== CorruptKingStage2AnimControl  (token 0x0200001B) =====
  .method CorruptKingStage2AnimControl::Start()  // token 0x0600009C rva 0x4ab8 attrs Private, HideBySig
    // code size 70 (0x46), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack CorruptKingStage2AnimControl::autoAttack  /*0x040000AB*/
    IL_0006: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_000b: ldarg.0
    IL_000c: ldftn void CorruptKingStage2AnimControl::OnAttack()  /*0x0600009D*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld UnitDashJumpEnemy CorruptKingStage2AnimControl::jumper  /*0x040000AD*/
    IL_0022: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0027: brfalse.s IL_0045
    IL_0029: ldarg.0
    IL_002a: ldfld UnitDashJumpEnemy CorruptKingStage2AnimControl::jumper  /*0x040000AD*/
    IL_002f: ldfld UnityEvent<Vector3> UnitDashJumpEnemy::onStartJump  /*0x040017C3*/
    IL_0034: ldarg.0
    IL_0035: ldftn void CorruptKingStage2AnimControl::OnJump(UnityEngine.Vector3)  /*0x0600009E*/
    IL_003b: newobj void UnityEngine.Events.UnityAction<UnityEngine.Vector3>::.ctor(object,IntPtr)  /*0x0A000089*/
    IL_0040: callvirt void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A00008A*/
    IL_0045: ret

  .method CorruptKingStage2AnimControl::OnAttack()  // token 0x0600009D rva 0x4b0a attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator CorruptKingStage2AnimControl::animator  /*0x040000AC*/
    IL_0006: ldstr "Attack"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ret

  .method CorruptKingStage2AnimControl::OnJump(UnityEngine.Vector3)  // token 0x0600009E rva 0x4b1c attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator CorruptKingStage2AnimControl::animator  /*0x040000AC*/
    IL_0006: ldstr "JumpAttack"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ldarg.0
    IL_0011: ldfld GameObject CorruptKingStage2AnimControl::jumpMarkerPrefab  /*0x040000AE*/
    IL_0016: ldarg.1
    IL_0017: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_001c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0021: pop
    IL_0022: ret

  .method CorruptKingStage2AnimControl::.ctor()  // token 0x0600009F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

