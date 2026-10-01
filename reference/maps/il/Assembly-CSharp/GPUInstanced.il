// ===== GPUInstanced  (token 0x020001CB) =====
  .method GPUInstanced::Start()  // token 0x06000936 rva 0x2be84 attrs Private, HideBySig
    // code size 195 (0xc3), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.MeshRenderer>  /*0x2B000084*/
    IL_0015: stfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_001a: ldarg.0
    IL_001b: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0026: brfalse.s IL_002f
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002e: ret
    IL_002f: ldarg.0
    IL_0030: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003b: brfalse.s IL_0048
    IL_003d: ldarg.0
    IL_003e: ldsfld GPUInstancingManager GPUInstancingManager::Instance  /*0x04000BAA*/
    IL_0043: stfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_0048: ldarg.0
    IL_0049: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_004e: ldnull
    IL_004f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0054: brfalse.s IL_005d
    IL_0056: ldarg.0
    IL_0057: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_005c: ret
    IL_005d: ldarg.0
    IL_005e: ldarg.0
    IL_005f: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_0064: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.MeshFilter>  /*0x2B00009A*/
    IL_0069: callvirt Mesh UnityEngine.MeshFilter::get_sharedMesh()  /*0x0A00040E*/
    IL_006e: stfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0073: ldarg.0
    IL_0074: ldarg.0
    IL_0075: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_007a: callvirt Material UnityEngine.Renderer::get_sharedMaterial()  /*0x0A0002B3*/
    IL_007f: stfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_0084: ldarg.0
    IL_0085: ldfld bool GPUInstanced::eenabled  /*0x04000BA6*/
    IL_008a: brfalse.s IL_00bb
    IL_008c: ldarg.0
    IL_008d: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_0092: ldc.i4.0
    IL_0093: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_0098: ldarg.0
    IL_0099: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_009e: ldarg.0
    IL_009f: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_00aa: ldarg.0
    IL_00ab: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld bool GPUInstanced::CullingEnabled  /*0x04000BA7*/
    IL_00b6: callvirt void GPUInstancingManager::AddVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  /*0x0600093E*/
    IL_00bb: ldarg.0
    IL_00bc: ldc.i4.1
    IL_00bd: stfld bool GPUInstanced::started  /*0x04000BA5*/
    IL_00c2: ret

  .method GPUInstanced::OnEnable()  // token 0x06000937 rva 0x2bf54 attrs Private, HideBySig
    // code size 64 (0x40), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool GPUInstanced::eenabled  /*0x04000BA6*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool GPUInstanced::started  /*0x04000BA5*/
    IL_000d: brtrue.s IL_0010
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_001c: ldarg.0
    IL_001d: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_0022: ldarg.0
    IL_0023: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0028: ldarg.0
    IL_0029: ldfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_002e: ldarg.0
    IL_002f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: ldarg.0
    IL_0035: ldfld bool GPUInstanced::CullingEnabled  /*0x04000BA7*/
    IL_003a: callvirt void GPUInstancingManager::AddVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  /*0x0600093E*/
    IL_003f: ret

  .method GPUInstanced::OnDisable()  // token 0x06000938 rva 0x2bfa0 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool GPUInstanced::eenabled  /*0x04000BA6*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool GPUInstanced::started  /*0x04000BA5*/
    IL_000d: brtrue.s IL_0010
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_0016: ldarg.0
    IL_0017: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_001c: ldarg.0
    IL_001d: ldfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_0022: ldarg.0
    IL_0023: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0028: callvirt void GPUInstancingManager::RemoveVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform)  /*0x0600093F*/
    IL_002d: ret

  .method GPUInstanced::OnMeshOrMaterialUpdate(UnityEngine.Mesh,UnityEngine.Material)  // token 0x06000939 rva 0x2bfd0 attrs Public, HideBySig
    // code size 80 (0x50), max stack 7, init locals
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brtrue.s IL_001c
    IL_000e: ldarg.2
    IL_000f: ldarg.0
    IL_0010: ldfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_0015: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001a: brfalse.s IL_004f
    IL_001c: ldarg.0
    IL_001d: ldfld GPUInstancingManager GPUInstanced::gpui  /*0x04000BA4*/
    IL_0022: ldarg.0
    IL_0023: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0028: ldarg.0
    IL_0029: ldfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_002e: ldarg.1
    IL_002f: ldarg.2
    IL_0030: ldarg.0
    IL_0031: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0036: ldarg.0
    IL_0037: ldfld bool GPUInstanced::CullingEnabled  /*0x04000BA7*/
    IL_003c: callvirt void GPUInstancingManager::UpdateVirtualMeshRenderer(UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Mesh,UnityEngine.Material,UnityEngine.Transform,bool)  /*0x06000940*/
    IL_0041: ldarg.0
    IL_0042: ldarg.1
    IL_0043: stfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0048: ldarg.0
    IL_0049: ldarg.2
    IL_004a: stfld Material GPUInstanced::mat  /*0x04000BA9*/
    IL_004f: ret

  .method GPUInstanced::Update()  // token 0x0600093A rva 0x2c02c attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Mesh GPUInstanced::mesh  /*0x04000BA8*/
    IL_0007: ldarg.0
    IL_0008: ldfld MeshRenderer GPUInstanced::mr  /*0x04000BA3*/
    IL_000d: callvirt Material UnityEngine.Renderer::get_sharedMaterial()  /*0x0A0002B3*/
    IL_0012: call void GPUInstanced::OnMeshOrMaterialUpdate(UnityEngine.Mesh,UnityEngine.Material)  /*0x06000939*/
    IL_0017: ret

  .method GPUInstanced::.ctor()  // token 0x0600093B rva 0x2c045 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool GPUInstanced::CullingEnabled  /*0x04000BA7*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

