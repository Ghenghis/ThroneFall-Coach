// ===== AttachVisionSourceToAllBuildParents  (token 0x0200012F) =====
  .method AttachVisionSourceToAllBuildParents::Start()  // token 0x06000653 rva 0x1a854 attrs Private, HideBySig
    // code size 176 (0xb0), max stack 4, init locals
    .locals ([0] BuildSlot[], [1] int, [2] BuildSlot, [3] GameObject, [4] VisionSource)
    IL_0000: ldc.i4.1
    IL_0001: call !!0[] UnityEngine.Object::FindObjectsOfType(bool)<BuildSlot>  /*0x2B000051*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br IL_00a6
    IL_000e: ldloc.0
    IL_000f: ldloc.1
    IL_0010: ldelem.ref
    IL_0011: stloc.2
    IL_0012: ldloc.2
    IL_0013: callvirt GameObject BuildSlot::get_BuildingParent()  /*0x060002EA*/
    IL_0018: stloc.3
    IL_0019: ldloc.3
    IL_001a: ldnull
    IL_001b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0020: brfalse.s IL_003e
    IL_0022: ldstr "BuildSlot '"
    IL_0027: ldloc.2
    IL_0028: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_002d: ldstr "' has no BuildParent."
    IL_0032: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0037: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_003c: br.s IL_00a2
    IL_003e: ldloc.3
    IL_003f: ldloca.s 4
    IL_0041: callvirt bool UnityEngine.GameObject::TryGetComponent(ref !!0)<KB.FogRTS.Runtime.VisionSource>  /*0x2B000052*/
    IL_0046: brtrue.s IL_0050
    IL_0048: ldloc.3
    IL_0049: callvirt !!0 UnityEngine.GameObject::AddComponent()<KB.FogRTS.Runtime.VisionSource>  /*0x2B000050*/
    IL_004e: stloc.s 4
    IL_0050: ldloc.s 4
    IL_0052: ldarg.0
    IL_0053: ldfld float AttachVisionSourceToAllBuildParents::radius  /*0x040007AB*/
    IL_0058: ldarg.0
    IL_0059: ldfld float AttachVisionSourceToAllBuildParents::radius  /*0x040007AB*/
    IL_005e: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0063: callvirt void KB.FogRTS.Runtime.VisionSource::set_Scale(UnityEngine.Vector2)  /*0x0A000289*/
    IL_0068: ldc.i4.5
    IL_0069: newarr System.String  /*0x0100001D*/
    IL_006e: dup
    IL_006f: ldc.i4.0
    IL_0070: ldstr "VisionSource attached to BuildParent '"
    IL_0075: stelem.ref
    IL_0076: dup
    IL_0077: ldc.i4.1
    IL_0078: ldloc.3
    IL_0079: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_007e: stelem.ref
    IL_007f: dup
    IL_0080: ldc.i4.2
    IL_0081: ldstr "' from slot '"
    IL_0086: stelem.ref
    IL_0087: dup
    IL_0088: ldc.i4.3
    IL_0089: ldloc.2
    IL_008a: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_008f: stelem.ref
    IL_0090: dup
    IL_0091: ldc.i4.4
    IL_0092: ldstr "'."
    IL_0097: stelem.ref
    IL_0098: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_009d: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_00a2: ldloc.1
    IL_00a3: ldc.i4.1
    IL_00a4: add
    IL_00a5: stloc.1
    IL_00a6: ldloc.1
    IL_00a7: ldloc.0
    IL_00a8: ldlen
    IL_00a9: conv.i4
    IL_00aa: blt IL_000e
    IL_00af: ret

  .method AttachVisionSourceToAllBuildParents::.ctor()  // token 0x06000654 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

