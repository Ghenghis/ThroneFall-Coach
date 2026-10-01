// ===== KeyframedBoss  (token 0x0200001C) =====
  .method KeyframedBoss::Start()  // token 0x060000A0 rva 0x4b40 attrs Private, HideBySig
    // code size 104 (0x68), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0006: stfld ThronefallAudioManager KeyframedBoss::audioManager  /*0x040000C5*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld ThronefallAudioManager KeyframedBoss::audioManager  /*0x040000C5*/
    IL_0012: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0017: stfld AudioSet KeyframedBoss::audioSet  /*0x040000C6*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld float KeyframedBoss::waveToSpawnInterval  /*0x040000BE*/
    IL_0023: stfld float KeyframedBoss::waveToSpawnIntervalCurrent  /*0x040000C0*/
    IL_0028: ldarg.0
    IL_0029: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002e: ldarg.0
    IL_002f: ldfld Transform KeyframedBoss::stratKeyframe  /*0x040000B1*/
    IL_0034: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0039: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_003e: ldarg.0
    IL_003f: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0044: ldarg.0
    IL_0045: ldfld Transform KeyframedBoss::stratKeyframe  /*0x040000B1*/
    IL_004a: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_004f: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_0054: ldarg.0
    IL_0055: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_005a: ldarg.0
    IL_005b: ldarg.0
    IL_005c: call IEnumerator KeyframedBoss::StartAnimation()  /*0x060000A1*/
    IL_0061: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0066: pop
    IL_0067: ret

  .method KeyframedBoss::StartAnimation()  // token 0x060000A1 rva 0x4bb4 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void KeyframedBoss.<StartAnimation>d__26::.ctor(int)  /*0x060000A6*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld KeyframedBoss KeyframedBoss.<StartAnimation>d__26::<>4__this  /*0x040000CA*/
    IL_000d: ret

  .method KeyframedBoss::Update()  // token 0x060000A2 rva 0x4bc4 attrs Private, HideBySig
    // code size 533 (0x215), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_0006: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_0011: ldlen
    IL_0012: conv.i4
    IL_0013: ldarg.0
    IL_0014: ldfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_0019: ldc.i4.1
    IL_001a: add
    IL_001b: sub
    IL_001c: conv.r4
    IL_001d: ldarg.0
    IL_001e: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_0023: ldlen
    IL_0024: conv.i4
    IL_0025: conv.r4
    IL_0026: div
    IL_0027: bgt.un.s IL_009d
    IL_0029: ldarg.0
    IL_002a: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_002f: ldarg.0
    IL_0030: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_0035: ldlen
    IL_0036: conv.i4
    IL_0037: ldarg.0
    IL_0038: ldfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_003d: ldc.i4.1
    IL_003e: add
    IL_003f: sub
    IL_0040: conv.r4
    IL_0041: ldarg.0
    IL_0042: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_0047: ldlen
    IL_0048: conv.i4
    IL_0049: conv.r4
    IL_004a: div
    IL_004b: callvirt void Hp::set_HpPercentage(float)  /*0x06000814*/
    IL_0050: ldarg.0
    IL_0051: ldarg.0
    IL_0052: ldfld float KeyframedBoss::waveToSpawnInterval  /*0x040000BE*/
    IL_0057: stfld float KeyframedBoss::waveToSpawnIntervalCurrent  /*0x040000C0*/
    IL_005c: ldarg.0
    IL_005d: ldarg.0
    IL_005e: ldfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_0063: ldc.i4.1
    IL_0064: add
    IL_0065: stfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_006a: ldarg.0
    IL_006b: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0070: ldarg.0
    IL_0071: ldarg.0
    IL_0072: ldarg.0
    IL_0073: ldfld Transform[] KeyframedBoss::transitionalKeyframes  /*0x040000B5*/
    IL_0078: ldarg.0
    IL_0079: ldfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_007e: ldelem.ref
    IL_007f: ldarg.0
    IL_0080: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_0085: ldarg.0
    IL_0086: ldfld int KeyframedBoss::bossStage  /*0x040000B9*/
    IL_008b: ldelem.ref
    IL_008c: ldarg.0
    IL_008d: ldfld float KeyframedBoss::animationDuration  /*0x040000B6*/
    IL_0092: call IEnumerator KeyframedBoss::TransitionOverTo(UnityEngine.Transform,UnityEngine.Transform,float)  /*0x060000A3*/
    IL_0097: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_009c: pop
    IL_009d: ldarg.0
    IL_009e: ldarg.0
    IL_009f: ldfld float KeyframedBoss::cooldownToEnemySpawn  /*0x040000C1*/
    IL_00a4: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00a9: sub
    IL_00aa: stfld float KeyframedBoss::cooldownToEnemySpawn  /*0x040000C1*/
    IL_00af: ldarg.0
    IL_00b0: ldfld float KeyframedBoss::cooldownToEnemySpawn  /*0x040000C1*/
    IL_00b5: ldc.r4 0f
    IL_00ba: bgt.un.s IL_00fe
    IL_00bc: ldarg.0
    IL_00bd: ldfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_00c2: brtrue.s IL_00fe
    IL_00c4: ldarg.0
    IL_00c5: ldfld bool KeyframedBoss::waveRunning  /*0x040000C2*/
    IL_00ca: brtrue.s IL_00fe
    IL_00cc: ldarg.0
    IL_00cd: ldarg.0
    IL_00ce: ldfld float KeyframedBoss::waveToSpawnIntervalCurrent  /*0x040000C0*/
    IL_00d3: stfld float KeyframedBoss::cooldownToEnemySpawn  /*0x040000C1*/
    IL_00d8: ldarg.0
    IL_00d9: ldarg.0
    IL_00da: ldfld float KeyframedBoss::waveToSpawnIntervalCurrent  /*0x040000C0*/
    IL_00df: ldarg.0
    IL_00e0: ldfld float KeyframedBoss::waveToSpawnIntervalIncrease  /*0x040000BF*/
    IL_00e5: add
    IL_00e6: stfld float KeyframedBoss::waveToSpawnIntervalCurrent  /*0x040000C0*/
    IL_00eb: ldarg.0
    IL_00ec: ldfld Wave KeyframedBoss::waveToSpawn  /*0x040000BD*/
    IL_00f1: ldc.i4.1
    IL_00f2: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_00f7: ldarg.0
    IL_00f8: ldc.i4.1
    IL_00f9: stfld bool KeyframedBoss::waveRunning  /*0x040000C2*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld bool KeyframedBoss::waveRunning  /*0x040000C2*/
    IL_0104: brfalse.s IL_0140
    IL_0106: ldarg.0
    IL_0107: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_010c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0111: ldarg.0
    IL_0112: ldfld float KeyframedBoss::takeDamageDuringEnemySpawn  /*0x040000C7*/
    IL_0117: mul
    IL_0118: ldnull
    IL_0119: ldc.i4.0
    IL_011a: ldc.i4.0
    IL_011b: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0120: pop
    IL_0121: ldarg.0
    IL_0122: ldfld Wave KeyframedBoss::waveToSpawn  /*0x040000BD*/
    IL_0127: callvirt void Wave::Update()  /*0x0600069D*/
    IL_012c: ldarg.0
    IL_012d: ldfld Wave KeyframedBoss::waveToSpawn  /*0x040000BD*/
    IL_0132: callvirt bool Wave::HasFinished()  /*0x0600069E*/
    IL_0137: brfalse.s IL_0140
    IL_0139: ldarg.0
    IL_013a: ldc.i4.0
    IL_013b: stfld bool KeyframedBoss::waveRunning  /*0x040000C2*/
    IL_0140: ldarg.0
    IL_0141: ldfld bool KeyframedBoss::waveRunning  /*0x040000C2*/
    IL_0146: brtrue.s IL_0164
    IL_0148: ldarg.0
    IL_0149: ldfld float KeyframedBoss::cooldownToEnemySpawn  /*0x040000C1*/
    IL_014e: ldarg.0
    IL_014f: ldfld float KeyframedBoss::spawnWarningTime  /*0x040000BC*/
    IL_0154: bgt.un IL_01f3
    IL_0159: ldarg.0
    IL_015a: ldfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_015f: brtrue IL_01f3
    IL_0164: ldarg.0
    IL_0165: ldfld WigglerAnimationState KeyframedBoss::wigglerAnimationState  /*0x040000BB*/
    IL_016a: ldfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_016f: ldc.i4.1
    IL_0170: beq.s IL_01e6
    IL_0172: ldarg.0
    IL_0173: ldfld AudioSource KeyframedBoss::audioSourceSpawnsAndScream  /*0x040000C4*/
    IL_0178: ldarg.0
    IL_0179: ldfld AudioSet KeyframedBoss::audioSet  /*0x040000C6*/
    IL_017e: callvirt AudioSet.ClipArray AudioSet::get_EismolochSpawnUnits()  /*0x060001B8*/
    IL_0183: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_0188: ldc.i4.0
    IL_0189: ldarg.0
    IL_018a: ldfld AudioSet KeyframedBoss::audioSet  /*0x040000C6*/
    IL_018f: callvirt AudioSet.ClipArray AudioSet::get_EismolochSpawnUnits()  /*0x060001B8*/
    IL_0194: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_0199: ldlen
    IL_019a: conv.i4
    IL_019b: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_01a0: ldelem.ref
    IL_01a1: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_01a6: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_01ab: ldc.r4 0.33f
    IL_01b0: bgt.un.s IL_01e6
    IL_01b2: ldarg.0
    IL_01b3: ldfld AudioSource KeyframedBoss::audioSourceSpawnsAndScream  /*0x040000C4*/
    IL_01b8: ldarg.0
    IL_01b9: ldfld AudioSet KeyframedBoss::audioSet  /*0x040000C6*/
    IL_01be: callvirt AudioSet.ClipArray AudioSet::get_EismolochScream()  /*0x060001B9*/
    IL_01c3: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_01c8: ldc.i4.0
    IL_01c9: ldarg.0
    IL_01ca: ldfld AudioSet KeyframedBoss::audioSet  /*0x040000C6*/
    IL_01cf: callvirt AudioSet.ClipArray AudioSet::get_EismolochScream()  /*0x060001B9*/
    IL_01d4: ldfld AudioClip[] AudioSet.ClipArray::clips  /*0x04000242*/
    IL_01d9: ldlen
    IL_01da: conv.i4
    IL_01db: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_01e0: ldelem.ref
    IL_01e1: callvirt void UnityEngine.AudioSource::PlayOneShot(UnityEngine.AudioClip)  /*0x0A000090*/
    IL_01e6: ldarg.0
    IL_01e7: ldfld WigglerAnimationState KeyframedBoss::wigglerAnimationState  /*0x040000BB*/
    IL_01ec: ldc.i4.1
    IL_01ed: stfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_01f2: ret
    IL_01f3: ldarg.0
    IL_01f4: ldfld bool KeyframedBoss::cutSceneAnimation  /*0x040000C3*/
    IL_01f9: brfalse.s IL_0208
    IL_01fb: ldarg.0
    IL_01fc: ldfld WigglerAnimationState KeyframedBoss::wigglerAnimationState  /*0x040000BB*/
    IL_0201: ldc.i4.1
    IL_0202: stfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_0207: ret
    IL_0208: ldarg.0
    IL_0209: ldfld WigglerAnimationState KeyframedBoss::wigglerAnimationState  /*0x040000BB*/
    IL_020e: ldc.i4.0
    IL_020f: stfld int WigglerAnimationState::animationState  /*0x04000136*/
    IL_0214: ret

  .method KeyframedBoss::TransitionOverTo(UnityEngine.Transform,UnityEngine.Transform,float)  // token 0x060000A3 rva 0x4de5 attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void KeyframedBoss.<TransitionOverTo>d__28::.ctor(int)  /*0x060000AC*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld KeyframedBoss KeyframedBoss.<TransitionOverTo>d__28::<>4__this  /*0x040000CD*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform KeyframedBoss.<TransitionOverTo>d__28::_transitionOver  /*0x040000CE*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld Transform KeyframedBoss.<TransitionOverTo>d__28::_transitionTo  /*0x040000D0*/
    IL_001b: dup
    IL_001c: ldarg.3
    IL_001d: stfld float KeyframedBoss.<TransitionOverTo>d__28::_animationDuration  /*0x040000CF*/
    IL_0022: ret

  .method KeyframedBoss::TransitionTo(UnityEngine.Transform,float)  // token 0x060000A4 rva 0x4e09 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void KeyframedBoss.<TransitionTo>d__29::.ctor(int)  /*0x060000B2*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld KeyframedBoss KeyframedBoss.<TransitionTo>d__29::<>4__this  /*0x040000D3*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld Transform KeyframedBoss.<TransitionTo>d__29::_transitionTo  /*0x040000D5*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float KeyframedBoss.<TransitionTo>d__29::_animationDuration  /*0x040000D4*/
    IL_001b: ret

  .method KeyframedBoss::.ctor()  // token 0x060000A5 rva 0x4e26 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 4f
    IL_0006: stfld float KeyframedBoss::cutsceneHoldPosition  /*0x040000B3*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: stfld float KeyframedBoss::spawnWarningTime  /*0x040000BC*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 2f
    IL_001c: stfld float KeyframedBoss::waveToSpawnIntervalIncrease  /*0x040000BF*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 100f
    IL_0027: stfld float KeyframedBoss::takeDamageDuringEnemySpawn  /*0x040000C7*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

// ===== KeyframedBoss/<StartAnimation>d__26  (token 0x0200001D) =====
  .method KeyframedBoss.<StartAnimation>d__26::.ctor(int)  // token 0x060000A6 rva 0x4e5a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_000d: ret

  .method KeyframedBoss.<StartAnimation>d__26::System.IDisposable.Dispose()  // token 0x060000A7 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method KeyframedBoss.<StartAnimation>d__26::MoveNext()  // token 0x060000A8 rva 0x4e6c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 282 (0x11a), max stack 5, init locals
    .locals ([0] int, [1] KeyframedBoss)
    IL_0000: ldarg.0
    IL_0001: ldfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld KeyframedBoss KeyframedBoss.<StartAnimation>d__26::<>4__this  /*0x040000CA*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_0061, IL_00a8, IL_00df)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_002d: ldloc.1
    IL_002e: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_0033: ldc.i4.1
    IL_0034: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0039: ldloc.1
    IL_003a: ldc.i4.1
    IL_003b: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_0040: ldarg.0
    IL_0041: ldloc.1
    IL_0042: ldloc.1
    IL_0043: ldfld Transform KeyframedBoss::cutsceneKeyframe  /*0x040000B2*/
    IL_0048: ldloc.1
    IL_0049: ldfld float KeyframedBoss::cutsceneAnimationDuration  /*0x040000B7*/
    IL_004e: call IEnumerator KeyframedBoss::TransitionTo(UnityEngine.Transform,float)  /*0x060000A4*/
    IL_0053: stfld object KeyframedBoss.<StartAnimation>d__26::<>2__current  /*0x040000C9*/
    IL_0058: ldarg.0
    IL_0059: ldc.i4.1
    IL_005a: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_005f: ldc.i4.1
    IL_0060: ret
    IL_0061: ldarg.0
    IL_0062: ldc.i4.m1
    IL_0063: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_0068: ldloc.1
    IL_0069: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_006e: ldc.i4.1
    IL_006f: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0074: ldloc.1
    IL_0075: ldc.i4.1
    IL_0076: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_007b: ldloc.1
    IL_007c: ldc.i4.1
    IL_007d: stfld bool KeyframedBoss::cutSceneAnimation  /*0x040000C3*/
    IL_0082: ldloc.1
    IL_0083: ldfld DestroyOrDisableOnEnable KeyframedBoss::disablerComponent  /*0x040000B8*/
    IL_0088: ldc.i4.1
    IL_0089: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_008e: ldarg.0
    IL_008f: ldloc.1
    IL_0090: ldfld float KeyframedBoss::cutsceneHoldPosition  /*0x040000B3*/
    IL_0095: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_009a: stfld object KeyframedBoss.<StartAnimation>d__26::<>2__current  /*0x040000C9*/
    IL_009f: ldarg.0
    IL_00a0: ldc.i4.2
    IL_00a1: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_00a6: ldc.i4.1
    IL_00a7: ret
    IL_00a8: ldarg.0
    IL_00a9: ldc.i4.m1
    IL_00aa: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_00af: ldloc.1
    IL_00b0: ldc.i4.0
    IL_00b1: stfld bool KeyframedBoss::cutSceneAnimation  /*0x040000C3*/
    IL_00b6: ldarg.0
    IL_00b7: ldloc.1
    IL_00b8: ldloc.1
    IL_00b9: ldfld Transform[] KeyframedBoss::mainKeyframes  /*0x040000B4*/
    IL_00be: ldc.i4.0
    IL_00bf: ldelem.ref
    IL_00c0: ldloc.1
    IL_00c1: ldfld float KeyframedBoss::animationDuration  /*0x040000B6*/
    IL_00c6: ldc.r4 2f
    IL_00cb: div
    IL_00cc: call IEnumerator KeyframedBoss::TransitionTo(UnityEngine.Transform,float)  /*0x060000A4*/
    IL_00d1: stfld object KeyframedBoss.<StartAnimation>d__26::<>2__current  /*0x040000C9*/
    IL_00d6: ldarg.0
    IL_00d7: ldc.i4.3
    IL_00d8: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_00dd: ldc.i4.1
    IL_00de: ret
    IL_00df: ldarg.0
    IL_00e0: ldc.i4.m1
    IL_00e1: stfld int KeyframedBoss.<StartAnimation>d__26::<>1__state  /*0x040000C8*/
    IL_00e6: ldloc.1
    IL_00e7: ldc.i4.0
    IL_00e8: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_00ed: ldloc.1
    IL_00ee: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_00f3: ldc.i4.0
    IL_00f4: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_00f9: ldloc.1
    IL_00fa: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_00ff: ldc.r4 1f
    IL_0104: ldnull
    IL_0105: ldc.i4.0
    IL_0106: ldc.i4.1
    IL_0107: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_010c: pop
    IL_010d: ldloc.1
    IL_010e: ldfld HealthbarMulti KeyframedBoss::hpBarMulti  /*0x040000AF*/
    IL_0113: callvirt void Healthbar::UpdateDisplay()  /*0x06000804*/
    IL_0118: ldc.i4.0
    IL_0119: ret

  .method KeyframedBoss.<StartAnimation>d__26::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000A9 rva 0x4f92 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<StartAnimation>d__26::<>2__current  /*0x040000C9*/
    IL_0006: ret

  .method KeyframedBoss.<StartAnimation>d__26::System.Collections.IEnumerator.Reset()  // token 0x060000AA rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method KeyframedBoss.<StartAnimation>d__26::System.Collections.IEnumerator.get_Current()  // token 0x060000AB rva 0x4f92 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<StartAnimation>d__26::<>2__current  /*0x040000C9*/
    IL_0006: ret

