// ===== ThiefFX  (token 0x020000FD) =====
  .method ThiefFX::Start()  // token 0x06000544 rva 0x17104 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThiefController ThiefFX::_thiefController  /*0x040006DB*/
    IL_0006: ldfld UnityEvent ThiefController::onSteal  /*0x04000777*/
    IL_000b: ldarg.0
    IL_000c: ldftn void ThiefFX::OnSteal()  /*0x06000545*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method ThiefFX::OnSteal()  // token 0x06000545 rva 0x17122 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem ThiefFX::_fx  /*0x040006DC*/
    IL_0006: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_000b: ret

  .method ThiefFX::.ctor()  // token 0x06000546 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

