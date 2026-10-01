// ===== DemoQuitSwitch  (token 0x020002F3) =====
  .method DemoQuitSwitch::Trigger()  // token 0x0600104A rva 0x4a45f attrs Public, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0005: callvirt void UIFrameManager::QuitToDesktop()  /*0x0600130C*/
    IL_000a: ret

  .method DemoQuitSwitch::.ctor()  // token 0x0600104B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

