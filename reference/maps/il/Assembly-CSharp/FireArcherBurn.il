// ===== FireArcherBurn  (token 0x02000166) =====
  .method FireArcherBurn::Start()  // token 0x0600074D rva 0x24b9c attrs Private, HideBySig
    // code size 80 (0x50), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0006: stfld TagManager FireArcherBurn::tagManager  /*0x04000938*/
    IL_000b: ldarg.0
    IL_000c: call bool FireArcherBurn::DamageTick()  /*0x0600074F*/
    IL_0011: brfalse.s IL_004f
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld float FireArcherBurn::hotOilGroundBurnTickDuration  /*0x04000931*/
    IL_001a: stfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld int FireArcherBurn::hotOilGroundBurnTicks  /*0x04000932*/
    IL_0026: ldc.i4.1
    IL_0027: sub
    IL_0028: stfld int FireArcherBurn::ticksRemaining  /*0x0400093B*/
    IL_002d: ldarg.0
    IL_002e: ldfld ParticleSystem FireArcherBurn::hotOilGround  /*0x04000930*/
    IL_0033: ldnull
    IL_0034: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0039: brfalse.s IL_004f
    IL_003b: ldarg.0
    IL_003c: ldfld ParticleSystem FireArcherBurn::hotOilGround  /*0x04000930*/
    IL_0041: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_0046: stloc.0
    IL_0047: ldloca.s 0
    IL_0049: ldc.i4.1
    IL_004a: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_004f: ret

  .method FireArcherBurn::Update()  // token 0x0600074E rva 0x24bf8 attrs Private, HideBySig
    // code size 165 (0xa5), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_007a
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_001f: ldarg.0
    IL_0020: ldfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_0025: ldc.r4 0f
    IL_002a: bgt.un.s IL_007a
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld int FireArcherBurn::ticksRemaining  /*0x0400093B*/
    IL_0033: ldc.i4.1
    IL_0034: sub
    IL_0035: stfld int FireArcherBurn::ticksRemaining  /*0x0400093B*/
    IL_003a: ldarg.0
    IL_003b: ldfld int FireArcherBurn::ticksRemaining  /*0x0400093B*/
    IL_0040: ldc.i4.0
    IL_0041: bge.s IL_0067
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem FireArcherBurn::hotOilGround  /*0x04000930*/
    IL_0049: ldnull
    IL_004a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_004f: brfalse.s IL_007a
    IL_0051: ldarg.0
    IL_0052: ldfld ParticleSystem FireArcherBurn::hotOilGround  /*0x04000930*/
    IL_0057: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_005c: stloc.0
    IL_005d: ldloca.s 0
    IL_005f: ldc.i4.0
    IL_0060: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0065: br.s IL_007a
    IL_0067: ldarg.0
    IL_0068: call bool FireArcherBurn::DamageTick()  /*0x0600074F*/
    IL_006d: pop
    IL_006e: ldarg.0
    IL_006f: ldarg.0
    IL_0070: ldfld float FireArcherBurn::hotOilGroundBurnTickDuration  /*0x04000931*/
    IL_0075: stfld float FireArcherBurn::timeTillTickEnds  /*0x0400093A*/
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: ldfld float FireArcherBurn::timeTillSelfDestroy  /*0x04000937*/
    IL_0081: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0086: sub
    IL_0087: stfld float FireArcherBurn::timeTillSelfDestroy  /*0x04000937*/
    IL_008c: ldarg.0
    IL_008d: ldfld float FireArcherBurn::timeTillSelfDestroy  /*0x04000937*/
    IL_0092: ldc.r4 0f
    IL_0097: bgt.un.s IL_00a4
    IL_0099: ldarg.0
    IL_009a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_009f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00a4: ret

  .method FireArcherBurn::DamageTick()  // token 0x0600074F rva 0x24cac attrs Private, HideBySig
    // code size 162 (0xa2), max stack 5, init locals
    .locals ([0] bool, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld TagManager FireArcherBurn::tagManager  /*0x04000938*/
    IL_0008: ldarg.0
    IL_0009: ldfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_000e: ldarg.0
    IL_000f: ldfld List<TagManager.ETag> FireArcherBurn::mustHaveTags  /*0x04000935*/
    IL_0014: ldarg.0
    IL_0015: ldfld List<TagManager.ETag> FireArcherBurn::mayNotHaveTags  /*0x04000936*/
    IL_001a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001f: ldc.i4.0
    IL_0020: stloc.1
    IL_0021: br.s IL_0092
    IL_0023: ldarg.0
    IL_0024: ldfld TagManager FireArcherBurn::tagManager  /*0x04000938*/
    IL_0029: ldarg.0
    IL_002a: ldfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_002f: ldloc.1
    IL_0030: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0035: ldarg.0
    IL_0036: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0040: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0045: ldarg.0
    IL_0046: ldfld float FireArcherBurn::range  /*0x04000933*/
    IL_004b: bgt.s IL_008e
    IL_004d: ldc.i4.1
    IL_004e: stloc.0
    IL_004f: ldarg.0
    IL_0050: ldfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_0055: ldloc.1
    IL_0056: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_005b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0060: ldarg.0
    IL_0061: ldfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_0066: ldloc.1
    IL_0067: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_006c: ldarg.0
    IL_006d: ldfld List<DamageModifyer> FireArcherBurn::damageModifyers  /*0x04000934*/
    IL_0072: ldarg.0
    IL_0073: ldfld float WeaponDamageDealer::damageMultiplyer  /*0x0400183B*/
    IL_0078: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_007d: ldarg.0
    IL_007e: ldfld int FireArcherBurn::hotOilGroundBurnTicks  /*0x04000932*/
    IL_0083: conv.r4
    IL_0084: div
    IL_0085: ldnull
    IL_0086: ldc.i4.0
    IL_0087: ldc.i4.1
    IL_0088: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_008d: pop
    IL_008e: ldloc.1
    IL_008f: ldc.i4.1
    IL_0090: add
    IL_0091: stloc.1
    IL_0092: ldloc.1
    IL_0093: ldarg.0
    IL_0094: ldfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_0099: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_009e: blt.s IL_0023
    IL_00a0: ldloc.0
    IL_00a1: ret

  .method FireArcherBurn::.ctor()  // token 0x06000750 rva 0x24d5c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float FireArcherBurn::hotOilGroundBurnTickDuration  /*0x04000931*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.5
    IL_000d: stfld int FireArcherBurn::hotOilGroundBurnTicks  /*0x04000932*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 3.5f
    IL_0018: stfld float FireArcherBurn::range  /*0x04000933*/
    IL_001d: ldarg.0
    IL_001e: newobj void System.Collections.Generic.List<DamageModifyer>::.ctor()  /*0x0A000211*/
    IL_0023: stfld List<DamageModifyer> FireArcherBurn::damageModifyers  /*0x04000934*/
    IL_0028: ldarg.0
    IL_0029: ldc.r4 5f
    IL_002e: stfld float FireArcherBurn::timeTillSelfDestroy  /*0x04000937*/
    IL_0033: ldarg.0
    IL_0034: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0039: stfld List<TaggedObject> FireArcherBurn::foundTaggedObjects  /*0x04000939*/
    IL_003e: ldarg.0
    IL_003f: call void WeaponDamageDealer::.ctor()  /*0x060013D4*/
    IL_0044: ret

