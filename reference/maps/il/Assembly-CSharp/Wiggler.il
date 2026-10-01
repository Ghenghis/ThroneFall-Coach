// ===== Wiggler  (token 0x02000031) =====
  .method Wiggler::get_velocity()  // token 0x06000101 rva 0x5ff3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 Wiggler::<velocity>k__BackingField  /*0x0400012F*/
    IL_0006: ret

  .method Wiggler::set_velocity(UnityEngine.Vector3)  // token 0x06000102 rva 0x5ffb attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector3 Wiggler::<velocity>k__BackingField  /*0x0400012F*/
    IL_0007: ret

  .method Wiggler::Start()  // token 0x06000103 rva 0x6004 attrs Private, HideBySig
    // code size 98 (0x62), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001f
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0015: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_001a: stfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0026: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002b: call Quaternion UnityEngine.Quaternion::Inverse(UnityEngine.Quaternion)  /*0x0A0000A8*/
    IL_0030: ldarg.0
    IL_0031: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0036: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003b: ldarg.0
    IL_003c: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0041: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0046: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_004b: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_0050: stfld Vector3 Wiggler::parentOffset  /*0x0400012E*/
    IL_0055: ldarg.0
    IL_0056: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005b: ldnull
    IL_005c: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0061: ret

  .method Wiggler::Update()  // token 0x06000104 rva 0x6074 attrs Private, HideBySig
    // code size 256 (0x100), max stack 6, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_001f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0024: ldarg.0
    IL_0025: ldfld Transform Wiggler::parentOverride  /*0x0400012A*/
    IL_002a: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002f: ldarg.0
    IL_0030: ldfld Vector3 Wiggler::parentOffset  /*0x0400012E*/
    IL_0035: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_003a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_003f: stloc.0
    IL_0040: ldarg.0
    IL_0041: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0046: ldloc.0
    IL_0047: ldarg.0
    IL_0048: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0052: ldarg.0
    IL_0053: ldfld float Wiggler::speedDamping  /*0x0400012C*/
    IL_0058: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005d: ldarg.0
    IL_005e: ldfld float Wiggler::positionDampingMultiplyer  /*0x0400012D*/
    IL_0063: mul
    IL_0064: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0069: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_006e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0073: ldloc.0
    IL_0074: ldarg.0
    IL_0075: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0084: stloc.1
    IL_0085: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008a: ldarg.0
    IL_008b: ldfld float Wiggler::acceleration  /*0x0400012B*/
    IL_0090: mul
    IL_0091: ldloca.s 1
    IL_0093: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0098: mul
    IL_0099: stloc.2
    IL_009a: ldarg.0
    IL_009b: ldarg.0
    IL_009c: call Vector3 Wiggler::get_velocity()  /*0x06000101*/
    IL_00a1: ldloca.s 1
    IL_00a3: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00a8: ldloc.2
    IL_00a9: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00ae: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00b3: call void Wiggler::set_velocity(UnityEngine.Vector3)  /*0x06000102*/
    IL_00b8: ldarg.0
    IL_00b9: ldarg.0
    IL_00ba: call Vector3 Wiggler::get_velocity()  /*0x06000101*/
    IL_00bf: ldarg.0
    IL_00c0: ldfld float Wiggler::speedDamping  /*0x0400012C*/
    IL_00c5: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00ca: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00cf: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00d4: call void Wiggler::set_velocity(UnityEngine.Vector3)  /*0x06000102*/
    IL_00d9: ldarg.0
    IL_00da: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00df: dup
    IL_00e0: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e5: ldarg.0
    IL_00e6: call Vector3 Wiggler::get_velocity()  /*0x06000101*/
    IL_00eb: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00f0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00f5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00fa: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00ff: ret

  .method Wiggler::.ctor()  // token 0x06000105 rva 0x6180 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 50f
    IL_0006: stfld float Wiggler::acceleration  /*0x0400012B*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float Wiggler::speedDamping  /*0x0400012C*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float Wiggler::positionDampingMultiplyer  /*0x0400012D*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

