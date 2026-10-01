// ===== TFUITextButton  (token 0x0200035B) =====
  .method TFUITextButton::Start()  // token 0x06001270 rva 0x582bc attrs Private, HideBySig
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<I2.Loc.Localize>  /*0x2B000106*/
    IL_0007: stfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_000c: ldarg.0
    IL_000d: ldfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_0036
    IL_001a: ldarg.0
    IL_001b: ldfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_0020: ldfld UnityEvent I2.Loc.Localize::LocalizeEvent  /*0x04001A98*/
    IL_0025: ldarg.0
    IL_0026: ldftn void TFUITextButton::UpdateOriginalStringLocalized()  /*0x0600127B*/
    IL_002c: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0031: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0036: ret

  .method TFUITextButton::Update()  // token 0x06001271 rva 0x582f4 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUITextButton.Animation TFUITextButton::currentAnimation  /*0x04001636*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld TFUITextButton.Animation TFUITextButton::currentAnimation  /*0x04001636*/
    IL_000e: callvirt void TFUITextButton.Animation::Tick()  /*0x06001280*/
    IL_0013: ret

  .method TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  // token 0x06001272 rva 0x5830c attrs Family, HideBySig
    // code size 83 (0x53), max stack 1, init locals
    .locals ([0] TFUITextButton.Style)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUITextButton::defaultStyleInitialized  /*0x0400162B*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUITextButton::InitializeDefaultStyle()  /*0x0600127A*/
    IL_000e: ldarg.1
    IL_000f: switch (IL_0026, IL_002f, IL_0038, IL_0041)
    IL_0024: br.s IL_004a
    IL_0026: ldarg.0
    IL_0027: ldfld TFUITextButton.Style TFUITextButton::defaultStyle  /*0x0400162A*/
    IL_002c: stloc.0
    IL_002d: br.s IL_0051
    IL_002f: ldarg.0
    IL_0030: ldfld TFUITextButton.Style TFUITextButton::focussedStyle  /*0x0400162E*/
    IL_0035: stloc.0
    IL_0036: br.s IL_0051
    IL_0038: ldarg.0
    IL_0039: ldfld TFUITextButton.Style TFUITextButton::selectedStyle  /*0x0400162F*/
    IL_003e: stloc.0
    IL_003f: br.s IL_0051
    IL_0041: ldarg.0
    IL_0042: ldfld TFUITextButton.Style TFUITextButton::focussedAndSelectedStyle  /*0x04001630*/
    IL_0047: stloc.0
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldfld TFUITextButton.Style TFUITextButton::defaultStyle  /*0x0400162A*/
    IL_0050: stloc.0
    IL_0051: ldloc.0
    IL_0052: ret

  .method TFUITextButton::OnApply()  // token 0x06001273 rva 0x25f1 attrs Family, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TFUITextButton::OnClear()  // token 0x06001274 rva 0x5836b attrs Family, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUITextButton.Style TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001272*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0012: brtrue.s IL_001c
    IL_0014: ldarg.0
    IL_0015: ldfld TFUITextButton.Style TFUITextButton::defaultStyle  /*0x0400162A*/
    IL_001a: br.s IL_0022
    IL_001c: ldarg.0
    IL_001d: ldfld TFUITextButton.Style TFUITextButton::overrideStyle  /*0x04001631*/
    IL_0022: ldarg.0
    IL_0023: newobj void TFUITextButton.Animation::.ctor(TFUITextButton.Style,TFUITextButton.Style,TFUITextButton)  /*0x0600127F*/
    IL_0028: pop
    IL_0029: ret

  .method TFUITextButton::OnFocus()  // token 0x06001275 rva 0x58396 attrs Family, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUITextButton.Style TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001272*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0012: brtrue.s IL_001c
    IL_0014: ldarg.0
    IL_0015: ldfld TFUITextButton.Style TFUITextButton::focussedStyle  /*0x0400162E*/
    IL_001a: br.s IL_0022
    IL_001c: ldarg.0
    IL_001d: ldfld TFUITextButton.Style TFUITextButton::overrideStyle  /*0x04001631*/
    IL_0022: ldarg.0
    IL_0023: newobj void TFUITextButton.Animation::.ctor(TFUITextButton.Style,TFUITextButton.Style,TFUITextButton)  /*0x0600127F*/
    IL_0028: pop
    IL_0029: ret

  .method TFUITextButton::OnSelect()  // token 0x06001276 rva 0x583c1 attrs Family, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUITextButton.Style TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001272*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0012: brtrue.s IL_001c
    IL_0014: ldarg.0
    IL_0015: ldfld TFUITextButton.Style TFUITextButton::selectedStyle  /*0x0400162F*/
    IL_001a: br.s IL_0022
    IL_001c: ldarg.0
    IL_001d: ldfld TFUITextButton.Style TFUITextButton::overrideStyle  /*0x04001631*/
    IL_0022: ldarg.0
    IL_0023: newobj void TFUITextButton.Animation::.ctor(TFUITextButton.Style,TFUITextButton.Style,TFUITextButton)  /*0x0600127F*/
    IL_0028: pop
    IL_0029: ret

  .method TFUITextButton::OnFocusAndSelect()  // token 0x06001277 rva 0x583ec attrs Family, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::previousState  /*0x0400167C*/
    IL_0007: call TFUITextButton.Style TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001272*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0012: brtrue.s IL_001c
    IL_0014: ldarg.0
    IL_0015: ldfld TFUITextButton.Style TFUITextButton::focussedAndSelectedStyle  /*0x04001630*/
    IL_001a: br.s IL_0022
    IL_001c: ldarg.0
    IL_001d: ldfld TFUITextButton.Style TFUITextButton::overrideStyle  /*0x04001631*/
    IL_0022: ldarg.0
    IL_0023: newobj void TFUITextButton.Animation::.ctor(TFUITextButton.Style,TFUITextButton.Style,TFUITextButton)  /*0x0600127F*/
    IL_0028: pop
    IL_0029: ret

  .method TFUITextButton::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x06001278 rva 0x58417 attrs Family, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldnull
    IL_0002: stfld TFUITextButton.Animation TFUITextButton::currentAnimation  /*0x04001636*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldarg.1
    IL_000a: call TFUITextButton.Style TFUITextButton::GetStyle(ThronefallUIElement.SelectionState)  /*0x06001272*/
    IL_000f: call void TFUITextButton::ApplyStyle(TFUITextButton.Style)  /*0x06001279*/
    IL_0014: ret

  .method TFUITextButton::ApplyStyle(TFUITextButton.Style)  // token 0x06001279 rva 0x58430 attrs Private, HideBySig
    // code size 94 (0x5e), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0006: ldarg.1
    IL_0007: ldfld Color TFUITextButton.Style::color  /*0x04001638*/
    IL_000c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0011: ldarg.0
    IL_0012: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0017: ldarg.1
    IL_0018: ldfld float TFUITextButton.Style::fontSize  /*0x04001639*/
    IL_001d: callvirt void TMPro.TMP_Text::set_fontSize(float)  /*0x0A00065F*/
    IL_0022: ldarg.0
    IL_0023: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0028: ldarg.1
    IL_0029: ldfld TMP_FontAsset TFUITextButton.Style::font  /*0x0400163C*/
    IL_002e: callvirt void TMPro.TMP_Text::set_font(TMPro.TMP_FontAsset)  /*0x0A00071E*/
    IL_0033: ldarg.0
    IL_0034: ldfld bool TFUITextButton::ignorePreAndSuffix  /*0x04001632*/
    IL_0039: brtrue.s IL_005d
    IL_003b: ldarg.0
    IL_003c: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0041: ldarg.1
    IL_0042: ldfld string TFUITextButton.Style::prefix  /*0x0400163A*/
    IL_0047: ldarg.0
    IL_0048: ldfld string TFUITextButton::originalString  /*0x04001635*/
    IL_004d: ldarg.1
    IL_004e: ldfld string TFUITextButton.Style::suffix  /*0x0400163B*/
    IL_0053: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0058: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005d: ret

  .method TFUITextButton::InitializeDefaultStyle()  // token 0x0600127A rva 0x5849c attrs Private, HideBySig
    // code size 91 (0x5b), max stack 6, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUITextButton::defaultStyleInitialized  /*0x0400162B*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call !!0 UnityEngine.Component::GetComponent()<TMPro.TextMeshProUGUI>  /*0x2B000086*/
    IL_0010: stfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0015: ldarg.0
    IL_0016: call void TFUITextButton::UpdateOriginalStringLocalized()  /*0x0600127B*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0022: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0027: ldarg.0
    IL_0028: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_002d: callvirt float TMPro.TMP_Text::get_fontSize()  /*0x0A00071F*/
    IL_0032: ldarg.0
    IL_0033: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0038: callvirt TMP_FontAsset TMPro.TMP_Text::get_font()  /*0x0A000720*/
    IL_003d: ldarg.0
    IL_003e: ldfld AnimationCurve TFUITextButton::defaultAnimationCurve  /*0x0400162C*/
    IL_0043: ldarg.0
    IL_0044: ldfld float TFUITextButton::defaultAnimationTime  /*0x0400162D*/
    IL_0049: newobj void TFUITextButton.Style::.ctor(UnityEngine.Color,float,TMPro.TMP_FontAsset,UnityEngine.AnimationCurve,float)  /*0x0600127E*/
    IL_004e: stfld TFUITextButton.Style TFUITextButton::defaultStyle  /*0x0400162A*/
    IL_0053: ldarg.0
    IL_0054: ldc.i4.1
    IL_0055: stfld bool TFUITextButton::defaultStyleInitialized  /*0x0400162B*/
    IL_005a: ret

  .method TFUITextButton::UpdateOriginalStringLocalized()  // token 0x0600127B rva 0x58504 attrs Private, HideBySig
    // code size 85 (0x55), max stack 6, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call !!0 UnityEngine.Component::GetComponent()<I2.Loc.Localize>  /*0x2B000106*/
    IL_0015: stfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_001a: ldarg.0
    IL_001b: ldfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0026: brfalse.s IL_003a
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_002f: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0034: stfld string TFUITextButton::originalString  /*0x04001635*/
    IL_0039: ret
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: ldfld Localize TFUITextButton::locComponent  /*0x04001637*/
    IL_0041: callvirt string I2.Loc.Localize::get_Term()  /*0x060017F7*/
    IL_0046: ldc.i4.1
    IL_0047: ldc.i4.0
    IL_0048: ldc.i4.1
    IL_0049: ldc.i4.1
    IL_004a: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_004f: stfld string TFUITextButton::originalString  /*0x04001635*/
    IL_0054: ret

  .method TFUITextButton::SetOriginalString(string)  // token 0x0600127C rva 0x58565 attrs Public, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TFUITextButton::defaultStyleInitialized  /*0x0400162B*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void TFUITextButton::InitializeDefaultStyle()  /*0x0600127A*/
    IL_000e: ldarg.0
    IL_000f: ldarg.1
    IL_0010: stfld string TFUITextButton::originalString  /*0x04001635*/
    IL_0015: ldarg.0
    IL_0016: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_001b: ldarg.1
    IL_001c: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0021: ldarg.0
    IL_0022: ldarg.0
    IL_0023: ldfld ThronefallUIElement.SelectionState ThronefallUIElement::currentState  /*0x0400167B*/
    IL_0028: callvirt void ThronefallUIElement::OnHardStateSet(ThronefallUIElement.SelectionState)  /*0x060012B4*/
    IL_002d: ret

  .method TFUITextButton::.ctor()  // token 0x0600127D rva 0x58594 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve TFUITextButton::defaultAnimationCurve  /*0x0400162C*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0.3f
    IL_0025: stfld float TFUITextButton::defaultAnimationTime  /*0x0400162D*/
    IL_002a: ldarg.0
    IL_002b: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0030: ret

