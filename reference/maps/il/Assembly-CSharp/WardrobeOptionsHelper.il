// ===== WardrobeOptionsHelper  (token 0x02000385) =====
  .method WardrobeOptionsHelper::get_SelectedMat()  // token 0x0600135C rva 0x5bda8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_0006: ret

  .method WardrobeOptionsHelper::get_SelectedMesh()  // token 0x0600135D rva 0x5bdb0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_0006: ret

  .method WardrobeOptionsHelper::RefreshElements()  // token 0x0600135E rva 0x5bdb8 attrs Public, HideBySig
    // code size 163 (0xa3), max stack 1, init locals
    .locals ([0] IEnumerator, [1] IDisposable)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_0006: callvirt void System.Collections.Generic.List<TFUIWardrobeElement>::Clear()  /*0x0A00075E*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_0011: callvirt void System.Collections.Generic.List<TFUIWardrobeItemElement>::Clear()  /*0x0A00075F*/
    IL_0016: ldarg.0
    IL_0017: ldfld LayoutGroup WardrobeOptionsHelper::matLayout  /*0x04001782*/
    IL_001c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0026: stloc.0
    IL_0027: br.s IL_003e
    IL_0029: ldloc.0
    IL_002a: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_002f: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0034: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0039: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_003e: ldloc.0
    IL_003f: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0044: brtrue.s IL_0029
    IL_0046: leave.s IL_0059
    IL_0048: ldloc.0
    IL_0049: isinst System.IDisposable  /*0x0100001B*/
    IL_004e: stloc.1
    IL_004f: ldloc.1
    IL_0050: brfalse.s IL_0058
    IL_0052: ldloc.1
    IL_0053: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0058: endfinally
    IL_0059: ldarg.0
    IL_005a: ldfld LayoutGroup WardrobeOptionsHelper::meshLayout  /*0x04001783*/
    IL_005f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0064: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0069: stloc.0
    IL_006a: br.s IL_0081
    IL_006c: ldloc.0
    IL_006d: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0072: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0077: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_007c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0081: ldloc.0
    IL_0082: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0087: brtrue.s IL_006c
    IL_0089: leave.s IL_009c
    IL_008b: ldloc.0
    IL_008c: isinst System.IDisposable  /*0x0100001B*/
    IL_0091: stloc.1
    IL_0092: ldloc.1
    IL_0093: brfalse.s IL_009b
    IL_0095: ldloc.1
    IL_0096: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009b: endfinally
    IL_009c: ldarg.0
    IL_009d: call void WardrobeOptionsHelper::SetupWardrobeOptions()  /*0x0600135F*/
    IL_00a2: ret
    .try IL_0027-IL_0048 finally handler IL_0048-IL_0059
    .try IL_006a-IL_008b finally handler IL_008b-IL_009c

  .method WardrobeOptionsHelper::SetupWardrobeOptions()  // token 0x0600135F rva 0x5be84 attrs Private, HideBySig
    // code size 282 (0x11a), max stack 3, init locals
    .locals ([0] List.Enumerator<Material>, [1] Material, [2] TFUIWardrobeElement, [3] List.Enumerator<WardrobeItem>, [4] WardrobeItem, [5] TFUIWardrobeItemElement)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Material> WardrobeOptionsHelper::materials  /*0x04001784*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Material>::GetEnumerator()  /*0x0A000760*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0046
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Material>::get_Current()  /*0x0A000761*/
    IL_0015: stloc.1
    IL_0016: ldarg.0
    IL_0017: ldfld TFUIWardrobeElement WardrobeOptionsHelper::UIWardrobeElement  /*0x0400177F*/
    IL_001c: ldarg.0
    IL_001d: ldfld LayoutGroup WardrobeOptionsHelper::matLayout  /*0x04001782*/
    IL_0022: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIWardrobeElement>  /*0x2B00010D*/
    IL_002c: stloc.2
    IL_002d: ldloc.2
    IL_002e: ldloc.1
    IL_002f: ldarg.0
    IL_0030: ldfld WardrobeHandler WardrobeOptionsHelper::handler  /*0x04001781*/
    IL_0035: callvirt void TFUIWardrobeElement::SetupButton(UnityEngine.Material,WardrobeHandler)  /*0x0600133A*/
    IL_003a: ldarg.0
    IL_003b: ldfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_0040: ldloc.2
    IL_0041: callvirt void System.Collections.Generic.List<TFUIWardrobeElement>::Add(!0)  /*0x0A000762*/
    IL_0046: ldloca.s 0
    IL_0048: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Material>::MoveNext()  /*0x0A000763*/
    IL_004d: brtrue.s IL_000e
    IL_004f: leave.s IL_005f
    IL_0051: ldloca.s 0
    IL_0053: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Material>  /*0x1B00015E*/
    IL_0059: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005e: endfinally
    IL_005f: ldarg.0
    IL_0060: ldfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_0065: callvirt int System.Collections.Generic.List<TFUIWardrobeElement>::get_Count()  /*0x0A00075A*/
    IL_006a: ldc.i4.0
    IL_006b: ble.s IL_008a
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: ldfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_0074: ldc.i4.0
    IL_0075: callvirt !0 System.Collections.Generic.List<TFUIWardrobeElement>::get_Item(int)  /*0x0A00075B*/
    IL_007a: stfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_007f: ldarg.0
    IL_0080: ldfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_0085: callvirt void TFUIWardrobeElement::Pick()  /*0x0600133B*/
    IL_008a: ldarg.0
    IL_008b: ldfld List<WardrobeItem> WardrobeOptionsHelper::wardrobeItems  /*0x04001785*/
    IL_0090: callvirt List.Enumerator<!0> System.Collections.Generic.List<WardrobeItem>::GetEnumerator()  /*0x0A000764*/
    IL_0095: stloc.3
    IL_0096: br.s IL_00d5
    IL_0098: ldloca.s 3
    IL_009a: call !0 System.Collections.Generic.List.Enumerator<WardrobeItem>::get_Current()  /*0x0A000765*/
    IL_009f: stloc.s 4
    IL_00a1: ldarg.0
    IL_00a2: ldfld TFUIWardrobeItemElement WardrobeOptionsHelper::UIWardrobeItemElement  /*0x04001780*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld LayoutGroup WardrobeOptionsHelper::meshLayout  /*0x04001783*/
    IL_00ad: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b2: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIWardrobeItemElement>  /*0x2B00010E*/
    IL_00b7: stloc.s 5
    IL_00b9: ldloc.s 5
    IL_00bb: ldarg.0
    IL_00bc: ldfld WardrobeHandler WardrobeOptionsHelper::handler  /*0x04001781*/
    IL_00c1: ldloc.s 4
    IL_00c3: callvirt void TFUIWardrobeItemElement::SetupButton(WardrobeHandler,WardrobeItem)  /*0x06001342*/
    IL_00c8: ldarg.0
    IL_00c9: ldfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_00ce: ldloc.s 5
    IL_00d0: callvirt void System.Collections.Generic.List<TFUIWardrobeItemElement>::Add(!0)  /*0x0A000766*/
    IL_00d5: ldloca.s 3
    IL_00d7: call bool System.Collections.Generic.List.Enumerator<WardrobeItem>::MoveNext()  /*0x0A000767*/
    IL_00dc: brtrue.s IL_0098
    IL_00de: leave.s IL_00ee
    IL_00e0: ldloca.s 3
    IL_00e2: constrained. System.Collections.Generic.List.Enumerator<WardrobeItem>  /*0x1B000160*/
    IL_00e8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ed: endfinally
    IL_00ee: ldarg.0
    IL_00ef: ldfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_00f4: callvirt int System.Collections.Generic.List<TFUIWardrobeItemElement>::get_Count()  /*0x0A000768*/
    IL_00f9: ldc.i4.0
    IL_00fa: ble.s IL_0119
    IL_00fc: ldarg.0
    IL_00fd: ldarg.0
    IL_00fe: ldfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_0103: ldc.i4.0
    IL_0104: callvirt !0 System.Collections.Generic.List<TFUIWardrobeItemElement>::get_Item(int)  /*0x0A000769*/
    IL_0109: stfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_010e: ldarg.0
    IL_010f: ldfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_0114: callvirt void TFUIWardrobeElement::Pick()  /*0x0600133B*/
    IL_0119: ret
    .try IL_000c-IL_0051 finally handler IL_0051-IL_005f
    .try IL_0096-IL_00e0 finally handler IL_00e0-IL_00ee

  .method WardrobeOptionsHelper::TrySelectTFUIElement(TFUIWardrobeElement)  // token 0x06001360 rva 0x5bfc8 attrs Public, HideBySig
    // code size 130 (0x82), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<TFUIWardrobeElement>::Contains(!0)  /*0x0A00076A*/
    IL_000c: brfalse.s IL_0034
    IL_000e: ldarg.0
    IL_000f: ldfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_0014: ldarg.1
    IL_0015: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001a: brfalse.s IL_0034
    IL_001c: ldarg.0
    IL_001d: ldfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_0022: callvirt void TFUIWardrobeElement::UnPick()  /*0x0600133C*/
    IL_0027: ldarg.1
    IL_0028: callvirt void TFUIWardrobeElement::Pick()  /*0x0600133B*/
    IL_002d: ldarg.0
    IL_002e: ldarg.1
    IL_002f: stfld TFUIWardrobeElement WardrobeOptionsHelper::selectedMat  /*0x04001788*/
    IL_0034: ldarg.1
    IL_0035: isinst TFUIWardrobeItemElement  /*0x0200037E*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0040: brfalse.s IL_0043
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_0049: ldarg.1
    IL_004a: isinst TFUIWardrobeItemElement  /*0x0200037E*/
    IL_004f: callvirt bool System.Collections.Generic.List<TFUIWardrobeItemElement>::Contains(!0)  /*0x0A00076B*/
    IL_0054: brfalse.s IL_0081
    IL_0056: ldarg.0
    IL_0057: ldfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_005c: ldarg.1
    IL_005d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0062: brfalse.s IL_0081
    IL_0064: ldarg.0
    IL_0065: ldfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_006a: callvirt void TFUIWardrobeElement::UnPick()  /*0x0600133C*/
    IL_006f: ldarg.1
    IL_0070: callvirt void TFUIWardrobeElement::Pick()  /*0x0600133B*/
    IL_0075: ldarg.0
    IL_0076: ldarg.1
    IL_0077: isinst TFUIWardrobeItemElement  /*0x0200037E*/
    IL_007c: stfld TFUIWardrobeItemElement WardrobeOptionsHelper::selectedMesh  /*0x04001789*/
    IL_0081: ret

  .method WardrobeOptionsHelper::.ctor()  // token 0x06001361 rva 0x5c056 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TFUIWardrobeElement>::.ctor()  /*0x0A00076C*/
    IL_0006: stfld List<TFUIWardrobeElement> WardrobeOptionsHelper::matList  /*0x04001786*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TFUIWardrobeItemElement>::.ctor()  /*0x0A00076D*/
    IL_0011: stfld List<TFUIWardrobeItemElement> WardrobeOptionsHelper::meshList  /*0x04001787*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

