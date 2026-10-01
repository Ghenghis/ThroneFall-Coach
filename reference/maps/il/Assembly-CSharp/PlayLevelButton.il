// ===== PlayLevelButton  (token 0x020001AF) =====
  .method PlayLevelButton::Start()  // token 0x060008C4 rva 0x2a63c attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.Image>  /*0x2B000097*/
    IL_0007: stfld Image PlayLevelButton::image  /*0x04000B06*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Image PlayLevelButton::image  /*0x04000B06*/
    IL_0013: callvirt Color UnityEngine.UI.Graphic::get_color()  /*0x0A000365*/
    IL_0018: stfld Color PlayLevelButton::colorBasic  /*0x04000B05*/
    IL_001d: ret

  .method PlayLevelButton::OnPointerEnter(UnityEngine.EventSystems.PointerEventData)  // token 0x060008C5 rva 0x2a65b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool PlayLevelButton::mouseIsOver  /*0x04000B04*/
    IL_0007: ret

  .method PlayLevelButton::OnPointerExit(UnityEngine.EventSystems.PointerEventData)  // token 0x060008C6 rva 0x2a664 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool PlayLevelButton::mouseIsOver  /*0x04000B04*/
    IL_0007: ret

  .method PlayLevelButton::Update()  // token 0x060008C7 rva 0x2a66d attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Image PlayLevelButton::image  /*0x04000B06*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool PlayLevelButton::mouseIsOver  /*0x04000B04*/
    IL_000c: brtrue.s IL_0016
    IL_000e: ldarg.0
    IL_000f: ldfld Color PlayLevelButton::colorBasic  /*0x04000B05*/
    IL_0014: br.s IL_001c
    IL_0016: ldarg.0
    IL_0017: ldfld Color PlayLevelButton::hoverColor  /*0x04000B07*/
    IL_001c: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0021: ldc.i4.0
    IL_0022: call bool UnityEngine.Input::GetMouseButtonDown(int)  /*0x0A0003D5*/
    IL_0027: brfalse.s IL_003b
    IL_0029: ldarg.0
    IL_002a: ldfld bool PlayLevelButton::mouseIsOver  /*0x04000B04*/
    IL_002f: brfalse.s IL_003b
    IL_0031: ldsfld LevelSelectManager LevelSelectManager::instance  /*0x04000AD4*/
    IL_0036: callvirt void LevelSelectManager::PlayButtonPressed()  /*0x060008B5*/
    IL_003b: ret

  .method PlayLevelButton::.ctor()  // token 0x060008C8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

