// ===== VirtualBuilding  (token 0x0200013F) =====
  .method VirtualBuilding::get_RepresentingBuildSlot()  // token 0x060006C8 rva 0x1e21c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot VirtualBuilding::<RepresentingBuildSlot>k__BackingField  /*0x04000826*/
    IL_0006: ret

  .method VirtualBuilding::set_RepresentingBuildSlot(BuildSlot)  // token 0x060006C9 rva 0x1e224 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld BuildSlot VirtualBuilding::<RepresentingBuildSlot>k__BackingField  /*0x04000826*/
    IL_0007: ret

  .method VirtualBuilding::Reset()  // token 0x060006CA rva 0x1e22d attrs Public, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld bool VirtualBuilding::builtReset  /*0x0400081B*/
    IL_0007: stfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld int VirtualBuilding::costReset  /*0x0400081D*/
    IL_0013: stfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: ldfld int VirtualBuilding::incomeReset  /*0x04000820*/
    IL_001f: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0024: ldarg.0
    IL_0025: ldarg.0
    IL_0026: ldfld float VirtualBuilding::priorityReset  /*0x04000823*/
    IL_002b: stfld float VirtualBuilding::priority  /*0x04000822*/
    IL_0030: ret

  .method VirtualBuilding::IsBuildable(int,System.Collections.Generic.List<VirtualBuilding>)  // token 0x060006CB rva 0x1e260 attrs Public, HideBySig
    // code size 136 (0x88), max stack 4, init locals
    .locals ([0] List.Enumerator<int>, [1] int, [2] bool, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_0006: brfalse.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld int VirtualBuilding::cost  /*0x0400081C*/
    IL_0010: ldarg.1
    IL_0011: ble.s IL_0015
    IL_0013: ldc.i4.0
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: ldfld List<int> VirtualBuilding::requirementIndexes  /*0x0400081E*/
    IL_001b: callvirt List.Enumerator<!0> System.Collections.Generic.List<int>::GetEnumerator()  /*0x0A0002C5*/
    IL_0020: stloc.0
    IL_0021: br.s IL_006b
    IL_0023: ldloca.s 0
    IL_0025: call !0 System.Collections.Generic.List.Enumerator<int>::get_Current()  /*0x0A0002C6*/
    IL_002a: stloc.1
    IL_002b: ldarg.2
    IL_002c: ldloc.1
    IL_002d: callvirt !0 System.Collections.Generic.List<VirtualBuilding>::get_Item(int)  /*0x0A0002C7*/
    IL_0032: ldfld bool VirtualBuilding::built  /*0x0400081A*/
    IL_0037: brtrue.s IL_003d
    IL_0039: ldc.i4.0
    IL_003a: stloc.2
    IL_003b: leave.s IL_0086
    IL_003d: leave.s IL_006b
    IL_003f: pop
    IL_0040: ldstr "inx: "
    IL_0045: ldloca.s 1
    IL_0047: call string System.Int32::ToString()  /*0x0A000031*/
    IL_004c: ldstr "\n_virtualBuildings.Count: "
    IL_0051: ldarg.2
    IL_0052: callvirt int System.Collections.Generic.List<VirtualBuilding>::get_Count()  /*0x0A0002C8*/
    IL_0057: stloc.3
    IL_0058: ldloca.s 3
    IL_005a: call string System.Int32::ToString()  /*0x0A000031*/
    IL_005f: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0064: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0069: leave.s IL_006b
    IL_006b: ldloca.s 0
    IL_006d: call bool System.Collections.Generic.List.Enumerator<int>::MoveNext()  /*0x0A0002C9*/
    IL_0072: brtrue.s IL_0023
    IL_0074: leave.s IL_0084
    IL_0076: ldloca.s 0
    IL_0078: constrained. System.Collections.Generic.List.Enumerator<int>  /*0x1B00007C*/
    IL_007e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0083: endfinally
    IL_0084: ldc.i4.1
    IL_0085: ret
    IL_0086: ldloc.2
    IL_0087: ret
    .try IL_002b-IL_003f catch System.Object handler IL_003f-IL_006b
    .try IL_0021-IL_0076 finally handler IL_0076-IL_0084

  .method VirtualBuilding::.ctor()  // token 0x060006CC rva 0x1e310 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 101 (0x65), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0006: stfld List<int> VirtualBuilding::requirementIndexes  /*0x0400081E*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent VirtualBuilding::callAfterIncome  /*0x04000821*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldftn void VirtualBuilding::MillLowerIncome()  /*0x060006CD*/
    IL_0024: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0029: stfld UnityAction VirtualBuilding::ActionMillLowerIncome  /*0x04000828*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldftn void VirtualBuilding::HarborIncreaseIncomeLvl1()  /*0x060006D0*/
    IL_0036: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003b: stfld UnityAction VirtualBuilding::ActionHarborIncreaseIncomeLvl1  /*0x0400082B*/
    IL_0040: ldarg.0
    IL_0041: ldarg.0
    IL_0042: ldftn void VirtualBuilding::ShrineActivate()  /*0x060006CF*/
    IL_0048: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004d: stfld UnityAction VirtualBuilding::ActionShrineActivate  /*0x0400082A*/
    IL_0052: ldarg.0
    IL_0053: ldarg.0
    IL_0054: ldftn void VirtualBuilding::SetIncomToZero()  /*0x060006CE*/
    IL_005a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005f: stfld UnityAction VirtualBuilding::ActionSetIncomToZero  /*0x04000829*/
    IL_0064: ret

  .method VirtualBuilding::MillLowerIncome()  // token 0x060006CD rva 0x1e381 attrs Public, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: ldarg.0
    IL_0003: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0008: ldc.i4.1
    IL_0009: sub
    IL_000a: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_000f: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0014: ret

  .method VirtualBuilding::SetIncomToZero()  // token 0x060006CE rva 0x1e397 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0007: ret

  .method VirtualBuilding::ShrineActivate()  // token 0x060006CF rva 0x1e3a0 attrs Public, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: ldarg.0
    IL_0003: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0008: ldc.i4.1
    IL_0009: add
    IL_000a: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_000f: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0014: ret

  .method VirtualBuilding::HarborIncreaseIncomeLvl1()  // token 0x060006D0 rva 0x1e3b8 attrs Public, HideBySig
    // code size 160 (0xa0), max stack 4, init locals
    .locals ([0] List.Enumerator<VirtualBuilding>, [1] VirtualBuilding)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.5
    IL_0002: ldarg.0
    IL_0003: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0008: ldc.i4.1
    IL_0009: add
    IL_000a: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_000f: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0014: call List<VirtualBuilding> EconomySimulator::get_VirtualBuildings()  /*0x060006C1*/
    IL_0019: callvirt List.Enumerator<!0> System.Collections.Generic.List<VirtualBuilding>::GetEnumerator()  /*0x0A0002C1*/
    IL_001e: stloc.0
    IL_001f: br.s IL_0086
    IL_0021: ldloca.s 0
    IL_0023: call !0 System.Collections.Generic.List.Enumerator<VirtualBuilding>::get_Current()  /*0x0A0002C2*/
    IL_0028: stloc.1
    IL_0029: ldloc.1
    IL_002a: ldfld string VirtualBuilding::name  /*0x04000819*/
    IL_002f: ldarg.0
    IL_0030: ldfld string VirtualBuilding::name  /*0x04000819*/
    IL_0035: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_003a: brtrue.s IL_0086
    IL_003c: ldloc.1
    IL_003d: ldfld int VirtualBuilding::representingLevel  /*0x04000827*/
    IL_0042: ldarg.0
    IL_0043: ldfld int VirtualBuilding::representingLevel  /*0x04000827*/
    IL_0048: ldc.i4.1
    IL_0049: add
    IL_004a: bne.un.s IL_0086
    IL_004c: ldloc.1
    IL_004d: ldfld List<int> VirtualBuilding::requirementIndexes  /*0x0400081E*/
    IL_0052: call List<VirtualBuilding> EconomySimulator::get_VirtualBuildings()  /*0x060006C1*/
    IL_0057: ldarg.0
    IL_0058: callvirt int System.Collections.Generic.List<VirtualBuilding>::IndexOf(!0)  /*0x0A0002CA*/
    IL_005d: callvirt bool System.Collections.Generic.List<int>::Contains(!0)  /*0x0A000123*/
    IL_0062: brfalse.s IL_0086
    IL_0064: ldloc.1
    IL_0065: ldarg.0
    IL_0066: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_006b: stfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0070: ldloc.1
    IL_0071: ldfld int VirtualBuilding::income  /*0x0400081F*/
    IL_0076: ldc.i4.4
    IL_0077: blt.s IL_008f
    IL_0079: ldloc.1
    IL_007a: ldc.r4 90f
    IL_007f: stfld float VirtualBuilding::priority  /*0x04000822*/
    IL_0084: leave.s IL_009f
    IL_0086: ldloca.s 0
    IL_0088: call bool System.Collections.Generic.List.Enumerator<VirtualBuilding>::MoveNext()  /*0x0A0002C3*/
    IL_008d: brtrue.s IL_0021
    IL_008f: leave.s IL_009f
    IL_0091: ldloca.s 0
    IL_0093: constrained. System.Collections.Generic.List.Enumerator<VirtualBuilding>  /*0x1B00007B*/
    IL_0099: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009e: endfinally
    IL_009f: ret
    .try IL_001f-IL_0091 finally handler IL_0091-IL_009f

