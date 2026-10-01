// ===== AegisSentinelAnimator  (token 0x020000BD) =====
  .method AegisSentinelAnimator::Start()  // token 0x060003F6 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AegisSentinelAnimator::OnTriggerProtection(bool)  // token 0x060003F7 rva 0x11400 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator AegisSentinelAnimator::_animator  /*0x04000519*/
    IL_0006: ldstr "Protecting"
    IL_000b: ldarg.1
    IL_000c: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0011: ret

  .method AegisSentinelAnimator::.ctor()  // token 0x060003F8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

