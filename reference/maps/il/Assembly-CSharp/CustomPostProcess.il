// ===== CustomPostProcess  (token 0x020003A5) =====
  .method CustomPostProcess::Create()  // token 0x060013E8 rva 0x5e96c attrs Public, Virtual, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld CustomPostProcess.Settings CustomPostProcess::settings  /*0x0400184E*/
    IL_0007: ldfld Material CustomPostProcess.Settings::material  /*0x04001852*/
    IL_000c: newobj void CustomPostProcess.CustomRenderPass::.ctor(UnityEngine.Material)  /*0x060013EB*/
    IL_0011: stfld CustomPostProcess.CustomRenderPass CustomPostProcess::m_ScriptablePass  /*0x0400184D*/
    IL_0016: ldarg.0
    IL_0017: ldfld CustomPostProcess.CustomRenderPass CustomPostProcess::m_ScriptablePass  /*0x0400184D*/
    IL_001c: ldc.i4 550
    IL_0021: callvirt void UnityEngine.Rendering.Universal.ScriptableRenderPass::set_renderPassEvent(UnityEngine.Rendering.Universal.RenderPassEvent)  /*0x0A00078B*/
    IL_0026: ret

  .method CustomPostProcess::AddRenderPasses(UnityEngine.Rendering.Universal.ScriptableRenderer,ref UnityEngine.Rendering.Universal.RenderingData)  // token 0x060013E9 rva 0x5e994 attrs Public, Virtual, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld CustomPostProcess.CustomRenderPass CustomPostProcess::m_ScriptablePass  /*0x0400184D*/
    IL_0006: ldarg.1
    IL_0007: callvirt RenderTargetIdentifier UnityEngine.Rendering.Universal.ScriptableRenderer::get_cameraColorTarget()  /*0x0A00078C*/
    IL_000c: stfld RenderTargetIdentifier CustomPostProcess.CustomRenderPass::source  /*0x0400184F*/
    IL_0011: ldarg.1
    IL_0012: ldarg.0
    IL_0013: ldfld CustomPostProcess.CustomRenderPass CustomPostProcess::m_ScriptablePass  /*0x0400184D*/
    IL_0018: callvirt void UnityEngine.Rendering.Universal.ScriptableRenderer::EnqueuePass(UnityEngine.Rendering.Universal.ScriptableRenderPass)  /*0x0A00078D*/
    IL_001d: ret

  .method CustomPostProcess::.ctor()  // token 0x060013EA rva 0x5e9b3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.Rendering.Universal.ScriptableRendererFeature::.ctor()  /*0x0A00078E*/
    IL_0006: ret

