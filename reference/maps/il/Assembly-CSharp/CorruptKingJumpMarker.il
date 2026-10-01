// ===== CorruptKingJumpMarker  (token 0x0200001A) =====
  .method CorruptKingJumpMarker::Start()  // token 0x06000099 rva 0x4984 attrs Private, HideBySig
    // code size 77 (0x4d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Disc CorruptKingJumpMarker::innerDisc  /*0x040000A1*/
    IL_0007: callvirt float Shapes.Disc::get_Radius()  /*0x0A000080*/
    IL_000c: stfld float CorruptKingJumpMarker::initialRadius  /*0x040000A8*/
    IL_0011: ldarg.0
    IL_0012: ldfld Disc CorruptKingJumpMarker::innerDisc  /*0x040000A1*/
    IL_0017: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0021: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0026: ldarg.0
    IL_0027: ldfld Disc CorruptKingJumpMarker::outerDisc  /*0x040000A2*/
    IL_002c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0031: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0036: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: ldfld Disc CorruptKingJumpMarker::outerDisc  /*0x040000A2*/
    IL_0042: callvirt Color Shapes.ShapeRenderer::get_Color()  /*0x0A000082*/
    IL_0047: stfld Color CorruptKingJumpMarker::initColor  /*0x040000AA*/
    IL_004c: ret

  .method CorruptKingJumpMarker::Update()  // token 0x0600009A rva 0x49e0 attrs Private, HideBySig
    // code size 202 (0xca), max stack 5, init locals
    .locals ([0] Vector3, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float CorruptKingJumpMarker::clock  /*0x040000A9*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float CorruptKingJumpMarker::clock  /*0x040000A9*/
    IL_0012: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0017: ldarg.0
    IL_0018: ldfld AnimationCurve CorruptKingJumpMarker::scaleUpCurve  /*0x040000A5*/
    IL_001d: ldc.r4 0f
    IL_0022: ldarg.0
    IL_0023: ldfld float CorruptKingJumpMarker::scaleUpTime  /*0x040000A4*/
    IL_0028: ldarg.0
    IL_0029: ldfld float CorruptKingJumpMarker::clock  /*0x040000A9*/
    IL_002e: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0033: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0038: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003d: stloc.0
    IL_003e: ldarg.0
    IL_003f: ldfld Disc CorruptKingJumpMarker::innerDisc  /*0x040000A1*/
    IL_0044: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0049: ldloc.0
    IL_004a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_004f: ldarg.0
    IL_0050: ldfld Disc CorruptKingJumpMarker::outerDisc  /*0x040000A2*/
    IL_0055: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: ldloc.0
    IL_005b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0060: ldc.r4 0f
    IL_0065: ldarg.0
    IL_0066: ldfld float CorruptKingJumpMarker::overallTime  /*0x040000A3*/
    IL_006b: ldarg.0
    IL_006c: ldfld float CorruptKingJumpMarker::clock  /*0x040000A9*/
    IL_0071: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0076: stloc.1
    IL_0077: ldarg.0
    IL_0078: ldfld Disc CorruptKingJumpMarker::innerDisc  /*0x040000A1*/
    IL_007d: ldarg.0
    IL_007e: ldfld float CorruptKingJumpMarker::initialRadius  /*0x040000A8*/
    IL_0083: ldc.r4 0f
    IL_0088: ldloc.1
    IL_0089: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_008e: callvirt void Shapes.Disc::set_Radius(float)  /*0x0A000086*/
    IL_0093: ldarg.0
    IL_0094: ldfld Disc CorruptKingJumpMarker::outerDisc  /*0x040000A2*/
    IL_0099: ldarg.0
    IL_009a: ldfld Color CorruptKingJumpMarker::initColor  /*0x040000AA*/
    IL_009f: ldarg.0
    IL_00a0: ldfld Color CorruptKingJumpMarker::fadeColor  /*0x040000A7*/
    IL_00a5: ldloc.1
    IL_00a6: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00ab: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld float CorruptKingJumpMarker::clock  /*0x040000A9*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld float CorruptKingJumpMarker::overallTime  /*0x040000A3*/
    IL_00bc: ble.un.s IL_00c9
    IL_00be: ldarg.0
    IL_00bf: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00c4: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00c9: ret

  .method CorruptKingJumpMarker::.ctor()  // token 0x0600009B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

