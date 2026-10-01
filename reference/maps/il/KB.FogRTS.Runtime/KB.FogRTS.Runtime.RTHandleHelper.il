// ===== KB.FogRTS.Runtime.RTHandleHelper  (token 0x02000010) =====
  .method KB.FogRTS.Runtime.RTHandleHelper::CreateRT(UnityEngine.Vector2Int,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,bool)  // token 0x06000065 rva 0x3b38 attrs Assembly, Static, HideBySig
    // code size 46 (0x2e), max stack 20, init locals
    IL_0000: ldarga.s 0
    IL_0002: call int UnityEngine.Vector2Int::get_x()  /*0x0A000064*/
    IL_0007: ldarga.s 0
    IL_0009: call int UnityEngine.Vector2Int::get_y()  /*0x0A000066*/
    IL_000e: ldc.i4.1
    IL_000f: ldc.i4.0
    IL_0010: ldarg.1
    IL_0011: ldarg.2
    IL_0012: ldc.i4.1
    IL_0013: ldc.i4.2
    IL_0014: ldarg.3
    IL_0015: ldc.i4.0
    IL_0016: ldc.i4.1
    IL_0017: ldc.i4.0
    IL_0018: ldc.i4.1
    IL_0019: ldc.r4 0f
    IL_001e: ldc.i4.1
    IL_001f: ldc.i4.0
    IL_0020: ldc.i4.0
    IL_0021: ldc.i4.0
    IL_0022: ldc.i4.0
    IL_0023: ldstr ""
    IL_0028: call RTHandle UnityEngine.Rendering.RTHandles::Alloc(int,int,int,UnityEngine.Rendering.DepthBits,UnityEngine.Experimental.Rendering.GraphicsFormat,UnityEngine.FilterMode,UnityEngine.TextureWrapMode,UnityEngine.Rendering.TextureDimension,bool,bool,bool,bool,int,float,UnityEngine.Rendering.MSAASamples,bool,bool,UnityEngine.RenderTextureMemoryless,UnityEngine.VRTextureUsage,string)  /*0x0A0000BD*/
    IL_002d: ret

