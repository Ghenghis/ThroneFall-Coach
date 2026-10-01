// ===== FollowTransform  (token 0x0200016B) =====
  .method FollowTransform::Update()  // token 0x06000768 rva 0x2513c attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform FollowTransform::target  /*0x0400094D*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0023
    IL_000d: ldarg.0
    IL_000e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0013: ldarg.0
    IL_0014: ldfld Transform FollowTransform::target  /*0x0400094D*/
    IL_0019: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0023: ret

  .method FollowTransform::.ctor()  // token 0x06000769 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

