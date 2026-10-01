// ===== ThronefallAudioManager  (token 0x0200005F) =====
  .method ThronefallAudioManager::get_Instance()  // token 0x0600020F rva 0x8908 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ret

  .method ThronefallAudioManager::Awake()  // token 0x06000210 rva 0x8910 attrs Private, HideBySig
    // code size 165 (0xa5), max stack 2, init locals
    .locals ([0] AudioSource, [1] int)
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_002a: ldnull
    IL_002b: stloc.0
    IL_002c: ldc.i4.0
    IL_002d: stloc.1
    IL_002e: br.s IL_009a
    IL_0030: ldstr "Oneshot Source "
    IL_0035: ldloca.s 1
    IL_0037: call string System.Int32::ToString()  /*0x0A000031*/
    IL_003c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0041: newobj void UnityEngine.GameObject::.ctor(string)  /*0x0A0000D1*/
    IL_0046: call !!0 UnityEngine.GameObject::AddComponent()<UnityEngine.AudioSource>  /*0x2B000018*/
    IL_004b: stloc.0
    IL_004c: ldloc.0
    IL_004d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0052: ldarg.0
    IL_0053: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0058: callvirt void UnityEngine.Transform::SetParent(UnityEngine.Transform)  /*0x0A000065*/
    IL_005d: ldloc.0
    IL_005e: ldc.i4.1
    IL_005f: callvirt void UnityEngine.AudioSource::set_rolloffMode(UnityEngine.AudioRolloffMode)  /*0x0A0000D2*/
    IL_0064: ldloc.0
    IL_0065: ldc.r4 1f
    IL_006a: callvirt void UnityEngine.AudioSource::set_minDistance(float)  /*0x0A0000D3*/
    IL_006f: ldloc.0
    IL_0070: ldc.r4 80f
    IL_0075: callvirt void UnityEngine.AudioSource::set_maxDistance(float)  /*0x0A0000D4*/
    IL_007a: ldloc.0
    IL_007b: ldc.r4 0f
    IL_0080: callvirt void UnityEngine.AudioSource::set_spatialBlend(float)  /*0x0A0000D5*/
    IL_0085: ldarg.0
    IL_0086: ldfld List<ThronefallAudioManager.OneshotSource> ThronefallAudioManager::oneshotSourcePool  /*0x0400027C*/
    IL_008b: ldloc.0
    IL_008c: newobj void ThronefallAudioManager.OneshotSource::.ctor(UnityEngine.AudioSource)  /*0x0600021F*/
    IL_0091: callvirt void System.Collections.Generic.List<ThronefallAudioManager.OneshotSource>::Add(!0)  /*0x0A0000D6*/
    IL_0096: ldloc.1
    IL_0097: ldc.i4.1
    IL_0098: add
    IL_0099: stloc.1
    IL_009a: ldloc.1
    IL_009b: conv.r4
    IL_009c: ldarg.0
    IL_009d: ldfld float ThronefallAudioManager::oneshotAudioPoolSize  /*0x04000279*/
    IL_00a2: blt.s IL_0030
    IL_00a4: ret

  .method ThronefallAudioManager::Update()  // token 0x06000211 rva 0x89c4 attrs Private, HideBySig
    // code size 109 (0x6d), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float ThronefallAudioManager::oneshotSourceRecycleClock  /*0x0400027B*/
    IL_0007: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_000c: add
    IL_000d: stfld float ThronefallAudioManager::oneshotSourceRecycleClock  /*0x0400027B*/
    IL_0012: ldarg.0
    IL_0013: ldfld float ThronefallAudioManager::oneshotSourceRecycleClock  /*0x0400027B*/
    IL_0018: ldarg.0
    IL_0019: ldfld float ThronefallAudioManager::onshotAudioPoolRecycleTick  /*0x0400027A*/
    IL_001e: ble.un.s IL_0026
    IL_0020: ldarg.0
    IL_0021: call void ThronefallAudioManager::RecycleOneshotSources()  /*0x06000216*/
    IL_0026: ldarg.0
    IL_0027: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_002c: brfalse.s IL_006c
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld float ThronefallAudioManager::coinslotFillBackgroundClock  /*0x04000287*/
    IL_0035: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_003a: add
    IL_003b: stfld float ThronefallAudioManager::coinslotFillBackgroundClock  /*0x04000287*/
    IL_0040: ldarg.0
    IL_0041: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_0046: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_004b: ldc.r4 0.75f
    IL_0050: ldc.r4 1f
    IL_0055: ldarg.0
    IL_0056: ldfld float ThronefallAudioManager::coinslotFillBackgroundClock  /*0x04000287*/
    IL_005b: ldarg.0
    IL_005c: ldfld float ThronefallAudioManager::coinslotTotalFillTime  /*0x04000288*/
    IL_0061: div
    IL_0062: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0067: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_006c: ret

  .method ThronefallAudioManager::ProcessOneShotEvent(ThronefallAudioManager.AudioOneShot,bool,UnityEngine.Vector3)  // token 0x06000212 rva 0x8a40 attrs Private, HideBySig
    // code size 1545 (0x609), max stack 9, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld bool ThronefallAudioManager::muted  /*0x04000283*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: switch (IL_016e, IL_01b0, IL_00f3, IL_0084, IL_0134, IL_0167, IL_01dd, IL_0206, IL_0233, IL_027e, IL_02c5, IL_02f7, IL_0329, IL_035b, IL_0397, IL_03c8, IL_03ef, IL_0418, IL_0447, IL_0474, IL_04a1, IL_0608, IL_04ce, IL_04ef, IL_051a, IL_0545, IL_0570, IL_05a3, IL_05d6)
    IL_0083: ret
    IL_0084: ldarg.0
    IL_0085: ldc.r4 1f
    IL_008a: stfld float ThronefallAudioManager::coinslotFillPitch  /*0x04000284*/
    IL_008f: ldarg.0
    IL_0090: ldarg.0
    IL_0091: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0096: callvirt AudioClip AudioSet::get_CoinslotInteractionStart()  /*0x06000187*/
    IL_009b: ldc.r4 1f
    IL_00a0: ldc.r4 1f
    IL_00a5: ldnull
    IL_00a6: ldc.i4 128
    IL_00ab: ldc.i4.0
    IL_00ac: ldloca.s 0
    IL_00ae: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_00b4: ldloc.0
    IL_00b5: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_00ba: pop
    IL_00bb: ldarg.0
    IL_00bc: call void ThronefallAudioManager::StopCoinfillBackground()  /*0x06000217*/
    IL_00c1: ldarg.0
    IL_00c2: ldarg.0
    IL_00c3: ldarg.0
    IL_00c4: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00c9: callvirt AudioClip AudioSet::get_PayBackground()  /*0x06000188*/
    IL_00ce: ldc.r4 0.2f
    IL_00d3: ldc.r4 0.75f
    IL_00d8: ldnull
    IL_00d9: ldc.i4 128
    IL_00de: ldc.i4.0
    IL_00df: ldloca.s 0
    IL_00e1: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_00e7: ldloc.0
    IL_00e8: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_00ed: stfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_00f2: ret
    IL_00f3: ldarg.0
    IL_00f4: ldarg.0
    IL_00f5: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_00fa: callvirt AudioClip AudioSet::get_CoinslotFill()  /*0x06000185*/
    IL_00ff: ldc.r4 1f
    IL_0104: ldarg.0
    IL_0105: ldfld float ThronefallAudioManager::coinslotFillPitch  /*0x04000284*/
    IL_010a: ldnull
    IL_010b: ldc.i4 128
    IL_0110: ldc.i4.0
    IL_0111: ldloca.s 0
    IL_0113: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0119: ldloc.0
    IL_011a: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_011f: pop
    IL_0120: ldarg.0
    IL_0121: ldarg.0
    IL_0122: ldfld float ThronefallAudioManager::coinslotFillPitch  /*0x04000284*/
    IL_0127: ldarg.0
    IL_0128: ldfld float ThronefallAudioManager::coinslotFillPitchIncrease  /*0x04000285*/
    IL_012d: add
    IL_012e: stfld float ThronefallAudioManager::coinslotFillPitch  /*0x04000284*/
    IL_0133: ret
    IL_0134: ldarg.0
    IL_0135: ldarg.0
    IL_0136: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_013b: callvirt AudioClip AudioSet::get_LastCoinslotFill()  /*0x06000186*/
    IL_0140: ldc.r4 1f
    IL_0145: ldc.r4 1f
    IL_014a: ldnull
    IL_014b: ldc.i4 128
    IL_0150: ldc.i4.0
    IL_0151: ldloca.s 0
    IL_0153: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0159: ldloc.0
    IL_015a: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_015f: pop
    IL_0160: ldarg.0
    IL_0161: call void ThronefallAudioManager::StopCoinfillBackground()  /*0x06000217*/
    IL_0166: ret
    IL_0167: ldarg.0
    IL_0168: call void ThronefallAudioManager::StopCoinfillBackground()  /*0x06000217*/
    IL_016d: ret
    IL_016e: ldarg.0
    IL_016f: ldfld UnityEvent ThronefallAudioManager::onBuildingBuild  /*0x04000282*/
    IL_0174: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0179: ldarg.0
    IL_017a: ldarg.0
    IL_017b: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0180: callvirt AudioClip AudioSet::get_BuildingBuild()  /*0x06000189*/
    IL_0185: ldc.r4 1f
    IL_018a: ldc.r4 0.9f
    IL_018f: ldc.r4 1.1f
    IL_0194: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0199: ldnull
    IL_019a: ldc.i4 128
    IL_019f: ldc.i4.0
    IL_01a0: ldloca.s 0
    IL_01a2: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_01a8: ldloc.0
    IL_01a9: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_01ae: pop
    IL_01af: ret
    IL_01b0: ldarg.0
    IL_01b1: ldarg.0
    IL_01b2: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_01b7: callvirt AudioClip AudioSet::get_BuildingUpgrade()  /*0x0600018A*/
    IL_01bc: ldc.r4 1f
    IL_01c1: ldc.r4 1f
    IL_01c6: ldnull
    IL_01c7: ldc.i4 128
    IL_01cc: ldc.i4.0
    IL_01cd: ldloca.s 0
    IL_01cf: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_01d5: ldloc.0
    IL_01d6: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_01db: pop
    IL_01dc: ret
    IL_01dd: ldarg.0
    IL_01de: ldarg.0
    IL_01df: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_01e4: callvirt AudioClip AudioSet::get_NightSurvived()  /*0x06000183*/
    IL_01e9: ldc.r4 0.8f
    IL_01ee: ldc.r4 1f
    IL_01f3: ldnull
    IL_01f4: ldc.i4.0
    IL_01f5: ldc.i4.0
    IL_01f6: ldloca.s 0
    IL_01f8: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_01fe: ldloc.0
    IL_01ff: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0204: pop
    IL_0205: ret
    IL_0206: ldarg.0
    IL_0207: ldarg.0
    IL_0208: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_020d: callvirt AudioClip AudioSet::get_BuildingRepair()  /*0x06000184*/
    IL_0212: ldc.r4 1f
    IL_0217: ldc.r4 1f
    IL_021c: ldnull
    IL_021d: ldc.i4 128
    IL_0222: ldc.i4.0
    IL_0223: ldloca.s 0
    IL_0225: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_022b: ldloc.0
    IL_022c: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0231: pop
    IL_0232: ret
    IL_0233: ldarg.0
    IL_0234: ldarg.0
    IL_0235: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_023a: callvirt AudioSet.ClipArray AudioSet::get_EismolochAppear()  /*0x060001B7*/
    IL_023f: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_0244: ldc.i4.0
    IL_0245: ldarg.0
    IL_0246: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_024b: callvirt AudioSet.ClipArray AudioSet::get_EismolochAppear()  /*0x060001B7*/
    IL_0250: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_0255: ldlen
    IL_0256: conv.i4
    IL_0257: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_025c: ldelem.ref
    IL_025d: ldc.r4 1f
    IL_0262: ldc.r4 1f
    IL_0267: ldnull
    IL_0268: ldc.i4 128
    IL_026d: ldc.i4.0
    IL_026e: ldloca.s 0
    IL_0270: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0276: ldloc.0
    IL_0277: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_027c: pop
    IL_027d: ret
    IL_027e: ldarg.0
    IL_027f: ldarg.0
    IL_0280: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0285: callvirt AudioSet.ClipArray AudioSet::get_EismolochSpawnUnits()  /*0x060001B8*/
    IL_028a: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_028f: ldc.i4.0
    IL_0290: ldarg.0
    IL_0291: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0296: callvirt AudioSet.ClipArray AudioSet::get_EismolochSpawnUnits()  /*0x060001B8*/
    IL_029b: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_02a0: ldlen
    IL_02a1: conv.i4
    IL_02a2: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_02a7: ldelem.ref
    IL_02a8: ldc.r4 1f
    IL_02ad: ldc.r4 1f
    IL_02b2: ldnull
    IL_02b3: ldc.i4.0
    IL_02b4: ldc.i4.0
    IL_02b5: ldloca.s 0
    IL_02b7: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_02bd: ldloc.0
    IL_02be: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_02c3: pop
    IL_02c4: ret
    IL_02c5: ldarg.0
    IL_02c6: ldarg.0
    IL_02c7: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_02cc: callvirt AudioSet.ClipArray AudioSet::get_ButtonSelect()  /*0x060001D7*/
    IL_02d1: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_02d6: ldc.r4 1f
    IL_02db: ldc.r4 1f
    IL_02e0: ldnull
    IL_02e1: ldc.i4 128
    IL_02e6: ldc.i4.0
    IL_02e7: ldloca.s 0
    IL_02e9: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_02ef: ldloc.0
    IL_02f0: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_02f5: pop
    IL_02f6: ret
    IL_02f7: ldarg.0
    IL_02f8: ldarg.0
    IL_02f9: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_02fe: callvirt AudioSet.ClipArray AudioSet::get_ButtonApply()  /*0x060001D8*/
    IL_0303: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0308: ldc.r4 1f
    IL_030d: ldc.r4 1f
    IL_0312: ldnull
    IL_0313: ldc.i4 128
    IL_0318: ldc.i4.0
    IL_0319: ldloca.s 0
    IL_031b: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0321: ldloc.0
    IL_0322: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0327: pop
    IL_0328: ret
    IL_0329: ldarg.0
    IL_032a: ldarg.0
    IL_032b: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0330: callvirt AudioSet.ClipArray AudioSet::get_ButtonApplyHero()  /*0x060001D9*/
    IL_0335: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_033a: ldc.r4 1f
    IL_033f: ldc.r4 1f
    IL_0344: ldnull
    IL_0345: ldc.i4 128
    IL_034a: ldc.i4.0
    IL_034b: ldloca.s 0
    IL_034d: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0353: ldloc.0
    IL_0354: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0359: pop
    IL_035a: ret
    IL_035b: ldarg.0
    IL_035c: ldarg.0
    IL_035d: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0362: callvirt AudioSet.ClipArray AudioSet::get_CoinCollect()  /*0x060001DA*/
    IL_0367: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_036c: ldc.r4 1f
    IL_0371: ldc.r4 0.9f
    IL_0376: ldc.r4 1.1f
    IL_037b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0380: ldnull
    IL_0381: ldc.i4 128
    IL_0386: ldc.i4.0
    IL_0387: ldloca.s 0
    IL_0389: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_038f: ldloc.0
    IL_0390: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0395: pop
    IL_0396: ret
    IL_0397: ldarg.0
    IL_0398: ldarg.0
    IL_0399: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_039e: callvirt AudioSet.ClipArray AudioSet::get_TowerShot()  /*0x0600018B*/
    IL_03a3: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_03a8: ldc.r4 0.5f
    IL_03ad: ldc.r4 0.95f
    IL_03b2: ldc.r4 1.05f
    IL_03b7: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_03bc: ldnull
    IL_03bd: ldc.i4.s 50
    IL_03bf: ldc.i4.1
    IL_03c0: ldarg.3
    IL_03c1: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_03c6: pop
    IL_03c7: ret
    IL_03c8: ldarg.0
    IL_03c9: ldarg.0
    IL_03ca: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_03cf: callvirt AudioSet.ClipArray AudioSet::get_BallistaShot()  /*0x0600018C*/
    IL_03d4: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_03d9: ldc.r4 1f
    IL_03de: ldc.r4 1f
    IL_03e3: ldnull
    IL_03e4: ldc.i4.s 30
    IL_03e6: ldc.i4.1
    IL_03e7: ldarg.3
    IL_03e8: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_03ed: pop
    IL_03ee: ret
    IL_03ef: ldarg.0
    IL_03f0: ldarg.0
    IL_03f1: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_03f6: callvirt AudioSet.ClipArray AudioSet::get_PlayerSwordBigHit()  /*0x060001BB*/
    IL_03fb: ldc.r4 1f
    IL_0400: ldc.r4 1f
    IL_0405: ldnull
    IL_0406: ldc.i4.1
    IL_0407: ldc.i4.0
    IL_0408: ldloca.s 0
    IL_040a: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0410: ldloc.0
    IL_0411: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0416: pop
    IL_0417: ret
    IL_0418: ldarg.0
    IL_0419: ldarg.0
    IL_041a: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_041f: callvirt AudioClip AudioSet::get_EnemySpawn()  /*0x0600018D*/
    IL_0424: ldc.r4 0.85f
    IL_0429: ldc.r4 0.95f
    IL_042e: ldc.r4 1.05f
    IL_0433: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0438: ldnull
    IL_0439: ldc.i4 140
    IL_043e: ldc.i4.1
    IL_043f: ldarg.3
    IL_0440: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0445: pop
    IL_0446: ret
    IL_0447: ldarg.0
    IL_0448: ldarg.0
    IL_0449: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_044e: callvirt AudioClip AudioSet::get_ShowWaveCount()  /*0x060001E8*/
    IL_0453: ldc.r4 0.5f
    IL_0458: ldc.r4 1f
    IL_045d: ldnull
    IL_045e: ldc.i4 128
    IL_0463: ldc.i4.0
    IL_0464: ldloca.s 0
    IL_0466: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_046c: ldloc.0
    IL_046d: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_0472: pop
    IL_0473: ret
    IL_0474: ldarg.0
    IL_0475: ldarg.0
    IL_0476: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_047b: callvirt AudioClip AudioSet::get_CloseWaveCount()  /*0x060001E9*/
    IL_0480: ldc.r4 1f
    IL_0485: ldc.r4 1f
    IL_048a: ldnull
    IL_048b: ldc.i4 128
    IL_0490: ldc.i4.0
    IL_0491: ldloca.s 0
    IL_0493: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0499: ldloc.0
    IL_049a: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_049f: pop
    IL_04a0: ret
    IL_04a1: ldarg.0
    IL_04a2: ldarg.0
    IL_04a3: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_04a8: callvirt AudioClip AudioSet::get_ShowTooltip()  /*0x060001EA*/
    IL_04ad: ldc.r4 0.3f
    IL_04b2: ldc.r4 1f
    IL_04b7: ldnull
    IL_04b8: ldc.i4 128
    IL_04bd: ldc.i4.0
    IL_04be: ldloca.s 0
    IL_04c0: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_04c6: ldloc.0
    IL_04c7: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000213*/
    IL_04cc: pop
    IL_04cd: ret
    IL_04ce: ldarg.0
    IL_04cf: ldarg.0
    IL_04d0: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_04d5: callvirt AudioSet.ClipArray AudioSet::get_PlayerLightningWandActiveAbility()  /*0x060001C4*/
    IL_04da: ldc.r4 0.6f
    IL_04df: ldc.r4 1f
    IL_04e4: ldnull
    IL_04e5: ldc.i4.1
    IL_04e6: ldc.i4.1
    IL_04e7: ldarg.3
    IL_04e8: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_04ed: pop
    IL_04ee: ret
    IL_04ef: ldarg.0
    IL_04f0: ldarg.0
    IL_04f1: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_04f6: callvirt AudioSet.ClipArray AudioSet::get_PlayerTrapPlace()  /*0x060001C7*/
    IL_04fb: ldc.r4 0.2f
    IL_0500: ldc.r4 0.95f
    IL_0505: ldc.r4 1.05f
    IL_050a: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_050f: ldnull
    IL_0510: ldc.i4.1
    IL_0511: ldc.i4.1
    IL_0512: ldarg.3
    IL_0513: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0518: pop
    IL_0519: ret
    IL_051a: ldarg.0
    IL_051b: ldarg.0
    IL_051c: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0521: callvirt AudioSet.ClipArray AudioSet::get_PlayerTrapHit()  /*0x060001C8*/
    IL_0526: ldc.r4 0.6f
    IL_052b: ldc.r4 0.95f
    IL_0530: ldc.r4 1.05f
    IL_0535: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_053a: ldnull
    IL_053b: ldc.i4.1
    IL_053c: ldc.i4.1
    IL_053d: ldarg.3
    IL_053e: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0543: pop
    IL_0544: ret
    IL_0545: ldarg.0
    IL_0546: ldarg.0
    IL_0547: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_054c: callvirt AudioSet.ClipArray AudioSet::get_PlayerPotionHit()  /*0x060001CA*/
    IL_0551: ldc.r4 0.75f
    IL_0556: ldc.r4 0.95f
    IL_055b: ldc.r4 1.05f
    IL_0560: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0565: ldnull
    IL_0566: ldc.i4.1
    IL_0567: ldc.i4.1
    IL_0568: ldarg.3
    IL_0569: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_056e: pop
    IL_056f: ret
    IL_0570: ldarg.0
    IL_0571: ldarg.0
    IL_0572: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0577: callvirt AudioSet.ClipArray AudioSet::get_PlayerPotionActive()  /*0x060001CB*/
    IL_057c: ldc.r4 0.75f
    IL_0581: ldc.r4 0.95f
    IL_0586: ldc.r4 1.05f
    IL_058b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0590: ldnull
    IL_0591: ldc.i4.1
    IL_0592: ldc.i4.0
    IL_0593: ldloca.s 0
    IL_0595: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_059b: ldloc.0
    IL_059c: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_05a1: pop
    IL_05a2: ret
    IL_05a3: ldarg.0
    IL_05a4: ldarg.0
    IL_05a5: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_05aa: callvirt AudioSet.ClipArray AudioSet::get_PlayerAxeActive()  /*0x060001CD*/
    IL_05af: ldc.r4 0.7f
    IL_05b4: ldc.r4 0.975f
    IL_05b9: ldc.r4 1.025f
    IL_05be: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_05c3: ldnull
    IL_05c4: ldc.i4.1
    IL_05c5: ldc.i4.0
    IL_05c6: ldloca.s 0
    IL_05c8: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_05ce: ldloc.0
    IL_05cf: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_05d4: pop
    IL_05d5: ret
    IL_05d6: ldarg.0
    IL_05d7: ldarg.0
    IL_05d8: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_05dd: callvirt AudioSet.ClipArray AudioSet::get_PlayerBloodwandActive()  /*0x060001CF*/
    IL_05e2: ldc.r4 0.4f
    IL_05e7: ldc.r4 0.975f
    IL_05ec: ldc.r4 1.025f
    IL_05f1: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_05f6: ldnull
    IL_05f7: ldc.i4.1
    IL_05f8: ldc.i4.0
    IL_05f9: ldloca.s 0
    IL_05fb: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_0601: ldloc.0
    IL_0602: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  /*0x06000214*/
    IL_0607: pop
    IL_0608: ret

  .method ThronefallAudioManager::PlaySoundAsOneShot(UnityEngine.AudioClip,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  // token 0x06000213 rva 0x9058 attrs Public, HideBySig
    // code size 217 (0xd9), max stack 2, init locals
    IL_0000: ldarg.s 4
    IL_0002: ldnull
    IL_0003: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0008: brfalse.s IL_0012
    IL_000a: ldarg.0
    IL_000b: ldfld AudioMixerGroup ThronefallAudioManager::mgSFX  /*0x04000280*/
    IL_0010: starg.s 4
    IL_0012: ldarg.0
    IL_0013: ldarg.0
    IL_0014: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::GetFreeOneshotSource()  /*0x06000215*/
    IL_0019: stfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_001e: ldarg.0
    IL_001f: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0024: brtrue.s IL_0028
    IL_0026: ldnull
    IL_0027: ret
    IL_0028: ldarg.s 6
    IL_002a: brfalse.s IL_005a
    IL_002c: ldarg.0
    IL_002d: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0032: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_0037: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003c: ldarg.s 7
    IL_003e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0043: ldarg.0
    IL_0044: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0049: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_004e: ldc.r4 1f
    IL_0053: callvirt void UnityEngine.AudioSource::set_spatialBlend(float)  /*0x0A0000D5*/
    IL_0058: br.s IL_006f
    IL_005a: ldarg.0
    IL_005b: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0060: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_0065: ldc.r4 0f
    IL_006a: callvirt void UnityEngine.AudioSource::set_spatialBlend(float)  /*0x0A0000D5*/
    IL_006f: ldarg.0
    IL_0070: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0075: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_007a: ldarg.2
    IL_007b: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0080: ldarg.0
    IL_0081: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0086: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_008b: ldarg.3
    IL_008c: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0091: ldarg.0
    IL_0092: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0097: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_009c: ldarg.s 4
    IL_009e: callvirt void UnityEngine.AudioSource::set_outputAudioMixerGroup(UnityEngine.Audio.AudioMixerGroup)  /*0x0A0000D7*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00a9: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_00ae: ldarg.s 5
    IL_00b0: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_00b5: ldarg.0
    IL_00b6: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00bb: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_00c0: ldarg.1
    IL_00c1: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00cc: ldc.i4.0
    IL_00cd: stfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_00d2: ldarg.0
    IL_00d3: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00d8: ret

  .method ThronefallAudioManager::PlaySoundAsOneShot(AudioSet.ClipArray,float,float,UnityEngine.Audio.AudioMixerGroup,int,bool,UnityEngine.Vector3)  // token 0x06000214 rva 0x9140 attrs Public, HideBySig
    // code size 253 (0xfd), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: brtrue.s IL_0005
    IL_0003: ldnull
    IL_0004: ret
    IL_0005: ldarg.1
    IL_0006: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_000b: ldlen
    IL_000c: brtrue.s IL_0010
    IL_000e: ldnull
    IL_000f: ret
    IL_0010: ldarg.s 4
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brfalse.s IL_0022
    IL_001a: ldarg.0
    IL_001b: ldfld AudioMixerGroup ThronefallAudioManager::mgSFX  /*0x04000280*/
    IL_0020: starg.s 4
    IL_0022: ldarg.0
    IL_0023: ldarg.0
    IL_0024: call ThronefallAudioManager.OneshotSource ThronefallAudioManager::GetFreeOneshotSource()  /*0x06000215*/
    IL_0029: stfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_002e: ldarg.0
    IL_002f: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0034: brtrue.s IL_0038
    IL_0036: ldnull
    IL_0037: ret
    IL_0038: ldarg.s 6
    IL_003a: brfalse.s IL_006a
    IL_003c: ldarg.0
    IL_003d: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0042: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_0047: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004c: ldarg.s 7
    IL_004e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0053: ldarg.0
    IL_0054: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0059: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_005e: ldc.r4 1f
    IL_0063: callvirt void UnityEngine.AudioSource::set_spatialBlend(float)  /*0x0A0000D5*/
    IL_0068: br.s IL_007f
    IL_006a: ldarg.0
    IL_006b: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0070: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_0075: ldc.r4 0f
    IL_007a: callvirt void UnityEngine.AudioSource::set_spatialBlend(float)  /*0x0A0000D5*/
    IL_007f: ldarg.0
    IL_0080: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0085: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_008a: ldarg.2
    IL_008b: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0090: ldarg.0
    IL_0091: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_0096: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_009b: ldarg.3
    IL_009c: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_00a1: ldarg.0
    IL_00a2: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00a7: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_00ac: ldarg.s 4
    IL_00ae: callvirt void UnityEngine.AudioSource::set_outputAudioMixerGroup(UnityEngine.Audio.AudioMixerGroup)  /*0x0A0000D7*/
    IL_00b3: ldarg.0
    IL_00b4: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00b9: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_00be: ldarg.s 5
    IL_00c0: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_00c5: ldarg.0
    IL_00c6: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00cb: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_00d0: ldarg.1
    IL_00d1: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_00d6: ldc.i4.0
    IL_00d7: ldarg.1
    IL_00d8: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_00dd: ldlen
    IL_00de: conv.i4
    IL_00df: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_00e4: ldelem.ref
    IL_00e5: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_00ea: ldarg.0
    IL_00eb: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00f0: ldc.i4.0
    IL_00f1: stfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_00f6: ldarg.0
    IL_00f7: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::bufferOneshotSource  /*0x0400027D*/
    IL_00fc: ret

  .method ThronefallAudioManager::GetFreeOneshotSource()  // token 0x06000215 rva 0x924c attrs Private, HideBySig
    // code size 74 (0x4a), max stack 2, init locals
    .locals ([0] List.Enumerator<ThronefallAudioManager.OneshotSource>, [1] ThronefallAudioManager.OneshotSource, [2] ThronefallAudioManager.OneshotSource)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ThronefallAudioManager.OneshotSource> ThronefallAudioManager::oneshotSourcePool  /*0x0400027C*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<ThronefallAudioManager.OneshotSource>::GetEnumerator()  /*0x0A0000D8*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0022
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>::get_Current()  /*0x0A0000D9*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_001c: brfalse.s IL_0022
    IL_001e: ldloc.1
    IL_001f: stloc.2
    IL_0020: leave.s IL_0048
    IL_0022: ldloca.s 0
    IL_0024: call bool System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>::MoveNext()  /*0x0A0000DA*/
    IL_0029: brtrue.s IL_000e
    IL_002b: leave.s IL_003b
    IL_002d: ldloca.s 0
    IL_002f: constrained. System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>  /*0x1B00001A*/
    IL_0035: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003a: endfinally
    IL_003b: ldarg.0
    IL_003c: ldfld List<ThronefallAudioManager.OneshotSource> ThronefallAudioManager::oneshotSourcePool  /*0x0400027C*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt !0 System.Collections.Generic.List<ThronefallAudioManager.OneshotSource>::get_Item(int)  /*0x0A0000DB*/
    IL_0047: ret
    IL_0048: ldloc.2
    IL_0049: ret
    .try IL_000c-IL_002d finally handler IL_002d-IL_003b

  .method ThronefallAudioManager::RecycleOneshotSources()  // token 0x06000216 rva 0x92b4 attrs Private, HideBySig
    // code size 79 (0x4f), max stack 2, init locals
    .locals ([0] List.Enumerator<ThronefallAudioManager.OneshotSource>, [1] ThronefallAudioManager.OneshotSource)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ThronefallAudioManager.OneshotSource> ThronefallAudioManager::oneshotSourcePool  /*0x0400027C*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<ThronefallAudioManager.OneshotSource>::GetEnumerator()  /*0x0A0000D8*/
    IL_000b: stloc.0
    IL_000c: br.s IL_002a
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>::get_Current()  /*0x0A0000D9*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_001c: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_0021: brtrue.s IL_002a
    IL_0023: ldloc.1
    IL_0024: ldc.i4.1
    IL_0025: stfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_002a: ldloca.s 0
    IL_002c: call bool System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>::MoveNext()  /*0x0A0000DA*/
    IL_0031: brtrue.s IL_000e
    IL_0033: leave.s IL_0043
    IL_0035: ldloca.s 0
    IL_0037: constrained. System.Collections.Generic.List.Enumerator<ThronefallAudioManager.OneshotSource>  /*0x1B00001A*/
    IL_003d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0042: endfinally
    IL_0043: ldarg.0
    IL_0044: ldc.r4 0f
    IL_0049: stfld float ThronefallAudioManager::oneshotSourceRecycleClock  /*0x0400027B*/
    IL_004e: ret
    .try IL_000c-IL_0035 finally handler IL_0035-IL_0043

  .method ThronefallAudioManager::StopCoinfillBackground()  // token 0x06000217 rva 0x9320 attrs Private, HideBySig
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_0006: brfalse.s IL_0036
    IL_0008: ldarg.0
    IL_0009: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_000e: ldc.i4.1
    IL_000f: stfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_0014: ldarg.0
    IL_0015: ldfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_001a: ldfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_001f: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_0024: ldarg.0
    IL_0025: ldnull
    IL_0026: stfld ThronefallAudioManager.OneshotSource ThronefallAudioManager::coinslotFillBackground  /*0x04000286*/
    IL_002b: ldarg.0
    IL_002c: ldc.r4 0f
    IL_0031: stfld float ThronefallAudioManager::coinslotFillBackgroundClock  /*0x04000287*/
    IL_0036: ret

  .method ThronefallAudioManager::MakeSureCoinFillSoundIsNotPlayingAnymore()  // token 0x06000218 rva 0x9358 attrs Public, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ThronefallAudioManager::StopCoinfillBackground()  /*0x06000217*/
    IL_0006: ret

  .method ThronefallAudioManager::Oneshot(ThronefallAudioManager.AudioOneShot)  // token 0x06000219 rva 0x9360 attrs Public, Static, HideBySig
    // code size 46 (0x2e), max stack 4, init locals
    .locals ([0] Vector3)
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0023
    IL_000d: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0012: ldarg.0
    IL_0013: ldc.i4.0
    IL_0014: ldloca.s 0
    IL_0016: initobj UnityEngine.Vector3  /*0x01000028*/
    IL_001c: ldloc.0
    IL_001d: callvirt void ThronefallAudioManager::ProcessOneShotEvent(ThronefallAudioManager.AudioOneShot,bool,UnityEngine.Vector3)  /*0x06000212*/
    IL_0022: ret
    IL_0023: ldstr "No Audio Manager"
    IL_0028: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_002d: ret

  .method ThronefallAudioManager::WorldSpaceOneShot(ThronefallAudioManager.AudioOneShot,UnityEngine.Vector3)  // token 0x0600021A rva 0x939a attrs Public, Static, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_001b
    IL_000d: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0012: ldarg.0
    IL_0013: ldc.i4.1
    IL_0014: ldarg.1
    IL_0015: callvirt void ThronefallAudioManager::ProcessOneShotEvent(ThronefallAudioManager.AudioOneShot,bool,UnityEngine.Vector3)  /*0x06000212*/
    IL_001a: ret
    IL_001b: ldstr "No Audio Manager"
    IL_0020: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0025: ret

  .method ThronefallAudioManager::Mute()  // token 0x0600021B rva 0x93c1 attrs Public, Static, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldc.i4.1
    IL_0006: stfld bool ThronefallAudioManager::muted  /*0x04000283*/
    IL_000b: ret

  .method ThronefallAudioManager::Unmute()  // token 0x0600021C rva 0x93ce attrs Public, Static, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldc.i4.0
    IL_0006: stfld bool ThronefallAudioManager::muted  /*0x04000283*/
    IL_000b: ret

  .method ThronefallAudioManager::SetCoinDisplayFillTime(float)  // token 0x0600021D rva 0x93db attrs Public, Static, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld ThronefallAudioManager ThronefallAudioManager::instance  /*0x04000278*/
    IL_0005: ldarg.0
    IL_0006: stfld float ThronefallAudioManager::coinslotTotalFillTime  /*0x04000288*/
    IL_000b: ret

  .method ThronefallAudioManager::.ctor()  // token 0x0600021E rva 0x93e8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 15f
    IL_0006: stfld float ThronefallAudioManager::oneshotAudioPoolSize  /*0x04000279*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.3f
    IL_0011: stfld float ThronefallAudioManager::onshotAudioPoolRecycleTick  /*0x0400027A*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.List<ThronefallAudioManager.OneshotSource>::.ctor()  /*0x0A0000DE*/
    IL_001c: stfld List<ThronefallAudioManager.OneshotSource> ThronefallAudioManager::oneshotSourcePool  /*0x0400027C*/
    IL_0021: ldarg.0
    IL_0022: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0027: stfld UnityEvent ThronefallAudioManager::onBuildingBuild  /*0x04000282*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 1f
    IL_0032: stfld float ThronefallAudioManager::coinslotFillPitch  /*0x04000284*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0.025f
    IL_003d: stfld float ThronefallAudioManager::coinslotFillPitchIncrease  /*0x04000285*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 1f
    IL_0048: stfld float ThronefallAudioManager::coinslotTotalFillTime  /*0x04000288*/
    IL_004d: ldarg.0
    IL_004e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0053: ret

// ===== ThronefallAudioManager/OneshotSource  (token 0x02000060) =====
  .method ThronefallAudioManager.OneshotSource::.ctor(UnityEngine.AudioSource)  // token 0x0600021F rva 0x9448 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ThronefallAudioManager.OneshotSource::available  /*0x0400028A*/
    IL_0007: ldarg.0
    IL_0008: call void System.Object::.ctor()  /*0x0A000038*/
    IL_000d: ldarg.0
    IL_000e: ldarg.1
    IL_000f: stfld AudioSource ThronefallAudioManager.OneshotSource::aSource  /*0x04000289*/
    IL_0014: ret

// ===== ThronefallAudioManager/AudioOneShot  (token 0x02000061) =====
