// ===== QuickslingBarrelRotator  (token 0x02000035) =====
  .method QuickslingBarrelRotator::Start()  // token 0x0600010F rva 0x6384 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack QuickslingBarrelRotator::attack  /*0x0400013D*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack QuickslingBarrelRotator::attack  /*0x0400013D*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void QuickslingBarrelRotator::OnAttack()  /*0x06000111*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld Transform QuickslingBarrelRotator::transformToRotate  /*0x0400013C*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0035: stfld Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_003a: ret

  .method QuickslingBarrelRotator::Update()  // token 0x06000110 rva 0x63c0 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform QuickslingBarrelRotator::transformToRotate  /*0x0400013C*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_000b: ldarg.0
    IL_000c: ldfld Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_0011: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_0016: ldc.r4 3f
    IL_001b: ble.un.s IL_004a
    IL_001d: ldarg.0
    IL_001e: ldfld Transform QuickslingBarrelRotator::transformToRotate  /*0x0400013C*/
    IL_0023: ldarg.0
    IL_0024: ldfld Transform QuickslingBarrelRotator::transformToRotate  /*0x0400013C*/
    IL_0029: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_0034: ldarg.0
    IL_0035: ldflda Vector3 QuickslingBarrelRotator::angularVelocityRef  /*0x04000140*/
    IL_003a: ldarg.0
    IL_003b: ldfld float QuickslingBarrelRotator::attackSmoothTime  /*0x0400013E*/
    IL_0040: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_0045: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_004a: ret

  .method QuickslingBarrelRotator::OnAttack()  // token 0x06000111 rva 0x6417 attrs Private, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld AutoAttack QuickslingBarrelRotator::attack  /*0x0400013D*/
    IL_0007: callvirt Vector3 AutoAttack::get_LastTargetPosition()  /*0x06000230*/
    IL_000c: ldarg.0
    IL_000d: ldfld Transform QuickslingBarrelRotator::transformToRotate  /*0x0400013C*/
    IL_0012: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0017: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001c: stfld Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_0021: ldarg.0
    IL_0022: ldflda Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_0027: ldc.r4 0f
    IL_002c: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0031: ldarg.0
    IL_0032: ldflda Vector3 QuickslingBarrelRotator::desiredForward  /*0x0400013F*/
    IL_0037: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_003c: ret

  .method QuickslingBarrelRotator::.ctor()  // token 0x06000112 rva 0x6455 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.05f
    IL_0006: stfld float QuickslingBarrelRotator::attackSmoothTime  /*0x0400013E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.5f
    IL_0011: stfld float QuickslingBarrelRotator::minSqVelocity  /*0x04000141*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

