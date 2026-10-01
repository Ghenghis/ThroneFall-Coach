// ===== Nighthorn  (token 0x020001FE) =====
  .method Nighthorn::Awake()  // token 0x06000A9D rva 0x32d0b attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Nighthorn Nighthorn::instance  /*0x04000D7D*/
    IL_0006: ret

  .method Nighthorn::ReturnTooltip()  // token 0x06000A9E rva 0x32d14 attrs Public, Virtual, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call bool Nighthorn::get_AllCoinsHarvested()  /*0x06000AA7*/
    IL_0006: brtrue.s IL_000f
    IL_0008: ldarg.0
    IL_0009: ldfld string Nighthorn::autoCollectGoldTooltip  /*0x04000D80*/
    IL_000e: ret
    IL_000f: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0014: callvirt bool EnemySpawner::get_PreFinalWaveComingUp()  /*0x06000674*/
    IL_0019: brfalse.s IL_0022
    IL_001b: ldarg.0
    IL_001c: ldfld string Nighthorn::startPreFinalNightTooltip  /*0x04000D82*/
    IL_0021: ret
    IL_0022: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0027: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002c: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0031: callvirt bool EnemySpawner::FinalWaveComingUp(int)  /*0x06000673*/
    IL_0036: brfalse.s IL_003f
    IL_0038: ldarg.0
    IL_0039: ldfld string Nighthorn::startFinalNightTooltip  /*0x04000D83*/
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldfld string Nighthorn::startNightTooltip  /*0x04000D81*/
    IL_0045: ret

  .method Nighthorn::Start()  // token 0x06000A9F rva 0x32d66 attrs Private, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_0011: stfld TutorialManager Nighthorn::tutorialManager  /*0x04000D85*/
    IL_0016: ret

  .method Nighthorn::InteractionBegin(PlayerInteraction)  // token 0x06000AA0 rva 0x32d80 attrs Public, Virtual, HideBySig
    // code size 180 (0xb4), max stack 2, init locals
    .locals ([0] List.Enumerator<BuildingInteractor>, [1] List.Enumerator<Coin>, [2] Coin)
    IL_0000: ldarg.0
    IL_0001: ldfld TutorialManager Nighthorn::tutorialManager  /*0x04000D85*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0015
    IL_000d: call bool TutorialManager::get_AllowStartingTheNight()  /*0x06000F1C*/
    IL_0012: brtrue.s IL_0015
    IL_0014: ret
    IL_0015: ldarg.0
    IL_0016: call bool Nighthorn::get_AllCoinsHarvested()  /*0x06000AA7*/
    IL_001b: brfalse.s IL_0033
    IL_001d: ldarg.0
    IL_001e: ldfld MMF_Player Nighthorn::onBlowFeedback  /*0x04000D84*/
    IL_0023: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0028: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_002d: callvirt void DayNightCycle::SwitchToNight()  /*0x060003B1*/
    IL_0032: ret
    IL_0033: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0038: ldfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_003d: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildingInteractor>::GetEnumerator()  /*0x0A0001A2*/
    IL_0042: stloc.0
    IL_0043: br.s IL_0052
    IL_0045: ldloca.s 0
    IL_0047: call !0 System.Collections.Generic.List.Enumerator<BuildingInteractor>::get_Current()  /*0x0A0001A3*/
    IL_004c: ldarg.1
    IL_004d: callvirt void BuildingInteractor::Harvest(PlayerInteraction)  /*0x06000BBC*/
    IL_0052: ldloca.s 0
    IL_0054: call bool System.Collections.Generic.List.Enumerator<BuildingInteractor>::MoveNext()  /*0x0A0001A4*/
    IL_0059: brtrue.s IL_0045
    IL_005b: leave.s IL_006b
    IL_005d: ldloca.s 0
    IL_005f: constrained. System.Collections.Generic.List.Enumerator<BuildingInteractor>  /*0x1B000038*/
    IL_0065: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006a: endfinally
    IL_006b: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0070: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_0075: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coin>::GetEnumerator()  /*0x0A0001A9*/
    IL_007a: stloc.1
    IL_007b: br.s IL_0094
    IL_007d: ldloca.s 1
    IL_007f: call !0 System.Collections.Generic.List.Enumerator<Coin>::get_Current()  /*0x0A0001AA*/
    IL_0084: stloc.2
    IL_0085: ldloc.2
    IL_0086: callvirt bool Coin::get_IsFree()  /*0x0600033D*/
    IL_008b: brfalse.s IL_0094
    IL_008d: ldloc.2
    IL_008e: ldarg.1
    IL_008f: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_0094: ldloca.s 1
    IL_0096: call bool System.Collections.Generic.List.Enumerator<Coin>::MoveNext()  /*0x0A0001AB*/
    IL_009b: brtrue.s IL_007d
    IL_009d: leave.s IL_00ad
    IL_009f: ldloca.s 1
    IL_00a1: constrained. System.Collections.Generic.List.Enumerator<Coin>  /*0x1B00003A*/
    IL_00a7: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00ac: endfinally
    IL_00ad: ldarg.0
    IL_00ae: call void Nighthorn::ActivateAndRefreshCues()  /*0x06000AA8*/
    IL_00b3: ret
    .try IL_0043-IL_005d finally handler IL_005d-IL_006b
    .try IL_007b-IL_009f finally handler IL_009f-IL_00ad

  .method Nighthorn::OnDawn_AfterSunrise()  // token 0x06000AA1 rva 0x32e5c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method Nighthorn::OnDusk()  // token 0x06000AA2 rva 0x32e6a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: call void Nighthorn::DeactivateCues()  /*0x06000AA9*/
    IL_0012: ret

  .method Nighthorn::Focus(PlayerInteraction)  // token 0x06000AA3 rva 0x32e7e attrs Public, Virtual, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Nighthorn::ActivateAndRefreshCues()  /*0x06000AA8*/
    IL_0006: ret

  .method Nighthorn::Unfocus(PlayerInteraction)  // token 0x06000AA4 rva 0x32e86 attrs Public, Virtual, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Nighthorn::DeactivateCues()  /*0x06000AA9*/
    IL_0006: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_000b: callvirt void EnemySpawner::EnemySpawnersHornUnFocussed()  /*0x06000681*/
    IL_0010: ret

  .method Nighthorn::OnDawn_BeforeSunrise()  // token 0x06000AA5 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Nighthorn::get_CoinCountToBeHarvested()  // token 0x06000AA6 rva 0x32e98 attrs Public, HideBySig, SpecialName
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

  .method Nighthorn::get_AllCoinsHarvested()  // token 0x06000AA7 rva 0x32f18 attrs Public, HideBySig, SpecialName
    // code size 126 (0x7e), max stack 1, init locals
    .locals ([0] bool, [1] List.Enumerator<BuildingInteractor>, [2] List.Enumerator<Coin>)
    IL_0000: ldc.i4.1
    IL_0001: stloc.0
    IL_0002: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0007: ldfld List<BuildingInteractor> TagManager::playerBuildingInteractors  /*0x04001092*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildingInteractor>::GetEnumerator()  /*0x0A0001A2*/
    IL_0011: stloc.1
    IL_0012: br.s IL_0026
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<BuildingInteractor>::get_Current()  /*0x0A0001A3*/
    IL_001b: callvirt bool BuildingInteractor::get_canBeHarvested()  /*0x06000BA5*/
    IL_0020: brfalse.s IL_0026
    IL_0022: ldc.i4.0
    IL_0023: stloc.0
    IL_0024: leave.s IL_003f
    IL_0026: ldloca.s 1
    IL_0028: call bool System.Collections.Generic.List.Enumerator<BuildingInteractor>::MoveNext()  /*0x0A0001A4*/
    IL_002d: brtrue.s IL_0014
    IL_002f: leave.s IL_003f
    IL_0031: ldloca.s 1
    IL_0033: constrained. System.Collections.Generic.List.Enumerator<BuildingInteractor>  /*0x1B000038*/
    IL_0039: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003e: endfinally
    IL_003f: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0044: ldfld List<Coin> TagManager::freeCoins  /*0x04001093*/
    IL_0049: callvirt List.Enumerator<!0> System.Collections.Generic.List<Coin>::GetEnumerator()  /*0x0A0001A9*/
    IL_004e: stloc.2
    IL_004f: br.s IL_0063
    IL_0051: ldloca.s 2
    IL_0053: call !0 System.Collections.Generic.List.Enumerator<Coin>::get_Current()  /*0x0A0001AA*/
    IL_0058: callvirt bool Coin::get_IsFree()  /*0x0600033D*/
    IL_005d: brfalse.s IL_0063
    IL_005f: ldc.i4.0
    IL_0060: stloc.0
    IL_0061: leave.s IL_007c
    IL_0063: ldloca.s 2
    IL_0065: call bool System.Collections.Generic.List.Enumerator<Coin>::MoveNext()  /*0x0A0001AB*/
    IL_006a: brtrue.s IL_0051
    IL_006c: leave.s IL_007c
    IL_006e: ldloca.s 2
    IL_0070: constrained. System.Collections.Generic.List.Enumerator<Coin>  /*0x1B00003A*/
    IL_0076: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007b: endfinally
    IL_007c: ldloc.0
    IL_007d: ret
    .try IL_0012-IL_0031 finally handler IL_0031-IL_003f
    .try IL_004f-IL_006e finally handler IL_006e-IL_007c

  .method Nighthorn::ActivateAndRefreshCues()  // token 0x06000AA8 rva 0x32fc0 attrs Public, HideBySig
    // code size 68 (0x44), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call bool Nighthorn::get_AllCoinsHarvested()  /*0x06000AA7*/
    IL_0006: brfalse.s IL_002b
    IL_0008: ldarg.0
    IL_0009: ldfld GameObject Nighthorn::nightCue  /*0x04000D7E*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldarg.0
    IL_0015: ldfld GameObject Nighthorn::harvestCue  /*0x04000D7F*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0025: callvirt void EnemySpawner::EnemySpawnersHornFocussed()  /*0x06000680*/
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldfld GameObject Nighthorn::nightCue  /*0x04000D7E*/
    IL_0031: ldc.i4.0
    IL_0032: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0037: ldarg.0
    IL_0038: ldfld GameObject Nighthorn::harvestCue  /*0x04000D7F*/
    IL_003d: ldc.i4.1
    IL_003e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0043: ret

  .method Nighthorn::DeactivateCues()  // token 0x06000AA9 rva 0x33010 attrs Public, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Nighthorn::nightCue  /*0x04000D7E*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld GameObject Nighthorn::harvestCue  /*0x04000D7F*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0018: ret

  .method Nighthorn::OnDuskEarly()  // token 0x06000AAA rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method Nighthorn::.ctor()  // token 0x06000AAB rva 0x2743 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0006: ret

