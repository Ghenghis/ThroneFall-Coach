// ===== PlayerWeaponAudio  (token 0x02000057) =====
  .method PlayerWeaponAudio::get_AttackSound()  // token 0x060001FE rva 0x8622 attrs Public, HideBySig, SpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool PlayerWeaponAudio::initialized  /*0x0400025F*/
    IL_0006: brtrue.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void PlayerWeaponAudio::Initialize()  /*0x060001FF*/
    IL_000e: ldarg.0
    IL_000f: ldfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_0014: ret

  .method PlayerWeaponAudio::Initialize()  // token 0x060001FF rva 0x8638 attrs Private, HideBySig
    // code size 276 (0x114), max stack 2, init locals
    .locals ([0] PlayerWeaponAudio.WeaponType)
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerWeaponAudio.WeaponType PlayerWeaponAudio::weaponType  /*0x0400025B*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: switch (IL_006a, IL_0050, IL_0036, IL_0084, IL_009b, IL_00b2, IL_00c9, IL_00e0, IL_00f7)
    IL_0031: br IL_010c
    IL_0036: ldarg.0
    IL_0037: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_003c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0041: callvirt AudioSet.ClipArray AudioSet::get_PlayerBow()  /*0x060001BC*/
    IL_0046: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_004b: br IL_010c
    IL_0050: ldarg.0
    IL_0051: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0056: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_005b: callvirt AudioSet.ClipArray AudioSet::get_PlayerSpear()  /*0x060001C2*/
    IL_0060: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_0065: br IL_010c
    IL_006a: ldarg.0
    IL_006b: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0070: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0075: callvirt AudioSet.ClipArray AudioSet::get_PlayerSword()  /*0x060001BA*/
    IL_007a: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_007f: br IL_010c
    IL_0084: ldarg.0
    IL_0085: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_008a: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_008f: callvirt AudioSet.ClipArray AudioSet::get_PlayerLightningWand()  /*0x060001C3*/
    IL_0094: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_0099: br.s IL_010c
    IL_009b: ldarg.0
    IL_009c: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00a1: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00a6: callvirt AudioSet.ClipArray AudioSet::get_PlayerShadowCodex()  /*0x060001C5*/
    IL_00ab: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_00b0: br.s IL_010c
    IL_00b2: ldarg.0
    IL_00b3: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00b8: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00bd: callvirt AudioSet.ClipArray AudioSet::get_PlayerFalchion()  /*0x060001C6*/
    IL_00c2: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_00c7: br.s IL_010c
    IL_00c9: ldarg.0
    IL_00ca: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00cf: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00d4: callvirt AudioSet.ClipArray AudioSet::get_PlayerPotionThrow()  /*0x060001C9*/
    IL_00d9: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_00de: br.s IL_010c
    IL_00e0: ldarg.0
    IL_00e1: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00e6: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00eb: callvirt AudioSet.ClipArray AudioSet::get_PlayerAxeHit()  /*0x060001CC*/
    IL_00f0: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_00f5: br.s IL_010c
    IL_00f7: ldarg.0
    IL_00f8: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_00fd: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0102: callvirt AudioSet.ClipArray AudioSet::get_PlayerBloodwandHit()  /*0x060001CE*/
    IL_0107: stfld AudioSet.ClipArray PlayerWeaponAudio::attackSound  /*0x0400025E*/
    IL_010c: ldarg.0
    IL_010d: ldc.i4.1
    IL_010e: stfld bool PlayerWeaponAudio::initialized  /*0x0400025F*/
    IL_0113: ret

  .method PlayerWeaponAudio::.ctor()  // token 0x06000200 rva 0x8758 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.75f
    IL_0006: stfld float PlayerWeaponAudio::volume  /*0x0400025D*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== PlayerWeaponAudio/WeaponType  (token 0x02000058) =====
