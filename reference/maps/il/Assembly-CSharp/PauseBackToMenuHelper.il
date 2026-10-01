// ===== PauseBackToMenuHelper  (token 0x0200032C) =====
  .method PauseBackToMenuHelper::BackToMenu()  // token 0x06001179 rva 0x4ebd5 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::TransitionFromLevelToLevelSelect()  /*0x060009D3*/
    IL_000a: ret

  .method PauseBackToMenuHelper::.ctor()  // token 0x0600117A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

