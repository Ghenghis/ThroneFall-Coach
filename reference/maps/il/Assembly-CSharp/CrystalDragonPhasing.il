// ===== CrystalDragonPhasing  (token 0x020000D6) =====
  .method CrystalDragonPhasing::Start()  // token 0x06000473 rva 0x13a20 attrs Private, HideBySig
    // code size 300 (0x12c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call bool CrystalDragonPhasing::Validate()  /*0x06000475*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_000f: ldnull
    IL_0010: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0015: brfalse.s IL_0023
    IL_0017: ldarg.0
    IL_0018: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_001d: ldc.i4.0
    IL_001e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0023: ldarg.0
    IL_0024: call void CrystalDragonPhasing::SilenceAttacks()  /*0x06000482*/
    IL_0029: ldarg.0
    IL_002a: call void CrystalDragonPhasing::PutToSomePhase()  /*0x06000478*/
    IL_002f: ldarg.0
    IL_0030: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_0035: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_003a: ldarg.0
    IL_003b: ldftn void CrystalDragonPhasing::OnKillOrKnockoutAction()  /*0x06000477*/
    IL_0041: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0046: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_004b: ldarg.0
    IL_004c: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0051: ldfld UnityEvent<Vector3> FlyBehaviour::StartFlyEvent  /*0x040005DF*/
    IL_0056: ldarg.0
    IL_0057: ldftn void CrystalDragonPhasing::OnStartFly(UnityEngine.Vector3)  /*0x06000483*/
    IL_005d: newobj void UnityEngine.Events.UnityAction<UnityEngine.Vector3>::.ctor(object,IntPtr)  /*0x0A000089*/
    IL_0062: callvirt void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A00008A*/
    IL_0067: ldarg.0
    IL_0068: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_006d: ldfld UnityEvent FlyBehaviour::EndFlyEvent  /*0x040005E0*/
    IL_0072: ldarg.0
    IL_0073: ldftn void CrystalDragonPhasing::OnEndFly()  /*0x06000476*/
    IL_0079: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_007e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0083: ldarg.0
    IL_0084: ldfld AutoAttack CrystalDragonPhasing::crystalStomp  /*0x040005BA*/
    IL_0089: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_008e: ldarg.0
    IL_008f: ldftn void CrystalDragonPhasing::OnCrystalStomp()  /*0x06000484*/
    IL_0095: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_009a: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_009f: ldarg.0
    IL_00a0: ldfld AutoAttack CrystalDragonPhasing::bellySmash  /*0x040005BB*/
    IL_00a5: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00aa: ldarg.0
    IL_00ab: ldftn void CrystalDragonPhasing::OnBellySmashTriggered()  /*0x06000485*/
    IL_00b1: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00b6: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00bb: ldarg.0
    IL_00bc: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_00c1: ldfld UnityEvent AutoAttackWithDelay::BeforeDelayedAttackTrigger  /*0x0400057A*/
    IL_00c6: ldarg.0
    IL_00c7: ldftn void CrystalDragonPhasing::OnBeforeFlameSpitterAttack()  /*0x06000486*/
    IL_00cd: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00d2: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00d7: ldarg.0
    IL_00d8: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_00dd: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00e2: ldarg.0
    IL_00e3: ldftn void CrystalDragonPhasing::OnFlameSpitterActualAttack()  /*0x06000487*/
    IL_00e9: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00ee: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00f3: ldarg.0
    IL_00f4: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_00f9: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00fe: ldarg.0
    IL_00ff: ldftn void CrystalDragonPhasing::OnFireBall()  /*0x06000488*/
    IL_0105: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_010a: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_010f: ldarg.0
    IL_0110: ldfld AutoAttackLavaGolemPuddle CrystalDragonPhasing::fireTrail  /*0x040005BE*/
    IL_0115: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_011a: ldarg.0
    IL_011b: ldftn void CrystalDragonPhasing::OnFireTrail()  /*0x06000489*/
    IL_0121: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0126: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_012b: ret

  .method CrystalDragonPhasing::Update()  // token 0x06000474 rva 0x13b58 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 2, init locals
    .locals ([0] CrystalDragonPhasing.CrystalDragonPhase)
    IL_0000: ldarg.0
    IL_0001: ldfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldc.i4.4
    IL_0009: beq.s IL_0016
    IL_000b: ldloc.0
    IL_000c: ldc.i4.5
    IL_000d: bne.un.s IL_001c
    IL_000f: ldarg.0
    IL_0010: call void CrystalDragonPhasing::UpdateRegen()  /*0x0600047E*/
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: call void CrystalDragonPhasing::UpdateAngerPhase()  /*0x0600047F*/
    IL_001c: ret

  .method CrystalDragonPhasing::Validate()  // token 0x06000475 rva 0x13b84 attrs Private, HideBySig
    // code size 188 (0xbc), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call !!0 UnityEngine.Component::GetComponent()<HpCrystalDragon>  /*0x2B000038*/
    IL_0015: stfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_001a: ldarg.0
    IL_001b: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0026: brfalse.s IL_0034
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call !!0 UnityEngine.Component::GetComponent()<FlyBehaviour>  /*0x2B000039*/
    IL_002f: stfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0034: ldarg.0
    IL_0035: ldfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0040: brfalse.s IL_004e
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0049: stfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_004e: ldarg.0
    IL_004f: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0054: ldnull
    IL_0055: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005a: brfalse.s IL_0068
    IL_005c: ldarg.0
    IL_005d: ldarg.0
    IL_005e: call !!0 UnityEngine.Component::GetComponent()<PathfindMovementEnemy>  /*0x2B00000E*/
    IL_0063: stfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0068: ldarg.0
    IL_0069: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_006e: ldnull
    IL_006f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0074: brtrue.s IL_00ae
    IL_0076: ldarg.0
    IL_0077: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_007c: ldnull
    IL_007d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0082: brtrue.s IL_00ae
    IL_0084: ldarg.0
    IL_0085: ldfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_008a: ldnull
    IL_008b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0090: brtrue.s IL_00ae
    IL_0092: ldarg.0
    IL_0093: ldfld InstantEnemySpawn CrystalDragonPhasing::minionSpawner  /*0x040005C0*/
    IL_0098: ldnull
    IL_0099: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_009e: brtrue.s IL_00ae
    IL_00a0: ldarg.0
    IL_00a1: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_00a6: ldnull
    IL_00a7: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00ac: brfalse.s IL_00ba
    IL_00ae: ldstr "There are empty References for CrystalDragonPhasing"
    IL_00b3: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_00b8: ldc.i4.0
    IL_00b9: ret
    IL_00ba: ldc.i4.1
    IL_00bb: ret

  .method CrystalDragonPhasing::OnEndFly()  // token 0x06000476 rva 0x13c4c attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool CrystalDragonPhasing::needRegen  /*0x040005CA*/
    IL_0006: brtrue.s IL_0029
    IL_0008: ldarg.0
    IL_0009: ldfld ParticleSystem CrystalDragonPhasing::endJumpToPhaseVFX  /*0x040005B0*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld ParticleSystem CrystalDragonPhasing::endJumpToPhaseVFX  /*0x040005B0*/
    IL_001c: ldc.i4.1
    IL_001d: callvirt void UnityEngine.ParticleSystem::Play(bool)  /*0x0A000206*/
    IL_0022: ldarg.0
    IL_0023: call void CrystalDragonPhasing::PutToSomePhase()  /*0x06000478*/
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: ldfld ParticleSystem CrystalDragonPhasing::endJumpToRegenVFX  /*0x040005AF*/
    IL_002f: ldnull
    IL_0030: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0035: brfalse.s IL_0043
    IL_0037: ldarg.0
    IL_0038: ldfld ParticleSystem CrystalDragonPhasing::endJumpToRegenVFX  /*0x040005AF*/
    IL_003d: ldc.i4.1
    IL_003e: callvirt void UnityEngine.ParticleSystem::Play(bool)  /*0x0A000206*/
    IL_0043: ldarg.0
    IL_0044: call void CrystalDragonPhasing::PutToRegen()  /*0x0600047D*/
    IL_0049: ret

  .method CrystalDragonPhasing::OnKillOrKnockoutAction()  // token 0x06000477 rva 0x13ca2 attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0006: ldc.i4.4
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_0010: ldarg.0
    IL_0011: ldfld Collider CrystalDragonPhasing::knockoutBigCollider  /*0x040005A4*/
    IL_0016: stfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_001b: ldarg.0
    IL_001c: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_0021: ldc.i4.1
    IL_0022: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: call void CrystalDragonPhasing::PutToJumpState(bool)  /*0x0600047C*/
    IL_002e: ret

  .method CrystalDragonPhasing::PutToSomePhase()  // token 0x06000478 rva 0x13cd4 attrs Private, HideBySig
    // code size 87 (0x57), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_0006: ldarg.0
    IL_0007: ldfld Collider CrystalDragonPhasing::aliveBigCollider  /*0x040005A3*/
    IL_000c: stfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0011: ldarg.0
    IL_0012: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_0017: ldc.i4.0
    IL_0018: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_001d: ldarg.0
    IL_001e: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0023: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0028: ldarg.0
    IL_0029: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_002e: stloc.0
    IL_002f: ldloc.0
    IL_0030: switch (IL_0042, IL_0049, IL_0050)
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: call void CrystalDragonPhasing::PutToCrystal1()  /*0x06000479*/
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: call void CrystalDragonPhasing::PutToCrystal2()  /*0x0600047A*/
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: call void CrystalDragonPhasing::PutToAnger()  /*0x0600047B*/
    IL_0056: ret

  .method CrystalDragonPhasing::PutToCrystal1()  // token 0x06000479 rva 0x13d38 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool CrystalDragonPhasing::castleReached  /*0x040005D2*/
    IL_000d: brtrue.s IL_001b
    IL_000f: ldarg.0
    IL_0010: ldfld AutoAttack CrystalDragonPhasing::crystalStomp  /*0x040005BA*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_001b: ldarg.0
    IL_001c: ldfld AutoAttack CrystalDragonPhasing::bellySmash  /*0x040005BB*/
    IL_0021: ldc.i4.1
    IL_0022: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0027: ldarg.0
    IL_0028: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_002d: ldarg.0
    IL_002e: ldfld GameObject CrystalDragonPhasing::knockoutAfter1FX  /*0x040005B7*/
    IL_0033: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0038: ldarg.0
    IL_0039: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_003e: ldarg.0
    IL_003f: ldfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0044: callvirt void HpCrystalDragon::SetCurrentPhase(CrystalDragonPhasing.CrystalDragonPhase)  /*0x06000499*/
    IL_0049: ret

  .method CrystalDragonPhasing::PutToCrystal2()  // token 0x0600047A rva 0x13d90 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool CrystalDragonPhasing::castleReached  /*0x040005D2*/
    IL_000d: brtrue.s IL_001b
    IL_000f: ldarg.0
    IL_0010: ldfld AutoAttack CrystalDragonPhasing::crystalStomp  /*0x040005BA*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_001b: ldarg.0
    IL_001c: ldfld AutoAttack CrystalDragonPhasing::bellySmash  /*0x040005BB*/
    IL_0021: ldc.i4.1
    IL_0022: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0027: ldarg.0
    IL_0028: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_002d: ldarg.0
    IL_002e: ldfld GameObject CrystalDragonPhasing::knockoutAfter2FX  /*0x040005B8*/
    IL_0033: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0038: ldarg.0
    IL_0039: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_003e: ldarg.0
    IL_003f: ldfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0044: callvirt void HpCrystalDragon::SetCurrentPhase(CrystalDragonPhasing.CrystalDragonPhase)  /*0x06000499*/
    IL_0049: ret

  .method CrystalDragonPhasing::PutToAnger()  // token 0x0600047B rva 0x13de8 attrs Private, HideBySig
    // code size 240 (0xf0), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ldarg.0
    IL_000d: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0018: ldarg.0
    IL_0019: ldfld AutoAttackLavaGolemPuddle CrystalDragonPhasing::fireTrail  /*0x040005BE*/
    IL_001e: ldc.i4.1
    IL_001f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0024: ldarg.0
    IL_0025: ldfld RotateForwardToRVOVelocity CrystalDragonPhasing::rotator  /*0x040005A2*/
    IL_002a: ldarg.0
    IL_002b: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0030: callvirt void RotateForwardToRVOVelocity::ReInitWithAttack(AutoAttack)  /*0x0600011B*/
    IL_0035: ldarg.0
    IL_0036: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_003b: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_0040: callvirt void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0045: ldarg.0
    IL_0046: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_004b: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_0050: ldarg.0
    IL_0051: ldfld TargetPriority CrystalDragonPhasing::buildingAgnerTarget  /*0x040005A7*/
    IL_0056: callvirt void System.Collections.Generic.List<TargetPriority>::Add(!0)  /*0x0A000208*/
    IL_005b: ldarg.0
    IL_005c: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0061: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_0066: ldarg.0
    IL_0067: ldfld TargetPriority CrystalDragonPhasing::playerAngerTarget  /*0x040005A8*/
    IL_006c: callvirt void System.Collections.Generic.List<TargetPriority>::Add(!0)  /*0x0A000208*/
    IL_0071: ldarg.0
    IL_0072: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0077: ldarg.0
    IL_0078: ldfld float CrystalDragonPhasing::angerSpeed  /*0x040005AE*/
    IL_007d: stfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0082: ldarg.0
    IL_0083: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0088: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_008d: ldarg.0
    IL_008e: ldc.i4.4
    IL_008f: stfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0094: ldarg.0
    IL_0095: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_009a: ldc.i4.0
    IL_009b: stfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld TaggedObject CrystalDragonPhasing::taggedObject  /*0x0400059F*/
    IL_00a6: ldc.i4.s 10
    IL_00a8: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld GameObject CrystalDragonPhasing::deathFX  /*0x040005B9*/
    IL_00b9: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_00be: ldarg.0
    IL_00bf: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_00ca: callvirt void HpCrystalDragon::SetCurrentPhase(CrystalDragonPhasing.CrystalDragonPhase)  /*0x06000499*/
    IL_00cf: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_00d4: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_00d9: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_00de: ldarg.0
    IL_00df: ldftn void CrystalDragonPhasing::OnPlayerKilled()  /*0x0600048A*/
    IL_00e5: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00ea: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00ef: ret

  .method CrystalDragonPhasing::PutToJumpState(bool)  // token 0x0600047C rva 0x13ee4 attrs Private, HideBySig
    // code size 130 (0x82), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: stfld bool CrystalDragonPhasing::castleReached  /*0x040005D2*/
    IL_000e: ldarg.0
    IL_000f: call void CrystalDragonPhasing::SilenceAttacks()  /*0x06000482*/
    IL_0014: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0019: pop
    IL_001a: ldarg.1
    IL_001b: brfalse.s IL_004f
    IL_001d: ldarg.0
    IL_001e: ldc.i4.1
    IL_001f: stfld bool CrystalDragonPhasing::needRegen  /*0x040005CA*/
    IL_0024: ldarg.0
    IL_0025: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_002a: brtrue.s IL_0043
    IL_002c: ldarg.0
    IL_002d: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0032: call Transform MapPointCrystalDragon::get_CrystalDragonFlyOffPoint()  /*0x0600049B*/
    IL_0037: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003c: ldc.i4.0
    IL_003d: callvirt void FlyBehaviour::RequestFly(UnityEngine.Vector3,bool)  /*0x0600048C*/
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0049: callvirt void FlyBehaviour::NoFlyWithEvent()  /*0x0600048D*/
    IL_004e: ret
    IL_004f: ldarg.0
    IL_0050: ldc.i4.0
    IL_0051: stfld bool CrystalDragonPhasing::needRegen  /*0x040005CA*/
    IL_0056: ldarg.0
    IL_0057: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_005c: ldc.i4.1
    IL_005d: bne.un.s IL_0076
    IL_005f: ldarg.0
    IL_0060: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_0065: call Transform MapPointCrystalDragon::get_CrystalDragonCrystal2PhaseSpawn()  /*0x0600049D*/
    IL_006a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006f: ldc.i4.1
    IL_0070: callvirt void FlyBehaviour::RequestFly(UnityEngine.Vector3,bool)  /*0x0600048C*/
    IL_0075: ret
    IL_0076: ldarg.0
    IL_0077: ldfld FlyBehaviour CrystalDragonPhasing::flyBehaviour  /*0x040005A0*/
    IL_007c: callvirt void FlyBehaviour::NoFlyWithEvent()  /*0x0600048D*/
    IL_0081: ret

  .method CrystalDragonPhasing::PutToRegen()  // token 0x0600047D rva 0x13f74 attrs Private, HideBySig
    // code size 137 (0x89), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_0014: ldc.i4.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_0021: ldc.i4.1
    IL_0022: add
    IL_0023: stfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.5
    IL_002a: stfld CrystalDragonPhasing.CrystalDragonPhase CrystalDragonPhasing::currentPhase  /*0x040005D3*/
    IL_002f: ldarg.0
    IL_0030: ldfld UnityEvent<int> CrystalDragonPhasing::ChangePhaseEvent  /*0x040005C9*/
    IL_0035: dup
    IL_0036: brtrue.s IL_003b
    IL_0038: pop
    IL_0039: br.s IL_0046
    IL_003b: ldarg.0
    IL_003c: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_0041: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_0046: ldarg.0
    IL_0047: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_004c: ldc.i4.1
    IL_004d: bne.un.s IL_0067
    IL_004f: ldarg.0
    IL_0050: ldfld GameObject CrystalDragonPhasing::AliveVisualsCrystal1  /*0x040005B4*/
    IL_0055: ldc.i4.0
    IL_0056: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005b: ldarg.0
    IL_005c: ldfld GameObject CrystalDragonPhasing::AliveVisualsCrystal2  /*0x040005B5*/
    IL_0061: ldc.i4.1
    IL_0062: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0067: ldarg.0
    IL_0068: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_006d: ldc.i4.2
    IL_006e: bne.un.s IL_0088
    IL_0070: ldarg.0
    IL_0071: ldfld GameObject CrystalDragonPhasing::AliveVisualsCrystal2  /*0x040005B5*/
    IL_0076: ldc.i4.0
    IL_0077: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007c: ldarg.0
    IL_007d: ldfld GameObject CrystalDragonPhasing::AliveVisualsAnger  /*0x040005B6*/
    IL_0082: ldc.i4.1
    IL_0083: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0088: ret

  .method CrystalDragonPhasing::UpdateRegen()  // token 0x0600047E rva 0x1400c attrs Private, HideBySig
    // code size 164 (0xa4), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float CrystalDragonPhasing::regenTimer  /*0x040005CC*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float CrystalDragonPhasing::regenTimer  /*0x040005CC*/
    IL_0012: ldarg.0
    IL_0013: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_0018: ldc.i4.1
    IL_0019: bne.un.s IL_002a
    IL_001b: ldarg.0
    IL_001c: ldfld float CrystalDragonPhasing::regenTimer  /*0x040005CC*/
    IL_0021: ldarg.0
    IL_0022: ldfld float CrystalDragonPhasing::flyOffRegenDuration  /*0x040005B1*/
    IL_0027: bge.un.s IL_002a
    IL_0029: ret
    IL_002a: ldarg.0
    IL_002b: ldfld int CrystalDragonPhasing::regenedTimes  /*0x040005CB*/
    IL_0030: ldc.i4.2
    IL_0031: bne.un.s IL_0042
    IL_0033: ldarg.0
    IL_0034: ldfld float CrystalDragonPhasing::regenTimer  /*0x040005CC*/
    IL_0039: ldarg.0
    IL_003a: ldfld float CrystalDragonPhasing::toAngerRegenDuration  /*0x040005B2*/
    IL_003f: bge.un.s IL_0042
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldc.i4.0
    IL_0044: stfld bool CrystalDragonPhasing::needRegen  /*0x040005CA*/
    IL_0049: ldarg.0
    IL_004a: ldfld HpCrystalDragon CrystalDragonPhasing::hp  /*0x0400059D*/
    IL_004f: ldc.i4.1
    IL_0050: ldc.r4 1f
    IL_0055: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_005a: ldarg.0
    IL_005b: call void CrystalDragonPhasing::SilenceAttacks()  /*0x06000482*/
    IL_0060: ldarg.0
    IL_0061: ldc.r4 0f
    IL_0066: stfld float CrystalDragonPhasing::regenTimer  /*0x040005CC*/
    IL_006b: ldarg.0
    IL_006c: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_0071: ldnull
    IL_0072: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0077: brfalse.s IL_0085
    IL_0079: ldarg.0
    IL_007a: ldfld GameObject CrystalDragonPhasing::regenVFX  /*0x040005B3*/
    IL_007f: ldc.i4.0
    IL_0080: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0085: ldarg.0
    IL_0086: ldc.i4.0
    IL_0087: call void CrystalDragonPhasing::PutToJumpState(bool)  /*0x0600047C*/
    IL_008c: ldarg.0
    IL_008d: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0092: ldc.i4.1
    IL_0093: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0098: ldarg.0
    IL_0099: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_009e: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_00a3: ret

  .method CrystalDragonPhasing::UpdateAngerPhase()  // token 0x0600047F rva 0x140bc attrs Private, HideBySig
    // code size 342 (0x156), max stack 3, init locals
    .locals ([0] float, [1] Vector3)
    IL_0000: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0005: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000f: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_0014: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001e: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0023: stloc.1
    IL_0024: ldloca.s 1
    IL_0026: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_002b: stloc.0
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld float CrystalDragonPhasing::minionSpawnTimer  /*0x040005CF*/
    IL_0033: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0038: add
    IL_0039: stfld float CrystalDragonPhasing::minionSpawnTimer  /*0x040005CF*/
    IL_003e: ldarg.0
    IL_003f: ldfld float CrystalDragonPhasing::minionSpawnTimer  /*0x040005CF*/
    IL_0044: ldarg.0
    IL_0045: ldfld float CrystalDragonPhasing::colldownMinionSpawn  /*0x040005BF*/
    IL_004a: blt.un.s IL_0073
    IL_004c: ldarg.0
    IL_004d: ldfld InstantEnemySpawn CrystalDragonPhasing::minionSpawner  /*0x040005C0*/
    IL_0052: callvirt void InstantEnemySpawn::SpawnWave()  /*0x06000859*/
    IL_0057: ldarg.0
    IL_0058: ldfld UnityEvent CrystalDragonPhasing::MinionsSpawnTrigger  /*0x040005C7*/
    IL_005d: dup
    IL_005e: brtrue.s IL_0063
    IL_0060: pop
    IL_0061: br.s IL_0068
    IL_0063: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0068: ldarg.0
    IL_0069: ldc.r4 0f
    IL_006e: stfld float CrystalDragonPhasing::minionSpawnTimer  /*0x040005CF*/
    IL_0073: ldarg.0
    IL_0074: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0079: callvirt TaggedObject PathfindMovementEnemy::get_SeekToTargetObj()  /*0x06000B0E*/
    IL_007e: ldnull
    IL_007f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0084: brfalse.s IL_0087
    IL_0086: ret
    IL_0087: ldarg.0
    IL_0088: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_008d: callvirt TaggedObject PathfindMovementEnemy::get_SeekToTargetObj()  /*0x06000B0E*/
    IL_0092: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0097: ldc.i4.2
    IL_0098: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_009d: brfalse.s IL_00ce
    IL_009f: ldarg.0
    IL_00a0: ldfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_00a5: brtrue.s IL_00ce
    IL_00a7: ldloc.0
    IL_00a8: ldarg.0
    IL_00a9: ldfld float CrystalDragonPhasing::playerCastleMaxDistance  /*0x040005A5*/
    IL_00ae: bgt.un.s IL_00c8
    IL_00b0: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_00b5: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_00ba: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_00bf: brfalse.s IL_00c8
    IL_00c1: ldarg.0
    IL_00c2: call void CrystalDragonPhasing::StartPlayerHunt()  /*0x06000480*/
    IL_00c7: ret
    IL_00c8: ldarg.0
    IL_00c9: call void CrystalDragonPhasing::StartCastleHunt()  /*0x06000481*/
    IL_00ce: ldarg.0
    IL_00cf: ldfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_00d4: brtrue.s IL_00df
    IL_00d6: ldarg.0
    IL_00d7: ldfld bool CrystalDragonPhasing::onCastleHunt  /*0x040005CE*/
    IL_00dc: brtrue.s IL_00df
    IL_00de: ret
    IL_00df: ldarg.0
    IL_00e0: ldarg.0
    IL_00e1: ldfld float CrystalDragonPhasing::playerCheckTimer  /*0x040005D0*/
    IL_00e6: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00eb: add
    IL_00ec: stfld float CrystalDragonPhasing::playerCheckTimer  /*0x040005D0*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld float CrystalDragonPhasing::playerCheckTimer  /*0x040005D0*/
    IL_00f7: ldarg.0
    IL_00f8: ldfld float CrystalDragonPhasing::playerCheckDuration  /*0x040005A6*/
    IL_00fd: bgt.un.s IL_0100
    IL_00ff: ret
    IL_0100: ldloc.0
    IL_0101: ldarg.0
    IL_0102: ldfld float CrystalDragonPhasing::playerCastleMaxDistance  /*0x040005A5*/
    IL_0107: blt.un.s IL_0122
    IL_0109: ldarg.0
    IL_010a: ldfld bool CrystalDragonPhasing::onCastleHunt  /*0x040005CE*/
    IL_010f: brtrue.s IL_0122
    IL_0111: ldarg.0
    IL_0112: call void CrystalDragonPhasing::StartCastleHunt()  /*0x06000481*/
    IL_0117: ldarg.0
    IL_0118: ldc.r4 0f
    IL_011d: stfld float CrystalDragonPhasing::playerCheckTimer  /*0x040005D0*/
    IL_0122: ldloc.0
    IL_0123: ldarg.0
    IL_0124: ldfld float CrystalDragonPhasing::playerCastleMaxDistance  /*0x040005A5*/
    IL_0129: bgt.un.s IL_0155
    IL_012b: ldarg.0
    IL_012c: ldfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_0131: brtrue.s IL_0155
    IL_0133: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0138: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_013d: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0142: brfalse.s IL_0155
    IL_0144: ldarg.0
    IL_0145: call void CrystalDragonPhasing::StartPlayerHunt()  /*0x06000480*/
    IL_014a: ldarg.0
    IL_014b: ldc.r4 0f
    IL_0150: stfld float CrystalDragonPhasing::playerCheckTimer  /*0x040005D0*/
    IL_0155: ret

  .method CrystalDragonPhasing::StartPlayerHunt()  // token 0x06000480 rva 0x14220 attrs Private, HideBySig
    // code size 141 (0x8d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0006: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt void System.Collections.Generic.List<TargetPriority>::RemoveAt(int)  /*0x0A00020A*/
    IL_0011: ldarg.0
    IL_0012: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0017: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_001c: ldarg.0
    IL_001d: ldfld TargetPriority CrystalDragonPhasing::playerAngerTarget  /*0x040005A8*/
    IL_0022: callvirt void System.Collections.Generic.List<TargetPriority>::Add(!0)  /*0x0A000208*/
    IL_0027: ldarg.0
    IL_0028: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_002d: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0032: ldarg.0
    IL_0033: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0038: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_003d: callvirt void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0042: ldarg.0
    IL_0043: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0048: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_004d: ldarg.0
    IL_004e: ldfld List<TargetPriority> CrystalDragonPhasing::playerHuntAttackTargetsMelee  /*0x040005AA*/
    IL_0053: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_0058: ldarg.0
    IL_0059: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_005e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0063: callvirt void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0068: ldarg.0
    IL_0069: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_006e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0073: ldarg.0
    IL_0074: ldfld List<TargetPriority> CrystalDragonPhasing::playerHuntAttackTargetsRange  /*0x040005AB*/
    IL_0079: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_007e: ldarg.0
    IL_007f: ldc.i4.1
    IL_0080: stfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_0085: ldarg.0
    IL_0086: ldc.i4.0
    IL_0087: stfld bool CrystalDragonPhasing::onCastleHunt  /*0x040005CE*/
    IL_008c: ret

  .method CrystalDragonPhasing::StartCastleHunt()  // token 0x06000481 rva 0x142bc attrs Private, HideBySig
    // code size 141 (0x8d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0006: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_000b: ldc.i4.1
    IL_000c: callvirt void System.Collections.Generic.List<TargetPriority>::RemoveAt(int)  /*0x0A00020A*/
    IL_0011: ldarg.0
    IL_0012: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_0017: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_001c: ldarg.0
    IL_001d: ldfld TargetPriority CrystalDragonPhasing::castleAngerTarget  /*0x040005A9*/
    IL_0022: callvirt void System.Collections.Generic.List<TargetPriority>::Add(!0)  /*0x0A000208*/
    IL_0027: ldarg.0
    IL_0028: ldfld PathfindMovementEnemy CrystalDragonPhasing::enemyPathfind  /*0x0400059E*/
    IL_002d: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0032: ldarg.0
    IL_0033: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0038: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_003d: callvirt void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0042: ldarg.0
    IL_0043: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_0048: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_004d: ldarg.0
    IL_004e: ldfld List<TargetPriority> CrystalDragonPhasing::castleHuntAttackTargetsMelee  /*0x040005AC*/
    IL_0053: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_0058: ldarg.0
    IL_0059: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_005e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0063: callvirt void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0068: ldarg.0
    IL_0069: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_006e: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0073: ldarg.0
    IL_0074: ldfld List<TargetPriority> CrystalDragonPhasing::castleHuntAttackTargetsRange  /*0x040005AD*/
    IL_0079: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_007e: ldarg.0
    IL_007f: ldc.i4.1
    IL_0080: stfld bool CrystalDragonPhasing::onCastleHunt  /*0x040005CE*/
    IL_0085: ldarg.0
    IL_0086: ldc.i4.0
    IL_0087: stfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_008c: ret

  .method CrystalDragonPhasing::SilenceAttacks()  // token 0x06000482 rva 0x14355 attrs Private, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack CrystalDragonPhasing::crystalStomp  /*0x040005BA*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ldarg.0
    IL_000d: ldfld AutoAttack CrystalDragonPhasing::bellySmash  /*0x040005BB*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0018: ldarg.0
    IL_0019: ldfld AutoAttackWithDelay CrystalDragonPhasing::flameSpitter  /*0x040005BC*/
    IL_001e: ldc.i4.0
    IL_001f: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0024: ldarg.0
    IL_0025: ldfld AutoAttack CrystalDragonPhasing::fireBall  /*0x040005BD*/
    IL_002a: ldc.i4.0
    IL_002b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0030: ldarg.0
    IL_0031: ldfld AutoAttackLavaGolemPuddle CrystalDragonPhasing::fireTrail  /*0x040005BE*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_003c: ret

  .method CrystalDragonPhasing::OnStartFly(UnityEngine.Vector3)  // token 0x06000483 rva 0x14393 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::FlyEvent  /*0x040005C8*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnCrystalStomp()  // token 0x06000484 rva 0x143a5 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::CrystalStompAttackTrigger  /*0x040005C1*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnBellySmashTriggered()  // token 0x06000485 rva 0x143b7 attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CrystalDragonPhasing::castleReached  /*0x040005D2*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld AutoAttack CrystalDragonPhasing::crystalStomp  /*0x040005BA*/
    IL_000f: ldc.i4.0
    IL_0010: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.1
    IL_0017: stfld bool CrystalDragonPhasing::castleReached  /*0x040005D2*/
    IL_001c: ldarg.0
    IL_001d: ldfld UnityEvent CrystalDragonPhasing::BellySmashAttackTrigger  /*0x040005C2*/
    IL_0022: dup
    IL_0023: brtrue.s IL_0027
    IL_0025: pop
    IL_0026: ret
    IL_0027: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_002c: ret

  .method CrystalDragonPhasing::OnBeforeFlameSpitterAttack()  // token 0x06000486 rva 0x143e5 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::FlameSpitterBeforeAttackTrigger  /*0x040005C3*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnFlameSpitterActualAttack()  // token 0x06000487 rva 0x143f7 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::FlameSpitterActualAttackTrigger  /*0x040005C4*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnFireBall()  // token 0x06000488 rva 0x14409 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::FireballAttackTrigger  /*0x040005C5*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnFireTrail()  // token 0x06000489 rva 0x1441b attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent CrystalDragonPhasing::FireTrailAttackTrigger  /*0x040005C6*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method CrystalDragonPhasing::OnPlayerKilled()  // token 0x0600048A rva 0x1442d attrs Private, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CrystalDragonPhasing::onPlayerHunt  /*0x040005CD*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void CrystalDragonPhasing::StartCastleHunt()  /*0x06000481*/
    IL_000e: ret

  .method CrystalDragonPhasing::.ctor()  // token 0x0600048B rva 0x14440 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 117 (0x75), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float CrystalDragonPhasing::playerCastleMaxDistance  /*0x040005A5*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 4f
    IL_0011: stfld float CrystalDragonPhasing::playerCheckDuration  /*0x040005A6*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_001c: stfld List<TargetPriority> CrystalDragonPhasing::playerHuntAttackTargetsMelee  /*0x040005AA*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0027: stfld List<TargetPriority> CrystalDragonPhasing::playerHuntAttackTargetsRange  /*0x040005AB*/
    IL_002c: ldarg.0
    IL_002d: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0032: stfld List<TargetPriority> CrystalDragonPhasing::castleHuntAttackTargetsMelee  /*0x040005AC*/
    IL_0037: ldarg.0
    IL_0038: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_003d: stfld List<TargetPriority> CrystalDragonPhasing::castleHuntAttackTargetsRange  /*0x040005AD*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 5f
    IL_0048: stfld float CrystalDragonPhasing::angerSpeed  /*0x040005AE*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 5f
    IL_0053: stfld float CrystalDragonPhasing::flyOffRegenDuration  /*0x040005B1*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 5f
    IL_005e: stfld float CrystalDragonPhasing::toAngerRegenDuration  /*0x040005B2*/
    IL_0063: ldarg.0
    IL_0064: ldc.r4 5f
    IL_0069: stfld float CrystalDragonPhasing::colldownMinionSpawn  /*0x040005BF*/
    IL_006e: ldarg.0
    IL_006f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0074: ret

// ===== CrystalDragonPhasing/CrystalDragonPhase  (token 0x020000D7) =====
