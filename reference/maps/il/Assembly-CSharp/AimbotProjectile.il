// ===== AimbotProjectile  (token 0x02000014) =====
  .method AimbotProjectile::get_Weapon()  // token 0x0600007E rva 0x3f47 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0006: ret

  .method AimbotProjectile::set_Weapon(Weapon)  // token 0x0600007F rva 0x3f4f attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0007: ret

  .method AimbotProjectile::Start()  // token 0x06000080 rva 0x3f58 attrs Private, HideBySig
    // code size 114 (0x72), max stack 3, init locals
    .locals ([0] List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>, [1] AimbotProjectile.GameObjectToDestroyAfterTime)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<ReturnGameObjectToPool>  /*0x2B000007*/
    IL_0007: ldnull
    IL_0008: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000d: stfld bool AimbotProjectile::isPooledItem  /*0x0400008C*/
    IL_0012: ldarg.0
    IL_0013: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_0018: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_001d: stloc.0
    IL_001e: br.s IL_0058
    IL_0020: ldloca.s 0
    IL_0022: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_0027: stloc.1
    IL_0028: ldloc.1
    IL_0029: brfalse.s IL_0058
    IL_002b: ldloc.1
    IL_002c: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_0031: ldnull
    IL_0032: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0037: brfalse.s IL_0058
    IL_0039: ldloc.1
    IL_003a: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_003f: callvirt !!0 UnityEngine.GameObject::GetComponent()<DisablePooledObjectAfterTime>  /*0x2B000008*/
    IL_0044: ldnull
    IL_0045: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_004a: brfalse.s IL_0058
    IL_004c: ldloc.1
    IL_004d: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_0052: callvirt !!0 UnityEngine.GameObject::AddComponent()<DisablePooledObjectAfterTime>  /*0x2B000009*/
    IL_0057: pop
    IL_0058: ldloca.s 0
    IL_005a: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_005f: brtrue.s IL_0020
    IL_0061: leave.s IL_0071
    IL_0063: ldloca.s 0
    IL_0065: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_006b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0070: endfinally
    IL_0071: ret
    .try IL_001e-IL_0063 finally handler IL_0063-IL_0071

  .method AimbotProjectile::Fire(Weapon,Hp,float,UnityEngine.Vector3,TaggedObject,float,float)  // token 0x06000081 rva 0x3fe8 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 335 (0x14f), max stack 4, init locals
    .locals ([0] Vector3, [1] List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>, [2] AimbotProjectile.GameObjectToDestroyAfterTime)
    IL_0000: ldarg.0
    IL_0001: ldarg.s 5
    IL_0003: stfld TaggedObject AimbotProjectile::firedBy  /*0x04000087*/
    IL_0008: ldarg.0
    IL_0009: ldfld TaggedObject AimbotProjectile::firedBy  /*0x04000087*/
    IL_000e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0013: brfalse.s IL_0028
    IL_0015: ldarg.0
    IL_0016: ldarg.s 5
    IL_0018: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_001d: ldc.i4.2
    IL_001e: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0023: stfld bool AimbotProjectile::firedByPlayer  /*0x04000088*/
    IL_0028: ldarg.0
    IL_0029: ldarg.1
    IL_002a: stfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_002f: ldarg.2
    IL_0030: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0035: brfalse.s IL_0083
    IL_0037: ldarg.0
    IL_0038: ldarg.2
    IL_0039: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003e: stfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_0043: ldarg.0
    IL_0044: ldarg.0
    IL_0045: ldfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_004a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004f: stfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_0054: ldarg.0
    IL_0055: ldarg.2
    IL_0056: stfld Hp AimbotProjectile::targetHp  /*0x0400007F*/
    IL_005b: ldarg.0
    IL_005c: ldarg.2
    IL_005d: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0062: stfld TaggedObject AimbotProjectile::targetTaggedObject  /*0x04000080*/
    IL_0067: ldarg.0
    IL_0068: ldfld TaggedObject AimbotProjectile::targetTaggedObject  /*0x04000080*/
    IL_006d: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0072: ldc.i4.6
    IL_0073: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0078: brfalse.s IL_008b
    IL_007a: ldarg.0
    IL_007b: ldc.i4.1
    IL_007c: stfld bool AimbotProjectile::targetIsFlying  /*0x04000089*/
    IL_0081: br.s IL_008b
    IL_0083: ldarg.0
    IL_0084: ldarg.s 4
    IL_0086: stfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_008b: ldarg.0
    IL_008c: ldarg.0
    IL_008d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0092: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0097: stfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_009c: ldarg.0
    IL_009d: ldarg.0
    IL_009e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a8: stfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_00ad: ldarg.0
    IL_00ae: ldarg.0
    IL_00af: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00b4: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00b9: stfld Vector3 AimbotProjectile::previousPosition  /*0x04000084*/
    IL_00be: ldarg.0
    IL_00bf: ldarg.3
    IL_00c0: ldarg.0
    IL_00c1: ldfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_00cc: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_00d1: stloc.0
    IL_00d2: ldloca.s 0
    IL_00d4: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_00d9: ldc.r4 0.5f
    IL_00de: add
    IL_00df: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_00e4: stfld float AimbotProjectile::remainingRange  /*0x04000086*/
    IL_00e9: ldarg.0
    IL_00ea: ldarg.s 6
    IL_00ec: stfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_00f7: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_00fc: stloc.1
    IL_00fd: br.s IL_011b
    IL_00ff: ldloca.s 1
    IL_0101: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_0106: stloc.2
    IL_0107: ldloc.2
    IL_0108: brfalse.s IL_011b
    IL_010a: ldloc.2
    IL_010b: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_0110: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0115: ldnull
    IL_0116: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_011b: ldloca.s 1
    IL_011d: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_0122: brtrue.s IL_00ff
    IL_0124: leave.s IL_0134
    IL_0126: ldloca.s 1
    IL_0128: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_012e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0133: endfinally
    IL_0134: ldarg.0
    IL_0135: ldarg.0
    IL_0136: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_013b: ldfld float Weapon::projectileSpeed  /*0x04001818*/
    IL_0140: ldarg.s 7
    IL_0142: mul
    IL_0143: stfld float AimbotProjectile::speed  /*0x0400008B*/
    IL_0148: ldarg.0
    IL_0149: callvirt void AimbotProjectile::Update()  /*0x06000082*/
    IL_014e: ret
    .try IL_00fd-IL_0126 finally handler IL_0126-IL_0134

  .method AimbotProjectile::Update()  // token 0x06000082 rva 0x4154 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 714 (0x2ca), max stack 5, init locals
    .locals ([0] Vector3, [1] float, [2] float, [3] float, [4] Vector3, [5] float, [6] float, [7] List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0069
    IL_000d: ldarg.0
    IL_000e: ldfld TaggedObject AimbotProjectile::targetTaggedObject  /*0x04000080*/
    IL_0013: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_0018: ldnull
    IL_0019: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001e: brfalse.s IL_003e
    IL_0020: ldarg.0
    IL_0021: ldarg.0
    IL_0022: ldfld TaggedObject AimbotProjectile::targetTaggedObject  /*0x04000080*/
    IL_0027: ldfld Collider TaggedObject::colliderForBigOjectsToMeasureDistance  /*0x0400108A*/
    IL_002c: ldarg.0
    IL_002d: ldfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_0032: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_0037: stfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_003c: br.s IL_0069
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld Hp AimbotProjectile::targetHp  /*0x0400007F*/
    IL_0050: ldfld float Hp::hitFeedbackHeight  /*0x04000A32*/
    IL_0055: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_005a: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_005f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0064: stfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_0069: ldarg.0
    IL_006a: ldfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_006f: ldarg.0
    IL_0070: ldfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_0075: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_007a: stloc.0
    IL_007b: ldarg.0
    IL_007c: ldfld float AimbotProjectile::speed  /*0x0400008B*/
    IL_0081: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0086: mul
    IL_0087: stloc.1
    IL_0088: ldloc.1
    IL_0089: ldloca.s 0
    IL_008b: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0090: blt.un IL_011e
    IL_0095: ldarg.0
    IL_0096: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_009b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a0: pop
    IL_00a1: ldarg.0
    IL_00a2: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_00ad: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld TaggedObject AimbotProjectile::targetTaggedObject  /*0x04000080*/
    IL_00b8: ldnull
    IL_00b9: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00be: brfalse.s IL_00fa
    IL_00c0: ldarg.0
    IL_00c1: ldfld Hp AimbotProjectile::targetHp  /*0x0400007F*/
    IL_00c6: ldnull
    IL_00c7: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00cc: brfalse.s IL_00fa
    IL_00ce: ldarg.0
    IL_00cf: ldfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_00d4: ldnull
    IL_00d5: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00da: brfalse.s IL_00fa
    IL_00dc: ldarg.0
    IL_00dd: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld Hp AimbotProjectile::targetHp  /*0x0400007F*/
    IL_00e8: ldarg.0
    IL_00e9: ldfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld TaggedObject AimbotProjectile::firedBy  /*0x04000087*/
    IL_00f4: ldc.i4.0
    IL_00f5: callvirt void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_00fa: ldarg.0
    IL_00fb: ldarg.0
    IL_00fc: ldfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_0101: call void AimbotProjectile::SpawnWeaponObjectOnHit(UnityEngine.Transform)  /*0x06000085*/
    IL_0106: ldarg.0
    IL_0107: call void AimbotProjectile::SpawnProjectileObjectOnHit()  /*0x06000086*/
    IL_010c: ldarg.0
    IL_010d: ldfld UnityEvent AimbotProjectile::onHit  /*0x0400008A*/
    IL_0112: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0117: ldarg.0
    IL_0118: call void AimbotProjectile::DestroyProjectile()  /*0x06000084*/
    IL_011d: ret
    IL_011e: ldarg.0
    IL_011f: ldarg.0
    IL_0120: ldfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_0125: ldloca.s 0
    IL_0127: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_012c: ldloc.1
    IL_012d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0132: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0137: stfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_013c: ldarg.0
    IL_013d: ldfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_0142: ldarg.0
    IL_0143: ldfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_0148: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_014d: stloc.s 4
    IL_014f: ldloca.s 4
    IL_0151: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0156: stloc.3
    IL_0157: ldloc.3
    IL_0158: ldc.r4 0.001f
    IL_015d: ble.un.s IL_01c7
    IL_015f: ldarg.0
    IL_0160: ldfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_0165: ldarg.0
    IL_0166: ldfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_016b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0170: stloc.s 4
    IL_0172: ldloca.s 4
    IL_0174: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0179: ldloc.3
    IL_017a: div
    IL_017b: stloc.s 5
    IL_017d: ldc.r4 0f
    IL_0182: ldloc.3
    IL_0183: ldarg.0
    IL_0184: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0189: ldfld float Weapon::projectileParabulaOffset  /*0x0400181A*/
    IL_018e: add
    IL_018f: ldarg.0
    IL_0190: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0195: ldfld float Weapon::projectileParabulaFactor  /*0x04001819*/
    IL_019a: mul
    IL_019b: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_01a0: stloc.s 6
    IL_01a2: ldc.r4 2f
    IL_01a7: ldloc.s 5
    IL_01a9: mul
    IL_01aa: ldc.r4 1f
    IL_01af: sub
    IL_01b0: ldc.r4 2f
    IL_01b5: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_01ba: neg
    IL_01bb: ldc.r4 1f
    IL_01c0: add
    IL_01c1: ldloc.s 6
    IL_01c3: mul
    IL_01c4: stloc.2
    IL_01c5: br.s IL_01cd
    IL_01c7: ldc.r4 0f
    IL_01cc: stloc.2
    IL_01cd: ldarg.0
    IL_01ce: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01d3: ldarg.0
    IL_01d4: ldfld Vector3 AimbotProjectile::myLinearPosition  /*0x04000082*/
    IL_01d9: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01de: ldloc.2
    IL_01df: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_01e4: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01e9: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_01ee: ldarg.0
    IL_01ef: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_01f4: ldfld Weapon.EFacingDirection Weapon::projectileFacingDirection  /*0x04001817*/
    IL_01f9: ldc.i4.1
    IL_01fa: bne.un.s IL_023f
    IL_01fc: ldarg.0
    IL_01fd: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0202: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0207: ldarg.0
    IL_0208: ldfld Vector3 AimbotProjectile::previousPosition  /*0x04000084*/
    IL_020d: call bool UnityEngine.Vector3::op_Inequality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00006F*/
    IL_0212: brfalse.s IL_023f
    IL_0214: ldarg.0
    IL_0215: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_021a: ldarg.0
    IL_021b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0220: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0225: ldarg.0
    IL_0226: ldfld Vector3 AimbotProjectile::previousPosition  /*0x04000084*/
    IL_022b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0230: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0235: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_023a: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_023f: ldarg.0
    IL_0240: ldarg.0
    IL_0241: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0246: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_024b: stfld Vector3 AimbotProjectile::previousPosition  /*0x04000084*/
    IL_0250: ldarg.0
    IL_0251: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_0256: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_025b: stloc.s 7
    IL_025d: br.s IL_0280
    IL_025f: ldloca.s 7
    IL_0261: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_0266: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_026b: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0270: ldarg.0
    IL_0271: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0276: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_027b: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0280: ldloca.s 7
    IL_0282: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_0287: brtrue.s IL_025f
    IL_0289: leave.s IL_0299
    IL_028b: ldloca.s 7
    IL_028d: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_0293: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0298: endfinally
    IL_0299: ldarg.0
    IL_029a: ldarg.0
    IL_029b: ldfld float AimbotProjectile::remainingRange  /*0x04000086*/
    IL_02a0: ldloc.1
    IL_02a1: sub
    IL_02a2: stfld float AimbotProjectile::remainingRange  /*0x04000086*/
    IL_02a7: ldarg.0
    IL_02a8: ldfld float AimbotProjectile::remainingRange  /*0x04000086*/
    IL_02ad: ldc.r4 0f
    IL_02b2: bgt.un.s IL_02bb
    IL_02b4: ldarg.0
    IL_02b5: ldnull
    IL_02b6: stfld Transform AimbotProjectile::targetTransform  /*0x0400007E*/
    IL_02bb: ldarg.0
    IL_02bc: callvirt bool AimbotProjectile::ShouldBeDestroyedAheadOfTime()  /*0x06000083*/
    IL_02c1: brfalse.s IL_02c9
    IL_02c3: ldarg.0
    IL_02c4: call void AimbotProjectile::DestroyProjectile()  /*0x06000084*/
    IL_02c9: ret
    .try IL_025d-IL_028b finally handler IL_028b-IL_0299

  .method AimbotProjectile::ShouldBeDestroyedAheadOfTime()  // token 0x06000083 rva 0x443c attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: ret

  .method AimbotProjectile::DestroyProjectile()  // token 0x06000084 rva 0x443f attrs Private, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool AimbotProjectile::isPooledItem  /*0x0400008C*/
    IL_0006: brfalse.s IL_001a
    IL_0008: ldarg.0
    IL_0009: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: call void ObjectPools::ReleasePooledItemByObject(UnityEngine.GameObject)  /*0x06000E9B*/
    IL_0013: ldarg.0
    IL_0014: call void AimbotProjectile::OnDestroy()  /*0x06000087*/
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0020: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0025: ret

  .method AimbotProjectile::SpawnWeaponObjectOnHit(UnityEngine.Transform)  // token 0x06000085 rva 0x4468 attrs Private, HideBySig
    // code size 259 (0x103), max stack 3, init locals
    .locals ([0] GameObject, [1] WeaponDamageDealer[], [2] int)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld bool AimbotProjectile::targetIsFlying  /*0x04000089*/
    IL_0008: brtrue.s IL_0069
    IL_000a: ldarg.0
    IL_000b: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0010: ldfld GameObject Weapon::spawnOnGroundWhenTargetingGround  /*0x04001822*/
    IL_0015: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001a: brfalse.s IL_0069
    IL_001c: ldarg.1
    IL_001d: ldnull
    IL_001e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0023: brfalse.s IL_0046
    IL_0025: ldarg.0
    IL_0026: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_002b: ldfld GameObject Weapon::spawnOnGroundWhenTargetingGround  /*0x04001822*/
    IL_0030: ldarg.1
    IL_0031: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0036: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_003b: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0040: stloc.0
    IL_0041: br IL_00cb
    IL_0046: ldarg.0
    IL_0047: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_004c: ldfld GameObject Weapon::spawnOnGroundWhenTargetingGround  /*0x04001822*/
    IL_0051: ldarg.0
    IL_0052: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0057: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005c: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0061: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0066: stloc.0
    IL_0067: br.s IL_00cb
    IL_0069: ldarg.0
    IL_006a: ldfld bool AimbotProjectile::targetIsFlying  /*0x04000089*/
    IL_006f: brfalse.s IL_00cb
    IL_0071: ldarg.0
    IL_0072: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0077: ldfld GameObject Weapon::spawnInAirWhenTargetingAir  /*0x04001823*/
    IL_007c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0081: brfalse.s IL_00cb
    IL_0083: ldarg.1
    IL_0084: ldnull
    IL_0085: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_008a: brfalse.s IL_00aa
    IL_008c: ldarg.0
    IL_008d: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0092: ldfld GameObject Weapon::spawnInAirWhenTargetingAir  /*0x04001823*/
    IL_0097: ldarg.1
    IL_0098: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_009d: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_00a2: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_00a7: stloc.0
    IL_00a8: br.s IL_00cb
    IL_00aa: ldarg.0
    IL_00ab: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_00b0: ldfld GameObject Weapon::spawnInAirWhenTargetingAir  /*0x04001823*/
    IL_00b5: ldarg.0
    IL_00b6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00bb: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00c0: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_00c5: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_00ca: stloc.0
    IL_00cb: ldloc.0
    IL_00cc: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00d1: brfalse.s IL_0102
    IL_00d3: ldloc.0
    IL_00d4: callvirt !!0[] UnityEngine.GameObject::GetComponents()<WeaponDamageDealer>  /*0x2B00000B*/
    IL_00d9: stloc.1
    IL_00da: ldc.i4.0
    IL_00db: stloc.2
    IL_00dc: br.s IL_00fc
    IL_00de: ldloc.1
    IL_00df: ldloc.2
    IL_00e0: ldelem.ref
    IL_00e1: ldarg.0
    IL_00e2: ldfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_00e7: ldarg.0
    IL_00e8: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_00ed: callvirt float Weapon::get_BlacksmithMulti()  /*0x060013CC*/
    IL_00f2: mul
    IL_00f3: callvirt void WeaponDamageDealer::set_DamageMultiplyer(float)  /*0x060013D3*/
    IL_00f8: ldloc.2
    IL_00f9: ldc.i4.1
    IL_00fa: add
    IL_00fb: stloc.2
    IL_00fc: ldloc.2
    IL_00fd: ldloc.1
    IL_00fe: ldlen
    IL_00ff: conv.i4
    IL_0100: blt.s IL_00de
    IL_0102: ret

  .method AimbotProjectile::SpawnProjectileObjectOnHit()  // token 0x06000086 rva 0x4577 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject AimbotProjectile::spawnOnHit  /*0x0400007D*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002b
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject AimbotProjectile::spawnOnHit  /*0x0400007D*/
    IL_0014: ldarg.0
    IL_0015: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001f: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0024: ldnull
    IL_0025: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_002a: pop
    IL_002b: ret

  .method AimbotProjectile::OnDestroy()  // token 0x06000087 rva 0x45a4 attrs Private, HideBySig
    // code size 228 (0xe4), max stack 2, init locals
    .locals ([0] List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>, [1] AimbotProjectile.GameObjectToDestroyAfterTime, [2] DisablePooledObjectAfterTime, [3] AimbotProjectile.GameObjectToDestroyAfterTime)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AimbotProjectile::isPooledItem  /*0x0400008C*/
    IL_0006: brfalse.s IL_0085
    IL_0008: ldarg.0
    IL_0009: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_000e: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_0013: stloc.0
    IL_0014: br.s IL_004d
    IL_0016: ldloca.s 0
    IL_0018: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_001d: stloc.1
    IL_001e: ldloc.1
    IL_001f: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002a: brfalse.s IL_004d
    IL_002c: ldloc.1
    IL_002d: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_0032: callvirt !!0 UnityEngine.GameObject::GetComponent()<DisablePooledObjectAfterTime>  /*0x2B000008*/
    IL_0037: stloc.2
    IL_0038: ldloc.2
    IL_0039: ldnull
    IL_003a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003f: brfalse.s IL_004d
    IL_0041: ldloc.2
    IL_0042: ldloc.1
    IL_0043: ldfld float AimbotProjectile.GameObjectToDestroyAfterTime::lifetime  /*0x0400008E*/
    IL_0048: callvirt void DisablePooledObjectAfterTime::DisableAfter(float)  /*0x06000E8E*/
    IL_004d: ldloca.s 0
    IL_004f: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_0054: brtrue.s IL_0016
    IL_0056: leave.s IL_0066
    IL_0058: ldloca.s 0
    IL_005a: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_0060: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0065: endfinally
    IL_0066: ldarg.0
    IL_0067: ldfld bool AimbotProjectile::shakeCameraOnDestroy  /*0x0400007B*/
    IL_006c: brfalse.s IL_0084
    IL_006e: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_0073: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0078: brfalse.s IL_0084
    IL_007a: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_007f: callvirt void CameraController::ShakePunch()  /*0x06000321*/
    IL_0084: ret
    IL_0085: ldarg.0
    IL_0086: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_008b: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_0090: stloc.0
    IL_0091: br.s IL_00ac
    IL_0093: ldloca.s 0
    IL_0095: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_009a: stloc.3
    IL_009b: ldloc.3
    IL_009c: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_00a1: ldloc.3
    IL_00a2: ldfld float AimbotProjectile.GameObjectToDestroyAfterTime::lifetime  /*0x0400008E*/
    IL_00a7: call void UnityEngine.Object::Destroy(UnityEngine.Object,float)  /*0x0A000077*/
    IL_00ac: ldloca.s 0
    IL_00ae: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_00b3: brtrue.s IL_0093
    IL_00b5: leave.s IL_00c5
    IL_00b7: ldloca.s 0
    IL_00b9: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_00bf: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00c4: endfinally
    IL_00c5: ldarg.0
    IL_00c6: ldfld bool AimbotProjectile::shakeCameraOnDestroy  /*0x0400007B*/
    IL_00cb: brfalse.s IL_00e3
    IL_00cd: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_00d2: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00d7: brfalse.s IL_00e3
    IL_00d9: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_00de: callvirt void CameraController::ShakePunch()  /*0x06000321*/
    IL_00e3: ret
    .try IL_0014-IL_0058 finally handler IL_0058-IL_0066
    .try IL_0091-IL_00b7 finally handler IL_00b7-IL_00c5

  .method AimbotProjectile::ResetDisabledObjects()  // token 0x06000088 rva 0x46b0 attrs Public, HideBySig
    // code size 89 (0x59), max stack 2, init locals
    .locals ([0] List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>, [1] AimbotProjectile.GameObjectToDestroyAfterTime, [2] DisablePooledObjectAfterTime)
    IL_0000: ldarg.0
    IL_0001: ldfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::GetEnumerator()  /*0x0A00005D*/
    IL_000b: stloc.0
    IL_000c: br.s IL_003f
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::get_Current()  /*0x0A00005E*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_001c: ldnull
    IL_001d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0022: brfalse.s IL_003f
    IL_0024: ldloc.1
    IL_0025: ldfld GameObject AimbotProjectile.GameObjectToDestroyAfterTime::target  /*0x0400008D*/
    IL_002a: callvirt !!0 UnityEngine.GameObject::GetComponent()<DisablePooledObjectAfterTime>  /*0x2B000008*/
    IL_002f: stloc.2
    IL_0030: ldloc.2
    IL_0031: ldnull
    IL_0032: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0037: brfalse.s IL_003f
    IL_0039: ldloc.2
    IL_003a: callvirt void DisablePooledObjectAfterTime::ResetDisabledObject()  /*0x06000E8C*/
    IL_003f: ldloca.s 0
    IL_0041: call bool System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>::MoveNext()  /*0x0A000060*/
    IL_0046: brtrue.s IL_000e
    IL_0048: leave.s IL_0058
    IL_004a: ldloca.s 0
    IL_004c: constrained. System.Collections.Generic.List.Enumerator<AimbotProjectile.GameObjectToDestroyAfterTime>  /*0x1B00000F*/
    IL_0052: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0057: endfinally
    IL_0058: ret
    .try IL_000c-IL_004a finally handler IL_004a-IL_0058

  .method AimbotProjectile::.ctor()  // token 0x06000089 rva 0x4728 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<AimbotProjectile.GameObjectToDestroyAfterTime>::.ctor()  /*0x0A000078*/
    IL_0006: stfld List<AimbotProjectile.GameObjectToDestroyAfterTime> AimbotProjectile::objectsToUnparentOnDestroy  /*0x0400007C*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent AimbotProjectile::onHit  /*0x0400008A*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== AimbotProjectile/GameObjectToDestroyAfterTime  (token 0x02000015) =====
  .method AimbotProjectile.GameObjectToDestroyAfterTime::.ctor()  // token 0x0600008A rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

