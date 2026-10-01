// ===== ScrollArea  (token 0x0200033D) =====
  .method ScrollArea::Start()  // token 0x060011AF rva 0x558ef attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld RectTransform ScrollArea::content  /*0x0400156A*/
    IL_0007: callvirt Vector2 UnityEngine.RectTransform::get_anchoredPosition()  /*0x0A000606*/
    IL_000c: stfld Vector2 ScrollArea::initialContentPosition  /*0x04001570*/
    IL_0011: ldarg.0
    IL_0012: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0017: ldc.i4.0
    IL_0018: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_001d: stfld Player ScrollArea::input  /*0x04001573*/
    IL_0022: ret

  .method ScrollArea::Update()  // token 0x060011B0 rva 0x55914 attrs Private, HideBySig
    // code size 483 (0x1e3), max stack 7, init locals
    .locals ([0] float, [1] float, [2] Rect)
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: callvirt UIFrame UIFrameManager::get_ActiveFrame()  /*0x060012F9*/
    IL_000a: ldarg.0
    IL_000b: ldfld UIFrame ScrollArea::target  /*0x04001567*/
    IL_0010: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0015: brfalse.s IL_0060
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_001e: call Vector2 UnityEngine.Input::get_mouseScrollDelta()  /*0x0A00070D*/
    IL_0023: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0028: sub
    IL_0029: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_002e: ldarg.0
    IL_002f: ldfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_0034: ldc.r4 1f
    IL_0039: ble.un.s IL_0048
    IL_003b: ldarg.0
    IL_003c: ldc.r4 1f
    IL_0041: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_0046: br.s IL_0060
    IL_0048: ldarg.0
    IL_0049: ldfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_004e: ldc.r4 0f
    IL_0053: bge.un.s IL_0060
    IL_0055: ldarg.0
    IL_0056: ldc.r4 0f
    IL_005b: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_0060: ldarg.0
    IL_0061: ldarg.0
    IL_0062: ldfld RectTransform ScrollArea::mask  /*0x04001569*/
    IL_0067: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_006c: stloc.2
    IL_006d: ldloca.s 2
    IL_006f: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0074: ldc.r4 0.2f
    IL_0079: mul
    IL_007a: stfld float ScrollArea::endBuffer  /*0x0400156F*/
    IL_007f: ldarg.0
    IL_0080: ldfld RectTransform ScrollArea::content  /*0x0400156A*/
    IL_0085: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_008a: stloc.2
    IL_008b: ldloca.s 2
    IL_008d: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0092: ldarg.0
    IL_0093: ldfld RectTransform ScrollArea::mask  /*0x04001569*/
    IL_0098: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_009d: stloc.2
    IL_009e: ldloca.s 2
    IL_00a0: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_00a5: sub
    IL_00a6: stloc.0
    IL_00a7: ldloc.0
    IL_00a8: ldc.r4 0f
    IL_00ad: bge.un.s IL_00b5
    IL_00af: ldc.r4 0f
    IL_00b4: stloc.0
    IL_00b5: ldloc.0
    IL_00b6: ldc.r4 0f
    IL_00bb: beq.s IL_00c6
    IL_00bd: ldloc.0
    IL_00be: ldarg.0
    IL_00bf: ldfld float ScrollArea::endBuffer  /*0x0400156F*/
    IL_00c4: add
    IL_00c5: stloc.0
    IL_00c6: ldloc.0
    IL_00c7: ldc.r4 0f
    IL_00cc: bne.un.s IL_00e1
    IL_00ce: ldarg.0
    IL_00cf: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_00d4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00d9: ldc.i4.0
    IL_00da: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00df: br.s IL_00f2
    IL_00e1: ldarg.0
    IL_00e2: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_00e7: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ec: ldc.i4.1
    IL_00ed: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld RectTransform ScrollArea::scrollBarBlock  /*0x0400156C*/
    IL_00f8: ldc.i4.1
    IL_00f9: ldarg.0
    IL_00fa: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_00ff: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_0104: stloc.2
    IL_0105: ldloca.s 2
    IL_0107: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_010c: ldarg.0
    IL_010d: ldfld RectTransform ScrollArea::mask  /*0x04001569*/
    IL_0112: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_0117: stloc.2
    IL_0118: ldloca.s 2
    IL_011a: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_011f: ldarg.0
    IL_0120: ldfld RectTransform ScrollArea::content  /*0x0400156A*/
    IL_0125: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_012a: stloc.2
    IL_012b: ldloca.s 2
    IL_012d: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0132: ldarg.0
    IL_0133: ldfld float ScrollArea::endBuffer  /*0x0400156F*/
    IL_0138: add
    IL_0139: div
    IL_013a: mul
    IL_013b: callvirt void UnityEngine.RectTransform::SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis,float)  /*0x0A00070E*/
    IL_0140: ldarg.0
    IL_0141: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_0146: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_014b: stloc.2
    IL_014c: ldloca.s 2
    IL_014e: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0153: ldarg.0
    IL_0154: ldfld RectTransform ScrollArea::scrollBarBlock  /*0x0400156C*/
    IL_0159: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_015e: stloc.2
    IL_015f: ldloca.s 2
    IL_0161: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0166: sub
    IL_0167: stloc.1
    IL_0168: ldarg.0
    IL_0169: ldarg.0
    IL_016a: ldfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_016f: ldarg.0
    IL_0170: ldfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_0175: ldarg.0
    IL_0176: ldflda float ScrollArea::scrollVelocityRef  /*0x04001572*/
    IL_017b: ldarg.0
    IL_017c: ldfld float ScrollArea::dampTime  /*0x0400156E*/
    IL_0181: ldc.r4 Infinityf
    IL_0186: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_018b: call float UnityEngine.Mathf::SmoothDamp(float,float,ref float,float,float,float)  /*0x0A00070F*/
    IL_0190: stfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_0195: ldarg.0
    IL_0196: ldfld RectTransform ScrollArea::content  /*0x0400156A*/
    IL_019b: ldarg.0
    IL_019c: ldflda Vector2 ScrollArea::initialContentPosition  /*0x04001570*/
    IL_01a1: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_01a6: ldarg.0
    IL_01a7: ldflda Vector2 ScrollArea::initialContentPosition  /*0x04001570*/
    IL_01ac: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_01b1: ldloc.0
    IL_01b2: ldarg.0
    IL_01b3: ldfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_01b8: mul
    IL_01b9: add
    IL_01ba: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_01bf: callvirt void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)  /*0x0A000607*/
    IL_01c4: ldarg.0
    IL_01c5: ldfld RectTransform ScrollArea::scrollBarBlock  /*0x0400156C*/
    IL_01ca: ldc.r4 0f
    IL_01cf: ldloc.1
    IL_01d0: neg
    IL_01d1: ldarg.0
    IL_01d2: ldfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_01d7: mul
    IL_01d8: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_01dd: callvirt void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)  /*0x0A000607*/
    IL_01e2: ret

  .method ScrollArea::OnNewSelection()  // token 0x060011B1 rva 0x55b04 attrs Public, HideBySig
    // code size 80 (0x50), max stack 4, init locals
    .locals ([0] ScrollElementID, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ScrollArea::target  /*0x04001567*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_000b: callvirt !!0 UnityEngine.Component::GetComponent()<ScrollElementID>  /*0x2B000104*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldc.r4 0f
    IL_0020: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldfld RectTransform ScrollArea::content  /*0x0400156A*/
    IL_002c: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0031: ldc.i4.1
    IL_0032: sub
    IL_0033: stloc.1
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld int ScrollArea::startToScrollAfterElement  /*0x0400156D*/
    IL_003b: conv.r4
    IL_003c: ldloc.1
    IL_003d: conv.r4
    IL_003e: ldloc.0
    IL_003f: ldfld int ScrollElementID::id  /*0x04001574*/
    IL_0044: conv.r4
    IL_0045: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_004a: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_004f: ret

  .method ScrollArea::OnDragStart()  // token 0x060011B2 rva 0x55b60 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_0007: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_000c: ret

  .method ScrollArea::OnDrag(UnityEngine.Vector2)  // token 0x060011B3 rva 0x55b6e attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void ScrollArea::SetValueByScreenPoint(UnityEngine.Vector2)  /*0x060011B5*/
    IL_0007: ret

  .method ScrollArea::OnDragEnd()  // token 0x060011B4 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ScrollArea::SetValueByScreenPoint(UnityEngine.Vector2)  // token 0x060011B5 rva 0x55b78 attrs Public, HideBySig
    // code size 161 (0xa1), max stack 4, init locals
    .locals ([0] float, [1] Rect)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_0006: ldarg.0
    IL_0007: ldfld Player ScrollArea::input  /*0x04001573*/
    IL_000c: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0011: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0016: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_001b: ldnull
    IL_001c: ldarga.s 1
    IL_001e: call bool UnityEngine.RectTransformUtility::ScreenPointToLocalPointInRectangle(UnityEngine.RectTransform,UnityEngine.Vector2,UnityEngine.Camera,ref UnityEngine.Vector2)  /*0x0A000712*/
    IL_0023: pop
    IL_0024: ldarg.0
    IL_0025: ldfld RectTransform ScrollArea::scrollBarBackground  /*0x0400156B*/
    IL_002a: callvirt Rect UnityEngine.RectTransform::get_rect()  /*0x0A000033*/
    IL_002f: stloc.1
    IL_0030: ldloca.s 1
    IL_0032: call float UnityEngine.Rect::get_height()  /*0x0A0003C8*/
    IL_0037: stloc.0
    IL_0038: ldarg.1
    IL_0039: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_003e: ldloc.0
    IL_003f: neg
    IL_0040: ldc.r4 2f
    IL_0045: div
    IL_0046: bge.un.s IL_0057
    IL_0048: ldarga.s 1
    IL_004a: ldloc.0
    IL_004b: neg
    IL_004c: ldc.r4 2f
    IL_0051: div
    IL_0052: stfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0057: ldarg.1
    IL_0058: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_005d: ldloc.0
    IL_005e: ldc.r4 2f
    IL_0063: div
    IL_0064: ble.un.s IL_0074
    IL_0066: ldarga.s 1
    IL_0068: ldloc.0
    IL_0069: ldc.r4 2f
    IL_006e: div
    IL_006f: stfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0074: ldarg.0
    IL_0075: ldloc.0
    IL_0076: ldc.r4 2f
    IL_007b: div
    IL_007c: ldloc.0
    IL_007d: neg
    IL_007e: ldc.r4 2f
    IL_0083: div
    IL_0084: ldarg.1
    IL_0085: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_008a: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008f: stfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_0094: ldarg.0
    IL_0095: ldarg.0
    IL_0096: ldfld float ScrollArea::scrollValue  /*0x04001568*/
    IL_009b: stfld float ScrollArea::desiredScrollValue  /*0x04001571*/
    IL_00a0: ret

  .method ScrollArea::.ctor()  // token 0x060011B6 rva 0x55c25 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.4
    IL_0002: stfld int ScrollArea::startToScrollAfterElement  /*0x0400156D*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 0.5f
    IL_000d: stfld float ScrollArea::dampTime  /*0x0400156E*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 50f
    IL_0018: stfld float ScrollArea::endBuffer  /*0x0400156F*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

