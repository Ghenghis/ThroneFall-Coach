// ===== LevelSelectManager  (token 0x020001AB) =====
  .method LevelSelectManager::get_ShowingTooltipFor()  // token 0x060008AF rva 0x29e90 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable LevelSelectManager::showingTooltipFor  /*0x04000AE3*/
    IL_0006: ret

  .method LevelSelectManager::ShowTooltip(Equippable)  // token 0x060008B0 rva 0x29e98 attrs Public, HideBySig
    // code size 154 (0x9a), max stack 3, init locals
    .locals ([0] float, [1] Rect)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Equippable LevelSelectManager::showingTooltipFor  /*0x04000AE3*/
    IL_0007: ldarg.0
    IL_0008: ldfld GameObject LevelSelectManager::tooltipObject  /*0x04000ADF*/
    IL_000d: ldarg.1
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldarg.1
    IL_001a: ldnull
    IL_001b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0020: brfalse.s IL_0023
    IL_0022: ret
    IL_0023: ldarg.0
    IL_0024: ldfld Image LevelSelectManager::tooltipImage  /*0x04000AE0*/
    IL_0029: ldarg.1
    IL_002a: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_002f: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0034: ldarg.0
    IL_0035: ldfld TMP_Text LevelSelectManager::tooltipTitle  /*0x04000AE1*/
    IL_003a: ldarg.1
    IL_003b: ldfld string Equippable::displayName  /*0x04000E2B*/
    IL_0040: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0045: ldarg.0
    IL_0046: ldfld TMP_Text LevelSelectManager::tooltipDescription  /*0x04000AE2*/
    IL_004b: ldarg.1
    IL_004c: ldfld string Equippable::description  /*0x04000E2C*/
    IL_0051: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0056: ldarg.0
    IL_0057: ldfld Camera LevelSelectManager::camMain  /*0x04000AE5*/
    IL_005c: callvirt Rect UnityEngine.Camera::get_pixelRect()  /*0x0A0003C7*/
    IL_0061: stloc.1
    IL_0062: ldloca.s 1
    IL_0064: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0069: ldarg.0
    IL_006a: ldfld Canvas LevelSelectManager::levelSelectedCanvas  /*0x04000AE4*/
    IL_006f: callvirt Rect UnityEngine.Canvas::get_pixelRect()  /*0x0A0003C9*/
    IL_0074: stloc.1
    IL_0075: ldloca.s 1
    IL_0077: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_007c: div
    IL_007d: stloc.0
    IL_007e: ldarg.0
    IL_007f: ldfld GameObject LevelSelectManager::tooltipObject  /*0x04000ADF*/
    IL_0084: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0089: call Vector3 UnityEngine.Input::get_mousePosition()  /*0x0A0003CA*/
    IL_008e: ldloc.0
    IL_008f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0094: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0099: ret

  .method LevelSelectManager::get_PreLevelMenuIsOpen()  // token 0x060008B1 rva 0x29f3e attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LevelInteractor LevelSelectManager::openedLevel  /*0x04000AE6*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: ret

  .method LevelSelectManager::Awake()  // token 0x060008B2 rva 0x29f4c attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld LevelSelectManager LevelSelectManager::instance  /*0x04000AD4*/
    IL_0006: ret

  .method LevelSelectManager::Start()  // token 0x060008B3 rva 0x29f54 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0[] UnityEngine.Component::GetComponentsInChildren()<LevelInteractor>  /*0x2B000094*/
    IL_0007: stfld LevelInteractor[] LevelSelectManager::levelInteractors  /*0x04000AD5*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0[] UnityEngine.Component::GetComponentsInChildren()<BonusLevelInteractor>  /*0x2B000095*/
    IL_0013: stfld BonusLevelInteractor[] LevelSelectManager::bonusLevelInteractors  /*0x04000AD6*/
    IL_0018: ldarg.0
    IL_0019: ldnull
    IL_001a: call void LevelSelectManager::ShowTooltip(Equippable)  /*0x060008B0*/
    IL_001f: ret

  .method LevelSelectManager::MovePlayerToTheLevelYouCameFrom()  // token 0x060008B4 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LevelSelectManager::PlayButtonPressed()  // token 0x060008B5 rva 0x29f78 attrs Public, HideBySig
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call bool LevelSelectManager::get_PreLevelMenuIsOpen()  /*0x060008B1*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld LevelInteractor LevelSelectManager::openedLevel  /*0x04000AE6*/
    IL_000f: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0014: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0019: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_001e: ldc.i4.0
    IL_001f: ble.s IL_004f
    IL_0021: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0026: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_002b: callvirt void System.Collections.Generic.List<Equippable>::Clear()  /*0x0A0003CB*/
    IL_0030: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0035: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_003a: ldarg.0
    IL_003b: ldfld LevelInteractor LevelSelectManager::openedLevel  /*0x04000AE6*/
    IL_0040: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0045: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_004a: callvirt void System.Collections.Generic.List<Equippable>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0003CC*/
    IL_004f: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0054: ldarg.0
    IL_0055: ldfld LevelInteractor LevelSelectManager::openedLevel  /*0x04000AE6*/
    IL_005a: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_005f: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0064: callvirt void SceneTransitionManager::TransitionFromLevelSelectToLevel(string)  /*0x060009C9*/
    IL_0069: ret

  .method LevelSelectManager::.ctor()  // token 0x060008B6 rva 0x29fee attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "Not beaten yet."
    IL_0006: stfld string LevelSelectManager::notBeatenYet  /*0x04000ADC*/
    IL_000b: ldarg.0
    IL_000c: ldstr "Successfully beaten."
    IL_0011: stfld string LevelSelectManager::successfullyBeaten  /*0x04000ADD*/
    IL_0016: ldarg.0
    IL_0017: ldstr "Your Best: "
    IL_001c: stfld string LevelSelectManager::scorePrefix  /*0x04000ADE*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

