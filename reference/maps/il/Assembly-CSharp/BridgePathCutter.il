// ===== BridgePathCutter  (token 0x0200020A) =====
  .method BridgePathCutter::Start()  // token 0x06000AE6 rva 0x337e4 attrs Private, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool BridgePathCutter::inited  /*0x04000DA9*/
    IL_0006: brtrue.s IL_0025
    IL_0008: ldarg.0
    IL_0009: ldfld Animator BridgePathCutter::bridgeAnimator  /*0x04000DA7*/
    IL_000e: ldnull
    IL_000f: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0014: brfalse.s IL_0025
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld bool BridgePathCutter::startWithClosedBridge  /*0x04000DA8*/
    IL_001d: ldc.i4.0
    IL_001e: ceq
    IL_0020: call void BridgePathCutter::ToggleMesh(bool)  /*0x06000AEA*/
    IL_0025: ret

  .method BridgePathCutter::TogglePathState()  // token 0x06000AE7 rva 0x3380b attrs Public, Virtual, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BridgePathCutter::bridgeCut  /*0x04000DA5*/
    IL_0006: ldarg.0
    IL_0007: ldfld GameObject BridgePathCutter::bridgeCut  /*0x04000DA5*/
    IL_000c: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0011: ldc.i4.0
    IL_0012: ceq
    IL_0014: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0019: ret

  .method BridgePathCutter::IsPathOpened()  // token 0x06000AE8 rva 0x33826 attrs Public, Virtual, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BridgePathCutter::bridgeCut  /*0x04000DA5*/
    IL_0006: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_000b: ldc.i4.0
    IL_000c: ceq
    IL_000e: ret

  .method BridgePathCutter::SetPathState(bool)  // token 0x06000AE9 rva 0x33836 attrs Public, Virtual, HideBySig
    // code size 16 (0x10), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject BridgePathCutter::bridgeCut  /*0x04000DA5*/
    IL_0006: ldarg.1
    IL_0007: ldc.i4.0
    IL_0008: ceq
    IL_000a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000f: ret

  .method BridgePathCutter::ToggleMesh(bool)  // token 0x06000AEA rva 0x33848 attrs Public, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool BridgePathCutter::inited  /*0x04000DA9*/
    IL_0007: ldarg.0
    IL_0008: ldfld GameObject BridgePathCutter::bridgeMesh  /*0x04000DA6*/
    IL_000d: ldnull
    IL_000e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld GameObject BridgePathCutter::bridgeMesh  /*0x04000DA6*/
    IL_001b: ldarg.1
    IL_001c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0021: ldarg.0
    IL_0022: ldfld Animator BridgePathCutter::bridgeAnimator  /*0x04000DA7*/
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_0040
    IL_002f: ldarg.0
    IL_0030: ldfld Animator BridgePathCutter::bridgeAnimator  /*0x04000DA7*/
    IL_0035: ldstr "Open"
    IL_003a: ldarg.1
    IL_003b: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0040: ret

  .method BridgePathCutter::.ctor()  // token 0x06000AEB rva 0x33895 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PathCutterBase::.ctor()  /*0x06000AF3*/
    IL_0006: ret

