// ===== LaunchableProjectile  (token 0x020001A7) =====
  .method LaunchableProjectile::Launch()  // token 0x06000891 rva 0x29620 attrs Public, HideBySig
    // code size 91 (0x5b), max stack 4, init locals
    .locals ([0] RaycastHit)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool LaunchableProjectile::launched  /*0x04000AB5*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool LaunchableProjectile::groundedTranslation  /*0x04000AAF*/
    IL_000d: brfalse.s IL_005a
    IL_000f: ldarg.0
    IL_0010: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0015: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001a: call Vector3 UnityEngine.Vector3::get_down()  /*0x0A00016E*/
    IL_001f: newobj void UnityEngine.Ray::.ctor(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00016F*/
    IL_0024: ldloca.s 0
    IL_0026: ldc.r4 Infinityf
    IL_002b: ldarg.0
    IL_002c: ldfld LayerMask LaunchableProjectile::groundLayer  /*0x04000AB0*/
    IL_0031: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0036: call bool UnityEngine.Physics::Raycast(UnityEngine.Ray,ref UnityEngine.RaycastHit,float,int)  /*0x0A000170*/
    IL_003b: brfalse.s IL_005a
    IL_003d: ldarg.0
    IL_003e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0043: ldloca.s 0
    IL_0045: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000171*/
    IL_004a: ldarg.0
    IL_004b: ldfld Vector3 LaunchableProjectile::groundingOfffset  /*0x04000AB1*/
    IL_0050: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0055: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_005a: ret

  .method LaunchableProjectile::Update()  // token 0x06000892 rva 0x29688 attrs Private, HideBySig
    // code size 258 (0x102), max stack 5, init locals
    .locals ([0] int, [1] int, [2] Hp)
    IL_0000: ldarg.0
    IL_0001: ldfld bool LaunchableProjectile::launched  /*0x04000AB5*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld float LaunchableProjectile::timer  /*0x04000AB6*/
    IL_0010: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0015: add
    IL_0016: stfld float LaunchableProjectile::timer  /*0x04000AB6*/
    IL_001b: ldarg.0
    IL_001c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: dup
    IL_0022: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0027: ldarg.0
    IL_0028: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002d: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0032: ldarg.0
    IL_0033: ldfld float LaunchableProjectile::speed  /*0x04000AAD*/
    IL_0038: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0042: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0047: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_004c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0051: ldarg.0
    IL_0052: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0057: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005c: ldarg.0
    IL_005d: ldfld Vector3 LaunchableProjectile::damageBoxExtents  /*0x04000AB4*/
    IL_0062: ldc.r4 2f
    IL_0067: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_006c: ldsfld Collider[] LaunchableProjectile::overlapBuffer  /*0x04000AB8*/
    IL_0071: ldarg.0
    IL_0072: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0077: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_007c: ldarg.0
    IL_007d: ldfld LayerMask LaunchableProjectile::hitLayer  /*0x04000AB3*/
    IL_0082: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0087: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_008c: stloc.0
    IL_008d: ldc.i4.0
    IL_008e: stloc.1
    IL_008f: br.s IL_00e4
    IL_0091: ldsfld Collider[] LaunchableProjectile::overlapBuffer  /*0x04000AB8*/
    IL_0096: ldloc.1
    IL_0097: ldelem.ref
    IL_0098: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_009d: stloc.2
    IL_009e: ldloc.2
    IL_009f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00a4: brfalse.s IL_00e0
    IL_00a6: ldarg.0
    IL_00a7: ldfld List<Hp> LaunchableProjectile::touchedEnemies  /*0x04000AB7*/
    IL_00ac: ldloc.2
    IL_00ad: callvirt bool System.Collections.Generic.List<Hp>::Contains(!0)  /*0x0A0003C1*/
    IL_00b2: brtrue.s IL_00e0
    IL_00b4: ldarg.0
    IL_00b5: ldfld List<Hp> LaunchableProjectile::touchedEnemies  /*0x04000AB7*/
    IL_00ba: ldloc.2
    IL_00bb: callvirt void System.Collections.Generic.List<Hp>::Add(!0)  /*0x0A0003C2*/
    IL_00c0: ldloc.2
    IL_00c1: ldloc.2
    IL_00c2: callvirt TaggedObject Hp::get_TaggedObj()  /*0x06000816*/
    IL_00c7: ldarg.0
    IL_00c8: ldfld List<DamageModifyer> LaunchableProjectile::dmgModifiers  /*0x04000AB2*/
    IL_00cd: ldc.r4 1f
    IL_00d2: call float DamageModifyer::CalculateDamageOnTarget(TaggedObject,System.Collections.Generic.List<DamageModifyer>,float)  /*0x0600039B*/
    IL_00d7: ldnull
    IL_00d8: ldc.i4.0
    IL_00d9: ldc.i4.1
    IL_00da: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_00df: pop
    IL_00e0: ldloc.1
    IL_00e1: ldc.i4.1
    IL_00e2: add
    IL_00e3: stloc.1
    IL_00e4: ldloc.1
    IL_00e5: ldloc.0
    IL_00e6: blt.s IL_0091
    IL_00e8: ldarg.0
    IL_00e9: ldfld float LaunchableProjectile::timer  /*0x04000AB6*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld float LaunchableProjectile::lifetime  /*0x04000AAE*/
    IL_00f4: blt.un.s IL_0101
    IL_00f6: ldarg.0
    IL_00f7: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00fc: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0101: ret

  .method LaunchableProjectile::OnDrawGizmos()  // token 0x06000893 rva 0x29796 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: call Color UnityEngine.Color::get_magenta()  /*0x0A0003C3*/
    IL_0005: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0015: ldarg.0
    IL_0016: ldfld Vector3 LaunchableProjectile::damageBoxExtents  /*0x04000AB4*/
    IL_001b: call void UnityEngine.Gizmos::DrawWireCube(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0003C4*/
    IL_0020: ret

  .method LaunchableProjectile::.ctor()  // token 0x06000894 rva 0x297b8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 20f
    IL_0006: stfld float LaunchableProjectile::speed  /*0x04000AAD*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float LaunchableProjectile::lifetime  /*0x04000AAE*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<DamageModifyer>::.ctor()  /*0x0A000211*/
    IL_001c: stfld List<DamageModifyer> LaunchableProjectile::dmgModifiers  /*0x04000AB2*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<Hp>::.ctor()  /*0x0A0003C5*/
    IL_0027: stfld List<Hp> LaunchableProjectile::touchedEnemies  /*0x04000AB7*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

  .method LaunchableProjectile::.cctor()  // token 0x06000895 rva 0x297ec attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldc.i4.s 64
    IL_0002: newarr UnityEngine.Collider  /*0x01000032*/
    IL_0007: stsfld Collider[] LaunchableProjectile::overlapBuffer  /*0x04000AB8*/
    IL_000c: ret

