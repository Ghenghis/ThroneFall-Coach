// ===== DayNightCycle  (token 0x020000AA) =====
  .method DayNightCycle::get_Instance()  // token 0x060003A1 rva 0x10496 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld DayNightCycle DayNightCycle::instance  /*0x040004B5*/
    IL_0005: ret

  .method DayNightCycle::get_CurrentTimestate()  // token 0x060003A2 rva 0x1049d attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0006: ret

  .method DayNightCycle::get_CurrentNightLength()  // token 0x060003A3 rva 0x104a5 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float DayNightCycle::currentNightLength  /*0x040004B8*/
    IL_0006: ret

  .method DayNightCycle::get_AfterSunrise()  // token 0x060003A4 rva 0x104ad attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool DayNightCycle::afterSunrise  /*0x040004BA*/
    IL_0006: ret

  .method DayNightCycle::get_AutomatedDaytime()  // token 0x060003A5 rva 0x104b5 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool DayNightCycle::automatedDaytime  /*0x040004BB*/
    IL_0006: ret

  .method DayNightCycle::get_RemainingAutoDayTime()  // token 0x060003A6 rva 0x104bd attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_0006: ret

  .method DayNightCycle::get_AutomatedNighttime()  // token 0x060003A7 rva 0x104c5 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool DayNightCycle::automatedNighttime  /*0x040004BE*/
    IL_0006: ret

  .method DayNightCycle::get_RemainingAutoNightTime()  // token 0x060003A8 rva 0x104cd attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_0006: ret

  .method DayNightCycle::get_CoinCountToBeHarvested()  // token 0x060003A9 rva 0x104d8 attrs Public, HideBySig, SpecialName
    // code size 99 (0x63), max stack 2, init locals
    .locals ([0] int, [1] List.Enumerator<BuildingInteractor>, [2] BuildingInteractor)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0007: ldfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildingInteractor>::GetEnumerator()  /*0x0A0001A2*/
    IL_0011: stloc.1
    IL_0012: br.s IL_0048
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<BuildingInteractor>::get_Current()  /*0x0A0001A3*/
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: ldfld CoinSpawner BuildingInteractor::coinSpawner  /*0x04000E8B*/
    IL_0022: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0027: brfalse.s IL_0037
    IL_0029: ldloc.0
    IL_002a: ldloc.2
    IL_002b: ldfld CoinSpawner BuildingInteractor::coinSpawner  /*0x04000E8B*/
    IL_0030: callvirt int CoinSpawner::get_CoinsLeft()  /*0x06000343*/
    IL_0035: add
    IL_0036: stloc.0
    IL_0037: ldloc.2
    IL_0038: callvirt bool BuildingInteractor::get_canBeHarvested()  /*0x06000BA5*/
    IL_003d: brfalse.s IL_0048
    IL_003f: ldloc.0
    IL_0040: ldloc.2
    IL_0041: callvirt int BuildingInteractor::get_GoldIncome()  /*0x06000BA7*/
    IL_0046: add
    IL_0047: stloc.0
    IL_0048: ldloca.s 1
    IL_004a: call bool System.Collections.Generic.List.Enumerator<BuildingInteractor>::MoveNext()  /*0x0A0001A4*/
    IL_004f: brtrue.s IL_0014
    IL_0051: leave.s IL_0061
    IL_0053: ldloca.s 1
    IL_0055: constrained. System.Collections.Generic.List.Enumerator<BuildingInteractor>  /*0x1B000038*/
    IL_005b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0060: endfinally
    IL_0061: ldloc.0
    IL_0062: ret
    .try IL_0012-IL_0053 finally handler IL_0053-IL_0061

  .method DayNightCycle::Awake()  // token 0x060003AA rva 0x10558 attrs Private, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldsfld DayNightCycle DayNightCycle::instance  /*0x040004B5*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0014
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret
    IL_0014: ldarg.0
    IL_0015: stsfld DayNightCycle DayNightCycle::instance  /*0x040004B5*/
    IL_001a: ret

  .method DayNightCycle::Update()  // token 0x060003AB rva 0x10574 attrs Private, HideBySig
    // code size 308 (0x134), max stack 3, init locals
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_000a: ldc.i4.1
    IL_000b: beq.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0014: ldc.i4.1
    IL_0015: bne.un.s IL_0029
    IL_0017: ldarg.0
    IL_0018: ldarg.0
    IL_0019: ldfld float DayNightCycle::currentNightLength  /*0x040004B8*/
    IL_001e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0023: add
    IL_0024: stfld float DayNightCycle::currentNightLength  /*0x040004B8*/
    IL_0029: ldarg.0
    IL_002a: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_002f: ldc.i4.1
    IL_0030: bne.un.s IL_007d
    IL_0032: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0037: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_003c: brfalse.s IL_007d
    IL_003e: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0043: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0048: brfalse.s IL_007d
    IL_004a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_004f: callvirt bool EnemySpawner::get_SpawningInProgress()  /*0x0600066C*/
    IL_0054: brtrue.s IL_007d
    IL_0056: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_005b: callvirt int EnemySpawner::get_NumberOfEnemiesOnTheMap()  /*0x0600067B*/
    IL_0060: ldc.i4.0
    IL_0061: bgt.s IL_007d
    IL_0063: ldarg.0
    IL_0064: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0069: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_006e: brfalse.s IL_007d
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: call IEnumerator DayNightCycle::SwitchToDayCoroutine()  /*0x060003B0*/
    IL_0077: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_007c: pop
    IL_007d: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0082: ldc.i4.3
    IL_0083: callvirt int TagManager::CountObjectsWithTag(TagManager.ETag)  /*0x06000E5A*/
    IL_0088: ldc.i4.0
    IL_0089: ble.s IL_00eb
    IL_008b: ldarg.0
    IL_008c: ldfld bool DayNightCycle::automatedDaytime  /*0x040004BB*/
    IL_0091: brfalse.s IL_00eb
    IL_0093: ldarg.0
    IL_0094: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0099: brtrue.s IL_00eb
    IL_009b: ldarg.0
    IL_009c: ldarg.0
    IL_009d: ldfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_00a2: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00a7: sub
    IL_00a8: stfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_00b3: ldc.r4 0f
    IL_00b8: bgt.un.s IL_00eb
    IL_00ba: ldarg.0
    IL_00bb: ldc.r4 0f
    IL_00c0: stfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_00c5: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_00ca: callvirt bool ChoiceManager::get_ChoiceCoroutineWaiting()  /*0x0600091D*/
    IL_00cf: brfalse.s IL_00e5
    IL_00d1: ldsfld ChoiceManager ChoiceManager::instance  /*0x04000B87*/
    IL_00d6: callvirt void ChoiceManager::CancelChoice()  /*0x0600091F*/
    IL_00db: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_00e0: callvirt void UIFrameManager::CloseAllFrames()  /*0x0600130A*/
    IL_00e5: ldarg.0
    IL_00e6: call void DayNightCycle::SwitchToNight()  /*0x060003B1*/
    IL_00eb: ldarg.0
    IL_00ec: ldfld bool DayNightCycle::automatedNighttime  /*0x040004BE*/
    IL_00f1: brfalse.s IL_0133
    IL_00f3: ldarg.0
    IL_00f4: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_00f9: ldc.i4.1
    IL_00fa: bne.un.s IL_0133
    IL_00fc: ldarg.0
    IL_00fd: ldarg.0
    IL_00fe: ldfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_0103: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0108: sub
    IL_0109: stfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_010e: ldarg.0
    IL_010f: ldfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_0114: ldc.r4 0f
    IL_0119: bgt.un.s IL_0133
    IL_011b: ldarg.0
    IL_011c: ldc.r4 0f
    IL_0121: stfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_0126: ldarg.0
    IL_0127: ldarg.0
    IL_0128: call IEnumerator DayNightCycle::SwitchToDayCoroutine()  /*0x060003B0*/
    IL_012d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0132: pop
    IL_0133: ret

  .method DayNightCycle::DawnCallAfterSunrise()  // token 0x060003AC rva 0x106b4 attrs Private, HideBySig
    // code size 326 (0x146), max stack 3, init locals
    .locals ([0] int, [1] PlayerInteraction, [2] int, [3] List.Enumerator<Coin>, [4] Coin, [5] List.Enumerator<EnergyCore>, [6] EnergyCore)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool DayNightCycle::afterSunrise  /*0x040004BA*/
    IL_0007: call void Hp::ReviveAllKnockedOutPlayerUnitsAndBuildings()  /*0x06000834*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0012: callvirt int System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Count()  /*0x0A0001A5*/
    IL_0017: ldc.i4.1
    IL_0018: sub
    IL_0019: stloc.2
    IL_001a: br.s IL_0057
    IL_001c: nop
    IL_001d: ldarg.0
    IL_001e: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0023: ldloc.2
    IL_0024: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_0029: brfalse.s IL_003e
    IL_002b: ldarg.0
    IL_002c: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0031: ldloc.2
    IL_0032: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_0037: callvirt void DayNightCycle.IDaytimeSensitive::OnDawn_AfterSunrise()  /*0x060003BA*/
    IL_003c: br.s IL_004a
    IL_003e: ldarg.0
    IL_003f: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0044: ldloc.2
    IL_0045: callvirt void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::RemoveAt(int)  /*0x0A0001A7*/
    IL_004a: leave.s IL_0053
    IL_004c: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0051: leave.s IL_0053
    IL_0053: ldloc.2
    IL_0054: ldc.i4.1
    IL_0055: sub
    IL_0056: stloc.2
    IL_0057: ldloc.2
    IL_0058: ldc.i4.0
    IL_0059: bge.s IL_001c
    IL_005b: ldc.i4.7
    IL_005c: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0061: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0066: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_006b: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0070: callvirt int PlayerInteraction::get_Networth()  /*0x06000BFA*/
    IL_0075: stloc.0
    IL_0076: ldloc.0
    IL_0077: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_007c: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_0081: callvirt int System.Collections.Generic.List<Coin>::get_Count()  /*0x0A0001A8*/
    IL_0086: add
    IL_0087: stloc.0
    IL_0088: ldloc.0
    IL_0089: ldarg.0
    IL_008a: call int DayNightCycle::get_CoinCountToBeHarvested()  /*0x060003A9*/
    IL_008f: add
    IL_0090: stloc.0
    IL_0091: ldfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_0096: ldloc.0
    IL_0097: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_009c: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00a1: callvirt IReadOnlyList<TaggedObject> TagManager::get_Players()  /*0x06000E54*/
    IL_00a6: ldc.i4.0
    IL_00a7: callvirt !0 System.Collections.Generic.IReadOnlyList<TaggedObject>::get_Item(int)  /*0x0A00019F*/
    IL_00ac: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_00b1: stloc.1
    IL_00b2: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00b7: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_00bc: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coin>::GetEnumerator()  /*0x0A0001A9*/
    IL_00c1: stloc.3
    IL_00c2: br.s IL_00de
    IL_00c4: ldloca.s 3
    IL_00c6: call !0 System.Collections.Generic.List.Enumerator<Coin>::get_Current()  /*0x0A0001AA*/
    IL_00cb: stloc.s 4
    IL_00cd: ldloc.s 4
    IL_00cf: callvirt bool Coin::get_IsFree()  /*0x0600033D*/
    IL_00d4: brfalse.s IL_00de
    IL_00d6: ldloc.s 4
    IL_00d8: ldloc.1
    IL_00d9: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_00de: ldloca.s 3
    IL_00e0: call bool System.Collections.Generic.List.Enumerator<Coin>::MoveNext()  /*0x0A0001AB*/
    IL_00e5: brtrue.s IL_00c4
    IL_00e7: leave.s IL_00f7
    IL_00e9: ldloca.s 3
    IL_00eb: constrained. System.Collections.Generic.List.Enumerator<Coin>  /*0x1B00003A*/
    IL_00f1: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f6: endfinally
    IL_00f7: ldc.i4.0
    IL_00f8: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_00fd: brfalse.s IL_0145
    IL_00ff: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0104: ldfld List<EnergyCore> TagManager::freeEnergyCores  /*0x04001095*/
    IL_0109: callvirt List.Enumerator<!0> System.Collections.Generic.List<EnergyCore>::GetEnumerator()  /*0x0A0001AC*/
    IL_010e: stloc.s 5
    IL_0110: br.s IL_012c
    IL_0112: ldloca.s 5
    IL_0114: call !0 System.Collections.Generic.List.Enumerator<EnergyCore>::get_Current()  /*0x0A0001AD*/
    IL_0119: stloc.s 6
    IL_011b: ldloc.s 6
    IL_011d: callvirt bool Coin::get_IsFree()  /*0x0600033D*/
    IL_0122: brfalse.s IL_012c
    IL_0124: ldloc.s 6
    IL_0126: ldloc.1
    IL_0127: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_012c: ldloca.s 5
    IL_012e: call bool System.Collections.Generic.List.Enumerator<EnergyCore>::MoveNext()  /*0x0A0001AE*/
    IL_0133: brtrue.s IL_0112
    IL_0135: leave.s IL_0145
    IL_0137: ldloca.s 5
    IL_0139: constrained. System.Collections.Generic.List.Enumerator<EnergyCore>  /*0x1B00003C*/
    IL_013f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0144: endfinally
    IL_0145: ret
    .try IL_001d-IL_004c catch System.Exception handler IL_004c-IL_0053
    .try IL_00c2-IL_00e9 finally handler IL_00e9-IL_00f7
    .try IL_0110-IL_0137 finally handler IL_0137-IL_0145

  .method DayNightCycle::DawnCallBeforeSunrise()  // token 0x060003AD rva 0x10830 attrs Private, HideBySig
    // code size 105 (0x69), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float DayNightCycle::autoDayCycleLength  /*0x040004BC*/
    IL_0007: stfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.0
    IL_000e: stfld bool DayNightCycle::afterSunrise  /*0x040004BA*/
    IL_0013: ldarg.0
    IL_0014: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0019: callvirt int System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Count()  /*0x0A0001A5*/
    IL_001e: ldc.i4.1
    IL_001f: sub
    IL_0020: stloc.0
    IL_0021: br.s IL_005e
    IL_0023: nop
    IL_0024: ldarg.0
    IL_0025: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_002a: ldloc.0
    IL_002b: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_0030: brfalse.s IL_0045
    IL_0032: ldarg.0
    IL_0033: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0038: ldloc.0
    IL_0039: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_003e: callvirt void DayNightCycle.IDaytimeSensitive::OnDawn_BeforeSunrise()  /*0x060003BB*/
    IL_0043: br.s IL_0051
    IL_0045: ldarg.0
    IL_0046: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_004b: ldloc.0
    IL_004c: callvirt void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::RemoveAt(int)  /*0x0A0001A7*/
    IL_0051: leave.s IL_005a
    IL_0053: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0058: leave.s IL_005a
    IL_005a: ldloc.0
    IL_005b: ldc.i4.1
    IL_005c: sub
    IL_005d: stloc.0
    IL_005e: ldloc.0
    IL_005f: ldc.i4.0
    IL_0060: bge.s IL_0023
    IL_0062: ldc.i4.6
    IL_0063: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0068: ret
    .try IL_0024-IL_0053 catch System.Exception handler IL_0053-IL_005a

  .method DayNightCycle::DuskCall()  // token 0x060003AE rva 0x108b8 attrs Private, HideBySig
    // code size 222 (0xde), max stack 3, init locals
    .locals ([0] List<TagManager.ETag>, [1] int, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float DayNightCycle::autoNightCycleLength  /*0x040004BF*/
    IL_0007: stfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_000c: ldarg.0
    IL_000d: ldc.i4.0
    IL_000e: stfld bool DayNightCycle::afterSunrise  /*0x040004BA*/
    IL_0013: ldarg.0
    IL_0014: ldc.r4 0f
    IL_0019: stfld float DayNightCycle::currentNightLength  /*0x040004B8*/
    IL_001e: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0023: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_0028: stloc.0
    IL_0029: dup
    IL_002a: ldc.i4.0
    IL_002b: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0030: ldloc.0
    IL_0031: ldc.i4.s 25
    IL_0033: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_0038: ldloc.0
    IL_0039: ldc.i4.0
    IL_003a: call void Hp::SetAllUnitsWithTagInvulnerable(System.Collections.Generic.List<TagManager.ETag>,System.Collections.Generic.List<TagManager.ETag>,bool)  /*0x06000831*/
    IL_003f: ldarg.0
    IL_0040: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0045: callvirt int System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Count()  /*0x0A0001A5*/
    IL_004a: ldc.i4.1
    IL_004b: sub
    IL_004c: stloc.1
    IL_004d: br.s IL_008a
    IL_004f: nop
    IL_0050: ldarg.0
    IL_0051: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0056: ldloc.1
    IL_0057: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_005c: brfalse.s IL_0071
    IL_005e: ldarg.0
    IL_005f: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0064: ldloc.1
    IL_0065: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_006a: callvirt void DayNightCycle.IDaytimeSensitive::OnDuskEarly()  /*0x060003B8*/
    IL_006f: br.s IL_007d
    IL_0071: ldarg.0
    IL_0072: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0077: ldloc.1
    IL_0078: callvirt void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::RemoveAt(int)  /*0x0A0001A7*/
    IL_007d: leave.s IL_0086
    IL_007f: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0084: leave.s IL_0086
    IL_0086: ldloc.1
    IL_0087: ldc.i4.1
    IL_0088: sub
    IL_0089: stloc.1
    IL_008a: ldloc.1
    IL_008b: ldc.i4.0
    IL_008c: bge.s IL_004f
    IL_008e: ldarg.0
    IL_008f: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0094: callvirt int System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Count()  /*0x0A0001A5*/
    IL_0099: ldc.i4.1
    IL_009a: sub
    IL_009b: stloc.2
    IL_009c: br.s IL_00d9
    IL_009e: nop
    IL_009f: ldarg.0
    IL_00a0: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_00a5: ldloc.2
    IL_00a6: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_00ab: brfalse.s IL_00c0
    IL_00ad: ldarg.0
    IL_00ae: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_00b3: ldloc.2
    IL_00b4: callvirt !0 System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::get_Item(int)  /*0x0A0001A6*/
    IL_00b9: callvirt void DayNightCycle.IDaytimeSensitive::OnDusk()  /*0x060003B9*/
    IL_00be: br.s IL_00cc
    IL_00c0: ldarg.0
    IL_00c1: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_00c6: ldloc.2
    IL_00c7: callvirt void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::RemoveAt(int)  /*0x0A0001A7*/
    IL_00cc: leave.s IL_00d5
    IL_00ce: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_00d3: leave.s IL_00d5
    IL_00d5: ldloc.2
    IL_00d6: ldc.i4.1
    IL_00d7: sub
    IL_00d8: stloc.2
    IL_00d9: ldloc.2
    IL_00da: ldc.i4.0
    IL_00db: bge.s IL_009e
    IL_00dd: ret
    .try IL_0050-IL_007f catch System.Exception handler IL_007f-IL_0086
    .try IL_009f-IL_00ce catch System.Exception handler IL_00ce-IL_00d5

  .method DayNightCycle::ToggleDaytime()  // token 0x060003AF rva 0x109c0 attrs Public, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0006: brtrue.s IL_0017
    IL_0008: ldarg.0
    IL_0009: ldc.i4.1
    IL_000a: stfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_000f: ldarg.0
    IL_0010: call void DayNightCycle::DuskCall()  /*0x060003AE*/
    IL_0015: br.s IL_002a
    IL_0017: ldarg.0
    IL_0018: ldc.i4.0
    IL_0019: stfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_001e: ldarg.0
    IL_001f: call void DayNightCycle::DawnCallBeforeSunrise()  /*0x060003AD*/
    IL_0024: ldarg.0
    IL_0025: call void DayNightCycle::DawnCallAfterSunrise()  /*0x060003AC*/
    IL_002a: ldarg.0
    IL_002b: ldfld UnityEvent DayNightCycle::OnTimeChange  /*0x040004C1*/
    IL_0030: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0035: ret

  .method DayNightCycle::SwitchToDayCoroutine()  // token 0x060003B0 rva 0x109f7 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DayNightCycle.<SwitchToDayCoroutine>d__40::.ctor(int)  /*0x060003BC*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DayNightCycle DayNightCycle.<SwitchToDayCoroutine>d__40::<>4__this  /*0x040004C8*/
    IL_000d: ret

  .method DayNightCycle::SwitchToNight()  // token 0x060003B1 rva 0x10a06 attrs Public, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0006: ldc.i4.1
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldc.i4.1
    IL_000c: stfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0011: ldarg.0
    IL_0012: ldfld UnityEvent DayNightCycle::OnTimeChange  /*0x040004C1*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_001c: ldarg.0
    IL_001d: call void DayNightCycle::DuskCall()  /*0x060003AE*/
    IL_0022: ret

  .method DayNightCycle::SwithToDay()  // token 0x060003B2 rva 0x10a2a attrs Public, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call IEnumerator DayNightCycle::SwitchToDayCoroutine()  /*0x060003B0*/
    IL_0010: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0015: pop
    IL_0016: ret

  .method DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  // token 0x060003B3 rva 0x10a42 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0006: ldarg.1
    IL_0007: callvirt void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::Add(!0)  /*0x0A0001AF*/
    IL_000c: ret

  .method DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  // token 0x060003B4 rva 0x10a50 attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0006: ldarg.1
    IL_0007: callvirt bool System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::Remove(!0)  /*0x0A0001B0*/
    IL_000c: pop
    IL_000d: ret

  .method DayNightCycle::SetToAutoDayLength(float)  // token 0x060003B5 rva 0x10a5f attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float DayNightCycle::autoDayCycleLength  /*0x040004BC*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld float DayNightCycle::remainingAutoDayTime  /*0x040004BD*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.1
    IL_0010: stfld bool DayNightCycle::automatedDaytime  /*0x040004BB*/
    IL_0015: ret

  .method DayNightCycle::SetToAutoNightLength(float)  // token 0x060003B6 rva 0x10a76 attrs Public, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float DayNightCycle::autoNightCycleLength  /*0x040004BF*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: stfld float DayNightCycle::remainingAutoNightTime  /*0x040004C0*/
    IL_000e: ldarg.0
    IL_000f: ldc.i4.1
    IL_0010: stfld bool DayNightCycle::automatedNighttime  /*0x040004BE*/
    IL_0015: ret

  .method DayNightCycle::.ctor()  // token 0x060003B7 rva 0x10a8d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 47 (0x2f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2.5f
    IL_0006: stfld float DayNightCycle::sunriseTime  /*0x040004B6*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<DayNightCycle.IDaytimeSensitive>::.ctor()  /*0x0A0001B1*/
    IL_0011: stfld List<DayNightCycle.IDaytimeSensitive> DayNightCycle::daytimeSensitiveObjects  /*0x040004B9*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool DayNightCycle::afterSunrise  /*0x040004BA*/
    IL_001d: ldarg.0
    IL_001e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0023: stfld UnityEvent DayNightCycle::OnTimeChange  /*0x040004C1*/
    IL_0028: ldarg.0
    IL_0029: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_002e: ret

// ===== DayNightCycle/IDaytimeSensitive  (token 0x020000AB) =====
  .method DayNightCycle.IDaytimeSensitive::OnDuskEarly()  // token 0x060003B8 rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method DayNightCycle.IDaytimeSensitive::OnDusk()  // token 0x060003B9 rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method DayNightCycle.IDaytimeSensitive::OnDawn_AfterSunrise()  // token 0x060003BA rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method DayNightCycle.IDaytimeSensitive::OnDawn_BeforeSunrise()  // token 0x060003BB rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

// ===== DayNightCycle/Timestate  (token 0x020000AC) =====
// ===== DayNightCycle/<SwitchToDayCoroutine>d__40  (token 0x020000AD) =====
  .method DayNightCycle.<SwitchToDayCoroutine>d__40::.ctor(int)  // token 0x060003BC rva 0x10abd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DayNightCycle.<SwitchToDayCoroutine>d__40::<>1__state  /*0x040004C6*/
    IL_000d: ret

  .method DayNightCycle.<SwitchToDayCoroutine>d__40::System.IDisposable.Dispose()  // token 0x060003BD rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DayNightCycle.<SwitchToDayCoroutine>d__40::MoveNext()  // token 0x060003BE rva 0x10acc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 171 (0xab), max stack 4, init locals
    .locals ([0] int, [1] DayNightCycle)
    IL_0000: ldarg.0
    IL_0001: ldfld int DayNightCycle.<SwitchToDayCoroutine>d__40::<>1__state  /*0x040004C6*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DayNightCycle DayNightCycle.<SwitchToDayCoroutine>d__40::<>4__this  /*0x040004C8*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0060
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int DayNightCycle.<SwitchToDayCoroutine>d__40::<>1__state  /*0x040004C6*/
    IL_001e: ldloc.1
    IL_001f: ldfld bool DayNightCycle::currentlySwitchingToDay  /*0x040004C2*/
    IL_0024: brtrue IL_00a9
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool DayNightCycle::currentlySwitchingToDay  /*0x040004C2*/
    IL_0030: ldloc.1
    IL_0031: ldfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0036: ldc.i4.1
    IL_0037: bne.un.s IL_00a2
    IL_0039: ldloc.1
    IL_003a: ldc.i4.0
    IL_003b: stfld DayNightCycle.Timestate DayNightCycle::currentTimestate  /*0x040004B7*/
    IL_0040: ldloc.1
    IL_0041: call void DayNightCycle::DawnCallBeforeSunrise()  /*0x060003AD*/
    IL_0046: ldarg.0
    IL_0047: ldloc.1
    IL_0048: ldfld float DayNightCycle::sunriseTime  /*0x040004B6*/
    IL_004d: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0052: stfld object DayNightCycle.<SwitchToDayCoroutine>d__40::<>2__current  /*0x040004C7*/
    IL_0057: ldarg.0
    IL_0058: ldc.i4.1
    IL_0059: stfld int DayNightCycle.<SwitchToDayCoroutine>d__40::<>1__state  /*0x040004C6*/
    IL_005e: ldc.i4.1
    IL_005f: ret
    IL_0060: ldarg.0
    IL_0061: ldc.i4.m1
    IL_0062: stfld int DayNightCycle.<SwitchToDayCoroutine>d__40::<>1__state  /*0x040004C6*/
    IL_0067: ldloc.1
    IL_0068: call void DayNightCycle::DawnCallAfterSunrise()  /*0x060003AC*/
    IL_006d: ldloc.1
    IL_006e: ldfld UnityEvent DayNightCycle::OnTimeChange  /*0x040004C1*/
    IL_0073: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0078: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_007d: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0082: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0087: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_008c: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0091: ldc.i4.1
    IL_0092: sub
    IL_0093: blt.s IL_00a2
    IL_0095: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_009a: ldc.i4.2
    IL_009b: ldc.i4.0
    IL_009c: ldc.i4.0
    IL_009d: callvirt void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_00a2: ldloc.1
    IL_00a3: ldc.i4.0
    IL_00a4: stfld bool DayNightCycle::currentlySwitchingToDay  /*0x040004C2*/
    IL_00a9: ldc.i4.0
    IL_00aa: ret

  .method DayNightCycle.<SwitchToDayCoroutine>d__40::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060003BF rva 0x10b83 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DayNightCycle.<SwitchToDayCoroutine>d__40::<>2__current  /*0x040004C7*/
    IL_0006: ret

  .method DayNightCycle.<SwitchToDayCoroutine>d__40::System.Collections.IEnumerator.Reset()  // token 0x060003C0 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DayNightCycle.<SwitchToDayCoroutine>d__40::System.Collections.IEnumerator.get_Current()  // token 0x060003C1 rva 0x10b83 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DayNightCycle.<SwitchToDayCoroutine>d__40::<>2__current  /*0x040004C7*/
    IL_0006: ret

