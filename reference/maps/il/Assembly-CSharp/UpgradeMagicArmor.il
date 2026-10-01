// ===== UpgradeMagicArmor  (token 0x02000240) =====
  .method UpgradeMagicArmor::Awake()  // token 0x06000C60 rva 0x3977c attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld UpgradeMagicArmor UpgradeMagicArmor::instance  /*0x04000F1B*/
    IL_0006: ret

  .method UpgradeMagicArmor::OnEnable()  // token 0x06000C61 rva 0x39784 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0005: ldc.i4.1
    IL_0006: stfld bool PlayerUpgradeManager::magicArmor  /*0x04000F28*/
    IL_000b: ret

  .method UpgradeMagicArmor::.ctor()  // token 0x06000C62 rva 0x39791 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float UpgradeMagicArmor::damageVersusMelee  /*0x04000F1C*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float UpgradeMagicArmor::damageVersusRanged  /*0x04000F1D*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

