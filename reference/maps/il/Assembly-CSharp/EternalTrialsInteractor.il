// ===== EternalTrialsInteractor  (token 0x020001A8) =====
  .method EternalTrialsInteractor::ReturnTooltip()  // token 0x06000896 rva 0x297fa attrs Public, Virtual, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldstr "Menu/Level Interactor Cue"
    IL_0005: ldc.i4.1
    IL_0006: ldc.i4.0
    IL_0007: ldc.i4.1
    IL_0008: ldc.i4.1
    IL_0009: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_000e: ret

  .method EternalTrialsInteractor::Focus(PlayerInteraction)  // token 0x06000897 rva 0x2980a attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialsInteractor::focusPanel  /*0x04000AB9*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method EternalTrialsInteractor::Unfocus(PlayerInteraction)  // token 0x06000898 rva 0x29818 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject EternalTrialsInteractor::focusPanel  /*0x04000AB9*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method EternalTrialsInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000899 rva 0x29826 attrs Public, Virtual, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldsfld InGamePopUpHelper InGamePopUpHelper::instance  /*0x04001433*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brfalse.s IL_0019
    IL_000c: ldsfld InGamePopUpHelper InGamePopUpHelper::instance  /*0x04001433*/
    IL_0011: callvirt bool InGamePopUpHelper::PopEternalTrials()  /*0x060010F5*/
    IL_0016: brfalse.s IL_0019
    IL_0018: ret
    IL_0019: call bool UIFrameManager::TryOpenEternalTrialsSelect()  /*0x06001311*/
    IL_001e: pop
    IL_001f: ret

  .method EternalTrialsInteractor::.ctor()  // token 0x0600089A rva 0x2743 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_0006: ret

