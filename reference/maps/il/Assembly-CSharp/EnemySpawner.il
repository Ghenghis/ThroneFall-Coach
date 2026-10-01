// ===== EnemySpawner  (token 0x02000136) =====
  .method EnemySpawner::get_SpawningInProgress()  // token 0x0600066C rva 0x1aeff attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0006: ret

  .method EnemySpawner::get_WaveCount()  // token 0x0600066D rva 0x1af07 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0006: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_000b: ret

  .method EnemySpawner::get_Wavenumber()  // token 0x0600066E rva 0x1af14 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0006: ret

  .method EnemySpawner::get_MatchOver()  // token 0x0600066F rva 0x1af1c attrs Public, HideBySig, SpecialName
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_000c: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0011: ldc.i4.1
    IL_0012: sub
    IL_0013: blt.s IL_001f
    IL_0015: ldarg.0
    IL_0016: call bool EnemySpawner::get_SpawningInProgress()  /*0x0600066C*/
    IL_001b: ldc.i4.0
    IL_001c: ceq
    IL_001e: ret
    IL_001f: ldc.i4.0
    IL_0020: ret

  .method EnemySpawner::get_LevelBeatenAsSoonAsWaveFinished()  // token 0x06000670 rva 0x1af3e attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_000c: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0011: ldc.i4.2
    IL_0012: sub
    IL_0013: cgt
    IL_0015: ret

  .method EnemySpawner::TwoWavesBeforeFinalWaveComingUp(int)  // token 0x06000671 rva 0x1af55 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0007: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_000c: ldc.i4.4
    IL_000d: sub
    IL_000e: ceq
    IL_0010: ret

  .method EnemySpawner::WaveBeforeFinalWaveComingUp(int)  // token 0x06000672 rva 0x1af67 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0007: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_000c: ldc.i4.3
    IL_000d: sub
    IL_000e: ceq
    IL_0010: ret

  .method EnemySpawner::FinalWaveComingUp(int)  // token 0x06000673 rva 0x1af79 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0007: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_000c: ldc.i4.2
    IL_000d: sub
    IL_000e: ceq
    IL_0010: ret

  .method EnemySpawner::get_PreFinalWaveComingUp()  // token 0x06000674 rva 0x1af8b attrs Public, HideBySig, SpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_000c: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0011: ldc.i4.3
    IL_0012: sub
    IL_0013: ceq
    IL_0015: ret

  .method EnemySpawner::get_LastSpawnPeriodDuration()  // token 0x06000675 rva 0x1afa2 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EnemySpawner::lastSpawnPeriodDuration  /*0x040007CE*/
    IL_0006: ret

  .method EnemySpawner::get_LastSpawnPeriodClock()  // token 0x06000676 rva 0x1afaa attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EnemySpawner::lastSpawnPeriodClock  /*0x040007CF*/
    IL_0006: ret

  .method EnemySpawner::get_InfinitelySpawning()  // token 0x06000677 rva 0x1afb2 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnemySpawner::<InfinitelySpawning>k__BackingField  /*0x040007D2*/
    IL_0006: ret

  .method EnemySpawner::set_InfinitelySpawning(bool)  // token 0x06000678 rva 0x1afba attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool EnemySpawner::<InfinitelySpawning>k__BackingField  /*0x040007D2*/
    IL_0007: ret

  .method EnemySpawner::get_isInClassicMode()  // token 0x06000679 rva 0x1afc3 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode EnemySpawner::currentMode  /*0x040007C4*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method EnemySpawner::get_isInEternalTrialMode()  // token 0x0600067A rva 0x1afce attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.GameMode EnemySpawner::currentMode  /*0x040007C4*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method EnemySpawner::get_NumberOfEnemiesOnTheMap()  // token 0x0600067B rva 0x1afd9 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int EnemySpawner::numberOfEnemiesOnTheMap  /*0x040007D4*/
    IL_0006: ret

  .method EnemySpawner::Refresh()  // token 0x0600067C rva 0x1afe1 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EnemySpawner::DestroyMarkers()  /*0x0600068E*/
    IL_0006: ldarg.0
    IL_0007: call void EnemySpawner::PlaceMarkersForNextWave()  /*0x0600068B*/
    IL_000c: ret

  .method EnemySpawner::GetValidSpawnPointForEnemy(bool,bool,UnityEngine.Vector3)  // token 0x0600067D rva 0x1aff0 attrs Public, Static, HideBySig
    // code size 59 (0x3b), max stack 3, init locals
    .locals ([0] NNConstraint)
    IL_0000: ldarg.0
    IL_0001: brtrue.s IL_001e
    IL_0003: ldarg.1
    IL_0004: brtrue.s IL_0012
    IL_0006: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_000b: ldfld NNConstraint EnemySpawner::groundConstraint  /*0x040007DD*/
    IL_0010: br.s IL_0028
    IL_0012: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0017: ldfld NNConstraint EnemySpawner::flyingConstraint  /*0x040007DC*/
    IL_001c: br.s IL_0028
    IL_001e: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0023: ldfld NNConstraint EnemySpawner::groundConstraintLarge  /*0x040007DE*/
    IL_0028: stloc.0
    IL_0029: ldsfld AstarPath AstarPath::active  /*0x0A000260*/
    IL_002e: ldarg.2
    IL_002f: ldloc.0
    IL_0030: callvirt NNInfo AstarPath::GetNearest(UnityEngine.Vector3,Pathfinding.NNConstraint)  /*0x0A000262*/
    IL_0035: ldfld Vector3 Pathfinding.NNInfo::position  /*0x0A00028D*/
    IL_003a: ret

  .method EnemySpawner::OnDuskEarly()  // token 0x0600067E rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EnemySpawner::DebugSkipWave()  // token 0x0600067F rva 0x1b037 attrs Public, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void EnemySpawner::DestroyMarkers()  /*0x0600068E*/
    IL_000f: ldarg.0
    IL_0010: ldarg.0
    IL_0011: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0016: ldc.i4.1
    IL_0017: add
    IL_0018: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_001d: ldarg.0
    IL_001e: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0023: ldarg.0
    IL_0024: call int EnemySpawner::get_WaveCount()  /*0x0600066D*/
    IL_0029: blt.s IL_0032
    IL_002b: ldarg.0
    IL_002c: ldc.i4.m1
    IL_002d: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0032: ldarg.0
    IL_0033: call void EnemySpawner::PlaceMarkersForNextWave()  /*0x0600068B*/
    IL_0038: ret

  .method EnemySpawner::EnemySpawnersHornFocussed()  // token 0x06000680 rva 0x1b074 attrs Public, HideBySig
    // code size 263 (0x107), max stack 2, init locals
    .locals ([0] int, [1] int, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TutorialManager EnemySpawner::tutorialManager  /*0x040007C3*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse IL_0092
    IL_0010: ldarg.0
    IL_0011: ldfld TutorialManager EnemySpawner::tutorialManager  /*0x040007C3*/
    IL_0016: callvirt bool TutorialManager::get_MayShowEnemySpawn()  /*0x06000F1D*/
    IL_001b: brtrue.s IL_0092
    IL_001d: ldc.i4.0
    IL_001e: stloc.0
    IL_001f: br.s IL_0049
    IL_0021: ldarg.0
    IL_0022: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0027: ldloc.0
    IL_0028: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_002d: ldc.i4.0
    IL_002e: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0039: ldloc.0
    IL_003a: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_003f: ldc.i4.0
    IL_0040: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_0045: ldloc.0
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.0
    IL_0049: ldloc.0
    IL_004a: ldarg.0
    IL_004b: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0050: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0055: blt.s IL_0021
    IL_0057: ldc.i4.0
    IL_0058: stloc.1
    IL_0059: br.s IL_0083
    IL_005b: ldarg.0
    IL_005c: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_0061: ldloc.1
    IL_0062: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0067: ldc.i4.0
    IL_0068: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_006d: ldarg.0
    IL_006e: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_0073: ldloc.1
    IL_0074: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0079: ldc.i4.0
    IL_007a: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_007f: ldloc.1
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.1
    IL_0083: ldloc.1
    IL_0084: ldarg.0
    IL_0085: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_008a: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_008f: blt.s IL_005b
    IL_0091: ret
    IL_0092: ldc.i4.0
    IL_0093: stloc.2
    IL_0094: br.s IL_00be
    IL_0096: ldarg.0
    IL_0097: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_009c: ldloc.2
    IL_009d: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00a2: ldc.i4.1
    IL_00a3: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00ae: ldloc.2
    IL_00af: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00b4: ldc.i4.1
    IL_00b5: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_00ba: ldloc.2
    IL_00bb: ldc.i4.1
    IL_00bc: add
    IL_00bd: stloc.2
    IL_00be: ldloc.2
    IL_00bf: ldarg.0
    IL_00c0: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00c5: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00ca: blt.s IL_0096
    IL_00cc: ldc.i4.0
    IL_00cd: stloc.3
    IL_00ce: br.s IL_00f8
    IL_00d0: ldarg.0
    IL_00d1: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00d6: ldloc.3
    IL_00d7: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00dc: ldc.i4.0
    IL_00dd: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00e8: ldloc.3
    IL_00e9: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00ee: ldc.i4.0
    IL_00ef: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_00f4: ldloc.3
    IL_00f5: ldc.i4.1
    IL_00f6: add
    IL_00f7: stloc.3
    IL_00f8: ldloc.3
    IL_00f9: ldarg.0
    IL_00fa: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00ff: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0104: blt.s IL_00d0
    IL_0106: ret

  .method EnemySpawner::EnemySpawnersHornUnFocussed()  // token 0x06000681 rva 0x1b188 attrs Public, HideBySig
    // code size 263 (0x107), max stack 2, init locals
    .locals ([0] int, [1] int, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld TutorialManager EnemySpawner::tutorialManager  /*0x040007C3*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse IL_0092
    IL_0010: ldarg.0
    IL_0011: ldfld TutorialManager EnemySpawner::tutorialManager  /*0x040007C3*/
    IL_0016: callvirt bool TutorialManager::get_MayShowEnemySpawn()  /*0x06000F1D*/
    IL_001b: brtrue.s IL_0092
    IL_001d: ldc.i4.0
    IL_001e: stloc.0
    IL_001f: br.s IL_0049
    IL_0021: ldarg.0
    IL_0022: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0027: ldloc.0
    IL_0028: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_002d: ldc.i4.0
    IL_002e: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_0033: ldarg.0
    IL_0034: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0039: ldloc.0
    IL_003a: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_003f: ldc.i4.0
    IL_0040: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_0045: ldloc.0
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.0
    IL_0049: ldloc.0
    IL_004a: ldarg.0
    IL_004b: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0050: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0055: blt.s IL_0021
    IL_0057: ldc.i4.0
    IL_0058: stloc.1
    IL_0059: br.s IL_0083
    IL_005b: ldarg.0
    IL_005c: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_0061: ldloc.1
    IL_0062: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0067: ldc.i4.0
    IL_0068: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_006d: ldarg.0
    IL_006e: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_0073: ldloc.1
    IL_0074: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0079: ldc.i4.0
    IL_007a: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_007f: ldloc.1
    IL_0080: ldc.i4.1
    IL_0081: add
    IL_0082: stloc.1
    IL_0083: ldloc.1
    IL_0084: ldarg.0
    IL_0085: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_008a: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_008f: blt.s IL_005b
    IL_0091: ret
    IL_0092: ldc.i4.0
    IL_0093: stloc.2
    IL_0094: br.s IL_00be
    IL_0096: ldarg.0
    IL_0097: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_009c: ldloc.2
    IL_009d: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00a2: ldc.i4.1
    IL_00a3: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00ae: ldloc.2
    IL_00af: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00b4: ldc.i4.1
    IL_00b5: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_00ba: ldloc.2
    IL_00bb: ldc.i4.1
    IL_00bc: add
    IL_00bd: stloc.2
    IL_00be: ldloc.2
    IL_00bf: ldarg.0
    IL_00c0: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00c5: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_00ca: blt.s IL_0096
    IL_00cc: ldc.i4.0
    IL_00cd: stloc.3
    IL_00ce: br.s IL_00f8
    IL_00d0: ldarg.0
    IL_00d1: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00d6: ldloc.3
    IL_00d7: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00dc: ldc.i4.0
    IL_00dd: stfld bool ScreenMarker::showWhenOnScreen  /*0x04000FC1*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00e8: ldloc.3
    IL_00e9: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00ee: ldc.i4.0
    IL_00ef: stfld bool ScreenMarker::showWhenOffScreen  /*0x04000FC2*/
    IL_00f4: ldloc.3
    IL_00f5: ldc.i4.1
    IL_00f6: add
    IL_00f7: stloc.3
    IL_00f8: ldloc.3
    IL_00f9: ldarg.0
    IL_00fa: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_00ff: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0104: blt.s IL_00d0
    IL_0106: ret

  .method EnemySpawner::OnBeforeMainLoadPass(string)  // token 0x06000682 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EnemySpawner::OnAfterMainLoadPass(string)  // token 0x06000683 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EnemySpawner::OnLoad(string)  // token 0x06000684 rva 0x1b29b attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_0007: ldarg.0
    IL_0008: ldarg.1
    IL_0009: ldstr "wavenumber"
    IL_000e: ldarg.0
    IL_000f: ldflda int EnemySpawner::wavenumberLoadedFromSave  /*0x040007CD*/
    IL_0014: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0019: stfld bool EnemySpawner::loadedBalanceFromSave  /*0x040007C6*/
    IL_001e: ldarg.0
    IL_001f: ldc.i4.1
    IL_0020: stfld bool EnemySpawner::loadedFromSave  /*0x040007D3*/
    IL_0025: ret

  .method EnemySpawner::OnSave(string)  // token 0x06000685 rva 0x1b2c2 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "wavenumber"
    IL_0006: ldarg.0
    IL_0007: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ldarg.1
    IL_0012: ldstr "endlessSeed"
    IL_0017: ldarg.0
    IL_0018: ldfld int EnemySpawner::endlessSeed  /*0x040007D8*/
    IL_001d: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0022: ret

  .method EnemySpawner::Awake()  // token 0x06000686 rva 0x1b2e6 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0006: ret

  .method EnemySpawner::Start()  // token 0x06000687 rva 0x1b2f0 attrs Private, HideBySig
    // code size 1447 (0x5a7), max stack 8, init locals
    .locals ([0] LevelData, [1] Scene, [2] LevelInfo, [3] LevelInfo, [4] int, [5] List.Enumerator<Wave>, [6] List.Enumerator<Spawn>, [7] Spawn, [8] float, [9] Spawn, [10] float, [11] int, [12] int, [13] int, [14] PlayerMovement[], [15] int, [16] int)
    IL_0000: ldarg.0
    IL_0001: ldfld NNConstraint EnemySpawner::flyingConstraint  /*0x040007DC*/
    IL_0006: ldstr "Enemy Units Air"
    IL_000b: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_0010: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_0015: ldarg.0
    IL_0016: ldfld NNConstraint EnemySpawner::groundConstraint  /*0x040007DD*/
    IL_001b: ldstr "Enemy Units S"
    IL_0020: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_0025: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_002a: ldarg.0
    IL_002b: ldfld NNConstraint EnemySpawner::groundConstraintLarge  /*0x040007DE*/
    IL_0030: ldstr "Enemy Units L"
    IL_0035: call GraphMask Pathfinding.GraphMask::FromGraphName(string)  /*0x0A000290*/
    IL_003a: stfld GraphMask Pathfinding.NNConstraint::graphMask  /*0x0A000291*/
    IL_003f: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0044: stloc.1
    IL_0045: ldloca.s 1
    IL_0047: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_004c: pop
    IL_004d: ldarg.0
    IL_004e: ldfld int EnemySpawner::pauseSpawningAtEnemyCount  /*0x040007D5*/
    IL_0053: ldc.i4 200
    IL_0058: ble.s IL_0065
    IL_005a: ldarg.0
    IL_005b: ldc.i4 200
    IL_0060: stfld int EnemySpawner::pauseSpawningAtEnemyCount  /*0x040007D5*/
    IL_0065: call bool LocalGamestate::get_GameModeSet()  /*0x060008FC*/
    IL_006a: brfalse.s IL_0079
    IL_006c: ldarg.0
    IL_006d: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0072: stfld LocalGamestate.GameMode EnemySpawner::currentMode  /*0x040007C4*/
    IL_0077: br.s IL_0084
    IL_0079: ldarg.0
    IL_007a: ldfld LocalGamestate.GameMode EnemySpawner::currentMode  /*0x040007C4*/
    IL_007f: call void LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  /*0x060008FB*/
    IL_0084: ldarg.0
    IL_0085: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_008a: stfld PerkManager EnemySpawner::perkManager  /*0x040007C0*/
    IL_008f: ldarg.0
    IL_0090: ldsfld EnemySpawnManager EnemySpawnManager::instance  /*0x04000B9E*/
    IL_0095: stfld EnemySpawnManager EnemySpawner::enemySpawnManager  /*0x040007C1*/
    IL_009a: ldarg.0
    IL_009b: ldsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_00a0: stfld TutorialManager EnemySpawner::tutorialManager  /*0x040007C3*/
    IL_00a5: ldarg.0
    IL_00a6: call void EnemySpawner::EnemySpawnersHornUnFocussed()  /*0x06000681*/
    IL_00ab: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_00b0: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b5: brfalse.s IL_00c2
    IL_00b7: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_00bc: ldarg.0
    IL_00bd: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_00c2: ldarg.0
    IL_00c3: ldc.i4.0
    IL_00c4: stfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_00c9: ldarg.0
    IL_00ca: ldc.i4.m1
    IL_00cb: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_00d0: ldarg.0
    IL_00d1: call bool EnemySpawner::get_isInClassicMode()  /*0x06000679*/
    IL_00d6: brfalse.s IL_00f7
    IL_00d8: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_00dd: callvirt int DebugController::get_StartGameInWave()  /*0x060003CF*/
    IL_00e2: ldc.i4.m1
    IL_00e3: beq.s IL_00f7
    IL_00e5: ldarg.0
    IL_00e6: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_00eb: callvirt int DebugController::get_StartGameInWave()  /*0x060003CF*/
    IL_00f0: ldc.i4.1
    IL_00f1: sub
    IL_00f2: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_00f7: ldarg.0
    IL_00f8: ldfld int EnemySpawner::wavenumberLoadedFromSave  /*0x040007CD*/
    IL_00fd: ldc.i4.m1
    IL_00fe: beq.s IL_010c
    IL_0100: ldarg.0
    IL_0101: ldarg.0
    IL_0102: ldfld int EnemySpawner::wavenumberLoadedFromSave  /*0x040007CD*/
    IL_0107: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_010c: ldarg.0
    IL_010d: call bool EnemySpawner::get_isInEternalTrialMode()  /*0x0600067A*/
    IL_0112: brfalse.s IL_017d
    IL_0114: ldarg.0
    IL_0115: ldfld EternalWaveGenerator EnemySpawner::waveGeneratorScript  /*0x040007C8*/
    IL_011a: ldnull
    IL_011b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0120: brfalse.s IL_017d
    IL_0122: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0127: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_012c: stloc.2
    IL_012d: ldloc.2
    IL_012e: ldnull
    IL_012f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0134: brfalse.s IL_0140
    IL_0136: ldstr "Warning! We apparently did not recieve correct Level Info."
    IL_013b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0140: ldarg.0
    IL_0141: ldarg.0
    IL_0142: ldfld EternalWaveGenerator EnemySpawner::waveGeneratorScript  /*0x040007C8*/
    IL_0147: ldarg.0
    IL_0148: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_014d: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<EnemySpawnLine>  /*0x2B000057*/
    IL_0152: ldloc.2
    IL_0153: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0158: ldfld int EternalTrialsRun::stage  /*0x0400084F*/
    IL_015d: ldarg.0
    IL_015e: ldflda int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_0163: call EternalTrialsRun EternalTrialsRunManager::get_CurrentRun()  /*0x060006EA*/
    IL_0168: ldfld int EternalTrialsRun::currentStageSeed  /*0x0400084D*/
    IL_016d: ldc.i4.m1
    IL_016e: callvirt List<Wave> EternalWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  /*0x06000703*/
    IL_0173: stfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0178: br IL_023c
    IL_017d: ldarg.0
    IL_017e: ldfld bool EnemySpawner::endlessMode  /*0x040007D6*/
    IL_0183: brfalse IL_023c
    IL_0188: ldarg.0
    IL_0189: ldfld EternalWaveGenerator EnemySpawner::endlessModeWaveGeneratorScript  /*0x040007D7*/
    IL_018e: ldnull
    IL_018f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0194: brfalse IL_023c
    IL_0199: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_019e: callvirt LevelInfo LevelProgressManager::GetLevelInfoFromCurrentSceneName()  /*0x06000945*/
    IL_01a3: stloc.3
    IL_01a4: ldloc.3
    IL_01a5: ldnull
    IL_01a6: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_01ab: brfalse.s IL_01b7
    IL_01ad: ldstr "Warning! We apparently did not recieve correct Level Info."
    IL_01b2: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_01b7: ldarg.0
    IL_01b8: ldarg.0
    IL_01b9: call !!0 UnityEngine.Component::GetComponent()<SaveLoadEntity>  /*0x2B000026*/
    IL_01be: callvirt string SaveLoadEntity::get_GUID()  /*0x06000D09*/
    IL_01c3: ldstr "endlessSeed"
    IL_01c8: ldarg.0
    IL_01c9: ldflda int EnemySpawner::endlessSeed  /*0x040007D8*/
    IL_01ce: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_01d3: stfld bool EnemySpawner::endlessSeedLoadedFromSave  /*0x040007D9*/
    IL_01d8: ldsfld bool MatchSaveLoadHandler::OverwriteCurrentSave  /*0x04000F8C*/
    IL_01dd: brtrue.s IL_01e7
    IL_01df: ldarg.0
    IL_01e0: ldfld bool EnemySpawner::endlessSeedLoadedFromSave  /*0x040007D9*/
    IL_01e5: brtrue.s IL_0211
    IL_01e7: call float UnityEngine.Time::get_unscaledTime()  /*0x0A000293*/
    IL_01ec: ldc.r4 1000000f
    IL_01f1: mul
    IL_01f2: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_01f7: call void UnityEngine.Random::InitState(int)  /*0x0A000294*/
    IL_01fc: ldarg.0
    IL_01fd: ldc.i4 -1000000
    IL_0202: ldc.i4 1000000
    IL_0207: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_020c: stfld int EnemySpawner::endlessSeed  /*0x040007D8*/
    IL_0211: ldarg.0
    IL_0212: ldarg.0
    IL_0213: ldfld EternalWaveGenerator EnemySpawner::endlessModeWaveGeneratorScript  /*0x040007D7*/
    IL_0218: ldarg.0
    IL_0219: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_021e: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren()<EnemySpawnLine>  /*0x2B000057*/
    IL_0223: ldloc.3
    IL_0224: ldc.i4.3
    IL_0225: ldarg.0
    IL_0226: ldflda int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_022b: ldarg.0
    IL_022c: ldfld int EnemySpawner::endlessSeed  /*0x040007D8*/
    IL_0231: ldc.i4.m1
    IL_0232: callvirt List<Wave> EternalWaveGenerator::GenerateWaves(EnemySpawnLine[],LevelInfo,int,ref int,int,int)  /*0x06000703*/
    IL_0237: stfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_023c: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0241: callvirt bool PerkManager::get_EliteGodEquipped()  /*0x06000997*/
    IL_0246: brfalse IL_02de
    IL_024b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0250: ldfld int PerkManager::eliteGodSpawnInterval  /*0x04000C41*/
    IL_0255: stloc.s 4
    IL_0257: ldarg.0
    IL_0258: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_025d: callvirt List.Enumerator<!0> System.Collections.Generic.List<Wave>::GetEnumerator()  /*0x0A000295*/
    IL_0262: stloc.s 5
    IL_0264: br.s IL_02c5
    IL_0266: ldloca.s 5
    IL_0268: call !0 System.Collections.Generic.List.Enumerator<Wave>::get_Current()  /*0x0A000296*/
    IL_026d: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0272: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0277: stloc.s 6
    IL_0279: br.s IL_02ac
    IL_027b: ldloca.s 6
    IL_027d: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0282: stloc.s 7
    IL_0284: ldloc.s 7
    IL_0286: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_028b: brtrue.s IL_02ac
    IL_028d: ldloc.s 4
    IL_028f: ldc.i4.1
    IL_0290: sub
    IL_0291: stloc.s 4
    IL_0293: ldloc.s 4
    IL_0295: ldc.i4.0
    IL_0296: bgt.s IL_02ac
    IL_0298: ldloc.s 7
    IL_029a: ldc.i4.1
    IL_029b: stfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_02a0: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02a5: ldfld int PerkManager::eliteGodSpawnInterval  /*0x04000C41*/
    IL_02aa: stloc.s 4
    IL_02ac: ldloca.s 6
    IL_02ae: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_02b3: brtrue.s IL_027b
    IL_02b5: leave.s IL_02c5
    IL_02b7: ldloca.s 6
    IL_02b9: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_02bf: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02c4: endfinally
    IL_02c5: ldloca.s 5
    IL_02c7: call bool System.Collections.Generic.List.Enumerator<Wave>::MoveNext()  /*0x0A000297*/
    IL_02cc: brtrue.s IL_0266
    IL_02ce: leave.s IL_02de
    IL_02d0: ldloca.s 5
    IL_02d2: constrained. System.Collections.Generic.List.Enumerator<Wave>  /*0x1B000074*/
    IL_02d8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_02dd: endfinally
    IL_02de: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_02e3: callvirt bool PerkManager::get_RatGodActive()  /*0x0600097E*/
    IL_02e8: brfalse IL_0390
    IL_02ed: ldc.r4 0f
    IL_02f2: stloc.s 8
    IL_02f4: ldarg.0
    IL_02f5: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_02fa: callvirt List.Enumerator<!0> System.Collections.Generic.List<Wave>::GetEnumerator()  /*0x0A000295*/
    IL_02ff: stloc.s 5
    IL_0301: br.s IL_0377
    IL_0303: ldloca.s 5
    IL_0305: call !0 System.Collections.Generic.List.Enumerator<Wave>::get_Current()  /*0x0A000296*/
    IL_030a: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_030f: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0314: stloc.s 6
    IL_0316: br.s IL_035e
    IL_0318: ldloca.s 6
    IL_031a: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_031f: stloc.s 9
    IL_0321: ldloc.s 9
    IL_0323: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0328: conv.r4
    IL_0329: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_032e: ldfld float PerkManager::ratGod_GoldModifyer  /*0x04000C02*/
    IL_0333: mul
    IL_0334: ldloc.s 8
    IL_0336: add
    IL_0337: stloc.s 10
    IL_0339: ldloc.s 9
    IL_033b: ldc.r4 0f
    IL_0340: ldloc.s 10
    IL_0342: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0347: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_034c: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0351: ldloc.s 10
    IL_0353: ldloc.s 9
    IL_0355: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_035a: conv.r4
    IL_035b: sub
    IL_035c: stloc.s 8
    IL_035e: ldloca.s 6
    IL_0360: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0365: brtrue.s IL_0318
    IL_0367: leave.s IL_0377
    IL_0369: ldloca.s 6
    IL_036b: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0371: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0376: endfinally
    IL_0377: ldloca.s 5
    IL_0379: call bool System.Collections.Generic.List.Enumerator<Wave>::MoveNext()  /*0x0A000297*/
    IL_037e: brtrue.s IL_0303
    IL_0380: leave.s IL_0390
    IL_0382: ldloca.s 5
    IL_0384: constrained. System.Collections.Generic.List.Enumerator<Wave>  /*0x1B000074*/
    IL_038a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_038f: endfinally
    IL_0390: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0395: callvirt bool PerkManager::get_LoanEquipped()  /*0x06000994*/
    IL_039a: brfalse IL_043b
    IL_039f: ldarg.0
    IL_03a0: ldarg.0
    IL_03a1: ldfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_03a6: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_03ab: ldfld int PerkManager::loanBonusMoney  /*0x04000C3A*/
    IL_03b0: add
    IL_03b1: stfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_03b6: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_03bb: ldfld int PerkManager::loanInterestMoney  /*0x04000C3B*/
    IL_03c0: stloc.s 11
    IL_03c2: ldc.i4.0
    IL_03c3: stloc.s 12
    IL_03c5: br.s IL_042c
    IL_03c7: ldarg.0
    IL_03c8: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_03cd: ldloc.s 12
    IL_03cf: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_03d4: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_03d9: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_03de: stloc.s 6
    IL_03e0: br.s IL_040d
    IL_03e2: ldloca.s 6
    IL_03e4: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_03e9: dup
    IL_03ea: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_03ef: ldloc.s 11
    IL_03f1: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_03f6: stloc.s 13
    IL_03f8: ldloc.s 11
    IL_03fa: ldloc.s 13
    IL_03fc: sub
    IL_03fd: stloc.s 11
    IL_03ff: dup
    IL_0400: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0405: ldloc.s 13
    IL_0407: sub
    IL_0408: stfld int Spawn::goldCoins  /*0x040007EA*/
    IL_040d: ldloca.s 6
    IL_040f: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0414: brtrue.s IL_03e2
    IL_0416: leave.s IL_0426
    IL_0418: ldloca.s 6
    IL_041a: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0420: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0425: endfinally
    IL_0426: ldloc.s 12
    IL_0428: ldc.i4.1
    IL_0429: add
    IL_042a: stloc.s 12
    IL_042c: ldloc.s 12
    IL_042e: ldarg.0
    IL_042f: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0434: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0439: blt.s IL_03c7
    IL_043b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0440: callvirt bool PerkManager::get_RoyalMintActive()  /*0x0600097D*/
    IL_0445: brfalse.s IL_0466
    IL_0447: ldarg.0
    IL_0448: ldfld bool EnemySpawner::loadedBalanceFromSave  /*0x040007C6*/
    IL_044d: brtrue.s IL_0466
    IL_044f: ldarg.0
    IL_0450: ldarg.0
    IL_0451: ldfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_0456: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_045b: ldfld int PerkManager::royalMint_startGoldBonus  /*0x04000BF1*/
    IL_0460: add
    IL_0461: stfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_0466: ldarg.0
    IL_0467: ldfld bool EnemySpawner::loadedBalanceFromSave  /*0x040007C6*/
    IL_046c: brtrue.s IL_04a2
    IL_046e: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0473: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_0478: stloc.s 14
    IL_047a: ldc.i4.0
    IL_047b: stloc.s 15
    IL_047d: br.s IL_049a
    IL_047f: ldloc.s 14
    IL_0481: ldloc.s 15
    IL_0483: ldelem.ref
    IL_0484: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_0489: ldarg.0
    IL_048a: ldfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_048f: callvirt void PlayerInteraction::AddCoin(int)  /*0x06000C0E*/
    IL_0494: ldloc.s 15
    IL_0496: ldc.i4.1
    IL_0497: add
    IL_0498: stloc.s 15
    IL_049a: ldloc.s 15
    IL_049c: ldloc.s 14
    IL_049e: ldlen
    IL_049f: conv.i4
    IL_04a0: blt.s IL_047f
    IL_04a2: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_04a7: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_04ac: stloc.0
    IL_04ad: ldloc.0
    IL_04ae: brfalse.s IL_04c1
    IL_04b0: ldloc.0
    IL_04b1: ldfld List<int> LevelData::dayToDayNetworth  /*0x04000BC0*/
    IL_04b6: ldarg.0
    IL_04b7: ldfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_04bc: callvirt void System.Collections.Generic.List<int>::Add(!0)  /*0x0A000124*/
    IL_04c1: ldarg.0
    IL_04c2: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_04c7: callvirt bool PerkManager::get_TreasureHunterActive()  /*0x06000987*/
    IL_04cc: stfld bool EnemySpawner::treasureHunterActive  /*0x040007D0*/
    IL_04d1: ldarg.0
    IL_04d2: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_04d7: callvirt bool PerkManager::get_CheeseGodActive()  /*0x06000988*/
    IL_04dc: stfld bool EnemySpawner::cheeseGodActive  /*0x040007D1*/
    IL_04e1: ldarg.0
    IL_04e2: ldfld bool EnemySpawner::cheeseGodActive  /*0x040007D1*/
    IL_04e7: brfalse IL_05a0
    IL_04ec: ldc.i4.0
    IL_04ed: stloc.s 16
    IL_04ef: br IL_057f
    IL_04f4: ldarg.0
    IL_04f5: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_04fa: ldloc.s 16
    IL_04fc: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0501: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0506: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_050b: stloc.s 6
    IL_050d: br.s IL_0560
    IL_050f: ldloca.s 6
    IL_0511: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0516: dup
    IL_0517: dup
    IL_0518: ldfld int Spawn::count  /*0x040007E7*/
    IL_051d: conv.r4
    IL_051e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0523: ldfld float PerkManager::cheeseGod_spawnAmountMulti  /*0x04000C1D*/
    IL_0528: mul
    IL_0529: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_052e: stfld int Spawn::count  /*0x040007E7*/
    IL_0533: dup
    IL_0534: dup
    IL_0535: ldfld float Spawn::interval  /*0x040007E8*/
    IL_053a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_053f: ldfld float PerkManager::cheeseGod_firstWavesSpawnSpeed  /*0x04000C1C*/
    IL_0544: div
    IL_0545: stfld float Spawn::interval  /*0x040007E8*/
    IL_054a: dup
    IL_054b: ldfld float Spawn::delay  /*0x040007E4*/
    IL_0550: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0555: ldfld float PerkManager::cheeseGod_firstWavesSpawnSpeed  /*0x04000C1C*/
    IL_055a: div
    IL_055b: stfld float Spawn::delay  /*0x040007E4*/
    IL_0560: ldloca.s 6
    IL_0562: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0567: brtrue.s IL_050f
    IL_0569: leave.s IL_0579
    IL_056b: ldloca.s 6
    IL_056d: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0573: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0578: endfinally
    IL_0579: ldloc.s 16
    IL_057b: ldc.i4.1
    IL_057c: add
    IL_057d: stloc.s 16
    IL_057f: ldloc.s 16
    IL_0581: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0586: ldfld int PerkManager::cheeseGod_affectedNights  /*0x04000C1E*/
    IL_058b: ldarg.0
    IL_058c: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0591: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0596: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_059b: blt IL_04f4
    IL_05a0: ldarg.0
    IL_05a1: call void EnemySpawner::OnStartOfTheDay()  /*0x0600068A*/
    IL_05a6: ret
    .try IL_0279-IL_02b7 finally handler IL_02b7-IL_02c5
    .try IL_0264-IL_02d0 finally handler IL_02d0-IL_02de
    .try IL_0316-IL_0369 finally handler IL_0369-IL_0377
    .try IL_0301-IL_0382 finally handler IL_0382-IL_0390
    .try IL_03e0-IL_0418 finally handler IL_0418-IL_0426
    .try IL_050d-IL_056b finally handler IL_056b-IL_0579

  .method EnemySpawner::get_TimeSinceSpawningEnded()  // token 0x06000688 rva 0x1b8f0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float EnemySpawner::timeSinceSpaningEnded  /*0x040007DF*/
    IL_0006: ret

  .method EnemySpawner::Update()  // token 0x06000689 rva 0x1b8f8 attrs Private, HideBySig
    // code size 288 (0x120), max stack 3, init locals
    .locals ([0] List.Enumerator<Spawn>)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float EnemySpawner::lastSpawnPeriodClock  /*0x040007CF*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float EnemySpawner::lastSpawnPeriodClock  /*0x040007CF*/
    IL_0012: ldarg.0
    IL_0013: ldfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0018: brtrue.s IL_003e
    IL_001a: ldarg.0
    IL_001b: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0020: ldc.i4.1
    IL_0021: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_0026: stfld int EnemySpawner::numberOfEnemiesOnTheMap  /*0x040007D4*/
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float EnemySpawner::timeSinceSpaningEnded  /*0x040007DF*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float EnemySpawner::timeSinceSpaningEnded  /*0x040007DF*/
    IL_003d: ret
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: ldfld float EnemySpawner::lastSpawnPeriodDuration  /*0x040007CE*/
    IL_0045: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_004a: add
    IL_004b: stfld float EnemySpawner::lastSpawnPeriodDuration  /*0x040007CE*/
    IL_0050: ldarg.0
    IL_0051: ldfld int EnemySpawner::numberOfEnemiesOnTheMap  /*0x040007D4*/
    IL_0056: ldarg.0
    IL_0057: ldfld int EnemySpawner::pauseSpawningAtEnemyCount  /*0x040007D5*/
    IL_005c: bge IL_00ef
    IL_0061: ldarg.0
    IL_0062: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0067: ldarg.0
    IL_0068: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_006d: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0072: callvirt void Wave::Update()  /*0x0600069D*/
    IL_0077: ldarg.0
    IL_0078: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_007d: ldarg.0
    IL_007e: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0083: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0088: callvirt bool Wave::HasFinished()  /*0x0600069E*/
    IL_008d: brfalse.s IL_00ef
    IL_008f: ldarg.0
    IL_0090: call bool EnemySpawner::get_InfinitelySpawning()  /*0x06000677*/
    IL_0095: brfalse.s IL_00e9
    IL_0097: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_009c: ldc.i4.1
    IL_009d: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_00a2: ldc.i4.0
    IL_00a3: bgt.s IL_00ef
    IL_00a5: ldarg.0
    IL_00a6: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_00b1: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_00b6: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_00bb: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_00c0: stloc.0
    IL_00c1: br.s IL_00d0
    IL_00c3: ldloca.s 0
    IL_00c5: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_00ca: ldc.i4.0
    IL_00cb: callvirt void Spawn::Reset(bool)  /*0x060006A6*/
    IL_00d0: ldloca.s 0
    IL_00d2: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_00d7: brtrue.s IL_00c3
    IL_00d9: leave.s IL_00ef
    IL_00db: ldloca.s 0
    IL_00dd: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_00e3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00e8: endfinally
    IL_00e9: ldarg.0
    IL_00ea: call void EnemySpawner::StopSpawnAfterWaveAndReset()  /*0x06000690*/
    IL_00ef: ldarg.0
    IL_00f0: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_00f5: ldc.i4.1
    IL_00f6: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_00fb: stfld int EnemySpawner::numberOfEnemiesOnTheMap  /*0x040007D4*/
    IL_0100: ldarg.0
    IL_0101: ldfld int EnemySpawner::numberOfEnemiesOnTheMap  /*0x040007D4*/
    IL_0106: ldc.i4.0
    IL_0107: bgt.s IL_011f
    IL_0109: ldarg.0
    IL_010a: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_010f: ldarg.0
    IL_0110: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0115: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_011a: callvirt void Wave::ReduceMaxDelayTillNextSpawn()  /*0x0600069F*/
    IL_011f: ret
    .try IL_00c1-IL_00db finally handler IL_00db-IL_00e9

  .method EnemySpawner::OnStartOfTheDay()  // token 0x0600068A rva 0x1ba34 attrs Public, HideBySig
    // code size 119 (0x77), max stack 3, init locals
    .locals ([0] int, [1] PlayerMovement[], [2] int)
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: stfld float EnemySpawner::timeSinceSpaningEnded  /*0x040007DF*/
    IL_000b: ldarg.0
    IL_000c: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0011: ldc.i4.1
    IL_0012: add
    IL_0013: ldarg.0
    IL_0014: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0019: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_001e: blt.s IL_0021
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld bool EnemySpawner::treasureHunterActive  /*0x040007D0*/
    IL_0027: brfalse.s IL_006a
    IL_0029: ldarg.0
    IL_002a: ldfld bool EnemySpawner::loadedFromSave  /*0x040007D3*/
    IL_002f: brtrue.s IL_006a
    IL_0031: ldc.i4.0
    IL_0032: stloc.0
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_003a: ldloca.s 0
    IL_003c: call bool EnemySpawner::GetTreasureHunterBonus(int,ref int)  /*0x0600068C*/
    IL_0041: brfalse.s IL_006a
    IL_0043: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0048: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_004d: stloc.1
    IL_004e: ldc.i4.0
    IL_004f: stloc.2
    IL_0050: br.s IL_0064
    IL_0052: ldloc.1
    IL_0053: ldloc.2
    IL_0054: ldelem.ref
    IL_0055: callvirt !!0 UnityEngine.Component::GetComponent()<PlayerInteraction>  /*0x2B00002E*/
    IL_005a: ldloc.0
    IL_005b: callvirt void PlayerInteraction::AddCoin(int)  /*0x06000C0E*/
    IL_0060: ldloc.2
    IL_0061: ldc.i4.1
    IL_0062: add
    IL_0063: stloc.2
    IL_0064: ldloc.2
    IL_0065: ldloc.1
    IL_0066: ldlen
    IL_0067: conv.i4
    IL_0068: blt.s IL_0052
    IL_006a: ldarg.0
    IL_006b: call void EnemySpawner::PlaceMarkersForNextWave()  /*0x0600068B*/
    IL_0070: ldarg.0
    IL_0071: call void EnemySpawner::EnemySpawnersHornUnFocussed()  /*0x06000681*/
    IL_0076: ret

  .method EnemySpawner::PlaceMarkersForNextWave()  // token 0x0600068B rva 0x1bab8 attrs Public, HideBySig
    // code size 631 (0x277), max stack 4, init locals
    .locals ([0] Wave, [1] List<Vector3>, [2] List.Enumerator<Spawn>, [3] Spawn, [4] Vector3, [5] ScreenMarkerIcon, [6] Sprite, [7] ScreenMarker, [8] ScreenMarker, [9] int, [10] List.Enumerator<Vector3>, [11] Vector3, [12] ScreenMarker)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0006: ldarg.0
    IL_0007: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_000c: ldc.i4.1
    IL_000d: add
    IL_000e: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0013: stloc.0
    IL_0014: newobj void System.Collections.Generic.List<UnityEngine.Vector3>::.ctor()  /*0x0A00029A*/
    IL_0019: stloc.1
    IL_001a: ldloc.0
    IL_001b: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0020: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0025: stloc.2
    IL_0026: br IL_01c0
    IL_002b: ldloca.s 2
    IL_002d: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0032: stloc.3
    IL_0033: ldloc.3
    IL_0034: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0039: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003e: stloc.s 4
    IL_0040: ldloc.3
    IL_0041: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0046: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_004b: ldc.i4.0
    IL_004c: ble.s IL_008d
    IL_004e: ldloc.3
    IL_004f: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0054: ldc.i4.0
    IL_0055: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: ldloc.3
    IL_0060: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_0065: ldloc.3
    IL_0066: ldfld Transform Spawn::spawnLine  /*0x040007E9*/
    IL_006b: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0070: ldc.i4.1
    IL_0071: sub
    IL_0072: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0077: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0081: ldc.r4 2f
    IL_0086: call Vector3 UnityEngine.Vector3::op_Division(UnityEngine.Vector3,float)  /*0x0A000104*/
    IL_008b: stloc.s 4
    IL_008d: ldloc.1
    IL_008e: ldloc.s 4
    IL_0090: callvirt bool System.Collections.Generic.List<UnityEngine.Vector3>::Contains(!0)  /*0x0A00029B*/
    IL_0095: brtrue.s IL_009f
    IL_0097: ldloc.1
    IL_0098: ldloc.s 4
    IL_009a: callvirt void System.Collections.Generic.List<UnityEngine.Vector3>::Add(!0)  /*0x0A00029C*/
    IL_009f: ldloc.3
    IL_00a0: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_00a5: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIcon>  /*0x2B000058*/
    IL_00aa: stloc.s 5
    IL_00ac: ldloc.s 5
    IL_00ae: ldnull
    IL_00af: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00b4: brtrue IL_01c0
    IL_00b9: ldloc.s 5
    IL_00bb: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_00c0: stloc.s 6
    IL_00c2: ldnull
    IL_00c3: stloc.s 7
    IL_00c5: ldc.i4.0
    IL_00c6: stloc.s 9
    IL_00c8: br.s IL_0149
    IL_00ca: ldarg.0
    IL_00cb: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00d0: ldloc.s 9
    IL_00d2: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00d7: callvirt Sprite ScreenMarker::get_Sprite()  /*0x06000D31*/
    IL_00dc: ldloc.s 6
    IL_00de: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00e3: brtrue.s IL_0143
    IL_00e5: ldarg.0
    IL_00e6: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_00eb: ldloc.s 9
    IL_00ed: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_00f2: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f7: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00fc: ldloc.s 4
    IL_00fe: call bool UnityEngine.Vector3::op_Inequality(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A00006F*/
    IL_0103: brtrue.s IL_0143
    IL_0105: ldarg.0
    IL_0106: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_010b: ldloc.s 9
    IL_010d: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0112: callvirt bool ScreenMarker::get_Elite()  /*0x06000D33*/
    IL_0117: ldloc.3
    IL_0118: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_011d: bne.un.s IL_0143
    IL_011f: ldarg.0
    IL_0120: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0125: ldloc.s 9
    IL_0127: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_012c: stloc.s 7
    IL_012e: ldloc.s 7
    IL_0130: ldloc.s 7
    IL_0132: callvirt int ScreenMarker::get_Number()  /*0x06000D35*/
    IL_0137: ldloc.3
    IL_0138: ldfld int Spawn::count  /*0x040007E7*/
    IL_013d: add
    IL_013e: callvirt void ScreenMarker::SetNumber(int)  /*0x06000D34*/
    IL_0143: ldloc.s 9
    IL_0145: ldc.i4.1
    IL_0146: add
    IL_0147: stloc.s 9
    IL_0149: ldloc.s 9
    IL_014b: ldarg.0
    IL_014c: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0151: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0156: blt IL_00ca
    IL_015b: ldloc.s 7
    IL_015d: ldnull
    IL_015e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0163: brtrue.s IL_01c0
    IL_0165: ldarg.0
    IL_0166: ldfld EnemySpawnManager EnemySpawner::enemySpawnManager  /*0x040007C1*/
    IL_016b: ldfld GameObject EnemySpawnManager::screenMarkerPrefabEnemySpawns  /*0x04000B9F*/
    IL_0170: ldloc.s 4
    IL_0172: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0177: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_017c: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarker>  /*0x2B000059*/
    IL_0181: stloc.s 8
    IL_0183: ldloc.s 8
    IL_0185: ldloc.s 6
    IL_0187: callvirt void ScreenMarker::SetSprite(UnityEngine.Sprite)  /*0x06000D2F*/
    IL_018c: ldloc.s 8
    IL_018e: ldloc.3
    IL_018f: ldfld int Spawn::count  /*0x040007E7*/
    IL_0194: callvirt void ScreenMarker::SetNumber(int)  /*0x06000D34*/
    IL_0199: ldloc.s 8
    IL_019b: ldloc.3
    IL_019c: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_01a1: callvirt void ScreenMarker::SetElite(bool)  /*0x06000D32*/
    IL_01a6: ldloc.s 8
    IL_01a8: ldloc.3
    IL_01a9: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_01ae: callvirt void ScreenMarker::SetEnemyPrefab(UnityEngine.GameObject)  /*0x06000D2D*/
    IL_01b3: ldarg.0
    IL_01b4: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_01b9: ldloc.s 8
    IL_01bb: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_01c0: ldloca.s 2
    IL_01c2: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_01c7: brtrue IL_002b
    IL_01cc: leave.s IL_01dc
    IL_01ce: ldloca.s 2
    IL_01d0: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_01d6: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01db: endfinally
    IL_01dc: ldloc.0
    IL_01dd: ldfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_01e2: ldc.r4 1f
    IL_01e7: beq IL_0276
    IL_01ec: ldloc.1
    IL_01ed: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.Vector3>::GetEnumerator()  /*0x0A00029E*/
    IL_01f2: stloc.s 10
    IL_01f4: br.s IL_025d
    IL_01f6: ldloca.s 10
    IL_01f8: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.Vector3>::get_Current()  /*0x0A00029F*/
    IL_01fd: stloc.s 11
    IL_01ff: ldarg.0
    IL_0200: ldfld EnemySpawnManager EnemySpawner::enemySpawnManager  /*0x040007C1*/
    IL_0205: ldfld GameObject EnemySpawnManager::screenMarkerPrefabEnemySpawns  /*0x04000B9F*/
    IL_020a: ldloc.s 11
    IL_020c: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0211: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0216: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarker>  /*0x2B000059*/
    IL_021b: stloc.s 12
    IL_021d: ldloc.s 12
    IL_021f: ldarg.0
    IL_0220: ldfld Sprite EnemySpawner::difficultySprite  /*0x040007DB*/
    IL_0225: callvirt void ScreenMarker::SetSprite(UnityEngine.Sprite)  /*0x06000D2F*/
    IL_022a: ldloc.s 12
    IL_022c: ldloc.0
    IL_022d: ldfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_0232: ldc.r4 1f
    IL_0237: sub
    IL_0238: ldc.r4 0.1f
    IL_023d: div
    IL_023e: call int UnityEngine.Mathf::RoundToInt(float)  /*0x0A0000FA*/
    IL_0243: callvirt void ScreenMarker::SetNumber(int)  /*0x06000D34*/
    IL_0248: ldloc.s 12
    IL_024a: ldc.i4.0
    IL_024b: callvirt void ScreenMarker::SetElite(bool)  /*0x06000D32*/
    IL_0250: ldarg.0
    IL_0251: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0256: ldloc.s 12
    IL_0258: callvirt void System.Collections.Generic.List<ScreenMarker>::Add(!0)  /*0x0A00029D*/
    IL_025d: ldloca.s 10
    IL_025f: call bool System.Collections.Generic.List.Enumerator<UnityEngine.Vector3>::MoveNext()  /*0x0A0002A0*/
    IL_0264: brtrue.s IL_01f6
    IL_0266: leave.s IL_0276
    IL_0268: ldloca.s 10
    IL_026a: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.Vector3>  /*0x1B000076*/
    IL_0270: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0275: endfinally
    IL_0276: ret
    .try IL_0026-IL_01ce finally handler IL_01ce-IL_01dc
    .try IL_01f4-IL_0268 finally handler IL_0268-IL_0276

  .method EnemySpawner::GetTreasureHunterBonus(int,ref int)  // token 0x0600068C rva 0x1bd70 attrs Public, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    IL_0000: ldarg.2
    IL_0001: ldc.i4.0
    IL_0002: stind.i4
    IL_0003: ldarg.0
    IL_0004: ldarg.1
    IL_0005: call bool EnemySpawner::TwoWavesBeforeFinalWaveComingUp(int)  /*0x06000671*/
    IL_000a: brfalse.s IL_001a
    IL_000c: ldarg.2
    IL_000d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0012: ldfld int PerkManager::treasureHunterGoldAmountWave1  /*0x04000C18*/
    IL_0017: stind.i4
    IL_0018: ldc.i4.1
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldarg.1
    IL_001c: call bool EnemySpawner::WaveBeforeFinalWaveComingUp(int)  /*0x06000672*/
    IL_0021: brfalse.s IL_0031
    IL_0023: ldarg.2
    IL_0024: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0029: ldfld int PerkManager::treasureHunterGoldAmountWave2  /*0x04000C19*/
    IL_002e: stind.i4
    IL_002f: ldc.i4.1
    IL_0030: ret
    IL_0031: ldarg.0
    IL_0032: ldarg.1
    IL_0033: call bool EnemySpawner::FinalWaveComingUp(int)  /*0x06000673*/
    IL_0038: brfalse.s IL_0048
    IL_003a: ldarg.2
    IL_003b: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0040: ldfld int PerkManager::treasureHunterGoldAmountWave3  /*0x04000C1A*/
    IL_0045: stind.i4
    IL_0046: ldc.i4.1
    IL_0047: ret
    IL_0048: ldc.i4.0
    IL_0049: ret

  .method EnemySpawner::OnStartOfTheNight()  // token 0x0600068D rva 0x1bdc6 attrs Public, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool EnemySpawner::loadedFromSave  /*0x040007D3*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 0f
    IL_000d: stfld float EnemySpawner::timeSinceSpaningEnded  /*0x040007DF*/
    IL_0012: ldc.i4.0
    IL_0013: stsfld int EnemySpawner::totalEnemiesSpawnedThisWave  /*0x040007DA*/
    IL_0018: ldarg.0
    IL_0019: call void EnemySpawner::DestroyMarkers()  /*0x0600068E*/
    IL_001e: ldarg.0
    IL_001f: call void EnemySpawner::StartSpawning()  /*0x0600068F*/
    IL_0024: ret

  .method EnemySpawner::DestroyMarkers()  // token 0x0600068E rva 0x1bdec attrs Public, HideBySig
    // code size 115 (0x73), max stack 2, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0006: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_000b: ldc.i4.1
    IL_000c: sub
    IL_000d: stloc.0
    IL_000e: br.s IL_002a
    IL_0010: ldarg.0
    IL_0011: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0016: ldloc.0
    IL_0017: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_001c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0021: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0026: ldloc.0
    IL_0027: ldc.i4.1
    IL_0028: sub
    IL_0029: stloc.0
    IL_002a: ldloc.0
    IL_002b: ldc.i4.0
    IL_002c: bge.s IL_0010
    IL_002e: ldarg.0
    IL_002f: ldfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_0034: callvirt void System.Collections.Generic.List<ScreenMarker>::Clear()  /*0x0A0002A1*/
    IL_0039: ldarg.0
    IL_003a: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_003f: callvirt int System.Collections.Generic.List<ScreenMarker>::get_Count()  /*0x0A00028F*/
    IL_0044: ldc.i4.1
    IL_0045: sub
    IL_0046: stloc.1
    IL_0047: br.s IL_0063
    IL_0049: ldarg.0
    IL_004a: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_004f: ldloc.1
    IL_0050: callvirt !0 System.Collections.Generic.List<ScreenMarker>::get_Item(int)  /*0x0A00028E*/
    IL_0055: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_005a: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_005f: ldloc.1
    IL_0060: ldc.i4.1
    IL_0061: sub
    IL_0062: stloc.1
    IL_0063: ldloc.1
    IL_0064: ldc.i4.0
    IL_0065: bge.s IL_0049
    IL_0067: ldarg.0
    IL_0068: ldfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_006d: callvirt void System.Collections.Generic.List<ScreenMarker>::Clear()  /*0x0A0002A1*/
    IL_0072: ret

  .method EnemySpawner::StartSpawning()  // token 0x0600068F rva 0x1be6c attrs Public, HideBySig
    // code size 242 (0xf2), max stack 5, init locals
    .locals ([0] List.Enumerator<Spawn>, [1] Spawn, [2] Scene, [3] NavmeshCut)
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.r4 0f
    IL_000f: stfld float EnemySpawner::lastSpawnPeriodDuration  /*0x040007CE*/
    IL_0014: ldarg.0
    IL_0015: ldc.r4 0f
    IL_001a: stfld float EnemySpawner::lastSpawnPeriodClock  /*0x040007CF*/
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0026: ldc.i4.1
    IL_0027: add
    IL_0028: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_002d: ldarg.0
    IL_002e: ldarg.0
    IL_002f: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0034: ldc.i4.0
    IL_0035: ldarg.0
    IL_0036: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_003b: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0040: ldc.i4.1
    IL_0041: sub
    IL_0042: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_0047: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_004c: ldarg.0
    IL_004d: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0052: ldarg.0
    IL_0053: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0058: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_005d: ldc.i4.1
    IL_005e: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.1
    IL_0065: stfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_006a: ldarg.0
    IL_006b: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0070: ldarg.0
    IL_0071: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0076: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_007b: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0080: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0085: stloc.0
    IL_0086: br.s IL_00d8
    IL_0088: ldloca.s 0
    IL_008a: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_008f: stloc.1
    IL_0090: ldloc.1
    IL_0091: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0096: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_009b: stloc.2
    IL_009c: ldloca.s 2
    IL_009e: call bool UnityEngine.SceneManagement.Scene::get_isLoaded()  /*0x0A0002A2*/
    IL_00a3: brfalse.s IL_00d8
    IL_00a5: ldloc.1
    IL_00a6: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_00ab: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00b0: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_00b5: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<Pathfinding.NavmeshCut>  /*0x2B00005A*/
    IL_00ba: stloc.3
    IL_00bb: ldloc.3
    IL_00bc: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c1: brfalse.s IL_00c9
    IL_00c3: ldloc.3
    IL_00c4: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_00c9: leave.s IL_00d8
    IL_00cb: pop
    IL_00cc: ldstr "Enemy was spawned form scene but something went wrong with disabling potential NavmeshCuts."
    IL_00d1: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_00d6: leave.s IL_00d8
    IL_00d8: ldloca.s 0
    IL_00da: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_00df: brtrue.s IL_0088
    IL_00e1: leave.s IL_00f1
    IL_00e3: ldloca.s 0
    IL_00e5: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_00eb: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00f0: endfinally
    IL_00f1: ret
    .try IL_00a5-IL_00cb catch System.Object handler IL_00cb-IL_00d8
    .try IL_0086-IL_00e3 finally handler IL_00e3-IL_00f1

  .method EnemySpawner::StopSpawnAfterWaveAndReset()  // token 0x06000690 rva 0x1bf88 attrs Public, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.0
    IL_000b: stfld bool EnemySpawner::spawningInProgress  /*0x040007C7*/
    IL_0010: ret

  .method EnemySpawner::OnDusk()  // token 0x06000691 rva 0x1bf9a attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EnemySpawner::OnStartOfTheNight()  /*0x0600068D*/
    IL_0006: ret

  .method EnemySpawner::OnDawn_AfterSunrise()  // token 0x06000692 rva 0x1bfa2 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void EnemySpawner::OnStartOfTheDay()  /*0x0600068A*/
    IL_0006: ret

  .method EnemySpawner::OnDawn_BeforeSunrise()  // token 0x06000693 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method EnemySpawner::GetWaveInfoForNextWave()  // token 0x06000694 rva 0x1bfac attrs Public, Static, HideBySig
    // code size 76 (0x4c), max stack 3, init locals
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0013
    IL_000d: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_0012: ret
    IL_0013: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0018: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001d: ldc.i4.1
    IL_001e: bne.un.s IL_0035
    IL_0020: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0025: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002a: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_002f: callvirt WaveInfo EnemySpawner::GetWaveInfo(int)  /*0x06000697*/
    IL_0034: ret
    IL_0035: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_003a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_003f: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0044: ldc.i4.1
    IL_0045: add
    IL_0046: callvirt WaveInfo EnemySpawner::GetWaveInfo(int)  /*0x06000697*/
    IL_004b: ret

  .method EnemySpawner::GetWaveInfoByNumber(int)  // token 0x06000695 rva 0x1c004 attrs Public, Static, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0013
    IL_000d: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_0012: ret
    IL_0013: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0018: ldarg.0
    IL_0019: callvirt WaveInfo EnemySpawner::GetWaveInfo(int)  /*0x06000697*/
    IL_001e: ret

  .method EnemySpawner::GetNextWave()  // token 0x06000696 rva 0x1c024 attrs Public, Static, HideBySig
    // code size 130 (0x82), max stack 4, init locals
    IL_0000: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_0013
    IL_000d: newobj void Wave::.ctor()  /*0x06000699*/
    IL_0012: ret
    IL_0013: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0018: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001d: ldc.i4.1
    IL_001e: bne.un.s IL_0050
    IL_0020: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0025: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_002a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002f: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0034: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0039: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_003e: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0043: ldc.i4.1
    IL_0044: sub
    IL_0045: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_004a: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_004f: ret
    IL_0050: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0055: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_005a: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_005f: ldfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0064: ldc.i4.1
    IL_0065: add
    IL_0066: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_006b: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0070: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0075: ldc.i4.1
    IL_0076: sub
    IL_0077: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_007c: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0081: ret

  .method EnemySpawner::GetWaveInfo(int)  // token 0x06000697 rva 0x1c0b4 attrs Private, HideBySig
    // code size 895 (0x37f), max stack 3, init locals
    .locals ([0] WaveInfo, [1] Wave, [2] List.Enumerator<Spawn>, [3] Spawn, [4] GameObject, [5] ScreenMarkerIcon, [6] Hp, [7] PathfindMovementEnemy, [8] AutoAttack, [9] string, [10] string, [11] Sprite, [12] ScreenMarkerIconArachnophobia, [13] WaveEnemyInfo, [14] List.Enumerator<WaveEnemyInfo>, [15] WaveEnemyInfo, [16] List.Enumerator<TargetPriority>, [17] TargetPriority, [18] float, [19] int, [20] DamageModifyer)
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0007: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_000c: bge.s IL_0012
    IL_000e: ldarg.1
    IL_000f: ldc.i4.0
    IL_0010: bge.s IL_0018
    IL_0012: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_0017: ret
    IL_0018: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: ldarg.1
    IL_0020: ldc.i4.1
    IL_0021: add
    IL_0022: stfld int WaveInfo::waveNumber  /*0x040007FB*/
    IL_0027: ldloc.0
    IL_0028: ldarg.0
    IL_0029: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_002e: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0033: stfld int WaveInfo::outOfWaves  /*0x040007FC*/
    IL_0038: ldarg.0
    IL_0039: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_003e: ldarg.1
    IL_003f: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0044: stloc.1
    IL_0045: ldloc.0
    IL_0046: ldloc.1
    IL_0047: ldfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_004c: stfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_0051: ldloc.1
    IL_0052: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0057: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_005c: stloc.2
    IL_005d: br IL_0361
    IL_0062: ldloca.s 2
    IL_0064: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0069: stloc.3
    IL_006a: ldloc.3
    IL_006b: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0070: ldnull
    IL_0071: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0076: brtrue IL_0361
    IL_007b: ldloc.3
    IL_007c: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0081: stloc.s 4
    IL_0083: ldloc.s 4
    IL_0085: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIcon>  /*0x2B000058*/
    IL_008a: stloc.s 5
    IL_008c: ldloc.s 5
    IL_008e: ldnull
    IL_008f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0094: brtrue IL_0361
    IL_0099: ldloc.s 4
    IL_009b: callvirt !!0 UnityEngine.GameObject::GetComponent()<Hp>  /*0x2B000021*/
    IL_00a0: stloc.s 6
    IL_00a2: ldloc.s 4
    IL_00a4: callvirt !!0 UnityEngine.GameObject::GetComponent()<PathfindMovementEnemy>  /*0x2B00005B*/
    IL_00a9: stloc.s 7
    IL_00ab: ldloc.s 4
    IL_00ad: callvirt !!0 UnityEngine.GameObject::GetComponent()<AutoAttack>  /*0x2B00005C*/
    IL_00b2: stloc.s 8
    IL_00b4: ldloc.s 6
    IL_00b6: ldnull
    IL_00b7: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00bc: brfalse.s IL_00c7
    IL_00be: ldloc.s 4
    IL_00c0: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<Hp>  /*0x2B00005D*/
    IL_00c5: stloc.s 6
    IL_00c7: ldloc.s 7
    IL_00c9: ldnull
    IL_00ca: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00cf: brfalse.s IL_00da
    IL_00d1: ldloc.s 4
    IL_00d3: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<PathfindMovementEnemy>  /*0x2B00005E*/
    IL_00d8: stloc.s 7
    IL_00da: ldloc.s 8
    IL_00dc: ldnull
    IL_00dd: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00e2: brfalse.s IL_00ed
    IL_00e4: ldloc.s 4
    IL_00e6: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren()<AutoAttack>  /*0x2B00005F*/
    IL_00eb: stloc.s 8
    IL_00ed: ldloc.s 5
    IL_00ef: callvirt string ScreenMarkerIcon::get_UnitDescription()  /*0x06000D40*/
    IL_00f4: stloc.s 9
    IL_00f6: ldloc.s 5
    IL_00f8: callvirt string ScreenMarkerIcon::get_UnitName()  /*0x06000D41*/
    IL_00fd: stloc.s 10
    IL_00ff: ldloc.s 5
    IL_0101: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0106: stloc.s 11
    IL_0108: ldloc.s 4
    IL_010a: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIconArachnophobia>  /*0x2B000060*/
    IL_010f: stloc.s 12
    IL_0111: ldloc.s 12
    IL_0113: ldnull
    IL_0114: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0119: brfalse.s IL_0124
    IL_011b: ldloc.s 12
    IL_011d: ldfld Sprite ScreenMarkerIconArachnophobia::defaultSprite  /*0x04000021*/
    IL_0122: stloc.s 11
    IL_0124: ldnull
    IL_0125: stloc.s 13
    IL_0127: ldloc.0
    IL_0128: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_012d: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveEnemyInfo>::GetEnumerator()  /*0x0A0002A4*/
    IL_0132: stloc.s 14
    IL_0134: br.s IL_0174
    IL_0136: ldloca.s 14
    IL_0138: call !0 System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::get_Current()  /*0x0A0002A5*/
    IL_013d: stloc.s 15
    IL_013f: ldloc.s 15
    IL_0141: ldfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_0146: ldloc.s 11
    IL_0148: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_014d: brfalse.s IL_0174
    IL_014f: ldloc.s 15
    IL_0151: ldfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_0156: ldloc.s 10
    IL_0158: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_015d: brfalse.s IL_0174
    IL_015f: ldloc.s 15
    IL_0161: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_0166: ldloc.3
    IL_0167: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_016c: bne.un.s IL_0174
    IL_016e: ldloc.s 15
    IL_0170: stloc.s 13
    IL_0172: leave.s IL_018d
    IL_0174: ldloca.s 14
    IL_0176: call bool System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::MoveNext()  /*0x0A0002A7*/
    IL_017b: brtrue.s IL_0136
    IL_017d: leave.s IL_018d
    IL_017f: ldloca.s 14
    IL_0181: constrained. System.Collections.Generic.List.Enumerator<WaveEnemyInfo>  /*0x1B000078*/
    IL_0187: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_018c: endfinally
    IL_018d: ldloc.s 13
    IL_018f: brtrue IL_033a
    IL_0194: newobj void WaveEnemyInfo::.ctor()  /*0x060006AE*/
    IL_0199: stloc.s 13
    IL_019b: ldloc.s 13
    IL_019d: ldloc.s 9
    IL_019f: stfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_01a4: ldloc.s 13
    IL_01a6: ldloc.s 10
    IL_01a8: stfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_01ad: ldloc.s 13
    IL_01af: ldloc.s 11
    IL_01b1: stfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_01b6: ldloc.s 13
    IL_01b8: ldloc.3
    IL_01b9: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_01be: stfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_01c3: ldloc.s 12
    IL_01c5: ldnull
    IL_01c6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01cb: brfalse.s IL_01db
    IL_01cd: ldloc.s 13
    IL_01cf: ldloc.s 12
    IL_01d1: ldfld Sprite ScreenMarkerIconArachnophobia::arachnophobiaModeSprite  /*0x04000020*/
    IL_01d6: stfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_01db: ldloc.s 6
    IL_01dd: ldnull
    IL_01de: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01e3: brfalse.s IL_01f3
    IL_01e5: ldloc.s 13
    IL_01e7: ldloc.s 6
    IL_01e9: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_01ee: stfld float WaveEnemyInfo::maxHP  /*0x04000806*/
    IL_01f3: ldloc.s 7
    IL_01f5: ldnull
    IL_01f6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01fb: brfalse.s IL_020b
    IL_01fd: ldloc.s 13
    IL_01ff: ldloc.s 7
    IL_0201: ldfld float PathfindMovementEnemy::movementSpeed  /*0x04000DDC*/
    IL_0206: stfld float WaveEnemyInfo::speed  /*0x04000807*/
    IL_020b: ldloc.s 8
    IL_020d: ldnull
    IL_020e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0213: brfalse IL_032d
    IL_0218: ldloc.s 13
    IL_021a: ldloc.s 8
    IL_021c: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0221: stfld float WaveEnemyInfo::attackCooldown  /*0x0400080A*/
    IL_0226: ldloc.s 8
    IL_0228: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_022d: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0232: ldc.i4.0
    IL_0233: ble.s IL_029f
    IL_0235: ldloc.s 13
    IL_0237: ldloc.s 8
    IL_0239: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_023e: ldc.i4.0
    IL_023f: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0244: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0249: stfld float WaveEnemyInfo::range  /*0x04000808*/
    IL_024e: ldloc.s 8
    IL_0250: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0255: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_025a: stloc.s 16
    IL_025c: br.s IL_0286
    IL_025e: ldloca.s 16
    IL_0260: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0265: stloc.s 17
    IL_0267: ldloc.s 17
    IL_0269: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_026e: ldc.i4.2
    IL_026f: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0274: brfalse.s IL_0286
    IL_0276: ldloc.s 13
    IL_0278: ldloc.s 17
    IL_027a: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_027f: stfld float WaveEnemyInfo::range  /*0x04000808*/
    IL_0284: leave.s IL_029f
    IL_0286: ldloca.s 16
    IL_0288: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_028d: brtrue.s IL_025e
    IL_028f: leave.s IL_029f
    IL_0291: ldloca.s 16
    IL_0293: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_0299: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_029e: endfinally
    IL_029f: ldloc.s 8
    IL_02a1: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_02a6: ldnull
    IL_02a7: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_02ac: brfalse.s IL_032d
    IL_02ae: ldc.r4 0f
    IL_02b3: stloc.s 18
    IL_02b5: ldc.i4.0
    IL_02b6: stloc.s 19
    IL_02b8: br.s IL_02fc
    IL_02ba: ldloc.s 8
    IL_02bc: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_02c1: ldfld List<DamageModifyer> Weapon::directDamage  /*0x04001829*/
    IL_02c6: ldloc.s 19
    IL_02c8: callvirt !0 System.Collections.Generic.List<DamageModifyer>::get_Item(int)  /*0x0A00019D*/
    IL_02cd: stloc.s 20
    IL_02cf: ldloc.s 20
    IL_02d1: ldfld List<TagManager.ETag> DamageModifyer::requiredTags  /*0x040004A6*/
    IL_02d6: ldc.i4.0
    IL_02d7: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_02dc: brfalse.s IL_02f6
    IL_02de: ldloc.s 18
    IL_02e0: ldloc.s 20
    IL_02e2: ldfld float DamageModifyer::damageAdded  /*0x040004A7*/
    IL_02e7: add
    IL_02e8: stloc.s 18
    IL_02ea: ldloc.s 18
    IL_02ec: ldloc.s 20
    IL_02ee: ldfld float DamageModifyer::damageMultiplyer  /*0x040004A8*/
    IL_02f3: mul
    IL_02f4: stloc.s 18
    IL_02f6: ldloc.s 19
    IL_02f8: ldc.i4.1
    IL_02f9: add
    IL_02fa: stloc.s 19
    IL_02fc: ldloc.s 19
    IL_02fe: ldloc.s 8
    IL_0300: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0305: ldfld List<DamageModifyer> Weapon::directDamage  /*0x04001829*/
    IL_030a: callvirt int System.Collections.Generic.List<DamageModifyer>::get_Count()  /*0x0A00019E*/
    IL_030f: blt.s IL_02ba
    IL_0311: ldloc.s 13
    IL_0313: ldloc.s 18
    IL_0315: stfld float WaveEnemyInfo::attackDamage  /*0x04000809*/
    IL_031a: ldloc.s 13
    IL_031c: ldloc.s 8
    IL_031e: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0323: ldfld float Weapon::projectileSpeed  /*0x04001818*/
    IL_0328: stfld float WaveEnemyInfo::projectileSpeed  /*0x0400080B*/
    IL_032d: ldloc.0
    IL_032e: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_0333: ldloc.s 13
    IL_0335: callvirt void System.Collections.Generic.List<WaveEnemyInfo>::Add(!0)  /*0x0A0002A8*/
    IL_033a: ldloc.0
    IL_033b: dup
    IL_033c: ldfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_0341: ldloc.3
    IL_0342: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0347: add
    IL_0348: stfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_034d: ldloc.s 13
    IL_034f: dup
    IL_0350: ldfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0355: ldloc.3
    IL_0356: ldfld int Spawn::count  /*0x040007E7*/
    IL_035b: add
    IL_035c: stfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0361: ldloca.s 2
    IL_0363: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0368: brtrue IL_0062
    IL_036d: leave.s IL_037d
    IL_036f: ldloca.s 2
    IL_0371: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0377: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_037c: endfinally
    IL_037d: ldloc.0
    IL_037e: ret
    .try IL_0134-IL_017f finally handler IL_017f-IL_018d
    .try IL_025c-IL_0291 finally handler IL_0291-IL_029f
    .try IL_005d-IL_036f finally handler IL_036f-IL_037d

  .method EnemySpawner::.ctor()  // token 0x06000698 rva 0x1c48c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 113 (0x71), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.s 10
    IL_0003: stfld int EnemySpawner::goldBalanceAtStart  /*0x040007C5*/
    IL_0008: ldarg.0
    IL_0009: newobj void System.Collections.Generic.List<Wave>::.ctor()  /*0x0A0002A9*/
    IL_000e: stfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_0013: ldarg.0
    IL_0014: newobj void System.Collections.Generic.List<ScreenMarker>::.ctor()  /*0x0A0002AA*/
    IL_0019: stfld List<ScreenMarker> EnemySpawner::screenMarkersEnemySpawns  /*0x040007CA*/
    IL_001e: ldarg.0
    IL_001f: newobj void System.Collections.Generic.List<ScreenMarker>::.ctor()  /*0x0A0002AA*/
    IL_0024: stfld List<ScreenMarker> EnemySpawner::screenMarkersOffscreenWarnings  /*0x040007CB*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.m1
    IL_002b: stfld int EnemySpawner::wavenumber  /*0x040007CC*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.m1
    IL_0032: stfld int EnemySpawner::wavenumberLoadedFromSave  /*0x040007CD*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4 275
    IL_003d: stfld int EnemySpawner::pauseSpawningAtEnemyCount  /*0x040007D5*/
    IL_0042: ldarg.0
    IL_0043: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_0048: stfld NNConstraint EnemySpawner::flyingConstraint  /*0x040007DC*/
    IL_004d: ldarg.0
    IL_004e: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_0053: stfld NNConstraint EnemySpawner::groundConstraint  /*0x040007DD*/
    IL_0058: ldarg.0
    IL_0059: newobj void Pathfinding.NNConstraint::.ctor()  /*0x0A0002AB*/
    IL_005e: stfld NNConstraint EnemySpawner::groundConstraintLarge  /*0x040007DE*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.1
    IL_0065: stfld bool EnemySpawner::reduceSpawnWaitTimes  /*0x040007E0*/
    IL_006a: ldarg.0
    IL_006b: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0070: ret

