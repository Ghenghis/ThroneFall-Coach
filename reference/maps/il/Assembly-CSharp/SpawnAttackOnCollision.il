// ===== SpawnAttackOnCollision  (token 0x020001EB) =====
  .method SpawnAttackOnCollision::get_SpwanAttackOnDeath()  // token 0x06000A1E rva 0x2fee1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon SpawnAttackOnCollision::spwanAttackOnCollision  /*0x04000CE5*/
    IL_0006: ret

  .method SpawnAttackOnCollision::set_SpwanAttackOnDeath(Weapon)  // token 0x06000A1F rva 0x2fee9 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Weapon SpawnAttackOnCollision::spwanAttackOnCollision  /*0x04000CE5*/
    IL_0007: ret

  .method SpawnAttackOnCollision::get_taggedObject()  // token 0x06000A20 rva 0x2fef2 attrs Private, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TaggedObject SpawnAttackOnCollision::<taggedObject>k__BackingField  /*0x04000CF2*/
    IL_0006: ret

  .method SpawnAttackOnCollision::set_taggedObject(TaggedObject)  // token 0x06000A21 rva 0x2fefa attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld TaggedObject SpawnAttackOnCollision::<taggedObject>k__BackingField  /*0x04000CF2*/
    IL_0007: ret

  .method SpawnAttackOnCollision::Start()  // token 0x06000A22 rva 0x2ff04 attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldfld ThronefallAudioManager.AudioOneShot SpawnAttackOnCollision::placementSound  /*0x04000CE6*/
    IL_0011: ldarg.0
    IL_0012: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0017: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001c: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_0021: ldarg.0
    IL_0022: ldfld bool SpawnAttackOnCollision::isPlayerAttack  /*0x04000CE8*/
    IL_0027: brfalse.s IL_0040
    IL_0029: ldarg.0
    IL_002a: ldarg.0
    IL_002b: ldfld float SpawnAttackOnCollision::damageMultiplyer  /*0x04000CF3*/
    IL_0030: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0035: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_003a: mul
    IL_003b: stfld float SpawnAttackOnCollision::damageMultiplyer  /*0x04000CF3*/
    IL_0040: ret

  .method SpawnAttackOnCollision::Update()  // token 0x06000A23 rva 0x2ff54 attrs Private, HideBySig
    // code size 326 (0x146), max stack 5, init locals
    .locals ([0] IEnumerator<TaggedObject>, [1] TaggedObject, [2] int, [3] int, [4] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: ldarg.0
    IL_0007: ldfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_000c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0011: ldarg.0
    IL_0012: ldfld float SpawnAttackOnCollision::productionTime  /*0x04000CEF*/
    IL_0017: div
    IL_0018: add
    IL_0019: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_001e: stfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_0023: ldarg.0
    IL_0024: ldfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_0029: ldc.r4 1f
    IL_002e: bge.un.s IL_0043
    IL_0030: ldarg.0
    IL_0031: ldfld ProductionBar SpawnAttackOnCollision::productionBar  /*0x04000CF0*/
    IL_0036: ldarg.0
    IL_0037: ldfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_003c: callvirt void ProductionBar::UpdateVisual(float)  /*0x06000C97*/
    IL_0041: br.s IL_0072
    IL_0043: ldarg.0
    IL_0044: ldfld ProductionBar SpawnAttackOnCollision::productionBar  /*0x04000CF0*/
    IL_0049: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004e: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0053: brfalse.s IL_0072
    IL_0055: ldarg.0
    IL_0056: ldfld ProductionBar SpawnAttackOnCollision::productionBar  /*0x04000CF0*/
    IL_005b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0060: ldc.i4.0
    IL_0061: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0066: ldarg.0
    IL_0067: ldfld GameObject SpawnAttackOnCollision::fullyChargedIndicator  /*0x04000CF1*/
    IL_006c: ldc.i4.1
    IL_006d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0072: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0077: callvirt IReadOnlyList<TaggedObject> TagManager::get_EnemyUnits()  /*0x06000E53*/
    IL_007c: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_0081: stloc.0
    IL_0082: br IL_012e
    IL_0087: ldloc.0
    IL_0088: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_008d: stloc.1
    IL_008e: ldarg.0
    IL_008f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0094: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0099: ldloc.1
    IL_009a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a4: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld float SpawnAttackOnCollision::preSelectRadius  /*0x04000CE9*/
    IL_00af: bgt.un.s IL_012e
    IL_00b1: ldarg.0
    IL_00b2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld BoxCollider SpawnAttackOnCollision::myCollider  /*0x04000CEC*/
    IL_00c2: callvirt Vector3 UnityEngine.BoxCollider::get_size()  /*0x0A000103*/
    IL_00c7: ldc.r4 2f
    IL_00cc: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_00d1: ldarg.0
    IL_00d2: ldfld Collider[] SpawnAttackOnCollision::overlapColliders  /*0x04000CEA*/
    IL_00d7: ldarg.0
    IL_00d8: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00dd: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld LayerMask SpawnAttackOnCollision::lmTakeDamage  /*0x04000CEB*/
    IL_00e8: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_00ed: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_00f2: stloc.2
    IL_00f3: ldc.i4.0
    IL_00f4: stloc.3
    IL_00f5: br.s IL_0128
    IL_00f7: ldarg.0
    IL_00f8: ldfld Collider[] SpawnAttackOnCollision::overlapColliders  /*0x04000CEA*/
    IL_00fd: ldloc.3
    IL_00fe: ldelem.ref
    IL_00ff: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0104: stloc.s 4
    IL_0106: ldloc.s 4
    IL_0108: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_010d: brfalse.s IL_0124
    IL_010f: ldloc.s 4
    IL_0111: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0116: ldc.i4.1
    IL_0117: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_011c: brfalse.s IL_0124
    IL_011e: ldarg.0
    IL_011f: call void SpawnAttackOnCollision::Fire()  /*0x06000A24*/
    IL_0124: ldloc.3
    IL_0125: ldc.i4.1
    IL_0126: add
    IL_0127: stloc.3
    IL_0128: ldloc.3
    IL_0129: ldloc.2
    IL_012a: blt.s IL_00f7
    IL_012c: leave.s IL_0145
    IL_012e: ldloc.0
    IL_012f: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0134: brtrue IL_0087
    IL_0139: leave.s IL_0145
    IL_013b: ldloc.0
    IL_013c: brfalse.s IL_0144
    IL_013e: ldloc.0
    IL_013f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0144: endfinally
    IL_0145: ret
    .try IL_0082-IL_013b finally handler IL_013b-IL_0145

  .method SpawnAttackOnCollision::Fire()  // token 0x06000A24 rva 0x300b8 attrs Private, HideBySig
    // code size 137 (0x89), max stack 9, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_0006: stsfld float SpawnAttackOnCollision::lastTriggerProducitonProgress  /*0x04000CE4*/
    IL_000b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0010: ldarg.0
    IL_0011: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0016: ldarg.0
    IL_0017: ldfld ThronefallAudioManager.AudioOneShot SpawnAttackOnCollision::fireSound  /*0x04000CE7*/
    IL_001c: ldarg.0
    IL_001d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0022: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0027: call void ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  /*0x0600021A*/
    IL_002c: ldarg.0
    IL_002d: ldfld Weapon SpawnAttackOnCollision::spwanAttackOnCollision  /*0x04000CE5*/
    IL_0032: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0037: brfalse.s IL_007d
    IL_0039: ldarg.0
    IL_003a: ldfld Weapon SpawnAttackOnCollision::spwanAttackOnCollision  /*0x04000CE5*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldnull
    IL_004b: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0050: ldarg.0
    IL_0051: call TaggedObject SpawnAttackOnCollision::get_taggedObject()  /*0x06000A20*/
    IL_0056: ldarg.0
    IL_0057: ldfld float SpawnAttackOnCollision::damageMultiplyer  /*0x04000CF3*/
    IL_005c: ldarg.0
    IL_005d: ldfld float SpawnAttackOnCollision::productionProgress  /*0x04000CEE*/
    IL_0062: ldc.r4 1f
    IL_0067: ldarg.0
    IL_0068: ldfld float SpawnAttackOnCollision::baseDamagePercentage  /*0x04000CED*/
    IL_006d: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0072: mul
    IL_0073: ldc.r4 1f
    IL_0078: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_007d: ldarg.0
    IL_007e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0083: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0088: ret

  .method SpawnAttackOnCollision::OnDuskEarly()  // token 0x06000A25 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpawnAttackOnCollision::OnDusk()  // token 0x06000A26 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpawnAttackOnCollision::OnDawn_AfterSunrise()  // token 0x06000A27 rva 0x3014d attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 23 (0x17), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_000b: ldarg.0
    IL_000c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0016: ret

  .method SpawnAttackOnCollision::OnDawn_BeforeSunrise()  // token 0x06000A28 rva 0x3014d attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 23 (0x17), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_000b: ldarg.0
    IL_000c: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0011: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0016: ret

  .method SpawnAttackOnCollision::.ctor()  // token 0x06000A29 rva 0x30168 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 64 (0x40), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float SpawnAttackOnCollision::preSelectRadius  /*0x04000CE9*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.s 50
    IL_000e: newarr UnityEngine.Collider  /*0x01000032*/
    IL_0013: stfld Collider[] SpawnAttackOnCollision::overlapColliders  /*0x04000CEA*/
    IL_0018: ldarg.0
    IL_0019: ldc.r4 0.2f
    IL_001e: stfld float SpawnAttackOnCollision::baseDamagePercentage  /*0x04000CED*/
    IL_0023: ldarg.0
    IL_0024: ldc.r4 10f
    IL_0029: stfld float SpawnAttackOnCollision::productionTime  /*0x04000CEF*/
    IL_002e: ldarg.0
    IL_002f: ldc.r4 1f
    IL_0034: stfld float SpawnAttackOnCollision::damageMultiplyer  /*0x04000CF3*/
    IL_0039: ldarg.0
    IL_003a: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003f: ret

