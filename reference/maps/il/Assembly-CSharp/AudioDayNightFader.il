// ===== AudioDayNightFader  (token 0x0200004E) =====
  .method AudioDayNightFader::Start()  // token 0x0600016F rva 0x78d0 attrs Private, HideBySig
    // code size 147 (0x93), max stack 4, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0011: ldstr "DayEnvVolume"
    IL_0016: ldarg.0
    IL_0017: ldflda float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_001c: callvirt bool UnityEngine.Audio.AudioMixer::GetFloat(string,ref float)  /*0x0A0000BD*/
    IL_0021: pop
    IL_0022: ldarg.0
    IL_0023: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0028: ldstr "NightEnvVolume"
    IL_002d: ldarg.0
    IL_002e: ldflda float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_0033: callvirt bool UnityEngine.Audio.AudioMixer::GetFloat(string,ref float)  /*0x0A0000BD*/
    IL_0038: pop
    IL_0039: ldarg.0
    IL_003a: ldc.r4 10f
    IL_003f: ldarg.0
    IL_0040: ldfld float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_0045: ldc.r4 20f
    IL_004a: div
    IL_004b: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_0050: stfld float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_0055: ldarg.0
    IL_0056: ldc.r4 10f
    IL_005b: ldarg.0
    IL_005c: ldfld float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_0061: ldc.r4 20f
    IL_0066: div
    IL_0067: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_006c: stfld float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_0071: ldarg.0
    IL_0072: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0077: ldstr "NightEnvVolume"
    IL_007c: ldc.r4 0.0001f
    IL_0081: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_0086: ldc.r4 20f
    IL_008b: mul
    IL_008c: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0091: pop
    IL_0092: ret

  .method AudioDayNightFader::OnDawn_AfterSunrise()  // token 0x06000170 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AudioDayNightFader::OnDawn_BeforeSunrise()  // token 0x06000171 rva 0x796f attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator AudioDayNightFader::FadeToDay()  /*0x06000174*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method AudioDayNightFader::OnDusk()  // token 0x06000172 rva 0x7984 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator AudioDayNightFader::FadeToNight()  /*0x06000173*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method AudioDayNightFader::FadeToNight()  // token 0x06000173 rva 0x7999 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AudioDayNightFader.<FadeToNight>d__15::.ctor(int)  /*0x0600017D*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AudioDayNightFader AudioDayNightFader.<FadeToNight>d__15::<>4__this  /*0x040001D8*/
    IL_000d: ret

  .method AudioDayNightFader::FadeToDay()  // token 0x06000174 rva 0x79a8 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AudioDayNightFader.<FadeToDay>d__16::.ctor(int)  /*0x06000177*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AudioDayNightFader AudioDayNightFader.<FadeToDay>d__16::<>4__this  /*0x040001D5*/
    IL_000d: ret

  .method AudioDayNightFader::OnDuskEarly()  // token 0x06000175 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AudioDayNightFader::.ctor()  // token 0x06000176 rva 0x79b7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float AudioDayNightFader::fadeTime  /*0x040001C8*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float AudioDayNightFader::nightMusicFadeInTime  /*0x040001CC*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 4f
    IL_001c: stfld float AudioDayNightFader::nightMusicFadeOutTime  /*0x040001CD*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

// ===== AudioDayNightFader/<FadeToDay>d__16  (token 0x0200004F) =====
  .method AudioDayNightFader.<FadeToDay>d__16::.ctor(int)  // token 0x06000177 rva 0x79e0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AudioDayNightFader.<FadeToDay>d__16::<>1__state  /*0x040001D3*/
    IL_000d: ret

  .method AudioDayNightFader.<FadeToDay>d__16::System.IDisposable.Dispose()  // token 0x06000178 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AudioDayNightFader.<FadeToDay>d__16::MoveNext()  // token 0x06000179 rva 0x79f0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 299 (0x12b), max stack 5, init locals
    .locals ([0] int, [1] AudioDayNightFader)
    IL_0000: ldarg.0
    IL_0001: ldfld int AudioDayNightFader.<FadeToDay>d__16::<>1__state  /*0x040001D3*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AudioDayNightFader AudioDayNightFader.<FadeToDay>d__16::<>4__this  /*0x040001D5*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00c4
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int AudioDayNightFader.<FadeToDay>d__16::<>1__state  /*0x040001D3*/
    IL_0021: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_0026: ldnull
    IL_0027: ldloc.1
    IL_0028: ldfld float AudioDayNightFader::nightMusicFadeOutTime  /*0x040001CD*/
    IL_002d: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_0032: br IL_00cb
    IL_0037: ldloc.1
    IL_0038: ldloc.1
    IL_0039: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_003e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0043: ldloc.1
    IL_0044: ldfld float AudioDayNightFader::fadeTime  /*0x040001C8*/
    IL_0049: div
    IL_004a: sub
    IL_004b: stfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_0050: ldloc.1
    IL_0051: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0056: ldstr "DayEnvVolume"
    IL_005b: ldloc.1
    IL_005c: ldfld float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_0061: ldc.r4 0.0001f
    IL_0066: ldloc.1
    IL_0067: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_006c: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0071: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_0076: ldc.r4 20f
    IL_007b: mul
    IL_007c: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0081: pop
    IL_0082: ldloc.1
    IL_0083: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0088: ldstr "NightEnvVolume"
    IL_008d: ldc.r4 0.0001f
    IL_0092: ldloc.1
    IL_0093: ldfld float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_0098: ldloc.1
    IL_0099: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_009e: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_00a3: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_00a8: ldc.r4 20f
    IL_00ad: mul
    IL_00ae: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_00b3: pop
    IL_00b4: ldarg.0
    IL_00b5: ldnull
    IL_00b6: stfld object AudioDayNightFader.<FadeToDay>d__16::<>2__current  /*0x040001D4*/
    IL_00bb: ldarg.0
    IL_00bc: ldc.i4.1
    IL_00bd: stfld int AudioDayNightFader.<FadeToDay>d__16::<>1__state  /*0x040001D3*/
    IL_00c2: ldc.i4.1
    IL_00c3: ret
    IL_00c4: ldarg.0
    IL_00c5: ldc.i4.m1
    IL_00c6: stfld int AudioDayNightFader.<FadeToDay>d__16::<>1__state  /*0x040001D3*/
    IL_00cb: ldloc.1
    IL_00cc: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_00d1: ldc.r4 0f
    IL_00d6: bgt IL_0037
    IL_00db: ldloc.1
    IL_00dc: ldc.r4 0f
    IL_00e1: stfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_00e6: ldloc.1
    IL_00e7: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_00ec: ldstr "DayEnvVolume"
    IL_00f1: ldloc.1
    IL_00f2: ldfld float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_00f7: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_00fc: ldc.r4 20f
    IL_0101: mul
    IL_0102: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0107: pop
    IL_0108: ldloc.1
    IL_0109: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_010e: ldstr "NightEnvVolume"
    IL_0113: ldc.r4 0.0001f
    IL_0118: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_011d: ldc.r4 20f
    IL_0122: mul
    IL_0123: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0128: pop
    IL_0129: ldc.i4.0
    IL_012a: ret

  .method AudioDayNightFader.<FadeToDay>d__16::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600017A rva 0x7b27 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AudioDayNightFader.<FadeToDay>d__16::<>2__current  /*0x040001D4*/
    IL_0006: ret

  .method AudioDayNightFader.<FadeToDay>d__16::System.Collections.IEnumerator.Reset()  // token 0x0600017B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AudioDayNightFader.<FadeToDay>d__16::System.Collections.IEnumerator.get_Current()  // token 0x0600017C rva 0x7b27 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AudioDayNightFader.<FadeToDay>d__16::<>2__current  /*0x040001D4*/
    IL_0006: ret

