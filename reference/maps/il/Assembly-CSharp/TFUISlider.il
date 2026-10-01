// ===== TFUISlider  (token 0x02000357) =====
  .method TFUISlider::Start()  // token 0x0600123C rva 0x57684 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUISlider::target  /*0x040015EE*/
    IL_0006: ldfld UnityEvent<ThronefallUIElement.NavigationDirection> ThronefallUIElement::onEmptyNavigate  /*0x04001687*/
    IL_000b: ldarg.0
    IL_000c: ldftn void TFUISlider::Navigate(ThronefallUIElement.NavigationDirection)  /*0x0600123F*/
    IL_0012: newobj void UnityEngine.Events.UnityAction<ThronefallUIElement.NavigationDirection>::.ctor(object,IntPtr)  /*0x0A00071C*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent<ThronefallUIElement.NavigationDirection>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A00071D*/
    IL_001c: ldarg.0
    IL_001d: ldfld ThronefallUIElement TFUISlider::target  /*0x040015EE*/
    IL_0022: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0027: ldarg.0
    IL_0028: ldftn void TFUISlider::ToggleSelectionUI()  /*0x06001245*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ldarg.0
    IL_0039: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_003e: ldc.i4.0
    IL_003f: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0044: stfld Player TFUISlider::input  /*0x040015FE*/
    IL_0049: ret

  .method TFUISlider::OnEnable()  // token 0x0600123D rva 0x576da attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUISlider::ToggleSelectionUI()  /*0x06001245*/
    IL_0006: ret

  .method TFUISlider::UpdateDisplay()  // token 0x0600123E rva 0x576e4 attrs Private, HideBySig
    // code size 196 (0xc4), max stack 6, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform TFUISlider::fillRect  /*0x040015F5*/
    IL_0006: ldc.i4.0
    IL_0007: ldarg.0
    IL_0008: ldfld RectTransform TFUISlider::backgroundRect  /*0x040015F4*/
    IL_000d: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0012: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0017: ldarg.0
    IL_0018: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_001d: ldarg.0
    IL_001e: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_0023: ldarg.0
    IL_0024: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0029: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002e: mul
    IL_002f: callvirt void UnityEngine.RectTransform::SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis,float)  /*0x0A00070E*/
    IL_0034: ldarg.0
    IL_0035: ldfld bool TFUISlider::customLabelRemapping  /*0x040015FA*/
    IL_003a: brfalse.s IL_0098
    IL_003c: ldarg.0
    IL_003d: ldfld TextMeshProUGUI TFUISlider::display  /*0x040015F1*/
    IL_0042: ldarg.0
    IL_0043: ldfld float TFUISlider::minLabelValue  /*0x040015FB*/
    IL_0048: ldarg.0
    IL_0049: ldfld float TFUISlider::maxLabelValue  /*0x040015FC*/
    IL_004e: ldarg.0
    IL_004f: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_0054: ldarg.0
    IL_0055: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_005a: ldarg.0
    IL_005b: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0060: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0065: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_006a: stloc.0
    IL_006b: ldloca.s 0
    IL_006d: ldstr "F"
    IL_0072: ldarg.0
    IL_0073: ldflda int TFUISlider::displayFPPrecision  /*0x040015ED*/
    IL_0078: call string System.Int32::ToString()  /*0x0A000031*/
    IL_007d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0082: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_0087: ldarg.0
    IL_0088: ldfld string TFUISlider::suffix  /*0x040015FD*/
    IL_008d: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0092: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0097: ret
    IL_0098: ldarg.0
    IL_0099: ldfld TextMeshProUGUI TFUISlider::display  /*0x040015F1*/
    IL_009e: ldarg.0
    IL_009f: ldflda float TFUISlider::value  /*0x040015EB*/
    IL_00a4: ldstr "F"
    IL_00a9: ldarg.0
    IL_00aa: ldflda int TFUISlider::displayFPPrecision  /*0x040015ED*/
    IL_00af: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00b4: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b9: call string System.Single::ToString(string)  /*0x0A000623*/
    IL_00be: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00c3: ret

  .method TFUISlider::Navigate(ThronefallUIElement.NavigationDirection)  // token 0x0600123F rva 0x577b4 attrs Public, HideBySig
    // code size 139 (0x8b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent TFUISlider::onNavigate  /*0x040015F9*/
    IL_0006: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_000b: ldarg.1
    IL_000c: ldarg.0
    IL_000d: ldfld ThronefallUIElement.NavigationDirection TFUISlider::increase  /*0x040015EF*/
    IL_0012: bne.un.s IL_0029
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TFUISlider::increments  /*0x040015EC*/
    IL_0021: add
    IL_0022: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0027: br.s IL_0045
    IL_0029: ldarg.1
    IL_002a: ldarg.0
    IL_002b: ldfld ThronefallUIElement.NavigationDirection TFUISlider::decrease  /*0x040015F0*/
    IL_0030: bne.un.s IL_0045
    IL_0032: ldarg.0
    IL_0033: ldarg.0
    IL_0034: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0039: ldarg.0
    IL_003a: ldfld float TFUISlider::increments  /*0x040015EC*/
    IL_003f: sub
    IL_0040: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0045: ldarg.0
    IL_0046: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_004b: ldarg.0
    IL_004c: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_0051: ble.un.s IL_005f
    IL_0053: ldarg.0
    IL_0054: ldarg.0
    IL_0055: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_005a: stfld float TFUISlider::value  /*0x040015EB*/
    IL_005f: ldarg.0
    IL_0060: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0065: ldarg.0
    IL_0066: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_006b: bge.un.s IL_0079
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_0074: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0079: ldarg.0
    IL_007a: call void TFUISlider::UpdateDisplay()  /*0x0600123E*/
    IL_007f: ldarg.0
    IL_0080: ldfld UnityEvent TFUISlider::onChange  /*0x040015F8*/
    IL_0085: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_008a: ret

  .method TFUISlider::Increase()  // token 0x06001240 rva 0x5784b attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection TFUISlider::increase  /*0x040015EF*/
    IL_0007: call void TFUISlider::Navigate(ThronefallUIElement.NavigationDirection)  /*0x0600123F*/
    IL_000c: ret

  .method TFUISlider::Decrease()  // token 0x06001241 rva 0x57859 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection TFUISlider::decrease  /*0x040015F0*/
    IL_0007: call void TFUISlider::Navigate(ThronefallUIElement.NavigationDirection)  /*0x0600123F*/
    IL_000c: ret

  .method TFUISlider::OnTFUIStateChange()  // token 0x06001242 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUISlider::SetValue(float)  // token 0x06001243 rva 0x57868 attrs Public, HideBySig
    // code size 66 (0x42), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0007: ldarg.0
    IL_0008: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_000d: ldarg.0
    IL_000e: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_0013: ble.un.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldarg.0
    IL_0017: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_001c: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0021: ldarg.0
    IL_0022: ldfld float TFUISlider::value  /*0x040015EB*/
    IL_0027: ldarg.0
    IL_0028: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_002d: bge.un.s IL_003b
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_0036: stfld float TFUISlider::value  /*0x040015EB*/
    IL_003b: ldarg.0
    IL_003c: call void TFUISlider::UpdateDisplay()  /*0x0600123E*/
    IL_0041: ret

  .method TFUISlider::SetValueByScreenPoint(UnityEngine.Vector2)  // token 0x06001244 rva 0x578b8 attrs Public, HideBySig
    // code size 205 (0xcd), max stack 4, init locals
    .locals ([0] float, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform TFUISlider::backgroundRect  /*0x040015F4*/
    IL_0006: ldarg.0
    IL_0007: ldfld Player TFUISlider::input  /*0x040015FE*/
    IL_000c: ldfld Player.ControllerHelper Rewired.Player::controllers  /*0x0A000004*/
    IL_0011: callvirt Mouse Rewired.Player.ControllerHelper::get_Mouse()  /*0x0A000710*/
    IL_0016: callvirt Vector2 Rewired.Mouse::get_screenPosition()  /*0x0A000711*/
    IL_001b: ldnull
    IL_001c: ldarga.s 1
    IL_001e: call bool UnityEngine.RectTransformUtility::ScreenPointToLocalPointInRectangle(UnityEngine.RectTransform,UnityEngine.Vector2,UnityEngine.Camera,ref UnityEngine.Vector2)  /*0x0A000712*/
    IL_0023: pop
    IL_0024: ldarg.1
    IL_0025: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_002a: ldc.r4 0f
    IL_002f: bge.un.s IL_003d
    IL_0031: ldarga.s 1
    IL_0033: ldc.r4 0f
    IL_0038: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_003d: ldarg.1
    IL_003e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0043: ldarg.0
    IL_0044: ldfld RectTransform TFUISlider::backgroundRect  /*0x040015F4*/
    IL_0049: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_004e: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0053: ble.un.s IL_006c
    IL_0055: ldarga.s 1
    IL_0057: ldarg.0
    IL_0058: ldfld RectTransform TFUISlider::backgroundRect  /*0x040015F4*/
    IL_005d: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0062: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0067: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_006c: ldc.r4 0f
    IL_0071: ldarg.0
    IL_0072: ldfld RectTransform TFUISlider::backgroundRect  /*0x040015F4*/
    IL_0077: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_007c: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0081: ldarg.1
    IL_0082: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0087: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_008c: stloc.0
    IL_008d: ldarg.0
    IL_008e: ldfld float TFUISlider::minValue  /*0x040015E9*/
    IL_0093: ldarg.0
    IL_0094: ldfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_0099: ldloc.0
    IL_009a: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_009f: ldarg.0
    IL_00a0: ldfld float TFUISlider::increments  /*0x040015EC*/
    IL_00a5: div
    IL_00a6: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_00ab: stloc.1
    IL_00ac: ldarg.0
    IL_00ad: ldarg.0
    IL_00ae: ldfld float TFUISlider::increments  /*0x040015EC*/
    IL_00b3: ldloc.1
    IL_00b4: conv.r4
    IL_00b5: mul
    IL_00b6: stfld float TFUISlider::value  /*0x040015EB*/
    IL_00bb: ldarg.0
    IL_00bc: call void TFUISlider::UpdateDisplay()  /*0x0600123E*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld UnityEvent TFUISlider::onChange  /*0x040015F8*/
    IL_00c7: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00cc: ret

  .method TFUISlider::ToggleSelectionUI()  // token 0x06001245 rva 0x57994 attrs Private, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUISlider::target  /*0x040015EE*/
    IL_0006: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_000b: ldc.i4.3
    IL_000c: beq.s IL_001e
    IL_000e: ldarg.0
    IL_000f: ldfld ThronefallUIElement TFUISlider::target  /*0x040015EE*/
    IL_0014: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_0019: ldc.i4.2
    IL_001a: ceq
    IL_001c: br.s IL_001f
    IL_001e: ldc.i4.1
    IL_001f: stloc.0
    IL_0020: ldarg.0
    IL_0021: ldfld GameObject TFUISlider::knob  /*0x040015F2*/
    IL_0026: ldloc.0
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0032: ldnull
    IL_0033: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0038: brfalse.s IL_0046
    IL_003a: ldarg.0
    IL_003b: ldfld GameObject TFUISlider::tooltip  /*0x040015F3*/
    IL_0040: ldloc.0
    IL_0041: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0046: ret

  .method TFUISlider::.ctor()  // token 0x06001246 rva 0x579e8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 87 (0x57), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUISlider::maxValue  /*0x040015EA*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TFUISlider::value  /*0x040015EB*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.1f
    IL_001c: stfld float TFUISlider::increments  /*0x040015EC*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld int TFUISlider::displayFPPrecision  /*0x040015ED*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.1
    IL_002a: stfld ThronefallUIElement.NavigationDirection TFUISlider::decrease  /*0x040015F0*/
    IL_002f: ldarg.0
    IL_0030: ldc.r4 50f
    IL_0035: stfld float TFUISlider::minLabelValue  /*0x040015FB*/
    IL_003a: ldarg.0
    IL_003b: ldc.r4 150f
    IL_0040: stfld float TFUISlider::maxLabelValue  /*0x040015FC*/
    IL_0045: ldarg.0
    IL_0046: ldstr "%"
    IL_004b: stfld string TFUISlider::suffix  /*0x040015FD*/
    IL_0050: ldarg.0
    IL_0051: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0056: ret

