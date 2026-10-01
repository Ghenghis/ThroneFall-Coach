// ===== KB.FogRTS.Runtime.VisionContainer  (token 0x02000007) =====
  .method KB.FogRTS.Runtime.VisionContainer::get_Count()  // token 0x0600001B rva 0x2579 attrs Assembly, Static, HideBySig, SpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: ldfld int KB.FogRTS.Runtime.VisionContainer::elementCountWhenJobStarted  /*0x04000025*/
    IL_000a: ret

  .method KB.FogRTS.Runtime.VisionContainer::get_ShapesAndLayers()  // token 0x0600001C rva 0x2585 attrs Assembly, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: ldflda NativeArray<uint> KB.FogRTS.Runtime.VisionContainer::shapesAndLayers  /*0x0400001C*/
    IL_000a: call NativeArray.ReadOnly<!0> Unity.Collections.NativeArray<uint>::AsReadOnly()  /*0x0A00003E*/
    IL_000f: ret

  .method KB.FogRTS.Runtime.VisionContainer::get_Positions()  // token 0x0600001D rva 0x2596 attrs Assembly, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::worldPositions  /*0x0400001A*/
    IL_000a: call NativeArray.ReadOnly<!0> Unity.Collections.NativeArray<Unity.Mathematics.float2>::AsReadOnly()  /*0x0A00003F*/
    IL_000f: ret

  .method KB.FogRTS.Runtime.VisionContainer::get_Rotations()  // token 0x0600001E rva 0x25a7 attrs Assembly, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::rotations  /*0x0400001B*/
    IL_000a: call NativeArray.ReadOnly<!0> Unity.Collections.NativeArray<Unity.Mathematics.float2>::AsReadOnly()  /*0x0A00003F*/
    IL_000f: ret

  .method KB.FogRTS.Runtime.VisionContainer::get_Scales()  // token 0x0600001F rva 0x25b8 attrs Assembly, Static, HideBySig, SpecialName
    // code size 16 (0x10), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::scales  /*0x0400001F*/
    IL_000a: call NativeArray.ReadOnly<!0> Unity.Collections.NativeArray<Unity.Mathematics.float2>::AsReadOnly()  /*0x0A00003F*/
    IL_000f: ret

  .method KB.FogRTS.Runtime.VisionContainer::get_CurrentElementCount()  // token 0x06000020 rva 0x25c9 attrs Private, HideBySig, SpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_0006: callvirt int System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Count()  /*0x0A000040*/
    IL_000b: ldarg.0
    IL_000c: ldfld int KB.FogRTS.Runtime.VisionContainer::maxElements  /*0x04000016*/
    IL_0011: call int UnityEngine.Mathf::Min(int,int)  /*0x0A000020*/
    IL_0016: ret

  .method KB.FogRTS.Runtime.VisionContainer::Init(int,bool)  // token 0x06000021 rva 0x25e4 attrs Assembly, Static, HideBySig
    // code size 296 (0x128), max stack 4, init locals
    .locals ([0] VisionContainer)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld bool KB.FogRTS.Runtime.VisionContainer::inited  /*0x04000015*/
    IL_000c: brfalse.s IL_0016
    IL_000e: ldloc.0
    IL_000f: callvirt void KB.FogRTS.Runtime.VisionContainer::Dispose()  /*0x06000028*/
    IL_0014: br.s IL_001d
    IL_0016: ldloc.0
    IL_0017: ldc.i4.1
    IL_0018: stfld bool KB.FogRTS.Runtime.VisionContainer::inited  /*0x04000015*/
    IL_001d: ldloc.0
    IL_001e: ldarg.0
    IL_001f: stfld int KB.FogRTS.Runtime.VisionContainer::maxElements  /*0x04000016*/
    IL_0024: ldloc.0
    IL_0025: ldarg.1
    IL_0026: stfld bool KB.FogRTS.Runtime.VisionContainer::orientationXZ  /*0x04000017*/
    IL_002b: ldloc.0
    IL_002c: ldarg.0
    IL_002d: newarr UnityEngine.Transform  /*0x0100000C*/
    IL_0032: stfld Transform[] KB.FogRTS.Runtime.VisionContainer::transforms  /*0x04000018*/
    IL_0037: ldloc.0
    IL_0038: ldarg.0
    IL_0039: ldc.i4.1
    IL_003a: newobj void UnityEngine.Jobs.TransformAccessArray::.ctor(int,int)  /*0x0A000016*/
    IL_003f: stfld TransformAccessArray KB.FogRTS.Runtime.VisionContainer::transformAccessArray  /*0x04000019*/
    IL_0044: ldloc.0
    IL_0045: ldarg.0
    IL_0046: ldc.i4.4
    IL_0047: ldc.i4.1
    IL_0048: newobj void Unity.Collections.NativeArray<Unity.Mathematics.float2>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000017*/
    IL_004d: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::worldPositions  /*0x0400001A*/
    IL_0052: ldloc.0
    IL_0053: ldarg.0
    IL_0054: ldc.i4.4
    IL_0055: ldc.i4.1
    IL_0056: newobj void Unity.Collections.NativeArray<Unity.Mathematics.float2>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000017*/
    IL_005b: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::rotations  /*0x0400001B*/
    IL_0060: ldloc.0
    IL_0061: ldarg.0
    IL_0062: ldc.i4.4
    IL_0063: ldc.i4.1
    IL_0064: newobj void Unity.Collections.NativeArray<uint>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000018*/
    IL_0069: stfld NativeArray<uint> KB.FogRTS.Runtime.VisionContainer::shapesAndLayers  /*0x0400001C*/
    IL_006e: ldloc.0
    IL_006f: ldarg.0
    IL_0070: ldc.i4.4
    IL_0071: ldc.i4.1
    IL_0072: newobj void Unity.Collections.NativeArray<Unity.Mathematics.float2>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000017*/
    IL_0077: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::positionOffsets  /*0x0400001D*/
    IL_007c: ldloc.0
    IL_007d: ldarg.0
    IL_007e: ldc.i4.4
    IL_007f: ldc.i4.1
    IL_0080: newobj void Unity.Collections.NativeArray<float>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000041*/
    IL_0085: stfld NativeArray<float> KB.FogRTS.Runtime.VisionContainer::rotationOffsets  /*0x0400001E*/
    IL_008a: ldloc.0
    IL_008b: ldarg.0
    IL_008c: ldc.i4.4
    IL_008d: ldc.i4.1
    IL_008e: newobj void Unity.Collections.NativeArray<Unity.Mathematics.float2>::.ctor(int,Unity.Collections.Allocator,Unity.Collections.NativeArrayOptions)  /*0x0A000017*/
    IL_0093: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::scales  /*0x0400001F*/
    IL_0098: ldloc.0
    IL_0099: ldarg.0
    IL_009a: ldc.i4.4
    IL_009b: newobj void UnityEngine.ComputeBuffer::.ctor(int,int)  /*0x0A000042*/
    IL_00a0: stfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionShapesAndLayerBuffer  /*0x04000020*/
    IL_00a5: ldloc.0
    IL_00a6: ldarg.0
    IL_00a7: ldc.i4.8
    IL_00a8: newobj void UnityEngine.ComputeBuffer::.ctor(int,int)  /*0x0A000042*/
    IL_00ad: stfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionPositionsBuffer  /*0x04000021*/
    IL_00b2: ldloc.0
    IL_00b3: ldarg.0
    IL_00b4: ldc.i4.8
    IL_00b5: newobj void UnityEngine.ComputeBuffer::.ctor(int,int)  /*0x0A000042*/
    IL_00ba: stfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionRotationsBuffer  /*0x04000022*/
    IL_00bf: ldloc.0
    IL_00c0: ldarg.0
    IL_00c1: ldc.i4.8
    IL_00c2: newobj void UnityEngine.ComputeBuffer::.ctor(int,int)  /*0x0A000042*/
    IL_00c7: stfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionScalesBuffer  /*0x04000023*/
    IL_00cc: call Material KB.FogRTS.Runtime.FogResources::GetVision()  /*0x06000055*/
    IL_00d1: ldstr "_VisionShapesAndLayers"
    IL_00d6: ldloc.0
    IL_00d7: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionShapesAndLayerBuffer  /*0x04000020*/
    IL_00dc: callvirt void UnityEngine.Material::SetBuffer(string,UnityEngine.ComputeBuffer)  /*0x0A000043*/
    IL_00e1: call Material KB.FogRTS.Runtime.FogResources::GetVision()  /*0x06000055*/
    IL_00e6: ldstr "_VisionPositions"
    IL_00eb: ldloc.0
    IL_00ec: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionPositionsBuffer  /*0x04000021*/
    IL_00f1: callvirt void UnityEngine.Material::SetBuffer(string,UnityEngine.ComputeBuffer)  /*0x0A000043*/
    IL_00f6: call Material KB.FogRTS.Runtime.FogResources::GetVision()  /*0x06000055*/
    IL_00fb: ldstr "_VisionRotations"
    IL_0100: ldloc.0
    IL_0101: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionRotationsBuffer  /*0x04000022*/
    IL_0106: callvirt void UnityEngine.Material::SetBuffer(string,UnityEngine.ComputeBuffer)  /*0x0A000043*/
    IL_010b: call Material KB.FogRTS.Runtime.FogResources::GetVision()  /*0x06000055*/
    IL_0110: ldstr "_VisionScales"
    IL_0115: ldloc.0
    IL_0116: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionScalesBuffer  /*0x04000023*/
    IL_011b: callvirt void UnityEngine.Material::SetBuffer(string,UnityEngine.ComputeBuffer)  /*0x0A000043*/
    IL_0120: ldloc.0
    IL_0121: ldc.i4.2
    IL_0122: stfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0127: ret

  .method KB.FogRTS.Runtime.VisionContainer::Add(KB.FogRTS.Runtime.VisionSource)  // token 0x06000022 rva 0x2718 attrs Assembly, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: dup
    IL_0006: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_000b: ldarg.0
    IL_000c: callvirt void System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::Add(!0)  /*0x0A000044*/
    IL_0011: ldc.i4.2
    IL_0012: stfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0017: ret

  .method KB.FogRTS.Runtime.VisionContainer::UpdateElement()  // token 0x06000023 rva 0x2734 attrs Assembly, Static, HideBySig
    // code size 22 (0x16), max stack 2, init locals
    .locals ([0] VisionContainer)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_000c: brtrue.s IL_0015
    IL_000e: ldloc.0
    IL_000f: ldc.i4.1
    IL_0010: stfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0015: ret

  .method KB.FogRTS.Runtime.VisionContainer::Remove(KB.FogRTS.Runtime.VisionSource)  // token 0x06000024 rva 0x2756 attrs Assembly, Static, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: dup
    IL_0006: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_000b: ldarg.0
    IL_000c: callvirt bool System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::Remove(!0)  /*0x0A000045*/
    IL_0011: pop
    IL_0012: ldc.i4.2
    IL_0013: stfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0018: ret

  .method KB.FogRTS.Runtime.VisionContainer::ScheduleJob()  // token 0x06000025 rva 0x2770 attrs Assembly, Static, HideBySig
    // code size 155 (0x9b), max stack 4, init locals
    .locals ([0] VisionContainer, [1] int, [2] VisionContainer.SetPositionsAndRotationsJob, [3] JobHandle)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_000c: brfalse.s IL_0024
    IL_000e: ldloc.0
    IL_000f: ldloc.0
    IL_0010: ldfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0015: ldc.i4.2
    IL_0016: ceq
    IL_0018: callvirt void KB.FogRTS.Runtime.VisionContainer::Setup(bool)  /*0x06000027*/
    IL_001d: ldloc.0
    IL_001e: ldc.i4.0
    IL_001f: stfld VisionContainer.Modification KB.FogRTS.Runtime.VisionContainer::modified  /*0x04000024*/
    IL_0024: ldloc.0
    IL_0025: callvirt int KB.FogRTS.Runtime.VisionContainer::get_CurrentElementCount()  /*0x06000020*/
    IL_002a: stloc.1
    IL_002b: ldloc.0
    IL_002c: ldloc.1
    IL_002d: stfld int KB.FogRTS.Runtime.VisionContainer::elementCountWhenJobStarted  /*0x04000025*/
    IL_0032: ldloca.s 2
    IL_0034: initobj KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob  /*0x0200001A*/
    IL_003a: ldloca.s 2
    IL_003c: ldloc.1
    IL_003d: stfld int KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::VisionCount  /*0x04000092*/
    IL_0042: ldloca.s 2
    IL_0044: ldloc.0
    IL_0045: ldfld bool KB.FogRTS.Runtime.VisionContainer::orientationXZ  /*0x04000017*/
    IL_004a: stfld bool KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::OrientationXZ  /*0x04000093*/
    IL_004f: ldloca.s 2
    IL_0051: ldloc.0
    IL_0052: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::positionOffsets  /*0x0400001D*/
    IL_0057: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::PositionOffsets  /*0x04000094*/
    IL_005c: ldloca.s 2
    IL_005e: ldloc.0
    IL_005f: ldfld NativeArray<float> KB.FogRTS.Runtime.VisionContainer::rotationOffsets  /*0x0400001E*/
    IL_0064: stfld NativeArray<float> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::RotationOffsets  /*0x04000095*/
    IL_0069: ldloca.s 2
    IL_006b: ldloc.0
    IL_006c: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::worldPositions  /*0x0400001A*/
    IL_0071: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::WorldPositions  /*0x04000096*/
    IL_0076: ldloca.s 2
    IL_0078: ldloc.0
    IL_0079: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::rotations  /*0x0400001B*/
    IL_007e: stfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::Rotations  /*0x04000097*/
    IL_0083: ldloc.2
    IL_0084: ldloc.0
    IL_0085: ldfld TransformAccessArray KB.FogRTS.Runtime.VisionContainer::transformAccessArray  /*0x04000019*/
    IL_008a: ldc.i4.s 64
    IL_008c: ldloca.s 3
    IL_008e: initobj Unity.Jobs.JobHandle  /*0x01000012*/
    IL_0094: ldloc.3
    IL_0095: call JobHandle UnityEngine.Jobs.IJobParallelForTransformExtensions::ScheduleReadOnly(!!0,UnityEngine.Jobs.TransformAccessArray,int,Unity.Jobs.JobHandle)<KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob>  /*0x2B000004*/
    IL_009a: ret

  .method KB.FogRTS.Runtime.VisionContainer::UpdateVisionPositionsInShader()  // token 0x06000026 rva 0x2818 attrs Assembly, Static, HideBySig
    // code size 54 (0x36), max stack 5, init locals
    .locals ([0] VisionContainer, [1] int)
    IL_0000: call !0 KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::GetInstance()  /*0x0A00003D*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldfld int KB.FogRTS.Runtime.VisionContainer::elementCountWhenJobStarted  /*0x04000025*/
    IL_000c: stloc.1
    IL_000d: ldloc.0
    IL_000e: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionPositionsBuffer  /*0x04000021*/
    IL_0013: ldloc.0
    IL_0014: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::worldPositions  /*0x0400001A*/
    IL_0019: ldc.i4.0
    IL_001a: ldc.i4.0
    IL_001b: ldloc.1
    IL_001c: callvirt void UnityEngine.ComputeBuffer::SetData(Unity.Collections.NativeArray<!!0>,int,int,int)<Unity.Mathematics.float2>  /*0x2B000005*/
    IL_0021: ldloc.0
    IL_0022: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionRotationsBuffer  /*0x04000022*/
    IL_0027: ldloc.0
    IL_0028: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::rotations  /*0x0400001B*/
    IL_002d: ldc.i4.0
    IL_002e: ldc.i4.0
    IL_002f: ldloc.1
    IL_0030: callvirt void UnityEngine.ComputeBuffer::SetData(Unity.Collections.NativeArray<!!0>,int,int,int)<Unity.Mathematics.float2>  /*0x2B000005*/
    IL_0035: ret

  .method KB.FogRTS.Runtime.VisionContainer::Setup(bool)  // token 0x06000027 rva 0x285c attrs Private, HideBySig
    // code size 297 (0x129), max stack 5, init locals
    .locals ([0] int, [1] int, [2] bool, [3] uint, [4] uint)
    IL_0000: ldarg.0
    IL_0001: call int KB.FogRTS.Runtime.VisionContainer::get_CurrentElementCount()  /*0x06000020*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br IL_00e0
    IL_000e: ldloc.1
    IL_000f: ldloc.0
    IL_0010: clt
    IL_0012: stloc.2
    IL_0013: ldloc.2
    IL_0014: brfalse IL_00b6
    IL_0019: ldarg.0
    IL_001a: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_001f: ldloc.1
    IL_0020: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_0025: callvirt VisionSource.VisionShape KB.FogRTS.Runtime.VisionSource::get_Shape()  /*0x0600007A*/
    IL_002a: ldc.i4.3
    IL_002b: and
    IL_002c: stloc.3
    IL_002d: ldarg.0
    IL_002e: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_0033: ldloc.1
    IL_0034: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_0039: callvirt VisionLayer KB.FogRTS.Runtime.VisionSource::get_Layer()  /*0x0600007C*/
    IL_003e: ldc.i4.s 15
    IL_0040: and
    IL_0041: stloc.s 4
    IL_0043: ldarg.0
    IL_0044: ldflda NativeArray<uint> KB.FogRTS.Runtime.VisionContainer::shapesAndLayers  /*0x0400001C*/
    IL_0049: ldloc.1
    IL_004a: ldloc.3
    IL_004b: ldloc.s 4
    IL_004d: ldc.i4.2
    IL_004e: shl
    IL_004f: or
    IL_0050: call void Unity.Collections.NativeArray<uint>::set_Item(int,!0)  /*0x0A000024*/
    IL_0055: ldarg.0
    IL_0056: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::positionOffsets  /*0x0400001D*/
    IL_005b: ldloc.1
    IL_005c: ldarg.0
    IL_005d: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_0062: ldloc.1
    IL_0063: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_0068: callvirt Vector2 KB.FogRTS.Runtime.VisionSource::get_PositionOffset()  /*0x0600007E*/
    IL_006d: call float2 Unity.Mathematics.float2::op_Implicit(UnityEngine.Vector2)  /*0x0A000022*/
    IL_0072: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::set_Item(int,!0)  /*0x0A000023*/
    IL_0077: ldarg.0
    IL_0078: ldflda NativeArray<float> KB.FogRTS.Runtime.VisionContainer::rotationOffsets  /*0x0400001E*/
    IL_007d: ldloc.1
    IL_007e: ldarg.0
    IL_007f: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_0084: ldloc.1
    IL_0085: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_008a: callvirt float KB.FogRTS.Runtime.VisionSource::get_RotationOffset()  /*0x06000080*/
    IL_008f: call void Unity.Collections.NativeArray<float>::set_Item(int,!0)  /*0x0A000048*/
    IL_0094: ldarg.0
    IL_0095: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::scales  /*0x0400001F*/
    IL_009a: ldloc.1
    IL_009b: ldarg.0
    IL_009c: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_00a1: ldloc.1
    IL_00a2: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_00a7: callvirt Vector2 KB.FogRTS.Runtime.VisionSource::get_Scale()  /*0x06000082*/
    IL_00ac: call float2 Unity.Mathematics.float2::op_Implicit(UnityEngine.Vector2)  /*0x0A000022*/
    IL_00b1: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::set_Item(int,!0)  /*0x0A000023*/
    IL_00b6: ldarg.1
    IL_00b7: brfalse.s IL_00dc
    IL_00b9: ldarg.0
    IL_00ba: ldfld Transform[] KB.FogRTS.Runtime.VisionContainer::transforms  /*0x04000018*/
    IL_00bf: ldloc.1
    IL_00c0: ldloc.2
    IL_00c1: brtrue.s IL_00ca
    IL_00c3: call Transform KB.FogRTS.Runtime.TransformHelper::get_DummyTransform()  /*0x06000066*/
    IL_00c8: br.s IL_00db
    IL_00ca: ldarg.0
    IL_00cb: ldfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_00d0: ldloc.1
    IL_00d1: callvirt !0 System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::get_Item(int)  /*0x0A000047*/
    IL_00d6: callvirt Transform KB.FogRTS.Runtime.VisionSource::get_Transform()  /*0x06000085*/
    IL_00db: stelem.ref
    IL_00dc: ldloc.1
    IL_00dd: ldc.i4.1
    IL_00de: add
    IL_00df: stloc.1
    IL_00e0: ldloc.1
    IL_00e1: ldarg.0
    IL_00e2: ldfld int KB.FogRTS.Runtime.VisionContainer::maxElements  /*0x04000016*/
    IL_00e7: blt IL_000e
    IL_00ec: ldarg.1
    IL_00ed: brfalse.s IL_0100
    IL_00ef: ldarg.0
    IL_00f0: ldflda TransformAccessArray KB.FogRTS.Runtime.VisionContainer::transformAccessArray  /*0x04000019*/
    IL_00f5: ldarg.0
    IL_00f6: ldfld Transform[] KB.FogRTS.Runtime.VisionContainer::transforms  /*0x04000018*/
    IL_00fb: call void UnityEngine.Jobs.TransformAccessArray::SetTransforms(UnityEngine.Transform[])  /*0x0A000025*/
    IL_0100: ldarg.0
    IL_0101: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionShapesAndLayerBuffer  /*0x04000020*/
    IL_0106: ldarg.0
    IL_0107: ldfld NativeArray<uint> KB.FogRTS.Runtime.VisionContainer::shapesAndLayers  /*0x0400001C*/
    IL_010c: ldc.i4.0
    IL_010d: ldc.i4.0
    IL_010e: ldloc.0
    IL_010f: callvirt void UnityEngine.ComputeBuffer::SetData(Unity.Collections.NativeArray<!!0>,int,int,int)<uint>  /*0x2B000006*/
    IL_0114: ldarg.0
    IL_0115: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionScalesBuffer  /*0x04000023*/
    IL_011a: ldarg.0
    IL_011b: ldfld NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::scales  /*0x0400001F*/
    IL_0120: ldc.i4.0
    IL_0121: ldc.i4.0
    IL_0122: ldloc.0
    IL_0123: callvirt void UnityEngine.ComputeBuffer::SetData(Unity.Collections.NativeArray<!!0>,int,int,int)<Unity.Mathematics.float2>  /*0x2B000005*/
    IL_0128: ret

  .method KB.FogRTS.Runtime.VisionContainer::Dispose()  // token 0x06000028 rva 0x2994 attrs Private, HideBySig
    // code size 122 (0x7a), max stack 1, init locals
    IL_0000: ldarg.0
    IL_0001: ldflda TransformAccessArray KB.FogRTS.Runtime.VisionContainer::transformAccessArray  /*0x04000019*/
    IL_0006: call void UnityEngine.Jobs.TransformAccessArray::Dispose()  /*0x0A000026*/
    IL_000b: ldarg.0
    IL_000c: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::worldPositions  /*0x0400001A*/
    IL_0011: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::Dispose()  /*0x0A000027*/
    IL_0016: ldarg.0
    IL_0017: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::rotations  /*0x0400001B*/
    IL_001c: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::Dispose()  /*0x0A000027*/
    IL_0021: ldarg.0
    IL_0022: ldflda NativeArray<uint> KB.FogRTS.Runtime.VisionContainer::shapesAndLayers  /*0x0400001C*/
    IL_0027: call void Unity.Collections.NativeArray<uint>::Dispose()  /*0x0A000028*/
    IL_002c: ldarg.0
    IL_002d: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::positionOffsets  /*0x0400001D*/
    IL_0032: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::Dispose()  /*0x0A000027*/
    IL_0037: ldarg.0
    IL_0038: ldflda NativeArray<float> KB.FogRTS.Runtime.VisionContainer::rotationOffsets  /*0x0400001E*/
    IL_003d: call void Unity.Collections.NativeArray<float>::Dispose()  /*0x0A000049*/
    IL_0042: ldarg.0
    IL_0043: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer::scales  /*0x0400001F*/
    IL_0048: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::Dispose()  /*0x0A000027*/
    IL_004d: ldarg.0
    IL_004e: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionShapesAndLayerBuffer  /*0x04000020*/
    IL_0053: callvirt void UnityEngine.ComputeBuffer::Dispose()  /*0x0A00004A*/
    IL_0058: ldarg.0
    IL_0059: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionPositionsBuffer  /*0x04000021*/
    IL_005e: callvirt void UnityEngine.ComputeBuffer::Dispose()  /*0x0A00004A*/
    IL_0063: ldarg.0
    IL_0064: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionRotationsBuffer  /*0x04000022*/
    IL_0069: callvirt void UnityEngine.ComputeBuffer::Dispose()  /*0x0A00004A*/
    IL_006e: ldarg.0
    IL_006f: ldfld ComputeBuffer KB.FogRTS.Runtime.VisionContainer::visionScalesBuffer  /*0x04000023*/
    IL_0074: callvirt void UnityEngine.ComputeBuffer::Dispose()  /*0x0A00004A*/
    IL_0079: ret

  .method KB.FogRTS.Runtime.VisionContainer::OnDestroy()  // token 0x06000029 rva 0x2a1a attrs Private, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.VisionContainer::inited  /*0x04000015*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void KB.FogRTS.Runtime.VisionContainer::Dispose()  /*0x06000028*/
    IL_000e: ret

  .method KB.FogRTS.Runtime.VisionContainer::.ctor()  // token 0x0600002A rva 0x2a2a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<KB.FogRTS.Runtime.VisionSource>::.ctor()  /*0x0A00004B*/
    IL_0006: stfld List<VisionSource> KB.FogRTS.Runtime.VisionContainer::visionSources  /*0x04000014*/
    IL_000b: ldarg.0
    IL_000c: call void KB.FogRTS.Runtime.SingletonContainer<KB.FogRTS.Runtime.VisionContainer>::.ctor()  /*0x0A00004C*/
    IL_0011: ret

