// ===== AutoAttackAncientCannon  (token 0x020000C6) =====
  .method AutoAttackAncientCannon::OnAttack(TaggedObject)  // token 0x0600041A rva 0x119a0 attrs Public, Virtual, HideBySig
    // code size 211 (0xd3), max stack 7, init locals
    .locals ([0] Vector3, [1] HpCrystalDragon)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_001b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0020: stloc.0
    IL_0021: ldarg.0
    IL_0022: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_003b
    IL_002f: ldarg.0
    IL_0030: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0035: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003a: stloc.0
    IL_003b: ldarg.1
    IL_003c: ldnull
    IL_003d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0042: brfalse.s IL_0086
    IL_0044: ldarg.1
    IL_0045: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_004a: isinst HpCrystalDragon  /*0x020000DA*/
    IL_004f: stloc.1
    IL_0050: ldloc.1
    IL_0051: brfalse.s IL_0086
    IL_0053: ldloc.1
    IL_0054: callvirt CrystalDragonPhasing.CrystalDragonPhase HpCrystalDragon::get_CurrentPhase()  /*0x06000498*/
    IL_0059: ldc.i4.2
    IL_005a: beq.s IL_0065
    IL_005c: ldloc.1
    IL_005d: callvirt CrystalDragonPhasing.CrystalDragonPhase HpCrystalDragon::get_CurrentPhase()  /*0x06000498*/
    IL_0062: ldc.i4.3
    IL_0063: bne.un.s IL_0071
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld float AutoAttackAncientCannon::crystlaPhaseMultiplier  /*0x04000548*/
    IL_006c: stfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0071: ldloc.1
    IL_0072: callvirt CrystalDragonPhasing.CrystalDragonPhase HpCrystalDragon::get_CurrentPhase()  /*0x06000498*/
    IL_0077: ldc.i4.4
    IL_0078: bne.un.s IL_0086
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: ldfld float AutoAttackAncientCannon::angerPhaseMultiplier  /*0x04000549*/
    IL_0081: stfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0086: ldarg.0
    IL_0087: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_008c: ldloc.0
    IL_008d: ldarg.1
    IL_008e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0093: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0098: ldarg.0
    IL_0099: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_009e: ldarg.0
    IL_009f: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_00aa: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_00af: ldarg.0
    IL_00b0: ldarg.1
    IL_00b1: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00bb: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00c6: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00cb: ldarg.0
    IL_00cc: ldc.i4.1
    IL_00cd: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00d2: ret

  .method AutoAttackAncientCannon::.ctor()  // token 0x0600041B rva 0x11a7f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float AutoAttackAncientCannon::crystlaPhaseMultiplier  /*0x04000548*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float AutoAttackAncientCannon::angerPhaseMultiplier  /*0x04000549*/
    IL_0016: ldarg.0
    IL_0017: call void AutoAttackWithMinRange::.ctor()  /*0x06000458*/
    IL_001c: ret

