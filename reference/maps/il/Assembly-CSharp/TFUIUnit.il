// ===== TFUIUnit  (token 0x0200035E) =====
  .method TFUIUnit::get_Locked()  // token 0x06001281 rva 0x5877e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUnit::locked  /*0x04001658*/
    IL_0006: ret

  .method TFUIUnit::get_IconImg()  // token 0x06001282 rva 0x58786 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIUnit::iconImg  /*0x0400164C*/
    IL_0006: ret

  .method TFUIUnit::get_GetBackgroundColor()  // token 0x06001283 rva 0x5878e attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUnit::selectedForLoadout  /*0x04001656*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld Color TFUIUnit::defaultBGColor  /*0x04001643*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld Color TFUIUnit::highlightBGColor  /*0x04001644*/
    IL_0015: ret

  .method TFUIUnit::get_GetIconColor()  // token 0x06001284 rva 0x587a5 attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUnit::selectedForLoadout  /*0x04001656*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld Color TFUIUnit::defaultIconColor  /*0x04001645*/
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld Color TFUIUnit::highlightIconColor  /*0x04001646*/
    IL_0015: ret

  .method TFUIUnit::GetDefaultOutlineColor()  // token 0x06001285 rva 0x587bc attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIUnit::InitializeDefaultStyle()  /*0x0600128F*/
    IL_000e: ldarg.0
    IL_000f: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_001c: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_0021: ret
    IL_0022: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0027: ret

  .method TFUIUnit::Update()  // token 0x06001286 rva 0x587e5 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIUnit.Animation TFUIUnit::currentAnimation  /*0x04001657*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIUnit.Animation TFUIUnit::currentAnimation  /*0x04001657*/
    IL_000e: callvirt void TFUIUnit.Animation::Tick()  /*0x06001293*/
    IL_0013: ret

  .method TFUIUnit::OnApply()  // token 0x06001287 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIUnit::OnClear()  // token 0x06001288 rva 0x587fa attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUnit.Style TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600128D*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUnit.Animation::.ctor(TFUIUnit.Style,TFUIUnit.Style,TFUIUnit)  /*0x06001292*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUnit::OnFocus()  // token 0x06001289 rva 0x58815 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUnit.Style TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600128D*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUnit.Style TFUIUnit::focussedStyle  /*0x04001651*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUnit.Animation::.ctor(TFUIUnit.Style,TFUIUnit.Style,TFUIUnit)  /*0x06001292*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUnit::OnSelect()  // token 0x0600128A rva 0x58830 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUnit.Style TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600128D*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUnit.Style TFUIUnit::selectedStyle  /*0x04001652*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUnit.Animation::.ctor(TFUIUnit.Style,TFUIUnit.Style,TFUIUnit)  /*0x06001292*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUnit::OnFocusAndSelect()  // token 0x0600128B rva 0x5884b attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIUnit.Style TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600128D*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIUnit.Style TFUIUnit::focussedAndSelectedStyle  /*0x04001653*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIUnit.Animation::.ctor(TFUIUnit.Style,TFUIUnit.Style,TFUIUnit)  /*0x06001292*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIUnit::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x0600128C rva 0x58866 attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUIUnit.Animation TFUIUnit::currentAnimation  /*0x04001657*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUIUnit.Style TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  /*0x0600128D*/
    IL_000f: call void TFUIUnit::ApplyStyle(TFUIUnit.Style)  /*0x0600128E*/
    IL_0014: ret

  .method TFUIUnit::GetStyle(ThronefallUIElement.SelectionState)  // token 0x0600128D rva 0x5887c attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUIUnit.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIUnit::defaultStyleInitialized  /*0x04001655*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIUnit::InitializeDefaultStyle()  /*0x0600128F*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUIUnit.Style TFUIUnit::focussedStyle  /*0x04001651*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUIUnit.Style TFUIUnit::selectedStyle  /*0x04001652*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUIUnit.Style TFUIUnit::focussedAndSelectedStyle  /*0x04001653*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUIUnit::ApplyStyle(TFUIUnit.Style)  // token 0x0600128E rva 0x588dc attrs Private, HideBySig
    // code size 84 (0x54), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0006: ldarg.1
    IL_0007: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_000c: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0011: ldarg.0
    IL_0012: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_0017: ldarg.1
    IL_0018: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_001d: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0022: ldarg.0
    IL_0023: ldfld MPImageBasic TFUIUnit::numberBg  /*0x0400164A*/
    IL_0028: ldarg.1
    IL_0029: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_002e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0033: ldarg.0
    IL_0034: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0039: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0043: ldarg.1
    IL_0044: ldfld float TFUIUnit.Style::scale  /*0x04001659*/
    IL_0049: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_004e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0053: ret

  .method TFUIUnit::InitializeDefaultStyle()  // token 0x0600128F rva 0x5893c attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0007: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_000c: ldarg.0
    IL_000d: ldfld AnimationCurve TFUIUnit::defaultAnimationCurve  /*0x0400164F*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TFUIUnit::defaultAnimationTime  /*0x04001650*/
    IL_0018: ldc.r4 1f
    IL_001d: newobj void TFUIUnit.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  /*0x06001291*/
    IL_0022: stfld TFUIUnit.Style TFUIUnit::defaultStyle  /*0x04001654*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld bool TFUIUnit::defaultStyleInitialized  /*0x04001655*/
    IL_002e: ret

  .method TFUIUnit::.ctor()  // token 0x06001290 rva 0x5896c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUIUnit::defaultAnimationCurve  /*0x0400164F*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUIUnit::defaultAnimationTime  /*0x04001650*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUIUnit/Style  (token 0x0200035F) =====
  .method TFUIUnit.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  // token 0x06001291 rva 0x589a0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 89 (0x59), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUIUnit.Style::scale  /*0x04001659*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve TFUIUnit.Style::animationCurve  /*0x0400165B*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.5f
    IL_0030: stfld float TFUIUnit.Style::animationDuration  /*0x0400165C*/
    IL_0035: ldarg.0
    IL_0036: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003b: ldarg.0
    IL_003c: ldarg.s 4
    IL_003e: stfld float TFUIUnit.Style::scale  /*0x04001659*/
    IL_0043: ldarg.0
    IL_0044: ldarg.1
    IL_0045: stfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_004a: ldarg.0
    IL_004b: ldarg.2
    IL_004c: stfld AnimationCurve TFUIUnit.Style::animationCurve  /*0x0400165B*/
    IL_0051: ldarg.0
    IL_0052: ldarg.3
    IL_0053: stfld float TFUIUnit.Style::animationDuration  /*0x0400165C*/
    IL_0058: ret

