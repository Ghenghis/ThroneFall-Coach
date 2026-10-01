// ===== Weapon  (token 0x0200039C) =====
  .method Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  // token 0x060013C9 rva 0x5df4c attrs Public, HideBySig
    // code size 622 (0x26e), max stack 9, init locals
    .locals ([0] Vector3, [1] RaycastHit, [2] Vector3, [3] Hp, [4] GameObject, [5] AimbotProjectile, [6] Vector3, [7] AraTrail)
    IL_0000: ldarg.0
    IL_0001: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0006: stfld PlayerUpgradeManager Weapon::playerUpgradeManager  /*0x0400182C*/
    IL_000b: ldarg.1
    IL_000c: ldarg.3
    IL_000d: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0012: stloc.0
    IL_0013: ldarg.2
    IL_0014: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0019: brfalse.s IL_0070
    IL_001b: ldarg.2
    IL_001c: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_0021: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0026: brfalse.s IL_0070
    IL_0028: ldarg.2
    IL_0029: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_002e: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0033: ldnull
    IL_0034: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0039: brfalse.s IL_004f
    IL_003b: ldarg.2
    IL_003c: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_0041: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0046: ldarg.1
    IL_0047: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_004c: stloc.0
    IL_004d: br.s IL_0070
    IL_004f: ldarg.2
    IL_0050: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0055: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005a: ldarg.2
    IL_005b: ldfld float Hp::hitFeedbackHeight  /*0x04000A32*/
    IL_0060: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0065: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_006a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006f: stloc.0
    IL_0070: ldarg.0
    IL_0071: ldfld bool Weapon::performRaycastBeforeShooting  /*0x0400181E*/
    IL_0076: brfalse IL_0112
    IL_007b: ldarg.1
    IL_007c: ldloc.0
    IL_007d: ldarg.1
    IL_007e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0083: ldloca.s 1
    IL_0085: ldloc.0
    IL_0086: ldarg.1
    IL_0087: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_008c: stloc.2
    IL_008d: ldloca.s 2
    IL_008f: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0094: ldarg.0
    IL_0095: ldfld LayerMask Weapon::raycastBeforeShootingLayerMask  /*0x0400181F*/
    IL_009a: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_009f: call bool UnityEngine.Physics::Raycast(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.RaycastHit,float,int)  /*0x0A0001F8*/
    IL_00a4: pop
    IL_00a5: ldloca.s 1
    IL_00a7: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A0001FE*/
    IL_00ac: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b1: brfalse.s IL_0112
    IL_00b3: ldloca.s 1
    IL_00b5: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A0001FE*/
    IL_00ba: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_00bf: stloc.3
    IL_00c0: ldloc.3
    IL_00c1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c6: brfalse.s IL_0112
    IL_00c8: ldloc.3
    IL_00c9: starg.s 2
    IL_00cb: ldarg.2
    IL_00cc: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_00d1: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_00d6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00db: brfalse.s IL_00f1
    IL_00dd: ldarg.2
    IL_00de: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_00e3: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_00e8: ldarg.1
    IL_00e9: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_00ee: stloc.0
    IL_00ef: br.s IL_0112
    IL_00f1: ldarg.2
    IL_00f2: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00fc: ldarg.2
    IL_00fd: ldfld float Hp::hitFeedbackHeight  /*0x04000A32*/
    IL_0102: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0107: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_010c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0111: stloc.0
    IL_0112: ldarg.0
    IL_0113: ldfld float Weapon::projectileSpeed  /*0x04001818*/
    IL_0118: ldc.r4 0f
    IL_011d: ble.un IL_01cf
    IL_0122: ldarg.0
    IL_0123: ldfld GameObject Weapon::projectileVisuals  /*0x0400181B*/
    IL_0128: ldnull
    IL_0129: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_012e: brfalse IL_01cf
    IL_0133: ldarg.0
    IL_0134: ldfld GameObject Weapon::projectileVisuals  /*0x0400181B*/
    IL_0139: call GameObject ObjectPools::GetPooledItemByObject(UnityEngine.GameObject)  /*0x06000E9A*/
    IL_013e: stloc.s 4
    IL_0140: ldloc.s 4
    IL_0142: ldnull
    IL_0143: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0148: brfalse.s IL_018a
    IL_014a: ldloc.s 4
    IL_014c: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0151: ldarg.1
    IL_0152: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0157: ldloc.s 4
    IL_0159: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_015e: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0163: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0168: ldloc.s 4
    IL_016a: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Ara.AraTrail>  /*0x2B000112*/
    IL_016f: stloc.s 7
    IL_0171: ldloc.s 7
    IL_0173: ldnull
    IL_0174: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0179: brfalse.s IL_0182
    IL_017b: ldloc.s 7
    IL_017d: callvirt void Ara.AraTrail::Clear()  /*0x06003D8E*/
    IL_0182: ldloc.s 4
    IL_0184: ldc.i4.1
    IL_0185: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_018a: ldloc.s 4
    IL_018c: callvirt !!0 UnityEngine.GameObject::GetComponent()<AimbotProjectile>  /*0x2B000113*/
    IL_0191: stloc.s 5
    IL_0193: ldloc.s 5
    IL_0195: ldnull
    IL_0196: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_019b: brfalse.s IL_01a4
    IL_019d: ldloc.s 5
    IL_019f: callvirt void AimbotProjectile::ResetDisabledObjects()  /*0x06000088*/
    IL_01a4: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_01a9: stloc.s 6
    IL_01ab: ldarg.2
    IL_01ac: ldnull
    IL_01ad: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_01b2: brfalse.s IL_01b7
    IL_01b4: ldloc.0
    IL_01b5: stloc.s 6
    IL_01b7: ldloc.s 5
    IL_01b9: ldarg.0
    IL_01ba: ldarg.2
    IL_01bb: ldarg.0
    IL_01bc: ldfld float Weapon::maximumChaseRange  /*0x04001820*/
    IL_01c1: ldloc.s 6
    IL_01c3: ldarg.s 4
    IL_01c5: ldarg.s 5
    IL_01c7: ldarg.s 6
    IL_01c9: callvirt void AimbotProjectile::Fire(Weapon,Hp,float,UnityEngine.Vector3,TaggedObject,float,float)  /*0x06000081*/
    IL_01ce: ret
    IL_01cf: ldarg.0
    IL_01d0: ldfld GameObject Weapon::fxSpawnOnAttacker  /*0x04001824*/
    IL_01d5: ldnull
    IL_01d6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01db: brfalse.s IL_01f7
    IL_01dd: ldarg.0
    IL_01de: ldarg.0
    IL_01df: ldfld GameObject Weapon::fxSpawnOnAttacker  /*0x04001824*/
    IL_01e4: ldarg.1
    IL_01e5: ldarg.1
    IL_01e6: ldarg.2
    IL_01e7: ldloc.0
    IL_01e8: ldarg.s 4
    IL_01ea: ldarg.s 5
    IL_01ec: ldarg.0
    IL_01ed: ldfld bool Weapon::parentFxToAttacker  /*0x04001825*/
    IL_01f2: call void Weapon::SpawnAttackFx(UnityEngine.GameObject,UnityEngine.Vector3,UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,bool)  /*0x060013CA*/
    IL_01f7: ldarg.0
    IL_01f8: ldfld GameObject Weapon::fxSpawnOnVictim  /*0x04001826*/
    IL_01fd: ldnull
    IL_01fe: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0203: brfalse.s IL_0261
    IL_0205: ldarg.2
    IL_0206: ldnull
    IL_0207: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_020c: brfalse.s IL_0261
    IL_020e: ldarg.0
    IL_020f: ldarg.0
    IL_0210: ldfld GameObject Weapon::fxSpawnOnVictim  /*0x04001826*/
    IL_0215: ldloc.0
    IL_0216: ldarg.1
    IL_0217: ldarg.2
    IL_0218: ldloc.0
    IL_0219: ldarg.s 4
    IL_021b: ldarg.s 5
    IL_021d: ldc.i4.0
    IL_021e: call void Weapon::SpawnAttackFx(UnityEngine.GameObject,UnityEngine.Vector3,UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,bool)  /*0x060013CA*/
    IL_0223: ldarg.0
    IL_0224: ldfld bool Weapon::followFxVictim  /*0x04001827*/
    IL_0229: brfalse.s IL_0261
    IL_022b: ldarg.0
    IL_022c: ldfld GameObject Weapon::lastSpawnedFX  /*0x0400182D*/
    IL_0231: ldnull
    IL_0232: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0237: brfalse.s IL_0261
    IL_0239: ldarg.0
    IL_023a: ldfld GameObject Weapon::lastSpawnedFX  /*0x0400182D*/
    IL_023f: callvirt !!0 UnityEngine.GameObject::GetComponent()<CustomPositionConstraint>  /*0x2B00004C*/
    IL_0244: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0249: brfalse.s IL_0261
    IL_024b: ldarg.0
    IL_024c: ldfld GameObject Weapon::lastSpawnedFX  /*0x0400182D*/
    IL_0251: callvirt !!0 UnityEngine.GameObject::GetComponent()<CustomPositionConstraint>  /*0x2B00004C*/
    IL_0256: ldarg.2
    IL_0257: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_025c: stfld Transform CustomPositionConstraint::followTransform  /*0x040004A5*/
    IL_0261: ldarg.0
    IL_0262: ldarg.2
    IL_0263: ldarg.s 5
    IL_0265: ldarg.s 4
    IL_0267: ldc.i4.0
    IL_0268: call void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_026d: ret

  .method Weapon::SpawnAttackFx(UnityEngine.GameObject,UnityEngine.Vector3,UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,bool)  // token 0x060013CA rva 0x5e1c8 attrs Private, HideBySig
    // code size 131 (0x83), max stack 4, init locals
    .locals ([0] Quaternion, [1] Vector3, [2] GameObject)
    IL_0000: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0005: stloc.0
    IL_0006: ldarg.s 5
    IL_0008: ldarg.3
    IL_0009: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_000e: stloc.1
    IL_000f: ldloca.s 1
    IL_0011: ldc.r4 0f
    IL_0016: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_001b: ldloca.s 1
    IL_001d: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0022: ldc.r4 1E-06f
    IL_0027: ble.un.s IL_0035
    IL_0029: ldloc.1
    IL_002a: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_002f: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_0034: stloc.0
    IL_0035: ldarg.s 8
    IL_0037: brfalse.s IL_0041
    IL_0039: ldarg.s 6
    IL_003b: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0040: pop
    IL_0041: ldarg.1
    IL_0042: call GameObject ObjectPools::GetPooledItemByObject(UnityEngine.GameObject)  /*0x06000E9A*/
    IL_0047: stloc.2
    IL_0048: ldarg.0
    IL_0049: ldloc.2
    IL_004a: stfld GameObject Weapon::lastSpawnedFX  /*0x0400182D*/
    IL_004f: ldloc.2
    IL_0050: ldnull
    IL_0051: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0056: brfalse.s IL_0077
    IL_0058: ldloc.2
    IL_0059: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_005e: ldarg.2
    IL_005f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0064: ldloc.2
    IL_0065: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_006a: ldloc.0
    IL_006b: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0070: ldloc.2
    IL_0071: ldc.i4.1
    IL_0072: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0077: ldarg.0
    IL_0078: ldloc.2
    IL_0079: ldarg.s 6
    IL_007b: ldarg.s 7
    IL_007d: call void Weapon::DealSplashDamage(UnityEngine.GameObject,TaggedObject,float)  /*0x060013CB*/
    IL_0082: ret

  .method Weapon::DealSplashDamage(UnityEngine.GameObject,TaggedObject,float)  // token 0x060013CB rva 0x5e258 attrs Public, HideBySig
    // code size 90 (0x5a), max stack 5, init locals
    .locals ([0] SplashDamageArea[], [1] List<Hp>, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<DamageModifyer> Weapon::splashDamage  /*0x0400182A*/
    IL_0006: callvirt int System.Collections.Generic.List<DamageModifyer>::get_Count()  /*0x0A00019E*/
    IL_000b: ldc.i4.0
    IL_000c: bgt.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren()<SplashDamageArea>  /*0x2B000114*/
    IL_0015: stloc.0
    IL_0016: ldloc.0
    IL_0017: ldlen
    IL_0018: brtrue.s IL_001b
    IL_001a: ret
    IL_001b: newobj void System.Collections.Generic.List<Hp>::.ctor()  /*0x0A0003C5*/
    IL_0020: stloc.1
    IL_0021: ldc.i4.0
    IL_0022: stloc.2
    IL_0023: br.s IL_0032
    IL_0025: ldloc.0
    IL_0026: ldloc.2
    IL_0027: ldelem.ref
    IL_0028: ldloc.1
    IL_0029: callvirt void SplashDamageArea::AddReiveDamageHpScriptsInAreaToList(System.Collections.Generic.List<Hp>)  /*0x06000E2F*/
    IL_002e: ldloc.2
    IL_002f: ldc.i4.1
    IL_0030: add
    IL_0031: stloc.2
    IL_0032: ldloc.2
    IL_0033: ldloc.0
    IL_0034: ldlen
    IL_0035: conv.i4
    IL_0036: blt.s IL_0025
    IL_0038: ldc.i4.0
    IL_0039: stloc.3
    IL_003a: br.s IL_0050
    IL_003c: ldarg.0
    IL_003d: ldloc.1
    IL_003e: ldloc.3
    IL_003f: callvirt !0 System.Collections.Generic.List<Hp>::get_Item(int)  /*0x0A00077A*/
    IL_0044: ldarg.3
    IL_0045: ldarg.2
    IL_0046: ldc.i4.1
    IL_0047: call void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_004c: ldloc.3
    IL_004d: ldc.i4.1
    IL_004e: add
    IL_004f: stloc.3
    IL_0050: ldloc.3
    IL_0051: ldloc.1
    IL_0052: callvirt int System.Collections.Generic.List<Hp>::get_Count()  /*0x0A000779*/
    IL_0057: blt.s IL_003c
    IL_0059: ret

  .method Weapon::get_BlacksmithMulti()  // token 0x060013CC rva 0x5e2c0 attrs Public, HideBySig, SpecialName
    // code size 95 (0x5f), max stack 2, init locals
    .locals ([0] Weapon.EDamageAffectedByBlacksmithUpgrade)
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon.EDamageAffectedByBlacksmithUpgrade Weapon::blacksmithEffect  /*0x04001816*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.1
    IL_0009: sub
    IL_000a: switch (IL_0021, IL_002c, IL_0037, IL_0048)
    IL_001f: br.s IL_0059
    IL_0021: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0026: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_002b: ret
    IL_002c: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0031: ldfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0036: ret
    IL_0037: ldc.r4 1f
    IL_003c: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0041: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0046: div
    IL_0047: ret
    IL_0048: ldc.r4 1f
    IL_004d: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0052: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0057: div
    IL_0058: ret
    IL_0059: ldc.r4 1f
    IL_005e: ret

  .method Weapon::DealDamage(Hp,float,TaggedObject,bool)  // token 0x060013CD rva 0x5e32c attrs Public, HideBySig
    // code size 504 (0x1f8), max stack 8, init locals
    .locals ([0] TaggedObject, [1] float, [2] float, [3] bool, [4] float, [5] Weapon.EDamageAffectedByBlacksmithUpgrade, [6] List.Enumerator<AdditionalWeaponEffectScript>)
    IL_0000: ldarg.1
    IL_0001: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_000f: stloc.0
    IL_0010: ldloc.0
    IL_0011: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0016: brtrue.s IL_0019
    IL_0018: ret
    IL_0019: ldarg.2
    IL_001a: stloc.1
    IL_001b: ldarg.0
    IL_001c: ldfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_0021: ldnull
    IL_0022: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0027: brfalse.s IL_0034
    IL_0029: ldarg.0
    IL_002a: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_002f: stfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_0034: ldarg.0
    IL_0035: ldfld Weapon.EDamageAffectedByBlacksmithUpgrade Weapon::blacksmithEffect  /*0x04001816*/
    IL_003a: stloc.s 5
    IL_003c: ldloc.s 5
    IL_003e: ldc.i4.1
    IL_003f: sub
    IL_0040: switch (IL_0057, IL_0067, IL_0077, IL_0087)
    IL_0055: br.s IL_0095
    IL_0057: ldloc.1
    IL_0058: ldarg.0
    IL_0059: ldfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_005e: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0063: mul
    IL_0064: stloc.1
    IL_0065: br.s IL_0095
    IL_0067: ldloc.1
    IL_0068: ldarg.0
    IL_0069: ldfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_006e: ldfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0073: mul
    IL_0074: stloc.1
    IL_0075: br.s IL_0095
    IL_0077: ldloc.1
    IL_0078: ldarg.0
    IL_0079: ldfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_007e: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0083: div
    IL_0084: stloc.1
    IL_0085: br.s IL_0095
    IL_0087: ldloc.1
    IL_0088: ldarg.0
    IL_0089: ldfld BlacksmithUpgrades Weapon::blacksmithUpgrades  /*0x0400182F*/
    IL_008e: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0093: div
    IL_0094: stloc.1
    IL_0095: ldarg.1
    IL_0096: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_009b: stloc.2
    IL_009c: ldarg.s 4
    IL_009e: brfalse.s IL_00bd
    IL_00a0: ldarg.0
    IL_00a1: ldloc.0
    IL_00a2: ldloc.1
    IL_00a3: call float Weapon::CalculateSplashDamageOnTarget(TaggedObject,float)  /*0x060013CF*/
    IL_00a8: stloc.s 4
    IL_00aa: ldarg.1
    IL_00ab: ldloc.s 4
    IL_00ad: ldarg.3
    IL_00ae: ldarg.0
    IL_00af: ldfld bool Weapon::isPlayerWeapon  /*0x04001828*/
    IL_00b4: ldc.i4.1
    IL_00b5: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00ba: stloc.3
    IL_00bb: br.s IL_00d8
    IL_00bd: ldarg.0
    IL_00be: ldloc.0
    IL_00bf: ldloc.1
    IL_00c0: call float Weapon::CalculateDirectDamageOnTarget(TaggedObject,float)  /*0x060013CE*/
    IL_00c5: stloc.s 4
    IL_00c7: ldarg.1
    IL_00c8: ldloc.s 4
    IL_00ca: ldarg.3
    IL_00cb: ldarg.0
    IL_00cc: ldfld bool Weapon::isPlayerWeapon  /*0x04001828*/
    IL_00d1: ldc.i4.1
    IL_00d2: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00d7: stloc.3
    IL_00d8: ldloc.s 4
    IL_00da: ldc.r4 0f
    IL_00df: bne.un.s IL_00e2
    IL_00e1: ret
    IL_00e2: ldarg.0
    IL_00e3: ldfld List<AdditionalWeaponEffectScript> Weapon::additionalWeaponEffects  /*0x0400182E*/
    IL_00e8: callvirt List.Enumerator<!0> System.Collections.Generic.List<AdditionalWeaponEffectScript>::GetEnumerator()  /*0x0A000780*/
    IL_00ed: stloc.s 6
    IL_00ef: br.s IL_0105
    IL_00f1: ldloca.s 6
    IL_00f3: call !0 System.Collections.Generic.List.Enumerator<AdditionalWeaponEffectScript>::get_Current()  /*0x0A000781*/
    IL_00f8: ldarg.1
    IL_00f9: ldloc.0
    IL_00fa: ldarg.3
    IL_00fb: ldarg.0
    IL_00fc: ldarg.2
    IL_00fd: ldloc.3
    IL_00fe: ldloc.s 4
    IL_0100: callvirt void AdditionalWeaponEffectScript::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  /*0x06000027*/
    IL_0105: ldloca.s 6
    IL_0107: call bool System.Collections.Generic.List.Enumerator<AdditionalWeaponEffectScript>::MoveNext()  /*0x0A000782*/
    IL_010c: brtrue.s IL_00f1
    IL_010e: leave.s IL_011e
    IL_0110: ldloca.s 6
    IL_0112: constrained. System.Collections.Generic.List.Enumerator<AdditionalWeaponEffectScript>  /*0x1B000164*/
    IL_0118: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_011d: endfinally
    IL_011e: ldloc.0
    IL_011f: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0124: ldc.i4.2
    IL_0125: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_012a: brfalse.s IL_019f
    IL_012c: ldarg.0
    IL_012d: ldfld PlayerUpgradeManager Weapon::playerUpgradeManager  /*0x0400182C*/
    IL_0132: ldfld bool PlayerUpgradeManager::magicArmor  /*0x04000F28*/
    IL_0137: brfalse.s IL_019f
    IL_0139: ldloc.2
    IL_013a: ldarg.1
    IL_013b: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0140: sub
    IL_0141: ldc.r4 0f
    IL_0146: ble.un.s IL_019f
    IL_0148: ldarg.3
    IL_0149: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_014e: brfalse.s IL_019f
    IL_0150: ldarg.3
    IL_0151: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0156: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_015b: brfalse.s IL_019f
    IL_015d: ldarg.3
    IL_015e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0163: ldc.i4.5
    IL_0164: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0169: brfalse.s IL_0186
    IL_016b: ldarg.3
    IL_016c: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0171: ldsfld UpgradeMagicArmor UpgradeMagicArmor::instance  /*0x04000F1B*/
    IL_0176: ldfld float UpgradeMagicArmor::damageVersusRanged  /*0x04000F1D*/
    IL_017b: ldloc.0
    IL_017c: ldc.i4.1
    IL_017d: ldc.i4.1
    IL_017e: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0183: pop
    IL_0184: br.s IL_019f
    IL_0186: ldarg.3
    IL_0187: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_018c: ldsfld UpgradeMagicArmor UpgradeMagicArmor::instance  /*0x04000F1B*/
    IL_0191: ldfld float UpgradeMagicArmor::damageVersusMelee  /*0x04000F1C*/
    IL_0196: ldloc.0
    IL_0197: ldc.i4.1
    IL_0198: ldc.i4.1
    IL_0199: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_019e: pop
    IL_019f: ldarg.0
    IL_01a0: ldfld float Weapon::slowsFastEnemiesFor  /*0x0400182B*/
    IL_01a5: ldc.r4 0f
    IL_01aa: blt.un.s IL_01f7
    IL_01ac: ldloc.0
    IL_01ad: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_01b2: ldc.i4.s 16
    IL_01b4: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01b9: brfalse.s IL_01f7
    IL_01bb: ldarg.1
    IL_01bc: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_01c1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01c6: brfalse.s IL_01f7
    IL_01c8: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_01cd: callvirt bool PerkManager::get_IceMagicActive()  /*0x06000984*/
    IL_01d2: brfalse.s IL_01e6
    IL_01d4: ldarg.1
    IL_01d5: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_01da: ldarg.0
    IL_01db: ldfld float Weapon::slowsFastEnemiesFor  /*0x0400182B*/
    IL_01e0: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_01e5: ret
    IL_01e6: ldarg.1
    IL_01e7: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_01ec: ldarg.0
    IL_01ed: ldfld float Weapon::slowsFastEnemiesFor  /*0x0400182B*/
    IL_01f2: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_01f7: ret
    .try IL_00ef-IL_0110 finally handler IL_0110-IL_011e

  .method Weapon::CalculateDirectDamageOnTarget(TaggedObject,float)  // token 0x060013CE rva 0x5e540 attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<DamageModifyer> Weapon::directDamage  /*0x04001829*/
    IL_0007: ldarg.2
    IL_0008: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_000d: ret

  .method Weapon::CalculateSplashDamageOnTarget(TaggedObject,float)  // token 0x060013CF rva 0x5e54f attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<DamageModifyer> Weapon::splashDamage  /*0x0400182A*/
    IL_0007: ldarg.2
    IL_0008: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_000d: ret

  .method Weapon::CalculateDamageGeneral(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  // token 0x060013D0 rva 0x5e55e attrs Public, Static, HideBySig
    // code size 9 (0x9), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.2
    IL_0003: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_0008: ret

  .method Weapon::.ctor()  // token 0x060013D1 rva 0x5e568 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float Weapon::raycastLength  /*0x0400181D*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10000f
    IL_0011: stfld float Weapon::maximumChaseRange  /*0x04001820*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 20f
    IL_001c: stfld float Weapon::shootWithoutTargetRange  /*0x04001821*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<AdditionalWeaponEffectScript>::.ctor()  /*0x0A000783*/
    IL_0027: stfld List<AdditionalWeaponEffectScript> Weapon::additionalWeaponEffects  /*0x0400182E*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0032: ret

// ===== Weapon/EFacingDirection  (token 0x0200039D) =====
// ===== Weapon/EDamageAffectedByBlacksmithUpgrade  (token 0x0200039E) =====
