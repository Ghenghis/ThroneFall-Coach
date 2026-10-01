// ===== SuspendPlayerCollisionUntilNoOverlap  (token 0x02000297) =====
  .method SuspendPlayerCollisionUntilNoOverlap::Awake()  // token 0x06000E39 rva 0x3f71c attrs Private, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_0006: ldarg.0
    IL_0007: call !!0[] UnityEngine.Component::GetComponentsInChildren()<UnityEngine.Collider>  /*0x2B0000CB*/
    IL_000c: callvirt void System.Collections.Generic.List<UnityEngine.Collider>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0005B6*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_0017: callvirt int System.Collections.Generic.List<UnityEngine.Collider>::get_Count()  /*0x0A0005B7*/
    IL_001c: ldc.i4.1
    IL_001d: sub
    IL_001e: stloc.0
    IL_001f: br.s IL_0044
    IL_0021: ldarg.0
    IL_0022: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_0027: ldloc.0
    IL_0028: callvirt !0 System.Collections.Generic.List<UnityEngine.Collider>::get_Item(int)  /*0x0A0005B8*/
    IL_002d: callvirt bool UnityEngine.Collider::get_isTrigger()  /*0x0A0005B9*/
    IL_0032: brfalse.s IL_0040
    IL_0034: ldarg.0
    IL_0035: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_003a: ldloc.0
    IL_003b: callvirt void System.Collections.Generic.List<UnityEngine.Collider>::RemoveAt(int)  /*0x0A0005BA*/
    IL_0040: ldloc.0
    IL_0041: ldc.i4.1
    IL_0042: sub
    IL_0043: stloc.0
    IL_0044: ldloc.0
    IL_0045: ldc.i4.0
    IL_0046: bge.s IL_0021
    IL_0048: ret

  .method SuspendPlayerCollisionUntilNoOverlap::OnEnable()  // token 0x06000E3A rva 0x3f771 attrs Private, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool SuspendPlayerCollisionUntilNoOverlap::triggerOnEnable  /*0x0400107E*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void SuspendPlayerCollisionUntilNoOverlap::Trigger()  /*0x06000E3B*/
    IL_000e: ret

  .method SuspendPlayerCollisionUntilNoOverlap::Trigger()  // token 0x06000E3B rva 0x3f784 attrs Public, HideBySig
    // code size 110 (0x6e), max stack 2, init locals
    .locals ([0] PlayerMovement, [1] List.Enumerator<Collider>)
    IL_0000: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldc.i4.1
    IL_000f: stfld bool SuspendPlayerCollisionUntilNoOverlap::suspended  /*0x04001082*/
    IL_0014: ldarg.0
    IL_0015: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001f: call PlayerMovement PlayerManager::GetClosestPlayer(UnityEngine.Vector3)  /*0x06000C19*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brfalse.s IL_0039
    IL_002d: ldarg.0
    IL_002e: ldloc.0
    IL_002f: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.CharacterController>  /*0x2B0000B3*/
    IL_0034: stfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_0039: ldarg.0
    IL_003a: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_003f: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Collider>::GetEnumerator()  /*0x0A0005BB*/
    IL_0044: stloc.1
    IL_0045: br.s IL_0054
    IL_0047: ldloca.s 1
    IL_0049: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Collider>::get_Current()  /*0x0A0005BC*/
    IL_004e: ldc.i4.1
    IL_004f: callvirt void UnityEngine.Collider::set_isTrigger(bool)  /*0x0A0005BD*/
    IL_0054: ldloca.s 1
    IL_0056: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Collider>::MoveNext()  /*0x0A0005BE*/
    IL_005b: brtrue.s IL_0047
    IL_005d: leave.s IL_006d
    IL_005f: ldloca.s 1
    IL_0061: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Collider>  /*0x1B000105*/
    IL_0067: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006c: endfinally
    IL_006d: ret
    .try IL_0045-IL_005f finally handler IL_005f-IL_006d

  .method SuspendPlayerCollisionUntilNoOverlap::SwitchBack()  // token 0x06000E3C rva 0x3f810 attrs Private, HideBySig
    // code size 60 (0x3c), max stack 2, init locals
    .locals ([0] List.Enumerator<Collider>)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool SuspendPlayerCollisionUntilNoOverlap::suspended  /*0x04001082*/
    IL_0007: ldarg.0
    IL_0008: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_000d: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Collider>::GetEnumerator()  /*0x0A0005BB*/
    IL_0012: stloc.0
    IL_0013: br.s IL_0022
    IL_0015: ldloca.s 0
    IL_0017: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Collider>::get_Current()  /*0x0A0005BC*/
    IL_001c: ldc.i4.0
    IL_001d: callvirt void UnityEngine.Collider::set_isTrigger(bool)  /*0x0A0005BD*/
    IL_0022: ldloca.s 0
    IL_0024: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Collider>::MoveNext()  /*0x0A0005BE*/
    IL_0029: brtrue.s IL_0015
    IL_002b: leave.s IL_003b
    IL_002d: ldloca.s 0
    IL_002f: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Collider>  /*0x1B000105*/
    IL_0035: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003a: endfinally
    IL_003b: ret
    .try IL_0013-IL_002d finally handler IL_002d-IL_003b

  .method SuspendPlayerCollisionUntilNoOverlap::Update()  // token 0x06000E3D rva 0x3f868 attrs Private, HideBySig
    // code size 229 (0xe5), max stack 6, init locals
    .locals ([0] float, [1] Vector3, [2] Vector3, [3] bool, [4] Collider[], [5] int, [6] Collider)
    IL_0000: ldarg.0
    IL_0001: ldfld bool SuspendPlayerCollisionUntilNoOverlap::suspended  /*0x04001082*/
    IL_0006: brfalse IL_00e4
    IL_000b: ldarg.0
    IL_000c: ldfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_0011: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0016: brfalse IL_00de
    IL_001b: ldarg.0
    IL_001c: ldfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_0021: callvirt float UnityEngine.CharacterController::get_height()  /*0x0A0005BF*/
    IL_0026: ldc.r4 2f
    IL_002b: div
    IL_002c: ldc.r4 3.5f
    IL_0031: mul
    IL_0032: stloc.0
    IL_0033: ldarg.0
    IL_0034: ldfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_0039: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: call Vector3 UnityEngine.Vector3::get_down()  /*0x0A00016E*/
    IL_0048: ldloc.0
    IL_0049: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_004e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0053: stloc.1
    IL_0054: ldarg.0
    IL_0055: ldfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_005a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0064: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0069: ldloc.0
    IL_006a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0074: stloc.2
    IL_0075: ldarg.0
    IL_0076: ldloc.1
    IL_0077: ldloc.2
    IL_0078: ldarg.0
    IL_0079: ldfld CharacterController SuspendPlayerCollisionUntilNoOverlap::trackedTarget  /*0x04001083*/
    IL_007e: callvirt float UnityEngine.CharacterController::get_radius()  /*0x0A0005C0*/
    IL_0083: ldc.r4 3.5f
    IL_0088: mul
    IL_0089: ldarg.0
    IL_008a: ldfld LayerMask SuspendPlayerCollisionUntilNoOverlap::scanLayer  /*0x0400107F*/
    IL_008f: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0094: ldc.i4.2
    IL_0095: call Collider[] UnityEngine.Physics::OverlapCapsule(UnityEngine.Vector3,UnityEngine.Vector3,float,int,UnityEngine.QueryTriggerInteraction)  /*0x0A0005C1*/
    IL_009a: stfld Collider[] SuspendPlayerCollisionUntilNoOverlap::overlaps  /*0x04001081*/
    IL_009f: ldc.i4.1
    IL_00a0: stloc.3
    IL_00a1: ldarg.0
    IL_00a2: ldfld Collider[] SuspendPlayerCollisionUntilNoOverlap::overlaps  /*0x04001081*/
    IL_00a7: stloc.s 4
    IL_00a9: ldc.i4.0
    IL_00aa: stloc.s 5
    IL_00ac: br.s IL_00cc
    IL_00ae: ldloc.s 4
    IL_00b0: ldloc.s 5
    IL_00b2: ldelem.ref
    IL_00b3: stloc.s 6
    IL_00b5: ldarg.0
    IL_00b6: ldfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_00bb: ldloc.s 6
    IL_00bd: callvirt bool System.Collections.Generic.List<UnityEngine.Collider>::Contains(!0)  /*0x0A0005C2*/
    IL_00c2: brfalse.s IL_00c6
    IL_00c4: ldc.i4.0
    IL_00c5: stloc.3
    IL_00c6: ldloc.s 5
    IL_00c8: ldc.i4.1
    IL_00c9: add
    IL_00ca: stloc.s 5
    IL_00cc: ldloc.s 5
    IL_00ce: ldloc.s 4
    IL_00d0: ldlen
    IL_00d1: conv.i4
    IL_00d2: blt.s IL_00ae
    IL_00d4: ldloc.3
    IL_00d5: brfalse.s IL_00e4
    IL_00d7: ldarg.0
    IL_00d8: call void SuspendPlayerCollisionUntilNoOverlap::SwitchBack()  /*0x06000E3C*/
    IL_00dd: ret
    IL_00de: ldarg.0
    IL_00df: call void SuspendPlayerCollisionUntilNoOverlap::SwitchBack()  /*0x06000E3C*/
    IL_00e4: ret

  .method SuspendPlayerCollisionUntilNoOverlap::.ctor()  // token 0x06000E3E rva 0x3f959 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool SuspendPlayerCollisionUntilNoOverlap::triggerOnEnable  /*0x0400107E*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<UnityEngine.Collider>::.ctor()  /*0x0A0005C3*/
    IL_000d: stfld List<Collider> SuspendPlayerCollisionUntilNoOverlap::targetColliders  /*0x04001080*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

