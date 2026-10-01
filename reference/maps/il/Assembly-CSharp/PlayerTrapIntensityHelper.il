// ===== PlayerTrapIntensityHelper  (token 0x0200017A) =====
  .method PlayerTrapIntensityHelper::Awake()  // token 0x0600079A rva 0x25a54 attrs Private, HideBySig
    // code size 80 (0x50), max stack 4, init locals
    .locals ([0] ParticleSystem.MinMaxCurve, [1] ParticleSystem.MainModule, [2] ParticleSystem.MainModule)
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem PlayerTrapIntensityHelper::targetParticles  /*0x04000982*/
    IL_0006: callvirt ParticleSystem.MainModule UnityEngine.ParticleSystem::get_main()  /*0x0A000370*/
    IL_000b: stloc.2
    IL_000c: ldloca.s 2
    IL_000e: call ParticleSystem.MinMaxCurve UnityEngine.ParticleSystem.MainModule::get_startSpeed()  /*0x0A000374*/
    IL_0013: stloc.0
    IL_0014: ldloca.s 0
    IL_0016: ldarg.0
    IL_0017: ldflda Vector2 PlayerTrapIntensityHelper::maxSpeedRange  /*0x04000983*/
    IL_001c: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0021: ldarg.0
    IL_0022: ldflda Vector2 PlayerTrapIntensityHelper::maxSpeedRange  /*0x04000983*/
    IL_0027: ldfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_002c: ldsfld float SpawnAttackOnCollision::lastTriggerProducitonProgress  /*0x04000CE4*/
    IL_0031: call float UnityEngine.Mathf::Lerp(float,float,float)  /*0x0A000085*/
    IL_0036: call void UnityEngine.ParticleSystem.MinMaxCurve::set_constantMax(float)  /*0x0A000375*/
    IL_003b: ldarg.0
    IL_003c: ldfld ParticleSystem PlayerTrapIntensityHelper::targetParticles  /*0x04000982*/
    IL_0041: callvirt ParticleSystem.MainModule UnityEngine.ParticleSystem::get_main()  /*0x0A000370*/
    IL_0046: stloc.1
    IL_0047: ldloca.s 1
    IL_0049: ldloc.0
    IL_004a: call void UnityEngine.ParticleSystem.MainModule::set_startSpeed(UnityEngine.ParticleSystem.MinMaxCurve)  /*0x0A000376*/
    IL_004f: ret

  .method PlayerTrapIntensityHelper::.ctor()  // token 0x0600079B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

