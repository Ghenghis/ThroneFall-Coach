// ===== PerkManager  (token 0x020001D9) =====
  .method PerkManager::get_CurrentlyEquipped()  // token 0x0600097A rva 0x2cde7 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_0006: ret

  .method PerkManager::get_MetaLevels()  // token 0x0600097B rva 0x2cdef attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_0006: ret

  .method PerkManager::get_NextMetaLevel()  // token 0x0600097C rva 0x2cdf8 attrs Public, HideBySig, SpecialName
    // code size 72 (0x48), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_0006: ldc.i4.1
    IL_0007: sub
    IL_0008: ldarg.0
    IL_0009: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_000e: callvirt int System.Collections.Generic.List<MetaLevel>::get_Count()  /*0x0A000454*/
    IL_0013: bge.s IL_0022
    IL_0015: ldarg.0
    IL_0016: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_001b: ldc.i4 1000000
    IL_0020: blt.s IL_0034
    IL_0022: ldarg.0
    IL_0023: ldfld int PerkManager::xpNeededToProgressToNextLevelPastMaxMeta  /*0x04000BEE*/
    IL_0028: ldarg.0
    IL_0029: ldfld Equippable PerkManager::trophyPerkForPastMaxMeta  /*0x04000BEF*/
    IL_002e: newobj void MetaLevel::.ctor(int,Equippable)  /*0x060009AB*/
    IL_0033: ret
    IL_0034: ldarg.0
    IL_0035: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_003a: ldarg.0
    IL_003b: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_0040: ldc.i4.1
    IL_0041: sub
    IL_0042: callvirt !0 System.Collections.Generic.List<MetaLevel>::get_Item(int)  /*0x0A000455*/
    IL_0047: ret

  .method PerkManager::get_RoyalMintActive()  // token 0x0600097D rva 0x2ce4c attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::royalMint  /*0x04000BF0*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RatGodActive()  // token 0x0600097E rva 0x2ce59 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::ratGodPerk  /*0x04000C01*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_WarriorModeActive()  // token 0x0600097F rva 0x2ce66 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::warriorMode  /*0x04000C03*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_CommanderModeActive()  // token 0x06000980 rva 0x2ce73 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::commanderMode  /*0x04000C06*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GlassCanonActive()  // token 0x06000981 rva 0x2ce80 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::glassCanon  /*0x04000C09*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_HealingSpiritsActive()  // token 0x06000982 rva 0x2ce8d attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::healintSpirits  /*0x04000C0B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_ArcherySkillsActive()  // token 0x06000983 rva 0x2ce9a attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::archerySkills  /*0x04000C0D*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_IceMagicActive()  // token 0x06000984 rva 0x2cea7 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::iceMagic  /*0x04000C0F*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RangedResistenceActive()  // token 0x06000985 rva 0x2ceb4 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::rangedResistence  /*0x04000C12*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_MeleeResistenceActive()  // token 0x06000986 rva 0x2cec1 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::meleeResistence  /*0x04000C14*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_TreasureHunterActive()  // token 0x06000987 rva 0x2cece attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::treasureHunter  /*0x04000C17*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_CheeseGodActive()  // token 0x06000988 rva 0x2cedb attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::cheeseGod  /*0x04000C1B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GodOfDeathActive()  // token 0x06000989 rva 0x2cee8 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::godOfDeath  /*0x04000C1F*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_DestructionGodActive()  // token 0x0600098A rva 0x2cef5 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::destructionGod  /*0x04000C21*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_TauntThePhoenixGodActive()  // token 0x0600098B rva 0x2cf02 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::tauntThePhoenixGod  /*0x04000C23*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_HealthPotionsActive()  // token 0x0600098C rva 0x2cf0f attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::healthPotions  /*0x04000C26*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_AntiAirTelescope()  // token 0x0600098D rva 0x2cf1c attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::antiAirTelescope  /*0x04000C28*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_StrongerHeros()  // token 0x0600098E rva 0x2cf29 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::strongerHerosActive  /*0x04000C2B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_MeleeDamageActive()  // token 0x0600098F rva 0x2cf36 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::meleeDamage  /*0x04000C2E*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RangedDamageActive()  // token 0x06000990 rva 0x2cf43 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::rangedDamage  /*0x04000C30*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_PrayToWarGodsActive()  // token 0x06000991 rva 0x2cf50 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::prayToWarGods  /*0x04000C32*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_SpellScrollActive()  // token 0x06000992 rva 0x2cf5d attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::spellScroll  /*0x04000C35*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_LightMaterialsEquipped()  // token 0x06000993 rva 0x2cf6a attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::lightMaterials  /*0x04000C37*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_LoanEquipped()  // token 0x06000994 rva 0x2cf77 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::loan  /*0x04000C39*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RiskTakerEquipped()  // token 0x06000995 rva 0x2cf84 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::riskTaker  /*0x04000C3C*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_EliteTowersEquipped()  // token 0x06000996 rva 0x2cf91 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::eliteTowers  /*0x04000C3E*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_EliteGodEquipped()  // token 0x06000997 rva 0x2cf9e attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::eliteGod  /*0x04000C40*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GrowthGodEquipped()  // token 0x06000998 rva 0x2cfab attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::growthGod  /*0x04000C42*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RangeGodEquipped()  // token 0x06000999 rva 0x2cfb8 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::rangeGod  /*0x04000C45*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GodOfChaosEquipped()  // token 0x0600099A rva 0x2cfc5 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::godOfChaos  /*0x04000C4B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_ExperienceGainEquipped()  // token 0x0600099B rva 0x2cfd2 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::experienceGain  /*0x04000C4C*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_OutpostEquipped()  // token 0x0600099C rva 0x2cfdf attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::outpost  /*0x04000C4E*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_HealingGoldEquipped()  // token 0x0600099D rva 0x2cfec attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::healingGold  /*0x04000C4F*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_RoyalProtectionEquipped()  // token 0x0600099E rva 0x2cff9 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::royalProtection  /*0x04000C51*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_LastStandEquipped()  // token 0x0600099F rva 0x2d006 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::lastStand  /*0x04000C53*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GodOfAfterlifeEquipped()  // token 0x060009A0 rva 0x2d013 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::godOfAfterlife  /*0x04000C55*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_GodOfChoiceEquipped()  // token 0x060009A1 rva 0x2d020 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::godOfChoice  /*0x04000C57*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::get_PacifistPactEquipped()  // token 0x060009A2 rva 0x2d02d attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkManager::pacifistPact  /*0x04000C58*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkManager::Awake()  // token 0x060009A3 rva 0x2d03c attrs Private, HideBySig
    // code size 199 (0xc7), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0018
    IL_000c: ldarg.0
    IL_000d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0012: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: stsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001e: ldarg.0
    IL_001f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0024: callvirt Transform UnityEngine.Transform::get_root()  /*0x0A00037A*/
    IL_0029: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_0033: ldarg.0
    IL_0034: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0039: callvirt void System.Collections.Generic.Dictionary<Equippable, int>::Clear()  /*0x0A000456*/
    IL_003e: ldc.i4.0
    IL_003f: stloc.0
    IL_0040: br.s IL_0083
    IL_0042: ldarg.0
    IL_0043: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0048: ldarg.0
    IL_0049: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_004e: ldloc.0
    IL_004f: callvirt !0 System.Collections.Generic.List<MetaLevel>::get_Item(int)  /*0x0A000455*/
    IL_0054: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0059: callvirt bool System.Collections.Generic.Dictionary<Equippable, int>::ContainsKey(!0)  /*0x0A000457*/
    IL_005e: brtrue.s IL_007f
    IL_0060: ldarg.0
    IL_0061: ldfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0066: ldarg.0
    IL_0067: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_006c: ldloc.0
    IL_006d: callvirt !0 System.Collections.Generic.List<MetaLevel>::get_Item(int)  /*0x0A000455*/
    IL_0072: ldfld Equippable MetaLevel::reward  /*0x04000C5F*/
    IL_0077: ldloc.0
    IL_0078: ldc.i4.1
    IL_0079: add
    IL_007a: callvirt void System.Collections.Generic.Dictionary<Equippable, int>::Add(!0,!1)  /*0x0A000458*/
    IL_007f: ldloc.0
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.0
    IL_0083: ldloc.0
    IL_0084: ldarg.0
    IL_0085: ldfld List<MetaLevel> PerkManager::metaLevels  /*0x04000BED*/
    IL_008a: callvirt int System.Collections.Generic.List<MetaLevel>::get_Count()  /*0x0A000454*/
    IL_008f: blt.s IL_0042
    IL_0091: ldarg.0
    IL_0092: ldarg.0
    IL_0093: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_0098: ldsfld Func<Equippable, int> PerkManager.<>c::<>9__201_0  /*0x04000C5D*/
    IL_009d: dup
    IL_009e: brtrue.s IL_00b7
    IL_00a0: pop
    IL_00a1: ldsfld PerkManager.<>c PerkManager.<>c::<>9  /*0x04000C5C*/
    IL_00a6: ldftn int PerkManager.<>c::<Awake>b__201_0(Equippable)  /*0x060009AA*/
    IL_00ac: newobj void System.Func<Equippable, int>::.ctor(object,IntPtr)  /*0x0A000459*/
    IL_00b1: dup
    IL_00b2: stsfld Func<Equippable, int> PerkManager.<>c::<>9__201_0  /*0x04000C5D*/
    IL_00b7: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<Equippable,int>  /*0x2B00009B*/
    IL_00bc: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<Equippable>  /*0x2B00009C*/
    IL_00c1: stfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_00c6: ret

  .method PerkManager::IsEquipped(Equippable)  // token 0x060009A4 rva 0x2d10f attrs Public, Static, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000e
    IL_000c: ldc.i4.0
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldnull
    IL_0010: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0015: brfalse.s IL_0019
    IL_0017: ldc.i4.0
    IL_0018: ret
    IL_0019: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_001e: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_0023: ldarg.0
    IL_0024: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0029: ret

  .method PerkManager::SetEquipped(Equippable,bool)  // token 0x060009A5 rva 0x2d13c attrs Public, Static, HideBySig
    // code size 87 (0x57), max stack 2, init locals
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.1
    IL_000e: brfalse.s IL_0033
    IL_0010: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0015: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_001a: ldarg.0
    IL_001b: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0020: brtrue.s IL_0056
    IL_0022: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0027: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_002c: ldarg.0
    IL_002d: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_0032: ret
    IL_0033: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0038: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_003d: ldarg.0
    IL_003e: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0043: brfalse.s IL_0056
    IL_0045: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004a: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_004f: ldarg.0
    IL_0050: callvirt bool System.Collections.Generic.List<Equippable>::Remove(!0)  /*0x0A0003D3*/
    IL_0055: pop
    IL_0056: ret

  .method PerkManager::ClearAllEquipped()  // token 0x060009A6 rva 0x2d19f attrs Public, Static, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0012: ldfld List<Equippable> PerkManager::currentlyEquipped  /*0x04000BE7*/
    IL_0017: callvirt void System.Collections.Generic.List<Equippable>::Clear()  /*0x0A0003CB*/
    IL_001c: ret

  .method PerkManager::.ctor()  // token 0x060009A7 rva 0x2d1c0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 459 (0x1cb), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0006: stfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0011: stfld List<Equippable> PerkManager::countQuestsAsIncompleteWith  /*0x04000BE9*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.Dictionary<Equippable, int>::.ctor()  /*0x0A00045A*/
    IL_001c: stfld Dictionary<Equippable, int> PerkManager::metaLevelByPerk  /*0x04000BEA*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld int PerkManager::level  /*0x04000BEC*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4 4000
    IL_002e: stfld int PerkManager::xpNeededToProgressToNextLevelPastMaxMeta  /*0x04000BEE*/
    IL_0033: ldarg.0
    IL_0034: ldc.i4.1
    IL_0035: stfld int PerkManager::royalMint_startGoldBonus  /*0x04000BF1*/
    IL_003a: ldarg.0
    IL_003b: ldc.r4 0.5f
    IL_0040: stfld float PerkManager::ratGod_GoldModifyer  /*0x04000C02*/
    IL_0045: ldarg.0
    IL_0046: ldc.r4 0.5f
    IL_004b: stfld float PerkManager::warriorModeAllyDmgMulti  /*0x04000C04*/
    IL_0050: ldarg.0
    IL_0051: ldc.r4 2f
    IL_0056: stfld float PerkManager::warriorModeSelfDmgMultiMax  /*0x04000C05*/
    IL_005b: ldarg.0
    IL_005c: ldc.r4 1.5f
    IL_0061: stfld float PerkManager::commanderModeAllyDmgMulti  /*0x04000C07*/
    IL_0066: ldarg.0
    IL_0067: ldc.r4 0.5f
    IL_006c: stfld float PerkManager::commanderModeSelfDmgMulti  /*0x04000C08*/
    IL_0071: ldarg.0
    IL_0072: ldc.r4 1.5f
    IL_0077: stfld float PerkManager::glassCanon_dmgMulti  /*0x04000C0A*/
    IL_007c: ldarg.0
    IL_007d: ldc.r4 1.5f
    IL_0082: stfld float PerkManager::healingSpirits_healMulti  /*0x04000C0C*/
    IL_0087: ldarg.0
    IL_0088: ldc.r4 1.8f
    IL_008d: stfld float PerkManager::archerySkills_projectileSpeedMulti  /*0x04000C0E*/
    IL_0092: ldarg.0
    IL_0093: ldc.r4 0.75f
    IL_0098: stfld float PerkManager::iceMagic_AdditionalsSlowMutli  /*0x04000C10*/
    IL_009d: ldarg.0
    IL_009e: ldc.r4 2f
    IL_00a3: stfld float PerkManager::iceMagic_SlowDurationMulti  /*0x04000C11*/
    IL_00a8: ldarg.0
    IL_00a9: ldc.r4 1.3f
    IL_00ae: stfld float PerkManager::rangedResistence_AmountMulti  /*0x04000C13*/
    IL_00b3: ldarg.0
    IL_00b4: ldc.r4 1.3f
    IL_00b9: stfld float PerkManager::meleeResistence_AmountMulti  /*0x04000C15*/
    IL_00be: ldarg.0
    IL_00bf: ldc.r4 2f
    IL_00c4: stfld float PerkManager::powerTower_attackSpeedBonus  /*0x04000C16*/
    IL_00c9: ldarg.0
    IL_00ca: ldc.i4.s 10
    IL_00cc: stfld int PerkManager::treasureHunterGoldAmountWave1  /*0x04000C18*/
    IL_00d1: ldarg.0
    IL_00d2: ldc.i4.s 20
    IL_00d4: stfld int PerkManager::treasureHunterGoldAmountWave2  /*0x04000C19*/
    IL_00d9: ldarg.0
    IL_00da: ldc.i4.s 30
    IL_00dc: stfld int PerkManager::treasureHunterGoldAmountWave3  /*0x04000C1A*/
    IL_00e1: ldarg.0
    IL_00e2: ldc.r4 1.25f
    IL_00e7: stfld float PerkManager::cheeseGod_firstWavesSpawnSpeed  /*0x04000C1C*/
    IL_00ec: ldarg.0
    IL_00ed: ldc.r4 2f
    IL_00f2: stfld float PerkManager::cheeseGod_spawnAmountMulti  /*0x04000C1D*/
    IL_00f7: ldarg.0
    IL_00f8: ldc.i4.3
    IL_00f9: stfld int PerkManager::cheeseGod_affectedNights  /*0x04000C1E*/
    IL_00fe: ldarg.0
    IL_00ff: ldc.r4 2f
    IL_0104: stfld float PerkManager::godOfDeath_playerRespawnMultiplyer  /*0x04000C20*/
    IL_0109: ldarg.0
    IL_010a: ldc.r4 0.33f
    IL_010f: stfld float PerkManager::destructionGodHealthRegen  /*0x04000C22*/
    IL_0114: ldarg.0
    IL_0115: ldc.r4 0.2f
    IL_011a: stfld float PerkManager::phoenixGod_HealingPercentagePerSec  /*0x04000C24*/
    IL_011f: ldarg.0
    IL_0120: ldc.r4 40f
    IL_0125: stfld float PerkManager::phoenixGod_MaxHealingPerSec  /*0x04000C25*/
    IL_012a: ldarg.0
    IL_012b: ldc.r4 4f
    IL_0130: stfld float PerkManager::healthPotion_HealingPerSec  /*0x04000C27*/
    IL_0135: ldarg.0
    IL_0136: ldc.r4 0.75f
    IL_013b: stfld float PerkManager::antiAir_helathMultiplyer  /*0x04000C29*/
    IL_0140: ldarg.0
    IL_0141: ldc.r4 0.75f
    IL_0146: stfld float PerkManager::antiAir_damageMultiplyer  /*0x04000C2A*/
    IL_014b: ldarg.0
    IL_014c: ldc.r4 1.4f
    IL_0151: stfld float PerkManager::strongerHeros_healthMutli  /*0x04000C2C*/
    IL_0156: ldarg.0
    IL_0157: ldc.r4 1.4f
    IL_015c: stfld float PerkManager::strongerHeros_damageMulti  /*0x04000C2D*/
    IL_0161: ldarg.0
    IL_0162: ldc.r4 1.25f
    IL_0167: stfld float PerkManager::meleeDamage_multi  /*0x04000C2F*/
    IL_016c: ldarg.0
    IL_016d: ldc.r4 1.25f
    IL_0172: stfld float PerkManager::rangedDamage_multi  /*0x04000C31*/
    IL_0177: ldarg.0
    IL_0178: ldc.r4 0.8f
    IL_017d: stfld float PerkManager::prayWarGods_hpMulti  /*0x04000C33*/
    IL_0182: ldarg.0
    IL_0183: ldc.r4 0.8f
    IL_0188: stfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_018d: ldarg.0
    IL_018e: ldc.r4 0.65f
    IL_0193: stfld float PerkManager::spellScrollActiveCooldownMulti  /*0x04000C36*/
    IL_0198: ldarg.0
    IL_0199: ldc.r4 0.75f
    IL_019e: stfld float PerkManager::lightMaterialsCooldownMulti  /*0x04000C38*/
    IL_01a3: ldarg.0
    IL_01a4: ldc.r4 2f
    IL_01a9: stfld float PerkManager::pacifistAutoAttackMulti  /*0x04000C59*/
    IL_01ae: ldarg.0
    IL_01af: ldc.r4 2f
    IL_01b4: stfld float PerkManager::pacifistManualAttackMulti  /*0x04000C5A*/
    IL_01b9: ldarg.0
    IL_01ba: ldc.r4 2f
    IL_01bf: stfld float PerkManager::pacifistHpMulti  /*0x04000C5B*/
    IL_01c4: ldarg.0
    IL_01c5: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_01ca: ret

// ===== PerkManager/<>c  (token 0x020001DA) =====
  .method PerkManager.<>c::.cctor()  // token 0x060009A8 rva 0x2d397 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void PerkManager.<>c::.ctor()  /*0x060009A9*/
    IL_0005: stsfld PerkManager.<>c PerkManager.<>c::<>9  /*0x04000C5C*/
    IL_000a: ret

  .method PerkManager.<>c::.ctor()  // token 0x060009A9 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method PerkManager.<>c::<Awake>b__201_0(Equippable)  // token 0x060009AA rva 0x2d3a3 attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt int Equippable::get_sortingValue()  /*0x06000B53*/
    IL_0006: ret

