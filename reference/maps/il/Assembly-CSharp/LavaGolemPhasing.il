// ===== LavaGolemPhasing  (token 0x020000E2) =====
  .method LavaGolemPhasing::Start()  // token 0x060004C6 rva 0x14e64 attrs Private, HideBySig
    // code size 169 (0xa9), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call bool LavaGolemPhasing::Validate()  /*0x060004C8*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld GameObject LavaGolemPhasing::regenVFX  /*0x04000627*/
    IL_000f: ldc.i4.0
    IL_0010: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.0
    IL_0017: call void LavaGolemPhasing::PutToJumpState(bool)  /*0x060004CF*/
    IL_001c: ldarg.0
    IL_001d: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0022: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0027: ldarg.0
    IL_0028: ldftn void LavaGolemPhasing::OnKillOrKnockoutAction()  /*0x060004CA*/
    IL_002e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0033: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0038: ldarg.0
    IL_0039: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_003e: ldfld UnityEvent<Vector3> JumpBehaviour::StartJumpEvent  /*0x040005FE*/
    IL_0043: ldarg.0
    IL_0044: ldftn void LavaGolemPhasing::OnStartJump(UnityEngine.Vector3)  /*0x060004D4*/
    IL_004a: newobj void UnityEngine.Events.UnityAction<UnityEngine.Vector3>::.ctor(object,IntPtr)  /*0x0A000089*/
    IL_004f: callvirt void UnityEngine.Events.UnityEvent<UnityEngine.Vector3>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A00008A*/
    IL_0054: ldarg.0
    IL_0055: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_005a: ldfld UnityEvent JumpBehaviour::EndJumpEvent  /*0x040005FF*/
    IL_005f: ldarg.0
    IL_0060: ldftn void LavaGolemPhasing::OnEndJump()  /*0x060004C9*/
    IL_0066: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_006b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0070: ldarg.0
    IL_0071: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_0076: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_007b: ldarg.0
    IL_007c: ldftn void LavaGolemPhasing::OnComboAttack()  /*0x060004D2*/
    IL_0082: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0087: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_008c: ldarg.0
    IL_008d: ldfld AutoAttackLavaGolemPuddle LavaGolemPhasing::puddleAttack  /*0x0400062F*/
    IL_0092: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0097: ldarg.0
    IL_0098: ldftn void LavaGolemPhasing::OnPuddleAttack()  /*0x060004D3*/
    IL_009e: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_00a3: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_00a8: ret

  .method LavaGolemPhasing::Update()  // token 0x060004C7 rva 0x14f19 attrs Private, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0006: ldc.i4.5
    IL_0007: bne.un.s IL_000f
    IL_0009: ldarg.0
    IL_000a: call void LavaGolemPhasing::UpdateRegen()  /*0x060004D1*/
    IL_000f: ret

  .method LavaGolemPhasing::Validate()  // token 0x060004C8 rva 0x14f2c attrs Private, HideBySig
    // code size 134 (0x86), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0015: stfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_001a: ldarg.0
    IL_001b: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0020: ldnull
    IL_0021: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0026: brfalse.s IL_0034
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call !!0 UnityEngine.Component::GetComponent()<JumpBehaviour>  /*0x2B00003A*/
    IL_002f: stfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0034: ldarg.0
    IL_0035: ldfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_003a: ldnull
    IL_003b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0040: brfalse.s IL_004e
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: call !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0049: stfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_004e: ldarg.0
    IL_004f: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0054: ldnull
    IL_0055: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_005a: brtrue.s IL_0078
    IL_005c: ldarg.0
    IL_005d: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0062: ldnull
    IL_0063: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0068: brtrue.s IL_0078
    IL_006a: ldarg.0
    IL_006b: ldfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0076: brfalse.s IL_0084
    IL_0078: ldstr "There are empty References for LavaGolemPhasing"
    IL_007d: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0082: ldc.i4.0
    IL_0083: ret
    IL_0084: ldc.i4.1
    IL_0085: ret

  .method LavaGolemPhasing::OnEndJump()  // token 0x060004C9 rva 0x14fc0 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool LavaGolemPhasing::needRegen  /*0x04000638*/
    IL_0006: brtrue.s IL_0029
    IL_0008: ldarg.0
    IL_0009: ldfld ParticleSystem LavaGolemPhasing::endJumpToPhaseVFX  /*0x04000625*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0022
    IL_0016: ldarg.0
    IL_0017: ldfld ParticleSystem LavaGolemPhasing::endJumpToPhaseVFX  /*0x04000625*/
    IL_001c: ldc.i4.1
    IL_001d: callvirt void UnityEngine.ParticleSystem::Play(bool)  /*0x0A000206*/
    IL_0022: ldarg.0
    IL_0023: call void LavaGolemPhasing::PutToSomePhase()  /*0x060004CB*/
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: ldfld ParticleSystem LavaGolemPhasing::endJumpToRegenVFX  /*0x04000624*/
    IL_002f: ldnull
    IL_0030: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0035: brfalse.s IL_0043
    IL_0037: ldarg.0
    IL_0038: ldfld ParticleSystem LavaGolemPhasing::endJumpToRegenVFX  /*0x04000624*/
    IL_003d: ldc.i4.1
    IL_003e: callvirt void UnityEngine.ParticleSystem::Play(bool)  /*0x0A000206*/
    IL_0043: ldarg.0
    IL_0044: call void LavaGolemPhasing::PutToRegen()  /*0x060004D0*/
    IL_0049: ret

  .method LavaGolemPhasing::OnKillOrKnockoutAction()  // token 0x060004CA rva 0x15016 attrs Private, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0006: ldc.i4.4
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_0010: ldarg.0
    IL_0011: ldfld Collider LavaGolemPhasing::knockoutBigCollider  /*0x04000622*/
    IL_0016: stfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_001b: ldarg.0
    IL_001c: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0021: ldc.i4.1
    IL_0022: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: call void LavaGolemPhasing::PutToJumpState(bool)  /*0x060004CF*/
    IL_002e: ret

  .method LavaGolemPhasing::PutToSomePhase()  // token 0x060004CB rva 0x15048 attrs Private, HideBySig
    // code size 109 (0x6d), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_0006: ldarg.0
    IL_0007: ldfld Collider LavaGolemPhasing::aliveBigCollider  /*0x04000621*/
    IL_000c: stfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0011: ldarg.0
    IL_0012: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0017: ldc.i4.0
    IL_0018: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_001d: ldarg.0
    IL_001e: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0023: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0028: ldc.i4.1
    IL_0029: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_002e: ldarg.0
    IL_002f: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0034: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0039: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_003e: ldarg.0
    IL_003f: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_0044: stloc.0
    IL_0045: ldloc.0
    IL_0046: switch (IL_0058, IL_005f, IL_0066)
    IL_0057: ret
    IL_0058: ldarg.0
    IL_0059: call void LavaGolemPhasing::PutToPhase1()  /*0x060004CC*/
    IL_005e: ret
    IL_005f: ldarg.0
    IL_0060: call void LavaGolemPhasing::PutToPhase2()  /*0x060004CD*/
    IL_0065: ret
    IL_0066: ldarg.0
    IL_0067: call void LavaGolemPhasing::PutToPhase3()  /*0x060004CE*/
    IL_006c: ret

  .method LavaGolemPhasing::PutToPhase1()  // token 0x060004CC rva 0x150c4 attrs Private, HideBySig
    // code size 71 (0x47), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0007: ldarg.0
    IL_0008: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_000d: ldarg.0
    IL_000e: ldfld Weapon LavaGolemPhasing::swingWeapon  /*0x04000630*/
    IL_0013: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0018: ldarg.0
    IL_0019: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_001e: ldarg.0
    IL_001f: ldfld Transform LavaGolemPhasing::swingOriginal  /*0x04000632*/
    IL_0024: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0029: ldarg.0
    IL_002a: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_002f: ldc.i4.1
    IL_0030: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0035: ldarg.0
    IL_0036: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_003b: ldarg.0
    IL_003c: ldfld GameObject LavaGolemPhasing::knockoutAfter1FX  /*0x0400062B*/
    IL_0041: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0046: ret

  .method LavaGolemPhasing::PutToPhase2()  // token 0x060004CD rva 0x15118 attrs Private, HideBySig
    // code size 83 (0x53), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0007: ldarg.0
    IL_0008: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_000d: ldarg.0
    IL_000e: ldfld Weapon LavaGolemPhasing::swingWeapon  /*0x04000630*/
    IL_0013: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0018: ldarg.0
    IL_0019: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_001e: ldarg.0
    IL_001f: ldfld Transform LavaGolemPhasing::swingOriginal  /*0x04000632*/
    IL_0024: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0029: ldarg.0
    IL_002a: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_002f: ldc.i4.1
    IL_0030: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0035: ldarg.0
    IL_0036: ldfld AutoAttackLavaGolemPuddle LavaGolemPhasing::puddleAttack  /*0x0400062F*/
    IL_003b: ldc.i4.1
    IL_003c: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0041: ldarg.0
    IL_0042: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0047: ldarg.0
    IL_0048: ldfld GameObject LavaGolemPhasing::knockoutAfter2FX  /*0x0400062C*/
    IL_004d: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0052: ret

  .method LavaGolemPhasing::PutToPhase3()  // token 0x060004CE rva 0x15177 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.4
    IL_0002: stfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0007: ldarg.0
    IL_0008: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_000d: ldc.i4.0
    IL_000e: stfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_0013: ldarg.0
    IL_0014: ldfld TaggedObject LavaGolemPhasing::taggedObject  /*0x0400061F*/
    IL_0019: ldc.i4.s 10
    IL_001b: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0020: ldarg.0
    IL_0021: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_0026: ldarg.0
    IL_0027: ldfld GameObject LavaGolemPhasing::deathFX  /*0x0400062D*/
    IL_002c: stfld GameObject Hp::fxToSpawnOnDeath  /*0x04000A35*/
    IL_0031: ret

  .method LavaGolemPhasing::PutToJumpState(bool)  // token 0x060004CF rva 0x151ac attrs Private, HideBySig
    // code size 149 (0x95), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0007: ldarg.0
    IL_0008: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_000d: ldc.i4.0
    IL_000e: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0013: ldarg.0
    IL_0014: ldfld AutoAttackLavaGolemPuddle LavaGolemPhasing::puddleAttack  /*0x0400062F*/
    IL_0019: ldc.i4.0
    IL_001a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_001f: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0024: stloc.0
    IL_0025: ldarg.1
    IL_0026: brfalse.s IL_0049
    IL_0028: ldarg.0
    IL_0029: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_002e: brfalse.s IL_003c
    IL_0030: call Transform MapPointsCacher::get_LavaGolemPhase2EndPoint()  /*0x060004E9*/
    IL_0035: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003a: br.s IL_0046
    IL_003c: call Transform MapPointsCacher::get_LavaGolemPhase1EndPoint()  /*0x060004E7*/
    IL_0041: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0046: stloc.0
    IL_0047: br.s IL_007d
    IL_0049: ldarg.0
    IL_004a: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_004f: brfalse.s IL_0072
    IL_0051: ldarg.0
    IL_0052: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_0057: ldc.i4.1
    IL_0058: beq.s IL_0066
    IL_005a: call Transform MapPointsCacher::get_LavaGolemToPhase3JumpPoint()  /*0x060004E5*/
    IL_005f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0064: br.s IL_007c
    IL_0066: call Transform MapPointsCacher::get_LavaGolemToPhase2JumpPoint()  /*0x060004E3*/
    IL_006b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0070: br.s IL_007c
    IL_0072: call Transform MapPointsCacher::get_LavaGolemToPhase1JumpPoint()  /*0x060004E1*/
    IL_0077: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007c: stloc.0
    IL_007d: ldarg.0
    IL_007e: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_0083: ldloc.0
    IL_0084: ldarg.1
    IL_0085: ldc.i4.0
    IL_0086: ceq
    IL_0088: callvirt void JumpBehaviour::RequestJump(UnityEngine.Vector3,bool)  /*0x060004A9*/
    IL_008d: ldarg.0
    IL_008e: ldarg.1
    IL_008f: stfld bool LavaGolemPhasing::needRegen  /*0x04000638*/
    IL_0094: ret

  .method LavaGolemPhasing::PutToRegen()  // token 0x060004D0 rva 0x15250 attrs Private, HideBySig
    // code size 123 (0x7b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject LavaGolemPhasing::regenVFX  /*0x04000627*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_0013: ldc.i4.1
    IL_0014: add
    IL_0015: stfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_001a: ldarg.0
    IL_001b: ldfld UnityEvent<int> LavaGolemPhasing::OnChangePhaseEvent  /*0x04000637*/
    IL_0020: dup
    IL_0021: brtrue.s IL_0026
    IL_0023: pop
    IL_0024: br.s IL_0031
    IL_0026: ldarg.0
    IL_0027: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_002c: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_0031: ldarg.0
    IL_0032: ldc.i4.5
    IL_0033: stfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0038: ldarg.0
    IL_0039: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_003e: ldc.i4.1
    IL_003f: bne.un.s IL_0059
    IL_0041: ldarg.0
    IL_0042: ldfld GameObject LavaGolemPhasing::AliveVisualsPhase1  /*0x04000628*/
    IL_0047: ldc.i4.0
    IL_0048: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004d: ldarg.0
    IL_004e: ldfld GameObject LavaGolemPhasing::AliveVisualsPhase2  /*0x04000629*/
    IL_0053: ldc.i4.1
    IL_0054: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0059: ldarg.0
    IL_005a: ldfld int LavaGolemPhasing::regenedTimes  /*0x04000639*/
    IL_005f: ldc.i4.2
    IL_0060: bne.un.s IL_007a
    IL_0062: ldarg.0
    IL_0063: ldfld GameObject LavaGolemPhasing::AliveVisualsPhase2  /*0x04000629*/
    IL_0068: ldc.i4.0
    IL_0069: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006e: ldarg.0
    IL_006f: ldfld GameObject LavaGolemPhasing::AliveVisualsPhase3  /*0x0400062A*/
    IL_0074: ldc.i4.1
    IL_0075: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007a: ret

  .method LavaGolemPhasing::UpdateRegen()  // token 0x060004D1 rva 0x152d8 attrs Private, HideBySig
    // code size 121 (0x79), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float LavaGolemPhasing::regenTimer  /*0x0400063A*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float LavaGolemPhasing::regenTimer  /*0x0400063A*/
    IL_0012: ldarg.0
    IL_0013: ldfld float LavaGolemPhasing::regenTimer  /*0x0400063A*/
    IL_0018: ldarg.0
    IL_0019: ldfld float LavaGolemPhasing::regenDuration  /*0x04000626*/
    IL_001e: bge.un.s IL_0021
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldc.i4.0
    IL_0023: call void LavaGolemPhasing::PutToJumpState(bool)  /*0x060004CF*/
    IL_0028: ldarg.0
    IL_0029: ldfld Hp LavaGolemPhasing::hp  /*0x0400061E*/
    IL_002e: ldc.i4.1
    IL_002f: ldc.r4 1f
    IL_0034: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_0039: ldarg.0
    IL_003a: ldc.i4.0
    IL_003b: stfld bool LavaGolemPhasing::needRegen  /*0x04000638*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0f
    IL_0046: stfld float LavaGolemPhasing::regenTimer  /*0x0400063A*/
    IL_004b: ldarg.0
    IL_004c: ldfld GameObject LavaGolemPhasing::regenVFX  /*0x04000627*/
    IL_0051: ldc.i4.0
    IL_0052: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0057: ldarg.0
    IL_0058: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_005d: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0062: ldc.i4.1
    IL_0063: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0068: ldarg.0
    IL_0069: ldfld JumpBehaviour LavaGolemPhasing::jumpBehaviour  /*0x04000620*/
    IL_006e: ldfld PathfindMovementEnemy JumpBehaviour::unitMovement  /*0x040005F9*/
    IL_0073: callvirt void PathfindMovementEnemy::OriginalPathRequest()  /*0x06000B18*/
    IL_0078: ret

  .method LavaGolemPhasing::OnComboAttack()  // token 0x060004D2 rva 0x15360 attrs Private, HideBySig
    // code size 198 (0xc6), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld LavaGolemPhasing.LavaGolemPhase LavaGolemPhasing::currentPhase  /*0x0400063C*/
    IL_0006: ldc.i4.4
    IL_0007: beq.s IL_001b
    IL_0009: ldarg.0
    IL_000a: ldfld UnityEvent<int> LavaGolemPhasing::ComboAttackTriggerEvent  /*0x04000634*/
    IL_000f: dup
    IL_0010: brtrue.s IL_0014
    IL_0012: pop
    IL_0013: ret
    IL_0014: ldc.i4.1
    IL_0015: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_0022: ldc.i4.1
    IL_0023: add
    IL_0024: stfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_0029: ldarg.0
    IL_002a: ldfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_002f: ldc.i4.1
    IL_0030: bne.un.s IL_0044
    IL_0032: ldarg.0
    IL_0033: ldfld UnityEvent<int> LavaGolemPhasing::ComboAttackTriggerEvent  /*0x04000634*/
    IL_0038: dup
    IL_0039: brtrue.s IL_003e
    IL_003b: pop
    IL_003c: br.s IL_0044
    IL_003e: ldc.i4.1
    IL_003f: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_0044: ldarg.0
    IL_0045: ldfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_004a: ldc.i4.2
    IL_004b: bne.un.s IL_0081
    IL_004d: ldarg.0
    IL_004e: ldfld UnityEvent<int> LavaGolemPhasing::ComboAttackTriggerEvent  /*0x04000634*/
    IL_0053: dup
    IL_0054: brtrue.s IL_0059
    IL_0056: pop
    IL_0057: br.s IL_005f
    IL_0059: ldc.i4.1
    IL_005a: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_005f: ldarg.0
    IL_0060: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_0065: ldarg.0
    IL_0066: ldfld Weapon LavaGolemPhasing::vomitWeapon  /*0x04000631*/
    IL_006b: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0070: ldarg.0
    IL_0071: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_0076: ldarg.0
    IL_0077: ldfld Transform LavaGolemPhasing::vomitOriginal  /*0x04000633*/
    IL_007c: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0081: ldarg.0
    IL_0082: ldfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_0087: ldc.i4.3
    IL_0088: bne.un.s IL_00c5
    IL_008a: ldarg.0
    IL_008b: ldfld UnityEvent<int> LavaGolemPhasing::ComboAttackTriggerEvent  /*0x04000634*/
    IL_0090: dup
    IL_0091: brtrue.s IL_0096
    IL_0093: pop
    IL_0094: br.s IL_009c
    IL_0096: ldc.i4.2
    IL_0097: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_009c: ldarg.0
    IL_009d: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_00a2: ldarg.0
    IL_00a3: ldfld Weapon LavaGolemPhasing::swingWeapon  /*0x04000630*/
    IL_00a8: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld AutoAttack LavaGolemPhasing::swingVomitComboAttack  /*0x0400062E*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld Transform LavaGolemPhasing::swingOriginal  /*0x04000632*/
    IL_00b9: stfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_00be: ldarg.0
    IL_00bf: ldc.i4.0
    IL_00c0: stfld int LavaGolemPhasing::comboAction  /*0x0400063B*/
    IL_00c5: ret

  .method LavaGolemPhasing::OnPuddleAttack()  // token 0x060004D3 rva 0x15432 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent LavaGolemPhasing::PuddleAttackTriggerEvent  /*0x04000635*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method LavaGolemPhasing::OnStartJump(UnityEngine.Vector3)  // token 0x060004D4 rva 0x15444 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityEvent LavaGolemPhasing::LavaGolemJumpEvent  /*0x04000636*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000b
    IL_0009: pop
    IL_000a: ret
    IL_000b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0010: ret

  .method LavaGolemPhasing::CutsceneCoroutine()  // token 0x060004D5 rva 0x15456 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LavaGolemPhasing.<CutsceneCoroutine>d__47::.ctor(int)  /*0x060004D7*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LavaGolemPhasing LavaGolemPhasing.<CutsceneCoroutine>d__47::<>4__this  /*0x04000646*/
    IL_000d: ret

  .method LavaGolemPhasing::.ctor()  // token 0x060004D6 rva 0x15465 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float LavaGolemPhasing::regenDuration  /*0x04000626*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== LavaGolemPhasing/LavaGolemPhase  (token 0x020000E3) =====
