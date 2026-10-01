// ===== EmpireUpgrade  (token 0x02000133) =====
  .method EmpireUpgrade::OnEnable()  // token 0x06000662 rva 0x1aca4 attrs Private, HideBySig
    // code size 196 (0xc4), max stack 4, init locals
    .locals ([0] AutoAttackTower[], [1] int)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0010: dup
    IL_0011: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0016: ldarg.0
    IL_0017: ldfld float EmpireUpgrade::meleeDamageMultiplyer  /*0x040007B9*/
    IL_001c: mul
    IL_001d: stfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0022: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0027: dup
    IL_0028: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_002d: ldarg.0
    IL_002e: ldfld float EmpireUpgrade::universalResistanceMultiplyer  /*0x040007BA*/
    IL_0033: mul
    IL_0034: stfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0039: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_003e: dup
    IL_003f: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0044: ldarg.0
    IL_0045: ldfld float EmpireUpgrade::universalResistanceMultiplyer  /*0x040007BA*/
    IL_004a: mul
    IL_004b: stfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0050: ldarg.0
    IL_0051: ldfld float EmpireUpgrade::towerDamageMultiplyer  /*0x040007B8*/
    IL_0056: ldc.r4 1f
    IL_005b: beq.s IL_00c3
    IL_005d: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_0062: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0067: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_006c: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_0071: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0076: ldc.i4.1
    IL_0077: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren(bool)<AutoAttackTower>  /*0x2B000055*/
    IL_007c: stloc.0
    IL_007d: ldc.i4.0
    IL_007e: stloc.1
    IL_007f: br.s IL_00bd
    IL_0081: ldloc.0
    IL_0082: ldloc.1
    IL_0083: ldelem.ref
    IL_0084: dup
    IL_0085: dup
    IL_0086: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_008b: ldarg.0
    IL_008c: ldfld float EmpireUpgrade::towerDamageMultiplyer  /*0x040007B8*/
    IL_0091: mul
    IL_0092: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0097: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009c: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00a1: ldc.i4.1
    IL_00a2: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<HotOilTower>  /*0x2B000056*/
    IL_00a7: dup
    IL_00a8: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld float EmpireUpgrade::towerDamageMultiplyer  /*0x040007B8*/
    IL_00b3: mul
    IL_00b4: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_00b9: ldloc.1
    IL_00ba: ldc.i4.1
    IL_00bb: add
    IL_00bc: stloc.1
    IL_00bd: ldloc.1
    IL_00be: ldloc.0
    IL_00bf: ldlen
    IL_00c0: conv.i4
    IL_00c1: blt.s IL_0081
    IL_00c3: ret

  .method EmpireUpgrade::OnDusk()  // token 0x06000663 rva 0x1ad74 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 135 (0x87), max stack 3, init locals
    .locals ([0] int, [1] float, [2] float)
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_000a: stloc.0
    IL_000b: ldloc.0
    IL_000c: ldarg.0
    IL_000d: ldfld int EmpireUpgrade::lastRememberedGoldBalance  /*0x040007BC*/
    IL_0012: beq.s IL_0086
    IL_0014: ldc.r4 1f
    IL_0019: ldloc.0
    IL_001a: conv.r4
    IL_001b: ldarg.0
    IL_001c: ldfld int EmpireUpgrade::goldToDoublePower  /*0x040007B7*/
    IL_0021: conv.r4
    IL_0022: div
    IL_0023: add
    IL_0024: stloc.1
    IL_0025: ldloc.1
    IL_0026: conv.r4
    IL_0027: ldarg.0
    IL_0028: ldfld float EmpireUpgrade::currentlyAppliedMultiplyer  /*0x040007BB*/
    IL_002d: conv.r4
    IL_002e: div
    IL_002f: stloc.2
    IL_0030: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0035: dup
    IL_0036: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_003b: ldloc.2
    IL_003c: mul
    IL_003d: stfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0042: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0047: dup
    IL_0048: ldfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_004d: ldloc.2
    IL_004e: mul
    IL_004f: stfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0054: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0059: dup
    IL_005a: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_005f: ldloc.2
    IL_0060: mul
    IL_0061: stfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0066: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_006b: dup
    IL_006c: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0071: ldloc.2
    IL_0072: mul
    IL_0073: stfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0078: ldarg.0
    IL_0079: ldloc.1
    IL_007a: stfld float EmpireUpgrade::currentlyAppliedMultiplyer  /*0x040007BB*/
    IL_007f: ldarg.0
    IL_0080: ldloc.0
    IL_0081: stfld int EmpireUpgrade::lastRememberedGoldBalance  /*0x040007BC*/
    IL_0086: ret

  .method EmpireUpgrade::OnDawn_AfterSunrise()  // token 0x06000664 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EmpireUpgrade::OnDawn_BeforeSunrise()  // token 0x06000665 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EmpireUpgrade::OnDuskEarly()  // token 0x06000666 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EmpireUpgrade::.ctor()  // token 0x06000667 rva 0x1ae08 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4 1000
    IL_0006: stfld int EmpireUpgrade::goldToDoublePower  /*0x040007B7*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float EmpireUpgrade::towerDamageMultiplyer  /*0x040007B8*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float EmpireUpgrade::meleeDamageMultiplyer  /*0x040007B9*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float EmpireUpgrade::universalResistanceMultiplyer  /*0x040007BA*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float EmpireUpgrade::currentlyAppliedMultiplyer  /*0x040007BB*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.m1
    IL_0039: stfld int EmpireUpgrade::lastRememberedGoldBalance  /*0x040007BC*/
    IL_003e: ldarg.0
    IL_003f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0044: ret

