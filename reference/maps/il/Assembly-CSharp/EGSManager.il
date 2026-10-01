// ===== EGSManager  (token 0x0200017F) =====
  .method EGSManager::get_Instance()  // token 0x060007A7 rva 0x25d32 attrs Public, Static, HideBySig, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldsfld EGSManager EGSManager::s_instance  /*0x04000999*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_001d
    IL_000d: ldstr "EGSManager"
    IL_0012: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000D1*/
    IL_0017: call !!0 UnityEngine.GameObject::AddComponent()<EGSManager>  /*0x2B000087*/
    IL_001c: ret
    IL_001d: ldsfld EGSManager EGSManager::s_instance  /*0x04000999*/
    IL_0022: ret

  .method EGSManager::get_Initialized()  // token 0x060007A8 rva 0x25d56 attrs Public, Static, HideBySig, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call EGSManager EGSManager::get_Instance()  /*0x060007A7*/
    IL_0005: ldfld bool EGSManager::m_bInitialized  /*0x0400099A*/
    IL_000a: ret

  .method EGSManager::Awake()  // token 0x060007A9 rva 0x25d62 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 60 (0x3c), max stack 8
    IL_0000: ldsfld EGSManager EGSManager::s_instance  /*0x04000999*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld EGSManager EGSManager::s_instance  /*0x04000999*/
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_002a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002f: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0034: ldarg.0
    IL_0035: ldc.i4.1
    IL_0036: stfld bool EGSManager::m_bInitialized  /*0x0400099A*/
    IL_003b: ret

  .method EGSManager::UploadHighscore(int,string)  // token 0x060007AA rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EGSManager::DownloadFriendsHighscores(string)  // token 0x060007AB rva 0x25d9f attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent EGSManager::OnLeaderboardDownloadCallbackComplete  /*0x0400099B*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method EGSManager::SetAchievement(string)  // token 0x060007AC rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EGSManager::ClearAchievement(string)  // token 0x060007AD rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EGSManager::StoreStats()  // token 0x060007AE rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EGSManager::GetPersonaName()  // token 0x060007AF rva 0x25db1 attrs Public, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr "EpicUser"
    IL_0005: ret

  .method EGSManager::.ctor()  // token 0x060007B0 rva 0x25db8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent EGSManager::OnLeaderboardDownloadCallbackComplete  /*0x0400099B*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::.ctor()  /*0x0A00037B*/
    IL_0011: stfld List<LeaderboardEntry> EGSManager::lastDownloadedLeaderboardEntires  /*0x0400099C*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

