// ===== TowerUpgrade  (token 0x020002BD) =====
  .method TowerUpgrade::get_RangeMulti()  // token 0x06000F16 rva 0x438d5 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float TowerUpgrade::rangeMulti  /*0x0400116E*/
    IL_0006: ret

  .method TowerUpgrade::OnEnable()  // token 0x06000F17 rva 0x438e0 attrs Private, HideBySig
    // code size 575 (0x23f), max stack 4, init locals
    .locals ([0] List.Enumerator<TargetPriority>, [1] List<TagManager.ETag>, [2] List<TagManager.ETag>, [3] float)
    IL_0000: ldarg.0
    IL_0001: ldfld bool TowerUpgrade::overrideTargetingMode  /*0x0400116B*/
    IL_0006: brfalse.s IL_0019
    IL_0008: ldarg.0
    IL_0009: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_000e: ldarg.0
    IL_000f: ldfld AutoAttackTower.ETargetingMode TowerUpgrade::targetingMode  /*0x0400116C*/
    IL_0014: stfld AutoAttackTower.ETargetingMode AutoAttackTower::targetingMode  /*0x04000313*/
    IL_0019: ldarg.0
    IL_001a: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_001f: dup
    IL_0020: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0025: ldarg.0
    IL_0026: ldfld float TowerUpgrade::attackCooldownMulti  /*0x0400116D*/
    IL_002b: mul
    IL_002c: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0031: ldarg.0
    IL_0032: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_0037: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_003c: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_0041: stloc.0
    IL_0042: br.s IL_005d
    IL_0044: ldloca.s 0
    IL_0046: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_004b: dup
    IL_004c: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0051: ldarg.0
    IL_0052: ldfld float TowerUpgrade::rangeMulti  /*0x0400116E*/
    IL_0057: mul
    IL_0058: stfld float TargetPriority::range  /*0x040010D2*/
    IL_005d: ldloca.s 0
    IL_005f: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0064: brtrue.s IL_0044
    IL_0066: leave.s IL_0076
    IL_0068: ldloca.s 0
    IL_006a: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0070: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0075: endfinally
    IL_0076: ldarg.0
    IL_0077: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_007c: dup
    IL_007d: callvirt float AutoAttack::get_ProjectileSpeedMultiplyer()  /*0x0600022E*/
    IL_0082: ldarg.0
    IL_0083: ldfld float TowerUpgrade::projectileSpeedMulti  /*0x0400116F*/
    IL_0088: mul
    IL_0089: callvirt void AutoAttack::set_ProjectileSpeedMultiplyer(float)  /*0x0600022F*/
    IL_008e: ldarg.0
    IL_008f: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_0094: dup
    IL_0095: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_009a: ldarg.0
    IL_009b: ldfld float TowerUpgrade::damageMulti  /*0x04001170*/
    IL_00a0: mul
    IL_00a1: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld Equippable TowerUpgrade::equippableForOneExtraProjectile  /*0x04001172*/
    IL_00ac: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_00b1: brfalse.s IL_00c1
    IL_00b3: ldarg.0
    IL_00b4: ldarg.0
    IL_00b5: ldfld int TowerUpgrade::additionalArrowsToShoot  /*0x04001171*/
    IL_00ba: ldc.i4.1
    IL_00bb: add
    IL_00bc: stfld int TowerUpgrade::additionalArrowsToShoot  /*0x04001171*/
    IL_00c1: ldarg.0
    IL_00c2: ldfld int TowerUpgrade::additionalArrowsToShoot  /*0x04001171*/
    IL_00c7: ldc.i4.0
    IL_00c8: ble.s IL_00fd
    IL_00ca: ldarg.0
    IL_00cb: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_00d0: dup
    IL_00d1: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld int TowerUpgrade::additionalArrowsToShoot  /*0x04001171*/
    IL_00dc: add
    IL_00dd: stfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_00ee: ldfld int AutoAttackTower::simultaneousProjectiles  /*0x04000314*/
    IL_00f3: newarr TaggedObject  /*0x02000298*/
    IL_00f8: stfld TaggedObject[] AutoAttackTower::tempCollectionArray  /*0x04000316*/
    IL_00fd: ldarg.0
    IL_00fe: ldfld Weapon TowerUpgrade::replaceWeapon  /*0x04001173*/
    IL_0103: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0108: brfalse.s IL_011b
    IL_010a: ldarg.0
    IL_010b: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_0110: ldarg.0
    IL_0111: ldfld Weapon TowerUpgrade::replaceWeapon  /*0x04001173*/
    IL_0116: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_011b: ldarg.0
    IL_011c: ldfld bool TowerUpgrade::changeToHealing  /*0x04001174*/
    IL_0121: brfalse.s IL_0185
    IL_0123: ldarg.0
    IL_0124: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_0129: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_012e: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_0133: stloc.0
    IL_0134: br.s IL_016c
    IL_0136: ldloca.s 0
    IL_0138: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_013d: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0142: dup
    IL_0143: ldc.i4.0
    IL_0144: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0149: dup
    IL_014a: ldc.i4.s 10
    IL_014c: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0151: stloc.1
    IL_0152: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0157: dup
    IL_0158: ldc.i4.8
    IL_0159: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_015e: stloc.2
    IL_015f: dup
    IL_0160: ldloc.1
    IL_0161: stfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0166: ldloc.2
    IL_0167: stfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_016c: ldloca.s 0
    IL_016e: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0173: brtrue.s IL_0136
    IL_0175: leave.s IL_0185
    IL_0177: ldloca.s 0
    IL_0179: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_017f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0184: endfinally
    IL_0185: ldarg.0
    IL_0186: ldfld bool TowerUpgrade::insertTargetPriority  /*0x04001175*/
    IL_018b: brfalse.s IL_01d2
    IL_018d: ldarg.0
    IL_018e: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_0193: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0198: ldc.i4.0
    IL_0199: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_019e: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_01a3: stloc.3
    IL_01a4: ldarg.0
    IL_01a5: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_01aa: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_01af: ldc.i4.0
    IL_01b0: ldarg.0
    IL_01b1: ldfld TargetPriority TowerUpgrade::targetPriority  /*0x04001176*/
    IL_01b6: callvirt void System.Collections.Generic.List<TargetPriority>::Insert(int,!0)  /*0x0A000600*/
    IL_01bb: ldarg.0
    IL_01bc: ldfld AutoAttackTower TowerUpgrade::autoAttackTower  /*0x0400116A*/
    IL_01c1: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_01c6: ldc.i4.0
    IL_01c7: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_01cc: ldloc.3
    IL_01cd: stfld float TargetPriority::range  /*0x040010D2*/
    IL_01d2: ldarg.0
    IL_01d3: ldfld Transform TowerUpgrade::spireTransform  /*0x04001177*/
    IL_01d8: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01dd: brfalse.s IL_0205
    IL_01df: ldarg.0
    IL_01e0: ldfld Transform TowerUpgrade::spireTransform  /*0x04001177*/
    IL_01e5: dup
    IL_01e6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01eb: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01f0: ldarg.0
    IL_01f1: ldfld float TowerUpgrade::adjustHeight  /*0x04001179*/
    IL_01f6: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01fb: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0200: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0205: ldarg.0
    IL_0206: ldfld Transform TowerUpgrade::healthBarTransform  /*0x04001178*/
    IL_020b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0210: brfalse.s IL_0238
    IL_0212: ldarg.0
    IL_0213: ldfld Transform TowerUpgrade::healthBarTransform  /*0x04001178*/
    IL_0218: dup
    IL_0219: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_021e: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0223: ldarg.0
    IL_0224: ldfld float TowerUpgrade::adjustHeight  /*0x04001179*/
    IL_0229: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_022e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0233: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0238: ldarg.0
    IL_0239: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_023e: ret
    .try IL_0042-IL_0068 finally handler IL_0068-IL_0076
    .try IL_0134-IL_0177 finally handler IL_0177-IL_0185

  .method TowerUpgrade::.ctor()  // token 0x06000F18 rva 0x43b48 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float TowerUpgrade::attackCooldownMulti  /*0x0400116D*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TowerUpgrade::rangeMulti  /*0x0400116E*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float TowerUpgrade::projectileSpeedMulti  /*0x0400116F*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float TowerUpgrade::damageMulti  /*0x04001170*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

