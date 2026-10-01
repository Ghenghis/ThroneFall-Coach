// ===== TooltipManager  (token 0x020002BC) =====
  .method TooltipManager::SetTutorialOverrideToNone()  // token 0x06000F0E rva 0x43688 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "%NONE"
    IL_0006: ldc.i4.1
    IL_0007: call void TooltipManager::SetTutorialOverride(string,bool)  /*0x06000F0F*/
    IL_000c: ret

  .method TooltipManager::SetTutorialOverride(string,bool)  // token 0x06000F0F rva 0x43696 attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.2
    IL_0001: brfalse.s IL_000b
    IL_0003: ldarg.0
    IL_0004: ldarg.1
    IL_0005: stfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_000a: ret
    IL_000b: ldarg.0
    IL_000c: ldarg.1
    IL_000d: stfld string TooltipManager::tutorialOverride  /*0x04001162*/
    IL_0012: ret

  .method TooltipManager::Awake()  // token 0x06000F10 rva 0x436aa attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld TooltipManager TooltipManager::instance  /*0x04001167*/
    IL_0006: ret

  .method TooltipManager::Start()  // token 0x06000F11 rva 0x436b2 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0006: stfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_000b: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0010: ldfld UnityEvent SceneTransitionManager::onSceneChange  /*0x04000C79*/
    IL_0015: ldarg.0
    IL_0016: ldftn void TooltipManager::ResetAfterSceneLoad()  /*0x06000F12*/
    IL_001c: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0021: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0026: ldarg.0
    IL_0027: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_002c: stfld SettingsManager TooltipManager::settings  /*0x04001166*/
    IL_0031: ret

  .method TooltipManager::ResetAfterSceneLoad()  // token 0x06000F12 rva 0x436e5 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: stfld string TooltipManager::tutorialOverride  /*0x04001162*/
    IL_000b: ldarg.0
    IL_000c: ldstr ""
    IL_0011: stfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_0016: ldarg.0
    IL_0017: ldstr ""
    IL_001c: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0021: ret

  .method TooltipManager::Update()  // token 0x06000F13 rva 0x43708 attrs Private, HideBySig
    // code size 399 (0x18f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_0006: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_000b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0010: brfalse.s IL_001d
    IL_0012: ldarg.0
    IL_0013: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0018: stfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_001d: ldarg.0
    IL_001e: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_0023: ldnull
    IL_0024: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0029: brfalse.s IL_002c
    IL_002b: ret
    IL_002c: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0031: callvirt UIFrame UIFrameManager::get_ActiveFrame()  /*0x060012F9*/
    IL_0036: ldnull
    IL_0037: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003c: brfalse.s IL_0055
    IL_003e: ldarg.0
    IL_003f: ldstr ""
    IL_0044: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0049: ldarg.0
    IL_004a: ldc.i4.1
    IL_004b: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_0050: br IL_0165
    IL_0055: ldarg.0
    IL_0056: ldfld bool TooltipManager::hideAllTooltips  /*0x04001168*/
    IL_005b: brfalse.s IL_0074
    IL_005d: ldarg.0
    IL_005e: ldstr ""
    IL_0063: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0068: ldarg.0
    IL_0069: ldc.i4.1
    IL_006a: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_006f: br IL_0165
    IL_0074: ldarg.0
    IL_0075: ldfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_007a: ldstr ""
    IL_007f: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0084: brfalse.s IL_00bd
    IL_0086: ldarg.0
    IL_0087: ldfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_008c: ldstr "%NONE"
    IL_0091: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0096: brfalse.s IL_00a5
    IL_0098: ldarg.0
    IL_0099: ldstr ""
    IL_009e: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_00a3: br.s IL_00b1
    IL_00a5: ldarg.0
    IL_00a6: ldarg.0
    IL_00a7: ldfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_00ac: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_00b1: ldarg.0
    IL_00b2: ldc.i4.1
    IL_00b3: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_00b8: br IL_0165
    IL_00bd: ldarg.0
    IL_00be: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_00c3: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_00c8: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00cd: brfalse.s IL_012c
    IL_00cf: ldarg.0
    IL_00d0: ldfld SettingsManager TooltipManager::settings  /*0x04001166*/
    IL_00d5: callvirt bool SettingsManager::get_DisableTooltips()  /*0x06000DA8*/
    IL_00da: brtrue.s IL_012c
    IL_00dc: ldarg.0
    IL_00dd: ldfld InteractorBase TooltipManager::lastFocus  /*0x04001164*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_00e8: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_00ed: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00f2: brtrue.s IL_00fc
    IL_00f4: ldarg.0
    IL_00f5: ldfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_00fa: brfalse.s IL_0165
    IL_00fc: ldarg.0
    IL_00fd: ldarg.0
    IL_00fe: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_0103: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_0108: callvirt string InteractorBase::ReturnTooltip()  /*0x06000BE7*/
    IL_010d: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0112: ldarg.0
    IL_0113: ldarg.0
    IL_0114: ldfld PlayerInteraction TooltipManager::playerInteraction  /*0x04001160*/
    IL_0119: callvirt InteractorBase PlayerInteraction::get_FocussedInteractor()  /*0x06000C08*/
    IL_011e: stfld InteractorBase TooltipManager::lastFocus  /*0x04001164*/
    IL_0123: ldarg.0
    IL_0124: ldc.i4.0
    IL_0125: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_012a: br.s IL_0165
    IL_012c: ldarg.0
    IL_012d: ldfld string TooltipManager::tutorialOverride  /*0x04001162*/
    IL_0132: ldstr ""
    IL_0137: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_013c: brfalse.s IL_0153
    IL_013e: ldarg.0
    IL_013f: ldarg.0
    IL_0140: ldfld string TooltipManager::tutorialOverride  /*0x04001162*/
    IL_0145: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_014a: ldarg.0
    IL_014b: ldc.i4.1
    IL_014c: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_0151: br.s IL_0165
    IL_0153: ldarg.0
    IL_0154: ldstr ""
    IL_0159: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_015e: ldarg.0
    IL_015f: ldnull
    IL_0160: stfld InteractorBase TooltipManager::lastFocus  /*0x04001164*/
    IL_0165: ldarg.0
    IL_0166: ldfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_016b: ldarg.0
    IL_016c: ldfld Tooltip TooltipManager::targetTooltip  /*0x0400115F*/
    IL_0171: callvirt string Tooltip::get_currentText()  /*0x060012C8*/
    IL_0176: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_017b: brfalse.s IL_018e
    IL_017d: ldarg.0
    IL_017e: ldfld Tooltip TooltipManager::targetTooltip  /*0x0400115F*/
    IL_0183: ldarg.0
    IL_0184: ldfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0189: callvirt void Tooltip::SetTooltip(string)  /*0x060012CA*/
    IL_018e: ret

  .method TooltipManager::SetInteractorRefreshFlag()  // token 0x06000F14 rva 0x438a3 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TooltipManager::interactorRefreshFlag  /*0x04001165*/
    IL_0007: ret

  .method TooltipManager::.ctor()  // token 0x06000F15 rva 0x438ac attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: stfld string TooltipManager::tutorialOverridePriority  /*0x04001161*/
    IL_000b: ldarg.0
    IL_000c: ldstr ""
    IL_0011: stfld string TooltipManager::tutorialOverride  /*0x04001162*/
    IL_0016: ldarg.0
    IL_0017: ldstr ""
    IL_001c: stfld string TooltipManager::nextTooltipText  /*0x04001163*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

