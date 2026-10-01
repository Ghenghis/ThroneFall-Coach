// ===== TFUIEquippable  (token 0x0200034D) =====
  .method TFUIEquippable::get_Data()  // token 0x060011F6 rva 0x56616 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0006: ret

  .method TFUIEquippable::get_isWeapon()  // token 0x060011F7 rva 0x5661e attrs Private, HideBySig, SpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0006: isinst EquippableWeapon  /*0x0200021B*/
    IL_000b: ldnull
    IL_000c: cgt.un
    IL_000e: ret

  .method TFUIEquippable::get_isPerk()  // token 0x060011F8 rva 0x5662e attrs Private, HideBySig, SpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0006: isinst EquippablePerk  /*0x0200021A*/
    IL_000b: ldnull
    IL_000c: cgt.un
    IL_000e: ret

  .method TFUIEquippable::get_isMutator()  // token 0x060011F9 rva 0x5663e attrs Private, HideBySig, SpecialName
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0006: isinst EquippableMutation  /*0x02000219*/
    IL_000b: ldnull
    IL_000c: cgt.un
    IL_000e: ret

  .method TFUIEquippable::get_Locked()  // token 0x060011FA rva 0x5664e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIEquippable::locked  /*0x040015C3*/
    IL_0006: ret

  .method TFUIEquippable::get_IconImg()  // token 0x060011FB rva 0x56656 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0006: ret

  .method TFUIEquippable::get_GetBackgroundColor()  // token 0x060011FC rva 0x5665e attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIEquippable::selectedForLoadout  /*0x040015BD*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld Color TFUIEquippable::defaultBGColor  /*0x040015C1*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_0015: ret

  .method TFUIEquippable::get_GetIconColor()  // token 0x060011FD rva 0x56675 attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIEquippable::selectedForLoadout  /*0x040015BD*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld Color TFUIEquippable::defaultIconColor  /*0x040015C2*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld Color TFUIEquippable::highlightIconColor  /*0x040015B0*/
    IL_0015: ret

  .method TFUIEquippable::GetDefaultOutlineColor()  // token 0x060011FE rva 0x5668c attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_000e: ldfld Color TFUIEquippable.Style::outlineColor  /*0x040015C5*/
    IL_0013: ret
    IL_0014: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0019: ret

  .method TFUIEquippable::Update()  // token 0x060011FF rva 0x566a7 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable.Animation TFUIEquippable::currentAnimation  /*0x040015BE*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIEquippable.Animation TFUIEquippable::currentAnimation  /*0x040015BE*/
    IL_000e: callvirt void TFUIEquippable.Animation::Tick()  /*0x06001211*/
    IL_0013: ret

  .method TFUIEquippable::OnApply()  // token 0x06001200 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIEquippable::OnClear()  // token 0x06001201 rva 0x566bc attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIEquippable.Style TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001206*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIEquippable.Animation::.ctor(TFUIEquippable.Style,TFUIEquippable.Style,TFUIEquippable)  /*0x06001210*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIEquippable::OnFocus()  // token 0x06001202 rva 0x566d7 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIEquippable.Style TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001206*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIEquippable.Style TFUIEquippable::focussedStyle  /*0x040015B8*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIEquippable.Animation::.ctor(TFUIEquippable.Style,TFUIEquippable.Style,TFUIEquippable)  /*0x06001210*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIEquippable::OnSelect()  // token 0x06001203 rva 0x566f2 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIEquippable.Style TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001206*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIEquippable.Style TFUIEquippable::selectedStyle  /*0x040015B9*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIEquippable.Animation::.ctor(TFUIEquippable.Style,TFUIEquippable.Style,TFUIEquippable)  /*0x06001210*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIEquippable::OnFocusAndSelect()  // token 0x06001204 rva 0x5670d attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIEquippable.Style TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001206*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIEquippable.Style TFUIEquippable::focussedAndSelectedStyle  /*0x040015BA*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIEquippable.Animation::.ctor(TFUIEquippable.Style,TFUIEquippable.Style,TFUIEquippable)  /*0x06001210*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIEquippable::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001205 rva 0x56728 attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUIEquippable.Animation TFUIEquippable::currentAnimation  /*0x040015BE*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUIEquippable.Style TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001206*/
    IL_000f: call void TFUIEquippable::ApplyStyle(TFUIEquippable.Style)  /*0x06001207*/
    IL_0014: ret

  .method TFUIEquippable::GetStyle(ThronefallUIElement.SelectionState)  // token 0x06001206 rva 0x56740 attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUIEquippable.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIEquippable::defaultStyleInitialized  /*0x040015BC*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIEquippable::InitializeDefaultStyle()  /*0x06001208*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUIEquippable.Style TFUIEquippable::focussedStyle  /*0x040015B8*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUIEquippable.Style TFUIEquippable::selectedStyle  /*0x040015B9*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUIEquippable.Style TFUIEquippable::focussedAndSelectedStyle  /*0x040015BA*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUIEquippable::ApplyStyle(TFUIEquippable.Style)  // token 0x06001207 rva 0x567a0 attrs Private, HideBySig
    // code size 80 (0x50), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001e
    IL_000e: ldstr "backround is null"
    IL_0013: ldarg.0
    IL_0014: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_001e: ldarg.0
    IL_001f: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0024: ldarg.1
    IL_0025: ldfld Color TFUIEquippable.Style::outlineColor  /*0x040015C5*/
    IL_002a: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_002f: ldarg.0
    IL_0030: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0035: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_003f: ldarg.1
    IL_0040: ldfld float TFUIEquippable.Style::scale  /*0x040015C4*/
    IL_0045: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_004a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_004f: ret

  .method TFUIEquippable::InitializeDefaultStyle()  // token 0x06001208 rva 0x567fc attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0007: callvirt Color MPUIKIT.MPImage::get_OutlineColor()  /*0x0A00071A*/
    IL_000c: ldarg.0
    IL_000d: ldfld AnimationCurve TFUIEquippable::defaultAnimationCurve  /*0x040015B6*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TFUIEquippable::defaultAnimationTime  /*0x040015B7*/
    IL_0018: ldc.r4 1f
    IL_001d: newobj void TFUIEquippable.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  /*0x0600120F*/
    IL_0022: stfld TFUIEquippable.Style TFUIEquippable::defaultStyle  /*0x040015BB*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld bool TFUIEquippable::defaultStyleInitialized  /*0x040015BC*/
    IL_002e: ret

  .method TFUIEquippable::SetData(Equippable,bool,bool,LevelInfo)  // token 0x06001209 rva 0x5682c attrs Public, HideBySig
    // code size 399 (0x18f), max stack 2, init locals
    .locals ([0] bool, [1] bool)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0007: ldarg.1
    IL_0008: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_000d: brtrue.s IL_0024
    IL_000f: ldarg.2
    IL_0010: brfalse.s IL_0021
    IL_0012: ldarg.s 4
    IL_0014: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0019: ldarg.1
    IL_001a: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_001f: br.s IL_0025
    IL_0021: ldc.i4.0
    IL_0022: br.s IL_0025
    IL_0024: ldc.i4.1
    IL_0025: stloc.0
    IL_0026: ldarg.2
    IL_0027: brfalse.s IL_003b
    IL_0029: ldarg.s 4
    IL_002b: ldfld List<Equippable> LevelInfo::fixedLoadout  /*0x04000B2A*/
    IL_0030: ldarg.1
    IL_0031: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0036: ldc.i4.0
    IL_0037: ceq
    IL_0039: br.s IL_003c
    IL_003b: ldc.i4.0
    IL_003c: stloc.1
    IL_003d: ldloc.0
    IL_003e: brfalse.s IL_0046
    IL_0040: ldloc.1
    IL_0041: ldc.i4.0
    IL_0042: ceq
    IL_0044: br.s IL_0047
    IL_0046: ldc.i4.0
    IL_0047: ldarg.3
    IL_0048: or
    IL_0049: brfalse IL_00d6
    IL_004e: ldarg.0
    IL_004f: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0054: ldarg.1
    IL_0055: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_005a: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_005f: ldarg.0
    IL_0060: call bool TFUIEquippable::get_isWeapon()  /*0x060011F7*/
    IL_0065: brfalse.s IL_0084
    IL_0067: ldarg.0
    IL_0068: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_006d: ldarg.0
    IL_006e: ldfld Color TFUIEquippable::weaponBgColor  /*0x040015A6*/
    IL_0073: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0078: ldarg.0
    IL_0079: ldarg.0
    IL_007a: ldfld Color TFUIEquippable::weaponHighlightColor  /*0x040015AB*/
    IL_007f: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_0084: ldarg.0
    IL_0085: call bool TFUIEquippable::get_isPerk()  /*0x060011F8*/
    IL_008a: brfalse.s IL_00a9
    IL_008c: ldarg.0
    IL_008d: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0092: ldarg.0
    IL_0093: ldfld Color TFUIEquippable::perkBgColor  /*0x040015A7*/
    IL_0098: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_009d: ldarg.0
    IL_009e: ldarg.0
    IL_009f: ldfld Color TFUIEquippable::perkHightlightColor  /*0x040015AC*/
    IL_00a4: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_00a9: ldarg.0
    IL_00aa: call bool TFUIEquippable::get_isMutator()  /*0x060011F9*/
    IL_00af: brfalse IL_016c
    IL_00b4: ldarg.0
    IL_00b5: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld Color TFUIEquippable::mutatorBgColor  /*0x040015A8*/
    IL_00c0: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00c5: ldarg.0
    IL_00c6: ldarg.0
    IL_00c7: ldfld Color TFUIEquippable::mutatorHighlightColor  /*0x040015AD*/
    IL_00cc: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_00d1: br IL_016c
    IL_00d6: ldloc.0
    IL_00d7: ldloc.1
    IL_00d8: and
    IL_00d9: brfalse.s IL_0121
    IL_00db: ldarg.0
    IL_00dc: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_00e1: ldarg.1
    IL_00e2: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_00e7: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_00f8: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00fd: ldarg.0
    IL_00fe: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0103: ldarg.0
    IL_0104: ldfld Color TFUIEquippable::lockedBgColor  /*0x040015A9*/
    IL_0109: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_010e: ldarg.0
    IL_010f: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0114: ldarg.0
    IL_0115: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_011a: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_011f: br.s IL_016c
    IL_0121: ldarg.0
    IL_0122: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0127: ldarg.0
    IL_0128: ldfld Sprite TFUIEquippable::lockIcon  /*0x040015B3*/
    IL_012d: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0132: ldarg.0
    IL_0133: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0138: ldarg.0
    IL_0139: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_013e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0143: ldarg.0
    IL_0144: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0149: ldarg.0
    IL_014a: ldfld Color TFUIEquippable::lockedBgColor  /*0x040015A9*/
    IL_014f: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0154: ldarg.0
    IL_0155: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_015a: ldarg.0
    IL_015b: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_0160: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_0165: ldarg.0
    IL_0166: ldc.i4.1
    IL_0167: stfld bool TFUIEquippable::locked  /*0x040015C3*/
    IL_016c: ldarg.0
    IL_016d: ldarg.0
    IL_016e: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0173: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0178: stfld Color TFUIEquippable::defaultBGColor  /*0x040015C1*/
    IL_017d: ldarg.0
    IL_017e: ldarg.0
    IL_017f: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0184: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0189: stfld Color TFUIEquippable::defaultIconColor  /*0x040015C2*/
    IL_018e: ret

  .method TFUIEquippable::SetDataEternalTrials(Equippable)  // token 0x0600120A rva 0x569c8 attrs Public, HideBySig
    // code size 360 (0x168), max stack 2, init locals
    .locals ([0] bool, [1] EquippablePerk)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0007: ldc.i4.0
    IL_0008: stloc.0
    IL_0009: ldarg.1
    IL_000a: isinst EquippablePerk  /*0x0200021A*/
    IL_000f: stloc.1
    IL_0010: ldloc.1
    IL_0011: ldnull
    IL_0012: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0017: brfalse.s IL_002d
    IL_0019: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_001e: ldfld List<EquippablePerk> EternalTrialsRun::disabledPerks  /*0x04000855*/
    IL_0023: ldloc.1
    IL_0024: callvirt bool System.Collections.Generic.List<EquippablePerk>::Contains(!0)  /*0x0A0002DD*/
    IL_0029: brfalse.s IL_002d
    IL_002b: ldc.i4.1
    IL_002c: stloc.0
    IL_002d: ldloc.0
    IL_002e: brtrue IL_00e3
    IL_0033: ldarg.0
    IL_0034: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0039: ldarg.1
    IL_003a: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_003f: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0044: ldarg.0
    IL_0045: call bool TFUIEquippable::get_isWeapon()  /*0x060011F7*/
    IL_004a: brfalse.s IL_0069
    IL_004c: ldarg.0
    IL_004d: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0052: ldarg.0
    IL_0053: ldfld Color TFUIEquippable::weaponBgColor  /*0x040015A6*/
    IL_0058: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_005d: ldarg.0
    IL_005e: ldarg.0
    IL_005f: ldfld Color TFUIEquippable::weaponHighlightColor  /*0x040015AB*/
    IL_0064: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_0069: ldarg.0
    IL_006a: call bool TFUIEquippable::get_isPerk()  /*0x060011F8*/
    IL_006f: brfalse.s IL_008e
    IL_0071: ldarg.0
    IL_0072: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0077: ldarg.0
    IL_0078: ldfld Color TFUIEquippable::perkBgColor  /*0x040015A7*/
    IL_007d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0082: ldarg.0
    IL_0083: ldarg.0
    IL_0084: ldfld Color TFUIEquippable::perkHightlightColor  /*0x040015AC*/
    IL_0089: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_008e: ldarg.0
    IL_008f: call bool TFUIEquippable::get_isMutator()  /*0x060011F9*/
    IL_0094: brfalse.s IL_00b3
    IL_0096: ldarg.0
    IL_0097: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_009c: ldarg.0
    IL_009d: ldfld Color TFUIEquippable::mutatorBgColor  /*0x040015A8*/
    IL_00a2: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00a7: ldarg.0
    IL_00a8: ldarg.0
    IL_00a9: ldfld Color TFUIEquippable::mutatorHighlightColor  /*0x040015AD*/
    IL_00ae: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld Color TFUIEquippable::etDefaultMid  /*0x040015AE*/
    IL_00bf: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00c4: ldarg.0
    IL_00c5: ldarg.0
    IL_00c6: ldfld Color TFUIEquippable::etDefaultHigh  /*0x040015AF*/
    IL_00cb: stfld Color TFUIEquippable::highlightIconColor  /*0x040015B0*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld Color TFUIEquippable::etDefaultMid  /*0x040015AE*/
    IL_00dc: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_00e1: br.s IL_013f
    IL_00e3: ldarg.0
    IL_00e4: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_00e9: ldarg.1
    IL_00ea: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_00ef: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_00f4: ldarg.0
    IL_00f5: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_00fa: ldarg.0
    IL_00fb: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_0100: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0105: ldarg.0
    IL_0106: ldarg.0
    IL_0107: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_010c: stfld Color TFUIEquippable::highlightIconColor  /*0x040015B0*/
    IL_0111: ldarg.0
    IL_0112: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0117: ldarg.0
    IL_0118: ldfld Color TFUIEquippable::lockedOutlineColor  /*0x040015AA*/
    IL_011d: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_0122: ldarg.0
    IL_0123: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0128: ldarg.0
    IL_0129: ldfld Color TFUIEquippable::lockedBgColor  /*0x040015A9*/
    IL_012e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0133: ldarg.0
    IL_0134: ldarg.0
    IL_0135: ldfld Color TFUIEquippable::lockedBgColor  /*0x040015A9*/
    IL_013a: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_013f: ldarg.0
    IL_0140: ldarg.0
    IL_0141: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0146: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_014b: stfld Color TFUIEquippable::defaultBGColor  /*0x040015C1*/
    IL_0150: ldarg.0
    IL_0151: ldarg.0
    IL_0152: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0157: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_015c: stfld Color TFUIEquippable::defaultIconColor  /*0x040015C2*/
    IL_0161: ldarg.0
    IL_0162: call void TFUIEquippable::InitializeDefaultStyle()  /*0x06001208*/
    IL_0167: ret

  .method TFUIEquippable::SetDataSimple(Equippable)  // token 0x0600120B rva 0x56b3c attrs Public, HideBySig
    // code size 170 (0xaa), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Equippable TFUIEquippable::equippableData  /*0x040015BF*/
    IL_0007: ldarg.0
    IL_0008: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_000d: ldarg.1
    IL_000e: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0013: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0018: ldarg.0
    IL_0019: call bool TFUIEquippable::get_isWeapon()  /*0x060011F7*/
    IL_001e: brfalse.s IL_003d
    IL_0020: ldarg.0
    IL_0021: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0026: ldarg.0
    IL_0027: ldfld Color TFUIEquippable::weaponBgColor  /*0x040015A6*/
    IL_002c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0031: ldarg.0
    IL_0032: ldarg.0
    IL_0033: ldfld Color TFUIEquippable::weaponHighlightColor  /*0x040015AB*/
    IL_0038: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_003d: ldarg.0
    IL_003e: call bool TFUIEquippable::get_isPerk()  /*0x060011F8*/
    IL_0043: brfalse.s IL_0062
    IL_0045: ldarg.0
    IL_0046: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_004b: ldarg.0
    IL_004c: ldfld Color TFUIEquippable::perkBgColor  /*0x040015A7*/
    IL_0051: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0056: ldarg.0
    IL_0057: ldarg.0
    IL_0058: ldfld Color TFUIEquippable::perkHightlightColor  /*0x040015AC*/
    IL_005d: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_0062: ldarg.0
    IL_0063: call bool TFUIEquippable::get_isMutator()  /*0x060011F9*/
    IL_0068: brfalse.s IL_0087
    IL_006a: ldarg.0
    IL_006b: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0070: ldarg.0
    IL_0071: ldfld Color TFUIEquippable::mutatorBgColor  /*0x040015A8*/
    IL_0076: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_007b: ldarg.0
    IL_007c: ldarg.0
    IL_007d: ldfld Color TFUIEquippable::mutatorHighlightColor  /*0x040015AD*/
    IL_0082: stfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_0087: ldarg.0
    IL_0088: ldarg.0
    IL_0089: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_008e: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0093: stfld Color TFUIEquippable::defaultBGColor  /*0x040015C1*/
    IL_0098: ldarg.0
    IL_0099: ldarg.0
    IL_009a: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_009f: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_00a4: stfld Color TFUIEquippable::defaultIconColor  /*0x040015C2*/
    IL_00a9: ret

  .method TFUIEquippable::Pick()  // token 0x0600120C rva 0x56bf2 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEquippable::highlightBGColor  /*0x040015C0*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ldarg.0
    IL_0012: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0017: ldarg.0
    IL_0018: ldfld Color TFUIEquippable::highlightIconColor  /*0x040015B0*/
    IL_001d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0022: ldarg.0
    IL_0023: ldc.i4.1
    IL_0024: stfld bool TFUIEquippable::selectedForLoadout  /*0x040015BD*/
    IL_0029: ret

  .method TFUIEquippable::UnPick()  // token 0x0600120D rva 0x56c1d attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0006: ldarg.0
    IL_0007: ldfld Color TFUIEquippable::defaultBGColor  /*0x040015C1*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ldarg.0
    IL_0012: ldfld Image TFUIEquippable::iconImg  /*0x040015B2*/
    IL_0017: ldarg.0
    IL_0018: ldfld Color TFUIEquippable::defaultIconColor  /*0x040015C2*/
    IL_001d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0022: ldarg.0
    IL_0023: ldc.i4.0
    IL_0024: stfld bool TFUIEquippable::selectedForLoadout  /*0x040015BD*/
    IL_0029: ret

  .method TFUIEquippable::.ctor()  // token 0x0600120E rva 0x56c48 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUIEquippable::defaultAnimationCurve  /*0x040015B6*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUIEquippable::defaultAnimationTime  /*0x040015B7*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUIEquippable/Style  (token 0x0200034E) =====
  .method TFUIEquippable.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  // token 0x0600120F rva 0x56c7c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 89 (0x59), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUIEquippable.Style::scale  /*0x040015C4*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve TFUIEquippable.Style::animationCurve  /*0x040015C6*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.5f
    IL_0030: stfld float TFUIEquippable.Style::animationDuration  /*0x040015C7*/
    IL_0035: ldarg.0
    IL_0036: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003b: ldarg.0
    IL_003c: ldarg.s 4
    IL_003e: stfld float TFUIEquippable.Style::scale  /*0x040015C4*/
    IL_0043: ldarg.0
    IL_0044: ldarg.1
    IL_0045: stfld Color TFUIEquippable.Style::outlineColor  /*0x040015C5*/
    IL_004a: ldarg.0
    IL_004b: ldarg.2
    IL_004c: stfld AnimationCurve TFUIEquippable.Style::animationCurve  /*0x040015C6*/
    IL_0051: ldarg.0
    IL_0052: ldarg.3
    IL_0053: stfld float TFUIEquippable.Style::animationDuration  /*0x040015C7*/
    IL_0058: ret

