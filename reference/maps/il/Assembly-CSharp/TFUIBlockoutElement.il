// ===== TFUIBlockoutElement  (token 0x02000348) =====
  .method TFUIBlockoutElement::OnEnable()  // token 0x060011D2 rva 0x562b0 attrs Private, HideBySig
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0007: ldfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_000c: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0018: ldfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_001d: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0029: ldfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_002e: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_003a: ldfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_003f: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0044: ret

  .method TFUIBlockoutElement::OnApply()  // token 0x060011D3 rva 0x56301 attrs Family, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0006: callvirt void ThronefallUIElement::Apply()  /*0x060012A9*/
    IL_000b: ret

  .method TFUIBlockoutElement::OnClear()  // token 0x060011D4 rva 0x5630e attrs Family, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0006: callvirt void ThronefallUIElement::Clear()  /*0x060012AD*/
    IL_000b: ret

  .method TFUIBlockoutElement::OnFocus()  // token 0x060011D5 rva 0x5631b attrs Family, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0006: callvirt void ThronefallUIElement::Focus()  /*0x060012AB*/
    IL_000b: ret

  .method TFUIBlockoutElement::OnFocusAndSelect()  // token 0x060011D6 rva 0x56328 attrs Family, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0006: callvirt void ThronefallUIElement::FocusAndSelect()  /*0x060012AC*/
    IL_000b: ret

  .method TFUIBlockoutElement::OnHardStateSet(ThronefallUIElement.SelectionState)  // token 0x060011D7 rva 0x56335 attrs Family, Virtual, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotImplementedException::.ctor()  /*0x0A000719*/
    IL_0005: throw

  .method TFUIBlockoutElement::OnSelect()  // token 0x060011D8 rva 0x5633c attrs Family, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement TFUIBlockoutElement::target  /*0x04001598*/
    IL_0006: callvirt void ThronefallUIElement::Select()  /*0x060012AA*/
    IL_000b: ret

  .method TFUIBlockoutElement::.ctor()  // token 0x060011D9 rva 0x56349 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallUIElement::.ctor()  /*0x060012BA*/
    IL_0006: ret

