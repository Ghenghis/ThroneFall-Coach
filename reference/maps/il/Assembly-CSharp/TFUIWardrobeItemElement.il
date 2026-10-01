// ===== TFUIWardrobeItemElement  (token 0x0200037E) =====
  .method TFUIWardrobeItemElement::get_WardrobeItem()  // token 0x06001341 rva 0x5b815 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld WardrobeItem TFUIWardrobeItemElement::wardrobeItem  /*0x0400174A*/
    IL_0006: ret

  .method TFUIWardrobeItemElement::SetupButton(WardrobeHandler,WardrobeItem)  // token 0x06001342 rva 0x5b81d attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld WardrobeHandler TFUIWardrobeElement::handler  /*0x04001741*/
    IL_0007: ldarg.0
    IL_0008: ldarg.2
    IL_0009: stfld WardrobeItem TFUIWardrobeItemElement::wardrobeItem  /*0x0400174A*/
    IL_000e: ret

  .method TFUIWardrobeItemElement::.ctor()  // token 0x06001343 rva 0x5b82d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void TFUIWardrobeElement::.ctor()  /*0x0600133D*/
    IL_0006: ret

