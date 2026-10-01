// ===== PauseUILoadoutHelper  (token 0x0200032D) =====
  .method PauseUILoadoutHelper::OnEnable()  // token 0x0600117B rva 0x53060 attrs Private, HideBySig
    // code size 84 (0x54), max stack 3, init locals
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0016
    IL_000d: ldarg.0
    IL_000e: ldc.i4.1
    IL_000f: stfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0014: br.s IL_0047
    IL_0016: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_001b: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0020: ldc.i4.1
    IL_0021: bne.un.s IL_0035
    IL_0023: ldarg.0
    IL_0024: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0029: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_002e: stfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0033: br.s IL_0047
    IL_0035: ldarg.0
    IL_0036: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_003b: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0040: ldc.i4.1
    IL_0041: add
    IL_0042: stfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_004e: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0053: ret

  .method PauseUILoadoutHelper::CycleNightPreview(int)  // token 0x0600117C rva 0x530c0 attrs Public, HideBySig
    // code size 81 (0x51), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0007: ldarg.1
    IL_0008: add
    IL_0009: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_000e: ldarg.0
    IL_000f: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0014: ldc.i4.0
    IL_0015: bge.s IL_001e
    IL_0017: ldarg.0
    IL_0018: ldc.i4.0
    IL_0019: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_001e: ldarg.0
    IL_001f: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0024: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0029: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_002e: ldc.i4.1
    IL_002f: sub
    IL_0030: ble.s IL_0044
    IL_0032: ldarg.0
    IL_0033: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0038: callvirt int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_003d: ldc.i4.1
    IL_003e: sub
    IL_003f: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0044: ldarg.0
    IL_0045: call void PauseUILoadoutHelper::RefreshOnlyEnemyPreview()  /*0x06001180*/
    IL_004a: ldarg.0
    IL_004b: call void PauseUILoadoutHelper::AssignNavigationTargets()  /*0x06001185*/
    IL_0050: ret

  .method PauseUILoadoutHelper::OnFrameSelectionChange()  // token 0x0600117D rva 0x53120 attrs Public, HideBySig
    // code size 87 (0x57), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0006: ldarg.0
    IL_0007: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_000c: beq.s IL_0056
    IL_000e: ldarg.0
    IL_000f: ldfld UIFrame PauseUILoadoutHelper::frame  /*0x040014F3*/
    IL_0014: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0019: ldarg.0
    IL_001a: ldfld ThronefallUIElement PauseUILoadoutHelper::nightButton  /*0x040014F6*/
    IL_001f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0024: brfalse.s IL_0056
    IL_0026: ldarg.0
    IL_0027: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_002c: ldarg.0
    IL_002d: ldfld UIFrame PauseUILoadoutHelper::frame  /*0x040014F3*/
    IL_0032: callvirt ThronefallUIElement UIFrame::get_CurrentSelection()  /*0x060012E6*/
    IL_0037: callvirt bool System.Collections.Generic.List<ThronefallUIElement>::Contains(!0)  /*0x0A0006F2*/
    IL_003c: brtrue.s IL_0056
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0045: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_004a: ldarg.0
    IL_004b: call void PauseUILoadoutHelper::RefreshOnlyEnemyPreview()  /*0x06001180*/
    IL_0050: ldarg.0
    IL_0051: call void PauseUILoadoutHelper::AssignNavigationTargets()  /*0x06001185*/
    IL_0056: ret

  .method PauseUILoadoutHelper::Refresh()  // token 0x0600117E rva 0x53184 attrs Public, HideBySig
    // code size 414 (0x19e), max stack 3, init locals
    .locals ([0] List<Equippable>, [1] List<Equippable>, [2] List<Equippable>, [3] IEnumerator, [4] IDisposable, [5] List.Enumerator<Equippable>, [6] Equippable, [7] Equippable, [8] Equippable, [9] Equippable)
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: callvirt SceneTransitionManager.SceneState SceneTransitionManager::get_CurrentSceneState()  /*0x060009BC*/
    IL_000a: ldc.i4.2
    IL_000b: beq.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_0014: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Clear()  /*0x0A0006F3*/
    IL_0019: ldarg.0
    IL_001a: ldfld GridLayoutGroup PauseUILoadoutHelper::loadoutGroup  /*0x040014FC*/
    IL_001f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0024: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0029: stloc.3
    IL_002a: br.s IL_0041
    IL_002c: ldloc.3
    IL_002d: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0032: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0037: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_003c: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0041: ldloc.3
    IL_0042: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0047: brtrue.s IL_002c
    IL_0049: leave.s IL_005f
    IL_004b: ldloc.3
    IL_004c: isinst System.IDisposable  /*0x0100001B*/
    IL_0051: stloc.s 4
    IL_0053: ldloc.s 4
    IL_0055: brfalse.s IL_005e
    IL_0057: ldloc.s 4
    IL_0059: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005e: endfinally
    IL_005f: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0064: stloc.0
    IL_0065: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_006a: stloc.1
    IL_006b: newobj void System.Collections.Generic.List<Equippable>::.ctor()  /*0x0A0003D9*/
    IL_0070: stloc.2
    IL_0071: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0076: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_007b: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0080: stloc.s 5
    IL_0082: br.s IL_00c4
    IL_0084: ldloca.s 5
    IL_0086: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_008b: stloc.s 6
    IL_008d: ldloc.s 6
    IL_008f: isinst EquippableWeapon  /*0x0200021B*/
    IL_0094: brfalse.s IL_00a0
    IL_0096: ldloc.0
    IL_0097: ldloc.s 6
    IL_0099: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_009e: br.s IL_00c4
    IL_00a0: ldloc.s 6
    IL_00a2: isinst EquippablePerk  /*0x0200021A*/
    IL_00a7: brfalse.s IL_00b3
    IL_00a9: ldloc.1
    IL_00aa: ldloc.s 6
    IL_00ac: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_00b1: br.s IL_00c4
    IL_00b3: ldloc.s 6
    IL_00b5: isinst EquippableMutation  /*0x02000219*/
    IL_00ba: brfalse.s IL_00c4
    IL_00bc: ldloc.2
    IL_00bd: ldloc.s 6
    IL_00bf: callvirt void System.Collections.Generic.List<Equippable>::Add(!0)  /*0x0A0003D0*/
    IL_00c4: ldloca.s 5
    IL_00c6: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_00cb: brtrue.s IL_0084
    IL_00cd: leave.s IL_00dd
    IL_00cf: ldloca.s 5
    IL_00d1: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_00d7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00dc: endfinally
    IL_00dd: ldloc.0
    IL_00de: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_00e3: stloc.s 5
    IL_00e5: br.s IL_00fe
    IL_00e7: ldloca.s 5
    IL_00e9: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_00ee: stloc.s 7
    IL_00f0: ldarg.0
    IL_00f1: ldarg.0
    IL_00f2: ldfld GridLayoutGroup PauseUILoadoutHelper::loadoutGroup  /*0x040014FC*/
    IL_00f7: ldloc.s 7
    IL_00f9: call void PauseUILoadoutHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x06001181*/
    IL_00fe: ldloca.s 5
    IL_0100: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0105: brtrue.s IL_00e7
    IL_0107: leave.s IL_0117
    IL_0109: ldloca.s 5
    IL_010b: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0111: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0116: endfinally
    IL_0117: ldloc.1
    IL_0118: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_011d: stloc.s 5
    IL_011f: br.s IL_0138
    IL_0121: ldloca.s 5
    IL_0123: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0128: stloc.s 8
    IL_012a: ldarg.0
    IL_012b: ldarg.0
    IL_012c: ldfld GridLayoutGroup PauseUILoadoutHelper::loadoutGroup  /*0x040014FC*/
    IL_0131: ldloc.s 8
    IL_0133: call void PauseUILoadoutHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x06001181*/
    IL_0138: ldloca.s 5
    IL_013a: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_013f: brtrue.s IL_0121
    IL_0141: leave.s IL_0151
    IL_0143: ldloca.s 5
    IL_0145: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_014b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0150: endfinally
    IL_0151: ldloc.2
    IL_0152: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0157: stloc.s 5
    IL_0159: br.s IL_0172
    IL_015b: ldloca.s 5
    IL_015d: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0162: stloc.s 9
    IL_0164: ldarg.0
    IL_0165: ldarg.0
    IL_0166: ldfld GridLayoutGroup PauseUILoadoutHelper::loadoutGroup  /*0x040014FC*/
    IL_016b: ldloc.s 9
    IL_016d: call void PauseUILoadoutHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  /*0x06001181*/
    IL_0172: ldloca.s 5
    IL_0174: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0179: brtrue.s IL_015b
    IL_017b: leave.s IL_018b
    IL_017d: ldloca.s 5
    IL_017f: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0185: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_018a: endfinally
    IL_018b: ldarg.0
    IL_018c: call void PauseUILoadoutHelper::RefreshOnlyEnemyPreview()  /*0x06001180*/
    IL_0191: ldarg.0
    IL_0192: call void PauseUILoadoutHelper::RefreshOnlyPlayerPreview()  /*0x0600117F*/
    IL_0197: ldarg.0
    IL_0198: call void PauseUILoadoutHelper::AssignNavigationTargets()  /*0x06001185*/
    IL_019d: ret
    .try IL_002a-IL_004b finally handler IL_004b-IL_005f
    .try IL_0082-IL_00cf finally handler IL_00cf-IL_00dd
    .try IL_00e5-IL_0109 finally handler IL_0109-IL_0117
    .try IL_011f-IL_0143 finally handler IL_0143-IL_0151
    .try IL_0159-IL_017d finally handler IL_017d-IL_018b

  .method PauseUILoadoutHelper::RefreshOnlyPlayerPreview()  // token 0x0600117F rva 0x53370 attrs Private, HideBySig
    // code size 208 (0xd0), max stack 3, init locals
    .locals ([0] UnitsInfo, [1] IEnumerator, [2] IDisposable, [3] List.Enumerator<UnitInfo>, [4] UnitInfo)
    IL_0000: ldsfld PlayerUnitsInfo PlayerUnitsInfo::instance  /*0x040017EA*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse IL_00be
    IL_0010: ldsfld PlayerUnitsInfo PlayerUnitsInfo::instance  /*0x040017EA*/
    IL_0015: callvirt UnitsInfo PlayerUnitsInfo::GetUnitsInfo()  /*0x060013AA*/
    IL_001a: stloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld GridLayoutGroup PauseUILoadoutHelper::unitsPreview  /*0x040014FE*/
    IL_0021: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0026: ldc.i4.1
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ldloc.0
    IL_002d: brfalse IL_00cf
    IL_0032: ldarg.0
    IL_0033: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_0038: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Clear()  /*0x0A0006F3*/
    IL_003d: ldarg.0
    IL_003e: ldfld GridLayoutGroup PauseUILoadoutHelper::unitsPreview  /*0x040014FE*/
    IL_0043: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0048: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_004d: stloc.1
    IL_004e: br.s IL_0065
    IL_0050: ldloc.1
    IL_0051: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_0056: castclass UnityEngine.Transform  /*0x01000015*/
    IL_005b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0060: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0065: ldloc.1
    IL_0066: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_006b: brtrue.s IL_0050
    IL_006d: leave.s IL_0080
    IL_006f: ldloc.1
    IL_0070: isinst System.IDisposable  /*0x0100001B*/
    IL_0075: stloc.2
    IL_0076: ldloc.2
    IL_0077: brfalse.s IL_007f
    IL_0079: ldloc.2
    IL_007a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007f: endfinally
    IL_0080: ldloc.0
    IL_0081: ldfld List<UnitInfo> UnitsInfo::Units  /*0x040017EB*/
    IL_0086: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnitInfo>::GetEnumerator()  /*0x0A0006F4*/
    IL_008b: stloc.3
    IL_008c: br.s IL_00a5
    IL_008e: ldloca.s 3
    IL_0090: call !0 System.Collections.Generic.List.Enumerator<UnitInfo>::get_Current()  /*0x0A0006F5*/
    IL_0095: stloc.s 4
    IL_0097: ldarg.0
    IL_0098: ldarg.0
    IL_0099: ldfld GridLayoutGroup PauseUILoadoutHelper::unitsPreview  /*0x040014FE*/
    IL_009e: ldloc.s 4
    IL_00a0: call void PauseUILoadoutHelper::AddTFUIPlayerUnit(UnityEngine.UI.GridLayoutGroup,UnitInfo)  /*0x06001184*/
    IL_00a5: ldloca.s 3
    IL_00a7: call bool System.Collections.Generic.List.Enumerator<UnitInfo>::MoveNext()  /*0x0A0006F6*/
    IL_00ac: brtrue.s IL_008e
    IL_00ae: leave.s IL_00cf
    IL_00b0: ldloca.s 3
    IL_00b2: constrained. System.Collections.Generic.List.Enumerator<UnitInfo>  /*0x1B000148*/
    IL_00b8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00bd: endfinally
    IL_00be: ldarg.0
    IL_00bf: ldfld GridLayoutGroup PauseUILoadoutHelper::unitsPreview  /*0x040014FE*/
    IL_00c4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00c9: ldc.i4.0
    IL_00ca: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00cf: ret
    .try IL_004e-IL_006f finally handler IL_006f-IL_0080
    .try IL_008c-IL_00b0 finally handler IL_00b0-IL_00be

  .method PauseUILoadoutHelper::RefreshOnlyEnemyPreview()  // token 0x06001180 rva 0x53468 attrs Private, HideBySig
    // code size 770 (0x302), max stack 12, init locals
    .locals ([0] WaveInfo, [1] IEnumerator, [2] IDisposable, [3] List.Enumerator<WaveEnemyInfo>, [4] WaveEnemyInfo, [5] WaveEnemyInfo, [6] float, [7] WaveEnemyInfo, [8] int)
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse IL_02df
    IL_0010: ldarg.0
    IL_0011: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_0016: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001b: ldc.i4.1
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ldarg.0
    IL_0022: ldfld TextMeshProUGUI PauseUILoadoutHelper::nightPreviewText  /*0x04001503*/
    IL_0027: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002c: ldc.i4.1
    IL_002d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0032: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0037: ldnull
    IL_0038: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003d: brfalse.s IL_004d
    IL_003f: ldarg.0
    IL_0040: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0045: call WaveInfo EnemySpawner::GetWaveInfoByNumber(int)  /*0x06000695*/
    IL_004a: stloc.0
    IL_004b: br.s IL_0053
    IL_004d: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_0052: stloc.0
    IL_0053: ldloc.0
    IL_0054: brfalse IL_0301
    IL_0059: ldarg.0
    IL_005a: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_005f: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Clear()  /*0x0A0006F3*/
    IL_0064: ldarg.0
    IL_0065: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_006a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006f: callvirt IEnumerator UnityEngine.Transform::GetEnumerator()  /*0x0A00060B*/
    IL_0074: stloc.1
    IL_0075: br.s IL_008c
    IL_0077: ldloc.1
    IL_0078: callvirt object System.Collections.IEnumerator::get_Current()  /*0x0A000041*/
    IL_007d: castclass UnityEngine.Transform  /*0x01000015*/
    IL_0082: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0087: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_008c: ldloc.1
    IL_008d: callvirt bool System.Collections.IEnumerator::MoveNext()  /*0x0A00003D*/
    IL_0092: brtrue.s IL_0077
    IL_0094: leave.s IL_00a7
    IL_0096: ldloc.1
    IL_0097: isinst System.IDisposable  /*0x0100001B*/
    IL_009c: stloc.2
    IL_009d: ldloc.2
    IL_009e: brfalse.s IL_00a6
    IL_00a0: ldloc.2
    IL_00a1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a6: endfinally
    IL_00a7: ldloc.0
    IL_00a8: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_00ad: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveEnemyInfo>::GetEnumerator()  /*0x0A0002A4*/
    IL_00b2: stloc.3
    IL_00b3: br.s IL_00cc
    IL_00b5: ldloca.s 3
    IL_00b7: call !0 System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::get_Current()  /*0x0A0002A5*/
    IL_00bc: stloc.s 4
    IL_00be: ldarg.0
    IL_00bf: ldarg.0
    IL_00c0: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_00c5: ldloc.s 4
    IL_00c7: call void PauseUILoadoutHelper::AddTFUIEnemey(UnityEngine.UI.GridLayoutGroup,WaveEnemyInfo)  /*0x06001182*/
    IL_00cc: ldloca.s 3
    IL_00ce: call bool System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::MoveNext()  /*0x0A0002A7*/
    IL_00d3: brtrue.s IL_00b5
    IL_00d5: leave.s IL_00e5
    IL_00d7: ldloca.s 3
    IL_00d9: constrained. System.Collections.Generic.List.Enumerator<WaveEnemyInfo>  /*0x1B000078*/
    IL_00df: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e4: endfinally
    IL_00e5: ldloc.0
    IL_00e6: ldfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_00eb: ldc.r4 1f
    IL_00f0: beq IL_01fb
    IL_00f5: newobj void WaveEnemyInfo::.ctor()  /*0x060006AE*/
    IL_00fa: stloc.s 5
    IL_00fc: ldloc.s 5
    IL_00fe: ldarg.0
    IL_00ff: ldfld Sprite PauseUILoadoutHelper::difficultySprite  /*0x04001504*/
    IL_0104: stfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_0109: ldloc.s 5
    IL_010b: ldloc.0
    IL_010c: ldfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_0111: ldc.r4 1f
    IL_0116: sub
    IL_0117: ldc.r4 0.1f
    IL_011c: div
    IL_011d: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0122: stfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0127: ldloc.s 5
    IL_0129: ldstr "Menu/DifficultyBoost"
    IL_012e: ldc.i4.1
    IL_012f: ldc.i4.0
    IL_0130: ldc.i4.1
    IL_0131: ldc.i4.0
    IL_0132: ldnull
    IL_0133: ldnull
    IL_0134: ldc.i4.1
    IL_0135: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_013a: stfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_013f: ldloc.s 5
    IL_0141: ldstr "+ "
    IL_0146: ldloc.0
    IL_0147: ldfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_014c: ldc.r4 1f
    IL_0151: sub
    IL_0152: ldc.r4 100f
    IL_0157: mul
    IL_0158: call float UnityEngine.Mathf::Round(float)  /*0x0A0000F8*/
    IL_015d: stloc.s 6
    IL_015f: ldloca.s 6
    IL_0161: call string System.Single::ToString()  /*0x0A00030C*/
    IL_0166: ldstr "% "
    IL_016b: ldstr "Menu/AdditionalHealth"
    IL_0170: ldc.i4.1
    IL_0171: ldc.i4.0
    IL_0172: ldc.i4.1
    IL_0173: ldc.i4.0
    IL_0174: ldnull
    IL_0175: ldnull
    IL_0176: ldc.i4.1
    IL_0177: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_017c: call string System.String::Concat(string,string,string,string)  /*0x0A000108*/
    IL_0181: stfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_0186: ldloc.s 5
    IL_0188: stloc.s 7
    IL_018a: ldloc.s 7
    IL_018c: ldc.i4.5
    IL_018d: newarr System.String  /*0x0100001D*/
    IL_0192: dup
    IL_0193: ldc.i4.0
    IL_0194: ldloc.s 7
    IL_0196: ldfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_019b: stelem.ref
    IL_019c: dup
    IL_019d: ldc.i4.1
    IL_019e: ldstr "\n+ "
    IL_01a3: stelem.ref
    IL_01a4: dup
    IL_01a5: ldc.i4.2
    IL_01a6: ldloc.0
    IL_01a7: ldfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_01ac: ldc.r4 1f
    IL_01b1: sub
    IL_01b2: ldc.r4 50f
    IL_01b7: mul
    IL_01b8: call float UnityEngine.Mathf::Round(float)  /*0x0A0000F8*/
    IL_01bd: stloc.s 6
    IL_01bf: ldloca.s 6
    IL_01c1: call string System.Single::ToString()  /*0x0A00030C*/
    IL_01c6: stelem.ref
    IL_01c7: dup
    IL_01c8: ldc.i4.3
    IL_01c9: ldstr "% "
    IL_01ce: stelem.ref
    IL_01cf: dup
    IL_01d0: ldc.i4.4
    IL_01d1: ldstr "Menu/AdditionalDamage"
    IL_01d6: ldc.i4.1
    IL_01d7: ldc.i4.0
    IL_01d8: ldc.i4.1
    IL_01d9: ldc.i4.0
    IL_01da: ldnull
    IL_01db: ldnull
    IL_01dc: ldc.i4.1
    IL_01dd: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_01e2: stelem.ref
    IL_01e3: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_01e8: stfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_01ed: ldarg.0
    IL_01ee: ldarg.0
    IL_01ef: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_01f4: ldloc.s 5
    IL_01f6: call void PauseUILoadoutHelper::AddTFUIEnemey(UnityEngine.UI.GridLayoutGroup,WaveEnemyInfo)  /*0x06001182*/
    IL_01fb: ldarg.0
    IL_01fc: ldarg.0
    IL_01fd: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_0202: call void PauseUILoadoutHelper::AddIncomePreview(UnityEngine.UI.GridLayoutGroup)  /*0x06001183*/
    IL_0207: ldarg.0
    IL_0208: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_020d: ldarg.0
    IL_020e: ldfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_0213: bne.un.s IL_026c
    IL_0215: ldarg.0
    IL_0216: ldfld TextMeshProUGUI PauseUILoadoutHelper::nightPreviewText  /*0x04001503*/
    IL_021b: ldc.i4.5
    IL_021c: newarr System.String  /*0x0100001D*/
    IL_0221: dup
    IL_0222: ldc.i4.0
    IL_0223: ldstr "Menu/Night"
    IL_0228: ldc.i4.1
    IL_0229: ldc.i4.0
    IL_022a: ldc.i4.1
    IL_022b: ldc.i4.0
    IL_022c: ldnull
    IL_022d: ldnull
    IL_022e: ldc.i4.1
    IL_022f: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_0234: stelem.ref
    IL_0235: dup
    IL_0236: ldc.i4.1
    IL_0237: ldstr ": <style=Body Numerals>"
    IL_023c: stelem.ref
    IL_023d: dup
    IL_023e: ldc.i4.2
    IL_023f: ldloc.0
    IL_0240: ldflda int WaveInfo::waveNumber  /*0x040007FB*/
    IL_0245: call string System.Int32::ToString()  /*0x0A000031*/
    IL_024a: stelem.ref
    IL_024b: dup
    IL_024c: ldc.i4.3
    IL_024d: ldstr "</style>/<style=Body Numerals>"
    IL_0252: stelem.ref
    IL_0253: dup
    IL_0254: ldc.i4.4
    IL_0255: ldloc.0
    IL_0256: ldflda int WaveInfo::outOfWaves  /*0x040007FC*/
    IL_025b: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0260: stelem.ref
    IL_0261: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_0266: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_026b: ret
    IL_026c: ldarg.0
    IL_026d: ldfld TextMeshProUGUI PauseUILoadoutHelper::nightPreviewText  /*0x04001503*/
    IL_0272: ldc.i4.7
    IL_0273: newarr System.String  /*0x0100001D*/
    IL_0278: dup
    IL_0279: ldc.i4.0
    IL_027a: ldstr "Menu/Night"
    IL_027f: ldc.i4.1
    IL_0280: ldc.i4.0
    IL_0281: ldc.i4.1
    IL_0282: ldc.i4.0
    IL_0283: ldnull
    IL_0284: ldnull
    IL_0285: ldc.i4.1
    IL_0286: call string I2.Loc.LocalizationManager::GetTranslation(string,bool,int,bool,bool,UnityEngine.GameObject,string,bool)  /*0x06001855*/
    IL_028b: stelem.ref
    IL_028c: dup
    IL_028d: ldc.i4.1
    IL_028e: ldstr ": <style=Body Numerals>"
    IL_0293: stelem.ref
    IL_0294: dup
    IL_0295: ldc.i4.2
    IL_0296: ldloc.0
    IL_0297: ldflda int WaveInfo::waveNumber  /*0x040007FB*/
    IL_029c: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02a1: stelem.ref
    IL_02a2: dup
    IL_02a3: ldc.i4.3
    IL_02a4: ldstr "</style>(<style=Body Numerals>"
    IL_02a9: stelem.ref
    IL_02aa: dup
    IL_02ab: ldc.i4.4
    IL_02ac: ldarg.0
    IL_02ad: ldfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_02b2: ldc.i4.1
    IL_02b3: add
    IL_02b4: stloc.s 8
    IL_02b6: ldloca.s 8
    IL_02b8: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02bd: stelem.ref
    IL_02be: dup
    IL_02bf: ldc.i4.5
    IL_02c0: ldstr "</style>)<style=Body Numerals></style>/<style=Body Numerals>"
    IL_02c5: stelem.ref
    IL_02c6: dup
    IL_02c7: ldc.i4.6
    IL_02c8: ldloc.0
    IL_02c9: ldflda int WaveInfo::outOfWaves  /*0x040007FC*/
    IL_02ce: call string System.Int32::ToString()  /*0x0A000031*/
    IL_02d3: stelem.ref
    IL_02d4: call string System.String::Concat(string[])  /*0x0A00011F*/
    IL_02d9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_02de: ret
    IL_02df: ldarg.0
    IL_02e0: ldfld GridLayoutGroup PauseUILoadoutHelper::enemyPreview  /*0x040014FD*/
    IL_02e5: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_02ea: ldc.i4.0
    IL_02eb: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_02f0: ldarg.0
    IL_02f1: ldfld TextMeshProUGUI PauseUILoadoutHelper::nightPreviewText  /*0x04001503*/
    IL_02f6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_02fb: ldc.i4.0
    IL_02fc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0301: ret
    .try IL_0075-IL_0096 finally handler IL_0096-IL_00a7
    .try IL_00b3-IL_00d7 finally handler IL_00d7-IL_00e5

  .method PauseUILoadoutHelper::AddTFUIEquippable(UnityEngine.UI.GridLayoutGroup,Equippable)  // token 0x06001181 rva 0x53794 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 2, init locals
    .locals ([0] TFUIEquippable)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEquippable PauseUILoadoutHelper::equippableButtonPrefab  /*0x040014FF*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEquippable>  /*0x2B0000EB*/
    IL_0011: callvirt !!0 UnityEngine.Component::GetComponent()<TFUIEquippable>  /*0x2B0000E9*/
    IL_0016: stloc.0
    IL_0017: ldloc.0
    IL_0018: ldarg.2
    IL_0019: callvirt void TFUIEquippable::SetDataSimple(Equippable)  /*0x0600120B*/
    IL_001e: ldarg.0
    IL_001f: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_0024: ldloc.0
    IL_0025: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_002a: ret

  .method PauseUILoadoutHelper::AddTFUIEnemey(UnityEngine.UI.GridLayoutGroup,WaveEnemyInfo)  // token 0x06001182 rva 0x537cc attrs Private, HideBySig
    // code size 38 (0x26), max stack 2, init locals
    .locals ([0] TFUIEnemy)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIEnemy PauseUILoadoutHelper::enemyButtonPrefab  /*0x04001500*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEnemy>  /*0x2B0000FC*/
    IL_0011: stloc.0
    IL_0012: ldloc.0
    IL_0013: ldarg.2
    IL_0014: callvirt void TFUIEnemy::SetDataSimple(WaveEnemyInfo)  /*0x060011E3*/
    IL_0019: ldarg.0
    IL_001a: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_001f: ldloc.0
    IL_0020: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_0025: ret

  .method PauseUILoadoutHelper::AddIncomePreview(UnityEngine.UI.GridLayoutGroup)  // token 0x06001183 rva 0x53800 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 2, init locals
    .locals ([0] TFUIIncomeDisplay)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIIncomeDisplay PauseUILoadoutHelper::incomeDisplayPrefab  /*0x04001502*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIIncomeDisplay>  /*0x2B0000FF*/
    IL_0011: stloc.0
    IL_0012: ldloc.0
    IL_0013: ldarg.0
    IL_0014: ldfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0019: callvirt void TFUIIncomeDisplay::UpdateData(int)  /*0x0600121C*/
    IL_001e: ldarg.0
    IL_001f: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_0024: ldloc.0
    IL_0025: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_002a: ret

  .method PauseUILoadoutHelper::AddTFUIPlayerUnit(UnityEngine.UI.GridLayoutGroup,UnitInfo)  // token 0x06001184 rva 0x53838 attrs Private, HideBySig
    // code size 38 (0x26), max stack 2, init locals
    .locals ([0] TFUIPlayerUnit)
    IL_0000: ldarg.0
    IL_0001: ldfld TFUIPlayerUnit PauseUILoadoutHelper::playerButtonPrefab  /*0x04001501*/
    IL_0006: ldarg.1
    IL_0007: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIPlayerUnit>  /*0x2B000100*/
    IL_0011: stloc.0
    IL_0012: ldloc.0
    IL_0013: ldarg.2
    IL_0014: callvirt void TFUIPlayerUnit::SetDataSimple(UnitInfo)  /*0x0600122F*/
    IL_0019: ldarg.0
    IL_001a: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_001f: ldloc.0
    IL_0020: callvirt void System.Collections.Generic.List<ThronefallUIElement>::Add(!0)  /*0x0A0006F7*/
    IL_0025: ret

  .method PauseUILoadoutHelper::AssignNavigationTargets()  // token 0x06001185 rva 0x5386c attrs Private, HideBySig
    // code size 283 (0x11b), max stack 8, init locals
    .locals ([0] ThronefallUIElement, [1] ThronefallUIElement, [2] ThronefallUIElement)
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_000d: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0012: ldc.i4.0
    IL_0013: ble.s IL_0022
    IL_0015: ldarg.0
    IL_0016: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_001b: ldc.i4.0
    IL_001c: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0021: stloc.0
    IL_0022: ldarg.0
    IL_0023: ldfld ThronefallUIElement PauseUILoadoutHelper::rightMostElement  /*0x040014F7*/
    IL_0028: stloc.1
    IL_0029: ldarg.0
    IL_002a: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_002f: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0034: ldc.i4.0
    IL_0035: ble.s IL_0044
    IL_0037: ldarg.0
    IL_0038: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_003d: ldc.i4.0
    IL_003e: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0043: stloc.1
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_004b: ldloc.0
    IL_004c: ldarg.0
    IL_004d: ldfld ThronefallUIElement PauseUILoadoutHelper::botmostButton  /*0x040014F5*/
    IL_0052: ldloc.1
    IL_0053: ldc.i4.1
    IL_0054: ldc.i4.0
    IL_0055: ldc.i4.0
    IL_0056: call void PauseUILoadoutHelper::CalculateGridNavigation(System.Collections.Generic.List<ThronefallUIElement>,ThronefallUIElement,ThronefallUIElement,ThronefallUIElement,bool,bool,bool)  /*0x06001186*/
    IL_005b: ldarg.0
    IL_005c: ldfld ThronefallUIElement PauseUILoadoutHelper::botmostButton  /*0x040014F5*/
    IL_0061: stloc.2
    IL_0062: ldarg.0
    IL_0063: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_0068: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_006d: ldc.i4.0
    IL_006e: ble.s IL_007d
    IL_0070: ldarg.0
    IL_0071: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_0076: ldc.i4.0
    IL_0077: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_007c: stloc.2
    IL_007d: ldarg.0
    IL_007e: ldarg.0
    IL_007f: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_0084: ldarg.0
    IL_0085: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_008a: ldloc.2
    IL_008b: ldloc.1
    IL_008c: ldc.i4.0
    IL_008d: ldc.i4.1
    IL_008e: ldc.i4.0
    IL_008f: call void PauseUILoadoutHelper::CalculateGridNavigation(System.Collections.Generic.List<ThronefallUIElement>,ThronefallUIElement,ThronefallUIElement,ThronefallUIElement,bool,bool,bool)  /*0x06001186*/
    IL_0094: ldarg.0
    IL_0095: ldarg.0
    IL_0096: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_009b: ldarg.0
    IL_009c: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_00a7: ldnull
    IL_00a8: ldc.i4.0
    IL_00a9: ldc.i4.0
    IL_00aa: ldc.i4.1
    IL_00ab: call void PauseUILoadoutHelper::CalculateGridNavigation(System.Collections.Generic.List<ThronefallUIElement>,ThronefallUIElement,ThronefallUIElement,ThronefallUIElement,bool,bool,bool)  /*0x06001186*/
    IL_00b0: ldarg.0
    IL_00b1: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_00b6: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_00bb: ldc.i4.0
    IL_00bc: ble.s IL_011a
    IL_00be: ldarg.0
    IL_00bf: ldfld ThronefallUIElement PauseUILoadoutHelper::continueElement  /*0x040014F8*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_00ca: ldc.i4.0
    IL_00cb: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00d0: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_00d5: ldarg.0
    IL_00d6: ldfld ThronefallUIElement PauseUILoadoutHelper::settingsElement  /*0x040014F9*/
    IL_00db: ldarg.0
    IL_00dc: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_00e1: ldc.i4.0
    IL_00e2: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00e7: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld ThronefallUIElement PauseUILoadoutHelper::RestartElement  /*0x040014FA*/
    IL_00f2: ldarg.0
    IL_00f3: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_00f8: ldc.i4.0
    IL_00f9: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00fe: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0103: ldarg.0
    IL_0104: ldfld ThronefallUIElement PauseUILoadoutHelper::backToMenuElement  /*0x040014FB*/
    IL_0109: ldarg.0
    IL_010a: ldfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_010f: ldc.i4.0
    IL_0110: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0115: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_011a: ret

  .method PauseUILoadoutHelper::CalculateGridNavigation(System.Collections.Generic.List<ThronefallUIElement>,ThronefallUIElement,ThronefallUIElement,ThronefallUIElement,bool,bool,bool)  // token 0x06001186 rva 0x53994 attrs Private, HideBySig
    // code size 572 (0x23c), max stack 6, init locals
    .locals ([0] int, [1] int, [2] int, [3] int, [4] int, [5] ThronefallUIElement, [6] int)
    IL_0000: ldarg.1
    IL_0001: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0006: ldc.i4.2
    IL_0007: div
    IL_0008: stloc.0
    IL_0009: ldarg.1
    IL_000a: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_000f: ldc.i4.2
    IL_0010: rem
    IL_0011: stloc.1
    IL_0012: ldloc.1
    IL_0013: ldc.i4.0
    IL_0014: ble.s IL_001c
    IL_0016: ldloc.0
    IL_0017: ldc.i4.1
    IL_0018: add
    IL_0019: stloc.0
    IL_001a: br.s IL_001e
    IL_001c: ldc.i4.2
    IL_001d: stloc.1
    IL_001e: ldc.i4.0
    IL_001f: stloc.2
    IL_0020: ldc.i4.0
    IL_0021: stloc.3
    IL_0022: ldc.i4.0
    IL_0023: stloc.s 4
    IL_0025: br IL_01d1
    IL_002a: ldarg.1
    IL_002b: ldloc.s 4
    IL_002d: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0032: stloc.s 5
    IL_0034: ldloc.2
    IL_0035: brtrue.s IL_0041
    IL_0037: ldloc.s 5
    IL_0039: ldarg.3
    IL_003a: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_003f: br.s IL_0052
    IL_0041: ldloc.s 5
    IL_0043: ldarg.1
    IL_0044: ldloc.s 4
    IL_0046: ldc.i4.1
    IL_0047: sub
    IL_0048: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_004d: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0052: ldloc.2
    IL_0053: ldc.i4.1
    IL_0054: beq.s IL_0066
    IL_0056: ldloc.0
    IL_0057: ldc.i4.1
    IL_0058: bne.un.s IL_0070
    IL_005a: ldloc.s 4
    IL_005c: ldarg.1
    IL_005d: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_0062: ldc.i4.1
    IL_0063: sub
    IL_0064: bne.un.s IL_0070
    IL_0066: ldloc.s 5
    IL_0068: ldarg.2
    IL_0069: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_006e: br.s IL_00a5
    IL_0070: ldloc.0
    IL_0071: ldc.i4.1
    IL_0072: ble.s IL_0094
    IL_0074: ldloc.s 4
    IL_0076: ldarg.1
    IL_0077: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_007c: ldc.i4.1
    IL_007d: sub
    IL_007e: bne.un.s IL_0094
    IL_0080: ldloc.s 5
    IL_0082: ldarg.1
    IL_0083: ldc.i4.2
    IL_0084: ldloc.3
    IL_0085: mul
    IL_0086: ldc.i4.1
    IL_0087: sub
    IL_0088: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_008d: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_0092: br.s IL_00a5
    IL_0094: ldloc.s 5
    IL_0096: ldarg.1
    IL_0097: ldloc.s 4
    IL_0099: ldc.i4.1
    IL_009a: add
    IL_009b: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00a0: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_00a5: ldloc.0
    IL_00a6: ldc.i4.1
    IL_00a7: ble IL_019e
    IL_00ac: ldloc.3
    IL_00ad: brtrue.s IL_010b
    IL_00af: ldloc.2
    IL_00b0: ldloc.1
    IL_00b1: ldc.i4.1
    IL_00b2: sub
    IL_00b3: bgt.s IL_00dc
    IL_00b5: ldarg.s 7
    IL_00b7: brfalse.s IL_00c3
    IL_00b9: ldloc.s 5
    IL_00bb: ldarg.3
    IL_00bc: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_00c1: br.s IL_011c
    IL_00c3: ldloc.s 5
    IL_00c5: ldarg.1
    IL_00c6: ldarg.1
    IL_00c7: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_00cc: ldloc.1
    IL_00cd: ldloc.2
    IL_00ce: sub
    IL_00cf: sub
    IL_00d0: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_00d5: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_00da: br.s IL_011c
    IL_00dc: ldloc.s 4
    IL_00de: ldc.i4.2
    IL_00df: add
    IL_00e0: ldarg.1
    IL_00e1: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_00e6: ldc.i4.1
    IL_00e7: sub
    IL_00e8: bgt.s IL_011c
    IL_00ea: ldarg.s 7
    IL_00ec: brfalse.s IL_00f8
    IL_00ee: ldloc.s 5
    IL_00f0: ldarg.3
    IL_00f1: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_00f6: br.s IL_011c
    IL_00f8: ldloc.s 5
    IL_00fa: ldarg.1
    IL_00fb: ldloc.s 4
    IL_00fd: ldc.i4.2
    IL_00fe: add
    IL_00ff: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0104: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_0109: br.s IL_011c
    IL_010b: ldloc.s 5
    IL_010d: ldarg.1
    IL_010e: ldloc.s 4
    IL_0110: ldc.i4.2
    IL_0111: sub
    IL_0112: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0117: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_011c: ldloc.3
    IL_011d: ldloc.0
    IL_011e: ldc.i4.1
    IL_011f: sub
    IL_0120: bne.un.s IL_0151
    IL_0122: ldarg.s 4
    IL_0124: ldnull
    IL_0125: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_012a: brfalse.s IL_013a
    IL_012c: ldloc.s 5
    IL_012e: ldarg.s 4
    IL_0130: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0135: br IL_01bd
    IL_013a: ldloc.s 5
    IL_013c: ldarg.1
    IL_013d: ldloc.s 4
    IL_013f: ldc.i4.2
    IL_0140: ldloc.0
    IL_0141: ldc.i4.1
    IL_0142: sub
    IL_0143: mul
    IL_0144: sub
    IL_0145: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_014a: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_014f: br.s IL_01bd
    IL_0151: ldloc.s 4
    IL_0153: ldc.i4.2
    IL_0154: add
    IL_0155: stloc.s 6
    IL_0157: ldloc.s 6
    IL_0159: ldarg.1
    IL_015a: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_015f: ldc.i4.1
    IL_0160: sub
    IL_0161: bgt.s IL_0174
    IL_0163: ldloc.s 5
    IL_0165: ldarg.1
    IL_0166: ldloc.s 6
    IL_0168: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_016d: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0172: br.s IL_01bd
    IL_0174: ldarg.s 4
    IL_0176: ldnull
    IL_0177: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_017c: brfalse.s IL_0189
    IL_017e: ldloc.s 5
    IL_0180: ldarg.s 4
    IL_0182: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_0187: br.s IL_01bd
    IL_0189: ldloc.s 5
    IL_018b: ldarg.1
    IL_018c: ldloc.s 4
    IL_018e: ldc.i4.2
    IL_018f: ldloc.3
    IL_0190: mul
    IL_0191: sub
    IL_0192: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0197: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_019c: br.s IL_01bd
    IL_019e: ldarg.s 4
    IL_01a0: ldnull
    IL_01a1: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01a6: brfalse.s IL_01b1
    IL_01a8: ldloc.s 5
    IL_01aa: ldarg.s 4
    IL_01ac: stfld ThronefallUIElement ThronefallUIElement::rightNav  /*0x04001682*/
    IL_01b1: ldarg.s 7
    IL_01b3: brfalse.s IL_01bd
    IL_01b5: ldloc.s 5
    IL_01b7: ldarg.3
    IL_01b8: stfld ThronefallUIElement ThronefallUIElement::leftNav  /*0x04001681*/
    IL_01bd: ldloc.2
    IL_01be: ldc.i4.1
    IL_01bf: add
    IL_01c0: stloc.2
    IL_01c1: ldloc.2
    IL_01c2: ldc.i4.1
    IL_01c3: ble.s IL_01cb
    IL_01c5: ldc.i4.0
    IL_01c6: stloc.2
    IL_01c7: ldloc.3
    IL_01c8: ldc.i4.1
    IL_01c9: add
    IL_01ca: stloc.3
    IL_01cb: ldloc.s 4
    IL_01cd: ldc.i4.1
    IL_01ce: add
    IL_01cf: stloc.s 4
    IL_01d1: ldloc.s 4
    IL_01d3: ldarg.1
    IL_01d4: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_01d9: blt IL_002a
    IL_01de: ldarg.1
    IL_01df: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_01e4: ldc.i4.0
    IL_01e5: ble.s IL_023b
    IL_01e7: ldarg.s 5
    IL_01e9: brfalse.s IL_01fd
    IL_01eb: ldarg.0
    IL_01ec: ldfld ThronefallUIElement PauseUILoadoutHelper::botmostButton  /*0x040014F5*/
    IL_01f1: ldarg.1
    IL_01f2: ldc.i4.0
    IL_01f3: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_01f8: stfld ThronefallUIElement ThronefallUIElement::botNav  /*0x04001684*/
    IL_01fd: ldarg.s 6
    IL_01ff: brfalse.s IL_023b
    IL_0201: ldloc.1
    IL_0202: ldc.i4.2
    IL_0203: beq.s IL_0222
    IL_0205: ldloc.0
    IL_0206: ldc.i4.1
    IL_0207: ble.s IL_0222
    IL_0209: ldarg.0
    IL_020a: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_020f: ldarg.1
    IL_0210: ldc.i4.2
    IL_0211: ldloc.0
    IL_0212: ldc.i4.1
    IL_0213: sub
    IL_0214: mul
    IL_0215: ldc.i4.1
    IL_0216: sub
    IL_0217: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_021c: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_0221: ret
    IL_0222: ldarg.0
    IL_0223: ldfld ThronefallUIElement PauseUILoadoutHelper::topmostButton  /*0x040014F4*/
    IL_0228: ldarg.1
    IL_0229: ldarg.1
    IL_022a: callvirt int System.Collections.Generic.List<ThronefallUIElement>::get_Count()  /*0x0A0006F8*/
    IL_022f: ldc.i4.1
    IL_0230: sub
    IL_0231: callvirt !0 System.Collections.Generic.List<ThronefallUIElement>::get_Item(int)  /*0x0A0006F9*/
    IL_0236: stfld ThronefallUIElement ThronefallUIElement::topNav  /*0x04001683*/
    IL_023b: ret

  .method PauseUILoadoutHelper::.ctor()  // token 0x06001187 rva 0x53bdc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_0006: stfld List<ThronefallUIElement> PauseUILoadoutHelper::loadoutGrid  /*0x04001505*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_0011: stfld List<ThronefallUIElement> PauseUILoadoutHelper::enemyGrid  /*0x04001506*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<ThronefallUIElement>::.ctor()  /*0x0A0006FA*/
    IL_001c: stfld List<ThronefallUIElement> PauseUILoadoutHelper::playerGrid  /*0x04001507*/
    IL_0021: ldarg.0
    IL_0022: ldc.i4.1
    IL_0023: stfld int PauseUILoadoutHelper::currentPreviewWavenumber  /*0x04001509*/
    IL_0028: ldarg.0
    IL_0029: ldc.i4.1
    IL_002a: stfld int PauseUILoadoutHelper::currentTrueWaveNumver  /*0x0400150A*/
    IL_002f: ldarg.0
    IL_0030: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0035: ret

