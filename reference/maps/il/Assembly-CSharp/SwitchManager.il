// ===== SwitchManager  (token 0x02000182) =====
  .method SwitchManager::get_Instance()  // token 0x060007C4 rva 0x26250 attrs Public, Static, HideBySig, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldsfld SwitchManager SwitchManager::s_instance  /*0x040009A9*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_001d
    IL_000d: ldstr "SwitchManager"
    IL_0012: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000D1*/
    IL_0017: call !!0 UnityEngine.GameObject::AddComponent()<SwitchManager>  /*0x2B000089*/
    IL_001c: ret
    IL_001d: ldsfld SwitchManager SwitchManager::s_instance  /*0x040009A9*/
    IL_0022: ret

  .method SwitchManager::get_Initialized()  // token 0x060007C5 rva 0x26274 attrs Public, Static, HideBySig, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call SwitchManager SwitchManager::get_Instance()  /*0x060007C4*/
    IL_0005: ldfld bool SwitchManager::m_bInitialized  /*0x040009AA*/
    IL_000a: ret

  .method SwitchManager::Awake()  // token 0x060007C6 rva 0x26280 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 60 (0x3c), max stack 8
    IL_0000: ldsfld SwitchManager SwitchManager::s_instance  /*0x040009A9*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld SwitchManager SwitchManager::s_instance  /*0x040009A9*/
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_002a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002f: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0034: ldarg.0
    IL_0035: ldc.i4.1
    IL_0036: stfld bool SwitchManager::m_bInitialized  /*0x040009AA*/
    IL_003b: ret

  .method SwitchManager::UploadHighscore(int,string)  // token 0x060007C7 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SwitchManager::DownloadFriendsHighscores(string)  // token 0x060007C8 rva 0x262bd attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent SwitchManager::OnLeaderboardDownloadCallbackComplete  /*0x040009AB*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method SwitchManager::SetAchievement(string)  // token 0x060007C9 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SwitchManager::ClearAchievement(string)  // token 0x060007CA rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SwitchManager::StoreStats()  // token 0x060007CB rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SwitchManager::GetPersonaName()  // token 0x060007CC rva 0x262cf attrs Public, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr "SwitchUser"
    IL_0005: ret

  .method SwitchManager::.ctor()  // token 0x060007CD rva 0x262d6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent SwitchManager::OnLeaderboardDownloadCallbackComplete  /*0x040009AB*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent SwitchManager::OnLeaderboardError  /*0x040009AC*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<Thronefall.GameServices.LeaderboardEntry>::.ctor()  /*0x0A00037B*/
    IL_001c: stfld List<LeaderboardEntry> SwitchManager::lastDownloadedLeaderboardEntires  /*0x040009AD*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

