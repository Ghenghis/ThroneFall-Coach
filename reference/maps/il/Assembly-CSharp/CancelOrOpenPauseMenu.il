// ===== CancelOrOpenPauseMenu  (token 0x020001C3) =====
  .method CancelOrOpenPauseMenu::Start()  // token 0x0600091A rva 0x2b800 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player CancelOrOpenPauseMenu::input  /*0x04000B85*/
    IL_0011: ldarg.0
    IL_0012: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0017: stfld ChoiceManager CancelOrOpenPauseMenu::choiceManager  /*0x04000B86*/
    IL_001c: ret

  .method CancelOrOpenPauseMenu::Update()  // token 0x0600091B rva 0x2b820 attrs Private, HideBySig
    // code size 67 (0x43), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player CancelOrOpenPauseMenu::input  /*0x04000B85*/
    IL_0006: ldstr "Pause Menu & Cancel"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_0042
    IL_0012: ldarg.0
    IL_0013: ldfld ChoiceManager CancelOrOpenPauseMenu::choiceManager  /*0x04000B86*/
    IL_0018: callvirt bool ChoiceManager::get_ChoiceCoroutineRunning()  /*0x0600091E*/
    IL_001d: brfalse.s IL_002b
    IL_001f: ldarg.0
    IL_0020: ldfld ChoiceManager CancelOrOpenPauseMenu::choiceManager  /*0x04000B86*/
    IL_0025: callvirt void ChoiceManager::CancelChoice()  /*0x0600091F*/
    IL_002a: ret
    IL_002b: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0030: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_0035: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_003a: ldc.i4.0
    IL_003b: ldc.i4.0
    IL_003c: ldc.i4.0
    IL_003d: callvirt void SceneTransitionManager::TransitionFromGameplayToEndScreen(int,int,int,int)  /*0x060009CD*/
    IL_0042: ret

  .method CancelOrOpenPauseMenu::.ctor()  // token 0x0600091C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

