// ===== EndscreenRetryHelper  (token 0x02000302) =====
  .method EndscreenRetryHelper::InstantRestartIfInSaveForbiddenMap()  // token 0x060010A8 rva 0x4c978 attrs Public, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: call bool MatchSaveLoadHandler::get_SaveLoadForbidden()  /*0x06000CF0*/
    IL_0005: brfalse.s IL_002d
    IL_0007: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000c: callvirt void UIFrameManager::CloseAllFrames()  /*0x0600130A*/
    IL_0011: ldarg.0
    IL_0012: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0017: ldc.i4.0
    IL_0018: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001d: ldc.i4.1
    IL_001e: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0023: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0028: callvirt void SceneTransitionManager::RestartCurrentLevel()  /*0x060009CB*/
    IL_002d: ret

  .method EndscreenRetryHelper::FreshStart()  // token 0x060010A9 rva 0x4c9a7 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0006: call bool UIFrameManager::OpenInMapPerkSelect()  /*0x06001313*/
    IL_000b: pop
    IL_000c: ret

  .method EndscreenRetryHelper::RestartLastDay()  // token 0x060010AA rva 0x4c9b5 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_000a: ldc.i4.0
    IL_000b: ble.s IL_001d
    IL_000d: ldc.i4.0
    IL_000e: stsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_0013: call MatchSave MatchSaveLoadHandler::get_CurrentSave()  /*0x06000CF1*/
    IL_0018: callvirt void MatchSave::ApplyLoadout()  /*0x06000D05*/
    IL_001d: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0022: callvirt void SceneTransitionManager::RestartCurrentLevel()  /*0x060009CB*/
    IL_0027: ret

  .method EndscreenRetryHelper::.ctor()  // token 0x060010AB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

