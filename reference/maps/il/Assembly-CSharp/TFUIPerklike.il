// ===== TFUIPerklike  (token 0x02000352) =====
  .method TFUIPerklike::get_IconImg()  // token 0x0600121E rva 0x5720c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image TFUIPerklike::iconImg  /*0x040015D5*/
    IL_0006: ret

  .method TFUIPerklike::GetDefaultOutlineColor()  // token 0x0600121F rva 0x57214 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIPerklike::InitializeDefaultStyle()  /*0x06001229*/
    IL_000e: ldarg.0
    IL_000f: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_001c: ldfld Color TFUIPerklike.Style::outlineColor  /*0x040015DF*/
    IL_0021: ret
    IL_0022: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0027: ret

  .method TFUIPerklike::Update()  // token 0x06001220 rva 0x5723d attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIPerklike.Animation TFUIPerklike::currentAnimation  /*0x040015DD*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUIPerklike.Animation TFUIPerklike::currentAnimation  /*0x040015DD*/
    IL_000e: callvirt void TFUIPerklike.Animation::Tick()  /*0x0600122D*/
    IL_0013: ret

  .method TFUIPerklike::OnApply()  // token 0x06001221 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUIPerklike::OnClear()  // token 0x06001222 rva 0x57252 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIPerklike.Style TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001227*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIPerklike.Animation::.ctor(TFUIPerklike.Style,TFUIPerklike.Style,TFUIPerklike)  /*0x0600122C*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIPerklike::OnFocus()  // token 0x06001223 rva 0x5726d attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIPerklike.Style TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001227*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIPerklike.Style TFUIPerklike::focussedStyle  /*0x040015D8*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIPerklike.Animation::.ctor(TFUIPerklike.Style,TFUIPerklike.Style,TFUIPerklike)  /*0x0600122C*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIPerklike::OnSelect()  // token 0x06001224 rva 0x57288 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIPerklike.Style TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001227*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIPerklike.Style TFUIPerklike::selectedStyle  /*0x040015D9*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIPerklike.Animation::.ctor(TFUIPerklike.Style,TFUIPerklike.Style,TFUIPerklike)  /*0x0600122C*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIPerklike::OnFocusAndSelect()  // token 0x06001225 rva 0x572a3 attrs Family, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUIPerklike.Style TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001227*/
    IL_000c: ldarg.0
    IL_000d: ldfld TFUIPerklike.Style TFUIPerklike::focussedAndSelectedStyle  /*0x040015DA*/
    IL_0012: ldarg.0
    IL_0013: newobj void TFUIPerklike.Animation::.ctor(TFUIPerklike.Style,TFUIPerklike.Style,TFUIPerklike)  /*0x0600122C*/
    IL_0018: pop
    IL_0019: ret

  .method TFUIPerklike::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001226 rva 0x572be attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUIPerklike.Animation TFUIPerklike::currentAnimation  /*0x040015DD*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUIPerklike.Style TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001227*/
    IL_000f: call void TFUIPerklike::ApplyStyle(TFUIPerklike.Style)  /*0x06001228*/
    IL_0014: ret

  .method TFUIPerklike::GetStyle(ThronefallUIElement.SelectionState)  // token 0x06001227 rva 0x572d4 attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUIPerklike.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUIPerklike::defaultStyleInitialized  /*0x040015DC*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUIPerklike::InitializeDefaultStyle()  /*0x06001229*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUIPerklike.Style TFUIPerklike::focussedStyle  /*0x040015D8*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUIPerklike.Style TFUIPerklike::selectedStyle  /*0x040015D9*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUIPerklike.Style TFUIPerklike::focussedAndSelectedStyle  /*0x040015DA*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUIPerklike::ApplyStyle(TFUIPerklike.Style)  // token 0x06001228 rva 0x57333 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_0006: ldarg.1
    IL_0007: ldfld Color TFUIPerklike.Style::outlineColor  /*0x040015DF*/
    IL_000c: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_0011: ldarg.0
    IL_0012: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_0017: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0021: ldarg.1
    IL_0022: ldfld float TFUIPerklike.Style::scale  /*0x040015DE*/
    IL_0027: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_002c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0031: ret

  .method TFUIPerklike::InitializeDefaultStyle()  // token 0x06001229 rva 0x57366 attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_0007: callvirt Color MPUIKIT.MPImageBasic::get_OutlineColor()  /*0x0A0006FD*/
    IL_000c: ldarg.0
    IL_000d: ldfld AnimationCurve TFUIPerklike::defaultAnimationCurve  /*0x040015D6*/
    IL_0012: ldarg.0
    IL_0013: ldfld float TFUIPerklike::defaultAnimationTime  /*0x040015D7*/
    IL_0018: ldc.r4 1f
    IL_001d: newobj void TFUIPerklike.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  /*0x0600122B*/
    IL_0022: stfld TFUIPerklike.Style TFUIPerklike::defaultStyle  /*0x040015DB*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld bool TFUIPerklike::defaultStyleInitialized  /*0x040015DC*/
    IL_002e: ret

  .method TFUIPerklike::.ctor()  // token 0x0600122A rva 0x57396 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUIPerklike::defaultAnimationCurve  /*0x040015D6*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUIPerklike::defaultAnimationTime  /*0x040015D7*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUIPerklike/Style  (token 0x02000353) =====
  .method TFUIPerklike.Style::.ctor(UnityEngine.Color,UnityEngine.AnimationCurve,float,float)  // token 0x0600122B rva 0x573c8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 89 (0x59), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TFUIPerklike.Style::scale  /*0x040015DE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0f
    IL_0011: ldc.r4 0f
    IL_0016: ldc.r4 1f
    IL_001b: ldc.r4 1f
    IL_0020: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0025: stfld AnimationCurve TFUIPerklike.Style::animationCurve  /*0x040015E0*/
    IL_002a: ldarg.0
    IL_002b: ldc.r4 0.5f
    IL_0030: stfld float TFUIPerklike.Style::animationDuration  /*0x040015E1*/
    IL_0035: ldarg.0
    IL_0036: call void System.Object::.ctor()  /*0x0A000038*/
    IL_003b: ldarg.0
    IL_003c: ldarg.s 4
    IL_003e: stfld float TFUIPerklike.Style::scale  /*0x040015DE*/
    IL_0043: ldarg.0
    IL_0044: ldarg.1
    IL_0045: stfld Color TFUIPerklike.Style::outlineColor  /*0x040015DF*/
    IL_004a: ldarg.0
    IL_004b: ldarg.2
    IL_004c: stfld AnimationCurve TFUIPerklike.Style::animationCurve  /*0x040015E0*/
    IL_0051: ldarg.0
    IL_0052: ldarg.3
    IL_0053: stfld float TFUIPerklike.Style::animationDuration  /*0x040015E1*/
    IL_0058: ret

