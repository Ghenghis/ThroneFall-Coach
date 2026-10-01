// ===== ShapekeyPingPong  (token 0x0200003E) =====
  .method ShapekeyPingPong::Start()  // token 0x06000134 rva 0x6eed attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.SkinnedMeshRenderer>  /*0x2B000012*/
    IL_0007: stfld SkinnedMeshRenderer ShapekeyPingPong::sr  /*0x04000189*/
    IL_000c: ldarg.0
    IL_000d: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0012: stfld float ShapekeyPingPong::clock  /*0x0400018A*/
    IL_0017: ret

  .method ShapekeyPingPong::Update()  // token 0x06000135 rva 0x6f06 attrs Private, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float ShapekeyPingPong::clock  /*0x0400018A*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float ShapekeyPingPong::clock  /*0x0400018A*/
    IL_0012: ldarg.0
    IL_0013: ldfld SkinnedMeshRenderer ShapekeyPingPong::sr  /*0x04000189*/
    IL_0018: ldc.i4.0
    IL_0019: ldarg.0
    IL_001a: ldfld AnimationCurve ShapekeyPingPong::curve  /*0x04000187*/
    IL_001f: ldarg.0
    IL_0020: ldfld float ShapekeyPingPong::clock  /*0x0400018A*/
    IL_0025: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_002a: ldc.r4 100f
    IL_002f: mul
    IL_0030: callvirt void UnityEngine.SkinnedMeshRenderer::SetBlendShapeWeight(int,float)  /*0x0A0000B3*/
    IL_0035: ret

  .method ShapekeyPingPong::.ctor()  // token 0x06000136 rva 0x6f3d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 49 (0x31), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 0f
    IL_000b: ldc.r4 1f
    IL_0010: ldc.r4 1f
    IL_0015: call AnimationCurve UnityEngine.AnimationCurve::EaseInOut(float,float,float,float)  /*0x0A0000B4*/
    IL_001a: stfld AnimationCurve ShapekeyPingPong::curve  /*0x04000187*/
    IL_001f: ldarg.0
    IL_0020: ldc.r4 6f
    IL_0025: stfld float ShapekeyPingPong::speed  /*0x04000188*/
    IL_002a: ldarg.0
    IL_002b: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0030: ret

