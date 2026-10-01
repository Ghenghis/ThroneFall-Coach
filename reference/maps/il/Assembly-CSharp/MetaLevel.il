// ===== MetaLevel  (token 0x020001DB) =====
  .method MetaLevel::.ctor(int,Equippable)  // token 0x060009AB rva 0x2d3ab attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MetaLevel::requiredXp  /*0x04000C5E*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0014: ret

