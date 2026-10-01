// ===== LevelSelectUIFrameHelper  (token 0x0200031D) =====
  .method LevelSelectUIFrameHelper::OnShow()  // token 0x06001129 rva 0x50450 attrs Public, HideBySig
    // code size 198 (0xc6), max stack 2, init locals
    IL_0000: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0005: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_000a: call void MatchSaveLoadHandler::TryLoadRun(string)  /*0x06000CFE*/
    IL_000f: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0014: brfalse.s IL_007a
    IL_0016: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_001b: ldfld bool LevelInfo::ignoreSaves  /*0x04000B24*/
    IL_0020: brtrue.s IL_007a
    IL_0022: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0027: ldfld bool MatchSave::runComplete  /*0x04000F8F*/
    IL_002c: brtrue.s IL_007a
    IL_002e: ldarg.0
    IL_002f: ldfld GameObject LevelSelectUIFrameHelper::hasSaveParent  /*0x04001477*/
    IL_0034: ldc.i4.1
    IL_0035: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003a: ldarg.0
    IL_003b: ldfld GameObject LevelSelectUIFrameHelper::hasNoSaveParent  /*0x04001478*/
    IL_0040: ldc.i4.0
    IL_0041: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0046: ldarg.0
    IL_0047: ldfld UIFrame LevelSelectUIFrameHelper::target  /*0x04001471*/
    IL_004c: ldarg.0
    IL_004d: ldfld ThronefallUIElement LevelSelectUIFrameHelper::saveLowerButton  /*0x04001476*/
    IL_0052: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0057: ldarg.0
    IL_0058: ldfld ThronefallUIElement LevelSelectUIFrameHelper::highscoreButton  /*0x04001473*/
    IL_005d: ldarg.0
    IL_005e: ldfld ThronefallUIElement LevelSelectUIFrameHelper::saveLowerButton  /*0x04001476*/
    IL_0063: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0068: ldarg.0
    IL_0069: ldfld ThronefallUIElement LevelSelectUIFrameHelper::highscoreButton  /*0x04001473*/
    IL_006e: ldarg.0
    IL_006f: ldfld ThronefallUIElement LevelSelectUIFrameHelper::saveUpperButton  /*0x04001475*/
    IL_0074: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: ldfld GameObject LevelSelectUIFrameHelper::hasSaveParent  /*0x04001477*/
    IL_0080: ldc.i4.0
    IL_0081: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0086: ldarg.0
    IL_0087: ldfld GameObject LevelSelectUIFrameHelper::hasNoSaveParent  /*0x04001478*/
    IL_008c: ldc.i4.1
    IL_008d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0092: ldarg.0
    IL_0093: ldfld UIFrame LevelSelectUIFrameHelper::target  /*0x04001471*/
    IL_0098: ldarg.0
    IL_0099: ldfld ThronefallUIElement LevelSelectUIFrameHelper::noSavePlayButton  /*0x04001474*/
    IL_009e: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld ThronefallUIElement LevelSelectUIFrameHelper::highscoreButton  /*0x04001473*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld ThronefallUIElement LevelSelectUIFrameHelper::noSavePlayButton  /*0x04001474*/
    IL_00af: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld ThronefallUIElement LevelSelectUIFrameHelper::highscoreButton  /*0x04001473*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld ThronefallUIElement LevelSelectUIFrameHelper::noSavePlayButton  /*0x04001474*/
    IL_00c0: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00c5: ret

  .method LevelSelectUIFrameHelper::TransitionToSelectedLevel()  // token 0x0600112A rva 0x50522 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0006: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_000b: ldsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_0010: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0015: callvirt void SceneTransitionManager::TransitionFromLevelSelectToLevel(string)  /*0x060009C9*/
    IL_001a: ret

  .method LevelSelectUIFrameHelper::SetOverrideSave(bool)  // token 0x0600112B rva 0x5053e attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0006: ret

  .method LevelSelectUIFrameHelper::.ctor()  // token 0x0600112C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

