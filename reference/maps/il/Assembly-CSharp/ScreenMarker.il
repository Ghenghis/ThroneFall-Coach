// ===== ScreenMarker  (token 0x02000262) =====
  .method ScreenMarker::get_MyRandomVal()  // token 0x06000D24 rva 0x3c135 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ScreenMarker::myRandomVal  /*0x04000FBD*/
    IL_0006: ret

  .method ScreenMarker::get_UnclampedScreenPos()  // token 0x06000D25 rva 0x3c13d attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector2 ScreenMarker::unclampedScreenPos  /*0x04000FBE*/
    IL_0006: ret

  .method ScreenMarker::set_UnclampedScreenPos(UnityEngine.Vector2)  // token 0x06000D26 rva 0x3c145 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector2 ScreenMarker::unclampedScreenPos  /*0x04000FBE*/
    IL_0007: ret

  .method ScreenMarker::get_ClampedScreenPos()  // token 0x06000D27 rva 0x3c14e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector2 ScreenMarker::clampedScreenPos  /*0x04000FBF*/
    IL_0006: ret

  .method ScreenMarker::set_ClampedScreenPos(UnityEngine.Vector2)  // token 0x06000D28 rva 0x3c156 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector2 ScreenMarker::clampedScreenPos  /*0x04000FBF*/
    IL_0007: ret

  .method ScreenMarker::get_OnScreen()  // token 0x06000D29 rva 0x3c15f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScreenMarker::onScreen  /*0x04000FC4*/
    IL_0006: ret

  .method ScreenMarker::set_OnScreen(bool)  // token 0x06000D2A rva 0x3c167 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool ScreenMarker::onScreen  /*0x04000FC4*/
    IL_0007: ret

  .method ScreenMarker::get_Initialised()  // token 0x06000D2B rva 0x3c170 attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Camera ScreenMarker::cam  /*0x04000FBA*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: ret

  .method ScreenMarker::Start()  // token 0x06000D2C rva 0x3c180 attrs Private, HideBySig
    // code size 242 (0xf2), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0006: stfld Camera ScreenMarker::cam  /*0x04000FBA*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject ScreenMarker::screenMarkerPrefab  /*0x04000FB5*/
    IL_0012: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0017: callvirt RectTransform UIFrameManager::get_OnScreenMarkerContainer()  /*0x060012FB*/
    IL_001c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0021: stfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0026: ldarg.0
    IL_0027: ldarg.0
    IL_0028: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_002d: callvirt !!0 UnityEngine.GameObject::GetComponent()<EnemyScreenMarkerUIHelper>  /*0x2B0000C5*/
    IL_0032: stfld EnemyScreenMarkerUIHelper ScreenMarker::uiMarkerData  /*0x04000FB8*/
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: ldfld EnemyScreenMarkerUIHelper ScreenMarker::uiMarkerData  /*0x04000FB8*/
    IL_003e: ldfld MPImageBasic EnemyScreenMarkerUIHelper::enemyIcon  /*0x040013C9*/
    IL_0043: stfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0048: ldarg.0
    IL_0049: ldarg.0
    IL_004a: ldfld EnemyScreenMarkerUIHelper ScreenMarker::uiMarkerData  /*0x04000FB8*/
    IL_004f: ldfld TextMeshProUGUI EnemyScreenMarkerUIHelper::enemyNumber  /*0x040013CA*/
    IL_0054: stfld TMP_Text ScreenMarker::enemyNumber  /*0x04000FBC*/
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0060: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0065: castclass UnityEngine.RectTransform  /*0x01000020*/
    IL_006a: stfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_006f: ldarg.0
    IL_0070: ldarg.0
    IL_0071: ldfld Sprite ScreenMarker::showSprite  /*0x04000FB2*/
    IL_0076: call void ScreenMarker::SetSprite(UnityEngine.Sprite)  /*0x06000D2F*/
    IL_007b: ldarg.0
    IL_007c: ldarg.0
    IL_007d: ldfld int ScreenMarker::showNumber  /*0x04000FB3*/
    IL_0082: call void ScreenMarker::SetNumber(int)  /*0x06000D34*/
    IL_0087: ldarg.0
    IL_0088: ldarg.0
    IL_0089: ldfld bool ScreenMarker::showElite  /*0x04000FB4*/
    IL_008e: call void ScreenMarker::SetElite(bool)  /*0x06000D32*/
    IL_0093: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_0098: ldarg.0
    IL_0099: callvirt void ScreenMarkerManager::RegisterScreenMarker(ScreenMarker)  /*0x06000D47*/
    IL_009e: ldarg.0
    IL_009f: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00a4: stfld float ScreenMarker::myRandomVal  /*0x04000FBD*/
    IL_00a9: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00ae: ldfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_00b3: ldarg.0
    IL_00b4: ldftn void ScreenMarker::KillOnSceneChange()  /*0x06000D39*/
    IL_00ba: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00bf: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00c4: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_00c9: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00ce: brfalse.s IL_00d6
    IL_00d0: ldarg.0
    IL_00d1: call void ScreenMarker::RefreshSprite()  /*0x06000D2E*/
    IL_00d6: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_00db: ldfld UnityEvent SettingsManager::onArachnophobiaModeChange  /*0x04000FF8*/
    IL_00e0: ldarg.0
    IL_00e1: ldftn void ScreenMarker::RefreshSprite()  /*0x06000D2E*/
    IL_00e7: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00ec: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00f1: ret

  .method ScreenMarker::SetEnemyPrefab(UnityEngine.GameObject)  // token 0x06000D2D rva 0x3c27e attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld GameObject ScreenMarker::enemyPrefab  /*0x04000FB6*/
    IL_0007: ret

  .method ScreenMarker::RefreshSprite()  // token 0x06000D2E rva 0x3c288 attrs Public, HideBySig
    // code size 56 (0x38), max stack 2, init locals
    .locals ([0] ScreenMarkerIconArachnophobia, [1] Sprite)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::enemyPrefab  /*0x04000FB6*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0037
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ScreenMarker::enemyPrefab  /*0x04000FB6*/
    IL_0014: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIconArachnophobia>  /*0x2B000060*/
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: ldnull
    IL_001c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0021: brfalse.s IL_0037
    IL_0023: ldloc.0
    IL_0024: callvirt void ScreenMarkerIconArachnophobia::Refresh()  /*0x06000025*/
    IL_0029: ldloc.0
    IL_002a: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_002f: stloc.1
    IL_0030: ldarg.0
    IL_0031: ldloc.1
    IL_0032: call void ScreenMarker::SetSprite(UnityEngine.Sprite)  /*0x06000D2F*/
    IL_0037: ret

  .method ScreenMarker::SetSprite(UnityEngine.Sprite)  // token 0x06000D2F rva 0x3c2cc attrs Public, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldarg.1
    IL_000c: stfld Sprite ScreenMarker::showSprite  /*0x04000FB2*/
    IL_0011: ldarg.0
    IL_0012: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0017: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001c: brfalse.s IL_002a
    IL_001e: ldarg.0
    IL_001f: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0024: ldarg.1
    IL_0025: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_002a: ret

  .method ScreenMarker::Show(bool)  // token 0x06000D30 rva 0x3c2f8 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0027
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0013: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0018: ldarg.1
    IL_0019: beq.s IL_0027
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0021: ldarg.1
    IL_0022: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0027: ret

  .method ScreenMarker::get_Sprite()  // token 0x06000D31 rva 0x3c321 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Sprite ScreenMarker::showSprite  /*0x04000FB2*/
    IL_0006: ret

  .method ScreenMarker::SetElite(bool)  // token 0x06000D32 rva 0x3c329 attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool ScreenMarker::showElite  /*0x04000FB4*/
    IL_0007: ldarg.0
    IL_0008: ldfld EnemyScreenMarkerUIHelper ScreenMarker::uiMarkerData  /*0x04000FB8*/
    IL_000d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0012: brfalse.s IL_0020
    IL_0014: ldarg.0
    IL_0015: ldfld EnemyScreenMarkerUIHelper ScreenMarker::uiMarkerData  /*0x04000FB8*/
    IL_001a: ldarg.1
    IL_001b: callvirt void EnemyScreenMarkerUIHelper::SetElite(bool)  /*0x060010AC*/
    IL_0020: ret

  .method ScreenMarker::get_Elite()  // token 0x06000D33 rva 0x3c34b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScreenMarker::showElite  /*0x04000FB4*/
    IL_0006: ret

  .method ScreenMarker::SetNumber(int)  // token 0x06000D34 rva 0x3c353 attrs Public, HideBySig
    // code size 63 (0x3f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int ScreenMarker::showNumber  /*0x04000FB3*/
    IL_0007: ldarg.0
    IL_0008: ldfld TMP_Text ScreenMarker::enemyNumber  /*0x04000FBC*/
    IL_000d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0012: brfalse.s IL_003e
    IL_0014: ldarg.0
    IL_0015: ldfld TMP_Text ScreenMarker::enemyNumber  /*0x04000FBC*/
    IL_001a: ldarg.0
    IL_001b: ldflda int ScreenMarker::showNumber  /*0x04000FB3*/
    IL_0020: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0025: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_002a: ldarg.0
    IL_002b: ldfld TMP_Text ScreenMarker::enemyNumber  /*0x04000FBC*/
    IL_0030: ldarg.0
    IL_0031: ldfld int ScreenMarker::showNumber  /*0x04000FB3*/
    IL_0036: ldc.i4.0
    IL_0037: cgt
    IL_0039: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003e: ret

  .method ScreenMarker::get_Number()  // token 0x06000D35 rva 0x3c393 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int ScreenMarker::showNumber  /*0x04000FB3*/
    IL_0006: ret

  .method ScreenMarker::OnEnable()  // token 0x06000D36 rva 0x3c39b attrs Private, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0013: ldc.i4.1
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_001e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0023: brfalse.s IL_0030
    IL_0025: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_002a: ldarg.0
    IL_002b: callvirt void ScreenMarkerManager::RegisterScreenMarker(ScreenMarker)  /*0x06000D47*/
    IL_0030: ret

  .method ScreenMarker::OnDisable()  // token 0x06000D37 rva 0x3c3cd attrs Private, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0013: ldc.i4.0
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_001e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0023: brfalse.s IL_0030
    IL_0025: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_002a: ldarg.0
    IL_002b: callvirt void ScreenMarkerManager::UnregisterScreenMarker(ScreenMarker)  /*0x06000D48*/
    IL_0030: ret

  .method ScreenMarker::OnDestroy()  // token 0x06000D38 rva 0x3c3ff attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0018
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ldsfld ScreenMarkerManager ScreenMarkerManager::instance  /*0x04000FC8*/
    IL_001d: ldarg.0
    IL_001e: callvirt void ScreenMarkerManager::UnregisterScreenMarker(ScreenMarker)  /*0x06000D48*/
    IL_0023: ret

  .method ScreenMarker::KillOnSceneChange()  // token 0x06000D39 rva 0x3c424 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScreenMarker::myUiMarkerGameObject  /*0x04000FB7*/
    IL_0006: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_000b: ldarg.0
    IL_000c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0016: ret

  .method ScreenMarker::get_Position()  // token 0x06000D3A rva 0x3c43c attrs Public, HideBySig, SpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_001e
    IL_000d: ldarg.0
    IL_000e: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0013: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0018: call Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)  /*0x0A000575*/
    IL_001d: ret
    IL_001e: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_0023: ret

  .method ScreenMarker::set_Position(UnityEngine.Vector2)  // token 0x06000D3B rva 0x3c461 attrs Public, HideBySig, SpecialName
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_001e
    IL_000d: ldarg.0
    IL_000e: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0013: ldarg.1
    IL_0014: call Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)  /*0x0A0001CF*/
    IL_0019: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_001e: ret

  .method ScreenMarker::get_ImageRotation()  // token 0x06000D3C rva 0x3c481 attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0006: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000b: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0010: ldfld float UnityEngine.Quaternion::z  /*0x0A000576*/
    IL_0015: ret

  .method ScreenMarker::set_ImageRotation(float)  // token 0x06000D3D rva 0x3c498 attrs Public, HideBySig, SpecialName
    // code size 65 (0x41), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0006: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000b: ldarg.0
    IL_000c: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0011: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0016: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_001b: ldfld float UnityEngine.Quaternion::x  /*0x0A000577*/
    IL_0020: ldarg.0
    IL_0021: ldfld MPImageBasic ScreenMarker::enemyIcon  /*0x04000FBB*/
    IL_0026: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002b: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0030: ldfld float UnityEngine.Quaternion::y  /*0x0A000578*/
    IL_0035: ldarg.1
    IL_0036: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_003b: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0040: ret

  .method ScreenMarker::get_Rect()  // token 0x06000D3E rva 0x3c4e8 attrs Public, HideBySig, SpecialName
    // code size 35 (0x23), max stack 1, init locals
    .locals ([0] Rect)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld RectTransform ScreenMarker::screenMarkerUI  /*0x04000FB9*/
    IL_0013: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_0018: ret
    IL_0019: ldloca.s 0
    IL_001b: initobj UnityEngine.Rect  /*0x01000027*/
    IL_0021: ldloc.0
    IL_0022: ret

  .method ScreenMarker::.ctor()  // token 0x06000D3F rva 0x3c517 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_000e: ldarg.0
    IL_000f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0014: ret

