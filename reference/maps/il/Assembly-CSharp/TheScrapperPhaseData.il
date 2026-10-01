// ===== TheScrapperPhaseData  (token 0x020000EE) =====
  .method TheScrapperPhaseData::get_IsValid()  // token 0x06000511 rva 0x164ae attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon TheScrapperPhaseData::weapon  /*0x04000692*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: ret

  .method TheScrapperPhaseData::.ctor()  // token 0x06000512 rva 0x164bc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 50f
    IL_0006: stfld float TheScrapperPhaseData::hpGrowthAddition  /*0x04000693*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 15f
    IL_0011: stfld float TheScrapperPhaseData::destroyedEnemiesDetectionRadius  /*0x04000696*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_001c: ret

