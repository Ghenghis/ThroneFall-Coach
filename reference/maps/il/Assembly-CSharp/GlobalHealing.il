// ===== GlobalHealing  (token 0x0200018B) =====
  .method GlobalHealing::Start()  // token 0x060007F9 rva 0x270ac attrs Private, HideBySig
    // code size 132 (0x84), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager GlobalHealing::tagManager  /*0x040009FB*/
    IL_000b: ldarg.0
    IL_000c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0011: callvirt bool PerkManager::get_HealthPotionsActive()  /*0x0600098C*/
    IL_0016: stfld bool GlobalHealing::healPlayerUntisPerkActive  /*0x040009F4*/
    IL_001b: ldarg.0
    IL_001c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0021: callvirt bool PerkManager::get_TauntThePhoenixGodActive()  /*0x0600098B*/
    IL_0026: stfld bool GlobalHealing::healEnemyUnitsMutatorActive  /*0x040009F5*/
    IL_002b: ldarg.0
    IL_002c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0031: ldfld float PerkManager::healthPotion_HealingPerSec  /*0x04000C27*/
    IL_0036: ldc.r4 2f
    IL_003b: mul
    IL_003c: stfld float GlobalHealing::healPlayerUnitsPerHeal  /*0x040009F6*/
    IL_0041: ldarg.0
    IL_0042: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0047: ldfld float PerkManager::phoenixGod_HealingPercentagePerSec  /*0x04000C24*/
    IL_004c: ldc.r4 2f
    IL_0051: mul
    IL_0052: stfld float GlobalHealing::healEnemyUnitsPerHealPercentage  /*0x040009F7*/
    IL_0057: ldarg.0
    IL_0058: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005d: ldfld float PerkManager::phoenixGod_MaxHealingPerSec  /*0x04000C25*/
    IL_0062: ldc.r4 2f
    IL_0067: mul
    IL_0068: stfld float GlobalHealing::maxHealingPerEnemy  /*0x040009F8*/
    IL_006d: ldarg.0
    IL_006e: ldfld bool GlobalHealing::healPlayerUntisPerkActive  /*0x040009F4*/
    IL_0073: brtrue.s IL_0083
    IL_0075: ldarg.0
    IL_0076: ldfld bool GlobalHealing::healEnemyUnitsMutatorActive  /*0x040009F5*/
    IL_007b: brtrue.s IL_0083
    IL_007d: ldarg.0
    IL_007e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0083: ret

  .method GlobalHealing::Update()  // token 0x060007FA rva 0x2713c attrs Private, HideBySig
    // code size 331 (0x14b), max stack 4, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool GlobalHealing::healPlayerUntisPerkActive  /*0x040009F4*/
    IL_0006: brfalse IL_0097
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_0012: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0017: sub
    IL_0018: stfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_001d: ldarg.0
    IL_001e: ldfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_0023: ldc.r4 0f
    IL_0028: bgt.un.s IL_0097
    IL_002a: ldarg.0
    IL_002b: ldarg.0
    IL_002c: ldfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_0031: ldc.r4 2f
    IL_0036: add
    IL_0037: stfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_003c: ldarg.0
    IL_003d: ldfld TagManager GlobalHealing::tagManager  /*0x040009FB*/
    IL_0042: ldarg.0
    IL_0043: ldfld List<TaggedObject> GlobalHealing::taggedObjectsFound  /*0x04000A00*/
    IL_0048: ldarg.0
    IL_0049: ldfld List<TagManager.ETag> GlobalHealing::playerUnitsMustHaveTags  /*0x040009FC*/
    IL_004e: ldarg.0
    IL_004f: ldfld List<TagManager.ETag> GlobalHealing::playerUnitsMayNotHaveTags  /*0x040009FD*/
    IL_0054: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0059: ldarg.0
    IL_005a: ldfld List<TaggedObject> GlobalHealing::taggedObjectsFound  /*0x04000A00*/
    IL_005f: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0064: stloc.0
    IL_0065: br.s IL_007e
    IL_0067: ldloca.s 0
    IL_0069: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_006e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0073: ldarg.0
    IL_0074: ldfld float GlobalHealing::healPlayerUnitsPerHeal  /*0x040009F6*/
    IL_0079: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_007e: ldloca.s 0
    IL_0080: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0085: brtrue.s IL_0067
    IL_0087: leave.s IL_0097
    IL_0089: ldloca.s 0
    IL_008b: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0091: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0096: endfinally
    IL_0097: ldarg.0
    IL_0098: ldfld bool GlobalHealing::healEnemyUnitsMutatorActive  /*0x040009F5*/
    IL_009d: brfalse IL_014a
    IL_00a2: ldarg.0
    IL_00a3: ldarg.0
    IL_00a4: ldfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_00a9: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00ae: sub
    IL_00af: stfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_00ba: ldc.r4 0f
    IL_00bf: bgt.un IL_014a
    IL_00c4: ldarg.0
    IL_00c5: ldarg.0
    IL_00c6: ldfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_00cb: ldc.r4 2f
    IL_00d0: add
    IL_00d1: stfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld TagManager GlobalHealing::tagManager  /*0x040009FB*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld List<TaggedObject> GlobalHealing::taggedObjectsFound  /*0x04000A00*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld List<TagManager.ETag> GlobalHealing::enemyUnitsMustHaveTags  /*0x040009FE*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld List<TagManager.ETag> GlobalHealing::enemyUnitsMayNotHaveTags  /*0x040009FF*/
    IL_00ee: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_00f3: ldarg.0
    IL_00f4: ldfld List<TaggedObject> GlobalHealing::taggedObjectsFound  /*0x04000A00*/
    IL_00f9: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_00fe: stloc.0
    IL_00ff: br.s IL_0131
    IL_0101: ldloca.s 0
    IL_0103: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0108: stloc.1
    IL_0109: ldloc.1
    IL_010a: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_010f: ldarg.0
    IL_0110: ldfld float GlobalHealing::healEnemyUnitsPerHealPercentage  /*0x040009F7*/
    IL_0115: ldloc.1
    IL_0116: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_011b: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0120: mul
    IL_0121: ldarg.0
    IL_0122: ldfld float GlobalHealing::maxHealingPerEnemy  /*0x040009F8*/
    IL_0127: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_012c: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0131: ldloca.s 0
    IL_0133: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0138: brtrue.s IL_0101
    IL_013a: leave.s IL_014a
    IL_013c: ldloca.s 0
    IL_013e: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0144: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0149: endfinally
    IL_014a: ret
    .try IL_0065-IL_0089 finally handler IL_0089-IL_0097
    .try IL_00ff-IL_013c finally handler IL_013c-IL_014a

  .method GlobalHealing::.ctor()  // token 0x060007FB rva 0x272b0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float GlobalHealing::healPlayerUnitsCooldown  /*0x040009F9*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.1f
    IL_0011: stfld float GlobalHealing::healEnemyUnitsCooldown  /*0x040009FA*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> GlobalHealing::taggedObjectsFound  /*0x04000A00*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

