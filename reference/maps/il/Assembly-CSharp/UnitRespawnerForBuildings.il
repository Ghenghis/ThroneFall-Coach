// ===== UnitRespawnerForBuildings  (token 0x02000391) =====
  .method UnitRespawnerForBuildings::get_ResetCooldownTime()  // token 0x0600139F rva 0x5cf7e attrs Private, HideBySig, SpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<float> UnitRespawnerForBuildings::timeToRespawnAUnitDependingOnLevel  /*0x040017D6*/
    IL_0006: ldarg.0
    IL_0007: ldfld BuildSlot UnitRespawnerForBuildings::myBuildSlot  /*0x040017D8*/
    IL_000c: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0011: ldc.i4.0
    IL_0012: ldarg.0
    IL_0013: ldfld List<float> UnitRespawnerForBuildings::timeToRespawnAUnitDependingOnLevel  /*0x040017D6*/
    IL_0018: callvirt int System.Collections.Generic.List<float>::get_Count()  /*0x0A000494*/
    IL_001d: ldc.i4.1
    IL_001e: sub
    IL_001f: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0024: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_0029: ret

  .method UnitRespawnerForBuildings::Start()  // token 0x060013A0 rva 0x5cfac attrs Private, HideBySig
    // code size 260 (0x104), max stack 3, init locals
    .locals ([0] PerkManager, [1] int)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: stloc.0
    IL_0006: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_000b: ldarg.0
    IL_000c: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0011: ldarg.0
    IL_0012: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0017: stfld BlacksmithUpgrades UnitRespawnerForBuildings::blacksmithUpgrades  /*0x040017DB*/
    IL_001c: ldarg.0
    IL_001d: ldloc.0
    IL_001e: callvirt bool PerkManager::get_GodOfDeathActive()  /*0x06000989*/
    IL_0023: stfld bool UnitRespawnerForBuildings::godOfDeathActive  /*0x040017E4*/
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call float UnitRespawnerForBuildings::get_ResetCooldownTime()  /*0x0600139F*/
    IL_002f: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_0034: ldarg.0
    IL_0035: ldfld ProductionBar UnitRespawnerForBuildings::productionBar  /*0x040017DA*/
    IL_003a: ldc.r4 0f
    IL_003f: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld Equippable UnitRespawnerForBuildings::gladiatorSchoolPerk  /*0x040017E2*/
    IL_004b: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0050: stfld bool UnitRespawnerForBuildings::gladiatorSchool  /*0x040017DD*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldfld Equippable UnitRespawnerForBuildings::elliteWarriorsPerk  /*0x040017E3*/
    IL_005c: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0061: stfld bool UnitRespawnerForBuildings::elliteWarriors  /*0x040017DE*/
    IL_0066: ldarg.0
    IL_0067: ldloc.0
    IL_0068: ldfld float PerkManager::gladiatorSchool_TrainingSpeedMultiplyer  /*0x04000BF8*/
    IL_006d: stfld float UnitRespawnerForBuildings::gladiatorSchoolSpeed  /*0x040017DF*/
    IL_0072: ldarg.0
    IL_0073: ldloc.0
    IL_0074: ldfld float PerkManager::elliteWarriors_TrainingSpeedMultiplyer  /*0x04000BF9*/
    IL_0079: stfld float UnitRespawnerForBuildings::elliteWarriorSpeed  /*0x040017E0*/
    IL_007e: ldarg.0
    IL_007f: ldc.r4 1f
    IL_0084: ldarg.0
    IL_0085: ldfld bool UnitRespawnerForBuildings::gladiatorSchool  /*0x040017DD*/
    IL_008a: brtrue.s IL_0093
    IL_008c: ldc.r4 1f
    IL_0091: br.s IL_0099
    IL_0093: ldarg.0
    IL_0094: ldfld float UnitRespawnerForBuildings::gladiatorSchoolSpeed  /*0x040017DF*/
    IL_0099: mul
    IL_009a: ldarg.0
    IL_009b: ldfld bool UnitRespawnerForBuildings::elliteWarriors  /*0x040017DE*/
    IL_00a0: brtrue.s IL_00a9
    IL_00a2: ldc.r4 1f
    IL_00a7: br.s IL_00af
    IL_00a9: ldarg.0
    IL_00aa: ldfld float UnitRespawnerForBuildings::elliteWarriorSpeed  /*0x040017E0*/
    IL_00af: mul
    IL_00b0: stfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_00b5: ldarg.0
    IL_00b6: ldloc.0
    IL_00b7: callvirt bool PerkManager::get_ExperienceGainEquipped()  /*0x0600099B*/
    IL_00bc: stfld bool UnitRespawnerForBuildings::experienceGainActive  /*0x040017E6*/
    IL_00c1: ldarg.0
    IL_00c2: ldloc.0
    IL_00c3: ldfld float PerkManager::experienceGainPercentage  /*0x04000C4D*/
    IL_00c8: stfld float UnitRespawnerForBuildings::experienceGainMulti  /*0x040017E7*/
    IL_00cd: ldarg.0
    IL_00ce: ldarg.0
    IL_00cf: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_00d4: callvirt int System.Collections.Generic.List<Hp>::get_Count()  /*0x0A000779*/
    IL_00d9: newarr System.Single  /*0x01000052*/
    IL_00de: stfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_00e3: ldc.i4.0
    IL_00e4: stloc.1
    IL_00e5: br.s IL_00f8
    IL_00e7: ldarg.0
    IL_00e8: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_00ed: ldloc.1
    IL_00ee: ldc.r4 1f
    IL_00f3: stelem.r4
    IL_00f4: ldloc.1
    IL_00f5: ldc.i4.1
    IL_00f6: add
    IL_00f7: stloc.1
    IL_00f8: ldloc.1
    IL_00f9: ldarg.0
    IL_00fa: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_00ff: ldlen
    IL_0100: conv.i4
    IL_0101: blt.s IL_00e7
    IL_0103: ret

  .method UnitRespawnerForBuildings::Update()  // token 0x060013A1 rva 0x5d0bc attrs Private, HideBySig
    // code size 237 (0xed), max stack 4, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitRespawnerForBuildings::godOfDeathActive  /*0x040017E4*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld Hp UnitRespawnerForBuildings::hp  /*0x040017D4*/
    IL_000f: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0014: brfalse.s IL_0027
    IL_0016: ldarg.0
    IL_0017: ldfld ProductionBar UnitRespawnerForBuildings::productionBar  /*0x040017DA*/
    IL_001c: ldc.r4 0f
    IL_0021: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0026: ret
    IL_0027: ldarg.0
    IL_0028: call bool UnitRespawnerForBuildings::AtLeastOneUnitIsKnockedOut()  /*0x060013A2*/
    IL_002d: stloc.0
    IL_002e: ldloc.0
    IL_002f: brtrue.s IL_003c
    IL_0031: ldarg.0
    IL_0032: ldfld bool UnitRespawnerForBuildings::gladiatorSchool  /*0x040017DD*/
    IL_0037: brfalse IL_00bd
    IL_003c: ldarg.0
    IL_003d: ldfld bool UnitRespawnerForBuildings::night  /*0x040017E5*/
    IL_0042: brfalse.s IL_00bd
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_004b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0050: ldarg.0
    IL_0051: ldfld BlacksmithUpgrades UnitRespawnerForBuildings::blacksmithUpgrades  /*0x040017DB*/
    IL_0056: ldfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_005b: mul
    IL_005c: sub
    IL_005d: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_0062: ldarg.0
    IL_0063: ldfld ProductionBar UnitRespawnerForBuildings::productionBar  /*0x040017DA*/
    IL_0068: ldc.r4 1f
    IL_006d: ldarg.0
    IL_006e: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_0073: ldarg.0
    IL_0074: call float UnitRespawnerForBuildings::get_ResetCooldownTime()  /*0x0600139F*/
    IL_0079: div
    IL_007a: ldarg.0
    IL_007b: ldfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_0080: mul
    IL_0081: sub
    IL_0082: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0087: ldloc.0
    IL_0088: brfalse.s IL_00ec
    IL_008a: ldarg.0
    IL_008b: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_0090: ldc.r4 0f
    IL_0095: bgt.un.s IL_00ec
    IL_0097: ldarg.0
    IL_0098: ldarg.0
    IL_0099: call float UnitRespawnerForBuildings::get_ResetCooldownTime()  /*0x0600139F*/
    IL_009e: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00a3: ldarg.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_00b0: div
    IL_00b1: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00b6: ldarg.0
    IL_00b7: call void UnitRespawnerForBuildings::RespawnAKnockedOutUnit()  /*0x060013A3*/
    IL_00bc: ret
    IL_00bd: ldarg.0
    IL_00be: ldarg.0
    IL_00bf: call float UnitRespawnerForBuildings::get_ResetCooldownTime()  /*0x0600139F*/
    IL_00c4: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00c9: ldarg.0
    IL_00ca: ldarg.0
    IL_00cb: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00d0: ldarg.0
    IL_00d1: ldfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_00d6: div
    IL_00d7: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld ProductionBar UnitRespawnerForBuildings::productionBar  /*0x040017DA*/
    IL_00e2: ldc.r4 0f
    IL_00e7: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_00ec: ret

  .method UnitRespawnerForBuildings::AtLeastOneUnitIsKnockedOut()  // token 0x060013A2 rva 0x5d1b8 attrs Private, HideBySig
    // code size 60 (0x3c), max stack 2, init locals
    .locals ([0] int, [1] Hp)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_002c
    IL_0004: ldarg.0
    IL_0005: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_000a: ldloc.0
    IL_000b: callvirt !0 System.Collections.Generic.List<Hp>::get_Item(int)  /*0x0A00077A*/
    IL_0010: stloc.1
    IL_0011: ldloc.1
    IL_0012: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0017: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_001c: brfalse.s IL_0028
    IL_001e: ldloc.1
    IL_001f: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0024: brfalse.s IL_0028
    IL_0026: ldc.i4.1
    IL_0027: ret
    IL_0028: ldloc.0
    IL_0029: ldc.i4.1
    IL_002a: add
    IL_002b: stloc.0
    IL_002c: ldloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_0033: callvirt int System.Collections.Generic.List<Hp>::get_Count()  /*0x0A000779*/
    IL_0038: blt.s IL_0004
    IL_003a: ldc.i4.0
    IL_003b: ret

  .method UnitRespawnerForBuildings::RespawnAKnockedOutUnit()  // token 0x060013A3 rva 0x5d200 attrs Private, HideBySig
    // code size 280 (0x118), max stack 4, init locals
    .locals ([0] int, [1] Hp, [2] PathfindMovementPlayerunit, [3] Vector3, [4] float, [5] AutoAttack[], [6] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br IL_0106
    IL_0007: ldarg.0
    IL_0008: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_000d: ldloc.0
    IL_000e: callvirt !0 System.Collections.Generic.List<Hp>::get_Item(int)  /*0x0A00077A*/
    IL_0013: stloc.1
    IL_0014: ldloc.1
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_001f: brfalse IL_0102
    IL_0024: ldloc.1
    IL_0025: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_002a: brfalse IL_0102
    IL_002f: ldloc.1
    IL_0030: ldc.i4.1
    IL_0031: ldc.r4 1f
    IL_0036: callvirt void Hp::Revive(bool,float)  /*0x0600082A*/
    IL_003b: ldloc.1
    IL_003c: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementPlayerunit>  /*0x2B00008A*/
    IL_0041: stloc.2
    IL_0042: ldarg.0
    IL_0043: ldfld TaggedObject UnitRespawnerForBuildings::taggedObject  /*0x040017D9*/
    IL_0048: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_004d: ldloc.2
    IL_004e: callvirt Vector3 PathfindMovementPlayerunit::get_HomePositionOriginal()  /*0x06000B29*/
    IL_0053: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_0058: stloc.3
    IL_0059: ldloc.1
    IL_005a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005f: ldloc.3
    IL_0060: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0065: ldloc.2
    IL_0066: callvirt void PathfindMovementPlayerunit::SnapToNavmesh()  /*0x06000B46*/
    IL_006b: ldarg.0
    IL_006c: ldfld bool UnitRespawnerForBuildings::experienceGainActive  /*0x040017E6*/
    IL_0071: brfalse IL_0101
    IL_0076: ldarg.0
    IL_0077: ldarg.0
    IL_0078: ldfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_007d: ldarg.0
    IL_007e: ldfld float UnitRespawnerForBuildings::experienceGainMulti  /*0x040017E7*/
    IL_0083: mul
    IL_0084: stfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_0089: ldarg.0
    IL_008a: ldarg.0
    IL_008b: ldfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_0090: ldc.r4 1f
    IL_0095: ldc.r4 3f
    IL_009a: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_009f: stfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_00b0: ldloc.0
    IL_00b1: ldelem.r4
    IL_00b2: div
    IL_00b3: stloc.s 4
    IL_00b5: ldloc.1
    IL_00b6: ldloc.s 4
    IL_00b8: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_00bd: ldloc.1
    IL_00be: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_00c3: brfalse.s IL_00f3
    IL_00c5: ldloc.1
    IL_00c6: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_00cb: stloc.s 5
    IL_00cd: ldc.i4.0
    IL_00ce: stloc.s 6
    IL_00d0: br.s IL_00eb
    IL_00d2: ldloc.s 5
    IL_00d4: ldloc.s 6
    IL_00d6: ldelem.ref
    IL_00d7: dup
    IL_00d8: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_00dd: ldloc.s 4
    IL_00df: mul
    IL_00e0: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_00e5: ldloc.s 6
    IL_00e7: ldc.i4.1
    IL_00e8: add
    IL_00e9: stloc.s 6
    IL_00eb: ldloc.s 6
    IL_00ed: ldloc.s 5
    IL_00ef: ldlen
    IL_00f0: conv.i4
    IL_00f1: blt.s IL_00d2
    IL_00f3: ldarg.0
    IL_00f4: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_00f9: ldloc.0
    IL_00fa: ldarg.0
    IL_00fb: ldfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_0100: stelem.r4
    IL_0101: ret
    IL_0102: ldloc.0
    IL_0103: ldc.i4.1
    IL_0104: add
    IL_0105: stloc.0
    IL_0106: ldloc.0
    IL_0107: ldarg.0
    IL_0108: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_010d: callvirt int System.Collections.Generic.List<Hp>::get_Count()  /*0x0A000779*/
    IL_0112: blt IL_0007
    IL_0117: ret

  .method UnitRespawnerForBuildings::DayNightCycle.IDaytimeSensitive.OnDuskEarly()  // token 0x060013A4 rva 0x5d324 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 181 (0xb5), max stack 3, init locals
    .locals ([0] int, [1] Hp, [2] float, [3] AutoAttack[], [4] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call float UnitRespawnerForBuildings::get_ResetCooldownTime()  /*0x0600139F*/
    IL_0007: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_0013: ldarg.0
    IL_0014: ldfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_0019: div
    IL_001a: stfld float UnitRespawnerForBuildings::timeTillNextRespawn  /*0x040017D7*/
    IL_001f: ldarg.0
    IL_0020: ldc.i4.1
    IL_0021: stfld bool UnitRespawnerForBuildings::night  /*0x040017E5*/
    IL_0026: ldarg.0
    IL_0027: ldfld bool UnitRespawnerForBuildings::experienceGainActive  /*0x040017E6*/
    IL_002c: brfalse IL_00b4
    IL_0031: ldc.i4.0
    IL_0032: stloc.0
    IL_0033: br.s IL_009b
    IL_0035: ldarg.0
    IL_0036: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_003b: ldloc.0
    IL_003c: callvirt !0 System.Collections.Generic.List<Hp>::get_Item(int)  /*0x0A00077A*/
    IL_0041: stloc.1
    IL_0042: ldc.r4 1f
    IL_0047: ldarg.0
    IL_0048: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_004d: ldloc.0
    IL_004e: ldelem.r4
    IL_004f: div
    IL_0050: stloc.2
    IL_0051: ldloc.1
    IL_0052: ldloc.2
    IL_0053: callvirt void Hp::ScaleHp(float)  /*0x06000824*/
    IL_0058: ldloc.1
    IL_0059: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_005e: brfalse.s IL_008a
    IL_0060: ldloc.1
    IL_0061: callvirt AutoAttack[] Hp::get_AutoAttacks()  /*0x06000817*/
    IL_0066: stloc.3
    IL_0067: ldc.i4.0
    IL_0068: stloc.s 4
    IL_006a: br.s IL_0083
    IL_006c: ldloc.3
    IL_006d: ldloc.s 4
    IL_006f: ldelem.ref
    IL_0070: dup
    IL_0071: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_0076: ldloc.2
    IL_0077: mul
    IL_0078: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_007d: ldloc.s 4
    IL_007f: ldc.i4.1
    IL_0080: add
    IL_0081: stloc.s 4
    IL_0083: ldloc.s 4
    IL_0085: ldloc.3
    IL_0086: ldlen
    IL_0087: conv.i4
    IL_0088: blt.s IL_006c
    IL_008a: ldarg.0
    IL_008b: ldfld float[] UnitRespawnerForBuildings::currentlyAppliedExperienceBoosts  /*0x040017E8*/
    IL_0090: ldloc.0
    IL_0091: ldc.r4 1f
    IL_0096: stelem.r4
    IL_0097: ldloc.0
    IL_0098: ldc.i4.1
    IL_0099: add
    IL_009a: stloc.0
    IL_009b: ldloc.0
    IL_009c: ldarg.0
    IL_009d: ldfld List<Hp> UnitRespawnerForBuildings::units  /*0x040017D5*/
    IL_00a2: callvirt int System.Collections.Generic.List<Hp>::get_Count()  /*0x0A000779*/
    IL_00a7: blt.s IL_0035
    IL_00a9: ldarg.0
    IL_00aa: ldc.r4 1f
    IL_00af: stfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_00b4: ret

  .method UnitRespawnerForBuildings::DayNightCycle.IDaytimeSensitive.OnDusk()  // token 0x060013A5 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitRespawnerForBuildings::DayNightCycle.IDaytimeSensitive.OnDawn_AfterSunrise()  // token 0x060013A6 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitRespawnerForBuildings::DayNightCycle.IDaytimeSensitive.OnDawn_BeforeSunrise()  // token 0x060013A7 rva 0x5d3e5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool UnitRespawnerForBuildings::night  /*0x040017E5*/
    IL_0007: ret

  .method UnitRespawnerForBuildings::.ctor()  // token 0x060013A8 rva 0x5d3ee attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_0006: stfld List<float> UnitRespawnerForBuildings::timeToRespawnAUnitDependingOnLevel  /*0x040017D6*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float UnitRespawnerForBuildings::totalTrainingSpeed  /*0x040017E1*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float UnitRespawnerForBuildings::experienceGainMulti  /*0x040017E7*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float UnitRespawnerForBuildings::currentExperienceMulti  /*0x040017E9*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

