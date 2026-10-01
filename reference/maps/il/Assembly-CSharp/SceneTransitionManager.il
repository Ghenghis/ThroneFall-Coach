// ===== SceneTransitionManager  (token 0x020001DE) =====
  .method SceneTransitionManager::get_CurrentSceneState()  // token 0x060009BC rva 0x2dd71 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0006: ret

  .method SceneTransitionManager::get_LastSceneState()  // token 0x060009BD rva 0x2dd79 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SceneTransitionManager.SceneState SceneTransitionManager::lastSceneState  /*0x04000C7B*/
    IL_0006: ret

  .method SceneTransitionManager::get_IngameScoreFromLastMatch()  // token 0x060009BE rva 0x2dd81 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager::ingameScoreFromLastMatch  /*0x04000C7C*/
    IL_0006: ret

  .method SceneTransitionManager::get_GoldBonusScoreFromLastMatch()  // token 0x060009BF rva 0x2dd89 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager::goldBonusScoreFromLastMatch  /*0x04000C7D*/
    IL_0006: ret

  .method SceneTransitionManager::get_MutatorBonusScoreFromLastMatch()  // token 0x060009C0 rva 0x2dd91 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager::mutatorBonusScoreFromLastMatch  /*0x04000C7E*/
    IL_0006: ret

  .method SceneTransitionManager::get_NoRetryBonusScoreFromLastMatch()  // token 0x060009C1 rva 0x2dd99 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager::noRetryBonusScoreFromLastMatch  /*0x04000C7F*/
    IL_0006: ret

  .method SceneTransitionManager::get_TotalScoreFromLastMatch()  // token 0x060009C2 rva 0x2dda1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager::totalScoreFromLastMatch  /*0x04000C81*/
    IL_0006: ret

  .method SceneTransitionManager::get_TotalScoreFromLastMatchIsNewPersonalRecord()  // token 0x060009C3 rva 0x2dda9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SceneTransitionManager::totalScoreFromLastMatchIsNewPersonalRecord  /*0x04000C82*/
    IL_0006: ret

  .method SceneTransitionManager::get_ComingFromGameplayScene()  // token 0x060009C4 rva 0x2ddb1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SceneTransitionManager::comingFromGameplayScene  /*0x04000C80*/
    IL_0006: ret

  .method SceneTransitionManager::get_LevelDataFromLastMatch()  // token 0x060009C5 rva 0x2ddb9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LevelData SceneTransitionManager::levelDataFromLastMatch  /*0x04000C83*/
    IL_0006: ret

  .method SceneTransitionManager::get_SceneTransitionIsRunning()  // token 0x060009C6 rva 0x2ddc1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SceneTransitionManager::sceneTransitionIsRunning  /*0x04000C85*/
    IL_0006: ret

  .method SceneTransitionManager::Awake()  // token 0x060009C7 rva 0x2ddcc attrs Private, HideBySig
    // code size 146 (0x92), max stack 2, init locals
    .locals ([0] Scene)
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0018
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: stsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_001e: ldarg.0
    IL_001f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0024: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_0029: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0033: ldarg.0
    IL_0034: ldfld string SceneTransitionManager::uiScene  /*0x04000C70*/
    IL_0039: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_003e: stloc.0
    IL_003f: ldloca.s 0
    IL_0041: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_0046: brtrue.s IL_0054
    IL_0048: ldarg.0
    IL_0049: ldfld string SceneTransitionManager::uiScene  /*0x04000C70*/
    IL_004e: ldc.i4.1
    IL_004f: call void UnityEngine.SceneManagement.SceneManager::LoadScene(string,UnityEngine.SceneManagement.LoadSceneMode)  /*0x0A0003DB*/
    IL_0054: ldarg.0
    IL_0055: ldarg.0
    IL_0056: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_005b: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0060: stfld Color SceneTransitionManager::cloudsIn  /*0x04000C86*/
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld Color SceneTransitionManager::cloudsIn  /*0x04000C86*/
    IL_006c: stfld Color SceneTransitionManager::cloudsOut  /*0x04000C87*/
    IL_0071: ldarg.0
    IL_0072: ldflda Color SceneTransitionManager::cloudsOut  /*0x04000C87*/
    IL_0077: ldc.r4 0f
    IL_007c: stfld float UnityEngine.Color::a  /*0x0A000187*/
    IL_0081: ldarg.0
    IL_0082: ldfld TMP_Text SceneTransitionManager::loadingText  /*0x04000C76*/
    IL_0087: ldc.r4 0f
    IL_008c: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_0091: ret

  .method SceneTransitionManager::Start()  // token 0x060009C8 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SceneTransitionManager::TransitionFromLevelSelectToLevel(string)  // token 0x060009C9 rva 0x2de6a attrs Public, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0006: ldc.i4.1
    IL_0007: beq.s IL_0014
    IL_0009: ldstr "You should only transition to a specific level from the level selection scene."
    IL_000e: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: call void SceneTransitionManager::SetCurrentLevelSelect()  /*0x060009D8*/
    IL_001a: ldarg.0
    IL_001b: ldarg.1
    IL_001c: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_0021: ret

  .method SceneTransitionManager::TransitionFromNullToLevel(string)  // token 0x060009CA rva 0x2de8d attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SceneTransitionManager::SetCurrentLevelSelect()  /*0x060009D8*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_000d: ret

  .method SceneTransitionManager::RestartCurrentLevel()  // token 0x060009CB rva 0x2de9c attrs Public, HideBySig
    // code size 20 (0x14), max stack 2, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0006: stloc.0
    IL_0007: ldloca.s 0
    IL_0009: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_000e: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_0013: ret

  .method SceneTransitionManager::SetComingFromSceneToCurrentScene()  // token 0x060009CC rva 0x2debc attrs Private, HideBySig
    // code size 39 (0x27), max stack 2, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0006: stloc.0
    IL_0007: ldloca.s 0
    IL_0009: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_000e: stfld string SceneTransitionManager::comingFromGameplayScene  /*0x04000C80*/
    IL_0013: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0018: ldc.i4.1
    IL_0019: bne.un.s IL_0026
    IL_001b: ldarg.0
    IL_001c: ldstr "Eternal Trials"
    IL_0021: stfld string SceneTransitionManager::comingFromGameplayScene  /*0x04000C80*/
    IL_0026: ret

  .method SceneTransitionManager::TransitionFromGameplayToEndScreen(int,int,int,int)  // token 0x060009CD rva 0x2def0 attrs Public, HideBySig
    // code size 168 (0xa8), max stack 3, init locals
    .locals ([0] LevelData)
    IL_0000: ldarg.0
    IL_0001: call void SceneTransitionManager::SetComingFromSceneToCurrentScene()  /*0x060009CC*/
    IL_0006: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_000b: ldarg.0
    IL_000c: ldfld string SceneTransitionManager::comingFromGameplayScene  /*0x04000C80*/
    IL_0011: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0016: stloc.0
    IL_0017: ldarg.0
    IL_0018: ldloc.0
    IL_0019: stfld LevelData SceneTransitionManager::levelDataFromLastMatch  /*0x04000C83*/
    IL_001e: ldarg.0
    IL_001f: ldfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0024: ldc.i4.2
    IL_0025: beq.s IL_0032
    IL_0027: ldstr "You should only transition to the end screen from a gameply level."
    IL_002c: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldarg.1
    IL_0034: stfld int SceneTransitionManager::ingameScoreFromLastMatch  /*0x04000C7C*/
    IL_0039: ldarg.0
    IL_003a: ldarg.2
    IL_003b: stfld int SceneTransitionManager::goldBonusScoreFromLastMatch  /*0x04000C7D*/
    IL_0040: ldarg.0
    IL_0041: ldarg.3
    IL_0042: stfld int SceneTransitionManager::mutatorBonusScoreFromLastMatch  /*0x04000C7E*/
    IL_0047: ldarg.0
    IL_0048: ldarg.s 4
    IL_004a: stfld int SceneTransitionManager::noRetryBonusScoreFromLastMatch  /*0x04000C7F*/
    IL_004f: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0054: brtrue.s IL_0086
    IL_0056: ldloc.0
    IL_0057: ldarg.1
    IL_0058: ldarg.2
    IL_0059: add
    IL_005a: ldarg.3
    IL_005b: add
    IL_005c: ldarg.s 4
    IL_005e: add
    IL_005f: stfld int LevelData::highscore  /*0x04000BBE*/
    IL_0064: ldarg.0
    IL_0065: ldloc.0
    IL_0066: ldfld int LevelData::highscore  /*0x04000BBE*/
    IL_006b: stfld int SceneTransitionManager::totalScoreFromLastMatch  /*0x04000C81*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldfld int SceneTransitionManager::totalScoreFromLastMatch  /*0x04000C81*/
    IL_0077: ldloc.0
    IL_0078: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_007d: cgt
    IL_007f: stfld bool SceneTransitionManager::totalScoreFromLastMatchIsNewPersonalRecord  /*0x04000C82*/
    IL_0084: br.s IL_00a2
    IL_0086: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_008b: ldc.i4.1
    IL_008c: bne.un.s IL_00a2
    IL_008e: ldarg.0
    IL_008f: ldarg.1
    IL_0090: ldarg.2
    IL_0091: add
    IL_0092: stfld int SceneTransitionManager::totalScoreFromLastMatch  /*0x04000C81*/
    IL_0097: ldarg.0
    IL_0098: ldfld int SceneTransitionManager::totalScoreFromLastMatch  /*0x04000C81*/
    IL_009d: call void EternalTrialsRunManager::AddScore(int)  /*0x060006F8*/
    IL_00a2: call void UIFrameManager::TriggerEndOfMatch()  /*0x06001314*/
    IL_00a7: ret

  .method SceneTransitionManager::TransitionFromEndScreenToLevelSelect()  // token 0x060009CE rva 0x2dfa4 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call string SceneTransitionManager::GetCurrentLevelSelectScene()  /*0x060009D9*/
    IL_0007: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_000c: ret

  .method SceneTransitionManager::TransitionToScene(string)  // token 0x060009CF rva 0x2dfb4 attrs Private, HideBySig
    // code size 128 (0x80), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool SceneTransitionManager::sceneTransitionIsRunning  /*0x04000C85*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0010: stfld SceneTransitionManager.SceneState SceneTransitionManager::lastSceneState  /*0x04000C7B*/
    IL_0015: ldarg.1
    IL_0016: ldarg.0
    IL_0017: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_001c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0021: brtrue.s IL_003f
    IL_0023: ldarg.1
    IL_0024: ldarg.0
    IL_0025: ldfld string SceneTransitionManager::levelSelectSceneCraaghelm  /*0x04000C73*/
    IL_002a: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_002f: brtrue.s IL_003f
    IL_0031: ldarg.1
    IL_0032: ldarg.0
    IL_0033: ldfld string SceneTransitionManager::levelSelectSceneFangmore  /*0x04000C74*/
    IL_0038: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_003d: brfalse.s IL_0048
    IL_003f: ldarg.0
    IL_0040: ldc.i4.1
    IL_0041: stfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0046: br.s IL_0066
    IL_0048: ldarg.1
    IL_0049: ldarg.0
    IL_004a: ldfld string SceneTransitionManager::mainMenuScene  /*0x04000C71*/
    IL_004f: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0054: brfalse.s IL_005f
    IL_0056: ldarg.0
    IL_0057: ldc.i4.0
    IL_0058: stfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_005d: br.s IL_0066
    IL_005f: ldarg.0
    IL_0060: ldc.i4.2
    IL_0061: stfld SceneTransitionManager.SceneState SceneTransitionManager::currentSceneState  /*0x04000C7A*/
    IL_0066: ldarg.0
    IL_0067: ldfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_006c: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0071: ldarg.0
    IL_0072: ldarg.0
    IL_0073: ldarg.1
    IL_0074: call IEnumerator SceneTransitionManager::SceneTransitionAnimation(string)  /*0x060009D1*/
    IL_0079: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_007e: pop
    IL_007f: ret

  .method SceneTransitionManager::FadeFormula(float)  // token 0x060009D0 rva 0x2e040 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.r4 4f
    IL_0006: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_000b: ret

  .method SceneTransitionManager::SceneTransitionAnimation(string)  // token 0x060009D1 rva 0x2e04d attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void SceneTransitionManager.<SceneTransitionAnimation>d__59::.ctor(int)  /*0x060009DB*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld SceneTransitionManager SceneTransitionManager.<SceneTransitionAnimation>d__59::<>4__this  /*0x04000C8F*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld string SceneTransitionManager.<SceneTransitionAnimation>d__59::_scenename  /*0x04000C90*/
    IL_0014: ret

  .method SceneTransitionManager::TransitionFromNullToLevelSelect()  // token 0x060009D2 rva 0x2e063 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_0007: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_000c: ret

  .method SceneTransitionManager::TransitionFromLevelToLevelSelect()  // token 0x060009D3 rva 0x2e071 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void SceneTransitionManager::SetComingFromSceneToCurrentScene()  /*0x060009CC*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call string SceneTransitionManager::GetCurrentLevelSelectScene()  /*0x060009D9*/
    IL_000d: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_0012: ret

  .method SceneTransitionManager::TransitionToLevelSelect()  // token 0x060009D4 rva 0x2dfa4 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call string SceneTransitionManager::GetCurrentLevelSelectScene()  /*0x060009D9*/
    IL_0007: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_000c: ret

  .method SceneTransitionManager::TransitionToMainMenu()  // token 0x060009D5 rva 0x2e085 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld string SceneTransitionManager::mainMenuScene  /*0x04000C71*/
    IL_0007: call void SceneTransitionManager::TransitionToScene(string)  /*0x060009CF*/
    IL_000c: ret

  .method SceneTransitionManager::IsInLevelSelect()  // token 0x060009D6 rva 0x2e094 attrs Public, HideBySig
    // code size 64 (0x40), max stack 1, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_0006: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_000b: stloc.0
    IL_000c: ldloca.s 0
    IL_000e: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_0013: brtrue.s IL_003e
    IL_0015: ldarg.0
    IL_0016: ldfld string SceneTransitionManager::levelSelectSceneCraaghelm  /*0x04000C73*/
    IL_001b: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_0020: stloc.0
    IL_0021: ldloca.s 0
    IL_0023: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_0028: brtrue.s IL_003e
    IL_002a: ldarg.0
    IL_002b: ldfld string SceneTransitionManager::levelSelectSceneFangmore  /*0x04000C74*/
    IL_0030: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_0035: stloc.0
    IL_0036: ldloca.s 0
    IL_0038: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_003d: ret
    IL_003e: ldc.i4.1
    IL_003f: ret

  .method SceneTransitionManager::IsDLCLevelSelect()  // token 0x060009D7 rva 0x2e0e0 attrs Public, HideBySig
    // code size 43 (0x2b), max stack 1, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: ldfld string SceneTransitionManager::levelSelectSceneCraaghelm  /*0x04000C73*/
    IL_0006: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_000b: stloc.0
    IL_000c: ldloca.s 0
    IL_000e: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_0013: brtrue.s IL_0029
    IL_0015: ldarg.0
    IL_0016: ldfld string SceneTransitionManager::levelSelectSceneFangmore  /*0x04000C74*/
    IL_001b: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_0020: stloc.0
    IL_0021: ldloca.s 0
    IL_0023: call bool UnityEngine.SceneManagement.Scene::IsValid()  /*0x0A000469*/
    IL_0028: ret
    IL_0029: ldc.i4.1
    IL_002a: ret

  .method SceneTransitionManager::SetCurrentLevelSelect()  // token 0x060009D8 rva 0x2e118 attrs Private, HideBySig
    // code size 36 (0x24), max stack 2, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call bool SceneTransitionManager::IsInLevelSelect()  /*0x060009D6*/
    IL_0007: brtrue.s IL_0011
    IL_0009: ldarg.0
    IL_000a: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_000f: br.s IL_001e
    IL_0011: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0016: stloc.0
    IL_0017: ldloca.s 0
    IL_0019: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_001e: stfld string SceneTransitionManager::currentlevelSelectScene  /*0x04000C84*/
    IL_0023: ret

  .method SceneTransitionManager::GetCurrentLevelSelectScene()  // token 0x060009D9 rva 0x2e148 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SceneTransitionManager::currentlevelSelectScene  /*0x04000C84*/
    IL_0006: call bool System.String::IsNullOrEmpty(string)  /*0x0A000141*/
    IL_000b: brfalse.s IL_0014
    IL_000d: ldarg.0
    IL_000e: ldfld string SceneTransitionManager::levelSelectScene  /*0x04000C72*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld string SceneTransitionManager::currentlevelSelectScene  /*0x04000C84*/
    IL_001a: ret

  .method SceneTransitionManager::.ctor()  // token 0x060009DA rva 0x2e164 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldstr "_UI"
    IL_0006: stfld string SceneTransitionManager::uiScene  /*0x04000C70*/
    IL_000b: ldarg.0
    IL_000c: ldstr "_StartMenu"
    IL_0011: stfld string SceneTransitionManager::mainMenuScene  /*0x04000C71*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float SceneTransitionManager::cloudFadeInTime  /*0x04000C77*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 2f
    IL_0027: stfld float SceneTransitionManager::cloudFadeOutTime  /*0x04000C78*/
    IL_002c: ldarg.0
    IL_002d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0032: stfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_0037: ldarg.0
    IL_0038: ldstr ""
    IL_003d: stfld string SceneTransitionManager::comingFromGameplayScene  /*0x04000C80*/
    IL_0042: ldarg.0
    IL_0043: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0048: ret

