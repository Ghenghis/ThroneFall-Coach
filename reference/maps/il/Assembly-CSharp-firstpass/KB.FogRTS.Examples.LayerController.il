// ===== KB.FogRTS.Examples.LayerController  (token 0x02000005) =====
  .method KB.FogRTS.Examples.LayerController::Awake()  // token 0x06000006 rva 0x21c8 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0[] UnityEngine.Component::GetComponents()<UnityEngine.BoxCollider>  /*0x2B000001*/
    IL_0007: stfld BoxCollider[] KB.FogRTS.Examples.LayerController::boxColliders  /*0x04000007*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld int KB.FogRTS.Examples.LayerController::maxVisionSources  /*0x04000006*/
    IL_0013: newarr UnityEngine.Collider  /*0x0100000F*/
    IL_0018: stfld Collider[] KB.FogRTS.Examples.LayerController::overlapBuffer  /*0x04000008*/
    IL_001d: ret

  .method KB.FogRTS.Examples.LayerController::Update()  // token 0x06000007 rva 0x21e8 attrs Private, HideBySig
    // code size 326 (0x146), max stack 4, init locals
    .locals ([0] BoxCollider[], [1] int, [2] BoxCollider, [3] Vector3, [4] Quaternion, [5] int, [6] int, [7] VisionSource, [8] HashSet.Enumerator<VisionSource>, [9] VisionSource)
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::currentlyInside  /*0x0400000A*/
    IL_0006: callvirt void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::Clear()  /*0x0A00001A*/
    IL_000b: ldarg.0
    IL_000c: ldfld BoxCollider[] KB.FogRTS.Examples.LayerController::boxColliders  /*0x04000007*/
    IL_0011: stloc.0
    IL_0012: ldc.i4.0
    IL_0013: stloc.1
    IL_0014: br IL_00ce
    IL_0019: ldloc.0
    IL_001a: ldloc.1
    IL_001b: ldelem.ref
    IL_001c: stloc.2
    IL_001d: ldloc.2
    IL_001e: callvirt bool UnityEngine.Collider::get_enabled()  /*0x0A00001B*/
    IL_0023: brfalse IL_00ca
    IL_0028: ldloc.2
    IL_0029: callvirt bool UnityEngine.Collider::get_isTrigger()  /*0x0A00001C*/
    IL_002e: brfalse IL_00ca
    IL_0033: ldarg.0
    IL_0034: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0039: ldloc.2
    IL_003a: callvirt Vector3 UnityEngine.BoxCollider::get_center()  /*0x0A00001D*/
    IL_003f: callvirt Vector3 UnityEngine.Transform::TransformPoint(UnityEngine.Vector3)  /*0x0A00001E*/
    IL_0044: ldloc.2
    IL_0045: callvirt Vector3 UnityEngine.BoxCollider::get_size()  /*0x0A00001F*/
    IL_004a: ldc.r4 0.5f
    IL_004f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A000020*/
    IL_0054: ldarg.0
    IL_0055: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_lossyScale()  /*0x0A000021*/
    IL_005f: call Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000022*/
    IL_0064: stloc.3
    IL_0065: ldarg.0
    IL_0066: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_006b: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A000023*/
    IL_0070: stloc.s 4
    IL_0072: ldloc.3
    IL_0073: ldarg.0
    IL_0074: ldfld Collider[] KB.FogRTS.Examples.LayerController::overlapBuffer  /*0x04000008*/
    IL_0079: ldloc.s 4
    IL_007b: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion)  /*0x0A000024*/
    IL_0080: stloc.s 5
    IL_0082: ldc.i4.0
    IL_0083: stloc.s 6
    IL_0085: br.s IL_00c4
    IL_0087: ldarg.0
    IL_0088: ldfld Collider[] KB.FogRTS.Examples.LayerController::overlapBuffer  /*0x04000008*/
    IL_008d: ldloc.s 6
    IL_008f: ldelem.ref
    IL_0090: ldloca.s 7
    IL_0092: callvirt bool UnityEngine.Component::TryGetComponent(ref !!0)<KB.FogRTS.Runtime.VisionSource>  /*0x2B000002*/
    IL_0097: brfalse.s IL_00be
    IL_0099: ldarg.0
    IL_009a: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::currentlyInside  /*0x0400000A*/
    IL_009f: ldloc.s 7
    IL_00a1: callvirt bool System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::Add(!0)  /*0x0A000026*/
    IL_00a6: pop
    IL_00a7: ldarg.0
    IL_00a8: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::insideVisionSources  /*0x04000009*/
    IL_00ad: ldloc.s 7
    IL_00af: callvirt bool System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::Contains(!0)  /*0x0A000027*/
    IL_00b4: brtrue.s IL_00be
    IL_00b6: ldloc.s 7
    IL_00b8: ldc.i4.3
    IL_00b9: callvirt void KB.FogRTS.Runtime.VisionSource::set_Layer(KB.FogRTS.Runtime.VisionLayer)  /*0x0A000028*/
    IL_00be: ldloc.s 6
    IL_00c0: ldc.i4.1
    IL_00c1: add
    IL_00c2: stloc.s 6
    IL_00c4: ldloc.s 6
    IL_00c6: ldloc.s 5
    IL_00c8: blt.s IL_0087
    IL_00ca: ldloc.1
    IL_00cb: ldc.i4.1
    IL_00cc: add
    IL_00cd: stloc.1
    IL_00ce: ldloc.1
    IL_00cf: ldloc.0
    IL_00d0: ldlen
    IL_00d1: conv.i4
    IL_00d2: blt IL_0019
    IL_00d7: ldarg.0
    IL_00d8: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::insideVisionSources  /*0x04000009*/
    IL_00dd: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::GetEnumerator()  /*0x0A000029*/
    IL_00e2: stloc.s 8
    IL_00e4: br.s IL_0110
    IL_00e6: ldloca.s 8
    IL_00e8: call !0 System.Collections.Generic.HashSet.Enumerator<KB.FogRTS.Runtime.VisionSource>::get_Current()  /*0x0A00002A*/
    IL_00ed: stloc.s 9
    IL_00ef: ldloc.s 9
    IL_00f1: ldnull
    IL_00f2: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_00f7: brfalse.s IL_0110
    IL_00f9: ldarg.0
    IL_00fa: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::currentlyInside  /*0x0400000A*/
    IL_00ff: ldloc.s 9
    IL_0101: callvirt bool System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::Contains(!0)  /*0x0A000027*/
    IL_0106: brtrue.s IL_0110
    IL_0108: ldloc.s 9
    IL_010a: ldc.i4.1
    IL_010b: callvirt void KB.FogRTS.Runtime.VisionSource::set_Layer(KB.FogRTS.Runtime.VisionLayer)  /*0x0A000028*/
    IL_0110: ldloca.s 8
    IL_0112: call bool System.Collections.Generic.HashSet.Enumerator<KB.FogRTS.Runtime.VisionSource>::MoveNext()  /*0x0A00002C*/
    IL_0117: brtrue.s IL_00e6
    IL_0119: leave.s IL_0129
    IL_011b: ldloca.s 8
    IL_011d: constrained. System.Collections.Generic.HashSet.Enumerator<KB.FogRTS.Runtime.VisionSource>  /*0x1B000002*/
    IL_0123: callvirt void System.IDisposable::Dispose()  /*0x0A00002D*/
    IL_0128: endfinally
    IL_0129: ldarg.0
    IL_012a: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::insideVisionSources  /*0x04000009*/
    IL_012f: callvirt void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::Clear()  /*0x0A00001A*/
    IL_0134: ldarg.0
    IL_0135: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::insideVisionSources  /*0x04000009*/
    IL_013a: ldarg.0
    IL_013b: ldfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::currentlyInside  /*0x0400000A*/
    IL_0140: callvirt void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::UnionWith(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00002E*/
    IL_0145: ret
    .try IL_00e4-IL_011b finally handler IL_011b-IL_0129

  .method KB.FogRTS.Examples.LayerController::.ctor()  // token 0x06000008 rva 0x234c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 32
    IL_0003: stfld int KB.FogRTS.Examples.LayerController::maxVisionSources  /*0x04000006*/
    IL_0008: ldarg.0
    IL_0009: newobj void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::.ctor()  /*0x0A00002F*/
    IL_000e: stfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::insideVisionSources  /*0x04000009*/
    IL_0013: ldarg.0
    IL_0014: newobj void System.Collections.Generic.HashSet<KB.FogRTS.Runtime.VisionSource>::.ctor()  /*0x0A00002F*/
    IL_0019: stfld HashSet<VisionSource> KB.FogRTS.Examples.LayerController::currentlyInside  /*0x0400000A*/
    IL_001e: ldarg.0
    IL_001f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0024: ret

