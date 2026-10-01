// ===== ObstacleWithBridge  (token 0x0200020B) =====
  .method ObstacleWithBridge::TogglePathState()  // token 0x06000AEC rva 0x338a0 attrs Public, Virtual, HideBySig
    // code size 76 (0x4c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld NavmeshCut ObstacleWithBridge::bridgeCut  /*0x04000DAA*/
    IL_0006: ldarg.0
    IL_0007: ldfld NavmeshCut ObstacleWithBridge::bridgeCut  /*0x04000DAA*/
    IL_000c: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0011: ldc.i4.0
    IL_0012: ceq
    IL_0014: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0019: ldarg.0
    IL_001a: ldfld BoxCollider ObstacleWithBridge::bridgeCollider  /*0x04000DAC*/
    IL_001f: ldarg.0
    IL_0020: ldfld BoxCollider ObstacleWithBridge::bridgeCollider  /*0x04000DAC*/
    IL_0025: callvirt bool UnityEngine.Collider::get_enabled()  /*0x0A0001ED*/
    IL_002a: ldc.i4.0
    IL_002b: ceq
    IL_002d: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_0032: ldarg.0
    IL_0033: ldfld MeshRenderer ObstacleWithBridge::bridgeMesh  /*0x04000DAB*/
    IL_0038: ldarg.0
    IL_0039: ldfld MeshRenderer ObstacleWithBridge::bridgeMesh  /*0x04000DAB*/
    IL_003e: callvirt bool UnityEngine.Renderer::get_enabled()  /*0x0A0004C8*/
    IL_0043: ldc.i4.0
    IL_0044: ceq
    IL_0046: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_004b: ret

  .method ObstacleWithBridge::IsPathOpened()  // token 0x06000AED rva 0x338f8 attrs Public, Virtual, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld NavmeshCut ObstacleWithBridge::bridgeCut  /*0x04000DAA*/
    IL_0006: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_000b: ldc.i4.0
    IL_000c: ceq
    IL_000e: ret

  .method ObstacleWithBridge::SetPathState(bool)  // token 0x06000AEE rva 0x33908 attrs Public, Virtual, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld NavmeshCut ObstacleWithBridge::bridgeCut  /*0x04000DAA*/
    IL_0006: ldarg.1
    IL_0007: ldc.i4.0
    IL_0008: ceq
    IL_000a: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000f: ldarg.0
    IL_0010: ldfld BoxCollider ObstacleWithBridge::bridgeCollider  /*0x04000DAC*/
    IL_0015: ldarg.1
    IL_0016: ldc.i4.0
    IL_0017: ceq
    IL_0019: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_001e: ldarg.0
    IL_001f: ldfld MeshRenderer ObstacleWithBridge::bridgeMesh  /*0x04000DAB*/
    IL_0024: ldarg.1
    IL_0025: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_002a: ret

  .method ObstacleWithBridge::.ctor()  // token 0x06000AEF rva 0x33895 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PathCutterBase::.ctor()  /*0x06000AF3*/
    IL_0006: ret

