// ===== WaveInfo  (token 0x02000139) =====
  .method WaveInfo::ToDebugString()  // token 0x060006AB rva 0x1d78c attrs Public, HideBySig
    // code size 146 (0x92), max stack 4, init locals
    .locals ([0] string, [1] List.Enumerator<WaveEnemyInfo>, [2] WaveEnemyInfo)
    IL_0000: ldstr ""
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldstr "Wave {0}/{1}:\n\n"
    IL_000c: ldarg.0
    IL_000d: ldfld int WaveInfo::waveNumber  /*0x040007FB*/
    IL_0012: box System.Int32  /*0x01000026*/
    IL_0017: ldarg.0
    IL_0018: ldfld int WaveInfo::outOfWaves  /*0x040007FC*/
    IL_001d: box System.Int32  /*0x01000026*/
    IL_0022: call string System.String::Format(string,object,object)  /*0x0A0002B7*/
    IL_0027: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_002c: stloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_0033: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveEnemyInfo>::GetEnumerator()  /*0x0A0002A4*/
    IL_0038: stloc.1
    IL_0039: br.s IL_0077
    IL_003b: ldloca.s 1
    IL_003d: call !0 System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::get_Current()  /*0x0A0002A5*/
    IL_0042: stloc.2
    IL_0043: ldloc.0
    IL_0044: ldstr "{0}x {1}:\n"
    IL_0049: ldloc.2
    IL_004a: ldfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_004f: box System.Int32  /*0x01000026*/
    IL_0054: ldloc.2
    IL_0055: ldfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_005a: call string System.String::Format(string,object,object)  /*0x0A0002B7*/
    IL_005f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0064: stloc.0
    IL_0065: ldloc.0
    IL_0066: ldloc.2
    IL_0067: ldfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_006c: ldstr "\n\n"
    IL_0071: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0076: stloc.0
    IL_0077: ldloca.s 1
    IL_0079: call bool System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::MoveNext()  /*0x0A0002A7*/
    IL_007e: brtrue.s IL_003b
    IL_0080: leave.s IL_0090
    IL_0082: ldloca.s 1
    IL_0084: constrained. System.Collections.Generic.List.Enumerator<WaveEnemyInfo>  /*0x1B000078*/
    IL_008a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_008f: endfinally
    IL_0090: ldloc.0
    IL_0091: ret
    .try IL_0039-IL_0082 finally handler IL_0082-IL_0090

  .method WaveInfo::DistributeEvenly(int,int)  // token 0x060006AC rva 0x1d83c attrs Private, HideBySig
    // code size 42 (0x2a), max stack 5, init locals
    .locals ([0] int[], [1] int, [2] int, [3] int)
    IL_0000: ldarg.2
    IL_0001: newarr System.Int32  /*0x01000026*/
    IL_0006: stloc.0
    IL_0007: ldarg.1
    IL_0008: ldarg.2
    IL_0009: div
    IL_000a: stloc.1
    IL_000b: ldarg.1
    IL_000c: ldarg.2
    IL_000d: rem
    IL_000e: stloc.2
    IL_000f: ldc.i4.0
    IL_0010: stloc.3
    IL_0011: br.s IL_0024
    IL_0013: ldloc.0
    IL_0014: ldloc.3
    IL_0015: ldloc.1
    IL_0016: ldloc.3
    IL_0017: ldloc.2
    IL_0018: blt.s IL_001d
    IL_001a: ldc.i4.0
    IL_001b: br.s IL_001e
    IL_001d: ldc.i4.1
    IL_001e: add
    IL_001f: stelem.i4
    IL_0020: ldloc.3
    IL_0021: ldc.i4.1
    IL_0022: add
    IL_0023: stloc.3
    IL_0024: ldloc.3
    IL_0025: ldarg.2
    IL_0026: blt.s IL_0013
    IL_0028: ldloc.0
    IL_0029: ret

  .method WaveInfo::.ctor()  // token 0x060006AD rva 0x1d872 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<WaveEnemyInfo>::.ctor()  /*0x0A0002B8*/
    IL_0006: stfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float WaveInfo::difficultyMulti  /*0x040007FF*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ret

