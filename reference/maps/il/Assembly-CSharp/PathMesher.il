// ===== PathMesher  (token 0x020002A9) =====
  .method PathMesher::UpdateMesh()  // token 0x06000EAD rva 0x4172c attrs Public, HideBySig
    // code size 1495 (0x5d7), max stack 9, init locals
    .locals ([0] Mesh, [1] List<Vector3>, [2] List<Vector2>, [3] Vector3[], [4] List<int>, [5] List<int>, [6] List<PathMesher.PathPoint>, [7] float, [8] int, [9] int, [10] Transform, [11] Transform, [12] int, [13] Vector3, [14] Vector3, [15] Vector3, [16] Vector3, [17] int, [18] int, [19] int, [20] int, [21] int, [22] int, [23] int, [24] int, [25] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_0006: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Clear()  /*0x0A0005ED*/
    IL_000b: ldc.i4.0
    IL_000c: stloc.s 9
    IL_000e: br.s IL_0048
    IL_0010: ldarg.0
    IL_0011: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0016: ldloc.s 9
    IL_0018: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_001d: stloc.s 10
    IL_001f: ldarg.0
    IL_0020: ldfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_0025: ldloc.s 10
    IL_0027: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_002c: ldloc.s 10
    IL_002e: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0033: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0038: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_003d: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_0042: ldloc.s 9
    IL_0044: ldc.i4.1
    IL_0045: add
    IL_0046: stloc.s 9
    IL_0048: ldloc.s 9
    IL_004a: ldarg.0
    IL_004b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0050: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0055: blt.s IL_0010
    IL_0057: ldarg.0
    IL_0058: ldfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_005d: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0062: ldc.i4.2
    IL_0063: bge.s IL_0066
    IL_0065: ret
    IL_0066: ldarg.0
    IL_0067: ldfld bool PathMesher::loop  /*0x040010FF*/
    IL_006c: brfalse.s IL_009f
    IL_006e: ldarg.0
    IL_006f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0074: ldc.i4.0
    IL_0075: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_007a: stloc.s 11
    IL_007c: ldarg.0
    IL_007d: ldfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_0082: ldloc.s 11
    IL_0084: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0089: ldloc.s 11
    IL_008b: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0090: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0095: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_009a: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_009f: ldarg.0
    IL_00a0: ldarg.0
    IL_00a1: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.MeshFilter>  /*0x2B00009A*/
    IL_00a6: stfld MeshFilter PathMesher::meshFilter  /*0x040010F2*/
    IL_00ab: ldarg.0
    IL_00ac: ldarg.0
    IL_00ad: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.MeshCollider>  /*0x2B0000D2*/
    IL_00b2: stfld MeshCollider PathMesher::meshCollider  /*0x040010F3*/
    IL_00b7: newobj void UnityEngine.Mesh::.ctor()  /*0x0A000498*/
    IL_00bc: stloc.0
    IL_00bd: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_00c2: stloc.1
    IL_00c3: newobj void System.Collections.Generic.List<UnityEngine.Vector2>::.ctor()  /*0x0A000159*/
    IL_00c8: stloc.2
    IL_00c9: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_00ce: stloc.s 4
    IL_00d0: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_00d5: stloc.s 5
    IL_00d7: newobj void System.Collections.Generic.List<PathMesher.PathPoint>::.ctor()  /*0x0A0005F0*/
    IL_00dc: stloc.s 6
    IL_00de: ldarg.0
    IL_00df: ldarg.0
    IL_00e0: ldfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_00e5: ldloc.s 6
    IL_00e7: ldarg.0
    IL_00e8: ldfld int PathMesher::subdivisions  /*0x040010F5*/
    IL_00ed: call void PathMesher::InterpolateModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,System.Collections.Generic.List<PathMesher.PathPoint>,int)  /*0x06000EB0*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld float PathMesher::vertDistance  /*0x040010F6*/
    IL_00f8: ldc.r4 0.1f
    IL_00fd: ble.un.s IL_0119
    IL_00ff: ldarg.0
    IL_0100: ldloca.s 6
    IL_0102: ldarg.0
    IL_0103: ldfld float PathMesher::vertDistance  /*0x040010F6*/
    IL_0108: ldarg.0
    IL_0109: ldfld float PathMesher::vertDistance  /*0x040010F6*/
    IL_010e: ldc.r4 10f
    IL_0113: div
    IL_0114: call void PathMesher::ResampleModifyer(ref System.Collections.Generic.List<PathMesher.PathPoint>,float,float)  /*0x06000EB1*/
    IL_0119: ldarg.0
    IL_011a: ldloc.s 6
    IL_011c: ldarg.0
    IL_011d: ldfld int PathMesher::endCapSubdivisions  /*0x040010F7*/
    IL_0122: call void PathMesher::AddRoundedEndsModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,int)  /*0x06000EB3*/
    IL_0127: ldarg.0
    IL_0128: ldloc.s 6
    IL_012a: ldarg.0
    IL_012b: ldfld float PathMesher::widthWhobble  /*0x040010F8*/
    IL_0130: ldarg.0
    IL_0131: ldfld float PathMesher::positionWhobble  /*0x040010F9*/
    IL_0136: call void PathMesher::WhobbleModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,float,float)  /*0x06000EB2*/
    IL_013b: ldc.r4 0f
    IL_0140: stloc.s 7
    IL_0142: ldc.i4.0
    IL_0143: stloc.s 12
    IL_0145: br IL_028a
    IL_014a: ldarg.0
    IL_014b: ldloc.s 12
    IL_014d: ldloc.s 6
    IL_014f: ldc.i4.1
    IL_0150: call Vector3 PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  /*0x06000EB4*/
    IL_0155: stloc.s 13
    IL_0157: ldc.r4 0f
    IL_015c: ldc.r4 90f
    IL_0161: ldc.r4 0f
    IL_0166: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_016b: ldloc.s 13
    IL_016d: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0172: ldloc.s 6
    IL_0174: ldloc.s 12
    IL_0176: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_017b: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0180: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0185: stloc.s 14
    IL_0187: ldc.r4 0f
    IL_018c: ldc.r4 -90f
    IL_0191: ldc.r4 0f
    IL_0196: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_019b: ldloc.s 13
    IL_019d: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_01a2: ldloc.s 6
    IL_01a4: ldloc.s 12
    IL_01a6: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_01ab: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_01b0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01b5: stloc.s 15
    IL_01b7: ldarg.0
    IL_01b8: ldfld bool PathMesher::vertical  /*0x040010FE*/
    IL_01bd: brfalse.s IL_01f3
    IL_01bf: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01c4: ldloc.s 6
    IL_01c6: ldloc.s 12
    IL_01c8: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_01cd: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_01d2: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01d7: stloc.s 14
    IL_01d9: call Vector3 UnityEngine.Vector3::get_down()  /*0x0A00016E*/
    IL_01de: ldloc.s 6
    IL_01e0: ldloc.s 12
    IL_01e2: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_01e7: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_01ec: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01f1: stloc.s 15
    IL_01f3: ldarg.0
    IL_01f4: ldloc.s 6
    IL_01f6: ldloc.s 12
    IL_01f8: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_01fd: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0202: ldloc.s 14
    IL_0204: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0209: ldloc.1
    IL_020a: ldloc.2
    IL_020b: ldloc.s 7
    IL_020d: ldloc.s 6
    IL_020f: ldloc.s 12
    IL_0211: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0216: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_021b: neg
    IL_021c: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_0221: ldarg.0
    IL_0222: ldloc.s 6
    IL_0224: ldloc.s 12
    IL_0226: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_022b: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0230: ldloc.s 15
    IL_0232: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0237: ldloc.1
    IL_0238: ldloc.2
    IL_0239: ldloc.s 7
    IL_023b: ldloc.s 6
    IL_023d: ldloc.s 12
    IL_023f: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0244: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0249: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_024e: ldloc.s 12
    IL_0250: ldc.i4.0
    IL_0251: ble.s IL_0284
    IL_0253: ldloc.s 7
    IL_0255: ldloc.s 6
    IL_0257: ldloc.s 12
    IL_0259: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_025e: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0263: ldloc.s 6
    IL_0265: ldloc.s 12
    IL_0267: ldc.i4.1
    IL_0268: sub
    IL_0269: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_026e: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0273: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0278: stloc.s 16
    IL_027a: ldloca.s 16
    IL_027c: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0281: add
    IL_0282: stloc.s 7
    IL_0284: ldloc.s 12
    IL_0286: ldc.i4.1
    IL_0287: add
    IL_0288: stloc.s 12
    IL_028a: ldloc.s 12
    IL_028c: ldloc.s 6
    IL_028e: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0293: bge.s IL_02a2
    IL_0295: ldloc.s 6
    IL_0297: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_029c: ldc.i4.1
    IL_029d: bgt IL_014a
    IL_02a2: ldloc.1
    IL_02a3: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_02a8: stloc.s 8
    IL_02aa: ldarg.0
    IL_02ab: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_02b0: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_02b5: ldc.r4 0f
    IL_02ba: beq IL_03b4
    IL_02bf: ldc.r4 0f
    IL_02c4: stloc.s 7
    IL_02c6: ldc.i4.0
    IL_02c7: stloc.s 17
    IL_02c9: br IL_03ac
    IL_02ce: ldc.i4.0
    IL_02cf: stloc.s 18
    IL_02d1: ldloc.s 17
    IL_02d3: stloc.s 19
    IL_02d5: br IL_039b
    IL_02da: ldarg.0
    IL_02db: ldloc.1
    IL_02dc: ldloc.s 19
    IL_02de: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_02e3: ldloc.1
    IL_02e4: ldloc.2
    IL_02e5: ldloc.s 7
    IL_02e7: ldc.r4 0f
    IL_02ec: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_02f1: ldarg.0
    IL_02f2: ldloc.1
    IL_02f3: ldloc.s 19
    IL_02f5: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_02fa: ldarg.0
    IL_02fb: ldfld Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_0300: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0305: ldloc.1
    IL_0306: ldloc.2
    IL_0307: ldloc.s 7
    IL_0309: ldarg.0
    IL_030a: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_030f: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0314: neg
    IL_0315: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_031a: ldloc.s 7
    IL_031c: ldloc.s 6
    IL_031e: ldloc.s 18
    IL_0320: ldc.i4.1
    IL_0321: add
    IL_0322: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0327: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_032c: ldloc.s 6
    IL_032e: ldloc.s 18
    IL_0330: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0335: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_033a: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_033f: stloc.s 16
    IL_0341: ldloca.s 16
    IL_0343: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0348: add
    IL_0349: stloc.s 7
    IL_034b: ldloc.s 18
    IL_034d: ldc.i4.1
    IL_034e: add
    IL_034f: stloc.s 18
    IL_0351: ldarg.0
    IL_0352: ldloc.1
    IL_0353: ldloc.s 19
    IL_0355: ldc.i4.2
    IL_0356: add
    IL_0357: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_035c: ldloc.1
    IL_035d: ldloc.2
    IL_035e: ldloc.s 7
    IL_0360: ldc.r4 0f
    IL_0365: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_036a: ldarg.0
    IL_036b: ldloc.1
    IL_036c: ldloc.s 19
    IL_036e: ldc.i4.2
    IL_036f: add
    IL_0370: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0375: ldarg.0
    IL_0376: ldfld Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_037b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0380: ldloc.1
    IL_0381: ldloc.2
    IL_0382: ldloc.s 7
    IL_0384: ldarg.0
    IL_0385: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_038a: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_038f: neg
    IL_0390: call void PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  /*0x06000EAF*/
    IL_0395: ldloc.s 19
    IL_0397: ldc.i4.2
    IL_0398: add
    IL_0399: stloc.s 19
    IL_039b: ldloc.s 19
    IL_039d: ldloc.s 8
    IL_039f: ldc.i4.2
    IL_03a0: sub
    IL_03a1: blt IL_02da
    IL_03a6: ldloc.s 17
    IL_03a8: ldc.i4.1
    IL_03a9: add
    IL_03aa: stloc.s 17
    IL_03ac: ldloc.s 17
    IL_03ae: ldc.i4.1
    IL_03af: ble IL_02ce
    IL_03b4: ldloc.1
    IL_03b5: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_03ba: newarr UnityEngine.Vector3  /*0x01000028*/
    IL_03bf: stloc.3
    IL_03c0: ldc.i4.0
    IL_03c1: stloc.s 20
    IL_03c3: br.s IL_0413
    IL_03c5: ldloc.s 20
    IL_03c7: ldc.i4.2
    IL_03c8: mul
    IL_03c9: stloc.s 21
    IL_03cb: ldarg.0
    IL_03cc: ldloc.s 21
    IL_03ce: ldc.i4.2
    IL_03cf: add
    IL_03d0: ldloc.s 21
    IL_03d2: ldc.i4.1
    IL_03d3: add
    IL_03d4: ldloc.s 21
    IL_03d6: ldloc.s 4
    IL_03d8: ldloc.3
    IL_03d9: ldloc.1
    IL_03da: ldarg.0
    IL_03db: ldfld bool PathMesher::topNormalsAlwaysFaceDirectlyUp  /*0x040010FC*/
    IL_03e0: ldarg.0
    IL_03e1: ldfld bool PathMesher::vertical  /*0x040010FE*/
    IL_03e6: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_03eb: ldarg.0
    IL_03ec: ldloc.s 21
    IL_03ee: ldc.i4.1
    IL_03ef: add
    IL_03f0: ldloc.s 21
    IL_03f2: ldc.i4.2
    IL_03f3: add
    IL_03f4: ldloc.s 21
    IL_03f6: ldc.i4.3
    IL_03f7: add
    IL_03f8: ldloc.s 4
    IL_03fa: ldloc.3
    IL_03fb: ldloc.1
    IL_03fc: ldarg.0
    IL_03fd: ldfld bool PathMesher::topNormalsAlwaysFaceDirectlyUp  /*0x040010FC*/
    IL_0402: ldarg.0
    IL_0403: ldfld bool PathMesher::vertical  /*0x040010FE*/
    IL_0408: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_040d: ldloc.s 20
    IL_040f: ldc.i4.1
    IL_0410: add
    IL_0411: stloc.s 20
    IL_0413: ldloc.s 20
    IL_0415: ldloc.s 6
    IL_0417: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_041c: ldc.i4.1
    IL_041d: sub
    IL_041e: bge.s IL_042a
    IL_0420: ldloc.s 6
    IL_0422: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0427: ldc.i4.1
    IL_0428: bgt.s IL_03c5
    IL_042a: ldarg.0
    IL_042b: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_0430: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0435: ldc.r4 0f
    IL_043a: beq IL_052f
    IL_043f: ldloc.s 8
    IL_0441: stloc.s 22
    IL_0443: ldc.i4.0
    IL_0444: stloc.s 24
    IL_0446: br.s IL_0482
    IL_0448: ldarg.0
    IL_0449: ldloc.s 22
    IL_044b: ldloc.s 22
    IL_044d: ldc.i4.1
    IL_044e: add
    IL_044f: ldloc.s 22
    IL_0451: ldc.i4.2
    IL_0452: add
    IL_0453: ldloc.s 5
    IL_0455: ldloc.3
    IL_0456: ldloc.1
    IL_0457: ldc.i4.0
    IL_0458: ldc.i4.1
    IL_0459: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_045e: ldarg.0
    IL_045f: ldloc.s 22
    IL_0461: ldc.i4.3
    IL_0462: add
    IL_0463: ldloc.s 22
    IL_0465: ldc.i4.2
    IL_0466: add
    IL_0467: ldloc.s 22
    IL_0469: ldc.i4.1
    IL_046a: add
    IL_046b: ldloc.s 5
    IL_046d: ldloc.3
    IL_046e: ldloc.1
    IL_046f: ldc.i4.0
    IL_0470: ldc.i4.1
    IL_0471: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_0476: ldloc.s 22
    IL_0478: ldc.i4.4
    IL_0479: add
    IL_047a: stloc.s 22
    IL_047c: ldloc.s 24
    IL_047e: ldc.i4.2
    IL_047f: add
    IL_0480: stloc.s 24
    IL_0482: ldloc.s 24
    IL_0484: ldloc.s 8
    IL_0486: ldc.i4.2
    IL_0487: sub
    IL_0488: blt.s IL_0448
    IL_048a: ldloc.s 22
    IL_048c: stloc.s 23
    IL_048e: ldc.i4.1
    IL_048f: stloc.s 25
    IL_0491: br.s IL_04cd
    IL_0493: ldarg.0
    IL_0494: ldloc.s 22
    IL_0496: ldc.i4.2
    IL_0497: add
    IL_0498: ldloc.s 22
    IL_049a: ldc.i4.1
    IL_049b: add
    IL_049c: ldloc.s 22
    IL_049e: ldloc.s 5
    IL_04a0: ldloc.3
    IL_04a1: ldloc.1
    IL_04a2: ldc.i4.0
    IL_04a3: ldc.i4.1
    IL_04a4: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_04a9: ldarg.0
    IL_04aa: ldloc.s 22
    IL_04ac: ldc.i4.1
    IL_04ad: add
    IL_04ae: ldloc.s 22
    IL_04b0: ldc.i4.2
    IL_04b1: add
    IL_04b2: ldloc.s 22
    IL_04b4: ldc.i4.3
    IL_04b5: add
    IL_04b6: ldloc.s 5
    IL_04b8: ldloc.3
    IL_04b9: ldloc.1
    IL_04ba: ldc.i4.0
    IL_04bb: ldc.i4.1
    IL_04bc: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_04c1: ldloc.s 22
    IL_04c3: ldc.i4.4
    IL_04c4: add
    IL_04c5: stloc.s 22
    IL_04c7: ldloc.s 25
    IL_04c9: ldc.i4.2
    IL_04ca: add
    IL_04cb: stloc.s 25
    IL_04cd: ldloc.s 25
    IL_04cf: ldloc.s 8
    IL_04d1: ldc.i4.2
    IL_04d2: sub
    IL_04d3: blt.s IL_0493
    IL_04d5: ldarg.0
    IL_04d6: ldloc.s 23
    IL_04d8: ldloc.s 8
    IL_04da: ldc.i4.1
    IL_04db: add
    IL_04dc: ldloc.s 8
    IL_04de: ldloc.s 5
    IL_04e0: ldloc.3
    IL_04e1: ldloc.1
    IL_04e2: ldc.i4.0
    IL_04e3: ldc.i4.1
    IL_04e4: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_04e9: ldarg.0
    IL_04ea: ldloc.s 8
    IL_04ec: ldc.i4.1
    IL_04ed: add
    IL_04ee: ldloc.s 23
    IL_04f0: ldloc.s 23
    IL_04f2: ldc.i4.1
    IL_04f3: add
    IL_04f4: ldloc.s 5
    IL_04f6: ldloc.3
    IL_04f7: ldloc.1
    IL_04f8: ldc.i4.0
    IL_04f9: ldc.i4.1
    IL_04fa: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_04ff: ldarg.0
    IL_0500: ldloc.s 23
    IL_0502: ldc.i4.2
    IL_0503: sub
    IL_0504: ldloc.s 23
    IL_0506: ldc.i4.1
    IL_0507: sub
    IL_0508: ldloc.s 22
    IL_050a: ldc.i4.2
    IL_050b: sub
    IL_050c: ldloc.s 5
    IL_050e: ldloc.3
    IL_050f: ldloc.1
    IL_0510: ldc.i4.0
    IL_0511: ldc.i4.1
    IL_0512: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_0517: ldarg.0
    IL_0518: ldloc.s 22
    IL_051a: ldc.i4.1
    IL_051b: sub
    IL_051c: ldloc.s 22
    IL_051e: ldc.i4.2
    IL_051f: sub
    IL_0520: ldloc.s 23
    IL_0522: ldc.i4.1
    IL_0523: sub
    IL_0524: ldloc.s 5
    IL_0526: ldloc.3
    IL_0527: ldloc.1
    IL_0528: ldc.i4.0
    IL_0529: ldc.i4.1
    IL_052a: call void PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  /*0x06000EAE*/
    IL_052f: ldloc.0
    IL_0530: ldarg.0
    IL_0531: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_0536: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_053b: ldc.r4 0f
    IL_0540: bne.un.s IL_0545
    IL_0542: ldc.i4.1
    IL_0543: br.s IL_0546
    IL_0545: ldc.i4.2
    IL_0546: callvirt void UnityEngine.Mesh::set_subMeshCount(int)  /*0x0A0005F2*/
    IL_054b: ldloc.0
    IL_054c: ldloc.1
    IL_054d: callvirt void UnityEngine.Mesh::SetVertices(System.Collections.Generic.List<UnityEngine.Vector3>)  /*0x0A0004A4*/
    IL_0552: ldloc.0
    IL_0553: ldloc.s 4
    IL_0555: ldc.i4.0
    IL_0556: callvirt void UnityEngine.Mesh::SetTriangles(System.Collections.Generic.List<int>,int)  /*0x0A0004A5*/
    IL_055b: ldarg.0
    IL_055c: ldflda Vector3 PathMesher::extrudeDownOffset  /*0x040010FD*/
    IL_0561: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0566: ldc.r4 0f
    IL_056b: beq.s IL_0576
    IL_056d: ldloc.0
    IL_056e: ldloc.s 5
    IL_0570: ldc.i4.1
    IL_0571: callvirt void UnityEngine.Mesh::SetTriangles(System.Collections.Generic.List<int>,int)  /*0x0A0004A5*/
    IL_0576: ldloc.0
    IL_0577: ldc.i4.0
    IL_0578: ldloc.2
    IL_0579: callvirt void UnityEngine.Mesh::SetUVs(int,System.Collections.Generic.List<UnityEngine.Vector2>)  /*0x0A0005F3*/
    IL_057e: ldloc.0
    IL_057f: ldloc.3
    IL_0580: callvirt void UnityEngine.Mesh::SetNormals(UnityEngine.Vector3[])  /*0x0A0005F4*/
    IL_0585: ldloc.0
    IL_0586: callvirt void UnityEngine.Mesh::RecalculateBounds()  /*0x0A0005F5*/
    IL_058b: ldarg.0
    IL_058c: ldfld MeshFilter PathMesher::meshFilter  /*0x040010F2*/
    IL_0591: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0596: brfalse.s IL_05bd
    IL_0598: ldarg.0
    IL_0599: ldfld MeshFilter PathMesher::meshFilter  /*0x040010F2*/
    IL_059e: ldloc.0
    IL_059f: callvirt void UnityEngine.MeshFilter::set_sharedMesh(UnityEngine.Mesh)  /*0x0A0005F6*/
    IL_05a4: ldarg.0
    IL_05a5: ldfld MeshFilter PathMesher::_shadowMesh  /*0x040010F4*/
    IL_05aa: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_05af: brfalse.s IL_05bd
    IL_05b1: ldarg.0
    IL_05b2: ldfld MeshFilter PathMesher::_shadowMesh  /*0x040010F4*/
    IL_05b7: ldloc.0
    IL_05b8: callvirt void UnityEngine.MeshFilter::set_sharedMesh(UnityEngine.Mesh)  /*0x0A0005F6*/
    IL_05bd: ldarg.0
    IL_05be: ldfld MeshCollider PathMesher::meshCollider  /*0x040010F3*/
    IL_05c3: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_05c8: brfalse.s IL_05d6
    IL_05ca: ldarg.0
    IL_05cb: ldfld MeshCollider PathMesher::meshCollider  /*0x040010F3*/
    IL_05d0: ldloc.0
    IL_05d1: callvirt void UnityEngine.MeshCollider::set_sharedMesh(UnityEngine.Mesh)  /*0x0A0005F7*/
    IL_05d6: ret

  .method PathMesher::ConnectTriangle(int,int,int,System.Collections.Generic.List<int>,UnityEngine.Vector3[],System.Collections.Generic.List<UnityEngine.Vector3>,bool,bool)  // token 0x06000EAE rva 0x41d10 attrs Public, HideBySig
    // code size 184 (0xb8), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathMesher::flipNormals  /*0x04001100*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.1
    IL_0009: ldarg.3
    IL_000a: starg.s 1
    IL_000c: starg.s 3
    IL_000e: ldarg.s 6
    IL_0010: ldarg.1
    IL_0011: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0016: ldarg.s 6
    IL_0018: ldarg.2
    IL_0019: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_001e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0023: ldarg.s 6
    IL_0025: ldarg.3
    IL_0026: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_002b: ldarg.s 6
    IL_002d: ldarg.2
    IL_002e: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0033: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0038: call Vector3 UnityEngine.Vector3::Cross(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0005F8*/
    IL_003d: stloc.1
    IL_003e: ldloca.s 1
    IL_0040: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0045: stloc.0
    IL_0046: ldloc.0
    IL_0047: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_004c: ldc.r4 0f
    IL_0051: cgt
    IL_0053: ldarg.s 8
    IL_0055: or
    IL_0056: brfalse.s IL_00b7
    IL_0058: ldarg.s 4
    IL_005a: ldarg.3
    IL_005b: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0060: ldarg.s 4
    IL_0062: ldarg.2
    IL_0063: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0068: ldarg.s 4
    IL_006a: ldarg.1
    IL_006b: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0070: ldarg.s 7
    IL_0072: brfalse.s IL_009c
    IL_0074: ldarg.s 5
    IL_0076: ldarg.3
    IL_0077: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_007c: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_0081: ldarg.s 5
    IL_0083: ldarg.2
    IL_0084: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0089: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_008e: ldarg.s 5
    IL_0090: ldarg.1
    IL_0091: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0096: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_009b: ret
    IL_009c: ldarg.s 5
    IL_009e: ldarg.3
    IL_009f: ldloc.0
    IL_00a0: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_00a5: ldarg.s 5
    IL_00a7: ldarg.2
    IL_00a8: ldloc.0
    IL_00a9: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_00ae: ldarg.s 5
    IL_00b0: ldarg.1
    IL_00b1: ldloc.0
    IL_00b2: stelem UnityEngine.Vector3  /*0x01000028*/
    IL_00b7: ret

  .method PathMesher::AddUnwrappedVertTop(UnityEngine.Vector3,System.Collections.Generic.List<UnityEngine.Vector3>,System.Collections.Generic.List<UnityEngine.Vector2>,float,float)  // token 0x06000EAF rva 0x41dd4 attrs Public, HideBySig
    // code size 114 (0x72), max stack 4, init locals
    .locals ([0] Matrix4x4)
    IL_0000: ldarg.2
    IL_0001: ldarg.1
    IL_0002: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_0007: ldarg.0
    IL_0008: ldfld PathMesher.UnwrapMode PathMesher::uvUnwrapMode  /*0x040010FA*/
    IL_000d: brtrue.s IL_004b
    IL_000f: ldarg.0
    IL_0010: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0015: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_001a: stloc.0
    IL_001b: ldloca.s 0
    IL_001d: ldarg.1
    IL_001e: call Vector3 UnityEngine.Matrix4x4::MultiplyPoint(UnityEngine.Vector3)  /*0x0A0000A5*/
    IL_0023: starg.s 1
    IL_0025: ldarg.3
    IL_0026: ldarg.1
    IL_0027: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_002c: ldarg.0
    IL_002d: ldfld float PathMesher::uvScale  /*0x040010FB*/
    IL_0032: mul
    IL_0033: ldarg.1
    IL_0034: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0039: ldarg.0
    IL_003a: ldfld float PathMesher::uvScale  /*0x040010FB*/
    IL_003f: mul
    IL_0040: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0045: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::Add(!0)  /*0x0A00015B*/
    IL_004a: ret
    IL_004b: ldarg.0
    IL_004c: ldfld PathMesher.UnwrapMode PathMesher::uvUnwrapMode  /*0x040010FA*/
    IL_0051: ldc.i4.1
    IL_0052: bne.un.s IL_0071
    IL_0054: ldarg.3
    IL_0055: ldarg.s 4
    IL_0057: ldarg.0
    IL_0058: ldfld float PathMesher::uvScale  /*0x040010FB*/
    IL_005d: mul
    IL_005e: ldarg.s 5
    IL_0060: ldarg.0
    IL_0061: ldfld float PathMesher::uvScale  /*0x040010FB*/
    IL_0066: mul
    IL_0067: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_006c: callvirt void System.Collections.Generic.List<UnityEngine.Vector2>::Add(!0)  /*0x0A00015B*/
    IL_0071: ret

  .method PathMesher::InterpolateModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,System.Collections.Generic.List<PathMesher.PathPoint>,int)  // token 0x06000EB0 rva 0x41e54 attrs Public, HideBySig
    // code size 281 (0x119), max stack 5, init locals
    .locals ([0] int, [1] int, [2] float, [3] float, [4] Vector3, [5] Vector3, [6] Vector3, [7] float, [8] PathMesher.PathPoint, [9] Vector3)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_00f6
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br IL_00eb
    IL_000e: ldloc.1
    IL_000f: conv.r4
    IL_0010: ldarg.3
    IL_0011: conv.r4
    IL_0012: div
    IL_0013: stloc.2
    IL_0014: ldarg.1
    IL_0015: ldloc.0
    IL_0016: ldc.i4.1
    IL_0017: add
    IL_0018: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_001d: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0022: ldarg.1
    IL_0023: ldloc.0
    IL_0024: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0029: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_002e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0033: stloc.s 9
    IL_0035: ldloca.s 9
    IL_0037: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_003c: stloc.3
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: ldarg.1
    IL_0040: ldc.i4.1
    IL_0041: call Vector3 PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  /*0x06000EB4*/
    IL_0046: stloc.s 4
    IL_0048: ldarg.0
    IL_0049: ldloc.0
    IL_004a: ldc.i4.1
    IL_004b: add
    IL_004c: ldarg.1
    IL_004d: ldc.i4.1
    IL_004e: call Vector3 PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  /*0x06000EB4*/
    IL_0053: stloc.s 5
    IL_0055: ldarg.1
    IL_0056: ldloc.0
    IL_0057: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_005c: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0061: ldloc.2
    IL_0062: ldloc.s 4
    IL_0064: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0069: ldloc.3
    IL_006a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0074: ldarg.1
    IL_0075: ldloc.0
    IL_0076: ldc.i4.1
    IL_0077: add
    IL_0078: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_007d: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0082: ldc.r4 1f
    IL_0087: ldloc.2
    IL_0088: sub
    IL_0089: ldloc.s 5
    IL_008b: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0090: ldloc.3
    IL_0091: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0096: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_009b: stloc.s 6
    IL_009d: ldloc.s 6
    IL_009f: ldc.r4 0f
    IL_00a4: ldc.r4 1f
    IL_00a9: ldloc.2
    IL_00aa: call float UnityEngine.Mathf::SmoothStep(float,float,float)  /*0x0A0003A9*/
    IL_00af: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00b4: ldarg.1
    IL_00b5: ldloc.0
    IL_00b6: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_00bb: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_00c0: ldarg.1
    IL_00c1: ldloc.0
    IL_00c2: ldc.i4.1
    IL_00c3: add
    IL_00c4: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_00c9: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_00ce: ldloc.2
    IL_00cf: call float UnityEngine.Mathf::SmoothStep(float,float,float)  /*0x0A0003A9*/
    IL_00d4: stloc.s 7
    IL_00d6: ldloc.s 7
    IL_00d8: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_00dd: stloc.s 8
    IL_00df: ldarg.2
    IL_00e0: ldloc.s 8
    IL_00e2: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_00e7: ldloc.1
    IL_00e8: ldc.i4.1
    IL_00e9: add
    IL_00ea: stloc.1
    IL_00eb: ldloc.1
    IL_00ec: ldarg.3
    IL_00ed: blt IL_000e
    IL_00f2: ldloc.0
    IL_00f3: ldc.i4.1
    IL_00f4: add
    IL_00f5: stloc.0
    IL_00f6: ldloc.0
    IL_00f7: ldarg.1
    IL_00f8: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_00fd: ldc.i4.1
    IL_00fe: sub
    IL_00ff: blt IL_0007
    IL_0104: ldarg.2
    IL_0105: ldarg.1
    IL_0106: ldarg.1
    IL_0107: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_010c: ldc.i4.1
    IL_010d: sub
    IL_010e: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0113: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_0118: ret

  .method PathMesher::ResampleModifyer(ref System.Collections.Generic.List<PathMesher.PathPoint>,float,float)  // token 0x06000EB1 rva 0x41f7c attrs Public, HideBySig
    // code size 276 (0x114), max stack 4, init locals
    .locals ([0] List<PathMesher.PathPoint>, [1] Vector3, [2] float, [3] float, [4] int, [5] int, [6] Vector3, [7] int, [8] float)
    IL_0000: ldarg.1
    IL_0001: ldind.ref
    IL_0002: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0007: ldc.i4.2
    IL_0008: bge.s IL_000b
    IL_000a: ret
    IL_000b: newobj void System.Collections.Generic.List<PathMesher.PathPoint>::.ctor()  /*0x0A0005F0*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldarg.1
    IL_0013: ldind.ref
    IL_0014: ldc.i4.0
    IL_0015: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_001a: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_001f: ldc.r4 0f
    IL_0024: stloc.3
    IL_0025: ldc.i4.0
    IL_0026: stloc.s 4
    IL_0028: br IL_00ea
    IL_002d: ldarg.1
    IL_002e: ldind.ref
    IL_002f: ldloc.s 4
    IL_0031: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0036: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_003b: ldarg.1
    IL_003c: ldind.ref
    IL_003d: ldloc.s 4
    IL_003f: ldc.i4.1
    IL_0040: add
    IL_0041: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0046: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_004b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0050: stloc.s 6
    IL_0052: ldloca.s 6
    IL_0054: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0059: ldarg.3
    IL_005a: div
    IL_005b: call float UnityEngine.Mathf::Ceil(float)  /*0x0A0005F9*/
    IL_0060: conv.i4
    IL_0061: stloc.s 5
    IL_0063: ldc.i4.0
    IL_0064: stloc.s 7
    IL_0066: br.s IL_00de
    IL_0068: ldloc.3
    IL_0069: ldarg.3
    IL_006a: add
    IL_006b: stloc.3
    IL_006c: ldloc.3
    IL_006d: ldarg.2
    IL_006e: blt.un.s IL_00d8
    IL_0070: ldloc.s 7
    IL_0072: conv.r4
    IL_0073: ldloc.s 5
    IL_0075: conv.r4
    IL_0076: div
    IL_0077: stloc.s 8
    IL_0079: ldarg.1
    IL_007a: ldind.ref
    IL_007b: ldloc.s 4
    IL_007d: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0082: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0087: ldarg.1
    IL_0088: ldind.ref
    IL_0089: ldloc.s 4
    IL_008b: ldc.i4.1
    IL_008c: add
    IL_008d: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0092: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0097: ldloc.s 8
    IL_0099: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_009e: stloc.1
    IL_009f: ldarg.1
    IL_00a0: ldind.ref
    IL_00a1: ldloc.s 4
    IL_00a3: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_00a8: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_00ad: ldarg.1
    IL_00ae: ldind.ref
    IL_00af: ldloc.s 4
    IL_00b1: ldc.i4.1
    IL_00b2: add
    IL_00b3: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_00b8: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_00bd: ldloc.s 8
    IL_00bf: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00c4: stloc.2
    IL_00c5: ldc.r4 0f
    IL_00ca: stloc.3
    IL_00cb: ldloc.0
    IL_00cc: ldloc.1
    IL_00cd: ldloc.2
    IL_00ce: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_00d3: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_00d8: ldloc.s 7
    IL_00da: ldc.i4.1
    IL_00db: add
    IL_00dc: stloc.s 7
    IL_00de: ldloc.s 7
    IL_00e0: ldloc.s 5
    IL_00e2: blt.s IL_0068
    IL_00e4: ldloc.s 4
    IL_00e6: ldc.i4.1
    IL_00e7: add
    IL_00e8: stloc.s 4
    IL_00ea: ldloc.s 4
    IL_00ec: ldarg.1
    IL_00ed: ldind.ref
    IL_00ee: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_00f3: ldc.i4.1
    IL_00f4: sub
    IL_00f5: blt IL_002d
    IL_00fa: ldloc.0
    IL_00fb: ldarg.1
    IL_00fc: ldind.ref
    IL_00fd: ldarg.1
    IL_00fe: ldind.ref
    IL_00ff: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0104: ldc.i4.1
    IL_0105: sub
    IL_0106: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_010b: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_0110: ldarg.1
    IL_0111: ldloc.0
    IL_0112: stind.ref
    IL_0113: ret

  .method PathMesher::WhobbleModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,float,float)  // token 0x06000EB2 rva 0x4209c attrs Public, HideBySig
    // code size 130 (0x82), max stack 6, init locals
    .locals ([0] int)
    IL_0000: ldarg.1
    IL_0001: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0006: ldc.i4.7
    IL_0007: mul
    IL_0008: call void UnityEngine.Random::InitState(int)  /*0x0A000294*/
    IL_000d: ldc.i4.0
    IL_000e: stloc.0
    IL_000f: br.s IL_0078
    IL_0011: ldarg.1
    IL_0012: ldloc.0
    IL_0013: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0018: dup
    IL_0019: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_001e: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0023: ldc.r4 0.5f
    IL_0028: sub
    IL_0029: ldc.r4 0f
    IL_002e: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0033: ldc.r4 0.5f
    IL_0038: sub
    IL_0039: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_003e: ldarg.3
    IL_003f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0044: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0049: stfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_004e: ldarg.1
    IL_004f: ldloc.0
    IL_0050: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0055: dup
    IL_0056: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_005b: ldc.r4 1f
    IL_0060: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0065: ldc.r4 0.5f
    IL_006a: sub
    IL_006b: ldarg.2
    IL_006c: mul
    IL_006d: add
    IL_006e: mul
    IL_006f: stfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0074: ldloc.0
    IL_0075: ldc.i4.1
    IL_0076: add
    IL_0077: stloc.0
    IL_0078: ldloc.0
    IL_0079: ldarg.1
    IL_007a: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_007f: blt.s IL_0011
    IL_0081: ret

  .method PathMesher::AddRoundedEndsModifyer(System.Collections.Generic.List<PathMesher.PathPoint>,int)  // token 0x06000EB3 rva 0x4212c attrs Public, HideBySig
    // code size 291 (0x123), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float, [3] Vector3, [4] Vector3, [5] float, [6] int, [7] float, [8] float, [9] float, [10] int, [11] float, [12] float, [13] float)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0007: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: ldc.i4.0
    IL_000f: ldarg.1
    IL_0010: ldc.i4.1
    IL_0011: call Vector3 PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  /*0x06000EB4*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_UnaryNegation(UnityEngine.Vector3)  /*0x0A0005FA*/
    IL_001b: stloc.1
    IL_001c: ldarg.1
    IL_001d: ldc.i4.0
    IL_001e: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0023: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0028: stloc.2
    IL_0029: ldarg.1
    IL_002a: ldarg.1
    IL_002b: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0030: ldc.i4.1
    IL_0031: sub
    IL_0032: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0037: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_003c: stloc.3
    IL_003d: ldarg.0
    IL_003e: ldarg.1
    IL_003f: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0044: ldc.i4.1
    IL_0045: sub
    IL_0046: ldarg.1
    IL_0047: ldc.i4.1
    IL_0048: call Vector3 PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  /*0x06000EB4*/
    IL_004d: stloc.s 4
    IL_004f: ldarg.1
    IL_0050: ldarg.1
    IL_0051: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0056: ldc.i4.1
    IL_0057: sub
    IL_0058: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_005d: ldfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0062: stloc.s 5
    IL_0064: ldc.i4.1
    IL_0065: stloc.s 6
    IL_0067: br.s IL_00bd
    IL_0069: ldloc.s 6
    IL_006b: conv.r4
    IL_006c: ldarg.2
    IL_006d: conv.r4
    IL_006e: div
    IL_006f: stloc.s 7
    IL_0071: ldloc.s 7
    IL_0073: ldc.r4 0.5f
    IL_0078: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_007d: stloc.s 7
    IL_007f: ldloc.2
    IL_0080: ldc.r4 1f
    IL_0085: ldloc.s 7
    IL_0087: ldc.r4 3f
    IL_008c: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0091: sub
    IL_0092: mul
    IL_0093: stloc.s 8
    IL_0095: ldloc.2
    IL_0096: ldloc.s 7
    IL_0098: mul
    IL_0099: stloc.s 9
    IL_009b: ldarg.1
    IL_009c: ldc.i4.0
    IL_009d: ldloc.0
    IL_009e: ldloc.s 9
    IL_00a0: ldloc.1
    IL_00a1: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_00a6: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00ab: ldloc.s 8
    IL_00ad: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_00b2: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Insert(int,!0)  /*0x0A0005FB*/
    IL_00b7: ldloc.s 6
    IL_00b9: ldc.i4.1
    IL_00ba: add
    IL_00bb: stloc.s 6
    IL_00bd: ldloc.s 6
    IL_00bf: ldarg.2
    IL_00c0: blt.s IL_0069
    IL_00c2: ldc.i4.1
    IL_00c3: stloc.s 10
    IL_00c5: br.s IL_011d
    IL_00c7: ldloc.s 10
    IL_00c9: conv.r4
    IL_00ca: ldarg.2
    IL_00cb: conv.r4
    IL_00cc: div
    IL_00cd: stloc.s 11
    IL_00cf: ldloc.s 11
    IL_00d1: ldc.r4 0.5f
    IL_00d6: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00db: stloc.s 11
    IL_00dd: ldloc.s 5
    IL_00df: ldc.r4 1f
    IL_00e4: ldloc.s 11
    IL_00e6: ldc.r4 3f
    IL_00eb: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00f0: sub
    IL_00f1: mul
    IL_00f2: stloc.s 12
    IL_00f4: ldloc.s 5
    IL_00f6: ldloc.s 11
    IL_00f8: mul
    IL_00f9: stloc.s 13
    IL_00fb: ldarg.1
    IL_00fc: ldloc.3
    IL_00fd: ldloc.s 13
    IL_00ff: ldloc.s 4
    IL_0101: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0106: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_010b: ldloc.s 12
    IL_010d: newobj void PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  /*0x06000EB7*/
    IL_0112: callvirt void System.Collections.Generic.List<PathMesher.PathPoint>::Add(!0)  /*0x0A0005EE*/
    IL_0117: ldloc.s 10
    IL_0119: ldc.i4.1
    IL_011a: add
    IL_011b: stloc.s 10
    IL_011d: ldloc.s 10
    IL_011f: ldarg.2
    IL_0120: blt.s IL_00c7
    IL_0122: ret

  .method PathMesher::GetForwards(int,System.Collections.Generic.List<PathMesher.PathPoint>,bool)  // token 0x06000EB4 rva 0x4225c attrs Private, HideBySig
    // code size 176 (0xb0), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.1
    IL_0001: brtrue.s IL_002d
    IL_0003: ldarg.2
    IL_0004: ldarg.1
    IL_0005: ldc.i4.1
    IL_0006: add
    IL_0007: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_000c: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0011: ldarg.2
    IL_0012: ldarg.1
    IL_0013: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0018: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_001d: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0022: stloc.1
    IL_0023: ldloca.s 1
    IL_0025: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_002a: stloc.0
    IL_002b: br.s IL_008c
    IL_002d: ldarg.1
    IL_002e: ldarg.2
    IL_002f: callvirt int System.Collections.Generic.List<PathMesher.PathPoint>::get_Count()  /*0x0A0005EF*/
    IL_0034: ldc.i4.1
    IL_0035: sub
    IL_0036: bne.un.s IL_0062
    IL_0038: ldarg.2
    IL_0039: ldarg.1
    IL_003a: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_003f: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0044: ldarg.2
    IL_0045: ldarg.1
    IL_0046: ldc.i4.1
    IL_0047: sub
    IL_0048: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_004d: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0052: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0057: stloc.1
    IL_0058: ldloca.s 1
    IL_005a: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_005f: stloc.0
    IL_0060: br.s IL_008c
    IL_0062: ldarg.2
    IL_0063: ldarg.1
    IL_0064: ldc.i4.1
    IL_0065: add
    IL_0066: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_006b: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_0070: ldarg.2
    IL_0071: ldarg.1
    IL_0072: ldc.i4.1
    IL_0073: sub
    IL_0074: callvirt !0 System.Collections.Generic.List<PathMesher.PathPoint>::get_Item(int)  /*0x0A0005F1*/
    IL_0079: ldfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_007e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0083: stloc.1
    IL_0084: ldloca.s 1
    IL_0086: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_008b: stloc.0
    IL_008c: ldarg.3
    IL_008d: brfalse.s IL_00ae
    IL_008f: ldloc.0
    IL_0090: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0095: ldc.r4 0f
    IL_009a: ldloc.0
    IL_009b: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00a0: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00a5: stloc.1
    IL_00a6: ldloca.s 1
    IL_00a8: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00ad: stloc.0
    IL_00ae: ldloc.0
    IL_00af: ret

  .method PathMesher::Nullify()  // token 0x06000EB5 rva 0x42318 attrs Public, HideBySig
    // code size 126 (0x7e), max stack 3, init locals
    .locals ([0] List<Vector3>, [1] int, [2] Transform, [3] int)
    IL_0000: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_002c
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: ldloc.1
    IL_0011: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0016: stloc.2
    IL_0017: ldloc.0
    IL_0018: ldloc.2
    IL_0019: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0023: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_0028: ldloc.1
    IL_0029: ldc.i4.1
    IL_002a: add
    IL_002b: stloc.1
    IL_002c: ldloc.1
    IL_002d: ldarg.0
    IL_002e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0038: blt.s IL_000a
    IL_003a: ldarg.0
    IL_003b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0040: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0045: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_004a: ldc.i4.0
    IL_004b: stloc.3
    IL_004c: br.s IL_006f
    IL_004e: ldarg.0
    IL_004f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0054: ldloc.3
    IL_0055: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_005a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005f: ldloc.0
    IL_0060: ldloc.3
    IL_0061: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0066: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_006b: ldloc.3
    IL_006c: ldc.i4.1
    IL_006d: add
    IL_006e: stloc.3
    IL_006f: ldloc.3
    IL_0070: ldarg.0
    IL_0071: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0076: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_007b: blt.s IL_004e
    IL_007d: ret

  .method PathMesher::.ctor()  // token 0x06000EB6 rva 0x423a4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 87 (0x57), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int PathMesher::subdivisions  /*0x040010F5*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 0.2f
    IL_000d: stfld float PathMesher::vertDistance  /*0x040010F6*/
    IL_0012: ldarg.0
    IL_0013: ldc.i4.3
    IL_0014: stfld int PathMesher::endCapSubdivisions  /*0x040010F7*/
    IL_0019: ldarg.0
    IL_001a: ldc.r4 0.5f
    IL_001f: stfld float PathMesher::widthWhobble  /*0x040010F8*/
    IL_0024: ldarg.0
    IL_0025: ldc.r4 0.5f
    IL_002a: stfld float PathMesher::positionWhobble  /*0x040010F9*/
    IL_002f: ldarg.0
    IL_0030: ldc.r4 0.01f
    IL_0035: stfld float PathMesher::uvScale  /*0x040010FB*/
    IL_003a: ldarg.0
    IL_003b: newobj void System.Collections.Generic.List<FakeTransorm>::.ctor()  /*0x0A0005FC*/
    IL_0040: stfld List<FakeTransorm> PathMesher::transformsRemember  /*0x04001101*/
    IL_0045: ldarg.0
    IL_0046: newobj void System.Collections.Generic.List<PathMesher.PathPoint>::.ctor()  /*0x0A0005F0*/
    IL_004b: stfld List<PathMesher.PathPoint> PathMesher::pathPoints  /*0x04001102*/
    IL_0050: ldarg.0
    IL_0051: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0056: ret

// ===== PathMesher/UnwrapMode  (token 0x020002AA) =====
// ===== PathMesher/PathPoint  (token 0x020002AB) =====
  .method PathMesher.PathPoint::.ctor(UnityEngine.Vector3,float)  // token 0x06000EB7 rva 0x42407 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld Vector3 PathMesher.PathPoint::position  /*0x04001106*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld float PathMesher.PathPoint::width  /*0x04001107*/
    IL_0014: ret

