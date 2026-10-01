// ===== HideMeshRendOnPlay  (token 0x02000171) =====
  .method HideMeshRendOnPlay::Start()  // token 0x0600077B rva 0x25464 attrs Private, HideBySig
    // code size 82 (0x52), max stack 2, init locals
    .locals ([0] MeshRenderer[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.MeshRenderer>  /*0x2B000084*/
    IL_0007: stfld MeshRenderer HideMeshRendOnPlay::_meshRend  /*0x04000962*/
    IL_000c: ldarg.0
    IL_000d: ldfld MeshRenderer HideMeshRendOnPlay::_meshRend  /*0x04000962*/
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld MeshRenderer HideMeshRendOnPlay::_meshRend  /*0x04000962*/
    IL_0020: ldc.i4.0
    IL_0021: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_0026: ldarg.0
    IL_0027: ldfld bool HideMeshRendOnPlay::_hideChildren  /*0x04000963*/
    IL_002c: brfalse.s IL_0051
    IL_002e: ldarg.0
    IL_002f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<UnityEngine.MeshRenderer>  /*0x2B000085*/
    IL_0039: stloc.0
    IL_003a: ldc.i4.0
    IL_003b: stloc.1
    IL_003c: br.s IL_004b
    IL_003e: ldloc.0
    IL_003f: ldloc.1
    IL_0040: ldelem.ref
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_0047: ldloc.1
    IL_0048: ldc.i4.1
    IL_0049: add
    IL_004a: stloc.1
    IL_004b: ldloc.1
    IL_004c: ldloc.0
    IL_004d: ldlen
    IL_004e: conv.i4
    IL_004f: blt.s IL_003e
    IL_0051: ret

  .method HideMeshRendOnPlay::.ctor()  // token 0x0600077C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

