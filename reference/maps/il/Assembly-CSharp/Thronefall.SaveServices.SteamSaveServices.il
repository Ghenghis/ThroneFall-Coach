// ===== Thronefall.SaveServices.SteamSaveServices  (token 0x02000D1F) =====
  .method Thronefall.SaveServices.SteamSaveServices::Initialize()  // token 0x06003DE5 rva 0xa116a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool Thronefall.SaveServices.SteamSaveServices::mbInitialized  /*0x040033FF*/
    IL_0007: ret

  .method Thronefall.SaveServices.SteamSaveServices::Shutdown()  // token 0x06003DE6 rva 0xa1173 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool Thronefall.SaveServices.SteamSaveServices::mbInitialized  /*0x040033FF*/
    IL_0007: ret

  .method Thronefall.SaveServices.SteamSaveServices::Update()  // token 0x06003DE7 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Thronefall.SaveServices.SteamSaveServices::get_Initialized()  // token 0x06003DE8 rva 0xa117c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Thronefall.SaveServices.SteamSaveServices::mbInitialized  /*0x040033FF*/
    IL_0006: ret

  .method Thronefall.SaveServices.SteamSaveServices::Exists(string)  // token 0x06003DE9 rva 0xa1184 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.SaveServices.SteamSaveServices::get_Initialized()  /*0x06003DE8*/
    IL_0006: brtrue.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: ldarg.1
    IL_000b: call bool System.IO.File::Exists(string)  /*0x0A00052A*/
    IL_0010: ret

  .method Thronefall.SaveServices.SteamSaveServices::WriteAllLines(string,string[])  // token 0x06003DEA rva 0xa1196 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.SaveServices.SteamSaveServices::get_Initialized()  /*0x06003DE8*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldarg.2
    IL_000b: call void System.IO.File::WriteAllLines(string,string[])  /*0x0A000BE0*/
    IL_0010: ret

  .method Thronefall.SaveServices.SteamSaveServices::WriteAllLinesSafe(string,System.Collections.Generic.IEnumerable<string>)  // token 0x06003DEB rva 0xa11a8 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.2
    IL_0002: call void SafeFileWriter::FileWriteAllLinesSafe(string,System.Collections.Generic.IEnumerable<string>)  /*0x06000CCB*/
    IL_0007: ret

  .method Thronefall.SaveServices.SteamSaveServices::WriteAllText(string,string)  // token 0x06003DEC rva 0xa11b1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.SaveServices.SteamSaveServices::get_Initialized()  /*0x06003DE8*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldarg.2
    IL_000b: call void System.IO.File::WriteAllText(string,string)  /*0x0A000BE1*/
    IL_0010: ret

  .method Thronefall.SaveServices.SteamSaveServices::ReadAllLines(string)  // token 0x06003DED rva 0xa11c3 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.SaveServices.SteamSaveServices::get_Initialized()  /*0x06003DE8*/
    IL_0006: brtrue.s IL_000e
    IL_0008: call !!0[] System.Array::Empty()<string>  /*0x2B000173*/
    IL_000d: ret
    IL_000e: ldarg.1
    IL_000f: call string[] System.IO.File::ReadAllLines(string)  /*0x0A00052B*/
    IL_0014: ret

  .method Thronefall.SaveServices.SteamSaveServices::ReadAllLinesSafe(string)  // token 0x06003DEE rva 0xa11d9 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: call string[] SafeFileWriter::FileReadAllLinesSafe(string)  /*0x06000CCC*/
    IL_0006: ret

  .method Thronefall.SaveServices.SteamSaveServices::ReadAllText(string)  // token 0x06003DEF rva 0xa11e1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.SaveServices.SteamSaveServices::get_Initialized()  /*0x06003DE8*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldsfld string System.String::Empty  /*0x0A00092A*/
    IL_000d: ret
    IL_000e: ldarg.1
    IL_000f: call string System.IO.File::ReadAllText(string)  /*0x0A000BE2*/
    IL_0014: ret

  .method Thronefall.SaveServices.SteamSaveServices::SavePlayerPrefs()  // token 0x06003DF0 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Thronefall.SaveServices.SteamSaveServices::RestorePlayerPrefs()  // token 0x06003DF1 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Thronefall.SaveServices.SteamSaveServices::GetFullSavePath(string)  // token 0x06003DF2 rva 0xa11f7 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 12 (0xc), max stack 8
    IL_0000: call string UnityEngine.Application::get_persistentDataPath()  /*0x0A00058C*/
    IL_0005: ldarg.1
    IL_0006: call string System.IO.Path::Combine(string,string)  /*0x0A000521*/
    IL_000b: ret

  .method Thronefall.SaveServices.SteamSaveServices::.ctor()  // token 0x06003DF3 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

