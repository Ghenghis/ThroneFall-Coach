// ===== ETChoicePickScreen  (token 0x02000306) =====
  .method ETChoicePickScreen::Start()  // token 0x060010BD rva 0x4cd38 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0006: ldfld UnityEvent UIFrame::onNewFocus  /*0x040016E0*/
    IL_000b: ldarg.0
    IL_000c: ldftn void ETChoicePickScreen::OnTargetFrameFocusChange()  /*0x060010C4*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ldarg.0
    IL_001d: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0022: ldfld UnityEvent UIFrame::onNewSelection  /*0x040016E1*/
    IL_0027: ldarg.0
    IL_0028: ldftn void ETChoicePickScreen::OnTargetFrameSelectionChange()  /*0x060010C5*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ret

  .method ETChoicePickScreen::Update()  // token 0x060010BE rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ETChoicePickScreen::CheckForPerkDisable()  // token 0x060010BF rva 0x4cd74 attrs Public, HideBySig
    // code size 139 (0x8b), max stack 2, init locals
    .locals ([0] TFUIEquippable, [1] EquippablePerk)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brfalse.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_001a: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_001f: callvirt !!0 UnityEngine.Component::GetComponent()<TFUIEquippable>  /*0x2B0000E9*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brfalse.s IL_008a
    IL_002d: ldloc.0
    IL_002e: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0033: isinst EquippablePerk  /*0x0200021A*/
    IL_0038: stloc.1
    IL_0039: ldloc.1
    IL_003a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_003f: brfalse.s IL_008a
    IL_0041: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0046: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_004b: ldloc.1
    IL_004c: callvirt bool System.Collections.Generic.List<EquippablePerk>::Contains(!0)  /*0x0A0002DD*/
    IL_0051: brfalse.s IL_0066
    IL_0053: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0058: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_005d: ldloc.1
    IL_005e: callvirt bool System.Collections.Generic.List<EquippablePerk>::Remove(!0)  /*0x0A000666*/
    IL_0063: pop
    IL_0064: br.s IL_0076
    IL_0066: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_006b: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_0070: ldloc.1
    IL_0071: callvirt void System.Collections.Generic.List<EquippablePerk>::Add(!0)  /*0x0A0002E6*/
    IL_0076: ldloc.0
    IL_0077: ldloc.1
    IL_0078: callvirt void TFUIEquippable::SetDataEternalTrials(Equippable)  /*0x0600120A*/
    IL_007d: ldloc.0
    IL_007e: ldc.i4.2
    IL_007f: callvirt void ThronefallUIElement::HardStateSet(ThronefallUIElement.SelectionState)  /*0x060012AE*/
    IL_0084: ldloc.0
    IL_0085: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_008a: ret

  .method ETChoicePickScreen::Activate()  // token 0x060010C0 rva 0x4ce0c attrs Public, HideBySig
    // code size 408 (0x198), max stack 6, init locals
    .locals ([0] MapChoice[], [1] string, [2] EquippablePerk[], [3] IEnumerator, [4] IDisposable, [5] int, [6] ETMapChoiceDisplay, [7] int, [8] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform ETChoicePickScreen::choicesParent  /*0x040013DF*/
    IL_0006: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_000b: stloc.3
    IL_000c: br.s IL_0023
    IL_000e: ldloc.3
    IL_000f: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0014: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0019: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0023: ldloc.3
    IL_0024: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0029: brtrue.s IL_000e
    IL_002b: leave.s IL_0041
    IL_002d: ldloc.3
    IL_002e: isinst System.IDisposable  /*0x0100001B*/
    IL_0033: stloc.s 4
    IL_0035: ldloc.s 4
    IL_0037: brfalse.s IL_0040
    IL_0039: ldloc.s 4
    IL_003b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0040: endfinally
    IL_0041: call MapChoice[] EternalTrialsRunManager::GetMapChoices()  /*0x060006F6*/
    IL_0046: stloc.0
    IL_0047: ldarg.0
    IL_0048: ldloc.0
    IL_0049: ldlen
    IL_004a: conv.i4
    IL_004b: newarr ETMapChoiceDisplay  /*0x0200030C*/
    IL_0050: stfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0055: ldc.i4.0
    IL_0056: stloc.s 5
    IL_0058: br.s IL_008a
    IL_005a: ldarg.0
    IL_005b: ldfld ETMapChoiceDisplay ETChoicePickScreen::displayPrefab  /*0x040013DC*/
    IL_0060: ldarg.0
    IL_0061: ldfld Transform ETChoicePickScreen::choicesParent  /*0x040013DF*/
    IL_0066: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ETMapChoiceDisplay>  /*0x2B0000EA*/
    IL_006b: stloc.s 6
    IL_006d: ldloc.s 6
    IL_006f: ldloc.0
    IL_0070: ldloc.s 5
    IL_0072: ldelem.ref
    IL_0073: ldarg.0
    IL_0074: callvirt void ETMapChoiceDisplay::SetData(MapChoice,ETChoicePickScreen)  /*0x060010D9*/
    IL_0079: ldarg.0
    IL_007a: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_007f: ldloc.s 5
    IL_0081: ldloc.s 6
    IL_0083: stelem.ref
    IL_0084: ldloc.s 5
    IL_0086: ldc.i4.1
    IL_0087: add
    IL_0088: stloc.s 5
    IL_008a: ldloc.s 5
    IL_008c: ldloc.0
    IL_008d: ldlen
    IL_008e: conv.i4
    IL_008f: blt.s IL_005a
    IL_0091: ldarg.0
    IL_0092: call void ETChoicePickScreen::InitializeChoiceSelection()  /*0x060010C2*/
    IL_0097: ldstr "<style=Body Bold>"
    IL_009c: ldstr "Menu/Stage"
    IL_00a1: ldc.i4.1
    IL_00a2: ldc.i4.0
    IL_00a3: ldc.i4.1
    IL_00a4: ldc.i4.1
    IL_00a5: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00aa: ldstr "<style=Body Numerals> "
    IL_00af: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_00b4: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_00b9: ldc.i4.1
    IL_00ba: add
    IL_00bb: stloc.s 7
    IL_00bd: ldloca.s 7
    IL_00bf: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c4: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_00c9: stloc.1
    IL_00ca: ldarg.0
    IL_00cb: ldfld TextMeshProUGUI ETChoicePickScreen::currentLevelDisplay  /*0x040013E2*/
    IL_00d0: ldloc.1
    IL_00d1: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld Transform ETChoicePickScreen::currentLoadoutParent  /*0x040013E0*/
    IL_00dc: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_00e1: stloc.3
    IL_00e2: br.s IL_00f9
    IL_00e4: ldloc.3
    IL_00e5: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_00ea: castclass UnityEngine.Transform  /*0x01000015*/
    IL_00ef: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f4: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00f9: ldloc.3
    IL_00fa: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_00ff: brtrue.s IL_00e4
    IL_0101: leave.s IL_0117
    IL_0103: ldloc.3
    IL_0104: isinst System.IDisposable  /*0x0100001B*/
    IL_0109: stloc.s 4
    IL_010b: ldloc.s 4
    IL_010d: brfalse.s IL_0116
    IL_010f: ldloc.s 4
    IL_0111: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0116: endfinally
    IL_0117: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_011c: ldfld List<EquippablePerk> EternalTrialsRun::acquiredPerks  /*0x04000854*/
    IL_0121: callvirt !0[] System.Collections.Generic.List<EquippablePerk>::ToArray()  /*0x0A000667*/
    IL_0126: stloc.2
    IL_0127: ldarg.0
    IL_0128: ldloc.2
    IL_0129: ldlen
    IL_012a: conv.i4
    IL_012b: newarr TFUIEquippable  /*0x0200034D*/
    IL_0130: stfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0135: ldarg.0
    IL_0136: ldfld GameObject ETChoicePickScreen::noLoadoutYet  /*0x040013E1*/
    IL_013b: ldloc.2
    IL_013c: ldlen
    IL_013d: ldc.i4.0
    IL_013e: ceq
    IL_0140: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0145: ldc.i4.0
    IL_0146: stloc.s 8
    IL_0148: br.s IL_018a
    IL_014a: ldarg.0
    IL_014b: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0150: ldloc.s 8
    IL_0152: ldarg.0
    IL_0153: ldfld TFUIEquippable ETChoicePickScreen::perkTFUIPrefab  /*0x040013E3*/
    IL_0158: ldarg.0
    IL_0159: ldfld Transform ETChoicePickScreen::currentLoadoutParent  /*0x040013E0*/
    IL_015e: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEquippable>  /*0x2B0000EB*/
    IL_0163: stelem.ref
    IL_0164: ldarg.0
    IL_0165: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_016a: ldloc.s 8
    IL_016c: ldelem.ref
    IL_016d: ldloc.2
    IL_016e: ldloc.s 8
    IL_0170: ldelem.ref
    IL_0171: callvirt void TFUIEquippable::SetDataEternalTrials(Equippable)  /*0x0600120A*/
    IL_0176: ldarg.0
    IL_0177: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_017c: ldloc.s 8
    IL_017e: ldelem.ref
    IL_017f: callvirt void TFUIEquippable::Pick()  /*0x0600120C*/
    IL_0184: ldloc.s 8
    IL_0186: ldc.i4.1
    IL_0187: add
    IL_0188: stloc.s 8
    IL_018a: ldloc.s 8
    IL_018c: ldloc.2
    IL_018d: ldlen
    IL_018e: conv.i4
    IL_018f: blt.s IL_014a
    IL_0191: ldarg.0
    IL_0192: call void ETChoicePickScreen::RecomputeAllNavigation()  /*0x060010C6*/
    IL_0197: ret
    .try IL_000c-IL_002d finally handler IL_002d-IL_0041
    .try IL_00e2-IL_0103 finally handler IL_0103-IL_0117

  .method ETChoicePickScreen::ConfirmChoice(MapChoice)  // token 0x060010C1 rva 0x4cfcc attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.1
    IL_0001: call void EternalTrialsRunManager::ConfirmChoice(MapChoice)  /*0x060006F7*/
    IL_0006: ldnull
    IL_0007: call void EternalTrialsRunManager::LoadNextMap(EternalTrialsRun)  /*0x060006F4*/
    IL_000c: ret

  .method ETChoicePickScreen::InitializeChoiceSelection()  // token 0x060010C2 rva 0x4cfda attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0006: ldlen
    IL_0007: conv.i4
    IL_0008: ldc.i4.3
    IL_0009: bne.un.s IL_001c
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0012: ldc.i4.1
    IL_0013: ldelem.ref
    IL_0014: ldc.i4.0
    IL_0015: ldc.i4.1
    IL_0016: call void ETChoicePickScreen::SelectNewChoice(ETMapChoiceDisplay,bool,bool)  /*0x060010C3*/
    IL_001b: ret
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0023: ldc.i4.0
    IL_0024: ldelem.ref
    IL_0025: ldc.i4.0
    IL_0026: ldc.i4.1
    IL_0027: call void ETChoicePickScreen::SelectNewChoice(ETMapChoiceDisplay,bool,bool)  /*0x060010C3*/
    IL_002c: ret

  .method ETChoicePickScreen::SelectNewChoice(ETMapChoiceDisplay,bool,bool)  // token 0x060010C3 rva 0x4d008 attrs Private, HideBySig
    // code size 164 (0xa4), max stack 3, init locals
    .locals ([0] ETMapChoiceDisplay[], [1] int, [2] ETMapChoiceDisplay)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_0007: ldarg.0
    IL_0008: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_000d: stloc.0
    IL_000e: ldc.i4.0
    IL_000f: stloc.1
    IL_0010: br.s IL_002e
    IL_0012: ldloc.0
    IL_0013: ldloc.1
    IL_0014: ldelem.ref
    IL_0015: stloc.2
    IL_0016: ldloc.2
    IL_0017: ldarg.0
    IL_0018: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_001d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0022: brfalse.s IL_002a
    IL_0024: ldloc.2
    IL_0025: callvirt void ETMapChoiceDisplay::Unselect()  /*0x060010DC*/
    IL_002a: ldloc.1
    IL_002b: ldc.i4.1
    IL_002c: add
    IL_002d: stloc.1
    IL_002e: ldloc.1
    IL_002f: ldloc.0
    IL_0030: ldlen
    IL_0031: conv.i4
    IL_0032: blt.s IL_0012
    IL_0034: ldarg.0
    IL_0035: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_003a: callvirt void ETMapChoiceDisplay::Select()  /*0x060010DB*/
    IL_003f: ldarg.2
    IL_0040: brfalse.s IL_0058
    IL_0042: ldarg.0
    IL_0043: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0048: ldarg.0
    IL_0049: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_004e: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0053: callvirt void UIFrame::Select(ThronefallUIElement)  /*0x060012F2*/
    IL_0058: ldarg.3
    IL_0059: brfalse.s IL_0071
    IL_005b: ldarg.0
    IL_005c: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0061: ldarg.0
    IL_0062: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_0067: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_006c: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0071: ldarg.0
    IL_0072: call void ETChoicePickScreen::RecomputeCurrentLoadoutTFUINavigation()  /*0x060010C7*/
    IL_0077: ldarg.0
    IL_0078: ldfld EternalTrialsMapPreview ETChoicePickScreen::mapPreviewTT  /*0x040013DD*/
    IL_007d: ldarg.1
    IL_007e: callvirt MapChoice ETMapChoiceDisplay::get_Data()  /*0x060010D8*/
    IL_0083: ldfld List<WaveInfo> MapChoice::waveInfos  /*0x0400085E*/
    IL_0088: ldarg.1
    IL_0089: callvirt MapChoice ETMapChoiceDisplay::get_Data()  /*0x060010D8*/
    IL_008e: ldfld int MapChoice::goldAtStart  /*0x0400085F*/
    IL_0093: callvirt void EternalTrialsMapPreview::SetData(System.Collections.Generic.List<WaveInfo>,int)  /*0x060010CF*/
    IL_0098: ldarg.0
    IL_0099: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_009e: callvirt void UIFrame::RefetchManagedElements()  /*0x060012F7*/
    IL_00a3: ret

  .method ETChoicePickScreen::OnTargetFrameFocusChange()  // token 0x060010C4 rva 0x4d0b8 attrs Private, HideBySig
    // code size 92 (0x5c), max stack 4, init locals
    .locals ([0] ETMapChoiceDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brfalse.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_001a: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_001f: callvirt !!0 UnityEngine.Component::GetComponentInParent()<ETMapChoiceDisplay>  /*0x2B0000EC*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: ldnull
    IL_0027: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002c: brfalse.s IL_002f
    IL_002e: ret
    IL_002f: ldloc.0
    IL_0030: ldarg.0
    IL_0031: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_0036: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003b: brfalse.s IL_005b
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: ldarg.0
    IL_0040: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0045: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_004a: isinst TFUIEquippable  /*0x0200034D*/
    IL_004f: ldnull
    IL_0050: cgt.un
    IL_0052: ldc.i4.0
    IL_0053: ceq
    IL_0055: ldc.i4.0
    IL_0056: call void ETChoicePickScreen::SelectNewChoice(ETMapChoiceDisplay,bool,bool)  /*0x060010C3*/
    IL_005b: ret

  .method ETChoicePickScreen::OnTargetFrameSelectionChange()  // token 0x060010C5 rva 0x4d120 attrs Private, HideBySig
    // code size 92 (0x5c), max stack 4, init locals
    .locals ([0] ETMapChoiceDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brfalse.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_001a: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_001f: callvirt !!0 UnityEngine.Component::GetComponentInParent()<ETMapChoiceDisplay>  /*0x2B0000EC*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: ldnull
    IL_0027: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002c: brfalse.s IL_002f
    IL_002e: ret
    IL_002f: ldloc.0
    IL_0030: ldarg.0
    IL_0031: ldfld ETMapChoiceDisplay ETChoicePickScreen::selectedChoice  /*0x040013E4*/
    IL_0036: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003b: brfalse.s IL_005b
    IL_003d: ldarg.0
    IL_003e: ldloc.0
    IL_003f: ldarg.0
    IL_0040: ldfld UIFrame ETChoicePickScreen::targetFrame  /*0x040013DB*/
    IL_0045: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_004a: isinst TFUIEquippable  /*0x0200034D*/
    IL_004f: ldnull
    IL_0050: cgt.un
    IL_0052: ldc.i4.0
    IL_0053: ceq
    IL_0055: ldc.i4.0
    IL_0056: call void ETChoicePickScreen::SelectNewChoice(ETMapChoiceDisplay,bool,bool)  /*0x060010C3*/
    IL_005b: ret

  .method ETChoicePickScreen::RecomputeAllNavigation()  // token 0x060010C6 rva 0x4d188 attrs Private, HideBySig
    // code size 1257 (0x4e9), max stack 5, init locals
    .locals ([0] List<ETMapChoiceDisplay>, [1] ETMapChoiceDisplay[], [2] int, [3] ETMapChoiceDisplay, [4] int, [5] ETMapChoiceDisplay, [6] int)
    IL_0000: newobj void System.Collections.Generic.List<ETMapChoiceDisplay>::.ctor()  /*0x0A000668*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_000c: stloc.1
    IL_000d: ldc.i4.0
    IL_000e: stloc.2
    IL_000f: br.s IL_0029
    IL_0011: ldloc.1
    IL_0012: ldloc.2
    IL_0013: ldelem.ref
    IL_0014: stloc.3
    IL_0015: ldloc.3
    IL_0016: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_001b: ldlen
    IL_001c: brfalse.s IL_0025
    IL_001e: ldloc.0
    IL_001f: ldloc.3
    IL_0020: callvirt void System.Collections.Generic.List<ETMapChoiceDisplay>::Add(!0)  /*0x0A000669*/
    IL_0025: ldloc.2
    IL_0026: ldc.i4.1
    IL_0027: add
    IL_0028: stloc.2
    IL_0029: ldloc.2
    IL_002a: ldloc.1
    IL_002b: ldlen
    IL_002c: conv.i4
    IL_002d: blt.s IL_0011
    IL_002f: ldc.i4.0
    IL_0030: stloc.s 4
    IL_0032: br IL_04d3
    IL_0037: ldarg.0
    IL_0038: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_003d: ldloc.s 4
    IL_003f: ldelem.ref
    IL_0040: stloc.s 5
    IL_0042: ldc.i4.0
    IL_0043: stloc.s 6
    IL_0045: br IL_020b
    IL_004a: ldloc.s 5
    IL_004c: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0051: ldlen
    IL_0052: brfalse IL_021b
    IL_0057: ldloc.s 5
    IL_0059: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_005e: ldloc.s 6
    IL_0060: ldelem.ref
    IL_0061: ldloc.s 5
    IL_0063: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0068: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_006d: ldloc.s 5
    IL_006f: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0074: ldloc.s 6
    IL_0076: ldelem.ref
    IL_0077: ldloc.s 5
    IL_0079: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_007e: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0083: ldloc.s 6
    IL_0085: brtrue IL_0134
    IL_008a: ldloc.s 4
    IL_008c: brtrue.s IL_00fe
    IL_008e: ldarg.0
    IL_008f: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0094: ldlen
    IL_0095: brfalse.s IL_00bc
    IL_0097: ldloc.s 5
    IL_0099: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_009e: ldloc.s 6
    IL_00a0: ldelem.ref
    IL_00a1: ldarg.0
    IL_00a2: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_00ad: ldlen
    IL_00ae: conv.i4
    IL_00af: ldc.i4.1
    IL_00b0: sub
    IL_00b1: ldelem.ref
    IL_00b2: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00b7: br IL_014f
    IL_00bc: ldloc.s 5
    IL_00be: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_00c3: ldloc.s 6
    IL_00c5: ldelem.ref
    IL_00c6: ldarg.0
    IL_00c7: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00d2: ldlen
    IL_00d3: conv.i4
    IL_00d4: ldc.i4.1
    IL_00d5: sub
    IL_00d6: ldelem.ref
    IL_00d7: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00e8: ldlen
    IL_00e9: conv.i4
    IL_00ea: ldc.i4.1
    IL_00eb: sub
    IL_00ec: ldelem.ref
    IL_00ed: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_00f2: ldlen
    IL_00f3: conv.i4
    IL_00f4: ldc.i4.1
    IL_00f5: sub
    IL_00f6: ldelem.ref
    IL_00f7: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00fc: br.s IL_014f
    IL_00fe: ldloc.s 5
    IL_0100: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0105: ldloc.s 6
    IL_0107: ldelem.ref
    IL_0108: ldarg.0
    IL_0109: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_010e: ldloc.s 4
    IL_0110: ldc.i4.1
    IL_0111: sub
    IL_0112: ldelem.ref
    IL_0113: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0118: ldarg.0
    IL_0119: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_011e: ldloc.s 4
    IL_0120: ldc.i4.1
    IL_0121: sub
    IL_0122: ldelem.ref
    IL_0123: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0128: ldlen
    IL_0129: conv.i4
    IL_012a: ldc.i4.1
    IL_012b: sub
    IL_012c: ldelem.ref
    IL_012d: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0132: br.s IL_014f
    IL_0134: ldloc.s 5
    IL_0136: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_013b: ldloc.s 6
    IL_013d: ldelem.ref
    IL_013e: ldloc.s 5
    IL_0140: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0145: ldloc.s 6
    IL_0147: ldc.i4.1
    IL_0148: sub
    IL_0149: ldelem.ref
    IL_014a: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_014f: ldloc.s 6
    IL_0151: ldloc.s 5
    IL_0153: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0158: ldlen
    IL_0159: conv.i4
    IL_015a: ldc.i4.1
    IL_015b: sub
    IL_015c: bne.un.s IL_01da
    IL_015e: ldloc.s 4
    IL_0160: ldarg.0
    IL_0161: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0166: ldlen
    IL_0167: conv.i4
    IL_0168: ldc.i4.1
    IL_0169: sub
    IL_016a: bne.un.s IL_01b7
    IL_016c: ldarg.0
    IL_016d: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0172: ldlen
    IL_0173: brfalse.s IL_0197
    IL_0175: ldloc.s 5
    IL_0177: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_017c: ldloc.s 6
    IL_017e: ldelem.ref
    IL_017f: ldarg.0
    IL_0180: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0185: ldarg.0
    IL_0186: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_018b: ldlen
    IL_018c: conv.i4
    IL_018d: ldc.i4.1
    IL_018e: sub
    IL_018f: ldelem.ref
    IL_0190: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0195: br.s IL_01f5
    IL_0197: ldloc.s 5
    IL_0199: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_019e: ldloc.s 6
    IL_01a0: ldelem.ref
    IL_01a1: ldarg.0
    IL_01a2: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_01a7: ldc.i4.0
    IL_01a8: ldelem.ref
    IL_01a9: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01ae: ldc.i4.0
    IL_01af: ldelem.ref
    IL_01b0: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_01b5: br.s IL_01f5
    IL_01b7: ldloc.s 5
    IL_01b9: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01be: ldloc.s 6
    IL_01c0: ldelem.ref
    IL_01c1: ldarg.0
    IL_01c2: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_01c7: ldloc.s 4
    IL_01c9: ldc.i4.1
    IL_01ca: add
    IL_01cb: ldelem.ref
    IL_01cc: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01d1: ldc.i4.0
    IL_01d2: ldelem.ref
    IL_01d3: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_01d8: br.s IL_01f5
    IL_01da: ldloc.s 5
    IL_01dc: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01e1: ldloc.s 6
    IL_01e3: ldelem.ref
    IL_01e4: ldloc.s 5
    IL_01e6: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01eb: ldloc.s 6
    IL_01ed: ldc.i4.1
    IL_01ee: add
    IL_01ef: ldelem.ref
    IL_01f0: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_01f5: ldloc.s 5
    IL_01f7: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_01fc: ldloc.s 6
    IL_01fe: ldelem.ref
    IL_01ff: ldc.i4.1
    IL_0200: stfld bool ThronefallUIElement::forceNavigateToDisabledElements  /*0x04001680*/
    IL_0205: ldloc.s 6
    IL_0207: ldc.i4.1
    IL_0208: add
    IL_0209: stloc.s 6
    IL_020b: ldloc.s 6
    IL_020d: ldloc.s 5
    IL_020f: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0214: ldlen
    IL_0215: conv.i4
    IL_0216: blt IL_004a
    IL_021b: ldloc.s 4
    IL_021d: brtrue.s IL_028a
    IL_021f: ldarg.0
    IL_0220: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0225: ldlen
    IL_0226: brfalse.s IL_0247
    IL_0228: ldloc.s 5
    IL_022a: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_022f: ldarg.0
    IL_0230: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0235: ldarg.0
    IL_0236: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_023b: ldlen
    IL_023c: conv.i4
    IL_023d: ldc.i4.1
    IL_023e: sub
    IL_023f: ldelem.ref
    IL_0240: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0245: br.s IL_0269
    IL_0247: ldloc.s 5
    IL_0249: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_024e: ldarg.0
    IL_024f: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0254: ldarg.0
    IL_0255: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_025a: ldlen
    IL_025b: conv.i4
    IL_025c: ldc.i4.1
    IL_025d: sub
    IL_025e: ldelem.ref
    IL_025f: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0264: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0269: ldloc.s 5
    IL_026b: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0270: ldarg.0
    IL_0271: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0276: ldloc.s 4
    IL_0278: ldc.i4.1
    IL_0279: add
    IL_027a: ldelem.ref
    IL_027b: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0280: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0285: br IL_032f
    IL_028a: ldloc.s 4
    IL_028c: ldarg.0
    IL_028d: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0292: ldlen
    IL_0293: conv.i4
    IL_0294: ldc.i4.1
    IL_0295: sub
    IL_0296: bne.un.s IL_02f7
    IL_0298: ldarg.0
    IL_0299: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_029e: ldlen
    IL_029f: brfalse.s IL_02c0
    IL_02a1: ldloc.s 5
    IL_02a3: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02a8: ldarg.0
    IL_02a9: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_02ae: ldarg.0
    IL_02af: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_02b4: ldlen
    IL_02b5: conv.i4
    IL_02b6: ldc.i4.1
    IL_02b7: sub
    IL_02b8: ldelem.ref
    IL_02b9: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_02be: br.s IL_02d9
    IL_02c0: ldloc.s 5
    IL_02c2: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02c7: ldarg.0
    IL_02c8: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_02cd: ldc.i4.0
    IL_02ce: ldelem.ref
    IL_02cf: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02d4: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_02d9: ldloc.s 5
    IL_02db: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02e0: ldarg.0
    IL_02e1: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_02e6: ldloc.s 4
    IL_02e8: ldc.i4.1
    IL_02e9: sub
    IL_02ea: ldelem.ref
    IL_02eb: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02f0: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_02f5: br.s IL_032f
    IL_02f7: ldloc.s 5
    IL_02f9: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_02fe: ldarg.0
    IL_02ff: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0304: ldloc.s 4
    IL_0306: ldc.i4.1
    IL_0307: sub
    IL_0308: ldelem.ref
    IL_0309: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_030e: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0313: ldloc.s 5
    IL_0315: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_031a: ldarg.0
    IL_031b: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0320: ldloc.s 4
    IL_0322: ldc.i4.1
    IL_0323: add
    IL_0324: ldelem.ref
    IL_0325: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_032a: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_032f: ldloc.s 5
    IL_0331: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0336: ldlen
    IL_0337: brfalse.s IL_036d
    IL_0339: ldloc.s 5
    IL_033b: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0340: ldloc.s 5
    IL_0342: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0347: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_034c: ldloc.s 5
    IL_034e: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0353: ldloc.s 5
    IL_0355: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_035a: ldloc.s 5
    IL_035c: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0361: ldlen
    IL_0362: conv.i4
    IL_0363: ldc.i4.1
    IL_0364: sub
    IL_0365: ldelem.ref
    IL_0366: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_036b: br.s IL_0393
    IL_036d: ldloc.s 5
    IL_036f: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0374: ldloc.s 5
    IL_0376: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_037b: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0380: ldloc.s 5
    IL_0382: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_0387: ldloc.s 5
    IL_0389: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_038e: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0393: ldloc.s 4
    IL_0395: brtrue.s IL_03e3
    IL_0397: ldarg.0
    IL_0398: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_039d: ldlen
    IL_039e: brfalse.s IL_03bf
    IL_03a0: ldloc.s 5
    IL_03a2: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_03a7: ldarg.0
    IL_03a8: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_03ad: ldarg.0
    IL_03ae: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_03b3: ldlen
    IL_03b4: conv.i4
    IL_03b5: ldc.i4.1
    IL_03b6: sub
    IL_03b7: ldelem.ref
    IL_03b8: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_03bd: br.s IL_03ff
    IL_03bf: ldloc.s 5
    IL_03c1: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_03c6: ldarg.0
    IL_03c7: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_03cc: ldarg.0
    IL_03cd: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_03d2: ldlen
    IL_03d3: conv.i4
    IL_03d4: ldc.i4.1
    IL_03d5: sub
    IL_03d6: ldelem.ref
    IL_03d7: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_03dc: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_03e1: br.s IL_03ff
    IL_03e3: ldloc.s 5
    IL_03e5: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_03ea: ldarg.0
    IL_03eb: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_03f0: ldloc.s 4
    IL_03f2: ldc.i4.1
    IL_03f3: sub
    IL_03f4: ldelem.ref
    IL_03f5: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_03fa: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_03ff: ldloc.s 4
    IL_0401: ldarg.0
    IL_0402: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0407: ldlen
    IL_0408: conv.i4
    IL_0409: ldc.i4.1
    IL_040a: sub
    IL_040b: bne.un.s IL_0450
    IL_040d: ldarg.0
    IL_040e: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0413: ldlen
    IL_0414: brfalse.s IL_0435
    IL_0416: ldloc.s 5
    IL_0418: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_041d: ldarg.0
    IL_041e: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0423: ldarg.0
    IL_0424: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0429: ldlen
    IL_042a: conv.i4
    IL_042b: ldc.i4.1
    IL_042c: sub
    IL_042d: ldelem.ref
    IL_042e: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0433: br.s IL_046c
    IL_0435: ldloc.s 5
    IL_0437: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_043c: ldarg.0
    IL_043d: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_0442: ldc.i4.0
    IL_0443: ldelem.ref
    IL_0444: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0449: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_044e: br.s IL_046c
    IL_0450: ldloc.s 5
    IL_0452: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0457: ldarg.0
    IL_0458: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_045d: ldloc.s 4
    IL_045f: ldc.i4.1
    IL_0460: add
    IL_0461: ldelem.ref
    IL_0462: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0467: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_046c: ldloc.s 5
    IL_046e: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0473: ldlen
    IL_0474: brfalse.s IL_048d
    IL_0476: ldloc.s 5
    IL_0478: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_047d: ldloc.s 5
    IL_047f: ldfld TFUIEquippable[] ETMapChoiceDisplay::currentPerkTFUIs  /*0x0400140B*/
    IL_0484: ldc.i4.0
    IL_0485: ldelem.ref
    IL_0486: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_048b: br.s IL_04a0
    IL_048d: ldloc.s 5
    IL_048f: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_0494: ldloc.s 5
    IL_0496: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_049b: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_04a0: ldloc.s 5
    IL_04a2: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_04a7: ldloc.s 5
    IL_04a9: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_04ae: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_04b3: ldloc.s 5
    IL_04b5: ldfld TFUIEquippable ETMapChoiceDisplay::weapon  /*0x040013FE*/
    IL_04ba: ldc.i4.1
    IL_04bb: stfld bool ThronefallUIElement::forceNavigateToDisabledElements  /*0x04001680*/
    IL_04c0: ldloc.s 5
    IL_04c2: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_04c7: ldc.i4.1
    IL_04c8: stfld bool ThronefallUIElement::forceNavigateToDisabledElements  /*0x04001680*/
    IL_04cd: ldloc.s 4
    IL_04cf: ldc.i4.1
    IL_04d0: add
    IL_04d1: stloc.s 4
    IL_04d3: ldloc.s 4
    IL_04d5: ldarg.0
    IL_04d6: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_04db: ldlen
    IL_04dc: conv.i4
    IL_04dd: blt IL_0037
    IL_04e2: ldarg.0
    IL_04e3: call void ETChoicePickScreen::RecomputeCurrentLoadoutTFUINavigation()  /*0x060010C7*/
    IL_04e8: ret

  .method ETChoicePickScreen::RecomputeCurrentLoadoutTFUINavigation()  // token 0x060010C7 rva 0x4d680 attrs Private, HideBySig
    // code size 236 (0xec), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0006: brfalse.s IL_0011
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_000e: ldlen
    IL_000f: brtrue.s IL_0012
    IL_0011: ret
    IL_0012: ldc.i4.0
    IL_0013: stloc.0
    IL_0014: br IL_00dd
    IL_0019: ldloc.0
    IL_001a: brtrue.s IL_003c
    IL_001c: ldarg.0
    IL_001d: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0022: ldloc.0
    IL_0023: ldelem.ref
    IL_0024: ldarg.0
    IL_0025: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_002a: ldarg.0
    IL_002b: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0030: ldlen
    IL_0031: conv.i4
    IL_0032: ldc.i4.1
    IL_0033: sub
    IL_0034: ldelem.ref
    IL_0035: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_003a: br.s IL_0053
    IL_003c: ldarg.0
    IL_003d: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0042: ldloc.0
    IL_0043: ldelem.ref
    IL_0044: ldarg.0
    IL_0045: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_004a: ldloc.0
    IL_004b: ldc.i4.1
    IL_004c: sub
    IL_004d: ldelem.ref
    IL_004e: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0053: ldloc.0
    IL_0054: ldarg.0
    IL_0055: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_005a: ldlen
    IL_005b: conv.i4
    IL_005c: ldc.i4.1
    IL_005d: sub
    IL_005e: bne.un.s IL_0077
    IL_0060: ldarg.0
    IL_0061: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0066: ldloc.0
    IL_0067: ldelem.ref
    IL_0068: ldarg.0
    IL_0069: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_006e: ldc.i4.0
    IL_006f: ldelem.ref
    IL_0070: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0075: br.s IL_008e
    IL_0077: ldarg.0
    IL_0078: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_007d: ldloc.0
    IL_007e: ldelem.ref
    IL_007f: ldarg.0
    IL_0080: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0085: ldloc.0
    IL_0086: ldc.i4.1
    IL_0087: add
    IL_0088: ldelem.ref
    IL_0089: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_008e: ldarg.0
    IL_008f: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_0094: ldloc.0
    IL_0095: ldelem.ref
    IL_0096: ldarg.0
    IL_0097: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_009c: ldarg.0
    IL_009d: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00a2: ldlen
    IL_00a3: conv.i4
    IL_00a4: ldc.i4.1
    IL_00a5: sub
    IL_00a6: ldelem.ref
    IL_00a7: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_00ac: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_00b7: ldloc.0
    IL_00b8: ldelem.ref
    IL_00b9: ldarg.0
    IL_00ba: ldfld ETMapChoiceDisplay[] ETChoicePickScreen::choicesUIDisplays  /*0x040013E5*/
    IL_00bf: ldc.i4.0
    IL_00c0: ldelem.ref
    IL_00c1: ldfld ThronefallUIElement ETMapChoiceDisplay::confirmButton  /*0x040013FD*/
    IL_00c6: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_00d1: ldloc.0
    IL_00d2: ldelem.ref
    IL_00d3: ldc.i4.1
    IL_00d4: stfld bool ThronefallUIElement::forceNavigateToDisabledElements  /*0x04001680*/
    IL_00d9: ldloc.0
    IL_00da: ldc.i4.1
    IL_00db: add
    IL_00dc: stloc.0
    IL_00dd: ldloc.0
    IL_00de: ldarg.0
    IL_00df: ldfld TFUIEquippable[] ETChoicePickScreen::currentLoadoutTFUIs  /*0x040013E6*/
    IL_00e4: ldlen
    IL_00e5: conv.i4
    IL_00e6: blt IL_0019
    IL_00eb: ret

  .method ETChoicePickScreen::.ctor()  // token 0x060010C8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

