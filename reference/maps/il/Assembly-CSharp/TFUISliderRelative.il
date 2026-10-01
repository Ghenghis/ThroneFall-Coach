// ===== TFUISliderRelative  (token 0x02000359) =====
  .method TFUISliderRelative::Start()  // token 0x06001255 rva 0x57c54 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUISliderRelative::target  /*0x0400160D*/
    IL_0006: ldfld UnityEvent<ThronefallUIElement.NavigationDirection> ThronefallUIElement::onEmptyNavigate  /*0x04001687*/
    IL_000b: ldarg.0
    IL_000c: ldftn void TFUISliderRelative::Navigate(ThronefallUIElement.NavigationDirection)  /*0x06001259*/
    IL_0012: newobj void UnityEngine.Events.UnityAction<ThronefallUIElement.NavigationDirection>::.ctor(object,IntPtr)  /*0x0A00071C*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent<ThronefallUIElement.NavigationDirection>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A00071D*/
    IL_001c: ldarg.0
    IL_001d: ldfld ThronefallUIElement TFUISliderRelative::target  /*0x0400160D*/
    IL_0022: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0027: ldarg.0
    IL_0028: ldftn void TFUISliderRelative::ToggleSelectionUI()  /*0x06001260*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ldarg.0
    IL_0039: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_003e: ldc.i4.0
    IL_003f: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0044: stfld Player TFUISliderRelative::input  /*0x0400161D*/
    IL_0049: ret

  .method TFUISliderRelative::OnEnable()  // token 0x06001256 rva 0x57caa attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUISliderRelative::ToggleSelectionUI()  /*0x06001260*/
    IL_0006: ret

  .method TFUISliderRelative::Update()  // token 0x06001257 rva 0x57cb4 attrs Private, HideBySig
    // code size 177 (0xb1), max stack 3, init locals
    .locals ([0] float, [1] float, [2] float, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUISliderRelative::isDragging  /*0x0400161E*/
    IL_0006: brfalse IL_00b0
    IL_000b: ldarg.0
    IL_000c: ldfld Player TFUISliderRelative::input  /*0x0400161D*/
    IL_0011: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0016: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_001b: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_0020: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0025: ldarg.0
    IL_0026: ldflda Vector2 TFUISliderRelative::dragStartScreenPos  /*0x0400161F*/
    IL_002b: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0030: sub
    IL_0031: stloc.0
    IL_0032: ldarg.0
    IL_0033: ldfld float TFUISliderRelative::dragStartLocalX  /*0x04001620*/
    IL_0038: ldloc.0
    IL_0039: add
    IL_003a: ldc.r4 0f
    IL_003f: ldarg.0
    IL_0040: ldfld RectTransform TFUISliderRelative::backgroundRect  /*0x04001613*/
    IL_0045: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_004a: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_004f: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0054: stloc.1
    IL_0055: ldc.r4 0f
    IL_005a: ldarg.0
    IL_005b: ldfld RectTransform TFUISliderRelative::backgroundRect  /*0x04001613*/
    IL_0060: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0065: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_006a: ldloc.1
    IL_006b: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0070: stloc.2
    IL_0071: ldarg.0
    IL_0072: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_0077: ldarg.0
    IL_0078: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_007d: ldloc.2
    IL_007e: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0083: ldarg.0
    IL_0084: ldfld float TFUISliderRelative::increments  /*0x0400160B*/
    IL_0089: div
    IL_008a: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_008f: stloc.3
    IL_0090: ldarg.0
    IL_0091: ldarg.0
    IL_0092: ldfld float TFUISliderRelative::increments  /*0x0400160B*/
    IL_0097: ldloc.3
    IL_0098: conv.r4
    IL_0099: mul
    IL_009a: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_009f: ldarg.0
    IL_00a0: call void TFUISliderRelative::UpdateDisplay()  /*0x06001258*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld UnityEvent TFUISliderRelative::onChange  /*0x04001617*/
    IL_00ab: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00b0: ret

  .method TFUISliderRelative::UpdateDisplay()  // token 0x06001258 rva 0x57d74 attrs Private, HideBySig
    // code size 196 (0xc4), max stack 6, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform TFUISliderRelative::fillRect  /*0x04001614*/
    IL_0006: ldc.i4.0
    IL_0007: ldarg.0
    IL_0008: ldfld RectTransform TFUISliderRelative::backgroundRect  /*0x04001613*/
    IL_000d: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0012: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0017: ldarg.0
    IL_0018: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_001d: ldarg.0
    IL_001e: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_0023: ldarg.0
    IL_0024: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0029: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002e: mul
    IL_002f: callvirt void UnityEngine.RectTransform::SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis,float)  /*0x0A00070E*/
    IL_0034: ldarg.0
    IL_0035: ldfld bool TFUISliderRelative::customLabelRemapping  /*0x04001619*/
    IL_003a: brfalse.s IL_0098
    IL_003c: ldarg.0
    IL_003d: ldfld TextMeshProUGUI TFUISliderRelative::display  /*0x04001610*/
    IL_0042: ldarg.0
    IL_0043: ldfld float TFUISliderRelative::minLabelValue  /*0x0400161A*/
    IL_0048: ldarg.0
    IL_0049: ldfld float TFUISliderRelative::maxLabelValue  /*0x0400161B*/
    IL_004e: ldarg.0
    IL_004f: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_0054: ldarg.0
    IL_0055: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_005a: ldarg.0
    IL_005b: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0060: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0065: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_006a: stloc.0
    IL_006b: ldloca.s 0
    IL_006d: ldstr "F"
    IL_0072: ldarg.0
    IL_0073: ldflda int TFUISliderRelative::displayFPPrecision  /*0x0400160C*/
    IL_0078: call string System.Int32::ToString()  /*0x0A000031*/
    IL_007d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0082: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_0087: ldarg.0
    IL_0088: ldfld string TFUISliderRelative::suffix  /*0x0400161C*/
    IL_008d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0092: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0097: ret
    IL_0098: ldarg.0
    IL_0099: ldfld TextMeshProUGUI TFUISliderRelative::display  /*0x04001610*/
    IL_009e: ldarg.0
    IL_009f: ldflda float TFUISliderRelative::value  /*0x0400160A*/
    IL_00a4: ldstr "F"
    IL_00a9: ldarg.0
    IL_00aa: ldflda int TFUISliderRelative::displayFPPrecision  /*0x0400160C*/
    IL_00af: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b4: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b9: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_00be: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00c3: ret

  .method TFUISliderRelative::Navigate(ThronefallUIElement.NavigationDirection)  // token 0x06001259 rva 0x57e44 attrs Public, HideBySig
    // code size 139 (0x8b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent TFUISliderRelative::onNavigate  /*0x04001618*/
    IL_0006: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000b: ldarg.1
    IL_000c: ldarg.0
    IL_000d: ldfld ThronefallUIElement.NavigationDirection TFUISliderRelative::increase  /*0x0400160E*/
    IL_0012: bne.un.s IL_0029
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TFUISliderRelative::increments  /*0x0400160B*/
    IL_0021: add
    IL_0022: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0027: br.s IL_0045
    IL_0029: ldarg.1
    IL_002a: ldarg.0
    IL_002b: ldfld ThronefallUIElement.NavigationDirection TFUISliderRelative::decrease  /*0x0400160F*/
    IL_0030: bne.un.s IL_0045
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0039: ldarg.0
    IL_003a: ldfld float TFUISliderRelative::increments  /*0x0400160B*/
    IL_003f: sub
    IL_0040: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0045: ldarg.0
    IL_0046: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_004b: ldarg.0
    IL_004c: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_0051: ble.un.s IL_005f
    IL_0053: ldarg.0
    IL_0054: ldarg.0
    IL_0055: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_005a: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_005f: ldarg.0
    IL_0060: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0065: ldarg.0
    IL_0066: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_006b: bge.un.s IL_0079
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_0074: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0079: ldarg.0
    IL_007a: call void TFUISliderRelative::UpdateDisplay()  /*0x06001258*/
    IL_007f: ldarg.0
    IL_0080: ldfld UnityEvent TFUISliderRelative::onChange  /*0x04001617*/
    IL_0085: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_008a: ret

  .method TFUISliderRelative::Increase()  // token 0x0600125A rva 0x57edb attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection TFUISliderRelative::increase  /*0x0400160E*/
    IL_0007: call void TFUISliderRelative::Navigate(ThronefallUIElement.NavigationDirection)  /*0x06001259*/
    IL_000c: ret

  .method TFUISliderRelative::Decrease()  // token 0x0600125B rva 0x57ee9 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection TFUISliderRelative::decrease  /*0x0400160F*/
    IL_0007: call void TFUISliderRelative::Navigate(ThronefallUIElement.NavigationDirection)  /*0x06001259*/
    IL_000c: ret

  .method TFUISliderRelative::OnTFUIStateChange()  // token 0x0600125C rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISliderRelative::SetValue(float,bool)  // token 0x0600125D rva 0x57ef8 attrs Public, HideBySig
    // code size 80 (0x50), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0007: ldarg.0
    IL_0008: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_000d: ldarg.0
    IL_000e: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_0013: ble.un.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldarg.0
    IL_0017: ldfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_001c: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0021: ldarg.0
    IL_0022: ldfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0027: ldarg.0
    IL_0028: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_002d: bge.un.s IL_003b
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld float TFUISliderRelative::minValue  /*0x04001608*/
    IL_0036: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_003b: ldarg.0
    IL_003c: call void TFUISliderRelative::UpdateDisplay()  /*0x06001258*/
    IL_0041: ldarg.2
    IL_0042: brfalse.s IL_004f
    IL_0044: ldarg.0
    IL_0045: ldfld UnityEvent TFUISliderRelative::onChange  /*0x04001617*/
    IL_004a: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_004f: ret

  .method TFUISliderRelative::OnBeginDrag()  // token 0x0600125E rva 0x57f54 attrs Public, HideBySig
    // code size 109 (0x6d), max stack 4, init locals
    .locals ([0] Vector2)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TFUISliderRelative::isDragging  /*0x0400161E*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld Player TFUISliderRelative::input  /*0x0400161D*/
    IL_000e: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0013: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0018: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_001d: stfld Vector2 TFUISliderRelative::dragStartScreenPos  /*0x0400161F*/
    IL_0022: ldarg.0
    IL_0023: ldfld RectTransform TFUISliderRelative::backgroundRect  /*0x04001613*/
    IL_0028: ldarg.0
    IL_0029: ldfld Player TFUISliderRelative::input  /*0x0400161D*/
    IL_002e: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0033: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0038: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_003d: ldnull
    IL_003e: ldloca.s 0
    IL_0040: call bool UnityEngine.RectTransformUtility::ScreenPointToLocalPointInRectangle(UnityEngine.RectTransform,UnityEngine.Vector2,UnityEngine.Camera,ref UnityEngine.Vector2)  /*0x0A000712*/
    IL_0045: pop
    IL_0046: ldarg.0
    IL_0047: ldloc.0
    IL_0048: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_004d: ldc.r4 0f
    IL_0052: ldarg.0
    IL_0053: ldfld RectTransform TFUISliderRelative::backgroundRect  /*0x04001613*/
    IL_0058: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_005d: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0062: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_0067: stfld float TFUISliderRelative::dragStartLocalX  /*0x04001620*/
    IL_006c: ret

  .method TFUISliderRelative::OnEndDrag()  // token 0x0600125F rva 0x57fcd attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TFUISliderRelative::isDragging  /*0x0400161E*/
    IL_0007: ret

  .method TFUISliderRelative::ToggleSelectionUI()  // token 0x06001260 rva 0x57fd8 attrs Private, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUISliderRelative::target  /*0x0400160D*/
    IL_0006: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_000b: ldc.i4.3
    IL_000c: beq.s IL_001e
    IL_000e: ldarg.0
    IL_000f: ldfld ThronefallUIElement TFUISliderRelative::target  /*0x0400160D*/
    IL_0014: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_0019: ldc.i4.2
    IL_001a: ceq
    IL_001c: br.s IL_001f
    IL_001e: ldc.i4.1
    IL_001f: stloc.0
    IL_0020: ldarg.0
    IL_0021: ldfld GameObject TFUISliderRelative::knob  /*0x04001611*/
    IL_0026: ldloc.0
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0032: ldnull
    IL_0033: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0038: brfalse.s IL_0046
    IL_003a: ldarg.0
    IL_003b: ldfld GameObject TFUISliderRelative::tooltip  /*0x04001612*/
    IL_0040: ldloc.0
    IL_0041: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0046: ret

  .method TFUISliderRelative::.ctor()  // token 0x06001261 rva 0x5802c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 87 (0x57), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUISliderRelative::maxValue  /*0x04001609*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TFUISliderRelative::value  /*0x0400160A*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.1f
    IL_001c: stfld float TFUISliderRelative::increments  /*0x0400160B*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld int TFUISliderRelative::displayFPPrecision  /*0x0400160C*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.1
    IL_002a: stfld ThronefallUIElement.NavigationDirection TFUISliderRelative::decrease  /*0x0400160F*/
    IL_002f: ldarg.0
    IL_0030: ldc.r4 50f
    IL_0035: stfld float TFUISliderRelative::minLabelValue  /*0x0400161A*/
    IL_003a: ldarg.0
    IL_003b: ldc.r4 150f
    IL_0040: stfld float TFUISliderRelative::maxLabelValue  /*0x0400161B*/
    IL_0045: ldarg.0
    IL_0046: ldstr "%"
    IL_004b: stfld string TFUISliderRelative::suffix  /*0x0400161C*/
    IL_0050: ldarg.0
    IL_0051: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0056: ret

