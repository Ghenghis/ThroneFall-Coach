// ===== ExplosionWeapon  (token 0x020000F7) =====
  .method ExplosionWeapon::Explode(UnityEngine.Transform,System.Action,System.Action)  // token 0x06000530 rva 0x16bd4 attrs Public, HideBySig
    // code size 194 (0xc2), max stack 5, init locals
    .locals ([0] List<TaggedObject>, [1] float, [2] float, [3] int, [4] float, [5] float)
    IL_0000: ldarg.0
    IL_0001: ldfld TargetPriority ExplosionWeapon::targetPriority  /*0x040006BD*/
    IL_0006: ldarg.1
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000c: callvirt List<TaggedObject> TargetPriority::FindUnsortedTaggedObjectsInRange(UnityEngine.Vector3)  /*0x06000E73*/
    IL_0011: stloc.0
    IL_0012: ldarg.0
    IL_0013: ldfld float ExplosionWeapon::maxKnockbackForce  /*0x040006BE*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_003f
    IL_001f: ldarg.1
    IL_0020: ldarg.0
    IL_0021: ldfld TargetPriority ExplosionWeapon::targetPriority  /*0x040006BD*/
    IL_0026: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_002b: ldarg.0
    IL_002c: ldfld float ExplosionWeapon::maxKnockbackForce  /*0x040006BE*/
    IL_0031: call KnockbackUtils.KnockbackData KnockbackUtils.KnockbackData::FullCircle(UnityEngine.Transform,float,float)  /*0x060013BC*/
    IL_0036: ldloc.0
    IL_0037: ldarg.2
    IL_0038: ldarg.3
    IL_0039: call bool KnockbackUtils::ApplyRadialKnockback(KnockbackUtils.KnockbackData,System.Collections.Generic.List<TaggedObject>,System.Action,System.Action)  /*0x060013B3*/
    IL_003e: pop
    IL_003f: ldarg.0
    IL_0040: ldfld TargetPriority ExplosionWeapon::targetPriority  /*0x040006BD*/
    IL_0045: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_004a: ldarg.0
    IL_004b: ldfld TargetPriority ExplosionWeapon::targetPriority  /*0x040006BD*/
    IL_0050: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0055: mul
    IL_0056: stloc.1
    IL_0057: ldarg.0
    IL_0058: ldfld float ExplosionWeapon::explosionDamageOnEdge  /*0x040006C0*/
    IL_005d: ldarg.0
    IL_005e: ldfld float ExplosionWeapon::explosionDamageInCenter  /*0x040006BF*/
    IL_0063: sub
    IL_0064: stloc.2
    IL_0065: ldc.i4.0
    IL_0066: stloc.3
    IL_0067: br.s IL_00b8
    IL_0069: ldloc.0
    IL_006a: ldloc.3
    IL_006b: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0070: ldarg.1
    IL_0071: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0076: callvirt float TaggedObject::GetSqrDistance(UnityEngine.Vector3)  /*0x06000E50*/
    IL_007b: ldloc.1
    IL_007c: div
    IL_007d: stloc.s 4
    IL_007f: ldc.r4 1f
    IL_0084: ldloc.2
    IL_0085: ldloc.s 4
    IL_0087: mul
    IL_0088: sub
    IL_0089: stloc.s 5
    IL_008b: ldloc.0
    IL_008c: ldloc.3
    IL_008d: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0092: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0097: ldloc.0
    IL_0098: ldloc.3
    IL_0099: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_009e: ldarg.0
    IL_009f: ldfld List<DamageModifyer> ExplosionWeapon::damageModifyers  /*0x040006BC*/
    IL_00a4: ldloc.s 5
    IL_00a6: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_00ab: ldnull
    IL_00ac: ldc.i4.0
    IL_00ad: ldc.i4.1
    IL_00ae: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00b3: pop
    IL_00b4: ldloc.3
    IL_00b5: ldc.i4.1
    IL_00b6: add
    IL_00b7: stloc.3
    IL_00b8: ldloc.3
    IL_00b9: ldloc.0
    IL_00ba: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00bf: blt.s IL_0069
    IL_00c1: ret

  .method ExplosionWeapon::.ctor()  // token 0x06000531 rva 0x16ca2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<DamageModifyer>::.ctor()  /*0x0A000211*/
    IL_0006: stfld List<DamageModifyer> ExplosionWeapon::damageModifyers  /*0x040006BC*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float ExplosionWeapon::maxKnockbackForce  /*0x040006BE*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float ExplosionWeapon::explosionDamageInCenter  /*0x040006BF*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1f
    IL_0027: stfld float ExplosionWeapon::explosionDamageOnEdge  /*0x040006C0*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0032: ret

