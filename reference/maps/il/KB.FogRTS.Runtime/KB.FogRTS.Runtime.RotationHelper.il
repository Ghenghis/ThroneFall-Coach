// ===== KB.FogRTS.Runtime.RotationHelper  (token 0x0200000F) =====
  .method KB.FogRTS.Runtime.RotationHelper::QuaternionToAngle(bool,Unity.Mathematics.quaternion)  // token 0x06000063 rva 0x3abc attrs Assembly, Static, HideBySig
    // code size 93 (0x5d), max stack 4, init locals
    .locals ([0] float3, [1] float3)
    IL_0000: ldarg.0
    IL_0001: brfalse.s IL_0030
    IL_0003: ldarg.1
    IL_0004: ldc.r4 0f
    IL_0009: ldc.r4 0f
    IL_000e: ldc.r4 1f
    IL_0013: newobj void Unity.Mathematics.float3::.ctor(float,float,float)  /*0x0A0000B5*/
    IL_0018: call float3 Unity.Mathematics.math::mul(Unity.Mathematics.quaternion,Unity.Mathematics.float3)  /*0x0A0000B6*/
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: ldfld float Unity.Mathematics.float3::x  /*0x0A0000B7*/
    IL_0024: ldloc.0
    IL_0025: ldfld float Unity.Mathematics.float3::z  /*0x0A0000B8*/
    IL_002a: call float Unity.Mathematics.math::atan2(float,float)  /*0x0A0000B9*/
    IL_002f: ret
    IL_0030: ldarg.1
    IL_0031: ldc.r4 1f
    IL_0036: ldc.r4 0f
    IL_003b: ldc.r4 0f
    IL_0040: newobj void Unity.Mathematics.float3::.ctor(float,float,float)  /*0x0A0000B5*/
    IL_0045: call float3 Unity.Mathematics.math::mul(Unity.Mathematics.quaternion,Unity.Mathematics.float3)  /*0x0A0000B6*/
    IL_004a: stloc.1
    IL_004b: ldloc.1
    IL_004c: ldfld float Unity.Mathematics.float3::y  /*0x0A0000BA*/
    IL_0051: ldloc.1
    IL_0052: ldfld float Unity.Mathematics.float3::x  /*0x0A0000B7*/
    IL_0057: call float Unity.Mathematics.math::atan2(float,float)  /*0x0A0000B9*/
    IL_005c: ret

  .method KB.FogRTS.Runtime.RotationHelper::Rotate2D(Unity.Mathematics.float2,float,float)  // token 0x06000064 rva 0x3b25 attrs Assembly, Static, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.2
    IL_0001: ldarg.1
    IL_0002: ldarg.1
    IL_0003: neg
    IL_0004: ldarg.2
    IL_0005: newobj void Unity.Mathematics.float2x2::.ctor(float,float,float,float)  /*0x0A0000BB*/
    IL_000a: ldarg.0
    IL_000b: call float2 Unity.Mathematics.math::mul(Unity.Mathematics.float2x2,Unity.Mathematics.float2)  /*0x0A0000BC*/
    IL_0010: ret

