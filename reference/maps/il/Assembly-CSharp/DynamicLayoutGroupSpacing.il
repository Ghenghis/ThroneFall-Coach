// ===== DynamicLayoutGroupSpacing  (token 0x020002F6) =====
  .method DynamicLayoutGroupSpacing::Awake()  // token 0x06001051 rva 0x4a520 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.HorizontalLayoutGroup>  /*0x2B0000E7*/
    IL_0007: stfld HorizontalLayoutGroup DynamicLayoutGroupSpacing::layout  /*0x0400132F*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0013: stfld RectTransform DynamicLayoutGroupSpacing::rectT  /*0x04001330*/
    IL_0018: ret

  .method DynamicLayoutGroupSpacing::Update()  // token 0x06001052 rva 0x4a53a attrs Private, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RectTransform DynamicLayoutGroupSpacing::rectT  /*0x04001330*/
    IL_0006: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_000b: ldarg.0
    IL_000c: ldfld int DynamicLayoutGroupSpacing::bufferedChildCount  /*0x04001331*/
    IL_0011: beq.s IL_0019
    IL_0013: ldarg.0
    IL_0014: call void DynamicLayoutGroupSpacing::Refresh()  /*0x06001053*/
    IL_0019: ret

  .method DynamicLayoutGroupSpacing::Refresh()  // token 0x06001053 rva 0x4a558 attrs Private, HideBySig
    // code size 150 (0x96), max stack 3, init locals
    .locals ([0] int, [1] float, [2] float, [3] IEnumerator, [4] RectTransform, [5] IDisposable)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.r4 0f
    IL_0007: stloc.1
    IL_0008: ldarg.0
    IL_0009: ldfld RectTransform DynamicLayoutGroupSpacing::rectT  /*0x04001330*/
    IL_000e: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0013: stloc.3
    IL_0014: br.s IL_0036
    IL_0016: ldloc.3
    IL_0017: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_001c: castclass UnityEngine.RectTransform  /*0x01000020*/
    IL_0021: stloc.s 4
    IL_0023: ldloc.0
    IL_0024: ldc.i4.1
    IL_0025: add
    IL_0026: stloc.0
    IL_0027: ldloc.1
    IL_0028: ldloc.s 4
    IL_002a: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_002f: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0034: add
    IL_0035: stloc.1
    IL_0036: ldloc.3
    IL_0037: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_003c: brtrue.s IL_0016
    IL_003e: leave.s IL_0054
    IL_0040: ldloc.3
    IL_0041: isinst System.IDisposable  /*0x0100001B*/
    IL_0046: stloc.s 5
    IL_0048: ldloc.s 5
    IL_004a: brfalse.s IL_0053
    IL_004c: ldloc.s 5
    IL_004e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0053: endfinally
    IL_0054: ldarg.0
    IL_0055: ldfld float DynamicLayoutGroupSpacing::maxWidth  /*0x0400132E*/
    IL_005a: ldloc.1
    IL_005b: sub
    IL_005c: ldloc.0
    IL_005d: conv.r4
    IL_005e: ldc.r4 1f
    IL_0063: sub
    IL_0064: div
    IL_0065: stloc.2
    IL_0066: ldloc.2
    IL_0067: ldarg.0
    IL_0068: ldfld int DynamicLayoutGroupSpacing::maxSpacing  /*0x0400132D*/
    IL_006d: conv.r4
    IL_006e: ble.un.s IL_0078
    IL_0070: ldarg.0
    IL_0071: ldfld int DynamicLayoutGroupSpacing::maxSpacing  /*0x0400132D*/
    IL_0076: conv.r4
    IL_0077: stloc.2
    IL_0078: ldarg.0
    IL_0079: ldfld HorizontalLayoutGroup DynamicLayoutGroupSpacing::layout  /*0x0400132F*/
    IL_007e: ldloc.2
    IL_007f: callvirt void UnityEngine.UI.HorizontalOrVerticalLayoutGroup::set_spacing(float)  /*0x0A000605*/
    IL_0084: ldarg.0
    IL_0085: ldarg.0
    IL_0086: ldfld RectTransform DynamicLayoutGroupSpacing::rectT  /*0x04001330*/
    IL_008b: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0090: stfld int DynamicLayoutGroupSpacing::bufferedChildCount  /*0x04001331*/
    IL_0095: ret
    .try IL_0014-IL_0040 finally handler IL_0040-IL_0054

  .method DynamicLayoutGroupSpacing::.ctor()  // token 0x06001054 rva 0x4a60c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld int DynamicLayoutGroupSpacing::maxSpacing  /*0x0400132D*/
    IL_0008: ldarg.0
    IL_0009: ldc.r4 1070f
    IL_000e: stfld float DynamicLayoutGroupSpacing::maxWidth  /*0x0400132E*/
    IL_0013: ldarg.0
    IL_0014: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0019: ret

