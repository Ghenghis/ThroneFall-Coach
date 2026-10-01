// ===== <PrivateImplementationDetails>  (token 0x02000DA1) =====
  .method <PrivateImplementationDetails>::ComputeStringHash(string)  // token 0x060043F8 rva 0xb06b4 attrs Assembly, Static, HideBySig
    // code size 44 (0x2c), max stack 2, init locals
    .locals ([0] uint, [1] int)
    IL_0000: ldarg.0
    IL_0001: brfalse.s IL_002a
    IL_0003: ldc.i4 -2128831035
    IL_0008: stloc.0
    IL_0009: ldc.i4.0
    IL_000a: stloc.1
    IL_000b: br.s IL_0021
    IL_000d: ldarg.0
    IL_000e: ldloc.1
    IL_000f: callvirt char System.String::get_Chars(int)  /*0x0A000146*/
    IL_0014: ldloc.0
    IL_0015: xor
    IL_0016: ldc.i4 16777619
    IL_001b: mul
    IL_001c: stloc.0
    IL_001d: ldloc.1
    IL_001e: ldc.i4.1
    IL_001f: add
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: ldarg.0
    IL_0023: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_0028: blt.s IL_000d
    IL_002a: ldloc.0
    IL_002b: ret

// ===== <PrivateImplementationDetails>/__StaticArrayInitTypeSize=16  (token 0x02000DA2) =====
// ===== <PrivateImplementationDetails>/__StaticArrayInitTypeSize=24  (token 0x02000DA3) =====
// ===== <PrivateImplementationDetails>/__StaticArrayInitTypeSize=143398  (token 0x02000DA4) =====
// ===== <PrivateImplementationDetails>/__StaticArrayInitTypeSize=152956  (token 0x02000DA5) =====
