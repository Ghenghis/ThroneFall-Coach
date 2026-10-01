// ===== DebugBuildingDestroyer  (token 0x020000B0) =====
  .method DebugBuildingDestroyer::Update()  // token 0x060003CA rva 0x10c60 attrs Private, HideBySig
    // code size 184 (0xb8), max stack 5, init locals
    .locals ([0] Hp, [1] Hp, [2] float, [3] Collider[], [4] int, [5] Collider, [6] float)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld float DebugBuildingDestroyer::interactionRadius  /*0x040004CD*/
    IL_0011: ldarg.0
    IL_0012: ldfld LayerMask DebugBuildingDestroyer::interactionLayer  /*0x040004CC*/
    IL_0017: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_001c: call Collider[] UnityEngine.Physics::OverlapSphere(UnityEngine.Vector3,float,int)  /*0x0A0001B2*/
    IL_0021: ldnull
    IL_0022: stloc.1
    IL_0023: ldc.r4 Infinityf
    IL_0028: stloc.2
    IL_0029: stloc.3
    IL_002a: ldc.i4.0
    IL_002b: stloc.s 4
    IL_002d: br.s IL_008c
    IL_002f: ldloc.3
    IL_0030: ldloc.s 4
    IL_0032: ldelem.ref
    IL_0033: stloc.s 5
    IL_0035: ldloc.s 5
    IL_0037: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_003c: stloc.0
    IL_003d: ldloc.0
    IL_003e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0043: ldarg.0
    IL_0044: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0049: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004e: brtrue.s IL_0086
    IL_0050: ldloc.0
    IL_0051: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0056: brfalse.s IL_0086
    IL_0058: ldarg.0
    IL_0059: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0063: ldloc.s 5
    IL_0065: ldarg.0
    IL_0066: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0070: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_0075: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_007a: stloc.s 6
    IL_007c: ldloc.s 6
    IL_007e: ldloc.2
    IL_007f: bge.un.s IL_0086
    IL_0081: ldloc.0
    IL_0082: stloc.1
    IL_0083: ldloc.s 6
    IL_0085: stloc.2
    IL_0086: ldloc.s 4
    IL_0088: ldc.i4.1
    IL_0089: add
    IL_008a: stloc.s 4
    IL_008c: ldloc.s 4
    IL_008e: ldloc.3
    IL_008f: ldlen
    IL_0090: conv.i4
    IL_0091: blt.s IL_002f
    IL_0093: ldloc.1
    IL_0094: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0099: brfalse.s IL_00b7
    IL_009b: ldc.i4 304
    IL_00a0: call bool UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)  /*0x0A0001B3*/
    IL_00a5: brfalse.s IL_00b7
    IL_00a7: ldloc.1
    IL_00a8: ldloc.1
    IL_00a9: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_00ae: ldnull
    IL_00af: ldc.i4.0
    IL_00b0: ldc.i4.1
    IL_00b1: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00b6: pop
    IL_00b7: ret

  .method DebugBuildingDestroyer::.ctor()  // token 0x060003CB rva 0x10d24 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float DebugBuildingDestroyer::interactionRadius  /*0x040004CD*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

