// ===== PlayerBallMovement  (token 0x0200022D) =====
  .method PlayerBallMovement::MoveScript(UnityEngine.Vector2)  // token 0x06000B93 rva 0x36b88 attrs Public, Virtual, HideBySig
    // code size 644 (0x284), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3, [2] Vector3, [3] Vector3, [4] float, [5] Vector3, [6] bool, [7] int, [8] int)
    IL_0000: ldarg.1
    IL_0001: ldc.r4 1f
    IL_0006: call Vector2 UnityEngine.Vector2::ClampMagnitude(UnityEngine.Vector2,float)  /*0x0A0004EC*/
    IL_000b: starg.s 1
    IL_000d: ldarg.0
    IL_000e: ldfld Transform PlayerMovement::viewTransform  /*0x04000EE9*/
    IL_0013: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0018: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_001d: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0022: stloc.s 5
    IL_0024: ldloca.s 5
    IL_0026: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_002b: stloc.0
    IL_002c: ldarg.0
    IL_002d: ldfld Transform PlayerMovement::viewTransform  /*0x04000EE9*/
    IL_0032: callvirt Vector3 UnityEngine.Transform::get_right()  /*0x0A0004EE*/
    IL_0037: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_003c: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0041: stloc.s 5
    IL_0043: ldloca.s 5
    IL_0045: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_004a: stloc.1
    IL_004b: ldloca.s 2
    IL_004d: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0053: ldloc.2
    IL_0054: ldloc.0
    IL_0055: ldarg.1
    IL_0056: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_005b: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0060: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0065: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_006a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006f: stloc.2
    IL_0070: ldloc.2
    IL_0071: ldloc.1
    IL_0072: ldarg.1
    IL_0073: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0078: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_007d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0082: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0087: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_008c: stloc.2
    IL_008d: ldarg.0
    IL_008e: call bool PlayerMovement::get_Dead()  /*0x06000C1F*/
    IL_0093: brfalse.s IL_00b2
    IL_0095: ldarg.0
    IL_0096: ldc.r4 -1f
    IL_009b: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_00a0: ldloc.2
    IL_00a1: ldarg.0
    IL_00a2: ldfld float PlayerMovement::moveSpeedWhenDead  /*0x04000EE2*/
    IL_00a7: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00ac: stloc.2
    IL_00ad: br IL_0168
    IL_00b2: ldarg.0
    IL_00b3: ldfld DayNightCycle PlayerMovement::dayNightCycle  /*0x04000EFA*/
    IL_00b8: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_00bd: ldc.i4.0
    IL_00be: ceq
    IL_00c0: stloc.s 6
    IL_00c2: ldloc.2
    IL_00c3: ldarg.0
    IL_00c4: ldfld bool PlayerMovement::sprinting  /*0x04000EF3*/
    IL_00c9: brtrue.s IL_00df
    IL_00cb: ldloc.s 6
    IL_00cd: brtrue.s IL_00d7
    IL_00cf: ldarg.0
    IL_00d0: ldfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_00d5: br.s IL_00f1
    IL_00d7: ldarg.0
    IL_00d8: ldfld float PlayerMovement::speedDuringDay  /*0x04000EDF*/
    IL_00dd: br.s IL_00f1
    IL_00df: ldloc.s 6
    IL_00e1: brtrue.s IL_00eb
    IL_00e3: ldarg.0
    IL_00e4: ldfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_00e9: br.s IL_00f1
    IL_00eb: ldarg.0
    IL_00ec: ldfld float PlayerMovement::sprintSpeedDuringDay  /*0x04000EE1*/
    IL_00f1: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00f6: stloc.2
    IL_00f7: ldarg.0
    IL_00f8: ldarg.0
    IL_00f9: ldfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_00fe: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0103: sub
    IL_0104: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0109: ldloc.2
    IL_010a: ldarg.0
    IL_010b: ldfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0110: ldc.r4 0f
    IL_0115: bgt.s IL_011e
    IL_0117: ldc.r4 1f
    IL_011c: br.s IL_0123
    IL_011e: ldc.r4 0.33f
    IL_0123: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0128: stloc.2
    IL_0129: ldarg.0
    IL_012a: ldfld bool PlayerMovement::heavyArmorEquipped  /*0x04000EEF*/
    IL_012f: brfalse.s IL_014f
    IL_0131: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0136: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_013b: ldc.i4.1
    IL_013c: bne.un.s IL_014f
    IL_013e: ldloc.2
    IL_013f: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0144: ldfld float PerkManager::heavyArmor_SpeedMultiplyer  /*0x04000BF3*/
    IL_0149: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_014e: stloc.2
    IL_014f: ldarg.0
    IL_0150: ldfld bool PlayerMovement::racingHorseEquipped  /*0x04000EF0*/
    IL_0155: brfalse.s IL_0168
    IL_0157: ldloc.2
    IL_0158: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_015d: ldfld float PerkManager::racingHorse_SpeedMultiplyer  /*0x04000BF7*/
    IL_0162: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0167: stloc.2
    IL_0168: ldarg.0
    IL_0169: ldfld Rigidbody PlayerBallMovement::rigidbody  /*0x04000E6F*/
    IL_016e: dup
    IL_016f: callvirt Vector3 UnityEngine.Rigidbody::get_velocity()  /*0x0A0004EF*/
    IL_0174: ldloc.2
    IL_0175: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_017a: callvirt void UnityEngine.Rigidbody::set_velocity(UnityEngine.Vector3)  /*0x0A000098*/
    IL_017f: ldarg.0
    IL_0180: ldfld Rigidbody PlayerBallMovement::rigidbody  /*0x04000E6F*/
    IL_0185: dup
    IL_0186: callvirt Vector3 UnityEngine.Rigidbody::get_velocity()  /*0x0A0004EF*/
    IL_018b: ldarg.0
    IL_018c: ldfld float PlayerMovement::gravity  /*0x04000EE3*/
    IL_0191: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0196: mul
    IL_0197: call Vector3 UnityEngine.Vector3::get_down()  /*0x0A00016E*/
    IL_019c: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_01a1: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01a6: callvirt void UnityEngine.Rigidbody::set_velocity(UnityEngine.Vector3)  /*0x0A000098*/
    IL_01ab: ldarg.0
    IL_01ac: ldfld Rigidbody PlayerBallMovement::rigidbody  /*0x04000E6F*/
    IL_01b1: callvirt Vector3 UnityEngine.Rigidbody::get_position()  /*0x0A0004F0*/
    IL_01b6: stloc.3
    IL_01b7: ldarg.0
    IL_01b8: ldfld SphereCollider PlayerBallMovement::myCollider  /*0x04000E7D*/
    IL_01bd: callvirt float UnityEngine.SphereCollider::get_radius()  /*0x0A0004F1*/
    IL_01c2: ldarg.0
    IL_01c3: ldfld SphereCollider PlayerBallMovement::myCollider  /*0x04000E7D*/
    IL_01c8: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01cd: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_01d2: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_01d7: mul
    IL_01d8: stloc.s 4
    IL_01da: ldarg.0
    IL_01db: call bool PlayerMovement::get_Dead()  /*0x06000C1F*/
    IL_01e0: brtrue.s IL_022e
    IL_01e2: ldloc.3
    IL_01e3: ldloc.s 4
    IL_01e5: ldarg.0
    IL_01e6: ldfld Collider[] PlayerBallMovement::tempColliders  /*0x04000E75*/
    IL_01eb: ldarg.0
    IL_01ec: ldfld LayerMask PlayerBallMovement::lmRecieveDamage  /*0x04000E73*/
    IL_01f1: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_01f6: call int UnityEngine.Physics::OverlapSphereNonAlloc(UnityEngine.Vector3,float,UnityEngine.Collider[],int)  /*0x0A0004F2*/
    IL_01fb: stloc.s 7
    IL_01fd: ldc.i4.0
    IL_01fe: stloc.s 8
    IL_0200: br.s IL_0228
    IL_0202: ldarg.0
    IL_0203: ldfld Collider[] PlayerBallMovement::tempColliders  /*0x04000E75*/
    IL_0208: ldloc.s 8
    IL_020a: ldelem.ref
    IL_020b: ldnull
    IL_020c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0211: brtrue.s IL_022e
    IL_0213: ldarg.0
    IL_0214: ldarg.0
    IL_0215: ldfld Collider[] PlayerBallMovement::tempColliders  /*0x04000E75*/
    IL_021a: ldloc.s 8
    IL_021c: ldelem.ref
    IL_021d: call void PlayerBallMovement::DealWithColliderHit(UnityEngine.Collider)  /*0x06000B97*/
    IL_0222: ldloc.s 8
    IL_0224: ldc.i4.1
    IL_0225: add
    IL_0226: stloc.s 8
    IL_0228: ldloc.s 8
    IL_022a: ldloc.s 7
    IL_022c: blt.s IL_0202
    IL_022e: ldarg.0
    IL_022f: ldarg.0
    IL_0230: ldfld float PlayerBallMovement::time  /*0x04000E7C*/
    IL_0235: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_023a: add
    IL_023b: stfld float PlayerBallMovement::time  /*0x04000E7C*/
    IL_0240: br.s IL_0275
    IL_0242: ldarg.0
    IL_0243: ldfld float PlayerBallMovement::time  /*0x04000E7C*/
    IL_0248: ldarg.0
    IL_0249: ldfld List<float> PlayerBallMovement::recentlyHitWhen  /*0x04000E7B*/
    IL_024e: ldc.i4.0
    IL_024f: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0254: sub
    IL_0255: ldarg.0
    IL_0256: ldfld float PlayerBallMovement::cooldownPerObject  /*0x04000E76*/
    IL_025b: ble.un.s IL_0283
    IL_025d: ldarg.0
    IL_025e: ldfld List<float> PlayerBallMovement::recentlyHitWhen  /*0x04000E7B*/
    IL_0263: ldc.i4.0
    IL_0264: callvirt void System.Collections.Generic.List<float>::RemoveAt(int)  /*0x0A0004F3*/
    IL_0269: ldarg.0
    IL_026a: ldfld List<TaggedObject> PlayerBallMovement::recentlyHit  /*0x04000E7A*/
    IL_026f: ldc.i4.0
    IL_0270: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveAt(int)  /*0x0A000483*/
    IL_0275: ldarg.0
    IL_0276: ldfld List<float> PlayerBallMovement::recentlyHitWhen  /*0x04000E7B*/
    IL_027b: callvirt int System.Collections.Generic.List<float>::get_Count()  /*0x0A000494*/
    IL_0280: ldc.i4.0
    IL_0281: bgt.s IL_0242
    IL_0283: ret

  .method PlayerBallMovement::FixedUpdate()  // token 0x06000B94 rva 0x36e18 attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.0
    IL_0007: ldfld Transform PlayerBallMovement::targetPosition  /*0x04000E70*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0016: ldarg.0
    IL_0017: ldfld Transform PlayerMovement::meshParent  /*0x04000EE4*/
    IL_001c: ldarg.0
    IL_001d: ldfld Rigidbody PlayerBallMovement::rigidbody  /*0x04000E6F*/
    IL_0022: callvirt Quaternion UnityEngine.Rigidbody::get_rotation()  /*0x0A0004F4*/
    IL_0027: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_002c: ret

  .method PlayerBallMovement::get_DamageMultiplyer()  // token 0x06000B95 rva 0x36e46 attrs Public, HideBySig, SpecialName
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerUpgradeManager PlayerBallMovement::upgradeManager  /*0x04000E78*/
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_000b: ldarg.0
    IL_000c: ldfld BlacksmithUpgrades PlayerBallMovement::blacksmithUpgrades  /*0x04000E79*/
    IL_0011: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0016: mul
    IL_0017: ret

  .method PlayerBallMovement::Start()  // token 0x06000B96 rva 0x36e5f attrs Public, Virtual, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PlayerMovement::Start()  /*0x06000C24*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call !!0 UnityEngine.Component::GetComponentInParent()<PlayerMovement>  /*0x2B0000AC*/
    IL_000d: stfld PlayerMovement PlayerBallMovement::playerMovement  /*0x04000E77*/
    IL_0012: ldarg.0
    IL_0013: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0018: stfld PlayerUpgradeManager PlayerBallMovement::upgradeManager  /*0x04000E78*/
    IL_001d: ldarg.0
    IL_001e: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0023: stfld BlacksmithUpgrades PlayerBallMovement::blacksmithUpgrades  /*0x04000E79*/
    IL_0028: ret

  .method PlayerBallMovement::DealWithColliderHit(UnityEngine.Collider)  // token 0x06000B97 rva 0x36e8c attrs Private, HideBySig
    // code size 157 (0x9d), max stack 5, init locals
    .locals ([0] TaggedObject, [1] Vector3)
    IL_0000: ldarg.1
    IL_0001: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000d: brtrue.s IL_0010
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld List<TaggedObject> PlayerBallMovement::recentlyHit  /*0x04000E7A*/
    IL_0016: ldloc.0
    IL_0017: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_001c: brfalse.s IL_001f
    IL_001e: ret
    IL_001f: ldloc.0
    IL_0020: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0025: ldc.i4.1
    IL_0026: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_002b: brtrue.s IL_002e
    IL_002d: ret
    IL_002e: ldloc.0
    IL_002f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0034: ldloc.0
    IL_0035: ldarg.0
    IL_0036: ldfld List<DamageModifyer> PlayerBallMovement::damage  /*0x04000E74*/
    IL_003b: ldarg.0
    IL_003c: call float PlayerBallMovement::get_DamageMultiplyer()  /*0x06000B95*/
    IL_0041: ldarg.0
    IL_0042: ldfld Rigidbody PlayerBallMovement::rigidbody  /*0x04000E6F*/
    IL_0047: callvirt Vector3 UnityEngine.Rigidbody::get_velocity()  /*0x0A0004EF*/
    IL_004c: stloc.1
    IL_004d: ldloca.s 1
    IL_004f: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0054: mul
    IL_0055: call float Weapon::CalculateDamageGeneral(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x060013D0*/
    IL_005a: ldnull
    IL_005b: ldc.i4.0
    IL_005c: ldc.i4.1
    IL_005d: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0062: pop
    IL_0063: ldarg.0
    IL_0064: ldfld Hp PlayerBallMovement::playerHp  /*0x04000E71*/
    IL_0069: ldarg.0
    IL_006a: ldfld float PlayerBallMovement::selfInflictedDamagePerHit  /*0x04000E72*/
    IL_006f: ldarg.0
    IL_0070: call float PlayerBallMovement::get_DamageMultiplyer()  /*0x06000B95*/
    IL_0075: mul
    IL_0076: ldnull
    IL_0077: ldc.i4.0
    IL_0078: ldc.i4.1
    IL_0079: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_007e: pop
    IL_007f: ldarg.0
    IL_0080: ldfld List<TaggedObject> PlayerBallMovement::recentlyHit  /*0x04000E7A*/
    IL_0085: ldloc.0
    IL_0086: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_008b: ldarg.0
    IL_008c: ldfld List<float> PlayerBallMovement::recentlyHitWhen  /*0x04000E7B*/
    IL_0091: ldarg.0
    IL_0092: ldfld float PlayerBallMovement::time  /*0x04000E7C*/
    IL_0097: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_009c: ret

  .method PlayerBallMovement::.ctor()  // token 0x06000B98 rva 0x36f38 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 64 (0x40), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float PlayerBallMovement::selfInflictedDamagePerHit  /*0x04000E72*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.s 50
    IL_000e: newarr UnityEngine.Collider  /*0x01000032*/
    IL_0013: stfld Collider[] PlayerBallMovement::tempColliders  /*0x04000E75*/
    IL_0018: ldarg.0
    IL_0019: ldc.r4 4f
    IL_001e: stfld float PlayerBallMovement::cooldownPerObject  /*0x04000E76*/
    IL_0023: ldarg.0
    IL_0024: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0029: stfld List<TaggedObject> PlayerBallMovement::recentlyHit  /*0x04000E7A*/
    IL_002e: ldarg.0
    IL_002f: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0034: stfld List<float> PlayerBallMovement::recentlyHitWhen  /*0x04000E7B*/
    IL_0039: ldarg.0
    IL_003a: call void PlayerMovement::.ctor()  /*0x06000C2B*/
    IL_003f: ret

