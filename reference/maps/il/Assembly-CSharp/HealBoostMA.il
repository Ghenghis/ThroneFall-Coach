// ===== HealBoostMA  (token 0x020001E4) =====
  .method HealBoostMA::Start()  // token 0x060009EF rva 0x2ed6d attrs Public, Virtual, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ret

  .method HealBoostMA::Attack()  // token 0x060009F0 rva 0x2ee08 attrs Public, Virtual, HideBySig
    // code size 131 (0x83), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld bool HealBoostMA::attackSpeedReduced  /*0x04000CAB*/
    IL_0006: brtrue.s IL_0038
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld ManualAttack HealBoostMA::manualAttackToBoost  /*0x04000CA4*/
    IL_000f: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0014: stfld float HealBoostMA::attackSpeedOriginal  /*0x04000CAA*/
    IL_0019: ldarg.0
    IL_001a: ldfld ManualAttack HealBoostMA::manualAttackToBoost  /*0x04000CA4*/
    IL_001f: dup
    IL_0020: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0025: ldarg.0
    IL_0026: ldfld float HealBoostMA::attackSpeedBoost  /*0x04000CA3*/
    IL_002b: div
    IL_002c: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0031: ldarg.0
    IL_0032: ldc.i4.1
    IL_0033: stfld bool HealBoostMA::attackSpeedReduced  /*0x04000CAB*/
    IL_0038: ldarg.0
    IL_0039: ldfld ParticleSystem HealBoostMA::boostParticles  /*0x04000CA5*/
    IL_003e: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_0043: stloc.0
    IL_0044: ldloca.s 0
    IL_0046: ldc.i4.1
    IL_0047: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_004c: ldarg.0
    IL_004d: ldarg.0
    IL_004e: ldfld float HealBoostMA::attackSpeedDuration  /*0x04000CA6*/
    IL_0053: stfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0058: ldarg.0
    IL_0059: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_005e: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0063: ldc.r4 0.33f
    IL_0068: bgt.un.s IL_0076
    IL_006a: ldarg.0
    IL_006b: ldarg.0
    IL_006c: ldfld float HealBoostMA::attackSpeedDurationWhenLowHealth  /*0x04000CA8*/
    IL_0071: stfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0076: ldarg.0
    IL_0077: ldarg.0
    IL_0078: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_007d: stfld float HealBoostMA::cooldownOnAttack  /*0x04000CAC*/
    IL_0082: ret

  .method HealBoostMA::Update()  // token 0x060009F1 rva 0x2ee98 attrs Public, Virtual, HideBySig
    // code size 203 (0xcb), max stack 3, init locals
    .locals ([0] bool, [1] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Update()  /*0x06000A02*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_000d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0012: sub
    IL_0013: stfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0018: ldarg.0
    IL_0019: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_001e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0023: ldc.r4 0f
    IL_0028: cgt.un
    IL_002a: ldc.i4.0
    IL_002b: ceq
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0034: ldc.r4 0f
    IL_0039: ble.un.s IL_006c
    IL_003b: ldloc.0
    IL_003c: brtrue.s IL_006c
    IL_003e: ldarg.0
    IL_003f: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_0044: ldarg.0
    IL_0045: ldfld float HealBoostMA::healthRegenerationPerSecond  /*0x04000CA7*/
    IL_004a: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_004f: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0054: mul
    IL_0055: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005a: mul
    IL_005b: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0060: ldarg.0
    IL_0061: ldarg.0
    IL_0062: ldfld float HealBoostMA::cooldownOnAttack  /*0x04000CAC*/
    IL_0067: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_006c: ldarg.0
    IL_006d: ldfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0072: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0077: add
    IL_0078: ldc.r4 0f
    IL_007d: ble.un.s IL_0091
    IL_007f: ldarg.0
    IL_0080: ldfld float HealBoostMA::disableBoostIn  /*0x04000CA9*/
    IL_0085: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008a: cgt.un
    IL_008c: ldc.i4.0
    IL_008d: ceq
    IL_008f: br.s IL_0092
    IL_0091: ldc.i4.0
    IL_0092: ldloc.0
    IL_0093: or
    IL_0094: brfalse.s IL_00ca
    IL_0096: ldarg.0
    IL_0097: ldfld bool HealBoostMA::attackSpeedReduced  /*0x04000CAB*/
    IL_009c: brfalse.s IL_00b6
    IL_009e: ldarg.0
    IL_009f: ldc.i4.0
    IL_00a0: stfld bool HealBoostMA::attackSpeedReduced  /*0x04000CAB*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld ManualAttack HealBoostMA::manualAttackToBoost  /*0x04000CA4*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld float HealBoostMA::attackSpeedOriginal  /*0x04000CAA*/
    IL_00b1: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld ParticleSystem HealBoostMA::boostParticles  /*0x04000CA5*/
    IL_00bc: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_00c1: stloc.1
    IL_00c2: ldloca.s 1
    IL_00c4: ldc.i4.0
    IL_00c5: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_00ca: ret

  .method HealBoostMA::.ctor()  // token 0x060009F2 rva 0x2ef6f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float HealBoostMA::attackSpeedBoost  /*0x04000CA3*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float HealBoostMA::attackSpeedDuration  /*0x04000CA6*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 16.66f
    IL_001c: stfld float HealBoostMA::healthRegenerationPerSecond  /*0x04000CA7*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 4f
    IL_0027: stfld float HealBoostMA::attackSpeedDurationWhenLowHealth  /*0x04000CA8*/
    IL_002c: ldarg.0
    IL_002d: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0032: ret

