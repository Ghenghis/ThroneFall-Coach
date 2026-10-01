// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1  (token 0x02000002) =====
  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::Get()  // token 0x06000001 rva 0x2050 attrs Private, Static, HideBySig
    // code size 92 (0x5c), max stack 4, init locals
    .locals ([0] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData)
    IL_0000: ldloca.s 0
    IL_0002: initobj UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData  /*0x02000017*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4 1396
    IL_000f: newarr System.Byte  /*0x01000045*/
    IL_0014: dup
    IL_0015: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=1396 <PrivateImplementationDetails>::ACEC8B34F3B67143A38FC26C87930BCB26773AD319DA8B03F8B67AD519793BE0  /*0x0400007E*/
    IL_001a: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A000010*/
    IL_001f: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::FilePathsData  /*0x0400007F*/
    IL_0024: ldloca.s 0
    IL_0026: ldc.i4 843
    IL_002b: newarr System.Byte  /*0x01000045*/
    IL_0030: dup
    IL_0031: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=843 <PrivateImplementationDetails>::787140F756092B98D9962D6E586E51324497F17FA6A6787CCD59C79184FD419B  /*0x0400007D*/
    IL_0036: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A000010*/
    IL_003b: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TypesData  /*0x04000080*/
    IL_0040: ldloca.s 0
    IL_0042: ldc.i4.s 18
    IL_0044: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalFiles  /*0x04000082*/
    IL_0049: ldloca.s 0
    IL_004b: ldc.i4.s 21
    IL_004d: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalTypes  /*0x04000081*/
    IL_0052: ldloca.s 0
    IL_0054: ldc.i4.0
    IL_0055: stfld bool UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::IsEditorOnly  /*0x04000083*/
    IL_005a: ldloc.0
    IL_005b: ret

  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::.ctor()  // token 0x06000002 rva 0x20b8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000011*/
    IL_0006: ret

// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1/MonoScriptData  (token 0x02000017) =====
