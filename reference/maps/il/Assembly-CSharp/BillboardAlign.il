// ===== BillboardAlign  (token 0x0200007F) =====
  .method BillboardAlign::Start()  // token 0x06000283 rva 0xb48c attrs Private, HideBySig
    // code size 72 (0x48), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BillboardAlign::negativeZ  /*0x04000357*/
    IL_0006: brfalse.s IL_0023
    IL_0008: ldarg.0
    IL_0009: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000e: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_0013: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_001d: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0022: ret
    IL_0023: ldarg.0
    IL_0024: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0029: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_002e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0038: ldc.r4 -1f
    IL_003d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0042: callvirt void UnityEngine.Transform::set_forward(UnityEngine.Vector3)  /*0x0A0000AF*/
    IL_0047: ret

  .method BillboardAlign::.ctor()  // token 0x06000284 rva 0xb4e0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BillboardAlign::negativeZ  /*0x04000357*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

