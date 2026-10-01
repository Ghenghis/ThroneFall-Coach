// ===== EternalTrialsMapPreview  (token 0x02000309) =====
  .method EternalTrialsMapPreview::SetData(System.Collections.Generic.List<WaveInfo>,int)  // token 0x060010CF rva 0x4d968 attrs Public, HideBySig
    // code size 220 (0xdc), max stack 3, init locals
    .locals ([0] int, [1] List.Enumerator<NightPreviewElement>, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<NightPreviewElement>::GetEnumerator()  /*0x0A00066E*/
    IL_000b: stloc.1
    IL_000c: br.s IL_0020
    IL_000e: ldloca.s 1
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<NightPreviewElement>::get_Current()  /*0x0A00066F*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldloca.s 1
    IL_0022: call bool System.Collections.Generic.List.Enumerator<NightPreviewElement>::MoveNext()  /*0x0A000670*/
    IL_0027: brtrue.s IL_000e
    IL_0029: leave.s IL_0039
    IL_002b: ldloca.s 1
    IL_002d: constrained. System.Collections.Generic.List.Enumerator<NightPreviewElement>  /*0x1B000129*/
    IL_0033: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0038: endfinally
    IL_0039: ldarg.1
    IL_003a: callvirt int System.Collections.Generic.List<WaveInfo>::get_Count()  /*0x0A000671*/
    IL_003f: ldarg.0
    IL_0040: ldfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_0045: callvirt int System.Collections.Generic.List<NightPreviewElement>::get_Count()  /*0x0A000672*/
    IL_004a: sub
    IL_004b: stloc.0
    IL_004c: ldc.i4.0
    IL_004d: stloc.2
    IL_004e: br.s IL_0070
    IL_0050: ldarg.0
    IL_0051: ldfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_0056: ldarg.0
    IL_0057: ldfld NightPreviewElement EternalTrialsMapPreview::nightPreviewElementPrefab  /*0x040013EC*/
    IL_005c: ldarg.0
    IL_005d: ldfld Transform EternalTrialsMapPreview::nightPreviewParent  /*0x040013ED*/
    IL_0062: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<NightPreviewElement>  /*0x2B0000ED*/
    IL_0067: callvirt void System.Collections.Generic.List<NightPreviewElement>::Add(!0)  /*0x0A000673*/
    IL_006c: ldloc.2
    IL_006d: ldc.i4.1
    IL_006e: add
    IL_006f: stloc.2
    IL_0070: ldloc.2
    IL_0071: ldloc.0
    IL_0072: blt.s IL_0050
    IL_0074: ldc.i4.0
    IL_0075: stloc.3
    IL_0076: br.s IL_00ab
    IL_0078: ldarg.0
    IL_0079: ldfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_007e: ldloc.3
    IL_007f: callvirt !0 System.Collections.Generic.List<NightPreviewElement>::get_Item(int)  /*0x0A000674*/
    IL_0084: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0089: ldc.i4.1
    IL_008a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008f: ldarg.0
    IL_0090: ldfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_0095: ldloc.3
    IL_0096: callvirt !0 System.Collections.Generic.List<NightPreviewElement>::get_Item(int)  /*0x0A000674*/
    IL_009b: ldarg.1
    IL_009c: ldloc.3
    IL_009d: callvirt !0 System.Collections.Generic.List<WaveInfo>::get_Item(int)  /*0x0A000675*/
    IL_00a2: callvirt void NightPreviewElement::SetData(WaveInfo)  /*0x06001158*/
    IL_00a7: ldloc.3
    IL_00a8: ldc.i4.1
    IL_00a9: add
    IL_00aa: stloc.3
    IL_00ab: ldloc.3
    IL_00ac: ldarg.1
    IL_00ad: callvirt int System.Collections.Generic.List<WaveInfo>::get_Count()  /*0x0A000671*/
    IL_00b2: blt.s IL_0078
    IL_00b4: ldarg.0
    IL_00b5: ldfld TextMeshProUGUI EternalTrialsMapPreview::goldNumber  /*0x040013EF*/
    IL_00ba: ldstr "<sprite name=coin>"
    IL_00bf: ldarga.s 2
    IL_00c1: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00c6: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00cb: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld UIParentResizer EternalTrialsMapPreview::sizer  /*0x040013EE*/
    IL_00d6: callvirt void UIParentResizer::Trigger()  /*0x0600131B*/
    IL_00db: ret
    .try IL_000c-IL_002b finally handler IL_002b-IL_0039

  .method EternalTrialsMapPreview::.ctor()  // token 0x060010D0 rva 0x4da60 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<NightPreviewElement>::.ctor()  /*0x0A000676*/
    IL_0006: stfld List<NightPreviewElement> EternalTrialsMapPreview::previewElements  /*0x040013F0*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

