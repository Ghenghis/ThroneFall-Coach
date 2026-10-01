// ===== ControlMapButton  (token 0x020002E9) =====
  .method ControlMapButton::get_descriptor()  // token 0x06001008 rva 0x49114 attrs Private, HideBySig, SpecialName
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_001f
    IL_0009: ldarg.0
    IL_000a: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_000f: callvirt string Rewired.InputAction::get_name()  /*0x0A00064E*/
    IL_0014: ldstr " Positive"
    IL_0019: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_0025: ldc.i4.2
    IL_0026: bne.un.s IL_003e
    IL_0028: ldarg.0
    IL_0029: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_002e: callvirt string Rewired.InputAction::get_name()  /*0x0A00064E*/
    IL_0033: ldstr " Negative"
    IL_0038: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_0044: callvirt string Rewired.InputAction::get_name()  /*0x0A00064E*/
    IL_0049: ret

  .method ControlMapButton::Start()  // token 0x06001009 rva 0x4916c attrs Private, HideBySig
    // code size 69 (0x45), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ControlMapButton::selectionIndicator  /*0x040012DB*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0012: ldfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_0017: ldarg.0
    IL_0018: ldftn void ControlMapButton::OnApply()  /*0x0600100E*/
    IL_001e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0023: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0028: ldarg.0
    IL_0029: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_002e: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0033: ldarg.0
    IL_0034: ldftn void ControlMapButton::UpdateSelectionIndicator()  /*0x0600100F*/
    IL_003a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0044: ret

  .method ControlMapButton::SetData(Rewired.InputAction,KeyRebinder,ControlMapButton.AxisMode)  // token 0x0600100A rva 0x491c0 attrs Public, HideBySig
    // code size 67 (0x43), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.3
    IL_0002: stfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_0007: ldarg.0
    IL_0008: ldarg.2
    IL_0009: stfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_000e: ldarg.0
    IL_000f: ldarg.1
    IL_0010: stfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_0015: ldarg.0
    IL_0016: call void ControlMapButton::Refresh()  /*0x0600100B*/
    IL_001b: ldarg.0
    IL_001c: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0021: ldstr "Controls/"
    IL_0026: ldarg.0
    IL_0027: call string ControlMapButton::get_descriptor()  /*0x06001008*/
    IL_002c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0031: ldc.i4.1
    IL_0032: ldc.i4.0
    IL_0033: ldc.i4.1
    IL_0034: ldc.i4.0
    IL_0035: ldnull
    IL_0036: ldnull
    IL_0037: ldc.i4.1
    IL_0038: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_003d: callvirt void TFUITextButton::SetOriginalString(string)  /*0x0600127C*/
    IL_0042: ret

  .method ControlMapButton::Refresh()  // token 0x0600100B rva 0x4920f attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ControlMapButton::UpdateMappings()  /*0x0600100C*/
    IL_0006: ldarg.0
    IL_0007: call void ControlMapButton::UpdateLabels()  /*0x0600100D*/
    IL_000c: ret

  .method ControlMapButton::UpdateMappings()  // token 0x0600100C rva 0x49220 attrs Private, HideBySig
    // code size 501 (0x1f5), max stack 3, init locals
    .locals ([0] List<ActionElementMap>, [1] List<ActionElementMap>, [2] List<ActionElementMap>, [3] int, [4] ActionElementMap, [5] ControlMapButton.AxisMode, [6] int, [7] ActionElementMap, [8] int, [9] ActionElementMap)
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld ActionElementMap ControlMapButton::keyMap  /*0x040012E2*/
    IL_0007: ldarg.0
    IL_0008: ldnull
    IL_0009: stfld ActionElementMap ControlMapButton::mouseMap  /*0x040012E3*/
    IL_000e: ldarg.0
    IL_000f: ldnull
    IL_0010: stfld ActionElementMap ControlMapButton::joystickMap  /*0x040012E4*/
    IL_0015: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor()  /*0x0A00064F*/
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0021: callvirt ControllerMap KeyRebinder::get_KeyboardMap()  /*0x0600110C*/
    IL_0026: brfalse.s IL_0049
    IL_0028: ldarg.0
    IL_0029: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_002e: callvirt ControllerMap KeyRebinder::get_KeyboardMap()  /*0x0600110C*/
    IL_0033: ldarg.0
    IL_0034: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_0039: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_003e: callvirt ActionElementMap[] Rewired.ControllerMap::GetElementMapsWithAction(int)  /*0x0A000650*/
    IL_0043: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000651*/
    IL_0048: stloc.0
    IL_0049: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor()  /*0x0A00064F*/
    IL_004e: stloc.1
    IL_004f: ldarg.0
    IL_0050: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0055: callvirt ControllerMap KeyRebinder::get_MouseMap()  /*0x0600110D*/
    IL_005a: brfalse.s IL_007d
    IL_005c: ldarg.0
    IL_005d: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0062: callvirt ControllerMap KeyRebinder::get_MouseMap()  /*0x0600110D*/
    IL_0067: ldarg.0
    IL_0068: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_006d: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_0072: callvirt ActionElementMap[] Rewired.ControllerMap::GetElementMapsWithAction(int)  /*0x0A000650*/
    IL_0077: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000651*/
    IL_007c: stloc.1
    IL_007d: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor()  /*0x0A00064F*/
    IL_0082: stloc.2
    IL_0083: ldarg.0
    IL_0084: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0089: callvirt ControllerMap KeyRebinder::get_JoystickMap()  /*0x0600110E*/
    IL_008e: brfalse.s IL_00b1
    IL_0090: ldarg.0
    IL_0091: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0096: callvirt ControllerMap KeyRebinder::get_JoystickMap()  /*0x0600110E*/
    IL_009b: ldarg.0
    IL_009c: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_00a1: callvirt int Rewired.InputAction::get_id()  /*0x0A0003F3*/
    IL_00a6: callvirt ActionElementMap[] Rewired.ControllerMap::GetElementMapsWithAction(int)  /*0x0A000650*/
    IL_00ab: newobj void System.Collections.Generic.List<Rewired.ActionElementMap>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000651*/
    IL_00b0: stloc.2
    IL_00b1: ldloc.0
    IL_00b2: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_00b7: ldc.i4.1
    IL_00b8: sub
    IL_00b9: stloc.3
    IL_00ba: br.s IL_00fe
    IL_00bc: ldloc.0
    IL_00bd: ldloc.3
    IL_00be: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_00c3: stloc.s 4
    IL_00c5: ldarg.0
    IL_00c6: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_00cb: stloc.s 5
    IL_00cd: ldloc.s 5
    IL_00cf: ldc.i4.1
    IL_00d0: beq.s IL_00ea
    IL_00d2: ldloc.s 5
    IL_00d4: ldc.i4.2
    IL_00d5: bne.un.s IL_00fa
    IL_00d7: ldloc.s 4
    IL_00d9: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_00de: ldc.i4.1
    IL_00df: beq.s IL_00fa
    IL_00e1: ldloc.0
    IL_00e2: ldloc.3
    IL_00e3: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_00e8: br.s IL_00fa
    IL_00ea: ldloc.s 4
    IL_00ec: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_00f1: brfalse.s IL_00fa
    IL_00f3: ldloc.0
    IL_00f4: ldloc.3
    IL_00f5: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_00fa: ldloc.3
    IL_00fb: ldc.i4.1
    IL_00fc: sub
    IL_00fd: stloc.3
    IL_00fe: ldloc.3
    IL_00ff: ldc.i4.0
    IL_0100: bge.s IL_00bc
    IL_0102: ldloc.1
    IL_0103: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_0108: ldc.i4.1
    IL_0109: sub
    IL_010a: stloc.s 6
    IL_010c: br.s IL_0155
    IL_010e: ldloc.1
    IL_010f: ldloc.s 6
    IL_0111: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_0116: stloc.s 7
    IL_0118: ldarg.0
    IL_0119: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_011e: stloc.s 5
    IL_0120: ldloc.s 5
    IL_0122: ldc.i4.1
    IL_0123: beq.s IL_013e
    IL_0125: ldloc.s 5
    IL_0127: ldc.i4.2
    IL_0128: bne.un.s IL_014f
    IL_012a: ldloc.s 7
    IL_012c: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_0131: ldc.i4.1
    IL_0132: beq.s IL_014f
    IL_0134: ldloc.1
    IL_0135: ldloc.s 6
    IL_0137: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_013c: br.s IL_014f
    IL_013e: ldloc.s 7
    IL_0140: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_0145: brfalse.s IL_014f
    IL_0147: ldloc.1
    IL_0148: ldloc.s 6
    IL_014a: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_014f: ldloc.s 6
    IL_0151: ldc.i4.1
    IL_0152: sub
    IL_0153: stloc.s 6
    IL_0155: ldloc.s 6
    IL_0157: ldc.i4.0
    IL_0158: bge.s IL_010e
    IL_015a: ldloc.2
    IL_015b: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_0160: ldc.i4.1
    IL_0161: sub
    IL_0162: stloc.s 8
    IL_0164: br.s IL_01ad
    IL_0166: ldloc.2
    IL_0167: ldloc.s 8
    IL_0169: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_016e: stloc.s 9
    IL_0170: ldarg.0
    IL_0171: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_0176: stloc.s 5
    IL_0178: ldloc.s 5
    IL_017a: ldc.i4.1
    IL_017b: beq.s IL_0196
    IL_017d: ldloc.s 5
    IL_017f: ldc.i4.2
    IL_0180: bne.un.s IL_01a7
    IL_0182: ldloc.s 9
    IL_0184: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_0189: ldc.i4.1
    IL_018a: beq.s IL_01a7
    IL_018c: ldloc.2
    IL_018d: ldloc.s 8
    IL_018f: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_0194: br.s IL_01a7
    IL_0196: ldloc.s 9
    IL_0198: callvirt Pole Rewired.ActionElementMap::get_axisContribution()  /*0x0A000403*/
    IL_019d: brfalse.s IL_01a7
    IL_019f: ldloc.2
    IL_01a0: ldloc.s 8
    IL_01a2: callvirt void System.Collections.Generic.List<Rewired.ActionElementMap>::RemoveAt(int)  /*0x0A000654*/
    IL_01a7: ldloc.s 8
    IL_01a9: ldc.i4.1
    IL_01aa: sub
    IL_01ab: stloc.s 8
    IL_01ad: ldloc.s 8
    IL_01af: ldc.i4.0
    IL_01b0: bge.s IL_0166
    IL_01b2: ldloc.0
    IL_01b3: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_01b8: ldc.i4.0
    IL_01b9: ble.s IL_01c8
    IL_01bb: ldarg.0
    IL_01bc: ldloc.0
    IL_01bd: ldc.i4.0
    IL_01be: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_01c3: stfld ActionElementMap ControlMapButton::keyMap  /*0x040012E2*/
    IL_01c8: ldloc.1
    IL_01c9: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_01ce: ldc.i4.0
    IL_01cf: ble.s IL_01de
    IL_01d1: ldarg.0
    IL_01d2: ldloc.1
    IL_01d3: ldc.i4.0
    IL_01d4: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_01d9: stfld ActionElementMap ControlMapButton::mouseMap  /*0x040012E3*/
    IL_01de: ldloc.2
    IL_01df: callvirt int System.Collections.Generic.List<Rewired.ActionElementMap>::get_Count()  /*0x0A000652*/
    IL_01e4: ldc.i4.0
    IL_01e5: ble.s IL_01f4
    IL_01e7: ldarg.0
    IL_01e8: ldloc.2
    IL_01e9: ldc.i4.0
    IL_01ea: callvirt !0 System.Collections.Generic.List<Rewired.ActionElementMap>::get_Item(int)  /*0x0A000653*/
    IL_01ef: stfld ActionElementMap ControlMapButton::joystickMap  /*0x040012E4*/
    IL_01f4: ret

  .method ControlMapButton::UpdateLabels()  // token 0x0600100D rva 0x49424 attrs Private, HideBySig
    // code size 124 (0x7c), max stack 2, init locals
    .locals ([0] string, [1] string, [2] string)
    IL_0000: ldarg.0
    IL_0001: ldfld ActionElementMap ControlMapButton::keyMap  /*0x040012E2*/
    IL_0006: brtrue.s IL_0010
    IL_0008: ldstr "﹘"
    IL_000d: stloc.0
    IL_000e: br.s IL_001d
    IL_0010: ldarg.0
    IL_0011: ldfld ActionElementMap ControlMapButton::keyMap  /*0x040012E2*/
    IL_0016: ldc.i4.0
    IL_0017: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_001c: stloc.0
    IL_001d: ldarg.0
    IL_001e: ldfld ActionElementMap ControlMapButton::mouseMap  /*0x040012E3*/
    IL_0023: brtrue.s IL_002d
    IL_0025: ldstr "﹘"
    IL_002a: stloc.1
    IL_002b: br.s IL_003a
    IL_002d: ldarg.0
    IL_002e: ldfld ActionElementMap ControlMapButton::mouseMap  /*0x040012E3*/
    IL_0033: ldc.i4.0
    IL_0034: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_0039: stloc.1
    IL_003a: ldarg.0
    IL_003b: ldfld ActionElementMap ControlMapButton::joystickMap  /*0x040012E4*/
    IL_0040: brfalse.s IL_0051
    IL_0042: ldarg.0
    IL_0043: ldfld ActionElementMap ControlMapButton::joystickMap  /*0x040012E4*/
    IL_0048: ldc.i4.0
    IL_0049: call string InputActionGlyph::GetGlyphFromElementMap(Rewired.ActionElementMap,bool)  /*0x06001102*/
    IL_004e: stloc.2
    IL_004f: br.s IL_0057
    IL_0051: ldstr "﹘"
    IL_0056: stloc.2
    IL_0057: ldarg.0
    IL_0058: ldfld TextMeshProUGUI ControlMapButton::displayKeyboard  /*0x040012DC*/
    IL_005d: ldloc.0
    IL_005e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0063: ldarg.0
    IL_0064: ldfld TextMeshProUGUI ControlMapButton::displayMouse  /*0x040012DD*/
    IL_0069: ldloc.1
    IL_006a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_006f: ldarg.0
    IL_0070: ldfld TextMeshProUGUI ControlMapButton::displayController  /*0x040012DE*/
    IL_0075: ldloc.2
    IL_0076: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007b: ret

  .method ControlMapButton::OnApply()  // token 0x0600100E rva 0x494ac attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld KeyRebinder ControlMapButton::targetRebinder  /*0x040012E1*/
    IL_0006: ldarg.0
    IL_0007: ldfld InputAction ControlMapButton::actionToMap  /*0x040012E0*/
    IL_000c: ldarg.0
    IL_000d: ldfld ActionElementMap ControlMapButton::keyMap  /*0x040012E2*/
    IL_0012: ldarg.0
    IL_0013: ldfld ActionElementMap ControlMapButton::mouseMap  /*0x040012E3*/
    IL_0018: ldarg.0
    IL_0019: ldfld ActionElementMap ControlMapButton::joystickMap  /*0x040012E4*/
    IL_001e: ldarg.0
    IL_001f: ldfld ControlMapButton.AxisMode ControlMapButton::axisMode  /*0x040012DF*/
    IL_0024: callvirt void KeyRebinder::TriggerRebind(Rewired.InputAction,Rewired.ActionElementMap,Rewired.ActionElementMap,Rewired.ActionElementMap,ControlMapButton.AxisMode)  /*0x0600111B*/
    IL_0029: ret

  .method ControlMapButton::UpdateSelectionIndicator()  // token 0x0600100F rva 0x494d7 attrs Private, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUITextButton ControlMapButton::target  /*0x040012DA*/
    IL_0006: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_000b: ldc.i4.2
    IL_000c: bne.un.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ControlMapButton::selectionIndicator  /*0x040012DB*/
    IL_0014: ldc.i4.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject ControlMapButton::selectionIndicator  /*0x040012DB*/
    IL_0021: ldc.i4.0
    IL_0022: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0027: ret

  .method ControlMapButton::.ctor()  // token 0x06001010 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== ControlMapButton/AxisMode  (token 0x020002EA) =====
