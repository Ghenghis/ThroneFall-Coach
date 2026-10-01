// ===== OverworldPauseFrame  (token 0x0200032B) =====
  .method OverworldPauseFrame::get_IsInDLCLevelSelect()  // token 0x06001176 rva 0x53033 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool OverworldPauseFrame::isInDLCLevelSelect  /*0x040014F2*/
    IL_0006: ret

  .method OverworldPauseFrame::SetIsInDLCLevelSelect(bool)  // token 0x06001177 rva 0x5303b attrs Public, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool OverworldPauseFrame::isInDLCLevelSelect  /*0x040014F2*/
    IL_0007: ldarg.0
    IL_0008: ldfld GameObject OverworldPauseFrame::ReturntoLevelSelectButton  /*0x040014F1*/
    IL_000d: ldarg.0
    IL_000e: ldfld bool OverworldPauseFrame::isInDLCLevelSelect  /*0x040014F2*/
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret

  .method OverworldPauseFrame::.ctor()  // token 0x06001178 rva 0x53055 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UIFrame::.ctor()  /*0x060012F8*/
    IL_0006: ret

