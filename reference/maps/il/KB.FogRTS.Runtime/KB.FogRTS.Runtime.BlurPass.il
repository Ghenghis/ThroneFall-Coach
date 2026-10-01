// ===== KB.FogRTS.Runtime.BlurPass  (token 0x02000008) =====
  .method KB.FogRTS.Runtime.BlurPass::Init(float,UnityEngine.Vector2Int,UnityEngine.FilterMode,UnityEngine.Rendering.RTHandle)  // token 0x0600002B rva 0x2a40 attrs Assembly, HideBySig
    // code size 148 (0x94), max stack 5, init locals
    .locals ([0] float[], [1] float, [2] int, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.2
    IL_0002: ldc.i4.6
    IL_0003: ldarg.3
    IL_0004: ldc.i4.0
    IL_0005: call RTHandle KB.FogRTS.Runtime.RTHandleHelper::CreateRT(UnityEngine.Vector2Int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,bool)  /*0x06000065*/
    IL_000a: stfld RTHandle KB.FogRTS.Runtime.BlurPass::tempBlur  /*0x04000026*/
    IL_000f: ldarg.0
    IL_0010: ldarg.2
    IL_0011: ldc.i4.6
    IL_0012: ldarg.3
    IL_0013: ldc.i4.0
    IL_0014: call RTHandle KB.FogRTS.Runtime.RTHandleHelper::CreateRT(UnityEngine.Vector2Int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,bool)  /*0x06000065*/
    IL_0019: stfld RTHandle KB.FogRTS.Runtime.BlurPass::blurred  /*0x04000027*/
    IL_001e: ldarg.0
    IL_001f: ldarg.s 4
    IL_0021: stfld RTHandle KB.FogRTS.Runtime.BlurPass::sourceRef  /*0x04000028*/
    IL_0026: ldc.i4.7
    IL_0027: newarr System.Single  /*0x01000052*/
    IL_002c: stloc.0
    IL_002d: ldc.r4 0f
    IL_0032: stloc.1
    IL_0033: ldc.i4.0
    IL_0034: stloc.2
    IL_0035: br.s IL_005c
    IL_0037: ldloc.2
    IL_0038: ldc.i4.3
    IL_0039: sub
    IL_003a: stloc.3
    IL_003b: ldloc.0
    IL_003c: ldloc.2
    IL_003d: ldloc.3
    IL_003e: ldloc.3
    IL_003f: mul
    IL_0040: neg
    IL_0041: conv.r4
    IL_0042: ldc.r4 2f
    IL_0047: ldarg.1
    IL_0048: mul
    IL_0049: ldarg.1
    IL_004a: mul
    IL_004b: div
    IL_004c: call float UnityEngine.Mathf::Exp(float)  /*0x0A00004D*/
    IL_0051: stelem.r4
    IL_0052: ldloc.1
    IL_0053: ldloc.0
    IL_0054: ldloc.2
    IL_0055: ldelem.r4
    IL_0056: add
    IL_0057: stloc.1
    IL_0058: ldloc.2
    IL_0059: ldc.i4.1
    IL_005a: add
    IL_005b: stloc.2
    IL_005c: ldloc.2
    IL_005d: ldc.i4.7
    IL_005e: blt.s IL_0037
    IL_0060: ldc.i4.0
    IL_0061: stloc.s 4
    IL_0063: br.s IL_0078
    IL_0065: ldloc.0
    IL_0066: ldloc.s 4
    IL_0068: ldelema System.Single  /*0x01000052*/
    IL_006d: dup
    IL_006e: ldind.r4
    IL_006f: ldloc.1
    IL_0070: div
    IL_0071: stind.r4
    IL_0072: ldloc.s 4
    IL_0074: ldc.i4.1
    IL_0075: add
    IL_0076: stloc.s 4
    IL_0078: ldloc.s 4
    IL_007a: ldc.i4.7
    IL_007b: blt.s IL_0065
    IL_007d: call Material KB.FogRTS.Runtime.FogResources::GetBlitGaussianBlur()  /*0x06000056*/
    IL_0082: ldstr "_GaussianWeights"
    IL_0087: ldloc.0
    IL_0088: callvirt void UnityEngine.Material::SetFloatArray(string,float[])  /*0x0A00004E*/
    IL_008d: ldarg.0
    IL_008e: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::blurred  /*0x04000027*/
    IL_0093: ret

  .method KB.FogRTS.Runtime.BlurPass::MarkForExecution()  // token 0x0600002C rva 0x2ae0 attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool KB.FogRTS.Runtime.BlurPass::canPerform  /*0x04000029*/
    IL_0007: ret

  .method KB.FogRTS.Runtime.BlurPass::Enable()  // token 0x0600002D rva 0x2ae9 attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KB.FogRTS.Runtime.BlurPass::PerformBlur(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  /*0x06000030*/
    IL_0007: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>::.ctor(object,IntPtr)  /*0x0A00004F*/
    IL_000c: call void UnityEngine.Rendering.RenderPipelineManager::add_beginContextRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>)  /*0x0A000050*/
    IL_0011: ret

  .method KB.FogRTS.Runtime.BlurPass::Disable()  // token 0x0600002E rva 0x2afc attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KB.FogRTS.Runtime.BlurPass::PerformBlur(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  /*0x06000030*/
    IL_0007: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>::.ctor(object,IntPtr)  /*0x0A00004F*/
    IL_000c: call void UnityEngine.Rendering.RenderPipelineManager::remove_beginContextRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>)  /*0x0A000051*/
    IL_0011: ret

  .method KB.FogRTS.Runtime.BlurPass::Dispose()  // token 0x0600002F rva 0x2b0f attrs Assembly, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::tempBlur  /*0x04000026*/
    IL_0006: callvirt void UnityEngine.Rendering.RTHandle::Release()  /*0x0A000052*/
    IL_000b: ldarg.0
    IL_000c: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::blurred  /*0x04000027*/
    IL_0011: callvirt void UnityEngine.Rendering.RTHandle::Release()  /*0x0A000052*/
    IL_0016: ret

  .method KB.FogRTS.Runtime.BlurPass::PerformBlur(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  // token 0x06000030 rva 0x2b28 attrs Private, HideBySig
    // code size 130 (0x82), max stack 6, init locals
    .locals ([0] CommandBuffer)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.BlurPass::canPerform  /*0x04000029*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.0
    IL_000b: stfld bool KB.FogRTS.Runtime.BlurPass::canPerform  /*0x04000029*/
    IL_0010: ldstr "Fog Blur"
    IL_0015: call CommandBuffer UnityEngine.Rendering.CommandBufferPool::Get(string)  /*0x0A000053*/
    IL_001a: stloc.0
    IL_001b: ldloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::tempBlur  /*0x04000026*/
    IL_0022: ldc.i4.0
    IL_0023: ldc.i4.0
    IL_0024: ldc.i4.m1
    IL_0025: ldc.i4.m1
    IL_0026: call void UnityEngine.Rendering.CoreUtils::SetRenderTarget(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RTHandle,UnityEngine.Rendering.ClearFlag,int,UnityEngine.CubemapFace,int)  /*0x0A000054*/
    IL_002b: ldloc.0
    IL_002c: ldarg.0
    IL_002d: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::sourceRef  /*0x04000028*/
    IL_0032: call Vector2 UnityEngine.Vector2::get_one()  /*0x0A000055*/
    IL_0037: call Vector4 UnityEngine.Vector4::op_Implicit(UnityEngine.Vector2)  /*0x0A000056*/
    IL_003c: call Material KB.FogRTS.Runtime.FogResources::GetBlitGaussianBlur()  /*0x06000056*/
    IL_0041: ldc.i4.0
    IL_0042: call void UnityEngine.Rendering.Blitter::BlitTexture(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RTHandle,UnityEngine.Vector4,UnityEngine.Material,int)  /*0x0A000057*/
    IL_0047: ldloc.0
    IL_0048: ldarg.0
    IL_0049: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::blurred  /*0x04000027*/
    IL_004e: ldc.i4.0
    IL_004f: ldc.i4.0
    IL_0050: ldc.i4.m1
    IL_0051: ldc.i4.m1
    IL_0052: call void UnityEngine.Rendering.CoreUtils::SetRenderTarget(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RTHandle,UnityEngine.Rendering.ClearFlag,int,UnityEngine.CubemapFace,int)  /*0x0A000054*/
    IL_0057: ldloc.0
    IL_0058: ldarg.0
    IL_0059: ldfld RTHandle KB.FogRTS.Runtime.BlurPass::tempBlur  /*0x04000026*/
    IL_005e: call Vector2 UnityEngine.Vector2::get_one()  /*0x0A000055*/
    IL_0063: call Vector4 UnityEngine.Vector4::op_Implicit(UnityEngine.Vector2)  /*0x0A000056*/
    IL_0068: call Material KB.FogRTS.Runtime.FogResources::GetBlitGaussianBlur()  /*0x06000056*/
    IL_006d: ldc.i4.1
    IL_006e: call void UnityEngine.Rendering.Blitter::BlitTexture(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RTHandle,UnityEngine.Vector4,UnityEngine.Material,int)  /*0x0A000057*/
    IL_0073: ldarga.s 1
    IL_0075: ldloc.0
    IL_0076: call void UnityEngine.Rendering.ScriptableRenderContext::ExecuteCommandBuffer(UnityEngine.Rendering.CommandBuffer)  /*0x0A000058*/
    IL_007b: ldloc.0
    IL_007c: call void UnityEngine.Rendering.CommandBufferPool::Release(UnityEngine.Rendering.CommandBuffer)  /*0x0A000059*/
    IL_0081: ret

  .method KB.FogRTS.Runtime.BlurPass::.ctor()  // token 0x06000031 rva 0x2bb6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000011*/
    IL_0006: ret

