// ===== RotateToAttackTarget  (token 0x0200011E) =====
  .method RotateToAttackTarget::ReInitWithAttack(AutoAttack)  // token 0x060005DB rva 0x18f50 attrs Public, HideBySig
    // code size 92 (0x5c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002a
    IL_000e: ldarg.0
    IL_000f: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0014: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0019: ldarg.0
    IL_001a: ldftn void RotateToAttackTarget::OnAttack()  /*0x060005DE*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_002a: ldarg.0
    IL_002b: ldarg.1
    IL_002c: stfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0031: ldarg.0
    IL_0032: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0037: ldnull
    IL_0038: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003d: brfalse.s IL_005b
    IL_003f: ldarg.0
    IL_0040: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0045: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_004a: ldarg.0
    IL_004b: ldftn void RotateToAttackTarget::OnAttack()  /*0x060005DE*/
    IL_0051: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0056: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_005b: ret

  .method RotateToAttackTarget::Start()  // token 0x060005DC rva 0x18fb8 attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_000c: stfld Vector3 RotateToAttackTarget::desiredForward  /*0x04000750*/
    IL_0011: ldarg.0
    IL_0012: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001d: brfalse.s IL_003b
    IL_001f: ldarg.0
    IL_0020: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0025: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_002a: ldarg.0
    IL_002b: ldftn void RotateToAttackTarget::OnAttack()  /*0x060005DE*/
    IL_0031: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0036: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_003b: ret

  .method RotateToAttackTarget::Update()  // token 0x060005DD rva 0x18ff8 attrs Private, HideBySig
    // code size 191 (0xbf), max stack 5, init locals
    .locals ([0] Vector3, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldfld bool RotateToAttackTarget::isAttacking  /*0x04000752*/
    IL_0006: brtrue.s IL_0059
    IL_0008: ldarg.0
    IL_0009: ldfld PathfindMovementEnemy RotateToAttackTarget::movement  /*0x0400074C*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0059
    IL_0016: ldarg.0
    IL_0017: ldfld PathfindMovementEnemy RotateToAttackTarget::movement  /*0x0400074C*/
    IL_001c: callvirt Vector3 PathfindMovementEnemy::get_NextPathPoint()  /*0x06000B11*/
    IL_0021: ldarg.0
    IL_0022: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_0027: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0031: stloc.0
    IL_0032: ldloca.s 0
    IL_0034: ldc.r4 0f
    IL_0039: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_003e: ldloca.s 0
    IL_0040: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0045: ldc.r4 1f
    IL_004a: ble.un.s IL_0059
    IL_004c: ldarg.0
    IL_004d: ldloca.s 0
    IL_004f: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0054: stfld Vector3 RotateToAttackTarget::desiredForward  /*0x04000750*/
    IL_0059: ldarg.0
    IL_005a: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_005f: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0064: ldarg.0
    IL_0065: ldfld Vector3 RotateToAttackTarget::desiredForward  /*0x04000750*/
    IL_006a: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_006f: ldarg.0
    IL_0070: ldfld float RotateToAttackTarget::angleThresholdInDegrees  /*0x04000753*/
    IL_0075: ble.un.s IL_00b7
    IL_0077: ldarg.0
    IL_0078: ldfld bool RotateToAttackTarget::isAttacking  /*0x04000752*/
    IL_007d: brtrue.s IL_0087
    IL_007f: ldarg.0
    IL_0080: ldfld float RotateToAttackTarget::movementSmoothTime  /*0x0400074E*/
    IL_0085: br.s IL_008d
    IL_0087: ldarg.0
    IL_0088: ldfld float RotateToAttackTarget::attackSmoothTime  /*0x0400074F*/
    IL_008d: stloc.1
    IL_008e: ldarg.0
    IL_008f: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_0094: ldarg.0
    IL_0095: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_009a: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_009f: ldarg.0
    IL_00a0: ldfld Vector3 RotateToAttackTarget::desiredForward  /*0x04000750*/
    IL_00a5: ldarg.0
    IL_00a6: ldflda Vector3 RotateToAttackTarget::angularVelocityRef  /*0x04000751*/
    IL_00ab: ldloc.1
    IL_00ac: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_00b1: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_00b6: ret
    IL_00b7: ldarg.0
    IL_00b8: ldc.i4.0
    IL_00b9: stfld bool RotateToAttackTarget::isAttacking  /*0x04000752*/
    IL_00be: ret

  .method RotateToAttackTarget::OnAttack()  // token 0x060005DE rva 0x190c4 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack RotateToAttackTarget::attack  /*0x0400074D*/
    IL_0006: callvirt Vector3 AutoAttack::get_LastTargetPosition()  /*0x06000230*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform RotateToAttackTarget::transformToRotate  /*0x0400074B*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001b: stloc.0
    IL_001c: ldloca.s 0
    IL_001e: ldc.r4 0f
    IL_0023: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0028: ldloca.s 0
    IL_002a: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_002f: ldc.r4 0.001f
    IL_0034: ble.un.s IL_0043
    IL_0036: ldarg.0
    IL_0037: ldloca.s 0
    IL_0039: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_003e: stfld Vector3 RotateToAttackTarget::desiredForward  /*0x04000750*/
    IL_0043: ldarg.0
    IL_0044: ldc.i4.1
    IL_0045: stfld bool RotateToAttackTarget::isAttacking  /*0x04000752*/
    IL_004a: ret

  .method RotateToAttackTarget::.ctor()  // token 0x060005DF rva 0x1911b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.3f
    IL_0006: stfld float RotateToAttackTarget::movementSmoothTime  /*0x0400074E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.1f
    IL_0011: stfld float RotateToAttackTarget::attackSmoothTime  /*0x0400074F*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 3f
    IL_001c: stfld float RotateToAttackTarget::angleThresholdInDegrees  /*0x04000753*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

