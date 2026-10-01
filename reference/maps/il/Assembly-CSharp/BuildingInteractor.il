// ===== BuildingInteractor  (token 0x02000230) =====
  .method BuildingInteractor::get_CurrentUpgradePreviewBranchNumber()  // token 0x06000B9F rva 0x370f7 attrs Public, Static, HideBySig, SpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_001e
    IL_000c: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0011: callvirt bool ChoiceManager::get_ChoiceCoroutineRunning()  /*0x0600091E*/
    IL_0016: brfalse.s IL_001e
    IL_0018: ldsfld int ChoiceUIFrameHelper::CurrentSelectionIndex  /*0x040012B5*/
    IL_001d: ret
    IL_001e: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0023: ldc.r4 2f
    IL_0028: mul
    IL_0029: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_002e: ret

  .method BuildingInteractor::get_IsChoosingUpgrade()  // token 0x06000BA0 rva 0x37127 attrs Public, Static, HideBySig, SpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0017
    IL_000c: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_0011: callvirt bool ChoiceManager::get_ChoiceCoroutineRunning()  /*0x0600091E*/
    IL_0016: ret
    IL_0017: ldc.i4.0
    IL_0018: ret

  .method BuildingInteractor::get_IncomeModifiers()  // token 0x06000BA1 rva 0x37141 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<IncomeModifyer> BuildingInteractor::incomeModifiers  /*0x04000E93*/
    IL_0006: ret

  .method BuildingInteractor::get_KnockedOutTonight()  // token 0x06000BA2 rva 0x37149 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_0006: ret

  .method BuildingInteractor::SetHarvested(bool)  // token 0x06000BA3 rva 0x37151 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0007: ret

  .method BuildingInteractor::MarkAsHarvested()  // token 0x06000BA4 rva 0x3715a attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0007: ret

  .method BuildingInteractor::get_canBeHarvested()  // token 0x06000BA5 rva 0x37163 attrs Public, HideBySig, SpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_003c
    IL_000e: ldarg.0
    IL_000f: ldfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0014: brtrue.s IL_003c
    IL_0016: ldarg.0
    IL_0017: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_001c: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0021: ldc.i4.0
    IL_0022: bgt.s IL_0032
    IL_0024: ldarg.0
    IL_0025: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_002a: callvirt int BuildSlot::get_EnergyCoreIncome()  /*0x060002DC*/
    IL_002f: ldc.i4.0
    IL_0030: ble.s IL_003c
    IL_0032: ldarg.0
    IL_0033: ldfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_0038: ldc.i4.0
    IL_0039: ceq
    IL_003b: ret
    IL_003c: ldc.i4.0
    IL_003d: ret

  .method BuildingInteractor::get_harvestIsDenied()  // token 0x06000BA6 rva 0x371a2 attrs Public, HideBySig, SpecialName
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_0039
    IL_000e: ldarg.0
    IL_000f: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0014: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0019: ldc.i4.0
    IL_001a: bgt.s IL_0032
    IL_001c: ldarg.0
    IL_001d: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0022: callvirt int BuildSlot::get_EnergyCoreIncome()  /*0x060002DC*/
    IL_0027: ldc.i4.0
    IL_0028: bgt.s IL_0032
    IL_002a: ldarg.0
    IL_002b: ldfld bool BuildingInteractor::showsHarvestDeniedCueEvenWithNoIncome  /*0x04000E92*/
    IL_0030: brfalse.s IL_0039
    IL_0032: ldarg.0
    IL_0033: ldfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_0038: ret
    IL_0039: ldc.i4.0
    IL_003a: ret

  .method BuildingInteractor::get_GoldIncome()  // token 0x06000BA7 rva 0x371de attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_000b: ret

  .method BuildingInteractor::get_Focussed()  // token 0x06000BA8 rva 0x371eb attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0006: ret

  .method BuildingInteractor::get_HarvestCueVisible()  // token 0x06000BA9 rva 0x371f3 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BuildingInteractor::harvestCue  /*0x04000E8D*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: ret

  .method BuildingInteractor::get_UpgradeCueVisible()  // token 0x06000BAA rva 0x37200 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: ret

  .method BuildingInteractor::get_CanBeInteractedWith()  // token 0x06000BAB rva 0x3720d attrs Public, Virtual, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0006: ldc.i4.0
    IL_0007: cgt.un
    IL_0009: ret

  .method BuildingInteractor::get_IsWaitingForChoice()  // token 0x06000BAC rva 0x37218 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: ret

  .method BuildingInteractor::SetNeverDenyHarvest(bool)  // token 0x06000BAD rva 0x37220 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool BuildingInteractor::neverDenyHarvest  /*0x04000EA0*/
    IL_0007: ret

  .method BuildingInteractor::ReturnTooltip()  // token 0x06000BAE rva 0x37229 attrs Public, Virtual, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt string BuildSlot::ReturnTooltip()  /*0x060002E5*/
    IL_000b: ret

  .method BuildingInteractor::Start()  // token 0x06000BAF rva 0x37238 attrs Private, HideBySig
    // code size 158 (0x9e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: ldarg.0
    IL_0007: stfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_000c: ldarg.0
    IL_000d: ldfld Hp BuildingInteractor::buildingHP  /*0x04000E8A*/
    IL_0012: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0017: brfalse.s IL_0036
    IL_0019: ldarg.0
    IL_001a: ldfld Hp BuildingInteractor::buildingHP  /*0x04000E8A*/
    IL_001f: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0024: ldarg.0
    IL_0025: dup
    IL_0026: ldvirtftn void BuildingInteractor::OnKnockOut()  /*0x06000BC1*/
    IL_002c: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0031: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0036: ldarg.0
    IL_0037: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_003c: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_0041: ldarg.0
    IL_0042: ldftn void BuildingInteractor::OnTargetUpgrade()  /*0x06000BB5*/
    IL_0048: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_004d: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0052: ldarg.0
    IL_0053: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0058: ldfld UnityEvent BuildSlot::OnUpgradeCancel  /*0x040003B2*/
    IL_005d: ldarg.0
    IL_005e: ldftn void BuildingInteractor::OnTargetUpgradeCanceled()  /*0x06000BB6*/
    IL_0064: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0069: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_006e: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0073: ldarg.0
    IL_0074: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0079: ldarg.0
    IL_007a: ldc.i4.0
    IL_007b: ldc.i4.0
    IL_007c: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0081: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0086: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_008b: brfalse.s IL_009d
    IL_008d: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0092: ldfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_0097: ldarg.0
    IL_0098: callvirt void System.Collections.Generic.List<BuildingInteractor>::Add(!0)  /*0x0A0004F6*/
    IL_009d: ret

  .method BuildingInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000BB0 rva 0x372e2 attrs Public, Virtual, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.1
    IL_000b: stfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_0010: ldarg.0
    IL_0011: ldc.i4.0
    IL_0012: stfld bool BuildingInteractor::interactionComplete  /*0x04000E9B*/
    IL_0017: ldarg.0
    IL_0018: ldarg.1
    IL_0019: stfld PlayerInteraction BuildingInteractor::bufferedPlayer  /*0x04000E9E*/
    IL_001e: ldarg.0
    IL_001f: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0024: ldc.i4.2
    IL_0025: bne.un.s IL_002d
    IL_0027: ldc.i4.3
    IL_0028: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_002d: ret

  .method BuildingInteractor::InteractionHold(PlayerInteraction)  // token 0x06000BB1 rva 0x37314 attrs Public, Virtual, HideBySig
    // code size 243 (0xf3), max stack 3, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0006: ldc.i4.2
    IL_0007: bne.un.s IL_0021
    IL_0009: ldarg.0
    IL_000a: ldfld bool BuildingInteractor::interactionComplete  /*0x04000E9B*/
    IL_000f: brtrue.s IL_0021
    IL_0011: ldarg.0
    IL_0012: ldfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_0017: brfalse.s IL_0021
    IL_0019: ldarg.0
    IL_001a: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_001f: brfalse.s IL_0022
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0028: callvirt bool CostDisplay::get_CompletelyFilled()  /*0x06001011*/
    IL_002d: brfalse.s IL_006e
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0036: callvirt bool BuildSlot::get_NextUpgradeIsChoice()  /*0x060002E4*/
    IL_003b: stfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0040: ldarg.0
    IL_0041: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0046: ldarg.1
    IL_0047: ldc.i4.1
    IL_0048: callvirt void BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  /*0x060002F6*/
    IL_004d: ldarg.0
    IL_004e: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0053: brtrue.s IL_005c
    IL_0055: ldarg.0
    IL_0056: call void BuildingInteractor::BuildComplete()  /*0x06000BB3*/
    IL_005b: ret
    IL_005c: ldarg.0
    IL_005d: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0062: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0067: ldc.i4.0
    IL_0068: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_006d: ret
    IL_006e: ldarg.1
    IL_006f: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_0074: ldc.i4.0
    IL_0075: ble.s IL_0099
    IL_0077: ldarg.0
    IL_0078: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_007d: callvirt int BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  /*0x060002E8*/
    IL_0082: brtrue.s IL_0099
    IL_0084: ldarg.0
    IL_0085: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_008a: callvirt bool CostDisplay::FillUp()  /*0x06001019*/
    IL_008f: brfalse.s IL_00f2
    IL_0091: ldarg.1
    IL_0092: ldc.i4.1
    IL_0093: callvirt void PlayerInteraction::SpendCoins(int)  /*0x06000C0F*/
    IL_0098: ret
    IL_0099: ldarg.1
    IL_009a: callvirt int PlayerInteraction::get_EnergyCoreBalance()  /*0x06000C05*/
    IL_009f: ldc.i4.0
    IL_00a0: ble.s IL_00e7
    IL_00a2: ldarg.0
    IL_00a3: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_00a8: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_00ad: brtrue.s IL_00e7
    IL_00af: ldc.i4.0
    IL_00b0: ldarg.0
    IL_00b1: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00b6: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_00bb: stloc.0
    IL_00bc: ldloca.s 0
    IL_00be: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_00c3: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_00c8: brfalse.s IL_00e7
    IL_00ca: ldc.i4.0
    IL_00cb: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_00d0: brfalse.s IL_00e7
    IL_00d2: ldarg.0
    IL_00d3: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_00d8: callvirt bool CostDisplay::FillUp()  /*0x06001019*/
    IL_00dd: brfalse.s IL_00f2
    IL_00df: ldarg.1
    IL_00e0: ldc.i4.1
    IL_00e1: callvirt void PlayerInteraction::SpendEnergyCores(int)  /*0x06000C11*/
    IL_00e6: ret
    IL_00e7: ldarg.0
    IL_00e8: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_00ed: callvirt void CostDisplay::Deny()  /*0x0600101A*/
    IL_00f2: ret

  .method BuildingInteractor::InteractionEnd(PlayerInteraction)  // token 0x06000BB2 rva 0x37413 attrs Public, Virtual, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: brtrue.s IL_0010
    IL_0008: ldarg.0
    IL_0009: ldfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_000e: brtrue.s IL_0011
    IL_0010: ret
    IL_0011: ldarg.0
    IL_0012: ldc.i4.0
    IL_0013: stfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_0018: ldarg.0
    IL_0019: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_001e: ldc.i4.2
    IL_001f: beq.s IL_0022
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0028: ldarg.1
    IL_0029: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_002e: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0033: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_0038: ret

  .method BuildingInteractor::BuildComplete()  // token 0x06000BB3 rva 0x3744d attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool BuildingInteractor::interactionComplete  /*0x04000E9B*/
    IL_000e: ldarg.0
    IL_000f: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0014: callvirt void CostDisplay::OnCompletion()  /*0x0600101B*/
    IL_0019: ldarg.0
    IL_001a: ldc.i4.0
    IL_001b: ldc.i4.0
    IL_001c: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0021: ret

  .method BuildingInteractor::CancelBuild()  // token 0x06000BB4 rva 0x37470 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0006: ldarg.0
    IL_0007: ldfld PlayerInteraction BuildingInteractor::bufferedPlayer  /*0x04000E9E*/
    IL_000c: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_0011: ret

  .method BuildingInteractor::OnTargetUpgrade()  // token 0x06000BB5 rva 0x37483 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: brfalse.s IL_002d
    IL_0008: ldarg.0
    IL_0009: ldc.i4.0
    IL_000a: stfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_000f: ldarg.0
    IL_0010: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: ldc.i4.1
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldarg.0
    IL_0021: ldc.i4.0
    IL_0022: stfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_0027: ldarg.0
    IL_0028: call void BuildingInteractor::BuildComplete()  /*0x06000BB3*/
    IL_002d: ret

  .method BuildingInteractor::OnTargetUpgradeCanceled()  // token 0x06000BB6 rva 0x374b2 attrs Private, HideBySig
    // code size 59 (0x3b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: brfalse.s IL_003a
    IL_0008: ldarg.0
    IL_0009: ldc.i4.0
    IL_000a: stfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_000f: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0014: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0019: ldc.i4.1
    IL_001a: beq.s IL_002d
    IL_001c: ldarg.0
    IL_001d: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0022: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0027: ldc.i4.1
    IL_0028: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002d: ldarg.0
    IL_002e: ldc.i4.0
    IL_002f: stfld bool BuildingInteractor::interactionStarted  /*0x04000E9C*/
    IL_0034: ldarg.0
    IL_0035: call void BuildingInteractor::CancelBuild()  /*0x06000BB4*/
    IL_003a: ret

  .method BuildingInteractor::OnDusk()  // token 0x06000BB7 rva 0x374ee attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: ldc.i4.0
    IL_000a: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_000f: ret

  .method BuildingInteractor::OnDawn_BeforeSunrise()  // token 0x06000BB8 rva 0x374ff attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0007: ret

  .method BuildingInteractor::OnDawn_AfterSunrise()  // token 0x06000BB9 rva 0x37508 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 89 (0x59), max stack 3, init locals
    .locals ([0] PlayerInteraction, [1] List.Enumerator<IncomeModifyer>)
    IL_0000: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0005: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_000a: ldc.i4.0
    IL_000b: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_0010: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_0015: stloc.0
    IL_0016: ldarg.0
    IL_0017: ldloc.0
    IL_0018: call void BuildingInteractor::Harvest(PlayerInteraction)  /*0x06000BBC*/
    IL_001d: ldarg.0
    IL_001e: ldfld List<IncomeModifyer> BuildingInteractor::incomeModifiers  /*0x04000E93*/
    IL_0023: callvirt List.Enumerator<!0> System.Collections.Generic.List<IncomeModifyer>::GetEnumerator()  /*0x0A0004F7*/
    IL_0028: stloc.1
    IL_0029: br.s IL_0037
    IL_002b: ldloca.s 1
    IL_002d: call !0 System.Collections.Generic.List.Enumerator<IncomeModifyer>::get_Current()  /*0x0A0004F8*/
    IL_0032: callvirt void IncomeModifyer::OnDawn()  /*0x0600083A*/
    IL_0037: ldloca.s 1
    IL_0039: call bool System.Collections.Generic.List.Enumerator<IncomeModifyer>::MoveNext()  /*0x0A0004F9*/
    IL_003e: brtrue.s IL_002b
    IL_0040: leave.s IL_0050
    IL_0042: ldloca.s 1
    IL_0044: constrained. System.Collections.Generic.List.Enumerator<IncomeModifyer>  /*0x1B0000DD*/
    IL_004a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_004f: endfinally
    IL_0050: ldarg.0
    IL_0051: ldc.i4.0
    IL_0052: ldc.i4.0
    IL_0053: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0058: ret
    .try IL_0029-IL_0042 finally handler IL_0042-IL_0050

  .method BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  // token 0x06000BBA rva 0x37580 attrs Public, HideBySig
    // code size 343 (0x157), max stack 2, init locals
    .locals ([0] BuildingInteractor.InteractionState)
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::isWaitingForChoice  /*0x04000E9D*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0014: brtrue.s IL_0017
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001d: ldc.i4.1
    IL_001e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0023: ldarg.0
    IL_0024: call bool BuildingInteractor::get_canBeHarvested()  /*0x06000BA5*/
    IL_0029: brfalse.s IL_0034
    IL_002b: ldarg.0
    IL_002c: ldc.i4.1
    IL_002d: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0032: br.s IL_0051
    IL_0034: ldarg.0
    IL_0035: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_003a: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_003f: brfalse.s IL_004a
    IL_0041: ldarg.0
    IL_0042: ldc.i4.2
    IL_0043: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0048: br.s IL_0051
    IL_004a: ldarg.0
    IL_004b: ldc.i4.0
    IL_004c: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0051: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0056: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_005b: ldc.i4.1
    IL_005c: bne.un.s IL_0065
    IL_005e: ldarg.0
    IL_005f: ldc.i4.0
    IL_0060: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0065: ldarg.1
    IL_0066: brfalse.s IL_006f
    IL_0068: ldarg.0
    IL_0069: ldarg.2
    IL_006a: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_006f: ldarg.0
    IL_0070: call bool BuildingInteractor::get_harvestIsDenied()  /*0x06000BA6*/
    IL_0075: brfalse.s IL_0085
    IL_0077: ldarg.0
    IL_0078: ldfld GameObject BuildingInteractor::harvestDeniedCue  /*0x04000E8E*/
    IL_007d: ldc.i4.1
    IL_007e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0083: br.s IL_0091
    IL_0085: ldarg.0
    IL_0086: ldfld GameObject BuildingInteractor::harvestDeniedCue  /*0x04000E8E*/
    IL_008b: ldc.i4.0
    IL_008c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0091: ldarg.0
    IL_0092: ldfld bool BuildingInteractor::buildingIsCurrentlyBusyAndCantBeUpgraded  /*0x04000E9F*/
    IL_0097: brfalse.s IL_00a0
    IL_0099: ldarg.0
    IL_009a: ldc.i4.0
    IL_009b: stfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_00a6: stloc.0
    IL_00a7: ldloc.0
    IL_00a8: switch (IL_00ba, IL_00d9, IL_0102)
    IL_00b9: ret
    IL_00ba: ldarg.0
    IL_00bb: ldfld GameObject BuildingInteractor::harvestCue  /*0x04000E8D*/
    IL_00c0: ldc.i4.0
    IL_00c1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_00cc: ldc.i4.0
    IL_00cd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00d2: ldarg.0
    IL_00d3: call void BuildingInteractor::DisableCostDisplay()  /*0x06000BC0*/
    IL_00d8: ret
    IL_00d9: ldarg.0
    IL_00da: ldfld GameObject BuildingInteractor::harvestCue  /*0x04000E8D*/
    IL_00df: ldc.i4.1
    IL_00e0: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e5: ldarg.0
    IL_00e6: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_00eb: ldarg.0
    IL_00ec: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_00f1: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_00f6: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00fb: ldarg.0
    IL_00fc: call void BuildingInteractor::DisableCostDisplay()  /*0x06000BC0*/
    IL_0101: ret
    IL_0102: ldarg.0
    IL_0103: ldfld GameObject BuildingInteractor::harvestCue  /*0x04000E8D*/
    IL_0108: ldc.i4.0
    IL_0109: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010e: ldarg.0
    IL_010f: ldfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0114: brfalse.s IL_0129
    IL_0116: ldarg.0
    IL_0117: call void BuildingInteractor::ActivateCostDisplay()  /*0x06000BBF*/
    IL_011c: ldarg.0
    IL_011d: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_0122: ldc.i4.0
    IL_0123: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0128: ret
    IL_0129: ldarg.0
    IL_012a: call void BuildingInteractor::DisableCostDisplay()  /*0x06000BC0*/
    IL_012f: ldarg.0
    IL_0130: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0135: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_013a: ldc.i4.1
    IL_013b: bne.un.s IL_014a
    IL_013d: ldarg.0
    IL_013e: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_0143: ldc.i4.1
    IL_0144: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0149: ret
    IL_014a: ldarg.0
    IL_014b: ldfld GameObject BuildingInteractor::upgradeCue  /*0x04000E8F*/
    IL_0150: ldc.i4.0
    IL_0151: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0156: ret

  .method BuildingInteractor::Focus(PlayerInteraction)  // token 0x06000BBB rva 0x376e3 attrs Public, Virtual, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.0
    IL_0009: ldc.i4.0
    IL_000a: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_000f: ldarg.0
    IL_0010: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0015: ldc.i4.1
    IL_0016: bne.un.s IL_001f
    IL_0018: ldarg.0
    IL_0019: ldarg.1
    IL_001a: call void BuildingInteractor::Harvest(PlayerInteraction)  /*0x06000BBC*/
    IL_001f: ret

  .method BuildingInteractor::Harvest(PlayerInteraction)  // token 0x06000BBC rva 0x37704 attrs Public, HideBySig
    // code size 151 (0x97), max stack 3, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.0
    IL_0001: call bool BuildingInteractor::get_canBeHarvested()  /*0x06000BA5*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld CoinSpawner BuildingInteractor::coinSpawner  /*0x04000E8B*/
    IL_000f: ldnull
    IL_0010: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0015: brfalse.s IL_002e
    IL_0017: ldarg.0
    IL_0018: ldfld CoinSpawner BuildingInteractor::coinSpawner  /*0x04000E8B*/
    IL_001d: ldarg.0
    IL_001e: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0023: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0028: ldarg.1
    IL_0029: callvirt void CoinSpawner::TriggerCoinSpawn(int,PlayerInteraction)  /*0x06000347*/
    IL_002e: ldc.i4.0
    IL_002f: ldarg.0
    IL_0030: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0035: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_003a: stloc.0
    IL_003b: ldloca.s 0
    IL_003d: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0042: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_0047: brfalse.s IL_0051
    IL_0049: ldc.i4.0
    IL_004a: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_004f: br.s IL_0052
    IL_0051: ldc.i4.0
    IL_0052: brfalse.s IL_0087
    IL_0054: ldarg.0
    IL_0055: ldfld EnergyCoreSpawner BuildingInteractor::energyCoreSpawner  /*0x04000E8C*/
    IL_005a: ldnull
    IL_005b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0060: brfalse.s IL_0087
    IL_0062: ldarg.0
    IL_0063: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0068: callvirt int BuildSlot::get_EnergyCoreIncome()  /*0x060002DC*/
    IL_006d: ldc.i4.0
    IL_006e: ble.s IL_0087
    IL_0070: ldarg.0
    IL_0071: ldfld EnergyCoreSpawner BuildingInteractor::energyCoreSpawner  /*0x04000E8C*/
    IL_0076: ldarg.0
    IL_0077: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_007c: callvirt int BuildSlot::get_EnergyCoreIncome()  /*0x060002DC*/
    IL_0081: ldarg.1
    IL_0082: callvirt void EnergyCoreSpawner::TriggerEnergyCoreSpawn(int,PlayerInteraction)  /*0x060006B7*/
    IL_0087: ldarg.0
    IL_0088: ldc.i4.1
    IL_0089: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_008e: ldarg.0
    IL_008f: ldc.i4.0
    IL_0090: ldc.i4.0
    IL_0091: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0096: ret

  .method BuildingInteractor::Unfocus(PlayerInteraction)  // token 0x06000BBD rva 0x377a7 attrs Public, Virtual, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0007: ldarg.0
    IL_0008: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_000d: callvirt bool CostDisplay::get_CompletelyEmpty()  /*0x06001012*/
    IL_0012: brtrue.s IL_0020
    IL_0014: ldarg.0
    IL_0015: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_001a: ldarg.1
    IL_001b: callvirt void CostDisplay::CancelFill(PlayerInteraction)  /*0x0600101C*/
    IL_0020: ldarg.0
    IL_0021: ldc.i4.0
    IL_0022: ldc.i4.0
    IL_0023: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_0028: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_002d: callvirt void ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  /*0x06000218*/
    IL_0032: ret

  .method BuildingInteractor::get_UpgradePreviewMesh()  // token 0x06000BBE rva 0x377dc attrs Public, HideBySig, SpecialName
    // code size 108 (0x6c), max stack 3, init locals
    .locals ([0] BuildSlot.Upgrade)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_000b: ldc.i4.1
    IL_000c: bne.un.s IL_005b
    IL_000e: ldarg.0
    IL_000f: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0014: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0019: brtrue.s IL_001d
    IL_001b: ldnull
    IL_001c: ret
    IL_001d: ldarg.0
    IL_001e: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0023: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_0028: ldarg.0
    IL_0029: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_002e: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: stloc.0
    IL_0039: ldloc.0
    IL_003a: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_003f: call int BuildingInteractor::get_CurrentUpgradePreviewBranchNumber()  /*0x06000B9F*/
    IL_0044: ldloc.0
    IL_0045: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_004a: callvirt int System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Count()  /*0x0A00011E*/
    IL_004f: rem
    IL_0050: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_0055: ldfld Mesh BuildSlot.UpgradeBranch::replacementMesh  /*0x040003C0*/
    IL_005a: ret
    IL_005b: ldarg.0
    IL_005c: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0061: callvirt MeshFilter BuildSlot::get_MainMesh()  /*0x060002D7*/
    IL_0066: callvirt Mesh UnityEngine.MeshFilter::get_mesh()  /*0x0A0004FA*/
    IL_006b: ret

  .method BuildingInteractor::ActivateCostDisplay()  // token 0x06000BBF rva 0x37854 attrs Private, HideBySig
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt int BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  /*0x060002E8*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_0026
    IL_000e: ldarg.0
    IL_000f: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0014: ldarg.0
    IL_0015: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_001a: callvirt int BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  /*0x060002E8*/
    IL_001f: ldc.i4.1
    IL_0020: callvirt void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_002c: ldarg.0
    IL_002d: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0032: callvirt int BuildSlot::get_NextUpgradeOrBuildCost()  /*0x060002E6*/
    IL_0037: ldc.i4.1
    IL_0038: callvirt void CostDisplay::UpdateDisplay(int,bool)  /*0x06001017*/
    IL_003d: ret

  .method BuildingInteractor::DisableCostDisplay()  // token 0x06000BC0 rva 0x37893 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0006: callvirt void CostDisplay::Hide()  /*0x0600101E*/
    IL_000b: ret

  .method BuildingInteractor::OnKnockOut()  // token 0x06000BC1 rva 0x378a0 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::neverDenyHarvest  /*0x04000EA0*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldc.i4.1
    IL_000a: stfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_000f: ret

  .method BuildingInteractor::Update()  // token 0x06000BC2 rva 0x378b4 attrs Private, HideBySig
    // code size 104 (0x68), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldsfld bool BuildingInteractor::displayAllBuildPreviews  /*0x04000E88*/
    IL_000d: brfalse.s IL_0042
    IL_000f: ldarg.0
    IL_0010: ldfld BuildingInteractor.InteractionState BuildingInteractor::currentState  /*0x04000E96*/
    IL_0015: ldc.i4.2
    IL_0016: bne.un.s IL_0042
    IL_0018: ldarg.0
    IL_0019: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_001e: callvirt bool BuildSlot::get_ActivatorUpgradesThis()  /*0x060002D0*/
    IL_0023: brtrue.s IL_002d
    IL_0025: ldarg.0
    IL_0026: call void BuildingInteractor::PreviewSelf()  /*0x06000BC3*/
    IL_002b: br.s IL_0042
    IL_002d: ldarg.0
    IL_002e: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0033: callvirt BuildSlot BuildSlot::get_ActivatorBuilding()  /*0x060002CA*/
    IL_0038: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_003d: callvirt void BuildingInteractor::PreviewSelf()  /*0x06000BC3*/
    IL_0042: ldarg.0
    IL_0043: ldfld bool BuildingInteractor::focussed  /*0x04000E99*/
    IL_0048: brtrue.s IL_0067
    IL_004a: ldarg.0
    IL_004b: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0050: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0055: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_005a: brfalse.s IL_0067
    IL_005c: ldarg.0
    IL_005d: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0062: callvirt void CostDisplay::Hide()  /*0x0600101E*/
    IL_0067: ret

  .method BuildingInteractor::PreviewSelf()  // token 0x06000BC3 rva 0x37928 attrs Public, HideBySig
    // code size 479 (0x1df), max stack 4, init locals
    .locals ([0] MeshFilter, [1] int, [2] int, [3] int, [4] BuildSlot, [5] int)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0006: callvirt MeshFilter BuildSlot::get_MainMesh()  /*0x060002D7*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: call Mesh BuildingInteractor::get_UpgradePreviewMesh()  /*0x06000BBE*/
    IL_0012: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0017: brfalse.s IL_0042
    IL_0019: ldarg.0
    IL_001a: call Mesh BuildingInteractor::get_UpgradePreviewMesh()  /*0x06000BBE*/
    IL_001f: ldarg.0
    IL_0020: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0025: callvirt MeshFilter BuildSlot::get_MainMesh()  /*0x060002D7*/
    IL_002a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0034: ldarg.0
    IL_0035: ldfld Material BuildingInteractor::previewMaterial  /*0x04000E91*/
    IL_003a: ldc.i4.0
    IL_003b: call void UnityEngine.Graphics::DrawMesh(UnityEngine.Mesh,UnityEngine.Matrix4x4,UnityEngine.Material,int)  /*0x0A0004FB*/
    IL_0040: br.s IL_006c
    IL_0042: ldloc.0
    IL_0043: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0048: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_004d: brtrue.s IL_006c
    IL_004f: ldloc.0
    IL_0050: callvirt Mesh UnityEngine.MeshFilter::get_mesh()  /*0x0A0004FA*/
    IL_0055: ldloc.0
    IL_0056: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005b: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0060: ldarg.0
    IL_0061: ldfld Material BuildingInteractor::previewMaterial  /*0x04000E91*/
    IL_0066: ldc.i4.0
    IL_0067: call void UnityEngine.Graphics::DrawMesh(UnityEngine.Mesh,UnityEngine.Matrix4x4,UnityEngine.Material,int)  /*0x0A0004FB*/
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0073: call int BuildingInteractor::get_CurrentUpgradePreviewBranchNumber()  /*0x06000B9F*/
    IL_0078: callvirt List<GameObject> BuildSlot::GetGameObjectsThatWillUnlockWhenUpgraded(int)  /*0x060002F1*/
    IL_007d: stfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_0082: ldc.i4.0
    IL_0083: stloc.2
    IL_0084: br IL_011b
    IL_0089: ldarg.0
    IL_008a: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_008f: ldloc.2
    IL_0090: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_0095: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_009a: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_009f: ldnull
    IL_00a0: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00a5: brfalse.s IL_00bb
    IL_00a7: ldarg.0
    IL_00a8: ldarg.0
    IL_00a9: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_00ae: ldloc.2
    IL_00af: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_00b4: call void BuildingInteractor::PreviewGameObject(UnityEngine.GameObject)  /*0x06000BC4*/
    IL_00b9: br.s IL_0117
    IL_00bb: ldarg.0
    IL_00bc: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_00c1: ldloc.2
    IL_00c2: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_00c7: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00cc: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00d1: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00d6: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_00db: brtrue.s IL_0105
    IL_00dd: ldarg.0
    IL_00de: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_00e3: ldarg.0
    IL_00e4: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_00e9: ldloc.2
    IL_00ea: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_00ef: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00f4: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00f9: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00fe: callvirt bool System.Collections.Generic.List<UnityEngine.GameObject>::Contains(!0)  /*0x0A0004FC*/
    IL_0103: brfalse.s IL_0117
    IL_0105: ldarg.0
    IL_0106: ldarg.0
    IL_0107: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_010c: ldloc.2
    IL_010d: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_0112: call void BuildingInteractor::PreviewGameObject(UnityEngine.GameObject)  /*0x06000BC4*/
    IL_0117: ldloc.2
    IL_0118: ldc.i4.1
    IL_0119: add
    IL_011a: stloc.2
    IL_011b: ldloc.2
    IL_011c: ldarg.0
    IL_011d: ldfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_0122: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0127: blt IL_0089
    IL_012c: ldc.i4.0
    IL_012d: stloc.3
    IL_012e: br.s IL_017e
    IL_0130: ldarg.0
    IL_0131: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0136: callvirt List<BuildSlot> BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  /*0x060002EC*/
    IL_013b: ldloc.3
    IL_013c: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0141: stloc.s 4
    IL_0143: ldloc.s 4
    IL_0145: callvirt bool BuildSlot::get_ActivatorUpgradesThis()  /*0x060002D0*/
    IL_014a: brfalse.s IL_017a
    IL_014c: ldloc.s 4
    IL_014e: callvirt BuildSlot BuildSlot::get_ActivatorBuilding()  /*0x060002CA*/
    IL_0153: ldarg.0
    IL_0154: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0159: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_015e: brfalse.s IL_017a
    IL_0160: ldloc.s 4
    IL_0162: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_0167: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_016c: brfalse.s IL_017a
    IL_016e: ldloc.s 4
    IL_0170: ldfld BuildingInteractor BuildSlot::buildingInteractor  /*0x040003AB*/
    IL_0175: callvirt void BuildingInteractor::PreviewSelf()  /*0x06000BC3*/
    IL_017a: ldloc.3
    IL_017b: ldc.i4.1
    IL_017c: add
    IL_017d: stloc.3
    IL_017e: ldloc.3
    IL_017f: ldarg.0
    IL_0180: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0185: callvirt List<BuildSlot> BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  /*0x060002EC*/
    IL_018a: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_018f: blt.s IL_0130
    IL_0191: ldarg.0
    IL_0192: ldfld BuildSlot BuildingInteractor::targetBuilding  /*0x04000E89*/
    IL_0197: ldarg.0
    IL_0198: ldfld List<MeshFilter> BuildingInteractor::blueprintPreviews  /*0x04000E95*/
    IL_019d: callvirt int BuildSlot::GetBlueprintPreviewsThatWillUnlockWhenUpgraded(System.Collections.Generic.List<UnityEngine.MeshFilter>)  /*0x060002F0*/
    IL_01a2: stloc.1
    IL_01a3: ldc.i4.0
    IL_01a4: stloc.s 5
    IL_01a6: br.s IL_01d9
    IL_01a8: ldarg.0
    IL_01a9: ldfld List<MeshFilter> BuildingInteractor::blueprintPreviews  /*0x04000E95*/
    IL_01ae: ldloc.s 5
    IL_01b0: callvirt !0 System.Collections.Generic.List<UnityEngine.MeshFilter>::get_Item(int)  /*0x0A0004FD*/
    IL_01b5: stloc.0
    IL_01b6: ldloc.0
    IL_01b7: callvirt Mesh UnityEngine.MeshFilter::get_mesh()  /*0x0A0004FA*/
    IL_01bc: ldloc.0
    IL_01bd: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01c2: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_01c7: ldarg.0
    IL_01c8: ldfld Material BuildingInteractor::previewMaterial  /*0x04000E91*/
    IL_01cd: ldc.i4.0
    IL_01ce: call void UnityEngine.Graphics::DrawMesh(UnityEngine.Mesh,UnityEngine.Matrix4x4,UnityEngine.Material,int)  /*0x0A0004FB*/
    IL_01d3: ldloc.s 5
    IL_01d5: ldc.i4.1
    IL_01d6: add
    IL_01d7: stloc.s 5
    IL_01d9: ldloc.s 5
    IL_01db: ldloc.1
    IL_01dc: blt.s IL_01a8
    IL_01de: ret

  .method BuildingInteractor::PreviewGameObject(UnityEngine.GameObject)  // token 0x06000BC4 rva 0x37b14 attrs Private, HideBySig
    // code size 90 (0x5a), max stack 4, init locals
    .locals ([0] List.Enumerator<MeshFilter>, [1] MeshFilter)
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: ldarg.0
    IL_0003: ldfld List<MeshFilter> BuildingInteractor::blueprintPreviews  /*0x04000E95*/
    IL_0008: callvirt void UnityEngine.GameObject::GetComponentsInChildren(bool,System.Collections.Generic.List<!!0>)<UnityEngine.MeshFilter>  /*0x2B000024*/
    IL_000d: ldarg.0
    IL_000e: ldfld List<MeshFilter> BuildingInteractor::blueprintPreviews  /*0x04000E95*/
    IL_0013: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.MeshFilter>::GetEnumerator()  /*0x0A0004FE*/
    IL_0018: stloc.0
    IL_0019: br.s IL_0040
    IL_001b: ldloca.s 0
    IL_001d: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.MeshFilter>::get_Current()  /*0x0A0004FF*/
    IL_0022: stloc.1
    IL_0023: ldloc.1
    IL_0024: callvirt Mesh UnityEngine.MeshFilter::get_mesh()  /*0x0A0004FA*/
    IL_0029: ldloc.1
    IL_002a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0034: ldarg.0
    IL_0035: ldfld Material BuildingInteractor::previewMaterial  /*0x04000E91*/
    IL_003a: ldc.i4.0
    IL_003b: call void UnityEngine.Graphics::DrawMesh(UnityEngine.Mesh,UnityEngine.Matrix4x4,UnityEngine.Material,int)  /*0x0A0004FB*/
    IL_0040: ldloca.s 0
    IL_0042: call bool System.Collections.Generic.List.Enumerator<UnityEngine.MeshFilter>::MoveNext()  /*0x0A000500*/
    IL_0047: brtrue.s IL_001b
    IL_0049: leave.s IL_0059
    IL_004b: ldloca.s 0
    IL_004d: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.MeshFilter>  /*0x1B0000DE*/
    IL_0053: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0058: endfinally
    IL_0059: ret
    .try IL_0019-IL_004b finally handler IL_004b-IL_0059

  .method BuildingInteractor::OnDestroy()  // token 0x06000BC5 rva 0x37b8c attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_000b: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0010: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0015: brfalse.s IL_0028
    IL_0017: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_001c: ldfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_0021: ldarg.0
    IL_0022: callvirt bool System.Collections.Generic.List<BuildingInteractor>::Remove(!0)  /*0x0A000501*/
    IL_0027: pop
    IL_0028: ret

  .method BuildingInteractor::OnBeforeMainLoadPass(string)  // token 0x06000BC6 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingInteractor::OnAfterMainLoadPass(string)  // token 0x06000BC7 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingInteractor::OnLoad(string)  // token 0x06000BC8 rva 0x37bb6 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "knockedOutTonight"
    IL_0006: ldarg.0
    IL_0007: ldflda bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<bool>  /*0x2B000047*/
    IL_0011: pop
    IL_0012: ldarg.0
    IL_0013: ldc.i4.1
    IL_0014: stfld bool BuildingInteractor::harvestedToday  /*0x04000E98*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: call IEnumerator BuildingInteractor::UpdateInteractionStateDelayed()  /*0x06000BCA*/
    IL_0020: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0025: pop
    IL_0026: ret

  .method BuildingInteractor::OnSave(string)  // token 0x06000BC9 rva 0x37bde attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "knockedOutTonight"
    IL_0006: ldarg.0
    IL_0007: ldfld bool BuildingInteractor::knockedOutTonight  /*0x04000E97*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,bool)  /*0x06000CF8*/
    IL_0011: ret

  .method BuildingInteractor::UpdateInteractionStateDelayed()  // token 0x06000BCA rva 0x37bf1 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildingInteractor.<UpdateInteractionStateDelayed>d__82::.ctor(int)  /*0x06000BCD*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildingInteractor BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>4__this  /*0x04000EA7*/
    IL_000d: ret

  .method BuildingInteractor::OnDuskEarly()  // token 0x06000BCB rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingInteractor::.ctor()  // token 0x06000BCC rva 0x37c00 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<IncomeModifyer>::.ctor()  /*0x0A000502*/
    IL_0006: stfld List<IncomeModifyer> BuildingInteractor::incomeModifiers  /*0x04000E93*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_0011: stfld List<GameObject> BuildingInteractor::gameObjectPreviews  /*0x04000E94*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<UnityEngine.MeshFilter>::.ctor()  /*0x0A00013D*/
    IL_001c: stfld List<MeshFilter> BuildingInteractor::blueprintPreviews  /*0x04000E95*/
    IL_0021: ldarg.0
    IL_0022: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0027: ret

