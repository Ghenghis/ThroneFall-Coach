// ===== PathfindMovementBoss  (token 0x02000111) =====
  .method PathfindMovementBoss::GetRvoPriority(float)  // token 0x060005AB rva 0x181c6 attrs Family, Virtual, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PathfindMovementBoss::fixedPriority  /*0x0400071B*/
    IL_0006: ret

  .method PathfindMovementBoss::Update()  // token 0x060005AC rva 0x181d0 attrs Family, Virtual, HideBySig
    // code size 58 (0x3a), max stack 3, init locals
    .locals ([0] float, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: call Vector3 PathfindMovementEnemy::get_SeekToTargetPosSnappedtoNavmesh()  /*0x06000B0D*/
    IL_0011: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0016: stloc.1
    IL_0017: ldloca.s 1
    IL_0019: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_001e: stloc.0
    IL_001f: ldarg.0
    IL_0020: callvirt RVOController PathfindMovement::get_RVO()  /*0x06000B0A*/
    IL_0025: ldloc.0
    IL_0026: ldarg.0
    IL_0027: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_002c: clt
    IL_002e: stfld bool Pathfinding.RVO.RVOController::locked  /*0x0A00025A*/
    IL_0033: ldarg.0
    IL_0034: call void PathfindMovementEnemy::Update()  /*0x06000B1E*/
    IL_0039: ret

  .method PathfindMovementBoss::.ctor()  // token 0x060005AD rva 0x18216 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float PathfindMovementBoss::fixedPriority  /*0x0400071B*/
    IL_000b: ldarg.0
    IL_000c: call void PathfindMovementEnemy::.ctor()  /*0x06000B25*/
    IL_0011: ret

