// ===== CheatCategory  (token 0x020002DA) =====
  .method CheatCategory::.ctor()  // token 0x06000FC4 rva 0x47f30 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<CheatEntry>::.ctor()  /*0x0A00060D*/
    IL_0006: stfld List<CheatEntry> CheatCategory::Cheats  /*0x0400128C*/
    IL_000b: ldarg.0
    IL_000c: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0011: ret

