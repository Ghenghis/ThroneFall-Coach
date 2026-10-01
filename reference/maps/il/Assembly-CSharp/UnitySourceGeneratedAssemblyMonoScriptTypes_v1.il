// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1  (token 0x020003A8) =====
  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::Get()  // token 0x060013F0 rva 0x5ea54 attrs Private, Static, HideBySig
    // code size 98 (0x62), max stack 4, init locals
    .locals ([0] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData)
    IL_0000: ldloca.s 0
    IL_0002: initobj UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData  /*0x020003A9*/
    IL_0008: ldloca.s 0
    IL_000a: ldc.i4 152956
    IL_000f: newarr System.Byte  /*0x01000159*/
    IL_0014: dup
    IL_0015: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=152956 <PrivateImplementationDetails>::FACCAE8DBF34A062CBDED89C144EF75C39B5877BDC3BD5671CA1298F0F35A5C6  /*0x040037B3*/
    IL_001a: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A00016C*/
    IL_001f: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::FilePathsData  /*0x04001853*/
    IL_0024: ldloca.s 0
    IL_0026: ldc.i4 143398
    IL_002b: newarr System.Byte  /*0x01000159*/
    IL_0030: dup
    IL_0031: ldtoken <PrivateImplementationDetails>.__StaticArrayInitTypeSize=143398 <PrivateImplementationDetails>::EE2615445AD8278012A000081B2EBDC9234E071247A26F728567F792F0EA27AC  /*0x040037B2*/
    IL_0036: call void System.Runtime.CompilerServices.RuntimeHelpers::InitializeArray(System.Array,System.RuntimeFieldHandle)  /*0x0A00016C*/
    IL_003b: stfld byte[] UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TypesData  /*0x04001854*/
    IL_0040: ldloca.s 0
    IL_0042: ldc.i4 1810
    IL_0047: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalFiles  /*0x04001856*/
    IL_004c: ldloca.s 0
    IL_004e: ldc.i4 2714
    IL_0053: stfld int UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::TotalTypes  /*0x04001855*/
    IL_0058: ldloca.s 0
    IL_005a: ldc.i4.0
    IL_005b: stfld bool UnitySourceGeneratedAssemblyMonoScriptTypes_v1.MonoScriptData::IsEditorOnly  /*0x04001857*/
    IL_0060: ldloc.0
    IL_0061: ret

  .method UnitySourceGeneratedAssemblyMonoScriptTypes_v1::.ctor()  // token 0x060013F1 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

// ===== UnitySourceGeneratedAssemblyMonoScriptTypes_v1/MonoScriptData  (token 0x020003A9) =====
