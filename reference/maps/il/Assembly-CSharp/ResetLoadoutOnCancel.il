// ===== ResetLoadoutOnCancel  (token 0x02000339) =====
  .method ResetLoadoutOnCancel::OnShow()  // token 0x060011A4 rva 0x557c7 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool ResetLoadoutOnCancel::loadoutLockedIn  /*0x0400155C*/
    IL_0007: ret

  .method ResetLoadoutOnCancel::OnDeactivate()  // token 0x060011A5 rva 0x557d0 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ResetLoadoutOnCancel::loadoutLockedIn  /*0x0400155C*/
    IL_0006: brtrue.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld LoadoutUIHelper ResetLoadoutOnCancel::loadoutHelper  /*0x0400155B*/
    IL_000e: callvirt void LoadoutUIHelper::ResetToBufferedLoadout()  /*0x06001144*/
    IL_0013: ret

  .method ResetLoadoutOnCancel::LockInLoadout()  // token 0x060011A6 rva 0x557e5 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ResetLoadoutOnCancel::loadoutLockedIn  /*0x0400155C*/
    IL_0007: ret

  .method ResetLoadoutOnCancel::.ctor()  // token 0x060011A7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

