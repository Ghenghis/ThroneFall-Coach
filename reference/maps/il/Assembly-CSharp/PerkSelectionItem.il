// ===== PerkSelectionItem  (token 0x020001AE) =====
  .method PerkSelectionItem::get_Equippable()  // token 0x060008BC rva 0x2a4df attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkSelectionItem::equippable  /*0x04000B03*/
    IL_0006: ret

  .method PerkSelectionItem::OnPointerEnter(UnityEngine.EventSystems.PointerEventData)  // token 0x060008BD rva 0x2a4e7 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool PerkSelectionItem::mouseIsOver  /*0x04000B02*/
    IL_0007: ret

  .method PerkSelectionItem::OnPointerExit(UnityEngine.EventSystems.PointerEventData)  // token 0x060008BE rva 0x2a4f0 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool PerkSelectionItem::mouseIsOver  /*0x04000B02*/
    IL_0007: ldarg.0
    IL_0008: ldfld LevelSelectManager PerkSelectionItem::levelSelectManager  /*0x04000AFC*/
    IL_000d: callvirt Equippable LevelSelectManager::get_ShowingTooltipFor()  /*0x060008AF*/
    IL_0012: ldarg.0
    IL_0013: ldfld Equippable PerkSelectionItem::equippable  /*0x04000B03*/
    IL_0018: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001d: brfalse.s IL_002b
    IL_001f: ldarg.0
    IL_0020: ldfld LevelSelectManager PerkSelectionItem::levelSelectManager  /*0x04000AFC*/
    IL_0025: ldnull
    IL_0026: callvirt void LevelSelectManager::ShowTooltip(Equippable)  /*0x060008B0*/
    IL_002b: ret

  .method PerkSelectionItem::get_Selected()  // token 0x060008BF rva 0x2a51d attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PerkSelectionItem::selectedMarker  /*0x04000AFD*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: ret

  .method PerkSelectionItem::set_Selected(bool)  // token 0x060008C0 rva 0x2a52a attrs Public, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PerkSelectionItem::selectedMarker  /*0x04000AFD*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method PerkSelectionItem::Update()  // token 0x060008C1 rva 0x2a538 attrs Private, HideBySig
    // code size 100 (0x64), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image PerkSelectionItem::image  /*0x04000B00*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool PerkSelectionItem::mouseIsOver  /*0x04000B02*/
    IL_000c: brtrue.s IL_0016
    IL_000e: ldarg.0
    IL_000f: ldfld Color PerkSelectionItem::colorBasic  /*0x04000AFF*/
    IL_0014: br.s IL_001c
    IL_0016: ldarg.0
    IL_0017: ldfld Color PerkSelectionItem::hoverColor  /*0x04000B01*/
    IL_001c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0021: ldarg.0
    IL_0022: ldfld bool PerkSelectionItem::mouseIsOver  /*0x04000B02*/
    IL_0027: brfalse.s IL_003a
    IL_0029: ldarg.0
    IL_002a: ldfld LevelSelectManager PerkSelectionItem::levelSelectManager  /*0x04000AFC*/
    IL_002f: ldarg.0
    IL_0030: ldfld Equippable PerkSelectionItem::equippable  /*0x04000B03*/
    IL_0035: callvirt void LevelSelectManager::ShowTooltip(Equippable)  /*0x060008B0*/
    IL_003a: ldc.i4.0
    IL_003b: call bool UnityEngine.Input::GetMouseButtonDown(int)  /*0x0A0003D5*/
    IL_0040: brfalse.s IL_0063
    IL_0042: ldarg.0
    IL_0043: ldfld bool PerkSelectionItem::mouseIsOver  /*0x04000B02*/
    IL_0048: brfalse.s IL_0063
    IL_004a: ldarg.0
    IL_004b: ldfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_0050: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0055: brfalse.s IL_0063
    IL_0057: ldarg.0
    IL_0058: ldfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_005d: ldarg.0
    IL_005e: callvirt void PerkSelectionGroup::SelectPerk(PerkSelectionItem)  /*0x060008BA*/
    IL_0063: ret

  .method PerkSelectionItem::Initialize(Equippable)  // token 0x060008C2 rva 0x2a5a8 attrs Public, HideBySig
    // code size 136 (0x88), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.Image>  /*0x2B000097*/
    IL_0007: stfld Image PerkSelectionItem::image  /*0x04000B00*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Image PerkSelectionItem::image  /*0x04000B00*/
    IL_0013: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0018: stfld Color PerkSelectionItem::colorBasic  /*0x04000AFF*/
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: call !!0 UnityEngine.Component::GetComponentInParent()<PerkSelectionGroup>  /*0x2B000098*/
    IL_0024: stfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_0029: ldarg.0
    IL_002a: ldfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_002f: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0034: ldarg.0
    IL_0035: ldsfld LevelSelectManager LevelSelectManager::instance  /*0x04000AD4*/
    IL_003a: stfld LevelSelectManager PerkSelectionItem::levelSelectManager  /*0x04000AFC*/
    IL_003f: ldarg.0
    IL_0040: ldfld Image PerkSelectionItem::image  /*0x04000B00*/
    IL_0045: ldarg.1
    IL_0046: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_004b: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0050: ldarg.0
    IL_0051: ldarg.1
    IL_0052: stfld Equippable PerkSelectionItem::equippable  /*0x04000B03*/
    IL_0057: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005c: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0061: ldarg.0
    IL_0062: ldfld Equippable PerkSelectionItem::equippable  /*0x04000B03*/
    IL_0067: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_006c: brfalse.s IL_0087
    IL_006e: ldarg.0
    IL_006f: ldfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_0074: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0079: brfalse.s IL_0087
    IL_007b: ldarg.0
    IL_007c: ldfld PerkSelectionGroup PerkSelectionItem::perkSelectionGroup  /*0x04000AFE*/
    IL_0081: ldarg.0
    IL_0082: callvirt void PerkSelectionGroup::SelectPerk(PerkSelectionItem)  /*0x060008BA*/
    IL_0087: ret

  .method PerkSelectionItem::.ctor()  // token 0x060008C3 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

