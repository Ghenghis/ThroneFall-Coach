// ===== TextBackgroundFitter  (token 0x02000345) =====
  .method TextBackgroundFitter::OnEnable()  // token 0x060011C9 rva 0x56120 attrs Private, HideBySig
    // code size 122 (0x7a), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0007: stfld RectTransform TextBackgroundFitter::ownRT  /*0x0400158D*/
    IL_000c: ldarg.0
    IL_000d: ldfld ContentSizeFitter TextBackgroundFitter::csf  /*0x0400158F*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0018: ldarg.0
    IL_0019: ldfld ContentSizeFitter TextBackgroundFitter::csf  /*0x0400158F*/
    IL_001e: ldc.i4.1
    IL_001f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0024: ldarg.0
    IL_0025: ldfld RectTransform TextBackgroundFitter::target  /*0x0400158E*/
    IL_002a: call void UnityEngine.UI.LayoutRebuilder::ForceRebuildLayoutImmediate(UnityEngine.RectTransform)  /*0x0A000641*/
    IL_002f: ldarg.0
    IL_0030: ldfld RectTransform TextBackgroundFitter::ownRT  /*0x0400158D*/
    IL_0035: ldarg.0
    IL_0036: ldfld RectTransform TextBackgroundFitter::target  /*0x0400158E*/
    IL_003b: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0040: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0045: ldarg.0
    IL_0046: ldfld float TextBackgroundFitter::horizontalPaddingPerSide  /*0x04001590*/
    IL_004b: ldc.r4 2f
    IL_0050: mul
    IL_0051: add
    IL_0052: ldarg.0
    IL_0053: ldfld RectTransform TextBackgroundFitter::target  /*0x0400158E*/
    IL_0058: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_005d: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0062: ldarg.0
    IL_0063: ldfld float TextBackgroundFitter::verticalPaddingPerSide  /*0x04001591*/
    IL_0068: ldc.r4 2f
    IL_006d: mul
    IL_006e: add
    IL_006f: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0074: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0079: ret

  .method TextBackgroundFitter::.ctor()  // token 0x060011CA rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

