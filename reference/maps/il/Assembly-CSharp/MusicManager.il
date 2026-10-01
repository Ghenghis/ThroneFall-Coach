// ===== MusicManager  (token 0x020001D3) =====
  .method MusicManager::get_CurrentVolume()  // token 0x06000957 rva 0x2c87a attrs Private, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float MusicManager::currentVolume  /*0x04000BCC*/
    IL_0006: ret

  .method MusicManager::set_CurrentVolume(float)  // token 0x06000958 rva 0x2c884 attrs Private, HideBySig, SpecialName
    // code size 68 (0x44), max stack 3, init locals
    .locals ([0] float, [1] MusicManager.OverrideVolume)
    IL_0000: ldarg.1
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldarg.1
    IL_0004: stfld float MusicManager::currentVolume  /*0x04000BCC*/
    IL_0009: ldarg.0
    IL_000a: ldfld List<MusicManager.OverrideVolume> MusicManager::overrideVolumes  /*0x04000BCF*/
    IL_000f: ldarg.0
    IL_0010: ldftn bool MusicManager::<set_CurrentVolume>b__11_0(MusicManager.OverrideVolume)  /*0x06000960*/
    IL_0016: newobj void System.Predicate<MusicManager.OverrideVolume>::.ctor(object,IntPtr)  /*0x0A00044A*/
    IL_001b: callvirt !0 System.Collections.Generic.List<MusicManager.OverrideVolume>::Find(System.Predicate<!0>)  /*0x0A00044B*/
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: brfalse.s IL_002d
    IL_0024: ldloc.0
    IL_0025: ldloc.1
    IL_0026: ldfld float MusicManager.OverrideVolume::volume  /*0x04000BD1*/
    IL_002b: mul
    IL_002c: stloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_0033: ldloc.0
    IL_0034: ldc.r4 2f
    IL_0039: call float UnityEngine.Mathf::Pow(float,float)  /*0x0A00006E*/
    IL_003e: callvirt void UnityEngine.AudioSource::set_volume(float)  /*0x0A0000C9*/
    IL_0043: ret

  .method MusicManager::Awake()  // token 0x06000959 rva 0x2c8d4 attrs Private, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    .locals ([0] AudioClip[], [1] int, [2] AudioClip)
    IL_0000: ldsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld MusicManager MusicManager::instance  /*0x04000BC8*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 0f
    IL_0025: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_002a: ldarg.0
    IL_002b: ldfld AudioClip[] MusicManager::resumeableMusicClips  /*0x04000BCD*/
    IL_0030: stloc.0
    IL_0031: ldc.i4.0
    IL_0032: stloc.1
    IL_0033: br.s IL_004e
    IL_0035: ldloc.0
    IL_0036: ldloc.1
    IL_0037: ldelem.ref
    IL_0038: stloc.2
    IL_0039: ldarg.0
    IL_003a: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_003f: ldloc.2
    IL_0040: ldc.r4 0f
    IL_0045: callvirt void System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::Add(!0,!1)  /*0x0A00044C*/
    IL_004a: ldloc.1
    IL_004b: ldc.i4.1
    IL_004c: add
    IL_004d: stloc.1
    IL_004e: ldloc.1
    IL_004f: ldloc.0
    IL_0050: ldlen
    IL_0051: conv.i4
    IL_0052: blt.s IL_0035
    IL_0054: ret

  .method MusicManager::PlayMusic(UnityEngine.AudioClip,float)  // token 0x0600095A rva 0x2c938 attrs Public, HideBySig
    // code size 94 (0x5e), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0006: ldarg.1
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: ldnull
    IL_0011: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0016: brfalse.s IL_0035
    IL_0018: ldarg.0
    IL_0019: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_001e: ldnull
    IL_001f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0024: brfalse.s IL_0035
    IL_0026: ldarg.0
    IL_0027: ldarg.0
    IL_0028: ldarg.2
    IL_0029: call IEnumerator MusicManager::FadeOutAndStop(float)  /*0x0600095C*/
    IL_002e: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0033: pop
    IL_0034: ret
    IL_0035: ldarg.0
    IL_0036: ldfld Coroutine MusicManager::fadeCoroutine  /*0x04000BCB*/
    IL_003b: brfalse.s IL_0049
    IL_003d: ldarg.0
    IL_003e: ldarg.0
    IL_003f: ldfld Coroutine MusicManager::fadeCoroutine  /*0x04000BCB*/
    IL_0044: call void UnityEngine.MonoBehaviour::StopCoroutine(UnityEngine.Coroutine)  /*0x0A000114*/
    IL_0049: ldarg.0
    IL_004a: ldarg.0
    IL_004b: ldarg.0
    IL_004c: ldarg.1
    IL_004d: ldarg.2
    IL_004e: call IEnumerator MusicManager::FadeOutChangeMusicFadeIn(UnityEngine.AudioClip,float)  /*0x0600095B*/
    IL_0053: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0058: stfld Coroutine MusicManager::fadeCoroutine  /*0x04000BCB*/
    IL_005d: ret

  .method MusicManager::FadeOutChangeMusicFadeIn(UnityEngine.AudioClip,float)  // token 0x0600095B rva 0x2c9a2 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MusicManager.<FadeOutChangeMusicFadeIn>d__14::.ctor(int)  /*0x06000974*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MusicManager MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>4__this  /*0x04000BE2*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld AudioClip MusicManager.<FadeOutChangeMusicFadeIn>d__14::newMusic  /*0x04000BE4*/
    IL_0014: dup
    IL_0015: ldarg.2
    IL_0016: stfld float MusicManager.<FadeOutChangeMusicFadeIn>d__14::fadeDuration  /*0x04000BE3*/
    IL_001b: ret

  .method MusicManager::FadeOutAndStop(float)  // token 0x0600095C rva 0x2c9bf attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MusicManager.<FadeOutAndStop>d__15::.ctor(int)  /*0x0600096E*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MusicManager MusicManager.<FadeOutAndStop>d__15::<>4__this  /*0x04000BDE*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float MusicManager.<FadeOutAndStop>d__15::fadeDuration  /*0x04000BDF*/
    IL_0014: ret

  .method MusicManager::FadeOut(float)  // token 0x0600095D rva 0x2c9d5 attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MusicManager.<FadeOut>d__16::.ctor(int)  /*0x06000968*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MusicManager MusicManager.<FadeOut>d__16::<>4__this  /*0x04000BDA*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float MusicManager.<FadeOut>d__16::fadeDuration  /*0x04000BD9*/
    IL_0014: ret

  .method MusicManager::FadeIn(float)  // token 0x0600095E rva 0x2c9eb attrs Private, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MusicManager.<FadeIn>d__17::.ctor(int)  /*0x06000962*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld MusicManager MusicManager.<FadeIn>d__17::<>4__this  /*0x04000BD5*/
    IL_000d: dup
    IL_000e: ldarg.1
    IL_000f: stfld float MusicManager.<FadeIn>d__17::fadeDuration  /*0x04000BD4*/
    IL_0014: ret

  .method MusicManager::.ctor()  // token 0x0600095F rva 0x2ca01 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::.ctor()  /*0x0A00044D*/
    IL_0006: stfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<MusicManager.OverrideVolume>::.ctor()  /*0x0A00044E*/
    IL_0011: stfld List<MusicManager.OverrideVolume> MusicManager::overrideVolumes  /*0x04000BCF*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

  .method MusicManager::<set_CurrentVolume>b__11_0(MusicManager.OverrideVolume)  // token 0x06000960 rva 0x2ca1f attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld AudioClip MusicManager.OverrideVolume::audioClip  /*0x04000BD0*/
    IL_0006: ldarg.0
    IL_0007: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_000c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0011: ret

