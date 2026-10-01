// ===== InGameResignUIHelper  (token 0x02000315) =====
  .method InGameResignUIHelper::Resign()  // token 0x060010F9 rva 0x4eb10 attrs Public, HideBySig
    // code size 49 (0x31), max stack 4, init locals
    IL_0000: ldstr "Resign"
    IL_0005: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000a: ldsfld UIFrameManager UIFrameManager::instance  /*0x040016F4*/
    IL_000f: callvirt void UIFrameManager::CloseAllFrames()  /*0x0600130A*/
    IL_0014: call LocalGamestate LocalGamestate::get_Instance()  /*0x060008FE*/
    IL_0019: ldc.i4.3
    IL_001a: ldc.i4.0
    IL_001b: ldc.i4.1
    IL_001c: callvirt void LocalGamestate::SetState(LocalGamestate.State,bool,bool)  /*0x06000902*/
    IL_0021: leave.s IL_0030
    IL_0023: pop
    IL_0024: ldstr "Error in InGameResignUIHelper: Bro we can not resign here."
    IL_0029: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_002e: leave.s IL_0030
    IL_0030: ret
    .try IL_0000-IL_0023 catch System.Object handler IL_0023-IL_0030

  .method InGameResignUIHelper::.ctor()  // token 0x060010FA rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

