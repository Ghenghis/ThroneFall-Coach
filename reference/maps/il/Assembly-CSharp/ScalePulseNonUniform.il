// ===== ScalePulseNonUniform  (token 0x0200003D) =====
  .method ScalePulseNonUniform::Start()  // token 0x06000131 rva 0x6d52 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScalePulseNonUniform::randomizeClock  /*0x04000182*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_000e: stfld float ScalePulseNonUniform::clock  /*0x04000183*/
    IL_0013: ret

  .method ScalePulseNonUniform::Update()  // token 0x06000132 rva 0x6d68 attrs Private, HideBySig
    // code size 286 (0x11e), max stack 6, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldarg.0
    IL_0013: ldfld Vector3 ScalePulseNonUniform::lastPosition  /*0x04000186*/
    IL_0018: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_001d: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0022: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0027: stloc.1
    IL_0028: ldloca.s 1
    IL_002a: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_002f: stloc.2
    IL_0030: ldarg.0
    IL_0031: ldloc.0
    IL_0032: stfld Vector3 ScalePulseNonUniform::lastPosition  /*0x04000186*/
    IL_0037: ldarg.0
    IL_0038: ldfld bool ScalePulseNonUniform::onlyIfMoving  /*0x0400017C*/
    IL_003d: brfalse.s IL_0048
    IL_003f: ldloc.2
    IL_0040: ldarg.0
    IL_0041: ldfld float ScalePulseNonUniform::velocitySqrtDeadzone  /*0x0400017E*/
    IL_0046: ble.un.s IL_0061
    IL_0048: ldarg.0
    IL_0049: ldarg.0
    IL_004a: ldfld float ScalePulseNonUniform::clock  /*0x04000183*/
    IL_004f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0054: ldarg.0
    IL_0055: ldfld float ScalePulseNonUniform::pulseSpeed  /*0x0400017B*/
    IL_005a: mul
    IL_005b: add
    IL_005c: stfld float ScalePulseNonUniform::clock  /*0x04000183*/
    IL_0061: ldarg.0
    IL_0062: ldc.r4 1f
    IL_0067: ldc.r4 1f
    IL_006c: ldarg.0
    IL_006d: ldfld float ScalePulseNonUniform::scaleIncrease  /*0x0400017A*/
    IL_0072: ldarg.0
    IL_0073: ldfld AnimationCurve ScalePulseNonUniform::scaleCurve  /*0x04000179*/
    IL_0078: ldarg.0
    IL_0079: ldfld float ScalePulseNonUniform::clock  /*0x04000183*/
    IL_007e: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0083: mul
    IL_0084: add
    IL_0085: mul
    IL_0086: stfld float ScalePulseNonUniform::desiredScale  /*0x04000185*/
    IL_008b: ldarg.0
    IL_008c: ldfld bool ScalePulseNonUniform::x  /*0x0400017F*/
    IL_0091: brfalse.s IL_00a6
    IL_0093: ldarg.0
    IL_0094: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_0099: ldarg.0
    IL_009a: ldfld float ScalePulseNonUniform::desiredScale  /*0x04000185*/
    IL_009f: stfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00a4: br.s IL_00b6
    IL_00a6: ldarg.0
    IL_00a7: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_00ac: ldc.r4 1f
    IL_00b1: stfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld bool ScalePulseNonUniform::y  /*0x04000180*/
    IL_00bc: brfalse.s IL_00d1
    IL_00be: ldarg.0
    IL_00bf: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld float ScalePulseNonUniform::desiredScale  /*0x04000185*/
    IL_00ca: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00cf: br.s IL_00e1
    IL_00d1: ldarg.0
    IL_00d2: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_00d7: ldc.r4 1f
    IL_00dc: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld bool ScalePulseNonUniform::z  /*0x04000181*/
    IL_00e7: brfalse.s IL_00fc
    IL_00e9: ldarg.0
    IL_00ea: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_00ef: ldarg.0
    IL_00f0: ldfld float ScalePulseNonUniform::desiredScale  /*0x04000185*/
    IL_00f5: stfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00fa: br.s IL_010c
    IL_00fc: ldarg.0
    IL_00fd: ldflda Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_0102: ldc.r4 1f
    IL_0107: stfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_010c: ldarg.0
    IL_010d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0112: ldarg.0
    IL_0113: ldfld Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_0118: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_011d: ret

  .method ScalePulseNonUniform::.ctor()  // token 0x06000133 rva 0x6e94 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 77 (0x4d), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.4f
    IL_0006: stfld float ScalePulseNonUniform::scaleIncrease  /*0x0400017A*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float ScalePulseNonUniform::pulseSpeed  /*0x0400017B*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.15f
    IL_001c: stfld float ScalePulseNonUniform::velocitySqrtDeadzone  /*0x0400017E*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: ldc.r4 1f
    IL_002c: ldc.r4 1f
    IL_0031: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0036: stfld Vector3 ScalePulseNonUniform::newScaleVector  /*0x04000184*/
    IL_003b: ldarg.0
    IL_003c: ldc.r4 1f
    IL_0041: stfld float ScalePulseNonUniform::desiredScale  /*0x04000185*/
    IL_0046: ldarg.0
    IL_0047: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_004c: ret

