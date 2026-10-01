// ===== UIParentResizer  (token 0x02000375) =====
  .method UIParentResizer::Trigger()  // token 0x0600131B rva 0x5b028 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool UIParentResizer::dirty  /*0x04001717*/
    IL_0007: ret

  .method UIParentResizer::Resize()  // token 0x0600131C rva 0x5b034 attrs Private, HideBySig
    // code size 162 (0xa2), max stack 5, init locals
    .locals ([0] float, [1] List.Enumerator<RectTransform>, [2] RectTransform)
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform UIParentResizer::ownRT  /*0x04001716*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0015: stfld RectTransform UIParentResizer::ownRT  /*0x04001716*/
    IL_001a: ldc.r4 0f
    IL_001f: stloc.0
    IL_0020: ldarg.0
    IL_0021: ldfld List<RectTransform> UIParentResizer::observedElements  /*0x04001715*/
    IL_0026: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.RectTransform>::GetEnumerator()  /*0x0A000754*/
    IL_002b: stloc.1
    IL_002c: br.s IL_004a
    IL_002e: ldloca.s 1
    IL_0030: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.RectTransform>::get_Current()  /*0x0A000755*/
    IL_0035: stloc.2
    IL_0036: ldloc.2
    IL_0037: call void UnityEngine.UI.LayoutRebuilder::ForceRebuildLayoutImmediate(UnityEngine.RectTransform)  /*0x0A000641*/
    IL_003c: ldloc.0
    IL_003d: ldloc.2
    IL_003e: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0043: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0048: add
    IL_0049: stloc.0
    IL_004a: ldloca.s 1
    IL_004c: call bool System.Collections.Generic.List.Enumerator<UnityEngine.RectTransform>::MoveNext()  /*0x0A000756*/
    IL_0051: brtrue.s IL_002e
    IL_0053: leave.s IL_0063
    IL_0055: ldloca.s 1
    IL_0057: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.RectTransform>  /*0x1B000159*/
    IL_005d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0062: endfinally
    IL_0063: ldloc.0
    IL_0064: ldarg.0
    IL_0065: ldfld float UIParentResizer::minHeight  /*0x04001713*/
    IL_006a: bge.un.s IL_0073
    IL_006c: ldarg.0
    IL_006d: ldfld float UIParentResizer::minHeight  /*0x04001713*/
    IL_0072: stloc.0
    IL_0073: ldarg.0
    IL_0074: ldfld RectTransform UIParentResizer::ownRT  /*0x04001716*/
    IL_0079: ldarg.0
    IL_007a: ldfld RectTransform UIParentResizer::ownRT  /*0x04001716*/
    IL_007f: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_0084: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0089: ldloc.0
    IL_008a: ldc.r4 2f
    IL_008f: ldarg.0
    IL_0090: ldfld float UIParentResizer::padding  /*0x04001714*/
    IL_0095: mul
    IL_0096: add
    IL_0097: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_009c: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_00a1: ret
    .try IL_002c-IL_0055 finally handler IL_0055-IL_0063

  .method UIParentResizer::LateUpdate()  // token 0x0600131D rva 0x5b0f4 attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool UIParentResizer::dirty  /*0x04001717*/
    IL_0006: brfalse.s IL_0015
    IL_0008: ldarg.0
    IL_0009: call void UIParentResizer::Resize()  /*0x0600131C*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.0
    IL_0010: stfld bool UIParentResizer::dirty  /*0x04001717*/
    IL_0015: ret

  .method UIParentResizer::.ctor()  // token 0x0600131E rva 0x5b10b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 30f
    IL_0006: stfld float UIParentResizer::padding  /*0x04001714*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== UIParentResizer/Mode  (token 0x02000376) =====
