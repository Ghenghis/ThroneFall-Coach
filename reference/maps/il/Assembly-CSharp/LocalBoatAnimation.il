// ===== LocalBoatAnimation  (token 0x020000BF) =====
  .method LocalBoatAnimation::Start()  // token 0x060003FD rva 0x11497 attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: ldc.r4 10000f
    IL_000b: mul
    IL_000c: stfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_001d: stfld Vector3 LocalBoatAnimation::startPosition  /*0x04000520*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0029: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_002e: stfld Quaternion LocalBoatAnimation::startRotation  /*0x04000521*/
    IL_0033: ret

  .method LocalBoatAnimation::Update()  // token 0x060003FE rva 0x114cc attrs Private, HideBySig
    // code size 148 (0x94), max stack 5, init locals
    .locals ([0] Quaternion)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_0012: ldarg.0
    IL_0013: ldfld AnimationCurve LocalBoatAnimation::xRotation  /*0x04000524*/
    IL_0018: ldarg.0
    IL_0019: ldfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_001e: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0023: ldarg.0
    IL_0024: ldfld AnimationCurve LocalBoatAnimation::yRotation  /*0x04000525*/
    IL_0029: ldarg.0
    IL_002a: ldfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_002f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0034: ldarg.0
    IL_0035: ldfld AnimationCurve LocalBoatAnimation::zRotation  /*0x04000526*/
    IL_003a: ldarg.0
    IL_003b: ldfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_0040: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0045: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_004a: stloc.0
    IL_004b: ldarg.0
    IL_004c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0051: ldarg.0
    IL_0052: ldfld Quaternion LocalBoatAnimation::startRotation  /*0x04000521*/
    IL_0057: ldloc.0
    IL_0058: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_005d: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0062: ldarg.0
    IL_0063: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0068: ldarg.0
    IL_0069: ldfld Vector3 LocalBoatAnimation::startPosition  /*0x04000520*/
    IL_006e: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0073: ldarg.0
    IL_0074: ldfld AnimationCurve LocalBoatAnimation::yOffset  /*0x04000523*/
    IL_0079: ldarg.0
    IL_007a: ldfld float LocalBoatAnimation::time  /*0x04000522*/
    IL_007f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0084: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0089: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_008e: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0093: ret

  .method LocalBoatAnimation::.ctor()  // token 0x060003FF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

