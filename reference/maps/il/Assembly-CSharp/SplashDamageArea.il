// ===== SplashDamageArea  (token 0x02000294) =====
  .method SplashDamageArea::OnDrawGizmosSelected()  // token 0x06000E2E rva 0x3f50c attrs Private, HideBySig
    // code size 95 (0x5f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld SplashDamageArea.EShape SplashDamageArea::shape  /*0x04001072*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_0034
    IL_0009: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_000e: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_0013: ldarg.0
    IL_0014: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_001e: call void UnityEngine.Gizmos::set_matrix(UnityEngine.Matrix4x4)  /*0x0A0005B4*/
    IL_0023: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0028: ldarg.0
    IL_0029: ldfld Vector3 SplashDamageArea::boxSize  /*0x04001073*/
    IL_002e: call void UnityEngine.Gizmos::DrawWireCube(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0003C4*/
    IL_0033: ret
    IL_0034: call Color UnityEngine.Color::get_red()  /*0x0A00015E*/
    IL_0039: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_003e: ldarg.0
    IL_003f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0044: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0049: call void UnityEngine.Gizmos::set_matrix(UnityEngine.Matrix4x4)  /*0x0A0005B4*/
    IL_004e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0053: ldarg.0
    IL_0054: ldfld float SplashDamageArea::sphereRadius  /*0x04001074*/
    IL_0059: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_005e: ret

  .method SplashDamageArea::AddReiveDamageHpScriptsInAreaToList(System.Collections.Generic.List<Hp>)  // token 0x06000E2F rva 0x3f578 attrs Public, HideBySig
    // code size 153 (0x99), max stack 5, init locals
    .locals ([0] int, [1] int, [2] Hp)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld SplashDamageArea.EShape SplashDamageArea::shape  /*0x04001072*/
    IL_0008: ldc.i4.1
    IL_0009: bne.un.s IL_003f
    IL_000b: ldarg.0
    IL_000c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: ldarg.0
    IL_0017: ldfld Vector3 SplashDamageArea::boxSize  /*0x04001073*/
    IL_001c: ldsfld Collider[] SplashDamageArea::collidersTemp  /*0x04001076*/
    IL_0021: ldarg.0
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002c: ldarg.0
    IL_002d: ldfld LayerMask SplashDamageArea::layerMaskRecieveDamage  /*0x04001075*/
    IL_0032: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0037: call int UnityEngine.Physics::OverlapBoxNonAlloc(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Collider[],UnityEngine.Quaternion,int)  /*0x0A000106*/
    IL_003c: stloc.0
    IL_003d: br.s IL_0066
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004a: ldarg.0
    IL_004b: ldfld float SplashDamageArea::sphereRadius  /*0x04001074*/
    IL_0050: ldsfld Collider[] SplashDamageArea::collidersTemp  /*0x04001076*/
    IL_0055: ldarg.0
    IL_0056: ldfld LayerMask SplashDamageArea::layerMaskRecieveDamage  /*0x04001075*/
    IL_005b: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0060: call int UnityEngine.Physics::OverlapSphereNonAlloc(UnityEngine.Vector3,float,UnityEngine.Collider[],int)  /*0x0A0004F2*/
    IL_0065: stloc.0
    IL_0066: ldc.i4.0
    IL_0067: stloc.1
    IL_0068: br.s IL_0094
    IL_006a: ldsfld Collider[] SplashDamageArea::collidersTemp  /*0x04001076*/
    IL_006f: ldloc.1
    IL_0070: ldelem.ref
    IL_0071: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_0076: stloc.2
    IL_0077: ldloc.2
    IL_0078: ldnull
    IL_0079: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_007e: brtrue.s IL_0090
    IL_0080: ldarg.1
    IL_0081: ldloc.2
    IL_0082: callvirt bool System.Collections.Generic.List<Hp>::Contains(!0)  /*0x0A0003C1*/
    IL_0087: brtrue.s IL_0090
    IL_0089: ldarg.1
    IL_008a: ldloc.2
    IL_008b: callvirt void System.Collections.Generic.List<Hp>::Add(!0)  /*0x0A0003C2*/
    IL_0090: ldloc.1
    IL_0091: ldc.i4.1
    IL_0092: add
    IL_0093: stloc.1
    IL_0094: ldloc.1
    IL_0095: ldloc.0
    IL_0096: blt.s IL_006a
    IL_0098: ret

  .method SplashDamageArea::.ctor()  // token 0x06000E30 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

  .method SplashDamageArea::.cctor()  // token 0x06000E31 rva 0x3f61d attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: ldc.i4 200
    IL_0005: newarr UnityEngine.Collider  /*0x01000032*/
    IL_000a: stsfld Collider[] SplashDamageArea::collidersTemp  /*0x04001076*/
    IL_000f: ret

// ===== SplashDamageArea/EShape  (token 0x02000295) =====
