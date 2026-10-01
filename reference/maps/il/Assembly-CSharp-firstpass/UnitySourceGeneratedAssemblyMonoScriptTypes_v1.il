// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1  (token 0x02000002) =====
  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::Get()  // token 0x06000001 rva 0x2050 attrs Private, Static, HideBySig
    // code size 90 (0x5a), max stack 4, init locals
    .locals ([0] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData)
    IL_0000: ldloca.s 0
    IL_0002: initobj UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData  /*0x0200000C*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4 550
    IL_000f: newarr System.Byte  /*0x01000020*/
    IL_0014: dup
    IL_0015: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=550 <PrivateImplementationDetails>::DDA25FC1AFA0831F45172F8B7EE71DE4908BDF85F8834060111512F477D3668C  /*0x04000026*/
    IL_001a: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A000009*/
    IL_001f: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::FilePathsData  /*0x04000027*/
    IL_0024: ldloca.s 0
    IL_0026: ldc.i4 278
    IL_002b: newarr System.Byte  /*0x01000020*/
    IL_0030: dup
    IL_0031: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=278 <PrivateImplementationDetails>::4B52D1B061039950AE077A951BC890956D872BAC824F57D11917E6C96C3D3DA7  /*0x04000025*/
    IL_0036: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A000009*/
    IL_003b: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TypesData  /*0x04000028*/
    IL_0040: ldloca.s 0
    IL_0042: ldc.i4.8
    IL_0043: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalFiles  /*0x0400002A*/
    IL_0048: ldloca.s 0
    IL_004a: ldc.i4.8
    IL_004b: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalTypes  /*0x04000029*/
    IL_0050: ldloca.s 0
    IL_0052: ldc.i4.0
    IL_0053: stfld bool UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::IsEditorOnly  /*0x0400002B*/
    IL_0058: ldloc.0
    IL_0059: ret

  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::.ctor()  // token 0x06000002 rva 0x20b6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A00000A*/
    IL_0006: ret

// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1/MonoScriptData  (token 0x0200000C) =====
