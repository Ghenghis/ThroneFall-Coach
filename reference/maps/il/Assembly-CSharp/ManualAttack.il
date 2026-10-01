// ===== ManualAttack  (token 0x020001E7) =====
  .method ManualAttack::get_AttackDamageMultiplyer()  // token 0x060009FC rva 0x2f377 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PlayerUpgradeManager ManualAttack::upgradeManager  /*0x04000CCA*/
    IL_0006: callvirt float PlayerUpgradeManager::get_PlayerDamageMultiplyer()  /*0x06000C67*/
    IL_000b: ret

  .method ManualAttack::get_Cooldown()  // token 0x060009FD rva 0x2f384 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0006: ret

  .method ManualAttack::set_Cooldown(float)  // token 0x060009FE rva 0x2f38c attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0007: ret

  .method ManualAttack::get_LastTargetPos()  // token 0x060009FF rva 0x2f395 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 ManualAttack::lastTargetPos  /*0x04000CCB*/
    IL_0006: ret

  .method ManualAttack::Start()  // token 0x06000A00 rva 0x2f3a0 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 142 (0x8e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldsfld PlayerUpgradeManager PlayerUpgradeManager::instance  /*0x04000F22*/
    IL_0006: stfld PlayerUpgradeManager ManualAttack::upgradeManager  /*0x04000CCA*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: call !!0 UnityEngine.Component::GetComponentInParent()<Hp>  /*0x2B00002F*/
    IL_0012: stfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_0017: ldarg.0
    IL_0018: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_001d: ldc.i4.0
    IL_001e: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0023: stfld Player ManualAttack::input  /*0x04000CC7*/
    IL_0028: ldarg.0
    IL_0029: ldarg.0
    IL_002a: call !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_002f: stfld TaggedObject ManualAttack::myTaggedObj  /*0x04000CC8*/
    IL_0034: ldarg.0
    IL_0035: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_003a: stfld DayNightCycle ManualAttack::dayNightCycle  /*0x04000CC9*/
    IL_003f: ldarg.0
    IL_0040: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0045: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_004a: stfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_004f: ldarg.0
    IL_0050: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0055: stfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_005a: ldarg.0
    IL_005b: ldarg.0
    IL_005c: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0061: callvirt AudioSet.ClipArray AudioSet::get_PlayerCantUseActiveAbility()  /*0x060001BF*/
    IL_0066: stfld AudioSet.ClipArray ManualAttack::caStillOnCooldown  /*0x04000CCE*/
    IL_006b: ldarg.0
    IL_006c: ldarg.0
    IL_006d: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0072: callvirt AudioSet.ClipArray AudioSet::get_AssasinsTrainingWeaponTimedPerfectly()  /*0x060001C0*/
    IL_0077: stfld AudioSet.ClipArray ManualAttack::caAttackTimedPerfectly  /*0x04000CCF*/
    IL_007c: ldarg.0
    IL_007d: ldarg.0
    IL_007e: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_0083: callvirt AudioSet.ClipArray AudioSet::get_ActiveAbilityCooldownReadyToUse()  /*0x060001C1*/
    IL_0088: stfld AudioSet.ClipArray ManualAttack::caCooldownOver  /*0x04000CD0*/
    IL_008d: ret

  .method ManualAttack::get_CooldownPercentage()  // token 0x06000A01 rva 0x2f43a attrs Public, HideBySig, SpecialName
    // code size 19 (0x13), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0006: ldarg.0
    IL_0007: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_000c: div
    IL_000d: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0012: ret

  .method ManualAttack::Update()  // token 0x06000A02 rva 0x2f44e attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0006: brfalse.s IL_0026
    IL_0008: ldarg.0
    IL_0009: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_000e: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0013: ldc.r4 0f
    IL_0018: ble.un.s IL_0020
    IL_001a: ldarg.0
    IL_001b: call void ManualAttack::Tick()  /*0x06000A04*/
    IL_0020: ldarg.0
    IL_0021: call void ManualAttack::DisableMarkersIfDead()  /*0x06000A03*/
    IL_0026: ret

  .method ManualAttack::DisableMarkersIfDead()  // token 0x06000A03 rva 0x2f478 attrs Public, HideBySig
    // code size 97 (0x61), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp ManualAttack::hpPlayer  /*0x04000CC6*/
    IL_0006: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_000b: ldc.r4 0f
    IL_0010: bgt.un.s IL_0060
    IL_0012: ldarg.0
    IL_0013: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0018: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001d: brfalse.s IL_0030
    IL_001f: ldarg.0
    IL_0020: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0025: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_002a: ldc.i4.0
    IL_002b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0030: ldarg.0
    IL_0031: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_0036: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_003b: brfalse.s IL_004e
    IL_003d: ldarg.0
    IL_003e: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_0043: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0048: ldc.i4.0
    IL_0049: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004e: ldarg.0
    IL_004f: ldc.r4 0f
    IL_0054: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0059: ldarg.0
    IL_005a: ldnull
    IL_005b: stfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0060: ret

  .method ManualAttack::Tick()  // token 0x06000A04 rva 0x2f4e8 attrs Public, HideBySig
    // code size 530 (0x212), max stack 8, init locals
    .locals ([0] Vector3, [1] TaggedObject, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_000d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0012: sub
    IL_0013: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0018: ldc.r4 0f
    IL_001d: ble.un.s IL_0073
    IL_001f: ldarg.0
    IL_0020: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0025: ldc.r4 0f
    IL_002a: bgt.un.s IL_0073
    IL_002c: ldarg.0
    IL_002d: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0032: brtrue.s IL_0073
    IL_0034: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0039: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_003e: ldc.i4.1
    IL_003f: bne.un.s IL_0073
    IL_0041: ldarg.0
    IL_0042: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_0047: ldarg.0
    IL_0048: ldfld AudioSet.ClipArray ManualAttack::caCooldownOver  /*0x04000CD0*/
    IL_004d: ldc.r4 1f
    IL_0052: ldc.r4 1f
    IL_0057: ldarg.0
    IL_0058: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_005d: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_0062: ldc.i4.5
    IL_0063: ldc.i4.0
    IL_0064: ldloca.s 0
    IL_0066: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_006c: ldloc.0
    IL_006d: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0072: pop
    IL_0073: ldarg.0
    IL_0074: ldc.i4.0
    IL_0075: stfld bool ManualAttack::isAttacking  /*0x04000CC5*/
    IL_007a: ldarg.0
    IL_007b: callvirt void ManualAttack::HandleAttackUpdate()  /*0x06000A06*/
    IL_0080: ldarg.0
    IL_0081: ldarg.0
    IL_0082: ldfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0087: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_008c: sub
    IL_008d: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0092: ldarg.0
    IL_0093: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0098: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_009d: brfalse IL_013e
    IL_00a2: ldarg.0
    IL_00a3: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_00a8: brtrue.s IL_00b7
    IL_00aa: ldarg.0
    IL_00ab: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_00b0: ldc.r4 0f
    IL_00b5: bgt.un.s IL_012d
    IL_00b7: ldarg.0
    IL_00b8: ldarg.0
    IL_00b9: ldc.i4.1
    IL_00ba: callvirt TaggedObject ManualAttack::FindAttackTarget(bool)  /*0x06000A08*/
    IL_00bf: stfld TaggedObject ManualAttack::target  /*0x04000CD5*/
    IL_00c4: ldarg.0
    IL_00c5: ldfld TaggedObject ManualAttack::target  /*0x04000CD5*/
    IL_00ca: ldnull
    IL_00cb: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_00d0: brfalse.s IL_00e5
    IL_00d2: ldarg.0
    IL_00d3: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_00d8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00dd: ldc.i4.0
    IL_00de: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e3: br.s IL_013e
    IL_00e5: ldarg.0
    IL_00e6: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_00eb: brfalse.s IL_00ff
    IL_00ed: ldarg.0
    IL_00ee: ldc.r4 0.2f
    IL_00f3: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_00f8: ldarg.0
    IL_00f9: ldc.i4.1
    IL_00fa: stfld bool ManualAttack::isAttacking  /*0x04000CC5*/
    IL_00ff: ldarg.0
    IL_0100: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0105: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_010a: ldc.i4.1
    IL_010b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0110: ldarg.0
    IL_0111: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0116: ldarg.0
    IL_0117: ldfld TaggedObject ManualAttack::target  /*0x04000CD5*/
    IL_011c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0121: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0126: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_012b: br.s IL_013e
    IL_012d: ldarg.0
    IL_012e: ldfld Transform ManualAttack::attackMarkerPosition  /*0x04000CBC*/
    IL_0133: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0138: ldc.i4.0
    IL_0139: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_013e: ldarg.0
    IL_013f: ldfld Player ManualAttack::input  /*0x04000CC7*/
    IL_0144: ldstr "Lock Target"
    IL_0149: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_014e: brfalse.s IL_0178
    IL_0150: ldarg.0
    IL_0151: ldc.i4.0
    IL_0152: callvirt TaggedObject ManualAttack::FindAttackTargetWithInfiniteRange(bool)  /*0x06000A09*/
    IL_0157: stloc.1
    IL_0158: ldarg.0
    IL_0159: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_015e: ldnull
    IL_015f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0164: brfalse.s IL_016f
    IL_0166: ldarg.0
    IL_0167: ldloc.1
    IL_0168: stfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_016d: br.s IL_01a6
    IL_016f: ldarg.0
    IL_0170: ldnull
    IL_0171: stfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0176: br.s IL_01a6
    IL_0178: ldarg.0
    IL_0179: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_017e: ldnull
    IL_017f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0184: brfalse.s IL_01a6
    IL_0186: ldarg.0
    IL_0187: ldfld bool ManualAttack::preferredTargetPreviouslySet  /*0x04000CD2*/
    IL_018c: brfalse.s IL_01a6
    IL_018e: ldarg.0
    IL_018f: ldc.i4.0
    IL_0190: callvirt TaggedObject ManualAttack::FindAttackTargetWithInfiniteRange(bool)  /*0x06000A09*/
    IL_0195: stloc.2
    IL_0196: ldloc.2
    IL_0197: ldnull
    IL_0198: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_019d: brfalse.s IL_01a6
    IL_019f: ldarg.0
    IL_01a0: ldloc.2
    IL_01a1: stfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_01a6: ldarg.0
    IL_01a7: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_01ac: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01b1: brfalse.s IL_01ff
    IL_01b3: ldarg.0
    IL_01b4: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_01b9: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_01be: brfalse.s IL_01ee
    IL_01c0: ldarg.0
    IL_01c1: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_01c6: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01cb: ldc.i4.1
    IL_01cc: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01d1: ldarg.0
    IL_01d2: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_01d7: ldarg.0
    IL_01d8: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_01dd: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_01e2: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_01e7: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_01ec: br.s IL_01ff
    IL_01ee: ldarg.0
    IL_01ef: ldfld Transform ManualAttack::preferredTargetMarkerPosition  /*0x04000CBD*/
    IL_01f4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01f9: ldc.i4.0
    IL_01fa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01ff: ldarg.0
    IL_0200: ldarg.0
    IL_0201: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0206: ldnull
    IL_0207: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_020c: stfld bool ManualAttack::preferredTargetPreviouslySet  /*0x04000CD2*/
    IL_0211: ret

  .method ManualAttack::TryToAttack()  // token 0x06000A05 rva 0x2f708 attrs Public, HideBySig
    // code size 83 (0x53), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld DayNightCycle ManualAttack::dayNightCycle  /*0x04000CC9*/
    IL_0006: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000b: brtrue.s IL_0016
    IL_000d: ldarg.0
    IL_000e: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0013: brtrue.s IL_0016
    IL_0015: ret
    IL_0016: ldarg.0
    IL_0017: ldfld PlayerUpgradeManager ManualAttack::upgradeManager  /*0x04000CCA*/
    IL_001c: ldfld bool PlayerUpgradeManager::assassinsTraining  /*0x04000F26*/
    IL_0021: brfalse.s IL_0040
    IL_0023: ldarg.0
    IL_0024: ldarg.0
    IL_0025: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_002a: call float UnityEngine.Mathf::Abs(float)  /*0x0A0000B8*/
    IL_002f: ldsfld UpgradeAssassinsTraining UpgradeAssassinsTraining::instance  /*0x04000F00*/
    IL_0034: ldfld float UpgradeAssassinsTraining::activationWindow  /*0x04000F03*/
    IL_0039: clt
    IL_003b: stfld bool ManualAttack::timedActivationPerfectly  /*0x04000CD3*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0.2f
    IL_0046: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_004b: ldarg.0
    IL_004c: ldc.i4.1
    IL_004d: stfld bool ManualAttack::isAttacking  /*0x04000CC5*/
    IL_0052: ret

  .method ManualAttack::HandleAttackUpdate()  // token 0x06000A06 rva 0x2f768 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 251 (0xfb), max stack 8, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0006: ldc.r4 0f
    IL_000b: blt.un IL_00fa
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
    IL_009f: brfalse.s IL_00f4
    IL_00a1: ldarg.0
    IL_00a2: ldarg.0
    IL_00a3: ldfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_00a8: ldsfld UpgradeAssassinsTraining UpgradeAssassinsTraining::instance  /*0x04000F00*/
    IL_00ad: ldfld float UpgradeAssassinsTraining::cooldownMultiForPerfectlyTimedAttacks  /*0x04000F04*/
    IL_00b2: mul
    IL_00b3: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_00b8: ldarg.0
    IL_00b9: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_00be: ldarg.0
    IL_00bf: ldfld AudioSet.ClipArray ManualAttack::caAttackTimedPerfectly  /*0x04000CCF*/
    IL_00c4: ldc.r4 1f
    IL_00c9: ldc.r4 0.9f
    IL_00ce: ldc.r4 1.1f
    IL_00d3: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_00d8: ldarg.0
    IL_00d9: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_00de: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_00e3: ldc.i4.4
    IL_00e4: ldc.i4.0
    IL_00e5: ldloca.s 0
    IL_00e7: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_00ed: ldloc.0
    IL_00ee: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_00f3: pop
    IL_00f4: ldarg.0
    IL_00f5: callvirt void ManualAttack::Attack()  /*0x06000A07*/
    IL_00fa: ret

  .method ManualAttack::Attack()  // token 0x06000A07 rva 0x2f870 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 387 (0x183), max stack 8, init locals
    .locals ([0] TaggedObject, [1] Hp, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: callvirt TaggedObject ManualAttack::FindAttackTarget(bool)  /*0x06000A08*/
    IL_0007: stloc.0
    IL_0008: ldnull
    IL_0009: stloc.1
    IL_000a: ldloc.0
    IL_000b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0010: brfalse IL_00ac
    IL_0015: ldarg.0
    IL_0016: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_001b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0020: brfalse.s IL_002d
    IL_0022: ldarg.0
    IL_0023: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_0028: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_002d: ldarg.0
    IL_002e: ldfld bool ManualAttack::playOneShotOnAttack  /*0x04000CC0*/
    IL_0033: brfalse.s IL_0040
    IL_0035: ldarg.0
    IL_0036: ldfld ThronefallAudioManager.AudioOneShot ManualAttack::oneshotOnAttack  /*0x04000CC1*/
    IL_003b: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_0040: ldloc.0
    IL_0041: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0046: stloc.1
    IL_0047: ldarg.0
    IL_0048: ldloc.0
    IL_0049: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0053: stfld Vector3 ManualAttack::lastTargetPos  /*0x04000CCB*/
    IL_0058: ldarg.0
    IL_0059: ldfld Weapon ManualAttack::weapon  /*0x04000CB9*/
    IL_005e: ldarg.0
    IL_005f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0064: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0069: ldarg.0
    IL_006a: ldfld float ManualAttack::spawnAttackHeight  /*0x04000CB7*/
    IL_006f: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0074: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0079: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_007e: ldloc.1
    IL_007f: ldarg.0
    IL_0080: ldfld Transform ManualAttack::transformForAttackDirection  /*0x04000CBB*/
    IL_0085: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_008a: ldarg.0
    IL_008b: ldfld TaggedObject ManualAttack::myTaggedObj  /*0x04000CC8*/
    IL_0090: ldarg.0
    IL_0091: call float ManualAttack::get_AttackDamageMultiplyer()  /*0x060009FC*/
    IL_0096: ldc.r4 1f
    IL_009b: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_00a0: ldarg.0
    IL_00a1: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_00a6: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00ab: ret
    IL_00ac: ldarg.0
    IL_00ad: ldfld bool ManualAttack::allowAttackWithoutTarget  /*0x04000CC2*/
    IL_00b2: brfalse.s IL_0133
    IL_00b4: ldarg.0
    IL_00b5: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_00ba: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00bf: brfalse.s IL_00cc
    IL_00c1: ldarg.0
    IL_00c2: ldfld ParticleSystem ManualAttack::particlesOnAttack  /*0x04000CBF*/
    IL_00c7: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld bool ManualAttack::playOneShotOnAttack  /*0x04000CC0*/
    IL_00d2: brfalse.s IL_00df
    IL_00d4: ldarg.0
    IL_00d5: ldfld ThronefallAudioManager.AudioOneShot ManualAttack::oneshotOnAttack  /*0x04000CC1*/
    IL_00da: call void ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  /*0x06000219*/
    IL_00df: ldarg.0
    IL_00e0: ldfld Weapon ManualAttack::weapon  /*0x04000CB9*/
    IL_00e5: ldarg.0
    IL_00e6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00eb: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00f0: ldarg.0
    IL_00f1: ldfld float ManualAttack::spawnAttackHeight  /*0x04000CB7*/
    IL_00f6: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_00fb: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0100: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0105: ldnull
    IL_0106: ldarg.0
    IL_0107: ldfld Transform ManualAttack::transformForAttackDirection  /*0x04000CBB*/
    IL_010c: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0111: ldarg.0
    IL_0112: ldfld TaggedObject ManualAttack::myTaggedObj  /*0x04000CC8*/
    IL_0117: ldarg.0
    IL_0118: call float ManualAttack::get_AttackDamageMultiplyer()  /*0x060009FC*/
    IL_011d: ldc.r4 1f
    IL_0122: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_0127: ldarg.0
    IL_0128: ldfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_012d: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0132: ret
    IL_0133: ldarg.0
    IL_0134: ldc.r4 0f
    IL_0139: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_013e: ldarg.0
    IL_013f: ldfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_0144: brtrue.s IL_0182
    IL_0146: ldarg.0
    IL_0147: ldfld ThronefallAudioManager ManualAttack::audioManager  /*0x04000CD1*/
    IL_014c: ldarg.0
    IL_014d: ldfld AudioSet.ClipArray ManualAttack::caStillOnCooldown  /*0x04000CCE*/
    IL_0152: ldc.r4 1f
    IL_0157: ldc.r4 1.8f
    IL_015c: ldc.r4 2.2f
    IL_0161: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0166: ldarg.0
    IL_0167: ldfld AudioSet ManualAttack::audioSet  /*0x04000CCD*/
    IL_016c: ldfld AudioMixerGroup AudioSet::mixGroupFX  /*0x040001D9*/
    IL_0171: ldc.i4.5
    IL_0172: ldc.i4.0
    IL_0173: ldloca.s 2
    IL_0175: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_017b: ldloc.2
    IL_017c: callvirt ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0181: pop
    IL_0182: ret

  .method ManualAttack::FindAttackTarget(bool)  // token 0x06000A08 rva 0x2fa00 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 133 (0x85), max stack 3, init locals
    .locals ([0] int, [1] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0045
    IL_0003: ldarg.0
    IL_0004: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0009: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000e: brfalse.s IL_0045
    IL_0010: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0015: ldarg.0
    IL_0016: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_001b: ldarg.0
    IL_001c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0021: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0026: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0031: ldc.i4.0
    IL_0032: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0037: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_003c: bgt.un.s IL_0045
    IL_003e: ldarg.0
    IL_003f: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_0044: ret
    IL_0045: ldc.i4.0
    IL_0046: stloc.0
    IL_0047: br.s IL_0075
    IL_0049: ldarg.0
    IL_004a: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_004f: ldloc.0
    IL_0050: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0055: ldarg.0
    IL_0056: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_005b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0060: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0065: stloc.1
    IL_0066: ldloc.1
    IL_0067: ldnull
    IL_0068: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_006d: brfalse.s IL_0071
    IL_006f: ldloc.1
    IL_0070: ret
    IL_0071: ldloc.0
    IL_0072: ldc.i4.1
    IL_0073: add
    IL_0074: stloc.0
    IL_0075: ldloc.0
    IL_0076: ldarg.0
    IL_0077: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_007c: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0081: blt.s IL_0049
    IL_0083: ldnull
    IL_0084: ret

  .method ManualAttack::FindAttackTargetWithInfiniteRange(bool)  // token 0x06000A09 rva 0x2fa94 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 139 (0x8b), max stack 3, init locals
    .locals ([0] TaggedObject, [1] int, [2] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: callvirt TaggedObject ManualAttack::FindAttackTarget(bool)  /*0x06000A08*/
    IL_0007: stloc.0
    IL_0008: ldloc.0
    IL_0009: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000e: brfalse.s IL_0012
    IL_0010: ldloc.0
    IL_0011: ret
    IL_0012: ldarg.1
    IL_0013: brfalse.s IL_004b
    IL_0015: ldarg.0
    IL_0016: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_001b: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0020: brfalse.s IL_004b
    IL_0022: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0027: ldarg.0
    IL_0028: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_002d: ldarg.0
    IL_002e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0038: callvirt float TagManager::MeasureDistanceToTaggedObject(TaggedObject,UnityEngine.Vector3)  /*0x06000E63*/
    IL_003d: ldc.r4 1000000f
    IL_0042: bgt.un.s IL_004b
    IL_0044: ldarg.0
    IL_0045: ldfld TaggedObject ManualAttack::preferredTarget  /*0x04000CD4*/
    IL_004a: ret
    IL_004b: ldc.i4.0
    IL_004c: stloc.1
    IL_004d: br.s IL_007b
    IL_004f: ldarg.0
    IL_0050: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0055: ldloc.1
    IL_0056: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_005b: ldarg.0
    IL_005c: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0061: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0066: callvirt TaggedObject TargetPriority::FindClosestTaggedObjectWithoutMaxDistanceCheck(UnityEngine.Vector3)  /*0x06000E71*/
    IL_006b: stloc.2
    IL_006c: ldloc.2
    IL_006d: ldnull
    IL_006e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0073: brfalse.s IL_0077
    IL_0075: ldloc.2
    IL_0076: ret
    IL_0077: ldloc.1
    IL_0078: ldc.i4.1
    IL_0079: add
    IL_007a: stloc.1
    IL_007b: ldloc.1
    IL_007c: ldarg.0
    IL_007d: ldfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_0082: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0087: blt.s IL_004f
    IL_0089: ldnull
    IL_008a: ret

  .method ManualAttack::.ctor()  // token 0x06000A0A rva 0x2fb2b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 58 (0x3a), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0006: stfld List<TargetPriority> ManualAttack::targetPriorities  /*0x04000CB8*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0016: ldarg.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool ManualAttack::autoAttack  /*0x04000CBE*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 -1f
    IL_0023: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0028: ldarg.0
    IL_0029: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_002e: stfld UnityEvent ManualAttack::onAttack  /*0x04000CCC*/
    IL_0033: ldarg.0
    IL_0034: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0039: ret

