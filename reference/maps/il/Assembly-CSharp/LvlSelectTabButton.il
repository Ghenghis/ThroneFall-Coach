// ===== LvlSelectTabButton  (token 0x02000321) =====
  .method LvlSelectTabButton::Start()  // token 0x06001146 rva 0x516d6 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.Image>  /*0x2B000097*/
    IL_0007: stfld Image LvlSelectTabButton::image  /*0x0400149E*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Image LvlSelectTabButton::image  /*0x0400149E*/
    IL_0013: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0018: stfld Color LvlSelectTabButton::colorBasic  /*0x0400149D*/
    IL_001d: ret

  .method LvlSelectTabButton::OnPointerEnter(UnityEngine.EventSystems.PointerEventData)  // token 0x06001147 rva 0x516f5 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool LvlSelectTabButton::mouseIsOver  /*0x0400149C*/
    IL_0007: ret

  .method LvlSelectTabButton::OnPointerExit(UnityEngine.EventSystems.PointerEventData)  // token 0x06001148 rva 0x516fe attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool LvlSelectTabButton::mouseIsOver  /*0x0400149C*/
    IL_0007: ret

  .method LvlSelectTabButton::Update()  // token 0x06001149 rva 0x51708 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Image LvlSelectTabButton::image  /*0x0400149E*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool LvlSelectTabButton::mouseIsOver  /*0x0400149C*/
    IL_000c: brtrue.s IL_0016
    IL_000e: ldarg.0
    IL_000f: ldfld Color LvlSelectTabButton::colorBasic  /*0x0400149D*/
    IL_0014: br.s IL_001c
    IL_0016: ldarg.0
    IL_0017: ldfld Color LvlSelectTabButton::hoverColor  /*0x0400149F*/
    IL_001c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0021: ldarg.0
    IL_0022: ldfld bool LvlSelectTabButton::selected  /*0x040014A1*/
    IL_0027: brfalse.s IL_003a
    IL_0029: ldarg.0
    IL_002a: ldfld Image LvlSelectTabButton::image  /*0x0400149E*/
    IL_002f: ldarg.0
    IL_0030: ldfld Color LvlSelectTabButton::selectedColor  /*0x040014A0*/
    IL_0035: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_003a: ldc.i4.0
    IL_003b: call bool UnityEngine.Input::GetMouseButtonDown(int)  /*0x0A0003D5*/
    IL_0040: brfalse.s IL_0049
    IL_0042: ldarg.0
    IL_0043: ldfld bool LvlSelectTabButton::mouseIsOver  /*0x0400149C*/
    IL_0048: pop
    IL_0049: ret

  .method LvlSelectTabButton::.ctor()  // token 0x0600114A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

