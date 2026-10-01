// ===== SteamDlcProvider  (token 0x020000BA) =====
  .method SteamDlcProvider::IsDlcAvailable(IDlcProvider.DlcId)  // token 0x060003ED rva 0x11270 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 48 (0x30), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: call bool SteamManager::get_Initialized()  /*0x060007B6*/
    IL_0005: brtrue.s IL_0009
    IL_0007: ldc.i4.0
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: brfalse.s IL_0012
    IL_000c: ldarg.1
    IL_000d: ldc.i4.1
    IL_000e: beq.s IL_001f
    IL_0010: br.s IL_002c
    IL_0012: ldsfld AppId_t SteamDlcProvider::CRAAGHELM_STEAM_ID  /*0x0400050D*/
    IL_0017: call bool Steamworks.SteamApps::BIsDlcInstalled(Steamworks.AppId_t)  /*0x0A0001B8*/
    IL_001c: stloc.0
    IL_001d: br.s IL_002e
    IL_001f: ldsfld AppId_t SteamDlcProvider::FANGMOOR_STEAM_ID  /*0x0400050E*/
    IL_0024: call bool Steamworks.SteamApps::BIsDlcInstalled(Steamworks.AppId_t)  /*0x0A0001B8*/
    IL_0029: stloc.0
    IL_002a: br.s IL_002e
    IL_002c: ldc.i4.0
    IL_002d: stloc.0
    IL_002e: ldloc.0
    IL_002f: ret

  .method SteamDlcProvider::.ctor()  // token 0x060003EE rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method SteamDlcProvider::.cctor()  // token 0x060003EF rva 0x112ac attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldsfld AppId_t Steamworks.AppId_t::Invalid  /*0x0A0001B9*/
    IL_0005: stsfld AppId_t SteamDlcProvider::CRAAGHELM_STEAM_ID  /*0x0400050D*/
    IL_000a: ldsfld AppId_t Steamworks.AppId_t::Invalid  /*0x0A0001B9*/
    IL_000f: stsfld AppId_t SteamDlcProvider::FANGMOOR_STEAM_ID  /*0x0400050E*/
    IL_0014: ret

