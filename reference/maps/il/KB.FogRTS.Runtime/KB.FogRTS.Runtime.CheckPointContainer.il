// ===== KB.FogRTS.Runtime.CheckPointContainer  (token 0x02000004) =====
  .method KB.FogRTS.Runtime.CheckPointContainer::add_OnDetectionCompleted(System.Action<bool>)  // token 0x06000009 rva 0x2110 attrs Assembly, Static, HideBySig, SpecialName
    // code size 39 (0x27), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldsfld Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: stloc.1
    IL_0008: ldloc.1
    IL_0009: ldarg.0
    IL_000a: call Delegate System.Delegate::Combine(System.Delegate,System.Delegate)  /*0x0A000012*/
    IL_000f: castclass System.Action<bool>  /*0x1B000002*/
    IL_0014: stloc.2
    IL_0015: ldsflda Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_001a: ldloc.2
    IL_001b: ldloc.1
    IL_001c: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0021: stloc.0
    IL_0022: ldloc.0
    IL_0023: ldloc.1
    IL_0024: bne.un.s IL_0006
    IL_0026: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::remove_OnDetectionCompleted(System.Action<bool>)  // token 0x0600000A rva 0x2144 attrs Assembly, Static, HideBySig, SpecialName
    // code size 39 (0x27), max stack 3, init locals
    .locals ([0] Action<bool>, [1] Action<bool>, [2] Action<bool>)
    IL_0000: ldsfld Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: stloc.1
    IL_0008: ldloc.1
    IL_0009: ldarg.0
    IL_000a: call Delegate System.Delegate::Remove(System.Delegate,System.Delegate)  /*0x0A000014*/
    IL_000f: castclass System.Action<bool>  /*0x1B000002*/
    IL_0014: stloc.2
    IL_0015: ldsflda Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_001a: ldloc.2
    IL_001b: ldloc.1
    IL_001c: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<bool>>  /*0x2B000001*/
    IL_0021: stloc.0
    IL_0022: ldloc.0
    IL_0023: ldloc.1
    IL_0024: bne.un.s IL_0006
    IL_0026: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::Init(int,bool)  // token 0x0600000B rva 0x2178 attrs Assembly, Static, HideBySig
    // code size 137 (0x89), max stack 4, init locals
    .locals ([0] CheckPointContainer)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::GetInstance()  /*0x0A000015*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld bool KB.FogRTS.Runtime.CheckPointContainer::inited  /*0x04000006*/
    IL_000c: brfalse.s IL_0016
    IL_000e: ldloc.0
    IL_000f: callvirt void KB.FogRTS.Runtime.CheckPointContainer::Dispose()  /*0x06000012*/
    IL_0014: br.s IL_001d
    IL_0016: ldloc.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool KB.FogRTS.Runtime.CheckPointContainer::inited  /*0x04000006*/
    IL_001d: ldloc.0
    IL_001e: ldarg.0
    IL_001f: stfld int KB.FogRTS.Runtime.CheckPointContainer::maxElements  /*0x04000007*/
    IL_0024: ldloc.0
    IL_0025: ldarg.1
    IL_0026: stfld bool KB.FogRTS.Runtime.CheckPointContainer::orientationXZ  /*0x04000008*/
    IL_002b: ldloc.0
    IL_002c: ldarg.0
    IL_002d: newarr KB.FogRTS.Runtime.CheckPoint  /*0x02000003*/
    IL_0032: stfld CheckPoint[] KB.FogRTS.Runtime.CheckPointContainer::cachedCheckPoints  /*0x04000009*/
    IL_0037: ldloc.0
    IL_0038: ldc.i4.0
    IL_0039: stfld int KB.FogRTS.Runtime.CheckPointContainer::cachedCount  /*0x0400000A*/
    IL_003e: ldloc.0
    IL_003f: ldarg.0
    IL_0040: newarr UnityEngine.Transform  /*0x0100000C*/
    IL_0045: stfld Transform[] KB.FogRTS.Runtime.CheckPointContainer::transforms  /*0x0400000B*/
    IL_004a: ldloc.0
    IL_004b: ldarg.0
    IL_004c: ldc.i4.1
    IL_004d: newobj void UnityEngine.Jobs.TransformAccessArray::.ctor(int,int)  /*0x0A000016*/
    IL_0052: stfld TransformAccessArray KB.FogRTS.Runtime.CheckPointContainer::transformAccessArray  /*0x0400000C*/
    IL_0057: ldloc.0
    IL_0058: ldarg.0
    IL_0059: ldc.i4.4
    IL_005a: ldc.i4.1
    IL_005b: newobj void Unity.Collections.NativeArray<Unity.Mathematics.float2>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000017*/
    IL_0060: stfld NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer::offsets  /*0x0400000D*/
    IL_0065: ldloc.0
    IL_0066: ldarg.0
    IL_0067: ldc.i4.4
    IL_0068: ldc.i4.1
    IL_0069: newobj void Unity.Collections.NativeArray<uint>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000018*/
    IL_006e: stfld NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer::layers  /*0x0400000E*/
    IL_0073: ldloc.0
    IL_0074: ldarg.0
    IL_0075: ldc.i4.4
    IL_0076: ldc.i4.1
    IL_0077: newobj void Unity.Collections.NativeArray<bool>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000019*/
    IL_007c: stfld NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer::areVisible  /*0x0400000F*/
    IL_0081: ldloc.0
    IL_0082: ldc.i4.1
    IL_0083: stfld bool KB.FogRTS.Runtime.CheckPointContainer::modified  /*0x04000010*/
    IL_0088: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::Add(KB.FogRTS.Runtime.CheckPoint)  // token 0x0600000C rva 0x220d attrs Assembly, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::GetInstance()  /*0x0A000015*/
    IL_0005: dup
    IL_0006: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_000b: ldarg.0
    IL_000c: callvirt void System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::Add(!0)  /*0x0A00001A*/
    IL_0011: ldc.i4.1
    IL_0012: stfld bool KB.FogRTS.Runtime.CheckPointContainer::modified  /*0x04000010*/
    IL_0017: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::Remove(KB.FogRTS.Runtime.CheckPoint)  // token 0x0600000D rva 0x2226 attrs Assembly, Static, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::GetInstance()  /*0x0A000015*/
    IL_0005: dup
    IL_0006: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_000b: ldarg.0
    IL_000c: callvirt bool System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::Remove(!0)  /*0x0A00001B*/
    IL_0011: pop
    IL_0012: ldc.i4.1
    IL_0013: stfld bool KB.FogRTS.Runtime.CheckPointContainer::modified  /*0x04000010*/
    IL_0018: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::ScheduleJob(Unity.Jobs.JobHandle)  // token 0x0600000E rva 0x2240 attrs Assembly, Static, HideBySig
    // code size 176 (0xb0), max stack 4, init locals
    .locals ([0] CheckPointContainer, [1] CheckPointContainer.CheckIsInVisionJob)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::GetInstance()  /*0x0A000015*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld bool KB.FogRTS.Runtime.CheckPointContainer::modified  /*0x04000010*/
    IL_000c: brfalse.s IL_001b
    IL_000e: ldloc.0
    IL_000f: callvirt void KB.FogRTS.Runtime.CheckPointContainer::Setup()  /*0x06000011*/
    IL_0014: ldloc.0
    IL_0015: ldc.i4.0
    IL_0016: stfld bool KB.FogRTS.Runtime.CheckPointContainer::modified  /*0x04000010*/
    IL_001b: ldloca.s 1
    IL_001d: initobj KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob  /*0x02000018*/
    IL_0023: ldloca.s 1
    IL_0025: ldloc.0
    IL_0026: ldfld int KB.FogRTS.Runtime.CheckPointContainer::cachedCount  /*0x0400000A*/
    IL_002b: stfld int KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsCount  /*0x04000084*/
    IL_0030: ldloca.s 1
    IL_0032: ldloc.0
    IL_0033: ldfld bool KB.FogRTS.Runtime.CheckPointContainer::orientationXZ  /*0x04000008*/
    IL_0038: stfld bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::OrientationXZ  /*0x04000085*/
    IL_003d: ldloca.s 1
    IL_003f: ldloc.0
    IL_0040: ldfld NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer::offsets  /*0x0400000D*/
    IL_0045: stfld NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsOffsets  /*0x04000086*/
    IL_004a: ldloca.s 1
    IL_004c: ldloc.0
    IL_004d: ldfld NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer::layers  /*0x0400000E*/
    IL_0052: stfld NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsLayers  /*0x04000087*/
    IL_0057: ldloca.s 1
    IL_0059: call int KB.FogRTS.Runtime.VisionContainer::get_Count()  /*0x0600001B*/
    IL_005e: stfld int KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionCount  /*0x04000088*/
    IL_0063: ldloca.s 1
    IL_0065: call NativeArray.ReadOnly<uint> KB.FogRTS.Runtime.VisionContainer::get_ShapesAndLayers()  /*0x0600001C*/
    IL_006a: stfld NativeArray.ReadOnly<uint> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionShapesAndLayers  /*0x04000089*/
    IL_006f: ldloca.s 1
    IL_0071: call NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.VisionContainer::get_Positions()  /*0x0600001D*/
    IL_0076: stfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionPositions  /*0x0400008A*/
    IL_007b: ldloca.s 1
    IL_007d: call NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.VisionContainer::get_Rotations()  /*0x0600001E*/
    IL_0082: stfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionRotations  /*0x0400008B*/
    IL_0087: ldloca.s 1
    IL_0089: call NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.VisionContainer::get_Scales()  /*0x0600001F*/
    IL_008e: stfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionScales  /*0x0400008C*/
    IL_0093: ldloca.s 1
    IL_0095: ldloc.0
    IL_0096: ldfld NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer::areVisible  /*0x0400000F*/
    IL_009b: stfld NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::Results  /*0x0400008D*/
    IL_00a0: ldloc.1
    IL_00a1: ldloc.0
    IL_00a2: ldfld TransformAccessArray KB.FogRTS.Runtime.CheckPointContainer::transformAccessArray  /*0x0400000C*/
    IL_00a7: ldc.i4.s 64
    IL_00a9: ldarg.0
    IL_00aa: call JobHandle UnityEngine.Jobs.IJobParallelForTransformExtensions::ScheduleReadOnly(!!0,UnityEngine.Jobs.TransformAccessArray,int,Unity.Jobs.JobHandle)<KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob>  /*0x2B000002*/
    IL_00af: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::PerformObjectDetection()  // token 0x0600000F rva 0x22fc attrs Assembly, Static, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    .locals ([0] CheckPointContainer, [1] int)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::GetInstance()  /*0x0A000015*/
    IL_0005: stloc.0
    IL_0006: ldc.i4.0
    IL_0007: stloc.1
    IL_0008: br.s IL_0027
    IL_000a: ldloc.0
    IL_000b: ldfld CheckPoint[] KB.FogRTS.Runtime.CheckPointContainer::cachedCheckPoints  /*0x04000009*/
    IL_0010: ldloc.1
    IL_0011: ldelem.ref
    IL_0012: ldloc.0
    IL_0013: ldflda NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer::areVisible  /*0x0400000F*/
    IL_0018: ldloc.1
    IL_0019: call !0 Unity.Collections.NativeArray<bool>::get_Item(int)  /*0x0A00001D*/
    IL_001e: callvirt void KB.FogRTS.Runtime.CheckPoint::SetVisibility(bool)  /*0x06000008*/
    IL_0023: ldloc.1
    IL_0024: ldc.i4.1
    IL_0025: add
    IL_0026: stloc.1
    IL_0027: ldloc.1
    IL_0028: ldloc.0
    IL_0029: ldfld int KB.FogRTS.Runtime.CheckPointContainer::cachedCount  /*0x0400000A*/
    IL_002e: blt.s IL_000a
    IL_0030: ldsfld Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_0035: dup
    IL_0036: brtrue.s IL_003a
    IL_0038: pop
    IL_0039: ret
    IL_003a: ldc.i4.0
    IL_003b: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A00001E*/
    IL_0040: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::NotifyDetectionSkipped()  // token 0x06000010 rva 0x2349 attrs Assembly, Static, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldsfld Action<bool> KB.FogRTS.Runtime.CheckPointContainer::OnDetectionCompleted  /*0x04000004*/
    IL_0005: dup
    IL_0006: brtrue.s IL_000a
    IL_0008: pop
    IL_0009: ret
    IL_000a: ldc.i4.1
    IL_000b: callvirt void System.Action<bool>::Invoke(!0)  /*0x0A00001E*/
    IL_0010: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::Setup()  // token 0x06000011 rva 0x235c attrs Private, HideBySig
    // code size 204 (0xcc), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_0007: callvirt int System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::get_Count()  /*0x0A00001F*/
    IL_000c: ldarg.0
    IL_000d: ldfld int KB.FogRTS.Runtime.CheckPointContainer::maxElements  /*0x04000007*/
    IL_0012: call int UnityEngine.Mathf::Min(int,int)  /*0x0A000020*/
    IL_0017: stfld int KB.FogRTS.Runtime.CheckPointContainer::cachedCount  /*0x0400000A*/
    IL_001c: ldc.i4.0
    IL_001d: stloc.0
    IL_001e: br IL_00ae
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld int KB.FogRTS.Runtime.CheckPointContainer::cachedCount  /*0x0400000A*/
    IL_002a: bge.s IL_009d
    IL_002c: ldarg.0
    IL_002d: ldfld CheckPoint[] KB.FogRTS.Runtime.CheckPointContainer::cachedCheckPoints  /*0x04000009*/
    IL_0032: ldloc.0
    IL_0033: ldarg.0
    IL_0034: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_0039: ldloc.0
    IL_003a: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::get_Item(int)  /*0x0A000021*/
    IL_003f: stelem.ref
    IL_0040: ldarg.0
    IL_0041: ldfld Transform[] KB.FogRTS.Runtime.CheckPointContainer::transforms  /*0x0400000B*/
    IL_0046: ldloc.0
    IL_0047: ldarg.0
    IL_0048: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_004d: ldloc.0
    IL_004e: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::get_Item(int)  /*0x0A000021*/
    IL_0053: callvirt Transform KB.FogRTS.Runtime.CheckPoint::get_Transform()  /*0x06000003*/
    IL_0058: stelem.ref
    IL_0059: ldarg.0
    IL_005a: ldflda NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer::offsets  /*0x0400000D*/
    IL_005f: ldloc.0
    IL_0060: ldarg.0
    IL_0061: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_0066: ldloc.0
    IL_0067: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::get_Item(int)  /*0x0A000021*/
    IL_006c: callvirt Vector2 KB.FogRTS.Runtime.CheckPoint::get_Offset()  /*0x06000005*/
    IL_0071: call float2 Unity.Mathematics.float2::op_Implicit(UnityEngine.Vector2)  /*0x0A000022*/
    IL_0076: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::set_Item(int,!0)  /*0x0A000023*/
    IL_007b: ldarg.0
    IL_007c: ldflda NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer::layers  /*0x0400000E*/
    IL_0081: ldloc.0
    IL_0082: ldarg.0
    IL_0083: ldfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_0088: ldloc.0
    IL_0089: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::get_Item(int)  /*0x0A000021*/
    IL_008e: callvirt VisionLayer KB.FogRTS.Runtime.CheckPoint::get_Layer()  /*0x06000004*/
    IL_0093: ldc.i4.s 15
    IL_0095: and
    IL_0096: call void Unity.Collections.NativeArray<uint>::set_Item(int,!0)  /*0x0A000024*/
    IL_009b: br.s IL_00aa
    IL_009d: ldarg.0
    IL_009e: ldfld Transform[] KB.FogRTS.Runtime.CheckPointContainer::transforms  /*0x0400000B*/
    IL_00a3: ldloc.0
    IL_00a4: call Transform KB.FogRTS.Runtime.TransformHelper::get_DummyTransform()  /*0x06000066*/
    IL_00a9: stelem.ref
    IL_00aa: ldloc.0
    IL_00ab: ldc.i4.1
    IL_00ac: add
    IL_00ad: stloc.0
    IL_00ae: ldloc.0
    IL_00af: ldarg.0
    IL_00b0: ldfld int KB.FogRTS.Runtime.CheckPointContainer::maxElements  /*0x04000007*/
    IL_00b5: blt IL_0023
    IL_00ba: ldarg.0
    IL_00bb: ldflda TransformAccessArray KB.FogRTS.Runtime.CheckPointContainer::transformAccessArray  /*0x0400000C*/
    IL_00c0: ldarg.0
    IL_00c1: ldfld Transform[] KB.FogRTS.Runtime.CheckPointContainer::transforms  /*0x0400000B*/
    IL_00c6: call void UnityEngine.Jobs.TransformAccessArray::SetTransforms(UnityEngine.Transform[])  /*0x0A000025*/
    IL_00cb: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::Dispose()  // token 0x06000012 rva 0x2434 attrs Private, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldflda TransformAccessArray KB.FogRTS.Runtime.CheckPointContainer::transformAccessArray  /*0x0400000C*/
    IL_0006: call void UnityEngine.Jobs.TransformAccessArray::Dispose()  /*0x0A000026*/
    IL_000b: ldarg.0
    IL_000c: ldflda NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer::offsets  /*0x0400000D*/
    IL_0011: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::Dispose()  /*0x0A000027*/
    IL_0016: ldarg.0
    IL_0017: ldflda NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer::layers  /*0x0400000E*/
    IL_001c: call void Unity.Collections.NativeArray<uint>::Dispose()  /*0x0A000028*/
    IL_0021: ldarg.0
    IL_0022: ldflda NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer::areVisible  /*0x0400000F*/
    IL_0027: call void Unity.Collections.NativeArray<bool>::Dispose()  /*0x0A000029*/
    IL_002c: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::OnDestroy()  // token 0x06000013 rva 0x2462 attrs Private, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.CheckPointContainer::inited  /*0x04000006*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void KB.FogRTS.Runtime.CheckPointContainer::Dispose()  /*0x06000012*/
    IL_000e: ret

  .method KB.FogRTS.Runtime.CheckPointContainer::.ctor()  // token 0x06000014 rva 0x2472 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<KB.FogRTS.Runtime.CheckPoint>::.ctor()  /*0x0A00002A*/
    IL_0006: stfld List<CheckPoint> KB.FogRTS.Runtime.CheckPointContainer::checkPoints  /*0x04000005*/
    IL_000b: ldarg.0
    IL_000c: call void KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.CheckPointContainer>::.ctor()  /*0x0A00002B*/
    IL_0011: ret

