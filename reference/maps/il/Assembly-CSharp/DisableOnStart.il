// ===== DisableOnStart  (token 0x020000B8) =====
  .method DisableOnStart::Start()  // token 0x060003E9 rva 0x1125f attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method DisableOnStart::.ctor()  // token 0x060003EA rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

