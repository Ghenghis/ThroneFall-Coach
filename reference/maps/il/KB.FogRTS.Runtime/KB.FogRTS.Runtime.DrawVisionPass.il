// ===== KB.FogRTS.Runtime.DrawVisionPass  (token 0x02000009) =====
  .method KB.FogRTS.Runtime.DrawVisionPass::Init(UnityEngine.Vector4,UnityEngine.Vector2Int,float,float,UnityEngine.Texture)  // token 0x06000032 rva 0x2bc0 attrs Assembly, HideBySig
    // code size 324 (0x144), max stack 7, init locals
    IL_0000: ldarg.0
    IL_0001: call Vector3 UnityEngine.Vector3::get_back()  /*0x0A00005A*/
    IL_0006: ldc.r4 0.02f
    IL_000b: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00005B*/
    IL_0010: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A00005C*/
    IL_0015: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A00005D*/
    IL_001a: call Matrix4x4 UnityEngine.Matrix4x4::TRS(UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A00005E*/
    IL_001f: stfld Matrix4x4 KB.FogRTS.Runtime.DrawVisionPass::view  /*0x0400002B*/
    IL_0024: ldarg.0
    IL_0025: ldarg.1
    IL_0026: ldfld float UnityEngine.Vector4::x  /*0x0A00005F*/
    IL_002b: ldarg.1
    IL_002c: ldfld float UnityEngine.Vector4::y  /*0x0A000060*/
    IL_0031: ldarg.1
    IL_0032: ldfld float UnityEngine.Vector4::z  /*0x0A000061*/
    IL_0037: ldarg.1
    IL_0038: ldfld float UnityEngine.Vector4::w  /*0x0A000062*/
    IL_003d: ldc.r4 0.019999f
    IL_0042: ldc.r4 0.020001f
    IL_0047: call Matrix4x4 UnityEngine.Matrix4x4::Ortho(float,float,float,float,float,float)  /*0x0A000063*/
    IL_004c: stfld Matrix4x4 KB.FogRTS.Runtime.DrawVisionPass::projection  /*0x0400002C*/
    IL_0051: ldarg.0
    IL_0052: ldarg.2
    IL_0053: ldc.i4.8
    IL_0054: ldc.i4.0
    IL_0055: ldc.i4.0
    IL_0056: call RTHandle KB.FogRTS.Runtime.RTHandleHelper::CreateRT(UnityEngine.Vector2Int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,bool)  /*0x06000065*/
    IL_005b: stfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::currentVision  /*0x0400002D*/
    IL_0060: ldarg.0
    IL_0061: ldarg.2
    IL_0062: ldc.i4.6
    IL_0063: ldc.i4.0
    IL_0064: ldc.i4.1
    IL_0065: call RTHandle KB.FogRTS.Runtime.RTHandleHelper::CreateRT(UnityEngine.Vector2Int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,bool)  /*0x06000065*/
    IL_006a: stfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::exploredAndVisibleState  /*0x0400002E*/
    IL_006f: ldarg.0
    IL_0070: ldarga.s 2
    IL_0072: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_0077: conv.r4
    IL_0078: ldc.r4 8f
    IL_007d: div
    IL_007e: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000065*/
    IL_0083: stfld int KB.FogRTS.Runtime.DrawVisionPass::threadGroupX  /*0x0400002F*/
    IL_0088: ldarg.0
    IL_0089: ldarga.s 2
    IL_008b: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0090: conv.r4
    IL_0091: ldc.r4 8f
    IL_0096: div
    IL_0097: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000065*/
    IL_009c: stfld int KB.FogRTS.Runtime.DrawVisionPass::threadGroupY  /*0x04000030*/
    IL_00a1: call ComputeShader KB.FogRTS.Runtime.FogResources::GetCalculateVision()  /*0x06000059*/
    IL_00a6: dup
    IL_00a7: ldc.i4.0
    IL_00a8: ldstr "Layers"
    IL_00ad: ldarg.s 5
    IL_00af: callvirt void UnityEngine.ComputeShader::SetTexture(int,string,UnityEngine.Texture)  /*0x0A000067*/
    IL_00b4: dup
    IL_00b5: ldc.i4.0
    IL_00b6: ldstr "VisionInput"
    IL_00bb: ldarg.0
    IL_00bc: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::currentVision  /*0x0400002D*/
    IL_00c1: call Texture UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A000068*/
    IL_00c6: callvirt void UnityEngine.ComputeShader::SetTexture(int,string,UnityEngine.Texture)  /*0x0A000067*/
    IL_00cb: dup
    IL_00cc: ldc.i4.0
    IL_00cd: ldstr "VisionState"
    IL_00d2: ldarg.0
    IL_00d3: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::exploredAndVisibleState  /*0x0400002E*/
    IL_00d8: call Texture UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A000068*/
    IL_00dd: callvirt void UnityEngine.ComputeShader::SetTexture(int,string,UnityEngine.Texture)  /*0x0A000067*/
    IL_00e2: dup
    IL_00e3: ldstr "LayerScale"
    IL_00e8: ldarg.s 5
    IL_00ea: callvirt int UnityEngine.Texture::get_width()  /*0x0A000069*/
    IL_00ef: conv.r4
    IL_00f0: ldarga.s 2
    IL_00f2: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_00f7: conv.r4
    IL_00f8: div
    IL_00f9: ldarg.s 5
    IL_00fb: callvirt int UnityEngine.Texture::get_height()  /*0x0A00006A*/
    IL_0100: conv.r4
    IL_0101: ldarga.s 2
    IL_0103: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_0108: conv.r4
    IL_0109: div
    IL_010a: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_010f: call Vector4 UnityEngine.Vector4::op_Implicit(UnityEngine.Vector2)  /*0x0A000056*/
    IL_0114: callvirt void UnityEngine.ComputeShader::SetVector(string,UnityEngine.Vector4)  /*0x0A00006C*/
    IL_0119: dup
    IL_011a: ldstr "FadeInSpeed"
    IL_011f: ldc.r4 1f
    IL_0124: ldarg.3
    IL_0125: div
    IL_0126: callvirt void UnityEngine.ComputeShader::SetFloat(string,float)  /*0x0A00006D*/
    IL_012b: ldstr "FadeOutSpeed"
    IL_0130: ldc.r4 1f
    IL_0135: ldarg.s 4
    IL_0137: div
    IL_0138: callvirt void UnityEngine.ComputeShader::SetFloat(string,float)  /*0x0A00006D*/
    IL_013d: ldarg.0
    IL_013e: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::exploredAndVisibleState  /*0x0400002E*/
    IL_0143: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::MarkForExecution()  // token 0x06000033 rva 0x2d10 attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool KB.FogRTS.Runtime.DrawVisionPass::canPerform  /*0x04000031*/
    IL_0007: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::Enable()  // token 0x06000034 rva 0x2d19 attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KB.FogRTS.Runtime.DrawVisionPass::PerformVision(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  /*0x06000037*/
    IL_0007: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>::.ctor(object,IntPtr)  /*0x0A00004F*/
    IL_000c: call void UnityEngine.Rendering.RenderPipelineManager::add_beginContextRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>)  /*0x0A000050*/
    IL_0011: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::Disable()  // token 0x06000035 rva 0x2d2c attrs Assembly, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldftn void KB.FogRTS.Runtime.DrawVisionPass::PerformVision(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  /*0x06000037*/
    IL_0007: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>::.ctor(object,IntPtr)  /*0x0A00004F*/
    IL_000c: call void UnityEngine.Rendering.RenderPipelineManager::remove_beginContextRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, System.Collections.Generic.List<UnityEngine.Camera>>)  /*0x0A000051*/
    IL_0011: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::Dispose()  // token 0x06000036 rva 0x2d3f attrs Assembly, HideBySig
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::currentVision  /*0x0400002D*/
    IL_0006: callvirt void UnityEngine.Rendering.RTHandle::Release()  /*0x0A000052*/
    IL_000b: ldarg.0
    IL_000c: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::exploredAndVisibleState  /*0x0400002E*/
    IL_0011: callvirt void UnityEngine.Rendering.RTHandle::Release()  /*0x0A000052*/
    IL_0016: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::PerformVision(UnityEngine.Rendering.ScriptableRenderContext,System.Collections.Generic.List<UnityEngine.Camera>)  // token 0x06000037 rva 0x2d58 attrs Private, HideBySig
    // code size 186 (0xba), max stack 7, init locals
    .locals ([0] float, [1] CommandBuffer, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool KB.FogRTS.Runtime.DrawVisionPass::canPerform  /*0x04000031*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldc.i4.0
    IL_000b: stfld bool KB.FogRTS.Runtime.DrawVisionPass::canPerform  /*0x04000031*/
    IL_0010: call float UnityEngine.Time::get_time()  /*0x0A00006E*/
    IL_0015: ldarg.0
    IL_0016: ldfld float KB.FogRTS.Runtime.DrawVisionPass::lastRefreshVisionTime  /*0x04000032*/
    IL_001b: sub
    IL_001c: stloc.0
    IL_001d: ldarg.0
    IL_001e: call float UnityEngine.Time::get_time()  /*0x0A00006E*/
    IL_0023: stfld float KB.FogRTS.Runtime.DrawVisionPass::lastRefreshVisionTime  /*0x04000032*/
    IL_0028: ldstr "Draw Fog Vision"
    IL_002d: call CommandBuffer UnityEngine.Rendering.CommandBufferPool::Get(string)  /*0x0A000053*/
    IL_0032: stloc.1
    IL_0033: ldloc.1
    IL_0034: ldarg.0
    IL_0035: ldfld RTHandle KB.FogRTS.Runtime.DrawVisionPass::currentVision  /*0x0400002D*/
    IL_003a: call RenderTargetIdentifier UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A00006F*/
    IL_003f: callvirt void UnityEngine.Rendering.CommandBuffer::SetRenderTarget(UnityEngine.Rendering.RenderTargetIdentifier)  /*0x0A000070*/
    IL_0044: ldloc.1
    IL_0045: ldc.i4.1
    IL_0046: ldc.i4.1
    IL_0047: call Color UnityEngine.Color::get_clear()  /*0x0A000071*/
    IL_004c: callvirt void UnityEngine.Rendering.CommandBuffer::ClearRenderTarget(bool,bool,UnityEngine.Color)  /*0x0A000072*/
    IL_0051: ldloc.1
    IL_0052: ldarg.0
    IL_0053: ldfld Matrix4x4 KB.FogRTS.Runtime.DrawVisionPass::view  /*0x0400002B*/
    IL_0058: ldarg.0
    IL_0059: ldfld Matrix4x4 KB.FogRTS.Runtime.DrawVisionPass::projection  /*0x0400002C*/
    IL_005e: callvirt void UnityEngine.Rendering.CommandBuffer::SetViewProjectionMatrices(UnityEngine.Matrix4x4,UnityEngine.Matrix4x4)  /*0x0A000073*/
    IL_0063: call int KB.FogRTS.Runtime.VisionContainer::get_Count()  /*0x0600001B*/
    IL_0068: stloc.2
    IL_0069: ldloc.2
    IL_006a: ldc.i4.0
    IL_006b: ble.s IL_0081
    IL_006d: ldloc.1
    IL_006e: call Mesh KB.FogRTS.Runtime.FogResources::GetQuad()  /*0x0600005B*/
    IL_0073: ldc.i4.0
    IL_0074: call Material KB.FogRTS.Runtime.FogResources::GetVision()  /*0x06000055*/
    IL_0079: ldc.i4.0
    IL_007a: ldloc.2
    IL_007b: ldnull
    IL_007c: callvirt void UnityEngine.Rendering.CommandBuffer::DrawMeshInstancedProcedural(UnityEngine.Mesh,int,UnityEngine.Material,int,int,UnityEngine.MaterialPropertyBlock)  /*0x0A000074*/
    IL_0081: call ComputeShader KB.FogRTS.Runtime.FogResources::GetCalculateVision()  /*0x06000059*/
    IL_0086: ldarg.0
    IL_0087: ldfld int KB.FogRTS.Runtime.DrawVisionPass::fogDeltaID  /*0x0400002A*/
    IL_008c: ldloc.0
    IL_008d: callvirt void UnityEngine.ComputeShader::SetFloat(int,float)  /*0x0A000075*/
    IL_0092: ldloc.1
    IL_0093: call ComputeShader KB.FogRTS.Runtime.FogResources::GetCalculateVision()  /*0x06000059*/
    IL_0098: ldc.i4.0
    IL_0099: ldarg.0
    IL_009a: ldfld int KB.FogRTS.Runtime.DrawVisionPass::threadGroupX  /*0x0400002F*/
    IL_009f: ldarg.0
    IL_00a0: ldfld int KB.FogRTS.Runtime.DrawVisionPass::threadGroupY  /*0x04000030*/
    IL_00a5: ldc.i4.1
    IL_00a6: callvirt void UnityEngine.Rendering.CommandBuffer::DispatchCompute(UnityEngine.ComputeShader,int,int,int,int)  /*0x0A000076*/
    IL_00ab: ldarga.s 1
    IL_00ad: ldloc.1
    IL_00ae: call void UnityEngine.Rendering.ScriptableRenderContext::ExecuteCommandBuffer(UnityEngine.Rendering.CommandBuffer)  /*0x0A000058*/
    IL_00b3: ldloc.1
    IL_00b4: call void UnityEngine.Rendering.CommandBufferPool::Release(UnityEngine.Rendering.CommandBuffer)  /*0x0A000059*/
    IL_00b9: ret

  .method KB.FogRTS.Runtime.DrawVisionPass::.ctor()  // token 0x06000038 rva 0x2e1e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 23 (0x17), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "Delta"
    IL_0006: call int UnityEngine.Shader::PropertyToID(string)  /*0x0A000077*/
    IL_000b: stfld int KB.FogRTS.Runtime.DrawVisionPass::fogDeltaID  /*0x0400002A*/
    IL_0010: ldarg.0
    IL_0011: call void System.Object::.ctor()  /*0x0A000011*/
    IL_0016: ret

