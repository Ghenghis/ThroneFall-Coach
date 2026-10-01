// ===== KB.FogRTS.Runtime.MapFogOverlayUI  (token 0x0200000E) =====
  .method KB.FogRTS.Runtime.MapFogOverlayUI::Awake()  // token 0x0600005F rva 0x3994 attrs Private, HideBySig
    // code size 72 (0x48), max stack 2, init locals
    .locals ([0] Graphic, [1] Image, [2] RawImage)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.0
    IL_0003: ldloca.s 1
    IL_0005: call bool UnityEngine.Component::TryGetComponent(ref !!0)<UnityEngine.UI.Image>  /*0x2B00000A*/
    IL_000a: brfalse.s IL_0010
    IL_000c: ldloc.1
    IL_000d: stloc.0
    IL_000e: br.s IL_001c
    IL_0010: ldarg.0
    IL_0011: ldloca.s 2
    IL_0013: call bool UnityEngine.Component::TryGetComponent(ref !!0)<UnityEngine.UI.RawImage>  /*0x2B00000B*/
    IL_0018: brfalse.s IL_001c
    IL_001a: ldloc.2
    IL_001b: stloc.0
    IL_001c: ldloc.0
    IL_001d: ldnull
    IL_001e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_0023: brfalse.s IL_0047
    IL_0025: ldarg.0
    IL_0026: call Shader KB.FogRTS.Runtime.FogResources::GetFogOverlayUI()  /*0x06000058*/
    IL_002b: newobj void UnityEngine.Material::.ctor(UnityEngine.Shader)  /*0x0A0000AB*/
    IL_0030: stfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0035: ldarg.0
    IL_0036: call void KB.FogRTS.Runtime.MapFogOverlayUI::SetFogProperties()  /*0x06000060*/
    IL_003b: ldloc.0
    IL_003c: ldarg.0
    IL_003d: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0042: callvirt void UnityEngine.UI.Graphic::set_material(UnityEngine.Material)  /*0x0A0000B2*/
    IL_0047: ret

  .method KB.FogRTS.Runtime.MapFogOverlayUI::SetFogProperties()  // token 0x06000060 rva 0x39e8 attrs Private, HideBySig
    // code size 89 (0x59), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0006: ldstr "_UnexploredFogTexture"
    IL_000b: ldarg.0
    IL_000c: ldfld Texture2D KB.FogRTS.Runtime.MapFogOverlayUI::fogTexture  /*0x04000060*/
    IL_0011: callvirt void UnityEngine.Material::SetTexture(string,UnityEngine.Texture)  /*0x0A0000B3*/
    IL_0016: ldarg.0
    IL_0017: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_001c: ldstr "_UnexploredFogColor"
    IL_0021: ldarg.0
    IL_0022: ldfld Color KB.FogRTS.Runtime.MapFogOverlayUI::fogColor  /*0x04000061*/
    IL_0027: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A0000B4*/
    IL_002c: ldarg.0
    IL_002d: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0032: ldstr "_ExploredFogTexture"
    IL_0037: ldarg.0
    IL_0038: ldfld Texture2D KB.FogRTS.Runtime.MapFogOverlayUI::exploredFogTexture  /*0x04000062*/
    IL_003d: callvirt void UnityEngine.Material::SetTexture(string,UnityEngine.Texture)  /*0x0A0000B3*/
    IL_0042: ldarg.0
    IL_0043: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0048: ldstr "_ExploredFogColor"
    IL_004d: ldarg.0
    IL_004e: ldfld Color KB.FogRTS.Runtime.MapFogOverlayUI::exploredFogColor  /*0x04000063*/
    IL_0053: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A0000B4*/
    IL_0058: ret

  .method KB.FogRTS.Runtime.MapFogOverlayUI::OnDestroy()  // token 0x06000061 rva 0x3a4d attrs Private, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000082*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldarg.0
    IL_000f: ldfld Material KB.FogRTS.Runtime.MapFogOverlayUI::fogOverlayMat  /*0x04000064*/
    IL_0014: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A0000A0*/
    IL_0019: ret

  .method KB.FogRTS.Runtime.MapFogOverlayUI::.ctor()  // token 0x06000062 rva 0x3a68 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 69 (0x45), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 0f
    IL_0010: ldc.r4 1f
    IL_0015: newobj void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A0000A9*/
    IL_001a: stfld Color KB.FogRTS.Runtime.MapFogOverlayUI::fogColor  /*0x04000061*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 1f
    IL_0025: ldc.r4 1f
    IL_002a: ldc.r4 1f
    IL_002f: ldc.r4 0.5f
    IL_0034: newobj void UnityEngine.Color::.ctor(float,float,float,float)  /*0x0A0000A9*/
    IL_0039: stfld Color KB.FogRTS.Runtime.MapFogOverlayUI::exploredFogColor  /*0x04000063*/
    IL_003e: ldarg.0
    IL_003f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000092*/
    IL_0044: ret

