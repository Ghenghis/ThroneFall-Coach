// ===== PlatformCRTWriter  (token 0x020002E4) =====
  .method PlatformCRTWriter::Awake()  // token 0x06000FEC rva 0x48d40 attrs Private, HideBySig
    // code size 84 (0x54), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Camera>  /*0x2B0000E2*/
    IL_0007: stfld Camera PlatformCRTWriter::cam  /*0x040012C5*/
    IL_000c: ldarg.0
    IL_000d: ldfld CustomRenderTexture PlatformCRTWriter::cointreasuryCRT  /*0x040012C4*/
    IL_0012: callvirt void UnityEngine.RenderTexture::Release()  /*0x0A000648*/
    IL_0017: ldarg.0
    IL_0018: ldfld CustomRenderTexture PlatformCRTWriter::cointreasuryCRT  /*0x040012C4*/
    IL_001d: ldc.i4 512
    IL_0022: callvirt void UnityEngine.Texture::set_width(int)  /*0x0A000649*/
    IL_0027: ldarg.0
    IL_0028: ldfld CustomRenderTexture PlatformCRTWriter::cointreasuryCRT  /*0x040012C4*/
    IL_002d: ldc.i4 1024
    IL_0032: callvirt void UnityEngine.Texture::set_height(int)  /*0x0A00064A*/
    IL_0037: ldarg.0
    IL_0038: ldfld CustomRenderTexture PlatformCRTWriter::cointreasuryCRT  /*0x040012C4*/
    IL_003d: callvirt void UnityEngine.CustomRenderTexture::Initialize()  /*0x0A00064B*/
    IL_0042: ldarg.0
    IL_0043: ldfld Camera PlatformCRTWriter::cam  /*0x040012C5*/
    IL_0048: ldarg.0
    IL_0049: ldfld CustomRenderTexture PlatformCRTWriter::cointreasuryCRT  /*0x040012C4*/
    IL_004e: callvirt void UnityEngine.Camera::set_targetTexture(UnityEngine.RenderTexture)  /*0x0A00064C*/
    IL_0053: ret

  .method PlatformCRTWriter::.ctor()  // token 0x06000FED rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

