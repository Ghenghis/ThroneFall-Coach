// ===== ShapeGroupFader  (token 0x0200017D) =====
  .method ShapeGroupFader::Update()  // token 0x060007A2 rva 0x25c00 attrs Private, HideBySig
    // code size 177 (0xb1), max stack 5, init locals
    .locals ([0] int, [1] Color)
    IL_0000: ldarg.0
    IL_0001: ldfld bool ShapeGroupFader::running  /*0x04000995*/
    IL_0006: brfalse IL_00b0
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld float ShapeGroupFader::clock  /*0x04000994*/
    IL_0012: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0017: add
    IL_0018: stfld float ShapeGroupFader::clock  /*0x04000994*/
    IL_001d: ldarg.0
    IL_001e: ldflda Color ShapeGroupFader::groupColor  /*0x04000993*/
    IL_0023: ldarg.0
    IL_0024: ldfld AnimationCurve ShapeGroupFader::fadeCurve  /*0x04000992*/
    IL_0029: ldc.r4 0f
    IL_002e: ldarg.0
    IL_002f: ldfld float ShapeGroupFader::fadeTime  /*0x04000991*/
    IL_0034: ldarg.0
    IL_0035: ldfld float ShapeGroupFader::clock  /*0x04000994*/
    IL_003a: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_003f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0044: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0049: ldarg.0
    IL_004a: ldfld ShapeGroup ShapeGroupFader::target  /*0x04000990*/
    IL_004f: ldarg.0
    IL_0050: ldfld Color ShapeGroupFader::groupColor  /*0x04000993*/
    IL_0055: callvirt void Shapes.ShapeGroup::set_Color(UnityEngine.Color)  /*0x0A000377*/
    IL_005a: ldc.i4.0
    IL_005b: stloc.0
    IL_005c: br.s IL_0090
    IL_005e: ldarg.0
    IL_005f: ldfld SpriteRenderer[] ShapeGroupFader::sprites  /*0x04000996*/
    IL_0064: ldloc.0
    IL_0065: ldelem.ref
    IL_0066: callvirt Color UnityEngine.SpriteRenderer::get_color()  /*0x0A000378*/
    IL_006b: stloc.1
    IL_006c: ldloca.s 1
    IL_006e: ldarg.0
    IL_006f: ldflda Color ShapeGroupFader::groupColor  /*0x04000993*/
    IL_0074: ldfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0079: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_007e: ldarg.0
    IL_007f: ldfld SpriteRenderer[] ShapeGroupFader::sprites  /*0x04000996*/
    IL_0084: ldloc.0
    IL_0085: ldelem.ref
    IL_0086: ldloc.1
    IL_0087: callvirt void UnityEngine.SpriteRenderer::set_color(UnityEngine.Color)  /*0x0A000379*/
    IL_008c: ldloc.0
    IL_008d: ldc.i4.1
    IL_008e: add
    IL_008f: stloc.0
    IL_0090: ldloc.0
    IL_0091: ldarg.0
    IL_0092: ldfld SpriteRenderer[] ShapeGroupFader::sprites  /*0x04000996*/
    IL_0097: ldlen
    IL_0098: conv.i4
    IL_0099: blt.s IL_005e
    IL_009b: ldarg.0
    IL_009c: ldfld float ShapeGroupFader::clock  /*0x04000994*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld float ShapeGroupFader::fadeTime  /*0x04000991*/
    IL_00a7: blt.un.s IL_00b0
    IL_00a9: ldarg.0
    IL_00aa: ldc.i4.0
    IL_00ab: stfld bool ShapeGroupFader::running  /*0x04000995*/
    IL_00b0: ret

  .method ShapeGroupFader::.ctor()  // token 0x060007A3 rva 0x25cbd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float ShapeGroupFader::fadeTime  /*0x04000991*/
    IL_000b: ldarg.0
    IL_000c: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0011: stfld Color ShapeGroupFader::groupColor  /*0x04000993*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool ShapeGroupFader::running  /*0x04000995*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