// ===== KB.FogRTS.Runtime.VisionContainer/Modification  (token 0x02000019) =====
// ===== KB.FogRTS.Runtime.VisionContainer/SetPositionsAndRotationsJob  (token 0x0200001A) =====
  .method KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::Execute(int,UnityEngine.Jobs.TransformAccess)  // token 0x06000093 rva 0x4290 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 185 (0xb9), max stack 4, init locals
    .locals ([0] Vector3, [1] Quaternion, [2] float, [3] float, [4] float2, [5] float2)
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld int KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::VisionCount  /*0x04000092*/
    IL_0007: blt.s IL_000a
    IL_0009: ret
    IL_000a: ldarga.s 2
    IL_000c: ldloca.s 0
    IL_000e: ldloca.s 1
    IL_0010: call void UnityEngine.Jobs.TransformAccess::GetPositionAndRotation(ref UnityEngine.Vector3,ref UnityEngine.Quaternion)  /*0x0A0000C6*/
    IL_0015: ldarg.0
    IL_0016: ldfld bool KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::OrientationXZ  /*0x04000093*/
    IL_001b: ldloc.1
    IL_001c: call quaternion Unity.Mathematics.quaternion::op_Implicit(UnityEngine.Quaternion)  /*0x0A0000C8*/
    IL_0021: call float KB.FogRTS.Runtime.RotationHelper::QuaternionToAngle(bool,Unity.Mathematics.quaternion)  /*0x06000063*/
    IL_0026: ldarg.0
    IL_0027: ldflda NativeArray<float> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::RotationOffsets  /*0x04000095*/
    IL_002c: ldarg.1
    IL_002d: call !0 Unity.Collections.NativeArray<float>::get_Item(int)  /*0x0A0000DA*/
    IL_0032: call float Unity.Mathematics.math::radians(float)  /*0x0A0000DB*/
    IL_0037: add
    IL_0038: ldloca.s 2
    IL_003a: ldloca.s 3
    IL_003c: call void Unity.Mathematics.math::sincos(float,ref float,ref float)  /*0x0A0000CD*/
    IL_0041: ldarg.0
    IL_0042: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::PositionOffsets  /*0x04000094*/
    IL_0047: ldarg.1
    IL_0048: call !0 Unity.Collections.NativeArray<Unity.Mathematics.float2>::get_Item(int)  /*0x0A0000C9*/
    IL_004d: ldloc.2
    IL_004e: ldloc.3
    IL_004f: call float2 KB.FogRTS.Runtime.RotationHelper::Rotate2D(Unity.Mathematics.float2,float,float)  /*0x06000064*/
    IL_0054: stloc.s 4
    IL_0056: ldarg.0
    IL_0057: ldfld bool KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::OrientationXZ  /*0x04000093*/
    IL_005c: brtrue.s IL_0071
    IL_005e: ldloc.0
    IL_005f: ldfld float UnityEngine.Vector3::x  /*0x0A0000DC*/
    IL_0064: ldloc.0
    IL_0065: ldfld float UnityEngine.Vector3::y  /*0x0A0000DD*/
    IL_006a: newobj void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_006f: br.s IL_0082
    IL_0071: ldloc.0
    IL_0072: ldfld float UnityEngine.Vector3::x  /*0x0A0000DC*/
    IL_0077: ldloc.0
    IL_0078: ldfld float UnityEngine.Vector3::z  /*0x0A0000DE*/
    IL_007d: newobj void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_0082: stloc.s 5
    IL_0084: ldarg.0
    IL_0085: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::WorldPositions  /*0x04000096*/
    IL_008a: ldarg.1
    IL_008b: ldloc.s 5
    IL_008d: ldloc.s 4
    IL_008f: call float2 Unity.Mathematics.float2::op_Addition(Unity.Mathematics.float2,Unity.Mathematics.float2)  /*0x0A0000D0*/
    IL_0094: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::set_Item(int,!0)  /*0x0A000023*/
    IL_0099: ldarg.0
    IL_009a: ldflda NativeArray<float2> KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::Rotations  /*0x04000097*/
    IL_009f: ldarg.1
    IL_00a0: ldarg.0
    IL_00a1: ldfld bool KB.FogRTS.Runtime.VisionContainer.SetPositionsAndRotationsJob::OrientationXZ  /*0x04000093*/
    IL_00a6: brtrue.s IL_00ac
    IL_00a8: ldloc.2
    IL_00a9: neg
    IL_00aa: br.s IL_00ad
    IL_00ac: ldloc.2
    IL_00ad: ldloc.3
    IL_00ae: newobj void Unity.Mathematics.float2::.ctor(float,float)  /*0x0A0000D5*/
    IL_00b3: call void Unity.Collections.NativeArray<Unity.Mathematics.float2>::set_Item(int,!0)  /*0x0A000023*/
    IL_00b8: ret

