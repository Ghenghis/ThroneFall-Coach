// ===== HpWithDamageReduction  (token 0x02000100) =====
  .method HpWithDamageReduction::TakeDamage(float,TaggedObject,bool,bool)  // token 0x0600054C rva 0x17199 attrs Public, Virtual, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.r4 0f
    IL_0006: ble.un.s IL_001d
    IL_0008: ldc.r4 1f
    IL_000d: ldarg.0
    IL_000e: ldfld float HpWithDamageReduction::DamageReductionRate  /*0x040006E0*/
    IL_0013: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_0018: sub
    IL_0019: ldarg.1
    IL_001a: mul
    IL_001b: starg.s 1
    IL_001d: ldarg.0
    IL_001e: ldarg.1
    IL_001f: ldarg.2
    IL_0020: ldarg.3
    IL_0021: ldarg.s 4
    IL_0023: call bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0028: ret

  .method HpWithDamageReduction::.ctor()  // token 0x0600054D rva 0x1472f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Hp::.ctor()  /*0x06000837*/
    IL_0006: ret