// ===== TFUIEquippable/Animation  (token 0x0200034F) =====
  .method TFUIEquippable.Animation::.ctor(TFUIEquippable.Style,TFUIEquippable.Style,TFUIEquippable)  // token 0x06001210 rva 0x56ce1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUIEquippable.Style TFUIEquippable.Animation::startStyle  /*0x040015C9*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUIEquippable TFUIEquippable.Animation::target  /*0x040015C8*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUIEquippable::ApplyStyle(TFUIEquippable.Style)  /*0x06001207*/
    IL_0022: ldarg.3
    IL_0023: ldarg.0
    IL_0024: stfld TFUIEquippable.Animation TFUIEquippable::currentAnimation  /*0x040015BE*/
    IL_0029: ret

  .method TFUIEquippable.Animation::Tick()  // token 0x06001211 rva 0x56d0c attrs Public, HideBySig
    // code size 205 (0xcd), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUIEquippable.Animation::clock  /*0x040015CB*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUIEquippable.Animation::clock  /*0x040015CB*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_001d: ldfld float TFUIEquippable.Style::animationDuration  /*0x040015C7*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUIEquippable.Animation::clock  /*0x040015CB*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_0034: ldfld AnimationCurve TFUIEquippable.Style::animationCurve  /*0x040015C6*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUIEquippable TFUIEquippable.Animation::target  /*0x040015C8*/
    IL_0046: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUIEquippable.Style TFUIEquippable.Animation::startStyle  /*0x040015C9*/
    IL_0051: ldfld Color TFUIEquippable.Style::outlineColor  /*0x040015C5*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_005c: ldfld Color TFUIEquippable.Style::outlineColor  /*0x040015C5*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void MPUIKIT.MPImage::set_OutlineColor(UnityEngine.Color)  /*0x0A00067A*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUIEquippable TFUIEquippable.Animation::target  /*0x040015C8*/
    IL_0072: ldfld MPImage TFUIEquippable::backgroundImg  /*0x040015B1*/
    IL_0077: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0081: ldarg.0
    IL_0082: ldfld TFUIEquippable.Style TFUIEquippable.Animation::startStyle  /*0x040015C9*/
    IL_0087: ldfld float TFUIEquippable.Style::scale  /*0x040015C4*/
    IL_008c: ldarg.0
    IL_008d: ldfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_0092: ldfld float TFUIEquippable.Style::scale  /*0x040015C4*/
    IL_0097: ldloc.1
    IL_0098: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_009d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a7: ldloc.0
    IL_00a8: ldc.r4 1f
    IL_00ad: blt.un.s IL_00cc
    IL_00af: ldarg.0
    IL_00b0: ldfld TFUIEquippable TFUIEquippable.Animation::target  /*0x040015C8*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld TFUIEquippable.Style TFUIEquippable.Animation::endStyle  /*0x040015CA*/
    IL_00bb: callvirt void TFUIEquippable::ApplyStyle(TFUIEquippable.Style)  /*0x06001207*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld TFUIEquippable TFUIEquippable.Animation::target  /*0x040015C8*/
    IL_00c6: ldnull
    IL_00c7: stfld TFUIEquippable.Animation TFUIEquippable::currentAnimation  /*0x040015BE*/
    IL_00cc: ret

