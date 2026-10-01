// ===== Thronefall.GameServices.SteamGameServices  (token 0x02000D23) =====
  .method Thronefall.GameServices.SteamGameServices::get_Initialized()  // token 0x06003E02 rva 0xa123b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: call bool SteamManager::get_Initialized()  /*0x060007B6*/
    IL_0005: ret

  .method Thronefall.GameServices.SteamGameServices::get_LastDownloadedLeaderboardEntries()  // token 0x06003E03 rva 0xa1242 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_0005: ldfld List<LeaderboardEntry> SteamManager::lastDownloadedLeaderboardEntires  /*0x040009A6*/
    IL_000a: ret

  .method Thronefall.GameServices.SteamGameServices::get_OnLeaderboardDownloadComplete()  // token 0x06003E04 rva 0xa124e attrs Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_0005: ldfld UnityEvent SteamManager::OnLeaderboardDownloadCallbackComplete  /*0x040009A7*/
    IL_000a: ret

  .method Thronefall.GameServices.SteamGameServices::get_OnLeaderboardError()  // token 0x06003E05 rva 0xa125a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_0005: ldfld UnityEvent SteamManager::OnLeaderboardError  /*0x040009A8*/
    IL_000a: ret

  .method Thronefall.GameServices.SteamGameServices::GetPersonaName()  // token 0x06003E06 rva 0xa1266 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldstr ""
    IL_000d: ret
    IL_000e: call string Steamworks.SteamFriends::GetPersonaName()  /*0x0A000BE3*/
    IL_0013: ret

  .method Thronefall.GameServices.SteamGameServices::DownloadFriendsHighscores(string)  // token 0x06003E07 rva 0xa127b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_000e: ldarg.1
    IL_000f: callvirt void SteamManager::DownloadFriendsHighscores(string)  /*0x060007BF*/
    IL_0014: ret

  .method Thronefall.GameServices.SteamGameServices::UploadHighscore(int,string)  // token 0x06003E08 rva 0xa1291 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_000e: ldarg.1
    IL_000f: ldarg.2
    IL_0010: callvirt void SteamManager::UploadHighscore(int,string)  /*0x060007BD*/
    IL_0015: ret

  .method Thronefall.GameServices.SteamGameServices::SetAchievement(string)  // token 0x06003E09 rva 0xa12a8 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: call bool Steamworks.SteamUserStats::SetAchievement(string)  /*0x0A000BE4*/
    IL_000f: pop
    IL_0010: ret

  .method Thronefall.GameServices.SteamGameServices::ClearAchievement(string)  // token 0x06003E0A rva 0xa12ba attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: call bool Steamworks.SteamUserStats::ClearAchievement(string)  /*0x0A000BE5*/
    IL_000f: pop
    IL_0010: ret

  .method Thronefall.GameServices.SteamGameServices::StoreStats()  // token 0x06003E0B rva 0xa12cc attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: call bool Steamworks.SteamUserStats::StoreStats()  /*0x0A000BE6*/
    IL_000e: pop
    IL_000f: ret

  .method Thronefall.GameServices.SteamGameServices::IsRunningOnSteamDeck()  // token 0x06003E0C rva 0xa12dd attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool Thronefall.GameServices.SteamGameServices::get_Initialized()  /*0x06003E02*/
    IL_0006: brtrue.s IL_000a
    IL_0008: ldc.i4.0
    IL_0009: ret
    IL_000a: call bool Steamworks.SteamUtils::IsSteamRunningOnSteamDeck()  /*0x0A000BE7*/
    IL_000f: ret

  .method Thronefall.GameServices.SteamGameServices::.ctor()  // token 0x06003E0D rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

