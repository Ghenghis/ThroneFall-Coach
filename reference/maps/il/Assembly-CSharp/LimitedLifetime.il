// ===== LimitedLifetime  (token 0x020001B9) =====
  .method LimitedLifetime::Start()  // token 0x060008F5 rva 0x2b051 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldarg.0
    IL_0007: ldfld float LimitedLifetime::liftetime  /*0x04000B41*/
    IL_000c: call void UnityEngine.Object::Destroy(UnityEngine.Object,float)  /*0x0A000077*/
    IL_0011: ret

  .method LimitedLifetime::.ctor()  // token 0x060008F6 rva 0x2b064 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float LimitedLifetime::liftetime  /*0x04000B41*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

