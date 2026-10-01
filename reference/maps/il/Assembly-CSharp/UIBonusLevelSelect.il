// ===== UIBonusLevelSelect  (token 0x02000370) =====
  .method UIBonusLevelSelect::OnShow()  // token 0x060012E1 rva 0x59cb0 attrs Public, HideBySig
    // code size 452 (0x1c4), max stack 3, init locals
    .locals ([0] int, [1] LevelInfo[], [2] int, [3] LevelInfo, [4] ThronefallUIElement, [5] int, [6] Transform, [7] int, [8] int, [9] int, [10] int)
    IL_0000: ldarg.0
    IL_0001: call void UIBonusLevelSelect::UpdateLevelTitle()  /*0x060012E3*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_000c: callvirt void System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::Clear()  /*0x0A000729*/
    IL_0011: ldarg.0
    IL_0012: ldfld Transform UIBonusLevelSelect::buttonParent  /*0x040016D2*/
    IL_0017: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_001c: ldc.i4.1
    IL_001d: sub
    IL_001e: stloc.0
    IL_001f: br.s IL_003b
    IL_0021: ldarg.0
    IL_0022: ldfld Transform UIBonusLevelSelect::buttonParent  /*0x040016D2*/
    IL_0027: ldloc.0
    IL_0028: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_002d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0032: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0037: ldloc.0
    IL_0038: ldc.i4.1
    IL_0039: sub
    IL_003a: stloc.0
    IL_003b: ldloc.0
    IL_003c: ldc.i4.0
    IL_003d: bge.s IL_0021
    IL_003f: ldsfld BonusLevelInteractor BonusLevelInteractor::lastSelected  /*0x0400126F*/
    IL_0044: ldfld LevelInfo[] BonusLevelInteractor::levelsToPick  /*0x0400127D*/
    IL_0049: stloc.1
    IL_004a: ldc.i4.0
    IL_004b: stloc.2
    IL_004c: br IL_00f8
    IL_0051: ldloc.1
    IL_0052: ldloc.2
    IL_0053: ldelem.ref
    IL_0054: stloc.3
    IL_0055: ldarg.0
    IL_0056: ldfld ThronefallUIElement UIBonusLevelSelect::buttonPrefab  /*0x040016D1*/
    IL_005b: ldarg.0
    IL_005c: ldfld Transform UIBonusLevelSelect::buttonParent  /*0x040016D2*/
    IL_0061: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<ThronefallUIElement>  /*0x2B0000F5*/
    IL_0066: stloc.s 4
    IL_0068: ldloc.s 4
    IL_006a: callvirt !!0 UnityEngine.Component::GetComponent()<TMPro.TextMeshProUGUI>  /*0x2B000086*/
    IL_006f: ldloc.3
    IL_0070: callvirt string LevelInfo::get_displaySubtitle()  /*0x060008E0*/
    IL_0075: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_007a: ldloc.3
    IL_007b: callvirt int LevelInfo::QuestsComplete()  /*0x060008E4*/
    IL_0080: stloc.s 5
    IL_0082: ldloc.s 4
    IL_0084: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0089: ldc.i4.0
    IL_008a: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_008f: stloc.s 6
    IL_0091: ldc.i4.0
    IL_0092: stloc.s 7
    IL_0094: br.s IL_00d6
    IL_0096: ldloc.s 7
    IL_0098: ldloc.s 5
    IL_009a: blt.s IL_00b7
    IL_009c: ldloc.s 6
    IL_009e: ldloc.s 7
    IL_00a0: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00a5: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.Image>  /*0x2B000097*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld Color UIBonusLevelSelect::crownLocked  /*0x040016D5*/
    IL_00b0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00b5: br.s IL_00d0
    IL_00b7: ldloc.s 6
    IL_00b9: ldloc.s 7
    IL_00bb: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_00c0: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.Image>  /*0x2B000097*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld Color UIBonusLevelSelect::crownUnlocked  /*0x040016D6*/
    IL_00cb: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00d0: ldloc.s 7
    IL_00d2: ldc.i4.1
    IL_00d3: add
    IL_00d4: stloc.s 7
    IL_00d6: ldloc.s 7
    IL_00d8: ldloc.s 6
    IL_00da: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_00df: blt.s IL_0096
    IL_00e1: ldarg.0
    IL_00e2: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_00e7: ldloc.s 4
    IL_00e9: ldloc.3
    IL_00ea: newobj void UIBonusLevelSelect.LevelButtonPair::.ctor(ThronefallUIElement,LevelInfo)  /*0x060012E5*/
    IL_00ef: callvirt void System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::Add(!0)  /*0x0A00072A*/
    IL_00f4: ldloc.2
    IL_00f5: ldc.i4.1
    IL_00f6: add
    IL_00f7: stloc.2
    IL_00f8: ldloc.2
    IL_00f9: ldloc.1
    IL_00fa: ldlen
    IL_00fb: conv.i4
    IL_00fc: blt IL_0051
    IL_0101: ldc.i4.0
    IL_0102: stloc.s 8
    IL_0104: br IL_0195
    IL_0109: ldloc.s 8
    IL_010b: ldc.i4.1
    IL_010c: sub
    IL_010d: stloc.s 9
    IL_010f: ldloc.s 8
    IL_0111: ldc.i4.1
    IL_0112: add
    IL_0113: stloc.s 10
    IL_0115: ldloc.s 9
    IL_0117: ldc.i4.0
    IL_0118: bge.s IL_0129
    IL_011a: ldarg.0
    IL_011b: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0120: callvirt int System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Count()  /*0x0A00072B*/
    IL_0125: ldc.i4.1
    IL_0126: sub
    IL_0127: stloc.s 9
    IL_0129: ldloc.s 10
    IL_012b: ldarg.0
    IL_012c: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0131: callvirt int System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Count()  /*0x0A00072B*/
    IL_0136: ldc.i4.1
    IL_0137: sub
    IL_0138: ble.s IL_013d
    IL_013a: ldc.i4.0
    IL_013b: stloc.s 10
    IL_013d: ldarg.0
    IL_013e: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0143: ldloc.s 8
    IL_0145: callvirt !0 System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Item(int)  /*0x0A00072C*/
    IL_014a: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_014f: ldarg.0
    IL_0150: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0155: ldloc.s 9
    IL_0157: callvirt !0 System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Item(int)  /*0x0A00072C*/
    IL_015c: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_0161: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0166: ldarg.0
    IL_0167: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_016c: ldloc.s 8
    IL_016e: callvirt !0 System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Item(int)  /*0x0A00072C*/
    IL_0173: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_0178: ldarg.0
    IL_0179: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_017e: ldloc.s 10
    IL_0180: callvirt !0 System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Item(int)  /*0x0A00072C*/
    IL_0185: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_018a: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_018f: ldloc.s 8
    IL_0191: ldc.i4.1
    IL_0192: add
    IL_0193: stloc.s 8
    IL_0195: ldloc.s 8
    IL_0197: ldarg.0
    IL_0198: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_019d: callvirt int System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Count()  /*0x0A00072B*/
    IL_01a2: blt IL_0109
    IL_01a7: ldarg.0
    IL_01a8: ldfld UIFrame UIBonusLevelSelect::frame  /*0x040016D0*/
    IL_01ad: ldarg.0
    IL_01ae: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_01b3: ldc.i4.0
    IL_01b4: callvirt !0 System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::get_Item(int)  /*0x0A00072C*/
    IL_01b9: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_01be: stfld ThronefallUIElement UIFrame::firstSelected  /*0x040016DA*/
    IL_01c3: ret

  .method UIBonusLevelSelect::OnSelectionApplied()  // token 0x060012E2 rva 0x59e80 attrs Public, HideBySig
    // code size 100 (0x64), max stack 2, init locals
    .locals ([0] ThronefallUIElement, [1] bool, [2] List.Enumerator<UIBonusLevelSelect.LevelButtonPair>, [3] UIBonusLevelSelect.LevelButtonPair)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame UIBonusLevelSelect::frame  /*0x040016D0*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_LastApplied()  /*0x060012E8*/
    IL_000b: stloc.0
    IL_000c: ldc.i4.0
    IL_000d: stloc.1
    IL_000e: ldarg.0
    IL_000f: ldfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0014: callvirt List.Enumerator<!0> System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::GetEnumerator()  /*0x0A00072D*/
    IL_0019: stloc.2
    IL_001a: br.s IL_0041
    IL_001c: ldloca.s 2
    IL_001e: call !0 System.Collections.Generic.List.Enumerator<UIBonusLevelSelect.LevelButtonPair>::get_Current()  /*0x0A00072E*/
    IL_0023: stloc.3
    IL_0024: ldloc.3
    IL_0025: ldfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_002a: ldloc.0
    IL_002b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0030: brfalse.s IL_0041
    IL_0032: ldc.i4.1
    IL_0033: stloc.1
    IL_0034: ldloc.3
    IL_0035: ldfld LevelInfo UIBonusLevelSelect.LevelButtonPair::info  /*0x040016D9*/
    IL_003a: stsfld LevelInfo LevelInteractor::lastActiveLevelInfo  /*0x04000ABB*/
    IL_003f: leave.s IL_005a
    IL_0041: ldloca.s 2
    IL_0043: call bool System.Collections.Generic.List.Enumerator<UIBonusLevelSelect.LevelButtonPair>::MoveNext()  /*0x0A00072F*/
    IL_0048: brtrue.s IL_001c
    IL_004a: leave.s IL_005a
    IL_004c: ldloca.s 2
    IL_004e: constrained. System.Collections.Generic.List.Enumerator<UIBonusLevelSelect.LevelButtonPair>  /*0x1B000151*/
    IL_0054: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0059: endfinally
    IL_005a: ldloc.1
    IL_005b: brtrue.s IL_005e
    IL_005d: ret
    IL_005e: call void UIFrameManager::ForceOpenLevelSelect()  /*0x0600130E*/
    IL_0063: ret
    .try IL_001a-IL_004c finally handler IL_004c-IL_005a

  .method UIBonusLevelSelect::UpdateLevelTitle()  // token 0x060012E3 rva 0x59f00 attrs Public, HideBySig
    // code size 118 (0x76), max stack 12, init locals
    .locals ([0] TextMeshProUGUI)
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI UIBonusLevelSelect::levelTitle  /*0x040016D3*/
    IL_0006: ldsfld BonusLevelInteractor BonusLevelInteractor::lastSelected  /*0x0400126F*/
    IL_000b: ldfld LevelInfo BonusLevelInteractor::baseLevelInfo  /*0x0400127E*/
    IL_0010: callvirt string LevelInfo::get_LocalizedDisplayName()  /*0x060008DF*/
    IL_0015: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_001a: ldarg.0
    IL_001b: ldfld TextMeshProUGUI UIBonusLevelSelect::levelTitle  /*0x040016D3*/
    IL_0020: stloc.0
    IL_0021: ldloc.0
    IL_0022: ldc.i4.6
    IL_0023: newarr System.String  /*0x0100001D*/
    IL_0028: dup
    IL_0029: ldc.i4.0
    IL_002a: ldloc.0
    IL_002b: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0030: stelem.ref
    IL_0031: dup
    IL_0032: ldc.i4.1
    IL_0033: ldstr "\n<size="
    IL_0038: stelem.ref
    IL_0039: dup
    IL_003a: ldc.i4.2
    IL_003b: ldarg.0
    IL_003c: ldflda float UIBonusLevelSelect::untertitleSize  /*0x040016D4*/
    IL_0041: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0046: stelem.ref
    IL_0047: dup
    IL_0048: ldc.i4.3
    IL_0049: ldstr "><style=Subheader>"
    IL_004e: stelem.ref
    IL_004f: dup
    IL_0050: ldc.i4.4
    IL_0051: ldstr "Menu/Bonus Modes"
    IL_0056: ldc.i4.1
    IL_0057: ldc.i4.0
    IL_0058: ldc.i4.1
    IL_0059: ldc.i4.0
    IL_005a: ldnull
    IL_005b: ldnull
    IL_005c: ldc.i4.1
    IL_005d: call string I2.Loc.LocalizationManager::GetTermTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001856*/
    IL_0062: stelem.ref
    IL_0063: dup
    IL_0064: ldc.i4.5
    IL_0065: ldstr "</size></style>"
    IL_006a: stelem.ref
    IL_006b: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0070: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0075: ret

  .method UIBonusLevelSelect::.ctor()  // token 0x060012E4 rva 0x59f82 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float UIBonusLevelSelect::untertitleSize  /*0x040016D4*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<UIBonusLevelSelect.LevelButtonPair>::.ctor()  /*0x0A000730*/
    IL_0011: stfld List<UIBonusLevelSelect.LevelButtonPair> UIBonusLevelSelect::levelButtonPairs  /*0x040016D7*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== UIBonusLevelSelect/LevelButtonPair  (token 0x02000371) =====
  .method UIBonusLevelSelect.LevelButtonPair::.ctor(ThronefallUIElement,LevelInfo)  // token 0x060012E5 rva 0x59fa0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld ThronefallUIElement UIBonusLevelSelect.LevelButtonPair::button  /*0x040016D8*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld LevelInfo UIBonusLevelSelect.LevelButtonPair::info  /*0x040016D9*/
    IL_0014: ret

