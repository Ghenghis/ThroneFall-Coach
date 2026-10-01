// ===== RotateForwardToRVOVelocity  (token 0x02000038) =====
  .method RotateForwardToRVOVelocity::get_IsMoving()  // token 0x06000119 rva 0x6655 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool RotateForwardToRVOVelocity::<IsMoving>k__BackingField  /*0x04000155*/
    IL_0006: ret

  .method RotateForwardToRVOVelocity::set_IsMoving(bool)  // token 0x0600011A rva 0x665d attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool RotateForwardToRVOVelocity::<IsMoving>k__BackingField  /*0x04000155*/
    IL_0007: ret

  .method RotateForwardToRVOVelocity::ReInitWithAttack(AutoAttack)  // token 0x0600011B rva 0x6668 attrs Public, HideBySig
    // code size 92 (0x5c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002a
    IL_000e: ldarg.0
    IL_000f: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0014: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0019: ldarg.0
    IL_001a: ldftn void RotateForwardToRVOVelocity::OnAttack()  /*0x0600011E*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_002a: ldarg.0
    IL_002b: ldarg.1
    IL_002c: stfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0031: ldarg.0
    IL_0032: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0037: ldnull
    IL_0038: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003d: brfalse.s IL_005b
    IL_003f: ldarg.0
    IL_0040: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0045: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_004a: ldarg.0
    IL_004b: ldftn void RotateForwardToRVOVelocity::OnAttack()  /*0x0600011E*/
    IL_0051: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0056: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_005b: ret

  .method RotateForwardToRVOVelocity::Start()  // token 0x0600011C rva 0x66d0 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void RotateForwardToRVOVelocity::OnAttack()  /*0x0600011E*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0035: stfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_003a: ret

  .method RotateForwardToRVOVelocity::Update()  // token 0x0600011D rva 0x670c attrs Private, HideBySig
    // code size 337 (0x151), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovement RotateForwardToRVOVelocity::target  /*0x04000151*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse IL_00a0
    IL_0010: ldarg.0
    IL_0011: ldfld PathfindMovement RotateForwardToRVOVelocity::target  /*0x04000151*/
    IL_0016: callvirt RVOController PathfindMovement::get_RVO()  /*0x06000B0A*/
    IL_001b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0020: brfalse.s IL_00a0
    IL_0022: ldarg.0
    IL_0023: ldfld PathfindMovement RotateForwardToRVOVelocity::target  /*0x04000151*/
    IL_0028: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002d: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0032: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0037: stloc.0
    IL_0038: ldloc.0
    IL_0039: ldarg.0
    IL_003a: ldfld Vector3 RotateForwardToRVOVelocity::lastPosition  /*0x0400015A*/
    IL_003f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0044: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0049: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_004e: stloc.1
    IL_004f: ldloca.s 1
    IL_0051: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0056: stloc.2
    IL_0057: ldarg.0
    IL_0058: ldloc.0
    IL_0059: stfld Vector3 RotateForwardToRVOVelocity::lastPosition  /*0x0400015A*/
    IL_005e: ldloc.2
    IL_005f: ldarg.0
    IL_0060: ldfld float RotateForwardToRVOVelocity::minSqVelocity  /*0x04000158*/
    IL_0065: ble.un.s IL_0091
    IL_0067: ldarg.0
    IL_0068: ldfld bool RotateForwardToRVOVelocity::attackOverride  /*0x04000159*/
    IL_006d: brtrue.s IL_0091
    IL_006f: ldarg.0
    IL_0070: ldloc.1
    IL_0071: stfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_0076: ldarg.0
    IL_0077: ldflda Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_007c: ldc.r4 0f
    IL_0081: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0086: ldarg.0
    IL_0087: ldflda Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_008c: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_0091: ldarg.0
    IL_0092: ldloc.2
    IL_0093: ldarg.0
    IL_0094: ldfld float RotateForwardToRVOVelocity::minSqVelocity  /*0x04000158*/
    IL_0099: cgt
    IL_009b: call void RotateForwardToRVOVelocity::set_IsMoving(bool)  /*0x0600011A*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_00a6: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_00b1: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_00b6: ldc.r4 3f
    IL_00bb: ble.un IL_0149
    IL_00c0: ldarg.0
    IL_00c1: ldfld bool RotateForwardToRVOVelocity::attackOverride  /*0x04000159*/
    IL_00c6: brfalse.s IL_00f7
    IL_00c8: ldarg.0
    IL_00c9: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_00d4: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_00d9: ldarg.0
    IL_00da: ldfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_00df: ldarg.0
    IL_00e0: ldflda Vector3 RotateForwardToRVOVelocity::angularVelocityRef  /*0x04000157*/
    IL_00e5: ldarg.0
    IL_00e6: ldfld float RotateForwardToRVOVelocity::attackSmoothTime  /*0x04000154*/
    IL_00eb: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_00f0: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_00f5: br.s IL_0124
    IL_00f7: ldarg.0
    IL_00f8: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_00fd: ldarg.0
    IL_00fe: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_0103: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0108: ldarg.0
    IL_0109: ldfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_010e: ldarg.0
    IL_010f: ldflda Vector3 RotateForwardToRVOVelocity::angularVelocityRef  /*0x04000157*/
    IL_0114: ldarg.0
    IL_0115: ldfld float RotateForwardToRVOVelocity::regularSmoothTime  /*0x04000153*/
    IL_011a: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_011f: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0124: ldarg.0
    IL_0125: ldfld Transform RotateForwardToRVOVelocity::transformToRotateArach  /*0x04000150*/
    IL_012a: ldnull
    IL_012b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0130: brfalse.s IL_0150
    IL_0132: ldarg.0
    IL_0133: ldfld Transform RotateForwardToRVOVelocity::transformToRotateArach  /*0x04000150*/
    IL_0138: ldarg.0
    IL_0139: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_013e: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0143: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0148: ret
    IL_0149: ldarg.0
    IL_014a: ldc.i4.0
    IL_014b: stfld bool RotateForwardToRVOVelocity::attackOverride  /*0x04000159*/
    IL_0150: ret

  .method RotateForwardToRVOVelocity::OnAttack()  // token 0x0600011E rva 0x686c attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld AutoAttack RotateForwardToRVOVelocity::attack  /*0x04000152*/
    IL_0007: callvirt Vector3 AutoAttack::get_LastTargetPosition()  /*0x06000230*/
    IL_000c: ldarg.0
    IL_000d: ldfld Transform RotateForwardToRVOVelocity::transformToRotate  /*0x0400014F*/
    IL_0012: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001c: stfld Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_0021: ldarg.0
    IL_0022: ldflda Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_0027: ldc.r4 0f
    IL_002c: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0031: ldarg.0
    IL_0032: ldflda Vector3 RotateForwardToRVOVelocity::desiredForward  /*0x04000156*/
    IL_0037: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_003c: ldarg.0
    IL_003d: ldc.i4.1
    IL_003e: stfld bool RotateForwardToRVOVelocity::attackOverride  /*0x04000159*/
    IL_0043: ret

  .method RotateForwardToRVOVelocity::.ctor()  // token 0x0600011F rva 0x68bc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float RotateForwardToRVOVelocity::regularSmoothTime  /*0x04000153*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.05f
    IL_0011: stfld float RotateForwardToRVOVelocity::attackSmoothTime  /*0x04000154*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.5f
    IL_001c: stfld float RotateForwardToRVOVelocity::minSqVelocity  /*0x04000158*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

