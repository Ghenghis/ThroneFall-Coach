// ===== CutOpenPathInteractor  (token 0x02000233) =====
  .method CutOpenPathInteractor::get_CanBeInteractedWith()  // token 0x06000BD3 rva 0x37cad attrs Public, Virtual, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool CutOpenPathInteractor::IsToggleValidToUse()  /*0x06000BE2*/
    IL_0006: ret

  .method CutOpenPathInteractor::Start()  // token 0x06000BD4 rva 0x37cb8 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld PathCutterBase CutOpenPathInteractor::pathToCut  /*0x04000EA8*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_001f
    IL_000d: ldstr "No Cut Component referenced"
    IL_0012: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0017: ldarg.0
    IL_0018: ldc.i4.0
    IL_0019: stfld bool CutOpenPathInteractor::valid  /*0x04000EB6*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld bool CutOpenPathInteractor::wasLoaded  /*0x04000EB8*/
    IL_0025: brtrue.s IL_0033
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: ldfld bool CutOpenPathInteractor::startWithOpenPath  /*0x04000EAD*/
    IL_002e: stfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_0033: ldarg.0
    IL_0034: call void CutOpenPathInteractor::UpdateSymbol()  /*0x06000BE3*/
    IL_0039: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_003e: ldarg.0
    IL_003f: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0044: ldarg.0
    IL_0045: call void CutOpenPathInteractor::UpdateSymbol()  /*0x06000BE3*/
    IL_004a: ret

  .method CutOpenPathInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000BD5 rva 0x37d0f attrs Public, Virtual, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void InteractorBase::InteractionBegin(PlayerInteraction)  /*0x06000BE9*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool CutOpenPathInteractor::interactionStarted  /*0x04000EB3*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.0
    IL_0010: stfld bool CutOpenPathInteractor::interactionComplete  /*0x04000EB4*/
    IL_0015: ret

  .method CutOpenPathInteractor::InteractionHold(PlayerInteraction)  // token 0x06000BD6 rva 0x37d28 attrs Public, Virtual, HideBySig
    // code size 78 (0x4e), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void InteractorBase::InteractionHold(PlayerInteraction)  /*0x06000BEA*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool CutOpenPathInteractor::interactionComplete  /*0x04000EB4*/
    IL_000d: brfalse.s IL_0010
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_0016: callvirt bool CostDisplay::get_CompletelyFilled()  /*0x06001011*/
    IL_001b: brfalse.s IL_0024
    IL_001d: ldarg.0
    IL_001e: call void CutOpenPathInteractor::ToggleComplete()  /*0x06000BE5*/
    IL_0023: ret
    IL_0024: ldarg.1
    IL_0025: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_002a: ldc.i4.0
    IL_002b: ble.s IL_0042
    IL_002d: ldarg.0
    IL_002e: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_0033: callvirt bool CostDisplay::FillUp()  /*0x06001019*/
    IL_0038: brfalse.s IL_004d
    IL_003a: ldarg.1
    IL_003b: ldc.i4.1
    IL_003c: callvirt void PlayerInteraction::SpendCoins(int)  /*0x06000C0F*/
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_0048: callvirt void CostDisplay::Deny()  /*0x0600101A*/
    IL_004d: ret

  .method CutOpenPathInteractor::InteractionEnd(PlayerInteraction)  // token 0x06000BD7 rva 0x37d82 attrs Public, Virtual, HideBySig
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CutOpenPathInteractor::interactionStarted  /*0x04000EB3*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.0
    IL_000b: stfld bool CutOpenPathInteractor::interactionStarted  /*0x04000EB3*/
    IL_0010: ldarg.0
    IL_0011: ldfld bool CutOpenPathInteractor::interactionComplete  /*0x04000EB4*/
    IL_0016: brtrue.s IL_0024
    IL_0018: ldarg.0
    IL_0019: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_001e: ldarg.1
    IL_001f: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_0024: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0029: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_002e: ret

  .method CutOpenPathInteractor::Focus(PlayerInteraction)  // token 0x06000BD8 rva 0x37db2 attrs Public, Virtual, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_0006: ldarg.0
    IL_0007: ldfld int CutOpenPathInteractor::toggleCost  /*0x04000EAC*/
    IL_000c: ldc.i4.1
    IL_000d: callvirt void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_0012: ret

  .method CutOpenPathInteractor::Unfocus(PlayerInteraction)  // token 0x06000BD9 rva 0x37dc6 attrs Public, Virtual, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool CutOpenPathInteractor::interactionComplete  /*0x04000EB4*/
    IL_0007: ldarg.0
    IL_0008: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_000d: callvirt bool CostDisplay::get_CompletelyEmpty()  /*0x06001012*/
    IL_0012: brtrue.s IL_0020
    IL_0014: ldarg.0
    IL_0015: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_001a: ldarg.1
    IL_001b: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_0020: ldarg.0
    IL_0021: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_0026: callvirt void CostDisplay::Hide()  /*0x0600101E*/
    IL_002b: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0030: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_0035: ret

  .method CutOpenPathInteractor::OnDuskEarly()  // token 0x06000BDA rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CutOpenPathInteractor::OnDusk()  // token 0x06000BDB rva 0x37dfd attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool CutOpenPathInteractor::valid  /*0x04000EB6*/
    IL_0006: brfalse.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool CutOpenPathInteractor::autoToggleOnDayNight  /*0x04000EB1*/
    IL_000e: brtrue.s IL_0011
    IL_0010: ret
    IL_0011: ldarg.0
    IL_0012: call void CutOpenPathInteractor::ToggleCutPath()  /*0x06000BE4*/
    IL_0017: ret

  .method CutOpenPathInteractor::OnDawn_AfterSunrise()  // token 0x06000BDC rva 0x37e16 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool CutOpenPathInteractor::wasToggledThisDay  /*0x04000EB7*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool CutOpenPathInteractor::valid  /*0x04000EB6*/
    IL_000d: brfalse.s IL_0017
    IL_000f: ldarg.0
    IL_0010: ldfld bool CutOpenPathInteractor::autoToggleOnDayNight  /*0x04000EB1*/
    IL_0015: brtrue.s IL_0018
    IL_0017: ret
    IL_0018: ldarg.0
    IL_0019: call void CutOpenPathInteractor::ToggleCutPath()  /*0x06000BE4*/
    IL_001e: ret

  .method CutOpenPathInteractor::OnDawn_BeforeSunrise()  // token 0x06000BDD rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CutOpenPathInteractor::OnBeforeMainLoadPass(string)  // token 0x06000BDE rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CutOpenPathInteractor::OnAfterMainLoadPass(string)  // token 0x06000BDF rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CutOpenPathInteractor::OnLoad(string)  // token 0x06000BE0 rva 0x37e38 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 71 (0x47), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldstr "pathOpened"
    IL_0006: ldarg.0
    IL_0007: ldflda bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0011: pop
    IL_0012: ldarg.0
    IL_0013: call void CutOpenPathInteractor::UpdateSymbol()  /*0x06000BE3*/
    IL_0018: ldarg.0
    IL_0019: ldfld PathCutterBase CutOpenPathInteractor::pathToCut  /*0x04000EA8*/
    IL_001e: ldarg.0
    IL_001f: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_0024: callvirt void PathCutterBase::SetPathState(bool)  /*0x06000AF0*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.1
    IL_002b: stfld bool CutOpenPathInteractor::wasLoaded  /*0x04000EB8*/
    IL_0030: ldarg.0
    IL_0031: ldfld UnityEvent<bool> CutOpenPathInteractor::pathStateChanged  /*0x04000EB2*/
    IL_0036: dup
    IL_0037: brtrue.s IL_003b
    IL_0039: pop
    IL_003a: ret
    IL_003b: ldarg.0
    IL_003c: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_0041: call void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0046: ret

  .method CutOpenPathInteractor::OnSave(string)  // token 0x06000BE1 rva 0x37e8b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "pathOpened"
    IL_0006: ldarg.0
    IL_0007: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_0011: ret

  .method CutOpenPathInteractor::IsToggleValidToUse()  // token 0x06000BE2 rva 0x37ea0 attrs Private, HideBySig
    // code size 137 (0x89), max stack 3, init locals
    .locals ([0] bool, [1] bool, [2] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld bool CutOpenPathInteractor::autoToggleOnDayNight  /*0x04000EB1*/
    IL_0006: brtrue.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool CutOpenPathInteractor::valid  /*0x04000EB6*/
    IL_000e: br.s IL_0011
    IL_0010: ldc.i4.0
    IL_0011: ldarg.0
    IL_0012: ldfld bool CutOpenPathInteractor::toogleOnlyAtDay  /*0x04000EAE*/
    IL_0017: brfalse.s IL_0025
    IL_0019: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001e: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0023: brfalse.s IL_0050
    IL_0025: ldarg.0
    IL_0026: ldfld bool CutOpenPathInteractor::toggleOnlyAtNight  /*0x04000EAF*/
    IL_002b: brfalse.s IL_003a
    IL_002d: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0032: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0037: ldc.i4.1
    IL_0038: beq.s IL_0050
    IL_003a: ldarg.0
    IL_003b: ldfld bool CutOpenPathInteractor::toogleOnlyAtDay  /*0x04000EAE*/
    IL_0040: brtrue.s IL_004d
    IL_0042: ldarg.0
    IL_0043: ldfld bool CutOpenPathInteractor::toggleOnlyAtNight  /*0x04000EAF*/
    IL_0048: ldc.i4.0
    IL_0049: ceq
    IL_004b: br.s IL_0051
    IL_004d: ldc.i4.0
    IL_004e: br.s IL_0051
    IL_0050: ldc.i4.1
    IL_0051: stloc.0
    IL_0052: ldarg.0
    IL_0053: ldfld bool CutOpenPathInteractor::toggleOncePerDay  /*0x04000EB0*/
    IL_0058: brfalse.s IL_0065
    IL_005a: ldarg.0
    IL_005b: ldfld bool CutOpenPathInteractor::wasToggledThisDay  /*0x04000EB7*/
    IL_0060: ldc.i4.0
    IL_0061: ceq
    IL_0063: br.s IL_0066
    IL_0065: ldc.i4.1
    IL_0066: stloc.1
    IL_0067: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_006c: ldnull
    IL_006d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0072: brtrue.s IL_0077
    IL_0074: ldc.i4.0
    IL_0075: br.s IL_0081
    IL_0077: ldsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_007c: callvirt bool CastleCenter::get_IsCastleBuilt()  /*0x0600033B*/
    IL_0081: stloc.2
    IL_0082: ldloc.0
    IL_0083: and
    IL_0084: ldloc.1
    IL_0085: and
    IL_0086: ldloc.2
    IL_0087: and
    IL_0088: ret

  .method CutOpenPathInteractor::UpdateSymbol()  // token 0x06000BE3 rva 0x37f35 attrs Private, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject CutOpenPathInteractor::openSymbol  /*0x04000EAA*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_000c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0011: ldarg.0
    IL_0012: ldfld GameObject CutOpenPathInteractor::cutSymbol  /*0x04000EAB*/
    IL_0017: ldarg.0
    IL_0018: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_001d: ldc.i4.0
    IL_001e: ceq
    IL_0020: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0025: ret

  .method CutOpenPathInteractor::ToggleCutPath()  // token 0x06000BE4 rva 0x37f5c attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PathCutterBase CutOpenPathInteractor::pathToCut  /*0x04000EA8*/
    IL_0006: callvirt void PathCutterBase::TogglePathState()  /*0x06000AF1*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld PathCutterBase CutOpenPathInteractor::pathToCut  /*0x04000EA8*/
    IL_0012: callvirt bool PathCutterBase::IsPathOpened()  /*0x06000AF2*/
    IL_0017: stfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_001c: ldarg.0
    IL_001d: ldc.i4.1
    IL_001e: stfld bool CutOpenPathInteractor::wasToggledThisDay  /*0x04000EB7*/
    IL_0023: ldarg.0
    IL_0024: call void CutOpenPathInteractor::UpdateSymbol()  /*0x06000BE3*/
    IL_0029: ret

  .method CutOpenPathInteractor::ToggleComplete()  // token 0x06000BE5 rva 0x37f88 attrs Private, HideBySig
    // code size 74 (0x4a), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool CutOpenPathInteractor::interactionComplete  /*0x04000EB4*/
    IL_0007: ldarg.0
    IL_0008: call void CutOpenPathInteractor::ToggleCutPath()  /*0x06000BE4*/
    IL_000d: ldarg.0
    IL_000e: ldfld UnityEvent<bool> CutOpenPathInteractor::pathStateChanged  /*0x04000EB2*/
    IL_0013: dup
    IL_0014: brtrue.s IL_0019
    IL_0016: pop
    IL_0017: br.s IL_0024
    IL_0019: ldarg.0
    IL_001a: ldfld bool CutOpenPathInteractor::pathOpened  /*0x04000EB5*/
    IL_001f: call void UnityEngine.Events.UnityEvent<bool>::Invoke(!0)  /*0x0A00027A*/
    IL_0024: ldarg.0
    IL_0025: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_002a: callvirt void CostDisplay::OnCompletion()  /*0x0600101B*/
    IL_002f: ldarg.0
    IL_0030: callvirt bool InteractorBase::get_CanBeInteractedWith()  /*0x06000BE8*/
    IL_0035: brfalse.s IL_0049
    IL_0037: ldarg.0
    IL_0038: ldfld CostDisplay CutOpenPathInteractor::costDisplay  /*0x04000EA9*/
    IL_003d: ldarg.0
    IL_003e: ldfld int CutOpenPathInteractor::toggleCost  /*0x04000EAC*/
    IL_0043: ldc.i4.1
    IL_0044: callvirt void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_0049: ret

  .method CutOpenPathInteractor::.ctor()  // token 0x06000BE6 rva 0x37fde attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int CutOpenPathInteractor::toggleCost  /*0x04000EAC*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool CutOpenPathInteractor::startWithOpenPath  /*0x04000EAD*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.1
    IL_0010: stfld bool CutOpenPathInteractor::toggleOncePerDay  /*0x04000EB0*/
    IL_0015: ldarg.0
    IL_0016: ldc.i4.1
    IL_0017: stfld bool CutOpenPathInteractor::valid  /*0x04000EB6*/
    IL_001c: ldarg.0
    IL_001d: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0022: ret

