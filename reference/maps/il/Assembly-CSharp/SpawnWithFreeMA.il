// ===== SpawnWithFreeMA  (token 0x020001ED) =====
  .method SpawnWithFreeMA::Start()  // token 0x06000A2C rva 0x30203 attrs Public, Virtual, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_000b: ldarg.0
    IL_000c: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0011: ret

  .method SpawnWithFreeMA::HandleAttackUpdate()  // token 0x06000A2D rva 0x30218 attrs Public, Virtual, HideBySig
    // code size 250 (0xfa), max stack 8, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0006: ldc.r4 0f
    IL_000b: blt.un IL_00f9
    IL_0010: ldarg.0
    IL_0011: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0016: ldc.r4 0f
    IL_001b: ble.un.s IL_007b
    IL_001d: ldarg.0
    IL_001e: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0023: brtrue.s IL_007a
    IL_0025: ldarg.0
    IL_0026: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_002b: ldarg.0
    IL_002c: ldfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0031: ble.un.s IL_007a
    IL_0033: ldarg.0
    IL_0034: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_0039: ldarg.0
    IL_003a: ldfld AudioSet.ClipArray ManualAttack::caStillOnCooldown  /*0x04000CCE*/
    IL_003f: ldc.r4 1f
    IL_0044: ldc.r4 1.8f
    IL_0049: ldc.r4 2.2f
    IL_004e: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0053: ldarg.0
    IL_0054: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0059: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_005e: ldc.i4.5
    IL_005f: ldc.i4.0
    IL_0060: ldloca.s 0
    IL_0062: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0068: ldloc.0
    IL_0069: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_006e: pop
    IL_006f: ldarg.0
    IL_0070: ldc.r4 -1f
    IL_0075: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_007a: ret
    IL_007b: ldarg.0
    IL_007c: ldc.r4 -1f
    IL_0081: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0086: ldarg.0
    IL_0087: ldc.i4.1
    IL_0088: stfld bool ManualAttack::isAttacking  /*0x04000CC5*/
    IL_008d: ldarg.0
    IL_008e: ldarg.0
    IL_008f: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0094: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0099: ldarg.0
    IL_009a: ldfld bool ManualAttack::timedActivationPerfectly  /*0x04000CD3*/
    IL_009f: brfalse.s IL_00f3
    IL_00a1: ldarg.0
    IL_00a2: ldfld int SpawnWithFreeMA::activationNr  /*0x04000CF8*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld int SpawnWithFreeMA::consecutiveActivations  /*0x04000CF7*/
    IL_00ad: rem
    IL_00ae: brtrue.s IL_00f3
    IL_00b0: ldarg.0
    IL_00b1: ldc.i4.1
    IL_00b2: stfld bool SpawnWithFreeMA::cutCooldownNextTime  /*0x04000CF9*/
    IL_00b7: ldarg.0
    IL_00b8: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_00bd: ldarg.0
    IL_00be: ldfld AudioSet.ClipArray ManualAttack::caAttackTimedPerfectly  /*0x04000CCF*/
    IL_00c3: ldc.r4 1f
    IL_00c8: ldc.r4 0.9f
    IL_00cd: ldc.r4 1.1f
    IL_00d2: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_00d7: ldarg.0
    IL_00d8: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_00dd: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_00e2: ldc.i4.4
    IL_00e3: ldc.i4.0
    IL_00e4: ldloca.s 0
    IL_00e6: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_00ec: ldloc.0
    IL_00ed: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_00f2: pop
    IL_00f3: ldarg.0
    IL_00f4: callvirt void ManualAttack::Attack()  /*0x06000A07*/
    IL_00f9: ret

  .method SpawnWithFreeMA::Attack()  // token 0x06000A2E rva 0x30320 attrs Public, Virtual, HideBySig
    // code size 132 (0x84), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject SpawnWithFreeMA::spawnHere  /*0x04000CF6*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0034
    IL_000d: ldarg.0
    IL_000e: ldfld GameObject SpawnWithFreeMA::spawnHere  /*0x04000CF6*/
    IL_0013: ldarg.0
    IL_0014: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0019: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001e: ldarg.0
    IL_001f: ldfld GameObject SpawnWithFreeMA::spawnHere  /*0x04000CF6*/
    IL_0024: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0029: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_002e: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0033: pop
    IL_0034: ldarg.0
    IL_0035: ldarg.0
    IL_0036: ldfld int SpawnWithFreeMA::activationNr  /*0x04000CF8*/
    IL_003b: ldc.i4.1
    IL_003c: add
    IL_003d: stfld int SpawnWithFreeMA::activationNr  /*0x04000CF8*/
    IL_0042: ldarg.0
    IL_0043: ldfld int SpawnWithFreeMA::activationNr  /*0x04000CF8*/
    IL_0048: ldarg.0
    IL_0049: ldfld int SpawnWithFreeMA::consecutiveActivations  /*0x04000CF7*/
    IL_004e: rem
    IL_004f: brfalse.s IL_005d
    IL_0051: ldarg.0
    IL_0052: ldc.r4 0f
    IL_0057: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_005c: ret
    IL_005d: ldarg.0
    IL_005e: ldfld bool SpawnWithFreeMA::cutCooldownNextTime  /*0x04000CF9*/
    IL_0063: brfalse.s IL_0083
    IL_0065: ldarg.0
    IL_0066: ldarg.0
    IL_0067: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_006c: ldsfld UpgradeAssassinsTraining UpgradeAssassinsTraining::instance  /*0x04000F00*/
    IL_0071: ldfld float UpgradeAssassinsTraining::cooldownMultiForPerfectlyTimedAttacks  /*0x04000F04*/
    IL_0076: mul
    IL_0077: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_007c: ldarg.0
    IL_007d: ldc.i4.0
    IL_007e: stfld bool SpawnWithFreeMA::cutCooldownNextTime  /*0x04000CF9*/
    IL_0083: ret

  .method SpawnWithFreeMA::OnDawn_AfterSunrise()  // token 0x06000A2F rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpawnWithFreeMA::OnDawn_BeforeSunrise()  // token 0x06000A30 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpawnWithFreeMA::OnDusk()  // token 0x06000A31 rva 0x303b0 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld int SpawnWithFreeMA::activationNr  /*0x04000CF8*/
    IL_0007: ret

  .method SpawnWithFreeMA::OnDuskEarly()  // token 0x06000A32 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method SpawnWithFreeMA::.ctor()  // token 0x06000A33 rva 0x303b9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int SpawnWithFreeMA::consecutiveActivations  /*0x04000CF7*/
    IL_0007: ldarg.0
    IL_0008: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_000d: ret