// ===== SceneTransitionManager/SceneState  (token 0x020001DF) =====
// ===== SceneTransitionManager/<SceneTransitionAnimation>d__59  (token 0x020001E0) =====
  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::.ctor(int)  // token 0x060009DB rva 0x2e1b9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_000d: ret

  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::System.IDisposable.Dispose()  // token 0x060009DC rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::MoveNext()  // token 0x060009DD rva 0x2e1c8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 834 (0x342), max stack 8, init locals
    .locals ([0] int, [1] SceneTransitionManager, [2] float, [3] int, [4] Scene, [5] int, [6] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld SceneTransitionManager SceneTransitionManager.<SceneTransitionAnimation>d__59::<>4__this  /*0x04000C8F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_00f8, IL_01ec, IL_02ef)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_002d: ldloc.1
    IL_002e: ldc.i4.1
    IL_002f: stfld bool SceneTransitionManager::sceneTransitionIsRunning  /*0x04000C85*/
    IL_0034: ldarg.0
    IL_0035: call int UnityEngine.SceneManagement.SceneManager::get_sceneCount()  /*0x0A000425*/
    IL_003a: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<sceneCount>5__2  /*0x04000C91*/
    IL_003f: ldloc.1
    IL_0040: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_0045: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004a: ldc.i4.1
    IL_004b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0050: ldarg.0
    IL_0051: ldc.r4 0f
    IL_0056: stfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_005b: br IL_00ff
    IL_0060: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0065: ldc.r4 0f
    IL_006a: ldc.r4 0.1f
    IL_006f: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0074: stloc.2
    IL_0075: ldarg.0
    IL_0076: ldarg.0
    IL_0077: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_007c: ldloc.2
    IL_007d: add
    IL_007e: stfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_0083: ldloc.1
    IL_0084: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_0089: ldloc.1
    IL_008a: ldfld Color SceneTransitionManager::cloudsOut  /*0x04000C87*/
    IL_008f: ldloc.1
    IL_0090: ldfld Color SceneTransitionManager::cloudsIn  /*0x04000C86*/
    IL_0095: ldc.r4 1f
    IL_009a: ldloc.1
    IL_009b: ldc.r4 1f
    IL_00a0: ldarg.0
    IL_00a1: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_00a6: ldloc.1
    IL_00a7: ldfld float SceneTransitionManager::cloudFadeInTime  /*0x04000C77*/
    IL_00ac: div
    IL_00ad: sub
    IL_00ae: call float SceneTransitionManager::FadeFormula(float)  /*0x060009D0*/
    IL_00b3: sub
    IL_00b4: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00b9: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00be: ldloc.1
    IL_00bf: ldfld TMP_Text SceneTransitionManager::loadingText  /*0x04000C76*/
    IL_00c4: ldc.r4 1f
    IL_00c9: ldloc.1
    IL_00ca: ldc.r4 1f
    IL_00cf: ldarg.0
    IL_00d0: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_00d5: ldloc.1
    IL_00d6: ldfld float SceneTransitionManager::cloudFadeInTime  /*0x04000C77*/
    IL_00db: div
    IL_00dc: sub
    IL_00dd: call float SceneTransitionManager::FadeFormula(float)  /*0x060009D0*/
    IL_00e2: sub
    IL_00e3: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_00e8: ldarg.0
    IL_00e9: ldnull
    IL_00ea: stfld object SceneTransitionManager.<SceneTransitionAnimation>d__59::<>2__current  /*0x04000C8E*/
    IL_00ef: ldarg.0
    IL_00f0: ldc.i4.1
    IL_00f1: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_00f6: ldc.i4.1
    IL_00f7: ret
    IL_00f8: ldarg.0
    IL_00f9: ldc.i4.m1
    IL_00fa: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_00ff: ldarg.0
    IL_0100: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_0105: ldloc.1
    IL_0106: ldfld float SceneTransitionManager::cloudFadeInTime  /*0x04000C77*/
    IL_010b: ble IL_0060
    IL_0110: ldloc.1
    IL_0111: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_0116: ldloc.1
    IL_0117: ldfld Color SceneTransitionManager::cloudsIn  /*0x04000C86*/
    IL_011c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0121: ldloc.1
    IL_0122: ldfld TMP_Text SceneTransitionManager::loadingText  /*0x04000C76*/
    IL_0127: ldc.r4 1f
    IL_012c: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_0131: ldarg.0
    IL_0132: newobj void System.Collections.Generic.List<UnityEngine.AsyncOperation>::.ctor()  /*0x0A00046B*/
    IL_0137: stfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_013c: ldarg.0
    IL_013d: ldfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<sceneCount>5__2  /*0x04000C91*/
    IL_0142: ldc.i4.0
    IL_0143: ble.s IL_0186
    IL_0145: ldarg.0
    IL_0146: ldfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<sceneCount>5__2  /*0x04000C91*/
    IL_014b: ldc.i4.1
    IL_014c: sub
    IL_014d: stloc.3
    IL_014e: br.s IL_0182
    IL_0150: ldloc.3
    IL_0151: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneAt(int)  /*0x0A000424*/
    IL_0156: stloc.s 4
    IL_0158: ldloca.s 4
    IL_015a: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_015f: ldloc.1
    IL_0160: ldfld string SceneTransitionManager::uiScene  /*0x04000C70*/
    IL_0165: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_016a: brfalse.s IL_017e
    IL_016c: ldarg.0
    IL_016d: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_0172: ldloc.s 4
    IL_0174: call AsyncOperation UnityEngine.SceneManagement.SceneManager::UnloadSceneAsync(UnityEngine.SceneManagement.Scene)  /*0x0A00046C*/
    IL_0179: callvirt void System.Collections.Generic.List<UnityEngine.AsyncOperation>::Add(!0)  /*0x0A00046D*/
    IL_017e: ldloc.3
    IL_017f: ldc.i4.1
    IL_0180: sub
    IL_0181: stloc.3
    IL_0182: ldloc.3
    IL_0183: ldc.i4.0
    IL_0184: bge.s IL_0150
    IL_0186: ldarg.0
    IL_0187: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_018c: ldarg.0
    IL_018d: ldfld string SceneTransitionManager.<SceneTransitionAnimation>d__59::_scenename  /*0x04000C90*/
    IL_0192: ldc.i4.1
    IL_0193: call AsyncOperation UnityEngine.SceneManagement.SceneManager::LoadSceneAsync(string,UnityEngine.SceneManagement.LoadSceneMode)  /*0x0A00046E*/
    IL_0198: callvirt void System.Collections.Generic.List<UnityEngine.AsyncOperation>::Add(!0)  /*0x0A00046D*/
    IL_019d: br.s IL_01f3
    IL_019f: ldarg.0
    IL_01a0: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_01a5: callvirt int System.Collections.Generic.List<UnityEngine.AsyncOperation>::get_Count()  /*0x0A00046F*/
    IL_01aa: ldc.i4.1
    IL_01ab: sub
    IL_01ac: stloc.s 5
    IL_01ae: br.s IL_01d7
    IL_01b0: ldarg.0
    IL_01b1: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_01b6: ldloc.s 5
    IL_01b8: callvirt !0 System.Collections.Generic.List<UnityEngine.AsyncOperation>::get_Item(int)  /*0x0A000470*/
    IL_01bd: callvirt bool UnityEngine.AsyncOperation::get_isDone()  /*0x0A0003C0*/
    IL_01c2: brfalse.s IL_01d1
    IL_01c4: ldarg.0
    IL_01c5: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_01ca: ldloc.s 5
    IL_01cc: callvirt void System.Collections.Generic.List<UnityEngine.AsyncOperation>::RemoveAt(int)  /*0x0A000471*/
    IL_01d1: ldloc.s 5
    IL_01d3: ldc.i4.1
    IL_01d4: sub
    IL_01d5: stloc.s 5
    IL_01d7: ldloc.s 5
    IL_01d9: ldc.i4.0
    IL_01da: bge.s IL_01b0
    IL_01dc: ldarg.0
    IL_01dd: ldnull
    IL_01de: stfld object SceneTransitionManager.<SceneTransitionAnimation>d__59::<>2__current  /*0x04000C8E*/
    IL_01e3: ldarg.0
    IL_01e4: ldc.i4.2
    IL_01e5: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_01ea: ldc.i4.1
    IL_01eb: ret
    IL_01ec: ldarg.0
    IL_01ed: ldc.i4.m1
    IL_01ee: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_01f3: ldarg.0
    IL_01f4: ldfld List<AsyncOperation> SceneTransitionManager.<SceneTransitionAnimation>d__59::<loadOperations>5__4  /*0x04000C93*/
    IL_01f9: callvirt int System.Collections.Generic.List<UnityEngine.AsyncOperation>::get_Count()  /*0x0A00046F*/
    IL_01fe: ldc.i4.0
    IL_01ff: bgt.s IL_019f
    IL_0201: ldarg.0
    IL_0202: ldfld string SceneTransitionManager.<SceneTransitionAnimation>d__59::_scenename  /*0x04000C90*/
    IL_0207: ldstr "_LevelSelect"
    IL_020c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0211: brfalse.s IL_0219
    IL_0213: call AsyncOperation UnityEngine.Resources::UnloadUnusedAssets()  /*0x0A000472*/
    IL_0218: pop
    IL_0219: ldarg.0
    IL_021a: ldfld string SceneTransitionManager.<SceneTransitionAnimation>d__59::_scenename  /*0x04000C90*/
    IL_021f: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneByName(string)  /*0x0A000468*/
    IL_0224: call bool UnityEngine.SceneManagement.SceneManager::SetActiveScene(UnityEngine.SceneManagement.Scene)  /*0x0A000473*/
    IL_0229: pop
    IL_022a: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_022f: callvirt void UIFrameManager::CloseAllFrames()  /*0x0600130A*/
    IL_0234: ldarg.0
    IL_0235: ldfld string SceneTransitionManager.<SceneTransitionAnimation>d__59::_scenename  /*0x04000C90*/
    IL_023a: ldloc.1
    IL_023b: ldfld string SceneTransitionManager::mainMenuScene  /*0x04000C71*/
    IL_0240: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0245: brfalse.s IL_0251
    IL_0247: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_024c: callvirt void UIFrameManager::SwitchToTitleFrame()  /*0x06001300*/
    IL_0251: ldarg.0
    IL_0252: ldc.r4 0f
    IL_0257: stfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_025c: br IL_02f6
    IL_0261: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0266: ldc.r4 0f
    IL_026b: ldc.r4 0.1f
    IL_0270: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0275: stloc.s 6
    IL_0277: ldarg.0
    IL_0278: ldarg.0
    IL_0279: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_027e: ldloc.s 6
    IL_0280: add
    IL_0281: stfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_0286: ldloc.1
    IL_0287: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_028c: ldloc.1
    IL_028d: ldfld Color SceneTransitionManager::cloudsIn  /*0x04000C86*/
    IL_0292: ldloc.1
    IL_0293: ldfld Color SceneTransitionManager::cloudsOut  /*0x04000C87*/
    IL_0298: ldloc.1
    IL_0299: ldarg.0
    IL_029a: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_029f: ldloc.1
    IL_02a0: ldfld float SceneTransitionManager::cloudFadeOutTime  /*0x04000C78*/
    IL_02a5: div
    IL_02a6: call float SceneTransitionManager::FadeFormula(float)  /*0x060009D0*/
    IL_02ab: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_02b0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_02b5: ldloc.1
    IL_02b6: ldfld TMP_Text SceneTransitionManager::loadingText  /*0x04000C76*/
    IL_02bb: ldc.r4 1f
    IL_02c0: ldloc.1
    IL_02c1: ldc.r4 1f
    IL_02c6: ldarg.0
    IL_02c7: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_02cc: ldloc.1
    IL_02cd: ldfld float SceneTransitionManager::cloudFadeInTime  /*0x04000C77*/
    IL_02d2: div
    IL_02d3: sub
    IL_02d4: call float SceneTransitionManager::FadeFormula(float)  /*0x060009D0*/
    IL_02d9: sub
    IL_02da: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_02df: ldarg.0
    IL_02e0: ldnull
    IL_02e1: stfld object SceneTransitionManager.<SceneTransitionAnimation>d__59::<>2__current  /*0x04000C8E*/
    IL_02e6: ldarg.0
    IL_02e7: ldc.i4.3
    IL_02e8: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_02ed: ldc.i4.1
    IL_02ee: ret
    IL_02ef: ldarg.0
    IL_02f0: ldc.i4.m1
    IL_02f1: stfld int SceneTransitionManager.<SceneTransitionAnimation>d__59::<>1__state  /*0x04000C8D*/
    IL_02f6: ldarg.0
    IL_02f7: ldfld float SceneTransitionManager.<SceneTransitionAnimation>d__59::<clock>5__3  /*0x04000C92*/
    IL_02fc: ldloc.1
    IL_02fd: ldfld float SceneTransitionManager::cloudFadeOutTime  /*0x04000C78*/
    IL_0302: ble IL_0261
    IL_0307: ldloc.1
    IL_0308: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_030d: ldloc.1
    IL_030e: ldfld Color SceneTransitionManager::cloudsOut  /*0x04000C87*/
    IL_0313: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0318: ldloc.1
    IL_0319: ldfld TMP_Text SceneTransitionManager::loadingText  /*0x04000C76*/
    IL_031e: ldc.r4 0f
    IL_0323: callvirt void TMPro.TMP_Text::set_alpha(float)  /*0x0A00046A*/
    IL_0328: ldloc.1
    IL_0329: ldfld Image SceneTransitionManager::placeholderCloudsTransition  /*0x04000C75*/
    IL_032e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0333: ldc.i4.0
    IL_0334: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0339: ldloc.1
    IL_033a: ldc.i4.0
    IL_033b: stfld bool SceneTransitionManager::sceneTransitionIsRunning  /*0x04000C85*/
    IL_0340: ldc.i4.0
    IL_0341: ret

  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060009DE rva 0x2e516 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SceneTransitionManager.<SceneTransitionAnimation>d__59::<>2__current  /*0x04000C8E*/
    IL_0006: ret

  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::System.Collections.IEnumerator.Reset()  // token 0x060009DF rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method SceneTransitionManager.<SceneTransitionAnimation>d__59::System.Collections.IEnumerator.get_Current()  // token 0x060009E0 rva 0x2e516 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object SceneTransitionManager.<SceneTransitionAnimation>d__59::<>2__current  /*0x04000C8E*/
    IL_0006: ret

