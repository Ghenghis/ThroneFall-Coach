// ===== ProjectileImpactParticles  (token 0x0200024C) =====
  .method ProjectileImpactParticles::Start()  // token 0x06000C99 rva 0x39dab attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld AimbotProjectile ProjectileImpactParticles::target  /*0x04000F42*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002a
    IL_000e: ldarg.0
    IL_000f: ldfld AimbotProjectile ProjectileImpactParticles::target  /*0x04000F42*/
    IL_0014: ldfld UnityEvent AimbotProjectile::onHit  /*0x0400008A*/
    IL_0019: ldarg.0
    IL_001a: ldftn void ProjectileImpactParticles::Play()  /*0x06000C9A*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_002a: ret

  .method ProjectileImpactParticles::Play()  // token 0x06000C9A rva 0x39dd7 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem ProjectileImpactParticles::particles  /*0x04000F43*/
    IL_0006: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_000b: ret

  .method ProjectileImpactParticles::.ctor()  // token 0x06000C9B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

