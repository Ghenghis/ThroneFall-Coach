// ===== AutoAttackFlamethrower  (token 0x020000C8) =====
  .method AutoAttackFlamethrower::get_IsActive()  // token 0x0600042E rva 0x1214d attrs Public, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method AutoAttackFlamethrower::Start()  // token 0x0600042F rva 0x12158 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: call void AutoAttackFlamethrower::Init()  /*0x06000430*/
    IL_000c: ret

  .method AutoAttackFlamethrower::Init()  // token 0x06000430 rva 0x12168 attrs Private, HideBySig
    // code size 104 (0x68), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float AutoAttackFlamethrower::_flameDuration  /*0x04000559*/
    IL_000e: stfld float AutoAttackFlamethrower::_flameTimer  /*0x0400055F*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld float AutoAttackFlamethrower::_towerToFlameOffset  /*0x0400055E*/
    IL_001a: ldc.r4 0f
    IL_001f: ldc.r4 0f
    IL_0024: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0029: stfld Vector3 AutoAttackFlamethrower::_flameOffset  /*0x04000560*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: call !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_0035: stfld Hp AutoAttackFlamethrower::_hp  /*0x04000564*/
    IL_003a: ldarg.0
    IL_003b: ldfld Hp AutoAttackFlamethrower::_hp  /*0x04000564*/
    IL_0040: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0045: brtrue.s IL_0061
    IL_0047: ldarg.0
    IL_0048: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004d: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0052: ldstr " - Can't find required Hp components"
    IL_0057: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_005c: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0061: ldarg.0
    IL_0062: call void AutoAttackFlamethrower::SpawnFlameLines()  /*0x06000431*/
    IL_0067: ret

  .method AutoAttackFlamethrower::SpawnFlameLines()  // token 0x06000431 rva 0x121dc attrs Private, HideBySig
    // code size 375 (0x177), max stack 5, init locals
    .locals ([0] float, [1] float, [2] int, [3] GameObject, [4] FlamethrowerFlameController, [5] CapsuleCollider, [6] MeshRenderer, [7] Vector3)
    IL_0000: ldc.r4 360f
    IL_0005: ldarg.0
    IL_0006: ldfld int AutoAttackFlamethrower::_flameCount  /*0x04000558*/
    IL_000b: conv.r4
    IL_000c: div
    IL_000d: stloc.0
    IL_000e: ldc.r4 0f
    IL_0013: stloc.1
    IL_0014: ldc.i4.0
    IL_0015: stloc.2
    IL_0016: br IL_016a
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject AutoAttackFlamethrower::_flamePrefab  /*0x0400055C*/
    IL_0021: ldarg.0
    IL_0022: ldfld Transform AutoAttackFlamethrower::_rotationPivot  /*0x0400055D*/
    IL_0027: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_002c: stloc.3
    IL_002d: ldloc.3
    IL_002e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0033: brfalse IL_0148
    IL_0038: ldloc.3
    IL_0039: ldc.i4.1
    IL_003a: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren(bool)<FlamethrowerFlameController>  /*0x2B000033*/
    IL_003f: stloc.s 4
    IL_0041: ldloc.s 4
    IL_0043: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0048: brfalse.s IL_005f
    IL_004a: ldloc.s 4
    IL_004c: ldarg.0
    IL_004d: callvirt void FlamethrowerFlameController::Attach(AutoAttackFlamethrower)  /*0x06000532*/
    IL_0052: ldarg.0
    IL_0053: ldfld List<FlamethrowerFlameController> AutoAttackFlamethrower::_flames  /*0x04000563*/
    IL_0058: ldloc.s 4
    IL_005a: callvirt void System.Collections.Generic.List<FlamethrowerFlameController>::Add(!0)  /*0x0A0001CC*/
    IL_005f: ldloc.3
    IL_0060: ldc.i4.1
    IL_0061: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren(bool)<UnityEngine.CapsuleCollider>  /*0x2B000034*/
    IL_0066: stloc.s 5
    IL_0068: ldloc.s 5
    IL_006a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_006f: brfalse.s IL_007e
    IL_0071: ldloc.s 5
    IL_0073: ldarg.0
    IL_0074: ldfld float AutoAttackFlamethrower::_range  /*0x04000556*/
    IL_0079: callvirt void UnityEngine.CapsuleCollider::set_height(float)  /*0x0A0001CD*/
    IL_007e: ldloc.3
    IL_007f: ldc.i4.1
    IL_0080: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren(bool)<UnityEngine.MeshRenderer>  /*0x2B000035*/
    IL_0085: stloc.s 6
    IL_0087: ldloc.s 6
    IL_0089: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_008e: brfalse.s IL_00fd
    IL_0090: ldloc.s 6
    IL_0092: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0097: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_009c: stloc.s 7
    IL_009e: ldloc.s 6
    IL_00a0: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a5: ldloc.s 7
    IL_00a7: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_00ac: ldloc.s 7
    IL_00ae: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_00b3: ldloc.s 7
    IL_00b5: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00ba: ldarg.0
    IL_00bb: ldfld float AutoAttackFlamethrower::_range  /*0x04000556*/
    IL_00c0: mul
    IL_00c1: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00c6: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00cb: ldloc.s 6
    IL_00cd: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d2: dup
    IL_00d3: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld float AutoAttackFlamethrower::_range  /*0x04000556*/
    IL_00de: ldc.r4 0.5f
    IL_00e3: mul
    IL_00e4: ldc.r4 0f
    IL_00e9: ldc.r4 0f
    IL_00ee: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00f3: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00f8: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00fd: ldloc.3
    IL_00fe: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0103: dup
    IL_0104: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0109: ldarg.0
    IL_010a: ldfld Vector3 AutoAttackFlamethrower::_flameOffset  /*0x04000560*/
    IL_010f: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0114: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0119: ldloc.3
    IL_011a: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_011f: ldarg.0
    IL_0120: ldfld Transform AutoAttackFlamethrower::_rotationPivot  /*0x0400055D*/
    IL_0125: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_012a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_012f: call Vector2 UnityEngine.Vector2::get_up()  /*0x0A0001CE*/
    IL_0134: call Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)  /*0x0A0001CF*/
    IL_0139: ldloc.1
    IL_013a: callvirt void UnityEngine.Transform::RotateAround(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A0001D0*/
    IL_013f: ldloc.3
    IL_0140: ldc.i4.0
    IL_0141: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0146: br.s IL_0162
    IL_0148: ldarg.0
    IL_0149: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_014e: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0153: ldstr " - flame instanciating error"
    IL_0158: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_015d: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0162: ldloc.1
    IL_0163: ldloc.0
    IL_0164: add
    IL_0165: stloc.1
    IL_0166: ldloc.2
    IL_0167: ldc.i4.1
    IL_0168: add
    IL_0169: stloc.2
    IL_016a: ldloc.2
    IL_016b: ldarg.0
    IL_016c: ldfld int AutoAttackFlamethrower::_flameCount  /*0x04000558*/
    IL_0171: blt IL_001b
    IL_0176: ret

  .method AutoAttackFlamethrower::AddTarget(TaggedObject)  // token 0x06000432 rva 0x12360 attrs Public, HideBySig
    // code size 203 (0xcb), max stack 4, init locals
    .locals ([0] bool, [1] List.Enumerator<TargetPriority>, [2] TargetPriority, [3] List.Enumerator<TagManager.ETag>, [4] TagManager.ETag)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0008: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_000d: stloc.1
    IL_000e: br.s IL_0074
    IL_0010: ldloca.s 1
    IL_0012: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0017: stloc.2
    IL_0018: ldarg.1
    IL_0019: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_001e: callvirt List.Enumerator<!0> System.Collections.Generic.List<TagManager.ETag>::GetEnumerator()  /*0x0A0001D3*/
    IL_0023: stloc.3
    IL_0024: br.s IL_0056
    IL_0026: ldloca.s 3
    IL_0028: call !0 System.Collections.Generic.List.Enumerator<TagManager.ETag>::get_Current()  /*0x0A0001D4*/
    IL_002d: stloc.s 4
    IL_002f: ldloc.2
    IL_0030: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0035: ldloc.s 4
    IL_0037: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_003c: brfalse.s IL_0043
    IL_003e: leave IL_00ca
    IL_0043: ldloc.2
    IL_0044: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0049: ldloc.s 4
    IL_004b: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0050: brfalse.s IL_0056
    IL_0052: ldc.i4.1
    IL_0053: stloc.0
    IL_0054: leave.s IL_006f
    IL_0056: ldloca.s 3
    IL_0058: call bool System.Collections.Generic.List.Enumerator<TagManager.ETag>::MoveNext()  /*0x0A0001D5*/
    IL_005d: brtrue.s IL_0026
    IL_005f: leave.s IL_006f
    IL_0061: ldloca.s 3
    IL_0063: constrained. System.Collections.Generic.List.Enumerator<TagManager.ETag>  /*0x1B000041*/
    IL_0069: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006e: endfinally
    IL_006f: ldloc.0
    IL_0070: brfalse.s IL_0074
    IL_0072: leave.s IL_008d
    IL_0074: ldloca.s 1
    IL_0076: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_007b: brtrue.s IL_0010
    IL_007d: leave.s IL_008d
    IL_007f: ldloca.s 1
    IL_0081: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0087: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008c: endfinally
    IL_008d: ldloc.0
    IL_008e: brfalse.s IL_00ca
    IL_0090: ldarg.0
    IL_0091: ldfld Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer> AutoAttackFlamethrower::_targetTimers  /*0x04000561*/
    IL_0096: ldarg.1
    IL_0097: ldarg.0
    IL_0098: ldfld float AutoAttackFlamethrower::_lingerDuration  /*0x0400055B*/
    IL_009d: ldc.r4 -1f
    IL_00a2: newobj void AutoAttackFlamethrower.ItemTimer::.ctor(float,float)  /*0x0600043B*/
    IL_00a7: callvirt bool System.Collections.Generic.Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer>::TryAdd(!0,!1)  /*0x0A0001D7*/
    IL_00ac: brfalse.s IL_00ca
    IL_00ae: ldarg.1
    IL_00af: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_00b4: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_00b9: ldarg.0
    IL_00ba: ldftn void AutoAttackFlamethrower::RemoveTargetOnKill(TaggedObject)  /*0x06000433*/
    IL_00c0: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_00c5: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001D9*/
    IL_00ca: ret
    .try IL_0024-IL_0061 finally handler IL_0061-IL_006f
    .try IL_000e-IL_007f finally handler IL_007f-IL_008d

  .method AutoAttackFlamethrower::RemoveTargetOnKill(TaggedObject)  // token 0x06000433 rva 0x12454 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> AutoAttackFlamethrower::_targetsToDestroy  /*0x04000562*/
    IL_0006: ldarg.1
    IL_0007: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_000c: ret

  .method AutoAttackFlamethrower::Update()  // token 0x06000434 rva 0x12464 attrs Public, Virtual, HideBySig
    // code size 111 (0x6f), max stack 2, init locals
    .locals ([0] AutoAttackFlamethrower.EState)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_0014
    IL_000c: ldarg.0
    IL_000d: ldc.i4.0
    IL_000e: call void AutoAttackFlamethrower::ActivateFlame(bool)  /*0x06000437*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: ldfld Hp AutoAttackFlamethrower::_hp  /*0x04000564*/
    IL_001a: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_001f: brfalse.s IL_0038
    IL_0021: ldarg.0
    IL_0022: ldfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0027: ldc.i4.1
    IL_0028: bne.un.s IL_0038
    IL_002a: ldarg.0
    IL_002b: ldc.i4.0
    IL_002c: call void AutoAttackFlamethrower::ActivateFlame(bool)  /*0x06000437*/
    IL_0031: ldarg.0
    IL_0032: ldc.i4.0
    IL_0033: stfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0038: ldarg.0
    IL_0039: call void AutoAttackFlamethrower::UpdateFlame()  /*0x06000435*/
    IL_003e: ldarg.0
    IL_003f: ldfld Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer> AutoAttackFlamethrower::_targetTimers  /*0x04000561*/
    IL_0044: callvirt int System.Collections.Generic.Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Count()  /*0x0A0001DA*/
    IL_0049: ldc.i4.0
    IL_004a: ble.s IL_0052
    IL_004c: ldarg.0
    IL_004d: call void AutoAttackFlamethrower::AttackTargets()  /*0x06000439*/
    IL_0052: ldarg.0
    IL_0053: ldfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0058: stloc.0
    IL_0059: ldloc.0
    IL_005a: brfalse.s IL_0061
    IL_005c: ldloc.0
    IL_005d: ldc.i4.1
    IL_005e: beq.s IL_0068
    IL_0060: ret
    IL_0061: ldarg.0
    IL_0062: call void AutoAttackFlamethrower::UpdateInactive()  /*0x06000436*/
    IL_0067: ret
    IL_0068: ldarg.0
    IL_0069: call void AutoAttackFlamethrower::UpdateActive()  /*0x06000438*/
    IL_006e: ret

  .method AutoAttackFlamethrower::UpdateFlame()  // token 0x06000435 rva 0x124df attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0006: ldc.i4.1
    IL_0007: beq.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld Transform AutoAttackFlamethrower::_rotationPivot  /*0x0400055D*/
    IL_0010: ldc.r4 0f
    IL_0015: ldarg.0
    IL_0016: ldfld float AutoAttackFlamethrower::_rotationSpeed  /*0x04000557*/
    IL_001b: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0020: mul
    IL_0021: ldc.r4 0f
    IL_0026: callvirt void UnityEngine.Transform::Rotate(float,float,float)  /*0x0A0001DB*/
    IL_002b: ret

  .method AutoAttackFlamethrower::UpdateInactive()  // token 0x06000436 rva 0x1250c attrs Private, HideBySig
    // code size 86 (0x56), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_0020
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldfld Hp AutoAttackFlamethrower::_hp  /*0x04000564*/
    IL_0026: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_002b: brfalse.s IL_002e
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: callvirt TaggedObject AutoAttack::FindAutoAttackTarget()  /*0x06000236*/
    IL_0034: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0039: brfalse.s IL_0055
    IL_003b: ldarg.0
    IL_003c: ldc.i4.1
    IL_003d: stfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_0042: ldarg.0
    IL_0043: ldc.i4.1
    IL_0044: call void AutoAttackFlamethrower::ActivateFlame(bool)  /*0x06000437*/
    IL_0049: ldarg.0
    IL_004a: ldarg.0
    IL_004b: ldfld float AutoAttackFlamethrower::_flameDuration  /*0x04000559*/
    IL_0050: stfld float AutoAttackFlamethrower::_flameTimer  /*0x0400055F*/
    IL_0055: ret

  .method AutoAttackFlamethrower::ActivateFlame(bool)  // token 0x06000437 rva 0x12570 attrs Private, HideBySig
    // code size 68 (0x44), max stack 2, init locals
    .locals ([0] List.Enumerator<FlamethrowerFlameController>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<FlamethrowerFlameController> AutoAttackFlamethrower::_flames  /*0x04000563*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<FlamethrowerFlameController>::GetEnumerator()  /*0x0A0001DC*/
    IL_000b: stloc.0
    IL_000c: br.s IL_002a
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<FlamethrowerFlameController>::get_Current()  /*0x0A0001DD*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_001f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0024: ldarg.1
    IL_0025: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002a: ldloca.s 0
    IL_002c: call bool System.Collections.Generic.List.Enumerator<FlamethrowerFlameController>::MoveNext()  /*0x0A0001DE*/
    IL_0031: brtrue.s IL_000e
    IL_0033: leave.s IL_0043
    IL_0035: ldloca.s 0
    IL_0037: constrained. System.Collections.Generic.List.Enumerator<FlamethrowerFlameController>  /*0x1B000045*/
    IL_003d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0042: endfinally
    IL_0043: ret
    .try IL_000c-IL_0035 finally handler IL_0035-IL_0043

  .method AutoAttackFlamethrower::UpdateActive()  // token 0x06000438 rva 0x125d0 attrs Private, HideBySig
    // code size 96 (0x60), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttackFlamethrower::_flameTimer  /*0x0400055F*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttackFlamethrower::_flameTimer  /*0x0400055F*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttackFlamethrower::_flameTimer  /*0x0400055F*/
    IL_0018: ldc.r4 0f
    IL_001d: bge.un.s IL_005f
    IL_001f: ldarg.0
    IL_0020: ldc.i4.0
    IL_0021: call void AutoAttackFlamethrower::ActivateFlame(bool)  /*0x06000437*/
    IL_0026: ldarg.0
    IL_0027: ldarg.0
    IL_0028: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_002d: ldarg.0
    IL_002e: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0033: ldc.r4 1f
    IL_0038: ldc.r4 1f
    IL_003d: ldc.r4 2f
    IL_0042: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0047: mul
    IL_0048: sub
    IL_0049: ldarg.0
    IL_004a: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_004f: mul
    IL_0050: add
    IL_0051: mul
    IL_0052: add
    IL_0053: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0058: ldarg.0
    IL_0059: ldc.i4.0
    IL_005a: stfld AutoAttackFlamethrower.EState AutoAttackFlamethrower::_state  /*0x04000565*/
    IL_005f: ret

  .method AutoAttackFlamethrower::AttackTargets()  // token 0x06000439 rva 0x1263c attrs Private, HideBySig
    // code size 260 (0x104), max stack 3, init locals
    .locals ([0] Dictionary.Enumerator<TaggedObject, AutoAttackFlamethrower.ItemTimer>, [1] KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>, [2] List.Enumerator<TaggedObject>, [3] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer> AutoAttackFlamethrower::_targetTimers  /*0x04000561*/
    IL_0006: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer>::GetEnumerator()  /*0x0A0001DF*/
    IL_000b: stloc.0
    IL_000c: br IL_00a0
    IL_0011: ldloca.s 0
    IL_0013: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Current()  /*0x0A0001E0*/
    IL_0018: stloc.1
    IL_0019: ldloca.s 1
    IL_001b: call !1 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Value()  /*0x0A0001E1*/
    IL_0020: dup
    IL_0021: ldfld float AutoAttackFlamethrower.ItemTimer::DamageTimer  /*0x04000567*/
    IL_0026: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002b: sub
    IL_002c: stfld float AutoAttackFlamethrower.ItemTimer::DamageTimer  /*0x04000567*/
    IL_0031: ldloca.s 1
    IL_0033: call !1 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Value()  /*0x0A0001E1*/
    IL_0038: dup
    IL_0039: ldfld float AutoAttackFlamethrower.ItemTimer::LingerTimer  /*0x04000566*/
    IL_003e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0043: sub
    IL_0044: stfld float AutoAttackFlamethrower.ItemTimer::LingerTimer  /*0x04000566*/
    IL_0049: ldloca.s 1
    IL_004b: call !1 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Value()  /*0x0A0001E1*/
    IL_0050: ldfld float AutoAttackFlamethrower.ItemTimer::DamageTimer  /*0x04000567*/
    IL_0055: ldc.r4 0f
    IL_005a: bge.un.s IL_007b
    IL_005c: ldarg.0
    IL_005d: ldloca.s 1
    IL_005f: call !0 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Key()  /*0x0A0001E2*/
    IL_0064: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0069: ldloca.s 1
    IL_006b: call !1 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Value()  /*0x0A0001E1*/
    IL_0070: ldarg.0
    IL_0071: ldfld float AutoAttackFlamethrower::_damageInterval  /*0x0400055A*/
    IL_0076: stfld float AutoAttackFlamethrower.ItemTimer::DamageTimer  /*0x04000567*/
    IL_007b: ldloca.s 1
    IL_007d: call !1 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Value()  /*0x0A0001E1*/
    IL_0082: ldfld float AutoAttackFlamethrower.ItemTimer::LingerTimer  /*0x04000566*/
    IL_0087: ldc.r4 0f
    IL_008c: bge.un.s IL_00a0
    IL_008e: ldarg.0
    IL_008f: ldfld List<TaggedObject> AutoAttackFlamethrower::_targetsToDestroy  /*0x04000562*/
    IL_0094: ldloca.s 1
    IL_0096: call !0 System.Collections.Generic.KeyValuePair<TaggedObject, AutoAttackFlamethrower.ItemTimer>::get_Key()  /*0x0A0001E2*/
    IL_009b: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_00a0: ldloca.s 0
    IL_00a2: call bool System.Collections.Generic.Dictionary.Enumerator<TaggedObject, AutoAttackFlamethrower.ItemTimer>::MoveNext()  /*0x0A0001E3*/
    IL_00a7: brtrue IL_0011
    IL_00ac: leave.s IL_00bc
    IL_00ae: ldloca.s 0
    IL_00b0: constrained. System.Collections.Generic.Dictionary.Enumerator<TaggedObject, AutoAttackFlamethrower.ItemTimer>  /*0x1B000046*/
    IL_00b6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00bb: endfinally
    IL_00bc: ldarg.0
    IL_00bd: ldfld List<TaggedObject> AutoAttackFlamethrower::_targetsToDestroy  /*0x04000562*/
    IL_00c2: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_00c7: stloc.2
    IL_00c8: br.s IL_00df
    IL_00ca: ldloca.s 2
    IL_00cc: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_00d1: stloc.3
    IL_00d2: ldarg.0
    IL_00d3: ldfld Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer> AutoAttackFlamethrower::_targetTimers  /*0x04000561*/
    IL_00d8: ldloc.3
    IL_00d9: callvirt bool System.Collections.Generic.Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer>::Remove(!0)  /*0x0A0001E4*/
    IL_00de: pop
    IL_00df: ldloca.s 2
    IL_00e1: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_00e6: brtrue.s IL_00ca
    IL_00e8: leave.s IL_00f8
    IL_00ea: ldloca.s 2
    IL_00ec: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_00f2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f7: endfinally
    IL_00f8: ldarg.0
    IL_00f9: ldfld List<TaggedObject> AutoAttackFlamethrower::_targetsToDestroy  /*0x04000562*/
    IL_00fe: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0103: ret
    .try IL_000c-IL_00ae finally handler IL_00ae-IL_00bc
    .try IL_00c8-IL_00ea finally handler IL_00ea-IL_00f8

  .method AutoAttackFlamethrower::.ctor()  // token 0x0600043A rva 0x12768 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 113 (0x71), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float AutoAttackFlamethrower::_range  /*0x04000556*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float AutoAttackFlamethrower::_rotationSpeed  /*0x04000557*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld int AutoAttackFlamethrower::_flameCount  /*0x04000558*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 1f
    IL_0023: stfld float AutoAttackFlamethrower::_flameDuration  /*0x04000559*/
    IL_0028: ldarg.0
    IL_0029: ldc.r4 0.3f
    IL_002e: stfld float AutoAttackFlamethrower::_damageInterval  /*0x0400055A*/
    IL_0033: ldarg.0
    IL_0034: ldc.r4 1f
    IL_0039: stfld float AutoAttackFlamethrower::_lingerDuration  /*0x0400055B*/
    IL_003e: ldarg.0
    IL_003f: ldc.r4 4f
    IL_0044: stfld float AutoAttackFlamethrower::_towerToFlameOffset  /*0x0400055E*/
    IL_0049: ldarg.0
    IL_004a: newobj void System.Collections.Generic.Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer>::.ctor()  /*0x0A0001E5*/
    IL_004f: stfld Dictionary<TaggedObject, AutoAttackFlamethrower.ItemTimer> AutoAttackFlamethrower::_targetTimers  /*0x04000561*/
    IL_0054: ldarg.0
    IL_0055: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_005a: stfld List<TaggedObject> AutoAttackFlamethrower::_targetsToDestroy  /*0x04000562*/
    IL_005f: ldarg.0
    IL_0060: newobj void System.Collections.Generic.List<FlamethrowerFlameController>::.ctor()  /*0x0A0001E6*/
    IL_0065: stfld List<FlamethrowerFlameController> AutoAttackFlamethrower::_flames  /*0x04000563*/
    IL_006a: ldarg.0
    IL_006b: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0070: ret

// ===== AutoAttackFlamethrower/ItemTimer  (token 0x020000C9) =====
  .method AutoAttackFlamethrower.ItemTimer::.ctor(float,float)  // token 0x0600043B rva 0x127e5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld float AutoAttackFlamethrower.ItemTimer::LingerTimer  /*0x04000566*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld float AutoAttackFlamethrower.ItemTimer::DamageTimer  /*0x04000567*/
    IL_0014: ret

// ===== AutoAttackFlamethrower/EState  (token 0x020000CA) =====