// ===== KB.FogRTS.Runtime.CheckPointContainer/CheckIsInVisionJob  (token 0x02000018) =====
  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::Execute(int,UnityEngine.Jobs.TransformAccess)  // token 0x0600008B rva 0x3fbc attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 139 (0x8b), max stack 5, init locals
    .locals ([0] Vector3, [1] Quaternion, [2] float2, [3] int)
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld int KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsCount  /*0x04000084*/
    IL_0007: blt.s IL_000a
    IL_0009: ret
    IL_000a: ldarga.s 2
    IL_000c: ldloca.s 0
    IL_000e: ldloca.s 1
    IL_0010: call void UnityEngine.Jobs.TransformAccess::GetPositionAndRotation(ref UnityEngine.Vector3,ref UnityEngine.Quaternion)  /*0x0A0000C6*/
    IL_0015: ldarg.0
    IL_0016: ldloc.0
    IL_0017: call float3 Unity.Mathematics.float3::op_Implicit(UnityEngine.Vector3)  /*0x0A0000C7*/
    IL_001c: ldloc.1
    IL_001d: call quaternion Unity.Mathematics.quaternion::op_Implicit(UnityEngine.Quaternion)  /*0x0A0000C8*/
    IL_0022: ldarg.0
    IL_0023: ldflda NativeArray<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsOffsets  /*0x04000086*/
    IL_0028: ldarg.1
    IL_0029: call !0 Unity.Collections.NativeArray<Unity.Mathematics.float2>::get_Item(int)  /*0x0A0000C9*/
    IL_002e: call float2 KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::CalculatePointPosition(Unity.Mathematics.float3,Unity.Mathematics.quaternion,Unity.Mathematics.float2)  /*0x0600008C*/
    IL_0033: stloc.2
    IL_0034: ldc.i4.0
    IL_0035: stloc.3
    IL_0036: br.s IL_0074
    IL_0038: ldarg.0
    IL_0039: ldflda NativeArray.ReadOnly<uint> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionShapesAndLayers  /*0x04000089*/
    IL_003e: ldloc.3
    IL_003f: call !0 Unity.Collections.NativeArray.ReadOnly<uint>::get_Item(int)  /*0x0A0000CA*/
    IL_0044: ldc.i4.2
    IL_0045: shr.un
    IL_0046: ldc.i4.s 15
    IL_0048: and
    IL_0049: ldarg.0
    IL_004a: ldflda NativeArray<uint> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::PointsLayers  /*0x04000087*/
    IL_004f: ldarg.1
    IL_0050: call !0 Unity.Collections.NativeArray<uint>::get_Item(int)  /*0x0A0000CB*/
    IL_0055: and
    IL_0056: brfalse.s IL_0070
    IL_0058: ldarg.0
    IL_0059: ldloc.2
    IL_005a: ldloc.3
    IL_005b: call bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::CheckIsInPosition(Unity.Mathematics.float2,int)  /*0x0600008D*/
    IL_0060: brfalse.s IL_0070
    IL_0062: ldarg.0
    IL_0063: ldflda NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::Results  /*0x0400008D*/
    IL_0068: ldarg.1
    IL_0069: ldc.i4.1
    IL_006a: call void Unity.Collections.NativeArray<bool>::set_Item(int,!0)  /*0x0A0000CC*/
    IL_006f: ret
    IL_0070: ldloc.3
    IL_0071: ldc.i4.1
    IL_0072: add
    IL_0073: stloc.3
    IL_0074: ldloc.3
    IL_0075: ldarg.0
    IL_0076: ldfld int KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionCount  /*0x04000088*/
    IL_007b: blt.s IL_0038
    IL_007d: ldarg.0
    IL_007e: ldflda NativeArray<bool> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::Results  /*0x0400008D*/
    IL_0083: ldarg.1
    IL_0084: ldc.i4.0
    IL_0085: call void Unity.Collections.NativeArray<bool>::set_Item(int,!0)  /*0x0A0000CC*/
    IL_008a: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::CalculatePointPosition(Unity.Mathematics.float3,Unity.Mathematics.quaternion,Unity.Mathematics.float2)  // token 0x0600008C rva 0x4054 attrs Private, HideBySig
    // code size 61 (0x3d), max stack 3, init locals
    .locals ([0] float, [1] float, [2] float2)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::OrientationXZ  /*0x04000085*/
    IL_0006: ldarg.2
    IL_0007: call float KB.FogRTS.Runtime.RotationHelper::QuaternionToAngle(bool,Unity.Mathematics.quaternion)  /*0x06000063*/
    IL_000c: ldloca.s 0
    IL_000e: ldloca.s 1
    IL_0010: call void Unity.Mathematics.math::sincos(float,ref float,ref float)  /*0x0A0000CD*/
    IL_0015: ldarg.3
    IL_0016: ldloc.0
    IL_0017: ldloc.1
    IL_0018: call float2 KB.FogRTS.Runtime.RotationHelper::Rotate2D(Unity.Mathematics.float2,float,float)  /*0x06000064*/
    IL_001d: stloc.2
    IL_001e: ldarg.0
    IL_001f: ldfld bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::OrientationXZ  /*0x04000085*/
    IL_0024: brtrue.s IL_002f
    IL_0026: ldarga.s 1
    IL_0028: call float2 Unity.Mathematics.float3::get_xy()  /*0x0A0000CE*/
    IL_002d: br.s IL_0036
    IL_002f: ldarga.s 1
    IL_0031: call float2 Unity.Mathematics.float3::get_xz()  /*0x0A0000CF*/
    IL_0036: ldloc.2
    IL_0037: call float2 Unity.Mathematics.float2::op_Addition(Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x0A0000D0*/
    IL_003c: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::CheckIsInPosition(Unity.Mathematics.float2,int)  // token 0x0600008D rva 0x40a0 attrs Private, HideBySig
    // code size 130 (0x82), max stack 6, init locals
    .locals ([0] float2, [1] uint, [2] NativeArray.ReadOnly<float2>, [3] NativeArray.ReadOnly<uint>, [4] bool)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.0
    IL_0003: ldfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionPositions  /*0x0400008A*/
    IL_0008: stloc.2
    IL_0009: ldloca.s 2
    IL_000b: ldarg.2
    IL_000c: call !0 Unity.Collections.NativeArray.ReadOnly<Unity.Mathematics.float2>::get_Item(int)  /*0x0A0000D1*/
    IL_0011: ldarg.0
    IL_0012: ldfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionRotations  /*0x0400008B*/
    IL_0017: stloc.2
    IL_0018: ldloca.s 2
    IL_001a: ldarg.2
    IL_001b: call !0 Unity.Collections.NativeArray.ReadOnly<Unity.Mathematics.float2>::get_Item(int)  /*0x0A0000D1*/
    IL_0020: ldarg.0
    IL_0021: ldfld NativeArray.ReadOnly<float2> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionScales  /*0x0400008C*/
    IL_0026: stloc.2
    IL_0027: ldloca.s 2
    IL_0029: ldarg.2
    IL_002a: call !0 Unity.Collections.NativeArray.ReadOnly<Unity.Mathematics.float2>::get_Item(int)  /*0x0A0000D1*/
    IL_002f: call float2 KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::TransformPointPositionToVisionPosition(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x0600008E*/
    IL_0034: stloc.0
    IL_0035: ldarg.0
    IL_0036: ldfld NativeArray.ReadOnly<uint> KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::VisionShapesAndLayers  /*0x04000089*/
    IL_003b: stloc.3
    IL_003c: ldloca.s 3
    IL_003e: ldarg.2
    IL_003f: call !0 Unity.Collections.NativeArray.ReadOnly<uint>::get_Item(int)  /*0x0A0000CA*/
    IL_0044: ldc.i4.3
    IL_0045: and
    IL_0046: stloc.1
    IL_0047: ldloc.1
    IL_0048: switch (IL_005b, IL_0066, IL_0071)
    IL_0059: br.s IL_007c
    IL_005b: ldarg.0
    IL_005c: ldloc.0
    IL_005d: call bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInCircle(Unity.Mathematics.float2)  /*0x0600008F*/
    IL_0062: stloc.s 4
    IL_0064: br.s IL_007f
    IL_0066: ldarg.0
    IL_0067: ldloc.0
    IL_0068: call bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInSquare(Unity.Mathematics.float2)  /*0x06000090*/
    IL_006d: stloc.s 4
    IL_006f: br.s IL_007f
    IL_0071: ldarg.0
    IL_0072: ldloc.0
    IL_0073: call bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInTriangle(Unity.Mathematics.float2)  /*0x06000092*/
    IL_0078: stloc.s 4
    IL_007a: br.s IL_007f
    IL_007c: ldc.i4.0
    IL_007d: stloc.s 4
    IL_007f: ldloc.s 4
    IL_0081: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::TransformPointPositionToVisionPosition(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  // token 0x0600008E rva 0x4130 attrs Private, HideBySig
    // code size 96 (0x60), max stack 4, init locals
    .locals ([0] float, [1] float, [2] float2)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::OrientationXZ  /*0x04000085*/
    IL_0006: brtrue.s IL_0011
    IL_0008: ldarg.3
    IL_0009: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_000e: neg
    IL_000f: br.s IL_0017
    IL_0011: ldarg.3
    IL_0012: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_0017: stloc.0
    IL_0018: ldarg.3
    IL_0019: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_001e: stloc.1
    IL_001f: ldarg.1
    IL_0020: ldarg.2
    IL_0021: call float2 Unity.Mathematics.float2::op_Subtraction(Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x0A0000D4*/
    IL_0026: stloc.2
    IL_0027: ldloc.2
    IL_0028: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_002d: ldloc.1
    IL_002e: mul
    IL_002f: ldloc.2
    IL_0030: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0035: ldloc.0
    IL_0036: mul
    IL_0037: sub
    IL_0038: ldloc.2
    IL_0039: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_003e: ldloc.0
    IL_003f: mul
    IL_0040: ldloc.2
    IL_0041: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0046: ldloc.1
    IL_0047: mul
    IL_0048: add
    IL_0049: newobj void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_004e: ldarg.s 4
    IL_0050: ldc.r4 0.5f
    IL_0055: call float2 Unity.Mathematics.float2::op_Multiply(Unity.Mathematics.float2,float)  /*0x0A0000D6*/
    IL_005a: call float2 Unity.Mathematics.float2::op_Division(Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x0A0000D7*/
    IL_005f: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInCircle(Unity.Mathematics.float2)  // token 0x0600008F rva 0x419c attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.1
    IL_0001: call float Unity.Mathematics.math::lengthsq(Unity.Mathematics.float2)  /*0x0A0000D8*/
    IL_0006: ldc.r4 1f
    IL_000b: cgt.un
    IL_000d: ldc.i4.0
    IL_000e: ceq
    IL_0010: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInSquare(Unity.Mathematics.float2)  // token 0x06000090 rva 0x41ae attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_0006: call float Unity.Mathematics.math::abs(float)  /*0x0A0000D9*/
    IL_000b: ldc.r4 1f
    IL_0010: bgt.un.s IL_0028
    IL_0012: ldarg.1
    IL_0013: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0018: call float Unity.Mathematics.math::abs(float)  /*0x0A0000D9*/
    IL_001d: ldc.r4 1f
    IL_0022: cgt.un
    IL_0024: ldc.i4.0
    IL_0025: ceq
    IL_0027: ret
    IL_0028: ldc.i4.0
    IL_0029: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::EdgeFunction(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  // token 0x06000091 rva 0x41d9 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.3
    IL_0001: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_0006: ldarg.1
    IL_0007: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_000c: sub
    IL_000d: ldarg.2
    IL_000e: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0013: ldarg.1
    IL_0014: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0019: sub
    IL_001a: mul
    IL_001b: ldarg.3
    IL_001c: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0021: ldarg.1
    IL_0022: ldfld float Unity.Mathematics.float2::y  /*0x0A0000D3*/
    IL_0027: sub
    IL_0028: ldarg.2
    IL_0029: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_002e: ldarg.1
    IL_002f: ldfld float Unity.Mathematics.float2::x  /*0x0A0000D2*/
    IL_0034: sub
    IL_0035: mul
    IL_0036: sub
    IL_0037: ret

  .method KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::IsInTriangle(Unity.Mathematics.float2)  // token 0x06000092 rva 0x4214 attrs Private, HideBySig
    // code size 111 (0x6f), max stack 5, init locals
    .locals ([0] float2, [1] float2, [2] float2, [3] float, [4] float)
    IL_0000: ldloca.s 0
    IL_0002: ldc.r4 0f
    IL_0007: ldc.r4 1f
    IL_000c: call void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_0011: ldloca.s 1
    IL_0013: ldc.r4 1f
    IL_0018: ldc.r4 -1f
    IL_001d: call void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_0022: ldloca.s 2
    IL_0024: ldc.r4 -1f
    IL_0029: ldc.r4 -1f
    IL_002e: call void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_0033: ldarg.0
    IL_0034: ldloc.1
    IL_0035: ldloc.2
    IL_0036: ldarg.1
    IL_0037: call float KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::EdgeFunction(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x06000091*/
    IL_003c: ldarg.0
    IL_003d: ldloc.2
    IL_003e: ldloc.0
    IL_003f: ldarg.1
    IL_0040: call float KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::EdgeFunction(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x06000091*/
    IL_0045: stloc.3
    IL_0046: ldarg.0
    IL_0047: ldloc.0
    IL_0048: ldloc.1
    IL_0049: ldarg.1
    IL_004a: call float KB.FogRTS.Runtime.CheckPointContainer.CheckIsInVisionJob::EdgeFunction(Unity.Mathematics.float2,Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x06000091*/
    IL_004f: stloc.s 4
    IL_0051: ldc.r4 0f
    IL_0056: blt.un.s IL_006d
    IL_0058: ldloc.3
    IL_0059: ldc.r4 0f
    IL_005e: blt.un.s IL_006d
    IL_0060: ldloc.s 4
    IL_0062: ldc.r4 0f
    IL_0067: clt.un
    IL_0069: ldc.i4.0
    IL_006a: ceq
    IL_006c: ret
    IL_006d: ldc.i4.0
    IL_006e: ret

