// ===== ThronefallUIElement  (token 0x02000364) =====
  .method ThronefallUIElement::get_CurrentState()  // token 0x060012A6 rva 0x59011 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0006: ret

  .method ThronefallUIElement::get_PreviousState()  // token 0x060012A7 rva 0x59019 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0006: ret

  .method ThronefallUIElement::get_dragable()  // token 0x060012A8 rva 0x443c attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: ret

  .method ThronefallUIElement::Apply()  // token 0x060012A9 rva 0x59021 attrs Public, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_000a: brfalse.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_0013: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0018: ldarg.0
    IL_0019: callvirt void ThronefallUIElement::OnApply()  /*0x060012AF*/
    IL_001e: ret

  .method ThronefallUIElement::Select()  // token 0x060012AA rva 0x59041 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: call void ThronefallUIElement::SetState(ThronefallUIElement.SelectionState)  /*0x060012B5*/
    IL_0007: ret

  .method ThronefallUIElement::Focus()  // token 0x060012AB rva 0x5904a attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void ThronefallUIElement::SetState(ThronefallUIElement.SelectionState)  /*0x060012B5*/
    IL_0007: ret

  .method ThronefallUIElement::FocusAndSelect()  // token 0x060012AC rva 0x59053 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: call void ThronefallUIElement::SetState(ThronefallUIElement.SelectionState)  /*0x060012B5*/
    IL_0007: ret

  .method ThronefallUIElement::Clear()  // token 0x060012AD rva 0x5905c attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void ThronefallUIElement::SetState(ThronefallUIElement.SelectionState)  /*0x060012B5*/
    IL_0007: ret

  .method ThronefallUIElement::HardStateSet(ThronefallUIElement.SelectionState)  // token 0x060012AE rva 0x59065 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_000e: ldarg.0
    IL_000f: ldarg.1
    IL_0010: callvirt void ThronefallUIElement::OnHardStateSet(ThronefallUIElement.SelectionState)  /*0x060012B4*/
    IL_0015: ret

  .method ThronefallUIElement::OnApply()  // token 0x060012AF rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::OnClear()  // token 0x060012B0 rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::OnSelect()  // token 0x060012B1 rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::OnFocus()  // token 0x060012B2 rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::OnFocusAndSelect()  // token 0x060012B3 rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x060012B4 rva 0x0 attrs Family, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method ThronefallUIElement::SetState(ThronefallUIElement.SelectionState)  // token 0x060012B5 rva 0x5907c attrs Private, HideBySig
    // code size 102 (0x66), max stack 2, init locals
    .locals ([0] ThronefallUIElement.SelectionState)
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldarg.0
    IL_000c: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0011: stfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0016: ldarg.0
    IL_0017: ldarg.1
    IL_0018: stfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_001d: ldarg.0
    IL_001e: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: switch (IL_003c, IL_0044, IL_004c, IL_0054)
    IL_003a: br.s IL_005a
    IL_003c: ldarg.0
    IL_003d: callvirt void ThronefallUIElement::OnClear()  /*0x060012B0*/
    IL_0042: br.s IL_005a
    IL_0044: ldarg.0
    IL_0045: callvirt void ThronefallUIElement::OnFocus()  /*0x060012B2*/
    IL_004a: br.s IL_005a
    IL_004c: ldarg.0
    IL_004d: callvirt void ThronefallUIElement::OnSelect()  /*0x060012B1*/
    IL_0052: br.s IL_005a
    IL_0054: ldarg.0
    IL_0055: callvirt void ThronefallUIElement::OnFocusAndSelect()  /*0x060012B3*/
    IL_005a: ldarg.0
    IL_005b: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0060: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0065: ret

  .method ThronefallUIElement::TryNavigate(ThronefallUIElement.NavigationDirection)  // token 0x060012B6 rva 0x590f0 attrs Public, HideBySig
    // code size 125 (0x7d), max stack 2, init locals
    .locals ([0] ThronefallUIElement)
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_000a: brfalse.s IL_000e
    IL_000c: ldarg.0
    IL_000d: ret
    IL_000e: ldnull
    IL_000f: stloc.0
    IL_0010: ldarg.1
    IL_0011: switch (IL_0043, IL_003a, IL_0031, IL_0028)
    IL_0026: br.s IL_004a
    IL_0028: ldarg.0
    IL_0029: ldfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_002e: stloc.0
    IL_002f: br.s IL_004a
    IL_0031: ldarg.0
    IL_0032: ldfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0037: stloc.0
    IL_0038: br.s IL_004a
    IL_003a: ldarg.0
    IL_003b: ldfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0040: stloc.0
    IL_0041: br.s IL_004a
    IL_0043: ldarg.0
    IL_0044: ldfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0049: stloc.0
    IL_004a: ldloc.0
    IL_004b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0050: brfalse.s IL_006f
    IL_0052: ldloc.0
    IL_0053: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0058: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_005d: brtrue.s IL_006f
    IL_005f: ldarg.0
    IL_0060: ldfld bool ThronefallUIElement::forceNavigateToDisabledElements  /*0x04001680*/
    IL_0065: brtrue.s IL_006f
    IL_0067: ldloc.0
    IL_0068: ldarg.1
    IL_0069: callvirt ThronefallUIElement ThronefallUIElement::TryNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012B6*/
    IL_006e: ret
    IL_006f: ldarg.0
    IL_0070: ldfld UnityEvent<ThronefallUIElement.NavigationDirection> ThronefallUIElement::onEmptyNavigate  /*0x04001687*/
    IL_0075: ldarg.1
    IL_0076: callvirt void UnityEngine.Events.UnityEvent<ThronefallUIElement.NavigationDirection>::Invoke(!0)  /*0x0A000721*/
    IL_007b: ldloc.0
    IL_007c: ret

  .method ThronefallUIElement::OnDrag(UnityEngine.Vector2)  // token 0x060012B7 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ThronefallUIElement::OnDragEnd()  // token 0x060012B8 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ThronefallUIElement::OnDragStart()  // token 0x060012B9 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ThronefallUIElement::.ctor()  // token 0x060012BA rva 0x59179 attrs Family, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent<ThronefallUIElement.NavigationDirection>::.ctor()  /*0x0A000722*/
    IL_001c: stfld UnityEvent<ThronefallUIElement.NavigationDirection> ThronefallUIElement::onEmptyNavigate  /*0x04001687*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== ThronefallUIElement/NavigationDirection  (token 0x02000365) =====
// ===== ThronefallUIElement/SelectionState  (token 0x02000366) =====
