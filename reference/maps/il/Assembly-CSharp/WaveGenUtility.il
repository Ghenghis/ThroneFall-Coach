// ===== WaveGenUtility  (token 0x0200015E) =====
  .method WaveGenUtility::GetRandomElements(System.Collections.Generic.List<!!0>,int,System.Random)  // token 0x0600072F rva 0x2455c attrs Public, Static, HideBySig
    // code size 43 (0x2b), max stack 3, init locals
    .locals ([0] WaveGenUtility.<>c__DisplayClass0_0<!!0>)
    IL_0000: newobj void WaveGenUtility.<>c__DisplayClass0_0<!!0>::.ctor()  /*0x0A000358*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.2
    IL_0008: stfld Random WaveGenUtility.<>c__DisplayClass0_0<!!0>::random  /*0x0A000359*/
    IL_000d: ldarg.0
    IL_000e: ldloc.0
    IL_000f: ldftn int WaveGenUtility.<>c__DisplayClass0_0<!!0>::<GetRandomElements>b__0(!0)  /*0x0A00035A*/
    IL_0015: newobj void System.Func<!!0, int>::.ctor(object,IntPtr)  /*0x0A00035B*/
    IL_001a: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<!!0,int>  /*0x2B000081*/
    IL_001f: ldarg.1
    IL_0020: call IEnumerable<!!0> System.Linq.Enumerable::Take(System.Collections.Generic.IEnumerable<!!0>,int)<!!0>  /*0x2B000082*/
    IL_0025: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<!!0>  /*0x2B000083*/
    IL_002a: ret

  .method WaveGenUtility::DistributeEnemies(int,int)  // token 0x06000730 rva 0x24594 attrs Public, Static, HideBySig
    // code size 189 (0xbd), max stack 4, init locals
    .locals ([0] List<float>, [1] List<int>, [2] float, [3] int, [4] int, [5] float, [6] int, [7] float, [8] int, [9] List<int>)
    IL_0000: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0005: stloc.0
    IL_0006: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_000b: stloc.1
    IL_000c: ldc.r4 0f
    IL_0011: stloc.2
    IL_0012: ldc.i4.0
    IL_0013: stloc.s 4
    IL_0015: br.s IL_003b
    IL_0017: ldc.r4 0.2f
    IL_001c: ldc.r4 1f
    IL_0021: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0026: stloc.s 5
    IL_0028: ldloc.0
    IL_0029: ldloc.s 5
    IL_002b: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_0030: ldloc.2
    IL_0031: ldloc.s 5
    IL_0033: add
    IL_0034: stloc.2
    IL_0035: ldloc.s 4
    IL_0037: ldc.i4.1
    IL_0038: add
    IL_0039: stloc.s 4
    IL_003b: ldloc.s 4
    IL_003d: ldarg.1
    IL_003e: blt.s IL_0017
    IL_0040: ldloc.0
    IL_0041: ldsfld Comparison<float> WaveGenUtility.<>c::<>9__1_0  /*0x04000915*/
    IL_0046: dup
    IL_0047: brtrue.s IL_0060
    IL_0049: pop
    IL_004a: ldsfld WaveGenUtility.<>c WaveGenUtility.<>c::<>9  /*0x04000914*/
    IL_004f: ldftn int WaveGenUtility.<>c::<DistributeEnemies>b__1_0(float,float)  /*0x06000734*/
    IL_0055: newobj void System.Comparison<float>::.ctor(object,IntPtr)  /*0x0A00035E*/
    IL_005a: dup
    IL_005b: stsfld Comparison<float> WaveGenUtility.<>c::<>9__1_0  /*0x04000915*/
    IL_0060: callvirt void System.Collections.Generic.List<float>::Sort(System.Comparison<!0>)  /*0x0A00035F*/
    IL_0065: ldc.i4.0
    IL_0066: stloc.3
    IL_0067: ldc.i4.0
    IL_0068: stloc.s 6
    IL_006a: br.s IL_0097
    IL_006c: ldloc.0
    IL_006d: ldloc.s 6
    IL_006f: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0074: ldloc.2
    IL_0075: div
    IL_0076: stloc.s 7
    IL_0078: ldarg.0
    IL_0079: conv.r4
    IL_007a: ldloc.s 7
    IL_007c: mul
    IL_007d: call int UnityEngine.Mathf::FloorToInt(float)  /*0x0A000144*/
    IL_0082: stloc.s 8
    IL_0084: ldloc.1
    IL_0085: ldloc.s 8
    IL_0087: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_008c: ldloc.3
    IL_008d: ldloc.s 8
    IL_008f: add
    IL_0090: stloc.3
    IL_0091: ldloc.s 6
    IL_0093: ldc.i4.1
    IL_0094: add
    IL_0095: stloc.s 6
    IL_0097: ldloc.s 6
    IL_0099: ldarg.1
    IL_009a: blt.s IL_006c
    IL_009c: br.s IL_00b7
    IL_009e: ldloc.1
    IL_009f: stloc.s 9
    IL_00a1: ldloc.s 9
    IL_00a3: ldc.i4.0
    IL_00a4: ldloc.s 9
    IL_00a6: ldc.i4.0
    IL_00a7: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_00ac: ldc.i4.1
    IL_00ad: add
    IL_00ae: callvirt void System.Collections.Generic.List<int>::set_Item(int,!0)  /*0x0A00030F*/
    IL_00b3: ldloc.3
    IL_00b4: ldc.i4.1
    IL_00b5: add
    IL_00b6: stloc.3
    IL_00b7: ldloc.3
    IL_00b8: ldarg.0
    IL_00b9: blt.s IL_009e
    IL_00bb: ldloc.1
    IL_00bc: ret

  .method WaveGenUtility::.ctor()  // token 0x06000731 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== WaveGenUtility/<>c  (token 0x0200015F) =====
  .method WaveGenUtility.<>c::.cctor()  // token 0x06000732 rva 0x2465d attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void WaveGenUtility.<>c::.ctor()  /*0x06000733*/
    IL_0005: stsfld WaveGenUtility.<>c WaveGenUtility.<>c::<>9  /*0x04000914*/
    IL_000a: ret

  .method WaveGenUtility.<>c::.ctor()  // token 0x06000733 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method WaveGenUtility.<>c::<DistributeEnemies>b__1_0(float,float)  // token 0x06000734 rva 0x24669 attrs Assembly, HideBySig
    // code size 9 (0x9), max stack 8
    IL_0000: ldarga.s 2
    IL_0002: ldarg.1
    IL_0003: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0008: ret

// ===== WaveGenUtility/<>c__DisplayClass0_0`1  (token 0x02000160) =====
  .method WaveGenUtility.<>c__DisplayClass0_0::.ctor()  // token 0x06000735 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method WaveGenUtility.<>c__DisplayClass0_0::<GetRandomElements>b__0(!0)  // token 0x06000736 rva 0x24673 attrs Assembly, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Random WaveGenUtility.<>c__DisplayClass0_0<!0>::random  /*0x0A000360*/
    IL_0006: callvirt int System.Random::Next()  /*0x0A000361*/
    IL_000b: ret

