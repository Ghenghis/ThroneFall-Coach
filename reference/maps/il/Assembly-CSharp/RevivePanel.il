// ===== RevivePanel  (token 0x0200033A) =====
  .method RevivePanel::Update()  // token 0x060011A8 rva 0x557f0 attrs Private, HideBySig
    // code size 117 (0x75), max stack 4, init locals
    .locals ([0] float, [1] float)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoRevive RevivePanel::playerReviveComponent  /*0x04001560*/
    IL_0006: callvirt float AutoRevive::get_TimeTillRevive()  /*0x06000269*/
    IL_000b: stloc.0
    IL_000c: ldloc.0
    IL_000d: ldc.r4 0f
    IL_0012: ble.un.s IL_0068
    IL_0014: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0019: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_001e: ldc.i4.1
    IL_001f: bne.un.s IL_0068
    IL_0021: ldarg.0
    IL_0022: ldfld GameObject RevivePanel::revivePanel  /*0x0400155D*/
    IL_0027: ldc.i4.1
    IL_0028: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002d: ldarg.0
    IL_002e: ldfld TMP_Text RevivePanel::counterText  /*0x0400155E*/
    IL_0033: ldloc.0
    IL_0034: call float UnityEngine.Mathf::Floor(float)  /*0x0A00070C*/
    IL_0039: stloc.1
    IL_003a: ldloca.s 1
    IL_003c: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0041: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0046: ldarg.0
    IL_0047: ldfld MPImage RevivePanel::fill  /*0x0400155F*/
    IL_004c: ldarg.0
    IL_004d: ldfld AutoRevive RevivePanel::playerReviveComponent  /*0x04001560*/
    IL_0052: ldfld float AutoRevive::reviveAfterBeingKnockedOutFor  /*0x04000334*/
    IL_0057: ldc.r4 0f
    IL_005c: ldloc.0
    IL_005d: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0062: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0067: ret
    IL_0068: ldarg.0
    IL_0069: ldfld GameObject RevivePanel::revivePanel  /*0x0400155D*/
    IL_006e: ldc.i4.0
    IL_006f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0074: ret

  .method RevivePanel::.ctor()  // token 0x060011A9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