// ===== AudioDayNightFader/<FadeToNight>d__15  (token 0x02000050) =====
  .method AudioDayNightFader.<FadeToNight>d__15::.ctor(int)  // token 0x0600017D rva 0x7b2f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_000d: ret

  .method AudioDayNightFader.<FadeToNight>d__15::System.IDisposable.Dispose()  // token 0x0600017E rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AudioDayNightFader.<FadeToNight>d__15::MoveNext()  // token 0x0600017F rva 0x7b40 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 449 (0x1c1), max stack 5, init locals
    .locals ([0] int, [1] AudioDayNightFader)
    IL_0000: ldarg.0
    IL_0001: ldfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AudioDayNightFader AudioDayNightFader.<FadeToNight>d__15::<>4__this  /*0x040001D8*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0067, IL_015a)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_0029: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002e: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_0033: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_0038: ldfld List<Wave> EnemySpawner::waves  /*0x040007C9*/
    IL_003d: callvirt int System.Collections.Generic.List<Wave>::get_Count()  /*0x0A0000C0*/
    IL_0042: ldc.i4.1
    IL_0043: sub
    IL_0044: blt.s IL_00b2
    IL_0046: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_004b: brtrue.s IL_006e
    IL_004d: ldarg.0
    IL_004e: ldloc.1
    IL_004f: ldfld float AudioDayNightFader::transitionDelayInLastNight  /*0x040001CE*/
    IL_0054: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0059: stfld object AudioDayNightFader.<FadeToNight>d__15::<>2__current  /*0x040001D7*/
    IL_005e: ldarg.0
    IL_005f: ldc.i4.1
    IL_0060: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_0065: ldc.i4.1
    IL_0066: ret
    IL_0067: ldarg.0
    IL_0068: ldc.i4.m1
    IL_0069: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_006e: ldloc.1
    IL_006f: ldfld bool AudioDayNightFader::quickMusicFadeInLastNight  /*0x040001CF*/
    IL_0074: brfalse.s IL_0097
    IL_0076: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_007b: brtrue.s IL_0097
    IL_007d: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_0082: ldloc.1
    IL_0083: ldfld AudioClip AudioDayNightFader::finalNightMusic  /*0x040001CB*/
    IL_0088: ldc.r4 0.25f
    IL_008d: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_0092: br IL_0161
    IL_0097: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_009c: ldloc.1
    IL_009d: ldfld AudioClip AudioDayNightFader::finalNightMusic  /*0x040001CB*/
    IL_00a2: ldloc.1
    IL_00a3: ldfld float AudioDayNightFader::nightMusicFadeInTime  /*0x040001CC*/
    IL_00a8: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_00ad: br IL_0161
    IL_00b2: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_00b7: ldloc.1
    IL_00b8: ldfld AudioClip AudioDayNightFader::nightMusic  /*0x040001CA*/
    IL_00bd: ldloc.1
    IL_00be: ldfld float AudioDayNightFader::nightMusicFadeInTime  /*0x040001CC*/
    IL_00c3: callvirt void MusicManager::PlayMusic(UnityEngine.AudioClip,float)  /*0x0600095A*/
    IL_00c8: br IL_0161
    IL_00cd: ldloc.1
    IL_00ce: ldloc.1
    IL_00cf: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_00d4: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00d9: ldloc.1
    IL_00da: ldfld float AudioDayNightFader::fadeTime  /*0x040001C8*/
    IL_00df: div
    IL_00e0: add
    IL_00e1: stfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_00e6: ldloc.1
    IL_00e7: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_00ec: ldstr "DayEnvVolume"
    IL_00f1: ldloc.1
    IL_00f2: ldfld float AudioDayNightFader::dayTargetVol  /*0x040001D1*/
    IL_00f7: ldc.r4 0.0001f
    IL_00fc: ldloc.1
    IL_00fd: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_0102: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0107: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_010c: ldc.r4 20f
    IL_0111: mul
    IL_0112: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0117: pop
    IL_0118: ldloc.1
    IL_0119: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_011e: ldstr "NightEnvVolume"
    IL_0123: ldc.r4 0.0001f
    IL_0128: ldloc.1
    IL_0129: ldfld float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_012e: ldloc.1
    IL_012f: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_0134: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0139: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_013e: ldc.r4 20f
    IL_0143: mul
    IL_0144: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_0149: pop
    IL_014a: ldarg.0
    IL_014b: ldnull
    IL_014c: stfld object AudioDayNightFader.<FadeToNight>d__15::<>2__current  /*0x040001D7*/
    IL_0151: ldarg.0
    IL_0152: ldc.i4.2
    IL_0153: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_0158: ldc.i4.1
    IL_0159: ret
    IL_015a: ldarg.0
    IL_015b: ldc.i4.m1
    IL_015c: stfld int AudioDayNightFader.<FadeToNight>d__15::<>1__state  /*0x040001D6*/
    IL_0161: ldloc.1
    IL_0162: ldfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_0167: ldc.r4 1f
    IL_016c: blt IL_00cd
    IL_0171: ldloc.1
    IL_0172: ldc.r4 1f
    IL_0177: stfld float AudioDayNightFader::transitionClock  /*0x040001D0*/
    IL_017c: ldloc.1
    IL_017d: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_0182: ldstr "DayEnvVolume"
    IL_0187: ldc.r4 0.0001f
    IL_018c: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_0191: ldc.r4 20f
    IL_0196: mul
    IL_0197: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_019c: pop
    IL_019d: ldloc.1
    IL_019e: ldfld AudioMixer AudioDayNightFader::mixer  /*0x040001C9*/
    IL_01a3: ldstr "NightEnvVolume"
    IL_01a8: ldloc.1
    IL_01a9: ldfld float AudioDayNightFader::nightTargetVol  /*0x040001D2*/
    IL_01ae: call float UnityEngine.Mathf::Log10(float)  /*0x0A0000BE*/
    IL_01b3: ldc.r4 20f
    IL_01b8: mul
    IL_01b9: callvirt bool UnityEngine.Audio.AudioMixer::SetFloat(string,float)  /*0x0A0000BF*/
    IL_01be: pop
    IL_01bf: ldc.i4.0
    IL_01c0: ret

  .method AudioDayNightFader.<FadeToNight>d__15::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000180 rva 0x7d0d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AudioDayNightFader.<FadeToNight>d__15::<>2__current  /*0x040001D7*/
    IL_0006: ret

  .method AudioDayNightFader.<FadeToNight>d__15::System.Collections.IEnumerator.Reset()  // token 0x06000181 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AudioDayNightFader.<FadeToNight>d__15::System.Collections.IEnumerator.get_Current()  // token 0x06000182 rva 0x7d0d attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AudioDayNightFader.<FadeToNight>d__15::<>2__current  /*0x040001D7*/
    IL_0006: ret

