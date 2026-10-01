// ===== BoatAnimation  (token 0x02000019) =====
  .method BoatAnimation::Start()  // token 0x06000096 rva 0x48af attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: ldc.r4 10000f
    IL_000b: mul
    IL_000c: stfld float BoatAnimation::time  /*0x0400009C*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001d: stfld Vector3 BoatAnimation::startPosition  /*0x0400009A*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0029: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002e: stfld Quaternion BoatAnimation::startRotation  /*0x0400009B*/
    IL_0033: ret

  .method BoatAnimation::Update()  // token 0x06000097 rva 0x48e4 attrs Private, HideBySig
    // code size 148 (0x94), max stack 5, init locals
    .locals ([0] Quaternion)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float BoatAnimation::time  /*0x0400009C*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float BoatAnimation::time  /*0x0400009C*/
    IL_0012: ldarg.0
    IL_0013: ldfld AnimationCurve BoatAnimation::xRotation  /*0x0400009E*/
    IL_0018: ldarg.0
    IL_0019: ldfld float BoatAnimation::time  /*0x0400009C*/
    IL_001e: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0023: ldarg.0
    IL_0024: ldfld AnimationCurve BoatAnimation::yRotation  /*0x0400009F*/
    IL_0029: ldarg.0
    IL_002a: ldfld float BoatAnimation::time  /*0x0400009C*/
    IL_002f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0034: ldarg.0
    IL_0035: ldfld AnimationCurve BoatAnimation::zRotation  /*0x040000A0*/
    IL_003a: ldarg.0
    IL_003b: ldfld float BoatAnimation::time  /*0x0400009C*/
    IL_0040: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0045: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_004a: stloc.0
    IL_004b: ldarg.0
    IL_004c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0051: ldarg.0
    IL_0052: ldfld Quaternion BoatAnimation::startRotation  /*0x0400009B*/
    IL_0057: ldloc.0
    IL_0058: call Quaternion UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A00007F*/
    IL_005d: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0062: ldarg.0
    IL_0063: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0068: ldarg.0
    IL_0069: ldfld Vector3 BoatAnimation::startPosition  /*0x0400009A*/
    IL_006e: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0073: ldarg.0
    IL_0074: ldfld AnimationCurve BoatAnimation::yOffset  /*0x0400009D*/
    IL_0079: ldarg.0
    IL_007a: ldfld float BoatAnimation::time  /*0x0400009C*/
    IL_007f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0084: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0089: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_008e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0093: ret

  .method BoatAnimation::.ctor()  // token 0x06000098 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

