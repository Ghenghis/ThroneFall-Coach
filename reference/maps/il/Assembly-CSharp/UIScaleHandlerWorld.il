// ===== UIScaleHandlerWorld  (token 0x02000377) =====
  .method UIScaleHandlerWorld::Start()  // token 0x0600131F rva 0x5b11e attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_000c: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0011: stfld float UIScaleHandlerWorld::originScale  /*0x0400171A*/
    IL_0016: ldarg.0
    IL_0017: call void UIScaleHandlerWorld::Refresh()  /*0x06001320*/
    IL_001c: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0021: ldfld UnityEvent SettingsManager::onUIScaleChange  /*0x04000FF5*/
    IL_0026: ldarg.0
    IL_0027: ldftn void UIScaleHandlerWorld::Refresh()  /*0x06001320*/
    IL_002d: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0032: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0037: ret

  .method UIScaleHandlerWorld::Refresh()  // token 0x06001320 rva 0x5b158 attrs Public, HideBySig
    // code size 57 (0x39), max stack 5, init locals
    .locals ([0] float)
    IL_0000: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0005: callvirt float SettingsManager::get_UiReferenceResolutionFactor()  /*0x06000DA7*/
    IL_000a: stloc.0
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0016: ldarg.0
    IL_0017: ldfld float UIScaleHandlerWorld::originScale  /*0x0400171A*/
    IL_001c: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0021: ldc.r4 1f
    IL_0026: ldloc.0
    IL_0027: ldc.r4 1f
    IL_002c: sub
    IL_002d: sub
    IL_002e: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0033: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0038: ret

  .method UIScaleHandlerWorld::.ctor()  // token 0x06001321 rva 0x5b19d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float UIScaleHandlerWorld::originScale  /*0x0400171A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

