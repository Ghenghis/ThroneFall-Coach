// ===== PlayerInteraction  (token 0x02000236) =====
  .method PlayerInteraction::get_Networth()  // token 0x06000BFA rva 0x381d8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerInteraction::networth  /*0x04000EC6*/
    IL_0006: ret

  .method PlayerInteraction::get_ManualAttack()  // token 0x06000BFB rva 0x381e0 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ManualAttack PlayerInteraction::manualAttack  /*0x04000EC4*/
    IL_0006: ret

  .method PlayerInteraction::get_AutoAttack()  // token 0x06000BFC rva 0x381e8 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ManualAttack PlayerInteraction::autoAttack  /*0x04000EC5*/
    IL_0006: ret

  .method PlayerInteraction::get_IsFreeToCallNight()  // token 0x06000BFD rva 0x381f0 attrs Public, HideBySig, SpecialName
    // code size 76 (0x4c), max stack 2, init locals
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_000a: brtrue.s IL_004a
    IL_000c: ldarg.0
    IL_000d: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_004a
    IL_001a: ldarg.0
    IL_001b: ldfld TagManager PlayerInteraction::tagManager  /*0x04000ECD*/
    IL_0020: ldc.i4.3
    IL_0021: callvirt int TagManager::CountObjectsWithTag(TagManager.ETag)  /*0x06000E5A*/
    IL_0026: ldc.i4.0
    IL_0027: ble.s IL_004a
    IL_0029: call bool TutorialManager::get_AllowStartingTheNight()  /*0x06000F1C*/
    IL_002e: brfalse.s IL_004a
    IL_0030: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0035: callvirt bool EnemySpawner::get_MatchOver()  /*0x0600066F*/
    IL_003a: brtrue.s IL_004a
    IL_003c: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0041: callvirt LocalGamestate.State LocalGamestate::get_CurrentState()  /*0x060008FD*/
    IL_0046: ldc.i4.1
    IL_0047: ceq
    IL_0049: ret
    IL_004a: ldc.i4.0
    IL_004b: ret

  .method PlayerInteraction::OnBeforeMainLoadPass(string)  // token 0x06000BFE rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerInteraction::OnAfterMainLoadPass(string)  // token 0x06000BFF rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerInteraction::OnLoad(string)  // token 0x06000C00 rva 0x38248 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 72 (0x48), max stack 3, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.1
    IL_0001: ldstr "balance"
    IL_0006: ldarg.0
    IL_0007: ldflda int PlayerInteraction::balance  /*0x04000EBE*/
    IL_000c: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0011: pop
    IL_0012: ldc.i4.0
    IL_0013: ldarg.0
    IL_0014: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_001e: stloc.0
    IL_001f: ldloca.s 0
    IL_0021: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0026: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_002b: brfalse.s IL_0047
    IL_002d: ldc.i4.0
    IL_002e: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0033: brfalse.s IL_0047
    IL_0035: ldarg.1
    IL_0036: ldstr "energyCoreBalance"
    IL_003b: ldarg.0
    IL_003c: ldflda int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_0041: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_0046: pop
    IL_0047: ret

  .method PlayerInteraction::OnSave(string)  // token 0x06000C01 rva 0x3829c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 70 (0x46), max stack 3, init locals
    .locals ([0] Scene)
    IL_0000: ldarg.1
    IL_0001: ldstr "balance"
    IL_0006: ldarg.0
    IL_0007: call int PlayerInteraction::get_TrueBalance()  /*0x06000C06*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ldc.i4.0
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: callvirt Scene UnityEngine.GameObject::get_scene()  /*0x0A00011A*/
    IL_001d: stloc.0
    IL_001e: ldloca.s 0
    IL_0020: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_0025: call bool DlcConfiguration::IsDlcMap(IDlcProvider.DlcId,string)  /*0x0600001D*/
    IL_002a: brfalse.s IL_0045
    IL_002c: ldc.i4.0
    IL_002d: call bool DlcConfiguration::IsDlcAvailable(IDlcProvider.DlcId)  /*0x0600001C*/
    IL_0032: brfalse.s IL_0045
    IL_0034: ldarg.1
    IL_0035: ldstr "energyCoreBalance"
    IL_003a: ldarg.0
    IL_003b: call int PlayerInteraction::get_TrueEnergyCoreBalance()  /*0x06000C07*/
    IL_0040: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0045: ret

  .method PlayerInteraction::Awake()  // token 0x06000C02 rva 0x382ee attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0006: ret

  .method PlayerInteraction::EquipWeapon(ManualAttack,ManualAttack)  // token 0x06000C03 rva 0x382f6 attrs Public, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ManualAttack PlayerInteraction::manualAttack  /*0x04000EC4*/
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerCharacterAudio PlayerInteraction::playerAudio  /*0x04000EC7*/
    IL_000d: ldarg.0
    IL_000e: ldfld ManualAttack PlayerInteraction::manualAttack  /*0x04000EC4*/
    IL_0013: callvirt void PlayerCharacterAudio::OnWeaponEquip(ManualAttack)  /*0x060001F7*/
    IL_0018: ldarg.0
    IL_0019: ldarg.2
    IL_001a: stfld ManualAttack PlayerInteraction::autoAttack  /*0x04000EC5*/
    IL_001f: ret

  .method PlayerInteraction::get_Balance()  // token 0x06000C04 rva 0x38317 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_0006: ret

  .method PlayerInteraction::get_EnergyCoreBalance()  // token 0x06000C05 rva 0x3831f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_0006: ret

  .method PlayerInteraction::get_TrueBalance()  // token 0x06000C06 rva 0x38327 attrs Public, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldfld List<Coin> TagManager::coins  /*0x04001094*/
    IL_0010: callvirt int System.Collections.Generic.List<Coin>::get_Count()  /*0x0A0001A8*/
    IL_0015: add
    IL_0016: call int CoinSpawner::get_AllCoinsLeftToBeSpawned()  /*0x06000346*/
    IL_001b: add
    IL_001c: ret

  .method PlayerInteraction::get_TrueEnergyCoreBalance()  // token 0x06000C07 rva 0x38345 attrs Public, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_0006: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_000b: ldfld List<EnergyCore> TagManager::energyCores  /*0x04001096*/
    IL_0010: callvirt int System.Collections.Generic.List<EnergyCore>::get_Count()  /*0x0A000505*/
    IL_0015: add
    IL_0016: call int EnergyCoreSpawner::get_AllAllEnergyCoresLeftToBeSpawned()  /*0x060006B6*/
    IL_001b: add
    IL_001c: ret

  .method PlayerInteraction::get_FocussedInteractor()  // token 0x06000C08 rva 0x38363 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0006: ret

  .method PlayerInteraction::Start()  // token 0x06000C09 rva 0x3836b attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_000c: stfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0011: ldarg.0
    IL_0012: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0017: stfld TagManager PlayerInteraction::tagManager  /*0x04000ECD*/
    IL_001c: ret

  .method PlayerInteraction::Update()  // token 0x06000C0A rva 0x38389 attrs Private, HideBySig
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PlayerInteraction::FetchCoins()  /*0x06000C0D*/
    IL_0006: ldarg.0
    IL_0007: call void PlayerInteraction::FetchInteractors()  /*0x06000C0C*/
    IL_000c: ldarg.0
    IL_000d: call void PlayerInteraction::RunInteraction()  /*0x06000C0B*/
    IL_0012: ret

  .method PlayerInteraction::RunInteraction()  // token 0x06000C0B rva 0x383a0 attrs Private, HideBySig
    // code size 200 (0xc8), max stack 2, init locals
    IL_0000: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0005: callvirt bool LocalGamestate::get_PlayerFrozen()  /*0x060008FF*/
    IL_000a: brfalse.s IL_000d
    IL_000c: ret
    IL_000d: ldarg.0
    IL_000e: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0013: ldstr "Interact"
    IL_0018: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_001d: brfalse.s IL_0052
    IL_001f: ldarg.0
    IL_0020: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0025: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_002a: brfalse.s IL_003a
    IL_002c: ldarg.0
    IL_002d: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0032: ldarg.0
    IL_0033: callvirt void InteractorBase::InteractionBegin(PlayerInteraction)  /*0x06000BE9*/
    IL_0038: br.s IL_0052
    IL_003a: ldarg.0
    IL_003b: ldfld ManualAttack PlayerInteraction::manualAttack  /*0x04000EC4*/
    IL_0040: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0045: brfalse.s IL_0052
    IL_0047: ldarg.0
    IL_0048: ldfld ManualAttack PlayerInteraction::manualAttack  /*0x04000EC4*/
    IL_004d: callvirt void ManualAttack::TryToAttack()  /*0x06000A05*/
    IL_0052: ldarg.0
    IL_0053: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0058: ldstr "Interact"
    IL_005d: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0062: brfalse.s IL_007d
    IL_0064: ldarg.0
    IL_0065: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_006a: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_006f: brfalse.s IL_007d
    IL_0071: ldarg.0
    IL_0072: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0077: ldarg.0
    IL_0078: callvirt void InteractorBase::InteractionHold(PlayerInteraction)  /*0x06000BEA*/
    IL_007d: ldarg.0
    IL_007e: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0083: ldstr "Interact"
    IL_0088: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_008d: brfalse.s IL_00a8
    IL_008f: ldarg.0
    IL_0090: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0095: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009a: brfalse.s IL_00a8
    IL_009c: ldarg.0
    IL_009d: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_00a2: ldarg.0
    IL_00a3: callvirt void InteractorBase::InteractionEnd(PlayerInteraction)  /*0x06000BEB*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_00ae: ldstr "Preview Build Options"
    IL_00b3: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_00b8: brfalse.s IL_00c1
    IL_00ba: ldc.i4.1
    IL_00bb: stsfld bool BuildingInteractor::displayAllBuildPreviews  /*0x04000E88*/
    IL_00c0: ret
    IL_00c1: ldc.i4.0
    IL_00c2: stsfld bool BuildingInteractor::displayAllBuildPreviews  /*0x04000E88*/
    IL_00c7: ret

  .method PlayerInteraction::FetchInteractors()  // token 0x06000C0C rva 0x38474 attrs Private, HideBySig
    // code size 557 (0x22d), max stack 4, init locals
    .locals ([0] int, [1] InteractorBase, [2] InteractorBase, [3] BuildingRangeIndicator, [4] float, [5] int, [6] Collider, [7] float, [8] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0006: ldstr "Call Night"
    IL_000b: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0010: brtrue.s IL_0024
    IL_0012: ldarg.0
    IL_0013: ldfld Player PlayerInteraction::input  /*0x04000ED9*/
    IL_0018: ldstr "Interact"
    IL_001d: callvirt bool Rewired.Player::GetButton(string)  /*0x0A00005B*/
    IL_0022: brfalse.s IL_0025
    IL_0024: ret
    IL_0025: ldarg.0
    IL_0026: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_002b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0030: brfalse.s IL_0052
    IL_0032: ldarg.0
    IL_0033: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0038: isinst BuildingInteractor  /*0x02000230*/
    IL_003d: brfalse.s IL_0052
    IL_003f: ldarg.0
    IL_0040: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0045: isinst BuildingInteractor  /*0x02000230*/
    IL_004a: callvirt bool BuildingInteractor::get_IsWaitingForChoice()  /*0x06000BAC*/
    IL_004f: brfalse.s IL_0052
    IL_0051: ret
    IL_0052: ldarg.0
    IL_0053: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0058: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005d: ldarg.0
    IL_005e: ldfld float PlayerInteraction::interactionRadius  /*0x04000EC2*/
    IL_0063: ldarg.0
    IL_0064: ldfld Collider[] PlayerInteraction::overlappingInteractors  /*0x04000ECB*/
    IL_0069: ldarg.0
    IL_006a: ldfld LayerMask PlayerInteraction::interactorLayer  /*0x04000EC3*/
    IL_006f: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0074: call int UnityEngine.Physics::OverlapSphereNonAlloc(UnityEngine.Vector3,float,UnityEngine.Collider[],int)  /*0x0A0004F2*/
    IL_0079: stloc.0
    IL_007a: ldnull
    IL_007b: stloc.2
    IL_007c: ldnull
    IL_007d: stloc.3
    IL_007e: ldarg.0
    IL_007f: ldnull
    IL_0080: stfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_0085: ldc.r4 Infinityf
    IL_008a: stloc.s 4
    IL_008c: ldc.i4.0
    IL_008d: stloc.s 5
    IL_008f: br.s IL_0101
    IL_0091: ldarg.0
    IL_0092: ldfld Collider[] PlayerInteraction::overlappingInteractors  /*0x04000ECB*/
    IL_0097: ldloc.s 5
    IL_0099: ldelem.ref
    IL_009a: stloc.s 6
    IL_009c: ldloc.s 6
    IL_009e: callvirt !!0 UnityEngine.Component::GetComponent()<InteractorBase>  /*0x2B0000AF*/
    IL_00a3: stloc.1
    IL_00a4: ldloc.s 6
    IL_00a6: callvirt !!0 UnityEngine.Component::GetComponent()<BuildingRangeIndicator>  /*0x2B0000B0*/
    IL_00ab: stloc.3
    IL_00ac: ldloc.3
    IL_00ad: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00b2: brfalse.s IL_00bb
    IL_00b4: ldarg.0
    IL_00b5: ldloc.3
    IL_00b6: stfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_00bb: ldloc.1
    IL_00bc: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00c1: brfalse.s IL_00fb
    IL_00c3: ldloc.1
    IL_00c4: callvirt bool InteractorBase::get_CanBeInteractedWith()  /*0x06000BE8*/
    IL_00c9: brfalse.s IL_00fb
    IL_00cb: ldarg.0
    IL_00cc: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00d1: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00d6: ldloc.s 6
    IL_00d8: ldarg.0
    IL_00d9: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00de: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00e3: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_00e8: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_00ed: stloc.s 7
    IL_00ef: ldloc.s 7
    IL_00f1: ldloc.s 4
    IL_00f3: bge.un.s IL_00fb
    IL_00f5: ldloc.1
    IL_00f6: stloc.2
    IL_00f7: ldloc.s 7
    IL_00f9: stloc.s 4
    IL_00fb: ldloc.s 5
    IL_00fd: ldc.i4.1
    IL_00fe: add
    IL_00ff: stloc.s 5
    IL_0101: ldloc.s 5
    IL_0103: ldloc.0
    IL_0104: blt.s IL_0091
    IL_0106: ldarg.0
    IL_0107: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_010c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0111: brfalse.s IL_014c
    IL_0113: ldarg.0
    IL_0114: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0119: ldloc.2
    IL_011a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_011f: brfalse.s IL_014c
    IL_0121: ldarg.0
    IL_0122: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0127: isinst BuildingInteractor  /*0x02000230*/
    IL_012c: brfalse.s IL_0139
    IL_012e: ldarg.0
    IL_012f: ldfld UnityEvent PlayerInteraction::onUnfocusPaymentInteraction  /*0x04000ED4*/
    IL_0134: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0139: ldarg.0
    IL_013a: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_013f: ldarg.0
    IL_0140: callvirt void InteractorBase::Unfocus(PlayerInteraction)  /*0x06000BED*/
    IL_0145: ldarg.0
    IL_0146: ldnull
    IL_0147: stfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_014c: ldloc.2
    IL_014d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0152: brfalse.s IL_0183
    IL_0154: ldloc.2
    IL_0155: ldarg.0
    IL_0156: ldfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_015b: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0160: brfalse.s IL_0183
    IL_0162: ldloc.2
    IL_0163: isinst BuildingInteractor  /*0x02000230*/
    IL_0168: brfalse.s IL_0175
    IL_016a: ldarg.0
    IL_016b: ldfld UnityEvent PlayerInteraction::onFocusPaymentInteraction  /*0x04000ED3*/
    IL_0170: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0175: ldloc.2
    IL_0176: ldarg.0
    IL_0177: callvirt void InteractorBase::Focus(PlayerInteraction)  /*0x06000BEC*/
    IL_017c: ldarg.0
    IL_017d: ldloc.2
    IL_017e: stfld InteractorBase PlayerInteraction::focussedInteractor  /*0x04000ED8*/
    IL_0183: ldarg.0
    IL_0184: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_0189: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_018e: brfalse.s IL_01ea
    IL_0190: ldarg.0
    IL_0191: ldfld BuildingRangeIndicator PlayerInteraction::lastBuildingRangeIndicator  /*0x04000ECE*/
    IL_0196: ldarg.0
    IL_0197: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_019c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01a1: brfalse.s IL_01ea
    IL_01a3: ldarg.0
    IL_01a4: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_01a9: callvirt void BuildingRangeIndicator::Activate()  /*0x06000FB7*/
    IL_01ae: ldarg.0
    IL_01af: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_01b4: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01b9: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_01be: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01c3: stloc.s 8
    IL_01c5: ldloc.s 8
    IL_01c7: ldnull
    IL_01c8: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01cd: brfalse.s IL_01ea
    IL_01cf: ldloc.s 8
    IL_01d1: ldc.i4.1
    IL_01d2: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren(bool)<AutoAttack>  /*0x2B0000B1*/
    IL_01d7: ldnull
    IL_01d8: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_01dd: brfalse.s IL_01ea
    IL_01df: ldarg.0
    IL_01e0: ldfld UnityEvent PlayerInteraction::onFocusInteraction  /*0x04000ED5*/
    IL_01e5: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_01ea: ldarg.0
    IL_01eb: ldfld BuildingRangeIndicator PlayerInteraction::lastBuildingRangeIndicator  /*0x04000ECE*/
    IL_01f0: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01f5: brfalse.s IL_0220
    IL_01f7: ldarg.0
    IL_01f8: ldfld BuildingRangeIndicator PlayerInteraction::lastBuildingRangeIndicator  /*0x04000ECE*/
    IL_01fd: ldarg.0
    IL_01fe: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_0203: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0208: brfalse.s IL_0220
    IL_020a: ldarg.0
    IL_020b: ldfld BuildingRangeIndicator PlayerInteraction::lastBuildingRangeIndicator  /*0x04000ECE*/
    IL_0210: callvirt void BuildingRangeIndicator::Deactivate()  /*0x06000FBC*/
    IL_0215: ldarg.0
    IL_0216: ldfld UnityEvent PlayerInteraction::onUnfocusInteraction  /*0x04000ED6*/
    IL_021b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0220: ldarg.0
    IL_0221: ldarg.0
    IL_0222: ldfld BuildingRangeIndicator PlayerInteraction::buildingRangeIndicatorThisFrame  /*0x04000ECC*/
    IL_0227: stfld BuildingRangeIndicator PlayerInteraction::lastBuildingRangeIndicator  /*0x04000ECE*/
    IL_022c: ret

  .method PlayerInteraction::FetchCoins()  // token 0x06000C0D rva 0x386b0 attrs Private, HideBySig
    // code size 91 (0x5b), max stack 4, init locals
    .locals ([0] int, [1] Coin, [2] int)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld float PlayerInteraction::coinMagnetRadius  /*0x04000EC0*/
    IL_0011: ldarg.0
    IL_0012: ldfld Collider[] PlayerInteraction::overlappingCoins  /*0x04000ECA*/
    IL_0017: ldarg.0
    IL_0018: ldfld LayerMask PlayerInteraction::coinLayer  /*0x04000EC1*/
    IL_001d: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0022: call int UnityEngine.Physics::OverlapSphereNonAlloc(UnityEngine.Vector3,float,UnityEngine.Collider[],int)  /*0x0A0004F2*/
    IL_0027: stloc.0
    IL_0028: ldc.i4.0
    IL_0029: stloc.2
    IL_002a: br.s IL_0056
    IL_002c: ldarg.0
    IL_002d: ldfld Collider[] PlayerInteraction::overlappingCoins  /*0x04000ECA*/
    IL_0032: ldloc.2
    IL_0033: ldelem.ref
    IL_0034: callvirt !!0 UnityEngine.Component::GetComponent()<Coin>  /*0x2B0000B2*/
    IL_0039: stloc.1
    IL_003a: ldloc.1
    IL_003b: ldnull
    IL_003c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0041: brfalse.s IL_0052
    IL_0043: ldloc.1
    IL_0044: callvirt bool Coin::get_IsFree()  /*0x0600033D*/
    IL_0049: brfalse.s IL_0052
    IL_004b: ldloc.1
    IL_004c: ldarg.0
    IL_004d: callvirt void Coin::SetTarget(PlayerInteraction)  /*0x06000340*/
    IL_0052: ldloc.2
    IL_0053: ldc.i4.1
    IL_0054: add
    IL_0055: stloc.2
    IL_0056: ldloc.2
    IL_0057: ldloc.0
    IL_0058: blt.s IL_002c
    IL_005a: ret

  .method PlayerInteraction::AddCoin(int)  // token 0x06000C0E rva 0x38717 attrs Public, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_0007: ldarg.1
    IL_0008: add
    IL_0009: stfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld int PlayerInteraction::networth  /*0x04000EC6*/
    IL_0015: ldarg.1
    IL_0016: add
    IL_0017: stfld int PlayerInteraction::networth  /*0x04000EC6*/
    IL_001c: ldarg.0
    IL_001d: ldfld UnityEvent<int> PlayerInteraction::onBalanceGain  /*0x04000ECF*/
    IL_0022: ldarg.1
    IL_0023: callvirt void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_0028: ret

  .method PlayerInteraction::SpendCoins(int)  // token 0x06000C0F rva 0x38744 attrs Public, HideBySig
    // code size 67 (0x43), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_0007: ldarg.1
    IL_0008: sub
    IL_0009: stfld int PlayerInteraction::balance  /*0x04000EBE*/
    IL_000e: ldarg.0
    IL_000f: ldfld UnityEvent<int> PlayerInteraction::onBalanceSpend  /*0x04000ED0*/
    IL_0014: ldarg.1
    IL_0015: callvirt void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_001a: ldarg.0
    IL_001b: ldfld GameObject PlayerInteraction::coinSpendFX  /*0x04000EC8*/
    IL_0020: ldarg.0
    IL_0021: ldfld Transform PlayerInteraction::coinSpendFXOrigin  /*0x04000EC9*/
    IL_0026: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002b: ldarg.0
    IL_002c: ldfld Transform PlayerInteraction::coinSpendFXOrigin  /*0x04000EC9*/
    IL_0031: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0036: ldarg.0
    IL_0037: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_0041: pop
    IL_0042: ret

  .method PlayerInteraction::AddEnergyCores(int)  // token 0x06000C10 rva 0x38793 attrs Public, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_0007: ldarg.1
    IL_0008: add
    IL_0009: stfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_000e: ldarg.0
    IL_000f: ldfld UnityEvent<int> PlayerInteraction::onEnergyCoreBalanceGain  /*0x04000ED1*/
    IL_0014: dup
    IL_0015: brtrue.s IL_0019
    IL_0017: pop
    IL_0018: ret
    IL_0019: ldarg.1
    IL_001a: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_001f: ret

  .method PlayerInteraction::SpendEnergyCores(int)  // token 0x06000C11 rva 0x387b4 attrs Public, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_0007: ldarg.1
    IL_0008: sub
    IL_0009: stfld int PlayerInteraction::energyCoreBalance  /*0x04000EBF*/
    IL_000e: ldarg.0
    IL_000f: ldfld UnityEvent<int> PlayerInteraction::onEnergyCoreBalanceSpend  /*0x04000ED2*/
    IL_0014: dup
    IL_0015: brtrue.s IL_0019
    IL_0017: pop
    IL_0018: ret
    IL_0019: ldarg.1
    IL_001a: call void UnityEngine.Events.UnityEvent<int>::Invoke(!0)  /*0x0A000209*/
    IL_001f: ret

  .method PlayerInteraction::OnDrawGizmosSelected()  // token 0x06000C12 rva 0x387d8 attrs Private, HideBySig
    // code size 65 (0x41), max stack 2, init locals
    IL_0000: call Color UnityEngine.Color::get_blue()  /*0x0A000506*/
    IL_0005: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_000a: ldarg.0
    IL_000b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0010: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0015: ldarg.0
    IL_0016: ldfld float PlayerInteraction::interactionRadius  /*0x04000EC2*/
    IL_001b: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_0020: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0025: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_002a: ldarg.0
    IL_002b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0030: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0035: ldarg.0
    IL_0036: ldfld float PlayerInteraction::coinMagnetRadius  /*0x04000EC0*/
    IL_003b: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_0040: ret

  .method PlayerInteraction::.ctor()  // token 0x06000C13 rva 0x38828 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 143 (0x8f), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float PlayerInteraction::coinMagnetRadius  /*0x04000EC0*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float PlayerInteraction::interactionRadius  /*0x04000EC2*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.s 32
    IL_0019: newarr UnityEngine.Collider  /*0x01000032*/
    IL_001e: stfld Collider[] PlayerInteraction::overlappingCoins  /*0x04000ECA*/
    IL_0023: ldarg.0
    IL_0024: ldc.i4.s 32
    IL_0026: newarr UnityEngine.Collider  /*0x01000032*/
    IL_002b: stfld Collider[] PlayerInteraction::overlappingInteractors  /*0x04000ECB*/
    IL_0030: ldarg.0
    IL_0031: newobj void UnityEngine.Events.UnityEvent<int>::.ctor()  /*0x0A000507*/
    IL_0036: stfld UnityEvent<int> PlayerInteraction::onBalanceGain  /*0x04000ECF*/
    IL_003b: ldarg.0
    IL_003c: newobj void UnityEngine.Events.UnityEvent<int>::.ctor()  /*0x0A000507*/
    IL_0041: stfld UnityEvent<int> PlayerInteraction::onBalanceSpend  /*0x04000ED0*/
    IL_0046: ldarg.0
    IL_0047: newobj void UnityEngine.Events.UnityEvent<int>::.ctor()  /*0x0A000507*/
    IL_004c: stfld UnityEvent<int> PlayerInteraction::onEnergyCoreBalanceGain  /*0x04000ED1*/
    IL_0051: ldarg.0
    IL_0052: newobj void UnityEngine.Events.UnityEvent<int>::.ctor()  /*0x0A000507*/
    IL_0057: stfld UnityEvent<int> PlayerInteraction::onEnergyCoreBalanceSpend  /*0x04000ED2*/
    IL_005c: ldarg.0
    IL_005d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0062: stfld UnityEvent PlayerInteraction::onFocusPaymentInteraction  /*0x04000ED3*/
    IL_0067: ldarg.0
    IL_0068: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_006d: stfld UnityEvent PlayerInteraction::onUnfocusPaymentInteraction  /*0x04000ED4*/
    IL_0072: ldarg.0
    IL_0073: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0078: stfld UnityEvent PlayerInteraction::onFocusInteraction  /*0x04000ED5*/
    IL_007d: ldarg.0
    IL_007e: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0083: stfld UnityEvent PlayerInteraction::onUnfocusInteraction  /*0x04000ED6*/
    IL_0088: ldarg.0
    IL_0089: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_008e: ret

