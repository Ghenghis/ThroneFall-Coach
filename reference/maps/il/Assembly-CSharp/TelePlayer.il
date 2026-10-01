// ===== TelePlayer  (token 0x020002AD) =====
  .method TelePlayer::Start()  // token 0x06000EBB rva 0x424a1 attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0[] UnityEngine.Component::GetComponentsInChildren()<LevelInteractor>  /*0x2B000094*/
    IL_0007: stfld LevelInteractor[] TelePlayer::levelInteractors  /*0x0400110B*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponentInChildren()<EternalTrialsInteractor>  /*0x2B0000D3*/
    IL_0013: stfld EternalTrialsInteractor TelePlayer::eternalTrialsInteractor  /*0x0400110D*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: call !!0[] UnityEngine.Component::GetComponentsInChildren()<BonusLevelInteractor>  /*0x2B000095*/
    IL_001f: stfld BonusLevelInteractor[] TelePlayer::bonusLevelInteractors  /*0x0400110C*/
    IL_0024: ret

  .method TelePlayer::Update()  // token 0x06000EBC rva 0x424c7 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int TelePlayer::frame  /*0x04001110*/
    IL_0007: ldc.i4.1
    IL_0008: add
    IL_0009: stfld int TelePlayer::frame  /*0x04001110*/
    IL_000e: ldarg.0
    IL_000f: ldfld int TelePlayer::frame  /*0x04001110*/
    IL_0014: ldc.i4.2
    IL_0015: bne.un.s IL_001d
    IL_0017: ldarg.0
    IL_0018: call void TelePlayer::MovePlayerToTheLevelYouCameFrom()  /*0x06000EBD*/
    IL_001d: ret

  .method TelePlayer::MovePlayerToTheLevelYouCameFrom()  // token 0x06000EBD rva 0x424e8 attrs Private, HideBySig
    // code size 297 (0x129), max stack 3, init locals
    .locals ([0] SceneTransitionManager, [1] int, [2] int, [3] LevelInfo[], [4] int)
    IL_0000: ldsfld SceneTransitionManager SceneTransitionManager::instance  /*0x04000C6F*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000c: brtrue.s IL_000f
    IL_000e: ret
    IL_000f: ldloc.0
    IL_0010: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_0015: ldstr ""
    IL_001a: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_001f: brfalse.s IL_0022
    IL_0021: ret
    IL_0022: ldloc.0
    IL_0023: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_0028: ldstr "Eternal Trials"
    IL_002d: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0032: brfalse.s IL_0060
    IL_0034: ldarg.0
    IL_0035: ldfld PlayerMovement TelePlayer::playerMovement  /*0x0400110E*/
    IL_003a: ldarg.0
    IL_003b: ldfld EternalTrialsInteractor TelePlayer::eternalTrialsInteractor  /*0x0400110D*/
    IL_0040: ldfld Transform EternalTrialsInteractor::banner  /*0x04000ABA*/
    IL_0045: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004f: ldarg.0
    IL_0050: ldfld Vector3 TelePlayer::spawnOnLevelOffsetPositon  /*0x0400110F*/
    IL_0055: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_005a: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_005f: ret
    IL_0060: ldc.i4.0
    IL_0061: stloc.1
    IL_0062: br.s IL_00ab
    IL_0064: ldarg.0
    IL_0065: ldfld LevelInteractor[] TelePlayer::levelInteractors  /*0x0400110B*/
    IL_006a: ldloc.1
    IL_006b: ldelem.ref
    IL_006c: ldfld LevelInfo LevelInteractor::levelInfo  /*0x04000ACB*/
    IL_0071: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_0076: ldloc.0
    IL_0077: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_007c: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0081: brfalse.s IL_00a7
    IL_0083: ldarg.0
    IL_0084: ldfld PlayerMovement TelePlayer::playerMovement  /*0x0400110E*/
    IL_0089: ldarg.0
    IL_008a: ldfld LevelInteractor[] TelePlayer::levelInteractors  /*0x0400110B*/
    IL_008f: ldloc.1
    IL_0090: ldelem.ref
    IL_0091: callvirt Vector3 LevelInteractor::get_PlayerTeleportPosition()  /*0x0600089B*/
    IL_0096: ldarg.0
    IL_0097: ldfld Vector3 TelePlayer::spawnOnLevelOffsetPositon  /*0x0400110F*/
    IL_009c: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00a1: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_00a6: ret
    IL_00a7: ldloc.1
    IL_00a8: ldc.i4.1
    IL_00a9: add
    IL_00aa: stloc.1
    IL_00ab: ldloc.1
    IL_00ac: ldarg.0
    IL_00ad: ldfld LevelInteractor[] TelePlayer::levelInteractors  /*0x0400110B*/
    IL_00b2: ldlen
    IL_00b3: conv.i4
    IL_00b4: blt.s IL_0064
    IL_00b6: ldc.i4.0
    IL_00b7: stloc.2
    IL_00b8: br.s IL_011d
    IL_00ba: ldarg.0
    IL_00bb: ldfld BonusLevelInteractor[] TelePlayer::bonusLevelInteractors  /*0x0400110C*/
    IL_00c0: ldloc.2
    IL_00c1: ldelem.ref
    IL_00c2: ldfld LevelInfo[] BonusLevelInteractor::levelsToPick  /*0x0400127D*/
    IL_00c7: stloc.3
    IL_00c8: ldc.i4.0
    IL_00c9: stloc.s 4
    IL_00cb: br.s IL_0112
    IL_00cd: ldloc.3
    IL_00ce: ldloc.s 4
    IL_00d0: ldelem.ref
    IL_00d1: ldfld string LevelInfo::sceneName  /*0x04000B1F*/
    IL_00d6: ldloc.0
    IL_00d7: callvirt string SceneTransitionManager::get_ComingFromGameplayScene()  /*0x060009C4*/
    IL_00dc: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00e1: brfalse.s IL_010c
    IL_00e3: ldarg.0
    IL_00e4: ldfld PlayerMovement TelePlayer::playerMovement  /*0x0400110E*/
    IL_00e9: ldarg.0
    IL_00ea: ldfld BonusLevelInteractor[] TelePlayer::bonusLevelInteractors  /*0x0400110C*/
    IL_00ef: ldloc.2
    IL_00f0: ldelem.ref
    IL_00f1: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00f6: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00fb: ldarg.0
    IL_00fc: ldfld Vector3 TelePlayer::spawnOnLevelOffsetPositon  /*0x0400110F*/
    IL_0101: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0106: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_010b: ret
    IL_010c: ldloc.s 4
    IL_010e: ldc.i4.1
    IL_010f: add
    IL_0110: stloc.s 4
    IL_0112: ldloc.s 4
    IL_0114: ldloc.3
    IL_0115: ldlen
    IL_0116: conv.i4
    IL_0117: blt.s IL_00cd
    IL_0119: ldloc.2
    IL_011a: ldc.i4.1
    IL_011b: add
    IL_011c: stloc.2
    IL_011d: ldloc.2
    IL_011e: ldarg.0
    IL_011f: ldfld BonusLevelInteractor[] TelePlayer::bonusLevelInteractors  /*0x0400110C*/
    IL_0124: ldlen
    IL_0125: conv.i4
    IL_0126: blt.s IL_00ba
    IL_0128: ret

  .method TelePlayer::.ctor()  // token 0x06000EBE rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

