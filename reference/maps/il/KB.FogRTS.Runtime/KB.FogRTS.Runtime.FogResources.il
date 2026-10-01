// ===== KB.FogRTS.Runtime.FogResources  (token 0x0200000D) =====
  .method KB.FogRTS.Runtime.FogResources::GetVision()  // token 0x06000055 rva 0x37dc attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld Material KB.FogRTS.Runtime.FogResources::visionMat  /*0x0400005C*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetBlitGaussianBlur()  // token 0x06000056 rva 0x37e8 attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld Material KB.FogRTS.Runtime.FogResources::blitMat  /*0x0400005D*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetFogScreenEffect()  // token 0x06000057 rva 0x37f4 attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld Material KB.FogRTS.Runtime.FogResources::fogScreenEffectMat  /*0x0400005E*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetFogOverlayUI()  // token 0x06000058 rva 0x3800 attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld Shader KB.FogRTS.Runtime.FogResources::fogOverlayUI  /*0x04000058*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetCalculateVision()  // token 0x06000059 rva 0x380c attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld ComputeShader KB.FogRTS.Runtime.FogResources::calculateVision  /*0x04000059*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetLoadFog()  // token 0x0600005A rva 0x3818 attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld ComputeShader KB.FogRTS.Runtime.FogResources::loadFog  /*0x0400005A*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetQuad()  // token 0x0600005B rva 0x3824 attrs Assembly, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: call FogResources KB.FogRTS.Runtime.FogResources::GetInstance()  /*0x0600005C*/
    IL_0005: ldfld Mesh KB.FogRTS.Runtime.FogResources::quad  /*0x0400005F*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.FogResources::GetInstance()  // token 0x0600005C rva 0x3830 attrs Private, Static, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldsfld FogResources KB.FogRTS.Runtime.FogResources::instance  /*0x0400005B*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00003A*/
    IL_000b: brfalse.s IL_0026
    IL_000d: ldstr "Fog Resources"
    IL_0012: call !!0 UnityEngine.Resources::Load(string)<KB.FogRTS.Runtime.FogResources>  /*0x2B000009*/
    IL_0017: stsfld FogResources KB.FogRTS.Runtime.FogResources::instance  /*0x0400005B*/
    IL_001c: ldsfld FogResources KB.FogRTS.Runtime.FogResources::instance  /*0x0400005B*/
    IL_0021: callvirt void KB.FogRTS.Runtime.FogResources::Init()  /*0x0600005D*/
    IL_0026: ldsfld FogResources KB.FogRTS.Runtime.FogResources::instance  /*0x0400005B*/
    IL_002b: ret

  .method KB.FogRTS.Runtime.FogResources::Init()  // token 0x0600005D rva 0x3860 attrs Private, HideBySig
    // code size 288 (0x120), max stack 7, init locals
    .locals ([0] Mesh)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Shader KB.FogRTS.Runtime.FogResources::vision  /*0x04000055*/
    IL_0007: newobj void UnityEngine.Material::.ctor(UnityEngine.Shader)  /*0x0A0000AB*/
    IL_000c: stfld Material KB.FogRTS.Runtime.FogResources::visionMat  /*0x0400005C*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld Shader KB.FogRTS.Runtime.FogResources::blitGaussianBlur  /*0x04000056*/
    IL_0018: newobj void UnityEngine.Material::.ctor(UnityEngine.Shader)  /*0x0A0000AB*/
    IL_001d: stfld Material KB.FogRTS.Runtime.FogResources::blitMat  /*0x0400005D*/
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: ldfld Shader KB.FogRTS.Runtime.FogResources::fogScreenEffect  /*0x04000057*/
    IL_0029: newobj void UnityEngine.Material::.ctor(UnityEngine.Shader)  /*0x0A0000AB*/
    IL_002e: stfld Material KB.FogRTS.Runtime.FogResources::fogScreenEffectMat  /*0x0400005E*/
    IL_0033: ldarg.0
    IL_0034: newobj void UnityEngine.Mesh::.ctor()  /*0x0A0000AC*/
    IL_0039: stloc.0
    IL_003a: ldloc.0
    IL_003b: ldc.i4.4
    IL_003c: newarr UnityEngine.Vector3  /*0x01000019*/
    IL_0041: dup
    IL_0042: ldc.i4.0
    IL_0043: ldc.r4 -0.5f
    IL_0048: ldc.r4 -0.5f
    IL_004d: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A0000AD*/
    IL_0052: stelem UnityEngine.Vector3  /*0x01000019*/
    IL_0057: dup
    IL_0058: ldc.i4.1
    IL_0059: ldc.r4 0.5f
    IL_005e: ldc.r4 -0.5f
    IL_0063: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A0000AD*/
    IL_0068: stelem UnityEngine.Vector3  /*0x01000019*/
    IL_006d: dup
    IL_006e: ldc.i4.2
    IL_006f: ldc.r4 -0.5f
    IL_0074: ldc.r4 0.5f
    IL_0079: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A0000AD*/
    IL_007e: stelem UnityEngine.Vector3  /*0x01000019*/
    IL_0083: dup
    IL_0084: ldc.i4.3
    IL_0085: ldc.r4 0.5f
    IL_008a: ldc.r4 0.5f
    IL_008f: newobj void UnityEngine.Vector3::.ctor(float,float)  /*0x0A0000AD*/
    IL_0094: stelem UnityEngine.Vector3  /*0x01000019*/
    IL_0099: callvirt void UnityEngine.Mesh::set_vertices(UnityEngine.Vector3[])  /*0x0A0000AE*/
    IL_009e: ldloc.0
    IL_009f: ldc.i4.6
    IL_00a0: newarr System.Int32  /*0x01000065*/
    IL_00a5: dup
    IL_00a6: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=24 <PrivateImplementationDetails>::752A6E22358C492163D1DE31BFAFB249C23A54C303CE495A18ABF04CF82E01B2  /*0x0400007C*/
    IL_00ab: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A000010*/
    IL_00b0: callvirt void UnityEngine.Mesh::set_triangles(int[])  /*0x0A0000AF*/
    IL_00b5: ldloc.0
    IL_00b6: ldc.i4.4
    IL_00b7: newarr UnityEngine.Vector2  /*0x0100000B*/
    IL_00bc: dup
    IL_00bd: ldc.i4.0
    IL_00be: ldc.r4 0f
    IL_00c3: ldc.r4 0f
    IL_00c8: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_00cd: stelem UnityEngine.Vector2  /*0x0100000B*/
    IL_00d2: dup
    IL_00d3: ldc.i4.1
    IL_00d4: ldc.r4 1f
    IL_00d9: ldc.r4 0f
    IL_00de: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_00e3: stelem UnityEngine.Vector2  /*0x0100000B*/
    IL_00e8: dup
    IL_00e9: ldc.i4.2
    IL_00ea: ldc.r4 0f
    IL_00ef: ldc.r4 1f
    IL_00f4: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_00f9: stelem UnityEngine.Vector2  /*0x0100000B*/
    IL_00fe: dup
    IL_00ff: ldc.i4.3
    IL_0100: ldc.r4 1f
    IL_0105: ldc.r4 1f
    IL_010a: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_010f: stelem UnityEngine.Vector2  /*0x0100000B*/
    IL_0114: callvirt void UnityEngine.Mesh::set_uv(UnityEngine.Vector2[])  /*0x0A0000B0*/
    IL_0119: ldloc.0
    IL_011a: stfld Mesh KB.FogRTS.Runtime.FogResources::quad  /*0x0400005F*/
    IL_011f: ret

  .method KB.FogRTS.Runtime.FogResources::.ctor()  // token 0x0600005E rva 0x398c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00003C*/
    IL_0006: ret

