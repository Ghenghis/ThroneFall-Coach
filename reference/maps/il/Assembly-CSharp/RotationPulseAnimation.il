// ===== RotationPulseAnimation  (token 0x020000C2) =====
  .method RotationPulseAnimation::Start()  // token 0x0600040A rva 0x116f8 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_000c: stfld Quaternion RotationPulseAnimation::_startRotation  /*0x04000539*/
    IL_0011: ldarg.0
    IL_0012: ldfld bool RotationPulseAnimation::_randomizeClock  /*0x04000536*/
    IL_0017: brfalse.s IL_0024
    IL_0019: ldarg.0
    IL_001a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_001f: stfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_0024: ret

  .method RotationPulseAnimation::Update()  // token 0x0600040B rva 0x11720 attrs Private, HideBySig
    // code size 196 (0xc4), max stack 4, init locals
    .locals ([0] Quaternion, [1] Vector3, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool RotationPulseAnimation::_onlyIfMoving  /*0x04000535*/
    IL_0006: brfalse.s IL_0044
    IL_0008: ldarg.0
    IL_0009: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0013: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0018: stloc.1
    IL_0019: ldloc.1
    IL_001a: ldarg.0
    IL_001b: ldfld Vector3 RotationPulseAnimation::lastPosition  /*0x0400053B*/
    IL_0020: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0025: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_002a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_002f: stloc.2
    IL_0030: ldarg.0
    IL_0031: ldloca.s 2
    IL_0033: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0038: stfld float RotationPulseAnimation::rvoVelSqrMag  /*0x0400053C*/
    IL_003d: ldarg.0
    IL_003e: ldloc.1
    IL_003f: stfld Vector3 RotationPulseAnimation::lastPosition  /*0x0400053B*/
    IL_0044: ldarg.0
    IL_0045: ldfld bool RotationPulseAnimation::_onlyIfMoving  /*0x04000535*/
    IL_004a: brfalse.s IL_005a
    IL_004c: ldarg.0
    IL_004d: ldfld float RotationPulseAnimation::rvoVelSqrMag  /*0x0400053C*/
    IL_0052: ldarg.0
    IL_0053: ldfld float RotationPulseAnimation::_velocitySqrtDeadzone  /*0x04000538*/
    IL_0058: ble.un.s IL_0073
    IL_005a: ldarg.0
    IL_005b: ldarg.0
    IL_005c: ldfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_0061: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0066: ldarg.0
    IL_0067: ldfld float RotationPulseAnimation::_pulseSpeed  /*0x04000534*/
    IL_006c: mul
    IL_006d: add
    IL_006e: stfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_0073: ldarg.0
    IL_0074: ldfld AnimationCurve RotationPulseAnimation::xRotation  /*0x04000531*/
    IL_0079: ldarg.0
    IL_007a: ldfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_007f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0084: ldarg.0
    IL_0085: ldfld AnimationCurve RotationPulseAnimation::yRotation  /*0x04000532*/
    IL_008a: ldarg.0
    IL_008b: ldfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_0090: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0095: ldarg.0
    IL_0096: ldfld AnimationCurve RotationPulseAnimation::zRotation  /*0x04000533*/
    IL_009b: ldarg.0
    IL_009c: ldfld float RotationPulseAnimation::_clock  /*0x04000537*/
    IL_00a1: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00a6: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_00ab: stloc.0
    IL_00ac: ldarg.0
    IL_00ad: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld Quaternion RotationPulseAnimation::_startRotation  /*0x04000539*/
    IL_00b8: ldloc.0
    IL_00b9: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_00be: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_00c3: ret

  .method RotationPulseAnimation::.ctor()  // token 0x0600040C rva 0x117f0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float RotationPulseAnimation::_pulseSpeed  /*0x04000534*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.15f
    IL_0011: stfld float RotationPulseAnimation::_velocitySqrtDeadzone  /*0x04000538*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

