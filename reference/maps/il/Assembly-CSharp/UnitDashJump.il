// ===== UnitDashJump  (token 0x0200038C) =====
  .method UnitDashJump::Start()  // token 0x06001381 rva 0x5c446 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: ldarg.0
    IL_0007: ldfld float UnitDashJump::recheckInterval  /*0x0400179A*/
    IL_000c: mul
    IL_000d: stfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_0012: ret

  .method UnitDashJump::Update()  // token 0x06001382 rva 0x5c45c attrs Private, HideBySig
    // code size 197 (0xc5), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitDashJump::dashJumpAnimRunning  /*0x040017A9*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Hp UnitDashJump::hp  /*0x040017A6*/
    IL_000f: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0014: brtrue.s IL_0017
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_001d: callvirt bool PathfindMovementPlayerunit::get_FollowingPlayer()  /*0x06000B2D*/
    IL_0022: brfalse.s IL_0025
    IL_0024: ret
    IL_0025: ldarg.0
    IL_0026: ldarg.0
    IL_0027: ldfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_002c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0031: sub
    IL_0032: stfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_0037: ldarg.0
    IL_0038: ldfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_003d: ldc.r4 0f
    IL_0042: ble.un.s IL_0045
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldarg.0
    IL_0047: ldfld float UnitDashJump::recheckInterval  /*0x0400179A*/
    IL_004c: stfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_0051: ldarg.0
    IL_0052: ldfld List<TargetPriority> UnitDashJump::targetPriorities  /*0x040017A1*/
    IL_0057: ldarg.0
    IL_0058: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0062: call TaggedObject AutoAttack::FindAutoAttackTarget(System.Collections.Generic.List<TargetPriority>,UnityEngine.Vector3)  /*0x06000237*/
    IL_0067: stloc.0
    IL_0068: ldloc.0
    IL_0069: ldnull
    IL_006a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_006f: brfalse.s IL_0072
    IL_0071: ret
    IL_0072: ldloc.0
    IL_0073: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0078: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007d: ldarg.0
    IL_007e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0083: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0088: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_008d: stloc.2
    IL_008e: ldloca.s 2
    IL_0090: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0095: stloc.1
    IL_0096: ldloc.1
    IL_0097: ldarg.0
    IL_0098: ldfld float UnitDashJump::minAttackJumpDistance  /*0x0400179D*/
    IL_009d: blt.s IL_00a8
    IL_009f: ldloc.1
    IL_00a0: ldarg.0
    IL_00a1: ldfld float UnitDashJump::maxAttackJumpDistance  /*0x0400179E*/
    IL_00a6: ble.un.s IL_00a9
    IL_00a8: ret
    IL_00a9: ldarg.0
    IL_00aa: ldarg.0
    IL_00ab: ldfld float UnitDashJump::jumpCooldown  /*0x0400179B*/
    IL_00b0: stfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_00b5: ldarg.0
    IL_00b6: ldarg.0
    IL_00b7: ldloc.0
    IL_00b8: ldloc.1
    IL_00b9: call IEnumerator UnitDashJump::DashJumpAnimation(TaggedObject,float)  /*0x06001383*/
    IL_00be: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00c3: pop
    IL_00c4: ret

  .method UnitDashJump::DashJumpAnimation(TaggedObject,float)  // token 0x06001383 rva 0x5c52d attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UnitDashJump.<DashJumpAnimation>d__19::.ctor(int)  /*0x06001386*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UnitDashJump UnitDashJump.<DashJumpAnimation>d__19::<>4__this  /*0x040017AC*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_0014: ret

  .method UnitDashJump::InstantiateHere(UnityEngine.GameObject)  // token 0x06001384 rva 0x5c544 attrs Private, HideBySig
    // code size 63 (0x3f), max stack 3, init locals
    .locals ([0] FireArcherBurn)
    IL_0000: ldarg.1
    IL_0001: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0015: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_001a: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_001f: callvirt !!0 UnityEngine.GameObject::GetComponent()<FireArcherBurn>  /*0x2B0000A2*/
    IL_0024: stloc.0
    IL_0025: ldloc.0
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brfalse.s IL_003e
    IL_002d: ldloc.0
    IL_002e: ldarg.0
    IL_002f: call !!0 UnityEngine.Component::GetComponent()<AutoAttack>  /*0x2B0000A3*/
    IL_0034: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0039: callvirt void WeaponDamageDealer::set_DamageMultiplyer(float)  /*0x060013D3*/
    IL_003e: ret

  .method UnitDashJump::.ctor()  // token 0x06001385 rva 0x5c58f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float UnitDashJump::nextJumpPossibleIn  /*0x04001799*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.75f
    IL_0011: stfld float UnitDashJump::recheckInterval  /*0x0400179A*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 12f
    IL_001c: stfld float UnitDashJump::jumpCooldown  /*0x0400179B*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float UnitDashJump::jumpDuration  /*0x0400179F*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 10f
    IL_0032: stfld float UnitDashJump::jumpHeight  /*0x040017A0*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

// ===== UnitDashJump/<DashJumpAnimation>d__19  (token 0x0200038D) =====
  .method UnitDashJump.<DashJumpAnimation>d__19::.ctor(int)  // token 0x06001386 rva 0x5c5ce attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_000d: ret

  .method UnitDashJump.<DashJumpAnimation>d__19::System.IDisposable.Dispose()  // token 0x06001387 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitDashJump.<DashJumpAnimation>d__19::MoveNext()  // token 0x06001388 rva 0x5c5e0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 686 (0x2ae), max stack 7, init locals
    .locals ([0] int, [1] UnitDashJump, [2] Vector3, [3] Vector3, [4] float, [5] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UnitDashJump UnitDashJump.<DashJumpAnimation>d__19::<>4__this  /*0x040017AC*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_015e, IL_0299)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool UnitDashJump::dashJumpAnimRunning  /*0x040017A9*/
    IL_0030: ldloc.1
    IL_0031: ldfld AutoAttack UnitDashJump::autoAttack  /*0x0400179C*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003c: ldloc.1
    IL_003d: ldfld Hp UnitDashJump::hp  /*0x040017A6*/
    IL_0042: ldc.i4.1
    IL_0043: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0048: ldarg.0
    IL_0049: ldloc.1
    IL_004a: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_004f: callvirt bool PathfindMovementPlayerunit::get_HoldPosition()  /*0x06000B33*/
    IL_0054: stfld bool UnitDashJump.<DashJumpAnimation>d__19::<unitHoldPosition>5__2  /*0x040017AE*/
    IL_0059: ldloc.1
    IL_005a: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_005f: ldc.i4.0
    IL_0060: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_006c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: stfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_007b: ldloc.1
    IL_007c: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_0081: ldarg.0
    IL_0082: ldfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_0087: callvirt Vector3 PathfindMovementPlayerunit::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B48*/
    IL_008c: stloc.2
    IL_008d: ldloc.2
    IL_008e: ldarg.0
    IL_008f: ldfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_0094: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0099: stloc.3
    IL_009a: ldloca.s 3
    IL_009c: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00a1: ldc.r4 1f
    IL_00a6: bge.un IL_0224
    IL_00ab: ldarg.0
    IL_00ac: ldloc.1
    IL_00ad: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00b7: stfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<startPos>5__4  /*0x040017B0*/
    IL_00bc: ldarg.0
    IL_00bd: ldloc.2
    IL_00be: stfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_00c3: ldarg.0
    IL_00c4: ldc.r4 0f
    IL_00c9: stfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_00ce: br IL_017e
    IL_00d3: ldarg.0
    IL_00d4: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_00d9: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00de: brfalse.s IL_00f6
    IL_00e0: ldarg.0
    IL_00e1: ldarg.0
    IL_00e2: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_00e7: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ec: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f1: stfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_00f6: ldloc.1
    IL_00f7: ldfld float UnitDashJump::jumpHeight  /*0x040017A0*/
    IL_00fc: ldarg.0
    IL_00fd: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_0102: neg
    IL_0103: ldarg.0
    IL_0104: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_0109: mul
    IL_010a: ldarg.0
    IL_010b: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_0110: add
    IL_0111: mul
    IL_0112: stloc.s 4
    IL_0114: ldloc.1
    IL_0115: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_011a: ldarg.0
    IL_011b: ldfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<startPos>5__4  /*0x040017B0*/
    IL_0120: ldarg.0
    IL_0121: ldfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_0126: ldarg.0
    IL_0127: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_012c: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0131: ldloc.1
    IL_0132: ldfld float UnitDashJump::jumpHeight  /*0x040017A0*/
    IL_0137: ldloc.s 4
    IL_0139: mul
    IL_013a: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_013f: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0144: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0149: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_014e: ldarg.0
    IL_014f: ldnull
    IL_0150: stfld object UnitDashJump.<DashJumpAnimation>d__19::<>2__current  /*0x040017AB*/
    IL_0155: ldarg.0
    IL_0156: ldc.i4.1
    IL_0157: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_015c: ldc.i4.1
    IL_015d: ret
    IL_015e: ldarg.0
    IL_015f: ldc.i4.m1
    IL_0160: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_0165: ldarg.0
    IL_0166: ldarg.0
    IL_0167: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_016c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0171: ldloc.1
    IL_0172: ldfld float UnitDashJump::jumpDuration  /*0x0400179F*/
    IL_0177: div
    IL_0178: add
    IL_0179: stfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_017e: ldarg.0
    IL_017f: ldfld float UnitDashJump.<DashJumpAnimation>d__19::<t>5__5  /*0x040017B1*/
    IL_0184: ldc.r4 1f
    IL_0189: blt IL_00d3
    IL_018e: ldloc.1
    IL_018f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0194: ldarg.0
    IL_0195: ldfld Vector3 UnitDashJump.<DashJumpAnimation>d__19::<targetPosition>5__3  /*0x040017AF*/
    IL_019a: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_019f: ldarg.0
    IL_01a0: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_01a5: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01aa: brfalse.s IL_0218
    IL_01ac: ldloc.1
    IL_01ad: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01b2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01b7: ldloc.1
    IL_01b8: ldfld AutoAttack UnitDashJump::autoAttack  /*0x0400179C*/
    IL_01bd: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_01c2: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01c7: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_01cc: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01d1: stloc.s 5
    IL_01d3: ldloc.1
    IL_01d4: ldfld Weapon UnitDashJump::weaponOnLanding  /*0x040017A3*/
    IL_01d9: ldloc.s 5
    IL_01db: ldarg.0
    IL_01dc: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_01e1: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_01e6: ldarg.0
    IL_01e7: ldfld TaggedObject UnitDashJump.<DashJumpAnimation>d__19::_objToAttack  /*0x040017AD*/
    IL_01ec: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01f1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01f6: ldloc.s 5
    IL_01f8: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01fd: ldloc.1
    IL_01fe: ldfld TaggedObject UnitDashJump::taggedObject  /*0x040017A8*/
    IL_0203: ldloc.1
    IL_0204: ldfld AutoAttack UnitDashJump::autoAttack  /*0x0400179C*/
    IL_0209: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_020e: ldc.r4 1f
    IL_0213: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0218: ldarg.0
    IL_0219: ldflda Vector3 UnitDashJump.<DashJumpAnimation>d__19::<startPos>5__4  /*0x040017B0*/
    IL_021e: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0224: ldloc.1
    IL_0225: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_022a: ldc.i4.1
    IL_022b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0230: ldloc.1
    IL_0231: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_0236: callvirt void PathfindMovementPlayerunit::OriginalPathRequest()  /*0x06000B3D*/
    IL_023b: ldloc.1
    IL_023c: ldfld PathfindMovementPlayerunit UnitDashJump::unitMovement  /*0x040017A7*/
    IL_0241: ldarg.0
    IL_0242: ldfld bool UnitDashJump.<DashJumpAnimation>d__19::<unitHoldPosition>5__2  /*0x040017AE*/
    IL_0247: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_024c: ldloc.1
    IL_024d: ldfld Transform UnitDashJump::aliveParent  /*0x040017A4*/
    IL_0252: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0257: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_025c: ldloc.1
    IL_025d: ldfld Transform UnitDashJump::aliveParent  /*0x040017A4*/
    IL_0262: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0267: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_026c: ldloc.1
    IL_026d: ldc.i4.0
    IL_026e: stfld bool UnitDashJump::dashJumpAnimRunning  /*0x040017A9*/
    IL_0273: ldloc.1
    IL_0274: ldfld AutoAttack UnitDashJump::autoAttack  /*0x0400179C*/
    IL_0279: ldc.i4.1
    IL_027a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_027f: ldarg.0
    IL_0280: ldloc.1
    IL_0281: ldfld float UnitDashJump::additionalInvulnerabilityTime  /*0x040017A2*/
    IL_0286: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_028b: stfld object UnitDashJump.<DashJumpAnimation>d__19::<>2__current  /*0x040017AB*/
    IL_0290: ldarg.0
    IL_0291: ldc.i4.2
    IL_0292: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_0297: ldc.i4.1
    IL_0298: ret
    IL_0299: ldarg.0
    IL_029a: ldc.i4.m1
    IL_029b: stfld int UnitDashJump.<DashJumpAnimation>d__19::<>1__state  /*0x040017AA*/
    IL_02a0: ldloc.1
    IL_02a1: ldfld Hp UnitDashJump::hp  /*0x040017A6*/
    IL_02a6: ldc.i4.0
    IL_02a7: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_02ac: ldc.i4.0
    IL_02ad: ret

  .method UnitDashJump.<DashJumpAnimation>d__19::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001389 rva 0x5c89a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitDashJump.<DashJumpAnimation>d__19::<>2__current  /*0x040017AB*/
    IL_0006: ret

  .method UnitDashJump.<DashJumpAnimation>d__19::System.Collections.IEnumerator.Reset()  // token 0x0600138A rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UnitDashJump.<DashJumpAnimation>d__19::System.Collections.IEnumerator.get_Current()  // token 0x0600138B rva 0x5c89a attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitDashJump.<DashJumpAnimation>d__19::<>2__current  /*0x040017AB*/
    IL_0006: ret

