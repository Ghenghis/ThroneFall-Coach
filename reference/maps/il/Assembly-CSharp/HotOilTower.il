// ===== HotOilTower  (token 0x02000191) =====
  .method HotOilTower::Start()  // token 0x0600080B rva 0x27919 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0006: stfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_000b: ldarg.0
    IL_000c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0011: stfld TagManager HotOilTower::tagManager  /*0x04000A27*/
    IL_0016: ret

  .method HotOilTower::ReduceCooldownBy(float)  // token 0x0600080C rva 0x27931 attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_0007: ldarg.1
    IL_0008: sub
    IL_0009: stfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_000e: ret

  .method HotOilTower::Update()  // token 0x0600080D rva 0x27944 attrs Private, HideBySig
    // code size 219 (0xdb), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule, [1] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_0012: ldarg.0
    IL_0013: ldfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_007e
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_0026: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002b: sub
    IL_002c: stfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_0031: ldarg.0
    IL_0032: ldfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_0037: ldc.r4 0f
    IL_003c: bgt.un.s IL_007e
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld int HotOilTower::ticksRemaining  /*0x04000A2A*/
    IL_0045: ldc.i4.1
    IL_0046: sub
    IL_0047: stfld int HotOilTower::ticksRemaining  /*0x04000A2A*/
    IL_004c: ldarg.0
    IL_004d: ldfld int HotOilTower::ticksRemaining  /*0x04000A2A*/
    IL_0052: ldc.i4.0
    IL_0053: bge.s IL_006b
    IL_0055: ldarg.0
    IL_0056: ldfld ParticleSystem HotOilTower::hotOilGround  /*0x04000A1C*/
    IL_005b: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_0060: stloc.0
    IL_0061: ldloca.s 0
    IL_0063: ldc.i4.0
    IL_0064: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0069: br.s IL_007e
    IL_006b: ldarg.0
    IL_006c: call bool HotOilTower::DamageTick()  /*0x0600080E*/
    IL_0071: pop
    IL_0072: ldarg.0
    IL_0073: ldarg.0
    IL_0074: ldfld float HotOilTower::hotOilGroundBurnTickDuration  /*0x04000A1D*/
    IL_0079: stfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_007e: ldarg.0
    IL_007f: ldfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_0084: ldc.r4 0f
    IL_0089: bgt.un.s IL_00da
    IL_008b: ldarg.0
    IL_008c: call bool HotOilTower::DamageTick()  /*0x0600080E*/
    IL_0091: brfalse.s IL_00ce
    IL_0093: ldarg.0
    IL_0094: ldarg.0
    IL_0095: ldfld float HotOilTower::attackCooldown  /*0x04000A1F*/
    IL_009a: stfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_009f: ldarg.0
    IL_00a0: ldarg.0
    IL_00a1: ldfld float HotOilTower::hotOilGroundBurnTickDuration  /*0x04000A1D*/
    IL_00a6: stfld float HotOilTower::timeTillTickEnds  /*0x04000A29*/
    IL_00ab: ldarg.0
    IL_00ac: ldarg.0
    IL_00ad: ldfld int HotOilTower::hotOilGroundBurnTicks  /*0x04000A1E*/
    IL_00b2: ldc.i4.1
    IL_00b3: sub
    IL_00b4: stfld int HotOilTower::ticksRemaining  /*0x04000A2A*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld ParticleSystem HotOilTower::hotOilGround  /*0x04000A1C*/
    IL_00bf: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_00c4: stloc.1
    IL_00c5: ldloca.s 1
    IL_00c7: ldc.i4.1
    IL_00c8: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_00cd: ret
    IL_00ce: ldarg.0
    IL_00cf: ldarg.0
    IL_00d0: ldfld float HotOilTower::checkRate  /*0x04000A20*/
    IL_00d5: stfld float HotOilTower::cooldown  /*0x04000A26*/
    IL_00da: ret

  .method HotOilTower::DamageTick()  // token 0x0600080E rva 0x27a2c attrs Private, HideBySig
    // code size 206 (0xce), max stack 5, init locals
    .locals ([0] bool, [1] int, [2] float)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld TagManager HotOilTower::tagManager  /*0x04000A27*/
    IL_0008: ldarg.0
    IL_0009: ldfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_000e: ldarg.0
    IL_000f: ldfld List<TagManager.ETag> HotOilTower::mustHaveTags  /*0x04000A23*/
    IL_0014: ldarg.0
    IL_0015: ldfld List<TagManager.ETag> HotOilTower::mayNotHaveTags  /*0x04000A24*/
    IL_001a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001f: ldc.i4.0
    IL_0020: stloc.1
    IL_0021: br IL_00bb
    IL_0026: ldarg.0
    IL_0027: ldfld TagManager HotOilTower::tagManager  /*0x04000A27*/
    IL_002c: ldarg.0
    IL_002d: ldfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_0032: ldloc.1
    IL_0033: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0038: ldarg.0
    IL_0039: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0048: ldarg.0
    IL_0049: ldfld float HotOilTower::range  /*0x04000A21*/
    IL_004e: bgt.s IL_00b7
    IL_0050: ldc.i4.1
    IL_0051: stloc.0
    IL_0052: ldarg.0
    IL_0053: ldfld BlacksmithUpgrades HotOilTower::blacksmithUpgrages  /*0x04000A2B*/
    IL_0058: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_005d: brtrue.s IL_006a
    IL_005f: ldarg.0
    IL_0060: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0065: stfld BlacksmithUpgrades HotOilTower::blacksmithUpgrages  /*0x04000A2B*/
    IL_006a: ldarg.0
    IL_006b: ldfld BlacksmithUpgrades HotOilTower::blacksmithUpgrages  /*0x04000A2B*/
    IL_0070: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0075: stloc.2
    IL_0076: ldarg.0
    IL_0077: ldfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_007c: ldloc.1
    IL_007d: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0082: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0087: ldarg.0
    IL_0088: ldfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_008d: ldloc.1
    IL_008e: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0093: ldarg.0
    IL_0094: ldfld List<DamageModifyer> HotOilTower::damageModifyers  /*0x04000A22*/
    IL_0099: ldarg.0
    IL_009a: ldfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_009f: ldloc.2
    IL_00a0: mul
    IL_00a1: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld int HotOilTower::hotOilGroundBurnTicks  /*0x04000A1E*/
    IL_00ac: conv.r4
    IL_00ad: div
    IL_00ae: ldnull
    IL_00af: ldc.i4.0
    IL_00b0: ldc.i4.1
    IL_00b1: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00b6: pop
    IL_00b7: ldloc.1
    IL_00b8: ldc.i4.1
    IL_00b9: add
    IL_00ba: stloc.1
    IL_00bb: ldloc.1
    IL_00bc: ldarg.0
    IL_00bd: ldfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_00c2: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00c7: blt IL_0026
    IL_00cc: ldloc.0
    IL_00cd: ret

  .method HotOilTower::.ctor()  // token 0x0600080F rva 0x27b08 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 91 (0x5b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float HotOilTower::hotOilGroundBurnTickDuration  /*0x04000A1D*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.5
    IL_000d: stfld int HotOilTower::hotOilGroundBurnTicks  /*0x04000A1E*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 5f
    IL_0018: stfld float HotOilTower::attackCooldown  /*0x04000A1F*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 1f
    IL_0023: stfld float HotOilTower::checkRate  /*0x04000A20*/
    IL_0028: ldarg.0
    IL_0029: ldc.r4 3.5f
    IL_002e: stfld float HotOilTower::range  /*0x04000A21*/
    IL_0033: ldarg.0
    IL_0034: newobj void System.Collections.Generic.List<DamageModifyer>::.ctor()  /*0x0A000211*/
    IL_0039: stfld List<DamageModifyer> HotOilTower::damageModifyers  /*0x04000A22*/
    IL_003e: ldarg.0
    IL_003f: ldc.r4 1f
    IL_0044: stfld float HotOilTower::DamageMultiplyer  /*0x04000A25*/
    IL_0049: ldarg.0
    IL_004a: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_004f: stfld List<TaggedObject> HotOilTower::foundTaggedObjects  /*0x04000A28*/
    IL_0054: ldarg.0
    IL_0055: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_005a: ret

