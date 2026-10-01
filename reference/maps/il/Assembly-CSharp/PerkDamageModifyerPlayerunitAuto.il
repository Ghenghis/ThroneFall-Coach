// ===== PerkDamageModifyerPlayerunitAuto  (token 0x02000220) =====
  .method PerkDamageModifyerPlayerunitAuto::Start()  // token 0x06000B66 rva 0x36584 attrs Private, HideBySig
    // code size 350 (0x15e), max stack 3, init locals
    .locals ([0] PerkManager, [1] AutoAttack[], [2] int, [3] HotOilTower[], [4] BarricadeDamage[])
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: callvirt bool PerkManager::get_ArcherySkillsActive()  /*0x06000983*/
    IL_000c: brfalse.s IL_0039
    IL_000e: ldarg.0
    IL_000f: ldc.i4.1
    IL_0010: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<AutoAttack>  /*0x2B0000A9*/
    IL_0015: stloc.1
    IL_0016: ldc.i4.0
    IL_0017: stloc.2
    IL_0018: br.s IL_0033
    IL_001a: ldloc.1
    IL_001b: ldloc.2
    IL_001c: ldelem.ref
    IL_001d: dup
    IL_001e: callvirt float AutoAttack::get_ProjectileSpeedMultiplyer()  /*0x0600022E*/
    IL_0023: ldloc.0
    IL_0024: ldfld float PerkManager::archerySkills_projectileSpeedMulti  /*0x04000C0E*/
    IL_0029: mul
    IL_002a: callvirt void AutoAttack::set_ProjectileSpeedMultiplyer(float)  /*0x0600022F*/
    IL_002f: ldloc.2
    IL_0030: ldc.i4.1
    IL_0031: add
    IL_0032: stloc.2
    IL_0033: ldloc.2
    IL_0034: ldloc.1
    IL_0035: ldlen
    IL_0036: conv.i4
    IL_0037: blt.s IL_001a
    IL_0039: ldloc.0
    IL_003a: callvirt bool PerkManager::get_WarriorModeActive()  /*0x0600097F*/
    IL_003f: brfalse IL_00c8
    IL_0044: ldarg.0
    IL_0045: ldc.i4.1
    IL_0046: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<AutoAttack>  /*0x2B0000A9*/
    IL_004b: stloc.1
    IL_004c: ldc.i4.0
    IL_004d: stloc.2
    IL_004e: br.s IL_0069
    IL_0050: ldloc.1
    IL_0051: ldloc.2
    IL_0052: ldelem.ref
    IL_0053: dup
    IL_0054: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0059: ldloc.0
    IL_005a: ldfld float PerkManager::warriorModeAllyDmgMulti  /*0x04000C04*/
    IL_005f: mul
    IL_0060: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0065: ldloc.2
    IL_0066: ldc.i4.1
    IL_0067: add
    IL_0068: stloc.2
    IL_0069: ldloc.2
    IL_006a: ldloc.1
    IL_006b: ldlen
    IL_006c: conv.i4
    IL_006d: blt.s IL_0050
    IL_006f: ldarg.0
    IL_0070: ldc.i4.1
    IL_0071: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<HotOilTower>  /*0x2B0000AA*/
    IL_0076: stloc.3
    IL_0077: ldc.i4.0
    IL_0078: stloc.2
    IL_0079: br.s IL_0094
    IL_007b: ldloc.3
    IL_007c: ldloc.2
    IL_007d: ldelem.ref
    IL_007e: dup
    IL_007f: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0084: ldloc.0
    IL_0085: ldfld float PerkManager::warriorModeAllyDmgMulti  /*0x04000C04*/
    IL_008a: mul
    IL_008b: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0090: ldloc.2
    IL_0091: ldc.i4.1
    IL_0092: add
    IL_0093: stloc.2
    IL_0094: ldloc.2
    IL_0095: ldloc.3
    IL_0096: ldlen
    IL_0097: conv.i4
    IL_0098: blt.s IL_007b
    IL_009a: ldarg.0
    IL_009b: ldc.i4.1
    IL_009c: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<BarricadeDamage>  /*0x2B0000AB*/
    IL_00a1: stloc.s 4
    IL_00a3: ldc.i4.0
    IL_00a4: stloc.2
    IL_00a5: br.s IL_00c1
    IL_00a7: ldloc.s 4
    IL_00a9: ldloc.2
    IL_00aa: ldelem.ref
    IL_00ab: dup
    IL_00ac: ldfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_00b1: ldloc.0
    IL_00b2: ldfld float PerkManager::warriorModeAllyDmgMulti  /*0x04000C04*/
    IL_00b7: mul
    IL_00b8: stfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_00bd: ldloc.2
    IL_00be: ldc.i4.1
    IL_00bf: add
    IL_00c0: stloc.2
    IL_00c1: ldloc.2
    IL_00c2: ldloc.s 4
    IL_00c4: ldlen
    IL_00c5: conv.i4
    IL_00c6: blt.s IL_00a7
    IL_00c8: ldloc.0
    IL_00c9: callvirt bool PerkManager::get_CommanderModeActive()  /*0x06000980*/
    IL_00ce: brfalse IL_0157
    IL_00d3: ldarg.0
    IL_00d4: ldc.i4.1
    IL_00d5: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<AutoAttack>  /*0x2B0000A9*/
    IL_00da: stloc.1
    IL_00db: ldc.i4.0
    IL_00dc: stloc.2
    IL_00dd: br.s IL_00f8
    IL_00df: ldloc.1
    IL_00e0: ldloc.2
    IL_00e1: ldelem.ref
    IL_00e2: dup
    IL_00e3: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_00e8: ldloc.0
    IL_00e9: ldfld float PerkManager::commanderModeAllyDmgMulti  /*0x04000C07*/
    IL_00ee: mul
    IL_00ef: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_00f4: ldloc.2
    IL_00f5: ldc.i4.1
    IL_00f6: add
    IL_00f7: stloc.2
    IL_00f8: ldloc.2
    IL_00f9: ldloc.1
    IL_00fa: ldlen
    IL_00fb: conv.i4
    IL_00fc: blt.s IL_00df
    IL_00fe: ldarg.0
    IL_00ff: ldc.i4.1
    IL_0100: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<HotOilTower>  /*0x2B0000AA*/
    IL_0105: stloc.3
    IL_0106: ldc.i4.0
    IL_0107: stloc.2
    IL_0108: br.s IL_0123
    IL_010a: ldloc.3
    IL_010b: ldloc.2
    IL_010c: ldelem.ref
    IL_010d: dup
    IL_010e: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0113: ldloc.0
    IL_0114: ldfld float PerkManager::commanderModeAllyDmgMulti  /*0x04000C07*/
    IL_0119: mul
    IL_011a: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_011f: ldloc.2
    IL_0120: ldc.i4.1
    IL_0121: add
    IL_0122: stloc.2
    IL_0123: ldloc.2
    IL_0124: ldloc.3
    IL_0125: ldlen
    IL_0126: conv.i4
    IL_0127: blt.s IL_010a
    IL_0129: ldarg.0
    IL_012a: ldc.i4.1
    IL_012b: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<BarricadeDamage>  /*0x2B0000AB*/
    IL_0130: stloc.s 4
    IL_0132: ldc.i4.0
    IL_0133: stloc.2
    IL_0134: br.s IL_0150
    IL_0136: ldloc.s 4
    IL_0138: ldloc.2
    IL_0139: ldelem.ref
    IL_013a: dup
    IL_013b: ldfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_0140: ldloc.0
    IL_0141: ldfld float PerkManager::commanderModeAllyDmgMulti  /*0x04000C07*/
    IL_0146: mul
    IL_0147: stfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_014c: ldloc.2
    IL_014d: ldc.i4.1
    IL_014e: add
    IL_014f: stloc.2
    IL_0150: ldloc.2
    IL_0151: ldloc.s 4
    IL_0153: ldlen
    IL_0154: conv.i4
    IL_0155: blt.s IL_0136
    IL_0157: ldarg.0
    IL_0158: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_015d: ret

  .method PerkDamageModifyerPlayerunitAuto::.ctor()  // token 0x06000B67 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

