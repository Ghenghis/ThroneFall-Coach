// ===== ChoiceUIFrameHelper  (token 0x020002E2) =====
  .method ChoiceUIFrameHelper::OnShow()  // token 0x06000FDE rva 0x4878c attrs Public, HideBySig
    // code size 204 (0xcc), max stack 3, init locals
    .locals ([0] IEnumerator, [1] IDisposable, [2] List.Enumerator<Choice>, [3] Choice)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0006: callvirt void System.Collections.Generic.List<TFUIUpgradeChoice>::Clear()  /*0x0A00063C*/
    IL_000b: ldarg.0
    IL_000c: ldfld GridLayoutGroup ChoiceUIFrameHelper::choicesParent  /*0x040012B7*/
    IL_0011: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0016: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_001b: stloc.0
    IL_001c: br.s IL_0033
    IL_001e: ldloc.0
    IL_001f: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0024: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0029: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0033: ldloc.0
    IL_0034: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0039: brtrue.s IL_001e
    IL_003b: leave.s IL_004e
    IL_003d: ldloc.0
    IL_003e: isinst System.IDisposable  /*0x0100001B*/
    IL_0043: stloc.1
    IL_0044: ldloc.1
    IL_0045: brfalse.s IL_004d
    IL_0047: ldloc.1
    IL_0048: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_004d: endfinally
    IL_004e: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0053: ldfld List<Choice> ChoiceManager::availableChoices  /*0x04000B8A*/
    IL_0058: callvirt int System.Collections.Generic.List<Choice>::get_Count()  /*0x0A0003E1*/
    IL_005d: ldc.i4.4
    IL_005e: ble.s IL_006e
    IL_0060: ldarg.0
    IL_0061: ldfld GridLayoutGroup ChoiceUIFrameHelper::choicesParent  /*0x040012B7*/
    IL_0066: ldc.i4.3
    IL_0067: callvirt void UnityEngine.UI.GridLayoutGroup::set_constraintCount(int)  /*0x0A00063D*/
    IL_006c: br.s IL_007a
    IL_006e: ldarg.0
    IL_006f: ldfld GridLayoutGroup ChoiceUIFrameHelper::choicesParent  /*0x040012B7*/
    IL_0074: ldc.i4.4
    IL_0075: callvirt void UnityEngine.UI.GridLayoutGroup::set_constraintCount(int)  /*0x0A00063D*/
    IL_007a: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_007f: ldfld List<Choice> ChoiceManager::availableChoices  /*0x04000B8A*/
    IL_0084: callvirt List.Enumerator<!0> System.Collections.Generic.List<Choice>::GetEnumerator()  /*0x0A00063E*/
    IL_0089: stloc.2
    IL_008a: br.s IL_00a1
    IL_008c: ldloca.s 2
    IL_008e: call !0 System.Collections.Generic.List.Enumerator<Choice>::get_Current()  /*0x0A00063F*/
    IL_0093: stloc.3
    IL_0094: ldarg.0
    IL_0095: ldarg.0
    IL_0096: ldfld GridLayoutGroup ChoiceUIFrameHelper::choicesParent  /*0x040012B7*/
    IL_009b: ldloc.3
    IL_009c: call void ChoiceUIFrameHelper::AddChoiceTFUI(UnityEngine.UI.LayoutGroup,Choice)  /*0x06000FDF*/
    IL_00a1: ldloca.s 2
    IL_00a3: call bool System.Collections.Generic.List.Enumerator<Choice>::MoveNext()  /*0x0A000640*/
    IL_00a8: brtrue.s IL_008c
    IL_00aa: leave.s IL_00ba
    IL_00ac: ldloca.s 2
    IL_00ae: constrained. System.Collections.Generic.List.Enumerator<Choice>  /*0x1B000120*/
    IL_00b4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b9: endfinally
    IL_00ba: ldarg.0
    IL_00bb: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_00c0: call void UnityEngine.UI.LayoutRebuilder::ForceRebuildLayoutImmediate(UnityEngine.RectTransform)  /*0x0A000641*/
    IL_00c5: ldarg.0
    IL_00c6: call void ChoiceUIFrameHelper::RecomputeNavigation()  /*0x06000FE0*/
    IL_00cb: ret
    .try IL_001c-IL_003d finally handler IL_003d-IL_004e
    .try IL_008a-IL_00ac finally handler IL_00ac-IL_00ba

  .method ChoiceUIFrameHelper::AddChoiceTFUI(UnityEngine.UI.LayoutGroup,Choice)  // token 0x06000FDF rva 0x48880 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 2, init locals
    .locals ([0] TFUIUpgradeChoice)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIUpgradeChoice ChoiceUIFrameHelper::upgradeChoiceButtonPrefab  /*0x040012B8*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIUpgradeChoice>  /*0x2B0000E0*/
    IL_0011: callvirt !!0 UnityEngine.Component::GetComponent()<TFUIUpgradeChoice>  /*0x2B0000E1*/
    IL_0016: stloc.0
    IL_0017: ldloc.0
    IL_0018: ldarg.2
    IL_0019: callvirt void TFUIUpgradeChoice::SetData(Choice)  /*0x060012A1*/
    IL_001e: ldarg.0
    IL_001f: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0024: ldloc.0
    IL_0025: callvirt void System.Collections.Generic.List<TFUIUpgradeChoice>::Add(!0)  /*0x0A000642*/
    IL_002a: ret

  .method ChoiceUIFrameHelper::RecomputeNavigation()  // token 0x06000FE0 rva 0x488b8 attrs Private, HideBySig
    // code size 342 (0x156), max stack 4, init locals
    .locals ([0] int, [1] int, [2] TFUIUpgradeChoice, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld GridLayoutGroup ChoiceUIFrameHelper::choicesParent  /*0x040012B7*/
    IL_0006: callvirt int UnityEngine.UI.GridLayoutGroup::get_constraintCount()  /*0x0A000643*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: br IL_012d
    IL_0013: ldarg.0
    IL_0014: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0019: ldloc.1
    IL_001a: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_001f: stloc.2
    IL_0020: ldloc.1
    IL_0021: ldc.i4.0
    IL_0022: bgt.s IL_0044
    IL_0024: ldloc.2
    IL_0025: ldarg.0
    IL_0026: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0031: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_0036: ldc.i4.1
    IL_0037: sub
    IL_0038: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_003d: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0042: br.s IL_0058
    IL_0044: ldloc.2
    IL_0045: ldarg.0
    IL_0046: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_004b: ldloc.1
    IL_004c: ldc.i4.1
    IL_004d: sub
    IL_004e: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_0053: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0058: ldloc.1
    IL_0059: ldarg.0
    IL_005a: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_005f: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_0064: ldc.i4.1
    IL_0065: sub
    IL_0066: blt.s IL_007c
    IL_0068: ldloc.2
    IL_0069: ldarg.0
    IL_006a: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_006f: ldc.i4.0
    IL_0070: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_0075: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_007a: br.s IL_0090
    IL_007c: ldloc.2
    IL_007d: ldarg.0
    IL_007e: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0083: ldloc.1
    IL_0084: ldc.i4.1
    IL_0085: add
    IL_0086: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_008b: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0090: ldarg.0
    IL_0091: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0096: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_009b: ldloc.0
    IL_009c: ble IL_0129
    IL_00a1: ldloc.1
    IL_00a2: ldloc.0
    IL_00a3: sub
    IL_00a4: stloc.3
    IL_00a5: ldloc.1
    IL_00a6: ldloc.0
    IL_00a7: add
    IL_00a8: stloc.s 4
    IL_00aa: ldloc.3
    IL_00ab: ldc.i4.0
    IL_00ac: bge.s IL_00d3
    IL_00ae: ldarg.0
    IL_00af: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_00b4: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_00b9: ldloc.3
    IL_00ba: call int UnityEngine.Mathf::Abs(int)  /*0x0A000646*/
    IL_00bf: sub
    IL_00c0: stloc.3
    IL_00c1: ldloc.3
    IL_00c2: ldc.i4.0
    IL_00c3: bge.s IL_00d3
    IL_00c5: ldarg.0
    IL_00c6: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_00cb: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_00d0: ldc.i4.1
    IL_00d1: sub
    IL_00d2: stloc.3
    IL_00d3: ldloc.s 4
    IL_00d5: ldarg.0
    IL_00d6: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_00db: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_00e0: blt.s IL_0104
    IL_00e2: ldloc.s 4
    IL_00e4: ldarg.0
    IL_00e5: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_00ea: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_00ef: sub
    IL_00f0: stloc.s 4
    IL_00f2: ldloc.s 4
    IL_00f4: ldarg.0
    IL_00f5: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_00fa: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_00ff: blt.s IL_0104
    IL_0101: ldc.i4.0
    IL_0102: stloc.s 4
    IL_0104: ldloc.2
    IL_0105: ldarg.0
    IL_0106: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_010b: ldloc.3
    IL_010c: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_0111: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0116: ldloc.2
    IL_0117: ldarg.0
    IL_0118: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_011d: ldloc.s 4
    IL_011f: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_0124: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0129: ldloc.1
    IL_012a: ldc.i4.1
    IL_012b: add
    IL_012c: stloc.1
    IL_012d: ldloc.1
    IL_012e: ldarg.0
    IL_012f: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0134: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_0139: blt IL_0013
    IL_013e: ldarg.0
    IL_013f: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_0144: ldarg.0
    IL_0145: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_014a: ldc.i4.0
    IL_014b: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_0150: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_0155: ret

  .method ChoiceUIFrameHelper::UpdateSelectedChoice()  // token 0x06000FE1 rva 0x48a1c attrs Public, HideBySig
    // code size 349 (0x15d), max stack 6, init locals
    .locals ([0] TFUIUpgradeChoice, [1] BuildSlot, [2] int)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_0008: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_000d: ldnull
    IL_000e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0013: brfalse.s IL_0026
    IL_0015: ldarg.0
    IL_0016: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_001b: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_0020: isinst TFUIUpgradeChoice  /*0x02000361*/
    IL_0025: stloc.0
    IL_0026: ldloc.0
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002d: brfalse.s IL_0053
    IL_002f: ldarg.0
    IL_0030: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_0035: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0040: brfalse.s IL_0053
    IL_0042: ldarg.0
    IL_0043: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_0048: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_004d: isinst TFUIUpgradeChoice  /*0x02000361*/
    IL_0052: stloc.0
    IL_0053: ldloc.0
    IL_0054: ldnull
    IL_0055: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_005a: brfalse IL_012c
    IL_005f: ldloc.0
    IL_0060: callvirt Choice TFUIUpgradeChoice::get_Data()  /*0x06001294*/
    IL_0065: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_006a: brfalse.s IL_00a3
    IL_006c: ldarg.0
    IL_006d: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceTitle  /*0x040012B9*/
    IL_0072: ldstr "Menu/Locked"
    IL_0077: ldc.i4.1
    IL_0078: ldc.i4.0
    IL_0079: ldc.i4.1
    IL_007a: ldc.i4.1
    IL_007b: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0080: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0085: ldarg.0
    IL_0086: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceDescription  /*0x040012BA*/
    IL_008b: ldstr "Menu/Locked Choice Mini Mode Description"
    IL_0090: ldc.i4.1
    IL_0091: ldc.i4.0
    IL_0092: ldc.i4.1
    IL_0093: ldc.i4.1
    IL_0094: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0099: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_009e: br IL_012c
    IL_00a3: ldloc.0
    IL_00a4: callvirt bool TFUIUpgradeChoice::get_Locked()  /*0x06001295*/
    IL_00a9: brtrue.s IL_00f8
    IL_00ab: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_00b0: ldfld BuildSlot ChoiceManager::currentOriginBuildSlot  /*0x04000B8C*/
    IL_00b5: stloc.1
    IL_00b6: ldarg.0
    IL_00b7: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceTitle  /*0x040012B9*/
    IL_00bc: ldloc.1
    IL_00bd: ldloc.0
    IL_00be: callvirt Choice TFUIUpgradeChoice::get_Data()  /*0x06001294*/
    IL_00c3: callvirt string BuildSlot::GET_LOCIDENTIFIER_CHOICENAME(Choice)  /*0x060002C4*/
    IL_00c8: ldc.i4.1
    IL_00c9: ldc.i4.0
    IL_00ca: ldc.i4.1
    IL_00cb: ldc.i4.1
    IL_00cc: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00d1: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceDescription  /*0x040012BA*/
    IL_00dc: ldloc.1
    IL_00dd: ldloc.0
    IL_00de: callvirt Choice TFUIUpgradeChoice::get_Data()  /*0x06001294*/
    IL_00e3: callvirt string BuildSlot::GET_LOCIDENTIFIER_CHOICEDESCRIPTION(Choice)  /*0x060002C5*/
    IL_00e8: ldc.i4.1
    IL_00e9: ldc.i4.0
    IL_00ea: ldc.i4.1
    IL_00eb: ldc.i4.1
    IL_00ec: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00f1: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00f6: br.s IL_012c
    IL_00f8: ldarg.0
    IL_00f9: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceTitle  /*0x040012B9*/
    IL_00fe: ldstr "Menu/Locked"
    IL_0103: ldc.i4.1
    IL_0104: ldc.i4.0
    IL_0105: ldc.i4.1
    IL_0106: ldc.i4.1
    IL_0107: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_010c: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0111: ldarg.0
    IL_0112: ldfld TextMeshProUGUI ChoiceUIFrameHelper::choiceDescription  /*0x040012BA*/
    IL_0117: ldloc.0
    IL_0118: callvirt Choice TFUIUpgradeChoice::get_Data()  /*0x06001294*/
    IL_011d: ldfld EquippableBuildingUpgrade Choice::requiresUnlocked  /*0x04000B96*/
    IL_0122: callvirt string Equippable::GetLockedTooltip()  /*0x06000B57*/
    IL_0127: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_012c: ldc.i4.0
    IL_012d: stloc.2
    IL_012e: br.s IL_014e
    IL_0130: ldarg.0
    IL_0131: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0136: ldloc.2
    IL_0137: callvirt !0 System.Collections.Generic.List<TFUIUpgradeChoice>::get_Item(int)  /*0x0A000644*/
    IL_013c: ldloc.0
    IL_013d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0142: brfalse.s IL_014a
    IL_0144: ldloc.2
    IL_0145: stsfld int ChoiceUIFrameHelper::CurrentSelectionIndex  /*0x040012B5*/
    IL_014a: ldloc.2
    IL_014b: ldc.i4.1
    IL_014c: add
    IL_014d: stloc.2
    IL_014e: ldloc.2
    IL_014f: ldarg.0
    IL_0150: ldfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_0155: callvirt int System.Collections.Generic.List<TFUIUpgradeChoice>::get_Count()  /*0x0A000645*/
    IL_015a: blt.s IL_0130
    IL_015c: ret

  .method ChoiceUIFrameHelper::OnApply()  // token 0x06000FE2 rva 0x48b88 attrs Public, HideBySig
    // code size 62 (0x3e), max stack 2, init locals
    .locals ([0] TFUIUpgradeChoice)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame ChoiceUIFrameHelper::frame  /*0x040012B6*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_LastApplied()  /*0x060012E8*/
    IL_000b: isinst TFUIUpgradeChoice  /*0x02000361*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brtrue.s IL_0022
    IL_001a: ldloc.0
    IL_001b: callvirt bool TFUIUpgradeChoice::get_Locked()  /*0x06001295*/
    IL_0020: brfalse.s IL_0023
    IL_0022: ret
    IL_0023: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0028: ldloc.0
    IL_0029: callvirt Choice TFUIUpgradeChoice::get_Data()  /*0x06001294*/
    IL_002e: stfld Choice ChoiceManager::choiceToReturn  /*0x04000B8B*/
    IL_0033: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0038: callvirt void UIFrameManager::CloseActiveFrame()  /*0x06001309*/
    IL_003d: ret

  .method ChoiceUIFrameHelper::.ctor()  // token 0x06000FE3 rva 0x48bd2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TFUIUpgradeChoice>::.ctor()  /*0x0A000647*/
    IL_0006: stfld List<TFUIUpgradeChoice> ChoiceUIFrameHelper::choices  /*0x040012BB*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

