// ===== LevelBorder  (token 0x020001B1) =====
  .method LevelBorder::get_notInArrayMode()  // token 0x060008CD rva 0x2a6d8 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method LevelBorder::Start()  // token 0x060008CE rva 0x2a6e4 attrs Private, HideBySig
    // code size 134 (0x86), max stack 3, init locals
    .locals ([0] Line[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_000b: ldc.i4.0
    IL_000c: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0011: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0016: stfld Transform LevelBorder::target  /*0x04000B12*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_0022: callvirt Color Shapes.ShapeRenderer::get_Color()  /*0x0A000082*/
    IL_0027: stfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_0033: stfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_0038: ldarg.0
    IL_0039: ldflda Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_003e: ldc.r4 0f
    IL_0043: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0048: ldarg.0
    IL_0049: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_004e: brtrue.s IL_0062
    IL_0050: ldarg.0
    IL_0051: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_0056: ldarg.0
    IL_0057: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_005c: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0061: ret
    IL_0062: ldarg.0
    IL_0063: ldfld Line[] LevelBorder::lineArray  /*0x04000B0D*/
    IL_0068: stloc.0
    IL_0069: ldc.i4.0
    IL_006a: stloc.1
    IL_006b: br.s IL_007f
    IL_006d: ldloc.0
    IL_006e: ldloc.1
    IL_006f: ldelem.ref
    IL_0070: ldarg.0
    IL_0071: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_0076: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_007b: ldloc.1
    IL_007c: ldc.i4.1
    IL_007d: add
    IL_007e: stloc.1
    IL_007f: ldloc.1
    IL_0080: ldloc.0
    IL_0081: ldlen
    IL_0082: conv.i4
    IL_0083: blt.s IL_006d
    IL_0085: ret

  .method LevelBorder::Update()  // token 0x060008CF rva 0x2a778 attrs Private, HideBySig
    // code size 382 (0x17e), max stack 3, init locals
    .locals ([0] float, [1] float, [2] BoxCollider[], [3] int, [4] BoxCollider, [5] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float LevelBorder::timer  /*0x04000B10*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float LevelBorder::timer  /*0x04000B10*/
    IL_0012: ldarg.0
    IL_0013: ldfld float LevelBorder::timer  /*0x04000B10*/
    IL_0018: ldarg.0
    IL_0019: ldfld float LevelBorder::tickTime  /*0x04000B0E*/
    IL_001e: blt.un IL_017d
    IL_0023: ldarg.0
    IL_0024: ldc.r4 0f
    IL_0029: stfld float LevelBorder::timer  /*0x04000B10*/
    IL_002e: ldarg.0
    IL_002f: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_0034: brtrue IL_00cc
    IL_0039: ldarg.0
    IL_003a: ldfld Transform LevelBorder::target  /*0x04000B12*/
    IL_003f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0044: ldarg.0
    IL_0045: ldfld BoxCollider LevelBorder::boxCol  /*0x04000B0A*/
    IL_004a: ldarg.0
    IL_004b: ldfld Transform LevelBorder::target  /*0x04000B12*/
    IL_0050: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0055: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_005a: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_005f: stloc.0
    IL_0060: ldarg.0
    IL_0061: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0066: brfalse.s IL_0093
    IL_0068: ldloc.0
    IL_0069: ldarg.0
    IL_006a: ldfld float LevelBorder::fadeInDistance  /*0x04000B09*/
    IL_006f: ble.un.s IL_0093
    IL_0071: ldarg.0
    IL_0072: ldfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0077: brtrue.s IL_008b
    IL_0079: ldarg.0
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: call IEnumerator LevelBorder::FadeOut()  /*0x060008D1*/
    IL_0081: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0086: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_008b: ldarg.0
    IL_008c: ldc.i4.0
    IL_008d: stfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0092: ret
    IL_0093: ldarg.0
    IL_0094: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0099: brtrue IL_017d
    IL_009e: ldloc.0
    IL_009f: ldarg.0
    IL_00a0: ldfld float LevelBorder::fadeInDistance  /*0x04000B09*/
    IL_00a5: bgt.un IL_017d
    IL_00aa: ldarg.0
    IL_00ab: ldfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_00b0: brtrue.s IL_00c4
    IL_00b2: ldarg.0
    IL_00b3: ldarg.0
    IL_00b4: ldarg.0
    IL_00b5: call IEnumerator LevelBorder::FadeIn()  /*0x060008D0*/
    IL_00ba: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00bf: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_00c4: ldarg.0
    IL_00c5: ldc.i4.1
    IL_00c6: stfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_00cb: ret
    IL_00cc: ldc.r4 Infinityf
    IL_00d1: stloc.1
    IL_00d2: ldarg.0
    IL_00d3: ldfld BoxCollider[] LevelBorder::boxColArray  /*0x04000B0C*/
    IL_00d8: stloc.2
    IL_00d9: ldc.i4.0
    IL_00da: stloc.3
    IL_00db: br.s IL_0112
    IL_00dd: ldloc.2
    IL_00de: ldloc.3
    IL_00df: ldelem.ref
    IL_00e0: stloc.s 4
    IL_00e2: ldarg.0
    IL_00e3: ldfld Transform LevelBorder::target  /*0x04000B12*/
    IL_00e8: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ed: ldloc.s 4
    IL_00ef: ldarg.0
    IL_00f0: ldfld Transform LevelBorder::target  /*0x04000B12*/
    IL_00f5: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00fa: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_00ff: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_0104: stloc.s 5
    IL_0106: ldloc.s 5
    IL_0108: ldloc.1
    IL_0109: bge.un.s IL_010e
    IL_010b: ldloc.s 5
    IL_010d: stloc.1
    IL_010e: ldloc.3
    IL_010f: ldc.i4.1
    IL_0110: add
    IL_0111: stloc.3
    IL_0112: ldloc.3
    IL_0113: ldloc.2
    IL_0114: ldlen
    IL_0115: conv.i4
    IL_0116: blt.s IL_00dd
    IL_0118: ldarg.0
    IL_0119: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_011e: brfalse.s IL_014b
    IL_0120: ldloc.1
    IL_0121: ldarg.0
    IL_0122: ldfld float LevelBorder::fadeInDistance  /*0x04000B09*/
    IL_0127: ble.un.s IL_014b
    IL_0129: ldarg.0
    IL_012a: ldfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_012f: brtrue.s IL_0143
    IL_0131: ldarg.0
    IL_0132: ldarg.0
    IL_0133: ldarg.0
    IL_0134: call IEnumerator LevelBorder::FadeOut()  /*0x060008D1*/
    IL_0139: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_013e: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0143: ldarg.0
    IL_0144: ldc.i4.0
    IL_0145: stfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_014a: ret
    IL_014b: ldarg.0
    IL_014c: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0151: brtrue.s IL_017d
    IL_0153: ldloc.1
    IL_0154: ldarg.0
    IL_0155: ldfld float LevelBorder::fadeInDistance  /*0x04000B09*/
    IL_015a: bgt.un.s IL_017d
    IL_015c: ldarg.0
    IL_015d: ldfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0162: brtrue.s IL_0176
    IL_0164: ldarg.0
    IL_0165: ldarg.0
    IL_0166: ldarg.0
    IL_0167: call IEnumerator LevelBorder::FadeIn()  /*0x060008D0*/
    IL_016c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0171: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0176: ldarg.0
    IL_0177: ldc.i4.1
    IL_0178: stfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_017d: ret

  .method LevelBorder::FadeIn()  // token 0x060008D0 rva 0x2a902 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LevelBorder.<FadeIn>d__18::.ctor(int)  /*0x060008D3*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LevelBorder LevelBorder.<FadeIn>d__18::<>4__this  /*0x04000B19*/
    IL_000d: ret

  .method LevelBorder::FadeOut()  // token 0x060008D1 rva 0x2a911 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LevelBorder.<FadeOut>d__19::.ctor(int)  /*0x060008D9*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LevelBorder LevelBorder.<FadeOut>d__19::<>4__this  /*0x04000B1D*/
    IL_000d: ret

  .method LevelBorder::.ctor()  // token 0x060008D2 rva 0x2a920 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float LevelBorder::tickTime  /*0x04000B0E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.75f
    IL_0011: stfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== LevelBorder/<FadeIn>d__18  (token 0x020001B2) =====
  .method LevelBorder.<FadeIn>d__18::.ctor(int)  // token 0x060008D3 rva 0x2a93e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LevelBorder.<FadeIn>d__18::<>1__state  /*0x04000B17*/
    IL_000d: ret

  .method LevelBorder.<FadeIn>d__18::System.IDisposable.Dispose()  // token 0x060008D4 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LevelBorder.<FadeIn>d__18::MoveNext()  // token 0x060008D5 rva 0x2a950 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 326 (0x146), max stack 5, init locals
    .locals ([0] int, [1] LevelBorder, [2] Color, [3] Line[], [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int LevelBorder.<FadeIn>d__18::<>1__state  /*0x04000B17*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LevelBorder LevelBorder.<FadeIn>d__18::<>4__this  /*0x04000B19*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00c8
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int LevelBorder.<FadeIn>d__18::<>1__state  /*0x04000B17*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: stfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_002c: br IL_00cf
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: ldfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_0038: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003d: add
    IL_003e: stfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_0043: ldloc.1
    IL_0044: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_0049: brtrue.s IL_0076
    IL_004b: ldloc.1
    IL_004c: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_0051: ldloc.1
    IL_0052: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_0057: ldloc.1
    IL_0058: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_005d: ldarg.0
    IL_005e: ldfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_0063: ldloc.1
    IL_0064: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_0069: div
    IL_006a: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_006f: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0074: br.s IL_00b8
    IL_0076: ldloc.1
    IL_0077: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_007c: ldloc.1
    IL_007d: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_0082: ldarg.0
    IL_0083: ldfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_0088: ldloc.1
    IL_0089: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_008e: div
    IL_008f: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0094: stloc.2
    IL_0095: ldloc.1
    IL_0096: ldfld Line[] LevelBorder::lineArray  /*0x04000B0D*/
    IL_009b: stloc.3
    IL_009c: ldc.i4.0
    IL_009d: stloc.s 4
    IL_009f: br.s IL_00b1
    IL_00a1: ldloc.3
    IL_00a2: ldloc.s 4
    IL_00a4: ldelem.ref
    IL_00a5: ldloc.2
    IL_00a6: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_00ab: ldloc.s 4
    IL_00ad: ldc.i4.1
    IL_00ae: add
    IL_00af: stloc.s 4
    IL_00b1: ldloc.s 4
    IL_00b3: ldloc.3
    IL_00b4: ldlen
    IL_00b5: conv.i4
    IL_00b6: blt.s IL_00a1
    IL_00b8: ldarg.0
    IL_00b9: ldnull
    IL_00ba: stfld object LevelBorder.<FadeIn>d__18::<>2__current  /*0x04000B18*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.i4.1
    IL_00c1: stfld int LevelBorder.<FadeIn>d__18::<>1__state  /*0x04000B17*/
    IL_00c6: ldc.i4.1
    IL_00c7: ret
    IL_00c8: ldarg.0
    IL_00c9: ldc.i4.m1
    IL_00ca: stfld int LevelBorder.<FadeIn>d__18::<>1__state  /*0x04000B17*/
    IL_00cf: ldarg.0
    IL_00d0: ldfld float LevelBorder.<FadeIn>d__18::<timer>5__2  /*0x04000B1A*/
    IL_00d5: ldloc.1
    IL_00d6: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_00db: ble IL_0031
    IL_00e0: ldloc.1
    IL_00e1: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_00e6: brtrue.s IL_00fb
    IL_00e8: ldloc.1
    IL_00e9: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_00ee: ldloc.1
    IL_00ef: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_00f4: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_00f9: br.s IL_0123
    IL_00fb: ldloc.1
    IL_00fc: ldfld Line[] LevelBorder::lineArray  /*0x04000B0D*/
    IL_0101: stloc.3
    IL_0102: ldc.i4.0
    IL_0103: stloc.s 4
    IL_0105: br.s IL_011c
    IL_0107: ldloc.3
    IL_0108: ldloc.s 4
    IL_010a: ldelem.ref
    IL_010b: ldloc.1
    IL_010c: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_0111: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0116: ldloc.s 4
    IL_0118: ldc.i4.1
    IL_0119: add
    IL_011a: stloc.s 4
    IL_011c: ldloc.s 4
    IL_011e: ldloc.3
    IL_011f: ldlen
    IL_0120: conv.i4
    IL_0121: blt.s IL_0107
    IL_0123: ldloc.1
    IL_0124: ldnull
    IL_0125: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_012a: ldloc.1
    IL_012b: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0130: brtrue.s IL_0144
    IL_0132: ldloc.1
    IL_0133: ldloc.1
    IL_0134: ldloc.1
    IL_0135: call IEnumerator LevelBorder::FadeOut()  /*0x060008D1*/
    IL_013a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_013f: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0144: ldc.i4.0
    IL_0145: ret

  .method LevelBorder.<FadeIn>d__18::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060008D6 rva 0x2aaa2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelBorder.<FadeIn>d__18::<>2__current  /*0x04000B18*/
    IL_0006: ret

  .method LevelBorder.<FadeIn>d__18::System.Collections.IEnumerator.Reset()  // token 0x060008D7 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LevelBorder.<FadeIn>d__18::System.Collections.IEnumerator.get_Current()  // token 0x060008D8 rva 0x2aaa2 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelBorder.<FadeIn>d__18::<>2__current  /*0x04000B18*/
    IL_0006: ret

// ===== LevelBorder/<FadeOut>d__19  (token 0x020001B3) =====
  .method LevelBorder.<FadeOut>d__19::.ctor(int)  // token 0x060008D9 rva 0x2aaaa attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LevelBorder.<FadeOut>d__19::<>1__state  /*0x04000B1B*/
    IL_000d: ret

  .method LevelBorder.<FadeOut>d__19::System.IDisposable.Dispose()  // token 0x060008DA rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LevelBorder.<FadeOut>d__19::MoveNext()  // token 0x060008DB rva 0x2aabc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 326 (0x146), max stack 5, init locals
    .locals ([0] int, [1] LevelBorder, [2] Color, [3] Line[], [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int LevelBorder.<FadeOut>d__19::<>1__state  /*0x04000B1B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LevelBorder LevelBorder.<FadeOut>d__19::<>4__this  /*0x04000B1D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00c8
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int LevelBorder.<FadeOut>d__19::<>1__state  /*0x04000B1B*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: stfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_002c: br IL_00cf
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: ldfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_0038: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003d: add
    IL_003e: stfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_0043: ldloc.1
    IL_0044: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_0049: brtrue.s IL_0076
    IL_004b: ldloc.1
    IL_004c: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_0051: ldloc.1
    IL_0052: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_0057: ldloc.1
    IL_0058: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_005d: ldarg.0
    IL_005e: ldfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_0063: ldloc.1
    IL_0064: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_0069: div
    IL_006a: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_006f: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0074: br.s IL_00b8
    IL_0076: ldloc.1
    IL_0077: ldfld Color LevelBorder::defaultColor  /*0x04000B13*/
    IL_007c: ldloc.1
    IL_007d: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_0082: ldarg.0
    IL_0083: ldfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_0088: ldloc.1
    IL_0089: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_008e: div
    IL_008f: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0094: stloc.2
    IL_0095: ldloc.1
    IL_0096: ldfld Line[] LevelBorder::lineArray  /*0x04000B0D*/
    IL_009b: stloc.3
    IL_009c: ldc.i4.0
    IL_009d: stloc.s 4
    IL_009f: br.s IL_00b1
    IL_00a1: ldloc.3
    IL_00a2: ldloc.s 4
    IL_00a4: ldelem.ref
    IL_00a5: ldloc.2
    IL_00a6: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_00ab: ldloc.s 4
    IL_00ad: ldc.i4.1
    IL_00ae: add
    IL_00af: stloc.s 4
    IL_00b1: ldloc.s 4
    IL_00b3: ldloc.3
    IL_00b4: ldlen
    IL_00b5: conv.i4
    IL_00b6: blt.s IL_00a1
    IL_00b8: ldarg.0
    IL_00b9: ldnull
    IL_00ba: stfld object LevelBorder.<FadeOut>d__19::<>2__current  /*0x04000B1C*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.i4.1
    IL_00c1: stfld int LevelBorder.<FadeOut>d__19::<>1__state  /*0x04000B1B*/
    IL_00c6: ldc.i4.1
    IL_00c7: ret
    IL_00c8: ldarg.0
    IL_00c9: ldc.i4.m1
    IL_00ca: stfld int LevelBorder.<FadeOut>d__19::<>1__state  /*0x04000B1B*/
    IL_00cf: ldarg.0
    IL_00d0: ldfld float LevelBorder.<FadeOut>d__19::<timer>5__2  /*0x04000B1E*/
    IL_00d5: ldloc.1
    IL_00d6: ldfld float LevelBorder::fadeTime  /*0x04000B0F*/
    IL_00db: ble IL_0031
    IL_00e0: ldloc.1
    IL_00e1: ldfld bool LevelBorder::arrayMode  /*0x04000B15*/
    IL_00e6: brtrue.s IL_00fb
    IL_00e8: ldloc.1
    IL_00e9: ldfld Line LevelBorder::line  /*0x04000B0B*/
    IL_00ee: ldloc.1
    IL_00ef: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_00f4: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_00f9: br.s IL_0123
    IL_00fb: ldloc.1
    IL_00fc: ldfld Line[] LevelBorder::lineArray  /*0x04000B0D*/
    IL_0101: stloc.3
    IL_0102: ldc.i4.0
    IL_0103: stloc.s 4
    IL_0105: br.s IL_011c
    IL_0107: ldloc.3
    IL_0108: ldloc.s 4
    IL_010a: ldelem.ref
    IL_010b: ldloc.1
    IL_010c: ldfld Color LevelBorder::fadeOutColor  /*0x04000B14*/
    IL_0111: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_0116: ldloc.s 4
    IL_0118: ldc.i4.1
    IL_0119: add
    IL_011a: stloc.s 4
    IL_011c: ldloc.s 4
    IL_011e: ldloc.3
    IL_011f: ldlen
    IL_0120: conv.i4
    IL_0121: blt.s IL_0107
    IL_0123: ldloc.1
    IL_0124: ldnull
    IL_0125: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_012a: ldloc.1
    IL_012b: ldfld bool LevelBorder::fadedIn  /*0x04000B11*/
    IL_0130: brfalse.s IL_0144
    IL_0132: ldloc.1
    IL_0133: ldloc.1
    IL_0134: ldloc.1
    IL_0135: call IEnumerator LevelBorder::FadeIn()  /*0x060008D0*/
    IL_013a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_013f: stfld Coroutine LevelBorder::currentFade  /*0x04000B16*/
    IL_0144: ldc.i4.0
    IL_0145: ret

  .method LevelBorder.<FadeOut>d__19::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060008DC rva 0x2ac0e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelBorder.<FadeOut>d__19::<>2__current  /*0x04000B1C*/
    IL_0006: ret

  .method LevelBorder.<FadeOut>d__19::System.Collections.IEnumerator.Reset()  // token 0x060008DD rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LevelBorder.<FadeOut>d__19::System.Collections.IEnumerator.get_Current()  // token 0x060008DE rva 0x2ac0e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LevelBorder.<FadeOut>d__19::<>2__current  /*0x04000B1C*/
    IL_0006: ret

