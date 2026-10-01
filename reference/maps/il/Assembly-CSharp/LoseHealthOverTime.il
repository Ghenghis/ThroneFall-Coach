// ===== LoseHealthOverTime  (token 0x020001BF) =====
  .method LoseHealthOverTime::Update()  // token 0x0600090D rva 0x2b3e8 attrs Private, HideBySig
    // code size 73 (0x49), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float LoseHealthOverTime::timer  /*0x04000B5A*/
    IL_0006: ldarg.0
    IL_0007: ldfld float LoseHealthOverTime::damageTime  /*0x04000B5B*/
    IL_000c: bge.un.s IL_0021
    IL_000e: ldarg.0
    IL_000f: ldarg.0
    IL_0010: ldfld float LoseHealthOverTime::timer  /*0x04000B5A*/
    IL_0015: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_001a: add
    IL_001b: stfld float LoseHealthOverTime::timer  /*0x04000B5A*/
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldfld Hp LoseHealthOverTime::hp  /*0x04000B58*/
    IL_0027: ldarg.0
    IL_0028: ldfld float LoseHealthOverTime::loseHealthPerSecond  /*0x04000B59*/
    IL_002d: ldarg.0
    IL_002e: ldfld float LoseHealthOverTime::timer  /*0x04000B5A*/
    IL_0033: mul
    IL_0034: ldnull
    IL_0035: ldc.i4.0
    IL_0036: ldc.i4.0
    IL_0037: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_003c: pop
    IL_003d: ldarg.0
    IL_003e: ldc.r4 0f
    IL_0043: stfld float LoseHealthOverTime::timer  /*0x04000B5A*/
    IL_0048: ret

  .method LoseHealthOverTime::.ctor()  // token 0x0600090E rva 0x2b43d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float LoseHealthOverTime::damageTime  /*0x04000B5B*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

