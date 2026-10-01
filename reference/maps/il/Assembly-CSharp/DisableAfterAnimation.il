// ===== DisableAfterAnimation  (token 0x02000023) =====
  .method DisableAfterAnimation::DisableObject()  // token 0x060000C0 rva 0x5443 attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0010: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0015: ldc.i4.0
    IL_0016: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001b: ret

  .method DisableAfterAnimation::.ctor()  // token 0x060000C1 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

