// ===== PathfindMovementPlayerunit  (token 0x02000210) =====
  .method PathfindMovementPlayerunit::get_RVO()  // token 0x06000B26 rva 0x358ab attrs Public, Virtual, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RVOController PathfindMovementPlayerunit::rvo  /*0x04000E08*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_SeekToTargetPosSnappedtoNavmesh()  // token 0x06000B27 rva 0x358b3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_SeekToTaggedObj()  // token 0x06000B28 rva 0x358bb attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_HomePositionOriginal()  // token 0x06000B29 rva 0x358c3 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementPlayerunit::homePositionOriginal  /*0x04000E10*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_HomePosition()  // token 0x06000B2A rva 0x358cb attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  // token 0x06000B2B rva 0x358d3 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0007: ret

  .method PathfindMovementPlayerunit::get_NextPathPoint()  // token 0x06000B2C rva 0x358dc attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_FollowingPlayer()  // token 0x06000B2D rva 0x358e4 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::followingPlayer  /*0x04000E17*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::FollowPlayer(bool)  // token 0x06000B2E rva 0x358ec attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool PathfindMovementPlayerunit::followingPlayer  /*0x04000E17*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_000e: ret

  .method PathfindMovementPlayerunit::get_IsSlowed()  // token 0x06000B2F rva 0x358fc attrs Public, Virtual, HideBySig, SpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PathfindMovementPlayerunit::slowedFor  /*0x04000E1A*/
    IL_0006: ldc.r4 0f
    IL_000b: cgt
    IL_000d: ret

  .method PathfindMovementPlayerunit::get_HasReachedHomePositionAlready()  // token 0x06000B30 rva 0x3590b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::hasReachedHomePositionAlready  /*0x04000E1F*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::set_HasReachedHomePositionAlready(bool)  // token 0x06000B31 rva 0x35913 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool PathfindMovementPlayerunit::hasReachedHomePositionAlready  /*0x04000E1F*/
    IL_0007: ret

  .method PathfindMovementPlayerunit::get_Flying()  // token 0x06000B32 rva 0x3591c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::flying  /*0x04000E20*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::get_HoldPosition()  // token 0x06000B33 rva 0x35924 attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::holdPosition  /*0x04000E1C*/
    IL_0006: ret

  .method PathfindMovementPlayerunit::set_HoldPosition(bool)  // token 0x06000B34 rva 0x3592c attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 240 (0xf0), max stack 4, init locals
    .locals ([0] AutoAttack[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::holdPosition  /*0x04000E1C*/
    IL_0006: ldarg.1
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_000f: ldfld bool PlayerUpgradeManager::commander  /*0x04000F29*/
    IL_0014: brfalse IL_00aa
    IL_0019: ldarg.1
    IL_001a: brfalse.s IL_0061
    IL_001c: ldarg.0
    IL_001d: ldfld Hp PathfindMovementPlayerunit::hp  /*0x04000E21*/
    IL_0022: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0027: ldfld float CommandUnits::commanderHoldHealthMulti  /*0x04000DBB*/
    IL_002c: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_0031: ldarg.0
    IL_0032: ldfld AutoAttack[] PathfindMovementPlayerunit::autoAttacks  /*0x04000E22*/
    IL_0037: stloc.0
    IL_0038: ldc.i4.0
    IL_0039: stloc.1
    IL_003a: br.s IL_0059
    IL_003c: ldloc.0
    IL_003d: ldloc.1
    IL_003e: ldelem.ref
    IL_003f: dup
    IL_0040: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0045: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_004a: ldfld float CommandUnits::commanderHoldDamageMulti  /*0x04000DBC*/
    IL_004f: mul
    IL_0050: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0055: ldloc.1
    IL_0056: ldc.i4.1
    IL_0057: add
    IL_0058: stloc.1
    IL_0059: ldloc.1
    IL_005a: ldloc.0
    IL_005b: ldlen
    IL_005c: conv.i4
    IL_005d: blt.s IL_003c
    IL_005f: br.s IL_00aa
    IL_0061: ldarg.0
    IL_0062: ldfld Hp PathfindMovementPlayerunit::hp  /*0x04000E21*/
    IL_0067: ldc.r4 1f
    IL_006c: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0071: ldfld float CommandUnits::commanderHoldHealthMulti  /*0x04000DBB*/
    IL_0076: div
    IL_0077: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_007c: ldarg.0
    IL_007d: ldfld AutoAttack[] PathfindMovementPlayerunit::autoAttacks  /*0x04000E22*/
    IL_0082: stloc.0
    IL_0083: ldc.i4.0
    IL_0084: stloc.1
    IL_0085: br.s IL_00a4
    IL_0087: ldloc.0
    IL_0088: ldloc.1
    IL_0089: ldelem.ref
    IL_008a: dup
    IL_008b: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0090: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_0095: ldfld float CommandUnits::commanderHoldDamageMulti  /*0x04000DBC*/
    IL_009a: div
    IL_009b: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_00a0: ldloc.1
    IL_00a1: ldc.i4.1
    IL_00a2: add
    IL_00a3: stloc.1
    IL_00a4: ldloc.1
    IL_00a5: ldloc.0
    IL_00a6: ldlen
    IL_00a7: conv.i4
    IL_00a8: blt.s IL_0087
    IL_00aa: ldarg.0
    IL_00ab: ldarg.1
    IL_00ac: stfld bool PathfindMovementPlayerunit::holdPosition  /*0x04000E1C*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld GameObject PathfindMovementPlayerunit::holdPositionMarker  /*0x04000E18*/
    IL_00b7: ldarg.1
    IL_00b8: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00bd: ldarg.0
    IL_00be: ldfld Transform PathfindMovementPlayerunit::holdPositionMarkerTransform  /*0x04000E19*/
    IL_00c3: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c8: brfalse.s IL_00ef
    IL_00ca: ldarg.0
    IL_00cb: ldfld Transform PathfindMovementPlayerunit::holdPositionMarkerTransform  /*0x04000E19*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_00d6: ldc.r4 0.05f
    IL_00db: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00e0: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_00e5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00ea: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00ef: ret

  .method PathfindMovementPlayerunit::GetAgroFromObject(TaggedObject)  // token 0x06000B35 rva 0x25f1 attrs Public, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementPlayerunit::OnDisable()  // token 0x06000B36 rva 0x35a28 attrs Private, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PathfindMovementPlayerunit::holdPositionMarker  /*0x04000E18*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject PathfindMovementPlayerunit::holdPositionMarker  /*0x04000E18*/
    IL_0013: ldc.i4.0
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ret

  .method PathfindMovementPlayerunit::OnEnable()  // token 0x06000B37 rva 0x35a43 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_0007: ret

  .method PathfindMovementPlayerunit::OnDuskEarly()  // token 0x06000B38 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementPlayerunit::OnDusk()  // token 0x06000B39 rva 0x35a4c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool PathfindMovementPlayerunit::day  /*0x04000E1B*/
    IL_0007: ret

  .method PathfindMovementPlayerunit::OnDawn_AfterSunrise()  // token 0x06000B3A rva 0x35a55 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool PathfindMovementPlayerunit::day  /*0x04000E1B*/
    IL_0007: ret

  .method PathfindMovementPlayerunit::OnDawn_BeforeSunrise()  // token 0x06000B3B rva 0x35a5e attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SettingsManager PathfindMovementPlayerunit::settingsManager  /*0x04000E16*/
    IL_0006: callvirt bool SettingsManager::get_ResetUnitFormationEveryMorning()  /*0x06000DA6*/
    IL_000b: brfalse.s IL_0020
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld Vector3 PathfindMovementPlayerunit::homePositionOriginal  /*0x04000E10*/
    IL_0014: stfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0019: ldarg.0
    IL_001a: ldc.i4.0
    IL_001b: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_0020: ret

  .method PathfindMovementPlayerunit::Start()  // token 0x06000B3C rva 0x35a80 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 197 (0xc5), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0006: stfld SettingsManager PathfindMovementPlayerunit::settingsManager  /*0x04000E16*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject PathfindMovementPlayerunit::holdPositionMarker  /*0x04000E18*/
    IL_0012: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0017: stfld Transform PathfindMovementPlayerunit::holdPositionMarkerTransform  /*0x04000E19*/
    IL_001c: ldarg.0
    IL_001d: ldfld Transform PathfindMovementPlayerunit::holdPositionMarkerTransform  /*0x04000E19*/
    IL_0022: ldnull
    IL_0023: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.0
    IL_002a: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.Seeker>  /*0x2B00008B*/
    IL_0036: stfld Seeker PathfindMovementPlayerunit::seeker  /*0x04000E07*/
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.RVO.RVOController>  /*0x2B000090*/
    IL_0042: stfld RVOController PathfindMovementPlayerunit::rvo  /*0x04000E08*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldfld float PathfindMovementPlayerunit::recalculatePathInterval  /*0x04000E02*/
    IL_004e: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0053: mul
    IL_0054: stfld float PathfindMovementPlayerunit::recalculatePathCooldown  /*0x04000E0E*/
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0060: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0065: stfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_006a: ldarg.0
    IL_006b: ldarg.0
    IL_006c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: stfld Vector3 PathfindMovementPlayerunit::homePositionOriginal  /*0x04000E10*/
    IL_007b: ldarg.0
    IL_007c: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_0081: ldarg.0
    IL_0082: ldfld Seeker PathfindMovementPlayerunit::seeker  /*0x04000E07*/
    IL_0087: ldfld GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_008c: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_0091: ldarg.0
    IL_0092: ldarg.0
    IL_0093: ldfld Seeker PathfindMovementPlayerunit::seeker  /*0x04000E07*/
    IL_0098: ldfld GraphMask Pathfinding.Seeker::graphMask  /*0x0A0002D1*/
    IL_009d: stfld GraphMask PathfindMovementPlayerunit::graphMaskOriginal  /*0x04000E14*/
    IL_00a2: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_00a7: ldarg.0
    IL_00a8: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_00ad: ldarg.0
    IL_00ae: ldarg.0
    IL_00af: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_00b4: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00b9: ldc.i4.6
    IL_00ba: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00bf: stfld bool PathfindMovementPlayerunit::flying  /*0x04000E20*/
    IL_00c4: ret

  .method PathfindMovementPlayerunit::OriginalPathRequest()  // token 0x06000B3D rva 0x35b54 attrs Public, HideBySig
    // code size 105 (0x69), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Vector3 PathfindMovementPlayerunit::FindMoveToTarget()  /*0x06000B42*/
    IL_0007: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_000c: ldarg.0
    IL_000d: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0012: ldarg.0
    IL_0013: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_0018: ldarg.0
    IL_0019: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_001e: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0023: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0028: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0034: stfld Vector3 PathfindMovementPlayerunit::storeRequestedTargetPos  /*0x04000E23*/
    IL_0039: ldarg.0
    IL_003a: ldfld Seeker PathfindMovementPlayerunit::seeker  /*0x04000E07*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0050: ldarg.0
    IL_0051: ldftn void PathfindMovementPlayerunit::OriginalOnPathComplete(Pathfinding.Path)  /*0x06000B3E*/
    IL_0057: newobj void Pathfinding.OnPathDelegate::.ctor(object,IntPtr)  /*0x0A0004DB*/
    IL_005c: ldarg.0
    IL_005d: ldfld GraphMask PathfindMovementPlayerunit::graphMaskOriginal  /*0x04000E14*/
    IL_0062: callvirt Path Pathfinding.Seeker::StartPath(UnityEngine.Vector3,UnityEngine.Vector3,Pathfinding.OnPathDelegate,Pathfinding.GraphMask)  /*0x0A0004DC*/
    IL_0067: pop
    IL_0068: ret

  .method PathfindMovementPlayerunit::OriginalOnPathComplete(Pathfinding.Path)  // token 0x06000B3E rva 0x35bcc attrs Private, HideBySig
    // code size 119 (0x77), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld string PathfindMovementPlayerunit::backupMovementGraph  /*0x04000E03*/
    IL_0006: ldstr ""
    IL_000b: call bool System.String::op_Inequality(string,string)  /*0x0A00002D*/
    IL_0010: brfalse.s IL_005a
    IL_0012: ldarg.1
    IL_0013: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_0018: brfalse.s IL_0021
    IL_001a: ldarg.0
    IL_001b: call void PathfindMovementPlayerunit::BackupPathRequest()  /*0x06000B3F*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld Vector3 PathfindMovementPlayerunit::storeRequestedTargetPos  /*0x04000E23*/
    IL_0027: ldarg.1
    IL_0028: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_002d: ldarg.1
    IL_002e: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0033: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0038: ldc.i4.1
    IL_0039: sub
    IL_003a: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_003f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0044: stloc.0
    IL_0045: ldloca.s 0
    IL_0047: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_004c: ldc.r4 0.1f
    IL_0051: ble.un.s IL_0063
    IL_0053: ldarg.0
    IL_0054: call void PathfindMovementPlayerunit::BackupPathRequest()  /*0x06000B3F*/
    IL_0059: ret
    IL_005a: ldarg.1
    IL_005b: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_0060: brfalse.s IL_0063
    IL_0062: ret
    IL_0063: ldarg.0
    IL_0064: ldarg.1
    IL_0065: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_006a: stfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_006f: ldarg.0
    IL_0070: ldc.i4.0
    IL_0071: stfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0076: ret

  .method PathfindMovementPlayerunit::BackupPathRequest()  // token 0x06000B3F rva 0x35c50 attrs Private, HideBySig
    // code size 110 (0x6e), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Vector3 PathfindMovementPlayerunit::FindMoveToTarget()  /*0x06000B42*/
    IL_0007: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_000c: ldarg.0
    IL_000d: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0012: ldarg.0
    IL_0013: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_0018: ldarg.0
    IL_0019: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_001e: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0023: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0028: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0034: stfld Vector3 PathfindMovementPlayerunit::storeRequestedTargetPos  /*0x04000E23*/
    IL_0039: ldarg.0
    IL_003a: ldfld Seeker PathfindMovementPlayerunit::seeker  /*0x04000E07*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0050: ldarg.0
    IL_0051: ldftn void PathfindMovementPlayerunit::BackupOnPathComplete(Pathfinding.Path)  /*0x06000B40*/
    IL_0057: newobj void Pathfinding.OnPathDelegate::.ctor(object,IntPtr)  /*0x0A0004DB*/
    IL_005c: ldarg.0
    IL_005d: ldfld string PathfindMovementPlayerunit::backupMovementGraph  /*0x04000E03*/
    IL_0062: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_0067: callvirt Path Pathfinding.Seeker::StartPath(UnityEngine.Vector3,UnityEngine.Vector3,Pathfinding.OnPathDelegate,Pathfinding.GraphMask)  /*0x0A0004DC*/
    IL_006c: pop
    IL_006d: ret

  .method PathfindMovementPlayerunit::BackupOnPathComplete(Pathfinding.Path)  // token 0x06000B40 rva 0x35cca attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt bool Pathfinding.Path::get_error()  /*0x0A0004DD*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.1
    IL_000b: ldfld List<Vector3> Pathfinding.Path::vectorPath  /*0x0A0004DE*/
    IL_0010: stfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.0
    IL_0017: stfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_001c: ret

  .method PathfindMovementPlayerunit::FindTargetPosition()  // token 0x06000B41 rva 0x35ce8 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 173 (0xad), max stack 6, init locals
    .locals ([0] Vector3, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.1
    IL_0002: br IL_0090
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_000e: ldloc.1
    IL_000f: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0014: stfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0019: ldarg.0
    IL_001a: ldfld bool PathfindMovementPlayerunit::holdPosition  /*0x04000E1C*/
    IL_001f: brfalse.s IL_004c
    IL_0021: ldarg.0
    IL_0022: ldarg.0
    IL_0023: ldfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0028: ldarg.0
    IL_0029: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0033: ldarg.0
    IL_0034: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0039: ldc.r4 7f
    IL_003e: ldloca.s 0
    IL_0040: callvirt TaggedObject TargetPriority::FindTaggedObjectCloseToHomeInHomeRange(UnityEngine.Vector3,UnityEngine.Vector3,float,ref UnityEngine.Vector3)  /*0x06000E7E*/
    IL_0045: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_004a: br.s IL_0076
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0053: ldarg.0
    IL_0054: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0059: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005e: ldarg.0
    IL_005f: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0064: ldarg.0
    IL_0065: ldfld float PathfindMovementPlayerunit::maximumDistanceFromHome  /*0x04000E00*/
    IL_006a: ldloca.s 0
    IL_006c: callvirt TaggedObject TargetPriority::FindTaggedObjectCloseToHome(UnityEngine.Vector3,UnityEngine.Vector3,float,ref UnityEngine.Vector3)  /*0x06000E7D*/
    IL_0071: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_0076: ldarg.0
    IL_0077: ldfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_007c: ldnull
    IL_007d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0082: brtrue.s IL_008c
    IL_0084: ldloc.0
    IL_0085: ldc.i4.1
    IL_0086: newobj void System.ValueTuple<UnityEngine.Vector3, bool>::.ctor(!0,!1)  /*0x0A00025D*/
    IL_008b: ret
    IL_008c: ldloc.1
    IL_008d: ldc.i4.1
    IL_008e: add
    IL_008f: stloc.1
    IL_0090: ldloc.1
    IL_0091: ldarg.0
    IL_0092: ldfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_0097: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_009c: blt IL_0007
    IL_00a1: call Vector3 UnityEngine.Vector3::get_negativeInfinity()  /*0x0A00025E*/
    IL_00a6: ldc.i4.0
    IL_00a7: newobj void System.ValueTuple<UnityEngine.Vector3, bool>::.ctor(!0,!1)  /*0x0A00025D*/
    IL_00ac: ret

  .method PathfindMovementPlayerunit::FindMoveToTarget()  // token 0x06000B42 rva 0x35da4 attrs Family, HideBySig
    // code size 129 (0x81), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool PathfindMovementPlayerunit::followingPlayer  /*0x04000E17*/
    IL_0006: brfalse.s IL_0024
    IL_0008: ldarg.0
    IL_0009: ldnull
    IL_000a: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_000f: ldarg.0
    IL_0010: ldnull
    IL_0011: stfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_001d: ldarg.0
    IL_001e: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0023: ret
    IL_0024: ldarg.0
    IL_0025: ldfld bool PathfindMovementPlayerunit::hasReachedHomePositionAlready  /*0x04000E1F*/
    IL_002a: brtrue.s IL_0048
    IL_002c: ldarg.0
    IL_002d: ldnull
    IL_002e: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_0033: ldarg.0
    IL_0034: ldnull
    IL_0035: stfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_003a: ldarg.0
    IL_003b: ldc.i4.1
    IL_003c: stfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_0041: ldarg.0
    IL_0042: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0047: ret
    IL_0048: ldarg.0
    IL_0049: ldc.i4.0
    IL_004a: stfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_004f: ldarg.0
    IL_0050: callvirt ValueTuple<Vector3, bool> PathfindMovementPlayerunit::FindTargetPosition()  /*0x06000B41*/
    IL_0055: dup
    IL_0056: ldfld !0 System.ValueTuple<UnityEngine.Vector3, bool>::Item1  /*0x0A0004E5*/
    IL_005b: stloc.0
    IL_005c: ldfld !1 System.ValueTuple<UnityEngine.Vector3, bool>::Item2  /*0x0A0004E6*/
    IL_0061: brfalse.s IL_0065
    IL_0063: ldloc.0
    IL_0064: ret
    IL_0065: ldarg.0
    IL_0066: ldnull
    IL_0067: stfld TaggedObject PathfindMovementPlayerunit::seekToTaggedObj  /*0x04000E0B*/
    IL_006c: ldarg.0
    IL_006d: ldnull
    IL_006e: stfld TargetPriority PathfindMovementPlayerunit::targetPrio  /*0x04000E12*/
    IL_0073: ldarg.0
    IL_0074: ldc.i4.1
    IL_0075: stfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_007a: ldarg.0
    IL_007b: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0080: ret

  .method PathfindMovementPlayerunit::Update()  // token 0x06000B43 rva 0x35e34 attrs Private, HideBySig
    // code size 120 (0x78), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PathfindMovementPlayerunit::recalculatePathCooldown  /*0x04000E0E*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float PathfindMovementPlayerunit::recalculatePathCooldown  /*0x04000E0E*/
    IL_0012: ldarg.0
    IL_0013: ldfld float PathfindMovementPlayerunit::recalculatePathCooldown  /*0x04000E0E*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_0031
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float PathfindMovementPlayerunit::recalculatePathInterval  /*0x04000E02*/
    IL_0026: stfld float PathfindMovementPlayerunit::recalculatePathCooldown  /*0x04000E0E*/
    IL_002b: ldarg.0
    IL_002c: call void PathfindMovementPlayerunit::OriginalPathRequest()  /*0x06000B3D*/
    IL_0031: ldarg.0
    IL_0032: ldfld bool PathfindMovementPlayerunit::followingPlayer  /*0x04000E17*/
    IL_0037: brfalse.s IL_0071
    IL_0039: ldarg.0
    IL_003a: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_003f: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0044: ldc.i4.0
    IL_0045: ble.s IL_0065
    IL_0047: ldarg.0
    IL_0048: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_004d: ldarg.0
    IL_004e: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0053: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0058: ldc.i4.1
    IL_0059: sub
    IL_005a: ldarg.0
    IL_005b: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_0060: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::set_Item(int,!0)  /*0x0A0004E0*/
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld Vector3 PathfindMovementPlayerunit::homePosition  /*0x04000E0F*/
    IL_006c: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_0071: ldarg.0
    IL_0072: call void PathfindMovementPlayerunit::FollowPathUpdate()  /*0x06000B45*/
    IL_0077: ret

  .method PathfindMovementPlayerunit::Slow(float)  // token 0x06000B44 rva 0x25f1 attrs Public, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PathfindMovementPlayerunit::FollowPathUpdate()  // token 0x06000B45 rva 0x35eb8 attrs Private, HideBySig
    // code size 520 (0x208), max stack 7, init locals
    .locals ([0] Vector3, [1] float, [2] float, [3] Vector3, [4] Vector3, [5] Vector3, [6] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0006: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_000b: ldarg.0
    IL_000c: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0011: bgt.s IL_003f
    IL_0013: ldarg.0
    IL_0014: ldfld bool PathfindMovementPlayerunit::followingPlayer  /*0x04000E17*/
    IL_0019: brfalse.s IL_003e
    IL_001b: ldarg.0
    IL_001c: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0021: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0026: ldc.i4.0
    IL_0027: ble.s IL_003e
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0030: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_0035: ldc.i4.1
    IL_0036: sub
    IL_0037: stfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_003c: br.s IL_003f
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0046: ldarg.0
    IL_0047: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_004c: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0051: stfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_0056: ldarg.0
    IL_0057: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0061: ldarg.0
    IL_0062: ldfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_0067: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_006c: stloc.s 5
    IL_006e: ldloca.s 5
    IL_0070: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0075: dup
    IL_0076: ldc.r4 3f
    IL_007b: bge.un.s IL_008c
    IL_007d: ldarg.0
    IL_007e: ldfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_0083: brfalse.s IL_008c
    IL_0085: ldarg.0
    IL_0086: ldc.i4.1
    IL_0087: call void PathfindMovementPlayerunit::set_HasReachedHomePositionAlready(bool)  /*0x06000B31*/
    IL_008c: ldarg.0
    IL_008d: ldfld float PathfindMovementPlayerunit::keepDistanceOf  /*0x04000DFF*/
    IL_0092: bge.un.s IL_00b8
    IL_0094: ldarg.0
    IL_0095: ldfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_009a: brtrue.s IL_00b8
    IL_009c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_00a1: stloc.0
    IL_00a2: ldarg.0
    IL_00a3: ldarg.0
    IL_00a4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a9: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00ae: stfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_00b3: br IL_0164
    IL_00b8: ldarg.0
    IL_00b9: ldfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_00be: ldarg.0
    IL_00bf: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00c4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c9: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00ce: stloc.0
    IL_00cf: ldc.i4.0
    IL_00d0: stloc.s 6
    IL_00d2: br IL_015b
    IL_00d7: ldloca.s 0
    IL_00d9: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00de: ldc.r4 1f
    IL_00e3: bgt.un.s IL_0164
    IL_00e5: ldarg.0
    IL_00e6: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_00eb: ldarg.0
    IL_00ec: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_00f1: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_00f6: ldc.i4.1
    IL_00f7: sub
    IL_00f8: beq.s IL_0164
    IL_00fa: ldarg.0
    IL_00fb: ldarg.0
    IL_00fc: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0101: ldc.i4.1
    IL_0102: add
    IL_0103: stfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0108: ldarg.0
    IL_0109: ldarg.0
    IL_010a: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_010f: ldc.i4.0
    IL_0110: ldarg.0
    IL_0111: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0116: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_011b: ldc.i4.1
    IL_011c: sub
    IL_011d: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0122: stfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0127: ldarg.0
    IL_0128: ldarg.0
    IL_0129: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_012e: ldarg.0
    IL_012f: ldfld int PathfindMovementPlayerunit::nextPathPointIndex  /*0x04000E0D*/
    IL_0134: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_0139: stfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_013e: ldarg.0
    IL_013f: ldfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_0144: ldarg.0
    IL_0145: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_014a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_014f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0154: stloc.0
    IL_0155: ldloc.s 6
    IL_0157: ldc.i4.1
    IL_0158: add
    IL_0159: stloc.s 6
    IL_015b: ldloc.s 6
    IL_015d: ldc.i4.s 100
    IL_015f: blt IL_00d7
    IL_0164: ldloca.s 0
    IL_0166: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_016b: stloc.1
    IL_016c: ldarg.0
    IL_016d: ldfld RVOController PathfindMovementPlayerunit::rvo  /*0x04000E08*/
    IL_0172: ldloc.1
    IL_0173: stfld float Pathfinding.RVO.RVOController::priority  /*0x0A0004E1*/
    IL_0178: ldarg.0
    IL_0179: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_017e: ldloc.1
    IL_017f: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0184: div
    IL_0185: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_018a: stloc.2
    IL_018b: ldarg.0
    IL_018c: ldfld RVOController PathfindMovementPlayerunit::rvo  /*0x04000E08*/
    IL_0191: ldarg.0
    IL_0192: ldfld Vector3 PathfindMovementPlayerunit::nextPathPoint  /*0x04000E15*/
    IL_0197: ldloc.2
    IL_0198: ldarg.0
    IL_0199: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_019e: ldc.r4 1.15f
    IL_01a3: mul
    IL_01a4: ldarg.0
    IL_01a5: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_01aa: ldarg.0
    IL_01ab: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_01b0: callvirt int System.Collections.Generic.List<UnityEngine.Vector3>::get_Count()  /*0x0A0004A2*/
    IL_01b5: ldc.i4.1
    IL_01b6: sub
    IL_01b7: callvirt !0 System.Collections.Generic.List<UnityEngine.Vector3>::get_Item(int)  /*0x0A0004DF*/
    IL_01bc: callvirt void Pathfinding.RVO.RVOController::SetTarget(UnityEngine.Vector3,float,float,UnityEngine.Vector3)  /*0x0A0004E2*/
    IL_01c1: ldarg.0
    IL_01c2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01c7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01cc: ldarg.0
    IL_01cd: ldfld RVOController PathfindMovementPlayerunit::rvo  /*0x04000E08*/
    IL_01d2: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01d7: callvirt Vector3 Pathfinding.RVO.RVOController::CalculateMovementDelta(float)  /*0x0A0004E3*/
    IL_01dc: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01e1: stloc.3
    IL_01e2: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_01e7: ldloc.3
    IL_01e8: ldarg.0
    IL_01e9: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_01ee: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_01f3: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_01f8: stloc.s 4
    IL_01fa: ldarg.0
    IL_01fb: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0200: ldloc.s 4
    IL_0202: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0207: ret

  .method PathfindMovementPlayerunit::SnapToNavmesh()  // token 0x06000B46 rva 0x360cc attrs Public, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: ldarg.0
    IL_0017: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_001c: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0021: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0026: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_002b: ret

  .method PathfindMovementPlayerunit::ClearCurrentPath()  // token 0x06000B47 rva 0x360f9 attrs Public, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0006: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Clear()  /*0x0A0004E4*/
    IL_000b: ret

  .method PathfindMovementPlayerunit::GetNearestGroundPosition(UnityEngine.Vector3)  // token 0x06000B48 rva 0x36106 attrs Public, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_000c: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0011: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_0016: ret

  .method PathfindMovementPlayerunit::.ctor()  // token 0x06000B49 rva 0x36120 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 153 (0x99), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0006: stfld List<TargetPriority> PathfindMovementPlayerunit::targetPriorities  /*0x04000DFE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float PathfindMovementPlayerunit::keepDistanceOf  /*0x04000DFF*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 100000f
    IL_001c: stfld float PathfindMovementPlayerunit::maximumDistanceFromHome  /*0x04000E00*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 2f
    IL_0027: stfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float PathfindMovementPlayerunit::recalculatePathInterval  /*0x04000E02*/
    IL_0037: ldarg.0
    IL_0038: ldstr ""
    IL_003d: stfld string PathfindMovementPlayerunit::backupMovementGraph  /*0x04000E03*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 5f
    IL_0048: stfld float PathfindMovementPlayerunit::agroTimeWhenAttackedByPlayer  /*0x04000E04*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 1.5f
    IL_0053: stfld float PathfindMovementPlayerunit::speedBoostDuringDaytime  /*0x04000E05*/
    IL_0058: ldarg.0
    IL_0059: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_005e: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPosSnappedtoNavmesh  /*0x04000E09*/
    IL_0063: ldarg.0
    IL_0064: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0069: stfld Vector3 PathfindMovementPlayerunit::seekToTargetPos  /*0x04000E0A*/
    IL_006e: ldarg.0
    IL_006f: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_0074: stfld List<Vector3> PathfindMovementPlayerunit::path  /*0x04000E0C*/
    IL_0079: ldarg.0
    IL_007a: ldc.i4.1
    IL_007b: stfld bool PathfindMovementPlayerunit::currentlyWalkingHome  /*0x04000E11*/
    IL_0080: ldarg.0
    IL_0081: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_0086: stfld NNConstraint PathfindMovementPlayerunit::nearestConstraint  /*0x04000E13*/
    IL_008b: ldarg.0
    IL_008c: ldc.i4.1
    IL_008d: stfld bool PathfindMovementPlayerunit::day  /*0x04000E1B*/
    IL_0092: ldarg.0
    IL_0093: call void PathfindMovement::.ctor()  /*0x06000B0B*/
    IL_0098: ret

