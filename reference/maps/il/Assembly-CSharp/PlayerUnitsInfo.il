// ===== PlayerUnitsInfo  (token 0x02000392) =====
  .method PlayerUnitsInfo::Awake()  // token 0x060013A9 rva 0x5d422 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld PlayerUnitsInfo PlayerUnitsInfo::instance  /*0x040017EA*/
    IL_0006: ret

  .method PlayerUnitsInfo::GetUnitsInfo()  // token 0x060013AA rva 0x5d42c attrs Public, HideBySig
    // code size 689 (0x2b1), max stack 4, init locals
    .locals ([0] List<TagManager.ETag>, [1] List<TagManager.ETag>, [2] List<TaggedObject>, [3] UnitsInfo, [4] List.Enumerator<TaggedObject>, [5] ScreenMarkerIcon, [6] Hp, [7] PathfindMovementPlayerunit, [8] AutoAttack, [9] UnitInfo, [10] List.Enumerator<UnitInfo>, [11] UnitInfo, [12] List.Enumerator<TargetPriority>, [13] TargetPriority, [14] float, [15] int, [16] DamageModifyer)
    IL_0000: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0005: stloc.0
    IL_0006: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_000b: stloc.1
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stloc.2
    IL_0012: ldloc.0
    IL_0013: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_0018: ldloc.1
    IL_0019: callvirt void System.Collections.Generic.List<TagManager.ETag>::Clear()  /*0x0A000012*/
    IL_001e: ldloc.0
    IL_001f: ldc.i4.7
    IL_0020: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0025: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_002a: ldloc.2
    IL_002b: ldloc.0
    IL_002c: ldloc.1
    IL_002d: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0032: newobj void UnitsInfo::.ctor()  /*0x060013AC*/
    IL_0037: stloc.3
    IL_0038: ldloc.2
    IL_0039: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_003e: stloc.s 4
    IL_0040: br IL_0293
    IL_0045: ldloca.s 4
    IL_0047: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_004c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0051: dup
    IL_0052: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIcon>  /*0x2B000058*/
    IL_0057: stloc.s 5
    IL_0059: dup
    IL_005a: callvirt !!0 UnityEngine.GameObject::GetComponent()<Hp>  /*0x2B000021*/
    IL_005f: stloc.s 6
    IL_0061: dup
    IL_0062: callvirt !!0 UnityEngine.GameObject::GetComponent()<PathfindMovementPlayerunit>  /*0x2B000111*/
    IL_0067: stloc.s 7
    IL_0069: callvirt !!0 UnityEngine.GameObject::GetComponent()<AutoAttack>  /*0x2B00005C*/
    IL_006e: stloc.s 8
    IL_0070: ldnull
    IL_0071: stloc.s 9
    IL_0073: ldloc.s 5
    IL_0075: ldnull
    IL_0076: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_007b: brfalse.s IL_00ed
    IL_007d: ldloc.3
    IL_007e: ldfld List<UnitInfo> UnitsInfo::Units  /*0x040017EB*/
    IL_0083: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnitInfo>::GetEnumerator()  /*0x0A0006F4*/
    IL_0088: stloc.s 10
    IL_008a: br.s IL_00d4
    IL_008c: ldloca.s 10
    IL_008e: call !0 System.Collections.Generic.List.Enumerator<UnitInfo>::get_Current()  /*0x0A0006F5*/
    IL_0093: stloc.s 11
    IL_0095: ldloc.s 5
    IL_0097: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_009c: ldloc.s 11
    IL_009e: ldfld Sprite UnitInfo::unitIcon  /*0x040017EC*/
    IL_00a3: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00a8: brfalse.s IL_00d4
    IL_00aa: ldloc.s 5
    IL_00ac: callvirt string ScreenMarkerIcon::get_UnitName()  /*0x06000D41*/
    IL_00b1: ldloc.s 11
    IL_00b3: ldfld string UnitInfo::unitName  /*0x040017ED*/
    IL_00b8: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00bd: brfalse.s IL_00d4
    IL_00bf: ldloc.s 11
    IL_00c1: stloc.s 9
    IL_00c3: ldloc.s 9
    IL_00c5: dup
    IL_00c6: ldfld int UnitInfo::unitCount  /*0x040017EF*/
    IL_00cb: ldc.i4.1
    IL_00cc: add
    IL_00cd: stfld int UnitInfo::unitCount  /*0x040017EF*/
    IL_00d2: leave.s IL_00ed
    IL_00d4: ldloca.s 10
    IL_00d6: call bool System.Collections.Generic.List.Enumerator<UnitInfo>::MoveNext()  /*0x0A0006F6*/
    IL_00db: brtrue.s IL_008c
    IL_00dd: leave.s IL_00ed
    IL_00df: ldloca.s 10
    IL_00e1: constrained. System.Collections.Generic.List.Enumerator<UnitInfo>  /*0x1B000148*/
    IL_00e7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ec: endfinally
    IL_00ed: ldloc.s 9
    IL_00ef: brtrue IL_0293
    IL_00f4: newobj void UnitInfo::.ctor()  /*0x060013AD*/
    IL_00f9: stloc.s 9
    IL_00fb: ldloc.s 9
    IL_00fd: ldloc.s 5
    IL_00ff: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0104: stfld Sprite UnitInfo::unitIcon  /*0x040017EC*/
    IL_0109: ldloc.s 9
    IL_010b: ldloc.s 5
    IL_010d: callvirt string ScreenMarkerIcon::get_UnitName()  /*0x06000D41*/
    IL_0112: stfld string UnitInfo::unitName  /*0x040017ED*/
    IL_0117: ldloc.s 9
    IL_0119: ldloc.s 5
    IL_011b: callvirt string ScreenMarkerIcon::get_UnitDescription()  /*0x06000D40*/
    IL_0120: stfld string UnitInfo::unitDescription  /*0x040017EE*/
    IL_0125: ldloc.s 9
    IL_0127: dup
    IL_0128: ldfld int UnitInfo::unitCount  /*0x040017EF*/
    IL_012d: ldc.i4.1
    IL_012e: add
    IL_012f: stfld int UnitInfo::unitCount  /*0x040017EF*/
    IL_0134: ldloc.s 6
    IL_0136: ldnull
    IL_0137: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_013c: brfalse.s IL_014c
    IL_013e: ldloc.s 9
    IL_0140: ldloc.s 6
    IL_0142: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0147: stfld float UnitInfo::maxHP  /*0x040017F1*/
    IL_014c: ldloc.s 7
    IL_014e: ldnull
    IL_014f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0154: brfalse.s IL_0164
    IL_0156: ldloc.s 9
    IL_0158: ldloc.s 7
    IL_015a: ldfld float PathfindMovementPlayerunit::movementSpeed  /*0x04000E01*/
    IL_015f: stfld float UnitInfo::speed  /*0x040017F2*/
    IL_0164: ldloc.s 8
    IL_0166: ldnull
    IL_0167: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_016c: brfalse IL_0286
    IL_0171: ldloc.s 9
    IL_0173: ldloc.s 8
    IL_0175: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_017a: stfld float UnitInfo::attackCooldown  /*0x040017F5*/
    IL_017f: ldloc.s 8
    IL_0181: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0186: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_018b: ldc.i4.0
    IL_018c: ble.s IL_01f8
    IL_018e: ldloc.s 9
    IL_0190: ldloc.s 8
    IL_0192: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0197: ldc.i4.0
    IL_0198: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_019d: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_01a2: stfld float UnitInfo::range  /*0x040017F3*/
    IL_01a7: ldloc.s 8
    IL_01a9: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_01ae: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_01b3: stloc.s 12
    IL_01b5: br.s IL_01df
    IL_01b7: ldloca.s 12
    IL_01b9: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_01be: stloc.s 13
    IL_01c0: ldloc.s 13
    IL_01c2: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_01c7: ldc.i4.1
    IL_01c8: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_01cd: brfalse.s IL_01df
    IL_01cf: ldloc.s 9
    IL_01d1: ldloc.s 13
    IL_01d3: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_01d8: stfld float UnitInfo::range  /*0x040017F3*/
    IL_01dd: leave.s IL_01f8
    IL_01df: ldloca.s 12
    IL_01e1: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_01e6: brtrue.s IL_01b7
    IL_01e8: leave.s IL_01f8
    IL_01ea: ldloca.s 12
    IL_01ec: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_01f2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01f7: endfinally
    IL_01f8: ldloc.s 8
    IL_01fa: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_01ff: ldnull
    IL_0200: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0205: brfalse.s IL_0286
    IL_0207: ldc.r4 0f
    IL_020c: stloc.s 14
    IL_020e: ldc.i4.0
    IL_020f: stloc.s 15
    IL_0211: br.s IL_0255
    IL_0213: ldloc.s 8
    IL_0215: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_021a: ldfld List<DamageModifyer> Weapon::directDamage  /*0x04001829*/
    IL_021f: ldloc.s 15
    IL_0221: callvirt !0 System.Collections.Generic.List<DamageModifyer>::get_Item(int)  /*0x0A00019D*/
    IL_0226: stloc.s 16
    IL_0228: ldloc.s 16
    IL_022a: ldfld List<TagManager.ETag> DamageModifyer::requiredTags  /*0x040004A6*/
    IL_022f: ldc.i4.1
    IL_0230: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0235: brfalse.s IL_024f
    IL_0237: ldloc.s 14
    IL_0239: ldloc.s 16
    IL_023b: ldfld float DamageModifyer::damageAdded  /*0x040004A7*/
    IL_0240: add
    IL_0241: stloc.s 14
    IL_0243: ldloc.s 14
    IL_0245: ldloc.s 16
    IL_0247: ldfld float DamageModifyer::damageMultiplyer  /*0x040004A8*/
    IL_024c: mul
    IL_024d: stloc.s 14
    IL_024f: ldloc.s 15
    IL_0251: ldc.i4.1
    IL_0252: add
    IL_0253: stloc.s 15
    IL_0255: ldloc.s 15
    IL_0257: ldloc.s 8
    IL_0259: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_025e: ldfld List<DamageModifyer> Weapon::directDamage  /*0x04001829*/
    IL_0263: callvirt int System.Collections.Generic.List<DamageModifyer>::get_Count()  /*0x0A00019E*/
    IL_0268: blt.s IL_0213
    IL_026a: ldloc.s 9
    IL_026c: ldloc.s 14
    IL_026e: stfld float UnitInfo::attackDamage  /*0x040017F4*/
    IL_0273: ldloc.s 9
    IL_0275: ldloc.s 8
    IL_0277: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_027c: ldfld float Weapon::projectileSpeed  /*0x04001818*/
    IL_0281: stfld float UnitInfo::projectileSpeed  /*0x040017F6*/
    IL_0286: ldloc.3
    IL_0287: ldfld List<UnitInfo> UnitsInfo::Units  /*0x040017EB*/
    IL_028c: ldloc.s 9
    IL_028e: callvirt void System.Collections.Generic.List<UnitInfo>::Add(!0)  /*0x0A00077B*/
    IL_0293: ldloca.s 4
    IL_0295: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_029a: brtrue IL_0045
    IL_029f: leave.s IL_02af
    IL_02a1: ldloca.s 4
    IL_02a3: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_02a9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02ae: endfinally
    IL_02af: ldloc.3
    IL_02b0: ret
    .try IL_008a-IL_00df finally handler IL_00df-IL_00ed
    .try IL_01b5-IL_01ea finally handler IL_01ea-IL_01f8
    .try IL_0040-IL_02a1 finally handler IL_02a1-IL_02af

  .method PlayerUnitsInfo::.ctor()  // token 0x060013AB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

