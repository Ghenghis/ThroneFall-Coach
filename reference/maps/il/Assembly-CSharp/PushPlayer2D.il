// ===== PushPlayer2D  (token 0x0200024E) =====
  .method PushPlayer2D::Start()  // token 0x06000C9F rva 0x39e75 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0006: stfld PlayerMovement PushPlayer2D::pm  /*0x04000F4B*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld PlayerMovement PushPlayer2D::pm  /*0x04000F4B*/
    IL_0012: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0017: stfld Transform PushPlayer2D::ptrans  /*0x04000F4C*/
    IL_001c: ret

  .method PushPlayer2D::Update()  // token 0x06000CA0 rva 0x39e94 attrs Private, HideBySig
    // code size 145 (0x91), max stack 5, init locals
    .locals ([0] Vector3, [1] float, [2] Vector3)
    IL_0000: ldloca.s 0
    IL_0002: ldarg.0
    IL_0003: ldfld Transform PushPlayer2D::ptrans  /*0x04000F4C*/
    IL_0008: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000d: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001d: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0022: sub
    IL_0023: ldc.r4 0f
    IL_0028: ldarg.0
    IL_0029: ldfld Transform PushPlayer2D::ptrans  /*0x04000F4C*/
    IL_002e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0033: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0038: ldarg.0
    IL_0039: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0048: sub
    IL_0049: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_004e: ldloca.s 0
    IL_0050: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0055: stloc.1
    IL_0056: ldloc.1
    IL_0057: ldarg.0
    IL_0058: ldfld float PushPlayer2D::ensureDistance  /*0x04000F4D*/
    IL_005d: bge.un.s IL_0090
    IL_005f: ldloca.s 0
    IL_0061: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0066: stloc.2
    IL_0067: ldarg.0
    IL_0068: ldfld PlayerMovement PushPlayer2D::pm  /*0x04000F4B*/
    IL_006d: ldarg.0
    IL_006e: ldfld Transform PushPlayer2D::ptrans  /*0x04000F4C*/
    IL_0073: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0078: ldloc.2
    IL_0079: ldarg.0
    IL_007a: ldfld float PushPlayer2D::ensureDistance  /*0x04000F4D*/
    IL_007f: ldloc.1
    IL_0080: sub
    IL_0081: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0086: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_008b: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_0090: ret

  .method PushPlayer2D::.ctor()  // token 0x06000CA1 rva 0x39f31 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float PushPlayer2D::ensureDistance  /*0x04000F4D*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

