// ===== BarricadeDamage  (token 0x0200007E) =====
  .method BarricadeDamage::Start()  // token 0x06000280 rva 0xb262 attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.BoxCollider>  /*0x2B00001C*/
    IL_0007: stfld BoxCollider BarricadeDamage::myCollider  /*0x04000355*/
    IL_000c: ldarg.0
    IL_000d: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0012: stfld float BarricadeDamage::timeSinceLastCollisionCheck  /*0x04000353*/
    IL_0017: ret

  .method BarricadeDamage::Update()  // token 0x06000281 rva 0xb27c attrs Private, HideBySig
    // code size 429 (0x1ad), max stack 5, init locals
    .locals ([0] Vector3, [1] IEnumerator<TaggedObject>, [2] TaggedObject, [3] int, [4] int, [5] TaggedObject, [6] Hp, [7] PathfindMovement, [8] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float BarricadeDamage::timeSinceLastCollisionCheck  /*0x04000353*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float BarricadeDamage::timeSinceLastCollisionCheck  /*0x04000353*/
    IL_0012: ldarg.0
    IL_0013: ldfld float BarricadeDamage::timeSinceLastCollisionCheck  /*0x04000353*/
    IL_0018: ldc.r4 0.2f
    IL_001d: bge.un.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldc.r4 0f
    IL_0026: stfld float BarricadeDamage::timeSinceLastCollisionCheck  /*0x04000353*/
    IL_002b: ldarg.0
    IL_002c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0031: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0036: stloc.0
    IL_0037: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_003c: callvirt IReadOnlyList<TaggedObject> TagManager::get_EnemyUnits()  /*0x06000E53*/
    IL_0041: callvirt IEnumerator<!0> System.Collections.Generic.IEnumerable<TaggedObject>::GetEnumerator()  /*0x0A000100*/
    IL_0046: stloc.1
    IL_0047: br IL_0195
    IL_004c: ldloc.1
    IL_004d: callvirt !0 System.Collections.Generic.IEnumerator<TaggedObject>::get_Current()  /*0x0A000101*/
    IL_0052: stloc.2
    IL_0053: ldloc.0
    IL_0054: ldloc.2
    IL_0055: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_0064: ldarg.0
    IL_0065: ldfld float BarricadeDamage::preSelectRadius  /*0x0400034E*/
    IL_006a: bgt.un IL_0195
    IL_006f: ldloc.2
    IL_0070: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0075: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_007a: callvirt bool PathfindMovement::get_IsSlowed()  /*0x06000B09*/
    IL_007f: brtrue IL_0195
    IL_0084: ldloc.0
    IL_0085: ldarg.0
    IL_0086: ldfld BoxCollider BarricadeDamage::myCollider  /*0x04000355*/
    IL_008b: callvirt Vector3 UnityEngine.BoxCollider::get_size()  /*0x0A000103*/
    IL_0090: ldc.r4 2f
    IL_0095: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_009a: ldarg.0
    IL_009b: ldfld Collider[] BarricadeDamage::overlapColliders  /*0x04000352*/
    IL_00a0: ldarg.0
    IL_00a1: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a6: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld LayerMask BarricadeDamage::lmTakeDamage  /*0x04000351*/
    IL_00b1: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_00b6: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_00bb: stloc.3
    IL_00bc: ldc.i4.0
    IL_00bd: stloc.s 4
    IL_00bf: br IL_018b
    IL_00c4: ldarg.0
    IL_00c5: ldfld Collider[] BarricadeDamage::overlapColliders  /*0x04000352*/
    IL_00ca: ldloc.s 4
    IL_00cc: ldelem.ref
    IL_00cd: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_00d2: stloc.s 5
    IL_00d4: ldloc.s 5
    IL_00d6: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00db: brfalse IL_0185
    IL_00e0: ldloc.s 5
    IL_00e2: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00e7: ldc.i4.1
    IL_00e8: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00ed: brfalse IL_0185
    IL_00f2: ldloc.s 5
    IL_00f4: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00f9: ldc.i4.s 16
    IL_00fb: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0100: brfalse IL_0185
    IL_0105: ldloc.s 5
    IL_0107: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_010c: stloc.s 6
    IL_010e: ldloc.s 6
    IL_0110: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0115: brfalse.s IL_0185
    IL_0117: ldloc.s 6
    IL_0119: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_011e: stloc.s 7
    IL_0120: ldloc.s 7
    IL_0122: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0127: brfalse.s IL_0185
    IL_0129: ldloc.s 7
    IL_012b: callvirt bool PathfindMovement::get_IsSlowed()  /*0x06000B09*/
    IL_0130: brtrue.s IL_0185
    IL_0132: ldarg.0
    IL_0133: ldfld BlacksmithUpgrades BarricadeDamage::blacksmithUpgrades  /*0x04000356*/
    IL_0138: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_013d: brtrue.s IL_014a
    IL_013f: ldarg.0
    IL_0140: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0145: stfld BlacksmithUpgrades BarricadeDamage::blacksmithUpgrades  /*0x04000356*/
    IL_014a: ldarg.0
    IL_014b: ldfld BlacksmithUpgrades BarricadeDamage::blacksmithUpgrades  /*0x04000356*/
    IL_0150: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0155: stloc.s 8
    IL_0157: ldloc.s 7
    IL_0159: ldarg.0
    IL_015a: ldfld float BarricadeDamage::slowTime  /*0x0400034F*/
    IL_015f: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_0164: ldloc.s 6
    IL_0166: ldloc.s 5
    IL_0168: ldarg.0
    IL_0169: ldfld List<DamageModifyer> BarricadeDamage::damage  /*0x04000350*/
    IL_016e: ldarg.0
    IL_016f: ldfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_0174: ldloc.s 8
    IL_0176: mul
    IL_0177: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_017c: ldnull
    IL_017d: ldc.i4.0
    IL_017e: ldc.i4.1
    IL_017f: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0184: pop
    IL_0185: ldloc.s 4
    IL_0187: ldc.i4.1
    IL_0188: add
    IL_0189: stloc.s 4
    IL_018b: ldloc.s 4
    IL_018d: ldloc.3
    IL_018e: blt IL_00c4
    IL_0193: leave.s IL_01ac
    IL_0195: ldloc.1
    IL_0196: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_019b: brtrue IL_004c
    IL_01a0: leave.s IL_01ac
    IL_01a2: ldloc.1
    IL_01a3: brfalse.s IL_01ab
    IL_01a5: ldloc.1
    IL_01a6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01ab: endfinally
    IL_01ac: ret
    .try IL_0047-IL_01a2 finally handler IL_01a2-IL_01ac

  .method BarricadeDamage::.ctor()  // token 0x06000282 rva 0xb454 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float BarricadeDamage::preSelectRadius  /*0x0400034E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float BarricadeDamage::slowTime  /*0x0400034F*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.s 50
    IL_0019: newarr UnityEngine.Collider  /*0x01000032*/
    IL_001e: stfld Collider[] BarricadeDamage::overlapColliders  /*0x04000352*/
    IL_0023: ldarg.0
    IL_0024: ldc.r4 1f
    IL_0029: stfld float BarricadeDamage::DamageMultiplyer  /*0x04000354*/
    IL_002e: ldarg.0
    IL_002f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0034: ret

