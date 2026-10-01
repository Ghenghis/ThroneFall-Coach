// ===== GodlyCurseEffect  (token 0x0200018C) =====
  .method GodlyCurseEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x060007FC rva 0x272d9 attrs Public, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0005: ldfld bool PlayerUpgradeManager::godlyCurse  /*0x04000F27*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.s 7
    IL_000f: ldc.r4 0f
    IL_0014: ble.un.s IL_0021
    IL_0016: ldsfld UpgradeGodlyCurse UpgradeGodlyCurse::instance  /*0x04000F18*/
    IL_001b: ldarg.1
    IL_001c: callvirt void UpgradeGodlyCurse::Damage(Hp)  /*0x06000C5A*/
    IL_0021: ret

  .method GodlyCurseEffect::.ctor()  // token 0x060007FD rva 0x101c0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0006: ret

