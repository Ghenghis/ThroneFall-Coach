// ===== WeaponDamageDealer  (token 0x0200039F) =====
  .method WeaponDamageDealer::get_DamageMultiplyer()  // token 0x060013D2 rva 0x5e59c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float WeaponDamageDealer::damageMultiplyer  /*0x0400183B*/
    IL_0006: ret

  .method WeaponDamageDealer::set_DamageMultiplyer(float)  // token 0x060013D3 rva 0x5e5a4 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float WeaponDamageDealer::damageMultiplyer  /*0x0400183B*/
    IL_0007: ret

  .method WeaponDamageDealer::.ctor()  // token 0x060013D4 rva 0x5e5ad attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float WeaponDamageDealer::damageMultiplyer  /*0x0400183B*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

