// ===== ScreenMarkerManager  (token 0x02000264) =====
  .method ScreenMarkerManager::get_FIXED_CANVAS_HEIGHT()  // token 0x06000D43 rva 0x3c593 attrs Private, HideBySig, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld ScreenMarkerCanvasHelper ScreenMarkerCanvasHelper::instance  /*0x04001565*/
    IL_0005: callvirt float ScreenMarkerCanvasHelper::get_Height()  /*0x060011AC*/
    IL_000a: ret

  .method ScreenMarkerManager::Awake()  // token 0x06000D44 rva 0x3c59f attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_0006: ret

  .method ScreenMarkerManager::Start()  // token 0x06000D45 rva 0x3c5a7 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0006: stfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_000b: ldarg.0
    IL_000c: call void ScreenMarkerManager::UpdateCam()  /*0x06000D46*/
    IL_0011: ret

  .method ScreenMarkerManager::UpdateCam()  // token 0x06000D46 rva 0x3c5bc attrs Private, HideBySig
    // code size 89 (0x59), max stack 3, init locals
    .locals ([0] Rect)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_0007: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_000c: stloc.0
    IL_000d: ldloca.s 0
    IL_000f: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0014: ldarg.0
    IL_0015: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_001a: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_001f: stloc.0
    IL_0020: ldloca.s 0
    IL_0022: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0027: div
    IL_0028: stfld float ScreenMarkerManager::ratio  /*0x04000FCE*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: call float ScreenMarkerManager::get_FIXED_CANVAS_HEIGHT()  /*0x06000D43*/
    IL_0034: ldc.r4 2f
    IL_0039: div
    IL_003a: stfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: call float ScreenMarkerManager::get_FIXED_CANVAS_HEIGHT()  /*0x06000D43*/
    IL_0046: ldc.r4 2f
    IL_004b: div
    IL_004c: ldarg.0
    IL_004d: ldfld float ScreenMarkerManager::ratio  /*0x04000FCE*/
    IL_0052: mul
    IL_0053: stfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_0058: ret

  .method ScreenMarkerManager::RegisterScreenMarker(ScreenMarker)  // token 0x06000D47 rva 0x3c621 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<ScreenMarker>::Contains(!0)  /*0x0A000579*/
    IL_000c: brtrue.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_0014: ldarg.1
    IL_0015: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_001a: ret

  .method ScreenMarkerManager::UnregisterScreenMarker(ScreenMarker)  // token 0x06000D48 rva 0x3c63d attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<ScreenMarker>::Contains(!0)  /*0x0A000579*/
    IL_000c: brfalse.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_0014: ldarg.1
    IL_0015: callvirt bool System.Collections.Generic.List<ScreenMarker>::Remove(!0)  /*0x0A00057A*/
    IL_001a: pop
    IL_001b: ret

  .method ScreenMarkerManager::Update()  // token 0x06000D49 rva 0x3c65c attrs Private, HideBySig
    // code size 709 (0x2c5), max stack 4, init locals
    .locals ([0] bool, [1] int, [2] int, [3] int, [4] int, [5] bool, [6] int, [7] ScreenMarker, [8] int, [9] ScreenMarker, [10] int, [11] int, [12] int, [13] ScreenMarker, [14] int, [15] int, [16] ScreenMarker)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int ScreenMarkerManager::frame  /*0x04000FD1*/
    IL_0007: ldc.i4.1
    IL_0008: add
    IL_0009: stfld int ScreenMarkerManager::frame  /*0x04000FD1*/
    IL_000e: ldarg.0
    IL_000f: ldfld int ScreenMarkerManager::frame  /*0x04000FD1*/
    IL_0014: ldc.i4.2
    IL_0015: bge.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: call void ScreenMarkerManager::UpdateCam()  /*0x06000D46*/
    IL_001e: ldarg.0
    IL_001f: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_0024: callvirt void System.Collections.Generic.List<ScreenMarker>::Clear()  /*0x0A0002A1*/
    IL_0029: ldarg.0
    IL_002a: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_002f: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0034: ldc.i4.1
    IL_0035: sub
    IL_0036: stloc.2
    IL_0037: br.s IL_004f
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_0040: ldloc.2
    IL_0041: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0046: call void ScreenMarkerManager::UpdateMarkerPosition(ScreenMarker)  /*0x06000D4C*/
    IL_004b: ldloc.2
    IL_004c: ldc.i4.1
    IL_004d: sub
    IL_004e: stloc.2
    IL_004f: ldloc.2
    IL_0050: ldc.i4.0
    IL_0051: bge.s IL_0039
    IL_0053: ldc.i4.0
    IL_0054: stloc.3
    IL_0055: br.s IL_006c
    IL_0057: ldarg.0
    IL_0058: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_005d: ldloc.3
    IL_005e: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_0063: callvirt void System.Collections.Generic.List<ScreenMarker>::Clear()  /*0x0A0002A1*/
    IL_0068: ldloc.3
    IL_0069: ldc.i4.1
    IL_006a: add
    IL_006b: stloc.3
    IL_006c: ldloc.3
    IL_006d: ldarg.0
    IL_006e: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_0073: callvirt int System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Count()  /*0x0A00057C*/
    IL_0078: blt.s IL_0057
    IL_007a: ldarg.0
    IL_007b: ldfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_0080: callvirt void System.Collections.Generic.Dictionary<ScreenMarker, int>::Clear()  /*0x0A00057D*/
    IL_0085: br.s IL_0097
    IL_0087: ldarg.0
    IL_0088: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_008d: newobj void System.Collections.Generic.List<ScreenMarker>::.ctor()  /*0x0A0002AA*/
    IL_0092: callvirt void System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::Add(!0)  /*0x0A00057E*/
    IL_0097: ldarg.0
    IL_0098: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_009d: callvirt int System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Count()  /*0x0A00057C*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_00a8: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00ad: blt.s IL_0087
    IL_00af: ldc.i4.0
    IL_00b0: stloc.s 4
    IL_00b2: br.s IL_00f3
    IL_00b4: ldarg.0
    IL_00b5: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_00ba: ldloc.s 4
    IL_00bc: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_00c7: ldloc.s 4
    IL_00c9: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00ce: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_00d3: ldarg.0
    IL_00d4: ldfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_00d9: ldarg.0
    IL_00da: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_00df: ldloc.s 4
    IL_00e1: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00e6: ldloc.s 4
    IL_00e8: callvirt void System.Collections.Generic.Dictionary<ScreenMarker, int>::Add(!0,!1)  /*0x0A00057F*/
    IL_00ed: ldloc.s 4
    IL_00ef: ldc.i4.1
    IL_00f0: add
    IL_00f1: stloc.s 4
    IL_00f3: ldloc.s 4
    IL_00f5: ldarg.0
    IL_00f6: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_00fb: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0100: blt.s IL_00b4
    IL_0102: ldc.i4.1
    IL_0103: stloc.0
    IL_0104: ldc.i4.s 30
    IL_0106: stloc.1
    IL_0107: br IL_024d
    IL_010c: ldloc.1
    IL_010d: ldc.i4.1
    IL_010e: sub
    IL_010f: stloc.1
    IL_0110: ldc.i4.0
    IL_0111: stloc.s 5
    IL_0113: ldc.i4.0
    IL_0114: stloc.s 6
    IL_0116: br IL_0207
    IL_011b: ldarg.0
    IL_011c: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_0121: ldloc.s 6
    IL_0123: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0128: stloc.s 7
    IL_012a: ldloc.s 6
    IL_012c: ldc.i4.1
    IL_012d: add
    IL_012e: stloc.s 8
    IL_0130: br IL_01ef
    IL_0135: ldarg.0
    IL_0136: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_013b: ldloc.s 8
    IL_013d: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0142: stloc.s 9
    IL_0144: ldarg.0
    IL_0145: ldloc.s 7
    IL_0147: ldloc.s 9
    IL_0149: call bool ScreenMarkerManager::CheckOverlap(ScreenMarker,ScreenMarker)  /*0x06000D4A*/
    IL_014e: brfalse IL_01e9
    IL_0153: ldarg.0
    IL_0154: ldfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_0159: ldloc.s 7
    IL_015b: callvirt !1 System.Collections.Generic.Dictionary<ScreenMarker, int>::get_Item(!0)  /*0x0A000580*/
    IL_0160: stloc.s 10
    IL_0162: ldarg.0
    IL_0163: ldfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_0168: ldloc.s 9
    IL_016a: callvirt !1 System.Collections.Generic.Dictionary<ScreenMarker, int>::get_Item(!0)  /*0x0A000580*/
    IL_016f: stloc.s 11
    IL_0171: ldloc.s 10
    IL_0173: ldloc.s 11
    IL_0175: beq.s IL_01e9
    IL_0177: ldc.i4.1
    IL_0178: stloc.s 5
    IL_017a: ldc.i4.0
    IL_017b: stloc.s 12
    IL_017d: br.s IL_01d3
    IL_017f: ldarg.0
    IL_0180: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_0185: ldloc.s 11
    IL_0187: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_018c: ldloc.s 12
    IL_018e: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0193: stloc.s 13
    IL_0195: ldarg.0
    IL_0196: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_019b: ldloc.s 11
    IL_019d: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_01a2: ldloc.s 13
    IL_01a4: callvirt bool System.Collections.Generic.List<ScreenMarker>::Remove(!0)  /*0x0A00057A*/
    IL_01a9: pop
    IL_01aa: ldarg.0
    IL_01ab: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_01b0: ldloc.s 10
    IL_01b2: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_01b7: ldloc.s 13
    IL_01b9: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_01be: ldarg.0
    IL_01bf: ldfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_01c4: ldloc.s 13
    IL_01c6: ldloc.s 10
    IL_01c8: callvirt void System.Collections.Generic.Dictionary<ScreenMarker, int>::set_Item(!0,!1)  /*0x0A000581*/
    IL_01cd: ldloc.s 12
    IL_01cf: ldc.i4.1
    IL_01d0: add
    IL_01d1: stloc.s 12
    IL_01d3: ldloc.s 12
    IL_01d5: ldarg.0
    IL_01d6: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_01db: ldloc.s 11
    IL_01dd: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_01e2: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_01e7: blt.s IL_017f
    IL_01e9: ldloc.s 8
    IL_01eb: ldc.i4.1
    IL_01ec: add
    IL_01ed: stloc.s 8
    IL_01ef: ldloc.s 8
    IL_01f1: ldarg.0
    IL_01f2: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_01f7: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_01fc: blt IL_0135
    IL_0201: ldloc.s 6
    IL_0203: ldc.i4.1
    IL_0204: add
    IL_0205: stloc.s 6
    IL_0207: ldloc.s 6
    IL_0209: ldarg.0
    IL_020a: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_020f: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0214: blt IL_011b
    IL_0219: ldloc.s 5
    IL_021b: stloc.0
    IL_021c: ldloc.s 5
    IL_021e: brfalse.s IL_024d
    IL_0220: ldc.i4.0
    IL_0221: stloc.s 14
    IL_0223: br.s IL_023e
    IL_0225: ldarg.0
    IL_0226: ldarg.0
    IL_0227: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_022c: ldloc.s 14
    IL_022e: callvirt !0 System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Item(int)  /*0x0A00057B*/
    IL_0233: call void ScreenMarkerManager::FormatGroup(System.Collections.Generic.List<ScreenMarker>)  /*0x06000D4B*/
    IL_0238: ldloc.s 14
    IL_023a: ldc.i4.1
    IL_023b: add
    IL_023c: stloc.s 14
    IL_023e: ldloc.s 14
    IL_0240: ldarg.0
    IL_0241: ldfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_0246: callvirt int System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::get_Count()  /*0x0A00057C*/
    IL_024b: blt.s IL_0225
    IL_024d: ldloc.0
    IL_024e: brfalse.s IL_0257
    IL_0250: ldloc.1
    IL_0251: ldc.i4.0
    IL_0252: bgt IL_010c
    IL_0257: ldc.i4.0
    IL_0258: stloc.s 15
    IL_025a: br.s IL_02b5
    IL_025c: ldarg.0
    IL_025d: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_0262: ldloc.s 15
    IL_0264: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0269: stloc.s 16
    IL_026b: ldloc.s 16
    IL_026d: ldfld bool ScreenMarker::rotateTowardsTargetWhenOffscreen  /*0x04000FC0*/
    IL_0272: brfalse.s IL_02af
    IL_0274: ldloc.s 16
    IL_0276: callvirt bool ScreenMarker::get_OnScreen()  /*0x06000D29*/
    IL_027b: brfalse.s IL_028b
    IL_027d: ldloc.s 16
    IL_027f: ldc.r4 0f
    IL_0284: callvirt void ScreenMarker::set_ImageRotation(float)  /*0x06000D3D*/
    IL_0289: br.s IL_02af
    IL_028b: ldloc.s 16
    IL_028d: call Vector2 UnityEngine.Vector2::get_down()  /*0x0A000582*/
    IL_0292: ldloc.s 16
    IL_0294: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0299: ldloc.s 16
    IL_029b: callvirt Vector2 ScreenMarker::get_Position()  /*0x06000D3A*/
    IL_02a0: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00014F*/
    IL_02a5: call float UnityEngine.Vector2::SignedAngle(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000583*/
    IL_02aa: callvirt void ScreenMarker::set_ImageRotation(float)  /*0x06000D3D*/
    IL_02af: ldloc.s 15
    IL_02b1: ldc.i4.1
    IL_02b2: add
    IL_02b3: stloc.s 15
    IL_02b5: ldloc.s 15
    IL_02b7: ldarg.0
    IL_02b8: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_02bd: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_02c2: blt.s IL_025c
    IL_02c4: ret

  .method ScreenMarkerManager::CheckOverlap(ScreenMarker,ScreenMarker)  // token 0x06000D4A rva 0x3c930 attrs Private, HideBySig
    // code size 174 (0xae), max stack 3, init locals
    .locals ([0] Rect, [1] Rect)
    IL_0000: ldarg.1
    IL_0001: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0006: ldarg.2
    IL_0007: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_000c: call bool UnityEngine.Rect::op_Inequality(UnityEngine.Rect,UnityEngine.Rect)  /*0x0A000584*/
    IL_0011: brfalse.s IL_0015
    IL_0013: ldc.i4.0
    IL_0014: ret
    IL_0015: ldarg.1
    IL_0016: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_001b: ldarg.2
    IL_001c: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0021: call bool UnityEngine.Vector2::op_Equality(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000585*/
    IL_0026: brfalse.s IL_002a
    IL_0028: ldc.i4.1
    IL_0029: ret
    IL_002a: ldarg.1
    IL_002b: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0030: stloc.0
    IL_0031: ldarg.2
    IL_0032: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0037: stloc.1
    IL_0038: ldarg.1
    IL_0039: callvirt Vector2 ScreenMarker::get_Position()  /*0x06000D3A*/
    IL_003e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0043: ldarg.2
    IL_0044: callvirt Vector2 ScreenMarker::get_Position()  /*0x06000D3A*/
    IL_0049: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_004e: sub
    IL_004f: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0054: ldloca.s 0
    IL_0056: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_005b: ldloca.s 1
    IL_005d: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0062: add
    IL_0063: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0068: ldc.r4 2f
    IL_006d: div
    IL_006e: ble.un.s IL_0072
    IL_0070: ldc.i4.0
    IL_0071: ret
    IL_0072: ldarg.1
    IL_0073: callvirt Vector2 ScreenMarker::get_Position()  /*0x06000D3A*/
    IL_0078: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_007d: ldarg.2
    IL_007e: callvirt Vector2 ScreenMarker::get_Position()  /*0x06000D3A*/
    IL_0083: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0088: sub
    IL_0089: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_008e: ldloca.s 0
    IL_0090: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0095: ldloca.s 1
    IL_0097: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_009c: add
    IL_009d: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_00a2: ldc.r4 2f
    IL_00a7: div
    IL_00a8: ble.un.s IL_00ac
    IL_00aa: ldc.i4.0
    IL_00ab: ret
    IL_00ac: ldc.i4.1
    IL_00ad: ret

  .method ScreenMarkerManager::FormatGroup(System.Collections.Generic.List<ScreenMarker>)  // token 0x06000D4B rva 0x3c9ec attrs Private, HideBySig
    // code size 542 (0x21e), max stack 7, init locals
    .locals ([0] Vector2, [1] float, [2] float, [3] float, [4] float, [5] int, [6] Rect, [7] int, [8] int)
    IL_0000: ldarg.1
    IL_0001: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0006: ldc.i4.0
    IL_0007: bgt.s IL_000a
    IL_0009: ret
    IL_000a: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_000f: stloc.0
    IL_0010: ldc.r4 0f
    IL_0015: stloc.1
    IL_0016: ldc.r4 0f
    IL_001b: stloc.2
    IL_001c: ldc.r4 0f
    IL_0021: stloc.3
    IL_0022: ldc.r4 0f
    IL_0027: stloc.s 4
    IL_0029: ldc.i4.0
    IL_002a: stloc.s 5
    IL_002c: br IL_00c2
    IL_0031: ldloc.0
    IL_0032: ldarg.1
    IL_0033: ldloc.s 5
    IL_0035: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_003a: callvirt Vector2 ScreenMarker::get_ClampedScreenPos()  /*0x06000D27*/
    IL_003f: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0044: stloc.0
    IL_0045: ldloc.3
    IL_0046: ldarg.1
    IL_0047: ldloc.s 5
    IL_0049: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_004e: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0053: stloc.s 6
    IL_0055: ldloca.s 6
    IL_0057: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_005c: add
    IL_005d: stloc.3
    IL_005e: ldloc.s 4
    IL_0060: ldarg.1
    IL_0061: ldloc.s 5
    IL_0063: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0068: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_006d: stloc.s 6
    IL_006f: ldloca.s 6
    IL_0071: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0076: add
    IL_0077: stloc.s 4
    IL_0079: ldloc.s 5
    IL_007b: ldc.i4.0
    IL_007c: ble.s IL_00bc
    IL_007e: ldloc.1
    IL_007f: ldarg.1
    IL_0080: ldloc.s 5
    IL_0082: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0087: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_008c: stloc.s 6
    IL_008e: ldloca.s 6
    IL_0090: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0095: ldc.r4 2f
    IL_009a: div
    IL_009b: sub
    IL_009c: stloc.1
    IL_009d: ldloc.2
    IL_009e: ldarg.1
    IL_009f: ldloc.s 5
    IL_00a1: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00a6: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_00ab: stloc.s 6
    IL_00ad: ldloca.s 6
    IL_00af: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_00b4: ldc.r4 2f
    IL_00b9: div
    IL_00ba: sub
    IL_00bb: stloc.2
    IL_00bc: ldloc.s 5
    IL_00be: ldc.i4.1
    IL_00bf: add
    IL_00c0: stloc.s 5
    IL_00c2: ldloc.s 5
    IL_00c4: ldarg.1
    IL_00c5: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00ca: blt IL_0031
    IL_00cf: ldloc.0
    IL_00d0: ldarg.1
    IL_00d1: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00d6: conv.r4
    IL_00d7: call Vector2 UnityEngine.Vector2::op_Division(UnityEngine.Vector2,float)  /*0x0A000155*/
    IL_00dc: stloc.0
    IL_00dd: ldloc.0
    IL_00de: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_00e9: div
    IL_00ea: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_00ef: ldloc.0
    IL_00f0: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_00f5: ldarg.0
    IL_00f6: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_00fb: div
    IL_00fc: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0101: clt
    IL_0103: brfalse IL_0192
    IL_0108: ldloca.s 0
    IL_010a: ldloc.0
    IL_010b: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0110: ldarg.0
    IL_0111: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_0116: neg
    IL_0117: ldloc.3
    IL_0118: ldc.r4 2f
    IL_011d: div
    IL_011e: add
    IL_011f: ldarg.0
    IL_0120: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_0125: ldloc.3
    IL_0126: ldc.r4 2f
    IL_012b: div
    IL_012c: sub
    IL_012d: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0132: ldloc.0
    IL_0133: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0138: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_013d: ldarg.1
    IL_013e: call void ScreenMarkerManager.SortNoGC::SortByX(System.Collections.Generic.List<ScreenMarker>)  /*0x06000D4F*/
    IL_0143: ldc.i4.0
    IL_0144: stloc.s 7
    IL_0146: br.s IL_0187
    IL_0148: ldarg.1
    IL_0149: ldloc.s 7
    IL_014b: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0150: ldloc.0
    IL_0151: call Vector2 UnityEngine.Vector2::get_right()  /*0x0A000586*/
    IL_0156: ldarg.1
    IL_0157: ldloc.s 7
    IL_0159: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_015e: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0163: stloc.s 6
    IL_0165: ldloca.s 6
    IL_0167: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_016c: ldloc.s 7
    IL_016e: conv.r4
    IL_016f: mul
    IL_0170: ldloc.1
    IL_0171: add
    IL_0172: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0177: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_017c: callvirt void ScreenMarker::set_Position(UnityEngine.Vector2)  /*0x06000D3B*/
    IL_0181: ldloc.s 7
    IL_0183: ldc.i4.1
    IL_0184: add
    IL_0185: stloc.s 7
    IL_0187: ldloc.s 7
    IL_0189: ldarg.1
    IL_018a: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_018f: blt.s IL_0148
    IL_0191: ret
    IL_0192: ldloca.s 0
    IL_0194: ldloc.0
    IL_0195: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_019a: ldloc.0
    IL_019b: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_01a0: ldarg.0
    IL_01a1: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_01a6: neg
    IL_01a7: ldloc.s 4
    IL_01a9: ldc.r4 2f
    IL_01ae: div
    IL_01af: add
    IL_01b0: ldarg.0
    IL_01b1: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_01b6: ldloc.s 4
    IL_01b8: ldc.r4 2f
    IL_01bd: div
    IL_01be: sub
    IL_01bf: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_01c4: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_01c9: ldarg.1
    IL_01ca: call void ScreenMarkerManager.SortNoGC::SortByY(System.Collections.Generic.List<ScreenMarker>)  /*0x06000D50*/
    IL_01cf: ldc.i4.0
    IL_01d0: stloc.s 8
    IL_01d2: br.s IL_0213
    IL_01d4: ldarg.1
    IL_01d5: ldloc.s 8
    IL_01d7: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_01dc: ldloc.0
    IL_01dd: call Vector2 UnityEngine.Vector2::get_down()  /*0x0A000582*/
    IL_01e2: ldarg.1
    IL_01e3: ldloc.s 8
    IL_01e5: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_01ea: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_01ef: stloc.s 6
    IL_01f1: ldloca.s 6
    IL_01f3: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_01f8: ldloc.s 8
    IL_01fa: conv.r4
    IL_01fb: mul
    IL_01fc: ldloc.2
    IL_01fd: add
    IL_01fe: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_0203: call Vector2 UnityEngine.Vector2::op_Addition(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000154*/
    IL_0208: callvirt void ScreenMarker::set_Position(UnityEngine.Vector2)  /*0x06000D3B*/
    IL_020d: ldloc.s 8
    IL_020f: ldc.i4.1
    IL_0210: add
    IL_0211: stloc.s 8
    IL_0213: ldloc.s 8
    IL_0215: ldarg.1
    IL_0216: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_021b: blt.s IL_01d4
    IL_021d: ret

  .method ScreenMarkerManager::UpdateMarkerPosition(ScreenMarker)  // token 0x06000D4C rva 0x3cc18 attrs Public, HideBySig
    // code size 589 (0x24d), max stack 7, init locals
    .locals ([0] float, [1] Vector3, [2] Vector2, [3] bool, [4] Rect, [5] float, [6] float, [7] float, [8] Rect)
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_0010: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_0015: stloc.s 4
    IL_0017: ldloca.s 4
    IL_0019: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_001e: ldarg.0
    IL_001f: call float ScreenMarkerManager::get_FIXED_CANVAS_HEIGHT()  /*0x06000D43*/
    IL_0024: div
    IL_0025: stloc.0
    IL_0026: ldarg.0
    IL_0027: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_002c: ldarg.1
    IL_002d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0032: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0037: callvirt Vector3 UnityEngine.Camera::WorldToScreenPoint(UnityEngine.Vector3)  /*0x0A0003B6*/
    IL_003c: stloc.1
    IL_003d: ldloc.1
    IL_003e: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0043: ldarg.0
    IL_0044: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_0049: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_004e: stloc.s 4
    IL_0050: ldloca.s 4
    IL_0052: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_0057: ldc.r4 0.5f
    IL_005c: mul
    IL_005d: sub
    IL_005e: ldloc.1
    IL_005f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0064: ldarg.0
    IL_0065: ldfld Camera ScreenMarkerManager::cam  /*0x04000FCD*/
    IL_006a: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_006f: stloc.s 4
    IL_0071: ldloca.s 4
    IL_0073: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0078: ldc.r4 0.5f
    IL_007d: mul
    IL_007e: sub
    IL_007f: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0084: ldloc.0
    IL_0085: call Vector2 UnityEngine.Vector2::op_Division(UnityEngine.Vector2,float)  /*0x0A000155*/
    IL_008a: stloc.2
    IL_008b: ldarg.1
    IL_008c: ldloc.2
    IL_008d: callvirt void ScreenMarker::set_UnclampedScreenPos(UnityEngine.Vector2)  /*0x06000D26*/
    IL_0092: ldc.i4.1
    IL_0093: stloc.3
    IL_0094: ldloc.2
    IL_0095: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_009a: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_009f: ldarg.0
    IL_00a0: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_00a5: ldarg.1
    IL_00a6: ldflda Rect ScreenMarker::checkOnScreenRect  /*0x04000FC3*/
    IL_00ab: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_00b0: ldc.r4 2f
    IL_00b5: div
    IL_00b6: sub
    IL_00b7: ble.un.s IL_00bd
    IL_00b9: ldc.i4.0
    IL_00ba: stloc.3
    IL_00bb: br.s IL_00e4
    IL_00bd: ldloc.2
    IL_00be: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00c3: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_00c8: ldarg.0
    IL_00c9: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_00ce: ldarg.1
    IL_00cf: ldflda Rect ScreenMarker::checkOnScreenRect  /*0x04000FC3*/
    IL_00d4: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_00d9: ldc.r4 2f
    IL_00de: div
    IL_00df: sub
    IL_00e0: ble.un.s IL_00e4
    IL_00e2: ldc.i4.0
    IL_00e3: stloc.3
    IL_00e4: ldarg.1
    IL_00e5: ldloc.3
    IL_00e6: callvirt void ScreenMarker::set_OnScreen(bool)  /*0x06000D2A*/
    IL_00eb: ldarg.1
    IL_00ec: callvirt bool ScreenMarker::get_Initialised()  /*0x06000D2B*/
    IL_00f1: brtrue.s IL_00fb
    IL_00f3: ldarg.1
    IL_00f4: ldc.i4.0
    IL_00f5: callvirt void ScreenMarker::Show(bool)  /*0x06000D30*/
    IL_00fa: ret
    IL_00fb: ldloc.3
    IL_00fc: brfalse.s IL_0106
    IL_00fe: ldarg.1
    IL_00ff: ldfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_0104: brtrue.s IL_0111
    IL_0106: ldloc.3
    IL_0107: brtrue.s IL_0126
    IL_0109: ldarg.1
    IL_010a: ldfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_010f: brfalse.s IL_0126
    IL_0111: ldarg.0
    IL_0112: ldfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_0117: ldarg.1
    IL_0118: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_011d: ldarg.1
    IL_011e: ldc.i4.1
    IL_011f: callvirt void ScreenMarker::Show(bool)  /*0x06000D30*/
    IL_0124: br.s IL_012e
    IL_0126: ldarg.1
    IL_0127: ldc.i4.0
    IL_0128: callvirt void ScreenMarker::Show(bool)  /*0x06000D30*/
    IL_012d: ret
    IL_012e: ldarg.0
    IL_012f: ldfld ScreenMarkerManager.MarkerMode ScreenMarkerManager::markerMode  /*0x04000FD2*/
    IL_0134: brtrue IL_01c7
    IL_0139: ldarg.0
    IL_013a: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_013f: ldarg.1
    IL_0140: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_0145: stloc.s 4
    IL_0147: ldloca.s 4
    IL_0149: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_014e: ldc.r4 2f
    IL_0153: div
    IL_0154: sub
    IL_0155: ldloc.2
    IL_0156: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_015b: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0160: div
    IL_0161: stloc.s 5
    IL_0163: ldarg.0
    IL_0164: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_0169: ldarg.1
    IL_016a: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_016f: stloc.s 4
    IL_0171: ldloca.s 4
    IL_0173: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0178: ldc.r4 2f
    IL_017d: div
    IL_017e: sub
    IL_017f: ldloc.2
    IL_0180: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0185: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_018a: div
    IL_018b: stloc.s 6
    IL_018d: ldc.i4.3
    IL_018e: newarr System.Single  /*0x01000052*/
    IL_0193: dup
    IL_0194: ldc.i4.0
    IL_0195: ldloc.s 5
    IL_0197: stelem.r4
    IL_0198: dup
    IL_0199: ldc.i4.1
    IL_019a: ldloc.s 6
    IL_019c: stelem.r4
    IL_019d: dup
    IL_019e: ldc.i4.2
    IL_019f: ldc.r4 1f
    IL_01a4: stelem.r4
    IL_01a5: call float UnityEngine.Mathf::Min(float[])  /*0x0A0004BD*/
    IL_01aa: stloc.s 7
    IL_01ac: ldloc.2
    IL_01ad: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_01b2: ldloc.2
    IL_01b3: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_01b8: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_01bd: ldloc.s 7
    IL_01bf: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,float)  /*0x0A000156*/
    IL_01c4: stloc.2
    IL_01c5: br.s IL_023e
    IL_01c7: ldarg.1
    IL_01c8: callvirt Rect ScreenMarker::get_Rect()  /*0x06000D3E*/
    IL_01cd: stloc.s 8
    IL_01cf: ldloca.s 2
    IL_01d1: ldloc.2
    IL_01d2: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_01d7: ldarg.0
    IL_01d8: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_01dd: neg
    IL_01de: ldloca.s 8
    IL_01e0: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_01e5: ldc.r4 2f
    IL_01ea: div
    IL_01eb: add
    IL_01ec: ldarg.0
    IL_01ed: ldfld float ScreenMarkerManager::clampX  /*0x04000FD0*/
    IL_01f2: ldloca.s 8
    IL_01f4: call float UnityEngine.Rect::get_width()  /*0x0A000034*/
    IL_01f9: ldc.r4 2f
    IL_01fe: div
    IL_01ff: sub
    IL_0200: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0205: ldloc.2
    IL_0206: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_020b: ldarg.0
    IL_020c: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_0211: neg
    IL_0212: ldloca.s 8
    IL_0214: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0219: ldc.r4 2f
    IL_021e: div
    IL_021f: add
    IL_0220: ldarg.0
    IL_0221: ldfld float ScreenMarkerManager::clampY  /*0x04000FCF*/
    IL_0226: ldloca.s 8
    IL_0228: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_022d: ldc.r4 2f
    IL_0232: div
    IL_0233: sub
    IL_0234: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0239: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_023e: ldarg.1
    IL_023f: ldloc.2
    IL_0240: callvirt void ScreenMarker::set_Position(UnityEngine.Vector2)  /*0x06000D3B*/
    IL_0245: ldarg.1
    IL_0246: ldloc.2
    IL_0247: callvirt void ScreenMarker::set_ClampedScreenPos(UnityEngine.Vector2)  /*0x06000D28*/
    IL_024c: ret

  .method ScreenMarkerManager::.ctor()  // token 0x06000D4D rva 0x3ce71 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ScreenMarker>::.ctor()  /*0x0A0002AA*/
    IL_0006: stfld List<ScreenMarker> ScreenMarkerManager::screenMarkersActive  /*0x04000FC9*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<ScreenMarker>::.ctor()  /*0x0A0002AA*/
    IL_0011: stfld List<ScreenMarker> ScreenMarkerManager::screenMarkersToShow  /*0x04000FCA*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.Dictionary<ScreenMarker, int>::.ctor()  /*0x0A000587*/
    IL_001c: stfld Dictionary<ScreenMarker, int> ScreenMarkerManager::screenMarkerInGroup  /*0x04000FCB*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<System.Collections.Generic.List<ScreenMarker>>::.ctor()  /*0x0A000588*/
    IL_0027: stfld List<List<ScreenMarker>> ScreenMarkerManager::screenMarkerGroups  /*0x04000FCC*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

// ===== ScreenMarkerManager/MarkerMode  (token 0x02000265) =====
// ===== ScreenMarkerManager/SortNoGC  (token 0x02000266) =====
  .method ScreenMarkerManager.SortNoGC::Swap(System.Collections.Generic.IList<!!0>,int,int)  // token 0x06000D4E rva 0x3cea8 attrs Public, Static, HideBySig
    // code size 31 (0x1f), max stack 4, init locals
    .locals ([0] !!0)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: callvirt !0 System.Collections.Generic.IList<!!0>::get_Item(int)  /*0x0A0002F7*/
    IL_0007: stloc.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: ldarg.2
    IL_000c: callvirt !0 System.Collections.Generic.IList<!!0>::get_Item(int)  /*0x0A0002F7*/
    IL_0011: callvirt void System.Collections.Generic.IList<!!0>::set_Item(int,!0)  /*0x0A0002F8*/
    IL_0016: ldarg.0
    IL_0017: ldarg.2
    IL_0018: ldloc.0
    IL_0019: callvirt void System.Collections.Generic.IList<!!0>::set_Item(int,!0)  /*0x0A0002F8*/
    IL_001e: ret

  .method ScreenMarkerManager.SortNoGC::SortByX(System.Collections.Generic.List<ScreenMarker>)  // token 0x06000D4F rva 0x3ced4 attrs Public, Static, HideBySig
    // code size 186 (0xba), max stack 5, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_00ab
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: add
    IL_000a: stloc.1
    IL_000b: br IL_009b
    IL_0010: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_0015: ldarg.0
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_001c: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0021: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0026: ldarg.0
    IL_0027: ldloc.1
    IL_0028: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_002d: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0032: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0037: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_003c: stloc.2
    IL_003d: ldloc.2
    IL_003e: brfalse.s IL_004e
    IL_0040: ldloc.2
    IL_0041: ldc.i4.0
    IL_0042: ble.s IL_0097
    IL_0044: ldarg.0
    IL_0045: ldloc.0
    IL_0046: ldloc.1
    IL_0047: call void ScreenMarkerManager.SortNoGC::Swap(System.Collections.Generic.IList<!!0>,int,int)<ScreenMarker>  /*0x2B0000C6*/
    IL_004c: br.s IL_0097
    IL_004e: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_0053: ldarg.0
    IL_0054: ldloc.0
    IL_0055: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_005a: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_005f: ldarg.0
    IL_0060: ldloc.0
    IL_0061: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0066: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_006b: conv.r4
    IL_006c: sub
    IL_006d: ldarg.0
    IL_006e: ldloc.1
    IL_006f: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0074: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0079: ldarg.0
    IL_007a: ldloc.1
    IL_007b: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0080: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0085: conv.r4
    IL_0086: sub
    IL_0087: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_008c: ldc.i4.0
    IL_008d: ble.s IL_0097
    IL_008f: ldarg.0
    IL_0090: ldloc.0
    IL_0091: ldloc.1
    IL_0092: call void ScreenMarkerManager.SortNoGC::Swap(System.Collections.Generic.IList<!!0>,int,int)<ScreenMarker>  /*0x2B0000C6*/
    IL_0097: ldloc.1
    IL_0098: ldc.i4.1
    IL_0099: add
    IL_009a: stloc.1
    IL_009b: ldloc.1
    IL_009c: ldarg.0
    IL_009d: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00a2: blt IL_0010
    IL_00a7: ldloc.0
    IL_00a8: ldc.i4.1
    IL_00a9: add
    IL_00aa: stloc.0
    IL_00ab: ldloc.0
    IL_00ac: ldarg.0
    IL_00ad: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00b2: ldc.i4.1
    IL_00b3: sub
    IL_00b4: blt IL_0007
    IL_00b9: ret

  .method ScreenMarkerManager.SortNoGC::SortByY(System.Collections.Generic.List<ScreenMarker>)  // token 0x06000D50 rva 0x3cf9c attrs Public, Static, HideBySig
    // code size 186 (0xba), max stack 5, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_00ab
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: add
    IL_000a: stloc.1
    IL_000b: br IL_009b
    IL_0010: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_0015: ldarg.0
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_001c: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0021: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0026: ldarg.0
    IL_0027: ldloc.1
    IL_0028: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_002d: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0032: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0037: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_003c: stloc.2
    IL_003d: ldloc.2
    IL_003e: brfalse.s IL_004e
    IL_0040: ldloc.2
    IL_0041: ldc.i4.0
    IL_0042: ble.s IL_0097
    IL_0044: ldarg.0
    IL_0045: ldloc.0
    IL_0046: ldloc.1
    IL_0047: call void ScreenMarkerManager.SortNoGC::Swap(System.Collections.Generic.IList<!!0>,int,int)<ScreenMarker>  /*0x2B0000C6*/
    IL_004c: br.s IL_0097
    IL_004e: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_0053: ldarg.0
    IL_0054: ldloc.0
    IL_0055: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_005a: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_005f: ldarg.0
    IL_0060: ldloc.0
    IL_0061: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0066: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_006b: conv.r4
    IL_006c: sub
    IL_006d: ldarg.0
    IL_006e: ldloc.1
    IL_006f: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0074: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0079: ldarg.0
    IL_007a: ldloc.1
    IL_007b: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0080: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0085: conv.r4
    IL_0086: sub
    IL_0087: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_008c: ldc.i4.0
    IL_008d: ble.s IL_0097
    IL_008f: ldarg.0
    IL_0090: ldloc.0
    IL_0091: ldloc.1
    IL_0092: call void ScreenMarkerManager.SortNoGC::Swap(System.Collections.Generic.IList<!!0>,int,int)<ScreenMarker>  /*0x2B0000C6*/
    IL_0097: ldloc.1
    IL_0098: ldc.i4.1
    IL_0099: add
    IL_009a: stloc.1
    IL_009b: ldloc.1
    IL_009c: ldarg.0
    IL_009d: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00a2: blt IL_0010
    IL_00a7: ldloc.0
    IL_00a8: ldc.i4.1
    IL_00a9: add
    IL_00aa: stloc.0
    IL_00ab: ldloc.0
    IL_00ac: ldarg.0
    IL_00ad: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00b2: ldc.i4.1
    IL_00b3: sub
    IL_00b4: blt IL_0007
    IL_00b9: ret

// ===== ScreenMarkerManager/ComparePositionX  (token 0x02000267) =====
  .method ScreenMarkerManager.ComparePositionX::Compare(ScreenMarker,ScreenMarker)  // token 0x06000D51 rva 0x3d064 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 111 (0x6f), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0006: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_000b: box System.Single  /*0x01000052*/
    IL_0010: ldarg.2
    IL_0011: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0016: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_001b: box System.Single  /*0x01000052*/
    IL_0020: call bool System.Object::Equals(object,object)  /*0x0A00058B*/
    IL_0025: brtrue.s IL_0048
    IL_0027: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_002c: ldarg.1
    IL_002d: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0032: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0037: ldarg.2
    IL_0038: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_003d: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0042: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_0047: ret
    IL_0048: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_004d: ldarg.1
    IL_004e: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0053: ldarg.1
    IL_0054: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0059: conv.r4
    IL_005a: sub
    IL_005b: ldarg.2
    IL_005c: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0061: ldarg.2
    IL_0062: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0067: conv.r4
    IL_0068: sub
    IL_0069: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_006e: ret

  .method ScreenMarkerManager.ComparePositionX::.ctor()  // token 0x06000D52 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== ScreenMarkerManager/ComparePositionY  (token 0x02000268) =====
  .method ScreenMarkerManager.ComparePositionY::Compare(ScreenMarker,ScreenMarker)  // token 0x06000D53 rva 0x3d0e0 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 111 (0x6f), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0006: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_000b: box System.Single  /*0x01000052*/
    IL_0010: ldarg.2
    IL_0011: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0016: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_001b: box System.Single  /*0x01000052*/
    IL_0020: call bool System.Object::Equals(object,object)  /*0x0A00058B*/
    IL_0025: brtrue.s IL_0048
    IL_0027: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_002c: ldarg.1
    IL_002d: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_0032: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0037: ldarg.2
    IL_0038: callvirt Vector2 ScreenMarker::get_UnclampedScreenPos()  /*0x06000D25*/
    IL_003d: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0042: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_0047: ret
    IL_0048: call Comparer<!0> System.Collections.Generic.Comparer<float>::get_Default()  /*0x0A000589*/
    IL_004d: ldarg.1
    IL_004e: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0053: ldarg.1
    IL_0054: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0059: conv.r4
    IL_005a: sub
    IL_005b: ldarg.2
    IL_005c: callvirt float ScreenMarker::get_MyRandomVal()  /*0x06000D24*/
    IL_0061: ldarg.2
    IL_0062: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0067: conv.r4
    IL_0068: sub
    IL_0069: callvirt int System.Collections.Generic.Comparer<float>::Compare(!0,!0)  /*0x0A00058A*/
    IL_006e: ret

  .method ScreenMarkerManager.ComparePositionY::.ctor()  // token 0x06000D54 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

