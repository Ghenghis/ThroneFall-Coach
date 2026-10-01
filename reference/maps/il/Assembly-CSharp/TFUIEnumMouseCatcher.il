// ===== TFUIEnumMouseCatcher  (token 0x0200034B) =====
  .method TFUIEnumMouseCatcher::OnApply()  // token 0x060011E6 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumMouseCatcher::OnClear()  // token 0x060011E7 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumMouseCatcher::OnFocus()  // token 0x060011E8 rva 0x56544 attrs Family, Virtual, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TFUIEnumMouseCatcher::buttons  /*0x040015A1*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld UIFrame TFUIEnumMouseCatcher::targetFrame  /*0x040015A2*/
    IL_0012: ldfld UnityEvent UIFrame::onNewFocus  /*0x040016E0*/
    IL_0017: ldarg.0
    IL_0018: ldftn void TFUIEnumMouseCatcher::ListenForUnfocus()  /*0x060011ED*/
    IL_001e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0023: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0028: ret

  .method TFUIEnumMouseCatcher::OnFocusAndSelect()  // token 0x060011E9 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumMouseCatcher::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x060011EA rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumMouseCatcher::OnSelect()  // token 0x060011EB rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEnumMouseCatcher::Start()  // token 0x060011EC rva 0x5656e attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<UIFrame>  /*0x2B0000F9*/
    IL_0007: stfld UIFrame TFUIEnumMouseCatcher::targetFrame  /*0x040015A2*/
    IL_000c: ret

  .method TFUIEnumMouseCatcher::ListenForUnfocus()  // token 0x060011ED rva 0x5657c attrs Private, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame TFUIEnumMouseCatcher::targetFrame  /*0x040015A2*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_000b: ldarg.0
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brtrue.s IL_002b
    IL_0013: ldarg.0
    IL_0014: ldfld List<ThronefallUIElement> TFUIEnumMouseCatcher::focusWhitelist  /*0x040015A0*/
    IL_0019: ldarg.0
    IL_001a: ldfld UIFrame TFUIEnumMouseCatcher::targetFrame  /*0x040015A2*/
    IL_001f: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_0024: callvirt bool System.Collections.Generic.List<ThronefallUIElement>::Contains(!0)  /*0x0A0006F2*/
    IL_0029: brfalse.s IL_002c
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject TFUIEnumMouseCatcher::buttons  /*0x040015A1*/
    IL_0032: ldc.i4.0
    IL_0033: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0038: ldarg.0
    IL_0039: ldfld UIFrame TFUIEnumMouseCatcher::targetFrame  /*0x040015A2*/
    IL_003e: ldfld UnityEvent UIFrame::onNewFocus  /*0x040016E0*/
    IL_0043: ldarg.0
    IL_0044: ldftn void TFUIEnumMouseCatcher::ListenForUnfocus()  /*0x060011ED*/
    IL_004a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004f: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_0054: ret

  .method TFUIEnumMouseCatcher::.ctor()  // token 0x060011EE rva 0x565dd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_0006: stfld List<ThronefallUIElement> TFUIEnumMouseCatcher::focusWhitelist  /*0x040015A0*/
    IL_000b: ldarg.0
    IL_000c: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0011: ret

