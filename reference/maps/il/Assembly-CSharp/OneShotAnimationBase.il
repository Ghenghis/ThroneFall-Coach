// ===== OneShotAnimationBase  (token 0x02000027) =====
  .method OneShotAnimationBase::Trigger()  // token 0x060000CE rva 0x0 attrs Public, Virtual, HideBySig, VtableLayoutMask, Abstract
    // no body (abstract / extern / interface)

  .method OneShotAnimationBase::.ctor()  // token 0x060000CF rva 0x567e attrs Family, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float OneShotAnimationBase::duration  /*0x040000F9*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

