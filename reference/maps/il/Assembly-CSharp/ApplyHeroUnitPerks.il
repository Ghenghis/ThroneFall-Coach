// ===== ApplyHeroUnitPerks  (token 0x0200004C) =====
  .method ApplyHeroUnitPerks::Start()  // token 0x0600016A rva 0x77c8 attrs Private, HideBySig
    // code size 118 (0x76), max stack 3, init locals
    .locals ([0] Hp, [1] AutoAttack[], [2] int)
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0006: stloc.0
    IL_0007: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_000c: callvirt bool PerkManager::get_StrongerHeros()  /*0x0600098E*/
    IL_0011: brfalse.s IL_0075
    IL_0013: ldloc.0
    IL_0014: dup
    IL_0015: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_001a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001f: ldfld float PerkManager::strongerHeros_healthMutli  /*0x04000C2C*/
    IL_0024: mul
    IL_0025: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_002a: ldloc.0
    IL_002b: dup
    IL_002c: callvirt float Hp::get_DamageMultiplyer()  /*0x0600081B*/
    IL_0031: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0036: ldfld float PerkManager::strongerHeros_damageMulti  /*0x04000C2D*/
    IL_003b: mul
    IL_003c: callvirt void Hp::set_DamageMultiplyer(float)  /*0x0600081C*/
    IL_0041: ldloc.0
    IL_0042: callvirt void Hp::SetHpToMaxHp()  /*0x06000825*/
    IL_0047: ldarg.0
    IL_0048: call !!0[] UnityEngine.Component::GetComponentsInChildren()<AutoAttack>  /*0x2B000015*/
    IL_004d: stloc.1
    IL_004e: ldc.i4.0
    IL_004f: stloc.2
    IL_0050: br.s IL_006f
    IL_0052: ldloc.1
    IL_0053: ldloc.2
    IL_0054: ldelem.ref
    IL_0055: dup
    IL_0056: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_005b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0060: ldfld float PerkManager::strongerHeros_damageMulti  /*0x04000C2D*/
    IL_0065: mul
    IL_0066: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_006b: ldloc.2
    IL_006c: ldc.i4.1
    IL_006d: add
    IL_006e: stloc.2
    IL_006f: ldloc.2
    IL_0070: ldloc.1
    IL_0071: ldlen
    IL_0072: conv.i4
    IL_0073: blt.s IL_0052
    IL_0075: ret

  .method ApplyHeroUnitPerks::.ctor()  // token 0x0600016B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

