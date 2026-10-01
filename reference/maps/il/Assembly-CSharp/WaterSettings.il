// ===== WaterSettings  (token 0x0200039B) =====
  .method WaterSettings::.ctor()  // token 0x060013C8 rva 0x5dee0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 93 (0x5d), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.r4 -0.04f
    IL_0006: stfld float WaterSettings::riverScrollSpeed  /*0x04001810*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 2f
    IL_0011: ldc.r4 16f
    IL_0016: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_001b: stfld Vector2 WaterSettings::riverTextureTiling  /*0x04001811*/
    IL_0020: ldarg.0
    IL_0021: ldc.r4 0.04f
    IL_0026: stfld float WaterSettings::oceanScrollSpeed  /*0x04001812*/
    IL_002b: ldarg.0
    IL_002c: ldc.r4 80f
    IL_0031: ldc.r4 20f
    IL_0036: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_003b: stfld Vector2 WaterSettings::oceanTextureTiling  /*0x04001813*/
    IL_0040: ldarg.0
    IL_0041: ldc.r4 0.724f
    IL_0046: stfld float WaterSettings::selfShadingSize  /*0x04001814*/
    IL_004b: ldarg.0
    IL_004c: ldc.r4 0.724f
    IL_0051: stfld float WaterSettings::oceanSelfShadingSize  /*0x04001815*/
    IL_0056: ldarg.0
    IL_0057: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_005c: ret

