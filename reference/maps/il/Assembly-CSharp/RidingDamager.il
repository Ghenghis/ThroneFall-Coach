// ===== RidingDamager  (token 0x02000254) =====
  .method RidingDamager::get_DamageMultiplyer()  // token 0x06000CB3 rva 0x3a512 attrs Public, HideBySig, SpecialName
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerUpgradeManager RidingDamager::upgradeManager  /*0x04000F67*/
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_000b: ldarg.0
    IL_000c: ldfld BlacksmithUpgrades RidingDamager::blacksmithUpgrades  /*0x04000F68*/
    IL_0011: ldfld float BlacksmithUpgrades::meleeDamage  /*0x04000B80*/
    IL_0016: mul
    IL_0017: ret

  .method RidingDamager::Start()  // token 0x06000CB4 rva 0x3a52c attrs Private, HideBySig
    // code size 109 (0x6d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Equippable RidingDamager::requiredUpgradeForRidingDamage  /*0x04000F5F*/
    IL_0007: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000c: stfld bool RidingDamager::ridingDamage  /*0x04000F6D*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld Equippable RidingDamager::requiredUpgradeForRidingSlow  /*0x04000F60*/
    IL_0018: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_001d: stfld bool RidingDamager::ridingSlow  /*0x04000F6E*/
    IL_0022: ldarg.0
    IL_0023: ldfld bool RidingDamager::ridingDamage  /*0x04000F6D*/
    IL_0028: brtrue.s IL_003e
    IL_002a: ldarg.0
    IL_002b: ldfld bool RidingDamager::ridingSlow  /*0x04000F6E*/
    IL_0030: brtrue.s IL_003e
    IL_0032: ldarg.0
    IL_0033: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0038: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.BoxCollider>  /*0x2B00001C*/
    IL_0045: stfld BoxCollider RidingDamager::myCollider  /*0x04000F63*/
    IL_004a: ldarg.0
    IL_004b: ldarg.0
    IL_004c: call !!0 UnityEngine.Component::GetComponentInParent()<PlayerMovement>  /*0x2B0000AC*/
    IL_0051: stfld PlayerMovement RidingDamager::playerMovement  /*0x04000F66*/
    IL_0056: ldarg.0
    IL_0057: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_005c: stfld PlayerUpgradeManager RidingDamager::upgradeManager  /*0x04000F67*/
    IL_0061: ldarg.0
    IL_0062: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0067: stfld BlacksmithUpgrades RidingDamager::blacksmithUpgrades  /*0x04000F68*/
    IL_006c: ret

  .method RidingDamager::Update()  // token 0x06000CB5 rva 0x3a5a8 attrs Private, HideBySig
    // code size 276 (0x114), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] Matrix4x4, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_000b: stloc.2
    IL_000c: ldloca.s 2
    IL_000e: ldarg.0
    IL_000f: ldfld BoxCollider RidingDamager::myCollider  /*0x04000F63*/
    IL_0014: callvirt Vector3 UnityEngine.BoxCollider::get_center()  /*0x0A0004BB*/
    IL_0019: call Vector3 UnityEngine.Matrix4x4::MultiplyPoint(UnityEngine.Vector3)  /*0x0A0000A5*/
    IL_001e: stloc.0
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_002a: stloc.2
    IL_002b: ldloca.s 2
    IL_002d: ldarg.0
    IL_002e: ldfld BoxCollider RidingDamager::myCollider  /*0x04000F63*/
    IL_0033: callvirt Vector3 UnityEngine.BoxCollider::get_size()  /*0x0A000103*/
    IL_0038: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_003d: stloc.1
    IL_003e: ldarg.0
    IL_003f: ldfld PlayerMovement RidingDamager::playerMovement  /*0x04000F66*/
    IL_0044: callvirt bool PlayerMovement::get_Moving()  /*0x06000C1D*/
    IL_0049: brfalse.s IL_00be
    IL_004b: ldarg.0
    IL_004c: ldfld PlayerMovement RidingDamager::playerMovement  /*0x04000F66*/
    IL_0051: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0056: brfalse.s IL_00be
    IL_0058: ldarg.0
    IL_0059: ldfld Hp RidingDamager::playerHp  /*0x04000F5D*/
    IL_005e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0063: ldc.r4 0f
    IL_0068: ble.un.s IL_00be
    IL_006a: ldloc.0
    IL_006b: ldloc.1
    IL_006c: ldarg.0
    IL_006d: ldfld Collider[] RidingDamager::tempColliders  /*0x04000F64*/
    IL_0072: ldarg.0
    IL_0073: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0078: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_007d: ldarg.0
    IL_007e: ldfld LayerMask RidingDamager::lmRecieveDamage  /*0x04000F61*/
    IL_0083: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0088: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_008d: stloc.3
    IL_008e: ldc.i4.0
    IL_008f: stloc.s 4
    IL_0091: br.s IL_00b9
    IL_0093: ldarg.0
    IL_0094: ldfld Collider[] RidingDamager::tempColliders  /*0x04000F64*/
    IL_0099: ldloc.s 4
    IL_009b: ldelem.ref
    IL_009c: ldnull
    IL_009d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00a2: brtrue.s IL_00be
    IL_00a4: ldarg.0
    IL_00a5: ldarg.0
    IL_00a6: ldfld Collider[] RidingDamager::tempColliders  /*0x04000F64*/
    IL_00ab: ldloc.s 4
    IL_00ad: ldelem.ref
    IL_00ae: call void RidingDamager::DealWithColliderHit(UnityEngine.Collider)  /*0x06000CB6*/
    IL_00b3: ldloc.s 4
    IL_00b5: ldc.i4.1
    IL_00b6: add
    IL_00b7: stloc.s 4
    IL_00b9: ldloc.s 4
    IL_00bb: ldloc.3
    IL_00bc: blt.s IL_0093
    IL_00be: ldarg.0
    IL_00bf: ldarg.0
    IL_00c0: ldfld float RidingDamager::time  /*0x04000F6C*/
    IL_00c5: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00ca: add
    IL_00cb: stfld float RidingDamager::time  /*0x04000F6C*/
    IL_00d0: br.s IL_0105
    IL_00d2: ldarg.0
    IL_00d3: ldfld float RidingDamager::time  /*0x04000F6C*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld List<float> RidingDamager::recentlyHitWhen  /*0x04000F6B*/
    IL_00de: ldc.i4.0
    IL_00df: callvirt !0 System.Collections.Generic.List<float>::get_Item(int)  /*0x0A00030A*/
    IL_00e4: sub
    IL_00e5: ldarg.0
    IL_00e6: ldfld float RidingDamager::cooldownPerObject  /*0x04000F65*/
    IL_00eb: ble.un.s IL_0113
    IL_00ed: ldarg.0
    IL_00ee: ldfld List<float> RidingDamager::recentlyHitWhen  /*0x04000F6B*/
    IL_00f3: ldc.i4.0
    IL_00f4: callvirt void System.Collections.Generic.List<float>::RemoveAt(int)  /*0x0A0004F3*/
    IL_00f9: ldarg.0
    IL_00fa: ldfld List<TaggedObject> RidingDamager::recentlyHit  /*0x04000F6A*/
    IL_00ff: ldc.i4.0
    IL_0100: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveAt(int)  /*0x0A000483*/
    IL_0105: ldarg.0
    IL_0106: ldfld List<float> RidingDamager::recentlyHitWhen  /*0x04000F6B*/
    IL_010b: callvirt int System.Collections.Generic.List<float>::get_Count()  /*0x0A000494*/
    IL_0110: ldc.i4.0
    IL_0111: bgt.s IL_00d2
    IL_0113: ret

  .method RidingDamager::DealWithColliderHit(UnityEngine.Collider)  // token 0x06000CB6 rva 0x3a6c8 attrs Private, HideBySig
    // code size 208 (0xd0), max stack 5, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000d: brtrue.s IL_0010
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld List<TaggedObject> RidingDamager::recentlyHit  /*0x04000F6A*/
    IL_0016: ldloc.0
    IL_0017: callvirt bool System.Collections.Generic.List<TaggedObject>::Contains(!0)  /*0x0A00021D*/
    IL_001c: brfalse.s IL_001f
    IL_001e: ret
    IL_001f: ldloc.0
    IL_0020: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0025: ldc.i4.1
    IL_0026: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_002b: brtrue.s IL_002e
    IL_002d: ret
    IL_002e: ldloc.0
    IL_002f: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0034: ldnull
    IL_0035: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003a: brfalse.s IL_003d
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: ldfld bool RidingDamager::ridingDamage  /*0x04000F6D*/
    IL_0043: brfalse.s IL_0082
    IL_0045: ldloc.0
    IL_0046: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_004b: ldloc.0
    IL_004c: ldarg.0
    IL_004d: ldfld List<DamageModifyer> RidingDamager::damage  /*0x04000F62*/
    IL_0052: ldarg.0
    IL_0053: call float RidingDamager::get_DamageMultiplyer()  /*0x06000CB3*/
    IL_0058: call float Weapon::CalculateDamageGeneral(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x060013D0*/
    IL_005d: ldnull
    IL_005e: ldc.i4.0
    IL_005f: ldc.i4.1
    IL_0060: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0065: pop
    IL_0066: ldarg.0
    IL_0067: ldfld Hp RidingDamager::playerHp  /*0x04000F5D*/
    IL_006c: ldarg.0
    IL_006d: ldfld float RidingDamager::selfInflictedDamagePerHit  /*0x04000F5E*/
    IL_0072: ldarg.0
    IL_0073: call float RidingDamager::get_DamageMultiplyer()  /*0x06000CB3*/
    IL_0078: mul
    IL_0079: ldnull
    IL_007a: ldc.i4.0
    IL_007b: ldc.i4.1
    IL_007c: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0081: pop
    IL_0082: ldarg.0
    IL_0083: ldfld bool RidingDamager::ridingSlow  /*0x04000F6E*/
    IL_0088: brfalse.s IL_00b2
    IL_008a: ldloc.0
    IL_008b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0090: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0095: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009a: brfalse.s IL_00b2
    IL_009c: ldloc.0
    IL_009d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00a2: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld float RidingDamager::slowDuration  /*0x04000F69*/
    IL_00ad: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_00b2: ldarg.0
    IL_00b3: ldfld List<TaggedObject> RidingDamager::recentlyHit  /*0x04000F6A*/
    IL_00b8: ldloc.0
    IL_00b9: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_00be: ldarg.0
    IL_00bf: ldfld List<float> RidingDamager::recentlyHitWhen  /*0x04000F6B*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld float RidingDamager::time  /*0x04000F6C*/
    IL_00ca: callvirt void System.Collections.Generic.List<float>::Add(!0)  /*0x0A000309*/
    IL_00cf: ret

  .method RidingDamager::.ctor()  // token 0x06000CB7 rva 0x3a7a4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 75 (0x4b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float RidingDamager::selfInflictedDamagePerHit  /*0x04000F5E*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.s 50
    IL_000e: newarr UnityEngine.Collider  /*0x01000032*/
    IL_0013: stfld Collider[] RidingDamager::tempColliders  /*0x04000F64*/
    IL_0018: ldarg.0
    IL_0019: ldc.r4 4f
    IL_001e: stfld float RidingDamager::cooldownPerObject  /*0x04000F65*/
    IL_0023: ldarg.0
    IL_0024: ldc.r4 1f
    IL_0029: stfld float RidingDamager::slowDuration  /*0x04000F69*/
    IL_002e: ldarg.0
    IL_002f: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0034: stfld List<TaggedObject> RidingDamager::recentlyHit  /*0x04000F6A*/
    IL_0039: ldarg.0
    IL_003a: newobj void System.Collections.Generic.List<float>::.ctor()  /*0x0A0002D3*/
    IL_003f: stfld List<float> RidingDamager::recentlyHitWhen  /*0x04000F6B*/
    IL_0044: ldarg.0
    IL_0045: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_004a: ret