// ===== KeyframedBoss/<TransitionOverTo>d__28  (token 0x0200001E) =====
  .method KeyframedBoss.<TransitionOverTo>d__28::.ctor(int)  // token 0x060000AC rva 0x4f9a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_000d: ret

  .method KeyframedBoss.<TransitionOverTo>d__28::System.IDisposable.Dispose()  // token 0x060000AD rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method KeyframedBoss.<TransitionOverTo>d__28::MoveNext()  // token 0x060000AE rva 0x4fac attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 156 (0x9c), max stack 5, init locals
    .locals ([0] int, [1] KeyframedBoss)
    IL_0000: ldarg.0
    IL_0001: ldfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld KeyframedBoss KeyframedBoss.<TransitionOverTo>d__28::<>4__this  /*0x040000CD*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0057, IL_008c)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_0029: ldloc.1
    IL_002a: ldc.i4.1
    IL_002b: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_0030: ldarg.0
    IL_0031: ldloc.1
    IL_0032: ldarg.0
    IL_0033: ldfld Transform KeyframedBoss.<TransitionOverTo>d__28::_transitionOver  /*0x040000CE*/
    IL_0038: ldarg.0
    IL_0039: ldfld float KeyframedBoss.<TransitionOverTo>d__28::_animationDuration  /*0x040000CF*/
    IL_003e: ldc.r4 2f
    IL_0043: div
    IL_0044: call IEnumerator KeyframedBoss::TransitionTo(UnityEngine.Transform,float)  /*0x060000A4*/
    IL_0049: stfld object KeyframedBoss.<TransitionOverTo>d__28::<>2__current  /*0x040000CC*/
    IL_004e: ldarg.0
    IL_004f: ldc.i4.1
    IL_0050: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_0055: ldc.i4.1
    IL_0056: ret
    IL_0057: ldarg.0
    IL_0058: ldc.i4.m1
    IL_0059: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_005e: ldloc.1
    IL_005f: ldc.i4.1
    IL_0060: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_0065: ldarg.0
    IL_0066: ldloc.1
    IL_0067: ldarg.0
    IL_0068: ldfld Transform KeyframedBoss.<TransitionOverTo>d__28::_transitionTo  /*0x040000D0*/
    IL_006d: ldarg.0
    IL_006e: ldfld float KeyframedBoss.<TransitionOverTo>d__28::_animationDuration  /*0x040000CF*/
    IL_0073: ldc.r4 2f
    IL_0078: div
    IL_0079: call IEnumerator KeyframedBoss::TransitionTo(UnityEngine.Transform,float)  /*0x060000A4*/
    IL_007e: stfld object KeyframedBoss.<TransitionOverTo>d__28::<>2__current  /*0x040000CC*/
    IL_0083: ldarg.0
    IL_0084: ldc.i4.2
    IL_0085: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_008a: ldc.i4.1
    IL_008b: ret
    IL_008c: ldarg.0
    IL_008d: ldc.i4.m1
    IL_008e: stfld int KeyframedBoss.<TransitionOverTo>d__28::<>1__state  /*0x040000CB*/
    IL_0093: ldloc.1
    IL_0094: ldc.i4.0
    IL_0095: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_009a: ldc.i4.0
    IL_009b: ret

  .method KeyframedBoss.<TransitionOverTo>d__28::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000AF rva 0x5054 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<TransitionOverTo>d__28::<>2__current  /*0x040000CC*/
    IL_0006: ret

  .method KeyframedBoss.<TransitionOverTo>d__28::System.Collections.IEnumerator.Reset()  // token 0x060000B0 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method KeyframedBoss.<TransitionOverTo>d__28::System.Collections.IEnumerator.get_Current()  // token 0x060000B1 rva 0x5054 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<TransitionOverTo>d__28::<>2__current  /*0x040000CC*/
    IL_0006: ret

