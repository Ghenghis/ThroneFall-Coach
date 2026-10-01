// ===== CorruptKingBlastCircle  (token 0x02000022) =====
  .method CorruptKingBlastCircle::Start()  // token 0x060000BD rva 0x539b attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Disc CorruptKingBlastCircle::disc  /*0x040000E7*/
    IL_0007: callvirt Color Shapes.ShapeRenderer::get_Color()  /*0x0A000082*/
    IL_000c: stfld Color CorruptKingBlastCircle::initcol  /*0x040000ED*/
    IL_0011: ret

  .method CorruptKingBlastCircle::Update()  // token 0x060000BE rva 0x53b0 attrs Private, HideBySig
    // code size 135 (0x87), max stack 5, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld float CorruptKingBlastCircle::clock  /*0x040000EC*/
    IL_0006: ldarg.0
    IL_0007: ldfld float CorruptKingBlastCircle::animationTime  /*0x040000E9*/
    IL_000c: ble.un.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldarg.0
    IL_0011: ldfld float CorruptKingBlastCircle::clock  /*0x040000EC*/
    IL_0016: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001b: add
    IL_001c: stfld float CorruptKingBlastCircle::clock  /*0x040000EC*/
    IL_0021: ldc.r4 0f
    IL_0026: ldarg.0
    IL_0027: ldfld float CorruptKingBlastCircle::animationTime  /*0x040000E9*/
    IL_002c: ldarg.0
    IL_002d: ldfld float CorruptKingBlastCircle::clock  /*0x040000EC*/
    IL_0032: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0037: stloc.0
    IL_0038: ldarg.0
    IL_0039: ldfld Disc CorruptKingBlastCircle::disc  /*0x040000E7*/
    IL_003e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0043: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0048: ldarg.0
    IL_0049: ldfld AnimationCurve CorruptKingBlastCircle::scaleCurve  /*0x040000EA*/
    IL_004e: ldloc.0
    IL_004f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0054: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0059: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_005e: ldarg.0
    IL_005f: ldfld Disc CorruptKingBlastCircle::disc  /*0x040000E7*/
    IL_0064: ldarg.0
    IL_0065: ldfld Color CorruptKingBlastCircle::initcol  /*0x040000ED*/
    IL_006a: ldarg.0
    IL_006b: ldfld Color CorruptKingBlastCircle::targetColor  /*0x040000E8*/
    IL_0070: ldarg.0
    IL_0071: ldfld AnimationCurve CorruptKingBlastCircle::colorCurve  /*0x040000EB*/
    IL_0076: ldloc.0
    IL_0077: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_007c: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0081: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0086: ret

  .method CorruptKingBlastCircle::.ctor()  // token 0x060000BF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

