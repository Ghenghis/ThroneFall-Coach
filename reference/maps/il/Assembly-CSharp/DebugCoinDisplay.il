// ===== DebugCoinDisplay  (token 0x020000B1) =====
  .method DebugCoinDisplay::Start()  // token 0x060003CC rva 0x10d37 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Object::FindObjectOfType()<PlayerInteraction>  /*0x2B000030*/
    IL_0006: stfld PlayerInteraction DebugCoinDisplay::player  /*0x040004CF*/
    IL_000b: ret

  .method DebugCoinDisplay::Update()  // token 0x060003CD rva 0x10d44 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TextMeshProUGUI DebugCoinDisplay::target  /*0x040004CE*/
    IL_0006: ldarg.0
    IL_0007: ldfld PlayerInteraction DebugCoinDisplay::player  /*0x040004CF*/
    IL_000c: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0011: stloc.0
    IL_0012: ldloca.s 0
    IL_0014: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0019: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_001e: ret

  .method DebugCoinDisplay::.ctor()  // token 0x060003CE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

