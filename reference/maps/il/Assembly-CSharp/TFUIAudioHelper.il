// ===== TFUIAudioHelper  (token 0x02000347) =====
  .method TFUIAudioHelper::get_selected()  // token 0x060011CD rva 0x561c0 attrs Private, HideBySig, SpecialName
    // code size 64 (0x40), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_0006: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_000b: ldc.i4.2
    IL_000c: beq.s IL_001c
    IL_000e: ldarg.0
    IL_000f: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_0014: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_CurrentState()  /*0x060012A6*/
    IL_0019: ldc.i4.3
    IL_001a: bne.un.s IL_003e
    IL_001c: ldarg.0
    IL_001d: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_0022: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_PreviousState()  /*0x060012A7*/
    IL_0027: ldc.i4.3
    IL_0028: beq.s IL_003c
    IL_002a: ldarg.0
    IL_002b: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_0030: callvirt ThronefallUIElement.SelectionState ThronefallUIElement::get_PreviousState()  /*0x060012A7*/
    IL_0035: ldc.i4.2
    IL_0036: ceq
    IL_0038: ldc.i4.0
    IL_0039: ceq
    IL_003b: ret
    IL_003c: ldc.i4.0
    IL_003d: ret
    IL_003e: ldc.i4.0
    IL_003f: ret

  .method TFUIAudioHelper::Start()  // token 0x060011CE rva 0x5620c attrs Private, HideBySig
    // code size 91 (0x5b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<ThronefallUIElement>  /*0x2B000105*/
    IL_0007: stfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_000c: ldarg.0
    IL_000d: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_0012: ldfld UnityEvent ThronefallUIElement::onApply  /*0x04001686*/
    IL_0017: ldarg.0
    IL_0018: ldftn void TFUIAudioHelper::PlayApply()  /*0x060011CF*/
    IL_001e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0023: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0028: ldarg.0
    IL_0029: ldfld ThronefallUIElement TFUIAudioHelper::tfui  /*0x04001597*/
    IL_002e: ldfld UnityEvent ThronefallUIElement::onSelectionStateChange  /*0x04001685*/
    IL_0033: ldarg.0
    IL_0034: ldftn void TFUIAudioHelper::PlaySelect()  /*0x060011D0*/
    IL_003a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0044: ldarg.0
    IL_0045: call bool TFUIAudioHelper::get_selected()  /*0x060011CD*/
    IL_004a: brfalse.s IL_005a
    IL_004c: ldarg.0
    IL_004d: ldfld bool TFUIAudioHelper::playOnColdSelect  /*0x04001594*/
    IL_0052: brfalse.s IL_005a
    IL_0054: ldarg.0
    IL_0055: call void TFUIAudioHelper::PlaySelect()  /*0x060011D0*/
    IL_005a: ret

  .method TFUIAudioHelper::PlayApply()  // token 0x060011CF rva 0x56273 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager.AudioOneShot TFUIAudioHelper::onApply  /*0x04001596*/
    IL_0006: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_000b: ret

  .method TFUIAudioHelper::PlaySelect()  // token 0x060011D0 rva 0x56280 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool TFUIAudioHelper::get_selected()  /*0x060011CD*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld ThronefallAudioManager.AudioOneShot TFUIAudioHelper::onSelect  /*0x04001595*/
    IL_000e: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0013: ret

  .method TFUIAudioHelper::.ctor()  // token 0x060011D1 rva 0x56295 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld ThronefallAudioManager.AudioOneShot TFUIAudioHelper::onSelect  /*0x04001595*/
    IL_0008: ldarg.0
    IL_0009: ldc.i4.s 11
    IL_000b: stfld ThronefallAudioManager.AudioOneShot TFUIAudioHelper::onApply  /*0x04001596*/
    IL_0010: ldarg.0
    IL_0011: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0016: ret

