// ===== PerkWeaponModifyer  (token 0x0200022B) =====
  .method PerkWeaponModifyer::Start()  // token 0x06000B8D rva 0x36b07 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkWeaponModifyer::requiredPerk  /*0x04000E68*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_001e
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack PerkWeaponModifyer::autoAttack  /*0x04000E6A*/
    IL_0013: ldarg.0
    IL_0014: ldfld Weapon PerkWeaponModifyer::weaponToInsert  /*0x04000E69*/
    IL_0019: stfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_001e: ldarg.0
    IL_001f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0024: ret

  .method PerkWeaponModifyer::.ctor()  // token 0x06000B8E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

