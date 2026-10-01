// ===== EquippableMutation  (token 0x02000219) =====
  .method EquippableMutation::.ctor()  // token 0x06000B5C rva 0x36451 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.2f
    IL_0006: stfld float EquippableMutation::scoreMultiplyerOnWin  /*0x04000E43*/
    IL_000b: ldarg.0
    IL_000c: call void Equippable::.ctor()  /*0x06000B58*/
    IL_0011: ret

