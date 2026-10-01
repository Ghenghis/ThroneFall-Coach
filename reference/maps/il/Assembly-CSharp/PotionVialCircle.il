// ===== PotionVialCircle  (token 0x0200017B) =====
  .method PotionVialCircle::Start()  // token 0x0600079C rva 0x25ab0 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Disc PotionVialCircle::disc  /*0x04000984*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld Disc PotionVialCircle::disc  /*0x04000984*/
    IL_0013: callvirt Color Shapes.ShapeRenderer::get_Color()  /*0x0A000082*/
    IL_0018: stfld Color PotionVialCircle::originalColor  /*0x04000989*/
    IL_001d: ret

  .method PotionVialCircle::Update()  // token 0x0600079D rva 0x25ad0 attrs Private, HideBySig
    // code size 110 (0x6e), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PotionVialCircle::clock  /*0x04000988*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float PotionVialCircle::clock  /*0x04000988*/
    IL_0012: ldc.r4 0f
    IL_0017: ldarg.0
    IL_0018: ldfld float PotionVialCircle::animTime  /*0x04000985*/
    IL_001d: ldarg.0
    IL_001e: ldfld float PotionVialCircle::clock  /*0x04000988*/
    IL_0023: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0028: stloc.0
    IL_0029: ldarg.0
    IL_002a: ldfld float PotionVialCircle::clock  /*0x04000988*/
    IL_002f: ldarg.0
    IL_0030: ldfld float PotionVialCircle::activateAt  /*0x04000986*/
    IL_0035: ble.un.s IL_0050
    IL_0037: ldarg.0
    IL_0038: ldfld Disc PotionVialCircle::disc  /*0x04000984*/
    IL_003d: callvirt bool UnityEngine.Behaviour::get_enabled()  /*0x0A0001B4*/
    IL_0042: brtrue.s IL_0050
    IL_0044: ldarg.0
    IL_0045: ldfld Disc PotionVialCircle::disc  /*0x04000984*/
    IL_004a: ldc.i4.1
    IL_004b: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0050: ldarg.0
    IL_0051: ldfld Disc PotionVialCircle::disc  /*0x04000984*/
    IL_0056: ldarg.0
    IL_0057: ldfld Color PotionVialCircle::originalColor  /*0x04000989*/
    IL_005c: ldarg.0
    IL_005d: ldfld Color PotionVialCircle::targetColor  /*0x04000987*/
    IL_0062: ldloc.0
    IL_0063: call Color UnityEngine.Color::Lerp(UnityEngine.Color,UnityEngine.Color,float)  /*0x0A000087*/
    IL_0068: callvirt void Shapes.ShapeRenderer::set_Color(UnityEngine.Color)  /*0x0A000088*/
    IL_006d: ret

  .method PotionVialCircle::.ctor()  // token 0x0600079E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

