// ===== LocalGamestate  (token 0x020001BB) =====
  .method LocalGamestate::get_SelectedGameMode()  // token 0x060008FA rva 0x2b0a5 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld LocalGamestate.GameMode LocalGamestate::selectedGameMode  /*0x04000B43*/
    IL_0005: ret

  .method LocalGamestate::set_SelectedGameMode(LocalGamestate.GameMode)  // token 0x060008FB rva 0x2b0ac attrs Public, Static, HideBySig, SpecialName
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld LocalGamestate.GameMode LocalGamestate::selectedGameMode  /*0x04000B43*/
    IL_0006: ldc.i4.1
    IL_0007: stsfld bool LocalGamestate::gameModeSet  /*0x04000B44*/
    IL_000c: ret

  .method LocalGamestate::get_GameModeSet()  // token 0x060008FC rva 0x2b0ba attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld bool LocalGamestate::gameModeSet  /*0x04000B44*/
    IL_0005: ret

  .method LocalGamestate::get_CurrentState()  // token 0x060008FD rva 0x2b0c1 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0006: ret

  .method LocalGamestate::get_Instance()  // token 0x060008FE rva 0x2b0c9 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld LocalGamestate LocalGamestate::instance  /*0x04000B49*/
    IL_0005: ret

  .method LocalGamestate::get_PlayerFrozen()  // token 0x060008FF rva 0x2b0d0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool LocalGamestate::playerFrozen  /*0x04000B4A*/
    IL_0006: ret

  .method LocalGamestate::Awake()  // token 0x06000900 rva 0x2b0d8 attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldsfld LocalGamestate LocalGamestate::instance  /*0x04000B49*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0026
    IL_000d: ldstr "Multiple LocalGamestate Objects detected. Please make sure there is only on LocalGamestate in the scene. Old instance got destroyed."
    IL_0012: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0017: ldsfld LocalGamestate LocalGamestate::instance  /*0x04000B49*/
    IL_001c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0021: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0026: ldarg.0
    IL_0027: stsfld LocalGamestate LocalGamestate::instance  /*0x04000B49*/
    IL_002c: ret

  .method LocalGamestate::Start()  // token 0x06000901 rva 0x2b108 attrs Private, HideBySig
    // code size 125 (0x7d), max stack 4, init locals
    .locals ([0] LevelData, [1] List.Enumerator<Hp>, [2] Hp)
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_000a: stloc.0
    IL_000b: ldloc.0
    IL_000c: brfalse.s IL_0015
    IL_000e: ldloc.0
    IL_000f: ldc.i4.0
    IL_0010: callvirt void LevelData::SaveScoreAndStatsToBestIfBest(bool)  /*0x06000951*/
    IL_0015: ldarg.0
    IL_0016: ldfld bool LocalGamestate::autoStartMatch  /*0x04000B45*/
    IL_001b: brfalse.s IL_0026
    IL_001d: ldarg.0
    IL_001e: ldc.i4.1
    IL_001f: ldc.i4.0
    IL_0020: ldc.i4.0
    IL_0021: call void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_0026: ldarg.0
    IL_0027: ldfld List<Hp> LocalGamestate::objectsThatTriggerLoseWhenDestroyed  /*0x04000B47*/
    IL_002c: callvirt List.Enumerator<!0> System.Collections.Generic.List<Hp>::GetEnumerator()  /*0x0A0003DC*/
    IL_0031: stloc.1
    IL_0032: br.s IL_0063
    IL_0034: ldloca.s 1
    IL_0036: call !0 System.Collections.Generic.List.Enumerator<Hp>::get_Current()  /*0x0A0003DD*/
    IL_003b: stloc.2
    IL_003c: ldloc.2
    IL_003d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0042: brfalse.s IL_0063
    IL_0044: ldloc.2
    IL_0045: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_004a: brfalse.s IL_0063
    IL_004c: ldloc.2
    IL_004d: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0052: ldarg.0
    IL_0053: ldftn void LocalGamestate::OnVitalObjectKill()  /*0x06000904*/
    IL_0059: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005e: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0063: ldloca.s 1
    IL_0065: call bool System.Collections.Generic.List.Enumerator<Hp>::MoveNext()  /*0x0A0003DE*/
    IL_006a: brtrue.s IL_0034
    IL_006c: leave.s IL_007c
    IL_006e: ldloca.s 1
    IL_0070: constrained. System.Collections.Generic.List.Enumerator<Hp>  /*0x1B0000B2*/
    IL_0076: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_007b: endfinally
    IL_007c: ret
    .try IL_0032-IL_006e finally handler IL_006e-IL_007c

  .method LocalGamestate::SetState(LocalGamestate.State,bool,bool)  // token 0x06000902 rva 0x2b1a4 attrs Public, HideBySig
    // code size 167 (0xa7), max stack 3, init locals
    .locals ([0] LevelData, [1] LevelData)
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0006: ldc.i4.2
    IL_0007: bne.un.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0010: ldc.i4.3
    IL_0011: bne.un.s IL_0014
    IL_0013: ret
    IL_0014: ldarg.1
    IL_0015: ldarg.0
    IL_0016: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_001b: bne.un.s IL_0021
    IL_001d: ldarg.2
    IL_001e: brtrue.s IL_0021
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldarg.1
    IL_0023: stfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0028: ldarg.0
    IL_0029: ldfld UnityEvent LocalGamestate::OnGameStateChange  /*0x04000B48*/
    IL_002e: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0033: ldarg.0
    IL_0034: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0039: ldc.i4.2
    IL_003a: bne.un.s IL_0058
    IL_003c: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0041: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_0046: stloc.0
    IL_0047: ldloc.0
    IL_0048: brfalse.s IL_0051
    IL_004a: ldloc.0
    IL_004b: ldc.i4.1
    IL_004c: stfld bool LevelData::beaten  /*0x04000BBD*/
    IL_0051: call void MatchSaveLoadHandler::MarkRunCompleteAndSave()  /*0x06000CFD*/
    IL_0056: br.s IL_006d
    IL_0058: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_005d: callvirt LevelData LevelProgressManager::GetLevelDataForActiveScene()  /*0x0600094B*/
    IL_0062: stloc.1
    IL_0063: ldloc.1
    IL_0064: brfalse.s IL_006d
    IL_0066: ldloc.1
    IL_0067: ldc.i4.0
    IL_0068: stfld bool LevelData::beaten  /*0x04000BBD*/
    IL_006d: ldarg.0
    IL_006e: call LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_0073: ldc.i4.3
    IL_0074: bne.un.s IL_0086
    IL_0076: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_007b: ldnull
    IL_007c: ldc.r4 3f
    IL_0081: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_0086: ldarg.0
    IL_0087: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_008c: ldc.i4.2
    IL_008d: beq.s IL_0098
    IL_008f: ldarg.0
    IL_0090: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0095: ldc.i4.3
    IL_0096: bne.un.s IL_00a6
    IL_0098: ldarg.0
    IL_0099: ldarg.0
    IL_009a: ldarg.3
    IL_009b: call IEnumerator LocalGamestate::WaitThenTriggerEndOfMatchScreen(bool)  /*0x06000903*/
    IL_00a0: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_00a5: pop
    IL_00a6: ret

  .method LocalGamestate::WaitThenTriggerEndOfMatchScreen(bool)  // token 0x06000903 rva 0x2b257 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::.ctor(int)  /*0x06000907*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LocalGamestate LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>4__this  /*0x04000B56*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld bool LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::immediate  /*0x04000B57*/
    IL_0014: ret

  .method LocalGamestate::OnVitalObjectKill()  // token 0x06000904 rva 0x2b26d attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0006: ldc.i4.1
    IL_0007: beq.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldc.i4.3
    IL_000c: ldc.i4.0
    IL_000d: ldc.i4.0
    IL_000e: call void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_0013: ret

  .method LocalGamestate::SetPlayerFreezeState(bool)  // token 0x06000905 rva 0x2b282 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool LocalGamestate::playerFrozen  /*0x04000B4A*/
    IL_0007: ret

  .method LocalGamestate::.ctor()  // token 0x06000906 rva 0x2b28b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool LocalGamestate::autoStartMatch  /*0x04000B45*/
    IL_0007: ldarg.0
    IL_0008: newobj void System.Collections.Generic.List<Hp>::.ctor()  /*0x0A0003C5*/
    IL_000d: stfld List<Hp> LocalGamestate::objectsThatTriggerLoseWhenDestroyed  /*0x04000B47*/
    IL_0012: ldarg.0
    IL_0013: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0018: stfld UnityEvent LocalGamestate::OnGameStateChange  /*0x04000B48*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

// ===== LocalGamestate/GameMode  (token 0x020001BC) =====
// ===== LocalGamestate/State  (token 0x020001BD) =====
// ===== LocalGamestate/<WaitThenTriggerEndOfMatchScreen>d__25  (token 0x020001BE) =====
  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::.ctor(int)  // token 0x06000907 rva 0x2b2b0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_000d: ret

  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::System.IDisposable.Dispose()  // token 0x06000908 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::MoveNext()  // token 0x06000909 rva 0x2b2c0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 274 (0x112), max stack 5, init locals
    .locals ([0] int, [1] LocalGamestate)
    IL_0000: ldarg.0
    IL_0001: ldfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LocalGamestate LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>4__this  /*0x04000B56*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_0073, IL_0095, IL_0109)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_002d: ldloc.1
    IL_002e: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_0033: ldc.i4.2
    IL_0034: bne.un.s IL_0045
    IL_0036: ldsfld LocalGamestate.GameMode LocalGamestate::selectedGameMode  /*0x04000B43*/
    IL_003b: ldc.i4.1
    IL_003c: bne.un.s IL_005b
    IL_003e: call void EternalTrialsRunManager::OnVictory()  /*0x060006F2*/
    IL_0043: br.s IL_005b
    IL_0045: ldloc.1
    IL_0046: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_004b: ldc.i4.3
    IL_004c: bne.un.s IL_005b
    IL_004e: ldsfld LocalGamestate.GameMode LocalGamestate::selectedGameMode  /*0x04000B43*/
    IL_0053: ldc.i4.1
    IL_0054: bne.un.s IL_005b
    IL_0056: call void EternalTrialsRunManager::OnDefeat()  /*0x060006F3*/
    IL_005b: ldarg.0
    IL_005c: ldfld bool LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::immediate  /*0x04000B57*/
    IL_0061: brfalse.s IL_007c
    IL_0063: ldarg.0
    IL_0064: ldnull
    IL_0065: stfld object LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>2__current  /*0x04000B55*/
    IL_006a: ldarg.0
    IL_006b: ldc.i4.1
    IL_006c: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_0071: ldc.i4.1
    IL_0072: ret
    IL_0073: ldarg.0
    IL_0074: ldc.i4.m1
    IL_0075: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_007a: br.s IL_009c
    IL_007c: ldarg.0
    IL_007d: ldc.r4 1f
    IL_0082: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0087: stfld object LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>2__current  /*0x04000B55*/
    IL_008c: ldarg.0
    IL_008d: ldc.i4.2
    IL_008e: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_0093: ldc.i4.1
    IL_0094: ret
    IL_0095: ldarg.0
    IL_0096: ldc.i4.m1
    IL_0097: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_009c: ldloc.1
    IL_009d: ldfld LocalGamestate.State LocalGamestate::currentState  /*0x04000B46*/
    IL_00a2: ldc.i4.2
    IL_00a3: bne.un.s IL_00d9
    IL_00a5: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00aa: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00af: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_00b4: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00b9: callvirt int ScoreManager::get_VictoryGoldBonus()  /*0x06000D12*/
    IL_00be: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00c3: callvirt int ScoreManager::get_VictoryMutatorBonus()  /*0x06000D13*/
    IL_00c8: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00cd: callvirt int ScoreManager::get_VictoryNoRetryBonus()  /*0x06000D15*/
    IL_00d2: callvirt void SceneTransitionManager::TransitionFromGameplayToEndScreen(int,int,int,int)  /*0x060009CD*/
    IL_00d7: br.s IL_00f9
    IL_00d9: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_00de: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00e3: callvirt int ScoreManager::get_CurrentScore()  /*0x06000D11*/
    IL_00e8: ldc.i4.0
    IL_00e9: ldc.i4.0
    IL_00ea: call ScoreManager ScoreManager::get_Instance()  /*0x06000D10*/
    IL_00ef: callvirt int ScoreManager::get_DefeatNoRetryBonus()  /*0x06000D14*/
    IL_00f4: callvirt void SceneTransitionManager::TransitionFromGameplayToEndScreen(int,int,int,int)  /*0x060009CD*/
    IL_00f9: ldarg.0
    IL_00fa: ldnull
    IL_00fb: stfld object LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>2__current  /*0x04000B55*/
    IL_0100: ldarg.0
    IL_0101: ldc.i4.3
    IL_0102: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_0107: ldc.i4.1
    IL_0108: ret
    IL_0109: ldarg.0
    IL_010a: ldc.i4.m1
    IL_010b: stfld int LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>1__state  /*0x04000B54*/
    IL_0110: ldc.i4.0
    IL_0111: ret

  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600090A rva 0x2b3de attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>2__current  /*0x04000B55*/
    IL_0006: ret

  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::System.Collections.IEnumerator.Reset()  // token 0x0600090B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::System.Collections.IEnumerator.get_Current()  // token 0x0600090C rva 0x2b3de attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LocalGamestate.<WaitThenTriggerEndOfMatchScreen>d__25::<>2__current  /*0x04000B55*/
    IL_0006: ret

