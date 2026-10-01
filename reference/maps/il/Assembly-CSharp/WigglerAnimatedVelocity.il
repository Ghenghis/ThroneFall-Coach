// ===== WigglerAnimatedVelocity  (token 0x02000032) =====
  .method WigglerAnimatedVelocity::Start()  // token 0x06000106 rva 0x61a9 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Wiggler>  /*0x2B000010*/
    IL_0007: stfld Wiggler WigglerAnimatedVelocity::wiggler  /*0x04000133*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Wiggler WigglerAnimatedVelocity::wiggler  /*0x04000133*/
    IL_0013: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0018: callvirt !!0 UnityEngine.Component::GetComponentInParent()<WigglerAnimationState>  /*0x2B000011*/
    IL_001d: stfld WigglerAnimationState WigglerAnimatedVelocity::wigglerAnimState  /*0x04000135*/
    IL_0022: ldarg.0
    IL_0023: ldc.r4 0f
    IL_0028: ldc.r4 1000f
    IL_002d: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0032: stfld float WigglerAnimatedVelocity::time  /*0x04000134*/
    IL_0037: ret

  .method WigglerAnimatedVelocity::Update()  // token 0x06000107 rva 0x61e2 attrs Private, HideBySig
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int WigglerAnimatedVelocity::stateCondition  /*0x04000130*/
    IL_0006: ldc.i4.m1
    IL_0007: bne.un.s IL_0010
    IL_0009: ldarg.0
    IL_000a: call void WigglerAnimatedVelocity::PerformUpdate()  /*0x06000108*/
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld WigglerAnimationState WigglerAnimatedVelocity::wigglerAnimState  /*0x04000135*/
    IL_0016: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001b: brfalse.s IL_0036
    IL_001d: ldarg.0
    IL_001e: ldfld WigglerAnimationState WigglerAnimatedVelocity::wigglerAnimState  /*0x04000135*/
    IL_0023: ldfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_0028: ldarg.0
    IL_0029: ldfld int WigglerAnimatedVelocity::stateCondition  /*0x04000130*/
    IL_002e: bne.un.s IL_0036
    IL_0030: ldarg.0
    IL_0031: call void WigglerAnimatedVelocity::PerformUpdate()  /*0x06000108*/
    IL_0036: ret

  .method WigglerAnimatedVelocity::PerformUpdate()  // token 0x06000108 rva 0x621c attrs Private, HideBySig
    // code size 118 (0x76), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld Wiggler WigglerAnimatedVelocity::wiggler  /*0x04000133*/
    IL_0006: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0011: brfalse.s IL_0075
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld float WigglerAnimatedVelocity::time  /*0x04000134*/
    IL_001a: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001f: ldarg.0
    IL_0020: ldfld float WigglerAnimatedVelocity::timeSpeed  /*0x04000132*/
    IL_0025: mul
    IL_0026: add
    IL_0027: stfld float WigglerAnimatedVelocity::time  /*0x04000134*/
    IL_002c: ldarg.0
    IL_002d: ldfld float WigglerAnimatedVelocity::time  /*0x04000134*/
    IL_0032: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_0037: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003c: mul
    IL_003d: stloc.0
    IL_003e: ldarg.0
    IL_003f: ldfld Wiggler WigglerAnimatedVelocity::wiggler  /*0x04000133*/
    IL_0044: dup
    IL_0045: callvirt Vector3 Wiggler::get_velocity()  /*0x06000101*/
    IL_004a: ldarg.0
    IL_004b: ldfld Wiggler WigglerAnimatedVelocity::wiggler  /*0x04000133*/
    IL_0050: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0055: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_005a: ldarg.0
    IL_005b: ldfld Vector3 WigglerAnimatedVelocity::direction  /*0x04000131*/
    IL_0060: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0065: ldloc.0
    IL_0066: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0070: callvirt void Wiggler::set_velocity(UnityEngine.Vector3)  /*0x06000102*/
    IL_0075: ret

  .method WigglerAnimatedVelocity::.ctor()  // token 0x06000109 rva 0x629e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int WigglerAnimatedVelocity::stateCondition  /*0x04000130*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 1f
    IL_000d: stfld float WigglerAnimatedVelocity::timeSpeed  /*0x04000132*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

