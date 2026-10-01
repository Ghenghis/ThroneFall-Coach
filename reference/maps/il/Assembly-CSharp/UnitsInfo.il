// ===== UnitsInfo  (token 0x02000393) =====
  .method UnitsInfo::.ctor()  // token 0x060013AC rva 0x5d738 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<UnitInfo>::.ctor()  /*0x0A00077C*/
    IL_0006: stfld List<UnitInfo> UnitsInfo::Units  /*0x040017EB*/
    IL_000b: ldarg.0
    IL_000c: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0011: ret

