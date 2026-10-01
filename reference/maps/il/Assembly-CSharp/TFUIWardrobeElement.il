// ===== TFUIWardrobeElement  (token 0x0200037B) =====
  .method TFUIWardrobeElement::get_Locked()  // token 0x0600132D rva 0x5b462 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIWardrobeElement::locked  /*0x0400173F*/
    IL_0006: ret

  .method TFUIWardrobeElement::get_IconImg()  // token 0x0600132E rva 0x5b46a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIWardrobeElement::iconImg  /*0x04001734*/
    IL_0006: ret

  .method TFUIWardrobeElement::GetDefaultOutlineColor()  // token 0x0600132F rva 0x5b472 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIWardrobeElement::InitializeDefaultStyle()  /*0x06001338*/
    IL_000e: ldarg.0
    IL_000f: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_001c: ldfld Color TFUIWardrobeElement.Style::outlineColor  /*0x04001743*/
    IL_0021: ret
    IL_0022: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0027: ret

  .method TFUIWardrobeElement::Update()  // token 0x06001330 rva 0x5b49b attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIWardrobeElement.Animation TFUIWardrobeElement::currentAnimation  /*0x0400173E*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIWardrobeElement.Animation TFUIWardrobeElement::currentAnimation  /*0x0400173E*/
    IL_000e: callvirt void TFUIWardrobeElement.Animation::Tick()  /*0x06001340*/
    IL_0013: ret

  .method TFUIWardrobeElement::OnApply()  // token 0x06001331 rva 0x5b4b0 attrs Family, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld WardrobeHandler TFUIWardrobeElement::handler  /*0x04001741*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld WardrobeHandler TFUIWardrobeElement::handler  /*0x04001741*/
    IL_0015: ldarg.0
    IL_0016: ldfld Material TFUIWardrobeElement::material  /*0x04001740*/
    IL_001b: ldarg.0
    IL_001c: callvirt void WardrobeHandler::ApplyMat(UnityEngine.Material,TFUIWardrobeElement)  /*0x0600134E*/
    IL_0021: ret

  .method TFUIWardrobeElement::OnClear()  // token 0x06001332 rva 0x5b4d3 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIWardrobeElement.Style TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001337*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIWardrobeElement.Animation::.ctor(TFUIWardrobeElement.Style,TFUIWardrobeElement.Style,TFUIWardrobeElement)  /*0x0600133F*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIWardrobeElement::OnFocus()  // token 0x06001333 rva 0x5b4ee attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIWardrobeElement.Style TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001337*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::focussedStyle  /*0x04001738*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIWardrobeElement.Animation::.ctor(TFUIWardrobeElement.Style,TFUIWardrobeElement.Style,TFUIWardrobeElement)  /*0x0600133F*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIWardrobeElement::OnSelect()  // token 0x06001334 rva 0x5b509 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIWardrobeElement.Style TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001337*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::selectedStyle  /*0x04001739*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIWardrobeElement.Animation::.ctor(TFUIWardrobeElement.Style,TFUIWardrobeElement.Style,TFUIWardrobeElement)  /*0x0600133F*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIWardrobeElement::OnFocusAndSelect()  // token 0x06001335 rva 0x5b524 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIWardrobeElement.Style TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001337*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::focussedAndSelectedStyle  /*0x0400173A*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIWardrobeElement.Animation::.ctor(TFUIWardrobeElement.Style,TFUIWardrobeElement.Style,TFUIWardrobeElement)  /*0x0600133F*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIWardrobeElement::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001336 rva 0x5b53f attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUIWardrobeElement.Animation TFUIWardrobeElement::currentAnimation  /*0x0400173E*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUIWardrobeElement.Style TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001337*/
    IL_000f: call void TFUIWardrobeElement::ApplyStyle(TFUIWardrobeElement.Style)  /*0x06001339*/
    IL_0014: ret

  .method TFUIWardrobeElement::GetStyle(ThronefallUIElement.SelectionState)  // token 0x06001337 rva 0x5b558 attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUIWardrobeElement.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIWardrobeElement::defaultStyleInitialized  /*0x0400173C*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIWardrobeElement::InitializeDefaultStyle()  /*0x06001338*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::focussedStyle  /*0x04001738*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::selectedStyle  /*0x04001739*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::focussedAndSelectedStyle  /*0x0400173A*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUIWardrobeElement::InitializeDefaultStyle()  // token 0x06001338 rva 0x5b5b7 attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_0007: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_000c: ldarg.0
    IL_000d: ldfld AnimationCurve TFUIWardrobeElement::defaultAnimationCurve  /*0x04001736*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TFUIWardrobeElement::defaultAnimationTime  /*0x04001737*/
    IL_0018: ldc.r4 1f
    IL_001d: newobj void TFUIWardrobeElement.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  /*0x0600133E*/
    IL_0022: stfld TFUIWardrobeElement.Style TFUIWardrobeElement::defaultStyle  /*0x0400173B*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld bool TFUIWardrobeElement::defaultStyleInitialized  /*0x0400173C*/
    IL_002e: ret

  .method TFUIWardrobeElement::ApplyStyle(TFUIWardrobeElement.Style)  // token 0x06001339 rva 0x5b5e7 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_0006: ldarg.1
    IL_0007: ldfld Color TFUIWardrobeElement.Style::outlineColor  /*0x04001743*/
    IL_000c: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0011: ldarg.0
    IL_0012: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_0017: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0021: ldarg.1
    IL_0022: ldfld float TFUIWardrobeElement.Style::scale  /*0x04001742*/
    IL_0027: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_002c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0031: ret

  .method TFUIWardrobeElement::SetupButton(UnityEngine.Material,WardrobeHandler)  // token 0x0600133A rva 0x5b61a attrs Public, HideBySig
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.2
    IL_0002: stfld WardrobeHandler TFUIWardrobeElement::handler  /*0x04001741*/
    IL_0007: ldarg.1
    IL_0008: ldnull
    IL_0009: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000e: brfalse.s IL_0034
    IL_0010: ldarg.0
    IL_0011: ldarg.1
    IL_0012: stfld Material TFUIWardrobeElement::material  /*0x04001740*/
    IL_0017: ldarg.0
    IL_0018: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_001d: ldarg.1
    IL_001e: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_0023: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0028: ldarg.0
    IL_0029: ldarg.1
    IL_002a: callvirt Color UnityEngine.Material::get_color()  /*0x0A0004C0*/
    IL_002f: stfld Color TFUIWardrobeElement::defaultBGColor  /*0x0400172E*/
    IL_0034: ret

  .method TFUIWardrobeElement::Pick()  // token 0x0600133B rva 0x5b650 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIWardrobeElement::iconImg  /*0x04001734*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.1
    IL_000e: stfld bool TFUIWardrobeElement::selected  /*0x0400173D*/
    IL_0013: ret

  .method TFUIWardrobeElement::UnPick()  // token 0x0600133C rva 0x5b665 attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIWardrobeElement::iconImg  /*0x04001734*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.0
    IL_000e: stfld bool TFUIWardrobeElement::selected  /*0x0400173D*/
    IL_0013: ret

  .method TFUIWardrobeElement::.ctor()  // token 0x0600133D rva 0x5b67a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUIWardrobeElement::defaultAnimationCurve  /*0x04001736*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUIWardrobeElement::defaultAnimationTime  /*0x04001737*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUIWardrobeElement/Style  (token 0x0200037C) =====
  .method TFUIWardrobeElement.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  // token 0x0600133E rva 0x5b6ac attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 89 (0x59), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUIWardrobeElement.Style::scale  /*0x04001742*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve TFUIWardrobeElement.Style::animationCurve  /*0x04001744*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.5f
    IL_0030: stfld float TFUIWardrobeElement.Style::animationDuration  /*0x04001745*/
    IL_0035: ldarg.0
    IL_0036: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003b: ldarg.0
    IL_003c: ldarg.s 4
    IL_003e: stfld float TFUIWardrobeElement.Style::scale  /*0x04001742*/
    IL_0043: ldarg.0
    IL_0044: ldarg.1
    IL_0045: stfld Color TFUIWardrobeElement.Style::outlineColor  /*0x04001743*/
    IL_004a: ldarg.0
    IL_004b: ldarg.2
    IL_004c: stfld AnimationCurve TFUIWardrobeElement.Style::animationCurve  /*0x04001744*/
    IL_0051: ldarg.0
    IL_0052: ldarg.3
    IL_0053: stfld float TFUIWardrobeElement.Style::animationDuration  /*0x04001745*/
    IL_0058: ret

