// ===== Docker  (token 0x02000105) =====
  .method Docker::get_DockPosition()  // token 0x06000560 rva 0x17601 attrs Public, HideBySig, SpecialName
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Docker::dockTransform  /*0x040006F2*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brtrue.s IL_001a
    IL_000e: ldarg.0
    IL_000f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0014: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldfld Transform Docker::dockTransform  /*0x040006F2*/
    IL_0020: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0025: ret

  .method Docker::Open()  // token 0x06000561 rva 0x17628 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Docker::blockersRoot  /*0x040006F3*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method Docker::Close()  // token 0x06000562 rva 0x17636 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Docker::blockersRoot  /*0x040006F3*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method Docker::InitialClose()  // token 0x06000563 rva 0x17636 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Docker::blockersRoot  /*0x040006F3*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method Docker::InitialOpen()  // token 0x06000564 rva 0x17628 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Docker::blockersRoot  /*0x040006F3*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method Docker::GetTeleportPoint()  // token 0x06000565 rva 0x17644 attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Docker::teleportPoint  /*0x040006F4*/
    IL_0006: ret

  .method Docker::.ctor()  // token 0x06000566 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