// ===== LavaGolemPhasing/<CutsceneCoroutine>d__47  (token 0x020000E4) =====
  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::.ctor(int)  // token 0x060004D7 rva 0x15478 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LavaGolemPhasing.<CutsceneCoroutine>d__47::<>1__state  /*0x04000644*/
    IL_000d: ret

  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::System.IDisposable.Dispose()  // token 0x060004D8 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::MoveNext()  // token 0x060004D9 rva 0x15488 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 72 (0x48), max stack 2, init locals
    .locals ([0] int, [1] LavaGolemPhasing)
    IL_0000: ldarg.0
    IL_0001: ldfld int LavaGolemPhasing.<CutsceneCoroutine>d__47::<>1__state  /*0x04000644*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LavaGolemPhasing LavaGolemPhasing.<CutsceneCoroutine>d__47::<>4__this  /*0x04000646*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int LavaGolemPhasing.<CutsceneCoroutine>d__47::<>1__state  /*0x04000644*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float LavaGolemPhasing::cutsceneDuration  /*0x04000623*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object LavaGolemPhasing.<CutsceneCoroutine>d__47::<>2__current  /*0x04000645*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int LavaGolemPhasing.<CutsceneCoroutine>d__47::<>1__state  /*0x04000644*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int LavaGolemPhasing.<CutsceneCoroutine>d__47::<>1__state  /*0x04000644*/
    IL_003f: ldloc.1
    IL_0040: ldc.i4.0
    IL_0041: call void LavaGolemPhasing::PutToJumpState(bool)  /*0x060004CF*/
    IL_0046: ldc.i4.0
    IL_0047: ret

  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060004DA rva 0x154dc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LavaGolemPhasing.<CutsceneCoroutine>d__47::<>2__current  /*0x04000645*/
    IL_0006: ret

  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::System.Collections.IEnumerator.Reset()  // token 0x060004DB rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LavaGolemPhasing.<CutsceneCoroutine>d__47::System.Collections.IEnumerator.get_Current()  // token 0x060004DC rva 0x154dc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LavaGolemPhasing.<CutsceneCoroutine>d__47::<>2__current  /*0x04000645*/
    IL_0006: ret

