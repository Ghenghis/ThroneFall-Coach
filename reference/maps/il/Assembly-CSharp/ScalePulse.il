// ===== ScalePulse  (token 0x0200003C) =====
  .method ScalePulse::Start()  // token 0x0600012E rva 0x6c4e attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScalePulse::randomizeClock  /*0x04000175*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_000e: stfld float ScalePulse::clock  /*0x04000176*/
    IL_0013: ret

  .method ScalePulse::Update()  // token 0x0600012F rva 0x6c64 attrs Private, HideBySig
    // code size 185 (0xb9), max stack 6, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld bool ScalePulse::onlyIfMoving  /*0x04000172*/
    IL_0007: ldc.i4.0
    IL_0008: ceq
    IL_000a: stfld bool ScalePulse::pulseAllowed  /*0x04000178*/
    IL_000f: ldarg.0
    IL_0010: ldfld bool ScalePulse::pulseAllowed  /*0x04000178*/
    IL_0015: brtrue.s IL_0064
    IL_0017: ldarg.0
    IL_0018: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001d: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0022: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0027: stloc.0
    IL_0028: ldloc.0
    IL_0029: ldarg.0
    IL_002a: ldfld Vector3 ScalePulse::lastPosition  /*0x04000177*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0034: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0039: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003e: stloc.1
    IL_003f: ldloca.s 1
    IL_0041: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0046: stloc.2
    IL_0047: ldarg.0
    IL_0048: ldloc.0
    IL_0049: stfld Vector3 ScalePulse::lastPosition  /*0x04000177*/
    IL_004e: ldarg.0
    IL_004f: ldarg.0
    IL_0050: ldfld bool ScalePulse::pulseAllowed  /*0x04000178*/
    IL_0055: ldloc.2
    IL_0056: ldarg.0
    IL_0057: ldfld float ScalePulse::velocitySqrtDeadzone  /*0x04000174*/
    IL_005c: cgt
    IL_005e: or
    IL_005f: stfld bool ScalePulse::pulseAllowed  /*0x04000178*/
    IL_0064: ldarg.0
    IL_0065: ldfld bool ScalePulse::pulseAllowed  /*0x04000178*/
    IL_006a: brfalse.s IL_00b8
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld float ScalePulse::clock  /*0x04000176*/
    IL_0073: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0078: ldarg.0
    IL_0079: ldfld float ScalePulse::pulseSpeed  /*0x04000171*/
    IL_007e: mul
    IL_007f: add
    IL_0080: stfld float ScalePulse::clock  /*0x04000176*/
    IL_0085: ldarg.0
    IL_0086: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_008b: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0090: ldc.r4 1f
    IL_0095: ldarg.0
    IL_0096: ldfld float ScalePulse::scaleIncrease  /*0x04000170*/
    IL_009b: ldarg.0
    IL_009c: ldfld AnimationCurve ScalePulse::scaleCurve  /*0x0400016F*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld float ScalePulse::clock  /*0x04000176*/
    IL_00a7: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_00ac: mul
    IL_00ad: add
    IL_00ae: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00b3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00b8: ret

  .method ScalePulse::.ctor()  // token 0x06000130 rva 0x6d29 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.4f
    IL_0006: stfld float ScalePulse::scaleIncrease  /*0x04000170*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float ScalePulse::pulseSpeed  /*0x04000171*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.15f
    IL_001c: stfld float ScalePulse::velocitySqrtDeadzone  /*0x04000174*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

