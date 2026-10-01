// ===== UnitAudio  (token 0x02000062) =====
  .method UnitAudio::get_isBounceLocomotion()  // token 0x06000220 rva 0x945e attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method UnitAudio::get_isPerpetualLocomotion()  // token 0x06000221 rva 0x9469 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0006: ldc.i4.2
    IL_0007: ceq
    IL_0009: ret

  .method UnitAudio::get_isRollingLocomotion()  // token 0x06000222 rva 0x9474 attrs Private, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0006: ldc.i4.1
    IL_0007: ceq
    IL_0009: ret

  .method UnitAudio::Start()  // token 0x06000223 rva 0x9480 attrs Private, HideBySig
    // code size 1328 (0x530), max stack 4, init locals
    .locals ([0] AudioSet, [1] UnitAudio.StepType, [2] UnitAudio.AttackType, [3] UnitAudio.DmgType, [4] UnitAudio.DeathType, [5] UnitAudio.LocomotionMode)
    IL_0000: ldarg.0
    IL_0001: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0006: brtrue.s IL_001b
    IL_0008: ldarg.0
    IL_0009: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_000e: ldarg.0
    IL_000f: ldfld int UnitAudio::stepPriority  /*0x040002BE*/
    IL_0014: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_0019: br.s IL_002c
    IL_001b: ldarg.0
    IL_001c: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0021: ldarg.0
    IL_0022: ldfld int UnitAudio::rollPriority  /*0x040002BD*/
    IL_0027: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_002c: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0031: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0036: stloc.0
    IL_0037: ldarg.0
    IL_0038: ldfld UnitAudio.StepType UnitAudio::step  /*0x040002B1*/
    IL_003d: stloc.1
    IL_003e: ldloc.1
    IL_003f: switch (IL_0081, IL_0092, IL_00a3, IL_00c5, IL_00e1, IL_00d3, IL_00ef, IL_00fd, IL_010b, IL_00b4, IL_0119, IL_0127, IL_0135, IL_0143)
    IL_007c: br IL_014f
    IL_0081: ldarg.0
    IL_0082: ldloc.0
    IL_0083: callvirt AudioSet.ClipArray AudioSet::get_DefaultOnFootStep()  /*0x0600018E*/
    IL_0088: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_008d: br IL_014f
    IL_0092: ldarg.0
    IL_0093: ldloc.0
    IL_0094: callvirt AudioSet.ClipArray AudioSet::get_GiantStep()  /*0x0600018F*/
    IL_0099: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_009e: br IL_014f
    IL_00a3: ldarg.0
    IL_00a4: ldloc.0
    IL_00a5: callvirt AudioSet.ClipArray AudioSet::get_FlyingSmall()  /*0x06000190*/
    IL_00aa: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00af: br IL_014f
    IL_00b4: ldarg.0
    IL_00b5: ldloc.0
    IL_00b6: callvirt AudioSet.ClipArray AudioSet::get_FlyingBig()  /*0x06000191*/
    IL_00bb: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00c0: br IL_014f
    IL_00c5: ldarg.0
    IL_00c6: ldloc.0
    IL_00c7: callvirt AudioSet.ClipArray AudioSet::get_SiegeRoll()  /*0x06000193*/
    IL_00cc: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00d1: br.s IL_014f
    IL_00d3: ldarg.0
    IL_00d4: ldloc.0
    IL_00d5: callvirt AudioSet.ClipArray AudioSet::get_SquishyBounce()  /*0x06000195*/
    IL_00da: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00df: br.s IL_014f
    IL_00e1: ldarg.0
    IL_00e2: ldloc.0
    IL_00e3: callvirt AudioSet.ClipArray AudioSet::get_RacerRoll()  /*0x06000194*/
    IL_00e8: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00ed: br.s IL_014f
    IL_00ef: ldarg.0
    IL_00f0: ldloc.0
    IL_00f1: callvirt AudioSet.ClipArray AudioSet::get_ExploderRoll()  /*0x06000196*/
    IL_00f6: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_00fb: br.s IL_014f
    IL_00fd: ldarg.0
    IL_00fe: ldloc.0
    IL_00ff: callvirt AudioSet.ClipArray AudioSet::get_MonsterRiderGallop()  /*0x06000197*/
    IL_0104: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0109: br.s IL_014f
    IL_010b: ldarg.0
    IL_010c: ldloc.0
    IL_010d: callvirt AudioSet.ClipArray AudioSet::get_SlimeStep()  /*0x06000198*/
    IL_0112: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0117: br.s IL_014f
    IL_0119: ldarg.0
    IL_011a: ldloc.0
    IL_011b: callvirt AudioSet.ClipArray AudioSet::get_FlyingWizzard()  /*0x06000192*/
    IL_0120: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0125: br.s IL_014f
    IL_0127: ldarg.0
    IL_0128: ldloc.0
    IL_0129: callvirt AudioSet.ClipArray AudioSet::get_WindboatFly()  /*0x06000199*/
    IL_012e: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0133: br.s IL_014f
    IL_0135: ldarg.0
    IL_0136: ldloc.0
    IL_0137: callvirt AudioSet.ClipArray AudioSet::get_Steamcastle()  /*0x0600019A*/
    IL_013c: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0141: br.s IL_014f
    IL_0143: ldarg.0
    IL_0144: ldloc.0
    IL_0145: callvirt AudioSet.ClipArray AudioSet::get_Firestorm()  /*0x0600019B*/
    IL_014a: stfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_014f: ldarg.0
    IL_0150: ldfld UnitAudio.AttackType UnitAudio::attack  /*0x040002B4*/
    IL_0155: stloc.2
    IL_0156: ldloc.2
    IL_0157: switch (IL_01a9, IL_01cb, IL_01dc, IL_01fe, IL_01ed, IL_020f, IL_0220, IL_0231, IL_024d, IL_025b, IL_0269, IL_023f, IL_01ba, IL_0277, IL_0285, IL_0293, IL_02a1, IL_02af)
    IL_01a4: br IL_02bb
    IL_01a9: ldarg.0
    IL_01aa: ldloc.0
    IL_01ab: callvirt AudioSet.ClipArray AudioSet::get_DefaultSwordAttack()  /*0x0600019C*/
    IL_01b0: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_01b5: br IL_02bb
    IL_01ba: ldarg.0
    IL_01bb: ldloc.0
    IL_01bc: callvirt AudioSet.ClipArray AudioSet::get_PlayerSpear()  /*0x060001C2*/
    IL_01c1: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_01c6: br IL_02bb
    IL_01cb: ldarg.0
    IL_01cc: ldloc.0
    IL_01cd: callvirt AudioSet.ClipArray AudioSet::get_MassiveBluntAttack()  /*0x0600019F*/
    IL_01d2: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_01d7: br IL_02bb
    IL_01dc: ldarg.0
    IL_01dd: ldloc.0
    IL_01de: callvirt AudioSet.ClipArray AudioSet::get_FlyerSpit()  /*0x060001A0*/
    IL_01e3: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_01e8: br IL_02bb
    IL_01ed: ldarg.0
    IL_01ee: ldloc.0
    IL_01ef: callvirt AudioSet.ClipArray AudioSet::get_CrossbowShot()  /*0x060001A2*/
    IL_01f4: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_01f9: br IL_02bb
    IL_01fe: ldarg.0
    IL_01ff: ldloc.0
    IL_0200: callvirt AudioSet.ClipArray AudioSet::get_FlatbowShot()  /*0x060001A1*/
    IL_0205: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_020a: br IL_02bb
    IL_020f: ldarg.0
    IL_0210: ldloc.0
    IL_0211: callvirt AudioSet.ClipArray AudioSet::get_CatapultShot()  /*0x060001A3*/
    IL_0216: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_021b: br IL_02bb
    IL_0220: ldarg.0
    IL_0221: ldloc.0
    IL_0222: callvirt AudioSet.ClipArray AudioSet::get_RacerBite()  /*0x060001A5*/
    IL_0227: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_022c: br IL_02bb
    IL_0231: ldarg.0
    IL_0232: ldloc.0
    IL_0233: callvirt AudioSet.ClipArray AudioSet::get_HunterlingBite()  /*0x060001A6*/
    IL_0238: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_023d: br.s IL_02bb
    IL_023f: ldarg.0
    IL_0240: ldloc.0
    IL_0241: callvirt AudioSet.ClipArray AudioSet::get_FireSpit()  /*0x060001A9*/
    IL_0246: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_024b: br.s IL_02bb
    IL_024d: ldarg.0
    IL_024e: ldloc.0
    IL_024f: callvirt AudioSet.ClipArray AudioSet::get_Ram()  /*0x060001A4*/
    IL_0254: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0259: br.s IL_02bb
    IL_025b: ldarg.0
    IL_025c: ldloc.0
    IL_025d: callvirt AudioSet.ClipArray AudioSet::get_SlimeSpit()  /*0x060001A7*/
    IL_0262: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0267: br.s IL_02bb
    IL_0269: ldarg.0
    IL_026a: ldloc.0
    IL_026b: callvirt AudioSet.ClipArray AudioSet::get_HealingProjectile()  /*0x060001AA*/
    IL_0270: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0275: br.s IL_02bb
    IL_0277: ldarg.0
    IL_0278: ldloc.0
    IL_0279: callvirt AudioSet.ClipArray AudioSet::get_FlyingWizardCast()  /*0x060001AB*/
    IL_027e: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0283: br.s IL_02bb
    IL_0285: ldarg.0
    IL_0286: ldloc.0
    IL_0287: callvirt AudioSet.ClipArray AudioSet::get_SpiderBite()  /*0x060001A8*/
    IL_028c: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0291: br.s IL_02bb
    IL_0293: ldarg.0
    IL_0294: ldloc.0
    IL_0295: callvirt AudioSet.ClipArray AudioSet::get_FlailAttack()  /*0x0600019D*/
    IL_029a: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_029f: br.s IL_02bb
    IL_02a1: ldarg.0
    IL_02a2: ldloc.0
    IL_02a3: callvirt AudioSet.ClipArray AudioSet::get_WindboatShot()  /*0x060001AC*/
    IL_02a8: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_02ad: br.s IL_02bb
    IL_02af: ldarg.0
    IL_02b0: ldloc.0
    IL_02b1: callvirt AudioSet.ClipArray AudioSet::get_WindboatShot()  /*0x060001AC*/
    IL_02b6: stfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_02bb: ldarg.0
    IL_02bc: ldfld UnitAudio.DmgType UnitAudio::dmg  /*0x040002BA*/
    IL_02c1: stloc.3
    IL_02c2: ldloc.3
    IL_02c3: switch (IL_02da, IL_02e8, IL_02f6, IL_0304)
    IL_02d8: br.s IL_0310
    IL_02da: ldarg.0
    IL_02db: ldloc.0
    IL_02dc: callvirt AudioSet.ClipArray AudioSet::get_DefaultHumanoidOnFootDamage()  /*0x060001AE*/
    IL_02e1: stfld AudioSet.ClipArray UnitAudio::soundOnDmg  /*0x040002C2*/
    IL_02e6: br.s IL_0310
    IL_02e8: ldarg.0
    IL_02e9: ldloc.0
    IL_02ea: callvirt AudioSet.ClipArray AudioSet::get_BigOrganicDamage()  /*0x060001AF*/
    IL_02ef: stfld AudioSet.ClipArray UnitAudio::soundOnDmg  /*0x040002C2*/
    IL_02f4: br.s IL_0310
    IL_02f6: ldarg.0
    IL_02f7: ldloc.0
    IL_02f8: callvirt AudioSet.ClipArray AudioSet::get_SmallOrganicDamage()  /*0x060001B0*/
    IL_02fd: stfld AudioSet.ClipArray UnitAudio::soundOnDmg  /*0x040002C2*/
    IL_0302: br.s IL_0310
    IL_0304: ldarg.0
    IL_0305: ldloc.0
    IL_0306: callvirt AudioSet.ClipArray AudioSet::get_SiegeDamage()  /*0x060001B1*/
    IL_030b: stfld AudioSet.ClipArray UnitAudio::soundOnDmg  /*0x040002C2*/
    IL_0310: ldarg.0
    IL_0311: ldfld UnitAudio.DeathType UnitAudio::death  /*0x040002B7*/
    IL_0316: stloc.s 4
    IL_0318: ldloc.s 4
    IL_031a: switch (IL_0335, IL_0343, IL_0351, IL_035f, IL_036d)
    IL_0333: br.s IL_0379
    IL_0335: ldarg.0
    IL_0336: ldloc.0
    IL_0337: callvirt AudioSet.ClipArray AudioSet::get_DefaultHumanoidOnFootDeath()  /*0x060001B2*/
    IL_033c: stfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_0341: br.s IL_0379
    IL_0343: ldarg.0
    IL_0344: ldloc.0
    IL_0345: callvirt AudioSet.ClipArray AudioSet::get_BigOrganicDeath()  /*0x060001B3*/
    IL_034a: stfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_034f: br.s IL_0379
    IL_0351: ldarg.0
    IL_0352: ldloc.0
    IL_0353: callvirt AudioSet.ClipArray AudioSet::get_SiegeDeath()  /*0x060001B4*/
    IL_0358: stfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_035d: br.s IL_0379
    IL_035f: ldarg.0
    IL_0360: ldloc.0
    IL_0361: callvirt AudioSet.ClipArray AudioSet::get_ExploderDeath()  /*0x060001B5*/
    IL_0366: stfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_036b: br.s IL_0379
    IL_036d: ldarg.0
    IL_036e: ldloc.0
    IL_036f: callvirt AudioSet.ClipArray AudioSet::get_UnitBuildingCollpse()  /*0x060001B6*/
    IL_0374: stfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_0379: ldarg.0
    IL_037a: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_037f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0384: brfalse.s IL_03da
    IL_0386: ldarg.0
    IL_0387: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_038c: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0391: ldarg.0
    IL_0392: ldftn void UnitAudio::PlayDeath()  /*0x06000229*/
    IL_0398: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_039d: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_03a2: ldarg.0
    IL_03a3: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_03a8: ldfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_03ad: ldarg.0
    IL_03ae: ldftn void UnitAudio::PlayDMG(bool)  /*0x06000228*/
    IL_03b4: newobj void UnityEngine.Events.UnityAction<bool>::.ctor(object,IntPtr)  /*0x0A0000CC*/
    IL_03b9: callvirt void UnityEngine.Events.UnityEvent<bool>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0000CD*/
    IL_03be: ldarg.0
    IL_03bf: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_03c4: ldfld UnityEvent Hp::OnRevive  /*0x04000A3B*/
    IL_03c9: ldarg.0
    IL_03ca: ldftn void UnitAudio::Revive()  /*0x0600022A*/
    IL_03d0: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_03d5: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_03da: ldarg.0
    IL_03db: ldfld AutoAttack UnitAudio::attackTrigger  /*0x040002AE*/
    IL_03e0: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_03e5: brfalse.s IL_0403
    IL_03e7: ldarg.0
    IL_03e8: ldfld AutoAttack UnitAudio::attackTrigger  /*0x040002AE*/
    IL_03ed: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_03f2: ldarg.0
    IL_03f3: ldftn void UnitAudio::PlayAttack()  /*0x06000227*/
    IL_03f9: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_03fe: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0403: ldarg.0
    IL_0404: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0409: stloc.s 5
    IL_040b: ldloc.s 5
    IL_040d: switch (IL_04eb, IL_0423, IL_0483)
    IL_041e: br IL_0514
    IL_0423: ldarg.0
    IL_0424: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0429: ldarg.0
    IL_042a: ldfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_042f: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0434: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0439: ldarg.0
    IL_043a: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_043f: ldarg.0
    IL_0440: ldfld float UnitAudio::stepVolume  /*0x040002B2*/
    IL_0445: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_044a: ldarg.0
    IL_044b: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0450: ldc.i4.1
    IL_0451: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_0456: ldarg.0
    IL_0457: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_045c: ldc.r4 1f
    IL_0461: ldarg.0
    IL_0462: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_0467: sub
    IL_0468: ldc.r4 1f
    IL_046d: ldarg.0
    IL_046e: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_0473: add
    IL_0474: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0479: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_047e: br IL_0514
    IL_0483: ldarg.0
    IL_0484: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0489: ldarg.0
    IL_048a: ldfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_048f: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0494: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0499: ldarg.0
    IL_049a: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_049f: ldarg.0
    IL_04a0: ldfld float UnitAudio::stepVolume  /*0x040002B2*/
    IL_04a5: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_04aa: ldarg.0
    IL_04ab: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_04b0: ldc.i4.1
    IL_04b1: callvirt void UnityEngine.AudioSource::set_loop(bool)  /*0x0A0000DF*/
    IL_04b6: ldarg.0
    IL_04b7: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_04bc: ldc.r4 1f
    IL_04c1: ldarg.0
    IL_04c2: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_04c7: sub
    IL_04c8: ldc.r4 1f
    IL_04cd: ldarg.0
    IL_04ce: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_04d3: add
    IL_04d4: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_04d9: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_04de: ldarg.0
    IL_04df: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_04e4: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_04e9: br.s IL_0514
    IL_04eb: ldarg.0
    IL_04ec: ldfld SimpleWalk UnitAudio::walkSource  /*0x040002AA*/
    IL_04f1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_04f6: brfalse.s IL_0514
    IL_04f8: ldarg.0
    IL_04f9: ldfld SimpleWalk UnitAudio::walkSource  /*0x040002AA*/
    IL_04fe: ldfld UnityEvent SimpleWalk::onGroundContact  /*0x04000197*/
    IL_0503: ldarg.0
    IL_0504: ldftn void UnitAudio::PlayStep()  /*0x06000226*/
    IL_050a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_050f: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0514: ldarg.0
    IL_0515: call bool UnitAudio::get_isRollingLocomotion()  /*0x06000222*/
    IL_051a: brfalse.s IL_052f
    IL_051c: ldarg.0
    IL_051d: ldarg.0
    IL_051e: ldfld float UnitAudio::maxSpeed  /*0x040002AB*/
    IL_0523: ldarg.0
    IL_0524: ldfld float UnitAudio::maxSpeed  /*0x040002AB*/
    IL_0529: mul
    IL_052a: stfld float UnitAudio::maxSpeed  /*0x040002AB*/
    IL_052f: ret

  .method UnitAudio::Update()  // token 0x06000224 rva 0x99bc attrs Private, HideBySig
    // code size 227 (0xe3), max stack 5, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitAudio::dead  /*0x040002C6*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: call float UnityEngine.Time::get_timeScale()  /*0x0A0000E0*/
    IL_000e: ldc.r4 0.1f
    IL_0013: bge.un.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_001b: callvirt void UnityEngine.AudioSource::Pause()  /*0x0A0000E1*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0027: ldc.i4.2
    IL_0028: bne.un.s IL_0043
    IL_002a: ldarg.0
    IL_002b: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0030: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_0035: brtrue.s IL_0043
    IL_0037: ldarg.0
    IL_0038: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_003d: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0042: ret
    IL_0043: ldarg.0
    IL_0044: ldfld UnitAudio.LocomotionMode UnitAudio::locomotionMode  /*0x040002A9*/
    IL_0049: ldc.i4.1
    IL_004a: bne.un IL_00e2
    IL_004f: ldarg.0
    IL_0050: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0055: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_005a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005f: stloc.0
    IL_0060: ldloc.0
    IL_0061: ldarg.0
    IL_0062: ldfld Vector3 UnitAudio::lastPosition  /*0x040002C7*/
    IL_0067: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_006c: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0071: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0076: stloc.1
    IL_0077: ldloca.s 1
    IL_0079: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_007e: stloc.2
    IL_007f: ldarg.0
    IL_0080: ldloc.0
    IL_0081: stfld Vector3 UnitAudio::lastPosition  /*0x040002C7*/
    IL_0086: ldloc.2
    IL_0087: ldc.r4 0.25f
    IL_008c: ble.un.s IL_00ca
    IL_008e: ldarg.0
    IL_008f: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0094: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_0099: brtrue.s IL_00a6
    IL_009b: ldarg.0
    IL_009c: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_00a1: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_00a6: ldarg.0
    IL_00a7: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_00ac: ldc.r4 0f
    IL_00b1: ldarg.0
    IL_00b2: ldfld float UnitAudio::stepVolume  /*0x040002B2*/
    IL_00b7: ldloc.2
    IL_00b8: ldarg.0
    IL_00b9: ldfld float UnitAudio::maxSpeed  /*0x040002AB*/
    IL_00be: div
    IL_00bf: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00c4: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_00c9: ret
    IL_00ca: ldarg.0
    IL_00cb: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_00d0: callvirt bool UnityEngine.AudioSource::get_isPlaying()  /*0x0A00001C*/
    IL_00d5: brfalse.s IL_00e2
    IL_00d7: ldarg.0
    IL_00d8: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_00dd: callvirt void UnityEngine.AudioSource::Pause()  /*0x0A0000E1*/
    IL_00e2: ret

  .method UnitAudio::PlaySound(UnitAudio.OneshotType)  // token 0x06000225 rva 0x9aac attrs Public, HideBySig
    // code size 310 (0x136), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool UnitAudio::dead  /*0x040002C6*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.1
    IL_000a: switch (IL_0072, IL_001c, IL_00e0)
    IL_001b: ret
    IL_001c: ldarg.0
    IL_001d: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_0022: ldarg.0
    IL_0023: ldfld int UnitAudio::attackPriority  /*0x040002C0*/
    IL_0028: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_002d: ldarg.0
    IL_002e: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_0033: ldc.r4 1f
    IL_0038: ldarg.0
    IL_0039: ldfld float UnitAudio::attackPitchVariation  /*0x040002B6*/
    IL_003e: sub
    IL_003f: ldc.r4 1f
    IL_0044: ldarg.0
    IL_0045: ldfld float UnitAudio::attackPitchVariation  /*0x040002B6*/
    IL_004a: add
    IL_004b: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0050: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0055: ldarg.0
    IL_0056: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_005b: ldarg.0
    IL_005c: ldfld AudioSet.ClipArray UnitAudio::soundOnAttack  /*0x040002C3*/
    IL_0061: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0066: ldarg.0
    IL_0067: ldfld float UnitAudio::attackVolume  /*0x040002B5*/
    IL_006c: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0071: ret
    IL_0072: ldarg.0
    IL_0073: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_0078: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_007d: conv.r8
    IL_007e: ldc.r8 0.01
    IL_0087: bge.un.s IL_008a
    IL_0089: ret
    IL_008a: ldarg.0
    IL_008b: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_0090: ldarg.0
    IL_0091: ldfld int UnitAudio::damagePriority  /*0x040002BF*/
    IL_0096: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_009b: ldarg.0
    IL_009c: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_00a1: ldc.r4 1f
    IL_00a6: ldarg.0
    IL_00a7: ldfld float UnitAudio::dmgPitchVariation  /*0x040002BC*/
    IL_00ac: sub
    IL_00ad: ldc.r4 1f
    IL_00b2: ldarg.0
    IL_00b3: ldfld float UnitAudio::dmgPitchVariation  /*0x040002BC*/
    IL_00b8: add
    IL_00b9: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_00be: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_00c3: ldarg.0
    IL_00c4: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_00c9: ldarg.0
    IL_00ca: ldfld AudioSet.ClipArray UnitAudio::soundOnDmg  /*0x040002C2*/
    IL_00cf: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_00d4: ldarg.0
    IL_00d5: ldfld float UnitAudio::dmgVolume  /*0x040002BB*/
    IL_00da: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_00df: ret
    IL_00e0: ldarg.0
    IL_00e1: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_00e6: ldarg.0
    IL_00e7: ldfld int UnitAudio::deathPriority  /*0x040002C1*/
    IL_00ec: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_00f1: ldarg.0
    IL_00f2: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_00f7: ldc.r4 1f
    IL_00fc: ldarg.0
    IL_00fd: ldfld float UnitAudio::deathPitchVariation  /*0x040002B9*/
    IL_0102: sub
    IL_0103: ldc.r4 1f
    IL_0108: ldarg.0
    IL_0109: ldfld float UnitAudio::deathPitchVariation  /*0x040002B9*/
    IL_010e: add
    IL_010f: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0114: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0119: ldarg.0
    IL_011a: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_011f: ldarg.0
    IL_0120: ldfld AudioSet.ClipArray UnitAudio::soundOnDeath  /*0x040002C4*/
    IL_0125: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_012a: ldarg.0
    IL_012b: ldfld float UnitAudio::deathVolume  /*0x040002B8*/
    IL_0130: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0135: ret

  .method UnitAudio::PlayStep()  // token 0x06000226 rva 0x9bf0 attrs Private, HideBySig
    // code size 86 (0x56), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0006: ldarg.0
    IL_0007: ldfld int UnitAudio::stepPriority  /*0x040002BE*/
    IL_000c: callvirt void UnityEngine.AudioSource::set_priority(int)  /*0x0A0000CB*/
    IL_0011: ldarg.0
    IL_0012: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_0017: ldc.r4 1f
    IL_001c: ldarg.0
    IL_001d: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_0022: sub
    IL_0023: ldc.r4 1f
    IL_0028: ldarg.0
    IL_0029: ldfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_002e: add
    IL_002f: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0034: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0039: ldarg.0
    IL_003a: ldfld AudioSource UnitAudio::stepSource  /*0x040002AC*/
    IL_003f: ldarg.0
    IL_0040: ldfld AudioSet.ClipArray UnitAudio::soundOnStep  /*0x040002C5*/
    IL_0045: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_004a: ldarg.0
    IL_004b: ldfld float UnitAudio::stepVolume  /*0x040002B2*/
    IL_0050: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip,float)  /*0x0A0000CE*/
    IL_0055: ret

  .method UnitAudio::PlayAttack()  // token 0x06000227 rva 0x9c52 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call void UnitAudio::PlaySound(UnitAudio.OneshotType)  /*0x06000225*/
    IL_0007: ret

  .method UnitAudio::PlayDMG(bool)  // token 0x06000228 rva 0x9c5b attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: call void UnitAudio::PlaySound(UnitAudio.OneshotType)  /*0x06000225*/
    IL_0007: ret

  .method UnitAudio::PlayDeath()  // token 0x06000229 rva 0x9c64 attrs Private, HideBySig
    // code size 66 (0x42), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: call void UnitAudio::PlaySound(UnitAudio.OneshotType)  /*0x06000225*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool UnitAudio::dead  /*0x040002C6*/
    IL_000e: ldarg.0
    IL_000f: ldfld Hp UnitAudio::hp  /*0x040002AF*/
    IL_0014: ldfld bool Hp::getsKnockedOutInsteadOfDying  /*0x04000A2D*/
    IL_0019: brtrue.s IL_0041
    IL_001b: ldarg.0
    IL_001c: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_0021: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0026: ldnull
    IL_0027: callvirt void UnityEngine.Transform::set_parent(UnityEngine.Transform)  /*0x0A0000E2*/
    IL_002c: ldarg.0
    IL_002d: ldfld AudioSource UnitAudio::sfxSource  /*0x040002AD*/
    IL_0032: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0037: ldc.r4 3f
    IL_003c: call void UnityEngine.Object::Destroy(UnityEngine.Object,float)  /*0x0A000077*/
    IL_0041: ret

  .method UnitAudio::Revive()  // token 0x0600022A rva 0x9cb2 attrs Private, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.0
    IL_0002: stfld bool UnitAudio::dead  /*0x040002C6*/
    IL_0007: ret

  .method UnitAudio::.ctor()  // token 0x0600022B rva 0x9cbc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 145 (0x91), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float UnitAudio::maxSpeed  /*0x040002AB*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float UnitAudio::stepVolume  /*0x040002B2*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 0.1f
    IL_001c: stfld float UnitAudio::stepPitchVariation  /*0x040002B3*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0.5f
    IL_0027: stfld float UnitAudio::attackVolume  /*0x040002B5*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0.3f
    IL_0032: stfld float UnitAudio::attackPitchVariation  /*0x040002B6*/
    IL_0037: ldarg.0
    IL_0038: ldc.r4 0.5f
    IL_003d: stfld float UnitAudio::deathVolume  /*0x040002B8*/
    IL_0042: ldarg.0
    IL_0043: ldc.r4 0.3f
    IL_0048: stfld float UnitAudio::deathPitchVariation  /*0x040002B9*/
    IL_004d: ldarg.0
    IL_004e: ldc.r4 0.5f
    IL_0053: stfld float UnitAudio::dmgVolume  /*0x040002BB*/
    IL_0058: ldarg.0
    IL_0059: ldc.r4 0.3f
    IL_005e: stfld float UnitAudio::dmgPitchVariation  /*0x040002BC*/
    IL_0063: ldarg.0
    IL_0064: ldc.i4.s 80
    IL_0066: stfld int UnitAudio::rollPriority  /*0x040002BD*/
    IL_006b: ldarg.0
    IL_006c: ldc.i4.s 110
    IL_006e: stfld int UnitAudio::stepPriority  /*0x040002BE*/
    IL_0073: ldarg.0
    IL_0074: ldc.i4.s 20
    IL_0076: stfld int UnitAudio::damagePriority  /*0x040002BF*/
    IL_007b: ldarg.0
    IL_007c: ldc.i4.s 10
    IL_007e: stfld int UnitAudio::attackPriority  /*0x040002C0*/
    IL_0083: ldarg.0
    IL_0084: ldc.i4.3
    IL_0085: stfld int UnitAudio::deathPriority  /*0x040002C1*/
    IL_008a: ldarg.0
    IL_008b: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0090: ret

// ===== UnitAudio/LocomotionMode  (token 0x02000063) =====
// ===== UnitAudio/OneshotType  (token 0x02000064) =====
// ===== UnitAudio/StepType  (token 0x02000065) =====
// ===== UnitAudio/DmgType  (token 0x02000066) =====
// ===== UnitAudio/DeathType  (token 0x02000067) =====
// ===== UnitAudio/AttackType  (token 0x02000068) =====
