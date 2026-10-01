// ===== FlameTowerSmokeFX  (token 0x020000F9) =====
  .method FlameTowerSmokeFX::Update()  // token 0x06000535 rva 0x16d38 attrs Private, HideBySig
    // code size 113 (0x71), max stack 1, init locals
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_000a: brtrue.s IL_0025
    IL_000c: ldarg.0
    IL_000d: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_0012: callvirt bool UnityEngine.ParticleSystem::get_isPlaying()  /*0x0A000111*/
    IL_0017: brfalse.s IL_0024
    IL_0019: ldarg.0
    IL_001a: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_001f: callvirt void UnityEngine.ParticleSystem::Stop()  /*0x0A00022C*/
    IL_0024: ret
    IL_0025: ldarg.0
    IL_0026: ldfld AutoAttackFlamethrower FlameTowerSmokeFX::_autoAttack  /*0x040006C2*/
    IL_002b: callvirt bool AutoAttackFlamethrower::get_IsActive()  /*0x0600042E*/
    IL_0030: brfalse.s IL_004b
    IL_0032: ldarg.0
    IL_0033: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_0038: callvirt bool UnityEngine.ParticleSystem::get_isPlaying()  /*0x0A000111*/
    IL_003d: brtrue.s IL_004b
    IL_003f: ldarg.0
    IL_0040: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_0045: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_004a: ret
    IL_004b: ldarg.0
    IL_004c: ldfld AutoAttackFlamethrower FlameTowerSmokeFX::_autoAttack  /*0x040006C2*/
    IL_0051: callvirt bool AutoAttackFlamethrower::get_IsActive()  /*0x0600042E*/
    IL_0056: brtrue.s IL_0070
    IL_0058: ldarg.0
    IL_0059: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_005e: callvirt bool UnityEngine.ParticleSystem::get_isPlaying()  /*0x0A000111*/
    IL_0063: brfalse.s IL_0070
    IL_0065: ldarg.0
    IL_0066: ldfld ParticleSystem FlameTowerSmokeFX::_smokeFX  /*0x040006C3*/
    IL_006b: callvirt void UnityEngine.ParticleSystem::Stop()  /*0x0A00022C*/
    IL_0070: ret

  .method FlameTowerSmokeFX::.ctor()  // token 0x06000536 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

