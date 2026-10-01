// ===== TFUIEnumSelectorButton  (token 0x0200034C) =====
  .method TFUIEnumSelectorButton::OnApply()  // token 0x060011EF rva 0x565f0 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEnumSelectorButton::targetGraphic  /*0x040015A3*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEnumSelectorButton::highlightColor  /*0x040015A5*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUIEnumSelectorButton::OnClear()  // token 0x060011F0 rva 0x56603 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEnumSelectorButton::targetGraphic  /*0x040015A3*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEnumSelectorButton::defaultColor  /*0x040015A4*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUIEnumSelectorButton::OnFocus()  // token 0x060011F1 rva 0x565f0 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEnumSelectorButton::targetGraphic  /*0x040015A3*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEnumSelectorButton::highlightColor  /*0x040015A5*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUIEnumSelectorButton::OnFocusAndSelect()  // token 0x060011F2 rva 0x565f0 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEnumSelectorButton::targetGraphic  /*0x040015A3*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEnumSelectorButton::highlightColor  /*0x040015A5*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUIEnumSelectorButton::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x060011F3 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumSelectorButton::OnSelect()  // token 0x060011F4 rva 0x565f0 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEnumSelectorButton::targetGraphic  /*0x040015A3*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEnumSelectorButton::highlightColor  /*0x040015A5*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUIEnumSelectorButton::.ctor()  // token 0x060011F5 rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

