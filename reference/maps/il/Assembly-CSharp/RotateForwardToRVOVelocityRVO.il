// ===== RotateForwardToRVOVelocityRVO  (token 0x02000039) =====
  .method RotateForwardToRVOVelocityRVO::Start()  // token 0x06000120 rva 0x68e5 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack RotateForwardToRVOVelocityRVO::attack  /*0x0400015D*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack RotateForwardToRVOVelocityRVO::attack  /*0x0400015D*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void RotateForwardToRVOVelocityRVO::OnAttack()  /*0x06000122*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0035: stfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_003a: ret

  .method RotateForwardToRVOVelocityRVO::Update()  // token 0x06000121 rva 0x6924 attrs Private, HideBySig
    // code size 259 (0x103), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld RVOController RotateForwardToRVOVelocityRVO::target  /*0x0400015C*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_007a
    IL_000d: ldarg.0
    IL_000e: ldfld RVOController RotateForwardToRVOVelocityRVO::target  /*0x0400015C*/
    IL_0013: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_001d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld Vector3 RotateForwardToRVOVelocityRVO::lastPosition  /*0x04000165*/
    IL_002a: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_002f: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0034: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0039: stloc.1
    IL_003a: ldloca.s 1
    IL_003c: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0041: ldarg.0
    IL_0042: ldloc.0
    IL_0043: stfld Vector3 RotateForwardToRVOVelocityRVO::lastPosition  /*0x04000165*/
    IL_0048: ldarg.0
    IL_0049: ldfld float RotateForwardToRVOVelocityRVO::minSqVelocity  /*0x04000163*/
    IL_004e: ble.un.s IL_007a
    IL_0050: ldarg.0
    IL_0051: ldfld bool RotateForwardToRVOVelocityRVO::attackOverride  /*0x04000164*/
    IL_0056: brtrue.s IL_007a
    IL_0058: ldarg.0
    IL_0059: ldloc.1
    IL_005a: stfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_005f: ldarg.0
    IL_0060: ldflda Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_0065: ldc.r4 0f
    IL_006a: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_006f: ldarg.0
    IL_0070: ldflda Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_0075: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_007a: ldarg.0
    IL_007b: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_0080: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0085: ldarg.0
    IL_0086: ldfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_008b: call float UnityEngine.Vector3::Angle(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0000AD*/
    IL_0090: ldc.r4 3f
    IL_0095: ble.un.s IL_00fb
    IL_0097: ldarg.0
    IL_0098: ldfld bool RotateForwardToRVOVelocityRVO::attackOverride  /*0x04000164*/
    IL_009d: brfalse.s IL_00cd
    IL_009f: ldarg.0
    IL_00a0: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_00ab: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_00b6: ldarg.0
    IL_00b7: ldflda Vector3 RotateForwardToRVOVelocityRVO::angularVelocityRef  /*0x04000162*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld float RotateForwardToRVOVelocityRVO::attackSmoothTime  /*0x0400015F*/
    IL_00c2: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_00c7: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_00cc: ret
    IL_00cd: ldarg.0
    IL_00ce: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_00d3: ldarg.0
    IL_00d4: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_00d9: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_00de: ldarg.0
    IL_00df: ldfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_00e4: ldarg.0
    IL_00e5: ldflda Vector3 RotateForwardToRVOVelocityRVO::angularVelocityRef  /*0x04000162*/
    IL_00ea: ldarg.0
    IL_00eb: ldfld float RotateForwardToRVOVelocityRVO::regularSmoothTime  /*0x0400015E*/
    IL_00f0: call Vector3 UnityEngine.Vector3::SmoothDamp(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.Vector3,float)  /*0x0A0000AE*/
    IL_00f5: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_00fa: ret
    IL_00fb: ldarg.0
    IL_00fc: ldc.i4.0
    IL_00fd: stfld bool RotateForwardToRVOVelocityRVO::attackOverride  /*0x04000164*/
    IL_0102: ret

  .method RotateForwardToRVOVelocityRVO::OnAttack()  // token 0x06000122 rva 0x6a34 attrs Private, HideBySig
    // code size 77 (0x4d), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool RotateForwardToRVOVelocityRVO::ignoreAttack  /*0x04000160*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld AutoAttack RotateForwardToRVOVelocityRVO::attack  /*0x0400015D*/
    IL_0010: callvirt Vector3 AutoAttack::get_LastTargetPosition()  /*0x06000230*/
    IL_0015: ldarg.0
    IL_0016: ldfld Transform RotateForwardToRVOVelocityRVO::transformToRotate  /*0x0400015B*/
    IL_001b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0020: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0025: stfld Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_002a: ldarg.0
    IL_002b: ldflda Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_0030: ldc.r4 0f
    IL_0035: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_003a: ldarg.0
    IL_003b: ldflda Vector3 RotateForwardToRVOVelocityRVO::desiredForward  /*0x04000161*/
    IL_0040: call void UnityEngine.Vector3::Normalize()  /*0x0A0000A0*/
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: stfld bool RotateForwardToRVOVelocityRVO::attackOverride  /*0x04000164*/
    IL_004c: ret

  .method RotateForwardToRVOVelocityRVO::.ctor()  // token 0x06000123 rva 0x6a8d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float RotateForwardToRVOVelocityRVO::regularSmoothTime  /*0x0400015E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.05f
    IL_0011: stfld float RotateForwardToRVOVelocityRVO::attackSmoothTime  /*0x0400015F*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.5f
    IL_001c: stfld float RotateForwardToRVOVelocityRVO::minSqVelocity  /*0x04000163*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

