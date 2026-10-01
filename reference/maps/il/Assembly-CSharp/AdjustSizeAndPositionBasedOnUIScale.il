// ===== AdjustSizeAndPositionBasedOnUIScale  (token 0x020002C1) =====
  .method AdjustSizeAndPositionBasedOnUIScale::OnEnable()  // token 0x06000F2D rva 0x44d9c attrs Private, HideBySig
    // code size 177 (0xb1), max stack 5, init locals
    .locals ([0] RectTransform, [1] float, [2] float, [3] float)
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0006: stloc.0
    IL_0007: ldc.r4 50f
    IL_000c: ldc.r4 150f
    IL_0011: ldc.r4 1.2f
    IL_0016: ldc.r4 0.8f
    IL_001b: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0020: callvirt float SettingsManager::get_UiReferenceResolutionFactor()  /*0x06000DA7*/
    IL_0025: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_002a: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_002f: stloc.1
    IL_0030: ldarg.0
    IL_0031: ldfld float AdjustSizeAndPositionBasedOnUIScale::minSize  /*0x040011B4*/
    IL_0036: ldarg.0
    IL_0037: ldfld float AdjustSizeAndPositionBasedOnUIScale::maxSize  /*0x040011B5*/
    IL_003c: ldarg.0
    IL_003d: ldfld float AdjustSizeAndPositionBasedOnUIScale::minScale  /*0x040011B9*/
    IL_0042: ldarg.0
    IL_0043: ldfld float AdjustSizeAndPositionBasedOnUIScale::maxScale  /*0x040011BA*/
    IL_0048: ldloc.1
    IL_0049: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_004e: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0053: stloc.2
    IL_0054: ldarg.0
    IL_0055: ldfld float AdjustSizeAndPositionBasedOnUIScale::minXPos  /*0x040011B7*/
    IL_005a: ldarg.0
    IL_005b: ldfld float AdjustSizeAndPositionBasedOnUIScale::maxXPos  /*0x040011B8*/
    IL_0060: ldarg.0
    IL_0061: ldfld float AdjustSizeAndPositionBasedOnUIScale::minScale  /*0x040011B9*/
    IL_0066: ldarg.0
    IL_0067: ldfld float AdjustSizeAndPositionBasedOnUIScale::maxScale  /*0x040011BA*/
    IL_006c: ldloc.1
    IL_006d: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0072: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0077: stloc.3
    IL_0078: ldarg.0
    IL_0079: ldfld bool AdjustSizeAndPositionBasedOnUIScale::useSize  /*0x040011B3*/
    IL_007e: brfalse.s IL_0091
    IL_0080: ldloc.0
    IL_0081: ldloc.2
    IL_0082: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0087: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_008c: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0091: ldarg.0
    IL_0092: ldfld bool AdjustSizeAndPositionBasedOnUIScale::useXPos  /*0x040011B6*/
    IL_0097: brfalse.s IL_00b0
    IL_0099: ldloc.0
    IL_009a: ldloc.3
    IL_009b: ldloc.0
    IL_009c: callvirt Vector2 UnityEngine.RectTransform::get_anchoredPosition()  /*0x0A000606*/
    IL_00a1: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_00a6: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00ab: callvirt void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)  /*0x0A000607*/
    IL_00b0: ret

  .method AdjustSizeAndPositionBasedOnUIScale::.ctor()  // token 0x06000F2E rva 0x44e59 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool AdjustSizeAndPositionBasedOnUIScale::useSize  /*0x040011B3*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 100f
    IL_000d: stfld float AdjustSizeAndPositionBasedOnUIScale::minScale  /*0x040011B9*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 100f
    IL_0018: stfld float AdjustSizeAndPositionBasedOnUIScale::maxScale  /*0x040011BA*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

