// ===== DebugController  (token 0x020000B2) =====
  .method DebugController::get_StartGameInWave()  // token 0x060003CF rva 0x10d6f attrs Public, HideBySig, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.m1
    IL_0001: ret

  .method DebugController::get_SaveLoadModeToUse()  // token 0x060003D0 rva 0x10d72 attrs Public, Static, HideBySig, SpecialName
    // code size 28 (0x1c), max stack 8
    IL_0000: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_000f
    IL_000d: ldc.i4.0
    IL_000e: ret
    IL_000f: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0014: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0019: pop
    IL_001a: ldc.i4.0
    IL_001b: ret

  .method DebugController::get_SaveTheGame()  // token 0x060003D1 rva 0x10d8f attrs Public, Static, HideBySig, SpecialName
    // code size 28 (0x1c), max stack 8
    IL_0000: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_000f
    IL_000d: ldc.i4.1
    IL_000e: ret
    IL_000f: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0014: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0019: pop
    IL_001a: ldc.i4.1
    IL_001b: ret

  .method DebugController::Start()  // token 0x060003D2 rva 0x10dac attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player DebugController::player  /*0x040004F2*/
    IL_0011: ret

  .method DebugController::Awake()  // token 0x060003D3 rva 0x10dbf attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld DebugController DebugController::instance  /*0x040004D1*/
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_002a: ret

  .method DebugController::EnableUICanvases()  // token 0x060003D4 rva 0x10deb attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldsfld NightCall NightCall::instance  /*0x040014A9*/
    IL_0005: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000a: ldc.i4.1
    IL_000b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0010: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: ldc.i4.1
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ret

  .method DebugController::Update()  // token 0x060003D5 rva 0x10e10 attrs Private, HideBySig
    // code size 1 (0x1), max stack 5, init locals
    .locals ([0] Canvas, [1] BuildSlot[], [2] int, [3] BuildSlot[], [4] int, [5] Scene, [6] LevelData, [7] Stopwatch, [8] Colorscheme)
    IL_0000: ret

  .method DebugController::LogChoice(Choice)  // token 0x060003D6 rva 0x10e1d attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_000f
    IL_0003: ldarg.1
    IL_0004: ldfld string Choice::name  /*0x04000B92*/
    IL_0009: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000e: ret
    IL_000f: ldstr "Choice cancelled."
    IL_0014: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0019: ret

  .method DebugController::Mute(float)  // token 0x060003D7 rva 0x10e38 attrs Public, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: call void ThronefallAudioManager::Mute()  /*0x0600021B*/
    IL_0005: ldarg.0
    IL_0006: ldc.i4.1
    IL_0007: stfld bool DebugController::muted  /*0x040004F0*/
    IL_000c: ldarg.1
    IL_000d: ldarg.0
    IL_000e: ldfld float DebugController::muteClock  /*0x040004EF*/
    IL_0013: ble.un.s IL_001c
    IL_0015: ldarg.0
    IL_0016: ldarg.1
    IL_0017: stfld float DebugController::muteClock  /*0x040004EF*/
    IL_001c: ret

  .method DebugController::StartNewBoundary()  // token 0x060003D8 rva 0x10e58 attrs Public, HideBySig
    // code size 115 (0x73), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002f
    IL_000e: ldarg.0
    IL_000f: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0014: callvirt !!0 UnityEngine.Component::GetComponent()<PathMesher>  /*0x2B000031*/
    IL_0019: ldc.i4.1
    IL_001a: stfld bool PathMesher::loop  /*0x040010FF*/
    IL_001f: ldarg.0
    IL_0020: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0025: callvirt !!0 UnityEngine.Component::GetComponent()<PathMesher>  /*0x2B000031*/
    IL_002a: callvirt void PathMesher::UpdateMesh()  /*0x06000EAD*/
    IL_002f: ldarg.0
    IL_0030: ldarg.0
    IL_0031: ldfld GameObject DebugController::boundariesPrefab  /*0x040004FB*/
    IL_0036: ldarg.0
    IL_0037: ldfld GameObject DebugController::invisibleWalls  /*0x040004FA*/
    IL_003c: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0041: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_0046: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_004b: stfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0050: ldarg.0
    IL_0051: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0056: callvirt !!0 UnityEngine.Component::GetComponent()<PathMesher>  /*0x2B000031*/
    IL_005b: ldc.i4.0
    IL_005c: stfld bool PathMesher::loop  /*0x040010FF*/
    IL_0061: ldarg.0
    IL_0062: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0067: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.Collider>  /*0x2B000032*/
    IL_006c: ldc.i4.0
    IL_006d: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_0072: ret

  .method DebugController::PlaceBountaryNode()  // token 0x060003D9 rva 0x10ed8 attrs Public, HideBySig
    // code size 111 (0x6f), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0014
    IL_000e: ldarg.0
    IL_000f: call void DebugController::StartNewBoundary()  /*0x060003D8*/
    IL_0014: ldstr "Node"
    IL_0019: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000D1*/
    IL_001e: dup
    IL_001f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0024: ldarg.0
    IL_0025: ldfld Transform DebugController::playerCharacter  /*0x040004FC*/
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0034: dup
    IL_0035: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_003a: ldarg.0
    IL_003b: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0040: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_0045: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_004a: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_004f: ldc.r4 7f
    IL_0054: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0059: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_005e: ldarg.0
    IL_005f: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0064: callvirt !!0 UnityEngine.Component::GetComponent()<PathMesher>  /*0x2B000031*/
    IL_0069: callvirt void PathMesher::UpdateMesh()  /*0x06000EAD*/
    IL_006e: ret

  .method DebugController::RemoveLastBoundaryNode()  // token 0x060003DA rva 0x10f53 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void DebugController.<RemoveLastBoundaryNode>d__61::.ctor(int)  /*0x060003DC*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld DebugController DebugController.<RemoveLastBoundaryNode>d__61::<>4__this  /*0x04000504*/
    IL_000d: ret

  .method DebugController::.ctor()  // token 0x060003DB rva 0x10f64 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 255 (0xff), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int DebugController::startGameInWave  /*0x040004D0*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.s 50
    IL_000a: stfld KeyCode DebugController::addCoin  /*0x040004D5*/
    IL_000f: ldarg.0
    IL_0010: ldc.i4.s 51
    IL_0012: stfld KeyCode DebugController::removeCoin  /*0x040004D6*/
    IL_0017: ldarg.0
    IL_0018: ldc.i4.s 52
    IL_001a: stfld KeyCode DebugController::getPoints  /*0x040004D7*/
    IL_001f: ldarg.0
    IL_0020: ldc.i4.s 57
    IL_0022: stfld KeyCode DebugController::upgradeAllBuildingsToMax  /*0x040004D8*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.s 54
    IL_002a: stfld KeyCode DebugController::reviveAllYourUnits  /*0x040004D9*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.s 55
    IL_0032: stfld KeyCode DebugController::killAllEnemyUnits  /*0x040004DA*/
    IL_0037: ldarg.0
    IL_0038: ldc.i4.s 114
    IL_003a: stfld KeyCode DebugController::restartScene  /*0x040004DB*/
    IL_003f: ldarg.0
    IL_0040: ldc.i4.s 116
    IL_0042: stfld KeyCode DebugController::spawnNextWave  /*0x040004DC*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.s 27
    IL_004a: stfld KeyCode DebugController::goToLevelSelect  /*0x040004DD*/
    IL_004f: ldarg.0
    IL_0050: ldc.i4 279
    IL_0055: stfld KeyCode DebugController::instaWinLevel  /*0x040004DE*/
    IL_005a: ldarg.0
    IL_005b: ldc.i4.s 108
    IL_005d: stfld KeyCode DebugController::causeLagSpike  /*0x040004DF*/
    IL_0062: ldarg.0
    IL_0063: ldc.i4.s 99
    IL_0065: stfld KeyCode DebugController::openTestChoice  /*0x040004E0*/
    IL_006a: ldarg.0
    IL_006b: ldc.i4.s 56
    IL_006d: stfld KeyCode DebugController::softWinLevel  /*0x040004E1*/
    IL_0072: ldarg.0
    IL_0073: ldc.i4.s 113
    IL_0075: stfld KeyCode DebugController::loseLevel  /*0x040004E2*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.s 45
    IL_007d: stfld KeyCode DebugController::deletePlayerPrefs  /*0x040004E3*/
    IL_0082: ldarg.0
    IL_0083: ldc.i4.s 107
    IL_0085: stfld KeyCode DebugController::killPlayer  /*0x040004E4*/
    IL_008a: ldarg.0
    IL_008b: ldc.i4 269
    IL_0090: stfld KeyCode DebugController::enableDisableUI  /*0x040004E5*/
    IL_0095: ldarg.0
    IL_0096: ldc.i4.s 110
    IL_0098: stfld KeyCode DebugController::printNextWaveInfo  /*0x040004E6*/
    IL_009d: ldarg.0
    IL_009e: ldc.i4.s 99
    IL_00a0: stfld KeyCode DebugController::changeColorscheme  /*0x040004E7*/
    IL_00a5: ldarg.0
    IL_00a6: ldc.i4.m1
    IL_00a7: stfld int DebugController::currentColorscheme  /*0x040004E9*/
    IL_00ac: ldarg.0
    IL_00ad: ldc.i4.s 110
    IL_00af: stfld KeyCode DebugController::changeNextWave  /*0x040004EA*/
    IL_00b4: ldarg.0
    IL_00b5: ldc.r4 0.2f
    IL_00ba: stfld float DebugController::buildFastTime  /*0x040004EC*/
    IL_00bf: ldarg.0
    IL_00c0: ldc.i4.s 98
    IL_00c2: stfld KeyCode DebugController::placeBounteryNode  /*0x040004F4*/
    IL_00c7: ldarg.0
    IL_00c8: ldstr ""
    IL_00cd: stfld string DebugController::placeBounteryNodeRewired  /*0x040004F5*/
    IL_00d2: ldarg.0
    IL_00d3: ldc.i4.s 118
    IL_00d5: stfld KeyCode DebugController::startNewBoundary  /*0x040004F6*/
    IL_00da: ldarg.0
    IL_00db: ldstr ""
    IL_00e0: stfld string DebugController::startNewBoundaryRewired  /*0x040004F7*/
    IL_00e5: ldarg.0
    IL_00e6: ldc.i4.s 122
    IL_00e8: stfld KeyCode DebugController::removeLastBoundaryNode  /*0x040004F8*/
    IL_00ed: ldarg.0
    IL_00ee: ldstr ""
    IL_00f3: stfld string DebugController::removeLastBoundaryNodeRewired  /*0x040004F9*/
    IL_00f8: ldarg.0
    IL_00f9: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_00fe: ret

