// ===== RandomizeExtensionsForLists  (token 0x02000148) =====
  .method RandomizeExtensionsForLists::ETShuffle(System.Collections.Generic.IList<!!0>,System.Random)  // token 0x06000702 rva 0x1f20c attrs Public, Static, HideBySig
    // code size 58 (0x3a), max stack 4, init locals
    .locals ([0] int, [1] int, [2] !!0)
    IL_0000: ldarg.0
    IL_0001: callvirt int System.Collections.Generic.ICollection<!!0>::get_Count()  /*0x0A0002F5*/
    IL_0006: stloc.0
    IL_0007: br.s IL_0035
    IL_0009: ldloc.0
    IL_000a: ldc.i4.1
    IL_000b: sub
    IL_000c: stloc.0
    IL_000d: ldarg.1
    IL_000e: ldloc.0
    IL_000f: ldc.i4.1
    IL_0010: add
    IL_0011: callvirt int System.Random::Next(int)  /*0x0A0002F6*/
    IL_0016: stloc.1
    IL_0017: ldarg.0
    IL_0018: ldloc.1
    IL_0019: callvirt !0 System.Collections.Generic.IList<!!0>::get_Item(int)  /*0x0A0002F7*/
    IL_001e: stloc.2
    IL_001f: ldarg.0
    IL_0020: ldloc.1
    IL_0021: ldarg.0
    IL_0022: ldloc.0
    IL_0023: callvirt !0 System.Collections.Generic.IList<!!0>::get_Item(int)  /*0x0A0002F7*/
    IL_0028: callvirt void System.Collections.Generic.IList<!!0>::set_Item(int,!0)  /*0x0A0002F8*/
    IL_002d: ldarg.0
    IL_002e: ldloc.0
    IL_002f: ldloc.2
    IL_0030: callvirt void System.Collections.Generic.IList<!!0>::set_Item(int,!0)  /*0x0A0002F8*/
    IL_0035: ldloc.0
    IL_0036: ldc.i4.1
    IL_0037: bgt.s IL_0009
    IL_0039: ret