// ===== MusicManager/OverrideVolume  (token 0x020001D4) =====
  .method MusicManager.OverrideVolume::.ctor(UnityEngine.AudioClip,float)  // token 0x06000961 rva 0x2ca32 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld AudioClip MusicManager.OverrideVolume::audioClip  /*0x04000BD0*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld float MusicManager.OverrideVolume::volume  /*0x04000BD1*/
    IL_0014: ret

// ===== MusicManager/<FadeIn>d__17  (token 0x020001D5) =====
  .method MusicManager.<FadeIn>d__17::.ctor(int)  // token 0x06000962 rva 0x2ca48 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MusicManager.<FadeIn>d__17::<>1__state  /*0x04000BD2*/
    IL_000d: ret

  .method MusicManager.<FadeIn>d__17::System.IDisposable.Dispose()  // token 0x06000963 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MusicManager.<FadeIn>d__17::MoveNext()  // token 0x06000964 rva 0x2ca58 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] int, [1] MusicManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int MusicManager.<FadeIn>d__17::<>1__state  /*0x04000BD2*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MusicManager MusicManager.<FadeIn>d__17::<>4__this  /*0x04000BD5*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0075
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int MusicManager.<FadeIn>d__17::<>1__state  /*0x04000BD2*/
    IL_001e: ldarg.0
    IL_001f: ldfld float MusicManager.<FadeIn>d__17::fadeDuration  /*0x04000BD4*/
    IL_0024: ldc.r4 0f
    IL_0029: bgt.un.s IL_0038
    IL_002b: ldloc.1
    IL_002c: ldc.r4 1f
    IL_0031: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0036: ldc.i4.0
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.r4 1f
    IL_003e: ldarg.0
    IL_003f: ldfld float MusicManager.<FadeIn>d__17::fadeDuration  /*0x04000BD4*/
    IL_0044: div
    IL_0045: stfld float MusicManager.<FadeIn>d__17::<fadeSpeed>5__2  /*0x04000BD6*/
    IL_004a: br.s IL_007c
    IL_004c: ldloc.1
    IL_004d: ldloc.1
    IL_004e: call float MusicManager::get_CurrentVolume()  /*0x06000957*/
    IL_0053: ldarg.0
    IL_0054: ldfld float MusicManager.<FadeIn>d__17::<fadeSpeed>5__2  /*0x04000BD6*/
    IL_0059: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_005e: mul
    IL_005f: add
    IL_0060: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0065: ldarg.0
    IL_0066: ldnull
    IL_0067: stfld object MusicManager.<FadeIn>d__17::<>2__current  /*0x04000BD3*/
    IL_006c: ldarg.0
    IL_006d: ldc.i4.1
    IL_006e: stfld int MusicManager.<FadeIn>d__17::<>1__state  /*0x04000BD2*/
    IL_0073: ldc.i4.1
    IL_0074: ret
    IL_0075: ldarg.0
    IL_0076: ldc.i4.m1
    IL_0077: stfld int MusicManager.<FadeIn>d__17::<>1__state  /*0x04000BD2*/
    IL_007c: ldloc.1
    IL_007d: call float MusicManager::get_CurrentVolume()  /*0x06000957*/
    IL_0082: ldc.r4 1f
    IL_0087: blt.s IL_004c
    IL_0089: ldloc.1
    IL_008a: ldc.r4 1f
    IL_008f: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0094: ldc.i4.0
    IL_0095: ret

  .method MusicManager.<FadeIn>d__17::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000965 rva 0x2cafa attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeIn>d__17::<>2__current  /*0x04000BD3*/
    IL_0006: ret

  .method MusicManager.<FadeIn>d__17::System.Collections.IEnumerator.Reset()  // token 0x06000966 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MusicManager.<FadeIn>d__17::System.Collections.IEnumerator.get_Current()  // token 0x06000967 rva 0x2cafa attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeIn>d__17::<>2__current  /*0x04000BD3*/
    IL_0006: ret

