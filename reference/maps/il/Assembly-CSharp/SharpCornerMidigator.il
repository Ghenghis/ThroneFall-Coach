// ===== SharpCornerMidigator  (token 0x0200028D) =====
  .method SharpCornerMidigator::get_Order()  // token 0x06000E03 rva 0x3eca5 attrs Public, Virtual, HideBySig, SpecialName
    // code size 3 (0x3), max stack 8
    IL_0000: ldc.i4.s 100
    IL_0002: ret

  .method SharpCornerMidigator::Apply(Pathfinding.Path)  // token 0x06000E04 rva 0x3ecac attrs Public, Virtual, HideBySig
    // code size 479 (0x1df), max stack 5, init locals
    .locals ([0] int, [1] Vector2, [2] List<Vector3>, [3] int)
    IL_0000: ldarg.1
    IL_0001: ldfld List<GraphNode> Pathfinding.Path::path  /*0x0A0005AF*/
    IL_0006: brfalse.s IL_002a
    IL_0008: ldarg.1
    IL_0009: ldfld List<GraphNode> Pathfinding.Path::path  /*0x0A0005AF*/
    IL_000e: callvirt int System.Collections.Generic.List<Pathfinding.GraphNode>::get_Count()  /*0x0A0005B0*/
    IL_0013: brfalse.s IL_002a
    IL_0015: ldarg.1
    IL_0016: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_001b: brfalse.s IL_002a
    IL_001d: ldarg.1
    IL_001e: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0023: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0028: brtrue.s IL_002b
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldarg.1
    IL_002d: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0032: stfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_003e: ldc.i4.0
    IL_003f: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0044: stfld Vector3 SharpCornerMidigator::pathPointLast  /*0x0400104E*/
    IL_0049: ldc.i4.1
    IL_004a: stloc.0
    IL_004b: br IL_01cb
    IL_0050: ldarg.0
    IL_0051: ldarg.0
    IL_0052: ldflda Vector3 SharpCornerMidigator::pathPointLast  /*0x0400104E*/
    IL_0057: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_005c: ldarg.0
    IL_005d: ldflda Vector3 SharpCornerMidigator::pathPointLast  /*0x0400104E*/
    IL_0062: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0067: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_006c: ldarg.0
    IL_006d: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_0072: ldloc.0
    IL_0073: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0078: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_007d: ldarg.0
    IL_007e: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_0083: ldloc.0
    IL_0084: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0089: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_008e: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0093: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_0098: stfld Vector2 SharpCornerMidigator::toLastPoint  /*0x0400104F*/
    IL_009d: ldarg.0
    IL_009e: ldarg.0
    IL_009f: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_00a4: ldloc.0
    IL_00a5: ldc.i4.1
    IL_00a6: add
    IL_00a7: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_00ac: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_00b7: ldloc.0
    IL_00b8: ldc.i4.1
    IL_00b9: add
    IL_00ba: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_00bf: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00c4: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00c9: ldarg.0
    IL_00ca: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_00cf: ldloc.0
    IL_00d0: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_00d5: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00da: ldarg.0
    IL_00db: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_00e0: ldloc.0
    IL_00e1: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_00e6: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00eb: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00f0: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_00f5: stfld Vector2 SharpCornerMidigator::toNextPoint  /*0x04001050*/
    IL_00fa: ldarg.0
    IL_00fb: ldarg.0
    IL_00fc: ldfld Vector2 SharpCornerMidigator::toLastPoint  /*0x0400104F*/
    IL_0101: ldarg.0
    IL_0102: ldfld Vector2 SharpCornerMidigator::toNextPoint  /*0x04001050*/
    IL_0107: call float UnityEngine.Vector2::Angle(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A0005B1*/
    IL_010c: stfld float SharpCornerMidigator::angle  /*0x04001051*/
    IL_0111: ldarg.0
    IL_0112: ldarg.0
    IL_0113: ldflda Vector2 SharpCornerMidigator::toLastPoint  /*0x0400104F*/
    IL_0118: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_011d: ldarg.0
    IL_011e: ldflda Vector2 SharpCornerMidigator::toNextPoint  /*0x04001050*/
    IL_0123: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_0128: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_012d: stloc.1
    IL_012e: ldloca.s 1
    IL_0130: call Vector2 UnityEngine.Vector2::get_normalized()  /*0x0A000150*/
    IL_0135: call Vector2 UnityEngine.Vector2::op_UnaryNegation(UnityEngine.Vector2)  /*0x0A0005B2*/
    IL_013a: stfld Vector2 SharpCornerMidigator::normal2d  /*0x04001052*/
    IL_013f: ldarg.0
    IL_0140: ldc.r4 180f
    IL_0145: ldarg.0
    IL_0146: ldfld float SharpCornerMidigator::angle  /*0x04001051*/
    IL_014b: sub
    IL_014c: ldc.r4 180f
    IL_0151: div
    IL_0152: stfld float SharpCornerMidigator::strngth  /*0x04001053*/
    IL_0157: ldarg.0
    IL_0158: ldarg.0
    IL_0159: ldflda Vector2 SharpCornerMidigator::normal2d  /*0x04001052*/
    IL_015e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0163: ldc.r4 0f
    IL_0168: ldarg.0
    IL_0169: ldflda Vector2 SharpCornerMidigator::normal2d  /*0x04001052*/
    IL_016e: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0173: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0178: stfld Vector3 SharpCornerMidigator::normal  /*0x04001054*/
    IL_017d: ldarg.0
    IL_017e: ldarg.0
    IL_017f: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_0184: ldloc.0
    IL_0185: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_018a: stfld Vector3 SharpCornerMidigator::pathPointLast  /*0x0400104E*/
    IL_018f: ldarg.0
    IL_0190: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_0195: stloc.2
    IL_0196: ldloc.0
    IL_0197: stloc.3
    IL_0198: ldloc.2
    IL_0199: ldloc.3
    IL_019a: ldloc.2
    IL_019b: ldloc.3
    IL_019c: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_01a1: ldarg.0
    IL_01a2: ldfld Vector3 SharpCornerMidigator::normal  /*0x04001054*/
    IL_01a7: ldarg.0
    IL_01a8: ldfld float SharpCornerMidigator::strngth  /*0x04001053*/
    IL_01ad: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01b2: ldarg.0
    IL_01b3: ldfld float SharpCornerMidigator::extendCorners  /*0x0400104C*/
    IL_01b8: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01bd: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01c2: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::set_Item(int,!0)  /*0x0A0004E0*/
    IL_01c7: ldloc.0
    IL_01c8: ldc.i4.1
    IL_01c9: add
    IL_01ca: stloc.0
    IL_01cb: ldloc.0
    IL_01cc: ldarg.0
    IL_01cd: ldfld List<Vector3> SharpCornerMidigator::path  /*0x0400104D*/
    IL_01d2: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_01d7: ldc.i4.1
    IL_01d8: sub
    IL_01d9: blt IL_0050
    IL_01de: ret

  .method SharpCornerMidigator::.ctor()  // token 0x06000E05 rva 0x3ee97 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float SharpCornerMidigator::extendCorners  /*0x0400104C*/
    IL_000b: ldarg.0
    IL_000c: call void Pathfinding.MonoModifier::.ctor()  /*0x0A0005B3*/
    IL_0011: ret