// ===== TFUIWardrobeElement/Animation  (token 0x0200037D) =====
  .method TFUIWardrobeElement.Animation::.ctor(TFUIWardrobeElement.Style,TFUIWardrobeElement.Style,TFUIWardrobeElement)  // token 0x0600133F rva 0x5b711 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::startStyle  /*0x04001747*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUIWardrobeElement TFUIWardrobeElement.Animation::target  /*0x04001746*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUIWardrobeElement::ApplyStyle(TFUIWardrobeElement.Style)  /*0x06001339*/
    IL_0022: ldarg.3
    IL_0023: ldarg.0
    IL_0024: stfld TFUIWardrobeElement.Animation TFUIWardrobeElement::currentAnimation  /*0x0400173E*/
    IL_0029: ret

  .method TFUIWardrobeElement.Animation::Tick()  // token 0x06001340 rva 0x5b73c attrs Public, HideBySig
    // code size 205 (0xcd), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUIWardrobeElement.Animation::clock  /*0x04001749*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUIWardrobeElement.Animation::clock  /*0x04001749*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_001d: ldfld float TFUIWardrobeElement.Style::animationDuration  /*0x04001745*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUIWardrobeElement.Animation::clock  /*0x04001749*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_0034: ldfld AnimationCurve TFUIWardrobeElement.Style::animationCurve  /*0x04001744*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUIWardrobeElement TFUIWardrobeElement.Animation::target  /*0x04001746*/
    IL_0046: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::startStyle  /*0x04001747*/
    IL_0051: ldfld Color TFUIWardrobeElement.Style::outlineColor  /*0x04001743*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_005c: ldfld Color TFUIWardrobeElement.Style::outlineColor  /*0x04001743*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUIWardrobeElement TFUIWardrobeElement.Animation::target  /*0x04001746*/
    IL_0072: ldfld MPImageBasic TFUIWardrobeElement::backgroundImg  /*0x04001733*/
    IL_0077: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0081: ldarg.0
    IL_0082: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::startStyle  /*0x04001747*/
    IL_0087: ldfld float TFUIWardrobeElement.Style::scale  /*0x04001742*/
    IL_008c: ldarg.0
    IL_008d: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_0092: ldfld float TFUIWardrobeElement.Style::scale  /*0x04001742*/
    IL_0097: ldloc.1
    IL_0098: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_009d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a7: ldloc.0
    IL_00a8: ldc.r4 1f
    IL_00ad: blt.un.s IL_00cc
    IL_00af: ldarg.0
    IL_00b0: ldfld TFUIWardrobeElement TFUIWardrobeElement.Animation::target  /*0x04001746*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld TFUIWardrobeElement.Style TFUIWardrobeElement.Animation::endStyle  /*0x04001748*/
    IL_00bb: callvirt void TFUIWardrobeElement::ApplyStyle(TFUIWardrobeElement.Style)  /*0x06001339*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld TFUIWardrobeElement TFUIWardrobeElement.Animation::target  /*0x04001746*/
    IL_00c6: ldnull
    IL_00c7: stfld TFUIWardrobeElement.Animation TFUIWardrobeElement::currentAnimation  /*0x0400173E*/
    IL_00cc: ret

