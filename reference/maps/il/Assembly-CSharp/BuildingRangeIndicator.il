// ===== BuildingRangeIndicator  (token 0x020002D8) =====
  .method BuildingRangeIndicator::Start()  // token 0x06000FB6 rva 0x4770c attrs Public, HideBySig
    // code size 136 (0x88), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0045
    IL_000d: ldarg.0
    IL_000e: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_0013: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_0018: ldarg.0
    IL_0019: ldftn void BuildingRangeIndicator::DisplayAllTowerRange()  /*0x06000FBA*/
    IL_001f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0024: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0029: ldarg.0
    IL_002a: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_002f: ldfld UnityEvent BuildSlot::OnAfterDelayedLoadFinished  /*0x0400039E*/
    IL_0034: ldarg.0
    IL_0035: ldftn void BuildingRangeIndicator::DisplayAllTowerRange()  /*0x06000FBA*/
    IL_003b: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0040: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0045: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_004a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_004f: brfalse.s IL_006c
    IL_0051: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0056: ldfld UnityEvent SettingsManager::onDisplayTowerRangeChange  /*0x04000FF9*/
    IL_005b: ldarg.0
    IL_005c: ldftn void BuildingRangeIndicator::DisplayAllTowerRange()  /*0x06000FBA*/
    IL_0062: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0067: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_006c: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0071: ldfld UnityEvent DayNightCycle::OnTimeChange  /*0x040004C1*/
    IL_0076: ldarg.0
    IL_0077: ldftn void BuildingRangeIndicator::DisplayAllTowerRange()  /*0x06000FBA*/
    IL_007d: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0082: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0087: ret

  .method BuildingRangeIndicator::Activate()  // token 0x06000FB7 rva 0x477a0 attrs Public, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Coroutine BuildingRangeIndicator::tickRoutine  /*0x04001286*/
    IL_0006: brfalse.s IL_001b
    IL_0008: ldarg.0
    IL_0009: ldarg.0
    IL_000a: ldfld Coroutine BuildingRangeIndicator::tickRoutine  /*0x04001286*/
    IL_000f: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0014: ldarg.0
    IL_0015: ldnull
    IL_0016: stfld Coroutine BuildingRangeIndicator::tickRoutine  /*0x04001286*/
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: call IEnumerator BuildingRangeIndicator::Tick()  /*0x06000FBB*/
    IL_0023: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0028: stfld Coroutine BuildingRangeIndicator::tickRoutine  /*0x04001286*/
    IL_002d: ret

  .method BuildingRangeIndicator::OnFocus()  // token 0x06000FB8 rva 0x477cf attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BuildingRangeIndicator::focused  /*0x04001287*/
    IL_0007: ldarg.0
    IL_0008: call void BuildingRangeIndicator::DisplayAllTowerRange()  /*0x06000FBA*/
    IL_000d: ret

  .method BuildingRangeIndicator::OnUnfocus()  // token 0x06000FB9 rva 0x477de attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool BuildingRangeIndicator::focused  /*0x04001287*/
    IL_0007: ldarg.0
    IL_0008: call void BuildingRangeIndicator::Deactivate()  /*0x06000FBC*/
    IL_000d: ret

  .method BuildingRangeIndicator::DisplayAllTowerRange()  // token 0x06000FBA rva 0x477f0 attrs Public, HideBySig
    // code size 421 (0x1a5), max stack 5, init locals
    .locals ([0] float, [1] IEnumerator, [2] Transform, [3] AutoAttack, [4] PerkDestroyGameObjectModifyer, [5] PerkRangeModifyer, [6] float, [7] List.Enumerator<TargetPriority>, [8] TargetPriority, [9] IDisposable)
    IL_0000: ldc.r4 0f
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld bool BuildingRangeIndicator::focused  /*0x04001287*/
    IL_000c: brtrue.s IL_001b
    IL_000e: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0013: callvirt bool SettingsManager::get_DisplayTowerRangesOnInteract()  /*0x06000DAB*/
    IL_0018: brfalse.s IL_001b
    IL_001a: ret
    IL_001b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0020: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0025: brtrue IL_0142
    IL_002a: ldarg.0
    IL_002b: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_0030: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_0035: ldc.i4.1
    IL_0036: beq.s IL_0048
    IL_0038: ldarg.0
    IL_0039: ldfld BuildingInteractor BuildingRangeIndicator::interactor  /*0x04001284*/
    IL_003e: callvirt bool BuildingInteractor::get_Focussed()  /*0x06000BA8*/
    IL_0043: brfalse IL_0142
    IL_0048: ldarg.0
    IL_0049: ldfld Transform BuildingRangeIndicator::weaponsParent  /*0x04001282*/
    IL_004e: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0053: stloc.1
    IL_0054: br IL_0121
    IL_0059: ldloc.1
    IL_005a: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_005f: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0064: stloc.2
    IL_0065: ldloc.2
    IL_0066: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_006b: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0070: brfalse IL_0121
    IL_0075: ldloc.2
    IL_0076: callvirt !!0 UnityEngine.Component::GetComponent()<AutoAttack>  /*0x2B0000A3*/
    IL_007b: stloc.3
    IL_007c: ldloc.2
    IL_007d: callvirt !!0 UnityEngine.Component::GetComponent()<PerkDestroyGameObjectModifyer>  /*0x2B0000DA*/
    IL_0082: stloc.s 4
    IL_0084: ldloc.s 4
    IL_0086: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_008b: brfalse.s IL_0099
    IL_008d: ldloc.s 4
    IL_008f: callvirt bool PerkDestroyGameObjectModifyer::get_IsGoingToBeDestroyed()  /*0x06000B68*/
    IL_0094: brtrue IL_0121
    IL_0099: ldloc.2
    IL_009a: callvirt !!0 UnityEngine.Component::GetComponent()<PerkRangeModifyer>  /*0x2B0000DB*/
    IL_009f: stloc.s 5
    IL_00a1: ldc.r4 1f
    IL_00a6: stloc.s 6
    IL_00a8: ldloc.s 5
    IL_00aa: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00af: brfalse.s IL_00c3
    IL_00b1: ldloc.s 5
    IL_00b3: callvirt bool PerkRangeModifyer::get_IsActive()  /*0x06000B82*/
    IL_00b8: brfalse.s IL_00c3
    IL_00ba: ldloc.s 5
    IL_00bc: ldfld float PerkRangeModifyer::rangeMultiplyer  /*0x04000E5B*/
    IL_00c1: stloc.s 6
    IL_00c3: ldloc.3
    IL_00c4: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c9: brfalse.s IL_0121
    IL_00cb: ldloc.2
    IL_00cc: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00d1: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_00d6: brfalse.s IL_0121
    IL_00d8: ldloc.3
    IL_00d9: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_00de: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_00e3: stloc.s 7
    IL_00e5: br.s IL_0108
    IL_00e7: ldloca.s 7
    IL_00e9: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_00ee: stloc.s 8
    IL_00f0: ldloc.s 8
    IL_00f2: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_00f7: ldloc.s 6
    IL_00f9: mul
    IL_00fa: ldloc.0
    IL_00fb: ble.un.s IL_0108
    IL_00fd: ldloc.s 8
    IL_00ff: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0104: ldloc.s 6
    IL_0106: mul
    IL_0107: stloc.0
    IL_0108: ldloca.s 7
    IL_010a: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_010f: brtrue.s IL_00e7
    IL_0111: leave.s IL_0121
    IL_0113: ldloca.s 7
    IL_0115: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_011b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0120: endfinally
    IL_0121: ldloc.1
    IL_0122: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0127: brtrue IL_0059
    IL_012c: leave.s IL_0142
    IL_012e: ldloc.1
    IL_012f: isinst System.IDisposable  /*0x0100001B*/
    IL_0134: stloc.s 9
    IL_0136: ldloc.s 9
    IL_0138: brfalse.s IL_0141
    IL_013a: ldloc.s 9
    IL_013c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0141: endfinally
    IL_0142: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0147: callvirt bool SettingsManager::get_DisplayTowerRangesOnInteract()  /*0x06000DAB*/
    IL_014c: brfalse.s IL_0175
    IL_014e: ldloc.0
    IL_014f: ldc.r4 0f
    IL_0154: ble.un.s IL_0186
    IL_0156: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_015b: ldarg.0
    IL_015c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0161: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0166: ldloc.0
    IL_0167: ldarg.0
    IL_0168: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_016d: ldc.i4.3
    IL_016e: callvirt void RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119D*/
    IL_0173: br.s IL_0186
    IL_0175: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_017a: ldarg.0
    IL_017b: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0180: ldc.i4.3
    IL_0181: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0186: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_018b: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0190: ldc.i4.1
    IL_0191: bne.un.s IL_01a4
    IL_0193: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0198: ldarg.0
    IL_0199: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_019e: ldc.i4.3
    IL_019f: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_01a4: ret
    .try IL_00e5-IL_0113 finally handler IL_0113-IL_0121
    .try IL_0054-IL_012e finally handler IL_012e-IL_0142

  .method BuildingRangeIndicator::Tick()  // token 0x06000FBB rva 0x479c0 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void BuildingRangeIndicator.<Tick>d__11::.ctor(int)  /*0x06000FBE*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld BuildingRangeIndicator BuildingRangeIndicator.<Tick>d__11::<>4__this  /*0x0400128A*/
    IL_000d: ret

  .method BuildingRangeIndicator::Deactivate()  // token 0x06000FBC rva 0x479d0 attrs Public, HideBySig
    // code size 117 (0x75), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_000b: callvirt bool SettingsManager::get_DisplayTowerRangesOnInteract()  /*0x06000DAB*/
    IL_0010: brfalse.s IL_0023
    IL_0012: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0017: ldarg.0
    IL_0018: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001d: ldc.i4.3
    IL_001e: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0023: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0028: ldarg.0
    IL_0029: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002e: ldc.i4.0
    IL_002f: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0034: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0039: ldarg.0
    IL_003a: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_003f: ldc.i4.1
    IL_0040: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0045: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_004a: ldarg.0
    IL_004b: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0050: ldc.i4.4
    IL_0051: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0056: ldarg.0
    IL_0057: ldfld Shrine BuildingRangeIndicator::optionalShrine  /*0x04001285*/
    IL_005c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0061: brfalse.s IL_0074
    IL_0063: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0068: ldarg.0
    IL_0069: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_006e: ldc.i4.2
    IL_006f: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0074: ret

  .method BuildingRangeIndicator::.ctor()  // token 0x06000FBD rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== BuildingRangeIndicator/<Tick>d__11  (token 0x020002D9) =====
  .method BuildingRangeIndicator.<Tick>d__11::.ctor(int)  // token 0x06000FBE rva 0x47a51 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int BuildingRangeIndicator.<Tick>d__11::<>1__state  /*0x04001288*/
    IL_000d: ret

  .method BuildingRangeIndicator.<Tick>d__11::System.IDisposable.Dispose()  // token 0x06000FBF rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method BuildingRangeIndicator.<Tick>d__11::MoveNext()  // token 0x06000FC0 rva 0x47a60 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1085 (0x43d), max stack 5, init locals
    .locals ([0] int, [1] BuildingRangeIndicator, [2] bool, [3] bool, [4] float, [5] float, [6] IEnumerator, [7] Transform, [8] AutoAttack, [9] PerkDestroyGameObjectModifyer, [10] PerkRangeModifyer, [11] float, [12] List.Enumerator<TargetPriority>, [13] TargetPriority, [14] TargetPriority, [15] IDisposable, [16] List<GameObject>, [17] List.Enumerator<GameObject>, [18] GameObject, [19] AutoAttack, [20] PerkDestroyGameObjectModifyer, [21] PerkRangeModifyer, [22] float, [23] TowerUpgrade, [24] TargetPriority)
    IL_0000: ldarg.0
    IL_0001: ldfld int BuildingRangeIndicator.<Tick>d__11::<>1__state  /*0x04001288*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld BuildingRangeIndicator BuildingRangeIndicator.<Tick>d__11::<>4__this  /*0x0400128A*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_0431
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int BuildingRangeIndicator.<Tick>d__11::<>1__state  /*0x04001288*/
    IL_0021: ldc.i4.0
    IL_0022: stloc.2
    IL_0023: ldc.i4.0
    IL_0024: stloc.3
    IL_0025: ldc.r4 0f
    IL_002a: stloc.s 4
    IL_002c: ldc.r4 0f
    IL_0031: stloc.s 5
    IL_0033: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0038: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_003d: brtrue IL_033c
    IL_0042: ldloc.1
    IL_0043: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_0048: callvirt BuildSlot.BuildingState BuildSlot::get_State()  /*0x060002D9*/
    IL_004d: ldc.i4.1
    IL_004e: beq.s IL_0060
    IL_0050: ldloc.1
    IL_0051: ldfld BuildingInteractor BuildingRangeIndicator::interactor  /*0x04001284*/
    IL_0056: callvirt bool BuildingInteractor::get_Focussed()  /*0x06000BA8*/
    IL_005b: brfalse IL_033c
    IL_0060: ldloc.1
    IL_0061: ldfld Transform BuildingRangeIndicator::weaponsParent  /*0x04001282*/
    IL_0066: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_006b: stloc.s 6
    IL_006d: br IL_0199
    IL_0072: ldloc.s 6
    IL_0074: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0079: castclass UnityEngine.Transform  /*0x01000015*/
    IL_007e: stloc.s 7
    IL_0080: ldloc.s 7
    IL_0082: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0087: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_008c: brfalse IL_0199
    IL_0091: ldloc.s 7
    IL_0093: callvirt !!0 UnityEngine.Component::GetComponent()<AutoAttack>  /*0x2B0000A3*/
    IL_0098: stloc.s 8
    IL_009a: ldloc.s 7
    IL_009c: callvirt !!0 UnityEngine.Component::GetComponent()<PerkDestroyGameObjectModifyer>  /*0x2B0000DA*/
    IL_00a1: stloc.s 9
    IL_00a3: ldloc.s 9
    IL_00a5: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00aa: brfalse.s IL_00b8
    IL_00ac: ldloc.s 9
    IL_00ae: callvirt bool PerkDestroyGameObjectModifyer::get_IsGoingToBeDestroyed()  /*0x06000B68*/
    IL_00b3: brtrue IL_0199
    IL_00b8: ldloc.s 7
    IL_00ba: callvirt !!0 UnityEngine.Component::GetComponent()<PerkRangeModifyer>  /*0x2B0000DB*/
    IL_00bf: stloc.s 10
    IL_00c1: ldc.r4 1f
    IL_00c6: stloc.s 11
    IL_00c8: ldloc.s 10
    IL_00ca: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00cf: brfalse.s IL_00e3
    IL_00d1: ldloc.s 10
    IL_00d3: callvirt bool PerkRangeModifyer::get_IsActive()  /*0x06000B82*/
    IL_00d8: brfalse.s IL_00e3
    IL_00da: ldloc.s 10
    IL_00dc: ldfld float PerkRangeModifyer::rangeMultiplyer  /*0x04000E5B*/
    IL_00e1: stloc.s 11
    IL_00e3: ldloc.s 8
    IL_00e5: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00ea: brfalse IL_0199
    IL_00ef: ldloc.s 7
    IL_00f1: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f6: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_00fb: brfalse.s IL_014b
    IL_00fd: ldc.i4.1
    IL_00fe: stloc.2
    IL_00ff: ldloc.s 8
    IL_0101: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0106: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_010b: stloc.s 12
    IL_010d: br.s IL_0132
    IL_010f: ldloca.s 12
    IL_0111: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0116: stloc.s 13
    IL_0118: ldloc.s 13
    IL_011a: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_011f: ldloc.s 11
    IL_0121: mul
    IL_0122: ldloc.s 4
    IL_0124: ble.un.s IL_0132
    IL_0126: ldloc.s 13
    IL_0128: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_012d: ldloc.s 11
    IL_012f: mul
    IL_0130: stloc.s 4
    IL_0132: ldloca.s 12
    IL_0134: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0139: brtrue.s IL_010f
    IL_013b: leave.s IL_0199
    IL_013d: ldloca.s 12
    IL_013f: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0145: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_014a: endfinally
    IL_014b: ldc.i4.1
    IL_014c: stloc.3
    IL_014d: ldloc.s 8
    IL_014f: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0154: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_0159: stloc.s 12
    IL_015b: br.s IL_0180
    IL_015d: ldloca.s 12
    IL_015f: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0164: stloc.s 14
    IL_0166: ldloc.s 14
    IL_0168: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_016d: ldloc.s 11
    IL_016f: mul
    IL_0170: ldloc.s 5
    IL_0172: ble.un.s IL_0180
    IL_0174: ldloc.s 14
    IL_0176: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_017b: ldloc.s 11
    IL_017d: mul
    IL_017e: stloc.s 5
    IL_0180: ldloca.s 12
    IL_0182: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0187: brtrue.s IL_015d
    IL_0189: leave.s IL_0199
    IL_018b: ldloca.s 12
    IL_018d: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0193: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0198: endfinally
    IL_0199: ldloc.s 6
    IL_019b: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_01a0: brtrue IL_0072
    IL_01a5: leave.s IL_01bc
    IL_01a7: ldloc.s 6
    IL_01a9: isinst System.IDisposable  /*0x0100001B*/
    IL_01ae: stloc.s 15
    IL_01b0: ldloc.s 15
    IL_01b2: brfalse.s IL_01bb
    IL_01b4: ldloc.s 15
    IL_01b6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01bb: endfinally
    IL_01bc: ldloc.1
    IL_01bd: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_01c2: callvirt bool BuildSlot::get_CanBeUpgraded()  /*0x060002DE*/
    IL_01c7: brfalse IL_02e7
    IL_01cc: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_01d1: ldloc.1
    IL_01d2: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_01d7: call int BuildingInteractor::get_CurrentUpgradePreviewBranchNumber()  /*0x06000B9F*/
    IL_01dc: callvirt List<GameObject> BuildSlot::GetGameObjectsThatWillUnlockWhenUpgraded(int)  /*0x060002F1*/
    IL_01e1: stloc.s 16
    IL_01e3: dup
    IL_01e4: ldloc.s 16
    IL_01e6: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00060C*/
    IL_01eb: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_01f0: stloc.s 17
    IL_01f2: br IL_02cb
    IL_01f7: ldloca.s 17
    IL_01f9: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_01fe: stloc.s 18
    IL_0200: ldloc.s 18
    IL_0202: callvirt !!0 UnityEngine.GameObject::GetComponent()<AutoAttack>  /*0x2B00005C*/
    IL_0207: stloc.s 19
    IL_0209: ldloc.s 18
    IL_020b: callvirt !!0 UnityEngine.GameObject::GetComponent()<PerkDestroyGameObjectModifyer>  /*0x2B0000DC*/
    IL_0210: stloc.s 20
    IL_0212: ldloc.s 20
    IL_0214: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0219: brfalse.s IL_0227
    IL_021b: ldloc.s 20
    IL_021d: callvirt bool PerkDestroyGameObjectModifyer::get_IsGoingToBeDestroyed()  /*0x06000B68*/
    IL_0222: brtrue IL_02cb
    IL_0227: ldloc.s 18
    IL_0229: callvirt !!0 UnityEngine.GameObject::GetComponent()<PerkRangeModifyer>  /*0x2B0000DD*/
    IL_022e: stloc.s 21
    IL_0230: ldc.r4 1f
    IL_0235: stloc.s 22
    IL_0237: ldloc.s 21
    IL_0239: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_023e: brfalse.s IL_0252
    IL_0240: ldloc.s 21
    IL_0242: callvirt bool PerkRangeModifyer::get_IsActive()  /*0x06000B82*/
    IL_0247: brfalse.s IL_0252
    IL_0249: ldloc.s 21
    IL_024b: ldfld float PerkRangeModifyer::rangeMultiplyer  /*0x04000E5B*/
    IL_0250: stloc.s 22
    IL_0252: ldloc.s 19
    IL_0254: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0259: brfalse.s IL_02a9
    IL_025b: ldc.i4.1
    IL_025c: stloc.3
    IL_025d: ldloc.s 19
    IL_025f: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0264: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_0269: stloc.s 12
    IL_026b: br.s IL_0290
    IL_026d: ldloca.s 12
    IL_026f: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0274: stloc.s 24
    IL_0276: ldloc.s 24
    IL_0278: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_027d: ldloc.s 22
    IL_027f: mul
    IL_0280: ldloc.s 5
    IL_0282: ble.un.s IL_0290
    IL_0284: ldloc.s 24
    IL_0286: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_028b: ldloc.s 22
    IL_028d: mul
    IL_028e: stloc.s 5
    IL_0290: ldloca.s 12
    IL_0292: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0297: brtrue.s IL_026d
    IL_0299: leave.s IL_02a9
    IL_029b: ldloca.s 12
    IL_029d: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_02a3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02a8: endfinally
    IL_02a9: ldloc.s 18
    IL_02ab: callvirt !!0 UnityEngine.GameObject::GetComponent()<TowerUpgrade>  /*0x2B0000DE*/
    IL_02b0: stloc.s 23
    IL_02b2: ldloc.s 23
    IL_02b4: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_02b9: brfalse.s IL_02cb
    IL_02bb: ldc.i4.1
    IL_02bc: stloc.3
    IL_02bd: ldloc.s 5
    IL_02bf: ldloc.s 23
    IL_02c1: callvirt float TowerUpgrade::get_RangeMulti()  /*0x06000F16*/
    IL_02c6: mul
    IL_02c7: stloc.s 5
    IL_02c9: leave.s IL_02e7
    IL_02cb: ldloca.s 17
    IL_02cd: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_02d2: brtrue IL_01f7
    IL_02d7: leave.s IL_02e7
    IL_02d9: ldloca.s 17
    IL_02db: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_02e1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02e6: endfinally
    IL_02e7: ldloc.1
    IL_02e8: ldfld Shrine BuildingRangeIndicator::optionalShrine  /*0x04001285*/
    IL_02ed: ldnull
    IL_02ee: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_02f3: brfalse.s IL_033c
    IL_02f5: ldloc.1
    IL_02f6: ldfld Shrine BuildingRangeIndicator::optionalShrine  /*0x04001285*/
    IL_02fb: callvirt bool Shrine::get_ShrineHasBeenActivated()  /*0x06000E14*/
    IL_0300: brtrue.s IL_032b
    IL_0302: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0307: ldloc.1
    IL_0308: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_030d: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0312: ldloc.1
    IL_0313: ldfld Shrine BuildingRangeIndicator::optionalShrine  /*0x04001285*/
    IL_0318: callvirt float Shrine::get_CollectionRange()  /*0x06000E10*/
    IL_031d: ldloc.1
    IL_031e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0323: ldc.i4.2
    IL_0324: callvirt void RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119D*/
    IL_0329: br.s IL_033c
    IL_032b: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0330: ldloc.1
    IL_0331: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0336: ldc.i4.2
    IL_0337: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_033c: ldloc.2
    IL_033d: brfalse.s IL_035f
    IL_033f: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0344: ldloc.1
    IL_0345: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_034a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_034f: ldloc.s 4
    IL_0351: ldloc.1
    IL_0352: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0357: ldc.i4.0
    IL_0358: callvirt void RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119D*/
    IL_035d: br.s IL_0370
    IL_035f: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0364: ldloc.1
    IL_0365: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_036a: ldc.i4.0
    IL_036b: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0370: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0375: callvirt bool SettingsManager::get_DisplayTowerRangesOnInteract()  /*0x06000DAB*/
    IL_037a: brtrue.s IL_03ce
    IL_037c: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0381: ldloc.1
    IL_0382: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0387: ldc.i4.4
    IL_0388: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_038d: ldloc.3
    IL_038e: brfalse.s IL_03bb
    IL_0390: ldloc.s 4
    IL_0392: ldloc.s 5
    IL_0394: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_0399: brtrue.s IL_03bb
    IL_039b: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_03a0: ldloc.1
    IL_03a1: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03a6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_03ab: ldloc.s 5
    IL_03ad: ldloc.1
    IL_03ae: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_03b3: ldc.i4.1
    IL_03b4: callvirt void RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119D*/
    IL_03b9: br.s IL_0421
    IL_03bb: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_03c0: ldloc.1
    IL_03c1: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_03c6: ldc.i4.1
    IL_03c7: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_03cc: br.s IL_0421
    IL_03ce: call bool BuildingInteractor::get_IsChoosingUpgrade()  /*0x06000BA0*/
    IL_03d3: brtrue.s IL_03e2
    IL_03d5: ldloc.1
    IL_03d6: ldfld BuildSlot BuildingRangeIndicator::buildSlot  /*0x04001283*/
    IL_03db: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_03e0: brtrue.s IL_0410
    IL_03e2: ldloc.3
    IL_03e3: brfalse.s IL_0410
    IL_03e5: ldloc.s 4
    IL_03e7: ldloc.s 5
    IL_03e9: call bool UnityEngine.Mathf::Approximately(float,float)  /*0x0A0000F9*/
    IL_03ee: brtrue.s IL_0410
    IL_03f0: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_03f5: ldloc.1
    IL_03f6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_03fb: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0400: ldloc.s 5
    IL_0402: ldloc.1
    IL_0403: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0408: ldc.i4.4
    IL_0409: callvirt void RangeIndicatorHandler::ShowIndicator(UnityEngine.Vector3,float,UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119D*/
    IL_040e: br.s IL_0421
    IL_0410: ldsfld RangeIndicatorHandler RangeIndicatorHandler::instance  /*0x04001541*/
    IL_0415: ldloc.1
    IL_0416: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_041b: ldc.i4.4
    IL_041c: callvirt void RangeIndicatorHandler::HideIndicator(UnityEngine.GameObject,RangeIndicatorHandler.IndicatorType)  /*0x0600119E*/
    IL_0421: ldarg.0
    IL_0422: ldnull
    IL_0423: stfld object BuildingRangeIndicator.<Tick>d__11::<>2__current  /*0x04001289*/
    IL_0428: ldarg.0
    IL_0429: ldc.i4.1
    IL_042a: stfld int BuildingRangeIndicator.<Tick>d__11::<>1__state  /*0x04001288*/
    IL_042f: ldc.i4.1
    IL_0430: ret
    IL_0431: ldarg.0
    IL_0432: ldc.i4.m1
    IL_0433: stfld int BuildingRangeIndicator.<Tick>d__11::<>1__state  /*0x04001288*/
    IL_0438: br IL_0021
    .try IL_010d-IL_013d finally handler IL_013d-IL_014b
    .try IL_015b-IL_018b finally handler IL_018b-IL_0199
    .try IL_006d-IL_01a7 finally handler IL_01a7-IL_01bc
    .try IL_026b-IL_029b finally handler IL_029b-IL_02a9
    .try IL_01f2-IL_02d9 finally handler IL_02d9-IL_02e7

  .method BuildingRangeIndicator.<Tick>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000FC1 rva 0x47f28 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingRangeIndicator.<Tick>d__11::<>2__current  /*0x04001289*/
    IL_0006: ret

  .method BuildingRangeIndicator.<Tick>d__11::System.Collections.IEnumerator.Reset()  // token 0x06000FC2 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method BuildingRangeIndicator.<Tick>d__11::System.Collections.IEnumerator.get_Current()  // token 0x06000FC3 rva 0x47f28 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object BuildingRangeIndicator.<Tick>d__11::<>2__current  /*0x04001289*/
    IL_0006: ret

