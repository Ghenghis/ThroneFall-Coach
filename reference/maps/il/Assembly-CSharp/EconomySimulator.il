// ===== EconomySimulator  (token 0x0200013E) =====
  .method EconomySimulator::get_VirtualBuildings()  // token 0x060006C1 rva 0x1ddfc attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld List<VirtualBuilding> EconomySimulator::virtualBuildingsRef  /*0x04000818*/
    IL_0005: ret

  .method EconomySimulator::SimulateEconomy(ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<string>,ref System.Collections.Generic.List<int>,System.Collections.Generic.List<VirtualBuilding>,int,float,int,int,int)  // token 0x060006C2 rva 0x1de04 attrs Public, Static, HideBySig
    // code size 616 (0x268), max stack 14, init locals
    .locals ([0] int, [1] int, [2] List.Enumerator<VirtualBuilding>, [3] int, [4] int, [5] int, [6] string, [7] int, [8] int, [9] int, [10] int, [11] int, [12] VirtualBuilding, [13] VirtualBuilding, [14] VirtualBuilding)
    IL_0000: ldarg.s 7
    IL_0002: stsfld List<VirtualBuilding> EconomySimulator::virtualBuildingsRef  /*0x04000818*/
    IL_0007: ldarg.s 7
    IL_0009: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_000e: stloc.2
    IL_000f: br.s IL_001d
    IL_0011: ldloca.s 2
    IL_0013: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0018: callvirt void VirtualBuilding::Reset()  /*0x060006CA*/
    IL_001d: ldloca.s 2
    IL_001f: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_0024: brtrue.s IL_0011
    IL_0026: leave.s IL_0036
    IL_0028: ldloca.s 2
    IL_002a: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_0030: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0035: endfinally
    IL_0036: ldarg.0
    IL_0037: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_003c: stind.ref
    IL_003d: ldarg.1
    IL_003e: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0043: stind.ref
    IL_0044: ldarg.2
    IL_0045: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_004a: stind.ref
    IL_004b: ldarg.s 4
    IL_004d: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0052: stind.ref
    IL_0053: ldarg.3
    IL_0054: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0059: stind.ref
    IL_005a: ldarg.s 5
    IL_005c: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0061: stind.ref
    IL_0062: ldarg.s 6
    IL_0064: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0069: stind.ref
    IL_006a: ldarg.s 8
    IL_006c: stloc.0
    IL_006d: ldarg.s 8
    IL_006f: stloc.1
    IL_0070: ldc.i4.0
    IL_0071: stloc.3
    IL_0072: br IL_025f
    IL_0077: ldloc.0
    IL_0078: conv.r4
    IL_0079: ldc.r4 3f
    IL_007e: div
    IL_007f: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0084: stloc.s 4
    IL_0086: ldloc.0
    IL_0087: ldloc.s 4
    IL_0089: sub
    IL_008a: stloc.s 5
    IL_008c: ldloc.3
    IL_008d: ldarg.s 12
    IL_008f: ldc.i4.2
    IL_0090: sub
    IL_0091: blt.s IL_0099
    IL_0093: ldloc.0
    IL_0094: stloc.s 4
    IL_0096: ldc.i4.0
    IL_0097: stloc.s 5
    IL_0099: ldstr ""
    IL_009e: stloc.s 6
    IL_00a0: ldloc.s 6
    IL_00a2: ldloca.s 4
    IL_00a4: ldloca.s 0
    IL_00a6: ldarg.s 7
    IL_00a8: ldc.i4.0
    IL_00a9: call string EconomySimulator::SimulateSpending(ref int,ref int,System.Collections.Generic.List<VirtualBuilding>,bool)  /*0x060006C4*/
    IL_00ae: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b3: stloc.s 6
    IL_00b5: ldloc.s 6
    IL_00b7: ldloca.s 5
    IL_00b9: ldloca.s 0
    IL_00bb: ldarg.s 7
    IL_00bd: ldc.i4.1
    IL_00be: call string EconomySimulator::SimulateSpending(ref int,ref int,System.Collections.Generic.List<VirtualBuilding>,bool)  /*0x060006C4*/
    IL_00c3: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00c8: stloc.s 6
    IL_00ca: ldarg.s 7
    IL_00cc: call bool EconomySimulator::AllBuildingsBuilt(System.Collections.Generic.List<VirtualBuilding>)  /*0x060006C5*/
    IL_00d1: brfalse.s IL_00f0
    IL_00d3: ldarg.0
    IL_00d4: ldarg.1
    IL_00d5: ldarg.2
    IL_00d6: ldarg.3
    IL_00d7: ldarg.s 4
    IL_00d9: ldarg.s 5
    IL_00db: ldarg.s 6
    IL_00dd: ldarg.s 7
    IL_00df: ldarg.s 8
    IL_00e1: ldarg.s 9
    IL_00e3: ldarg.s 10
    IL_00e5: ldarg.s 11
    IL_00e7: ldloc.3
    IL_00e8: ldc.i4.1
    IL_00e9: sub
    IL_00ea: call void EconomySimulator::SimulateEconomy(ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<int>,ref System.Collections.Generic.List<string>,ref System.Collections.Generic.List<int>,System.Collections.Generic.List<VirtualBuilding>,int,float,int,int,int)  /*0x060006C2*/
    IL_00ef: ret
    IL_00f0: ldc.i4.0
    IL_00f1: stloc.s 7
    IL_00f3: ldarg.s 7
    IL_00f5: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_00fa: stloc.2
    IL_00fb: br.s IL_011b
    IL_00fd: ldloca.s 2
    IL_00ff: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0104: stloc.s 12
    IL_0106: ldloc.s 12
    IL_0108: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_010d: brfalse.s IL_011b
    IL_010f: ldloc.s 7
    IL_0111: ldloc.s 12
    IL_0113: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0118: add
    IL_0119: stloc.s 7
    IL_011b: ldloca.s 2
    IL_011d: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_0122: brtrue.s IL_00fd
    IL_0124: leave.s IL_0134
    IL_0126: ldloca.s 2
    IL_0128: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_012e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0133: endfinally
    IL_0134: ldarg.s 7
    IL_0136: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_013b: stloc.2
    IL_013c: br.s IL_0165
    IL_013e: ldloca.s 2
    IL_0140: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0145: stloc.s 13
    IL_0147: ldloc.s 13
    IL_0149: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_014e: brfalse.s IL_0165
    IL_0150: ldloc.s 13
    IL_0152: ldfld UnityEvent VirtualBuilding::callAfterIncome  /*0x04000821*/
    IL_0157: brfalse.s IL_0165
    IL_0159: ldloc.s 13
    IL_015b: ldfld UnityEvent VirtualBuilding::callAfterIncome  /*0x04000821*/
    IL_0160: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0165: ldloca.s 2
    IL_0167: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_016c: brtrue.s IL_013e
    IL_016e: leave.s IL_017e
    IL_0170: ldloca.s 2
    IL_0172: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_0178: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_017d: endfinally
    IL_017e: ldloc.1
    IL_017f: conv.r4
    IL_0180: ldarg.s 9
    IL_0182: mul
    IL_0183: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0188: ldarg.s 10
    IL_018a: ldarg.s 11
    IL_018c: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0191: stloc.s 8
    IL_0193: ldloc.3
    IL_0194: ldarg.s 12
    IL_0196: ldc.i4.1
    IL_0197: sub
    IL_0198: blt.s IL_019d
    IL_019a: ldc.i4.0
    IL_019b: stloc.s 8
    IL_019d: ldloc.0
    IL_019e: ldloc.s 7
    IL_01a0: ldloc.s 8
    IL_01a2: add
    IL_01a3: add
    IL_01a4: stloc.0
    IL_01a5: ldc.i4.0
    IL_01a6: stloc.s 9
    IL_01a8: ldc.i4.0
    IL_01a9: stloc.s 10
    IL_01ab: ldc.i4.0
    IL_01ac: stloc.s 11
    IL_01ae: ldarg.s 7
    IL_01b0: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_01b5: stloc.2
    IL_01b6: br.s IL_01f9
    IL_01b8: ldloca.s 2
    IL_01ba: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_01bf: stloc.s 14
    IL_01c1: ldloc.s 14
    IL_01c3: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_01c8: brfalse.s IL_01f9
    IL_01ca: ldloc.s 14
    IL_01cc: ldfld bool VirtualBuilding::economicBuilding  /*0x04000824*/
    IL_01d1: brfalse.s IL_01e1
    IL_01d3: ldloc.s 9
    IL_01d5: ldloc.s 14
    IL_01d7: ldfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_01dc: add
    IL_01dd: stloc.s 9
    IL_01df: br.s IL_01ed
    IL_01e1: ldloc.s 10
    IL_01e3: ldloc.s 14
    IL_01e5: ldfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_01ea: add
    IL_01eb: stloc.s 10
    IL_01ed: ldloc.s 11
    IL_01ef: ldloc.s 14
    IL_01f1: ldfld int VirtualBuilding::defensePower  /*0x04000825*/
    IL_01f6: add
    IL_01f7: stloc.s 11
    IL_01f9: ldloca.s 2
    IL_01fb: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_0200: brtrue.s IL_01b8
    IL_0202: leave.s IL_0212
    IL_0204: ldloca.s 2
    IL_0206: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_020c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0211: endfinally
    IL_0212: ldarg.s 4
    IL_0214: ldind.ref
    IL_0215: ldloc.s 8
    IL_0217: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_021c: ldarg.2
    IL_021d: ldind.ref
    IL_021e: ldloc.1
    IL_021f: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0224: ldarg.0
    IL_0225: ldind.ref
    IL_0226: ldloc.s 9
    IL_0228: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_022d: ldarg.1
    IL_022e: ldind.ref
    IL_022f: ldloc.s 10
    IL_0231: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0236: ldarg.3
    IL_0237: ldind.ref
    IL_0238: ldloc.s 7
    IL_023a: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_023f: ldarg.s 5
    IL_0241: ldind.ref
    IL_0242: ldloc.s 6
    IL_0244: callvirt void System.Collections.Generic.List<string>::Add(!0)  /*0x0A000027*/
    IL_0249: ldarg.s 6
    IL_024b: ldind.ref
    IL_024c: ldloc.s 11
    IL_024e: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_0253: ldloc.1
    IL_0254: ldloc.s 7
    IL_0256: ldloc.s 8
    IL_0258: add
    IL_0259: add
    IL_025a: stloc.1
    IL_025b: ldloc.3
    IL_025c: ldc.i4.1
    IL_025d: add
    IL_025e: stloc.3
    IL_025f: ldloc.3
    IL_0260: ldarg.s 12
    IL_0262: blt IL_0077
    IL_0267: ret
    .try IL_000f-IL_0028 finally handler IL_0028-IL_0036
    .try IL_00fb-IL_0126 finally handler IL_0126-IL_0134
    .try IL_013c-IL_0170 finally handler IL_0170-IL_017e
    .try IL_01b6-IL_0204 finally handler IL_0204-IL_0212

  .method EconomySimulator::FindBestBuilding(int,System.Collections.Generic.List<VirtualBuilding>,bool)  // token 0x060006C3 rva 0x1e0ac attrs Private, Static, HideBySig
    // code size 97 (0x61), max stack 3, init locals
    .locals ([0] float, [1] VirtualBuilding, [2] List.Enumerator<VirtualBuilding>, [3] VirtualBuilding)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldnull
    IL_0007: stloc.1
    IL_0008: ldarg.1
    IL_0009: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_000e: stloc.2
    IL_000f: br.s IL_0046
    IL_0011: ldloca.s 2
    IL_0013: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0018: stloc.3
    IL_0019: ldloc.3
    IL_001a: ldfld bool VirtualBuilding::economicBuilding  /*0x04000824*/
    IL_001f: ldarg.2
    IL_0020: bne.un.s IL_0046
    IL_0022: ldloc.3
    IL_0023: ldarg.0
    IL_0024: ldarg.1
    IL_0025: callvirt bool VirtualBuilding::IsBuildable(int,System.Collections.Generic.List<VirtualBuilding>)  /*0x060006CB*/
    IL_002a: brfalse.s IL_0046
    IL_002c: ldloc.3
    IL_002d: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_0032: brtrue.s IL_0046
    IL_0034: ldloc.3
    IL_0035: ldfld float VirtualBuilding::priority  /*0x04000822*/
    IL_003a: ldloc.0
    IL_003b: ble.un.s IL_0046
    IL_003d: ldloc.3
    IL_003e: ldfld float VirtualBuilding::priority  /*0x04000822*/
    IL_0043: stloc.0
    IL_0044: ldloc.3
    IL_0045: stloc.1
    IL_0046: ldloca.s 2
    IL_0048: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_004d: brtrue.s IL_0011
    IL_004f: leave.s IL_005f
    IL_0051: ldloca.s 2
    IL_0053: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_0059: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005e: endfinally
    IL_005f: ldloc.1
    IL_0060: ret
    .try IL_000f-IL_0051 finally handler IL_0051-IL_005f

  .method EconomySimulator::SimulateSpending(ref int,ref int,System.Collections.Generic.List<VirtualBuilding>,bool)  // token 0x060006C4 rva 0x1e12c attrs Private, Static, HideBySig
    // code size 129 (0x81), max stack 4, init locals
    .locals ([0] string, [1] int, [2] VirtualBuilding)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: ldc.i4 10000
    IL_000b: stloc.1
    IL_000c: br.s IL_007b
    IL_000e: ldarg.0
    IL_000f: ldind.i4
    IL_0010: ldarg.2
    IL_0011: ldarg.3
    IL_0012: call VirtualBuilding EconomySimulator::FindBestBuilding(int,System.Collections.Generic.List<VirtualBuilding>,bool)  /*0x060006C3*/
    IL_0017: stloc.2
    IL_0018: ldloc.2
    IL_0019: brfalse.s IL_007f
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldind.i4
    IL_001e: ldloc.2
    IL_001f: ldfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_0024: sub
    IL_0025: stind.i4
    IL_0026: ldarg.1
    IL_0027: ldarg.1
    IL_0028: ldind.i4
    IL_0029: ldloc.2
    IL_002a: ldfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_002f: sub
    IL_0030: stind.i4
    IL_0031: ldloc.2
    IL_0032: ldc.i4.1
    IL_0033: stfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_0038: ldc.i4.6
    IL_0039: newarr System.String  /*0x0100001D*/
    IL_003e: dup
    IL_003f: ldc.i4.0
    IL_0040: ldloc.0
    IL_0041: stelem.ref
    IL_0042: dup
    IL_0043: ldc.i4.1
    IL_0044: ldstr "("
    IL_0049: stelem.ref
    IL_004a: dup
    IL_004b: ldc.i4.2
    IL_004c: ldloc.2
    IL_004d: ldfld string VirtualBuilding::name  /*0x04000819*/
    IL_0052: stelem.ref
    IL_0053: dup
    IL_0054: ldc.i4.3
    IL_0055: ldstr " Level "
    IL_005a: stelem.ref
    IL_005b: dup
    IL_005c: ldc.i4.4
    IL_005d: ldloc.2
    IL_005e: ldflda int VirtualBuilding::representingLevel  /*0x04000827*/
    IL_0063: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0068: stelem.ref
    IL_0069: dup
    IL_006a: ldc.i4.5
    IL_006b: ldstr ") "
    IL_0070: stelem.ref
    IL_0071: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0076: stloc.0
    IL_0077: ldloc.1
    IL_0078: ldc.i4.1
    IL_0079: sub
    IL_007a: stloc.1
    IL_007b: ldloc.1
    IL_007c: ldc.i4.0
    IL_007d: bge.s IL_000e
    IL_007f: ldloc.0
    IL_0080: ret

  .method EconomySimulator::AllBuildingsBuilt(System.Collections.Generic.List<VirtualBuilding>)  // token 0x060006C5 rva 0x1e1bc attrs Private, Static, HideBySig
    // code size 56 (0x38), max stack 1, init locals
    .locals ([0] List.Enumerator<VirtualBuilding>, [1] bool)
    IL_0000: ldarg.0
    IL_0001: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_0006: stloc.0
    IL_0007: br.s IL_001b
    IL_0009: ldloca.s 0
    IL_000b: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0010: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_0015: brtrue.s IL_001b
    IL_0017: ldc.i4.0
    IL_0018: stloc.1
    IL_0019: leave.s IL_0036
    IL_001b: ldloca.s 0
    IL_001d: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_0022: brtrue.s IL_0009
    IL_0024: leave.s IL_0034
    IL_0026: ldloca.s 0
    IL_0028: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_002e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0033: endfinally
    IL_0034: ldc.i4.1
    IL_0035: ret
    IL_0036: ldloc.1
    IL_0037: ret
    .try IL_0007-IL_0026 finally handler IL_0026-IL_0034

  .method EconomySimulator::.ctor()  // token 0x060006C6 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method EconomySimulator::.cctor()  // token 0x060006C7 rva 0x1e210 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<VirtualBuilding>::.ctor()  /*0x0A0002C4*/
    IL_0005: stsfld List<VirtualBuilding> EconomySimulator::virtualBuildingsRef  /*0x04000818*/
    IL_000a: ret

