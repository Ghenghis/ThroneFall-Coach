// ===== PoweredAttackController  (token 0x02000116) =====
  .method PoweredAttackController::Start()  // token 0x060005C2 rva 0x1893c attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldfld AutoAttack PoweredAttackController::attack  /*0x04000730*/
    IL_0011: ldc.i4.0
    IL_0012: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0017: ldarg.0
    IL_0018: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_001d: callvirt void ScheduledActivationInteractor::UpdateScheduledVisuals()  /*0x060005F4*/
    IL_0022: ldarg.0
    IL_0023: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0028: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_002d: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_0032: ldarg.0
    IL_0033: ldftn void PoweredAttackController::DoOnUpgrade()  /*0x060005C3*/
    IL_0039: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0043: ret

  .method PoweredAttackController::DoOnUpgrade()  // token 0x060005C3 rva 0x1898c attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0006: callvirt void ScheduledActivationInteractor::UpdateScheduledVisuals()  /*0x060005F4*/
    IL_000b: ret

  .method PoweredAttackController::OnDuskEarly()  // token 0x060005C4 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PoweredAttackController::OnDusk()  // token 0x060005C5 rva 0x18999 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AutoAttack PoweredAttackController::attack  /*0x04000730*/
    IL_0006: ldarg.0
    IL_0007: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_000c: callvirt bool ScheduledActivationInteractor::get_IsPoweredUp()  /*0x060005EF*/
    IL_0011: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0016: ldarg.0
    IL_0017: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_001c: callvirt bool ScheduledActivationInteractor::get_IsPoweredUp()  /*0x060005EF*/
    IL_0021: brfalse.s IL_002e
    IL_0023: ldarg.0
    IL_0024: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0029: callvirt void ScheduledActivationInteractor::SpendPower()  /*0x060005F5*/
    IL_002e: ldarg.0
    IL_002f: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0034: ldc.i4.0
    IL_0035: callvirt void ScheduledActivationInteractor::SetIsTrueDay(bool)  /*0x060005F6*/
    IL_003a: ret

  .method PoweredAttackController::OnDawn_AfterSunrise()  // token 0x060005C6 rva 0x189d5 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void ScheduledActivationInteractor::SetIsTrueDay(bool)  /*0x060005F6*/
    IL_000c: ldarg.0
    IL_000d: ldfld ScheduledActivationInteractor PoweredAttackController::scheduledPower  /*0x04000731*/
    IL_0012: callvirt void ScheduledActivationInteractor::UpdateScheduledVisuals()  /*0x060005F4*/
    IL_0017: ret

  .method PoweredAttackController::OnDawn_BeforeSunrise()  // token 0x060005C7 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PoweredAttackController::.ctor()  // token 0x060005C8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

