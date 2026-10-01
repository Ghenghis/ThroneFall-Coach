// ===== BackToTitlescreenUIHelper  (token 0x020002D6) =====
  .method BackToTitlescreenUIHelper::TransitionToMainMenu()  // token 0x06000FAA rva 0x4736c attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::TransitionToMainMenu()  /*0x060009D5*/
    IL_000a: ret

  .method BackToTitlescreenUIHelper::.ctor()  // token 0x06000FAB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