// ===== TFUITextButton/Style  (token 0x0200035C) =====
  .method TFUITextButton.Style::.ctor(UnityEngine.Color,float,TMPro.TMP_FontAsset,UnityEngine.AnimationCurve,float)  // token 0x0600127E rva 0x585c8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 108 (0x6c), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0006: stfld Color TFUITextButton.Style::color  /*0x04001638*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 30f
    IL_0011: stfld float TFUITextButton.Style::fontSize  /*0x04001639*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0f
    IL_001c: ldc.r4 0f
    IL_0021: ldc.r4 1f
    IL_0026: ldc.r4 1f
    IL_002b: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_0030: stfld AnimationCurve TFUITextButton.Style::animationCurve  /*0x0400163D*/
    IL_0035: ldarg.0
    IL_0036: ldc.r4 0.5f
    IL_003b: stfld float TFUITextButton.Style::animationDuration  /*0x0400163E*/
    IL_0040: ldarg.0
    IL_0041: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0046: ldarg.0
    IL_0047: ldarg.1
    IL_0048: stfld Color TFUITextButton.Style::color  /*0x04001638*/
    IL_004d: ldarg.0
    IL_004e: ldarg.2
    IL_004f: stfld float TFUITextButton.Style::fontSize  /*0x04001639*/
    IL_0054: ldarg.0
    IL_0055: ldarg.3
    IL_0056: stfld TMP_FontAsset TFUITextButton.Style::font  /*0x0400163C*/
    IL_005b: ldarg.0
    IL_005c: ldarg.s 4
    IL_005e: stfld AnimationCurve TFUITextButton.Style::animationCurve  /*0x0400163D*/
    IL_0063: ldarg.0
    IL_0064: ldarg.s 5
    IL_0066: stfld float TFUITextButton.Style::animationDuration  /*0x0400163E*/
    IL_006b: ret

