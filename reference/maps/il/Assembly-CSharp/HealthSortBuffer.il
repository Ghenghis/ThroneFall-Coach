// ===== HealthSortBuffer  (token 0x020002A0) =====
  .method HealthSortBuffer::Allocate(int)  // token 0x06000E81 rva 0x41154 attrs Public, Static, HideBySig
    // code size 92 (0x5c), max stack 4, init locals
    IL_0000: ldsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_0005: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_000a: callvirt int System.Collections.Generic.List<HealthEntry[]>::get_Count()  /*0x0A0005D2*/
    IL_000f: bge.s IL_004e
    IL_0011: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_0016: ldsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_001b: callvirt !0 System.Collections.Generic.List<HealthEntry[]>::get_Item(int)  /*0x0A0005D3*/
    IL_0020: brfalse.s IL_004e
    IL_0022: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_0027: ldsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_002c: callvirt !0 System.Collections.Generic.List<HealthEntry[]>::get_Item(int)  /*0x0A0005D3*/
    IL_0031: ldlen
    IL_0032: conv.i4
    IL_0033: ldarg.0
    IL_0034: blt.s IL_004e
    IL_0036: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_003b: ldsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_0040: dup
    IL_0041: ldc.i4.1
    IL_0042: add
    IL_0043: stsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_0048: callvirt !0 System.Collections.Generic.List<HealthEntry[]>::get_Item(int)  /*0x0A0005D3*/
    IL_004d: ret
    IL_004e: ldarg.0
    IL_004f: ldc.i4.s 16
    IL_0051: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0056: newarr HealthEntry  /*0x0200029F*/
    IL_005b: ret

  .method HealthSortBuffer::Free(HealthEntry[],int)  // token 0x06000E82 rva 0x411bc attrs Public, Static, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_0005: callvirt int System.Collections.Generic.List<HealthEntry[]>::get_Count()  /*0x0A0005D2*/
    IL_000a: ldc.i4.s 32
    IL_000c: bge.s IL_0020
    IL_000e: ldarg.0
    IL_000f: ldlen
    IL_0010: conv.i4
    IL_0011: ldc.i4.s 16
    IL_0013: blt.s IL_0020
    IL_0015: ldsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_001a: ldarg.0
    IL_001b: callvirt void System.Collections.Generic.List<HealthEntry[]>::Add(!0)  /*0x0A0005D4*/
    IL_0020: ret

  .method HealthSortBuffer::SortDesc(HealthEntry[],int)  // token 0x06000E83 rva 0x411de attrs Public, Static, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: ldarg.1
    IL_0003: ldsfld HealthSortBuffer.DescComparer HealthSortBuffer.DescComparer::Instance  /*0x040010DB*/
    IL_0008: call void System.Array::Sort(!!0[],int,int,System.Collections.Generic.IComparer<!!0>)<HealthEntry>  /*0x2B0000CF*/
    IL_000d: ret

  .method HealthSortBuffer::SortAsc(HealthEntry[],int)  // token 0x06000E84 rva 0x411ed attrs Public, Static, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: ldarg.1
    IL_0003: ldsfld HealthSortBuffer.AscComparer HealthSortBuffer.AscComparer::Instance  /*0x040010DC*/
    IL_0008: call void System.Array::Sort(!!0[],int,int,System.Collections.Generic.IComparer<!!0>)<HealthEntry>  /*0x2B0000CF*/
    IL_000d: ret

  .method HealthSortBuffer::.cctor()  // token 0x06000E85 rva 0x411fc attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<HealthEntry[]>::.ctor()  /*0x0A0005D5*/
    IL_0005: stsfld List<HealthEntry[]> HealthSortBuffer::Pool  /*0x040010D9*/
    IL_000a: ldc.i4.0
    IL_000b: stsfld int HealthSortBuffer::_idx  /*0x040010DA*/
    IL_0010: ret

// ===== HealthSortBuffer/DescComparer  (token 0x020002A1) =====
  .method HealthSortBuffer.DescComparer::Compare(HealthEntry,HealthEntry)  // token 0x06000E86 rva 0x4120e attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 19 (0x13), max stack 8
    IL_0000: ldarga.s 2
    IL_0002: ldflda float HealthEntry::value  /*0x040010D8*/
    IL_0007: ldarg.1
    IL_0008: ldfld float HealthEntry::value  /*0x040010D8*/
    IL_000d: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0012: ret

  .method HealthSortBuffer.DescComparer::.ctor()  // token 0x06000E87 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method HealthSortBuffer.DescComparer::.cctor()  // token 0x06000E88 rva 0x41222 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void HealthSortBuffer.DescComparer::.ctor()  /*0x06000E87*/
    IL_0005: stsfld HealthSortBuffer.DescComparer HealthSortBuffer.DescComparer::Instance  /*0x040010DB*/
    IL_000a: ret

// ===== HealthSortBuffer/AscComparer  (token 0x020002A2) =====
  .method HealthSortBuffer.AscComparer::Compare(HealthEntry,HealthEntry)  // token 0x06000E89 rva 0x4122e attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 19 (0x13), max stack 8
    IL_0000: ldarga.s 1
    IL_0002: ldflda float HealthEntry::value  /*0x040010D8*/
    IL_0007: ldarg.2
    IL_0008: ldfld float HealthEntry::value  /*0x040010D8*/
    IL_000d: call int System.Single::CompareTo(float)  /*0x0A000276*/
    IL_0012: ret

  .method HealthSortBuffer.AscComparer::.ctor()  // token 0x06000E8A rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method HealthSortBuffer.AscComparer::.cctor()  // token 0x06000E8B rva 0x41242 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void HealthSortBuffer.AscComparer::.ctor()  /*0x06000E8A*/
    IL_0005: stsfld HealthSortBuffer.AscComparer HealthSortBuffer.AscComparer::Instance  /*0x040010DC*/
    IL_000a: ret