// ===== DebugController/SaveLoadMode  (token 0x020000B3) =====
// ===== DebugController/<RemoveLastBoundaryNode>d__61  (token 0x020000B4) =====
  .method DebugController.<RemoveLastBoundaryNode>d__61::.ctor(int)  // token 0x060003DC rva 0x1106f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int DebugController.<RemoveLastBoundaryNode>d__61::<>1__state  /*0x04000502*/
    IL_000d: ret

  .method DebugController.<RemoveLastBoundaryNode>d__61::System.IDisposable.Dispose()  // token 0x060003DD rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method DebugController.<RemoveLastBoundaryNode>d__61::MoveNext()  // token 0x060003DE rva 0x11080 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 133 (0x85), max stack 3, init locals
    .locals ([0] int, [1] DebugController)
    IL_0000: ldarg.0
    IL_0001: ldfld int DebugController.<RemoveLastBoundaryNode>d__61::<>1__state  /*0x04000502*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld DebugController DebugController.<RemoveLastBoundaryNode>d__61::<>4__this  /*0x04000504*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_006c
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int DebugController.<RemoveLastBoundaryNode>d__61::<>1__state  /*0x04000502*/
    IL_001e: ldloc.1
    IL_001f: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002a: brfalse.s IL_0083
    IL_002c: ldloc.1
    IL_002d: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0032: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0037: ldc.i4.0
    IL_0038: ble.s IL_0083
    IL_003a: ldloc.1
    IL_003b: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0040: ldloc.1
    IL_0041: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0046: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_004b: ldc.i4.1
    IL_004c: sub
    IL_004d: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0052: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0057: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_005c: ldarg.0
    IL_005d: ldnull
    IL_005e: stfld object DebugController.<RemoveLastBoundaryNode>d__61::<>2__current  /*0x04000503*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.1
    IL_0065: stfld int DebugController.<RemoveLastBoundaryNode>d__61::<>1__state  /*0x04000502*/
    IL_006a: ldc.i4.1
    IL_006b: ret
    IL_006c: ldarg.0
    IL_006d: ldc.i4.m1
    IL_006e: stfld int DebugController.<RemoveLastBoundaryNode>d__61::<>1__state  /*0x04000502*/
    IL_0073: ldloc.1
    IL_0074: ldfld Transform DebugController::currentBoundaryParent  /*0x040004FD*/
    IL_0079: callvirt !!0 UnityEngine.Component::GetComponent()<PathMesher>  /*0x2B000031*/
    IL_007e: callvirt void PathMesher::UpdateMesh()  /*0x06000EAD*/
    IL_0083: ldc.i4.0
    IL_0084: ret

  .method DebugController.<RemoveLastBoundaryNode>d__61::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060003DF rva 0x11111 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DebugController.<RemoveLastBoundaryNode>d__61::<>2__current  /*0x04000503*/
    IL_0006: ret

  .method DebugController.<RemoveLastBoundaryNode>d__61::System.Collections.IEnumerator.Reset()  // token 0x060003E0 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method DebugController.<RemoveLastBoundaryNode>d__61::System.Collections.IEnumerator.get_Current()  // token 0x060003E1 rva 0x11111 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object DebugController.<RemoveLastBoundaryNode>d__61::<>2__current  /*0x04000503*/
    IL_0006: ret

