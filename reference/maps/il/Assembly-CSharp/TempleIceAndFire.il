// ===== TempleIceAndFire  (token 0x020002AF) =====
  .method TempleIceAndFire::EnableEffectAtDusk()  // token 0x06000EC2 rva 0x4279a attrs Public, Virtual, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool TempleIceAndFire::effectRunning  /*0x04001119*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float TempleIceAndFire::boltCooldown  /*0x04001115*/
    IL_000e: ldc.r4 2f
    IL_0013: div
    IL_0014: stfld float TempleIceAndFire::timeTillNextTick  /*0x04001118*/
    IL_0019: ldarg.0
    IL_001a: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_001f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0024: stfld Transform TempleIceAndFire::playerTransform  /*0x0400111D*/
    IL_0029: ret

  .method TempleIceAndFire::DisableEffectAtDawn()  // token 0x06000EC3 rva 0x427c5 attrs Public, Virtual, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool TempleIceAndFire::effectRunning  /*0x04001119*/
    IL_0007: ret

  .method TempleIceAndFire::Update()  // token 0x06000EC4 rva 0x427ce attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool TempleIceAndFire::effectRunning  /*0x04001119*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float TempleIceAndFire::timeTillNextTick  /*0x04001118*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: sub
    IL_0016: stfld float TempleIceAndFire::timeTillNextTick  /*0x04001118*/
    IL_001b: ldarg.0
    IL_001c: ldfld float TempleIceAndFire::timeTillNextTick  /*0x04001118*/
    IL_0021: ldc.r4 0f
    IL_0026: bgt.un.s IL_003a
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: ldfld float TempleIceAndFire::boltCooldown  /*0x04001115*/
    IL_002f: stfld float TempleIceAndFire::timeTillNextTick  /*0x04001118*/
    IL_0034: ldarg.0
    IL_0035: call void TempleIceAndFire::SpawnIceBolt()  /*0x06000EC5*/
    IL_003a: ret

  .method TempleIceAndFire::SpawnIceBolt()  // token 0x06000EC5 rva 0x4280c attrs Private, HideBySig
    // code size 131 (0x83), max stack 6, init locals
    .locals ([0] Transform)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: ldarg.0
    IL_0006: ldfld Transform TempleIceAndFire::playerTransform  /*0x0400111D*/
    IL_000b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0010: ldarg.0
    IL_0011: ldfld List<TagManager.ETag> TempleIceAndFire::targetMustHaveTags  /*0x0400111B*/
    IL_0016: ldarg.0
    IL_0017: ldfld List<TagManager.ETag> TempleIceAndFire::targetMayNotHaveTags  /*0x0400111C*/
    IL_001c: ldarg.0
    IL_001d: ldfld TaggedObject[] TempleIceAndFire::closestObject  /*0x0400111A*/
    IL_0022: ldc.r4 10000000f
    IL_0027: callvirt void TagManager::FindClosestTaggedObjectsWithTags(UnityEngine.Vector3,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,TaggedObject[],float)  /*0x06000E5F*/
    IL_002c: ldnull
    IL_002d: stloc.0
    IL_002e: ldarg.0
    IL_002f: ldfld TaggedObject[] TempleIceAndFire::closestObject  /*0x0400111A*/
    IL_0034: ldc.i4.0
    IL_0035: ldelem.ref
    IL_0036: ldnull
    IL_0037: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003c: brfalse.s IL_0047
    IL_003e: ldarg.0
    IL_003f: ldfld Transform TempleIceAndFire::playerTransform  /*0x0400111D*/
    IL_0044: stloc.0
    IL_0045: br.s IL_0055
    IL_0047: ldarg.0
    IL_0048: ldfld TaggedObject[] TempleIceAndFire::closestObject  /*0x0400111A*/
    IL_004d: ldc.i4.0
    IL_004e: ldelem.ref
    IL_004f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0054: stloc.0
    IL_0055: ldarg.0
    IL_0056: ldfld GameObject TempleIceAndFire::iceBolt  /*0x04001117*/
    IL_005b: ldloc.0
    IL_005c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0061: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0066: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_006b: callvirt !!0 UnityEngine.GameObject::GetComponent()<SpawnAttackAfter>  /*0x2B00008C*/
    IL_0070: dup
    IL_0071: ldfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_0076: ldarg.0
    IL_0077: ldfld float TempleIceAndFire::boltDamage  /*0x04001116*/
    IL_007c: mul
    IL_007d: stfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_0082: ret

  .method TempleIceAndFire::.ctor()  // token 0x06000EC6 rva 0x4289b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float TempleIceAndFire::boltCooldown  /*0x04001115*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TempleIceAndFire::boltDamage  /*0x04001116*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: newarr TaggedObject  /*0x02000298*/
    IL_001d: stfld TaggedObject[] TempleIceAndFire::closestObject  /*0x0400111A*/
    IL_0022: ldarg.0
    IL_0023: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_0028: ret

