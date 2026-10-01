// ===== NightWavePreviewCycleButton  (token 0x0200032A) =====
  .method NightWavePreviewCycleButton::Increase()  // token 0x06001172 rva 0x52fb3 attrs Public, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame NightWavePreviewCycleButton::frame  /*0x040014EC*/
    IL_0006: ldarg.0
    IL_0007: ldfld ThronefallUIElement NightWavePreviewCycleButton::button  /*0x040014ED*/
    IL_000c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0011: ldarg.0
    IL_0012: ldfld PauseUILoadoutHelper NightWavePreviewCycleButton::target  /*0x040014EE*/
    IL_0017: ldc.i4.1
    IL_0018: callvirt void PauseUILoadoutHelper::CycleNightPreview(int)  /*0x0600117C*/
    IL_001d: ldarg.0
    IL_001e: ldfld MMF_Player NightWavePreviewCycleButton::onIncrease  /*0x040014EF*/
    IL_0023: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0028: ldarg.0
    IL_0029: ldfld UIFrame NightWavePreviewCycleButton::frame  /*0x040014EC*/
    IL_002e: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_0033: ret

  .method NightWavePreviewCycleButton::Decrease()  // token 0x06001173 rva 0x52fe8 attrs Public, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame NightWavePreviewCycleButton::frame  /*0x040014EC*/
    IL_0006: ldarg.0
    IL_0007: ldfld ThronefallUIElement NightWavePreviewCycleButton::button  /*0x040014ED*/
    IL_000c: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0011: ldarg.0
    IL_0012: ldfld PauseUILoadoutHelper NightWavePreviewCycleButton::target  /*0x040014EE*/
    IL_0017: ldc.i4.m1
    IL_0018: callvirt void PauseUILoadoutHelper::CycleNightPreview(int)  /*0x0600117C*/
    IL_001d: ldarg.0
    IL_001e: ldfld MMF_Player NightWavePreviewCycleButton::onDecrease  /*0x040014F0*/
    IL_0023: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0028: ldarg.0
    IL_0029: ldfld UIFrame NightWavePreviewCycleButton::frame  /*0x040014EC*/
    IL_002e: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_0033: ret

  .method NightWavePreviewCycleButton::ProcessNavigate(ThronefallUIElement.NavigationDirection)  // token 0x06001174 rva 0x5301d attrs Public, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.1
    IL_0002: bne.un.s IL_000b
    IL_0004: ldarg.0
    IL_0005: call void NightWavePreviewCycleButton::Decrease()  /*0x06001173*/
    IL_000a: ret
    IL_000b: ldarg.1
    IL_000c: brtrue.s IL_0014
    IL_000e: ldarg.0
    IL_000f: call void NightWavePreviewCycleButton::Increase()  /*0x06001172*/
    IL_0014: ret

  .method NightWavePreviewCycleButton::.ctor()  // token 0x06001175 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

