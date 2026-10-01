// ===== SizeRectangleToMeshBounds  (token 0x02000343) =====
  .method SizeRectangleToMeshBounds::OnEnable()  // token 0x060011C5 rva 0x56090 attrs Private, HideBySig
    // code size 102 (0x66), max stack 5, init locals
    .locals ([0] Bounds)
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<Shapes.Rectangle>  /*0x2B0000D9*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: ldfld MeshFilter SizeRectangleToMeshBounds::meshFilter  /*0x0400158C*/
    IL_000d: callvirt Mesh UnityEngine.MeshFilter::get_sharedMesh()  /*0x0A00040E*/
    IL_0012: callvirt Bounds UnityEngine.Mesh::get_bounds()  /*0x0A000716*/
    IL_0017: stloc.0
    IL_0018: ldloca.s 0
    IL_001a: call Vector3 UnityEngine.Bounds::get_size()  /*0x0A00010D*/
    IL_001f: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0024: ldc.r4 2f
    IL_0029: ldarg.0
    IL_002a: ldfld float SizeRectangleToMeshBounds::yMargin  /*0x0400158B*/
    IL_002f: mul
    IL_0030: add
    IL_0031: callvirt void Shapes.Rectangle::set_Height(float)  /*0x0A000717*/
    IL_0036: ldarg.0
    IL_0037: ldfld MeshFilter SizeRectangleToMeshBounds::meshFilter  /*0x0400158C*/
    IL_003c: callvirt Mesh UnityEngine.MeshFilter::get_sharedMesh()  /*0x0A00040E*/
    IL_0041: callvirt Bounds UnityEngine.Mesh::get_bounds()  /*0x0A000716*/
    IL_0046: stloc.0
    IL_0047: ldloca.s 0
    IL_0049: call Vector3 UnityEngine.Bounds::get_size()  /*0x0A00010D*/
    IL_004e: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0053: ldc.r4 2f
    IL_0058: ldarg.0
    IL_0059: ldfld float SizeRectangleToMeshBounds::xMargin  /*0x0400158A*/
    IL_005e: mul
    IL_005f: add
    IL_0060: callvirt void Shapes.Rectangle::set_Width(float)  /*0x0A000718*/
    IL_0065: ret

  .method SizeRectangleToMeshBounds::.ctor()  // token 0x060011C6 rva 0x56102 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float SizeRectangleToMeshBounds::xMargin  /*0x0400158A*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float SizeRectangleToMeshBounds::yMargin  /*0x0400158B*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

