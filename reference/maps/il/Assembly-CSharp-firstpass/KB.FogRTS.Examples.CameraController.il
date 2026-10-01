// ===== KB.FogRTS.Examples.CameraController  (token 0x02000003) =====
  .method KB.FogRTS.Examples.CameraController::Update()  // token 0x06000003 rva 0x20c0 attrs Private, HideBySig
    // code size 181 (0xb5), max stack 4, init locals
    .locals ([0] Vector3, [1] float, [2] float)
    IL_0000: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A00000B*/
    IL_0005: stloc.0
    IL_0006: ldloca.s 0
    IL_0008: ldstr "Horizontal"
    IL_000d: call float UnityEngine.Input::GetAxis(string)  /*0x0A00000C*/
    IL_0012: ldc.r4 0f
    IL_0017: ldstr "Vertical"
    IL_001c: call float UnityEngine.Input::GetAxis(string)  /*0x0A00000C*/
    IL_0021: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A00000D*/
    IL_0026: ldarg.0
    IL_0027: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_002c: dup
    IL_002d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_0032: ldarg.0
    IL_0033: ldfld float KB.FogRTS.Examples.CameraController::moveSpeed  /*0x04000001*/
    IL_0038: call float UnityEngine.Time::get_deltaTime()  /*0x0A000010*/
    IL_003d: mul
    IL_003e: ldloc.0
    IL_003f: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000011*/
    IL_0044: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000012*/
    IL_0049: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A000013*/
    IL_004e: ldarg.0
    IL_004f: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0054: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_0059: ldfld float UnityEngine.Vector3::x  /*0x0A000014*/
    IL_005e: ldarg.0
    IL_005f: ldfld float KB.FogRTS.Examples.CameraController::xMin  /*0x04000002*/
    IL_0064: ldarg.0
    IL_0065: ldfld float KB.FogRTS.Examples.CameraController::xMax  /*0x04000003*/
    IL_006a: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A000015*/
    IL_006f: stloc.1
    IL_0070: ldarg.0
    IL_0071: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0076: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_007b: ldfld float UnityEngine.Vector3::z  /*0x0A000016*/
    IL_0080: ldarg.0
    IL_0081: ldfld float KB.FogRTS.Examples.CameraController::zMin  /*0x04000004*/
    IL_0086: ldarg.0
    IL_0087: ldfld float KB.FogRTS.Examples.CameraController::zMax  /*0x04000005*/
    IL_008c: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A000015*/
    IL_0091: stloc.2
    IL_0092: ldarg.0
    IL_0093: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0098: ldloc.1
    IL_0099: ldarg.0
    IL_009a: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_009f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_00a4: ldfld float UnityEngine.Vector3::y  /*0x0A000017*/
    IL_00a9: ldloc.2
    IL_00aa: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A00000D*/
    IL_00af: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A000013*/
    IL_00b4: ret

  .method KB.FogRTS.Examples.CameraController::.ctor()  // token 0x06000004 rva 0x2181 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float KB.FogRTS.Examples.CameraController::moveSpeed  /*0x04000001*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 -10f
    IL_0011: stfld float KB.FogRTS.Examples.CameraController::xMin  /*0x04000002*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 10f
    IL_001c: stfld float KB.FogRTS.Examples.CameraController::xMax  /*0x04000003*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 -10f
    IL_0027: stfld float KB.FogRTS.Examples.CameraController::zMin  /*0x04000004*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 10f
    IL_0032: stfld float KB.FogRTS.Examples.CameraController::zMax  /*0x04000005*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_003d: ret

