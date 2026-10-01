// ===== EternalTrialEnemySet  (token 0x02000142) =====
  .method EternalTrialEnemySet::ListAllFlying()  // token 0x060006D4 rva 0x1e4cc attrs Public, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    .locals ([0] List<EternalTrialEnemy>, [1] List.Enumerator<EternalTrialEnemy>, [2] EternalTrialEnemy)
    IL_0000: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0011: stloc.1
    IL_0012: br.s IL_002b
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: callvirt bool EternalTrialEnemy::get_flying()  /*0x060006E5*/
    IL_0022: brfalse.s IL_002b
    IL_0024: ldloc.0
    IL_0025: ldloc.2
    IL_0026: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_002b: ldloca.s 1
    IL_002d: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0032: brtrue.s IL_0014
    IL_0034: leave.s IL_0044
    IL_0036: ldloca.s 1
    IL_0038: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_003e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0043: endfinally
    IL_0044: ldloc.0
    IL_0045: ret
    .try IL_0012-IL_0036 finally handler IL_0036-IL_0044

  .method EternalTrialEnemySet::ListAllGroundSmall()  // token 0x060006D5 rva 0x1e530 attrs Public, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    .locals ([0] List<EternalTrialEnemy>, [1] List.Enumerator<EternalTrialEnemy>, [2] EternalTrialEnemy)
    IL_0000: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0011: stloc.1
    IL_0012: br.s IL_002b
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: callvirt bool EternalTrialEnemy::get_smallGround()  /*0x060006E6*/
    IL_0022: brfalse.s IL_002b
    IL_0024: ldloc.0
    IL_0025: ldloc.2
    IL_0026: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_002b: ldloca.s 1
    IL_002d: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0032: brtrue.s IL_0014
    IL_0034: leave.s IL_0044
    IL_0036: ldloca.s 1
    IL_0038: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_003e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0043: endfinally
    IL_0044: ldloc.0
    IL_0045: ret
    .try IL_0012-IL_0036 finally handler IL_0036-IL_0044

  .method EternalTrialEnemySet::ListAllGroundBig()  // token 0x060006D6 rva 0x1e594 attrs Public, HideBySig
    // code size 70 (0x46), max stack 2, init locals
    .locals ([0] List<EternalTrialEnemy>, [1] List.Enumerator<EternalTrialEnemy>, [2] EternalTrialEnemy)
    IL_0000: newobj void System.Collections.Generic.List<EternalTrialEnemy>::.ctor()  /*0x0A0002CC*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<EternalTrialEnemy> EternalTrialEnemySet::enemies  /*0x04000836*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<EternalTrialEnemy>::GetEnumerator()  /*0x0A0002CD*/
    IL_0011: stloc.1
    IL_0012: br.s IL_002b
    IL_0014: ldloca.s 1
    IL_0016: call !0 System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::get_Current()  /*0x0A0002CE*/
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: callvirt bool EternalTrialEnemy::get_bigGround()  /*0x060006E7*/
    IL_0022: brfalse.s IL_002b
    IL_0024: ldloc.0
    IL_0025: ldloc.2
    IL_0026: callvirt void System.Collections.Generic.List<EternalTrialEnemy>::Add(!0)  /*0x0A0002CF*/
    IL_002b: ldloca.s 1
    IL_002d: call bool System.Collections.Generic.List.Enumerator<EternalTrialEnemy>::MoveNext()  /*0x0A0002D0*/
    IL_0032: brtrue.s IL_0014
    IL_0034: leave.s IL_0044
    IL_0036: ldloca.s 1
    IL_0038: constrained. System.Collections.Generic.List.Enumerator<EternalTrialEnemy>  /*0x1B00007F*/
    IL_003e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0043: endfinally
    IL_0044: ldloc.0
    IL_0045: ret
    .try IL_0012-IL_0036 finally handler IL_0036-IL_0044

  .method EternalTrialEnemySet::.ctor()  // token 0x060006D7 rva 0x26e3 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.ScriptableObject::.ctor()  /*0x0A00002B*/
    IL_0006: ret

