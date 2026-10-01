// ===== ReturnGameObjectToPool  (token 0x020002A8) =====
  .method ReturnGameObjectToPool::.ctor()  // token 0x06000EAC rva 0x4171c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.m1
    IL_0002: stfld int ReturnGameObjectToPool::owningPoolHashCode  /*0x040010EF*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

