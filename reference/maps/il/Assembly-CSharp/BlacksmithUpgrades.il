// ===== BlacksmithUpgrades  (token 0x020001C2) =====
  .method BlacksmithUpgrades::Awake()  // token 0x06000916 rva 0x2b71e attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0006: ret

  .method BlacksmithUpgrades::Start()  // token 0x06000917 rva 0x2b728 attrs Private, HideBySig
    // code size 141 (0x8d), max stack 3, init locals
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt bool PerkManager::get_MeleeResistenceActive()  /*0x06000986*/
    IL_000a: brfalse.s IL_0023
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0013: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0018: ldfld float PerkManager::meleeResistence_AmountMulti  /*0x04000C15*/
    IL_001d: mul
    IL_001e: stfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0023: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0028: callvirt bool PerkManager::get_RangedResistenceActive()  /*0x06000985*/
    IL_002d: brfalse.s IL_0046
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0036: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_003b: ldfld float PerkManager::rangedResistence_AmountMulti  /*0x04000C13*/
    IL_0040: mul
    IL_0041: stfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0046: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004b: callvirt bool PerkManager::get_RangedDamageActive()  /*0x06000990*/
    IL_0050: brfalse.s IL_0069
    IL_0052: ldarg.0
    IL_0053: ldarg.0
    IL_0054: ldfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0059: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005e: ldfld float PerkManager::rangedDamage_multi  /*0x04000C31*/
    IL_0063: mul
    IL_0064: stfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0069: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006e: callvirt bool PerkManager::get_MeleeDamageActive()  /*0x0600098F*/
    IL_0073: brfalse.s IL_008c
    IL_0075: ldarg.0
    IL_0076: ldarg.0
    IL_0077: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_007c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0081: ldfld float PerkManager::meleeDamage_multi  /*0x04000C2F*/
    IL_0086: mul
    IL_0087: stfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_008c: ret

  .method BlacksmithUpgrades::Update()  // token 0x06000918 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BlacksmithUpgrades::.ctor()  // token 0x06000919 rva 0x2b7c1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float BlacksmithUpgrades::rangedDamage  /*0x04000B81*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float BlacksmithUpgrades::meleeResistance  /*0x04000B82*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float BlacksmithUpgrades::unitRespawnSpeedMulti  /*0x04000B84*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

