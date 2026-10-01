// ===== PlayerMovement  (token 0x02000238) =====
  .method PlayerMovement::ToggleTimeScale()  // token 0x06000C1B rva 0x389f7 attrs Public, Static, HideBySig
    // code size 58 (0x3a), max stack 8
    IL_0000: call float UnityEngine.Time::get_timeScale()  /*0x0A0000E0*/
    IL_0005: ldc.r4 0f
    IL_000a: bne.un.s IL_000d
    IL_000c: ret
    IL_000d: ldsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_0012: ldc.r4 1f
    IL_0017: bne.un.s IL_0025
    IL_0019: ldc.r4 2f
    IL_001e: stsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_0023: br.s IL_002f
    IL_0025: ldc.r4 1f
    IL_002a: stsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_002f: ldsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_0034: call void UnityEngine.Time::set_timeScale(float)  /*0x0A00050F*/
    IL_0039: ret

  .method PlayerMovement::get_Hp()  // token 0x06000C1C rva 0x38a32 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp PlayerMovement::hp  /*0x04000EE8*/
    IL_0006: ret

  .method PlayerMovement::get_Moving()  // token 0x06000C1D rva 0x38a3a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PlayerMovement::moving  /*0x04000EF2*/
    IL_0006: ret

  .method PlayerMovement::get_Sprinting()  // token 0x06000C1E rva 0x38a42 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PlayerMovement::sprinting  /*0x04000EF3*/
    IL_0006: ret

  .method PlayerMovement::get_Dead()  // token 0x06000C1F rva 0x38a4a attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PlayerMovement::dead  /*0x04000EF5*/
    IL_0006: ret

  .method PlayerMovement::set_Dead(bool)  // token 0x06000C20 rva 0x38a52 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool PlayerMovement::dead  /*0x04000EF5*/
    IL_0007: ret

  .method PlayerMovement::Awake()  // token 0x06000C21 rva 0x38a5b attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0006: ret

  .method PlayerMovement::TeleportTo(UnityEngine.Vector3)  // token 0x06000C22 rva 0x38a63 attrs Public, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_000c: ldarg.0
    IL_000d: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_0012: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0017: ldarg.1
    IL_0018: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_0025: call IEnumerator PlayerMovement::EnableControllerNextFrame(UnityEngine.CharacterController)  /*0x06000C29*/
    IL_002a: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_002f: pop
    IL_0030: ret

  .method PlayerMovement::TeleportToStart()  // token 0x06000C23 rva 0x38a95 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Vector3 PlayerMovement::startPosition  /*0x04000EDD*/
    IL_0007: call void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_000c: ret

  .method PlayerMovement::Start()  // token 0x06000C24 rva 0x38aa4 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 155 (0x9b), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000c: stfld Vector3 PlayerMovement::startPosition  /*0x04000EDD*/
    IL_0011: ldarg.0
    IL_0012: call void PlayerManager::RegisterPlayer(PlayerMovement)  /*0x06000C17*/
    IL_0017: ldarg.0
    IL_0018: call Camera UnityEngine.Camera::get_main()  /*0x0A000107*/
    IL_001d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0022: stfld Transform PlayerMovement::viewTransform  /*0x04000EE9*/
    IL_0027: ldarg.0
    IL_0028: ldarg.0
    IL_0029: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.CharacterController>  /*0x2B0000B3*/
    IL_002e: stfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_0033: ldarg.0
    IL_0034: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0039: ldc.i4.0
    IL_003a: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_003f: stfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_0044: ldarg.0
    IL_0045: ldarg.0
    IL_0046: call !!0 UnityEngine.Component::GetComponent()<Pathfinding.RVO.RVOController>  /*0x2B000090*/
    IL_004b: stfld RVOController PlayerMovement::rvoController  /*0x04000EED*/
    IL_0050: ldarg.0
    IL_0051: ldarg.0
    IL_0052: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0057: stfld Hp PlayerMovement::hp  /*0x04000EE8*/
    IL_005c: ldarg.0
    IL_005d: ldarg.0
    IL_005e: ldfld Equippable PlayerMovement::heavyArmorPerk  /*0x04000EF7*/
    IL_0063: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0068: stfld bool PlayerMovement::heavyArmorEquipped  /*0x04000EEF*/
    IL_006d: ldarg.0
    IL_006e: ldarg.0
    IL_006f: ldfld Equippable PlayerMovement::warHorsePerk  /*0x04000EF8*/
    IL_0074: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_0079: stfld bool PlayerMovement::racingHorseEquipped  /*0x04000EF0*/
    IL_007e: ldarg.0
    IL_007f: ldarg.0
    IL_0080: ldfld Equippable PlayerMovement::canAlwaysSprint  /*0x04000EF9*/
    IL_0085: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_008a: stfld bool PlayerMovement::canAlwaysSprintEquipped  /*0x04000EF1*/
    IL_008f: ldarg.0
    IL_0090: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0095: stfld DayNightCycle PlayerMovement::dayNightCycle  /*0x04000EFA*/
    IL_009a: ret

  .method PlayerMovement::Slow(float)  // token 0x06000C25 rva 0x38b4b attrs Public, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.0
    IL_0003: ldfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0008: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_000d: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0012: ret

  .method PlayerMovement::get_Velocity()  // token 0x06000C26 rva 0x38b5f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0006: ret

  .method PlayerMovement::Update()  // token 0x06000C27 rva 0x38b68 attrs Private, HideBySig
    // code size 528 (0x210), max stack 5, init locals
    .locals ([0] Vector2, [1] Vector3, [2] Vector3, [3] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_0006: ldstr "Change Timescale"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_0017
    IL_0012: call void PlayerMovement::ToggleTimeScale()  /*0x06000C1B*/
    IL_0017: ldloca.s 0
    IL_0019: ldarg.0
    IL_001a: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_001f: ldstr "Move Vertical"
    IL_0024: callvirt float Rewired.Player::GetAxis(string)  /*0x0A000510*/
    IL_0029: ldarg.0
    IL_002a: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_002f: ldstr "Move Horizontal"
    IL_0034: callvirt float Rewired.Player::GetAxis(string)  /*0x0A000510*/
    IL_0039: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_003e: ldarg.0
    IL_003f: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_0044: ldstr "Move Towards Mouse"
    IL_0049: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_004e: brfalse.s IL_0092
    IL_0050: call Vector3 UnityEngine.Input::get_mousePosition()  /*0x0A0003CA*/
    IL_0055: stloc.2
    IL_0056: ldloca.s 3
    IL_0058: call int UnityEngine.Screen::get_width()  /*0x0A0003B7*/
    IL_005d: ldc.i4.2
    IL_005e: div
    IL_005f: conv.r4
    IL_0060: call int UnityEngine.Screen::get_height()  /*0x0A0003B8*/
    IL_0065: ldc.i4.2
    IL_0066: div
    IL_0067: conv.r4
    IL_0068: ldc.r4 0f
    IL_006d: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0072: ldloc.2
    IL_0073: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0078: ldloc.3
    IL_0079: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_007e: sub
    IL_007f: ldloc.2
    IL_0080: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0085: ldloc.3
    IL_0086: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_008b: sub
    IL_008c: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_0091: stloc.0
    IL_0092: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0097: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_009c: brfalse.s IL_00a4
    IL_009e: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0004B6*/
    IL_00a3: stloc.0
    IL_00a4: ldarg.0
    IL_00a5: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_00aa: ldstr "Sprint Toggle"
    IL_00af: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_00b4: brfalse.s IL_00c5
    IL_00b6: ldarg.0
    IL_00b7: ldarg.0
    IL_00b8: ldfld bool PlayerMovement::sprintingToggledOn  /*0x04000EF4*/
    IL_00bd: ldc.i4.0
    IL_00be: ceq
    IL_00c0: stfld bool PlayerMovement::sprintingToggledOn  /*0x04000EF4*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld bool PlayerMovement::sprintingToggledOn  /*0x04000EF4*/
    IL_00cb: brfalse.s IL_00e6
    IL_00cd: ldarg.0
    IL_00ce: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_00d3: ldstr "Sprint"
    IL_00d8: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_00dd: brfalse.s IL_00e6
    IL_00df: ldarg.0
    IL_00e0: ldc.i4.0
    IL_00e1: stfld bool PlayerMovement::sprintingToggledOn  /*0x04000EF4*/
    IL_00e6: ldarg.0
    IL_00e7: ldarg.0
    IL_00e8: ldfld Player PlayerMovement::input  /*0x04000EEB*/
    IL_00ed: ldstr "Sprint"
    IL_00f2: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_00f7: brtrue.s IL_0101
    IL_00f9: ldarg.0
    IL_00fa: ldfld bool PlayerMovement::sprintingToggledOn  /*0x04000EF4*/
    IL_00ff: brfalse.s IL_011e
    IL_0101: ldarg.0
    IL_0102: ldfld Hp PlayerMovement::hp  /*0x04000EE8*/
    IL_0107: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_010c: ldc.r4 1f
    IL_0111: bge.s IL_011b
    IL_0113: ldarg.0
    IL_0114: ldfld bool PlayerMovement::canAlwaysSprintEquipped  /*0x04000EF1*/
    IL_0119: br.s IL_011f
    IL_011b: ldc.i4.1
    IL_011c: br.s IL_011f
    IL_011e: ldc.i4.0
    IL_011f: stfld bool PlayerMovement::sprinting  /*0x04000EF3*/
    IL_0124: ldarg.0
    IL_0125: ldloc.0
    IL_0126: callvirt void PlayerMovement::MoveScript(UnityEngine.Vector2)  /*0x06000C2A*/
    IL_012b: ldarg.0
    IL_012c: ldfld RVOController PlayerMovement::rvoController  /*0x04000EED*/
    IL_0131: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0136: brfalse.s IL_0149
    IL_0138: ldarg.0
    IL_0139: ldfld RVOController PlayerMovement::rvoController  /*0x04000EED*/
    IL_013e: ldarg.0
    IL_013f: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0144: callvirt void Pathfinding.RVO.RVOController::set_velocity(UnityEngine.Vector3)  /*0x0A0004C3*/
    IL_0149: ldloca.s 1
    IL_014b: ldarg.0
    IL_014c: ldflda Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0151: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0156: ldc.r4 0f
    IL_015b: ldarg.0
    IL_015c: ldflda Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0161: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_0166: call void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_016b: ldarg.0
    IL_016c: ldloca.s 1
    IL_016e: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0173: ldc.r4 0.1f
    IL_0178: cgt
    IL_017a: stfld bool PlayerMovement::moving  /*0x04000EF2*/
    IL_017f: ldarg.0
    IL_0180: ldfld bool PlayerMovement::moving  /*0x04000EF2*/
    IL_0185: brfalse.s IL_019e
    IL_0187: ldarg.0
    IL_0188: ldloca.s 1
    IL_018a: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_018f: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0194: call Quaternion UnityEngine.Quaternion::LookRotation(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000070*/
    IL_0199: stfld Quaternion PlayerMovement::desiredMeshRotation  /*0x04000EEC*/
    IL_019e: ldarg.0
    IL_019f: ldfld Quaternion PlayerMovement::desiredMeshRotation  /*0x04000EEC*/
    IL_01a4: ldarg.0
    IL_01a5: ldfld Transform PlayerMovement::meshParent  /*0x04000EE4*/
    IL_01aa: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_01af: call bool UnityEngine.Quaternion::op_Inequality(UnityEngine.Quaternion,UnityEngine.Quaternion)  /*0x0A000511*/
    IL_01b4: brfalse.s IL_01e3
    IL_01b6: ldarg.0
    IL_01b7: ldfld Transform PlayerMovement::meshParent  /*0x04000EE4*/
    IL_01bc: ldarg.0
    IL_01bd: ldfld Transform PlayerMovement::meshParent  /*0x04000EE4*/
    IL_01c2: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_01c7: ldarg.0
    IL_01c8: ldfld Quaternion PlayerMovement::desiredMeshRotation  /*0x04000EEC*/
    IL_01cd: ldarg.0
    IL_01ce: ldfld float PlayerMovement::maxMeshRotationSpeed  /*0x04000EE5*/
    IL_01d3: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01d8: mul
    IL_01d9: call Quaternion UnityEngine.Quaternion::RotateTowards(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A0000A2*/
    IL_01de: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_01e3: ldarg.0
    IL_01e4: ldfld Animator PlayerMovement::meshAnimator  /*0x04000EE6*/
    IL_01e9: ldstr "Moving"
    IL_01ee: ldarg.0
    IL_01ef: ldfld bool PlayerMovement::moving  /*0x04000EF2*/
    IL_01f4: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_01f9: ldarg.0
    IL_01fa: ldfld Animator PlayerMovement::meshAnimator  /*0x04000EE6*/
    IL_01ff: ldstr "Sprinting"
    IL_0204: ldarg.0
    IL_0205: ldfld bool PlayerMovement::sprinting  /*0x04000EF3*/
    IL_020a: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_020f: ret

  .method PlayerMovement::OnDisable()  // token 0x06000C28 rva 0x38d84 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator PlayerMovement::meshAnimator  /*0x04000EE6*/
    IL_0006: ldstr "Moving"
    IL_000b: ldc.i4.0
    IL_000c: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0011: ret

  .method PlayerMovement::EnableControllerNextFrame(UnityEngine.CharacterController)  // token 0x06000C29 rva 0x38d97 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerMovement.<EnableControllerNextFrame>d__52::.ctor(int)  /*0x06000C2D*/
    IL_0006: dup
    IL_0007: ldarg.1
    IL_0008: stfld CharacterController PlayerMovement.<EnableControllerNextFrame>d__52::controller  /*0x04000EFF*/
    IL_000d: ret

  .method PlayerMovement::MoveScript(UnityEngine.Vector2)  // token 0x06000C2A rva 0x38da8 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 592 (0x250), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3, [2] Vector3, [3] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld Transform PlayerMovement::viewTransform  /*0x04000EE9*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_000b: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0010: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0015: stloc.2
    IL_0016: ldloca.s 2
    IL_0018: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_001d: stloc.0
    IL_001e: ldarg.0
    IL_001f: ldfld Transform PlayerMovement::viewTransform  /*0x04000EE9*/
    IL_0024: callvirt Vector3 UnityEngine.Transform::get_right()  /*0x0A0004EE*/
    IL_0029: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_002e: call Vector3 UnityEngine.Vector3::ProjectOnPlane(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0004ED*/
    IL_0033: stloc.2
    IL_0034: ldloca.s 2
    IL_0036: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_003b: stloc.1
    IL_003c: ldarg.0
    IL_003d: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0042: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0047: ldarg.0
    IL_0048: ldarg.0
    IL_0049: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_004e: ldloc.0
    IL_004f: ldarg.1
    IL_0050: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0055: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_005a: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_005f: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0064: ldarg.0
    IL_0065: ldarg.0
    IL_0066: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_006b: ldloc.1
    IL_006c: ldarg.1
    IL_006d: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0072: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0077: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_007c: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0081: ldarg.0
    IL_0082: ldarg.0
    IL_0083: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0088: ldc.r4 1f
    IL_008d: call Vector3 UnityEngine.Vector3::ClampMagnitude(UnityEngine.Vector3,float)  /*0x0A000512*/
    IL_0092: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0097: ldarg.0
    IL_0098: call bool PlayerMovement::get_Dead()  /*0x06000C1F*/
    IL_009d: brfalse.s IL_00c6
    IL_009f: ldarg.0
    IL_00a0: ldc.r4 -1f
    IL_00a5: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_00aa: ldarg.0
    IL_00ab: ldarg.0
    IL_00ac: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld float PlayerMovement::moveSpeedWhenDead  /*0x04000EE2*/
    IL_00b7: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00bc: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_00c1: br IL_01a1
    IL_00c6: ldarg.0
    IL_00c7: ldfld DayNightCycle PlayerMovement::dayNightCycle  /*0x04000EFA*/
    IL_00cc: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_00d1: ldc.i4.0
    IL_00d2: ceq
    IL_00d4: stloc.3
    IL_00d5: ldarg.0
    IL_00d6: ldarg.0
    IL_00d7: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld bool PlayerMovement::sprinting  /*0x04000EF3*/
    IL_00e2: brtrue.s IL_00f7
    IL_00e4: ldloc.3
    IL_00e5: brtrue.s IL_00ef
    IL_00e7: ldarg.0
    IL_00e8: ldfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_00ed: br.s IL_0108
    IL_00ef: ldarg.0
    IL_00f0: ldfld float PlayerMovement::speedDuringDay  /*0x04000EDF*/
    IL_00f5: br.s IL_0108
    IL_00f7: ldloc.3
    IL_00f8: brtrue.s IL_0102
    IL_00fa: ldarg.0
    IL_00fb: ldfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0100: br.s IL_0108
    IL_0102: ldarg.0
    IL_0103: ldfld float PlayerMovement::sprintSpeedDuringDay  /*0x04000EE1*/
    IL_0108: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_010d: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0112: ldarg.0
    IL_0113: ldarg.0
    IL_0114: ldfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0119: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_011e: sub
    IL_011f: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0124: ldarg.0
    IL_0125: ldarg.0
    IL_0126: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_012b: ldarg.0
    IL_012c: ldfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0131: ldc.r4 0f
    IL_0136: bgt.s IL_013f
    IL_0138: ldc.r4 1f
    IL_013d: br.s IL_0144
    IL_013f: ldc.r4 0.33f
    IL_0144: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0149: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_014e: ldarg.0
    IL_014f: ldfld bool PlayerMovement::heavyArmorEquipped  /*0x04000EEF*/
    IL_0154: brfalse.s IL_017e
    IL_0156: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_015b: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_0160: ldc.i4.1
    IL_0161: bne.un.s IL_017e
    IL_0163: ldarg.0
    IL_0164: ldarg.0
    IL_0165: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_016a: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_016f: ldfld float PerkManager::heavyArmor_SpeedMultiplyer  /*0x04000BF3*/
    IL_0174: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0179: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_017e: ldarg.0
    IL_017f: ldfld bool PlayerMovement::racingHorseEquipped  /*0x04000EF0*/
    IL_0184: brfalse.s IL_01a1
    IL_0186: ldarg.0
    IL_0187: ldarg.0
    IL_0188: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_018d: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0192: ldfld float PerkManager::racingHorse_SpeedMultiplyer  /*0x04000BF7*/
    IL_0197: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_019c: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_01a1: ldarg.0
    IL_01a2: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_01a7: callvirt bool UnityEngine.Collider::get_enabled()  /*0x0A0001ED*/
    IL_01ac: brfalse IL_024f
    IL_01b1: ldarg.0
    IL_01b2: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_01b7: callvirt bool UnityEngine.CharacterController::get_isGrounded()  /*0x0A000513*/
    IL_01bc: brfalse.s IL_01cb
    IL_01be: ldarg.0
    IL_01bf: ldc.r4 0f
    IL_01c4: stfld float PlayerMovement::yVelocity  /*0x04000EEE*/
    IL_01c9: br.s IL_01e4
    IL_01cb: ldarg.0
    IL_01cc: ldarg.0
    IL_01cd: ldfld float PlayerMovement::yVelocity  /*0x04000EEE*/
    IL_01d2: ldarg.0
    IL_01d3: ldfld float PlayerMovement::gravity  /*0x04000EE3*/
    IL_01d8: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_01dd: mul
    IL_01de: add
    IL_01df: stfld float PlayerMovement::yVelocity  /*0x04000EEE*/
    IL_01e4: ldarg.0
    IL_01e5: ldfld CharacterController PlayerMovement::controller  /*0x04000EEA*/
    IL_01ea: ldarg.0
    IL_01eb: ldfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_01f0: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_01f5: ldarg.0
    IL_01f6: ldfld float PlayerMovement::yVelocity  /*0x04000EEE*/
    IL_01fb: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0200: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0205: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_020a: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_020f: callvirt CollisionFlags UnityEngine.CharacterController::Move(UnityEngine.Vector3)  /*0x0A000514*/
    IL_0214: pop
    IL_0215: ldarg.0
    IL_0216: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_021b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0220: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0225: ldarg.0
    IL_0226: ldfld float PlayerMovement::yFallThroughMapDetection  /*0x04000EE7*/
    IL_022b: bge.un.s IL_024f
    IL_022d: ldarg.0
    IL_022e: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0233: stfld Vector3 PlayerMovement::velocity  /*0x04000EFC*/
    IL_0238: ldarg.0
    IL_0239: ldc.r4 0f
    IL_023e: stfld float PlayerMovement::yVelocity  /*0x04000EEE*/
    IL_0243: ldarg.0
    IL_0244: ldarg.0
    IL_0245: ldfld Vector3 PlayerMovement::startPosition  /*0x04000EDD*/
    IL_024a: call void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_024f: ret

  .method PlayerMovement::.ctor()  // token 0x06000C2B rva 0x39004 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 14f
    IL_0006: stfld float PlayerMovement::speed  /*0x04000EDE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 14f
    IL_0011: stfld float PlayerMovement::speedDuringDay  /*0x04000EDF*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 23f
    IL_001c: stfld float PlayerMovement::sprintSpeed  /*0x04000EE0*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 23f
    IL_0027: stfld float PlayerMovement::sprintSpeedDuringDay  /*0x04000EE1*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 8f
    IL_0032: stfld float PlayerMovement::moveSpeedWhenDead  /*0x04000EE2*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 -19.62f
    IL_003d: stfld float PlayerMovement::gravity  /*0x04000EE3*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 360f
    IL_0048: stfld float PlayerMovement::maxMeshRotationSpeed  /*0x04000EE5*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 -10f
    IL_0053: stfld float PlayerMovement::yFallThroughMapDetection  /*0x04000EE7*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 -1f
    IL_005e: stfld float PlayerMovement::slowedFor  /*0x04000EFB*/
    IL_0063: ldarg.0
    IL_0064: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0069: ret

  .method PlayerMovement::.cctor()  // token 0x06000C2C rva 0x3907a attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: ldc.r4 1f
    IL_0005: stsfld float PlayerMovement::gameplayTimeScale  /*0x04000EDC*/
    IL_000a: ret

// ===== PlayerMovement/<EnableControllerNextFrame>d__52  (token 0x02000239) =====
  .method PlayerMovement.<EnableControllerNextFrame>d__52::.ctor(int)  // token 0x06000C2D rva 0x39086 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerMovement.<EnableControllerNextFrame>d__52::<>1__state  /*0x04000EFD*/
    IL_000d: ret

  .method PlayerMovement.<EnableControllerNextFrame>d__52::System.IDisposable.Dispose()  // token 0x06000C2E rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerMovement.<EnableControllerNextFrame>d__52::MoveNext()  // token 0x06000C2F rva 0x39098 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 64 (0x40), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerMovement.<EnableControllerNextFrame>d__52::<>1__state  /*0x04000EFD*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_002b
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int PlayerMovement.<EnableControllerNextFrame>d__52::<>1__state  /*0x04000EFD*/
    IL_0017: ldarg.0
    IL_0018: newobj void UnityEngine.WaitForEndOfFrame::.ctor()  /*0x0A00024A*/
    IL_001d: stfld object PlayerMovement.<EnableControllerNextFrame>d__52::<>2__current  /*0x04000EFE*/
    IL_0022: ldarg.0
    IL_0023: ldc.i4.1
    IL_0024: stfld int PlayerMovement.<EnableControllerNextFrame>d__52::<>1__state  /*0x04000EFD*/
    IL_0029: ldc.i4.1
    IL_002a: ret
    IL_002b: ldarg.0
    IL_002c: ldc.i4.m1
    IL_002d: stfld int PlayerMovement.<EnableControllerNextFrame>d__52::<>1__state  /*0x04000EFD*/
    IL_0032: ldarg.0
    IL_0033: ldfld CharacterController PlayerMovement.<EnableControllerNextFrame>d__52::controller  /*0x04000EFF*/
    IL_0038: ldc.i4.1
    IL_0039: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_003e: ldc.i4.0
    IL_003f: ret

  .method PlayerMovement.<EnableControllerNextFrame>d__52::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000C30 rva 0x390e4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerMovement.<EnableControllerNextFrame>d__52::<>2__current  /*0x04000EFE*/
    IL_0006: ret

  .method PlayerMovement.<EnableControllerNextFrame>d__52::System.Collections.IEnumerator.Reset()  // token 0x06000C31 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerMovement.<EnableControllerNextFrame>d__52::System.Collections.IEnumerator.get_Current()  // token 0x06000C32 rva 0x390e4 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerMovement.<EnableControllerNextFrame>d__52::<>2__current  /*0x04000EFE*/
    IL_0006: ret