// ===== MusicManager/<FadeOut>d__16  (token 0x020001D6) =====
  .method MusicManager.<FadeOut>d__16::.ctor(int)  // token 0x06000968 rva 0x2cb02 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MusicManager.<FadeOut>d__16::<>1__state  /*0x04000BD7*/
    IL_000d: ret

  .method MusicManager.<FadeOut>d__16::System.IDisposable.Dispose()  // token 0x06000969 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MusicManager.<FadeOut>d__16::MoveNext()  // token 0x0600096A rva 0x2cb14 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] int, [1] MusicManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int MusicManager.<FadeOut>d__16::<>1__state  /*0x04000BD7*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MusicManager MusicManager.<FadeOut>d__16::<>4__this  /*0x04000BDA*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0075
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int MusicManager.<FadeOut>d__16::<>1__state  /*0x04000BD7*/
    IL_001e: ldarg.0
    IL_001f: ldfld float MusicManager.<FadeOut>d__16::fadeDuration  /*0x04000BD9*/
    IL_0024: ldc.r4 0f
    IL_0029: bgt.un.s IL_0038
    IL_002b: ldloc.1
    IL_002c: ldc.r4 0f
    IL_0031: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0036: ldc.i4.0
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.r4 1f
    IL_003e: ldarg.0
    IL_003f: ldfld float MusicManager.<FadeOut>d__16::fadeDuration  /*0x04000BD9*/
    IL_0044: div
    IL_0045: stfld float MusicManager.<FadeOut>d__16::<fadeSpeed>5__2  /*0x04000BDB*/
    IL_004a: br.s IL_007c
    IL_004c: ldloc.1
    IL_004d: ldloc.1
    IL_004e: call float MusicManager::get_CurrentVolume()  /*0x06000957*/
    IL_0053: ldarg.0
    IL_0054: ldfld float MusicManager.<FadeOut>d__16::<fadeSpeed>5__2  /*0x04000BDB*/
    IL_0059: call float UnityEngine.Time::get_unscaledDeltaTime()  /*0x0A000046*/
    IL_005e: mul
    IL_005f: sub
    IL_0060: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0065: ldarg.0
    IL_0066: ldnull
    IL_0067: stfld object MusicManager.<FadeOut>d__16::<>2__current  /*0x04000BD8*/
    IL_006c: ldarg.0
    IL_006d: ldc.i4.1
    IL_006e: stfld int MusicManager.<FadeOut>d__16::<>1__state  /*0x04000BD7*/
    IL_0073: ldc.i4.1
    IL_0074: ret
    IL_0075: ldarg.0
    IL_0076: ldc.i4.m1
    IL_0077: stfld int MusicManager.<FadeOut>d__16::<>1__state  /*0x04000BD7*/
    IL_007c: ldloc.1
    IL_007d: call float MusicManager::get_CurrentVolume()  /*0x06000957*/
    IL_0082: ldc.r4 0f
    IL_0087: bgt.s IL_004c
    IL_0089: ldloc.1
    IL_008a: ldc.r4 0f
    IL_008f: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_0094: ldc.i4.0
    IL_0095: ret

  .method MusicManager.<FadeOut>d__16::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600096B rva 0x2cbb6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOut>d__16::<>2__current  /*0x04000BD8*/
    IL_0006: ret

  .method MusicManager.<FadeOut>d__16::System.Collections.IEnumerator.Reset()  // token 0x0600096C rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MusicManager.<FadeOut>d__16::System.Collections.IEnumerator.get_Current()  // token 0x0600096D rva 0x2cbb6 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOut>d__16::<>2__current  /*0x04000BD8*/
    IL_0006: ret

