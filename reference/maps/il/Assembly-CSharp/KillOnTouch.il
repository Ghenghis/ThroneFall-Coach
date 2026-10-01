// ===== KillOnTouch  (token 0x020001A1) =====
  .method KillOnTouch::Update()  // token 0x06000871 rva 0x28bf4 attrs Private, HideBySig
    // code size 168 (0xa8), max stack 5, init locals
    .locals ([0] Vector3, [1] Quaternion, [2] int, [3] Bounds, [4] int, [5] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld BoxCollider KillOnTouch::boxCollider  /*0x04000A72*/
    IL_0006: callvirt Bounds UnityEngine.Collider::get_bounds()  /*0x0A000257*/
    IL_000b: stloc.3
    IL_000c: ldloca.s 3
    IL_000e: call Vector3 UnityEngine.Bounds::get_center()  /*0x0A00010F*/
    IL_0013: ldarg.0
    IL_0014: ldfld BoxCollider KillOnTouch::boxCollider  /*0x04000A72*/
    IL_0019: callvirt Bounds UnityEngine.Collider::get_bounds()  /*0x0A000257*/
    IL_001e: stloc.3
    IL_001f: ldloca.s 3
    IL_0021: call Vector3 UnityEngine.Bounds::get_size()  /*0x0A00010D*/
    IL_0026: stloc.0
    IL_0027: ldarg.0
    IL_0028: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002d: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0032: stloc.1
    IL_0033: ldloc.0
    IL_0034: ldc.r4 2f
    IL_0039: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_003e: ldsfld Collider[] KillOnTouch::overlapBuffer  /*0x04000A74*/
    IL_0043: ldloc.1
    IL_0044: ldarg.0
    IL_0045: ldfld LayerMask KillOnTouch::layerMask  /*0x04000A71*/
    IL_004a: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_004f: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_0054: stloc.2
    IL_0055: ldc.i4.0
    IL_0056: stloc.s 4
    IL_0058: br.s IL_00a2
    IL_005a: ldsfld Collider[] KillOnTouch::overlapBuffer  /*0x04000A74*/
    IL_005f: ldloc.s 4
    IL_0061: ldelem.ref
    IL_0062: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0067: stloc.s 5
    IL_0069: ldloc.s 5
    IL_006b: ldnull
    IL_006c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0071: brfalse.s IL_009c
    IL_0073: ldloc.s 5
    IL_0075: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_007a: ldarg.0
    IL_007b: ldfld TagManager.ETag KillOnTouch::mustHaveTag  /*0x04000A73*/
    IL_0080: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0085: brfalse.s IL_009c
    IL_0087: ldloc.s 5
    IL_0089: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_008e: ldc.r4 1E+13f
    IL_0093: ldnull
    IL_0094: ldc.i4.0
    IL_0095: ldc.i4.1
    IL_0096: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_009b: pop
    IL_009c: ldloc.s 4
    IL_009e: ldc.i4.1
    IL_009f: add
    IL_00a0: stloc.s 4
    IL_00a2: ldloc.s 4
    IL_00a4: ldloc.2
    IL_00a5: blt.s IL_005a
    IL_00a7: ret

  .method KillOnTouch::.ctor()  // token 0x06000872 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

  .method KillOnTouch::.cctor()  // token 0x06000873 rva 0x28ca8 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldc.i4.s 64
    IL_0002: newarr UnityEngine.Collider  /*0x01000032*/
    IL_0007: stsfld Collider[] KillOnTouch::overlapBuffer  /*0x04000A74*/
    IL_000c: ret

