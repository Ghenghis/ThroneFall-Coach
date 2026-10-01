// ===== HpCrystalDragon  (token 0x020000DA) =====
  .method HpCrystalDragon::get_CurrentPhase()  // token 0x06000498 rva 0x1471e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CrystalDragonPhasing.CrystalDragonPhase HpCrystalDragon::currentPhase  /*0x040005EB*/
    IL_0006: ret

  .method HpCrystalDragon::SetCurrentPhase(CrystalDragonPhasing.CrystalDragonPhase)  // token 0x06000499 rva 0x14726 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld CrystalDragonPhasing.CrystalDragonPhase HpCrystalDragon::currentPhase  /*0x040005EB*/
    IL_0007: ret

  .method HpCrystalDragon::.ctor()  // token 0x0600049A rva 0x1472f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Hp::.ctor()  /*0x06000837*/
    IL_0006: ret