// ===== TFUIUnit/Animation  (token 0x02000360) =====
  .method TFUIUnit.Animation::.ctor(TFUIUnit.Style,TFUIUnit.Style,TFUIUnit)  // token 0x06001292 rva 0x58a05 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUIUnit.Style TFUIUnit.Animation::startStyle  /*0x0400165E*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUIUnit::ApplyStyle(TFUIUnit.Style)  /*0x0600128E*/
    IL_0022: ldarg.3
    IL_0023: ldarg.0
    IL_0024: stfld TFUIUnit.Animation TFUIUnit::currentAnimation  /*0x04001657*/
    IL_0029: ret

  .method TFUIUnit.Animation::Tick()  // token 0x06001293 rva 0x58a30 attrs Public, HideBySig
    // code size 269 (0x10d), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUIUnit.Animation::clock  /*0x04001660*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUIUnit.Animation::clock  /*0x04001660*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_001d: ldfld float TFUIUnit.Style::animationDuration  /*0x0400165C*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUIUnit.Animation::clock  /*0x04001660*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_0034: ldfld AnimationCurve TFUIUnit.Style::animationCurve  /*0x0400165B*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_0046: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUIUnit.Style TFUIUnit.Animation::startStyle  /*0x0400165E*/
    IL_0051: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_005c: ldfld Color TFUIUnit.Style::outlineColor  /*0x0400165A*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_0072: ldfld MPImageBasic TFUIUnit::backgroundEliteImg  /*0x04001649*/
    IL_0077: ldarg.0
    IL_0078: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_007d: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_0082: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_0087: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_008c: ldarg.0
    IL_008d: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_0092: ldfld MPImageBasic TFUIUnit::numberBg  /*0x0400164A*/
    IL_0097: ldarg.0
    IL_0098: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_009d: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00a2: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_00a7: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_00ac: ldarg.0
    IL_00ad: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_00b2: ldfld MPImageBasic TFUIUnit::backgroundImg  /*0x04001648*/
    IL_00b7: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00bc: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld TFUIUnit.Style TFUIUnit.Animation::startStyle  /*0x0400165E*/
    IL_00c7: ldfld float TFUIUnit.Style::scale  /*0x04001659*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_00d2: ldfld float TFUIUnit.Style::scale  /*0x04001659*/
    IL_00d7: ldloc.1
    IL_00d8: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_00dd: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00e2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00e7: ldloc.0
    IL_00e8: ldc.r4 1f
    IL_00ed: blt.un.s IL_010c
    IL_00ef: ldarg.0
    IL_00f0: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_00f5: ldarg.0
    IL_00f6: ldfld TFUIUnit.Style TFUIUnit.Animation::endStyle  /*0x0400165F*/
    IL_00fb: callvirt void TFUIUnit::ApplyStyle(TFUIUnit.Style)  /*0x0600128E*/
    IL_0100: ldarg.0
    IL_0101: ldfld TFUIUnit TFUIUnit.Animation::target  /*0x0400165D*/
    IL_0106: ldnull
    IL_0107: stfld TFUIUnit.Animation TFUIUnit::currentAnimation  /*0x04001657*/
    IL_010c: ret

