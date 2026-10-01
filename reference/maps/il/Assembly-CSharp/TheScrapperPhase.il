// ===== TheScrapperPhase  (token 0x020000ED) =====
  .method TheScrapperPhase::get_IsValid()  // token 0x0600050B rva 0x163e0 attrs Public, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001b
    IL_000e: ldarg.0
    IL_000f: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_0014: ldnull
    IL_0015: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001a: ret
    IL_001b: ldc.i4.0
    IL_001c: ret

  .method TheScrapperPhase::get_IsActive()  // token 0x0600050C rva 0x163fe attrs Public, HideBySig, SpecialName
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0014: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0019: ret
    IL_001a: ldc.i4.0
    IL_001b: ret

  .method TheScrapperPhase::Start()  // token 0x0600050D rva 0x1641b attrs Private, HideBySig
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0018
    IL_000e: ldstr "[The Scrapper Phase] requires visuals to be set"
    IL_0013: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0018: ldarg.0
    IL_0019: ldfld TheScrapperPhaseData TheScrapperPhase::data  /*0x0400068D*/
    IL_001e: ldnull
    IL_001f: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0024: brfalse.s IL_0030
    IL_0026: ldstr "[The Scrapper Phase] requires data to be set"
    IL_002b: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0030: ret

  .method TheScrapperPhase::ActivateVisuals()  // token 0x0600050E rva 0x1644d attrs Public, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0025
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0014: ldc.i4.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ldarg.0
    IL_001b: ldfld UnityEvent TheScrapperPhase::activation  /*0x04000691*/
    IL_0020: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0025: ret

  .method TheScrapperPhase::DeactivateVisuals()  // token 0x0600050F rva 0x16474 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_001a
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject TheScrapperPhase::visuals  /*0x0400068B*/
    IL_0014: ldc.i4.0
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ret

  .method TheScrapperPhase::.ctor()  // token 0x06000510 rva 0x16490 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TheScrapperAttackOrigin>::.ctor()  /*0x0A000218*/
    IL_0006: stfld List<TheScrapperAttackOrigin> TheScrapperPhase::attackOrigins  /*0x0400068C*/
    IL_000b: ldarg.0
    IL_000c: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0011: stfld UnityEvent TheScrapperPhase::activation  /*0x04000691*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

