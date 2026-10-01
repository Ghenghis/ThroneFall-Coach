// ===== PathfindMovementEnemy  (token 0x0200020F) =====
  .method PathfindMovementEnemy::get_RVO()  // token 0x06000B0C rva 0x34e06 attrs Public, Virtual, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_SeekToTargetPosSnappedtoNavmesh()  // token 0x06000B0D rva 0x34e0e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_SeekToTargetObj()  // token 0x06000B0E rva 0x34e16 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_Path()  // token 0x06000B0F rva 0x34e1e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_HomePosition()  // token 0x06000B10 rva 0x34e26 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementEnemy::homePosition  /*0x04000DEB*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_NextPathPoint()  // token 0x06000B11 rva 0x34e2e attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_0006: ret

  .method PathfindMovementEnemy::get_IsSlowed()  // token 0x06000B12 rva 0x34e36 attrs Public, Virtual, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_0006: ldc.r4 0f
    IL_000b: cgt
    IL_000d: ret

  .method PathfindMovementEnemy::GetAgroFromObject(TaggedObject)  // token 0x06000B13 rva 0x34e48 attrs Public, Virtual, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    IL_0000: ldarg.1
    IL_0001: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_000f: ldc.i4.2
    IL_0010: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0015: brtrue.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: stfld TaggedObject PathfindMovementEnemy::agroPlayerTarget  /*0x04000DE0*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_0026: stfld float PathfindMovementEnemy::remainingPlayerAgroTime  /*0x04000DE1*/
    IL_002b: ldarg.0
    IL_002c: ldfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_0031: brtrue.s IL_0046
    IL_0033: ldarg.0
    IL_0034: ldfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_0039: ldc.r4 0f
    IL_003e: ble.un.s IL_0046
    IL_0040: ldarg.0
    IL_0041: call void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0046: ret

  .method PathfindMovementEnemy::OnDusk()  // token 0x06000B14 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementEnemy::OnDawn_AfterSunrise()  // token 0x06000B15 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementEnemy::OnDawn_BeforeSunrise()  // token 0x06000B16 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementEnemy::Start()  // token 0x06000B17 rva 0x34e9c attrs Private, HideBySig
    // code size 373 (0x175), max stack 5, init locals
    .locals ([0] List.Enumerator<TargetPriority>)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.Seeker>  /*0x2B00008B*/
    IL_0007: stfld Seeker PathfindMovementEnemy::seeker  /*0x04000DE2*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.RVO.RVOController>  /*0x2B000090*/
    IL_0013: stfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_001f: ldc.i4 2147483647
    IL_0024: and
    IL_0025: ldc.i4 1000
    IL_002a: rem
    IL_002b: conv.r4
    IL_002c: ldc.r4 1000f
    IL_0031: div
    IL_0032: ldarg.0
    IL_0033: ldfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_0038: mul
    IL_0039: stfld float PathfindMovementEnemy::pathStaggerOffset  /*0x04000DEA*/
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_0045: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_004a: mul
    IL_004b: ldarg.0
    IL_004c: ldfld float PathfindMovementEnemy::pathStaggerOffset  /*0x04000DEA*/
    IL_0051: add
    IL_0052: stfld float PathfindMovementEnemy::recalculatePathCooldown  /*0x04000DE9*/
    IL_0057: ldarg.0
    IL_0058: ldarg.0
    IL_0059: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0063: stfld Vector3 PathfindMovementEnemy::homePosition  /*0x04000DEB*/
    IL_0068: ldarg.0
    IL_0069: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_006e: ldarg.0
    IL_006f: ldfld Seeker PathfindMovementEnemy::seeker  /*0x04000DE2*/
    IL_0074: ldfld GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_0079: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_007e: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0083: ldarg.0
    IL_0084: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0089: ldarg.0
    IL_008a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_008f: ldc.r4 0.5f
    IL_0094: sub
    IL_0095: ldc.r4 0f
    IL_009a: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_009f: ldc.r4 0.5f
    IL_00a4: sub
    IL_00a5: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00aa: stfld Vector3 PathfindMovementEnemy::homeOffset  /*0x04000DF1*/
    IL_00af: ldarg.0
    IL_00b0: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_00b5: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_00ba: stloc.0
    IL_00bb: br.s IL_00d0
    IL_00bd: ldloca.s 0
    IL_00bf: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_00c4: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_00c9: ldc.i4.s 22
    IL_00cb: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_00d0: ldloca.s 0
    IL_00d2: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_00d7: brtrue.s IL_00bd
    IL_00d9: leave.s IL_00e9
    IL_00db: ldloca.s 0
    IL_00dd: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_00e3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e8: endfinally
    IL_00e9: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00ee: callvirt bool PerkManager::get_IceMagicActive()  /*0x06000984*/
    IL_00f3: brfalse.s IL_0123
    IL_00f5: ldarg.0
    IL_00f6: ldarg.0
    IL_00f7: ldfld float PathfindMovementEnemy::speedWhenSlowed  /*0x04000DF6*/
    IL_00fc: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0101: ldfld float PerkManager::iceMagic_AdditionalsSlowMutli  /*0x04000C10*/
    IL_0106: mul
    IL_0107: stfld float PathfindMovementEnemy::speedWhenSlowed  /*0x04000DF6*/
    IL_010c: ldarg.0
    IL_010d: ldarg.0
    IL_010e: ldfld float PathfindMovementEnemy::slowDurationMulti  /*0x04000DF4*/
    IL_0113: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0118: ldfld float PerkManager::iceMagic_SlowDurationMulti  /*0x04000C11*/
    IL_011d: mul
    IL_011e: stfld float PathfindMovementEnemy::slowDurationMulti  /*0x04000DF4*/
    IL_0123: ldarg.0
    IL_0124: ldarg.0
    IL_0125: ldfld Seeker PathfindMovementEnemy::seeker  /*0x04000DE2*/
    IL_012a: ldfld GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_012f: stfld GraphMask PathfindMovementEnemy::graphMaskOriginal  /*0x04000DF2*/
    IL_0134: ldarg.0
    IL_0135: ldarg.0
    IL_0136: ldfld string PathfindMovementEnemy::backupMovementGraph  /*0x04000DDE*/
    IL_013b: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_0140: stfld GraphMask PathfindMovementEnemy::graphMaskBackup  /*0x04000DF3*/
    IL_0145: ldarg.0
    IL_0146: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_014b: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0150: ldc.i4.4
    IL_0151: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0156: brfalse.s IL_016e
    IL_0158: ldsfld int EnemySpawner::totalEnemiesSpawnedThisWave  /*0x040007DA*/
    IL_015d: ldc.i4.2
    IL_015e: rem
    IL_015f: ldc.i4.1
    IL_0160: bne.un.s IL_016e
    IL_0162: ldarg.0
    IL_0163: ldarg.0
    IL_0164: ldfld GraphMask PathfindMovementEnemy::graphMaskBackup  /*0x04000DF3*/
    IL_0169: stfld GraphMask PathfindMovementEnemy::graphMaskOriginal  /*0x04000DF2*/
    IL_016e: ldarg.0
    IL_016f: call void PathfindMovementEnemy::SnapToNavmesh()  /*0x06000B22*/
    IL_0174: ret
    .try IL_00bb-IL_00db finally handler IL_00db-IL_00e9

  .method PathfindMovementEnemy::OriginalPathRequest()  // token 0x06000B18 rva 0x35030 attrs Public, HideBySig
    // code size 105 (0x69), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: callvirt Vector3 PathfindMovementEnemy::FindMoveToTarget()  /*0x06000B1D*/
    IL_0007: stfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_000c: ldarg.0
    IL_000d: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0012: ldarg.0
    IL_0013: ldfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_0018: ldarg.0
    IL_0019: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_001e: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0023: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0028: stfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0034: stfld Vector3 PathfindMovementEnemy::storeRequestedTargetPos  /*0x04000DF7*/
    IL_0039: ldarg.0
    IL_003a: ldfld Seeker PathfindMovementEnemy::seeker  /*0x04000DE2*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0050: ldarg.0
    IL_0051: ldftn void PathfindMovementEnemy::OriginalOnPathComplete(Pathfinding.Path)  /*0x06000B19*/
    IL_0057: newobj void Pathfinding.OnPathDelegate::.ctor(object,IntPtr)  /*0x0A0004DB*/
    IL_005c: ldarg.0
    IL_005d: ldfld GraphMask PathfindMovementEnemy::graphMaskOriginal  /*0x04000DF2*/
    IL_0062: callvirt Path Pathfinding.Seeker::StartPath(UnityEngine.Vector3,UnityEngine.Vector3,Pathfinding.OnPathDelegate,Pathfinding.GraphMask)  /*0x0A0004DC*/
    IL_0067: pop
    IL_0068: ret

  .method PathfindMovementEnemy::OriginalOnPathComplete(Pathfinding.Path)  // token 0x06000B19 rva 0x350a8 attrs Private, HideBySig
    // code size 132 (0x84), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld string PathfindMovementEnemy::backupMovementGraph  /*0x04000DDE*/
    IL_0006: ldstr ""
    IL_000b: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0010: brfalse.s IL_0067
    IL_0012: ldarg.1
    IL_0013: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_0018: brtrue.s IL_0027
    IL_001a: ldarg.1
    IL_001b: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0020: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0025: brtrue.s IL_002e
    IL_0027: ldarg.0
    IL_0028: call void PathfindMovementEnemy::BackupPathRequest()  /*0x06000B1A*/
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 PathfindMovementEnemy::storeRequestedTargetPos  /*0x04000DF7*/
    IL_0034: ldarg.1
    IL_0035: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_003a: ldarg.1
    IL_003b: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0040: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0045: ldc.i4.1
    IL_0046: sub
    IL_0047: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_004c: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0051: stloc.0
    IL_0052: ldloca.s 0
    IL_0054: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0059: ldc.r4 1f
    IL_005e: ble.un.s IL_0070
    IL_0060: ldarg.0
    IL_0061: call void PathfindMovementEnemy::BackupPathRequest()  /*0x06000B1A*/
    IL_0066: ret
    IL_0067: ldarg.1
    IL_0068: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_006d: brfalse.s IL_0070
    IL_006f: ret
    IL_0070: ldarg.0
    IL_0071: ldarg.1
    IL_0072: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0077: stfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_007c: ldarg.0
    IL_007d: ldc.i4.0
    IL_007e: stfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_0083: ret

  .method PathfindMovementEnemy::BackupPathRequest()  // token 0x06000B1A rva 0x35138 attrs Private, HideBySig
    // code size 105 (0x69), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: callvirt Vector3 PathfindMovementEnemy::FindMoveToTarget()  /*0x06000B1D*/
    IL_0007: stfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_000c: ldarg.0
    IL_000d: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0012: ldarg.0
    IL_0013: ldfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_0018: ldarg.0
    IL_0019: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_001e: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0023: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0028: stfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0034: stfld Vector3 PathfindMovementEnemy::storeRequestedTargetPos  /*0x04000DF7*/
    IL_0039: ldarg.0
    IL_003a: ldfld Seeker PathfindMovementEnemy::seeker  /*0x04000DE2*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0050: ldarg.0
    IL_0051: ldftn void PathfindMovementEnemy::BackupOnPathComplete(Pathfinding.Path)  /*0x06000B1C*/
    IL_0057: newobj void Pathfinding.OnPathDelegate::.ctor(object,IntPtr)  /*0x0A0004DB*/
    IL_005c: ldarg.0
    IL_005d: ldfld GraphMask PathfindMovementEnemy::graphMaskBackup  /*0x04000DF3*/
    IL_0062: callvirt Path Pathfinding.Seeker::StartPath(UnityEngine.Vector3,UnityEngine.Vector3,Pathfinding.OnPathDelegate,Pathfinding.GraphMask)  /*0x0A0004DC*/
    IL_0067: pop
    IL_0068: ret

  .method PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  // token 0x06000B1B rva 0x351ad attrs Public, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_000c: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0011: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0016: ret

  .method PathfindMovementEnemy::BackupOnPathComplete(Pathfinding.Path)  // token 0x06000B1C rva 0x351c5 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.1
    IL_000b: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0010: stfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.0
    IL_0017: stfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_001c: ret

  .method PathfindMovementEnemy::FindMoveToTarget()  // token 0x06000B1D rva 0x351e4 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 258 (0x102), max stack 6, init locals
    .locals ([0] Vector3, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: stfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_000e: ldarg.0
    IL_000f: ldfld float PathfindMovementEnemy::remainingPlayerAgroTime  /*0x04000DE1*/
    IL_0014: ldc.r4 0f
    IL_0019: ble.un.s IL_005f
    IL_001b: ldarg.0
    IL_001c: ldfld TaggedObject PathfindMovementEnemy::agroPlayerTarget  /*0x04000DE0*/
    IL_0021: ldnull
    IL_0022: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0027: brfalse.s IL_005f
    IL_0029: ldarg.0
    IL_002a: ldfld TaggedObject PathfindMovementEnemy::agroPlayerTarget  /*0x04000DE0*/
    IL_002f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0034: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0039: brtrue.s IL_005f
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: ldfld TaggedObject PathfindMovementEnemy::agroPlayerTarget  /*0x04000DE0*/
    IL_0042: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.1
    IL_0049: stfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_004e: ldarg.0
    IL_004f: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_0054: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0059: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005e: ret
    IL_005f: ldc.i4.0
    IL_0060: stloc.1
    IL_0061: br.s IL_00cd
    IL_0063: ldarg.0
    IL_0064: ldarg.0
    IL_0065: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_006a: ldloc.1
    IL_006b: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0070: stfld TargetPriority PathfindMovementEnemy::targetPrio  /*0x04000DED*/
    IL_0075: ldarg.0
    IL_0076: ldarg.0
    IL_0077: ldfld TargetPriority PathfindMovementEnemy::targetPrio  /*0x04000DED*/
    IL_007c: ldarg.0
    IL_007d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0082: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0087: ldarg.0
    IL_0088: ldfld Vector3 PathfindMovementEnemy::homePosition  /*0x04000DEB*/
    IL_008d: ldarg.0
    IL_008e: ldfld float PathfindMovementEnemy::maximumDistanceFromHome  /*0x04000DDB*/
    IL_0093: ldloca.s 0
    IL_0095: callvirt TaggedObject TargetPriority::FindTaggedObjectCloseToHome(UnityEngine.Vector3,UnityEngine.Vector3,float,ref UnityEngine.Vector3)  /*0x06000E7D*/
    IL_009a: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_009f: ldarg.0
    IL_00a0: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_00a5: ldnull
    IL_00a6: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00ab: brtrue.s IL_00c9
    IL_00ad: ldarg.0
    IL_00ae: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_00b3: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00b8: ldc.i4.2
    IL_00b9: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00be: brfalse.s IL_00c7
    IL_00c0: ldarg.0
    IL_00c1: ldc.i4.1
    IL_00c2: stfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_00c7: ldloc.0
    IL_00c8: ret
    IL_00c9: ldloc.1
    IL_00ca: ldc.i4.1
    IL_00cb: add
    IL_00cc: stloc.1
    IL_00cd: ldloc.1
    IL_00ce: ldarg.0
    IL_00cf: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_00d4: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_00d9: blt.s IL_0063
    IL_00db: ldarg.0
    IL_00dc: ldnull
    IL_00dd: stfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_00e2: ldarg.0
    IL_00e3: ldnull
    IL_00e4: stfld TargetPriority PathfindMovementEnemy::targetPrio  /*0x04000DED*/
    IL_00e9: ldarg.0
    IL_00ea: ldc.i4.1
    IL_00eb: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_00f0: ldarg.0
    IL_00f1: ldfld Vector3 PathfindMovementEnemy::homePosition  /*0x04000DEB*/
    IL_00f6: ldarg.0
    IL_00f7: ldfld Vector3 PathfindMovementEnemy::homeOffset  /*0x04000DF1*/
    IL_00fc: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0101: ret

  .method PathfindMovementEnemy::Update()  // token 0x06000B1E rva 0x352f4 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 204 (0xcc), max stack 3, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld float PathfindMovementEnemy::remainingPlayerAgroTime  /*0x04000DE1*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_001f
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float PathfindMovementEnemy::remainingPlayerAgroTime  /*0x04000DE1*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float PathfindMovementEnemy::remainingPlayerAgroTime  /*0x04000DE1*/
    IL_001f: ldarg.0
    IL_0020: ldfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_0025: brtrue.s IL_0035
    IL_0027: ldarg.0
    IL_0028: ldfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_002d: ldc.r4 2f
    IL_0032: mul
    IL_0033: br.s IL_003b
    IL_0035: ldarg.0
    IL_0036: ldfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_003b: stloc.0
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld float PathfindMovementEnemy::recalculatePathCooldown  /*0x04000DE9*/
    IL_0043: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0048: sub
    IL_0049: stfld float PathfindMovementEnemy::recalculatePathCooldown  /*0x04000DE9*/
    IL_004e: ldarg.0
    IL_004f: ldfld float PathfindMovementEnemy::recalculatePathCooldown  /*0x04000DE9*/
    IL_0054: ldc.r4 0f
    IL_0059: bgt.un.s IL_006f
    IL_005b: ldarg.0
    IL_005c: ldloc.0
    IL_005d: ldarg.0
    IL_005e: ldfld float PathfindMovementEnemy::pathStaggerOffset  /*0x04000DEA*/
    IL_0063: add
    IL_0064: stfld float PathfindMovementEnemy::recalculatePathCooldown  /*0x04000DE9*/
    IL_0069: ldarg.0
    IL_006a: call void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_006f: ldarg.0
    IL_0070: ldfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_0075: brfalse.s IL_00c5
    IL_0077: ldarg.0
    IL_0078: ldarg.0
    IL_0079: ldfld TaggedObject PathfindMovementEnemy::seekToTaggedObj  /*0x04000DE6*/
    IL_007e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0083: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0088: stfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_008d: ldarg.0
    IL_008e: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0093: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0098: ldc.i4.0
    IL_0099: ble.s IL_00b9
    IL_009b: ldarg.0
    IL_009c: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_00a7: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_00ac: ldc.i4.1
    IL_00ad: sub
    IL_00ae: ldarg.0
    IL_00af: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_00b4: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::set_Item(int,!0)  /*0x0A0004E0*/
    IL_00b9: ldarg.0
    IL_00ba: ldarg.0
    IL_00bb: ldfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_00c0: stfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_00c5: ldarg.0
    IL_00c6: call void PathfindMovementEnemy::FollowPathUpdate()  /*0x06000B20*/
    IL_00cb: ret

  .method PathfindMovementEnemy::Slow(float)  // token 0x06000B1F rva 0x353cc attrs Public, Virtual, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.0
    IL_0003: ldfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_0008: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_000d: stfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_0012: ret

  .method PathfindMovementEnemy::FollowPathUpdate()  // token 0x06000B20 rva 0x353e0 attrs Private, HideBySig
    // code size 965 (0x3c5), max stack 7, init locals
    .locals ([0] float, [1] float, [2] Vector3, [3] Vector3, [4] Vector3, [5] float, [6] Vector3, [7] int, [8] Vector2)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0006: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_000b: ldarg.0
    IL_000c: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_0011: bgt.s IL_003f
    IL_0013: ldarg.0
    IL_0014: ldfld bool PathfindMovementEnemy::currentlyChasingPlayer  /*0x04000DEE*/
    IL_0019: brfalse.s IL_003e
    IL_001b: ldarg.0
    IL_001c: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0021: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0026: ldc.i4.0
    IL_0027: ble.s IL_003e
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0030: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0035: ldc.i4.1
    IL_0036: sub
    IL_0037: stfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_003c: br.s IL_003f
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0046: ldarg.0
    IL_0047: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_004c: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0051: stfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_0056: ldarg.0
    IL_0057: ldarg.0
    IL_0058: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0062: ldarg.0
    IL_0063: ldfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_0068: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_006d: stloc.s 6
    IL_006f: ldloca.s 6
    IL_0071: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0076: stfld float PathfindMovementEnemy::distanceToTarget  /*0x04000DFB*/
    IL_007b: ldarg.0
    IL_007c: ldfld float PathfindMovementEnemy::distanceToTarget  /*0x04000DFB*/
    IL_0081: ldarg.0
    IL_0082: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_0087: bge.un.s IL_00b2
    IL_0089: ldarg.0
    IL_008a: ldfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_008f: brtrue.s IL_00b2
    IL_0091: ldarg.0
    IL_0092: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0097: stfld Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_009c: ldarg.0
    IL_009d: ldarg.0
    IL_009e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a8: stfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_00ad: br IL_016f
    IL_00b2: ldarg.0
    IL_00b3: ldarg.0
    IL_00b4: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_00b9: ldarg.0
    IL_00ba: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00bf: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c4: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00c9: stfld Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_00ce: ldc.i4.0
    IL_00cf: stloc.s 7
    IL_00d1: br IL_0166
    IL_00d6: ldarg.0
    IL_00d7: ldflda Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_00dc: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00e1: ldc.r4 1f
    IL_00e6: bgt.un IL_016f
    IL_00eb: ldarg.0
    IL_00ec: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_00f7: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_00fc: ldc.i4.1
    IL_00fd: sub
    IL_00fe: beq.s IL_016f
    IL_0100: ldarg.0
    IL_0101: ldarg.0
    IL_0102: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_0107: ldc.i4.1
    IL_0108: add
    IL_0109: stfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_010e: ldarg.0
    IL_010f: ldarg.0
    IL_0110: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_0115: ldc.i4.0
    IL_0116: ldarg.0
    IL_0117: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_011c: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0121: ldc.i4.1
    IL_0122: sub
    IL_0123: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0128: stfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_012d: ldarg.0
    IL_012e: ldarg.0
    IL_012f: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0134: ldarg.0
    IL_0135: ldfld int PathfindMovementEnemy::nextPathPointIndex  /*0x04000DE8*/
    IL_013a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_013f: stfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_0144: ldarg.0
    IL_0145: ldarg.0
    IL_0146: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_014b: ldarg.0
    IL_014c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0151: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0156: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_015b: stfld Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_0160: ldloc.s 7
    IL_0162: ldc.i4.1
    IL_0163: add
    IL_0164: stloc.s 7
    IL_0166: ldloc.s 7
    IL_0168: ldc.i4.s 100
    IL_016a: blt IL_00d6
    IL_016f: ldarg.0
    IL_0170: ldfld float PathfindMovementEnemy::solveStuckTimer  /*0x04000DFA*/
    IL_0175: ldc.r4 0f
    IL_017a: ble.un.s IL_01fb
    IL_017c: ldarg.0
    IL_017d: ldarg.0
    IL_017e: ldfld float PathfindMovementEnemy::solveStuckTimer  /*0x04000DFA*/
    IL_0183: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0188: sub
    IL_0189: stfld float PathfindMovementEnemy::solveStuckTimer  /*0x04000DFA*/
    IL_018e: ldarg.0
    IL_018f: ldarg.0
    IL_0190: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0195: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_019a: ldarg.0
    IL_019b: ldfld Vector3 PathfindMovementEnemy::escapeVector  /*0x04000DFD*/
    IL_01a0: ldc.r4 10f
    IL_01a5: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01aa: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01af: stfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_01b4: ldarg.0
    IL_01b5: ldc.r4 0f
    IL_01ba: ldc.r4 30f
    IL_01bf: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01c4: mul
    IL_01c5: ldc.r4 0f
    IL_01ca: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_01cf: ldarg.0
    IL_01d0: ldfld Vector3 PathfindMovementEnemy::escapeVector  /*0x04000DFD*/
    IL_01d5: call Vector3 UnityEngine.Quaternion::op_Multiply(UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A0000AA*/
    IL_01da: stfld Vector3 PathfindMovementEnemy::escapeVector  /*0x04000DFD*/
    IL_01df: ldarg.0
    IL_01e0: ldarg.0
    IL_01e1: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_01e6: ldarg.0
    IL_01e7: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01ec: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01f1: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01f6: stfld Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_01fb: ldarg.0
    IL_01fc: ldflda Vector3 PathfindMovementEnemy::fromToVector  /*0x04000DFC*/
    IL_0201: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0206: stloc.0
    IL_0207: ldarg.0
    IL_0208: ldfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_020d: ldarg.0
    IL_020e: ldloc.0
    IL_020f: callvirt float PathfindMovementEnemy::GetRvoPriority(float)  /*0x06000B21*/
    IL_0214: stfld float Pathfinding.RVO.RVOController::priority  /*0x0A0004E1*/
    IL_0219: ldarg.0
    IL_021a: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_021f: ldloc.0
    IL_0220: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0225: div
    IL_0226: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_022b: stloc.1
    IL_022c: ldarg.0
    IL_022d: ldfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_0232: ldc.r4 0f
    IL_0237: ble.un.s IL_0291
    IL_0239: ldarg.0
    IL_023a: ldfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_023f: ldarg.0
    IL_0240: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_0245: ldloc.1
    IL_0246: ldarg.0
    IL_0247: ldfld float PathfindMovementEnemy::speedWhenSlowed  /*0x04000DF6*/
    IL_024c: mul
    IL_024d: ldarg.0
    IL_024e: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0253: ldc.r4 1.15f
    IL_0258: mul
    IL_0259: ldarg.0
    IL_025a: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_025f: ldarg.0
    IL_0260: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0265: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_026a: ldc.i4.1
    IL_026b: sub
    IL_026c: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0271: callvirt void Pathfinding.RVO.RVOController::SetTarget(UnityEngine.Vector3,float,float,UnityEngine.Vector3)  /*0x0A0004E2*/
    IL_0276: ldarg.0
    IL_0277: ldarg.0
    IL_0278: ldfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_027d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0282: ldarg.0
    IL_0283: ldfld float PathfindMovementEnemy::slowDurationMulti  /*0x04000DF4*/
    IL_0288: div
    IL_0289: sub
    IL_028a: stfld float PathfindMovementEnemy::slowedFor  /*0x04000DF5*/
    IL_028f: br.s IL_02c7
    IL_0291: ldarg.0
    IL_0292: ldfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_0297: ldarg.0
    IL_0298: ldfld Vector3 PathfindMovementEnemy::nextPathPoint  /*0x04000DF0*/
    IL_029d: ldloc.1
    IL_029e: ldarg.0
    IL_029f: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_02a4: ldc.r4 1.15f
    IL_02a9: mul
    IL_02aa: ldarg.0
    IL_02ab: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_02b0: ldarg.0
    IL_02b1: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_02b6: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_02bb: ldc.i4.1
    IL_02bc: sub
    IL_02bd: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_02c2: callvirt void Pathfinding.RVO.RVOController::SetTarget(UnityEngine.Vector3,float,float,UnityEngine.Vector3)  /*0x0A0004E2*/
    IL_02c7: ldarg.0
    IL_02c8: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_02cd: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_02d2: ldarg.0
    IL_02d3: ldfld RVOController PathfindMovementEnemy::rvo  /*0x04000DE3*/
    IL_02d8: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_02dd: callvirt Vector3 Pathfinding.RVO.RVOController::CalculateMovementDelta(float)  /*0x0A0004E3*/
    IL_02e2: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_02e7: stloc.2
    IL_02e8: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_02ed: ldloc.2
    IL_02ee: ldarg.0
    IL_02ef: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_02f4: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_02f9: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_02fe: stloc.3
    IL_02ff: ldarg.0
    IL_0300: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0305: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_030a: ldloc.3
    IL_030b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0310: stloc.s 4
    IL_0312: ldloc.s 4
    IL_0314: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0319: ldloc.s 4
    IL_031b: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0320: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0325: stloc.s 8
    IL_0327: ldloca.s 8
    IL_0329: call float UnityEngine.Vector2::get_magnitude()  /*0x0A00015A*/
    IL_032e: stloc.s 5
    IL_0330: ldarg.0
    IL_0331: ldfld bool PathfindMovementEnemy::eneableStuckDetection  /*0x04000DF8*/
    IL_0336: brfalse.s IL_03af
    IL_0338: ldarg.0
    IL_0339: ldfld float PathfindMovementEnemy::solveStuckTimer  /*0x04000DFA*/
    IL_033e: ldc.r4 0f
    IL_0343: bgt.un.s IL_03af
    IL_0345: ldloc.s 5
    IL_0347: ldc.r4 0.001f
    IL_034c: bge.un.s IL_0370
    IL_034e: ldarg.0
    IL_034f: ldfld float PathfindMovementEnemy::distanceToTarget  /*0x04000DFB*/
    IL_0354: ldarg.0
    IL_0355: ldfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_035a: ble.un.s IL_0370
    IL_035c: ldarg.0
    IL_035d: ldarg.0
    IL_035e: ldfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_0363: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0368: add
    IL_0369: stfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_036e: br.s IL_038c
    IL_0370: ldarg.0
    IL_0371: ldc.r4 0f
    IL_0376: ldarg.0
    IL_0377: ldfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_037c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0381: sub
    IL_0382: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0387: stfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_038c: ldarg.0
    IL_038d: ldfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_0392: ldc.r4 3f
    IL_0397: ble.un.s IL_03af
    IL_0399: ldarg.0
    IL_039a: ldc.r4 0f
    IL_039f: stfld float PathfindMovementEnemy::stuckDetectionTimer  /*0x04000DF9*/
    IL_03a4: ldarg.0
    IL_03a5: ldc.r4 5f
    IL_03aa: stfld float PathfindMovementEnemy::solveStuckTimer  /*0x04000DFA*/
    IL_03af: ldloc.s 5
    IL_03b1: ldc.r4 2f
    IL_03b6: bge.un.s IL_03c4
    IL_03b8: ldarg.0
    IL_03b9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03be: ldloc.3
    IL_03bf: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_03c4: ret

  .method PathfindMovementEnemy::GetRvoPriority(float)  // token 0x06000B21 rva 0xb168 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 2 (0x2), max stack 8
    IL_0000: ldarg.1
    IL_0001: ret

  .method PathfindMovementEnemy::SnapToNavmesh()  // token 0x06000B22 rva 0x357b1 attrs Public, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: ldarg.0
    IL_0017: ldfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_001c: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0021: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0026: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_002b: ret

  .method PathfindMovementEnemy::ClearCurrentPath()  // token 0x06000B23 rva 0x357de attrs Public, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_0006: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Clear()  /*0x0A0004E4*/
    IL_000b: ret

  .method PathfindMovementEnemy::OnDuskEarly()  // token 0x06000B24 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementEnemy::.ctor()  // token 0x06000B25 rva 0x357ec attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 179 (0xb3), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0006: stfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float PathfindMovementEnemy::keepDistanceOf  /*0x04000DDA*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 100000f
    IL_001c: stfld float PathfindMovementEnemy::maximumDistanceFromHome  /*0x04000DDB*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 2f
    IL_0027: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float PathfindMovementEnemy::recalculatePathInterval  /*0x04000DDD*/
    IL_0037: ldarg.0
    IL_0038: ldstr ""
    IL_003d: stfld string PathfindMovementEnemy::backupMovementGraph  /*0x04000DDE*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 5f
    IL_0048: stfld float PathfindMovementEnemy::agroTimeWhenAttackedByPlayer  /*0x04000DDF*/
    IL_004d: ldarg.0
    IL_004e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0053: stfld Vector3 PathfindMovementEnemy::seekToTargetPosSnappedtoNavmesh  /*0x04000DE4*/
    IL_0058: ldarg.0
    IL_0059: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_005e: stfld Vector3 PathfindMovementEnemy::seekToTargetPos  /*0x04000DE5*/
    IL_0063: ldarg.0
    IL_0064: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_0069: stfld List<Vector3> PathfindMovementEnemy::path  /*0x04000DE7*/
    IL_006e: ldarg.0
    IL_006f: ldc.i4.1
    IL_0070: stfld bool PathfindMovementEnemy::currentlyWalkingHome  /*0x04000DEC*/
    IL_0075: ldarg.0
    IL_0076: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_007b: stfld NNConstraint PathfindMovementEnemy::nearestConstraint  /*0x04000DEF*/
    IL_0080: ldarg.0
    IL_0081: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0086: stfld Vector3 PathfindMovementEnemy::homeOffset  /*0x04000DF1*/
    IL_008b: ldarg.0
    IL_008c: ldc.r4 1f
    IL_0091: stfld float PathfindMovementEnemy::slowDurationMulti  /*0x04000DF4*/
    IL_0096: ldarg.0
    IL_0097: ldc.r4 0.33f
    IL_009c: stfld float PathfindMovementEnemy::speedWhenSlowed  /*0x04000DF6*/
    IL_00a1: ldarg.0
    IL_00a2: call Vector3 UnityEngine.Vector3::get_right()  /*0x0A0004D4*/
    IL_00a7: stfld Vector3 PathfindMovementEnemy::escapeVector  /*0x04000DFD*/
    IL_00ac: ldarg.0
    IL_00ad: call void PathfindMovement::.ctor()  /*0x06000B0B*/
    IL_00b2: ret

