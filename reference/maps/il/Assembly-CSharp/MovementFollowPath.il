// ===== MovementFollowPath  (token 0x020001FC) =====
  .method MovementFollowPath::Start()  // token 0x06000A98 rva 0x32b04 attrs Private, HideBySig
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.RVO.RVOController>  /*0x2B000090*/
    IL_0007: stfld RVOController MovementFollowPath::rvo  /*0x04000D74*/
    IL_000c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0011: ldfld Equippable PerkManager::falconGodPerk  /*0x04000C00*/
    IL_0016: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_001b: brfalse.s IL_0034
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: ldfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_0024: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0029: ldfld float PerkManager::tauntTheFalcon_speedMultiplyer  /*0x04000BFE*/
    IL_002e: mul
    IL_002f: stfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld Transform MovementFollowPath::pathParent  /*0x04000D6F*/
    IL_003b: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0040: newarr UnityEngine.Transform  /*0x01000015*/
    IL_0045: stfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_004a: ldc.i4.0
    IL_004b: stloc.0
    IL_004c: br.s IL_0066
    IL_004e: ldarg.0
    IL_004f: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_0054: ldloc.0
    IL_0055: ldarg.0
    IL_0056: ldfld Transform MovementFollowPath::pathParent  /*0x04000D6F*/
    IL_005b: ldloc.0
    IL_005c: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0061: stelem.ref
    IL_0062: ldloc.0
    IL_0063: ldc.i4.1
    IL_0064: add
    IL_0065: stloc.0
    IL_0066: ldloc.0
    IL_0067: ldarg.0
    IL_0068: ldfld Transform MovementFollowPath::pathParent  /*0x04000D6F*/
    IL_006d: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0072: blt.s IL_004e
    IL_0074: ldarg.0
    IL_0075: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_007a: ldlen
    IL_007b: brfalse.s IL_0095
    IL_007d: ldarg.0
    IL_007e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0083: ldarg.0
    IL_0084: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_0089: ldc.i4.0
    IL_008a: ldelem.ref
    IL_008b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0090: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0095: ret

  .method MovementFollowPath::Update()  // token 0x06000A99 rva 0x32ba6 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool MovementFollowPath::isMoving  /*0x04000D73*/
    IL_0006: brfalse.s IL_0018
    IL_0008: ldarg.0
    IL_0009: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_000e: ldlen
    IL_000f: brfalse.s IL_0018
    IL_0011: ldarg.0
    IL_0012: call void MovementFollowPath::MoveAlongPath()  /*0x06000A9A*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldfld RVOController MovementFollowPath::rvo  /*0x04000D74*/
    IL_001e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0023: callvirt void Pathfinding.RVO.RVOController::set_velocity(UnityEngine.Vector3)  /*0x0A0004C3*/
    IL_0028: ret

  .method MovementFollowPath::MoveAlongPath()  // token 0x06000A9A rva 0x32bd0 attrs Private, HideBySig
    // code size 240 (0xf0), max stack 4, init locals
    .locals ([0] Vector3, [1] Transform, [2] float, [3] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld int MovementFollowPath::currentPointIndex  /*0x04000D72*/
    IL_0006: ldarg.0
    IL_0007: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_000c: ldlen
    IL_000d: conv.i4
    IL_000e: bge IL_00df
    IL_0013: ldarg.0
    IL_0014: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001e: stloc.0
    IL_001f: ldarg.0
    IL_0020: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_0025: ldarg.0
    IL_0026: ldfld int MovementFollowPath::currentPointIndex  /*0x04000D72*/
    IL_002b: ldelem.ref
    IL_002c: stloc.1
    IL_002d: ldarg.0
    IL_002e: ldfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_0033: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0038: mul
    IL_0039: stloc.2
    IL_003a: ldarg.0
    IL_003b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0040: ldarg.0
    IL_0041: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0046: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004b: ldloc.1
    IL_004c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0051: ldloc.2
    IL_0052: call Vector3 UnityEngine.Vector3::MoveTowards(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000173*/
    IL_0057: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_005c: ldarg.0
    IL_005d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0062: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0067: ldloc.1
    IL_0068: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006d: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_0072: ldc.r4 0.1f
    IL_0077: bge.un.s IL_00af
    IL_0079: ldarg.0
    IL_007a: ldarg.0
    IL_007b: ldfld int MovementFollowPath::currentPointIndex  /*0x04000D72*/
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stfld int MovementFollowPath::currentPointIndex  /*0x04000D72*/
    IL_0087: ldarg.0
    IL_0088: ldfld int MovementFollowPath::currentPointIndex  /*0x04000D72*/
    IL_008d: ldarg.0
    IL_008e: ldfld Transform[] MovementFollowPath::pathPoints  /*0x04000D71*/
    IL_0093: ldlen
    IL_0094: conv.i4
    IL_0095: blt.s IL_00af
    IL_0097: ldarg.0
    IL_0098: ldc.i4.0
    IL_0099: stfld bool MovementFollowPath::isMoving  /*0x04000D73*/
    IL_009e: ldarg.0
    IL_009f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a4: ldloc.1
    IL_00a5: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00aa: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00af: ldarg.0
    IL_00b0: ldfld RVOController MovementFollowPath::rvo  /*0x04000D74*/
    IL_00b5: ldarg.0
    IL_00b6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00bb: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c0: ldloc.0
    IL_00c1: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00c6: stloc.3
    IL_00c7: ldloca.s 3
    IL_00c9: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_00d4: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00d9: callvirt void Pathfinding.RVO.RVOController::set_velocity(UnityEngine.Vector3)  /*0x0A0004C3*/
    IL_00de: ret
    IL_00df: ldarg.0
    IL_00e0: ldfld RVOController MovementFollowPath::rvo  /*0x04000D74*/
    IL_00e5: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00ea: callvirt void Pathfinding.RVO.RVOController::set_velocity(UnityEngine.Vector3)  /*0x0A0004C3*/
    IL_00ef: ret

  .method MovementFollowPath::.ctor()  // token 0x06000A9B rva 0x32ccc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float MovementFollowPath::speed  /*0x04000D70*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.1
    IL_000d: stfld bool MovementFollowPath::isMoving  /*0x04000D73*/
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0018: ret

