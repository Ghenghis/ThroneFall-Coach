// ===== FishingHarbour  (token 0x02000167) =====
  .method FishingHarbour::Start()  // token 0x06000751 rva 0x24db0 attrs Private, HideBySig
    // code size 213 (0xd5), max stack 3, init locals
    .locals ([0] int, [1] List.Enumerator<BuildSlot.UpgradeBranch>)
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0006: callvirt List<IncomeModifyer> BuildingInteractor::get_IncomeModifiers()  /*0x06000BA1*/
    IL_000b: ldarg.0
    IL_000c: callvirt void System.Collections.Generic.List<IncomeModifyer>::Add(!0)  /*0x0A000363*/
    IL_0011: ldc.i4.0
    IL_0012: stloc.0
    IL_0013: br.s IL_0030
    IL_0015: ldarg.0
    IL_0016: ldfld Transform FishingHarbour::activeChildOnIncomeIncrease  /*0x0400093F*/
    IL_001b: ldloc.0
    IL_001c: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0021: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ldloc.0
    IL_002d: ldc.i4.1
    IL_002e: add
    IL_002f: stloc.0
    IL_0030: ldloc.0
    IL_0031: ldarg.0
    IL_0032: ldfld Transform FishingHarbour::activeChildOnIncomeIncrease  /*0x0400093F*/
    IL_0037: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_003c: blt.s IL_0015
    IL_003e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0043: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_0048: ldarg.0
    IL_0049: ldfld Equippable FishingHarbour::perk  /*0x04000942*/
    IL_004e: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0053: brfalse.s IL_00c8
    IL_0055: ldarg.0
    IL_0056: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_005b: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_0060: ldc.i4.0
    IL_0061: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_0066: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_006b: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot.UpgradeBranch>::GetEnumerator()  /*0x0A000121*/
    IL_0070: stloc.1
    IL_0071: br.s IL_0095
    IL_0073: ldloca.s 1
    IL_0075: call !0 System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::get_Current()  /*0x0A000122*/
    IL_007a: ldfld List<GameObject> BuildSlot.UpgradeBranch::objectsToActivate  /*0x040003C4*/
    IL_007f: ldarg.0
    IL_0080: ldfld Transform FishingHarbour::activeChildOnIncomeIncrease  /*0x0400093F*/
    IL_0085: ldc.i4.0
    IL_0086: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_008b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0090: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0095: ldloca.s 1
    IL_0097: call bool System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>::MoveNext()  /*0x0A000125*/
    IL_009c: brtrue.s IL_0073
    IL_009e: leave.s IL_00ae
    IL_00a0: ldloca.s 1
    IL_00a2: constrained. System.Collections.Generic.List.Enumerator<BuildSlot.UpgradeBranch>  /*0x1B000022*/
    IL_00a8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ad: endfinally
    IL_00ae: ldarg.0
    IL_00af: ldarg.0
    IL_00b0: ldfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld int FishingHarbour::additionalBoatCapacity  /*0x04000943*/
    IL_00bb: add
    IL_00bc: stfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_00c1: ldarg.0
    IL_00c2: ldc.i4.1
    IL_00c3: stfld int FishingHarbour::activationNr  /*0x04000940*/
    IL_00c8: ldarg.0
    IL_00c9: ldarg.0
    IL_00ca: ldfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_00cf: stfld int FishingHarbour::maximumBoats  /*0x0400093E*/
    IL_00d4: ret
    .try IL_0071-IL_00a0 finally handler IL_00a0-IL_00ae

  .method FishingHarbour::OnDawn()  // token 0x06000752 rva 0x24ea4 attrs Public, Virtual, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.0
    IL_000c: bgt.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0015: callvirt bool BuildingInteractor::get_KnockedOutTonight()  /*0x06000BA2*/
    IL_001a: brfalse.s IL_001d
    IL_001c: ret
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: call IEnumerator FishingHarbour::IncreaseIncomeAndBuildShip()  /*0x06000753*/
    IL_0024: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0029: pop
    IL_002a: ret

  .method FishingHarbour::IncreaseIncomeAndBuildShip()  // token 0x06000753 rva 0x24ed0 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::.ctor(int)  /*0x06000760*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld FishingHarbour FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>4__this  /*0x0400094B*/
    IL_000d: ret

  .method FishingHarbour::BatchBuildShipsOnLoad(int)  // token 0x06000754 rva 0x24edf attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void FishingHarbour.<BatchBuildShipsOnLoad>d__11::.ctor(int)  /*0x0600075A*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld FishingHarbour FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>4__this  /*0x04000946*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::amount  /*0x04000947*/
    IL_0014: ret

  .method FishingHarbour::OnBeforeMainLoadPass(string)  // token 0x06000755 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FishingHarbour::OnAfterMainLoadPass(string)  // token 0x06000756 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FishingHarbour::OnLoad(string)  // token 0x06000757 rva 0x24ef8 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 35 (0x23), max stack 3, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldarg.1
    IL_0003: ldstr "shipsBuilt"
    IL_0008: ldloca.s 0
    IL_000a: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_000f: pop
    IL_0010: ldloc.0
    IL_0011: ldc.i4.0
    IL_0012: ble.s IL_0022
    IL_0014: ldarg.0
    IL_0015: ldarg.0
    IL_0016: ldloc.0
    IL_0017: call IEnumerator FishingHarbour::BatchBuildShipsOnLoad(int)  /*0x06000754*/
    IL_001c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0021: pop
    IL_0022: ret

  .method FishingHarbour::OnSave(string)  // token 0x06000758 rva 0x24f27 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "shipsBuilt"
    IL_0006: ldarg.0
    IL_0007: ldfld int FishingHarbour::shipsBuilt  /*0x04000941*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ret

  .method FishingHarbour::.ctor()  // token 0x06000759 rva 0x24f3a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int FishingHarbour::incomeIncreasePerTurn  /*0x0400093C*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.5
    IL_0009: stfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_000e: ldarg.0
    IL_000f: call void IncomeModifyer::.ctor()  /*0x0600083B*/
    IL_0014: ret

