// ===== AllowUpgrade  (token 0x0200011F) =====
  .method AllowUpgrade::Start()  // token 0x060005E0 rva 0x19144 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot AllowUpgrade::buildSlot  /*0x04000754*/
    IL_0006: ldc.i4.s -100
    IL_0008: callvirt void BuildSlot::SetRequiredRootLevelDifference(int)  /*0x060002C7*/
    IL_000d: ret

  .method AllowUpgrade::.ctor()  // token 0x060005E1 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

