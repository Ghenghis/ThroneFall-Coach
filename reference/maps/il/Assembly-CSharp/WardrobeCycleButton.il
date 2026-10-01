// ===== WardrobeCycleButton  (token 0x0200037F) =====
  .method WardrobeCycleButton::Increase()  // token 0x06001344 rva 0x5b838 attrs Public, HideBySig
    // code size 97 (0x61), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame WardrobeCycleButton::frame  /*0x0400174B*/
    IL_0006: ldarg.0
    IL_0007: ldfld ThronefallUIElement WardrobeCycleButton::button  /*0x0400174C*/
    IL_000c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0018: ldc.i4.1
    IL_0019: add
    IL_001a: stfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_001f: ldarg.0
    IL_0020: ldfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0025: ldarg.0
    IL_0026: ldfld int WardrobeCycleButton::numbOfOptions  /*0x04001750*/
    IL_002b: blt.s IL_0034
    IL_002d: ldarg.0
    IL_002e: ldc.i4.0
    IL_002f: stfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0034: ldarg.0
    IL_0035: ldfld TextMeshProUGUI WardrobeCycleButton::wardrobeOptionText  /*0x0400174F*/
    IL_003a: ldarg.0
    IL_003b: ldflda int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0040: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0045: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_004a: ldarg.0
    IL_004b: ldfld MMF_Player WardrobeCycleButton::onIncrease  /*0x0400174D*/
    IL_0050: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0055: ldarg.0
    IL_0056: ldfld UIFrame WardrobeCycleButton::frame  /*0x0400174B*/
    IL_005b: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_0060: ret

  .method WardrobeCycleButton::Decrease()  // token 0x06001345 rva 0x5b8a8 attrs Public, HideBySig
    // code size 99 (0x63), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame WardrobeCycleButton::frame  /*0x0400174B*/
    IL_0006: ldarg.0
    IL_0007: ldfld ThronefallUIElement WardrobeCycleButton::button  /*0x0400174C*/
    IL_000c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0018: ldc.i4.1
    IL_0019: sub
    IL_001a: stfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_001f: ldarg.0
    IL_0020: ldfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0025: ldc.i4.0
    IL_0026: bge.s IL_0036
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: ldfld int WardrobeCycleButton::numbOfOptions  /*0x04001750*/
    IL_002f: ldc.i4.1
    IL_0030: sub
    IL_0031: stfld int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0036: ldarg.0
    IL_0037: ldfld TextMeshProUGUI WardrobeCycleButton::wardrobeOptionText  /*0x0400174F*/
    IL_003c: ldarg.0
    IL_003d: ldflda int WardrobeCycleButton::currentIndex  /*0x04001751*/
    IL_0042: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0047: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_004c: ldarg.0
    IL_004d: ldfld MMF_Player WardrobeCycleButton::onDecrease  /*0x0400174E*/
    IL_0052: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0057: ldarg.0
    IL_0058: ldfld UIFrame WardrobeCycleButton::frame  /*0x0400174B*/
    IL_005d: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_0062: ret

  .method WardrobeCycleButton::ProcessNavigate(ThronefallUIElement.NavigationDirection)  // token 0x06001346 rva 0x5b917 attrs Public, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.1
    IL_0002: bne.un.s IL_000b
    IL_0004: ldarg.0
    IL_0005: call void WardrobeCycleButton::Decrease()  /*0x06001345*/
    IL_000a: ret
    IL_000b: ldarg.1
    IL_000c: brtrue.s IL_0014
    IL_000e: ldarg.0
    IL_000f: call void WardrobeCycleButton::Increase()  /*0x06001344*/
    IL_0014: ret

  .method WardrobeCycleButton::.ctor()  // token 0x06001347 rva 0x5b92d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int WardrobeCycleButton::numbOfOptions  /*0x04001750*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

