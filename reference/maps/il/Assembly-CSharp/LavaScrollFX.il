// ===== LavaScrollFX  (token 0x020000FA) =====
  .method LavaScrollFX::Update()  // token 0x06000537 rva 0x16db8 attrs Private, HideBySig
    // code size 76 (0x4c), max stack 3, init locals
    .locals ([0] float)
    IL_0000: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_0005: ldarg.0
    IL_0006: ldfld float LavaScrollFX::_scrollSpeed  /*0x040006C4*/
    IL_000b: mul
    IL_000c: stloc.0
    IL_000d: ldarg.0
    IL_000e: ldflda Vector2 LavaScrollFX::_offset  /*0x040006C8*/
    IL_0013: ldloc.0
    IL_0014: ldarg.0
    IL_0015: ldfld int LavaScrollFX::_xDirection  /*0x040006C5*/
    IL_001a: conv.r4
    IL_001b: mul
    IL_001c: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0021: ldarg.0
    IL_0022: ldflda Vector2 LavaScrollFX::_offset  /*0x040006C8*/
    IL_0027: ldloc.0
    IL_0028: ldarg.0
    IL_0029: ldfld int LavaScrollFX::_yDirection  /*0x040006C6*/
    IL_002e: conv.r4
    IL_002f: mul
    IL_0030: stfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_0035: ldarg.0
    IL_0036: ldfld Material LavaScrollFX::_lavaMaterial  /*0x040006C7*/
    IL_003b: ldstr "_BaseMap"
    IL_0040: ldarg.0
    IL_0041: ldfld Vector2 LavaScrollFX::_offset  /*0x040006C8*/
    IL_0046: callvirt void UnityEngine.Material::SetTextureOffset(string,UnityEngine.Vector2)  /*0x0A000183*/
    IL_004b: ret

  .method LavaScrollFX::.ctor()  // token 0x06000538 rva 0x16e10 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld int LavaScrollFX::_xDirection  /*0x040006C5*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld int LavaScrollFX::_yDirection  /*0x040006C6*/
    IL_000e: ldarg.0
    IL_000f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0014: ret

