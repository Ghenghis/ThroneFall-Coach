// ===== SetWidthToTarget  (token 0x02000342) =====
  .method SetWidthToTarget::Awake()  // token 0x060011C2 rva 0x55f80 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0007: stfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_000c: ldarg.0
    IL_000d: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_0012: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0017: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_001c: ldarg.0
    IL_001d: ldfld float SetWidthToTarget::minWidth  /*0x04001588*/
    IL_0022: bge.un.s IL_004a
    IL_0024: ldarg.0
    IL_0025: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_002a: ldarg.0
    IL_002b: ldfld float SetWidthToTarget::minWidth  /*0x04001588*/
    IL_0030: ldarg.0
    IL_0031: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_0036: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_003b: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0040: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0045: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_004a: ret

  .method SetWidthToTarget::Update()  // token 0x060011C3 rva 0x55fd8 attrs Private, HideBySig
    // code size 151 (0x97), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform SetWidthToTarget::target  /*0x04001586*/
    IL_0006: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_000b: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0010: ldarg.0
    IL_0011: ldfld float SetWidthToTarget::padding  /*0x04001587*/
    IL_0016: ldc.r4 2f
    IL_001b: mul
    IL_001c: add
    IL_001d: ldarg.0
    IL_001e: ldfld float SetWidthToTarget::minWidth  /*0x04001588*/
    IL_0023: ble.un.s IL_0096
    IL_0025: ldarg.0
    IL_0026: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_002b: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0030: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0035: ldarg.0
    IL_0036: ldfld float SetWidthToTarget::padding  /*0x04001587*/
    IL_003b: ldc.r4 2f
    IL_0040: mul
    IL_0041: sub
    IL_0042: ldarg.0
    IL_0043: ldfld RectTransform SetWidthToTarget::target  /*0x04001586*/
    IL_0048: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_004d: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0052: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_0057: brtrue.s IL_0096
    IL_0059: ldarg.0
    IL_005a: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_005f: ldarg.0
    IL_0060: ldfld RectTransform SetWidthToTarget::target  /*0x04001586*/
    IL_0065: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_006a: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_006f: ldarg.0
    IL_0070: ldfld float SetWidthToTarget::padding  /*0x04001587*/
    IL_0075: ldc.r4 2f
    IL_007a: mul
    IL_007b: add
    IL_007c: ldarg.0
    IL_007d: ldfld RectTransform SetWidthToTarget::rt  /*0x04001589*/
    IL_0082: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0087: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_008c: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0091: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0096: ret

  .method SetWidthToTarget::.ctor()  // token 0x060011C4 rva 0x5607b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 800f
    IL_0006: stfld float SetWidthToTarget::minWidth  /*0x04001588*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