// ===== TFUITextButton/Animation  (token 0x0200035D) =====
  .method TFUITextButton.Animation::.ctor(TFUITextButton.Style,TFUITextButton.Style,TFUITextButton)  // token 0x0600127F rva 0x58640 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 101 (0x65), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld TFUITextButton.Style TFUITextButton.Animation::startStyle  /*0x04001640*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_0014: ldarg.0
    IL_0015: ldarg.3
    IL_0016: stfld TFUITextButton TFUITextButton.Animation::target  /*0x0400163F*/
    IL_001b: ldarg.3
    IL_001c: ldarg.1
    IL_001d: callvirt void TFUITextButton::ApplyStyle(TFUITextButton.Style)  /*0x06001279*/
    IL_0022: ldarg.3
    IL_0023: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0028: ldarg.2
    IL_0029: ldfld TMP_FontAsset TFUITextButton.Style::font  /*0x0400163C*/
    IL_002e: callvirt void TMPro.TMP_Text::set_font(TMPro.TMP_FontAsset)  /*0x0A00071E*/
    IL_0033: ldarg.3
    IL_0034: ldfld bool TFUITextButton::ignorePreAndSuffix  /*0x04001632*/
    IL_0039: brtrue.s IL_005d
    IL_003b: ldarg.3
    IL_003c: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0041: ldarg.2
    IL_0042: ldfld string TFUITextButton.Style::prefix  /*0x0400163A*/
    IL_0047: ldarg.3
    IL_0048: ldfld string TFUITextButton::originalString  /*0x04001635*/
    IL_004d: ldarg.2
    IL_004e: ldfld string TFUITextButton.Style::suffix  /*0x0400163B*/
    IL_0053: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0058: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_005d: ldarg.3
    IL_005e: ldarg.0
    IL_005f: stfld TFUITextButton.Animation TFUITextButton::currentAnimation  /*0x04001636*/
    IL_0064: ret

  .method TFUITextButton.Animation::Tick()  // token 0x06001280 rva 0x586b4 attrs Public, HideBySig
    // code size 190 (0xbe), max stack 4, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float TFUITextButton.Animation::clock  /*0x04001642*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float TFUITextButton.Animation::clock  /*0x04001642*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_001d: ldfld float TFUITextButton.Style::animationDuration  /*0x0400163E*/
    IL_0022: ldarg.0
    IL_0023: ldfld float TFUITextButton.Animation::clock  /*0x04001642*/
    IL_0028: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_0034: ldfld AnimationCurve TFUITextButton.Style::animationCurve  /*0x0400163D*/
    IL_0039: ldloc.0
    IL_003a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_003f: stloc.1
    IL_0040: ldarg.0
    IL_0041: ldfld TFUITextButton TFUITextButton.Animation::target  /*0x0400163F*/
    IL_0046: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_004b: ldarg.0
    IL_004c: ldfld TFUITextButton.Style TFUITextButton.Animation::startStyle  /*0x04001640*/
    IL_0051: ldfld Color TFUITextButton.Style::color  /*0x04001638*/
    IL_0056: ldarg.0
    IL_0057: ldfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_005c: ldfld Color TFUITextButton.Style::color  /*0x04001638*/
    IL_0061: ldloc.1
    IL_0062: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0067: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_006c: ldarg.0
    IL_006d: ldfld TFUITextButton TFUITextButton.Animation::target  /*0x0400163F*/
    IL_0072: ldfld TextMeshProUGUI TFUITextButton::targetText  /*0x04001634*/
    IL_0077: ldarg.0
    IL_0078: ldfld TFUITextButton.Style TFUITextButton.Animation::startStyle  /*0x04001640*/
    IL_007d: ldfld float TFUITextButton.Style::fontSize  /*0x04001639*/
    IL_0082: ldarg.0
    IL_0083: ldfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_0088: ldfld float TFUITextButton.Style::fontSize  /*0x04001639*/
    IL_008d: ldloc.1
    IL_008e: call float UnityEngine.Mathf::LerpUnclamped(float,float,float)  /*0x0A00071B*/
    IL_0093: callvirt void TMPro.TMP_Text::set_fontSize(float)  /*0x0A00065F*/
    IL_0098: ldloc.0
    IL_0099: ldc.r4 1f
    IL_009e: blt.un.s IL_00bd
    IL_00a0: ldarg.0
    IL_00a1: ldfld TFUITextButton TFUITextButton.Animation::target  /*0x0400163F*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld TFUITextButton.Style TFUITextButton.Animation::endStyle  /*0x04001641*/
    IL_00ac: callvirt void TFUITextButton::ApplyStyle(TFUITextButton.Style)  /*0x06001279*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld TFUITextButton TFUITextButton.Animation::target  /*0x0400163F*/
    IL_00b7: ldnull
    IL_00b8: stfld TFUITextButton.Animation TFUITextButton::currentAnimation  /*0x04001636*/
    IL_00bd: ret

