// ===== InteractorBase  (token 0x02000234) =====
  .method InteractorBase::ReturnTooltip()  // token 0x06000BE7 rva 0x1f25e attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: ldstr ""
    IL_0005: ret

  .method InteractorBase::get_CanBeInteractedWith()  // token 0x06000BE8 rva 0x38002 attrs Public, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 2 (0x2), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: ret

  .method InteractorBase::InteractionBegin(PlayerInteraction)  // token 0x06000BE9 rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InteractorBase::InteractionHold(PlayerInteraction)  // token 0x06000BEA rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InteractorBase::InteractionEnd(PlayerInteraction)  // token 0x06000BEB rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InteractorBase::Focus(PlayerInteraction)  // token 0x06000BEC rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method InteractorBase::Unfocus(PlayerInteraction)  // token 0x06000BED rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method InteractorBase::.ctor()  // token 0x06000BEE rva 0x20e9 attrs Family, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

