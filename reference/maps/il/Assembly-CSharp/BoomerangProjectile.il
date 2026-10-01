// ===== BoomerangProjectile  (token 0x020000D2) =====
  .method BoomerangProjectile::Fire(Weapon,Hp,float,UnityEngine.Vector3,TaggedObject,float,float)  // token 0x06000459 rva 0x133cc attrs Public, Virtual, HideBySig
    // code size 185 (0xb9), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0007: ldarg.0
    IL_0008: ldarg.s 6
    IL_000a: stfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_000f: ldarg.0
    IL_0010: ldarg.0
    IL_0011: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_0016: ldfld float Weapon::projectileSpeed  /*0x04001818*/
    IL_001b: ldarg.s 7
    IL_001d: mul
    IL_001e: stfld float AimbotProjectile::speed  /*0x0400008B*/
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: stfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_0034: ldarg.0
    IL_0035: ldarg.s 5
    IL_0037: stfld TaggedObject BoomerangProjectile::source  /*0x0400058E*/
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld Vector3 AimbotProjectile::spawnPosition  /*0x04000083*/
    IL_0043: stfld Vector3 BoomerangProjectile::sourcePosition  /*0x0400058B*/
    IL_0048: ldarg.0
    IL_0049: ldc.i4.1
    IL_004a: stfld bool BoomerangProjectile::launched  /*0x0400058F*/
    IL_004f: ldarg.0
    IL_0050: ldarg.0
    IL_0051: ldfld Vector3 BoomerangProjectile::targetPoint  /*0x0400058A*/
    IL_0056: pop
    IL_0057: ldarg.2
    IL_0058: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0062: ldarg.0
    IL_0063: ldfld Vector3 BoomerangProjectile::sourcePosition  /*0x0400058B*/
    IL_0068: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_006d: stloc.0
    IL_006e: ldloca.s 0
    IL_0070: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0075: stfld Vector3 BoomerangProjectile::direction  /*0x0400058C*/
    IL_007a: ldarg.0
    IL_007b: ldflda Vector3 BoomerangProjectile::direction  /*0x0400058C*/
    IL_0080: ldc.r4 0f
    IL_0085: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_008a: ldarg.0
    IL_008b: ldarg.0
    IL_008c: ldfld Vector3 BoomerangProjectile::sourcePosition  /*0x0400058B*/
    IL_0091: ldarg.0
    IL_0092: ldflda Vector3 BoomerangProjectile::direction  /*0x0400058C*/
    IL_0097: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_009c: ldarg.0
    IL_009d: ldfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_00a2: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a7: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00ac: stfld Vector3 BoomerangProjectile::targetPoint  /*0x0400058A*/
    IL_00b1: ldarg.0
    IL_00b2: ldc.i4.1
    IL_00b3: call void BoomerangProjectile::BeginPhase(BoomerangProjectile.Phase)  /*0x0600045B*/
    IL_00b8: ret

  .method BoomerangProjectile::Update()  // token 0x0600045A rva 0x13494 attrs Family, Virtual, HideBySig
    // code size 105 (0x69), max stack 6, init locals
    .locals ([0] BoomerangProjectile.Phase)
    IL_0000: ldarg.0
    IL_0001: ldfld bool BoomerangProjectile::launched  /*0x0400058F*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld BoomerangProjectile.Phase BoomerangProjectile::phase  /*0x04000592*/
    IL_000f: stloc.0
    IL_0010: ldloc.0
    IL_0011: ldc.i4.1
    IL_0012: beq.s IL_001a
    IL_0014: ldloc.0
    IL_0015: ldc.i4.3
    IL_0016: beq.s IL_003b
    IL_0018: br.s IL_005a
    IL_001a: ldarg.0
    IL_001b: ldarg.0
    IL_001c: ldfld Vector3 BoomerangProjectile::sourcePosition  /*0x0400058B*/
    IL_0021: ldarg.0
    IL_0022: ldfld Vector3 BoomerangProjectile::targetPoint  /*0x0400058A*/
    IL_0027: ldarg.0
    IL_0028: ldfld float BoomerangProjectile::flyOutSpeed  /*0x0400057F*/
    IL_002d: ldarg.0
    IL_002e: ldfld AnimationCurve BoomerangProjectile::flyOutSpeedCurve  /*0x04000581*/
    IL_0033: ldc.i4.2
    IL_0034: call void BoomerangProjectile::UpdateFly(UnityEngine.Vector3,UnityEngine.Vector3,float,UnityEngine.AnimationCurve,BoomerangProjectile.Phase)  /*0x0600045C*/
    IL_0039: br.s IL_005a
    IL_003b: ldarg.0
    IL_003c: ldarg.0
    IL_003d: ldfld Vector3 BoomerangProjectile::targetPoint  /*0x0400058A*/
    IL_0042: ldarg.0
    IL_0043: ldfld Vector3 BoomerangProjectile::sourcePosition  /*0x0400058B*/
    IL_0048: ldarg.0
    IL_0049: ldfld float BoomerangProjectile::flyBackSpeed  /*0x04000580*/
    IL_004e: ldarg.0
    IL_004f: ldfld AnimationCurve BoomerangProjectile::flyBackSpeedCurve  /*0x04000582*/
    IL_0054: ldc.i4.4
    IL_0055: call void BoomerangProjectile::UpdateFly(UnityEngine.Vector3,UnityEngine.Vector3,float,UnityEngine.AnimationCurve,BoomerangProjectile.Phase)  /*0x0600045C*/
    IL_005a: ldarg.0
    IL_005b: ldfld BoomerangProjectile.Phase BoomerangProjectile::phase  /*0x04000592*/
    IL_0060: brfalse.s IL_0068
    IL_0062: ldarg.0
    IL_0063: call void BoomerangProjectile::DealDamage()  /*0x0600045E*/
    IL_0068: ret

  .method BoomerangProjectile::BeginPhase(BoomerangProjectile.Phase)  // token 0x0600045B rva 0x13509 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld BoomerangProjectile.Phase BoomerangProjectile::phase  /*0x04000592*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 0f
    IL_000d: stfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_0012: ldarg.1
    IL_0013: ldc.i4.2
    IL_0014: bne.un.s IL_0023
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: call IEnumerator BoomerangProjectile::LingerRoutine()  /*0x0600045D*/
    IL_001d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0022: pop
    IL_0023: ldarg.1
    IL_0024: ldc.i4.4
    IL_0025: bne.un.s IL_002d
    IL_0027: ldarg.0
    IL_0028: call void BoomerangProjectile::OnReturnComplete()  /*0x0600045F*/
    IL_002d: ret

  .method BoomerangProjectile::UpdateFly(UnityEngine.Vector3,UnityEngine.Vector3,float,UnityEngine.AnimationCurve,BoomerangProjectile.Phase)  // token 0x0600045C rva 0x13538 attrs Private, HideBySig
    // code size 205 (0xcd), max stack 5, init locals
    .locals ([0] float, [1] RaycastHit, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_0006: ldarg.0
    IL_0007: ldfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_000c: div
    IL_000d: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0012: stloc.0
    IL_0013: ldarg.0
    IL_0014: ldarg.3
    IL_0015: ldarg.s 4
    IL_0017: ldloc.0
    IL_0018: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_001d: mul
    IL_001e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0023: mul
    IL_0024: stfld float BoomerangProjectile::speedStep  /*0x0400058D*/
    IL_0029: ldarg.0
    IL_002a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0034: ldarg.0
    IL_0035: ldfld Vector3 BoomerangProjectile::direction  /*0x0400058C*/
    IL_003a: ldloca.s 1
    IL_003c: ldarg.0
    IL_003d: ldfld float BoomerangProjectile::speedStep  /*0x0400058D*/
    IL_0042: ldarg.0
    IL_0043: ldfld LayerMask BoomerangProjectile::obstacleLayerMask  /*0x04000585*/
    IL_0048: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_004d: call bool UnityEngine.Physics::Raycast(UnityEngine.Vector3,UnityEngine.Vector3,ref UnityEngine.RaycastHit,float,int)  /*0x0A0001F8*/
    IL_0052: brfalse.s IL_0072
    IL_0054: ldarg.0
    IL_0055: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005a: ldloca.s 1
    IL_005c: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000171*/
    IL_0061: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0066: ldarg.0
    IL_0067: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_006c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0071: ret
    IL_0072: ldarg.0
    IL_0073: ldarg.0
    IL_0074: ldfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_0079: ldarg.0
    IL_007a: ldfld float BoomerangProjectile::speedStep  /*0x0400058D*/
    IL_007f: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_0084: add
    IL_0085: ldarg.0
    IL_0086: ldfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_008b: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_0090: stfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_0095: ldarg.0
    IL_0096: ldfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_009b: ldarg.0
    IL_009c: ldfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_00a1: div
    IL_00a2: stloc.2
    IL_00a3: ldarg.0
    IL_00a4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a9: ldarg.1
    IL_00aa: ldarg.2
    IL_00ab: ldloc.2
    IL_00ac: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00b1: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00b6: ldarg.0
    IL_00b7: ldfld float BoomerangProjectile::distanceTravelled  /*0x04000590*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_00c2: blt.un.s IL_00cc
    IL_00c4: ldarg.0
    IL_00c5: ldarg.s 5
    IL_00c7: call void BoomerangProjectile::BeginPhase(BoomerangProjectile.Phase)  /*0x0600045B*/
    IL_00cc: ret

  .method BoomerangProjectile::LingerRoutine()  // token 0x0600045D rva 0x13611 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BoomerangProjectile.<LingerRoutine>d__26::.ctor(int)  /*0x06000462*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BoomerangProjectile BoomerangProjectile.<LingerRoutine>d__26::<>4__this  /*0x0400059B*/
    IL_000d: ret

  .method BoomerangProjectile::DealDamage()  // token 0x0600045E rva 0x13620 attrs Private, HideBySig
    // code size 344 (0x158), max stack 6, init locals
    .locals ([0] Vector3, [1] HashSet<int>, [2] RaycastHit[], [3] int, [4] RaycastHit, [5] int, [6] Hp, [7] TaggedObject, [8] HashSet.Enumerator<int>, [9] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0010: ldarg.0
    IL_0011: ldfld float BoomerangProjectile::damageHalfHeight  /*0x04000587*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_001b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0020: ldarg.0
    IL_0021: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0026: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0030: ldarg.0
    IL_0031: ldfld float BoomerangProjectile::damageHalfHeight  /*0x04000587*/
    IL_0036: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0040: stloc.0
    IL_0041: newobj void System.Collections.Generic.HashSet<int>::.ctor()  /*0x0A0001F9*/
    IL_0046: stloc.1
    IL_0047: ldloc.0
    IL_0048: ldarg.0
    IL_0049: ldfld float BoomerangProjectile::damageRadius  /*0x04000586*/
    IL_004e: ldarg.0
    IL_004f: ldfld Vector3 BoomerangProjectile::direction  /*0x0400058C*/
    IL_0054: ldarg.0
    IL_0055: ldfld float BoomerangProjectile::speedStep  /*0x0400058D*/
    IL_005a: ldarg.0
    IL_005b: ldfld LayerMask BoomerangProjectile::damageLayerMask  /*0x04000584*/
    IL_0060: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0065: call RaycastHit[] UnityEngine.Physics::CapsuleCastAll(UnityEngine.Vector3,UnityEngine.Vector3,float,UnityEngine.Vector3,float,int)  /*0x0A0001FA*/
    IL_006a: stloc.2
    IL_006b: ldc.i4.0
    IL_006c: stloc.3
    IL_006d: br IL_0109
    IL_0072: ldloc.2
    IL_0073: ldloc.3
    IL_0074: ldelem UnityEngine.RaycastHit  /*0x0100006D*/
    IL_0079: stloc.s 4
    IL_007b: ldloca.s 4
    IL_007d: call int UnityEngine.RaycastHit::get_colliderInstanceID()  /*0x0A0001FB*/
    IL_0082: stloc.s 5
    IL_0084: ldloc.1
    IL_0085: ldloc.s 5
    IL_0087: callvirt bool System.Collections.Generic.HashSet<int>::Add(!0)  /*0x0A0001FC*/
    IL_008c: pop
    IL_008d: ldarg.0
    IL_008e: ldfld HashSet<int> BoomerangProjectile::lastUnitsInside  /*0x04000591*/
    IL_0093: ldloc.s 5
    IL_0095: callvirt bool System.Collections.Generic.HashSet<int>::Contains(!0)  /*0x0A0001FD*/
    IL_009a: brtrue.s IL_0105
    IL_009c: ldloca.s 4
    IL_009e: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A0001FE*/
    IL_00a3: callvirt !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_00a8: stloc.s 6
    IL_00aa: ldloca.s 4
    IL_00ac: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A0001FE*/
    IL_00b1: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_00b6: stloc.s 7
    IL_00b8: ldloc.s 6
    IL_00ba: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00bf: brfalse.s IL_0105
    IL_00c1: ldloc.s 7
    IL_00c3: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c8: brfalse.s IL_0105
    IL_00ca: ldarg.0
    IL_00cb: ldloc.s 7
    IL_00cd: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00d2: ldarg.0
    IL_00d3: ldfld List<TagManager.ETag> BoomerangProjectile::mustHaveTags  /*0x04000588*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld List<TagManager.ETag> BoomerangProjectile::mayNotHaveTags  /*0x04000589*/
    IL_00de: call bool BoomerangProjectile::HasValidTags(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000460*/
    IL_00e3: brfalse.s IL_0105
    IL_00e5: ldarg.0
    IL_00e6: ldfld Weapon AimbotProjectile::weapon  /*0x0400007A*/
    IL_00eb: dup
    IL_00ec: brtrue.s IL_00f1
    IL_00ee: pop
    IL_00ef: br.s IL_0105
    IL_00f1: ldloc.s 6
    IL_00f3: ldarg.0
    IL_00f4: ldfld float AimbotProjectile::finalDamageMultiplyer  /*0x04000085*/
    IL_00f9: ldarg.0
    IL_00fa: ldfld TaggedObject BoomerangProjectile::source  /*0x0400058E*/
    IL_00ff: ldc.i4.0
    IL_0100: call void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_0105: ldloc.3
    IL_0106: ldc.i4.1
    IL_0107: add
    IL_0108: stloc.3
    IL_0109: ldloc.3
    IL_010a: ldloc.2
    IL_010b: ldlen
    IL_010c: conv.i4
    IL_010d: blt IL_0072
    IL_0112: ldarg.0
    IL_0113: ldfld HashSet<int> BoomerangProjectile::lastUnitsInside  /*0x04000591*/
    IL_0118: callvirt void System.Collections.Generic.HashSet<int>::Clear()  /*0x0A0001FF*/
    IL_011d: ldloc.1
    IL_011e: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<int>::GetEnumerator()  /*0x0A000200*/
    IL_0123: stloc.s 8
    IL_0125: br.s IL_013e
    IL_0127: ldloca.s 8
    IL_0129: call !0 System.Collections.Generic.HashSet.Enumerator<int>::get_Current()  /*0x0A000201*/
    IL_012e: stloc.s 9
    IL_0130: ldarg.0
    IL_0131: ldfld HashSet<int> BoomerangProjectile::lastUnitsInside  /*0x04000591*/
    IL_0136: ldloc.s 9
    IL_0138: callvirt bool System.Collections.Generic.HashSet<int>::Add(!0)  /*0x0A0001FC*/
    IL_013d: pop
    IL_013e: ldloca.s 8
    IL_0140: call bool System.Collections.Generic.HashSet.Enumerator<int>::MoveNext()  /*0x0A000202*/
    IL_0145: brtrue.s IL_0127
    IL_0147: leave.s IL_0157
    IL_0149: ldloca.s 8
    IL_014b: constrained. System.Collections.Generic.HashSet.Enumerator<int>  /*0x1B00004D*/
    IL_0151: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0156: endfinally
    IL_0157: ret
    .try IL_0125-IL_0149 finally handler IL_0149-IL_0157

  .method BoomerangProjectile::OnReturnComplete()  // token 0x0600045F rva 0x13794 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_000b: ret

  .method BoomerangProjectile::HasValidTags(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  // token 0x06000460 rva 0x137a4 attrs Private, HideBySig
    // code size 123 (0x7b), max stack 2, init locals
    .locals ([0] HashSet<TagManager.ETag>, [1] List.Enumerator<TagManager.ETag>, [2] TagManager.ETag, [3] bool, [4] TagManager.ETag)
    IL_0000: ldarg.1
    IL_0001: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001E7*/
    IL_0006: stloc.0
    IL_0007: ldarg.2
    IL_0008: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_000d: stloc.1
    IL_000e: br.s IL_0025
    IL_0010: ldloca.s 1
    IL_0012: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_0017: stloc.2
    IL_0018: ldloc.0
    IL_0019: ldloc.2
    IL_001a: callvirt bool System.Collections.Generic.HashSet<TagManager.ETag>::Contains(!0)  /*0x0A000203*/
    IL_001f: brtrue.s IL_0025
    IL_0021: ldc.i4.0
    IL_0022: stloc.3
    IL_0023: leave.s IL_0079
    IL_0025: ldloca.s 1
    IL_0027: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_002c: brtrue.s IL_0010
    IL_002e: leave.s IL_003e
    IL_0030: ldloca.s 1
    IL_0032: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0038: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003d: endfinally
    IL_003e: ldarg.3
    IL_003f: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_0044: stloc.1
    IL_0045: br.s IL_005e
    IL_0047: ldloca.s 1
    IL_0049: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_004e: stloc.s 4
    IL_0050: ldloc.0
    IL_0051: ldloc.s 4
    IL_0053: callvirt bool System.Collections.Generic.HashSet<TagManager.ETag>::Contains(!0)  /*0x0A000203*/
    IL_0058: brfalse.s IL_005e
    IL_005a: ldc.i4.0
    IL_005b: stloc.3
    IL_005c: leave.s IL_0079
    IL_005e: ldloca.s 1
    IL_0060: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_0065: brtrue.s IL_0047
    IL_0067: leave.s IL_0077
    IL_0069: ldloca.s 1
    IL_006b: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0071: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0076: endfinally
    IL_0077: ldc.i4.1
    IL_0078: ret
    IL_0079: ldloc.3
    IL_007a: ret
    .try IL_000e-IL_0030 finally handler IL_0030-IL_003e
    .try IL_0045-IL_0069 finally handler IL_0069-IL_0077

  .method BoomerangProjectile::.ctor()  // token 0x06000461 rva 0x13848 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 8f
    IL_0006: stfld float BoomerangProjectile::travelDistance  /*0x0400057E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float BoomerangProjectile::flyOutSpeed  /*0x0400057F*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 14f
    IL_001c: stfld float BoomerangProjectile::flyBackSpeed  /*0x04000580*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 1.5f
    IL_0027: stfld float BoomerangProjectile::lingerDuration  /*0x04000583*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.5f
    IL_0032: stfld float BoomerangProjectile::damageRadius  /*0x04000586*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0.5f
    IL_003d: stfld float BoomerangProjectile::damageHalfHeight  /*0x04000587*/
    IL_0042: ldarg.0
    IL_0043: newobj void System.Collections.Generic.HashSet<int>::.ctor()  /*0x0A0001F9*/
    IL_0048: stfld HashSet<int> BoomerangProjectile::lastUnitsInside  /*0x04000591*/
    IL_004d: ldarg.0
    IL_004e: call void AimbotProjectile::.ctor()  /*0x06000089*/
    IL_0053: ret

// ===== BoomerangProjectile/Phase  (token 0x020000D3) =====
// ===== BoomerangProjectile/<LingerRoutine>d__26  (token 0x020000D4) =====
  .method BoomerangProjectile.<LingerRoutine>d__26::.ctor(int)  // token 0x06000462 rva 0x138a8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BoomerangProjectile.<LingerRoutine>d__26::<>1__state  /*0x04000599*/
    IL_000d: ret

  .method BoomerangProjectile.<LingerRoutine>d__26::System.IDisposable.Dispose()  // token 0x06000463 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BoomerangProjectile.<LingerRoutine>d__26::MoveNext()  // token 0x06000464 rva 0x138b8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 72 (0x48), max stack 2, init locals
    .locals ([0] int, [1] BoomerangProjectile)
    IL_0000: ldarg.0
    IL_0001: ldfld int BoomerangProjectile.<LingerRoutine>d__26::<>1__state  /*0x04000599*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BoomerangProjectile BoomerangProjectile.<LingerRoutine>d__26::<>4__this  /*0x0400059B*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int BoomerangProjectile.<LingerRoutine>d__26::<>1__state  /*0x04000599*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float BoomerangProjectile::lingerDuration  /*0x04000583*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object BoomerangProjectile.<LingerRoutine>d__26::<>2__current  /*0x0400059A*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int BoomerangProjectile.<LingerRoutine>d__26::<>1__state  /*0x04000599*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int BoomerangProjectile.<LingerRoutine>d__26::<>1__state  /*0x04000599*/
    IL_003f: ldloc.1
    IL_0040: ldc.i4.3
    IL_0041: call void BoomerangProjectile::BeginPhase(BoomerangProjectile.Phase)  /*0x0600045B*/
    IL_0046: ldc.i4.0
    IL_0047: ret

  .method BoomerangProjectile.<LingerRoutine>d__26::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000465 rva 0x1390c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BoomerangProjectile.<LingerRoutine>d__26::<>2__current  /*0x0400059A*/
    IL_0006: ret

  .method BoomerangProjectile.<LingerRoutine>d__26::System.Collections.IEnumerator.Reset()  // token 0x06000466 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BoomerangProjectile.<LingerRoutine>d__26::System.Collections.IEnumerator.get_Current()  // token 0x06000467 rva 0x1390c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BoomerangProjectile.<LingerRoutine>d__26::<>2__current  /*0x0400059A*/
    IL_0006: ret

