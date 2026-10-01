// ===== NavmeshBakeHelper  (token 0x020001FD) =====
  .method NavmeshBakeHelper::.ctor()  // token 0x06000A9C rva 0x32ce6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool NavmeshBakeHelper::_turnOffMeshRendsOnBake  /*0x04000D76*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 5000f
    IL_000d: stfld float NavmeshBakeHelper::minRegionSize  /*0x04000D7B*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 3000f
    IL_0018: stfld float NavmeshBakeHelper::minRegionSizeAir  /*0x04000D7C*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

