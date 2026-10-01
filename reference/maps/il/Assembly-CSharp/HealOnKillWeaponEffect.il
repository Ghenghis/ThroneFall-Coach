// ===== HealOnKillWeaponEffect  (token 0x0200018D) =====
  .method HealOnKillWeaponEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x060007FE rva 0x272fc attrs Public, Virtual, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.s 6
    IL_0002: brfalse.s IL_003a
    IL_0004: ldarg.0
    IL_0005: ldfld bool HealOnKillWeaponEffect::applyPlayerSelfHealMulti  /*0x04000A02*/
    IL_000a: brfalse.s IL_0029
    IL_000c: ldarg.3
    IL_000d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0012: ldarg.0
    IL_0013: ldfld float HealOnKillWeaponEffect::healOnKill  /*0x04000A01*/
    IL_0018: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_001d: callvirt float PlayerUpgradeManager::get_PlayerHealthRegenerationMultiplyer()  /*0x06000C69*/
    IL_0022: mul
    IL_0023: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0028: ret
    IL_0029: ldarg.3
    IL_002a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_002f: ldarg.0
    IL_0030: ldfld float HealOnKillWeaponEffect::healOnKill  /*0x04000A01*/
    IL_0035: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_003a: ret

  .method HealOnKillWeaponEffect::.ctor()  // token 0x060007FF rva 0x27338 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float HealOnKillWeaponEffect::healOnKill  /*0x04000A01*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

