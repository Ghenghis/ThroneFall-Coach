// ===== FalcionMA  (token 0x020001E3) =====
  .method FalcionMA::Start()  // token 0x060009EB rva 0x2ed6d attrs Public, Virtual, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Start()  /*0x06000A00*/
    IL_0006: ret

  .method FalcionMA::Attack()  // token 0x060009EC rva 0x2ed78 attrs Public, Virtual, HideBySig
    // code size 70 (0x46), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Attack()  /*0x06000A07*/
    IL_0006: ldarg.0
    IL_0007: ldfld int FalcionMA::attackNr  /*0x04000CA2*/
    IL_000c: ldarg.0
    IL_000d: ldfld int FalcionMA::consecutiveBursts  /*0x04000CA1*/
    IL_0012: rem
    IL_0013: ldarg.0
    IL_0014: ldfld int FalcionMA::consecutiveBursts  /*0x04000CA1*/
    IL_0019: ldc.i4.1
    IL_001a: sub
    IL_001b: bne.un.s IL_002b
    IL_001d: ldarg.0
    IL_001e: ldarg.0
    IL_001f: ldfld float ManualAttack::cooldownTime  /*0x04000CBA*/
    IL_0024: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0029: br.s IL_0037
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float FalcionMA::shortCooldownTime  /*0x04000CA0*/
    IL_0032: stfld float ManualAttack::cooldown  /*0x04000CC3*/
    IL_0037: ldarg.0
    IL_0038: ldarg.0
    IL_0039: ldfld int FalcionMA::attackNr  /*0x04000CA2*/
    IL_003e: ldc.i4.1
    IL_003f: add
    IL_0040: stfld int FalcionMA::attackNr  /*0x04000CA2*/
    IL_0045: ret

  .method FalcionMA::Update()  // token 0x060009ED rva 0x2edca attrs Public, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::Update()  /*0x06000A02*/
    IL_0006: ldarg.0
    IL_0007: ldfld int FalcionMA::attackNr  /*0x04000CA2*/
    IL_000c: ldarg.0
    IL_000d: ldfld int FalcionMA::consecutiveBursts  /*0x04000CA1*/
    IL_0012: rem
    IL_0013: brfalse.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldarg.0
    IL_0017: ldfld float FalcionMA::shortCooldownTime  /*0x04000CA0*/
    IL_001c: stfld float ManualAttack::inputBuffer  /*0x04000CC4*/
    IL_0021: ret

  .method FalcionMA::.ctor()  // token 0x060009EE rva 0x2eded attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float FalcionMA::shortCooldownTime  /*0x04000CA0*/
    IL_000b: ldarg.0
    IL_000c: ldc.i4.5
    IL_000d: stfld int FalcionMA::consecutiveBursts  /*0x04000CA1*/
    IL_0012: ldarg.0
    IL_0013: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0018: ret

