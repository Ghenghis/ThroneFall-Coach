// ===== Invulnerable  (token 0x0200019F) =====
  .method Invulnerable::Start()  // token 0x0600086B rva 0x28b05 attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0007: stfld Hp Invulnerable::hp  /*0x04000A6E*/
    IL_000c: ret

  .method Invulnerable::Update()  // token 0x0600086C rva 0x28b13 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Invulnerable::hp  /*0x04000A6E*/
    IL_0006: ldc.r4 1000000f
    IL_000b: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_0010: ret

  .method Invulnerable::.ctor()  // token 0x0600086D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

