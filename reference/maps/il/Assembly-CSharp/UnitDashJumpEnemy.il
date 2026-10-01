// ===== UnitDashJumpEnemy  (token 0x0200038E) =====
  .method UnitDashJumpEnemy::Start()  // token 0x0600138C rva 0x5c8a2 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: ldarg.0
    IL_0007: ldfld float UnitDashJumpEnemy::recheckInterval  /*0x040017B3*/
    IL_000c: mul
    IL_000d: stfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_0012: ret

  .method UnitDashJumpEnemy::Update()  // token 0x0600138D rva 0x5c8b8 attrs Private, HideBySig
    // code size 183 (0xb7), max stack 4, init locals
    .locals ([0] TaggedObject, [1] float, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitDashJumpEnemy::dashJumpAnimRunning  /*0x040017C4*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Hp UnitDashJumpEnemy::hp  /*0x040017C0*/
    IL_000f: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0014: brtrue.s IL_0017
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_001e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0023: sub
    IL_0024: stfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_0029: ldarg.0
    IL_002a: ldfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_002f: ldc.r4 0f
    IL_0034: ble.un.s IL_0037
    IL_0036: ret
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: ldfld float UnitDashJumpEnemy::recheckInterval  /*0x040017B3*/
    IL_003e: stfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_0043: ldarg.0
    IL_0044: ldfld List<TargetPriority> UnitDashJumpEnemy::targetPriorities  /*0x040017BB*/
    IL_0049: ldarg.0
    IL_004a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0054: call TaggedObject AutoAttack::FindAutoAttackTarget(System.Collections.Generic.List<TargetPriority>,UnityEngine.Vector3)  /*0x06000237*/
    IL_0059: stloc.0
    IL_005a: ldloc.0
    IL_005b: ldnull
    IL_005c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0061: brfalse.s IL_0064
    IL_0063: ret
    IL_0064: ldloc.0
    IL_0065: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006f: ldarg.0
    IL_0070: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0075: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007a: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_007f: stloc.2
    IL_0080: ldloca.s 2
    IL_0082: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0087: stloc.1
    IL_0088: ldloc.1
    IL_0089: ldarg.0
    IL_008a: ldfld float UnitDashJumpEnemy::minAttackJumpDistance  /*0x040017B7*/
    IL_008f: blt.s IL_009a
    IL_0091: ldloc.1
    IL_0092: ldarg.0
    IL_0093: ldfld float UnitDashJumpEnemy::maxAttackJumpDistance  /*0x040017B8*/
    IL_0098: ble.un.s IL_009b
    IL_009a: ret
    IL_009b: ldarg.0
    IL_009c: ldarg.0
    IL_009d: ldfld float UnitDashJumpEnemy::jumpCooldown  /*0x040017B4*/
    IL_00a2: stfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_00a7: ldarg.0
    IL_00a8: ldarg.0
    IL_00a9: ldloc.0
    IL_00aa: ldloc.1
    IL_00ab: call IEnumerator UnitDashJumpEnemy::DashJumpAnimation(TaggedObject,float)  /*0x0600138E*/
    IL_00b0: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00b5: pop
    IL_00b6: ret

  .method UnitDashJumpEnemy::DashJumpAnimation(TaggedObject,float)  // token 0x0600138E rva 0x5c97b attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UnitDashJumpEnemy.<DashJumpAnimation>d__21::.ctor(int)  /*0x06001391*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UnitDashJumpEnemy UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>4__this  /*0x040017C7*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld TaggedObject UnitDashJumpEnemy.<DashJumpAnimation>d__21::_objToAttack  /*0x040017C8*/
    IL_0014: ret

  .method UnitDashJumpEnemy::InstantiateHere(UnityEngine.GameObject)  // token 0x0600138F rva 0x5c994 attrs Private, HideBySig
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

  .method UnitDashJumpEnemy::.ctor()  // token 0x06001390 rva 0x5c9e0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 73 (0x49), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float UnitDashJumpEnemy::nextJumpPossibleIn  /*0x040017B2*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.75f
    IL_0011: stfld float UnitDashJumpEnemy::recheckInterval  /*0x040017B3*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 12f
    IL_001c: stfld float UnitDashJumpEnemy::jumpCooldown  /*0x040017B4*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float UnitDashJumpEnemy::snapRange  /*0x040017B5*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float UnitDashJumpEnemy::jumpDuration  /*0x040017B9*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 10f
    IL_003d: stfld float UnitDashJumpEnemy::jumpHeight  /*0x040017BA*/
    IL_0042: ldarg.0
    IL_0043: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0048: ret

// ===== UnitDashJumpEnemy/<DashJumpAnimation>d__21  (token 0x0200038F) =====
  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::.ctor(int)  // token 0x06001391 rva 0x5ca35 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_000d: ret

  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::System.IDisposable.Dispose()  // token 0x06001392 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::MoveNext()  // token 0x06001393 rva 0x5ca44 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 630 (0x276), max stack 7, init locals
    .locals ([0] int, [1] UnitDashJumpEnemy, [2] Vector3, [3] Vector3, [4] float, [5] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UnitDashJumpEnemy UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>4__this  /*0x040017C7*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0137, IL_0261)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool UnitDashJumpEnemy::dashJumpAnimRunning  /*0x040017C4*/
    IL_0030: ldloc.1
    IL_0031: ldfld AutoAttack UnitDashJumpEnemy::autoAttack  /*0x040017B6*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003c: ldloc.1
    IL_003d: ldfld Hp UnitDashJumpEnemy::hp  /*0x040017C0*/
    IL_0042: ldc.i4.1
    IL_0043: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0048: ldloc.1
    IL_0049: ldfld PathfindMovementEnemy UnitDashJumpEnemy::unitMovement  /*0x040017C1*/
    IL_004e: ldc.i4.0
    IL_004f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0054: ldarg.0
    IL_0055: ldarg.0
    IL_0056: ldfld TaggedObject UnitDashJumpEnemy.<DashJumpAnimation>d__21::_objToAttack  /*0x040017C8*/
    IL_005b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0060: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0065: stfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_006a: ldloc.1
    IL_006b: ldfld PathfindMovementEnemy UnitDashJumpEnemy::unitMovement  /*0x040017C1*/
    IL_0070: ldarg.0
    IL_0071: ldfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_0076: callvirt Vector3 PathfindMovementEnemy::GetNearestGroundPosition(UnityEngine.Vector3)  /*0x06000B1B*/
    IL_007b: stloc.2
    IL_007c: ldloc.2
    IL_007d: ldarg.0
    IL_007e: ldfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_0083: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0088: stloc.3
    IL_0089: ldloca.s 3
    IL_008b: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0090: ldloc.1
    IL_0091: ldfld float UnitDashJumpEnemy::snapRange  /*0x040017B5*/
    IL_0096: bge.un IL_01fd
    IL_009b: ldloc.1
    IL_009c: ldfld UnityEvent<Vector3> UnitDashJumpEnemy::onStartJump  /*0x040017C3*/
    IL_00a1: ldloc.2
    IL_00a2: callvirt void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::Invoke(!0)  /*0x0A00020C*/
    IL_00a7: ldarg.0
    IL_00a8: ldloc.1
    IL_00a9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00ae: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00b3: stfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<startPos>5__3  /*0x040017CA*/
    IL_00b8: ldarg.0
    IL_00b9: ldloc.2
    IL_00ba: stfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.r4 0f
    IL_00c5: stfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_00ca: br IL_0157
    IL_00cf: ldloc.1
    IL_00d0: ldfld float UnitDashJumpEnemy::jumpHeight  /*0x040017BA*/
    IL_00d5: ldarg.0
    IL_00d6: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_00db: neg
    IL_00dc: ldarg.0
    IL_00dd: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_00e2: mul
    IL_00e3: ldarg.0
    IL_00e4: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_00e9: add
    IL_00ea: mul
    IL_00eb: stloc.s 4
    IL_00ed: ldloc.1
    IL_00ee: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f3: ldarg.0
    IL_00f4: ldfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<startPos>5__3  /*0x040017CA*/
    IL_00f9: ldarg.0
    IL_00fa: ldfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_00ff: ldarg.0
    IL_0100: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_0105: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_010a: ldloc.1
    IL_010b: ldfld float UnitDashJumpEnemy::jumpHeight  /*0x040017BA*/
    IL_0110: ldloc.s 4
    IL_0112: mul
    IL_0113: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0118: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_011d: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0122: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0127: ldarg.0
    IL_0128: ldnull
    IL_0129: stfld object UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>2__current  /*0x040017C6*/
    IL_012e: ldarg.0
    IL_012f: ldc.i4.1
    IL_0130: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_0135: ldc.i4.1
    IL_0136: ret
    IL_0137: ldarg.0
    IL_0138: ldc.i4.m1
    IL_0139: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_013e: ldarg.0
    IL_013f: ldarg.0
    IL_0140: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_0145: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_014a: ldloc.1
    IL_014b: ldfld float UnitDashJumpEnemy::jumpDuration  /*0x040017B9*/
    IL_0150: div
    IL_0151: add
    IL_0152: stfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_0157: ldarg.0
    IL_0158: ldfld float UnitDashJumpEnemy.<DashJumpAnimation>d__21::<t>5__4  /*0x040017CB*/
    IL_015d: ldc.r4 1f
    IL_0162: blt IL_00cf
    IL_0167: ldloc.1
    IL_0168: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_016d: ldarg.0
    IL_016e: ldfld Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<targetPosition>5__2  /*0x040017C9*/
    IL_0173: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0178: ldarg.0
    IL_0179: ldfld TaggedObject UnitDashJumpEnemy.<DashJumpAnimation>d__21::_objToAttack  /*0x040017C8*/
    IL_017e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0183: brfalse.s IL_01f1
    IL_0185: ldloc.1
    IL_0186: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_018b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0190: ldloc.1
    IL_0191: ldfld AutoAttack UnitDashJumpEnemy::autoAttack  /*0x040017B6*/
    IL_0196: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_019b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01a0: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_01a5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01aa: stloc.s 5
    IL_01ac: ldloc.1
    IL_01ad: ldfld Weapon UnitDashJumpEnemy::weaponOnLanding  /*0x040017BD*/
    IL_01b2: ldloc.s 5
    IL_01b4: ldarg.0
    IL_01b5: ldfld TaggedObject UnitDashJumpEnemy.<DashJumpAnimation>d__21::_objToAttack  /*0x040017C8*/
    IL_01ba: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_01bf: ldarg.0
    IL_01c0: ldfld TaggedObject UnitDashJumpEnemy.<DashJumpAnimation>d__21::_objToAttack  /*0x040017C8*/
    IL_01c5: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01ca: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01cf: ldloc.s 5
    IL_01d1: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_01d6: ldloc.1
    IL_01d7: ldfld TaggedObject UnitDashJumpEnemy::taggedObject  /*0x040017C2*/
    IL_01dc: ldloc.1
    IL_01dd: ldfld AutoAttack UnitDashJumpEnemy::autoAttack  /*0x040017B6*/
    IL_01e2: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_01e7: ldc.r4 1f
    IL_01ec: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_01f1: ldarg.0
    IL_01f2: ldflda Vector3 UnitDashJumpEnemy.<DashJumpAnimation>d__21::<startPos>5__3  /*0x040017CA*/
    IL_01f7: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_01fd: ldloc.1
    IL_01fe: ldfld PathfindMovementEnemy UnitDashJumpEnemy::unitMovement  /*0x040017C1*/
    IL_0203: ldc.i4.1
    IL_0204: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0209: ldloc.1
    IL_020a: ldfld PathfindMovementEnemy UnitDashJumpEnemy::unitMovement  /*0x040017C1*/
    IL_020f: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0214: ldloc.1
    IL_0215: ldfld Transform UnitDashJumpEnemy::aliveParent  /*0x040017BE*/
    IL_021a: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_021f: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0224: ldloc.1
    IL_0225: ldfld Transform UnitDashJumpEnemy::aliveParent  /*0x040017BE*/
    IL_022a: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_022f: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0234: ldloc.1
    IL_0235: ldc.i4.0
    IL_0236: stfld bool UnitDashJumpEnemy::dashJumpAnimRunning  /*0x040017C4*/
    IL_023b: ldloc.1
    IL_023c: ldfld AutoAttack UnitDashJumpEnemy::autoAttack  /*0x040017B6*/
    IL_0241: ldc.i4.1
    IL_0242: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0247: ldarg.0
    IL_0248: ldloc.1
    IL_0249: ldfld float UnitDashJumpEnemy::additionalInvulnerabilityTime  /*0x040017BC*/
    IL_024e: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0253: stfld object UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>2__current  /*0x040017C6*/
    IL_0258: ldarg.0
    IL_0259: ldc.i4.2
    IL_025a: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_025f: ldc.i4.1
    IL_0260: ret
    IL_0261: ldarg.0
    IL_0262: ldc.i4.m1
    IL_0263: stfld int UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>1__state  /*0x040017C5*/
    IL_0268: ldloc.1
    IL_0269: ldfld Hp UnitDashJumpEnemy::hp  /*0x040017C0*/
    IL_026e: ldc.i4.0
    IL_026f: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0274: ldc.i4.0
    IL_0275: ret

  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06001394 rva 0x5ccc6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>2__current  /*0x040017C6*/
    IL_0006: ret

  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::System.Collections.IEnumerator.Reset()  // token 0x06001395 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UnitDashJumpEnemy.<DashJumpAnimation>d__21::System.Collections.IEnumerator.get_Current()  // token 0x06001396 rva 0x5ccc6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitDashJumpEnemy.<DashJumpAnimation>d__21::<>2__current  /*0x040017C6*/
    IL_0006: ret

