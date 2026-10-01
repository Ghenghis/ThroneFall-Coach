// ===== IronCastleEnemySpawning  (token 0x020001A0) =====
  .method IronCastleEnemySpawning::Start()  // token 0x0600086E rva 0x28b28 attrs Private, HideBySig
    // code size 53 (0x35), max stack 2, init locals
    .locals ([0] List.Enumerator<Wave>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Wave> IronCastleEnemySpawning::waves  /*0x04000A6F*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<Wave>::GetEnumerator()  /*0x0A000295*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<Wave>::get_Current()  /*0x0A000296*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void Wave::Reset(bool)  /*0x0600069C*/
    IL_001b: ldloca.s 0
    IL_001d: call bool System.Collections.Generic.List.Enumerator<Wave>::MoveNext()  /*0x0A000297*/
    IL_0022: brtrue.s IL_000e
    IL_0024: leave.s IL_0034
    IL_0026: ldloca.s 0
    IL_0028: constrained. System.Collections.Generic.List.Enumerator<Wave>  /*0x1B000074*/
    IL_002e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0033: endfinally
    IL_0034: ret
    .try IL_000c-IL_0026 finally handler IL_0026-IL_0034

  .method IronCastleEnemySpawning::Update()  // token 0x0600086F rva 0x28b7c attrs Private, HideBySig
    // code size 106 (0x6a), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp IronCastleEnemySpawning::hp  /*0x04000A70*/
    IL_0006: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_000b: ldc.r4 0.75f
    IL_0010: bge.un.s IL_0023
    IL_0012: ldarg.0
    IL_0013: ldfld List<Wave> IronCastleEnemySpawning::waves  /*0x04000A6F*/
    IL_0018: ldc.i4.0
    IL_0019: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_001e: callvirt void Wave::Update()  /*0x0600069D*/
    IL_0023: ldarg.0
    IL_0024: ldfld Hp IronCastleEnemySpawning::hp  /*0x04000A70*/
    IL_0029: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_002e: ldc.r4 0.5f
    IL_0033: bge.un.s IL_0046
    IL_0035: ldarg.0
    IL_0036: ldfld List<Wave> IronCastleEnemySpawning::waves  /*0x04000A6F*/
    IL_003b: ldc.i4.1
    IL_003c: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0041: callvirt void Wave::Update()  /*0x0600069D*/
    IL_0046: ldarg.0
    IL_0047: ldfld Hp IronCastleEnemySpawning::hp  /*0x04000A70*/
    IL_004c: callvirt float Hp::get_HpPercentage()  /*0x06000813*/
    IL_0051: ldc.r4 0.25f
    IL_0056: bge.un.s IL_0069
    IL_0058: ldarg.0
    IL_0059: ldfld List<Wave> IronCastleEnemySpawning::waves  /*0x04000A6F*/
    IL_005e: ldc.i4.2
    IL_005f: callvirt !0 System.Collections.Generic.List<Wave>::get_Item(int)  /*0x0A000299*/
    IL_0064: callvirt void Wave::Update()  /*0x0600069D*/
    IL_0069: ret

  .method IronCastleEnemySpawning::.ctor()  // token 0x06000870 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

