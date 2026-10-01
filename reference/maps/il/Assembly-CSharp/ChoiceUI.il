// ===== ChoiceUI  (token 0x020002E1) =====
  .method ChoiceUI::get_IsUnlocked()  // token 0x06000FDA rva 0x486d0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_0006: ret

  .method ChoiceUI::SetChoice(Choice)  // token 0x06000FDB rva 0x486d8 attrs Public, HideBySig
    // code size 152 (0x98), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldfld EquippableBuildingUpgrade Choice::requiresUnlocked  /*0x04000B96*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0016
    IL_000d: ldarg.0
    IL_000e: ldc.i4.1
    IL_000f: stfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_0014: br.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldarg.1
    IL_0018: callvirt bool Choice::get_CanBePicked()  /*0x0600092A*/
    IL_001d: stfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_0022: ldarg.1
    IL_0023: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_0028: brfalse.s IL_0031
    IL_002a: ldarg.0
    IL_002b: ldc.i4.0
    IL_002c: stfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_0031: ldarg.0
    IL_0032: ldfld GameObject ChoiceUI::unlocked  /*0x040012B2*/
    IL_0037: ldarg.0
    IL_0038: ldfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_003d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0042: ldarg.0
    IL_0043: ldfld GameObject ChoiceUI::locked  /*0x040012B3*/
    IL_0048: ldarg.0
    IL_0049: ldfld bool ChoiceUI::isunlocked  /*0x040012B4*/
    IL_004e: ldc.i4.0
    IL_004f: ceq
    IL_0051: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0056: ldarg.0
    IL_0057: ldarg.1
    IL_0058: stfld Choice ChoiceUI::choice  /*0x040012AD*/
    IL_005d: ldarg.0
    IL_005e: ldfld TMP_Text ChoiceUI::title  /*0x040012AE*/
    IL_0063: ldarg.1
    IL_0064: ldfld string Choice::name  /*0x04000B92*/
    IL_0069: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_006e: ldarg.0
    IL_006f: ldfld TMP_Text ChoiceUI::description  /*0x040012AF*/
    IL_0074: ldarg.1
    IL_0075: ldfld string Choice::tooltip  /*0x04000B93*/
    IL_007a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007f: ldarg.0
    IL_0080: ldfld Image ChoiceUI::icon  /*0x040012B1*/
    IL_0085: ldarg.1
    IL_0086: ldfld Sprite Choice::icon  /*0x04000B94*/
    IL_008b: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0090: ldarg.0
    IL_0091: ldc.i4.0
    IL_0092: call void ChoiceUI::SetHighlighted(bool)  /*0x06000FDC*/
    IL_0097: ret

  .method ChoiceUI::SetHighlighted(bool)  // token 0x06000FDC rva 0x4877c attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ChoiceUI::selected  /*0x040012B0*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method ChoiceUI::.ctor()  // token 0x06000FDD rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