// ===== KeyframedBoss/<TransitionTo>d__29  (token 0x0200001F) =====
  .method KeyframedBoss.<TransitionTo>d__29::.ctor(int)  // token 0x060000B2 rva 0x505c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int KeyframedBoss.<TransitionTo>d__29::<>1__state  /*0x040000D1*/
    IL_000d: ret

  .method KeyframedBoss.<TransitionTo>d__29::System.IDisposable.Dispose()  // token 0x060000B3 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method KeyframedBoss.<TransitionTo>d__29::MoveNext()  // token 0x060000B4 rva 0x506c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 365 (0x16d), max stack 4, init locals
    .locals ([0] int, [1] KeyframedBoss, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int KeyframedBoss.<TransitionTo>d__29::<>1__state  /*0x040000D1*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld KeyframedBoss KeyframedBoss.<TransitionTo>d__29::<>4__this  /*0x040000D3*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00f7
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int KeyframedBoss.<TransitionTo>d__29::<>1__state  /*0x040000D1*/
    IL_0021: ldloc.1
    IL_0022: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_0027: ldc.i4.1
    IL_0028: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_002d: ldloc.1
    IL_002e: ldfld HealthbarMulti KeyframedBoss::hpBarMulti  /*0x040000AF*/
    IL_0033: callvirt void Healthbar::UpdateDisplay()  /*0x06000804*/
    IL_0038: ldloc.1
    IL_0039: ldc.i4.1
    IL_003a: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_003f: ldarg.0
    IL_0040: ldloc.1
    IL_0041: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0046: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_004b: stfld Vector3 KeyframedBoss.<TransitionTo>d__29::<startPosition>5__2  /*0x040000D6*/
    IL_0050: ldarg.0
    IL_0051: ldloc.1
    IL_0052: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0057: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_005c: stfld Quaternion KeyframedBoss.<TransitionTo>d__29::<startRotation>5__3  /*0x040000D7*/
    IL_0061: ldarg.0
    IL_0062: ldc.r4 0f
    IL_0067: stfld float KeyframedBoss.<TransitionTo>d__29::<animProgress>5__4  /*0x040000D8*/
    IL_006c: br IL_0110
    IL_0071: ldarg.0
    IL_0072: ldfld float KeyframedBoss.<TransitionTo>d__29::<animProgress>5__4  /*0x040000D8*/
    IL_0077: ldarg.0
    IL_0078: ldfld float KeyframedBoss.<TransitionTo>d__29::_animationDuration  /*0x040000D4*/
    IL_007d: div
    IL_007e: stloc.2
    IL_007f: ldc.r4 3f
    IL_0084: ldloc.2
    IL_0085: ldc.r4 2f
    IL_008a: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_008f: mul
    IL_0090: ldc.r4 2f
    IL_0095: ldloc.2
    IL_0096: ldc.r4 3f
    IL_009b: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_00a0: mul
    IL_00a1: sub
    IL_00a2: stloc.2
    IL_00a3: ldloc.1
    IL_00a4: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a9: ldarg.0
    IL_00aa: ldfld Vector3 KeyframedBoss.<TransitionTo>d__29::<startPosition>5__2  /*0x040000D6*/
    IL_00af: ldarg.0
    IL_00b0: ldfld Transform KeyframedBoss.<TransitionTo>d__29::_transitionTo  /*0x040000D5*/
    IL_00b5: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_00ba: ldloc.2
    IL_00bb: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_00c0: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00c5: ldloc.1
    IL_00c6: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00cb: ldarg.0
    IL_00cc: ldfld Quaternion KeyframedBoss.<TransitionTo>d__29::<startRotation>5__3  /*0x040000D7*/
    IL_00d1: ldarg.0
    IL_00d2: ldfld Transform KeyframedBoss.<TransitionTo>d__29::_transitionTo  /*0x040000D5*/
    IL_00d7: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_00dc: ldloc.2
    IL_00dd: call Quaternion UnityEngine.Quaternion::Lerp(UnityEngine.Quaternion,UnityEngine.Quaternion,float)  /*0x0A000092*/
    IL_00e2: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_00e7: ldarg.0
    IL_00e8: ldnull
    IL_00e9: stfld object KeyframedBoss.<TransitionTo>d__29::<>2__current  /*0x040000D2*/
    IL_00ee: ldarg.0
    IL_00ef: ldc.i4.1
    IL_00f0: stfld int KeyframedBoss.<TransitionTo>d__29::<>1__state  /*0x040000D1*/
    IL_00f5: ldc.i4.1
    IL_00f6: ret
    IL_00f7: ldarg.0
    IL_00f8: ldc.i4.m1
    IL_00f9: stfld int KeyframedBoss.<TransitionTo>d__29::<>1__state  /*0x040000D1*/
    IL_00fe: ldarg.0
    IL_00ff: ldarg.0
    IL_0100: ldfld float KeyframedBoss.<TransitionTo>d__29::<animProgress>5__4  /*0x040000D8*/
    IL_0105: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_010a: add
    IL_010b: stfld float KeyframedBoss.<TransitionTo>d__29::<animProgress>5__4  /*0x040000D8*/
    IL_0110: ldarg.0
    IL_0111: ldfld float KeyframedBoss.<TransitionTo>d__29::<animProgress>5__4  /*0x040000D8*/
    IL_0116: ldarg.0
    IL_0117: ldfld float KeyframedBoss.<TransitionTo>d__29::_animationDuration  /*0x040000D4*/
    IL_011c: blt IL_0071
    IL_0121: ldloc.1
    IL_0122: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0127: ldarg.0
    IL_0128: ldfld Transform KeyframedBoss.<TransitionTo>d__29::_transitionTo  /*0x040000D5*/
    IL_012d: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0132: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0137: ldloc.1
    IL_0138: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_013d: ldarg.0
    IL_013e: ldfld Transform KeyframedBoss.<TransitionTo>d__29::_transitionTo  /*0x040000D5*/
    IL_0143: callvirt Quaternion UnityEngine.Transform::get_localRotation()  /*0x0A00008D*/
    IL_0148: callvirt void UnityEngine.Transform::set_localRotation(UnityEngine.Quaternion)  /*0x0A00008E*/
    IL_014d: ldloc.1
    IL_014e: ldc.i4.0
    IL_014f: stfld bool KeyframedBoss::coroutineRunning  /*0x040000BA*/
    IL_0154: ldloc.1
    IL_0155: ldfld Hp KeyframedBoss::hp  /*0x040000B0*/
    IL_015a: ldc.i4.0
    IL_015b: stfld bool Hp::invulnerable  /*0x04000A4F*/
    IL_0160: ldloc.1
    IL_0161: ldfld HealthbarMulti KeyframedBoss::hpBarMulti  /*0x040000AF*/
    IL_0166: callvirt void Healthbar::UpdateDisplay()  /*0x06000804*/
    IL_016b: ldc.i4.0
    IL_016c: ret

  .method KeyframedBoss.<TransitionTo>d__29::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000B5 rva 0x51e5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<TransitionTo>d__29::<>2__current  /*0x040000D2*/
    IL_0006: ret

  .method KeyframedBoss.<TransitionTo>d__29::System.Collections.IEnumerator.Reset()  // token 0x060000B6 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method KeyframedBoss.<TransitionTo>d__29::System.Collections.IEnumerator.get_Current()  // token 0x060000B7 rva 0x51e5 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object KeyframedBoss.<TransitionTo>d__29::<>2__current  /*0x040000D2*/
    IL_0006: ret

