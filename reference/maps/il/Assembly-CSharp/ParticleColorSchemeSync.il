// ===== ParticleColorSchemeSync  (token 0x02000177) =====
  .method ParticleColorSchemeSync::Awake()  // token 0x0600078F rva 0x25840 attrs Private, HideBySig
    // code size 135 (0x87), max stack 3, init locals
    .locals ([0] ParticleSystem.MainModule, [1] ParticleSystem.MainModule)
    IL_0000: ldarg.0
    IL_0001: call ColorAndLightManager ColorAndLightManager::get_Instance()  /*0x06000351*/
    IL_0006: stfld ColorAndLightManager ParticleColorSchemeSync::_colorManager  /*0x04000976*/
    IL_000b: ldarg.0
    IL_000c: ldfld ParticleSystem ParticleColorSchemeSync::_waterfall  /*0x04000977*/
    IL_0011: callvirt ParticleSystem.MainModule UnityEngine.ParticleSystem::get_main()  /*0x0A000370*/
    IL_0016: stloc.0
    IL_0017: ldloca.s 0
    IL_0019: ldarg.0
    IL_001a: ldfld ColorAndLightManager ParticleColorSchemeSync::_colorManager  /*0x04000976*/
    IL_001f: callvirt Colorscheme ColorAndLightManager::get_CurrentColorScheme()  /*0x06000354*/
    IL_0024: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_0029: ldarg.0
    IL_002a: ldfld ColorAndLightManager ParticleColorSchemeSync::_colorManager  /*0x04000976*/
    IL_002f: callvirt Colorscheme ColorAndLightManager::get_CurrentColorScheme()  /*0x06000354*/
    IL_0034: ldfld Color Colorscheme::waterSecondaryColor  /*0x0400047C*/
    IL_0039: newobj void UnityEngine.ParticleSystem.MinMaxGradient::.ctor(UnityEngine.Color,UnityEngine.Color)  /*0x0A000371*/
    IL_003e: call void UnityEngine.ParticleSystem.MainModule::set_startColor(UnityEngine.ParticleSystem.MinMaxGradient)  /*0x0A000372*/
    IL_0043: ldarg.0
    IL_0044: ldfld ParticleSystem ParticleColorSchemeSync::_waterfall  /*0x04000977*/
    IL_0049: callvirt void UnityEngine.ParticleSystem::Clear()  /*0x0A000373*/
    IL_004e: ldarg.0
    IL_004f: ldfld ParticleSystem ParticleColorSchemeSync::_waterfallImpact  /*0x04000978*/
    IL_0054: callvirt ParticleSystem.MainModule UnityEngine.ParticleSystem::get_main()  /*0x0A000370*/
    IL_0059: stloc.1
    IL_005a: ldloca.s 1
    IL_005c: call Color UnityEngine.Color::get_white()  /*0x0A000188*/
    IL_0061: ldarg.0
    IL_0062: ldfld ColorAndLightManager ParticleColorSchemeSync::_colorManager  /*0x04000976*/
    IL_0067: callvirt Colorscheme ColorAndLightManager::get_CurrentColorScheme()  /*0x06000354*/
    IL_006c: ldfld Color Colorscheme::waterLightColor  /*0x0400047B*/
    IL_0071: newobj void UnityEngine.ParticleSystem.MinMaxGradient::.ctor(UnityEngine.Color,UnityEngine.Color)  /*0x0A000371*/
    IL_0076: call void UnityEngine.ParticleSystem.MainModule::set_startColor(UnityEngine.ParticleSystem.MinMaxGradient)  /*0x0A000372*/
    IL_007b: ldarg.0
    IL_007c: ldfld ParticleSystem ParticleColorSchemeSync::_waterfallImpact  /*0x04000978*/
    IL_0081: callvirt void UnityEngine.ParticleSystem::Clear()  /*0x0A000373*/
    IL_0086: ret

  .method ParticleColorSchemeSync::.ctor()  // token 0x06000790 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

