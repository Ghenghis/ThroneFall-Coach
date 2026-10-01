// ===== BoarChargeFX  (token 0x02000170) =====
  .method BoarChargeFX::Update()  // token 0x06000778 rva 0x2537c attrs Private, HideBySig
    // code size 140 (0x8c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool BoarChargeFX::isDashing  /*0x0400095D*/
    IL_0006: brfalse.s IL_005b
    IL_0008: ldarg.0
    IL_0009: ldfld ParticleSystem BoarChargeFX::windShieldParticleSystem  /*0x0400095A*/
    IL_000e: callvirt bool UnityEngine.ParticleSystem::get_isPlaying()  /*0x0A000111*/
    IL_0013: brtrue.s IL_0028
    IL_0015: ldarg.0
    IL_0016: ldc.i4.0
    IL_0017: stfld bool BoarChargeFX::isDashing  /*0x0400095D*/
    IL_001c: ldarg.0
    IL_001d: ldfld GameObject BoarChargeFX::windShieldFX  /*0x04000959*/
    IL_0022: ldc.i4.0
    IL_0023: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0028: ldarg.0
    IL_0029: ldfld float BoarChargeFX::windShieldTimer  /*0x0400095E*/
    IL_002e: ldc.r4 0f
    IL_0033: ble.un.s IL_0049
    IL_0035: ldarg.0
    IL_0036: ldarg.0
    IL_0037: ldfld float BoarChargeFX::windShieldTimer  /*0x0400095E*/
    IL_003c: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0041: sub
    IL_0042: stfld float BoarChargeFX::windShieldTimer  /*0x0400095E*/
    IL_0047: br.s IL_0055
    IL_0049: ldarg.0
    IL_004a: ldfld GameObject BoarChargeFX::endFX  /*0x0400095B*/
    IL_004f: ldc.i4.1
    IL_0050: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0055: ldarg.0
    IL_0056: call void BoarChargeFX::WindTextureScroll()  /*0x06000779*/
    IL_005b: ldc.i4.s 116
    IL_005d: call bool UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)  /*0x0A0001B3*/
    IL_0062: brfalse.s IL_008b
    IL_0064: ldarg.0
    IL_0065: ldfld bool BoarChargeFX::isDashing  /*0x0400095D*/
    IL_006a: brtrue.s IL_008b
    IL_006c: ldarg.0
    IL_006d: ldarg.0
    IL_006e: ldfld float BoarChargeFX::windShieldDuration  /*0x0400095C*/
    IL_0073: stfld float BoarChargeFX::windShieldTimer  /*0x0400095E*/
    IL_0078: ldarg.0
    IL_0079: ldc.i4.1
    IL_007a: stfld bool BoarChargeFX::isDashing  /*0x0400095D*/
    IL_007f: ldarg.0
    IL_0080: ldfld GameObject BoarChargeFX::windShieldFX  /*0x04000959*/
    IL_0085: ldc.i4.1
    IL_0086: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_008b: ret

  .method BoarChargeFX::WindTextureScroll()  // token 0x06000779 rva 0x25414 attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldflda Vector2 BoarChargeFX::windOffset  /*0x04000961*/
    IL_0006: call float UnityEngine.Time::get_time()  /*0x0A00010A*/
    IL_000b: ldarg.0
    IL_000c: ldfld float BoarChargeFX::windScrollSpeed  /*0x0400095F*/
    IL_0011: mul
    IL_0012: stfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0017: ldarg.0
    IL_0018: ldflda Vector2 BoarChargeFX::windOffset  /*0x04000961*/
    IL_001d: ldarg.0
    IL_001e: ldflda Vector2 BoarChargeFX::windOffset  /*0x04000961*/
    IL_0023: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0028: stfld float UnityEngine.Vector2::y  /*0x0A000151*/
    IL_002d: ldarg.0
    IL_002e: ldfld Material BoarChargeFX::windMaterial  /*0x04000960*/
    IL_0033: ldstr "_BaseMap"
    IL_0038: ldarg.0
    IL_0039: ldfld Vector2 BoarChargeFX::windOffset  /*0x04000961*/
    IL_003e: callvirt void UnityEngine.Material::SetTextureOffset(string,UnityEngine.Vector2)  /*0x0A000183*/
    IL_0043: ret

  .method BoarChargeFX::.ctor()  // token 0x0600077A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

