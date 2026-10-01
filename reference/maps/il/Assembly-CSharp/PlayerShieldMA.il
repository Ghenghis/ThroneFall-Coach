// ===== PlayerShieldMA  (token 0x020001E8) =====
  .method PlayerShieldMA::Start()  // token 0x06000A0B rva 0x2fb66 attrs Public, Virtual, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ldarg.0
    IL_0007: ldfld BattleAxeShieldFX PlayerShieldMA::shieldFX  /*0x04000CD8*/
    IL_000c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: ldc.i4.1
    IL_0012: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0017: ret

  .method PlayerShieldMA::Attack()  // token 0x06000A0C rva 0x2fb7f attrs Public, Virtual, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_0006: ldc.r4 0f
    IL_000b: bgt.un.s IL_002b
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float PlayerShieldMA::effectDuration  /*0x04000CD6*/
    IL_0014: stfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0020: stfld float PlayerShieldMA::cooldownRemember  /*0x04000CD9*/
    IL_0025: ldarg.0
    IL_0026: call void PlayerShieldMA::EffectEnable()  /*0x06000A10*/
    IL_002b: ret

  .method PlayerShieldMA::Update()  // token 0x06000A0D rva 0x2fbac attrs Public, Virtual, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Update()  /*0x06000A02*/
    IL_0006: ldarg.0
    IL_0007: ldfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_000c: ldc.r4 0f
    IL_0011: ble.un.s IL_0033
    IL_0013: ldarg.0
    IL_0014: call bool PlayerShieldMA::IsDead()  /*0x06000A0E*/
    IL_0019: brtrue.s IL_0033
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_0022: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0027: sub
    IL_0028: stfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_002d: ldarg.0
    IL_002e: call void PlayerShieldMA::EffectUpdate()  /*0x06000A11*/
    IL_0033: ldarg.0
    IL_0034: call bool PlayerShieldMA::ShouldDisableEffect()  /*0x06000A0F*/
    IL_0039: brfalse.s IL_0041
    IL_003b: ldarg.0
    IL_003c: call void PlayerShieldMA::EffectDisable()  /*0x06000A12*/
    IL_0041: ret

  .method PlayerShieldMA::IsDead()  // token 0x06000A0E rva 0x2fbfa attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_0006: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_000b: ldc.r4 0f
    IL_0010: cgt.un
    IL_0012: ldc.i4.0
    IL_0013: ceq
    IL_0015: ret

  .method PlayerShieldMA::ShouldDisableEffect()  // token 0x06000A0F rva 0x2fc11 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_0006: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000b: add
    IL_000c: ldc.r4 0f
    IL_0011: ble.un.s IL_0020
    IL_0013: ldarg.0
    IL_0014: ldfld float PlayerShieldMA::disableEffectIn  /*0x04000CD7*/
    IL_0019: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001e: ble.s IL_0027
    IL_0020: ldarg.0
    IL_0021: call bool PlayerShieldMA::IsDead()  /*0x06000A0E*/
    IL_0026: ret
    IL_0027: ldc.i4.1
    IL_0028: ret

  .method PlayerShieldMA::EffectEnable()  // token 0x06000A10 rva 0x2fc3b attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0005: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_000a: ldc.i4.1
    IL_000b: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0010: ldarg.0
    IL_0011: ldfld BattleAxeShieldFX PlayerShieldMA::shieldFX  /*0x04000CD8*/
    IL_0016: ldarg.0
    IL_0017: ldfld float PlayerShieldMA::effectDuration  /*0x04000CD6*/
    IL_001c: callvirt void BattleAxeShieldFX::Play(float)  /*0x0600076F*/
    IL_0021: ret

  .method PlayerShieldMA::EffectUpdate()  // token 0x06000A11 rva 0x2fc5e attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PlayerShieldMA::cooldownRemember  /*0x04000CD9*/
    IL_0007: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_000c: ret

  .method PlayerShieldMA::EffectDisable()  // token 0x06000A12 rva 0x2fc6c attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: ldc.i4.1
    IL_000b: bne.un.s IL_001d
    IL_000d: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0012: callvirt Hp PlayerMovement::get_Hp()  /*0x06000C1C*/
    IL_0017: ldc.i4.0
    IL_0018: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_001d: ret

  .method PlayerShieldMA::.ctor()  // token 0x06000A13 rva 0x2fc8b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float PlayerShieldMA::effectDuration  /*0x04000CD6*/
    IL_000b: ldarg.0
    IL_000c: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0011: ret

