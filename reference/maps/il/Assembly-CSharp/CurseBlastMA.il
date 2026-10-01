// ===== CurseBlastMA  (token 0x020001E2) =====
  .method CurseBlastMA::Awake()  // token 0x060009E7 rva 0x2eae8 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld CurseBlastMA CurseBlastMA::instance  /*0x04000C97*/
    IL_0006: ret

  .method CurseBlastMA::AddCursedHp(Hp,Weapon,TaggedObject,float)  // token 0x060009E8 rva 0x2eaf0 attrs Public, HideBySig
    // code size 152 (0x98), max stack 5, init locals
    .locals ([0] GameObject, [1] List.Enumerator<Hp>, [2] Hp)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<Hp>::GetEnumerator()  /*0x0A0003DC*/
    IL_000b: stloc.1
    IL_000c: br.s IL_0021
    IL_000e: ldloca.s 1
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<Hp>::get_Current()  /*0x0A0003DD*/
    IL_0015: stloc.2
    IL_0016: ldarg.2
    IL_0017: ldloc.2
    IL_0018: ldarg.s 4
    IL_001a: ldnull
    IL_001b: ldc.i4.0
    IL_001c: callvirt void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_0021: ldloca.s 1
    IL_0023: call bool System.Collections.Generic.List.Enumerator<Hp>::MoveNext()  /*0x0A0003DE*/
    IL_0028: brtrue.s IL_000e
    IL_002a: leave.s IL_003a
    IL_002c: ldloca.s 1
    IL_002e: constrained. System.Collections.Generic.List.Enumerator<Hp>  /*0x1B0000B2*/
    IL_0034: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0039: endfinally
    IL_003a: ldarg.0
    IL_003b: ldfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_0040: ldarg.1
    IL_0041: callvirt bool System.Collections.Generic.List<Hp>::Contains(!0)  /*0x0A0003C1*/
    IL_0046: brfalse.s IL_0049
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: ldfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_004f: ldarg.1
    IL_0050: callvirt void System.Collections.Generic.List<Hp>::Add(!0)  /*0x0A0003C2*/
    IL_0055: ldarg.3
    IL_0056: ldc.i4.s 36
    IL_0058: callvirt void TaggedObject::AddTag(TagManager.ETag)  /*0x06000E49*/
    IL_005d: ldarg.0
    IL_005e: ldfld List<TaggedObject> CurseBlastMA::cursedTags  /*0x04000C99*/
    IL_0063: ldarg.3
    IL_0064: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_0069: ldarg.0
    IL_006a: ldfld GameObject CurseBlastMA::cursedMarkerPrefab  /*0x04000C9B*/
    IL_006f: ldarg.1
    IL_0070: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0075: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007a: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_007f: ldarg.1
    IL_0080: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0085: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_008a: stloc.0
    IL_008b: ldarg.0
    IL_008c: ldfld List<GameObject> CurseBlastMA::cursedMarkers  /*0x04000C9A*/
    IL_0091: ldloc.0
    IL_0092: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0097: ret
    .try IL_000c-IL_002c finally handler IL_002c-IL_003a

  .method CurseBlastMA::Attack()  // token 0x060009E9 rva 0x2eba4 attrs Public, Virtual, HideBySig
    // code size 361 (0x169), max stack 5, init locals
    .locals ([0] List.Enumerator<Hp>, [1] Hp, [2] List.Enumerator<TaggedObject>, [3] List.Enumerator<GameObject>, [4] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject CurseBlastMA::activatePlayerFX  /*0x04000C9D*/
    IL_0006: ldarg.0
    IL_0007: ldfld Transform CurseBlastMA::playerFXOrigin  /*0x04000C9E*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0016: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_001b: callvirt !!0 UnityEngine.GameObject::AddComponent()<FollowTransform>  /*0x2B00009F*/
    IL_0020: ldarg.0
    IL_0021: ldfld Transform CurseBlastMA::playerFXOrigin  /*0x04000C9E*/
    IL_0026: stfld Transform FollowTransform::target  /*0x0400094D*/
    IL_002b: ldarg.0
    IL_002c: ldfld AudioSource CurseBlastMA::blastAudio  /*0x04000C9F*/
    IL_0031: ldc.r4 0.9f
    IL_0036: ldc.r4 1.1f
    IL_003b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0040: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0045: ldarg.0
    IL_0046: ldfld AudioSource CurseBlastMA::blastAudio  /*0x04000C9F*/
    IL_004b: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0050: ldarg.0
    IL_0051: ldfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_0056: callvirt List.Enumerator<!0> System.Collections.Generic.List<Hp>::GetEnumerator()  /*0x0A0003DC*/
    IL_005b: stloc.0
    IL_005c: br.s IL_00b8
    IL_005e: ldloca.s 0
    IL_0060: call !0 System.Collections.Generic.List.Enumerator<Hp>::get_Current()  /*0x0A0003DD*/
    IL_0065: stloc.1
    IL_0066: ldarg.0
    IL_0067: ldfld Weapon ManualAttack::weapon  /*0x04000CB9*/
    IL_006c: ldloc.1
    IL_006d: ldarg.0
    IL_006e: call float ManualAttack::get_AttackDamageMultiplyer()  /*0x060009FC*/
    IL_0073: ldnull
    IL_0074: ldc.i4.0
    IL_0075: callvirt void Weapon::DealDamage(Hp,float,TaggedObject,bool)  /*0x060013CD*/
    IL_007a: ldloc.1
    IL_007b: ldnull
    IL_007c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0081: brfalse.s IL_00b8
    IL_0083: ldarg.0
    IL_0084: ldfld GameObject CurseBlastMA::curseBlastFX  /*0x04000C9C*/
    IL_0089: ldloc.1
    IL_008a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_008f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0094: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0099: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_009e: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_00a3: callvirt !!0 UnityEngine.GameObject::AddComponent()<FollowTransform>  /*0x2B00009F*/
    IL_00a8: ldloc.1
    IL_00a9: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ae: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00b3: stfld Transform FollowTransform::target  /*0x0400094D*/
    IL_00b8: ldloca.s 0
    IL_00ba: call bool System.Collections.Generic.List.Enumerator<Hp>::MoveNext()  /*0x0A0003DE*/
    IL_00bf: brtrue.s IL_005e
    IL_00c1: leave.s IL_00d1
    IL_00c3: ldloca.s 0
    IL_00c5: constrained. System.Collections.Generic.List.Enumerator<Hp>  /*0x1B0000B2*/
    IL_00cb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00d0: endfinally
    IL_00d1: ldarg.0
    IL_00d2: ldfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_00d7: callvirt void System.Collections.Generic.List<Hp>::Clear()  /*0x0A000482*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld List<TaggedObject> CurseBlastMA::cursedTags  /*0x04000C99*/
    IL_00e2: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_00e7: stloc.2
    IL_00e8: br.s IL_00f8
    IL_00ea: ldloca.s 2
    IL_00ec: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_00f1: ldc.i4.s 36
    IL_00f3: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_00f8: ldloca.s 2
    IL_00fa: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00ff: brtrue.s IL_00ea
    IL_0101: leave.s IL_0111
    IL_0103: ldloca.s 2
    IL_0105: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_010b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0110: endfinally
    IL_0111: ldarg.0
    IL_0112: ldfld List<TaggedObject> CurseBlastMA::cursedTags  /*0x04000C99*/
    IL_0117: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_011c: ldarg.0
    IL_011d: ldfld List<GameObject> CurseBlastMA::cursedMarkers  /*0x04000C9A*/
    IL_0122: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0127: stloc.3
    IL_0128: br.s IL_0144
    IL_012a: ldloca.s 3
    IL_012c: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0131: stloc.s 4
    IL_0133: ldloc.s 4
    IL_0135: ldnull
    IL_0136: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_013b: brfalse.s IL_0144
    IL_013d: ldloc.s 4
    IL_013f: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0144: ldloca.s 3
    IL_0146: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_014b: brtrue.s IL_012a
    IL_014d: leave.s IL_015d
    IL_014f: ldloca.s 3
    IL_0151: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0157: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_015c: endfinally
    IL_015d: ldarg.0
    IL_015e: ldfld List<GameObject> CurseBlastMA::cursedMarkers  /*0x04000C9A*/
    IL_0163: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_0168: ret
    .try IL_005c-IL_00c3 finally handler IL_00c3-IL_00d1
    .try IL_00e8-IL_0103 finally handler IL_0103-IL_0111
    .try IL_0128-IL_014f finally handler IL_014f-IL_015d

  .method CurseBlastMA::.ctor()  // token 0x060009EA rva 0x2ed44 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Hp>::.ctor()  /*0x0A0003C5*/
    IL_0006: stfld List<Hp> CurseBlastMA::cursedHps  /*0x04000C98*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stfld List<TaggedObject> CurseBlastMA::cursedTags  /*0x04000C99*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_001c: stfld List<GameObject> CurseBlastMA::cursedMarkers  /*0x04000C9A*/
    IL_0021: ldarg.0
    IL_0022: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0027: ret

