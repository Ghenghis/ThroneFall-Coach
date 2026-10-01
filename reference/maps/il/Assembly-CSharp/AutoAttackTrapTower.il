// ===== AutoAttackTrapTower  (token 0x02000127) =====
  .method AutoAttackTrapTower::get_TrapActive()  // token 0x06000628 rva 0x19f74 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_000b: ret

  .method AutoAttackTrapTower::get_Cooldown()  // token 0x06000629 rva 0x19f81 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0006: ret

  .method AutoAttackTrapTower::Start()  // token 0x0600062A rva 0x19f8c attrs Public, Virtual, HideBySig
    // code size 115 (0x73), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_000d: stfld Hp AutoAttackTrapTower::_hp  /*0x0400078D*/
    IL_0012: ldarg.0
    IL_0013: ldfld Hp AutoAttackTrapTower::_hp  /*0x0400078D*/
    IL_0018: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001d: brtrue.s IL_0039
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_002a: ldstr " required Hp component"
    IL_002f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0034: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0039: ldarg.0
    IL_003a: ldfld Hp AutoAttackTrapTower::_hp  /*0x0400078D*/
    IL_003f: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0044: ldarg.0
    IL_0045: ldftn void AutoAttackTrapTower::DisableTrapOnDeath()  /*0x0600062B*/
    IL_004b: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0050: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldfld AutoAttackTrap AutoAttackTrapTower::_trapAttack  /*0x0400078B*/
    IL_005c: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0061: stfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0066: ldarg.0
    IL_0067: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_006c: ldc.i4.0
    IL_006d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0072: ret

  .method AutoAttackTrapTower::DisableTrapOnDeath()  // token 0x0600062B rva 0x1a00b attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap AutoAttackTrapTower::_trapAttack  /*0x0400078B*/
    IL_0006: callvirt HashSet<TaggedObject> AutoAttackTrap::get_Targets()  /*0x0600060D*/
    IL_000b: callvirt void System.Collections.Generic.HashSet<TaggedObject>::Clear()  /*0x0A0001EB*/
    IL_0010: ldarg.0
    IL_0011: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0016: ldc.i4.0
    IL_0017: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001c: ret

  .method AutoAttackTrapTower::Update()  // token 0x0600062C rva 0x1a02c attrs Public, Virtual, HideBySig
    // code size 290 (0x122), max stack 7, init locals
    .locals ([0] TaggedObject)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_0026
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0012: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0017: brfalse.s IL_0025
    IL_0019: ldarg.0
    IL_001a: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_001f: ldc.i4.0
    IL_0020: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldfld Hp AutoAttackTrapTower::_hp  /*0x0400078D*/
    IL_002c: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0031: brtrue.s IL_0040
    IL_0033: ldarg.0
    IL_0034: ldfld Hp AutoAttackTrapTower::_hp  /*0x0400078D*/
    IL_0039: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_003e: brtrue.s IL_0041
    IL_0040: ret
    IL_0041: ldarg.0
    IL_0042: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0047: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_004c: brfalse.s IL_007a
    IL_004e: ldarg.0
    IL_004f: ldarg.0
    IL_0050: ldfld float AutoAttackTrapTower::_trapLifetimeTimer  /*0x0400078E*/
    IL_0055: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_005a: sub
    IL_005b: stfld float AutoAttackTrapTower::_trapLifetimeTimer  /*0x0400078E*/
    IL_0060: ldarg.0
    IL_0061: ldfld float AutoAttackTrapTower::_trapLifetimeTimer  /*0x0400078E*/
    IL_0066: ldc.r4 0f
    IL_006b: bge.un.s IL_0079
    IL_006d: ldarg.0
    IL_006e: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0073: ldc.i4.0
    IL_0074: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0079: ret
    IL_007a: ldarg.0
    IL_007b: ldarg.0
    IL_007c: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0081: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0086: sub
    IL_0087: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_008c: ldarg.0
    IL_008d: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0092: ldc.r4 0f
    IL_0097: ble.un.s IL_009a
    IL_0099: ret
    IL_009a: ldarg.0
    IL_009b: callvirt TaggedObject AutoAttack::FindAutoAttackTarget()  /*0x06000236*/
    IL_00a0: stloc.0
    IL_00a1: ldloc.0
    IL_00a2: ldnull
    IL_00a3: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00a8: brfalse.s IL_00c5
    IL_00aa: ldarg.0
    IL_00ab: ldarg.0
    IL_00ac: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_00b7: add
    IL_00b8: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00bd: ldarg.0
    IL_00be: ldc.i4.0
    IL_00bf: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00c4: ret
    IL_00c5: ldarg.0
    IL_00c6: ldfld AutoAttackTrap AutoAttackTrapTower::_trapAttack  /*0x0400078B*/
    IL_00cb: ldloc.0
    IL_00cc: callvirt void AutoAttackTrap::AddTarget(TaggedObject)  /*0x06000615*/
    IL_00d1: ldarg.0
    IL_00d2: ldarg.0
    IL_00d3: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_00de: ldc.r4 1f
    IL_00e3: ldc.r4 1f
    IL_00e8: ldc.r4 2f
    IL_00ed: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_00f2: mul
    IL_00f3: sub
    IL_00f4: ldarg.0
    IL_00f5: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_00fa: mul
    IL_00fb: add
    IL_00fc: mul
    IL_00fd: add
    IL_00fe: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0103: ldarg.0
    IL_0104: ldfld GameObject AutoAttackTrapTower::_trap  /*0x0400078C*/
    IL_0109: ldc.i4.1
    IL_010a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010f: ldarg.0
    IL_0110: ldarg.0
    IL_0111: ldfld float AutoAttackTrapTower::_trapLifetime  /*0x0400078A*/
    IL_0116: stfld float AutoAttackTrapTower::_trapLifetimeTimer  /*0x0400078E*/
    IL_011b: ldarg.0
    IL_011c: call void AutoAttackTrapTower::Attack()  /*0x0600062D*/
    IL_0121: ret

  .method AutoAttackTrapTower::Attack()  // token 0x0600062D rva 0x1a15c attrs Private, HideBySig
    // code size 60 (0x3c), max stack 2, init locals
    .locals ([0] HashSet.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap AutoAttackTrapTower::_trapAttack  /*0x0400078B*/
    IL_0006: callvirt HashSet<TaggedObject> AutoAttackTrap::get_Targets()  /*0x0600060D*/
    IL_000b: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TaggedObject>::GetEnumerator()  /*0x0A0001E8*/
    IL_0010: stloc.0
    IL_0011: br.s IL_0022
    IL_0013: ldloca.s 0
    IL_0015: call !0 System.Collections.Generic.HashSet.Enumerator<TaggedObject>::get_Current()  /*0x0A0001E9*/
    IL_001a: stloc.1
    IL_001b: ldarg.0
    IL_001c: ldloc.1
    IL_001d: call void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0022: ldloca.s 0
    IL_0024: call bool System.Collections.Generic.HashSet.Enumerator<TaggedObject>::MoveNext()  /*0x0A0001EA*/
    IL_0029: brtrue.s IL_0013
    IL_002b: leave.s IL_003b
    IL_002d: ldloca.s 0
    IL_002f: constrained. System.Collections.Generic.HashSet.Enumerator<TaggedObject>  /*0x1B00004A*/
    IL_0035: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003a: endfinally
    IL_003b: ret
    .try IL_0011-IL_002d finally handler IL_002d-IL_003b

  .method AutoAttackTrapTower::.ctor()  // token 0x0600062E rva 0xa042 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0006: ret

