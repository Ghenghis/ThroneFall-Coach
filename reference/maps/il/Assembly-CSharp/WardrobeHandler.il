// ===== WardrobeHandler  (token 0x02000380) =====
  .method WardrobeHandler::Awake()  // token 0x06001348 rva 0x5b93c attrs Private, HideBySig
    // code size 187 (0xbb), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_0006: ldarg.0
    IL_0007: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::crownTab  /*0x04001757*/
    IL_000c: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_0011: ldarg.0
    IL_0012: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::crownTab  /*0x04001757*/
    IL_0017: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::Add(!0,!1)  /*0x0A000758*/
    IL_001c: ldarg.0
    IL_001d: ldfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_0022: ldarg.0
    IL_0023: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::armourTab  /*0x04001758*/
    IL_0028: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_002d: ldarg.0
    IL_002e: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::armourTab  /*0x04001758*/
    IL_0033: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::Add(!0,!1)  /*0x0A000758*/
    IL_0038: ldarg.0
    IL_0039: ldfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_003e: ldarg.0
    IL_003f: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::mountTab  /*0x04001759*/
    IL_0044: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_0049: ldarg.0
    IL_004a: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::mountTab  /*0x04001759*/
    IL_004f: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::Add(!0,!1)  /*0x0A000758*/
    IL_0054: ldarg.0
    IL_0055: ldfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_005a: ldarg.0
    IL_005b: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::capeTab  /*0x0400175A*/
    IL_0060: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_0065: ldarg.0
    IL_0066: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::capeTab  /*0x0400175A*/
    IL_006b: callvirt void System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::Add(!0,!1)  /*0x0A000758*/
    IL_0070: ldarg.0
    IL_0071: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::crownTab  /*0x04001757*/
    IL_0076: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_007b: ldc.i4.0
    IL_007c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0081: ldarg.0
    IL_0082: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::armourTab  /*0x04001758*/
    IL_0087: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_008c: ldc.i4.0
    IL_008d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0092: ldarg.0
    IL_0093: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::mountTab  /*0x04001759*/
    IL_0098: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_009d: ldc.i4.0
    IL_009e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::capeTab  /*0x0400175A*/
    IL_00a9: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_00ae: ldc.i4.0
    IL_00af: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00b4: ldarg.0
    IL_00b5: call void WardrobeHandler::RecomputeAllNavigation()  /*0x06001349*/
    IL_00ba: ret

  .method WardrobeHandler::RecomputeAllNavigation()  // token 0x06001349 rva 0x5ba03 attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::crownTab  /*0x04001757*/
    IL_0006: callvirt void WardrobeHandler.WardrobeTab::ComputeNavigationForSettingsTab()  /*0x06001357*/
    IL_000b: ldarg.0
    IL_000c: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::armourTab  /*0x04001758*/
    IL_0011: callvirt void WardrobeHandler.WardrobeTab::ComputeNavigationForSettingsTab()  /*0x06001357*/
    IL_0016: ldarg.0
    IL_0017: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::mountTab  /*0x04001759*/
    IL_001c: callvirt void WardrobeHandler.WardrobeTab::ComputeNavigationForSettingsTab()  /*0x06001357*/
    IL_0021: ldarg.0
    IL_0022: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::capeTab  /*0x0400175A*/
    IL_0027: callvirt void WardrobeHandler.WardrobeTab::ComputeNavigationForSettingsTab()  /*0x06001357*/
    IL_002c: ret

  .method WardrobeHandler::OnSelect()  // token 0x0600134A rva 0x5ba34 attrs Public, HideBySig
    // code size 176 (0xb0), max stack 3, init locals
    .locals ([0] WardrobeHandler.WardrobeTab)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_0008: ldarg.0
    IL_0009: ldfld UIFrame WardrobeHandler::targetFrame  /*0x04001752*/
    IL_000e: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0013: ldloca.s 0
    IL_0015: callvirt bool System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::TryGetValue(!0,ref !1)  /*0x0A000759*/
    IL_001a: brfalse.s IL_0096
    IL_001c: ldarg.0
    IL_001d: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_0022: brfalse.s IL_0046
    IL_0024: ldarg.0
    IL_0025: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_002a: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_002f: ldc.i4.0
    IL_0030: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0035: ldarg.0
    IL_0036: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_003b: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_0040: ldc.i4.0
    IL_0041: stfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_0046: ldarg.0
    IL_0047: ldloc.0
    IL_0048: stfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_004d: ldarg.0
    IL_004e: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_0053: ldfld GameObject WardrobeHandler.WardrobeTab::contentParent  /*0x0400175F*/
    IL_0058: ldc.i4.1
    IL_0059: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005e: ldarg.0
    IL_005f: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_0064: ldfld WardrobeOptionsHelper WardrobeHandler.WardrobeTab::Options  /*0x04001760*/
    IL_0069: callvirt TFUIWardrobeItemElement WardrobeOptionsHelper::get_SelectedMesh()  /*0x0600135D*/
    IL_006e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0073: brfalse.s IL_00af
    IL_0075: ldarg.0
    IL_0076: ldfld WardrobeInfo WardrobeHandler::wardrobeInfo  /*0x0400175B*/
    IL_007b: ldarg.0
    IL_007c: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_0081: ldfld WardrobeOptionsHelper WardrobeHandler.WardrobeTab::Options  /*0x04001760*/
    IL_0086: callvirt TFUIWardrobeItemElement WardrobeOptionsHelper::get_SelectedMesh()  /*0x0600135D*/
    IL_008b: callvirt WardrobeItem TFUIWardrobeItemElement::get_WardrobeItem()  /*0x06001341*/
    IL_0090: callvirt void WardrobeInfo::SetInfo(WardrobeItem)  /*0x06001359*/
    IL_0095: ret
    IL_0096: ldarg.0
    IL_0097: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_009c: brfalse.s IL_00af
    IL_009e: ldarg.0
    IL_009f: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_00a4: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_00a9: ldc.i4.1
    IL_00aa: stfld bool TFUITextButton::applyOverrideStyle  /*0x04001633*/
    IL_00af: ret

  .method WardrobeHandler::Refresh()  // token 0x0600134B rva 0x5baf0 attrs Public, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld WardrobeOptionsHelper WardrobeHandler::crownOptions  /*0x04001753*/
    IL_0006: callvirt void WardrobeOptionsHelper::RefreshElements()  /*0x0600135E*/
    IL_000b: ldarg.0
    IL_000c: ldfld WardrobeOptionsHelper WardrobeHandler::bodyArmourOption  /*0x04001754*/
    IL_0011: callvirt void WardrobeOptionsHelper::RefreshElements()  /*0x0600135E*/
    IL_0016: ldarg.0
    IL_0017: ldfld WardrobeOptionsHelper WardrobeHandler::horseArmourOptions  /*0x04001755*/
    IL_001c: callvirt void WardrobeOptionsHelper::RefreshElements()  /*0x0600135E*/
    IL_0021: ldarg.0
    IL_0022: ldfld WardrobeOptionsHelper WardrobeHandler::capeOptions  /*0x04001756*/
    IL_0027: callvirt void WardrobeOptionsHelper::RefreshElements()  /*0x0600135E*/
    IL_002c: ret

  .method WardrobeHandler::SetUpNavigation(System.Collections.Generic.List<TFUIWardrobeElement>)  // token 0x0600134C rva 0x5bb20 attrs Private, HideBySig
    // code size 115 (0x73), max stack 4, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldarg.1
    IL_0001: callvirt int System.Collections.Generic.List<TFUIWardrobeElement>::get_Count()  /*0x0A00075A*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_006e
    IL_000b: ldloc.1
    IL_000c: ldloc.0
    IL_000d: ldc.i4.1
    IL_000e: sub
    IL_000f: beq.s IL_0028
    IL_0011: ldarg.1
    IL_0012: ldloc.1
    IL_0013: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_0018: ldarg.1
    IL_0019: ldloc.1
    IL_001a: ldc.i4.1
    IL_001b: add
    IL_001c: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_0021: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0026: br.s IL_003b
    IL_0028: ldarg.1
    IL_0029: ldloc.1
    IL_002a: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_002f: ldarg.1
    IL_0030: ldc.i4.0
    IL_0031: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_0036: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_003b: ldloc.1
    IL_003c: brfalse.s IL_0055
    IL_003e: ldarg.1
    IL_003f: ldloc.1
    IL_0040: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_0045: ldarg.1
    IL_0046: ldloc.1
    IL_0047: ldc.i4.1
    IL_0048: sub
    IL_0049: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_004e: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0053: br.s IL_006a
    IL_0055: ldarg.1
    IL_0056: ldloc.1
    IL_0057: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_005c: ldarg.1
    IL_005d: ldloc.0
    IL_005e: ldc.i4.1
    IL_005f: sub
    IL_0060: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_0065: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_006a: ldloc.1
    IL_006b: ldc.i4.1
    IL_006c: add
    IL_006d: stloc.1
    IL_006e: ldloc.1
    IL_006f: ldloc.0
    IL_0070: blt.s IL_000b
    IL_0072: ret

  .method WardrobeHandler::TrySelectTFUIElement()  // token 0x0600134D rva 0x5bba0 attrs Public, HideBySig
    // code size 95 (0x5f), max stack 2, init locals
    .locals ([0] TFUIWardrobeElement)
    IL_0000: ldarg.0
    IL_0001: ldfld UIFrame WardrobeHandler::targetFrame  /*0x04001752*/
    IL_0006: callvirt ThronefallUIElement UIFrame::get_LastApplied()  /*0x060012E8*/
    IL_000b: isinst TFUIWardrobeElement  /*0x0200037B*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_001b
    IL_001a: ret
    IL_001b: ldloc.0
    IL_001c: callvirt bool TFUIWardrobeElement::get_Locked()  /*0x0600132D*/
    IL_0021: brfalse.s IL_0024
    IL_0023: ret
    IL_0024: ldarg.0
    IL_0025: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_002a: brtrue.s IL_002d
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_0033: ldfld WardrobeOptionsHelper WardrobeHandler.WardrobeTab::Options  /*0x04001760*/
    IL_0038: ldloc.0
    IL_0039: callvirt void WardrobeOptionsHelper::TrySelectTFUIElement(TFUIWardrobeElement)  /*0x06001360*/
    IL_003e: ldarg.0
    IL_003f: ldfld WardrobeInfo WardrobeHandler::wardrobeInfo  /*0x0400175B*/
    IL_0044: ldarg.0
    IL_0045: ldfld WardrobeHandler.WardrobeTab WardrobeHandler::currentSelectedTab  /*0x0400175D*/
    IL_004a: ldfld WardrobeOptionsHelper WardrobeHandler.WardrobeTab::Options  /*0x04001760*/
    IL_004f: callvirt TFUIWardrobeItemElement WardrobeOptionsHelper::get_SelectedMesh()  /*0x0600135D*/
    IL_0054: callvirt WardrobeItem TFUIWardrobeItemElement::get_WardrobeItem()  /*0x06001341*/
    IL_0059: callvirt void WardrobeInfo::SetInfo(WardrobeItem)  /*0x06001359*/
    IL_005e: ret

  .method WardrobeHandler::ApplyMat(UnityEngine.Material,TFUIWardrobeElement)  // token 0x0600134E rva 0x5bc0b attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.2
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.2
    IL_000b: callvirt bool TFUIWardrobeElement::get_Locked()  /*0x0600132D*/
    IL_0010: brfalse.s IL_0013
    IL_0012: ret
    IL_0013: ldarg.1
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001a: pop
    IL_001b: ret

  .method WardrobeHandler::SetCrownMat(UnityEngine.Material)  // token 0x0600134F rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetBodyArmourMat(UnityEngine.Material)  // token 0x06001350 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetHorseArmourMat(UnityEngine.Material)  // token 0x06001351 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetCapeMat(UnityEngine.Material)  // token 0x06001352 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetCrownVersion(int)  // token 0x06001353 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetBodyVersion(int)  // token 0x06001354 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::SetCapeVersion(int)  // token 0x06001355 rva 0x25f1 attrs Public, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method WardrobeHandler::.ctor()  // token 0x06001356 rva 0x5bc28 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab>::.ctor()  /*0x0A00075C*/
    IL_0006: stfld Dictionary<ThronefallUIElement, WardrobeHandler.WardrobeTab> WardrobeHandler::allTabs  /*0x0400175C*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== WardrobeHandler/WardrobeTab  (token 0x02000381) =====
  .method WardrobeHandler.WardrobeTab::ComputeNavigationForSettingsTab()  // token 0x06001357 rva 0x5bc3c attrs Public, HideBySig
    // code size 240 (0xf0), max stack 4, init locals
    .locals ([0] List<ThronefallUIElement>, [1] IEnumerator, [2] Transform, [3] IDisposable, [4] int, [5] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldfld bool WardrobeHandler.WardrobeTab::disableNavigationProcessing  /*0x04001762*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_000e: stloc.0
    IL_000f: ldarg.0
    IL_0010: ldfld HorizontalLayoutGroup WardrobeHandler.WardrobeTab::childContainer  /*0x04001761*/
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
    IL_0056: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
    IL_005b: ldloc.0
    IL_005c: ldc.i4.0
    IL_005d: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0062: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0067: ldarg.0
    IL_0068: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
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
    IL_0096: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
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
    IL_00c2: ldfld TFUITextButton WardrobeHandler.WardrobeTab::parentElement  /*0x0400175E*/
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

  .method WardrobeHandler.WardrobeTab::.ctor()  // token 0x06001358 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

