// ===== TFUIUpgradeChoice  (token 0x02000361) =====
  .method TFUIUpgradeChoice::get_Data()  // token 0x06001294 rva 0x58b49 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Choice TFUIUpgradeChoice::choiceData  /*0x0400166E*/
    IL_0006: ret

  .method TFUIUpgradeChoice::get_Locked()  // token 0x06001295 rva 0x58b51 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUpgradeChoice::locked  /*0x04001671*/
    IL_0006: ret

  .method TFUIUpgradeChoice::get_IconImg()  // token 0x06001296 rva 0x58b59 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0006: ret

  .method TFUIUpgradeChoice::Update()  // token 0x06001297 rva 0x58b61 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIUpgradeChoice.Animation TFUIUpgradeChoice::currentAnimation  /*0x0400166D*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIUpgradeChoice.Animation TFUIUpgradeChoice::currentAnimation  /*0x0400166D*/
    IL_000e: callvirt void TFUIUpgradeChoice.Animation::Tick()  /*0x060012A5*/
    IL_0013: ret

  .method TFUIUpgradeChoice::OnApply()  // token 0x06001298 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIUpgradeChoice::OnClear()  // token 0x06001299 rva 0x58b76 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUpgradeChoice.Style TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600129E*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::defaultStyle  /*0x0400166B*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUpgradeChoice.Animation::.ctor(TFUIUpgradeChoice.Style,TFUIUpgradeChoice.Style,TFUIUpgradeChoice)  /*0x060012A4*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUpgradeChoice::OnFocus()  // token 0x0600129A rva 0x58b91 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUpgradeChoice.Style TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600129E*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::focussedStyle  /*0x04001668*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUpgradeChoice.Animation::.ctor(TFUIUpgradeChoice.Style,TFUIUpgradeChoice.Style,TFUIUpgradeChoice)  /*0x060012A4*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUpgradeChoice::OnSelect()  // token 0x0600129B rva 0x58bac attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUpgradeChoice.Style TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600129E*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::selectedStyle  /*0x04001669*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUpgradeChoice.Animation::.ctor(TFUIUpgradeChoice.Style,TFUIUpgradeChoice.Style,TFUIUpgradeChoice)  /*0x060012A4*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUpgradeChoice::OnFocusAndSelect()  // token 0x0600129C rva 0x58bc7 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUpgradeChoice.Style TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600129E*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::focussedAndSelectedStyle  /*0x0400166A*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUpgradeChoice.Animation::.ctor(TFUIUpgradeChoice.Style,TFUIUpgradeChoice.Style,TFUIUpgradeChoice)  /*0x060012A4*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUpgradeChoice::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x0600129D rva 0x58be2 attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUIUpgradeChoice.Animation TFUIUpgradeChoice::currentAnimation  /*0x0400166D*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUIUpgradeChoice.Style TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600129E*/
    IL_000f: call void TFUIUpgradeChoice::ApplyStyle(TFUIUpgradeChoice.Style)  /*0x0600129F*/
    IL_0014: ret

  .method TFUIUpgradeChoice::GetStyle(ThronefallUIElement.SelectionState)  // token 0x0600129E rva 0x58bf8 attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUIUpgradeChoice.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUpgradeChoice::defaultStyleInitialized  /*0x0400166C*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIUpgradeChoice::InitializeDefaultStyle()  /*0x060012A0*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::defaultStyle  /*0x0400166B*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::focussedStyle  /*0x04001668*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::selectedStyle  /*0x04001669*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::focussedAndSelectedStyle  /*0x0400166A*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::defaultStyle  /*0x0400166B*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUIUpgradeChoice::ApplyStyle(TFUIUpgradeChoice.Style)  // token 0x0600129F rva 0x58c58 attrs Private, HideBySig
    // code size 84 (0x54), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0006: ldarg.1
    IL_0007: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ldarg.0
    IL_0012: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0017: ldarg.1
    IL_0018: ldfld Color TFUIUpgradeChoice.Style::bgColor  /*0x04001674*/
    IL_001d: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0022: ldarg.0
    IL_0023: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0028: ldarg.1
    IL_0029: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_002e: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0033: ldarg.0
    IL_0034: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0039: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0043: ldarg.1
    IL_0044: ldfld float TFUIUpgradeChoice.Style::scale  /*0x04001672*/
    IL_0049: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_004e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0053: ret

  .method TFUIUpgradeChoice::InitializeDefaultStyle()  // token 0x060012A0 rva 0x58cb8 attrs Private, HideBySig
    // code size 92 (0x5c), max stack 6, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0007: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_000c: stfld Color TFUIUpgradeChoice::defaultBgColor  /*0x0400166F*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0018: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_001d: stfld Color TFUIUpgradeChoice::defaultIconColor  /*0x04001670*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0029: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_002e: ldarg.0
    IL_002f: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0034: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0039: ldarg.0
    IL_003a: ldfld AnimationCurve TFUIUpgradeChoice::defaultAnimationCurve  /*0x04001666*/
    IL_003f: ldarg.0
    IL_0040: ldfld float TFUIUpgradeChoice::defaultAnimationTime  /*0x04001667*/
    IL_0045: ldc.r4 1f
    IL_004a: newobj void TFUIUpgradeChoice.Style::.ctor(UnityEngine.Color,UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  /*0x060012A3*/
    IL_004f: stfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::defaultStyle  /*0x0400166B*/
    IL_0054: ldarg.0
    IL_0055: ldc.i4.1
    IL_0056: stfld bool TFUIUpgradeChoice::defaultStyleInitialized  /*0x0400166C*/
    IL_005b: ret

  .method TFUIUpgradeChoice::SetData(Choice)  // token 0x060012A1 rva 0x58d20 attrs Public, HideBySig
    // code size 232 (0xe8), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Choice TFUIUpgradeChoice::choiceData  /*0x0400166E*/
    IL_0007: ldc.i4.1
    IL_0008: stloc.0
    IL_0009: ldarg.1
    IL_000a: callvirt bool Choice::get_CanBePicked()  /*0x0600092A*/
    IL_000f: brtrue.s IL_0013
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: ldarg.1
    IL_0014: ldfld bool Choice::disabledInThisMode  /*0x04000B91*/
    IL_0019: brfalse.s IL_001d
    IL_001b: ldc.i4.0
    IL_001c: stloc.0
    IL_001d: ldloc.0
    IL_001e: brfalse.s IL_007a
    IL_0020: ldarg.0
    IL_0021: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0026: ldarg.1
    IL_0027: ldfld Sprite Choice::icon  /*0x04000B94*/
    IL_002c: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0031: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0036: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_003b: brfalse IL_00e7
    IL_0040: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0045: callvirt bool SettingsManager::get_ArachnophobiaMode()  /*0x06000DAA*/
    IL_004a: brfalse IL_00e7
    IL_004f: ldarg.1
    IL_0050: ldfld bool Choice::hasArachnophobiaMode  /*0x04000B97*/
    IL_0055: brfalse IL_00e7
    IL_005a: ldarg.1
    IL_005b: ldfld Sprite Choice::altIcon  /*0x04000B95*/
    IL_0060: ldnull
    IL_0061: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0066: brfalse.s IL_00e7
    IL_0068: ldarg.0
    IL_0069: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_006e: ldarg.1
    IL_006f: ldfld Sprite Choice::altIcon  /*0x04000B95*/
    IL_0074: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0080: ldarg.0
    IL_0081: ldfld Sprite TFUIUpgradeChoice::lockIcon  /*0x04001665*/
    IL_0086: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_008b: ldarg.0
    IL_008c: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_0091: ldarg.0
    IL_0092: ldfld Color TFUIUpgradeChoice::lockedOutlineColor  /*0x04001662*/
    IL_0097: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_009c: ldarg.0
    IL_009d: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld Color TFUIUpgradeChoice::lockedBgColor  /*0x04001661*/
    IL_00a8: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld Color TFUIUpgradeChoice::lockedOutlineColor  /*0x04001662*/
    IL_00b9: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_00be: ldarg.0
    IL_00bf: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::selectedStyle  /*0x04001669*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld Color TFUIUpgradeChoice::lockedBgColor  /*0x04001661*/
    IL_00ca: stfld Color TFUIUpgradeChoice.Style::bgColor  /*0x04001674*/
    IL_00cf: ldarg.0
    IL_00d0: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice::selectedStyle  /*0x04001669*/
    IL_00d5: ldarg.0
    IL_00d6: ldfld Color TFUIUpgradeChoice::lockedOutlineColor  /*0x04001662*/
    IL_00db: stfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_00e0: ldarg.0
    IL_00e1: ldc.i4.1
    IL_00e2: stfld bool TFUIUpgradeChoice::locked  /*0x04001671*/
    IL_00e7: ret

  .method TFUIUpgradeChoice::.ctor()  // token 0x060012A2 rva 0x58e14 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUIUpgradeChoice::defaultAnimationCurve  /*0x04001666*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUIUpgradeChoice::defaultAnimationTime  /*0x04001667*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUIUpgradeChoice/Style  (token 0x02000362) =====
  .method TFUIUpgradeChoice.Style::.ctor(UnityEngine.Color,UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  // token 0x060012A3 rva 0x58e48 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 97 (0x61), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUIUpgradeChoice.Style::scale  /*0x04001672*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve TFUIUpgradeChoice.Style::animationCurve  /*0x04001675*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.5f
    IL_0030: stfld float TFUIUpgradeChoice.Style::animationDuration  /*0x04001676*/
    IL_0035: ldarg.0
    IL_0036: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003b: ldarg.0
    IL_003c: ldarg.s 5
    IL_003e: stfld float TFUIUpgradeChoice.Style::scale  /*0x04001672*/
    IL_0043: ldarg.0
    IL_0044: ldarg.2
    IL_0045: stfld Color TFUIUpgradeChoice.Style::bgColor  /*0x04001674*/
    IL_004a: ldarg.0
    IL_004b: ldarg.1
    IL_004c: stfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_0051: ldarg.0
    IL_0052: ldarg.3
    IL_0053: stfld AnimationCurve TFUIUpgradeChoice.Style::animationCurve  /*0x04001675*/
    IL_0058: ldarg.0
    IL_0059: ldarg.s 4
    IL_005b: stfld float TFUIUpgradeChoice.Style::animationDuration  /*0x04001676*/
    IL_0060: ret

// ===== TFUIUpgradeChoice/Animation  (token 0x02000363) =====
  .method TFUIUpgradeChoice.Animation::.ctor(TFUIUpgradeChoice.Style,TFUIUpgradeChoice.Style,TFUIUpgradeChoice)  // token 0x060012A4 rva 0x58eb5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::startStyle  /*0x04001678*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUIUpgradeChoice::ApplyStyle(TFUIUpgradeChoice.Style)  /*0x0600129F*/
    IL_0022: ldarg.3
    IL_0023: ldarg.0
    IL_0024: stfld TFUIUpgradeChoice.Animation TFUIUpgradeChoice::currentAnimation  /*0x0400166D*/
    IL_0029: ret

  .method TFUIUpgradeChoice.Animation::Tick()  // token 0x060012A5 rva 0x58ee0 attrs Public, HideBySig
    // code size 293 (0x125), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUIUpgradeChoice.Animation::clock  /*0x0400167A*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUIUpgradeChoice.Animation::clock  /*0x0400167A*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_001d: ldfld float TFUIUpgradeChoice.Style::animationDuration  /*0x04001676*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUIUpgradeChoice.Animation::clock  /*0x0400167A*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_0034: ldfld AnimationCurve TFUIUpgradeChoice.Style::animationCurve  /*0x04001675*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_0046: ldfld Image TFUIUpgradeChoice::iconImg  /*0x04001664*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::startStyle  /*0x04001678*/
    IL_0051: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_005c: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_0072: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_0077: ldarg.0
    IL_0078: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::startStyle  /*0x04001678*/
    IL_007d: ldfld Color TFUIUpgradeChoice.Style::bgColor  /*0x04001674*/
    IL_0082: ldarg.0
    IL_0083: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_0088: ldfld Color TFUIUpgradeChoice.Style::bgColor  /*0x04001674*/
    IL_008d: ldloc.1
    IL_008e: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0093: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0098: ldarg.0
    IL_0099: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_009e: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::startStyle  /*0x04001678*/
    IL_00a9: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_00ae: ldarg.0
    IL_00af: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_00b4: ldfld Color TFUIUpgradeChoice.Style::outlineColor  /*0x04001673*/
    IL_00b9: ldloc.1
    IL_00ba: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_00bf: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_00ca: ldfld MPImageBasic TFUIUpgradeChoice::backgroundImg  /*0x04001663*/
    IL_00cf: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d4: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00d9: ldarg.0
    IL_00da: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::startStyle  /*0x04001678*/
    IL_00df: ldfld float TFUIUpgradeChoice.Style::scale  /*0x04001672*/
    IL_00e4: ldarg.0
    IL_00e5: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_00ea: ldfld float TFUIUpgradeChoice.Style::scale  /*0x04001672*/
    IL_00ef: ldloc.1
    IL_00f0: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_00f5: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00fa: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00ff: ldloc.0
    IL_0100: ldc.r4 1f
    IL_0105: blt.un.s IL_0124
    IL_0107: ldarg.0
    IL_0108: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_010d: ldarg.0
    IL_010e: ldfld TFUIUpgradeChoice.Style TFUIUpgradeChoice.Animation::endStyle  /*0x04001679*/
    IL_0113: callvirt void TFUIUpgradeChoice::ApplyStyle(TFUIUpgradeChoice.Style)  /*0x0600129F*/
    IL_0118: ldarg.0
    IL_0119: ldfld TFUIUpgradeChoice TFUIUpgradeChoice.Animation::target  /*0x04001677*/
    IL_011e: ldnull
    IL_011f: stfld TFUIUpgradeChoice.Animation TFUIUpgradeChoice::currentAnimation  /*0x0400166D*/
    IL_0124: ret

