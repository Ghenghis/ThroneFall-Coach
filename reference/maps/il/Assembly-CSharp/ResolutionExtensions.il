// ===== ResolutionExtensions  (token 0x02000282) =====
  .method ResolutionExtensions::CompareResolutions(UnityEngine.Resolution,UnityEngine.Resolution)  // token 0x06000DE2 rva 0x3e87c attrs Public, Static, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarga.s 0
    IL_0002: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_0007: ldarga.s 1
    IL_0009: call int UnityEngine.Resolution::get_width()  /*0x0A00059B*/
    IL_000e: bne.un.s IL_0021
    IL_0010: ldarga.s 0
    IL_0012: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_0017: ldarga.s 1
    IL_0019: call int UnityEngine.Resolution::get_height()  /*0x0A00059C*/
    IL_001e: ceq
    IL_0020: ret
    IL_0021: ldc.i4.0
    IL_0022: ret

