// ===== InMatchResignHelper  (token 0x02000316) =====
  .method InMatchResignHelper::TryResign()  // token 0x060010FB rva 0x4eb60 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: bne.un.s IL_0019
    IL_0008: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000d: ldarg.0
    IL_000e: ldfld UIFrame InMatchResignHelper::etResignPopUp  /*0x0400143B*/
    IL_0013: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0018: ret
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldarg.0
    IL_001f: ldfld UIFrame InMatchResignHelper::classicRetryPopUp  /*0x0400143A*/
    IL_0024: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0029: ret

  .method InMatchResignHelper::ApplyResign()  // token 0x060010FC rva 0x4eb8b attrs Public, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: callvirt void UIFrameManager::CloseAllFrames()  /*0x0600130A*/
    IL_000a: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_000f: ldc.i4.3
    IL_0010: ldc.i4.0
    IL_0011: ldc.i4.0
    IL_0012: callvirt void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_0017: ret

  .method InMatchResignHelper::TryBackToMap()  // token 0x060010FD rva 0x4eba4 attrs Public, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: bne.un.s IL_0025
    IL_0008: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000d: ldfld bool EternalTrialsRun::inNight  /*0x04000853*/
    IL_0012: brfalse.s IL_0025
    IL_0014: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0019: ldarg.0
    IL_001a: ldfld UIFrame InMatchResignHelper::etBackToMapPopUp  /*0x0400143C*/
    IL_001f: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0024: ret
    IL_0025: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_002a: callvirt void SceneTransitionManager::TransitionFromLevelToLevelSelect()  /*0x060009D3*/
    IL_002f: ret

  .method InMatchResignHelper::AppliedBackToMap()  // token 0x060010FE rva 0x4ebd5 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt void SceneTransitionManager::TransitionFromLevelToLevelSelect()  /*0x060009D3*/
    IL_000a: ret

  .method InMatchResignHelper::.ctor()  // token 0x060010FF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

