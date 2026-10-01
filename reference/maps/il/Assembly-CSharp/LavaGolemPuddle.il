// ===== LavaGolemPuddle  (token 0x020000E5) =====
  .method LavaGolemPuddle::OnEnable()  // token 0x060004DD rva 0x154e4 attrs Private, HideBySig
    // code size 86 (0x56), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager LavaGolemPuddle::tagManager  /*0x0400064E*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0014: stfld TagManager LavaGolemPuddle::tagManager  /*0x0400064E*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float LavaGolemPuddle::lavaGroundBurnTickDuration  /*0x04000648*/
    IL_0020: stfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_0025: ldarg.0
    IL_0026: ldarg.0
    IL_0027: ldfld int LavaGolemPuddle::lavaGroundBurnTicks  /*0x04000649*/
    IL_002c: ldc.i4.1
    IL_002d: sub
    IL_002e: stfld int LavaGolemPuddle::ticksRemaining  /*0x04000651*/
    IL_0033: ldarg.0
    IL_0034: ldfld ParticleSystem LavaGolemPuddle::lavaGround  /*0x04000647*/
    IL_0039: ldnull
    IL_003a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003f: brfalse.s IL_0055
    IL_0041: ldarg.0
    IL_0042: ldfld ParticleSystem LavaGolemPuddle::lavaGround  /*0x04000647*/
    IL_0047: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_004c: stloc.0
    IL_004d: ldloca.s 0
    IL_004f: ldc.i4.1
    IL_0050: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0055: ret

  .method LavaGolemPuddle::Update()  // token 0x060004DE rva 0x15548 attrs Private, HideBySig
    // code size 122 (0x7a), max stack 3, init locals
    .locals ([0] ParticleSystem.EmissionModule)
    IL_0000: ldarg.0
    IL_0001: ldfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_0079
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_001f: ldarg.0
    IL_0020: ldfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_0025: ldc.r4 0f
    IL_002a: bgt.un.s IL_0079
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld int LavaGolemPuddle::ticksRemaining  /*0x04000651*/
    IL_0033: ldc.i4.1
    IL_0034: sub
    IL_0035: stfld int LavaGolemPuddle::ticksRemaining  /*0x04000651*/
    IL_003a: ldarg.0
    IL_003b: ldfld int LavaGolemPuddle::ticksRemaining  /*0x04000651*/
    IL_0040: ldc.i4.0
    IL_0041: bge.s IL_0066
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem LavaGolemPuddle::lavaGround  /*0x04000647*/
    IL_0049: ldnull
    IL_004a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_004f: brfalse.s IL_0079
    IL_0051: ldarg.0
    IL_0052: ldfld ParticleSystem LavaGolemPuddle::lavaGround  /*0x04000647*/
    IL_0057: callvirt ParticleSystem.EmissionModule UnityEngine.ParticleSystem::get_emission()  /*0x0A00020F*/
    IL_005c: stloc.0
    IL_005d: ldloca.s 0
    IL_005f: ldc.i4.0
    IL_0060: call void UnityEngine.ParticleSystem.EmissionModule::set_enabled(bool)  /*0x0A000210*/
    IL_0065: ret
    IL_0066: ldarg.0
    IL_0067: call bool LavaGolemPuddle::DamageTick()  /*0x060004DF*/
    IL_006c: pop
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: ldfld float LavaGolemPuddle::lavaGroundBurnTickDuration  /*0x04000648*/
    IL_0074: stfld float LavaGolemPuddle::timeTillTickEnds  /*0x04000650*/
    IL_0079: ret

  .method LavaGolemPuddle::DamageTick()  // token 0x060004DF rva 0x155d0 attrs Private, HideBySig
    // code size 162 (0xa2), max stack 5, init locals
    .locals ([0] bool, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld TagManager LavaGolemPuddle::tagManager  /*0x0400064E*/
    IL_0008: ldarg.0
    IL_0009: ldfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_000e: ldarg.0
    IL_000f: ldfld List<TagManager.ETag> LavaGolemPuddle::mustHaveTags  /*0x0400064C*/
    IL_0014: ldarg.0
    IL_0015: ldfld List<TagManager.ETag> LavaGolemPuddle::mayNotHaveTags  /*0x0400064D*/
    IL_001a: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_001f: ldc.i4.0
    IL_0020: stloc.1
    IL_0021: br.s IL_0092
    IL_0023: ldarg.0
    IL_0024: ldfld TagManager LavaGolemPuddle::tagManager  /*0x0400064E*/
    IL_0029: ldarg.0
    IL_002a: ldfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_002f: ldloc.1
    IL_0030: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0035: ldarg.0
    IL_0036: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0040: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_0045: ldarg.0
    IL_0046: ldfld float LavaGolemPuddle::range  /*0x0400064A*/
    IL_004b: bgt.s IL_008e
    IL_004d: ldc.i4.1
    IL_004e: stloc.0
    IL_004f: ldarg.0
    IL_0050: ldfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_0055: ldloc.1
    IL_0056: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_005b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0060: ldarg.0
    IL_0061: ldfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_0066: ldloc.1
    IL_0067: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_006c: ldarg.0
    IL_006d: ldfld List<DamageModifyer> LavaGolemPuddle::damageModifyers  /*0x0400064B*/
    IL_0072: ldarg.0
    IL_0073: ldfld float WeaponDamageDealer::damageMultiplyer  /*0x0400183B*/
    IL_0078: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_007d: ldarg.0
    IL_007e: ldfld int LavaGolemPuddle::lavaGroundBurnTicks  /*0x04000649*/
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
    IL_0094: ldfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_0099: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_009e: blt.s IL_0023
    IL_00a0: ldloc.0
    IL_00a1: ret

  .method LavaGolemPuddle::.ctor()  // token 0x060004E0 rva 0x1567e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float LavaGolemPuddle::lavaGroundBurnTickDuration  /*0x04000648*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.5
    IL_000d: stfld int LavaGolemPuddle::lavaGroundBurnTicks  /*0x04000649*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 3.5f
    IL_0018: stfld float LavaGolemPuddle::range  /*0x0400064A*/
    IL_001d: ldarg.0
    IL_001e: newobj void System.Collections.Generic.List<DamageModifyer>::.ctor()  /*0x0A000211*/
    IL_0023: stfld List<DamageModifyer> LavaGolemPuddle::damageModifyers  /*0x0400064B*/
    IL_0028: ldarg.0
    IL_0029: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_002e: stfld List<TaggedObject> LavaGolemPuddle::foundTaggedObjects  /*0x0400064F*/
    IL_0033: ldarg.0
    IL_0034: call void WeaponDamageDealer::.ctor()  /*0x060013D4*/
    IL_0039: ret

