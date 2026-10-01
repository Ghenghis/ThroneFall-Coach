// ===== KB.FogRTS.Runtime.ScreenEffectPass  (token 0x0200000A) =====
  .method KB.FogRTS.Runtime.ScreenEffectPass::Init(UnityEngine.Rendering.Universal.RenderPassEvent,UnityEngine.Camera,UnityEngine.Vector4,bool,UnityEngine.Rendering.RTHandle,UnityEngine.Texture,UnityEngine.Color,UnityEngine.Texture,UnityEngine.Color)  // token 0x06000039 rva 0x2e38 attrs Assembly, HideBySig
    // code size 325 (0x145), max stack 5, init locals
    .locals ([0] Vector2, [1] Vector2, [2] Vector2, [3] Vector2)
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: newobj void KB.FogRTS.Runtime.ScreenEffectPass.FogOfWarRenderPass::.ctor(UnityEngine.Rendering.Universal.RenderPassEvent)  /*0x06000094*/
    IL_0007: stfld ScriptableRenderPass KB.FogRTS.Runtime.ScreenEffectPass::fogRenderPass  /*0x04000033*/
    IL_000c: ldarg.0
    IL_000d: ldarg.2
    IL_000e: stfld Camera KB.FogRTS.Runtime.ScreenEffectPass::targetCamera  /*0x04000034*/
    IL_0013: ldloca.s 0
    IL_0015: ldarg.3
    IL_0016: ldfld float UnityEngine.Vector4::x  /*0x0A00005F*/
    IL_001b: ldarg.3
    IL_001c: ldfld float UnityEngine.Vector4::y  /*0x0A000060*/
    IL_0021: add
    IL_0022: ldc.r4 0.5f
    IL_0027: mul
    IL_0028: ldarg.3
    IL_0029: ldfld float UnityEngine.Vector4::z  /*0x0A000061*/
    IL_002e: ldarg.3
    IL_002f: ldfld float UnityEngine.Vector4::w  /*0x0A000062*/
    IL_0034: add
    IL_0035: ldc.r4 0.5f
    IL_003a: mul
    IL_003b: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_0040: ldloca.s 1
    IL_0042: ldarg.3
    IL_0043: ldfld float UnityEngine.Vector4::x  /*0x0A00005F*/
    IL_0048: ldarg.3
    IL_0049: ldfld float UnityEngine.Vector4::y  /*0x0A000060*/
    IL_004e: sub
    IL_004f: call float UnityEngine.Mathf::Abs(float)  /*0x0A000078*/
    IL_0054: ldarg.3
    IL_0055: ldfld float UnityEngine.Vector4::z  /*0x0A000061*/
    IL_005a: ldarg.3
    IL_005b: ldfld float UnityEngine.Vector4::w  /*0x0A000062*/
    IL_0060: sub
    IL_0061: call float UnityEngine.Mathf::Abs(float)  /*0x0A000078*/
    IL_0066: call void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_006b: call Vector2 UnityEngine.Vector2::get_one()  /*0x0A000055*/
    IL_0070: ldloc.1
    IL_0071: call Vector2 UnityEngine.Vector2::op_Division(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A000079*/
    IL_0076: stloc.2
    IL_0077: ldc.r4 0.5f
    IL_007c: ldc.r4 0.5f
    IL_0081: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A00006B*/
    IL_0086: ldloc.0
    IL_0087: ldloc.2
    IL_0088: call Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00007A*/
    IL_008d: call Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)  /*0x0A00007B*/
    IL_0092: stloc.3
    IL_0093: ldstr "_FogOfWar_OrientationXZ"
    IL_0098: ldarg.s 4
    IL_009a: brtrue.s IL_009f
    IL_009c: ldc.i4.0
    IL_009d: br.s IL_00a0
    IL_009f: ldc.i4.1
    IL_00a0: conv.r4
    IL_00a1: call void UnityEngine.Shader::SetGlobalFloat(string,float)  /*0x0A00007C*/
    IL_00a6: ldstr "_FogOfWar_WorldToFogParams"
    IL_00ab: ldloc.2
    IL_00ac: ldfld float UnityEngine.Vector2::x  /*0x0A00007D*/
    IL_00b1: ldloc.2
    IL_00b2: ldfld float UnityEngine.Vector2::y  /*0x0A00007E*/
    IL_00b7: ldloc.3
    IL_00b8: ldfld float UnityEngine.Vector2::x  /*0x0A00007D*/
    IL_00bd: ldloc.3
    IL_00be: ldfld float UnityEngine.Vector2::y  /*0x0A00007E*/
    IL_00c3: newobj void UnityEngine.Vector4::.ctor(float,float,float,float)  /*0x0A00007F*/
    IL_00c8: call void UnityEngine.Shader::SetGlobalVector(string,UnityEngine.Vector4)  /*0x0A000080*/
    IL_00cd: ldstr "_FogOfWar_MaskTexture"
    IL_00d2: ldarg.s 5
    IL_00d4: call Texture UnityEngine.Rendering.RTHandle::op_Implicit(UnityEngine.Rendering.RTHandle)  /*0x0A000068*/
    IL_00d9: call void UnityEngine.Shader::SetGlobalTexture(string,UnityEngine.Texture)  /*0x0A000081*/
    IL_00de: ldstr "_FogOfWar_UnexploredFogTexture"
    IL_00e3: ldarg.s 6
    IL_00e5: ldnull
    IL_00e6: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_00eb: brtrue.s IL_00f4
    IL_00ed: call Texture2D UnityEngine.Texture2D::get_whiteTexture()  /*0x0A000083*/
    IL_00f2: br.s IL_00f6
    IL_00f4: ldarg.s 6
    IL_00f6: call void UnityEngine.Shader::SetGlobalTexture(string,UnityEngine.Texture)  /*0x0A000081*/
    IL_00fb: ldstr "_FogOfWar_UnexploredFogColor"
    IL_0100: ldarga.s 7
    IL_0102: call Color UnityEngine.Color::get_linear()  /*0x0A000084*/
    IL_0107: call Vector4 UnityEngine.Color::op_Implicit(UnityEngine.Color)  /*0x0A000085*/
    IL_010c: call void UnityEngine.Shader::SetGlobalVector(string,UnityEngine.Vector4)  /*0x0A000080*/
    IL_0111: ldstr "_FogOfWar_ExploredFogTexture"
    IL_0116: ldarg.s 8
    IL_0118: ldnull
    IL_0119: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_011e: brtrue.s IL_0127
    IL_0120: call Texture2D UnityEngine.Texture2D::get_whiteTexture()  /*0x0A000083*/
    IL_0125: br.s IL_0129
    IL_0127: ldarg.s 8
    IL_0129: call void UnityEngine.Shader::SetGlobalTexture(string,UnityEngine.Texture)  /*0x0A000081*/
    IL_012e: ldstr "_FogOfWar_ExploredFogColor"
    IL_0133: ldarga.s 9
    IL_0135: call Color UnityEngine.Color::get_linear()  /*0x0A000084*/
    IL_013a: call Vector4 UnityEngine.Color::op_Implicit(UnityEngine.Color)  /*0x0A000085*/
    IL_013f: call void UnityEngine.Shader::SetGlobalVector(string,UnityEngine.Vector4)  /*0x0A000080*/
    IL_0144: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass::Enable()  // token 0x0600003A rva 0x2f89 attrs Assembly, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldstr "_FogOfWar_Enabled"
    IL_0005: ldc.r4 1f
    IL_000a: call void UnityEngine.Shader::SetGlobalFloat(string,float)  /*0x0A00007C*/
    IL_000f: ldarg.0
    IL_0010: ldftn void KB.FogRTS.Runtime.ScreenEffectPass::PerformScreenEffect(UnityEngine.Rendering.ScriptableRenderContext,UnityEngine.Camera)  /*0x0600003C*/
    IL_0016: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, UnityEngine.Camera>::.ctor(object,IntPtr)  /*0x0A000086*/
    IL_001b: call void UnityEngine.Rendering.RenderPipelineManager::add_beginCameraRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, UnityEngine.Camera>)  /*0x0A000087*/
    IL_0020: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass::Disable()  // token 0x0600003B rva 0x2fab attrs Assembly, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldstr "_FogOfWar_Enabled"
    IL_0005: ldc.r4 0f
    IL_000a: call void UnityEngine.Shader::SetGlobalFloat(string,float)  /*0x0A00007C*/
    IL_000f: ldarg.0
    IL_0010: ldftn void KB.FogRTS.Runtime.ScreenEffectPass::PerformScreenEffect(UnityEngine.Rendering.ScriptableRenderContext,UnityEngine.Camera)  /*0x0600003C*/
    IL_0016: newobj void System.Action<UnityEngine.Rendering.ScriptableRenderContext, UnityEngine.Camera>::.ctor(object,IntPtr)  /*0x0A000086*/
    IL_001b: call void UnityEngine.Rendering.RenderPipelineManager::remove_beginCameraRendering(System.Action<UnityEngine.Rendering.ScriptableRenderContext, UnityEngine.Camera>)  /*0x0A000088*/
    IL_0020: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass::PerformScreenEffect(UnityEngine.Rendering.ScriptableRenderContext,UnityEngine.Camera)  // token 0x0600003C rva 0x2fcd attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.2
    IL_0002: call bool KB.FogRTS.Runtime.ScreenEffectPass::IsValidCamera(UnityEngine.Camera)  /*0x0600003D*/
    IL_0007: brtrue.s IL_000a
    IL_0009: ret
    IL_000a: call RenderPipelineAsset UnityEngine.Rendering.GraphicsSettings::get_currentRenderPipeline()  /*0x0A000089*/
    IL_000f: isinst UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset  /*0x0100005E*/
    IL_0014: callvirt ScriptableRenderer UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset::get_scriptableRenderer()  /*0x0A00008A*/
    IL_0019: ldarg.0
    IL_001a: ldfld ScriptableRenderPass KB.FogRTS.Runtime.ScreenEffectPass::fogRenderPass  /*0x04000033*/
    IL_001f: callvirt void UnityEngine.Rendering.Universal.ScriptableRenderer::EnqueuePass(UnityEngine.Rendering.Universal.ScriptableRenderPass)  /*0x0A00008B*/
    IL_0024: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass::IsValidCamera(UnityEngine.Camera)  // token 0x0600003D rva 0x2ff3 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldarg.0
    IL_0002: ldfld Camera KB.FogRTS.Runtime.ScreenEffectPass::targetCamera  /*0x04000034*/
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00003A*/
    IL_000c: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass::.ctor()  // token 0x0600003E rva 0x3001 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000011*/
    IL_0006: ret

