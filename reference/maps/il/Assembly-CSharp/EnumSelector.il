// ===== EnumSelector  (token 0x02000304) =====
  .method EnumSelector::get_Index()  // token 0x060010AE rva 0x4ca48 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0006: ret

  .method EnumSelector::Start()  // token 0x060010AF rva 0x4ca50 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement EnumSelector::target  /*0x040013CB*/
    IL_0006: ldfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_000b: ldarg.0
    IL_000c: ldftn void EnumSelector::PropagateDelayedChange()  /*0x060010B7*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld ThronefallUIElement EnumSelector::target  /*0x040013CB*/
    IL_0022: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0027: ldarg.0
    IL_0028: ldftn void EnumSelector::OnLinkedTFUINavigate()  /*0x060010B6*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ret

  .method EnumSelector::UpdateDisplay()  // token 0x060010B0 rva 0x4ca8c attrs Public, HideBySig
    // code size 126 (0x7e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnumSelector::unpropagatedChanges  /*0x040013D7*/
    IL_0006: brfalse.s IL_0048
    IL_0008: ldarg.0
    IL_0009: ldfld TextMeshProUGUI EnumSelector::display  /*0x040013D2*/
    IL_000e: ldarg.0
    IL_000f: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0014: ldarg.0
    IL_0015: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_001a: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_001f: ldstr "<style=Settings Warning> *</style>"
    IL_0024: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0029: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_002e: ldarg.0
    IL_002f: ldfld GameObject EnumSelector::applyButton  /*0x040013CF*/
    IL_0034: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0039: brfalse.s IL_007d
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject EnumSelector::applyButton  /*0x040013CF*/
    IL_0041: ldc.i4.1
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldfld TextMeshProUGUI EnumSelector::display  /*0x040013D2*/
    IL_004e: ldarg.0
    IL_004f: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0054: ldarg.0
    IL_0055: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_005a: callvirt !0 System.Collections.Generic.List<string>::get_Item(int)  /*0x0A000362*/
    IL_005f: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0064: ldarg.0
    IL_0065: ldfld GameObject EnumSelector::applyButton  /*0x040013CF*/
    IL_006a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_006f: brfalse.s IL_007d
    IL_0071: ldarg.0
    IL_0072: ldfld GameObject EnumSelector::applyButton  /*0x040013CF*/
    IL_0077: ldc.i4.0
    IL_0078: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007d: ret

  .method EnumSelector::Navigate(ThronefallUIElement.NavigationDirection)  // token 0x060010B1 rva 0x4cb18 attrs Public, HideBySig
    // code size 185 (0xb9), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection EnumSelector::increase  /*0x040013D0*/
    IL_0007: bne.un.s IL_0024
    IL_0009: ldarg.0
    IL_000a: ldfld UnityEvent EnumSelector::onIncrease  /*0x040013D5*/
    IL_000f: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_001b: ldc.i4.1
    IL_001c: add
    IL_001d: stfld int EnumSelector::index  /*0x040013CD*/
    IL_0022: br.s IL_0046
    IL_0024: ldarg.1
    IL_0025: ldarg.0
    IL_0026: ldfld ThronefallUIElement.NavigationDirection EnumSelector::decrease  /*0x040013D1*/
    IL_002b: bne.un.s IL_0046
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0034: ldc.i4.1
    IL_0035: sub
    IL_0036: stfld int EnumSelector::index  /*0x040013CD*/
    IL_003b: ldarg.0
    IL_003c: ldfld UnityEvent EnumSelector::onDecrease  /*0x040013D6*/
    IL_0041: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0046: ldarg.0
    IL_0047: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_004c: ldarg.0
    IL_004d: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0052: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0057: ldc.i4.1
    IL_0058: sub
    IL_0059: ble.s IL_0062
    IL_005b: ldarg.0
    IL_005c: ldc.i4.0
    IL_005d: stfld int EnumSelector::index  /*0x040013CD*/
    IL_0062: ldarg.0
    IL_0063: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0068: ldc.i4.0
    IL_0069: bge.s IL_007e
    IL_006b: ldarg.0
    IL_006c: ldarg.0
    IL_006d: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0072: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0077: ldc.i4.1
    IL_0078: sub
    IL_0079: stfld int EnumSelector::index  /*0x040013CD*/
    IL_007e: ldarg.0
    IL_007f: ldfld bool EnumSelector::delayedApply  /*0x040013CE*/
    IL_0084: brfalse.s IL_009d
    IL_0086: ldarg.0
    IL_0087: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_008c: ldarg.0
    IL_008d: ldfld int EnumSelector::bufferIndex  /*0x040013D8*/
    IL_0092: beq.s IL_009d
    IL_0094: ldarg.0
    IL_0095: ldc.i4.1
    IL_0096: stfld bool EnumSelector::unpropagatedChanges  /*0x040013D7*/
    IL_009b: br.s IL_00a4
    IL_009d: ldarg.0
    IL_009e: ldc.i4.0
    IL_009f: stfld bool EnumSelector::unpropagatedChanges  /*0x040013D7*/
    IL_00a4: ldarg.0
    IL_00a5: call void EnumSelector::UpdateDisplay()  /*0x060010B0*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld bool EnumSelector::delayedApply  /*0x040013CE*/
    IL_00b0: brtrue.s IL_00b8
    IL_00b2: ldarg.0
    IL_00b3: call void EnumSelector::ApplyChanges()  /*0x060010B8*/
    IL_00b8: ret

  .method EnumSelector::Increase()  // token 0x060010B2 rva 0x4cbdd attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection EnumSelector::increase  /*0x040013D0*/
    IL_0007: call void EnumSelector::Navigate(ThronefallUIElement.NavigationDirection)  /*0x060010B1*/
    IL_000c: ret

  .method EnumSelector::Decrease()  // token 0x060010B3 rva 0x4cbeb attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.NavigationDirection EnumSelector::decrease  /*0x040013D1*/
    IL_0007: call void EnumSelector::Navigate(ThronefallUIElement.NavigationDirection)  /*0x060010B1*/
    IL_000c: ret

  .method EnumSelector::OnTFUIStateChange()  // token 0x060010B4 rva 0x4cbf9 attrs Public, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement EnumSelector::target  /*0x040013CB*/
    IL_0006: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_000b: brfalse.s IL_001a
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject EnumSelector::buttons  /*0x040013D3*/
    IL_0013: ldc.i4.1
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld GameObject EnumSelector::buttons  /*0x040013D3*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0026: ret

  .method EnumSelector::SetIndex(int)  // token 0x060010B5 rva 0x4cc24 attrs Public, HideBySig
    // code size 82 (0x52), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int EnumSelector::index  /*0x040013CD*/
    IL_0007: ldarg.0
    IL_0008: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_000d: ldarg.0
    IL_000e: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0013: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0018: ldc.i4.1
    IL_0019: sub
    IL_001a: ble.s IL_0023
    IL_001c: ldarg.0
    IL_001d: ldc.i4.0
    IL_001e: stfld int EnumSelector::index  /*0x040013CD*/
    IL_0023: ldarg.0
    IL_0024: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0029: ldc.i4.0
    IL_002a: bge.s IL_003f
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_0033: callvirt int System.Collections.Generic.List<string>::get_Count()  /*0x0A000047*/
    IL_0038: ldc.i4.1
    IL_0039: sub
    IL_003a: stfld int EnumSelector::index  /*0x040013CD*/
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0046: stfld int EnumSelector::bufferIndex  /*0x040013D8*/
    IL_004b: ldarg.0
    IL_004c: call void EnumSelector::UpdateDisplay()  /*0x060010B0*/
    IL_0051: ret

  .method EnumSelector::OnLinkedTFUINavigate()  // token 0x060010B6 rva 0x4cc82 attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EnumSelector::CancelChanges()  /*0x060010B9*/
    IL_0006: ret

  .method EnumSelector::PropagateDelayedChange()  // token 0x060010B7 rva 0x4cc8a attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnumSelector::delayedApply  /*0x040013CE*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void EnumSelector::ApplyChanges()  /*0x060010B8*/
    IL_000e: ret

  .method EnumSelector::ApplyChanges()  // token 0x060010B8 rva 0x4cc9a attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int EnumSelector::index  /*0x040013CD*/
    IL_0007: stfld int EnumSelector::bufferIndex  /*0x040013D8*/
    IL_000c: ldarg.0
    IL_000d: ldfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_0012: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0017: ldarg.0
    IL_0018: ldc.i4.0
    IL_0019: stfld bool EnumSelector::unpropagatedChanges  /*0x040013D7*/
    IL_001e: ldarg.0
    IL_001f: call void EnumSelector::UpdateDisplay()  /*0x060010B0*/
    IL_0024: ret

  .method EnumSelector::CancelChanges()  // token 0x060010B9 rva 0x4ccc0 attrs Private, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int EnumSelector::bufferIndex  /*0x040013D8*/
    IL_0007: stfld int EnumSelector::index  /*0x040013CD*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.0
    IL_000e: stfld bool EnumSelector::unpropagatedChanges  /*0x040013D7*/
    IL_0013: ldarg.0
    IL_0014: call void EnumSelector::UpdateDisplay()  /*0x060010B0*/
    IL_0019: ret

  .method EnumSelector::.ctor()  // token 0x060010BA rva 0x4ccdb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<string>::.ctor()  /*0x0A000023*/
    IL_0006: stfld List<string> EnumSelector::options  /*0x040013CC*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.1
    IL_000d: stfld ThronefallUIElement.NavigationDirection EnumSelector::decrease  /*0x040013D1*/
    IL_0012: ldarg.0
    IL_0013: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0018: stfld UnityEvent EnumSelector::onChange  /*0x040013D4*/
    IL_001d: ldarg.0
    IL_001e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0023: stfld UnityEvent EnumSelector::onIncrease  /*0x040013D5*/
    IL_0028: ldarg.0
    IL_0029: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_002e: stfld UnityEvent EnumSelector::onDecrease  /*0x040013D6*/
    IL_0033: ldarg.0
    IL_0034: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0039: ret

