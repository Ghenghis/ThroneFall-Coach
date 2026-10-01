// ===== ThiefAnimator  (token 0x020000C5) =====
  .method ThiefAnimator::Start()  // token 0x06000417 rva 0x1196e attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ThiefController ThiefAnimator::_thiefController  /*0x04000545*/
    IL_0006: ldfld UnityEvent<bool> ThiefController::onStealingTarget  /*0x04000776*/
    IL_000b: ldarg.0
    IL_000c: ldftn void ThiefAnimator::OnStealingTarget(bool)  /*0x06000418*/
    IL_0012: newobj void UnityEngine.Events.UnityAction<bool>::.ctor(object,IntPtr)  /*0x0A0000CC*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent<bool>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0000CD*/
    IL_001c: ret

  .method ThiefAnimator::OnStealingTarget(bool)  // token 0x06000418 rva 0x1198c attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Animator ThiefAnimator::_animator  /*0x04000546*/
    IL_0006: ldstr "Stealing"
    IL_000b: ldarg.1
    IL_000c: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0011: ret

  .method ThiefAnimator::.ctor()  // token 0x06000419 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