// ===== KB.FogRTS.Runtime.ScreenEffectPass/FogOfWarRenderPass  (token 0x0200001B) =====
  .method KB.FogRTS.Runtime.ScreenEffectPass.FogOfWarRenderPass::.ctor(UnityEngine.Rendering.Universal.RenderPassEvent)  // token 0x06000094 rva 0x4355 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.Rendering.Universal.ScriptableRenderPass::.ctor()  /*0x0A0000DF*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: call void UnityEngine.Rendering.Universal.ScriptableRenderPass::set_renderPassEvent(UnityEngine.Rendering.Universal.RenderPassEvent)  /*0x0A0000E0*/
    IL_000d: ret

  .method KB.FogRTS.Runtime.ScreenEffectPass.FogOfWarRenderPass::Execute(UnityEngine.Rendering.ScriptableRenderContext,ref UnityEngine.Rendering.Universal.RenderingData)  // token 0x06000095 rva 0x4364 attrs Public, Virtual, HideBySig
    // code size 52 (0x34), max stack 5, init locals
    .locals ([0] CommandBuffer, [1] RTHandle)
    IL_0000: call CommandBuffer UnityEngine.Rendering.CommandBufferPool::Get()  /*0x0A0000E1*/
    IL_0005: stloc.0
    IL_0006: ldarg.2
    IL_0007: ldflda CameraData UnityEngine.Rendering.Universal.RenderingData::cameraData  /*0x0A0000E2*/
    IL_000c: ldfld ScriptableRenderer UnityEngine.Rendering.Universal.CameraData::renderer  /*0x0A0000E3*/
    IL_0011: callvirt RTHandle UnityEngine.Rendering.Universal.ScriptableRenderer::get_cameraColorTargetHandle()  /*0x0A0000E4*/
    IL_0016: stloc.1
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: ldloc.1
    IL_001a: call Material KB.FogRTS.Runtime.FogResources::GetFogScreenEffect()  /*0x06000057*/
    IL_001f: ldc.i4.0
    IL_0020: call void UnityEngine.Rendering.Blitter::BlitCameraTexture(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RTHandle,UnityEngine.Rendering.RTHandle,UnityEngine.Material,int)  /*0x0A0000E5*/
    IL_0025: ldarga.s 1
    IL_0027: ldloc.0
    IL_0028: call void UnityEngine.Rendering.ScriptableRenderContext::ExecuteCommandBuffer(UnityEngine.Rendering.CommandBuffer)  /*0x0A000058*/
    IL_002d: ldloc.0
    IL_002e: call void UnityEngine.Rendering.CommandBufferPool::Release(UnityEngine.Rendering.CommandBuffer)  /*0x0A000059*/
    IL_0033: ret

