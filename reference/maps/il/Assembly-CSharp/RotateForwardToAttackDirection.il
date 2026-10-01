// ===== RotateForwardToAttackDirection  (token 0x02000037) =====
  .method RotateForwardToAttackDirection::Start()  // token 0x06000115 rva 0x64fc attrs Private, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_000c: stfld Vector3 RotateForwardToAttackDirection::originalForward  /*0x0400014E*/
    IL_0011: ldarg.0
    IL_0012: ldfld AutoAttack RotateForwardToAttackDirection::attack  /*0x04000147*/
    IL_0017: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_001c: ldarg.0
    IL_001d: ldftn void RotateForwardToAttackDirection::OnAttack()  /*0x06000117*/
    IL_0023: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0028: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 RotateForwardToAttackDirection::originalForward  /*0x0400014E*/
    IL_0034: stfld Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0039: ret

  .method RotateForwardToAttackDirection::Update()  // token 0x06000116 rva 0x6538 attrs Private, HideBySig
    // code size 149 (0x95), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_000b: ldarg.0
    IL_000c: ldfld Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0011: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_0016: ldc.r4 3f
    IL_001b: ble.un.s IL_0081
    IL_001d: ldarg.0
    IL_001e: ldfld bool RotateForwardToAttackDirection::attackOverride  /*0x0400014D*/
    IL_0023: brfalse.s IL_0053
    IL_0025: ldarg.0
    IL_0026: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_002b: ldarg.0
    IL_002c: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_0031: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0036: ldarg.0
    IL_0037: ldfld Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_003c: ldarg.0
    IL_003d: ldflda Vector3 RotateForwardToAttackDirection::angularVelocityRef  /*0x0400014B*/
    IL_0042: ldarg.0
    IL_0043: ldfld float RotateForwardToAttackDirection::attackSmoothTime  /*0x04000148*/
    IL_0048: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_004d: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0052: ret
    IL_0053: ldarg.0
    IL_0054: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_0059: ldarg.0
    IL_005a: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_005f: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0064: ldarg.0
    IL_0065: ldfld Vector3 RotateForwardToAttackDirection::originalForward  /*0x0400014E*/
    IL_006a: ldarg.0
    IL_006b: ldflda Vector3 RotateForwardToAttackDirection::angularVelocityRef  /*0x0400014B*/
    IL_0070: ldarg.0
    IL_0071: ldfld float RotateForwardToAttackDirection::regularSmoothTime  /*0x04000149*/
    IL_0076: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_007b: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldc.i4.0
    IL_0083: stfld bool RotateForwardToAttackDirection::attackOverride  /*0x0400014D*/
    IL_0088: ldarg.0
    IL_0089: ldarg.0
    IL_008a: ldfld Vector3 RotateForwardToAttackDirection::originalForward  /*0x0400014E*/
    IL_008f: stfld Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0094: ret

  .method RotateForwardToAttackDirection::OnAttack()  // token 0x06000117 rva 0x65dc attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld AutoAttack RotateForwardToAttackDirection::attack  /*0x04000147*/
    IL_0007: callvirt Vector3 AutoAttack::get_LastTargetPosition()  /*0x06000230*/
    IL_000c: ldarg.0
    IL_000d: ldfld Transform RotateForwardToAttackDirection::transformToRotate  /*0x04000146*/
    IL_0012: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001c: stfld Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0021: ldarg.0
    IL_0022: ldflda Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0027: ldc.r4 0f
    IL_002c: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0031: ldarg.0
    IL_0032: ldflda Vector3 RotateForwardToAttackDirection::desiredForward  /*0x0400014A*/
    IL_0037: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_003c: ldarg.0
    IL_003d: ldc.i4.1
    IL_003e: stfld bool RotateForwardToAttackDirection::attackOverride  /*0x0400014D*/
    IL_0043: ret

  .method RotateForwardToAttackDirection::.ctor()  // token 0x06000118 rva 0x662c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.05f
    IL_0006: stfld float RotateForwardToAttackDirection::attackSmoothTime  /*0x04000148*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.25f
    IL_0011: stfld float RotateForwardToAttackDirection::regularSmoothTime  /*0x04000149*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.5f
    IL_001c: stfld float RotateForwardToAttackDirection::minSqVelocity  /*0x0400014C*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

