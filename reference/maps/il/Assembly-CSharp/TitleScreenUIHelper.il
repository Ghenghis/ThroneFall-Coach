// ===== TitleScreenUIHelper  (token 0x0200036A) =====
  .method TitleScreenUIHelper::Update()  // token 0x060012C5 rva 0x5932e attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TitleScreenUIHelper::framesTillYouCanPlay  /*0x0400169E*/
    IL_0007: ldc.r4 1f
    IL_000c: sub
    IL_000d: stfld float TitleScreenUIHelper::framesTillYouCanPlay  /*0x0400169E*/
    IL_0012: ret

  .method TitleScreenUIHelper::ClickPlay()  // token 0x060012C6 rva 0x59344 attrs Public, HideBySig
    // code size 148 (0x94), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float TitleScreenUIHelper::framesTillYouCanPlay  /*0x0400169E*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_000e
    IL_000d: ret
    IL_000e: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0013: ldstr "Neuland(Tutorial)"
    IL_0018: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_001d: ldfld int LevelData::highscoreBest  /*0x04000BC2*/
    IL_0022: ldc.i4.0
    IL_0023: bgt.s IL_003b
    IL_0025: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_002a: ldstr "Neuland(Tutorial)"
    IL_002f: callvirt LevelData LevelProgressManager::GetLevelDataForScene(string)  /*0x0600094A*/
    IL_0034: ldfld bool LevelData::beatenBest  /*0x04000BC1*/
    IL_0039: brfalse.s IL_0050
    IL_003b: ldstr "Start game in level select as tutorial has already been played."
    IL_0040: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0045: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_004a: callvirt void SceneTransitionManager::TransitionFromNullToLevelSelect()  /*0x060009D2*/
    IL_004f: ret
    IL_0050: ldstr "Start it tutorial!"
    IL_0055: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_005a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005f: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0064: callvirt void System.Collections.Generic.List<Equippable>::Clear()  /*0x0A0003CB*/
    IL_0069: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006e: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0073: ldarg.0
    IL_0074: ldfld Equippable TitleScreenUIHelper::tutorialWeapon  /*0x0400169D*/
    IL_0079: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_007e: ldc.i4.0
    IL_007f: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0084: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0089: ldstr "Neuland(Tutorial)"
    IL_008e: callvirt void SceneTransitionManager::TransitionFromNullToLevel(string)  /*0x060009CA*/
    IL_0093: ret

  .method TitleScreenUIHelper::.ctor()  // token 0x060012C7 rva 0x593e4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float TitleScreenUIHelper::framesTillYouCanPlay  /*0x0400169E*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

