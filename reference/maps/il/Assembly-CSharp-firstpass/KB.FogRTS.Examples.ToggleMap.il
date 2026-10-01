// ===== KB.FogRTS.Examples.ToggleMap  (token 0x02000008) =====
  .method KB.FogRTS.Examples.ToggleMap::Update()  // token 0x06000018 rva 0x26bc attrs Private, HideBySig
    // code size 60 (0x3c), max stack 8
    IL_0000: ldc.i4.s 109
    IL_0002: call bool UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)  /*0x0A000058*/
    IL_0007: brfalse.s IL_003b
    IL_0009: ldarg.0
    IL_000a: ldfld GameObject KB.FogRTS.Examples.ToggleMap::miniMap  /*0x04000017*/
    IL_000f: ldarg.0
    IL_0010: ldfld GameObject KB.FogRTS.Examples.ToggleMap::miniMap  /*0x04000017*/
    IL_0015: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A000059*/
    IL_001a: ldc.i4.0
    IL_001b: ceq
    IL_001d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000041*/
    IL_0022: ldarg.0
    IL_0023: ldfld GameObject KB.FogRTS.Examples.ToggleMap::bigMap  /*0x04000018*/
    IL_0028: ldarg.0
    IL_0029: ldfld GameObject KB.FogRTS.Examples.ToggleMap::bigMap  /*0x04000018*/
    IL_002e: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A000059*/
    IL_0033: ldc.i4.0
    IL_0034: ceq
    IL_0036: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000041*/
    IL_003b: ret

  .method KB.FogRTS.Examples.ToggleMap::.ctor()  // token 0x06000019 rva 0x26f9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0006: ret

