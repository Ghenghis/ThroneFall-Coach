// ===== SpawnAttackAfter  (token 0x020001EA) =====
  .method SpawnAttackAfter::get_SpwanAttackOnDeath()  // token 0x06000A17 rva 0x2fda8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon SpawnAttackAfter::spwanAttackOnDeath  /*0x04000CDA*/
    IL_0006: ret

  .method SpawnAttackAfter::set_SpwanAttackOnDeath(Weapon)  // token 0x06000A18 rva 0x2fdb0 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Weapon SpawnAttackAfter::spwanAttackOnDeath  /*0x04000CDA*/
    IL_0007: ret

  .method SpawnAttackAfter::get_taggedObject()  // token 0x06000A19 rva 0x2fdb9 attrs Private, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject SpawnAttackAfter::<taggedObject>k__BackingField  /*0x04000CE0*/
    IL_0006: ret

  .method SpawnAttackAfter::set_taggedObject(TaggedObject)  // token 0x06000A1A rva 0x2fdc1 attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld TaggedObject SpawnAttackAfter::<taggedObject>k__BackingField  /*0x04000CE0*/
    IL_0007: ret

  .method SpawnAttackAfter::Start()  // token 0x06000A1B rva 0x2fdcc attrs Private, HideBySig
    // code size 91 (0x5b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Disc SpawnAttackAfter::disc  /*0x04000CDC*/
    IL_0007: callvirt float Shapes.Disc::get_Radius()  /*0x0A000080*/
    IL_000c: stfld float SpawnAttackAfter::startRadius  /*0x04000CE2*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld float SpawnAttackAfter::delay  /*0x04000CDB*/
    IL_0018: stfld float SpawnAttackAfter::startDelay  /*0x04000CE3*/
    IL_001d: ldarg.0
    IL_001e: ldfld bool SpawnAttackAfter::mute  /*0x04000CDE*/
    IL_0023: brtrue.s IL_003b
    IL_0025: ldarg.0
    IL_0026: ldfld ThronefallAudioManager.AudioOneShot SpawnAttackAfter::sound  /*0x04000CDD*/
    IL_002b: ldarg.0
    IL_002c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0031: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0036: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_003b: ldarg.0
    IL_003c: ldfld bool SpawnAttackAfter::isPlayerAttack  /*0x04000CDF*/
    IL_0041: brfalse.s IL_005a
    IL_0043: ldarg.0
    IL_0044: ldarg.0
    IL_0045: ldfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_004a: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_004f: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_0054: mul
    IL_0055: stfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_005a: ret

  .method SpawnAttackAfter::Update()  // token 0x06000A1C rva 0x2fe34 attrs Private, HideBySig
    // code size 142 (0x8e), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float SpawnAttackAfter::delay  /*0x04000CDB*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float SpawnAttackAfter::delay  /*0x04000CDB*/
    IL_0012: ldarg.0
    IL_0013: ldfld float SpawnAttackAfter::delay  /*0x04000CDB*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_0065
    IL_001f: ldarg.0
    IL_0020: ldfld Weapon SpawnAttackAfter::spwanAttackOnDeath  /*0x04000CDA*/
    IL_0025: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002a: brfalse.s IL_0059
    IL_002c: ldarg.0
    IL_002d: ldfld Weapon SpawnAttackAfter::spwanAttackOnDeath  /*0x04000CDA*/
    IL_0032: ldarg.0
    IL_0033: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0038: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003d: ldnull
    IL_003e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0043: ldarg.0
    IL_0044: call TaggedObject SpawnAttackAfter::get_taggedObject()  /*0x06000A19*/
    IL_0049: ldarg.0
    IL_004a: ldfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_004f: ldc.r4 1f
    IL_0054: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0059: ldarg.0
    IL_005a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0064: ret
    IL_0065: ldarg.0
    IL_0066: ldfld Disc SpawnAttackAfter::disc  /*0x04000CDC*/
    IL_006b: ldarg.0
    IL_006c: ldfld float SpawnAttackAfter::startRadius  /*0x04000CE2*/
    IL_0071: ldc.r4 0f
    IL_0076: ldarg.0
    IL_0077: ldfld float SpawnAttackAfter::delay  /*0x04000CDB*/
    IL_007c: ldarg.0
    IL_007d: ldfld float SpawnAttackAfter::startDelay  /*0x04000CE3*/
    IL_0082: div
    IL_0083: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0088: callvirt void Shapes.Disc::set_Radius(float)  /*0x0A000086*/
    IL_008d: ret

  .method SpawnAttackAfter::.ctor()  // token 0x06000A1D rva 0x2fece attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float SpawnAttackAfter::damageMultiplyer  /*0x04000CE1*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

