// ===== WigglerVelocity  (token 0x02000034) =====
  .method WigglerVelocity::Start()  // token 0x0600010B rva 0x62c7 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Wiggler>  /*0x2B000010*/
    IL_0007: stfld Wiggler WigglerVelocity::wiggler  /*0x04000139*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Wiggler WigglerVelocity::wiggler  /*0x04000139*/
    IL_0013: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0018: callvirt !!0 UnityEngine.Component::GetComponentInParent()<WigglerAnimationState>  /*0x2B000011*/
    IL_001d: stfld WigglerAnimationState WigglerVelocity::wigglerAnimState  /*0x0400013B*/
    IL_0022: ldarg.0
    IL_0023: ldc.r4 0f
    IL_0028: ldc.r4 1000f
    IL_002d: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0032: stfld float WigglerVelocity::time  /*0x0400013A*/
    IL_0037: ret

  .method WigglerVelocity::Update()  // token 0x0600010C rva 0x6300 attrs Private, HideBySig
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int WigglerVelocity::stateCondition  /*0x04000137*/
    IL_0006: ldc.i4.m1
    IL_0007: bne.un.s IL_0010
    IL_0009: ldarg.0
    IL_000a: call void WigglerVelocity::PerformUpdate()  /*0x0600010D*/
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld WigglerAnimationState WigglerVelocity::wigglerAnimState  /*0x0400013B*/
    IL_0016: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001b: brfalse.s IL_0036
    IL_001d: ldarg.0
    IL_001e: ldfld WigglerAnimationState WigglerVelocity::wigglerAnimState  /*0x0400013B*/
    IL_0023: ldfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_0028: ldarg.0
    IL_0029: ldfld int WigglerVelocity::stateCondition  /*0x04000137*/
    IL_002e: bne.un.s IL_0036
    IL_0030: ldarg.0
    IL_0031: call void WigglerVelocity::PerformUpdate()  /*0x0600010D*/
    IL_0036: ret

  .method WigglerVelocity::PerformUpdate()  // token 0x0600010D rva 0x6338 attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Wiggler WigglerVelocity::wiggler  /*0x04000139*/
    IL_0006: dup
    IL_0007: callvirt Vector3 Wiggler::get_velocity()  /*0x06000101*/
    IL_000c: ldarg.0
    IL_000d: ldfld Wiggler WigglerVelocity::wiggler  /*0x04000139*/
    IL_0012: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0017: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_001c: ldarg.0
    IL_001d: ldfld Vector3 WigglerVelocity::direction  /*0x04000138*/
    IL_0022: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0027: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002c: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0031: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0036: callvirt void Wiggler::set_velocity(UnityEngine.Vector3)  /*0x06000102*/
    IL_003b: ret

  .method WigglerVelocity::.ctor()  // token 0x0600010E rva 0x6375 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int WigglerVelocity::stateCondition  /*0x04000137*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

