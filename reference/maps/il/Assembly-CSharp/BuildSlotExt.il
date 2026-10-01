// ===== BuildSlotExt  (token 0x020000F0) =====
  .method BuildSlotExt::Start()  // token 0x06000515 rva 0x16510 attrs Family, Virtual, HideBySig
    // code size 162 (0xa2), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call void BuildSlot::Start()  /*0x060002F2*/
    IL_0006: ldarg.0
    IL_0007: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_000c: ldnull
    IL_000d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0012: brfalse.s IL_001f
    IL_0014: ldstr "BuildSlotExt requires Interactor to be set"
    IL_0019: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0025: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_002a: ldnull
    IL_002b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0030: brfalse.s IL_003d
    IL_0032: ldstr "BuildSlotExt requires Interactor.costDisplay to be not null"
    IL_0037: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_003c: ret
    IL_003d: ldarg.0
    IL_003e: ldfld Coin BuildSlotExt::coinDefault  /*0x0400069D*/
    IL_0043: ldnull
    IL_0044: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0049: brfalse.s IL_0056
    IL_004b: ldstr "BuildSlotExt class requires coinDefault to be set"
    IL_0050: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0055: ret
    IL_0056: ldarg.0
    IL_0057: ldfld Coinslot BuildSlotExt::coinslotDefault  /*0x0400069E*/
    IL_005c: ldnull
    IL_005d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0062: brfalse.s IL_006f
    IL_0064: ldstr "BuildSlotExt class requires coinslotDefault to be set"
    IL_0069: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_006e: ret
    IL_006f: ldarg.0
    IL_0070: ldfld Coin BuildSlotExt::coinEnergyCore  /*0x0400069F*/
    IL_0075: ldnull
    IL_0076: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_007b: brfalse.s IL_0088
    IL_007d: ldstr "BuildSlotExt class requires coinEnergyCore to be set"
    IL_0082: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0087: ret
    IL_0088: ldarg.0
    IL_0089: ldfld Coinslot BuildSlotExt::coinslotEnergyCore  /*0x040006A0*/
    IL_008e: ldnull
    IL_008f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0094: brfalse.s IL_00a1
    IL_0096: ldstr "BuildSlotExt class requires coinslotEnergyCore to be set"
    IL_009b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_00a0: ret
    IL_00a1: ret

  .method BuildSlotExt::OnUpgradeChoiceComplete(Choice)  // token 0x06000516 rva 0x165c0 attrs Public, Virtual, HideBySig
    // code size 209 (0xd1), max stack 3, init locals
    .locals ([0] bool)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void BuildSlot::OnUpgradeChoiceComplete(Choice)  /*0x060002F9*/
    IL_0007: ldarg.0
    IL_0008: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_000d: brfalse IL_00d0
    IL_0012: ldarg.0
    IL_0013: call int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0018: ldc.i4.0
    IL_0019: ble IL_00d0
    IL_001e: ldarg.0
    IL_001f: call int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0024: pop
    IL_0025: ldarg.0
    IL_0026: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_002b: ldarg.0
    IL_002c: call int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0031: ldc.i4.1
    IL_0032: sub
    IL_0033: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0038: ldfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_003d: ldc.i4.0
    IL_003e: cgt
    IL_0040: ldarg.0
    IL_0041: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_0046: ldarg.0
    IL_0047: call int BuildSlot::get_Level()  /*0x060002D3*/
    IL_004c: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0051: ldfld int BuildSlot.Upgrade::energyCoreCost  /*0x040003BC*/
    IL_0056: ldc.i4.0
    IL_0057: cgt
    IL_0059: stloc.0
    IL_005a: ldloc.0
    IL_005b: bne.un.s IL_005e
    IL_005d: ret
    IL_005e: ldarg.0
    IL_005f: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0064: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0069: callvirt void CostDisplay::SetClearCoinPoolFlag()  /*0x06001015*/
    IL_006e: ldarg.0
    IL_006f: call int BuildSlot::get_NextUpgradeOrBuildEnergyCoreCost()  /*0x060002E8*/
    IL_0074: ldc.i4.0
    IL_0075: ble.s IL_00a4
    IL_0077: ldarg.0
    IL_0078: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_007d: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0082: ldarg.0
    IL_0083: ldfld Coin BuildSlotExt::coinEnergyCore  /*0x0400069F*/
    IL_0088: stfld Coin CostDisplay::coinPrefab  /*0x040012EA*/
    IL_008d: ldarg.0
    IL_008e: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0093: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_0098: ldarg.0
    IL_0099: ldfld Coinslot BuildSlotExt::coinslotEnergyCore  /*0x040006A0*/
    IL_009e: stfld Coinslot CostDisplay::coinslotPrefab  /*0x040012E9*/
    IL_00a3: ret
    IL_00a4: ldarg.0
    IL_00a5: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_00aa: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_00af: ldarg.0
    IL_00b0: ldfld Coin BuildSlotExt::coinDefault  /*0x0400069D*/
    IL_00b5: stfld Coin CostDisplay::coinPrefab  /*0x040012EA*/
    IL_00ba: ldarg.0
    IL_00bb: call BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_00c0: ldfld CostDisplay BuildingInteractor::costDisplay  /*0x04000E90*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld Coinslot BuildSlotExt::coinslotDefault  /*0x0400069E*/
    IL_00cb: stfld Coinslot CostDisplay::coinslotPrefab  /*0x040012E9*/
    IL_00d0: ret

  .method BuildSlotExt::get_CanBeUpgraded()  // token 0x06000517 rva 0x1669d attrs Public, Virtual, HideBySig, SpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: call int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0006: ldarg.0
    IL_0007: ldfld int BuildSlotExt::maxLevel  /*0x0400069C*/
    IL_000c: ldc.i4.1
    IL_000d: add
    IL_000e: blt.s IL_0012
    IL_0010: ldc.i4.0
    IL_0011: ret
    IL_0012: ldarg.0
    IL_0013: call bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_0018: ret

  .method BuildSlotExt::.ctor()  // token 0x06000518 rva 0x166b7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void BuildSlot::.ctor()  /*0x06000302*/
    IL_0006: ret

