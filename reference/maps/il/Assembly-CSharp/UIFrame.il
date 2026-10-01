// ===== UIFrame  (token 0x02000372) =====
  .method UIFrame::get_CurrentSelection()  // token 0x060012E6 rva 0x59fb6 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0006: ret

  .method UIFrame::get_CurrentFocus()  // token 0x060012E7 rva 0x59fbe attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0006: ret

  .method UIFrame::get_LastApplied()  // token 0x060012E8 rva 0x59fc6 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement UIFrame::lastApplied  /*0x040016F0*/
    IL_0006: ret

  .method UIFrame::get_Interactable()  // token 0x060012E9 rva 0x59fce attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool UIFrame::interactable  /*0x040016F1*/
    IL_0006: ret

  .method UIFrame::get_mouseApplyPossible()  // token 0x060012EA rva 0x59fd8 attrs Private, HideBySig, SpecialName
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0014: ldfld bool ThronefallUIElement::ignoreMouse  /*0x0400167D*/
    IL_0019: brfalse.s IL_0047
    IL_001b: ldarg.0
    IL_001c: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0021: ldnull
    IL_0022: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0027: brfalse.s IL_0045
    IL_0029: ldarg.0
    IL_002a: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_002f: ldfld bool ThronefallUIElement::autoSelectOnFocus  /*0x0400167E*/
    IL_0034: brfalse.s IL_0045
    IL_0036: ldarg.0
    IL_0037: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_003c: ldfld bool ThronefallUIElement::ignoreMouse  /*0x0400167D*/
    IL_0041: ldc.i4.0
    IL_0042: ceq
    IL_0044: ret
    IL_0045: ldc.i4.0
    IL_0046: ret
    IL_0047: ldc.i4.1
    IL_0048: ret

  .method UIFrame::get_MouseSleeping()  // token 0x060012EB rva 0x5a02d attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool UIFrame::mouseSleeping  /*0x040016F2*/
    IL_0006: ret

  .method UIFrame::Awake()  // token 0x060012EC rva 0x5a035 attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<UIFrameManager>  /*0x2B000109*/
    IL_0007: stfld UIFrameManager UIFrame::frameManager  /*0x040016E5*/
    IL_000c: ldarg.0
    IL_000d: ldfld UIFrameManager UIFrame::frameManager  /*0x040016E5*/
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld UIFrameManager UIFrame::frameManager  /*0x040016E5*/
    IL_0020: ldarg.0
    IL_0021: callvirt void UIFrameManager::RegisterFrame(UIFrame)  /*0x06001305*/
    IL_0026: ret

  .method UIFrame::Start()  // token 0x060012ED rva 0x5a05d attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player UIFrame::input  /*0x040016EA*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: call !!0 UnityEngine.Component::GetComponentInParent()<UnityEngine.UI.GraphicRaycaster>  /*0x2B00010A*/
    IL_0018: stfld GraphicRaycaster UIFrame::graphicRaycaster  /*0x040016EB*/
    IL_001d: ret

  .method UIFrame::Update()  // token 0x060012EE rva 0x5a07c attrs Private, HideBySig
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrameManager UIFrame::frameManager  /*0x040016E5*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0021
    IL_000e: ldarg.0
    IL_000f: ldfld UIFrameManager UIFrame::frameManager  /*0x040016E5*/
    IL_0014: callvirt UIFrame UIFrameManager::get_ActiveFrame()  /*0x060012F9*/
    IL_0019: ldarg.0
    IL_001a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001f: brtrue.s IL_0029
    IL_0021: ldarg.0
    IL_0022: ldfld bool UIFrame::interactable  /*0x040016F1*/
    IL_0027: brtrue.s IL_002a
    IL_0029: ret
    IL_002a: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_002f: callvirt bool SceneTransitionManager::get_SceneTransitionIsRunning()  /*0x060009C6*/
    IL_0034: brfalse.s IL_0037
    IL_0036: ret
    IL_0037: ldarg.0
    IL_0038: ldc.i4.0
    IL_0039: stfld bool UIFrame::appliedThisFrame  /*0x040016F3*/
    IL_003e: ldarg.0
    IL_003f: call void UIFrame::HandleMouseNavigation()  /*0x060012F0*/
    IL_0044: ldarg.0
    IL_0045: ldfld bool UIFrame::appliedThisFrame  /*0x040016F3*/
    IL_004a: brfalse.s IL_004d
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: call void UIFrame::HandleButtonNavigation()  /*0x060012EF*/
    IL_0053: ret

  .method UIFrame::HandleButtonNavigation()  // token 0x060012EF rva 0x5a0dc attrs Private, HideBySig
    // code size 258 (0x102), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0006: ldstr "Menu Apply"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_0019
    IL_0012: ldarg.0
    IL_0013: call void UIFrame::Apply()  /*0x060012F5*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_001f: ldstr "Menu Right"
    IL_0024: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_0029: brfalse.s IL_0033
    IL_002b: ldarg.0
    IL_002c: ldc.i4.0
    IL_002d: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_0032: ret
    IL_0033: ldarg.0
    IL_0034: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0039: ldstr "Menu Left"
    IL_003e: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_0043: brfalse.s IL_004d
    IL_0045: ldarg.0
    IL_0046: ldc.i4.1
    IL_0047: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0053: ldstr "Menu Up"
    IL_0058: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_005d: brfalse.s IL_0067
    IL_005f: ldarg.0
    IL_0060: ldc.i4.2
    IL_0061: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_0066: ret
    IL_0067: ldarg.0
    IL_0068: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_006d: ldstr "Menu Down"
    IL_0072: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_0077: brfalse.s IL_0081
    IL_0079: ldarg.0
    IL_007a: ldc.i4.3
    IL_007b: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_0080: ret
    IL_0081: ldarg.0
    IL_0082: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0087: ldstr "Interact"
    IL_008c: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0091: brfalse.s IL_009a
    IL_0093: ldarg.0
    IL_0094: call void UIFrame::Apply()  /*0x060012F5*/
    IL_0099: ret
    IL_009a: ldarg.0
    IL_009b: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_00a0: ldstr "Move Horizontal"
    IL_00a5: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_00aa: brfalse.s IL_00b4
    IL_00ac: ldarg.0
    IL_00ad: ldc.i4.0
    IL_00ae: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_00b3: ret
    IL_00b4: ldarg.0
    IL_00b5: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_00ba: ldstr "Move Horizontal"
    IL_00bf: callvirt bool Rewired.Player::GetNegativeButtonRepeating(string)  /*0x0A000732*/
    IL_00c4: brfalse.s IL_00ce
    IL_00c6: ldarg.0
    IL_00c7: ldc.i4.1
    IL_00c8: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_00cd: ret
    IL_00ce: ldarg.0
    IL_00cf: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_00d4: ldstr "Move Vertical"
    IL_00d9: callvirt bool Rewired.Player::GetButtonRepeating(string)  /*0x0A000731*/
    IL_00de: brfalse.s IL_00e8
    IL_00e0: ldarg.0
    IL_00e1: ldc.i4.2
    IL_00e2: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_00e7: ret
    IL_00e8: ldarg.0
    IL_00e9: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_00ee: ldstr "Move Vertical"
    IL_00f3: callvirt bool Rewired.Player::GetNegativeButtonRepeating(string)  /*0x0A000732*/
    IL_00f8: brfalse.s IL_0101
    IL_00fa: ldarg.0
    IL_00fb: ldc.i4.3
    IL_00fc: call void UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012F1*/
    IL_0101: ret

  .method UIFrame::HandleMouseNavigation()  // token 0x060012F0 rva 0x5a1ec attrs Private, HideBySig
    // code size 601 (0x259), max stack 3, init locals
    .locals ([0] List.Enumerator<RaycastResult>, [1] RaycastResult, [2] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0006: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_000b: callvirt bool Rewired.Player.ControllerHelper::get_hasMouse()  /*0x0A000733*/
    IL_0010: brfalse.s IL_0019
    IL_0012: call bool UnityEngine.Cursor::get_visible()  /*0x0A000734*/
    IL_0017: brtrue.s IL_001a
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld PointerEventData UIFrame::pointerData  /*0x040016EC*/
    IL_0021: callvirt Vector2 UnityEngine.EventSystems.PointerEventData::get_position()  /*0x0A000735*/
    IL_0026: stfld Vector2 UIFrame::lastFramePointerPosition  /*0x040016ED*/
    IL_002b: ldarg.0
    IL_002c: ldfld PointerEventData UIFrame::pointerData  /*0x040016EC*/
    IL_0031: ldarg.0
    IL_0032: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0037: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_003c: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0041: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_0046: callvirt void UnityEngine.EventSystems.PointerEventData::set_position(UnityEngine.Vector2)  /*0x0A000736*/
    IL_004b: ldarg.0
    IL_004c: ldfld bool UIFrame::mouseSleeping  /*0x040016F2*/
    IL_0051: brfalse.s IL_0076
    IL_0053: ldarg.0
    IL_0054: ldfld Vector2 UIFrame::lastFramePointerPosition  /*0x040016ED*/
    IL_0059: box UnityEngine.Vector2  /*0x01000069*/
    IL_005e: ldarg.0
    IL_005f: ldfld PointerEventData UIFrame::pointerData  /*0x040016EC*/
    IL_0064: callvirt Vector2 UnityEngine.EventSystems.PointerEventData::get_position()  /*0x0A000735*/
    IL_0069: box UnityEngine.Vector2  /*0x01000069*/
    IL_006e: call bool System.Object::Equals(object,object)  /*0x0A00058B*/
    IL_0073: brfalse.s IL_0076
    IL_0075: ret
    IL_0076: ldarg.0
    IL_0077: ldc.i4.0
    IL_0078: stfld bool UIFrame::mouseSleeping  /*0x040016F2*/
    IL_007d: ldarg.0
    IL_007e: ldfld List<RaycastResult> UIFrame::pointerRayResults  /*0x040016EE*/
    IL_0083: callvirt void System.Collections.Generic.List<UnityEngine.EventSystems.RaycastResult>::Clear()  /*0x0A000737*/
    IL_0088: ldarg.0
    IL_0089: ldfld GraphicRaycaster UIFrame::graphicRaycaster  /*0x040016EB*/
    IL_008e: ldarg.0
    IL_008f: ldfld PointerEventData UIFrame::pointerData  /*0x040016EC*/
    IL_0094: ldarg.0
    IL_0095: ldfld List<RaycastResult> UIFrame::pointerRayResults  /*0x040016EE*/
    IL_009a: callvirt void UnityEngine.EventSystems.BaseRaycaster::Raycast(UnityEngine.EventSystems.PointerEventData,System.Collections.Generic.List<UnityEngine.EventSystems.RaycastResult>)  /*0x0A000738*/
    IL_009f: ldarg.0
    IL_00a0: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_00a5: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Clear()  /*0x0A0006F3*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld List<RaycastResult> UIFrame::pointerRayResults  /*0x040016EE*/
    IL_00b0: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.EventSystems.RaycastResult>::GetEnumerator()  /*0x0A000739*/
    IL_00b5: stloc.0
    IL_00b6: br.s IL_00f0
    IL_00b8: ldloca.s 0
    IL_00ba: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.EventSystems.RaycastResult>::get_Current()  /*0x0A00073A*/
    IL_00bf: stloc.1
    IL_00c0: ldloca.s 1
    IL_00c2: call GameObject UnityEngine.EventSystems.RaycastResult::get_gameObject()  /*0x0A00073B*/
    IL_00c7: callvirt !!0 UnityEngine.GameObject::GetComponentInParent()<ThronefallUIElement>  /*0x2B00010B*/
    IL_00cc: stloc.2
    IL_00cd: ldloc.2
    IL_00ce: ldnull
    IL_00cf: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00d4: brfalse.s IL_00f0
    IL_00d6: ldarg.0
    IL_00d7: ldfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_00dc: ldloc.2
    IL_00dd: callvirt bool System.Collections.Generic.List<ThronefallUIElement>::Contains(!0)  /*0x0A0006F2*/
    IL_00e2: brfalse.s IL_00f0
    IL_00e4: ldarg.0
    IL_00e5: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_00ea: ldloc.2
    IL_00eb: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_00f0: ldloca.s 0
    IL_00f2: call bool System.Collections.Generic.List.Enumerator<UnityEngine.EventSystems.RaycastResult>::MoveNext()  /*0x0A00073D*/
    IL_00f7: brtrue.s IL_00b8
    IL_00f9: leave.s IL_0109
    IL_00fb: ldloca.s 0
    IL_00fd: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.EventSystems.RaycastResult>  /*0x1B000153*/
    IL_0103: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0108: endfinally
    IL_0109: ldarg.0
    IL_010a: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_010f: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0114: ldc.i4.0
    IL_0115: ble.s IL_0185
    IL_0117: ldarg.0
    IL_0118: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_011d: ldc.i4.0
    IL_011e: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0123: ldfld bool ThronefallUIElement::ignoreMouse  /*0x0400167D*/
    IL_0128: brtrue.s IL_0185
    IL_012a: ldarg.0
    IL_012b: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_0130: ldc.i4.0
    IL_0131: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0136: ldfld bool ThronefallUIElement::autoSelectOnFocus  /*0x0400167E*/
    IL_013b: brfalse.s IL_0171
    IL_013d: ldarg.0
    IL_013e: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_0143: ldc.i4.0
    IL_0144: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0149: ldarg.0
    IL_014a: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_014f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0154: brfalse.s IL_0168
    IL_0156: ldarg.0
    IL_0157: ldarg.0
    IL_0158: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_015d: ldc.i4.0
    IL_015e: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0163: call void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0168: ldarg.0
    IL_0169: ldnull
    IL_016a: call void UIFrame::Focus(ThronefallUIElement)  /*0x060012F3*/
    IL_016f: br.s IL_018c
    IL_0171: ldarg.0
    IL_0172: ldarg.0
    IL_0173: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_0178: ldc.i4.0
    IL_0179: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_017e: call void UIFrame::Focus(ThronefallUIElement)  /*0x060012F3*/
    IL_0183: br.s IL_018c
    IL_0185: ldarg.0
    IL_0186: ldnull
    IL_0187: call void UIFrame::Focus(ThronefallUIElement)  /*0x060012F3*/
    IL_018c: ldarg.0
    IL_018d: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0192: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0197: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_019c: ldc.i4.0
    IL_019d: callvirt bool Rewired.Controller::GetButtonDown(int)  /*0x0A00073E*/
    IL_01a2: brfalse.s IL_01da
    IL_01a4: ldarg.0
    IL_01a5: ldfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_01aa: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_01af: ldc.i4.0
    IL_01b0: ble.s IL_01da
    IL_01b2: ldarg.0
    IL_01b3: call bool UIFrame::get_mouseApplyPossible()  /*0x060012EA*/
    IL_01b8: brfalse.s IL_01da
    IL_01ba: ldarg.0
    IL_01bb: call ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_01c0: ldnull
    IL_01c1: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01c6: brfalse.s IL_01d4
    IL_01c8: ldarg.0
    IL_01c9: ldarg.0
    IL_01ca: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_01cf: call void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_01d4: ldarg.0
    IL_01d5: call void UIFrame::Apply()  /*0x060012F5*/
    IL_01da: ldarg.0
    IL_01db: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_01e0: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_01e5: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_01ea: ldc.i4.0
    IL_01eb: callvirt bool Rewired.Controller::GetButton(int)  /*0x0A00073F*/
    IL_01f0: brfalse.s IL_0220
    IL_01f2: ldarg.0
    IL_01f3: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_01f8: ldnull
    IL_01f9: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01fe: brfalse.s IL_0220
    IL_0200: ldarg.0
    IL_0201: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_0206: ldarg.0
    IL_0207: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_020c: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0211: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0216: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_021b: callvirt void ThronefallUIElement::OnDrag(UnityEngine.Vector2)  /*0x060012B7*/
    IL_0220: ldarg.0
    IL_0221: ldfld Player UIFrame::input  /*0x040016EA*/
    IL_0226: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_022b: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0230: ldc.i4.0
    IL_0231: callvirt bool Rewired.Controller::GetButtonUp(int)  /*0x0A000740*/
    IL_0236: brfalse.s IL_0258
    IL_0238: ldarg.0
    IL_0239: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_023e: ldnull
    IL_023f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0244: brfalse.s IL_0258
    IL_0246: ldarg.0
    IL_0247: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_024c: callvirt void ThronefallUIElement::OnDragEnd()  /*0x060012B8*/
    IL_0251: ldarg.0
    IL_0252: ldnull
    IL_0253: stfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_0258: ret
    .try IL_00b6-IL_00fb finally handler IL_00fb-IL_0109

  .method UIFrame::ControllerOrKeyboardNavigate(ThronefallUIElement.NavigationDirection)  // token 0x060012F1 rva 0x5a464 attrs Private, HideBySig
    // code size 52 (0x34), max stack 2, init locals
    .locals ([0] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldc.i4.1
    IL_0011: stfld bool UIFrame::mouseSleeping  /*0x040016F2*/
    IL_0016: ldarg.0
    IL_0017: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_001c: ldarg.1
    IL_001d: callvirt ThronefallUIElement ThronefallUIElement::TryNavigate(ThronefallUIElement.NavigationDirection)  /*0x060012B6*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002a: brfalse.s IL_0033
    IL_002c: ldarg.0
    IL_002d: ldloc.0
    IL_002e: call void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0033: ret

  .method UIFrame::Select(ThronefallUIElement)  // token 0x060012F2 rva 0x5a4a4 attrs Public, HideBySig
    // code size 147 (0x93), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brtrue.s IL_0016
    IL_000e: ldarg.1
    IL_000f: ldfld bool ThronefallUIElement::cannotBeSelected  /*0x0400167F*/
    IL_0014: brfalse.s IL_0017
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_001e: stfld ThronefallUIElement UIFrame::lastSelected  /*0x040016E8*/
    IL_0023: ldarg.0
    IL_0024: ldarg.1
    IL_0025: stfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_002a: ldarg.0
    IL_002b: ldfld UnityEvent UIFrame::onNewSelection  /*0x040016E1*/
    IL_0030: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0035: ldarg.0
    IL_0036: ldfld ThronefallUIElement UIFrame::lastSelected  /*0x040016E8*/
    IL_003b: ldnull
    IL_003c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0041: brfalse.s IL_006e
    IL_0043: ldarg.0
    IL_0044: ldfld ThronefallUIElement UIFrame::lastSelected  /*0x040016E8*/
    IL_0049: ldarg.0
    IL_004a: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_004f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0054: brfalse.s IL_0063
    IL_0056: ldarg.0
    IL_0057: ldfld ThronefallUIElement UIFrame::lastSelected  /*0x040016E8*/
    IL_005c: callvirt void ThronefallUIElement::Focus()  /*0x060012AB*/
    IL_0061: br.s IL_006e
    IL_0063: ldarg.0
    IL_0064: ldfld ThronefallUIElement UIFrame::lastSelected  /*0x040016E8*/
    IL_0069: callvirt void ThronefallUIElement::Clear()  /*0x060012AD*/
    IL_006e: ldarg.1
    IL_006f: ldnull
    IL_0070: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0075: brfalse.s IL_0092
    IL_0077: ldarg.1
    IL_0078: ldarg.0
    IL_0079: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_007e: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0083: brfalse.s IL_008c
    IL_0085: ldarg.1
    IL_0086: callvirt void ThronefallUIElement::FocusAndSelect()  /*0x060012AC*/
    IL_008b: ret
    IL_008c: ldarg.1
    IL_008d: callvirt void ThronefallUIElement::Select()  /*0x060012AA*/
    IL_0092: ret

  .method UIFrame::Focus(ThronefallUIElement)  // token 0x060012F3 rva 0x5a544 attrs Private, HideBySig
    // code size 128 (0x80), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0015: ldnull
    IL_0016: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001b: brfalse.s IL_0048
    IL_001d: ldarg.0
    IL_001e: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0023: ldarg.0
    IL_0024: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0029: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002e: brfalse.s IL_003d
    IL_0030: ldarg.0
    IL_0031: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0036: callvirt void ThronefallUIElement::Select()  /*0x060012AA*/
    IL_003b: br.s IL_0048
    IL_003d: ldarg.0
    IL_003e: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0043: callvirt void ThronefallUIElement::Clear()  /*0x060012AD*/
    IL_0048: ldarg.1
    IL_0049: ldnull
    IL_004a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_004f: brfalse.s IL_006d
    IL_0051: ldarg.1
    IL_0052: ldarg.0
    IL_0053: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0058: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005d: brfalse.s IL_0067
    IL_005f: ldarg.1
    IL_0060: callvirt void ThronefallUIElement::FocusAndSelect()  /*0x060012AC*/
    IL_0065: br.s IL_006d
    IL_0067: ldarg.1
    IL_0068: callvirt void ThronefallUIElement::Focus()  /*0x060012AB*/
    IL_006d: ldarg.0
    IL_006e: ldarg.1
    IL_006f: stfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0074: ldarg.0
    IL_0075: ldfld UnityEvent UIFrame::onNewFocus  /*0x040016E0*/
    IL_007a: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_007f: ret

  .method UIFrame::Activate(ThronefallUIElement)  // token 0x060012F4 rva 0x5a5d0 attrs Public, HideBySig
    // code size 144 (0x90), max stack 2, init locals
    .locals ([0] ThronefallUIElement, [1] List.Enumerator<ThronefallUIElement>)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.1
    IL_000e: stfld bool UIFrame::interactable  /*0x040016F1*/
    IL_0013: ldarg.0
    IL_0014: ldnull
    IL_0015: stfld ThronefallUIElement UIFrame::lastApplied  /*0x040016F0*/
    IL_001a: ldarg.0
    IL_001b: ldnull
    IL_001c: stfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0021: ldarg.0
    IL_0022: ldnull
    IL_0023: stfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0028: ldarg.0
    IL_0029: ldfld UnityEvent UIFrame::onActivate  /*0x040016DF*/
    IL_002e: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0033: ldarg.0
    IL_0034: call void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_0039: ldarg.0
    IL_003a: ldfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_003f: callvirt List.Enumerator<!0> System.Collections.Generic.List<ThronefallUIElement>::GetEnumerator()  /*0x0A000741*/
    IL_0044: stloc.1
    IL_0045: br.s IL_0054
    IL_0047: ldloca.s 1
    IL_0049: call !0 System.Collections.Generic.List.Enumerator<ThronefallUIElement>::get_Current()  /*0x0A000742*/
    IL_004e: ldc.i4.0
    IL_004f: callvirt void ThronefallUIElement::HardStateSet(ThronefallUIElement.SelectionState)  /*0x060012AE*/
    IL_0054: ldloca.s 1
    IL_0056: call bool System.Collections.Generic.List.Enumerator<ThronefallUIElement>::MoveNext()  /*0x0A000743*/
    IL_005b: brtrue.s IL_0047
    IL_005d: leave.s IL_006d
    IL_005f: ldloca.s 1
    IL_0061: constrained. System.Collections.Generic.List.Enumerator<ThronefallUIElement>  /*0x1B000154*/
    IL_0067: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006c: endfinally
    IL_006d: ldarg.1
    IL_006e: stloc.0
    IL_006f: ldloc.0
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0076: brfalse.s IL_007f
    IL_0078: ldarg.0
    IL_0079: ldfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_007e: stloc.0
    IL_007f: ldloc.0
    IL_0080: ldnull
    IL_0081: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0086: brfalse.s IL_008f
    IL_0088: ldarg.0
    IL_0089: ldloc.0
    IL_008a: call void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_008f: ret
    .try IL_0045-IL_005f finally handler IL_005f-IL_006d

  .method UIFrame::Apply()  // token 0x060012F5 rva 0x5a67c attrs Public, HideBySig
    // code size 192 (0xc0), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool UIFrame::appliedThisFrame  /*0x040016F3*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool UIFrame::appliedThisFrame  /*0x040016F3*/
    IL_0010: ldarg.0
    IL_0011: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0016: ldnull
    IL_0017: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001c: brfalse.s IL_0068
    IL_001e: ldarg.0
    IL_001f: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0024: ldfld bool ThronefallUIElement::cannotBeSelected  /*0x0400167F*/
    IL_0029: brfalse.s IL_0068
    IL_002b: ldarg.0
    IL_002c: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0031: callvirt void ThronefallUIElement::Apply()  /*0x060012A9*/
    IL_0036: ldarg.0
    IL_0037: ldarg.0
    IL_0038: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_003d: stfld ThronefallUIElement UIFrame::lastApplied  /*0x040016F0*/
    IL_0042: ldarg.0
    IL_0043: ldfld ThronefallUIElement UIFrame::currentFocus  /*0x040016E7*/
    IL_0048: callvirt bool ThronefallUIElement::get_dragable()  /*0x060012A8*/
    IL_004d: brfalse.s IL_00b4
    IL_004f: ldarg.0
    IL_0050: ldarg.0
    IL_0051: call ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_0056: stfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_005b: ldarg.0
    IL_005c: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_0061: callvirt void ThronefallUIElement::OnDragStart()  /*0x060012B9*/
    IL_0066: br.s IL_00b4
    IL_0068: ldarg.0
    IL_0069: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_006e: ldnull
    IL_006f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0074: brfalse.s IL_00b3
    IL_0076: ldarg.0
    IL_0077: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_007c: callvirt void ThronefallUIElement::Apply()  /*0x060012A9*/
    IL_0081: ldarg.0
    IL_0082: ldarg.0
    IL_0083: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0088: stfld ThronefallUIElement UIFrame::lastApplied  /*0x040016F0*/
    IL_008d: ldarg.0
    IL_008e: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_0093: callvirt bool ThronefallUIElement::get_dragable()  /*0x060012A8*/
    IL_0098: brfalse.s IL_00b4
    IL_009a: ldarg.0
    IL_009b: ldarg.0
    IL_009c: ldfld ThronefallUIElement UIFrame::currentSelected  /*0x040016E6*/
    IL_00a1: stfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld ThronefallUIElement UIFrame::currentDragTarget  /*0x040016E9*/
    IL_00ac: callvirt void ThronefallUIElement::OnDragStart()  /*0x060012B9*/
    IL_00b1: br.s IL_00b4
    IL_00b3: ret
    IL_00b4: ldarg.0
    IL_00b5: ldfld UnityEvent UIFrame::onApply  /*0x040016E2*/
    IL_00ba: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00bf: ret

  .method UIFrame::Deactivate(bool)  // token 0x060012F6 rva 0x5a748 attrs Public, HideBySig
    // code size 93 (0x5d), max stack 2, init locals
    .locals ([0] List.Enumerator<ThronefallUIElement>, [1] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool UIFrame::interactable  /*0x040016F1*/
    IL_0007: ldarg.0
    IL_0008: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000d: ldarg.1
    IL_000e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0013: ldarg.0
    IL_0014: ldfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_0019: callvirt List.Enumerator<!0> System.Collections.Generic.List<ThronefallUIElement>::GetEnumerator()  /*0x0A000741*/
    IL_001e: stloc.0
    IL_001f: br.s IL_0038
    IL_0021: ldloca.s 0
    IL_0023: call !0 System.Collections.Generic.List.Enumerator<ThronefallUIElement>::get_Current()  /*0x0A000742*/
    IL_0028: stloc.1
    IL_0029: ldloc.1
    IL_002a: ldnull
    IL_002b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0030: brfalse.s IL_0038
    IL_0032: ldloc.1
    IL_0033: callvirt void ThronefallUIElement::Clear()  /*0x060012AD*/
    IL_0038: ldloca.s 0
    IL_003a: call bool System.Collections.Generic.List.Enumerator<ThronefallUIElement>::MoveNext()  /*0x0A000743*/
    IL_003f: brtrue.s IL_0021
    IL_0041: leave.s IL_0051
    IL_0043: ldloca.s 0
    IL_0045: constrained. System.Collections.Generic.List.Enumerator<ThronefallUIElement>  /*0x1B000154*/
    IL_004b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0050: endfinally
    IL_0051: ldarg.0
    IL_0052: ldfld UnityEvent UIFrame::onDeactivate  /*0x040016E3*/
    IL_0057: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_005c: ret
    .try IL_001f-IL_0043 finally handler IL_0043-IL_0051

  .method UIFrame::RefetchManagedElements()  // token 0x060012F7 rva 0x5a7c4 attrs Public, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_0006: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Clear()  /*0x0A0006F3*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_0011: ldarg.0
    IL_0012: ldc.i4.1
    IL_0013: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<ThronefallUIElement>  /*0x2B00010C*/
    IL_0018: callvirt void System.Collections.Generic.List<ThronefallUIElement>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000744*/
    IL_001d: ret

  .method UIFrame::.ctor()  // token 0x060012F8 rva 0x5a7e4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 128 (0x80), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool UIFrame::storeLastSelectedElementInFrameStack  /*0x040016DB*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool UIFrame::freezePlayer  /*0x040016DD*/
    IL_000e: ldarg.0
    IL_000f: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0014: stfld UnityEvent UIFrame::onActivate  /*0x040016DF*/
    IL_0019: ldarg.0
    IL_001a: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001f: stfld UnityEvent UIFrame::onNewFocus  /*0x040016E0*/
    IL_0024: ldarg.0
    IL_0025: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_002a: stfld UnityEvent UIFrame::onNewSelection  /*0x040016E1*/
    IL_002f: ldarg.0
    IL_0030: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0035: stfld UnityEvent UIFrame::onApply  /*0x040016E2*/
    IL_003a: ldarg.0
    IL_003b: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0040: stfld UnityEvent UIFrame::onDeactivate  /*0x040016E3*/
    IL_0045: ldarg.0
    IL_0046: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_004b: stfld List<ThronefallUIElement> UIFrame::managedElements  /*0x040016E4*/
    IL_0050: ldarg.0
    IL_0051: ldnull
    IL_0052: newobj void UnityEngine.EventSystems.PointerEventData::.ctor(UnityEngine.EventSystems.EventSystem)  /*0x0A000745*/
    IL_0057: stfld PointerEventData UIFrame::pointerData  /*0x040016EC*/
    IL_005c: ldarg.0
    IL_005d: newobj void System.Collections.Generic.List<UnityEngine.EventSystems.RaycastResult>::.ctor()  /*0x0A000746*/
    IL_0062: stfld List<RaycastResult> UIFrame::pointerRayResults  /*0x040016EE*/
    IL_0067: ldarg.0
    IL_0068: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_006d: stfld List<ThronefallUIElement> UIFrame::filteredPointerResults  /*0x040016EF*/
    IL_0072: ldarg.0
    IL_0073: ldc.i4.1
    IL_0074: stfld bool UIFrame::interactable  /*0x040016F1*/
    IL_0079: ldarg.0
    IL_007a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_007f: ret

