// ===== RoyalForgeUpgrades  (token 0x020001DC) =====
  .method RoyalForgeUpgrades::Awake()  // token 0x060009AC rva 0x2d3c1 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld RoyalForgeUpgrades RoyalForgeUpgrades::instance  /*0x04000C60*/
    IL_0006: ret

  .method RoyalForgeUpgrades::Start()  // token 0x060009AD rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrades::Update()  // token 0x060009AE rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method RoyalForgeUpgrades::.ctor()  // token 0x060009AF rva 0x2d3c9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float RoyalForgeUpgrades::meleeDamage  /*0x04000C61*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float RoyalForgeUpgrades::rangedDamage  /*0x04000C62*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float RoyalForgeUpgrades::meleeResistance  /*0x04000C63*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float RoyalForgeUpgrades::rangedResistance  /*0x04000C64*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

