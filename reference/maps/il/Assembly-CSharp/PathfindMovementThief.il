// ===== PathfindMovementThief  (token 0x02000114) =====
  .method PathfindMovementThief::AtTarget()  // token 0x060005B5 rva 0x18474 attrs Public, HideBySig
    // code size 105 (0x69), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0010
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0016: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_001b: ldnull
    IL_001c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0021: brfalse.s IL_0037
    IL_0023: ldarg.0
    IL_0024: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0029: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_002e: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0033: brfalse.s IL_0037
    IL_0035: ldc.i4.0
    IL_0036: ret
    IL_0037: ldarg.0
    IL_0038: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0042: ldarg.0
    IL_0043: call Vector3 PathfindMovementEnemy::get_SeekToTargetPosSnappedtoNavmesh()  /*0x06000B0D*/
    IL_0048: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_004d: stloc.0
    IL_004e: ldloca.s 0
    IL_0050: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0055: ldarg.0
    IL_0056: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_005b: bge.un.s IL_0067
    IL_005d: ldarg.0
    IL_005e: ldfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_0063: ldc.i4.0
    IL_0064: ceq
    IL_0066: ret
    IL_0067: ldc.i4.0
    IL_0068: ret

  .method PathfindMovementThief::AtHome()  // token 0x060005B6 rva 0x184ec attrs Public, HideBySig
    // code size 47 (0x2f), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: call Vector3 PathfindMovementEnemy::get_HomePosition()  /*0x06000B10*/
    IL_0011: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0016: stloc.0
    IL_0017: ldloca.s 0
    IL_0019: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_001e: ldarg.0
    IL_001f: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_0024: bge.un.s IL_002d
    IL_0026: ldarg.0
    IL_0027: ldfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_002c: ret
    IL_002d: ldc.i4.0
    IL_002e: ret

  .method PathfindMovementThief::Awake()  // token 0x060005B7 rva 0x18527 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<ThiefController>  /*0x2B000040*/
    IL_0007: stfld ThiefController PathfindMovementThief::_thiefController  /*0x04000722*/
    IL_000c: ret

  .method PathfindMovementThief::Update()  // token 0x060005B8 rva 0x18538 attrs Family, Virtual, HideBySig
    // code size 68 (0x44), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ThiefController PathfindMovementThief::_thiefController  /*0x04000722*/
    IL_0006: callvirt bool ThiefController::get_IsComingHome()  /*0x06000602*/
    IL_000b: brfalse.s IL_0027
    IL_000d: ldarg.0
    IL_000e: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0013: ldarg.0
    IL_0014: ldfld float PathfindMovementThief::_returningSpeed  /*0x04000721*/
    IL_0019: beq.s IL_0027
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld float PathfindMovementThief::_returningSpeed  /*0x04000721*/
    IL_0022: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0027: ldarg.0
    IL_0028: ldfld ThiefController PathfindMovementThief::_thiefController  /*0x04000722*/
    IL_002d: callvirt bool ThiefController::get_IsStealing()  /*0x06000603*/
    IL_0032: brfalse.s IL_003d
    IL_0034: ldarg.0
    IL_0035: call bool PathfindMovementThief::AtTarget()  /*0x060005B5*/
    IL_003a: brfalse.s IL_003d
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: call void PathfindMovementEnemy::Update()  /*0x06000B1E*/
    IL_0043: ret

  .method PathfindMovementThief::ForcePathRecalculation()  // token 0x060005B9 rva 0x18588 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: stfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_000b: ret

  .method PathfindMovementThief::FindMoveToTarget()  // token 0x060005BA rva 0x18598 attrs Family, Virtual, HideBySig
    // code size 479 (0x1df), max stack 5, init locals
    .locals ([0] GraphNode, [1] int, [2] TaggedObject, [3] Vector3, [4] float, [5] TaggedObject, [6] Vector3, [7] float, [8] int, [9] TaggedObject, [10] Vector3, [11] float, [12] GraphNode, [13] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld ThiefController PathfindMovementThief::_thiefController  /*0x04000722*/
    IL_0006: callvirt bool ThiefController::get_IsComingHome()  /*0x06000602*/
    IL_000b: brfalse.s IL_0028
    IL_000d: ldarg.0
    IL_000e: ldnull
    IL_000f: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0014: ldarg.0
    IL_0015: ldc.i4.1
    IL_0016: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_001b: ldarg.0
    IL_001c: call void PathfindMovementThief::ForcePathRecalculation()  /*0x060005B9*/
    IL_0021: ldarg.0
    IL_0022: call Vector3 PathfindMovementEnemy::get_HomePosition()  /*0x06000B10*/
    IL_0027: ret
    IL_0028: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_002d: ldarg.0
    IL_002e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0038: call NNConstraint Pathfinding.NNConstraint::get_Walkable()  /*0x0A000261*/
    IL_003d: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0042: ldfld GraphNode Pathfinding.NNInfo::node  /*0x0A000263*/
    IL_0047: stloc.0
    IL_0048: ldc.i4.0
    IL_0049: stloc.1
    IL_004a: br IL_01c7
    IL_004f: ldarg.0
    IL_0050: ldfld List<TaggedObject> PathfindMovementThief::_candidates  /*0x04000723*/
    IL_0055: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_005a: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_005f: ldarg.0
    IL_0060: ldfld List<TaggedObject> PathfindMovementThief::_candidates  /*0x04000723*/
    IL_0065: ldarg.0
    IL_0066: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_006b: ldloc.1
    IL_006c: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0071: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0076: ldarg.0
    IL_0077: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_007c: ldloc.1
    IL_007d: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0082: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0087: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_008c: ldnull
    IL_008d: stloc.2
    IL_008e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0093: stloc.3
    IL_0094: ldc.r4 3.4028235E+38f
    IL_0099: stloc.s 4
    IL_009b: ldnull
    IL_009c: stloc.s 5
    IL_009e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00a3: stloc.s 6
    IL_00a5: ldc.r4 3.4028235E+38f
    IL_00aa: stloc.s 7
    IL_00ac: ldc.i4.0
    IL_00ad: stloc.s 8
    IL_00af: br IL_017c
    IL_00b4: ldarg.0
    IL_00b5: ldfld List<TaggedObject> PathfindMovementThief::_candidates  /*0x04000723*/
    IL_00ba: ldloc.s 8
    IL_00bc: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00c1: stloc.s 9
    IL_00c3: ldloc.s 9
    IL_00c5: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_00ca: ldnull
    IL_00cb: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00d0: brtrue.s IL_00e0
    IL_00d2: ldloc.s 9
    IL_00d4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d9: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00de: br.s IL_00f7
    IL_00e0: ldloc.s 9
    IL_00e2: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_00e7: ldarg.0
    IL_00e8: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ed: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f2: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_00f7: stloc.s 10
    IL_00f9: ldloc.s 10
    IL_00fb: ldarg.0
    IL_00fc: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0101: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0106: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_010b: stloc.s 13
    IL_010d: ldloca.s 13
    IL_010f: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0114: stloc.s 11
    IL_0116: ldloc.s 11
    IL_0118: ldarg.0
    IL_0119: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_011e: ldloc.1
    IL_011f: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0124: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0129: bgt.s IL_0176
    IL_012b: ldloc.s 11
    IL_012d: ldloc.s 7
    IL_012f: bge.un.s IL_013d
    IL_0131: ldloc.s 9
    IL_0133: stloc.s 5
    IL_0135: ldloc.s 10
    IL_0137: stloc.s 6
    IL_0139: ldloc.s 11
    IL_013b: stloc.s 7
    IL_013d: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0142: ldloc.s 10
    IL_0144: call NNConstraint Pathfinding.NNConstraint::get_Walkable()  /*0x0A000261*/
    IL_0149: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_014e: ldfld GraphNode Pathfinding.NNInfo::node  /*0x0A000263*/
    IL_0153: stloc.s 12
    IL_0155: ldloc.s 12
    IL_0157: brfalse.s IL_0176
    IL_0159: ldloc.0
    IL_015a: brfalse.s IL_0176
    IL_015c: ldloc.0
    IL_015d: ldloc.s 12
    IL_015f: call bool Pathfinding.PathUtilities::IsPathPossible(Pathfinding.GraphNode,Pathfinding.GraphNode)  /*0x0A000264*/
    IL_0164: brfalse.s IL_0176
    IL_0166: ldloc.s 11
    IL_0168: ldloc.s 4
    IL_016a: bge.un.s IL_0176
    IL_016c: ldloc.s 9
    IL_016e: stloc.2
    IL_016f: ldloc.s 10
    IL_0171: stloc.3
    IL_0172: ldloc.s 11
    IL_0174: stloc.s 4
    IL_0176: ldloc.s 8
    IL_0178: ldc.i4.1
    IL_0179: add
    IL_017a: stloc.s 8
    IL_017c: ldloc.s 8
    IL_017e: ldarg.0
    IL_017f: ldfld List<TaggedObject> PathfindMovementThief::_candidates  /*0x04000723*/
    IL_0184: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_0189: blt IL_00b4
    IL_018e: ldloc.2
    IL_018f: ldnull
    IL_0190: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0195: brfalse.s IL_01a7
    IL_0197: ldarg.0
    IL_0198: ldloc.2
    IL_0199: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_019e: ldarg.0
    IL_019f: ldc.i4.0
    IL_01a0: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_01a5: ldloc.3
    IL_01a6: ret
    IL_01a7: ldloc.s 5
    IL_01a9: ldnull
    IL_01aa: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01af: brfalse.s IL_01c3
    IL_01b1: ldarg.0
    IL_01b2: ldloc.s 5
    IL_01b4: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_01b9: ldarg.0
    IL_01ba: ldc.i4.0
    IL_01bb: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_01c0: ldloc.s 6
    IL_01c2: ret
    IL_01c3: ldloc.1
    IL_01c4: ldc.i4.1
    IL_01c5: add
    IL_01c6: stloc.1
    IL_01c7: ldloc.1
    IL_01c8: ldarg.0
    IL_01c9: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_01ce: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_01d3: blt IL_004f
    IL_01d8: ldarg.0
    IL_01d9: call Vector3 PathfindMovementEnemy::FindMoveToTarget()  /*0x06000B1D*/
    IL_01de: ret

  .method PathfindMovementThief::.ctor()  // token 0x060005BB rva 0x18783 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2.5f
    IL_0006: stfld float PathfindMovementThief::_returningSpeed  /*0x04000721*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stfld List<TaggedObject> PathfindMovementThief::_candidates  /*0x04000723*/
    IL_0016: ldarg.0
    IL_0017: call void PathfindMovementEnemy::.ctor()  /*0x06000B25*/
    IL_001c: ret