// ===== TFUIPerklike/Animation  (token 0x02000354) =====
  .method TFUIPerklike.Animation::.ctor(TFUIPerklike.Style,TFUIPerklike.Style,TFUIPerklike)  // token 0x0600122C rva 0x5742d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUIPerklike.Style TFUIPerklike.Animation::startStyle  /*0x040015E3*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUIPerklike TFUIPerklike.Animation::target  /*0x040015E2*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUIPerklike::ApplyStyle(TFUIPerklike.Style)  /*0x06001228*/
    IL_0022: ldarg.3
    IL_0023: ldarg.0
    IL_0024: stfld TFUIPerklike.Animation TFUIPerklike::currentAnimation  /*0x040015DD*/
    IL_0029: ret

  .method TFUIPerklike.Animation::Tick()  // token 0x0600122D rva 0x57458 attrs Public, HideBySig
    // code size 205 (0xcd), max stack 5, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUIPerklike.Animation::clock  /*0x040015E5*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUIPerklike.Animation::clock  /*0x040015E5*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_001d: ldfld float TFUIPerklike.Style::animationDuration  /*0x040015E1*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUIPerklike.Animation::clock  /*0x040015E5*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_0034: ldfld AnimationCurve TFUIPerklike.Style::animationCurve  /*0x040015E0*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUIPerklike TFUIPerklike.Animation::target  /*0x040015E2*/
    IL_0046: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUIPerklike.Style TFUIPerklike.Animation::startStyle  /*0x040015E3*/
    IL_0051: ldfld Color TFUIPerklike.Style::outlineColor  /*0x040015DF*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_005c: ldfld Color TFUIPerklike.Style::outlineColor  /*0x040015DF*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void MPUIKIT.MPImageBasic::set_OutlineColor(UnityEngine.Color)  /*0x0A0006FC*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUIPerklike TFUIPerklike.Animation::target  /*0x040015E2*/
    IL_0072: ldfld MPImageBasic TFUIPerklike::backgroundImg  /*0x040015D4*/
    IL_0077: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007c: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0081: ldarg.0
    IL_0082: ldfld TFUIPerklike.Style TFUIPerklike.Animation::startStyle  /*0x040015E3*/
    IL_0087: ldfld float TFUIPerklike.Style::scale  /*0x040015DE*/
    IL_008c: ldarg.0
    IL_008d: ldfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_0092: ldfld float TFUIPerklike.Style::scale  /*0x040015DE*/
    IL_0097: ldloc.1
    IL_0098: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_009d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a7: ldloc.0
    IL_00a8: ldc.r4 1f
    IL_00ad: blt.un.s IL_00cc
    IL_00af: ldarg.0
    IL_00b0: ldfld TFUIPerklike TFUIPerklike.Animation::target  /*0x040015E2*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld TFUIPerklike.Style TFUIPerklike.Animation::endStyle  /*0x040015E4*/
    IL_00bb: callvirt void TFUIPerklike::ApplyStyle(TFUIPerklike.Style)  /*0x06001228*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld TFUIPerklike TFUIPerklike.Animation::target  /*0x040015E2*/
    IL_00c6: ldnull
    IL_00c7: stfld TFUIPerklike.Animation TFUIPerklike::currentAnimation  /*0x040015DD*/
    IL_00cc: ret

