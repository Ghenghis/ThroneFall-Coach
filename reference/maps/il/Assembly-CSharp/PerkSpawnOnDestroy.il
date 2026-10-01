// ===== PerkSpawnOnDestroy  (token 0x02000228) =====
  .method PerkSpawnOnDestroy::Update()  // token 0x06000B87 rva 0x36a85 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkSpawnOnDestroy::requiredEquippable  /*0x04000E60*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_001e
    IL_000d: ldarg.0
    IL_000e: ldfld Hp PerkSpawnOnDestroy::hp  /*0x04000E61*/
    IL_0013: ldarg.0
    IL_0014: ldfld Weapon PerkSpawnOnDestroy::weaponToSpawn  /*0x04000E62*/
    IL_0019: callvirt void Hp::set_SpwanAttackOnDeath(Weapon)  /*0x0600081A*/
    IL_001e: ldarg.0
    IL_001f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0024: ret

  .method PerkSpawnOnDestroy::.ctor()  // token 0x06000B88 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

