// ===== CameraBounds  (token 0x02000093) =====
  .method CameraBounds::PrepareBounds(float)  // token 0x06000317 rva 0xd940 attrs Public, HideBySig
    // code size 73 (0x49), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld List<Vector2> CameraBounds::bounds  /*0x040003D0*/
    IL_0007: newobj void System.Collections.Generic.List<UnityEngine.Vector2>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00014C*/
    IL_000c: stfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_0038
    IL_0015: ldarg.0
    IL_0016: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_001b: ldarg.1
    IL_001c: ldc.r4 10f
    IL_0021: div
    IL_0022: ldarg.1
    IL_0023: ldc.r4 10f
    IL_0028: div
    IL_0029: ldc.r4 2f
    IL_002e: mul
    IL_002f: call void CameraBounds::GrowShrinkPoly(System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000318*/
    IL_0034: ldloc.0
    IL_0035: ldc.i4.1
    IL_0036: add
    IL_0037: stloc.0
    IL_0038: ldloc.0
    IL_0039: ldc.i4.s 10
    IL_003b: blt.s IL_0015
    IL_003d: ldarg.0
    IL_003e: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0043: call void CameraBounds::MakeBoundsConvex(System.Collections.Generic.List<UnityEngine.Vector2>)  /*0x0600031B*/
    IL_0048: ret

  .method CameraBounds::GrowShrinkPoly(System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  // token 0x06000318 rva 0xd998 attrs Public, Static, HideBySig
    // code size 211 (0xd3), max stack 4, init locals
    .locals ([0] int, [1] int, [2] Vector2, [3] Vector2, [4] Vector2, [5] Vector2, [6] Vector2, [7] Vector2, [8] Vector2, [9] Vector2, [10] float, [11] Vector2)
    IL_0000: ldarg.0
    IL_0001: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br IL_00cb
    IL_000e: ldarg.0
    IL_000f: ldloc.1
    IL_0010: ldc.i4.1
    IL_0011: sub
    IL_0012: ldloc.0
    IL_0013: add
    IL_0014: ldloc.0
    IL_0015: rem
    IL_0016: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_001b: stloc.2
    IL_001c: ldarg.0
    IL_001d: ldloc.1
    IL_001e: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0023: stloc.3
    IL_0024: ldarg.0
    IL_0025: ldloc.1
    IL_0026: ldc.i4.1
    IL_0027: add
    IL_0028: ldloc.0
    IL_0029: rem
    IL_002a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_002f: stloc.s 4
    IL_0031: ldloc.3
    IL_0032: ldloc.2
    IL_0033: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0038: stloc.s 11
    IL_003a: ldloca.s 11
    IL_003c: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_0041: stloc.s 5
    IL_0043: ldloc.s 4
    IL_0045: ldloc.3
    IL_0046: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_004b: stloc.s 11
    IL_004d: ldloca.s 11
    IL_004f: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_0054: stloc.s 6
    IL_0056: ldloc.s 5
    IL_0058: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_005d: neg
    IL_005e: ldloc.s 5
    IL_0060: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0065: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_006a: ldloca.s 7
    IL_006c: ldloc.s 6
    IL_006e: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0073: neg
    IL_0074: ldloc.s 6
    IL_0076: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_007b: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0080: ldloc.s 7
    IL_0082: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0087: ldc.r4 2f
    IL_008c: call Vector2 UnityEngine.Vector2::op_Division(UnityEngine.Vector2,float)  /*0x0A000155*/
    IL_0091: stloc.s 8
    IL_0093: ldloc.3
    IL_0094: ldloc.s 8
    IL_0096: ldarg.1
    IL_0097: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_009c: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_00a1: stloc.s 9
    IL_00a3: ldloc.s 9
    IL_00a5: ldloc.2
    IL_00a6: call float UnityEngine.Vector2::Distance(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000157*/
    IL_00ab: ldloc.s 9
    IL_00ad: ldloc.s 4
    IL_00af: call float UnityEngine.Vector2::Distance(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000157*/
    IL_00b4: stloc.s 10
    IL_00b6: ldarg.2
    IL_00b7: blt.un.s IL_00c7
    IL_00b9: ldloc.s 10
    IL_00bb: ldarg.2
    IL_00bc: blt.un.s IL_00c7
    IL_00be: ldarg.0
    IL_00bf: ldloc.1
    IL_00c0: ldloc.s 9
    IL_00c2: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::set_Item(int,!0)  /*0x0A000158*/
    IL_00c7: ldloc.1
    IL_00c8: ldc.i4.1
    IL_00c9: add
    IL_00ca: stloc.1
    IL_00cb: ldloc.1
    IL_00cc: ldloc.0
    IL_00cd: blt IL_000e
    IL_00d2: ret

  .method CameraBounds::BevelPolygon(System.Collections.Generic.List<UnityEngine.Vector2>,float)  // token 0x06000319 rva 0xda78 attrs Public, Static, HideBySig
    // code size 216 (0xd8), max stack 3, init locals
    .locals ([0] List<Vector2>, [1] int, [2] Vector2, [3] Vector2, [4] Vector2, [5] Vector2, [6] float, [7] float, [8] Vector2, [9] Vector2, [10] Vector2)
    IL_0000: newobj void System.Collections.Generic.List<UnityEngine.Vector2>::.ctor()  /*0x0A000159*/
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br IL_00be
    IL_000d: ldarg.0
    IL_000e: ldloc.1
    IL_000f: ldc.i4.1
    IL_0010: sub
    IL_0011: ldarg.0
    IL_0012: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0017: add
    IL_0018: ldarg.0
    IL_0019: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_001e: rem
    IL_001f: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0024: stloc.2
    IL_0025: ldarg.0
    IL_0026: ldloc.1
    IL_0027: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_002c: stloc.3
    IL_002d: ldarg.0
    IL_002e: ldloc.1
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: ldarg.0
    IL_0032: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0037: rem
    IL_0038: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_003d: ldloc.2
    IL_003e: ldloc.3
    IL_003f: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0044: stloc.s 10
    IL_0046: ldloca.s 10
    IL_0048: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_004d: stloc.s 4
    IL_004f: dup
    IL_0050: ldloc.3
    IL_0051: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0056: stloc.s 10
    IL_0058: ldloca.s 10
    IL_005a: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_005f: stloc.s 5
    IL_0061: ldloc.2
    IL_0062: ldloc.3
    IL_0063: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0068: stloc.s 10
    IL_006a: ldloca.s 10
    IL_006c: call float UnityEngine.Vector2::get_magnitude()  /*0x0A00015A*/
    IL_0071: ldarg.1
    IL_0072: mul
    IL_0073: stloc.s 6
    IL_0075: ldloc.3
    IL_0076: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_007b: stloc.s 10
    IL_007d: ldloca.s 10
    IL_007f: call float UnityEngine.Vector2::get_magnitude()  /*0x0A00015A*/
    IL_0084: ldarg.1
    IL_0085: mul
    IL_0086: stloc.s 7
    IL_0088: ldloc.3
    IL_0089: ldloc.s 4
    IL_008b: ldloc.s 6
    IL_008d: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0092: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0097: stloc.s 8
    IL_0099: ldloc.3
    IL_009a: ldloc.s 5
    IL_009c: ldloc.s 7
    IL_009e: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_00a3: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_00a8: stloc.s 9
    IL_00aa: ldloc.0
    IL_00ab: ldloc.s 8
    IL_00ad: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::Add(!0)  /*0x0A00015B*/
    IL_00b2: ldloc.0
    IL_00b3: ldloc.s 9
    IL_00b5: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::Add(!0)  /*0x0A00015B*/
    IL_00ba: ldloc.1
    IL_00bb: ldc.i4.1
    IL_00bc: add
    IL_00bd: stloc.1
    IL_00be: ldloc.1
    IL_00bf: ldarg.0
    IL_00c0: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_00c5: blt IL_000d
    IL_00ca: ldarg.0
    IL_00cb: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::Clear()  /*0x0A00015C*/
    IL_00d0: ldarg.0
    IL_00d1: ldloc.0
    IL_00d2: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00015D*/
    IL_00d7: ret

  .method CameraBounds::DrawPolygonDebug(System.Collections.Generic.List<UnityEngine.Vector2>,float)  // token 0x0600031A rva 0xdb5c attrs Public, Static, HideBySig
    // code size 112 (0x70), max stack 7, init locals
    .locals ([0] int, [1] int, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_006b
    IL_000b: ldarg.0
    IL_000c: ldloc.1
    IL_000d: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0012: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0017: ldarg.1
    IL_0018: ldarg.0
    IL_0019: ldloc.1
    IL_001a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_001f: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0024: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0029: ldloca.s 2
    IL_002b: ldarg.0
    IL_002c: ldloc.1
    IL_002d: ldc.i4.1
    IL_002e: add
    IL_002f: ldloc.0
    IL_0030: rem
    IL_0031: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0036: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_003b: ldarg.1
    IL_003c: ldarg.0
    IL_003d: ldloc.1
    IL_003e: ldc.i4.1
    IL_003f: add
    IL_0040: ldloc.0
    IL_0041: rem
    IL_0042: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0047: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_004c: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0051: ldloc.2
    IL_0052: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_0057: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005c: ldc.r4 3f
    IL_0061: mul
    IL_0062: call void UnityEngine.Debug::DrawLine(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Color,float)  /*0x0A00015F*/
    IL_0067: ldloc.1
    IL_0068: ldc.i4.1
    IL_0069: add
    IL_006a: stloc.1
    IL_006b: ldloc.1
    IL_006c: ldloc.0
    IL_006d: blt.s IL_000b
    IL_006f: ret

  .method CameraBounds::MakeBoundsConvex(System.Collections.Generic.List<UnityEngine.Vector2>)  // token 0x0600031B rva 0xdbd8 attrs Public, Static, HideBySig
    // code size 174 (0xae), max stack 4, init locals
    .locals ([0] int, [1] Vector2, [2] Vector2, [3] Vector2, [4] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_00a1
    IL_0007: ldarg.0
    IL_0008: ldloc.0
    IL_0009: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_000e: stloc.1
    IL_000f: ldarg.0
    IL_0010: ldloc.0
    IL_0011: ldc.i4.1
    IL_0012: add
    IL_0013: ldarg.0
    IL_0014: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0019: rem
    IL_001a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_001f: stloc.2
    IL_0020: ldarg.0
    IL_0021: ldloc.0
    IL_0022: ldc.i4.2
    IL_0023: add
    IL_0024: ldarg.0
    IL_0025: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_002a: rem
    IL_002b: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0030: stloc.3
    IL_0031: ldloc.1
    IL_0032: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0037: ldloc.2
    IL_0038: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_003d: sub
    IL_003e: ldloc.1
    IL_003f: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0044: ldloc.2
    IL_0045: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_004a: sub
    IL_004b: call float UnityEngine.Mathf::Atan2(float,float)  /*0x0A000160*/
    IL_0050: ldc.r4 57.29578f
    IL_0055: mul
    IL_0056: ldloc.3
    IL_0057: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_005c: ldloc.2
    IL_005d: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0062: sub
    IL_0063: ldloc.3
    IL_0064: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0069: ldloc.2
    IL_006a: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_006f: sub
    IL_0070: call float UnityEngine.Mathf::Atan2(float,float)  /*0x0A000160*/
    IL_0075: ldc.r4 57.29578f
    IL_007a: mul
    IL_007b: stloc.s 4
    IL_007d: ldloc.s 4
    IL_007f: call float UnityEngine.Mathf::DeltaAngle(float,float)  /*0x0A000161*/
    IL_0084: ldc.r4 0f
    IL_0089: bgt.un.s IL_009d
    IL_008b: ldarg.0
    IL_008c: ldloc.0
    IL_008d: ldc.i4.1
    IL_008e: add
    IL_008f: ldarg.0
    IL_0090: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_0095: rem
    IL_0096: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::RemoveAt(int)  /*0x0A000162*/
    IL_009b: br.s IL_00a1
    IL_009d: ldloc.0
    IL_009e: ldc.i4.1
    IL_009f: add
    IL_00a0: stloc.0
    IL_00a1: ldloc.0
    IL_00a2: ldarg.0
    IL_00a3: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_00a8: blt IL_0007
    IL_00ad: ret

  .method CameraBounds::IsInBounds(UnityEngine.Vector2)  // token 0x0600031C rva 0xdc94 attrs Public, HideBySig
    // code size 227 (0xe3), max stack 5, init locals
    .locals ([0] bool, [1] int, [2] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: ldarg.0
    IL_0005: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_000a: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_000f: ldc.i4.1
    IL_0010: sub
    IL_0011: stloc.2
    IL_0012: br IL_00d0
    IL_0017: ldarg.0
    IL_0018: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_001d: ldloc.1
    IL_001e: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0023: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0028: ldarg.1
    IL_0029: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_002e: cgt
    IL_0030: ldarg.0
    IL_0031: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0036: ldloc.2
    IL_0037: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_003c: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0041: ldarg.1
    IL_0042: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0047: cgt
    IL_0049: beq.s IL_00ca
    IL_004b: ldarg.1
    IL_004c: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0051: ldarg.0
    IL_0052: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0057: ldloc.2
    IL_0058: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_005d: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0062: ldarg.0
    IL_0063: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0068: ldloc.1
    IL_0069: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_006e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0073: sub
    IL_0074: ldarg.1
    IL_0075: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_007a: ldarg.0
    IL_007b: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0080: ldloc.1
    IL_0081: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0086: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_008b: sub
    IL_008c: mul
    IL_008d: ldarg.0
    IL_008e: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0093: ldloc.2
    IL_0094: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_0099: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_009e: ldarg.0
    IL_009f: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_00a4: ldloc.1
    IL_00a5: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_00aa: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_00af: sub
    IL_00b0: div
    IL_00b1: ldarg.0
    IL_00b2: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_00b7: ldloc.1
    IL_00b8: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_00bd: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00c2: add
    IL_00c3: bge.un.s IL_00ca
    IL_00c5: ldloc.0
    IL_00c6: ldc.i4.0
    IL_00c7: ceq
    IL_00c9: stloc.0
    IL_00ca: ldloc.1
    IL_00cb: dup
    IL_00cc: ldc.i4.1
    IL_00cd: add
    IL_00ce: stloc.1
    IL_00cf: stloc.2
    IL_00d0: ldloc.1
    IL_00d1: ldarg.0
    IL_00d2: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_00d7: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_00dc: blt IL_0017
    IL_00e1: ldloc.0
    IL_00e2: ret

  .method CameraBounds::ClosestPointOnBounds(UnityEngine.Vector2)  // token 0x0600031D rva 0xdd84 attrs Public, HideBySig
    // code size 221 (0xdd), max stack 4, init locals
    .locals ([0] Vector2, [1] float, [2] int, [3] int, [4] Vector2, [5] Vector2, [6] float, [7] Vector2, [8] float, [9] Vector2)
    IL_0000: ldloca.s 0
    IL_0002: initobj UnityEngine.Vector2  /*0x01000069*/
    IL_0008: ldc.r4 3.4028235E+38f
    IL_000d: stloc.1
    IL_000e: ldc.i4.0
    IL_000f: stloc.2
    IL_0010: ldarg.0
    IL_0011: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0016: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_001b: ldc.i4.1
    IL_001c: sub
    IL_001d: stloc.3
    IL_001e: br IL_00ca
    IL_0023: ldarg.0
    IL_0024: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0029: ldloc.3
    IL_002a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_002f: stloc.s 4
    IL_0031: ldarg.0
    IL_0032: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0037: ldloc.2
    IL_0038: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector2>::get_Item(int)  /*0x0A00014E*/
    IL_003d: stloc.s 5
    IL_003f: ldarg.1
    IL_0040: ldloc.s 4
    IL_0042: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0047: ldloc.s 5
    IL_0049: ldloc.s 4
    IL_004b: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0050: call float UnityEngine.Vector2::Dot(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000163*/
    IL_0055: ldloc.s 5
    IL_0057: ldloc.s 4
    IL_0059: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_005e: ldloc.s 5
    IL_0060: ldloc.s 4
    IL_0062: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0067: call float UnityEngine.Vector2::Dot(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000163*/
    IL_006c: div
    IL_006d: stloc.s 6
    IL_006f: ldloc.s 6
    IL_0071: ldc.r4 0f
    IL_0076: bge.un.s IL_007e
    IL_0078: ldloc.s 4
    IL_007a: stloc.s 7
    IL_007c: br.s IL_00a6
    IL_007e: ldloc.s 6
    IL_0080: ldc.r4 1f
    IL_0085: ble.un.s IL_008d
    IL_0087: ldloc.s 5
    IL_0089: stloc.s 7
    IL_008b: br.s IL_00a6
    IL_008d: ldloc.s 4
    IL_008f: ldloc.s 6
    IL_0091: ldloc.s 5
    IL_0093: ldloc.s 4
    IL_0095: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_009a: call Vector2 UnityEngine.Vector2::op_Multiply(float,UnityEngine.Vector2)  /*0x0A000164*/
    IL_009f: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_00a4: stloc.s 7
    IL_00a6: ldloc.s 7
    IL_00a8: ldarg.1
    IL_00a9: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_00ae: stloc.s 9
    IL_00b0: ldloca.s 9
    IL_00b2: call float UnityEngine.Vector2::get_sqrMagnitude()  /*0x0A000165*/
    IL_00b7: stloc.s 8
    IL_00b9: ldloc.s 8
    IL_00bb: ldloc.1
    IL_00bc: bge.un.s IL_00c4
    IL_00be: ldloc.s 8
    IL_00c0: stloc.1
    IL_00c1: ldloc.s 7
    IL_00c3: stloc.0
    IL_00c4: ldloc.2
    IL_00c5: dup
    IL_00c6: ldc.i4.1
    IL_00c7: add
    IL_00c8: stloc.2
    IL_00c9: stloc.3
    IL_00ca: ldloc.2
    IL_00cb: ldarg.0
    IL_00cc: ldfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_00d1: callvirt int System.Collections.Generic.List<UnityEngine.Vector2>::get_Count()  /*0x0A00014D*/
    IL_00d6: blt IL_0023
    IL_00db: ldloc.0
    IL_00dc: ret

  .method CameraBounds::.ctor()  // token 0x0600031E rva 0xde6d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<UnityEngine.Vector2>::.ctor()  /*0x0A000159*/
    IL_0006: stfld List<Vector2> CameraBounds::bounds  /*0x040003D0*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<UnityEngine.Vector2>::.ctor()  /*0x0A000159*/
    IL_0011: stfld List<Vector2> CameraBounds::boundsToUse  /*0x040003D1*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_001c: ret

