// ===== SetStateWhenMacOSX  (token 0x0200026A) =====
  .method SetStateWhenMacOSX::Awake()  // token 0x06000D58 rva 0x3d202 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool SetStateWhenMacOSX::activeElsewhere  /*0x04000FDB*/
    IL_000c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0011: ret

  .method SetStateWhenMacOSX::.ctor()  // token 0x06000D59 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

