// ===== PerkDamageAutoAttackModifyer  (token 0x0200021F) =====
  .method PerkDamageAutoAttackModifyer::Start()  // token 0x06000B64 rva 0x3652c attrs Private, HideBySig
    // code size 73 (0x49), max stack 3, init locals
    .locals ([0] AutoAttack[], [1] int)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_000a: ldarg.0
    IL_000b: ldfld Equippable PerkDamageAutoAttackModifyer::perk  /*0x04000E49*/
    IL_0010: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0015: brfalse.s IL_0042
    IL_0017: ldarg.0
    IL_0018: ldc.i4.1
    IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren(bool)<AutoAttack>  /*0x2B0000A9*/
    IL_001e: stloc.0
    IL_001f: ldc.i4.0
    IL_0020: stloc.1
    IL_0021: br.s IL_003c
    IL_0023: ldloc.0
    IL_0024: ldloc.1
    IL_0025: ldelem.ref
    IL_0026: dup
    IL_0027: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_002c: ldarg.0
    IL_002d: ldfld float PerkDamageAutoAttackModifyer::damageMultiplyer  /*0x04000E4A*/
    IL_0032: mul
    IL_0033: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_0038: ldloc.1
    IL_0039: ldc.i4.1
    IL_003a: add
    IL_003b: stloc.1
    IL_003c: ldloc.1
    IL_003d: ldloc.0
    IL_003e: ldlen
    IL_003f: conv.i4
    IL_0040: blt.s IL_0023
    IL_0042: ldarg.0
    IL_0043: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0048: ret

  .method PerkDamageAutoAttackModifyer::.ctor()  // token 0x06000B65 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

