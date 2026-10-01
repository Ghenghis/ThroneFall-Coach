// ===== LightningWandMA  (token 0x020001E6) =====
  .method LightningWandMA::Start()  // token 0x060009F9 rva 0x2f117 attrs Public, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ldarg.0
    IL_0007: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000c: stfld TagManager LightningWandMA::tagManager  /*0x04000CB5*/
    IL_0011: ret

  .method LightningWandMA::Attack()  // token 0x060009FA rva 0x2f12c attrs Public, Virtual, HideBySig
    // code size 538 (0x21a), max stack 7, init locals
    .locals ([0] TaggedObject, [1] float, [2] int, [3] int, [4] int, [5] List.Enumerator<TaggedObject>, [6] Hp)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0018
    IL_000d: ldarg.0
    IL_000e: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0013: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0018: ldarg.0
    IL_0019: ldfld bool ManualAttack::playOneShotOnAttack  /*0x04000CC0*/
    IL_001e: brfalse.s IL_002b
    IL_0020: ldarg.0
    IL_0021: ldfld ThronefallAudioManager.AudioOneShot ManualAttack::oneshotOnAttack  /*0x04000CC1*/
    IL_0026: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.1
    IL_002d: callvirt TaggedObject ManualAttack::FindAttackTarget(bool)  /*0x06000A08*/
    IL_0032: stloc.0
    IL_0033: ldloc.0
    IL_0034: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0039: brtrue.s IL_003c
    IL_003b: ret
    IL_003c: ldloc.0
    IL_003d: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0042: pop
    IL_0043: ldarg.0
    IL_0044: ldloc.0
    IL_0045: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004f: stfld Vector3 ManualAttack::lastTargetPos  /*0x04000CCB*/
    IL_0054: ldarg.0
    IL_0055: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_005a: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_005f: ldarg.0
    IL_0060: ldfld TagManager LightningWandMA::tagManager  /*0x04000CB5*/
    IL_0065: ldarg.0
    IL_0066: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_006b: ldarg.0
    IL_006c: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0071: ldc.i4.0
    IL_0072: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0077: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_007c: ldarg.0
    IL_007d: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0082: ldc.i4.0
    IL_0083: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0088: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_008d: callvirt void TagManager::FindAllTaggedObjectsWithTags(System.Collections.Generic.List<TaggedObject>,System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>)  /*0x06000E5B*/
    IL_0092: ldarg.0
    IL_0093: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0098: ldc.i4.0
    IL_0099: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_009e: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_00a3: stloc.1
    IL_00a4: ldarg.0
    IL_00a5: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_00aa: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00af: ldc.i4.1
    IL_00b0: sub
    IL_00b1: stloc.2
    IL_00b2: br.s IL_00e9
    IL_00b4: ldarg.0
    IL_00b5: ldfld TagManager LightningWandMA::tagManager  /*0x04000CB5*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_00c0: ldloc.2
    IL_00c1: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_00c6: ldarg.0
    IL_00c7: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00cc: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00d1: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_00d6: ldloc.1
    IL_00d7: ble.un.s IL_00e5
    IL_00d9: ldarg.0
    IL_00da: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_00df: ldloc.2
    IL_00e0: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveAt(int)  /*0x0A000483*/
    IL_00e5: ldloc.2
    IL_00e6: ldc.i4.1
    IL_00e7: sub
    IL_00e8: stloc.2
    IL_00e9: ldloc.2
    IL_00ea: ldc.i4.0
    IL_00eb: bge.s IL_00b4
    IL_00ed: ldarg.0
    IL_00ee: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_00f3: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00f8: ldc.i4.1
    IL_00f9: sub
    IL_00fa: stloc.3
    IL_00fb: br IL_018a
    IL_0100: ldarg.0
    IL_0101: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_0106: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_010b: ldc.i4.1
    IL_010c: sub
    IL_010d: stloc.s 4
    IL_010f: br.s IL_0181
    IL_0111: ldloc.3
    IL_0112: ldloc.s 4
    IL_0114: beq.s IL_017b
    IL_0116: ldarg.0
    IL_0117: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_011c: ldloc.3
    IL_011d: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0122: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0127: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_012c: ldarg.0
    IL_012d: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_0132: ldloc.s 4
    IL_0134: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0139: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_013e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0143: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_0148: ldarg.0
    IL_0149: ldfld float LightningWandMA::distanceBetweenAttacks  /*0x04000CB6*/
    IL_014e: bge.un.s IL_017b
    IL_0150: ldarg.0
    IL_0151: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_0156: ldloc.s 4
    IL_0158: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_015d: ldloc.0
    IL_015e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0163: brfalse.s IL_017b
    IL_0165: ldarg.0
    IL_0166: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_016b: ldloc.s 4
    IL_016d: callvirt void System.Collections.Generic.List<TaggedObject>::RemoveAt(int)  /*0x0A000483*/
    IL_0172: ldloc.s 4
    IL_0174: ldloc.3
    IL_0175: bge.s IL_017b
    IL_0177: ldloc.3
    IL_0178: ldc.i4.1
    IL_0179: sub
    IL_017a: stloc.3
    IL_017b: ldloc.s 4
    IL_017d: ldc.i4.1
    IL_017e: sub
    IL_017f: stloc.s 4
    IL_0181: ldloc.s 4
    IL_0183: ldc.i4.0
    IL_0184: bge.s IL_0111
    IL_0186: ldloc.3
    IL_0187: ldc.i4.1
    IL_0188: sub
    IL_0189: stloc.3
    IL_018a: ldloc.3
    IL_018b: ldc.i4.0
    IL_018c: bge IL_0100
    IL_0191: ldarg.0
    IL_0192: ldfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_0197: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_019c: stloc.s 5
    IL_019e: br.s IL_0200
    IL_01a0: ldloca.s 5
    IL_01a2: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_01a7: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_01ac: stloc.s 6
    IL_01ae: ldloc.s 6
    IL_01b0: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01b5: brfalse.s IL_0200
    IL_01b7: ldarg.0
    IL_01b8: ldfld Weapon ManualAttack::weapon  /*0x04000CB9*/
    IL_01bd: ldarg.0
    IL_01be: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01c3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01c8: ldarg.0
    IL_01c9: ldfld float ManualAttack::spawnAttackHeight  /*0x04000CB7*/
    IL_01ce: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01d3: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_01d8: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_01dd: ldloc.s 6
    IL_01df: ldarg.0
    IL_01e0: ldfld Transform ManualAttack::transformForAttackDirection  /*0x04000CBB*/
    IL_01e5: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_01ea: ldarg.0
    IL_01eb: ldfld TaggedObject ManualAttack::myTaggedObj  /*0x04000CC8*/
    IL_01f0: ldarg.0
    IL_01f1: call float ManualAttack::get_AttackDamageMultiplyer()  /*0x060009FC*/
    IL_01f6: ldc.r4 1f
    IL_01fb: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0200: ldloca.s 5
    IL_0202: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0207: brtrue.s IL_01a0
    IL_0209: leave.s IL_0219
    IL_020b: ldloca.s 5
    IL_020d: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_0213: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0218: endfinally
    IL_0219: ret
    .try IL_019e-IL_020b finally handler IL_020b-IL_0219

  .method LightningWandMA::.ctor()  // token 0x060009FB rva 0x2f364 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0006: stfld List<TaggedObject> LightningWandMA::possibleAttackTargets  /*0x04000CB4*/
    IL_000b: ldarg.0
    IL_000c: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0011: ret

