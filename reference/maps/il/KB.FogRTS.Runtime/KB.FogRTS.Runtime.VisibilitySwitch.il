// ===== KB.FogRTS.Runtime.VisibilitySwitch  (token 0x02000013) =====
  .method KB.FogRTS.Runtime.VisibilitySwitch::add_OnVisibilityChanged(System.Action<bool>)  // token 0x06000067 rva 0x3ba4 attrs Public, HideBySig, SpecialName
    // code size 41 (0x29), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldarg.0
    IL_0001: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::OnVisibilityChanged  /*0x0400006B*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: stloc.1
    IL_0009: ldloc.1
    IL_000a: ldarg.1
    IL_000b: call Delegate System.Delegate::Combine(System.Delegate,System.Delegate)  /*0x0A000012*/
    IL_0010: castclass System.Action<bool>  /*0x1B000002*/
    IL_0015: stloc.2
    IL_0016: ldarg.0
    IL_0017: ldflda Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::OnVisibilityChanged  /*0x0400006B*/
    IL_001c: ldloc.2
    IL_001d: ldloc.1
    IL_001e: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldloc.1
    IL_0026: bne.un.s IL_0007
    IL_0028: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::remove_OnVisibilityChanged(System.Action<bool>)  // token 0x06000068 rva 0x3bdc attrs Public, HideBySig, SpecialName
    // code size 41 (0x29), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldarg.0
    IL_0001: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::OnVisibilityChanged  /*0x0400006B*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: stloc.1
    IL_0009: ldloc.1
    IL_000a: ldarg.1
    IL_000b: call Delegate System.Delegate::Remove(System.Delegate,System.Delegate)  /*0x0A000014*/
    IL_0010: castclass System.Action<bool>  /*0x1B000002*/
    IL_0015: stloc.2
    IL_0016: ldarg.0
    IL_0017: ldflda Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::OnVisibilityChanged  /*0x0400006B*/
    IL_001c: ldloc.2
    IL_001d: ldloc.1
    IL_001e: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldloc.1
    IL_0026: bne.un.s IL_0007
    IL_0028: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::add_TriggerFader(System.Action<bool>)  // token 0x06000069 rva 0x3c14 attrs Assembly, HideBySig, SpecialName
    // code size 41 (0x29), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldarg.0
    IL_0001: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: stloc.1
    IL_0009: ldloc.1
    IL_000a: ldarg.1
    IL_000b: call Delegate System.Delegate::Combine(System.Delegate,System.Delegate)  /*0x0A000012*/
    IL_0010: castclass System.Action<bool>  /*0x1B000002*/
    IL_0015: stloc.2
    IL_0016: ldarg.0
    IL_0017: ldflda Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_001c: ldloc.2
    IL_001d: ldloc.1
    IL_001e: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldloc.1
    IL_0026: bne.un.s IL_0007
    IL_0028: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::remove_TriggerFader(System.Action<bool>)  // token 0x0600006A rva 0x3c4c attrs Assembly, HideBySig, SpecialName
    // code size 41 (0x29), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldarg.0
    IL_0001: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: stloc.1
    IL_0009: ldloc.1
    IL_000a: ldarg.1
    IL_000b: call Delegate System.Delegate::Remove(System.Delegate,System.Delegate)  /*0x0A000014*/
    IL_0010: castclass System.Action<bool>  /*0x1B000002*/
    IL_0015: stloc.2
    IL_0016: ldarg.0
    IL_0017: ldflda Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_001c: ldloc.2
    IL_001d: ldloc.1
    IL_001e: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0023: stloc.0
    IL_0024: ldloc.0
    IL_0025: ldloc.1
    IL_0026: bne.un.s IL_0007
    IL_0028: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::get_IsVisible()  // token 0x0600006B rva 0x3c81 attrs Public, HideBySig, SpecialName
    // code size 10 (0xa), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInvisible  /*0x0400006F*/
    IL_0006: ldc.i4.0
    IL_0007: ceq
    IL_0009: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::get_Layer()  // token 0x0600006C rva 0x3c8c attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld VisionLayer KB.FogRTS.Runtime.VisibilitySwitch::layer  /*0x04000067*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::set_Layer(KB.FogRTS.Runtime.VisionLayer)  // token 0x0600006D rva 0x3c94 attrs Public, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld VisionLayer KB.FogRTS.Runtime.VisibilitySwitch::layer  /*0x04000067*/
    IL_0007: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::set_Transform(UnityEngine.Transform)  // token 0x0600006E rva 0x3c9d attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Transform KB.FogRTS.Runtime.VisibilitySwitch::<Transform>k__BackingField  /*0x04000070*/
    IL_0007: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::get_Transform()  // token 0x0600006F rva 0x3ca6 attrs Assembly, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform KB.FogRTS.Runtime.VisibilitySwitch::<Transform>k__BackingField  /*0x04000070*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::Awake()  // token 0x06000070 rva 0x3cae attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Runtime.VisibilitySwitch::Init()  /*0x06000073*/
    IL_0006: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::OnEnable()  // token 0x06000071 rva 0x3cb6 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInitializing  /*0x0400006E*/
    IL_0007: ldarg.0
    IL_0008: ldftn void KB.FogRTS.Runtime.VisibilitySwitch::SetVisibility(bool)  /*0x06000076*/
    IL_000e: newobj void System.Action<bool>::.ctor(object,IntPtr)  /*0x0A000090*/
    IL_0013: call void KB.FogRTS.Runtime.CheckPointContainer::add_OnDetectionCompleted(System.Action<bool>)  /*0x06000009*/
    IL_0018: ldarg.0
    IL_0019: call void KB.FogRTS.Runtime.VisibilitySwitch::AddCheckpoints()  /*0x06000074*/
    IL_001e: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::OnDisable()  // token 0x06000072 rva 0x3cd6 attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KB.FogRTS.Runtime.VisibilitySwitch::SetVisibility(bool)  /*0x06000076*/
    IL_0007: newobj void System.Action<bool>::.ctor(object,IntPtr)  /*0x0A000090*/
    IL_000c: call void KB.FogRTS.Runtime.CheckPointContainer::remove_OnDetectionCompleted(System.Action<bool>)  /*0x0600000A*/
    IL_0011: ldarg.0
    IL_0012: call void KB.FogRTS.Runtime.VisibilitySwitch::RemoveCheckpoints()  /*0x06000075*/
    IL_0017: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::Init()  // token 0x06000073 rva 0x3cf0 attrs Private, HideBySig
    // code size 77 (0x4d), max stack 5, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A0000C1*/
    IL_0007: call void KB.FogRTS.Runtime.VisibilitySwitch::set_Transform(UnityEngine.Transform)  /*0x0600006E*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Vector2[] KB.FogRTS.Runtime.VisibilitySwitch::positions  /*0x04000068*/
    IL_0013: ldlen
    IL_0014: conv.i4
    IL_0015: newarr KB.FogRTS.Runtime.CheckPoint  /*0x02000003*/
    IL_001a: stfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_001f: ldc.i4.0
    IL_0020: stloc.0
    IL_0021: br.s IL_0041
    IL_0023: ldarg.0
    IL_0024: ldfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_0029: ldloc.0
    IL_002a: ldarg.0
    IL_002b: ldarg.0
    IL_002c: ldfld Vector2[] KB.FogRTS.Runtime.VisibilitySwitch::positions  /*0x04000068*/
    IL_0031: ldloc.0
    IL_0032: ldelem UnityEngine.Vector2  /*0x0100000B*/
    IL_0037: newobj void KB.FogRTS.Runtime.CheckPoint::.ctor(KB.FogRTS.Runtime.VisibilitySwitch,UnityEngine.Vector2)  /*0x06000007*/
    IL_003c: stelem.ref
    IL_003d: ldloc.0
    IL_003e: ldc.i4.1
    IL_003f: add
    IL_0040: stloc.0
    IL_0041: ldloc.0
    IL_0042: ldarg.0
    IL_0043: ldfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_0048: ldlen
    IL_0049: conv.i4
    IL_004a: blt.s IL_0023
    IL_004c: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::AddCheckpoints()  // token 0x06000074 rva 0x3d4c attrs Private, HideBySig
    // code size 30 (0x1e), max stack 2, init locals
    .locals ([0] CheckPoint[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0017
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: call void KB.FogRTS.Runtime.CheckPointContainer::Add(KB.FogRTS.Runtime.CheckPoint)  /*0x0600000C*/
    IL_0013: ldloc.1
    IL_0014: ldc.i4.1
    IL_0015: add
    IL_0016: stloc.1
    IL_0017: ldloc.1
    IL_0018: ldloc.0
    IL_0019: ldlen
    IL_001a: conv.i4
    IL_001b: blt.s IL_000b
    IL_001d: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::RemoveCheckpoints()  // token 0x06000075 rva 0x3d78 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 2, init locals
    .locals ([0] CheckPoint[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0017
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: call void KB.FogRTS.Runtime.CheckPointContainer::Remove(KB.FogRTS.Runtime.CheckPoint)  /*0x0600000D*/
    IL_0013: ldloc.1
    IL_0014: ldc.i4.1
    IL_0015: add
    IL_0016: stloc.1
    IL_0017: ldloc.1
    IL_0018: ldloc.0
    IL_0019: ldlen
    IL_001a: conv.i4
    IL_001b: blt.s IL_000b
    IL_001d: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::SetVisibility(bool)  // token 0x06000076 rva 0x3da4 attrs Private, HideBySig
    // code size 99 (0x63), max stack 2, init locals
    .locals ([0] bool)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0012
    IL_0003: ldarg.0
    IL_0004: ldc.i4.1
    IL_0005: stfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInitializing  /*0x0400006E*/
    IL_000a: ldarg.0
    IL_000b: ldc.i4.1
    IL_000c: call void KB.FogRTS.Runtime.VisibilitySwitch::SetVisibilityState(bool)  /*0x06000077*/
    IL_0011: ret
    IL_0012: ldarg.0
    IL_0013: call bool KB.FogRTS.Runtime.VisibilitySwitch::CheckIfVisible()  /*0x06000078*/
    IL_0018: stloc.0
    IL_0019: ldloc.0
    IL_001a: brfalse.s IL_002d
    IL_001c: ldarg.0
    IL_001d: ldfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInvisible  /*0x0400006F*/
    IL_0022: brfalse.s IL_002d
    IL_0024: ldarg.0
    IL_0025: ldc.i4.1
    IL_0026: call void KB.FogRTS.Runtime.VisibilitySwitch::SetVisibilityState(bool)  /*0x06000077*/
    IL_002b: br.s IL_005b
    IL_002d: ldloc.0
    IL_002e: brtrue.s IL_0041
    IL_0030: ldarg.0
    IL_0031: ldfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInvisible  /*0x0400006F*/
    IL_0036: brtrue.s IL_0041
    IL_0038: ldarg.0
    IL_0039: ldc.i4.0
    IL_003a: call void KB.FogRTS.Runtime.VisibilitySwitch::SetVisibilityState(bool)  /*0x06000077*/
    IL_003f: br.s IL_005b
    IL_0041: ldarg.0
    IL_0042: ldfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInitializing  /*0x0400006E*/
    IL_0047: brfalse.s IL_005b
    IL_0049: ldarg.0
    IL_004a: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_004f: dup
    IL_0050: brtrue.s IL_0055
    IL_0052: pop
    IL_0053: br.s IL_005b
    IL_0055: ldc.i4.1
    IL_0056: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A00001E*/
    IL_005b: ldarg.0
    IL_005c: ldc.i4.0
    IL_005d: stfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInitializing  /*0x0400006E*/
    IL_0062: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::SetVisibilityState(bool)  // token 0x06000077 rva 0x3e14 attrs Private, HideBySig
    // code size 78 (0x4e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldc.i4.0
    IL_0003: ceq
    IL_0005: stfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInvisible  /*0x0400006F*/
    IL_000a: ldarg.1
    IL_000b: brfalse.s IL_001a
    IL_000d: ldarg.0
    IL_000e: ldfld UnityEvent KB.FogRTS.Runtime.VisibilitySwitch::onBecomeVisible  /*0x04000069*/
    IL_0013: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A0000C2*/
    IL_0018: br.s IL_0025
    IL_001a: ldarg.0
    IL_001b: ldfld UnityEvent KB.FogRTS.Runtime.VisibilitySwitch::onBecomeInvisible  /*0x0400006A*/
    IL_0020: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A0000C2*/
    IL_0025: ldarg.0
    IL_0026: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::OnVisibilityChanged  /*0x0400006B*/
    IL_002b: dup
    IL_002c: brtrue.s IL_0031
    IL_002e: pop
    IL_002f: br.s IL_0037
    IL_0031: ldarg.1
    IL_0032: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A00001E*/
    IL_0037: ldarg.0
    IL_0038: ldfld Action<bool> KB.FogRTS.Runtime.VisibilitySwitch::TriggerFader  /*0x0400006C*/
    IL_003d: dup
    IL_003e: brtrue.s IL_0042
    IL_0040: pop
    IL_0041: ret
    IL_0042: ldarg.0
    IL_0043: ldfld bool KB.FogRTS.Runtime.VisibilitySwitch::isInitializing  /*0x0400006E*/
    IL_0048: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A00001E*/
    IL_004d: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::CheckIfVisible()  // token 0x06000078 rva 0x3e70 attrs Private, HideBySig
    // code size 35 (0x23), max stack 2, init locals
    .locals ([0] CheckPoint[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld CheckPoint[] KB.FogRTS.Runtime.VisibilitySwitch::checkPoints  /*0x0400006D*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_001b
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: callvirt bool KB.FogRTS.Runtime.CheckPoint::get_IsVisible()  /*0x06000006*/
    IL_0013: brfalse.s IL_0017
    IL_0015: ldc.i4.1
    IL_0016: ret
    IL_0017: ldloc.1
    IL_0018: ldc.i4.1
    IL_0019: add
    IL_001a: stloc.1
    IL_001b: ldloc.1
    IL_001c: ldloc.0
    IL_001d: ldlen
    IL_001e: conv.i4
    IL_001f: blt.s IL_000b
    IL_0021: ldc.i4.0
    IL_0022: ret

  .method KB.FogRTS.Runtime.VisibilitySwitch::.ctor()  // token 0x06000079 rva 0x3e9f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld VisionLayer KB.FogRTS.Runtime.VisibilitySwitch::layer  /*0x04000067*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: newarr UnityEngine.Vector2  /*0x0100000B*/
    IL_000e: dup
    IL_000f: ldc.i4.0
    IL_0010: call Vector2 UnityEngine.Vector2::get_zero()  /*0x0A0000C3*/
    IL_0015: stelem UnityEngine.Vector2  /*0x0100000B*/
    IL_001a: stfld Vector2[] KB.FogRTS.Runtime.VisibilitySwitch::positions  /*0x04000068*/
    IL_001f: ldarg.0
    IL_0020: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A0000C4*/
    IL_0025: stfld UnityEvent KB.FogRTS.Runtime.VisibilitySwitch::onBecomeVisible  /*0x04000069*/
    IL_002a: ldarg.0
    IL_002b: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A0000C4*/
    IL_0030: stfld UnityEvent KB.FogRTS.Runtime.VisibilitySwitch::onBecomeInvisible  /*0x0400006A*/
    IL_0035: ldarg.0
    IL_0036: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000092*/
    IL_003b: ret

