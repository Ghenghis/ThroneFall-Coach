// ===== KB.FogRTS.Runtime.CheckPoint  (token 0x02000003) =====
  .method KB.FogRTS.Runtime.CheckPoint::get_Transform()  // token 0x06000003 rva 0x20c0 attrs Assembly, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisibilitySwitch KB.FogRTS.Runtime.CheckPoint::visibilitySwitch  /*0x04000001*/
    IL_0006: callvirt Transform KB.FogRTS.Runtime.VisibilitySwitch::get_Transform()  /*0x0600006F*/
    IL_000b: ret

  .method KB.FogRTS.Runtime.CheckPoint::get_Layer()  // token 0x06000004 rva 0x20cd attrs Assembly, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisibilitySwitch KB.FogRTS.Runtime.CheckPoint::visibilitySwitch  /*0x04000001*/
    IL_0006: callvirt VisionLayer KB.FogRTS.Runtime.VisibilitySwitch::get_Layer()  /*0x0600006C*/
    IL_000b: ret

  .method KB.FogRTS.Runtime.CheckPoint::get_Offset()  // token 0x06000005 rva 0x20da attrs Assembly, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector2 KB.FogRTS.Runtime.CheckPoint::offset  /*0x04000002*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.CheckPoint::get_IsVisible()  // token 0x06000006 rva 0x20e2 attrs Assembly, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.CheckPoint::isInvisible  /*0x04000003*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method KB.FogRTS.Runtime.CheckPoint::.ctor(KB.FogRTS.Runtime.VisibilitySwitch,UnityEngine.Vector2)  // token 0x06000007 rva 0x20ed attrs Assembly, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000011*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld VisibilitySwitch KB.FogRTS.Runtime.CheckPoint::visibilitySwitch  /*0x04000001*/
    IL_000d: ldarg.0
    IL_000e: ldarg.2
    IL_000f: stfld Vector2 KB.FogRTS.Runtime.CheckPoint::offset  /*0x04000002*/
    IL_0014: ret

  .method KB.FogRTS.Runtime.CheckPoint::SetVisibility(bool)  // token 0x06000008 rva 0x2103 attrs Assembly, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldc.i4.0
    IL_0003: ceq
    IL_0005: stfld bool KB.FogRTS.Runtime.CheckPoint::isInvisible  /*0x04000003*/
    IL_000a: ret

