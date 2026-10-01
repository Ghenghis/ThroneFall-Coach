// ===== HpThief  (token 0x020000FF) =====
  .method HpThief::TakeDamage(float,TaggedObject,bool,bool)  // token 0x0600054A rva 0x17168 attrs Public, Virtual, HideBySig
    // code size 48 (0x30), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: ldarg.2
    IL_0003: ldarg.3
    IL_0004: ldarg.s 4
    IL_0006: call bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_000b: brtrue.s IL_000f
    IL_000d: ldc.i4.0
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld float Hp::hp  /*0x04000A2F*/
    IL_0015: ldc.r4 0f
    IL_001a: bgt.un.s IL_002e
    IL_001c: ldarg.0
    IL_001d: ldfld UnityEvent<TaggedObject> HpThief::OnKill  /*0x040006DF*/
    IL_0022: dup
    IL_0023: brtrue.s IL_0028
    IL_0025: pop
    IL_0026: br.s IL_002e
    IL_0028: ldarg.2
    IL_0029: call void UnityEngine.Events.UnityEvent<TaggedObject>::Invoke(!0)  /*0x0A000231*/
    IL_002e: ldc.i4.1
    IL_002f: ret

  .method HpThief::.ctor()  // token 0x0600054B rva 0x1472f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void Hp::.ctor()  /*0x06000837*/
    IL_0006: ret

