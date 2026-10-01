// ===== UpgradePlayerDmg  (token 0x02000241) =====
  .method UpgradePlayerDmg::OnEnable()  // token 0x06000C63 rva 0x397af attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0005: dup
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_000b: ldarg.0
    IL_000c: ldfld float UpgradePlayerDmg::damageMultiplyer  /*0x04000F1E*/
    IL_0011: mul
    IL_0012: callvirt void PlayerUpgradeManager::set_PlayerDamageMultiplyer(float)  /*0x06000C68*/
    IL_0017: ret

  .method UpgradePlayerDmg::.ctor()  // token 0x06000C64 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

