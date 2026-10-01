// ===== __JobReflectionRegistrationOutput__1221673671587648887  (token 0x02000DA6) =====
  .method __JobReflectionRegistrationOutput__1221673671587648887::CreateJobReflectionData()  // token 0x060043F9 rva 0xb06ec attrs Public, Static, HideBySig
    // code size 39 (0x27), max stack 1
    IL_0000: nop
    IL_0001: call void Unity.Jobs.IJobParallelForExtensions::EarlyJobInit()<NGS.MeshFusionPro.JobsMeshMoverLW.MovePartsJob>  /*0x2B0004FF*/
    IL_0006: call void Unity.Jobs.IJobExtensions::EarlyJobInit()<NGS.MeshFusionPro.JobsMeshMoverLW.RecalculateBoundsJob>  /*0x2B000500*/
    IL_000b: call void Unity.Jobs.IJobParallelForExtensions::EarlyJobInit()<NGS.MeshFusionPro.JobsMeshMoverSTD.MovePartsJob>  /*0x2B000501*/
    IL_0010: call void Unity.Jobs.IJobExtensions::EarlyJobInit()<NGS.MeshFusionPro.JobsMeshMoverSTD.RecalculateBoundsJob>  /*0x2B000502*/
    IL_0015: leave IL_0025
    IL_001a: nop
    IL_001b: call void Unity.Jobs.EarlyInitHelpers::JobReflectionDataCreationFailed(System.Exception)  /*0x0A000E5D*/
    IL_0020: leave IL_0025
    IL_0025: nop
    IL_0026: ret
    .try IL_0000-IL_001a catch System.Exception handler IL_001a-IL_0025

  .method __JobReflectionRegistrationOutput__1221673671587648887::EarlyInit()  // token 0x060043FA rva 0xb0730 attrs Public, Static, HideBySig
    // code size 6 (0x6), max stack 8
    IL_0000: call void __JobReflectionRegistrationOutput__1221673671587648887::CreateJobReflectionData()  /*0x060043F9*/
    IL_0005: ret