// ===== CustomPostProcess/CustomRenderPass  (token 0x020003A6) =====
  .method CustomPostProcess.CustomRenderPass::.ctor(UnityEngine.Material)  // token 0x060013EB rva 0x5e9bb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.Rendering.Universal.ScriptableRenderPass::.ctor()  /*0x0A00078F*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld Material CustomPostProcess.CustomRenderPass::mat  /*0x04001850*/
    IL_000d: ldarg.0
    IL_000e: ldflda RenderTargetHandle CustomPostProcess.CustomRenderPass::tempRenderTargetHandle  /*0x04001851*/
    IL_0013: ldstr "_TemporaryColorTexture"
    IL_0018: call void UnityEngine.Rendering.Universal.RenderTargetHandle::Init(string)  /*0x0A000790*/
    IL_001d: ret

  .method CustomPostProcess.CustomRenderPass::OnCameraSetup(UnityEngine.Rendering.CommandBuffer,ref UnityEngine.Rendering.Universal.RenderingData)  // token 0x060013EC rva 0x25f1 attrs Public, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method CustomPostProcess.CustomRenderPass::Execute(UnityEngine.Rendering.ScriptableRenderContext,ref UnityEngine.Rendering.Universal.RenderingData)  // token 0x060013ED rva 0x5e9dc attrs Public, Virtual, HideBySig
    // code size 106 (0x6a), max stack 6, init locals
    .locals ([0] CommandBuffer)
    IL_0000: call CommandBuffer UnityEngine.Rendering.CommandBufferPool::Get()  /*0x0A000791*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.0
    IL_0008: ldflda RenderTargetHandle CustomPostProcess.CustomRenderPass::tempRenderTargetHandle  /*0x04001851*/
    IL_000d: call int UnityEngine.Rendering.Universal.RenderTargetHandle::get_id()  /*0x0A000792*/
    IL_0012: ldarg.2
    IL_0013: ldflda CameraData UnityEngine.Rendering.Universal.RenderingData::cameraData  /*0x0A000793*/
    IL_0018: ldfld RenderTextureDescriptor UnityEngine.Rendering.Universal.CameraData::cameraTargetDescriptor  /*0x0A000794*/
    IL_001d: callvirt void UnityEngine.Rendering.CommandBuffer::GetTemporaryRT(int,UnityEngine.RenderTextureDescriptor)  /*0x0A000795*/
    IL_0022: ldarg.0
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld RenderTargetIdentifier CustomPostProcess.CustomRenderPass::source  /*0x0400184F*/
    IL_002a: ldarg.0
    IL_002b: ldflda RenderTargetHandle CustomPostProcess.CustomRenderPass::tempRenderTargetHandle  /*0x04001851*/
    IL_0030: call RenderTargetIdentifier UnityEngine.Rendering.Universal.RenderTargetHandle::Identifier()  /*0x0A000796*/
    IL_0035: ldarg.0
    IL_0036: ldfld Material CustomPostProcess.CustomRenderPass::mat  /*0x04001850*/
    IL_003b: ldc.i4.0
    IL_003c: call void UnityEngine.Rendering.Universal.ScriptableRenderPass::Blit(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RenderTargetIdentifier,UnityEngine.Rendering.RenderTargetIdentifier,UnityEngine.Material,int)  /*0x0A000797*/
    IL_0041: ldarg.0
    IL_0042: ldloc.0
    IL_0043: ldarg.0
    IL_0044: ldflda RenderTargetHandle CustomPostProcess.CustomRenderPass::tempRenderTargetHandle  /*0x04001851*/
    IL_0049: call RenderTargetIdentifier UnityEngine.Rendering.Universal.RenderTargetHandle::Identifier()  /*0x0A000796*/
    IL_004e: ldarg.0
    IL_004f: ldfld RenderTargetIdentifier CustomPostProcess.CustomRenderPass::source  /*0x0400184F*/
    IL_0054: ldnull
    IL_0055: ldc.i4.0
    IL_0056: call void UnityEngine.Rendering.Universal.ScriptableRenderPass::Blit(UnityEngine.Rendering.CommandBuffer,UnityEngine.Rendering.RenderTargetIdentifier,UnityEngine.Rendering.RenderTargetIdentifier,UnityEngine.Material,int)  /*0x0A000797*/
    IL_005b: ldarga.s 1
    IL_005d: ldloc.0
    IL_005e: call void UnityEngine.Rendering.ScriptableRenderContext::ExecuteCommandBuffer(UnityEngine.Rendering.CommandBuffer)  /*0x0A000798*/
    IL_0063: ldloc.0
    IL_0064: call void UnityEngine.Rendering.CommandBufferPool::Release(UnityEngine.Rendering.CommandBuffer)  /*0x0A000799*/
    IL_0069: ret

  .method CustomPostProcess.CustomRenderPass::OnCameraCleanup(UnityEngine.Rendering.CommandBuffer)  // token 0x060013EE rva 0x25f1 attrs Public, Virtual, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

// ===== CustomPostProcess/Settings  (token 0x020003A7) =====
  .method CustomPostProcess.Settings::.ctor()  // token 0x060013EF rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

