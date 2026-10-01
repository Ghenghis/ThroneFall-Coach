// ===== WardrobeInfo  (token 0x02000382) =====
  .method WardrobeInfo::SetInfo(WardrobeItem)  // token 0x06001359 rva 0x5bd48 attrs Public, HideBySig
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld TextMeshProUGUI WardrobeInfo::itemName  /*0x04001763*/
    IL_0010: ldarg.1
    IL_0011: ldfld string WardrobeItem::itemName  /*0x04001769*/
    IL_0016: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_001b: ldarg.0
    IL_001c: ldfld TextMeshProUGUI WardrobeInfo::itemDesc  /*0x04001764*/
    IL_0021: ldarg.1
    IL_0022: ldfld string WardrobeItem::desc  /*0x0400176A*/
    IL_0027: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_002c: ldarg.0
    IL_002d: ldfld TextMeshProUGUI WardrobeInfo::crownRequirment  /*0x04001765*/
    IL_0032: ldarg.1
    IL_0033: ldflda int WardrobeItem::crownRequirment  /*0x0400176B*/
    IL_0038: call string System.Int32::ToString()  /*0x0A000031*/
    IL_003d: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0042: ldarg.0
    IL_0043: ldfld RawImage WardrobeInfo::itemImage  /*0x04001766*/
    IL_0048: ldarg.1
    IL_0049: ldfld Texture WardrobeItem::image  /*0x04001768*/
    IL_004e: callvirt void UnityEngine.UI.RawImage::set_texture(UnityEngine.Texture)  /*0x0A00075D*/
    IL_0053: ret

  .method WardrobeInfo::.ctor()  // token 0x0600135A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

