// ===== TempleBlessing  (token 0x020002AE) =====
  .method TempleBlessing::EnableEffectAtDusk()  // token 0x06000EBF rva 0x42620 attrs Public, Virtual, HideBySig
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] PlayerMovement[], [1] int)
    IL_0000: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0005: dup
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_000b: ldarg.0
    IL_000c: ldfld float TempleBlessing::selfHealMulit  /*0x04001112*/
    IL_0011: mul
    IL_0012: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_0017: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_001c: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_004a
    IL_0026: ldloc.0
    IL_0027: ldloc.1
    IL_0028: ldelem.ref
    IL_0029: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_002e: dup
    IL_002f: dup
    IL_0030: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0035: ldarg.0
    IL_0036: ldfld float TempleBlessing::healthMulit  /*0x04001111*/
    IL_003b: mul
    IL_003c: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0041: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_0046: ldloc.1
    IL_0047: ldc.i4.1
    IL_0048: add
    IL_0049: stloc.1
    IL_004a: ldloc.1
    IL_004b: ldloc.0
    IL_004c: ldlen
    IL_004d: conv.i4
    IL_004e: blt.s IL_0026
    IL_0050: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0055: dup
    IL_0056: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_005b: ldarg.0
    IL_005c: ldfld float TempleBlessing::damageMulit  /*0x04001113*/
    IL_0061: mul
    IL_0062: callvirt void PlayerUpgradeManager::set_PlayerDamageMultiplyer(float)  /*0x06000C68*/
    IL_0067: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_006c: dup
    IL_006d: ldfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_0072: ldarg.0
    IL_0073: ldfld float TempleBlessing::speedMulit  /*0x04001114*/
    IL_0078: mul
    IL_0079: stfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_007e: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0083: dup
    IL_0084: ldfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0089: ldarg.0
    IL_008a: ldfld float TempleBlessing::speedMulit  /*0x04001114*/
    IL_008f: mul
    IL_0090: stfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0095: ret

  .method TempleBlessing::DisableEffectAtDawn()  // token 0x06000EC0 rva 0x426c4 attrs Public, Virtual, HideBySig
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] PlayerMovement[], [1] int)
    IL_0000: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0005: dup
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_000b: ldarg.0
    IL_000c: ldfld float TempleBlessing::selfHealMulit  /*0x04001112*/
    IL_0011: div
    IL_0012: callvirt void PlayerUpgradeManager::set_PlayerHealthRegenerationMultiplyer(float)  /*0x06000C6A*/
    IL_0017: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_001c: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_0021: stloc.0
    IL_0022: ldc.i4.0
    IL_0023: stloc.1
    IL_0024: br.s IL_004a
    IL_0026: ldloc.0
    IL_0027: ldloc.1
    IL_0028: ldelem.ref
    IL_0029: callvirt !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_002e: dup
    IL_002f: dup
    IL_0030: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0035: ldarg.0
    IL_0036: ldfld float TempleBlessing::healthMulit  /*0x04001111*/
    IL_003b: div
    IL_003c: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0041: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_0046: ldloc.1
    IL_0047: ldc.i4.1
    IL_0048: add
    IL_0049: stloc.1
    IL_004a: ldloc.1
    IL_004b: ldloc.0
    IL_004c: ldlen
    IL_004d: conv.i4
    IL_004e: blt.s IL_0026
    IL_0050: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0055: dup
    IL_0056: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_005b: ldarg.0
    IL_005c: ldfld float TempleBlessing::damageMulit  /*0x04001113*/
    IL_0061: div
    IL_0062: callvirt void PlayerUpgradeManager::set_PlayerDamageMultiplyer(float)  /*0x06000C68*/
    IL_0067: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_006c: dup
    IL_006d: ldfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_0072: ldarg.0
    IL_0073: ldfld float TempleBlessing::speedMulit  /*0x04001114*/
    IL_0078: div
    IL_0079: stfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_007e: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0083: dup
    IL_0084: ldfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0089: ldarg.0
    IL_008a: ldfld float TempleBlessing::speedMulit  /*0x04001114*/
    IL_008f: div
    IL_0090: stfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0095: ret

  .method TempleBlessing::.ctor()  // token 0x06000EC1 rva 0x42766 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.25f
    IL_0006: stfld float TempleBlessing::healthMulit  /*0x04001111*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.25f
    IL_0011: stfld float TempleBlessing::selfHealMulit  /*0x04001112*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1.25f
    IL_001c: stfld float TempleBlessing::damageMulit  /*0x04001113*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.75f
    IL_0027: stfld float TempleBlessing::speedMulit  /*0x04001114*/
    IL_002c: ldarg.0
    IL_002d: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_0032: ret

