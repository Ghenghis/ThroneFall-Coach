// ===== ScheduledActivationInteractor  (token 0x02000121) =====
  .method ScheduledActivationInteractor::get_IsPoweredUp()  // token 0x060005EF rva 0x1928b attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ScheduledActivationInteractor::isPoweredUp  /*0x04000761*/
    IL_0006: ret

  .method ScheduledActivationInteractor::get_CanInteractBySchedule()  // token 0x060005F0 rva 0x19293 attrs Public, HideBySig, SpecialName
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int[] ScheduledActivationInteractor::daysToPowerUp  /*0x0400075B*/
    IL_0006: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_000b: dup
    IL_000c: brtrue.s IL_0012
    IL_000e: pop
    IL_000f: ldc.i4.0
    IL_0010: br.s IL_0017
    IL_0012: call int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0017: ldc.i4.2
    IL_0018: add
    IL_0019: call bool System.Linq.Enumerable::Contains(System.Collections.Generic.IEnumerable<!!0>,!!0)<int>  /*0x2B000048*/
    IL_001e: ret

  .method ScheduledActivationInteractor::get_CanBeInteractedWith()  // token 0x060005F1 rva 0x192b3 attrs Public, Virtual, HideBySig, SpecialName
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: call bool BuildingInteractor::get_CanBeInteractedWith()  /*0x06000BAB*/
    IL_0006: brtrue.s IL_0021
    IL_0008: ldarg.0
    IL_0009: call bool ScheduledActivationInteractor::get_CanInteractBySchedule()  /*0x060005F0*/
    IL_000e: brfalse.s IL_001f
    IL_0010: ldarg.0
    IL_0011: ldfld bool ScheduledActivationInteractor::isPoweredUp  /*0x04000761*/
    IL_0016: brtrue.s IL_001f
    IL_0018: ldarg.0
    IL_0019: ldfld bool ScheduledActivationInteractor::isDayTime  /*0x04000762*/
    IL_001e: ret
    IL_001f: ldc.i4.0
    IL_0020: ret
    IL_0021: ldc.i4.1
    IL_0022: ret

  .method ScheduledActivationInteractor::SetReadyVisuals(bool)  // token 0x060005F2 rva 0x192d7 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScheduledActivationInteractor::readyCue  /*0x0400075F*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ScheduledActivationInteractor::readyCue  /*0x0400075F*/
    IL_0014: ldarg.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ret

  .method ScheduledActivationInteractor::SetPoweredUpVisuals(bool)  // token 0x060005F3 rva 0x192f3 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ScheduledActivationInteractor::poweredUpCue  /*0x04000760*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ScheduledActivationInteractor::poweredUpCue  /*0x04000760*/
    IL_0014: ldarg.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ret

  .method ScheduledActivationInteractor::UpdateScheduledVisuals()  // token 0x060005F4 rva 0x1930f attrs Public, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0007: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000c: ldc.i4.0
    IL_000d: ble.s IL_0017
    IL_000f: ldarg.0
    IL_0010: call bool ScheduledActivationInteractor::get_CanInteractBySchedule()  /*0x060005F0*/
    IL_0015: br.s IL_0018
    IL_0017: ldc.i4.0
    IL_0018: call void ScheduledActivationInteractor::SetReadyVisuals(bool)  /*0x060005F2*/
    IL_001d: ret

  .method ScheduledActivationInteractor::SpendPower()  // token 0x060005F5 rva 0x1932e attrs Public, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool ScheduledActivationInteractor::isPoweredUp  /*0x04000761*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: call void ScheduledActivationInteractor::SetPoweredUpVisuals(bool)  /*0x060005F3*/
    IL_000e: ret

  .method ScheduledActivationInteractor::SetIsTrueDay(bool)  // token 0x060005F6 rva 0x1933e attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool ScheduledActivationInteractor::isDayTime  /*0x04000762*/
    IL_0007: ret

  .method ScheduledActivationInteractor::Focus(PlayerInteraction)  // token 0x060005F7 rva 0x19347 attrs Public, Virtual, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildingInteractor::Focus(PlayerInteraction)  /*0x06000BBB*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_000d: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0012: ldc.i4.1
    IL_0013: blt.s IL_001d
    IL_0015: ldarg.0
    IL_0016: call bool BuildingInteractor::get_Focussed()  /*0x06000BA8*/
    IL_001b: brtrue.s IL_001e
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: ldfld bool ScheduledActivationInteractor::isEnergyCostSetup  /*0x04000763*/
    IL_0024: brtrue.s IL_002c
    IL_0026: ldarg.0
    IL_0027: call void ScheduledActivationInteractor::SetupEnergyCoreCost()  /*0x060005FF*/
    IL_002c: ldarg.0
    IL_002d: call void ScheduledActivationInteractor::ActivateCostDisplay()  /*0x060005FE*/
    IL_0032: ret

  .method ScheduledActivationInteractor::InteractionBegin(PlayerInteraction)  // token 0x060005F8 rva 0x1937b attrs Public, Virtual, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildingInteractor::InteractionBegin(PlayerInteraction)  /*0x06000BB0*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_000d: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0012: ldc.i4.1
    IL_0013: blt.s IL_001d
    IL_0015: ldarg.0
    IL_0016: ldfld bool ScheduledActivationInteractor::started  /*0x04000764*/
    IL_001b: brfalse.s IL_001e
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: ldc.i4.1
    IL_0020: stfld bool ScheduledActivationInteractor::started  /*0x04000764*/
    IL_0025: ldarg.0
    IL_0026: ldc.i4.0
    IL_0027: stfld bool ScheduledActivationInteractor::complete  /*0x04000765*/
    IL_002c: ret

  .method ScheduledActivationInteractor::InteractionHold(PlayerInteraction)  // token 0x060005F9 rva 0x193ac attrs Public, Virtual, HideBySig
    // code size 167 (0xa7), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildingInteractor::InteractionHold(PlayerInteraction)  /*0x06000BB1*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_000d: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0012: ldc.i4.1
    IL_0013: blt.s IL_0025
    IL_0015: ldarg.0
    IL_0016: ldfld bool ScheduledActivationInteractor::complete  /*0x04000765*/
    IL_001b: brtrue.s IL_0025
    IL_001d: ldarg.0
    IL_001e: callvirt bool InteractorBase::get_CanBeInteractedWith()  /*0x06000BE8*/
    IL_0023: brtrue.s IL_0026
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_002c: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0031: ldc.i4.0
    IL_0032: ble.s IL_0042
    IL_0034: ldarg.0
    IL_0035: ldfld bool ScheduledActivationInteractor::isEnergyCostSetup  /*0x04000763*/
    IL_003a: brtrue.s IL_0042
    IL_003c: ldarg.0
    IL_003d: call void ScheduledActivationInteractor::SetupEnergyCoreCost()  /*0x060005FF*/
    IL_0042: ldarg.0
    IL_0043: call bool BuildingInteractor::get_Focussed()  /*0x06000BA8*/
    IL_0048: brfalse.s IL_0060
    IL_004a: ldarg.0
    IL_004b: ldfld bool ScheduledActivationInteractor::isCostVisible  /*0x04000766*/
    IL_0050: brtrue.s IL_0060
    IL_0052: ldarg.0
    IL_0053: call bool ScheduledActivationInteractor::get_CanInteractBySchedule()  /*0x060005F0*/
    IL_0058: brfalse.s IL_0060
    IL_005a: ldarg.0
    IL_005b: call void ScheduledActivationInteractor::ActivateCostDisplay()  /*0x060005FE*/
    IL_0060: ldarg.0
    IL_0061: ldfld bool ScheduledActivationInteractor::started  /*0x04000764*/
    IL_0066: brtrue.s IL_0069
    IL_0068: ret
    IL_0069: ldarg.0
    IL_006a: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_006f: callvirt bool CostDisplay::get_CompletelyFilled()  /*0x06001011*/
    IL_0074: brfalse.s IL_007d
    IL_0076: ldarg.0
    IL_0077: call void ScheduledActivationInteractor::ToggleComplete()  /*0x060005FD*/
    IL_007c: ret
    IL_007d: ldarg.1
    IL_007e: callvirt int PlayerInteraction::get_EnergyCoreBalance()  /*0x06000C05*/
    IL_0083: ldc.i4.0
    IL_0084: ble.s IL_009b
    IL_0086: ldarg.0
    IL_0087: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_008c: callvirt bool CostDisplay::FillUp()  /*0x06001019*/
    IL_0091: brfalse.s IL_00a6
    IL_0093: ldarg.1
    IL_0094: ldc.i4.1
    IL_0095: callvirt void PlayerInteraction::SpendEnergyCores(int)  /*0x06000C11*/
    IL_009a: ret
    IL_009b: ldarg.0
    IL_009c: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_00a1: callvirt void CostDisplay::Deny()  /*0x0600101A*/
    IL_00a6: ret

  .method ScheduledActivationInteractor::InteractionEnd(PlayerInteraction)  // token 0x060005FA rva 0x19460 attrs Public, Virtual, HideBySig
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildingInteractor::InteractionEnd(PlayerInteraction)  /*0x06000BB2*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_000d: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0012: ldc.i4.1
    IL_0013: bge.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldfld bool ScheduledActivationInteractor::started  /*0x04000764*/
    IL_001c: brtrue.s IL_001f
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldc.i4.0
    IL_0021: stfld bool ScheduledActivationInteractor::started  /*0x04000764*/
    IL_0026: ldarg.0
    IL_0027: ldfld bool ScheduledActivationInteractor::complete  /*0x04000765*/
    IL_002c: brtrue.s IL_003a
    IL_002e: ldarg.0
    IL_002f: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0034: ldarg.1
    IL_0035: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_003a: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_003f: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_0044: ret

  .method ScheduledActivationInteractor::Unfocus(PlayerInteraction)  // token 0x060005FB rva 0x194b4 attrs Public, Virtual, HideBySig
    // code size 76 (0x4c), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildingInteractor::Unfocus(PlayerInteraction)  /*0x06000BBD*/
    IL_0007: ldarg.0
    IL_0008: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_000d: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0012: ldc.i4.1
    IL_0013: bge.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldc.i4.0
    IL_0018: stfld bool ScheduledActivationInteractor::complete  /*0x04000765*/
    IL_001d: ldarg.0
    IL_001e: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0023: callvirt bool CostDisplay::get_CompletelyEmpty()  /*0x06001012*/
    IL_0028: brtrue.s IL_0036
    IL_002a: ldarg.0
    IL_002b: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0030: ldarg.1
    IL_0031: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_0036: ldarg.0
    IL_0037: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_003c: callvirt void CostDisplay::Hide()  /*0x0600101E*/
    IL_0041: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0046: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_004b: ret

  .method ScheduledActivationInteractor::OnKnockOut()  // token 0x060005FC rva 0x1950c attrs Public, Virtual, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void BuildingInteractor::OnKnockOut()  /*0x06000BC1*/
    IL_0006: ldarg.0
    IL_0007: ldc.i4.0
    IL_0008: stfld bool ScheduledActivationInteractor::isPoweredUp  /*0x04000761*/
    IL_000d: ret

  .method ScheduledActivationInteractor::ToggleComplete()  // token 0x060005FD rva 0x1951b attrs Private, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ScheduledActivationInteractor::complete  /*0x04000765*/
    IL_0007: ldarg.0
    IL_0008: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_000d: callvirt void CostDisplay::OnCompletion()  /*0x0600101B*/
    IL_0012: ldarg.0
    IL_0013: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0018: callvirt void CostDisplay::Hide()  /*0x0600101E*/
    IL_001d: ldarg.0
    IL_001e: ldc.i4.0
    IL_001f: stfld bool ScheduledActivationInteractor::isCostVisible  /*0x04000766*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.1
    IL_0026: stfld bool ScheduledActivationInteractor::isPoweredUp  /*0x04000761*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.0
    IL_002d: call void ScheduledActivationInteractor::SetReadyVisuals(bool)  /*0x060005F2*/
    IL_0032: ldarg.0
    IL_0033: ldc.i4.1
    IL_0034: call void ScheduledActivationInteractor::SetPoweredUpVisuals(bool)  /*0x060005F3*/
    IL_0039: ret

  .method ScheduledActivationInteractor::ActivateCostDisplay()  // token 0x060005FE rva 0x19556 attrs Private, HideBySig
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int ScheduledActivationInteractor::powerUpCost  /*0x0400075C*/
    IL_0006: ldc.i4.0
    IL_0007: bgt.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0010: ldarg.0
    IL_0011: ldfld int ScheduledActivationInteractor::powerUpCost  /*0x0400075C*/
    IL_0016: ldc.i4.1
    IL_0017: callvirt void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_001c: ldarg.0
    IL_001d: ldc.i4.1
    IL_001e: stfld bool ScheduledActivationInteractor::isCostVisible  /*0x04000766*/
    IL_0023: ret

  .method ScheduledActivationInteractor::SetupEnergyCoreCost()  // token 0x060005FF rva 0x1957b attrs Private, HideBySig
    // code size 53 (0x35), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0006: callvirt void CostDisplay::SetClearCoinPoolFlag()  /*0x06001015*/
    IL_000b: ldarg.0
    IL_000c: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0011: ldarg.0
    IL_0012: ldfld Coinslot ScheduledActivationInteractor::coinslotEnergyCore  /*0x0400075E*/
    IL_0017: stfld Coinslot CostDisplay::coinslotPrefab  /*0x040012E9*/
    IL_001c: ldarg.0
    IL_001d: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0022: ldarg.0
    IL_0023: ldfld Coin ScheduledActivationInteractor::coinEnergyCore  /*0x0400075D*/
    IL_0028: stfld Coin CostDisplay::coinPrefab  /*0x040012EA*/
    IL_002d: ldarg.0
    IL_002e: ldc.i4.1
    IL_002f: stfld bool ScheduledActivationInteractor::isEnergyCostSetup  /*0x04000763*/
    IL_0034: ret

  .method ScheduledActivationInteractor::.ctor()  // token 0x06000600 rva 0x195b1 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld int ScheduledActivationInteractor::powerUpCost  /*0x0400075C*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool ScheduledActivationInteractor::isDayTime  /*0x04000762*/
    IL_000e: ldarg.0
    IL_000f: call void BuildingInteractor::.ctor()  /*0x06000BCC*/
    IL_0014: ret

