// ===== SettingsUIHelper  (token 0x02000340) =====
  .method SettingsUIHelper::Awake()  // token 0x060011BA rva 0x55c7c attrs Private, HideBySig
    // code size 232 (0xe8), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_0006: ldarg.0
    IL_0007: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::videoTab  /*0x0400157A*/
    IL_000c: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0011: ldarg.0
    IL_0012: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::videoTab  /*0x0400157A*/
    IL_0017: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::Add(!0,!1)  /*0x0A000713*/
    IL_001c: ldarg.0
    IL_001d: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_0022: ldarg.0
    IL_0023: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::audioTab  /*0x0400157B*/
    IL_0028: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_002d: ldarg.0
    IL_002e: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::audioTab  /*0x0400157B*/
    IL_0033: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::Add(!0,!1)  /*0x0A000713*/
    IL_0038: ldarg.0
    IL_0039: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_003e: ldarg.0
    IL_003f: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::gameplayTab  /*0x0400157C*/
    IL_0044: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0049: ldarg.0
    IL_004a: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::gameplayTab  /*0x0400157C*/
    IL_004f: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::Add(!0,!1)  /*0x0A000713*/
    IL_0054: ldarg.0
    IL_0055: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_005a: ldarg.0
    IL_005b: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::accessibilityTab  /*0x0400157D*/
    IL_0060: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0065: ldarg.0
    IL_0066: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::accessibilityTab  /*0x0400157D*/
    IL_006b: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::Add(!0,!1)  /*0x0A000713*/
    IL_0070: ldarg.0
    IL_0071: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_0076: ldarg.0
    IL_0077: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::controlsTab  /*0x0400157E*/
    IL_007c: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0081: ldarg.0
    IL_0082: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::controlsTab  /*0x0400157E*/
    IL_0087: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::Add(!0,!1)  /*0x0A000713*/
    IL_008c: ldarg.0
    IL_008d: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::videoTab  /*0x0400157A*/
    IL_0092: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_0097: ldc.i4.0
    IL_0098: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009d: ldarg.0
    IL_009e: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::audioTab  /*0x0400157B*/
    IL_00a3: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_00a8: ldc.i4.0
    IL_00a9: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ae: ldarg.0
    IL_00af: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::gameplayTab  /*0x0400157C*/
    IL_00b4: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_00b9: ldc.i4.0
    IL_00ba: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00bf: ldarg.0
    IL_00c0: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::accessibilityTab  /*0x0400157D*/
    IL_00c5: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_00ca: ldc.i4.0
    IL_00cb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::controlsTab  /*0x0400157E*/
    IL_00d6: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_00db: ldc.i4.0
    IL_00dc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e1: ldarg.0
    IL_00e2: call void SettingsUIHelper::RecomputeAllNavigation()  /*0x060011BB*/
    IL_00e7: ret

  .method SettingsUIHelper::RecomputeAllNavigation()  // token 0x060011BB rva 0x55d70 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::videoTab  /*0x0400157A*/
    IL_0006: callvirt void SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  /*0x060011C0*/
    IL_000b: ldarg.0
    IL_000c: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::audioTab  /*0x0400157B*/
    IL_0011: callvirt void SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  /*0x060011C0*/
    IL_0016: ldarg.0
    IL_0017: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::gameplayTab  /*0x0400157C*/
    IL_001c: callvirt void SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  /*0x060011C0*/
    IL_0021: ldarg.0
    IL_0022: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::accessibilityTab  /*0x0400157D*/
    IL_0027: callvirt void SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  /*0x060011C0*/
    IL_002c: ldarg.0
    IL_002d: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::controlsTab  /*0x0400157E*/
    IL_0032: callvirt void SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  /*0x060011C0*/
    IL_0037: ret

  .method SettingsUIHelper::OnShow()  // token 0x060011BC rva 0x55da9 attrs Public, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_000a: brtrue.s IL_0019
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject SettingsUIHelper::dimBG  /*0x0400157F*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld GameObject SettingsUIHelper::dimBG  /*0x0400157F*/
    IL_001f: ldc.i4.1
    IL_0020: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0025: ret

  .method SettingsUIHelper::OnSelect()  // token 0x060011BD rva 0x55dd0 attrs Public, HideBySig
    // code size 121 (0x79), max stack 3, init locals
    .locals ([0] SettingsUIHelper.SettingsTab)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_0008: ldarg.0
    IL_0009: ldfld UIFrame SettingsUIHelper::targetFrame  /*0x04001579*/
    IL_000e: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0013: ldloca.s 0
    IL_0015: callvirt bool System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::TryGetValue(!0,ref !1)  /*0x0A000714*/
    IL_001a: brfalse.s IL_005f
    IL_001c: ldarg.0
    IL_001d: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_0022: brfalse.s IL_0046
    IL_0024: ldarg.0
    IL_0025: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_002a: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_002f: ldc.i4.0
    IL_0030: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0035: ldarg.0
    IL_0036: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_003b: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0040: ldc.i4.0
    IL_0041: stfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0046: ldarg.0
    IL_0047: ldloc.0
    IL_0048: stfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_004d: ldarg.0
    IL_004e: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_0053: ldfld GameObject SettingsUIHelper.SettingsTab::contentParent  /*0x04001583*/
    IL_0058: ldc.i4.1
    IL_0059: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005e: ret
    IL_005f: ldarg.0
    IL_0060: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_0065: brfalse.s IL_0078
    IL_0067: ldarg.0
    IL_0068: ldfld SettingsUIHelper.SettingsTab SettingsUIHelper::currentSelectedTab  /*0x04001580*/
    IL_006d: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_0072: ldc.i4.1
    IL_0073: stfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0078: ret

  .method SettingsUIHelper::OnDisable()  // token 0x060011BE rva 0x55e55 attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call ISaveServices Thronefall.SaveServices.SaveServicesLocator::get_Instance()  /*0x06003DE2*/
    IL_0005: callvirt void Thronefall.SaveServices.ISaveServices::SavePlayerPrefs()  /*0x06003DDF*/
    IL_000a: ret

  .method SettingsUIHelper::.ctor()  // token 0x060011BF rva 0x55e61 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab>::.ctor()  /*0x0A000715*/
    IL_0006: stfld Dictionary<ThronefallUIElement, SettingsUIHelper.SettingsTab> SettingsUIHelper::allTabs  /*0x04001581*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== SettingsUIHelper/SettingsTab  (token 0x02000341) =====
  .method SettingsUIHelper.SettingsTab::ComputeNavigationForSettingsTab()  // token 0x060011C0 rva 0x55e74 attrs Public, HideBySig
    // code size 240 (0xf0), max stack 4, init locals
    .locals ([0] List<ThronefallUIElement>, [1] IEnumerator, [2] Transform, [3] IDisposable, [4] int, [5] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldfld bool SettingsUIHelper.SettingsTab::disableNavigationProcessing  /*0x04001585*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_000e: stloc.0
    IL_000f: ldarg.0
    IL_0010: ldfld VerticalLayoutGroup SettingsUIHelper.SettingsTab::childContainer  /*0x04001584*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_001f: stloc.1
    IL_0020: br.s IL_003a
    IL_0022: ldloc.1
    IL_0023: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0028: castclass UnityEngine.Transform  /*0x01000015*/
    IL_002d: stloc.2
    IL_002e: ldloc.0
    IL_002f: ldloc.2
    IL_0030: callvirt !!0 UnityEngine.Component::GetComponent()<ThronefallUIElement>  /*0x2B000105*/
    IL_0035: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_003a: ldloc.1
    IL_003b: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0040: brtrue.s IL_0022
    IL_0042: leave.s IL_0055
    IL_0044: ldloc.1
    IL_0045: isinst System.IDisposable  /*0x0100001B*/
    IL_004a: stloc.3
    IL_004b: ldloc.3
    IL_004c: brfalse.s IL_0054
    IL_004e: ldloc.3
    IL_004f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0054: endfinally
    IL_0055: ldarg.0
    IL_0056: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_005b: ldloc.0
    IL_005c: ldc.i4.0
    IL_005d: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0062: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0067: ldarg.0
    IL_0068: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_006d: ldloc.0
    IL_006e: ldloc.0
    IL_006f: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0074: ldc.i4.1
    IL_0075: sub
    IL_0076: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_007b: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0080: ldc.i4.0
    IL_0081: stloc.s 4
    IL_0083: br.s IL_00e5
    IL_0085: ldloc.0
    IL_0086: ldloc.s 4
    IL_0088: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_008d: stloc.s 5
    IL_008f: ldloc.s 4
    IL_0091: brtrue.s IL_00a2
    IL_0093: ldloc.s 5
    IL_0095: ldarg.0
    IL_0096: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_009b: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00a0: br.s IL_00b3
    IL_00a2: ldloc.s 5
    IL_00a4: ldloc.0
    IL_00a5: ldloc.s 4
    IL_00a7: ldc.i4.1
    IL_00a8: sub
    IL_00a9: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00ae: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_00b3: ldloc.s 4
    IL_00b5: ldloc.0
    IL_00b6: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_00bb: ldc.i4.1
    IL_00bc: sub
    IL_00bd: bne.un.s IL_00ce
    IL_00bf: ldloc.s 5
    IL_00c1: ldarg.0
    IL_00c2: ldfld TFUITextButton SettingsUIHelper.SettingsTab::parentElement  /*0x04001582*/
    IL_00c7: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00cc: br.s IL_00df
    IL_00ce: ldloc.s 5
    IL_00d0: ldloc.0
    IL_00d1: ldloc.s 4
    IL_00d3: ldc.i4.1
    IL_00d4: add
    IL_00d5: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00da: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00df: ldloc.s 4
    IL_00e1: ldc.i4.1
    IL_00e2: add
    IL_00e3: stloc.s 4
    IL_00e5: ldloc.s 4
    IL_00e7: ldloc.0
    IL_00e8: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_00ed: blt.s IL_0085
    IL_00ef: ret
    .try IL_0020-IL_0044 finally handler IL_0044-IL_0055

  .method SettingsUIHelper.SettingsTab::.ctor()  // token 0x060011C1 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