// ===== BuildingInteractor/InteractionState  (token 0x02000231) =====
// ===== BuildingInteractor/<UpdateInteractionStateDelayed>d__82  (token 0x02000232) =====
  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::.ctor(int)  // token 0x06000BCD rva 0x37c29 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_000d: ret

  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::System.IDisposable.Dispose()  // token 0x06000BCE rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::MoveNext()  // token 0x06000BCF rva 0x37c38 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 97 (0x61), max stack 3, init locals
    .locals ([0] int, [1] BuildingInteractor)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildingInteractor BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>4__this  /*0x04000EA7*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>2__current  /*0x04000EA6*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>2__current  /*0x04000EA6*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>1__state  /*0x04000EA5*/
    IL_0057: ldloc.1
    IL_0058: ldc.i4.0
    IL_0059: ldc.i4.0
    IL_005a: call void BuildingInteractor::UpdateInteractionState(bool,BuildingInteractor.InteractionState)  /*0x06000BBA*/
    IL_005f: ldc.i4.0
    IL_0060: ret

  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000BD0 rva 0x37ca5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>2__current  /*0x04000EA6*/
    IL_0006: ret

  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::System.Collections.IEnumerator.Reset()  // token 0x06000BD1 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildingInteractor.<UpdateInteractionStateDelayed>d__82::System.Collections.IEnumerator.get_Current()  // token 0x06000BD2 rva 0x37ca5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingInteractor.<UpdateInteractionStateDelayed>d__82::<>2__current  /*0x04000EA6*/
    IL_0006: ret

