// ===== LavaRiverController  (token 0x02000102) =====
  .method LavaRiverController::Start()  // token 0x06000552 rva 0x17254 attrs Private, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0017
    IL_000c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0011: ldarg.0
    IL_0012: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0017: ldarg.0
    IL_0018: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_001d: ldnull
    IL_001e: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0023: brfalse.s IL_0030
    IL_0025: ldstr "LavaRiverController requires AutoAttackLavaRiver to be set."
    IL_002a: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld bool LavaRiverController::inited  /*0x040006E9*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.0
    IL_0039: call void LavaRiverController::ToggleObjects(bool)  /*0x06000558*/
    IL_003e: ldarg.0
    IL_003f: ldc.i4.0
    IL_0040: call void LavaRiverController::ToggleVFX(bool)  /*0x06000559*/
    IL_0045: ret

  .method LavaRiverController::OnDestroy()  // token 0x06000553 rva 0x172a6 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LavaRiverController::inited  /*0x040006E9*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_000f: callvirt bool UnityEngine.Behaviour::get_isActiveAndEnabled()  /*0x0A000234*/
    IL_0014: brfalse.s IL_0021
    IL_0016: ldarg.0
    IL_0017: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_001c: callvirt void AutoAttackLavaRiver::TurnOff()  /*0x06000448*/
    IL_0021: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0026: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002b: brfalse.s IL_0038
    IL_002d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0032: ldarg.0
    IL_0033: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0038: ret

  .method LavaRiverController::OnDuskEarly()  // token 0x06000554 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LavaRiverController::OnDusk()  // token 0x06000555 rva 0x172e0 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LavaRiverController::inited  /*0x040006E9*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_000f: callvirt bool UnityEngine.Behaviour::get_isActiveAndEnabled()  /*0x0A000234*/
    IL_0014: brfalse.s IL_002f
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: call void LavaRiverController::ToggleObjects(bool)  /*0x06000558*/
    IL_001d: ldarg.0
    IL_001e: ldc.i4.1
    IL_001f: call void LavaRiverController::ToggleVFX(bool)  /*0x06000559*/
    IL_0024: ldarg.0
    IL_0025: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_002a: callvirt void AutoAttackLavaRiver::TurnOn()  /*0x06000447*/
    IL_002f: ret

  .method LavaRiverController::OnDawn_AfterSunrise()  // token 0x06000556 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LavaRiverController::OnDawn_BeforeSunrise()  // token 0x06000557 rva 0x17311 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LavaRiverController::inited  /*0x040006E9*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_000f: callvirt bool UnityEngine.Behaviour::get_isActiveAndEnabled()  /*0x0A000234*/
    IL_0014: brfalse.s IL_002f
    IL_0016: ldarg.0
    IL_0017: ldc.i4.0
    IL_0018: call void LavaRiverController::ToggleObjects(bool)  /*0x06000558*/
    IL_001d: ldarg.0
    IL_001e: ldc.i4.0
    IL_001f: call void LavaRiverController::ToggleVFX(bool)  /*0x06000559*/
    IL_0024: ldarg.0
    IL_0025: ldfld AutoAttackLavaRiver LavaRiverController::autoAttackLavaRiver  /*0x040006E8*/
    IL_002a: callvirt void AutoAttackLavaRiver::TurnOff()  /*0x06000448*/
    IL_002f: ret

  .method LavaRiverController::ToggleObjects(bool)  // token 0x06000558 rva 0x17344 attrs Private, HideBySig
    // code size 108 (0x6c), max stack 3, init locals
    .locals ([0] List.Enumerator<GameObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> LavaRiverController::inactiveObjects  /*0x040006E4*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001e
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0015: ldarg.1
    IL_0016: ldc.i4.0
    IL_0017: ceq
    IL_0019: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001e: ldloca.s 0
    IL_0020: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0025: brtrue.s IL_000e
    IL_0027: leave.s IL_0037
    IL_0029: ldloca.s 0
    IL_002b: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0031: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0036: endfinally
    IL_0037: ldarg.0
    IL_0038: ldfld List<GameObject> LavaRiverController::activeObjects  /*0x040006E5*/
    IL_003d: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0042: stloc.0
    IL_0043: br.s IL_0052
    IL_0045: ldloca.s 0
    IL_0047: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_004c: ldarg.1
    IL_004d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0052: ldloca.s 0
    IL_0054: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0059: brtrue.s IL_0045
    IL_005b: leave.s IL_006b
    IL_005d: ldloca.s 0
    IL_005f: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_0065: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006a: endfinally
    IL_006b: ret
    .try IL_000c-IL_0029 finally handler IL_0029-IL_0037
    .try IL_0043-IL_005d finally handler IL_005d-IL_006b

  .method LavaRiverController::ToggleVFX(bool)  // token 0x06000559 rva 0x173d8 attrs Private, HideBySig
    // code size 129 (0x81), max stack 1, init locals
    .locals ([0] List.Enumerator<ParticleSystem>, [1] ParticleSystem, [2] ParticleSystem)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ParticleSystem> LavaRiverController::inactiveVFXs  /*0x040006E6*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.ParticleSystem>::GetEnumerator()  /*0x0A00022E*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0027
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::get_Current()  /*0x0A00022F*/
    IL_0015: stloc.1
    IL_0016: ldarg.1
    IL_0017: brtrue.s IL_0021
    IL_0019: ldloc.1
    IL_001a: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_001f: br.s IL_0027
    IL_0021: ldloc.1
    IL_0022: callvirt void UnityEngine.ParticleSystem::Stop()  /*0x0A00022C*/
    IL_0027: ldloca.s 0
    IL_0029: call bool System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::MoveNext()  /*0x0A000230*/
    IL_002e: brtrue.s IL_000e
    IL_0030: leave.s IL_0040
    IL_0032: ldloca.s 0
    IL_0034: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>  /*0x1B00005A*/
    IL_003a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003f: endfinally
    IL_0040: ldarg.0
    IL_0041: ldfld List<ParticleSystem> LavaRiverController::activeVFXs  /*0x040006E7*/
    IL_0046: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.ParticleSystem>::GetEnumerator()  /*0x0A00022E*/
    IL_004b: stloc.0
    IL_004c: br.s IL_0067
    IL_004e: ldloca.s 0
    IL_0050: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::get_Current()  /*0x0A00022F*/
    IL_0055: stloc.2
    IL_0056: ldarg.1
    IL_0057: brfalse.s IL_0061
    IL_0059: ldloc.2
    IL_005a: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_005f: br.s IL_0067
    IL_0061: ldloc.2
    IL_0062: callvirt void UnityEngine.ParticleSystem::Stop()  /*0x0A00022C*/
    IL_0067: ldloca.s 0
    IL_0069: call bool System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>::MoveNext()  /*0x0A000230*/
    IL_006e: brtrue.s IL_004e
    IL_0070: leave.s IL_0080
    IL_0072: ldloca.s 0
    IL_0074: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.ParticleSystem>  /*0x1B00005A*/
    IL_007a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007f: endfinally
    IL_0080: ret
    .try IL_000c-IL_0032 finally handler IL_0032-IL_0040
    .try IL_004c-IL_0072 finally handler IL_0072-IL_0080

  .method LavaRiverController::.ctor()  // token 0x0600055A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

