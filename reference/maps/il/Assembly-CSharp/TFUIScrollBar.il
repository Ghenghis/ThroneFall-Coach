// ===== TFUIScrollBar  (token 0x02000356) =====
  .method TFUIScrollBar::get_dragable()  // token 0x06001231 rva 0x38002 attrs Public, Virtual, HideBySig, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: ret

  .method TFUIScrollBar::OnApply()  // token 0x06001232 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIScrollBar::OnClear()  // token 0x06001233 rva 0x57648 attrs Family, Virtual, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TFUIScrollBar::focussed  /*0x040015E8*/
    IL_0007: ret

  .method TFUIScrollBar::OnFocus()  // token 0x06001234 rva 0x57651 attrs Family, Virtual, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TFUIScrollBar::focussed  /*0x040015E8*/
    IL_0007: ret

  .method TFUIScrollBar::OnFocusAndSelect()  // token 0x06001235 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIScrollBar::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001236 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIScrollBar::OnSelect()  // token 0x06001237 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIScrollBar::OnDragStart()  // token 0x06001238 rva 0x5765a attrs Public, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ScrollArea TFUIScrollBar::target  /*0x040015E7*/
    IL_0006: callvirt void ScrollArea::OnDragStart()  /*0x060011B2*/
    IL_000b: ret

  .method TFUIScrollBar::OnDrag(UnityEngine.Vector2)  // token 0x06001239 rva 0x57667 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ScrollArea TFUIScrollBar::target  /*0x040015E7*/
    IL_0006: ldarg.1
    IL_0007: callvirt void ScrollArea::OnDrag(UnityEngine.Vector2)  /*0x060011B3*/
    IL_000c: ret

  .method TFUIScrollBar::OnDragEnd()  // token 0x0600123A rva 0x57675 attrs Public, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ScrollArea TFUIScrollBar::target  /*0x040015E7*/
    IL_0006: callvirt void ScrollArea::OnDragEnd()  /*0x060011B4*/
    IL_000b: ret

  .method TFUIScrollBar::.ctor()  // token 0x0600123B rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

