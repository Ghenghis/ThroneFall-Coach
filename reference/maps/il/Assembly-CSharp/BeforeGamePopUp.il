// ===== BeforeGamePopUp  (token 0x02000369) =====
  .method BeforeGamePopUp::.ctor()  // token 0x060012C4 rva 0x59318 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BeforeGamePopUp::showInDemoVersion  /*0x04001699*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool BeforeGamePopUp::showInFullVersion  /*0x0400169A*/
    IL_000e: ldarg.0
    IL_000f: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0014: ret

