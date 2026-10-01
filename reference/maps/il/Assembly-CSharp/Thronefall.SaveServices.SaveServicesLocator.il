// ===== Thronefall.SaveServices.SaveServicesLocator  (token 0x02000D1E) =====
  .method Thronefall.SaveServices.SaveServicesLocator::get_Instance()  // token 0x06003DE2 rva 0xa1133 attrs Public, Static, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldsfld ISaveServices Thronefall.SaveServices.SaveServicesLocator::s_Instance  /*0x040033FE*/
    IL_0005: brfalse.s IL_000d
    IL_0007: ldsfld ISaveServices Thronefall.SaveServices.SaveServicesLocator::s_Instance  /*0x040033FE*/
    IL_000c: ret
    IL_000d: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::CreateInstance()  /*0x06003DE3*/
    IL_0012: stsfld ISaveServices Thronefall.SaveServices.SaveServicesLocator::s_Instance  /*0x040033FE*/
    IL_0017: ldsfld ISaveServices Thronefall.SaveServices.SaveServicesLocator::s_Instance  /*0x040033FE*/
    IL_001c: ret

  .method Thronefall.SaveServices.SaveServicesLocator::CreateInstance()  // token 0x06003DE3 rva 0xa1151 attrs Private, Static, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldstr "[SaveServices] Using SteamSaveServices"
    IL_0005: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000a: newobj void Thronefall.SaveServices.SteamSaveServices::.ctor()  /*0x06003DF3*/
    IL_000f: ret

  .method Thronefall.SaveServices.SaveServicesLocator::Reset()  // token 0x06003DE4 rva 0xa1162 attrs Public, Static, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldnull
    IL_0001: stsfld ISaveServices Thronefall.SaveServices.SaveServicesLocator::s_Instance  /*0x040033FE*/
    IL_0006: ret

