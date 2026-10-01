// ===== TFUISliderDragArea  (token 0x02000358) =====
  .method TFUISliderDragArea::get_dragable()  // token 0x06001247 rva 0x38002 attrs Public, Virtual, HideBySig, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: ret

  .method TFUISliderDragArea::OnApply()  // token 0x06001248 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderDragArea::Update()  // token 0x06001249 rva 0x57a4c attrs Private, HideBySig
    // code size 107 (0x6b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderDragArea::delayedDisable  /*0x04001605*/
    IL_0006: brfalse.s IL_006a
    IL_0008: ldarg.0
    IL_0009: ldfld bool TFUISliderDragArea::inDrag  /*0x04001606*/
    IL_000e: brtrue.s IL_006a
    IL_0010: ldarg.0
    IL_0011: ldarg.0
    IL_0012: ldfld float TFUISliderDragArea::afterDragCounter  /*0x04001607*/
    IL_0017: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_001c: add
    IL_001d: stfld float TFUISliderDragArea::afterDragCounter  /*0x04001607*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUISliderDragArea::afterDragCounter  /*0x04001607*/
    IL_0028: ldc.r4 0.35f
    IL_002d: ble.un.s IL_006a
    IL_002f: ldarg.0
    IL_0030: ldc.i4.0
    IL_0031: stfld bool TFUISliderDragArea::delayedDisable  /*0x04001605*/
    IL_0036: ldarg.0
    IL_0037: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_003c: ldfld GameObject TFUISlider::knob  /*0x040015F2*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldarg.0
    IL_0048: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_004d: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0052: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0057: brfalse.s IL_006a
    IL_0059: ldarg.0
    IL_005a: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_005f: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0064: ldc.i4.0
    IL_0065: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006a: ret

  .method TFUISliderDragArea::OnClear()  // token 0x0600124A rva 0x57ac4 attrs Family, Virtual, HideBySig
    // code size 80 (0x50), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderDragArea::inDrag  /*0x04001606*/
    IL_0006: brtrue.s IL_003d
    IL_0008: ldarg.0
    IL_0009: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_000e: ldfld GameObject TFUISlider::knob  /*0x040015F2*/
    IL_0013: ldc.i4.0
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldarg.0
    IL_001a: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_001f: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0024: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0029: brfalse.s IL_004f
    IL_002b: ldarg.0
    IL_002c: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0031: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld bool TFUISliderDragArea::delayedDisable  /*0x04001605*/
    IL_0044: ldarg.0
    IL_0045: ldc.r4 0f
    IL_004a: stfld float TFUISliderDragArea::afterDragCounter  /*0x04001607*/
    IL_004f: ret

  .method TFUISliderDragArea::OnFocus()  // token 0x0600124B rva 0x57b20 attrs Family, Virtual, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TFUISliderDragArea::delayedDisable  /*0x04001605*/
    IL_0007: ldarg.0
    IL_0008: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_000d: ldfld GameObject TFUISlider::knob  /*0x040015F2*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldarg.0
    IL_0019: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_001e: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0023: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0028: brfalse.s IL_003b
    IL_002a: ldarg.0
    IL_002b: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0030: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0035: ldc.i4.1
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ret

  .method TFUISliderDragArea::OnFocusAndSelect()  // token 0x0600124C rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderDragArea::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x0600124D rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderDragArea::OnSelect()  // token 0x0600124E rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderDragArea::OnDragStart()  // token 0x0600124F rva 0x57b60 attrs Public, Virtual, HideBySig
    // code size 77 (0x4d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TFUISliderDragArea::inDrag  /*0x04001606*/
    IL_0007: ldarg.0
    IL_0008: ldfld MMF_Player TFUISliderDragArea::onStartDrag  /*0x04001601*/
    IL_000d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0012: ldarg.0
    IL_0013: ldfld bool TFUISliderDragArea::colorInitialized  /*0x04001604*/
    IL_0018: brtrue.s IL_0020
    IL_001a: ldarg.0
    IL_001b: call void TFUISliderDragArea::InitColor()  /*0x06001252*/
    IL_0020: ldarg.0
    IL_0021: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0026: ldfld MPImageBasic TFUISlider::fillImg  /*0x040015F6*/
    IL_002b: ldarg.0
    IL_002c: ldfld Color TFUISliderDragArea::dragColor  /*0x04001600*/
    IL_0031: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0036: ldarg.0
    IL_0037: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_003c: ldfld MPImageBasic TFUISlider::knobImg  /*0x040015F7*/
    IL_0041: ldarg.0
    IL_0042: ldfld Color TFUISliderDragArea::dragColor  /*0x04001600*/
    IL_0047: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_004c: ret

  .method TFUISliderDragArea::OnDrag(UnityEngine.Vector2)  // token 0x06001250 rva 0x57bb9 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0006: ldarg.1
    IL_0007: callvirt void TFUISlider::SetValueByScreenPoint(UnityEngine.Vector2)  /*0x06001244*/
    IL_000c: ret

  .method TFUISliderDragArea::OnDragEnd()  // token 0x06001251 rva 0x57bc7 attrs Public, Virtual, HideBySig
    // code size 63 (0x3f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player TFUISliderDragArea::onEndDrag  /*0x04001602*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_000b: ldarg.0
    IL_000c: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0011: ldfld MPImageBasic TFUISlider::fillImg  /*0x040015F6*/
    IL_0016: ldarg.0
    IL_0017: ldfld Color TFUISliderDragArea::defaultColor  /*0x04001603*/
    IL_001c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0021: ldarg.0
    IL_0022: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0027: ldfld MPImageBasic TFUISlider::knobImg  /*0x040015F7*/
    IL_002c: ldarg.0
    IL_002d: ldfld Color TFUISliderDragArea::defaultColor  /*0x04001603*/
    IL_0032: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.0
    IL_0039: stfld bool TFUISliderDragArea::inDrag  /*0x04001606*/
    IL_003e: ret

  .method TFUISliderDragArea::InitColor()  // token 0x06001252 rva 0x57c07 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0007: ldfld MPImageBasic TFUISlider::fillImg  /*0x040015F6*/
    IL_000c: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0011: stfld Color TFUISliderDragArea::defaultColor  /*0x04001603*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool TFUISliderDragArea::colorInitialized  /*0x04001604*/
    IL_001d: ret

  .method TFUISliderDragArea::OnEnable()  // token 0x06001253 rva 0x57c26 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderDragArea::colorInitialized  /*0x04001604*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUISliderDragArea::InitColor()  /*0x06001252*/
    IL_000e: ldarg.0
    IL_000f: ldfld TFUISlider TFUISliderDragArea::target  /*0x040015FF*/
    IL_0014: ldfld MPImageBasic TFUISlider::fillImg  /*0x040015F6*/
    IL_0019: ldarg.0
    IL_001a: ldfld Color TFUISliderDragArea::defaultColor  /*0x04001603*/
    IL_001f: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.0
    IL_0026: stfld bool TFUISliderDragArea::inDrag  /*0x04001606*/
    IL_002b: ret

  .method TFUISliderDragArea::.ctor()  // token 0x06001254 rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

