// ===== PerkCooldownModifyer  (token 0x0200021D) =====
  .method PerkCooldownModifyer::Start()  // token 0x06000B60 rva 0x36464 attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkCooldownModifyer::requiredPerk  /*0x04000E44*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_003d
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack PerkCooldownModifyer::autoAttack  /*0x04000E46*/
    IL_0013: dup
    IL_0014: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0019: ldarg.0
    IL_001a: ldfld float PerkCooldownModifyer::hpCooldownMultiplyer  /*0x04000E45*/
    IL_001f: mul
    IL_0020: stfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0025: ldarg.0
    IL_0026: ldfld AutoAttack PerkCooldownModifyer::autoAttack  /*0x04000E46*/
    IL_002b: dup
    IL_002c: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_0031: ldarg.0
    IL_0032: ldfld float PerkCooldownModifyer::hpCooldownMultiplyer  /*0x04000E45*/
    IL_0037: mul
    IL_0038: stfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_003d: ldarg.0
    IL_003e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0043: ret

  .method PerkCooldownModifyer::.ctor()  // token 0x06000B61 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

