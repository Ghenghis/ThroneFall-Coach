// ===== WeaponEquipper  (token 0x020003A0) =====
  .method WeaponEquipper::Start()  // token 0x060013D5 rva 0x5e5c0 attrs Private, HideBySig
    // code size 178 (0xb2), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable WeaponEquipper::requiredWeapon  /*0x0400183C*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: call !!0 UnityEngine.Component::GetComponentInParent()<PlayerInteraction>  /*0x2B000115*/
    IL_001f: ldarg.0
    IL_0020: ldfld ManualAttack WeaponEquipper::activeWeapon  /*0x0400183D*/
    IL_0025: ldarg.0
    IL_0026: ldfld ManualAttack WeaponEquipper::passiveWeapon  /*0x0400183E*/
    IL_002b: callvirt void PlayerInteraction::EquipWeapon(ManualAttack,ManualAttack)  /*0x06000C03*/
    IL_0030: ldarg.0
    IL_0031: call !!0 UnityEngine.Component::GetComponentInParent()<PlayerUpgradeManager>  /*0x2B000116*/
    IL_0036: pop
    IL_0037: ldarg.0
    IL_0038: call !!0 UnityEngine.Component::GetComponentInParent()<PlayerAttack>  /*0x2B000117*/
    IL_003d: ldarg.0
    IL_003e: ldfld ManualAttack WeaponEquipper::activeWeapon  /*0x0400183D*/
    IL_0043: callvirt void PlayerAttack::AssignManualAttack(ManualAttack)  /*0x06000B91*/
    IL_0048: ldarg.0
    IL_0049: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004e: callvirt !!0 UnityEngine.GameObject::AddComponent()<PlayerWeaponVisuals>  /*0x2B000118*/
    IL_0053: ldarg.0
    IL_0054: ldfld GameObject WeaponEquipper::visuals  /*0x0400183F*/
    IL_0059: ldarg.0
    IL_005a: ldfld ManualAttack WeaponEquipper::passiveWeapon  /*0x0400183E*/
    IL_005f: callvirt void PlayerWeaponVisuals::Init(UnityEngine.GameObject,ManualAttack)  /*0x06000C7E*/
    IL_0064: ldarg.0
    IL_0065: ldfld PlayerAttackTargetFacer WeaponEquipper::facer  /*0x04001840*/
    IL_006a: ldarg.0
    IL_006b: ldfld ManualAttack WeaponEquipper::passiveWeapon  /*0x0400183E*/
    IL_0070: callvirt void PlayerAttackTargetFacer::AssignAttack(ManualAttack)  /*0x060000DA*/
    IL_0075: ldarg.0
    IL_0076: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_007b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0080: callvirt bool PerkManager::get_LightMaterialsEquipped()  /*0x06000993*/
    IL_0085: brfalse.s IL_0096
    IL_0087: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_008c: ldfld float PerkManager::lightMaterialsCooldownMulti  /*0x04000C38*/
    IL_0091: call void RoyalForgeUpgrade::AutoAttackMulti(float)  /*0x06000CBE*/
    IL_0096: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_009b: callvirt bool PerkManager::get_SpellScrollActive()  /*0x06000992*/
    IL_00a0: brfalse.s IL_00b1
    IL_00a2: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00a7: ldfld float PerkManager::spellScrollActiveCooldownMulti  /*0x04000C36*/
    IL_00ac: call void RoyalForgeUpgrade::ManualAttackMulti(float)  /*0x06000CBD*/
    IL_00b1: ret

  .method WeaponEquipper::.ctor()  // token 0x060013D6 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

