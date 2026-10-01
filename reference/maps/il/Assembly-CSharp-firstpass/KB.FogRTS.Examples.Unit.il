// ===== KB.FogRTS.Examples.Unit  (token 0x02000009) =====
  .method KB.FogRTS.Examples.Unit::SetTargetPosition(UnityEngine.Vector3)  // token 0x0600001A rva 0x2701 attrs Public, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector3 KB.FogRTS.Examples.Unit::targetPosition  /*0x0400001B*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool KB.FogRTS.Examples.Unit::ignoreY  /*0x04000019*/
    IL_000d: brfalse.s IL_002a
    IL_000f: ldarg.0
    IL_0010: ldflda Vector3 KB.FogRTS.Examples.Unit::targetPosition  /*0x0400001B*/
    IL_0015: ldarg.0
    IL_0016: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_001b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_0020: ldfld float UnityEngine.Vector3::y  /*0x0A000017*/
    IL_0025: stfld float UnityEngine.Vector3::y  /*0x0A000017*/
    IL_002a: ldarg.0
    IL_002b: ldc.i4.1
    IL_002c: stfld bool KB.FogRTS.Examples.Unit::isMoving  /*0x0400001C*/
    IL_0031: ret

  .method KB.FogRTS.Examples.Unit::Update()  // token 0x0600001B rva 0x2734 attrs Private, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Examples.Unit::isMoving  /*0x0400001C*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void KB.FogRTS.Examples.Unit::MoveToTarget()  /*0x0600001C*/
    IL_000e: ret

  .method KB.FogRTS.Examples.Unit::MoveToTarget()  // token 0x0600001C rva 0x2744 attrs Private, HideBySig
    // code size 77 (0x4d), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_0011: ldarg.0
    IL_0012: ldfld Vector3 KB.FogRTS.Examples.Unit::targetPosition  /*0x0400001B*/
    IL_0017: ldarg.0
    IL_0018: ldfld float KB.FogRTS.Examples.Unit::speed  /*0x0400001A*/
    IL_001d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000010*/
    IL_0022: mul
    IL_0023: call Vector3 UnityEngine.Vector3::MoveTowards(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A00005A*/
    IL_0028: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A000013*/
    IL_002d: ldarg.0
    IL_002e: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_0038: ldarg.0
    IL_0039: ldfld Vector3 KB.FogRTS.Examples.Unit::targetPosition  /*0x0400001B*/
    IL_003e: call bool UnityEngine.Vector3::op_Equality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00005B*/
    IL_0043: brfalse.s IL_004c
    IL_0045: ldarg.0
    IL_0046: ldc.i4.0
    IL_0047: stfld bool KB.FogRTS.Examples.Unit::isMoving  /*0x0400001C*/
    IL_004c: ret

  .method KB.FogRTS.Examples.Unit::.ctor()  // token 0x0600001D rva 0x279d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float KB.FogRTS.Examples.Unit::speed  /*0x0400001A*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0011: ret

