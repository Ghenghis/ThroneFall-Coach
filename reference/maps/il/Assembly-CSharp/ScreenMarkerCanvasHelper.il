// ===== ScreenMarkerCanvasHelper  (token 0x0200033C) =====
  .method ScreenMarkerCanvasHelper::get_Height()  // token 0x060011AC rva 0x558c8 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform ScreenMarkerCanvasHelper::ownRT  /*0x04001566*/
    IL_0006: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_000b: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0010: ret

  .method ScreenMarkerCanvasHelper::Awake()  // token 0x060011AD rva 0x558da attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldsfld ScreenMarkerCanvasHelper ScreenMarkerCanvasHelper::instance  /*0x04001565*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0013
    IL_000d: ldarg.0
    IL_000e: stsfld ScreenMarkerCanvasHelper ScreenMarkerCanvasHelper::instance  /*0x04001565*/
    IL_0013: ret

  .method ScreenMarkerCanvasHelper::.ctor()  // token 0x060011AE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

