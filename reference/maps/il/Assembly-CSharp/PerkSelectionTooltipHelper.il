// ===== PerkSelectionTooltipHelper  (token 0x0200032E) =====
  .method PerkSelectionTooltipHelper::OnSelection()  // token 0x06001188 rva 0x53c14 attrs Public, HideBySig
    // code size 205 (0xcd), max stack 2, init locals
    .locals ([0] TFUIEquippable, [1] TFUIEnemy, [2] TFUIIncomeDisplay, [3] TFUIPlayerUnit)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brfalse.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_001a: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_001f: isinst TFUIEquippable  /*0x0200034D*/
    IL_0024: stloc.0
    IL_0025: ldarg.0
    IL_0026: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_002b: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0030: isinst TFUIEnemy  /*0x0200034A*/
    IL_0035: stloc.1
    IL_0036: ldarg.0
    IL_0037: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_003c: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0041: isinst TFUIIncomeDisplay  /*0x02000351*/
    IL_0046: stloc.2
    IL_0047: ldarg.0
    IL_0048: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_004d: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0052: isinst TFUIPlayerUnit  /*0x02000355*/
    IL_0057: stloc.3
    IL_0058: ldloc.0
    IL_0059: ldnull
    IL_005a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005f: brfalse.s IL_0091
    IL_0061: ldloc.1
    IL_0062: ldnull
    IL_0063: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0068: brfalse.s IL_0091
    IL_006a: ldloc.2
    IL_006b: ldnull
    IL_006c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0071: brfalse.s IL_0091
    IL_0073: ldloc.3
    IL_0074: ldnull
    IL_0075: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_007a: brfalse.s IL_0091
    IL_007c: ldarg.0
    IL_007d: ldfld bool PerkSelectionTooltipHelper::disableOnNullSelect  /*0x04001512*/
    IL_0082: brfalse.s IL_0090
    IL_0084: ldarg.0
    IL_0085: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_008a: ldc.i4.0
    IL_008b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0090: ret
    IL_0091: ldarg.0
    IL_0092: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_0097: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009c: brfalse.s IL_00aa
    IL_009e: ldarg.0
    IL_009f: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_00a4: ldc.i4.1
    IL_00a5: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00aa: ldarg.0
    IL_00ab: ldloc.0
    IL_00ac: stfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_00b1: ldarg.0
    IL_00b2: ldloc.1
    IL_00b3: stfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_00b8: ldarg.0
    IL_00b9: ldloc.3
    IL_00ba: stfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_00bf: ldarg.0
    IL_00c0: ldloc.2
    IL_00c1: stfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_00c6: ldarg.0
    IL_00c7: call void PerkSelectionTooltipHelper::UpdateTooltip()  /*0x0600118A*/
    IL_00cc: ret

  .method PerkSelectionTooltipHelper::OnFocus()  // token 0x06001189 rva 0x53cf0 attrs Public, HideBySig
    // code size 211 (0xd3), max stack 2, init locals
    .locals ([0] TFUIEquippable, [1] TFUIEnemy, [2] TFUIIncomeDisplay, [3] TFUIPlayerUnit)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_000b: ldnull
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: brfalse.s IL_001a
    IL_0013: ldarg.0
    IL_0014: call void PerkSelectionTooltipHelper::OnSelection()  /*0x06001188*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_0020: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0025: brfalse.s IL_0033
    IL_0027: ldarg.0
    IL_0028: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_002d: ldc.i4.1
    IL_002e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0033: ldarg.0
    IL_0034: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_0039: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_003e: isinst TFUIEquippable  /*0x0200034D*/
    IL_0043: stloc.0
    IL_0044: ldarg.0
    IL_0045: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_004a: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_004f: isinst TFUIEnemy  /*0x0200034A*/
    IL_0054: stloc.1
    IL_0055: ldarg.0
    IL_0056: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_005b: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_0060: isinst TFUIIncomeDisplay  /*0x02000351*/
    IL_0065: stloc.2
    IL_0066: ldarg.0
    IL_0067: ldfld UIFrame PerkSelectionTooltipHelper::targetFrame  /*0x0400150B*/
    IL_006c: callvirt ThronefallUIElement UIFrame::get_CurrentFocus()  /*0x060012E7*/
    IL_0071: isinst TFUIPlayerUnit  /*0x02000355*/
    IL_0076: stloc.3
    IL_0077: ldloc.0
    IL_0078: ldnull
    IL_0079: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_007e: brfalse.s IL_00b0
    IL_0080: ldloc.1
    IL_0081: ldnull
    IL_0082: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0087: brfalse.s IL_00b0
    IL_0089: ldloc.2
    IL_008a: ldnull
    IL_008b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0090: brfalse.s IL_00b0
    IL_0092: ldloc.3
    IL_0093: ldnull
    IL_0094: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0099: brfalse.s IL_00b0
    IL_009b: ldarg.0
    IL_009c: ldfld bool PerkSelectionTooltipHelper::disableOnNullSelect  /*0x04001512*/
    IL_00a1: brfalse.s IL_00af
    IL_00a3: ldarg.0
    IL_00a4: ldfld GameObject PerkSelectionTooltipHelper::tooltipParent  /*0x04001513*/
    IL_00a9: ldc.i4.0
    IL_00aa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00af: ret
    IL_00b0: ldarg.0
    IL_00b1: ldloc.0
    IL_00b2: stfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_00b7: ldarg.0
    IL_00b8: ldloc.1
    IL_00b9: stfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_00be: ldarg.0
    IL_00bf: ldloc.3
    IL_00c0: stfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_00c5: ldarg.0
    IL_00c6: ldloc.2
    IL_00c7: stfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_00cc: ldarg.0
    IL_00cd: call void PerkSelectionTooltipHelper::UpdateTooltip()  /*0x0600118A*/
    IL_00d2: ret

  .method PerkSelectionTooltipHelper::UpdateTooltip()  // token 0x0600118A rva 0x53dd0 attrs Public, HideBySig
    // code size 1522 (0x5f2), max stack 5, init locals
    .locals ([0] string, [1] string, [2] Equippable, [3] WaveEnemyInfo, [4] UnitInfo, [5] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0039
    IL_000e: ldarg.0
    IL_000f: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001a: brfalse.s IL_0039
    IL_001c: ldarg.0
    IL_001d: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_0022: ldnull
    IL_0023: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0028: brfalse.s IL_0039
    IL_002a: ldarg.0
    IL_002b: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_0030: ldnull
    IL_0031: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0036: brfalse.s IL_0039
    IL_0038: ret
    IL_0039: ldstr ""
    IL_003e: stloc.0
    IL_003f: ldstr ""
    IL_0044: stloc.1
    IL_0045: ldarg.0
    IL_0046: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_004b: ldnull
    IL_004c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0051: brfalse IL_0181
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_005c: callvirt Equippable TFUIEquippable::get_Data()  /*0x060011F6*/
    IL_0061: stloc.2
    IL_0062: ldarg.0
    IL_0063: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_0068: callvirt bool TFUIEquippable::get_Locked()  /*0x060011FA*/
    IL_006d: brfalse.s IL_00a2
    IL_006f: ldstr "Menu/Locked"
    IL_0074: ldc.i4.1
    IL_0075: ldc.i4.0
    IL_0076: ldc.i4.1
    IL_0077: ldc.i4.1
    IL_0078: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_007d: stloc.0
    IL_007e: ldloc.2
    IL_007f: callvirt string Equippable::GetLockedTooltip()  /*0x06000B57*/
    IL_0084: stloc.1
    IL_0085: ldarg.0
    IL_0086: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_008b: ldarg.0
    IL_008c: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_0091: callvirt Image TFUIEquippable::get_IconImg()  /*0x060011FB*/
    IL_0096: callvirt Sprite UnityEngine.UI.Image::get_sprite()  /*0x0A0006FB*/
    IL_009b: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_00a0: br.s IL_00d3
    IL_00a2: ldloc.2
    IL_00a3: callvirt string Equippable::get_LOCIDENTIFIER_NAME()  /*0x06000B4F*/
    IL_00a8: ldc.i4.1
    IL_00a9: ldc.i4.0
    IL_00aa: ldc.i4.1
    IL_00ab: ldc.i4.1
    IL_00ac: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00b1: stloc.0
    IL_00b2: ldloc.2
    IL_00b3: callvirt string Equippable::get_LOCIDENTIFIER_DESCRIPTION()  /*0x06000B50*/
    IL_00b8: ldc.i4.1
    IL_00b9: ldc.i4.0
    IL_00ba: ldc.i4.1
    IL_00bb: ldc.i4.1
    IL_00bc: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_00c1: stloc.1
    IL_00c2: ldarg.0
    IL_00c3: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_00c8: ldloc.2
    IL_00c9: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_00ce: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_00d3: ldarg.0
    IL_00d4: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_00d9: ldarg.0
    IL_00da: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_00df: callvirt Color TFUIEquippable::GetDefaultOutlineColor()  /*0x060011FE*/
    IL_00e4: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_00e9: ldarg.0
    IL_00ea: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_00ef: ldarg.0
    IL_00f0: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_00f5: callvirt Color TFUIEquippable::get_GetBackgroundColor()  /*0x060011FC*/
    IL_00fa: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00ff: ldarg.0
    IL_0100: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_0105: ldarg.0
    IL_0106: ldfld TFUIEquippable PerkSelectionTooltipHelper::currentEquippableElement  /*0x04001517*/
    IL_010b: callvirt Color TFUIEquippable::get_GetIconColor()  /*0x060011FD*/
    IL_0110: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0115: ldarg.0
    IL_0116: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_011b: ldc.i4.1
    IL_011c: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0121: ldarg.0
    IL_0122: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_0127: ldnull
    IL_0128: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_012d: brfalse.s IL_013b
    IL_012f: ldarg.0
    IL_0130: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_0135: ldc.i4.0
    IL_0136: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_013b: ldarg.0
    IL_013c: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0141: ldnull
    IL_0142: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0147: brfalse.s IL_015a
    IL_0149: ldarg.0
    IL_014a: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_014f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0154: ldc.i4.0
    IL_0155: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_015a: ldarg.0
    IL_015b: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_0160: ldnull
    IL_0161: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0166: brfalse IL_05c1
    IL_016b: ldarg.0
    IL_016c: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_0171: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0176: ldc.i4.0
    IL_0177: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_017c: br IL_05c1
    IL_0181: ldarg.0
    IL_0182: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_0187: ldnull
    IL_0188: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_018d: brfalse IL_0316
    IL_0192: ldarg.0
    IL_0193: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_0198: callvirt WaveEnemyInfo TFUIEnemy::get_Data()  /*0x060011E1*/
    IL_019d: stloc.3
    IL_019e: ldloc.3
    IL_019f: ldfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_01a4: stloc.0
    IL_01a5: ldloc.3
    IL_01a6: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_01ab: brfalse.s IL_01c7
    IL_01ad: ldstr "Menu/Elite Prefix"
    IL_01b2: ldc.i4.1
    IL_01b3: ldc.i4.0
    IL_01b4: ldc.i4.1
    IL_01b5: ldc.i4.1
    IL_01b6: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_01bb: ldstr " "
    IL_01c0: ldloc.0
    IL_01c1: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_01c6: stloc.0
    IL_01c7: ldloc.3
    IL_01c8: ldfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_01cd: stloc.1
    IL_01ce: ldarg.0
    IL_01cf: ldloc.3
    IL_01d0: call void PerkSelectionTooltipHelper::SetEnemySprite(WaveEnemyInfo)  /*0x0600118B*/
    IL_01d5: ldarg.0
    IL_01d6: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_01db: ldarg.0
    IL_01dc: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_01e1: callvirt Color TFUIUnit::GetDefaultOutlineColor()  /*0x06001285*/
    IL_01e6: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_01eb: ldarg.0
    IL_01ec: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_01f1: ldarg.0
    IL_01f2: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_01f7: callvirt Color TFUIUnit::get_GetBackgroundColor()  /*0x06001283*/
    IL_01fc: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0201: ldarg.0
    IL_0202: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0207: ldloc.3
    IL_0208: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_020d: ldc.i4.0
    IL_020e: ceq
    IL_0210: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0215: ldarg.0
    IL_0216: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_021b: ldnull
    IL_021c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0221: brfalse.s IL_0260
    IL_0223: ldarg.0
    IL_0224: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_0229: ldarg.0
    IL_022a: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_022f: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_0234: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0239: ldarg.0
    IL_023a: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_023f: ldarg.0
    IL_0240: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0245: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_024a: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_024f: ldarg.0
    IL_0250: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_0255: ldloc.3
    IL_0256: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_025b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0260: ldarg.0
    IL_0261: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_0266: ldarg.0
    IL_0267: ldfld TFUIEnemy PerkSelectionTooltipHelper::currentEnemyElement  /*0x04001518*/
    IL_026c: callvirt Color TFUIUnit::get_GetIconColor()  /*0x06001284*/
    IL_0271: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0276: ldarg.0
    IL_0277: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_027c: ldnull
    IL_027d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0282: brfalse.s IL_02c1
    IL_0284: ldarg.0
    IL_0285: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_028a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_028f: ldc.i4.1
    IL_0290: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0295: ldarg.0
    IL_0296: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_029b: ldarg.0
    IL_029c: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_02a1: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_02a6: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_02ab: ldarg.0
    IL_02ac: ldfld TextMeshProUGUI PerkSelectionTooltipHelper::enemyNumberText  /*0x04001515*/
    IL_02b1: ldloc.3
    IL_02b2: ldflda int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_02b7: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02bc: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02c1: ldarg.0
    IL_02c2: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_02c7: ldnull
    IL_02c8: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_02cd: brfalse IL_05c1
    IL_02d2: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_02d7: callvirt bool SettingsManager::get_EnableUnitStats()  /*0x06000DB0*/
    IL_02dc: brfalse.s IL_0300
    IL_02de: ldarg.0
    IL_02df: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_02e4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_02e9: ldc.i4.1
    IL_02ea: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_02ef: ldarg.0
    IL_02f0: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_02f5: ldloc.3
    IL_02f6: callvirt void UnitStatsDisplayUI::SetStats(WaveEnemyInfo)  /*0x06001323*/
    IL_02fb: br IL_05c1
    IL_0300: ldarg.0
    IL_0301: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_0306: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_030b: ldc.i4.0
    IL_030c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0311: br IL_05c1
    IL_0316: ldarg.0
    IL_0317: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_031c: ldnull
    IL_031d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0322: brfalse IL_04be
    IL_0327: ldarg.0
    IL_0328: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_032d: callvirt UnitInfo TFUIPlayerUnit::get_Data()  /*0x0600122E*/
    IL_0332: stloc.s 4
    IL_0334: ldloc.s 4
    IL_0336: ldfld string UnitInfo::unitName  /*0x040017ED*/
    IL_033b: stloc.0
    IL_033c: ldloc.s 4
    IL_033e: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_0343: brfalse.s IL_035f
    IL_0345: ldstr "Menu/Elite Prefix"
    IL_034a: ldc.i4.1
    IL_034b: ldc.i4.0
    IL_034c: ldc.i4.1
    IL_034d: ldc.i4.1
    IL_034e: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0353: ldstr " "
    IL_0358: ldloc.0
    IL_0359: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_035e: stloc.0
    IL_035f: ldloc.s 4
    IL_0361: ldfld string UnitInfo::unitDescription  /*0x040017EE*/
    IL_0366: stloc.1
    IL_0367: ldarg.0
    IL_0368: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_036d: ldloc.s 4
    IL_036f: ldfld Sprite UnitInfo::unitIcon  /*0x040017EC*/
    IL_0374: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0379: ldarg.0
    IL_037a: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_037f: ldarg.0
    IL_0380: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_0385: callvirt Color TFUIUnit::GetDefaultOutlineColor()  /*0x06001285*/
    IL_038a: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_038f: ldarg.0
    IL_0390: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0395: ldarg.0
    IL_0396: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_039b: callvirt Color TFUIUnit::get_GetBackgroundColor()  /*0x06001283*/
    IL_03a0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_03a5: ldarg.0
    IL_03a6: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_03ab: ldloc.s 4
    IL_03ad: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_03b2: ldc.i4.0
    IL_03b3: ceq
    IL_03b5: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_03ba: ldarg.0
    IL_03bb: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_03c0: ldnull
    IL_03c1: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_03c6: brfalse.s IL_0406
    IL_03c8: ldarg.0
    IL_03c9: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_03ce: ldarg.0
    IL_03cf: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_03d4: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_03d9: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_03de: ldarg.0
    IL_03df: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_03e4: ldarg.0
    IL_03e5: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_03ea: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_03ef: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_03f4: ldarg.0
    IL_03f5: ldfld MPImageBasic PerkSelectionTooltipHelper::eliteBackground  /*0x04001510*/
    IL_03fa: ldloc.s 4
    IL_03fc: ldfld bool UnitInfo::eliteUnit  /*0x040017F0*/
    IL_0401: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0406: ldarg.0
    IL_0407: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_040c: ldarg.0
    IL_040d: ldfld TFUIPlayerUnit PerkSelectionTooltipHelper::currentPlayerUnitElement  /*0x04001519*/
    IL_0412: callvirt Color TFUIUnit::get_GetIconColor()  /*0x06001284*/
    IL_0417: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_041c: ldarg.0
    IL_041d: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0422: ldnull
    IL_0423: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0428: brfalse.s IL_0468
    IL_042a: ldarg.0
    IL_042b: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0430: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0435: ldc.i4.1
    IL_0436: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_043b: ldarg.0
    IL_043c: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0441: ldarg.0
    IL_0442: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0447: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_044c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0451: ldarg.0
    IL_0452: ldfld TextMeshProUGUI PerkSelectionTooltipHelper::enemyNumberText  /*0x04001515*/
    IL_0457: ldloc.s 4
    IL_0459: ldflda int UnitInfo::unitCount  /*0x040017EF*/
    IL_045e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0463: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0468: ldarg.0
    IL_0469: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_046e: ldnull
    IL_046f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0474: brfalse IL_05c1
    IL_0479: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_047e: callvirt bool SettingsManager::get_EnableUnitStats()  /*0x06000DB0*/
    IL_0483: brfalse.s IL_04a8
    IL_0485: ldarg.0
    IL_0486: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_048b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0490: ldc.i4.1
    IL_0491: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0496: ldarg.0
    IL_0497: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_049c: ldloc.s 4
    IL_049e: callvirt void UnitStatsDisplayUI::SetStats(UnitInfo)  /*0x06001322*/
    IL_04a3: br IL_05c1
    IL_04a8: ldarg.0
    IL_04a9: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_04ae: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_04b3: ldc.i4.0
    IL_04b4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_04b9: br IL_05c1
    IL_04be: ldarg.0
    IL_04bf: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_04c4: ldnull
    IL_04c5: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_04ca: brfalse IL_05c1
    IL_04cf: ldarg.0
    IL_04d0: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_04d5: callvirt string TFUIIncomeDisplay::GetTitle()  /*0x0600121A*/
    IL_04da: stloc.0
    IL_04db: ldarg.0
    IL_04dc: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_04e1: callvirt string TFUIIncomeDisplay::GetDescription()  /*0x0600121B*/
    IL_04e6: stloc.1
    IL_04e7: ldarg.0
    IL_04e8: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_04ed: ldarg.0
    IL_04ee: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_04f3: ldfld Image TFUIPerklike::iconImg  /*0x040015D5*/
    IL_04f8: callvirt Sprite UnityEngine.UI.Image::get_sprite()  /*0x0A0006FB*/
    IL_04fd: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0502: ldarg.0
    IL_0503: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0508: ldarg.0
    IL_0509: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_050e: callvirt Color TFUIPerklike::GetDefaultOutlineColor()  /*0x0600121F*/
    IL_0513: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0518: ldarg.0
    IL_0519: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_051e: ldarg.0
    IL_051f: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_0524: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_0529: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_052e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0533: ldarg.0
    IL_0534: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_0539: ldarg.0
    IL_053a: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_053f: ldfld Image TFUIPerklike::iconImg  /*0x040015D5*/
    IL_0544: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0549: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_054e: ldarg.0
    IL_054f: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0554: ldnull
    IL_0555: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_055a: brfalse.s IL_05a2
    IL_055c: ldarg.0
    IL_055d: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0562: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0567: ldc.i4.1
    IL_0568: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_056d: ldarg.0
    IL_056e: ldfld MPImageBasic PerkSelectionTooltipHelper::enemyNumberBg  /*0x04001514*/
    IL_0573: ldarg.0
    IL_0574: ldfld MPImageBasic PerkSelectionTooltipHelper::background  /*0x0400150F*/
    IL_0579: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_057e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0583: ldarg.0
    IL_0584: ldfld TextMeshProUGUI PerkSelectionTooltipHelper::enemyNumberText  /*0x04001515*/
    IL_0589: ldarg.0
    IL_058a: ldfld TFUIIncomeDisplay PerkSelectionTooltipHelper::currentIncomeDisplay  /*0x0400151A*/
    IL_058f: callvirt int TFUIIncomeDisplay::get_CurrentIncome()  /*0x06001219*/
    IL_0594: stloc.s 5
    IL_0596: ldloca.s 5
    IL_0598: call string System.Int32::ToString()  /*0x0A000031*/
    IL_059d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_05a2: ldarg.0
    IL_05a3: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_05a8: ldnull
    IL_05a9: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_05ae: brfalse.s IL_05c1
    IL_05b0: ldarg.0
    IL_05b1: ldfld UnitStatsDisplayUI PerkSelectionTooltipHelper::UnitStatsDisplay  /*0x04001516*/
    IL_05b6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_05bb: ldc.i4.0
    IL_05bc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_05c1: ldarg.0
    IL_05c2: ldfld TextMeshProUGUI PerkSelectionTooltipHelper::selectionTitle  /*0x0400150C*/
    IL_05c7: ldloc.0
    IL_05c8: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_05cd: ldarg.0
    IL_05ce: ldfld TextMeshProUGUI PerkSelectionTooltipHelper::selectionDescription  /*0x0400150D*/
    IL_05d3: ldloc.1
    IL_05d4: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_05d9: ldarg.0
    IL_05da: ldfld UIParentResizer PerkSelectionTooltipHelper::sizer  /*0x04001511*/
    IL_05df: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_05e4: brfalse.s IL_05f1
    IL_05e6: ldarg.0
    IL_05e7: ldfld UIParentResizer PerkSelectionTooltipHelper::sizer  /*0x04001511*/
    IL_05ec: callvirt void UIParentResizer::Trigger()  /*0x0600131B*/
    IL_05f1: ret

  .method PerkSelectionTooltipHelper::SetEnemySprite(WaveEnemyInfo)  // token 0x0600118B rva 0x543d0 attrs Private, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_0006: ldarg.1
    IL_0007: ldfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_000c: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0011: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0016: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001b: brfalse.s IL_0048
    IL_001d: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0022: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_0027: brfalse.s IL_0048
    IL_0029: ldarg.1
    IL_002a: ldfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_002f: ldnull
    IL_0030: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0035: brfalse.s IL_0048
    IL_0037: ldarg.0
    IL_0038: ldfld Image PerkSelectionTooltipHelper::selectionIcon  /*0x0400150E*/
    IL_003d: ldarg.1
    IL_003e: ldfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_0043: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0048: ret

  .method PerkSelectionTooltipHelper::.ctor()  // token 0x0600118C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

