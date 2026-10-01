// ===== TransitionToSelectedLevelHelper  (token 0x0200036C) =====
  .method TransitionToSelectedLevelHelper::TransitionToSelectedLevel()  // token 0x060012CD rva 0x594e7 attrs Public, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool TransitionToSelectedLevelHelper::justRestartCurrentLevel  /*0x040016A4*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0013: callvirt void SceneTransitionManager::RestartCurrentLevel()  /*0x060009CB*/
    IL_0018: ret
    IL_0019: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_001e: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0023: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0028: callvirt void SceneTransitionManager::TransitionFromLevelSelectToLevel(string)  /*0x060009C9*/
    IL_002d: ret

  .method TransitionToSelectedLevelHelper::.ctor()  // token 0x060012CE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

