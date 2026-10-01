// ===== ThiefController  (token 0x02000123) =====
  .method ThiefController::get_IsComingHome()  // token 0x06000602 rva 0x195f0 attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_0006: ldc.r4 0f
    IL_000b: clt
    IL_000d: ret

  .method ThiefController::get_IsStealing()  // token 0x06000603 rva 0x195ff attrs Public, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_0006: ldc.r4 0f
    IL_000b: cgt
    IL_000d: ret

  .method ThiefController::Awake()  // token 0x06000604 rva 0x19610 attrs Private, HideBySig
    // code size 77 (0x4d), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0007: stfld Hp ThiefController::_hp  /*0x04000773*/
    IL_000c: ldarg.0
    IL_000d: ldfld Hp ThiefController::_hp  /*0x04000773*/
    IL_0012: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0017: ldarg.0
    IL_0018: ldftn void ThiefController::ReturnStolen()  /*0x06000605*/
    IL_001e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0023: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call !!0 UnityEngine.Component::GetComponent()<PathfindMovementThief>  /*0x2B000049*/
    IL_002f: stfld PathfindMovementThief ThiefController::_pathfindMovement  /*0x04000774*/
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: call !!0 UnityEngine.Component::GetComponent()<KnockbackBehavior>  /*0x2B00004A*/
    IL_003b: stfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0040: ldarg.0
    IL_0041: ldarg.0
    IL_0042: ldfld float ThiefController::_holdDuration  /*0x0400076D*/
    IL_0047: stfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_004c: ret

  .method ThiefController::ReturnStolen()  // token 0x06000605 rva 0x1966c attrs Private, HideBySig
    // code size 173 (0xad), max stack 4, init locals
    .locals ([0] int, [1] Vector3, [2] Coin)
    IL_0000: ldarg.0
    IL_0001: ldfld int ThiefController::_actualStolenAmount  /*0x04000771*/
    IL_0006: ldc.i4.0
    IL_0007: bgt.s IL_000a
    IL_0009: ret
    IL_000a: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_000f: pop
    IL_0010: ldc.i4.0
    IL_0011: stloc.0
    IL_0012: br IL_0099
    IL_0017: ldloc.0
    IL_0018: ldc.i4.1
    IL_0019: bge.s IL_002c
    IL_001b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0020: ldc.r4 1.5f
    IL_0025: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_002a: br.s IL_006b
    IL_002c: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0031: ldc.r4 1.5f
    IL_0036: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003b: ldc.r4 0f
    IL_0040: ldc.r4 45f
    IL_0045: ldloc.0
    IL_0046: conv.r4
    IL_0047: mul
    IL_0048: ldc.r4 0f
    IL_004d: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0052: call Vector3 UnityEngine.Vector3::get_forward()  /*0x0A000278*/
    IL_0057: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_005c: ldc.r4 2f
    IL_0061: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0066: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006b: stloc.1
    IL_006c: ldarg.0
    IL_006d: ldfld GameObject ThiefController::_coinPrefab  /*0x0400076E*/
    IL_0072: ldarg.0
    IL_0073: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0078: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007d: ldloc.1
    IL_007e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0083: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0088: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_008d: ldloca.s 2
    IL_008f: callvirt bool UnityEngine.GameObject::TryGetComponent(ref !!0)<Coin>  /*0x2B00004B*/
    IL_0094: pop
    IL_0095: ldloc.0
    IL_0096: ldc.i4.1
    IL_0097: add
    IL_0098: stloc.0
    IL_0099: ldloc.0
    IL_009a: ldarg.0
    IL_009b: ldfld int ThiefController::_actualStolenAmount  /*0x04000771*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld int ThiefController::_bonus  /*0x0400076C*/
    IL_00a6: add
    IL_00a7: blt IL_0017
    IL_00ac: ret

  .method ThiefController::Eliminate()  // token 0x06000606 rva 0x13794 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_000b: ret

  .method ThiefController::Update()  // token 0x06000607 rva 0x19728 attrs Private, HideBySig
    // code size 187 (0xbb), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call bool ThiefController::get_IsStealing()  /*0x06000603*/
    IL_0006: brfalse IL_0099
    IL_000b: ldarg.0
    IL_000c: ldfld PathfindMovementThief ThiefController::_pathfindMovement  /*0x04000774*/
    IL_0011: callvirt bool PathfindMovementThief::AtTarget()  /*0x060005B5*/
    IL_0016: brfalse.s IL_0066
    IL_0018: ldarg.0
    IL_0019: ldfld bool ThiefController::_wasAtTarget  /*0x0400076F*/
    IL_001e: brtrue.s IL_0032
    IL_0020: ldarg.0
    IL_0021: ldfld UnityEvent<bool> ThiefController::onStealingTarget  /*0x04000776*/
    IL_0026: dup
    IL_0027: brtrue.s IL_002c
    IL_0029: pop
    IL_002a: br.s IL_0032
    IL_002c: ldc.i4.1
    IL_002d: call void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0032: ldarg.0
    IL_0033: ldc.i4.1
    IL_0034: stfld bool ThiefController::_wasAtTarget  /*0x0400076F*/
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_0040: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0045: sub
    IL_0046: stfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_004b: ldarg.0
    IL_004c: call void ThiefController::DisableKnockback()  /*0x06000609*/
    IL_0051: ldarg.0
    IL_0052: ldfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_0057: ldc.r4 0f
    IL_005c: bge.un.s IL_0099
    IL_005e: ldarg.0
    IL_005f: call void ThiefController::Steal()  /*0x06000608*/
    IL_0064: br.s IL_0099
    IL_0066: ldarg.0
    IL_0067: ldfld bool ThiefController::_wasAtTarget  /*0x0400076F*/
    IL_006c: brfalse.s IL_0099
    IL_006e: ldarg.0
    IL_006f: ldfld UnityEvent<bool> ThiefController::onStealingTarget  /*0x04000776*/
    IL_0074: dup
    IL_0075: brtrue.s IL_007a
    IL_0077: pop
    IL_0078: br.s IL_0080
    IL_007a: ldc.i4.0
    IL_007b: call void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0080: ldarg.0
    IL_0081: ldc.i4.0
    IL_0082: stfld bool ThiefController::_wasAtTarget  /*0x0400076F*/
    IL_0087: ldarg.0
    IL_0088: ldarg.0
    IL_0089: ldfld float ThiefController::_holdDuration  /*0x0400076D*/
    IL_008e: stfld float ThiefController::_holdTimer  /*0x04000770*/
    IL_0093: ldarg.0
    IL_0094: call void ThiefController::EnableKnockback()  /*0x0600060A*/
    IL_0099: ldarg.0
    IL_009a: call bool ThiefController::get_IsComingHome()  /*0x06000602*/
    IL_009f: brfalse.s IL_00ba
    IL_00a1: ldarg.0
    IL_00a2: call void ThiefController::EnableKnockback()  /*0x0600060A*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld PathfindMovementThief ThiefController::_pathfindMovement  /*0x04000774*/
    IL_00ad: callvirt bool PathfindMovementThief::AtHome()  /*0x060005B6*/
    IL_00b2: brfalse.s IL_00ba
    IL_00b4: ldarg.0
    IL_00b5: call void ThiefController::Eliminate()  /*0x06000606*/
    IL_00ba: ret

  .method ThiefController::Steal()  // token 0x06000608 rva 0x197f0 attrs Private, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    .locals ([0] PlayerInteraction)
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld int ThiefController::_theftAmount  /*0x0400076B*/
    IL_000d: ldloc.0
    IL_000e: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0013: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_0018: stfld int ThiefController::_actualStolenAmount  /*0x04000771*/
    IL_001d: ldarg.0
    IL_001e: ldfld int ThiefController::_actualStolenAmount  /*0x04000771*/
    IL_0023: ldc.i4.0
    IL_0024: ble.s IL_0032
    IL_0026: ldloc.0
    IL_0027: ldarg.0
    IL_0028: ldfld int ThiefController::_actualStolenAmount  /*0x04000771*/
    IL_002d: callvirt void PlayerInteraction::SpendCoins(int)  /*0x06000C0F*/
    IL_0032: ldarg.0
    IL_0033: ldfld UnityEvent ThiefController::onSteal  /*0x04000777*/
    IL_0038: dup
    IL_0039: brtrue.s IL_003e
    IL_003b: pop
    IL_003c: br.s IL_0043
    IL_003e: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0043: ldarg.0
    IL_0044: ldfld UnityEvent<bool> ThiefController::onStealingTarget  /*0x04000776*/
    IL_0049: dup
    IL_004a: brtrue.s IL_004e
    IL_004c: pop
    IL_004d: ret
    IL_004e: ldc.i4.0
    IL_004f: call void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0054: ret

  .method ThiefController::DisableKnockback()  // token 0x06000609 rva 0x19851 attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0026
    IL_000d: ldarg.0
    IL_000e: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0013: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0018: brfalse.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0026: ret

  .method ThiefController::EnableKnockback()  // token 0x0600060A rva 0x19879 attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0026
    IL_000d: ldarg.0
    IL_000e: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0013: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0018: brtrue.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld KnockbackBehavior ThiefController::_knockbackBehavior  /*0x04000775*/
    IL_0020: ldc.i4.1
    IL_0021: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0026: ret

  .method ThiefController::.ctor()  // token 0x0600060B rva 0x198a1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int ThiefController::_theftAmount  /*0x0400076B*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 5f
    IL_000d: stfld float ThiefController::_holdDuration  /*0x0400076D*/
    IL_0012: ldarg.0
    IL_0013: newobj void UnityEngine.Events.UnityEvent<bool>::.ctor()  /*0x0A00027C*/
    IL_0018: stfld UnityEvent<bool> ThiefController::onStealingTarget  /*0x04000776*/
    IL_001d: ldarg.0
    IL_001e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0023: stfld UnityEvent ThiefController::onSteal  /*0x04000777*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002e: ret

