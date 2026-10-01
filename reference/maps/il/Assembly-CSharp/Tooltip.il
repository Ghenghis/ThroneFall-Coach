// ===== Tooltip  (token 0x0200036B) =====
  .method Tooltip::get_currentText()  // token 0x060012C8 rva 0x593f7 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI Tooltip::content  /*0x0400169F*/
    IL_0006: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_000b: ret

  .method Tooltip::Awake()  // token 0x060012C9 rva 0x59404 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_000b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0010: ldarg.0
    IL_0011: ldfld TextMeshProUGUI Tooltip::content  /*0x0400169F*/
    IL_0016: ldstr ""
    IL_001b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0020: ret

  .method Tooltip::SetTooltip(string)  // token 0x060012CA rva 0x59428 attrs Public, HideBySig
    // code size 144 (0x90), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld TextMeshProUGUI Tooltip::content  /*0x0400169F*/
    IL_0007: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_000c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0011: brfalse.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld MMF_Player Tooltip::onOpen  /*0x040016A1*/
    IL_001a: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_001f: ldarg.0
    IL_0020: ldfld MMF_Player Tooltip::onClose  /*0x040016A2*/
    IL_0025: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_002a: ldarg.0
    IL_002b: ldfld MMF_Player Tooltip::onUpdate  /*0x040016A3*/
    IL_0030: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0035: ldarg.0
    IL_0036: ldfld TextMeshProUGUI Tooltip::content  /*0x0400169F*/
    IL_003b: ldarg.1
    IL_003c: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0041: ldarg.1
    IL_0042: ldstr ""
    IL_0047: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_004c: brfalse.s IL_005a
    IL_004e: ldarg.0
    IL_004f: ldfld MMF_Player Tooltip::onClose  /*0x040016A2*/
    IL_0054: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0059: ret
    IL_005a: ldarg.0
    IL_005b: ldfld TextMeshProUGUI Tooltip::content  /*0x0400169F*/
    IL_0060: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0065: ldstr ""
    IL_006a: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_006f: brfalse.s IL_007e
    IL_0071: ldarg.0
    IL_0072: ldfld MMF_Player Tooltip::onOpen  /*0x040016A1*/
    IL_0077: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_007c: br.s IL_0089
    IL_007e: ldarg.0
    IL_007f: ldfld MMF_Player Tooltip::onUpdate  /*0x040016A3*/
    IL_0084: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0089: ldarg.0
    IL_008a: call void Tooltip::UpdateSize()  /*0x060012CB*/
    IL_008f: ret

  .method Tooltip::UpdateSize()  // token 0x060012CB rva 0x594c4 attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.RectTransform>  /*0x2B0000D8*/
    IL_0006: ldarg.0
    IL_0007: ldfld RectTransform Tooltip::targetRect  /*0x040016A0*/
    IL_000c: call void UnityEngine.UI.LayoutRebuilder::ForceRebuildLayoutImmediate(UnityEngine.RectTransform)  /*0x0A000641*/
    IL_0011: ldarg.0
    IL_0012: ldfld RectTransform Tooltip::targetRect  /*0x040016A0*/
    IL_0017: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_001c: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0021: ret

  .method Tooltip::.ctor()  // token 0x060012CC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

