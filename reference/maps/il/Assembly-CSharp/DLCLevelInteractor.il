// ===== DLCLevelInteractor  (token 0x02000006) =====
  .method DLCLevelInteractor::Start()  // token 0x06000020 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DLCLevelInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000021 rva 0x2703 attrs Public, Virtual, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string DLCLevelInteractor::DLCLevelSelectScene  /*0x0400001F*/
    IL_0006: ldstr ""
    IL_000b: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0010: brfalse.s IL_0022
    IL_0012: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0017: ldarg.0
    IL_0018: ldfld string DLCLevelInteractor::DLCLevelSelectScene  /*0x0400001F*/
    IL_001d: callvirt void SceneTransitionManager::TransitionFromLevelSelectToLevel(string)  /*0x060009C9*/
    IL_0022: ret

  .method DLCLevelInteractor::Focus(PlayerInteraction)  // token 0x06000022 rva 0x2727 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject DLCLevelInteractor::focusPanel  /*0x0400001E*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method DLCLevelInteractor::Unfocus(PlayerInteraction)  // token 0x06000023 rva 0x2735 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject DLCLevelInteractor::focusPanel  /*0x0400001E*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method DLCLevelInteractor::.ctor()  // token 0x06000024 rva 0x2743 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0006: ret

