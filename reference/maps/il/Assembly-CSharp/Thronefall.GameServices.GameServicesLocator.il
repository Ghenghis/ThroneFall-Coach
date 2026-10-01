// ===== Thronefall.GameServices.GameServicesLocator  (token 0x02000D20) =====
  .method Thronefall.GameServices.GameServicesLocator::get_Instance()  // token 0x06003DF4 rva 0xa1204 attrs Public, Static, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldsfld IGameServices Thronefall.GameServices.GameServicesLocator::s_Instance  /*0x04003400*/
    IL_0005: brfalse.s IL_000d
    IL_0007: ldsfld IGameServices Thronefall.GameServices.GameServicesLocator::s_Instance  /*0x04003400*/
    IL_000c: ret
    IL_000d: call IGameServices Thronefall.GameServices.GameServicesLocator::CreateInstance()  /*0x06003DF5*/
    IL_0012: stsfld IGameServices Thronefall.GameServices.GameServicesLocator::s_Instance  /*0x04003400*/
    IL_0017: ldsfld IGameServices Thronefall.GameServices.GameServicesLocator::s_Instance  /*0x04003400*/
    IL_001c: ret

  .method Thronefall.GameServices.GameServicesLocator::CreateInstance()  // token 0x06003DF5 rva 0xa1222 attrs Private, Static, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldstr "[GameServices] Using SteamGameServices"
    IL_0005: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000a: newobj void Thronefall.GameServices.SteamGameServices::.ctor()  /*0x06003E0D*/
    IL_000f: ret

  .method Thronefall.GameServices.GameServicesLocator::Reset()  // token 0x06003DF6 rva 0xa1233 attrs Public, Static, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldnull
    IL_0001: stsfld IGameServices Thronefall.GameServices.GameServicesLocator::s_Instance  /*0x04003400*/
    IL_0006: ret

