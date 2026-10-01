// ===== TarTowerPourFX  (token 0x020000FB) =====
  .method TarTowerPourFX::Start()  // token 0x06000539 rva 0x16e26 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0029
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_0013: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0018: ldarg.0
    IL_0019: ldftn void TarTowerPourFX::OnAttack()  /*0x0600053B*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ret

  .method TarTowerPourFX::Update()  // token 0x0600053A rva 0x16e54 attrs Private, HideBySig
    // code size 237 (0xed), max stack 6, init locals
    .locals ([0] float)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_0013: ldfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0018: brfalse IL_00ec
    IL_001d: ldarg.0
    IL_001e: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_0023: callvirt bool AutoAttackTrapTower::get_TrapActive()  /*0x06000628*/
    IL_0028: brtrue IL_00ec
    IL_002d: ldarg.0
    IL_002e: ldfld bool TarTowerPourFX::_isAnimating  /*0x040006D3*/
    IL_0033: brfalse.s IL_00a4
    IL_0035: ldarg.0
    IL_0036: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_003b: callvirt float AutoAttackTrapTower::get_Cooldown()  /*0x06000629*/
    IL_0040: ldarg.0
    IL_0041: ldfld float TarTowerPourFX::_timerBuffer  /*0x040006CF*/
    IL_0046: sub
    IL_0047: stloc.0
    IL_0048: ldloc.0
    IL_0049: ldc.r4 0f
    IL_004e: ble.un.s IL_007b
    IL_0050: ldarg.0
    IL_0051: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_0056: ldarg.0
    IL_0057: ldfld Vector3 TarTowerPourFX::_refillInitialPos  /*0x040006D1*/
    IL_005c: ldarg.0
    IL_005d: ldfld Vector3 TarTowerPourFX::_tarHighPosition  /*0x040006CB*/
    IL_0062: ldc.r4 1f
    IL_0067: ldloc.0
    IL_0068: ldarg.0
    IL_0069: ldfld float TarTowerPourFX::_refillDuration  /*0x040006D0*/
    IL_006e: div
    IL_006f: sub
    IL_0070: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0075: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_007a: ret
    IL_007b: ldarg.0
    IL_007c: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_0081: ldarg.0
    IL_0082: ldfld Vector3 TarTowerPourFX::_refillInitialPos  /*0x040006D1*/
    IL_0087: ldarg.0
    IL_0088: ldfld Vector3 TarTowerPourFX::_tarHighPosition  /*0x040006CB*/
    IL_008d: ldc.r4 1f
    IL_0092: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0097: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_009c: ldarg.0
    IL_009d: ldc.i4.0
    IL_009e: stfld bool TarTowerPourFX::_isAnimating  /*0x040006D3*/
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_00aa: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_00af: ldarg.0
    IL_00b0: ldfld Vector3 TarTowerPourFX::_tarHighPosition  /*0x040006CB*/
    IL_00b5: call bool UnityEngine.Vector3::op_Inequality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00006F*/
    IL_00ba: brfalse.s IL_00ec
    IL_00bc: ldarg.0
    IL_00bd: ldarg.0
    IL_00be: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_00c3: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_00c8: stfld Vector3 TarTowerPourFX::_refillInitialPos  /*0x040006D1*/
    IL_00cd: ldarg.0
    IL_00ce: ldc.i4.1
    IL_00cf: stfld bool TarTowerPourFX::_isAnimating  /*0x040006D3*/
    IL_00d4: ldarg.0
    IL_00d5: ldarg.0
    IL_00d6: ldfld AutoAttackTrapTower TarTowerPourFX::_autoAttack  /*0x040006C9*/
    IL_00db: callvirt float AutoAttackTrapTower::get_Cooldown()  /*0x06000629*/
    IL_00e0: ldarg.0
    IL_00e1: ldfld float TarTowerPourFX::_timerBuffer  /*0x040006CF*/
    IL_00e6: sub
    IL_00e7: stfld float TarTowerPourFX::_refillDuration  /*0x040006D0*/
    IL_00ec: ret

  .method TarTowerPourFX::OnAttack()  // token 0x0600053B rva 0x16f50 attrs Private, HideBySig
    // code size 109 (0x6d), max stack 4, init locals
    .locals ([0] List.Enumerator<ParticleSystem>)
    IL_0000: ldarg.0
    IL_0001: ldfld IEnumerator TarTowerPourFX::_coroutine  /*0x040006D2*/
    IL_0006: brfalse.s IL_0014
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld IEnumerator TarTowerPourFX::_coroutine  /*0x040006D2*/
    IL_000f: call void UnityEngine.MonoBehaviour::StopCoroutine(System.Collections.IEnumerator)  /*0x0A00022D*/
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: ldarg.0
    IL_0017: ldfld Vector3 TarTowerPourFX::_tarLowPosition  /*0x040006CC*/
    IL_001c: ldarg.0
    IL_001d: ldfld float TarTowerPourFX::_pourDuration  /*0x040006CD*/
    IL_0022: call IEnumerator TarTowerPourFX::TarCauldronAnimate(UnityEngine.Vector3,float)  /*0x0600053C*/
    IL_0027: stfld IEnumerator TarTowerPourFX::_coroutine  /*0x040006D2*/
    IL_002c: ldarg.0
    IL_002d: ldarg.0
    IL_002e: ldfld IEnumerator TarTowerPourFX::_coroutine  /*0x040006D2*/
    IL_0033: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0038: pop
    IL_0039: ldarg.0
    IL_003a: ldfld List<ParticleSystem> TarTowerPourFX::_pourOutParticles  /*0x040006CE*/
    IL_003f: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.ParticleSystem>::GetEnumerator()  /*0x0A00022E*/
    IL_0044: stloc.0
    IL_0045: br.s IL_0053
    IL_0047: ldloca.s 0
    IL_0049: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::get_Current()  /*0x0A00022F*/
    IL_004e: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0053: ldloca.s 0
    IL_0055: call bool System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::MoveNext()  /*0x0A000230*/
    IL_005a: brtrue.s IL_0047
    IL_005c: leave.s IL_006c
    IL_005e: ldloca.s 0
    IL_0060: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>  /*0x1B00005A*/
    IL_0066: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006b: endfinally
    IL_006c: ret
    .try IL_0045-IL_005e finally handler IL_005e-IL_006c

  .method TarTowerPourFX::TarCauldronAnimate(UnityEngine.Vector3,float)  // token 0x0600053C rva 0x16fdc attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void TarTowerPourFX.<TarCauldronAnimate>d__14::.ctor(int)  /*0x0600053E*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld TarTowerPourFX TarTowerPourFX.<TarCauldronAnimate>d__14::<>4__this  /*0x040006D6*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::targetPos  /*0x040006D7*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float TarTowerPourFX.<TarCauldronAnimate>d__14::duration  /*0x040006D8*/
    IL_001b: ret

  .method TarTowerPourFX::.ctor()  // token 0x0600053D rva 0x16ff9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.1f
    IL_0006: stfld float TarTowerPourFX::_timerBuffer  /*0x040006CF*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== TarTowerPourFX/<TarCauldronAnimate>d__14  (token 0x020000FC) =====
  .method TarTowerPourFX.<TarCauldronAnimate>d__14::.ctor(int)  // token 0x0600053E rva 0x1700c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int TarTowerPourFX.<TarCauldronAnimate>d__14::<>1__state  /*0x040006D4*/
    IL_000d: ret

  .method TarTowerPourFX.<TarCauldronAnimate>d__14::System.IDisposable.Dispose()  // token 0x0600053F rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TarTowerPourFX.<TarCauldronAnimate>d__14::MoveNext()  // token 0x06000540 rva 0x1701c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 212 (0xd4), max stack 5, init locals
    .locals ([0] int, [1] TarTowerPourFX)
    IL_0000: ldarg.0
    IL_0001: ldfld int TarTowerPourFX.<TarCauldronAnimate>d__14::<>1__state  /*0x040006D4*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld TarTowerPourFX TarTowerPourFX.<TarCauldronAnimate>d__14::<>4__this  /*0x040006D6*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_008e
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int TarTowerPourFX.<TarCauldronAnimate>d__14::<>1__state  /*0x040006D4*/
    IL_001e: ldloc.1
    IL_001f: ldc.i4.1
    IL_0020: stfld bool TarTowerPourFX::_isAnimating  /*0x040006D3*/
    IL_0025: ldarg.0
    IL_0026: ldloc.1
    IL_0027: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_002c: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0031: stfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::<initialPos>5__2  /*0x040006D9*/
    IL_0036: ldarg.0
    IL_0037: ldc.r4 0f
    IL_003c: stfld float TarTowerPourFX.<TarCauldronAnimate>d__14::<timer>5__3  /*0x040006DA*/
    IL_0041: br.s IL_0095
    IL_0043: ldloc.1
    IL_0044: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_0049: ldarg.0
    IL_004a: ldfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::<initialPos>5__2  /*0x040006D9*/
    IL_004f: ldarg.0
    IL_0050: ldfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::targetPos  /*0x040006D7*/
    IL_0055: ldarg.0
    IL_0056: ldfld float TarTowerPourFX.<TarCauldronAnimate>d__14::<timer>5__3  /*0x040006DA*/
    IL_005b: ldarg.0
    IL_005c: ldfld float TarTowerPourFX.<TarCauldronAnimate>d__14::duration  /*0x040006D8*/
    IL_0061: div
    IL_0062: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0067: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld float TarTowerPourFX.<TarCauldronAnimate>d__14::<timer>5__3  /*0x040006DA*/
    IL_0073: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0078: add
    IL_0079: stfld float TarTowerPourFX.<TarCauldronAnimate>d__14::<timer>5__3  /*0x040006DA*/
    IL_007e: ldarg.0
    IL_007f: ldnull
    IL_0080: stfld object TarTowerPourFX.<TarCauldronAnimate>d__14::<>2__current  /*0x040006D5*/
    IL_0085: ldarg.0
    IL_0086: ldc.i4.1
    IL_0087: stfld int TarTowerPourFX.<TarCauldronAnimate>d__14::<>1__state  /*0x040006D4*/
    IL_008c: ldc.i4.1
    IL_008d: ret
    IL_008e: ldarg.0
    IL_008f: ldc.i4.m1
    IL_0090: stfld int TarTowerPourFX.<TarCauldronAnimate>d__14::<>1__state  /*0x040006D4*/
    IL_0095: ldarg.0
    IL_0096: ldfld float TarTowerPourFX.<TarCauldronAnimate>d__14::<timer>5__3  /*0x040006DA*/
    IL_009b: ldarg.0
    IL_009c: ldfld float TarTowerPourFX.<TarCauldronAnimate>d__14::duration  /*0x040006D8*/
    IL_00a1: blt.s IL_0043
    IL_00a3: ldloc.1
    IL_00a4: ldfld Transform TarTowerPourFX::_tarInCauldron  /*0x040006CA*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::<initialPos>5__2  /*0x040006D9*/
    IL_00af: ldarg.0
    IL_00b0: ldfld Vector3 TarTowerPourFX.<TarCauldronAnimate>d__14::targetPos  /*0x040006D7*/
    IL_00b5: ldc.r4 1f
    IL_00ba: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00bf: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00c4: ldloc.1
    IL_00c5: ldnull
    IL_00c6: stfld IEnumerator TarTowerPourFX::_coroutine  /*0x040006D2*/
    IL_00cb: ldloc.1
    IL_00cc: ldc.i4.0
    IL_00cd: stfld bool TarTowerPourFX::_isAnimating  /*0x040006D3*/
    IL_00d2: ldc.i4.0
    IL_00d3: ret

  .method TarTowerPourFX.<TarCauldronAnimate>d__14::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000541 rva 0x170fc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TarTowerPourFX.<TarCauldronAnimate>d__14::<>2__current  /*0x040006D5*/
    IL_0006: ret

  .method TarTowerPourFX.<TarCauldronAnimate>d__14::System.Collections.IEnumerator.Reset()  // token 0x06000542 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method TarTowerPourFX.<TarCauldronAnimate>d__14::System.Collections.IEnumerator.get_Current()  // token 0x06000543 rva 0x170fc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TarTowerPourFX.<TarCauldronAnimate>d__14::<>2__current  /*0x040006D5*/
    IL_0006: ret

