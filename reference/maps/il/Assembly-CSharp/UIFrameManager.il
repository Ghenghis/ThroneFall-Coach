// ===== UIFrameManager  (token 0x02000373) =====
  .method UIFrameManager::get_ActiveFrame()  // token 0x060012F9 rva 0x5a870 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0006: ret

  .method UIFrameManager::get_InGameUIContainer()  // token 0x060012FA rva 0x5a878 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform UIFrameManager::inGameUIContainer  /*0x04001709*/
    IL_0006: ret

  .method UIFrameManager::get_OnScreenMarkerContainer()  // token 0x060012FB rva 0x5a880 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform UIFrameManager::onScreenMarkerContainer  /*0x0400170A*/
    IL_0006: ret

  .method UIFrameManager::get_TreasureChest()  // token 0x060012FC rva 0x5a888 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TreasureChestUIHelper UIFrameManager::treasureChest  /*0x0400170B*/
    IL_0006: ret

  .method UIFrameManager::get_EternalTrialsStageDisplay()  // token 0x060012FD rva 0x5a890 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld EternalTrialsStageCountDisplay UIFrameManager::eternalTrialsStageDisplay  /*0x0400170C*/
    IL_0006: ret

  .method UIFrameManager::Awake()  // token 0x060012FE rva 0x5a898 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001f: ret

  .method UIFrameManager::Start()  // token 0x060012FF rva 0x5a8bc attrs Private, HideBySig
    // code size 172 (0xac), max stack 3, init locals
    .locals ([0] List.Enumerator<UIFrame>)
    IL_0000: call int UnityEngine.SceneManagement.SceneManager::get_sceneCount()  /*0x0A000425*/
    IL_0005: ldc.i4.1
    IL_0006: bgt.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld string UIFrameManager::titleFrameSceneName  /*0x040016F7*/
    IL_000e: ldc.i4.1
    IL_000f: call void UnityEngine.SceneManagement.SceneManager::LoadScene(string,UnityEngine.SceneManagement.LoadSceneMode)  /*0x0A0003DB*/
    IL_0014: ldarg.0
    IL_0015: ldfld List<UIFrame> UIFrameManager::frames  /*0x04001706*/
    IL_001a: callvirt List.Enumerator<!0> System.Collections.Generic.List<UIFrame>::GetEnumerator()  /*0x0A000747*/
    IL_001f: stloc.0
    IL_0020: br.s IL_002f
    IL_0022: ldloca.s 0
    IL_0024: call !0 System.Collections.Generic.List.Enumerator<UIFrame>::get_Current()  /*0x0A000748*/
    IL_0029: ldc.i4.0
    IL_002a: callvirt void UIFrame::Deactivate(bool)  /*0x060012F6*/
    IL_002f: ldloca.s 0
    IL_0031: call bool System.Collections.Generic.List.Enumerator<UIFrame>::MoveNext()  /*0x0A000749*/
    IL_0036: brtrue.s IL_0022
    IL_0038: leave.s IL_0048
    IL_003a: ldloca.s 0
    IL_003c: constrained. System.Collections.Generic.List.Enumerator<UIFrame>  /*0x1B000156*/
    IL_0042: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0047: endfinally
    IL_0048: ldarg.0
    IL_0049: ldarg.0
    IL_004a: ldfld string UIFrameManager::titleFrameSceneName  /*0x040016F7*/
    IL_004f: call bool UIFrameManager::IsSceneLoaded(string)  /*0x06001301*/
    IL_0054: brfalse.s IL_005c
    IL_0056: ldarg.0
    IL_0057: call void UIFrameManager::SwitchToTitleFrame()  /*0x06001300*/
    IL_005c: ldarg.0
    IL_005d: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0062: ldc.i4.0
    IL_0063: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0068: stfld Player UIFrameManager::input  /*0x04001707*/
    IL_006d: ldarg.0
    IL_006e: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0073: stfld SceneTransitionManager UIFrameManager::sceneTransitionManager  /*0x0400170E*/
    IL_0078: ldarg.0
    IL_0079: ldfld SceneTransitionManager UIFrameManager::sceneTransitionManager  /*0x0400170E*/
    IL_007e: ldfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_0083: ldarg.0
    IL_0084: ldftn void UIFrameManager::UpdateUIBasedOnCurrentScene()  /*0x06001316*/
    IL_008a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_008f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0094: ldarg.0
    IL_0095: call void UIFrameManager::UpdateUIBasedOnCurrentScene()  /*0x06001316*/
    IL_009a: ldarg.0
    IL_009b: ldfld Texture2D UIFrameManager::defaultCursor  /*0x040016F5*/
    IL_00a0: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00a5: ldc.i4.1
    IL_00a6: call void UnityEngine.Cursor::SetCursor(UnityEngine.Texture2D,UnityEngine.Vector2,UnityEngine.CursorMode)  /*0x0A00074A*/
    IL_00ab: ret
    .try IL_0020-IL_003a finally handler IL_003a-IL_0048

  .method UIFrameManager::SwitchToTitleFrame()  // token 0x06001300 rva 0x5a984 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld UIFrame UIFrameManager::titleFrame  /*0x040016F8*/
    IL_0007: call void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_000c: ret

  .method UIFrameManager::IsSceneLoaded(string)  // token 0x06001301 rva 0x5a994 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] int, [1] Scene)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0020
    IL_0004: ldloc.0
    IL_0005: call Scene UnityEngine.SceneManagement.SceneManager::GetSceneAt(int)  /*0x0A000424*/
    IL_000a: stloc.1
    IL_000b: ldloca.s 1
    IL_000d: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0012: ldarg.1
    IL_0013: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0018: brfalse.s IL_001c
    IL_001a: ldc.i4.1
    IL_001b: ret
    IL_001c: ldloc.0
    IL_001d: ldc.i4.1
    IL_001e: add
    IL_001f: stloc.0
    IL_0020: ldloc.0
    IL_0021: call int UnityEngine.SceneManagement.SceneManager::get_sceneCount()  /*0x0A000425*/
    IL_0026: blt.s IL_0004
    IL_0028: ldc.i4.0
    IL_0029: ret

  .method UIFrameManager::Update()  // token 0x06001302 rva 0x5a9cc attrs Private, HideBySig
    // code size 330 (0x14a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld SceneTransitionManager UIFrameManager::sceneTransitionManager  /*0x0400170E*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001c
    IL_000e: ldarg.0
    IL_000f: ldfld SceneTransitionManager UIFrameManager::sceneTransitionManager  /*0x0400170E*/
    IL_0014: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_0019: brfalse.s IL_001c
    IL_001b: ret
    IL_001c: ldarg.0
    IL_001d: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_0022: ldstr "Pause Menu"
    IL_0027: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_002c: brfalse.s IL_0036
    IL_002e: ldarg.0
    IL_002f: call void UIFrameManager::OpenMenu()  /*0x06001304*/
    IL_0034: br.s IL_004e
    IL_0036: ldarg.0
    IL_0037: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_003c: ldstr "Cancel"
    IL_0041: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0046: brfalse.s IL_004e
    IL_0048: ldarg.0
    IL_0049: call void UIFrameManager::Cancel()  /*0x06001303*/
    IL_004e: ldarg.0
    IL_004f: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_0054: ldstr "Change Colorscheme"
    IL_0059: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_005e: brfalse.s IL_0082
    IL_0060: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0065: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_006a: brfalse.s IL_0082
    IL_006c: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0071: ldfld bool ColorAndLightManager::forbidColorschemeCycle  /*0x0400041F*/
    IL_0076: brtrue.s IL_0082
    IL_0078: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_007d: callvirt void ColorAndLightManager::CycleToNextColorscheme()  /*0x0600036A*/
    IL_0082: ldarg.0
    IL_0083: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_0088: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_008d: callvirt bool Rewired.Player.ControllerHelper::get_hasMouse()  /*0x0A000733*/
    IL_0092: brfalse.s IL_00ee
    IL_0094: ldarg.0
    IL_0095: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_009a: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_009f: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_00a4: callvirt Vector2 Rewired.Mouse::get_screenPositionDelta()  /*0x0A00074B*/
    IL_00a9: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00ae: ldc.r4 0f
    IL_00b3: bgt.s IL_00d6
    IL_00b5: ldarg.0
    IL_00b6: ldfld Player UIFrameManager::input  /*0x04001707*/
    IL_00bb: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_00c0: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_00c5: callvirt Vector2 Rewired.Mouse::get_screenPositionDelta()  /*0x0A00074B*/
    IL_00ca: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_00cf: ldc.r4 0f
    IL_00d4: ble.un.s IL_00ee
    IL_00d6: ldarg.0
    IL_00d7: ldc.r4 0f
    IL_00dc: stfld float UIFrameManager::idleCursorClock  /*0x0400170F*/
    IL_00e1: call bool UnityEngine.Cursor::get_visible()  /*0x0A000734*/
    IL_00e6: brtrue.s IL_00ee
    IL_00e8: ldc.i4.1
    IL_00e9: call void UnityEngine.Cursor::set_visible(bool)  /*0x0A00074C*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_00f4: ldnull
    IL_00f5: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00fa: brtrue.s IL_011c
    IL_00fc: ldarg.0
    IL_00fd: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0102: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0107: ldnull
    IL_0108: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_010d: brtrue.s IL_011c
    IL_010f: ldarg.0
    IL_0110: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0115: callvirt bool UIFrame::get_MouseSleeping()  /*0x060012EB*/
    IL_011a: brfalse.s IL_012e
    IL_011c: ldarg.0
    IL_011d: ldarg.0
    IL_011e: ldfld float UIFrameManager::idleCursorClock  /*0x0400170F*/
    IL_0123: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_0128: add
    IL_0129: stfld float UIFrameManager::idleCursorClock  /*0x0400170F*/
    IL_012e: ldarg.0
    IL_012f: ldfld float UIFrameManager::idleCursorClock  /*0x0400170F*/
    IL_0134: ldarg.0
    IL_0135: ldfld float UIFrameManager::timeBeforeHideIdleCursor  /*0x040016F6*/
    IL_013a: ble.un.s IL_0149
    IL_013c: call bool UnityEngine.Cursor::get_visible()  /*0x0A000734*/
    IL_0141: brfalse.s IL_0149
    IL_0143: ldc.i4.0
    IL_0144: call void UnityEngine.Cursor::set_visible(bool)  /*0x0A00074C*/
    IL_0149: ret

  .method UIFrameManager::Cancel()  // token 0x06001303 rva 0x5ab22 attrs Private, HideBySig
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0034
    IL_000e: ldarg.0
    IL_000f: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0014: ldarg.0
    IL_0015: ldfld UIFrame UIFrameManager::titleFrame  /*0x040016F8*/
    IL_001a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001f: brfalse.s IL_0034
    IL_0021: ldarg.0
    IL_0022: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0027: ldfld bool UIFrame::canNotBeEscaped  /*0x040016DE*/
    IL_002c: brtrue.s IL_0034
    IL_002e: ldarg.0
    IL_002f: call void UIFrameManager::CloseActiveFrame()  /*0x06001309*/
    IL_0034: ret

  .method UIFrameManager::OpenMenu()  // token 0x06001304 rva 0x5ab58 attrs Private, HideBySig
    // code size 121 (0x79), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0022
    IL_000e: ldarg.0
    IL_000f: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0014: ldfld bool UIFrame::canNotBeEscaped  /*0x040016DE*/
    IL_0019: brtrue.s IL_0022
    IL_001b: ldarg.0
    IL_001c: call void UIFrameManager::CloseActiveFrame()  /*0x06001309*/
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0028: ldnull
    IL_0029: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002e: brfalse.s IL_005e
    IL_0030: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0035: callvirt bool SceneTransitionManager::IsInLevelSelect()  /*0x060009D6*/
    IL_003a: brfalse.s IL_005e
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld OverworldPauseFrame UIFrameManager::overworldPauseMenuFrame  /*0x040016F9*/
    IL_0043: call void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0048: ldarg.0
    IL_0049: ldfld OverworldPauseFrame UIFrameManager::overworldPauseMenuFrame  /*0x040016F9*/
    IL_004e: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0053: callvirt bool SceneTransitionManager::IsDLCLevelSelect()  /*0x060009D7*/
    IL_0058: callvirt void OverworldPauseFrame::SetIsInDLCLevelSelect(bool)  /*0x06001177*/
    IL_005d: ret
    IL_005e: ldarg.0
    IL_005f: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0064: ldnull
    IL_0065: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_006a: brfalse.s IL_0078
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld UIFrame UIFrameManager::inMatchPauseMenuFrame  /*0x040016FA*/
    IL_0073: call void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0078: ret

  .method UIFrameManager::RegisterFrame(UIFrame)  // token 0x06001305 rva 0x5abdd attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<UIFrame> UIFrameManager::frames  /*0x04001706*/
    IL_0006: ldarg.1
    IL_0007: callvirt void System.Collections.Generic.List<UIFrame>::Add(!0)  /*0x0A00074D*/
    IL_000c: ret

  .method UIFrameManager::ChangeActiveFrame(UIFrame)  // token 0x06001306 rva 0x5abeb attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldc.i4.1
    IL_0003: ldc.i4.0
    IL_0004: ldnull
    IL_0005: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_000a: ret

  .method UIFrameManager::ChangeActiveFrameKeepOldVisible(UIFrame)  // token 0x06001307 rva 0x5abf7 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldc.i4.1
    IL_0003: ldc.i4.1
    IL_0004: ldnull
    IL_0005: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_000a: ret

  .method UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  // token 0x06001308 rva 0x5ac04 attrs Private, HideBySig
    // code size 267 (0x10b), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0007: brfalse.s IL_0082
    IL_0009: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0026
    IL_0016: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_001b: ldarg.1
    IL_001c: ldfld bool UIFrame::freezePlayer  /*0x040016DD*/
    IL_0021: callvirt void LocalGamestate::SetPlayerFreezeState(bool)  /*0x06000905*/
    IL_0026: ldarg.1
    IL_0027: ldfld bool UIFrame::freezeTime  /*0x040016DC*/
    IL_002c: brfalse.s IL_003a
    IL_002e: ldc.r4 0f
    IL_0033: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_0038: br.s IL_0044
    IL_003a: ldsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_003f: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_0044: ldarg.0
    IL_0045: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_004a: ldnull
    IL_004b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0050: ldarg.2
    IL_0051: and
    IL_0052: brfalse.s IL_0075
    IL_0054: ldarg.0
    IL_0055: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_005a: ldarg.0
    IL_005b: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0060: ldarg.0
    IL_0061: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0066: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_006b: newobj void UIFrameManager.FrameStackElement::.ctor(UIFrame,ThronefallUIElement)  /*0x0600131A*/
    IL_0070: callvirt void System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::Push(!0)  /*0x0A00074E*/
    IL_0075: ldarg.0
    IL_0076: ldfld UnityEvent UIFrameManager::onFrameOpen  /*0x0400170D*/
    IL_007b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0080: br.s IL_00af
    IL_0082: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0087: ldnull
    IL_0088: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_008d: brfalse.s IL_009a
    IL_008f: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0094: ldc.i4.0
    IL_0095: callvirt void LocalGamestate::SetPlayerFreezeState(bool)  /*0x06000905*/
    IL_009a: ldsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_009f: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_00aa: callvirt void System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::Clear()  /*0x0A00074F*/
    IL_00af: ldarg.0
    IL_00b0: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_00b5: ldnull
    IL_00b6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00bb: brfalse.s IL_00f2
    IL_00bd: ldarg.0
    IL_00be: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_00c3: ldarg.0
    IL_00c4: ldfld UIFrame UIFrameManager::choiceFrame  /*0x04001701*/
    IL_00c9: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00ce: brfalse.s IL_00e6
    IL_00d0: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_00d5: callvirt bool ChoiceManager::get_ChoiceCoroutineWaiting()  /*0x0600091D*/
    IL_00da: brfalse.s IL_00e6
    IL_00dc: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_00e1: callvirt void ChoiceManager::CancelChoice()  /*0x0600091F*/
    IL_00e6: ldarg.0
    IL_00e7: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_00ec: ldarg.3
    IL_00ed: callvirt void UIFrame::Deactivate(bool)  /*0x060012F6*/
    IL_00f2: ldarg.1
    IL_00f3: ldnull
    IL_00f4: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00f9: brfalse.s IL_0103
    IL_00fb: ldarg.1
    IL_00fc: ldarg.s 4
    IL_00fe: callvirt void UIFrame::Activate(ThronefallUIElement)  /*0x060012F4*/
    IL_0103: ldarg.0
    IL_0104: ldarg.1
    IL_0105: stfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_010a: ret

  .method UIFrameManager::CloseActiveFrame()  // token 0x06001309 rva 0x5ad1c attrs Public, HideBySig
    // code size 98 (0x62), max stack 5, init locals
    .locals ([0] UIFrameManager.FrameStackElement)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0061
    IL_000e: ldarg.0
    IL_000f: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_0014: callvirt int System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::get_Count()  /*0x0A000750*/
    IL_0019: ldc.i4.0
    IL_001a: ble.s IL_005a
    IL_001c: ldarg.0
    IL_001d: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_0022: callvirt !0 System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::Pop()  /*0x0A000751*/
    IL_0027: stloc.0
    IL_0028: ldloc.0
    IL_0029: ldfld UIFrame UIFrameManager.FrameStackElement::frame  /*0x04001710*/
    IL_002e: ldfld bool UIFrame::storeLastSelectedElementInFrameStack  /*0x040016DB*/
    IL_0033: brfalse.s IL_004a
    IL_0035: ldarg.0
    IL_0036: ldloc.0
    IL_0037: ldfld UIFrame UIFrameManager.FrameStackElement::frame  /*0x04001710*/
    IL_003c: ldc.i4.0
    IL_003d: ldc.i4.0
    IL_003e: ldloc.0
    IL_003f: ldfld ThronefallUIElement UIFrameManager.FrameStackElement::selectedElement  /*0x04001711*/
    IL_0044: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_0049: ret
    IL_004a: ldarg.0
    IL_004b: ldloc.0
    IL_004c: ldfld UIFrame UIFrameManager.FrameStackElement::frame  /*0x04001710*/
    IL_0051: ldc.i4.0
    IL_0052: ldc.i4.0
    IL_0053: ldnull
    IL_0054: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_0059: ret
    IL_005a: ldarg.0
    IL_005b: ldnull
    IL_005c: call void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0061: ret

  .method UIFrameManager::CloseAllFrames()  // token 0x0600130A rva 0x5ad8a attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0020
    IL_000e: ldarg.0
    IL_000f: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_0014: callvirt void System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::Clear()  /*0x0A00074F*/
    IL_0019: ldarg.0
    IL_001a: ldnull
    IL_001b: call void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0020: ret

  .method UIFrameManager::ResetToTileScreen()  // token 0x0600130B rva 0x5adac attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld UIFrame UIFrameManager::titleFrame  /*0x040016F8*/
    IL_0007: ldc.i4.0
    IL_0008: ldc.i4.0
    IL_0009: ldnull
    IL_000a: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_000f: ldarg.0
    IL_0010: ldfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_0015: callvirt void System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::Clear()  /*0x0A00074F*/
    IL_001a: ret

  .method UIFrameManager::QuitToDesktop()  // token 0x0600130C rva 0x5adc8 attrs Public, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: call void UnityEngine.Application::Quit()  /*0x0A00038B*/
    IL_0005: ret

  .method UIFrameManager::TryOpenLevelSelect()  // token 0x0600130D rva 0x5adcf attrs Public, Static, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldc.i4.0
    IL_0013: ret
    IL_0014: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldfld UIFrame UIFrameManager::levelSelectFrame  /*0x040016FB*/
    IL_0023: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0028: ldc.i4.1
    IL_0029: ret

  .method UIFrameManager::ForceOpenLevelSelect()  // token 0x0600130E rva 0x5adfa attrs Public, Static, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_000a: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000f: ldfld UIFrame UIFrameManager::levelSelectFrame  /*0x040016FB*/
    IL_0014: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0019: brfalse.s IL_001c
    IL_001b: ret
    IL_001c: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0021: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0026: ldfld UIFrame UIFrameManager::levelSelectFrame  /*0x040016FB*/
    IL_002b: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0030: ret

  .method UIFrameManager::TryOpenWardrobe()  // token 0x0600130F rva 0x5ae2c attrs Public, Static, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldc.i4.0
    IL_0013: ret
    IL_0014: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldfld UIFrame UIFrameManager::wardrobeFrame  /*0x04001704*/
    IL_0023: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0028: ldc.i4.1
    IL_0029: ret

  .method UIFrameManager::TryOpenBonusLevelSelect()  // token 0x06001310 rva 0x5ae57 attrs Public, Static, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldc.i4.0
    IL_0013: ret
    IL_0014: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldfld UIFrame UIFrameManager::bonusLevelSelectFrame  /*0x040016FC*/
    IL_0023: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0028: ldc.i4.1
    IL_0029: ret

  .method UIFrameManager::TryOpenEternalTrialsSelect()  // token 0x06001311 rva 0x5ae82 attrs Public, Static, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldfld UIFrame UIFrameManager::activeFrame  /*0x04001705*/
    IL_000a: ldnull
    IL_000b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0010: brfalse.s IL_0014
    IL_0012: ldc.i4.0
    IL_0013: ret
    IL_0014: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0019: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_001e: ldfld UIFrame UIFrameManager::eternalTrialsSelectFrame  /*0x040016FD*/
    IL_0023: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0028: ldc.i4.1
    IL_0029: ret

  .method UIFrameManager::OpenEternalTrialsLoadoutPick()  // token 0x06001312 rva 0x5aead attrs Public, Static, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000a: ldfld UIFrame UIFrameManager::eternalTrialsLoadoutPickFrame  /*0x040016FE*/
    IL_000f: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0014: ldc.i4.1
    IL_0015: ret

  .method UIFrameManager::OpenInMapPerkSelect()  // token 0x06001313 rva 0x5aec4 attrs Public, Static, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000a: ldfld UIFrame UIFrameManager::inmatchPerkSelectFrame  /*0x04001703*/
    IL_000f: callvirt void UIFrameManager::ChangeActiveFrame(UIFrame)  /*0x06001306*/
    IL_0014: ldc.i4.1
    IL_0015: ret

  .method UIFrameManager::TriggerEndOfMatch()  // token 0x06001314 rva 0x5aedb attrs Public, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000a: ldfld UIFrame UIFrameManager::endOfMatchFrame  /*0x040016FF*/
    IL_000f: ldc.i4.0
    IL_0010: ldc.i4.0
    IL_0011: ldnull
    IL_0012: callvirt void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_0017: ret

  .method UIFrameManager::ShowLevelUpReward()  // token 0x06001315 rva 0x5aef4 attrs Public, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000a: ldfld UIFrame UIFrameManager::levelUpRewardFrame  /*0x04001700*/
    IL_000f: ldc.i4.1
    IL_0010: ldc.i4.1
    IL_0011: ldnull
    IL_0012: callvirt void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_0017: ret

  .method UIFrameManager::UpdateUIBasedOnCurrentScene()  // token 0x06001316 rva 0x5af10 attrs Private, HideBySig
    // code size 147 (0x93), max stack 2, init locals
    .locals ([0] SceneTransitionManager.SceneState)
    IL_0000: ldarg.0
    IL_0001: ldfld SceneTransitionManager UIFrameManager::sceneTransitionManager  /*0x0400170E*/
    IL_0006: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_000b: stloc.0
    IL_000c: ldloc.0
    IL_000d: switch (IL_0070, IL_004d, IL_001f)
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld TreasureChestUIHelper UIFrameManager::treasureChest  /*0x0400170B*/
    IL_0025: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: ldc.i4.1
    IL_002b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0030: ldarg.0
    IL_0031: ldfld EternalTrialsStageCountDisplay UIFrameManager::eternalTrialsStageDisplay  /*0x0400170C*/
    IL_0036: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_003b: ldc.i4.1
    IL_003c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0041: ldarg.0
    IL_0042: ldfld EternalTrialsStageCountDisplay UIFrameManager::eternalTrialsStageDisplay  /*0x0400170C*/
    IL_0047: callvirt void EternalTrialsStageCountDisplay::Refresh()  /*0x060010D6*/
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: ldfld TreasureChestUIHelper UIFrameManager::treasureChest  /*0x0400170B*/
    IL_0053: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0058: ldc.i4.0
    IL_0059: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005e: ldarg.0
    IL_005f: ldfld EternalTrialsStageCountDisplay UIFrameManager::eternalTrialsStageDisplay  /*0x0400170C*/
    IL_0064: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0069: ldc.i4.0
    IL_006a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006f: ret
    IL_0070: ldarg.0
    IL_0071: ldfld TreasureChestUIHelper UIFrameManager::treasureChest  /*0x0400170B*/
    IL_0076: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_007b: ldc.i4.0
    IL_007c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0081: ldarg.0
    IL_0082: ldfld EternalTrialsStageCountDisplay UIFrameManager::eternalTrialsStageDisplay  /*0x0400170C*/
    IL_0087: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_008c: ldc.i4.0
    IL_008d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0092: ret

  .method UIFrameManager::PresentChoiceFrame()  // token 0x06001317 rva 0x5afaf attrs Public, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld UIFrame UIFrameManager::choiceFrame  /*0x04001701*/
    IL_0007: ldc.i4.0
    IL_0008: ldc.i4.0
    IL_0009: ldnull
    IL_000a: call void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_000f: ret

  .method UIFrameManager::ShowResetControlsFrame()  // token 0x06001318 rva 0x5afc0 attrs Public, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000a: ldfld UIFrame UIFrameManager::resetControlsFrame  /*0x04001702*/
    IL_000f: ldc.i4.1
    IL_0010: ldc.i4.1
    IL_0011: ldnull
    IL_0012: callvirt void UIFrameManager::ProcessFrameChange(UIFrame,bool,bool,ThronefallUIElement)  /*0x06001308*/
    IL_0017: ret

  .method UIFrameManager::.ctor()  // token 0x06001319 rva 0x5afd9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float UIFrameManager::timeBeforeHideIdleCursor  /*0x040016F6*/
    IL_000b: ldarg.0
    IL_000c: ldstr "_StartMenu"
    IL_0011: stfld string UIFrameManager::titleFrameSceneName  /*0x040016F7*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<UIFrame>::.ctor()  /*0x0A000752*/
    IL_001c: stfld List<UIFrame> UIFrameManager::frames  /*0x04001706*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.Stack<UIFrameManager.FrameStackElement>::.ctor()  /*0x0A000753*/
    IL_0027: stfld Stack<UIFrameManager.FrameStackElement> UIFrameManager::frameStack  /*0x04001708*/
    IL_002c: ldarg.0
    IL_002d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0032: stfld UnityEvent UIFrameManager::onFrameOpen  /*0x0400170D*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

// ===== UIFrameManager/FrameStackElement  (token 0x02000374) =====
  .method UIFrameManager.FrameStackElement::.ctor(UIFrame,ThronefallUIElement)  // token 0x0600131A rva 0x5b018 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld UIFrame UIFrameManager.FrameStackElement::frame  /*0x04001710*/
    IL_0007: ldarg.0
    IL_0008: ldarg.2
    IL_0009: stfld ThronefallUIElement UIFrameManager.FrameStackElement::selectedElement  /*0x04001711*/
    IL_000e: ret

