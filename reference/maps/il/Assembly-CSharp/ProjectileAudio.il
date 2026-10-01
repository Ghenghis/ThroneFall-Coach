// ===== ProjectileAudio  (token 0x0200005C) =====
  .method ProjectileAudio::Start()  // token 0x06000209 rva 0x8847 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AimbotProjectile ProjectileAudio::target  /*0x04000271*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002a
    IL_000e: ldarg.0
    IL_000f: ldfld AimbotProjectile ProjectileAudio::target  /*0x04000271*/
    IL_0014: ldfld UnityEvent AimbotProjectile::onHit  /*0x0400008A*/
    IL_0019: ldarg.0
    IL_001a: ldftn void ProjectileAudio::PlayImpact()  /*0x0600020B*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002a: ret

  .method ProjectileAudio::OnEnable()  // token 0x0600020A rva 0x8874 attrs Private, HideBySig
    // code size 80 (0x50), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ProjectileAudio.ProjectileType ProjectileAudio::projectile  /*0x04000273*/
    IL_0006: brtrue.s IL_0027
    IL_0008: ldarg.0
    IL_0009: ldfld AudioSource ProjectileAudio::aSource  /*0x04000272*/
    IL_000e: call ThronefallAudioManager ThronefallAudioManager::get_Instance()  /*0x0600020F*/
    IL_0013: ldfld AudioSet ThronefallAudioManager::audioContent  /*0x0400027E*/
    IL_0018: callvirt AudioSet.ClipArray AudioSet::get_CatapultImpact()  /*0x060001D6*/
    IL_001d: callvirt AudioClip AudioSet.ClipArray::GetRandomClip()  /*0x060001EC*/
    IL_0022: callvirt void UnityEngine.AudioSource::set_clip(UnityEngine.AudioClip)  /*0x0A0000D0*/
    IL_0027: ldarg.0
    IL_0028: ldfld AudioSource ProjectileAudio::aSource  /*0x04000272*/
    IL_002d: ldc.r4 1f
    IL_0032: ldarg.0
    IL_0033: ldfld float ProjectileAudio::pitchrange  /*0x04000274*/
    IL_0038: sub
    IL_0039: ldc.r4 1f
    IL_003e: ldarg.0
    IL_003f: ldfld float ProjectileAudio::pitchrange  /*0x04000274*/
    IL_0044: add
    IL_0045: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_004a: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_004f: ret

  .method ProjectileAudio::PlayImpact()  // token 0x0600020B rva 0x88d0 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AudioSource ProjectileAudio::aSource  /*0x04000272*/
    IL_0006: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_000b: ret

  .method ProjectileAudio::.ctor()  // token 0x0600020C rva 0x88dd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float ProjectileAudio::pitchrange  /*0x04000274*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== ProjectileAudio/ProjectileType  (token 0x0200005D) =====
