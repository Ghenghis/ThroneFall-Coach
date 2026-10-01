// ===== DamagePlayerWhenEnteringRange  (token 0x020000A9) =====
  .method DamagePlayerWhenEnteringRange::Start()  // token 0x0600039D rva 0x10298 attrs Private, HideBySig
    // code size 221 (0xdd), max stack 3, init locals
    .locals ([0] PerkManager)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_000b: ldc.i4.0
    IL_000c: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0011: stfld TaggedObject DamagePlayerWhenEnteringRange::playerTaggedObj  /*0x040004AF*/
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld TaggedObject DamagePlayerWhenEnteringRange::playerTaggedObj  /*0x040004AF*/
    IL_001d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0022: stfld Transform DamagePlayerWhenEnteringRange::transformPlayer  /*0x040004B0*/
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld TaggedObject DamagePlayerWhenEnteringRange::playerTaggedObj  /*0x040004AF*/
    IL_002e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0033: stfld Hp DamagePlayerWhenEnteringRange::playerHp  /*0x040004B1*/
    IL_0038: ldarg.0
    IL_0039: ldarg.0
    IL_003a: ldfld Transform DamagePlayerWhenEnteringRange::transformPlayer  /*0x040004B0*/
    IL_003f: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerMovement>  /*0x2B00002D*/
    IL_0044: stfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_0049: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_004e: stloc.0
    IL_004f: ldloc.0
    IL_0050: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0055: ldloc.0
    IL_0056: ldfld Equippable PerkManager::tigerGodPerk  /*0x04000BFB*/
    IL_005b: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0060: brfalse.s IL_009b
    IL_0062: ldarg.0
    IL_0063: ldarg.0
    IL_0064: ldfld float DamagePlayerWhenEnteringRange::damageWhenEntering  /*0x040004A9*/
    IL_0069: ldloc.0
    IL_006a: ldfld float PerkManager::tauntTheTiger_damageMultiplyer  /*0x04000BFA*/
    IL_006f: mul
    IL_0070: stfld float DamagePlayerWhenEnteringRange::damageWhenEntering  /*0x040004A9*/
    IL_0075: ldarg.0
    IL_0076: ldarg.0
    IL_0077: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileMoving  /*0x040004AA*/
    IL_007c: ldloc.0
    IL_007d: ldfld float PerkManager::tauntTheTiger_damageMultiplyer  /*0x04000BFA*/
    IL_0082: mul
    IL_0083: stfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileMoving  /*0x040004AA*/
    IL_0088: ldarg.0
    IL_0089: ldarg.0
    IL_008a: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileSprinting  /*0x040004AB*/
    IL_008f: ldloc.0
    IL_0090: ldfld float PerkManager::tauntTheTiger_damageMultiplyer  /*0x04000BFA*/
    IL_0095: mul
    IL_0096: stfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileSprinting  /*0x040004AB*/
    IL_009b: ldloc.0
    IL_009c: callvirt bool PerkManager::get_PrayToWarGodsActive()  /*0x06000991*/
    IL_00a1: brfalse.s IL_00dc
    IL_00a3: ldarg.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld float DamagePlayerWhenEnteringRange::damageWhenEntering  /*0x040004A9*/
    IL_00aa: ldloc.0
    IL_00ab: ldfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_00b0: mul
    IL_00b1: stfld float DamagePlayerWhenEnteringRange::damageWhenEntering  /*0x040004A9*/
    IL_00b6: ldarg.0
    IL_00b7: ldarg.0
    IL_00b8: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileMoving  /*0x040004AA*/
    IL_00bd: ldloc.0
    IL_00be: ldfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_00c3: mul
    IL_00c4: stfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileMoving  /*0x040004AA*/
    IL_00c9: ldarg.0
    IL_00ca: ldarg.0
    IL_00cb: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileSprinting  /*0x040004AB*/
    IL_00d0: ldloc.0
    IL_00d1: ldfld float PerkManager::prayWarGods_dmgMulti  /*0x04000C34*/
    IL_00d6: mul
    IL_00d7: stfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileSprinting  /*0x040004AB*/
    IL_00dc: ret

  .method DamagePlayerWhenEnteringRange::Update()  // token 0x0600039E rva 0x10384 attrs Private, HideBySig
    // code size 125 (0x7d), max stack 3, init locals
    .locals ([0] Vector3, [1] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform DamagePlayerWhenEnteringRange::transformPlayer  /*0x040004B0*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_001b: ldarg.0
    IL_001c: ldfld float DamagePlayerWhenEnteringRange::range  /*0x040004AC*/
    IL_0021: bgt.un.s IL_0075
    IL_0023: ldarg.0
    IL_0024: ldfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_0029: callvirt Vector3 PlayerMovement::get_Velocity()  /*0x06000C26*/
    IL_002e: ldarg.0
    IL_002f: ldfld Transform DamagePlayerWhenEnteringRange::transformPlayer  /*0x040004B0*/
    IL_0034: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0039: ldarg.0
    IL_003a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0044: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0049: stloc.1
    IL_004a: ldloca.s 1
    IL_004c: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0051: stloc.0
    IL_0052: ldloc.0
    IL_0053: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_0058: ldc.r4 0f
    IL_005d: bge.un.s IL_006d
    IL_005f: ldarg.0
    IL_0060: ldfld bool DamagePlayerWhenEnteringRange::playerWasLastOutsideRange  /*0x040004B2*/
    IL_0065: brfalse.s IL_006d
    IL_0067: ldarg.0
    IL_0068: call void DamagePlayerWhenEnteringRange::ApplyDamage()  /*0x0600039F*/
    IL_006d: ldarg.0
    IL_006e: ldc.i4.0
    IL_006f: stfld bool DamagePlayerWhenEnteringRange::playerWasLastOutsideRange  /*0x040004B2*/
    IL_0074: ret
    IL_0075: ldarg.0
    IL_0076: ldc.i4.1
    IL_0077: stfld bool DamagePlayerWhenEnteringRange::playerWasLastOutsideRange  /*0x040004B2*/
    IL_007c: ret

  .method DamagePlayerWhenEnteringRange::ApplyDamage()  // token 0x0600039F rva 0x10410 attrs Private, HideBySig
    // code size 107 (0x6b), max stack 5, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld float DamagePlayerWhenEnteringRange::damageWhenEntering  /*0x040004A9*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_000d: callvirt bool PlayerMovement::get_Moving()  /*0x06000C1D*/
    IL_0012: brfalse.s IL_002e
    IL_0014: ldarg.0
    IL_0015: ldfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_001a: ldarg.0
    IL_001b: ldfld float DamagePlayerWhenEnteringRange::slowPlayerFor  /*0x040004AD*/
    IL_0020: callvirt void PlayerMovement::Slow(float)  /*0x06000C25*/
    IL_0025: ldloc.0
    IL_0026: ldarg.0
    IL_0027: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileMoving  /*0x040004AA*/
    IL_002c: add
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_0034: callvirt bool PlayerMovement::get_Sprinting()  /*0x06000C1E*/
    IL_0039: brfalse.s IL_0055
    IL_003b: ldarg.0
    IL_003c: ldfld PlayerMovement DamagePlayerWhenEnteringRange::playerMovement  /*0x040004B3*/
    IL_0041: ldarg.0
    IL_0042: ldfld float DamagePlayerWhenEnteringRange::slowPlayerFor  /*0x040004AD*/
    IL_0047: callvirt void PlayerMovement::Slow(float)  /*0x06000C25*/
    IL_004c: ldloc.0
    IL_004d: ldarg.0
    IL_004e: ldfld float DamagePlayerWhenEnteringRange::addedDamageWhenEnteringWhileSprinting  /*0x040004AB*/
    IL_0053: add
    IL_0054: stloc.0
    IL_0055: ldarg.0
    IL_0056: ldfld Hp DamagePlayerWhenEnteringRange::playerHp  /*0x040004B1*/
    IL_005b: ldloc.0
    IL_005c: ldarg.0
    IL_005d: ldfld TaggedObject DamagePlayerWhenEnteringRange::myTaggedObject  /*0x040004AE*/
    IL_0062: ldc.i4.0
    IL_0063: ldc.i4.1
    IL_0064: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0069: pop
    IL_006a: ret

  .method DamagePlayerWhenEnteringRange::.ctor()  // token 0x060003A0 rva 0x10487 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool DamagePlayerWhenEnteringRange::playerWasLastOutsideRange  /*0x040004B2*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

