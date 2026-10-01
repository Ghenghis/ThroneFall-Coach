// ===== AutoUpgradeBuildingOnStart  (token 0x02000077) =====
  .method AutoUpgradeBuildingOnStart::Start()  // token 0x0600026C rva 0xaf5e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator AutoUpgradeBuildingOnStart::AutoUpgradeOnStart()  /*0x0600026D*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method AutoUpgradeBuildingOnStart::AutoUpgradeOnStart()  // token 0x0600026D rva 0xaf6d attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::.ctor(int)  /*0x0600026F*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AutoUpgradeBuildingOnStart AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>4__this  /*0x04000343*/
    IL_000d: ret

  .method AutoUpgradeBuildingOnStart::.ctor()  // token 0x0600026E rva 0xaf7c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<int>::.ctor()  /*0x0A0000F0*/
    IL_0006: stfld List<int> AutoUpgradeBuildingOnStart::upgradePaths  /*0x04000340*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== AutoUpgradeBuildingOnStart/<AutoUpgradeOnStart>d__2  (token 0x02000078) =====
  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::.ctor(int)  // token 0x0600026F rva 0xaf8f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_000d: ret

  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::System.IDisposable.Dispose()  // token 0x06000270 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::MoveNext()  // token 0x06000271 rva 0xafa0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 348 (0x15c), max stack 3, init locals
    .locals ([0] int, [1] AutoUpgradeBuildingOnStart, [2] int, [3] BuildSlot.UpgradeBranch, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AutoUpgradeBuildingOnStart AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>4__this  /*0x04000343*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_006d, IL_00e8)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_0029: ldarg.0
    IL_002a: ldloc.1
    IL_002b: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0030: stfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_0035: ldarg.0
    IL_0036: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_003b: callvirt void BuildSlot::Activate()  /*0x060002F3*/
    IL_0040: ldarg.0
    IL_0041: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_0046: ldc.i4.0
    IL_0047: callvirt void BuildSlot::set_StartDeactivated(bool)  /*0x060002CD*/
    IL_004c: ldarg.0
    IL_004d: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_0052: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0057: ldc.i4.1
    IL_0058: callvirt void BuildingInteractor::SetHarvested(bool)  /*0x06000BA3*/
    IL_005d: ldarg.0
    IL_005e: ldnull
    IL_005f: stfld object AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>2__current  /*0x04000342*/
    IL_0064: ldarg.0
    IL_0065: ldc.i4.1
    IL_0066: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_006b: ldc.i4.1
    IL_006c: ret
    IL_006d: ldarg.0
    IL_006e: ldc.i4.m1
    IL_006f: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_0074: ldarg.0
    IL_0075: ldc.i4.0
    IL_0076: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_007b: br IL_0101
    IL_0080: ldloc.1
    IL_0081: ldfld List<int> AutoUpgradeBuildingOnStart::upgradePaths  /*0x04000340*/
    IL_0086: ldarg.0
    IL_0087: ldfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_008c: callvirt !0 System.Collections.Generic.List<int>::get_Item(int)  /*0x0A0000F1*/
    IL_0091: stloc.2
    IL_0092: ldarg.0
    IL_0093: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_0098: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_009d: ldarg.0
    IL_009e: ldfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_00a3: bgt.s IL_00ef
    IL_00a5: ldarg.0
    IL_00a6: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_00ab: ldfld List<BuildSlot.Upgrade> BuildSlot::upgrades  /*0x0400039B*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_00b6: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_00bb: callvirt !0 System.Collections.Generic.List<BuildSlot.Upgrade>::get_Item(int)  /*0x0A0000F2*/
    IL_00c0: ldfld List<BuildSlot.UpgradeBranch> BuildSlot.Upgrade::upgradeBranches  /*0x040003BE*/
    IL_00c5: ldloc.2
    IL_00c6: callvirt !0 System.Collections.Generic.List<BuildSlot.UpgradeBranch>::get_Item(int)  /*0x0A0000F3*/
    IL_00cb: stloc.3
    IL_00cc: ldarg.0
    IL_00cd: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_00d2: ldloc.3
    IL_00d3: callvirt void BuildSlot::ForceManualUpgradeWithoutFeedbackEffects(BuildSlot.UpgradeBranch)  /*0x060002FA*/
    IL_00d8: ldarg.0
    IL_00d9: ldnull
    IL_00da: stfld object AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>2__current  /*0x04000342*/
    IL_00df: ldarg.0
    IL_00e0: ldc.i4.2
    IL_00e1: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_00e6: ldc.i4.1
    IL_00e7: ret
    IL_00e8: ldarg.0
    IL_00e9: ldc.i4.m1
    IL_00ea: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>1__state  /*0x04000341*/
    IL_00ef: ldarg.0
    IL_00f0: ldfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_00f5: stloc.s 4
    IL_00f7: ldarg.0
    IL_00f8: ldloc.s 4
    IL_00fa: ldc.i4.1
    IL_00fb: add
    IL_00fc: stfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_0101: ldarg.0
    IL_0102: ldfld int AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<iUpgrade>5__3  /*0x04000345*/
    IL_0107: ldloc.1
    IL_0108: ldfld List<int> AutoUpgradeBuildingOnStart::upgradePaths  /*0x04000340*/
    IL_010d: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0112: blt IL_0080
    IL_0117: ldarg.0
    IL_0118: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_011d: callvirt List<int> BuildSlot::get_AppliedUpgrades()  /*0x060002D4*/
    IL_0122: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0127: ldloc.1
    IL_0128: ldfld List<int> AutoUpgradeBuildingOnStart::upgradePaths  /*0x04000340*/
    IL_012d: callvirt int System.Collections.Generic.List<int>::get_Count()  /*0x0A0000F4*/
    IL_0132: bge.s IL_015a
    IL_0134: ldarg.0
    IL_0135: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_013a: callvirt List<int> BuildSlot::get_AppliedUpgrades()  /*0x060002D4*/
    IL_013f: callvirt void System.Collections.Generic.List<int>::Clear()  /*0x0A0000F5*/
    IL_0144: ldarg.0
    IL_0145: ldfld BuildSlot AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<bs>5__2  /*0x04000344*/
    IL_014a: callvirt List<int> BuildSlot::get_AppliedUpgrades()  /*0x060002D4*/
    IL_014f: ldloc.1
    IL_0150: ldfld List<int> AutoUpgradeBuildingOnStart::upgradePaths  /*0x04000340*/
    IL_0155: callvirt void System.Collections.Generic.List<int>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0000F6*/
    IL_015a: ldc.i4.0
    IL_015b: ret

  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000272 rva 0xb108 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>2__current  /*0x04000342*/
    IL_0006: ret

  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::System.Collections.IEnumerator.Reset()  // token 0x06000273 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::System.Collections.IEnumerator.get_Current()  // token 0x06000274 rva 0xb108 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoUpgradeBuildingOnStart.<AutoUpgradeOnStart>d__2::<>2__current  /*0x04000342*/
    IL_0006: ret

