// ===== SteamManager  (token 0x02000181) =====
  .method SteamManager::get_Instance()  // token 0x060007B5 rva 0x25ebb attrs Public, Static, HideBySig, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_001d
    IL_000d: ldstr "SteamManager"
    IL_0012: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000D1*/
    IL_0017: call !!0 UnityEngine.GameObject::AddComponent()<SteamManager>  /*0x2B000088*/
    IL_001c: ret
    IL_001d: ldsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0022: ret

  .method SteamManager::get_Initialized()  // token 0x060007B6 rva 0x25edf attrs Public, Static, HideBySig, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call SteamManager SteamManager::get_Instance()  /*0x060007B5*/
    IL_0005: ldfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_000a: ret

  .method SteamManager::SteamAPIDebugTextHook(int,System.Text.StringBuilder)  // token 0x060007B7 rva 0x25eeb attrs Family, Static, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0006: ret

  .method SteamManager::InitOnPlayMode()  // token 0x060007B8 rva 0x25ef3 attrs Private, Static, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: stsfld bool SteamManager::s_EverInitialized  /*0x0400099F*/
    IL_0006: ldnull
    IL_0007: stsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_000c: ret

  .method SteamManager::Awake()  // token 0x060007B9 rva 0x25f04 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 219 (0xdb), max stack 3, init locals
    .locals ([0] DllNotFoundException)
    IL_0000: ldsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_001f: ldc.i4.m1
    IL_0020: stsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0025: ldsfld bool SteamManager::s_EverInitialized  /*0x0400099F*/
    IL_002a: brfalse.s IL_0037
    IL_002c: ldstr "Tried to Initialize the SteamAPI twice in one session!"
    IL_0031: newobj void System.Exception::.ctor(string)  /*0x0A000386*/
    IL_0036: throw
    IL_0037: ldarg.0
    IL_0038: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003d: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_0042: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0047: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_004c: call bool Steamworks.Packsize::Test()  /*0x0A000387*/
    IL_0051: brtrue.s IL_005e
    IL_0053: ldstr "[Steamworks.NET] Packsize Test returned false, the wrong version of Steamworks.NET is being run in this platform."
    IL_0058: ldarg.0
    IL_0059: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_005e: call bool Steamworks.DllCheck::Test()  /*0x0A000389*/
    IL_0063: brtrue.s IL_0070
    IL_0065: ldstr "[Steamworks.NET] DllCheck Test returned false, One or more of the Steamworks binaries seems to be the wrong version."
    IL_006a: ldarg.0
    IL_006b: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_0070: nop
    IL_0071: ldsfld AppId_t Steamworks.AppId_t::Invalid  /*0x0A0001B9*/
    IL_0076: call bool Steamworks.SteamAPI::RestartAppIfNecessary(Steamworks.AppId_t)  /*0x0A00038A*/
    IL_007b: brfalse.s IL_008e
    IL_007d: ldstr "[Steamworks.NET] Shutting down because RestartAppIfNecessary returned true. Steam will restart the application."
    IL_0082: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0087: call void UnityEngine.Application::Quit()  /*0x0A00038B*/
    IL_008c: leave.s IL_00da
    IL_008e: leave.s IL_00b5
    IL_0090: stloc.0
    IL_0091: ldstr "[Steamworks.NET] Could not load [lib]steam_api.dll/so/dylib. It's likely not in the correct location. Refer to the README for more details.\n"
    IL_0096: ldloc.0
    IL_0097: dup
    IL_0098: brtrue.s IL_009e
    IL_009a: pop
    IL_009b: ldnull
    IL_009c: br.s IL_00a3
    IL_009e: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_00a3: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a8: ldarg.0
    IL_00a9: call void UnityEngine.Debug::Log(object,UnityEngine.Object)  /*0x0A00038C*/
    IL_00ae: call void UnityEngine.Application::Quit()  /*0x0A00038B*/
    IL_00b3: leave.s IL_00da
    IL_00b5: ldarg.0
    IL_00b6: call bool Steamworks.SteamAPI::Init()  /*0x0A00038D*/
    IL_00bb: stfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_00c6: brtrue.s IL_00d4
    IL_00c8: ldstr "[Steamworks.NET] SteamAPI_Init() failed. This is likely the case because the Steam client is not running."
    IL_00cd: ldarg.0
    IL_00ce: call void UnityEngine.Debug::Log(object,UnityEngine.Object)  /*0x0A00038C*/
    IL_00d3: ret
    IL_00d4: ldc.i4.1
    IL_00d5: stsfld bool SteamManager::s_EverInitialized  /*0x0400099F*/
    IL_00da: ret
    .try IL_0071-IL_0090 catch System.DllNotFoundException handler IL_0090-IL_00b5

  .method SteamManager::OnEnable()  // token 0x060007BA rva 0x25ffc attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 66 (0x42), max stack 3, init locals
    IL_0000: ldsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldarg.0
    IL_000e: stsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0013: ldarg.0
    IL_0014: ldfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_0019: brtrue.s IL_001c
    IL_001b: ret
    IL_001c: ldarg.0
    IL_001d: ldfld SteamAPIWarningMessageHook_t SteamManager::m_SteamAPIWarningMessageHook  /*0x040009A2*/
    IL_0022: brtrue.s IL_0041
    IL_0024: ldarg.0
    IL_0025: ldnull
    IL_0026: ldftn void SteamManager::SteamAPIDebugTextHook(int,System.Text.StringBuilder)  /*0x060007B7*/
    IL_002c: newobj void Steamworks.SteamAPIWarningMessageHook_t::.ctor(object,IntPtr)  /*0x0A00038E*/
    IL_0031: stfld SteamAPIWarningMessageHook_t SteamManager::m_SteamAPIWarningMessageHook  /*0x040009A2*/
    IL_0036: ldarg.0
    IL_0037: ldfld SteamAPIWarningMessageHook_t SteamManager::m_SteamAPIWarningMessageHook  /*0x040009A2*/
    IL_003c: call void Steamworks.SteamClient::SetWarningMessageHook(Steamworks.SteamAPIWarningMessageHook_t)  /*0x0A00038F*/
    IL_0041: ret

  .method SteamManager::OnDestroy()  // token 0x060007BB rva 0x2604a attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 35 (0x23), max stack 8
    IL_0000: ldsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0005: ldarg.0
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: ldnull
    IL_000f: stsfld SteamManager SteamManager::s_instance  /*0x040009A0*/
    IL_0014: ldarg.0
    IL_0015: ldfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_001a: brtrue.s IL_001d
    IL_001c: ret
    IL_001d: call void Steamworks.SteamAPI::Shutdown()  /*0x0A000390*/
    IL_0022: ret

  .method SteamManager::Update()  // token 0x060007BC rva 0x2606e attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SteamManager::m_bInitialized  /*0x040009A1*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: call void Steamworks.SteamAPI::RunCallbacks()  /*0x0A000391*/
    IL_000e: ret

  .method SteamManager::UploadHighscore(int,string)  // token 0x060007BD rva 0x26080 attrs Public, HideBySig
    // code size 66 (0x42), max stack 4, init locals
    .locals ([0] SteamAPICall_t)
    IL_0000: call bool SteamManager::get_Initialized()  /*0x060007B6*/
    IL_0005: brtrue.s IL_0008
    IL_0007: ret
    IL_0008: ldsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_000d: ldc.i4.m1
    IL_000e: beq.s IL_001b
    IL_0010: ldstr "You can't upload multiple scores symultaneously with the current system."
    IL_0015: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_001a: ret
    IL_001b: ldarg.1
    IL_001c: stsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0021: ldarg.2
    IL_0022: ldc.i4.2
    IL_0023: ldc.i4.1
    IL_0024: call SteamAPICall_t Steamworks.SteamUserStats::FindOrCreateLeaderboard(string,Steamworks.ELeaderboardSortMethod,Steamworks.ELeaderboardDisplayType)  /*0x0A000392*/
    IL_0029: stloc.0
    IL_002a: ldsfld CallResult<LeaderboardFindResult_t> SteamManager::_findLeaderboardCallback  /*0x040009A3*/
    IL_002f: ldloc.0
    IL_0030: ldarg.0
    IL_0031: ldftn void SteamManager::OnFindLeaderboardForUploadingScore(Steamworks.LeaderboardFindResult_t,bool)  /*0x060007BE*/
    IL_0037: newobj void Steamworks.CallResult.APIDispatchDelegate<Steamworks.LeaderboardFindResult_t>::.ctor(object,IntPtr)  /*0x0A000393*/
    IL_003c: callvirt void Steamworks.CallResult<Steamworks.LeaderboardFindResult_t>::Set(Steamworks.SteamAPICall_t,Steamworks.CallResult.APIDispatchDelegate<!0>)  /*0x0A000394*/
    IL_0041: ret

  .method SteamManager::OnFindLeaderboardForUploadingScore(Steamworks.LeaderboardFindResult_t,bool)  // token 0x060007BE rva 0x260ce attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.2
    IL_0001: brfalse.s IL_000a
    IL_0003: ldc.i4.m1
    IL_0004: stsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0009: ret
    IL_000a: ldarg.1
    IL_000b: ldfld SteamLeaderboard_t Steamworks.LeaderboardFindResult_t::m_hSteamLeaderboard  /*0x0A000395*/
    IL_0010: ldc.i4.1
    IL_0011: ldsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0016: ldc.i4.0
    IL_0017: newarr System.Int32  /*0x01000026*/
    IL_001c: ldc.i4.0
    IL_001d: call SteamAPICall_t Steamworks.SteamUserStats::UploadLeaderboardScore(Steamworks.SteamLeaderboard_t,Steamworks.ELeaderboardUploadScoreMethod,int,int[],int)  /*0x0A000396*/
    IL_0022: pop
    IL_0023: ldc.i4.m1
    IL_0024: stsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0029: ret

  .method SteamManager::DownloadFriendsHighscores(string)  // token 0x060007BF rva 0x260fc attrs Public, HideBySig
    // code size 50 (0x32), max stack 4, init locals
    .locals ([0] SteamAPICall_t)
    IL_0000: ldarg.0
    IL_0001: ldfld List<LeaderboardEntry> SteamManager::lastDownloadedLeaderboardEntires  /*0x040009A6*/
    IL_0006: callvirt void System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::Clear()  /*0x0A000397*/
    IL_000b: call bool SteamManager::get_Initialized()  /*0x060007B6*/
    IL_0010: brtrue.s IL_0013
    IL_0012: ret
    IL_0013: ldarg.1
    IL_0014: call SteamAPICall_t Steamworks.SteamUserStats::FindLeaderboard(string)  /*0x0A000398*/
    IL_0019: stloc.0
    IL_001a: ldsfld CallResult<LeaderboardFindResult_t> SteamManager::_findLeaderboardCallback  /*0x040009A3*/
    IL_001f: ldloc.0
    IL_0020: ldarg.0
    IL_0021: ldftn void SteamManager::OnFindLeaderboardFodDownloadingFriendsScore(Steamworks.LeaderboardFindResult_t,bool)  /*0x060007C0*/
    IL_0027: newobj void Steamworks.CallResult.APIDispatchDelegate<Steamworks.LeaderboardFindResult_t>::.ctor(object,IntPtr)  /*0x0A000393*/
    IL_002c: callvirt void Steamworks.CallResult<Steamworks.LeaderboardFindResult_t>::Set(Steamworks.SteamAPICall_t,Steamworks.CallResult.APIDispatchDelegate<!0>)  /*0x0A000394*/
    IL_0031: ret

  .method SteamManager::OnFindLeaderboardFodDownloadingFriendsScore(Steamworks.LeaderboardFindResult_t,bool)  // token 0x060007C0 rva 0x2613c attrs Public, HideBySig
    // code size 44 (0x2c), max stack 4, init locals
    .locals ([0] SteamAPICall_t)
    IL_0000: ldarg.2
    IL_0001: brfalse.s IL_0004
    IL_0003: ret
    IL_0004: ldarg.1
    IL_0005: ldfld SteamLeaderboard_t Steamworks.LeaderboardFindResult_t::m_hSteamLeaderboard  /*0x0A000395*/
    IL_000a: ldc.i4.2
    IL_000b: ldc.i4.1
    IL_000c: ldc.i4.s 100
    IL_000e: call SteamAPICall_t Steamworks.SteamUserStats::DownloadLeaderboardEntries(Steamworks.SteamLeaderboard_t,Steamworks.ELeaderboardDataRequest,int,int)  /*0x0A000399*/
    IL_0013: stloc.0
    IL_0014: ldsfld CallResult<LeaderboardScoresDownloaded_t> SteamManager::_downloadedScoresCallback  /*0x040009A5*/
    IL_0019: ldloc.0
    IL_001a: ldarg.0
    IL_001b: ldftn void SteamManager::OnDownloadedScores(Steamworks.LeaderboardScoresDownloaded_t,bool)  /*0x060007C1*/
    IL_0021: newobj void Steamworks.CallResult.APIDispatchDelegate<Steamworks.LeaderboardScoresDownloaded_t>::.ctor(object,IntPtr)  /*0x0A00039A*/
    IL_0026: callvirt void Steamworks.CallResult<Steamworks.LeaderboardScoresDownloaded_t>::Set(Steamworks.SteamAPICall_t,Steamworks.CallResult.APIDispatchDelegate<!0>)  /*0x0A00039B*/
    IL_002b: ret

  .method SteamManager::OnDownloadedScores(Steamworks.LeaderboardScoresDownloaded_t,bool)  // token 0x060007C1 rva 0x26174 attrs Public, HideBySig
    // code size 131 (0x83), max stack 5, init locals
    .locals ([0] LeaderboardEntry_t, [1] int[], [2] int, [3] LeaderboardEntry)
    IL_0000: ldarg.2
    IL_0001: brfalse.s IL_000f
    IL_0003: ldarg.0
    IL_0004: ldfld UnityEvent SteamManager::OnLeaderboardDownloadCallbackComplete  /*0x040009A7*/
    IL_0009: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: ldfld SteamLeaderboard_t Steamworks.LeaderboardScoresDownloaded_t::m_hSteamLeaderboard  /*0x0A00039C*/
    IL_0015: call string Steamworks.SteamUserStats::GetLeaderboardName(Steamworks.SteamLeaderboard_t)  /*0x0A00039D*/
    IL_001a: pop
    IL_001b: ldc.i4.0
    IL_001c: newarr System.Int32  /*0x01000026*/
    IL_0021: stloc.1
    IL_0022: ldc.i4.0
    IL_0023: stloc.2
    IL_0024: br.s IL_006e
    IL_0026: ldarg.1
    IL_0027: ldfld SteamLeaderboardEntries_t Steamworks.LeaderboardScoresDownloaded_t::m_hSteamLeaderboardEntries  /*0x0A00039E*/
    IL_002c: ldloc.2
    IL_002d: ldloca.s 0
    IL_002f: ldloc.1
    IL_0030: ldc.i4.0
    IL_0031: call bool Steamworks.SteamUserStats::GetDownloadedLeaderboardEntry(Steamworks.SteamLeaderboardEntries_t,int,ref Steamworks.LeaderboardEntry_t,int[],int)  /*0x0A00039F*/
    IL_0036: pop
    IL_0037: ldloca.s 3
    IL_0039: initobj Thronefall.GameServices.LeaderboardEntry  /*0x02000D22*/
    IL_003f: ldloca.s 3
    IL_0041: ldloc.0
    IL_0042: ldfld CSteamID Steamworks.LeaderboardEntry_t::m_steamIDUser  /*0x0A0003A0*/
    IL_0047: call string Steamworks.SteamFriends::GetFriendPersonaName(Steamworks.CSteamID)  /*0x0A0003A1*/
    IL_004c: stfld string Thronefall.GameServices.LeaderboardEntry::username  /*0x04003401*/
    IL_0051: ldloca.s 3
    IL_0053: ldloc.0
    IL_0054: ldfld int Steamworks.LeaderboardEntry_t::m_nScore  /*0x0A0003A2*/
    IL_0059: stfld int Thronefall.GameServices.LeaderboardEntry::score  /*0x04003402*/
    IL_005e: ldarg.0
    IL_005f: ldfld List<LeaderboardEntry> SteamManager::lastDownloadedLeaderboardEntires  /*0x040009A6*/
    IL_0064: ldloc.3
    IL_0065: callvirt void System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::Add(!0)  /*0x0A0003A3*/
    IL_006a: ldloc.2
    IL_006b: ldc.i4.1
    IL_006c: add
    IL_006d: stloc.2
    IL_006e: ldloc.2
    IL_006f: ldarg.1
    IL_0070: ldfld int Steamworks.LeaderboardScoresDownloaded_t::m_cEntryCount  /*0x0A0003A4*/
    IL_0075: blt.s IL_0026
    IL_0077: ldarg.0
    IL_0078: ldfld UnityEvent SteamManager::OnLeaderboardDownloadCallbackComplete  /*0x040009A7*/
    IL_007d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0082: ret

  .method SteamManager::.ctor()  // token 0x060007C2 rva 0x26203 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::.ctor()  /*0x0A00037B*/
    IL_0006: stfld List<LeaderboardEntry> SteamManager::lastDownloadedLeaderboardEntires  /*0x040009A6*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent SteamManager::OnLeaderboardDownloadCallbackComplete  /*0x040009A7*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent SteamManager::OnLeaderboardError  /*0x040009A8*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

  .method SteamManager::.cctor()  // token 0x060007C3 rva 0x2622c attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: stsfld bool SteamManager::s_EverInitialized  /*0x0400099F*/
    IL_0006: ldnull
    IL_0007: newobj void Steamworks.CallResult<Steamworks.LeaderboardFindResult_t>::.ctor(Steamworks.CallResult.APIDispatchDelegate<!0>)  /*0x0A0003A5*/
    IL_000c: stsfld CallResult<LeaderboardFindResult_t> SteamManager::_findLeaderboardCallback  /*0x040009A3*/
    IL_0011: ldc.i4.m1
    IL_0012: stsfld int SteamManager::scoreToUpload  /*0x040009A4*/
    IL_0017: ldnull
    IL_0018: newobj void Steamworks.CallResult<Steamworks.LeaderboardScoresDownloaded_t>::.ctor(Steamworks.CallResult.APIDispatchDelegate<!0>)  /*0x0A0003A6*/
    IL_001d: stsfld CallResult<LeaderboardScoresDownloaded_t> SteamManager::_downloadedScoresCallback  /*0x040009A5*/
    IL_0022: ret

