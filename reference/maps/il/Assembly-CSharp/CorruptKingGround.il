// ===== CorruptKingGround  (token 0x020000A5) =====
  .method CorruptKingGround::Start()  // token 0x06000393 rva 0x100fd attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_0006: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_000b: stfld Hp CorruptKingGround::castleCenterHp  /*0x040004A3*/
    IL_0010: ret

  .method CorruptKingGround::Update()  // token 0x06000394 rva 0x10110 attrs Private, HideBySig
    // code size 142 (0x8e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp CorruptKingGround::castleCenterHp  /*0x040004A3*/
    IL_0006: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_000b: conv.r8
    IL_000c: ldarg.0
    IL_000d: ldfld Hp CorruptKingGround::hp  /*0x0400049C*/
    IL_0012: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0017: conv.r8
    IL_0018: ldc.r8 0.15
    IL_0021: add
    IL_0022: bge.un.s IL_0047
    IL_0024: ldarg.0
    IL_0025: ldfld PathfindMovementEnemy CorruptKingGround::pathfindMovement  /*0x0400049D*/
    IL_002a: ldarg.0
    IL_002b: ldfld List<TargetPriority> CorruptKingGround::attackIfOwnHealthHigherThanCastleCenter  /*0x0400049E*/
    IL_0030: stfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_0035: ldarg.0
    IL_0036: ldfld UnitDashJumpEnemy CorruptKingGround::dashJump  /*0x040004A0*/
    IL_003b: ldarg.0
    IL_003c: ldfld List<TargetPriority> CorruptKingGround::jumpIfOwnHealthHigherThanCastleCenter  /*0x040004A1*/
    IL_0041: stfld List<TargetPriority> UnitDashJumpEnemy::targetPriorities  /*0x040017BB*/
    IL_0046: ret
    IL_0047: ldarg.0
    IL_0048: ldfld Hp CorruptKingGround::castleCenterHp  /*0x040004A3*/
    IL_004d: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0052: conv.r8
    IL_0053: ldarg.0
    IL_0054: ldfld Hp CorruptKingGround::hp  /*0x0400049C*/
    IL_0059: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_005e: conv.r8
    IL_005f: ldc.r8 0.15
    IL_0068: add
    IL_0069: ble.un.s IL_008d
    IL_006b: ldarg.0
    IL_006c: ldfld PathfindMovementEnemy CorruptKingGround::pathfindMovement  /*0x0400049D*/
    IL_0071: ldarg.0
    IL_0072: ldfld List<TargetPriority> CorruptKingGround::attackIfOwnHealthLowerThanCastleCenter  /*0x0400049F*/
    IL_0077: stfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_007c: ldarg.0
    IL_007d: ldfld UnitDashJumpEnemy CorruptKingGround::dashJump  /*0x040004A0*/
    IL_0082: ldarg.0
    IL_0083: ldfld List<TargetPriority> CorruptKingGround::jumpIfOwnHealthLowerThanCastleCenter  /*0x040004A2*/
    IL_0088: stfld List<TargetPriority> UnitDashJumpEnemy::targetPriorities  /*0x040017BB*/
    IL_008d: ret

  .method CorruptKingGround::.ctor()  // token 0x06000395 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

