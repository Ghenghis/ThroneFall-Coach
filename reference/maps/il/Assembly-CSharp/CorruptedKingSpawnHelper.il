// ===== CorruptedKingSpawnHelper  (token 0x02000021) =====
  .method CorruptedKingSpawnHelper::Start()  // token 0x060000BA rva 0x5224 attrs Private, HideBySig
    // code size 107 (0x6b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnitDashJumpEnemy>  /*0x2B00000D*/
    IL_0007: stfld UnitDashJumpEnemy CorruptedKingSpawnHelper::jumper  /*0x040000E0*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<PathfindMovementEnemy>  /*0x2B00000E*/
    IL_0013: stfld PathfindMovementEnemy CorruptedKingSpawnHelper::pathing  /*0x040000E1*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: ldfld PathfindMovementEnemy CorruptedKingSpawnHelper::pathing  /*0x040000E1*/
    IL_001f: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0024: stfld float CorruptedKingSpawnHelper::defaultMovementSpeed  /*0x040000E2*/
    IL_0029: ldarg.0
    IL_002a: ldfld UnitDashJumpEnemy CorruptedKingSpawnHelper::jumper  /*0x040000E0*/
    IL_002f: ldc.i4.0
    IL_0030: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0035: ldarg.0
    IL_0036: ldfld PathfindMovementEnemy CorruptedKingSpawnHelper::pathing  /*0x040000E1*/
    IL_003b: ldc.r4 0f
    IL_0040: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0045: ldarg.0
    IL_0046: ldfld GameObject CorruptedKingSpawnHelper::meshParent  /*0x040000DB*/
    IL_004b: ldc.i4.0
    IL_004c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0051: ldarg.0
    IL_0052: ldfld Cloth CorruptedKingSpawnHelper::cloth  /*0x040000DC*/
    IL_0057: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_005c: brfalse.s IL_006a
    IL_005e: ldarg.0
    IL_005f: ldfld Cloth CorruptedKingSpawnHelper::cloth  /*0x040000DC*/
    IL_0064: ldc.i4.0
    IL_0065: callvirt void UnityEngine.Cloth::set_enabled(bool)  /*0x0A000093*/
    IL_006a: ret

  .method CorruptedKingSpawnHelper::Update()  // token 0x060000BB rva 0x529c attrs Private, HideBySig
    // code size 202 (0xca), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float CorruptedKingSpawnHelper::clock  /*0x040000E3*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float CorruptedKingSpawnHelper::clock  /*0x040000E3*/
    IL_0012: ldarg.0
    IL_0013: ldfld float CorruptedKingSpawnHelper::clock  /*0x040000E3*/
    IL_0018: ldarg.0
    IL_0019: ldfld float CorruptedKingSpawnHelper::movementFreeze  /*0x040000DE*/
    IL_001e: ble.un.s IL_0040
    IL_0020: ldarg.0
    IL_0021: ldfld bool CorruptedKingSpawnHelper::movementActive  /*0x040000E4*/
    IL_0026: brtrue.s IL_0040
    IL_0028: ldarg.0
    IL_0029: ldc.i4.1
    IL_002a: stfld bool CorruptedKingSpawnHelper::movementActive  /*0x040000E4*/
    IL_002f: ldarg.0
    IL_0030: ldfld PathfindMovementEnemy CorruptedKingSpawnHelper::pathing  /*0x040000E1*/
    IL_0035: ldarg.0
    IL_0036: ldfld float CorruptedKingSpawnHelper::defaultMovementSpeed  /*0x040000E2*/
    IL_003b: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0040: ldarg.0
    IL_0041: ldfld float CorruptedKingSpawnHelper::clock  /*0x040000E3*/
    IL_0046: ldarg.0
    IL_0047: ldfld float CorruptedKingSpawnHelper::jumpFreeze  /*0x040000DF*/
    IL_004c: ble.un.s IL_0069
    IL_004e: ldarg.0
    IL_004f: ldfld bool CorruptedKingSpawnHelper::jumpingActive  /*0x040000E5*/
    IL_0054: brtrue.s IL_0069
    IL_0056: ldarg.0
    IL_0057: ldc.i4.1
    IL_0058: stfld bool CorruptedKingSpawnHelper::jumpingActive  /*0x040000E5*/
    IL_005d: ldarg.0
    IL_005e: ldfld UnitDashJumpEnemy CorruptedKingSpawnHelper::jumper  /*0x040000E0*/
    IL_0063: ldc.i4.1
    IL_0064: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0069: ldarg.0
    IL_006a: ldfld float CorruptedKingSpawnHelper::clock  /*0x040000E3*/
    IL_006f: ldarg.0
    IL_0070: ldfld float CorruptedKingSpawnHelper::meshHide  /*0x040000DD*/
    IL_0075: ble.un.s IL_00ab
    IL_0077: ldarg.0
    IL_0078: ldfld bool CorruptedKingSpawnHelper::meshActive  /*0x040000E6*/
    IL_007d: brtrue.s IL_00ab
    IL_007f: ldarg.0
    IL_0080: ldc.i4.1
    IL_0081: stfld bool CorruptedKingSpawnHelper::meshActive  /*0x040000E6*/
    IL_0086: ldarg.0
    IL_0087: ldfld GameObject CorruptedKingSpawnHelper::meshParent  /*0x040000DB*/
    IL_008c: ldc.i4.1
    IL_008d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0092: ldarg.0
    IL_0093: ldfld Cloth CorruptedKingSpawnHelper::cloth  /*0x040000DC*/
    IL_0098: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009d: brfalse.s IL_00ab
    IL_009f: ldarg.0
    IL_00a0: ldfld Cloth CorruptedKingSpawnHelper::cloth  /*0x040000DC*/
    IL_00a5: ldc.i4.1
    IL_00a6: callvirt void UnityEngine.Cloth::set_enabled(bool)  /*0x0A000093*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld bool CorruptedKingSpawnHelper::jumpingActive  /*0x040000E5*/
    IL_00b1: brfalse.s IL_00c9
    IL_00b3: ldarg.0
    IL_00b4: ldfld bool CorruptedKingSpawnHelper::movementActive  /*0x040000E4*/
    IL_00b9: brfalse.s IL_00c9
    IL_00bb: ldarg.0
    IL_00bc: ldfld bool CorruptedKingSpawnHelper::meshActive  /*0x040000E6*/
    IL_00c1: brfalse.s IL_00c9
    IL_00c3: ldarg.0
    IL_00c4: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00c9: ret

  .method CorruptedKingSpawnHelper::.ctor()  // token 0x060000BC rva 0x5372 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float CorruptedKingSpawnHelper::meshHide  /*0x040000DD*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float CorruptedKingSpawnHelper::movementFreeze  /*0x040000DE*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 6f
    IL_001c: stfld float CorruptedKingSpawnHelper::jumpFreeze  /*0x040000DF*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

