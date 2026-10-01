// ===== EternalTrialsSelectScreen  (token 0x0200030A) =====
  .method EternalTrialsSelectScreen::ContinueRun()  // token 0x060010D1 rva 0x4da73 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0006: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_000b: ldfld bool EternalTrialsRun::inGame  /*0x04000852*/
    IL_0010: brfalse.s IL_0019
    IL_0012: ldnull
    IL_0013: call void EternalTrialsRunManager::LoadNextMap(EternalTrialsRun)  /*0x060006F4*/
    IL_0018: ret
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldarg.0
    IL_001f: ldfld UIFrame EternalTrialsSelectScreen::loadoutSelectionFrame  /*0x040013F2*/
    IL_0024: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0029: ret

  .method EternalTrialsSelectScreen::NewRun()  // token 0x060010D2 rva 0x4da9e attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0006: call void EternalTrialsRunManager::DiscardActiveRun()  /*0x060006F0*/
    IL_000b: call void EternalTrialsRunManager::CreateFreshRun()  /*0x060006F5*/
    IL_0010: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0015: ldarg.0
    IL_0016: ldfld UIFrame EternalTrialsSelectScreen::loadoutSelectionFrame  /*0x040013F2*/
    IL_001b: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0020: ret

  .method EternalTrialsSelectScreen::Refresh()  // token 0x060010D3 rva 0x4dac0 attrs Public, HideBySig
    // code size 181 (0xb5), max stack 2, init locals
    IL_0000: call bool EternalTrialsRunManager::get_HasOngoingRun()  /*0x060006EC*/
    IL_0005: brtrue.s IL_000c
    IL_0007: call void EternalTrialsRunManager::TurnLastDiscardedRunIntoCurrentRun()  /*0x060006F1*/
    IL_000c: ldstr "ET_CurrentLevel"
    IL_0011: call void MatchSaveLoadHandler::TryLoadRun(string)  /*0x06000CFE*/
    IL_0016: call bool EternalTrialsRunManager::get_HasOngoingRun()  /*0x060006EC*/
    IL_001b: brfalse.s IL_0069
    IL_001d: ldarg.0
    IL_001e: ldfld GameObject EternalTrialsSelectScreen::runExistantButtons  /*0x040013F3*/
    IL_0023: ldc.i4.1
    IL_0024: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0029: ldarg.0
    IL_002a: ldfld GameObject EternalTrialsSelectScreen::noRunSavedButtons  /*0x040013F4*/
    IL_002f: ldc.i4.0
    IL_0030: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0035: ldarg.0
    IL_0036: ldfld UIFrame EternalTrialsSelectScreen::targetFrame  /*0x040013F1*/
    IL_003b: ldarg.0
    IL_003c: ldfld ThronefallUIElement EternalTrialsSelectScreen::runExistantFirstSelected  /*0x040013F5*/
    IL_0041: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0046: ldarg.0
    IL_0047: ldfld ThronefallUIElement EternalTrialsSelectScreen::highscoreButton  /*0x040013F7*/
    IL_004c: ldarg.0
    IL_004d: ldfld ThronefallUIElement EternalTrialsSelectScreen::saveLowerButton  /*0x040013FA*/
    IL_0052: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0057: ldarg.0
    IL_0058: ldfld ThronefallUIElement EternalTrialsSelectScreen::highscoreButton  /*0x040013F7*/
    IL_005d: ldarg.0
    IL_005e: ldfld ThronefallUIElement EternalTrialsSelectScreen::saveUpperButton  /*0x040013F9*/
    IL_0063: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0068: ret
    IL_0069: ldarg.0
    IL_006a: ldfld GameObject EternalTrialsSelectScreen::runExistantButtons  /*0x040013F3*/
    IL_006f: ldc.i4.0
    IL_0070: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0075: ldarg.0
    IL_0076: ldfld GameObject EternalTrialsSelectScreen::noRunSavedButtons  /*0x040013F4*/
    IL_007b: ldc.i4.1
    IL_007c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0081: ldarg.0
    IL_0082: ldfld UIFrame EternalTrialsSelectScreen::targetFrame  /*0x040013F1*/
    IL_0087: ldarg.0
    IL_0088: ldfld ThronefallUIElement EternalTrialsSelectScreen::noRunSavedFirstSelected  /*0x040013F6*/
    IL_008d: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0092: ldarg.0
    IL_0093: ldfld ThronefallUIElement EternalTrialsSelectScreen::highscoreButton  /*0x040013F7*/
    IL_0098: ldarg.0
    IL_0099: ldfld ThronefallUIElement EternalTrialsSelectScreen::noSaveButton  /*0x040013F8*/
    IL_009e: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld ThronefallUIElement EternalTrialsSelectScreen::highscoreButton  /*0x040013F7*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld ThronefallUIElement EternalTrialsSelectScreen::noSaveButton  /*0x040013F8*/
    IL_00af: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00b4: ret

  .method EternalTrialsSelectScreen::.ctor()  // token 0x060010D4 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

