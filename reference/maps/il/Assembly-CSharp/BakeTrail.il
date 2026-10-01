// ===== BakeTrail  (token 0x020003A1) =====
  .method BakeTrail::Awake()  // token 0x060013D7 rva 0x5e67e attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Ara.AraTrail>  /*0x2B000119*/
    IL_0007: stfld AraTrail BakeTrail::trail  /*0x04001841*/
    IL_000c: ret

  .method BakeTrail::Update()  // token 0x060013D8 rva 0x5e68c attrs Private, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldc.i4.s 32
    IL_0002: call bool UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)  /*0x0A0001B3*/
    IL_0007: brfalse.s IL_000f
    IL_0009: ldarg.0
    IL_000a: call void BakeTrail::Bake()  /*0x060013D9*/
    IL_000f: ret

  .method BakeTrail::Bake()  // token 0x060013D9 rva 0x5e6a0 attrs Private, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    .locals ([0] MeshFilter, [1] MeshRenderer)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: callvirt !!0 UnityEngine.GameObject::AddComponent()<UnityEngine.MeshFilter>  /*0x2B00011A*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: callvirt !!0 UnityEngine.GameObject::AddComponent()<UnityEngine.MeshRenderer>  /*0x2B00011B*/
    IL_0017: stloc.1
    IL_0018: ldloc.0
    IL_0019: ldnull
    IL_001a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001f: brfalse.s IL_0063
    IL_0021: ldloc.1
    IL_0022: ldnull
    IL_0023: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0028: brfalse.s IL_0063
    IL_002a: ldloc.0
    IL_002b: ldarg.0
    IL_002c: ldfld AraTrail BakeTrail::trail  /*0x04001841*/
    IL_0031: callvirt Mesh Ara.AraTrail::get_mesh()  /*0x06003D86*/
    IL_0036: call !!0 UnityEngine.Object::Instantiate(!!0)<UnityEngine.Mesh>  /*0x2B00011C*/
    IL_003b: callvirt void UnityEngine.MeshFilter::set_mesh(UnityEngine.Mesh)  /*0x0A00013C*/
    IL_0040: ldloc.1
    IL_0041: ldarg.0
    IL_0042: ldfld AraTrail BakeTrail::trail  /*0x04001841*/
    IL_0047: ldfld Material[] Ara.AraTrail::materials  /*0x040033A5*/
    IL_004c: callvirt void UnityEngine.Renderer::set_materials(UnityEngine.Material[])  /*0x0A000784*/
    IL_0051: ldarg.0
    IL_0052: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0057: ldarg.0
    IL_0058: ldfld AraTrail BakeTrail::trail  /*0x04001841*/
    IL_005d: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0062: ret
    IL_0063: ldstr "[BakeTrail]: Could not bake the trail because the object already had a MeshRenderer."
    IL_0068: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_006d: ret

  .method BakeTrail::.ctor()  // token 0x060013DA rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