// ===== MusicManager/<FadeOutAndStop>d__15  (token 0x020001D7) =====
  .method MusicManager.<FadeOutAndStop>d__15::.ctor(int)  // token 0x0600096E rva 0x2cbbe attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MusicManager.<FadeOutAndStop>d__15::<>1__state  /*0x04000BDC*/
    IL_000d: ret

  .method MusicManager.<FadeOutAndStop>d__15::System.IDisposable.Dispose()  // token 0x0600096F rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MusicManager.<FadeOutAndStop>d__15::MoveNext()  // token 0x06000970 rva 0x2cbd0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 151 (0x97), max stack 4, init locals
    .locals ([0] int, [1] MusicManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int MusicManager.<FadeOutAndStop>d__15::<>1__state  /*0x04000BDC*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MusicManager MusicManager.<FadeOutAndStop>d__15::<>4__this  /*0x04000BDE*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_003f
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int MusicManager.<FadeOutAndStop>d__15::<>1__state  /*0x04000BDC*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldloc.1
    IL_0021: ldarg.0
    IL_0022: ldfld float MusicManager.<FadeOutAndStop>d__15::fadeDuration  /*0x04000BDF*/
    IL_0027: call IEnumerator MusicManager::FadeOut(float)  /*0x0600095D*/
    IL_002c: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0031: stfld object MusicManager.<FadeOutAndStop>d__15::<>2__current  /*0x04000BDD*/
    IL_0036: ldarg.0
    IL_0037: ldc.i4.1
    IL_0038: stfld int MusicManager.<FadeOutAndStop>d__15::<>1__state  /*0x04000BDC*/
    IL_003d: ldc.i4.1
    IL_003e: ret
    IL_003f: ldarg.0
    IL_0040: ldc.i4.m1
    IL_0041: stfld int MusicManager.<FadeOutAndStop>d__15::<>1__state  /*0x04000BDC*/
    IL_0046: ldloc.1
    IL_0047: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_004c: ldnull
    IL_004d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0052: brfalse.s IL_0083
    IL_0054: ldloc.1
    IL_0055: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_005a: ldloc.1
    IL_005b: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0060: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::ContainsKey(!0)  /*0x0A00044F*/
    IL_0065: brfalse.s IL_0083
    IL_0067: ldloc.1
    IL_0068: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_006d: ldloc.1
    IL_006e: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0073: ldloc.1
    IL_0074: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_0079: callvirt float UnityEngine.AudioSource::get_time()  /*0x0A000450*/
    IL_007e: callvirt void System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::set_Item(!0,!1)  /*0x0A000451*/
    IL_0083: ldloc.1
    IL_0084: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_0089: callvirt void UnityEngine.AudioSource::Stop()  /*0x0A0000DC*/
    IL_008e: ldloc.1
    IL_008f: ldnull
    IL_0090: stfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0095: ldc.i4.0
    IL_0096: ret

  .method MusicManager.<FadeOutAndStop>d__15::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000971 rva 0x2cc73 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOutAndStop>d__15::<>2__current  /*0x04000BDD*/
    IL_0006: ret

  .method MusicManager.<FadeOutAndStop>d__15::System.Collections.IEnumerator.Reset()  // token 0x06000972 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MusicManager.<FadeOutAndStop>d__15::System.Collections.IEnumerator.get_Current()  // token 0x06000973 rva 0x2cc73 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOutAndStop>d__15::<>2__current  /*0x04000BDD*/
    IL_0006: ret

// ===== MusicManager/<FadeOutChangeMusicFadeIn>d__14  (token 0x020001D8) =====
  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::.ctor(int)  // token 0x06000974 rva 0x2cc7b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_000d: ret

  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::System.IDisposable.Dispose()  // token 0x06000975 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::MoveNext()  // token 0x06000976 rva 0x2cc8c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 327 (0x147), max stack 4, init locals
    .locals ([0] int, [1] MusicManager)
    IL_0000: ldarg.0
    IL_0001: ldfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld MusicManager MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>4__this  /*0x04000BE2*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0026, IL_008b, IL_0116, IL_013e)
    IL_0024: ldc.i4.0
    IL_0025: ret
    IL_0026: ldarg.0
    IL_0027: ldc.i4.m1
    IL_0028: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_002d: ldloc.1
    IL_002e: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0033: ldnull
    IL_0034: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0039: brfalse.s IL_0092
    IL_003b: ldloc.1
    IL_003c: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_0041: ldloc.1
    IL_0042: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_0047: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::ContainsKey(!0)  /*0x0A00044F*/
    IL_004c: brfalse.s IL_006a
    IL_004e: ldloc.1
    IL_004f: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_0054: ldloc.1
    IL_0055: ldfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_005a: ldloc.1
    IL_005b: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_0060: callvirt float UnityEngine.AudioSource::get_time()  /*0x0A000450*/
    IL_0065: callvirt void System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::set_Item(!0,!1)  /*0x0A000451*/
    IL_006a: ldarg.0
    IL_006b: ldloc.1
    IL_006c: ldloc.1
    IL_006d: ldarg.0
    IL_006e: ldfld float MusicManager.<FadeOutChangeMusicFadeIn>d__14::fadeDuration  /*0x04000BE3*/
    IL_0073: call IEnumerator MusicManager::FadeOut(float)  /*0x0600095D*/
    IL_0078: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_007d: stfld object MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>2__current  /*0x04000BE1*/
    IL_0082: ldarg.0
    IL_0083: ldc.i4.1
    IL_0084: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_0089: ldc.i4.1
    IL_008a: ret
    IL_008b: ldarg.0
    IL_008c: ldc.i4.m1
    IL_008d: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_0092: ldloc.1
    IL_0093: ldc.r4 0f
    IL_0098: call void MusicManager::set_CurrentVolume(float)  /*0x06000958*/
    IL_009d: ldloc.1
    IL_009e: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_00a3: ldarg.0
    IL_00a4: ldfld AudioClip MusicManager.<FadeOutChangeMusicFadeIn>d__14::newMusic  /*0x04000BE4*/
    IL_00a9: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_00ae: ldloc.1
    IL_00af: ldarg.0
    IL_00b0: ldfld AudioClip MusicManager.<FadeOutChangeMusicFadeIn>d__14::newMusic  /*0x04000BE4*/
    IL_00b5: stfld AudioClip MusicManager::currentMusic  /*0x04000BCA*/
    IL_00ba: ldloc.1
    IL_00bb: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld AudioClip MusicManager.<FadeOutChangeMusicFadeIn>d__14::newMusic  /*0x04000BE4*/
    IL_00c6: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::ContainsKey(!0)  /*0x0A00044F*/
    IL_00cb: brfalse.s IL_00eb
    IL_00cd: ldloc.1
    IL_00ce: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_00d3: ldloc.1
    IL_00d4: ldfld Dictionary<AudioClip, float> MusicManager::resumeableMusicPlaybackPositions  /*0x04000BCE*/
    IL_00d9: ldarg.0
    IL_00da: ldfld AudioClip MusicManager.<FadeOutChangeMusicFadeIn>d__14::newMusic  /*0x04000BE4*/
    IL_00df: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.AudioClip, float>::get_Item(!0)  /*0x0A000452*/
    IL_00e4: callvirt void UnityEngine.AudioSource::set_time(float)  /*0x0A000453*/
    IL_00e9: br.s IL_00fb
    IL_00eb: ldloc.1
    IL_00ec: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_00f1: ldc.r4 0f
    IL_00f6: callvirt void UnityEngine.AudioSource::set_time(float)  /*0x0A000453*/
    IL_00fb: ldloc.1
    IL_00fc: ldfld AudioSource MusicManager::audioSource  /*0x04000BC9*/
    IL_0101: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_0106: ldarg.0
    IL_0107: ldnull
    IL_0108: stfld object MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>2__current  /*0x04000BE1*/
    IL_010d: ldarg.0
    IL_010e: ldc.i4.2
    IL_010f: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_0114: ldc.i4.1
    IL_0115: ret
    IL_0116: ldarg.0
    IL_0117: ldc.i4.m1
    IL_0118: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_011d: ldarg.0
    IL_011e: ldloc.1
    IL_011f: ldloc.1
    IL_0120: ldarg.0
    IL_0121: ldfld float MusicManager.<FadeOutChangeMusicFadeIn>d__14::fadeDuration  /*0x04000BE3*/
    IL_0126: call IEnumerator MusicManager::FadeIn(float)  /*0x0600095E*/
    IL_012b: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0130: stfld object MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>2__current  /*0x04000BE1*/
    IL_0135: ldarg.0
    IL_0136: ldc.i4.3
    IL_0137: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_013c: ldc.i4.1
    IL_013d: ret
    IL_013e: ldarg.0
    IL_013f: ldc.i4.m1
    IL_0140: stfld int MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>1__state  /*0x04000BE0*/
    IL_0145: ldc.i4.0
    IL_0146: ret

  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000977 rva 0x2cddf attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>2__current  /*0x04000BE1*/
    IL_0006: ret

  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::System.Collections.IEnumerator.Reset()  // token 0x06000978 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MusicManager.<FadeOutChangeMusicFadeIn>d__14::System.Collections.IEnumerator.get_Current()  // token 0x06000979 rva 0x2cddf attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MusicManager.<FadeOutChangeMusicFadeIn>d__14::<>2__current  /*0x04000BE1*/
    IL_0006: ret

