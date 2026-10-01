// ===== AutoAttackTrap  (token 0x02000124) =====
  .method AutoAttackTrap::get_State()  // token 0x0600060C rva 0x198d1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0006: ret

  .method AutoAttackTrap::get_Targets()  // token 0x0600060D rva 0x198d9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0006: ret

  .method AutoAttackTrap::get_AttackTimer()  // token 0x0600060E rva 0x198e1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0006: ret

  .method AutoAttackTrap::Start()  // token 0x0600060F rva 0x198e9 attrs Public, Virtual, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: call void AutoAttackTrap::PrepareTargetPriorities()  /*0x06000611*/
    IL_000c: ldarg.0
    IL_000d: call void AutoAttackTrap::AttachTraps()  /*0x06000612*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 -1f
    IL_0018: stfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_001d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0022: ldarg.0
    IL_0023: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0028: ret

  .method AutoAttackTrap::OnDestroy()  // token 0x06000610 rva 0x19913 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_000b: ldarg.0
    IL_000c: call void AutoAttackTrap::DetachTraps()  /*0x06000613*/
    IL_0011: ret

  .method AutoAttackTrap::PrepareTargetPriorities()  // token 0x06000611 rva 0x19928 attrs Private, HideBySig
    // code size 104 (0x68), max stack 3, init locals
    .locals ([0] List.Enumerator<TargetPriority>, [1] TargetPriority, [2] AutoAttackTrap.TargetEntry)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_000b: stloc.0
    IL_000c: br.s IL_004e
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0015: stloc.1
    IL_0016: ldarg.0
    IL_0017: ldfld List<AutoAttackTrap.TargetEntry> AutoAttackTrap::_targeting  /*0x04000782*/
    IL_001c: ldloca.s 2
    IL_001e: initobj AutoAttackTrap.TargetEntry  /*0x02000126*/
    IL_0024: ldloca.s 2
    IL_0026: ldloc.1
    IL_0027: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_002c: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001E7*/
    IL_0031: stfld HashSet<TagManager.ETag> AutoAttackTrap.TargetEntry::MustHave  /*0x04000788*/
    IL_0036: ldloca.s 2
    IL_0038: ldloc.1
    IL_0039: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_003e: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001E7*/
    IL_0043: stfld HashSet<TagManager.ETag> AutoAttackTrap.TargetEntry::MayNotHave  /*0x04000789*/
    IL_0048: ldloc.2
    IL_0049: callvirt void System.Collections.Generic.List<AutoAttackTrap.TargetEntry>::Add(!0)  /*0x0A00027D*/
    IL_004e: ldloca.s 0
    IL_0050: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0055: brtrue.s IL_000e
    IL_0057: leave.s IL_0067
    IL_0059: ldloca.s 0
    IL_005b: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0061: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0066: endfinally
    IL_0067: ret
    .try IL_000c-IL_0059 finally handler IL_0059-IL_0067

  .method AutoAttackTrap::AttachTraps()  // token 0x06000612 rva 0x199ac attrs Private, HideBySig
    // code size 53 (0x35), max stack 2, init locals
    .locals ([0] List.Enumerator<TrapController>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TrapController> AutoAttackTrap::_traps  /*0x04000778*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TrapController>::GetEnumerator()  /*0x0A00027E*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TrapController>::get_Current()  /*0x0A00027F*/
    IL_0015: ldarg.0
    IL_0016: callvirt void TrapController::Attach(AutoAttackTrap)  /*0x0600063D*/
    IL_001b: ldloca.s 0
    IL_001d: call bool System.Collections.Generic.List.Enumerator<TrapController>::MoveNext()  /*0x0A000280*/
    IL_0022: brtrue.s IL_000e
    IL_0024: leave.s IL_0034
    IL_0026: ldloca.s 0
    IL_0028: constrained. System.Collections.Generic.List.Enumerator<TrapController>  /*0x1B000070*/
    IL_002e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0033: endfinally
    IL_0034: ret
    .try IL_000c-IL_0026 finally handler IL_0026-IL_0034

  .method AutoAttackTrap::DetachTraps()  // token 0x06000613 rva 0x19a00 attrs Private, HideBySig
    // code size 52 (0x34), max stack 1, init locals
    .locals ([0] List.Enumerator<TrapController>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TrapController> AutoAttackTrap::_traps  /*0x04000778*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TrapController>::GetEnumerator()  /*0x0A00027E*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001a
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TrapController>::get_Current()  /*0x0A00027F*/
    IL_0015: callvirt void TrapController::Detach()  /*0x0600063E*/
    IL_001a: ldloca.s 0
    IL_001c: call bool System.Collections.Generic.List.Enumerator<TrapController>::MoveNext()  /*0x0A000280*/
    IL_0021: brtrue.s IL_000e
    IL_0023: leave.s IL_0033
    IL_0025: ldloca.s 0
    IL_0027: constrained. System.Collections.Generic.List.Enumerator<TrapController>  /*0x1B000070*/
    IL_002d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0032: endfinally
    IL_0033: ret
    .try IL_000c-IL_0025 finally handler IL_0025-IL_0033

  .method AutoAttackTrap::MatchTags(TaggedObject)  // token 0x06000614 rva 0x19a50 attrs Public, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    .locals ([0] List.Enumerator<AutoAttackTrap.TargetEntry>, [1] AutoAttackTrap.TargetEntry, [2] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld List<AutoAttackTrap.TargetEntry> AutoAttackTrap::_targeting  /*0x04000782*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<AutoAttackTrap.TargetEntry>::GetEnumerator()  /*0x0A000281*/
    IL_000b: stloc.0
    IL_000c: br.s IL_002e
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<AutoAttackTrap.TargetEntry>::get_Current()  /*0x0A000282*/
    IL_0015: stloc.1
    IL_0016: ldarg.1
    IL_0017: ldloc.1
    IL_0018: ldfld HashSet<TagManager.ETag> AutoAttackTrap.TargetEntry::MustHave  /*0x04000788*/
    IL_001d: ldloc.1
    IL_001e: ldfld HashSet<TagManager.ETag> AutoAttackTrap.TargetEntry::MayNotHave  /*0x04000789*/
    IL_0023: callvirt bool TaggedObject::Match(System.Collections.Generic.HashSet<TagManager.ETag>,System.Collections.Generic.HashSet<TagManager.ETag>)  /*0x06000E4F*/
    IL_0028: brfalse.s IL_002e
    IL_002a: ldc.i4.1
    IL_002b: stloc.2
    IL_002c: leave.s IL_0049
    IL_002e: ldloca.s 0
    IL_0030: call bool System.Collections.Generic.List.Enumerator<AutoAttackTrap.TargetEntry>::MoveNext()  /*0x0A000283*/
    IL_0035: brtrue.s IL_000e
    IL_0037: leave.s IL_0047
    IL_0039: ldloca.s 0
    IL_003b: constrained. System.Collections.Generic.List.Enumerator<AutoAttackTrap.TargetEntry>  /*0x1B000071*/
    IL_0041: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0046: endfinally
    IL_0047: ldc.i4.0
    IL_0048: ret
    IL_0049: ldloc.2
    IL_004a: ret
    .try IL_000c-IL_0039 finally handler IL_0039-IL_0047

  .method AutoAttackTrap::AddTarget(TaggedObject)  // token 0x06000615 rva 0x19ab8 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Add(!0)  /*0x0A0001F0*/
    IL_000c: pop
    IL_000d: ldarg.1
    IL_000e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0013: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_0018: ldarg.0
    IL_0019: ldftn void AutoAttackTrap::RemoveTarget(TaggedObject)  /*0x06000616*/
    IL_001f: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001D9*/
    IL_0029: ret

  .method AutoAttackTrap::RemoveTarget(TaggedObject)  // token 0x06000616 rva 0x19ae3 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Remove(!0)  /*0x0A0001F2*/
    IL_000c: pop
    IL_000d: ldarg.1
    IL_000e: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0013: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_0018: ldarg.0
    IL_0019: ldftn void AutoAttackTrap::RemoveTarget(TaggedObject)  /*0x06000616*/
    IL_001f: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::RemoveListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001F1*/
    IL_0029: ret

  .method AutoAttackTrap::Activate()  // token 0x06000617 rva 0x19b10 attrs Public, HideBySig
    // code size 71 (0x47), max stack 3, init locals
    .locals ([0] List.Enumerator<TrapController>)
    IL_0000: ldarg.0
    IL_0001: call AutoAttackTrap.EState AutoAttackTrap::get_State()  /*0x0600060C*/
    IL_0006: ldc.i4.2
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldc.i4.2
    IL_000c: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TrapController> AutoAttackTrap::_traps  /*0x04000778*/
    IL_0017: callvirt List.Enumerator<!0> System.Collections.Generic.List<TrapController>::GetEnumerator()  /*0x0A00027E*/
    IL_001c: stloc.0
    IL_001d: br.s IL_002d
    IL_001f: ldloca.s 0
    IL_0021: call !0 System.Collections.Generic.List.Enumerator<TrapController>::get_Current()  /*0x0A00027F*/
    IL_0026: ldc.i4.1
    IL_0027: ldc.i4.0
    IL_0028: callvirt void TrapController::Activate(bool,bool)  /*0x06000641*/
    IL_002d: ldloca.s 0
    IL_002f: call bool System.Collections.Generic.List.Enumerator<TrapController>::MoveNext()  /*0x0A000280*/
    IL_0034: brtrue.s IL_001f
    IL_0036: leave.s IL_0046
    IL_0038: ldloca.s 0
    IL_003a: constrained. System.Collections.Generic.List.Enumerator<TrapController>  /*0x1B000070*/
    IL_0040: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0045: endfinally
    IL_0046: ret
    .try IL_001d-IL_0038 finally handler IL_0038-IL_0046

  .method AutoAttackTrap::Deactivate()  // token 0x06000618 rva 0x19b74 attrs Public, HideBySig
    // code size 54 (0x36), max stack 3, init locals
    .locals ([0] List.Enumerator<TrapController>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TrapController> AutoAttackTrap::_traps  /*0x04000778*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TrapController>::GetEnumerator()  /*0x0A00027E*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001c
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TrapController>::get_Current()  /*0x0A00027F*/
    IL_0015: ldc.i4.0
    IL_0016: ldc.i4.0
    IL_0017: callvirt void TrapController::Activate(bool,bool)  /*0x06000641*/
    IL_001c: ldloca.s 0
    IL_001e: call bool System.Collections.Generic.List.Enumerator<TrapController>::MoveNext()  /*0x0A000280*/
    IL_0023: brtrue.s IL_000e
    IL_0025: leave.s IL_0035
    IL_0027: ldloca.s 0
    IL_0029: constrained. System.Collections.Generic.List.Enumerator<TrapController>  /*0x1B000070*/
    IL_002f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0034: endfinally
    IL_0035: ret
    .try IL_000c-IL_0027 finally handler IL_0027-IL_0035

  .method AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  // token 0x06000619 rva 0x19bc8 attrs Family, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.1
    IL_0001: switch (IL_0018, IL_001f, IL_0026, IL_002d)
    IL_0016: br.s IL_0034
    IL_0018: ldarg.0
    IL_0019: callvirt void AutoAttackTrap::TransferToDisabled()  /*0x0600061A*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: callvirt void AutoAttackTrap::TransferToIdle()  /*0x0600061B*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: callvirt void AutoAttackTrap::TransferToActive()  /*0x0600061C*/
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: callvirt void AutoAttackTrap::TransferToCooldown()  /*0x0600061D*/
    IL_0033: ret
    IL_0034: ldarg.0
    IL_0035: callvirt void AutoAttackTrap::TransferToDisabled()  /*0x0600061A*/
    IL_003a: ret

  .method AutoAttackTrap::TransferToDisabled()  // token 0x0600061A rva 0x19c04 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0007: ldarg.0
    IL_0008: call void AutoAttackTrap::Deactivate()  /*0x06000618*/
    IL_000d: ret

  .method AutoAttackTrap::TransferToIdle()  // token 0x0600061B rva 0x19c13 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 -1f
    IL_000d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0012: ret

  .method AutoAttackTrap::TransferToActive()  // token 0x0600061C rva 0x19c27 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_000e: ldarg.0
    IL_000f: ldfld float AutoAttackTrap::_activePhaseDuration  /*0x04000779*/
    IL_0014: add
    IL_0015: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_001a: ldarg.0
    IL_001b: ldc.r4 0f
    IL_0020: stfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0025: ret

  .method AutoAttackTrap::TransferToCooldown()  // token 0x0600061D rva 0x19c50 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 64 (0x40), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_000e: ldarg.0
    IL_000f: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0014: ldc.r4 1f
    IL_0019: ldc.r4 1f
    IL_001e: ldc.r4 2f
    IL_0023: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0028: mul
    IL_0029: sub
    IL_002a: ldarg.0
    IL_002b: ldfld float AutoAttack::cooldownRandomization  /*0x04000300*/
    IL_0030: mul
    IL_0031: add
    IL_0032: mul
    IL_0033: add
    IL_0034: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0039: ldarg.0
    IL_003a: call void AutoAttackTrap::Deactivate()  /*0x06000618*/
    IL_003f: ret

  .method AutoAttackTrap::OnDuskEarly()  // token 0x0600061E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackTrap::OnDusk()  // token 0x0600061F rva 0x19c9c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_0007: ret

  .method AutoAttackTrap::OnDawn_AfterSunrise()  // token 0x06000620 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackTrap::OnDawn_BeforeSunrise()  // token 0x06000621 rva 0x19ca5 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_0007: ret

  .method AutoAttackTrap::Update()  // token 0x06000622 rva 0x19cb0 attrs Public, Virtual, HideBySig
    // code size 75 (0x4b), max stack 3, init locals
    .locals ([0] AutoAttackTrap.EState)
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrap.EState AutoAttackTrap::_state  /*0x04000781*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void AutoAttackTrap::ApplySideEffect()  /*0x06000626*/
    IL_000f: ldarg.0
    IL_0010: ldarg.0
    IL_0011: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0016: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001b: sub
    IL_001c: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0021: ldarg.0
    IL_0022: call AutoAttackTrap.EState AutoAttackTrap::get_State()  /*0x0600060C*/
    IL_0027: stloc.0
    IL_0028: ldloc.0
    IL_0029: ldc.i4.1
    IL_002a: sub
    IL_002b: switch (IL_004a, IL_003d, IL_0044)
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: callvirt void AutoAttackTrap::UpdateActive()  /*0x06000623*/
    IL_0043: ret
    IL_0044: ldarg.0
    IL_0045: call void AutoAttackTrap::UpdateCooldown()  /*0x06000624*/
    IL_004a: ret

  .method AutoAttackTrap::UpdateActive()  // token 0x06000623 rva 0x19d08 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 91 (0x5b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0018: ldc.r4 0f
    IL_001d: bge.un.s IL_0046
    IL_001f: ldarg.0
    IL_0020: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0025: callvirt int System.Collections.Generic.HashSet<TaggedObject>::get_Count()  /*0x0A000284*/
    IL_002a: ldc.i4.0
    IL_002b: ble.s IL_0046
    IL_002d: ldarg.0
    IL_002e: call void AutoAttackTrap::AttackAllTargets()  /*0x06000625*/
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_003a: ldarg.0
    IL_003b: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_0040: add
    IL_0041: stfld float AutoAttackTrap::_attackTimer  /*0x0400077E*/
    IL_0046: ldarg.0
    IL_0047: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_004c: ldc.r4 0f
    IL_0051: bge.un.s IL_005a
    IL_0053: ldarg.0
    IL_0054: ldc.i4.3
    IL_0055: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_005a: ret

  .method AutoAttackTrap::UpdateCooldown()  // token 0x06000624 rva 0x19d6f attrs Family, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0006: ldc.r4 0f
    IL_000b: bge.un.s IL_0014
    IL_000d: ldarg.0
    IL_000e: ldc.i4.1
    IL_000f: call void AutoAttackTrap::TransferTo(AutoAttackTrap.EState)  /*0x06000619*/
    IL_0014: ret

  .method AutoAttackTrap::AttackAllTargets()  // token 0x06000625 rva 0x19d88 attrs Family, HideBySig
    // code size 169 (0xa9), max stack 2, init locals
    .locals ([0] List.Enumerator<TaggedObject>, [1] TaggedObject, [2] List.Enumerator<TrapController>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TaggedObject> AutoAttackTrap::_targetsBuffer  /*0x04000780*/
    IL_0006: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<TaggedObject> AutoAttackTrap::_targetsBuffer  /*0x04000780*/
    IL_0011: ldarg.0
    IL_0012: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0017: callvirt void System.Collections.Generic.List<TaggedObject>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A000285*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<TaggedObject> AutoAttackTrap::_targetsBuffer  /*0x04000780*/
    IL_0022: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0027: stloc.0
    IL_0028: br.s IL_005c
    IL_002a: ldloca.s 0
    IL_002c: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_0031: stloc.1
    IL_0032: ldloc.1
    IL_0033: ldnull
    IL_0034: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0039: brfalse.s IL_005c
    IL_003b: ldloc.1
    IL_003c: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0041: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_0046: brfalse.s IL_005c
    IL_0048: ldloc.1
    IL_0049: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_004e: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0053: brtrue.s IL_005c
    IL_0055: ldarg.0
    IL_0056: ldloc.1
    IL_0057: callvirt void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_005c: ldloca.s 0
    IL_005e: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_0063: brtrue.s IL_002a
    IL_0065: leave.s IL_0075
    IL_0067: ldloca.s 0
    IL_0069: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_006f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0074: endfinally
    IL_0075: ldarg.0
    IL_0076: ldfld List<TrapController> AutoAttackTrap::_traps  /*0x04000778*/
    IL_007b: callvirt List.Enumerator<!0> System.Collections.Generic.List<TrapController>::GetEnumerator()  /*0x0A00027E*/
    IL_0080: stloc.2
    IL_0081: br.s IL_008f
    IL_0083: ldloca.s 2
    IL_0085: call !0 System.Collections.Generic.List.Enumerator<TrapController>::get_Current()  /*0x0A00027F*/
    IL_008a: callvirt void TrapController::PlayAttackVFX()  /*0x06000642*/
    IL_008f: ldloca.s 2
    IL_0091: call bool System.Collections.Generic.List.Enumerator<TrapController>::MoveNext()  /*0x0A000280*/
    IL_0096: brtrue.s IL_0083
    IL_0098: leave.s IL_00a8
    IL_009a: ldloca.s 2
    IL_009c: constrained. System.Collections.Generic.List.Enumerator<TrapController>  /*0x1B000070*/
    IL_00a2: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a7: endfinally
    IL_00a8: ret
    .try IL_0028-IL_0067 finally handler IL_0067-IL_0075
    .try IL_0081-IL_009a finally handler IL_009a-IL_00a8

  .method AutoAttackTrap::ApplySideEffect()  // token 0x06000626 rva 0x19e5c attrs Private, HideBySig
    // code size 200 (0xc8), max stack 8, init locals
    .locals ([0] HashSet.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackTrap::_hasSideEffect  /*0x0400077A*/
    IL_0006: brfalse IL_00c7
    IL_000b: ldarg.0
    IL_000c: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0011: callvirt int System.Collections.Generic.HashSet<TaggedObject>::get_Count()  /*0x0A000284*/
    IL_0016: ldc.i4.0
    IL_0017: ble IL_00c7
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_0023: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0028: sub
    IL_0029: stfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_002e: ldarg.0
    IL_002f: ldfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_0034: ldc.r4 0f
    IL_0039: bge.un IL_00c7
    IL_003e: ldarg.0
    IL_003f: ldfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0044: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TaggedObject>::GetEnumerator()  /*0x0A0001E8*/
    IL_0049: stloc.0
    IL_004a: br.s IL_009b
    IL_004c: ldloca.s 0
    IL_004e: call !0 System.Collections.Generic.HashSet.Enumerator<TaggedObject>::get_Current()  /*0x0A0001E9*/
    IL_0053: stloc.1
    IL_0054: ldarg.0
    IL_0055: ldfld AdditionalWeaponEffectScript AutoAttackTrap::_sideEffect  /*0x0400077B*/
    IL_005a: ldloc.1
    IL_005b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0060: ldloc.1
    IL_0061: ldarg.0
    IL_0062: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0067: ldarg.0
    IL_0068: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_006d: ldc.r4 1f
    IL_0072: ldloc.1
    IL_0073: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0078: callvirt bool Hp::get_Alive()  /*0x0600081D*/
    IL_007d: brfalse.s IL_008f
    IL_007f: ldloc.1
    IL_0080: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0085: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_008a: ldc.i4.0
    IL_008b: ceq
    IL_008d: br.s IL_0090
    IL_008f: ldc.i4.0
    IL_0090: ldarg.0
    IL_0091: ldfld float AutoAttackTrap::_sideEffectDuration  /*0x0400077C*/
    IL_0096: callvirt void AdditionalWeaponEffectScript::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  /*0x06000027*/
    IL_009b: ldloca.s 0
    IL_009d: call bool System.Collections.Generic.HashSet.Enumerator<TaggedObject>::MoveNext()  /*0x0A0001EA*/
    IL_00a2: brtrue.s IL_004c
    IL_00a4: leave.s IL_00b4
    IL_00a6: ldloca.s 0
    IL_00a8: constrained. System.Collections.Generic.HashSet.Enumerator<TaggedObject>  /*0x1B00004A*/
    IL_00ae: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00b3: endfinally
    IL_00b4: ldarg.0
    IL_00b5: ldarg.0
    IL_00b6: ldfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_00bb: ldarg.0
    IL_00bc: ldfld float AutoAttackTrap::_sideEffectDuration  /*0x0400077C*/
    IL_00c1: add
    IL_00c2: stfld float AutoAttackTrap::_sideEffectTimer  /*0x0400077D*/
    IL_00c7: ret
    .try IL_004a-IL_00a6 finally handler IL_00a6-IL_00b4

  .method AutoAttackTrap::.ctor()  // token 0x06000627 rva 0x19f40 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float AutoAttackTrap::_sideEffectDuration  /*0x0400077C*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.HashSet<TaggedObject>::.ctor()  /*0x0A0001F3*/
    IL_0011: stfld HashSet<TaggedObject> AutoAttackTrap::_targets  /*0x0400077F*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_001c: stfld List<TaggedObject> AutoAttackTrap::_targetsBuffer  /*0x04000780*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.List<AutoAttackTrap.TargetEntry>::.ctor()  /*0x0A000286*/
    IL_0027: stfld List<AutoAttackTrap.TargetEntry> AutoAttackTrap::_targeting  /*0x04000782*/
    IL_002c: ldarg.0
    IL_002d: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0032: ret

// ===== AutoAttackTrap/EState  (token 0x02000125) =====
// ===== AutoAttackTrap/TargetEntry  (token 0x02000126) =====
