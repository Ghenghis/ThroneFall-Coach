// ===== AdjustLayoutGroupSpacingBasedOnUIScale  (token 0x020002C0) =====
  .method AdjustLayoutGroupSpacingBasedOnUIScale::OnEnable()  // token 0x06000F2B rva 0x44d18 attrs Private, HideBySig
    // code size 90 (0x5a), max stack 6, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.VerticalLayoutGroup>  /*0x2B0000D7*/
    IL_0006: ldc.r4 50f
    IL_000b: ldc.r4 150f
    IL_0010: ldc.r4 1.2f
    IL_0015: ldc.r4 0.8f
    IL_001a: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001f: callvirt float SettingsManager::get_UiReferenceResolutionFactor()  /*0x06000DA7*/
    IL_0024: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0029: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_002e: stloc.0
    IL_002f: ldarg.0
    IL_0030: ldfld float AdjustLayoutGroupSpacingBasedOnUIScale::minSpacing  /*0x040011AF*/
    IL_0035: ldarg.0
    IL_0036: ldfld float AdjustLayoutGroupSpacingBasedOnUIScale::maxSpacing  /*0x040011B0*/
    IL_003b: ldarg.0
    IL_003c: ldfld float AdjustLayoutGroupSpacingBasedOnUIScale::minScale  /*0x040011B1*/
    IL_0041: ldarg.0
    IL_0042: ldfld float AdjustLayoutGroupSpacingBasedOnUIScale::maxScale  /*0x040011B2*/
    IL_0047: ldloc.0
    IL_0048: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_004d: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0052: stloc.1
    IL_0053: ldloc.1
    IL_0054: callvirt void UnityEngine.UI.HorizontalOrVerticalLayoutGroup::set_spacing(float)  /*0x0A000605*/
    IL_0059: ret

  .method AdjustLayoutGroupSpacingBasedOnUIScale::.ctor()  // token 0x06000F2C rva 0x44d7e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 100f
    IL_0006: stfld float AdjustLayoutGroupSpacingBasedOnUIScale::minScale  /*0x040011B1*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 100f
    IL_0011: stfld float AdjustLayoutGroupSpacingBasedOnUIScale::maxScale  /*0x040011B2*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

