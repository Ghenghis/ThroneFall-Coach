// ===== GraphDrawer  (token 0x0200030F) =====
  .method GraphDrawer::Generate(string)  // token 0x060010E6 rva 0x4dff0 attrs Public, HideBySig
    // code size 615 (0x267), max stack 5, init locals
    .locals ([0] LevelData, [1] GameObject, [2] Rect, [3] int, [4] int, [5] int, [6] int)
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: ldarg.1
    IL_0006: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: ldfld GraphDrawer.Type GraphDrawer::type  /*0x04001415*/
    IL_0012: brtrue.s IL_002e
    IL_0014: ldarg.0
    IL_0015: ldloc.0
    IL_0016: ldfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_001b: stfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_0020: ldarg.0
    IL_0021: ldloc.0
    IL_0022: ldfld List<int> LevelData::dayToDayNetworthBest  /*0x04000BC4*/
    IL_0027: stfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_002c: br.s IL_004f
    IL_002e: ldarg.0
    IL_002f: ldfld GraphDrawer.Type GraphDrawer::type  /*0x04001415*/
    IL_0034: ldc.i4.1
    IL_0035: bne.un.s IL_004f
    IL_0037: ldarg.0
    IL_0038: ldloc.0
    IL_0039: ldfld List<int> LevelData::dayToDayScore  /*0x04000BBF*/
    IL_003e: stfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_0043: ldarg.0
    IL_0044: ldloc.0
    IL_0045: ldfld List<int> LevelData::dayToDayScoreBest  /*0x04000BC3*/
    IL_004a: stfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_004f: ldarg.0
    IL_0050: ldarg.0
    IL_0051: ldfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_0056: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_005b: ldarg.0
    IL_005c: ldfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_0061: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0066: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_006b: stfld int GraphDrawer::xMaxScale  /*0x0400141D*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldfld RectTransform GraphDrawer::graphSurface  /*0x0400141C*/
    IL_0077: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_007c: stloc.2
    IL_007d: ldloca.s 2
    IL_007f: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0084: stfld float GraphDrawer::width  /*0x0400141F*/
    IL_0089: ldarg.0
    IL_008a: ldarg.0
    IL_008b: ldfld RectTransform GraphDrawer::graphSurface  /*0x0400141C*/
    IL_0090: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_0095: stloc.2
    IL_0096: ldloca.s 2
    IL_0098: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_009d: stfld float GraphDrawer::height  /*0x04001420*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld int GraphDrawer::xMaxScale  /*0x0400141D*/
    IL_00a8: ldc.i4.1
    IL_00a9: ble.s IL_00c3
    IL_00ab: ldarg.0
    IL_00ac: ldarg.0
    IL_00ad: ldfld float GraphDrawer::width  /*0x0400141F*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld int GraphDrawer::xMaxScale  /*0x0400141D*/
    IL_00b8: ldc.i4.1
    IL_00b9: sub
    IL_00ba: conv.r4
    IL_00bb: div
    IL_00bc: stfld float GraphDrawer::wspacing  /*0x04001421*/
    IL_00c1: br.s IL_00ce
    IL_00c3: ldarg.0
    IL_00c4: ldc.r4 0f
    IL_00c9: stfld float GraphDrawer::wspacing  /*0x04001421*/
    IL_00ce: ldarg.0
    IL_00cf: ldc.i4.1
    IL_00d0: stfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_00d5: ldc.i4.0
    IL_00d6: stloc.3
    IL_00d7: br.s IL_00fa
    IL_00d9: ldarg.0
    IL_00da: ldarg.0
    IL_00db: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_00e0: ldarg.0
    IL_00e1: ldfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_00e6: ldloc.3
    IL_00e7: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_00ec: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_00f1: stfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_00f6: ldloc.3
    IL_00f7: ldc.i4.1
    IL_00f8: add
    IL_00f9: stloc.3
    IL_00fa: ldloc.3
    IL_00fb: ldarg.0
    IL_00fc: ldfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_0101: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0106: blt.s IL_00d9
    IL_0108: ldc.i4.0
    IL_0109: stloc.s 4
    IL_010b: br.s IL_0131
    IL_010d: ldarg.0
    IL_010e: ldarg.0
    IL_010f: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_0114: ldarg.0
    IL_0115: ldfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_011a: ldloc.s 4
    IL_011c: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0121: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0126: stfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_012b: ldloc.s 4
    IL_012d: ldc.i4.1
    IL_012e: add
    IL_012f: stloc.s 4
    IL_0131: ldloc.s 4
    IL_0133: ldarg.0
    IL_0134: ldfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_0139: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_013e: blt.s IL_010d
    IL_0140: ldarg.0
    IL_0141: ldfld GameObject GraphDrawer::graphSclaeMarkerPrefab  /*0x0400141B*/
    IL_0146: ldarg.0
    IL_0147: ldfld RectTransform GraphDrawer::graphSurface  /*0x0400141C*/
    IL_014c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0151: stloc.1
    IL_0152: ldloc.1
    IL_0153: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0158: ldarg.0
    IL_0159: ldfld float GraphDrawer::width  /*0x0400141F*/
    IL_015e: neg
    IL_015f: ldc.r4 2f
    IL_0164: div
    IL_0165: ldarg.0
    IL_0166: ldfld float GraphDrawer::height  /*0x04001420*/
    IL_016b: neg
    IL_016c: ldc.r4 2f
    IL_0171: div
    IL_0172: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A00067C*/
    IL_0177: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_017c: ldloc.1
    IL_017d: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TMPro.TMP_Text>  /*0x2B0000EE*/
    IL_0182: ldstr "0"
    IL_0187: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_018c: ldarg.0
    IL_018d: ldfld GameObject GraphDrawer::graphSclaeMarkerPrefab  /*0x0400141B*/
    IL_0192: ldarg.0
    IL_0193: ldfld RectTransform GraphDrawer::graphSurface  /*0x0400141C*/
    IL_0198: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_019d: stloc.1
    IL_019e: ldloc.1
    IL_019f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_01a4: ldarg.0
    IL_01a5: ldfld float GraphDrawer::width  /*0x0400141F*/
    IL_01aa: neg
    IL_01ab: ldc.r4 2f
    IL_01b0: div
    IL_01b1: ldarg.0
    IL_01b2: ldfld float GraphDrawer::height  /*0x04001420*/
    IL_01b7: ldc.r4 2f
    IL_01bc: div
    IL_01bd: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A00067C*/
    IL_01c2: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_01c7: ldarg.0
    IL_01c8: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_01cd: ldc.i4 1000
    IL_01d2: bge.s IL_01ec
    IL_01d4: ldloc.1
    IL_01d5: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TMPro.TMP_Text>  /*0x2B0000EE*/
    IL_01da: ldarg.0
    IL_01db: ldflda int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_01e0: call string System.Int32::ToString()  /*0x0A000031*/
    IL_01e5: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_01ea: br.s IL_0242
    IL_01ec: ldarg.0
    IL_01ed: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_01f2: conv.r4
    IL_01f3: ldc.r4 1000f
    IL_01f8: div
    IL_01f9: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_01fe: stloc.s 5
    IL_0200: ldarg.0
    IL_0201: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_0206: conv.r4
    IL_0207: ldc.r4 100f
    IL_020c: div
    IL_020d: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0212: ldloc.s 5
    IL_0214: ldc.i4.s 10
    IL_0216: mul
    IL_0217: sub
    IL_0218: stloc.s 6
    IL_021a: ldloc.1
    IL_021b: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<TMPro.TMP_Text>  /*0x2B0000EE*/
    IL_0220: ldloca.s 5
    IL_0222: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0227: ldstr "."
    IL_022c: ldloca.s 6
    IL_022e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0233: ldstr "K"
    IL_0238: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_023d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0242: ldarg.0
    IL_0243: ldarg.0
    IL_0244: ldfld List<int> GraphDrawer::oldBest  /*0x04001417*/
    IL_0249: ldarg.0
    IL_024a: ldfld Color GraphDrawer::colorOldBest  /*0x04001419*/
    IL_024f: call void GraphDrawer::PlotList(System.Collections.Generic.List<int>,UnityEngine.Color)  /*0x060010E7*/
    IL_0254: ldarg.0
    IL_0255: ldarg.0
    IL_0256: ldfld List<int> GraphDrawer::current  /*0x04001416*/
    IL_025b: ldarg.0
    IL_025c: ldfld Color GraphDrawer::colorCurrent  /*0x04001418*/
    IL_0261: call void GraphDrawer::PlotList(System.Collections.Generic.List<int>,UnityEngine.Color)  /*0x060010E7*/
    IL_0266: ret

  .method GraphDrawer::PlotList(System.Collections.Generic.List<int>,UnityEngine.Color)  // token 0x060010E7 rva 0x4e264 attrs Private, HideBySig
    // code size 325 (0x145), max stack 6, init locals
    .locals ([0] Vector3, [1] int, [2] float, [3] float, [4] Vector3, [5] RectTransform, [6] Vector3, [7] Rect)
    IL_0000: ldarg.1
    IL_0001: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0006: ldc.i4.0
    IL_0007: bgt.s IL_000a
    IL_0009: ret
    IL_000a: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_000f: stloc.0
    IL_0010: ldc.i4.0
    IL_0011: stloc.1
    IL_0012: br IL_0138
    IL_0017: ldloc.1
    IL_0018: conv.r4
    IL_0019: ldarg.0
    IL_001a: ldfld float GraphDrawer::wspacing  /*0x04001421*/
    IL_001f: mul
    IL_0020: ldarg.0
    IL_0021: ldfld float GraphDrawer::width  /*0x0400141F*/
    IL_0026: ldc.r4 2f
    IL_002b: div
    IL_002c: sub
    IL_002d: stloc.2
    IL_002e: ldarg.1
    IL_002f: ldloc.1
    IL_0030: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0035: conv.r4
    IL_0036: ldarg.0
    IL_0037: ldfld int GraphDrawer::yMaxScale  /*0x0400141E*/
    IL_003c: conv.r4
    IL_003d: div
    IL_003e: ldarg.0
    IL_003f: ldfld float GraphDrawer::height  /*0x04001420*/
    IL_0044: mul
    IL_0045: ldarg.0
    IL_0046: ldfld float GraphDrawer::height  /*0x04001420*/
    IL_004b: ldc.r4 2f
    IL_0050: div
    IL_0051: sub
    IL_0052: stloc.3
    IL_0053: ldloca.s 4
    IL_0055: ldloc.2
    IL_0056: ldloc.3
    IL_0057: ldc.r4 0f
    IL_005c: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0061: ldloc.1
    IL_0062: ldc.i4.0
    IL_0063: bgt.s IL_0071
    IL_0065: ldarg.1
    IL_0066: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_006b: ldc.i4.1
    IL_006c: bgt IL_0131
    IL_0071: ldarg.0
    IL_0072: ldfld GameObject GraphDrawer::graphMarkersPrefab  /*0x0400141A*/
    IL_0077: ldarg.0
    IL_0078: ldfld RectTransform GraphDrawer::graphSurface  /*0x0400141C*/
    IL_007d: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0082: dup
    IL_0083: callvirt !!0 UnityEngine.GameObject::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000EF*/
    IL_0088: stloc.s 5
    IL_008a: ldloc.s 5
    IL_008c: ldloc.s 4
    IL_008e: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0093: callvirt !!0 UnityEngine.GameObject::GetComponent()<UnityEngine.UI.Image>  /*0x2B0000F0*/
    IL_0098: ldarg.2
    IL_0099: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_009e: ldloc.1
    IL_009f: ldc.i4.0
    IL_00a0: ble IL_0131
    IL_00a5: ldloc.s 5
    IL_00a7: ldloc.0
    IL_00a8: ldloc.s 4
    IL_00aa: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00af: ldc.r4 2f
    IL_00b4: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_00b9: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00be: ldloc.s 5
    IL_00c0: ldloc.0
    IL_00c1: ldloc.s 4
    IL_00c3: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00c8: stloc.s 6
    IL_00ca: ldloca.s 6
    IL_00cc: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00d1: ldloc.s 5
    IL_00d3: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_00d8: stloc.s 7
    IL_00da: ldloca.s 7
    IL_00dc: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_00e1: div
    IL_00e2: ldloc.s 5
    IL_00e4: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_00e9: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00ee: ldloc.s 5
    IL_00f0: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_00f5: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00fa: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00ff: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0104: ldloc.s 5
    IL_0106: ldc.r4 0f
    IL_010b: ldc.r4 0f
    IL_0110: call Vector2 UnityEngine.Vector2::get_right()  /*0x0A000586*/
    IL_0115: ldloc.0
    IL_0116: ldloc.s 4
    IL_0118: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_011d: call Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)  /*0x0A000575*/
    IL_0122: call float UnityEngine.Vector2::SignedAngle(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000583*/
    IL_0127: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_012c: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0131: ldloc.s 4
    IL_0133: stloc.0
    IL_0134: ldloc.1
    IL_0135: ldc.i4.1
    IL_0136: add
    IL_0137: stloc.1
    IL_0138: ldloc.1
    IL_0139: ldarg.1
    IL_013a: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_013f: blt IL_0017
    IL_0144: ret

  .method GraphDrawer::.ctor()  // token 0x060010E8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== GraphDrawer/Type  (token 0x02000310) =====
