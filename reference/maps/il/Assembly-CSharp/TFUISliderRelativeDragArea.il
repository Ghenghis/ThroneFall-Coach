// ===== TFUISliderRelativeDragArea  (token 0x0200035A) =====
  .method TFUISliderRelativeDragArea::get_dragable()  // token 0x06001262 rva 0x38002 attrs Public, Virtual, HideBySig, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: ret

  .method TFUISliderRelativeDragArea::OnApply()  // token 0x06001263 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelativeDragArea::Update()  // token 0x06001264 rva 0x58090 attrs Private, HideBySig
    // code size 107 (0x6b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderRelativeDragArea::delayedDisable  /*0x04001627*/
    IL_0006: brfalse.s IL_006a
    IL_0008: ldarg.0
    IL_0009: ldfld bool TFUISliderRelativeDragArea::inDrag  /*0x04001628*/
    IL_000e: brtrue.s IL_006a
    IL_0010: ldarg.0
    IL_0011: ldarg.0
    IL_0012: ldfld float TFUISliderRelativeDragArea::afterDragCounter  /*0x04001629*/
    IL_0017: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_001c: add
    IL_001d: stfld float TFUISliderRelativeDragArea::afterDragCounter  /*0x04001629*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUISliderRelativeDragArea::afterDragCounter  /*0x04001629*/
    IL_0028: ldc.r4 0.35f
    IL_002d: ble.un.s IL_006a
    IL_002f: ldarg.0
    IL_0030: ldc.i4.0
    IL_0031: stfld bool TFUISliderRelativeDragArea::delayedDisable  /*0x04001627*/
    IL_0036: ldarg.0
    IL_0037: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_003c: ldfld GameObject TFUISliderRelative::knob  /*0x04001611*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldarg.0
    IL_0048: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_004d: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0052: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0057: brfalse.s IL_006a
    IL_0059: ldarg.0
    IL_005a: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_005f: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0064: ldc.i4.0
    IL_0065: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006a: ret

  .method TFUISliderRelativeDragArea::OnClear()  // token 0x06001265 rva 0x58108 attrs Family, Virtual, HideBySig
    // code size 80 (0x50), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderRelativeDragArea::inDrag  /*0x04001628*/
    IL_0006: brtrue.s IL_003d
    IL_0008: ldarg.0
    IL_0009: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_000e: ldfld GameObject TFUISliderRelative::knob  /*0x04001611*/
    IL_0013: ldc.i4.0
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ldarg.0
    IL_001a: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_001f: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0024: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0029: brfalse.s IL_004f
    IL_002b: ldarg.0
    IL_002c: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0031: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: ldc.i4.1
    IL_003f: stfld bool TFUISliderRelativeDragArea::delayedDisable  /*0x04001627*/
    IL_0044: ldarg.0
    IL_0045: ldc.r4 0f
    IL_004a: stfld float TFUISliderRelativeDragArea::afterDragCounter  /*0x04001629*/
    IL_004f: ret

  .method TFUISliderRelativeDragArea::OnFocus()  // token 0x06001266 rva 0x58164 attrs Family, Virtual, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TFUISliderRelativeDragArea::delayedDisable  /*0x04001627*/
    IL_0007: ldarg.0
    IL_0008: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_000d: ldfld GameObject TFUISliderRelative::knob  /*0x04001611*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ldarg.0
    IL_0019: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_001e: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0023: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0028: brfalse.s IL_003b
    IL_002a: ldarg.0
    IL_002b: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0030: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0035: ldc.i4.1
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003b: ret

  .method TFUISliderRelativeDragArea::OnFocusAndSelect()  // token 0x06001267 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelativeDragArea::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001268 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelativeDragArea::OnSelect()  // token 0x06001269 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelativeDragArea::OnDragStart()  // token 0x0600126A rva 0x581a4 attrs Public, Virtual, HideBySig
    // code size 88 (0x58), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TFUISliderRelativeDragArea::inDrag  /*0x04001628*/
    IL_0007: ldarg.0
    IL_0008: ldfld MMF_Player TFUISliderRelativeDragArea::onStartDrag  /*0x04001623*/
    IL_000d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0012: ldarg.0
    IL_0013: ldfld bool TFUISliderRelativeDragArea::colorInitialized  /*0x04001626*/
    IL_0018: brtrue.s IL_0020
    IL_001a: ldarg.0
    IL_001b: call void TFUISliderRelativeDragArea::InitColor()  /*0x0600126D*/
    IL_0020: ldarg.0
    IL_0021: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0026: ldfld MPImageBasic TFUISliderRelative::fillImg  /*0x04001615*/
    IL_002b: ldarg.0
    IL_002c: ldfld Color TFUISliderRelativeDragArea::dragColor  /*0x04001622*/
    IL_0031: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0036: ldarg.0
    IL_0037: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_003c: ldfld MPImageBasic TFUISliderRelative::knobImg  /*0x04001616*/
    IL_0041: ldarg.0
    IL_0042: ldfld Color TFUISliderRelativeDragArea::dragColor  /*0x04001622*/
    IL_0047: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_004c: ldarg.0
    IL_004d: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0052: callvirt void TFUISliderRelative::OnBeginDrag()  /*0x0600125E*/
    IL_0057: ret

  .method TFUISliderRelativeDragArea::OnDrag(UnityEngine.Vector2)  // token 0x0600126B rva 0x25f1 attrs Public, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelativeDragArea::OnDragEnd()  // token 0x0600126C rva 0x58208 attrs Public, Virtual, HideBySig
    // code size 92 (0x5c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player TFUISliderRelativeDragArea::onEndDrag  /*0x04001624*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_000b: ldarg.0
    IL_000c: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0011: ldfld MPImageBasic TFUISliderRelative::fillImg  /*0x04001615*/
    IL_0016: ldarg.0
    IL_0017: ldfld Color TFUISliderRelativeDragArea::defaultColor  /*0x04001625*/
    IL_001c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0021: ldarg.0
    IL_0022: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0027: ldfld MPImageBasic TFUISliderRelative::knobImg  /*0x04001616*/
    IL_002c: ldarg.0
    IL_002d: ldfld Color TFUISliderRelativeDragArea::defaultColor  /*0x04001625*/
    IL_0032: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.0
    IL_0039: stfld bool TFUISliderRelativeDragArea::inDrag  /*0x04001628*/
    IL_003e: ldarg.0
    IL_003f: ldc.i4.1
    IL_0040: stfld bool TFUISliderRelativeDragArea::delayedDisable  /*0x04001627*/
    IL_0045: ldarg.0
    IL_0046: ldc.r4 0f
    IL_004b: stfld float TFUISliderRelativeDragArea::afterDragCounter  /*0x04001629*/
    IL_0050: ldarg.0
    IL_0051: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0056: callvirt void TFUISliderRelative::OnEndDrag()  /*0x0600125F*/
    IL_005b: ret

  .method TFUISliderRelativeDragArea::InitColor()  // token 0x0600126D rva 0x58270 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0007: ldfld MPImageBasic TFUISliderRelative::fillImg  /*0x04001615*/
    IL_000c: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0011: stfld Color TFUISliderRelativeDragArea::defaultColor  /*0x04001625*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool TFUISliderRelativeDragArea::colorInitialized  /*0x04001626*/
    IL_001d: ret

  .method TFUISliderRelativeDragArea::OnEnable()  // token 0x0600126E rva 0x5828f attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderRelativeDragArea::colorInitialized  /*0x04001626*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUISliderRelativeDragArea::InitColor()  /*0x0600126D*/
    IL_000e: ldarg.0
    IL_000f: ldfld TFUISliderRelative TFUISliderRelativeDragArea::target  /*0x04001621*/
    IL_0014: ldfld MPImageBasic TFUISliderRelative::fillImg  /*0x04001615*/
    IL_0019: ldarg.0
    IL_001a: ldfld Color TFUISliderRelativeDragArea::defaultColor  /*0x04001625*/
    IL_001f: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.0
    IL_0026: stfld bool TFUISliderRelativeDragArea::inDrag  /*0x04001628*/
    IL_002b: ret

  .method TFUISliderRelativeDragArea::.ctor()  // token 0x0600126F rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

