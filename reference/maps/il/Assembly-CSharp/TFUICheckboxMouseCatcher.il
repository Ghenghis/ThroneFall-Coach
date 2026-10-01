// ===== TFUICheckboxMouseCatcher  (token 0x02000349) =====
  .method TFUICheckboxMouseCatcher::OnApply()  // token 0x060011DA rva 0x56351 attrs Family, Virtual, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Checkbox TFUICheckboxMouseCatcher::target  /*0x04001599*/
    IL_0006: callvirt void Checkbox::Toggle()  /*0x06000FD7*/
    IL_000b: ldarg.0
    IL_000c: ldfld MPImageBasic TFUICheckboxMouseCatcher::targetGraphic  /*0x0400159A*/
    IL_0011: ldarg.0
    IL_0012: ldfld Color TFUICheckboxMouseCatcher::highlightColor  /*0x0400159C*/
    IL_0017: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_001c: ret

  .method TFUICheckboxMouseCatcher::OnClear()  // token 0x060011DB rva 0x5636f attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUICheckboxMouseCatcher::targetGraphic  /*0x0400159A*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUICheckboxMouseCatcher::defaultColor  /*0x0400159B*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUICheckboxMouseCatcher::OnFocus()  // token 0x060011DC rva 0x56382 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUICheckboxMouseCatcher::targetGraphic  /*0x0400159A*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUICheckboxMouseCatcher::highlightColor  /*0x0400159C*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUICheckboxMouseCatcher::OnFocusAndSelect()  // token 0x060011DD rva 0x56382 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUICheckboxMouseCatcher::targetGraphic  /*0x0400159A*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUICheckboxMouseCatcher::highlightColor  /*0x0400159C*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUICheckboxMouseCatcher::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x060011DE rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUICheckboxMouseCatcher::OnSelect()  // token 0x060011DF rva 0x56382 attrs Family, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUICheckboxMouseCatcher::targetGraphic  /*0x0400159A*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUICheckboxMouseCatcher::highlightColor  /*0x0400159C*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ret

  .method TFUICheckboxMouseCatcher::.ctor()  // token 0x060011E0 rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

