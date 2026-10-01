// ===== EnableAllChildren  (token 0x02000134) =====
  .method EnableAllChildren::Start()  // token 0x06000668 rva 0x1ae5c attrs Private, HideBySig
    // code size 46 (0x2e), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_001f
    IL_0004: ldarg.0
    IL_0005: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: ldloc.0
    IL_000b: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0010: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001b: ldloc.0
    IL_001c: ldc.i4.1
    IL_001d: add
    IL_001e: stloc.0
    IL_001f: ldloc.0
    IL_0020: ldarg.0
    IL_0021: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0026: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_002b: blt.s IL_0004
    IL_002d: ret

  .method EnableAllChildren::.ctor()  // token 0x06000669 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

