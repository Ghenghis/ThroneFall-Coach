// ===== ApplyUpgradeIndicatorColor  (token 0x020002D3) =====
  .method ApplyUpgradeIndicatorColor::Start()  // token 0x06000FA2 rva 0x47260 attrs Private, HideBySig
    // code size 47 (0x2f), max stack 2, init locals
    .locals ([0] Rectangle)
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_000b: ldarg.0
    IL_000c: call !!0 UnityEngine.Component::GetComponent()<Shapes.Rectangle>  /*0x2B0000D9*/
    IL_0011: stloc.0
    IL_0012: ldsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_0017: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001c: brfalse.s IL_002e
    IL_001e: ldloc.0
    IL_001f: ldsfld Colorscheme ColorAndLightManager::currentColorscheme  /*0x04000448*/
    IL_0024: ldfld Color Colorscheme::upgradeInteractorColor  /*0x0400047E*/
    IL_0029: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_002e: ret

  .method ApplyUpgradeIndicatorColor::.ctor()  // token 0x06000FA3 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

