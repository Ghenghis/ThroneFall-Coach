// ===== PlayerHpRegen  (token 0x0200022F) =====
  .method PlayerHpRegen::Start()  // token 0x06000B9B rva 0x36f98 attrs Private, HideBySig
    // code size 203 (0xcb), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0007: stfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_0013: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0018: stfld float PlayerHpRegen::hpRemember  /*0x04000E83*/
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: ldfld Equippable PlayerHpRegen::heavyArmorPerk  /*0x04000E86*/
    IL_0024: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0029: stfld bool PlayerHpRegen::heavyArmorEquipped  /*0x04000E84*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld Equippable PlayerHpRegen::godsLotionPerk  /*0x04000E87*/
    IL_0035: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_003a: stfld bool PlayerHpRegen::godsLotionEquipped  /*0x04000E85*/
    IL_003f: ldarg.0
    IL_0040: ldfld bool PlayerHpRegen::heavyArmorEquipped  /*0x04000E84*/
    IL_0045: brfalse.s IL_008f
    IL_0047: ldarg.0
    IL_0048: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_004d: dup
    IL_004e: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0053: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0058: ldfld float PerkManager::heavyArmor_HpMultiplyer  /*0x04000BF2*/
    IL_005d: mul
    IL_005e: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0063: ldarg.0
    IL_0064: ldfld PlayerUpgradeManager PlayerHpRegen::playerUpgradeManager  /*0x04000E7E*/
    IL_0069: dup
    IL_006a: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_006f: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0074: ldfld float PerkManager::heavyArmor_SelfHealMultiplyer  /*0x04000BF4*/
    IL_0079: mul
    IL_007a: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_007f: ldarg.0
    IL_0080: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_0085: ldc.r4 3.4028235E+38f
    IL_008a: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_008f: ldarg.0
    IL_0090: ldfld bool PlayerHpRegen::godsLotionEquipped  /*0x04000E85*/
    IL_0095: brfalse.s IL_00ca
    IL_0097: ldarg.0
    IL_0098: ldarg.0
    IL_0099: ldfld float PlayerHpRegen::delayTillRegenerationStarts  /*0x04000E80*/
    IL_009e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00a3: ldfld float PerkManager::godsLotion_RegenDelayMultiplyer  /*0x04000BF6*/
    IL_00a8: mul
    IL_00a9: stfld float PlayerHpRegen::delayTillRegenerationStarts  /*0x04000E80*/
    IL_00ae: ldarg.0
    IL_00af: ldfld PlayerUpgradeManager PlayerHpRegen::playerUpgradeManager  /*0x04000E7E*/
    IL_00b4: dup
    IL_00b5: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_00ba: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00bf: ldfld float PerkManager::godsLotion_RegenRateMultiplyer  /*0x04000BF5*/
    IL_00c4: mul
    IL_00c5: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_00ca: ret

  .method PlayerHpRegen::Update()  // token 0x06000B9C rva 0x37070 attrs Private, HideBySig
    // code size 103 (0x67), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PlayerHpRegen::timeSinceLastTakenDamage  /*0x04000E82*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float PlayerHpRegen::timeSinceLastTakenDamage  /*0x04000E82*/
    IL_0012: ldarg.0
    IL_0013: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_0018: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_001d: ldarg.0
    IL_001e: ldfld float PlayerHpRegen::hpRemember  /*0x04000E83*/
    IL_0023: bge.un.s IL_0030
    IL_0025: ldarg.0
    IL_0026: ldc.r4 0f
    IL_002b: stfld float PlayerHpRegen::timeSinceLastTakenDamage  /*0x04000E82*/
    IL_0030: ldarg.0
    IL_0031: ldarg.0
    IL_0032: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_0037: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_003c: stfld float PlayerHpRegen::hpRemember  /*0x04000E83*/
    IL_0041: ldarg.0
    IL_0042: ldfld float PlayerHpRegen::timeSinceLastTakenDamage  /*0x04000E82*/
    IL_0047: ldarg.0
    IL_0048: ldfld float PlayerHpRegen::delayTillRegenerationStarts  /*0x04000E80*/
    IL_004d: blt.un.s IL_0066
    IL_004f: ldarg.0
    IL_0050: ldfld Hp PlayerHpRegen::hp  /*0x04000E7F*/
    IL_0055: ldarg.0
    IL_0056: call float PlayerHpRegen::get_HealingPerSecond()  /*0x06000B9D*/
    IL_005b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0060: mul
    IL_0061: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0066: ret

  .method PlayerHpRegen::get_HealingPerSecond()  // token 0x06000B9D rva 0x370e3 attrs Public, HideBySig, SpecialName
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float PlayerHpRegen::standardHealingPerSecond  /*0x04000E81*/
    IL_0006: ldarg.0
    IL_0007: ldfld PlayerUpgradeManager PlayerHpRegen::playerUpgradeManager  /*0x04000E7E*/
    IL_000c: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0011: mul
    IL_0012: ret

  .method PlayerHpRegen::.ctor()  // token 0x06000B9E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