// ===== FishingHarbour/<BatchBuildShipsOnLoad>d__11  (token 0x02000168) =====
  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::.ctor(int)  // token 0x0600075A rva 0x24f50 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>1__state  /*0x04000944*/
    IL_000d: ret

  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::System.IDisposable.Dispose()  // token 0x0600075B rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::MoveNext()  // token 0x0600075C rva 0x24f60 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 105 (0x69), max stack 3, init locals
    .locals ([0] int, [1] FishingHarbour, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>1__state  /*0x04000944*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld FishingHarbour FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>4__this  /*0x04000946*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0042
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>1__state  /*0x04000944*/
    IL_001e: ldarg.0
    IL_001f: ldc.i4.0
    IL_0020: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<i>5__2  /*0x04000948*/
    IL_0025: br.s IL_0059
    IL_0027: ldarg.0
    IL_0028: ldloc.1
    IL_0029: ldloc.1
    IL_002a: call IEnumerator FishingHarbour::IncreaseIncomeAndBuildShip()  /*0x06000753*/
    IL_002f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0034: stfld object FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>2__current  /*0x04000945*/
    IL_0039: ldarg.0
    IL_003a: ldc.i4.1
    IL_003b: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>1__state  /*0x04000944*/
    IL_0040: ldc.i4.1
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldc.i4.m1
    IL_0044: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>1__state  /*0x04000944*/
    IL_0049: ldarg.0
    IL_004a: ldfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<i>5__2  /*0x04000948*/
    IL_004f: stloc.2
    IL_0050: ldarg.0
    IL_0051: ldloc.2
    IL_0052: ldc.i4.1
    IL_0053: add
    IL_0054: stfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<i>5__2  /*0x04000948*/
    IL_0059: ldarg.0
    IL_005a: ldfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::<i>5__2  /*0x04000948*/
    IL_005f: ldarg.0
    IL_0060: ldfld int FishingHarbour.<BatchBuildShipsOnLoad>d__11::amount  /*0x04000947*/
    IL_0065: blt.s IL_0027
    IL_0067: ldc.i4.0
    IL_0068: ret

  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600075D rva 0x24fd5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>2__current  /*0x04000945*/
    IL_0006: ret

  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::System.Collections.IEnumerator.Reset()  // token 0x0600075E rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method FishingHarbour.<BatchBuildShipsOnLoad>d__11::System.Collections.IEnumerator.get_Current()  // token 0x0600075F rva 0x24fd5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FishingHarbour.<BatchBuildShipsOnLoad>d__11::<>2__current  /*0x04000945*/
    IL_0006: ret

// ===== FishingHarbour/<IncreaseIncomeAndBuildShip>d__10  (token 0x02000169) =====
  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::.ctor(int)  // token 0x06000760 rva 0x24fdd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_000d: ret

  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::System.IDisposable.Dispose()  // token 0x06000761 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::MoveNext()  // token 0x06000762 rva 0x24fec attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 259 (0x103), max stack 3, init locals
    .locals ([0] int, [1] FishingHarbour)
    IL_0000: ldarg.0
    IL_0001: ldfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld FishingHarbour FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>4__this  /*0x0400094B*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>2__current  /*0x0400094A*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>2__current  /*0x0400094A*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>1__state  /*0x04000949*/
    IL_0057: ldloc.1
    IL_0058: ldfld int FishingHarbour::activationNr  /*0x04000940*/
    IL_005d: ldloc.1
    IL_005e: ldfld int FishingHarbour::maximumBoats  /*0x0400093E*/
    IL_0063: bge.s IL_0081
    IL_0065: ldloc.1
    IL_0066: ldfld Transform FishingHarbour::activeChildOnIncomeIncrease  /*0x0400093F*/
    IL_006b: ldloc.1
    IL_006c: ldfld int FishingHarbour::activationNr  /*0x04000940*/
    IL_0071: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0076: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_007b: ldc.i4.1
    IL_007c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0081: ldloc.1
    IL_0082: ldloc.1
    IL_0083: ldfld int FishingHarbour::activationNr  /*0x04000940*/
    IL_0088: ldc.i4.1
    IL_0089: add
    IL_008a: stfld int FishingHarbour::activationNr  /*0x04000940*/
    IL_008f: ldloc.1
    IL_0090: ldloc.1
    IL_0091: ldfld int FishingHarbour::shipsBuilt  /*0x04000941*/
    IL_0096: ldc.i4.1
    IL_0097: add
    IL_0098: stfld int FishingHarbour::shipsBuilt  /*0x04000941*/
    IL_009d: ldloc.1
    IL_009e: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_00a3: ldloc.1
    IL_00a4: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_00a9: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_00ae: ldloc.1
    IL_00af: ldfld int FishingHarbour::incomeIncreasePerTurn  /*0x0400093C*/
    IL_00b4: add
    IL_00b5: ldloc.1
    IL_00b6: ldfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_00bb: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_00c0: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_00c5: ldloc.1
    IL_00c6: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_00cb: callvirt List<BuildSlot.Upgrade> BuildSlot::get_Upgrades()  /*0x060002D1*/
    IL_00d0: ldc.i4.1
    IL_00d1: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00d6: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_00db: ldc.i4.0
    IL_00dc: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_00e1: ldloc.1
    IL_00e2: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_00e7: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_00ec: stfld int BuildSlot.UpgradeBranch::goldIncomeChange  /*0x040003C1*/
    IL_00f1: ldloc.1
    IL_00f2: ldfld BuildSlot IncomeModifyer::buildSlot  /*0x04000A56*/
    IL_00f7: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_00fc: callvirt void BuildingInteractor::MarkAsHarvested()  /*0x06000BA4*/
    IL_0101: ldc.i4.0
    IL_0102: ret

  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000763 rva 0x250fb attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>2__current  /*0x0400094A*/
    IL_0006: ret

  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::System.Collections.IEnumerator.Reset()  // token 0x06000764 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::System.Collections.IEnumerator.get_Current()  // token 0x06000765 rva 0x250fb attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object FishingHarbour.<IncreaseIncomeAndBuildShip>d__10::<>2__current  /*0x0400094A*/
    IL_0006: ret

